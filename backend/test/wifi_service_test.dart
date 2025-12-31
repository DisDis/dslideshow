import 'package:dslideshow_backend/src/command/wifi_commands.dart';
import 'package:dslideshow_backend/src/service/wifi/wifi_config.dart';
import 'package:dslideshow_backend/src/service/wifi/wifi_service.dart';
import 'package:test/test.dart';

void main() {
  group('WiFiService', () {
    test('parse scanOutput #1', () {
      final testData =
          """N-USE  BSSID              SSID               MODE   CHAN  RATE        SIGNAL  BARS  SECURITY  
        4C:BB:4F:DC:2C:55  Jazzir             Infra  9     270 Мбит/с  90      ▂▄▆█  WPA2      
*       4C:BC:4F:DC:3C:55  Jazzir_5G          Infra  40    270 Мбит/с  72      ▂▄▆_  WPA2      
        F0:BB:74:62:48:A9  Jazzir             Infra  9     270 Мбит/с  70      ▂▄▆_  WPA2      
        52:FF:20:8F:34:1D  GuestNetw WiFi     Infra  149   270 Мбит/с  67      ▂▄▆_  WPA2      
""";

      final _config = new WiFiConfig.fromJson(<String, dynamic>{});
      final _wifiService = WiFiService(_config);
      expect(
        _wifiService.parseScanOutput(testData),
        equals(<WiFiNetworkInfo>[
          WiFiNetworkInfo(
            BSSID: '4C:BB:4F:DC:2C:55',
            SSID: 'Jazzir',
            signal: 90,
            channel: 9,
            rate: 270,
            security: 'WPA2',
          ),
          WiFiNetworkInfo(
            BSSID: '4C:BC:4F:DC:3C:55',
            SSID: 'Jazzir_5G',
            signal: 72,
            channel: 40,
            rate: 270,
            security: 'WPA2',
          ),
          WiFiNetworkInfo(
            BSSID: 'F0:BB:74:62:48:A9',
            SSID: 'Jazzir',
            signal: 70,
            channel: 9,
            rate: 270,
            security: 'WPA2',
          ),
          WiFiNetworkInfo(
            BSSID: '52:FF:20:8F:34:1D',
            SSID: 'GuestNetw WiFi',
            signal: 67,
            channel: 149,
            rate: 270,
            security: 'WPA2',
          ),
        ]),
      );
    });

    test('parse scanOutput #2 - empty', () {
      final testData = """""";

      final _config = new WiFiConfig.fromJson(<String, dynamic>{});
      final _wifiService = WiFiService(_config);
      expect(
        _wifiService.parseScanOutput(testData),
        equals(<WiFiNetworkInfo>[]),
      );
    });

    test('parse parseConnectionsOutput #1 - empty', () {
      final testData = """""";

      final _config = new WiFiConfig.fromJson(<String, dynamic>{});
      final _wifiService = WiFiService(_config);
      expect(
        _wifiService.parseScanOutput(testData),
        equals(<WiFiConnectionInfo>[]),
      );
    });

    test('parse parseConnectionsOutput #2', () {
      final testData =
          """NAME               UUID                                  TYPE      DEVICE          
Jazzir_5G          bde254af-21bc-4edd-864c-1e01012aac72  wifi      wlo1            
lo                 9c102455-4a20-4f23-bd88-aecee06469b6  loopback  lo              
docker0            13594913-743b-4b39-9c3b-6ef9bfdcadec  bridge    docker0         
AC:0B:FB:73:C6:04  a8fe3917-c305-4147-b3c2-4304545c4a0b  wifi      --              
Air                7e32b73f-c4de-4696-9517-b37c8d1921b4  wifi      --              
Asus Restore       90287d45-9281-4710-8a34-286132876e80  ethernet  --""";

      final _config = new WiFiConfig.fromJson(<String, dynamic>{});
      final _wifiService = WiFiService(_config);
      expect(
        _wifiService.parseConnectionsOutput(testData),
        equals(<WiFiConnectionInfo>[
          WiFiConnectionInfo(
            name: 'Jazzir_5G',
            UUID: 'bde254af-21bc-4edd-864c-1e01012aac72',
            type: 'wifi',
            device: 'wlo1',
          ),
          WiFiConnectionInfo(
            name: 'lo',
            UUID: '9c102455-4a20-4f23-bd88-aecee06469b6',
            type: 'loopback',
            device: 'lo',
          ),
          WiFiConnectionInfo(
            name: 'docker0',
            UUID: '13594913-743b-4b39-9c3b-6ef9bfdcadec',
            type: 'bridge',
            device: 'docker0',
          ),
          WiFiConnectionInfo(
            name: 'AC:0B:FB:73:C6:04',
            UUID: 'a8fe3917-c305-4147-b3c2-4304545c4a0b',
            type: 'wifi',
            device: '--',
          ),
          WiFiConnectionInfo(
            name: 'Air',
            UUID: '7e32b73f-c4de-4696-9517-b37c8d1921b4',
            type: 'wifi',
            device: '--',
          ),
          WiFiConnectionInfo(
            name: 'Asus Restore',
            UUID: '90287d45-9281-4710-8a34-286132876e80',
            type: 'ethernet',
            device: '--',
          ),
        ]),
      );
    });
  });
}
