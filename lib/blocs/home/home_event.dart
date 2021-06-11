part of 'home_bloc.dart';

abstract class HomeEvent {}

class GetAlbum extends HomeEvent {
  final bool getDefaultImage;
  final BuildContext context;
  GetAlbum({this.getDefaultImage = true, @required this.context});
}

class SelectMainImage extends HomeEvent {
  final Medium medium;

  SelectMainImage(this.medium);
}
