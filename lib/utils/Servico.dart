class Servico {
  DateTime _dataEntrega;
  String _estado;


  Servico(this._dataEntrega, this._estado);

  DateTime get dataEntrega => _dataEntrega;

  set dataEntrega(DateTime value) {
    _dataEntrega = value;
  }

  String get estado => _estado;

  set estado(String value) {
    _estado = value;
  }
}