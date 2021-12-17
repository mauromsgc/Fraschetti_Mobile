import 'package:flutter/foundation.dart';
import 'package:fraschetti_videocatalogo/helper/DBHelper.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class AgenteModel {
  int id = 0;
  String cognome = '';
  String nome = '';
  String username = '';
  String sede = '';
  String codice = '';
  int stato = 0;
  int vendite = 0;
  int acquisti = 0;
  int preventivi_abilitati = 0;
  int listino_id = 0;
  int offerte_disattivate = 0;
  int comunicazioni_disattivate = 0;
  int ordini_disattivati = 0;
  int servizi_disattivati = 0;
  int disponibilita_disattivate = 0;
  int prezzi_non_visibili = 0;
  int moduli_disattivati = 0;
  int giacenze_disattivate = 0;

  // il costruttore con tutti i parametri lo uso solo per creare i record fake
  AgenteModel({
    int id = 0,
    String cognome = '',
    String nome = '',
    String username = '',
    String sede = '',
    String codice = '',
    int stato = 0,
    int vendite = 0,
    int acquisti = 0,
    int preventivi_abilitati = 0,
    int listino_id = 0,
    int offerte_disattivate = 0,
    int comunicazioni_disattivate = 0,
    int ordini_disattivati = 0,
    int servizi_disattivati = 0,
    int disponibilita_disattivate = 0,
    int prezzi_non_visibili = 0,
    int moduli_disattivati = 0,
    int giacenze_disattivate = 0,
  });

  AgenteModel.agente_cerca({int agente_id = 0, String codice = ""}) {
       AgenteModel.agente_da(agente_id: agente_id, codice: codice);
  }

  factory AgenteModel.fromMap(Map<String, dynamic> map) {
    final id = map["id"];
    final cognome = map["cognome"];
    final nome = map["nome"];
    final username = map["username"];
    final sede = map["sede"];
    final codice = map["codice"];
    final stato = map["stato"];
    final vendite = map["vendite"];
    final acquisti = map["acquisti"];
    final preventivi_abilitati = map["preventivi_abilitati"];
    final listino_id = map["listino_id"];
    final offerte_disattivate = map["offerte_disattivate"];
    final comunicazioni_disattivate = map["comunicazioni_disattivate"];
    final ordini_disattivati = map["ordini_disattivati"];
    final servizi_disattivati = map["servizi_disattivati"];
    final disponibilita_disattivate = map["disponibilita_disattivate"];
    final prezzi_non_visibili = map["prezzi_non_visibili"];
    final moduli_disattivati = map["moduli_disattivati"];
    final giacenze_disattivate = map["giacenze_disattivate"];

    return AgenteModel(
      id: id,
      cognome: cognome,
      nome: nome,
      username: username,
      sede: sede,
      codice: codice,
      stato: stato,
      vendite: vendite,
      acquisti: acquisti,
      preventivi_abilitati: preventivi_abilitati,
      listino_id: listino_id,
      offerte_disattivate: offerte_disattivate,
      comunicazioni_disattivate: comunicazioni_disattivate,
      ordini_disattivati: ordini_disattivati,
      servizi_disattivati: servizi_disattivati,
      disponibilita_disattivate: disponibilita_disattivate,
      prezzi_non_visibili: prezzi_non_visibili,
      moduli_disattivati: moduli_disattivati,
      giacenze_disattivate: giacenze_disattivate,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "cognome": cognome,
        "nome": nome,
        "username": username,
        "sede": sede,
        "codice": codice,
        "stato": stato,
        "vendite": vendite,
        "acquisti": acquisti,
        "preventivi_abilitati": preventivi_abilitati,
        "listino_id": listino_id,
        "offerte_disattivate": offerte_disattivate,
        "comunicazioni_disattivate": comunicazioni_disattivate,
        "ordini_disattivati": ordini_disattivati,
        "servizi_disattivati": servizi_disattivati,
        "disponibilita_disattivate": disponibilita_disattivate,
        "prezzi_non_visibili": prezzi_non_visibili,
        "moduli_disattivati": moduli_disattivati,
        "giacenze_disattivate": giacenze_disattivate,
      };

  static Future<AgenteModel> agente_da({int agente_id = 0, String codice = ""}) async {
    Database db = GetIt.instance<DbRepository>()
        .database;

    String sql_where = "";
    List sql_argomenti = [];

    if(agente_id != 0){
      sql_where += "id = ?";
      sql_argomenti.add(agente_id);
    }
    if(codice != ""){
      if (sql_where != ""){
        sql_where += " And ";
      }
      sql_where += "codice = ?";
      sql_argomenti.add(codice);
    }

    final rows = await (await db
        .query("agenti", where: sql_where, whereArgs: sql_argomenti));
    if(rows.length>0){
      return AgenteModel.fromMap(rows[0]);
    } else {
      return AgenteModel();
    }
  }

  static Future<List<AgenteModel>> agenti_lista() async {
    Database db = GetIt.instance<DbRepository>().database;
    final rows = await db.query("agenti");
    return rows.map((row) => AgenteModel.fromMap(row)).toList();
  }

  String get sede_sigla {

    return (this.sede == 0) ? "P" : (this.sede == 1) ? "B" : "";

  }

}
