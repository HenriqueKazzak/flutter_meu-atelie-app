import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:meu_atelie/models/Costureira.dart';
import 'package:meu_atelie/models/PedidoAjuste.dart';
import 'package:meu_atelie/models/PedidoSobMedida.dart';
import 'package:meu_atelie/models/Servico.dart';
import 'package:meu_atelie/utils/FirebaseService.dart';

import '../menu/SideMenu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, User? user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseService _firebaseService = FirebaseService();
  final ScrollController _scrollController = ScrollController();
  late var lastDocuments;
  var maxDocuments = 10;
  // Definir um Stream para os pedidos
  late Stream<QuerySnapshot> _ordersStream;
  bool _isLoading = false; // Variável para controlar o estado de carregamento

  @override
  void initState() {
    super.initState();
    _ordersStream = _firebaseService.getOrdersStream(10);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {        _loadMoreOrders(lastDocuments);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _editOrder(String orderId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Pedido'),
          content: SingleChildScrollView(
            child: FutureBuilder<DocumentSnapshot>(
              future: _firebaseService.getOrder(orderId),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Erro ao carregar o pedido.');
                }
                final pedidoData = snapshot.data!.data();
                if (pedidoData == null) {
                  return Text('Pedido não encontrado.');
                }
                final pedido = Servico.fromJson(pedidoData as Map<String, dynamic>);
                if (pedido.pedido is PedidoSobMedida) {
                  final pedidoSobMedida = pedido.pedido as PedidoSobMedida;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        initialValue: pedidoSobMedida.titulo,
                        decoration: InputDecoration(labelText: 'Título'),
                      ),
                      TextFormField(
                        initialValue: pedidoSobMedida.descricao,
                        decoration: InputDecoration(labelText: 'Descrição'),
                      ),
                      // ... Adicionar outros campos específicos do PedidoSobMedida ...
                    ],
                  );
                }
                else if(pedido.pedido is PedidoAjuste){
                  final pedidoAjuste = pedido.pedido as PedidoAjuste;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Título'),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Descrição'),
                      ),
                      // ... Adicionar outros campos específicos do PedidoAjuste ...
                    ],
                  );
                }

                else {
                  return Text('Tipo de pedido não suportado.');
                }
              },
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Implementar a lógica para salvar as alterações no pedido
              },
              child: Text('Salvar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Fechar o popup sem salvar
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _loadMoreOrders(lastDocuments) async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true; // Define o estado de carregamento como verdadeiro
      });
      await _firebaseService.getNextOrdersStream(lastDocuments);
      setState(() {
        _isLoading = false; // Define o estado de carregamento como falso
      });
    }
  }

  void _deleteOrder(String orderId) async {
    try {
      await _firebaseService.deleteOrder(orderId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pedido deletado com sucesso.'),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (error) {
      // Mostrar uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao deletar o pedido.'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedidos"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _firebaseService.signOut();
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
      drawer: SideMenu(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/newjob');
        },
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _ordersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Text('Erro ao carregar os pedidos.');
          }
          final documents = snapshot.data!.docs;
          if (documents.isEmpty) {
            return const Center(child: Text('Nenhum pedido encontrado.'));
          }
          return ListView.builder(
            itemCount: documents.length + (_isLoading ? 1 : 0),
            itemBuilder: (BuildContext context, int index) {
              if (index == documents.length) {
                if (_isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const SizedBox(); // Retornar um widget vazio quando todos os itens foram carregados
                }
              }
              // Construir o item da lista com base no documento do Firestore
              final pedido = Servico.fromJson(
                  documents[index].data() as Map<String, dynamic>);
              return Slidable(
                key: Key(documents[index].id), // Definir uma chave única para o Slidable
                actionPane: SlidableDrawerActionPane(),
                actions: <Widget>[
                  IconSlideAction(
                    caption: 'Deletar',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () => _deleteOrder(documents[index].id),
                  ),
                ],
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Editar',
                    color: Colors.green,
                    icon: Icons.edit,
                    onTap: () => _editOrder(documents[index].id),
                  ),
                ],
                child: InkWell(
                  onTap: () {
                    _editOrder(documents[index].id);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text(
                            pedido.cliente.nome.substring(0, 2).toUpperCase(),
                            style: const TextStyle(color: Colors.white)),
                      ),
                      title: Text(
                        pedido.cliente.nome,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Status: ${pedido.status}'),
                          Text('Data de entrega: ${pedido.dataEntrega
                              .toIso8601String()}'),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            controller: _scrollController,
          );
        },
      ),
    );
  }
}
