import 'package:flutter/material.dart';

final slideShowLoaderWidget = Container(
  key: const Key('loader'),
  child: const Center(
    child: SizedBox(
      width: 60,
      height: 60,
      child: CircularProgressIndicator(),
    ),
  ),
);
