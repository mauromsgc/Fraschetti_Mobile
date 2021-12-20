import 'package:flutter/foundation.dart';
import 'package:fraschetti_videocatalogo/helper/DBHelper.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class AssortimentoModel {
  int id = 0;
  String descrizione = "";
  int ordinatore = 0;

  // il costruttore con tutti i parametri lo uso solo per creare i record fake
  AssortimentoModel({
    this.id = 0,
    this.descrizione = "",
    this.ordinatore = 0,
  });

  factory AssortimentoModel.fromMap(Map<String, dynamic> map) {
    final id = map["id"];
    final descrizione = map["descrizione"];
    final ordinatore = map["ordinatore"];

    return AssortimentoModel(
      id: id,
      descrizione: descrizione,
      ordinatore: ordinatore,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "descrizione": descrizione,
        "ordinatore": ordinatore,
      };

static  Future<List<AssortimentoModel>> assortimenti_lista() async {
  Database db = GetIt.instance<DbRepository>().database;
  final rows = await db.query("assortimenti");
    return rows.map((row) => AssortimentoModel.fromMap(row)).toList();
  }

}
