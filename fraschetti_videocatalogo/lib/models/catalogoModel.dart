import 'package:flutter/foundation.dart';
import 'package:fraschetti_videocatalogo/models/codiceModel.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class CatalogoModel {
  int id = 0;
  String nome = '';
  String descrizione = '';
  int famiglia = 0;
  int nuovo = 0;
  int sospeso = 0;
  int ordinatore = 0;
  int primo_codice = 0;
  List<CodiceModel> codici = [];

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
    // this.codici = [],
  });

  factory CatalogoModel.fromMap(Map<String, dynamic> map) {
    final id = map["id"];
    final nome = map["nome"];
    final descrizione = map["descrizione"];
    final famiglia = map["famiglia"];
    final nuovo = map["nuovo"];
    final sospeso = map["sospeso"];
    final ordinatore = map["ordinatore"];
    final primo_codice = map["primo_codice"];

    return CatalogoModel(
      id: id,
      nome: nome,
      descrizione: descrizione,
      famiglia: famiglia,
      nuovo: nuovo,
      sospeso: sospeso,
      ordinatore: ordinatore,
      primo_codice: primo_codice,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "nome": nome,
        "descrizione": descrizione,
        "famiglia": famiglia,
        "nuovo": nuovo,
        "sospeso": sospeso,
        "ordinatore": ordinatore,
        "primo_codice": primo_codice,
      };

  // poi fare il cerca
  static Future<List<Map>> catalogo_lista({
    String descrizione = '',
    String codice = '',
    int famiglia_id = 0,
    int assortimento_id = 0,
    String selezione = '',
    String ordinamento_campo = '',
    String ordinamento_verso = '',
  }) async {
    List<Map> catalogo_lista = [];

    Database db = GetIt.instance<DbRepository>().database;
    String sql_eseguire = """SELECT DISTINCT 
    catalogo.id,
    catalogo.nome,
    catalogo.nuovo,
    catalogo.sospeso,
    catalogo.ordinatore,
    famiglie.colore,
    ifnull(promozioni_codici.promozione_id, 0) as promozione_id,
    ifnull(catalogo_img.immagine_preview, '') as immagine_preview
    FROM catalogo
    LEFT JOIN famiglie ON famiglie.id = catalogo.famiglia
    LEFT JOIN promozioni_codici ON promozioni_codici.catalogo_id = catalogo.id
    LEFT JOIN catalogo_img ON catalogo_img.catalogo_id = catalogo.id
    """;

    // fare ricerca per parole separate
    // in base ai parametri compilare i vettori con
    // i join, le condizioni, gli ordinamenti


    if (codice != '') {
      sql_eseguire += "LEFT JOIN codici ON codici.catalogo_id = catalogo.id ";
    }
    if (assortimento_id != 0) {
      sql_eseguire +=
          "LEFT JOIN assortimenti_codici ON assortimenti_codici.catalogo_id = catalogo.id ";
      sql_eseguire +=
          "LEFT JOIN assortimenti ON assortimenti.id = assortimenti_codici.assortimenti_id ";
    }

    if ((descrizione != '') ||
        (codice != '') ||
        (famiglia_id != 0) ||
        (assortimento_id != 0) ||
        (selezione != '')) {
      sql_eseguire += "WHERE ";
    }
    if (descrizione != '') {
      sql_eseguire += "catalogo.nome LIKE '%${descrizione}%' ";
    }
    if (codice != '') {
      sql_eseguire += "codici.numero LIKE '${codice}%' ";
    }
    if (famiglia_id != 0) {
      sql_eseguire += "famiglie.id = ${famiglia_id} ";
    }
    if (assortimento_id != 0) {
      sql_eseguire += "assortimenti.id = ${assortimento_id} ";
    }
    if (selezione != '') {
      switch (selezione) {
        case 'tutto':
          sql_eseguire += "catalogo.id > 0 ";
          break;
        case 'novita':
          sql_eseguire += "catalogo.nuovo > 0 ";
          break;
        case 'nuovi_codici':
          // sql_eseguire += "famiglie.id = ${selezione} ";
          break;
        case 'in_offerta':
          sql_eseguire += "promozione_id > 0 ";
          break;
      }
    }

    sql_eseguire += ";";
    print(sql_eseguire);

    final rows = await db.rawQuery(sql_eseguire);

    catalogo_lista = rows;

    return catalogo_lista;

    // switch
    // case (pCercare = "Svuota")
    // put "SELECT Catalogo.ID FROM Catalogo" into tSQL
    // put tSQL && "WHERE Catalogo.ID < 0" into tSQL
    // put tSQL && "AND Catalogo.Sospeso <= " & tSOFT_SospesiMostra into tSQL
    // break
    // case (pCercare = "Tutto")
    // put "SELECT Catalogo.ID FROM Catalogo" into tSQL
    // put tSQL && "WHERE Catalogo.Sospeso < 1" into tSQL
    // put tSQL && "AND Catalogo.Sospeso <= " & tSOFT_SospesiMostra into tSQL
    // put tSQL && "ORDER BY Catalogo.Nome ASC" into tSQL
    // break
    // case (pCercare = "Famiglia")
    // put "SELECT Catalogo.ID FROM Catalogo" into tSQL
    // put tSQL && "WHERE Catalogo.Famiglia = " & pValoreCercare into tSQL
    // put tSQL && "AND Catalogo.Sospeso <= " & tSOFT_SospesiMostra into tSQL
    // put tSQL && "ORDER BY Catalogo.Nome ASC" into tSQL
    // break
    // case (pCercare = "Assortimenti")
    // put "SELECT DISTINCT Catalogo.ID FROM Catalogo, AssortimentiCodici, Assortimenti" into tSQL
    // put tSQL && "WHERE Catalogo.ID = AssortimentiCodici.CatalogoID" into tSQL
    // put tSQL && "AND AssortimentiCodici.AssortimentiID = Assortimenti.ID" into tSQL
    // put tSQL && "AND Assortimenti.Descrizione LIKE '" & pValoreCercare & "'" into tSQL
    // put tSQL && "AND Catalogo.Sospeso <= " & tSOFT_SospesiMostra into tSQL
    // put tSQL && "ORDER BY AssortimentiCodici.Ordinatore ASC" into tSQL
    //
    // break
    // case (pCercare = "Selezione")
    // switch
    // case (pValoreCercare = "Novità")
    // put "SELECT Catalogo.ID FROM Catalogo" into tSQL
    // put tSQL && "WHERE Catalogo.Nuovo = 1" into tSQL
    // put tSQL && "AND Catalogo.Sospeso <= " & tSOFT_SospesiMostra into tSQL
    // put tSQL && "ORDER BY Catalogo.Nome ASC" into tSQL
    // break
    //
    // case (pValoreCercare = "Nuovi codici")
    // put "SELECT DISTINCT Catalogo.ID FROM Catalogo, Codici" into tSQL
    // put tSQL && "WHERE Catalogo.ID = Codici.CatalogoID" into tSQL
    // put tSQL && "AND Catalogo.Sospeso <= " & tSOFT_SospesiMostra into tSQL
    // put tSQL && "AND Codici.Nuovo = 1" into tSQL
    // put tSQL && "ORDER BY Catalogo.Nome ASC" into tSQL
    // break
    //
    // case (pValoreCercare = "Prodotti in offerta")
    // put "SELECT DISTINCT Catalogo.ID FROM Catalogo, PromozioniCodici" into tSQL
    // put tSQL && "WHERE Catalogo.ID = PromozioniCodici.CatalogoID" into tSQL
    // put tSQL && "AND Catalogo.Sospeso <= " & tSOFT_SospesiMostra into tSQL
    // put tSQL && "ORDER BY PromozioniCodici.Ordinatore ASC" into tSQL
    // break
    //
    // case (pValoreCercare = "Assortimenti")
    // put "SELECT DISTINCT Catalogo.ID FROM Catalogo, AssortimentiCodici" into tSQL
    // put tSQL && "WHERE Catalogo.ID = AssortimentiCodici.CatalogoID" into tSQL
    // put tSQL && "AND Catalogo.Sospeso <= " & tSOFT_SospesiMostra into tSQL
    // put tSQL && "ORDER BY AssortimentiCodici.Ordinatore ASC" into tSQL
    // break
    // end switch
    //
    // break
    //
    // case tNome is not empty
    // -- controllare se c'è più di una parola
    // -- se c'è una sola parola cercare la parola con %, che iniza per
    // -- se ci sono n parole cercare gli articoli che contengono esattamente le parole fino a n-1
    // -- e per la parola n cercare con %
    //
    // local tParolaNumero, tParoleTotale, tParola
    // put 0 into tParolaNumero
    // put 0 into tParoleTotale
    // put empty into tParola
    //
    // put "%" after word -1 of tNome -- aggiungo % alla fine dell'ultima parola per la ricerca
    // -- inserisco le parole in un array per creare poi la
    //
    // put the number of words in tNome into tParoleTotale
    //
    // put "SELECT Catalogo.ID FROM Catalogo" into tSQL
    // put tSQL && "WHERE Catalogo.Sospeso <= " & tSOFT_SospesiMostra into tSQL
    //
    // repeat with tParolaNumero = 1 to tParoleTotale
    // put word tParolaNumero of tNome into tParola
    // put tSQL && "AND (Catalogo.Nome LIKE '" & tParola & " %'" into tSQL
    // put tSQL && "OR Catalogo.Nome LIKE '% " & tParola & " %'" into tSQL
    // put tSQL && "OR Catalogo.Nome LIKE '% " & tParola & "'" into tSQL
    // put tSQL && "OR Catalogo.Nome LIKE '" & tParola & "')" into tSQL
    // end repeat
    //
    // put tSQL && "ORDER BY Catalogo.Nome ASC" into tSQL
    // break
    // case tCodice is not empty
    // put "SELECT DISTINCT Catalogo.ID FROM Catalogo, Codici" into tSQL
    // put tSQL && "WHERE Catalogo.ID = Codici.CatalogoID" into tSQL
    // put tSQL && "AND Catalogo.Sospeso <= " & tSOFT_SospesiMostra into tSQL
    // put tSQL && "AND Codici.Numero LIKE '" & tCodice & "%'" into tSQL
    // put tSQL && "ORDER BY Catalogo.Nome ASC" into tSQL
    // break
    // default
    // put "SELECT Catalogo.ID FROM Catalogo" into tSQL
    // put tSQL && "WHERE Catalogo.ID < 0" into tSQL
    // put tSQL && "AND Catalogo.Sospeso <= " & tSOFT_SospesiMostra into tSQL
    // put tSQL && "ORDER BY Catalogo.Nome ASC" into tSQL
    // break
    // end switch
  }
}
