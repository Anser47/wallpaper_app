part of 'photo_bloc.dart';

@immutable
abstract class PhotoEvent {}

class PhotoInitailFetchEvent extends PhotoEvent {}

class PhotoFetchMoreEvent extends PhotoEvent {}
