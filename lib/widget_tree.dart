/*
* This handles the switching between pages on the application's launch
*/

// Package imports
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';

// Local imports
import 'login_page.dart';
import 'initial_survey.dart';
import 'user_home.dart';

final fb = FirebaseDatabase.instance;
var hasFilledSurvey = true;

class WidgetTree extends StatelessWidget {
  final ref = fb.reference();
  @override
  Widget build(BuildContext context) {
    // this builds the page
    User user = Provider.of<User>(context);
    if (user == null) {
      // if the user is not logged in already then
      return LoginPage(); // take them to login
    } else {
      // check if dob has been entered
      ref.child(user.uid).child("dob").once().then((DataSnapshot data) {
        if (data.value.toString() == "") {
          // no dob in database

          hasFilledSurvey = false;
        } else {
          // dob is in database

          hasFilledSurvey = true;
        }
      });

      if (hasFilledSurvey) {
        return UserMainPage();
      } else {
        return InitialSurveyPage();
      }
    }
    // take them to the homepage
  }
}
