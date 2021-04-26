part of 'brush_bloc.dart';

abstract class BrushEvent {}

class Draw extends BrushEvent {
  final DrawingPoints drawingPoints;

  Draw({@required this.drawingPoints});
}

class UpdateBrush extends Draw {
  final double size;
  final Color color;

  UpdateBrush({this.size, this.color});
}
