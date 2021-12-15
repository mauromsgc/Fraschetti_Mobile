import 'package:flutter/foundation.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class ClienteModel {

  int id = 0;
  int agente_id = 0;
  String ragione_sociale = '';
  String localita = '';
  String indirizzo = '';
  String username = '';
  String sede = '';
  String codice = '';
  int stato = 0;
  int videocatalogo_disattivato = 0;
  int offerte_disattivate = 0;
  int comunicazioni_disattivate = 0;
  int ordini_disattivati = 0;
  int servizi_disattivati = 0;
  int disponibilita_disattivate = 0;
  int prezzi_non_visibili = 0;
  int giacenze_disattivate = 0;

  // il costruttore con tutti i parametri lo uso solo per creare i record fake
  ClienteModel({
    this.id = 0,
    this.agente_id = 0,
    this.ragione_sociale = '',
    this.localita = '',
    this.indirizzo = '',
    this.username = '',
    this.sede = '',
    this.codice = '',
    this.stato = 0,
    this.videocatalogo_disattivato = 0,
    this.offerte_disattivate = 0,
    this.comunicazioni_disattivate = 0,
    this.ordini_disattivati = 0,
    this.servizi_disattivati = 0,
    this.disponibilita_disattivate = 0,
    this.prezzi_non_visibili = 0,
    this.giacenze_disattivate = 0,
  });

  factory ClienteModel.fromMap(Map<String, dynamic> map) {
    final id = map["id"];
    final agente_id = map["agente_id"];
    final ragione_sociale = map["ragione_sociale"];
    final localita = map["localita"];
    final indirizzo = map["indirizzo"];
    final username = map["username"];
    final sede = map["sede"];
    final codice = map["codice"];
    final stato = map["stato"];
    final videocatalogo_disattivato = map["videocatalogo_disattivato"];
    final offerte_disattivate = map["offerte_disattivate"];
    final comunicazioni_disattivate = map["comunicazioni_disattivate"];
    final ordini_disattivati = map["ordini_disattivati"];
    final servizi_disattivati = map["servizi_disattivati"];
    final disponibilita_disattivate = map["disponibilita_disattivate"];
    final prezzi_non_visibili = map["prezzi_non_visibili"];
    final giacenze_disattivate = map["giacenze_disattivate"];

    return ClienteModel(
      id: id,
      agente_id: agente_id,
      ragione_sociale: ragione_sociale,
      localita: localita,
      indirizzo: indirizzo,
      username: username,
      sede: sede,
      codice: codice,
      stato: stato,
      videocatalogo_disattivato: videocatalogo_disattivato,
      offerte_disattivate: offerte_disattivate,
      comunicazioni_disattivate: comunicazioni_disattivate,
      ordini_disattivati: ordini_disattivati,
      servizi_disattivati: servizi_disattivati,
      disponibilita_disattivate: disponibilita_disattivate,
      prezzi_non_visibili: prezzi_non_visibili,
      giacenze_disattivate: giacenze_disattivate,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "agente_id": agente_id,
        "ragione_sociale": ragione_sociale,
        "localita": localita,
        "indirizzo": indirizzo,
        "username": username,
        "sede": sede,
        "codice": codice,
        "stato": stato,
        "videocatalogo_disattivato": videocatalogo_disattivato,
        "offerte_disattivate": offerte_disattivate,
        "comunicazioni_disattivate": comunicazioni_disattivate,
        "ordini_disattivati": ordini_disattivati,
        "servizi_disattivati": servizi_disattivati,
        "disponibilita_disattivate": disponibilita_disattivate,
        "prezzi_non_visibili": prezzi_non_visibili,
        "giacenze_disattivate": giacenze_disattivate,
      };


  // poi fare il cerca
  static Future<List<Map>> clienti_lista() async {
    List<Map> clienti_lista = [];

    Database db = GetIt.instance<DbRepository>().database;
    final rows = await db.rawQuery("""SELECT 
    clienti.id,
    clienti.agente_id,
    clienti.ragione_sociale,
    clienti.localita
     FROM clienti
    ;""");

    clienti_lista = rows;

    return clienti_lista;  }

}
