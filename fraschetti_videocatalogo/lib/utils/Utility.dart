



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fraschetti_videocatalogo/repositories/httpRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:macadress_gen/macadress_gen.dart';


// per il momento non funziona
// utilizzo
// _codice_macchina = await get_mac_address();
// print("MacAddress: "+_codice_macchina);

Future<String> get_mac_address() async {
  MacadressGen macadressGen = MacadressGen();

  String _mac_address = "";

  _mac_address = await macadressGen.getMac();

  return _mac_address;

}


Future<bool> test_comunicazione(BuildContext context) async {
  bool test_comunicazione = false;
  final response =
  await GetIt.instance<HttpRepository>().http!.trasmissione_test();

  if(response["data"] == "OK"){
    test_comunicazione = true;
  }

  return test_comunicazione;
}

void test_comunicazione_alert(BuildContext context) async {
  bool test_esito = false;
  String test_esito_testo = "";

  test_esito = await test_comunicazione(context);

  if(test_esito == true){
    test_esito_testo = """Test di connessione eseguito con esito positivo""";
  }else{
    test_esito_testo = """
Test FALLITO,
Verificare il collegamento ad internet
e riprovare""";
  }
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Test trasmissione"),
        content: Text("${test_esito_testo}"),
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
