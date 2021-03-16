import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imgprc/blocs/filter/filter_bloc.dart';
import 'package:imgprc/utils/enums.dart';
import 'package:imgprc/utils/helper.dart';

class ListFiltersWidget extends StatefulWidget {
  @override
  _ListFiltersWidgetState createState() => _ListFiltersWidgetState();
}

class _ListFiltersWidgetState extends State<ListFiltersWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: FilterType.values.map((e) {
          return InkWell(
            onTap: () {
              print("tap");
              BlocProvider.of<FilterBloc>(context).add(SetFilter(
                filterType: e,
              ));
            },
            child: Container(
              height: 80,
              width: 80,
              margin: EdgeInsets.only(right: 10),
              color: Colors.green[50],
              alignment: Alignment.center,
              child: Text(
                Helper.getFilterName(e),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
