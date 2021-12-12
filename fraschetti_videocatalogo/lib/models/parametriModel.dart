import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/main.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:fraschetti_videocatalogo/repositories/httpRepository.dart';
import 'package:sqflite/sqflite.dart';

const String VIDEOCATALOGO_VERSIONE = "0.0.1";
const String VIDEOCATALOGO_DISPOSIVITO_TIPO = "mobile_2";

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

      results = await (await this
          .db!
          .query('parametri', where: 'id = ?', whereArgs: ["1"]));

      print("parametri inizializza 2");
    } on DatabaseException catch (e) {
      if (e.isNoSuchTableError()) {
        print("Errore inizializzazione parametri");
      }
    }
    if (results.length == 1) {
      print("parametri inizializza 3");
      this.id = results[0]["id"];
      this.agg_dati_id = results[0]["agg_dati_id"];
      this.agg_immagini_id = results[0]["agg_immagini_id"];
      this.agg_comunicazioni_id = results[0]["agg_comunicazioni_id"];
      this.agg_codici_ean_id = results[0]["agg_codici_ean_id"];
      this.agg_script_id = results[0]["agg_script_id"];
      this.agg_sql_id = results[0]["agg_sql_id"];
      this.aggiornamento_obbligatorio =
          results[0]["aggiornamento_obbligatorio"];
      this.anagrafica_aggiornamento = results[0]["anagrafica_aggiornamento"];
      this.promozioni_attivazione = results[0]["promozioni_attivazione"];
      this.sql_versione = results[0]["sql_versione"];
      this.host_server = results[0]["host_server"];
      this.codice_macchina = results[0]["codice_macchina"];
      this.username = results[0]["username"];
      this.password = results[0]["password"];
      this.videocatalogo_uid = results[0]["videocatalogo_uid"];
      this.log_attivo = results[0]["log_attivo"];
    } else {
      this._azzera_variabili();
    }

    var t1;
  }

  void _azzera_variabili() {
    this.id = 0;
    this.agg_dati_id = 0;
    this.agg_immagini_id = 0;
    this.agg_comunicazioni_id = 0;
    this.agg_codici_ean_id = 0;
    this.agg_script_id = 0;
    this.agg_sql_id = 0;
    this.aggiornamento_obbligatorio = 0;
    this.anagrafica_aggiornamento = 0;
    this.promozioni_attivazione = 0;
    this.sql_versione = 0;
    this.host_server = "http://www.fraschetti.com:8080";
    this.codice_macchina = "";
    this.username = "";
    this.password = "";
    this.videocatalogo_uid = "";
    this.log_attivo = 0;
  }

  Future<bool> host_server_aggiorna(String? host_server) async {
    // bool host_server_aggiorna(String? host_server) async {
    // aggiorna la proprieta host_server

    int record_eleborati = 0;

    try {

      record_eleborati = await(await db!.update('parametri', {'host_server': host_server}, where: 'id = ?', whereArgs: ["1"]));

    } on DatabaseException catch (e) {
      if (e.isNoSuchTableError()) {
        print("Errore inizializzazione parametri");
      }
    }

    if (record_eleborati > 0) {
      print("parametri host_server_aggiorna 1");
      await this.inizializza();
      print("parametri host_server_aggiorna 2");
    } else {
      print("ParametriModel errore aggiornamento host_server");
    }

    return (record_eleborati > 0);
  }


  bool utente_registrato() {
    // se non è presente la username l'utente non è ancora registrato
    bool utente_regisrtrato = false;

    if (this.username == "") {
      utente_regisrtrato = false;
    } else {
      utente_regisrtrato = true;
    }

    return utente_regisrtrato;
  }

}
