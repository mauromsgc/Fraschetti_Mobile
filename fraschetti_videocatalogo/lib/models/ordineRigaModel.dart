import 'package:flutter/foundation.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/models/codiceModel.dart';
import 'package:fraschetti_videocatalogo/models/parametriModel.dart';
import 'package:fraschetti_videocatalogo/models/utenteCorrenteModel.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class OrdineRigaModel {
  int id = 0;
  int ordini_id = 0;
  String codice = "";
  String descrizione = "";
  String um = "";
  double quantita = 0;
  double prezzo = 0;
  double prezzo_ordine = 0;
  late CodiceModel codice_scheda;

  OrdineRigaModel({
    this.id = 0,
    this.ordini_id = 0,
    this.codice = "",
    this.descrizione = "",
    this.um = "",
    this.quantita = 0,
    this.prezzo = 0,
    this.prezzo_ordine = 0,
  });

  factory OrdineRigaModel.fromMap(Map<String, dynamic> map) {
    OrdineRigaModel oggetto = OrdineRigaModel();

    oggetto.id = map["id"];
    oggetto.ordini_id = map["ordini_id"];
    oggetto.codice = map["codice"];
    oggetto.descrizione = map["descrizione"];
    oggetto.um = map["um"];
    oggetto.quantita = map["quantita"];
    oggetto.prezzo = map["prezzo"];
    oggetto.prezzo_ordine = map["prezzo_ordine"];

    return oggetto;
  }

  double get prezzo_riga_totale {
    double prezzo_riga_totale = (this.quantita * this.prezzo_ordine);
    return double.parse(prezzo_riga_totale.toStringAsFixed(2));
  }

  static Future<List<OrdineRigaModel>> ordini_righe_cerca({
    int id = 0,
    int ordini_id = 0,
    int numero = 0,
    int agenti_id = 0,
    int clienti_id = 0,
    String codice = "",
  }) async {
    List<OrdineRigaModel> ordini_righe_lista = [];

    Database db = GetIt.instance<DbRepository>().database;
    String sql_eseguire = """SELECT DISTINCT 
    ordini_righe.id, 
    ordini_righe.ordini_id, 
    ordini_righe.codice, 
    ordini_righe.descrizione, 
    ordini_righe.um, 
    ordini_righe.quantita, 
    ordini_righe.prezzo, 
    ordini_righe.prezzo_ordine
    FROM ordini_righe
    """;

    List<String> sql_join = [];
    List<String> sql_where = [];
    List<String> sql_ordinamenti = [];

    if (id != 0) {
      sql_where.add(" ordini_righe.id = ${id} ");
    }
    if (ordini_id != 0) {
      sql_where.add(" ordini_righe.ordini_id = ${ordini_id} ");
    }
    if (numero != 0) {
      sql_where.add(" ordini.numero = ${numero} ");
    }

    if (agenti_id != 0) {
      sql_join.add(" LEFT JOIN ordini ON ordini.id = ordini_righe.ordini_id ");
      sql_where.add(" ordini.agenti_id = ${agenti_id} ");
    }
    if (clienti_id != 0) {
      sql_join.add(" LEFT JOIN ordini ON ordini.id = ordini_righe.ordini_id ");
      sql_where.add(" ordini.agenti_id = ${clienti_id} ");
    }

    if (codice != "") {
      sql_where.add(" ordini_righe.codice LIKE '${codice}%' ");
    }

    sql_ordinamenti.add(" ordini_righe.id ASC ");

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

    // ordini_righe_lista = rows.map((row) => OrdineRigaModel.fromMap(row)).toList();

    ordini_righe_lista = rows.map((row) => OrdineRigaModel.fromMap(row)).toList();

    rows.forEach((row) async {
      OrdineRigaModel oggetto = OrdineRigaModel.fromMap(row);

      List<CodiceModel> result = await CodiceModel.codici_lista(codice: oggetto.codice);
      if (result.length > 0) {
        oggetto.codice_scheda = result.first;
      } else {
        oggetto.codice_scheda = CodiceModel();
      }
      ordini_righe_lista.add(oggetto);
    });

    return ordini_righe_lista;
  }


  static Future<OrdineRigaModel> ordini_righe_cerca_singolo({
    int id = 0,
    // int ordini_id = 0,
    // int numero = 0,
    // int agenti_id = 0,
    // int clienti_id = 0,
    // String codice = "",
  }) async {
    // cerca un record esistente
    // e restituisce l'oggetto relativo al record
    OrdineRigaModel ordine_riga_scheda;

    List<OrdineRigaModel> ordini_righe_lista =
        await OrdineRigaModel.ordini_righe_cerca(id: id);

    if (ordini_righe_lista.length > 0) {
      ordine_riga_scheda = ordini_righe_lista.first;
    } else {
      // oppure errore
      ordine_riga_scheda = OrdineRigaModel();
    }

    return ordine_riga_scheda;
  }

  static Future<OrdineRigaModel> nuovo_da_codice({
    String codice = "",
  }) async {
    // in caso di nuovo record
    // crea un nuovo oggetto con i dati di
    // agente, cliente, numero ordine e codice articolo
    // poi carica i dati del codice
    // e compila i campi codice, descrizione, um, quantita, prezzo
    // dalla proprietà del codice

    OrdineRigaModel ordine_scheda = OrdineRigaModel();

    List<CodiceModel> result = await CodiceModel.codici_lista(codice: codice);
    if (result.length > 0) {
      ordine_scheda.codice_scheda = result.first;
    } else {
      ordine_scheda.codice_scheda = CodiceModel();

      // compilo i dati della riga ordine
      ordine_scheda.ordini_id = GetIt.instance<SessioneModel>().ordine_id_corrente;
      ordine_scheda.codice = ordine_scheda.codice_scheda.numero;
      ordine_scheda.descrizione =
          ordine_scheda.codice_scheda.catalogo_nome.trim();
      if (ordine_scheda.codice_scheda.descrizione != "") {
        ordine_scheda.descrizione +=
            " " + ordine_scheda.codice_scheda.descrizione.trim();
      }
      ordine_scheda.um = ordine_scheda.codice_scheda.um;
      ordine_scheda.quantita = ordine_scheda.codice_scheda.pezzi;
      ordine_scheda.prezzo = ordine_scheda.codice_scheda.prezzo;
      ordine_scheda.prezzo_ordine = ordine_scheda.codice_scheda.prezzo;
    }

    return ordine_scheda;
  }
}
