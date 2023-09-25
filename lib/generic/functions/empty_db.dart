import 'package:isar/isar.dart';

Future<void> emptyDatabase() async {
  final Isar? dbConnection = Isar.getInstance();

  await dbConnection?.writeTxn(() async => await dbConnection.clear());
  await dbConnection?.close(deleteFromDisk: true);
}
