import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/service/webclient/transaction_service.dart';
import 'package:bytebank/widgets/centered_message.dart';
import 'package:bytebank/widgets/progress.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  final TransactionService transferenciaDao = TransactionService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: this.transferenciaDao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Transaction> transctions = snapshot.data;
                if (transctions.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Transaction transaction = transctions[index];
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.monetization_on),
                          title: Text(
                            transaction.value.toString(),
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            transaction.contact.accountNumber.toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: transctions.length,
                  );
                }
              }
              return CenteredMessage("No transactions found");
              break;
          }
          return CenteredMessage(
            "Erro Snapshot Transactions List",
            icon: Icons.warning,
          );
        },
      ),
    );
  }
}
