import 'package:flutter/material.dart';

class Option {
  Icon? icon;
  String? title;
  String? subtitle;

  Option({this.icon, this.title, this.subtitle});
}

final options = [
  Option(
    icon: const Icon(Icons.keyboard_backspace, size: 40.0),
    title: 'Return',
    subtitle: 'Return to slideshow.',
  ),
  Option(
    icon: const Icon(Icons.do_not_disturb, size: 40.0),
    title: 'Option Two',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
  ),
  Option(
    icon: const Icon(Icons.account_circle, size: 40.0),
    title: 'Option Three',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
  ),
  Option(
    icon: const Icon(Icons.invert_colors, size: 40.0),
    title: 'Option Four',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
  ),
  Option(
    icon: const Icon(Icons.watch_later, size: 40.0),
    title: 'Option Five',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
  ),
  Option(
    icon: const Icon(Icons.fastfood, size: 40.0),
    title: 'Option Six',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
  ),
  Option(
    icon: const Icon(Icons.local_airport, size: 40.0),
    title: 'Option Seven',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
  ),
  Option(
    icon: const Icon(Icons.settings, size: 40.0),
    title: 'Option Eight',
    subtitle: 'Lorem ipsum dolor sit amet, consect.',
  ),
];
