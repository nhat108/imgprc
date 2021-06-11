import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class EmoijModel extends Equatable {
  final String path;
  final Offset offset;
  final double size;

  EmoijModel({this.path, this.offset, this.size});

  @override
  List<Object> get props => [this.path, this.offset, this.size];
  EmoijModel copyWith({
    final String path,
    final Offset offset,
    final double size,
  }) {
    return EmoijModel(
      offset: offset ?? this.offset,
      path: path ?? this.path,
      size: size ?? this.size,
    );
  }
}
