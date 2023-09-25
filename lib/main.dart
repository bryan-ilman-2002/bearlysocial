import 'package:bearlysocial/generic/functions/getters/app_colors.dart';
import 'package:bearlysocial/generic/functions/providers/auth.dart';
import 'package:bearlysocial/generic/functions/providers/prep.dart';
import 'package:bearlysocial/specific/pages/prep_page.dart';
import 'package:bearlysocial/specific/page_managers/post_auth_page_manager.dart';
import 'package:bearlysocial/specific/page_managers/pre_auth_page_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  final TextTheme _mukta = TextTheme(
    bodyMedium: TextStyle(
      overflow: TextOverflow.ellipsis,
      fontFamily: 'Mukta',
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: moderateGray,
    ),
  );

  @override
  Widget build(BuildContext context) {
    if (!ref.watch(prep)) ref.read(validateSavedMainAccessNumber)();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      title: 'BearlySocial',
      theme: ThemeData(
        textTheme: _mukta,
        iconTheme: IconThemeData(
          size: 24,
          color: moderateGray,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: heavyGray,
        ),
        splashFactory: InkRipple.splashFactory,
      ),
      home: ref.watch(prep)
          ? ref.read(auth) == true
              ? const PostAuthPageManager()
              : const PreAuthPageManager()
          : const PreparationPage(),
    );
  }
}
