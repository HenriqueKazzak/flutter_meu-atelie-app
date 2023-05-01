class ItemAjuste{
  String _nome;
  int _custo;

  ItemAjuste(this._nome, this._custo);

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  int get custo => _custo;

  set custo(int value) {
    _custo = value;
  }
}