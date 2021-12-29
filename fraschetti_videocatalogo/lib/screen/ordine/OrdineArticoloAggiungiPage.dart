import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/models/ordineModel.dart';
import 'package:fraschetti_videocatalogo/models/ordineRigaModel.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/ClientiLista.dart';
import 'package:get_it/get_it.dart';

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

    print("_ordine_riga_carica setState inizio");
    setState(() {});
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
                      // readOnly: true,
                      enabled: false,
                      initialValue: GetIt.instance<SessioneModel>()
                          .cliente_Nominativo_selezionato,
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
                  Container(
                    // articolo descrizione
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      // readOnly: true,
                      enabled: false,
                      initialValue:
                          ordine_riga_scheda.codice_scheda.catalogo_nome,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        labelText: "Articolo",
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        // articolo codice
                        width: 100,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          // readOnly: true,
                          enabled: false,
                          initialValue: ordine_riga_scheda.codice,
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
                              // readOnly: true,
                              enabled: false,
                              initialValue:
                                  ordine_riga_scheda.codice_scheda.descrizione,
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
                          // readOnly: true,
                          enabled: false,
                          initialValue:
                              (ordine_riga_scheda.codice_scheda.apribile ==
                                      true)
                                  ? "*"
                                  : "",
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
                          // readOnly: true,
                          enabled: false,
                          initialValue: ordine_riga_scheda.codice_scheda.um,
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
                      Container(
                        // confezione
                        width: 80,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          // readOnly: true,
                          enabled: false,
                          initialValue: ordine_riga_scheda.codice_scheda.pezzi
                              .toStringAsFixed(2),
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
                          // readOnly: true,
                          enabled: false,
                          initialValue: ordine_riga_scheda.codice_scheda.prezzo
                              .toStringAsFixed(2),
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
                          initialValue:
                              ordine_riga_scheda.quantita.toStringAsFixed(2),
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
                      if (ordine_riga_scheda.quantita != 0)
                        Container(
                          // quantità già presente
                          width: 100,
                          padding: EdgeInsets.all(5),
                          child: TextFormField(
                            // readOnly: true,
                            enabled: false,
                            initialValue:
                                ordine_riga_scheda.quantita.toStringAsFixed(2),
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
                          initialValue: "",
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
                          initialValue: ordine_riga_scheda.codice_scheda.prezzo
                              .toStringAsFixed(2),
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
                      if (ordine_riga_scheda.prezzo != 0)
                        Container(
                          // confezione
                          width: 120,
                          padding: EdgeInsets.all(5),
                          child: TextFormField(
                            // readOnly: true,

                            enabled: false,
                            initialValue:
                                ordine_riga_scheda.prezzo.toStringAsFixed(2),
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
}
