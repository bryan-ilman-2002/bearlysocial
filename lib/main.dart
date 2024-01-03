import 'package:bearlysocial/generic/functions/providers/auth.dart';
import 'package:bearlysocial/generic/functions/providers/prep.dart';
import 'package:bearlysocial/loading_page.dart';
import 'package:bearlysocial/scroll_behaviors/bouncing_scroll.dart';
import 'package:bearlysocial/post_auth/post_auth_page_manager.dart';
import 'package:bearlysocial/pre_auth/page_manager.dart';
import 'package:bearlysocial/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
  @override
  Widget build(BuildContext context) {
    // if (!ref.watch(prep)) {
    //   ref.read(validateSavedMainAccessNumber)();
    // }

    return MaterialApp(
      title: 'BearlySocial',
      theme: lightTheme,
      darkTheme: darkTheme,
      scrollBehavior: const BouncingScroll(),
      home: const PreAuthPageManager(),
      // home: ref.watch(prep)
      //     ? ref.read(auth)
      //         ? const PostAuthPageManager()
      //         : const PreAuthPageManager()
      //     : const PreparationPage(),
    );
  }
}
