import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// this file contains different widget components to aid builder method

// error toast dialog
void showErrorToast(String label) {
  Fluttertoast.showToast(
      msg: label, backgroundColor: Colors.red, gravity: ToastGravity.CENTER);
}

// success toast dialog
showToast(String label) {
  Fluttertoast.showToast(
    msg: label,
    backgroundColor: Colors.green,
    gravity: ToastGravity.CENTER,
  );
}

Color pColor = const Color(0xff4cbb17);

Widget loader = Center(
  child: CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(pColor),
  ),
);

void showLoader(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => const Center(child: CircularProgressIndicator()),
  );
}

class CustomField extends StatelessWidget {
  String hint;
  String isEmpty;
  final TextEditingController controller;
  final TextInputType type;

  CustomField(
      {Key? key,
      required this.controller,
      required this.type,
      required this.isEmpty,
      required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return isEmpty;
        }
      },
      controller: controller,
      keyboardType: type,
      style: const TextStyle(
        color: Colors.black,
        fontFamily: 'Poppins',
      ),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        labelText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class CustomFieldEmail extends StatelessWidget {
  String hint;
  String isEmpty;
  final TextEditingController controller;
  final TextInputType type;

  CustomFieldEmail(
      {Key? key,
      required this.controller,
      required this.type,
      required this.isEmpty,
      required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty || !value.contains("@")) {
          return isEmpty;
        }
      },
      controller: controller,
      keyboardType: type,
      style: const TextStyle(
        color: Colors.black,
        fontFamily: 'Poppins',
      ),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        labelText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
