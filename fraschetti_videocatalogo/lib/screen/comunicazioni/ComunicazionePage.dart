import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/repositories/articoliRepository.dart';
import 'package:fraschetti_videocatalogo/models/catalogoModel.dart';
import 'package:fraschetti_videocatalogo/screen/catalogo/CatalogoPage.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';

class ComunicazionePageArgs {
  List<Map>? comunicazioni_lista;
  int indice;

  ComunicazionePageArgs({
    this.comunicazioni_lista = null,
    this.indice = 0,
  });

}

class ComunicazionePage extends StatefulWidget {
  ComunicazionePage({Key? key}) : super(key: key);
  static const String routeName = 'comunicazione_page';
  final String pagina_titolo = "Comunicazione";

  @override
  _ComunicazionePageState createState() => _ComunicazionePageState();
}

class _ComunicazionePageState extends State<ComunicazionePage> {
  late ComunicazionePageArgs? argomenti;
  List<CatalogoModel> articoli_lista = ArticoliRepository().all_3();

  void listaClick(BuildContext context) {
    Navigator.pushNamed(context, CatalogoPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      argomenti = ModalRoute
          .of(context)
          ?.settings
          .arguments as ComunicazionePageArgs;
      print(argomenti?.comunicazioni_lista.toString());
      print(argomenti?.indice.toString());
    }

    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          // leading: IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.menu),
          // ),
          title: Text(widget.pagina_titolo),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomBarWidget(),
        body: GestureDetector(
          onHorizontalDragEnd: (DragEndDetails drag) {
            if(drag.primaryVelocity == null) return;
            if(drag.primaryVelocity! < 0) {
              // drag from right to left
              print("drag from right to left");
              // _scheda_successiva();
            }else{
              // drag from left to right
              print("drag from left to right");
              // _scheda_precedente();
            }
          },
          child: SingleChildScrollView(
              child: Container(
                // si dovrebbe sitemare meglio
                height: MediaQuery.of(context).size.height-(kBottomNavigationBarHeight*2),
                // decoration: MyBoxDecoration().MyBox(),
                child: ComunicazopneWidget(),

              ),
            ),
        ),
      ),
    );
  }

// dati promozione
  Widget ComunicazopneWidget() {
    return Container(
      // height: 500,
      // padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "Comunicazione Comunicazione Comunicazione",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(),

          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Expanded(
              //   child: Container(
              //     padding: EdgeInsets.all(5),
              //     child:
              //   ),
              // ),
              Text(
                "ID",
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 5),
              Text(
                "000000",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 10),
              Text(
                "Data",
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 5),
              Text(
                "00/00/0000",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 5),
            ],
          ),
          SizedBox(height: 5),
          Divider(),

          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 5),
                Expanded(
                  child: Container(
                    decoration: MyBoxDecoration().MyBox(),
                    child: Image.asset("assets/immagini/splash_screen.png"),
                  ),
                ),
                SizedBox(width: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
