import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meu_atelie/models/PedidoSobMedida.dart';
import 'package:meu_atelie/models/Servico.dart';

import '../../../models/Cliente.dart';
import '../../../models/Medida.dart';
import 'SobMedidaEtapa4Page.dart';

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
    final comprimento = double.tryParse(_comprimentoController.text);

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

  void _editarMedida(int index) {
    final medida = _medidas[index];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _nomeEditController =
            TextEditingController(text: medida.nome);
        TextEditingController _comprimentoEditController =
            TextEditingController(text: medida.vrMedida.toString());

        return AlertDialog(
          title: const Text('Editar Medida'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nomeEditController,
                decoration: const InputDecoration(
                  labelText: 'Nome da Medida',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _comprimentoEditController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Medida',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final nome = _nomeEditController.text;
                final comprimento =
                    double.tryParse(_comprimentoEditController.text);

                if (nome.isNotEmpty && comprimento != null) {
                  setState(() {
                    medida.nome = nome;
                    medida.comprimento = comprimento;
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildListaMedidas() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _medidas.length,
      itemBuilder: (context, index) {
        final medida = _medidas[index];
        return ListTile(
          title: Text(medida.nome),
          subtitle: Text('Comprimento: ${medida.vrMedida}'),
          trailing: Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editarMedida(index),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _removerMedida(index),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etapa 3/4 - Medidas'),
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
                PedidoSobMedida pedido =
                    widget.servico.pedido as PedidoSobMedida;
                pedido.medidas = _medidas;
                widget.servico.pedido = pedido;
                log(widget.servico.pedido.toJson().toString());
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SobMedidaEtapa4Page(
                      servico: widget.servico,
                    ),
                  ),
                );
              },
              child: const Text('Próxima Etapa'),
            ),
          ],
        ),
      ),
    );
  }
}
