import 'dart:convert';

import 'package:bytebank_app/models/transaction.dart';
import 'package:http/http.dart';

import '../api.dart';

class TransactionClient {
  Future<List<Transaction>> findAll() async {
    final Response resp = await client.get(transactionsUri).timeout(
          Duration(
            seconds: 60,
          ),
        );
    final List jsonData = jsonDecode(resp.body);
    final List<Transaction> transactions = [];
    for (Map<String, dynamic> transactionJson in jsonData) {
      final transaction = Transaction.fromMap(transactionJson);
      transactions.add(transaction);
    }
    return transactions;
  }

  Future<Transaction> save(Transaction transaction) async {
    final resp = await client.post(transactionsUri,
        headers: {
          "Content-type": "application/json",
          "password": "1000",
        },
        body: transaction.toJson());
    return Transaction.fromJson(resp.body);
  }
}
