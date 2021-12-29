import 'package:fraschetti_videocatalogo/models/clienteModel.dart';
import 'package:fraschetti_videocatalogo/models/ordineModel.dart';

class SessioneModel {
  static final SessioneModel _istanza = SessioneModel._costruttore_privato();

  factory SessioneModel() {
    return _istanza;
  }

  SessioneModel._costruttore_privato() {
    // inizializzazione
    this.inizializza();
  }

  int bottom_bar_indice = 0;
  int ordine_top_menu_indice = 0;

  int clienti_id_selezionato = 0;
  String cliente_Nominativo_selezionato = "";
  String cliente_Localita_selezionato = "";
  int ordine_id_corrente = 0;
  int reso_id_corrente = 0;

  void inizializza() {
    this.bottom_bar_indice = 0;
    this.ordine_top_menu_indice = 0;
    this.clienti_id_selezionato = 0;
    this.cliente_Nominativo_selezionato = "";
    this.cliente_Localita_selezionato = "";
    this.ordine_id_corrente = 0;
    this.reso_id_corrente = 0;
  }

  Future<bool> cliente_seleziona({int clienti_id = 0}) async {
    // seleziona il cliente se lo trova
    // e seleziona/crea il numero di ordine
    // se non ci sono odini/resi o se c'è già un ordine
    // se ci sono più ordini seleziona il più recente
    // quello con il numero maggiore
    bool cliente_selezionato = false;

    // cerco il cliente per leggere i suoi dati
    ClienteModel cliente = await ClienteModel.cliente_da(
            clienti_id: clienti_id,
        );

    if (cliente.id != 0) {
      cliente_selezionato = true;
      this.clienti_id_selezionato = cliente.id;
      this.cliente_Nominativo_selezionato = cliente.codice + " " + cliente.ragione_sociale;
      this.cliente_Localita_selezionato = cliente.localita;
    }


    return cliente_selezionato;
  }

  bool cliente_deseleziona() {
    // deseleziona il cliente
    // e azzera il numero di ordine e reso
    bool cliente_deselezionato = true;

    this.clienti_id_selezionato = 0;
    this.cliente_Nominativo_selezionato = "";
    this.cliente_Localita_selezionato = "";
    this.ordine_id_corrente = 0;
    this.reso_id_corrente = 0;

    return cliente_deselezionato;
  }

  bool ordine_id_imposta({int id = 0}) {
    // imposta l'id per l'ordine
    bool esito = true;

    this.ordine_id_corrente = id;

    return esito;
  }

  bool reso_id_imposta({int id = 0}) {
    // imposta l'id per il reso
    bool esito = true;

    this.reso_id_corrente = id;

    return esito;
  }
}
