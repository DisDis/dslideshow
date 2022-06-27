import 'package:config_app/src/bloc/authentication_bloc.dart';
import 'package:config_app/src/page/home/bloc/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WebConfigTab extends StatelessWidget {
  const WebConfigTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text('web'),
        // ElevatedButton(
        //   child: const Text('Echo'),
        //   onPressed: () async {
        //     final result = await context.read<HomeCubit>().echo();
        //     print('Result: $result');
        //   },
        // ),
        // ElevatedButton(
        //   child: const Text('Echo - error'),
        //   onPressed: () async {
        //     try {
        //       final result = await context.read<HomeCubit>().echoError();
        //       print('Result: $result');
        //     } catch (e) {
        //       print('Error: $e');
        //     }
        //   },
        // ),
      ]),
    );
  }
}
