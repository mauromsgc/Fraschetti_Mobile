
import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/repositories/httpRepository.dart';
import 'package:fraschetti_videocatalogo/screen/auth/RegistrazionePage.dart';

import 'package:fraschetti_videocatalogo/screen/auth/SplashPage.dart';
import 'package:fraschetti_videocatalogo/screen/auth/LoginPage.dart';
import 'package:fraschetti_videocatalogo/screen/catalogo/CatalogoLista.dart';
import 'package:fraschetti_videocatalogo/screen/utils/LogPage.dart';
import 'package:fraschetti_videocatalogo/utils/router_app.dart';
import 'package:fraschetti_videocatalogo/screen/home/HomePage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void main() {
  runApp(MyApp());

  getIt.registerSingleton<HttpRepository>(HttpRepository());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors.
        // brightness: Brightness.dark,
        primaryColor: Color.fromRGBO(67, 122, 28, 1),
        // backgroud di tutte le scaffold
        // scaffoldBackgroundColor: ,

        // Define the default font family.
        // fontFamily: 'Georgia',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          // headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          // headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          // bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),

      // onGenerateRoute: RouterApp.generateRoute,
      //onUnknownRoute: (context) => ErrorScreen(),
      initialRoute: "/splash",
      routes: {
        "/splash": (_) => SplashPage(),
        "/login": (_) => LoginPage(),
        "/registrazione": (_) => RegistazionePage(),
        "/home": (_) => HomePage(),
        "/articoli": (_) => CatalogoListaPage(),
        "/log": (_) => LogPage(),
      },


    );
  }
}


