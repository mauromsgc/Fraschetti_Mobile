import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fraschetti_videocatalogo/models/parametriModel.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';

import 'package:fraschetti_videocatalogo/repositories/httpRepository.dart';

import 'package:fraschetti_videocatalogo/main.dart';
import 'package:fraschetti_videocatalogo/screen/auth/LoginPage.dart';
import 'package:fraschetti_videocatalogo/screen/auth/RegistrazionePage.dart';
import 'package:get_it/get_it.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = 'splash';

  @override
  State<StatefulWidget> createState() => new _StatefulWidget();
}

class _StatefulWidget extends State<SplashPage> {
  bool utenteRegistrato = false;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      utenteRegistrato = GetIt.instance<ParametriModel>().utente_registrato();

      // utenteRegistrato =
      //     await getIt.get<HttpRepository>().http!.utenteRegistrato();
      // await Future.delayed(Duration(seconds: 3));
      if (utenteRegistrato) {
        // Navigator.of(context).pushNamed(LoginPage.routeName);
        Navigator.popAndPushNamed(context, LoginPage.routeName);
      } else {
        // Navigator.of(context).pushNamed(RegistazionePage.routeName);
        Navigator.popAndPushNamed(context, RegistazionePage.routeName);
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
