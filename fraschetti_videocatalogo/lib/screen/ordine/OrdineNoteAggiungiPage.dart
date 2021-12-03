import 'package:flutter/material.dart';

class OrdineNoteAggiungiPage extends StatefulWidget {
  OrdineNoteAggiungiPage({Key? key}) : super(key: key);
  static const String routeName = "ordini_note_aggiungi";
  final String pagina_titolo = "Ordine note";

  @override
  _OrdineNoteAggiungiPageState createState() => _OrdineNoteAggiungiPageState();
}

class _OrdineNoteAggiungiPageState extends State<OrdineNoteAggiungiPage> {
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
    //    Navigator.of(context).pop();
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
                left: 10,
                right: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // cliente nominativo
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      // readOnly: true,
                      enabled: false,
                      initialValue: "0000 Cliente Cliente Cliente",
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        labelText: "Cliente",
                      ),
                    ),
                  ),
                  Container(
                    // articolo codice
                    width: 120,
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      // readOnly: true,
                      enabled: false,
                      initialValue: "000000",
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        labelText: "Codice",
                      ),
                    ),
                  ),
                  Container(
                    // articolo descrizione
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      // readOnly: true,
                      enabled: false,
                      initialValue: "Catalogo Catalogo Catalogo",
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        labelText: "Articolo",
                      ),
                    ),
                  ),
                  Container(
                    // articolo codice descrizione
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      // readOnly: true,
                      enabled: false,
                      initialValue: "Codice descrizione Codice descrizione",
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        labelText: "Descrizione codice",
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        // unità di misura
                        width: 120  ,
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          // readOnly: true,
                          enabled: false,
                          initialValue: "PZ",
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "U.M.",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Container(
                        // prezzo base
                        width: 150,
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          // readOnly: true,
                          enabled: false,
                          initialValue: "1500,36",
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
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
                        // apribile
                        width: 120  ,
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          // readOnly: true,
                          enabled: false,
                          initialValue: "*",
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "Apribile",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Container(
                        // confezione
                        width: 120,
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          // readOnly: true,
                          enabled: false,
                          initialValue: "4",
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "Confezione",
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Container(
                        // Quantità
                        width: 120  ,
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          // initialValue: "",
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "Quantità",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Container(
                        // quantità già presente
                        width: 120,
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          // readOnly: true,
                          enabled: false,
                          initialValue: "4",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.red.shade100,
                              contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
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
                        width: 120  ,
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          // initialValue: "",
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
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
                        width: 150  ,
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          // initialValue: "",
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "Prezzo",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Container(
                        // confezione
                        width: 150,
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          // readOnly: true,
                          enabled: false,
                          initialValue: "135,00",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.red.shade100,
                            contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            labelText: "Prezzo presente",
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
                          padding: EdgeInsets.all(10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(elevation: 2),
                            onPressed: () => annullaOnSubmit(context),
                            child: Text('Annulla'),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(elevation: 2),
                            onPressed: () => successivoOnSubmit(context),
                            child: Text('Successivo'),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(10),
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
