import 'package:flutter/material.dart';
import 'package:meu_atelie/utils/FirebaseService.dart';

class LoginBloc {
  final FirebaseService _firebaseService = FirebaseService();
  var _email = TextEditingController();
  var _senha = TextEditingController();
  var _msgErroLogin ="";

  get email => _email;

  set email(value) {
    _email = value;
  }

  get senha => _senha;

  set senha(value) {
    _senha = value;
  }

  get msgErroLogin => _msgErroLogin;

  set msgErroLogin(value) {
    _msgErroLogin = value;
  }

  Future<bool> login() async {
    try {
      await _firebaseService.signIn(_email.text, _senha.text);
      return true;
    } catch (e) {
      _msgErroLogin = "Email ou senha inválidos";
      return false;
    }
  }

  Future<bool> loginGoogle() async {
    try {
      await _firebaseService.signInWithGoogle();
      return true;
    } catch (e) {
      _msgErroLogin = "Email ou senha inválidos";
      return false;
    }
  }

  void dispose() {
    _email.dispose();
    _senha.dispose();
  }
}