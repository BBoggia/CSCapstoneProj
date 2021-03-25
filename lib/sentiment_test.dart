import 'package:sentiment_dart/sentiment_dart.dart';
import 'package:flutter/material.dart';
//import 'package:CSCapstoneCourse/user_home.dart';

class UserSentimentPage extends StatefulWidget {
  @override
  _UserSentimentPageState createState() => _UserSentimentPageState();
}

class _UserSentimentPageState extends State<UserSentimentPage> {
  void _incrementCounter() {
    setState(() {
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (ctxt) => new UserSentimentPage()),
      );
    });
  }

  final sentiment = Sentiment();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sentiment Page"),
      ),
      body: Center(
        child: new Column(children: [
          SizedBox(
            height: 30,
          ),
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Your Journal Entry'),
            onSubmitted: (String value) async {
              print(sentiment.analysis(
                value,
              ));
            },
          )
        ]),
      ),
    );
  }
}

class SentimentPage extends StatelessWidget {
  final sentiment = Sentiment();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sentiment Page"),
      ),
      body: Center(
        child: new Column(children: [
          SizedBox(
            height: 30,
          ),
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Your Journal Entry'),
            onSubmitted: (String value) async {
              print(sentiment.analysis(
                value,
              ));
            },
          )
        ]),
      ),
    );
  }
}
