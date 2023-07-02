import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meu_atelie/models/PedidoSobMedida.dart';
import 'package:meu_atelie/models/Servico.dart';

import '../../../models/Cliente.dart';
import 'SobMedidaEtapa3Page.dart';

class SobMedidaEtapa2Page extends StatefulWidget {
  final Cliente cliente;

  const SobMedidaEtapa2Page({Key? key, required this.cliente}) : super(key: key);

  @override
  _SobMedidaEtapa2PageState createState() => _SobMedidaEtapa2PageState();
}

class _SobMedidaEtapa2PageState extends State<SobMedidaEtapa2Page> {
  List<File> _imagemSobMedida = [];
  TextEditingController _tituloController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();

  Future<void> _escolherImagens() async {
    final pickedFiles = await ImagePicker().pickMultiImage(
      imageQuality: 80, // Qualidade das imagens selecionadas (opcional)
      maxWidth: 800, // Largura máxima das imagens selecionadas (opcional)
      maxHeight: 800, // Altura máxima das imagens selecionadas (opcional)
    );

    if (pickedFiles != null) {
      setState(() {
        _imagemSobMedida = pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
      });
    }
  }

  Widget _buildImagensSelecionadas() {
    if (_imagemSobMedida.isEmpty) {
      return const Text('Nenhuma imagem selecionada');
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: _imagemSobMedida.length,
      itemBuilder: (context, index) {
        final imagem = _imagemSobMedida[index];
        return Image.file(imagem);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etapa 2/5 - Imagens de Referência'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Adicionar fotos da peça modelo',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: 5,
              itemBuilder: (context, index) {
                if (index < _imagemSobMedida.length) {
                  final imagem = _imagemSobMedida[index];
                  return Image.file(imagem);
                } else {
                  return const Placeholder();
                }
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _tituloController,
              decoration: const InputDecoration(
                labelText: 'Título da Peça',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _descricaoController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Descrição da Peça',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _escolherImagens,
              child: const Text('Escolher Imagens'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {

                PedidoSobMedida p = PedidoSobMedida(
                  titulo: _tituloController.text,
                  descricao: _descricaoController.text,
                );
                if (_imagemSobMedida.isNotEmpty) {
                  p.imagens = _imagemSobMedida;
                }
                Servico servico = Servico(
                  tipoPedido: "SobMedida",
                  cliente: widget.cliente,
                  pedido: p
                );
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SobMedidaEtapa3Page(servico: servico))
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