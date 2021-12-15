import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/main.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/models/promozioneModel.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:fraschetti_videocatalogo/repositories/promozioniRepository.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_it/get_it.dart';

import 'PromozionePage.dart';

class PromozioneListaPage extends StatefulWidget {
  PromozioneListaPage({Key? key}) : super(key: key);
  static const String routeName = "promozione_lista";
  final String pagina_titolo = "Promozioni";

  @override
  _PromozioneListaPageState createState() => _PromozioneListaPageState();
}

final pageStato = PageStore().obs;

class PageStore {
  List<PromozioneModel> promozioni_lista = [];

  PageStore() {
    print("PageStore inizializza ");
    inizializza();
  }

  void inizializza() async {
    promozioni_lista_carica();
  }

  Future<void> promozioni_lista_carica() async {
    promozioni_lista = await GetIt.instance<DbRepository>().promozioni_lista();
    print("promozioni_lista: " + promozioni_lista.length.toString());
    // promozioni_lista.forEach((PromozioneModel promozione) async {
    //   print(promozione.nome);
    // });
    pageStato.refresh();
  }

  void promozioni_cerca() async {
    promozioni_lista_carica();
  }

  void promozioni_tour_intero() async {
    promozioni_lista_carica();
  }

  void promozioni_tour_singolo() async {
    promozioni_lista_carica();
  }
}

class _PromozioneListaPageState extends State<PromozioneListaPage> {
  @override
  void initState() {
    super.initState();
  }

  void listaClick(BuildContext context) {
    Navigator.pushNamed(context, PromozionePage.routeName);
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
                Obx(
                      () => ListaWidget(pageStato.value.promozioni_lista),
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
              flex: 5,
              child: TextFormField(
                onEditingComplete: () {
                  pageStato.value.promozioni_cerca();

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
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                  border: OutlineInputBorder(),
                  // labelText: 'Descrizione/EAN',
                  // labelText: 'Descrizione',
                  hintText: 'Descrizione',
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
                onPressed: () {
                  pageStato.value.promozioni_cerca();
                },
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
                onPressed: () {
                  pageStato.value.promozioni_tour_intero();
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
                  pageStato.value.promozioni_tour_singolo();
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
  Widget ListaWidget(List<PromozioneModel> promozioni_lista) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          height: 5,
          thickness: 2,
          color: Theme.of(context).primaryColor,
        ),
        itemCount: promozioni_lista.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              listaClick(context);
            },
            child: Container(
              height: 40,
              // decoration: MyBoxDecoration().MyBox(),
              child: Row(
                  children: <Widget>[
                    Container(
                      width: 40,
                      decoration: BoxDecoration(
                        border: MyBorder().MyBorderOrange(),
                        image: DecorationImage(
                          image: AssetImage("assets/immagini/splash_screen.png"),
                          fit: BoxFit.contain,
                        ),
                      ),

                      // child:
                      // Image.memory(
                      //   Base64Decoder().convert(promozioni_lista[index].immagine_preview),
                      //   width: 200,
                      // ),

                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment(-1.0, 0.0),
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          border: MyBorder().MyBorderOrange(),
                        ),
                        child: Text(
                          "${promozioni_lista[index].nome}",
                          style: TextStyle(
                              fontSize: 18.0,
                              overflow: TextOverflow.ellipsis
                          ),
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
