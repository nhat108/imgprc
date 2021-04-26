import 'package:flutter/material.dart';

class TextModel {
  final String text;
  final TextDirection textDirection;
  final TextStyle textStyle;
  final Offset offset;

  TextModel(
      {this.offset,
      this.text = '',
      this.textDirection = TextDirection.ltr,
      this.textStyle});
  TextPainter toTextPainter() {
    return TextPainter(
      text: TextSpan(
        text: text,
        style: textStyle,
      ),
      textDirection: textDirection,
    );
  }

  TextModel copyWith({
    String text,
    TextDirection textDirection,
    TextStyle textStyle,
    Offset offset,
  }) {
    return TextModel(
        text: text ?? this.text,
        textDirection: textDirection ?? this.textDirection,
        textStyle: textStyle ?? this.textStyle,
        offset: offset ?? this.textStyle);
  }
}
