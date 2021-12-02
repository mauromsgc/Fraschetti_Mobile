import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/screen/auth/SplashPage.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/ClientiLista.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/OrdineArticoloAggiungiPage.dart';
import 'package:fraschetti_videocatalogo/screen/catalogo/CatalogoPage.dart';
import 'package:fraschetti_videocatalogo/screen/comunicazioni/ComunicazionePage.dart';
import 'package:fraschetti_videocatalogo/screen/home/HomePage.dart';
import 'package:fraschetti_videocatalogo/screen/auth/LoginPage.dart';
import 'package:fraschetti_videocatalogo/screen/catalogo/CatalogoLista.dart';
import 'package:fraschetti_videocatalogo/screen/auth/ParametriConnesionePage.dart';
import 'package:fraschetti_videocatalogo/screen/auth/RegistrazionePage.dart';
import 'package:fraschetti_videocatalogo/screen/comunicazioni/ComunicazioneLista.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/OrdineCodiceCercaPage.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/OrdineLista.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/OrdineNoteAggiungiPage.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/OrdineResiLista.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/ResoArticoloAggiungiPage.dart';
import 'package:fraschetti_videocatalogo/screen/promozioni/PromozioneLista.dart';
import 'package:fraschetti_videocatalogo/screen/promozioni/PromozionePage.dart';
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
      case PromozioneListaPage.routeName:
        return MaterialPageRoute(builder: (context) => PromozioneListaPage());
      case PromozionePage.routeName:
        return MaterialPageRoute(builder: (context) => PromozionePage());
      case ComunicazioneListaPage.routeName:
        return MaterialPageRoute(builder: (context) => ComunicazioneListaPage());
      case ComunicazionePage.routeName:
        return MaterialPageRoute(builder: (context) => ComunicazionePage());

      case ClienteLista.routeName:
        return MaterialPageRoute(builder: (context) => ClienteLista());
      case OrdineLista.routeName:
        return MaterialPageRoute(builder: (context) => OrdineLista());
      case OrdineCodiceCercaPage.routeName:
        return MaterialPageRoute(builder: (context) => OrdineCodiceCercaPage());
      case OrdineArticoloAggiungiPage.routeName:
        return MaterialPageRoute(builder: (context) => OrdineArticoloAggiungiPage());
      case OrdineNoteAggiungiPage.routeName:
        return MaterialPageRoute(builder: (context) => OrdineNoteAggiungiPage());
      case OrdineResiLista.routeName:
        return MaterialPageRoute(builder: (context) => OrdineResiLista());
      case ResoArticoloAggiungiPage.routeName:
        return MaterialPageRoute(builder: (context) => ResoArticoloAggiungiPage());

      default:
        return MaterialPageRoute(builder: (context) => SplashPage());
        // return MaterialPageRoute(builder: (context) => RegistazionePage());
      // return MaterialPageRoute(builder: (context) => LoginPage());
    }
  }
}
