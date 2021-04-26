import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imgprc/blocs/bloc/text_bloc.dart';
import 'package:imgprc/blocs/brush/brush_bloc.dart';
import 'package:imgprc/blocs/filter/filter_bloc.dart';
import 'package:imgprc/blocs/home/home_bloc.dart';
import 'package:imgprc/config/app_assets.dart';
import 'package:imgprc/config/app_colors.dart';
import 'package:imgprc/config/text_styles.dart';
import 'package:imgprc/models/drawing_point.dart';
import 'package:imgprc/models/text_paint.dart';
import 'package:imgprc/utils/progress_image.dart';

import 'dart:ui' as ui;

import 'package:imgprc/widgets/edit_tool_widget.dart';
import 'package:imgprc/widgets/list_filters_widget.dart';

class EditPhotoNavigator extends StatefulWidget {
  @override
  _EditPhotoNavigatorState createState() => _EditPhotoNavigatorState();
}

class _EditPhotoNavigatorState extends State<EditPhotoNavigator> {
  StrokeCap strokeCap = (Platform.isAndroid) ? StrokeCap.butt : StrokeCap.round;
  GlobalKey _globalKey = GlobalKey(debugLabel: 'imagedisplay');
  GlobalKey _mainKey = GlobalKey(debugLabel: 'mainkey');
  var image;
  @override
  void initState() {
    BlocProvider.of<FilterBloc>(context).input =
        File(BlocProvider.of<HomeBloc>(context).state.imageSelected);
    super.initState();
    // _initImage();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _mainKey,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "NEXT",
                style: AppStyles.medium(size: 16),
              ),
            )
          ],
          title: SvgPicture.asset(
            AppAssets.magicIcon,
            color: Colors.white,
            width: 22,
          ),
          backgroundColor: AppColors.secondaryColor,
        ),
        backgroundColor: AppColors.primaryColor,
        bottomNavigationBar: TabBar(tabs: [
          Tab(
            text: 'FILTER',
          ),
          Tab(
            text: 'EDIT',
          )
        ]),
        body: Column(
          children: [
            ImageDisplay(
                // key: _globalKey,
                ),
            Expanded(
              flex: 4,
              child: TabBarView(
                children: [
                  ListFiltersWidget(),
                  EditToolWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageDisplay extends StatefulWidget {
  const ImageDisplay({
    GlobalKey key,
  }) : super(key: key);

  @override
  _ImageDisplayState createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  StrokeCap strokeCap = (Platform.isAndroid) ? StrokeCap.butt : StrokeCap.round;
  var image;
  @override
  void initState() {
    super.initState();
    _initImage();
  }

  _initImage() {
    ProgressImage().convertFileToImage(
        File(BlocProvider.of<HomeBloc>(context).state.imageSelected), (result) {
      setState(() {
        image = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () {
          print("tap");
        },
        onPanUpdate: (details) {
          RenderBox renderBox = context.findRenderObject();
          var strokeWidth =
              BlocProvider.of<BrushBloc>(context).state.strokeWidth;
          var selectedColor =
              BlocProvider.of<BrushBloc>(context).state.selectedColor;

          setState(() {
            BlocProvider.of<BrushBloc>(context).add(Draw(
                drawingPoints: DrawingPoints(
                    points: renderBox.globalToLocal(details.globalPosition),
                    paint: Paint()
                      ..strokeCap = strokeCap
                      ..isAntiAlias = true
                      ..color = selectedColor
                      ..strokeWidth = strokeWidth)));
          });
        },
        onPanStart: (details) {
          setState(() {
            RenderBox renderBox = context.findRenderObject();
            var strokeWidth =
                BlocProvider.of<BrushBloc>(context).state.strokeWidth;
            var selectedColor =
                BlocProvider.of<BrushBloc>(context).state.selectedColor;
            BlocProvider.of<BrushBloc>(context).add(Draw(
                drawingPoints: DrawingPoints(
                    points: renderBox.globalToLocal(details.globalPosition),
                    paint: Paint()
                      ..strokeCap = strokeCap
                      ..isAntiAlias = true
                      ..color = selectedColor
                      ..strokeWidth = strokeWidth)));
          });
        },
        onPanEnd: (details) {
          setState(() {
            BlocProvider.of<BrushBloc>(context).add(Draw(drawingPoints: null));
          });
        },
        child:
            BlocBuilder<BrushBloc, BrushState>(builder: (context, brushState) {
          return BlocBuilder<FilterBloc, FilterState>(
              builder: (context, filterState) {
            return BlocBuilder<TextBloc, TextState>(
                builder: (context, textState) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      // size: Size.fromHeight(100),
                      painter: ImagePainter(
                        pointsList: brushState.points,
                        image: image,
                      ),
                    ),
                  ),
                ]..addAll(textState.listText.map((e) {
                    Text text = Text(
                      "${e.text}",
                      style: e.textStyle,
                    );
                    return Positioned.fill(
                      left: e.offset.dx,
                      top: e.offset.dy,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        // onScaleStart: (detail) {
                        //   // _editPhotoBloc.add(UpdateSticker(
                        //   //   index: index,
                        //   //   offset: detail.focalPoint,
                        //   //   previousZoom: state.listStickerModel[index].zoom,
                        //   // ));
                        //   // BlocProvider.of<TextBloc>(context).add(UpdateText(
                        //   //     index: textState.listText.indexOf(e),
                        //   //     textModel: e.copyWith(
                        //   //       offset: detail.focalPoint,
                        //   //     )));
                        // },
                        // onScaleUpdate: (detail) {
                        //   print("${detail.focalPoint}");
                        //   BlocProvider.of<TextBloc>(context).add(UpdateText(
                        //       index: textState.listText.indexOf(e),
                        //       textModel: e.copyWith(
                        //         offset: detail.localFocalPoint,
                        //       )));
                        //   // _editPhotoBloc.add(UpdateSticker(
                        //   //     index: index,
                        //   //     offset: Offset(detail.localFocalPoint.dx,
                        //   //         detail.focalPoint.dy),
                        //   //     angle: detail.rotation,
                        //   //     zoom: state.listStickerModel[index].previousZoom *
                        //   //         detail.scale));
                        // },
                        onPanUpdate: (detail) {
                          BlocProvider.of<TextBloc>(context).add(UpdateText(
                              index: textState.listText.indexOf(e),
                              textModel: e.copyWith(
                                offset: detail.localPosition,
                              )));
                        },
                        child: text,
                      ),
                    );
                  }).toList()),
              );
            });
          });
        }),
      ),
    );
  }
}

class ImagePainter extends CustomPainter {
  ImagePainter({this.image, this.pointsList});
  ui.Image image;
  List<DrawingPoints> pointsList;
  List<Offset> offsetPoints = List();

  @override
  void paint(Canvas canvas, Size size) {
    final imageSize = Size(image.width.toDouble(), image.height.toDouble());
    final src = Offset.zero & imageSize;
    final dst = Offset.zero & size;

    canvas.drawImageRect(this.image, src, dst, Paint());

    pointsList = pointsList.map((e) {
      if (e != null) {
        if (e.points.dy <= dst.height) {
          return e;
        }
      }

      return null;
    }).toList();

    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        canvas.drawLine(pointsList[i].points, pointsList[i + 1].points,
            pointsList[i].paint);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(pointsList[i].points);
        offsetPoints.add(Offset(
            pointsList[i].points.dx + 0.1, pointsList[i].points.dy + 0.1));
        canvas.drawPoints(
            ui.PointMode.points, offsetPoints, pointsList[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
