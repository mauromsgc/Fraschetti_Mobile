import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

// import 'package:focus_login_sessioni_utente/repositories/SessionRepository.dart';
// import 'package:focus_login_sessioni_utente/repositories/UserRepository.dart';

const String HTTP_HOST = "http://192.168.1.78:8080";

// Questa è una delle classi più importanti di tutta l'applicazione.
//
// In generale il HttpRepository è la classe di riferimento per fare chiamate HTTP verso l'esterno, ed implementa
// l'omonimo "Repository" pattern.
//
// Il vantaggio dell'avere questa classe "base", attraverso cui passano tutte le richieste HTTP verso l'esterno è
// che centralizza in un singolo file tutte le configurazioni e formattazioni fatte per una chiamata prima che vada verso l'esterno.
//
class HttpRepository {
  HttpClient? http;

  // SessionRepository session;
  // UserRepository user;

  HttpRepository() {
    http = HttpClient(this);

    // session = SessionRepository(this);
    // user = UserRepository(this);
  }
}

// Questa classe rappresenta l'HTTP client ed è quello attraverso cui passano tutte le richieste.
// Il HttpRepository istanzia ed ha un riferimento a questa classe valido per tutta la durata di esecuzione dell'app (se chiudi e riapri l'app, si ricreano sia HttpRepository che HttpClient ovviamente).
// A sua volta, HttpClient ha un riferimento all'istanza del HttpRepository, cosiche possa accedere alla sessione attiva, e da li recuperare il token JWT.
class HttpClient {
  final HttpRepository http_repository;
  http.Client? client;

  HttpClient(this.http_repository) {
    client = http.Client();
  }

  Future<Map<String, dynamic>> test(String email, String password) async {
    var url = Uri.parse('https://office.centridiventa.com/api/utenti/login');
    var response =
        await http.post(url, body: {'username': email, 'password': password});

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      return data["data"];
    }

    throw RequestError(data["error"]);
  }


  Future<Map<String, dynamic>> trasmissione_test() async {
    // effettua un test di trasmissione

    final String _api = "/4daction/Post_mv1_ConnessioneTest";
    var url = Uri.parse(HTTP_HOST + _api);

    Map _body_data = {
      "data": "test",
    };

    var response = await http.post(url, body: _body_data);

    print(response.body);
    print(response.statusCode);

    final data = json.decode(response.body);
    print(data);

    if (response.statusCode == 200) {
      return data;
    }

    throw RequestError(data["error"]);
  }



  Future<Map<String, dynamic>> trasmissione_test_2() async {
    // effettua un test di trasmissione

    final String _api = "/4daction/Post_mv1_ConnessioneTest";
    var url = Uri.parse(HTTP_HOST + _api);

    Map _body_data = {
      "data": "test",
    };

    var response = await http.post(url, body: _body_data);

    print(response.body);
    print(response.statusCode);

    final data = json.decode(response.body);
    print(data);

    if (response.statusCode == 200) {
      return data;
    }

    throw RequestError(data["error"]);
  }


  void mac_address_leggi() {
    // legge i mac address
    // DA VERIFICARE SE POSSIBILE SU MOBILE
  }

  void intestazione_trasmissione() {
    // prepara la prima parte dei dati da trasmettre
    // versioni protoccolli e videocatalogo,
    // dati utente e dati installazione
    // altri dati comuni
  }

  void aggiornamenti_verifica() {
    // verifica se ci sono aggiornamenti da scaricare
  }

  Future<Map<String, dynamic>> utente_registra ({required Map<String, dynamic> data_invio}) async {
    // effettua la registrazione del videocatalogo

    final String _api = "/4daction/Post_mv1_Registrazione";
    var url = Uri.parse(HTTP_HOST + _api);

    Map _body_data = {};
    _body_data["data"] = data_invio;

    final t1 = json.encode(_body_data);

    var response = await http.post(url, body: t1);

    print(response.body);
    print(response.statusCode);

    final data_risposta = json.decode(response.body);
    print(data_risposta);

    if (response.statusCode == 200) {
      return data_risposta["data"];
    }

    throw RequestError(data_risposta["error"]);

  }

  void videocatalogo_disinstalla() {
    // disinstalla il videocatalogo
  }

  void aggiornamenti_scarica() {
    // scarica gli aggiornamenti
    // da idvidere in base al tipo di dati da scaricare
  }

  void anagrafica_aggiorna() {
    // aggiorna l'anagrafica agente e cliente
  }

  void ordini_trasmetti() {
    // trasmette gli ordini
  }
}

class RequestError implements Exception {
  final String error;

  RequestError(this.error);
}
