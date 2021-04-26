part of 'brush_bloc.dart';

class BrushState extends Equatable {
  final Color selectedColor;
  final List<DrawingPoints> points;
  final double strokeWidth;

  BrushState({this.selectedColor, this.points, this.strokeWidth});

  @override
  List<Object> get props => [this.selectedColor, this.points, this.strokeWidth];
  factory BrushState.empty() {
    return BrushState(selectedColor: Colors.white, points: [], strokeWidth: 1);
  }
  BrushState copyWith({
    final Color selectedColor,
    final List<DrawingPoints> points,
    final double strokeWidth,
  }) {
    return BrushState(
      selectedColor: selectedColor ?? this.selectedColor,
      points: points ?? this.points,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    );
  }
}
