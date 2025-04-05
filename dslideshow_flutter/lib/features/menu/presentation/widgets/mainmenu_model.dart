import 'package:flutter/material.dart';

enum MenuCommand { returnToSlideshow, update, config, powerOff }

class Option {
  Icon icon;
  String title;
  String? subtitle;
  MenuCommand command;

  Option({required this.icon, required this.title, this.subtitle, required this.command});
}

final options = [
  Option(
    icon: const Icon(Icons.keyboard_backspace, size: 40.0),
    title: 'Return',
    subtitle: 'Return to slideshow.',
    command: MenuCommand.returnToSlideshow,
  ),
  Option(
    icon: const Icon(Icons.system_update, size: 40.0),
    title: 'Update',
    subtitle: 'Update.',
    command: MenuCommand.update,
  ),
  Option(
    icon: const Icon(Icons.settings, size: 40.0),
    title: 'Сonfig',
    subtitle: 'Сonfig.',
    command: MenuCommand.config,
  ),
  Option(
    icon: const Icon(Icons.power_settings_new, size: 40.0),
    title: 'Power off',
    subtitle: 'Shut down system.',
    command: MenuCommand.powerOff,
  ),
];
