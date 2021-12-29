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
  late CodiceModel codice_scheda = CodiceModel();

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

  Map<String, Object?> toMap_record() {
    // deve contenere solo i campi della tabella
    var map = <String, dynamic>{
    "id": (id != 0) ? id : null,
    "ordini_id": ordini_id,
    "codice": codice,
    "descrizione": descrizione,
    "um": um,
    "quantita": quantita,
    "prezzo": prezzo,
    "prezzo_ordine": prezzo_ordine,
    };

    return map;
  }

  Future<int> record_salva() async {
    // restituisco l'id del record creato o aggiornato
    // se ritorna 0 il salvataggio o l'aggiornamento non sono a dati a buon fine
    int record_id = 0;
    if (this.id == 0) {
      record_id = await record_inserisci();
      this.id = record_id;
    } else {
      final record_aggiornati = await record_aggiorna();
      if (record_aggiornati > 0) {
        record_id = record_id;
      }
    }

    return record_id;
  }

  Future<int> record_inserisci() async {
    Database db = GetIt.instance<DbRepository>().database;

    int record_id = await db.insert(
      'ordini_righe',
      this.toMap_record(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return record_id;
  }

  Future<int> record_aggiorna() async {
    Database db = GetIt.instance<DbRepository>().database;

    int record_aggiornati = await db.update(
      'ordini_righe',
      this.toMap_record(),
      where: 'id = ?',
      whereArgs: [this.id],
    );

    return record_aggiornati;
  }

  static Future<int> record_elimina(int id) async {
    Database db = GetIt.instance<DbRepository>().database;

    int record_eliminati = await db.delete(
      'ordini_righe',
      where: 'id = ?',
      whereArgs: [id],
    );

    return record_eliminati;
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
    print("ordini_righe_cerca_singolo inizio");
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
    print("ordini_righe_cerca_singolo fine");

    return ordine_riga_scheda;
  }

  static Future<OrdineRigaModel> nuovo_da_codice({
    int codice_id = 0,
    String codice = "",
  }) async {
    print("nuovo_da_codice inizio");
    // in caso di nuovo record
    // crea un nuovo oggetto con i dati di
    // agente, cliente, numero ordine e codice articolo
    // poi carica i dati del codice
    // e compila i campi codice, descrizione, um, quantita, prezzo
    // dalla proprietà del codice

    OrdineRigaModel ordine_riga_scheda = OrdineRigaModel();

    List<CodiceModel> result = await CodiceModel.codici_lista(id: codice_id, codice: codice);
    if (result.length > 0) {
      ordine_riga_scheda.codice_scheda = result.first;
    } else {
      ordine_riga_scheda.codice_scheda = CodiceModel();

      // compilo i dati della riga ordine
      ordine_riga_scheda.ordini_id = GetIt.instance<SessioneModel>().ordine_id_corrente;
      ordine_riga_scheda.codice = ordine_riga_scheda.codice_scheda.numero;
      ordine_riga_scheda.descrizione =
          ordine_riga_scheda.codice_scheda.catalogo_nome.trim();
      if (ordine_riga_scheda.codice_scheda.descrizione != "") {
        ordine_riga_scheda.descrizione +=
            " " + ordine_riga_scheda.codice_scheda.descrizione.trim();
      }
      ordine_riga_scheda.um = ordine_riga_scheda.codice_scheda.um;
      ordine_riga_scheda.quantita = ordine_riga_scheda.codice_scheda.pezzi;
      ordine_riga_scheda.prezzo = ordine_riga_scheda.codice_scheda.prezzo;
      ordine_riga_scheda.prezzo_ordine = ordine_riga_scheda.codice_scheda.prezzo;
    }
    print("nuovo_da_codice fine");

    return ordine_riga_scheda;
  }
}
