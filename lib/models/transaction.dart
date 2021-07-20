import 'dart:convert';

import 'contact.dart';

class Transaction {
  final String id;
  final double value;
  final Contact contact;

  Transaction({
    required this.id,
    required this.value,
    required this.contact,
  });

  @override
  String toString() {
    return 'Transaction{id: $id, value: $value, contact: $contact}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
      'contact': contact.toMap(),
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      value: map['value'],
      contact: Contact.fromMap(map['contact']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source));
}
