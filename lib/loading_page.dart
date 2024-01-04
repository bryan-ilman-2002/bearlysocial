import 'package:bearlysocial/constants.dart';
import 'package:flutter/material.dart';

class PreparationPage extends StatelessWidget {
  const PreparationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: const SafeArea(
        child: Center(
          child: SizedBox(
            width: SideSize.small,
            height: SideSize.small,
            child: CircularProgressIndicator(
              strokeWidth: ThicknessSize.veryLarge,
              color: AppColor.heavyGray,
            ),
          ),
        ),
      ),
    );
  }
}