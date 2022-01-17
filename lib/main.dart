import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weight_app/screen/home.dart';

import 'screen/sign_in.dart';
import 'widgets/components.dart';

/*
TO Do
-- catch network error and timeout exception
-- make sure user is signed out when app state terminates
-- circular progres indicator when connection state is loading
-- study cloud fire documentation
-- don't forget clean code and programming principles
-- think about logic for features (READ & WRITE from firebase cloudstore)
-- show success snackbar or indicator when user data is added 


*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Weight Application',
      home: StarterPage(),
    );
  }
}

class StarterPage extends StatelessWidget {
  const StarterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loader;
          }
          if (snapshot.hasError) {
            return loader;
          }
          if (snapshot.hasData) {
            return const Home();
          } else {
            return const SignIn();
          }
        },
      ),
    );
  }
}
