import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/repositories/articoliRepository.dart';
import 'package:fraschetti_videocatalogo/models/catalogoModel.dart';
import 'package:image/image.dart';

import '../ordine/OrdineArticoloAggiungiPage.dart';

class CatalogoPage extends StatefulWidget {
  CatalogoPage({Key? key}) : super(key: key);
  static const String routeName = "catalogo_page";
  final String pagina_titolo = "Catalogo";

  @override
  _CatalogoPageState createState() => _CatalogoPageState();
}

class _CatalogoPageState extends State<CatalogoPage> {
  void listaClick(BuildContext context) {
    Navigator.pushNamed(context, OrdineArticoloAggiungiPage.routeName);
  }

  void articolo_disponibilita_mostra(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Disponibilità'),
        content: const Text('Verrà mostrata la disponibilità'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          // leading: IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.menu),
          // ),
          title: Text(widget.pagina_titolo),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomBarWidget(),
        body: Container(
          // height: 400,
          // height: MediaQuery.of(context).size.height/2,
          child: SingleChildScrollView(
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
                children: <Widget>[
                  ArticoloWidget(),
                  // SizedBox(height: 5),
                  CodiciWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// dati articolo catalogo
  Widget ArticoloWidget() {
    return Container(
      // height: 500,
      // padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.amber,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      "Categoria Categoria",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 60,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orange,
                      width: 2,
                    ),
                    image: DecorationImage(
                      image: AssetImage("assets/immagini/splash_screen.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                  width: 60,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orange,
                      width: 2,
                    ),
                    image: DecorationImage(
                      image: AssetImage("assets/immagini/splash_screen.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "Articolo Articolo Articolo",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 5),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(5),
                  // height: 400,
                  // width: 100,
                  // height: double.infinity,

                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orange,
                      width: 2,
                    ),
                  ),
                  child: SizedBox(
                    height: 300,
                    child: SingleChildScrollView(
                      child: Text(
                        "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
                        // "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, ",
                        textAlign: TextAlign.justify,
                        // style: TextStyle(fontSize: 12.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                flex: 2,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                      height: constraints.minWidth,
                      // width: 500,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 2,
                        ),
                        image: DecorationImage(
                          image:
                              AssetImage("assets/immagini/splash_screen.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 5),
            ],
          ),
        ],
      ),
    );
  }

  Widget CodiciWidget_2() {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.orange,
          width: 2,
        ),
      ),
      child: Text("ciao"),
    );
  }

// riga lista codici
  Widget CodiciWidget() {
    return SizedBox(
      height: 300,
      child: Expanded(
        child: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                listaClick(context);
              },
              onLongPress: () {
                articolo_disponibilita_mostra(context);
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      // venduto
                      alignment: Alignment(0.0, 0.0),
                      width: 15,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        "•",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Container(
                      // codice
                      alignment: Alignment(0.0, 0.0),
                      width: 60,
                      // color: Colors.orange,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        "000000",
                        // style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    Expanded(
                      // descrizione
                      child: Container(
                        padding: EdgeInsets.all(2),
                        alignment: Alignment(-1.0, 0.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.orange,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          "Codice Codice Codice Codice Codice Codice",
                          style: TextStyle(
                            // fontSize: 14.0,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // quantità
                      padding: EdgeInsets.all(2),
                      alignment: Alignment(1.0, 0.0),
                      width: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        "1500",
                        // style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Container(
                      // apribile
                      alignment: Alignment(0.0, 0.0),
                      width: 20,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        "*",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Container(
                      // unità di misura
                      alignment: Alignment(0.0, 0.0),
                      width: 25,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        "XC",
                        // style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Container(
                      // prezzo
                      padding: EdgeInsets.all(3),
                      alignment: Alignment(1.0, 0.0),
                      width: 80,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        "99999,99",
                        // style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Container(
                      // iva
                      alignment: Alignment(0.0, 0.0),
                      width: 25,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        "22",
                        // style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
