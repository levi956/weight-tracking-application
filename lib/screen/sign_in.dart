import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weight_app/Services/auth.dart';
import 'package:weight_app/widgets/components.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Welcome to the weight application'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 100,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains("@")) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
              decoration: InputDecoration(
                hoverColor: Colors.green[600],
                prefixIcon: const Icon(Icons.person),
                labelText: 'email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              controller: _passwordController,
              obscureText: true,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.password),
                labelText: 'password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(pColor),
                    );

                    Auth().signIn(_emailController.text.trim(),
                        _passwordController.text.trim());
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    /*ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Processing Data'),
                      ),
                    ); */
                  }
                },
                child: const Text('sign in'),
              ),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                onPressed: () {
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(pColor),
                  );
                  Auth().signinAnon();
                },
                child: const Text('Sign In As Guest'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
