// Copyright (c) 2016, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:system_metrics_widget/src/model/system_info/cpu_info.dart';
import 'package:system_metrics_widget/src/model/system_info/network_info.dart';
import 'package:system_metrics_widget/src/model/system_info/os_info.dart';
import 'package:system_metrics_widget/src/model/system_info/os_type.dart';
import 'package:system_metrics_widget/src/model/system_info/sensor_info.dart';
import 'package:system_metrics_widget/src/model/system_info/system_info.dart';
import 'package:system_metrics_widget/src/model/system_info/update_info.dart';

part 'serializers.g.dart';

/// Collection of generated serializers for the built_value chat example.
@SerializersFor([
  CpuInfo,
  NetworkInfo,
  OSInfo,
  SystemInfo,
  UpdateInfo,
])
final Serializers serializers = _$serializers;
