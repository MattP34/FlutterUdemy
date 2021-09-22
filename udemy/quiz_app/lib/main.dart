import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';
import './QAPair.dart';
import './outputScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int _questionIndex = 0;
  int _score = 0;

  static const List<String> _questions = [
    'What is your name?',
    'How old are you?',
    'What is your favorite sport?',
  ];

  static const List<List<String>> _answers = [
    ['Matthew', 'Michael', 'Megan'],
    ['18', '19', '20', '21'],
    ['Running', 'Swimming', 'Soccer'],
  ];

  void answerQuestion(int scoreChange) {
    setState(() {
      _questionIndex++;
      _score += scoreChange;
    });
    print(_questionIndex);
    print("answer choosen");
  }

  void reset() {
    setState(() {
      _questionIndex = 0;
      _score = 0;
    });
    print("reset");
  }

  @override
  Widget build(BuildContext context) {
    if (_questionIndex >= _questions.length) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("MyApp"),
          ),
          body: OutputScreen(_score, reset),
        ),
      );
    }
    List<Function> callBacks = [];
    for (int i = 0; i < _answers[_questionIndex].length; i++) {
      callBacks.add(() => answerQuestion(i + 1));
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("MyApp")),
        body: QAPair(
          _questions[_questionIndex],
          _answers[_questionIndex],
          callBacks,
        ),
      ),
    );
  }
}
