import 'package:fraschetti_videocatalogo/models/parametriModel.dart';

class ParametriRepository {
  Future<ParametriModel> all() async {
    await Future.delayed(Duration(seconds: 3));
    return fakeParametri;
  }
}

final fakeParametri = ParametriModel(
  id: 0,
  agg_dati_id: 0,
  agg_immagini_id: 0,
  agg_comunicazioni_id: 0,
  agg_codici_ean_id: 0,
  agg_script_id: 0,
  agg_sql_id: 0,
  aggiornamento_obbligatorio: 0,
  anagrafica_aggiornamento: 0,
  promozioni_attivazione: 0,
  sql_versione: 0,
  host_server: '',
  codice_macchina: '',
  username: '',
  password: '',
  videocatalogo_uid: '',
  log_attivo: 0,
);
