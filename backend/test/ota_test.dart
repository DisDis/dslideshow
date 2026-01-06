import 'dart:convert';

import 'package:dslideshow_backend/src/service/ota/ota_service.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

void main() {
  group('OTAService', () {
    test('parse Release Data from GitHub', () {
      final testDataStr = """{
  "url": "https://api.github.com/repos/DisDis/dslideshow/releases/274039190",
  "assets_url": "https://api.github.com/repos/DisDis/dslideshow/releases/274039190/assets",
  "upload_url": "https://uploads.github.com/repos/DisDis/dslideshow/releases/274039190/assets{?name,label}",
  "html_url": "https://github.com/DisDis/dslideshow/releases/tag/v8.2.0%2B7",
  "id": 274039190,
  "author": {
    "login": "DisDis",
    "id": 87201,
    "node_id": "MDQ6VXNlcjg3MjAx",
    "avatar_url": "https://avatars.githubusercontent.com/u/87201?v=4",
    "gravatar_id": "",
    "url": "https://api.github.com/users/DisDis",
    "html_url": "https://github.com/DisDis",
    "followers_url": "https://api.github.com/users/DisDis/followers",
    "following_url": "https://api.github.com/users/DisDis/following{/other_user}",
    "gists_url": "https://api.github.com/users/DisDis/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/DisDis/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/DisDis/subscriptions",
    "organizations_url": "https://api.github.com/users/DisDis/orgs",
    "repos_url": "https://api.github.com/users/DisDis/repos",
    "events_url": "https://api.github.com/users/DisDis/events{/privacy}",
    "received_events_url": "https://api.github.com/users/DisDis/received_events",
    "type": "User",
    "user_view_type": "public",
    "site_admin": false
  },
  "node_id": "RE_kwDOD8p5G84QVYGW",
  "tag_name": "v8.2.0+7",
  "target_commitish": "master",
  "name": "v8.2.0+7-arm64",
  "draft": false,
  "immutable": false,
  "prerelease": false,
  "created_at": "2026-01-03T21:25:15Z",
  "updated_at": "2026-01-04T08:50:36Z",
  "published_at": "2026-01-04T08:50:36Z",
  "assets": [
    {
      "url": "https://api.github.com/repos/DisDis/dslideshow/releases/assets/336119027",
      "id": 336119027,
      "node_id": "RA_kwDOD8p5G84UCMTz",
      "name": "dslideshow-8.2.0+7-arm64-pi4.deb",
      "label": null,
      "uploader": {
        "login": "DisDis",
        "id": 87201,
        "node_id": "MDQ6VXNlcjg3MjAx",
        "avatar_url": "https://avatars.githubusercontent.com/u/87201?v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/DisDis",
        "html_url": "https://github.com/DisDis",
        "followers_url": "https://api.github.com/users/DisDis/followers",
        "following_url": "https://api.github.com/users/DisDis/following{/other_user}",
        "gists_url": "https://api.github.com/users/DisDis/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/DisDis/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/DisDis/subscriptions",
        "organizations_url": "https://api.github.com/users/DisDis/orgs",
        "repos_url": "https://api.github.com/users/DisDis/repos",
        "events_url": "https://api.github.com/users/DisDis/events{/privacy}",
        "received_events_url": "https://api.github.com/users/DisDis/received_events",
        "type": "User",
        "user_view_type": "public",
        "site_admin": false
      },
      "content_type": "application/vnd.debian.binary-package",
      "state": "uploaded",
      "size": 16510696,
      "digest": "sha256:f9ce9f0bddfc9e74b54c48193cc36c4391da86ac1d041801c9dc5c61c4627754",
      "download_count": 1,
      "created_at": "2026-01-04T08:49:47Z",
      "updated_at": "2026-01-04T08:49:51Z",
      "browser_download_url": "https://github.com/DisDis/dslideshow/releases/download/v8.2.0%2B7/dslideshow-8.2.0%2B7-arm64-pi4.deb"
    }
  ],
  "tarball_url": "https://api.github.com/repos/DisDis/dslideshow/tarball/v8.2.0+7",
  "zipball_url": "https://api.github.com/repos/DisDis/dslideshow/zipball/v8.2.0+7",
  "body": "Increased QR Code size"
}""";
      final releaseData = json.decode(testDataStr);
      final releaseInfo = OTAService.parseReleaseData(releaseData);
      expect(releaseInfo!.version, equals(Version(8, 2, 0, build: "7")));
      expect(
        releaseInfo.debUrl,
        equals(
          "https://github.com/DisDis/dslideshow/releases/download/v8.2.0%2B7/dslideshow-8.2.0%2B7-arm64-pi4.deb",
        ),
      );
    });

    test('get basename from url', () {
      expect(
        path.basename(
          Uri.decodeFull(
            "https://github.com/DisDis/dslideshow/releases/download/v8.2.0%2B7/dslideshow-8.2.0%2B7-arm64-pi4.deb",
          ),
        ),
        equals("dslideshow-8.2.0+7-arm64-pi4.deb"),
      );
    });
    test('compare versions', () {
      final currentVerion = Version.parse('8.2.0+5');
      final newVerion = Version.parse('8.2.0+6');
      expect(currentVerion < newVerion, equals(true));
    });
  });
}
