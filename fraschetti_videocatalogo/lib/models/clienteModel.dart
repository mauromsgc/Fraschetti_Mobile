import 'package:flutter/foundation.dart';
import 'package:fraschetti_videocatalogo/helper/DBHelper.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class ClienteModel {

  int id = 0;
  int agenti_id = 0;
  String ragione_sociale = "";
  String localita = "";
  String indirizzo = "";
  String username = "";
  String sede = "";
  String codice = "";
  int stato = 0;
  int videocatalogo_disattivato = 0;
  int offerte_disattivate = 0;
  int comunicazioni_disattivate = 0;
  int ordini_disattivati = 0;
  int servizi_disattivati = 0;
  int disponibilita_disattivate = 0;
  int prezzi_non_visibili = 0;
  int giacenze_disattivate = 0;

  // il costruttore con tutti i parametri lo uso solo per creare i record fake
  ClienteModel({
    this.id = 0,
    this.agenti_id = 0,
    this.ragione_sociale = "",
    this.localita = "",
    this.indirizzo = "",
    this.username = "",
    this.sede = "",
    this.codice = "",
    this.stato = 0,
    this.videocatalogo_disattivato = 0,
    this.offerte_disattivate = 0,
    this.comunicazioni_disattivate = 0,
    this.ordini_disattivati = 0,
    this.servizi_disattivati = 0,
    this.disponibilita_disattivate = 0,
    this.prezzi_non_visibili = 0,
    this.giacenze_disattivate = 0,
  });

  // ClienteModel.cliente_cerca({int clienti_id = 0, String codice = ""}) {
  //   ClienteModel.cliente_da(clienti_id: clienti_id, codice: codice);
  // }

  factory ClienteModel.fromMap(Map<String, dynamic> map) {
    ClienteModel oggetto = ClienteModel();

    oggetto.id = map["id"];
    oggetto.agenti_id = map["agenti_id"];
    oggetto.ragione_sociale = map["ragione_sociale"];
    oggetto.localita = map["localita"];
    oggetto.indirizzo = map["indirizzo"];
    oggetto.username = map["username"];
    oggetto.sede = map["sede"];
    oggetto.codice = map["codice"];
    oggetto.stato = map["stato"];
    oggetto.videocatalogo_disattivato = map["videocatalogo_disattivato"];
    oggetto.offerte_disattivate = map["offerte_disattivate"];
    oggetto.comunicazioni_disattivate = map["comunicazioni_disattivate"];
    oggetto.ordini_disattivati = map["ordini_disattivati"];
    oggetto.servizi_disattivati = map["servizi_disattivati"];
    oggetto.disponibilita_disattivate = map["disponibilita_disattivate"];
    oggetto.prezzi_non_visibili = map["prezzi_non_visibili"];
    oggetto.giacenze_disattivate = map["giacenze_disattivate"];

    return oggetto;
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "agenti_id": agenti_id,
        "ragione_sociale": ragione_sociale,
        "localita": localita,
        "indirizzo": indirizzo,
        "username": username,
        "sede": sede,
        "codice": codice,
        "stato": stato,
        "videocatalogo_disattivato": videocatalogo_disattivato,
        "offerte_disattivate": offerte_disattivate,
        "comunicazioni_disattivate": comunicazioni_disattivate,
        "ordini_disattivati": ordini_disattivati,
        "servizi_disattivati": servizi_disattivati,
        "disponibilita_disattivate": disponibilita_disattivate,
        "prezzi_non_visibili": prezzi_non_visibili,
        "giacenze_disattivate": giacenze_disattivate,
      };


  static Future<ClienteModel> cliente_da({int clienti_id = 0, String codice = ""}) async {
    Database db = GetIt.instance<DbRepository>()
        .database;

    String sql_where = "";
    List sql_argomenti = [];

    if(clienti_id != 0){
      sql_where += "id = ?";
      sql_argomenti.add(clienti_id);
    }
    if(codice != ""){
      if (sql_where != ""){
        sql_where += " And ";
      }
      sql_where += "codice = ?";
      sql_argomenti.add(codice);
    }

    final rows = await (await db
        .query("clienti", where: sql_where, whereArgs: sql_argomenti));
    if(rows.length>0){
      return ClienteModel.fromMap(rows[0]);
    } else {
      return ClienteModel();
    }
  }

  static Future<List<Map>> clienti_lista({
    int id = 0,
    String nominativo = "",
    String codice = "",
    String selezione = "", // selezione "tutti" "con_ordine"
  }) async {
    List<Map> clienti_lista = [];

    Database db = GetIt.instance<DbRepository>().database;
    String sql_eseguire = """SELECT DISTINCT 
    clienti.id,
    clienti.agenti_id,
    clienti.codice,
    clienti.ragione_sociale,
    clienti.localita
     FROM clienti
""";

    List<String> sql_join = [];
    List<String> sql_where = [];
    List<String> sql_ordinamenti = [];

    if (id != 0) {
      sql_where.add(" clienti.id = ${id} ");
    }
    if (nominativo != "") {
      String sql_nominativo = "";
      nominativo.split(" ").forEach((String element) {
        sql_nominativo += (sql_nominativo == "") ? "(" : " AND ";
        sql_nominativo += " clienti.ragione_sociale LIKE '%${element}%' ";
      });
      sql_nominativo += ")";
      sql_where.add(sql_nominativo);
    }
    if (codice != "") {
      sql_where.add(" clienti.codice LIKE '${codice}%' ");
    }
    if (selezione != "") {
      switch (selezione) {
        case 'tutti':
          sql_where.add(" clienti.id > 0 ");
          break;
        case 'con_ordine':
          sql_join.add("LEFT JOIN ordini ON ordini.clienti_id = clienti.id ");
          sql_join.add("LEFT JOIN ordini_righe ON ordini_righe.ordini_id = ordini.id ");
          sql_join.add("LEFT JOIN resi ON resi.clienti_id = clienti.id ");
          sql_join.add("LEFT JOIN resi_righe ON resi_righe.resi_id = resi.id ");
          sql_where.add(" ((ordini.id > 0 AND ordini_righe.id > 0) OR (resi.id > 0 AND resi_righe.id > 0 ))");
          break;
      }
    }

    sql_ordinamenti.add(" clienti.ragione_sociale ASC ");

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

    clienti_lista = rows;

    return clienti_lista;
  }

  String get sede_sigla {

    return (this.sede == 0) ? "P" : (this.sede == 1) ? "B" : "";

  }

}
