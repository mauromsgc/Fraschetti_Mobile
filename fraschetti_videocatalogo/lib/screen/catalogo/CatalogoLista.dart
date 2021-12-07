import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/models/famigliaModel.dart';
import 'package:fraschetti_videocatalogo/repositories/famiglieRepository.dart';
import 'package:fraschetti_videocatalogo/repositories/articoliRepository.dart';
import 'package:fraschetti_videocatalogo/models/catalogoModel.dart';
import 'package:fraschetti_videocatalogo/screen/auth/LoginPage.dart';

import 'CatalogoPage.dart';

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

  List<ListItem> _assortimento_lista = [
    ListItem(1, "assortimento 1"),
    ListItem(2, "assortimento 2"),
    ListItem(3, "assortimento 3"),
    ListItem(4, "assortimento 4")
  ];
  String _assortimento_selezionato = "assortimento 1";
  String _assortimento_descrizione = "Assortimenti";

  // List<String> _selezione_lista = [
  //   'selezione 1',
  //   'selezione 2',
  //   'selezione 3',
  //   'selezione 4'
  // ];
  String _selezione_selezionato = "selezione 1";

  void listaClick(BuildContext context) {
    Navigator.pushNamed(context, CatalogoPage.routeName);
  }

  @override
  void initState() {
    super.initState();
  }


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
                CategorieWidget_2(),
                // CategorieWidget(),
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
                onPressed: () {},
                child: Text('Assortimenti'),
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            //   // decoration: BoxDecoration(
            //   //     borderRadius: BorderRadius.circular(10.0),
            //   //     color: Colors.cyan,
            //   //     border: Border.all()),
            //   // child: DropdownButtonHideUnderline(
            //     child: DropdownButton(
            //         // value: _assortimento_descrizione,
            //         // items: _assortimento_lista.map((elemento) {
            //         //   return DropdownMenuItem(
            //         //     child: Text(elemento.valore),
            //         //     value: elemento.codice,
            //         //   );
            //         // }).toList(),
            //
            //         items: [
            //           DropdownMenuItem(
            //             child: Text("First Item"),
            //             value: 1,
            //           ),
            //           DropdownMenuItem(
            //             child: Text("Second Item"),
            //             value: 2,
            //           ),
            //           DropdownMenuItem(
            //               child: Text("Third Item"),
            //               value: 3
            //           ),
            //           DropdownMenuItem(
            //               child: Text("Fourth Item"),
            //               value: 4
            //           )
            //         ],
            //
            //         onChanged: (value) {
            //           setState(() {
            //             // _assortimento_selezionato = value.toString();
            //           });
            //         }
            //       ),
            //   // ),
            // ),
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



// sezione categorie
  Widget CategorieWidget_2() {
    return Row(
      children: famiglie.map((elemento) {
      return Expanded(
        flex: 1,
        child: InkWell(
          hoverColor: Color(int.parse(elemento.colore)).withAlpha(50),
          highlightColor: Color(int.parse(elemento.colore)).withAlpha(200),
          splashColor:  Colors.grey.shade600,
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


        // Expanded(
        //       flex: 1,
        //       child: ElevatedButton(
        //         style: ElevatedButton.styleFrom(
        //           textStyle: TextStyle(
        //             fontSize: 10.0, // insert your font size here
        //           ),
        //           primary: Color(0xFF009900),
        //           elevation: 2,
        //           shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.all(
        //                 Radius.circular(0),
        //               ),
        //           ),
        //         ),
        //         onPressed: () {},
        //         child: Text(elemento.abbreviazione),
        //       ),
        //     );
    }).toList(),


      // children: <Widget>[
      //   Expanded(
      //     flex: 1,
      //     child: ElevatedButton(
      //       style: ElevatedButton.styleFrom(
      //         textStyle: TextStyle(
      //           fontSize: 10.0, // insert your font size here
      //         ),
      //         primary: Colors.red,
      //         elevation: 2,
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.all(Radius.circular(0))),
      //       ),
      //       onPressed: () {},
      //       child: Text('Edilizia'),
      //     ),
      //   ),
      //   Expanded(
      //     flex: 1,
      //     child: ElevatedButton(
      //       style: ElevatedButton.styleFrom(
      //         textStyle: TextStyle(
      //           fontSize: 10.0, // insert your font size here
      //         ),
      //         primary: Colors.red,
      //         elevation: 2,
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.all(Radius.circular(0))),
      //       ),
      //       onPressed: () {},
      //       child: Text('Ut. mano'),
      //     ),
      //   ),
      //   Expanded(
      //     flex: 1,
      //     child: ElevatedButton(
      //       style: ElevatedButton.styleFrom(
      //         textStyle: TextStyle(
      //           fontSize: 10.0, // insert your font size here
      //         ),
      //         primary: Colors.red,
      //         elevation: 2,
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.all(Radius.circular(0))),
      //       ),
      //       onPressed: () {},
      //       child: Text('Ferram.'),
      //     ),
      //   ),
      //   Expanded(
      //     flex: 1,
      //     child: ElevatedButton(
      //       style: ElevatedButton.styleFrom(
      //         textStyle: TextStyle(
      //           fontSize: 10.0, // insert your font size here
      //         ),
      //         primary: Colors.red,
      //         elevation: 2,
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.all(Radius.circular(0))),
      //       ),
      //       onPressed: () {},
      //       child: Text('Giardin.'),
      //     ),
      //   ),
      //   Expanded(
      //     flex: 1,
      //     child: ElevatedButton(
      //       style: ElevatedButton.styleFrom(
      //         textStyle: TextStyle(
      //           fontSize: 10.0, // insert your font size here
      //         ),
      //         primary: Colors.red,
      //         elevation: 2,
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.all(Radius.circular(0))),
      //       ),
      //       onPressed: () {},
      //       child: Text('Ut. elet.'),
      //     ),
      //   ),
      //   Expanded(
      //     flex: 1,
      //     child: ElevatedButton(
      //       style: ElevatedButton.styleFrom(
      //         textStyle: TextStyle(
      //           fontSize: 10.0, // insert your font size here
      //         ),
      //         primary: Colors.red,
      //         elevation: 2,
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.all(Radius.circular(0))),
      //       ),
      //       onPressed: () {},
      //       child: Text('Idraulica'),
      //     ),
      //   ),
      //   Expanded(
      //     flex: 1,
      //     child: ElevatedButton(
      //       style: ElevatedButton.styleFrom(
      //         textStyle: TextStyle(
      //           fontSize: 10.0, // insert your font size here
      //         ),
      //         primary: Colors.red,
      //         elevation: 2,
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.all(Radius.circular(0))),
      //       ),
      //       onPressed: () {},
      //       child: Text('Siderurg.'),
      //     ),
      //   ),
      //   Expanded(
      //     flex: 1,
      //     child: ElevatedButton(
      //       style: ElevatedButton.styleFrom(
      //         textStyle: TextStyle(
      //           fontSize: 10.0, // insert your font size here
      //         ),
      //         primary: Colors.red,
      //         elevation: 2,
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.all(Radius.circular(0))),
      //       ),
      //       onPressed: () {},
      //       child: Text('Domo ut.'),
      //     ),
      //   ),
      // ],
    );
  }

// riga lista
  Widget ListaWidget(List<CatalogoModel> articoli_lista) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          height: 5,
          thickness: 2,
          color: Theme.of(context).primaryColor,
        ),
        itemCount: articoli_lista.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              listaClick(context);
            },
            child: Container(
              height: 40,
              // decoration: BoxDecoration(
              //   border: Border.all(
              //     color: Colors.orange,
              //     width: 2,
              //   ),
              // ),
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
                      alignment: Alignment(-1.0, 0.0),
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
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
        },
      ),
    );
  }
}
