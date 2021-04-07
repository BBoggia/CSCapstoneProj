/*
* This handles the switching between pages on the application's launch
*/

// Package imports
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

// Local imports
import 'login_page.dart';
import 'user_home.dart';

class WidgetTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // this builds the page
    User user = Provider.of<User>(context);
    if (user == null) {
      // if the user is not logged in already then
      return LoginPage(); // take them to login
    } // else
    return UserMainPage(); // take them to the homepage
  }
}
