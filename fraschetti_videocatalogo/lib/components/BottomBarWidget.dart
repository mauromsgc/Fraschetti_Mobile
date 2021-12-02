// classe app bar da spostare per usare da altre parti
import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';
import 'package:fraschetti_videocatalogo/screen/catalogo/CatalogoLista.dart';
import 'package:fraschetti_videocatalogo/screen/promozioni/PromozioneLista.dart';
import 'package:fraschetti_videocatalogo/screen/promozioni/PromozionePage.dart';

import '../main.dart';

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

  var _sessione = getIt.get<SessioneModel>();

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
        Navigator.pushNamed(context, CatalogoListaPage.routeName);
        return;
      // break;
      case 1:
        Navigator.pushNamed(context, PromozioneListaPage.routeName);
        return;
      // break;
      case 2:
        // Navigator.pushNamed(context, ComunicazioneListaPage.routeName);
        break;
      case 3:
        // Navigator.pushNamed(context, OrdineListaPage.routeName);
        break;
      case 4:
        // Navigator.pushNamed(context, TrasmissionePage.routeName);
        break;
      case 5:
        // Navigator.pushNamed(context, AltroPage.routeName);
        break;
      default:
        Navigator.pushNamed(context, CatalogoListaPage.routeName);
        break;
    }
  }

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
