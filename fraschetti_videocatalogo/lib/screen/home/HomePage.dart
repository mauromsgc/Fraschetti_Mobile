import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  final String pagina_titolo = "Home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.pagina_titolo),
          centerTitle: true,
        ),
        body: Container(
          child:
          Text('Home page'),
        ),
      ),
    );
  }
}
