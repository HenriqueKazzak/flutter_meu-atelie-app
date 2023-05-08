import 'package:flutter/material.dart';

import 'bloc/RegisterCostureiraBloc.dart';

class CadastrarCostureiraPage extends StatefulWidget {
  const CadastrarCostureiraPage({Key? key}) : super(key: key);

  @override
  State<CadastrarCostureiraPage> createState() => _CadastrarCostureiraPageState();
}

class _CadastrarCostureiraPageState extends State<CadastrarCostureiraPage> {
  var registerBloc = RegisterBloc();

  //Reload da tela
  void reload() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    reload();
  }

  @override
  void dispose() {
    super.dispose();
    registerBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool obscureText = true;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.pinkAccent,
                Colors.deepOrangeAccent,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 50.0,
                  left: 20.0,
                ),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  alignment: Alignment.topLeft,
                ),
              ),
              const SizedBox(height: 30.0),
              const Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Text(
                  'Crie sua conta',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: Card(
                    color: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Nome',
                            labelText: 'Nome',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira seu nome';
                            }
                            return null;
                          },
                          controller: registerBloc.nomeController,
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira seu email';
                            }
                          },
                          controller:registerBloc.emailController,
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Telefone',
                            labelText: 'Telefone',
                            border: OutlineInputBorder(),
                          ),
                          autofillHints: const [AutofillHints.telephoneNumber],
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira seu telefone';
                            }
                          },
                          controller:registerBloc.telefoneController,
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            hintText: 'Senha',
                            labelText: 'Senha',
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira sua senha';
                            }
                            if (value.length < 6) {
                              return 'Sua senha deve conter pelo menos 6 caracteres';
                            }
                            return null;
                          },
                          controller: registerBloc.senhaController,
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            hintText: 'Confirmar senha',
                            labelText: 'Confirmar senha',
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, confirme sua senha';
                            }
                            if (value != registerBloc.senhaController) {
                              return 'As senhas não conferem';
                            }
                            return null;
                          },
                          controller: registerBloc.confirmarSenhaController,
                        ),
                        const SizedBox(height: 10.0),
                        ElevatedButton(
                          onPressed: () {
                            registerBloc.register(context) != null
                                ? Navigator.pop(context)
                                : null;
                          },
                          child: const Text('Cadastrar'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
