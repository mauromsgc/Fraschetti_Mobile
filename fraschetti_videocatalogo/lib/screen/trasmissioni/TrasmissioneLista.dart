import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/main.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/models/comunicazioneModel.dart';
import 'package:fraschetti_videocatalogo/repositories/comunicazioniRepository.dart';
import 'package:fraschetti_videocatalogo/screen/comunicazioni/ComunicazionePage.dart';
import 'package:fraschetti_videocatalogo/screen/trasmissioni/TrasmissionePage.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';


class TrasmissioneLista extends StatefulWidget {
  TrasmissioneLista({Key? key}) : super(key: key);
  static const String routeName = "trasmissione_lista";
  final String pagina_titolo = "Trasmissioni";

  @override
  _TrasmissioneListaState createState() => _TrasmissioneListaState();
}

class _TrasmissioneListaState extends State<TrasmissioneLista> {
  List<ComunicazioneModel> trasmissioni_lista =
  ComunicazioniRepository().all_2();

  void listaClick(BuildContext context) {
    Navigator.pushNamed(context, TrasmissionePage.routeName);
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
                ListaWidget(trasmissioni_lista),
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
              flex: 8,
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
                  hintText: 'Trasmissione id',
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
                onPressed: () {},
                child: Text('Mostra tutto'),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 2),
                onPressed: () {},
                child: Text('Inviate'),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 2),
                onPressed: () {},
                child: Text('Non inviate'),
              ),
            ),
          ],
        ),
      ),
    );
  }


// riga lista
  Widget ListaWidget(List<ComunicazioneModel> trasmissioni_lista) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          height: 5,
          thickness: 2,
          // color: Theme.of(context).primaryColor,
        ),
        itemCount: trasmissioni_lista.length,
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
                    width: 70,
                    decoration: MyBoxDecoration().MyBox(),
                    alignment: Alignment.center,
                    child: Text(
                      "00000",
                      style: TextStyle(
                          fontSize: 18.0,
                          overflow: TextOverflow.ellipsis
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // alignment: Alignment(-1.0, 0.0),
                      padding: EdgeInsets.all(5.0),
                      decoration: MyBoxDecoration().MyBox(),
                      alignment: Alignment.centerRight,
                      child: Text(
                        "55555555",
                        style: TextStyle(
                            fontSize: 18.0,
                            overflow: TextOverflow.ellipsis
                        ),
                      ),

                    ),
                  ),
                  Container(
                    width: 120,
                    decoration: MyBoxDecoration().MyBox(),
                    alignment: Alignment.center,
                    child: Text(
                      "00/00/0000",
                      style: TextStyle(
                          fontSize: 18.0,
                          overflow: TextOverflow.ellipsis
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    decoration: MyBoxDecoration().MyBox(),
                    alignment: Alignment.center,
                    child: Text(
                      "000",
                      style: TextStyle(
                          fontSize: 18.0,
                          overflow: TextOverflow.ellipsis
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    decoration: MyBoxDecoration().MyBox(),
                    alignment: Alignment.center,
                    child: Text(
                      "000",
                      style: TextStyle(
                          fontSize: 18.0,
                          overflow: TextOverflow.ellipsis
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
