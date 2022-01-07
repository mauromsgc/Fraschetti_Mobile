import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/models/ordineModel.dart';
import 'package:fraschetti_videocatalogo/models/ordineRigaModel.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/ClientiLista.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';
import 'package:fraschetti_videocatalogo/utils/Utility.dart';
import 'package:fraschetti_videocatalogo/utils/ValidationBlock.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class OrdineArticoloAggiungiPageArgs {
  int id;
  String codice;

  OrdineArticoloAggiungiPageArgs({
    this.id = 0,
    this.codice = "",
  });
}

class OrdineArticoloAggiungiPage extends StatefulWidget {
  OrdineArticoloAggiungiPage({Key? key}) : super(key: key);
  static const String routeName = "ordine_articolo_aggiungi";
  final String pagina_titolo = "Ordine articolo aggiungi";

  @override
  _OrdineArticoloAggiungiPageState createState() =>
      _OrdineArticoloAggiungiPageState();
}

class _OrdineArticoloAggiungiPageState
    extends State<OrdineArticoloAggiungiPage> {

  OrdineArticoloAggiungiPageArgs argomenti = OrdineArticoloAggiungiPageArgs();
  OrdineRigaModel ordine_riga_scheda = OrdineRigaModel();

  final TextEditingController cliente_nominatico_con = TextEditingController();
  final TextEditingController articolo_con = TextEditingController();
  final TextEditingController codice_con = TextEditingController();
  final TextEditingController codice_descrizione_con = TextEditingController();
  final TextEditingController apribile_con = TextEditingController();
  final TextEditingController unita_misura_con = TextEditingController();
  final TextEditingController quantita_master_con = TextEditingController();
  final TextEditingController pezzi_con = TextEditingController();
  final TextEditingController prezzo_base_con = TextEditingController();
  final TextEditingController quantita_con = TextEditingController();
  final TextEditingController quantita_presente_con = TextEditingController();
  final TextEditingController sconto_con = TextEditingController();
  final TextEditingController prezzo_con = TextEditingController();
  final TextEditingController prezzo_presente_con = TextEditingController();

  String errore_generico = "";
  String quantita_errore = "";

  final _quantita_focus_node = FocusNode();
  final _sconto_focus_node = FocusNode();
  final _prezzo_focus_node = FocusNode();

  @override
  void initState() {
    super.initState();

    _quantita_focus_node.addListener(() {
      if (!_quantita_focus_node.hasFocus) {
        _quantita_verifica(context);
      }
    });

    _sconto_focus_node.addListener(() {
      if (!_sconto_focus_node.hasFocus) {
        _sconto_calcola(context);
      }
    });

    _prezzo_focus_node.addListener(() {
      if (!_prezzo_focus_node.hasFocus) {
        _prezzo_controlla(context);
      }
    });

    print("_OrdineArticoloAggiungiPageState initState");
  }

  @override
  void dispose() {
    _quantita_focus_node.dispose();
    _sconto_focus_node.dispose();
    _prezzo_focus_node.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      argomenti = ModalRoute.of(context)?.settings.arguments
          as OrdineArticoloAggiungiPageArgs;
    }

    await _cliente_ordine_seleziona();
    await _ordine_riga_carica();

    super.didChangeDependencies();
  }

  Future<void> _cliente_ordine_seleziona() async {
    print("_cliente_ordine_seleziona inizio");

    // controlla se è selezionato un cliente e un ordine
    // se non c'è un cliente selezionato
    // apre la page della selezione del cliente
    // se non c'è un ordine id selezionato crea l'ordine
    // e lo imoposta

    if (GetIt.instance<SessioneModel>().clienti_id_selezionato == 0) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {

        Navigator.pushNamed(
        context,
        ClienteLista.routeName,
        arguments: ClientiListaPageArgs(
          pagina_chiamante_route: OrdineArticoloAggiungiPage.routeName,
        ),
      );

      });

    } else {
      OrdineModel ordine_scheda = await OrdineModel.ordine_cliente_seleziona(
        cliente_id: GetIt.instance<SessioneModel>().clienti_id_selezionato,
      );

      print("ordine_scheda.id ${ordine_scheda.id}");
      print(
          "GetIt.instance<SessioneModel>().ordine_id_corrente ${GetIt.instance<SessioneModel>().ordine_id_corrente}");
    }

    print("_cliente_ordine_seleziona fine");
  }

  Future<void> _ordine_riga_carica() async {
    print("_ordine_riga_carica inizio");
    // cerco il codice per vedere se già presente
    // con id ordine
    // creo una nuova se non presente
    // modifico la riga esistente se già presente il codice

    if (argomenti.codice != "") {
      ordine_riga_scheda = await OrdineRigaModel.ordini_righe_cerca_singolo(
        codice: argomenti.codice,
        ordini_id: GetIt.instance<SessioneModel>().ordine_id_corrente,
      );
    }

    if ((ordine_riga_scheda.id == 0) | (ordine_riga_scheda.id == null)) {
      ordine_riga_scheda = await OrdineRigaModel.nuovo_da_codice(
        codice: argomenti.codice,
      );
    }

    print("ordine_riga_scheda ${ordine_riga_scheda.toMap_record().toString()}");
    print(
        "ordine_riga_scheda.codice_scheda ${ordine_riga_scheda.codice_scheda.toMap().toString()}");
    print("_ordine_riga_carica setState inizio");
    setState(() {
      cliente_nominatico_con.text =
          GetIt.instance<SessioneModel>().cliente_Nominativo_selezionato;
      articolo_con.text = ordine_riga_scheda.codice_scheda.catalogo_nome;
      codice_con.text = ordine_riga_scheda.codice;
      codice_descrizione_con.text =
          ordine_riga_scheda.codice_scheda.descrizione;
      apribile_con.text =
          (ordine_riga_scheda.codice_scheda.apribile == 1) ? "*" : " ";
      unita_misura_con.text = ordine_riga_scheda.um;
      quantita_master_con.text =
          (ordine_riga_scheda.codice_scheda.quantita_massima != 0)
              ? ordine_riga_scheda.codice_scheda.quantita_massima.toQuantita()
              : "";
      pezzi_con.text = ordine_riga_scheda.codice_scheda.pezzi.toQuantita();
      prezzo_base_con.text =
          ordine_riga_scheda.codice_scheda.prezzo.toImporti();
      quantita_presente_con.text = (ordine_riga_scheda.id != 0)
          ? ordine_riga_scheda.quantita.toQuantita()
          : "";
      sconto_con.text = "0";
      prezzo_presente_con.text = (ordine_riga_scheda.id != 0)
          ? ordine_riga_scheda.prezzo.toImporti()
          : "";

      // quando modificano una riga si mostrano quantità e prezzo iniziale
      ordine_riga_scheda.quantita = ordine_riga_scheda.codice_scheda.pezzi;
      ordine_riga_scheda.prezzo = ordine_riga_scheda.codice_scheda.prezzo;

      quantita_con.text = ordine_riga_scheda.codice_scheda.pezzi.toQuantita();
      prezzo_con.text = ordine_riga_scheda.codice_scheda.prezzo.toImporti();

      if(ordine_riga_scheda.codice_scheda.sospeso == 1){
        errore_generico = "Codice SOSPESO non ordinabile";
      }

    });
    print("_ordine_riga_carica setState fine");

    print("_ordine_riga_carica fine");
  }

  void _form_salva(BuildContext context) async {
    setState(() {
      errore_generico = "";
      quantita_errore = "";
    });

    final valid = validationBlock((when) {
      when(
          (ordine_riga_scheda.codice_scheda.sospeso == 1),
              () => setState(
                  () => errore_generico = "Codice SOSPESO non ordinabile\n"));
      when(
          (quantita_con.text.toDouble() <= 0),
          () => setState(
              () => errore_generico = "La quantità deve essere maggiore di 0\n"));
    });

    if (valid) {
      ordine_riga_scheda.quantita = quantita_con.text.toDoubleSql();
      ordine_riga_scheda.prezzo = prezzo_con.text.toDoubleSql();
      int record_id = await ordine_riga_scheda.record_salva();
      print("record_id ${record_id}");

      if (record_id > 0) {
        Navigator.of(context).pop();
      } else {
        setState(() {
          errore_generico = "Errore durante il salvataggio, annulla o riprova";
        });
      }
    }
  }

  void _form_successivo(BuildContext context) async {
    FocusScope.of(context).requestFocus();
  }

  void _form_annulla(BuildContext context) async {
    Navigator.of(context).pop();
  }

  void _quantita_verifica(BuildContext context) {
    String _errore_testo = "";
    double _quantita = 0;


    _quantita = quantita_con.text.toDoubleSql();
    print("_quantita ${_quantita}");
    print("ordine_riga_scheda.quantita ${ordine_riga_scheda.quantita}");
    if (ordine_riga_scheda.quantita != _quantita) {
      print("_quantita ${_quantita}");
      // _quantita = _quantita.toInt() as double;
      // print("_quantita ${_quantita}");

      print("1");
      if (_quantita <= 0) {
        print("2");
        _errore_testo = "La quantità deve essere maggiore di 0";
        _quantita_focus_node.requestFocus();
      } else {
        print("3");
        if (ordine_riga_scheda.codice_scheda.um == "XC") {
          print("4");
          _quantita = _quantita.toStringAsFixed(0).toDoubleSql();
        }
        if (ordine_riga_scheda.codice_scheda.apribile != 1) {
          print("5");
          _quantita = (_quantita * ordine_riga_scheda.codice_scheda.pezzi);
        }
      }

      setState(() {
        quantita_con.text = _quantita.toQuantita();
        errore_generico = _errore_testo;
      });
      ordine_riga_scheda.quantita = _quantita;
    }

    // If (vrQuantita<=0)
    // ALERT("La quantità deve essere maggiore di zero")
    // vrQuantita:=vroldqua
    // GOTO OBJECT(vrQuantita)
    // Else
    // If (vtUm#"XC")
    // vrQuantita:=Round(vrQuantita;0)
    // End if
    // If (vrApribile#0)
    // vrQuantita:=vrQuantita*vrApribile
    // End if
    // End if
  }

  void _sconto_calcola(BuildContext context) {
    double _sconto = 0;
    double _prezzo = 0;

    _sconto =
        sconto_con.text.toDoubleSql();
    print("_sconto ${_sconto}");
    if ((_sconto != 0) & (_sconto != null)) {
      print("ordine_riga_scheda.prezzo_ordine ${ordine_riga_scheda.prezzo_ordine}");
      _prezzo = (ordine_riga_scheda.prezzo_ordine * (100 - _sconto) /100  );
      print("_prezzo ${_prezzo}");

      setState(() {
        sconto_con.text = _sconto.toQuantita();
        prezzo_con.text = _prezzo.toImporti();
      });
      ordine_riga_scheda.prezzo = _prezzo;
    }

    // vrPrezzo:=Round(vrPrezzoBase*(100-vrSconto)/100;2)
  }

  void _prezzo_controlla(BuildContext context) {
    int? prezzo_intero = 0;
    double _sconto = 0;
    double _prezzo = 0;

    print("_prezzo ${_prezzo}");
    print(
        "double.tryParse _prezzo ${prezzo_con.text.replaceAll(".", "").replaceAll(",", "")}");

    prezzo_intero =
        int.tryParse(prezzo_con.text.replaceAll(".", "").replaceAll(",", ""));
    print("prezzo_intero ${prezzo_intero}");

    if (prezzo_intero == null) {
      prezzo_intero = 0;
    }
    _prezzo = prezzo_intero / 100;
    print("_prezzo ${_prezzo}");
    _sconto = (100-(100 * (_prezzo  / ordine_riga_scheda.prezzo_ordine)));
    print("_sconto ${_sconto}");

    setState(() {
      sconto_con.text = _sconto.toQuantita();
      prezzo_con.text = _prezzo.toImporti();
    });
    ordine_riga_scheda.prezzo = _prezzo;

    // vrPrezzo:=vrPrezzo/100
    // vrSconto:=100-Round(100*vrPrezzo/vrPrezzoBase;2)

  }

  @override
  Widget build(BuildContext context) {
    print("OrdineArticoloAggiungi Widget build");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.pagina_titolo),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // cliente nominativo
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      controller: cliente_nominatico_con,
                      // readOnly: true,
                      enabled: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        labelText: "Cliente",
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      if (ordine_riga_scheda.codice_scheda.immagine_preview !=
                          "")
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Container(
                              // width: 60,
                              // height: 40,
                              decoration: MyBoxDecoration().MyBox(),
                              child: ListaImmagineWidget(
                                  immagine_base64: ordine_riga_scheda
                                      .codice_scheda.immagine_preview),
                            ),
                          ),
                        ),
                      Expanded(
                        child: Container(
                          // articolo descrizione
                          padding: EdgeInsets.all(5),
                          child: TextFormField(
                            controller: articolo_con,
                            // readOnly: true,
                            enabled: false,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                              border: OutlineInputBorder(),
                              labelText: "Articolo ",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        // articolo codice
                        width: 100,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: codice_con,
                          // readOnly: true,
                          enabled: false,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "Codice",
                          ),
                        ),
                      ),
                      if (ordine_riga_scheda.codice_scheda.descrizione.trim() !=
                          "")
                        Expanded(
                          child: Container(
                            // articolo codice descrizione
                            padding: EdgeInsets.all(5),
                            child: TextFormField(
                              controller: codice_descrizione_con,
                              // readOnly: true,
                              enabled: false,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                contentPadding:
                                    EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                                border: OutlineInputBorder(),
                                labelText: "Descrizione",
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        // apribile
                        width: 45,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: apribile_con,
                          // readOnly: true,
                          enabled: false,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "Ap.",
                          ),
                        ),
                      ),
                      Container(
                        // unità di misura
                        width: 55,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: unita_misura_con,
                          // readOnly: true,
                          enabled: false,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "U.M.",
                          ),
                        ),
                      ),
                      if (quantita_master_con.text != "")
                        Container(
                          // confezione
                          width: 70,
                          padding: EdgeInsets.all(5),
                          child: TextFormField(
                            controller: quantita_master_con,
                            // readOnly: true,
                            enabled: false,
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                              border: OutlineInputBorder(),
                              labelText: "Master",
                            ),
                          ),
                        ),
                      Container(
                        // confezione
                        width: 60,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: pezzi_con,
                          // readOnly: true,
                          enabled: false,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "Pezzi",
                          ),
                        ),
                      ),
                      Container(
                        // prezzo base
                        width: 110,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: prezzo_base_con,
                          // readOnly: true,
                          enabled: false,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "Prezzo base",
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        // Quantità
                        width: 100,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: quantita_con,
                          onTap: () {
                            quantita_con.selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: quantita_con.text.length);
                          },
                          focusNode: _quantita_focus_node,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [FilteringTextInputFormatter(RegExp(r"^\d*\,?\d{0,2}"), allow: true)],
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "Quantità",
                            // errorText: (quantita_errore == "") ? null : quantita_errore,
                          ),
                        ),
                      ),
                      if (quantita_presente_con.text != "")
                        Container(
                          // quantità già presente
                          width: 100,
                          padding: EdgeInsets.all(5),
                          child: TextFormField(
                            controller: quantita_presente_con,
                            // readOnly: true,
                            enabled: false,
                            style: TextStyle(
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.red.shade100,
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              labelText: "Qt. presente",
                              labelStyle: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        // sconto
                        width: 80,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: sconto_con,
                          onTap: () {
                            sconto_con.selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: sconto_con.text.length);
                          },

                          focusNode: _sconto_focus_node,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.right,
                          inputFormatters: [FilteringTextInputFormatter(RegExp(r"^\d*\,?\d{0,2}"), allow: true)],
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "Sconto",
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        // prezzo
                        width: 120,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: prezzo_con,
                          onTap: () {
                            prezzo_con.selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: prezzo_con.text.length);
                          },
                          focusNode: _prezzo_focus_node,
                          onEditingComplete: () {
                            _form_salva(context);
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          textAlign: TextAlign.right,
                          // inputFormatters: [FilteringTextInputFormatter(RegExp(r"^\d*\,?\d{0,2}"), allow: true)],
                          inputFormatters: [FilteringTextInputFormatter(RegExp(r"^\d*"), allow: true)],
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "Prezzo",
                          ),
                        ),
                      ),
                      if (prezzo_presente_con.text != "")
                        Container(
                          // confezione
                          width: 120,
                          padding: EdgeInsets.all(5),
                          child: TextFormField(
                            controller: prezzo_presente_con,
                            // readOnly: true,
                            enabled: false,
                            style: TextStyle(
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.red.shade100,
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              labelText: "Prezzo pres.",
                              labelStyle: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (errore_generico != "")
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        errore_generico,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(elevation: 2),
                            onPressed: () => _form_annulla(context),
                            child: Text('Annulla'),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          // child: ElevatedButton(
                          //   style: ElevatedButton.styleFrom(elevation: 2),
                          //   onPressed: () => _form_successivo(context),
                          //   child: Text('Successivo'),
                          // ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(elevation: 2),
                            onPressed: () => _form_salva(context),
                            child: Text('Salva'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
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
