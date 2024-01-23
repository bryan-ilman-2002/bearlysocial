import 'dart:convert';

import 'package:bearlysocial/schemas/transaction.dart';
import 'package:hashlib/hashlib.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

/// This class handles all database operations for the application.
class DatabaseOperation {
  /// Creates a connection to the Isar database.
  ///
  /// This function is asynchronous and returns a Future that completes when the connection is established.
  static Future<void> createConnection() async {
    final dir = await getApplicationDocumentsDirectory();

    await Isar.open(
      [TransactionSchema],
      directory: dir.path,
    );
  }

  /// Inserts transactions into the database.
  ///
  /// This function is asynchronous and returns a Future that completes when the transactions are inserted.
  ///
  /// The `pairs` parameter is a map of key-value pairs to be inserted as transactions.
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

  /// Retrieves a transaction value from the database.
  ///
  /// This function is asynchronous and returns a Future that completes with a transaction value.
  ///
  /// The `key` parameter is a key for the transaction value to be retrieved.
  static Future<String> retrieveTransaction({
    required String key,
  }) async {
    final Isar? dbConnection = Isar.getInstance();

    final int hash = crc32code(key);

    final Transaction? transaction = await dbConnection?.transactions.get(hash);
    final String? value = transaction?.value;

    return value ?? '';
  }

  /// Retrieves transaction values from the database.
  ///
  /// This function is asynchronous and returns a Future that completes with a list of transaction values.
  ///
  /// The `keys` parameter is a list of keys for the transaction values to be retrieved.
  static Future<List<String>> retrieveTransactions({
    required List<String> keys,
  }) async {
    final dbConnection = Isar.getInstance();

    final hashes = keys.map(crc32code).toList();
    final txns = await dbConnection?.transactions.getAll(hashes);

    return txns?.map((txn) => txn?.value ?? '').toList() ?? [];
  }

  /// Generates a SHA-256 hash of the input string.
  ///
  /// The `input` parameter is the string to be hashed.
  static String getHash({
    required String input,
  }) {
    var bytes = utf8.encode(input);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Empties the database.
  ///
  /// This function is asynchronous and returns a Future that completes when the database is cleared.
  static Future<void> emptyDatabase() async {
    final Isar? dbConnection = Isar.getInstance();
    await dbConnection?.writeTxn(() async => await dbConnection.clear());
  }
}
