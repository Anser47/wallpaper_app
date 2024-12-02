part of 'photo_bloc.dart';

@immutable
abstract class PhotoState {}

class PhotoInitial extends PhotoState {}

class PhotoFetchLoadingState extends PhotoState {}

class PhotoFetchingSucessfulstate extends PhotoState {
  final List<UnsplashPhoto> post;
  final bool hasReachedMax;

  PhotoFetchingSucessfulstate(
      {required this.post, required this.hasReachedMax});
}

class PhotoFetchErrorState extends PhotoState {}
