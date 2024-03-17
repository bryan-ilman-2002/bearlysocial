import 'package:bearlysocial/constants/design_tokens.dart';
import 'package:flutter/material.dart';

class OTP_Section extends StatefulWidget {
  const OTP_Section({super.key});

  @override
  State<OTP_Section> createState() => _OTP_SectionState();
}

class _OTP_SectionState extends State<OTP_Section> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Please check your email.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          "We've sent a One-Time Password (OTP) to contact@bearly.social",
          maxLines: 4,
        ),
        Row()
      ],
    );
  }
}
