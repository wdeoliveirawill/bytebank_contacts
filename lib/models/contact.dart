import 'dart:convert';

class Contact {
  final int id;
  final String name;
  final int accountNumber;

  Contact({this.id = 0, required this.name, required this.accountNumber});

  @override
  String toString() => 'Contact(name: $name, accountNumber: $accountNumber)';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'accountNumber': accountNumber,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'] ?? 0,
      name: map['name'],
      accountNumber: map['accountNumber'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) =>
      Contact.fromMap(json.decode(source));
}
