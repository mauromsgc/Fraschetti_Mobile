import 'package:flutter/material.dart';

class ArticoloAggiungiPage extends StatefulWidget {
  ArticoloAggiungiPage({Key? key}) : super(key: key);
  static const String routeName = "articolo_aggiungi";
  final String pagina_titolo = "Articolo aggiungi";

  @override
  _ArticoloAggiungiPageState createState() => _ArticoloAggiungiPageState();
}

class _ArticoloAggiungiPageState extends State<ArticoloAggiungiPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.pagina_titolo),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.all(10),
                    child: TextFormField(
                      readOnly: true,
                      initialValue: "0000 Cliente Cliente CLiente",
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Cliente",
                      ),
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
