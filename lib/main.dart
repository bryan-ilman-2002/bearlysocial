import 'package:bearlysocial/generic/functions/getters/app_colors.dart';
import 'package:bearlysocial/generic/functions/providers/db_access.dart';
import 'package:bearlysocial/specific/page_managers/post_auth_page_manager.dart';
import 'package:bearlysocial/specific/page_managers/pre_auth_page_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerWidget {
  App({super.key});

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
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(getDatabaseAccess)();

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
      home: const PostAuthPageManager(),
    );
  }
}
