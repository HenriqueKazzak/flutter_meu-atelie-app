class Agenda {
 int _quantidadeServicos;
 DateTime _data;

 Agenda(this._quantidadeServicos, this._data);

  int get quantidadeServicos => _quantidadeServicos;

  set quantidadeServicos(int value) {
    _quantidadeServicos = value;
  }

 DateTime get data => _data;

  set data(DateTime value) {
    _data = value;
  }
}