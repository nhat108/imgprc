part of 'filter_bloc.dart';

@immutable
abstract class FilterEvent {}

class SetFilter extends FilterEvent {
  final FilterType filterType;
  final File file;
  SetFilter({@required this.filterType, this.file});
}

class ResetFilter extends FilterEvent {}

class ExportImage extends FilterEvent {
  final List<DrawingPoints> points;
  final dynamic image;
  final double strokeWidth;
  final double screenWidth;
  final List<TextModel> listText;
  final List<EmoijModel> emoijs;
  final BuildContext context;
  ExportImage({
    this.screenWidth,
    this.points,
    this.image,
    this.strokeWidth,
    this.listText,
    this.emoijs,
    this.context,
  });
}
