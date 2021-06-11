part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool getAlbumLoading;
  final List<MediaPage> albums;
  final String getAlbumError;

  final List<String> listEmoijPath;
  final String imageSelected;
  HomeState({
    this.imageSelected,
    this.getAlbumLoading,
    this.albums,
    this.getAlbumError,
    this.listEmoijPath,
  });

  factory HomeState.empty() {
    return HomeState(
        getAlbumError: '',
        albums: [],
        getAlbumLoading: false,
        imageSelected: '',
        listEmoijPath: []);
  }
  HomeState copyWith({
    bool getAlbumLoading,
    List<MediaPage> albums,
    String getAlbumError,
    String imageSelected,
    List<String> listEmoijPath,
  }) {
    return HomeState(
      listEmoijPath: listEmoijPath ?? this.listEmoijPath,
      imageSelected: imageSelected ?? this.imageSelected,
      getAlbumError: getAlbumError ?? this.getAlbumError,
      albums: albums ?? this.albums,
      getAlbumLoading: getAlbumLoading ?? this.getAlbumLoading,
    );
  }

  @override
  List<Object> get props => [
        this.listEmoijPath,
        this.getAlbumLoading,
        this.albums,
        this.getAlbumError,
        this.imageSelected,
      ];
}
