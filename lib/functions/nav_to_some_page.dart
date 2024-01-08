import 'package:flutter/material.dart';

void navigateToSomePage({
  required BuildContext context,
  required Widget somePage,
}) {
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (x, y, z) => somePage,
      transitionDuration: const Duration(seconds: 0),
    ),
  );
}
