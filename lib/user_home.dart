import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:horoscope/horoscope_flutter.dart';
import 'journal_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'journal_calendar.dart';

class UserMainPage extends StatefulWidget {
  final DateTime now = DateTime.now();
  final DateFormat readableFormatter = DateFormat('LLL d');

  final DateFormat nonreadableFormatter = DateFormat('yMdHms');

  @override
  _UserMainPageState createState() => _UserMainPageState();
}

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
Future<void> signOut() async {
  /*
  * This function signs out the user
  */
  final googleSignIn = GoogleSignIn(); // get current sign in
  await googleSignIn.signOut(); //sign it out from google
  await _firebaseAuth.signOut(); // sign out from firebase
}

class _UserMainPageState extends State<UserMainPage> {
  @override
  void initState() {
    super.initState();
    getHoroscope();
    //signOut();
  }

  var userName = 'Bob!';
  String selectedZodiac = ZodiacSigns.CAPRICORN;
  String sunsign = "Sunsign", horoscope = "Your Daily Horoscope";
  var buttonWidth = 150.0, buttonHeight = 65.0, buttonBorderRadius = 7.0;
  var leftButtonMargins = EdgeInsets.fromLTRB(0, 0, 10.0, 0),
      rightButtonMargins = EdgeInsets.fromLTRB(10.0, 0, 0, 0);

  void getHoroscope() {
    Horoscope.getDailyHoroscope(selectedZodiac).then((val) {
      if (val != null) {
        setState(() {
          horoscope = val.horoscope;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Home'),
      ),
      body: Container(
        child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 12, 0),
            child: Row(
              children: [
                Container(
                  child: Text(
                    "Welcome, $userName",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                  alignment: Alignment.topLeft,
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[400]),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text(
                    widget.readableFormatter.format(widget.now),
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                  padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                  alignment: Alignment.bottomRight,
                )
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
              padding: EdgeInsets.fromLTRB(0, 8.0, 0, 0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400]),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: RecentSlider()),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400]),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
              margin: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 8.0),
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Container(
                    child: Text("Daily $selectedZodiac Horiscope:",
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        )),
                    margin: EdgeInsets.fromLTRB(8.0, 6.0, 0, 6.0),
                    alignment: Alignment.centerLeft,
                  ),
                  SingleChildScrollView(
                      child: Container(
                    child: Text(horoscope, style: TextStyle(fontSize: 16)),
                  ))
                ],
              )),
          Flexible(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400]),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 60.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: buttonWidth,
                                  height: buttonHeight,
                                  margin: leftButtonMargins,
                                  child: ElevatedButton(
                                      child: Text("New Entry",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 16),
                                          maxLines: 2),
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          buttonBorderRadius)))),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  JournalEntry()),
                                        );
                                      }),
                                ),
                                Container(
                                  width: buttonWidth,
                                  height: buttonHeight,
                                  margin: rightButtonMargins,
                                  child: ElevatedButton(
                                      child: Text("Journal",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 16),
                                          maxLines: 2),
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          buttonBorderRadius)))),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  JournalCalendar()),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0.0, 18.0, 0.0, 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: buttonWidth,
                                  height: buttonHeight,
                                  margin: leftButtonMargins,
                                  child: ElevatedButton(
                                      child: Text("Emotional Analsys",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 16),
                                          maxLines: 2),
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          buttonBorderRadius)))),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserMainPage()),
                                        );
                                      }),
                                ),
                                Container(
                                  width: buttonWidth,
                                  height: buttonHeight,
                                  margin: rightButtonMargins,
                                  child: ElevatedButton(
                                      child: Text("Settings",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 15),
                                          maxLines: 2),
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          buttonBorderRadius)))),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserMainPage()),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                        ]))),
          )
        ]),
      ),
    );
  }
}

// ignore: camel_case_types
class RecentSlider extends StatefulWidget {
  @override
  RecentSliderState createState() => RecentSliderState();
}

// ignore: camel_case_types
class RecentSliderState extends State<RecentSlider> {
  var userList = ['No Entries'];

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Recent Entries',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          height: 120.0,
          margin: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
          child: ListView.builder(
            padding: EdgeInsets.only(left: 10.0),
            scrollDirection: Axis.horizontal,
            itemCount: userList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserMainPage(),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 35.0,
                        backgroundImage: AssetImage('assets/journal.png'),
                      ),
                      SizedBox(height: 6.0),
                      Text(
                        userList[index],
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
