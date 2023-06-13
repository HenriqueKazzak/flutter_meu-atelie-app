//classe interface para o pedido

abstract class AbstractPedido {
  @override
  String toString();
  AbstractPedido.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}


