// This file contains the homepage we are currently using to route to the pages. This is temporary and it's being used just for testing purposes.

// import packages
import 'package:CSCapstoneCourse/journal_input.dart';
import 'package:flutter/material.dart';
import 'package:CSCapstoneCourse/user_home.dart';

//local files
import 'authentication.dart';

class HomePage extends StatelessWidget {
  /*
  * This is the signout function calling the authentication class
  */
  Future<void> signOut() async {
    await Authentication().signOut();
  }

  @override
  Widget build(BuildContext context) {
    /*
    * This Builds the looks of our page
    */
    return Scaffold(
      // Top of the app
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: new Column(children: [
          SizedBox(
            height: 30,
          ),
          Authentication()
              .getProfileImage(), // This returns the profile image of the user
          Text('Hello, '),
          Authentication()
              .getProfileName(), // This returns the name of the current user
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            // this is the button that triggers the logout
            onPressed: signOut,
            child: Text("Log out"),
          ),
          ElevatedButton(
              // this button reroutes us to the user homepage, which will become out permanent homepage
              child: Text("User Main Page"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserMainPage()),
                );
              }),
          ElevatedButton(
              // This button reroutes us to the user entry page, which handles the user input
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
