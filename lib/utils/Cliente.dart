class Cliente {
  String _nome;
  String _telefone;

  Cliente(this._nome, this._telefone);

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }
}