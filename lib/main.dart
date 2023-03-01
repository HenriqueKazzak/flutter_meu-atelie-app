import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meu_atelie/SplashScreen.dart';
import 'config/firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "meuAtelie",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MeuAtelie());
}
class MeuAtelie extends StatelessWidget {
  const MeuAtelie({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atelie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: const Color.fromRGBO(242, 114, 137,100),
          secondary: Colors.white,)
        ),
      ),
      home: SplashScreen(),
    );
  }
}

