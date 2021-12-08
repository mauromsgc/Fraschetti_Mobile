import 'package:flutter/foundation.dart';

class ParametriModel {

  // il costruttore con tutti i parametri lo uso solo per creare i record fake
  ParametriModel({
    this.id = 0,
    this.agg_dati_id = 0,
    this.agg_immagini_id = 0,
    this.agg_comunicazioni_id = 0,
    this.agg_codici_ean_id = 0,
    this.agg_script_id = 0,
    this.agg_sql_id = 0,
    this.aggiornamento_obbligatorio = 0,
    this.anagrafica_aggiornamento = 0,
    this.promozioni_attivazione = 0,
    this.sql_versione = 0,
    this.host_server = '',
    this.codice_macchina = '',
    this.username = '',
    this.password = '',
    this.videocatalogo_uid = '',
    this.log_attivo = 0,
  });

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
  String host_server = '';
  String codice_macchina = '';
  String username = '';
  String password = '';
  String videocatalogo_uid = '';
  int log_attivo = 0;

}