import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );
        return userCredential.user;
      }
    } else {
      throw FirebaseAuthException(
        message: "Sign in aborded by user",
        code: "ERROR_ABORDER_BY_USER",
      );
    }
  }

  Future getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  getProfileImage() {
    if (_firebaseAuth.currentUser.photoURL != null) {
      return new Container(
          width: 75.0,
          height: 75.0,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: new NetworkImage(_firebaseAuth.currentUser.photoURL),
              )));
    } else {
      return Image.asset('assets/missingProfilePicture.jpeg');
    }
  }

  getProfileName() {
    if (_firebaseAuth.currentUser.uid != null) {
      return new Container(
        child: Text(_firebaseAuth.currentUser.displayName,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold)),
      );
    }
  }

  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
