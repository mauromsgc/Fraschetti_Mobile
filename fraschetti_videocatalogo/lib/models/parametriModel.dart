import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/helper/DBHelper.dart';
import 'package:fraschetti_videocatalogo/main.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:fraschetti_videocatalogo/repositories/httpRepository.dart';
import 'package:fraschetti_videocatalogo/screen/trasmissioni/TrasmissioniProgressPage.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

const String VIDEOCATALOGO_VERSIONE = "0,01";
const String VIDEOCATALOGO_DISPOSIVITO_TIPO = "mobile_2";

// nella tabella parametri esisterà un solo record con id = 1

// definito come singleton all'avvio per avere sempre i parametri a disposizione e aggiornarli
class ParametriModel {
  static final ParametriModel _istanza = ParametriModel
      ._costruttore_privato();

  factory ParametriModel() {
    return _istanza;
  }

  // definito come singleton all'avvio per avere sempre i dati a disposizione
  // da richiamare dopo il login
  // dopo aver caricato un oggetto parametri aggiornato
  // dopo aggiornamento dati

  // i dati di stato dell'app li salvo nel singleton SessioneModel
  // cliente selezionato, numero ordine in corso ecc.

  ParametriModel._costruttore_privato(){
    // carico i parametri e da quelli compilo tutte le proprietà
    this.inizializza();
  }

  final Database? db = GetIt.instance<DbRepository>().database;

  int id = 0;
  int agg_dati_id = 0;
  int agg_immagini_id = 0;
  int agg_comunicazioni_id = 0;
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
    } on DatabaseException catch (errore_db) {
      // if (e.isNoSuchTableError()) {
      print("Errore inizializzazione parametri");
      // }
    }
    if (results.length == 1) {
      this.id = results[0]["id"];
      this.agg_dati_id = results[0]["agg_dati_id"];
      this.agg_immagini_id = results[0]["agg_immagini_id"];
      this.agg_comunicazioni_id = results[0]["agg_comunicazioni_id"];
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

  factory ParametriModel.fromMap(Map<String, dynamic> map) {
    ParametriModel oggetto = ParametriModel();

    oggetto.id = map["id"];
    oggetto.agg_dati_id = map["agg_dati_id"];
    oggetto.agg_immagini_id = map["agg_immagini_id"];
    oggetto.agg_comunicazioni_id = map["agg_comunicazioni_id"];
    oggetto.agg_sql_id = map["agg_sql_id"];
    oggetto.aggiornamento_obbligatorio = map["aggiornamento_obbligatorio"];
    oggetto.anagrafica_aggiornamento = map["anagrafica_aggiornamento"];
    oggetto.promozioni_attivazione = map["promozioni_attivazione"];
    oggetto.sql_versione = map["sql_versione"];
    oggetto.host_server = map["host_server"];
    oggetto.codice_macchina = map["codice_macchina"];
    oggetto.username = map["username"];
    oggetto.password = map["password"];
    oggetto.videocatalogo_uid = map["videocatalogo_uid"];
    oggetto.log_attivo = map["log_attivo"];

    return oggetto;
  }

  Map<String, dynamic> toMap() => {
    "id": id,
        "agg_dati_id": agg_dati_id,
        "agg_immagini_id": agg_immagini_id,
        "agg_comunicazioni_id": agg_comunicazioni_id,
        "agg_sql_id": agg_sql_id,
        "aggiornamento_obbligatorio": aggiornamento_obbligatorio,
        "anagrafica_aggiornamento": anagrafica_aggiornamento,
        "promozioni_attivazione": promozioni_attivazione,
        "sql_versione": sql_versione,
        "host_server": host_server,
        "codice_macchina": codice_macchina,
        "username": username,
        "password": password,
        "videocatalogo_uid": videocatalogo_uid,
        "log_attivo": log_attivo,
      };

  Future<bool> host_server_aggiorna(String? host_server) async {
    // bool host_server_aggiorna(String? host_server) async {
    // aggiorna la proprieta host_server

    int record_eleborati = 0;

    try {
      record_eleborati = await (await db!.update(
          'parametri', {'host_server': host_server},
          where: 'id = ?', whereArgs: ["1"]));
    } on DatabaseException catch (errore_db) {
      if (errore_db.isNoSuchTableError()) {
        print("Errore aggiornamento parametri");
      }
    }

    if (record_eleborati > 0) {
      await this.inizializza();
    } else {
      print("ParametriModel errore aggiornamento host_server");
    }

    return (record_eleborati > 0);
  }

  Future<bool> password_aggiorna(String? password) async {
     // aggiorna la proprieta password

    int record_eleborati = 0;

    try {
      record_eleborati = await (await db!.update(
          'parametri', {'password': password},
          where: 'id = ?', whereArgs: ["1"]));
    } on DatabaseException catch (errore_db) {
      if (errore_db.isNoSuchTableError()) {
        print("Errore aggiornamento parametri");
      }
    }

    if (record_eleborati > 0) {
      await this.inizializza();
    } else {
      print("ParametriModel errore aggiornamento host_server");
    }

    return (record_eleborati > 0);
  }

  Future<bool> agg_sql_id_aggiorna(int? agg_sql_id) async {
    // aggiorna la proprieta agg_sql_id

    int record_eleborati = 0;

    try {
      record_eleborati = await (await db!.update(
          'parametri', {'agg_sql_id': agg_sql_id},
          where: 'id = ?', whereArgs: ["1"]));
    } on DatabaseException catch (errore_db) {
      if (errore_db.isNoSuchTableError()) {
        print("Errore aggiornamento parametri");
      }
    }

    if (record_eleborati > 0) {
      print("parametri agg_sql_id_aggiorna 1");
      await this.inizializza();
      print("parametri agg_sql_id_aggiorna 2");
    } else {
      print("ParametriModel errore aggiornamento agg_sql_id_aggiorna");
    }

    return (record_eleborati > 0);
  }

  Future<bool> agg_dati_id_aggiorna(int? agg_dati_id) async {
    // aggiorna la proprieta agg_dati_id

    int record_eleborati = 0;

    try {
      record_eleborati = await (await db!.update(
          'parametri', {'agg_dati_id': agg_dati_id},
          where: 'id = ?', whereArgs: ["1"]));
    } on DatabaseException catch (errore_db) {
      if (errore_db.isNoSuchTableError()) {
        print("Errore aggiornamento parametri");
      }
    }

    if (record_eleborati > 0) {
      await this.inizializza();
    } else {
      print("ParametriModel errore aggiornamento agg_dati_id");
    }

    return (record_eleborati > 0);
  }

  Future<bool> agg_comunicazioni_id_aggiorna(int? agg_comunicazioni_id) async {
    // aggiorna la proprieta agg_comunicazioni_id

    int record_eleborati = 0;

    try {
      record_eleborati = await (await db!.update(
          'parametri', {'agg_comunicazioni_id': agg_comunicazioni_id},
          where: 'id = ?', whereArgs: ["1"]));
    } on DatabaseException catch (errore_db) {
      if (errore_db.isNoSuchTableError()) {
        print("Errore aggiornamento parametri");
      }
    }

    if (record_eleborati > 0) {
      print("parametri agg_comunicazioni_id_aggiorna 1");
      await this.inizializza();
      print("parametri agg_comunicazioni_id_aggiorna 2");
    } else {
      print("ParametriModel errore aggiornamento agg_comunicazioni_id_aggiorna");
    }

    return (record_eleborati > 0);
  }

  Future<bool> agg_immagini_id_aggiorna(int? agg_immagini_id) async {
    // aggiorna la proprieta agg_immagini_id

    int record_eleborati = 0;

    try {
      record_eleborati = await (await db!.update(
          'parametri', {'agg_immagini_id': agg_immagini_id},
          where: 'id = ?', whereArgs: ["1"]));
    } on DatabaseException catch (errore_db) {
      if (errore_db.isNoSuchTableError()) {
        print("Errore aggiornamento parametri");
      }
    }

    if (record_eleborati > 0) {
      print("parametri agg_immagini_id_aggiorna 1");
      await this.inizializza();
      print("parametri agg_immagini_id_aggiorna 2");
    } else {
      print("ParametriModel errore aggiornamento agg_immagini_id_aggiorna");
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



  Future<bool> aggiornamenti_controlla({StreamController<ProgressData>? progress_stream_con}) async {
    // cotrolla se ci sono aggiornamenti da scaricare

    progress_stream_con?.add(ProgressData(titolo: "Verifica aggiornamenti",
        messaggio: "Preparazione richiesta",
        progress: -1));

    print("dbRepositoty aggiornamenti_controlla inizio");

    bool esito = false;
    Map<String, dynamic> risposta = {};

    // dati generali
    Map<String, dynamic> data_invio = {};
    data_invio["azione"] = "Post.Aggior.AggiornamentiControlla";
    data_invio["azione_versione"] = 1;
    data_invio["username"] = username;
    data_invio["videocatalogo_versione"] = VIDEOCATALOGO_VERSIONE;
    data_invio["videocatalogo_uid"] = this.videocatalogo_uid;
    data_invio["dispositivo_codice"] = this.codice_macchina;
    data_invio["dispositivo_tipo"] = VIDEOCATALOGO_DISPOSIVITO_TIPO;

    // presenti in base al tipo di chimata
    // aggiungo tutti i campi dei parametri da verificare
    data_invio["aggiornamento_id_ultimo_immagini"] = this.agg_immagini_id;
    data_invio["aggiornamento_id_ultimo_dati"] = this.agg_dati_id;
    data_invio["aggiornamento_id_ultimo_script"] =
        this.agg_sql_id; // non utilizzato
    data_invio["aggiornamento_id_ultimo_comunicazioni"] =
        this.agg_comunicazioni_id;


    progress_stream_con?.add(ProgressData(messaggio: "Invio richiesta"));
    try {
      risposta = await GetIt
          .instance<HttpRepository>()
          .http!
          .aggiornamenti_controlla(data_invio: data_invio);
    } catch (exception) {
      progress_stream_con?.add(ProgressData(
          messaggio: "ERRORE RISPOSTA", errore: exception.toString()));
      print("Errore di connessione");
    } finally {
      progress_stream_con?.add(ProgressData(messaggio: "Ricevura risposta"));
    }

    if (risposta["aggiornamenti_presenti"] == true) {
      print("dbRepository aggiornamenti_controlla: " + risposta.toString());
      esito = true;
    } else {
      print(risposta["errori"].toString());
      esito = false;
    }

    print("dbRepositoty aggiornamenti_controlla fine");
    progress_stream_con?.add(ProgressData(messaggio: "Richiesta terminata"));

    return esito;
  }


}
