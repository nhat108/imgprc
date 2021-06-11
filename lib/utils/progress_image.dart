import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
// import 'package:flutter/foundation.dart' as found;
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;

class ProgressImage {
  convertFileToImage(File file, Function(Image) callback,
      {double width, double height}) {
    ui.decodeImageFromList(file.readAsBytesSync(), callback);
  }

  convertUnit8ListToImage(Uint8List list, Function(Image) callback,
      {double width, double height}) {
    ui.decodeImageFromList(list, callback);
  }

  Future<List<int>> convertToGreyImage(File file) async {
    try {
      var image = img.decodeImage(File(file.path).readAsBytesSync());
      // var imageRezied = img.copyResize(image,
      //     width: (image.width * 0.5).toInt(),
      //     height: (image.height * 0.5).toInt());
      var imageRezied = image;
      var width = imageRezied.width;
      var height = imageRezied.height;
      for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
          Color c = Color(image.getPixelSafe(j, i));
          int red = (c.red * 0.299).toInt();
          int green = (c.green * 0.587).toInt();
          int blue = (c.blue * 0.114).toInt();

          var sum = red + green + blue;

          Color newColor = new Color.fromARGB(0, sum, sum, sum);

          imageRezied.setPixelRgba(
              j, i, newColor.red, newColor.green, newColor.blue);
        }
      }

      return img.encodePng(imageRezied);
      // return File(file.path)..copy('newPath') ..writeAsBytesSync(img.encodePng(imageRezied));
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<int>> convertToNavigateImage(File file) async {
    try {
      var image = img.decodeImage(file.readAsBytesSync());

      var imageRezied = image;

      var width = imageRezied.width;
      var height = imageRezied.height;
      for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
          Color c = Color(image.getPixelSafe(j, i));

          int red = 255 - c.red;
          int green = 255 - c.green;
          int blue = 255 - c.blue;

          Color newColor = new Color.fromARGB(0, red, green, blue);

          imageRezied.setPixelRgba(
              j, i, newColor.red, newColor.green, newColor.blue);
        }
      }
      return img.encodePng(imageRezied);
      // return File(file.path)..writeAsBytesSync(img.encodePng(imageRezied));
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<int>> convertImageToRGB(File file) async {
    try {
      var image = img.decodeImage(file.readAsBytesSync());
      // var imageRezied = img.copyResize(image,
      //     width: (image.width * 0.5).toInt(),
      //     height: (image.height * 0.5).toInt());
      var imageRezied = image;

      var width = imageRezied.width;
      var height = imageRezied.height;
      for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
          Color c = Color(image.getPixelSafe(j, i));

          int red = c.red;

          Color newColor = new Color.fromARGB(255, red, 0, 0);

          imageRezied.setPixelRgba(
              j, i, newColor.red, newColor.green, newColor.blue);
        }
      }
      return img.encodePng(imageRezied);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<int>> convertImageSepia(File file) async {
    try {
      var image = img.decodeImage(file.readAsBytesSync());

      var imageRezied = image;

      var width = imageRezied.width;
      var height = imageRezied.height;
      for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
          Color c = Color(image.getPixelSafe(j, i));
          int r = c.red;
          int g = c.green;
          int b = c.blue;
          int newR = (0.393 * r + 0.769 * g + 0.189 * b).toInt();
          int newG = (0.349 * r + 0.686 * g + 0.168 * b).toInt();
          int newB = (0.272 * r + 0.534 * g + 0.131 * b).toInt();
          if (newR > 255) {
            newR = 255;
          }
          if (newG > 255) {
            newG = 255;
          }
          if (newB > 255) {
            newB = 255;
          }
          imageRezied.setPixelRgba(j, i, newR, newG, newB);
        }
      }
      return img.encodePng(imageRezied);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<int>> convertImageMiror(File file) async {
    try {
      var image = img.decodeImage(file.readAsBytesSync());

      var imageRezied = image;

      var width = imageRezied.width;
      var height = imageRezied.height;
      for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
          Color c = Color(image.getPixelSafe(j, i));
          int r = c.red;
          int g = c.green;
          int b = c.blue;

          imageRezied.setPixelRgba((width - 1) - j, i, r, g, b);
        }
      }
      return img.encodePng(imageRezied);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  int hexOfRGBA(int r, int g, int b, {double opacity = 1}) {
    r = (r < 0) ? -r : r;
    g = (g < 0) ? -g : g;
    b = (b < 0) ? -b : b;
    opacity = (opacity < 0) ? -opacity : opacity;
    opacity = (opacity > 1) ? 255 : opacity * 255;
    r = (r > 255) ? 255 : r;
    g = (g > 255) ? 255 : g;
    b = (b > 255) ? 255 : b;
    int a = opacity.toInt();
    return int.parse(
        '0x${a.toRadixString(16)}${r.toRadixString(16)}${g.toRadixString(16)}${b.toRadixString(16)}');
  }
}
