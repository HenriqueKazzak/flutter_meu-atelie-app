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
      appBar: AppBar(
        title: const Text('Cadastrar Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Cliente",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Nome",
                border: OutlineInputBorder(),
              ),
              controller: clienteBloc.NomeCliente,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              controller: clienteBloc.TelefoneCliente,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                clienteBloc.cadastrarCliente();
                Navigator.pop(context);
              },
              child: const Text("Cadastrar"),
            ),
          ],
        ),
      ),
    );
  }
}

