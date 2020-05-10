// This is a generated file (see the discoveryapis_generator project).

// ignore_for_file: unnecessary_cast

library googleapis.abusiveexperiencereport.v1;

import 'dart:core' as core;
import 'dart:async' as async;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client abusiveexperiencereport/v1';

/// Views Abusive Experience Report data, and gets a list of sites that have a
/// significant number of abusive experiences.
class AbusiveexperiencereportApi {
  /// Test scope for access to the Zoo service
  static const XapiZooScope = "https://www.googleapis.com/auth/xapi.zoo";

  final commons.ApiRequester _requester;

  SitesResourceApi get sites => new SitesResourceApi(_requester);
  ViolatingSitesResourceApi get violatingSites =>
      new ViolatingSitesResourceApi(_requester);

  AbusiveexperiencereportApi(http.Client client,
      {core.String rootUrl: "https://abusiveexperiencereport.googleapis.com/",
      core.String servicePath: ""})
      : _requester =
            new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}

class SitesResourceApi {
  final commons.ApiRequester _requester;

  SitesResourceApi(commons.ApiRequester client) : _requester = client;

  /// Gets a summary of the abusive experience rating of a site.
  ///
  /// Request parameters:
  ///
  /// [name] - The required site name. This is the site property whose abusive
  /// experiences have been reviewed, and it must be URL-encoded. For example,
  /// sites/https%3A%2F%2Fwww.google.com. The server will return an error of
  /// BAD_REQUEST if this field is not filled in. Note that if the site property
  /// is not yet verified in Search Console, the reportUrl field
  /// returned by the API will lead to the verification page, prompting the user
  /// to go through that process before they can gain access to the Abusive
  /// Experience Report.
  /// Value must have pattern "^sites/[^/]+$".
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [SiteSummaryResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<SiteSummaryResponse> get(core.String name,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$name');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new SiteSummaryResponse.fromJson(data));
  }
}

class ViolatingSitesResourceApi {
  final commons.ApiRequester _requester;

  ViolatingSitesResourceApi(commons.ApiRequester client) : _requester = client;

  /// Lists sites with Abusive Experience Report statuses of "Failing".
  ///
  /// Request parameters:
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [ViolatingSitesResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ViolatingSitesResponse> list({core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = 'v1/violatingSites';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ViolatingSitesResponse.fromJson(data));
  }
}

/// Response message for GetSiteSummary.
class SiteSummaryResponse {
  /// The status of the site reviewed for the abusive experiences.
  /// Possible string values are:
  /// - "UNKNOWN" : Not reviewed.
  /// - "PASSING" : Passing.
  /// - "FAILING" : Failing.
  core.String abusiveStatus;

  /// The date on which enforcement begins.
  core.String enforcementTime;

  /// The abusive experience enforcement status of the site.
  /// Possible string values are:
  /// - "UNKNOWN" : N/A.
  /// - "ON" : Ad filtering is on.
  /// - "OFF" : Ad filtering is off.
  /// - "PAUSED" : Ad filtering is paused.
  /// - "PENDING" : Ad filtering is pending.
  core.String filterStatus;

  /// The last time that the site changed status.
  core.String lastChangeTime;

  /// A link that leads to a full abusive experience report.
  core.String reportUrl;

  /// The name of the site reviewed.
  core.String reviewedSite;

  /// Whether the site is currently under review.
  core.bool underReview;

  SiteSummaryResponse();

  SiteSummaryResponse.fromJson(core.Map _json) {
    if (_json.containsKey("abusiveStatus")) {
      abusiveStatus = _json["abusiveStatus"];
    }
    if (_json.containsKey("enforcementTime")) {
      enforcementTime = _json["enforcementTime"];
    }
    if (_json.containsKey("filterStatus")) {
      filterStatus = _json["filterStatus"];
    }
    if (_json.containsKey("lastChangeTime")) {
      lastChangeTime = _json["lastChangeTime"];
    }
    if (_json.containsKey("reportUrl")) {
      reportUrl = _json["reportUrl"];
    }
    if (_json.containsKey("reviewedSite")) {
      reviewedSite = _json["reviewedSite"];
    }
    if (_json.containsKey("underReview")) {
      underReview = _json["underReview"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (abusiveStatus != null) {
      _json["abusiveStatus"] = abusiveStatus;
    }
    if (enforcementTime != null) {
      _json["enforcementTime"] = enforcementTime;
    }
    if (filterStatus != null) {
      _json["filterStatus"] = filterStatus;
    }
    if (lastChangeTime != null) {
      _json["lastChangeTime"] = lastChangeTime;
    }
    if (reportUrl != null) {
      _json["reportUrl"] = reportUrl;
    }
    if (reviewedSite != null) {
      _json["reviewedSite"] = reviewedSite;
    }
    if (underReview != null) {
      _json["underReview"] = underReview;
    }
    return _json;
  }
}

/// Response message for ListViolatingSites.
class ViolatingSitesResponse {
  /// A list of summaries of violating sites.
  core.List<SiteSummaryResponse> violatingSites;

  ViolatingSitesResponse();

  ViolatingSitesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("violatingSites")) {
      violatingSites = (_json["violatingSites"] as core.List)
          .map<SiteSummaryResponse>(
              (value) => new SiteSummaryResponse.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (violatingSites != null) {
      _json["violatingSites"] =
          violatingSites.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}
