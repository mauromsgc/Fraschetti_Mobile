import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/models/assortimentoModel.dart';
import 'package:fraschetti_videocatalogo/models/famigliaModel.dart';
import 'package:fraschetti_videocatalogo/models/catalogoModel.dart';
import 'package:fraschetti_videocatalogo/screen/auth/LoginPage.dart';
import 'package:fraschetti_videocatalogo/screen/catalogo/CatalogoPage.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';
import 'package:get_it/get_it.dart';
import 'package:get/get.dart';

class CatalogoListaPage extends StatefulWidget {
  CatalogoListaPage({Key? key}) : super(key: key);
  static const String routeName = "catalogo_lista";
  final String pagina_titolo = "Catalogo";

  @override
  _CatalogoListaPageState createState() => _CatalogoListaPageState();
}

final pageStato = PageStore().obs;

class PageStore {
  List<FamigliaModel> famiglie_lista = [];
  List<AssortimentoModel> assortimenti_lista = [];
  List<Map> articoli_lista = [];

  int lista_numero_elementi = 0;
}

class _CatalogoListaPageState extends State<CatalogoListaPage> {
  final TextEditingController descrizioneController = TextEditingController();
  final TextEditingController codiceController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _famiglie_lista_carica();
    _assortimenti_lista_carica();
    // _articoli_lista_cerca(); // non carico la lista al'avvio
  }

  void app_chiudi() {
    if (kDebugMode) {
      Navigator.pushNamed(context, LoginPage.routeName);
    } else {
      Future.delayed(const Duration(milliseconds: 1000), () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      });
    }
  }

  Future<void> _famiglie_lista_carica() async {
    pageStato.value.famiglie_lista = await FamigliaModel.famiglie_lista();
    pageStato.refresh();
  }

  Future<void> _assortimenti_lista_carica() async {
    pageStato.value.assortimenti_lista =
        await AssortimentoModel.assortimenti_lista();
    pageStato.refresh();
  }

  Future<void> _articoli_lista_svuota() async {
    pageStato.value.articoli_lista = [];
    pageStato.value.lista_numero_elementi =
        pageStato.value.articoli_lista.length;
    pageStato.refresh();
  }

  Future<void> _articoli_lista_cerca({
    int famiglia_id = 0,
    int assortimento_id = 0,
    String selezione = "", // selezione contiene anche tutto
    String ordinamento_campo = "",
    String ordinamento_verso = "",
  }) async {
    // passo sempre le variabili descrizione e codice
    if ((famiglia_id != 0) || (assortimento_id != 0) || (selezione != "")) {
      descrizioneController.clear();
      codiceController.clear();
      setState(() {});
    }
    pageStato.value.articoli_lista = await CatalogoModel.catalogo_lista(
      descrizione: descrizioneController.text,
      codice: codiceController.text,
      famiglia_id: famiglia_id,
      assortimento_id: assortimento_id,
      selezione: selezione,
      ordinamento_campo: ordinamento_campo,
      ordinamento_verso: ordinamento_verso,
    );
    pageStato.value.lista_numero_elementi =
        pageStato.value.articoli_lista.length;
    pageStato.refresh();
  }

  void listaClick(BuildContext context, int indice) {

        Navigator.pushNamed(
        context,
        CatalogoPage.routeName,
        arguments:
        CatalogoPageArgs(
          articoli_lista: pageStato.value.articoli_lista.toList(),
          indice: indice,
        ),
    );
  }

  void _assortimenti_menu(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Assortimenti"),
        content: SingleChildScrollView(
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: pageStato.value.assortimenti_lista.map((elemento) {
                return Container(
                  height: 40,
                  width: double.maxFinite,
                  padding: EdgeInsets.all(5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 2),
                    onPressed: () {
                      _articoli_lista_cerca(assortimento_id: elemento.id);
                      Navigator.pop(context);
                    },
                    child: Text(elemento.descrizione),
                  ),
                );
              }).toList(),
            ),
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

  void _selezioni_menu(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Selezioni"),
        content: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 40,
                width: double.maxFinite,
                padding: EdgeInsets.all(5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 2),
                  onPressed: () {
                    _articoli_lista_cerca(selezione: 'novita');
                    Navigator.pop(context);
                  },
                  child: Text('Novità'),
                ),
              ),
              Container(
                height: 40,
                width: double.maxFinite,
                padding: EdgeInsets.all(5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 2),
                  onPressed: () {
                    _articoli_lista_cerca(selezione: 'nuovi_codici');
                    Navigator.pop(context);
                  },
                  child: Text('Nuovi codici'),
                ),
              ),
              Container(
                height: 40,
                width: double.maxFinite,
                padding: EdgeInsets.all(5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 2),
                  onPressed: () {
                    _articoli_lista_cerca(selezione: 'in_offerta');
                    Navigator.of(context).pop();
                  },
                  child: Text('Prodotti in offerta'),
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

  void _ordinamenti_menu(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Seleziona l'ordine"),
        content: SingleChildScrollView(
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 40,
                  width: double.maxFinite,
                  padding: EdgeInsets.all(5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 2),
                    onPressed: () {},
                    child: Text('Descrizione crescente'),
                  ),
                ),
                Container(
                  height: 40,
                  width: double.maxFinite,
                  padding: EdgeInsets.all(5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 2),
                    onPressed: () {},
                    child: Text('Descrizione decrescente'),
                  ),
                ),
                Container(
                  height: 40,
                  width: double.maxFinite,
                  padding: EdgeInsets.all(5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 2),
                    onPressed: () {},
                    child: Text('Codice crescente'),
                  ),
                ),
                Container(
                  height: 40,
                  width: double.maxFinite,
                  padding: EdgeInsets.all(5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 2),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Codice decrescente'),
                  ),
                ),
              ],
            ),
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
          //   icon: Icon(Icons.sort),
          // ),
          title: Column(
            children: [
              Text(widget.pagina_titolo),
              // if(pageStato.value.lista_numero_elementi >0)
              Obx(
                () => Text(
                  "${pageStato.value.lista_numero_elementi} elementi",
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          centerTitle: true,
          actions: [
            // IconButton(
            //   onPressed: () {
            //     _ordinamenti_menu(context);
            //   },
            //   icon: Icon(Icons.sort),
            // ),
            IconButton(
              onPressed: () {
                app_chiudi();
              },
              icon: Icon(Icons.exit_to_app),
            )
          ],
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
                CategorieWidget(),
                Divider(
                  height: 5,
                  thickness: 2,
                  // color: Theme.of(context).primaryColor,
                ),
                Obx(
                  () => ListaWidget(pageStato.value.articoli_lista),
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
              flex: 6,
              child: TextFormField(
                autofocus: true,
                controller: descrizioneController,
                onChanged: (value) {
                  // Call setState to update the UI
                  codiceController.clear();
                  setState(() {});
                  // if(descrizioneController.text.length >=3){
                  _articoli_lista_cerca();
                  // }
                },
                onEditingComplete: () {
                  _articoli_lista_cerca();
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
                            _articoli_lista_svuota();
                          },
                        ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: codiceController,
                onChanged: (value) {
                  // Call setState to update the UI
                  descrizioneController.clear();
                  setState(() {});
                  // if(codiceController.text.length >=2){
                  _articoli_lista_cerca();
                  // }
                },
                onEditingComplete: () {
                  _articoli_lista_cerca();
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
                            _articoli_lista_svuota();
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
            //       _articoli_lista_cerca();
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
                  _assortimenti_menu(context);
                },
                child: Text('Assortimenti'),
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
                  _selezioni_menu(context);
                },
                child: Text('Selezioni'),
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
                  _articoli_lista_cerca(selezione: 'tutto');
                },
                child: Text('Tutto'),
              ),
            ),
          ],
        ),
      ),
    );
  }

// sezione categorie
  Widget CategorieWidget() => Obx(
        () => Row(
          children: pageStato.value.famiglie_lista.map((elemento) {
            return Expanded(
              flex: 1,
              child: InkWell(
                hoverColor: Color(int.parse(elemento.colore)).withAlpha(50),
                highlightColor:
                    Color(int.parse(elemento.colore)).withAlpha(200),
                splashColor: Colors.grey.shade600,
                focusColor: Color(int.parse(elemento.colore)).withAlpha(125),
                onTap: () {
                  _articoli_lista_cerca(famiglia_id: elemento.id);
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    // color: Color(0xFF009900),
                    border: Border(
                      top: BorderSide(
                        color: Color(int.parse(elemento.colore)),
                        width: 5,
                      ),
                      bottom: BorderSide(
                        color: Color(int.parse(elemento.colore)),
                        width: 5,
                      ),
                    ),
                  ),
                  child: Text(
                    elemento.abbreviazione,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        // color: Colors.white,
                        ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );

  // riga lista
  // Widget ListaWidget(List<CatalogoModel> articoli_lista) {
  Widget ListaWidget(List<Map> articoli_lista) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          height: 5,
          thickness: 2,
          color: Theme.of(context).primaryColor,
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
                      color: Color(int.parse(articoli_lista[index]['famiglie_colore'])),
                      // "${articoli_lista[index]["nome"]}"
                    ),
                  ),
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: MyBorder().MyBorderOrange(),
                    ),
                    child: ListaImmagineWidget(
                        immagine_base64: articoli_lista[index]
                            ['immagine_preview']),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          // alignment: Alignment(-1.0, 0.0),
                          padding: EdgeInsets.all(5.0),
                          decoration: MyBoxDecoration().MyBox(),
                          child: Text(
                            "${articoli_lista[index]['nome']}",
                            style: TextStyle(
                                fontSize: 15.0,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        if (articoli_lista[index]['nuovo'] == 1)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 60,
                              height: 25,
                              decoration: BoxDecoration(
                                border: MyBorder().MyBorderOrange(),
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/immagini/splash_screen.png"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        if (articoli_lista[index]['promozione_id'] > 0)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 60,
                              height: 25,
                              decoration: BoxDecoration(
                                border: MyBorder().MyBorderOrange(),
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/immagini/splash_screen.png"),
                                  fit: BoxFit.contain,
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
      return Image.asset("assets/immagini/splash_screen.png");
    }
  }
}
