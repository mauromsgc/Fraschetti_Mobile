import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/models/ordineModel.dart';
import 'package:fraschetti_videocatalogo/models/ordineRigaModel.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/ClientiLista.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';
import 'package:fraschetti_videocatalogo/utils/Utility.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class OrdineArticoloAggiungiPageArgs {
  int id;
  int codice_id;

  OrdineArticoloAggiungiPageArgs({
    this.id = 0,
    this.codice_id = 0,
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

  @override
  void initState() {
    super.initState();
    print("Inizializza");
    // _inizializza();
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

  void _inizializza() async {
    await _cliente_ordine_seleziona();
  }

  Future<void> _cliente_ordine_seleziona() async {
    print("_cliente_ordine_seleziona inizio");

    // controlla se è selezionato un cliente e un ordine
    // se non c'è un cliente selezionato
    // apre la page della selezione del cliente
    // se non c'è un ordine id selezionato crea l'ordine
    // e lo imoposta

    if (GetIt.instance<SessioneModel>().clienti_id_selezionato == 0) {
      Navigator.pushNamed(
        context,
        ClienteLista.routeName,
        arguments: ClientiListaPageArgs(
          pagina_chiamante_route: OrdineArticoloAggiungiPage.routeName,
        ),
      );
    } else {
      OrdineModel ordine_scheda = await OrdineModel.ordine_cliente_seleziona(
        cliente_id: GetIt.instance<SessioneModel>().clienti_id_selezionato,
      );
      print("ordine_scheda.id ${ordine_scheda.id}");

      if (ordine_scheda.id != 0) {
        GetIt.instance<SessioneModel>().ordine_id_imposta(
          id: ordine_scheda.id,
        );
      }
      print("ordine_scheda.id ${ordine_scheda.id}");
    }

    print("_cliente_ordine_seleziona fine");
  }

  Future<void> _ordine_riga_carica() async {
    print("_ordine_riga_carica inizio");
    // se argomenti.id != 0 carico la riga del record
    // se argomenti.id == 0 e argomenti.codice != "" cerco il codice e creo un nuovo oggetto

    if (argomenti.id != 0) {
      ordine_riga_scheda = await OrdineRigaModel.ordini_righe_cerca_singolo(
        id: argomenti.id,
      );
    } else {
      if (argomenti.codice_id != 0) {
        ordine_riga_scheda = await OrdineRigaModel.nuovo_da_codice(
          codice_id: argomenti.codice_id,
        );
      }
    }
    NumberFormat numberFormat = NumberFormat.decimalPattern('it');
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
          (ordine_riga_scheda.codice_scheda.apribile == 1) ? "*" : "";
      unita_misura_con.text = ordine_riga_scheda.um;
      quantita_master_con.text = (ordine_riga_scheda.codice_scheda.quantita_massima != 0) ? ordine_riga_scheda.codice_scheda.quantita_massima.toQuantita() : "";
      pezzi_con.text = ordine_riga_scheda.codice_scheda.pezzi.toQuantita();
      prezzo_base_con.text = ordine_riga_scheda.codice_scheda.prezzo.toImporti();
      quantita_con.text = ordine_riga_scheda.quantita.toQuantita();
      quantita_presente_con.text = (ordine_riga_scheda.id != 0)
          ? ordine_riga_scheda.quantita.toQuantita()
          : "";
      sconto_con.text = "0";
      prezzo_con.text = ordine_riga_scheda.codice_scheda.prezzo.toImporti();
      prezzo_presente_con.text = (ordine_riga_scheda.id != 0)
          ? ordine_riga_scheda.prezzo.toImporti()
          : "";
    });
    print("_ordine_riga_carica setState fine");

    print("_ordine_riga_carica fine");
  }

  void _form_salva(BuildContext context) async {
    // final username = usernameController.text.trim();
    // final password = passwordController.text.trim();
    // final password_verifica = password_verificaController.text.trim();
    // final codice_attivazione = codice_attivazioneController.text.trim();
    //
    // setState(() {
    //   usernameError = "";
    //   passwordError = "";
    //   password_verificaError = "";
    //   codice_attivazioneError = "";
    // });
    //
    // final valid = validationBlock((when) {
    //   when(username.isEmpty,
    //           () => setState(() => usernameError = "Campo obbligatorio"));
    //   when(password.isEmpty,
    //           () => setState(() => passwordError = "Campo obbligatorio"));
    //   when(password_verifica.isEmpty,
    //           () => setState(() => password_verificaError = "Campo obbligatorio"));
    //   when(((password.isNotEmpty & password_verifica.isNotEmpty) &(password != password_verifica)),
    //           () => setState(() => password_verificaError = "Le password non coincidono"));
    //   when(codice_attivazione.isEmpty,
    //           () => setState(() => codice_attivazioneError = "Campo obbligatorio"));
    // });
    //
    // if (valid) {
    // Navigator.of(context).pop();
    // } else {
    //   print("Registrazione fallita");
    // }

    // t2 = await OrdineRigaModel.ordini_righe_cerca_singolo(id: record_id);
    ordine_riga_scheda.quantita = double.parse(quantita_con.text);
    ordine_riga_scheda.prezzo = double.parse(prezzo_con.text);
    int record_id = await ordine_riga_scheda.record_salva();


    Navigator.of(context).pop();
  }

  void _form_successivo(BuildContext context) async {
    // vado al campo successivo
  }

  void _form_annulla(BuildContext context) async {
    Navigator.of(context).pop();
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
                      if(ordine_riga_scheda.codice_scheda.immagine_preview != "")
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
                                immagine_base64: ordine_riga_scheda.codice_scheda.immagine_preview),
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
                        width: 60,
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
                            labelText: "Apribile",
                          ),
                        ),
                      ),
                      Container(
                        // unità di misura
                        width: 70,
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
                      if(quantita_master_con.text != "")
                      Container(
                        // confezione
                        width: 90,
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
                        width: 90,
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
                            labelText: "Confezione",
                          ),
                        ),
                      ),
                      Container(
                        // prezzo base
                        width: 120,
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
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "Quantità",
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
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.right,
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
                          onEditingComplete: () {
                            _form_salva(context);
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          textAlign: TextAlign.right,
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
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(elevation: 2),
                            onPressed: () => _form_successivo(context),
                            child: Text('Successivo'),
                          ),
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
      return Image.asset("assets/immagini/splash_screen.png");
    }
  }
}
