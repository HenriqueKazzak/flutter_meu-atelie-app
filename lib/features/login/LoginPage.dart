import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:meu_atelie/features/cadastro/cadastrocostureira/CadastrarCostureiraPage.dart';


import '../homepage/HomePage.dart';
import 'bloc/LoginBloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc loginbloc = LoginBloc();

  //reload page when email or password is incorrect to show error message
  void reloadPage() {
    setState(() {});
  }


  @override
  void didUpdateWidget(covariant LoginPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    reloadPage();
  }

  //Animate route to RegisterCostureiraPage from bottom to top
  void _navigateToRegisterCostureiraPage() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            CadastrarCostureiraPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.easeOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 100.0),
              const Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Text(
                  'Entrar',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
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
                    padding: const EdgeInsets.all(30.0),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Email',
                            errorText: loginbloc.msgErroLogin.isNotEmpty
                                ? loginbloc.msgErroLogin
                                : null,
                            errorBorder: loginbloc.msgErroLogin.isNotEmpty
                                ? const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  )
                                : null,
                          ),
                          controller: loginbloc.email,
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Password',
                            errorBorder: loginbloc.msgErroLogin.isNotEmpty
                                ? const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  )
                                : null,
                          ),
                          obscureText: true,
                          controller: loginbloc.senha,
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forgot Password',
                                style: TextStyle(fontSize: 10),
                              ),
                            )),
                        TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromRGBO(242, 114, 137, 100)),
                            ),
                            onPressed: () async {
                              loginbloc.msgErroLogin = '';
                              loginbloc.login().then((value) => {
                                    if (value)
                                      {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomePage()))
                                      }
                                    else
                                      {reloadPage()}
                                  });
                            },
                            child: const Text(
                                style: TextStyle(color: Colors.white),
                                "Login")),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text('Ainda não possui conta?'),
                            TextButton(
                              child: const Text(
                                'Criar conta',
                                style: TextStyle(fontSize: 15),
                              ),
                              onPressed: () {
                                _navigateToRegisterCostureiraPage();
                              },
                            )
                          ],
                        ),
                        Row(
                          children: const <Widget>[
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1,
                                height: 32,
                                indent: 16,
                                endIndent: 16,
                              ),
                            ),
                            Text(
                              'Ou',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1,
                                height: 32,
                                indent: 16,
                                endIndent: 16,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        SignInButton(
                          Buttons.Google,
                          text: "Sign up with Google",
                          onPressed: () async =>
                              loginbloc.loginGoogle().then((value) => {
                                    if (value)
                                      {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomePage()))
                                      }
                                  }),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
