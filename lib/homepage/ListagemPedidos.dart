import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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


