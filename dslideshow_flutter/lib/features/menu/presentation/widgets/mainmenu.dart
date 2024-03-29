import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'mainmenu_model.dart';

class MainMenuWidget extends StatefulWidget {
  const MainMenuWidget({super.key});

  @override
  MenuOptionsScreenState createState() => MenuOptionsScreenState();
}

class MenuOptionsScreenState extends State<MainMenuWidget> {
  int _selectedOption = 0;
  static final Random _rnd = Random();
  late Timer _demoTimer;

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
        child: ListView.builder(
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
                border: _selectedOption == index - 1 ? Border.all(color: Colors.blue) : Border.all(color: Colors.black26),
              ),
              child: ListTile(
                leading: options[index - 1].icon,
                title: Text(
                  options[index - 1].title!,
                  style: TextStyle(
                    color: _selectedOption == index - 1 ? Colors.black : Colors.grey[600],
                  ),
                ),
                subtitle: Text(
                  options[index - 1].subtitle!,
                  style: TextStyle(
                    color: _selectedOption == index - 1 ? Colors.black : Colors.grey,
                  ),
                ),
                selected: _selectedOption == index - 1,
                onTap: () {
                  setState(() {
                    _selectedOption = index - 1;
                  });
                },
              ),
            );
          },
        ));
  }

  @override
  void initState() {
    super.initState();
    _demoTimer = Timer.periodic(const Duration(seconds: 3), _changeSelect);
  }

  @override
  void dispose() {
    _demoTimer.cancel();
    super.dispose();
  }

  void _changeSelect(Timer _) {
    if (mounted) {
      setState(() {
        _selectedOption = _rnd.nextInt(options.length - 1);
      });
    }
  }
}
