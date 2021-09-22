import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.tx,
    @required this.index,
    @required this.mq,
    @required Function(int p1) deleteTransaction,
  })  : _deleteTransaction = deleteTransaction,
        super(key: key);

  final int index;
  final Transaction tx;
  final MediaQueryData mq;
  final Function(int p1) _deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 3.0,
        horizontal: 5,
      ),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                child: Text('\$${tx.amount}'),
              ),
            ),
          ),
          title: Text(
            tx.title,
            style: Theme.of(context).textTheme.headline1,
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(tx.date),
            style: Theme.of(context).textTheme.headline2,
          ),
          trailing: mq.size.width > 360
              ? TextButton.icon(
                  label: Text('Delete'),
                  style: Theme.of(context).textButtonTheme.style,
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () => _deleteTransaction(index),
                )
              : IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () => _deleteTransaction(index),
                ),
        ),
      ),
    );
  }
}
