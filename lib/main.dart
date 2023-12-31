import 'package:bearlysocial/database/db_operations.dart';
import 'package:bearlysocial/providers/auth.dart';
import 'package:bearlysocial/loading_page.dart';
import 'package:bearlysocial/views/post_auth/page_manager.dart';
import 'package:bearlysocial/views/pre_auth/page_manager.dart';
import 'package:bearlysocial/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      theme: light,
      darkTheme: dark,
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
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
