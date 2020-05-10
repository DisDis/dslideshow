import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/config.dart';


import "package:http/http.dart" as http;
import "package:googleapis_auth/auth_io.dart";
import "package:googleapis/photoslibrary/v1.dart";
import 'package:logging/logging.dart';
import 'package:googleapis_auth/src/auth_http_utils.dart';

//final clientId = new ClientId('identifier','secret');
//final String tokenRefresh = 'tokenRefresh';
//String tokenAccess = 'token';
//DateTime tokenAExpire = DateTime.parse('2019-05-10 00:52:15.086528Z');
import 'client_test_access.dart';


class GooglePhotoService{
  static final Logger _log = new Logger('GooglePhotoService');
  GooglePhotoService(AppConfig config);
  var scopes = ["https://www.googleapis.com/auth/photoslibrary.readonly"];
  var redirectUri = 'http://localhost:8989/googleapi';
  var tokenAType = 'Bearer';

  void prompt(String url) {
    print("Please go to the following URL and grant access:");
    print("  => $url");
    print("");
  }

  String _authenticationUri(String redirectUri, {String state = 'state'}) {
    // TODO: Increase scopes with [include_granted_scopes].
    var queryValues = [
      'response_type=code',
      'access_type=offline',
      'client_id=${Uri.encodeQueryComponent(clientId.identifier)}',
      'redirect_uri=${Uri.encodeQueryComponent(redirectUri)}',
      'scope=${Uri.encodeQueryComponent(scopes.join(' '))}',
      'prompt=consent'
    ];
    if (state != null) {
      queryValues.add('state=${Uri.encodeQueryComponent(state)}');
    }
    return Uri.parse('https://accounts.google.com/o/oauth2/auth'
        '?${queryValues.join('&')}')
        .toString();
  }


  Future _run(Completer<String> codeCompleter) async {
    HttpServer server = await HttpServer.bind('localhost', 8989);

    try {
//      var port = server.port;
//      var redirectionUri = 'http://localhost:$port';
//      var state = 'authcodestate${new DateTime.now().millisecondsSinceEpoch}';

//      // Prompt user and wait until he goes to URL and the google authorization
//      // server calls back to our locally running HTTP server.
//      userPrompt(_authenticationUri(redirectionUri, state: state));

      var request = await server.first;
      var uri = request.uri;

      try {
//        var returnedState = uri.queryParameters['state'];
        var code = uri.queryParameters['code'];
        var error = uri.queryParameters['error'];

        if (request.method != 'GET') {
          throw new Exception('Invalid response from server '
              '(expected GET request callback, got: ${request.method}).');
        }

        // TODO: implement it
//        if (state != returnedState) {
//          throw new Exception(
//              'Invalid response from server (state did not match).');
//        }

        if (error != null) {
          throw new UserConsentException(
              'Error occured while obtaining access credentials: $error');
        }

        if (code == null || code == '') {
          throw new Exception(
              'Invalid response from server (no auth code transmitted).');
        }

        codeCompleter.complete(code);

        // TODO: We could introduce a user-defined redirect page.
        request.response
          ..statusCode = 200
          ..headers.set('content-type', 'text/html; charset=UTF-8')
          ..write('''
<!DOCTYPE html>

<html>
  <head>
    <meta charset="utf-8">
    <title>Authorization successful.</title>
  </head>

  <body>
    <h2 style="text-align: center">Application has successfully obtained access credentials</h2>
    <p style="text-align: center">This window can be closed now.</p>
  </body>
</html>''');
        await request.response.close();
      } catch (e) {
        request.response.statusCode = 500;
        await request.response.close().catchError((dynamic _) {});
        rethrow;
      }
    } finally {
      await server.close();
    }
  }


  void run() async{
    //
    var client = new http.Client();
    try {
      AccessCredentials credentials;
      if (tokenRefresh == null) {
        var uri = _authenticationUri(redirectUri);
        _log.info("Uri: $uri");
        var codeCompleter = new Completer<String>();
        _run(codeCompleter);
        var code = await codeCompleter.future;
        credentials = await obtainAccessCredentialsViaCodeExchange(
            client, clientId, code, redirectUrl: redirectUri);
      } else {
        var at = new AccessToken(tokenAType, tokenAccess, tokenAExpire);
        credentials = new AccessCredentials(at, tokenRefresh, scopes);
      }
//      var credentials = await obtainAccessCredentialsViaUserConsent(clientId, scopes, client, prompt);
//      var credentials = await obtainAccessCredentialsUsingCode(clientId, code, redirectUri, client, scopes);
//      var client = await clientViaUserConsent(clientId, scopes, prompt);
      _log.info('Cred id:${credentials.idToken} at:${credentials.accessToken} rt:${credentials.refreshToken}');
//      client = new AuthenticatedClient(client, credentials);
      var clientARC = new AutoRefreshingClient(client, clientId, credentials);

      var gphoto = new PhotoslibraryApi(clientARC);
      var albumsRes = await gphoto.albums.list();
      var slideShowAlbum = albumsRes.albums.firstWhere((item)=>item.title == "SlideShow",orElse: ()=> null);
      if (slideShowAlbum != null){
        var mediaItems = await gphoto.mediaItems.search(new SearchMediaItemsRequest()..albumId=slideShowAlbum.id);
        mediaItems.mediaItems.forEach((item){
          _log.info( "Item: id='${item.id}', baseUrl=' ${item.baseUrl}=w1920-h1080 '");
        });

      } else {
        _log.severe("Not found 'SlideShow' album");
      }
      credentials = clientARC.credentials;
      _log.info('Cred id:${credentials.idToken} at:${credentials.accessToken} rt:${credentials.refreshToken}');
      client.close();
    } catch(err){
    _log.severe("Unable to create Google photo service: $err");
    }
  }

}