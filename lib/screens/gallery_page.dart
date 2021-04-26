import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imgprc/blocs/home/home_bloc.dart';
import 'package:imgprc/config/app_colors.dart';
import 'package:imgprc/config/app_routes.dart';
import 'package:imgprc/config/text_styles.dart';
import 'package:imgprc/screens/edit_photo_navigator/edit_photo_navigator.dart';
import 'package:photo_gallery/photo_gallery.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  Widget _buildMainImage() {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Stack(
        children: [
          state.imageSelected.isEmpty
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  color: Colors.grey[200],
                )
              : Image.file(
                  File('${state.imageSelected}'),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
          Positioned.fill(
            bottom: 10,
            left: 10,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.grey1Color.withOpacity(0.3),
                ),
                child: Icon(
                  Icons.fit_screen,
                  size: 16,
                ),
              ),
            ),
          )
        ],
      );
    });
  }

  Widget _buildListGirdImages() {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 1,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        padding: EdgeInsets.only(bottom: 80),
        children: List.generate(state.albums.first.items.length, (index) {
          return GestureDetector(
            onTap: () {
              BlocProvider.of<HomeBloc>(context)
                  .add(SelectMainImage(state.albums.first.items[index]));
            },
            child: FadeInImage(
              fit: BoxFit.cover,
              placeholder: MemoryImage(Uint8List.fromList([0])),
              image: ThumbnailProvider(
                mediumId: state.albums.first.items[index].id,
                height: 40,
                width: 40,
                mediumType: MediumType.image,
              ),
            ),
          );
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            backgroundColor: AppColors.primaryColor,
            leading: IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  AppRoutes.push(context, EditPhotoNavigator());
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "NEXT",
                    style: AppStyles.medium(size: 16),
                  ),
                ),
              )
            ],
          ),
          _buildMainImage(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent",
                  style: AppStyles.book(size: 16),
                ),
                const SizedBox(
                  width: 4,
                ),
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
          Expanded(child: _buildListGirdImages())
        ],
      ),
    );
  }
}
