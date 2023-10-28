import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:bearlysocial/generic/functions/getters/app_colors.dart';
import 'package:bearlysocial/specific/functions/providers/profile_pic.dart';
import 'package:bearlysocial/generic/widgets/buttons/colored_btn.dart';
import 'package:bearlysocial/specific/functions/detect_face_in_selfie.dart';
import 'package:bearlysocial/specific/functions/profile_pic_maker.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart' as img;

class SelfieCapturePage extends ConsumerStatefulWidget {
  final CameraDescription deviceCamera;

  const SelfieCapturePage({
    super.key,
    required this.deviceCamera,
  });

  @override
  ConsumerState<SelfieCapturePage> createState() => _SelfieCapturePage();
}

class _SelfieCapturePage extends ConsumerState<SelfieCapturePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _focusIsSet = false;
  Timer? _focusTimer;

  late CameraController _deviceCameraController;
  late Future<void> _deviceCameraInitialization;

  final FaceDetector _uprightFaceDetector =
      GoogleMlKit.vision.faceDetector(FaceDetectorOptions(
    performanceMode: FaceDetectorMode.accurate,
    enableClassification: true,
    enableTracking: true,
  ));
  bool _detectingFaceInSelfie = false;

  late AnimationController _animationController;

  Face? _trackedFace;
  XFile? newSelfie;

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

      final Size screenSize = MediaQuery.of(context).size;
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
              newSelfie = await _deviceCameraController.takePicture();

              OverlayEntry overlayEntry = OverlayEntry(
                builder: (context) => Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(color: Colors.white),
                ),
              );

              Overlay.of(_scaffoldKey.currentContext!).insert(overlayEntry);
              await Future.delayed(const Duration(
                milliseconds: 100,
              ));
              overlayEntry.remove();

              await _deviceCameraController.stopImageStream();

              Future.delayed(
                const Duration(
                  milliseconds: 1200,
                ),
                () {
                  Navigator.pop(context);
                },
              );

              final img.Image? profilePicture = await ProfilePictureMaker(
                imagePath: newSelfie!.path,
                screenSize: screenSize,
              );

              ref.read(setProfilePicture)(profilePicture: profilePicture);
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
      key: _scaffoldKey,
      body: FutureBuilder<void>(
        future: _deviceCameraInitialization,
        builder: (context, snapshot) {
          return Stack(
            children: newSelfie == null
                ? <Widget>[
                    if (snapshot.connectionState == ConnectionState.done)
                      Positioned.fill(
                        child: AspectRatio(
                          aspectRatio:
                              _deviceCameraController.value.aspectRatio,
                          child: CameraPreview(_deviceCameraController),
                        ),
                      ),
                    Container(
                      decoration: BoxDecoration(
                        color: snapshot.connectionState == ConnectionState.done
                            ? Colors.transparent
                            : Colors.white,
                        gradient:
                            snapshot.connectionState == ConnectionState.done
                                ? LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: const [0, 0.2, 0.4],
                                    colors: <Color>[
                                      Colors.black.withOpacity(0.4),
                                      Colors.black.withOpacity(0.16),
                                      Colors.transparent,
                                    ],
                                  )
                                : null,
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
                              width: _trackedFace == null ? 2 : 8,
                              color: snapshot.connectionState ==
                                      ConnectionState.done
                                  ? _focusIsSet
                                      ? lightYellow
                                      : Colors.white
                                  : moderateGray,
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
                                  callbackFunction: () =>
                                      Navigator.pop(context),
                                  borderColor: snapshot.connectionState ==
                                          ConnectionState.done
                                      ? Colors.white
                                      : moderateGray,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _trackedFace == null
                                              ? 'Scanning facial features '
                                              : 'Smile to take a photo.',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: snapshot.connectionState ==
                                                    ConnectionState.done
                                                ? Colors.white
                                                : moderateGray,
                                          ),
                                        ),
                                        if (_trackedFace == null)
                                          ...List.generate(
                                            4,
                                            (index) {
                                              return Transform.translate(
                                                offset: Offset(
                                                  _animationController.value *
                                                      ((index + 2) * -2),
                                                  0,
                                                ),
                                                child: Text(
                                                  '.',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: snapshot
                                                                .connectionState ==
                                                            ConnectionState.done
                                                        ? Colors.white
                                                        : moderateGray,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
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
                  ]
                : <Widget>[
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi),
                      child: Image.file(
                        File(newSelfie!.path),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
          );
        },
      ),
    );
  }
}
