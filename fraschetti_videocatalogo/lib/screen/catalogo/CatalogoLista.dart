import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/models/assortimentoModel.dart';
import 'package:fraschetti_videocatalogo/models/assortimentoModel.dart';
import 'package:fraschetti_videocatalogo/models/famigliaModel.dart';
import 'package:fraschetti_videocatalogo/repositories/assortimentiRepository.dart';
import 'package:fraschetti_videocatalogo/repositories/famiglieRepository.dart';
import 'package:fraschetti_videocatalogo/repositories/articoliRepository.dart';
import 'package:fraschetti_videocatalogo/models/catalogoModel.dart';
import 'package:fraschetti_videocatalogo/screen/auth/LoginPage.dart';
import 'package:fraschetti_videocatalogo/screen/catalogo/CatalogoPage.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';


class CatalogoListaPage extends StatefulWidget {
  CatalogoListaPage({Key? key}) : super(key: key);
  static const String routeName = "catalogo_lista";
  final String pagina_titolo = "Catalogo";

  @override
  _CatalogoListaPageState createState() => _CatalogoListaPageState();
}

class ListItem {
  int codice = 0;
  String valore = "";

  ListItem(this.codice, this.valore);
}

class _CatalogoListaPageState extends State<CatalogoListaPage> {
  List<CatalogoModel> articoli_lista = ArticoliRepository().all_2();
  List<FamigliaModel> famiglie = FamiglieRepository().all_2();
  List<AssortimentoModel> _assortimenti_lista = AssortimentiRepository()
      .all_2();

  @override
  void initState() {
    super.initState();
  }

  void listaClick(BuildContext context) {
    Navigator.pushNamed(context, CatalogoPage.routeName);
  }

  void _assortimenti_menu(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: const Text("Assortimenti"),
            content: SingleChildScrollView(
              child: Container(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children:

                  _assortimenti_lista.map((elemento) {
                    return Container(
                      height: 40,
                      width: double.maxFinite,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 2),
                        onPressed: () {},
                        child: Text(elemento.descrizione),
                      ),
                    );
                  }).toList(),


                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Chiudi'),
              ),
            ],
          ),
    );
  }

  void _selezioni_menu(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: const Text("Selezioni"),
            content: Container(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 40,
                    width: double.maxFinite,
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 2),
                      onPressed: () {},
                      child: Text('Novità'),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: double.maxFinite,
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 2),
                      onPressed: () {},
                      child: Text('Nuovi codici'),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: double.maxFinite,
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 2),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Prodotti in offerta'),
                    ),
                  ),

                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Chiudi'),
              ),
            ],
          ),
    );
  }

  void _ordinamenti_menu(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: const Text("Seleziona l'ordine"),
            content: SingleChildScrollView(
              child: Container(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 40,
                      width: double.maxFinite,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 2),
                        onPressed: () {},
                        child: Text('Descrizione crescente'),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: double.maxFinite,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 2),
                        onPressed: () {},
                        child: Text('Descrizione decrescente'),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: double.maxFinite,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 2),
                        onPressed: () {},
                        child: Text('Codice crescente'),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: double.maxFinite,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 2),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Codice decrescente'),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Chiudi'),
              ),
            ],
          ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.sort),
          // ),
          title: Text(widget.pagina_titolo),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                _ordinamenti_menu(context);
              },
              icon: Icon(Icons.sort),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, LoginPage.routeName);
              },
              icon: Icon(Icons.exit_to_app),
            )
          ],
        ),
        bottomNavigationBar: BottomBarWidget(),
        body: Container(
          child: Container(
            // padding: new EdgeInsets.all(10.0),
            // decoration: MyBoxDecoration().MyBox(),
            // width: 600,
            child: Column(
              children: <Widget>[
                RicercaWidget(),
                SelezioniWidget(),
                CategorieWidget(),
                Divider(
                  height: 5,
                  thickness: 2,
                  // color: Theme.of(context).primaryColor,
                ),
                ListaWidget(articoli_lista),
              ],
            ),
          ),
        ),
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
              flex: 6,
              child: TextFormField(
                onEditingComplete: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>
                        AlertDialog(
                          title: const Text('Avviare ricerca'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('ok'),
                            ),
                          ],
                        ),
                  );
                },
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                  border: OutlineInputBorder(),
                  hintText: 'Descrizione',
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: TextFormField(
                onEditingComplete: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>
                        AlertDialog(
                          title: const Text('Avviare ricerca'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('ok'),
                            ),
                          ],
                        ),
                  );
                },
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                  border: OutlineInputBorder(),
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
                onPressed: () {
                  _assortimenti_menu(context);
                },
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
                onPressed: () {
                  _selezioni_menu(context);
                },
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
      children: famiglie.map((elemento) {
        return Expanded(
          flex: 1,
          child: InkWell(
            hoverColor: Color(int.parse(elemento.colore)).withAlpha(50),
            highlightColor: Color(int.parse(elemento.colore)).withAlpha(200),
            splashColor: Colors.grey.shade600,
            focusColor: Color(int.parse(elemento.colore)).withAlpha(125),
            onTap: () {
              print(elemento.descrizione);
            },
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                // color: Color(0xFF009900),
                border: Border(
                  top: BorderSide(
                    color: Color(int.parse(elemento.colore)),
                    width: 5,
                  ),
                  bottom: BorderSide(
                    color: Color(int.parse(elemento.colore)),
                    width: 5,
                  ),
                ),
              ),
              child: Text(elemento.abbreviazione,
                textAlign: TextAlign.center,
                style: TextStyle(
                  // color: Colors.white,
                ),),
            ),
          ),
        );
      }).toList(),
    );
  }

// riga lista
  Widget ListaWidget(List<CatalogoModel> articoli_lista) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) =>
            Divider(
              height: 5,
              thickness: 2,
              color: Theme
                  .of(context)
                  .primaryColor,
            ),
        itemCount: articoli_lista.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              listaClick(context);
            },
            child: Container(
              height: 40,
              // decoration: MyBoxDecoration().MyBox(),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 10,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      // "${articoli_lista[index].nome}"
                    ),
                  ),
                  Container(
                    width: 40,
                    decoration: BoxDecoration(
                      border: MyBorder().MyBorderOrange(),
                      image: DecorationImage(
                        image: AssetImage("assets/immagini/splash_screen.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment(-1.0, 0.0),
                      padding: EdgeInsets.all(5.0),
                      decoration: MyBoxDecoration().MyBox(),
                      child: Text(
                        "${articoli_lista[index].nome}",
                        style: TextStyle(
                            fontSize: 15.0, overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: MyBorder().MyBorderOrange(),
                      image: DecorationImage(
                        image: AssetImage("assets/immagini/splash_screen.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: MyBorder().MyBorderOrange(),
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
        },
      ),
    );
  }
}
