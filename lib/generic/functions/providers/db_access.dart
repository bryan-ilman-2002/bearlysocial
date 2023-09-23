import 'package:bearlysocial/generic/schemas/extra.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseAccessStateNotifier extends StateNotifier<Isar?> {
  DatabaseAccessStateNotifier() : super(null);

  Future<Isar?> getDatabaseAccess() async {
    final isar = Isar.getInstance();

    if (isar == null || !isar.isOpen) {
      final dir = await getApplicationDocumentsDirectory();

      state = await Isar.open(
        [
          ExtraSchema,
        ],
        directory: dir.path,
      );
    } else {
      state = isar;
    }

    return state;
  }
}

final databaseAccessStateNotifierProvider =
    StateNotifierProvider<DatabaseAccessStateNotifier, Isar?>(
  (ref) => DatabaseAccessStateNotifier(),
);

final databaseAccess = Provider((ref) {
  return ref.watch(databaseAccessStateNotifierProvider);
});

final initDatabaseAccess = Provider((ref) {
  return ref
      .read(databaseAccessStateNotifierProvider.notifier)
      .getDatabaseAccess;
});
