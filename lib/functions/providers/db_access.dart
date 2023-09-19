import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseAccessStateNotifier extends StateNotifier<Isar?> {
  DatabaseAccessStateNotifier() : super(null);

  Future<Isar?> getDatabaseAccess() async {
    final dir = await getApplicationDocumentsDirectory();

    state = await Isar.open(
      [],
      directory: dir.path,
    );

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

final getDatabaseAccess = Provider((ref) {
  return ref
      .read(databaseAccessStateNotifierProvider.notifier)
      .getDatabaseAccess;
});
