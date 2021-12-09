import 'package:flutter/foundation.dart';
import 'package:fraschetti_videocatalogo/models/catalogoModel.dart';

class ArticoliRepository {
  Future<List<CatalogoModel>> all() async {
    // await Future.delayed(Duration(seconds: 3));
    return fakeArticoli;
  }

  Future<List<CatalogoModel>> all_sub() async {
    // await Future.delayed(Duration(seconds: 3));
    return fakeArticoli2;
  }


  List<CatalogoModel> all_2() {
    return fakeArticoli;
  }


  List<CatalogoModel> all_3() {
    return fakeArticoli2;
  }
}

final fakeArticoli = [
  // CatalogoModel(
  //   id: 0,
  //   nome: '',
  //   descrizione: '',
  //   famiglia: 0,
  //   nuovo: 0,
  //   sospeso: 0,
  //   ordinatore: 0,
  //   primo_codice: 0,
  // ),
  CatalogoModel(
    id: 2,
    nome: 'Accendigas piezoelettrico Orion     ',
    descrizione:
        'Corpo in ABS, funziona senza pietrina, senza pile, senza corrente, senza resistenza, senza ricarica, sempre pronto all\'uso, l\'accendigas ha i cristalli indistruttibi di durata illimitata, in confezione blister',
    famiglia: 8,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 579,
    primo_codice: 299001,
  ),
  CatalogoModel(
    id: 3,
    nome: 'Accendigas ricaricabile Geos    ',
    descrizione:
        'Corpo ABS, contiene gas butano sotto pressione, in confezione blister',
    famiglia: 8,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 583,
    primo_codice: 299010,
  ),
  CatalogoModel(
    id: 4,
    nome: 'Accessori per caffettiera moka          ',
    descrizione: 'In confezioni self service',
    famiglia: 8,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 1000,
    primo_codice: 508017,
  ),
  CatalogoModel(
    id: 5,
    nome: 'Accette Galizzi Art. 2005   ',
    descrizione:
        'In acciaio forgiato con lama temperata, senza manico, specifica per carpentieri, peso kg. 0,500',
    famiglia: 1,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 782,
    primo_codice: 228010,
  ),
  CatalogoModel(
    id: 8,
    nome: 'Accette da taglio Brixo manico legno          ',
    descrizione:
        'In acciaio forgiato con lama temperata, manico sagomato in faggio. Peso kg. 1,600        ',
    famiglia: 1,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 784,
    primo_codice: 225052,
  ),
  CatalogoModel(
    id: 9,
    nome: 'Adesivi Pattex Acciaio liquido        ',
    descrizione:
        'Pasta adesiva epossidica a due componenti di colore metallico, ideale per saldare parti metalliche tra loro ed al vetro, ceramica, muratura, legno e materie plastiche, per la stuccatura di fori e fessure su superfici metalliche, e la ricostruzione di piccoli particolari, 30 gr. in confezione blister',
    famiglia: 2,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 579,
    primo_codice: 450380,
  ),
  CatalogoModel(
    id: 10,
    nome: 'Acido muriatico              ',
    descrizione:
        'Prodotto a base di acido cloridrico, scioglie facilmente incrostazioni di natura calcarea eliminando eventuali macchie di ruggine, residui di calce e cemento etc.',
    famiglia: 2,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 720,
    primo_codice: 151000,
  ),
  CatalogoModel(
    id: 11,
    nome: 'Acquaragia Abete     ',
    descrizione:
        'Specifica per la diluizione di vernici e smalti sintetici, oleosintetici, cere ed antiruggini, confezioni in latte metalliche ',
    famiglia: 2,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 710,
    primo_codice: 205020,
  ),
  CatalogoModel(
    id: 14,
    nome: 'Adattatori semplici Polaris         ',
    descrizione:
        'Corpo in tecnopolimero e termoresistente con viti e passacavo. Amp. 16+T',
    famiglia: 8,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 1289,
    primo_codice: 444570,
  ),
  CatalogoModel(
    id: 15,
    nome: 'Adattatori triplici Polaris        ',
    descrizione:
        'Corpo in tecnopolimero e termoresistente serracavo con viti e passacavo ',
    famiglia: 8,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 1293,
    primo_codice: 444584,
  ),
  CatalogoModel(
    id: 16,
    nome: 'Aereatori termici per finestre regolabile',
    descrizione: 'Apertura e chisura manuale regolabile, materiale trasparente',
    famiglia: 8,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 545,
    primo_codice: 409019,
  ),
  CatalogoModel(
    id: 17,
    nome: 'Aerografi Brixo verniciatura gr. 1000 aria compressa          ',
    descrizione:
        'Serbatoio inferiore capacità Lt. 1 con fissaggio a baionetta a tenuta stagna, foro ugello mm. 1,5, attacco filetto M 1/4" ',
    famiglia: 4,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 315,
    primo_codice: 303040,
  ),
  CatalogoModel(
    id: 18,
    nome: 'Aerografi Brixo verniciatura cc 600 aria compressa',
    descrizione:
        'Corpo in alluminio nichelato, serbatoio superiore in nylon cc. 600, spillo in acciaio inox, getto a rosa con ugello in ottone foro Ø mm. 1,5 - attacco filetto M 1/4"',
    famiglia: 4,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 314,
    primo_codice: 303050,
  ),
  CatalogoModel(
    id: 19,
    nome: 'Affilatoi al carbonio Due Buoi Art. 671       ',
    descrizione:
        'Con impugnatura in legno, lunghezza cm. 25, confezionato in busta self service. ',
    famiglia: 8,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 991,
    primo_codice: 435210,
  ),
  CatalogoModel(
    id: 20,
    nome: 'Affilatoi a doppia grana                          ',
    descrizione: 'Dimensioni cm. 5x15x2,5H',
    famiglia: 1,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 817,
    primo_codice: 305080,
  ),
  CatalogoModel(
    id: 21,
    nome: 'Guidalima con tondino per catene motosega               ',
    descrizione:
        'Attrezzo guida per una corretta angolazione e profondità di affilatura della catena, tondino incluso',
    famiglia: 1,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 968,
    primo_codice: 112130,
  ),
  CatalogoModel(
    id: 22,
    nome: 'Alari Mini in ferro battuto per camino',
    descrizione: 'Con pomolo in ottone, cm. L38xH33 - pomo Ø mm. 35',
    famiglia: 8,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 460,
    primo_codice: 355010,
  ),
  CatalogoModel(
    id: 23,
    nome: 'Alari in ottone per camino         ',
    descrizione:
        'Interamente in ottone lucido con gamba in acciaio, cm. H 43 x L 48   ',
    famiglia: 8,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 462,
    primo_codice: 355005,
  ),
  CatalogoModel(
    id: 30,
    nome: 'Ancoraggi Mottura Art. 300   ',
    descrizione: 'In acciaio verniciato, per antine fisse ',
    famiglia: 7,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 723,
    primo_codice: 507600,
  ),
  CatalogoModel(
    id: 31,
    nome: 'Tasselli Ancore Fischer KD            ',
    descrizione:
        'Con vite, interamente in acciaio tropicalizzato, specifiche per fissaggi su pareti vuote, particolarmente adatte per fissaggi al soffitto.',
    famiglia: 7,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 198,
    primo_codice: 525840,
  ),
  CatalogoModel(
    id: 33,
    nome: 'Anelli per falci                   ',
    descrizione:
        'In acciaio zincato, completo di chiave stringiviti. 2 viti  - H.  mm. 30  ',
    famiglia: 1,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 806,
    primo_codice: 20035,
  ),
  CatalogoModel(
    id: 34,
    nome: 'Anelli copritesta per chiavi      ',
    descrizione: 'In scatola da 200 pezzi in plastica assortita in 8 colori ',
    famiglia: 7,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 856,
    primo_codice: 57210,
  ),
  CatalogoModel(
    id: 37,
    nome: 'Anelli portachiavi    ',
    descrizione: 'In acciaio, in confezioni da 100 pezzi ',
    famiglia: 7,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 861,
    primo_codice: 57230,
  ),
  CatalogoModel(
    id: 39,
    nome: 'Anelli tubolari in ottone lucido       ',
    descrizione: 'Per tendine',
    famiglia: 8,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 89,
    primo_codice: 68010,
  ),
  CatalogoModel(
    id: 41,
    nome: 'Montanti scaffalature a bulloni           ',
    descrizione:
        'In lamiera verniciata a caldo. Ral 7038. Dimensioni mm. 35x35, spessore 18/10',
    famiglia: 7,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 285,
    primo_codice: 275040,
  ),
  CatalogoModel(
    id: 44,
    nome: 'Protettivo antitarlo per legno Tarlix     ',
    descrizione:
        'Antitarlo pronto all’uso, in confezione con siringa e spray. ',
    famiglia: 2,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 724,
    primo_codice: 509050,
  ),
  CatalogoModel(
    id: 45,
    nome: 'Portabiti colorati in nylon            ',
    descrizione: 'In ABS, con basetta di premontaggio, altezza mm. 115',
    famiglia: 7,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 575,
    primo_codice: 264600,
  ),
  CatalogoModel(
    id: 46,
    nome: 'Portabiti Cosma Art. 33466      ',
    descrizione: 'In acciaio laccato colorato, altezza mm. 105 ',
    famiglia: 7,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 576,
    primo_codice: 487340,
  ),
  CatalogoModel(
    id: 54,
    nome: 'Archetti da traforo    ',
    descrizione:
        'In acciaio tubolare verniciato nero con manico legno, lunghezza mm. 300 ',
    famiglia: 3,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 334,
    primo_codice: 31100,
  ),
  CatalogoModel(
    id: 55,
    nome: 'Archetti in alluminio con lama per metallo     ',
    descrizione:
        'Telaio cromato a sezione quadra con impugnatura doppia in alluminio pressofuso, taglio ad angolazione variabile fino a 55° ',
    famiglia: 3,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 189,
    primo_codice: 31007,
  ),
  CatalogoModel(
    id: 56,
    nome: 'Archetti piatti per metallo    ',
    descrizione: 'Attacchi lama sfilabili, tendilama a galletto',
    famiglia: 3,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 190,
    primo_codice: 31010,
  ),
  CatalogoModel(
    id: 57,
    nome: 'Archetti tubolari per metallo          ',
    descrizione:
        'Tendilama a galletto, con impugnatura anatomica in alluminio ',
    famiglia: 3,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 188,
    primo_codice: 31005,
  ),
  CatalogoModel(
    id: 58,
    nome: 'Arelle stuoia',
    descrizione:
        'In canna pulita, legate con nylon, versione Utility Packing in confezioni singole termoretratte. ',
    famiglia: 1,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 1142,
    primo_codice: 421140,
  ),
  CatalogoModel(
    id: 60,
    nome: 'Armadi metallico portascope       ',
    descrizione:
        'In lamiera verniciata a caldo, colore grigio chiaro, con 4 ripiani regolabili di cui 3 a delta, dimensioni cm.: 60x40x175 H ',
    famiglia: 8,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 770,
    primo_codice: 275120,
  ),
];


final fakeArticoli2 = [
  CatalogoModel(
    id: 30,
    nome: 'Ancoraggi Mottura Art. 300   ',
    descrizione: 'In acciaio verniciato, per antine fisse ',
    famiglia: 7,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 723,
    primo_codice: 507600,
  ),
  CatalogoModel(
    id: 31,
    nome: 'Tasselli Ancore Fischer KD            ',
    descrizione:
    'Con vite, interamente in acciaio tropicalizzato, specifiche per fissaggi su pareti vuote, particolarmente adatte per fissaggi al soffitto.',
    famiglia: 7,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 198,
    primo_codice: 525840,
  ),
  CatalogoModel(
    id: 33,
    nome: 'Anelli per falci                   ',
    descrizione:
    'In acciaio zincato, completo di chiave stringiviti. 2 viti  - H.  mm. 30  ',
    famiglia: 1,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 806,
    primo_codice: 20035,
  ),
  CatalogoModel(
    id: 34,
    nome: 'Anelli copritesta per chiavi      ',
    descrizione: 'In scatola da 200 pezzi in plastica assortita in 8 colori ',
    famiglia: 7,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 856,
    primo_codice: 57210,
  ),
  CatalogoModel(
    id: 37,
    nome: 'Anelli portachiavi    ',
    descrizione: 'In acciaio, in confezioni da 100 pezzi ',
    famiglia: 7,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 861,
    primo_codice: 57230,
  ),
  CatalogoModel(
    id: 39,
    nome: 'Anelli tubolari in ottone lucido       ',
    descrizione: 'Per tendine',
    famiglia: 8,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 89,
    primo_codice: 68010,
  ),
  CatalogoModel(
    id: 41,
    nome: 'Montanti scaffalature a bulloni           ',
    descrizione:
    'In lamiera verniciata a caldo. Ral 7038. Dimensioni mm. 35x35, spessore 18/10',
    famiglia: 7,
    nuovo: 0,
    sospeso: 0,
    ordinatore: 285,
    primo_codice: 275040,
  ),

];
