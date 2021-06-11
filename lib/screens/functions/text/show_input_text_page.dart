import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:imgprc/blocs/text/text_bloc.dart';
import 'package:imgprc/blocs/tool/tool_bloc.dart';
import 'package:imgprc/config/app_colors.dart';
import 'package:imgprc/config/text_styles.dart';
import 'package:imgprc/models/text_paint.dart';
import 'package:imgprc/utils/enums.dart';

class InputTextPage extends StatefulWidget {
  @override
  _InputTextPageState createState() => _InputTextPageState();
}

class _InputTextPageState extends State<InputTextPage> {
  final TextEditingController _textEditingController = TextEditingController();
  double size = 5;
  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (_textEditingController.text.isNotEmpty) {
                TextModel textModel = TextModel(
                  textStyle: TextStyle(color: color, fontSize: size * 10),
                  offset: Offset(MediaQuery.of(context).size.width / 2,
                      MediaQuery.of(context).size.width / 2),
                  text: _textEditingController.text,
                  textDirection: TextDirection.ltr,
                );
                BlocProvider.of<TextBloc>(context)
                    .add(AddText(textModel: textModel));
                BlocProvider.of<ToolBloc>(context)
                    .add(SelectTool(toolType: ToolType.Text));
              }
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "DONE",
                style: AppStyles.medium(size: 16),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Size",
                    style: AppStyles.book(size: 18),
                  ),
                  Expanded(
                    child: Slider(
                        value: size,
                        min: 1,
                        max: 10,
                        divisions: 9,
                        onChanged: (value) {
                          setState(() {
                            size = value;
                          });
                        }),
                  ),
                  Text(
                    "$size",
                    style: AppStyles.book(size: 18),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Color",
                    style: AppStyles.book(size: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Select a color'),
                            content: SingleChildScrollView(
                              child: BlockPicker(
                                pickerColor: color,
                                onColorChanged: (value) {
                                  setState(() {
                                    color = value;
                                  });

                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      width: 25,
                      height: 25,
                      margin: EdgeInsets.only(left: 20),
                      decoration:
                          BoxDecoration(color: color, shape: BoxShape.circle),
                    ),
                  )
                ],
              ),
              Center(
                child: TextField(
                  controller: _textEditingController,
                  autofocus: true,
                  minLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  maxLines: 5,
                  style: TextStyle(fontSize: size * 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
