import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/utils/ValidationBlock.dart';

class ParametriConnesionePage extends StatefulWidget {
  ParametriConnesionePage({Key? key}) : super(key: key);
  static const String routeName = "parametri_connessione";

  final String pagina_titolo = "Parametri connessione";

  @override
  _ParametriConnesionePageState createState() => _ParametriConnesionePageState();
}

class _ParametriConnesionePageState extends State<ParametriConnesionePage> {
  final TextEditingController parametriController = TextEditingController();

  String parametriError = "";

  void salvaOnSubmit(BuildContext context) async {
    final parametri = parametriController.text.trim();

    setState(() {
      parametriError = "";
    });

    final valid = validationBlock((when) {
      when(parametri.isEmpty,
              () => setState(() => parametriError = "Campo obbligatorio"));
      // when(password.isEmpty,
      //         () => setState(() => passwordError = "Campo obbligatorio"));
    });

    if (valid) {
      Navigator.of(context).pop();
    } else {
      print("Registrazione fallita");
    }
  }


  void AnnullaOnSubmit(BuildContext context) async {
    Navigator.of(context).pop();
  }

  void parametri_defaultOnSubmit() async {
    parametriController.text = "www.fraschetti.com:8080";

    // setState(() {
    //
    // });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.pagina_titolo),
          centerTitle: true,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      controller: parametriController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        labelText: 'Parametri di connessione',
                        errorText: (parametriError == "") ? null : parametriError,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(elevation: 2),
                          onPressed: () => Navigator.pop(context),
                          child: Text('Annulla'),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(elevation: 2),
                          // dovrebbe salvare e poi tornare indietro
                          onPressed: () => salvaOnSubmit(context),
                          child: Text('Salva'),
                        ),
                      ),
                    ],),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(elevation: 2),
                          onPressed: () => parametri_defaultOnSubmit(),
                          child: Text('Assegna parameri default'),
                        ),
                      ),
                    ],),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(elevation: 2),
                          onPressed: () {},
                          child: Text('Test trasmissione'),
                        ),
                      ),
                    ],),


                ],),
            ),
          ),
        ),
      ),
    );
  }
}
