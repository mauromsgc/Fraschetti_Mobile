import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/OrdineArticoloAggiungiPage.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';

class DisponibilitaPage extends StatefulWidget {
  DisponibilitaPage({Key? key}) : super(key: key);
  static const String routeName = "disponibilita_page";
  final String pagina_titolo = "Disponibilità";

  @override
  _DisponibilitaPageState createState() => _DisponibilitaPageState();
}

class _DisponibilitaPageState extends State<DisponibilitaPage> {
  void aggiungi_ad_ordine(BuildContext context) {
    Navigator.pushNamed(context, OrdineArticoloAggiungiPage.routeName);
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
              // decoration: MyBoxDecoration().MyBox(),
              // width: 600,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 5),
                  DisponibilitaWidget(),
                  SizedBox(height: 5),
                  ArticoloWidget(),
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
                top: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
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
                    decoration: MyBoxDecoration().MyBox(),
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
                  decoration: MyBoxDecoration().MyBox(),
                  child: Image.asset("assets/immagini/splash_screen.png"),
                ),
                Container(
                  width: 60,
                  height: 50,
                  decoration: MyBoxDecoration().MyBox(),
                  child: Image.asset("assets/immagini/splash_screen.png"),
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

                  decoration: MyBoxDecoration().MyBox(),
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
                      decoration: MyBoxDecoration().MyBox(),
                      child: Image.asset("assets/immagini/splash_screen.png"),
                    );
                  },
                ),
              ),
              SizedBox(width: 5),
            ],
          ),
          Divider(),
          Container(
            padding: EdgeInsets.all(5),
            child: Text(
              "Avvertenze",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.all(5),
            // height: 400,
            // width: 100,
            // height: double.infinity,

            decoration: MyBoxDecoration().MyBox(),
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
        ],
      ),
    );
  }

  Widget DisponibilitaWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              // Articolo codice
              width: 120,
              padding: EdgeInsets.all(5),
              child: TextFormField(
                // readOnly: true,
                textAlign: TextAlign.end,
                enabled: false,
                initialValue: "000000",
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                  border: OutlineInputBorder(),
                  labelText: "Articolo codice",
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            // Expanded(
            //   child:
            Container(
              // descrizione codice
              padding: EdgeInsets.all(5),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 2),
                onPressed: () {
                  aggiungi_ad_ordine(context);
                },
                child: Text("Aggiungi all'ordine"),
              ),
            ),
            // ),
          ],
        ),
        Container(
          // codic e descrizione
          padding: EdgeInsets.all(5),
          child: TextFormField(
            // readOnly: true,
            enabled: false,
            initialValue: "Codice descrizione Codice descrizione Codice descrizione Codice descrizione Codice descrizione Codice descrizione Codice descrizione",
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade200,
              contentPadding:
              EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
              border: OutlineInputBorder(),
              labelText: "Codice descrizione",
            ),
          ),
        ),
          Container(
            // stato disponibilità
            padding: EdgeInsets.all(5),
            child: TextFormField(
              // readOnly: true,
              enabled: false,
              initialValue: "non disponibile",
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding:
                EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                border: OutlineInputBorder(),
                labelText: "Stato",
              ),
            ),
          ),
        Container(
          // unità di misura
          padding: EdgeInsets.all(5),
          child: TextFormField(
            // readOnly: true,
            enabled: false,
            initialValue: "00/00/0000",
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade200,
              contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
              border: OutlineInputBorder(),
              labelText: "Data arrivo prevista",
            ),
          ),
        ),
      ],
    );
  }
}
