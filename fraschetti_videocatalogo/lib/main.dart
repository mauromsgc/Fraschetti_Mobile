
import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/models/parametriModel.dart';
import 'package:fraschetti_videocatalogo/models/utenteCorrenteModel.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:fraschetti_videocatalogo/repositories/httpRepository.dart';
import 'package:fraschetti_videocatalogo/utils/router_app.dart';
import 'package:logger/logger.dart';

// final log_app = Logger();

void main() async{
  // log_app.v("Verbose log");
  // log_app.d("Debug log");
  // log_app.i("Info log");
  // log_app.w("Warning log");
  // log_app.e("Error log");
  // log_app.wtf("What a terrible failure log");


  // per attendere che carichi tutte le librerie
  WidgetsFlutterBinding.ensureInitialized();

  // per gestione date in formato corretto
  Intl.defaultLocale = 'it_IT';
  await initializeDateFormatting('it_IT', null);

  // GetIt.instance.registerSingleton<DBHelper>(DBHelper());
// Singleton connessione al database
  final db = await DbRepository.newConnection();
  GetIt.instance.registerSingleton(db);

  // singleton per connessione http
  GetIt.instance.registerSingleton(HttpRepository());
  // getIt.registerSingleton<HttpRepository>(HttpRepository());

  // singleton per gestione variabili dello stato globale (cliente selezionato, numero ordine attuale ecc.)
  GetIt.instance.registerSingleton<SessioneModel>(SessioneModel());

  // singleton accesso parametri salvati nel database (username, id aggiornament ecc.)
  GetIt.instance.registerSingleton<ParametriModel>(ParametriModel());

  // singleton variabili utente utilizzatore (dati utente da tabella e calcolati)
  GetIt.instance.registerSingleton<UtenteCorrenteModel>(UtenteCorrenteModel());

  runApp(MyApp());


}

class MyApp extends StatelessWidget {

  @override
  void dispose() {
    // chiudo la connessione al database
    GetIt.instance<DbRepository>().database.close();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

      onGenerateRoute: RouterApp.generateRoute,
      // home: SplashPage(), // con il default in onGenerateRoute non serve



    );
  }

  MyApp();
}


