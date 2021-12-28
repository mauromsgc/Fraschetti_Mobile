import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/models/catalogoModel.dart';
import 'package:fraschetti_videocatalogo/screen/disponibilita/DisponibilitaPage.dart';
import 'package:fraschetti_videocatalogo/screen/disponibilita/DisponibilitaWidget.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/OrdineArticoloAggiungiPage.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

class TestPageArgs {
  List<Map>? articoli_lista;
  int indice;

  TestPageArgs({
    this.articoli_lista = null,
    this.indice = 0,
  });
}

class TestPage extends StatefulWidget {
  TestPage({Key? key}) : super(key: key);
  static const String routeName = "test_page";
  final String pagina_titolo = "Test";

  @override
  _TestPageState createState() => _TestPageState();
}

final pageStato = PageStore().obs;

class PageStore {
  CatalogoModel catalogo_scheda = CatalogoModel();
}

class _TestPageState extends State<TestPage> {
  // late TestPageArgs? argomenti= ModalRoute.of(context)?.settings.arguments as TestPageArgs;
  late TestPageArgs? argomenti;

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
    // pageStato.value.lista_elementi_numero =
    //     pageStato.value.articoli_lista.length;
    pageStato.refresh();
  }

  void listaClick(BuildContext context, int indice) {
    Navigator.pushNamed(
      context,
      OrdineArticoloAggiungiPage.routeName,
      // arguments: TestPageArgs(
      //   articoli_lista: pageStato.value.articoli_lista.toList(),
      //   indice: indice,
      // ),
    );
  }

  void articolo_disponibilita_mostra(BuildContext context) {
    // Navigator.pushNamed(context, DisponibilitaPage.routeName);
    // showDialog(
    //   context: context,
    //   // builder: DisponibilitaDialogWidget(codice_id: 1, returnValue: true),
    // );
  }

  @override
  Widget build(BuildContext context) {
    // TestPageArgs? argomenti= ModalRoute.of(context)?.settings.arguments as TestPageArgs;
    // print(argomenti.articoli_lista.toString());
    // print(argomenti.indice.toString());

    // argomenti = ModalRoute.of(context)?.settings.arguments as TestPageArgs;
    // print(argomenti?.articoli_lista.toString());
    // print(argomenti?.indice.toString());
    // print(argomenti?.articoli_lista![1]["id"].toString());
    // int indice = argomenti!.indice;
    // print(argomenti?.articoli_lista![indice]["id"].toString());
    // _catalogo_scheda_carica(id: argomenti?.articoli_lista![indice]["id"]);
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
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  // height: 100,
                  color: Colors.greenAccent,
                  child: Center(
                    child: Text('100'),
                  ),
                ),
                Container(
                  width: double.infinity,
                  // height: 150,
                  color: Colors.red,
                  child: Center(
                    child: Text('150'),
                  ),
                ),
                Flexible(
                  child: Container(
                    width: double.infinity,
                    color: Colors.orange,
                    child: Center(
                      child: Text('Fill'),
                    ),
                  ),
                ),
              ],
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
                CircleAvatar(
                  backgroundColor: Colors.amber,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: MyBoxDecoration().MyBox(),
                    child: Text(
                      // pageStato.value.catalogo_scheda.famiglie_descrizione,
                      "Categoria Categoria",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 60,
                  height: 50,
                  decoration: MyBoxDecoration().MyBox(),
                    child: Image.asset("assets/immagini/splash_screen.png"),
                ),
                Container(
                  width: 60,
                  height: 50,
                  decoration: MyBoxDecoration().MyBox(),
                  child: Image.asset("assets/immagini/splash_screen.png"),
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
                    "Articolo Articolo Articolo",
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
                        "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
                        // "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, ",
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
                        image: DecorationImage(
                          image:
                          AssetImage("assets/immagini/splash_screen.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
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

// riga lista codici
  Widget CodiciWidget_2() {
    return SizedBox(
      height: 300,
      child: Expanded(
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            height: 5,
            thickness: 2,
            // color: Theme.of(context).primaryColor,
          ),
          itemCount: 15,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                listaClick(context, index);
              },
              onLongPress: () {
                articolo_disponibilita_mostra(context);
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      // venduto
                      alignment: Alignment(0.0, 0.0),
                      width: 15,
                      decoration: MyBoxDecoration().MyBox(),
                      child: Text(
                        "•",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Container(
                      // codice
                      alignment: Alignment(0.0, 0.0),
                      width: 60,
                      // color: Colors.orange,
                      decoration: MyBoxDecoration().MyBox(),
                      child: Text(
                        "000000",
                        // style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    Expanded(
                      // descrizione
                      child: Container(
                        padding: EdgeInsets.all(2),
                        alignment: Alignment(-1.0, 0.0),
                        decoration: MyBoxDecoration().MyBox(),
                        child: Text(
                          "Codice Codice Codice Codice Codice Codice",
                          style: TextStyle(
                            // fontSize: 14.0,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // quantità
                      padding: EdgeInsets.all(2),
                      alignment: Alignment(1.0, 0.0),
                      width: 50,
                      decoration: MyBoxDecoration().MyBox(),
                      child: Text(
                        "1500",
                        // style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Container(
                      // apribile
                      alignment: Alignment(0.0, 0.0),
                      width: 20,
                      decoration: MyBoxDecoration().MyBox(),
                      child: Text(
                        "*",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Container(
                      // unità di misura
                      alignment: Alignment(0.0, 0.0),
                      width: 25,
                      decoration: MyBoxDecoration().MyBox(),
                      child: Text(
                        "XC",
                        // style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Container(
                      // prezzo
                      padding: EdgeInsets.all(3),
                      alignment: Alignment(1.0, 0.0),
                      width: 80,
                      decoration: MyBoxDecoration().MyBox(),
                      child: Text(
                        "99999,99",
                        // style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Container(
                      // iva
                      alignment: Alignment(0.0, 0.0),
                      width: 25,
                      decoration: MyBoxDecoration().MyBox(),
                      child: Text(
                        "22",
                        // style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
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
  Widget CodiciWidget() {
    return Container(
      height: MediaQuery.of(context).size.height/2,
      // height: 300,
      child: Expanded(
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            height: 5,
            thickness: 2,
            // color: Theme.of(context).primaryColor,
          ),
          itemCount: 15,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                listaClick(context, index);
              },
              onLongPress: () {
                articolo_disponibilita_mostra(context);
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
                            "000000",
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
                              "Codice Codice Codice Codice Codice Codice",
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
                        Container(
                          // quantità
                          padding: EdgeInsets.all(2),
                          alignment: Alignment.centerRight,
                          width: 50,
                          decoration: MyBoxDecoration().MyBox(),
                          child: Text(
                            "1500",
                            // style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        Text(" x "),
                        Container(
                          // quantità
                          padding: EdgeInsets.all(2),
                          alignment: Alignment.centerRight,
                          width: 50,
                          decoration: MyBoxDecoration().MyBox(),
                          child: Text(
                            "1500",
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
                            "*",
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
                            "XC",
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
                            "99999,99",
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
                            "22",
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
      ),
    );
  }

  Widget CodiciWidget_3() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 50,
          color: Colors.greenAccent,
          child: Center(
            child: Text('100'),
          ),
        ),
        Container(
          width: double.infinity,
          height: 50,
          color: Colors.red,
          child: Center(
            child: Text('150'),
          ),
        ),
        Flexible(
          child: Container(
            width: double.infinity,
            color: Colors.orange,
            child: Center(
              child: Text('Fill'),
            ),
          ),
        ),
      ],
    );
  }

  Widget CodiciWidget_33() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          // height: double.maxFinite,
          child: Text("Prova"),
          decoration: MyBoxDecoration().MyBox(),
        ),
      ],
    );
  }
}
