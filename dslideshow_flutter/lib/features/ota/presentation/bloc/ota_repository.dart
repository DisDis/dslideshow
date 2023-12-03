import 'dart:async';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';

class OtaRepository {
  final FrontendService frontendService;
  OtaRepository({required this.frontendService});

  Stream<OTAInfo> get onOTAInfo => frontendService.onOTAInfo;
}
