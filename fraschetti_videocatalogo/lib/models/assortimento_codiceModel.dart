import 'package:flutter/foundation.dart';

class AssortimentoCodiceModel {

  // il costruttore con tutti i parametri lo uso solo per creare i record fake
  AssortimentoCodiceModel ({
    this.id = 0,
    this.assortimento_id = 0,
    this.catalogo_id = 0,
    this.ordinatore = 0,
  });

  int id = 0;
  int assortimento_id = 0;
  int catalogo_id = 0;
  int ordinatore = 0;
}