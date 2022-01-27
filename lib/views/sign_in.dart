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
            CustomFieldEmail(
              controller: _emailController,
              type: TextInputType.text,
              isEmpty: 'Pleae enter a valid email',
              hint: 'Email',
            ),
            const SizedBox(
              height: 20,
            ),
            CustomField(
                isEmpty: 'Please enter your password',
                controller: _passwordController,
                type: TextInputType.text,
                hint: 'Password'),
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
                  Auth().signinAnon(context);
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
