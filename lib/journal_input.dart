import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Today {
  DateTime now;
  DateTime date;
  String formattedDate;

  Today() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    formattedDate = formatter.format(now);
  }
  String todaysDate() {
    return formattedDate;
  }
}

class JournalEntry extends StatelessWidget {
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(children: [
        SizedBox(
          height: 50.0,
        ),
        Text("Journal Entry for: " + Today().formattedDate,
            style: TextStyle(fontSize: 25)),
        TextField(
          keyboardType: TextInputType.multiline,
          minLines: 5,
          maxLines: null,
          obscureText: false,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Journal Entry',
          ),
        ),
      ]),
    );
  }
}
