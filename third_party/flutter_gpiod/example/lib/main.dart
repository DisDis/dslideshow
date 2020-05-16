import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_gpiod/flutter_gpiod.dart';


void main() => runApp(FlutterGpiodTestApp());

class FlutterGpiodTestApp extends StatefulWidget {
  @override
  _FlutterGpiodTestAppState createState() => _FlutterGpiodTestAppState();
}

class _FlutterGpiodTestAppState extends State<FlutterGpiodTestApp> {
  Future<void> _testFlutterGpiod() async {
    final gpio = await FlutterGpiod.getInstance();

    /// Retrieve the list of GPIO chips.
    final chips = gpio.chips;

    /// Print out all GPIO chips and all lines
    /// for all GPIO chips.
    for (var chip in chips) {
      print("$chip");

      var index = 0;
      for (var line in chip.lines) {
        print("$index:  ${await line.info}");
        index++;
      }
    }


//    await _led(chips);
//    await _button(chips);
      await _pirTest(chips);


  }

  Future _pirTest(List<GpioChip> chips) async {
    final lineLED =
    chips.singleWhere((chip) => chip.label == 'pinctrl-bcm2835').lines[14];
    final linePIR =
    chips.singleWhere((chip) => chip.label == 'pinctrl-bcm2835').lines[17];

    /// Request BCM 14 as output.
    await lineLED.requestOutput(
        consumer: "flutter_gpiod test", initialValue: true);

    for (var i = 0; i<2 ;i++) {
      /// Pulse the line.
      /// Set it to inactive. (so low voltage = GND)
      await lineLED.setValue(false);
      await Future.delayed(Duration(milliseconds: 500));
      await lineLED.setValue(true);
      await Future.delayed(Duration(milliseconds: 500));
    }
    await lineLED.setValue(false);

    await linePIR.requestInput(
        consumer: "flutter_gpiod input test",
        //        activeState: ActiveState.low,
        triggers: {SignalEdge.falling, SignalEdge.rising});

    /// Log line events for eternity.
    await for (final SignalEvent event in linePIR.onEvent) {
      print("flutter_gpiod line event: $event");
      await lineLED.setValue(event.edge == SignalEdge.falling);
    }

    await lineLED.release();
    await linePIR.release();
  }


  Future _led(List<GpioChip> chips) async {
      /// Retrieve the line with index 23 of the first chip.
    /// This is BCM pin 23 for the Raspberry Pi.
    ///
    /// I recommend finding the chip you want
    /// based on the chip label, as is done here.
    ///
    /// In this example, we search for the main Raspberry Pi GPIO chip,
    /// which has the label `pinctrl-bcm2835`, and then retrieve the line
    /// with index 14 of it. So [line] is GPIO pin BCM 14.
    final line14 =
        chips.singleWhere((chip) => chip.label == 'pinctrl-bcm2835').lines[14];
    
    /// Request BCM 14 as output.
    await line14.requestOutput(
        consumer: "flutter_gpiod test", initialValue: true);
    
    for (var i = 0; i<5 ;i++) {
      /// Pulse the line.
      /// Set it to inactive. (so low voltage = GND)
      await line14.setValue(false);
      await Future.delayed(Duration(milliseconds: 500));
      await line14.setValue(true);
      await Future.delayed(Duration(milliseconds: 500));
    }
    await line14.release();
  }

  Future _button(List<GpioChip> chips) async {
    final line15 =
    chips.singleWhere((chip) => chip.label == 'pinctrl-bcm2835').lines[15];
    
    await line15.requestInput(
        consumer: "flutter_gpiod input test",
    //        activeState: ActiveState.low,
        triggers: {SignalEdge.falling, SignalEdge.rising});
    
    /// Log line events for eternity.
    await for (final event in line15.onEvent) {
      print("flutter_gpiod line event: $event");
    }
    
    /// Release the line, though we'll never reach this point.
    await line15.release();
  }

  @override
  void initState() {
    super.initState();
    _testFlutterGpiod();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('flutter_gpiod Test App'),
          ),
          body: Container()),
    );
  }
}
