import 'package:flutter/foundation.dart';

class ClienteModel {

  // il costruttore con tutti i parametri lo uso solo per creare i record fake
  ClienteModel ({
    int id = 0,
    String ragione_sociale = '',
    String localita = '',
    String indirizzo = '',
    String username = '',
    String sede = '',
    String codice = '',
    int stato = 0,
    int videocatalogo_disattivato = 0,
    int offerte_disattivate = 0,
    int agente_id = 0,
  });

  int id = 0;
  String ragione_sociale = '';
  String localita = '';
  String indirizzo = '';
  String username = '';
  String sede = '';
  String codice = '';
  int stato = 0;
  int videocatalogo_disattivato = 0;
  int offerte_disattivate = 0;
  int agente_id = 0;
}