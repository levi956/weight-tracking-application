// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weight_app/widgets/components.dart';

// this class "Auth" deals with firebase authentication instances and communicates
// with SignIn screen for authentication to the Home Screen

var userCred = FirebaseAuth.instance.currentUser;
var userId = userCred!.uid;

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  var userCred = FirebaseAuth.instance.currentUser;

  Future<bool> signIn(String email, String password) async {
    try {
      // ignore: unused_local_variable

      UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      showToast('Signed In');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showErrorToast('User not found');
      } else if (e.code == 'wrong-password') {
        showErrorToast('Invalid password');
      }
    }
    return false;
  }

  Future<void> signinAnon(BuildContext context) async {
    showLoader(context);
    UserCredential user = await FirebaseAuth.instance.signInAnonymously();
    var userCred = FirebaseAuth.instance.currentUser;
    Navigator.pop(context);
    var uid = userCred!.uid;
    if (user != null) {
      print("This is the user credentials " + uid);
      showToast('signed In anonymously');
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

  //read to firestore
  Future<void> addUser(String name, int age, int weight) async {
    // example fo gettig user uid
    var userId = userCred!.uid;
    return users
        .doc(userId.toString())
        .set({'name': name, 'age': age, 'weight': weight, 'id': userId})
        .then((value) => showToast('Sucessfully added'))
        .catchError((error) => showErrorToast('Failed to add user: $error'));
  }

  // update
  Future<void> updateUser(String name, int age, int weight) {
    return users
        .doc(userId.toString())
        .update({'name': name, 'age': age, 'weight': weight})
        .then((value) => showToast('Sucessfully updated'))
        .catchError((error) => showErrorToast('Failed: user not found'));
  }

  Future<void> deleteUser() async {
    return users
        .doc(userId.toString())
        .delete()
        .then((value) => showToast('User data deleted'))
        .catchError((error) => showErrorToast('Failed to delete user: $error'));
  }
}

class GetUserData extends StatelessWidget {
  final String documentId;

  const GetUserData(this.documentId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get().then(
        (DocumentSnapshot snapshot) {
          if (snapshot.exists) {
            print('okay');
          } else {
            print('Document not found');
          }
          return snapshot;
        },
      ),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          showErrorToast('Something went wrong');
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          showErrorToast('User not found');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          final snapshotData = snapshot.data!.data();
          if (snapshotData == null) {
            return Container();
          } else {
            Map<String, dynamic> data = snapshotData as Map<String, dynamic>;
            return ListTile(
              leading: const Icon(Icons.person),
              title: Text("name: ${data['name']}, age: ${data['age']}"),
              subtitle: Text("Your weight is ${data['weight']}"),
            );
          }
        }

        return loader;
      },
    );
  }
}
