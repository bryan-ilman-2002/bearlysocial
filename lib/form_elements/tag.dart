import 'package:bearlysocial/generic/enums/interest.dart';
import 'package:bearlysocial/generic/functions/getters/app_colors.dart';
import 'package:bearlysocial/generic/functions/providers/interest_labels.dart';
import 'package:bearlysocial/generic/functions/providers/lang_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Tag extends ConsumerWidget {
  final String label;
  final dynamic type;

  const Tag({
    super.key,
    required this.label,
    this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => type != null
          ? type == Interest
              ? ref.read(removeInterestLabel)(label)
              : ref.read(removeLangLabel)(label)
          : {},
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: moderateGray,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.circle,
              size: 7.2,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              label,
            ),
          ],
        ),
      ),
    );
  }
}
