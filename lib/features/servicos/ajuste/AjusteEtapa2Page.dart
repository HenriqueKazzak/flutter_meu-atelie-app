import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meu_atelie/models/Cliente.dart';
import 'package:meu_atelie/models/Servico.dart';

import '../../../models/AbstractPedido.dart';
import '../../../models/PedidoAjuste.dart';
import 'AjusteEtapa3Page.dart';

class AjusteEtapa2Page extends StatefulWidget {
  final Cliente cliente;

  const AjusteEtapa2Page({super.key, required this.cliente});

  @override
  _AjusteEtapa2PageState createState() => _AjusteEtapa2PageState();
}

class _AjusteEtapa2PageState extends State<AjusteEtapa2Page> {
  final TextEditingController _controller = TextEditingController();
  int i = 2;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etapa 2/4 - Selecionar quantidade de peças'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Quantidade de peças',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Quantidade',
              ),
              keyboardType: TextInputType.number,
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  i = int.parse(value);
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                PedidoAjuste p = PedidoAjuste(quantidadePecas: i);
                Servico servico = Servico(tipoPedido: "Ajuste", cliente: widget.cliente, pedido: PedidoAjuste(quantidadePecas: i));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AjusteEtapa3Page(servico: servico),
                  ),
                );
              },
              child: const Text('Próxima etapa'),
            ),
          ],
        ),
      ),
    );
  }
}


