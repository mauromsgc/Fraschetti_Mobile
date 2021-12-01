import 'package:flutter/foundation.dart';

class ParametriModel {

  // il costruttore con tutti i parametri lo uso solo per creare i record fake
  ParametriModel({
    this.agente_id = 0,
    this.log_attivo = 0,
    this.offerte_disattivate = 0,
    this.sospesi_mostra = 0,
    this.user_id = 0,
    this.user_in_attivita = 0,
    this.user_sede_codice = '',
    this.user_sede_sigla = '',
    this.user_tipo = '',
    this.user_tipo_interno = '',
    this.user_username = '',
    this.note = '',
  });

  int agente_id = 0;
  int log_attivo = 0;
  int offerte_disattivate = 0;
  int sospesi_mostra = 0;
  int user_id = 0;
  int user_in_attivita = 0;
  String user_sede_codice = '';
  String user_sede_sigla = '';
  String user_tipo = '';
  String user_tipo_interno = '';
  String user_username = '';
  String note = '';

}