import 'package:flutter/foundation.dart';

class UtenteModel {

  // il costruttore con tutti i parametri lo uso solo per creare i record fake
  UtenteModel ({
    int id = 0,
    String cognome = '',
    String nome = '',
    String username = '',
    String sede = '',
    String codice = '',
    int stato = 0,
    int vendite = 0,
    int acquisti = 0,
  });

  int id = 0;
  String cognome = '';
  String nome = '';
  String username = '';
  String sede = '';
  String codice = '';
  int stato = 0;
  int vendite = 0;
  int acquisti = 0;
}