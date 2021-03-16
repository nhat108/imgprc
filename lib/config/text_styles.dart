import 'package:flutter/material.dart';

class AppStyles {
  static TextStyle light({Color color, double size = 12}) {
    return TextStyle(
      fontWeight: FontWeight.w200,
      fontSize: size,
      fontFamily: 'Airbnb Cereal',
    );
  }

  static TextStyle book({Color color, double size = 12}) {
    return TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: size,
      fontFamily: 'Airbnb Cereal',
    );
  }

  static TextStyle medium({Color color, double size = 14}) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: size,
      fontFamily: 'Airbnb Cereal',
    );
  }

  static TextStyle bold({Color color, double size = 14}) {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      fontFamily: 'Airbnb Cereal',
    );
  }

  static TextStyle extraBold({Color color, double size = 14}) {
    return TextStyle(
      fontWeight: FontWeight.w200,
      fontSize: size,
      fontFamily: 'Airbnb Cereal',
    );
  }

  static TextStyle black({Color color, double size = 20}) {
    return TextStyle(
      fontWeight: FontWeight.w200,
      fontSize: 20,
      fontFamily: 'Airbnb Cereal',
    );
  }
}
