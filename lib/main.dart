import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weight_app/views/home.dart';

import 'views/sign_in.dart';
import 'widgets/components.dart';

/*
TO Do
-- catch network error and timeout exception
-- make sure user is signed out when app state terminates
-- circular progres indicator when connection state is loading
-- study cloud fire documentation
-- don't forget clean code and programming principles
-- think about logic for features (READ & WRITE from firebase cloudstore) 


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

class StarterPage extends StatefulWidget {
  const StarterPage({Key? key}) : super(key: key);

  @override
  State<StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            loader;
          }
          if (snapshot.hasError) {
            showErrorToast('Something went wrong ');
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
