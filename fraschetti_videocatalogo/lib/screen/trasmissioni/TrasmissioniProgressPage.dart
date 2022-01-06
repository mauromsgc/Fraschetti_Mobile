import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/helper/DBHelper.dart';
import 'package:fraschetti_videocatalogo/models/parametriModel.dart';
import 'package:fraschetti_videocatalogo/models/utenteCorrenteModel.dart';
import 'package:fraschetti_videocatalogo/repositories/dbRepository.dart';
import 'package:fraschetti_videocatalogo/screen/auth/ParametriConnesionePage.dart';
import 'package:fraschetti_videocatalogo/screen/Invii/InvioLista.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';
import 'package:fraschetti_videocatalogo/utils/Utility.dart';
import 'package:get_it/get_it.dart';

class TrasmissioniProgressPage extends StatefulWidget {
  TrasmissioniProgressPage({Key? key}) : super(key: key);
  static const String routeName = "trasmissioni_progress_page";
  final String pagina_titolo = "Trasmissioni";

  @override
  _TrasmissioniProgressPageState createState() =>
      _TrasmissioniProgressPageState();
}

class ProgressData {
  String titolo = "";
  String messaggio = "";
  int progress = -2;
  String errore = "";

  ProgressData({
    this.titolo = "",
    this.messaggio = "",
    this.progress = -2,
    this.errore = "",
  });

  Map<String, Object?> toMap() {
    var map = <String, dynamic>{
      "titolo": titolo,
      "messaggio": messaggio,
      "progress": progress,
      "errore": errore,
    };

    return map;
  }

}

class _TrasmissioniProgressPageState extends State<TrasmissioniProgressPage> {
  // final StreamController<ProgressData> _progress_stream_con = StreamController<ProgressData>();

  late StreamController<ProgressData> _progress_stream_con;
  late StreamSubscription<ProgressData> streamSubscription;
  late Stream<ProgressData> _progress_stream;

  String _test_titolo = "";
  int _test_progress = 0;
  String _test_messaggio = "";
  String _test_errore = "";

  @override
  void initState() {
    super.initState();

    _progress_stream_con = StreamController<ProgressData>.broadcast();

    streamSubscription = _progress_stream_con.stream.listen((valore) {
      print('streamSubscription listen valore: ${valore.toMap()}');
      _progress_aggiorna(progress_data: valore);
    });


    // _progress_stream = _progress_stream_con.stream;
    //
    // _progress_stream.listen((valore) {
    //   print('_progress_stream.listen valore: ${valore.progress}');
    //   // _test_progress = valore.
    //   _progress_aggiorna(progress_data: valore);
    //   // setState(() {
    //   //   _test_progress = valore.progress;
    //   // });
    // });


    // streamSubscription = _progress_stream.listen((valore) {
    //     print('streamSubscription listen valore: ${valore.progress}');
    //   });

    // StreamSubscription<ProgressData> streamSubscription = _progress_stream.listen((ProgressData valore) {
    //   print('streamSubscription listen valore: ${valore.progress}');
    // });

  }

  @override
  void dispose() {
    streamSubscription.cancel();
    _progress_stream_con.close();
    super.dispose();
  }

  void _annulla() {}

  void _test_0({StreamController<ProgressData>? progress_stream_con}) async {
     progress_stream_con!.add(ProgressData(titolo: "titolo test 0", progress: 10000, messaggio: "messaggio test 0"));

  }

  void _test_1() async {
    // _alert(
    //     titolo: "Attenzione",
    //     messaggio: "Errore trasmissione\nProvare di nuovo");
    //
    // // _progress_stream_con.add(ProgressData(progress: 5));
    // _progress_stream_con.add(ProgressData(titolo: "", progress: 0, messaggio: ""));


    // await aggiornamenti_controlla();
    aggiornamenti_controlla(progress_stream_con: _progress_stream_con);

  }

  void _test_2() async {
    // StreamSubscription<ProgressData> streamSubscription = _progress_stream.listen((valore) {
    //   print('streamSubscription listen valore: ${valore.progress}');
    // });

    _test_0(progress_stream_con: _progress_stream_con);
    _progress_stream_con.sink.add(ProgressData(titolo: "Titolo", progress: 1));

    _progress_stream_con.add(ProgressData(titolo: "Titolo", progress: 100, messaggio: "messaggio"));

  }

  void _progress_aggiorna({ProgressData? progress_data}){
    if(progress_data != null){

      setState(() {
        if(progress_data.titolo != null){
          _test_titolo = progress_data.titolo;
        }
        if(progress_data.progress != null){
        _test_progress = progress_data.progress;
        }
        if(progress_data.messaggio != null){
          _test_messaggio = progress_data.messaggio;
        }
        if(progress_data.errore != null){
          _test_errore = progress_data.errore;
        }
      });

    }
  }


  void aggiorna_da_server({StreamController<ProgressData>? progress_stream_con}) async {
    // dopo aggioranamento scrip e dati
    // verificare se il videocatalogo è ancora  attivvo o no
    // dopo aggiornamento dati verificare se
    // è stato attivato il listino o le promozioni

    bool aggiornamenti_disponibili = false;

    try {
      aggiornamenti_disponibili = await aggiornamenti_controlla(progress_stream_con: progress_stream_con);

      if (aggiornamenti_disponibili == true) {
        // software_aggiorna(progress_stream_con: progress_stream_con);

        await sql_aggiorna(progress_stream_con: progress_stream_con);
        // ricaricare dati utente e controllare prametri
        // GetIt.instance<UtenteCorrenteModel>().inizializza(); // ricarica anche ParametriModel
        if ((GetIt.instance<UtenteCorrenteModel>().utente_username == "") ||
            (GetIt.instance<UtenteCorrenteModel>().utente_in_attivita == 0)) {
          print("Videocatalogo disattivato");
          return;
        }

        await comunicazioni_aggiorna(progress_stream_con: progress_stream_con);

        // immagini_aggiorna(progress_stream_con: progress_stream_con); //NEW PROMO

        await dati_aggiorna(progress_stream_con: progress_stream_con);
        // ricaricare dati utente econtrollare parametri e se utente ancora attivo
        GetIt.instance<UtenteCorrenteModel>()
            .inizializza(); // ricarica anche ParametriModel
        if ((GetIt.instance<UtenteCorrenteModel>().utente_username == "") ||
            (GetIt.instance<UtenteCorrenteModel>().utente_in_attivita == 0)) {
          print("Videocatalogo disattivato");
          return;
        }
        // attivazione_listino(progress_stream_con: progress_stream_con);

        // attivazione promozioni(progress_stream_con: progress_stream_con);

        await immagini_aggiorna(progress_stream_con: progress_stream_con);
      }
    } catch (exception) {
      print("Errore durante l'aggiornamento: ${exception}");
    }
  }

  Future<bool> aggiornamenti_controlla({StreamController<ProgressData>? progress_stream_con}) async {
    bool aggiornamenti_disponibili = false;

    aggiornamenti_disponibili =
        await GetIt.instance<ParametriModel>().aggiornamenti_controlla(progress_stream_con: progress_stream_con);
    if (aggiornamenti_disponibili == true) {
      print("Aggiornamenti presenti");
    } else {
      print("Nessun aggiornamento da scaricare");
    }

    return aggiornamenti_disponibili;
  }

  Future<void> sql_aggiorna({StreamController<ProgressData>? progress_stream_con}) async {
    final valid = await GetIt.instance<DbRepository>().sql_aggiorna(progress_stream_con: progress_stream_con);
    if (valid) {
      print("Aggiornamento completato");
    } else {
      print("Errore durante l'aggiornamento, riprovare");
    }
  }

  Future<void> dati_aggiorna({StreamController<ProgressData>? progress_stream_con}) async {
    final valid = await GetIt.instance<DbRepository>().dati_aggiorna(progress_stream_con: progress_stream_con);
    if (valid) {
      print("Aggiornamento completato");
    } else {
      print("Errore durante l'aggiornamento, riprovare");
    }
  }

  Future<void> comunicazioni_aggiorna({StreamController<ProgressData>? progress_stream_con}) async {
    final valid = await GetIt.instance<DbRepository>().comunicazioni_aggiorna(progress_stream_con: progress_stream_con);
    if (valid) {
      print("Aggiornamento completato");
    } else {
      print("Errore durante l'aggiornamento, riprovare");
    }
  }

  Future<void> immagini_aggiorna({StreamController<ProgressData>? progress_stream_con}) async {
    final valid = await GetIt.instance<DbRepository>().immagini_aggiorna(progress_stream_con: progress_stream_con);
    if (valid) {
      print("Aggiornamento completato");
    } else {
      print("Errore durante l'aggiornamento, riprovare");
    }
  }

  Future<void> immagini_aggiorna_mancanti({StreamController<ProgressData>? progress_stream_con}) async {
    final valid =
        await GetIt.instance<DbRepository>().immagini_mancanti_aggiorna(progress_stream_con: progress_stream_con);
    if (valid) {
      print("Aggiornamento completato");
    } else {
      print("Errore durante l'aggiornamento, riprovare");
    }
  }

  void _alert({String titolo = "", String messaggio = ""}) async {
    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("${titolo}"),
          content: Text("${messaggio}"),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("Chiudi"),
            ),
          ],
        );
      },
    );
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
        // bottomNavigationBar: BottomBarWidget(),
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                top: 5,
              ),
              child: Column(
                children: [
                  Container(
                    // width: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          // width: double.maxFinite,
                          decoration: MyBoxDecoration().MyBox(),
                        ),
                        // StreamBuilder<ProgressData>(
                        //   stream: _progress_stream_con.stream,
                        //   initialData: ProgressData(titolo: "", messaggio: "", progress: 0),
                        //   // builder: (BuildContext context, AsyncSnapshot<ProgressData> snapshot) {
                        //     builder: (BuildContext context, AsyncSnapshot<ProgressData> snapshot) {
                        //     return
                        //     Text("Ciao ${snapshot.data!.progress}");
                        //
                        //   }
                        // ),

                        Container(
                          // width: double.maxFinite,
                          decoration: MyBoxDecoration().MyBox(),
                          child: Text("${_test_titolo}"),
                        ),
                        Container(
                          // width: double.maxFinite,
                          decoration: MyBoxDecoration().MyBox(),
                          child: Text("${_test_progress}"),
                        ),
                        Container(
                          // width: double.maxFinite,
                          decoration: MyBoxDecoration().MyBox(),
                          child: Text("${_test_messaggio}"),
                        ),
                        Container(
                          // width: double.maxFinite,
                          decoration: MyBoxDecoration().MyBox(),
                          child: Text("${_test_errore}"),
                        ),

                        Container(
                          // width: double.maxFinite,
                          decoration: MyBoxDecoration().MyBox(),
                          child: Text("Progress continuo"),
                        ),

                        Container(
                          // width: double.maxFinite,
                          decoration: MyBoxDecoration().MyBox(),
                          child: Text("Progress continuo"),
                        ),
                        Container(
                          // width: double.maxFinite,
                          decoration: MyBoxDecoration().MyBox(),
                          child: Text("Progress "),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: double.maxFinite,
                        ),
                        Container(
                          // lo fa già il server
                          height: 50,
                          width: double.maxFinite,
                          padding: EdgeInsets.all(5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(elevation: 2),
                            onPressed: () {
                              _test_1();
                            },
                            child: Text('Test 1'),
                          ),
                        ),
                        Container(
                          // lo fa già il server
                          height: 50,
                          width: double.maxFinite,
                          padding: EdgeInsets.all(5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(elevation: 2),
                            onPressed: () {
                              _test_2();
                            },
                            child: Text('Test 2'),
                          ),
                        ),
                        Container(
                          // lo fa già il server
                          height: 50,
                          width: double.maxFinite,
                          padding: EdgeInsets.all(5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(elevation: 2),
                            onPressed: () {
                              _annulla();
                            },
                            child: Text('Annulla'),
                          ),
                        ),
                        Container(
                          // lo fa già il server
                          height: 50,
                          width: double.maxFinite,
                          padding: EdgeInsets.all(5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(elevation: 2),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Indietro'),
                          ),
                        ),
                      ],
                    ),
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
