import 'package:flutter/foundation.dart';
import 'package:fraschetti_videocatalogo/helper/DBHelper.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class ComunicazioneModel {
  int id = 0;
  String oggetto = "";
  int da_leggere = 0;
  String data = "";
  String username = "";
  String comunicazione_testo = "";
  String comunicazione_blob = "";

  // il costruttore con tutti i parametri lo uso solo per creare i record fake
  ComunicazioneModel({
    this.id = 0,
    this.oggetto = "",
    this.da_leggere = 0,
    this.data = "",
    this.username = "",
    this.comunicazione_testo = "",
    this.comunicazione_blob = "",
  });

  factory ComunicazioneModel.fromMap(Map<String, dynamic> map) {
    ComunicazioneModel oggetto = ComunicazioneModel();

    oggetto.id = map["id"];
    oggetto.oggetto = map["oggetto"];
    oggetto.da_leggere = map["da_leggere"];
    oggetto.data = map["data"];
    oggetto.username = map["username"];
    oggetto.comunicazione_testo = map["comunicazione_testo"];
    oggetto.comunicazione_blob = map["comunicazione_blob"];

    return oggetto;
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "oggetto": oggetto,
        "da_leggere": da_leggere,
        "data": data,
        "username": username,
        "comunicazione_testo": comunicazione_testo,
        "comunicazione_blob": comunicazione_blob,
      };

  static Future<List<Map>> comunicazioni_lista({
    String oggetto = "",
    int id = 0,
    String stato = "",
  }) async {
    List<Map> comunicazioni_lista = [];

    Database db = GetIt.instance<DbRepository>().database;
    String sql_eseguire = """SELECT 
    comunicazioni.id,
    comunicazioni.oggetto,
    comunicazioni.data,
    comunicazioni.da_leggere
     FROM comunicazioni
    """;

    List<String> sql_join = [];
    List<String> sql_where = [];
    List<String> sql_ordinamenti = [];

    if (oggetto != "") {
      String sql_descrizione = "";
      oggetto.split(" ").forEach((String element) {
        sql_descrizione += (sql_descrizione == "") ? "(" : " AND ";
        sql_descrizione += " comunicazioni.oggetto LIKE '%${element}%' ";
      });
      sql_descrizione += ")";
      sql_where.add(sql_descrizione);
    }
    if (id != 0) {
      sql_where.add(" comunicazioni.id = ${id} ");
    }
    if (stato == 'da_leggere') {
      sql_where.add(" comunicazioni.da_leggere = 1 ");
    }
    if (stato == 'lette') {
      sql_where.add(" comunicazioni.da_leggere = 0 ");
    }
    if (stato == 'tutte') {
      sql_where.add(" comunicazioni.id > 0 ");
    }
    // sql_ordinamenti.add(" comunicazioni.data DESC ");
    sql_ordinamenti.add(" comunicazioni.id DESC ");

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
    print(sql_eseguire);

    final rows = await db.rawQuery(sql_eseguire);

    comunicazioni_lista = rows;

    return comunicazioni_lista;
  }

  static Future<ComunicazioneModel> scheda_form_id({
    int id = 0,
  }) async {
    ComunicazioneModel comunicazione_scheda;

    Database db = GetIt.instance<DbRepository>().database;
    String sql_eseguire = """SELECT 
    comunicazioni.id,
    comunicazioni.oggetto,
    comunicazioni.da_leggere,
    comunicazioni.data,
    comunicazioni.username,
    comunicazioni.comunicazione_testo,
    comunicazioni.comunicazione_blob
     FROM comunicazioni
    """;

    List<String> sql_join = [];
    List<String> sql_where = [];
    List<String> sql_ordinamenti = [];

    if (id != 0) {
      sql_where.add(" comunicazioni.id = ${id} ");
    }


    // sql_ordinamenti.add(" comunicazioni.data DESC ");
    sql_ordinamenti.add(" comunicazioni.id DESC ");

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
    print(sql_eseguire);

    final rows = await db.rawQuery(sql_eseguire);

    if (rows.length > 0) {
      comunicazione_scheda = ComunicazioneModel.fromMap(rows.first);
      if(comunicazione_scheda.da_leggere == 1){
        comunicazione_scheda.letta_imposta();
      }
    } else {
      comunicazione_scheda = ComunicazioneModel();
    }

    return comunicazione_scheda;
  }

  Future<bool> letta_imposta() async {
    Database db = GetIt.instance<DbRepository>().database;

    int record_eleborati = 0;

    try {
      record_eleborati = await (await db.update(
          'comunicazioni', {'da_leggere': 0},
          where: 'id = ?', whereArgs: [this.id]));
    } on DatabaseException catch (errore_db) {
      if (errore_db.isNoSuchTableError()) {
        print("Errore aggiornamento comunicazioni");
      }
    }

    if (record_eleborati > 0) {

    } else {
      print("comunicazioni errore aggiornamento da_leggere");
    }

    return (record_eleborati > 0);
  }

}
