import 'package:fraschetti_videocatalogo/models/famigliaModel.dart';

class FamiglieRepository {
  Future<List<FamigliaModel>> all() async {
    await Future.delayed(Duration(seconds: 3));
    return fakeFamiglie;
  }

  List<FamigliaModel> all_2() {
    return fakeFamiglie;
  }

}

final fakeFamiglie = [
  FamigliaModel(
    id: 1,
    codice: 1,
    descrizione: 'Giardinaggio',
    colore: '0xFF009900',
    abbreviazione: 'Gia',
  ),
  FamigliaModel(
    id: 2,
    codice: 2,
    descrizione: 'Edilizia',
    colore: '0xFF0099FF',
    abbreviazione: 'Edi',
  ),
  FamigliaModel(
    id: 3,
    codice: 3,
    descrizione: 'Utensili a mano',
    colore: '0xFFEE0000',
    abbreviazione: 'Ute',
  ),
  FamigliaModel(
    id: 4,
    codice: 4,
    descrizione: 'Utensili elettrici',
    colore: '0xFFFFDD00',
    abbreviazione: 'Ele',
  ),
  FamigliaModel(
    id: 5,
    codice: 5,
    descrizione: 'Idraulica',
    colore: '0xFFFF0099',
    abbreviazione: 'Idr',
  ),
  FamigliaModel(
    id: 6,
    codice: 6,
    descrizione: 'Siderurgia',
    colore: '0xFF663300',
    abbreviazione: 'Sid',
  ),
  FamigliaModel(
    id: 7,
    codice: 7,
    descrizione: 'Ferramenta',
    colore: '0xFF000099',
    abbreviazione: 'Fer',
  ),
  FamigliaModel(
    id: 8,
    codice: 8,
    descrizione: 'Domo utility',
    colore: '0xFFFF6600',
    abbreviazione: 'Dom',
  ),
];
