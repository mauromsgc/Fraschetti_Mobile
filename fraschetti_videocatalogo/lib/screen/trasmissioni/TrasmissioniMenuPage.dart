import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/helper/DBHelper.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/models/parametriModel.dart';
import 'package:fraschetti_videocatalogo/models/utenteCorrenteModel.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:fraschetti_videocatalogo/repositories/httpRepository.dart';
import 'package:fraschetti_videocatalogo/screen/trasmissioni/TrasmissioneLista.dart';
import 'package:get_it/get_it.dart';

import '../../main.dart';

class TrasmissioniMenuLista extends StatefulWidget {
  TrasmissioniMenuLista({Key? key}) : super(key: key);
  static const String routeName = "trasmissioni_menu_lista";
  final String pagina_titolo = "Trasmissioni";

  @override
  _TrasmissioniMenuListaState createState() => _TrasmissioniMenuListaState();
}

class _TrasmissioniMenuListaState extends State<TrasmissioniMenuLista> {
  void listaClick(BuildContext context, int index) {
    // selezione al cliente e va in ordine
  }

  void aggiornamenti_controlla(BuildContext context) async {
    final response =
        await GetIt.instance<ParametriModel>().aggiornamenti_controlla();

    print("aggiornamenti_controlla: " + response.toString());
  }

  void versione_videocatalogo_mostra(BuildContext context) async {
    String versione_aggiornamento = """
  Versione: ${VIDEOCATALOGO_DISPOSIVITO_TIPO} ${VIDEOCATALOGO_VERSIONE}
  """;
    // final valid = await GetIt.instance<DbRepository>().immagini_mancanti_aggiorna();


    showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: Text("Videocatalogo"),
            content: Text("${versione_aggiornamento}"),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Chiudi")),
            ],
          ),
    );
  }

  void aggiorna_da_server(BuildContext context) async {
    // dop aggioranamento scrip e dati
    // verificare se il videocatalogo è ancora  attivvo o no
    // dopo aggiornamento dati verificare se
    // è stato attivato il listino o le promozioni


    // software_aggiorna(context);

    await sql_aggiorna(context);
    // ricaricare dati utente e controllare prametri
    // GetIt.instance<UtenteCorrenteModel>().inizializza(); // ricarica anche ParametriModel
    if((GetIt.instance<UtenteCorrenteModel>().utente_username == "") || (GetIt.instance<UtenteCorrenteModel>().utente_in_attivita == 0)){
      print("Videocatalogo disattivato");
      return;
    }

    await comunicazioni_aggiorna(context);

    // immagini_aggiorna(context); //NEW PROMO

    await dati_aggiorna(context);
    // ricaricare dati utente econtrollare parametri e se utente ancora attivo
    GetIt.instance<UtenteCorrenteModel>().inizializza(); // ricarica anche ParametriModel
    if((GetIt.instance<UtenteCorrenteModel>().utente_username == "") || (GetIt.instance<UtenteCorrenteModel>().utente_in_attivita == 0)){
      print("Videocatalogo disattivato");
      return;
    }
    // attivazione_listino();

    // attivazione promozioni();

    await immagini_aggiorna(context);




  }

  Future<void> sql_aggiorna(BuildContext context) async {
    final valid = await GetIt.instance<DbRepository>().sql_aggiorna();
    if (valid) {
      print("Aggiornamento completato");
    } else {
      print("Errore durante l'aggiornamento, riprovare");
    }
  }

  Future<void> dati_aggiorna(BuildContext context) async {
    final valid = await GetIt.instance<DbRepository>().dati_aggiorna();
    if (valid) {
      print("Aggiornamento completato");
    } else {
      print("Errore durante l'aggiornamento, riprovare");
    }
  }

  Future<void> comunicazioni_aggiorna(BuildContext context) async {
    final valid = await GetIt.instance<DbRepository>().comunicazioni_aggiorna();
    if (valid) {
      print("Aggiornamento completato");
    } else {
      print("Errore durante l'aggiornamento, riprovare");
    }
  }

  Future<void> immagini_aggiorna(BuildContext context) async {
    final valid = await GetIt.instance<DbRepository>().immagini_aggiorna();
    if (valid) {
      print("Aggiornamento completato");
    } else {
      print("Errore durante l'aggiornamento, riprovare");
    }
  }

  Future<void> immagini_aggiorna_mancanti(BuildContext context) async {
    final valid = await GetIt.instance<DbRepository>().immagini_mancanti_aggiorna();
    if (valid) {
      print("Aggiornamento completato");
    } else {
      print("Errore durante l'aggiornamento, riprovare");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.menu),
          // ),
          title: Text(widget.pagina_titolo),
          centerTitle: true,
          // bottom: OrdineTopMenu(context),
        ),
        bottomNavigationBar: BottomBarWidget(),
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: 5,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    // width: double.maxFinite,
                    width: 300,
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 2),
                      onPressed: () {
                        // Navigator.of(context).pop();
                      },
                      child: Text('Trasmetti ordini'),
                    ),
                  ),
                  Container(
                    height: 50,
                    // width: double.maxFinite,
                    width: 300,
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 2),
                      onPressed: () {
                        aggiorna_da_server(context);
                      },
                      child: Text('Aggiorna da server'),
                    ),
                  ),
                  Container(
                    height: 50,
                    // width: double.maxFinite,
                    width: 300,
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 2),
                      onPressed: () {
                        aggiornamenti_controlla(context);
                      },
                      child: Text('Verifica disponibilità aggiornamenti'),
                    ),
                  ),
                  Container(
                    // solo per agenti
                    height: 50,
                    // width: double.maxFinite,
                    width: 300,
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 2),
                      onPressed: () {
                        Navigator.popAndPushNamed(
                            context, TrasmissioneLista.routeName);
                      },
                      child: Text('Trasmissioni esito'),
                    ),
                  ),
                  Container(
                    // lo fa già il server
                    height: 50,
                    // width: double.maxFinite,
                    width: 300,
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 2),
                      onPressed: () {
                        // Navigator.popAndPushNamed(context, routeName);
                      },
                      child: Text('Trasmissioni fallite'),
                    ),
                  ),
                  Container(
                    // lo fa già il server
                    height: 50,
                    // width: double.maxFinite,
                    width: 300,
                    // padding: EdgeInsets.all(5),
                    // child: ElevatedButton(
                    //   style: ElevatedButton.styleFrom(elevation: 2),
                    //   onPressed: () {
                    //     Navigator.of(context).pop();
                    //   },
                    //   child: Text('Invia email senza prezzi'),
                    // ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
