import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/main.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/models/comunicazioneModel.dart';
import 'package:fraschetti_videocatalogo/repositories/comunicazioniRepository.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:fraschetti_videocatalogo/screen/comunicazioni/ComunicazionePage.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_it/get_it.dart';


class ComunicazioneListaPage extends StatefulWidget {
  ComunicazioneListaPage({Key? key}) : super(key: key);
  static const String routeName = "comunicazione_lista";
  final String pagina_titolo = "Comunicazioni";

  @override
  _ComunicazioneListaPageState createState() => _ComunicazioneListaPageState();
}

final pageStato = PageStore().obs;

class PageStore {
  List<Map> comunicazioni_lista = [];

  PageStore() {
    print("PageStore inizializza ");
    inizializza();
  }

  void inizializza() async {
    _comunicazioni_lista_carica();
  }

  Future<void> _comunicazioni_lista_carica() async {
    comunicazioni_lista = await ComunicazioneModel.comunicazioni_lista();
    print("comunicazioni_lista: " + comunicazioni_lista.length.toString());

    pageStato.refresh();
  }

  void comunicazioni_cerca() async {
    _comunicazioni_lista_carica();
  }

  void comunicazioni_da_leggere() async {
    _comunicazioni_lista_carica();
  }

  void comunicazioni_lette() async {
    _comunicazioni_lista_carica();
  }
}

class _ComunicazioneListaPageState extends State<ComunicazioneListaPage> {
  @override
  void initState() {
    super.initState();
  }

  void listaClick(BuildContext context) {
    Navigator.pushNamed(context, ComunicazionePage.routeName);
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
          // title: Text("${getIt.get<SessioneModel>().bottom_bar_indice.toString()} ${widget.pagina_titolo}"),
          title: Text(widget.pagina_titolo),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomBarWidget(),
        body: Container(
          child: Container(
            // padding: new EdgeInsets.all(10.0),
            // decoration: MyBoxDecoration().MyBox(),
            // width: 600,
            child: Column(
              children: <Widget>[
                RicercaWidget(),
                SelezioniWidget(),
                Divider(
                  height: 5,
                  thickness: 2,
                  // color: Theme.of(context).primaryColor,
                ),
                Obx(
                      () => ListaWidget(pageStato.value.comunicazioni_lista),
                ),
              ],
            ),
          ),
        ),
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
              flex: 5,
              child: TextFormField(
                onEditingComplete: () {
                  pageStato.value.comunicazioni_cerca();

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
                  hintText: 'Oggetto',
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 3,
              child: TextFormField(
                onEditingComplete: () {
                  pageStato.value.comunicazioni_cerca();

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
                  hintText: 'ID',
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
                onPressed: () {
                  pageStato.value.comunicazioni_cerca();

                },
                child: Text('Cerca'),
              ),
            ),
          ],
        ),
      ),
    );
  }

// da modificare con un pulsante a destra del pulsante menu
// va messo all'interno del title
// sezione selezioni
  Widget SelezioniWidget() {
    return Padding(
      padding: EdgeInsets.all(3),
      child: SizedBox(
        height: 40,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 2),
                onPressed: () {
                  pageStato.value.comunicazioni_da_leggere();

                },
                child: Text('Da leggere'),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 2),
                onPressed: () {
                  pageStato.value.comunicazioni_lette();

                },
                child: Text('Lette'),
              ),
            ),
          ],
        ),
      ),
    );
  }

// riga lista
  Widget ListaWidget(List<Map> comunicazioni_lista) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          height: 5,
          thickness: 2,
          color: Theme.of(context).primaryColor,
        ),
        itemCount: comunicazioni_lista.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              listaClick(context);
            },
            child: Container(
              height: 50,
              // decoration: MyBoxDecoration().MyBox(),
              child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      decoration: MyBoxDecoration().MyBox(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${comunicazioni_lista[index]['id']}",
                            style: TextStyle(
                              // fontSize: 12,
                            ),
                          ),
                          Text(
                            "${comunicazioni_lista[index]['data']}",
                            style: TextStyle(
                              // fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment(-1.0, 0.0),
                        padding: EdgeInsets.all(5.0),
                        decoration: MyBoxDecoration().MyBox(),
                        child: Text(
                              "${comunicazioni_lista[index]['oggetto']}",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  overflow: TextOverflow.ellipsis
                              ),
                            ),

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
