import 'package:bearlysocial/generic/enums/api.dart';
import 'package:bearlysocial/generic/enums/db_key.dart';
import 'package:bearlysocial/generic/functions/getters/app_colors.dart';
import 'package:bearlysocial/generic/functions/make_request.dart';
import 'package:bearlysocial/generic/functions/providers/auth.dart';
import 'package:bearlysocial/generic/functions/providers/db_access.dart';
import 'package:bearlysocial/generic/pages/loading.dart';
import 'package:bearlysocial/generic/schemas/extra.dart';
import 'package:bearlysocial/specific/page_managers/post_auth_page_manager.dart';
import 'package:bearlysocial/specific/page_managers/pre_auth_page_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hashlib/hashlib.dart';
import 'package:http/http.dart';
import 'package:isar/isar.dart';

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
  bool appIsLoaded = false;

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
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadApp(ref);
    });
  }

  void _loadApp(WidgetRef ref) async {
    final Isar? db = await ref.watch(initDatabaseAccess)();

    final Extra? idDB = await db?.extras.get(crc32code(DatabaseKey.id.string));
    final Extra? mainAccessNumberDB =
        await db?.extras.get(crc32code(DatabaseKey.mainAccessNumber.string));

    if (idDB != null && mainAccessNumberDB != null) {
      final Response httpResponse = await makeRequest(
        API.checkMainAccessNumber,
        {'id': idDB.value, 'mainAccessNumber': mainAccessNumberDB.value},
      );

      httpResponse.statusCode == 200
          ? ref.watch(enterApp)()
          : ref.watch(exitApp)();
    } else {
      ref.watch(exitApp)();
    }

    setState(() {
      appIsLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(initDatabaseAccess)();

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
      home: appIsLoaded
          ? ref.watch(auth) == true
              ? const PostAuthPageManager()
              : const PreAuthPageManager()
          : const LoadingPage(),
    );
  }
}
