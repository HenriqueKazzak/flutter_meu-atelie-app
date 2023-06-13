import 'package:meu_atelie/models/AbstractPedido.dart';

import 'Ajuste.dart';

class PedidoAjuste implements AbstractPedido {
  late int quantidadePecas;
  late List<Ajuste> itensAjuste = <Ajuste>[];

  PedidoAjuste({required this.quantidadePecas}){
    for(int i=0;i<quantidadePecas;i++){
      itensAjuste.add(Ajuste());
    }
  }

  @override
  String toString() {
    return 'PedidoAjuste{quantidadePecas: $quantidadePecas, itensAjuste: $itensAjuste}';
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantidadePecas'] = this.quantidadePecas;
    data['itensAjuste'] = this.itensAjuste.map((v) => v.toJson()).toList();
    return data;
  }
}
