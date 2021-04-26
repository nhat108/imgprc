import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'package:flutter/material.dart';
import 'package:imgprc/utils/constants.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  String _platformVersion = 'Unknown';
  CameraDeepArController cameraDeepArController;
  int currentPage = 0;
  final vp = PageController(viewportFraction: .24);
  Effects currentEffect = Effects.none;
  Filters currentFilter = Filters.none;
  Masks currentMask = Masks.none;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('DeepAR Camera Example'),
      ),
      body: Stack(
        children: [
          CameraDeepAr(
              cameraDirection: CameraDirection.front,
              onCameraReady: (isReady) {
                _platformVersion = "Camera status $isReady";
                setState(() {});
              },
              onImageCaptured: (path) {
                _platformVersion = "Image Taken @ $path";
                setState(() {});
              },
              onVideoRecorded: (path) {
                _platformVersion = "Video Recorded @ $path";
                isRecording = false;
                setState(() {});
              },
              androidLicenceKey: Constants.ANDROID_DEEP_AR_KEY,
              iosLicenceKey: Constants.IOS_DEEP_AR_KEY,
              cameraDeepArCallback: (c) async {
                cameraDeepArController = c;
                setState(() {});
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(20),
              //height: 250,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Text(
                  //   'Response >>> : $_platformVersion\n',
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(fontSize: 14, color: Colors.white),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FlatButton(
                          onPressed: () {
                            if (null == cameraDeepArController) return;
                            if (isRecording) return;
                            cameraDeepArController.snapPhoto();
                          },
                          child: Icon(Icons.camera_enhance_outlined),
                          color: Colors.white,
                          padding: EdgeInsets.all(15),
                        ),
                      ),
                      if (isRecording)
                        Expanded(
                          child: FlatButton(
                            onPressed: () {
                              if (null == cameraDeepArController) return;
                              cameraDeepArController.stopVideoRecording();
                              isRecording = false;
                              setState(() {});
                            },
                            child: Icon(Icons.videocam_off),
                            color: Colors.red,
                            padding: EdgeInsets.all(15),
                          ),
                        )
                      else
                        Expanded(
                          child: FlatButton(
                            onPressed: () {
                              if (null == cameraDeepArController) return;
                              cameraDeepArController.startVideoRecording();
                              isRecording = true;
                              setState(() {});
                            },
                            child: Icon(Icons.videocam),
                            color: Colors.green,
                            padding: EdgeInsets.all(15),
                          ),
                        ),
                    ],
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.all(15),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(Masks.values.length, (p) {
                        bool active = currentPage == p;
                        return GestureDetector(
                          onTap: () {
                            currentPage = p;
                            cameraDeepArController.changeMask(p);
                            setState(() {});
                          },
                          child: Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(12),
                              width: active ? 100 : 80,
                              height: active ? 100 : 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: active ? Colors.orange : Colors.white,
                                  shape: BoxShape.circle),
                              child: Text(
                                "$p",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: active ? 16 : 14,
                                    color: Colors.black),
                              )),
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// class UnityDemoScreen extends StatefulWidget {
//   UnityDemoScreen({Key key}) : super(key: key);

//   @override
//   _UnityDemoScreenState createState() => _UnityDemoScreenState();
// }

// class _UnityDemoScreenState extends State<UnityDemoScreen> {
//   UnityWidgetController _unityWidgetController;
//   double _sliderValue = 0.0;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Unity Flutter Demo'),
//         ),
//         body: Card(
//           margin: const EdgeInsets.all(8),
//           clipBehavior: Clip.antiAlias,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.0),
//           ),
//           child: Stack(
//             children: <Widget>[
//               UnityWidget(
//                 onUnityCreated: onUnityCreated,
//                 onUnityMessage: onUnityMessage,
//                 onUnitySceneLoaded: onUnitySceneLoaded,
//                 fullscreen: false,
//               ),
//               Positioned(
//                 bottom: 20,
//                 left: 20,
//                 right: 20,
//                 child: Card(
//                   elevation: 10,
//                   child: Column(
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.only(top: 20),
//                         child: Text("Rotation speed:"),
//                       ),
//                       Slider(
//                         onChanged: (value) {
//                           setState(() {
//                             _sliderValue = value;
//                           });
//                           setRotationSpeed(value.toString());
//                         },
//                         value: _sliderValue,
//                         min: 0,
//                         max: 20,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Communcation from Flutter to Unity
//   void setRotationSpeed(String speed) {
//     _unityWidgetController.postMessage(
//       'Capsule',
//       'SetRotationSpeed',
//       speed,
//     );
//   }

//   // Communication from Unity to Flutter
//   void onUnityMessage(message) {
//     print('Received message from unity: ${message.toString()}');
//   }

//   // Callback that connects the created controller to the unity controller
//   void onUnityCreated(controller) {
//     this._unityWidgetController = controller;
//   }

//   // Communication from Unity when new scene is loaded to Flutter
//   void onUnitySceneLoaded(SceneLoaded sceneInfo) {
//     print('Received scene loaded from unity: ${sceneInfo.name}');
//     print(
//         'Received scene loaded from unity buildIndex: ${sceneInfo.buildIndex}');
//   }
// }
