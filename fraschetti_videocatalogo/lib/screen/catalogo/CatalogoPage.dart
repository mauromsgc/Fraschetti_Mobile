import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/models/codiceModel.dart';
import 'package:fraschetti_videocatalogo/repositories/articoliRepository.dart';
import 'package:fraschetti_videocatalogo/models/catalogoModel.dart';
import 'package:fraschetti_videocatalogo/screen/disponibilita/DisponibilitaPage.dart';
import 'package:fraschetti_videocatalogo/screen/disponibilita/DisponibilitaWidget.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/OrdineArticoloAggiungiPage.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

class CatalogoPageArgs {
  List<Map>? articoli_lista;
  int indice;

  CatalogoPageArgs({
    this.articoli_lista = null,
    this.indice = 0,
  });
}

class CatalogoPage extends StatefulWidget {
  CatalogoPage({Key? key}) : super(key: key);
  static const String routeName = "catalogo_page";
  final String pagina_titolo = "Catalogo";

  @override
  _CatalogoPageState createState() => _CatalogoPageState();
}

final pageStato = PageStore().obs;

class PageStore {
  CatalogoModel catalogo_scheda = CatalogoModel();
}

class _CatalogoPageState extends State<CatalogoPage> {
  // late CatalogoPageArgs? argomenti= ModalRoute.of(context)?.settings.arguments as CatalogoPageArgs;
  late CatalogoPageArgs? argomenti;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _catalogo_scheda_carica({
    int id = 0,
  }) async {
    pageStato.value.catalogo_scheda = await CatalogoModel.scheda_form_id(
      id: id,
    );
    // pageStato.value.lista_numero_elementi =
    //     pageStato.value.articoli_lista.length;
    pageStato.refresh();
  }

  _scheda_precedente(){
    int indice = argomenti!.indice;
    if(indice != 0){
      indice = indice-1;
      argomenti!.indice = indice;
    _catalogo_scheda_carica(id: argomenti?.articoli_lista![indice]["id"]);
    }

  }
  _scheda_successiva(){
    int indice = argomenti!.indice;
    if(indice < argomenti!.articoli_lista!.length){
      indice = indice+1;
      argomenti!.indice = indice;
      _catalogo_scheda_carica(id: argomenti?.articoli_lista![indice]["id"]);
    }
  }

  void listaClick(BuildContext context, int indice) {
    Navigator.pushNamed(
      context,
      OrdineArticoloAggiungiPage.routeName,
      // arguments: CatalogoPageArgs(
      //   articoli_lista: pageStato.value.articoli_lista.toList(),
      //   indice: indice,
      // ),
    );
  }

  void articolo_disponibilita_mostra(BuildContext context, CodiceModel codice_scheda) {
    // Navigator.pushNamed(context, DisponibilitaPage.routeName);
    showDialog(
      context: context,
      builder: DisponibilitaDialogWidget(codice_scheda: codice_scheda, returnValue: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    // CatalogoPageArgs? argomenti= ModalRoute.of(context)?.settings.arguments as CatalogoPageArgs;
    // print(argomenti.articoli_lista.toString());
    // print(argomenti.indice.toString());

    if (ModalRoute.of(context)?.settings.arguments != null) {
      argomenti =
          ModalRoute.of(context)?.settings.arguments as CatalogoPageArgs;
      print(argomenti?.articoli_lista.toString());
      print(argomenti?.indice.toString());
      print(argomenti?.articoli_lista![1]["id"].toString());
      int indice = argomenti!.indice;
      print(argomenti?.articoli_lista![indice]["id"].toString());
      _catalogo_scheda_carica(id: argomenti?.articoli_lista![indice]["id"]);
    }

    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          // leading: IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.menu),
          // ),
          title: Text(widget.pagina_titolo),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomBarWidget(),
        body: GestureDetector(
          onHorizontalDragUpdate: (details) {
            // Note: Sensitivity is integer used when you don't want to mess up vertical drag
            int sensitivity = 20;
            if (details.delta.dx > sensitivity) {
              // Right Swipe
              print("Right Swipe");
              _scheda_precedente();
            } else if (details.delta.dx < -sensitivity) {
              //Left Swipe
              print("Left Swipe");
              _scheda_successiva();
            }
          },
          child: SingleChildScrollView(
            child: Container(
              // si dovrebbe sitemare meglio
              height: MediaQuery.of(context).size.height -
                  (kBottomNavigationBarHeight * 2),
              // decoration: MyBoxDecoration().MyBox(),
              child: Column(
                children: <Widget>[
                  Obx(
                    () => ArticoloWidget(),
                  ),
// SizedBox(height: 5),
                  Divider(
                    height: 5,
                    thickness: 2,
                    // color: Theme.of(context).primaryColor,
                  ),
                  CodiciIntestazioneWidget(),
                  Divider(
                    height: 5,
                    thickness: 2,
                    // color: Theme.of(context).primaryColor,
                  ),
          Obx(
                () {
                  // print(pageStato.value.catalogo_scheda.codici.toString());
                  return CodiciWidget(pageStato.value.catalogo_scheda.codici);
                  },
          ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// dati articolo catalogo
  Widget ArticoloWidget() {
    return Container(
      // height: 500,
      // padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
            ),
            child: Row(
              children: [
                // Text("${int.parse(pageStato.value.catalogo_scheda.famiglie_colore)}"),
                CircleAvatar(
                  backgroundColor: Colors.red,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: MyBoxDecoration().MyBox(),
                        child: Text(
                          pageStato.value.catalogo_scheda.famiglie_descrizione,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Row(
                          children: [
                            if (pageStato.value.catalogo_scheda.nuovo == 1)
                              Container(
                                width: 60,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: MyBorder().MyBorderOrange(),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/immagini/splash_screen.png"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            if (pageStato.value.catalogo_scheda.promozione_id >0)
                              Container(
                                width: 60,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: MyBorder().MyBorderOrange(),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/immagini/splash_screen.png"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                          ],),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    pageStato.value.catalogo_scheda.nome,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 5),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(5),
                  // height: 400,
                  // width: 100,
                  // height: double.infinity,

                  decoration: MyBoxDecoration().MyBox(),
                  child: SizedBox(
                    height: 300,
                    child: SingleChildScrollView(
                      child: Text(
                        pageStato.value.catalogo_scheda.descrizione,
                        textAlign: TextAlign.justify,
                        // style: TextStyle(fontSize: 12.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                flex: 2,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                      height: constraints.minWidth,
                      // width: 500,
                      decoration: BoxDecoration(
                        border: MyBorder().MyBorderOrange(),
                      ),
                      child: SchedaImmagineWidget(
                          immagine_base64:
                              pageStato.value.catalogo_scheda.immagine),
                    );
                  },
                ),
              ),
              SizedBox(width: 5),
            ],
          ),
        ],
      ),
    );
  }

  Widget SchedaImmagineWidget({dynamic immagine_base64 = ""}) {
    if ((immagine_base64 != null) && (immagine_base64 != "")) {
      return Image.memory(
        Base64Decoder().convert(immagine_base64),
      );
    } else {
      return Image.asset("assets/immagini/splash_screen.png");
    }
  }

// riga lista codici
  Widget CodiciIntestazioneWidget() {
    return Container(
      // height: 40,
      // decoration: BoxDecoration(
      //   border: Border(
      //     bottom: BorderSide(
      //       color: Theme.of(context).primaryColor,
      //       width: 2,
      //     ),
      //   ),
      // ),
      // color: Colors.grey.shade400,
      color: Colors.blue.shade400,
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Container(
                // venduto
                padding: EdgeInsets.all(2),
                alignment: Alignment.center,
                width: 15,
                decoration: MyBoxDecoration().MyBox(),
                child: Text(
                  " ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                  ),
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
                  "Codice",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                  ),
                ),
              ),
              Expanded(
                // descrizione
                child: Container(
                  padding: EdgeInsets.all(2),
                  alignment: Alignment.centerLeft,
                  decoration: MyBoxDecoration().MyBox(),
                  child: Text(
                    "Descrizione",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0,
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
              Container(
                // quantità
                padding: EdgeInsets.all(2),
                alignment: Alignment.centerRight,
                width: 50,
                decoration: MyBoxDecoration().MyBox(),
                child: Text(
                  "Mas.",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                  ),
                ),
              ),
              Text("   "),
              Container(
                // quantità
                padding: EdgeInsets.all(2),
                alignment: Alignment.centerRight,
                width: 50,
                decoration: MyBoxDecoration().MyBox(),
                child: Text(
                  "Qt.",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                  ),
                ),
              ),
              Container(
                // apribile
                padding: EdgeInsets.all(2),
                alignment: Alignment.center,
                width: 25,
                decoration: MyBoxDecoration().MyBox(),
                child: Text(
                  "Ap.",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                  ),
                ),
              ),
              Container(
                // unità di misura
                padding: EdgeInsets.all(2),
                alignment: Alignment.center,
                width: 35,
                decoration: MyBoxDecoration().MyBox(),
                child: Text(
                  "U.M.",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                  ),
                ),
              ),
              Container(
                // prezzo
                padding: EdgeInsets.all(2),
                alignment: Alignment.centerRight,
                width: 75,
                decoration: MyBoxDecoration().MyBox(),
                child: Text(
                  "Prezzo",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                  ),
                ),
              ),
              Container(
                // iva
                padding: EdgeInsets.all(2),
                alignment: Alignment.center,
                width: 25,
                decoration: MyBoxDecoration().MyBox(),
                child: Text(
                  "Iva",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

// riga lista codici
  Widget CodiciWidget(List<CodiceModel> codice_scheda) {
    return Flexible(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          height: 5,
          thickness: 2,
          color: Theme.of(context).primaryColor,
        ),
        itemCount: codice_scheda.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              listaClick(context, index);
            },
            onLongPress: () {
              articolo_disponibilita_mostra(context, codice_scheda[index]);
            },
            child: Container(
              // height: 40,
              // decoration: BoxDecoration(
              //   border: Border(
              //     bottom: BorderSide(
              //       color: Theme.of(context).primaryColor,
              //       width: 2,
              //     ),
              //   ),
              // ),
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
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
                          codice_scheda[index].numero,
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
                            codice_scheda[index].descrizione,
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
                      if (codice_scheda[index].quantita_massima > 0)
                      Container(
                        // quantità
                        padding: EdgeInsets.all(2),
                        alignment: Alignment.centerRight,
                        width: 50,
                        decoration: MyBoxDecoration().MyBox(),
                        child: Text(
                          codice_scheda[index].quantita_massima.toString(),
                          // style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                      if (codice_scheda[index].quantita_massima > 0)
                        Text(" x "),
                      Container(
                        // quantità
                        padding: EdgeInsets.all(2),
                        alignment: Alignment.centerRight,
                        width: 50,
                        decoration: MyBoxDecoration().MyBox(),
                        child: Text(
                          codice_scheda[index].pezzi.toString(),
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
                          (codice_scheda[index].apribile == 1) ? "*" : "",
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
                          codice_scheda[index].um,
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
                          codice_scheda[index].prezzo.toString(),
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
                          codice_scheda[index].iva.toString(),
                          // style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
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
