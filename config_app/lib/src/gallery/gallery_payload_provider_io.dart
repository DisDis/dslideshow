import 'dart:io';

import 'package:flutter/painting.dart';

ImageProvider fileProvider(String path) => FileImage(File(path));
