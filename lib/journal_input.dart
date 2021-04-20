/*
* This file contains the journal entry page code.
*/

//package improts
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:sentiment_dart/sentiment_dart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

final fb = FirebaseDatabase.instance;
final ref = fb.reference();
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

// This class is today's date and time
class Today {
  DateTime now;
  DateTime date;
  String formattedDate;

  Today() {
    /*
    * This is the constructor of this class
    */
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    formattedDate = formatter.format(now);
  }
  String todaysDate() {
    /*
    * This function returns the formatted date as a string
    */
    return formattedDate;
  }
}

// This is the state for the _SpeechScreenState class

class JournalEntry extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

// This class handles the speech to text input screen
class _SpeechScreenState extends State<JournalEntry> {
  stt.SpeechToText _speech;
  bool _isListening = false;
  final String text = ''; // default text
  final String placeholderText = 'Journal entry...';
  // double _confidence = 1.0; // this is the confidence of the stt, not needed
  var txt = TextEditingController();

  var buttonWidth = 130.0, buttonHeight = 50.0;
  TextStyle buttonFontStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600);

  _SpeechScreenState() {
    /*
    * This is the constructor, setting the text controller of out input box to a default text
    */
    txt.text = text;
  }

  @override
  void initState() {
    /*
    * Initialize the state of the widget
    */
    super.initState();
    _speech = stt.SpeechToText(); // initialize stt variable
  }

  final sentiment = Sentiment(); // initialize sentiment analysys vatiable
  final String constScore = "Your Sentiment score is: ";
  String _score = "";

  @override
  Widget build(BuildContext context) {
    /*
    * This builds the UI of the page
    */
    return Scaffold(
      appBar: AppBar(
        // This is the blue bar at the top of our application
        title: Text(_score), // The score from Sentiment Analysys goes there
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          // This is the STT button trigger
          height: _isListening ? 82 : 78,
          width: _isListening ? 82 : 78,
          child: FloatingActionButton(
              onPressed: _listen,
              backgroundColor: _isListening
                  ? Color.fromARGB(255, 66, 165, 245)
                  : Color.fromARGB(255, 245, 0, 10),
              child: Icon(
                _isListening ? Icons.mic : Icons.mic_none,
                size: 34,
              ))),
      body: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
              child: Column(children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400]),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.fromLTRB(12.0, 18.0, 12.0, 0.0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(12.0, 18.0, 12.0, 12.0),
                    child: Text(
                      "Hi, I hope you're doing well today! 😃",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(12.0, 18.0, 12.0, 22.0),
                    child: Text(
                      "Talk or type your journal entry below then press submit.",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(12.0, 22.0, 12.0, 96.0),
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 24.0),
                        padding: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
                        child: new ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 300.0),
                            child: TextField(
                                decoration: InputDecoration(
                                    labelText: placeholderText,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                maxLines: null,
                                controller: txt))),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: buttonWidth,
                          height: buttonHeight,
                          child: ElevatedButton(
                            // This is a temporary button that clears the entry
                            child: Text("clear", style: buttonFontStyle),
                            onPressed: () => {txt.clear()},
                          ),
                        ),
                        Container(
                          width: buttonWidth,
                          height: buttonHeight,
                          child: ElevatedButton(
                              // This is the button that triggers the sentiment analysys
                              onPressed: () {
                                setState(() {
                                  var sentimentResults = sentiment.analysis(txt
                                      .text); // this is the result from the analysys
                                  print(sentimentResults);
                                  saveToFirebase(
                                      sentimentResults['score'], txt.text);
                                  _score = constScore;
                                  _score += sentimentResults['score']
                                      .toString(); // this is where the score is displayed
                                });
                              },
                              child: Text("Submit", style: buttonFontStyle)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ]))),
    );
  }

  void saveToFirebase(score, text) {
    final DateTime now = DateTime.now();

    final DateFormat nonreadableFormatter = DateFormat('yMdHms');

    ref
        .child(_firebaseAuth.currentUser.uid)
        .child("journals")
        .child(nonreadableFormatter.format(now))
        .child("score")
        .set(score);
    ref
        .child(_firebaseAuth.currentUser.uid)
        .child("journals")
        .child(nonreadableFormatter.format(now))
        .child("journal_entry")
        .set(text);
  }

  void _listen() async {
    /*
    * This is the stt listening and computing the words
    */
    if (txt.text == text) txt.clear(); // set the default text to null
    String tmpTxt = txt.text; // save previous text
    if (!_isListening) {
      // if not listening then set avaliability, send to console the status and or errors
      bool avaliable = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (avaliable) {
        // if avaliable then start listening, listen and then compute the result
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            print(tmpTxt);
            txt.text = tmpTxt + ' ' + val.recognizedWords + ' ';
            // print(val.recognizedWords);
            if (val.hasConfidenceRating && val.confidence > 0) {
              // _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}
