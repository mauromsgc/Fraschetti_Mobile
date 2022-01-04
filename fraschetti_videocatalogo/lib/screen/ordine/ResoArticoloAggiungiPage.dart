import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/models/resoModel.dart';
import 'package:fraschetti_videocatalogo/models/resoRigaModel.dart';
import 'package:fraschetti_videocatalogo/models/reso_causele_model.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/ClientiLista.dart';
import 'package:fraschetti_videocatalogo/utils/Utility.dart';
import 'package:fraschetti_videocatalogo/utils/ValidationBlock.dart';
import 'package:get_it/get_it.dart';

class ResoArticoloAggiungiPageArgs {
  int id;

  ResoArticoloAggiungiPageArgs({
    this.id = 0,
  });
}

class ResoArticoloAggiungiPage extends StatefulWidget {
  ResoArticoloAggiungiPage({Key? key}) : super(key: key);
  static const String routeName = "reso_articolo_aggiungi";
  final String pagina_titolo = "Reso articolo aggiungi";

  @override
  _ResoArticoloAggiungiPageState createState() =>
      _ResoArticoloAggiungiPageState();
}

class _ResoArticoloAggiungiPageState extends State<ResoArticoloAggiungiPage> {
  List<ResoCausaleModel> _reso_causale_lista = [];

  ResoArticoloAggiungiPageArgs argomenti = ResoArticoloAggiungiPageArgs();
  ResoRigaModel reso_riga_scheda = ResoRigaModel();
  String _causale_default = "";

  final TextEditingController fattura_numero_con = TextEditingController();
  final TextEditingController fattura_data_con = TextEditingController();
  final TextEditingController codice_con = TextEditingController();
  final TextEditingController um_con = TextEditingController();
  final TextEditingController quantita_con = TextEditingController();
  final TextEditingController descrizione_con = TextEditingController();
  final TextEditingController note_con = TextEditingController();

  String causale_errore = "";
  String quantita_errore = "";
  String errore_generico = "";

  final _causale_focus_node = FocusNode();
  final _codice_focus_node = FocusNode();

  String _reso_causale_selezionata = "Causale 1";

  @override
  void initState() {
    super.initState();

    _reso_causale_lista_carica();
    setState(() {
      _causale_default = "0";
    });

    _causale_focus_node.addListener(() {
      if (!_causale_focus_node.hasFocus) {
        // _causale_seleziona(context);
      }
    });

    _codice_focus_node.addListener(() {
      if (!_codice_focus_node.hasFocus) {
        // _codice_cerca(context);
      }
    });

    print("_ResoArticoloAggiungiPageState initState");
  }

  @override
  void dispose() {
    _causale_focus_node.dispose();
    _codice_focus_node.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      argomenti = ModalRoute.of(context)?.settings.arguments
          as ResoArticoloAggiungiPageArgs;
    }

    await _cliente_reso_seleziona();
    await _reso_riga_carica();

    super.didChangeDependencies();
  }

  Future<void> _reso_causale_lista_carica() async {
    _reso_causale_lista = await ResoCausaleModel.reso_causali_lista();
    setState(() {});
  }

  Future<void> _cliente_reso_seleziona() async {
    print("_cliente_reso_seleziona inizio");

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
          pagina_chiamante_route: ResoArticoloAggiungiPage.routeName,
        ),
      );
    } else {
      ResoModel reso_scheda = await ResoModel.reso_cliente_seleziona(
        cliente_id: GetIt.instance<SessioneModel>().clienti_id_selezionato,
      );

      print("reso_scheda.id ${reso_scheda.id}");
      print(
          "GetIt.instance<SessioneModel>().ordine_id_corrente ${GetIt.instance<SessioneModel>().ordine_id_corrente}");
    }

    print("_cliente_reso_seleziona fine");
  }

  Future<void> _reso_riga_carica() async {
    print("_reso_riga_carica inizio");
    // cerco il codice per vedere se già presente
    // con id ordine
    // creo una nuova se non presente
    // modifico la riga esistente se già presente il codice

    if (argomenti.id != "") {
      reso_riga_scheda = await ResoRigaModel.resi_righe_cerca_singolo(
        id: argomenti.id,
        resi_id: GetIt.instance<SessioneModel>().reso_id_corrente,
      );
    }

    if ((reso_riga_scheda.id == 0) | (reso_riga_scheda.id == null)) {
      reso_riga_scheda = await ResoRigaModel.nuovo_reso_riga();
    }

    print("reso_riga_scheda ${reso_riga_scheda.toMap_record().toString()}");
    print("_reso_riga_carica setState inizio");
    setState(() {
      _causale_default = reso_riga_scheda.causale_reso.toString();
      fattura_numero_con.text = reso_riga_scheda.fattura_numero;
      fattura_data_con.text = reso_riga_scheda.fattura_data;
      codice_con.text = reso_riga_scheda.codice;
      um_con.text = reso_riga_scheda.um;
      quantita_con.text = reso_riga_scheda.quantita.toQuantita();
      descrizione_con.text = reso_riga_scheda.descrizione;
      note_con.text = reso_riga_scheda.note;
    });
    print("_reso_riga_carica setState fine");

    print("_reso_riga_carica fine");
  }

  void _form_salva(BuildContext context) async {
    setState(() {
      causale_errore = "";
      quantita_errore = "";
      errore_generico = "";
    });

    final valid = validationBlock((when) {
      when((_causale_default == "0"),
          () => setState(() => causale_errore = "Selezionare una causale"));
      when(
          (quantita_con.text.toDouble() <= 0),
          () => setState(
              () => errore_generico = "La quantità deve essere maggiore di 0"));
    });

    if (valid) {
      // reso_riga_scheda.causale_reso viene assegnata dal medototo _causale_seleziona(context)
      reso_riga_scheda.fattura_numero = fattura_numero_con.text;
      reso_riga_scheda.fattura_data = fattura_data_con.text;
      reso_riga_scheda.codice = codice_con.text;
      reso_riga_scheda.um = um_con.text;
      reso_riga_scheda.quantita = quantita_con.text.toDoubleSql();
      reso_riga_scheda.descrizione = descrizione_con.text;
      reso_riga_scheda.note = note_con.text;

      int record_id = await reso_riga_scheda.record_salva();
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

  void _causale_seleziona(BuildContext context, {int codice = 0}) {
    print("causale selezionata codice ${codice}");
    reso_riga_scheda.causale_reso = codice;

    // String _errore_testo = "";
    // double _quantita = 0;
    //
    //
    // _quantita = quantita_con.text.toDoubleSql();
    // print("_quantita ${_quantita}");
    // print("reso_riga_scheda.quantita ${reso_riga_scheda.quantita}");
    // if (reso_riga_scheda.quantita != _quantita) {
    //   print("_quantita ${_quantita}");
    //   // _quantita = _quantita.toInt() as double;
    //   // print("_quantita ${_quantita}");
    //
    //   print("1");
    //   if (_quantita <= 0) {
    //     print("2");
    //     _errore_testo = "La quantità deve essere maggiore di 0";
    //     _quantita_focus_node.requestFocus();
    //   } else {
    //     print("3");
    //     if (reso_riga_scheda.codice_scheda.um == "XC") {
    //       print("4");
    //       _quantita = _quantita.toStringAsFixed(0).toDoubleSql();
    //     }
    //     if (reso_riga_scheda.codice_scheda.apribile != 1) {
    //       print("5");
    //       _quantita = (_quantita * reso_riga_scheda.codice_scheda.pezzi);
    //     }
    //   }
    //
    //   setState(() {
    //     quantita_con.text = _quantita.toQuantita();
    //     errore_generico = _errore_testo;
    //   });
    //   reso_riga_scheda.quantita = _quantita;
    // }
  }

  void _codice_cerca(BuildContext context) {
    // double _sconto = 0;
    // double _prezzo = 0;
    //
    // _sconto =
    //     sconto_con.text.toDoubleSql();
    // print("_sconto ${_sconto}");
    // if ((_sconto != 0) & (_sconto != null)) {
    //   print("reso_riga_scheda.prezzo_ordine ${reso_riga_scheda.prezzo_ordine}");
    //   _prezzo = (reso_riga_scheda.prezzo_ordine * (100 - _sconto) /100  );
    //   print("_prezzo ${_prezzo}");
    //
    //   setState(() {
    //     sconto_con.text = _sconto.toQuantita();
    //     prezzo_con.text = _prezzo.toImporti();
    //   });
    //   reso_riga_scheda.prezzo = _prezzo;
    // }
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
                    padding: EdgeInsets.all(5),
                    child: DropdownButtonFormField(
                      hint: Text('Seleziona la causale'),
                      // Not necessary for Option 1
                      // value: _causale_default,
                      // value: reso_riga_scheda.codice.toString(),
                      onChanged: (newValue) {
                        setState(() {
                          print("newValue ${newValue.toString()}");
                          _causale_default = newValue.toString();
                          _causale_seleziona(context,
                              codice: newValue.toString().toInt());
                        });
                      },
                      items: _reso_causale_lista.map((elemento) {
                        return DropdownMenuItem(
                          value: elemento.codice.toString(),
                          child: new Text(elemento.descrizione),
                          // onTap: () {
                          //   _causale_seleziona(context, codice: elemento.codice);
                          // },
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        labelText: "Causale reso",
                        errorText:
                            (causale_errore == "") ? null : causale_errore,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        // fattura numero
                        width: 200,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: fattura_numero_con,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.continueAction,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "Fattura numero",
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        // fattura data
                        width: 150,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: fattura_data_con,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.continueAction,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "Fattura data",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        // confezione
                        child: Text("Formato data GGMMAA"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        // articolo codice
                        width: 120,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: codice_con,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.continueAction,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "Codice",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        // unità di misura
                        width: 60,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: um_con,
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
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        // Quantità
                        width: 120,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: quantita_con,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "Quantità",
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    // articolo descrizione
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      controller: descrizione_con,
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
                  Container(
                    // reso note
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      controller: note_con,
                      onEditingComplete: () {
                        _form_salva(context);
                      },
                      minLines: 6,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      // keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        // contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        labelText: "Note reso",
                      ),
                    ),
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
                        child: Container(
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
}
