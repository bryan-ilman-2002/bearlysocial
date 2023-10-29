import 'package:flutter_riverpod/flutter_riverpod.dart';

class InterestLabelsStateNotifier extends StateNotifier<List<String>> {
  InterestLabelsStateNotifier() : super(<String>[]);

  void addLabel(String matchingKey) {
    if (matchingKey != '' && !state.contains(matchingKey)) {
      if (state.length >= 4) {
        state.removeAt(0);
      }

      state = <String>[...state, matchingKey];
    }
  }

  void removeLabel(String matchingKey) {
    if (matchingKey != '' && state.contains(matchingKey)) {
      state.remove(matchingKey);
      state = [...state];
    }
  }

  void resetList() => state = <String>[];
}

final interestlabelsStateNotifierProvider =
    StateNotifierProvider<InterestLabelsStateNotifier, List<String>>(
  (ref) => InterestLabelsStateNotifier(),
);

final interestLabels = Provider((ref) {
  return ref.watch(interestlabelsStateNotifierProvider);
});

final addInterestLabel = Provider((ref) {
  return ref.read(interestlabelsStateNotifierProvider.notifier).addLabel;
});

final removeInterestLabel = Provider((ref) {
  return ref.read(interestlabelsStateNotifierProvider.notifier).removeLabel;
});

final resetInterestList = Provider((ref) {
  return ref.read(interestlabelsStateNotifierProvider.notifier).resetList;
});
