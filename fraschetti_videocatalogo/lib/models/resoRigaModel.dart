import 'package:fraschetti_videocatalogo/models/codiceModel.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class ResoRigaModel {
  int id = 0;
  int resi_id = 0;
  String codice = "";
  String descrizione = "";
  String um = "";
  double quantita = 0;
  int causale_reso = 0;
  String causale_reso_descrizione = "";
  String fattura_data = "";
  String fattura_numero = "";
  String note = "";
  late CodiceModel codice_scheda = CodiceModel();

  ResoRigaModel({
    this.id = 0,
    this.resi_id = 0,
    this.codice = "",
    this.descrizione = "",
    this.um = "",
    this.quantita = 0,
    this.causale_reso = 0,
    this.causale_reso_descrizione = "",
    this.fattura_data = "",
    this.fattura_numero = "",
    this.note = "",
  });

  factory ResoRigaModel.fromMap(Map<String, dynamic> map) {
    ResoRigaModel oggetto = ResoRigaModel();

    oggetto.id = map["id"];
    oggetto.resi_id = map["resi_id"];
    oggetto.codice = map["codice"] ?? "";
    oggetto.descrizione = map["descrizione"] ?? "";
    oggetto.um = map["um"] ?? "";
    oggetto.quantita = map["quantita"] ?? 0;
    oggetto.causale_reso = map["causale_reso"] ?? 0;
    oggetto.causale_reso_descrizione = map["causale_reso_descrizione"] ?? "";
    oggetto.fattura_data = map["fattura_data"] ?? "";
    oggetto.fattura_numero = map["fattura_numero"] ?? "";
    oggetto.note = map["note"] ?? "";

    return oggetto;
  }

  Map<String, Object?> toMap_record() {
    // deve contenere solo i campi della tabella
    var map = <String, dynamic>{
      "id": (id != 0) ? id : null,
      "resi_id": resi_id,
      "codice": codice,
      "descrizione": descrizione,
      "um": um,
      "quantita": quantita,
      "causale_reso": causale_reso,
      "causale_reso_descrizione": causale_reso_descrizione,
      "fattura_data": fattura_data,
      "fattura_numero": fattura_numero,
      "note": note,
    };

    return map;
  }

  Future<int> record_salva() async {
    // restituisco l'id del record creato o aggiornato
    // se ritorna 0 il salvataggio o l'aggiornamento non sono a dati a buon fine
    int record_id = 0;
    try {
      if (this.id == 0) {
        record_id = await record_inserisci();
        this.id = record_id;
      } else {
        record_id = await record_aggiorna();
      }
    } catch (e) {
      print("errore ${e.toString()}");
    }

    return record_id;
  }

  Future<int> record_inserisci() async {
    Database db = GetIt.instance<DbRepository>().database;

    int record_id = await db.insert(
      'resi_righe',
      this.toMap_record(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return record_id;
  }

  Future<int> record_aggiorna() async {
    Database db = GetIt.instance<DbRepository>().database;

    int record_aggiornati = await db.update(
      'resi_righe',
      this.toMap_record(),
      where: 'id = ?',
      whereArgs: [this.id],
    );

    return record_aggiornati;
  }

  static Future<int> record_elimina({int id = 0}) async {
    Database db = GetIt.instance<DbRepository>().database;

    int record_eliminati = await db.delete(
      'resi_righe',
      where: 'id = ?',
      whereArgs: [id],
    );

    return record_eliminati;
  }

  static Future<List<ResoRigaModel>> resi_righe_cerca({
    int id = 0,
    int codice_id = 0,
    int resi_id = 0,
    int numero = 0,
    int agenti_id = 0,
    int clienti_id = 0,
    String codice = "",
  }) async {
    print("resi_righe_cerca inizio");
    List<ResoRigaModel> resi_righe_lista = [];

    Database db = GetIt.instance<DbRepository>().database;
    String sql_eseguire = """SELECT DISTINCT 
    resi_righe.id, 
    resi_righe.resi_id, 
    resi_righe.codice, 
    resi_righe.descrizione, 
    resi_righe.um, 
    resi_righe.quantita, 
    resi_righe.causale_reso, 
    resi_righe.fattura_data,
    resi_righe.fattura_numero,
    resi_righe.note,
    resi_causali.descrizione AS causale_reso_descrizione
    FROM resi_righe
    LEFT JOIN resi_causali ON resi_causali.codice = resi_righe.causale_reso
    """;

    List<String> sql_join = [];
    List<String> sql_where = [];
    List<String> sql_ordinamenti = [];

    if (id != 0) {
      sql_where.add(" resi_righe.id = ${id} ");
    }
    if (codice_id != 0) {
      sql_join.add(" LEFT JOIN codici ON codici.numero = resi_righe.codice ");
      sql_where.add(" codici.id = ${codice_id} ");
    }

    if (id != 0) {
      sql_where.add(" resi_righe.id = ${id} ");
    }
    if (resi_id != 0) {
      sql_where.add(" resi_righe.resi_id = ${resi_id} ");
    }
    if (numero != 0) {
      sql_where.add(" resi.numero = ${numero} ");
    }

    if (agenti_id != 0) {
      sql_join.add(" LEFT JOIN resi ON resi.id = resi_righe.resi_id ");
      sql_where.add(" resi.agenti_id = ${agenti_id} ");
    }
    if (clienti_id != 0) {
      sql_join.add(" LEFT JOIN resi ON resi.id = resi_righe.resi_id ");
      sql_where.add(" resi.agenti_id = ${clienti_id} ");
    }

    if (codice != "") {
      if (codice.length == 6) {
        sql_where.add(" resi_righe.codice = '${codice}' ");
      } else {
        sql_where.add(" resi_righe.codice LIKE '${codice}%' ");
      }
    }

    sql_ordinamenti.add(" resi_righe.id ASC ");

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

    // resi_righe_lista = rows.map((row) => ResoRigaModel.fromMap(row)).toList();

    await Future.forEach(rows, (Map<String, dynamic> row) async {
      // rows.forEach((row) async {
      ResoRigaModel oggetto = ResoRigaModel.fromMap(row);

      oggetto.codice_scheda =
      await CodiceModel.codici_cerca_singolo(codice: oggetto.codice);

      print("resi_righe_cerca oggetto ${oggetto.toMap_record()}");
      print(
          "resi_righe_cerca oggetto.codice_scheda ${oggetto.codice_scheda.toMap()}");
      resi_righe_lista.add(oggetto);
    });

    print("resi_righe_cerca fine");
    return resi_righe_lista;
  }

  static Future<ResoRigaModel> resi_righe_cerca_singolo({
    int id = 0,
    int codice_id = 0,
    int resi_id = 0,
    int numero = 0,
    int agenti_id = 0,
    int clienti_id = 0,
    String codice = "",
  }) async {
    print("resi_righe_cerca_singolo inizio");
    // cerca un record esistente
    // e restituisce l'oggetto relativo al record
    ResoRigaModel reso_riga_scheda;

    List<ResoRigaModel> resi_righe_lista =
    await ResoRigaModel.resi_righe_cerca(
      id: id,
      codice_id: codice_id,
      resi_id: resi_id,
      numero: numero,
      agenti_id: agenti_id,
      clienti_id: clienti_id,
      codice: codice,
    );

    if (resi_righe_lista.length > 0) {
      reso_riga_scheda = resi_righe_lista.first;
    } else {
      // oppure errore
      reso_riga_scheda = ResoRigaModel();
    }
    print("resi_righe_cerca_singolo fine");

    return reso_riga_scheda;
  }

  // cercare un codice e restituire descrizione e um

  // static Future<ResoRigaModel> nuovo_da_codice({
  //   int codice_id = 0,
  //   String codice = "",
  // }) async {
  //   print("nuovo_da_codice inizio");
  //   // in caso di nuovo record
  //   // crea un nuovo oggetto con i dati di
  //   // agente, cliente, numero ordine e codice articolo
  //   // poi carica i dati del codice
  //   // e compila i campi codice, descrizione, um, quantita, causale_reso
  //   // dalla proprietà del codice
  //
  //   ResoRigaModel reso_riga_scheda = ResoRigaModel();
  //
  //   reso_riga_scheda.codice_scheda = await CodiceModel.codici_cerca_singolo(
  //     codice_id: codice_id,
  //     codice: codice,
  //   );
  //
  //   // compilo i dati della riga ordine
  //   reso_riga_scheda.resi_id =
  //       GetIt.instance<SessioneModel>().reso_id_corrente;
  //   reso_riga_scheda.codice = reso_riga_scheda.codice_scheda.numero;
  //   reso_riga_scheda.descrizione =
  //       reso_riga_scheda.codice_scheda.catalogo_nome.trim();
  //   if (reso_riga_scheda.codice_scheda.descrizione != "") {
  //     reso_riga_scheda.descrizione +=
  //         " " + reso_riga_scheda.codice_scheda.descrizione.trim();
  //   }
  //   reso_riga_scheda.um = reso_riga_scheda.codice_scheda.um;
  //   reso_riga_scheda.quantita = reso_riga_scheda.codice_scheda.pezzi;
  //   reso_riga_scheda.causale_reso = reso_riga_scheda.codice_scheda.causale_reso;
  //   reso_riga_scheda.fattura_data = reso_riga_scheda.codice_scheda.causale_reso;
  //   print("nuovo_da_codice fine");
  //
  //   return reso_riga_scheda;
  // }
}
