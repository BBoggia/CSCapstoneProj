/*
* This file contains the journal entry page code.
*/

//package improts
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:sentiment_dart/sentiment_dart.dart';

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
  final String text = 'Press the button and start speaking'; // default text
  // double _confidence = 1.0; // this is the confidence of the stt, not needed
  var txt = TextEditingController();

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
          height: _isListening ? 50 : 47,
          width: _isListening ? 50 : 47,
          child: FloatingActionButton(
              onPressed: _listen,
              backgroundColor: _isListening
                  ? Color.fromARGB(255, 66, 165, 245)
                  : Color.fromARGB(255, 245, 0, 10),
              child: Icon(_isListening ? Icons.mic : Icons.mic_none))),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(children: [
          Container(
            // This is the container for the text input box
            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
            child: TextField(
              minLines: 8,
              maxLines: 200,
              controller: txt,
            ),
          ),
          ElevatedButton(
            // This is a temporary button that clears the entry
            child: Text("clear"),
            onPressed: () => {txt.clear()},
          ),
          ElevatedButton(
              // This is the button that triggers the sentiment analysys
              onPressed: () {
                setState(() {
                  var sentimentResults = sentiment.analysis(
                      txt.text); // this is the result from the analysys
                  print(sentimentResults);
                  _score = constScore;
                  _score += sentimentResults['score']
                      .toString(); // this is where the score is displayed
                });
              },
              child: Text("Get Score")),
        ]),
      ),
    );
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
