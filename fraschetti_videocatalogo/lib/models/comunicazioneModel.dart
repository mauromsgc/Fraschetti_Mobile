import 'package:flutter/foundation.dart';

class ComunicazioneModel {

  // il costruttore con tutti i parametri lo uso solo per creare i record fake
  ComunicazioneModel({
    this.id = 0,
    this.oggetto = "",
    this.da_leggere = 0,
    this.data = "",
    this.username = "",
    this.comunicazione_testo = "",
    this.comunicazione_blob = "",
  });

  int id = 0;
  String oggetto = "";
  int da_leggere = 0;
  String data = "";
  String username = "";
  String comunicazione_testo = "";
  String comunicazione_blob = "";

}
