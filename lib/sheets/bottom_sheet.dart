import 'package:bearlysocial/constants.dart';
import 'package:bearlysocial/lines/horizontal_line.dart';
import 'package:flutter/material.dart';

class BottomSheet extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget>? closure;

  const BottomSheet({
    super.key,
    required this.title,
    required this.content,
    this.closure,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(
            CurvatureSize.large,
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(
              PaddingSize.medium,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close_rounded,
                  ),
                ),
                const SizedBox(
                  width: WhiteSpaceSize.small,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          const HorizontalLine(),
          Expanded(
            child: SingleChildScrollView(
              // physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(
                PaddingSize.medium,
              ),
              child: content,
            ),
          ),
          if (closure != null) ...[
            const HorizontalLine(),
            Padding(
              padding: const EdgeInsets.all(
                PaddingSize.medium,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: closure as List<Widget>,
              ),
            )
          ],
        ],
      ),
    );
  }
}
