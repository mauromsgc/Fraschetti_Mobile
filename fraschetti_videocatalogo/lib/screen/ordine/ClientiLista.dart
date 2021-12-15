import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/components/OrdineTopMenu.dart';
import 'package:fraschetti_videocatalogo/main.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/models/clienteModel.dart';
import 'package:fraschetti_videocatalogo/repositories/comunicazioniRepository.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/OrdineLista.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_it/get_it.dart';

class ClienteLista extends StatefulWidget {
  ClienteLista({Key? key}) : super(key: key);
  static const String routeName = "ordini_clienti_lista";
  final String pagina_titolo = "Clienti";

  @override
  _ClienteListaState createState() => _ClienteListaState();
}

final pageStato = PageStore().obs;

class PageStore {
  List<Map> clienti_lista = [];

  PageStore() {
    print("PageStore inizializza ");
    inizializza();
  }

  void inizializza() async {
    _clienti_lista_carica();
  }

  Future<void> _clienti_lista_carica() async {
    clienti_lista = await ClienteModel.clienti_lista();
    print("clienti_lista: " + clienti_lista.length.toString());
    // clienti_lista.forEach((ClienteModel cliente) async {
    //   print(cliente.ragione_sociale);
    // });
    pageStato.refresh();
  }

  void clienti_cerca() async {
    _clienti_lista_carica();
  }

  void clienti_con_ordine() async {
    _clienti_lista_carica();
  }

  void clienti_tutti() async {
    _clienti_lista_carica();
  }
}

class _ClienteListaState extends State<ClienteLista> {
  @override
  void initState() {
    super.initState();
  }

  void listaClick(BuildContext context, int index) {
    // selezione al cliente e va in ordine
    GetIt.instance<SessioneModel>().ordine_top_menu_indice = 1;
    // poi spostarlo un utente corrente
    GetIt.instance<SessioneModel>().cliente_id_selezionato = index;

    Navigator.popAndPushNamed(context, OrdineLista.routeName);
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
          title: Text(widget.pagina_titolo),
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
                RicercaWidget(),
                SelezioniWidget(),
                Divider(
                  height: 5,
                  thickness: 2,
                  // color: Theme.of(context).primaryColor,
                ),
                Obx(
                  () => ListaWidget(pageStato.value.clienti_lista),
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
                onEditingComplete: () {
                  pageStato.value.clienti_cerca();

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
                  hintText: 'Nominativo',
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: TextFormField(
                onEditingComplete: () {
                  pageStato.value.clienti_cerca();

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
                  hintText: 'Codice',
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
                  pageStato.value.clienti_cerca();
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
                  pageStato.value.clienti_con_ordine();
                },
                child: Text('Clienti con ordini'),
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
                  pageStato.value.clienti_tutti();
                },
                child: Text('Tutti'),
              ),
            ),
          ],
        ),
      ),
    );
  }

// riga lista
  Widget ListaWidget(List<Map> clienti_lista) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          height: 5,
          thickness: 2,
          color: Theme.of(context).primaryColor,
        ),
        itemCount: clienti_lista.length,
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
                    alignment: Alignment(0.0, 0.0),
                    width: 60,
                    decoration: MyBoxDecoration().MyBox(),
                    child: Text(
                      "${clienti_lista[index]['id']}",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 5.0, right: 5.0),
                      decoration: MyBoxDecoration().MyBox(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${clienti_lista[index]['ragione_sociale']}",
                            style: TextStyle(
                              fontSize: 18.0,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            "${clienti_lista[index]['localita']}",
                            style: TextStyle(
                              fontSize: 10.0,
                              overflow: TextOverflow.ellipsis,
                            ),
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
}
