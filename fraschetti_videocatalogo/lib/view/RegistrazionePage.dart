import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/view/LoginPage.dart';
import 'package:fraschetti_videocatalogo/view/ParametriPage.dart';

class RegistazionePage extends StatefulWidget {
  RegistazionePage({Key? key, this.title = 'Registrazione'}) : super(key: key);
  static const String routeName = 'Registrazione';
  final String title;

  @override
  _RegistazionePageState createState() => _RegistazionePageState();
}

class _RegistazionePageState extends State<RegistazionePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Container(
            // padding: new EdgeInsets.all(10.0),
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     color: Colors.orange,
            //     width: 2,
            //   ),
            // ),
            // width: 600,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  //width: 200.0,
                  height: 50.0,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Annulla',
                      icon: Icon(
                        Icons.account_box,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      icon: Icon(
                        Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Conferma Password',
                      icon: Icon(
                        Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Codice attivazione',
                      icon: Icon(
                        Icons.lock_open,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 2),
                    // apertura pagina diretta senza route
                    // onPressed: () => Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => LoginPage())),
                    // apertura chiamando il router app
                    onPressed: () =>
                        Navigator.of(context).pushNamed(LoginPage.routeName),

                    child: Text('Registrati'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 2),
                    onPressed: () {},
                    child: Text('Test comunicazione'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 2),
                    onPressed: () => Navigator.of(context)
                        .pushNamed(ParametriPage.routeName),
                    child: Text('Parametri'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
