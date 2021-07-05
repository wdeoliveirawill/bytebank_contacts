import 'package:bytebank_app/database/app_database.dart';
import 'package:bytebank_app/database/dao/contact_dao.dart';
import 'package:bytebank_app/models/contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController accountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ContactDAO _dao = ContactDAO();
    return Scaffold(
        appBar: AppBar(
          title: Text("New Contact"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Full name",
                ),
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: accountController,
                  decoration: InputDecoration(
                    labelText: "Account number",
                  ),
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      final String name = nameController.text;
                      final int? accountNumber =
                          int.tryParse(accountController.text);
                      if (name.isNotEmpty && accountNumber != null) {
                        final contact =
                            Contact(name: name, accountNumber: accountNumber);
                        _dao.save(contact).then((id) {
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: Text("Create"),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
