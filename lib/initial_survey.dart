import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class InitialSurveyPage extends StatefulWidget {
  @override
  _InitSurveyPageState createState() => _InitSurveyPageState();

  var question = [
    'What is your date of birth?',
    "Does your family have a history of mental illness?",
    "How often do you feel sad or alone?",
    "How often do you feel anxious about life?"
  ];
}

class _InitSurveyPageState extends State<InitialSurveyPage> {
  var answers = [];

  @override
  Widget build(BuildContext context) {
    /*
    * This Builds the looks of our page
    */

    return Scaffold(
      appBar: AppBar(
        title: Text('Initial Survey'),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(12.0, 22.0, 12.0, 96.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            child: Row(
              children: [
                Flexible(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(0.0, 4.0, 8.0, 24.0),
                      child: new ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 300.0),
                          child: TextField(
                              decoration: InputDecoration(
                                  labelText: 'First Name',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              maxLines: 1))),
                ),
                Flexible(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(4.0, 8.0, 0.0, 24.0),
                      child: new ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 300.0),
                          child: TextField(
                              decoration: InputDecoration(
                                  labelText: 'Last Name',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              maxLines: 1))),
                ),
                new Expanded(
                  child: new TabBarView(
                      // Restrict scroll by user
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        // Sign In View
                        new Center(
                          child: new Text("SignIn"),
                        ),
                        // Sign Up View
                        new Center(
                          child: new Text("SignUp"),
                        )
                      ]),
                )
              ],
            ),
          ),
          Row(
            children: [
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2025),
                    );
                  },
                  child: Text('Date of Birth'),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
