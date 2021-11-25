import 'dart:async';

import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _StatefulWidget();
}

class _StatefulWidget extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // print("initState");
    // Future.delayed(Duration(seconds: 5));
    // print("5 secondi");
    //Navigator.of(context).pushNamed("/home");
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
