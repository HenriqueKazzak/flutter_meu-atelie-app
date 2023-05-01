<<<<<<< HEAD
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login/LoginPage.dart';
=======
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meu_atelie/utils/FirebaseService.dart';
>>>>>>> dev

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

<<<<<<< HEAD
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

=======
class _SplashScreenState extends State<SplashScreen>{


  final FirebaseService _firebaseService = FirebaseService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //Logger initialization
    log("SplashScreen: didChangeDependencies");
    _firebaseService.isSignedIn().then((value) {
      log("SplashScreen: isSignedIn: $value");
      if (value) {
        Navigator.pushNamed(context, '/home');
      } else {
        Navigator.pushNamed(context, '/login');
      }
    });
  }
>>>>>>> dev
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
