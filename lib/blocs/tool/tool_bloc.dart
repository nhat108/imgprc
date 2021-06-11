import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:imgprc/utils/enums.dart';

part 'tool_event.dart';
part 'tool_state.dart';

class ToolBloc extends Bloc<ToolEvent, ToolState> {
  ToolBloc() : super(ToolState.empty());

  @override
  Stream<ToolState> mapEventToState(
    ToolEvent event,
  ) async* {
    if (event is SelectTool) {
      yield state.copyWith(currentToolType: event.toolType);
    }
  }
}
