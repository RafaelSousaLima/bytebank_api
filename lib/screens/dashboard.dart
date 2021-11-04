import 'package:bytebank/models/name.dart';
import 'package:bytebank/screens/name.dart';
import 'package:bytebank/screens/transactions_list.dart';
import 'package:bytebank/widgets/container.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'contacts_list.dart';

class DashboardContainer extends BlocContainer {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit("Rafael"),
      child: DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // CUIDADO PARA NÃO MISTURAR LÓGICAS DE OBSERVER COM INTERFACE
        title: BlocBuilder<NameCubit, String>(
          builder: (context, state) => Text('Welcome $state'),
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                _FutureItem(
                  'Transfer',
                  Icons.monetization_on,
                  onClick: () => _showContactsList(context),
                ),
                _FutureItem(
                  'Transaction feed',
                  Icons.description,
                  onClick: () => _showTransactionsList(context),
                ),
                _FutureItem(
                  'Change name',
                  Icons.person_outline,
                  onClick: () => _showChangeName(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showChangeName(BuildContext blocContext) {
    if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
      FirebaseCrashlytics.instance.crash();
    }
    Navigator.of(blocContext).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: BlocProvider.of<NameCubit>(blocContext),
          child: NameContainer(),
        ),
        // builder: (context) => NameContainer(),
      ),
    );
  }

  void _showContactsList(BuildContext context) {
    if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
      FirebaseCrashlytics.instance.crash();
    }
    push(context, ContactsListContainer());
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => ContactsList(),
    //   ),
    // );
  }

  void _showTransactionsList(BuildContext context) {
    if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
      FirebaseCrashlytics.instance.crash();
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TransactionsList(),
      ),
    );
  }
}

class _FutureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  _FutureItem(this.name, this.icon, {@required this.onClick})
      : assert(icon != null),
        assert(onClick != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: 100,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
