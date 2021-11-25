import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/view/HomePage.dart';
import 'package:fraschetti_videocatalogo/view/LoginPage.dart';
import 'package:fraschetti_videocatalogo/view/CatalogoLista.dart';
import 'package:fraschetti_videocatalogo/view/ParametriPage.dart';
import 'package:fraschetti_videocatalogo/view/RegistrazionePage.dart';

class RouterApp {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // se non si è loggati si va il LoginPage
    // se non si è registrati si va in RegistrazionePage
    switch (settings.name) {
      case LoginPage.routeName:
        return MaterialPageRoute(builder: (context) => LoginPage());
      case RegistazionePage.routeName:
        return MaterialPageRoute(builder: (context) => RegistazionePage());
      case ParametriPage.routeName:
        return MaterialPageRoute(builder: (context) => ParametriPage());
      case CatalogoListaPage.routeName:
        return MaterialPageRoute(builder: (context) => CatalogoListaPage());
      default:
        // return MaterialPageRoute(builder: (context) => HomePage());
        return MaterialPageRoute(builder: (context) => RegistazionePage());
      // return MaterialPageRoute(builder: (context) => LoginPage());
    }
  }
}