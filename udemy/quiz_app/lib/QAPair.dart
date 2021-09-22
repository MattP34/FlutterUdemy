import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

class QAPair extends StatelessWidget {
  final String _question;
  final List<String> _answers;
  final List<Function> _callbacks;

  QAPair(this._question, this._answers, this._callbacks);

  @override
  Widget build(BuildContext context) {
    List<Widget> tempChildren = [Question(_question)];
    for (int i = 0; i < _answers.length && i < _callbacks.length; i++) {
      tempChildren.add(Answer(_answers[i], _callbacks[i]));
    }
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: tempChildren,
      ),
    );
  }
}
