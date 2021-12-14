import 'package:flutter/foundation.dart';
import 'package:fraschetti_videocatalogo/models/promozione_codiceModel.dart';

class PromozioneModel {
  int id = 0;
  String nome = "";
  String sconto = "";
  String permanente = "";
  String tour = "";
  int ordinatore = 0;
  List<PromozioneCodiceModel> codici = [];

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

  factory PromozioneModel.fromMap(Map<String, dynamic> map) {
    final id = map["id"];
    final sconto = map["sconto"];
    final permanente = map["permanente"];
    final tour = map["tour"];
    final ordinatore = map["ordinatore"];
    final nome = map["nome"];

    return PromozioneModel(
      id: id,
      sconto: sconto,
      permanente: permanente,
      tour: tour,
      ordinatore: ordinatore,
      nome: nome,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "sconto": sconto,
        "permanente": permanente,
        "tour": tour,
        "ordinatore": ordinatore,
        "nome": nome,
      };
}
