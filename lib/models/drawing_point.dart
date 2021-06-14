import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DrawingPoints extends Equatable {
  final Paint paint;
  final Offset offset;
  DrawingPoints({this.offset, this.paint});

  @override
  List<Object> get props => [this.offset, this.paint];
  DrawingPoints copyWith({Offset offset, double strokeWidth}) {
    var newPaint = paint;
    // if (strokeWidth != null) {
    //   newPaint.strokeWidth = newPaint.strokeWidth * 3;
    // }
    return DrawingPoints(paint: newPaint, offset: offset ?? this.offset);
  }
}

class DrawingPainter extends CustomPainter {
  DrawingPainter({this.pointsList});
  List<DrawingPoints> pointsList;
  List<Offset> offsetPoints = List();
  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        canvas.drawLine(pointsList[i].offset, pointsList[i + 1].offset,
            pointsList[i].paint);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(pointsList[i].offset);
        offsetPoints.add(Offset(
            pointsList[i].offset.dx + 0.1, pointsList[i].offset.dy + 0.1));
        canvas.drawPoints(PointMode.points, offsetPoints, pointsList[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) =>
      oldDelegate.pointsList != pointsList;
}
