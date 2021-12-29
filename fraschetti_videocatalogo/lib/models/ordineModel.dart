import 'package:flutter/foundation.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/models/codiceModel.dart';
import 'package:fraschetti_videocatalogo/models/ordineRigaModel.dart';
import 'package:fraschetti_videocatalogo/models/parametriModel.dart';
import 'package:fraschetti_videocatalogo/models/utenteCorrenteModel.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class OrdineModel {
  int id = 0;
  int agenti_id = 0;
  int clienti_id = 0;
  int numero = 0;
  String note = "";
  int sospeso = 0;
  int email_cliente_non_inviare = 0;
  late List<OrdineRigaModel> righe = [];

  OrdineModel({
    this.id = 0,
    this.agenti_id = 0,
    this.clienti_id = 0,
    this.numero = 0,
    this.note = "",
    this.sospeso = 0,
    this.email_cliente_non_inviare = 0,
  });

  factory OrdineModel.fromMap(Map<String, dynamic> map) {
    OrdineModel oggetto = OrdineModel();

    oggetto.id = map["id"];
    oggetto.agenti_id = map["agenti_id"];
    oggetto.clienti_id = map["clienti_id"];
    oggetto.numero = map["numero"];
    oggetto.note = map["note"];
    oggetto.sospeso = map["sospeso"];
    oggetto.email_cliente_non_inviare = map["email_cliente_non_inviare"];

    return oggetto;
  }

  double get totale_imponibile {
    // double prezzo_riga_totale = (this.sospeso * this.email_cliente_non_inviare);
    // return double.parse(prezzo_riga_totale.toStringAsFixed(2));

    // fare un map sulle righe con la somma

    return 0;
  }

  static Future<List<OrdineModel>> ordini_cerca({
    int id = 0,
    int agenti_id = 0,
    int clienti_id = 0,
    int numero = 0,
    int sospeso = -1,
    int email_cliente_non_inviare = -1,
  }) async {
    // uso questa ricerca sia per la lista delle gighe oridine
    // sia per quando mi servono tutti gli ordini da inviare
    List<OrdineModel> ordini_lista = [];

    Database db = GetIt.instance<DbRepository>().database;
    String sql_eseguire = """SELECT DISTINCT 
    ordini.id, 
    ordini.agenti_id, 
    ordini.clienti_id, 
    ordini.numero, 
    ordini.note, 
    ordini.sospeso, 
    ordini.email_cliente_non_inviare
    FROM ordini
    """;

    List<String> sql_join = [];
    List<String> sql_where = [];
    List<String> sql_ordinamenti = [];

    if (id != 0) {
      sql_where.add(" ordini.id = ${id} ");
    }
    if (agenti_id != 0) {
      sql_where.add(" ordini.agenti_id = ${agenti_id} ");
    }
    if (clienti_id != 0) {
      sql_where.add(" ordini.clienti_id = ${clienti_id} ");
    }
    if (numero != 0) {
      sql_where.add(" ordini.numero = ${numero} ");
    }

    if (sospeso != -1) {
      sql_where.add(" ordini.sospeso = ${sospeso} ");
    }
    if (email_cliente_non_inviare != -1) {
      sql_where.add(
          " ordini.email_cliente_non_inviare = ${email_cliente_non_inviare} ");
    }

    sql_ordinamenti.add(" ordini.id ASC ");

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

    // ordini_lista = rows.map((row) => OrdineModel.fromMap(row)).toList();

    ordini_lista = rows.map((row) => OrdineModel.fromMap(row)).toList();

    rows.forEach((row) async {
      OrdineModel oggetto = OrdineModel.fromMap(row);

      oggetto.righe =
          await OrdineRigaModel.ordini_righe_cerca(ordini_id: oggetto.id);

      ordini_lista.add(oggetto);
    });

    return ordini_lista;
  }

  static Future<OrdineModel> ordini_cerca_singolo({
    int id = 0,
    int agenti_id = 0,
    int clienti_id = 0,
    int numero = 0,
    int sospeso = -1,
    int email_cliente_non_inviare = -1,
  }) async {
    // cerca un record esistente
    // e restituisce l'oggetto relativo al record
    OrdineModel ordine_scheda;

    List<OrdineModel> ordini_lista = await OrdineModel.ordini_cerca(
      id: id,
      agenti_id: agenti_id,
      clienti_id: clienti_id,
      numero: numero,
      sospeso: sospeso,
      email_cliente_non_inviare: email_cliente_non_inviare,
    );

    if (ordini_lista.length > 0) {
      ordine_scheda = ordini_lista.first;
    } else {
      // oppure errore
      ordine_scheda = OrdineModel();
    }

    return ordine_scheda;
  }

  static Future<OrdineModel> ordine_cliente_seleziona({
    int cliente_id = 0,
  }) async {
    // cerco eventuali ordini cliente
    // se ne trovo più di uno seleziono quello con il numero più grande
    // se non ne trovo nessuno ne creo uno con numero uguale a 1
    int ordine_numero = 0;
    OrdineModel ordine_scheda = OrdineModel();

    Database db = GetIt.instance<DbRepository>().database;
    String sql_eseguire = """SELECT MAX(ordini.numero) AS numero
    FROM ordini
    WHERE clienti_id = ${cliente_id}""";

    final rows = await db.rawQuery(sql_eseguire);
    if (rows.length > 0) {
      ordine_numero = rows[0]["numero"];
      ordine_scheda = await OrdineModel.ordini_cerca_singolo(id: cliente_id, numero: ordine_numero);
      // lo riassegno in caso non ho trovato nessun ordine
      ordine_numero = ordine_scheda.id;
    } else {
      ordine_numero = 1;
    }


    if (ordine_scheda.id == 0) {
      // devo creare un nuovo ordine e salvarlo
      ordine_scheda = OrdineModel();

      ordine_scheda.agenti_id = GetIt.instance<UtenteCorrenteModel>().agenti_id;
      ordine_scheda.clienti_id = GetIt.instance<SessioneModel>().clienti_id_selezionato;
      ordine_scheda.numero = ordine_numero;



    }

    GetIt.instance<SessioneModel>().ordine_id_imposta(id: ordine_scheda.id);

    return ordine_scheda;
  }
}
