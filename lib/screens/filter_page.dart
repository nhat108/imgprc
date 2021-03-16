import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imgprc/blocs/filter/filter_bloc.dart';
import 'package:imgprc/widgets/list_filters_widget.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  File file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result =
              await ImagePicker().getImage(source: ImageSource.gallery);

          if (result != null) {
            File file = File(result.path);

            BlocProvider.of<FilterBloc>(context).add(ResetFilter());
            BlocProvider.of<FilterBloc>(context).input = file;
            setState(() {
              this.file = file;
            });
          }
        },
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child:
                BlocBuilder<FilterBloc, FilterState>(builder: (context, state) {
              if (file == null) {
                return Container();
              }
              File image = file;
              if (state.imageEncode.isNotEmpty) {
                return Center(
                  child: Image.memory(
                    state.imageEncode,
                    // width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                );
              }

              if (image != null) {
                return Center(
                  child: Image.file(
                    image,
                    // width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                );
              }
              return Container();
            }),
          ),
          Expanded(child: ListFiltersWidget())
        ],
      ),
    );
  }
}
