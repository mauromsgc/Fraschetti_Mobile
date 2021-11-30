import 'package:flutter/material.dart';
import 'dart:async';

import 'package:logger/logger.dart';

class LogPage extends StatefulWidget {
  LogPage({Key? key}) : super(key: key);
  static const String routeName = 'log';

  final String pagina_titolo = "Log";

  @override
  _LogPageState createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  var loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

  String log_testo = "f";

  void log() {
    logger.d("Log message with 2 methods");

    loggerNoStack.i("Info message");

    loggerNoStack.w("Just a warning!");

    logger.e("Error! Something bad happened", "Test Error");

    loggerNoStack.v({"key": 5, "value": "something"});

    // Future.delayed(Duration(seconds: 10), log);

    // logger(printer: SimplePrinter(colors: true)).v('boom');

  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
            body: Center(
              child: Text("${log_testo}"),
            ),
        ),
      ),
    );
  }
}