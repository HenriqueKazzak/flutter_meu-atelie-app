import 'package:flutter/material.dart';

import 'bloc/RegisterClienteBloc.dart';

class CadastrarClientePage extends StatefulWidget {
  const CadastrarClientePage({Key? key}) : super(key: key);

  @override
  State<CadastrarClientePage> createState() => _CadastrarClientePageState();
}

class _CadastrarClientePageState extends State<CadastrarClientePage> {
  var clienteBloc = RegisterClienteBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
              "Cliente"
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Cliente"
            ),
            controller: clienteBloc.NomeCliente,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Telefone",
            ),
            controller: clienteBloc.TelefoneCliente,
          ),
          TextButton(
            onPressed: () {
              clienteBloc.cadastrarCliente();
            },
            child: const Text("Cadastrar"),
          ),
        ],
      ),
    );
  }


}
