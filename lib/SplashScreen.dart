import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login/LoginPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;



  @override
  void initState(){
    super.initState();
    checkCurrentUser();
  }
  Future<void> checkCurrentUser() async {
    await Future.delayed(const Duration(seconds: 2));
    User? user = firebaseAuth.currentUser;
    if (user != null) {
/*      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomePage(user: user)),
      );*/
      print('HOMEPAGE');
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (_) => LoginPage()),
      // );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
