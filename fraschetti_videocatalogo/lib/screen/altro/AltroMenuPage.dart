import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/helper/DBHelper.dart';
import 'package:fraschetti_videocatalogo/main.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/models/parametriModel.dart';
import 'package:fraschetti_videocatalogo/models/utenteCorrenteModel.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:fraschetti_videocatalogo/repositories/httpRepository.dart';
import 'package:fraschetti_videocatalogo/screen/altro/TestPage.dart';
import 'package:fraschetti_videocatalogo/screen/auth/ParametriConnesionePage.dart';
import 'package:fraschetti_videocatalogo/utils/Utility.dart';
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

  void immagini_aggiorna_mancanti(BuildContext context) async {
    final valid =
        await GetIt.instance<DbRepository>().immagini_mancanti_aggiorna();
  }

  void versione_aggiornamento_mostra(BuildContext context) async {
    String versione_aggiornamento = """
  agg. dati = ${GetIt.instance<ParametriModel>().agg_dati_id},
  agg. immagini = ${GetIt.instance<ParametriModel>().agg_immagini_id},
  agg. comunicazioni = ${GetIt.instance<ParametriModel>().agg_comunicazioni_id},
  agg. sql = ${GetIt.instance<ParametriModel>().agg_sql_id},
  sql. versione = ${GetIt.instance<ParametriModel>().sql_versione}.
  """;
    // final valid = await GetIt.instance<DbRepository>().immagini_mancanti_aggiorna();

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Verisione aggiornamento"),
        content: Text("${versione_aggiornamento}"),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () => Navigator.pop(context), child: Text("Chiudi")),
        ],
      ),
    );
  }

  void versione_videocatalogo_mostra(BuildContext context) async {
    String versione_aggiornamento = """
  Versione: ${VIDEOCATALOGO_DISPOSIVITO_TIPO} ${VIDEOCATALOGO_VERSIONE}
  """;
    // final valid = await GetIt.instance<DbRepository>().immagini_mancanti_aggiorna();

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Videocatalogo"),
        content: Text("${versione_aggiornamento}"),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () => Navigator.pop(context), child: Text("Chiudi")),
        ],
      ),
    );
  }

  void test_1() async {
    final valid = await GetIt.instance<DbRepository>().comunicazioni_aggiorna();
    if (valid) {
      print("Aggiornamento completato");
    } else {
      print("Errore durante l'aggiornamento, riprovare");
    }
  }

  void test_2() async {
    final valid = await GetIt.instance<DbRepository>().immagini_aggiorna();
    if (valid) {
      print("Aggiornamento completato");
    } else {
      print("Errore durante l'aggiornamento, riprovare");
    }

    // Navigator.pushNamed(context, TestPage.routeName);
  }

  void test_3() async {
    // GetIt.instance<ParametriModel>().inizializza();
    //
    // print(GetIt.instance<ParametriModel>().toMap().toString());

    Navigator.pushNamed(context, TestPage.routeName);
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
                      // solo per agenti
                      height: 50,
                      width: double.maxFinite,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 2),
                        onPressed: () {
                          versione_aggiornamento_mostra(context);
                        },
                        child: Text('Versioni aggiornamento'),
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
                      // lo fa già il server
                      height: 50,
                      width: double.maxFinite,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 2),
                        onPressed: () {
                          versione_videocatalogo_mostra(context);
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
                          immagini_aggiorna_mancanti(context);
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
