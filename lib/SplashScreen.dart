import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meu_atelie/utils/FirebaseService.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

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
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
