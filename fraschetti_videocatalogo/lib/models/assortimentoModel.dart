import 'package:flutter/foundation.dart';

class AssortimentoModel {

  // il costruttore con tutti i parametri lo uso solo per creare i record fake
  AssortimentoModel ({
    this.id = 0,
    this.descrizione = '',
    this.ordinatore = 0,
  });

  int id = 0;
  String descrizione = '';
  int ordinatore = 0;
}