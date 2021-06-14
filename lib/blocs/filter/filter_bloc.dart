import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:imgprc/models/drawing_point.dart';
import 'package:imgprc/models/emoij_model.dart';
import 'package:imgprc/models/text_paint.dart';
import 'package:imgprc/utils/enums.dart';
import 'package:imgprc/utils/progress_image.dart';
import 'package:meta/meta.dart';
import 'dart:io';
import 'dart:ui' as ui;
part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterState.empty());
  ProgressImage progressImage = ProgressImage();
  File input = File("");
  @override
  Stream<FilterState> mapEventToState(
    FilterEvent event,
  ) async* {
    if (event is ResetFilter) {
      yield FilterState.empty();
    }
    if (event is SetFilter) {
      print(event.filterType);
      switch (event.filterType) {
        case FilterType.Normal:
          yield state.copyWith(
            filterLoading: true,
            currentFilter: event.filterType,
          );
          var result = await input.readAsBytes();
          yield state.copyWith(
              currentFilter: event.filterType,
              imageEncode: result,
              filterLoading: false);
          return;
        case FilterType.Grey:
          try {
            yield state.copyWith(
              filterLoading: true,
              currentFilter: event.filterType,
            );
            var result = await Future.wait([
              progressImage.convertToGreyImage(input),
            ]);
            // final output = await ;
            yield state.copyWith(
                imageEncode: result.first,
                currentFilter: event.filterType,
                filterLoading: false);
          } catch (e) {
            print(e);
            yield state.copyWith(
              currentFilter: event.filterType,
              filterError: e.toString(),
            );
          }
          break;
        case FilterType.Negative:
          try {
            yield state.copyWith(
              filterLoading: true,
            );

            final output = await progressImage.convertToNavigateImage(input);
            yield state.copyWith(
              imageEncode: output,
              filterLoading: false,
              currentFilter: event.filterType,
            );
          } catch (e) {
            print(e);
            yield state.copyWith(
              currentFilter: event.filterType,
              filterError: e.toString(),
            );
          }
          break;
        case FilterType.RedGreenBlue:
          try {
            yield state.copyWith(
              filterLoading: true,
            );

            final output = await progressImage.convertImageToRGB(input);
            yield state.copyWith(
              imageEncode: output,
              filterLoading: false,
              currentFilter: event.filterType,
            );
          } catch (e) {
            print(e);
            yield state.copyWith(
              currentFilter: event.filterType,
              filterError: e.toString(),
            );
          }
          break;
        case FilterType.Sepia:
          try {
            yield state.copyWith(
              filterLoading: true,
            );

            final output = await progressImage.convertImageSepia(input);
            yield state.copyWith(
              imageEncode: output,
              filterLoading: false,
              currentFilter: event.filterType,
            );
          } catch (e) {
            print(e);
            yield state.copyWith(
              currentFilter: event.filterType,
              filterError: e.toString(),
            );
          }
          break;
        case FilterType.Mirror:
          try {
            yield state.copyWith(
              filterLoading: true,
            );

            final output = await progressImage.convertImageMiror(input);
            yield state.copyWith(
              imageEncode: output,
              filterLoading: false,
              currentFilter: event.filterType,
            );
          } catch (e) {
            print(e);
            yield state.copyWith(
              currentFilter: event.filterType,
              filterError: e.toString(),
            );
          }
          break;
          break;
        case FilterType.Laplace:
          yield state.copyWith(
            filterLoading: true,
          );

          final output = await progressImage.laplace(input);
          yield state.copyWith(
            imageEncode: output,
            filterLoading: false,
            currentFilter: event.filterType,
          );
          break;
        case FilterType.GaussianBlue:
          yield state.copyWith(
            filterLoading: true,
          );

          final output = await progressImage.gaussianBlur(input);
          yield state.copyWith(
            imageEncode: output,
            filterLoading: false,
            currentFilter: event.filterType,
          );
          break;
        case FilterType.MedianBlur:
          yield state.copyWith(
            filterLoading: true,
          );

          final output = await progressImage.medianBlur(input);
          yield state.copyWith(
            imageEncode: output,
            filterLoading: false,
            currentFilter: event.filterType,
          );
          break;
      }
    }
    if (event is ExportImage) {
      yield state.copyWith(isSaving: true);
      final ui.Image image = await toImage(
          event.points,
          event.strokeWidth,
          event.image,
          event.screenWidth,
          event.listText,
          event.emoijs,
          event.context);
      final ByteData bytes =
          await image.toByteData(format: ui.ImageByteFormat.png);
      await ImageGallerySaver.saveImage(bytes.buffer.asUint8List(),
          quality: 100, name: "hello");
      Fluttertoast.showToast(msg: 'Save successfully!');
      yield state.copyWith(isSaving: false);
    }
  }

  Future<ui.Image> toImage(
    List<DrawingPoints> drawingPoints,
    double strokeWidth,
    ui.Image image,
    double screenWidth,
    List<TextModel> listText,
    List<EmoijModel> emoijs,
    BuildContext context,
  ) async {
    List<Offset> offsetPoints = List();
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final ui.Canvas canvas = ui.Canvas(recorder);

    final imageSize = ui.Size(image.width.toDouble(), image.height.toDouble());
    print(imageSize.toString());
    final src = Offset.zero & imageSize;
    final dst = Offset.zero & imageSize;

    canvas.drawImageRect(image, src, dst, Paint());
    var points = drawingPoints.toList();
    points = points.map((e) {
      if (e != null) {
        var scaleX = e.offset.dx / screenWidth;
        var x = imageSize.width * scaleX;
        var scaleY = e.offset.dy / screenWidth;
        var y = imageSize.width * scaleY;
        var newPaint = e.paint;
        // newPaint.strokeWidth = newPaint.strokeWidth * 3;
        DrawingPoints drawingPoint =
            DrawingPoints(offset: Offset(x, y), paint: newPaint);
        return drawingPoint;
      }
    }).toList();

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(
            points[i].offset, points[i + 1].offset, points[i].paint);
      } else if (points[i] != null && points[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(points[i].offset);
        offsetPoints
            .add(Offset(points[i].offset.dx + 0.1, points[i].offset.dy + 0.1));
        canvas.drawPoints(ui.PointMode.points, offsetPoints, points[i].paint);
      }
    }
    for (int i = 0; i < listText.length; i++) {
      var text = listText[i];
      text = text.copyWith(
          textStyle: TextStyle(
              fontSize: text.textStyle.fontSize * 2.25,
              color: text.textStyle.color));
      var textPainter = text.toTextPainter();

      var scaleX = listText[i].offset.dx / screenWidth;
      var x = imageSize.width * scaleX;
      var scaleY = listText[i].offset.dy / screenWidth;
      var y = imageSize.width * scaleY;
      textPainter.layout(
        minWidth: 0,
        maxWidth: imageSize.width,
      );

      textPainter.paint(canvas, Offset(x, y));
    }
    for (int i = 0; i < emoijs.length; i++) {
      var emoij = emoijs[i];
      String svgString =
          await DefaultAssetBundle.of(context).loadString(emoij.path);
      DrawableRoot drawableRoot = await svg.fromSvgString(svgString, null);
      // drawableRoot.scaleCanvasToViewBox(canvas, Size.fromHeight(20));
      var scaleX = emoijs[i].offset.dx / screenWidth;
      var x = imageSize.width * scaleX;
      var scaleY = emoijs[i].offset.dy / screenWidth;
      var y = imageSize.width * scaleY;
      // drawableRoot.draw(canvas, Rect.fromPoints(Offset.zero, Offset(x, y)));
      // ui.Picture picture = drawableRoot.to(
      //   size: Size(emoij.size, emoij.size),
      // );
      var image = await drawableRoot
          .toPicture()
          .toImage(emoij.size.toInt(), emoij.size.toInt());

      canvas.drawImage(image, Offset(x, y), Paint());
    }

    final ui.Picture picture = recorder.endRecording();

    return picture.toImage(imageSize.width.toInt(), imageSize.height.toInt());
  }
}
