import 'package:flutter/foundation.dart';
import 'package:fraschetti_videocatalogo/helper/DBHelper.dart';
import 'package:fraschetti_videocatalogo/models/promozione_codiceModel.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class PromozioneModel {
  int id = 0;
  String nome = "";
  String sconto = "";
  String permanente = "";
  String tour = "";
  int ordinatore = 0;
  List<PromozioneCodiceModel> codici = [];

  // il costruttore con tutti i parametri lo uso solo per creare i record fake
  PromozioneModel({
    this.id = 0,
    this.sconto = "",
    this.permanente = "",
    this.tour = "",
    this.ordinatore = 0,
    this.nome = "",
    // List<PromozioneCodiceModel> codici = [],
  });

  factory PromozioneModel.fromMap(Map<String, dynamic> map) {
    final id = map["id"];
    final sconto = map["sconto"];
    final permanente = map["permanente"];
    final tour = map["tour"];
    final ordinatore = map["ordinatore"];
    final nome = map["nome"];

    return PromozioneModel(
      id: id,
      sconto: sconto,
      permanente: permanente,
      tour: tour,
      ordinatore: ordinatore,
      nome: nome,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "sconto": sconto,
        "permanente": permanente,
        "tour": tour,
        "ordinatore": ordinatore,
        "nome": nome,
      };

  // poi fare il cerca
  static Future<List<Map>> promozioni_lista({
    String nome = "",
    String tour_singolo = "",
    int tour_intero = 0,
  }) async {
    List<Map> promozioni_lista = [];

    Database db = GetIt.instance<DbRepository>().database;
    String sql_eseguire = """SELECT 
    promozioni.id,
    promozioni.nome,
    promozioni.tour,
    promozioni.ordinatore,
    ifnull(promozioni_img.immagine_preview, '') as immagine_preview
    FROM promozioni
    LEFT JOIN promozioni_img ON promozioni_img.promozione_id = promozioni.id
    """;


    List<String> sql_join = [];
    List<String> sql_where = [];
    List<String> sql_ordinamenti = [];

    // per avere la lista piena
    sql_where.add(" promozioni.id > 0 ");

    if (nome != '') {
      String sql_descrizione = "";
      nome.split(" ").forEach((String element) {
        sql_descrizione +=(sql_descrizione == "") ? "(" : " AND ";
        sql_descrizione +=" promozioni.nome LIKE '%${element}%' ";
      });
      sql_descrizione +=")";
      sql_where.add(sql_descrizione);
    }
    if (tour_singolo != '') {
      sql_where.add(" promozioni.tour = '${tour_singolo}' ");
    }
    if (tour_intero == 1) {
      sql_where.add(" promozioni.id > 0 ");
    }

    sql_ordinamenti.add(" promozioni.ordinatore ASC ");

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

    promozioni_lista = rows;

    return promozioni_lista;
  }

  static Future<List<Map>> tour_offerte_lista() async {
    List<Map> tour_offerte_lista = [];

    Database db = GetIt.instance<DbRepository>().database;
    final rows = await db.rawQuery("""SELECT DISTINCT
tour
FROM promozioni
ORDER BY tour asc
    ;""");

    tour_offerte_lista = rows;

    return tour_offerte_lista;
  }
}
