import 'package:flutter/cupertino.dart';

class RegisterBloc {
  var _emailController = TextEditingController();
  var _senhaController = TextEditingController();
  var _nomeController = TextEditingController();
  var _telefoneController = TextEditingController();

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
}