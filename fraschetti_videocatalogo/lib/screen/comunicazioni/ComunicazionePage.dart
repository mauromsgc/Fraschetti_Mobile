import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/models/comunicazioneModel.dart';
import 'package:fraschetti_videocatalogo/models/catalogoModel.dart';
import 'package:fraschetti_videocatalogo/screen/catalogo/CatalogoPage.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';
import 'package:photo_view/photo_view.dart';

class ComunicazionePageArgs {
  List<Map>? comunicazioni_lista;
  int indice;

  ComunicazionePageArgs({
    this.comunicazioni_lista = null,
    this.indice = 0,
  });
}

class ComunicazionePage extends StatefulWidget {
  ComunicazionePage({Key? key}) : super(key: key);
  static const String routeName = 'comunicazione_page';
  final String pagina_titolo = "Comunicazione";

  @override
  _ComunicazionePageState createState() => _ComunicazionePageState();
}

class _ComunicazionePageState extends State<ComunicazionePage> {
  ComunicazionePageArgs argomenti = ComunicazionePageArgs();
  ComunicazioneModel comunicazione_scheda = ComunicazioneModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      argomenti =
          ModalRoute.of(context)?.settings.arguments as ComunicazionePageArgs;
      int indice = argomenti.indice;
      // all'apertura va caricato prima
      _comunicazione_scheda_carica(
          id: argomenti.comunicazioni_lista![indice]["id"]);
    }

    super.didChangeDependencies();
  }

  Future<void> _comunicazione_scheda_carica({
    int id = 0,
  }) async {
    comunicazione_scheda = await ComunicazioneModel.nuovo_da_id(
      id: id,
    );
    setState(() {});
  }

  _scheda_precedente() {
    int indice = argomenti.indice;
    if (indice != 0) {
      indice = indice - 1;
      argomenti.indice = indice;
      _comunicazione_scheda_carica(
          id: argomenti.comunicazioni_lista![indice]["id"]);
    }
  }

  _scheda_successiva() {
    int indice = argomenti.indice;
    if ((indice+1) < argomenti.comunicazioni_lista!.length) {
      indice = indice + 1;
      argomenti.indice = indice;
      _comunicazione_scheda_carica(
          id: argomenti.comunicazioni_lista![indice]["id"]);
    }
  }

  @override
  Widget build(BuildContext context) {
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
              child: ComunicazopneWidget(),
            ),
          ),
        ),
      ),
    );
  }

// dati promozione
  Widget ComunicazopneWidget() {
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
                    comunicazione_scheda.oggetto,
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
          Divider(),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Expanded(
              //   child: Container(
              //     padding: EdgeInsets.all(5),
              //     child:
              //   ),
              // ),
              Text(
                "ID",
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 5),
              Text(
                comunicazione_scheda.id.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 10),
              Text(
                "Data",
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 5),
              Text(
                comunicazione_scheda.data,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 5),
            ],
          ),
          SizedBox(height: 5),
          Divider(),
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 5),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: MyBoxDecoration().MyBox(),
                      child: SchedaImmagineWidget(
                          immagine_base64:
                              comunicazione_scheda.comunicazione_blob),
                    ),
                  ),
                ),
                SizedBox(width: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget SchedaImmagineWidget({dynamic immagine_base64 = ""}) {
    if ((immagine_base64 != null) && (immagine_base64 != "")) {
      return Image.memory(
        Base64Decoder().convert(immagine_base64),
        fit: BoxFit.fitWidth,
      );

      // return Container(
      //   height: 400,
      //   width: 400,
      //   child: PhotoView.customChild(child: Image.memory(
      //     Base64Decoder().convert(immagine_base64),
      //     fit: BoxFit.fitWidth,
      //   ),),
      // );


    } else {
      return Image.asset("assets/immagini/logo_512_512.png");
    }
  }
}
