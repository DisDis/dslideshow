
import 'package:dslideshow_flutter/features/menu/presentation/bloc/main_menu_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'mainmenu_model.dart';

class MainMenuWidget extends StatelessWidget {
  const MainMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(125, 133, 133, 133),
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: BlocBuilder<MainMenuBloc, MainMenuState>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: options.length + 2,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return const SizedBox(height: 15.0);
                } else if (index == options.length + 1) {
                  return const SizedBox(height: 100.0);
                }
                return Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(10.0),
                  width: double.infinity,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: state.selectedIndex == index - 1 ? Border.all(color: Colors.blue) : Border.all(color: Colors.black26),
                  ),
                  child: ListTile(
                    leading: options[index - 1].icon,
                    title: Text(
                      options[index - 1].title,
                      style: TextStyle(
                        color: state.selectedIndex == index - 1 ? Colors.black : Colors.grey[600],
                      ),
                    ),
                    subtitle: Text(
                      options[index - 1].subtitle!,
                      style: TextStyle(
                        color: state.selectedIndex == index - 1 ? Colors.black : Colors.grey,
                      ),
                    ),
                    selected: state.selectedIndex == index - 1,
                    onTap: () {
                      final bloc = BlocProvider.of<MainMenuBloc>(context);
                      bloc.add(MainMenuEvent.execute(options[index - 1].command));
                    },
                  ),
                );
              },
            );
          },
        ));
  }
}
