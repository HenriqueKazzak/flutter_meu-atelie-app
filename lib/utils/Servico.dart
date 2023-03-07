class Servico {
  DateTime _dataEntrega;
  String _status;


  Servico(this._dataEntrega, this._status);

  DateTime get dataEntrega => _dataEntrega;

  set dataEntrega(DateTime value) {
    _dataEntrega = value;
  }

  String get estado => _status;

  set estado(String value) {
    _status = value;
  }
}