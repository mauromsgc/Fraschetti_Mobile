import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/models/catalogoModel.dart';
import 'package:fraschetti_videocatalogo/screen/catalogo/CatalogoPage.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';

class TrasmissionePage extends StatefulWidget {
  TrasmissionePage({Key? key}) : super(key: key);
  static const String routeName = 'trasmissione_page';
  final String pagina_titolo = "Trasmissione";

  @override
  _TrasmissionePageState createState() => _TrasmissionePageState();
}

class _TrasmissionePageState extends State<TrasmissionePage> {
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
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        // unità di misura
                        width: 120,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          // readOnly: true,
                          textAlign: TextAlign.end,
                          enabled: false,
                          initialValue: "0000",
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "Invio id",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          // unità di misura
                          padding: EdgeInsets.all(5),
                          child: TextFormField(
                            // readOnly: true,
                            textAlign: TextAlign.end,
                            enabled: false,
                            initialValue: "0000000",
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                              border: OutlineInputBorder(),
                              labelText: "Codice di trasmissione",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        // fattura numero
                        width: 130,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          textAlign: TextAlign.end,
                          enabled: false,
                          initialValue: "00/00/0000",
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "Invio data",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        // fattura data
                        width: 100,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          textAlign: TextAlign.end,
                          enabled: false,
                          initialValue: "00:00:00",
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "Invio ora",
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        // unità di misura
                        width: 100,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          // readOnly: true,
                          textAlign: TextAlign.end,
                          enabled: false,
                          initialValue: "000",
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding:
                            EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "Num. ordini",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        // unità di misura
                        width: 100,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          // readOnly: true,
                          textAlign: TextAlign.end,
                          enabled: false,
                          initialValue: "000",
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "Num. resi",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        // unità di misura
                        width: 100,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          // readOnly: true,
                          textAlign: TextAlign.end,
                          enabled: false,
                          initialValue: "000",
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding:
                            EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "num. clienti",
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        // unità di misura
                        width: 100,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          // readOnly: true,
                          textAlign: TextAlign.end,
                          enabled: false,
                          initialValue: "000",
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding:
                            EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "Num. note",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        // unità di misura
                        width: 100,
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          // readOnly: true,
                          textAlign: TextAlign.end,
                          enabled: false,
                          initialValue: "0000",
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding:
                            EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                            border: OutlineInputBorder(),
                            labelText: "Num. linee",
                          ),
                        ),
                      ),

                    ],
                  ),
                  Container(
                    // dettaglio ordine
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 15,
                      maxLines: null,
                      enabled: false,
                      initialValue: "0000\n0000\n0000",
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        // contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        labelText: "Dettaglio righe ordine",
                      ),
                    ),
                  ),                  Container(
                    // dettaglio note
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 5,
                      maxLines: null,
                      enabled: false,
                      initialValue: "0000\n0000\n0000",
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        // contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        labelText: "Dettaglio note",
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

// dati promozione
  Widget ComunicazopneWidget() {
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
                    "Comunicazione Comunicazione Comunicazione",
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
                  decoration: MyBoxDecoration().MyBox(),
                  child: Image.asset("assets/immagini/logo_512_512.png"),
                ),
              ),
              SizedBox(width: 5),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Expanded(
              //   child: Container(
              //     padding: EdgeInsets.all(5),
              //     child:
              //   ),
              // ),
              Text(
                "ID",
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 5),
              Text(
                "000000",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 10),
              Text(
                "Data",
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 5),
              Text(
                "00/00/0000",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 5),
            ],
          ),
        ],
      ),
    );
  }
}
