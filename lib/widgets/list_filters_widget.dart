import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imgprc/blocs/filter/filter_bloc.dart';
import 'package:imgprc/config/app_assets.dart';
import 'package:imgprc/config/text_styles.dart';
import 'package:imgprc/utils/enums.dart';
import 'package:imgprc/utils/helper.dart';

class ListFiltersWidget extends StatefulWidget {
  @override
  _ListFiltersWidgetState createState() => _ListFiltersWidgetState();
}

class _ListFiltersWidgetState extends State<ListFiltersWidget> {
  String getImageFilter(FilterType type) {
    switch (type) {
      case FilterType.Normal:
        return AppAssets.normalImage;
        break;
      case FilterType.Grey:
        return AppAssets.greyImage;
        break;
      case FilterType.Negative:
        return AppAssets.negativeImage;
        break;
      case FilterType.RedGreenBlue:
        return AppAssets.rgbImage;
        break;
      case FilterType.Sepia:
        return AppAssets.sepiaImage;
        break;
      case FilterType.Mirror:
        return AppAssets.mirrorImage;
        break;
      case FilterType.Laplace:
        return AppAssets.laplaceImage;

      case FilterType.GaussianBlue:
        return AppAssets.gaussinBlur;
        break;
      case FilterType.MedianBlur:
        return AppAssets.medianBlur;
        break;
    }
    return AppAssets.normalImage;
  }

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
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
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
                              ? AppStyles.medium(size: 16)
                              : AppStyles.book(size: 16),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.width * 0.25,
                          width: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                            border: isSelected
                                ? Border.all(
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          padding: EdgeInsets.all(5),
                          child: Image.asset(
                            getImageFilter(e),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      );
    });
  }
}
