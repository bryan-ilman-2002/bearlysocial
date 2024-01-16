import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart' as img_lib;

class SelfieCaptureOperation {
  static Future<Face?> detectFace({
    required Size screenSize,
    required int sensorOrientation,
    required CameraImage image,
    required FaceDetector faceDetector,
  }) async {
    final Uint8List completeBytes = extractBytes(
      image: image,
    );
    final InputImageMetadata imgMetadata = buildImageMetadata(
      image: image,
      sensorOrientation: sensorOrientation,
    );
    final InputImage preppedImage = InputImage.fromBytes(
      bytes: completeBytes,
      metadata: imgMetadata,
    );
    final List<Face> detectedFaces = await faceDetector.processImage(
      preppedImage,
    );

    return findCenteredFace(
      faces: detectedFaces,
      image: image,
      screenSize: screenSize,
    );
  }

  static Uint8List extractBytes({
    required CameraImage image,
  }) {
    final WriteBuffer bytesInBuffer = WriteBuffer();

    for (final plane in image.planes) {
      bytesInBuffer.putUint8List(plane.bytes);
    }

    return bytesInBuffer.done().buffer.asUint8List();
  }

  static InputImageMetadata buildImageMetadata({
    required CameraImage image,
    required int sensorOrientation,
  }) {
    final Size imgSize = Size(
      image.width.toDouble(),
      image.height.toDouble(),
    );

    final InputImageRotation imgRot =
        InputImageRotationValue.fromRawValue(sensorOrientation) ??
            InputImageRotation.rotation0deg;

    final InputImageFormat imgFormat =
        InputImageFormatValue.fromRawValue(image.format.raw) ??
            InputImageFormat.nv21;

    return InputImageMetadata(
      size: imgSize,
      rotation: imgRot,
      format: imgFormat,
      bytesPerRow: image.planes[0].bytesPerRow,
    );
  }

  static Face? findCenteredFace({
    required List<Face> faces,
    required CameraImage image,
    required Size screenSize,
  }) {
    final screenCenter = Offset(screenSize.width / 2, screenSize.height / 2);

    for (final Face face in faces) {
      final Rect facialBoundingBox = normalizeBoundingBox(
        rect: face.boundingBox,
        imageSize: Size(
          image.width.toDouble(),
          image.height.toDouble(),
        ),
        screenSize: screenSize,
      );

      final Offset faceCenter = Offset(
        facialBoundingBox.left + facialBoundingBox.width / 2,
        facialBoundingBox.top + facialBoundingBox.height / 2,
      );

      final bool faceIsCentered = validateFacePosition(
        screenCenter: screenCenter,
        faceCenter: faceCenter,
        face: face,
      );

      if (faceIsCentered) {
        return Face(
          trackingId: face.trackingId,
          boundingBox: facialBoundingBox,
          landmarks: face.landmarks,
          contours: face.contours,
          smilingProbability: face.smilingProbability,
        );
      }
    }

    return null;
  }

  static Rect normalizeBoundingBox({
    required Rect rect,
    required Size imageSize,
    required Size screenSize,
  }) {
    final double scaleX = screenSize.width / imageSize.height;
    final double scaleY = screenSize.height / imageSize.width;

    final double scale = scaleX > scaleY ? scaleX : scaleY;
    final Offset offset = Offset(
      (screenSize.width - imageSize.height * scale) / 2,
      (screenSize.height - imageSize.width * scale) / 2,
    );

    return Rect.fromLTWH(
      rect.left * scale + offset.dx,
      rect.top * scale + offset.dy,
      rect.width * scale,
      rect.height * scale,
    );
  }

  static bool validateFacePosition({
    required Offset screenCenter,
    required Offset faceCenter,
    required Face face,
  }) {
    final double headTilt = face.headEulerAngleX ?? double.infinity;
    final double headTurn = face.headEulerAngleY ?? double.infinity;
    final double headRotation = face.headEulerAngleZ ?? double.infinity;

    final double dxDifference = (screenCenter.dx - faceCenter.dx).abs();
    final double dyDifference = (screenCenter.dy - faceCenter.dy).abs();

    return dxDifference <= 40 &&
        dyDifference <= 40 &&
        headTilt.abs() <= 20 &&
        headTurn.abs() <= 20 &&
        headRotation.abs() <= 20;
  }

  static Future<img_lib.Image?> buildProfilePic({
    required String imagePath,
    required Size screenSize,
  }) async {
    final img_lib.Image? image = img_lib.decodeImage(
      await File(imagePath).readAsBytes(),
    );

    if (image != null) {
      final int newWidth = screenSize.width.toInt();
      final int newHeight = screenSize.height.toInt();
      final img_lib.Image stretchedImage = img_lib.copyResize(
        image,
        width: newWidth,
        height: newHeight,
      );

      final int size = min(stretchedImage.width, stretchedImage.height) - 20;
      final int offsetX = (stretchedImage.width - size) ~/ 2;
      final int offsetY = (stretchedImage.height - size) ~/ 2;

      final img_lib.Image croppedImage = img_lib.copyCrop(
        stretchedImage,
        x: offsetX,
        y: offsetY,
        width: size,
        height: size,
      );

      img_lib.Image flippedImage = img_lib.flip(
        croppedImage,
        direction: img_lib.FlipDirection.horizontal,
      );

      return flippedImage;
    } else {
      return image;
    }
  }
}
