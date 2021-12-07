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
                            onPressed: () => annullaOnSubmit(context),
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
