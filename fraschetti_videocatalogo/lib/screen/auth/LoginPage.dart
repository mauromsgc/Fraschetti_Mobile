import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/screen/auth/RegistrazionePage.dart';
import 'package:fraschetti_videocatalogo/screen/catalogo/CatalogoLista.dart';
import 'package:fraschetti_videocatalogo/utils/ValidationBlock.dart';

import 'ParametriConnesionePage.dart';

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
  String usernameError = "";
  String passwordError = "";

  void loginOnSubmit(BuildContext context) async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    setState(() {
      usernameError = "";
      passwordError = "";
    });

    final valid = validationBlock((when) {
      when(username.isEmpty,
          () => setState(() => usernameError = "Campo obbligatorio"));
      when(password.isEmpty,
          () => setState(() => passwordError = "Campo obbligatorio"));
    });

    if (valid) {
      // print("Username $username Password = $password");
      Navigator.popAndPushNamed(context, CatalogoListaPage.routeName);
    } else {
      print("Login fallito");
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
                      controller: passwordController,
                      // obscureText: true,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
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
