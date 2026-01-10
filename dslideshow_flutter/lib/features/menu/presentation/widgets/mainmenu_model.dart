import 'package:flutter/material.dart';
import 'package:dslideshow_flutter/features/theme/presentation/theme.dart';

enum MenuCommand { returnToSlideshow, update, config, powerOff, restartApp }

class Option {
  Icon icon;
  String title;
  String? subtitle;
  MenuCommand command;

  Option({required this.icon, required this.title, this.subtitle, required this.command});
}

final options = [
  Option(
    icon: Icon(Icons.keyboard_backspace, size: ThemeSettings.menuIconSize),
    title: 'Return',
    subtitle: 'Return to slideshow.',
    command: MenuCommand.returnToSlideshow,
  ),
  Option(
    icon: Icon(Icons.system_update, size: ThemeSettings.menuIconSize),
    title: 'OTA Update',
    subtitle: 'OTA Update.',
    command: MenuCommand.update,
  ),
  Option(
    icon: Icon(Icons.settings, size: ThemeSettings.menuIconSize),
    title: 'Сonfig',
    subtitle: 'Сonfig.',
    command: MenuCommand.config,
  ),
  Option(
    icon: Icon(Icons.reset_tv, size: ThemeSettings.menuIconSize),
    title: 'Restart application',
    subtitle: 'Restart application.',
    command: MenuCommand.restartApp,
  ),
  Option(
    icon: Icon(Icons.power_settings_new, size: ThemeSettings.menuIconSize),
    title: 'Power off',
    subtitle: 'Shut down system.',
    command: MenuCommand.powerOff,
  ),
];
