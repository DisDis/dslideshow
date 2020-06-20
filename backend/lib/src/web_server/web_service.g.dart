// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_service.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$WebServiceRouter(WebService service) {
  final router = Router();
  router.add('GET', r'/users/', service.listUsers);
  router.add('GET', r'/users/<userId>', service.fetchUser);
  router.add('GET', r'/echo', service._echoRequest);
  return router;
}
