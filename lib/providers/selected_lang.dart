import 'package:bearlysocial/generic/functions/getters/native_lang_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageStateNotifier extends StateNotifier<TextEditingController> {
  LanguageStateNotifier() : super(TextEditingController());

  String validateSelection() =>
      nativeLanguageNames.containsKey(state.text) ? state.text : '';

  void resetController() => state.clear();
}

final languageStateNotifierProvider =
    StateNotifierProvider<LanguageStateNotifier, TextEditingController>(
  (ref) => LanguageStateNotifier(),
);

final selectedLang = Provider((ref) {
  return ref.watch(languageStateNotifierProvider);
});

final validateSelectedLang = Provider((ref) {
  return ref.read(languageStateNotifierProvider.notifier).validateSelection;
});

final resetLangController = Provider((ref) {
  return ref.read(languageStateNotifierProvider.notifier).resetController;
});
