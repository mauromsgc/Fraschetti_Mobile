import 'package:flutter/material.dart';

class CatalogoListaPage extends StatefulWidget {
  CatalogoListaPage({Key? key, this.title = 'Catalogo 2'}) : super(key: key);
  static const String routeName = 'CatalogoLista';

  final String title;

  @override
  _CatalogoListaPageState createState() => _CatalogoListaPageState();
}

class _CatalogoListaPageState extends State<CatalogoListaPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Icon(
            Icons.menu,
          ),
          title: Text(widget.title),
        ),
        body: Center(
          child: Container(
            // padding: new EdgeInsets.all(10.0),
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     color: Colors.orange,
            //     width: 2,
            //   ),
            // ),
            // width: 600,
            child: Column(
              children: <Widget>[
                _RicercaWidget(),
                _SelezioniWidget(),
                _CategorieWidget(),
                _ListaWidget(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _DemoBottomAppBar(),
      ),
    );
  }
}

// sezione ricerca
class _RicercaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                // labelText: 'Descrizione/EAN',
                // labelText: 'Descrizione',
                hintText: 'Descrizione',
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 2,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                // labelText: 'Codice',
                hintText: 'Codice',
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 2),
              onPressed: () {},
              child: Text('Cerca'),
            ),
          ),
        ],
      ),
    );
  }
}

// sezione selezioni
class _SelezioniWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 2),
              onPressed: () {},
              child: Text('Assortimenti'),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 2),
              onPressed: () {},
              child: Text('Selezioni'),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 2),
              onPressed: () {},
              child: Text('Tutto'),
            ),
          ),
        ],
      ),
    );
  }
}

// sezione categorie
class _CategorieWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: 10.0, // insert your font size here
              ),
              primary: Colors.red,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
            ),
            onPressed: () {},
            child: Text('Edilizia'),
          ),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: 10.0, // insert your font size here
              ),
              primary: Colors.red,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
            ),
            onPressed: () {},
            child: Text('Ut. mano'),
          ),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: 10.0, // insert your font size here
              ),
              primary: Colors.red,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
            ),
            onPressed: () {},
            child: Text('Ferram.'),
          ),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: 10.0, // insert your font size here
              ),
              primary: Colors.red,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
            ),
            onPressed: () {},
            child: Text('Giardin.'),
          ),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: 10.0, // insert your font size here
              ),
              primary: Colors.red,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
            ),
            onPressed: () {},
            child: Text('Ut. elet.'),
          ),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: 10.0, // insert your font size here
              ),
              primary: Colors.red,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
            ),
            onPressed: () {},
            child: Text('Idraulica'),
          ),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: 10.0, // insert your font size here
              ),
              primary: Colors.red,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
            ),
            onPressed: () {},
            child: Text('Siderurg.'),
          ),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: 10.0, // insert your font size here
              ),
              primary: Colors.red,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
            ),
            onPressed: () {},
            child: Text('Domo ut.'),
          ),
        ),
      ],
    );
  }
}

// riga lista
class _ListaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ListView(
        padding: const EdgeInsets.only(bottom: 88),
        children: <Widget>[
          SwitchListTile(
            title: const Text(
              'Floating Action Button',
            ),
            value: false,
            onChanged: (bool value) {},
          ),
          SwitchListTile(
            title: const Text('Notch'),
            value: false,
            onChanged: (bool value) {},
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Floating action button position'),
          ),
        ],
      ),
    );
  }
}

// app bar
class _DemoBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.blue,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: <Widget>[
            IconButton(
              tooltip: 'Open navigation menu',
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Search',
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Favorite',
              icon: const Icon(Icons.favorite),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
