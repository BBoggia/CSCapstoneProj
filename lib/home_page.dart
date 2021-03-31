import 'package:CSCapstoneCourse/journal_input.dart';
import 'package:flutter/material.dart';
import 'package:CSCapstoneCourse/user_home.dart';

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
        child: new Column(children: [
          SizedBox(
            height: 30,
          ),
          Authentication().getProfileImage(),
          Text('Hello, '),
          Authentication().getProfileName(),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: signOut,
            child: Text("Log out"),
          ),
          ElevatedButton(
              child: Text("User Main Page"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserMainPage()),
                );
              }),
          ElevatedButton(
              child: Text("User Entry"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JournalEntry()),
                );
              })
        ]),
      ),
    );
  }
}
