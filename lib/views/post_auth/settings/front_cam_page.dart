// import 'package:bearlysocial/generic/functions/getters/cam_permission.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';

// class FrontCameraPage extends StatefulWidget {
//   const FrontCameraPage({super.key});

//   @override
//   State<FrontCameraPage> createState() => _FrontCameraPage();
// }

// class _FrontCameraPage extends State<FrontCameraPage> {
//   // Widget _page = const BlankPage();

//   @override
//   Widget build(BuildContext context) {
//     cameraPermission.then((granted) async {
//       if (granted) {
//         final List<CameraDescription> cameras = await availableCameras();
//         final CameraDescription frontCamera = cameras.firstWhere(
//           (camera) => camera.lensDirection == CameraLensDirection.front,
//         );

//         setState(() {
//           // _page = SelfieCapturePage(deviceCamera: frontCamera);
//         });
//       }
//     });

//     return SizedBox();
//     // return _page;
//   }
// }
