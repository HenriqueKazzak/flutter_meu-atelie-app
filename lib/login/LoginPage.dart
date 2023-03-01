import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meu_atelie/register/RegisterPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User? user = authResult.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {

              },
              child: const Text(
                'Forgot Password',
              ),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(242, 114, 137,100)),
              ),
              onPressed: () {
              },
              child: const Text(style: TextStyle(color: Colors.white),
                  "Login"
              )
            ),
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
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const RegisterPage()
                        )
                    );
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
            SignInButton(
              Buttons.Google,
              text: "Sign up with Google",
              onPressed: _signInWithGoogle,
            )
          ],
        ),
      ),
    );
  }
}
