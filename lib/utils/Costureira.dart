import 'dart:ui';

class Costureira {
  String _nome;
  String _telefone;
  Image _fotoPerfil;

  Costureira(this._nome, this._telefone, this._fotoPerfil);

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get telefone => _telefone;

  Image get fotoPerfil => _fotoPerfil;

  set fotoPerfil(Image value) {
    _fotoPerfil = value;
  }

  set telefone(String value) {
    _telefone = value;
  }
}