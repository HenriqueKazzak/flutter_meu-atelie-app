import 'package:flutter/material.dart';
import 'package:meu_atelie/SplashScreen.dart';
import 'package:meu_atelie/features/jobsfeatures/ajuste/AjustePage.dart';
import 'package:meu_atelie/features/homepage/HomePage.dart';
import 'package:meu_atelie/features/login/LoginPage.dart';
import 'package:meu_atelie/features/jobsfeatures/ajuste/newjob/NewJobPage.dart';
import 'package:meu_atelie/features/jobsfeatures/ajuste/novo/NovoPage.dart';
import 'package:meu_atelie/features/registers/registerCliente/RegisterClientePage.dart';
import 'package:meu_atelie/features/registers/registerCostureira/RegisterCostureiraPage.dart';
import 'package:meu_atelie/features/user/UserPage.dart';
import 'package:meu_atelie/models/Ajuste.dart';
import 'package:meu_atelie/utils/FirebaseService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initializeFirebase();
  runApp(const MeuAtelie());
}

class MeuAtelie extends StatelessWidget {
  const MeuAtelie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atelie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColorLight: Colors.lightBlue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(242, 114, 137, 100),
          foregroundColor: Colors.white,
        ),
        buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.accent,
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color.fromRGBO(242, 114, 137, 100),
                  secondary: Colors.white,
                )),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromRGBO(242, 114, 137, 100),
          foregroundColor: Colors.white,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: const Color.fromRGBO(242, 114, 137, 100),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomePage(),
        '/login': (context) => LoginPage(),
        '/newjob': (context) => const NewJobPage(),
        '/novo': (context) => const NovoPage(),
        '/ajuste': (context) => const AjustePage(),
        '/register_costureira': (context) => const RegisterCostureiraPage(),
        '/register_cliente': (context) => const RegisterClientePage(),

      },
    );
  }
}
