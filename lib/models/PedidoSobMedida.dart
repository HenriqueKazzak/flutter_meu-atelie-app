import 'dart:io';

import 'AbstractPedido.dart';
import 'Medida.dart';

class PedidoSobMedida implements AbstractPedido{

  late String titulo;
  late String descricao;

  late List<File> imagens = <File>[];

  late List<Medida> medidas = <Medida>[];

  PedidoSobMedida({required this.titulo, required this.descricao});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titulo'] = this.titulo;
    data['descricao'] = this.descricao;
    data['imagens'] = this.imagens;
    data['medidas'] = this.medidas.map((v) => v.toJson()).toList();
    return data;
  }


}