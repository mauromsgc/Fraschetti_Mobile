import 'package:flutter/foundation.dart';

class OrdineModel {

  // il costruttore con tutti i parametri lo uso solo per creare i record fake
  OrdineModel({
    int id = 0,
    int cliente_id = 0,
    int agente_id = 0,
    int ordine_numero = 0,
    int articolo_codice = 0,
    String descrizione = '',
    String unita_misura = '',
    double quantita = 0,
    double prezzo = 0,
    double prezzo_ordine = 0,
  });

  int id = 0;
  int cliente_id = 0;
  int agente_id = 0;
  int ordine_numero = 0;
  int articolo_codice = 0;
  String descrizione = '';
  String unita_misura = '';
  double quantita = 0;
  double prezzo = 0;
  double prezzo_ordine = 0;
  
}