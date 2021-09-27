import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;

  final Function(int) _deleteTransaction;

  TransactionList(this._userTransactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    return this._userTransactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: constraints.maxHeight * 0.15,
                    child: FittedBox(
                      child: Text("No transactions added yet!",
                          style: Theme.of(context).textTheme.headline1),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  Image.asset(
                    'assets/images/waiting.png',
                    height: constraints.maxHeight * 0.75,
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: _userTransactions.length,
            itemBuilder: (ctx, index) {
              Transaction tx = _userTransactions[index];
              return TransactionItem(
                  tx: tx,
                  index: index,
                  mq: mq,
                  deleteTransaction: _deleteTransaction);
            },
          );
  }
}
