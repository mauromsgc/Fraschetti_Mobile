import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/components/OrdineTopMenu.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/models/resoModel.dart';
import 'package:fraschetti_videocatalogo/models/resoRigaModel.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/ClientiLista.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/ResoArticoloAggiungiPage.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';
import 'package:fraschetti_videocatalogo/utils/Utility.dart';
import 'package:get_it/get_it.dart';

class OrdineResiLista extends StatefulWidget {
  OrdineResiLista({Key? key}) : super(key: key);
  static const String routeName = "ordini_resi_clienti";
  final String pagina_titolo = "Reso cliente";

  @override
  _OrdineResiListaState createState() => _OrdineResiListaState();
}

class _OrdineResiListaState extends State<OrdineResiLista> {
  ResoModel reso_scheda = ResoModel();

  int lista_elementi_numero = 0;

  @override
  void initState() {
    super.initState();
    GetIt.instance<SessioneModel>().ordine_top_menu_indice = 3;
    _reso_cliente_carica();
  }

  @override
  void didChangeDependencies() {
    print("didChangeDependencies ResoLista");
  }

  Future<void> _reso_cliente_carica() async {
    reso_scheda = await ResoModel.reso_cliente_carica(
      cliente_id: GetIt.instance<SessioneModel>().clienti_id_selezionato,
    );
    lista_elementi_numero = reso_scheda.righe.length;

    setState(() {});
  }

  Future<void> listaClick(BuildContext context, {int id = 0}) async {
    Navigator.pushNamed(
    // Navigator.popAndPushNamed(
      context,
      ResoArticoloAggiungiPage.routeName,
      arguments: ResoArticoloAggiungiPageArgs(
        id: id,
      ),
    );
  }

  void _reso_aggiungi(BuildContext context) {
    Navigator.pushNamed(context, ResoArticoloAggiungiPage.routeName);
  }

  Future<void> reso_chiudi() async {
    GetIt.instance<SessioneModel>().cliente_deseleziona();
    Navigator.popAndPushNamed(context, ClienteLista.routeName);
  }

  Future<void> reso_riga_elimina({int id = 0, int index = 0}) async {
    int record_elaborati = await ResoRigaModel.record_elimina(id: id);
    print("record_elaborati ${record_elaborati}");

    if (record_elaborati > 0) {
      setState(() {
        reso_scheda.righe.removeAt(index);
      });
    } else {
      // setState(() {
      //   errore_generico = "Errore durante il salvataggio, annulla o riprova";
      // });
    }
  }

  Future<void> reso_elimina() async {
    int reso_id = GetIt.instance<SessioneModel>().reso_id_corrente;
    print("eliminare reso_id ${reso_id}");

    try {
      int record_elaborati = await ResoModel.record_elimina(
          id: GetIt.instance<SessioneModel>().reso_id_corrente);
      print("record_elaborati ${record_elaborati}");

      GetIt.instance<SessioneModel>().cliente_deseleziona();
      Navigator.popAndPushNamed(context, ClienteLista.routeName);
    } catch (exception) {
      print('errore cancelllazione reso: $exception');
    }
  }

  void numeroOnSubmit(BuildContext context) {
    return;
  }

  void resi_azioni_mostra(BuildContext context) {
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
                    reso_chiudi();
                  },
                  child: Text('Reso chiudi'),
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
                          content: const Text("Eliminare il reso corrente?"),
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
                                  reso_elimina();
                                },
                                child: const Text("Elimina")),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Reso elimina'),
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
                resi_azioni_mostra(context);
              },
              icon: Icon(Icons.more_vert),
            )
          ],
        ),
        bottomNavigationBar: BottomBarWidget(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _reso_aggiungi(context);
          },
          label: const Text('Reso'),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.red,
        ),
        body: Container(
          child: Container(
            // padding: new EdgeInsets.all(10.0),
            // decoration: MyBoxDecoration().MyBox(),
            // width: 600,
            child: Column(
              children: <Widget>[
                OrdineTopMenu(),
                Divider(),
                ResoIntestazioneWidget(),
                Divider(
                  height: 5,
                  thickness: 2,
                  // color: Theme.of(context).primaryColor,
                ),
                ListaWidget(reso_scheda.righe),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ResoIntestazioneWidget() {
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
                      onPressed: () => numeroOnSubmit(context),
                      child:
                          Text("Reso numero ${reso_scheda.numero.toString()}"),
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
  Widget ListaWidget(List<ResoRigaModel> reso_righe_lista) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          height: 5,
          thickness: 2,
          // color: Theme.of(context).primaryColor,
        ),
        itemCount: reso_righe_lista.length,
        // itemCount: 10,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            background: Container(
                // child: Padding(
                //   padding: const EdgeInsets.all(15),
                //   child: Icon(Icons.favorite, color: Colors.white),
                // ),
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
              print('Remove item');

              reso_riga_elimina(
                id: reso_righe_lista[index].id,
                index: index,
              );
            },
            child: InkWell(
              onTap: () {
                listaClick(context, id: reso_righe_lista[index].id);
              },
              child: Container(
                // height: 50,
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(2),
                            alignment: Alignment.centerLeft,
                            decoration: MyBoxDecoration().MyBox(),
                            child: Text(
                              reso_righe_lista[index].causale_reso_descrizione,
                              style: TextStyle(
                                // fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          // unità di misura
                          padding: EdgeInsets.all(2),
                          alignment: Alignment.centerRight,
                          width: 30,
                          decoration: MyBoxDecoration().MyBox(),
                          child: Text(
                            reso_righe_lista[index].um,
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
                            reso_righe_lista[index].quantita.toQuantita(),
                            // style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        Container(
                          // fattura numero
                          padding: EdgeInsets.all(2),
                          alignment: Alignment.centerRight,
                          width: 80,
                          decoration: MyBoxDecoration().MyBox(),
                          child: Text(
                            reso_righe_lista[index].fattura_numero,
                            // style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        Container(
                          // fattura data
                          padding: EdgeInsets.all(2),
                          alignment: Alignment.centerRight,
                          width: 80,
                          decoration: MyBoxDecoration().MyBox(),
                          child: Text(
                            reso_righe_lista[index].fattura_data,
                            // style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // codice
                          padding: EdgeInsets.all(2),
                          alignment: Alignment.centerLeft,
                          width: 70,
                          // color: Colors.orange,
                          decoration: MyBoxDecoration().MyBox(),
                          child: Text(
                            reso_righe_lista[index].codice,
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
                              reso_righe_lista[index].descrizione,
                              style: TextStyle(
                                // fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
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
