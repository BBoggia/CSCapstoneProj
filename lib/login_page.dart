/*
* This is the sign in page, if the user isnt signed in already, this is the page where they will sign in.
*/

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'authentication.dart';

// This class is the login page itself
class LoginPage extends StatelessWidget {
  Future<void> signInWithGoogle() async {
    /*
    * This function calls on the authentication functions
    */
    await Authentication().signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    /*
    * The build function builds the looks of the page
    */

    return Scaffold(
        body: Center(
            child: Stack(alignment: Alignment.center, children: <Widget>[
      Column(
        // this aligns everything in a column at the center of the page
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            // this is the title
            'Mental Health Journal',
            style: TextStyle(height: 5, fontSize: 25),
          ),
          Image.asset(
            // this is the widget for the logo of the app
            'assets/journal.png',
            height: 150,
            width: 150,
          ),
          SignInButton(
            // this is the google sign in button
            Buttons.GoogleDark,
            onPressed:
                signInWithGoogle, // this calls on the sign in function from this class
          ),
        ],
      )
    ])));
  }
}
