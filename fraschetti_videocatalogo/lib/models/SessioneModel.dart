import 'package:fraschetti_videocatalogo/models/clienteModel.dart';

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

  int cliente_id_selezionato = 0;
  String cliente_Nominativo_selezionato = "";
  String cliente_Localita_selezionato = "";
  int ordine_numero_corrente = 0;
  int reso_numero_corrente = 0;

  void inizializza() {
    this.bottom_bar_indice = 0;
    this.ordine_top_menu_indice = 0;
    this.cliente_id_selezionato = 0;
    this.cliente_Nominativo_selezionato = "";
    this.cliente_Localita_selezionato = "";
    this.ordine_numero_corrente = 0;
    this.reso_numero_corrente = 0;
  }

  Future<bool> cliente_seleziona({int cliente_id = 0}) async {
    // seleziona il cliente se lo trova
    // e selezione/ crea il numero di ordine e reso a 1
    // se non ci sono odini/resi o se c'è già un ordine
    // se ci sono più ordini seleziona il più recente
    // quello con il numero maggiore
    bool cliente_selezionato = false;

    // cerco il cliente per leggere i suoi dati
    ClienteModel cliente =
        await ClienteModel.cliente_da(cliente_id: cliente_id);

    if (cliente.id != 0) {
      cliente_selezionato = true;
      this.cliente_id_selezionato = cliente.id;
      this.cliente_Nominativo_selezionato = cliente.codice + " " + cliente.ragione_sociale;
      this.cliente_Localita_selezionato = cliente.localita;

      // cercare il numero di ordine e reso maggiore
      this.ordine_numero_corrente = 1;
      this.reso_numero_corrente = 1;


      await ordine_numero_imposta(ordine_numero: 1);
      await reso_numero_imposta(reso_numero: 1);

    }

    return cliente_selezionato;
  }

  Future<bool> cliente_deseleziona() async {
    // deseleziona il cliente
    // e azzera il numero di ordine e reso
    bool cliente_deselezionato = true;

    this.cliente_id_selezionato = 0;
    this.cliente_Nominativo_selezionato = "";
    this.cliente_Localita_selezionato = "";
    this.ordine_numero_corrente = 0;
    this.reso_numero_corrente = 0;

    return cliente_deselezionato;
  }

  Future<bool> ordine_numero_imposta({int ordine_numero = 0}) async {
    // imposta il numero per l'ordine
    bool esito = true;

    this.ordine_numero_corrente = ordine_numero;

    return esito;
  }

  Future<bool> reso_numero_imposta({int reso_numero = 0}) async {
    // imposta il numero per il reso
    bool esito = true;

    this.reso_numero_corrente = reso_numero;

    return esito;
  }
}
