
import 'package:fraschetti_videocatalogo/models/codiceModel.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class CatalogoModel {
  int id = 0;
  String nome = "";
  String descrizione = "";
  int famiglia = 0;
  int nuovo = 0;
  int sospeso = 0;
  int ordinatore = 0;
  int primo_codice = 0;
  int promozioni_id = 0;
  String famiglie_descrizione = "";
  String famiglie_colore = "";
  String immagine = "";
  String immagine_preview = "";
  int scheda_tecnica_id = 0;
  int scheda_sicurezza_id = 0;
  List<CodiceModel> codici = [];

  CatalogoModel({
    this.id = 0,
    this.nome = "",
    this.descrizione = "",
    this.famiglia = 0,
    this.nuovo = 0,
    this.sospeso = 0,
    this.ordinatore = 0,
    this.primo_codice = 0,
    this.promozioni_id = 0,
    this.famiglie_descrizione = "",
    this.famiglie_colore = "",
    this.immagine = "",
    this.immagine_preview = "",
    this.scheda_tecnica_id = 0,
    this.scheda_sicurezza_id = 0,
    // this.codici,
  });

  factory CatalogoModel.fromMap(Map<String, dynamic> map) {
    CatalogoModel oggetto = CatalogoModel();

    oggetto.id = map["id"];
    oggetto.nome = map["nome"];
    oggetto.descrizione = map["descrizione"];
    oggetto.famiglia = map["famiglia"];
    oggetto.nuovo = map["nuovo"];
    oggetto.sospeso = map["sospeso"];
    oggetto.ordinatore = map["ordinatore"];
    oggetto.primo_codice = map["primo_codice"];
    oggetto.promozioni_id = map["promozioni_id"];
    oggetto.famiglie_descrizione = map["famiglie_descrizione"];
    oggetto.famiglie_colore = map["famiglie_colore"];
    oggetto.immagine = map["immagine"];
    oggetto.immagine_preview = map["immagine_preview"];
    oggetto.scheda_tecnica_id = map["scheda_tecnica_id"];
    oggetto.scheda_sicurezza_id = map["scheda_sicurezza_id"];

    return oggetto;
  }


  static Future<List<Map>> catalogo_lista({
    String descrizione = "",
    String codice = "",
    String codice_ean = "",
    int famiglia_id = 0,
    int assortimento_id = 0,
    int promozioni_id = 0,
    String selezione = "",
    String ordinamento_campo = "",
    String ordinamento_verso = "",
  }) async {
    List<Map> catalogo_lista = [];

    Database db = GetIt.instance<DbRepository>().database;
    String sql_eseguire = """SELECT DISTINCT 
    catalogo.id,
    catalogo.nome,
    catalogo.nuovo,
    catalogo.sospeso,
    catalogo.ordinatore,
    famiglie.colore as famiglie_colore,
    ifnull(promozioni_codici.promozioni_id, 0) as promozioni_id,
    ifnull(catalogo_img.immagine_preview, '') as immagine_preview
    FROM catalogo
    LEFT JOIN famiglie ON famiglie.id = catalogo.famiglia
    LEFT JOIN catalogo_img ON catalogo_img.catalogo_id = catalogo.id
    LEFT JOIN promozioni_codici ON promozioni_codici.catalogo_id = catalogo.id 
    """;

    List<String> sql_join = [];
    List<String> sql_where = [];
    List<String> sql_ordinamenti = [];

    if (descrizione != "") {
      String sql_descrizione = "";
      descrizione.split(" ").forEach((String element) {
        sql_descrizione += (sql_descrizione == "") ? "(" : " AND ";
        sql_descrizione += " catalogo.nome LIKE '%${element}%' ";
      });
      sql_descrizione += ")";
      sql_where.add(sql_descrizione);
    }
    if (codice != "") {
      sql_join.add(" LEFT JOIN codici ON codici.catalogo_id = catalogo.id ");
      if(codice.length == 6 ){
        sql_where.add(" codici.numero = '${codice}' ");
      } else {
        sql_where.add(" codici.numero LIKE '${codice}%' ");
      }
    }

    if (codice_ean != "") {
      sql_join.add(" LEFT JOIN codici ON codici.catalogo_id = catalogo.id ");
      sql_join.add(" LEFT JOIN codice_ean ON codice_ean.codice_articolo = codici.numero ");
      sql_where.add(" codice_ean.codice_ean LIKE '%${codice_ean}%' ");
    }

    if (famiglia_id != 0) {
      sql_where.add(" famiglie.id = ${famiglia_id} ");
    }
    if (assortimento_id != 0) {
      sql_join.add(
          " LEFT JOIN assortimenti_codici ON assortimenti_codici.catalogo_id = catalogo.id ");
      sql_join.add(
          " LEFT JOIN assortimenti ON assortimenti.id = assortimenti_codici.assortimenti_id ");
      sql_where.add(" assortimenti.id = ${assortimento_id} ");
    }
    if (promozioni_id != 0) {
      sql_where.add(" promozioni_codici.promozioni_id = ${promozioni_id} ");
    }
    if (selezione != "") {
      switch (selezione) {
        case 'tutto':
          sql_where.add(" catalogo.id > 0 ");
          break;
        case 'novita':
          sql_where.add(" catalogo.nuovo > 0 ");
          break;
        case 'nuovi_codici':
          sql_join
              .add(" LEFT JOIN codici ON codici.catalogo_id = catalogo.id ");
          sql_where.add(" codici.nuovo > 0 ");
          break;
        case 'in_offerta':
          // il join per promozioni_codici c'è già per la proprietà promozioni_id della lista
          sql_where.add(" promozioni_id > 0 ");
          break;
      }
    }

    sql_ordinamenti.add(" catalogo.nome ASC ");

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

    catalogo_lista = rows;

    return catalogo_lista;
  }

  static Future<CatalogoModel> cerca_id({
    int id = 0,
  }) async {
    CatalogoModel catalogo_cheda;

    Database db = GetIt.instance<DbRepository>().database;
    String sql_eseguire = """SELECT DISTINCT 
    catalogo.id,
    catalogo.nome,
    catalogo.descrizione,
    catalogo.famiglia,
    catalogo.nuovo,
    catalogo.sospeso,
    catalogo.ordinatore,
    catalogo.primo_codice,
    ifnull(promozioni_codici.promozioni_id, 0) as promozioni_id,
    famiglie.descrizione as famiglie_descrizione,
    famiglie.colore as famiglie_colore,
    ifnull(catalogo_img.immagine, '') as immagine,
    ifnull(catalogo_img.immagine_preview, '') as immagine_preview,
    ifnull(schede_tecnica.id, 0) as scheda_tecnica_id,
    ifnull(schede_sicurezza.id, 0) as scheda_sicurezza_id
    FROM catalogo
    LEFT JOIN famiglie ON famiglie.id = catalogo.famiglia
    LEFT JOIN catalogo_img ON catalogo_img.catalogo_id = catalogo.id
    LEFT JOIN promozioni_codici ON promozioni_codici.catalogo_id = catalogo.id 
    LEFT JOIN schede AS schede_tecnica ON schede_tecnica.catalogo_id = catalogo.id AND schede_tecnica.tipo = "tecnica"
    LEFT JOIN schede AS schede_sicurezza ON schede_sicurezza.catalogo_id = catalogo.id AND schede_sicurezza.tipo = "sicurezza"
    """;

    List<String> sql_join = [];
    List<String> sql_where = [];
    List<String> sql_ordinamenti = [];

    if (id != 0) {
      sql_where.add(" catalogo.id = ${id} ");
    }

    sql_ordinamenti.add(" catalogo.nome ASC ");

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

    if (rows.length > 0) {
      catalogo_cheda = CatalogoModel.fromMap(rows.first);
      catalogo_cheda.codici = await CodiceModel.codici_cerca(catalogo_id: catalogo_cheda.id);
    } else {
      catalogo_cheda = CatalogoModel();
    }

    return catalogo_cheda;
  }

  static Future<List<Map>> immagini_mancanti() async {
    List<Map> catalogo_id = [];

    Database db = GetIt.instance<DbRepository>().database;
    String sql_eseguire = """SELECT DISTINCT 
    catalogo.id
    FROM catalogo
    WHERE catalogo.id NOT IN (SELECT catalogo_img.catalogo_id FROM catalogo_img)
    ;""";

    // print(sql_eseguire);

    final rows = await db.rawQuery(sql_eseguire);

    catalogo_id = rows;

    return catalogo_id;
  }

}
