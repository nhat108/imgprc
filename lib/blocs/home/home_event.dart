part of 'home_bloc.dart';

abstract class HomeEvent {}

class GetAlbum extends HomeEvent {
  final bool getDefaultImage;

  GetAlbum({this.getDefaultImage = true});
}

class SelectMainImage extends HomeEvent {
  final Medium medium;

  SelectMainImage(this.medium);
}
