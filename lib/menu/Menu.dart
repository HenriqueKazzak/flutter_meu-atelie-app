import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Name Surname',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.jpg'))),
          ),
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