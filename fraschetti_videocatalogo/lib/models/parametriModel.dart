import 'package:flutter/foundation.dart';
import 'package:fraschetti_videocatalogo/main.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:sqflite/sqflite.dart';

// nella tabella parametri esisterà un solo record con id = 1

// definito come singleton all'avvio per avere sempre i parametri a disposizione e aggiornarli

class ParametriModel {
  Database? db = null;

  ParametriModel() {
    this.db = getIt.get<DbRepository>().database;
    // inizializza non funziona l'await nel costruttore
    // this.inizializza();
  }

  int id = 0;
  int agg_dati_id = 0;
  int agg_immagini_id = 0;
  int agg_comunicazioni_id = 0;
  int agg_codici_ean_id = 0;
  int agg_script_id = 0;
  int agg_sql_id = 0;
  int aggiornamento_obbligatorio = 0;
  int anagrafica_aggiornamento = 0;
  int promozioni_attivazione = 0;
  int sql_versione = 0;
  String host_server = "";
  String codice_macchina = "";
  String username = "";
  String password = "";
  String videocatalogo_uid = "";
  int log_attivo = 0;

  Future<void> inizializza() async {
    // carico il record con id = 1
    List<Map> results = [];

    try {
      print("parametri inizializza 1");
      //   results = async () {
      //   return await this.db!.query('parametri', where: 'id = ?', whereArgs: ['1']);
      // }

      // results = async() {
      //   return await this.db!.query(
      //       'parametri', where: 'id = ?', whereArgs: ['1']);
      // }

      results =
          await this.db!.query('parametri', where: 'id = ?', whereArgs: ['1']);

      // results = await this.inizializza_0();

      print("parametri inizializza 2");
    } on DatabaseException catch (e) {
      if (e.isNoSuchTableError()) {
        print("Errore inizializzazione parametri");
      }
    }
    if (results.length == 1) {
      print("parametri inizializza 3");
      id = results[0]["id"];
      agg_dati_id = results[0]["agg_dati_id"];
      agg_immagini_id = results[0]["agg_immagini_id"];
      agg_comunicazioni_id = results[0]["agg_comunicazioni_id"];
      agg_codici_ean_id = results[0]["agg_codici_ean_id"];
      agg_script_id = results[0]["agg_script_id"];
      agg_sql_id = results[0]["agg_sql_id"];
      aggiornamento_obbligatorio = results[0]["aggiornamento_obbligatorio"];
      anagrafica_aggiornamento = results[0]["anagrafica_aggiornamento"];
      promozioni_attivazione = results[0]["promozioni_attivazione"];
      sql_versione = results[0]["sql_versione"];
      host_server = results[0]["host_server"];
      codice_macchina = results[0]["codice_macchina"];
      username = results[0]["username"];
      password = results[0]["password"];
      videocatalogo_uid = results[0]["videocatalogo_uid"];
      log_attivo = results[0]["log_attivo"];
    } else {
      this._azzera_variabili();
    }

    var t1;
  }

  void _azzera_variabili() {
    id = 0;
    agg_dati_id = 0;
    agg_immagini_id = 0;
    agg_comunicazioni_id = 0;
    agg_codici_ean_id = 0;
    agg_script_id = 0;
    agg_sql_id = 0;
    aggiornamento_obbligatorio = 0;
    anagrafica_aggiornamento = 0;
    promozioni_attivazione = 0;
    sql_versione = 0;
    host_server = "http://www.fraschetti.com:8080";
    codice_macchina = "";
    username = "";
    password = "";
    videocatalogo_uid = "";
    log_attivo = 0;
  }
}
