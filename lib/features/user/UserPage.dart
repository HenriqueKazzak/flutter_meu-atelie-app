import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meu_atelie/features/user/bloc/UserBloc.dart';
import 'package:meu_atelie/models/Costureira.dart';
import 'package:meu_atelie/utils/FirebaseService.dart';

class UserPage extends StatefulWidget {
  final Costureira costureira;

  const UserPage({Key? key, required this.costureira}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  File? _image;
  final FirebaseService _firebaseService = FirebaseService();
  UserBloc _userBloc = UserBloc();
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _userBloc.telefoneController.text = widget.costureira.telefone;
    _userBloc.nomeController.text = widget.costureira.nome;
    _userBloc.emailController.text = widget.costureira.email;
  }

  bool _confirmPassword() {
    return _userBloc.senhaController.text ==
        _userBloc.confirmarSenhaController.text;
  }

  //modal para mudar senha, senha atual nova e confirmar nova senha
  void _showModalChangePassword(BuildContext context) {
    bool showPassword = false;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Alterar senha'),
            contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    // TODO: Implement photo selection
                  },
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                        Icons.person, size: 60.0, color: Colors.grey[600]),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _userBloc.senhaAntigaController,
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    labelText: 'Senha atual',
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _userBloc.senhaController,
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    labelText: 'Nova senha',
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _userBloc.confirmarSenhaController,
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    errorText: _confirmPassword()
                        ? null
                        : 'Senhas não conferem',
                    labelText: 'Confirmar nova senha',
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _confirmPassword();
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text('Salvar'),
                onPressed: () {
                  if (_confirmPassword()) {
                    _userBloc.updatePassword().then((value) =>
                    {
                      if(value) {
                        Navigator.of(context).pop(),
                        sucessoDialog(context)
                      } else
                        {
                          Navigator.of(context).pop(),
                          erroDialog(context)
                        }
                    });
                  }
                },
              ),
            ],
          );
        }
    );
  }

  void sucessoDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sucesso'),
            content: Text('Dados alterados com sucesso'),
            actions: [
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                  });
                      },
              ),
            ],
          );
        });
  }

  erroDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro'),
            content: Text('Erro ao alterar dados'),
            actions: [
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }


  void _showImageSourceOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Câmera'),
                  onTap: () {
                    _pickImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Galeria'),
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => _showImageSourceOptions(context),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _userBloc.nomeController,
              decoration: InputDecoration(
                labelText: 'Nome',
                prefixIcon: Icon(Icons.person),
                suffixIcon: Icon(Icons.edit),
              ),
            ),
            TextField(
              controller: _userBloc.telefoneController,
              decoration: InputDecoration(
                labelText: 'Telefone',
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              readOnly: true,
              controller: _userBloc.emailController,
            ),
            ElevatedButton(onPressed: () => _showModalChangePassword(context),
                child: Text('Alterar senha')),
            ElevatedButton(
              onPressed: () {
                _userBloc.updateUser();
                //show dialog de sucesso
                sucessoDialog(context);
              },
              child: Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}