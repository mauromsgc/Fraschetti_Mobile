import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/models/promozioneModel.dart';
import 'package:fraschetti_videocatalogo/models/catalogoModel.dart';
import 'package:fraschetti_videocatalogo/screen/catalogo/CatalogoPage.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';

class PromozionePageArgs {
  List<Map>? promozioni_lista;
  int indice;
  int promozioni_id;

  PromozionePageArgs({
    this.promozioni_lista = null,
    this.indice = 0,
    this.promozioni_id = 0,
  });
}

class PromozionePage extends StatefulWidget {
  PromozionePage({Key? key}) : super(key: key);
  static const String routeName = 'promozione_page';
  final String pagina_titolo = "Promozione";

  @override
  _PromozionePageState createState() => _PromozionePageState();
}

class _PromozionePageState extends State<PromozionePage> {
  PromozionePageArgs argomenti = PromozionePageArgs();
  PromozioneModel promozione_scheda = PromozioneModel();
  List<Map> articoli_lista = [];

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
          ModalRoute.of(context)?.settings.arguments as PromozionePageArgs;
      if (argomenti.promozioni_lista != null) {
        int indice = argomenti.indice;
        // all'apertura va caricato prima
        _promozione_scheda_carica(
            id: argomenti.promozioni_lista![indice]["id"]);
        lista_elementi_numero = argomenti.promozioni_lista!.length;
        lista_elementi_indice = argomenti.indice;
      }
      if ((argomenti.promozioni_id != 0) &&
          (argomenti.promozioni_lista == null)) {
        _promozione_scheda_carica(id: argomenti.promozioni_id);
        lista_elementi_numero = 1;
        lista_elementi_indice = 0;
      }
    }

    super.didChangeDependencies();
  }

  Future<void> _promozione_scheda_carica({
    int id = 0,
  }) async {
    promozione_scheda = await PromozioneModel.nuovo_da_id(
      id: id,
    );
    articoli_lista = await CatalogoModel.catalogo_lista(
      promozioni_id: promozione_scheda.id,
    );
    setState(() {});
  }

  _scheda_precedente() {
    int indice = argomenti.indice;
    if (indice != 0) {
      indice = indice - 1;
      argomenti.indice = indice;
      _promozione_scheda_carica(id: argomenti.promozioni_lista![indice]["id"]);
      lista_elementi_indice = argomenti.indice;
    }
  }

  _scheda_successiva() {
    int indice = argomenti.indice;
    if ((indice+1) < argomenti.promozioni_lista!.length) {
      indice = indice + 1;
      argomenti.indice = indice;
      _promozione_scheda_carica(id: argomenti.promozioni_lista![indice]["id"]);
      lista_elementi_indice = argomenti.indice;
    }
  }

  void listaClick(BuildContext context, int indice) {
    Navigator.pushNamed(
      context,
      CatalogoPage.routeName,
      arguments: CatalogoPageArgs(
        articoli_lista: articoli_lista.toList(),
        indice: indice,
      ),
    );
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
                "${lista_elementi_indice+1} di ${lista_elementi_numero}",
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
                  PromozioneWidget(),
                  Divider(
                    height: 5,
                    thickness: 2,
                    // color: Theme.of(context).primaryColor,
                  ),
                  ListaWidget(articoli_lista),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// dati promozione
  Widget PromozioneWidget() {
    return Container(
      // height: 500,
      // padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    promozione_scheda.nome,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(
            height: 5,
            thickness: 2,
            // color: Theme.of(context).primaryColor,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 5),
              Expanded(
                child: Container(
                  height: 400,
                  // width: 400,
                  child: SchedaImmagineWidget(
                      immagine_base64: promozione_scheda.immagine),
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
      return Image.asset("assets/immagini/logo_512_512.png");
    }
  }

// riga lista articoli
  Widget ListaWidget(List<Map> articoli_lista) {
    return Flexible(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          height: 5,
          thickness: 2,
          // color: Theme.of(context).primaryColor,
        ),
        itemCount: articoli_lista.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              listaClick(context, index);
            },
            child: Container(
              height: 50,
              // decoration: MyBoxDecoration().MyBox(),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 10,
                    decoration: BoxDecoration(
                      color: Color(
                          int.parse(articoli_lista[index]['famiglie_colore'])),
                    ),
                  ),
                  Container(
                    width: 60,
                    decoration: MyBoxDecoration().MyBox(),
                    child: ListaImmagineWidget(
                        immagine_base64: articoli_lista[index]
                            ['immagine_preview']),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(5.0),
                          decoration: MyBoxDecoration().MyBox(),
                          child: Text(
                            "${articoli_lista[index]['nome']}",
                            style: TextStyle(
                              fontSize: 15.0,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        if (articoli_lista[index]['nuovo'] == 1)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 60,
                              height: 25,
                              color: Colors.green.shade800,
                              // child: Image.asset("assets/immagini/logo_512_512.png"),
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
                          ),
                        if (articoli_lista[index]['promozioni_id'] > 0)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 60,
                              height: 25,
                              color: Colors.blue.shade800,
                              // child: Image.asset("assets/immagini/logo_512_512.png"),
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
      return Image.asset("assets/immagini/logo_512_512.png");
    }
  }
}
