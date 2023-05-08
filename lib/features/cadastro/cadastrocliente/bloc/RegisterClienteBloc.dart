import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meu_atelie/utils/FirebaseService.dart';

import '../../../../models/Cliente.dart';

class RegisterClienteBloc{
  final FirebaseService _firebaseService = FirebaseService();
  var _NomeCliente = TextEditingController();
  var _TelefoneCliente = TextEditingController();
  get NomeCliente => _NomeCliente;

  set NomeCliente(value) {
    _NomeCliente = value;
  }

  get TelefoneCliente => _TelefoneCliente;

  set TelefoneCliente(value) {
    _TelefoneCliente = value;
  }

  Cliente cadastrarCliente(){
    Cliente cliente = Cliente(_NomeCliente.text, _TelefoneCliente.text);
    _firebaseService.save("clientes",cliente);
    return cliente;
  }
}