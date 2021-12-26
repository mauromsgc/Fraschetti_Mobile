
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
  int promozione_id = 0;
  String famiglie_descrizione = "";
  String famiglie_colore = "";
  String immagine = "";
  String immagine_preview = "";
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
    this.promozione_id = 0,
    this.famiglie_descrizione = "",
    this.famiglie_colore = "",
    this.immagine = "",
    this.immagine_preview = "",
    // this.codici,
  });

  factory CatalogoModel.fromMap_con_lista(Map<String, dynamic> map) {
    CatalogoModel oggetto;

    final id = map["id"];
    final nome = map["nome"];
    final descrizione = map["descrizione"];
    final famiglia = map["famiglia"];
    final nuovo = map["nuovo"];
    final sospeso = map["sospeso"];
    final ordinatore = map["ordinatore"];
    final primo_codice = map["primo_codice"];
    final promozione_id = map["promozione_id"];
    final famiglie_descrizione = map["famiglie_descrizione"];
    final famiglie_colore = map["famiglie_colore"];
    final immagine = map["immagine"];
    final immagine_preview = map["immagine_preview"];

    oggetto = CatalogoModel(
      id: id,
      nome: nome,
      descrizione: descrizione,
      famiglia: famiglia,
      nuovo: nuovo,
      sospeso: sospeso,
      ordinatore: ordinatore,
      primo_codice: primo_codice,
      promozione_id: promozione_id,
      famiglie_descrizione: famiglie_descrizione,
      famiglie_colore: famiglie_colore,
      immagine: immagine,
      immagine_preview: immagine_preview,
    );

    return oggetto;
  }

  // factory CatalogoModel.fromMap(Map<String, dynamic> map) {
  //   final id = map["id"];
  //   final nome = map["nome"];
  //   final descrizione = map["descrizione"];
  //   final famiglia = map["famiglia"];
  //   final nuovo = map["nuovo"];
  //   final sospeso = map["sospeso"];
  //   final ordinatore = map["ordinatore"];
  //   final primo_codice = map["primo_codice"];
  //
  //   return CatalogoModel(
  //     id: id,
  //     nome: nome,
  //     descrizione: descrizione,
  //     famiglia: famiglia,
  //     nuovo: nuovo,
  //     sospeso: sospeso,
  //     ordinatore: ordinatore,
  //     primo_codice: primo_codice,
  //   );
  // }
  //
  // Map<String, dynamic> toMap() => {
  //       "id": id,
  //       "nome": nome,
  //       "descrizione": descrizione,
  //       "famiglia": famiglia,
  //       "nuovo": nuovo,
  //       "sospeso": sospeso,
  //       "ordinatore": ordinatore,
  //       "primo_codice": primo_codice,
  //     };

  static Future<List<Map>> catalogo_lista({
    String descrizione = "",
    String codice = "",
    int famiglia_id = 0,
    int assortimento_id = 0,
    int promozione_id = 0,
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
    ifnull(promozioni_codici.promozione_id, 0) as promozione_id,
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
      sql_where.add(" codici.numero LIKE '${codice}%' ");
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
    if (promozione_id != 0) {
      sql_where.add(" promozioni_codici.promozione_id = ${promozione_id} ");
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
          // il join per promozioni_codici c'è già per la proprietà promozione_id della lista
          sql_where.add(" promozione_id > 0 ");
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

  static Future<CatalogoModel> scheda_form_id({
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
    ifnull(promozioni_codici.promozione_id, 0) as promozione_id,
    famiglie.descrizione as famiglie_descrizione,
    famiglie.colore as famiglie_colore,
    ifnull(catalogo_img.immagine, '') as immagine,
    ifnull(catalogo_img.immagine_preview, '') as immagine_preview
    FROM catalogo
    LEFT JOIN famiglie ON famiglie.id = catalogo.famiglia
    LEFT JOIN catalogo_img ON catalogo_img.catalogo_id = catalogo.id
    LEFT JOIN promozioni_codici ON promozioni_codici.catalogo_id = catalogo.id 
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
      catalogo_cheda = CatalogoModel.fromMap_con_lista(rows.first);
      print("cat mod 1");
      catalogo_cheda.codici = await CodiceModel.codici_lista(catalogo_id: catalogo_cheda.id);
      print("cat mod 2");
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
