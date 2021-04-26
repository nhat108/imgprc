import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:imgprc/models/drawing_point.dart';

part 'brush_event.dart';
part 'brush_state.dart';

class BrushBloc extends Bloc<BrushEvent, BrushState> {
  BrushBloc() : super(BrushState.empty());

  @override
  Stream<BrushState> mapEventToState(
    BrushEvent event,
  ) async* {
    if (event is UpdateBrush) {
      yield state.copyWith(
        strokeWidth: event.size,
        selectedColor: event.color,
      );
    }
    if (event is Draw) {
      var list = state.points.toList();
      list.add(event.drawingPoints);
      if (event.drawingPoints == null) {
        print(list.length);
      }
      yield state.copyWith(points: list);
    }
  }
}
