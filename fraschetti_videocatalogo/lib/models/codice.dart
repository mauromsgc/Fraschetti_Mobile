import 'package:flutter/foundation.dart';

class CodiceModel {
  // il costruttore con tutti i parametri lo uso solo per creare i record fake
  CodiceModel({
    int id = 0,
    int catalogo_id = 0,
    String numero = '',
    String descrizione = '',
    int apribile = 0,
    int nuovo = 0,
    int sospeso = 0,
    int pezzi = 0,
    double prezzo = 0,
    String unita_misura = '',
    int iva = 0,
  });

  int id = 0;
  int catalogo_id = 0;
  String numero = '';
  String descrizione = '';
  int apribile = 0;
  int nuovo = 0;
  int sospeso = 0;
  int pezzi = 0;
  double prezzo = 0;
  String unita_misura = '';
  int iva = 0;

}
