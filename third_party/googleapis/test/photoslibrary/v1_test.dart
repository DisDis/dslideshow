library googleapis.photoslibrary.v1.test;

import "dart:core" as core;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:test/test.dart' as unittest;

import 'package:googleapis/photoslibrary/v1.dart' as api;

class HttpServerMock extends http.BaseClient {
  core.Function _callback;
  core.bool _expectJson;

  void register(core.Function callback, core.bool expectJson) {
    _callback = callback;
    _expectJson = expectJson;
  }

  async.Future<http.StreamedResponse> send(http.BaseRequest request) {
    if (_expectJson) {
      return request
          .finalize()
          .transform(convert.utf8.decoder)
          .join('')
          .then((core.String jsonString) {
        if (jsonString.isEmpty) {
          return _callback(request, null);
        } else {
          return _callback(request, convert.json.decode(jsonString));
        }
      });
    } else {
      var stream = request.finalize();
      if (stream == null) {
        return _callback(request, []);
      } else {
        return stream.toBytes().then((data) {
          return _callback(request, data);
        });
      }
    }
  }
}

http.StreamedResponse stringResponse(core.int status,
    core.Map<core.String, core.String> headers, core.String body) {
  var stream = new async.Stream.fromIterable([convert.utf8.encode(body)]);
  return new http.StreamedResponse(stream, status, headers: headers);
}

core.int buildCounterAddEnrichmentToAlbumRequest = 0;
buildAddEnrichmentToAlbumRequest() {
  var o = new api.AddEnrichmentToAlbumRequest();
  buildCounterAddEnrichmentToAlbumRequest++;
  if (buildCounterAddEnrichmentToAlbumRequest < 3) {
    o.albumPosition = buildAlbumPosition();
    o.newEnrichmentItem = buildNewEnrichmentItem();
  }
  buildCounterAddEnrichmentToAlbumRequest--;
  return o;
}

checkAddEnrichmentToAlbumRequest(api.AddEnrichmentToAlbumRequest o) {
  buildCounterAddEnrichmentToAlbumRequest++;
  if (buildCounterAddEnrichmentToAlbumRequest < 3) {
    checkAlbumPosition(o.albumPosition);
    checkNewEnrichmentItem(o.newEnrichmentItem);
  }
  buildCounterAddEnrichmentToAlbumRequest--;
}

core.int buildCounterAddEnrichmentToAlbumResponse = 0;
buildAddEnrichmentToAlbumResponse() {
  var o = new api.AddEnrichmentToAlbumResponse();
  buildCounterAddEnrichmentToAlbumResponse++;
  if (buildCounterAddEnrichmentToAlbumResponse < 3) {
    o.enrichmentItem = buildEnrichmentItem();
  }
  buildCounterAddEnrichmentToAlbumResponse--;
  return o;
}

checkAddEnrichmentToAlbumResponse(api.AddEnrichmentToAlbumResponse o) {
  buildCounterAddEnrichmentToAlbumResponse++;
  if (buildCounterAddEnrichmentToAlbumResponse < 3) {
    checkEnrichmentItem(o.enrichmentItem);
  }
  buildCounterAddEnrichmentToAlbumResponse--;
}

core.int buildCounterAlbum = 0;
buildAlbum() {
  var o = new api.Album();
  buildCounterAlbum++;
  if (buildCounterAlbum < 3) {
    o.coverPhotoBaseUrl = "foo";
    o.id = "foo";
    o.isWriteable = true;
    o.productUrl = "foo";
    o.shareInfo = buildShareInfo();
    o.title = "foo";
    o.totalMediaItems = "foo";
  }
  buildCounterAlbum--;
  return o;
}

checkAlbum(api.Album o) {
  buildCounterAlbum++;
  if (buildCounterAlbum < 3) {
    unittest.expect(o.coverPhotoBaseUrl, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.isWriteable, unittest.isTrue);
    unittest.expect(o.productUrl, unittest.equals('foo'));
    checkShareInfo(o.shareInfo);
    unittest.expect(o.title, unittest.equals('foo'));
    unittest.expect(o.totalMediaItems, unittest.equals('foo'));
  }
  buildCounterAlbum--;
}

core.int buildCounterAlbumPosition = 0;
buildAlbumPosition() {
  var o = new api.AlbumPosition();
  buildCounterAlbumPosition++;
  if (buildCounterAlbumPosition < 3) {
    o.position = "foo";
    o.relativeEnrichmentItemId = "foo";
    o.relativeMediaItemId = "foo";
  }
  buildCounterAlbumPosition--;
  return o;
}

checkAlbumPosition(api.AlbumPosition o) {
  buildCounterAlbumPosition++;
  if (buildCounterAlbumPosition < 3) {
    unittest.expect(o.position, unittest.equals('foo'));
    unittest.expect(o.relativeEnrichmentItemId, unittest.equals('foo'));
    unittest.expect(o.relativeMediaItemId, unittest.equals('foo'));
  }
  buildCounterAlbumPosition--;
}

buildUnnamed4188() {
  var o = new core.List<api.NewMediaItem>();
  o.add(buildNewMediaItem());
  o.add(buildNewMediaItem());
  return o;
}

checkUnnamed4188(core.List<api.NewMediaItem> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkNewMediaItem(o[0]);
  checkNewMediaItem(o[1]);
}

core.int buildCounterBatchCreateMediaItemsRequest = 0;
buildBatchCreateMediaItemsRequest() {
  var o = new api.BatchCreateMediaItemsRequest();
  buildCounterBatchCreateMediaItemsRequest++;
  if (buildCounterBatchCreateMediaItemsRequest < 3) {
    o.albumId = "foo";
    o.albumPosition = buildAlbumPosition();
    o.newMediaItems = buildUnnamed4188();
  }
  buildCounterBatchCreateMediaItemsRequest--;
  return o;
}

checkBatchCreateMediaItemsRequest(api.BatchCreateMediaItemsRequest o) {
  buildCounterBatchCreateMediaItemsRequest++;
  if (buildCounterBatchCreateMediaItemsRequest < 3) {
    unittest.expect(o.albumId, unittest.equals('foo'));
    checkAlbumPosition(o.albumPosition);
    checkUnnamed4188(o.newMediaItems);
  }
  buildCounterBatchCreateMediaItemsRequest--;
}

buildUnnamed4189() {
  var o = new core.List<api.NewMediaItemResult>();
  o.add(buildNewMediaItemResult());
  o.add(buildNewMediaItemResult());
  return o;
}

checkUnnamed4189(core.List<api.NewMediaItemResult> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkNewMediaItemResult(o[0]);
  checkNewMediaItemResult(o[1]);
}

core.int buildCounterBatchCreateMediaItemsResponse = 0;
buildBatchCreateMediaItemsResponse() {
  var o = new api.BatchCreateMediaItemsResponse();
  buildCounterBatchCreateMediaItemsResponse++;
  if (buildCounterBatchCreateMediaItemsResponse < 3) {
    o.newMediaItemResults = buildUnnamed4189();
  }
  buildCounterBatchCreateMediaItemsResponse--;
  return o;
}

checkBatchCreateMediaItemsResponse(api.BatchCreateMediaItemsResponse o) {
  buildCounterBatchCreateMediaItemsResponse++;
  if (buildCounterBatchCreateMediaItemsResponse < 3) {
    checkUnnamed4189(o.newMediaItemResults);
  }
  buildCounterBatchCreateMediaItemsResponse--;
}

buildUnnamed4190() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed4190(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed4191() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed4191(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterContentFilter = 0;
buildContentFilter() {
  var o = new api.ContentFilter();
  buildCounterContentFilter++;
  if (buildCounterContentFilter < 3) {
    o.excludedContentCategories = buildUnnamed4190();
    o.includedContentCategories = buildUnnamed4191();
  }
  buildCounterContentFilter--;
  return o;
}

checkContentFilter(api.ContentFilter o) {
  buildCounterContentFilter++;
  if (buildCounterContentFilter < 3) {
    checkUnnamed4190(o.excludedContentCategories);
    checkUnnamed4191(o.includedContentCategories);
  }
  buildCounterContentFilter--;
}

core.int buildCounterContributorInfo = 0;
buildContributorInfo() {
  var o = new api.ContributorInfo();
  buildCounterContributorInfo++;
  if (buildCounterContributorInfo < 3) {
    o.displayName = "foo";
    o.profilePictureBaseUrl = "foo";
  }
  buildCounterContributorInfo--;
  return o;
}

checkContributorInfo(api.ContributorInfo o) {
  buildCounterContributorInfo++;
  if (buildCounterContributorInfo < 3) {
    unittest.expect(o.displayName, unittest.equals('foo'));
    unittest.expect(o.profilePictureBaseUrl, unittest.equals('foo'));
  }
  buildCounterContributorInfo--;
}

core.int buildCounterCreateAlbumRequest = 0;
buildCreateAlbumRequest() {
  var o = new api.CreateAlbumRequest();
  buildCounterCreateAlbumRequest++;
  if (buildCounterCreateAlbumRequest < 3) {
    o.album = buildAlbum();
  }
  buildCounterCreateAlbumRequest--;
  return o;
}

checkCreateAlbumRequest(api.CreateAlbumRequest o) {
  buildCounterCreateAlbumRequest++;
  if (buildCounterCreateAlbumRequest < 3) {
    checkAlbum(o.album);
  }
  buildCounterCreateAlbumRequest--;
}

core.int buildCounterDate = 0;
buildDate() {
  var o = new api.Date();
  buildCounterDate++;
  if (buildCounterDate < 3) {
    o.day = 42;
    o.month = 42;
    o.year = 42;
  }
  buildCounterDate--;
  return o;
}

checkDate(api.Date o) {
  buildCounterDate++;
  if (buildCounterDate < 3) {
    unittest.expect(o.day, unittest.equals(42));
    unittest.expect(o.month, unittest.equals(42));
    unittest.expect(o.year, unittest.equals(42));
  }
  buildCounterDate--;
}

buildUnnamed4192() {
  var o = new core.List<api.Date>();
  o.add(buildDate());
  o.add(buildDate());
  return o;
}

checkUnnamed4192(core.List<api.Date> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDate(o[0]);
  checkDate(o[1]);
}

buildUnnamed4193() {
  var o = new core.List<api.DateRange>();
  o.add(buildDateRange());
  o.add(buildDateRange());
  return o;
}

checkUnnamed4193(core.List<api.DateRange> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDateRange(o[0]);
  checkDateRange(o[1]);
}

core.int buildCounterDateFilter = 0;
buildDateFilter() {
  var o = new api.DateFilter();
  buildCounterDateFilter++;
  if (buildCounterDateFilter < 3) {
    o.dates = buildUnnamed4192();
    o.ranges = buildUnnamed4193();
  }
  buildCounterDateFilter--;
  return o;
}

checkDateFilter(api.DateFilter o) {
  buildCounterDateFilter++;
  if (buildCounterDateFilter < 3) {
    checkUnnamed4192(o.dates);
    checkUnnamed4193(o.ranges);
  }
  buildCounterDateFilter--;
}

core.int buildCounterDateRange = 0;
buildDateRange() {
  var o = new api.DateRange();
  buildCounterDateRange++;
  if (buildCounterDateRange < 3) {
    o.endDate = buildDate();
    o.startDate = buildDate();
  }
  buildCounterDateRange--;
  return o;
}

checkDateRange(api.DateRange o) {
  buildCounterDateRange++;
  if (buildCounterDateRange < 3) {
    checkDate(o.endDate);
    checkDate(o.startDate);
  }
  buildCounterDateRange--;
}

core.int buildCounterEnrichmentItem = 0;
buildEnrichmentItem() {
  var o = new api.EnrichmentItem();
  buildCounterEnrichmentItem++;
  if (buildCounterEnrichmentItem < 3) {
    o.id = "foo";
  }
  buildCounterEnrichmentItem--;
  return o;
}

checkEnrichmentItem(api.EnrichmentItem o) {
  buildCounterEnrichmentItem++;
  if (buildCounterEnrichmentItem < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
  }
  buildCounterEnrichmentItem--;
}

core.int buildCounterFilters = 0;
buildFilters() {
  var o = new api.Filters();
  buildCounterFilters++;
  if (buildCounterFilters < 3) {
    o.contentFilter = buildContentFilter();
    o.dateFilter = buildDateFilter();
    o.includeArchivedMedia = true;
    o.mediaTypeFilter = buildMediaTypeFilter();
  }
  buildCounterFilters--;
  return o;
}

checkFilters(api.Filters o) {
  buildCounterFilters++;
  if (buildCounterFilters < 3) {
    checkContentFilter(o.contentFilter);
    checkDateFilter(o.dateFilter);
    unittest.expect(o.includeArchivedMedia, unittest.isTrue);
    checkMediaTypeFilter(o.mediaTypeFilter);
  }
  buildCounterFilters--;
}

core.int buildCounterJoinSharedAlbumRequest = 0;
buildJoinSharedAlbumRequest() {
  var o = new api.JoinSharedAlbumRequest();
  buildCounterJoinSharedAlbumRequest++;
  if (buildCounterJoinSharedAlbumRequest < 3) {
    o.shareToken = "foo";
  }
  buildCounterJoinSharedAlbumRequest--;
  return o;
}

checkJoinSharedAlbumRequest(api.JoinSharedAlbumRequest o) {
  buildCounterJoinSharedAlbumRequest++;
  if (buildCounterJoinSharedAlbumRequest < 3) {
    unittest.expect(o.shareToken, unittest.equals('foo'));
  }
  buildCounterJoinSharedAlbumRequest--;
}

core.int buildCounterJoinSharedAlbumResponse = 0;
buildJoinSharedAlbumResponse() {
  var o = new api.JoinSharedAlbumResponse();
  buildCounterJoinSharedAlbumResponse++;
  if (buildCounterJoinSharedAlbumResponse < 3) {}
  buildCounterJoinSharedAlbumResponse--;
  return o;
}

checkJoinSharedAlbumResponse(api.JoinSharedAlbumResponse o) {
  buildCounterJoinSharedAlbumResponse++;
  if (buildCounterJoinSharedAlbumResponse < 3) {}
  buildCounterJoinSharedAlbumResponse--;
}

core.int buildCounterLatLng = 0;
buildLatLng() {
  var o = new api.LatLng();
  buildCounterLatLng++;
  if (buildCounterLatLng < 3) {
    o.latitude = 42.0;
    o.longitude = 42.0;
  }
  buildCounterLatLng--;
  return o;
}

checkLatLng(api.LatLng o) {
  buildCounterLatLng++;
  if (buildCounterLatLng < 3) {
    unittest.expect(o.latitude, unittest.equals(42.0));
    unittest.expect(o.longitude, unittest.equals(42.0));
  }
  buildCounterLatLng--;
}

buildUnnamed4194() {
  var o = new core.List<api.Album>();
  o.add(buildAlbum());
  o.add(buildAlbum());
  return o;
}

checkUnnamed4194(core.List<api.Album> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAlbum(o[0]);
  checkAlbum(o[1]);
}

core.int buildCounterListAlbumsResponse = 0;
buildListAlbumsResponse() {
  var o = new api.ListAlbumsResponse();
  buildCounterListAlbumsResponse++;
  if (buildCounterListAlbumsResponse < 3) {
    o.albums = buildUnnamed4194();
    o.nextPageToken = "foo";
  }
  buildCounterListAlbumsResponse--;
  return o;
}

checkListAlbumsResponse(api.ListAlbumsResponse o) {
  buildCounterListAlbumsResponse++;
  if (buildCounterListAlbumsResponse < 3) {
    checkUnnamed4194(o.albums);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListAlbumsResponse--;
}

buildUnnamed4195() {
  var o = new core.List<api.Album>();
  o.add(buildAlbum());
  o.add(buildAlbum());
  return o;
}

checkUnnamed4195(core.List<api.Album> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAlbum(o[0]);
  checkAlbum(o[1]);
}

core.int buildCounterListSharedAlbumsResponse = 0;
buildListSharedAlbumsResponse() {
  var o = new api.ListSharedAlbumsResponse();
  buildCounterListSharedAlbumsResponse++;
  if (buildCounterListSharedAlbumsResponse < 3) {
    o.nextPageToken = "foo";
    o.sharedAlbums = buildUnnamed4195();
  }
  buildCounterListSharedAlbumsResponse--;
  return o;
}

checkListSharedAlbumsResponse(api.ListSharedAlbumsResponse o) {
  buildCounterListSharedAlbumsResponse++;
  if (buildCounterListSharedAlbumsResponse < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed4195(o.sharedAlbums);
  }
  buildCounterListSharedAlbumsResponse--;
}

core.int buildCounterLocation = 0;
buildLocation() {
  var o = new api.Location();
  buildCounterLocation++;
  if (buildCounterLocation < 3) {
    o.latlng = buildLatLng();
    o.locationName = "foo";
  }
  buildCounterLocation--;
  return o;
}

checkLocation(api.Location o) {
  buildCounterLocation++;
  if (buildCounterLocation < 3) {
    checkLatLng(o.latlng);
    unittest.expect(o.locationName, unittest.equals('foo'));
  }
  buildCounterLocation--;
}

core.int buildCounterLocationEnrichment = 0;
buildLocationEnrichment() {
  var o = new api.LocationEnrichment();
  buildCounterLocationEnrichment++;
  if (buildCounterLocationEnrichment < 3) {
    o.location = buildLocation();
  }
  buildCounterLocationEnrichment--;
  return o;
}

checkLocationEnrichment(api.LocationEnrichment o) {
  buildCounterLocationEnrichment++;
  if (buildCounterLocationEnrichment < 3) {
    checkLocation(o.location);
  }
  buildCounterLocationEnrichment--;
}

core.int buildCounterMapEnrichment = 0;
buildMapEnrichment() {
  var o = new api.MapEnrichment();
  buildCounterMapEnrichment++;
  if (buildCounterMapEnrichment < 3) {
    o.destination = buildLocation();
    o.origin = buildLocation();
  }
  buildCounterMapEnrichment--;
  return o;
}

checkMapEnrichment(api.MapEnrichment o) {
  buildCounterMapEnrichment++;
  if (buildCounterMapEnrichment < 3) {
    checkLocation(o.destination);
    checkLocation(o.origin);
  }
  buildCounterMapEnrichment--;
}

core.int buildCounterMediaItem = 0;
buildMediaItem() {
  var o = new api.MediaItem();
  buildCounterMediaItem++;
  if (buildCounterMediaItem < 3) {
    o.baseUrl = "foo";
    o.contributorInfo = buildContributorInfo();
    o.description = "foo";
    o.id = "foo";
    o.mediaMetadata = buildMediaMetadata();
    o.mimeType = "foo";
    o.productUrl = "foo";
  }
  buildCounterMediaItem--;
  return o;
}

checkMediaItem(api.MediaItem o) {
  buildCounterMediaItem++;
  if (buildCounterMediaItem < 3) {
    unittest.expect(o.baseUrl, unittest.equals('foo'));
    checkContributorInfo(o.contributorInfo);
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    checkMediaMetadata(o.mediaMetadata);
    unittest.expect(o.mimeType, unittest.equals('foo'));
    unittest.expect(o.productUrl, unittest.equals('foo'));
  }
  buildCounterMediaItem--;
}

core.int buildCounterMediaMetadata = 0;
buildMediaMetadata() {
  var o = new api.MediaMetadata();
  buildCounterMediaMetadata++;
  if (buildCounterMediaMetadata < 3) {
    o.creationTime = "foo";
    o.height = "foo";
    o.photo = buildPhoto();
    o.video = buildVideo();
    o.width = "foo";
  }
  buildCounterMediaMetadata--;
  return o;
}

checkMediaMetadata(api.MediaMetadata o) {
  buildCounterMediaMetadata++;
  if (buildCounterMediaMetadata < 3) {
    unittest.expect(o.creationTime, unittest.equals('foo'));
    unittest.expect(o.height, unittest.equals('foo'));
    checkPhoto(o.photo);
    checkVideo(o.video);
    unittest.expect(o.width, unittest.equals('foo'));
  }
  buildCounterMediaMetadata--;
}

buildUnnamed4196() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed4196(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterMediaTypeFilter = 0;
buildMediaTypeFilter() {
  var o = new api.MediaTypeFilter();
  buildCounterMediaTypeFilter++;
  if (buildCounterMediaTypeFilter < 3) {
    o.mediaTypes = buildUnnamed4196();
  }
  buildCounterMediaTypeFilter--;
  return o;
}

checkMediaTypeFilter(api.MediaTypeFilter o) {
  buildCounterMediaTypeFilter++;
  if (buildCounterMediaTypeFilter < 3) {
    checkUnnamed4196(o.mediaTypes);
  }
  buildCounterMediaTypeFilter--;
}

core.int buildCounterNewEnrichmentItem = 0;
buildNewEnrichmentItem() {
  var o = new api.NewEnrichmentItem();
  buildCounterNewEnrichmentItem++;
  if (buildCounterNewEnrichmentItem < 3) {
    o.locationEnrichment = buildLocationEnrichment();
    o.mapEnrichment = buildMapEnrichment();
    o.textEnrichment = buildTextEnrichment();
  }
  buildCounterNewEnrichmentItem--;
  return o;
}

checkNewEnrichmentItem(api.NewEnrichmentItem o) {
  buildCounterNewEnrichmentItem++;
  if (buildCounterNewEnrichmentItem < 3) {
    checkLocationEnrichment(o.locationEnrichment);
    checkMapEnrichment(o.mapEnrichment);
    checkTextEnrichment(o.textEnrichment);
  }
  buildCounterNewEnrichmentItem--;
}

core.int buildCounterNewMediaItem = 0;
buildNewMediaItem() {
  var o = new api.NewMediaItem();
  buildCounterNewMediaItem++;
  if (buildCounterNewMediaItem < 3) {
    o.description = "foo";
    o.simpleMediaItem = buildSimpleMediaItem();
  }
  buildCounterNewMediaItem--;
  return o;
}

checkNewMediaItem(api.NewMediaItem o) {
  buildCounterNewMediaItem++;
  if (buildCounterNewMediaItem < 3) {
    unittest.expect(o.description, unittest.equals('foo'));
    checkSimpleMediaItem(o.simpleMediaItem);
  }
  buildCounterNewMediaItem--;
}

core.int buildCounterNewMediaItemResult = 0;
buildNewMediaItemResult() {
  var o = new api.NewMediaItemResult();
  buildCounterNewMediaItemResult++;
  if (buildCounterNewMediaItemResult < 3) {
    o.mediaItem = buildMediaItem();
    o.status = buildStatus();
    o.uploadToken = "foo";
  }
  buildCounterNewMediaItemResult--;
  return o;
}

checkNewMediaItemResult(api.NewMediaItemResult o) {
  buildCounterNewMediaItemResult++;
  if (buildCounterNewMediaItemResult < 3) {
    checkMediaItem(o.mediaItem);
    checkStatus(o.status);
    unittest.expect(o.uploadToken, unittest.equals('foo'));
  }
  buildCounterNewMediaItemResult--;
}

core.int buildCounterPhoto = 0;
buildPhoto() {
  var o = new api.Photo();
  buildCounterPhoto++;
  if (buildCounterPhoto < 3) {
    o.apertureFNumber = 42.0;
    o.cameraMake = "foo";
    o.cameraModel = "foo";
    o.exposureTime = "foo";
    o.focalLength = 42.0;
    o.isoEquivalent = 42;
  }
  buildCounterPhoto--;
  return o;
}

checkPhoto(api.Photo o) {
  buildCounterPhoto++;
  if (buildCounterPhoto < 3) {
    unittest.expect(o.apertureFNumber, unittest.equals(42.0));
    unittest.expect(o.cameraMake, unittest.equals('foo'));
    unittest.expect(o.cameraModel, unittest.equals('foo'));
    unittest.expect(o.exposureTime, unittest.equals('foo'));
    unittest.expect(o.focalLength, unittest.equals(42.0));
    unittest.expect(o.isoEquivalent, unittest.equals(42));
  }
  buildCounterPhoto--;
}

core.int buildCounterSearchMediaItemsRequest = 0;
buildSearchMediaItemsRequest() {
  var o = new api.SearchMediaItemsRequest();
  buildCounterSearchMediaItemsRequest++;
  if (buildCounterSearchMediaItemsRequest < 3) {
    o.albumId = "foo";
    o.filters = buildFilters();
    o.pageSize = 42;
    o.pageToken = "foo";
  }
  buildCounterSearchMediaItemsRequest--;
  return o;
}

checkSearchMediaItemsRequest(api.SearchMediaItemsRequest o) {
  buildCounterSearchMediaItemsRequest++;
  if (buildCounterSearchMediaItemsRequest < 3) {
    unittest.expect(o.albumId, unittest.equals('foo'));
    checkFilters(o.filters);
    unittest.expect(o.pageSize, unittest.equals(42));
    unittest.expect(o.pageToken, unittest.equals('foo'));
  }
  buildCounterSearchMediaItemsRequest--;
}

buildUnnamed4197() {
  var o = new core.List<api.MediaItem>();
  o.add(buildMediaItem());
  o.add(buildMediaItem());
  return o;
}

checkUnnamed4197(core.List<api.MediaItem> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMediaItem(o[0]);
  checkMediaItem(o[1]);
}

core.int buildCounterSearchMediaItemsResponse = 0;
buildSearchMediaItemsResponse() {
  var o = new api.SearchMediaItemsResponse();
  buildCounterSearchMediaItemsResponse++;
  if (buildCounterSearchMediaItemsResponse < 3) {
    o.mediaItems = buildUnnamed4197();
    o.nextPageToken = "foo";
  }
  buildCounterSearchMediaItemsResponse--;
  return o;
}

checkSearchMediaItemsResponse(api.SearchMediaItemsResponse o) {
  buildCounterSearchMediaItemsResponse++;
  if (buildCounterSearchMediaItemsResponse < 3) {
    checkUnnamed4197(o.mediaItems);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterSearchMediaItemsResponse--;
}

core.int buildCounterShareAlbumRequest = 0;
buildShareAlbumRequest() {
  var o = new api.ShareAlbumRequest();
  buildCounterShareAlbumRequest++;
  if (buildCounterShareAlbumRequest < 3) {
    o.sharedAlbumOptions = buildSharedAlbumOptions();
  }
  buildCounterShareAlbumRequest--;
  return o;
}

checkShareAlbumRequest(api.ShareAlbumRequest o) {
  buildCounterShareAlbumRequest++;
  if (buildCounterShareAlbumRequest < 3) {
    checkSharedAlbumOptions(o.sharedAlbumOptions);
  }
  buildCounterShareAlbumRequest--;
}

core.int buildCounterShareAlbumResponse = 0;
buildShareAlbumResponse() {
  var o = new api.ShareAlbumResponse();
  buildCounterShareAlbumResponse++;
  if (buildCounterShareAlbumResponse < 3) {
    o.shareInfo = buildShareInfo();
  }
  buildCounterShareAlbumResponse--;
  return o;
}

checkShareAlbumResponse(api.ShareAlbumResponse o) {
  buildCounterShareAlbumResponse++;
  if (buildCounterShareAlbumResponse < 3) {
    checkShareInfo(o.shareInfo);
  }
  buildCounterShareAlbumResponse--;
}

core.int buildCounterShareInfo = 0;
buildShareInfo() {
  var o = new api.ShareInfo();
  buildCounterShareInfo++;
  if (buildCounterShareInfo < 3) {
    o.shareToken = "foo";
    o.shareableUrl = "foo";
    o.sharedAlbumOptions = buildSharedAlbumOptions();
  }
  buildCounterShareInfo--;
  return o;
}

checkShareInfo(api.ShareInfo o) {
  buildCounterShareInfo++;
  if (buildCounterShareInfo < 3) {
    unittest.expect(o.shareToken, unittest.equals('foo'));
    unittest.expect(o.shareableUrl, unittest.equals('foo'));
    checkSharedAlbumOptions(o.sharedAlbumOptions);
  }
  buildCounterShareInfo--;
}

core.int buildCounterSharedAlbumOptions = 0;
buildSharedAlbumOptions() {
  var o = new api.SharedAlbumOptions();
  buildCounterSharedAlbumOptions++;
  if (buildCounterSharedAlbumOptions < 3) {
    o.isCollaborative = true;
    o.isCommentable = true;
  }
  buildCounterSharedAlbumOptions--;
  return o;
}

checkSharedAlbumOptions(api.SharedAlbumOptions o) {
  buildCounterSharedAlbumOptions++;
  if (buildCounterSharedAlbumOptions < 3) {
    unittest.expect(o.isCollaborative, unittest.isTrue);
    unittest.expect(o.isCommentable, unittest.isTrue);
  }
  buildCounterSharedAlbumOptions--;
}

core.int buildCounterSimpleMediaItem = 0;
buildSimpleMediaItem() {
  var o = new api.SimpleMediaItem();
  buildCounterSimpleMediaItem++;
  if (buildCounterSimpleMediaItem < 3) {
    o.uploadToken = "foo";
  }
  buildCounterSimpleMediaItem--;
  return o;
}

checkSimpleMediaItem(api.SimpleMediaItem o) {
  buildCounterSimpleMediaItem++;
  if (buildCounterSimpleMediaItem < 3) {
    unittest.expect(o.uploadToken, unittest.equals('foo'));
  }
  buildCounterSimpleMediaItem--;
}

buildUnnamed4198() {
  var o = new core.Map<core.String, core.Object>();
  o["x"] = {
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  };
  o["y"] = {
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  };
  return o;
}

checkUnnamed4198(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted1 = (o["x"]) as core.Map;
  unittest.expect(casted1, unittest.hasLength(3));
  unittest.expect(casted1["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted1["bool"], unittest.equals(true));
  unittest.expect(casted1["string"], unittest.equals('foo'));
  var casted2 = (o["y"]) as core.Map;
  unittest.expect(casted2, unittest.hasLength(3));
  unittest.expect(casted2["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted2["bool"], unittest.equals(true));
  unittest.expect(casted2["string"], unittest.equals('foo'));
}

buildUnnamed4199() {
  var o = new core.List<core.Map<core.String, core.Object>>();
  o.add(buildUnnamed4198());
  o.add(buildUnnamed4198());
  return o;
}

checkUnnamed4199(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed4198(o[0]);
  checkUnnamed4198(o[1]);
}

core.int buildCounterStatus = 0;
buildStatus() {
  var o = new api.Status();
  buildCounterStatus++;
  if (buildCounterStatus < 3) {
    o.code = 42;
    o.details = buildUnnamed4199();
    o.message = "foo";
  }
  buildCounterStatus--;
  return o;
}

checkStatus(api.Status o) {
  buildCounterStatus++;
  if (buildCounterStatus < 3) {
    unittest.expect(o.code, unittest.equals(42));
    checkUnnamed4199(o.details);
    unittest.expect(o.message, unittest.equals('foo'));
  }
  buildCounterStatus--;
}

core.int buildCounterTextEnrichment = 0;
buildTextEnrichment() {
  var o = new api.TextEnrichment();
  buildCounterTextEnrichment++;
  if (buildCounterTextEnrichment < 3) {
    o.text = "foo";
  }
  buildCounterTextEnrichment--;
  return o;
}

checkTextEnrichment(api.TextEnrichment o) {
  buildCounterTextEnrichment++;
  if (buildCounterTextEnrichment < 3) {
    unittest.expect(o.text, unittest.equals('foo'));
  }
  buildCounterTextEnrichment--;
}

core.int buildCounterVideo = 0;
buildVideo() {
  var o = new api.Video();
  buildCounterVideo++;
  if (buildCounterVideo < 3) {
    o.cameraMake = "foo";
    o.cameraModel = "foo";
    o.fps = 42.0;
    o.status = "foo";
  }
  buildCounterVideo--;
  return o;
}

checkVideo(api.Video o) {
  buildCounterVideo++;
  if (buildCounterVideo < 3) {
    unittest.expect(o.cameraMake, unittest.equals('foo'));
    unittest.expect(o.cameraModel, unittest.equals('foo'));
    unittest.expect(o.fps, unittest.equals(42.0));
    unittest.expect(o.status, unittest.equals('foo'));
  }
  buildCounterVideo--;
}

main() {
  unittest.group("obj-schema-AddEnrichmentToAlbumRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildAddEnrichmentToAlbumRequest();
      var od = new api.AddEnrichmentToAlbumRequest.fromJson(o.toJson());
      checkAddEnrichmentToAlbumRequest(od);
    });
  });

  unittest.group("obj-schema-AddEnrichmentToAlbumResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAddEnrichmentToAlbumResponse();
      var od = new api.AddEnrichmentToAlbumResponse.fromJson(o.toJson());
      checkAddEnrichmentToAlbumResponse(od);
    });
  });

  unittest.group("obj-schema-Album", () {
    unittest.test("to-json--from-json", () {
      var o = buildAlbum();
      var od = new api.Album.fromJson(o.toJson());
      checkAlbum(od);
    });
  });

  unittest.group("obj-schema-AlbumPosition", () {
    unittest.test("to-json--from-json", () {
      var o = buildAlbumPosition();
      var od = new api.AlbumPosition.fromJson(o.toJson());
      checkAlbumPosition(od);
    });
  });

  unittest.group("obj-schema-BatchCreateMediaItemsRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildBatchCreateMediaItemsRequest();
      var od = new api.BatchCreateMediaItemsRequest.fromJson(o.toJson());
      checkBatchCreateMediaItemsRequest(od);
    });
  });

  unittest.group("obj-schema-BatchCreateMediaItemsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildBatchCreateMediaItemsResponse();
      var od = new api.BatchCreateMediaItemsResponse.fromJson(o.toJson());
      checkBatchCreateMediaItemsResponse(od);
    });
  });

  unittest.group("obj-schema-ContentFilter", () {
    unittest.test("to-json--from-json", () {
      var o = buildContentFilter();
      var od = new api.ContentFilter.fromJson(o.toJson());
      checkContentFilter(od);
    });
  });

  unittest.group("obj-schema-ContributorInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildContributorInfo();
      var od = new api.ContributorInfo.fromJson(o.toJson());
      checkContributorInfo(od);
    });
  });

  unittest.group("obj-schema-CreateAlbumRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreateAlbumRequest();
      var od = new api.CreateAlbumRequest.fromJson(o.toJson());
      checkCreateAlbumRequest(od);
    });
  });

  unittest.group("obj-schema-Date", () {
    unittest.test("to-json--from-json", () {
      var o = buildDate();
      var od = new api.Date.fromJson(o.toJson());
      checkDate(od);
    });
  });

  unittest.group("obj-schema-DateFilter", () {
    unittest.test("to-json--from-json", () {
      var o = buildDateFilter();
      var od = new api.DateFilter.fromJson(o.toJson());
      checkDateFilter(od);
    });
  });

  unittest.group("obj-schema-DateRange", () {
    unittest.test("to-json--from-json", () {
      var o = buildDateRange();
      var od = new api.DateRange.fromJson(o.toJson());
      checkDateRange(od);
    });
  });

  unittest.group("obj-schema-EnrichmentItem", () {
    unittest.test("to-json--from-json", () {
      var o = buildEnrichmentItem();
      var od = new api.EnrichmentItem.fromJson(o.toJson());
      checkEnrichmentItem(od);
    });
  });

  unittest.group("obj-schema-Filters", () {
    unittest.test("to-json--from-json", () {
      var o = buildFilters();
      var od = new api.Filters.fromJson(o.toJson());
      checkFilters(od);
    });
  });

  unittest.group("obj-schema-JoinSharedAlbumRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildJoinSharedAlbumRequest();
      var od = new api.JoinSharedAlbumRequest.fromJson(o.toJson());
      checkJoinSharedAlbumRequest(od);
    });
  });

  unittest.group("obj-schema-JoinSharedAlbumResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildJoinSharedAlbumResponse();
      var od = new api.JoinSharedAlbumResponse.fromJson(o.toJson());
      checkJoinSharedAlbumResponse(od);
    });
  });

  unittest.group("obj-schema-LatLng", () {
    unittest.test("to-json--from-json", () {
      var o = buildLatLng();
      var od = new api.LatLng.fromJson(o.toJson());
      checkLatLng(od);
    });
  });

  unittest.group("obj-schema-ListAlbumsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListAlbumsResponse();
      var od = new api.ListAlbumsResponse.fromJson(o.toJson());
      checkListAlbumsResponse(od);
    });
  });

  unittest.group("obj-schema-ListSharedAlbumsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListSharedAlbumsResponse();
      var od = new api.ListSharedAlbumsResponse.fromJson(o.toJson());
      checkListSharedAlbumsResponse(od);
    });
  });

  unittest.group("obj-schema-Location", () {
    unittest.test("to-json--from-json", () {
      var o = buildLocation();
      var od = new api.Location.fromJson(o.toJson());
      checkLocation(od);
    });
  });

  unittest.group("obj-schema-LocationEnrichment", () {
    unittest.test("to-json--from-json", () {
      var o = buildLocationEnrichment();
      var od = new api.LocationEnrichment.fromJson(o.toJson());
      checkLocationEnrichment(od);
    });
  });

  unittest.group("obj-schema-MapEnrichment", () {
    unittest.test("to-json--from-json", () {
      var o = buildMapEnrichment();
      var od = new api.MapEnrichment.fromJson(o.toJson());
      checkMapEnrichment(od);
    });
  });

  unittest.group("obj-schema-MediaItem", () {
    unittest.test("to-json--from-json", () {
      var o = buildMediaItem();
      var od = new api.MediaItem.fromJson(o.toJson());
      checkMediaItem(od);
    });
  });

  unittest.group("obj-schema-MediaMetadata", () {
    unittest.test("to-json--from-json", () {
      var o = buildMediaMetadata();
      var od = new api.MediaMetadata.fromJson(o.toJson());
      checkMediaMetadata(od);
    });
  });

  unittest.group("obj-schema-MediaTypeFilter", () {
    unittest.test("to-json--from-json", () {
      var o = buildMediaTypeFilter();
      var od = new api.MediaTypeFilter.fromJson(o.toJson());
      checkMediaTypeFilter(od);
    });
  });

  unittest.group("obj-schema-NewEnrichmentItem", () {
    unittest.test("to-json--from-json", () {
      var o = buildNewEnrichmentItem();
      var od = new api.NewEnrichmentItem.fromJson(o.toJson());
      checkNewEnrichmentItem(od);
    });
  });

  unittest.group("obj-schema-NewMediaItem", () {
    unittest.test("to-json--from-json", () {
      var o = buildNewMediaItem();
      var od = new api.NewMediaItem.fromJson(o.toJson());
      checkNewMediaItem(od);
    });
  });

  unittest.group("obj-schema-NewMediaItemResult", () {
    unittest.test("to-json--from-json", () {
      var o = buildNewMediaItemResult();
      var od = new api.NewMediaItemResult.fromJson(o.toJson());
      checkNewMediaItemResult(od);
    });
  });

  unittest.group("obj-schema-Photo", () {
    unittest.test("to-json--from-json", () {
      var o = buildPhoto();
      var od = new api.Photo.fromJson(o.toJson());
      checkPhoto(od);
    });
  });

  unittest.group("obj-schema-SearchMediaItemsRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildSearchMediaItemsRequest();
      var od = new api.SearchMediaItemsRequest.fromJson(o.toJson());
      checkSearchMediaItemsRequest(od);
    });
  });

  unittest.group("obj-schema-SearchMediaItemsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildSearchMediaItemsResponse();
      var od = new api.SearchMediaItemsResponse.fromJson(o.toJson());
      checkSearchMediaItemsResponse(od);
    });
  });

  unittest.group("obj-schema-ShareAlbumRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildShareAlbumRequest();
      var od = new api.ShareAlbumRequest.fromJson(o.toJson());
      checkShareAlbumRequest(od);
    });
  });

  unittest.group("obj-schema-ShareAlbumResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildShareAlbumResponse();
      var od = new api.ShareAlbumResponse.fromJson(o.toJson());
      checkShareAlbumResponse(od);
    });
  });

  unittest.group("obj-schema-ShareInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildShareInfo();
      var od = new api.ShareInfo.fromJson(o.toJson());
      checkShareInfo(od);
    });
  });

  unittest.group("obj-schema-SharedAlbumOptions", () {
    unittest.test("to-json--from-json", () {
      var o = buildSharedAlbumOptions();
      var od = new api.SharedAlbumOptions.fromJson(o.toJson());
      checkSharedAlbumOptions(od);
    });
  });

  unittest.group("obj-schema-SimpleMediaItem", () {
    unittest.test("to-json--from-json", () {
      var o = buildSimpleMediaItem();
      var od = new api.SimpleMediaItem.fromJson(o.toJson());
      checkSimpleMediaItem(od);
    });
  });

  unittest.group("obj-schema-Status", () {
    unittest.test("to-json--from-json", () {
      var o = buildStatus();
      var od = new api.Status.fromJson(o.toJson());
      checkStatus(od);
    });
  });

  unittest.group("obj-schema-TextEnrichment", () {
    unittest.test("to-json--from-json", () {
      var o = buildTextEnrichment();
      var od = new api.TextEnrichment.fromJson(o.toJson());
      checkTextEnrichment(od);
    });
  });

  unittest.group("obj-schema-Video", () {
    unittest.test("to-json--from-json", () {
      var o = buildVideo();
      var od = new api.Video.fromJson(o.toJson());
      checkVideo(od);
    });
  });

  unittest.group("resource-AlbumsResourceApi", () {
    unittest.test("method--addEnrichment", () {
      var mock = new HttpServerMock();
      api.AlbumsResourceApi res = new api.PhotoslibraryApi(mock).albums;
      var arg_request = buildAddEnrichmentToAlbumRequest();
      var arg_albumId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.AddEnrichmentToAlbumRequest.fromJson(json);
        checkAddEnrichmentToAlbumRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 10),
            unittest.equals("v1/albums/"));
        pathOffset += 10;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }

        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildAddEnrichmentToAlbumResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .addEnrichment(arg_request, arg_albumId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAddEnrichmentToAlbumResponse(response);
      })));
    });

    unittest.test("method--create", () {
      var mock = new HttpServerMock();
      api.AlbumsResourceApi res = new api.PhotoslibraryApi(mock).albums;
      var arg_request = buildCreateAlbumRequest();
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.CreateAlbumRequest.fromJson(json);
        checkCreateAlbumRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("v1/albums"));
        pathOffset += 9;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }

        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildAlbum());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .create(arg_request, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAlbum(response);
      })));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.AlbumsResourceApi res = new api.PhotoslibraryApi(mock).albums;
      var arg_albumId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 10),
            unittest.equals("v1/albums/"));
        pathOffset += 10;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }

        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildAlbum());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_albumId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAlbum(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AlbumsResourceApi res = new api.PhotoslibraryApi(mock).albums;
      var arg_pageSize = 42;
      var arg_pageToken = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("v1/albums"));
        pathOffset += 9;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }

        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(core.int.parse(queryMap["pageSize"].first),
            unittest.equals(arg_pageSize));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildListAlbumsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(
              pageSize: arg_pageSize,
              pageToken: arg_pageToken,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkListAlbumsResponse(response);
      })));
    });

    unittest.test("method--share", () {
      var mock = new HttpServerMock();
      api.AlbumsResourceApi res = new api.PhotoslibraryApi(mock).albums;
      var arg_request = buildShareAlbumRequest();
      var arg_albumId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.ShareAlbumRequest.fromJson(json);
        checkShareAlbumRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 10),
            unittest.equals("v1/albums/"));
        pathOffset += 10;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }

        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildShareAlbumResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .share(arg_request, arg_albumId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkShareAlbumResponse(response);
      })));
    });
  });

  unittest.group("resource-MediaItemsResourceApi", () {
    unittest.test("method--batchCreate", () {
      var mock = new HttpServerMock();
      api.MediaItemsResourceApi res = new api.PhotoslibraryApi(mock).mediaItems;
      var arg_request = buildBatchCreateMediaItemsRequest();
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.BatchCreateMediaItemsRequest.fromJson(json);
        checkBatchCreateMediaItemsRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 25),
            unittest.equals("v1/mediaItems:batchCreate"));
        pathOffset += 25;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }

        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildBatchCreateMediaItemsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .batchCreate(arg_request, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkBatchCreateMediaItemsResponse(response);
      })));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.MediaItemsResourceApi res = new api.PhotoslibraryApi(mock).mediaItems;
      var arg_mediaItemId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 14),
            unittest.equals("v1/mediaItems/"));
        pathOffset += 14;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }

        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildMediaItem());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_mediaItemId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkMediaItem(response);
      })));
    });

    unittest.test("method--search", () {
      var mock = new HttpServerMock();
      api.MediaItemsResourceApi res = new api.PhotoslibraryApi(mock).mediaItems;
      var arg_request = buildSearchMediaItemsRequest();
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.SearchMediaItemsRequest.fromJson(json);
        checkSearchMediaItemsRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 20),
            unittest.equals("v1/mediaItems:search"));
        pathOffset += 20;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }

        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildSearchMediaItemsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .search(arg_request, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkSearchMediaItemsResponse(response);
      })));
    });
  });

  unittest.group("resource-SharedAlbumsResourceApi", () {
    unittest.test("method--join", () {
      var mock = new HttpServerMock();
      api.SharedAlbumsResourceApi res =
          new api.PhotoslibraryApi(mock).sharedAlbums;
      var arg_request = buildJoinSharedAlbumRequest();
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.JoinSharedAlbumRequest.fromJson(json);
        checkJoinSharedAlbumRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 20),
            unittest.equals("v1/sharedAlbums:join"));
        pathOffset += 20;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }

        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildJoinSharedAlbumResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .join(arg_request, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkJoinSharedAlbumResponse(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.SharedAlbumsResourceApi res =
          new api.PhotoslibraryApi(mock).sharedAlbums;
      var arg_pageSize = 42;
      var arg_pageToken = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 15),
            unittest.equals("v1/sharedAlbums"));
        pathOffset += 15;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }

        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]),
                core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(core.int.parse(queryMap["pageSize"].first),
            unittest.equals(arg_pageSize));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildListSharedAlbumsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(
              pageSize: arg_pageSize,
              pageToken: arg_pageToken,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkListSharedAlbumsResponse(response);
      })));
    });
  });
}
