import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:imgprc/models/drawing_point.dart';

part 'brush_event.dart';
part 'brush_state.dart';

class BrushBloc extends Bloc<BrushEvent, BrushState> {
  BrushBloc() : super(BrushState.empty());
  List<DrawingPoints> listPointsDeleted = [];
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
    if (event is Undo) {
      var list = state.points.toList();
      if (list.isEmpty) {
        return;
      }
      var index =
          list.reversed.toList().indexWhere((element) => element == null, 2);

      listPointsDeleted.addAll(list.getRange(index, list.length - 1));
      list.removeRange(index, list.length - 1);
      yield state.copyWith(points: list);
    }
    if (event is Redo) {
      var list = state.points.toList();
      var index = listPointsDeleted.indexOf(null, 2);
      list.addAll(listPointsDeleted.getRange(0, index));
      listPointsDeleted.removeRange(0, index);
      yield state.copyWith(points: list);
    }
  }
}
