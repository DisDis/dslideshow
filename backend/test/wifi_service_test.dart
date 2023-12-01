import 'package:dslideshow_backend/src/command/wifi_commands.dart';
import 'package:dslideshow_backend/src/service/wifi/wifi_config.dart';
import 'package:dslideshow_backend/src/service/wifi/wifi_service.dart';
import 'package:test/test.dart';

void main() {
  group('WiFiService', () {
    test('parse scanOutput #1', () {
      final testData = """	SSID: Tenda_7BF3B0
	signal: -88.00 dBm
	capability: ESS Privacy ShortSlotTime (0x0411)
	freq: 2437
	SSID: Jazzir_2G
	signal: -67.00 dBm
	capability: ESS Privacy ShortSlotTime RadioMeasure (0x1411)
	freq: 2437
	SSID: Jazzir_5G
	signal: -57.00 dBm
	capability: ESS Privacy SpectrumMgmt RadioMeasure (0x1111)
	freq: 5500""";

      final _config = new WiFiConfig.fromJson(<String, dynamic>{});
      final _wifiService = WiFiService(_config);
      expect(
          _wifiService.parseScanOutput(testData),
          equals(<WiFiNetworkInfo>[
            WiFiNetworkInfo(
              SSID: 'Tenda_7BF3B0',
              signal: -88,
              capability: 'ESS Privacy ShortSlotTime (0x0411)',
              freq: 2437,
            ),
            WiFiNetworkInfo(
              SSID: 'Jazzir_2G',
              signal: -67,
              capability: 'ESS Privacy ShortSlotTime RadioMeasure (0x1411)',
              freq: 2437,
            ),
            WiFiNetworkInfo(
              SSID: 'Jazzir_5G',
              signal: -57,
              capability: 'ESS Privacy SpectrumMgmt RadioMeasure (0x1111)',
              freq: 5500,
            )
          ]));
    });

    test('parse scanOutput #2', () {
      final testData = """	SSID: Jazzir_2G
	signal: -67.00 dBm
	capability: ESS Privacy ShortSlotTime RadioMeasure (0x1411)
	freq: 2437
""";

      final _config = new WiFiConfig.fromJson(<String, dynamic>{});
      final _wifiService = WiFiService(_config);
      expect(
          _wifiService.parseScanOutput(testData),
          equals(<WiFiNetworkInfo>[
            WiFiNetworkInfo(
              SSID: 'Jazzir_2G',
              signal: -67,
              capability: 'ESS Privacy ShortSlotTime RadioMeasure (0x1411)',
              freq: 2437,
            )
          ]));
    });

    test('parse scanOutput #3 - empty', () {
      final testData = """""";

      final _config = new WiFiConfig.fromJson(<String, dynamic>{});
      final _wifiService = WiFiService(_config);
      expect(_wifiService.parseScanOutput(testData), equals(<WiFiNetworkInfo>[]));
    });

    test('parse parseStoredOutput #1 - empty', () {
      final testData = """""";

      final _config = new WiFiConfig.fromJson(<String, dynamic>{});
      final _wifiService = WiFiService(_config);
      expect(_wifiService.parseStoredOutput(testData), equals(<WiFiStoredNetworkInfo>[]));
    });

    test('parse parseStoredOutput #2', () {
      final testData = """Selected interface 'p2p-dev-wlan0'
network id / ssid / bssid / flags
0	Jazzir_5G	any	
1	Jazzir_2G	any	
2	tutu	any	
3		any	[DISABLED]
4		any	[DISABLED]
""";

      final _config = new WiFiConfig.fromJson(<String, dynamic>{});
      final _wifiService = WiFiService(_config);
      expect(
          _wifiService.parseStoredOutput(testData),
          equals(<WiFiStoredNetworkInfo>[
            WiFiStoredNetworkInfo(
              id: 0,
              SSID: 'Jazzir_5G',
              disabled: false,
            ),
            WiFiStoredNetworkInfo(
              id: 1,
              SSID: 'Jazzir_2G',
              disabled: false,
            ),
            WiFiStoredNetworkInfo(
              id: 2,
              SSID: 'tutu',
              disabled: false,
            ),
            WiFiStoredNetworkInfo(
              id: 3,
              SSID: '',
              disabled: true,
            ),
            WiFiStoredNetworkInfo(
              id: 4,
              SSID: '',
              disabled: true,
            )
          ]));
    });
  });
}
