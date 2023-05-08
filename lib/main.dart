import 'package:flutter/material.dart';
import 'package:meu_atelie/SplashScreen.dart';
import 'package:meu_atelie/features/homepage/HomePage.dart';
import 'package:meu_atelie/features/login/LoginPage.dart';
import 'package:meu_atelie/utils/FirebaseService.dart';

import 'features/cadastro/cadastrocliente/CadastrarClientePage.dart';
import 'features/cadastro/cadastrocostureira/CadastrarCostureiraPage.dart';
import 'features/servicos/MainServicoPage.dart';
import 'features/servicos/ajuste/AjusteEtapa1Page.dart';
import 'features/servicos/novo/NovoPage.dart';

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
        '/newjob': (context) => const MainServicoPage(),
        '/novo': (context) => const NovoPage(),
        '/ajuste1': (context) => const AjusteEtapa1Page(),
        '/register_costureira': (context) => const CadastrarCostureiraPage(),
        '/register_cliente': (context) => const CadastrarClientePage()
      },
    );
  }
}
