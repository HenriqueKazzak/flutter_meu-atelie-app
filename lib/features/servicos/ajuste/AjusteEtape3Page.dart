import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meu_atelie/models/ItemAjuste.dart';
import 'package:meu_atelie/models/PedidoAjuste.dart';
import 'package:meu_atelie/models/Servico.dart';
import 'package:meu_atelie/models/Ajuste.dart';

import 'AjusteEtapa4Page.dart';

class AjusteEtapa3Page extends StatefulWidget {
  final Servico servico;

  const AjusteEtapa3Page({Key? key, required this.servico});
  @override
  _AjusteEtapa3PageState createState() => _AjusteEtapa3PageState();
}

class _AjusteEtapa3PageState extends State<AjusteEtapa3Page> {
  int _indiceAtual = 0;
  List<ItemAjuste> _ajustesDoBanco = [
    ItemAjuste("tes", 123.2),
    ItemAjuste("tes", 123.2),
    ItemAjuste("tes", 123.2),
    ItemAjuste("tes", 123.2),
    ItemAjuste("tes", 123.2),
    ItemAjuste("tes", 123.2),
    ItemAjuste("tes", 123.2),
    ItemAjuste("tes", 123.2),
    ItemAjuste("tes", 123.2),
    ItemAjuste("tes", 123.2),
    ItemAjuste("tes", 123.2),
    // ...
  ];
  late PedidoAjuste pedido;
  late Ajuste pecaAtual;
  late TextEditingController _pecaNomeController;
  late TextEditingController _pecaDescricaoController;
  late Servico servico;

  @override
  void initState() {
    super.initState();
    log("init");
    servico = widget.servico;
    pedido = widget.servico.pedido as PedidoAjuste;
    pecaAtual = pedido.itensAjuste[_indiceAtual];
    _pecaNomeController = TextEditingController(text: pecaAtual.nome??"");
    _pecaDescricaoController = TextEditingController(text: pecaAtual.descricao??"");

  }

  void _irParaPecaAnterior() {
    setState(() {
      if (_indiceAtual > 0) {
        _atualizarAjuste();
        _indiceAtual--;
        pecaAtual = pedido.itensAjuste[_indiceAtual];
      }
    });
  }

  void _irParaProximaPeca() {
    setState(() {
      if (_indiceAtual < pedido.quantidadePecas - 1) {
        _atualizarAjuste();
        _indiceAtual++;
        pecaAtual = pedido.itensAjuste[_indiceAtual];
      }
    });
  }

  void _atualizarAjuste() {
    pecaAtual.nome = _pecaNomeController.text;
    pecaAtual.descricao = _pecaDescricaoController.text;
    pecaAtual.ajustes = _ajustesDoBanco
        .where((ajuste) => ajuste.selecionado)
        .toList(); // Atualiza a lista de ajustes selecionados
    _pecaNomeController.clear();
    _pecaDescricaoController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Etapa 3/5 - Selecionar Ajustes'),
        ),
        body: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: _indiceAtual == 0 ? null : _irParaPecaAnterior,
              ),
              Text(
                'Peça ${_indiceAtual + 1}/${pedido.quantidadePecas}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: _indiceAtual == pedido.quantidadePecas - 1
                    ? null
                    : _irParaProximaPeca,
              ),
            ],
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Título da Peça:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: _pecaNomeController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Descrição (opcional):',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: _pecaDescricaoController,
                            maxLines: 4,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Selecione os ajustes solicitados:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      ItemAjuste ajuste = _ajustesDoBanco[index];
                      return CheckboxListTile(
                        title: Text(ajuste.nome),
                        subtitle: Text('Valor: R\$ ${ajuste.custo}'),
                        value: ajuste.selecionado,
                        onChanged: (value) {
                          setState(() {
                            ajuste.selecionado = value ?? false;
                          });
                        },
                      );
                    },
                    childCount: _ajustesDoBanco.length,
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'Resumo do Serviço:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Valor Total: R\$ 123.2',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                _atualizarAjuste();
                servico.pedido = pedido;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AjusteEtapa4Page(servico: servico),
                  ),
                );
              },
              child: Text('Próximo'),
            ),
          ),
        ]));
  }
}


