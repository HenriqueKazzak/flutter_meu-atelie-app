class Medida {
  String _nome;
  int _comprimento;

  Medida(this._nome, this._comprimento);

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  int get comprimento => _comprimento;

  set comprimento(int value) {
    _comprimento = value;
  }
}