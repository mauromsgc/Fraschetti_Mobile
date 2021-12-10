import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/components/OrdineTopMenu.dart';
import 'package:fraschetti_videocatalogo/main.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/models/comunicazioneModel.dart';
import 'package:fraschetti_videocatalogo/repositories/comunicazioniRepository.dart';
import 'package:fraschetti_videocatalogo/screen/disponibilita/DisponibilitaPage.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/OrdineArticoloAggiungiPage.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';

class OrdineCodiceCercaPage extends StatefulWidget {
  OrdineCodiceCercaPage({Key? key}) : super(key: key);
  static const String routeName = "ordini_codice_cerca";
  final String pagina_titolo = "Ordini";

  @override
  _OrdineCodiceCercaPageState createState() => _OrdineCodiceCercaPageState();
}

class _OrdineCodiceCercaPageState extends State<OrdineCodiceCercaPage> {
  List<ComunicazioneModel> codici_lista = ComunicazioniRepository().all_2();

  void listaClick(BuildContext context) {
    Navigator.pushNamed(context, OrdineArticoloAggiungiPage.routeName);
  }

  void articolo_disponibilita_mostra(BuildContext context) {
    Navigator.pushNamed(context, DisponibilitaPage.routeName);
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
          child: Container(
            // padding: new EdgeInsets.all(10.0),
            // decoration: MyBoxDecoration().MyBox(),
            // width: 600,
            child: Column(
              children: <Widget>[
                OrdineTopMenu(),
                Divider(),
                ClienteIntestazioneWidget(),
                RicercaWidget(),
                Divider(
                  height: 5,
                  thickness: 2,
                  // color: Theme.of(context).primaryColor,
                ),
                ListaWidget(codici_lista),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ClienteIntestazioneWidget() {
    return Container(
      padding: EdgeInsets.all(3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // cliente nominativo
            // padding: EdgeInsets.all(5),
            child: TextFormField(
              enabled: false,
              initialValue: "0000 Cliente Cliente Cliente",
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                border: OutlineInputBorder(),
                labelText: "Cliente",
              ),
            ),
          ),
        ],
      ),
    );
  }

  // sezione ricerca
  Widget RicercaWidget() {
    return Padding(
      padding: EdgeInsets.all(3),
      child: SizedBox(
        height: 40,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: TextFormField(
                onEditingComplete: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Avviare ricerca'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('ok'),
                        ),
                      ],
                    ),
                  );
                },
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                  border: OutlineInputBorder(),
                  hintText: 'Codice',
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 6,
              child: TextFormField(
                onEditingComplete: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Avviare ricerca'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('ok'),
                        ),
                      ],
                    ),
                  );
                },
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                  border: OutlineInputBorder(),
                  hintText: 'Descrizione',
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 2),
                onPressed: () {},
                child: Text('Cerca'),
              ),
            ),
          ],
        ),
      ),
    );
  }

// riga lista
  Widget ListaWidget(List<ComunicazioneModel> codici_lista) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          height: 5,
          thickness: 2,
          color: Theme.of(context).primaryColor,
        ),
        // itemCount: codici_lista.length,
        itemCount: 10,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              listaClick(context);
            },
            onLongPress: () {
              articolo_disponibilita_mostra(context);
            },
            child: Container(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: MyBorder().MyBorderOrange(),
                        image: DecorationImage(
                          image: AssetImage("assets/immagini/splash_screen.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // codice
                                padding: EdgeInsets.all(2),
                                alignment: Alignment(0.0, 0.0),
                                width: 70,
                                // color: Colors.orange,
                                decoration: MyBoxDecoration().MyBox(),
                                child: Text(
                                  "000000",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    // fontSize: 18.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                // descrizione
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  alignment: Alignment(-1.0, 0.0),
                                  decoration: MyBoxDecoration().MyBox(),
                                  child: Text(
                                    "Articolo Articolo Articolo Articolo Articolo Articolo Articolo Articolo",
                                    style: TextStyle(
                                      // fontSize: 14.0,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                // prezzo
                                padding: EdgeInsets.all(3),
                                alignment: Alignment(1.0, 0.0),
                                width: 85,
                                decoration: MyBoxDecoration().MyBox(),
                                child: Text(
                                  "99999,99",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    // fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(2),
                            alignment: Alignment(-1.0, 0.0),
                            decoration: MyBoxDecoration().MyBox(),
                            child: Text(
                              "Codice Codice Codice Codice Codice Codice Codice Codice Codice Codice Codice Codice Codice Codice Codice Codice Codice Codice",
                              maxLines: 3,
                              style: TextStyle(
                                // fontSize: 14.0,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Column(
                      //   children: [
                      //
                      //     Expanded(
                      //       // descrizione
                      //       flex: 1,
                      //       child: Container(
                      //         padding: EdgeInsets.all(2),
                      //         alignment: Alignment(-1.0, 0.0),
                      //         decoration: MyBoxDecoration().MyBox(),
                      //         child: Text(
                      //           "Codice Codice Codice Codice Codice Codice Codice Codice Codice Codice Codice Codice Codice Codice Codice Codice Codice Codice",
                      //           style: TextStyle(
                      //             // fontSize: 14.0,
                      //             overflow: TextOverflow.ellipsis,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //
                      //   ],
                      // ),
                    ),
                  ],
                ),
            ),
          );
        },
      ),
    );
  }
}