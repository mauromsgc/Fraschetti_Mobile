// app bar generale
import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/screen/altro/AltroMenuPage.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/ClientiLista.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/OrdineLista.dart';
import 'package:fraschetti_videocatalogo/screen/promozioni/PromozioneLista.dart';
import 'package:fraschetti_videocatalogo/screen/trasmissioni/TrasmissioniMenuPage.dart';
import 'package:get_it/get_it.dart';

import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/screen/catalogo/CatalogoLista.dart';
import 'package:fraschetti_videocatalogo/screen/comunicazioni/ComunicazioneLista.dart';

class BottomBarWidget extends StatefulWidget {
  BottomBarWidget({Key? key}) : super(key: key);

  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  // int _selectedIndex = 0;
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  int _selectedIndex = 0;

  var _sessione = GetIt.instance<SessioneModel>();

  @override
  void initState() {
    super.initState();
    _selectedIndex = _sessione.bottom_bar_indice;
  }

  void _onItemTapped(int index) {
    _sessione.bottom_bar_indice = index;
    _pagina_apri(index);
  }

  void _pagina_apri(int index) {
    switch (index) {
      case 0:
        Navigator.popAndPushNamed(context, CatalogoListaPage.routeName);
        return;
      // break;
      case 1:
        Navigator.popAndPushNamed(context, PromozioneListaPage.routeName);
        return;
      // break;
      case 2:
        Navigator.popAndPushNamed(context, ComunicazioneListaPage.routeName);
        break;
      case 3:
        if (GetIt.instance<SessioneModel>().clienti_id_selezionato == 0) {
          // se il cliente NON è selezionato va in elenco clienti
          GetIt.instance<SessioneModel>().ordine_top_menu_indice = 0;
          Navigator.popAndPushNamed(context, ClienteLista.routeName);
        } else {
          // se il cliente è già selezionato va in ordine
          GetIt.instance<SessioneModel>().ordine_top_menu_indice = 1;
          Navigator.popAndPushNamed(context, OrdineLista.routeName);
        }
        break;
      case 4:
        Navigator.pushNamed(context, TrasmissioniMenuLista.routeName);
        break;
      case 5:
        Navigator.pushNamed(context, AltroMenuLista.routeName);
        break;
      default:
        Navigator.popAndPushNamed(context, CatalogoListaPage.routeName);
        break;
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Colors.grey.shade600,
      currentIndex: _selectedIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      showUnselectedLabels: true,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.view_list),
          label: 'Catalogo',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.view_module),
          label: 'Promozioni',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.view_array),
          label: 'Comunicazioni',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.topic),
          label: 'Ordini',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.unarchive),
          label: 'Tramissioni',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.tune),
          label: 'Altro',
        ),
      ],
    );
  }
}
