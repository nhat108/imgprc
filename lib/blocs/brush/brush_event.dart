part of 'brush_bloc.dart';

abstract class BrushEvent {}

class Draw extends BrushEvent {
  final DrawingPoints drawingPoints;

  Draw({@required this.drawingPoints});
}

class UpdateBrush extends BrushEvent {
  final double size;
  final Color color;

  UpdateBrush({this.size, this.color});
}

class Undo extends BrushEvent {}

class Redo extends BrushEvent {}
