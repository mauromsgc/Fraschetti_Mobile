import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/models/parametriModel.dart';
import 'package:fraschetti_videocatalogo/models/utenteCorrenteModel.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:fraschetti_videocatalogo/screen/auth/RegistrazionePage.dart';
import 'package:fraschetti_videocatalogo/screen/catalogo/CatalogoLista.dart';
import 'package:fraschetti_videocatalogo/utils/ValidationBlock.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  static const String routeName = 'Login';

  final String pagina_titolo = "Login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // controller per i campi del form
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // variabili per errori
  String errore_generico = "";
  String usernameError = "";
  String passwordError = "";

  @override
  void initState() {
    super.initState();

    usernameController.text = GetIt.instance<ParametriModel>().username;
    setState(() {});
    print("username: " + usernameController.text);
    log(GetIt.instance<ParametriModel>().password);
  }

  void loginOnSubmit(BuildContext context) async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    setState(() {
      errore_generico = "";
      usernameError = "";
      passwordError = "";
    });

    bool valid = validationBlock((when) {
      when(username.isEmpty,
          () => setState(() => usernameError = "Campo obbligatorio"));
      when(password.isEmpty,
          () => setState(() => passwordError = "Campo obbligatorio"));
    });

    if (valid) {
      if ((GetIt.instance<ParametriModel>().username == username) &&
          (GetIt.instance<ParametriModel>().password == password)) {
        valid = true;
      } else {
        valid = false;
        setState(() {
          errore_generico = "Dati utente non corretti";
        });
      }

      print("valid: " + valid.toString());
      if (valid) {
        // print("Username $username Password = $password");
        GetIt.instance<UtenteCorrenteModel>().inizializza();
        Navigator.popAndPushNamed(context, CatalogoListaPage.routeName);
      } else {
        print("Login fallito");
      }
    } else {
      print("Registrazione fallita");
    }
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
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      controller: usernameController,
                      textCapitalization: TextCapitalization.characters,
                      // keyboardType: TextInputType.text,
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
                      autofocus: true,
                      onEditingComplete: () {
                        loginOnSubmit(context);
                      },
                      controller: passwordController,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
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
                  if(errore_generico != "")
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        errore_generico,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ), Container(
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 2),
                      onPressed: () => loginOnSubmit(context),
                      child: Text('Login'),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 2),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RegistazionePage.routeName);
                      },
                      child: Text('Registrazione'),
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
