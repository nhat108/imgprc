// import 'package:image/image.dart' as img;

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:imgprc/config/text_styles.dart';
import 'package:imgprc/screens/camera_page.dart';
import 'package:imgprc/screens/gallery_page.dart';

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
      CameraPage(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: new BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Gallery", style: AppStyles.medium()),
              Text(
                "Camera",
                style: AppStyles.book(),
              )
            ],
          ),
        ),
      ),
      body: PageView(
        children: pages,
        controller: _pageController,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
