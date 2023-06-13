import 'AbstractPedido.dart';
import 'Cliente.dart';

class Servico {
  late Cliente cliente;
  DateTime dataEntrega = DateTime.now().add(Duration(days: 7));
  String status = 'Aguardando';
  late AbstractPedido pedido;

  Servico({required this.cliente, required this.pedido});

  Servico.fromJson(Map<String, dynamic> json) {
    cliente = Cliente.fromJson(json['cliente']);
    dataEntrega = DateTime.parse(json['dataEntrega']);
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cliente'] = this.cliente.toJson();
    data['dataEntrega'] = this.dataEntrega.toIso8601String();
    data['status'] = this.status;
    data['pedido'] = this.pedido.toJson();
    return data;
  }

 @override
  String toString() {
    return toJson().toString();
  }
}
