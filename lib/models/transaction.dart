import 'dart:convert';

import 'contact.dart';

class Transaction {
  final double value;
  final Contact contact;

  Transaction({
    required this.value,
    required this.contact,
  });

  @override
  String toString() {
    return 'Transaction{value: $value, contact: $contact}';
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'contact': contact.toMap(),
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      value: map['value'],
      contact: Contact.fromMap(map['contact']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source));
}
