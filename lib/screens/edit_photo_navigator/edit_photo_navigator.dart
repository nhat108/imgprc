import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imgprc/blocs/brush/brush_bloc.dart';
import 'package:imgprc/blocs/emoij/emoij_bloc.dart';
import 'package:imgprc/blocs/filter/filter_bloc.dart';
import 'package:imgprc/blocs/home/home_bloc.dart';
import 'package:imgprc/blocs/text/text_bloc.dart';
import 'package:imgprc/blocs/tool/tool_bloc.dart';
import 'package:imgprc/config/app_assets.dart';
import 'package:imgprc/config/app_colors.dart';
import 'package:imgprc/config/text_styles.dart';
import 'package:imgprc/models/drawing_point.dart';
import 'package:imgprc/models/text_paint.dart';
import 'package:imgprc/utils/enums.dart';
import 'package:imgprc/utils/progress_image.dart';

import 'dart:ui' as ui;

import 'package:imgprc/widgets/edit_tool_widget.dart';
import 'package:imgprc/widgets/list_filters_widget.dart';

class EditPhotoNavigator extends StatefulWidget {
  @override
  _EditPhotoNavigatorState createState() => _EditPhotoNavigatorState();
}

class _EditPhotoNavigatorState extends State<EditPhotoNavigator> {
  @override
  void initState() {
    BlocProvider.of<FilterBloc>(context).input =
        File(BlocProvider.of<HomeBloc>(context).state.imageSelected);
    super.initState();
    // _initImage();
  }

  Widget _brushAppBar() {
    return AppBar(
      backgroundColor: AppColors.secondaryColor,
      leading: IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.white,
        ),
        onPressed: () {
          BlocProvider.of<ToolBloc>(context)
              .add(SelectTool(toolType: ToolType.None));
        },
      ),
      title: Text("Brush"),
      actions: [
        IconButton(
            icon: Icon(
              Icons.undo,
            ),
            onPressed: () {
              BlocProvider.of<BrushBloc>(context).add(Undo());
            }),
        IconButton(
          icon: Icon(Icons.redo),
          onPressed: () {
            BlocProvider.of<BrushBloc>(context).add(Redo());
          },
        ),
      ],
    );
  }

  Widget _textAppBar() {
    return AppBar(
      backgroundColor: AppColors.secondaryColor,
      leading: IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.white,
        ),
        onPressed: () {
          BlocProvider.of<ToolBloc>(context)
              .add(SelectTool(toolType: ToolType.None));
        },
      ),
      title: Text("Text"),
      actions: [
        IconButton(
            icon: Icon(
              Icons.undo,
            ),
            onPressed: () {
              BlocProvider.of<TextBloc>(context).add(UndoText());
            }),
        IconButton(
          icon: Icon(Icons.redo),
          onPressed: () {
            BlocProvider.of<TextBloc>(context).add(RedoText());
          },
        ),
      ],
    );
  }

  Widget _emoijAppBar() {
    return AppBar(
      backgroundColor: AppColors.secondaryColor,
      leading: IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.white,
        ),
        onPressed: () {
          BlocProvider.of<ToolBloc>(context)
              .add(SelectTool(toolType: ToolType.None));
        },
      ),
      title: Text("Emoij"),
      actions: [
        IconButton(
            icon: Icon(
              Icons.undo,
            ),
            onPressed: () {
              BlocProvider.of<TextBloc>(context).add(UndoText());
            }),
        IconButton(
          icon: Icon(Icons.redo),
          onPressed: () {
            BlocProvider.of<TextBloc>(context).add(RedoText());
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: BlocBuilder<ToolBloc, ToolState>(
            builder: (context, state) {
              if (state.currentToolType == ToolType.Brush) {
                return _brushAppBar();
              }
              if (state.currentToolType == ToolType.Text) {
                return _textAppBar();
              }
              if (state.currentToolType == ToolType.Emoij) {
                return _emoijAppBar();
              }
              return AppBar(
                centerTitle: true,
                actions: [
                  GestureDetector(
                    onTap: () {
                      var imageEncode = BlocProvider.of<FilterBloc>(context)
                          .state
                          .imageEncode;
                      var screenWidth = MediaQuery.of(context).size.width;
                      var points =
                          BlocProvider.of<BrushBloc>(context).state.points;
                      var textModels =
                          BlocProvider.of<TextBloc>(context).state.listText;
                      var emoijs =
                          BlocProvider.of<EmoijBloc>(context).state.emoijs;

                      if (imageEncode.isNotEmpty) {
                        ProgressImage().convertUnit8ListToImage(imageEncode,
                            (result) async {
                          BlocProvider.of<FilterBloc>(context).add(
                            ExportImage(
                              emoijs: emoijs,
                              screenWidth: screenWidth,
                              image: result,
                              points: points,
                              listText: textModels,
                              context: context,
                            ),
                          );
                        });
                      } else {
                        ProgressImage().convertFileToImage(
                            File(BlocProvider.of<HomeBloc>(context)
                                .state
                                .imageSelected), (result) {
                          BlocProvider.of<FilterBloc>(context).add(
                            ExportImage(
                              emoijs: emoijs,
                              screenWidth: screenWidth,
                              image: result,
                              points: points,
                              listText: textModels,
                              context: context,
                            ),
                          );
                        });
                      }
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "NEXT",
                        style: AppStyles.medium(size: 16),
                      ),
                    ),
                  )
                ],
                title: SvgPicture.asset(
                  AppAssets.magicIcon,
                  color: Colors.white,
                  width: 22,
                ),
                backgroundColor: AppColors.secondaryColor,
              );
            },
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        bottomNavigationBar: SafeArea(
          child: TabBar(tabs: [
            Tab(
              text: 'FILTER',
            ),
            Tab(
              text: 'EDIT',
            )
          ]),
        ),
        body: BlocBuilder<FilterBloc, FilterState>(builder: (context, state) {
          return Stack(
            children: [
              Column(
                children: [
                  ImageDisplay(),
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
              if (state.isSaving)
                Center(
                  child: Container(
                    padding: EdgeInsets.all(30),
                    child: CircularProgressIndicator(),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                )
            ],
          );
        }),
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
  StrokeCap strokeCap =
      (Platform.isAndroid) ? StrokeCap.round : StrokeCap.round;
  ui.Image image;
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
    print(MediaQuery.of(context).size.width);
    return BlocListener<FilterBloc, FilterState>(
      listenWhen: (oldState, newState) {
        if (oldState.imageEncode != newState.imageEncode) {
          return true;
        }
        return false;
      },
      listener: (_, state) {
        ProgressImage().convertUnit8ListToImage(state.imageEncode,
            (result) async {
          setState(() {
            image = result;
          });
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onPanUpdate: (details) {
            var tool = BlocProvider.of<ToolBloc>(context).state.currentToolType;
            if (tool == ToolType.Brush) {
              RenderBox renderBox = context.findRenderObject();

              var strokeWidth =
                  BlocProvider.of<BrushBloc>(context).state.strokeWidth;
              var selectedColor =
                  BlocProvider.of<BrushBloc>(context).state.selectedColor;

              BlocProvider.of<BrushBloc>(context).add(Draw(
                  drawingPoints: DrawingPoints(
                      offset: renderBox.globalToLocal(details.globalPosition),
                      paint: Paint()
                        ..strokeCap = strokeCap
                        ..isAntiAlias = true
                        ..color = selectedColor
                        ..strokeWidth = strokeWidth)));
            }
          },
          onPanStart: (details) {
            var tool = BlocProvider.of<ToolBloc>(context).state.currentToolType;
            if (tool == ToolType.Brush) {
              RenderBox renderBox = context.findRenderObject();
              var strokeWidth =
                  BlocProvider.of<BrushBloc>(context).state.strokeWidth;
              var selectedColor =
                  BlocProvider.of<BrushBloc>(context).state.selectedColor;
              BlocProvider.of<BrushBloc>(context).add(Draw(
                  drawingPoints: DrawingPoints(
                      offset: renderBox.globalToLocal(details.globalPosition),
                      paint: Paint()
                        ..strokeCap = strokeCap
                        ..isAntiAlias = true
                        ..color = selectedColor
                        ..strokeWidth = strokeWidth)));
            }
          },
          onPanEnd: (details) {
            var tool = BlocProvider.of<ToolBloc>(context).state.currentToolType;
            if (tool == ToolType.Brush) {
              BlocProvider.of<BrushBloc>(context)
                  .add(Draw(drawingPoints: null));
            }
          },
          child: BlocBuilder<BrushBloc, BrushState>(
              builder: (context, brushState) {
            return BlocBuilder<FilterBloc, FilterState>(
                builder: (context, filterState) {
              return BlocBuilder<TextBloc, TextState>(
                  builder: (context, textState) {
                return BlocBuilder<EmoijBloc, EmoijState>(
                    builder: (context, emoijState) {
                  return Stack(
                    children: [
                      Stack(
                        children: [
                          Positioned.fill(
                            child: CustomPaint(
                              painter: ImagePainter(
                                pointsList: brushState.points,
                                image: image,
                              ),
                            ),
                          ),
                        ]
                          ..addAll(textState.listText.map((e) {
                            return TextWidget(
                              index: textState.listText.indexOf(e),
                              textModel: e,
                            );
                          }).toList())
                          ..addAll(emoijState.emoijs.map((e) {
                            return Positioned.fill(
                              left: e.offset.dx,
                              top: e.offset.dy,
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onPanUpdate: (detail) {
                                  BlocProvider.of<EmoijBloc>(context).add(
                                    UpdateEmoij(
                                      detail.localPosition,
                                      emoijState.emoijs.indexOf(e),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      e.path,
                                      width: e.size,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList()),
                      ),
                      if (filterState.filterLoading)
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: CircularProgressIndicator(
                              backgroundColor: AppColors.primaryColor,
                            ),
                          ),
                        )
                    ],
                  );
                });
              });
            });
          }),
        ),
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
        if (e.offset.dy <= dst.height) {
          return e;
        }
      }

      return null;
    }).toList();

    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        canvas.drawLine(pointsList[i].offset, pointsList[i + 1].offset,
            pointsList[i].paint);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(pointsList[i].offset);
        offsetPoints.add(Offset(
            pointsList[i].offset.dx + 0.1, pointsList[i].offset.dy + 0.1));
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

class TextWidget extends StatelessWidget {
  final TextModel textModel;
  final int index;

  const TextWidget({Key key, @required this.textModel, @required this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Text text = Text(
      "${textModel.text}",
      style: textModel.textStyle,
    );
    return Positioned.fill(
      left: textModel.offset.dx,
      top: textModel.offset.dy,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanUpdate: (detail) {
          BlocProvider.of<TextBloc>(context).add(
            UpdateText(
              index: index,
              textModel: textModel.copyWith(
                offset: detail.localPosition,
              ),
            ),
          );
        },
        child: text,
      ),
    );
  }
}
