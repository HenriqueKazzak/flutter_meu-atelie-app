import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meu_atelie/models/PedidoSobMedida.dart';
import 'package:meu_atelie/models/Servico.dart';

import '../../../models/Cliente.dart';
import '../../../models/Medida.dart';

class SobMedidaEtapa3Page extends StatefulWidget {
  final Servico servico;

  const SobMedidaEtapa3Page({Key? key, required this.servico})
      : super(key: key);

  @override
  _SobMedidaEtapa3PageState createState() => _SobMedidaEtapa3PageState();
}

class _SobMedidaEtapa3PageState extends State<SobMedidaEtapa3Page> {
  List<Medida> _medidas = [];

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _comprimentoController = TextEditingController();

  void _adicionarMedida() {
    final nome = _nomeController.text;
    final comprimento = int.tryParse(_comprimentoController.text);

    if (nome.isNotEmpty && comprimento != null) {
      setState(() {
        _medidas.add(Medida(nome, comprimento));
        _nomeController.clear();
        _comprimentoController.clear();
      });
    }
  }

  void _removerMedida(int index) {
    setState(() {
      _medidas.removeAt(index);
    });
  }

  Widget _buildListaMedidas() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _medidas.length,
      itemBuilder: (context, index) {
        final medida = _medidas[index];
        return ListTile(
          title: Text(medida.nome),
          subtitle: Text('Comprimento: ${medida.comprimento}'),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _removerMedida(index),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etapa 3/5 - Medidas'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Adicionar medidas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome da Medida',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _comprimentoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Comprimento',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _adicionarMedida,
              child: const Text('Adicionar Medida'),
            ),
            const SizedBox(height: 20),
            _buildListaMedidas(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                PedidoSobMedida pedido = widget.servico.pedido as PedidoSobMedida;
                pedido.medidas = _medidas;
                widget.servico.pedido = pedido;
                log(widget.servico.pedido.toJson().toString());
                },
              child: const Text('Próxima Etapa'),
            ),
          ],
        ),
      ),
    );
  }
}
