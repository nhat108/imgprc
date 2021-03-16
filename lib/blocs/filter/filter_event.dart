part of 'filter_bloc.dart';

@immutable
abstract class FilterEvent {}

class SetFilter extends FilterEvent {
  final FilterType filterType;
  final File file;
  SetFilter({@required this.filterType, this.file});
}

class ResetFilter extends FilterEvent {}
