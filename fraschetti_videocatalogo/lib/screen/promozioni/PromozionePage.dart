import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/screen/catalogo/CatalogoPage.dart';


class PromozionePage extends StatefulWidget {
  PromozionePage({Key? key}) : super(key: key);
  static const String routeName = 'PromozionePage';
  final String pagina_titolo = "Catalogo";

  @override
  _PromozionePageState createState() => _PromozionePageState();
}

class _PromozionePageState extends State<PromozionePage> {
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
                  SizedBox(height: 5),
                  CodiciWidget(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: _DemoBottomAppBar(),
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
                  color: Colors.red,
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
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
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
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  "Articolo Articolo Articolo",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
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
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(5),
                  height: 500,
                  // width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orange,
                      width: 2,
                    ),
                  ),
                  child: SingleChildScrollView(
                  child: Text(
                    "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
                    // "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, ",
                    // style: TextStyle(fontSize: 12.0),
                  ),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                flex: 5,
                child: Container(
                  height: 500,
                  // width: 400,
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
              ),
              SizedBox(width: 5),
            ],
          ),
        ],
      ),
    );
  }

// riga lista codici
  Widget CodiciWidget() {
    return Container(
      height: 300,
      child: Expanded(
        child: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, CatalogoPage.routeName);
              },
              child: Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      // consegna
                      alignment: Alignment(0.0, 0.0),
                      width: 20,
                      height: 50,
                      // color: Colors.orange,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        "X",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Container(
                      // venduto
                      alignment: Alignment(0.0, 0.0),
                      width: 20,
                      height: 50,
                      // color: Colors.orange,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        " • ",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Container(
                      // codice
                      alignment: Alignment(0.0, 0.0),
                      width: 80,
                      height: 50,
                      // color: Colors.orange,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        "000000",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Expanded(
                      // descrizione
                      flex: 1,
                      child: Container(
                        alignment: Alignment(-1.0, 0.0),
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.orange,
                            width: 2,
                          ),
                        ),
                        child: Text(
                              "Codice Codice Codice Codice Codice Codice",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  overflow: TextOverflow.ellipsis),
                            ),

                      ),
                    ),
                    Container(
                      // quantità
                      alignment: Alignment(1.0, 0.0),
                      width: 50,
                      height: 50,
                      // color: Colors.orange,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        "1500",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Container(
                      // apribile
                      alignment: Alignment(0.0, 0.0),
                      width: 20,
                      height: 50,
                      // color: Colors.orange,
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
                      width: 40,
                      height: 50,
                      // color: Colors.orange,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        "XC",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Container(
                      // prezzo
                      alignment: Alignment(1.0, 0.0),
                      width: 90,
                      height: 50,
                      // color: Colors.orange,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        "1500,00",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Container(
                      // iva
                      alignment: Alignment(0.0, 0.0),
                      width: 30,
                      height: 50,
                      // color: Colors.orange,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        "22",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
            );
            // return ListTile(
            //   title: Text(articoli_lista[index].toString()),
            // );
          },
        ),
      ),
    );
  }
}

// classe app bar da spostare per usare da altre parti
class _DemoBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.blue,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: <Widget>[
            IconButton(
              tooltip: 'Open navigation menu',
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Search',
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Favorite',
              icon: const Icon(Icons.favorite),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
