// Authentication.dart final version

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

/*
* This is the authentication API
* Other files refer to this class to handle Google authentication
*/
final fb = FirebaseDatabase.instance;
var hasSignedIn = true;

class Authentication {
  // class declaration and definition
  final FirebaseAuth _firebaseAuth =
      FirebaseAuth.instance; // get the current instance of firebase auth
  final ref = fb.reference();

  Future<void> signInWithGoogle() async {
    // this function handles the request to google for signing in
    final googleSignIn = GoogleSignIn(); // initiate the google sign in
    final googleUser =
        await googleSignIn.signIn(); // wait for the user to sign in
    if (googleUser != null) {
      // check that if user signed in
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        ); // sign in and send data to firebase database
        setupDatabase(ref); // builds the specific users db
        return userCredential.user; // return user data
      }
    } else {
      // if signin does not happen
      throw FirebaseAuthException(
        message: "Sign in aborded by user",
        code: "ERROR_ABORDER_BY_USER",
      );
    }
  }

  Future getCurrentUser() async {
    /*
  * This function returns the current user
  */
    return _firebaseAuth.currentUser;
  }

  getProfileImage() {
    /*
  * This function returns the current user's profile picture widget
  */

    if (_firebaseAuth.currentUser.photoURL != null) {
      // check if the user has a picture
      return new Container(
          // build the container for the image, set sizes
          width: 75.0,
          height: 75.0,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: new NetworkImage(_firebaseAuth.currentUser.photoURL),
              )));
    } else {
      return Image.asset(
          'assets/missingProfilePicture.jpeg'); // is user has no picture use default one from assets
    }
  }

  getProfileName() {
    /*
  * This function retrieves the name of the current user
  */
    if (_firebaseAuth.currentUser.uid != null) {
      // if the current uid exists
      return new Container(
        child: Text(
            _firebaseAuth.currentUser
                .displayName, // creates text widget for username and return it
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold)),
      );
    }
  }

  Future<void> signOut() async {
    /*
  * This function signs out the user
  */
    final googleSignIn = GoogleSignIn(); // get current sign in
    await googleSignIn.signOut(); //sign it out from google
    await _firebaseAuth.signOut(); // sign out from firebase
  }

  setupDatabase(DatabaseReference ref) {
    ref
        .child(_firebaseAuth.currentUser.uid)
        .child("dob")
        .once()
        .then((DataSnapshot data) {
      if (data.value.toString() == "null") {
        // no dob in database
        //print("-----------data.value == null------------------");
        //print(data.value.toString() == "null");

        hasSignedIn = false;
      } else {
        // dob is in database
        hasSignedIn = true;
      }
    });
    //ref.child(_firebaseAuth.currentUser.uid).child("dob");
    print(hasSignedIn);
    if (hasSignedIn) {
      //print("User has signed in before");
    } else {
      //print("first time signing in");
      ref
          .child(_firebaseAuth.currentUser.uid)
          .child("name")
          .set(getProfileName());
      ref.child(_firebaseAuth.currentUser.uid).child("dob").set("");
      ref.child(_firebaseAuth.currentUser.uid).child('family_history').set("");
      ref.child(_firebaseAuth.currentUser.uid).child('sad_alone').set("");
      ref.child(_firebaseAuth.currentUser.uid).child('anxious').set("");
      ref.child(_firebaseAuth.currentUser.uid).child("journals");
    }
  }
}
