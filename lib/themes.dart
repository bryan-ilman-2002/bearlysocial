import 'package:bearlysocial/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

TextTheme _appTextTheme({
  required Color defaultColor,
  required Color focusColor,
}) {
  return TextTheme(
    bodyMedium: _appTextStyle(
      fontSize: TextSize.medium,
      fontWeight: FontWeight.normal,
      textColor: defaultColor,
    ),
    labelSmall: _appTextStyle(
      fontSize: TextSize.small,
      fontWeight: FontWeight.normal,
      textColor: AppColor.heavyRed,
    ),
    labelMedium: _appTextStyle(
      fontSize: TextSize.large,
      fontWeight: FontWeight.normal,
      textColor: defaultColor,
    ),
    displaySmall: _appTextStyle(
      fontSize: TextSize.medium,
      fontWeight: FontWeight.bold,
      textColor: focusColor,
    ),
    displayLarge: _appTextStyle(
      fontSize: TextSize.veryLarge,
      fontWeight: FontWeight.bold,
      textColor: focusColor,
    ),
  );
}

IconThemeData _appIconThemeData({
  required Color defaultColor,
}) {
  return IconThemeData(
    size: IconSize.medium,
    color: defaultColor,
  );
}

DropdownMenuThemeData _appDropdownMenuThemeData({
  required TextStyle hintStyle,
  required Color defaultColor,
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
          color: defaultColor,
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
            color: defaultColor,
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

ThemeData _appThemeData({
  required Brightness statusBarIconBrightness,
  required Color backgroundColor,
  required Color defaultColor,
  required Color focusColor,
}) {
  return ThemeData(
    primaryColor: defaultColor,
    focusColor: focusColor,
    backgroundColor: backgroundColor,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: statusBarIconBrightness,
      ),
    ),
    textTheme: _appTextTheme(
      defaultColor: defaultColor,
      focusColor: focusColor,
    ),
    iconTheme: _appIconThemeData(
      defaultColor: defaultColor,
    ),
    dropdownMenuTheme: _appDropdownMenuThemeData(
      hintStyle: _appTextStyle(
        fontSize: TextSize.medium,
        fontWeight: FontWeight.normal,
        textColor: defaultColor,
      ),
      defaultColor: defaultColor,
      focusColor: focusColor,
    ),
    splashFactory: InkRipple.splashFactory,
  );
}

final ThemeData lightTheme = _appThemeData(
  statusBarIconBrightness: Brightness.dark,
  defaultColor: AppColor.moderateGray,
  focusColor: AppColor.heavyGray,
  backgroundColor: Colors.white,
);

final ThemeData darkTheme = _appThemeData(
  statusBarIconBrightness: Brightness.light,
  defaultColor: AppColor.lightGray,
  focusColor: Colors.white,
  backgroundColor: AppColor.heavyGray,
);
