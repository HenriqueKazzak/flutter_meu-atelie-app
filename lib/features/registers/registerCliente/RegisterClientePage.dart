import 'package:flutter/material.dart';

import 'bloc/RegisterClienteBloc.dart';

class RegisterClientePage extends StatefulWidget {
  const RegisterClientePage({Key? key}) : super(key: key);

  @override
  State<RegisterClientePage> createState() => _RegisterClientePageState();
}

class _RegisterClientePageState extends State<RegisterClientePage> {
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
