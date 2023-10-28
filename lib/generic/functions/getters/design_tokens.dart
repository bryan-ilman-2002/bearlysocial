import 'package:flutter/material.dart';

class AppFontSize {
  static const double small = 10.0;
  static const double medium = 14.0;
  static const double large = 18.0;
}

class AppIconSize {
  static const double medium = 24.0;
}

class AppPadding {
  static const double small = 8.0;
  static const double medium = 20.0;
}

class AppSpacing {
  static const double extraSmall = 2.0;
  static const double verySmall = 4.0;
  static const double small = 10.0;
  static const double medium = 24.0;
  static const double large = 32.0;
  static const double veryLarge = 48.0;
  static const double extraLarge = 80.0;
}

class AppDimension {
  static const double small = 8.0;
  static const double medium = 20.0;
}

class AppBorderRadius {
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 128.0;
}

class AppColor {
  static const Color heavyGray = Color.fromRGBO(64, 64, 64, 4);
  static const Color moderateGray = Color.fromRGBO(120, 120, 120, 4);
  static const Color lightGray = Color.fromRGBO(236, 236, 236, 4);

  static const Color moderateRed = Color.fromARGB(255, 180, 4, 4);
  static const Color lightRed = Color.fromARGB(255, 255, 226, 224);

  static const Color lightYellow = Color.fromRGBO(255, 252, 156, 4);

  static const Color moderateBlue = Color.fromRGBO(14, 108, 192, 4);
}

class AppShadow {
  static final BoxShadow heavyShadow = BoxShadow(
    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.16),
    blurRadius: 4,
    offset: const Offset(0, 4),
  );

  static final BoxShadow moderateShadow = BoxShadow(
    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.16),
    blurRadius: 8,
    offset: const Offset(0, 4),
  );

  static final BoxShadow lightShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.4),
    blurRadius: 16,
    spreadRadius: 2,
  );
}
