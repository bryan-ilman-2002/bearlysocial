import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

Future<img.Image?> profilePictureMaker({
  required String imagePath,
  required Size screenSize,
}) async {
  final img.Image? image = img.decodeImage(await File(imagePath).readAsBytes());

  if (image != null) {
    final int newWidth = screenSize.width.toInt();
    final int newHeight = screenSize.height.toInt();
    final img.Image stretchedImage = img.copyResize(
      image,
      width: newWidth,
      height: newHeight,
    );

    final int size = min(stretchedImage.width, stretchedImage.height) - 20;
    final int offsetX = (stretchedImage.width - size) ~/ 2;
    final int offsetY = (stretchedImage.height - size) ~/ 2;

    final img.Image croppedImage = img.copyCrop(
      stretchedImage,
      x: offsetX,
      y: offsetY,
      width: size,
      height: size,
    );

    img.Image flippedImage = img.flip(
      croppedImage,
      direction: img.FlipDirection.horizontal,
    );

    return flippedImage;
  } else {
    return image;
  }
}
