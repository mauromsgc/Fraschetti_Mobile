import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/models/codiceModel.dart';
import 'package:fraschetti_videocatalogo/models/catalogoModel.dart';
import 'package:fraschetti_videocatalogo/models/parametriModel.dart';
import 'package:fraschetti_videocatalogo/models/utenteCorrenteModel.dart';
import 'package:fraschetti_videocatalogo/screen/disponibilita/DisponibilitaWidget.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/ClientiLista.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/OrdineArticoloAggiungiPage.dart';
import 'package:fraschetti_videocatalogo/screen/promozioni/PromozionePage.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

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

class _CatalogoPageState extends State<CatalogoPage> {
  // late CatalogoPageArgs? argomenti= ModalRoute.of(context)?.settings.arguments as CatalogoPageArgs;
  CatalogoPageArgs argomenti = CatalogoPageArgs();
  CatalogoModel catalogo_scheda = CatalogoModel();

  int lista_elementi_numero = 0;
  int lista_elementi_indice = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      argomenti =
          ModalRoute.of(context)?.settings.arguments as CatalogoPageArgs;
      int indice = argomenti.indice;
      // all'apertura va caricato prima
      _catalogo_scheda_carica(id: argomenti.articoli_lista![indice]["id"]);
      lista_elementi_numero = argomenti.articoli_lista!.length;
      lista_elementi_indice = argomenti.indice;
    }

    super.didChangeDependencies();
  }

  Future<void> _catalogo_scheda_carica({
    int id = 0,
  }) async {
    catalogo_scheda = await CatalogoModel.cerca_id(
      id: id,
    );
    setState(() {});
  }

  _scheda_precedente() {
    int indice = argomenti.indice;
    if (indice != 0) {
      indice = indice - 1;
      argomenti.indice = indice;
      _catalogo_scheda_carica(id: argomenti.articoli_lista![indice]["id"]);
      lista_elementi_indice = argomenti.indice;
    }
  }

  _scheda_successiva() {
    int indice = argomenti.indice;
    if ((indice + 1) < argomenti.articoli_lista!.length) {
      indice = indice + 1;
      argomenti.indice = indice;
      _catalogo_scheda_carica(id: argomenti.articoli_lista![indice]["id"]);
      lista_elementi_indice = argomenti.indice;
    }
  }

  void listaClick(BuildContext context, int codice_id) {
    if (GetIt.instance<SessioneModel>().clienti_id_selezionato == 0) {
      Navigator.pushNamed(
        context,
        ClienteLista.routeName,
        arguments: ClientiListaPageArgs(
          pagina_chiamante_route: CatalogoPage.routeName,
        ),
      );
    } else {
      Navigator.pushNamed(
        context,
        OrdineArticoloAggiungiPage.routeName,
        arguments: OrdineArticoloAggiungiPageArgs(
          id: 0,
          codice_id: codice_id,
        ),
      );
    }
  }

  void articolo_disponibilita_mostra(
      BuildContext context, CodiceModel codice_scheda) {
    // Navigator.pushNamed(context, DisponibilitaPage.routeName);
    showDialog(
      context: context,
      builder: DisponibilitaDialogWidget(
          codice_id: codice_scheda.id, returnValue: true),
    );
  }

  void promozione_mostra(BuildContext context, {int promozioni_id = 0}) {
    Navigator.pushNamed(
      context,
      PromozionePage.routeName,
      arguments: PromozionePageArgs(
        promozioni_id: promozioni_id,
      ),
    );
  }

  void scheda_tecnica_sicurezza_mostra({int scheda_id = 0}) async {
    bool url_aperto = false;
    String url_aprire = GetIt.instance<UtenteCorrenteModel>().url_schede_tecniche_sicurezza();
    url_aprire += "_SchedaTecSic_" + scheda_id.toString();
    print("url_aprire: ${url_aprire}");
    if (url_aprire != "") {
      url_aperto = await launch(url_aprire);
      if (url_aperto == false) {
        print("url " "${url_aprire}" " non aperto");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          // leading: IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.menu),
          // ),
          title: Column(
            children: [
              Text(widget.pagina_titolo),
              // if(lista_elementi_numero >0)
              Text(
                "${lista_elementi_indice + 1} di ${lista_elementi_numero}",
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomBarWidget(),
        body: GestureDetector(
          onHorizontalDragEnd: (DragEndDetails drag) {
            if (drag.primaryVelocity == null) return;
            if (drag.primaryVelocity! < 0) {
              // drag from right to left
              print("drag from right to left");
              _scheda_successiva();
            } else if (drag.primaryVelocity! > 0) {
              // drag from left to right
              print("drag from left to right");
              _scheda_precedente();
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
                  if (catalogo_scheda.id != 0) ArticoloWidget(),
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
                  if (catalogo_scheda.id != 0)
                    CodiciWidget(catalogo_scheda.codici),
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
                CircleAvatar(
                  backgroundColor:
                      Color(int.parse(catalogo_scheda.famiglie_colore)),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        decoration: MyBoxDecoration().MyBox(),
                        child: Text(
                          catalogo_scheda.famiglie_descrizione,
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
                            if (catalogo_scheda.nuovo == 1)
                              Container(
                                width: 60,
                                height: 50,
                                color: Colors.green.shade800,
                                // child: Image.asset("assets/immagini/splash_screen.png"),
                                child: Center(
                                  child: Text(
                                    "Nuovo",
                                    style: TextStyle(
                                      color: Colors.yellow,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            if (catalogo_scheda.promozioni_id > 0)
                              InkWell(
                                onTap: () {
                                  promozione_mostra(context,
                                      promozioni_id:
                                          catalogo_scheda.promozioni_id);
                                },
                                child: Container(
                                  width: 60,
                                  height: 50,
                                  color: Colors.blue.shade800,
                                  // child: Image.asset("assets/immagini/splash_screen.png"),
                                  child: Center(
                                    child: Text(
                                      "Offerta",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
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
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.all(5),
                  child: Text(
                    catalogo_scheda.nome,
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
          SizedBox(height: 5),

          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Flexible(
          //       child: ConstrainedBox(
          //         constraints: BoxConstraints(
          //           // maxWidth: MediaQuery.of(context).size.width * 0.25,
          //           // minWidth: MediaQuery.of(context).size.width * 0.25,
          //           // maxWidth: 150,
          //         ),
          //         child: Container(
          //           // width: MediaQuery.of(context).size.width * 0.25,
          //           // color : Colors.blue,
          //           decoration: MyBoxDecoration().MyBox(),
          //           child: Text('${MediaQuery.of(context).size.width.toString()} Your Text here ${(MediaQuery.of(context).size.width * 0.25).toString()}'),
          //         ),
          //       ),
          //     ),
          //     Flexible(
          //       child: ConstrainedBox(
          //         constraints: BoxConstraints(
          //             maxWidth: 500,
          //           maxHeight: 375,
          //           // minWidth: MediaQuery.of(context).size.width * 0.75,
          //           // minHeight: 100,
          //         ),
          //         child: Container(
          //           // width: MediaQuery.of(context).size.width * 0.75,
          //           // color : Colors.blue,
          //           decoration: BoxDecoration(
          //             border: MyBorder().MyBorderOrange(),
          //           ),
          //           child: Text('Your Text here ${(MediaQuery.of(context).size.width * 0.75).toString()}'),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  // height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.only(left: 5),
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // new LayoutBuilder(
                      //     builder: (BuildContext context, BoxConstraints constraints) {
                      //       return Container(
                      //         height: 200,
                      //         decoration: MyBoxDecoration().MyBox(),
                      //         child: Text(
                      //           catalogo_scheda.descrizione,
                      //           textAlign: TextAlign.justify,
                      //           // style: TextStyle(fontSize: 12.0),
                      //         ),
                      //       );
                      //
                      //       // if(constraints.maxWidth > 200.0) {
                      //       //   return new Text("BIG ${constraints.maxHeight}");
                      //       // } else {
                      //       //   return new Text("SMALL ${constraints.maxHeight}");
                      //       // }
                      //     }
                      // ),

                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: MyBoxDecoration().MyBox(),
                        child: SizedBox(
                          height: 300,
                          child: SingleChildScrollView(
                            child: Text(
                              catalogo_scheda.descrizione,
                              textAlign: TextAlign.justify,
                              // style: TextStyle(fontSize: 12.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: MyBoxDecoration().MyBox(),
                        child: Column(
                          children: [
                            if (catalogo_scheda.scheda_tecnica_id != 0)
                              Container(
                                // height: 50,
                                width: 170,
                                padding: EdgeInsets.all(5),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(elevation: 2),
                                  onPressed: () {
                                    scheda_tecnica_sicurezza_mostra(scheda_id: catalogo_scheda.scheda_tecnica_id);
                                  },
                                  child: Text('Scheda tecnica'),
                                ),
                              ),
                            if (catalogo_scheda.scheda_sicurezza_id != 0)
                              Container(
                                // height: 50,
                                width: 170,
                                padding: EdgeInsets.all(5),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(elevation: 2),
                                  onPressed: () {
                                    scheda_tecnica_sicurezza_mostra(scheda_id: catalogo_scheda.scheda_sicurezza_id);
                                  },
                                  child: Text('Scheda sicurezza'),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Expanded(
              //   flex: 1,
              //   child: Container(
              //     padding: EdgeInsets.all(5),
              //     decoration: MyBoxDecoration().MyBox(),
              //     child: SizedBox(
              //       height: 300,
              //       child: SingleChildScrollView(
              //         child: Text(
              //           catalogo_scheda.descrizione,
              //           textAlign: TextAlign.justify,
              //           // style: TextStyle(fontSize: 12.0),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              SizedBox(width: 5),
              Expanded(
                flex: 2,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                      height: constraints.minWidth,
                      // width: 500,
                      decoration: MyBoxDecoration().MyBox(),
                      child: SchedaImmagineWidget(
                          immagine_base64: catalogo_scheda.immagine),
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
                  "Master",
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
          // color: Theme.of(context).primaryColor,
        ),
        itemCount: codice_scheda.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              listaClick(context, codice_scheda[index].id);
            },
            onLongPress: () {
              articolo_disponibilita_mostra(context, codice_scheda[index]);
            },
            child: Container(
              height: 50,
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
