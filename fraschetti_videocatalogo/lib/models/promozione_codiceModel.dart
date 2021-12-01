import 'package:flutter/foundation.dart';

class PromozioneCodiceModel {
  // il costruttore con tutti i parametri lo uso solo per creare i record fake
  PromozioneCodiceModel({
    this.id = 0,
    this.promozione_id = 0,
    this.catalogo_id = 0,
    this.ordinatore = 0,
  });

  int id = 0;
  int promozione_id = 0;
  int catalogo_id = 0;
  int ordinatore = 0;
}
