import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper_app/models/photo_model.dart';
import 'package:wallpaper_app/repo/repo.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  int _currentPage = 1;
  bool _isFetching = false;
  bool _hasReachedMax = false;
  final int _perPage = 10;
  List<UnsplashPhoto> _photoList = [];
  final PhotoRepo photoRepo;

  PhotoBloc({required this.photoRepo}) : super(PhotoInitial()) {
    on<PhotoInitailFetchEvent>(_photoInitailFetchEvent);
    on<PhotoFetchMoreEvent>(_photoFetchMoreEvent);
  }

  bool get isFetching => _isFetching;
  bool get hasReachedMax => _hasReachedMax;

  Future<void> _photoInitailFetchEvent(
      PhotoInitailFetchEvent event, Emitter<PhotoState> emit) async {
    emit(PhotoFetchLoadingState());

    try {
      _currentPage = 1;
      _hasReachedMax = false;
      _photoList =
          await photoRepo.fetchPhotos(page: _currentPage, perPage: _perPage);

      if (_photoList.length < _perPage) {
        _hasReachedMax = true;
      }

      emit(PhotoFetchingSucessfulstate(
          post: _photoList, hasReachedMax: _hasReachedMax));
    } catch (e) {
      emit(PhotoFetchErrorState());
    }
  }

  Future<void> _photoFetchMoreEvent(
      PhotoFetchMoreEvent event, Emitter<PhotoState> emit) async {
    if (_isFetching || _hasReachedMax) return;

    _isFetching = true;

    try {
      _currentPage++;
      final newPhotos =
          await photoRepo.fetchPhotos(page: _currentPage, perPage: _perPage);

      if (newPhotos.isEmpty || newPhotos.length < _perPage) {
        _hasReachedMax = true;
      }

      _photoList.addAll(newPhotos);
      emit(PhotoFetchingSucessfulstate(
          post: _photoList, hasReachedMax: _hasReachedMax));
    } catch (e) {
      emit(PhotoFetchErrorState());
    } finally {
      _isFetching = false;
    }
  }
}
