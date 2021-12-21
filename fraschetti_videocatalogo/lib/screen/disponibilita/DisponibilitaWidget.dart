
import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/models/codiceModel.dart';

WidgetBuilder DisponibilitaDialogWidget({required CodiceModel codice_scheda, dynamic returnValue}) {
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
                Container(
                  // Articolo codice
                  width: 120,
                  padding: EdgeInsets.all(5),
                  child: TextFormField(
                    // readOnly: true,
                    enabled: false,
                    initialValue: codice_scheda.numero,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                      border: OutlineInputBorder(),
                      labelText: "Articolo codice",
                    ),
                  ),
                ),
              ],
            ),
            Container(
              // codic e descrizione
              padding: EdgeInsets.all(5),
              child: TextFormField(
                // readOnly: true,
                keyboardType: TextInputType.multiline,
                minLines: 2,
                maxLines: 2,
                enabled: false,
                initialValue: codice_scheda.descrizione,
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

