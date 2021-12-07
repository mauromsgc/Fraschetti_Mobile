import 'package:flutter/foundation.dart';

class FamigliaModel {

  // il costruttore con tutti i parametri lo uso solo per creare i record fake
  FamigliaModel({
    this.id = 0,
    this.codice = 0,
    this.descrizione = '',
    this.colore = '',
    this.abbreviazione = '',
  });

  int id = 0;
  int codice = 0;
  String descrizione = '';
  String colore = '';
  String abbreviazione = '';


}