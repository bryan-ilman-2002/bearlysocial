import 'dart:async';

import 'package:bearlysocial/generic/functions/getters/app_colors.dart';
import 'package:bearlysocial/specific/functions/detect_face_in_selfie.dart';
import 'package:bearlysocial/specific/widgets/painter/rect_painter.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class SelfieCapturePage extends StatefulWidget {
  final CameraDescription deviceCamera;

  const SelfieCapturePage({
    super.key,
    required this.deviceCamera,
  });

  @override
  State<SelfieCapturePage> createState() => _SelfieCapturePage();
}

class _SelfieCapturePage extends State<SelfieCapturePage> {
  bool _focusIsSet = false;

  late CameraController _deviceCameraController;
  late Future<void> _deviceCameraInitialization;

  final FaceDetector _uprightFaceDetector =
      GoogleMlKit.vision.faceDetector(FaceDetectorOptions(
    performanceMode: FaceDetectorMode.accurate,
    enableTracking: true,
  ));
  bool _detectingFaceInSelfie = false;

  Face? detectedFace;

  @override
  void initState() {
    super.initState();
    _deviceCameraController = CameraController(
      widget.deviceCamera,
      ResolutionPreset.ultraHigh,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    _deviceCameraInitialization =
        _deviceCameraController.initialize().then((_) {
      if (!mounted) return;

      _deviceCameraController.startImageStream((CameraImage selfie) async {
        if (!_detectingFaceInSelfie) {
          _detectingFaceInSelfie = true;
          detectedFace = await detectFaceInSelfie(
            screenSize: MediaQuery.of(context).size,
            selfie: selfie,
            sensorOrientation: widget.deviceCamera.sensorOrientation,
            uprightFaceDetector: _uprightFaceDetector,
          );
          _detectingFaceInSelfie = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _deviceCameraController.dispose();
    _uprightFaceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _deviceCameraInitialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: <Widget>[
                Positioned.fill(
                  child: AspectRatio(
                    aspectRatio: _deviceCameraController.value.aspectRatio,
                    child: CameraPreview(_deviceCameraController),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        heavyGray.withOpacity(0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        border: Border.all(
                          width: 2,
                          color: _focusIsSet ? lightYellow : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                // detectedFace != null
                //     ? Positioned.fill(
                //         child: CustomPaint(
                //           painter:
                //               BoundingBoxPainter(detectedFace: detectedFace!),
                //         ),
                //       )
                //     : Positioned(
                //         child: Container(),
                //       ),
                // Add a marker at the focus point
                Positioned.fill(
                  child: GestureDetector(
                    onTapUp: (TapUpDetails details) {
                      // Convert user's tap location to relative coordinates (between 0 and 1)
                      final RenderBox box =
                          context.findRenderObject() as RenderBox;
                      final Offset localPoint =
                          box.globalToLocal(details.globalPosition);
                      final Offset relativePoint = Offset(
                          localPoint.dx / box.size.width,
                          localPoint.dy / box.size.height);

                      _deviceCameraController.setFocusPoint(relativePoint);

                      setState(() {
                        _focusIsSet = true;
                      });

                      Timer(const Duration(milliseconds: 2000), () {
                        setState(() {
                          _focusIsSet = false;
                        });
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                const SafeArea(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      children: [],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
