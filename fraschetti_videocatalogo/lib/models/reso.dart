import 'package:flutter/foundation.dart';

class ResoModel {

  // il costruttore con tutti i parametri lo uso solo per creare i record fake
  ResoModel({
    int id = 0,
    int cliente_id = 0,
    int agente_id = 0,
    int reso_numero = 0,
    int articolo_codice = 0,
    String descrizione = '',
    String unita_misura = '',
    double quantita = 0,
    String causale_reso = '',
    String fattura_data = '',
    String fattura_numero = '',
    String note = '',
  });

  int id = 0;
  int cliente_id = 0;
  int agente_id = 0;
  int reso_numero = 0;
  int articolo_codice = 0;
  String descrizione = '';
  String unita_misura = '';
  double quantita = 0;
  String causale_reso = '';
  String fattura_data = '';
  String fattura_numero = '';
  String note = '';

}