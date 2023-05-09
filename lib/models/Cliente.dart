import 'package:meu_atelie/models/AbstractModel.dart';
import 'package:meu_atelie/utils/FirebaseService.dart';

class Cliente extends AbstractModel {
  late String _id;
  late String _nome;
  late String _email;

  Cliente(this._nome, this._email);

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  @override
  Map<String, dynamic> toJson() {
    return {

      'nome': _nome,
      'email': _email,
    };
  }

  Cliente.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _nome = json['nome'];
    _email = json['email'];
  }
}