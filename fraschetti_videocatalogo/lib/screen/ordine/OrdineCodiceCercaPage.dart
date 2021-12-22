import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/components/OrdineTopMenu.dart';
import 'package:fraschetti_videocatalogo/main.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/models/codiceModel.dart';
import 'package:fraschetti_videocatalogo/screen/disponibilita/DisponibilitaWidget.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/OrdineArticoloAggiungiPage.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/ResoArticoloAggiungiPage.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';

class OrdineCodiceCercaPage extends StatefulWidget {
  OrdineCodiceCercaPage({Key? key}) : super(key: key);
  static const String routeName = "ordini_codice_cerca";
  final String pagina_titolo = "Ordini";

  @override
  _OrdineCodiceCercaPageState createState() => _OrdineCodiceCercaPageState();
}

class _OrdineCodiceCercaPageState extends State<OrdineCodiceCercaPage> {
  List<Map> codici_lista = [];

  int lista_numero_elementi = 0;

  final TextEditingController descrizioneController = TextEditingController();
  final TextEditingController codiceController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _codici__lista_svuota() async {
    codici_lista = [];
    lista_numero_elementi = codici_lista.length;
    setState(() {});
  }

  Future<void> _codici_lista_cerca({
    int id = 0,
    String descrizione = "",
    String codice = "",
  }) async {
    codici_lista = await CodiceModel.codici_lista_ricerca(
      id: 0,
      descrizione: descrizioneController.text,
      codice: codiceController.text,
    );
    lista_numero_elementi = codici_lista.length;
    setState(() {});
  }

  void listaClick(BuildContext context, int indice) {
    Navigator.pushNamed(
      context,
      OrdineArticoloAggiungiPage.routeName,
      arguments: OrdineArticoloAggiungiPageArgs(
        codice_id: codici_lista[indice]["id"],
        ordine_riga_id: 0,
      ),
    );
  }

  void articolo_disponibilita_mostra(
      BuildContext context, int codice_id) {
    // Navigator.pushNamed(context, DisponibilitaPage.routeName);
    showDialog(
      context: context,
      builder: DisponibilitaDialogWidget(
          codice_id: codice_id, returnValue: true),
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
                if (codici_lista.length > 0) ListaWidget(codici_lista),
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
                controller: codiceController,
                onChanged: (value) {
                  // Call setState to update the UI
                  descrizioneController.clear();
                  setState(() {});
                  // if(codiceController.text.length >=2){
                  _codici_lista_cerca();
                  // }
                },
                onEditingComplete: () {
                  _codici_lista_cerca();
                },
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                  border: OutlineInputBorder(),
                  hintText: 'Codice',
                  suffixIcon: codiceController.text.length == 0
                      ? null
                      : IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            codiceController.clear();
                            setState(() {});
                            _codici__lista_svuota();
                          },
                        ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 6,
              child: TextFormField(
                // autofocus: true,
                controller: descrizioneController,
                onChanged: (value) {
                  // Call setState to update the UI
                  codiceController.clear();
                  setState(() {});
                  // if(descrizioneController.text.length >=3){
                  _codici_lista_cerca();
                  // }
                },
                onEditingComplete: () {
                  _codici_lista_cerca();
                },
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                  border: OutlineInputBorder(),
                  hintText: 'Descrizione',
                  suffixIcon: descrizioneController.text.length == 0
                      ? null
                      : IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            descrizioneController.clear();
                            setState(() {});
                            _codici__lista_svuota();
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
            //       _codici_lista_cerca();
            //     },
            //     child: Text('Cerca'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

// riga lista
  Widget ListaWidget(List<Map> codici_lista) {
    return Flexible(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          height: 5,
          thickness: 2,
          // color: Theme.of(context).primaryColor,
        ),
        // itemCount: codici_lista.length,
        itemCount: codici_lista.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              listaClick(context, index);
            },
            onLongPress: () {
              articolo_disponibilita_mostra(context, codici_lista[index]["id"]);
            },
            child: Container(
              // height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Container(
                      // width: 60,
                      // height: 40,
                      decoration: MyBoxDecoration().MyBox(),
                      child: ListaImmagineWidget(
                          immagine_base64: codici_lista[index]
                              ['immagine_preview']),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                // venduto
                                padding: EdgeInsets.all(2),
                                alignment: Alignment.center,
                                width: 15,
                                decoration: MyBoxDecoration().MyBox(),
                                child: Text(
                                  "•",
                                  // style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                              Container(
                                // codice
                                padding: EdgeInsets.all(2),
                                alignment: Alignment.center,
                                width: 70,
                                // color: Colors.orange,
                                decoration: MyBoxDecoration().MyBox(),
                                child: Text(
                                  codici_lista[index]["numero"],
                                  // style: TextStyle(fontSize: 14.0),
                                ),
                              ),
                              Expanded(
                                // descrizione
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  alignment: Alignment.centerLeft,
                                  decoration: MyBoxDecoration().MyBox(),
                                  child: Text(
                                    codici_lista[index]["catalogo_nome"],
                                    style: TextStyle(
                                      // fontSize: 14.0,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (codici_lista[index]["descrizione"] != "")
                            Row(
                              children: <Widget>[
                                Expanded(
                                  // descrizione
                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                    alignment: Alignment.centerLeft,
                                    decoration: MyBoxDecoration().MyBox(),
                                    child: Text(
                                      codici_lista[index]["descrizione"],
                                      style: TextStyle(
                                        // fontSize: 14.0,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              if (codici_lista[index]["quantita_massima"] > 0)
                                Container(
                                  // quantità
                                  padding: EdgeInsets.all(2),
                                  alignment: Alignment.centerRight,
                                  width: 50,
                                  decoration: MyBoxDecoration().MyBox(),
                                  child: Text(
                                    codici_lista[index]["quantita_massima"]
                                        .toString(),
                                    // style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              if (codici_lista[index]["quantita_massima"] > 0)
                                Text(" x "),
                              Container(
                                // quantità
                                padding: EdgeInsets.all(2),
                                alignment: Alignment.centerRight,
                                width: 50,
                                decoration: MyBoxDecoration().MyBox(),
                                child: Text(
                                  codici_lista[index]["pezzi"].toString(),
                                  // style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                              Container(
                                // apribile
                                padding: EdgeInsets.all(2),
                                alignment: Alignment.center,
                                width: 20,
                                decoration: MyBoxDecoration().MyBox(),
                                child: Text(
                                  (codici_lista[index]["apribile"] == 1)
                                      ? "*"
                                      : "",
                                  // style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                              Container(
                                // unità di misura
                                padding: EdgeInsets.all(2),
                                alignment: Alignment.center,
                                width: 30,
                                decoration: MyBoxDecoration().MyBox(),
                                child: Text(
                                  codici_lista[index]["um"],
                                  // style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                              Container(
                                // prezzo
                                padding: EdgeInsets.all(2),
                                alignment: Alignment.centerRight,
                                width: 80,
                                decoration: MyBoxDecoration().MyBox(),
                                child: Text(
                                  codici_lista[index]["prezzo"].toString(),
                                  // style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                              Container(
                                // iva
                                padding: EdgeInsets.all(2),
                                alignment: Alignment.center,
                                width: 25,
                                decoration: MyBoxDecoration().MyBox(),
                                child: Text(
                                  codici_lista[index]["iva"].toString(),
                                  // style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ],
                          ),
                        ],
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

  Widget ListaImmagineWidget({dynamic immagine_base64 = ""}) {
    if ((immagine_base64 != null) && (immagine_base64 != "")) {
      return Image.memory(
        Base64Decoder().convert(immagine_base64),
      );
    } else {
      return Image.asset("assets/immagini/splash_screen.png");
    }
  }
}
