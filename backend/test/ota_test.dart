import 'package:dslideshow_backend/src/service/ota/ota_service.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

const _debUrl =
    'https://example.test/releases/v8.2.0%2B7/dslideshow-8.2.0%2B7-arm64.deb';

void main() {
  for (final tag in ['v8.2.0+7', '8.2.0+7']) {
    test(
      'release $tag selects the DEB asset and preserves its encoded URL',
      () {
        final release = OTAService.parseReleaseData({
          'tag_name': tag,
          'assets': <dynamic>[
            {
              'name': 'sources.zip',
              'browser_download_url': 'https://example.test/source.zip',
            },
            {
              'name': 'dslideshow-8.2.0+7-arm64.deb',
              'browser_download_url': _debUrl,
            },
          ],
        });
        expect(release, isNotNull);
        expect(release!.version, Version(8, 2, 0, build: '7'));
        expect(release.debUrl, _debUrl);
      },
    );
  }

  for (final (name, payload) in <(String, Map<String, dynamic>)>[
    ('missing tag', {'assets': <dynamic>[]}),
    ('invalid version', {'tag_name': 'broken', 'assets': <dynamic>[]}),
    ('missing assets', {'tag_name': 'v8.2.0+7'}),
    ('empty assets', {'tag_name': 'v8.2.0+7', 'assets': <dynamic>[]}),
    (
      'no DEB asset',
      {
        'tag_name': 'v8.2.0+7',
        'assets': <dynamic>[
          {'name': 'sources.zip'},
        ],
      },
    ),
    (
      'missing download URL',
      {
        'tag_name': 'v8.2.0+7',
        'assets': <dynamic>[
          {'name': 'update.deb'},
        ],
      },
    ),
  ]) {
    test('release with $name cannot start an update', () {
      expect(OTAService.parseReleaseData(payload), isNull);
    });
  }
}
