import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/models/ordineRigaModel.dart';
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

  Map<String, Object?> toMap_record() {
    // deve contenere solo i campi della tabella
    var map = <String, dynamic>{
      "id": (id != 0) ? id : null,
      "agenti_id": agenti_id,
      "clienti_id": clienti_id,
      "numero": numero,
      "note": note,
      "sospeso": sospeso,
      "email_cliente_non_inviare": email_cliente_non_inviare,
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
      'ordini',
      this.toMap_record(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return record_id;
  }

  Future<int> record_aggiorna() async {
    Database db = GetIt.instance<DbRepository>().database;

    int record_aggiornati = await db.update(
      'ordini',
      this.toMap_record(),
      where: 'id = ?',
      whereArgs: [this.id],
    );

    return record_aggiornati;
  }

  static Future<int> record_elimina({int id = 0}) async {
    Database db = GetIt.instance<DbRepository>().database;

    // elimina le righe dell'ordine
    int record_eliminati_righe = await db.delete(
      'ordini_righe',
      where: 'ordini_id = ?',
      whereArgs: [id],
    );
    print("record_eliminati_righe ${record_eliminati_righe}");

    int record_eliminati = await db.delete(
      'ordini',
      where: 'id = ?',
      whereArgs: [id],
    );
    print("record_eliminati ${record_eliminati}");

    return record_eliminati;
  }

  double get totale_imponibile {

    double totale_imponibile = 0;
    totale_imponibile = righe.fold(0, (sum, next) => sum + next.prezzo_riga_totale);

    return totale_imponibile;
  }

  static Future<List<OrdineModel>> ordini_cerca({
    int id = 0,
    int agenti_id = 0,
    int clienti_id = 0,
    int numero = 0,
    int sospeso = -1,
    int email_cliente_non_inviare = -1,
    String ordinamento = "",
  }) async {
    print("ordini_cerca inizio");
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

    if(ordinamento != "") {
      sql_ordinamenti.add(ordinamento);
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

    print("ordini_cerca rows.length ${rows.length}");

    await Future.forEach(rows, (Map<String, dynamic> row) async {
      // rows.forEach((row) async {
      print("ordini_cerca fromMap inizio");
      OrdineModel oggetto = OrdineModel.fromMap(row);
      print("ordini_cerca fromMap fine");

      print("ordini_cerca oggetto.righe inizio");
      oggetto.righe =
          await OrdineRigaModel.ordini_righe_cerca(ordini_id: oggetto.id);
      print("ordini_cerca oggetto.righe fine");

      print("ordini_cerca oggetto ${oggetto.toMap_record()}");
      ordini_lista.add(oggetto);
    });
    print("ordini_cerca ordini_lista.length ${ordini_lista.length}");

    print("ordini_cerca fine");

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
    print("ordini_cerca_singolo inizio");
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

    print("ordini_cerca_singolo ordini_lista.length ${ordini_lista.length}");
    if (ordini_lista.length > 0) {
      ordine_scheda = ordini_lista.first;
    } else {
      // oppure errore
      ordine_scheda = OrdineModel();
    }

    print("ordini_cerca_singolo fine");
    return ordine_scheda;
  }

  static Future<OrdineModel> ordine_cliente_carica({
    int cliente_id = 0,
    int numero = 0,
  }) async {
    print("ordine_cliente_carica inizio");
    // cerco eventuali ordini del cliente
    // se ne trovo più di uno seleziono quello con il numero più grande
    // o se presente il numero quello con il numero indicato
    // se non trovo niente restituisco l'oggetto vuoto
    // imposto le variabili di sessione con ordine_id = 0

    OrdineModel ordine_scheda = OrdineModel();

    // aggiungere la ricerca anche non numero per numero > 0
    Database db = GetIt.instance<DbRepository>().database;
    String sql_eseguire = "SELECT ordini.id, ordini.numero ";
sql_eseguire += "FROM ordini ";
sql_eseguire += "WHERE clienti_id = ${cliente_id} ";
sql_eseguire += "ORDER BY ordini.numero DESC;";

    final List rows = await db.rawQuery(sql_eseguire);
    if (rows.length > 0) {
      // lo riassegno in caso non ho trovato nessun ordine
      ordine_scheda = await OrdineModel.ordini_cerca_singolo(id: rows[0]["id"]);
    }

    // reimposto l'id dell'ordine nelle variabili disessione
    GetIt.instance<SessioneModel>().ordine_id_corrente = ordine_scheda.id;

    print("ordine_scheda.id ${ordine_scheda.id}");
    print("ordine_scheda.numero ${ordine_scheda.numero}");

    print("ordine_cliente_carica fine");

    return ordine_scheda;
  }

  static Future<OrdineModel> ordine_cliente_seleziona({
    int cliente_id = 0,
    int numero = 0,
  }) async {
    print("ordine_cliente_seleziona inizio");
    // prima cerco eventuali ordini cliente con ordine_cliente_carica()
    // se ordine_cliente_carica() restituisce un ordine valido (id>0) uso quello
    // altrimenti se non ne trovo nessuno ne creo uno
    // con numero uguale a 1 ne numero = 0 altrimenti co il numero indicato
    print("numero ordine assegnare ${numero}");
    int ordine_id = 0;

    OrdineModel ordine_scheda = await OrdineModel.ordine_cliente_carica(
      cliente_id: cliente_id,
      numero: numero,
    );

    if (ordine_scheda.id == 0) {
      if(numero == 0){
        numero = 1;
      }
      // devo creare un nuovo ordine e salvarlo
      ordine_scheda = OrdineModel();

      ordine_scheda.agenti_id = GetIt.instance<UtenteCorrenteModel>().agenti_id;
      ordine_scheda.clienti_id = cliente_id;
      ordine_scheda.numero = numero;
      ordine_id = await ordine_scheda.record_salva();

      // ricarico il record per le altre variabili
      ordine_scheda = await OrdineModel.ordini_cerca_singolo(id: ordine_id);
      ordine_id = ordine_scheda.id;
      // reimposto l'id dell'ordine nelle variabili disessione
      // in caso ordine_scheda.id == 0 sarà stato impostatato da OrdineModel.ordine_cliente_carica
      GetIt.instance<SessioneModel>().ordine_id_corrente = ordine_scheda.id;

    }
    print("ordine_scheda.numero ${ordine_scheda.numero}");
    print("ordine_scheda.id ${ordine_scheda.id}");

    print("ordine_cliente_seleziona fine");

    return ordine_scheda;
  }
}
