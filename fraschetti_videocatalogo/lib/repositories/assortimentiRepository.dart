import 'package:flutter/foundation.dart';
import 'package:fraschetti_videocatalogo/models/assortimentoModel.dart';

class AssortimentiRepository  {
  Future<List<AssortimentoModel>> all() async {
    await Future.delayed(Duration(seconds: 3));
    return fakeAssortimenti;
  }

  List<AssortimentoModel> all_2() {
    return fakeAssortimenti;
  }

}

final fakeAssortimenti = [
  AssortimentoModel(
    id: 1,
    descrizione: 'Ass. Giardinaggio',
    ordinatore: 1,
  ),
  AssortimentoModel(
    id: 2,
    descrizione: 'Ass. Edilizia',
    ordinatore: 2,
  ),
  AssortimentoModel(
    id: 3,
    descrizione: 'Ass. Utensili a mano',
    ordinatore: 3,
  ),
  AssortimentoModel(
    id: 4,
    descrizione: 'Ass. Utensili elettrici',
    ordinatore: 4,
  ),
  AssortimentoModel(
    id: 5,
    descrizione: 'Ass. Idraulica',
    ordinatore: 5,
  ),
  AssortimentoModel(
    id: 6,
    descrizione: 'Ass. Siderurgia',
    ordinatore: 6,
  ),
  AssortimentoModel(
    id: 7,
    descrizione: 'Ass. Ferramenta',
    ordinatore: 7,
  ),
  AssortimentoModel(
    id: 8,
    descrizione: 'Ass. Domo utility',
    ordinatore: 8,
  ),
];
