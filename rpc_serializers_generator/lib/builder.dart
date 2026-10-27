import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/rpc_serializers_generator.dart';

Builder rpcSerializersBuilder(BuilderOptions options) =>
    SharedPartBuilder([RpcSerializersGenerator()], 'rpc_serializers');
