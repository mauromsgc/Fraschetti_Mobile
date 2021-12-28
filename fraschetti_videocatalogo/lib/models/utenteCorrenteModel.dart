import 'package:flutter/foundation.dart';
import 'package:fraschetti_videocatalogo/main.dart';
import 'package:fraschetti_videocatalogo/models/agenteModel.dart';
import 'package:fraschetti_videocatalogo/models/clienteModel.dart';
import 'package:fraschetti_videocatalogo/models/parametriModel.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

// va ricaricato/aggiornato al momneto
// della registrazione, del login e dopo l'ggiornamento dati

// class UtenteCorrenteModel {
//   static final UtenteCorrenteModel _istanza = UtenteCorrenteModel._costruttore_privato();
//
//   factory UtenteCorrenteModel() {
//     return _istanza;
//   }
//
//   UtenteCorrenteModel._costruttore_privato(){
//     // inizializzazione
//     String t1 ="";
//   }
//
// }

class UtenteCorrenteModel {
  static final UtenteCorrenteModel _istanza =
      UtenteCorrenteModel._costruttore_privato();

  factory UtenteCorrenteModel() {
    return _istanza;
  }

  // definito come singleton all'avvio per avere sempre i dati a disposizione
  // da richiamare dopo il login
  // dopo aver caricato un oggetto parametri aggiornato
  // dopo aggiornamento dati

  // i dati di stato dell'app li salvo nel singleton SessioneModel
  // cliente selezionato, numero ordine in corso ecc.

  UtenteCorrenteModel._costruttore_privato() {
    // carico i parametri e da quelli compilo tutte le proprietà
    this.inizializza();
  }

  int agente_id =
      0; // id agente per utente agente, id agente del cliente per utente cliente
  int cliente_id = 0; // id cliente per utente cliente
  int utente_id = 0;
  String cognome = "";
  String nome = "";
  String utente_sede_codice = "";
  String utente_sede_sigla = "";
  String utente_codice = "";
  String utente_tipo = "";
  String utente_tipo_interno = "";
  String utente_username = "";
  int log_attivo = 0;
  int utente_in_attivita = 1;
  int sospesi_mostra = 0;
  int preventivi_abilitati = 0;
  int offerte_disattivate = 0;
  int comunicazioni_disattivate = 0;
  int ordini_disattivati = 0;
  int servizi_disattivati = 0;
  int disponibilita_disattivate = 0;
  int prezzi_non_visibili = 0;
  int moduli_disattivati = 0;
  int giacenze_disattivate = 0;

  void inizializza() async {
    String username_tipo = "";
    GetIt.instance<ParametriModel>().inizializza(); // ricarica i dati
    ParametriModel parametri = GetIt.instance<ParametriModel>();

    if (parametri.username.length > 0) {
      username_tipo = parametri.username.substring(0, 1);
      this.utente_username = parametri.username;
      this.utente_codice = parametri.username.substring(1);
    }

    switch (username_tipo) {
      case "A":
        // AgenteModel agente_record = AgenteModel.agente_cerca(codice: this.utente_codice);
        AgenteModel agente_record = await AgenteModel.agente_da(codice: this.utente_codice);

        this.agente_id = agente_record.id;
        this.utente_id = agente_record.id;
        this.utente_sede_codice = agente_record.sede;
        this.utente_sede_sigla = agente_record.sede_sigla;

        this.utente_tipo = username_tipo;
        this.utente_tipo_interno = "-";
        this.utente_in_attivita = agente_record.stato;
        this.sospesi_mostra = 0;

        this.preventivi_abilitati = agente_record.preventivi_abilitati;
        this.offerte_disattivate = agente_record.offerte_disattivate;
        this.comunicazioni_disattivate =
            agente_record.comunicazioni_disattivate;
        this.ordini_disattivati = agente_record.ordini_disattivati;
        this.servizi_disattivati = agente_record.servizi_disattivati;
        this.disponibilita_disattivate =
            agente_record.disponibilita_disattivate;
        this.prezzi_non_visibili = agente_record.prezzi_non_visibili;
        this.moduli_disattivati = agente_record.moduli_disattivati;
        this.giacenze_disattivate = agente_record.giacenze_disattivate;

        break;
      case "S":
        // AgenteModel agente_record = AgenteModel.agente_cerca(codice: this.utente_codice);
        AgenteModel agente_record = await AgenteModel.agente_da(codice: this.utente_codice);

        this.agente_id = agente_record.id;
        this.utente_id = agente_record.id;
        this.utente_sede_codice = agente_record.sede;
        this.utente_sede_sigla = agente_record.sede_sigla;

        this.utente_tipo = username_tipo;
        if ((agente_record.vendite == 1) && (agente_record.vendite == 1)) {
          this.utente_tipo_interno = "T";
        } else if (agente_record.vendite == 1) {
          this.utente_tipo_interno = "A";
        } else if (agente_record.vendite == 1) {
          this.utente_tipo_interno = "V";
        }

        this.utente_in_attivita = agente_record.stato;
        this.sospesi_mostra = 1;

        this.preventivi_abilitati = agente_record.preventivi_abilitati;
        this.offerte_disattivate = agente_record.offerte_disattivate;
        this.comunicazioni_disattivate =
            agente_record.comunicazioni_disattivate;
        this.ordini_disattivati = agente_record.ordini_disattivati;
        this.servizi_disattivati = agente_record.servizi_disattivati;
        this.disponibilita_disattivate =
            agente_record.disponibilita_disattivate;
        this.prezzi_non_visibili = agente_record.prezzi_non_visibili;
        this.moduli_disattivati = agente_record.moduli_disattivati;
        this.giacenze_disattivate = agente_record.giacenze_disattivate;

        break;
      case "P":
      case "B":
        // lo eseguirà per P e B
        // ClienteModel cliente_record = ClienteModel.cliente_cerca(codice: this.utente_codice);
        ClienteModel cliente_record = await ClienteModel.cliente_da(codice: this.utente_codice);

        this.agente_id = cliente_record.agente_id;
        this.utente_id = cliente_record.id;
        this.utente_sede_codice = cliente_record.sede;
        this.utente_sede_sigla = cliente_record.sede_sigla;

        this.utente_tipo = "N";
        this.utente_tipo_interno = "-";
        this.utente_in_attivita = cliente_record.stato;
        this.sospesi_mostra = 0;

        this.preventivi_abilitati = 0;
        this.offerte_disattivate = cliente_record.offerte_disattivate;
        this.comunicazioni_disattivate =
            cliente_record.comunicazioni_disattivate;
        this.ordini_disattivati = cliente_record.ordini_disattivati;
        this.servizi_disattivati = cliente_record.servizi_disattivati;
        this.disponibilita_disattivate =
            cliente_record.disponibilita_disattivate;
        this.prezzi_non_visibili = cliente_record.prezzi_non_visibili;
        this.moduli_disattivati = 0;
        this.giacenze_disattivate = cliente_record.giacenze_disattivate;
        break;
    }
  }

  String url_schede_tecniche_sicurezza (){


    // If (Is compiled mode)
    // C_TEXT($vtSoapTrasm)
    // $vtSoapTrasm:=Parametro ("ServerSoap";"")
    // $vtLinkAprire:="http://"+$vtSoapTrasm+"/4DACTION/W_PortaleLogIn/"+<>vUserName+"_"+$vPass+"_"+$vtMacAddress
    //
    // Else
    // $vtLinkAprire:="http://localhost:8080/4DACTION/W_PortaleLogIn/"+<>vUserName+"_"+$vPass+"_"+$vtMacAddress
    //
    // End if

    // OPEN URL(PortaleFraschetti (True)+"_SchedaTecSic_"+String([Schede]ID))

    String url = "";

    url = GetIt.instance<ParametriModel>().host_server;

    url +="/4DACTION/W_PortaleLogIn/"+this.utente_username;
    if(this.utente_id != 0){
      url +="_"+this.utente_id.toString();
    }else{
      url +="_msgc03025";
    }
    // url +="_"+this.mac_address;  // non ho il mac_address
    url +="_";  // al posto del mac_address altrimenti sul server non va bene

    // url_aprire +="_SchedaTecSic_"+scheda_id.toString();

    return url;

  }

}
