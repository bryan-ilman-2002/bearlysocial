import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:bearlysocial/components/buttons/splash_btn.dart';
import 'package:bearlysocial/constants/design_tokens.dart';
import 'package:bearlysocial/providers/profile_pic_state.dart';
import 'package:bearlysocial/utilities/selfie_capture_operation.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart' as img_lib;

class SelfieScreen extends ConsumerStatefulWidget {
  final CameraDescription frontCamera;

  const SelfieScreen({
    super.key,
    required this.frontCamera,
  });

  @override
  ConsumerState<SelfieScreen> createState() => _SelfieScreen();
}

class _SelfieScreen extends ConsumerState<SelfieScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late AnimationController _animationController;
  late CameraController _camController;

  late Future<void> _camInit;

  bool _detecting = false;
  Face? _detectedFace;

  XFile? selfie;

  bool _settingFocus = false;
  Timer? _focusTimer;

  final FaceDetector _faceDetector = GoogleMlKit.vision.faceDetector(
    FaceDetectorOptions(
      performanceMode: FaceDetectorMode.accurate,
      enableClassification: true,
      enableTracking: true,
    ),
  );

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(
        milliseconds: AnimationDuration.slow,
      ),
      vsync: this,
    )..repeat(reverse: true);

    _camController = CameraController(
      widget.frontCamera,
      ResolutionPreset.ultraHigh,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    _camInit = _camController.initialize().then((_) {
      final Size screenSize = MediaQuery.of(context).size;

      _camController.startImageStream((CameraImage img) async {
        if (!_detecting) {
          _detecting = true;

          final Face? detectedFace = await SelfieCaptureOperation.detectFace(
            screenSize: MediaQuery.of(context).size,
            image: img,
            sensorOrientation: widget.frontCamera.sensorOrientation,
            faceDetector: _faceDetector,
          );

          // Check if the detected face is the same as the previously detected face
          final bool sameFace =
              _detectedFace?.trackingId == detectedFace?.trackingId;

          // Check if the detected face has a valid smiling probability
          final bool validSmilingProbability =
              _detectedFace?.smilingProbability != null;

          // Check if the detected face is smiling with a high probability (98% or more)
          final bool highSmilingProbability =
              _detectedFace!.smilingProbability! >= 0.98;

          if (detectedFace != null &&
              sameFace &&
              validSmilingProbability &&
              highSmilingProbability) {
            // take picture
            selfie = await _camController.takePicture();

            OverlayEntry camFlash = OverlayEntry(
              builder: (context) => Positioned.fill(
                child: Container(
                  color: Colors.white,
                ),
              ),
            );

            Overlay.of(_scaffoldKey.currentContext!).insert(camFlash);

            await Future.delayed(
              const Duration(
                milliseconds: AnimationDuration.quick,
              ),
            );

            camFlash.remove();

            await _camController.stopImageStream();

            Future.delayed(
              const Duration(milliseconds: AnimationDuration.slow),
              () => Navigator.pop(context),
            );

            final img_lib.Image? profilePic =
                await SelfieCaptureOperation.buildProfilePic(
              imagePath: selfie!.path,
              screenSize: screenSize,
            );

            ref.read(setProfilePic)(profilePicture: profilePic);
          }

          _detectedFace = detectedFace;
          _detecting = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _camController.dispose();
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: FutureBuilder<void>(
        future: _camInit,
        builder: (context, snapshot) {
          return Stack(
            children: <Widget>[
              // Transform(
              //   alignment: Alignment.center,
              //   transform: Matrix4.rotationY(pi),
              //   child: Image.file(
              //     File(selfie!.path),
              //     width: MediaQuery.of(context).size.width,
              //     height: MediaQuery.of(context).size.height,
              //     filterQuality: FilterQuality.high,
              //     fit: BoxFit.fill,
              //   ),
              // ),
              if (snapshot.connectionState == ConnectionState.done)
                Positioned.fill(
                  child: AspectRatio(
                    aspectRatio: _camController.value.aspectRatio,
                    child: CameraPreview(_camController),
                  ),
                ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  gradient: snapshot.connectionState == ConnectionState.done
                      ? LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0, 0.2, 0.4],
                          colors: <Color>[
                            Colors.black.withOpacity(OpacitySize.large),
                            Colors.black.withOpacity(OpacitySize.small),
                            Colors.transparent,
                          ],
                        )
                      : null,
                ),
              ),
              Center(
                child: Container(
                  width: SideSize.veryLarge,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(
                      width: _detectedFace == null
                          ? ThicknessSize.medium
                          : ThicknessSize.veryLarge,
                      color: snapshot.connectionState == ConnectionState.done
                          ? _settingFocus
                              ? AppColor.lightYellow
                              : Colors.white
                          : AppColor.moderateGray,
                    ),
                  ),
                ),
              ),
              // Positioned.fill(
              //   child: GestureDetector(
              //     onTapUp: (TapUpDetails details) {
              //       // Convert user's tap location to relative coordinates (between 0 and 1)
              //       final RenderBox box =
              //           context.findRenderObject() as RenderBox;
              //       final Offset localPoint =
              //           box.globalToLocal(details.globalPosition);
              //       final Offset relativePoint = Offset(
              //         localPoint.dx / box.size.width,
              //         localPoint.dy / box.size.height,
              //       );

              //       _camController.setFocusPoint(relativePoint);

              //       setState(() {
              //         _settingFocus = true;
              //       });

              //       _focusTimer?.cancel();

              //       _focusTimer = Timer(const Duration(milliseconds: 2000), () {
              //         setState(() {
              //           _settingFocus = false;
              //         });
              //       });
              //     },
              //     child: const SizedBox(),
              //   ),
              // ),
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(
                      PaddingSize.medium,
                    ),
                    child: Row(
                      children: [
                        UnconstrainedBox(
                          child: SplashButton(
                            horizontalPadding: PaddingSize.verySmall,
                            verticalPadding: PaddingSize.verySmall,
                            buttonColor: Colors.transparent,
                            borderRadius: BorderRadius.circular(
                              CurvatureSize.infinity,
                            ),
                            callbackFunction: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: AnimatedBuilder(
                            animation: _animationController,
                            builder: (ctx, _) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _detectedFace == null
                                        ? 'Scanning facial features '
                                        : 'Smile to take a photo.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                        ),
                                  ),
                                  if (_detectedFace == null)
                                    ...List.generate(
                                      4,
                                      (index) => AnimatedOpacity(
                                        opacity: _animationController.value >
                                                index * 0.25
                                            ? 1.0
                                            : 0.0,
                                        duration: const Duration(
                                            milliseconds:
                                                AnimationDuration.medium),
                                        child: Text(
                                          '.',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                              ),
                                        ),
                                      ),
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
            ],
          );
        },
      ),
    );
  }
}
