import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/main.dart';
import 'package:fraschetti_videocatalogo/models/parametriModel.dart';
import 'package:fraschetti_videocatalogo/repositories/httpRepository.dart';
import 'package:fraschetti_videocatalogo/utils/ValidationBlock.dart';
import 'package:get_it/get_it.dart';

class ParametriConnesionePage extends StatefulWidget {
  ParametriConnesionePage({Key? key}) : super(key: key);
  static const String routeName = "parametri_connessione";

  final String pagina_titolo = "Parametri connessione";

  @override
  _ParametriConnesionePageState createState() =>
      _ParametriConnesionePageState();
}

class _ParametriConnesionePageState extends State<ParametriConnesionePage> {
  final TextEditingController host_serverController = TextEditingController();

  String parametriError = "";

  @override
  void initState() {
    super.initState();
    host_serverController.text = GetIt.instance<ParametriModel>().host_server;
  }

  void salvaOnSubmit(BuildContext context) async {
    final host_server = host_serverController.text.trim();

    setState(() {
      parametriError = "";
    });

    bool valid = validationBlock((when) {
      when(host_server.isEmpty,
          () => setState(() => parametriError = "Campo obbligatorio"));
      // when(password.isEmpty,
      //         () => setState(() => passwordError = "Campo obbligatorio"));
    });

    if (valid) {
      valid = await GetIt.instance<ParametriModel>()
          .host_server_aggiorna(host_server.trim());
      if (valid) {
        Navigator.of(context).pop();
      } else {
        parametriError = "Errore durante il salvataggio, riprovare";
      }
    } else {
      print("Registrazione fallita");
    }
  }

  void AnnullaOnSubmit(BuildContext context) async {
    Navigator.of(context).pop();
  }

  void parametri_default_assegna({bool debug = false}) async {
    if(debug == false) {
      host_serverController.text = "http://www.fraschetti.com:8080";
    }else{
      host_serverController.text = "http://192.168.1.78:8080";
    }

  }

  void test_comunicazine(BuildContext context) async {
    final response = await getIt.get<HttpRepository>().http!.trasmissione_test(p_host_server: host_serverController.text);

    print(response);
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
                      controller: host_serverController,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        labelText: 'Parametri di connessione',
                        errorText:
                            (parametriError == "") ? null : parametriError,
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
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(elevation: 2),
                          onPressed: () => parametri_default_assegna(),
                          onLongPress: () => parametri_default_assegna(debug: true),
                          child: Text('Assegna parameri default'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(elevation: 2),
                          onPressed: () => test_comunicazine(context),
                          child: Text('Test trasmissione'),
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
