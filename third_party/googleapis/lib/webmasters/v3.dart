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

/// Search Console API - v3
///
/// View Google Search Console data for your verified sites.
///
/// For more information, see <https://developers.google.com/webmaster-tools/>
///
/// Create an instance of [WebmastersApi] to access these resources:
///
/// - [SearchanalyticsResource]
/// - [SitemapsResource]
/// - [SitesResource]
library webmasters.v3;

import 'dart:async' as async;
import 'dart:convert' as convert;
import 'dart:core' as core;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

import '../src/user_agent.dart';

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

/// View Google Search Console data for your verified sites.
class WebmastersApi {
  /// View and manage Search Console data for your verified sites
  static const webmastersScope = 'https://www.googleapis.com/auth/webmasters';

  /// View Search Console data for your verified sites
  static const webmastersReadonlyScope =
      'https://www.googleapis.com/auth/webmasters.readonly';

  final commons.ApiRequester _requester;

  SearchanalyticsResource get searchanalytics =>
      SearchanalyticsResource(_requester);
  SitemapsResource get sitemaps => SitemapsResource(_requester);
  SitesResource get sites => SitesResource(_requester);

  WebmastersApi(http.Client client,
      {core.String rootUrl = 'https://www.googleapis.com/',
      core.String servicePath = 'webmasters/v3/'})
      : _requester =
            commons.ApiRequester(client, rootUrl, servicePath, requestHeaders);
}

class SearchanalyticsResource {
  final commons.ApiRequester _requester;

  SearchanalyticsResource(commons.ApiRequester client) : _requester = client;

  /// Query your data with filters and parameters that you define.
  ///
  /// Returns zero or more rows grouped by the row keys that you define. You
  /// must define a date range of one or more days.
  ///
  /// When date is one of the group by values, any days without data are omitted
  /// from the result list. If you need to know which days have data, issue a
  /// broad date range query grouped by date for any metric, and see which day
  /// rows are returned.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [siteUrl] - The site's URL, including protocol. For example:
  /// http://www.example.com/
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [SearchAnalyticsQueryResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<SearchAnalyticsQueryResponse> query(
    SearchAnalyticsQueryRequest request,
    core.String siteUrl, {
    core.String? $fields,
  }) async {
    final _body = convert.json.encode(request.toJson());
    final _queryParams = <core.String, core.List<core.String>>{
      if ($fields != null) 'fields': [$fields],
    };

    final _url = 'sites/' +
        commons.escapeVariable('$siteUrl') +
        '/searchAnalytics/query';

    final _response = await _requester.request(
      _url,
      'POST',
      body: _body,
      queryParams: _queryParams,
    );
    return SearchAnalyticsQueryResponse.fromJson(
        _response as core.Map<core.String, core.dynamic>);
  }
}

class SitemapsResource {
  final commons.ApiRequester _requester;

  SitemapsResource(commons.ApiRequester client) : _requester = client;

  /// Deletes a sitemap from this site.
  ///
  /// Request parameters:
  ///
  /// [siteUrl] - The site's URL, including protocol. For example:
  /// http://www.example.com/
  ///
  /// [feedpath] - The URL of the actual sitemap. For example:
  /// http://www.example.com/sitemap.xml
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<void> delete(
    core.String siteUrl,
    core.String feedpath, {
    core.String? $fields,
  }) async {
    final _queryParams = <core.String, core.List<core.String>>{
      if ($fields != null) 'fields': [$fields],
    };

    final _url = 'sites/' +
        commons.escapeVariable('$siteUrl') +
        '/sitemaps/' +
        commons.escapeVariable('$feedpath');

    await _requester.request(
      _url,
      'DELETE',
      queryParams: _queryParams,
      downloadOptions: null,
    );
  }

  /// Retrieves information about a specific sitemap.
  ///
  /// Request parameters:
  ///
  /// [siteUrl] - The site's URL, including protocol. For example:
  /// http://www.example.com/
  ///
  /// [feedpath] - The URL of the actual sitemap. For example:
  /// http://www.example.com/sitemap.xml
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [WmxSitemap].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<WmxSitemap> get(
    core.String siteUrl,
    core.String feedpath, {
    core.String? $fields,
  }) async {
    final _queryParams = <core.String, core.List<core.String>>{
      if ($fields != null) 'fields': [$fields],
    };

    final _url = 'sites/' +
        commons.escapeVariable('$siteUrl') +
        '/sitemaps/' +
        commons.escapeVariable('$feedpath');

    final _response = await _requester.request(
      _url,
      'GET',
      queryParams: _queryParams,
    );
    return WmxSitemap.fromJson(
        _response as core.Map<core.String, core.dynamic>);
  }

  /// Lists the sitemaps-entries submitted for this site, or included in the
  /// sitemap index file (if sitemapIndex is specified in the request).
  ///
  /// Request parameters:
  ///
  /// [siteUrl] - The site's URL, including protocol. For example:
  /// http://www.example.com/
  ///
  /// [sitemapIndex] - A URL of a site's sitemap index. For example:
  /// http://www.example.com/sitemapindex.xml
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [SitemapsListResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<SitemapsListResponse> list(
    core.String siteUrl, {
    core.String? sitemapIndex,
    core.String? $fields,
  }) async {
    final _queryParams = <core.String, core.List<core.String>>{
      if (sitemapIndex != null) 'sitemapIndex': [sitemapIndex],
      if ($fields != null) 'fields': [$fields],
    };

    final _url = 'sites/' + commons.escapeVariable('$siteUrl') + '/sitemaps';

    final _response = await _requester.request(
      _url,
      'GET',
      queryParams: _queryParams,
    );
    return SitemapsListResponse.fromJson(
        _response as core.Map<core.String, core.dynamic>);
  }

  /// Submits a sitemap for a site.
  ///
  /// Request parameters:
  ///
  /// [siteUrl] - The site's URL, including protocol. For example:
  /// http://www.example.com/
  ///
  /// [feedpath] - The URL of the sitemap to add. For example:
  /// http://www.example.com/sitemap.xml
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<void> submit(
    core.String siteUrl,
    core.String feedpath, {
    core.String? $fields,
  }) async {
    final _queryParams = <core.String, core.List<core.String>>{
      if ($fields != null) 'fields': [$fields],
    };

    final _url = 'sites/' +
        commons.escapeVariable('$siteUrl') +
        '/sitemaps/' +
        commons.escapeVariable('$feedpath');

    await _requester.request(
      _url,
      'PUT',
      queryParams: _queryParams,
      downloadOptions: null,
    );
  }
}

class SitesResource {
  final commons.ApiRequester _requester;

  SitesResource(commons.ApiRequester client) : _requester = client;

  /// Adds a site to the set of the user's sites in Search Console.
  ///
  /// Request parameters:
  ///
  /// [siteUrl] - The URL of the site to add.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<void> add(
    core.String siteUrl, {
    core.String? $fields,
  }) async {
    final _queryParams = <core.String, core.List<core.String>>{
      if ($fields != null) 'fields': [$fields],
    };

    final _url = 'sites/' + commons.escapeVariable('$siteUrl');

    await _requester.request(
      _url,
      'PUT',
      queryParams: _queryParams,
      downloadOptions: null,
    );
  }

  /// Removes a site from the set of the user's Search Console sites.
  ///
  /// Request parameters:
  ///
  /// [siteUrl] - The URI of the property as defined in Search Console.
  /// Examples: http://www.example.com/ or android-app://com.example/ Note: for
  /// property-sets, use the URI that starts with sc-set: which is used in
  /// Search Console URLs.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<void> delete(
    core.String siteUrl, {
    core.String? $fields,
  }) async {
    final _queryParams = <core.String, core.List<core.String>>{
      if ($fields != null) 'fields': [$fields],
    };

    final _url = 'sites/' + commons.escapeVariable('$siteUrl');

    await _requester.request(
      _url,
      'DELETE',
      queryParams: _queryParams,
      downloadOptions: null,
    );
  }

  /// Retrieves information about specific site.
  ///
  /// Request parameters:
  ///
  /// [siteUrl] - The URI of the property as defined in Search Console.
  /// Examples: http://www.example.com/ or android-app://com.example/ Note: for
  /// property-sets, use the URI that starts with sc-set: which is used in
  /// Search Console URLs.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [WmxSite].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<WmxSite> get(
    core.String siteUrl, {
    core.String? $fields,
  }) async {
    final _queryParams = <core.String, core.List<core.String>>{
      if ($fields != null) 'fields': [$fields],
    };

    final _url = 'sites/' + commons.escapeVariable('$siteUrl');

    final _response = await _requester.request(
      _url,
      'GET',
      queryParams: _queryParams,
    );
    return WmxSite.fromJson(_response as core.Map<core.String, core.dynamic>);
  }

  /// Lists the user's Search Console sites.
  ///
  /// Request parameters:
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [SitesListResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<SitesListResponse> list({
    core.String? $fields,
  }) async {
    final _queryParams = <core.String, core.List<core.String>>{
      if ($fields != null) 'fields': [$fields],
    };

    const _url = 'sites';

    final _response = await _requester.request(
      _url,
      'GET',
      queryParams: _queryParams,
    );
    return SitesListResponse.fromJson(
        _response as core.Map<core.String, core.dynamic>);
  }
}

class ApiDataRow {
  core.double? clicks;
  core.double? ctr;
  core.double? impressions;
  core.List<core.String>? keys;
  core.double? position;

  ApiDataRow();

  ApiDataRow.fromJson(core.Map _json) {
    if (_json.containsKey('clicks')) {
      clicks = (_json['clicks'] as core.num).toDouble();
    }
    if (_json.containsKey('ctr')) {
      ctr = (_json['ctr'] as core.num).toDouble();
    }
    if (_json.containsKey('impressions')) {
      impressions = (_json['impressions'] as core.num).toDouble();
    }
    if (_json.containsKey('keys')) {
      keys = (_json['keys'] as core.List)
          .map<core.String>((value) => value as core.String)
          .toList();
    }
    if (_json.containsKey('position')) {
      position = (_json['position'] as core.num).toDouble();
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (clicks != null) 'clicks': clicks!,
        if (ctr != null) 'ctr': ctr!,
        if (impressions != null) 'impressions': impressions!,
        if (keys != null) 'keys': keys!,
        if (position != null) 'position': position!,
      };
}

class ApiDimensionFilter {
  core.String? dimension;
  core.String? expression;
  core.String? operator;

  ApiDimensionFilter();

  ApiDimensionFilter.fromJson(core.Map _json) {
    if (_json.containsKey('dimension')) {
      dimension = _json['dimension'] as core.String;
    }
    if (_json.containsKey('expression')) {
      expression = _json['expression'] as core.String;
    }
    if (_json.containsKey('operator')) {
      operator = _json['operator'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (dimension != null) 'dimension': dimension!,
        if (expression != null) 'expression': expression!,
        if (operator != null) 'operator': operator!,
      };
}

class ApiDimensionFilterGroup {
  core.List<ApiDimensionFilter>? filters;
  core.String? groupType;

  ApiDimensionFilterGroup();

  ApiDimensionFilterGroup.fromJson(core.Map _json) {
    if (_json.containsKey('filters')) {
      filters = (_json['filters'] as core.List)
          .map<ApiDimensionFilter>((value) => ApiDimensionFilter.fromJson(
              value as core.Map<core.String, core.dynamic>))
          .toList();
    }
    if (_json.containsKey('groupType')) {
      groupType = _json['groupType'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (filters != null)
          'filters': filters!.map((value) => value.toJson()).toList(),
        if (groupType != null) 'groupType': groupType!,
      };
}

class SearchAnalyticsQueryRequest {
  /// \[Optional; Default is "auto"\] How data is aggregated.
  ///
  /// If aggregated by property, all data for the same property is aggregated;
  /// if aggregated by page, all data is aggregated by canonical URI. If you
  /// filter or group by page, choose AUTO; otherwise you can aggregate either
  /// by property or by page, depending on how you want your data calculated;
  /// see the help documentation to learn how data is calculated differently by
  /// site versus by page.
  ///
  /// Note: If you group or filter by page, you cannot aggregate by property.
  ///
  /// If you specify any value other than AUTO, the aggregation type in the
  /// result will match the requested type, or if you request an invalid type,
  /// you will get an error. The API will never change your aggregation type if
  /// the requested type is invalid.
  core.String? aggregationType;

  /// If "all" (case-insensitive), data will include fresh data.
  ///
  /// If "final" (case-insensitive) or if this parameter is omitted, the
  /// returned data will include only finalized data.
  ///
  /// Optional.
  core.String? dataState;

  /// Zero or more filters to apply to the dimension grouping values; for
  /// example, 'query contains "buy"' to see only data where the query string
  /// contains the substring "buy" (not case-sensitive).
  ///
  /// You can filter by a dimension without grouping by it.
  ///
  /// Optional.
  core.List<ApiDimensionFilterGroup>? dimensionFilterGroups;

  /// Zero or more dimensions to group results by.
  ///
  /// Dimensions are the group-by values in the Search Analytics page.
  /// Dimensions are combined to create a unique row key for each row. Results
  /// are grouped in the order that you supply these dimensions.
  ///
  /// Optional.
  core.List<core.String>? dimensions;

  /// End date of the requested date range, in YYYY-MM-DD format, in PST (UTC -
  /// 8:00).
  ///
  /// Must be greater than or equal to the start date. This value is included in
  /// the range.
  ///
  /// Required.
  core.String? endDate;

  /// \[Optional; Default is 1000\] The maximum number of rows to return.
  ///
  /// Must be a number from 1 to 5,000 (inclusive).
  core.int? rowLimit;

  /// \[Optional; Default is "web"\] The search type to filter for.
  core.String? searchType;

  /// Start date of the requested date range, in YYYY-MM-DD format, in PST time
  /// (UTC - 8:00).
  ///
  /// Must be less than or equal to the end date. This value is included in the
  /// range.
  ///
  /// Required.
  core.String? startDate;

  /// \[Optional; Default is 0\] Zero-based index of the first row in the
  /// response.
  ///
  /// Must be a non-negative number.
  core.int? startRow;

  SearchAnalyticsQueryRequest();

  SearchAnalyticsQueryRequest.fromJson(core.Map _json) {
    if (_json.containsKey('aggregationType')) {
      aggregationType = _json['aggregationType'] as core.String;
    }
    if (_json.containsKey('dataState')) {
      dataState = _json['dataState'] as core.String;
    }
    if (_json.containsKey('dimensionFilterGroups')) {
      dimensionFilterGroups = (_json['dimensionFilterGroups'] as core.List)
          .map<ApiDimensionFilterGroup>((value) =>
              ApiDimensionFilterGroup.fromJson(
                  value as core.Map<core.String, core.dynamic>))
          .toList();
    }
    if (_json.containsKey('dimensions')) {
      dimensions = (_json['dimensions'] as core.List)
          .map<core.String>((value) => value as core.String)
          .toList();
    }
    if (_json.containsKey('endDate')) {
      endDate = _json['endDate'] as core.String;
    }
    if (_json.containsKey('rowLimit')) {
      rowLimit = _json['rowLimit'] as core.int;
    }
    if (_json.containsKey('searchType')) {
      searchType = _json['searchType'] as core.String;
    }
    if (_json.containsKey('startDate')) {
      startDate = _json['startDate'] as core.String;
    }
    if (_json.containsKey('startRow')) {
      startRow = _json['startRow'] as core.int;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (aggregationType != null) 'aggregationType': aggregationType!,
        if (dataState != null) 'dataState': dataState!,
        if (dimensionFilterGroups != null)
          'dimensionFilterGroups':
              dimensionFilterGroups!.map((value) => value.toJson()).toList(),
        if (dimensions != null) 'dimensions': dimensions!,
        if (endDate != null) 'endDate': endDate!,
        if (rowLimit != null) 'rowLimit': rowLimit!,
        if (searchType != null) 'searchType': searchType!,
        if (startDate != null) 'startDate': startDate!,
        if (startRow != null) 'startRow': startRow!,
      };
}

/// A list of rows, one per result, grouped by key.
///
/// Metrics in each row are aggregated for all data grouped by that key either
/// by page or property, as specified by the aggregation type parameter.
class SearchAnalyticsQueryResponse {
  /// How the results were aggregated.
  core.String? responseAggregationType;

  /// A list of rows grouped by the key values in the order given in the query.
  core.List<ApiDataRow>? rows;

  SearchAnalyticsQueryResponse();

  SearchAnalyticsQueryResponse.fromJson(core.Map _json) {
    if (_json.containsKey('responseAggregationType')) {
      responseAggregationType = _json['responseAggregationType'] as core.String;
    }
    if (_json.containsKey('rows')) {
      rows = (_json['rows'] as core.List)
          .map<ApiDataRow>((value) =>
              ApiDataRow.fromJson(value as core.Map<core.String, core.dynamic>))
          .toList();
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (responseAggregationType != null)
          'responseAggregationType': responseAggregationType!,
        if (rows != null) 'rows': rows!.map((value) => value.toJson()).toList(),
      };
}

/// List of sitemaps.
class SitemapsListResponse {
  /// Contains detailed information about a specific URL submitted as a sitemap.
  core.List<WmxSitemap>? sitemap;

  SitemapsListResponse();

  SitemapsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey('sitemap')) {
      sitemap = (_json['sitemap'] as core.List)
          .map<WmxSitemap>((value) =>
              WmxSitemap.fromJson(value as core.Map<core.String, core.dynamic>))
          .toList();
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (sitemap != null)
          'sitemap': sitemap!.map((value) => value.toJson()).toList(),
      };
}

/// List of sites with access level information.
class SitesListResponse {
  /// Contains permission level information about a Search Console site.
  ///
  /// For more information, see Permissions in Search Console.
  core.List<WmxSite>? siteEntry;

  SitesListResponse();

  SitesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey('siteEntry')) {
      siteEntry = (_json['siteEntry'] as core.List)
          .map<WmxSite>((value) =>
              WmxSite.fromJson(value as core.Map<core.String, core.dynamic>))
          .toList();
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (siteEntry != null)
          'siteEntry': siteEntry!.map((value) => value.toJson()).toList(),
      };
}

/// Contains permission level information about a Search Console site.
///
/// For more information, see  Permissions in Search Console.
class WmxSite {
  /// The user's permission level for the site.
  core.String? permissionLevel;

  /// The URL of the site.
  core.String? siteUrl;

  WmxSite();

  WmxSite.fromJson(core.Map _json) {
    if (_json.containsKey('permissionLevel')) {
      permissionLevel = _json['permissionLevel'] as core.String;
    }
    if (_json.containsKey('siteUrl')) {
      siteUrl = _json['siteUrl'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (permissionLevel != null) 'permissionLevel': permissionLevel!,
        if (siteUrl != null) 'siteUrl': siteUrl!,
      };
}

/// Contains detailed information about a specific URL submitted as a sitemap.
class WmxSitemap {
  /// The various content types in the sitemap.
  core.List<WmxSitemapContent>? contents;

  /// Number of errors in the sitemap.
  ///
  /// These are issues with the sitemap itself that need to be fixed before it
  /// can be processed correctly.
  core.String? errors;

  /// If true, the sitemap has not been processed.
  core.bool? isPending;

  /// If true, the sitemap is a collection of sitemaps.
  core.bool? isSitemapsIndex;

  /// Date & time in which this sitemap was last downloaded.
  ///
  /// Date format is in RFC 3339 format (yyyy-mm-dd).
  core.DateTime? lastDownloaded;

  /// Date & time in which this sitemap was submitted.
  ///
  /// Date format is in RFC 3339 format (yyyy-mm-dd).
  core.DateTime? lastSubmitted;

  /// The url of the sitemap.
  core.String? path;

  /// The type of the sitemap.
  ///
  /// For example: rssFeed.
  core.String? type;

  /// Number of warnings for the sitemap.
  ///
  /// These are generally non-critical issues with URLs in the sitemaps.
  core.String? warnings;

  WmxSitemap();

  WmxSitemap.fromJson(core.Map _json) {
    if (_json.containsKey('contents')) {
      contents = (_json['contents'] as core.List)
          .map<WmxSitemapContent>((value) => WmxSitemapContent.fromJson(
              value as core.Map<core.String, core.dynamic>))
          .toList();
    }
    if (_json.containsKey('errors')) {
      errors = _json['errors'] as core.String;
    }
    if (_json.containsKey('isPending')) {
      isPending = _json['isPending'] as core.bool;
    }
    if (_json.containsKey('isSitemapsIndex')) {
      isSitemapsIndex = _json['isSitemapsIndex'] as core.bool;
    }
    if (_json.containsKey('lastDownloaded')) {
      lastDownloaded =
          core.DateTime.parse(_json['lastDownloaded'] as core.String);
    }
    if (_json.containsKey('lastSubmitted')) {
      lastSubmitted =
          core.DateTime.parse(_json['lastSubmitted'] as core.String);
    }
    if (_json.containsKey('path')) {
      path = _json['path'] as core.String;
    }
    if (_json.containsKey('type')) {
      type = _json['type'] as core.String;
    }
    if (_json.containsKey('warnings')) {
      warnings = _json['warnings'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (contents != null)
          'contents': contents!.map((value) => value.toJson()).toList(),
        if (errors != null) 'errors': errors!,
        if (isPending != null) 'isPending': isPending!,
        if (isSitemapsIndex != null) 'isSitemapsIndex': isSitemapsIndex!,
        if (lastDownloaded != null)
          'lastDownloaded': lastDownloaded!.toIso8601String(),
        if (lastSubmitted != null)
          'lastSubmitted': lastSubmitted!.toIso8601String(),
        if (path != null) 'path': path!,
        if (type != null) 'type': type!,
        if (warnings != null) 'warnings': warnings!,
      };
}

/// Information about the various content types in the sitemap.
class WmxSitemapContent {
  /// The number of URLs from the sitemap that were indexed (of the content
  /// type).
  core.String? indexed;

  /// The number of URLs in the sitemap (of the content type).
  core.String? submitted;

  /// The specific type of content in this sitemap.
  ///
  /// For example: web.
  core.String? type;

  WmxSitemapContent();

  WmxSitemapContent.fromJson(core.Map _json) {
    if (_json.containsKey('indexed')) {
      indexed = _json['indexed'] as core.String;
    }
    if (_json.containsKey('submitted')) {
      submitted = _json['submitted'] as core.String;
    }
    if (_json.containsKey('type')) {
      type = _json['type'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (indexed != null) 'indexed': indexed!,
        if (submitted != null) 'submitted': submitted!,
        if (type != null) 'type': type!,
      };
}
