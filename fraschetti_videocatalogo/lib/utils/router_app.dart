import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/screen/auth/SplashPage.dart';
import 'package:fraschetti_videocatalogo/screen/catalogo/ArticoloAggiungiPage.dart';
import 'package:fraschetti_videocatalogo/screen/catalogo/CatalogoPage.dart';
import 'package:fraschetti_videocatalogo/screen/home/HomePage.dart';
import 'package:fraschetti_videocatalogo/screen/auth/LoginPage.dart';
import 'package:fraschetti_videocatalogo/screen/catalogo/CatalogoLista.dart';
import 'package:fraschetti_videocatalogo/screen/auth/ParametriConnesionePage.dart';
import 'package:fraschetti_videocatalogo/screen/auth/RegistrazionePage.dart';
import 'package:page_transition/page_transition.dart';

class RouterApp {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // se non si è loggati si va il LoginPage
    // se non si è registrati si va in RegistrazionePage
    switch (settings.name) {
      case SplashPage.routeName:
        return MaterialPageRoute(builder: (context) => SplashPage());
      case LoginPage.routeName:
        return PageTransition(
          child: LoginPage(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        return MaterialPageRoute(builder: (context) => LoginPage());
      case RegistazionePage.routeName:
        return MaterialPageRoute(builder: (context) => RegistazionePage());
      case ParametriConnesionePage.routeName:
        return MaterialPageRoute(builder: (context) => ParametriConnesionePage());
      case CatalogoListaPage.routeName:
        return MaterialPageRoute(builder: (context) => CatalogoListaPage());
      case CatalogoPage.routeName:
        return MaterialPageRoute(builder: (context) => CatalogoPage());
      case ArticoloAggiungiPage.routeName:
        return MaterialPageRoute(builder: (context) => ArticoloAggiungiPage());
      default:
        return MaterialPageRoute(builder: (context) => SplashPage());
        // return MaterialPageRoute(builder: (context) => RegistazionePage());
      // return MaterialPageRoute(builder: (context) => LoginPage());
    }
  }
}
