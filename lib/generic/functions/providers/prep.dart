import 'package:bearlysocial/api_call/enums/endpoint.dart';
import 'package:bearlysocial/database/db_key.dart';
import 'package:bearlysocial/generic/functions/empty_db.dart';
import 'package:bearlysocial/api_call/make_request.dart';
import 'package:bearlysocial/generic/functions/providers/auth.dart';
// import 'package:bearlysocial/generic/schemas/extra.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hashlib/hashlib.dart';
import 'package:http/http.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class PreparationStateNotifier extends StateNotifier<bool> {
  PreparationStateNotifier(this._providerRef) : super(false);
  final Ref _providerRef;

  Future<void> _createDatabaseConnection() async {
    // final Isar? dbConnection = Isar.getInstance();

    // if (dbConnection == null || !dbConnection.isOpen) {
    //   final dir = await getApplicationDocumentsDirectory();
    //   await Isar.open([ExtraSchema], directory: dir.path);
    // }
  }

  void validateSavedMainAccessNumber() async {
    // await _createDatabaseConnection();

    // final Isar? dbConnection = Isar.getInstance();

    // final Extra? savedId =
    //     await dbConnection?.extras.get(crc32code(DatabaseKey.id.string));
    // final Extra? savedMainAccessNumber = await dbConnection?.extras
    //     .get(crc32code(DatabaseKey.mainAccessNumber.string));

    // if (savedId != null && savedMainAccessNumber != null) {
    //   final Response httpResponse = await makeRequest(
    //     API.checkMainAccessNumber,
    //     {
    //       'id': savedId.value,
    //       'mainAccessNumber': savedMainAccessNumber.value,
    //     },
    //   );

    //   if (httpResponse.statusCode == 200) {
    //     _providerRef.read(setAuth)(true);
    //   } else {
    //     await emptyDatabase();
    //     _providerRef.read(setAuth)(false);
    //   }
    // } else {
    //   await emptyDatabase();
    //   _providerRef.read(setAuth)(false);
    // }

    // await _createDatabaseConnection();
    // state = true;
  }

  void prepApp() {
    state = false;
  }
}

final preparationStateNotifierProvider =
    StateNotifierProvider<PreparationStateNotifier, bool>(
  (ref) => PreparationStateNotifier(ref),
);

final prep = Provider((ref) {
  return ref.watch(preparationStateNotifierProvider);
});

final validateSavedMainAccessNumber = Provider((ref) {
  return ref
      .read(preparationStateNotifierProvider.notifier)
      .validateSavedMainAccessNumber;
});

final prepApp = Provider((ref) {
  return ref.read(preparationStateNotifierProvider.notifier).prepApp;
});
