import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meu_atelie/models/Costureira.dart';
import 'package:meu_atelie/utils/FirebaseService.dart';

import '../menu/SideMenu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, User? user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

  final FirebaseService _firebaseService = FirebaseService();

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
        ));
  }
}
