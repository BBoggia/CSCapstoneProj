// Authentication.dart final version

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:horoscope/horoscope_flutter.dart';
import 'package:firebase_database/firebase_database.dart';

final fb = FirebaseDatabase.instance;
final ref = fb.reference();

/*
* This is the authentication API
* Other files refer to this class to handle Google authentication
*/
var hasSignedIn = false;

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
      return _firebaseAuth.currentUser.displayName;
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

  String dob;

  String GetZodiacSign() {
    // var db = FirebaseDatabase.instance;

    ref
        .child(_firebaseAuth.currentUser.uid)
        .child("dob")
        .once()
        .then((value) => dob = value.value);

    print("this is the dob: $dob");

    if (dob == null) {
      dob = "1/1/2000";
    }

    int monthOfBirth;
    int dayOfBirth;

    var tmp = dob.split('/');
    monthOfBirth = int.parse(tmp[0]);
    dayOfBirth = int.parse(tmp[1]);

    switch (monthOfBirth) {
      case 1:
        if (dayOfBirth > 20) {
          return ZodiacSigns.CAPRICORN;
        } else {
          return ZodiacSigns.AQUARIUS;
        }
        break;
      case 2:
        if (dayOfBirth > 19) {
          return ZodiacSigns.PISCES;
        } else {
          return ZodiacSigns.AQUARIUS;
        }
        break;
      case 3:
        if (dayOfBirth > 21) {
          return ZodiacSigns.ARIES;
        } else {
          return ZodiacSigns.PISCES;
        }
        break;
      case 4:
        if (dayOfBirth > 20) {
          return ZodiacSigns.TAURUS;
        } else {
          return ZodiacSigns.ARIES;
        }
        break;
      case 5:
        if (dayOfBirth > 21) {
          return ZodiacSigns.GEMINI;
        } else {
          return ZodiacSigns.TAURUS;
        }
        break;
      case 6:
        if (dayOfBirth > 21) {
          return ZodiacSigns.CANCER;
        } else {
          return ZodiacSigns.GEMINI;
        }
        break;
      case 7:
        if (dayOfBirth > 23) {
          return ZodiacSigns.LEO;
        } else {
          return ZodiacSigns.CANCER;
        }
        break;
      case 8:
        if (dayOfBirth > 23) {
          return ZodiacSigns.VIRGO;
        } else {
          return ZodiacSigns.LEO;
        }
        break;
      case 9:
        if (dayOfBirth > 23) {
          return ZodiacSigns.LIBRA;
        } else {
          return ZodiacSigns.VIRGO;
        }
        break;
      case 10:
        if (dayOfBirth > 23) {
          return ZodiacSigns.SCORPIO;
        } else {
          return ZodiacSigns.LIBRA;
        }
        break;
      case 11:
        if (dayOfBirth > 23) {
          return ZodiacSigns.SAGITTARIUS;
        } else {
          return ZodiacSigns.SCORPIO;
        }
        break;
      case 12:
        if (dayOfBirth > 22) {
          return ZodiacSigns.CAPRICORN;
        } else {
          return ZodiacSigns.SAGITTARIUS;
        }
        break;
      default:
        throw Exception("Error, invalid DOB");
        break;
    }
  }

  setupDatabase(DatabaseReference ref) {
    ref
        .child(_firebaseAuth.currentUser.uid)
        .child("dob")
        .once()
        .then((DataSnapshot data) {
      if (data.value.toString() == "null") {
        // no dob in database

        hasSignedIn = false;
      } else {
        // dob is in database

        hasSignedIn = true;
      }
    });
    if (hasSignedIn) {
      print("User has signed in before");
    } else {
      print("first time signing in");
      ref
          .child(_firebaseAuth.currentUser.uid)
          .child("name")
          .set(getProfileName());
      ref.child(_firebaseAuth.currentUser.uid).child("dob").set("3/23/99");
      ref.child(_firebaseAuth.currentUser.uid).child('family_history').set("");
      ref.child(_firebaseAuth.currentUser.uid).child('sad_alone').set("");
      ref.child(_firebaseAuth.currentUser.uid).child('anxious').set("");
    }
  }
}
