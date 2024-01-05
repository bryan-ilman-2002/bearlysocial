import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageLabelsStateNotifier extends StateNotifier<List<String>> {
  LanguageLabelsStateNotifier() : super(<String>[]);

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

final languagelabelsStateNotifierProvider =
    StateNotifierProvider<LanguageLabelsStateNotifier, List<String>>(
  (ref) => LanguageLabelsStateNotifier(),
);

final langLabels = Provider((ref) {
  return ref.watch(languagelabelsStateNotifierProvider);
});

final addLangLabel = Provider((ref) {
  return ref.read(languagelabelsStateNotifierProvider.notifier).addLabel;
});

final removeLangLabel = Provider((ref) {
  return ref.read(languagelabelsStateNotifierProvider.notifier).removeLabel;
});

final resetLangList = Provider((ref) {
  return ref.read(languagelabelsStateNotifierProvider.notifier).resetList;
});
