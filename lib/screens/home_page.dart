// import 'package:image/image.dart' as img;

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imgprc/blocs/home/home_bloc.dart';
import 'package:imgprc/config/app_colors.dart';
import 'package:imgprc/config/app_routes.dart';
import 'package:imgprc/config/text_styles.dart';
import 'package:imgprc/screens/gallery_page.dart';

import 'edit_photo_navigator/edit_photo_navigator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pages = [];
  int _currentPage = 0;
  final PageController _pageController = PageController(keepPage: true);
  @override
  void initState() {
    pages = [
      GalleryPage(),
      // UnityDemoScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BottomNavigationBar(
        currentPage: _currentPage,
        onChanged: (value) {
          setState(() {
            _currentPage = value;
          });
          _pageController.animateToPage(value,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
      ),
      body: PageView(
        children: pages,
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
      ),
      backgroundColor: AppColors.primaryColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class BottomNavigationBar extends StatelessWidget {
  final Function(int) onChanged;
  final int currentPage;
  const BottomNavigationBar(
      {Key key, @required this.onChanged, @required this.currentPage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: new BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      onChanged(0);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text("GALLERY",
                          style: currentPage == 0
                              ? AppStyles.medium(size: 14)
                              : AppStyles.light(size: 14)),
                    )),
                GestureDetector(
                  onTap: () async {
                    var image = await ImagePicker()
                        .getImage(source: ImageSource.camera);
                    if (image != null) {
                      BlocProvider.of<HomeBloc>(context)
                          .add(SelectImageFromCamera(image.path));
                      AppRoutes.push(context, EditPhotoNavigator());
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text("CAMERA",
                        style: currentPage == 1
                            ? AppStyles.medium(size: 14)
                            : AppStyles.light(size: 14)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
