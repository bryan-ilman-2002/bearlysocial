import 'package:bearlysocial/constants/design_tokens.dart';
import 'package:flutter/material.dart';

final ThemeData light = _appThemeData(
  normalColor: AppColor.moderateGray,
  focusColor: AppColor.heavyGray,
  backgroundColor: Colors.white,
);

final ThemeData dark = _appThemeData(
  normalColor: AppColor.lightGray,
  focusColor: Colors.white,
  backgroundColor: AppColor.heavyGray,
);

ThemeData _appThemeData({
  required Color backgroundColor,
  required Color normalColor,
  required Color focusColor,
}) {
  return ThemeData(
    primaryColor: AppColor.primary,
    dividerColor: normalColor,
    focusColor: focusColor,
    scaffoldBackgroundColor: backgroundColor,
    textTheme: _appTextTheme(
      backgroundColor: backgroundColor,
      normalColor: normalColor,
      focusColor: focusColor,
    ),
    iconTheme: _appIconThemeData(
      iconColor: normalColor,
    ),
    dropdownMenuTheme: _appDropdownMenuThemeData(
      hintStyle: _bodyMedium(
        textColor: normalColor,
      ),
      normalColor: normalColor,
      focusColor: focusColor,
    ),
    splashFactory: InkRipple.splashFactory,
  );
}

TextTheme _appTextTheme({
  required Color backgroundColor,
  required Color normalColor,
  required Color focusColor,
}) {
  return TextTheme(
    titleLarge: _appTextStyle(
      fontSize: TextSize.large,
      fontWeight: FontWeight.bold,
      textColor: focusColor,
    ),
    titleMedium: _appTextStyle(
      fontSize: TextSize.medium,
      fontWeight: FontWeight.bold,
      textColor: backgroundColor,
    ),
    bodyMedium: _bodyMedium(
      textColor: normalColor,
    ),
    bodySmall: _appTextStyle(
      fontSize: TextSize.small,
      fontWeight: FontWeight.normal,
      textColor: AppColor.heavyRed,
    ),
    displayLarge: _appTextStyle(
      fontSize: TextSize.veryLarge,
      fontWeight: FontWeight.bold,
      textColor: focusColor,
    ),
  );
}

TextStyle _appTextStyle({
  required double fontSize,
  required FontWeight fontWeight,
  required Color textColor,
}) {
  return TextStyle(
    overflow: TextOverflow.ellipsis,
    fontFamily: appFontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: textColor,
    letterSpacing: 0.4,
  );
}

TextStyle _bodyMedium({
  required Color textColor,
}) {
  return _appTextStyle(
    fontSize: TextSize.medium,
    fontWeight: FontWeight.normal,
    textColor: textColor,
  );
}

IconThemeData _appIconThemeData({
  required Color iconColor,
}) {
  return IconThemeData(
    size: IconSize.medium,
    color: iconColor,
  );
}

DropdownMenuThemeData _appDropdownMenuThemeData({
  required TextStyle hintStyle,
  required Color normalColor,
  required Color focusColor,
}) {
  return DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: hintStyle,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          CurvatureSize.large,
        ),
        borderSide: BorderSide(
          color: normalColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          CurvatureSize.large,
        ),
        borderSide: BorderSide(
          width: ThicknessSize.large,
          color: focusColor,
        ),
      ),
    ),
    menuStyle: MenuStyle(
      elevation: const MaterialStatePropertyAll(
        ElevationSize.large,
      ),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            CurvatureSize.large,
          ),
          side: BorderSide(
            color: normalColor,
            width: ThicknessSize.verySmall,
          ),
        ),
      ),
      maximumSize: const MaterialStatePropertyAll(
        Size(
          double.infinity,
          SideSize.veryLarge,
        ),
      ),
    ),
  );
}
