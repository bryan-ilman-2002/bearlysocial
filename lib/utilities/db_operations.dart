import 'dart:convert';

import 'package:bearlysocial/schemas/transaction.dart';
import 'package:hashlib/hashlib.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseOperations {
  static Future<void> createConnection() async {
    final dir = await getApplicationDocumentsDirectory();

    await Isar.open(
      [TransactionSchema],
      directory: dir.path,
    );
  }

  static Future<void> insertTransactions({
    required Map<String, String> pairs,
  }) async {
    final Isar? dbConnection = Isar.getInstance();

    List<Transaction> transactions = pairs.entries.map((entry) {
      return Transaction()
        ..key = crc32code(entry.key)
        ..value = entry.value;
    }).toList();

    await dbConnection?.writeTxn(() async {
      await dbConnection.transactions.putAll(
        transactions,
      );
    });
  }

  static Future<List<Transaction?>> retrieveTransactions({
    required List<String> keys,
  }) async {
    final Isar? dbConnection = Isar.getInstance();

    final List<int> hashes = keys.map(crc32code).toList();
    final List<Transaction?>? values =
        await dbConnection?.transactions.getAll(hashes);

    return [...?values];
  }

  static String getHash({
    required String input,
  }) {
    var bytes = utf8.encode(input);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  static Future<void> emptyDatabase() async {
    final Isar? dbConnection = Isar.getInstance();
    await dbConnection?.writeTxn(() async => await dbConnection.clear());
  }
}
