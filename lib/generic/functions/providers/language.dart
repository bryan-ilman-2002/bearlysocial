import 'package:bearlysocial/generic/functions/getters/lang_names_in_native_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageStateNotifier extends StateNotifier<TextEditingController> {
  LanguageStateNotifier() : super(TextEditingController());

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }

  String validateSelection() {
    final String lowercaseInput = state.text.toLowerCase();
    final String matchingKey = languageNamesInNativeFormat.keys.firstWhere(
      (key) => key.toLowerCase() == lowercaseInput,
      orElse: () => '',
    );

    return matchingKey;
  }

  void resetController() => state.clear();
}

final languageStateNotifierProvider =
    StateNotifierProvider<LanguageStateNotifier, TextEditingController>(
  (ref) => LanguageStateNotifier(),
);

final selectedLang = Provider((ref) {
  return ref.watch(languageStateNotifierProvider);
});

final validateLangSelection = Provider((ref) {
  return ref.read(languageStateNotifierProvider.notifier).validateSelection;
});

final resetLangController = Provider((ref) {
  return ref.read(languageStateNotifierProvider.notifier).resetController;
});
