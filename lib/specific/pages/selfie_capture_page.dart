import 'dart:async';

import 'package:bearlysocial/generic/functions/getters/app_colors.dart';
import 'package:bearlysocial/generic/widgets/buttons/colored_btn.dart';
import 'package:bearlysocial/specific/functions/detect_face_in_selfie.dart';
import 'package:bearlysocial/specific/widgets/painter/rect_painter.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class _SelfieCapturePage extends State<SelfieCapturePage>
    with SingleTickerProviderStateMixin {
  bool _focusIsSet = false;
  Timer? _focusTimer;

  late CameraController _deviceCameraController;
  late Future<void> _deviceCameraInitialization;

  final FaceDetector _uprightFaceDetector =
      GoogleMlKit.vision.faceDetector(FaceDetectorOptions(
    performanceMode: FaceDetectorMode.accurate,
    enableTracking: true,
  ));
  bool _detectingFaceInSelfie = false;

  late AnimationController _animationController;

  Face? _trackedFace;

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

          final Face? bestShotFace = await detectFaceInSelfie(
            screenSize: MediaQuery.of(context).size,
            selfie: selfie,
            sensorOrientation: widget.deviceCamera.sensorOrientation,
            uprightFaceDetector: _uprightFaceDetector,
          );

          if (_trackedFace?.trackingId == bestShotFace?.trackingId &&
              bestShotFace != null) {
            final double? smilingProbability = _trackedFace?.smilingProbability;

            if (smilingProbability != null && smilingProbability >= 0.98) {
              Future<XFile> newSelfie = _deviceCameraController.takePicture();
            }
          }

          _trackedFace = bestShotFace;

          _detectingFaceInSelfie = false;
        }
      });
    });

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _deviceCameraController.dispose();
    _uprightFaceDetector.close();
    _animationController.dispose();

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
                      stops: const [0, 0.2, 0.4],
                      colors: <Color>[
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.16),
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

                      _focusTimer?.cancel();

                      _focusTimer =
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
                SafeArea(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          UnconstrainedBox(
                            child: ColoredButton(
                              horizontalPadding: 8,
                              verticalPadding: 8,
                              callbackFunction: () => Navigator.pop(context),
                              borderColor: Colors.transparent,
                              uniformBorderRadius: 128,
                              child: const Icon(
                                Icons.arrow_back,
                                size: 24,
                              ),
                            ),
                          ),
                          Expanded(
                            child: AnimatedBuilder(
                              animation: _animationController,
                              builder: (a, b) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Scanning facial features ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    ...List.generate(4, (index) {
                                      return Transform.translate(
                                        offset: Offset(
                                          _animationController.value *
                                              ((index + 2) * -2),
                                          0,
                                        ),
                                        child: const Text(
                                          '.',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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
