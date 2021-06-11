import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imgprc/blocs/filter/filter_bloc.dart';
import 'package:imgprc/config/text_styles.dart';
import 'package:imgprc/utils/enums.dart';
import 'package:imgprc/utils/helper.dart';

class ListFiltersWidget extends StatefulWidget {
  @override
  _ListFiltersWidgetState createState() => _ListFiltersWidgetState();
}

class _ListFiltersWidgetState extends State<ListFiltersWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(builder: (context, state) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 23),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: FilterType.values.map((e) {
            bool isSelected = state.currentFilter == e;
            return InkWell(
              onTap: () {
                BlocProvider.of<FilterBloc>(context).add(SetFilter(
                  filterType: e,
                ));
              },
              child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Helper.getFilterName(e),
                      style: isSelected
                          ? AppStyles.medium(size: 14)
                          : AppStyles.book(size: 14),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.25,
                      width: MediaQuery.of(context).size.width * 0.25,
                      color: Colors.pink,
                      alignment: Alignment.center,
                      child: Text(
                        Helper.getFilterName(e),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}
