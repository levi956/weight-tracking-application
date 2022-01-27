import 'package:flutter/material.dart';

// Text editing Controllers
final nameController = TextEditingController();
final nameController2 = TextEditingController();
final ageController = TextEditingController();
final weightController = TextEditingController();

clearTextInput() {
  nameController.clear();
  ageController.clear();
  weightController.clear();
}
