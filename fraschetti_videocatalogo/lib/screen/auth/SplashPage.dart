import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:fraschetti_videocatalogo/repositories/httpRepository.dart';

import 'package:fraschetti_videocatalogo/main.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _StatefulWidget();
}

class _StatefulWidget extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    bool utenteRegistrato = false;

    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      await Future.delayed(Duration(seconds: 3));
      utenteRegistrato =
          await getIt.get<HttpRepository>().http!.utenteRegistrato();
      // await Future.delayed(Duration(seconds: 3));
      if (utenteRegistrato) {
        Navigator.of(context).pushNamed("/login");
        // Navigator.pushNamed(context, "/login");
        // Navigator.popAndPushNamed(context, "/login");
      } else {
        Navigator.of(context).pushNamed("/registrazione");
        // Navigator.pushNamed(context, "/registrazione");
        // Navigator.popAndPushNamed(context, "/registrazione");
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/immagini/splash_screen.png"),
              fit: BoxFit.contain,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Fraschetti",
                    style: TextStyle(
                        fontSize: 40, color: Theme.of(context).primaryColor),
                    // fontSize: 40, color: Color.fromRGBO(67, 122, 28, 1)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Distribuzione",
                    style: TextStyle(
                        fontSize: 20, color: Theme.of(context).primaryColor),
                    // fontSize: 20, color: Color.fromRGBO(67, 122, 28, 1)),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              // CircularProgressIndicator(
              //   color: Theme.of(context).primaryColor,
              // ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
