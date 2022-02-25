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
      backgroundColor: Colors.transparent,
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
                  if (_formKey.currentState!.validate()) {
                    signIn();

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
                  signInAnon();
                },
                child: const Text('Sign In As Guest'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signIn() async {
    showLoader(context);
    await Auth.signIn(
        _emailController.text.trim(), _passwordController.text.trim());
    Navigator.pop(context);
  }

  void signInAnon() async {
    showLoader(context);
    await Auth.signinAnon();
    Navigator.pop(context);
  }

  @override
  dispose() {
    super.dispose();
  }
}
