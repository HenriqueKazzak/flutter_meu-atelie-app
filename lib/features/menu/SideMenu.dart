import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meu_atelie/features/user/UserPage.dart';
import 'package:meu_atelie/models/Costureira.dart';
import 'package:meu_atelie/utils/FirebaseService.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  Costureira costureira = Costureira();

  void _getCostureira() async {
    User user = await FirebaseService().getCurrentUser();
    setState(() {
      this.costureira = Costureira(
          nome: user.displayName??'',
          email: user.email??"",
          telefone: user.phoneNumber??"",
          fotoPerfil: user.photoURL??"");
    });
  }

  @override
  void initState() {
    super.initState();
    _getCostureira();
  }

  @override
  void reassemble() {
    super.reassemble();
    _getCostureira();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(242, 114, 137, 100)),
              child: ListView(children: <Widget>[
                InkWell(
                    onTap: () =>
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UserPage(
                                    costureira: costureira,
                                  )))
                    },
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.transparent,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                              NetworkImage(costureira.fotoPerfil!),
                              backgroundColor: Colors.grey,
                            )))),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      costureira.nome,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      costureira.email,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      costureira.telefone,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
              ])),
          ListTile(
            leading: Icon(Icons.shopping_bag_outlined),
            title: Text('Pedidos'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.people_outline_rounded),
            title: Text('Clientes'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.calendar_today_outlined),
            title: Text('Agenda'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}

