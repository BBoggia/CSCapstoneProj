import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

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

class JournalEntry extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<JournalEntry> {
  stt.SpeechToText _speech;
  bool _isListening = false;
  String text = 'Press the button and start speaking';
  double _confidence = 1.0;
  var txt = TextEditingController();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('confidence is: ${(_confidence * 100.0).toStringAsFixed(1)}%'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none)),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
            child: TextField(
              minLines: 8,
              maxLines: 200,
              controller: txt,
            ),
          ),
          ElevatedButton(
            child: Text("clear"),
            onPressed: () => {txt.clear()},
          ),
        ]),
      ),
    );
  }

  void _listen() async {
    String tmpTxt = txt.text;
    if (!_isListening) {
      bool avaliable = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (avaliable) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            print(tmpTxt);
            txt.text = tmpTxt + ' ' + val.recognizedWords + ' ';
            // print(val.recognizedWords);
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
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
