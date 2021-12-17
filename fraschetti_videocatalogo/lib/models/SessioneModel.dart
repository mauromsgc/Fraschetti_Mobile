class SessioneModel {
  static final SessioneModel _istanza = SessioneModel._costruttore_privato();

  factory SessioneModel() {
    return _istanza;
  }

  SessioneModel._costruttore_privato() {
    // inizializzazione
    this.inizializza();
  }

  void inizializza() {
    this.bottom_bar_indice = 0;
    this.ordine_top_menu_indice = 0;
    this.cliente_id_selezionato = 0;
  }

  int bottom_bar_indice = 0;
  int ordine_top_menu_indice = 0;

  // poi spostarlo un utente corrente
  int cliente_id_selezionato = 0;
}
