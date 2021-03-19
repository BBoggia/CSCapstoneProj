import 'package:flutter/material.dart';

//local files
import 'authentication.dart';

class HomePage extends StatelessWidget {
  Future<void> signOut() async {
    await Authentication().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: signOut,
          child: Text("Log out"),
        ),
      ),
    );
  }
}
