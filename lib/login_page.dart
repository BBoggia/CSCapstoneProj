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
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Center(
        child: Column(children: [
          Text("Sentiment Analisys Application Logo Goes Here"),
          SizedBox(
            height: 200,
          ),
          SignInButton(
            Buttons.GoogleDark,
            onPressed: signInWithGoogle,
          ),
        ]),
      ),
    );
  }
}
