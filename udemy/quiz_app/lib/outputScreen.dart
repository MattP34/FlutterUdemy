import 'package:flutter/material.dart';

class OutputScreen extends StatelessWidget {
  final int _score;
  final Function _reset;

  OutputScreen(this._score, this._reset);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "You scored a $_score",
            style: TextStyle(fontSize: 28),
            textAlign: TextAlign.center,
          ),
          TextButton(
              onPressed: _reset,
              child: Text(
                "Reset",
                style: TextStyle(fontSize: 28),
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
