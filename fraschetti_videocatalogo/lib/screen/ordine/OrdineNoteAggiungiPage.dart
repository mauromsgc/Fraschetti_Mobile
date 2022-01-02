import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/models/ordineModel.dart';
import 'package:fraschetti_videocatalogo/utils/ValidationBlock.dart';
import 'package:get_it/get_it.dart';

import 'ClientiLista.dart';
import 'OrdineArticoloAggiungiPage.dart';

class OrdineNoteAggiungiPage extends StatefulWidget {
  OrdineNoteAggiungiPage({Key? key}) : super(key: key);
  static const String routeName = "ordini_note_aggiungi";
  final String pagina_titolo = "Ordine note";

  @override
  _OrdineNoteAggiungiPageState createState() => _OrdineNoteAggiungiPageState();
}

class _OrdineNoteAggiungiPageState extends State<OrdineNoteAggiungiPage> {
  OrdineModel ordine_scheda = OrdineModel();

  final TextEditingController note_con = TextEditingController();

  String errore_generico = "";

  @override
  void initState() {
    super.initState();

    print("_OrdineNoteAggiungiPageState initState");
  }

  @override
  void didChangeDependencies() async {
    await _cliente_ordine_seleziona();
    await _ordine_carica_dati();

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
      Navigator.pushNamed(
        context,
        ClienteLista.routeName,
        arguments: ClientiListaPageArgs(
          pagina_chiamante_route: OrdineNoteAggiungiPage.routeName,
        ),
      );
    } else {
      ordine_scheda = await OrdineModel.ordine_cliente_seleziona(
        cliente_id: GetIt.instance<SessioneModel>().clienti_id_selezionato,
      );

      print("ordine_scheda.id ${ordine_scheda.id}");
      print(
          "GetIt.instance<SessioneModel>().ordine_id_corrente ${GetIt.instance<SessioneModel>().ordine_id_corrente}");
    }

    print("ordine_scheda.note ${ordine_scheda.note}");
    print("_cliente_ordine_seleziona fine");
  }

  Future<void> _ordine_carica_dati() async {
    print("ordine_scheda.note ${ordine_scheda.note}");
    setState(() {
      note_con.text = ordine_scheda.note;
    });
  }

  void _form_salva(BuildContext context) async {
    setState(() {
      errore_generico = "";
    });

    bool valid = true;
    // non faccio controlli altrimenti non posso svuotare le note
    // final valid = validationBlock((when) {
    //   when(
    //       (note_con.text = ""),
    //           () => setState(
    //               () => errore_generico = "Nessuna nota inserita"));
    // });

    if (valid) {
      ordine_scheda.note = note_con.text;
      int record_id = await ordine_scheda.record_salva();
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
    // vadio al campo successivo
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
                        labelText: "Note ordine",
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
                        child: Container(),
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
