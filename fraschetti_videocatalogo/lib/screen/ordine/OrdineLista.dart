import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/components/OrdineTopMenu.dart';
import 'package:fraschetti_videocatalogo/main.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/models/catalogoModel.dart';
import 'package:fraschetti_videocatalogo/models/codiceModel.dart';
import 'package:fraschetti_videocatalogo/models/comunicazioneModel.dart';
import 'package:fraschetti_videocatalogo/models/ordineModel.dart';
import 'package:fraschetti_videocatalogo/repositories/comunicazioniRepository.dart';
import 'package:fraschetti_videocatalogo/screen/disponibilita/DisponibilitaPage.dart';
import 'package:fraschetti_videocatalogo/screen/disponibilita/DisponibilitaWidget.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/ClientiLista.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/OrdineArticoloAggiungiPage.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/OrdineNoteAggiungiPage.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';
import 'package:get_it/get_it.dart';




class OrdineLista extends StatefulWidget {
  OrdineLista({Key? key}) : super(key: key);
  static const String routeName = "ordini_clienti";
  final String pagina_titolo = "Ordine cliente";

  @override
  _OrdineListaState createState() => _OrdineListaState();
}

class _OrdineListaState extends State<OrdineLista> {
  List<OrdineModel> ordine_righe_lista = [];

  int lista_elementi_numero = 0;


  @override
  void initState() {
    super.initState();
    GetIt.instance<SessioneModel>().ordine_top_menu_indice = 1;
    _clienti_lista_cerca();
  }


  Future<void> _clienti_lista_cerca() async {

    ordine_righe_lista = await OrdineModel.ordini_lista(
      cliente_id: GetIt.instance<SessioneModel>().cliente_id_selezionato,
      ordini_numero: GetIt.instance<SessioneModel>().ordine_numero_corrente,
    );
    lista_elementi_numero = ordine_righe_lista.length;
    setState(() {});
  }

  Future<void> listaClick(BuildContext context, {int id = 0}) async {

    Navigator.pushNamed(context, OrdineArticoloAggiungiPage.routeName);

    // bool cliente_selezionato = await GetIt.instance<SessioneModel>()
    //     .cliente_seleziona(cliente_id: clienti_id);
    //
    // if (cliente_selezionato == true) {
    //   // seleziona il cliente e va in ordine
    //   GetIt.instance<SessioneModel>().ordine_top_menu_indice = 1;
    //
    //   switch (argomenti.pagina_chiamante_route) {
    //     case CatalogoPage.routeName:
    //       Navigator.pop(context);
    //       break;
    //     case OrdineCodiceCercaPage.routeName:
    //       Navigator.pop(context);
    //       break;
    //
    //     default:
    //       Navigator.popAndPushNamed(context, OrdineLista.routeName);
    //   }
    // }
  }

  void articolo_disponibilita_mostra(
      BuildContext context,
      int codice_id,
      ) {
    // Navigator.pushNamed(context, DisponibilitaPage.routeName);
    showDialog(
      context: context,
      builder: DisponibilitaDialogWidget(
          codice_id: codice_id, returnValue: true),
    );
  }


  void ordine_note_aggiungi(BuildContext context) {
    Navigator.pushNamed(context, OrdineNoteAggiungiPage.routeName);
  }

  Future<void> ordine_chiudi() async {
     await GetIt.instance<SessioneModel>().cliente_deseleziona();
    Navigator.popAndPushNamed(context, ClienteLista.routeName);

  }

  Future<void> ordine_riga_elimina({int id = 0}) async {
    await GetIt.instance<SessioneModel>().cliente_deseleziona();
    Navigator.popAndPushNamed(context, ClienteLista.routeName);

  }

  Future<void> ordine_elimina() async {
    await GetIt.instance<SessioneModel>().cliente_deseleziona();
    Navigator.popAndPushNamed(context, ClienteLista.routeName);

  }

  Future<void> ordine_totale_mostra() async {
    await GetIt.instance<SessioneModel>().cliente_deseleziona();
    Navigator.popAndPushNamed(context, ClienteLista.routeName);

  }

  void ordine_numeroOnSubmit(BuildContext context) {
    return;
  }

  void ordine_azioni_mostra() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Seleziona un'azione"),
        content: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 40,
                // width: double.maxFinite,
                width: 300,
                padding: EdgeInsets.all(5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 2),
                  onPressed: () {
                    Navigator.of(context).pop();
                    ordine_chiudi();
                  },
                  child: Text('Ordine chiudi'),
                ),
              ),
              Container(
                height: 40,
                // width: double.maxFinite,
                width: 300,
                padding: EdgeInsets.all(5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 2),
                  onPressed: () {
                    Navigator.of(context).pop();
                    ordine_elimina();
                  },
                  child: Text('Ordine elimina'),
                ),
              ),
              Container(
                // solo per agenti
                height: 40,
                // width: double.maxFinite,
                width: 300,
                padding: EdgeInsets.all(5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 2),
                  onPressed: () {
                    Navigator.of(context).pop();
                    ordine_totale_mostra();
                  },
                  child: Text('Totale ordine'),
                ),
              ),
              // Container(
              //   // lo fa già il server
              //   height: 40,
              //   // width: double.maxFinite,
              //   width: 300,
              //   padding: EdgeInsets.all(5),
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(elevation: 2),
              //     onPressed: () {
              //       Navigator.of(context).pop();
              //     },
              //     child: Text('Invia email con prezzi'),
              //   ),
              // ),
              // Container(
              //   // lo fa già il server
              //   height: 40,
              //   // width: double.maxFinite,
              //   width: 300,
              //   padding: EdgeInsets.all(5),
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(elevation: 2),
              //     onPressed: () {
              //       Navigator.of(context).pop();
              //     },
              //     child: Text('Invia email senza prezzi'),
              //   ),
              // ),
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
          actions: [
            IconButton(
              onPressed: () {
                ordine_note_aggiungi(context);
              },
              icon: Icon(Icons.note_add),
            ),
            IconButton(
              onPressed: () {
                ordine_azioni_mostra();
              },
              icon: Icon(Icons.more_vert),
            ),
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
                OrdineTopMenu(),
                Divider(),
                OrdineIntestazioneWidget(),
                Divider(
                  height: 5,
                  thickness: 2,
                  // color: Theme.of(context).primaryColor,
                ),
                ListaWidget(ordine_righe_lista),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget OrdineIntestazioneWidget() {
    return Padding(
      padding: EdgeInsets.all(3),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              // cliente nominativo
              // padding: EdgeInsets.all(3),
              child: TextFormField(
                enabled: false,
                initialValue: GetIt.instance<SessioneModel>()
                    .cliente_Nominativo_selezionato,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                  border: OutlineInputBorder(),
                  labelText: "Cliente",
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    // articolo codice
                    width: 100,
                    // padding: EdgeInsets.all(5),
                    child: TextFormField(
                      // readOnly: true,
                      enabled: false,
                      initialValue: GetIt.instance<SessioneModel>()
                          .cliente_Localita_selezionato,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        labelText: "Località",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    // padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 2),
                      onPressed: () => ordine_numeroOnSubmit(context),
                      child: Text(
                          "Ordine numero ${GetIt.instance<SessioneModel>().ordine_numero_corrente}"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

// riga lista
  Widget ListaWidget(List<OrdineModel> ordine_righe_lista) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          height: 5,
          thickness: 2,
          // color: Theme.of(context).primaryColor,
        ),
        itemCount: ordine_righe_lista.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key("${index}"),
            background: Container(
              child: Padding(
                padding: const EdgeInsets.all(15),
                // child: Icon(Icons.favorite, color: Colors.white),
              ),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.delete, color: Colors.white),
                    Text('Elimina', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            confirmDismiss: (DismissDirection direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Attenzione"),
                    content: const Text("Eliminara la riga corrente?"),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text("Annulla"),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                            ordine_riga_elimina(id: ordine_righe_lista[index].id);
                          },
                          child: const Text("Elimina")),
                    ],
                  );
                },
              );
            },
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd) {
                print("Add to favorite");
              } else {
                print('Remove item');
              }

              setState(() {
              });
            },
            child: InkWell(
              onTap: () {
                listaClick(context, id: ordine_righe_lista[index].id);
              },
              onLongPress: () {
                articolo_disponibilita_mostra(context, ordine_righe_lista[index].codice_scheda.id);
              },
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      // codice
                      alignment: Alignment(0.0, 1.0),
                      width: 60,
                      // color: Colors.orange,
                      decoration: MyBoxDecoration().MyBox(),
                      child: Text(
                        ordine_righe_lista[index].articolo_codice,
                        // style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    Expanded(
                      // descrizione
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        alignment: Alignment(-1.0, 0.0),
                        decoration: MyBoxDecoration().MyBox(),
                        child: Text(
                          ordine_righe_lista[index].descrizione,
                          maxLines: 1,
                          style: TextStyle(
                            // fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // unità di misura
                      alignment: Alignment(0.0, 0.0),
                      width: 25,
                      decoration: MyBoxDecoration().MyBox(),
                      child: Text(
                        ordine_righe_lista[index].um,
                        // style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Container(
                      // quantità
                      padding: EdgeInsets.all(2),
                      alignment: Alignment(1.0, 0.0),
                      width: 45,
                      decoration: MyBoxDecoration().MyBox(),
                      child: Text(
                        ordine_righe_lista[index].quantita.toStringAsFixed(2),
                        // style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Container(
                      // prezzo
                      padding: EdgeInsets.all(2),
                      alignment: Alignment(1.0, 0.0),
                      width: 75,
                      decoration: MyBoxDecoration().MyBox(),
                      child: Text(
                        ordine_righe_lista[index].prezzo_ordine.toStringAsFixed(2),
                        // style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Container(
                      // totale
                      padding: EdgeInsets.all(2),
                      alignment: Alignment(1.0, 0.0),
                      width: 80,
                      decoration: MyBoxDecoration().MyBox(),
                      child: Text(
                        ordine_righe_lista[index].prezzo_riga_totale.toStringAsFixed(2),
                        // style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
