



import 'package:flutter/services.dart';
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