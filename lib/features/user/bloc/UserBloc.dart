import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meu_atelie/models/Costureira.dart';

import '../../../utils/FirebaseService.dart';

class UserBloc{
  final FirebaseService _firebaseService = FirebaseService();
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();

  TextEditingController get nomeController => _nomeController;

  set nomeController(TextEditingController value) {
    _nomeController = value;
  }

  TextEditingController get senhaController => _senhaController;

  set senhaController(TextEditingController value) {
    _senhaController = value;
  }

  TextEditingController get telefoneController => _telefoneController;

  set telefoneController(TextEditingController value) {
    _telefoneController = value;
  }

  Future<User> updateUser() async {
    return await _firebaseService.updateUser(_nomeController.text, _telefoneController.text);
  }

  Future<User> updatePassword() async {
    return await _firebaseService.updatePassword(_senhaController.text);
  }

  void deleteUser() {
    _firebaseService.deleteUser();
  }
}