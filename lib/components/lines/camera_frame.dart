part of 'package:bearlysocial/views/post_auth/settings/selfie_screen.dart';

class _CameraFrame extends StatelessWidget {
  final Color color;
  final double gapSize;

  const _CameraFrame({
    required this.color,
    required this.gapSize,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      strokeWidth: ThicknessSize.veryLarge,
      borderType: BorderType.Circle,
      dashPattern: [gapSize],
      strokeCap: StrokeCap.round,
      color: color,
      child: Container(),
    );
  }
}
