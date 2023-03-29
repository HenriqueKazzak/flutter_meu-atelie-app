import 'dart:ui';

class Costureira {
  String _nome;
  String _telefone;
  String _email;
  String _fotoPerfil;

  Costureira({String? email, String? nome, String? telefone, String? fotoPerfil})
      : _nome = nome ?? '',
        _telefone = telefone ?? '',
        _email = email ?? '',
        _fotoPerfil = fotoPerfil ?? '';

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get telefone => _telefone;

  String get fotoPerfil => _fotoPerfil;

  set fotoPerfil(String value) {
    _fotoPerfil = value;
  }

  set telefone(String value) {
    _telefone = value;
  }
}