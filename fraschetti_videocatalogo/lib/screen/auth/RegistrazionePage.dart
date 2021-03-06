import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/helper/DBHelper.dart';
import 'package:fraschetti_videocatalogo/main.dart';
import 'package:fraschetti_videocatalogo/models/parametriModel.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:fraschetti_videocatalogo/repositories/httpRepository.dart';
import 'package:fraschetti_videocatalogo/screen/auth/LoginPage.dart';
import 'package:fraschetti_videocatalogo/screen/auth/ParametriConnesionePage.dart';
import 'package:fraschetti_videocatalogo/utils/Utility.dart';
import 'package:fraschetti_videocatalogo/utils/ValidationBlock.dart';
import 'package:get_it/get_it.dart';

class RegistazionePage extends StatefulWidget {
  RegistazionePage({Key? key}) : super(key: key);
  static const String routeName = "registrazione";

  final String pagina_titolo = "Registrazione";

  @override
  _RegistazionePageState createState() => _RegistazionePageState();
}

class _RegistazionePageState extends State<RegistazionePage> {
  // controller per i campi del form
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController password_verificaController =
      TextEditingController();
  final TextEditingController codice_attivazioneController =
      TextEditingController();

  // variabili per errori
  String errore_generico = "";
  String usernameError = "";
  String passwordError = "";
  String password_verificaError = "";
  String codice_attivazioneError = "";

  @override
  void initState() {
    super.initState();
  }

  void registrazioneOnSubmit(BuildContext context) async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    final password_verifica = password_verificaController.text.trim();
    final codice_attivazione = codice_attivazioneController.text.trim();

    setState(() {
      errore_generico = "";
      usernameError = "";
      passwordError = "";
      password_verificaError = "";
      codice_attivazioneError = "";
    });

    bool valid = validationBlock((when) {
      when(username.isEmpty,
          () => setState(() => usernameError = "Campo obbligatorio"));
      when(password.isEmpty,
          () => setState(() => passwordError = "Campo obbligatorio"));
      when(password_verifica.isEmpty,
          () => setState(() => password_verificaError = "Campo obbligatorio"));
      when(
          ((password.isNotEmpty & password_verifica.isNotEmpty) &
              (password != password_verifica)),
          () => setState(
              () => password_verificaError = "Le password non coincidono"));
      when(codice_attivazione.isEmpty,
          () => setState(() => codice_attivazioneError = "Campo obbligatorio"));
    });

    if (GetIt.instance<ParametriModel>().host_server == "") {
      valid = false;
      setState(() {
        errore_generico = "Parametri di comunicazione non presenti";
      });
    }

    if (valid) {
      valid = await GetIt.instance<DbRepository>().utente_registra(
          username: username,
          password: password,
          codice_attivazione: codice_attivazione);
      print("valid: " + valid.toString());
      if (valid) {
// aggiorna la pasword nei parametri e ricaricai parametri

        await GetIt.instance<ParametriModel>().inizializza();

        Navigator.popAndPushNamed(context, LoginPage.routeName);
      } else {
        setState(() =>
            errore_generico = "Errore durante la registrazione, riprovare");
      }
    } else {
      print("Registrazione fallita");
    }
  }

  void parametriOnSubmit(BuildContext context) async {
    Navigator.of(context).pushNamed("parametri_connessione");
  }

  void connessione_test_ui(BuildContext context) async {
    connessione_test_alert(context);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.pagina_titolo),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      controller: usernameController,
                      textCapitalization: TextCapitalization.characters,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                        errorText: (usernameError == "") ? null : usernameError,
                        icon: Icon(
                          Icons.account_box,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        errorText: (passwordError == "") ? null : passwordError,
                        icon: Icon(
                          Icons.password,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      controller: password_verificaController,
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        labelText: 'Conferma Password',
                        errorText: (password_verificaError == "")
                            ? null
                            : password_verificaError,
                        icon: Icon(
                          Icons.password,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      onEditingComplete: () {
                        registrazioneOnSubmit(context);
                      },
                      controller: codice_attivazioneController,
                      // per poter inserire la password come programmatore
                      // keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        labelText: 'Codice attivazione',
                        errorText: (codice_attivazioneError == "")
                            ? null
                            : codice_attivazioneError,
                        icon: Icon(
                          Icons.vpn_key,
                        ),
                      ),
                    ),
                  ),
                  if(errore_generico != "")
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      errore_generico,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 2),
                      onPressed: () => registrazioneOnSubmit(context),
                      child: Text('Registrati'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 2),
                      onPressed: () => connessione_test_ui(context),
                      child: Text('Test connessione'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 2),
                      onPressed: () => parametriOnSubmit(context),
                      child: Text('Parametri'),
                    ),
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
