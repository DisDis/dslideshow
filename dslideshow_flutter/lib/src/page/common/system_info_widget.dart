import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SystemInfoWidget extends StatefulWidget {
  SystemInfoWidget({Key key}) : super(key: key);

  @override
  _SystemInfoWidgetState createState() => _SystemInfoWidgetState();
}

class _SystemInfoWidgetState extends State<SystemInfoWidget> {
  String cpuModel = "Raspberry Pi 4 Model B Rev 1.1";
  String cpuHardware = "BCM2835";
  String cpuRevision	= "c03111";
  String cpuLoad = '30%';
  int cpuCores = 4;
  int memTotal = 3817056;
  int memUsed = 385624;
  int swapTotal = 102396;
  int swapUsed = 0;
  String diskUsedPercent = '35%';
  String diskUsed = '4.8G';
  String diskAvail = '9.0G';
  String kernelVersion = "Linux raspberrypi 4.19.97-v7l+ #1294 SMP Thu Jan 30 13:21:14 GMT 2020 armv7l GNU/Linux";
  String uptime = printDuration( new Duration(days: 1, hours: 13, minutes: 46, seconds: 30));
  String sensorTemp = '62.0\'C';
  final TextStyle _style = TextStyle(
      color: Colors.black,
      fontSize: 5.0 );

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Color.fromARGB(150, 133, 133, 133),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '-----=== Hardware ===-----',
            style: _style,
          ),
          Text(
            'CPU: $cpuModel($cpuHardware rev $cpuRevision)',
            style: _style,
          ),
          Text(
            'Core(s): $cpuCores',
            style: _style,
          ),
          Text(
            'Mem: $memTotal/$memUsed(${(memUsed*100/memTotal).truncate()}%)  $swapTotal/$swapUsed(${(swapUsed*100/swapTotal).truncate()}%)',
            style: _style,
          ),
          Text(
            'Disk used: $diskUsed($diskUsedPercent), free: $diskAvail',
            style: _style,
          ),
          Text(
            '-----=== System ===-----',
            style: _style,
          ),
          Text(
            'kernel: $kernelVersion',
            style: _style,
          ),
          Text(
            'uptime: ${uptime}',
            style: _style,
          ),
          Text(
            'cpu load: ${cpuLoad}%',
            style: _style,
          ),
          Text(
            '-----=== Sensors ===-----',
            style: _style,
          ),
          Text(
            'Temp: $sensorTemp',
            style: _style,
          ),
        ],
      )

    )
    );
  }
}