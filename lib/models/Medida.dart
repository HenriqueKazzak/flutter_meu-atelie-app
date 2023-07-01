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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['comprimento'] = this.comprimento;
    return data;
  }

}