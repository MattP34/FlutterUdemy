import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';

import './widgets/chart.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                color: Colors.black,
              ),
              headline2: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 14,
                color: Colors.grey[750],
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline1: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
        ),
        buttonColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.purple),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
/*    Transaction(
      id: 't1',
      title: "New Shoes",
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
        id: 't2',
        title: "Weekly Groceries",
        amount: 16.53,
        date: DateTime.now()),*/
  ];

  bool _chartToggle = true;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    Transaction tx = Transaction(
      id: "t${this._userTransactions.length + 1}",
      title: title,
      amount: amount,
      date: date,
    );
    setState(() {
      this._userTransactions.add(tx);
    });
    print(this._userTransactions);
  }

  void _deleteTransaction(int index) {
    setState(() {
      this._userTransactions.removeAt(index);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
      title: Text(
        'Personal Expenses',
        style: Theme.of(context).appBarTheme.textTheme.headline1,
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: <Widget>[
          if (isLandscape)
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.vertical) *
                  .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Show Chart",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(width: 10),
                  Switch(
                    value: this._chartToggle,
                    onChanged: (val) {
                      setState(() {
                        this._chartToggle = val;
                      });
                    },
                  ),
                ],
              ),
            ),
          if (!isLandscape || _chartToggle)
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.vertical) *
                  (isLandscape ? 0.8 : 0.3),
              child: Chart(this._recentTransactions),
            ),
          if (!isLandscape || !_chartToggle)
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.vertical) *
                  (isLandscape ? 0.9 : 0.6),
              child: TransactionList(_userTransactions, _deleteTransaction),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
/*children: <Widget>[
          Container(
            height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.vertical) *
                .3,
            child: Chart(this._recentTransactions),
          ),
          Container(
            height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.vertical) *
                .7,
            child: TransactionList(_userTransactions, _deleteTransaction),
          ),
        ]*/