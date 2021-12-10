import 'package:flutter/foundation.dart';
import 'package:fraschetti_videocatalogo/main.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:sqflite/sqflite.dart';

class UtenteCorrenteModel {

  Database? db = null;

  // definito come singleton all'avvio per avere sempre i dati a gisposizione
  // da richiamare dopo il login
  // e dopo aver caricato un oggetto parametri aggiornato

  UtenteCorrenteModel () {
    // carico i parametri e da quelli compilo tutte le proprietà
    this.db = getIt.get<DbRepository>().database;
    this.inizializza();
  }

  int agente_id = 0;  // id agente per utente agente, id agente del cliente per utente cliente
  int listino_id = 0;
  int cliente_id = 0;  // id cliente selezionato per utente agente, id cliente per utente cliente
  int user_id = 0;
  String cognome = '';
  String nome = '';
  String user_sede_codice = '';
  String user_sede_sigla = '';
  String user_codice = '';
  String user_tipo = '';
  String user_tipo_interno = '';
  String user_username = '';
  int log_attivo = 0;
  int user_in_attivita = 0;
  int sospesi_mostra = 0;
  int preventivi_abilitati = 0;
  int offerte_disattivate = 0;
  int comunicazioni_disattivate = 0;
  int ordini_dasattivati = 0;
  int servizi_disattivati = 0;
  int disponibilita_disattivate = 0;
  int prezzi_non_visibili = 0;
  int moduli_disattivati = 0;
  int giacenze_disattivate = 0;

  void inizializza(){

  }

}