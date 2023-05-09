import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meu_atelie/models/Cliente.dart';
import 'package:meu_atelie/utils/FirebaseService.dart';

class AjusteEtapa1Page extends StatefulWidget {
  const AjusteEtapa1Page({Key? key}) : super(key: key);

  @override
  State<AjusteEtapa1Page> createState() => _AjusteEtapa1PageState();
}

class _AjusteEtapa1PageState extends State<AjusteEtapa1Page> {
  final FirebaseService _firebaseService = FirebaseService();

  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  final _controllerEmail = TextEditingController();
  List<QueryDocumentSnapshot> _clientes = [];

  Future<void> _pesquisarClientes(String value) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('clientes')
        .where('nome', isGreaterThanOrEqualTo: value)
        .where('nome', isLessThan: '${value}z')
        .get();
    final clientes = snapshot.docs;
    setState(() {
      _clientes = clientes;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerEmail.dispose();
    super.dispose();
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Pesquisar cliente:'),
              TextFormField(
                controller: _controller,
                onChanged: _pesquisarClientes,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                      setState(() {
                        _clientes = [];
                      });
                    },
                  ),
                ),
              ),
              if (_clientes.isNotEmpty)
                Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: _clientes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_clientes[index].get('nome')),
                        onTap: () {
                          _controller.text = _clientes[index].get('nome');
                          _controllerEmail.text = _clientes[index].get('email');
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
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'E-mail',
                      ),
                      controller: _controllerEmail,
                    ),
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