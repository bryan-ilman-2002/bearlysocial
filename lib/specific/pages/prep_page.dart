import 'package:bearlysocial/generic/functions/getters/app_colors.dart';
import 'package:flutter/material.dart';

class PreparationPage extends StatelessWidget {
  const PreparationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              color: heavyGray,
            ),
          ),
        ),
      ),
    );
  }
}
