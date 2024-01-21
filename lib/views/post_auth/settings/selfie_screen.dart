import 'dart:async';
import 'dart:io';

import 'package:bearlysocial/components/buttons/splash_btn.dart';
import 'package:bearlysocial/components/texts/blinking_dots.dart';
import 'package:bearlysocial/constants/design_tokens.dart';
import 'package:bearlysocial/providers/profile_pic_state.dart';
import 'package:bearlysocial/utilities/custom_painters.dart';
import 'package:bearlysocial/utilities/selfie_capture_operation.dart';
import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart' as img_lib;

part 'package:bearlysocial/components/lines/camera_frame.dart';

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

  Face? _detectedFace;
  bool _detecting = false;

  Timer? _focusTimer;
  bool _settingFocus = false;

  XFile? _selfie;

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
      if (!mounted) return;

      final Size screenSize = MediaQuery.of(context).size;

      _camController.startImageStream((CameraImage img) async {
        if (!_detecting) {
          _detecting = true;

          final Face? detectedFace = await SelfieCaptureOperation.detectFace(
            screenSize: screenSize,
            image: img,
            sensorOrientation: widget.frontCamera.sensorOrientation,
            faceDetector: _faceDetector,
          );

          // Check if the detected face is the same as the previously detected face
          final bool sameFace =
              _detectedFace?.trackingId == detectedFace?.trackingId;

          // Check if the detected face has a valid smiling probability
          final bool validSmilingProbability =
              detectedFace?.smilingProbability != null;

          // Check if the detected face is smiling with a high probability (98% or more)
          final bool highSmilingProbability =
              detectedFace != null && detectedFace.smilingProbability! >= 0.98;

          if (sameFace && validSmilingProbability && highSmilingProbability) {
            Future.delayed(
              const Duration(milliseconds: AnimationDuration.slow),
              () => Navigator.pop(context),
            );

            _selfie = await _camController.takePicture();

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

            XFile? compressedSelfie =
                await FlutterImageCompress.compressAndGetFile(
              _selfie!.path,
              SelfieCaptureOperation.addSuffixToFilePath(
                filePath: _selfie!.path,
                suffix: '-compressed',
              ),
              quality: 16,
            );

            File imageFile = File(compressedSelfie!.path);

            int fileSizeInBytes = imageFile.readAsBytesSync().lengthInBytes;

            double fileSizeInKB = fileSizeInBytes / 1024;

            print("File size: $fileSizeInKB KB");

            final img_lib.Image? profilePic =
                await SelfieCaptureOperation.buildProfilePic(
              imagePath: compressedSelfie.path,
              screenSize: screenSize,
            );

            ref.read(setProfilePic)(profilePicture: profilePic);
          }

          setState(() {
            _detectedFace = detectedFace;
          });
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
    final textStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.normal,
          color: Colors.white,
        );
    return Scaffold(
      key: _scaffoldKey,
      body: FutureBuilder<void>(
        future: _camInit,
        builder: (context, snapshot) {
          return Stack(
            children: <Widget>[
              if (snapshot.connectionState == ConnectionState.done)
                Positioned.fill(
                  child: CameraPreview(_camController),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: PaddingSize.verySmall,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    UnconstrainedBox(
                      child: SplashButton(
                        horizontalPadding: PaddingSize.veryLarge,
                        verticalPadding: PaddingSize.veryLarge,
                        buttonColor: Colors.red,
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
                    BlinkingDots(
                      enabled: _detectedFace == null,
                      controller: _animationController,
                      textStyle: textStyle,
                      leadingText: _detectedFace == null
                          ? 'Scanning facial features '
                          : 'Smile to take a photo.',
                    ),
                    _CameraFrame(
                      color:
                          _settingFocus ? AppColor.lightYellow : Colors.white,
                      gapSize: _detectedFace == null
                          ? MarginSize.veryLarge
                          : MarginSize.verySmall / 10,
                    ),
                    BlinkingDots(
                      enabled: _settingFocus,
                      controller: _animationController,
                      textStyle: textStyle,
                      leadingText: _settingFocus ? 'Adjusting focus ' : '',
                    ),
                  ],
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTapDown: (TapDownDetails details) {
                  final RenderBox renderBox =
                      context.findRenderObject() as RenderBox;

                  final Offset localPoint = renderBox.globalToLocal(
                    details.globalPosition,
                  );
                  final Offset relativePoint = Offset(
                    localPoint.dx / renderBox.size.width,
                    localPoint.dy / renderBox.size.height,
                  );

                  _camController.setFocusPoint(relativePoint);
                  setState(() => _settingFocus = true);

                  _focusTimer?.cancel();
                  _focusTimer = Timer(
                    const Duration(
                      milliseconds: AnimationDuration.slow * 2,
                    ),
                    () => setState(() => _settingFocus = false),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
