import 'package:bearlysocial/database/db_operations.dart';
import 'package:bearlysocial/providers/auth.dart';
import 'package:bearlysocial/loading_page.dart';
import 'package:bearlysocial/scroll_behaviors/bouncing_scroll.dart';
import 'package:bearlysocial/post_auth/page_manager.dart';
import 'package:bearlysocial/pre_auth/page_manager.dart';
import 'package:bearlysocial/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseOperations.createConnection();

  runApp(
    const ProviderScope(child: App()),
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
    return FutureBuilder(
      future: ref.read(validateToken)(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingPage();
        } else {
          return MaterialApp(
            title: 'BearlySocial',
            theme: lightTheme,
            darkTheme: darkTheme,
            scrollBehavior: const BouncingScroll(),
            home: ref.read(auth)
                ? const PostAuthPageManager()
                : const PreAuthPageManager(),
          );
        }
      },
    );
  }
}
