import 'package:flutter/material.dart';
import 'package:fraschetti_videocatalogo/components/BottomBarWidget.dart';
import 'package:fraschetti_videocatalogo/repositories/articoliRepository.dart';
import 'package:fraschetti_videocatalogo/models/catalogoModel.dart';
import 'package:fraschetti_videocatalogo/screen/catalogo/CatalogoPage.dart';
import 'package:fraschetti_videocatalogo/screen/utils/UtilsDev.dart';

class PromozionePageArgs {
  List<Map>? promozioni_lista;
  int indice;

  PromozionePageArgs({
    this.promozioni_lista = null,
    this.indice = 0,
  });
}

class PromozionePage extends StatefulWidget {
  PromozionePage({Key? key}) : super(key: key);
  static const String routeName = 'promozione_page';
  final String pagina_titolo = "Promozione";

  @override
  _PromozionePageState createState() => _PromozionePageState();
}

class _PromozionePageState extends State<PromozionePage> {
  late PromozionePageArgs? argomenti;
  List<CatalogoModel> articoli_lista = ArticoliRepository().all_3();

  void listaClick(BuildContext context) {
    Navigator.pushNamed(context, CatalogoPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      argomenti = ModalRoute.of(context)?.settings.arguments as PromozionePageArgs;
    print(argomenti?.promozioni_lista.toString());
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
          onHorizontalDragUpdate: (details) {
            // Note: Sensitivity is integer used when you don't want to mess up vertical drag
            int sensitivity = 8;
            if (details.delta.dx > sensitivity) {
              // Right Swipe
              print("Right Swipe");
            } else if (details.delta.dx < -sensitivity) {
              //Left Swipe
              print("Left Swipe");
            }
          },
          child: SingleChildScrollView(
            child: Container(
              // si dovrebbe sitemare meglio
              height: MediaQuery.of(context).size.height -
                  (kBottomNavigationBarHeight * 2),
              // decoration: MyBoxDecoration().MyBox(),
              child: Column(
                children: <Widget>[
                  PromozioneWidget(),
                  SizedBox(height: 5),
                  Divider(
                    height: 5,
                    thickness: 2,
                    // color: Theme.of(context).primaryColor,
                  ),
                  ListaWidget(articoli_lista),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// dati promozione
  Widget PromozioneWidget() {
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
                    "Promozione Promozione Promozione",
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 5),
              Expanded(
                child: Container(
                  height: 500,
                  // width: 400,
                  decoration: BoxDecoration(
                    border: MyBorder().MyBorderOrange(),
                    image: DecorationImage(
                      image: AssetImage("assets/immagini/splash_screen.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5),
            ],
          ),
        ],
      ),
    );
  }

// riga lista articoli
  Widget ListaWidget(List<CatalogoModel> articoli_lista) {
    return Flexible(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          height: 5,
          thickness: 2,
          color: Theme.of(context).primaryColor,
        ),
        itemCount: articoli_lista.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              listaClick(context);
            },
            child: Container(
              height: 40,
              // decoration: MyBoxDecoration().MyBox(),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 10,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      // "${articoli_lista[index].nome}"
                    ),
                  ),
                  Container(
                    width: 40,
                    decoration: BoxDecoration(
                      border: MyBorder().MyBorderOrange(),
                      image: DecorationImage(
                        image: AssetImage("assets/immagini/splash_screen.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment(-1.0, 0.0),
                      padding: EdgeInsets.all(5.0),
                      decoration: MyBoxDecoration().MyBox(),
                      child: Text(
                        "${articoli_lista[index].nome}",
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 15.0,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: MyBorder().MyBorderOrange(),
                      image: DecorationImage(
                        image: AssetImage("assets/immagini/splash_screen.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: MyBorder().MyBorderOrange(),
                      image: DecorationImage(
                        image: AssetImage("assets/immagini/splash_screen.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
