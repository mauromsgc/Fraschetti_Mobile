import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DbRepository {
  final Database database;

  DbRepository(this.database);

  static Future<DbRepository> newConnection() async {
    final databasesPath = await getDatabasesPath();
    final databasePath = path.join(databasesPath, "videocatalogo.db");

    final int db_versione = 1;
    final database = await openDatabase(
      databasePath,
      version: db_versione,
      onCreate: (Database db, int version) async {
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
acquisti INTEGER
)""");

        await db.execute("DROP TABLE IF EXISTS assortimenti");
        await db.execute("""
CREATE TABLE assortimenti ( 
id INTEGER NOT NULL PRIMARY KEY, 
descrizione TEXT(100,0), 
ordinatore integer
)""");

        await db.execute("DROP TABLE IF EXISTS assortimenti_codici");
        await db.execute("""
CREATE TABLE assortimenti_codici ( 
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
primo_codice integer
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
ragione_sociale CHAR(50,0), 
localita CHAR(40,0), 
indirizzo TEXT, 
username CHAR(20,0), 
sede CHAR(1,0), 
codice CHAR(4,0), 
stato INTEGER, 
videocatalogo_disattivato INTEGER, 
offerte_disattivate INTEGER, 
agente_id INTEGER
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
pezzi INTEGER, 
prezzo REAL, 
um CHAR(2,0), 
iva INTEGER
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
colore text(10,0), 
abbreviazione text(3,0)
)""");

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
agente_id INTEGER, 
cliente_id INTEGER, 
ordini_numero INTEGER, 
note TEXT
)""");

        await db.execute("DROP TABLE IF EXISTS ordini");
        await db.execute("""
CREATE TABLE ordini ( 
id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
cliente_id INTEGER, 
agente_id INTEGER, 
ordini_numero INTEGER, 
articolo_codice CHAR(6,0), 
descrizione TEXT, 
um CHAR(2,0), 
quantita REAL, 
prezzo REAL, 
prezzoordine REAL
)""");

        await db.execute("DROP TABLE IF EXISTS parametri");
        await db.execute("""
CREATE TABLE parametri ( 
id integer NOT NULL PRIMARY KEY AUTOINCREMENT, 
parametro text(50,0), 
valore text
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
promozione_id INTEGER, 
catalogo_id integer, 
ordinatore integer
)""");

        await db.execute("DROP TABLE IF EXISTS promozioni_img");
        await db.execute("""
CREATE TABLE promozioni_img ( 
promozione_id INTEGER NOT NULL PRIMARY KEY, 
immagine TEXT, 
immagine_preview TEXT
)""");

        await db.execute("DROP TABLE IF EXISTS promozioni_new");
        await db.execute("""
CREATE TABLE promozioni_new ( 
promozione_id INTEGER NOT NULL PRIMARY KEY, 
immagine TEXT
)""");

        await db.execute("DROP TABLE IF EXISTS resi");
        await db.execute("""
CREATE TABLE resi ( 
id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
cliente_id INTEGER, 
agente_id INTEGER, 
resinumero INTEGER, 
articolo_codice CHAR(6,0), 
descrizione TEXT, 
um CHAR(2,0), 
quantita REAL, 
causale_reso INTEGER, 
fattura_data CHAR(10,0), 
fattura_numero CHAR(10,0), 
note TEXT
)""");

        await db.execute("CREATE INDEX agenti_codice_indice ON agenti (codice ASC)");
        await db.execute("CREATE INDEX agenti_sede_indice ON agenti (sede ASC)");
        await db.execute("CREATE INDEX assortimenti_descrizione_indice ON assortimenti (descrizione ASC)");
        await db.execute("CREATE INDEX assortimenti_codici_catalogo_id_indice ON assortimenti_codici (catalogo_id ASC)");
        await db.execute("CREATE INDEX catalogo_nome_indice ON catalogo (nome ASC)");
        await db.execute("CREATE INDEX catalogo_sospeso_indice ON catalogo (sospeso ASC)");
        await db.execute("CREATE INDEX catalogo_nuovo_indice ON catalogo (nuovo ASC)");
        await db.execute("CREATE INDEX catalogo_famiglia_indice ON catalogo (famiglia ASC)");
        await db.execute("CREATE INDEX clienti_ragione_sociale_indice ON clienti (ragione_sociale ASC)");
        await db.execute("CREATE INDEX clienti_codice_indice ON clienti (codice ASC)");
        await db.execute("CREATE INDEX clienti_sede_indice ON clienti (sede ASC)");
        await db.execute("CREATE INDEX codici_catalogo_id_indice ON codici (catalogo_id ASC)");
        await db.execute("CREATE INDEX codici_sospeso_indice ON codici (sospeso ASC)");
        await db.execute("CREATE INDEX codici_nuovo_indice ON codici (nuovo ASC)");
        await db.execute("CREATE INDEX comunicazioni_oggetto_indice ON comunicazioni (oggetto ASC)");
        await db.execute("CREATE INDEX famiglie_codice_indice ON famiglie (codice ASC)");
        await db.execute("CREATE INDEX invio_utente_id_indice ON invio (utente_id ASC)");
        await db.execute("CREATE INDEX invio_ricezione_id_indice ON invio (ricezione_id ASC)");
        await db.execute("CREATE INDEX invio_mittente_id_indice ON invio (mittente_id ASC)");
        await db.execute("CREATE INDEX invio_mittente_tipo_indice ON invio (mittente_tipo ASC)");
        await db.execute("CREATE INDEX note_cliente_id_indice ON note (cliente_id ASC)");
        await db.execute("CREATE INDEX note_agente_id_indice ON note (agente_id ASC)");
        await db.execute("CREATE INDEX note_ordini_numero_indice ON note (ordini_numero ASC)");
        await db.execute("CREATE INDEX ordini_cliente_id_indice ON ordini (cliente_id ASC)");
        await db.execute("CREATE INDEX ordini_agente_id_indice ON ordini (agente_id ASC)");
        await db.execute("CREATE INDEX ordini_ordini_numero_indice ON ordini (ordini_numero ASC)");
        await db.execute("CREATE INDEX ordini_articolo_codice_indice ON ordini (articolo_codice ASC)");
        await db.execute("CREATE INDEX parametri_parametro_indice ON parametri (parametro ASC)");
        await db.execute("CREATE INDEX promozioni_nome_indice ON promozioni (nome ASC)");
        await db.execute("CREATE INDEX promozioni_codici_promozione_id_indice ON promozioni_codici (promozione_id ASC)");
        await db.execute("CREATE INDEX resi_cliente_id_indice ON resi (cliente_id ASC)");
        await db.execute("CREATE INDEX resi_agente_id_indice ON resi (agente_id ASC)");
        await db.execute("CREATE INDEX resi_resinumero_indice ON resi (resinumero ASC)");
        await db.execute("CREATE INDEX resi_articolo_codice_indice ON resi (articolo_codice ASC)");


      },

    );

    return DbRepository(database);
  }


}
