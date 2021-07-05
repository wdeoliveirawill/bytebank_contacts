class Contact {
  final int id;
  final String name;
  final int accountNumber;

  Contact({this.id = 0, required this.name, required this.accountNumber});

  @override
  String toString() => 'Contact(name: $name, accountNumber: $accountNumber)';
}
