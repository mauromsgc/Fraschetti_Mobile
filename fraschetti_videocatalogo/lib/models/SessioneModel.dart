class SessioneModel {

  // il costruttore con tutti i parametri lo uso solo per creare i record fake
  SessioneModel({
    this.bottom_bar_indice = 0,
    this.ordine_top_menu_indice = 0,
    this.cliente_id_selezionato = 0,
  });

  int bottom_bar_indice = 0;
  int ordine_top_menu_indice = 0;
  // poi spostarlo un utente corrente
  int cliente_id_selezionato = 0;

}
