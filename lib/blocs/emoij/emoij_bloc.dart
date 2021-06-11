import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:imgprc/models/emoij_model.dart';

part 'emoij_event.dart';
part 'emoij_state.dart';

class EmoijBloc extends Bloc<EmoijEvent, EmoijState> {
  EmoijBloc() : super(EmoijState.empty());

  @override
  Stream<EmoijState> mapEventToState(
    EmoijEvent event,
  ) async* {
    if (event is AddEmoij) {
      yield state.copyWith(emoijs: state.emoijs..add(event.emoijModel));
    }
    if (event is DeleteEmoij) {
      yield state.copyWith(
        emoijs: state.emoijs..removeAt(event.index),
      );
    }
    if (event is UpdateEmoij) {
      var emoijs = state.emoijs.toList();
      emoijs[event.index] = emoijs[event.index].copyWith(offset: event.offset);
      yield state.copyWith(emoijs: emoijs);
    }
  }
}
