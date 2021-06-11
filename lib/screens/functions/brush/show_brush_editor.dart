import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:imgprc/blocs/tool/tool_bloc.dart';
import 'package:imgprc/blocs/brush/brush_bloc.dart';
import 'package:imgprc/config/text_styles.dart';
import 'package:imgprc/utils/enums.dart';

class ShowBrushTool extends StatefulWidget {
  @override
  _ShowBrushToolState createState() => _ShowBrushToolState();
}

class _ShowBrushToolState extends State<ShowBrushTool> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrushBloc, BrushState>(builder: (context, state) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 23, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<ToolBloc>(context)
                          .add(SelectTool(toolType: ToolType.None));
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style:
                          AppStyles.medium(size: 16, color: Colors.grey[300]),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<ToolBloc>(context)
                          .add(SelectTool(toolType: ToolType.Brush));
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Done",
                      style: AppStyles.medium(size: 18),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: MaterialPicker(
                  pickerColor: state.selectedColor,
                  onColorChanged: (value) {
                    BlocProvider.of<BrushBloc>(context)
                        .add(UpdateBrush(color: value));
                  },
                  enableLabel: true,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Size",
                    style: AppStyles.book(size: 16),
                  ),
                  Expanded(
                      child: Slider(
                          min: 3,
                          max: 30,
                          value: state.strokeWidth <= 3
                              ? 3
                              : state.strokeWidth / 3,
                          semanticFormatterCallback: (value) {
                            return value.toInt().toString();
                          },
                          divisions: 9,
                          onChanged: (value) {
                            BlocProvider.of<BrushBloc>(context)
                                .add(UpdateBrush(size: value * 3));
                          })),
                  Text(
                    "${state.strokeWidth}",
                  )
                ],
              ),
            ],
          ));
    });
  }
}
