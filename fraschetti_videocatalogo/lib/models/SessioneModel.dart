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

}
