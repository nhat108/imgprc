part of 'emoij_bloc.dart';

abstract class EmoijEvent {}

class AddEmoij extends EmoijEvent {
  final EmoijModel emoijModel;

  AddEmoij(this.emoijModel);
}

class DeleteEmoij extends EmoijEvent {
  final int index;

  DeleteEmoij(this.index);
}

class UpdateEmoij extends EmoijEvent {
  final Offset offset;
  final int index;

  UpdateEmoij(this.offset, this.index);
}
