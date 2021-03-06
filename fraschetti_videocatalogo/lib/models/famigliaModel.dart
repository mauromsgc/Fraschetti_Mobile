import 'package:flutter/foundation.dart';
import 'package:fraschetti_videocatalogo/helper/DBHelper.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class FamigliaModel {
  // il costruttore con tutti i parametri lo uso solo per creare i record fake
  FamigliaModel({
    this.id = 0,
    this.codice = 0,
    this.descrizione = "",
    this.colore = "",
    this.abbreviazione = "",
  });

  int id = 0;
  int codice = 0;
  String descrizione = "";
  String colore = "";
  String abbreviazione = "";

  factory FamigliaModel.fromMap(Map<String, dynamic> map) {
    FamigliaModel oggetto = FamigliaModel();

    oggetto.id = map["id"];
    oggetto.codice = map["codice"];
    oggetto.descrizione = map["descrizione"];
    oggetto.colore = map["colore"];
    oggetto.abbreviazione = map["abbreviazione"];

    return oggetto;
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "codice": codice,
    "descrizione": descrizione,
    "colore": colore,
    "abbreviazione": abbreviazione,
  };

  static Future<List<FamigliaModel>> famiglie_lista() async {
    Database db = GetIt.instance<DbRepository>().database;
    final rows = await db.query("famiglie");
    return rows.map((row) => FamigliaModel.fromMap(row)).toList();
  }

}
