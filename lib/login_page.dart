import 'package:flutter/material.dart';

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
        child: RaisedButton(
          onPressed: signInWithGoogle,
          child: Text("Login With Google"),
        ),
      ),
    );
  }
}
