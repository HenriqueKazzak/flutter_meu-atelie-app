import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meu_atelie/models/Cliente.dart';
import 'package:meu_atelie/models/Servico.dart';
import 'package:meu_atelie/utils/FirebaseService.dart';

import 'SobMedidaEtapa2Page.dart';

class SobMedidaEtapa1Page extends StatefulWidget {
  const SobMedidaEtapa1Page({Key? key}) : super(key: key);

  @override
  State<SobMedidaEtapa1Page> createState() => _SobMedidaEtapa1PageState();
}

class _SobMedidaEtapa1PageState extends State<SobMedidaEtapa1Page> {
  final FirebaseService _firebaseService = FirebaseService();

  final _formKey = GlobalKey<FormState>();
  final _controllerNome = TextEditingController();
  final _controllerEmail = TextEditingController();
  List<dynamic> _clientes = [];

  Future<void> _pesquisarClientes(String value) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('clientes')
        .where('nome', isGreaterThanOrEqualTo: value)
        .where('nome', isLessThan: '${value}z')
        .get();

    final clientes = snapshot.docs.map((doc) {
      var data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();

    setState(() {
      _clientes = clientes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etapa 1/5 - Selecionar cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Pesquisar cliente:'),
              TextFormField(
                controller: _controllerNome,
                onChanged: _pesquisarClientes,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _controllerNome.clear();
                        _controllerEmail.clear();
                        setState(() {
                          _clientes = [];
                        });
                      },
                    ),
                    prefixIcon: const Icon(Icons.search)),
              ),
              if (_clientes.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: _clientes.length,
                    itemBuilder: (context, index) {
                      final cliente = Cliente.fromJson(_clientes[index]);
                      return ListTile(
                        title: Row(
                          children: [
                            const Icon(Icons.person),
                            Text(cliente.nome),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            const Icon(Icons.email),
                            Text(cliente.email),
                          ],
                        ),
                        onTap: () {
                          _controllerNome.text = cliente.nome;
                          _controllerEmail.text = cliente.email;
                          setState(() {
                            _clientes = [];
                          });
                        },
                      );
                    },
                  ),
                ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _controllerEmail,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    readOnly: true,
                  )),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/novo_cliente');
                },
                child: const Text('Novo cliente'),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Voltar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SobMedidaEtapa2Page(
                                    cliente: Cliente(_controllerNome.text,
                                        _controllerEmail.text))));
                      }
                    },
                    child: const Text('Próxima etapa'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
