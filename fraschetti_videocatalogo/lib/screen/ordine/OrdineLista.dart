import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/components/OrdineTopMenu.dart';
import 'package:fraschetti_videocatalogo/main.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/models/comunicazioneModel.dart';
import 'package:fraschetti_videocatalogo/repositories/comunicazioniRepository.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/OrdineArticoloAggiungiPage.dart';

class OrdineLista extends StatefulWidget {
  OrdineLista({Key? key}) : super(key: key);
  static const String routeName = "ordini_clienti";
  final String pagina_titolo = "Ordine cliente";

  @override
  _OrdineListaState createState() => _OrdineListaState();
}

class _OrdineListaState extends State<OrdineLista> {
  List<ComunicazioneModel> ordine_righe_lista =
      ComunicazioniRepository().all_2();

  @override
  void initState() {
    super.initState();
  }

  void listaClick(BuildContext context) {
    Navigator.pushNamed(context, OrdineArticoloAggiungiPage.routeName);
  }

  void lista_elemento_elimina(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Elimina riga ordine'),
        content: const Text('Eliminare la riga ordine?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Elimna'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annulla'),
          ),
        ],
      ),
    );

  }


  void ordine_numeroOnSubmit(BuildContext context) {
    return;
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
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     color: Colors.orange,
            //     width: 2,
            //   ),
            // ),
            // width: 600,
            child: Column(
              children: <Widget>[
                OrdineTopMenu(),
                OrdineIntestazioneWidget(),
                ListaWidget(ordine_righe_lista),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget OrdineIntestazioneWidget() {
    return Padding(
      padding: EdgeInsets.all(3),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Container(
              // cliente nominativo
              // padding: EdgeInsets.all(3),
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
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    // articolo codice
                    width: 100,
                    // padding: EdgeInsets.all(5),
                    child: TextFormField(
                      // readOnly: true,
                      enabled: false,
                      initialValue: "Località cliente cliente",
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        labelText: "Località",
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  flex: 2,
                  child: Container(
                    // padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 2),
                      onPressed: () => ordine_numeroOnSubmit(context),
                      child: Text('Ordine numero X'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

// riga lista
  Widget ListaWidget(List<ComunicazioneModel> ordine_righe_lista) {
    return Expanded(
      child: ListView.builder(
        // itemCount: ordine_righe_lista.length,
        itemCount: 10,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              listaClick(context);
            },
            onTapCancel: () {
              lista_elemento_elimina(context);
            },
            onLongPress: () {
              lista_elemento_elimina(context);
            },
            child: Container(
              // height: 80,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    // codice
                    alignment: Alignment(0.0, 1.0),
                    width: 60,
                    // color: Colors.orange,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      "000000",
                      // style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                  Expanded(
                    // descrizione
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      alignment: Alignment(-1.0, 0.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Articolo descrizione Articolo descrizione Articolo descrizione Articolo descrizione Articolo descrizione Articolo descrizione Articolo descrizione Articolo descrizione",
                            maxLines: 1,
                            style: TextStyle(
                              // fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            "Codice descrizione Codice descrizione Codice descrizione Codice descrizione Codice descrizione Codice descrizione Codice descrizione Codice descrizione Codice descrizione Codice descrizione Codice descrizione Codice descrizione ",
                            maxLines: 2,
                            style: TextStyle(
                              // fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    // unità di misura
                    alignment: Alignment(0.0, 0.0),
                    width: 25,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      "XC",
                      // style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  Container(
                    // quantità
                    padding: EdgeInsets.all(2),
                    alignment: Alignment(1.0, 0.0),
                    width: 45,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      "1500",
                      // style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  Container(
                    // prezzo
                    padding: EdgeInsets.all(2),
                    alignment: Alignment(1.0, 0.0),
                    width: 70,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      "99999,00",
                      // style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  Container(
                    // totale
                    padding: EdgeInsets.all(2),
                    alignment: Alignment(1.0, 0.0),
                    width: 75,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      "999999,00",
                      // style: TextStyle(fontSize: 18.0),
                    ),
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
