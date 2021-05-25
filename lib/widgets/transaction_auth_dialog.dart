import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatefulWidget {

  final Function(String password) onConfirm;

  TransactionAuthDialog(
      {@required this.onConfirm});

  @override
  _TransactionAuthDialogState createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Authenticate'),
      content: TextField(
        controller: _password,
        obscureText: true,
        maxLength: 4,
        decoration: InputDecoration(border: OutlineInputBorder()),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 40, letterSpacing: 32),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel')),
        TextButton(
            onPressed: () {
              this.widget.onConfirm(_password.text);
              Navigator.pop(context);
            },
            child: Text('Confirm')),
      ],
    );
  }
}
