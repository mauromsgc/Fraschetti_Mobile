import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/utils/router_app.dart';
import 'package:fraschetti_videocatalogo/view/LoginPage.dart';


void main() {
  runApp(MyApp());
}

//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
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //primarySwatch: Colors.green,
      ),

      onGenerateRoute: RouterApp.generateRoute,
      //initialRoute: LoginPage.routeName,
      //onUnknownRoute: (context) => ErrorScreen(),


    );
  }
}


