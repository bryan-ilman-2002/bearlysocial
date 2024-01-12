import 'package:bearlysocial/constants/translation_key.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

part 'package:bearlysocial/constants/translations/combined/en_translation.dart';
part 'package:bearlysocial/constants/translations/segments/en_segment_translations.dart';

class InlineTranslationLoader extends AssetLoader {
  final Map<String, dynamic> _translations = {
    'en': _enTranslation,
  };

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) async {
    return Future(
      () => _translations[locale.toLanguageTag()],
    );
  }
}
