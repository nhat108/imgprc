part of 'text_bloc.dart';

abstract class TextEvent {}

class AddText extends TextEvent {
  final TextModel textModel;

  AddText({@required this.textModel});
}

class DeleteText extends TextEvent {
  final TextModel textModel;

  DeleteText({@required this.textModel});
}

class UpdateText extends TextEvent {
  final TextModel textModel;
  final int index;
  UpdateText({@required this.textModel, @required this.index});
}
