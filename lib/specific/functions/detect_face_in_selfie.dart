import 'package:bearlysocial/specific/functions/transform_rect.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

Future<Face?> detectFaceInSelfie({
  required Size screenSize,
  required int sensorOrientation,
  required CameraImage selfie,
  required FaceDetector uprightFaceDetector,
}) async {
  final WriteBuffer bytesInBuffer = WriteBuffer();
  for (final Plane plane in selfie.planes) {
    bytesInBuffer.putUint8List(plane.bytes);
  }
  final Uint8List completeBytes = bytesInBuffer.done().buffer.asUint8List();

  final Size selfieSize = Size(
    selfie.width.toDouble(),
    selfie.height.toDouble(),
  );

  final InputImageRotation selfieRotation =
      InputImageRotationValue.fromRawValue(sensorOrientation) ??
          InputImageRotation.rotation0deg;

  final InputImageFormat selfieFormat =
      InputImageFormatValue.fromRawValue(selfie.format.raw) ??
          InputImageFormat.nv21;

  final InputImageMetadata selfieMetadata = InputImageMetadata(
    size: selfieSize,
    rotation: selfieRotation,
    format: selfieFormat,
    bytesPerRow: selfie.planes[0].bytesPerRow,
  );

  final InputImage selfieInBytes = InputImage.fromBytes(
    bytes: completeBytes,
    metadata: selfieMetadata,
  );

  final List<Face> detectedFaces =
      await uprightFaceDetector.processImage(selfieInBytes);

  Face? largestDetectedFace;
  double largestArea = 0.0;

  for (final Face detectedFace in detectedFaces) {
    final Rect transformedRect = transformRectangle(
      rect: detectedFace.boundingBox,
      imageSize: selfieSize,
      previewSize: screenSize,
    );

    final double area = transformedRect.width * transformedRect.height;
    if (area > largestArea) {
      largestArea = area;
      largestDetectedFace = Face(
        boundingBox: transformedRect,
        landmarks: detectedFace.landmarks,
        contours: detectedFace.contours,
        headEulerAngleY: detectedFace.headEulerAngleY,
        headEulerAngleZ: detectedFace.headEulerAngleZ,
        leftEyeOpenProbability: detectedFace.leftEyeOpenProbability,
        rightEyeOpenProbability: detectedFace.rightEyeOpenProbability,
        smilingProbability: detectedFace.smilingProbability,
        trackingId: detectedFace.trackingId,
      );
    }
  }

  return largestDetectedFace;
}
