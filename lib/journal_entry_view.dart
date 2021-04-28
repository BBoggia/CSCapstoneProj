import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class JournalEntryViewer extends StatefulWidget {
  @override
  _JournalEntryViewerState createState() => _JournalEntryViewerState();
  var currentJournal = "1/24/2021";
  var sentimentScore = 1.0;
  String fullEntryTxt = 'Placeholder';

  JournalEntryViewer(
      {Key key, @required this.fullEntryTxt, this.sentimentScore})
      : super(key: key);

  double scoreConversionFunction(score) {
    return (score / 10.0 + 0.5);
  }
}

class _JournalEntryViewerState extends State<JournalEntryViewer> {
  @override
  Widget build(BuildContext context) {
    /*
    * This Builds the looks of our page
    */

    return Scaffold(
      appBar: AppBar(
        title: Text('Journal Entry'),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(12.0, 22.0, 12.0, 96.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 50.0),
            child: Text(widget.currentJournal,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
          ),
          Row(
            children: [
              Spacer(),
              Container(
                child: SizedBox(
                  height: 125,
                  width: 125,
                  child: CircularProgressIndicator(
                    value:
                        widget.scoreConversionFunction(widget.sentimentScore),
                  ),
                ),
              ),
              Spacer()
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 18.0, 0, 50.0),
            child: Row(
              children: [
                Spacer(),
                Text('Sentiment Score: ' + (widget.sentimentScore).toString(),
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                Spacer()
              ],
            ),
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400]),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              margin: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 8.0),
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                  child: Container(
                child:
                    Text(widget.fullEntryTxt, style: TextStyle(fontSize: 16)),
              )))
        ]),
      ),
    );
  }
}
