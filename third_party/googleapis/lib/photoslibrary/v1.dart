// This is a generated file (see the discoveryapis_generator project).

// ignore_for_file: camel_case_types
// ignore_for_file: comment_references
// ignore_for_file: file_names
// ignore_for_file: library_names
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: prefer_interpolation_to_compose_strings
// ignore_for_file: unnecessary_brace_in_string_interps
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: unnecessary_string_interpolations

/// Photos Library API - v1
///
/// Manage photos, videos, and albums in Google Photos
///
///
/// For more information, see <https://developers.google.com/photos/>
///
/// Create an instance of [PhotosLibraryApi] to access these resources:
///
/// - [AlbumsResource]
/// - [MediaItemsResource]
/// - [SharedAlbumsResource]
library photoslibrary.v1;

import 'dart:async' as async;
import 'dart:convert' as convert;
import 'dart:core' as core;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

import '../src/user_agent.dart';

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

/// Manage photos, videos, and albums in Google Photos
class PhotosLibraryApi {
  /// View the photos, videos and albums in your Google Photos
  static const drivePhotosReadonlyScope =
      'https://www.googleapis.com/auth/drive.photos.readonly';

  /// View and manage your Google Photos library
  static const photoslibraryScope =
      'https://www.googleapis.com/auth/photoslibrary';

  /// Add to your Google Photos library
  static const photoslibraryAppendonlyScope =
      'https://www.googleapis.com/auth/photoslibrary.appendonly';

  /// View your Google Photos library
  static const photoslibraryReadonlyScope =
      'https://www.googleapis.com/auth/photoslibrary.readonly';

  /// Manage photos added by this app
  static const photoslibraryReadonlyAppcreateddataScope =
      'https://www.googleapis.com/auth/photoslibrary.readonly.appcreateddata';

  /// Manage and add to shared albums on your behalf
  static const photoslibrarySharingScope =
      'https://www.googleapis.com/auth/photoslibrary.sharing';

  final commons.ApiRequester _requester;

  AlbumsResource get albums => AlbumsResource(_requester);
  MediaItemsResource get mediaItems => MediaItemsResource(_requester);
  SharedAlbumsResource get sharedAlbums => SharedAlbumsResource(_requester);

  PhotosLibraryApi(http.Client client,
      {core.String rootUrl = 'https://photoslibrary.googleapis.com/',
      core.String servicePath = ''})
      : _requester =
            commons.ApiRequester(client, rootUrl, servicePath, requestHeaders);
}

class AlbumsResource {
  final commons.ApiRequester _requester;

  AlbumsResource(commons.ApiRequester client) : _requester = client;

  /// Adds an enrichment to a specified position in a defined album.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [albumId] - Identifier of the album where the enrichment will be added.
  /// Value must have pattern `^\[^/\]+$`.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [AddEnrichmentToAlbumResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<AddEnrichmentToAlbumResponse> addEnrichment(
    AddEnrichmentToAlbumRequest request,
    core.String albumId, {
    core.String? $fields,
  }) async {
    final _body = convert.json.encode(request.toJson());
    final _queryParams = <core.String, core.List<core.String>>{
      if ($fields != null) 'fields': [$fields],
    };

    final _url =
        'v1/albums/' + core.Uri.encodeFull('$albumId') + ':addEnrichment';

    final _response = await _requester.request(
      _url,
      'POST',
      body: _body,
      queryParams: _queryParams,
    );
    return AddEnrichmentToAlbumResponse.fromJson(
        _response as core.Map<core.String, core.dynamic>);
  }

  /// Creates an album in a user's Google Photos library.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [Album].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Album> create(
    CreateAlbumRequest request, {
    core.String? $fields,
  }) async {
    final _body = convert.json.encode(request.toJson());
    final _queryParams = <core.String, core.List<core.String>>{
      if ($fields != null) 'fields': [$fields],
    };

    const _url = 'v1/albums';

    final _response = await _requester.request(
      _url,
      'POST',
      body: _body,
      queryParams: _queryParams,
    );
    return Album.fromJson(_response as core.Map<core.String, core.dynamic>);
  }

  /// Returns the album specified by the given album id.
  ///
  /// Request parameters:
  ///
  /// [albumId] - Identifier of the album to be requested.
  /// Value must have pattern `^\[^/\]+$`.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [Album].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Album> get(
    core.String albumId, {
    core.String? $fields,
  }) async {
    final _queryParams = <core.String, core.List<core.String>>{
      if ($fields != null) 'fields': [$fields],
    };

    final _url = 'v1/albums/' + core.Uri.encodeFull('$albumId');

    final _response = await _requester.request(
      _url,
      'GET',
      queryParams: _queryParams,
    );
    return Album.fromJson(_response as core.Map<core.String, core.dynamic>);
  }

  /// Lists all albums shown to a user in the 'Albums' tab of the Google
  /// Photos app.
  ///
  /// Request parameters:
  ///
  /// [pageSize] - Maximum number of albums to return in the response. The
  /// default number of
  /// albums to return at a time is 20. The maximum page size is 50.
  ///
  /// [pageToken] - A continuation token to get the next page of the results.
  /// Adding this to
  /// the request will return the rows after the pageToken. The pageToken should
  /// be the value returned in the nextPageToken parameter in the response to
  /// the
  /// listAlbums request.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [ListAlbumsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListAlbumsResponse> list({
    core.int? pageSize,
    core.String? pageToken,
    core.String? $fields,
  }) async {
    final _queryParams = <core.String, core.List<core.String>>{
      if (pageSize != null) 'pageSize': ['${pageSize}'],
      if (pageToken != null) 'pageToken': [pageToken],
      if ($fields != null) 'fields': [$fields],
    };

    const _url = 'v1/albums';

    final _response = await _requester.request(
      _url,
      'GET',
      queryParams: _queryParams,
    );
    return ListAlbumsResponse.fromJson(
        _response as core.Map<core.String, core.dynamic>);
  }

  /// Marks an album as 'shared' and accessible to other users.
  ///
  /// This action can
  /// only be performed on albums which were created by the developer via the
  /// API.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [albumId] - Identifier of the album to be shared. This album id must
  /// belong to an album
  /// created by the developer.
  /// .
  /// Value must have pattern `^\[^/\]+$`.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [ShareAlbumResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ShareAlbumResponse> share(
    ShareAlbumRequest request,
    core.String albumId, {
    core.String? $fields,
  }) async {
    final _body = convert.json.encode(request.toJson());
    final _queryParams = <core.String, core.List<core.String>>{
      if ($fields != null) 'fields': [$fields],
    };

    final _url = 'v1/albums/' + core.Uri.encodeFull('$albumId') + ':share';

    final _response = await _requester.request(
      _url,
      'POST',
      body: _body,
      queryParams: _queryParams,
    );
    return ShareAlbumResponse.fromJson(
        _response as core.Map<core.String, core.dynamic>);
  }
}

class MediaItemsResource {
  final commons.ApiRequester _requester;

  MediaItemsResource(commons.ApiRequester client) : _requester = client;

  /// Creates one or more media items in a user's Google Photos library.
  /// If an album id is specified, the media item(s) are also added to the
  /// album.
  /// By default the media item(s) will be added to the end of the library or
  /// album.
  ///
  /// If an album id and position are both defined, then the media items will
  /// be added to the album at the specified position.
  ///
  /// If multiple media items are given, they will be inserted at the specified
  /// position.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [BatchCreateMediaItemsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<BatchCreateMediaItemsResponse> batchCreate(
    BatchCreateMediaItemsRequest request, {
    core.String? $fields,
  }) async {
    final _body = convert.json.encode(request.toJson());
    final _queryParams = <core.String, core.List<core.String>>{
      if ($fields != null) 'fields': [$fields],
    };

    const _url = 'v1/mediaItems:batchCreate';

    final _response = await _requester.request(
      _url,
      'POST',
      body: _body,
      queryParams: _queryParams,
    );
    return BatchCreateMediaItemsResponse.fromJson(
        _response as core.Map<core.String, core.dynamic>);
  }

  /// Returns the media item specified based on a given media item id.
  ///
  /// Request parameters:
  ///
  /// [mediaItemId] - Identifier of media item to be requested.
  /// Value must have pattern `^\[^/\]+$`.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [MediaItem].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<MediaItem> get(
    core.String mediaItemId, {
    core.String? $fields,
  }) async {
    final _queryParams = <core.String, core.List<core.String>>{
      if ($fields != null) 'fields': [$fields],
    };

    final _url = 'v1/mediaItems/' + core.Uri.encodeFull('$mediaItemId');

    final _response = await _requester.request(
      _url,
      'GET',
      queryParams: _queryParams,
    );
    return MediaItem.fromJson(_response as core.Map<core.String, core.dynamic>);
  }

  /// Searches for media items in a user's Google Photos library.
  /// If no filters are set, then all media items in the user's library will be
  /// returned.
  ///
  /// If an album is set, all media items in the specified album will be
  /// returned.
  ///
  /// If filters are specified, anything that matches the filters from the
  /// user's
  /// library will be listed.
  ///
  /// If an album and filters are set, then this will result in an error.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [SearchMediaItemsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<SearchMediaItemsResponse> search(
    SearchMediaItemsRequest request, {
    core.String? $fields,
  }) async {
    final _body = convert.json.encode(request.toJson());
    final _queryParams = <core.String, core.List<core.String>>{
      if ($fields != null) 'fields': [$fields],
    };

    const _url = 'v1/mediaItems:search';

    final _response = await _requester.request(
      _url,
      'POST',
      body: _body,
      queryParams: _queryParams,
    );
    return SearchMediaItemsResponse.fromJson(
        _response as core.Map<core.String, core.dynamic>);
  }
}

class SharedAlbumsResource {
  final commons.ApiRequester _requester;

  SharedAlbumsResource(commons.ApiRequester client) : _requester = client;

  /// Joins a shared album on behalf of the Google Photos user.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [JoinSharedAlbumResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<JoinSharedAlbumResponse> join(
    JoinSharedAlbumRequest request, {
    core.String? $fields,
  }) async {
    final _body = convert.json.encode(request.toJson());
    final _queryParams = <core.String, core.List<core.String>>{
      if ($fields != null) 'fields': [$fields],
    };

    const _url = 'v1/sharedAlbums:join';

    final _response = await _requester.request(
      _url,
      'POST',
      body: _body,
      queryParams: _queryParams,
    );
    return JoinSharedAlbumResponse.fromJson(
        _response as core.Map<core.String, core.dynamic>);
  }

  /// Lists all shared albums shown to a user in the 'Sharing' tab of the
  /// Google Photos app.
  ///
  /// Request parameters:
  ///
  /// [pageSize] - Maximum number of albums to return in the response. The
  /// default number of
  /// albums to return at a time is 20. The maximum page size is 50.
  ///
  /// [pageToken] - A continuation token to get the next page of the results.
  /// Adding this to
  /// the request will return the rows after the pageToken. The pageToken should
  /// be the value returned in the nextPageToken parameter in the response to
  /// the
  /// listSharedAlbums request.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [ListSharedAlbumsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ListSharedAlbumsResponse> list({
    core.int? pageSize,
    core.String? pageToken,
    core.String? $fields,
  }) async {
    final _queryParams = <core.String, core.List<core.String>>{
      if (pageSize != null) 'pageSize': ['${pageSize}'],
      if (pageToken != null) 'pageToken': [pageToken],
      if ($fields != null) 'fields': [$fields],
    };

    const _url = 'v1/sharedAlbums';

    final _response = await _requester.request(
      _url,
      'GET',
      queryParams: _queryParams,
    );
    return ListSharedAlbumsResponse.fromJson(
        _response as core.Map<core.String, core.dynamic>);
  }
}

/// Request to add an enrichment to a specific album at a specific position.
class AddEnrichmentToAlbumRequest {
  /// The position where the enrichment will be inserted.
  AlbumPosition? albumPosition;

  /// The enrichment to be added.
  NewEnrichmentItem? newEnrichmentItem;

  AddEnrichmentToAlbumRequest();

  AddEnrichmentToAlbumRequest.fromJson(core.Map _json) {
    if (_json.containsKey('albumPosition')) {
      albumPosition = AlbumPosition.fromJson(
          _json['albumPosition'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('newEnrichmentItem')) {
      newEnrichmentItem = NewEnrichmentItem.fromJson(
          _json['newEnrichmentItem'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (albumPosition != null) 'albumPosition': albumPosition!.toJson(),
        if (newEnrichmentItem != null)
          'newEnrichmentItem': newEnrichmentItem!.toJson(),
      };
}

class AddEnrichmentToAlbumResponse {
  /// Enrichment which was added.
  ///
  /// Output only.
  EnrichmentItem? enrichmentItem;

  AddEnrichmentToAlbumResponse();

  AddEnrichmentToAlbumResponse.fromJson(core.Map _json) {
    if (_json.containsKey('enrichmentItem')) {
      enrichmentItem = EnrichmentItem.fromJson(
          _json['enrichmentItem'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (enrichmentItem != null) 'enrichmentItem': enrichmentItem!.toJson(),
      };
}

/// Representation of an album in Google Photos.
/// Albums are a container for media items.
///
/// They contain an additional
/// shareInfo property if they have been shared by the application.
class Album {
  /// A URL to the cover photo's bytes.
  ///
  /// This should not be used as
  /// is. Parameters should be appended to this URL before use. For example,
  /// '=w2048-h1024' will set the dimensions of the cover photo to have a width
  /// of 2048 px and height of 1024 px.
  ///
  /// Output only.
  core.String? coverPhotoBaseUrl;

  /// \[Ouput only\] Identifier for the album.
  ///
  /// This is a persistent identifier that
  /// can be used between sessions to identify this album.
  core.String? id;

  /// True if media items can be created in the album.
  /// This field is based on the scopes granted and permissions of the album.
  ///
  /// If
  /// the scopes are changed or permissions of the album are changed, this field
  /// will be updated.
  ///
  /// Output only.
  core.bool? isWriteable;

  /// Google Photos URL for the album.
  ///
  /// The user needs to be signed
  /// in to their Google Photos account to access this link.
  ///
  /// Output only.
  core.String? productUrl;

  /// Information related to shared albums.
  /// This field is only populated if the album is a shared album, the
  /// developer created the album and the user has granted photoslibrary.sharing
  /// scope.
  ///
  /// Output only.
  ShareInfo? shareInfo;

  /// Name of the album displayed to the user in their Google Photos account.
  /// This string should not be more than 500 characters.
  core.String? title;

  /// The number of media items in the album
  ///
  /// Output only.
  core.String? totalMediaItems;

  Album();

  Album.fromJson(core.Map _json) {
    if (_json.containsKey('coverPhotoBaseUrl')) {
      coverPhotoBaseUrl = _json['coverPhotoBaseUrl'] as core.String;
    }
    if (_json.containsKey('id')) {
      id = _json['id'] as core.String;
    }
    if (_json.containsKey('isWriteable')) {
      isWriteable = _json['isWriteable'] as core.bool;
    }
    if (_json.containsKey('productUrl')) {
      productUrl = _json['productUrl'] as core.String;
    }
    if (_json.containsKey('shareInfo')) {
      shareInfo = ShareInfo.fromJson(
          _json['shareInfo'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('title')) {
      title = _json['title'] as core.String;
    }
    if (_json.containsKey('totalMediaItems')) {
      totalMediaItems = _json['totalMediaItems'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (coverPhotoBaseUrl != null) 'coverPhotoBaseUrl': coverPhotoBaseUrl!,
        if (id != null) 'id': id!,
        if (isWriteable != null) 'isWriteable': isWriteable!,
        if (productUrl != null) 'productUrl': productUrl!,
        if (shareInfo != null) 'shareInfo': shareInfo!.toJson(),
        if (title != null) 'title': title!,
        if (totalMediaItems != null) 'totalMediaItems': totalMediaItems!,
      };
}

/// Specifies a position in an album.
class AlbumPosition {
  /// Type of position, for a media or enrichment item.
  /// Possible string values are:
  /// - "POSITION_TYPE_UNSPECIFIED" : Default value if this enum is not set.
  /// - "FIRST_IN_ALBUM" : At the beginning of the album.
  /// - "LAST_IN_ALBUM" : At the end of the album.
  /// - "AFTER_MEDIA_ITEM" : After a media item.
  /// - "AFTER_ENRICHMENT_ITEM" : After an enrichment item.
  core.String? position;

  /// The enrichment item to which the position is relative to.
  /// Only used when position type is AFTER_ENRICHMENT_ITEM.
  core.String? relativeEnrichmentItemId;

  /// The media item to which the position is relative to.
  /// Only used when position type is AFTER_MEDIA_ITEM.
  core.String? relativeMediaItemId;

  AlbumPosition();

  AlbumPosition.fromJson(core.Map _json) {
    if (_json.containsKey('position')) {
      position = _json['position'] as core.String;
    }
    if (_json.containsKey('relativeEnrichmentItemId')) {
      relativeEnrichmentItemId =
          _json['relativeEnrichmentItemId'] as core.String;
    }
    if (_json.containsKey('relativeMediaItemId')) {
      relativeMediaItemId = _json['relativeMediaItemId'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (position != null) 'position': position!,
        if (relativeEnrichmentItemId != null)
          'relativeEnrichmentItemId': relativeEnrichmentItemId!,
        if (relativeMediaItemId != null)
          'relativeMediaItemId': relativeMediaItemId!,
      };
}

/// Request to create one or more media items in a user's Google Photos library.
/// If an <code>albumid</code> is specified, the media items are also added to
/// that album.
///
/// <code>albumPosition</code> is optional and can only be specified
/// if an <code>albumId</code> is set.
class BatchCreateMediaItemsRequest {
  /// Identifier of the album where the media item(s) will be added.
  ///
  /// They will
  /// also be added to the user's library. This is an optional field.
  core.String? albumId;

  /// Position in the album where the media item(s) will be added.
  ///
  /// If not
  /// specified, the media item(s) will be added to the end of the album (as per
  /// the default value which is LAST_IN_ALBUM).
  /// The request will fail if this field is present but no album_id is
  /// specified.
  AlbumPosition? albumPosition;

  /// List of media items to be created.
  core.List<NewMediaItem>? newMediaItems;

  BatchCreateMediaItemsRequest();

  BatchCreateMediaItemsRequest.fromJson(core.Map _json) {
    if (_json.containsKey('albumId')) {
      albumId = _json['albumId'] as core.String;
    }
    if (_json.containsKey('albumPosition')) {
      albumPosition = AlbumPosition.fromJson(
          _json['albumPosition'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('newMediaItems')) {
      newMediaItems = (_json['newMediaItems'] as core.List)
          .map<NewMediaItem>((value) => NewMediaItem.fromJson(
              value as core.Map<core.String, core.dynamic>))
          .toList();
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (albumId != null) 'albumId': albumId!,
        if (albumPosition != null) 'albumPosition': albumPosition!.toJson(),
        if (newMediaItems != null)
          'newMediaItems':
              newMediaItems!.map((value) => value.toJson()).toList(),
      };
}

class BatchCreateMediaItemsResponse {
  /// List of media items which were created.
  ///
  /// Output only.
  core.List<NewMediaItemResult>? newMediaItemResults;

  BatchCreateMediaItemsResponse();

  BatchCreateMediaItemsResponse.fromJson(core.Map _json) {
    if (_json.containsKey('newMediaItemResults')) {
      newMediaItemResults = (_json['newMediaItemResults'] as core.List)
          .map<NewMediaItemResult>((value) => NewMediaItemResult.fromJson(
              value as core.Map<core.String, core.dynamic>))
          .toList();
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (newMediaItemResults != null)
          'newMediaItemResults':
              newMediaItemResults!.map((value) => value.toJson()).toList(),
      };
}

/// This filter is used to define which results to return based on the contents
/// of the media item.
///
/// It is possible to specify a list of categories to include, and/or a list of
/// categories to exclude.
///
/// Within each list, the categories are combined with an
/// OR. For example, if the content filter looks like:
///
///     included_content_categories: \[c1, c2, c3\]
///
/// It would get media items that contain (c1 OR c2 OR c3).
///
/// And if the content filter looks like:
///
///     excluded_content_categories: \[c1, c2, c3\]
///
/// It would get media items that contain NOT (c1 OR c2 OR c3).
/// You can also include some categories while excluding others, as in this
/// proto:
///
///     included_content_categories: \[c1, c2\],
///     excluded_content_category: \[c3, c4\]
///
/// It would get media items that contain (c1 OR c2) AND NOT (c3 OR c4).
///
/// A category that appears in <code>includedContentategories</code> must not
/// appear in <code>excludedContentCategories</code>.
class ContentFilter {
  /// The set of categories that must NOT be present in the media items in the
  /// result.
  ///
  /// The items in the set are ORed. There is a maximum of 10
  /// excludedContentCategories per request.
  core.List<core.String>? excludedContentCategories;

  /// The set of categories that must be present in the media items in the
  /// result.
  ///
  /// The items in the set are ORed. There is a maximum of 10
  /// includedContentCategories per request.
  core.List<core.String>? includedContentCategories;

  ContentFilter();

  ContentFilter.fromJson(core.Map _json) {
    if (_json.containsKey('excludedContentCategories')) {
      excludedContentCategories =
          (_json['excludedContentCategories'] as core.List)
              .map<core.String>((value) => value as core.String)
              .toList();
    }
    if (_json.containsKey('includedContentCategories')) {
      includedContentCategories =
          (_json['includedContentCategories'] as core.List)
              .map<core.String>((value) => value as core.String)
              .toList();
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (excludedContentCategories != null)
          'excludedContentCategories': excludedContentCategories!,
        if (includedContentCategories != null)
          'includedContentCategories': includedContentCategories!,
      };
}

/// Information about a user who contributed the media item.
///
/// Note that this
/// information is only included if the album containing the media item is
/// shared, was created by you and you have the sharing scope.
class ContributorInfo {
  /// Display name of the contributor.
  core.String? displayName;

  /// URL to the profile picture of the contributor.
  core.String? profilePictureBaseUrl;

  ContributorInfo();

  ContributorInfo.fromJson(core.Map _json) {
    if (_json.containsKey('displayName')) {
      displayName = _json['displayName'] as core.String;
    }
    if (_json.containsKey('profilePictureBaseUrl')) {
      profilePictureBaseUrl = _json['profilePictureBaseUrl'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (displayName != null) 'displayName': displayName!,
        if (profilePictureBaseUrl != null)
          'profilePictureBaseUrl': profilePictureBaseUrl!,
      };
}

/// Request to create an album in Google Photos.
class CreateAlbumRequest {
  /// The album to be created.
  Album? album;

  CreateAlbumRequest();

  CreateAlbumRequest.fromJson(core.Map _json) {
    if (_json.containsKey('album')) {
      album =
          Album.fromJson(_json['album'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (album != null) 'album': album!.toJson(),
      };
}

/// Represents a whole calendar date.
///
/// The day may be 0 to represent a year and month where the day is not
/// significant, e.g. a whole calendar month. The month may be 0 to represent a
/// a day and a year where the month is not signficant, e.g. when you want to
/// specify the same day in every month of a year or a specific year. The year
/// may be 0 to represent a month and day independent of year, e.g. anniversary
/// date.
class Date {
  /// Day of month.
  ///
  /// Must be from 1 to 31 and valid for the year and month, or 0
  /// if specifying a year/month where the day is not significant.
  core.int? day;

  /// Month of year.
  ///
  /// Must be from 1 to 12, or 0 if specifying a date without a
  /// month.
  core.int? month;

  /// Year of date.
  ///
  /// Must be from 1 to 9999, or 0 if specifying a date without
  /// a year.
  core.int? year;

  Date();

  Date.fromJson(core.Map _json) {
    if (_json.containsKey('day')) {
      day = _json['day'] as core.int;
    }
    if (_json.containsKey('month')) {
      month = _json['month'] as core.int;
    }
    if (_json.containsKey('year')) {
      year = _json['year'] as core.int;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (day != null) 'day': day!,
        if (month != null) 'month': month!,
        if (year != null) 'year': year!,
      };
}

/// This filter defines the allowed dates or date ranges for the media returned.
/// It is possible to pick a set of specific dates and a set of date ranges.
class DateFilter {
  /// List of dates that the media items must have been created on.
  ///
  /// There is a
  /// maximum of 5 dates that can be included per request.
  core.List<Date>? dates;

  /// List of dates ranges that the media items must have been created in.
  ///
  /// There
  /// is a maximum of 5 dates ranges that can be included per request.
  core.List<DateRange>? ranges;

  DateFilter();

  DateFilter.fromJson(core.Map _json) {
    if (_json.containsKey('dates')) {
      dates = (_json['dates'] as core.List)
          .map<Date>((value) =>
              Date.fromJson(value as core.Map<core.String, core.dynamic>))
          .toList();
    }
    if (_json.containsKey('ranges')) {
      ranges = (_json['ranges'] as core.List)
          .map<DateRange>((value) =>
              DateRange.fromJson(value as core.Map<core.String, core.dynamic>))
          .toList();
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (dates != null)
          'dates': dates!.map((value) => value.toJson()).toList(),
        if (ranges != null)
          'ranges': ranges!.map((value) => value.toJson()).toList(),
      };
}

/// Defines a range of dates.
///
/// Both dates must be of the same format (see Date
/// definition for more).
class DateRange {
  /// The end date (included as part of the range) in the same format as the
  /// start date.
  Date? endDate;

  /// The start date (included as part of the range) in one of the formats
  /// described.
  Date? startDate;

  DateRange();

  DateRange.fromJson(core.Map _json) {
    if (_json.containsKey('endDate')) {
      endDate = Date.fromJson(
          _json['endDate'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('startDate')) {
      startDate = Date.fromJson(
          _json['startDate'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (endDate != null) 'endDate': endDate!.toJson(),
        if (startDate != null) 'startDate': startDate!.toJson(),
      };
}

/// An enrichment item.
class EnrichmentItem {
  /// Identifier of the enrichment item.
  core.String? id;

  EnrichmentItem();

  EnrichmentItem.fromJson(core.Map _json) {
    if (_json.containsKey('id')) {
      id = _json['id'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (id != null) 'id': id!,
      };
}

/// Filters that can be applied to a media item search.
/// If multiple filter options are specified, they are treated as AND with each
/// other.
class Filters {
  /// Filters the media items based on their content.
  ContentFilter? contentFilter;

  /// Filters the media items based on their creation date.
  DateFilter? dateFilter;

  /// If set, the results will include media items that the user has archived.
  /// Defaults to false (archived media items are not included).
  core.bool? includeArchivedMedia;

  /// Filters the media items based on the type of media.
  MediaTypeFilter? mediaTypeFilter;

  Filters();

  Filters.fromJson(core.Map _json) {
    if (_json.containsKey('contentFilter')) {
      contentFilter = ContentFilter.fromJson(
          _json['contentFilter'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('dateFilter')) {
      dateFilter = DateFilter.fromJson(
          _json['dateFilter'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('includeArchivedMedia')) {
      includeArchivedMedia = _json['includeArchivedMedia'] as core.bool;
    }
    if (_json.containsKey('mediaTypeFilter')) {
      mediaTypeFilter = MediaTypeFilter.fromJson(
          _json['mediaTypeFilter'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (contentFilter != null) 'contentFilter': contentFilter!.toJson(),
        if (dateFilter != null) 'dateFilter': dateFilter!.toJson(),
        if (includeArchivedMedia != null)
          'includeArchivedMedia': includeArchivedMedia!,
        if (mediaTypeFilter != null)
          'mediaTypeFilter': mediaTypeFilter!.toJson(),
      };
}

/// Request to join a shared album on behalf of the user.
///
/// This uses a shareToken
/// which can be acquired via the shareAlbum or listSharedAlbums calls.
class JoinSharedAlbumRequest {
  /// Token indicating the shared album to join on behalf of the user.
  core.String? shareToken;

  JoinSharedAlbumRequest();

  JoinSharedAlbumRequest.fromJson(core.Map _json) {
    if (_json.containsKey('shareToken')) {
      shareToken = _json['shareToken'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (shareToken != null) 'shareToken': shareToken!,
      };
}

/// Response to successfully joining the shared album on behalf of the user.
class JoinSharedAlbumResponse {
  JoinSharedAlbumResponse();

  JoinSharedAlbumResponse.fromJson(
      // ignore: avoid_unused_constructor_parameters
      core.Map _json);

  core.Map<core.String, core.dynamic> toJson() => {};
}

/// An object representing a latitude/longitude pair.
///
/// This is expressed as a pair
/// of doubles representing degrees latitude and degrees longitude. Unless
/// specified otherwise, this must conform to the
/// <a href="http://www.unoosa.org/pdf/icg/2012/template/WGS_84.pdf">WGS84
/// standard</a>. Values must be within normalized ranges.
class LatLng {
  /// The latitude in degrees.
  ///
  /// It must be in the range \[-90.0, +90.0\].
  core.double? latitude;

  /// The longitude in degrees.
  ///
  /// It must be in the range \[-180.0, +180.0\].
  core.double? longitude;

  LatLng();

  LatLng.fromJson(core.Map _json) {
    if (_json.containsKey('latitude')) {
      latitude = (_json['latitude'] as core.num).toDouble();
    }
    if (_json.containsKey('longitude')) {
      longitude = (_json['longitude'] as core.num).toDouble();
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (latitude != null) 'latitude': latitude!,
        if (longitude != null) 'longitude': longitude!,
      };
}

class ListAlbumsResponse {
  /// List of albums that were created by the user.
  ///
  /// Output only.
  core.List<Album>? albums;

  /// Token to use to get the next set of albums.
  ///
  /// Populated if
  /// there are more albums to retrieve for this request.
  ///
  /// Output only.
  core.String? nextPageToken;

  ListAlbumsResponse();

  ListAlbumsResponse.fromJson(core.Map _json) {
    if (_json.containsKey('albums')) {
      albums = (_json['albums'] as core.List)
          .map<Album>((value) =>
              Album.fromJson(value as core.Map<core.String, core.dynamic>))
          .toList();
    }
    if (_json.containsKey('nextPageToken')) {
      nextPageToken = _json['nextPageToken'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (albums != null)
          'albums': albums!.map((value) => value.toJson()).toList(),
        if (nextPageToken != null) 'nextPageToken': nextPageToken!,
      };
}

class ListSharedAlbumsResponse {
  /// Token to use to get the next set of shared albums.
  ///
  /// Populated
  /// if there are more shared albums to retrieve for this request.
  ///
  /// Output only.
  core.String? nextPageToken;

  /// List of shared albums that were requested.
  ///
  /// Output only.
  core.List<Album>? sharedAlbums;

  ListSharedAlbumsResponse();

  ListSharedAlbumsResponse.fromJson(core.Map _json) {
    if (_json.containsKey('nextPageToken')) {
      nextPageToken = _json['nextPageToken'] as core.String;
    }
    if (_json.containsKey('sharedAlbums')) {
      sharedAlbums = (_json['sharedAlbums'] as core.List)
          .map<Album>((value) =>
              Album.fromJson(value as core.Map<core.String, core.dynamic>))
          .toList();
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (nextPageToken != null) 'nextPageToken': nextPageToken!,
        if (sharedAlbums != null)
          'sharedAlbums': sharedAlbums!.map((value) => value.toJson()).toList(),
      };
}

/// Represents a physical location.
class Location {
  /// Position of the location on the map.
  LatLng? latlng;

  /// Name of the location to be displayed.
  core.String? locationName;

  Location();

  Location.fromJson(core.Map _json) {
    if (_json.containsKey('latlng')) {
      latlng = LatLng.fromJson(
          _json['latlng'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('locationName')) {
      locationName = _json['locationName'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (latlng != null) 'latlng': latlng!.toJson(),
        if (locationName != null) 'locationName': locationName!,
      };
}

/// An enrichment containing a single location.
class LocationEnrichment {
  /// Location for this enrichment item.
  Location? location;

  LocationEnrichment();

  LocationEnrichment.fromJson(core.Map _json) {
    if (_json.containsKey('location')) {
      location = Location.fromJson(
          _json['location'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (location != null) 'location': location!.toJson(),
      };
}

/// An enrichment containing a map, showing origin and destination locations.
class MapEnrichment {
  /// Destination location for this enrichemt item.
  Location? destination;

  /// Origin location for this enrichment item.
  Location? origin;

  MapEnrichment();

  MapEnrichment.fromJson(core.Map _json) {
    if (_json.containsKey('destination')) {
      destination = Location.fromJson(
          _json['destination'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('origin')) {
      origin = Location.fromJson(
          _json['origin'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (destination != null) 'destination': destination!.toJson(),
        if (origin != null) 'origin': origin!.toJson(),
      };
}

/// Representation of a media item (e.g. photo, video etc.) in Google Photos.
class MediaItem {
  /// A URL to the media item's bytes.
  ///
  /// This should not be used as is.
  /// For example, '=w2048-h1024' will set the dimensions of a media item of
  /// type
  /// photo to have a width of 2048 px and height of 1024 px.
  core.String? baseUrl;

  /// Information about the user who created this media item.
  ContributorInfo? contributorInfo;

  /// Description of the media item.
  ///
  /// This is shown to the user in the item's
  /// info section in the Google Photos app.
  core.String? description;

  /// Identifier for the media item.
  ///
  /// This is a persistent identifier that can be
  /// used between sessions to identify this media item.
  core.String? id;

  /// Metadata related to the media item, for example the height, width or
  /// creation time.
  MediaMetadata? mediaMetadata;

  /// MIME type of the media item.
  core.String? mimeType;

  /// Google Photos URL for the media item.
  ///
  /// This link will only be available to
  /// the user if they're signed in.
  core.String? productUrl;

  MediaItem();

  MediaItem.fromJson(core.Map _json) {
    if (_json.containsKey('baseUrl')) {
      baseUrl = _json['baseUrl'] as core.String;
    }
    if (_json.containsKey('contributorInfo')) {
      contributorInfo = ContributorInfo.fromJson(
          _json['contributorInfo'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('description')) {
      description = _json['description'] as core.String;
    }
    if (_json.containsKey('id')) {
      id = _json['id'] as core.String;
    }
    if (_json.containsKey('mediaMetadata')) {
      mediaMetadata = MediaMetadata.fromJson(
          _json['mediaMetadata'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('mimeType')) {
      mimeType = _json['mimeType'] as core.String;
    }
    if (_json.containsKey('productUrl')) {
      productUrl = _json['productUrl'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (baseUrl != null) 'baseUrl': baseUrl!,
        if (contributorInfo != null)
          'contributorInfo': contributorInfo!.toJson(),
        if (description != null) 'description': description!,
        if (id != null) 'id': id!,
        if (mediaMetadata != null) 'mediaMetadata': mediaMetadata!.toJson(),
        if (mimeType != null) 'mimeType': mimeType!,
        if (productUrl != null) 'productUrl': productUrl!,
      };
}

/// Metadata for a media item.
class MediaMetadata {
  /// Time when the media item was first created (not when it was uploaded to
  /// Google Photos).
  core.String? creationTime;

  /// Original height (in pixels) of the media item.
  core.String? height;

  /// Metadata for a photo media type.
  Photo? photo;

  /// Metadata for a video media type.
  Video? video;

  /// Original width (in pixels) of the media item.
  core.String? width;

  MediaMetadata();

  MediaMetadata.fromJson(core.Map _json) {
    if (_json.containsKey('creationTime')) {
      creationTime = _json['creationTime'] as core.String;
    }
    if (_json.containsKey('height')) {
      height = _json['height'] as core.String;
    }
    if (_json.containsKey('photo')) {
      photo =
          Photo.fromJson(_json['photo'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('video')) {
      video =
          Video.fromJson(_json['video'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('width')) {
      width = _json['width'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (creationTime != null) 'creationTime': creationTime!,
        if (height != null) 'height': height!,
        if (photo != null) 'photo': photo!.toJson(),
        if (video != null) 'video': video!.toJson(),
        if (width != null) 'width': width!,
      };
}

/// This filter defines the type of media items to be returned, for example
/// videos or photos.
///
/// All the specified media types are treated as an OR with
/// each other.
class MediaTypeFilter {
  /// The types of media items to be included.
  ///
  /// This field should only be
  /// populated with one media type, multiple media types will result in an
  /// error
  /// response.
  core.List<core.String>? mediaTypes;

  MediaTypeFilter();

  MediaTypeFilter.fromJson(core.Map _json) {
    if (_json.containsKey('mediaTypes')) {
      mediaTypes = (_json['mediaTypes'] as core.List)
          .map<core.String>((value) => value as core.String)
          .toList();
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (mediaTypes != null) 'mediaTypes': mediaTypes!,
      };
}

/// A new enrichment item to be added to an album, used by the
/// AddEnrichmentToAlbum call.
class NewEnrichmentItem {
  /// Location to be added to the album.
  LocationEnrichment? locationEnrichment;

  /// Map to be added to the album.
  MapEnrichment? mapEnrichment;

  /// Text to be added to the album.
  TextEnrichment? textEnrichment;

  NewEnrichmentItem();

  NewEnrichmentItem.fromJson(core.Map _json) {
    if (_json.containsKey('locationEnrichment')) {
      locationEnrichment = LocationEnrichment.fromJson(
          _json['locationEnrichment'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('mapEnrichment')) {
      mapEnrichment = MapEnrichment.fromJson(
          _json['mapEnrichment'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('textEnrichment')) {
      textEnrichment = TextEnrichment.fromJson(
          _json['textEnrichment'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (locationEnrichment != null)
          'locationEnrichment': locationEnrichment!.toJson(),
        if (mapEnrichment != null) 'mapEnrichment': mapEnrichment!.toJson(),
        if (textEnrichment != null) 'textEnrichment': textEnrichment!.toJson(),
      };
}

/// New media item that will be created in a user's Google Photos account.
class NewMediaItem {
  /// Description of the media item.
  ///
  /// This will be shown to the user in the item's
  /// info section in the Google Photos app.
  /// This string should not be more than 1000 characters.
  core.String? description;

  /// A new media item that has been uploaded via the included uploadToken.
  SimpleMediaItem? simpleMediaItem;

  NewMediaItem();

  NewMediaItem.fromJson(core.Map _json) {
    if (_json.containsKey('description')) {
      description = _json['description'] as core.String;
    }
    if (_json.containsKey('simpleMediaItem')) {
      simpleMediaItem = SimpleMediaItem.fromJson(
          _json['simpleMediaItem'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (description != null) 'description': description!,
        if (simpleMediaItem != null)
          'simpleMediaItem': simpleMediaItem!.toJson(),
      };
}

/// Result of creating a new media item.
class NewMediaItemResult {
  /// Media item created with the upload token.
  ///
  /// It is populated if no errors
  /// occurred and the media item was created successfully.
  MediaItem? mediaItem;

  /// If an error occurred during the creation of this media item, this field
  /// will be populated with information related to the error.
  ///
  /// Details of this
  /// status can be found down below.
  Status? status;

  /// The upload token used to create this new media item.
  core.String? uploadToken;

  NewMediaItemResult();

  NewMediaItemResult.fromJson(core.Map _json) {
    if (_json.containsKey('mediaItem')) {
      mediaItem = MediaItem.fromJson(
          _json['mediaItem'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('status')) {
      status = Status.fromJson(
          _json['status'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('uploadToken')) {
      uploadToken = _json['uploadToken'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (mediaItem != null) 'mediaItem': mediaItem!.toJson(),
        if (status != null) 'status': status!.toJson(),
        if (uploadToken != null) 'uploadToken': uploadToken!,
      };
}

/// Metadata that is specific to a photo, for example, ISO, focal length and
/// exposure time.
///
/// Some of these fields may be null or not included.
class Photo {
  /// Apeture f number of the photo.
  core.double? apertureFNumber;

  /// Brand of the camera which took the photo.
  core.String? cameraMake;

  /// Model of the camera which took the photo.
  core.String? cameraModel;

  /// Exposure time of the photo.
  core.String? exposureTime;

  /// Focal length of the photo.
  core.double? focalLength;

  /// ISO of the photo.
  core.int? isoEquivalent;

  Photo();

  Photo.fromJson(core.Map _json) {
    if (_json.containsKey('apertureFNumber')) {
      apertureFNumber = (_json['apertureFNumber'] as core.num).toDouble();
    }
    if (_json.containsKey('cameraMake')) {
      cameraMake = _json['cameraMake'] as core.String;
    }
    if (_json.containsKey('cameraModel')) {
      cameraModel = _json['cameraModel'] as core.String;
    }
    if (_json.containsKey('exposureTime')) {
      exposureTime = _json['exposureTime'] as core.String;
    }
    if (_json.containsKey('focalLength')) {
      focalLength = (_json['focalLength'] as core.num).toDouble();
    }
    if (_json.containsKey('isoEquivalent')) {
      isoEquivalent = _json['isoEquivalent'] as core.int;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (apertureFNumber != null) 'apertureFNumber': apertureFNumber!,
        if (cameraMake != null) 'cameraMake': cameraMake!,
        if (cameraModel != null) 'cameraModel': cameraModel!,
        if (exposureTime != null) 'exposureTime': exposureTime!,
        if (focalLength != null) 'focalLength': focalLength!,
        if (isoEquivalent != null) 'isoEquivalent': isoEquivalent!,
      };
}

/// Request to search for media items in a user's library.
///
/// If the album id is specified, this call will return the list of media items
/// in the album.
///
/// If neither filters nor album id are
/// specified, this call will return all media items in a user's Google Photos
/// library.
///
/// If filters are specified, this call will return all media items in
/// the user's library which fulfills the criteria based upon the filters.
///
/// Filters and album id must not both be set, as this will result in an
/// invalid request.
class SearchMediaItemsRequest {
  /// Identifier of an album.
  ///
  /// If populated will list all media items in
  /// specified album. Cannot be set in conjunction with any filters.
  core.String? albumId;

  /// Filters to apply to the request.
  ///
  /// Cannot be set in conjuction with an
  /// albumId.
  Filters? filters;

  /// Maximum number of media items to return in the response.
  ///
  /// The default number
  /// of media items to return at a time is 100. The maximum page size is 500.
  core.int? pageSize;

  /// A continuation token to get the next page of the results.
  ///
  /// Adding this to
  /// the request will return the rows after the pageToken. The pageToken should
  /// be the value returned in the nextPageToken parameter in the response to
  /// the
  /// searchMediaItems request.
  core.String? pageToken;

  SearchMediaItemsRequest();

  SearchMediaItemsRequest.fromJson(core.Map _json) {
    if (_json.containsKey('albumId')) {
      albumId = _json['albumId'] as core.String;
    }
    if (_json.containsKey('filters')) {
      filters = Filters.fromJson(
          _json['filters'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('pageSize')) {
      pageSize = _json['pageSize'] as core.int;
    }
    if (_json.containsKey('pageToken')) {
      pageToken = _json['pageToken'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (albumId != null) 'albumId': albumId!,
        if (filters != null) 'filters': filters!.toJson(),
        if (pageSize != null) 'pageSize': pageSize!,
        if (pageToken != null) 'pageToken': pageToken!,
      };
}

class SearchMediaItemsResponse {
  /// List of media items that match the search parameters.
  ///
  /// Output only.
  core.List<MediaItem>? mediaItems;

  /// Token to use to get the next set of media items.
  ///
  /// Its presence
  /// is the only reliable indicator of more media items being available in the
  /// next request.
  ///
  /// Output only.
  core.String? nextPageToken;

  SearchMediaItemsResponse();

  SearchMediaItemsResponse.fromJson(core.Map _json) {
    if (_json.containsKey('mediaItems')) {
      mediaItems = (_json['mediaItems'] as core.List)
          .map<MediaItem>((value) =>
              MediaItem.fromJson(value as core.Map<core.String, core.dynamic>))
          .toList();
    }
    if (_json.containsKey('nextPageToken')) {
      nextPageToken = _json['nextPageToken'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (mediaItems != null)
          'mediaItems': mediaItems!.map((value) => value.toJson()).toList(),
        if (nextPageToken != null) 'nextPageToken': nextPageToken!,
      };
}

/// Request to make an album shared in Google Photos.
class ShareAlbumRequest {
  /// Options to be set when converting the album to a shared album.
  SharedAlbumOptions? sharedAlbumOptions;

  ShareAlbumRequest();

  ShareAlbumRequest.fromJson(core.Map _json) {
    if (_json.containsKey('sharedAlbumOptions')) {
      sharedAlbumOptions = SharedAlbumOptions.fromJson(
          _json['sharedAlbumOptions'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (sharedAlbumOptions != null)
          'sharedAlbumOptions': sharedAlbumOptions!.toJson(),
      };
}

class ShareAlbumResponse {
  /// Information about the shared album.
  ///
  /// Output only.
  ShareInfo? shareInfo;

  ShareAlbumResponse();

  ShareAlbumResponse.fromJson(core.Map _json) {
    if (_json.containsKey('shareInfo')) {
      shareInfo = ShareInfo.fromJson(
          _json['shareInfo'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (shareInfo != null) 'shareInfo': shareInfo!.toJson(),
      };
}

/// Information about albums that are shared.
///
/// Note that this
/// information is only included if the album was created by you and you have
/// the
/// sharing scope.
class ShareInfo {
  /// A token which can be used to join this shared album on behalf of other
  /// users via the API.
  core.String? shareToken;

  /// A link to the album that's now shared on the Google Photos website and
  /// app.
  /// Anyone with the link can access this shared album and see all of the items
  /// present in the album.
  core.String? shareableUrl;

  /// Options set for the shared album.
  SharedAlbumOptions? sharedAlbumOptions;

  ShareInfo();

  ShareInfo.fromJson(core.Map _json) {
    if (_json.containsKey('shareToken')) {
      shareToken = _json['shareToken'] as core.String;
    }
    if (_json.containsKey('shareableUrl')) {
      shareableUrl = _json['shareableUrl'] as core.String;
    }
    if (_json.containsKey('sharedAlbumOptions')) {
      sharedAlbumOptions = SharedAlbumOptions.fromJson(
          _json['sharedAlbumOptions'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (shareToken != null) 'shareToken': shareToken!,
        if (shareableUrl != null) 'shareableUrl': shareableUrl!,
        if (sharedAlbumOptions != null)
          'sharedAlbumOptions': sharedAlbumOptions!.toJson(),
      };
}

/// Options that control the sharing of an album.
class SharedAlbumOptions {
  /// True if the shared album allows collaborators (users who have joined
  /// the album) to add media items to it.
  ///
  /// Defaults to false.
  core.bool? isCollaborative;

  /// True if the shared album allows the owner and the collaborators (users
  /// who have joined the album) to add comments to the album.
  ///
  /// Defaults to false.
  core.bool? isCommentable;

  SharedAlbumOptions();

  SharedAlbumOptions.fromJson(core.Map _json) {
    if (_json.containsKey('isCollaborative')) {
      isCollaborative = _json['isCollaborative'] as core.bool;
    }
    if (_json.containsKey('isCommentable')) {
      isCommentable = _json['isCommentable'] as core.bool;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (isCollaborative != null) 'isCollaborative': isCollaborative!,
        if (isCommentable != null) 'isCommentable': isCommentable!,
      };
}

/// A simple media item to be created in Google Photos via an upload token.
class SimpleMediaItem {
  /// Token identifying the media bytes which have been uploaded to Google.
  core.String? uploadToken;

  SimpleMediaItem();

  SimpleMediaItem.fromJson(core.Map _json) {
    if (_json.containsKey('uploadToken')) {
      uploadToken = _json['uploadToken'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (uploadToken != null) 'uploadToken': uploadToken!,
      };
}

/// The `Status` type defines a logical error model that is suitable for
/// different
/// programming environments, including REST APIs and RPC APIs.
///
/// It is used by
/// [gRPC](https://github.com/grpc). The error model is designed to be:
///
/// - Simple to use and understand for most users
/// - Flexible enough to meet unexpected needs
///
/// # Overview
///
/// The `Status` message contains three pieces of data: error code, error
/// message,
/// and error details. The error code should be an enum value of
/// google.rpc.Code, but it may accept additional error codes if needed.  The
/// error message should be a developer-facing English message that helps
/// developers *understand* and *resolve* the error. If a localized user-facing
/// error message is needed, put the localized message in the error details or
/// localize it in the client. The optional error details may contain arbitrary
/// information about the error. There is a predefined set of error detail types
/// in the package `google.rpc` that can be used for common error conditions.
///
/// # Language mapping
///
/// The `Status` message is the logical representation of the error model, but
/// it
/// is not necessarily the actual wire format. When the `Status` message is
/// exposed in different client libraries and different wire protocols, it can
/// be
/// mapped differently. For example, it will likely be mapped to some exceptions
/// in Java, but more likely mapped to some error codes in C.
///
/// # Other uses
///
/// The error model and the `Status` message can be used in a variety of
/// environments, either with or without APIs, to provide a
/// consistent developer experience across different environments.
///
/// Example uses of this error model include:
///
/// - Partial errors. If a service needs to return partial errors to the client,
/// it may embed the `Status` in the normal response to indicate the partial
///     errors.
///
/// - Workflow errors. A typical workflow has multiple steps. Each step may
///     have a `Status` message for error reporting.
///
/// - Batch operations. If a client uses batch request and batch response, the
///     `Status` message should be used directly inside batch response, one for
///     each error sub-response.
///
/// - Asynchronous operations. If an API call embeds asynchronous operation
///     results in its response, the status of those operations should be
///     represented directly using the `Status` message.
///
/// - Logging. If some API errors are stored in logs, the message `Status` could
/// be used directly after any stripping needed for security/privacy reasons.
class Status {
  /// The status code, which should be an enum value of google.rpc.Code.
  core.int? code;

  /// A list of messages that carry the error details.
  ///
  ///  There is a common set of
  /// message types for APIs to use.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.List<core.Map<core.String, core.Object>>? details;

  /// A developer-facing error message, which should be in English.
  ///
  /// Any
  /// user-facing error message should be localized and sent in the
  /// google.rpc.Status.details field, or localized by the client.
  core.String? message;

  Status();

  Status.fromJson(core.Map _json) {
    if (_json.containsKey('code')) {
      code = _json['code'] as core.int;
    }
    if (_json.containsKey('details')) {
      details = (_json['details'] as core.List)
          .map<core.Map<core.String, core.Object>>(
              (value) => (value as core.Map<core.String, core.dynamic>).map(
                    (key, item) => core.MapEntry(
                      key,
                      item as core.Object,
                    ),
                  ))
          .toList();
    }
    if (_json.containsKey('message')) {
      message = _json['message'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (code != null) 'code': code!,
        if (details != null) 'details': details!,
        if (message != null) 'message': message!,
      };
}

/// An enrichment containing text.
class TextEnrichment {
  /// Text for this text enrichment item.
  core.String? text;

  TextEnrichment();

  TextEnrichment.fromJson(core.Map _json) {
    if (_json.containsKey('text')) {
      text = _json['text'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (text != null) 'text': text!,
      };
}

/// Metadata that is specific to a video, for example, fps and processing
/// status.
/// Some of these fields may be null or not included.
class Video {
  /// Brand of the camera which took the video.
  core.String? cameraMake;

  /// Model of the camera which took the video.
  core.String? cameraModel;

  /// Frame rate of the video.
  core.double? fps;

  /// Processing status of the video.
  /// Possible string values are:
  /// - "UNSPECIFIED" : Video processing status is unknown.
  /// - "PROCESSING" : Video is currently being processed. The user will see an
  /// icon for this
  /// video in the Google Photos app, however, it will not be playable yet.
  /// - "READY" : Video is now ready for viewing.
  /// - "FAILED" : Something has gone wrong and the video has failed to process.
  core.String? status;

  Video();

  Video.fromJson(core.Map _json) {
    if (_json.containsKey('cameraMake')) {
      cameraMake = _json['cameraMake'] as core.String;
    }
    if (_json.containsKey('cameraModel')) {
      cameraModel = _json['cameraModel'] as core.String;
    }
    if (_json.containsKey('fps')) {
      fps = (_json['fps'] as core.num).toDouble();
    }
    if (_json.containsKey('status')) {
      status = _json['status'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (cameraMake != null) 'cameraMake': cameraMake!,
        if (cameraModel != null) 'cameraModel': cameraModel!,
        if (fps != null) 'fps': fps!,
        if (status != null) 'status': status!,
      };
}
