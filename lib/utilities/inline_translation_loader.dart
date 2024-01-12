import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class InlineTranslationLoader extends AssetLoader {
  final Map<String, String> _data = {
    'en': '''
    {}
    ''',
  };

  @override
  Future<Map<String, String>?> load(String path, Locale locale) async {
    return Future(
      () => _data,
    );
  }
}
