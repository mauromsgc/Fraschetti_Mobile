import 'package:flutter/foundation.dart';
import 'package:fraschetti_videocatalogo/models/promozioneModel.dart';

class PromozioniRepository {
  Future<List<PromozioneModel>> all() async {
    await Future.delayed(Duration(seconds: 3));
    return fakePromozioni;
  }

  List<PromozioneModel> all_2() {
    return fakePromozioni;
  }
}

final fakePromozioni = [
  // PromozioneModel(
  //   id: 0,
  //   nome: "",
  //   sconto: "",
  //   permanente: "",
  //   tour: "",
  //   ordinatore: 0,
  // )
  PromozioneModel(
    id: 204,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 64,
    nome: "Itap rubinetteria e valvole",),
  PromozioneModel(
    id: 353,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 40,
    nome: "Punte Testa piana",),
  PromozioneModel(
    id: 1452,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 41,
    nome: "Punte Testa Piana 16x60 - 20x100",),
  PromozioneModel(
    id: 1514,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 67,
    nome: "Silca UL 050-051-052-053-058-059",),
  PromozioneModel(
    id: 2741,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 68,
    nome: "Silca Chiavi First Class confezione 100+10",),
  PromozioneModel(
    id: 2742,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 69,
    nome: "Silca Chiavi Doppia Mappa",),
  PromozioneModel(
    id: 4799,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 70,
    nome: "Silca Chiavi Silky",),
  PromozioneModel(
    id: 4812,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 43,
    nome: "Fischer Ancorante Fip C700 HP",),
  PromozioneModel(
    id: 4856,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 44,
    nome: "Fischer Ancorante T BOND",),
  PromozioneModel(
    id: 4919,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 37,
    nome: "Pile Duracell",),
  PromozioneModel(
    id: 4950,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 57,
    nome: "Henkel Pattex Schiuma Poliuretanica",),
  PromozioneModel(
    id: 4968,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 42,
    nome: "Dischi abrasivi Grinding",),
  PromozioneModel(
    id: 5062,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 45,
    nome: "Fischer Ancorante PE 300 SF",),
  PromozioneModel(
    id: 5085,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 23,
    nome: "Brixo Carta Asciugamani",),
  PromozioneModel(
    id: 5110,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 32,
    nome: "Scaffali metallici 5 piani",),
  PromozioneModel(
    id: 5352,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 52,
    nome: "Fischer Tasselli SB SBS SBN",),
  PromozioneModel(
    id: 5356,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 46,
    nome: "Fischer Tasselli SLM 6 T.E. PROMO",),
  PromozioneModel(
    id: 5358,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 66,
    nome: "Silca Duplicatrici Targa 2000 P",),
  PromozioneModel(
    id: 5378,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 49,
    nome: "Fischer Tasselli SLM 6 - SLM 8",),
  PromozioneModel(
    id: 5402,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 55,
    nome: "Henkel Super Attak",),
  PromozioneModel(
    id: 5406,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 15,
    nome: "Cassette agricole impilabili",),
  PromozioneModel(
    id: 5415,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 54,
    nome: "Fischer Tasselli SX 6S Cod. 525017",),
  PromozioneModel(
    id: 5416,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 36,
    nome: "Foglia Additivata bianco/nera",),
  PromozioneModel(
    id: 5417,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 18,
    nome: "Forbici cogliuva Brixo",),
  PromozioneModel(
    id: 5418,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 19,
    nome: "Forbici cogliuva Baho Pradines",),
  PromozioneModel(
    id: 5419,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 20,
    nome: "Forbici cogliuva Samurai",),
  PromozioneModel(
    id: 5422,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 22,
    nome: "Olio Enologico di vaselina",),
  PromozioneModel(
    id: 5437,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 51,
    nome: "Fischer Tasselli SLM",),
  PromozioneModel(
    id: 5440,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 38,
    nome: "Espositore Duracell Torce Led",),
  PromozioneModel(
    id: 5441,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 30,
    nome: "Espositore Occhiali da Lettura",),
  PromozioneModel(
    id: 5443,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 58,
    nome: "Henkel Millechiodi Pattex",),
  PromozioneModel(
    id: 5444,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 56,
    nome: "Henkel Espositore Power Tape Pattex",),
  PromozioneModel(
    id: 5445,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 17,
    nome: "Beta Scarpe",),
  PromozioneModel(
    id: 5447,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 59,
    nome: "Henkel Pattex SP 101 cod. 450148",),
  PromozioneModel(
    id: 5449,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 24,
    nome: "Arexons Pennarelli",),
  PromozioneModel(
    id: 5450,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 76,
    nome: "Asfalto a freddo",),
  PromozioneModel(
    id: 5452,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 16,
    nome: "Bidoni in plastica",),
  PromozioneModel(
    id: 5453,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 26,
    nome: "B&D Aspirazione ricaricabile",),
  PromozioneModel(
    id: 5455,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 25,
    nome: "B&D Piccoli Elettrodomestici resto gamma",),
  PromozioneModel(
    id: 5456,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 62,
    nome: "Brixo Siliconi",),
  PromozioneModel(
    id: 5457,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 29,
    nome: "Carrelli spesa Gimi",),
  PromozioneModel(
    id: 5458,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 132,
    nome: "Catene per motoseghe",),
  PromozioneModel(
    id: 5459,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 35,
    nome: "Collari e Guinzagli",),
  PromozioneModel(
    id: 5460,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 34,
    nome: "Cucce per cani",),
  PromozioneModel(
    id: 5461,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 78,
    nome: "Deca caricabatterie",),
  PromozioneModel(
    id: 5462,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 79,
    nome: "Deca Saldatrici",),
  PromozioneModel(
    id: 5463,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 75,
    nome: "Guaina liquida - Primer",),
  PromozioneModel(
    id: 5464,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 60,
    nome: "Henkel Pattex Siliconi Bianco e Trasparente",),
  PromozioneModel(
    id: 5465,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 61,
    nome: "Henkel Pattex Siliconi",),
  PromozioneModel(
    id: 5466,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 71,
    nome: "Plastica Ondulata e Piana",),
  PromozioneModel(
    id: 5467,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 80,
    nome: "Saldatrici Stanley",),
  PromozioneModel(
    id: 5468,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 27,
    nome: "Sottovuoto Reber",),
  PromozioneModel(
    id: 5469,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 81,
    nome: "Topicida",),
  PromozioneModel(
    id: 5471,
    sconto: "0",
    permanente: "1",
    tour: "Olivo",
    ordinatore: 4,
    nome: "Olivo Batterie Auto",),
  PromozioneModel(
    id: 5472,
    sconto: "0",
    permanente: "1",
    tour: "Olivo",
    ordinatore: 9,
    nome: "Olivo Cassette Raccolta 153350",),
  PromozioneModel(
    id: 5473,
    sconto: "0",
    permanente: "1",
    tour: "Olivo",
    ordinatore: 11,
    nome: "Olivo Contenitori Inox per olio",),
  PromozioneModel(
    id: 5474,
    sconto: "0",
    permanente: "1",
    tour: "Olivo",
    ordinatore: 12,
    nome: "Olivo Contenitori inox per olio Sansone",),
  PromozioneModel(
    id: 5475,
    sconto: "0",
    permanente: "1",
    tour: "Olivo",
    ordinatore: 14,
    nome: "Olivo Contenitori polietilene",),
  PromozioneModel(
    id: 5476,
    sconto: "0",
    permanente: "1",
    tour: "Olivo",
    ordinatore: 8,
    nome: "Olivo Defogliatore elettrico Tornado",),
  PromozioneModel(
    id: 5477,
    sconto: "0",
    permanente: "1",
    tour: "Olivo",
    ordinatore: 13,
    nome: "Olivo Lattine pe olio",),
  PromozioneModel(
    id: 5478,
    sconto: "0",
    permanente: "1",
    tour: "Olivo",
    ordinatore: 2,
    nome: "Olivo Rete in rotolo xx",),
  PromozioneModel(
    id: 5479,
    sconto: "0",
    permanente: "1",
    tour: "Olivo",
    ordinatore: 1,
    nome: "Olivo Rete' a teli xx",),
  PromozioneModel(
    id: 5480,
    sconto: "0",
    permanente: "1",
    tour: "Olivo",
    ordinatore: 3,
    nome: "Olivo Scale alluminio coniche e triplice",),
  PromozioneModel(
    id: 5481,
    sconto: "0",
    permanente: "1",
    tour: "Olivo",
    ordinatore: 5,
    nome: "Olivo Scuotitori",),
  PromozioneModel(
    id: 5482,
    sconto: "0",
    permanente: "1",
    tour: "Olivo",
    ordinatore: 6,
    nome: "Olivo Scuotitore Motocompressore Tubo",),
  PromozioneModel(
    id: 5483,
    sconto: "0",
    permanente: "1",
    tour: "Olivo",
    ordinatore: 7,
    nome: "Olivo Motocompressori",),
  PromozioneModel(
    id: 5484,
    sconto: "0",
    permanente: "1",
    tour: "Olivo",
    ordinatore: 10,
    nome: "Olivo Secchio Agricolo",),
  PromozioneModel(
    id: 5485,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 47,
    nome: "Fischer Punte Super DD",),
  PromozioneModel(
    id: 5486,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 83,
    nome: "Tubi Ala smaltati",),
  PromozioneModel(
    id: 5487,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 84,
    nome: "Tubi Ala 2MM Aeternum",),
  PromozioneModel(
    id: 5488,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 85,
    nome: "Tubi Professional Pellet",),
  PromozioneModel(
    id: 5489,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 86,
    nome: "Tubi Kit PPP",),
  PromozioneModel(
    id: 5490,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 92,
    nome: "Accendifuoco Diavolina",),
  PromozioneModel(
    id: 5491,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 93,
    nome: "Accendifuoco Diavolina classica 397040",),
  PromozioneModel(
    id: 5492,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 94,
    nome: "Accendifuoco EL Gaucho",),
  PromozioneModel(
    id: 5494,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 95,
    nome: "Accendifuoco Espositore EL GAUCho 397006",),
  PromozioneModel(
    id: 5495,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 106,
    nome: "Bidone aspiracenere Niklas Nerone",),
  PromozioneModel(
    id: 5496,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 105,
    nome: "Bidone aspiracenere Lavor Riù",),
  PromozioneModel(
    id: 5497,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 97,
    nome: "Stufe Gamma Dal Zotto",),
  PromozioneModel(
    id: 5498,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 101,
    nome: "Ceppi Optima",),
  PromozioneModel(
    id: 5499,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 107,
    nome: "Corredi per camino",),
  PromozioneModel(
    id: 5500,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 108,
    nome: "Corredi per camino 355041 e 355054",),
  PromozioneModel(
    id: 5503,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 91,
    nome: "Fumaioli ventolini",),
  PromozioneModel(
    id: 5504,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 102,
    nome: "Legna da ardere",),
  PromozioneModel(
    id: 5505,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 103,
    nome: "Legnetti accendifuoco",),
  PromozioneModel(
    id: 5506,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 118,
    nome: "Parafreddo Brixo",),
  PromozioneModel(
    id: 5507,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 82,
    nome: "Pellets",),
  PromozioneModel(
    id: 5508,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 109,
    nome: "Radiatori ad olio Niklas",),
  PromozioneModel(
    id: 5509,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 115,
    nome: "Riscaldatori industriali",),
  PromozioneModel(
    id: 5510,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 90,
    nome: "Scovoli per camini",),
  PromozioneModel(
    id: 5511,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 88,
    nome: "Scovoli Spazzacamino in Kit",),
  PromozioneModel(
    id: 5512,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 89,
    nome: "Pulizia e Manutenzione stufe Brixo",),
  PromozioneModel(
    id: 5513,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 110,
    nome: "Stufe Alogene Niklas",),
  PromozioneModel(
    id: 5514,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 111,
    nome: "Stufe Infrarossi Niklas",),
  PromozioneModel(
    id: 5515,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 112,
    nome: "Stufe Ambiente Niklas",),
  PromozioneModel(
    id: 5516,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 96,
    nome: "Stufe Termostufe Caldaie Pellet Foko",),
  PromozioneModel(
    id: 5517,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 99,
    nome: "Stufe e Cucine Niklas",),
  PromozioneModel(
    id: 5518,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 113,
    nome: "Stufe a Gas Niklas",),
  PromozioneModel(
    id: 5519,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 100,
    nome: "Stufe in ghisa Old America",),
  PromozioneModel(
    id: 5520,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 116,
    nome: "Termoventilatori ceramica PTC Niklas",),
  PromozioneModel(
    id: 5521,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 117,
    nome: "Termoventilatori e Termoconvettori elettrici",),
  PromozioneModel(
    id: 5522,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 114,
    nome: "Termopatio gas Niklas",),
  PromozioneModel(
    id: 5523,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 104,
    nome: "Tronchetti Eco Brik",),
  PromozioneModel(
    id: 5524,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 87,
    nome: "Tubi Flessibili in alluminio",),
  PromozioneModel(
    id: 5525,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 120,
    nome: "Deumidificatore",),
  PromozioneModel(
    id: 5526,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 121,
    nome: "Umidificatori FINE SERIE",),
  PromozioneModel(
    id: 5527,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 122,
    nome: "Umidificatori New Collection",),
  PromozioneModel(
    id: 5528,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 119,
    nome: "Aspiratori e Aereatori",),
  PromozioneModel(
    id: 5529,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 129,
    nome: "Alpina Motoseghe e Elettroseghe",),
  PromozioneModel(
    id: 5530,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 135,
    nome: "Lubrificante Protettivo catene motoseghe",),
  PromozioneModel(
    id: 5531,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 131,
    nome: "Bosch Giardino",),
  PromozioneModel(
    id: 5532,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 130,
    nome: "Elettroseghe e Motoseghe Green Cat",),
  PromozioneModel(
    id: 5533,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 133,
    nome: "Tagliasiepi Green Cat",),
  PromozioneModel(
    id: 5534,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 134,
    nome: "Soffiatori Green Cat",),
  PromozioneModel(
    id: 5536,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 123,
    nome: "Henkel Ariasana",),
  PromozioneModel(
    id: 5537,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 126,
    nome: "Passatoie",),
  PromozioneModel(
    id: 5538,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 136,
    nome: "Pompe Easy Pump",),
  PromozioneModel(
    id: 5539,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 137,
    nome: "Pompe Easy Water",),
  PromozioneModel(
    id: 5540,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 124,
    nome: "Stendibiancheria Gimi Meliconi Piuma",),
  PromozioneModel(
    id: 5541,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 125,
    nome: "Stendibiancheria Gimi",),
  PromozioneModel(
    id: 5542,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 128,
    nome: "Termometri",),
  PromozioneModel(
    id: 5543,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 127,
    nome: "Zerbini e Tappeti",),
  PromozioneModel(
    id: 5544,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 138,
    nome: "Abbigliamento",),
  PromozioneModel(
    id: 5545,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 139,
    nome: "Espositore Calze 354680",),
  PromozioneModel(
    id: 5546,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 140,
    nome: "Impermeabili e Completi PVC Nylondry",),
  PromozioneModel(
    id: 5547,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 141,
    nome: "Stivali di Sicurezza",),
  PromozioneModel(
    id: 5548,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 142,
    nome: "Stivali Gomma",),
  PromozioneModel(
    id: 5549,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 143,
    nome: "Stivali PVC",),
  PromozioneModel(
    id: 5550,
    sconto: "0",
    permanente: "1",
    tour: "Calore",
    ordinatore: 0,
    nome: "145	Calore&Colore Esterno in Inverno 3%",),
  PromozioneModel(
    id: 5551,
    sconto: "0",
    permanente: "1",
    tour: "Calore",
    ordinatore: 0,
    nome: "146	Calore&Colore Esterno in Inverno 4%",),
  PromozioneModel(
    id: 5552,
    sconto: "0",
    permanente: "1",
    tour: "Calore",
    ordinatore: 0,
    nome: "147	Calore&Colore Esterno in Inverno 5%",),
  PromozioneModel(
    id: 5553,
    sconto: "0",
    permanente: "1",
    tour: "Calore",
    ordinatore: 0,
    nome: "148	Calore&Colore Esterno in Inverno 6%",),
  PromozioneModel(
    id: 5554,
    sconto: "0",
    permanente: "1",
    tour: "Calore",
    ordinatore: 0,
    nome: "149	Calore&Colore Esterno in Inverno 10%",),
  PromozioneModel(
    id: 5555,
    sconto: "0",
    permanente: "1",
    tour: "Calore",
    ordinatore: 0,
    nome: "150	Calore&Colore Esterno in Inverno 21%",),
  PromozioneModel(
    id: 5556,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 50,
    nome: "Brixo Punte Super BB Profy",),
  PromozioneModel(
    id: 5558,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 21,
    nome: "Pompe Rover Travaso e Filtranti",),
  PromozioneModel(
    id: 5559,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 75,
    nome: "Betafence Filo Motto Zincato e Plastificato",),
  PromozioneModel(
    id: 5560,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 72,
    nome: "Betafence Pantanet Basic",),
  PromozioneModel(
    id: 5561,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 73,
    nome: "Betafence Casanet",),
  PromozioneModel(
    id: 5562,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 74,
    nome: "Betafence Agritex",),
  PromozioneModel(
    id: 5563,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 28,
    nome: "Tritacarne e Insaccatrice",),
  PromozioneModel(
    id: 5564,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 31,
    nome: "Espositore Moschettoni cod. 057100",),
  PromozioneModel(
    id: 5565,
    sconto: "0",
    permanente: "1",
    tour: "Autunno",
    ordinatore: 98,
    nome: "Stufe Termostufe Cucine Termocucine Nordica",),
  PromozioneModel(
    id: 5566,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 65,
    nome: "Silca Pacco chiavi Simpsons cod. 515700",),
  PromozioneModel(
    id: 5567,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 77,
    nome: "Espositore Frese a tazza cod. 497991",),
  PromozioneModel(
    id: 5568,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 39,
    nome: "Varta Torce",),
  PromozioneModel(
    id: 5570,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 33,
    nome: "Espositore Tecknik Arexons",),
  PromozioneModel(
    id: 5571,
    sconto: "0",
    permanente: "1",
    tour: "Power_Team",
    ordinatore: 144,
    nome: "Power Team",),
  PromozioneModel(
    id: 5572,
    sconto: "0",
    permanente: "1",
    tour: "Offerte_mese",
    ordinatore: 74,
    nome: "Scale alluminio telescopica StepUp",),
];

