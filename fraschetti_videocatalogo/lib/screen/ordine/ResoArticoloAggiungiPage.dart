import 'package:flutter/material.dart';

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
  List<String> _reso_causale_lista = ['Causale 1', 'Causale 2', 'Causale 3', 'Causale 4'];
  String _reso_causale_selezionata = "Causale 1";

  void savalOnSubmit(BuildContext context) async {
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
    //       Navigator.of(context).pop();
    // } else {
    //   print("Registrazione fallita");
    // }

    Navigator.of(context).pop();
  }

  void successivoOnSubmit(BuildContext context) async {
    // vadio al campo successivo
  }

  void annullaOnSubmit(BuildContext context) async {
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
                    padding: EdgeInsets.all(5),
                    child: DropdownButtonFormField(
                      hint: Text('Seleziona la causale'), // Not necessary for Option 1
                      value: _reso_causale_selezionata,
                      onChanged: (newValue) {
                        setState(() {
                          // _reso_causale_selezionata = newValue;
                        });
                      },
                      items: _reso_causale_lista.map((elemento) {
                        return DropdownMenuItem(
                          child: new Text(elemento),
                          value: elemento,
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        labelText: "Causale reso",
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        // fattura numero
                        width: 200 ,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          // initialValue: "",
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
                          // readOnly: true,
                          enabled: false,
                          initialValue: "PZ",
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
                      // readOnly: true,
                      enabled: false,
                      initialValue: "Catalogo Catalogo Catalogo",
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
                  Container(
                    // articolo codice descrizione
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      // readOnly: true,
                      enabled: false,
                      initialValue: "Codice descrizione Codice descrizione",
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        labelText: "Descrizione codice",
                      ),
                    ),
                  ),
                  Container(
                    // reso note
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      onEditingComplete: () {
                        savalOnSubmit(context);
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
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(elevation: 2),
                            onPressed: () => annullaOnSubmit(context),
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
                          //   onPressed: () => successivoOnSubmit(context),
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
                            onPressed: () => savalOnSubmit(context),
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
