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
import 'package:fraschetti_videocatalogo/screen/ordine/ResoArticoloAggiungiPage.dart';

class OrdineResiLista extends StatefulWidget {
  OrdineResiLista({Key? key}) : super(key: key);
  static const String routeName = "ordini_resi_clienti";
  final String pagina_titolo = "Reso cliente";

  @override
  _OrdineResiListaState createState() => _OrdineResiListaState();
}

class _OrdineResiListaState extends State<OrdineResiLista> {
  List<ComunicazioneModel> reso_righe_lista = ComunicazioniRepository().all_2();

  void listaClick(BuildContext context) {
    Navigator.pushNamed(context, ResoArticoloAggiungiPage.routeName);
  }

  void articolo_disponibilita_mostra(BuildContext context) {
    Navigator.pushNamed(context, DisponibilitaPage.routeName);
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

  void reso_numeroOnSubmit(BuildContext context) {
    return;
  }


  void resi_azioni_mostra(){

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Seleziona un'azione"),
        content: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 40,
                // width: double.maxFinite,
                width: 200,
                padding: EdgeInsets.all(5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 2),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Reso chiudi'),
                ),
              ),
              Container(
                height: 40,
                // width: double.maxFinite,
                width: 200,
                padding: EdgeInsets.all(5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 2),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Reso elimina'),
                ),
              ),

            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Chiudi'),
          ),
        ],
      ),
    );

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
          actions: [
            IconButton(
              onPressed: () {
                resi_azioni_mostra();
              },
              icon: Icon(Icons.more_vert),
            )
          ],        ),
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
                Divider(),
                OrdineIntestazioneWidget(),
                Divider(
                  height: 5,
                  thickness: 2,
                  // color: Theme.of(context).primaryColor,
                ),
                ListaWidget(reso_righe_lista),
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
            SizedBox(
              height: 10,
            ),
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
            SizedBox(
              height: 10,
            ),
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
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    // padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 2),
                      onPressed: () => reso_numeroOnSubmit(context),
                      child: Text('Reso numero X'),
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
  Widget ListaWidget(List<ComunicazioneModel> reso_righe_lista) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          height: 5,
          thickness: 2,
          color: Theme.of(context).primaryColor,
        ),
        itemCount: reso_righe_lista.length,
        // itemCount: 10,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key("${index}"),
            background: Container(
              child: Padding(
                padding: const EdgeInsets.all(15),
                // child: Icon(Icons.favorite, color: Colors.white),
              ),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.delete, color: Colors.white),
                    Text('Elimina', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            confirmDismiss: (DismissDirection direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Attenzione"),
                    content: const Text("Eliminara la riga corrente?"),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text("Annulla"),
                      ),
                      ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text("Elimina")),
                    ],
                  );
                },
              );
            },
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd) {
                print("Add to favorite");
              } else {
                print('Remove item');
              }

              setState(() {
                reso_righe_lista.removeAt(index);
                  lista_elemento_elimina(context);
              });
            },
            child: InkWell(
              onTap: () {
                listaClick(context);
              },
              onLongPress: () {
                articolo_disponibilita_mostra(context);
              },
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(2),
                      alignment: Alignment(-1.0, 0.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        "X - reso causale rso causale",
                        maxLines: 2,
                        style: TextStyle(
                          // fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Row(
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
                          width: 75,
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
                          width: 80,
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
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
