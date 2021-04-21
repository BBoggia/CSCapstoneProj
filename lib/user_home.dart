import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:horoscope/horoscope_flutter.dart';
import 'journal_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'journal_calendar.dart';
import 'authentication.dart';
import 'package:firebase_database/firebase_database.dart';

final fb = FirebaseDatabase.instance;
final ref = fb.reference();

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

  var dob;
  Future<String> getZodiacSign() async {
    // var db = FirebaseDatabase.instance;

    await ref
        .child(_firebaseAuth.currentUser.uid)
        .child("dob")
        .once()
        .then((value) => dob = (value.value.toString()));

    if (dob == null) {
      dob = "1/1/2000";
    }
    print(dob);
    return dob;
  }

  String convertZodiacSign(String dob) {
    int monthOfBirth;
    int dayOfBirth;

    var tmp = dob.split('/');
    //print(dob);
    monthOfBirth = int.parse(tmp[0]);
    dayOfBirth = int.parse(tmp[1]);

    switch (monthOfBirth) {
      case 1:
        if (dayOfBirth > 20) {
          return ZodiacSigns.CAPRICORN;
        } else {
          return ZodiacSigns.AQUARIUS;
        }
        break;
      case 2:
        if (dayOfBirth > 19) {
          return ZodiacSigns.PISCES;
        } else {
          return ZodiacSigns.AQUARIUS;
        }
        break;
      case 3:
        if (dayOfBirth > 21) {
          return ZodiacSigns.ARIES;
        } else {
          return ZodiacSigns.PISCES;
        }
        break;
      case 4:
        if (dayOfBirth > 20) {
          return ZodiacSigns.TAURUS;
        } else {
          return ZodiacSigns.ARIES;
        }
        break;
      case 5:
        if (dayOfBirth > 21) {
          return ZodiacSigns.GEMINI;
        } else {
          return ZodiacSigns.TAURUS;
        }
        break;
      case 6:
        if (dayOfBirth > 21) {
          return ZodiacSigns.CANCER;
        } else {
          return ZodiacSigns.GEMINI;
        }
        break;
      case 7:
        if (dayOfBirth > 23) {
          return ZodiacSigns.LEO;
        } else {
          return ZodiacSigns.CANCER;
        }
        break;
      case 8:
        if (dayOfBirth > 23) {
          return ZodiacSigns.VIRGO;
        } else {
          return ZodiacSigns.LEO;
        }
        break;
      case 9:
        if (dayOfBirth > 23) {
          return ZodiacSigns.LIBRA;
        } else {
          return ZodiacSigns.VIRGO;
        }
        break;
      case 10:
        if (dayOfBirth > 23) {
          return ZodiacSigns.SCORPIO;
        } else {
          return ZodiacSigns.LIBRA;
        }
        break;
      case 11:
        if (dayOfBirth > 23) {
          return ZodiacSigns.SAGITTARIUS;
        } else {
          return ZodiacSigns.SCORPIO;
        }
        break;
      case 12:
        if (dayOfBirth > 22) {
          return ZodiacSigns.CAPRICORN;
        } else {
          return ZodiacSigns.SAGITTARIUS;
        }
        break;
      default:
        throw Exception("Error, invalid DOB");
        break;
    }
  }

  String userName = Authentication().getProfileName().split(' ')[0];
  //String selectedZodiac = Authentication().GetZodiacSign();
  var convertedSign;
  String sunsign = "Sunsign", horoscope = "Your Daily Horoscope";
  var buttonWidth = 150.0, buttonHeight = 65.0, buttonBorderRadius = 7.0;
  var leftButtonMargins = EdgeInsets.fromLTRB(0, 0, 10.0, 0),
      rightButtonMargins = EdgeInsets.fromLTRB(10.0, 0, 0, 0);

  void getHoroscope() async {
    var sign = await getZodiacSign();
    convertedSign = convertZodiacSign(sign);

    Horoscope.getDailyHoroscope(convertedSign).then((val) {
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
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
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
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
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
                    child: Text("Daily $convertedSign Horoscope:",
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
                                                  borderRadius: BorderRadius.circular(
                                                      buttonBorderRadius)))),
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => JournalEntry()))),
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
                                      child: Text("Logout",
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
                                        Authentication().signOut();
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

Map<dynamic, dynamic> entries;
List dates;

// ignore: camel_case_types
class RecentSlider extends StatefulWidget {
  @override
  RecentSliderState createState() => RecentSliderState();
}

// ignore: camel_case_types
class RecentSliderState extends State<RecentSlider> {
  void getUserJournalEntries() async {
    ref
        .child(_firebaseAuth.currentUser.uid)
        .child("journals")
        .limitToFirst(7)
        .once()
        .then((value) => entries = value.value);
    print(entries);
  }

  // this is for formatting the date of each journal entry
  String format(String date) {
    String tpDate;
    if (date.length == 12) {
      tpDate = date.substring(0, date.length - 5);
    } else {
      tpDate = date.substring(0, date.length - 6);
    }
    String formattedDate = tpDate.substring(0, 4) +
        "/" +
        tpDate.substring(4, 5) +
        "/" +
        tpDate.substring(5, 7);
    return formattedDate;
  }

  var userList = ['No Entries'];
  // count is used when entries == null
  int count;
  Widget build(BuildContext context) {
    if (entries == null) {
      count = 0;
    } else {
      count = entries.length;
    }
    getUserJournalEntries();
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
            itemCount: count,
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
                        format(entries.keys.elementAt(index)),
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
