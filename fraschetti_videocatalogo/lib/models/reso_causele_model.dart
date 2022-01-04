import 'package:flutter/foundation.dart';
import 'package:fraschetti_videocatalogo/helper/DBHelper.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class ResoCausaleModel {

  int id = 0;
  int codice = 0;
  String descrizione = "";
  int sospeso = 0;

  ResoCausaleModel({
    this.id = 0,
    this.codice = 0,
    this.descrizione = "",
    this.sospeso = 0,
  });

  factory ResoCausaleModel.fromMap(Map<String, dynamic> map) {
    ResoCausaleModel oggetto = ResoCausaleModel();

    oggetto.id = map["id"];
    oggetto.codice = map["codice"];
    oggetto.descrizione = map["descrizione"];
    oggetto.sospeso = map["sospeso"];

    return oggetto;
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "codice": codice,
    "descrizione": descrizione,
    "sospeso": sospeso,
  };

  static Future<List<ResoCausaleModel>> reso_causali_lista() async {
    Database db = GetIt.instance<DbRepository>().database;
    final rows = await db.query("resi_causali");
    return rows.map((row) => ResoCausaleModel.fromMap(row)).toList();
  }

}
