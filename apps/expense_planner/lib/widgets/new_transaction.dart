import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function(String, double, DateTime) _addNewTransaction;

  NewTransaction(this._addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  void submitData() {
    final String enteredTitle = this._titleController.text;
    final String enteredAmount = this._amountController.text;

    final double amount = double.tryParse(enteredAmount);

    if (enteredTitle.isEmpty ||
        enteredAmount.isEmpty ||
        amount == null ||
        amount <= 0 ||
        this._selectedDate == null) {
      print("error parsing");
      return;
      //TODO error message
    }

    this.widget._addNewTransaction(
        this._titleController.text, amount, this._selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        this._selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: mq.viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                controller: this._titleController,
                decoration: InputDecoration(labelText: "Title"),
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: this._amountController,
                decoration: InputDecoration(labelText: "Amount"),
                onSubmitted: (_) => submitData(),
              ),
              Row(children: <Widget>[
                Text(this._selectedDate == null
                    ? 'No Date Chosen'
                    : DateFormat.yMMMd().format(this._selectedDate)),
                TextButton(
                  child: Text(
                    'Choose Date',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  onPressed: _presentDatePicker,
                )
              ]),
              ElevatedButton(
                onPressed: submitData,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).accentColor),
                ),
                child: Text(
                  "Create New Entry",
                  style: TextStyle(
                    color: Theme.of(context).buttonColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
