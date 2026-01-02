import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/src/service/system_info/system_info_service.dart';
import 'package:test/test.dart';
// Импортируйте файл, где лежит ваш метод и класс
// import 'package:your_project/network_utils.dart'; 

void main() {
  group('ifconfig Parser Tests', () {
    
    // --- Тестовые данные (Fixtures) ---
    
    // Пример вывода Linux (Ubuntu/Debian modern net-tools)
    const linuxOutput = '''
docker0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
        ether 02:42:06:96:38:20  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

enp8s0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.50.177  netmask 255.255.255.0  broadcast 192.168.50.255
        inet6 fe80::9e6b:ff:fe0c:cc50  prefixlen 64  scopeid 0x20<link>
        ether 9c:6b:00:0c:cc:50  txqueuelen 1000  (Ethernet)
        RX packets 15234  bytes 12345678 (12.3 MB)
        TX packets 14000  bytes 8765432 (8.7 MB)
''';

    // Пример вывода macOS
    const macOsOutput = '''
lo0: flags=8049<UP,LOOPBACK,RUNNING,MULTICAST> mtu 16384
	options=1203<RXCSUM,TXCSUM,TXSTATUS,SW_TIMESTAMP>
	inet 127.0.0.1 netmask 0xff000000 
	inet6 ::1 prefixlen 128 
	inet6 fe80::1%lo0 prefixlen 64 scopeid 0x1 
	nd6 options=201<PERFORMNUD,DAD>

en0: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
	options=6463<RXCSUM,TXCSUM,TSO4,TSO6,CHANNEL_IO,PARTIAL_CSUM,ZEROINVERT_CSUM>
	ether f4:d4:88:5e:a2:16 
	inet6 fe80::1094:32:15:19%en0 prefixlen 64 secured scopeid 0x4 
	inet 192.168.1.50 netmask 0xffffff00 broadcast 192.168.1.255
	nd6 options=201<PERFORMNUD,DAD>
	media: autoselect
	status: active
''';

    // --- Тесты ---

    test('Correctly parses Linux output', () {
      final results = SystemInfoService.parseIfconfigOutput(linuxOutput);

      expect(results.length, equals(2));

      // Проверка первого интерфейса (docker0)
      // У него НЕТ флага RUNNING, значит статус должен быть offline
      final docker = results[0];
      expect(docker.name, equals('docker0'));
      expect(docker.status, equals(NetworkInterfaceStatus.offline));
      expect(docker.ip4, equals('172.17.0.1'));
      expect(docker.ip6, isEmpty); // Нет IPv6

      // Проверка второго интерфейса (enp8s0)
      // У него ЕСТЬ флаг RUNNING
      final enp = results[1];
      expect(enp.name, equals('enp8s0'));
      expect(enp.status, equals(NetworkInterfaceStatus.running));
      expect(enp.ip4, equals('192.168.50.177'));
      expect(enp.ip6, contains('fe80::9e6b:ff:fe0c:cc50'));
    });

    test('Correctly parses macOS output', () {
      final results = SystemInfoService.parseIfconfigOutput(macOsOutput);

      expect(results.length, equals(2));

      // Loopback
      final lo = results[0];
      expect(lo.name, equals('lo0'));
      expect(lo.status, equals(NetworkInterfaceStatus.running));
      expect(lo.ip4, equals('127.0.0.1'));
      // Должен взять первый inet6 (::1) или второй, зависит от логики,
      // но в нашем коде берется первый встреченный.
      expect(lo.ip6, equals('::1')); 

      // WiFi / Ethernet
      final en0 = results[1];
      expect(en0.name, equals('en0'));
      expect(en0.status, equals(NetworkInterfaceStatus.running));
      expect(en0.ip4, equals('192.168.1.50'));
      // Проверяем, что %en0 (zone index) не сломал парсинг,
      // если мы используем простой regex для hex.
      // Если regex [a-fA-F0-9:], то он остановится перед %.
      expect(en0.ip6, startsWith('fe80::1094:32:15:19'));
    });

    test('Handles empty or malformed output gracefully', () {
      final results = SystemInfoService.parseIfconfigOutput('');
      expect(results, isEmpty);
      
      final resultsTrash = SystemInfoService.parseIfconfigOutput('some random error text\nwith no format');
      // В зависимости от реализации может вернуть пустой список, 
      // либо список с "мусорными" данными, если regex совпадет случайно.
      // Наш код требует начала строки без отступа для имени, так что скорее всего будет пусто.
      expect(resultsTrash, isEmpty);
    });
    
    test('Parses interface without IP addresses', () {
      const noIpOutput = '''
fw0: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
	options=6463<RXCSUM,TXCSUM,TSO4,TSO6>
	ether ac:de:48:00:11:22 
	media: autoselect <full-duplex>
	status: inactive
''';
      final results = SystemInfoService.parseIfconfigOutput(noIpOutput);
      
      expect(results.length, equals(1));
      expect(results.first.name, equals('fw0'));
      expect(results.first.status, equals(NetworkInterfaceStatus.running)); // Флаг RUNNING есть
      expect(results.first.ip4, isEmpty);
      expect(results.first.ip6, isEmpty);
    });
  });
}