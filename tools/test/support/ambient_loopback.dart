import 'package:http/http.dart' as net;

class AmbientLoopbackClient extends net.BaseClient {
  AmbientLoopbackClient(this.port);
  final int port;
  final _client = net.Client();

  @override
  Future<net.StreamedResponse> send(net.BaseRequest request) async {
    final forwarded =
        net.AbortableRequest(
            request.method,
            Uri(
              scheme: 'http',
              host: '127.0.0.1',
              port: port,
              path: request.url.path,
              query: request.url.hasQuery ? request.url.query : null,
            ),
            abortTrigger: request is net.AbortableRequest ? request.abortTrigger : null,
          )
          ..followRedirects = false
          ..headers.addAll(request.headers)
          ..bodyBytes = await request.finalize().toBytes();
    return _client.send(forwarded);
  }

  @override
  void close() => _client.close();
}
