import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/main.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/models/parametriModel.dart';
import 'package:fraschetti_videocatalogo/models/utenteCorrenteModel.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:fraschetti_videocatalogo/repositories/httpRepository.dart';
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

  void testComunicazioneOnSubmit(BuildContext context) async {
    final response = await getIt.get<HttpRepository>().http!.trasmissione_test();

    print(response);
  }

  void test_1() async {

    final valid = await GetIt.instance<DbRepository>().comunicazioni_aggiorna();
    if (valid) {
      print("Aggiornamento completato");
    } else {
      print("Errore durante l'aggiornamento, riprovare");
    }

  }

  void test_2() async{
    final valid = await GetIt.instance<DbRepository>().immagini_aggiorna();
    if (valid) {
      print("Aggiornamento completato");
    } else {
      print("Errore durante l'aggiornamento, riprovare");
    }

  }

  void test_3() async{
    getIt.get<ParametriModel>().inizializza();

    print(getIt.get<ParametriModel>().toMap().toString());

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
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                top: 5,
              ),
              child: Container(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: double.maxFinite,
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
                      width: double.maxFinite,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 2),
                        onPressed: () => testComunicazioneOnSubmit(context),
                        child: Text('Test trasmissione'),
                      ),
                    ),
                    Container(
                      // lo fa già il server
                      height: 50,
                      width: double.maxFinite,
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
                      width: double.maxFinite,
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
                      width: double.maxFinite,
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
                      width: double.maxFinite,
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
                      width: double.maxFinite,
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
                      width: double.maxFinite,
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
                      width: double.maxFinite,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 2),
                        onPressed: () {
                          // Navigator.of(context).pop();
                        },
                        child: Text('Disinstallare videocatalogo'),
                      ),
                    ),
                    Container(
                      // lo fa già il server
                      height: 100,
                      width: double.maxFinite,
                      padding: EdgeInsets.all(5),

                    ),
                    Container(
                      // lo fa già il server
                      height: 50,
                      width: double.maxFinite,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 2),
                        onPressed: () {
                          test_1();
                        },
                        child: Text('Test 1 comunicazioni'),
                      ),
                    ),
                    Container(
                      // lo fa già il server
                      height: 50,
                      width: double.maxFinite,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 2),
                        onPressed: () {
                          test_2();
                        },
                        child: Text('Test 2 immagini'),
                      ),
                    ),
                    Container(
                      // lo fa già il server
                      height: 50,
                      width: double.maxFinite,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 2),
                        onPressed: () {
                          test_3();
                        },
                        child: Text('Ricarica parametri'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
