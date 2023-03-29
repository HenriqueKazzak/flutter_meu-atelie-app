import 'package:flutter/material.dart';
import 'package:meu_atelie/features/user/bloc/UserBloc.dart';
import 'package:meu_atelie/models/Costureira.dart';

import '../../utils/FirebaseService.dart';

//Page to do CRUD operations on User
class UserPage extends StatefulWidget {
  final Costureira costureira;
  const UserPage({Key? key, required this.costureira}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _firebaseService = FirebaseService();
  UserBloc _userBloc = UserBloc();


  //confirm dialog
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deletar Usuário'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Tem certeza que deseja deletar o usuário?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Deletar'),
              onPressed: () {
                _userBloc.deleteUser();
                Navigator.pushNamed(context, '/');
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _userBloc.nomeController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: _userBloc.telefoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
              ),
            ),
            TextField(
              controller: _userBloc.senhaController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                await _userBloc.updateUser();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('User data updated successfully.')),
                );
              },
              child: Text('Save Changes'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _userBloc.updatePassword();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Password updated successfully.')),
                );
              },
              child: Text('Change Password'),
            ),
            ElevatedButton(
              onPressed: () {
                _userBloc.deleteUser();
                Navigator.of(context).pop();
              },
              child: Text('Delete Account'),
            ),
          ],
        ),
      ),
    );
  }
}