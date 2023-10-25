import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Board extends ConsumerStatefulWidget {
  final List<Widget>? children;
  final WrapAlignment horizontalAlignment;
  final WrapAlignment verticalAlignment;
  final double horizontalSpacing;
  final double verticalSpacing;

  const Board({
    super.key,
    this.children,
    this.horizontalAlignment = WrapAlignment.center,
    this.verticalAlignment = WrapAlignment.center,
    this.horizontalSpacing = 16,
    this.verticalSpacing = 16,
  });

  @override
  ConsumerState<Board> createState() => _BoardState();
}

class _BoardState extends ConsumerState<Board> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: widget.horizontalAlignment,
      runAlignment: widget.verticalAlignment,
      spacing: widget.horizontalSpacing,
      runSpacing: widget.verticalSpacing,
      children: widget.children ?? [],
    );
  }
}
