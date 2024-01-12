import 'package:bearlysocial/constants/db_key.dart';
import 'package:bearlysocial/constants/endpoint.dart';
import 'package:bearlysocial/schemas/transaction.dart';
import 'package:bearlysocial/utilities/make_request.dart';
import 'package:bearlysocial/utilities/db_operations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

class AuthenticationStateNotifier extends StateNotifier<bool> {
  AuthenticationStateNotifier() : super(false);

  void enterApp() {
    state = true;
  }

  Future<void> exitApp() async {
    await DatabaseOperations.emptyDatabase();
    state = false;
  }

  Future<void> validateToken() async {
    Transaction? txnId, txnToken;

    [txnId, txnToken] = await DatabaseOperations.retrieveTransactions(
      keys: [
        DatabaseKey.id,
        DatabaseKey.token,
      ],
    );

    if (txnId != null && txnToken != null) {
      final Response httpResponse = await makeRequest(
        endpoint: Endpoint.validateToken,
        body: {
          'id': txnId.value,
          'token': txnToken.value,
        },
      );

      if (httpResponse.statusCode == 200) {
        enterApp();
      } else {
        exitApp();
      }
    } else {
      exitApp();
    }
  }
}

final authenticationStateNotifierProvider =
    StateNotifierProvider<AuthenticationStateNotifier, bool>(
  (ref) => AuthenticationStateNotifier(),
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

final validateToken = Provider((ref) {
  return ref.read(authenticationStateNotifierProvider.notifier).validateToken;
});
