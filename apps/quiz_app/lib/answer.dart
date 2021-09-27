import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String _answerText;
  final Function _selectHandler;

  Answer(this._answerText, this._selectHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: ElevatedButton(
        onPressed: _selectHandler,
        child: Text(_answerText),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue)),
      ),
    );
  }
}
