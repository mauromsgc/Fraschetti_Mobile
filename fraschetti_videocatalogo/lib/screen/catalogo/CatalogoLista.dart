import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/models/articoli.dart';
import 'package:fraschetti_videocatalogo/models/catalogoModel.dart';
import 'package:fraschetti_videocatalogo/screen/catalogo/ArticoloAggiungiPage.dart';
import 'package:image/image.dart';

import 'CatalogoPage.dart';

class CatalogoListaPage extends StatefulWidget {
  CatalogoListaPage({Key? key}) : super(key: key);
  static const String routeName = 'CatalogoLista';

  final String pagina_titolo = "Catalogo";

  @override
  _CatalogoListaPageState createState() => _CatalogoListaPageState();
}

class _CatalogoListaPageState extends State<CatalogoListaPage> {
  List<CatalogoModel> articoli_lista = ArticoliRepository().all_2();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
          title: Text(widget.pagina_titolo),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.exit_to_app),
            )
          ],
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
              children: <Widget>[
                RicercaWidget(),
                SelezioniWidget(),
                CategorieWidget(),
                ListaWidget(articoli_lista),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _DemoBottomAppBar(),
      ),
    );
  }

// sezione ricerca
  Widget RicercaWidget() {
    return Padding(
      padding: EdgeInsets.all(3),
      child: SizedBox(
        height: 40,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: TextFormField(
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  // labelText: 'Descrizione/EAN',
                  // labelText: 'Descrizione',
                  hintText: 'Descrizione',
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 3,
              child: TextFormField(
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  // labelText: 'Codice',
                  hintText: 'Codice',
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 2),
                onPressed: () {},
                child: Text('Cerca'),
              ),
            ),
          ],
        ),
      ),
    );
  }

// da modificare con un pulsante a destra del pulsante menu
// va messo all'interno del title
// sezione selezioni
  Widget SelezioniWidget() {
    return Padding(
      padding: EdgeInsets.all(3),
      child: SizedBox(
        height: 40,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 2),
                onPressed: () {},
                child: Text('Assortimenti'),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 2),
                onPressed: () {},
                child: Text('Selezioni'),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 2),
                onPressed: () {},
                child: Text('Tutto'),
              ),
            ),
          ],
        ),
      ),
    );
  }

// sezione categorie
  Widget CategorieWidget() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: 10.0, // insert your font size here
              ),
              primary: Colors.red,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
            ),
            onPressed: () {},
            child: Text('Edilizia'),
          ),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: 10.0, // insert your font size here
              ),
              primary: Colors.red,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
            ),
            onPressed: () {},
            child: Text('Ut. mano'),
          ),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: 10.0, // insert your font size here
              ),
              primary: Colors.red,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
            ),
            onPressed: () {},
            child: Text('Ferram.'),
          ),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: 10.0, // insert your font size here
              ),
              primary: Colors.red,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
            ),
            onPressed: () {},
            child: Text('Giardin.'),
          ),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: 10.0, // insert your font size here
              ),
              primary: Colors.red,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
            ),
            onPressed: () {},
            child: Text('Ut. elet.'),
          ),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: 10.0, // insert your font size here
              ),
              primary: Colors.red,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
            ),
            onPressed: () {},
            child: Text('Idraulica'),
          ),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: 10.0, // insert your font size here
              ),
              primary: Colors.red,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
            ),
            onPressed: () {},
            child: Text('Siderurg.'),
          ),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: 10.0, // insert your font size here
              ),
              primary: Colors.red,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
            ),
            onPressed: () {},
            child: Text('Domo ut.'),
          ),
        ),
      ],
    );
  }

// riga lista
  Widget ListaWidget(List<CatalogoModel> articoli_lista) {
    return Expanded(
      flex: 1,
      child: ListView.builder(
        itemCount: articoli_lista.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Navigator.pushNamed(context, ArticoloAggiungiPage.routeName);
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
                  Column(
                    children: [
                      Text("${articoli_lista[index].nome}"),
                      Text("Riga 22"),
                    ],
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
