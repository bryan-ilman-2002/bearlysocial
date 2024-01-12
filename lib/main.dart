import 'package:bearlysocial/providers/auth_state.dart';
import 'package:bearlysocial/themes.dart';
import 'package:bearlysocial/utilities/db_operations.dart';
import 'package:bearlysocial/utilities/inline_translation_loader.dart';
import 'package:bearlysocial/views/loading_page.dart';
import 'package:bearlysocial/views/post_auth/post_auth_page_manager.dart';
import 'package:bearlysocial/views/pre_auth/pre_auth_page_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await DatabaseOperations.createConnection();

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en'),
        ],
        path: 'assets/l10n',
        fallbackLocale: const Locale('en'),
        assetLoader: InlineTranslationLoader(),
        child: const App(),
      ),
    ),
  );
}

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();

    ref.read(validateToken)().then((_) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      title: 'BearlySocial',
      theme: buildAppThemeData(lightMode: true),
      darkTheme: buildAppThemeData(lightMode: false),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      scrollBehavior: const _BouncingScroll(),
      home: _loading
          ? const LoadingPage()
          : ref.watch(auth)
              ? const PostAuthPageManager()
              : const PreAuthPageManager(),
    );
  }
}

class _BouncingScroll extends ScrollBehavior {
  const _BouncingScroll();

  @override
  ScrollPhysics getScrollPhysics(_) => const BouncingScrollPhysics();
}
