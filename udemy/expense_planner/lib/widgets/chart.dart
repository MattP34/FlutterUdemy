import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bars.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double sum = 0.0;
      for (Transaction tx in this.recentTransactions) {
        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) {
          sum += tx.amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay)[0], 'amount': sum};
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (curSum, item) {
      return curSum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 7.0),
      child: Card(
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: groupedTransactionValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    data['day'],
                    data['amount'],
                    (maxSpending > 0.0)
                        ? (data['amount'] as double) / maxSpending
                        : 0),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
