import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center (
        child: Column(
          children: const <Widget> [
            TextField(
              decoration: InputDecoration(
                hintText: "Nome: "
              ),
            )
          ],
        )
      ),
    );
  }
}
