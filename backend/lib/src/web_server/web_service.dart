import 'dart:io';
import 'dart:math';

import 'package:dslideshow_backend/src/web_server/web_server_config.dart';
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'web_service.g.dart';

class WebService{
  static final Logger _log = new Logger('WebService');
  final WebServerConfig _config;
  bool _enabled;
  // Create router using the generate function defined in 'userservice.g.dart'.
  Router _router;

  WebService(this._config){
    _router = _$WebServiceRouter(this);
  }

  bool get enabled =>_enabled;
  void set enabled(bool value) {
    if (_enabled == value) {
      _log.info('The web server is already running.');
      return;
    }
    _enabled = value;
    if (_enabled) {
      _startServer();
    } else {
      _stopServer();
    }
  }

  final Random _rnd = new Random();
  HttpServer _server;

  void _startServer() async{
    _log.info('_startServer');
    if (_server != null){
      _log.info('Is the server running?');
      _stopServer();
    }
    _server = await io.serve(_router.handler, '0.0.0.0', _rnd.nextInt(20000)+8000);

    // Enable content compression
    _server.autoCompress = true;

    _log.info('Serving at http://${_server.address.host}:${_server.port}');
  }

  void _stopServer() {
    _log.info('_stopServer');
    if (_server != null) {
      _server.close(force:true);
      _server = null;
    }
  }

  @Route.get('/users/')
  Future<Response> listUsers(Request request) async {
    return Response.ok('["user1"]');
  }

  @Route.get('/users/<userId>')
  Future<Response> fetchUser(Request request, String userId) async {
    if (userId == 'user1') {
      return Response.ok('user1');
    }
    return Response.notFound('no such user');
  }



  @Route.get('/echo')
  shelf.Response _echoRequest(shelf.Request request) {
    return shelf.Response.ok('Request for "${request.url}"');
  }
}