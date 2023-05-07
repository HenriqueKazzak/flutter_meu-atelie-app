import 'package:flutter/material.dart';

class ListagemPedidos extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}
class _ListagemPedidosState extends State<ListagemPedidos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedidos"),
      ),
      // body: FutureBuilder(
      //   future: getServico,
      //   builder: (context, servico){
      //     return ListView.builder(
      //         itemBuilder: itemBuilder)
      //   },
      // ),
    );
  }

}

