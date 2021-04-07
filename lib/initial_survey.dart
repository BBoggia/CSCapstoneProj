import 'package:flutter/material.dart';

class InitialSurveyPage extends StatefulWidget {
  @override
  _InitSurveyPageState createState() => _InitSurveyPageState();
}

var question = [
  'What is your date of birth?',
  "Does your family have a history of mental illness?",
  "How often do you feel sad or alone?",
  "How often do you feel anxious about life?"
];
var answers = [];

class _InitSurveyPageState extends State<InitialSurveyPage> {
  void _incrementCounter() {
    setState(() {
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (ctxt) => new InitialSurveyPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    /*
    * This Builds the looks of our page
    */

    return Material(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("Before We Start"),
          )
        ],
      ),
    );
  }
}
