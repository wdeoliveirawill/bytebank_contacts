import 'package:bytebank_app/screens/transaction_form.dart';
import 'package:flutter/material.dart';

import 'package:bytebank_app/components/progress.dart';
import 'package:bytebank_app/database/dao/contact_dao.dart';
import 'package:bytebank_app/models/contact.dart';
import 'package:bytebank_app/screens/contacts_form.dart';

class ContactsList extends StatefulWidget {
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ContactDAO _dao = ContactDAO();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transfer"),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: [],
        future: _dao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contact>? contacts = snapshot.data;
              return ListView.builder(
                itemCount: contacts!.length,
                itemBuilder: (context, index) {
                  final Contact contact = contacts[index];
                  return ContactItem(
                    contact: contact,
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TransactionForm(contact),
                        ),
                      );
                    },
                  );
                },
              );
          }
          return Text("Unknown Error");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => ContactForm(),
            ),
          )
              .then((value) {
            setState(() {});
          });
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final Contact contact;
  final Function? onClick;

  const ContactItem({
    Key? key,
    required this.contact,
    @required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick!(),
        title: Text(
          contact.name,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
