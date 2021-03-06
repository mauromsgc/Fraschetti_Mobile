import 'package:fraschetti_videocatalogo/models/parametriModel.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:fraschetti_videocatalogo/repositories/httpRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';

class DBHelper {
  // Singleton pattern
  static final DBHelper _dbhelper = new DBHelper._costruttore_privato();

  DBHelper._costruttore_privato() {
    _inizializza();
  }

  factory DBHelper() {
    return _dbhelper;
  }

  static DBHelper get istanza => _dbhelper;

  // Members
  late Database database;
  final _initDBMemoizer = AsyncMemoizer<Database>();

  // Database get database {
  //   return _database;
  // }

  // Future<Database?> get database async {
  //   if (_database != null)
  //     return _database;
  //   _database = await _initDB();
  //   return _database;
  // }

  // Future<Database?> get database async {
  //   if (_database != null)
  //     return _database;
  //
  //   // if _database is null we instantiate it
  //   _database = await _initDBMemoizer.runOnce(() async {
  //     return await _initDB();
  //   });
  //
  //   return _database;
  // }

  Future<void> _inizializza() async {
    // _database = await _initDBMemoizer.runOnce(() async {
    //   return await _initDB();
    // });

    database = await _initDB();

  }

  Future<Database> _initDB() async {
    final databasesPath = await getDatabasesPath();
    final databasePath = path.join(databasesPath, "videocatalogo.db");

    // macOS database path
    // Users/poto/Library/Containers/it.msgc.fraschettiVideocatalogo/Data/Documents/videocatalogo.db
    print(databasePath);

    final int db_versione = 1;
    final database = await openDatabase(
      databasePath,
      version: db_versione,
      //     onConfigure: (Database db) async {
      //         // Add support for cascade delete
      //         await db.execute("PRAGMA foreign_keys = ON");
      // },
      onCreate: (Database db, int version) async {
        await db.execute("DROP TABLE IF EXISTS parametri");
        await db.execute("""
CREATE TABLE parametri ( 
id integer NOT NULL PRIMARY KEY AUTOINCREMENT, 
agg_dati_id INTEGER, 
agg_immagini_id INTEGER, 
agg_comunicazioni_id INTEGER,
agg_sql_id INTEGER, 
aggiornamento_obbligatorio INTEGER, 
anagrafica_aggiornamento INTEGER, 
promozioni_attivazione INTEGER, 
sql_versione INTEGER, 
host_server text(255,0), 
codice_macchina text(255,0), 
username text(255,0), 
password text(255,0), 
videocatalogo_uid text(255,0), 
log_attivo INTEGER
)""");

        await db.execute(
            "insert into parametri (id, agg_dati_id, agg_immagini_id, agg_comunicazioni_id, agg_sql_id, aggiornamento_obbligatorio, anagrafica_aggiornamento, promozioni_attivazione, sql_versione, host_server, codice_macchina, username, password, videocatalogo_uid, log_attivo )  values (  1, 0, 0, 0, 0, 1, 0, 0, 1, 'http://www.fraschetti.com:8080', '', '', '', '', 0 );");

// aggiornamento_dati_id - aggiornamento di tutto,
// in caso imposta anagrafica_aggiornamento e promozioni_attivazione a 1
// per ricaricare i dati dell'anagrafica e attivare le promozioni

// aggiornamento_img_id solo per aggiornamento immagini

        await db.execute("DROP TABLE IF EXISTS agenti");
        await db.execute("""
CREATE TABLE agenti ( 
id INTEGER NOT NULL PRIMARY KEY, 
cognome CHAR(30,0), 
nome CHAR(30,0), 
username CHAR(20,0), 
sede CHAR(1,0), 
codice CHAR(2,0), 
stato INTEGER, 
vendite INTEGER, 
acquisti INTEGER,
preventivi_abilitati INTEGER,
listino_id INTEGER,
offerte_disattivate INTEGER,
comunicazioni_disattivate INTEGER,
ordini_disattivati INTEGER,
servizi_disattivati INTEGER,
disponibilita_disattivate INTEGER,
prezzi_non_visibili INTEGER,
moduli_disattivati INTEGER,
giacenze_disattivate INTEGER
)""");

        await db.execute("DROP TABLE IF EXISTS assortimenti");
        await db.execute("""
CREATE TABLE assortimenti ( 
id INTEGER NOT NULL PRIMARY KEY, 
descrizione TEXT(100,0), 
ordinatore integer,
immagine TEXT 
)""");

        await db.execute("DROP TABLE IF EXISTS assortimenti_codici");
        await db.execute("""
CREATE TABLE assortimenti_codici ( 
id INTEGER NOT NULL PRIMARY KEY, 
assortimenti_id INTEGER, 
catalogo_id integer, 
ordinatore integer
)""");

        await db.execute("DROP TABLE IF EXISTS catalogo");
        await db.execute("""
CREATE TABLE catalogo ( 
id INTEGER NOT NULL PRIMARY KEY, 
nome CHAR(100,0), 
descrizione TEXT, 
famiglia INTEGER, 
nuovo INTEGER, 
sospeso INTEGER, 
ordinatore INTEGER, 
primo_codice INTEGER
)""");

        await db.execute("DROP TABLE IF EXISTS catalogo_img");
        await db.execute("""
CREATE TABLE catalogo_img ( 
catalogo_id INTEGER NOT NULL PRIMARY KEY, 
immagine TEXT, 
immagine_preview TEXT
)""");

        await db.execute("DROP TABLE IF EXISTS clienti");
        await db.execute("""
CREATE TABLE clienti ( 
id INTEGER NOT NULL PRIMARY KEY, 
agenti_id INTEGER,
ragione_sociale CHAR(50,0), 
localita CHAR(40,0), 
indirizzo TEXT, 
username CHAR(20,0), 
sede CHAR(1,0), 
codice CHAR(4,0), 
stato INTEGER, 
videocatalogo_disattivato INTEGER, 
offerte_disattivate INTEGER,
comunicazioni_disattivate INTEGER,
ordini_disattivati INTEGER,
servizi_disattivati INTEGER,
disponibilita_disattivate INTEGER,
prezzi_non_visibili INTEGER,
giacenze_disattivate INTEGER
)""");

        await db.execute("DROP TABLE IF EXISTS codici");
        await db.execute("""
CREATE TABLE codici ( 
id INTEGER NOT NULL PRIMARY KEY, 
catalogo_id INTEGER, 
numero CHAR(6,0), 
descrizione TEXT, 
apribile INTEGER, 
nuovo INTEGER, 
sospeso INTEGER, 
pezzi REAL, 
prezzo REAL, 
um CHAR(2,0), 
iva INTEGER,
spedizione_categoria_codice CHAR(2,0), 
quantita_massima INTEGER
)""");

        await db.execute("DROP TABLE IF EXISTS comunicazioni");
        await db.execute("""
CREATE TABLE comunicazioni ( 
id INTEGER NOT NULL PRIMARY KEY, 
oggetto text(80,0), 
da_leggere integer, 
data text, 
username text(5,0), 
comunicazione_testo TEXT, 
comunicazione_blob TEXT
)""");

        await db.execute("DROP TABLE IF EXISTS disponibilita");
        await db.execute("""
CREATE TABLE disponibilita ( 
codice CHAR(6,0) NOT NULL PRIMARY KEY, 
descrizione CHAR(40,0), 
stato INTEGER, 
data_arrivo CHAR(10,0)
)""");

        await db.execute("DROP TABLE IF EXISTS famiglie");
        await db.execute("""
CREATE TABLE famiglie ( 
id integer NOT NULL PRIMARY KEY AUTOINCREMENT, 
codice integer, 
descrizione text(50,0), 
colore text(15,0), 
abbreviazione text(3,0)
)""");

        await db.execute(
            "insert into famiglie ( codice, descrizione, colore, abbreviazione) values ( 1, 'Giardinaggio', '0xFF009900', 'Gia');");
        await db.execute(
            "insert into famiglie ( codice, descrizione, colore, abbreviazione) values ( 2, 'Edilizia', '0xFF0099FF', 'Edi');");
        await db.execute(
            "insert into famiglie ( codice, descrizione, colore, abbreviazione) values ( 3, 'Utensili a mano', '0xFFEE0000', 'Ute');");
        await db.execute(
            "insert into famiglie ( codice, descrizione, colore, abbreviazione) values ( 4, 'Utensili elettrici', '0xFFFFDD00', 'Ele');");
        await db.execute(
            "insert into famiglie ( codice, descrizione, colore, abbreviazione) values ( 5, 'Idraulica', '0xFFFF0099', 'Idr');");
        await db.execute(
            "insert into famiglie ( codice, descrizione, colore, abbreviazione) values ( 6, 'Siderurgia', '0xFF663300', 'Sid');");
        await db.execute(
            "insert into famiglie ( codice, descrizione, colore, abbreviazione) values ( 7, 'Ferramenta', '0xFF000099', 'Fer');");
        await db.execute(
            "insert into famiglie ( codice, descrizione, colore, abbreviazione) values ( 8, 'Domo utility', '0xFFFF6600', 'Dom');");

        await db.execute("DROP TABLE IF EXISTS invio");
        await db.execute("""
CREATE TABLE invio ( 
id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
utente_id INTEGER, 
ricezione_id INTEGER, 
mittente_id INTEGER, 
mittente_tipo CHAR(2,0), 
ordini_inviati INTEGER, 
clienti_inviati INTEGER, 
note_inviate INTEGER, 
linee_inviate INTEGER, 
resi_inviati INTEGER, 
ordine TEXT, 
resi TEXT, 
data_spedizione INTEGER, 
ora_spedizione TEXT
)""");

        await db.execute("DROP TABLE IF EXISTS moduli");
        await db.execute("""
CREATE TABLE moduli ( 
id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
tipo CHAR(50,0), 
data_registrazione INTEGER, 
data_invio INTEGER, 
data_reinvio INTEGER, 
data_ricezione INTEGER, 
inviare INTEGER, 
descrizione CHAR(50,0), 
modulo TEXT
)""");

        await db.execute("DROP TABLE IF EXISTS note");
        await db.execute("""
CREATE TABLE note ( 
id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
agenti_id INTEGER, 
clienti_id INTEGER, 
numero INTEGER, 
note TEXT
)""");

        await db.execute("DROP TABLE IF EXISTS ordini");
        await db.execute("""
CREATE TABLE ordini ( 
id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
clienti_id INTEGER, 
agenti_id INTEGER, 
numero INTEGER, 
codice CHAR(6,0), 
descrizione TEXT, 
um CHAR(2,0), 
quantita REAL, 
prezzo REAL, 
prezzo_ordine REAL
)""");

        await db.execute("DROP TABLE IF EXISTS promozioni");
        await db.execute("""
CREATE TABLE promozioni ( 
id INTEGER NOT NULL PRIMARY KEY, 
nome TEXT(100,0), 
sconto TEXT(2,0), 
permanente TEXT, 
tour TEXT(15,0), 
ordinatore integer
)""");

        await db.execute("DROP TABLE IF EXISTS promozioni_codici");
        await db.execute("""
CREATE TABLE promozioni_codici ( 
promozioni_id INTEGER, 
catalogo_id integer, 
ordinatore integer
)""");

        await db.execute("DROP TABLE IF EXISTS promozioni_img");
        await db.execute("""
CREATE TABLE promozioni_img ( 
promozioni_id INTEGER NOT NULL PRIMARY KEY, 
immagine TEXT, 
immagine_preview TEXT
)""");

        await db.execute("DROP TABLE IF EXISTS promozioni_new");
        await db.execute("""
CREATE TABLE promozioni_new ( 
promozioni_id INTEGER NOT NULL PRIMARY KEY, 
immagine TEXT, 
immagine_preview TEXT
)""");

        await db.execute("DROP TABLE IF EXISTS resi");
        await db.execute("""
CREATE TABLE resi ( 
id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
clienti_id INTEGER, 
agenti_id INTEGER, 
numero INTEGER, 
codice CHAR(6,0), 
descrizione TEXT, 
um CHAR(2,0), 
quantita REAL, 
causale_reso INTEGER, 
fattura_data CHAR(10,0), 
fattura_numero CHAR(10,0), 
note TEXT
)""");

        await db.execute("DROP TABLE IF EXISTS codici_ean");
        await db.execute("""
CREATE TABLE codici_ean ( 
id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
codice_articolo CHAR(6,0), 
codice_ean CHAR(20,0)
)""");

        await db.execute(
            "CREATE INDEX codice_ean_codice_articolo_indice ON codici_ean (codice_articolo ASC)");
        await db.execute(
            "CREATE INDEX codice_ean_codice_ean_indice ON codici_ean (codice_ean ASC)");

        await db.execute("DROP TABLE IF EXISTS giacenze");
        await db.execute("""
CREATE TABLE giacenze ( 
id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
codice_articolo CHAR(6,0),
quantita REAL 
)""");

        await db.execute(
            "CREATE INDEX giacenze_codice_articolo_indice ON giacenze (codice_articolo ASC)");

        await db.execute("DROP TABLE IF EXISTS referenze_agenti");
        await db.execute("""
CREATE TABLE referenze_agenti ( 
id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
codice_articolo CHAR(6,0)
)""");

        await db.execute(
            "CREATE INDEX referenze_agenti_codice_articolo_indice ON referenze_agenti (codice_articolo ASC)");

        await db.execute("DROP TABLE IF EXISTS schede");
        await db.execute("""
CREATE TABLE schede ( 
id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
catalogo_id INTEGER, 
tipo CHAR(20,0),
file_nome CHAR(255,0)
)""");

        await db.execute(
            "CREATE INDEX schede_catalogo_id_indice ON schede (catalogo_id ASC)");

        await db.execute("DROP TABLE IF EXISTS spedizione_categorie");
        await db.execute("""
CREATE TABLE spedizione_categorie ( 
id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
codice CHAR(2,0),
colore text(15,0), 
descrizione CHAR(30,0)
)""");

        await db.execute(
            "insert into spedizione_categorie ( codice, colore, descrizione) values ( 'X', '0xFFFFB796', 'X');");
        await db.execute(
            "insert into spedizione_categorie ( codice, colore, descrizione) values ( 'Y', '0xFF8FFE8F', 'Y');");
        await db.execute(
            "insert into spedizione_categorie ( codice, colore, descrizione) values ( 'W', '0xFFFDC5FF', 'W');");
        await db.execute(
            "insert into spedizione_categorie ( codice, colore, descrizione) values ( 'Z', '0xFF8EC5FF', 'Z');");

        await db.execute(
            "CREATE INDEX agenti_codice_indice ON agenti (codice ASC)");
        await db
            .execute("CREATE INDEX agenti_sede_indice ON agenti (sede ASC)");
        await db.execute(
            "CREATE INDEX assortimenti_descrizione_indice ON assortimenti (descrizione ASC)");
        await db.execute(
            "CREATE INDEX assortimenti_codici_catalogo_id_indice ON assortimenti_codici (catalogo_id ASC)");
        await db.execute(
            "CREATE INDEX catalogo_nome_indice ON catalogo (nome ASC)");
        await db.execute(
            "CREATE INDEX catalogo_sospeso_indice ON catalogo (sospeso ASC)");
        await db.execute(
            "CREATE INDEX catalogo_nuovo_indice ON catalogo (nuovo ASC)");
        await db.execute(
            "CREATE INDEX catalogo_famiglia_indice ON catalogo (famiglia ASC)");
        await db.execute(
            "CREATE INDEX clienti_ragione_sociale_indice ON clienti (ragione_sociale ASC)");
        await db.execute(
            "CREATE INDEX clienti_codice_indice ON clienti (codice ASC)");
        await db
            .execute("CREATE INDEX clienti_sede_indice ON clienti (sede ASC)");
        await db.execute(
            "CREATE INDEX codici_catalogo_id_indice ON codici (catalogo_id ASC)");
        await db.execute(
            "CREATE INDEX codici_sospeso_indice ON codici (sospeso ASC)");
        await db
            .execute("CREATE INDEX codici_nuovo_indice ON codici (nuovo ASC)");
        await db.execute(
            "CREATE INDEX comunicazioni_oggetto_indice ON comunicazioni (oggetto ASC)");
        await db.execute(
            "CREATE INDEX famiglie_codice_indice ON famiglie (codice ASC)");
        await db.execute(
            "CREATE INDEX invio_utente_id_indice ON invio (utente_id ASC)");
        await db.execute(
            "CREATE INDEX invio_ricezione_id_indice ON invio (ricezione_id ASC)");
        await db.execute(
            "CREATE INDEX invio_mittente_id_indice ON invio (mittente_id ASC)");
        await db.execute(
            "CREATE INDEX invio_mittente_tipo_indice ON invio (mittente_tipo ASC)");
        await db.execute(
            "CREATE INDEX note_clienti_id_indice ON note (clienti_id ASC)");
        await db.execute(
            "CREATE INDEX note_agenti_id_indice ON note (agenti_id ASC)");
        await db.execute(
            "CREATE INDEX note_numero_indice ON note (numero ASC)");
        await db.execute(
            "CREATE INDEX ordini_clienti_id_indice ON ordini (clienti_id ASC)");
        await db.execute(
            "CREATE INDEX ordini_agenti_id_indice ON ordini (agenti_id ASC)");
        await db.execute(
            "CREATE INDEX ordini_numero_indice ON ordini (numero ASC)");
        await db.execute(
            "CREATE INDEX ordini_codice_indice ON ordini (codice ASC)");
        await db.execute(
            "CREATE INDEX promozioni_nome_indice ON promozioni (nome ASC)");
        await db.execute(
            "CREATE INDEX promozioni_codici_promozioni_id_indice ON promozioni_codici (promozioni_id ASC)");
        await db.execute(
            "CREATE INDEX resi_clienti_id_indice ON resi (clienti_id ASC)");
        await db.execute(
            "CREATE INDEX resi_agenti_id_indice ON resi (agenti_id ASC)");
        await db.execute(
            "CREATE INDEX resi_numero_indice ON resi (numero ASC)");
        await db.execute(
            "CREATE INDEX resi_codice_indice ON resi (codice ASC)");
      },
    );

    return database;
  }

  Future<bool> utente_registra(
      {required String username,
      required String password,
      required String codice_attivazione}) async {
    // crea l'oggetto con i dati da inviare
    // chiama HttpRepository che fa la chiamata http e restituisce la risposta
    // elabora la risposta,
    // - aggiornail db
    // - ricarica prametri
    // - restituisce esito/mostra errori

    print("dbRepositoty utente_registra inizio");

    bool esito = true;
    Map<String, dynamic> risposta = {};

    Map<String, dynamic> data_invio = {};
    data_invio["azione"] = "Post.Aggior.Registrazione";
    data_invio["azione_versione"] = 1;
    data_invio["username"] = username;
    data_invio["videocatalogo_versione"] = VIDEOCATALOGO_VERSIONE;
    data_invio["videocatalogo_uid"] =
        GetIt.instance<ParametriModel>().videocatalogo_uid;
    data_invio["dispositivo_codice"] =
        GetIt.instance<ParametriModel>().codice_macchina;
    data_invio["dispositivo_tipo"] = VIDEOCATALOGO_DISPOSIVITO_TIPO;

    // presenti in base al tipo di chimata
    data_invio["codice_attivazione"] = codice_attivazione;

    if (esito == true) {
      try {
        risposta = await GetIt.instance<HttpRepository>()
            .http!
            .utente_registra(data_invio: data_invio);
      } on DatabaseException catch (e) {
        if (e.isNoSuchTableError()) {
          esito = false;
          print("Errore inizializzazione parametri");
        }
      }
      // print("dbRepository utente_registra: " + risposta.toString());
    }
    // $o_output.esito_codice:=0
    // $o_output.esito_descrizione:=""
    // $o_output.errori:=New collection
    // $o_output.sql_eseguire:=New collection
    // $o_output.codice_attivazione_nuovo:=""
    // $o_output.videocatalogo_uid:=""

    if (esito == true) {
      if (risposta["esito_codice"] == 0) {
        esito = true;
        try {
          List<dynamic> sql_eseguire = [];
          sql_eseguire = risposta["sql_eseguire"];
          // aggiorna i dati e i parametri
          await database.transaction((txn) async {
            sql_eseguire.forEach((sql_eseguire_riga) async {
              await database.execute(sql_eseguire_riga.toString());
            });
          });

          // ricaricare i parametri
          await GetIt.instance<ParametriModel>().inizializza();
          await GetIt.instance<ParametriModel>().password_aggiorna(password);
        } on DatabaseException catch (errore_db) {
          esito = false;
          print("Errore sql: " + errore_db.toString());
        }
      } else {
        print(risposta["errori"].toString());
        esito = false;
      }
    }

    print("dbRepositoty utente_registra fine");

    return esito;
  }

  Future<bool> dati_aggiorna() async {
    print("dbRepositoty dati_aggiorna inizio");

    bool esito = true;
    Map<String, dynamic> risposta = {};

    Map<String, dynamic> data_invio = {};
    data_invio["azione"] = "Post.Aggior.Dati";
    data_invio["azione_versione"] = 1;
    data_invio["username"] = GetIt.instance<ParametriModel>().username;
    data_invio["videocatalogo_versione"] = VIDEOCATALOGO_VERSIONE;
    data_invio["videocatalogo_uid"] =
        GetIt.instance<ParametriModel>().videocatalogo_uid;
    data_invio["dispositivo_codice"] =
        GetIt.instance<ParametriModel>().codice_macchina;
    data_invio["dispositivo_tipo"] = VIDEOCATALOGO_DISPOSIVITO_TIPO;

    // presenti in base al tipo di chimata
    data_invio["aggiornamento_id_ultimo"] =
        GetIt.instance<ParametriModel>().agg_dati_id;

    if (esito == true) {
      try {
        risposta = await GetIt.instance<HttpRepository>()
            .http!
            .dati_aggiorna(data_invio: data_invio);
      } on DatabaseException catch (e) {
        if (e.isNoSuchTableError()) {
          esito = false;
          print("Errore inizializzazione parametri");
        }
      }
      print("dbRepository dati_aggiorna: " + risposta.toString());
    }
    //$o_output.esito_codice:=0
    //$o_output.esito_descrizione:=""
    //$o_output.errori:=New collection
    //$o_output.sql_eseguire:=""
    //$o_output.videocatalogo_uid:=""
    //$o_output.aggiornamento_id_ultimo:=0

    if (esito == true) {
      if (risposta["esito_codice"] == 0) {
        esito = true;
        try {
          List<dynamic> sql_eseguire = [];
          sql_eseguire = risposta["sql_eseguire"];
          // aggiorna i dati e i parametri

          print(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()) +
              " - " +
              "Esecuzione query inizio");

          for (String sql_eseguire_riga in sql_eseguire) {
            await database.execute(sql_eseguire_riga);
            // print(sql_eseguire_riga);
          }
          // await database.transaction((txn) async {
          //   sql_eseguire.forEach((sql_eseguire_riga) async {
          //     await database.execute(sql_eseguire_riga.toString());
          //   });
          // });

          print(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()) +
              " - " +
              "Esecuzione query fine");

          // ricaricare i parametri
          int aggiornamento_id_ultimo_int = risposta["aggiornamento_id_ultimo"];

          if (GetIt.instance<ParametriModel>().agg_dati_id !=
              aggiornamento_id_ultimo_int) {
            GetIt.instance<ParametriModel>()
                .agg_dati_id_aggiorna(aggiornamento_id_ultimo_int);
          }
        } on DatabaseException catch (errore_db) {
          esito = false;
          print(DateFormat("yyyy-MM-dd HH:mm:ss").toString() +
              " - " +
              "Errore sql: " +
              errore_db.toString());
        }
      } else {
        print(risposta["errori"].toString());
        esito = false;
      }
    }

    print("dbRepositoty dati_aggiorna fine");

    return esito;
  }

  Future<bool> comunicazioni_aggiorna() async {
    print("dbRepositoty comunicazioni_aggiorna inizio");

    bool esito = true;
    Map<String, dynamic> risposta = {};

    Map<String, dynamic> data_invio = {};
    data_invio["azione"] = "Aggiornamento.Com.Cerca";
    data_invio["azione_versione"] = 1;
    data_invio["username"] = GetIt.instance<ParametriModel>().username;
    data_invio["videocatalogo_versione"] = VIDEOCATALOGO_VERSIONE;
    data_invio["videocatalogo_uid"] =
        GetIt.instance<ParametriModel>().videocatalogo_uid;
    data_invio["dispositivo_codice"] =
        GetIt.instance<ParametriModel>().codice_macchina;
    data_invio["dispositivo_tipo"] = VIDEOCATALOGO_DISPOSIVITO_TIPO;

    // presenti in base al tipo di chimata
    data_invio["aggiornamento_id_ultimo"] =
        GetIt.instance<ParametriModel>().agg_comunicazioni_id;

    if (esito == true) {
      try {
        risposta = await GetIt.instance<HttpRepository>()
            .http!
            .comunicazioni_aggiorna(data_invio: data_invio);
      } on DatabaseException catch (e) {
        if (e.isNoSuchTableError()) {
          esito = false;
          print("Errore inizializzazione parametri");
        }
      }
      print("dbRepository comunicazioni_aggiorna: " + risposta.toString());
    }
    //$o_output.esito_codice:=0
    //$o_output.esito_descrizione:=""
    //$o_output.errori:=New collection
    //$o_output.sql_eseguire:=""
    //$o_output.videocatalogo_uid:=""
    //$o_output.comunicazioni_id_aggiornare:=lista id comunicazioni da scaricare

    if (esito == true) {
      if (risposta["esito_codice"] == 0) {
        esito = true;

        if (risposta["comunicazioni_id_aggiornare"].length > 0) {
          List<dynamic> comunicazioni_id_aggiornare = [];
          comunicazioni_id_aggiornare = risposta["comunicazioni_id_aggiornare"];
          // aggiorna le comunicazioni

          for (int comunicazioni_id in comunicazioni_id_aggiornare) {
            final valid = await GetIt.instance<DbRepository>()
                .comunicazioni_aggiorna_scarica(
                    comunicazione_id_aggiornare: comunicazioni_id);
            if (valid) {
              print("Aggiornamento completato");
            } else {
              print("Errore durante l'aggiornamento");
            }
          }
        }
      } else {
        print(risposta["errori"].toString());
        esito = false;
      }
    }

    print("dbRepositoty comunicazioni_aggiorna fine");

    return esito;
  }

  Future<bool> comunicazioni_aggiorna_scarica(
      {int comunicazione_id_aggiornare = 0}) async {
    print("dbRepositoty comunicazioni_aggiorna_scarica inizio");

    bool esito = true;
    Map<String, dynamic> risposta = {};

    Map<String, dynamic> data_invio = {};
    data_invio["azione"] = "Aggiornamento.Com";
    data_invio["azione_versione"] = 1;
    data_invio["username"] = GetIt.instance<ParametriModel>().username;
    data_invio["videocatalogo_versione"] = VIDEOCATALOGO_VERSIONE;
    data_invio["videocatalogo_uid"] =
        GetIt.instance<ParametriModel>().videocatalogo_uid;
    data_invio["dispositivo_codice"] =
        GetIt.instance<ParametriModel>().codice_macchina;
    data_invio["dispositivo_tipo"] = VIDEOCATALOGO_DISPOSIVITO_TIPO;

    // presenti in base al tipo di chimata
    data_invio["aggiornamento_id_ultimo"] = comunicazione_id_aggiornare;

    if (esito == true) {
      try {
        risposta = await GetIt.instance<HttpRepository>()
            .http!
            .comunicazioni_aggiorna(data_invio: data_invio);
      } on DatabaseException catch (e) {
        if (e.isNoSuchTableError()) {
          esito = false;
          print("Errore inizializzazione parametri");
        }
      }
      // print("dbRepository comunicazioni_aggiorna_scarica: " +
      //     risposta.toString());
    }
    //$o_output.esito_codice:=0
    //$o_output.esito_descrizione:=""
    //$o_output.errori:=New collection
    //$o_output.sql_eseguire:=""
    //$o_output.videocatalogo_uid:=""
    //$o_output.comunicazioni_id_aggiornare:=lista id comunicazioni da scaricare

    if (esito == true) {
      if (risposta["esito_codice"] == 0) {
        esito = true;
        try {
          List<dynamic> sql_eseguire = [];
          sql_eseguire = risposta["sql_eseguire"];
          // aggiorna i dati e i parametri
          await database.transaction((txn) async {
            sql_eseguire.forEach((sql_eseguire_riga) async {
              await database.execute(sql_eseguire_riga.toString());
            });
          });

          // ricaricare i parametri
          int aggiornamento_id_ultimo_int = risposta["aggiornamento_id_ultimo"];
          if (GetIt.instance<ParametriModel>().agg_comunicazioni_id !=
              aggiornamento_id_ultimo_int) {
            GetIt.instance<ParametriModel>()
                .agg_comunicazioni_id_aggiorna(aggiornamento_id_ultimo_int);
          }
        } on DatabaseException catch (errore_db) {
          esito = false;
          print("Errore sql: " + errore_db.toString());
        }
      } else {
        print(risposta["errori"].toString());
        esito = false;
      }
    }

    print("dbRepositoty comunicazioni_aggiorna_scarica fine");

    return esito;
  }

  Future<bool> immagini_aggiorna() async {
    print("dbRepositoty immagini_aggiorna inizio");

    bool esito = true;
    Map<String, dynamic> risposta = {};

    Map<String, dynamic> data_invio = {};
    data_invio["azione"] = "Aggiornamento.Img.Cerca";
    data_invio["azione_versione"] = 1;
    data_invio["username"] = GetIt.instance<ParametriModel>().username;
    data_invio["videocatalogo_versione"] = VIDEOCATALOGO_VERSIONE;
    data_invio["videocatalogo_uid"] =
        GetIt.instance<ParametriModel>().videocatalogo_uid;
    data_invio["dispositivo_codice"] =
        GetIt.instance<ParametriModel>().codice_macchina;
    data_invio["dispositivo_tipo"] = VIDEOCATALOGO_DISPOSIVITO_TIPO;

    // presenti in base al tipo di chimata
    data_invio["aggiornamento_id_ultimo"] =
        GetIt.instance<ParametriModel>().agg_immagini_id;

    if (esito == true) {
      try {
        risposta = await GetIt.instance<HttpRepository>()
            .http!
            .immagini_aggiorna(data_invio: data_invio);
      } on DatabaseException catch (e) {
        if (e.isNoSuchTableError()) {
          esito = false;
          print("Errore inizializzazione parametri");
        }
      }
      print("dbRepository immagini_aggiorna: " + risposta.toString());
    }
    //$o_output.esito_codice:=0
    //$o_output.esito_descrizione:=""
    //$o_output.errori:=New collection
    //$o_output.sql_eseguire:=""
    //$o_output.videocatalogo_uid:=""
    //$o_output.immagini_id_aggiornare:=lista id immagini da scaricare

    if (esito == true) {
      if (risposta["esito_codice"] == 0) {
        esito = true;

        if (risposta["immagini_id_aggiornare"].length > 0) {
          List<dynamic> immagini_id_aggiornare = [];
          immagini_id_aggiornare = risposta["immagini_id_aggiornare"];
          // aggiorna le immagini

          for (int immagini_id in immagini_id_aggiornare) {
            final valid = await GetIt.instance<DbRepository>()
                .immagini_aggiorna_scarica(immagine_id_aggiornare: immagini_id);
            if (valid) {
              print("Aggiornamento completato");
            } else {
              print("Errore durante l'aggiornamento");
            }
          }
        }
      } else {
        print(risposta["errori"].toString());
        esito = false;
      }
    }

    print("dbRepositoty immagini_aggiorna fine");

    return esito;
  }

  Future<bool> immagini_aggiorna_scarica(
      {int immagine_id_aggiornare = 0}) async {
    print("dbRepositoty immagini_aggiorna_scarica inizio");

    bool esito = true;
    Map<String, dynamic> risposta = {};

    Map<String, dynamic> data_invio = {};
    data_invio["azione"] = "Aggiornamento.Img";
    data_invio["azione_versione"] = 1;
    data_invio["username"] = GetIt.instance<ParametriModel>().username;
    data_invio["videocatalogo_versione"] = VIDEOCATALOGO_VERSIONE;
    data_invio["videocatalogo_uid"] =
        GetIt.instance<ParametriModel>().videocatalogo_uid;
    data_invio["dispositivo_codice"] =
        GetIt.instance<ParametriModel>().codice_macchina;
    data_invio["dispositivo_tipo"] = VIDEOCATALOGO_DISPOSIVITO_TIPO;

    // presenti in base al tipo di chimata
    data_invio["aggiornamento_id_ultimo"] = immagine_id_aggiornare;

    if (esito == true) {
      try {
        risposta = await GetIt.instance<HttpRepository>()
            .http!
            .immagini_aggiorna(data_invio: data_invio);
      } on DatabaseException catch (e) {
        if (e.isNoSuchTableError()) {
          esito = false;
          print("Errore inizializzazione parametri");
        }
      }
      // print("dbRepository immagini_aggiorna_scarica: " + risposta.toString());
    }
    //$o_output.esito_codice:=0
    //$o_output.esito_descrizione:=""
    //$o_output.errori:=New collection
    //$o_output.sql_eseguire:=""
    //$o_output.videocatalogo_uid:=""
    //$o_output.immagini_id_aggiornare:=lista id immagini da scaricare

    if (esito == true) {
      if (risposta["esito_codice"] == 0) {
        esito = true;
        try {
          List<dynamic> sql_eseguire = [];
          sql_eseguire = risposta["sql_eseguire"];
          // aggiorna i dati e i parametri
          await database.transaction((txn) async {
            sql_eseguire.forEach((sql_eseguire_riga) async {
              await database.execute(sql_eseguire_riga.toString());
            });
          });

          // ricaricare i parametri
          int aggiornamento_id_ultimo_int = risposta["aggiornamento_id_ultimo"];
          if (GetIt.instance<ParametriModel>().agg_immagini_id !=
              aggiornamento_id_ultimo_int) {
            GetIt.instance<ParametriModel>()
                .agg_immagini_id_aggiorna(aggiornamento_id_ultimo_int);
          }
        } on DatabaseException catch (errore_db) {
          esito = false;
          print("Errore sql: " + errore_db.toString());
        }
      } else {
        print(risposta["errori"].toString());
        esito = false;
      }
    }

    print("dbRepositoty immagini_aggiorna_scarica fine");

    return esito;
  }
}
