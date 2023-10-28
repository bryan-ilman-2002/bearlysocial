import 'package:flutter/material.dart';

BoxShadow get heavyShadow {
  return BoxShadow(
    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.16),
    blurRadius: 4,
    offset: const Offset(0, 4),
  );
}

BoxShadow get moderateShadow {
  return BoxShadow(
    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.16),
    blurRadius: 8,
    offset: const Offset(0, 4),
  );
}

BoxShadow get lightShadow {
  return BoxShadow(
    color: Colors.grey.withOpacity(0.4),
    blurRadius: 16,
    spreadRadius: 2,
  );
}
