import 'package:flutter/foundation.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class CodiceModel {
  int id = 0;
  int catalogo_id = 0;
  String numero = "";
  String descrizione = "";
  int apribile = 0;
  int nuovo = 0;
  int sospeso = 0;
  int pezzi = 0;
  double prezzo = 0;
  String um = "";
  int iva = 0;
  String spedizione_categoria_codice = "";
  int quantita_massima = 0;
  String codice_ean = "";
  int disponibilita_stato = 0;
  String disponibilita_data_arrivo = "";
  int promozione_id = 0;

  CodiceModel({
    this.id = 0,
    this.catalogo_id = 0,
    this.numero = "",
    this.descrizione = "",
    this.apribile = 0,
    this.nuovo = 0,
    this.sospeso = 0,
    this.pezzi = 0,
    this.prezzo = 0,
    this.um = "",
    this.iva = 0,
    this.spedizione_categoria_codice = "",
    this.quantita_massima = 0,
    this.codice_ean = "",
    this.disponibilita_stato = 0,
    this.disponibilita_data_arrivo = "",
    this.promozione_id = 0,
  });

  factory CodiceModel.fromMap(Map<String, dynamic> map) {
    final id = map["id"];
    final catalogo_id = map["catalogo_id"];
    final numero = map["numero"];
    final descrizione = map["descrizione"];
    final apribile = map["apribile"];
    final nuovo = map["nuovo"];
    final sospeso = map["sospeso"];
    final pezzi = map["pezzi"];
    final prezzo = map["prezzo"];
    final um = map["um"];
    final iva = map["iva"];
    final spedizione_categoria_codice = map["spedizione_categoria_codice"];
    final quantita_massima = map["quantita_massima"];
    final codice_ean = map["codice_ean"];
    final disponibilita_stato = map["disponibilita_stato"];
    final disponibilita_data_arrivo = map["disponibilita_data_arrivo"];
    final promozione_id = map["promozione_id"];

    return CodiceModel(
      id: id,
      catalogo_id: catalogo_id,
      numero: numero,
      descrizione: descrizione,
      apribile: apribile,
      nuovo: nuovo,
      sospeso: sospeso,
      pezzi: pezzi,
      prezzo: prezzo,
      um: um,
      iva: iva,
      spedizione_categoria_codice: spedizione_categoria_codice,
      quantita_massima: quantita_massima,
      codice_ean : codice_ean,
      disponibilita_stato : disponibilita_stato,
      disponibilita_data_arrivo : disponibilita_data_arrivo,
      promozione_id : promozione_id,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "catalogo_id": catalogo_id,
        "numero": numero,
        "descrizione": descrizione,
        "apribile": apribile,
        "nuovo": nuovo,
        "sospeso": sospeso,
        "pezzi": pezzi,
        "prezzo": prezzo,
        "um": um,
        "iva": iva,
        "spedizione_categoria_codice": spedizione_categoria_codice,
        "quantita_massima": quantita_massima,
        "codice_ean": codice_ean,
        "disponibilita_stato": disponibilita_stato,
        "disponibilita_data_arrivo": disponibilita_data_arrivo,
        "promozione_id": promozione_id,
      };

  static Future<List<CodiceModel>> codici_lista({
    int id = 0,
    int catalogo_id = 0,
  }) async {
    List<CodiceModel> codici_lista = [];


    Database db = GetIt.instance<DbRepository>().database;
    String sql_eseguire = """SELECT DISTINCT
    codici.id,
    codici.catalogo_id,
    codici.numero,
    codici.descrizione,
    codici.apribile,
    codici.nuovo,
    codici.sospeso,
    codici.pezzi,
    codici.prezzo,
    codici.um,
    codici.iva,
    codici.spedizione_categoria_codice,
    codici.quantita_massima,
    ifnull(codici_ean.codice_ean, '') as codice_ean,
    ifnull(disponibilita.stato, 0) as disponibilita_stato,
    ifnull(disponibilita.data_arrivo, '00/00/0000') as disponibilita_data_arrivo,
    ifnull(promozioni_codici.promozione_id, 0) as promozione_id
    FROM codici
    LEFT JOIN codici_ean ON codici_ean.codice_articolo = codici.numero
    LEFT JOIN disponibilita ON disponibilita.codice = codici.numero
    LEFT JOIN promozioni_codici ON promozioni_codici.catalogo_id = codici.catalogo_id
    """;

    List<String> sql_join = [];
    List<String> sql_where = [];
    List<String> sql_ordinamenti = [];

    if (id != 0) {
      sql_where.add(" codici.id = ${id} ");
    }
    if (catalogo_id != 0) {
      sql_where.add(" codici.catalogo_id = ${catalogo_id} ");
    }


    sql_ordinamenti.add(" codici.numero ASC ");

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

    final rows = await ( await db.rawQuery(sql_eseguire));

    codici_lista = rows.map((row) => CodiceModel.fromMap(row)).toList();

    return codici_lista;
  }
}
