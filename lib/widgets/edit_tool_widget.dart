import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imgprc/blocs/emoij/emoij_bloc.dart';
import 'package:imgprc/blocs/tool/tool_bloc.dart';
import 'package:imgprc/config/app_assets.dart';
import 'package:imgprc/config/app_routes.dart';
import 'package:imgprc/models/emoij_model.dart';
import 'package:imgprc/screens/functions/brush/show_brush_editor.dart';
import 'package:imgprc/screens/functions/emoij/list_emoij_widget.dart';
import 'package:imgprc/screens/functions/text/show_input_text_page.dart';
import 'package:imgprc/utils/enums.dart';

class EditToolWidget extends StatelessWidget {
  String getAsset(ToolType type) {
    switch (type) {
      case ToolType.Brush:
        return AppAssets.brushIcon;
        break;
      case ToolType.Text:
        return AppAssets.textIcon;
        break;
      case ToolType.Eraser:
        return AppAssets.eraserIcon;
        break;
      case ToolType.Emoij:
        return AppAssets.emoijIcon;
        break;
      default:
        return '';
    }
  }

  String getName(ToolType type) {
    switch (type) {
      case ToolType.Brush:
        return 'Brush';
        break;
      case ToolType.Text:
        return 'Text';
        break;
      case ToolType.Eraser:
        return 'Eraser';
        break;
      case ToolType.Emoij:
        return 'Emoij';
        break;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToolBloc, ToolState>(builder: (context, state) {
      return Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: ToolType.values.map((e) {
              if (e == ToolType.None) {
                return Container();
              }
              return GestureDetector(
                onTap: () {
                  // AppRoutes.push(context, ImageEditorPro());
                  switch (e) {
                    case ToolType.Brush:
                      showModalBottomSheet(
                          context: context, builder: (_) => ShowBrushTool());
                      break;
                    case ToolType.Text:
                      AppRoutes.push(context, InputTextPage());
                      break;
                    case ToolType.Eraser:
                      // TODO: Handle this case.
                      break;
                    case ToolType.Emoij:
                      showModalBottomSheet(
                          context: context,
                          builder: (_) => ListEmoijWidget(
                                onEmoijTap: (value) {
                                  BlocProvider.of<ToolBloc>(context).add(
                                      SelectTool(toolType: ToolType.Emoij));
                                  BlocProvider.of<EmoijBloc>(context).add(
                                    AddEmoij(
                                      EmoijModel(
                                        offset: Offset(
                                          MediaQuery.of(context).size.width / 2,
                                          MediaQuery.of(context).size.height /
                                              2,
                                        ),
                                        path: value,
                                        size: 40,
                                      ),
                                    ),
                                  );
                                },
                              ));
                      break;
                    case ToolType.None:
                      // TODO: Handle this case.
                      break;
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: state.currentToolType == e
                              ? Colors.white
                              : Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white),
                        ),
                        child: SvgPicture.asset(getAsset(e),
                            width: 22,
                            color: state.currentToolType == e
                                ? Colors.black
                                : Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(getName(e)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    });
  }
}
