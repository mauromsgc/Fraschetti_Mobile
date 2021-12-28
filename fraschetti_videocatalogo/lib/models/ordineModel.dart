import 'package:flutter/foundation.dart';
import 'package:fraschetti_videocatalogo/models/codiceModel.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class OrdineModel {
  int id = 0;
  int cliente_id = 0;
  int agente_id = 0;
  int ordini_numero = 0;
  String articolo_codice = "";
  String descrizione = "";
  String um = "";
  double quantita = 0;
  double prezzo = 0;
  double prezzo_ordine = 0;
  late CodiceModel codice_scheda;

  OrdineModel({
    this.id = 0,
    this.cliente_id = 0,
    this.agente_id = 0,
    this.ordini_numero = 0,
    this.articolo_codice = "",
    this.descrizione = "",
    this.um = "",
    this.quantita = 0,
    this.prezzo = 0,
    this.prezzo_ordine = 0,
  });

  factory OrdineModel.fromMap(Map<String, dynamic> map) {
    OrdineModel oggetto = OrdineModel();

    oggetto.id = map["id"];
    oggetto.cliente_id = map["cliente_id"];
    oggetto.agente_id = map["agente_id"];
    oggetto.ordini_numero = map["ordini_numero"];
    oggetto.articolo_codice = map["articolo_codice"];
    oggetto.descrizione = map["descrizione"];
    oggetto.um = map["um"];
    oggetto.quantita = map["quantita"];
    oggetto.prezzo = map["prezzo"];
    oggetto.prezzo_ordine = map["prezzo_ordine"];

    return oggetto;
  }

  double get prezzo_riga_totale {
    double prezzo_riga_totale = (this.quantita * this.prezzo_ordine);
    return double.parse(prezzo_riga_totale.toStringAsFixed(2));
  }

  static Future<List<OrdineModel>> ordini_lista({
    int id = 0,
    int cliente_id = 0,
    int ordini_numero = 0,
    String codice = "",
  }) async {
    List<OrdineModel> ordini_lista = [];

    Database db = GetIt
        .instance<DbRepository>()
        .database;
    String sql_eseguire = """SELECT DISTINCT 
    ordini.id, 
    ordini.cliente_id, 
    ordini.agente_id, 
    ordini.ordini_numero, 
    ordini.articolo_codice, 
    ordini.descrizione, 
    ordini.um, 
    ordini.quantita, 
    ordini.prezzo, 
    ordini.prezzo_ordine
    FROM ordini
    """;

    List<String> sql_join = [];
    List<String> sql_where = [];
    List<String> sql_ordinamenti = [];


    if (id != 0) {
      sql_where.add(" ordini.id = ${id} ");
    }
    if (cliente_id != 0) {
      sql_where.add(" ordini.cliente_id = ${cliente_id} ");
    }
    if (ordini_numero != 0) {
      sql_where.add(" ordini.ordini_numero = ${ordini_numero} ");
    }

    if (codice != "") {
      sql_where.add(" ordini.articolo_codice LIKE '${codice}%' ");
    }

    sql_ordinamenti.add(" ordini.id ASC ");

    sql_join.forEach((element) {
      sql_eseguire += element;
    });
    // il forEach per le mappe ha l'indice
    sql_where.asMap().forEach((indice, element) {
      sql_eseguire += (indice == 0) ? " WHERE " : " AND ";
      sql_eseguire += element;
    });
    sql_ordinamenti.asMap().forEach((indice, element) {
      sql_eseguire += (indice == 0) ? " ORDER BY  " : " , ";
      sql_eseguire += element;
    });
    sql_eseguire += ";";
    // print(sql_eseguire);

    final rows = await db.rawQuery(sql_eseguire);

    ordini_lista = rows.map((row) => OrdineModel.fromMap(row)).toList();

    return ordini_lista;
  }

  static Future<OrdineModel> scheda_form_id({
    int id = 0,
  }) async {
    OrdineModel ordine_scheda;

    List<OrdineModel> ordini_lista = await OrdineModel.ordini_lista(id: id);

    if (ordini_lista.length > 0) {
      ordine_scheda = ordini_lista.first;
      print("cat mod 1");
      List<CodiceModel> result = await CodiceModel.codici_lista(
          codice: ordine_scheda.articolo_codice);
      if (result.length > 0) {
        ordine_scheda.codice_scheda = result.first;
      } else {
        ordine_scheda.codice_scheda = CodiceModel();
      }
      print("cat mod 2");
    } else {
      ordine_scheda = OrdineModel();
    }

    return ordine_scheda;
  }
}
