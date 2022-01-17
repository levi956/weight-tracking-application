import 'package:flutter/material.dart';
import 'package:weight_app/Services/auth.dart';
import 'package:weight_app/widgets/components.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _nameController = TextEditingController();
  final _nameController2 = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();

  bool _isData = false;

  clearTextInput() {
    _nameController.clear();
    _ageController.clear();
    _weightController.clear();
  }

  String wording =
      'In this application, you can enter your weight as time passes and view the weight anytime you want';
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _formKey1 = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("weight tracking application"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Text(wording),
            const SizedBox(height: 50),
            Container(
              margin: const EdgeInsets.all(7),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                controller: _nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  labelText: 'name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(7),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                },
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.format_list_numbered),
                  labelText: 'age',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(7),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your weight';
                  }
                  return null;
                },
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.monitor_weight),
                  labelText: 'weight',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(pColor),
                      );

                      // class method that reads data to cloud firestore when button is pressed
                      Auth().addUser(
                        _nameController.text.trim(),
                        int.parse(_ageController.text.trim()),
                        int.parse(_weightController.text.trim()),
                      );
                      clearTextInput();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Processing Data'),
                        ),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(pColor),
                      );

                      // class method that updates user data to cloud firestore when button is pressed
                      Auth().updateUser(
                        _nameController.text.trim(),
                        int.parse(_ageController.text.trim()),
                        int.parse(_weightController.text.trim()),
                      );
                      clearTextInput();
                      //Auth().getUser('documentId');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Processing Data'),
                        ),
                      );
                    }
                  },
                  child: const Text('Update Weight'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(pColor),
                      );

                      // class method that updates  user data to cloud firestore when button is pressed
                      Auth().deleteUser(
                        _nameController.text.trim(),
                        int.parse(_ageController.text.trim()),
                        int.parse(_weightController.text.trim()),
                      );
                      clearTextInput();
                      //Auth().getUser('documentId');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Processing Data'),
                        ),
                      );
                    }
                  },
                  child: const Text('Delete Weight'),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey1,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name cannot be empty';
                      }
                      return null;
                    },
                    controller: _nameController2,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.monitor_weight),
                      labelText: 'Enter your name to view weight',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey1.currentState!.validate()) {
                        setState(() {
                          _isData = true;
                        });
                      } else {
                        showErrorToast('Something went wrong');
                      }
                    },
                    child: const Text('View Data'),
                  )
                ],
              ),
            ),
            Container(
              child: _isData ? GetUserName(_nameController2.text.trim()) : null,
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(bottom: 25),
              child: ElevatedButton(
                onPressed: Auth().signOut,
                child: const Text('sign out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
