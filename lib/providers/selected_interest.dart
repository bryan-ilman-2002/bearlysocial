import 'package:bearlysocial/generic/functions/getters/interests.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InterestStateNotifier extends StateNotifier<TextEditingController> {
  InterestStateNotifier() : super(TextEditingController());

  String validateSelection() =>
      interests.containsKey(state.text) ? state.text : '';

  void resetController() => state.clear();
}

final interestStateNotifierProvider =
    StateNotifierProvider<InterestStateNotifier, TextEditingController>(
  (ref) => InterestStateNotifier(),
);

final selectedInterest = Provider((ref) {
  return ref.watch(interestStateNotifierProvider);
});

final validateSelectedInterest = Provider((ref) {
  return ref.read(interestStateNotifierProvider.notifier).validateSelection;
});

final resetInterestController = Provider((ref) {
  return ref.read(interestStateNotifierProvider.notifier).resetController;
});
