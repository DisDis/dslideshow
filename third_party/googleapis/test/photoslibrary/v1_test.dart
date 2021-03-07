// ignore_for_file: avoid_returning_null
// ignore_for_file: camel_case_types
// ignore_for_file: cascade_invocations
// ignore_for_file: comment_references
// ignore_for_file: file_names
// ignore_for_file: library_names
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: prefer_final_locals
// ignore_for_file: prefer_interpolation_to_compose_strings
// ignore_for_file: prefer_single_quotes
// ignore_for_file: unnecessary_brace_in_string_interps
// ignore_for_file: unnecessary_cast
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: unnecessary_string_interpolations
// ignore_for_file: unused_local_variable

import 'dart:async' as async;
import 'dart:convert' as convert;
import 'dart:core' as core;

import 'package:http/http.dart' as http;
import 'package:test/test.dart' as unittest;
import 'package:googleapis/photoslibrary/v1.dart' as api;

import '../test_shared.dart';

core.int buildCounterAddEnrichmentToAlbumRequest = 0;
api.AddEnrichmentToAlbumRequest buildAddEnrichmentToAlbumRequest() {
  var o = api.AddEnrichmentToAlbumRequest();
  buildCounterAddEnrichmentToAlbumRequest++;
  if (buildCounterAddEnrichmentToAlbumRequest < 3) {
    o.albumPosition = buildAlbumPosition();
    o.newEnrichmentItem = buildNewEnrichmentItem();
  }
  buildCounterAddEnrichmentToAlbumRequest--;
  return o;
}

void checkAddEnrichmentToAlbumRequest(api.AddEnrichmentToAlbumRequest o) {
  buildCounterAddEnrichmentToAlbumRequest++;
  if (buildCounterAddEnrichmentToAlbumRequest < 3) {
    checkAlbumPosition(o.albumPosition! as api.AlbumPosition);
    checkNewEnrichmentItem(o.newEnrichmentItem! as api.NewEnrichmentItem);
  }
  buildCounterAddEnrichmentToAlbumRequest--;
}

core.int buildCounterAddEnrichmentToAlbumResponse = 0;
api.AddEnrichmentToAlbumResponse buildAddEnrichmentToAlbumResponse() {
  var o = api.AddEnrichmentToAlbumResponse();
  buildCounterAddEnrichmentToAlbumResponse++;
  if (buildCounterAddEnrichmentToAlbumResponse < 3) {
    o.enrichmentItem = buildEnrichmentItem();
  }
  buildCounterAddEnrichmentToAlbumResponse--;
  return o;
}

void checkAddEnrichmentToAlbumResponse(api.AddEnrichmentToAlbumResponse o) {
  buildCounterAddEnrichmentToAlbumResponse++;
  if (buildCounterAddEnrichmentToAlbumResponse < 3) {
    checkEnrichmentItem(o.enrichmentItem! as api.EnrichmentItem);
  }
  buildCounterAddEnrichmentToAlbumResponse--;
}

core.int buildCounterAlbum = 0;
api.Album buildAlbum() {
  var o = api.Album();
  buildCounterAlbum++;
  if (buildCounterAlbum < 3) {
    o.coverPhotoBaseUrl = 'foo';
    o.id = 'foo';
    o.isWriteable = true;
    o.productUrl = 'foo';
    o.shareInfo = buildShareInfo();
    o.title = 'foo';
    o.totalMediaItems = 'foo';
  }
  buildCounterAlbum--;
  return o;
}

void checkAlbum(api.Album o) {
  buildCounterAlbum++;
  if (buildCounterAlbum < 3) {
    unittest.expect(
      o.coverPhotoBaseUrl!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.id!,
      unittest.equals('foo'),
    );
    unittest.expect(o.isWriteable!, unittest.isTrue);
    unittest.expect(
      o.productUrl!,
      unittest.equals('foo'),
    );
    checkShareInfo(o.shareInfo! as api.ShareInfo);
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.totalMediaItems!,
      unittest.equals('foo'),
    );
  }
  buildCounterAlbum--;
}

core.int buildCounterAlbumPosition = 0;
api.AlbumPosition buildAlbumPosition() {
  var o = api.AlbumPosition();
  buildCounterAlbumPosition++;
  if (buildCounterAlbumPosition < 3) {
    o.position = 'foo';
    o.relativeEnrichmentItemId = 'foo';
    o.relativeMediaItemId = 'foo';
  }
  buildCounterAlbumPosition--;
  return o;
}

void checkAlbumPosition(api.AlbumPosition o) {
  buildCounterAlbumPosition++;
  if (buildCounterAlbumPosition < 3) {
    unittest.expect(
      o.position!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.relativeEnrichmentItemId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.relativeMediaItemId!,
      unittest.equals('foo'),
    );
  }
  buildCounterAlbumPosition--;
}

core.List<api.NewMediaItem> buildUnnamed3132() {
  var o = <api.NewMediaItem>[];
  o.add(buildNewMediaItem());
  o.add(buildNewMediaItem());
  return o;
}

void checkUnnamed3132(core.List<api.NewMediaItem> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkNewMediaItem(o[0] as api.NewMediaItem);
  checkNewMediaItem(o[1] as api.NewMediaItem);
}

core.int buildCounterBatchCreateMediaItemsRequest = 0;
api.BatchCreateMediaItemsRequest buildBatchCreateMediaItemsRequest() {
  var o = api.BatchCreateMediaItemsRequest();
  buildCounterBatchCreateMediaItemsRequest++;
  if (buildCounterBatchCreateMediaItemsRequest < 3) {
    o.albumId = 'foo';
    o.albumPosition = buildAlbumPosition();
    o.newMediaItems = buildUnnamed3132();
  }
  buildCounterBatchCreateMediaItemsRequest--;
  return o;
}

void checkBatchCreateMediaItemsRequest(api.BatchCreateMediaItemsRequest o) {
  buildCounterBatchCreateMediaItemsRequest++;
  if (buildCounterBatchCreateMediaItemsRequest < 3) {
    unittest.expect(
      o.albumId!,
      unittest.equals('foo'),
    );
    checkAlbumPosition(o.albumPosition! as api.AlbumPosition);
    checkUnnamed3132(o.newMediaItems!);
  }
  buildCounterBatchCreateMediaItemsRequest--;
}

core.List<api.NewMediaItemResult> buildUnnamed3133() {
  var o = <api.NewMediaItemResult>[];
  o.add(buildNewMediaItemResult());
  o.add(buildNewMediaItemResult());
  return o;
}

void checkUnnamed3133(core.List<api.NewMediaItemResult> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkNewMediaItemResult(o[0] as api.NewMediaItemResult);
  checkNewMediaItemResult(o[1] as api.NewMediaItemResult);
}

core.int buildCounterBatchCreateMediaItemsResponse = 0;
api.BatchCreateMediaItemsResponse buildBatchCreateMediaItemsResponse() {
  var o = api.BatchCreateMediaItemsResponse();
  buildCounterBatchCreateMediaItemsResponse++;
  if (buildCounterBatchCreateMediaItemsResponse < 3) {
    o.newMediaItemResults = buildUnnamed3133();
  }
  buildCounterBatchCreateMediaItemsResponse--;
  return o;
}

void checkBatchCreateMediaItemsResponse(api.BatchCreateMediaItemsResponse o) {
  buildCounterBatchCreateMediaItemsResponse++;
  if (buildCounterBatchCreateMediaItemsResponse < 3) {
    checkUnnamed3133(o.newMediaItemResults!);
  }
  buildCounterBatchCreateMediaItemsResponse--;
}

core.List<core.String> buildUnnamed3134() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3134(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(
    o[0],
    unittest.equals('foo'),
  );
  unittest.expect(
    o[1],
    unittest.equals('foo'),
  );
}

core.List<core.String> buildUnnamed3135() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3135(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(
    o[0],
    unittest.equals('foo'),
  );
  unittest.expect(
    o[1],
    unittest.equals('foo'),
  );
}

core.int buildCounterContentFilter = 0;
api.ContentFilter buildContentFilter() {
  var o = api.ContentFilter();
  buildCounterContentFilter++;
  if (buildCounterContentFilter < 3) {
    o.excludedContentCategories = buildUnnamed3134();
    o.includedContentCategories = buildUnnamed3135();
  }
  buildCounterContentFilter--;
  return o;
}

void checkContentFilter(api.ContentFilter o) {
  buildCounterContentFilter++;
  if (buildCounterContentFilter < 3) {
    checkUnnamed3134(o.excludedContentCategories!);
    checkUnnamed3135(o.includedContentCategories!);
  }
  buildCounterContentFilter--;
}

core.int buildCounterContributorInfo = 0;
api.ContributorInfo buildContributorInfo() {
  var o = api.ContributorInfo();
  buildCounterContributorInfo++;
  if (buildCounterContributorInfo < 3) {
    o.displayName = 'foo';
    o.profilePictureBaseUrl = 'foo';
  }
  buildCounterContributorInfo--;
  return o;
}

void checkContributorInfo(api.ContributorInfo o) {
  buildCounterContributorInfo++;
  if (buildCounterContributorInfo < 3) {
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.profilePictureBaseUrl!,
      unittest.equals('foo'),
    );
  }
  buildCounterContributorInfo--;
}

core.int buildCounterCreateAlbumRequest = 0;
api.CreateAlbumRequest buildCreateAlbumRequest() {
  var o = api.CreateAlbumRequest();
  buildCounterCreateAlbumRequest++;
  if (buildCounterCreateAlbumRequest < 3) {
    o.album = buildAlbum();
  }
  buildCounterCreateAlbumRequest--;
  return o;
}

void checkCreateAlbumRequest(api.CreateAlbumRequest o) {
  buildCounterCreateAlbumRequest++;
  if (buildCounterCreateAlbumRequest < 3) {
    checkAlbum(o.album! as api.Album);
  }
  buildCounterCreateAlbumRequest--;
}

core.int buildCounterDate = 0;
api.Date buildDate() {
  var o = api.Date();
  buildCounterDate++;
  if (buildCounterDate < 3) {
    o.day = 42;
    o.month = 42;
    o.year = 42;
  }
  buildCounterDate--;
  return o;
}

void checkDate(api.Date o) {
  buildCounterDate++;
  if (buildCounterDate < 3) {
    unittest.expect(
      o.day!,
      unittest.equals(42),
    );
    unittest.expect(
      o.month!,
      unittest.equals(42),
    );
    unittest.expect(
      o.year!,
      unittest.equals(42),
    );
  }
  buildCounterDate--;
}

core.List<api.Date> buildUnnamed3136() {
  var o = <api.Date>[];
  o.add(buildDate());
  o.add(buildDate());
  return o;
}

void checkUnnamed3136(core.List<api.Date> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDate(o[0] as api.Date);
  checkDate(o[1] as api.Date);
}

core.List<api.DateRange> buildUnnamed3137() {
  var o = <api.DateRange>[];
  o.add(buildDateRange());
  o.add(buildDateRange());
  return o;
}

void checkUnnamed3137(core.List<api.DateRange> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDateRange(o[0] as api.DateRange);
  checkDateRange(o[1] as api.DateRange);
}

core.int buildCounterDateFilter = 0;
api.DateFilter buildDateFilter() {
  var o = api.DateFilter();
  buildCounterDateFilter++;
  if (buildCounterDateFilter < 3) {
    o.dates = buildUnnamed3136();
    o.ranges = buildUnnamed3137();
  }
  buildCounterDateFilter--;
  return o;
}

void checkDateFilter(api.DateFilter o) {
  buildCounterDateFilter++;
  if (buildCounterDateFilter < 3) {
    checkUnnamed3136(o.dates!);
    checkUnnamed3137(o.ranges!);
  }
  buildCounterDateFilter--;
}

core.int buildCounterDateRange = 0;
api.DateRange buildDateRange() {
  var o = api.DateRange();
  buildCounterDateRange++;
  if (buildCounterDateRange < 3) {
    o.endDate = buildDate();
    o.startDate = buildDate();
  }
  buildCounterDateRange--;
  return o;
}

void checkDateRange(api.DateRange o) {
  buildCounterDateRange++;
  if (buildCounterDateRange < 3) {
    checkDate(o.endDate! as api.Date);
    checkDate(o.startDate! as api.Date);
  }
  buildCounterDateRange--;
}

core.int buildCounterEnrichmentItem = 0;
api.EnrichmentItem buildEnrichmentItem() {
  var o = api.EnrichmentItem();
  buildCounterEnrichmentItem++;
  if (buildCounterEnrichmentItem < 3) {
    o.id = 'foo';
  }
  buildCounterEnrichmentItem--;
  return o;
}

void checkEnrichmentItem(api.EnrichmentItem o) {
  buildCounterEnrichmentItem++;
  if (buildCounterEnrichmentItem < 3) {
    unittest.expect(
      o.id!,
      unittest.equals('foo'),
    );
  }
  buildCounterEnrichmentItem--;
}

core.int buildCounterFilters = 0;
api.Filters buildFilters() {
  var o = api.Filters();
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

void checkFilters(api.Filters o) {
  buildCounterFilters++;
  if (buildCounterFilters < 3) {
    checkContentFilter(o.contentFilter! as api.ContentFilter);
    checkDateFilter(o.dateFilter! as api.DateFilter);
    unittest.expect(o.includeArchivedMedia!, unittest.isTrue);
    checkMediaTypeFilter(o.mediaTypeFilter! as api.MediaTypeFilter);
  }
  buildCounterFilters--;
}

core.int buildCounterJoinSharedAlbumRequest = 0;
api.JoinSharedAlbumRequest buildJoinSharedAlbumRequest() {
  var o = api.JoinSharedAlbumRequest();
  buildCounterJoinSharedAlbumRequest++;
  if (buildCounterJoinSharedAlbumRequest < 3) {
    o.shareToken = 'foo';
  }
  buildCounterJoinSharedAlbumRequest--;
  return o;
}

void checkJoinSharedAlbumRequest(api.JoinSharedAlbumRequest o) {
  buildCounterJoinSharedAlbumRequest++;
  if (buildCounterJoinSharedAlbumRequest < 3) {
    unittest.expect(
      o.shareToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterJoinSharedAlbumRequest--;
}

core.int buildCounterJoinSharedAlbumResponse = 0;
api.JoinSharedAlbumResponse buildJoinSharedAlbumResponse() {
  var o = api.JoinSharedAlbumResponse();
  buildCounterJoinSharedAlbumResponse++;
  if (buildCounterJoinSharedAlbumResponse < 3) {}
  buildCounterJoinSharedAlbumResponse--;
  return o;
}

void checkJoinSharedAlbumResponse(api.JoinSharedAlbumResponse o) {
  buildCounterJoinSharedAlbumResponse++;
  if (buildCounterJoinSharedAlbumResponse < 3) {}
  buildCounterJoinSharedAlbumResponse--;
}

core.int buildCounterLatLng = 0;
api.LatLng buildLatLng() {
  var o = api.LatLng();
  buildCounterLatLng++;
  if (buildCounterLatLng < 3) {
    o.latitude = 42.0;
    o.longitude = 42.0;
  }
  buildCounterLatLng--;
  return o;
}

void checkLatLng(api.LatLng o) {
  buildCounterLatLng++;
  if (buildCounterLatLng < 3) {
    unittest.expect(
      o.latitude!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.longitude!,
      unittest.equals(42.0),
    );
  }
  buildCounterLatLng--;
}

core.List<api.Album> buildUnnamed3138() {
  var o = <api.Album>[];
  o.add(buildAlbum());
  o.add(buildAlbum());
  return o;
}

void checkUnnamed3138(core.List<api.Album> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAlbum(o[0] as api.Album);
  checkAlbum(o[1] as api.Album);
}

core.int buildCounterListAlbumsResponse = 0;
api.ListAlbumsResponse buildListAlbumsResponse() {
  var o = api.ListAlbumsResponse();
  buildCounterListAlbumsResponse++;
  if (buildCounterListAlbumsResponse < 3) {
    o.albums = buildUnnamed3138();
    o.nextPageToken = 'foo';
  }
  buildCounterListAlbumsResponse--;
  return o;
}

void checkListAlbumsResponse(api.ListAlbumsResponse o) {
  buildCounterListAlbumsResponse++;
  if (buildCounterListAlbumsResponse < 3) {
    checkUnnamed3138(o.albums!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterListAlbumsResponse--;
}

core.List<api.Album> buildUnnamed3139() {
  var o = <api.Album>[];
  o.add(buildAlbum());
  o.add(buildAlbum());
  return o;
}

void checkUnnamed3139(core.List<api.Album> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAlbum(o[0] as api.Album);
  checkAlbum(o[1] as api.Album);
}

core.int buildCounterListSharedAlbumsResponse = 0;
api.ListSharedAlbumsResponse buildListSharedAlbumsResponse() {
  var o = api.ListSharedAlbumsResponse();
  buildCounterListSharedAlbumsResponse++;
  if (buildCounterListSharedAlbumsResponse < 3) {
    o.nextPageToken = 'foo';
    o.sharedAlbums = buildUnnamed3139();
  }
  buildCounterListSharedAlbumsResponse--;
  return o;
}

void checkListSharedAlbumsResponse(api.ListSharedAlbumsResponse o) {
  buildCounterListSharedAlbumsResponse++;
  if (buildCounterListSharedAlbumsResponse < 3) {
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
    checkUnnamed3139(o.sharedAlbums!);
  }
  buildCounterListSharedAlbumsResponse--;
}

core.int buildCounterLocation = 0;
api.Location buildLocation() {
  var o = api.Location();
  buildCounterLocation++;
  if (buildCounterLocation < 3) {
    o.latlng = buildLatLng();
    o.locationName = 'foo';
  }
  buildCounterLocation--;
  return o;
}

void checkLocation(api.Location o) {
  buildCounterLocation++;
  if (buildCounterLocation < 3) {
    checkLatLng(o.latlng! as api.LatLng);
    unittest.expect(
      o.locationName!,
      unittest.equals('foo'),
    );
  }
  buildCounterLocation--;
}

core.int buildCounterLocationEnrichment = 0;
api.LocationEnrichment buildLocationEnrichment() {
  var o = api.LocationEnrichment();
  buildCounterLocationEnrichment++;
  if (buildCounterLocationEnrichment < 3) {
    o.location = buildLocation();
  }
  buildCounterLocationEnrichment--;
  return o;
}

void checkLocationEnrichment(api.LocationEnrichment o) {
  buildCounterLocationEnrichment++;
  if (buildCounterLocationEnrichment < 3) {
    checkLocation(o.location! as api.Location);
  }
  buildCounterLocationEnrichment--;
}

core.int buildCounterMapEnrichment = 0;
api.MapEnrichment buildMapEnrichment() {
  var o = api.MapEnrichment();
  buildCounterMapEnrichment++;
  if (buildCounterMapEnrichment < 3) {
    o.destination = buildLocation();
    o.origin = buildLocation();
  }
  buildCounterMapEnrichment--;
  return o;
}

void checkMapEnrichment(api.MapEnrichment o) {
  buildCounterMapEnrichment++;
  if (buildCounterMapEnrichment < 3) {
    checkLocation(o.destination! as api.Location);
    checkLocation(o.origin! as api.Location);
  }
  buildCounterMapEnrichment--;
}

core.int buildCounterMediaItem = 0;
api.MediaItem buildMediaItem() {
  var o = api.MediaItem();
  buildCounterMediaItem++;
  if (buildCounterMediaItem < 3) {
    o.baseUrl = 'foo';
    o.contributorInfo = buildContributorInfo();
    o.description = 'foo';
    o.id = 'foo';
    o.mediaMetadata = buildMediaMetadata();
    o.mimeType = 'foo';
    o.productUrl = 'foo';
  }
  buildCounterMediaItem--;
  return o;
}

void checkMediaItem(api.MediaItem o) {
  buildCounterMediaItem++;
  if (buildCounterMediaItem < 3) {
    unittest.expect(
      o.baseUrl!,
      unittest.equals('foo'),
    );
    checkContributorInfo(o.contributorInfo! as api.ContributorInfo);
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.id!,
      unittest.equals('foo'),
    );
    checkMediaMetadata(o.mediaMetadata! as api.MediaMetadata);
    unittest.expect(
      o.mimeType!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.productUrl!,
      unittest.equals('foo'),
    );
  }
  buildCounterMediaItem--;
}

core.int buildCounterMediaMetadata = 0;
api.MediaMetadata buildMediaMetadata() {
  var o = api.MediaMetadata();
  buildCounterMediaMetadata++;
  if (buildCounterMediaMetadata < 3) {
    o.creationTime = 'foo';
    o.height = 'foo';
    o.photo = buildPhoto();
    o.video = buildVideo();
    o.width = 'foo';
  }
  buildCounterMediaMetadata--;
  return o;
}

void checkMediaMetadata(api.MediaMetadata o) {
  buildCounterMediaMetadata++;
  if (buildCounterMediaMetadata < 3) {
    unittest.expect(
      o.creationTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.height!,
      unittest.equals('foo'),
    );
    checkPhoto(o.photo! as api.Photo);
    checkVideo(o.video! as api.Video);
    unittest.expect(
      o.width!,
      unittest.equals('foo'),
    );
  }
  buildCounterMediaMetadata--;
}

core.List<core.String> buildUnnamed3140() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3140(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(
    o[0],
    unittest.equals('foo'),
  );
  unittest.expect(
    o[1],
    unittest.equals('foo'),
  );
}

core.int buildCounterMediaTypeFilter = 0;
api.MediaTypeFilter buildMediaTypeFilter() {
  var o = api.MediaTypeFilter();
  buildCounterMediaTypeFilter++;
  if (buildCounterMediaTypeFilter < 3) {
    o.mediaTypes = buildUnnamed3140();
  }
  buildCounterMediaTypeFilter--;
  return o;
}

void checkMediaTypeFilter(api.MediaTypeFilter o) {
  buildCounterMediaTypeFilter++;
  if (buildCounterMediaTypeFilter < 3) {
    checkUnnamed3140(o.mediaTypes!);
  }
  buildCounterMediaTypeFilter--;
}

core.int buildCounterNewEnrichmentItem = 0;
api.NewEnrichmentItem buildNewEnrichmentItem() {
  var o = api.NewEnrichmentItem();
  buildCounterNewEnrichmentItem++;
  if (buildCounterNewEnrichmentItem < 3) {
    o.locationEnrichment = buildLocationEnrichment();
    o.mapEnrichment = buildMapEnrichment();
    o.textEnrichment = buildTextEnrichment();
  }
  buildCounterNewEnrichmentItem--;
  return o;
}

void checkNewEnrichmentItem(api.NewEnrichmentItem o) {
  buildCounterNewEnrichmentItem++;
  if (buildCounterNewEnrichmentItem < 3) {
    checkLocationEnrichment(o.locationEnrichment! as api.LocationEnrichment);
    checkMapEnrichment(o.mapEnrichment! as api.MapEnrichment);
    checkTextEnrichment(o.textEnrichment! as api.TextEnrichment);
  }
  buildCounterNewEnrichmentItem--;
}

core.int buildCounterNewMediaItem = 0;
api.NewMediaItem buildNewMediaItem() {
  var o = api.NewMediaItem();
  buildCounterNewMediaItem++;
  if (buildCounterNewMediaItem < 3) {
    o.description = 'foo';
    o.simpleMediaItem = buildSimpleMediaItem();
  }
  buildCounterNewMediaItem--;
  return o;
}

void checkNewMediaItem(api.NewMediaItem o) {
  buildCounterNewMediaItem++;
  if (buildCounterNewMediaItem < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    checkSimpleMediaItem(o.simpleMediaItem! as api.SimpleMediaItem);
  }
  buildCounterNewMediaItem--;
}

core.int buildCounterNewMediaItemResult = 0;
api.NewMediaItemResult buildNewMediaItemResult() {
  var o = api.NewMediaItemResult();
  buildCounterNewMediaItemResult++;
  if (buildCounterNewMediaItemResult < 3) {
    o.mediaItem = buildMediaItem();
    o.status = buildStatus();
    o.uploadToken = 'foo';
  }
  buildCounterNewMediaItemResult--;
  return o;
}

void checkNewMediaItemResult(api.NewMediaItemResult o) {
  buildCounterNewMediaItemResult++;
  if (buildCounterNewMediaItemResult < 3) {
    checkMediaItem(o.mediaItem! as api.MediaItem);
    checkStatus(o.status! as api.Status);
    unittest.expect(
      o.uploadToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterNewMediaItemResult--;
}

core.int buildCounterPhoto = 0;
api.Photo buildPhoto() {
  var o = api.Photo();
  buildCounterPhoto++;
  if (buildCounterPhoto < 3) {
    o.apertureFNumber = 42.0;
    o.cameraMake = 'foo';
    o.cameraModel = 'foo';
    o.exposureTime = 'foo';
    o.focalLength = 42.0;
    o.isoEquivalent = 42;
  }
  buildCounterPhoto--;
  return o;
}

void checkPhoto(api.Photo o) {
  buildCounterPhoto++;
  if (buildCounterPhoto < 3) {
    unittest.expect(
      o.apertureFNumber!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.cameraMake!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.cameraModel!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.exposureTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.focalLength!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.isoEquivalent!,
      unittest.equals(42),
    );
  }
  buildCounterPhoto--;
}

core.int buildCounterSearchMediaItemsRequest = 0;
api.SearchMediaItemsRequest buildSearchMediaItemsRequest() {
  var o = api.SearchMediaItemsRequest();
  buildCounterSearchMediaItemsRequest++;
  if (buildCounterSearchMediaItemsRequest < 3) {
    o.albumId = 'foo';
    o.filters = buildFilters();
    o.pageSize = 42;
    o.pageToken = 'foo';
  }
  buildCounterSearchMediaItemsRequest--;
  return o;
}

void checkSearchMediaItemsRequest(api.SearchMediaItemsRequest o) {
  buildCounterSearchMediaItemsRequest++;
  if (buildCounterSearchMediaItemsRequest < 3) {
    unittest.expect(
      o.albumId!,
      unittest.equals('foo'),
    );
    checkFilters(o.filters! as api.Filters);
    unittest.expect(
      o.pageSize!,
      unittest.equals(42),
    );
    unittest.expect(
      o.pageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterSearchMediaItemsRequest--;
}

core.List<api.MediaItem> buildUnnamed3141() {
  var o = <api.MediaItem>[];
  o.add(buildMediaItem());
  o.add(buildMediaItem());
  return o;
}

void checkUnnamed3141(core.List<api.MediaItem> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMediaItem(o[0] as api.MediaItem);
  checkMediaItem(o[1] as api.MediaItem);
}

core.int buildCounterSearchMediaItemsResponse = 0;
api.SearchMediaItemsResponse buildSearchMediaItemsResponse() {
  var o = api.SearchMediaItemsResponse();
  buildCounterSearchMediaItemsResponse++;
  if (buildCounterSearchMediaItemsResponse < 3) {
    o.mediaItems = buildUnnamed3141();
    o.nextPageToken = 'foo';
  }
  buildCounterSearchMediaItemsResponse--;
  return o;
}

void checkSearchMediaItemsResponse(api.SearchMediaItemsResponse o) {
  buildCounterSearchMediaItemsResponse++;
  if (buildCounterSearchMediaItemsResponse < 3) {
    checkUnnamed3141(o.mediaItems!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterSearchMediaItemsResponse--;
}

core.int buildCounterShareAlbumRequest = 0;
api.ShareAlbumRequest buildShareAlbumRequest() {
  var o = api.ShareAlbumRequest();
  buildCounterShareAlbumRequest++;
  if (buildCounterShareAlbumRequest < 3) {
    o.sharedAlbumOptions = buildSharedAlbumOptions();
  }
  buildCounterShareAlbumRequest--;
  return o;
}

void checkShareAlbumRequest(api.ShareAlbumRequest o) {
  buildCounterShareAlbumRequest++;
  if (buildCounterShareAlbumRequest < 3) {
    checkSharedAlbumOptions(o.sharedAlbumOptions! as api.SharedAlbumOptions);
  }
  buildCounterShareAlbumRequest--;
}

core.int buildCounterShareAlbumResponse = 0;
api.ShareAlbumResponse buildShareAlbumResponse() {
  var o = api.ShareAlbumResponse();
  buildCounterShareAlbumResponse++;
  if (buildCounterShareAlbumResponse < 3) {
    o.shareInfo = buildShareInfo();
  }
  buildCounterShareAlbumResponse--;
  return o;
}

void checkShareAlbumResponse(api.ShareAlbumResponse o) {
  buildCounterShareAlbumResponse++;
  if (buildCounterShareAlbumResponse < 3) {
    checkShareInfo(o.shareInfo! as api.ShareInfo);
  }
  buildCounterShareAlbumResponse--;
}

core.int buildCounterShareInfo = 0;
api.ShareInfo buildShareInfo() {
  var o = api.ShareInfo();
  buildCounterShareInfo++;
  if (buildCounterShareInfo < 3) {
    o.shareToken = 'foo';
    o.shareableUrl = 'foo';
    o.sharedAlbumOptions = buildSharedAlbumOptions();
  }
  buildCounterShareInfo--;
  return o;
}

void checkShareInfo(api.ShareInfo o) {
  buildCounterShareInfo++;
  if (buildCounterShareInfo < 3) {
    unittest.expect(
      o.shareToken!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.shareableUrl!,
      unittest.equals('foo'),
    );
    checkSharedAlbumOptions(o.sharedAlbumOptions! as api.SharedAlbumOptions);
  }
  buildCounterShareInfo--;
}

core.int buildCounterSharedAlbumOptions = 0;
api.SharedAlbumOptions buildSharedAlbumOptions() {
  var o = api.SharedAlbumOptions();
  buildCounterSharedAlbumOptions++;
  if (buildCounterSharedAlbumOptions < 3) {
    o.isCollaborative = true;
    o.isCommentable = true;
  }
  buildCounterSharedAlbumOptions--;
  return o;
}

void checkSharedAlbumOptions(api.SharedAlbumOptions o) {
  buildCounterSharedAlbumOptions++;
  if (buildCounterSharedAlbumOptions < 3) {
    unittest.expect(o.isCollaborative!, unittest.isTrue);
    unittest.expect(o.isCommentable!, unittest.isTrue);
  }
  buildCounterSharedAlbumOptions--;
}

core.int buildCounterSimpleMediaItem = 0;
api.SimpleMediaItem buildSimpleMediaItem() {
  var o = api.SimpleMediaItem();
  buildCounterSimpleMediaItem++;
  if (buildCounterSimpleMediaItem < 3) {
    o.uploadToken = 'foo';
  }
  buildCounterSimpleMediaItem--;
  return o;
}

void checkSimpleMediaItem(api.SimpleMediaItem o) {
  buildCounterSimpleMediaItem++;
  if (buildCounterSimpleMediaItem < 3) {
    unittest.expect(
      o.uploadToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterSimpleMediaItem--;
}

core.Map<core.String, core.Object> buildUnnamed3142() {
  var o = <core.String, core.Object>{};
  o['x'] = {
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  };
  o['y'] = {
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  };
  return o;
}

void checkUnnamed3142(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted1 = (o['x']!) as core.Map;
  unittest.expect(casted1, unittest.hasLength(3));
  unittest.expect(
    casted1['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted1['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted1['string'],
    unittest.equals('foo'),
  );
  var casted2 = (o['y']!) as core.Map;
  unittest.expect(casted2, unittest.hasLength(3));
  unittest.expect(
    casted2['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted2['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted2['string'],
    unittest.equals('foo'),
  );
}

core.List<core.Map<core.String, core.Object>> buildUnnamed3143() {
  var o = <core.Map<core.String, core.Object>>[];
  o.add(buildUnnamed3142());
  o.add(buildUnnamed3142());
  return o;
}

void checkUnnamed3143(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed3142(o[0]);
  checkUnnamed3142(o[1]);
}

core.int buildCounterStatus = 0;
api.Status buildStatus() {
  var o = api.Status();
  buildCounterStatus++;
  if (buildCounterStatus < 3) {
    o.code = 42;
    o.details = buildUnnamed3143();
    o.message = 'foo';
  }
  buildCounterStatus--;
  return o;
}

void checkStatus(api.Status o) {
  buildCounterStatus++;
  if (buildCounterStatus < 3) {
    unittest.expect(
      o.code!,
      unittest.equals(42),
    );
    checkUnnamed3143(o.details!);
    unittest.expect(
      o.message!,
      unittest.equals('foo'),
    );
  }
  buildCounterStatus--;
}

core.int buildCounterTextEnrichment = 0;
api.TextEnrichment buildTextEnrichment() {
  var o = api.TextEnrichment();
  buildCounterTextEnrichment++;
  if (buildCounterTextEnrichment < 3) {
    o.text = 'foo';
  }
  buildCounterTextEnrichment--;
  return o;
}

void checkTextEnrichment(api.TextEnrichment o) {
  buildCounterTextEnrichment++;
  if (buildCounterTextEnrichment < 3) {
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterTextEnrichment--;
}

core.int buildCounterVideo = 0;
api.Video buildVideo() {
  var o = api.Video();
  buildCounterVideo++;
  if (buildCounterVideo < 3) {
    o.cameraMake = 'foo';
    o.cameraModel = 'foo';
    o.fps = 42.0;
    o.status = 'foo';
  }
  buildCounterVideo--;
  return o;
}

void checkVideo(api.Video o) {
  buildCounterVideo++;
  if (buildCounterVideo < 3) {
    unittest.expect(
      o.cameraMake!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.cameraModel!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.fps!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.status!,
      unittest.equals('foo'),
    );
  }
  buildCounterVideo--;
}

void main() {
  unittest.group('obj-schema-AddEnrichmentToAlbumRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildAddEnrichmentToAlbumRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.AddEnrichmentToAlbumRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkAddEnrichmentToAlbumRequest(od as api.AddEnrichmentToAlbumRequest);
    });
  });

  unittest.group('obj-schema-AddEnrichmentToAlbumResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildAddEnrichmentToAlbumResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.AddEnrichmentToAlbumResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkAddEnrichmentToAlbumResponse(od as api.AddEnrichmentToAlbumResponse);
    });
  });

  unittest.group('obj-schema-Album', () {
    unittest.test('to-json--from-json', () async {
      var o = buildAlbum();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.Album.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkAlbum(od as api.Album);
    });
  });

  unittest.group('obj-schema-AlbumPosition', () {
    unittest.test('to-json--from-json', () async {
      var o = buildAlbumPosition();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.AlbumPosition.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkAlbumPosition(od as api.AlbumPosition);
    });
  });

  unittest.group('obj-schema-BatchCreateMediaItemsRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildBatchCreateMediaItemsRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.BatchCreateMediaItemsRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkBatchCreateMediaItemsRequest(od as api.BatchCreateMediaItemsRequest);
    });
  });

  unittest.group('obj-schema-BatchCreateMediaItemsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildBatchCreateMediaItemsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.BatchCreateMediaItemsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkBatchCreateMediaItemsResponse(
          od as api.BatchCreateMediaItemsResponse);
    });
  });

  unittest.group('obj-schema-ContentFilter', () {
    unittest.test('to-json--from-json', () async {
      var o = buildContentFilter();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ContentFilter.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkContentFilter(od as api.ContentFilter);
    });
  });

  unittest.group('obj-schema-ContributorInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildContributorInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ContributorInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkContributorInfo(od as api.ContributorInfo);
    });
  });

  unittest.group('obj-schema-CreateAlbumRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildCreateAlbumRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.CreateAlbumRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkCreateAlbumRequest(od as api.CreateAlbumRequest);
    });
  });

  unittest.group('obj-schema-Date', () {
    unittest.test('to-json--from-json', () async {
      var o = buildDate();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.Date.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkDate(od as api.Date);
    });
  });

  unittest.group('obj-schema-DateFilter', () {
    unittest.test('to-json--from-json', () async {
      var o = buildDateFilter();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.DateFilter.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkDateFilter(od as api.DateFilter);
    });
  });

  unittest.group('obj-schema-DateRange', () {
    unittest.test('to-json--from-json', () async {
      var o = buildDateRange();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.DateRange.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkDateRange(od as api.DateRange);
    });
  });

  unittest.group('obj-schema-EnrichmentItem', () {
    unittest.test('to-json--from-json', () async {
      var o = buildEnrichmentItem();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.EnrichmentItem.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkEnrichmentItem(od as api.EnrichmentItem);
    });
  });

  unittest.group('obj-schema-Filters', () {
    unittest.test('to-json--from-json', () async {
      var o = buildFilters();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Filters.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkFilters(od as api.Filters);
    });
  });

  unittest.group('obj-schema-JoinSharedAlbumRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildJoinSharedAlbumRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.JoinSharedAlbumRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkJoinSharedAlbumRequest(od as api.JoinSharedAlbumRequest);
    });
  });

  unittest.group('obj-schema-JoinSharedAlbumResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildJoinSharedAlbumResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.JoinSharedAlbumResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkJoinSharedAlbumResponse(od as api.JoinSharedAlbumResponse);
    });
  });

  unittest.group('obj-schema-LatLng', () {
    unittest.test('to-json--from-json', () async {
      var o = buildLatLng();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.LatLng.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkLatLng(od as api.LatLng);
    });
  });

  unittest.group('obj-schema-ListAlbumsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildListAlbumsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ListAlbumsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkListAlbumsResponse(od as api.ListAlbumsResponse);
    });
  });

  unittest.group('obj-schema-ListSharedAlbumsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildListSharedAlbumsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ListSharedAlbumsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkListSharedAlbumsResponse(od as api.ListSharedAlbumsResponse);
    });
  });

  unittest.group('obj-schema-Location', () {
    unittest.test('to-json--from-json', () async {
      var o = buildLocation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Location.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkLocation(od as api.Location);
    });
  });

  unittest.group('obj-schema-LocationEnrichment', () {
    unittest.test('to-json--from-json', () async {
      var o = buildLocationEnrichment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.LocationEnrichment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkLocationEnrichment(od as api.LocationEnrichment);
    });
  });

  unittest.group('obj-schema-MapEnrichment', () {
    unittest.test('to-json--from-json', () async {
      var o = buildMapEnrichment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.MapEnrichment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkMapEnrichment(od as api.MapEnrichment);
    });
  });

  unittest.group('obj-schema-MediaItem', () {
    unittest.test('to-json--from-json', () async {
      var o = buildMediaItem();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.MediaItem.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkMediaItem(od as api.MediaItem);
    });
  });

  unittest.group('obj-schema-MediaMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildMediaMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.MediaMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkMediaMetadata(od as api.MediaMetadata);
    });
  });

  unittest.group('obj-schema-MediaTypeFilter', () {
    unittest.test('to-json--from-json', () async {
      var o = buildMediaTypeFilter();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.MediaTypeFilter.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkMediaTypeFilter(od as api.MediaTypeFilter);
    });
  });

  unittest.group('obj-schema-NewEnrichmentItem', () {
    unittest.test('to-json--from-json', () async {
      var o = buildNewEnrichmentItem();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.NewEnrichmentItem.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkNewEnrichmentItem(od as api.NewEnrichmentItem);
    });
  });

  unittest.group('obj-schema-NewMediaItem', () {
    unittest.test('to-json--from-json', () async {
      var o = buildNewMediaItem();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.NewMediaItem.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkNewMediaItem(od as api.NewMediaItem);
    });
  });

  unittest.group('obj-schema-NewMediaItemResult', () {
    unittest.test('to-json--from-json', () async {
      var o = buildNewMediaItemResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.NewMediaItemResult.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkNewMediaItemResult(od as api.NewMediaItemResult);
    });
  });

  unittest.group('obj-schema-Photo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildPhoto();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.Photo.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkPhoto(od as api.Photo);
    });
  });

  unittest.group('obj-schema-SearchMediaItemsRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildSearchMediaItemsRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.SearchMediaItemsRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkSearchMediaItemsRequest(od as api.SearchMediaItemsRequest);
    });
  });

  unittest.group('obj-schema-SearchMediaItemsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildSearchMediaItemsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.SearchMediaItemsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkSearchMediaItemsResponse(od as api.SearchMediaItemsResponse);
    });
  });

  unittest.group('obj-schema-ShareAlbumRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildShareAlbumRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ShareAlbumRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkShareAlbumRequest(od as api.ShareAlbumRequest);
    });
  });

  unittest.group('obj-schema-ShareAlbumResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildShareAlbumResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ShareAlbumResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkShareAlbumResponse(od as api.ShareAlbumResponse);
    });
  });

  unittest.group('obj-schema-ShareInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildShareInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.ShareInfo.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkShareInfo(od as api.ShareInfo);
    });
  });

  unittest.group('obj-schema-SharedAlbumOptions', () {
    unittest.test('to-json--from-json', () async {
      var o = buildSharedAlbumOptions();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.SharedAlbumOptions.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkSharedAlbumOptions(od as api.SharedAlbumOptions);
    });
  });

  unittest.group('obj-schema-SimpleMediaItem', () {
    unittest.test('to-json--from-json', () async {
      var o = buildSimpleMediaItem();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.SimpleMediaItem.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkSimpleMediaItem(od as api.SimpleMediaItem);
    });
  });

  unittest.group('obj-schema-Status', () {
    unittest.test('to-json--from-json', () async {
      var o = buildStatus();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Status.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkStatus(od as api.Status);
    });
  });

  unittest.group('obj-schema-TextEnrichment', () {
    unittest.test('to-json--from-json', () async {
      var o = buildTextEnrichment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.TextEnrichment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkTextEnrichment(od as api.TextEnrichment);
    });
  });

  unittest.group('obj-schema-Video', () {
    unittest.test('to-json--from-json', () async {
      var o = buildVideo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.Video.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkVideo(od as api.Video);
    });
  });

  unittest.group('resource-AlbumsResource', () {
    unittest.test('method--addEnrichment', () async {
      var mock = HttpServerMock();
      var res = api.PhotosLibraryApi(mock).albums;
      var arg_request = buildAddEnrichmentToAlbumRequest();
      var arg_albumId = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.AddEnrichmentToAlbumRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkAddEnrichmentToAlbumRequest(
            obj as api.AddEnrichmentToAlbumRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 10),
          unittest.equals("v1/albums/"),
        );
        pathOffset += 10;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildAddEnrichmentToAlbumResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.addEnrichment(arg_request, arg_albumId,
          $fields: arg_$fields);
      checkAddEnrichmentToAlbumResponse(
          response as api.AddEnrichmentToAlbumResponse);
    });

    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.PhotosLibraryApi(mock).albums;
      var arg_request = buildCreateAlbumRequest();
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.CreateAlbumRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkCreateAlbumRequest(obj as api.CreateAlbumRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 9),
          unittest.equals("v1/albums"),
        );
        pathOffset += 9;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildAlbum());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.create(arg_request, $fields: arg_$fields);
      checkAlbum(response as api.Album);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.PhotosLibraryApi(mock).albums;
      var arg_albumId = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 10),
          unittest.equals("v1/albums/"),
        );
        pathOffset += 10;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildAlbum());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_albumId, $fields: arg_$fields);
      checkAlbum(response as api.Album);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.PhotosLibraryApi(mock).albums;
      var arg_pageSize = 42;
      var arg_pageToken = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 9),
          unittest.equals("v1/albums"),
        );
        pathOffset += 9;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          core.int.parse(queryMap["pageSize"]!.first),
          unittest.equals(arg_pageSize),
        );
        unittest.expect(
          queryMap["pageToken"]!.first,
          unittest.equals(arg_pageToken),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildListAlbumsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkListAlbumsResponse(response as api.ListAlbumsResponse);
    });

    unittest.test('method--share', () async {
      var mock = HttpServerMock();
      var res = api.PhotosLibraryApi(mock).albums;
      var arg_request = buildShareAlbumRequest();
      var arg_albumId = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.ShareAlbumRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkShareAlbumRequest(obj as api.ShareAlbumRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 10),
          unittest.equals("v1/albums/"),
        );
        pathOffset += 10;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildShareAlbumResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.share(arg_request, arg_albumId, $fields: arg_$fields);
      checkShareAlbumResponse(response as api.ShareAlbumResponse);
    });
  });

  unittest.group('resource-MediaItemsResource', () {
    unittest.test('method--batchCreate', () async {
      var mock = HttpServerMock();
      var res = api.PhotosLibraryApi(mock).mediaItems;
      var arg_request = buildBatchCreateMediaItemsRequest();
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.BatchCreateMediaItemsRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkBatchCreateMediaItemsRequest(
            obj as api.BatchCreateMediaItemsRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 25),
          unittest.equals("v1/mediaItems:batchCreate"),
        );
        pathOffset += 25;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildBatchCreateMediaItemsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.batchCreate(arg_request, $fields: arg_$fields);
      checkBatchCreateMediaItemsResponse(
          response as api.BatchCreateMediaItemsResponse);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.PhotosLibraryApi(mock).mediaItems;
      var arg_mediaItemId = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 14),
          unittest.equals("v1/mediaItems/"),
        );
        pathOffset += 14;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildMediaItem());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_mediaItemId, $fields: arg_$fields);
      checkMediaItem(response as api.MediaItem);
    });

    unittest.test('method--search', () async {
      var mock = HttpServerMock();
      var res = api.PhotosLibraryApi(mock).mediaItems;
      var arg_request = buildSearchMediaItemsRequest();
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.SearchMediaItemsRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkSearchMediaItemsRequest(obj as api.SearchMediaItemsRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 20),
          unittest.equals("v1/mediaItems:search"),
        );
        pathOffset += 20;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildSearchMediaItemsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.search(arg_request, $fields: arg_$fields);
      checkSearchMediaItemsResponse(response as api.SearchMediaItemsResponse);
    });
  });

  unittest.group('resource-SharedAlbumsResource', () {
    unittest.test('method--join', () async {
      var mock = HttpServerMock();
      var res = api.PhotosLibraryApi(mock).sharedAlbums;
      var arg_request = buildJoinSharedAlbumRequest();
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.JoinSharedAlbumRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkJoinSharedAlbumRequest(obj as api.JoinSharedAlbumRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 20),
          unittest.equals("v1/sharedAlbums:join"),
        );
        pathOffset += 20;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildJoinSharedAlbumResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.join(arg_request, $fields: arg_$fields);
      checkJoinSharedAlbumResponse(response as api.JoinSharedAlbumResponse);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.PhotosLibraryApi(mock).sharedAlbums;
      var arg_pageSize = 42;
      var arg_pageToken = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 15),
          unittest.equals("v1/sharedAlbums"),
        );
        pathOffset += 15;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          core.int.parse(queryMap["pageSize"]!.first),
          unittest.equals(arg_pageSize),
        );
        unittest.expect(
          queryMap["pageToken"]!.first,
          unittest.equals(arg_pageToken),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildListSharedAlbumsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkListSharedAlbumsResponse(response as api.ListSharedAlbumsResponse);
    });
  });
}
