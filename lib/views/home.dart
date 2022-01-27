import 'package:flutter/material.dart';
import 'package:weight_app/Services/auth.dart';
import 'package:weight_app/controllers/controllers.dart';
import 'package:weight_app/widgets/components.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isData = false;

  String wording =
      'In this application, you can enter your weight as time passes and view the weight anytime you want';
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("weight tracking application"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                  controller: nameController,
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
                  controller: ageController,
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
                  controller: weightController,
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
                          nameController.text.trim(),
                          int.parse(ageController.text.trim()),
                          int.parse(weightController.text.trim()),
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
                          nameController.text.trim(),
                          int.parse(ageController.text.trim()),
                          int.parse(weightController.text.trim()),
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
                      {
                        // class method that updates  user data to cloud firestore when button is pressed
                        Auth().deleteUser();
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
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isData = true;
                  });
                },
                child: const Text('View Saved Data'),
              ),
              Container(
                child: _isData ? GetUserData(userId) : null,
              ),
              const SizedBox(height: 60),
              Container(
                margin: const EdgeInsets.only(bottom: 25),
                child: ElevatedButton(
                  onPressed: () async {
                    Auth().signOut();
                  },
                  child: const Text('sign out'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
