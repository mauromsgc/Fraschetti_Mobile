
import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:fraschetti_videocatalogo/repositories/httpRepository.dart';
import 'package:fraschetti_videocatalogo/utils/router_app.dart';


final getIt = GetIt.instance;

void main() async{
  // per attendere che carichi tutte le librerie
  WidgetsFlutterBinding.ensureInitialized();

  Intl.defaultLocale = 'it_IT';
  await initializeDateFormatting('it_IT', null);

  final db = await DbRepository.newConnection();
  GetIt.instance.registerSingleton(db);

  getIt.registerSingleton<HttpRepository>(HttpRepository());


  // SessioneModel sessione = SessioneModel();
  // var test = "Pippo pippo".obs;
  getIt.registerSingleton<SessioneModel>(SessioneModel());

  runApp(MyApp());


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

      onGenerateRoute: RouterApp.generateRoute,
      // home: SplashPage(), // con il default in onGenerateRoute non serve



    );
  }
}


