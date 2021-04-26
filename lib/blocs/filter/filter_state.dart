part of 'filter_bloc.dart';

class FilterState extends Equatable {
  final bool filterLoading;
  final bool filterSuccess;
  final String filterError;

  final FilterType currentFilter;

  final File outputImage;
  final List<int> imageEncode;
  FilterState({
    this.filterLoading,
    this.filterSuccess,
    this.filterError,
    this.currentFilter,
    this.outputImage,
    this.imageEncode,
  });

  factory FilterState.empty() {
    return FilterState(
      filterError: '',
      filterLoading: false,
      outputImage: null,
      filterSuccess: false,
      currentFilter: FilterType.Normal,
      imageEncode: [],
    );
  }
  FilterState copyWith({
    bool filterLoading,
    bool filterSuccess,
    String filterError,
    FilterType currentFilter,
    File outputImage,
    List<int> imageEncode,
  }) {
    return FilterState(
      imageEncode: imageEncode ?? this.imageEncode,
      outputImage: outputImage,
      currentFilter: currentFilter ?? this.currentFilter,
      filterError: filterError ?? this.filterError,
      filterLoading: filterLoading ?? this.filterLoading,
      filterSuccess: filterSuccess ?? this.filterSuccess,
    );
  }

  @override
  List<Object> get props => [
        this.imageEncode,
        this.filterLoading,
        this.filterSuccess,
        this.filterError,
        this.outputImage,
        this.currentFilter,
      ];
}
