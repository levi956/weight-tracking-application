// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weight_app/widgets/components.dart';

// this class "Auth" deals with firebase authentication instances and communicates
// with SignIn screen for authentication to the Home Screen

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  final user = FirebaseAuth.instance.currentUser;

  Future<bool> signIn(String email, String password) async {
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      showToast('Signed In');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showErrorToast('User not found');
        //print('No user found for that email');
      } else if (e.code == 'wrong-password') {
        showErrorToast('Invalid password');
        //print('Invalid password for that user');
      }
    }
    return false;
  }

  Future<void> signinAnon() async {
    loader;
    UserCredential user = await FirebaseAuth.instance.signInAnonymously();
    if (user != null) {
      showToast('signed In anonymously');
      // TODO: also show a loading indication as connection is loading
      // TODO: catch network timeout exception
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      showToast('Signed out');
    } catch (e) {
      print(e); // TODO: show dialog with error

    }
  }

  // class method that reads data to firestore data base
  Future<void> addUser(String name, int age, int weight) async {
    return users
        .doc(name)
        .set({'name': name, 'age': age, 'weight': weight})
        .then((value) => showToast('Sucessfully added'))
        .catchError((error) => showErrorToast('Failed to add user: $error'));
  }

  Future<void> updateUser(String name, int age, int weight) {
    return users
        .doc(name)
        .update({'name': name, 'age': age, 'weight': weight})
        .then((value) => showToast('Sucessfully updated'))
        .catchError((error) => showErrorToast('Failed: user not found'));
  }

  Future<void> deleteUser(String name, int age, int weight) async {
    return users
        .doc(name)
        .delete()
        .then((value) => showToast('User data deleted'))
        .catchError((error) => showErrorToast('Failed to delete user: $error'));
  }

  Future<FutureBuilder<DocumentSnapshot<Object?>>> getUser(
      String documentId) async {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          showErrorToast('Something went wrong');
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          showErrorToast('User not found');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
              "name: ${data['name']}, Age: ${data['age']}, Weight: ${data['weight']}");
        }

        return loader;
      },
    );
  }
}

class GetUserName extends StatelessWidget {
  final String documentId;

  const GetUserName(this.documentId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          showErrorToast('Something went wrong');
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          showErrorToast('User not found');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              // exception here NO IDEA to catch exception sigh!
              snapshot.data!.data() as Map<String, dynamic>;
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text("name: ${data['name']}, age: ${data['age']}"),
            subtitle: Text("Your weight is ${data['weight']}"),
          );
        }

        return loader;
      },
    );
  }
}
