import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fraschetti_videocatalogo/repositories/httpRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
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

Future<bool> connessione_test(BuildContext context) async {
  bool connessione_test = false;
  final response =
      await GetIt.instance<HttpRepository>().http!.connessione_test();

  if (response["data"] == "OK") {
    connessione_test = true;
  }

  return connessione_test;
}

void connessione_test_alert(BuildContext context) async {
  bool test_esito = false;
  String test_esito_testo = "";

  test_esito = await connessione_test(context);

  if (test_esito == true) {
    test_esito_testo = """Test di connessione eseguito con esito positivo""";
  } else {
    test_esito_testo = """
Test FALLITO,
Verificare il collegamento ad internet
e riprovare""";
  }
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Test connessione"),
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

void test() {
  print(NumberFormat.currency(locale: 'eu', symbol: '')
      .format(123456)); // 123.456,00
}

extension StringExtension on String {
  int toInt() {
    return (int.tryParse(this) != null) ? int.tryParse(this)! : 0;
  }

  double toDouble() {
    return (double.tryParse(this) != null) ? double.tryParse(this)! : 0;
  }

  double toDoubleSql() {
    String input = "";
    double output = 0;
    input = this.replaceAll(".", "").replaceAll(",", ".");
    output = (double.tryParse(input) != null) ? double.tryParse(input)! : 0;

    return output;
  }

  num? toNumber() {
    return (num.tryParse(this) != null) ? num.tryParse(this)! : 0;
  }
}

extension NumberParsing_double on double {
  String toImporti() {
    // return NumberFormat.currency(locale: 'eu', symbol: "").format(this);
    return NumberFormat("#.00", "it").format(this);
  }

  String toQuantita() {
    var NumQuantita = NumberFormat("###.##", "it");
    return NumQuantita.format(this);
  }
}

extension NumberParsing_int on int {
  String toQuantita() {
    var NumQuantita = NumberFormat("###.##", "it");
    return NumQuantita.format(this);
  }
}
