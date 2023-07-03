class Medida {
  String _nome;
  double _vrMedida;

  Medida(this._nome, this._vrMedida);

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  double get vrMedida => _vrMedida;

  set comprimento(double value) {
    _vrMedida = value;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['comprimento'] = this.vrMedida;
    return data;
  }

}