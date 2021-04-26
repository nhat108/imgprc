part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool getAlbumLoading;
  final List<MediaPage> albums;
  final String getAlbumError;

  final String imageSelected;
  HomeState(
      {this.imageSelected,
      this.getAlbumLoading,
      this.albums,
      this.getAlbumError});

  factory HomeState.empty() {
    return HomeState(
      getAlbumError: '',
      albums: [],
      getAlbumLoading: false,
      imageSelected: '',
    );
  }
  HomeState copyWith({
    bool getAlbumLoading,
    List<MediaPage> albums,
    String getAlbumError,
    String imageSelected,
  }) {
    return HomeState(
      imageSelected: imageSelected ?? this.imageSelected,
      getAlbumError: getAlbumError ?? this.getAlbumError,
      albums: albums ?? this.albums,
      getAlbumLoading: getAlbumLoading ?? this.getAlbumLoading,
    );
  }

  @override
  List<Object> get props => [
        this.getAlbumLoading,
        this.albums,
        this.getAlbumError,
        this.imageSelected,
      ];
}
