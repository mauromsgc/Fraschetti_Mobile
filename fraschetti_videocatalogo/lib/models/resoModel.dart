import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/models/resoRigaModel.dart';
import 'package:fraschetti_videocatalogo/models/utenteCorrenteModel.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class ResoModel {
  int id = 0;
  int clienti_id = 0;
  int agenti_id = 0;
  int numero = 0;
  late List<ResoRigaModel> righe = [];

  ResoModel({
    this.id = 0,
    this.clienti_id = 0,
    this.agenti_id = 0,
    this.numero = 0,
  });

  factory ResoModel.fromMap(Map<String, dynamic> map) {
    ResoModel oggetto = ResoModel();

    oggetto.id = map["id"];
    oggetto.agenti_id = map["agenti_id"];
    oggetto.clienti_id = map["clienti_id"];
    oggetto.numero = map["numero"];

    return oggetto;
  }

  Map<String, Object?> toMap_record() {
    // deve contenere solo i campi della tabella
    var map = <String, dynamic>{
      "id": (id != 0) ? id : null,
      "agenti_id": agenti_id,
      "clienti_id": clienti_id,
      "numero": numero,
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
      record_id = await record_aggiorna();
    }
    return record_id;
  }

  Future<int> record_inserisci() async {
    Database db = GetIt.instance<DbRepository>().database;

    int record_id = await db.insert(
      'resi',
      this.toMap_record(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return record_id;
  }

  Future<int> record_aggiorna() async {
    Database db = GetIt.instance<DbRepository>().database;

    int record_aggiornati = await db.update(
      'resi',
      this.toMap_record(),
      where: 'id = ?',
      whereArgs: [this.id],
    );

    return record_aggiornati;
  }

  static Future<int> record_elimina({int id = 0}) async {
    Database db = GetIt.instance<DbRepository>().database;

    // elimina le righe del reso
    int record_eliminati_righe = await db.delete(
      'resi_righe',
      where: 'resi_id = ?',
      whereArgs: [id],
    );
    print("record_eliminati_righe ${record_eliminati_righe}");

    int record_eliminati = await db.delete(
      'resi',
      where: 'id = ?',
      whereArgs: [id],
    );
    print("record_eliminati ${record_eliminati}");

    return record_eliminati;
  }

  static Future<List<ResoModel>> resi_cerca({
    int id = 0,
    int agenti_id = 0,
    int clienti_id = 0,
    int numero = 0,
    String ordinamento = "",
  }) async {
    print("resi_cerca inizio");
    // uso questa ricerca sia per la lista delle gighe oridine
    // sia per quando mi servono tutti gli resi da inviare
    List<ResoModel> resi_lista = [];

    Database db = GetIt.instance<DbRepository>().database;
    String sql_eseguire = """SELECT DISTINCT 
    resi.id, 
    resi.agenti_id, 
    resi.clienti_id, 
    resi.numero 
    FROM resi
    """;

    List<String> sql_join = [];
    List<String> sql_where = [];
    List<String> sql_ordinamenti = [];

    if (id != 0) {
      sql_where.add(" resi.id = ${id} ");
    }
    if (agenti_id != 0) {
      sql_where.add(" resi.agenti_id = ${agenti_id} ");
    }
    if (clienti_id != 0) {
      sql_where.add(" resi.clienti_id = ${clienti_id} ");
    }
    if (numero != 0) {
      sql_where.add(" resi.numero = ${numero} ");
    }

    if(ordinamento != "") {
      sql_ordinamenti.add(ordinamento);
    }
    sql_ordinamenti.add(" resi.id ASC ");

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

    // resi_lista = rows.map((row) => ResoModel.fromMap(row)).toList();

    print("resi_cerca rows.length ${rows.length}");

    await Future.forEach(rows, (Map<String, dynamic> row) async {
      // rows.forEach((row) async {
      print("resi_cerca fromMap inizio");
      ResoModel oggetto = ResoModel.fromMap(row);
      print("resi_cerca fromMap fine");

      print("resi_cerca oggetto.righe inizio");
      oggetto.righe = await ResoRigaModel.resi_righe_cerca(resi_id: oggetto.id);
      print("resi_cerca oggetto.righe fine");

      print("resi_cerca oggetto ${oggetto.toMap_record()}");
      resi_lista.add(oggetto);
    });
    print("resi_cerca resi_lista.length ${resi_lista.length}");

    print("resi_cerca fine");

    return resi_lista;
  }

  static Future<ResoModel> resi_cerca_singolo({
    int id = 0,
    int agenti_id = 0,
    int clienti_id = 0,
    int numero = 0,
  }) async {
    print("resi_cerca_singolo inizio");
    // cerca un record esistente
    // e restituisce l'oggetto relativo al record
    ResoModel reso_scheda;

    List<ResoModel> resi_lista = await ResoModel.resi_cerca(
      id: id,
      agenti_id: agenti_id,
      clienti_id: clienti_id,
      numero: numero,
    );

    print("resi_cerca_singolo resi_lista.length ${resi_lista.length}");
    if (resi_lista.length > 0) {
      reso_scheda = resi_lista.first;
    } else {
      // oppure errore
      reso_scheda = ResoModel();
    }

    print("resi_cerca_singolo fine");
    return reso_scheda;
  }


  static Future<ResoModel> reso_cliente_carica({
    int cliente_id = 0,
    int numero = 0,
  }) async {
    print("reso_cliente_carica inizio");
    // cerco eventuali resi del cliente
    // se ne trovo più di uno seleziono quello con il numero più grande
    // o se presente il numero quello con il numero indicato
    // se non trovo niente restituisco l'oggetto vuoto
    // imposto le variabili di sessione con reso_id = 0

    ResoModel reso_scheda = ResoModel();

    // aggiungere la ricerca anche non numero per numero > 0
    Database db = GetIt.instance<DbRepository>().database;
    String sql_eseguire = "SELECT resi.id, resi.numero ";
    sql_eseguire += "FROM resi ";
    sql_eseguire += "WHERE clienti_id = ${cliente_id} ";
    if (numero != 0) {
      sql_eseguire += "AND  numero = ${numero} ";
    }
    sql_eseguire += "ORDER BY resi.numero DESC;";

    final List rows = await db.rawQuery(sql_eseguire);
    if (rows.length > 0) {
      // lo riassegno in caso non ho trovato nessun reso
      reso_scheda = await ResoModel.resi_cerca_singolo(id: rows[0]["id"]);
    }

    // reimposto l'id dell'reso nelle variabili disessione
    GetIt.instance<SessioneModel>().reso_id_corrente = reso_scheda.id;

    print("reso_scheda.id ${reso_scheda.id}");
    print("reso_scheda.numero ${reso_scheda.numero}");

    print("reso_cliente_carica fine");

    return reso_scheda;
  }

  static Future<ResoModel> reso_cliente_seleziona({
    int cliente_id = 0,
    int numero = 0,
  }) async {
    print("reso_cliente_seleziona inizio");
    // prima cerco eventuali resi cliente con reso_cliente_carica()
    // se reso_cliente_carica() restituisce un reso valido (id>0) uso quello
    // altrimenti se non ne trovo nessuno ne creo uno
    // con numero uguale a 1 ne numero = 0 altrimenti co il numero indicato
    print("numero reso assegnare ${numero}");
    int reso_id = 0;

    ResoModel reso_scheda = await ResoModel.reso_cliente_carica(
      cliente_id: cliente_id,
      numero: numero,
    );

    if (reso_scheda.id == 0) {
      if (numero == 0) {
        numero = 1;
      }
      // devo creare un nuovo reso e salvarlo
      reso_scheda = ResoModel();

      reso_scheda.agenti_id = GetIt.instance<UtenteCorrenteModel>().agenti_id;
      reso_scheda.clienti_id = cliente_id;
      reso_scheda.numero = numero;
      reso_id = await reso_scheda.record_salva();

      // ricarico il record per le altre variabili
      reso_scheda = await ResoModel.resi_cerca_singolo(id: reso_id);
      reso_id = reso_scheda.id;
      // reimposto l'id dell'reso nelle variabili disessione
      // in caso reso_scheda.id == 0 sarà stato impostatato da ResoModel.reso_cliente_carica
      GetIt.instance<SessioneModel>().reso_id_corrente = reso_scheda.id;
    }
    print("reso_scheda.numero ${reso_scheda.numero}");
    print("reso_scheda.id ${reso_scheda.id}");

    print("reso_cliente_seleziona fine");

    return reso_scheda;
  }
}
