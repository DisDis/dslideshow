import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/buttons_hint.dart';
import 'package:dslideshow_flutter/features/menu/presentation/bloc/main_menu_bloc.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'mainmenu_model.dart';
import 'package:dslideshow_flutter/features/theme/presentation/theme.dart';

class MainMenuWidget extends StatelessWidget {
  const MainMenuWidget({super.key});


  @override
  Widget build(BuildContext context) {
    final AppConfig appConfig = injector();
    
    // Координаты для подсказок (под физическими кнопками)
    final double hintLeft = appConfig.slideshow.buttons.hintOffsetX.toDouble();
    final double hintTop = appConfig.slideshow.buttons.hintOffsetY.toDouble();

    return Stack(
      children: [
        // 1. ПОДСКАЗКИ (Привязаны к кнопкам)
        Positioned(
          left: hintLeft,
          top: hintTop,
          child: ButtonsHintWidget(buttons: appConfig.slideshow.buttons),
        ),

        // 2. МЕНЮ (По центру экрана)
        Center(
          child: Container(
            width: ThemeSettings.menuSizeW,
            height: ThemeSettings.menuSizeH, // Фиксированная высота или можно использовать Constraints
            decoration: BoxDecoration(
              color: ThemeColors.menuBgColor,
              border: Border.all(color: ThemeColors.menuBorderColor.withOpacity(0.5), width: 1),
              // Убираем скругление для производительности и стиля "Терминал"
              boxShadow: [
                 BoxShadow(color: ThemeColors.menuShadowColor, blurRadius: 20, spreadRadius: 5)
              ]
            ),
            child: Column(
              children: [
                // Шапка меню
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: ThemeColors.menuBorderColor.withOpacity(0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "MENU",
                        style: TextStyle(
                          color: ThemeColors.menuBorderColor,
                          fontSize: ThemeSettings.menuHeaderTitleSize,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                      // Декоративные элементы
                      Row(
                        children: [
                          Container(width: 8, height: 8, color: ThemeColors.menuBorderColor.withOpacity(0.5)),
                          const SizedBox(width: 4),
                          Container(width: 8, height: 8, color: ThemeColors.menuBorderColor),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(height: 1, color: ThemeColors.menuBorderColor),

                // Список
                Expanded(
                  child: BlocBuilder<MainMenuBloc, MainMenuState>(
                    builder: (context, state) {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          final item = options[index];
                          final isSelected = state.selectedIndex == index;
                          return _buildMenuItem(context, item, isSelected);
                        },
                      );
                    },
                  ),
                ),
                
                // Футер (подсказка навигации)
                Container(
                   padding: const EdgeInsets.all(8),
                   child: const Text(
                     "Use physical buttons to navigate",
                     style: TextStyle(color: ThemeColors.menuSubTextColor, fontSize: ThemeSettings.menuHintTextSize),
                   ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, Option item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      color: isSelected ? ThemeColors.menuActiveBgColor : Colors.transparent,
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        // Иконка
        leading: Icon(
          item.icon.icon,
          color: isSelected ? ThemeColors.menuTextColor : ThemeColors.menuInactiveIconColor,
          size: ThemeSettings.menuItemIconSize,
        ),
        // Текст
        title: Text(
          item.title.toUpperCase(),
          style: TextStyle(
            color: isSelected ? ThemeColors.menuTextColor : ThemeColors.menuInactiveTextColor,
            fontWeight: isSelected ? FontWeight.w900 : FontWeight.normal,
            fontSize: ThemeSettings.menuListItemTextSize,
            letterSpacing: 1.2,
          ),
        ),
        // Правая часть (стрелка)
        trailing: isSelected 
          ? Icon(Icons.arrow_left, color: ThemeColors.menuBorderColor)
          : null,
        onTap: () {
          context.read<MainMenuBloc>().add(MainMenuEvent.execute(item.command));
        },
      ),
    );
  }
}