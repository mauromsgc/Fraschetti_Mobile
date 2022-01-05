import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/components/OrdineTopMenu.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/models/ordineModel.dart';
import 'package:fraschetti_videocatalogo/models/ordineRigaModel.dart';
import 'package:fraschetti_videocatalogo/screen/disponibilita/DisponibilitaWidget.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/ClientiLista.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/OrdineArticoloAggiungiPage.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/OrdineNoteAggiungiPage.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';
import 'package:fraschetti_videocatalogo/utils/Utility.dart';
import 'package:get_it/get_it.dart';

class OrdineLista extends StatefulWidget {
  OrdineLista({Key? key}) : super(key: key);
  static const String routeName = "ordini_clienti";
  final String pagina_titolo = "Ordine cliente";

  @override
  _OrdineListaState createState() => _OrdineListaState();
}

class _OrdineListaState extends State<OrdineLista> {
  OrdineModel ordine_scheda = OrdineModel();

  int lista_elementi_numero = 0;

  @override
  void initState() {
    super.initState();
    GetIt.instance<SessioneModel>().ordine_top_menu_indice = 1;
    _ordine_cliente_carica();
  }

  @override
  void didChangeDependencies() {
    print("didChangeDependencies OrdineLista");
  }

  Future<void> _ordine_cliente_carica() async {
    ordine_scheda = await OrdineModel.ordine_cliente_carica(
      cliente_id: GetIt.instance<SessioneModel>().clienti_id_selezionato,
    );
    lista_elementi_numero = ordine_scheda.righe.length;

    setState(() {});
  }

  Future<void> listaClick(BuildContext context, {String codice = ""}) async {
    Navigator.pushNamed(
      context,
      OrdineArticoloAggiungiPage.routeName,
      arguments: OrdineArticoloAggiungiPageArgs(
        codice: codice,
      ),
    );

  }

  void articolo_disponibilita_mostra(
    BuildContext context,
    int codice_id,
  ) {
    showDialog(
      context: context,
      builder:
          DisponibilitaDialogWidget(codice_id: codice_id, returnValue: true),
    );
  }

  void ordine_note_aggiungi(BuildContext context) {
    Navigator.pushNamed(context, OrdineNoteAggiungiPage.routeName);
  }

  Future<void> ordine_chiudi() async {
    GetIt.instance<SessioneModel>().cliente_deseleziona();
    Navigator.popAndPushNamed(context, ClienteLista.routeName);
  }

  Future<void> ordine_riga_elimina({int id = 0, int index = 0}) async {
    int record_elaborati = await OrdineRigaModel.record_elimina(id: id);
    print("record_elaborati ${record_elaborati}");

    if (record_elaborati > 0) {
      setState(() {
        ordine_scheda.righe.removeAt(index);
      });
    } else {
      // setState(() {
      //   errore_generico = "Errore durante il salvataggio, annulla o riprova";
      // });
    }
  }

  Future<void> ordine_elimina() async {
    int ordine_id = GetIt.instance<SessioneModel>().ordine_id_corrente;
    print("eliminare ordine_id ${ordine_id}");

    try{
    int record_elaborati = await OrdineModel.record_elimina(
        id: GetIt.instance<SessioneModel>().ordine_id_corrente);
    print("record_elaborati ${record_elaborati}");

    GetIt.instance<SessioneModel>().cliente_deseleziona();
    Navigator.popAndPushNamed(context, ClienteLista.routeName);
    } catch (exception) {
      print('errore cancelllazione ordine: $exception');
    }

  }

  void ordine_totale_mostra() async {

    double totale_imponibile = ordine_scheda.totale_imponibile;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Totale ordine"),
          content: Text("${totale_imponibile.toImporti()}"),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("Chiudi"),
            ),
          ],
        );
      },
    );
  }


  void _ordine_numero_seleziona({int numero = 0}) async {
    print("numero reso selezionare ${numero}");

    ordine_scheda = await OrdineModel.ordine_cliente_seleziona(
      cliente_id: GetIt.instance<SessioneModel>().clienti_id_selezionato,
      numero: numero,
    );
    lista_elementi_numero = ordine_scheda.righe.length;

    setState(() {});
  }

  void _ordine_numero_seleziona_scegli() async {
    List<OrdineModel> resi_lista = await OrdineModel.ordini_cerca(
      clienti_id: GetIt.instance<SessioneModel>().clienti_id_selezionato,
      ordinamento: "numero ASC",
    );

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Container(
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var _reso in resi_lista)
                Container(
                  height: 40,
                  width: double.maxFinite,
                  padding: EdgeInsets.all(5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 2),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _ordine_numero_seleziona(numero: _reso.numero);
                    },
                    child: Text("Reso ${_reso.numero}"),
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
                    _ordine_numero_seleziona(
                        numero: resi_lista[resi_lista.length - 1].numero + 1);
                  },
                  child: Text("Nuovo reso"),
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

  void ordine_azioni_mostra() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Seleziona un'azione"),
        content: Container(
          width: 200,
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
                    Navigator.of(context).pop();
                    ordine_chiudi();
                  },
                  child: Text('Ordine chiudi'),
                ),
              ),
              Container(
                height: 40,
                width: double.maxFinite,
                padding: EdgeInsets.all(5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 2),
                  onPressed: () async {
                    Navigator.of(context).pop();

                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Attenzione"),
                          content: const Text("Eliminare l'ordine corrente?"),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: const Text("Annulla"),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  ordine_elimina();
                                },
                                child: const Text("Elimina")),
                          ],
                        );
                      },
                    );
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
                ListaWidget(ordine_scheda.righe),
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
            if (GetIt.instance<SessioneModel>().clienti_id_selezionato == 0)
              Container(
                decoration: MyBoxDecoration().MyBox(),
                height: 40,
                alignment: Alignment.center,
                child: Text(
                  "Selezionare un cliente",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
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
                if (GetIt.instance<SessioneModel>().clienti_id_selezionato != 0)
                  Expanded(
                  flex: 2,
                  child: Container(
                    // padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 2),
                      onPressed: () => _ordine_numero_seleziona_scegli(),
                      child: Text(
                          "Ordine numero ${ordine_scheda.numero.toString()}"),
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
  Widget ListaWidget(List<OrdineRigaModel> ordine_righe_lista) {
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
            key: UniqueKey(),
            background: Container(
                // child: Padding(
                //   padding: const EdgeInsets.all(15),
                //   // child: Icon(Icons.favorite, color: Colors.white),
                // ),
                ),
            // background: Container(
            //   color: Colors.green,
            //   child: Padding(
            //     padding: const EdgeInsets.all(15),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: <Widget>[
            //         Text('Disponibilità', style: TextStyle(color: Colors.white)),
            //       ],
            //     ),
            //   ),
            // ),
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
                    content: const Text("Eliminare la riga corrente?"),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text("Annulla"),
                      ),
                      ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text("Elimina")),
                    ],
                  );
                },
              );
            },
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart) {
                print('Remove item');

                ordine_riga_elimina(
                  id: ordine_righe_lista[index].id,
                  index: index,
                );
              }
              // if (direction == DismissDirection.startToEnd) {
              //   articolo_disponibilita_mostra(
              //     context,
              //     ordine_righe_lista[index].codice_scheda.id,
              //   );
              // }
            },
            child: InkWell(
              onTap: () {
                listaClick(context, codice: ordine_righe_lista[index].codice);
              },
              onLongPress: () {
                articolo_disponibilita_mostra(
                    context, ordine_righe_lista[index].codice_scheda.id);
              },
              child: Container(
                height: 50,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          // codice
                          padding: EdgeInsets.all(2),
                          alignment: Alignment.center,
                          width: 70,
                          // color: Colors.orange,
                          decoration: MyBoxDecoration().MyBox(),
                          child: Text(
                            ordine_righe_lista[index].codice,
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
                              ordine_righe_lista[index].descrizione,
                              style: TextStyle(
                                // fontSize: 14,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          // unità di misura
                          padding: EdgeInsets.all(2),
                          alignment: Alignment.centerRight,
                          width: 30,
                          decoration: MyBoxDecoration().MyBox(),
                          child: Text(
                            ordine_righe_lista[index].um,
                            // style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        Container(
                          // quantità
                          padding: EdgeInsets.all(2),
                          alignment: Alignment.centerRight,
                          width: 50,
                          decoration: MyBoxDecoration().MyBox(),
                          child: Text(
                            ordine_righe_lista[index].quantita.toQuantita(),
                            // style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        Container(
                          // prezzo
                          padding: EdgeInsets.all(2),
                          alignment: Alignment.centerRight,
                          width: 75,
                          decoration: MyBoxDecoration().MyBox(),
                          child: Text(
                            ordine_righe_lista[index].prezzo_ordine.toImporti(),
                            // style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        Container(
                          // totale
                          padding: EdgeInsets.all(2),
                          alignment: Alignment.centerRight,
                          width: 80,
                          decoration: MyBoxDecoration().MyBox(),
                          child: Text(
                            ordine_righe_lista[index]
                                .prezzo_riga_totale
                                .toImporti(),
                            // style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ],
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
