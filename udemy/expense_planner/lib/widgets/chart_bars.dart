import 'package:expense_planner/widgets/chart.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount, spendingPct;

  ChartBar(this.label, this.spendingAmount, this.spendingPct);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(children: <Widget>[
          Container(
            height: constraints.maxHeight * 0.15,
            width: constraints.maxWidth * 0.8,
            child: FittedBox(
              child: Text('\$${this.spendingAmount.toStringAsFixed(2)}'),
            ),
          ),
          SizedBox(height: constraints.maxHeight * .05),
          Container(
            height: constraints.maxHeight * 0.6,
            width: constraints.maxWidth * 0.6,
            child: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: this.spendingPct,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ]),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            height: constraints.maxHeight * 0.15,
            width: constraints.maxWidth * 0.8,
            child: FittedBox(
                child: Text(
              label,
              style: Theme.of(context).textTheme.headline1,
            )),
          ),
        ]);
      },
    );
  }
}
