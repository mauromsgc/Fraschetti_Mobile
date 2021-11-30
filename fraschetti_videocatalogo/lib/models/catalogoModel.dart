import 'package:flutter/foundation.dart';
import 'package:fraschetti_videocatalogo/models/codiceModel.dart';

class CatalogoModel {

  // il costruttore con tutti i parametri lo uso solo per creare i record fake
  CatalogoModel({
    this.id = 0,
    this.nome = '',
    this.descrizione = '',
    this.famiglia = 0,
    this.nuovo = 0,
    this.sospeso = 0,
    this.ordinatore = 0,
    this.primo_codice = 0,
    // List<CodiceModel> codici = [],
  });

  int id = 0;
  String nome = '';
  String descrizione = '';
  int famiglia = 0;
  int nuovo = 0;
  int sospeso = 0;
  int ordinatore = 0;
  int primo_codice = 0;
  List<CodiceModel> codici = [];

}
