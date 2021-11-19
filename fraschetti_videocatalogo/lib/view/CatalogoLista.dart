import 'package:flutter/material.dart';

class CatalogoListaPage extends StatefulWidget {
  CatalogoListaPage({Key? key, this.title = 'Catalogo'}) : super(key: key);

  final String title;

  @override
  _CatalogoListaPageState createState() => _CatalogoListaPageState();
}

class _CatalogoListaPageState extends State<CatalogoListaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
        ),
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          padding: new EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.orange,
              width: 2,
            ),
          ),
          width: 600,
          child:
          ListView(
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
        ),

      ),
      bottomNavigationBar: _DemoBottomAppBar(),
    );
  }
}


class _DemoBottomAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.blue,
      child: IconTheme(
        data: IconThemeData(color: Theme
            .of(context)
            .colorScheme
            .onPrimary),
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
