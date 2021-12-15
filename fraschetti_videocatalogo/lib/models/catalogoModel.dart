import 'package:flutter/foundation.dart';
import 'package:fraschetti_videocatalogo/models/codiceModel.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class CatalogoModel {
  int id = 0;
  String nome = '';
  String descrizione = '';
  int famiglia = 0;
  int nuovo = 0;
  int sospeso = 0;
  int ordinatore = 0;
  int primo_codice = 0;
  List<CodiceModel> codici = [];

  // il costruttore con tutti i parametri lo uso solo per creare i record fake
  CatalogoModel({
    this.id = 0,
    this.nome = '',
    this.descrizione = '',
    this.famiglia = 0,
    this.nuovo = 0,
    this.sospeso = 0,
    this.ordinatore = 0,
    this.primo_codice = 0,
    // this.codici = [],
  });

  factory CatalogoModel.fromMap(Map<String, dynamic> map) {
    final id = map["id"];
    final nome = map["nome"];
    final descrizione = map["descrizione"];
    final famiglia = map["famiglia"];
    final nuovo = map["nuovo"];
    final sospeso = map["sospeso"];
    final ordinatore = map["ordinatore"];
    final primo_codice = map["primo_codice"];

    return CatalogoModel(
      id: id,
      nome: nome,
      descrizione: descrizione,
      famiglia: famiglia,
      nuovo: nuovo,
      sospeso: sospeso,
      ordinatore: ordinatore,
      primo_codice: primo_codice,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "nome": nome,
        "descrizione": descrizione,
        "famiglia": famiglia,
        "nuovo": nuovo,
        "sospeso": sospeso,
        "ordinatore": ordinatore,
        "primo_codice": primo_codice,
      };

  // poi fare il cerca
  static Future<List<Map>> catalogo_lista() async {
    List<Map> catalogo_lista = [];

    Database db = GetIt.instance<DbRepository>().database;
    final rows = await db.rawQuery("""SELECT 
    catalogo.id,
    catalogo.nome,
    catalogo.nuovo,
    catalogo.sospeso,
    catalogo.ordinatore,
    famiglie.colore,
    ifnull(catalogo_img.immagine_preview, '') as immagine_preview
    FROM catalogo
    LEFT JOIN famiglie ON famiglie.id = catalogo.famiglia
    LEFT JOIN catalogo_img ON catalogo_img.catalogo_id = catalogo.id
    ;""");

    catalogo_lista = rows;

    return catalogo_lista;
  }
}
