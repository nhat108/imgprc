part of 'text_bloc.dart';

class TextState extends Equatable {
  final List<TextModel> listText;

  TextState({this.listText});

  @override
  List<Object> get props => [listText];
  factory TextState.empty() {
    return TextState(listText: []);
  }
  TextState copyWith({
    List<TextModel> listText,
  }) {
    return TextState(
      listText: listText ?? this.listText,
    );
  }
}
