import 'package:flutter/material.dart';
import 'package:meu_atelie/register/bloc/RegisterBloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var registerBloc = RegisterBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center (
        child: Column(
          children: <Widget> [
            TextField(
              decoration: const InputDecoration(
                hintText: "Nome: ",
              ),
              controller: registerBloc.emailController,
            )
          ],
        )
      ),
    );
  }
}
