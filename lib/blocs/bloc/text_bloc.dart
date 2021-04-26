import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:imgprc/models/text_paint.dart';
import 'package:meta/meta.dart';
part 'text_event.dart';
part 'text_state.dart';

class TextBloc extends Bloc<TextEvent, TextState> {
  TextBloc() : super(TextState.empty());

  @override
  Stream<TextState> mapEventToState(
    TextEvent event,
  ) async* {
    if (event is AddText) {
      var list = state.listText.toList();
      list.add(event.textModel);
      yield state.copyWith(listText: list);
    }
    if (event is DeleteText) {
      var list = state.listText.toList();
      list.remove(event.textModel);
      yield state.copyWith(listText: list);
    }
    if (event is UpdateText) {
      var list = state.listText.toList();
      list[event.index] = event.textModel;
      yield state.copyWith(listText: list);
    }
  }
}
