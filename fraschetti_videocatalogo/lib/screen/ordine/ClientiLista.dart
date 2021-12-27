import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/components/OrdineTopMenu.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/models/clienteModel.dart';
import 'package:fraschetti_videocatalogo/screen/catalogo/CatalogoPage.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/OrdineArticoloAggiungiPage.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/OrdineCodiceCercaPage.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/OrdineLista.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_it/get_it.dart';

class ClientiListaPageArgs {
  String? pagina_chiamante_route;

  ClientiListaPageArgs({
    this.pagina_chiamante_route = "",
  });
}

class ClienteLista extends StatefulWidget {
  ClienteLista({Key? key}) : super(key: key);
  static const String routeName = "ordini_clienti_lista";
  final String pagina_titolo = "Clienti";

  @override
  _ClienteListaState createState() => _ClienteListaState();
}

class _ClienteListaState extends State<ClienteLista> {
  ClientiListaPageArgs argomenti = ClientiListaPageArgs();
  List<Map> clienti_lista = [];

  int lista_elementi_numero = 0;

  final TextEditingController nominativoController = TextEditingController();
  final TextEditingController codiceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    GetIt.instance<SessioneModel>().ordine_top_menu_indice = 0;
  }

  @override
  void didChangeDependencies() {

    if (ModalRoute.of(context)?.settings.arguments != null) {
      argomenti =
      ModalRoute.of(context)?.settings.arguments as ClientiListaPageArgs;
    }

    super.didChangeDependencies();
  }

  Future<void> _clienti_lista_svuota() async {
    clienti_lista = [];
    lista_elementi_numero = clienti_lista.length;
    setState(() {});
  }

  Future<void> _clienti_lista_cerca({
    int id = 0,
    String nominativo = "",
    String codice = "",
    String selezione = "", // selezione "tutti" "con_ordini"
  }) async {
    if (selezione != "") {
      nominativoController.clear();
      codiceController.clear();
      setState(() {});
    }
    clienti_lista = await ClienteModel.clienti_lista(
      id: id,
      nominativo: nominativoController.text,
      codice: codiceController.text,
      selezione: selezione,
    );
    lista_elementi_numero = clienti_lista.length;
    setState(() {});
  }

  Future<void> listaClick(BuildContext context, {int clienti_id = 0}) async {
    bool cliente_selezionato = await GetIt.instance<SessioneModel>()
        .cliente_seleziona(cliente_id: clienti_id);

    if (cliente_selezionato == true) {
      // selezione al cliente e va in ordine
      GetIt.instance<SessioneModel>().ordine_top_menu_indice = 1;

      switch (argomenti.pagina_chiamante_route) {
        case CatalogoPage.routeName:
          Navigator.pop(context);
          break;
        case OrdineCodiceCercaPage.routeName:
          Navigator.pop(context);
          break;

        default:
          Navigator.popAndPushNamed(context, OrdineLista.routeName);
      }
    }
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
                ListaWidget(clienti_lista),
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
                // autofocus: true,
                controller: nominativoController,
                onChanged: (value) {
                  // Call setState to update the UI
                  codiceController.clear();
                  setState(() {});
                  // if(descrizioneController.text.length >=3){
                  _clienti_lista_cerca();
                  // }
                },
                onEditingComplete: () {
                  _clienti_lista_cerca();
                },
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                  border: OutlineInputBorder(),
                  hintText: 'Nominativo',
                  suffixIcon: nominativoController.text.length == 0
                      ? null
                      : IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            nominativoController.clear();
                            setState(() {});
                            _clienti_lista_svuota();
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
                  nominativoController.clear();
                  setState(() {});
                  // if(codiceController.text.length >=2){
                  _clienti_lista_cerca();
                  // }
                },
                onEditingComplete: () {
                  _clienti_lista_cerca();
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
                            _clienti_lista_svuota();
                          },
                        ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            // Expanded(
            //   flex: 2,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(elevation: 2),
            //     onPressed: () {
            //       _clienti_lista_cerca();
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
                  _clienti_lista_cerca(selezione: 'con_ordine');
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
                  _clienti_lista_cerca(selezione: 'tutti');
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
          // color: Theme.of(context).primaryColor,
        ),
        itemCount: clienti_lista.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              listaClick(context, clienti_id: clienti_lista[index]['id']);
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
                      "${clienti_lista[index]['codice']}",
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
