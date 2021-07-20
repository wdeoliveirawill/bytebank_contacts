import 'dart:convert';

import 'package:bytebank_app/models/transaction.dart';
import 'package:http/http.dart';

import '../api.dart';

class TransactionClient {
  static final Map<int, String> _errorMessages = {
    400: "Houve um erro ao enviar a transação",
    401: "Falha de autenticação"
  };

  Future<List<Transaction>> findAll() async {
    final Response resp = await client.get(transactionsUri);
    final List jsonData = jsonDecode(resp.body);
    final List<Transaction> transactions = [];
    for (Map<String, dynamic> transactionJson in jsonData) {
      final transaction = Transaction.fromMap(transactionJson);
      transactions.add(transaction);
    }
    return transactions;
  }

  Future<Transaction> save(
    Transaction transaction,
    String password,
  ) async {
    final resp = await client.post(transactionsUri,
        headers: {
          "Content-type": "application/json",
          "password": password,
        },
        body: transaction.toJson());
    if (resp.statusCode == 200) {
      return Transaction.fromJson(resp.body);
    }
    throw TransactionHttpException(_errorMessages[resp.statusCode] ?? "Error");
  }
}

class TransactionHttpException implements Exception {
  final String message;

  TransactionHttpException(this.message);
}
