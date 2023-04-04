import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meu_atelie/models/Costureira.dart';

import '../../../utils/FirebaseService.dart';

class UserBloc{
  final FirebaseService _firebaseService = FirebaseService();
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _confirmarSenhaController = TextEditingController();
  TextEditingController _senhaAntigaController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  TextEditingController get confirmarSenhaController => _confirmarSenhaController;

  set confirmarSenhaController(TextEditingController value) {
    _confirmarSenhaController = value;
  }

  TextEditingController get senhaAntigaController => _senhaAntigaController;

  set senhaAntigaController(TextEditingController value) {
    _senhaAntigaController = value;
  }

  TextEditingController get emailController => _emailController;

  set emailController(TextEditingController value) {
    _emailController = value;
  }

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

  Future<bool> updatePassword() async {
    return await _firebaseService.updatePassword(_emailController.text,_senhaAntigaController.text ,_senhaController.text);
  }

  void deleteUser() {
    _firebaseService.deleteUser();
  }
}