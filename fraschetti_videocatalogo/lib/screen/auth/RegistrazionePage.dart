import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/main.dart';
import 'package:fraschetti_videocatalogo/repositories/httpRepository.dart';
import 'package:fraschetti_videocatalogo/screen/auth/LoginPage.dart';
import 'package:fraschetti_videocatalogo/screen/auth/ParametriConnesionePage.dart';
import 'package:fraschetti_videocatalogo/utils/ValidationBlock.dart';

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
  final TextEditingController password_verificaController = TextEditingController();
  final TextEditingController codice_attivazioneController = TextEditingController();

  // variabili per errori
  String usernameError = "";
  String passwordError = "";
  String password_verificaError = "";
  String codice_attivazioneError = "";

  void registrazioneOnSubmit(BuildContext context) async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    final password_verifica = password_verificaController.text.trim();
    final codice_attivazione = codice_attivazioneController.text.trim();

    setState(() {
      usernameError = "";
      passwordError = "";
      password_verificaError = "";
      codice_attivazioneError = "";
    });

    final valid = validationBlock((when) {
      when(username.isEmpty,
              () => setState(() => usernameError = "Campo obbligatorio"));
      when(password.isEmpty,
              () => setState(() => passwordError = "Campo obbligatorio"));
      when(password_verifica.isEmpty,
              () => setState(() => password_verificaError = "Campo obbligatorio"));
      when(((password.isNotEmpty & password_verifica.isNotEmpty) &(password != password_verifica)),
              () => setState(() => password_verificaError = "Le password non coincidono"));
      when(codice_attivazione.isEmpty,
              () => setState(() => codice_attivazioneError = "Campo obbligatorio"));
    });

    if (valid) {
      Navigator.pushNamed(context, LoginPage.routeName);
    } else {
      print("Registrazione fallita");
    }
  }

  void parametriOnSubmit(BuildContext context) async {
    Navigator.of(context).pushNamed("parametri_connessione");
  }

  void testComunicazioneOnSubmit(BuildContext context) async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    final response = await getIt.get<HttpRepository>().http!.test('lg', 'superbmsgc');

    print(response);
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
                        contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
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
                        contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        errorText: (passwordError == "") ? null : passwordError,
                        icon: Icon(
                          Icons.visibility_off,
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
                        contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        labelText: 'Conferma Password',
                        errorText: (password_verificaError == "") ? null : password_verificaError,
                        icon: Icon(
                          Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      controller: codice_attivazioneController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        labelText: 'Codice attivazione',
                        errorText: (codice_attivazioneError == "") ? null : codice_attivazioneError,
                        icon: Icon(
                          Icons.lock_open,
                        ),
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
                      onPressed: () => testComunicazioneOnSubmit(context),
                      child: Text('Test comunicazione'),
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
