import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

void nativeFile(String path, {int committed = 1, int complete = 1, int dropped = 0}) {
  final data = ByteData(256), bytes = data.buffer.asUint8List();
  bytes.setRange(0, 8, ascii.encode('NPIPV001'));
  for (final (i, value) in [1, 0x01020304, 128, 128, 1, 123, 3, 0].indexed) {
    data.setUint32(8 + i * 4, value, Endian.little);
  }
  for (final (i, value) in [1, committed, dropped, 1000, 2000, 0].indexed) {
    data.setUint64(40 + i * 8, value, Endian.little);
  }
  data.setUint32(88, 1, Endian.little);
  data.setUint32(128, complete, Endian.little);
  data.setUint16(132, 1, Endian.little);
  for (final (i, value) in [1, 1100, 1200, 100, 110].indexed) {
    data.setUint64(136 + i * 8, value, Endian.little);
  }
  data.setUint32(176, 123, Endian.little);
  data.setInt64(184, 1, Endian.little);
  File(path).writeAsBytesSync(bytes);
}
