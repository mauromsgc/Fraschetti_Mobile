import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/models/codiceModel.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';

WidgetBuilder DisponibilitaDialogWidget({
  int codice_id = 0,
  dynamic returnValue,
}) {
  late CodiceModel codice_scheda;

  Future<void> _codice_cerca({int id = 0}) async {
    List<CodiceModel> result;
    result = await CodiceModel.codici_lista(id: id);

    codice_scheda = result.first;
  }

  if (codice_id != 0) {
    // devo cercare il codice
    _codice_cerca(id: codice_id);
  }

  return (BuildContext context) => AlertDialog(
        title: const Text("Disponibilità"),
        content: Container(
          width: MediaQuery.of(context).size.width * 0.70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Container(
                      // width: 60,
                      // height: 40,
                      decoration: MyBoxDecoration().MyBox(),
                      child: ListaImmagineWidget(
                          immagine_base64: codice_scheda.immagine_preview),
                    ),
                  ),
                  Container(
                    // Articolo codice
                    width: 120,
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      // readOnly: true,
                      enabled: false,
                      initialValue: codice_scheda.numero,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                        border: OutlineInputBorder(),
                        labelText: "Articolo codice",
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                // codice
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  // readOnly: true,
                  enabled: false,
                  initialValue: codice_scheda.catalogo_nome,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                    border: OutlineInputBorder(),
                    labelText: "Articolo",
                  ),
                ),
              ),
              if(codice_scheda.descrizione != "")
              Container(
                // codice descrizione
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  // readOnly: true,
                  enabled: false,
                  initialValue: codice_scheda.descrizione,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
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
                  initialValue: codice_scheda.disponibilita_stato.toString(),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
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
                  initialValue: codice_scheda.disponibilita_data_arrivo,
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
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Chiudi")),
        ],
      );
}

Widget ListaImmagineWidget({dynamic immagine_base64 = ""}) {
  if ((immagine_base64 != null) && (immagine_base64 != "")) {
    return Image.memory(
      Base64Decoder().convert(immagine_base64),
    );
  } else {
    return Image.asset("assets/immagini/splash_screen.png");
  }
}
