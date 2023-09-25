import 'package:bearlysocial/generic/functions/empty_db.dart';
import 'package:bearlysocial/generic/functions/providers/prep.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationStateNotifier extends StateNotifier<bool> {
  AuthenticationStateNotifier(this._providerRef) : super(false);
  final Ref _providerRef;

  void enterApp() {
    state = true;
    _providerRef.read(prepApp)();
  }

  void exitApp() async {
    await emptyDatabase();

    state = false;
    _providerRef.read(prepApp)();
  }

  void setAuth(bool auth) {
    state = auth;
  }
}

final authenticationStateNotifierProvider =
    StateNotifierProvider<AuthenticationStateNotifier, bool>(
  (ref) => AuthenticationStateNotifier(ref),
);

final auth = Provider((ref) {
  return ref.watch(authenticationStateNotifierProvider);
});

final enterApp = Provider((ref) {
  return ref.read(authenticationStateNotifierProvider.notifier).enterApp;
});

final exitApp = Provider((ref) {
  return ref.read(authenticationStateNotifierProvider.notifier).exitApp;
});

final setAuth = Provider((ref) {
  return ref.read(authenticationStateNotifierProvider.notifier).setAuth;
});
