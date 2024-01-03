import 'package:flutter/material.dart';

class BouncingScroll extends ScrollBehavior {
  const BouncingScroll();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
