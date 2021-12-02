// top bar da usare per sezione ordini
import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/ClientiLista.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/OrdineCodiceCercaPage.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/OrdineLista.dart';
import 'package:fraschetti_videocatalogo/screen/ordine/OrdineResiLista.dart';
import 'package:fraschetti_videocatalogo/screen/promozioni/PromozioneLista.dart';
import 'package:get_it/get_it.dart';

import 'package:fraschetti_videocatalogo/models/SessioneModel.dart';

class OrdineTopMenu extends StatefulWidget {
  OrdineTopMenu({Key? key}) : super(key: key);

  @override
  _OrdineTopMenuState createState() => _OrdineTopMenuState();
}

class _OrdineTopMenuState extends State<OrdineTopMenu>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  var _sessione = GetIt.instance<SessioneModel>();
  Color? _indicator_colore = null;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    _tabController.addListener(_tabSeleziona);
    _tabController.index = _sessione.ordine_top_menu_indice;
    _indicator_colore = _indicator_colore_imposta(_tabController.index);
  }

  void _tabSeleziona() {
    if (_tabController.indexIsChanging) {
      // setState(() {});
      _sessione.ordine_top_menu_indice = _tabController.index;
      _indicator_colore = _indicator_colore_imposta(_tabController.index);
      _pagina_apri(_sessione.ordine_top_menu_indice);
    }
  }

  void _pagina_apri(int index) {
    switch (index) {
      case 0:
        Navigator.popAndPushNamed(context, ClienteLista.routeName);
        return;
      // break;
      case 1:
        Navigator.popAndPushNamed(context, OrdineLista.routeName);
        return;
      // break;
      case 2:
        Navigator.popAndPushNamed(context, OrdineCodiceCercaPage.routeName);
        return;
      // break;
      case 3:
        Navigator.popAndPushNamed(context, OrdineResiLista.routeName);
        return;
      // break;
      default:
        // Navigator.pushNamed(context, CatalogoListaPage.routeName);
        return;
      // break;
    }
  }

  Color? _indicator_colore_imposta(int index) {
    switch (index) {
      case 0:
        return Colors.grey.shade400;
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.lightGreen;
      case 3:
        return Colors.redAccent;
      default:
        return null;
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(100.0), // here the desired height
      child: TabBar(
        //Theme.of(context).primaryColor,
        indicator: BoxDecoration(
          color: Colors.grey.shade400 //_indicator_colore,
        ),
        // labelColor: Theme.of(context).primaryColor,
        labelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelColor: Colors.grey,
        unselectedLabelStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
        controller: _tabController,
        tabs: [
          Tab(
            text: "Clienti",
            // icon: Icon(Icons.laptop_mac),
          ),
          Tab(
            text: "Ordine",
            // icon: Icon(Icons.desktop_mac),
          ),
          Tab(
            text: "Cerca codici",
            // icon: Icon(Icons.laptop_mac),
          ),
          Tab(
            text: "Resi",
            // icon: Icon(Icons.desktop_mac),
          ),
        ],
      ),
    );
  }
}
