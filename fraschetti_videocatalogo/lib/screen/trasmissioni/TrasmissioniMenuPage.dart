import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/screen/trasmissioni/TrasmissioneLista.dart';
import 'package:get_it/get_it.dart';

class TrasmissioniMenuLista extends StatefulWidget {
  TrasmissioniMenuLista({Key? key}) : super(key: key);
  static const String routeName = "trasmissioni_menu_lista";
  final String pagina_titolo = "Trasmissioni";

  @override
  _TrasmissioniMenuListaState createState() => _TrasmissioniMenuListaState();
}

class _TrasmissioniMenuListaState extends State<TrasmissioniMenuLista> {
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
                        // Navigator.of(context).pop();
                      },
                      child: Text('Trasmetti ordini'),
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
                      child: Text('Aggiorna da server'),
                    ),
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
                        Navigator.popAndPushNamed(context, TrasmissioneLista.routeName);
                      },
                      child: Text('Trasmissioni esito'),
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
                        // Navigator.popAndPushNamed(context, routeName);
                      },
                      child: Text('Trasmissioni fallite'),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
