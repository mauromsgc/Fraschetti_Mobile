import 'package:flutter/foundation.dart';
import 'package:fraschetti_videocatalogo/models/promozione_codiceModel.dart';

class PromozioneModel {

  // il costruttore con tutti i parametri lo uso solo per creare i record fake
  PromozioneModel({
    this.id = 0,
    this.sconto = "",
    this.permanente = "",
    this.tour = "",
    this.ordinatore = 0,
    this.nome = "",
    // List<PromozioneCodiceModel> codici = [],
  });

  int id = 0;
  String nome = "";
  String sconto = "";
  String permanente = "";
  String tour = "";
  int ordinatore = 0;
  List<PromozioneCodiceModel> codici = [];

}
