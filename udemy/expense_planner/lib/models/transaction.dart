import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Transaction {
  final String id, title;
  final double amount;
  final DateTime date;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
  });
}

class TransactionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return null;
  }
}
