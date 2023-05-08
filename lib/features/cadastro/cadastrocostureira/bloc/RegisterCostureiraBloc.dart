import 'dart:async';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meu_atelie/utils/FirebaseService.dart';

class RegisterBloc {
  final FirebaseService _firebaseService = FirebaseService();
  var _emailController = TextEditingController();
  var _senhaController = TextEditingController();
  var _confirmarSenhaController = TextEditingController();
  var _nomeController = TextEditingController();
  var _telefoneController = TextEditingController();
  var _msgErroLogin = "";

  get emailController => _emailController;

  set emailController(value) {
    _emailController = value;
  }

  get senhaController => _senhaController;

  set senhaController(value) {
    _senhaController = value;
  }

  get telefoneController => _telefoneController;

  set telefoneController(value) {
    _telefoneController = value;
  }

  get nomeController => _nomeController;

  set nomeController(value) {
    _nomeController = value;
  }

  set confirmarSenhaController(value) {
    _confirmarSenhaController = value;
  }
  get confirmarSenhaController => _confirmarSenhaController;

  get msgErroLogin => _msgErroLogin;

  set msgErroLogin(value) {
    _msgErroLogin = value;
  }

  //create user
  Future<UserCredential> register(BuildContext context) async {
    try {
      UserCredential userCredential = await _firebaseService.signUp(
          _emailController.text, _senhaController.text, _nomeController.text, _telefoneController.text);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        msgErroLogin = 'A senha é muito fraca.';
      } else if (e.code == 'email-already-in-use') {
        msgErroLogin = 'O email já está em uso.';
      }
    } catch (e) {
      msgErroLogin = e.toString();
    }
    return msgErroLogin;
  }
  Future<User> update() async {
    try{
      return await _firebaseService.updateUser(_nomeController.text, _telefoneController.text);
    }
    catch(e){
      msgErroLogin = e.toString();
      return msgErroLogin;
    }
  }


  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    _nomeController.dispose();
    _telefoneController.dispose();
  }

}