import 'package:flutter/foundation.dart';
import 'package:fraschetti_videocatalogo/models/utenteCorrenteModel.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class CodiceModel {
  int id = 0;
  int catalogo_id = 0;
  String catalogo_nome = "";
  String numero = "";
  String descrizione = "";
  int apribile = 0;
  int nuovo = 0;
  int sospeso = 0;
  double pezzi = 0;
  double prezzo = 0;
  String um = "";
  int iva = 0;
  String spedizione_categoria_codice = "";
  int quantita_massima = 0;
  String codice_ean = "";
  int disponibilita_stato = 0;
  String disponibilita_data_arrivo = "";
  int promozioni_id = 0;
  String immagine_preview = "";

  CodiceModel({
    this.id = 0,
    this.catalogo_id = 0,
    this.catalogo_nome = "",
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
    this.promozioni_id = 0,
    this.immagine_preview = "",
  });

  factory CodiceModel.fromMap(Map<String, dynamic> map) {
    // print("CodiceModel.fromMap inizio");
    CodiceModel oggetto = CodiceModel();

    oggetto.id = map["id"];
    oggetto.catalogo_id = map["catalogo_id"];
    oggetto.catalogo_nome = map["catalogo_nome"];
    oggetto.numero = map["numero"];
    oggetto.descrizione = map["descrizione"];
    oggetto.apribile = map["apribile"];
    oggetto.nuovo = map["nuovo"];
    oggetto.sospeso = map["sospeso"];
    oggetto.pezzi = map["pezzi"];
    oggetto.prezzo = map["prezzo"];
    oggetto.um = map["um"];
    oggetto.iva = map["iva"];
    oggetto.spedizione_categoria_codice = map["spedizione_categoria_codice"];
    oggetto.quantita_massima = map["quantita_massima"];
    oggetto.codice_ean = map["codice_ean"];
    oggetto.disponibilita_stato = map["disponibilita_stato"];
    oggetto.disponibilita_data_arrivo = map["disponibilita_data_arrivo"];
    oggetto.promozioni_id = map["promozioni_id"];
    oggetto.immagine_preview = map["immagine_preview"];

    // print("CodiceModel.fromMap fine");
    return oggetto;
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "catalogo_id": catalogo_id,
        "catalogo_nome": catalogo_nome,
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
        "immagine_preview": immagine_preview,
        "promozioni_id": promozioni_id,
      };

  String get disponibilita_stato_testo {
    String disponibilita_stato_testo = "";

    switch (this.disponibilita_stato) {
      case 1:
        disponibilita_stato_testo = "disponibile";
        // data non presente lo svuoto per sicurezza
        this.disponibilita_data_arrivo = "";
        break;
      case 2:
        disponibilita_stato_testo = "non disponibile";
        // la data è presente non la svuoto
        // this.disponibilita_data_arrivo = "";
        break;
      case 3:
        disponibilita_stato_testo = "non disponibile";
        // data non presente mostro "data da comunicare"
        this.disponibilita_data_arrivo = "data da comunicare";
        break;
      default:
        // svuoro tutto
        disponibilita_stato_testo = "";
        this.disponibilita_data_arrivo = "";
        break;
    }

    return disponibilita_stato_testo;
  }

  static Future<List<CodiceModel>> codici_cerca({
    int id = 0,
    int codice_id = 0,
    int catalogo_id = 0,
    String descrizione = "",
    String codice = "",
    String codice_ean = "",
    bool sospesi_inclusi = false,
  }) async {
    print("codici_cerca inizio");
    List<CodiceModel> codici_lista = [];

    Database db = GetIt.instance<DbRepository>().database;
    String sql_eseguire = """SELECT DISTINCT
    codici.id,
    codici.catalogo_id,
    catalogo.nome as catalogo_nome,
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
    ifnull(disponibilita.data_arrivo, '') as disponibilita_data_arrivo,
    ifnull(promozioni_codici.promozioni_id, 0) as promozioni_id,
    ifnull(catalogo_img.immagine_preview, '') as immagine_preview
    FROM codici
    LEFT JOIN catalogo ON catalogo.id = codici.catalogo_id
    LEFT JOIN catalogo_img ON catalogo_img.catalogo_id = codici.catalogo_id
    LEFT JOIN codici_ean ON codici_ean.codice_articolo = codici.numero
    LEFT JOIN disponibilita ON disponibilita.codice = codici.numero
    LEFT JOIN promozioni_codici ON promozioni_codici.catalogo_id = codici.catalogo_id
    """;

    List<String> sql_join = [];
    List<String> sql_where = [];
    List<String> sql_ordinamenti = [];

    if ((GetIt.instance<UtenteCorrenteModel>().sospesi_mostra == 0) && (sospesi_inclusi == false)) {
      sql_where.add(" codici.sospeso = 0 ");
    }

    if (id != 0) {
      sql_where.add(" codici.id = ${id} ");
    }
    if (catalogo_id != 0) {
      sql_where.add(" codici.catalogo_id = ${catalogo_id} ");
    }
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
      if(codice.length == 6 ){
        sql_where.add(" codici.numero = '${codice}' ");
      } else {
        sql_where.add(" codici.numero LIKE '${codice}%' ");
      }
    }

    if (codice_ean != "") {
      sql_join.add(
          " LEFT JOIN codice_ean ON codice_ean.codice_articolo = codici.numero ");
      sql_where.add(" codice_ean.codice_ean LIKE '%${codice_ean}%' ");
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
    // print(sql_eseguire);

    final rows = await db.rawQuery(sql_eseguire);

    codici_lista = rows.map((row) => CodiceModel.fromMap(row)).toList();

    print("codici_cerca fine");
    return codici_lista;
  }

  static Future<CodiceModel> codici_cerca_singolo({
    int id = 0,
    int codice_id = 0,
    int catalogo_id = 0,
    String descrizione = "",
    String codice = "",
    String codice_ean = "",
    bool sospesi_inclusi = false,
  }) async {
    print("codici_cerca_singolo inizio");
    // cerca un record esistente
    // e restituisce l'oggetto relativo al record
    CodiceModel codice_scheda;

    List<CodiceModel> codici_lista = await CodiceModel.codici_cerca(
      id: id,
      codice_id: codice_id,
      catalogo_id: catalogo_id,
      descrizione: descrizione,
      codice: codice,
      codice_ean: codice_ean,
        sospesi_inclusi: sospesi_inclusi,
    );

    if (codici_lista.length > 0) {
      codice_scheda = codici_lista.first;
    } else {
      // oppure errore
      codice_scheda = CodiceModel();
    }
    print("codici_cerca_singolo fine");

    return codice_scheda;
  }
}
