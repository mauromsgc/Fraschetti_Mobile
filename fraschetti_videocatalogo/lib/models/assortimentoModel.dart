import 'package:flutter/foundation.dart';

class AssortimentoModel {
  int id = 0;
  String descrizione = '';
  int ordinatore = 0;

  // il costruttore con tutti i parametri lo uso solo per creare i record fake
  AssortimentoModel({
    this.id = 0,
    this.descrizione = '',
    this.ordinatore = 0,
  });

  factory AssortimentoModel.fromMap(Map<String, dynamic> map) {
    final id = map["id"];
    final descrizione = map["descrizione"];
    final ordinatore = map["ordinatore"];

    return AssortimentoModel(
      id: id,
      descrizione: descrizione,
      ordinatore: ordinatore,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "descrizione": descrizione,
        "ordinatore": ordinatore,
      };
}
