import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meu_atelie/models/Cliente.dart';
import 'package:meu_atelie/models/Servico.dart';
import 'package:meu_atelie/utils/FirebaseService.dart';

class AjusteEtapa1Page extends StatefulWidget {
  const AjusteEtapa1Page({Key? key}) : super(key: key);

  @override
  State<AjusteEtapa1Page> createState() => _AjusteEtapa1PageState();
}

class _AjusteEtapa1PageState extends State<AjusteEtapa1Page> {
  final FirebaseService _firebaseService = FirebaseService();


  String _getClienteTelefone() {
    return "+55 (11) 98765-4321";
  }


  final _formKey = GlobalKey<FormState>();
  final _controllerNome = TextEditingController();
  final _controllerTelefone = TextEditingController();
  List<dynamic> _clientes = [];

  Future<void> _pesquisarClientes(String value) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('clientes')
        .where('nome', isGreaterThanOrEqualTo: value)
        .where('nome', isLessThan: value + 'z')
        .get();
    final clientes = snapshot.docs.map((doc) => doc.data()).toList();
    setState(() {
      _clientes = clientes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Etapa 1/5 - Selecionar cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pesquisar cliente:'),
              TextFormField(
                controller: _controllerNome,
                onChanged: _pesquisarClientes,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _controllerNome.clear();
                      setState(() {
                        _clientes = [];
                      });
                    },
                  ),
                  prefixIcon: Icon(Icons.search)
                ),
              ),
              if (_clientes.isNotEmpty)
                Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: _clientes.length,
                    itemBuilder: (context, index) {
                      final cliente = _clientes[index];
                      return ListTile(
                        title: Row(
                          children: [
                            Icon(Icons.person),
                            Text(cliente['nome'])
                          ],
                        ),
                        subtitle: Text(cliente['telefone']),
                        onTap: () {
                          _controllerNome.text = cliente['nome'];
                          _controllerTelefone.text = cliente['telefone'];
                          setState(() {
                            _clientes = [];
                          });
                        },
                      );
                    },
                  ),
                ),
              SizedBox(height: 20),
              Row(
                children:  [
                  Icon(Icons.phone),
                  Expanded(child: TextField(
                    controller: _controllerTelefone,
                    readOnly: true,
                  )

                  ),

                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/novo_cliente');
                },
                child: Text('Novo cliente'),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Voltar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushNamed(context, '/etapa2');
                      }
                    },
                    child: Text('Próxima etapa'),
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

