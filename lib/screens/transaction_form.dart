import 'dart:async';

import 'package:bytebank_app/components/progress.dart';
import 'package:bytebank_app/components/response_dialog.dart';
import 'package:bytebank_app/components/transaction_auth_dialog.dart';
import 'package:bytebank_app/http/clients/transactions.dart';
import 'package:bytebank_app/models/contact.dart';
import 'package:bytebank_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final String transactionId = Uuid().v4();

  bool _isSending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Progress(),
                ),
                visible: _isSending,
              ),
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text('Transfer'),
                    onPressed: () async {
                      final double value =
                          double.tryParse(_valueController.text) ?? 0;
                      final transactionCreated = Transaction(
                        id: transactionId,
                        value: value,
                        contact: widget.contact,
                      );
                      showDialog(
                        context: context,
                        builder: (contextDialog) => TransactionAuthDialog(
                          onConfirm: (String password) async {
                            setState(() {
                              _isSending = true;
                            });
                            final result = await TransactionClient()
                                .save(transactionCreated, password)
                                .catchError(
                              (e) {
                                showErrorDialog(context, message: e.message);
                              },
                              test: (e) => e is TransactionHttpException,
                            ).catchError(
                              (e) {
                                showErrorDialog(context, message: e.message);
                              },
                              test: (e) => e is TimeoutException,
                            ).catchError(
                              (e) {
                                showErrorDialog(context);
                              },
                              test: (e) => e is Exception,
                            ).whenComplete(() {
                              setState(() {
                                _isSending = false;
                              });
                            });
                            if (result.value > 0) {
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SuccessDialog(
                                        "Transferência realizada com sucesso!");
                                  });
                              Navigator.pop(contextDialog);
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showErrorDialog(
    BuildContext context, {
    String message = "Unknown Error",
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return FailureDialog(message);
        });
  }
}
