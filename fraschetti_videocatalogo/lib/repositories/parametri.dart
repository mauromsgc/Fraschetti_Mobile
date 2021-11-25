import 'package:fraschetti_videocatalogo/models/parametri.dart';

class ParametriRepository {
  Future<ParametriModel> all() async {
    await Future.delayed(Duration(seconds: 3));
    return fakeParametri;
  }
}

final fakeParametri =
  ParametriModel(
    agente_id: 0,
    log_attivo: 0,
    offerte_disattivate: 0,
    sospesi_mostra: 0,
    user_id: 0,
    user_in_attivita: 0,
    user_sede_codice: '',
    user_sede_sigla: '',
    user_tipo: '',
    user_tipo_interno: '',
    user_username: '',
    note: '',
  );
