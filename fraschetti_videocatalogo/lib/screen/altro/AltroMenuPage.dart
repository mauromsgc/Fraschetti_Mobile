import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/screen/auth/ParametriConnesionePage.dart';
import 'package:get_it/get_it.dart';

class AltroMenuLista extends StatefulWidget {
  AltroMenuLista({Key? key}) : super(key: key);
  static const String routeName = "altro_menu_lista";
  final String pagina_titolo = "Altro";

  @override
  _AltroMenuListaState createState() => _AltroMenuListaState();
}

class _AltroMenuListaState extends State<AltroMenuLista> {
  void listaClick(BuildContext context, int index) {
    // selezione al cliente e va in ordine
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.menu),
          // ),
          title: Text(widget.pagina_titolo),
          centerTitle: true,
          // bottom: OrdineTopMenu(context),
        ),
        bottomNavigationBar: BottomBarWidget(),
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: 5,
              ),

              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    // width: double.maxFinite,
                    width: 300,
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 2),
                      onPressed: () {
                        Navigator.pushNamed(context, ParametriConnesionePage.routeName);
                      },
                      child: Text('Parametri di connessione'),
                    ),
                  ),
                  Container(
                    height: 50,
                    // width: double.maxFinite,
                    width: 300,
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 2),
                      onPressed: () {
                        // Navigator.of(context).pop();
                      },
                      child: Text('Test trasmissione'),
                    ),
                  ),
                  Container(
                    // lo fa già il server
                    height: 50,
                    // width: double.maxFinite,
                    width: 300,
                    // padding: EdgeInsets.all(5),
                    // child: ElevatedButton(
                    //   style: ElevatedButton.styleFrom(elevation: 2),
                    //   onPressed: () {
                    //     Navigator.of(context).pop();
                    //   },
                    //   child: Text('Invia email senza prezzi'),
                    // ),
                  ),
                  Container(
                    // solo per agenti
                    height: 50,
                    // width: double.maxFinite,
                    width: 300,
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 2),
                      onPressed: () {
                        // Navigator.of(context).pop();
                      },
                      child: Text('Versioni aggiornamento'),
                    ),
                  ),
                  Container(
                    // lo fa già il server
                    height: 50,
                    // width: double.maxFinite,
                    width: 300,
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 2),
                      onPressed: () {
                        // Navigator.of(context).pop();
                      },
                      child: Text('Versione videocatalogo'),
                    ),
                  ),
                  Container(
                    // lo fa già il server
                    height: 50,
                    // width: double.maxFinite,
                    width: 300,
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 2),
                      onPressed: () {
                        // Navigator.of(context).pop();
                      },
                      child: Text('Aggiorna immagini non presenti'),
                    ),
                  ),
                  Container(
                    // lo fa già il server
                    height: 50,
                    // width: double.maxFinite,
                    width: 300,
                    // padding: EdgeInsets.all(5),
                    // child: ElevatedButton(
                    //   style: ElevatedButton.styleFrom(elevation: 2),
                    //   onPressed: () {
                    //     Navigator.of(context).pop();
                    //   },
                    //   child: Text('Invia email senza prezzi'),
                    // ),
                  ),
                  Container(
                    // solo per agenti
                    height: 50,
                    // width: double.maxFinite,
                    width: 300,
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 2),
                      onPressed: () {
                        // Navigator.of(context).pop();
                      },
                      child: Text('Modifica password'),
                    ),
                  ),
                  Container(
                    // lo fa già il server
                    height: 50,
                    // width: double.maxFinite,
                    width: 300,
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 2),
                      onPressed: () {
                        // Navigator.of(context).pop();
                      },
                      child: Text('Disinstallare videocatalogo'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
