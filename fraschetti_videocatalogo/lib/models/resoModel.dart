import 'package:flutter/foundation.dart';

class ResoModel {

  // il costruttore con tutti i parametri lo uso solo per creare i record fake
  ResoModel({
    this.id = 0,
    this.cliente_id = 0,
    this.agente_id = 0,
    this.reso_numero = 0,
    this.articolo_codice = 0,
    this.descrizione = "",
    this.unita_misura = "",
    this.quantita = 0,
    this.causale_reso = "",
    this.fattura_data = "",
    this.fattura_numero = "",
    this.note = "",
  });

  int id = 0;
  int cliente_id = 0;
  int agente_id = 0;
  int reso_numero = 0;
  int articolo_codice = 0;
  String descrizione = "";
  String unita_misura = "";
  double quantita = 0;
  String causale_reso = "";
  String fattura_data = "";
  String fattura_numero = "";
  String note = "";

}