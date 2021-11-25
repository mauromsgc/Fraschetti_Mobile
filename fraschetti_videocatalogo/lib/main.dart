
import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/screen/SplashPage.dart';
import 'package:fraschetti_videocatalogo/utils/router_app.dart';
import 'package:fraschetti_videocatalogo/view/HomePage.dart';
import 'package:fraschetti_videocatalogo/view/LoginPage.dart';


void main() {
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

        // Define the default font family.
        // fontFamily: 'Georgia',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),

      // onGenerateRoute: RouterApp.generateRoute,
      //onUnknownRoute: (context) => ErrorScreen(),
      initialRoute: "/splash",
      routes: {
        "/splash": (_) => SplashPage(),
        "/home": (_) => HomePage(),
      },


    );
  }
}


