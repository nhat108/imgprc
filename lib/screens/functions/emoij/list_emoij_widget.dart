import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imgprc/blocs/home/home_bloc.dart';
import 'package:imgprc/config/text_styles.dart';

class ListEmoijWidget extends StatelessWidget {
  final Function(String) onEmoijTap;

  const ListEmoijWidget({Key key, @required this.onEmoijTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 23, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: AppStyles.medium(size: 16, color: Colors.grey[300]),
                ),
              ),
              GestureDetector(
                onTap: () {
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
            child: BlocBuilder<HomeBloc, HomeState>(builder: (_, state) {
              return GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: state.listEmoijPath.map((e) {
                  return GestureDetector(
                      onTap: () {
                        onEmoijTap(e);
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(e));
                }).toList(),
              );
            }),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
