import 'package:dslideshow_backend/config.dart';
import 'package:test/test.dart';

Map<String, dynamic> otherStorageSections(AppConfig config) {
  final result = config.toStorageJson();
  final slideshow = result['slideshow'] as Map<String, dynamic>;
  final effects = slideshow.remove('effects') as Map<String, dynamic>;
  expect(effects['schemaVersion'], 1);
  expect(effects['items'], isA<List>());
  if (slideshow.isEmpty) result.remove('slideshow');
  return result;
}
