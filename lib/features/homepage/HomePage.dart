import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meu_atelie/models/Costureira.dart';
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

  // Definir um Stream para os pedidos
  late Stream<QuerySnapshot> _ordersStream;



  @override
  void initState() {
    super.initState();
    // Inicializar o Stream com os pedidos
    _ordersStream = _firebaseService.getOrdersStream();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Carregar mais pedidos quando o usuário chegar ao final da lista
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length + 1, // Adicionar um item extra para o indicador de carregamento
              itemBuilder: (BuildContext context, int index) {
                if (index == documents.length) {
                  // Último item, exibir um indicador de carregamento
                  return const Center(child: CircularProgressIndicator());
                }
                // Construir o item da lista com base no documento do Firestore
                final pedido = Servico.fromJson(documents[index].data() as Map<String, dynamic>);
                return ListTile(
                  title: Text(pedido.status),
                  subtitle: Text(pedido.dataEntrega as String),
                );

              },
              controller: _scrollController,
            );
          },
        ));
  }
}

