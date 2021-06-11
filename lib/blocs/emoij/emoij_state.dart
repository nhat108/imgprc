part of 'emoij_bloc.dart';

class EmoijState extends Equatable {
  final List<EmoijModel> emoijs;

  EmoijState({this.emoijs});
  factory EmoijState.empty() {
    return EmoijState(
      emoijs: [],
    );
  }
  EmoijState copyWith({
    List<EmoijModel> emoijs,
  }) {
    return EmoijState(
      emoijs: emoijs,
    );
  }

  @override
  List<Object> get props => [emoijs];
}
