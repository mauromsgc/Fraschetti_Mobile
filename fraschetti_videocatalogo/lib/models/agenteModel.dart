import 'package:flutter/foundation.dart';
import 'package:fraschetti_videocatalogo/helper/DBHelper.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class AgenteModel {
  int id = 0;
  String cognome = "";
  String nome = "";
  String username = "";
  String sede = "";
  String codice = "";
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

  AgenteModel({
    int id = 0,
    String cognome = "",
    String nome = "",
    String username = "",
    String sede = "",
    String codice = "",
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

  // AgenteModel.agente_cerca({int agente_id = 0, String codice = ""}) {
  //     AgenteModel.agente_da(agente_id: agente_id, codice: codice);
  // }

  factory AgenteModel.fromMap(Map<String, dynamic> map) {
    AgenteModel oggetto = AgenteModel();

    oggetto.id = map["id"];
    oggetto.cognome = map["cognome"];
    oggetto.nome = map["nome"];
    oggetto.username = map["username"];
    oggetto.sede = map["sede"];
    oggetto.codice = map["codice"];
    oggetto.stato = map["stato"];
    oggetto.vendite = map["vendite"];
    oggetto.acquisti = map["acquisti"];
    oggetto.preventivi_abilitati = map["preventivi_abilitati"];
    oggetto.listino_id = map["listino_id"];
    oggetto.offerte_disattivate = map["offerte_disattivate"];
    oggetto.comunicazioni_disattivate = map["comunicazioni_disattivate"];
    oggetto.ordini_disattivati = map["ordini_disattivati"];
    oggetto.servizi_disattivati = map["servizi_disattivati"];
    oggetto.disponibilita_disattivate = map["disponibilita_disattivate"];
    oggetto.prezzi_non_visibili = map["prezzi_non_visibili"];
    oggetto.moduli_disattivati = map["moduli_disattivati"];
    oggetto.giacenze_disattivate = map["giacenze_disattivate"];

    return oggetto;
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

  static Future<AgenteModel> agente_da(
      {int agente_id = 0, String codice = ""}) async {
    Database db = GetIt.instance<DbRepository>().database;

    String sql_where = "";
    List sql_argomenti = [];

    if (agente_id != 0) {
      sql_where += "id = ?";
      sql_argomenti.add(agente_id);
    }
    if (codice != "") {
      if (sql_where != "") {
        sql_where += " And ";
      }
      sql_where += "codice = ?";
      sql_argomenti.add(codice);
    }

    final rows = await (await db.query("agenti",
        where: sql_where, whereArgs: sql_argomenti));
    if (rows.length > 0) {
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
    return (this.sede == 0)
        ? "P"
        : (this.sede == 1)
            ? "B"
            : "";
  }
}
