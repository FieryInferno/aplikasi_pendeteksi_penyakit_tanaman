import 'package:flutter/material.dart';

class UserController {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  UserController({name, phone}) {
    _nameController.text = name;
    _phoneController.text = phone;
  }

  TextEditingController get name => _nameController;
  TextEditingController get phone => _phoneController;
}
