import 'package:logging/logging.dart';

final _log = Logger('web');

void initEnvironment() {
  _log.info('initEnvironment - Web');
}

void configHttpAdapter(obj) {
  _log.info('configHttpAdapter :$obj');
}
