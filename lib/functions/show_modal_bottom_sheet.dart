import 'package:flutter/material.dart';

void showFullHeightModalBottomSheet({
  required BuildContext context,
  required Widget body,
}) {
  _showModalBottomSheet(
    context: context,
    fullHeight: true,
    body: body,
  );
}

void showHalfHeightModalBottomSheet({
  required BuildContext context,
  required Widget body,
}) {
  _showModalBottomSheet(
    context: context,
    fullHeight: false,
    body: body,
  );
}

void _showModalBottomSheet({
  required BuildContext context,
  required bool fullHeight,
  required Widget body,
}) {
  showModalBottomSheet(
    context: context,
    useSafeArea: true,
    isScrollControlled: fullHeight,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return body;
    },
  );
}
