import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/models/comunicazioneModel.dart';
import 'package:fraschetti_videocatalogo/screen/comunicazioni/ComunicazionePage.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';

class ComunicazioneListaPage extends StatefulWidget {
  ComunicazioneListaPage({Key? key}) : super(key: key);
  static const String routeName = "comunicazione_lista";
  final String pagina_titolo = "Comunicazioni";

  @override
  _ComunicazioneListaPageState createState() => _ComunicazioneListaPageState();
}


class _ComunicazioneListaPageState extends State<ComunicazioneListaPage> {
  List<Map> comunicazioni_lista = [];

  int lista_numero_elementi = 0;

  final TextEditingController oggettoController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (lista_numero_elementi == 0) {
      _comunicazioni_lista_cerca(stato: "da_leggere");
    }
  }

  Future<void> _comunicazioni_lista_svuota() async {
    comunicazioni_lista = [];
    lista_numero_elementi = comunicazioni_lista.length;
    setState(() {});
  }

  Future<void> _comunicazioni_lista_cerca({
    String oggetto = "",
    int id = 0,
    String stato = "",
  }) async {
    if ((stato != "")) {
      oggettoController.clear();
      idController.clear();
      setState(() {});
    }
    comunicazioni_lista =
        await ComunicazioneModel.comunicazioni_lista(
      oggetto: oggettoController.text,
      id: (idController.text != "") ? int.parse(idController.text) : 0,
      stato: stato,
    );
    lista_numero_elementi =
        comunicazioni_lista.length;
    setState(() {});
  }

  void listaClick(BuildContext context, int indice) {
    Navigator.pushNamed(
      context,
      ComunicazionePage.routeName,
      arguments: ComunicazionePageArgs(
        comunicazioni_lista: comunicazioni_lista.toList(),
        indice: indice,
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
          // title: Text("${getIt.get<SessioneModel>().bottom_bar_indice.toString()} ${widget.pagina_titolo}"),
          title: Column(
            children: [
              Text(widget.pagina_titolo),
              // if(lista_numero_elementi >0)
              Text(
                  "${lista_numero_elementi} elementi",
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
            ],
          ),
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
                ListaWidget(comunicazioni_lista),
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
                // autofocus: true,
                controller: oggettoController,
                onChanged: (value) {
                  // Call setState to update the UI
                  idController.clear();
                  setState(() {});
                  // if(oggettoController.text.length >=3){
                  _comunicazioni_lista_cerca();
                  // }
                },
                onEditingComplete: () {
                  _comunicazioni_lista_cerca();
                },
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                  border: OutlineInputBorder(),
                  hintText: 'Oggetto',
                  suffixIcon: oggettoController.text.length == 0
                      ? null
                      : IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            oggettoController.clear();
                            setState(() {});
                            _comunicazioni_lista_cerca();
                          },
                        ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: idController,
                onChanged: (value) {
                  // Call setState to update the UI
                  oggettoController.clear();
                  setState(() {});
                  // if(idController.text.length >=2){
                  _comunicazioni_lista_cerca();
                  // }
                },
                onEditingComplete: () {
                  _comunicazioni_lista_cerca();
                },
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                  border: OutlineInputBorder(),
                  hintText: 'ID',
                  suffixIcon: idController.text.length == 0
                      ? null
                      : IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            idController.clear();
                            setState(() {});
                            _comunicazioni_lista_cerca();
                          },
                        ),
                ),
              ),
            ),
            // SizedBox(
            //   width: 10,
            // ),
            // Expanded(
            //   flex: 2,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(elevation: 2),
            //     onPressed: () {
            //       _comunicazioni_lista_cerca();
            //     },
            //     child: Text('Cerca'),
            //   ),
            // ),
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
                  _comunicazioni_lista_cerca(stato: "da_leggere");
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
                  _comunicazioni_lista_cerca(stato: "lette");
                },
                child: Text('Lette'),
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
                  _comunicazioni_lista_cerca(stato: "tutte");
                },
                child: Text('Tutte'),
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
          // color: Theme.of(context).primaryColor,
        ),
        itemCount: comunicazioni_lista.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              listaClick(context, index);
            },
            child: Container(
              height: 50,
              color: (comunicazioni_lista[index]['da_leggere'] == 1)
                  ? Colors.red.shade100
                  : null,
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
                            fontSize: 18.0, overflow: TextOverflow.ellipsis),
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
