import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/repositories/articoliRepository.dart';
import 'package:fraschetti_videocatalogo/models/catalogoModel.dart';
import 'package:fraschetti_videocatalogo/screen/catalogo/CatalogoPage.dart';

class PromozionePage extends StatefulWidget {
  PromozionePage({Key? key}) : super(key: key);
  static const String routeName = 'promozione_page';
  final String pagina_titolo = "Promozione";

  @override
  _PromozionePageState createState() => _PromozionePageState();
}

class _PromozionePageState extends State<PromozionePage> {
  List<CatalogoModel> articoli_lista = ArticoliRepository().all_3();

  void listaClick(BuildContext context) {
    Navigator.pushNamed(context, CatalogoPage.routeName);
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
                  PromozioneWidget(),
                  SizedBox(height: 5),
                  ListaWidget(articoli_lista),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// dati promozione
  Widget PromozioneWidget() {
    return Container(
      // height: 500,
      // padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "Promozione Promozione Promozione",
                    style: TextStyle(
                      fontSize: 30,
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

// riga lista articoli
  Widget ListaWidget(List<CatalogoModel> articoli_lista) {
    return Container(
      height: 300,
      child: Expanded(
        child: ListView.builder(
          itemCount: articoli_lista.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                listaClick(context);
              },
              child: Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 10,
                      height: 40,
                      // color: Colors.orange,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
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
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.orange,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${articoli_lista[index].nome}",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            // Text("${articoli_lista[index].nome}"),
                            // Text("Riga 22"),
                          ],
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
