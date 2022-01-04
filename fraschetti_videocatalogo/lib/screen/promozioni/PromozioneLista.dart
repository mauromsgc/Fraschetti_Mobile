import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/models/promozioneModel.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';
import 'PromozionePage.dart';

class PromozioneListaPage extends StatefulWidget {
  PromozioneListaPage({Key? key}) : super(key: key);
  static const String routeName = "promozione_lista";
  final String pagina_titolo = "Promozioni";

  @override
  _PromozioneListaPageState createState() => _PromozioneListaPageState();
}

class _PromozioneListaPageState extends State<PromozioneListaPage> {
  List<Map> tour_offerte_lista = [];
  List<Map> promozioni_lista = [];

  int lista_elementi_numero = 0;

  final TextEditingController descrizioneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _tour_offerte_lista_carica();
    if(lista_elementi_numero == 0){
    _promozioni_lista_cerca();
    }
  }

  Future<void> _tour_offerte_lista_carica() async {
    tour_offerte_lista =
        await PromozioneModel.tour_offerte_lista();
    setState(() {});
  }

  Future<void> _promozioni_lista_svuota() async {
    promozioni_lista = [];
    lista_elementi_numero = promozioni_lista.length;
    setState(() {});
  }

  Future<void> _promozioni_lista_cerca({
    String nome = "",
    String tour_singolo = "",
    int tour_intero = 0,
  }) async {
    if ((tour_singolo != "") || (tour_intero != 0)) {
      descrizioneController.clear();
      setState(() {});
    }
    promozioni_lista = await PromozioneModel.promozioni_lista(
      nome: descrizioneController.text,
      tour_singolo: tour_singolo,
      tour_intero: tour_intero,
    );
    lista_elementi_numero = promozioni_lista.length;
    setState(() {});
  }

  void listaClick(BuildContext context, int indice) {
    Navigator.pushNamed(
      context,
      PromozionePage.routeName,
      arguments: PromozionePageArgs(
        promozioni_lista: promozioni_lista.toList(),
        indice: indice,
      ),
    );
  }

  void _tour_singolo_menu(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Tour"),
        content: SingleChildScrollView(
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: tour_offerte_lista.map((elemento) {
                return Container(
                  height: 40,
                  width: double.maxFinite,
                  padding: EdgeInsets.all(5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 2),
                    onPressed: () {
                      _promozioni_lista_cerca(tour_singolo: elemento["tour"]);
                      Navigator.pop(context);
                    },
                    child: Text(elemento["tour"]),
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
          // title: Text("${getIt.get<SessioneModel>().bottom_bar_indice.toString()} ${widget.pagina_titolo}"),
          title: Column(
            children: [
              Text(widget.pagina_titolo),
              // if(lista_elementi_numero >0)
              Text(
                  "${lista_elementi_numero} elementi",
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
                ListaWidget(promozioni_lista),
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
                controller: descrizioneController,
                onChanged: (value) {
                  setState(() {});
                  // if(descrizioneController.text.length >=3){
                  _promozioni_lista_cerca();
                  // }
                },
                onEditingComplete: () {
                  _promozioni_lista_cerca();
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
                            _promozioni_lista_cerca();
                            // _promozioni_lista_svuota();
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
            //       _promozioni_lista_cerca();
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
                  _promozioni_lista_cerca(tour_intero: 1);
                },
                child: Text('Tour intero'),
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
                  _tour_singolo_menu(context);
                },
                child: Text('Tour singolo'),
              ),
            ),
          ],
        ),
      ),
    );
  }

// riga lista
  Widget ListaWidget(List<Map> promozioni_lista) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          height: 5,
          thickness: 2,
          // color: Theme.of(context).primaryColor,
        ),
        itemCount: promozioni_lista.length,
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
                    width: 60,
                    decoration: MyBoxDecoration().MyBox(),
                    child: ListaImmagineWidget(
                        immagine_base64: promozioni_lista[index]
                            ['immagine_preview']),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment(-1.0, 0.0),
                      padding: EdgeInsets.all(5.0),
                      decoration: MyBoxDecoration().MyBox(),
                      child: Text(
                        "${promozioni_lista[index]['nome']}",
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
