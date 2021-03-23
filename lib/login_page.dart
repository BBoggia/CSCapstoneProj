import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'authentication.dart';

class LoginPage extends StatelessWidget {
  Future<void> signInWithGoogle() async {
    await Authentication().signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(alignment: Alignment.center, children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Mental Health Journal',
            style: TextStyle(height: 5, fontSize: 25),
          ),
          Image.asset(
            'assets/journal.png',
            height: 150,
            width: 150,
          ),
          SignInButton(
            Buttons.GoogleDark,
            onPressed: signInWithGoogle,
          ),
        ],
      )
    ])));
  }
}
