/*
* This is the first page that loads when the app is initialized
*/
// Package imports
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

// Local imports
import 'widget_tree.dart';

// firebase
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ensure widgets are initialized
  await Firebase.initializeApp(); // initialze firebase
  runApp(MyApp()); // start running our app
}

class MyApp extends StatelessWidget {
  // this class starts our app
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider.value(value: FirebaseAuth.instance.authStateChanges()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
            WidgetTree(), // this will always default to Widget tree, which redirects users to login or homepage
      ),
    );
  }
}
