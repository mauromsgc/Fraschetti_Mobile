import 'package:flutter/foundation.dart';

class ComunicazioneModel {
  int id = 0;
  String oggetto = "";
  int da_leggere = 0;
  String data = "";
  String username = "";
  String comunicazione_testo = "";
  String comunicazione_blob = "";

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

  factory ComunicazioneModel.fromMap(Map<String, dynamic> map) {
    final id = map["id"];
    final oggetto = map["oggetto"];
    final da_leggere = map["da_leggere"];
    final data = map["data"];
    final username = map["username"];
    final comunicazione_testo = map["comunicazione_testo"];
    final comunicazione_blob = map["comunicazione_blob"];

    return ComunicazioneModel(
      id: id,
      oggetto: oggetto,
      da_leggere: da_leggere,
      data: data,
      username: username,
      comunicazione_testo: comunicazione_testo,
      comunicazione_blob: comunicazione_blob,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "oggetto": oggetto,
        "da_leggere": da_leggere,
        "data": data,
        "username": username,
        "comunicazione_testo": comunicazione_testo,
        "comunicazione_blob": comunicazione_blob,
      };
}
