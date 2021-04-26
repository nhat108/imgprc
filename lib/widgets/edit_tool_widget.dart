import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imgprc/config/app_assets.dart';
import 'package:imgprc/config/app_routes.dart';
import 'package:imgprc/screens/functions/brush/show_brush_editor.dart';
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
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: ToolType.values.map((e) {
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
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white),
                      ),
                      child: SvgPicture.asset(
                        getAsset(e),
                        width: 22,
                        color: Colors.white,
                      ),
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
  }
}
