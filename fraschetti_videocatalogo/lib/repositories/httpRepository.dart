import 'dart:convert';
import 'dart:io';

import 'package:fraschetti_videocatalogo/models/parametriModel.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

// import 'package:focus_login_sessioni_utente/repositories/SessionRepository.dart';
// import 'package:focus_login_sessioni_utente/repositories/UserRepository.dart';

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

  Future<Map<String, dynamic>> connessione_test(
      {String p_host_server = ""}) async {
    // effettua un test di trasmissione

    String host_server = GetIt.instance<ParametriModel>().host_server;
    if (p_host_server != "") {
      host_server = p_host_server;
    }

    final String _api = "/4daction/Post_mv1_ConnessioneTest";
    var url = Uri.parse(host_server + _api);

    var data_risposta;
    try {
        Map<String, dynamic> data_invio = {};
      data_invio["data"] = "Post.Test";
      data_invio["parametri"] =
          GetIt.instance<ParametriModel>().toMap().toString();

      // trasformando in json mi arrivano i dati nel body
      final _oggetto_invio = json.encode(data_invio);
      var response = await http.post(url, body: _oggetto_invio);

      try {
        data_risposta = json.decode(response.body);

      } catch (e){
        // leggo i dati come un base64 che contine un testo zippato
        try {
          final decoded_data = GZipCodec().decode(base64.decode(response.body));
          final string_data = utf8.decode(decoded_data, allowMalformed: true);
          data_risposta = json.decode(string_data);
        } catch (e){
          data_risposta = {};
        }

      } finally{

      }

      // print(data_risposta);
      if (response.statusCode == 200) {
        return data_risposta["data"];
      }

    } catch (exception) {
      // print("Errore test di connessione: ${exception}");
      print("Errore test di connessione");
      data_risposta["data"] = "{conessione: KO}";
      return data_risposta["data"];
    } finally {
    }

    throw RequestError(data_risposta["error"]);
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

  Future<Map<String, dynamic>> utente_registra(
      {required Map<String, dynamic> data_invio}) async {
    // effettua la registrazione del videocatalogo
    print("httpRepositoty utente_registra inizio");

    final host_server = GetIt.instance<ParametriModel>().host_server;
    final String _api = "/4daction/Post_mv1_Registrazione";
    var url = Uri.parse(host_server + _api);

    var data_risposta;
    try {
    Map _body_data = {};
    _body_data["data"] = data_invio;

    final _oggetto_invio = json.encode(_body_data);
    var response = await http.post(url, body: _oggetto_invio);

    try {
      data_risposta = json.decode(response.body);

    } catch (e){
      // leggo i dati come un base64 che contine un testo zippato
      try {
        final decoded_data = GZipCodec().decode(base64.decode(response.body));
        final string_data = utf8.decode(decoded_data, allowMalformed: true);
        data_risposta = json.decode(string_data);
      } catch (e){
        data_risposta = {};
      }

    } finally{

    }

    // print(data_risposta);

    print("httpRepositoty utente_registra fine");
    if (response.statusCode == 200) {
      return data_risposta["data"];
    }

    } catch (exception) {
      print("Errore di connessione");
      data_risposta["data"] = "{}";
      return data_risposta["data"];
    } finally {
    }

    throw RequestError(data_risposta["error"]);
  }

  Future<Map<String, dynamic>> sql_aggiorna(
      {required Map<String, dynamic> data_invio}) async {
    // scarica le comunicazioni
    print("httpRepositoty sql_aggiorna inizio");

    final host_server = GetIt.instance<ParametriModel>().host_server;
    final String _api = "/4daction/Post_mv1_Sql";
    var url = Uri.parse(host_server + _api);

    var data_risposta;
    try {
      Map _body_data = {};
    _body_data["data"] = data_invio;

    final _oggetto_invio = json.encode(_body_data);
    var response = await http.post(url, body: _oggetto_invio);

      try {
        data_risposta = json.decode(response.body);

      } catch (e){
        // leggo i dati come un base64 che contine un testo zippato
        try {
          final decoded_data = GZipCodec().decode(base64.decode(response.body));
          final string_data = utf8.decode(decoded_data, allowMalformed: true);
          data_risposta = json.decode(string_data);
        } catch (e){
          data_risposta = {};
        }

      } finally{

      }

      // print(data_risposta);

    print("httpRepositoty sql_aggiorna fine");
    if (response.statusCode == 200) {
      return data_risposta["data"];
    }

    } catch (exception) {
      print("Errore di connessione");
      data_risposta["data"] = "{}";
      return data_risposta["data"];
    } finally {
    }

    throw RequestError(data_risposta["error"]);
  }

  Future<Map<String, dynamic>> dati_aggiorna(
      {required Map<String, dynamic> data_invio}) async {
    // scarica gli aggiornamenti
    print("httpRepositoty dati_aggiorna inizio");

    final host_server = GetIt.instance<ParametriModel>().host_server;
    final String _api = "/4daction/Post_mv1_AggiornaDati";
    var url = Uri.parse(host_server + _api);

    var data_risposta;
    try {
      Map _body_data = {};
    _body_data["data"] = data_invio;

    final _oggetto_invio = json.encode(_body_data);
    var response = await http.post(url, body: _oggetto_invio);

      try {
        data_risposta = json.decode(response.body);

      } catch (e){
        // leggo i dati come un base64 che contine un testo zippato
        try {
          final decoded_data = GZipCodec().decode(base64.decode(response.body));
          final string_data = utf8.decode(decoded_data, allowMalformed: true);
          data_risposta = json.decode(string_data);
        } catch (e){
          data_risposta = {};
        }

      } finally{

      }

      // print(data_risposta);

    print("httpRepositoty dati_aggiorna fine");
    if (response.statusCode == 200) {
      return data_risposta["data"];
    }

    } catch (exception) {
      print("Errore di connessione");
      data_risposta["data"] = "{}";
      return data_risposta["data"];
    } finally {
    }

    throw RequestError(data_risposta["error"]);
  }

  Future<Map<String, dynamic>> comunicazioni_aggiorna(
      {required Map<String, dynamic> data_invio}) async {
    // scarica le comunicazioni
    print("httpRepositoty comunicazioni_aggiorna inizio");

    final host_server = GetIt.instance<ParametriModel>().host_server;
    final String _api = "/4daction/Post_mv1_AggiornaComunicazioni";
    var url = Uri.parse(host_server + _api);

    var data_risposta;
    try {
      Map _body_data = {};
    _body_data["data"] = data_invio;

    final _oggetto_invio = json.encode(_body_data);
    var response = await http.post(url, body: _oggetto_invio);

      try {
        data_risposta = json.decode(response.body);

      } catch (e){
        // leggo i dati come un base64 che contine un testo zippato
        try {
          final decoded_data = GZipCodec().decode(base64.decode(response.body));
          final string_data = utf8.decode(decoded_data, allowMalformed: true);
          data_risposta = json.decode(string_data);
        } catch (e){
          data_risposta = {};
        }

      } finally{

      }

      // print(data_risposta);

    print("httpRepositoty comunicazioni_aggiorna fine");
    if (response.statusCode == 200) {
      return data_risposta["data"];
    }

    } catch (exception) {
      print("Errore di connessione");
      data_risposta["data"] = "{}";
      return data_risposta["data"];
    } finally {
    }

    throw RequestError(data_risposta["error"]);
  }

  Future<Map<String, dynamic>> immagini_aggiorna(
      {required Map<String, dynamic> data_invio}) async {
    // scarica le immagini
    print("httpRepositoty immagini_aggiorna inizio");

    final host_server = GetIt.instance<ParametriModel>().host_server;
    final String _api = "/4daction/Post_mv1_AggiornaImmagini";
    var url = Uri.parse(host_server + _api);

    var data_risposta;
    try {
      Map _body_data = {};
    _body_data["data"] = data_invio;

    final _oggetto_invio = json.encode(_body_data);
    var response = await http.post(url, body: _oggetto_invio);

    try {
      data_risposta = json.decode(response.body);
    } catch (e) {
      // leggo i dati come un base64 che contine un testo zippato
      try {
        final decoded_data = GZipCodec().decode(base64.decode(response.body));
        final string_data = utf8.decode(decoded_data, allowMalformed: true);
        data_risposta = json.decode(string_data);
      } catch (e) {
        data_risposta = {};
      }
    } finally {

    }

    // print(data_risposta);

    print("httpRepositoty immagini_aggiorna fine");
    if (response.statusCode == 200) {
      return data_risposta["data"];
    }

    } catch (exception) {
      print("Errore di connessione");
      data_risposta["data"] = "{}";
      return data_risposta["data"];
    } finally {
    }

    throw RequestError(data_risposta["error"]);
  }

  Future<Map<String, dynamic>> aggiornamenti_controlla(
      {required Map<String, dynamic> data_invio}) async {
    // controlla se ci sono aggiornamenti da scaricare
    print("httpRepositoty aggiornamenti_controlla inizio");

    final host_server = GetIt.instance<ParametriModel>().host_server;
    final String _api = "/4daction/Post_mv1_AggiornamentiControlla";
    var url = Uri.parse(host_server + _api);

    var data_risposta;
    try {
      Map _body_data = {};
    _body_data["data"] = data_invio;

    final _oggetto_invio = json.encode(_body_data);
    var response = await http.post(url, body: _oggetto_invio);

      try {
        data_risposta = json.decode(response.body);
      } catch (e) {
        // leggo i dati come un base64 che contine un testo zippato
        try {
          final decoded_data = GZipCodec().decode(base64.decode(response.body));
          final string_data = utf8.decode(decoded_data, allowMalformed: true);
          data_risposta = json.decode(string_data);
        } catch (e) {
          data_risposta = {};
        }
      } finally {}

      // print(data_risposta);

      print("httpRepositoty immagini_aggiorna fine");
      if (response.statusCode == 200) {
        return data_risposta["data"];
      }

    } catch (exception) {
      print("Errore di connessione");
      data_risposta["data"] = "{}";
      return data_risposta["data"];
    } finally {
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
