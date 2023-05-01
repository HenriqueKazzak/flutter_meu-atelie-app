import 'package:meu_atelie/models/AbstractModel.dart';
import 'package:meu_atelie/utils/FirebaseService.dart';

class Cliente extends AbstractModel {
  late String _id;
  late String _nome;
  late String _telefone;

  Cliente(this._nome, this._telefone);

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'nome': _nome,
      'telefone': _telefone,
    };
  }

  Cliente.fromJson(Map<String, dynamic> json) {
    _nome = json['nome'];
    _telefone = json['telefone'];
  }
}