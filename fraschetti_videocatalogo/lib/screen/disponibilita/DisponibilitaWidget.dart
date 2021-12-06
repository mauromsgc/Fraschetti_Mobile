
import 'package:flutter/material.dart';

WidgetBuilder DisponibilitaDialogWidget({int? codice_id, dynamic returnValue}) {
  return (BuildContext context) => AlertDialog(
      title: const Text("Disponibilità"),
      content: Column(
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
              initialValue:
                  "Codice descrizione Codice descrizione Codice descrizione Codice descrizione Codice descrizione Codice descrizione Codice descrizione",
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
              initialValue: "non disponibile",
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
      ),
      actions: <Widget>[
        ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Chiudi")),
      ],
    );
  }

