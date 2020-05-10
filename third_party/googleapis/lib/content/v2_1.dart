// This is a generated file (see the discoveryapis_generator project).

// ignore_for_file: unnecessary_cast

library googleapis.content.v2_1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client content/v2.1';

/// Manages product items, inventory, and Merchant Center accounts for Google
/// Shopping.
class ContentApi {
  /// Manage your product listings and accounts for Google Shopping
  static const ContentScope = "https://www.googleapis.com/auth/content";

  final commons.ApiRequester _requester;

  AccountsResourceApi get accounts => new AccountsResourceApi(_requester);
  AccountstatusesResourceApi get accountstatuses =>
      new AccountstatusesResourceApi(_requester);
  AccounttaxResourceApi get accounttax => new AccounttaxResourceApi(_requester);
  DatafeedsResourceApi get datafeeds => new DatafeedsResourceApi(_requester);
  DatafeedstatusesResourceApi get datafeedstatuses =>
      new DatafeedstatusesResourceApi(_requester);
  LiasettingsResourceApi get liasettings =>
      new LiasettingsResourceApi(_requester);
  OrderinvoicesResourceApi get orderinvoices =>
      new OrderinvoicesResourceApi(_requester);
  OrderpaymentsResourceApi get orderpayments =>
      new OrderpaymentsResourceApi(_requester);
  OrderreportsResourceApi get orderreports =>
      new OrderreportsResourceApi(_requester);
  OrderreturnsResourceApi get orderreturns =>
      new OrderreturnsResourceApi(_requester);
  OrdersResourceApi get orders => new OrdersResourceApi(_requester);
  PosResourceApi get pos => new PosResourceApi(_requester);
  ProductsResourceApi get products => new ProductsResourceApi(_requester);
  ProductstatusesResourceApi get productstatuses =>
      new ProductstatusesResourceApi(_requester);
  ShippingsettingsResourceApi get shippingsettings =>
      new ShippingsettingsResourceApi(_requester);

  ContentApi(http.Client client,
      {core.String rootUrl: "https://www.googleapis.com/",
      core.String servicePath: "content/v2.1/"})
      : _requester =
            new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}

class AccountsResourceApi {
  final commons.ApiRequester _requester;

  AccountsResourceApi(commons.ApiRequester client) : _requester = client;

  /// Returns information about the authenticated user.
  ///
  /// Request parameters:
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [AccountsAuthInfoResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<AccountsAuthInfoResponse> authinfo({core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = 'accounts/authinfo';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new AccountsAuthInfoResponse.fromJson(data));
  }

  /// Claims the website of a Merchant Center sub-account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the managing account. If this parameter is not
  /// the same as accountId, then this account must be a multi-client account
  /// and accountId must be the ID of a sub-account of this account.
  ///
  /// [accountId] - The ID of the account whose website is claimed.
  ///
  /// [overwrite] - Only available to selected merchants. When set to True, this
  /// flag removes any existing claim on the requested website by another
  /// account and replaces it with a claim from this account.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [AccountsClaimWebsiteResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<AccountsClaimWebsiteResponse> claimwebsite(
      core.String merchantId, core.String accountId,
      {core.bool overwrite, core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (overwrite != null) {
      _queryParams["overwrite"] = ["${overwrite}"];
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/claimwebsite';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new AccountsClaimWebsiteResponse.fromJson(data));
  }

  /// Retrieves, inserts, updates, and deletes multiple Merchant Center
  /// (sub-)accounts in a single request.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [AccountsCustomBatchResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<AccountsCustomBatchResponse> custombatch(
      AccountsCustomBatchRequest request,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = 'accounts/batch';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new AccountsCustomBatchResponse.fromJson(data));
  }

  /// Deletes a Merchant Center sub-account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the managing account. This must be a multi-client
  /// account, and accountId must be the ID of a sub-account of this account.
  ///
  /// [accountId] - The ID of the account.
  ///
  /// [force] - Flag to delete sub-accounts with products. The default value is
  /// false.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future delete(core.String merchantId, core.String accountId,
      {core.bool force, core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (force != null) {
      _queryParams["force"] = ["${force}"];
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/accounts/' +
        commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /// Retrieves a Merchant Center account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the managing account. If this parameter is not
  /// the same as accountId, then this account must be a multi-client account
  /// and accountId must be the ID of a sub-account of this account.
  ///
  /// [accountId] - The ID of the account.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [Account].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Account> get(core.String merchantId, core.String accountId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/accounts/' +
        commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Account.fromJson(data));
  }

  /// Creates a Merchant Center sub-account.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the managing account. This must be a multi-client
  /// account.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [Account].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Account> insert(Account request, core.String merchantId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/accounts';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Account.fromJson(data));
  }

  /// Performs an action on a link between a Merchant Center account and another
  /// account.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the managing account. If this parameter is not
  /// the same as accountId, then this account must be a multi-client account
  /// and accountId must be the ID of a sub-account of this account.
  ///
  /// [accountId] - The ID of the account that should be linked.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [AccountsLinkResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<AccountsLinkResponse> link(AccountsLinkRequest request,
      core.String merchantId, core.String accountId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/accounts/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/link';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountsLinkResponse.fromJson(data));
  }

  /// Lists the sub-accounts in your Merchant Center account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the managing account. This must be a multi-client
  /// account.
  ///
  /// [maxResults] - The maximum number of accounts to return in the response,
  /// used for paging.
  ///
  /// [pageToken] - The token returned by the previous request.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [AccountsListResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<AccountsListResponse> list(core.String merchantId,
      {core.int maxResults, core.String pageToken, core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/accounts';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountsListResponse.fromJson(data));
  }

  /// Updates a Merchant Center account.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the managing account. If this parameter is not
  /// the same as accountId, then this account must be a multi-client account
  /// and accountId must be the ID of a sub-account of this account.
  ///
  /// [accountId] - The ID of the account.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [Account].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Account> update(
      Account request, core.String merchantId, core.String accountId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/accounts/' +
        commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url, "PUT",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Account.fromJson(data));
  }
}

class AccountstatusesResourceApi {
  final commons.ApiRequester _requester;

  AccountstatusesResourceApi(commons.ApiRequester client) : _requester = client;

  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [AccountstatusesCustomBatchResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<AccountstatusesCustomBatchResponse> custombatch(
      AccountstatusesCustomBatchRequest request,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = 'accountstatuses/batch';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new AccountstatusesCustomBatchResponse.fromJson(data));
  }

  /// Retrieves the status of a Merchant Center account. Multi-client accounts
  /// can only call this method for sub-accounts.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the managing account. If this parameter is not
  /// the same as accountId, then this account must be a multi-client account
  /// and accountId must be the ID of a sub-account of this account.
  ///
  /// [accountId] - The ID of the account.
  ///
  /// [destinations] - If set, only issues for the specified destinations are
  /// returned, otherwise only issues for the Shopping destination.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [AccountStatus].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<AccountStatus> get(core.String merchantId, core.String accountId,
      {core.List<core.String> destinations, core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (destinations != null) {
      _queryParams["destinations"] = destinations;
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/accountstatuses/' +
        commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountStatus.fromJson(data));
  }

  /// Lists the statuses of the sub-accounts in your Merchant Center account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the managing account. This must be a multi-client
  /// account.
  ///
  /// [destinations] - If set, only issues for the specified destinations are
  /// returned, otherwise only issues for the Shopping destination.
  ///
  /// [maxResults] - The maximum number of account statuses to return in the
  /// response, used for paging.
  ///
  /// [pageToken] - The token returned by the previous request.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [AccountstatusesListResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<AccountstatusesListResponse> list(core.String merchantId,
      {core.List<core.String> destinations,
      core.int maxResults,
      core.String pageToken,
      core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (destinations != null) {
      _queryParams["destinations"] = destinations;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/accountstatuses';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new AccountstatusesListResponse.fromJson(data));
  }
}

class AccounttaxResourceApi {
  final commons.ApiRequester _requester;

  AccounttaxResourceApi(commons.ApiRequester client) : _requester = client;

  /// Retrieves and updates tax settings of multiple accounts in a single
  /// request.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [AccounttaxCustomBatchResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<AccounttaxCustomBatchResponse> custombatch(
      AccounttaxCustomBatchRequest request,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = 'accounttax/batch';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new AccounttaxCustomBatchResponse.fromJson(data));
  }

  /// Retrieves the tax settings of the account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the managing account. If this parameter is not
  /// the same as accountId, then this account must be a multi-client account
  /// and accountId must be the ID of a sub-account of this account.
  ///
  /// [accountId] - The ID of the account for which to get/update account tax
  /// settings.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [AccountTax].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<AccountTax> get(core.String merchantId, core.String accountId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/accounttax/' +
        commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountTax.fromJson(data));
  }

  /// Lists the tax settings of the sub-accounts in your Merchant Center
  /// account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the managing account. This must be a multi-client
  /// account.
  ///
  /// [maxResults] - The maximum number of tax settings to return in the
  /// response, used for paging.
  ///
  /// [pageToken] - The token returned by the previous request.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [AccounttaxListResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<AccounttaxListResponse> list(core.String merchantId,
      {core.int maxResults, core.String pageToken, core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/accounttax';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new AccounttaxListResponse.fromJson(data));
  }

  /// Updates the tax settings of the account.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the managing account. If this parameter is not
  /// the same as accountId, then this account must be a multi-client account
  /// and accountId must be the ID of a sub-account of this account.
  ///
  /// [accountId] - The ID of the account for which to get/update account tax
  /// settings.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [AccountTax].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<AccountTax> update(
      AccountTax request, core.String merchantId, core.String accountId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/accounttax/' +
        commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url, "PUT",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountTax.fromJson(data));
  }
}

class DatafeedsResourceApi {
  final commons.ApiRequester _requester;

  DatafeedsResourceApi(commons.ApiRequester client) : _requester = client;

  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [DatafeedsCustomBatchResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<DatafeedsCustomBatchResponse> custombatch(
      DatafeedsCustomBatchRequest request,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = 'datafeeds/batch';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new DatafeedsCustomBatchResponse.fromJson(data));
  }

  /// Deletes a datafeed configuration from your Merchant Center account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the datafeed. This
  /// account cannot be a multi-client account.
  ///
  /// [datafeedId] - The ID of the datafeed.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future delete(core.String merchantId, core.String datafeedId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (datafeedId == null) {
      throw new core.ArgumentError("Parameter datafeedId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/datafeeds/' +
        commons.Escaper.ecapeVariable('$datafeedId');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /// Invokes a fetch for the datafeed in your Merchant Center account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the datafeed. This
  /// account cannot be a multi-client account.
  ///
  /// [datafeedId] - The ID of the datafeed to be fetched.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [DatafeedsFetchNowResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<DatafeedsFetchNowResponse> fetchnow(
      core.String merchantId, core.String datafeedId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (datafeedId == null) {
      throw new core.ArgumentError("Parameter datafeedId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/datafeeds/' +
        commons.Escaper.ecapeVariable('$datafeedId') +
        '/fetchNow';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new DatafeedsFetchNowResponse.fromJson(data));
  }

  /// Retrieves a datafeed configuration from your Merchant Center account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the datafeed. This
  /// account cannot be a multi-client account.
  ///
  /// [datafeedId] - The ID of the datafeed.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [Datafeed].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Datafeed> get(core.String merchantId, core.String datafeedId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (datafeedId == null) {
      throw new core.ArgumentError("Parameter datafeedId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/datafeeds/' +
        commons.Escaper.ecapeVariable('$datafeedId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Datafeed.fromJson(data));
  }

  /// Registers a datafeed configuration with your Merchant Center account.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the datafeed. This
  /// account cannot be a multi-client account.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [Datafeed].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Datafeed> insert(Datafeed request, core.String merchantId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/datafeeds';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Datafeed.fromJson(data));
  }

  /// Lists the configurations for datafeeds in your Merchant Center account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the datafeeds. This
  /// account cannot be a multi-client account.
  ///
  /// [maxResults] - The maximum number of products to return in the response,
  /// used for paging.
  ///
  /// [pageToken] - The token returned by the previous request.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [DatafeedsListResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<DatafeedsListResponse> list(core.String merchantId,
      {core.int maxResults, core.String pageToken, core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/datafeeds';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new DatafeedsListResponse.fromJson(data));
  }

  /// Updates a datafeed configuration of your Merchant Center account.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the datafeed. This
  /// account cannot be a multi-client account.
  ///
  /// [datafeedId] - The ID of the datafeed.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [Datafeed].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Datafeed> update(
      Datafeed request, core.String merchantId, core.String datafeedId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (datafeedId == null) {
      throw new core.ArgumentError("Parameter datafeedId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/datafeeds/' +
        commons.Escaper.ecapeVariable('$datafeedId');

    var _response = _requester.request(_url, "PUT",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Datafeed.fromJson(data));
  }
}

class DatafeedstatusesResourceApi {
  final commons.ApiRequester _requester;

  DatafeedstatusesResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [DatafeedstatusesCustomBatchResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<DatafeedstatusesCustomBatchResponse> custombatch(
      DatafeedstatusesCustomBatchRequest request,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = 'datafeedstatuses/batch';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new DatafeedstatusesCustomBatchResponse.fromJson(data));
  }

  /// Retrieves the status of a datafeed from your Merchant Center account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the datafeed. This
  /// account cannot be a multi-client account.
  ///
  /// [datafeedId] - The ID of the datafeed.
  ///
  /// [country] - The country for which to get the datafeed status. If this
  /// parameter is provided then language must also be provided. Note that this
  /// parameter is required for feeds targeting multiple countries and
  /// languages, since a feed may have a different status for each target.
  ///
  /// [language] - The language for which to get the datafeed status. If this
  /// parameter is provided then country must also be provided. Note that this
  /// parameter is required for feeds targeting multiple countries and
  /// languages, since a feed may have a different status for each target.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [DatafeedStatus].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<DatafeedStatus> get(
      core.String merchantId, core.String datafeedId,
      {core.String country, core.String language, core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (datafeedId == null) {
      throw new core.ArgumentError("Parameter datafeedId is required.");
    }
    if (country != null) {
      _queryParams["country"] = [country];
    }
    if (language != null) {
      _queryParams["language"] = [language];
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/datafeedstatuses/' +
        commons.Escaper.ecapeVariable('$datafeedId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new DatafeedStatus.fromJson(data));
  }

  /// Lists the statuses of the datafeeds in your Merchant Center account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the datafeeds. This
  /// account cannot be a multi-client account.
  ///
  /// [maxResults] - The maximum number of products to return in the response,
  /// used for paging.
  ///
  /// [pageToken] - The token returned by the previous request.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [DatafeedstatusesListResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<DatafeedstatusesListResponse> list(core.String merchantId,
      {core.int maxResults, core.String pageToken, core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/datafeedstatuses';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new DatafeedstatusesListResponse.fromJson(data));
  }
}

class LiasettingsResourceApi {
  final commons.ApiRequester _requester;

  LiasettingsResourceApi(commons.ApiRequester client) : _requester = client;

  /// Retrieves and/or updates the LIA settings of multiple accounts in a single
  /// request.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [LiasettingsCustomBatchResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<LiasettingsCustomBatchResponse> custombatch(
      LiasettingsCustomBatchRequest request,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = 'liasettings/batch';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new LiasettingsCustomBatchResponse.fromJson(data));
  }

  /// Retrieves the LIA settings of the account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the managing account. If this parameter is not
  /// the same as accountId, then this account must be a multi-client account
  /// and accountId must be the ID of a sub-account of this account.
  ///
  /// [accountId] - The ID of the account for which to get or update LIA
  /// settings.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [LiaSettings].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<LiaSettings> get(core.String merchantId, core.String accountId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/liasettings/' +
        commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new LiaSettings.fromJson(data));
  }

  /// Retrieves the list of accessible Google My Business accounts.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the managing account. If this parameter is not
  /// the same as accountId, then this account must be a multi-client account
  /// and accountId must be the ID of a sub-account of this account.
  ///
  /// [accountId] - The ID of the account for which to retrieve accessible
  /// Google My Business accounts.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [LiasettingsGetAccessibleGmbAccountsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<LiasettingsGetAccessibleGmbAccountsResponse>
      getaccessiblegmbaccounts(core.String merchantId, core.String accountId,
          {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/liasettings/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/accessiblegmbaccounts';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) =>
        new LiasettingsGetAccessibleGmbAccountsResponse.fromJson(data));
  }

  /// Lists the LIA settings of the sub-accounts in your Merchant Center
  /// account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the managing account. This must be a multi-client
  /// account.
  ///
  /// [maxResults] - The maximum number of LIA settings to return in the
  /// response, used for paging.
  ///
  /// [pageToken] - The token returned by the previous request.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [LiasettingsListResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<LiasettingsListResponse> list(core.String merchantId,
      {core.int maxResults, core.String pageToken, core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/liasettings';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new LiasettingsListResponse.fromJson(data));
  }

  /// Retrieves the list of POS data providers that have active settings for the
  /// all eiligible countries.
  ///
  /// Request parameters:
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [LiasettingsListPosDataProvidersResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<LiasettingsListPosDataProvidersResponse> listposdataproviders(
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = 'liasettings/posdataproviders';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then(
        (data) => new LiasettingsListPosDataProvidersResponse.fromJson(data));
  }

  /// Requests access to a specified Google My Business account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the managing account. If this parameter is not
  /// the same as accountId, then this account must be a multi-client account
  /// and accountId must be the ID of a sub-account of this account.
  ///
  /// [accountId] - The ID of the account for which GMB access is requested.
  ///
  /// [gmbEmail] - The email of the Google My Business account.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [LiasettingsRequestGmbAccessResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<LiasettingsRequestGmbAccessResponse> requestgmbaccess(
      core.String merchantId, core.String accountId, core.String gmbEmail,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (gmbEmail == null) {
      throw new core.ArgumentError("Parameter gmbEmail is required.");
    }
    _queryParams["gmbEmail"] = [gmbEmail];
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/liasettings/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/requestgmbaccess';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new LiasettingsRequestGmbAccessResponse.fromJson(data));
  }

  /// Requests inventory validation for the specified country.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the managing account. If this parameter is not
  /// the same as accountId, then this account must be a multi-client account
  /// and accountId must be the ID of a sub-account of this account.
  ///
  /// [accountId] - The ID of the account that manages the order. This cannot be
  /// a multi-client account.
  ///
  /// [country] - The country for which inventory validation is requested.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [LiasettingsRequestInventoryVerificationResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<LiasettingsRequestInventoryVerificationResponse>
      requestinventoryverification(
          core.String merchantId, core.String accountId, core.String country,
          {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (country == null) {
      throw new core.ArgumentError("Parameter country is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/liasettings/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/requestinventoryverification/' +
        commons.Escaper.ecapeVariable('$country');

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) =>
        new LiasettingsRequestInventoryVerificationResponse.fromJson(data));
  }

  /// Sets the inventory verification contract for the specified country.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the managing account. If this parameter is not
  /// the same as accountId, then this account must be a multi-client account
  /// and accountId must be the ID of a sub-account of this account.
  ///
  /// [accountId] - The ID of the account that manages the order. This cannot be
  /// a multi-client account.
  ///
  /// [contactEmail] - The email of the inventory verification contact.
  ///
  /// [contactName] - The name of the inventory verification contact.
  ///
  /// [country] - The country for which inventory verification is requested.
  ///
  /// [language] - The language for which inventory verification is requested.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [LiasettingsSetInventoryVerificationContactResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<LiasettingsSetInventoryVerificationContactResponse>
      setinventoryverificationcontact(
          core.String merchantId,
          core.String accountId,
          core.String contactEmail,
          core.String contactName,
          core.String country,
          core.String language,
          {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (contactEmail == null) {
      throw new core.ArgumentError("Parameter contactEmail is required.");
    }
    _queryParams["contactEmail"] = [contactEmail];
    if (contactName == null) {
      throw new core.ArgumentError("Parameter contactName is required.");
    }
    _queryParams["contactName"] = [contactName];
    if (country == null) {
      throw new core.ArgumentError("Parameter country is required.");
    }
    _queryParams["country"] = [country];
    if (language == null) {
      throw new core.ArgumentError("Parameter language is required.");
    }
    _queryParams["language"] = [language];
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/liasettings/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/setinventoryverificationcontact';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) =>
        new LiasettingsSetInventoryVerificationContactResponse.fromJson(data));
  }

  /// Sets the POS data provider for the specified country.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the managing account. If this parameter is not
  /// the same as accountId, then this account must be a multi-client account
  /// and accountId must be the ID of a sub-account of this account.
  ///
  /// [accountId] - The ID of the account for which to retrieve accessible
  /// Google My Business accounts.
  ///
  /// [country] - The country for which the POS data provider is selected.
  ///
  /// [posDataProviderId] - The ID of POS data provider.
  ///
  /// [posExternalAccountId] - The account ID by which this merchant is known to
  /// the POS data provider.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [LiasettingsSetPosDataProviderResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<LiasettingsSetPosDataProviderResponse> setposdataprovider(
      core.String merchantId, core.String accountId, core.String country,
      {core.String posDataProviderId,
      core.String posExternalAccountId,
      core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if (country == null) {
      throw new core.ArgumentError("Parameter country is required.");
    }
    _queryParams["country"] = [country];
    if (posDataProviderId != null) {
      _queryParams["posDataProviderId"] = [posDataProviderId];
    }
    if (posExternalAccountId != null) {
      _queryParams["posExternalAccountId"] = [posExternalAccountId];
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/liasettings/' +
        commons.Escaper.ecapeVariable('$accountId') +
        '/setposdataprovider';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then(
        (data) => new LiasettingsSetPosDataProviderResponse.fromJson(data));
  }

  /// Updates the LIA settings of the account.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the managing account. If this parameter is not
  /// the same as accountId, then this account must be a multi-client account
  /// and accountId must be the ID of a sub-account of this account.
  ///
  /// [accountId] - The ID of the account for which to get or update LIA
  /// settings.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [LiaSettings].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<LiaSettings> update(
      LiaSettings request, core.String merchantId, core.String accountId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/liasettings/' +
        commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url, "PUT",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new LiaSettings.fromJson(data));
  }
}

class OrderinvoicesResourceApi {
  final commons.ApiRequester _requester;

  OrderinvoicesResourceApi(commons.ApiRequester client) : _requester = client;

  /// Creates a charge invoice for a shipment group, and triggers a charge
  /// capture for non-facilitated payment orders.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [orderId] - The ID of the order.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrderinvoicesCreateChargeInvoiceResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrderinvoicesCreateChargeInvoiceResponse> createchargeinvoice(
      OrderinvoicesCreateChargeInvoiceRequest request,
      core.String merchantId,
      core.String orderId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/orderinvoices/' +
        commons.Escaper.ecapeVariable('$orderId') +
        '/createChargeInvoice';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then(
        (data) => new OrderinvoicesCreateChargeInvoiceResponse.fromJson(data));
  }

  /// Creates a refund invoice for one or more shipment groups, and triggers a
  /// refund for non-facilitated payment orders. This can only be used for line
  /// items that have previously been charged using createChargeInvoice. All
  /// amounts (except for the summary) are incremental with respect to the
  /// previous invoice.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [orderId] - The ID of the order.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrderinvoicesCreateRefundInvoiceResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrderinvoicesCreateRefundInvoiceResponse> createrefundinvoice(
      OrderinvoicesCreateRefundInvoiceRequest request,
      core.String merchantId,
      core.String orderId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/orderinvoices/' +
        commons.Escaper.ecapeVariable('$orderId') +
        '/createRefundInvoice';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then(
        (data) => new OrderinvoicesCreateRefundInvoiceResponse.fromJson(data));
  }
}

class OrderpaymentsResourceApi {
  final commons.ApiRequester _requester;

  OrderpaymentsResourceApi(commons.ApiRequester client) : _requester = client;

  /// Notify about successfully authorizing user's payment method for a given
  /// amount.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [orderId] - The ID of the order for for which payment authorization is
  /// happening.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrderpaymentsNotifyAuthApprovedResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrderpaymentsNotifyAuthApprovedResponse> notifyauthapproved(
      OrderpaymentsNotifyAuthApprovedRequest request,
      core.String merchantId,
      core.String orderId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/orderpayments/' +
        commons.Escaper.ecapeVariable('$orderId') +
        '/notifyAuthApproved';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then(
        (data) => new OrderpaymentsNotifyAuthApprovedResponse.fromJson(data));
  }

  /// Notify about failure to authorize user's payment method.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [orderId] - The ID of the order for which payment authorization was
  /// declined.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrderpaymentsNotifyAuthDeclinedResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrderpaymentsNotifyAuthDeclinedResponse> notifyauthdeclined(
      OrderpaymentsNotifyAuthDeclinedRequest request,
      core.String merchantId,
      core.String orderId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/orderpayments/' +
        commons.Escaper.ecapeVariable('$orderId') +
        '/notifyAuthDeclined';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then(
        (data) => new OrderpaymentsNotifyAuthDeclinedResponse.fromJson(data));
  }

  /// Notify about charge on user's selected payments method.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [orderId] - The ID of the order for which charge is happening.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrderpaymentsNotifyChargeResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrderpaymentsNotifyChargeResponse> notifycharge(
      OrderpaymentsNotifyChargeRequest request,
      core.String merchantId,
      core.String orderId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/orderpayments/' +
        commons.Escaper.ecapeVariable('$orderId') +
        '/notifyCharge';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new OrderpaymentsNotifyChargeResponse.fromJson(data));
  }

  /// Notify about refund on user's selected payments method.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [orderId] - The ID of the order for which charge is happening.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrderpaymentsNotifyRefundResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrderpaymentsNotifyRefundResponse> notifyrefund(
      OrderpaymentsNotifyRefundRequest request,
      core.String merchantId,
      core.String orderId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/orderpayments/' +
        commons.Escaper.ecapeVariable('$orderId') +
        '/notifyRefund';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new OrderpaymentsNotifyRefundResponse.fromJson(data));
  }
}

class OrderreportsResourceApi {
  final commons.ApiRequester _requester;

  OrderreportsResourceApi(commons.ApiRequester client) : _requester = client;

  /// Retrieves a report for disbursements from your Merchant Center account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [disbursementStartDate] - The first date which disbursements occurred. In
  /// ISO 8601 format.
  ///
  /// [disbursementEndDate] - The last date which disbursements occurred. In ISO
  /// 8601 format. Default: current date.
  ///
  /// [maxResults] - The maximum number of disbursements to return in the
  /// response, used for paging.
  ///
  /// [pageToken] - The token returned by the previous request.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrderreportsListDisbursementsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrderreportsListDisbursementsResponse> listdisbursements(
      core.String merchantId, core.String disbursementStartDate,
      {core.String disbursementEndDate,
      core.int maxResults,
      core.String pageToken,
      core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (disbursementStartDate == null) {
      throw new core.ArgumentError(
          "Parameter disbursementStartDate is required.");
    }
    _queryParams["disbursementStartDate"] = [disbursementStartDate];
    if (disbursementEndDate != null) {
      _queryParams["disbursementEndDate"] = [disbursementEndDate];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/orderreports/disbursements';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then(
        (data) => new OrderreportsListDisbursementsResponse.fromJson(data));
  }

  /// Retrieves a list of transactions for a disbursement from your Merchant
  /// Center account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [disbursementId] - The Google-provided ID of the disbursement (found in
  /// Wallet).
  ///
  /// [transactionStartDate] - The first date in which transaction occurred. In
  /// ISO 8601 format.
  ///
  /// [maxResults] - The maximum number of disbursements to return in the
  /// response, used for paging.
  ///
  /// [pageToken] - The token returned by the previous request.
  ///
  /// [transactionEndDate] - The last date in which transaction occurred. In ISO
  /// 8601 format. Default: current date.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrderreportsListTransactionsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrderreportsListTransactionsResponse> listtransactions(
      core.String merchantId,
      core.String disbursementId,
      core.String transactionStartDate,
      {core.int maxResults,
      core.String pageToken,
      core.String transactionEndDate,
      core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (disbursementId == null) {
      throw new core.ArgumentError("Parameter disbursementId is required.");
    }
    if (transactionStartDate == null) {
      throw new core.ArgumentError(
          "Parameter transactionStartDate is required.");
    }
    _queryParams["transactionStartDate"] = [transactionStartDate];
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (transactionEndDate != null) {
      _queryParams["transactionEndDate"] = [transactionEndDate];
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/orderreports/disbursements/' +
        commons.Escaper.ecapeVariable('$disbursementId') +
        '/transactions';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then(
        (data) => new OrderreportsListTransactionsResponse.fromJson(data));
  }
}

class OrderreturnsResourceApi {
  final commons.ApiRequester _requester;

  OrderreturnsResourceApi(commons.ApiRequester client) : _requester = client;

  /// Retrieves an order return from your Merchant Center account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [returnId] - Merchant order return ID generated by Google.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [MerchantOrderReturn].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<MerchantOrderReturn> get(
      core.String merchantId, core.String returnId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (returnId == null) {
      throw new core.ArgumentError("Parameter returnId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/orderreturns/' +
        commons.Escaper.ecapeVariable('$returnId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new MerchantOrderReturn.fromJson(data));
  }

  /// Lists order returns in your Merchant Center account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [createdEndDate] - Obtains order returns created before this date
  /// (inclusively), in ISO 8601 format.
  ///
  /// [createdStartDate] - Obtains order returns created after this date
  /// (inclusively), in ISO 8601 format.
  ///
  /// [maxResults] - The maximum number of order returns to return in the
  /// response, used for paging. The default value is 25 returns per page, and
  /// the maximum allowed value is 250 returns per page.
  ///
  /// [orderBy] - Return the results in the specified order.
  /// Possible string values are:
  /// - "returnCreationTimeAsc"
  /// - "returnCreationTimeDesc"
  ///
  /// [pageToken] - The token returned by the previous request.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrderreturnsListResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrderreturnsListResponse> list(core.String merchantId,
      {core.String createdEndDate,
      core.String createdStartDate,
      core.int maxResults,
      core.String orderBy,
      core.String pageToken,
      core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (createdEndDate != null) {
      _queryParams["createdEndDate"] = [createdEndDate];
    }
    if (createdStartDate != null) {
      _queryParams["createdStartDate"] = [createdStartDate];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (orderBy != null) {
      _queryParams["orderBy"] = [orderBy];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/orderreturns';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new OrderreturnsListResponse.fromJson(data));
  }
}

class OrdersResourceApi {
  final commons.ApiRequester _requester;

  OrdersResourceApi(commons.ApiRequester client) : _requester = client;

  /// Marks an order as acknowledged.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [orderId] - The ID of the order.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrdersAcknowledgeResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrdersAcknowledgeResponse> acknowledge(
      OrdersAcknowledgeRequest request,
      core.String merchantId,
      core.String orderId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/orders/' +
        commons.Escaper.ecapeVariable('$orderId') +
        '/acknowledge';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new OrdersAcknowledgeResponse.fromJson(data));
  }

  /// Sandbox only. Moves a test order from state "inProgress" to state
  /// "pendingShipment".
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [orderId] - The ID of the test order to modify.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrdersAdvanceTestOrderResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrdersAdvanceTestOrderResponse> advancetestorder(
      core.String merchantId, core.String orderId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/testorders/' +
        commons.Escaper.ecapeVariable('$orderId') +
        '/advance';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new OrdersAdvanceTestOrderResponse.fromJson(data));
  }

  /// Cancels all line items in an order, making a full refund.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [orderId] - The ID of the order to cancel.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrdersCancelResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrdersCancelResponse> cancel(
      OrdersCancelRequest request, core.String merchantId, core.String orderId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/orders/' +
        commons.Escaper.ecapeVariable('$orderId') +
        '/cancel';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersCancelResponse.fromJson(data));
  }

  /// Cancels a line item, making a full refund.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [orderId] - The ID of the order.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrdersCancelLineItemResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrdersCancelLineItemResponse> cancellineitem(
      OrdersCancelLineItemRequest request,
      core.String merchantId,
      core.String orderId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/orders/' +
        commons.Escaper.ecapeVariable('$orderId') +
        '/cancelLineItem';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new OrdersCancelLineItemResponse.fromJson(data));
  }

  /// Sandbox only. Cancels a test order for customer-initiated cancellation.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [orderId] - The ID of the test order to cancel.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrdersCancelTestOrderByCustomerResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrdersCancelTestOrderByCustomerResponse>
      canceltestorderbycustomer(OrdersCancelTestOrderByCustomerRequest request,
          core.String merchantId, core.String orderId,
          {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/testorders/' +
        commons.Escaper.ecapeVariable('$orderId') +
        '/cancelByCustomer';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then(
        (data) => new OrdersCancelTestOrderByCustomerResponse.fromJson(data));
  }

  /// Sandbox only. Creates a test order.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that should manage the order. This
  /// cannot be a multi-client account.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrdersCreateTestOrderResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrdersCreateTestOrderResponse> createtestorder(
      OrdersCreateTestOrderRequest request, core.String merchantId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/testorders';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new OrdersCreateTestOrderResponse.fromJson(data));
  }

  /// Sandbox only. Creates a test return.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [orderId] - The ID of the order.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrdersCreateTestReturnResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrdersCreateTestReturnResponse> createtestreturn(
      OrdersCreateTestReturnRequest request,
      core.String merchantId,
      core.String orderId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/orders/' +
        commons.Escaper.ecapeVariable('$orderId') +
        '/testreturn';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new OrdersCreateTestReturnResponse.fromJson(data));
  }

  /// Retrieves an order from your Merchant Center account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [orderId] - The ID of the order.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [Order].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Order> get(core.String merchantId, core.String orderId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/orders/' +
        commons.Escaper.ecapeVariable('$orderId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Order.fromJson(data));
  }

  /// Retrieves an order using merchant order id.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [merchantOrderId] - The merchant order id to be looked for.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrdersGetByMerchantOrderIdResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrdersGetByMerchantOrderIdResponse> getbymerchantorderid(
      core.String merchantId, core.String merchantOrderId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (merchantOrderId == null) {
      throw new core.ArgumentError("Parameter merchantOrderId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/ordersbymerchantid/' +
        commons.Escaper.ecapeVariable('$merchantOrderId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new OrdersGetByMerchantOrderIdResponse.fromJson(data));
  }

  /// Sandbox only. Retrieves an order template that can be used to quickly
  /// create a new order in sandbox.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that should manage the order. This
  /// cannot be a multi-client account.
  ///
  /// [templateName] - The name of the template to retrieve.
  /// Possible string values are:
  /// - "template1"
  /// - "template1a"
  /// - "template1b"
  /// - "template2"
  ///
  /// [country] - The country of the template to retrieve. Defaults to US.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrdersGetTestOrderTemplateResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrdersGetTestOrderTemplateResponse> gettestordertemplate(
      core.String merchantId, core.String templateName,
      {core.String country, core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (templateName == null) {
      throw new core.ArgumentError("Parameter templateName is required.");
    }
    if (country != null) {
      _queryParams["country"] = [country];
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/testordertemplates/' +
        commons.Escaper.ecapeVariable('$templateName');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new OrdersGetTestOrderTemplateResponse.fromJson(data));
  }

  /// Notifies that item return and refund was handled directly by merchant
  /// outside of Google payments processing (e.g. cash refund done in store).
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [orderId] - The ID of the order.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrdersInStoreRefundLineItemResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrdersInStoreRefundLineItemResponse> instorerefundlineitem(
      OrdersInStoreRefundLineItemRequest request,
      core.String merchantId,
      core.String orderId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/orders/' +
        commons.Escaper.ecapeVariable('$orderId') +
        '/inStoreRefundLineItem';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new OrdersInStoreRefundLineItemResponse.fromJson(data));
  }

  /// Lists the orders in your Merchant Center account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [acknowledged] - Obtains orders that match the acknowledgement status.
  /// When set to true, obtains orders that have been acknowledged. When false,
  /// obtains orders that have not been acknowledged.
  /// We recommend using this filter set to false, in conjunction with the
  /// acknowledge call, such that only un-acknowledged orders are returned.
  ///
  /// [maxResults] - The maximum number of orders to return in the response,
  /// used for paging. The default value is 25 orders per page, and the maximum
  /// allowed value is 250 orders per page.
  /// Known issue: All List calls will return all Orders without limit
  /// regardless of the value of this field.
  ///
  /// [orderBy] - The ordering of the returned list. The only supported value
  /// are placedDate desc and placedDate asc for now, which returns orders
  /// sorted by placement date. "placedDate desc" stands for listing orders by
  /// placement date, from oldest to most recent. "placedDate asc" stands for
  /// listing orders by placement date, from most recent to oldest. In future
  /// releases we'll support other sorting criteria.
  /// Possible string values are:
  /// - "placedDate asc"
  /// - "placedDate desc"
  ///
  /// [pageToken] - The token returned by the previous request.
  ///
  /// [placedDateEnd] - Obtains orders placed before this date (exclusively), in
  /// ISO 8601 format.
  ///
  /// [placedDateStart] - Obtains orders placed after this date (inclusively),
  /// in ISO 8601 format.
  ///
  /// [statuses] - Obtains orders that match any of the specified statuses.
  /// Multiple values can be specified with comma separation. Additionally,
  /// please note that active is a shortcut for pendingShipment and
  /// partiallyShipped, and completed is a shortcut for shipped ,
  /// partiallyDelivered, delivered, partiallyReturned, returned, and canceled.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrdersListResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrdersListResponse> list(core.String merchantId,
      {core.bool acknowledged,
      core.int maxResults,
      core.String orderBy,
      core.String pageToken,
      core.String placedDateEnd,
      core.String placedDateStart,
      core.List<core.String> statuses,
      core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (acknowledged != null) {
      _queryParams["acknowledged"] = ["${acknowledged}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (orderBy != null) {
      _queryParams["orderBy"] = [orderBy];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (placedDateEnd != null) {
      _queryParams["placedDateEnd"] = [placedDateEnd];
    }
    if (placedDateStart != null) {
      _queryParams["placedDateStart"] = [placedDateStart];
    }
    if (statuses != null) {
      _queryParams["statuses"] = statuses;
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/orders';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersListResponse.fromJson(data));
  }

  /// Rejects return on an line item.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [orderId] - The ID of the order.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrdersRejectReturnLineItemResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrdersRejectReturnLineItemResponse> rejectreturnlineitem(
      OrdersRejectReturnLineItemRequest request,
      core.String merchantId,
      core.String orderId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/orders/' +
        commons.Escaper.ecapeVariable('$orderId') +
        '/rejectReturnLineItem';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new OrdersRejectReturnLineItemResponse.fromJson(data));
  }

  /// Returns and refunds a line item. Note that this method can only be called
  /// on fully shipped orders.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [orderId] - The ID of the order.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrdersReturnRefundLineItemResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrdersReturnRefundLineItemResponse> returnrefundlineitem(
      OrdersReturnRefundLineItemRequest request,
      core.String merchantId,
      core.String orderId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/orders/' +
        commons.Escaper.ecapeVariable('$orderId') +
        '/returnRefundLineItem';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new OrdersReturnRefundLineItemResponse.fromJson(data));
  }

  /// Sets (overrides) merchant provided annotations on the line item.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [orderId] - The ID of the order.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrdersSetLineItemMetadataResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrdersSetLineItemMetadataResponse> setlineitemmetadata(
      OrdersSetLineItemMetadataRequest request,
      core.String merchantId,
      core.String orderId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/orders/' +
        commons.Escaper.ecapeVariable('$orderId') +
        '/setLineItemMetadata';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new OrdersSetLineItemMetadataResponse.fromJson(data));
  }

  /// Marks line item(s) as shipped.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [orderId] - The ID of the order.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrdersShipLineItemsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrdersShipLineItemsResponse> shiplineitems(
      OrdersShipLineItemsRequest request,
      core.String merchantId,
      core.String orderId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/orders/' +
        commons.Escaper.ecapeVariable('$orderId') +
        '/shipLineItems';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new OrdersShipLineItemsResponse.fromJson(data));
  }

  /// Updates ship by and delivery by dates for a line item.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [orderId] - The ID of the order.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrdersUpdateLineItemShippingDetailsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrdersUpdateLineItemShippingDetailsResponse>
      updatelineitemshippingdetails(
          OrdersUpdateLineItemShippingDetailsRequest request,
          core.String merchantId,
          core.String orderId,
          {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/orders/' +
        commons.Escaper.ecapeVariable('$orderId') +
        '/updateLineItemShippingDetails';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) =>
        new OrdersUpdateLineItemShippingDetailsResponse.fromJson(data));
  }

  /// Updates the merchant order ID for a given order.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [orderId] - The ID of the order.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrdersUpdateMerchantOrderIdResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrdersUpdateMerchantOrderIdResponse> updatemerchantorderid(
      OrdersUpdateMerchantOrderIdRequest request,
      core.String merchantId,
      core.String orderId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/orders/' +
        commons.Escaper.ecapeVariable('$orderId') +
        '/updateMerchantOrderId';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new OrdersUpdateMerchantOrderIdResponse.fromJson(data));
  }

  /// Updates a shipment's status, carrier, and/or tracking ID.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that manages the order. This cannot
  /// be a multi-client account.
  ///
  /// [orderId] - The ID of the order.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [OrdersUpdateShipmentResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<OrdersUpdateShipmentResponse> updateshipment(
      OrdersUpdateShipmentRequest request,
      core.String merchantId,
      core.String orderId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (orderId == null) {
      throw new core.ArgumentError("Parameter orderId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/orders/' +
        commons.Escaper.ecapeVariable('$orderId') +
        '/updateShipment';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new OrdersUpdateShipmentResponse.fromJson(data));
  }
}

class PosResourceApi {
  final commons.ApiRequester _requester;

  PosResourceApi(commons.ApiRequester client) : _requester = client;

  /// Batches multiple POS-related calls in a single request.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [PosCustomBatchResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<PosCustomBatchResponse> custombatch(
      PosCustomBatchRequest request,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = 'pos/batch';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new PosCustomBatchResponse.fromJson(data));
  }

  /// Deletes a store for the given merchant.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the POS or inventory data provider.
  ///
  /// [targetMerchantId] - The ID of the target merchant.
  ///
  /// [storeCode] - A store code that is unique per merchant.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future delete(core.String merchantId, core.String targetMerchantId,
      core.String storeCode,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (targetMerchantId == null) {
      throw new core.ArgumentError("Parameter targetMerchantId is required.");
    }
    if (storeCode == null) {
      throw new core.ArgumentError("Parameter storeCode is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/pos/' +
        commons.Escaper.ecapeVariable('$targetMerchantId') +
        '/store/' +
        commons.Escaper.ecapeVariable('$storeCode');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /// Retrieves information about the given store.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the POS or inventory data provider.
  ///
  /// [targetMerchantId] - The ID of the target merchant.
  ///
  /// [storeCode] - A store code that is unique per merchant.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [PosStore].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<PosStore> get(core.String merchantId,
      core.String targetMerchantId, core.String storeCode,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (targetMerchantId == null) {
      throw new core.ArgumentError("Parameter targetMerchantId is required.");
    }
    if (storeCode == null) {
      throw new core.ArgumentError("Parameter storeCode is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/pos/' +
        commons.Escaper.ecapeVariable('$targetMerchantId') +
        '/store/' +
        commons.Escaper.ecapeVariable('$storeCode');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new PosStore.fromJson(data));
  }

  /// Creates a store for the given merchant.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the POS or inventory data provider.
  ///
  /// [targetMerchantId] - The ID of the target merchant.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [PosStore].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<PosStore> insert(
      PosStore request, core.String merchantId, core.String targetMerchantId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (targetMerchantId == null) {
      throw new core.ArgumentError("Parameter targetMerchantId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/pos/' +
        commons.Escaper.ecapeVariable('$targetMerchantId') +
        '/store';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new PosStore.fromJson(data));
  }

  /// Submit inventory for the given merchant.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the POS or inventory data provider.
  ///
  /// [targetMerchantId] - The ID of the target merchant.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [PosInventoryResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<PosInventoryResponse> inventory(PosInventoryRequest request,
      core.String merchantId, core.String targetMerchantId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (targetMerchantId == null) {
      throw new core.ArgumentError("Parameter targetMerchantId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/pos/' +
        commons.Escaper.ecapeVariable('$targetMerchantId') +
        '/inventory';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new PosInventoryResponse.fromJson(data));
  }

  /// Lists the stores of the target merchant.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the POS or inventory data provider.
  ///
  /// [targetMerchantId] - The ID of the target merchant.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [PosListResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<PosListResponse> list(
      core.String merchantId, core.String targetMerchantId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (targetMerchantId == null) {
      throw new core.ArgumentError("Parameter targetMerchantId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/pos/' +
        commons.Escaper.ecapeVariable('$targetMerchantId') +
        '/store';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new PosListResponse.fromJson(data));
  }

  /// Submit a sale event for the given merchant.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the POS or inventory data provider.
  ///
  /// [targetMerchantId] - The ID of the target merchant.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [PosSaleResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<PosSaleResponse> sale(PosSaleRequest request,
      core.String merchantId, core.String targetMerchantId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (targetMerchantId == null) {
      throw new core.ArgumentError("Parameter targetMerchantId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/pos/' +
        commons.Escaper.ecapeVariable('$targetMerchantId') +
        '/sale';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new PosSaleResponse.fromJson(data));
  }
}

class ProductsResourceApi {
  final commons.ApiRequester _requester;

  ProductsResourceApi(commons.ApiRequester client) : _requester = client;

  /// Retrieves, inserts, and deletes multiple products in a single request.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [ProductsCustomBatchResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ProductsCustomBatchResponse> custombatch(
      ProductsCustomBatchRequest request,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = 'products/batch';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new ProductsCustomBatchResponse.fromJson(data));
  }

  /// Deletes a product from your Merchant Center account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that contains the product. This
  /// account cannot be a multi-client account.
  ///
  /// [productId] - The REST id of the product.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future delete(core.String merchantId, core.String productId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (productId == null) {
      throw new core.ArgumentError("Parameter productId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/products/' +
        commons.Escaper.ecapeVariable('$productId');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /// Retrieves a product from your Merchant Center account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that contains the product. This
  /// account cannot be a multi-client account.
  ///
  /// [productId] - The REST id of the product.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [Product].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Product> get(core.String merchantId, core.String productId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (productId == null) {
      throw new core.ArgumentError("Parameter productId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/products/' +
        commons.Escaper.ecapeVariable('$productId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Product.fromJson(data));
  }

  /// Uploads a product to your Merchant Center account. If an item with the
  /// same channel, contentLanguage, offerId, and targetCountry already exists,
  /// this method updates that entry.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that contains the product. This
  /// account cannot be a multi-client account.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [Product].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Product> insert(Product request, core.String merchantId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/products';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new Product.fromJson(data));
  }

  /// Lists the products in your Merchant Center account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that contains the products. This
  /// account cannot be a multi-client account.
  ///
  /// [maxResults] - The maximum number of products to return in the response,
  /// used for paging.
  ///
  /// [pageToken] - The token returned by the previous request.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [ProductsListResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ProductsListResponse> list(core.String merchantId,
      {core.int maxResults, core.String pageToken, core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/products';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ProductsListResponse.fromJson(data));
  }
}

class ProductstatusesResourceApi {
  final commons.ApiRequester _requester;

  ProductstatusesResourceApi(commons.ApiRequester client) : _requester = client;

  /// Gets the statuses of multiple products in a single request.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [ProductstatusesCustomBatchResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ProductstatusesCustomBatchResponse> custombatch(
      ProductstatusesCustomBatchRequest request,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = 'productstatuses/batch';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new ProductstatusesCustomBatchResponse.fromJson(data));
  }

  /// Gets the status of a product from your Merchant Center account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that contains the product. This
  /// account cannot be a multi-client account.
  ///
  /// [productId] - The REST id of the product.
  ///
  /// [destinations] - If set, only issues for the specified destinations are
  /// returned, otherwise only issues for the Shopping destination.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [ProductStatus].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ProductStatus> get(core.String merchantId, core.String productId,
      {core.List<core.String> destinations, core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (productId == null) {
      throw new core.ArgumentError("Parameter productId is required.");
    }
    if (destinations != null) {
      _queryParams["destinations"] = destinations;
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/productstatuses/' +
        commons.Escaper.ecapeVariable('$productId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ProductStatus.fromJson(data));
  }

  /// Lists the statuses of the products in your Merchant Center account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account that contains the products. This
  /// account cannot be a multi-client account.
  ///
  /// [destinations] - If set, only issues for the specified destinations are
  /// returned, otherwise only issues for the Shopping destination.
  ///
  /// [maxResults] - The maximum number of product statuses to return in the
  /// response, used for paging.
  ///
  /// [pageToken] - The token returned by the previous request.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [ProductstatusesListResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ProductstatusesListResponse> list(core.String merchantId,
      {core.List<core.String> destinations,
      core.int maxResults,
      core.String pageToken,
      core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (destinations != null) {
      _queryParams["destinations"] = destinations;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/productstatuses';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new ProductstatusesListResponse.fromJson(data));
  }
}

class ShippingsettingsResourceApi {
  final commons.ApiRequester _requester;

  ShippingsettingsResourceApi(commons.ApiRequester client)
      : _requester = client;

  /// Retrieves and updates the shipping settings of multiple accounts in a
  /// single request.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [ShippingsettingsCustomBatchResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ShippingsettingsCustomBatchResponse> custombatch(
      ShippingsettingsCustomBatchRequest request,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = 'shippingsettings/batch';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new ShippingsettingsCustomBatchResponse.fromJson(data));
  }

  /// Retrieves the shipping settings of the account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the managing account. If this parameter is not
  /// the same as accountId, then this account must be a multi-client account
  /// and accountId must be the ID of a sub-account of this account.
  ///
  /// [accountId] - The ID of the account for which to get/update shipping
  /// settings.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [ShippingSettings].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ShippingSettings> get(
      core.String merchantId, core.String accountId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/shippingsettings/' +
        commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ShippingSettings.fromJson(data));
  }

  /// Retrieves supported carriers and carrier services for an account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account for which to retrieve the supported
  /// carriers.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [ShippingsettingsGetSupportedCarriersResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ShippingsettingsGetSupportedCarriersResponse>
      getsupportedcarriers(core.String merchantId, {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/supportedCarriers';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) =>
        new ShippingsettingsGetSupportedCarriersResponse.fromJson(data));
  }

  /// Retrieves supported holidays for an account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the account for which to retrieve the supported
  /// holidays.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [ShippingsettingsGetSupportedHolidaysResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ShippingsettingsGetSupportedHolidaysResponse>
      getsupportedholidays(core.String merchantId, {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/supportedHolidays';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) =>
        new ShippingsettingsGetSupportedHolidaysResponse.fromJson(data));
  }

  /// Lists the shipping settings of the sub-accounts in your Merchant Center
  /// account.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the managing account. This must be a multi-client
  /// account.
  ///
  /// [maxResults] - The maximum number of shipping settings to return in the
  /// response, used for paging.
  ///
  /// [pageToken] - The token returned by the previous request.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [ShippingsettingsListResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ShippingsettingsListResponse> list(core.String merchantId,
      {core.int maxResults, core.String pageToken, core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') + '/shippingsettings';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response
        .then((data) => new ShippingsettingsListResponse.fromJson(data));
  }

  /// Updates the shipping settings of the account.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [merchantId] - The ID of the managing account. If this parameter is not
  /// the same as accountId, then this account must be a multi-client account
  /// and accountId must be the ID of a sub-account of this account.
  ///
  /// [accountId] - The ID of the account for which to get/update shipping
  /// settings.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [ShippingSettings].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<ShippingSettings> update(
      ShippingSettings request, core.String merchantId, core.String accountId,
      {core.String $fields}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode((request).toJson());
    }
    if (merchantId == null) {
      throw new core.ArgumentError("Parameter merchantId is required.");
    }
    if (accountId == null) {
      throw new core.ArgumentError("Parameter accountId is required.");
    }
    if ($fields != null) {
      _queryParams["fields"] = [$fields];
    }

    _url = commons.Escaper.ecapeVariable('$merchantId') +
        '/shippingsettings/' +
        commons.Escaper.ecapeVariable('$accountId');

    var _response = _requester.request(_url, "PUT",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => new ShippingSettings.fromJson(data));
  }
}

/// Account data. After the creation of a new account it may take a few minutes
/// before it is fully operational. The methods delete, insert, patch, and
/// update require the admin role.
class Account {
  /// List of linked Ads accounts that are active or pending approval. To create
  /// a new link request, add a new link with status active to the list. It will
  /// remain in a pending state until approved or rejected either in the Ads
  /// interface or through the AdWords API. To delete an active link, or to
  /// cancel a link request, remove it from the list.
  core.List<AccountAdsLink> adsLinks;

  /// Indicates whether the merchant sells adult content.
  core.bool adultContent;

  /// The business information of the account.
  AccountBusinessInformation businessInformation;

  /// The GMB account which is linked or in the process of being linked with the
  /// Merchant Center account.
  AccountGoogleMyBusinessLink googleMyBusinessLink;

  /// Merchant Center account ID.
  core.String id;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#account".
  core.String kind;

  /// Display name for the account.
  core.String name;

  /// Client-specific, locally-unique, internal ID for the child account.
  core.String sellerId;

  /// Users with access to the account. Every account (except for subaccounts)
  /// must have at least one admin user.
  core.List<AccountUser> users;

  /// The merchant's website.
  core.String websiteUrl;

  /// List of linked YouTube channels that are active or pending approval. To
  /// create a new link request, add a new link with status active to the list.
  /// It will remain in a pending state until approved or rejected in the YT
  /// Creator Studio interface. To delete an active link, or to cancel a link
  /// request, remove it from the list.
  core.List<AccountYouTubeChannelLink> youtubeChannelLinks;

  Account();

  Account.fromJson(core.Map _json) {
    if (_json.containsKey("adsLinks")) {
      adsLinks = (_json["adsLinks"] as core.List)
          .map<AccountAdsLink>((value) => new AccountAdsLink.fromJson(value))
          .toList();
    }
    if (_json.containsKey("adultContent")) {
      adultContent = _json["adultContent"];
    }
    if (_json.containsKey("businessInformation")) {
      businessInformation =
          new AccountBusinessInformation.fromJson(_json["businessInformation"]);
    }
    if (_json.containsKey("googleMyBusinessLink")) {
      googleMyBusinessLink = new AccountGoogleMyBusinessLink.fromJson(
          _json["googleMyBusinessLink"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("sellerId")) {
      sellerId = _json["sellerId"];
    }
    if (_json.containsKey("users")) {
      users = (_json["users"] as core.List)
          .map<AccountUser>((value) => new AccountUser.fromJson(value))
          .toList();
    }
    if (_json.containsKey("websiteUrl")) {
      websiteUrl = _json["websiteUrl"];
    }
    if (_json.containsKey("youtubeChannelLinks")) {
      youtubeChannelLinks = (_json["youtubeChannelLinks"] as core.List)
          .map<AccountYouTubeChannelLink>(
              (value) => new AccountYouTubeChannelLink.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (adsLinks != null) {
      _json["adsLinks"] = adsLinks.map((value) => (value).toJson()).toList();
    }
    if (adultContent != null) {
      _json["adultContent"] = adultContent;
    }
    if (businessInformation != null) {
      _json["businessInformation"] = (businessInformation).toJson();
    }
    if (googleMyBusinessLink != null) {
      _json["googleMyBusinessLink"] = (googleMyBusinessLink).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (sellerId != null) {
      _json["sellerId"] = sellerId;
    }
    if (users != null) {
      _json["users"] = users.map((value) => (value).toJson()).toList();
    }
    if (websiteUrl != null) {
      _json["websiteUrl"] = websiteUrl;
    }
    if (youtubeChannelLinks != null) {
      _json["youtubeChannelLinks"] =
          youtubeChannelLinks.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class AccountAddress {
  /// CLDR country code (e.g. "US").
  core.String country;

  /// City, town or commune. May also include dependent localities or
  /// sublocalities (e.g. neighborhoods or suburbs).
  core.String locality;

  /// Postal code or ZIP (e.g. "94043").
  core.String postalCode;

  /// Top-level administrative subdivision of the country. For example, a state
  /// like California ("CA") or a province like Quebec ("QC").
  core.String region;

  /// Street-level part of the address.
  core.String streetAddress;

  AccountAddress();

  AccountAddress.fromJson(core.Map _json) {
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("locality")) {
      locality = _json["locality"];
    }
    if (_json.containsKey("postalCode")) {
      postalCode = _json["postalCode"];
    }
    if (_json.containsKey("region")) {
      region = _json["region"];
    }
    if (_json.containsKey("streetAddress")) {
      streetAddress = _json["streetAddress"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (country != null) {
      _json["country"] = country;
    }
    if (locality != null) {
      _json["locality"] = locality;
    }
    if (postalCode != null) {
      _json["postalCode"] = postalCode;
    }
    if (region != null) {
      _json["region"] = region;
    }
    if (streetAddress != null) {
      _json["streetAddress"] = streetAddress;
    }
    return _json;
  }
}

class AccountAdsLink {
  /// Customer ID of the Ads account.
  core.String adsId;

  /// Status of the link between this Merchant Center account and the Ads
  /// account. Upon retrieval, it represents the actual status of the link and
  /// can be either active if it was approved in Google Ads or pending if it's
  /// pending approval. Upon insertion, it represents the intended status of the
  /// link. Re-uploading a link with status active when it's still pending or
  /// with status pending when it's already active will have no effect: the
  /// status will remain unchanged. Re-uploading a link with deprecated status
  /// inactive is equivalent to not submitting the link at all and will delete
  /// the link if it was active or cancel the link request if it was pending.
  core.String status;

  AccountAdsLink();

  AccountAdsLink.fromJson(core.Map _json) {
    if (_json.containsKey("adsId")) {
      adsId = _json["adsId"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (adsId != null) {
      _json["adsId"] = adsId;
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

class AccountBusinessInformation {
  /// The address of the business.
  AccountAddress address;

  /// The customer service information of the business.
  AccountCustomerService customerService;

  /// The phone number of the business.
  core.String phoneNumber;

  AccountBusinessInformation();

  AccountBusinessInformation.fromJson(core.Map _json) {
    if (_json.containsKey("address")) {
      address = new AccountAddress.fromJson(_json["address"]);
    }
    if (_json.containsKey("customerService")) {
      customerService =
          new AccountCustomerService.fromJson(_json["customerService"]);
    }
    if (_json.containsKey("phoneNumber")) {
      phoneNumber = _json["phoneNumber"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (address != null) {
      _json["address"] = (address).toJson();
    }
    if (customerService != null) {
      _json["customerService"] = (customerService).toJson();
    }
    if (phoneNumber != null) {
      _json["phoneNumber"] = phoneNumber;
    }
    return _json;
  }
}

class AccountCustomerService {
  /// Customer service email.
  core.String email;

  /// Customer service phone number.
  core.String phoneNumber;

  /// Customer service URL.
  core.String url;

  AccountCustomerService();

  AccountCustomerService.fromJson(core.Map _json) {
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("phoneNumber")) {
      phoneNumber = _json["phoneNumber"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (email != null) {
      _json["email"] = email;
    }
    if (phoneNumber != null) {
      _json["phoneNumber"] = phoneNumber;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

class AccountGoogleMyBusinessLink {
  /// The GMB email address of which a specific account within a GMB account. A
  /// sample account within a GMB account could be a business account with set
  /// of locations, managed under the GMB account.
  core.String gmbEmail;

  /// Status of the link between this Merchant Center account and the GMB
  /// account.
  core.String status;

  AccountGoogleMyBusinessLink();

  AccountGoogleMyBusinessLink.fromJson(core.Map _json) {
    if (_json.containsKey("gmbEmail")) {
      gmbEmail = _json["gmbEmail"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (gmbEmail != null) {
      _json["gmbEmail"] = gmbEmail;
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

class AccountIdentifier {
  /// The aggregator ID, set for aggregators and subaccounts (in that case, it
  /// represents the aggregator of the subaccount).
  core.String aggregatorId;

  /// The merchant account ID, set for individual accounts and subaccounts.
  core.String merchantId;

  AccountIdentifier();

  AccountIdentifier.fromJson(core.Map _json) {
    if (_json.containsKey("aggregatorId")) {
      aggregatorId = _json["aggregatorId"];
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (aggregatorId != null) {
      _json["aggregatorId"] = aggregatorId;
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    return _json;
  }
}

/// The status of an account, i.e., information about its products, which is
/// computed offline and not returned immediately at insertion time.
class AccountStatus {
  /// The ID of the account for which the status is reported.
  core.String accountId;

  /// A list of account level issues.
  core.List<AccountStatusAccountLevelIssue> accountLevelIssues;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#accountStatus".
  core.String kind;

  /// List of product-related data by channel, destination, and country. Data in
  /// this field may be delayed by up to 30 minutes.
  core.List<AccountStatusProducts> products;

  /// Whether the account's website is claimed or not.
  core.bool websiteClaimed;

  AccountStatus();

  AccountStatus.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("accountLevelIssues")) {
      accountLevelIssues = (_json["accountLevelIssues"] as core.List)
          .map<AccountStatusAccountLevelIssue>(
              (value) => new AccountStatusAccountLevelIssue.fromJson(value))
          .toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("products")) {
      products = (_json["products"] as core.List)
          .map<AccountStatusProducts>(
              (value) => new AccountStatusProducts.fromJson(value))
          .toList();
    }
    if (_json.containsKey("websiteClaimed")) {
      websiteClaimed = _json["websiteClaimed"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (accountLevelIssues != null) {
      _json["accountLevelIssues"] =
          accountLevelIssues.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (products != null) {
      _json["products"] = products.map((value) => (value).toJson()).toList();
    }
    if (websiteClaimed != null) {
      _json["websiteClaimed"] = websiteClaimed;
    }
    return _json;
  }
}

class AccountStatusAccountLevelIssue {
  /// Country for which this issue is reported.
  core.String country;

  /// The destination the issue applies to.
  core.String destination;

  /// Additional details about the issue.
  core.String detail;

  /// The URL of a web page to help resolving this issue.
  core.String documentation;

  /// Issue identifier.
  core.String id;

  /// Severity of the issue.
  core.String severity;

  /// Short description of the issue.
  core.String title;

  AccountStatusAccountLevelIssue();

  AccountStatusAccountLevelIssue.fromJson(core.Map _json) {
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("destination")) {
      destination = _json["destination"];
    }
    if (_json.containsKey("detail")) {
      detail = _json["detail"];
    }
    if (_json.containsKey("documentation")) {
      documentation = _json["documentation"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("severity")) {
      severity = _json["severity"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (country != null) {
      _json["country"] = country;
    }
    if (destination != null) {
      _json["destination"] = destination;
    }
    if (detail != null) {
      _json["detail"] = detail;
    }
    if (documentation != null) {
      _json["documentation"] = documentation;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (severity != null) {
      _json["severity"] = severity;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

class AccountStatusItemLevelIssue {
  /// The attribute's name, if the issue is caused by a single attribute.
  core.String attributeName;

  /// The error code of the issue.
  core.String code;

  /// A short issue description in English.
  core.String description;

  /// A detailed issue description in English.
  core.String detail;

  /// The URL of a web page to help with resolving this issue.
  core.String documentation;

  /// Number of items with this issue.
  core.String numItems;

  /// Whether the issue can be resolved by the merchant.
  core.String resolution;

  /// How this issue affects serving of the offer.
  core.String servability;

  AccountStatusItemLevelIssue();

  AccountStatusItemLevelIssue.fromJson(core.Map _json) {
    if (_json.containsKey("attributeName")) {
      attributeName = _json["attributeName"];
    }
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("detail")) {
      detail = _json["detail"];
    }
    if (_json.containsKey("documentation")) {
      documentation = _json["documentation"];
    }
    if (_json.containsKey("numItems")) {
      numItems = _json["numItems"];
    }
    if (_json.containsKey("resolution")) {
      resolution = _json["resolution"];
    }
    if (_json.containsKey("servability")) {
      servability = _json["servability"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (attributeName != null) {
      _json["attributeName"] = attributeName;
    }
    if (code != null) {
      _json["code"] = code;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (detail != null) {
      _json["detail"] = detail;
    }
    if (documentation != null) {
      _json["documentation"] = documentation;
    }
    if (numItems != null) {
      _json["numItems"] = numItems;
    }
    if (resolution != null) {
      _json["resolution"] = resolution;
    }
    if (servability != null) {
      _json["servability"] = servability;
    }
    return _json;
  }
}

class AccountStatusProducts {
  /// The channel the data applies to.
  core.String channel;

  /// The country the data applies to.
  core.String country;

  /// The destination the data applies to.
  core.String destination;

  /// List of item-level issues.
  core.List<AccountStatusItemLevelIssue> itemLevelIssues;

  /// Aggregated product statistics.
  AccountStatusStatistics statistics;

  AccountStatusProducts();

  AccountStatusProducts.fromJson(core.Map _json) {
    if (_json.containsKey("channel")) {
      channel = _json["channel"];
    }
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("destination")) {
      destination = _json["destination"];
    }
    if (_json.containsKey("itemLevelIssues")) {
      itemLevelIssues = (_json["itemLevelIssues"] as core.List)
          .map<AccountStatusItemLevelIssue>(
              (value) => new AccountStatusItemLevelIssue.fromJson(value))
          .toList();
    }
    if (_json.containsKey("statistics")) {
      statistics = new AccountStatusStatistics.fromJson(_json["statistics"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (channel != null) {
      _json["channel"] = channel;
    }
    if (country != null) {
      _json["country"] = country;
    }
    if (destination != null) {
      _json["destination"] = destination;
    }
    if (itemLevelIssues != null) {
      _json["itemLevelIssues"] =
          itemLevelIssues.map((value) => (value).toJson()).toList();
    }
    if (statistics != null) {
      _json["statistics"] = (statistics).toJson();
    }
    return _json;
  }
}

class AccountStatusStatistics {
  /// Number of active offers.
  core.String active;

  /// Number of disapproved offers.
  core.String disapproved;

  /// Number of expiring offers.
  core.String expiring;

  /// Number of pending offers.
  core.String pending;

  AccountStatusStatistics();

  AccountStatusStatistics.fromJson(core.Map _json) {
    if (_json.containsKey("active")) {
      active = _json["active"];
    }
    if (_json.containsKey("disapproved")) {
      disapproved = _json["disapproved"];
    }
    if (_json.containsKey("expiring")) {
      expiring = _json["expiring"];
    }
    if (_json.containsKey("pending")) {
      pending = _json["pending"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (active != null) {
      _json["active"] = active;
    }
    if (disapproved != null) {
      _json["disapproved"] = disapproved;
    }
    if (expiring != null) {
      _json["expiring"] = expiring;
    }
    if (pending != null) {
      _json["pending"] = pending;
    }
    return _json;
  }
}

/// The tax settings of a merchant account. All methods require the admin role.
class AccountTax {
  /// The ID of the account to which these account tax settings belong.
  core.String accountId;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#accountTax".
  core.String kind;

  /// Tax rules. Updating the tax rules will enable US taxes (not reversible).
  /// Defining no rules is equivalent to not charging tax at all.
  core.List<AccountTaxTaxRule> rules;

  AccountTax();

  AccountTax.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("rules")) {
      rules = (_json["rules"] as core.List)
          .map<AccountTaxTaxRule>(
              (value) => new AccountTaxTaxRule.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (rules != null) {
      _json["rules"] = rules.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// Tax calculation rule to apply in a state or province (USA only).
class AccountTaxTaxRule {
  /// Country code in which tax is applicable.
  core.String country;

  /// State (or province) is which the tax is applicable, described by its
  /// location id (also called criteria id).
  core.String locationId;

  /// Explicit tax rate in percent, represented as a floating point number
  /// without the percentage character. Must not be negative.
  core.String ratePercent;

  /// If true, shipping charges are also taxed.
  core.bool shippingTaxed;

  /// Whether the tax rate is taken from a global tax table or specified
  /// explicitly.
  core.bool useGlobalRate;

  AccountTaxTaxRule();

  AccountTaxTaxRule.fromJson(core.Map _json) {
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("locationId")) {
      locationId = _json["locationId"];
    }
    if (_json.containsKey("ratePercent")) {
      ratePercent = _json["ratePercent"];
    }
    if (_json.containsKey("shippingTaxed")) {
      shippingTaxed = _json["shippingTaxed"];
    }
    if (_json.containsKey("useGlobalRate")) {
      useGlobalRate = _json["useGlobalRate"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (country != null) {
      _json["country"] = country;
    }
    if (locationId != null) {
      _json["locationId"] = locationId;
    }
    if (ratePercent != null) {
      _json["ratePercent"] = ratePercent;
    }
    if (shippingTaxed != null) {
      _json["shippingTaxed"] = shippingTaxed;
    }
    if (useGlobalRate != null) {
      _json["useGlobalRate"] = useGlobalRate;
    }
    return _json;
  }
}

class AccountUser {
  /// Whether user is an admin.
  core.bool admin;

  /// User's email address.
  core.String emailAddress;

  /// Whether user is an order manager.
  core.bool orderManager;

  /// Whether user can access payment statements.
  core.bool paymentsAnalyst;

  /// Whether user can manage payment settings.
  core.bool paymentsManager;

  AccountUser();

  AccountUser.fromJson(core.Map _json) {
    if (_json.containsKey("admin")) {
      admin = _json["admin"];
    }
    if (_json.containsKey("emailAddress")) {
      emailAddress = _json["emailAddress"];
    }
    if (_json.containsKey("orderManager")) {
      orderManager = _json["orderManager"];
    }
    if (_json.containsKey("paymentsAnalyst")) {
      paymentsAnalyst = _json["paymentsAnalyst"];
    }
    if (_json.containsKey("paymentsManager")) {
      paymentsManager = _json["paymentsManager"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (admin != null) {
      _json["admin"] = admin;
    }
    if (emailAddress != null) {
      _json["emailAddress"] = emailAddress;
    }
    if (orderManager != null) {
      _json["orderManager"] = orderManager;
    }
    if (paymentsAnalyst != null) {
      _json["paymentsAnalyst"] = paymentsAnalyst;
    }
    if (paymentsManager != null) {
      _json["paymentsManager"] = paymentsManager;
    }
    return _json;
  }
}

class AccountYouTubeChannelLink {
  /// Channel ID.
  core.String channelId;

  /// Status of the link between this Merchant Center account and the YouTube
  /// channel. Upon retrieval, it represents the actual status of the link and
  /// can be either active if it was approved in YT Creator Studio or pending if
  /// it's pending approval. Upon insertion, it represents the intended status
  /// of the link. Re-uploading a link with status active when it's still
  /// pending or with status pending when it's already active will have no
  /// effect: the status will remain unchanged. Re-uploading a link with
  /// deprecated status inactive is equivalent to not submitting the link at all
  /// and will delete the link if it was active or cancel the link request if it
  /// was pending.
  core.String status;

  AccountYouTubeChannelLink();

  AccountYouTubeChannelLink.fromJson(core.Map _json) {
    if (_json.containsKey("channelId")) {
      channelId = _json["channelId"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (channelId != null) {
      _json["channelId"] = channelId;
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

class AccountsAuthInfoResponse {
  /// The account identifiers corresponding to the authenticated user.
  /// - For an individual account: only the merchant ID is defined
  /// - For an aggregator: only the aggregator ID is defined
  /// - For a subaccount of an MCA: both the merchant ID and the aggregator ID
  /// are defined.
  core.List<AccountIdentifier> accountIdentifiers;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#accountsAuthInfoResponse".
  core.String kind;

  AccountsAuthInfoResponse();

  AccountsAuthInfoResponse.fromJson(core.Map _json) {
    if (_json.containsKey("accountIdentifiers")) {
      accountIdentifiers = (_json["accountIdentifiers"] as core.List)
          .map<AccountIdentifier>(
              (value) => new AccountIdentifier.fromJson(value))
          .toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (accountIdentifiers != null) {
      _json["accountIdentifiers"] =
          accountIdentifiers.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class AccountsClaimWebsiteResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#accountsClaimWebsiteResponse".
  core.String kind;

  AccountsClaimWebsiteResponse();

  AccountsClaimWebsiteResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class AccountsCustomBatchRequest {
  /// The request entries to be processed in the batch.
  core.List<AccountsCustomBatchRequestEntry> entries;

  AccountsCustomBatchRequest();

  AccountsCustomBatchRequest.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = (_json["entries"] as core.List)
          .map<AccountsCustomBatchRequestEntry>(
              (value) => new AccountsCustomBatchRequestEntry.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// A batch entry encoding a single non-batch accounts request.
class AccountsCustomBatchRequestEntry {
  /// The account to create or update. Only defined if the method is insert or
  /// update.
  Account account;

  /// The ID of the targeted account. Only defined if the method is not insert.
  core.String accountId;

  /// An entry ID, unique within the batch request.
  core.int batchId;

  /// Whether the account should be deleted if the account has offers. Only
  /// applicable if the method is delete.
  core.bool force;

  /// Details about the link request.
  AccountsCustomBatchRequestEntryLinkRequest linkRequest;

  /// The ID of the managing account.
  core.String merchantId;

  /// The method of the batch entry.
  core.String method;

  /// Only applicable if the method is claimwebsite. Indicates whether or not to
  /// take the claim from another account in case there is a conflict.
  core.bool overwrite;

  AccountsCustomBatchRequestEntry();

  AccountsCustomBatchRequestEntry.fromJson(core.Map _json) {
    if (_json.containsKey("account")) {
      account = new Account.fromJson(_json["account"]);
    }
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("force")) {
      force = _json["force"];
    }
    if (_json.containsKey("linkRequest")) {
      linkRequest = new AccountsCustomBatchRequestEntryLinkRequest.fromJson(
          _json["linkRequest"]);
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
    if (_json.containsKey("overwrite")) {
      overwrite = _json["overwrite"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (account != null) {
      _json["account"] = (account).toJson();
    }
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (force != null) {
      _json["force"] = force;
    }
    if (linkRequest != null) {
      _json["linkRequest"] = (linkRequest).toJson();
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (method != null) {
      _json["method"] = method;
    }
    if (overwrite != null) {
      _json["overwrite"] = overwrite;
    }
    return _json;
  }
}

class AccountsCustomBatchRequestEntryLinkRequest {
  /// Action to perform for this link. The "request" action is only available to
  /// select merchants.
  core.String action;

  /// Type of the link between the two accounts.
  core.String linkType;

  /// The ID of the linked account.
  core.String linkedAccountId;

  AccountsCustomBatchRequestEntryLinkRequest();

  AccountsCustomBatchRequestEntryLinkRequest.fromJson(core.Map _json) {
    if (_json.containsKey("action")) {
      action = _json["action"];
    }
    if (_json.containsKey("linkType")) {
      linkType = _json["linkType"];
    }
    if (_json.containsKey("linkedAccountId")) {
      linkedAccountId = _json["linkedAccountId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (action != null) {
      _json["action"] = action;
    }
    if (linkType != null) {
      _json["linkType"] = linkType;
    }
    if (linkedAccountId != null) {
      _json["linkedAccountId"] = linkedAccountId;
    }
    return _json;
  }
}

class AccountsCustomBatchResponse {
  /// The result of the execution of the batch requests.
  core.List<AccountsCustomBatchResponseEntry> entries;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#accountsCustomBatchResponse".
  core.String kind;

  AccountsCustomBatchResponse();

  AccountsCustomBatchResponse.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = (_json["entries"] as core.List)
          .map<AccountsCustomBatchResponseEntry>(
              (value) => new AccountsCustomBatchResponseEntry.fromJson(value))
          .toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/// A batch entry encoding a single non-batch accounts response.
class AccountsCustomBatchResponseEntry {
  /// The retrieved, created, or updated account. Not defined if the method was
  /// delete, claimwebsite or link.
  Account account;

  /// The ID of the request entry this entry responds to.
  core.int batchId;

  /// A list of errors defined if and only if the request failed.
  Errors errors;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#accountsCustomBatchResponseEntry".
  core.String kind;

  AccountsCustomBatchResponseEntry();

  AccountsCustomBatchResponseEntry.fromJson(core.Map _json) {
    if (_json.containsKey("account")) {
      account = new Account.fromJson(_json["account"]);
    }
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("errors")) {
      errors = new Errors.fromJson(_json["errors"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (account != null) {
      _json["account"] = (account).toJson();
    }
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (errors != null) {
      _json["errors"] = (errors).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class AccountsLinkRequest {
  /// Action to perform for this link. The "request" action is only available to
  /// select merchants.
  core.String action;

  /// Type of the link between the two accounts.
  core.String linkType;

  /// The ID of the linked account.
  core.String linkedAccountId;

  AccountsLinkRequest();

  AccountsLinkRequest.fromJson(core.Map _json) {
    if (_json.containsKey("action")) {
      action = _json["action"];
    }
    if (_json.containsKey("linkType")) {
      linkType = _json["linkType"];
    }
    if (_json.containsKey("linkedAccountId")) {
      linkedAccountId = _json["linkedAccountId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (action != null) {
      _json["action"] = action;
    }
    if (linkType != null) {
      _json["linkType"] = linkType;
    }
    if (linkedAccountId != null) {
      _json["linkedAccountId"] = linkedAccountId;
    }
    return _json;
  }
}

class AccountsLinkResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#accountsLinkResponse".
  core.String kind;

  AccountsLinkResponse();

  AccountsLinkResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class AccountsListResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#accountsListResponse".
  core.String kind;

  /// The token for the retrieval of the next page of accounts.
  core.String nextPageToken;
  core.List<Account> resources;

  AccountsListResponse();

  AccountsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resources")) {
      resources = (_json["resources"] as core.List)
          .map<Account>((value) => new Account.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resources != null) {
      _json["resources"] = resources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class AccountstatusesCustomBatchRequest {
  /// The request entries to be processed in the batch.
  core.List<AccountstatusesCustomBatchRequestEntry> entries;

  AccountstatusesCustomBatchRequest();

  AccountstatusesCustomBatchRequest.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = (_json["entries"] as core.List)
          .map<AccountstatusesCustomBatchRequestEntry>((value) =>
              new AccountstatusesCustomBatchRequestEntry.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// A batch entry encoding a single non-batch accountstatuses request.
class AccountstatusesCustomBatchRequestEntry {
  /// The ID of the (sub-)account whose status to get.
  core.String accountId;

  /// An entry ID, unique within the batch request.
  core.int batchId;

  /// If set, only issues for the specified destinations are returned, otherwise
  /// only issues for the Shopping destination.
  core.List<core.String> destinations;

  /// The ID of the managing account.
  core.String merchantId;

  /// The method (get).
  core.String method;

  AccountstatusesCustomBatchRequestEntry();

  AccountstatusesCustomBatchRequestEntry.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("destinations")) {
      destinations = (_json["destinations"] as core.List).cast<core.String>();
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (destinations != null) {
      _json["destinations"] = destinations;
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (method != null) {
      _json["method"] = method;
    }
    return _json;
  }
}

class AccountstatusesCustomBatchResponse {
  /// The result of the execution of the batch requests.
  core.List<AccountstatusesCustomBatchResponseEntry> entries;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#accountstatusesCustomBatchResponse".
  core.String kind;

  AccountstatusesCustomBatchResponse();

  AccountstatusesCustomBatchResponse.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = (_json["entries"] as core.List)
          .map<AccountstatusesCustomBatchResponseEntry>((value) =>
              new AccountstatusesCustomBatchResponseEntry.fromJson(value))
          .toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/// A batch entry encoding a single non-batch accountstatuses response.
class AccountstatusesCustomBatchResponseEntry {
  /// The requested account status. Defined if and only if the request was
  /// successful.
  AccountStatus accountStatus;

  /// The ID of the request entry this entry responds to.
  core.int batchId;

  /// A list of errors defined if and only if the request failed.
  Errors errors;

  AccountstatusesCustomBatchResponseEntry();

  AccountstatusesCustomBatchResponseEntry.fromJson(core.Map _json) {
    if (_json.containsKey("accountStatus")) {
      accountStatus = new AccountStatus.fromJson(_json["accountStatus"]);
    }
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("errors")) {
      errors = new Errors.fromJson(_json["errors"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (accountStatus != null) {
      _json["accountStatus"] = (accountStatus).toJson();
    }
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (errors != null) {
      _json["errors"] = (errors).toJson();
    }
    return _json;
  }
}

class AccountstatusesListResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#accountstatusesListResponse".
  core.String kind;

  /// The token for the retrieval of the next page of account statuses.
  core.String nextPageToken;
  core.List<AccountStatus> resources;

  AccountstatusesListResponse();

  AccountstatusesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resources")) {
      resources = (_json["resources"] as core.List)
          .map<AccountStatus>((value) => new AccountStatus.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resources != null) {
      _json["resources"] = resources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class AccounttaxCustomBatchRequest {
  /// The request entries to be processed in the batch.
  core.List<AccounttaxCustomBatchRequestEntry> entries;

  AccounttaxCustomBatchRequest();

  AccounttaxCustomBatchRequest.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = (_json["entries"] as core.List)
          .map<AccounttaxCustomBatchRequestEntry>(
              (value) => new AccounttaxCustomBatchRequestEntry.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// A batch entry encoding a single non-batch accounttax request.
class AccounttaxCustomBatchRequestEntry {
  /// The ID of the account for which to get/update account tax settings.
  core.String accountId;

  /// The account tax settings to update. Only defined if the method is update.
  AccountTax accountTax;

  /// An entry ID, unique within the batch request.
  core.int batchId;

  /// The ID of the managing account.
  core.String merchantId;
  core.String method;

  AccounttaxCustomBatchRequestEntry();

  AccounttaxCustomBatchRequestEntry.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("accountTax")) {
      accountTax = new AccountTax.fromJson(_json["accountTax"]);
    }
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (accountTax != null) {
      _json["accountTax"] = (accountTax).toJson();
    }
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (method != null) {
      _json["method"] = method;
    }
    return _json;
  }
}

class AccounttaxCustomBatchResponse {
  /// The result of the execution of the batch requests.
  core.List<AccounttaxCustomBatchResponseEntry> entries;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#accounttaxCustomBatchResponse".
  core.String kind;

  AccounttaxCustomBatchResponse();

  AccounttaxCustomBatchResponse.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = (_json["entries"] as core.List)
          .map<AccounttaxCustomBatchResponseEntry>(
              (value) => new AccounttaxCustomBatchResponseEntry.fromJson(value))
          .toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/// A batch entry encoding a single non-batch accounttax response.
class AccounttaxCustomBatchResponseEntry {
  /// The retrieved or updated account tax settings.
  AccountTax accountTax;

  /// The ID of the request entry this entry responds to.
  core.int batchId;

  /// A list of errors defined if and only if the request failed.
  Errors errors;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#accounttaxCustomBatchResponseEntry".
  core.String kind;

  AccounttaxCustomBatchResponseEntry();

  AccounttaxCustomBatchResponseEntry.fromJson(core.Map _json) {
    if (_json.containsKey("accountTax")) {
      accountTax = new AccountTax.fromJson(_json["accountTax"]);
    }
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("errors")) {
      errors = new Errors.fromJson(_json["errors"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (accountTax != null) {
      _json["accountTax"] = (accountTax).toJson();
    }
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (errors != null) {
      _json["errors"] = (errors).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class AccounttaxListResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#accounttaxListResponse".
  core.String kind;

  /// The token for the retrieval of the next page of account tax settings.
  core.String nextPageToken;
  core.List<AccountTax> resources;

  AccounttaxListResponse();

  AccounttaxListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resources")) {
      resources = (_json["resources"] as core.List)
          .map<AccountTax>((value) => new AccountTax.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resources != null) {
      _json["resources"] = resources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class Amount {
  /// [required] The pre-tax or post-tax price depending on the location of the
  /// order.
  Price priceAmount;

  /// [required] Tax value.
  Price taxAmount;

  Amount();

  Amount.fromJson(core.Map _json) {
    if (_json.containsKey("priceAmount")) {
      priceAmount = new Price.fromJson(_json["priceAmount"]);
    }
    if (_json.containsKey("taxAmount")) {
      taxAmount = new Price.fromJson(_json["taxAmount"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (priceAmount != null) {
      _json["priceAmount"] = (priceAmount).toJson();
    }
    if (taxAmount != null) {
      _json["taxAmount"] = (taxAmount).toJson();
    }
    return _json;
  }
}

class CarrierRate {
  /// Carrier service, such as "UPS" or "Fedex". The list of supported carriers
  /// can be retrieved via the getSupportedCarriers method. Required.
  core.String carrierName;

  /// Carrier service, such as "ground" or "2 days". The list of supported
  /// services for a carrier can be retrieved via the getSupportedCarriers
  /// method. Required.
  core.String carrierService;

  /// Additive shipping rate modifier. Can be negative. For example { "value":
  /// "1", "currency" : "USD" } adds $1 to the rate, { "value": "-3", "currency"
  /// : "USD" } removes $3 from the rate. Optional.
  Price flatAdjustment;

  /// Name of the carrier rate. Must be unique per rate group. Required.
  core.String name;

  /// Shipping origin for this carrier rate. Required.
  core.String originPostalCode;

  /// Multiplicative shipping rate modifier as a number in decimal notation. Can
  /// be negative. For example "5.4" increases the rate by 5.4%, "-3" decreases
  /// the rate by 3%. Optional.
  core.String percentageAdjustment;

  CarrierRate();

  CarrierRate.fromJson(core.Map _json) {
    if (_json.containsKey("carrierName")) {
      carrierName = _json["carrierName"];
    }
    if (_json.containsKey("carrierService")) {
      carrierService = _json["carrierService"];
    }
    if (_json.containsKey("flatAdjustment")) {
      flatAdjustment = new Price.fromJson(_json["flatAdjustment"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("originPostalCode")) {
      originPostalCode = _json["originPostalCode"];
    }
    if (_json.containsKey("percentageAdjustment")) {
      percentageAdjustment = _json["percentageAdjustment"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (carrierName != null) {
      _json["carrierName"] = carrierName;
    }
    if (carrierService != null) {
      _json["carrierService"] = carrierService;
    }
    if (flatAdjustment != null) {
      _json["flatAdjustment"] = (flatAdjustment).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (originPostalCode != null) {
      _json["originPostalCode"] = originPostalCode;
    }
    if (percentageAdjustment != null) {
      _json["percentageAdjustment"] = percentageAdjustment;
    }
    return _json;
  }
}

class CarriersCarrier {
  /// The CLDR country code of the carrier (e.g., "US"). Always present.
  core.String country;

  /// The name of the carrier (e.g., "UPS"). Always present.
  core.String name;

  /// A list of supported services (e.g., "ground") for that carrier. Contains
  /// at least one service.
  core.List<core.String> services;

  CarriersCarrier();

  CarriersCarrier.fromJson(core.Map _json) {
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("services")) {
      services = (_json["services"] as core.List).cast<core.String>();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (country != null) {
      _json["country"] = country;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (services != null) {
      _json["services"] = services;
    }
    return _json;
  }
}

class CustomAttribute {
  /// Subattributes within this attribute group. Exactly one of value or
  /// groupValues must be provided.
  core.List<CustomAttribute> groupValues;

  /// The name of the attribute. Underscores will be replaced by spaces upon
  /// insertion.
  core.String name;

  /// The value of the attribute.
  core.String value;

  CustomAttribute();

  CustomAttribute.fromJson(core.Map _json) {
    if (_json.containsKey("groupValues")) {
      groupValues = (_json["groupValues"] as core.List)
          .map<CustomAttribute>((value) => new CustomAttribute.fromJson(value))
          .toList();
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (groupValues != null) {
      _json["groupValues"] =
          groupValues.map((value) => (value).toJson()).toList();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class CustomerReturnReason {
  core.String description;
  core.String reasonCode;

  CustomerReturnReason();

  CustomerReturnReason.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("reasonCode")) {
      reasonCode = _json["reasonCode"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (description != null) {
      _json["description"] = description;
    }
    if (reasonCode != null) {
      _json["reasonCode"] = reasonCode;
    }
    return _json;
  }
}

class CutoffTime {
  /// Hour of the cutoff time until which an order has to be placed to be
  /// processed in the same day. Required.
  core.int hour;

  /// Minute of the cutoff time until which an order has to be placed to be
  /// processed in the same day. Required.
  core.int minute;

  /// Timezone identifier for the cutoff time. A list of identifiers can be
  /// found in  the AdWords API documentation. E.g. "Europe/Zurich". Required.
  core.String timezone;

  CutoffTime();

  CutoffTime.fromJson(core.Map _json) {
    if (_json.containsKey("hour")) {
      hour = _json["hour"];
    }
    if (_json.containsKey("minute")) {
      minute = _json["minute"];
    }
    if (_json.containsKey("timezone")) {
      timezone = _json["timezone"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (hour != null) {
      _json["hour"] = hour;
    }
    if (minute != null) {
      _json["minute"] = minute;
    }
    if (timezone != null) {
      _json["timezone"] = timezone;
    }
    return _json;
  }
}

/// Datafeed configuration data.
class Datafeed {
  /// The two-letter ISO 639-1 language in which the attributes are defined in
  /// the data feed.
  core.String attributeLanguage;

  /// The type of data feed. For product inventory feeds, only feeds for local
  /// stores, not online stores, are supported.
  core.String contentType;

  /// Fetch schedule for the feed file.
  DatafeedFetchSchedule fetchSchedule;

  /// The filename of the feed. All feeds must have a unique file name.
  core.String fileName;

  /// Format of the feed file.
  DatafeedFormat format;

  /// The ID of the data feed.
  core.String id;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#datafeed".
  core.String kind;

  /// A descriptive name of the data feed.
  core.String name;

  /// The targets this feed should apply to (country, language, destinations).
  core.List<DatafeedTarget> targets;

  Datafeed();

  Datafeed.fromJson(core.Map _json) {
    if (_json.containsKey("attributeLanguage")) {
      attributeLanguage = _json["attributeLanguage"];
    }
    if (_json.containsKey("contentType")) {
      contentType = _json["contentType"];
    }
    if (_json.containsKey("fetchSchedule")) {
      fetchSchedule =
          new DatafeedFetchSchedule.fromJson(_json["fetchSchedule"]);
    }
    if (_json.containsKey("fileName")) {
      fileName = _json["fileName"];
    }
    if (_json.containsKey("format")) {
      format = new DatafeedFormat.fromJson(_json["format"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("targets")) {
      targets = (_json["targets"] as core.List)
          .map<DatafeedTarget>((value) => new DatafeedTarget.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (attributeLanguage != null) {
      _json["attributeLanguage"] = attributeLanguage;
    }
    if (contentType != null) {
      _json["contentType"] = contentType;
    }
    if (fetchSchedule != null) {
      _json["fetchSchedule"] = (fetchSchedule).toJson();
    }
    if (fileName != null) {
      _json["fileName"] = fileName;
    }
    if (format != null) {
      _json["format"] = (format).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (targets != null) {
      _json["targets"] = targets.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// The required fields vary based on the frequency of fetching. For a monthly
/// fetch schedule, day_of_month and hour are required. For a weekly fetch
/// schedule, weekday and hour are required. For a daily fetch schedule, only
/// hour is required.
class DatafeedFetchSchedule {
  /// The day of the month the feed file should be fetched (1-31).
  core.int dayOfMonth;

  /// The URL where the feed file can be fetched. Google Merchant Center will
  /// support automatic scheduled uploads using the HTTP, HTTPS, FTP, or SFTP
  /// protocols, so the value will need to be a valid link using one of those
  /// four protocols.
  core.String fetchUrl;

  /// The hour of the day the feed file should be fetched (0-23).
  core.int hour;

  /// The minute of the hour the feed file should be fetched (0-59). Read-only.
  core.int minuteOfHour;

  /// An optional password for fetch_url.
  core.String password;

  /// Whether the scheduled fetch is paused or not.
  core.bool paused;

  /// Time zone used for schedule. UTC by default. E.g., "America/Los_Angeles".
  core.String timeZone;

  /// An optional user name for fetch_url.
  core.String username;

  /// The day of the week the feed file should be fetched.
  core.String weekday;

  DatafeedFetchSchedule();

  DatafeedFetchSchedule.fromJson(core.Map _json) {
    if (_json.containsKey("dayOfMonth")) {
      dayOfMonth = _json["dayOfMonth"];
    }
    if (_json.containsKey("fetchUrl")) {
      fetchUrl = _json["fetchUrl"];
    }
    if (_json.containsKey("hour")) {
      hour = _json["hour"];
    }
    if (_json.containsKey("minuteOfHour")) {
      minuteOfHour = _json["minuteOfHour"];
    }
    if (_json.containsKey("password")) {
      password = _json["password"];
    }
    if (_json.containsKey("paused")) {
      paused = _json["paused"];
    }
    if (_json.containsKey("timeZone")) {
      timeZone = _json["timeZone"];
    }
    if (_json.containsKey("username")) {
      username = _json["username"];
    }
    if (_json.containsKey("weekday")) {
      weekday = _json["weekday"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (dayOfMonth != null) {
      _json["dayOfMonth"] = dayOfMonth;
    }
    if (fetchUrl != null) {
      _json["fetchUrl"] = fetchUrl;
    }
    if (hour != null) {
      _json["hour"] = hour;
    }
    if (minuteOfHour != null) {
      _json["minuteOfHour"] = minuteOfHour;
    }
    if (password != null) {
      _json["password"] = password;
    }
    if (paused != null) {
      _json["paused"] = paused;
    }
    if (timeZone != null) {
      _json["timeZone"] = timeZone;
    }
    if (username != null) {
      _json["username"] = username;
    }
    if (weekday != null) {
      _json["weekday"] = weekday;
    }
    return _json;
  }
}

class DatafeedFormat {
  /// Delimiter for the separation of values in a delimiter-separated values
  /// feed. If not specified, the delimiter will be auto-detected. Ignored for
  /// non-DSV data feeds.
  core.String columnDelimiter;

  /// Character encoding scheme of the data feed. If not specified, the encoding
  /// will be auto-detected.
  core.String fileEncoding;

  /// Specifies how double quotes are interpreted. If not specified, the mode
  /// will be auto-detected. Ignored for non-DSV data feeds.
  core.String quotingMode;

  DatafeedFormat();

  DatafeedFormat.fromJson(core.Map _json) {
    if (_json.containsKey("columnDelimiter")) {
      columnDelimiter = _json["columnDelimiter"];
    }
    if (_json.containsKey("fileEncoding")) {
      fileEncoding = _json["fileEncoding"];
    }
    if (_json.containsKey("quotingMode")) {
      quotingMode = _json["quotingMode"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (columnDelimiter != null) {
      _json["columnDelimiter"] = columnDelimiter;
    }
    if (fileEncoding != null) {
      _json["fileEncoding"] = fileEncoding;
    }
    if (quotingMode != null) {
      _json["quotingMode"] = quotingMode;
    }
    return _json;
  }
}

/// The status of a datafeed, i.e., the result of the last retrieval of the
/// datafeed computed asynchronously when the feed processing is finished.
class DatafeedStatus {
  /// The country for which the status is reported, represented as a  CLDR
  /// territory code.
  core.String country;

  /// The ID of the feed for which the status is reported.
  core.String datafeedId;

  /// The list of errors occurring in the feed.
  core.List<DatafeedStatusError> errors;

  /// The number of items in the feed that were processed.
  core.String itemsTotal;

  /// The number of items in the feed that were valid.
  core.String itemsValid;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#datafeedStatus".
  core.String kind;

  /// The two-letter ISO 639-1 language for which the status is reported.
  core.String language;

  /// The last date at which the feed was uploaded.
  core.String lastUploadDate;

  /// The processing status of the feed.
  core.String processingStatus;

  /// The list of errors occurring in the feed.
  core.List<DatafeedStatusError> warnings;

  DatafeedStatus();

  DatafeedStatus.fromJson(core.Map _json) {
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("datafeedId")) {
      datafeedId = _json["datafeedId"];
    }
    if (_json.containsKey("errors")) {
      errors = (_json["errors"] as core.List)
          .map<DatafeedStatusError>(
              (value) => new DatafeedStatusError.fromJson(value))
          .toList();
    }
    if (_json.containsKey("itemsTotal")) {
      itemsTotal = _json["itemsTotal"];
    }
    if (_json.containsKey("itemsValid")) {
      itemsValid = _json["itemsValid"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("language")) {
      language = _json["language"];
    }
    if (_json.containsKey("lastUploadDate")) {
      lastUploadDate = _json["lastUploadDate"];
    }
    if (_json.containsKey("processingStatus")) {
      processingStatus = _json["processingStatus"];
    }
    if (_json.containsKey("warnings")) {
      warnings = (_json["warnings"] as core.List)
          .map<DatafeedStatusError>(
              (value) => new DatafeedStatusError.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (country != null) {
      _json["country"] = country;
    }
    if (datafeedId != null) {
      _json["datafeedId"] = datafeedId;
    }
    if (errors != null) {
      _json["errors"] = errors.map((value) => (value).toJson()).toList();
    }
    if (itemsTotal != null) {
      _json["itemsTotal"] = itemsTotal;
    }
    if (itemsValid != null) {
      _json["itemsValid"] = itemsValid;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (language != null) {
      _json["language"] = language;
    }
    if (lastUploadDate != null) {
      _json["lastUploadDate"] = lastUploadDate;
    }
    if (processingStatus != null) {
      _json["processingStatus"] = processingStatus;
    }
    if (warnings != null) {
      _json["warnings"] = warnings.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// An error occurring in the feed, like "invalid price".
class DatafeedStatusError {
  /// The code of the error, e.g., "validation/invalid_value".
  core.String code;

  /// The number of occurrences of the error in the feed.
  core.String count;

  /// A list of example occurrences of the error, grouped by product.
  core.List<DatafeedStatusExample> examples;

  /// The error message, e.g., "Invalid price".
  core.String message;

  DatafeedStatusError();

  DatafeedStatusError.fromJson(core.Map _json) {
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("count")) {
      count = _json["count"];
    }
    if (_json.containsKey("examples")) {
      examples = (_json["examples"] as core.List)
          .map<DatafeedStatusExample>(
              (value) => new DatafeedStatusExample.fromJson(value))
          .toList();
    }
    if (_json.containsKey("message")) {
      message = _json["message"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (code != null) {
      _json["code"] = code;
    }
    if (count != null) {
      _json["count"] = count;
    }
    if (examples != null) {
      _json["examples"] = examples.map((value) => (value).toJson()).toList();
    }
    if (message != null) {
      _json["message"] = message;
    }
    return _json;
  }
}

/// An example occurrence for a particular error.
class DatafeedStatusExample {
  /// The ID of the example item.
  core.String itemId;

  /// Line number in the data feed where the example is found.
  core.String lineNumber;

  /// The problematic value.
  core.String value;

  DatafeedStatusExample();

  DatafeedStatusExample.fromJson(core.Map _json) {
    if (_json.containsKey("itemId")) {
      itemId = _json["itemId"];
    }
    if (_json.containsKey("lineNumber")) {
      lineNumber = _json["lineNumber"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (itemId != null) {
      _json["itemId"] = itemId;
    }
    if (lineNumber != null) {
      _json["lineNumber"] = lineNumber;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class DatafeedTarget {
  /// The country where the items in the feed will be included in the search
  /// index, represented as a  CLDR territory code.
  core.String country;

  /// The list of destinations to exclude for this target (corresponds to
  /// unchecked check boxes in Merchant Center).
  core.List<core.String> excludedDestinations;

  /// The list of destinations to include for this target (corresponds to
  /// checked check boxes in Merchant Center). Default destinations are always
  /// included unless provided in the excluded_destination field.
  core.List<core.String> includedDestinations;

  /// The two-letter ISO 639-1 language of the items in the feed. Must be a
  /// valid language for targets[].country.
  core.String language;

  DatafeedTarget();

  DatafeedTarget.fromJson(core.Map _json) {
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("excludedDestinations")) {
      excludedDestinations =
          (_json["excludedDestinations"] as core.List).cast<core.String>();
    }
    if (_json.containsKey("includedDestinations")) {
      includedDestinations =
          (_json["includedDestinations"] as core.List).cast<core.String>();
    }
    if (_json.containsKey("language")) {
      language = _json["language"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (country != null) {
      _json["country"] = country;
    }
    if (excludedDestinations != null) {
      _json["excludedDestinations"] = excludedDestinations;
    }
    if (includedDestinations != null) {
      _json["includedDestinations"] = includedDestinations;
    }
    if (language != null) {
      _json["language"] = language;
    }
    return _json;
  }
}

class DatafeedsCustomBatchRequest {
  /// The request entries to be processed in the batch.
  core.List<DatafeedsCustomBatchRequestEntry> entries;

  DatafeedsCustomBatchRequest();

  DatafeedsCustomBatchRequest.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = (_json["entries"] as core.List)
          .map<DatafeedsCustomBatchRequestEntry>(
              (value) => new DatafeedsCustomBatchRequestEntry.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// A batch entry encoding a single non-batch datafeeds request.
class DatafeedsCustomBatchRequestEntry {
  /// An entry ID, unique within the batch request.
  core.int batchId;

  /// The data feed to insert.
  Datafeed datafeed;

  /// The ID of the data feed to get, delete or fetch.
  core.String datafeedId;

  /// The ID of the managing account.
  core.String merchantId;
  core.String method;

  DatafeedsCustomBatchRequestEntry();

  DatafeedsCustomBatchRequestEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("datafeed")) {
      datafeed = new Datafeed.fromJson(_json["datafeed"]);
    }
    if (_json.containsKey("datafeedId")) {
      datafeedId = _json["datafeedId"];
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (datafeed != null) {
      _json["datafeed"] = (datafeed).toJson();
    }
    if (datafeedId != null) {
      _json["datafeedId"] = datafeedId;
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (method != null) {
      _json["method"] = method;
    }
    return _json;
  }
}

class DatafeedsCustomBatchResponse {
  /// The result of the execution of the batch requests.
  core.List<DatafeedsCustomBatchResponseEntry> entries;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#datafeedsCustomBatchResponse".
  core.String kind;

  DatafeedsCustomBatchResponse();

  DatafeedsCustomBatchResponse.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = (_json["entries"] as core.List)
          .map<DatafeedsCustomBatchResponseEntry>(
              (value) => new DatafeedsCustomBatchResponseEntry.fromJson(value))
          .toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/// A batch entry encoding a single non-batch datafeeds response.
class DatafeedsCustomBatchResponseEntry {
  /// The ID of the request entry this entry responds to.
  core.int batchId;

  /// The requested data feed. Defined if and only if the request was
  /// successful.
  Datafeed datafeed;

  /// A list of errors defined if and only if the request failed.
  Errors errors;

  DatafeedsCustomBatchResponseEntry();

  DatafeedsCustomBatchResponseEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("datafeed")) {
      datafeed = new Datafeed.fromJson(_json["datafeed"]);
    }
    if (_json.containsKey("errors")) {
      errors = new Errors.fromJson(_json["errors"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (datafeed != null) {
      _json["datafeed"] = (datafeed).toJson();
    }
    if (errors != null) {
      _json["errors"] = (errors).toJson();
    }
    return _json;
  }
}

class DatafeedsFetchNowResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#datafeedsFetchNowResponse".
  core.String kind;

  DatafeedsFetchNowResponse();

  DatafeedsFetchNowResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class DatafeedsListResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#datafeedsListResponse".
  core.String kind;

  /// The token for the retrieval of the next page of datafeeds.
  core.String nextPageToken;
  core.List<Datafeed> resources;

  DatafeedsListResponse();

  DatafeedsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resources")) {
      resources = (_json["resources"] as core.List)
          .map<Datafeed>((value) => new Datafeed.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resources != null) {
      _json["resources"] = resources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class DatafeedstatusesCustomBatchRequest {
  /// The request entries to be processed in the batch.
  core.List<DatafeedstatusesCustomBatchRequestEntry> entries;

  DatafeedstatusesCustomBatchRequest();

  DatafeedstatusesCustomBatchRequest.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = (_json["entries"] as core.List)
          .map<DatafeedstatusesCustomBatchRequestEntry>((value) =>
              new DatafeedstatusesCustomBatchRequestEntry.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// A batch entry encoding a single non-batch datafeedstatuses request.
class DatafeedstatusesCustomBatchRequestEntry {
  /// An entry ID, unique within the batch request.
  core.int batchId;

  /// The country for which to get the datafeed status. If this parameter is
  /// provided then language must also be provided. Note that for multi-target
  /// datafeeds this parameter is required.
  core.String country;

  /// The ID of the data feed to get.
  core.String datafeedId;

  /// The language for which to get the datafeed status. If this parameter is
  /// provided then country must also be provided. Note that for multi-target
  /// datafeeds this parameter is required.
  core.String language;

  /// The ID of the managing account.
  core.String merchantId;
  core.String method;

  DatafeedstatusesCustomBatchRequestEntry();

  DatafeedstatusesCustomBatchRequestEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("datafeedId")) {
      datafeedId = _json["datafeedId"];
    }
    if (_json.containsKey("language")) {
      language = _json["language"];
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (country != null) {
      _json["country"] = country;
    }
    if (datafeedId != null) {
      _json["datafeedId"] = datafeedId;
    }
    if (language != null) {
      _json["language"] = language;
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (method != null) {
      _json["method"] = method;
    }
    return _json;
  }
}

class DatafeedstatusesCustomBatchResponse {
  /// The result of the execution of the batch requests.
  core.List<DatafeedstatusesCustomBatchResponseEntry> entries;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#datafeedstatusesCustomBatchResponse".
  core.String kind;

  DatafeedstatusesCustomBatchResponse();

  DatafeedstatusesCustomBatchResponse.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = (_json["entries"] as core.List)
          .map<DatafeedstatusesCustomBatchResponseEntry>((value) =>
              new DatafeedstatusesCustomBatchResponseEntry.fromJson(value))
          .toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/// A batch entry encoding a single non-batch datafeedstatuses response.
class DatafeedstatusesCustomBatchResponseEntry {
  /// The ID of the request entry this entry responds to.
  core.int batchId;

  /// The requested data feed status. Defined if and only if the request was
  /// successful.
  DatafeedStatus datafeedStatus;

  /// A list of errors defined if and only if the request failed.
  Errors errors;

  DatafeedstatusesCustomBatchResponseEntry();

  DatafeedstatusesCustomBatchResponseEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("datafeedStatus")) {
      datafeedStatus = new DatafeedStatus.fromJson(_json["datafeedStatus"]);
    }
    if (_json.containsKey("errors")) {
      errors = new Errors.fromJson(_json["errors"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (datafeedStatus != null) {
      _json["datafeedStatus"] = (datafeedStatus).toJson();
    }
    if (errors != null) {
      _json["errors"] = (errors).toJson();
    }
    return _json;
  }
}

class DatafeedstatusesListResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#datafeedstatusesListResponse".
  core.String kind;

  /// The token for the retrieval of the next page of datafeed statuses.
  core.String nextPageToken;
  core.List<DatafeedStatus> resources;

  DatafeedstatusesListResponse();

  DatafeedstatusesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resources")) {
      resources = (_json["resources"] as core.List)
          .map<DatafeedStatus>((value) => new DatafeedStatus.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resources != null) {
      _json["resources"] = resources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class DeliveryTime {
  /// Business days cutoff time definition. If not configured the cutoff time
  /// will be defaulted to 8AM PST.
  CutoffTime cutoffTime;

  /// Holiday cutoff definitions. If configured, they specify order cutoff times
  /// for holiday-specific shipping.
  core.List<HolidayCutoff> holidayCutoffs;

  /// Maximum number of business days spent before an order is shipped. 0 means
  /// same day shipped, 1 means next day shipped. Must be greater than or equal
  /// to minHandlingTimeInDays.
  core.int maxHandlingTimeInDays;

  /// Maximum number of business days that is spent in transit. 0 means same day
  /// delivery, 1 means next day delivery. Must be greater than or equal to
  /// minTransitTimeInDays. Required.
  core.int maxTransitTimeInDays;

  /// Minimum number of business days spent before an order is shipped. 0 means
  /// same day shipped, 1 means next day shipped.
  core.int minHandlingTimeInDays;

  /// Minimum number of business days that is spent in transit. 0 means same day
  /// delivery, 1 means next day delivery. Required.
  core.int minTransitTimeInDays;

  DeliveryTime();

  DeliveryTime.fromJson(core.Map _json) {
    if (_json.containsKey("cutoffTime")) {
      cutoffTime = new CutoffTime.fromJson(_json["cutoffTime"]);
    }
    if (_json.containsKey("holidayCutoffs")) {
      holidayCutoffs = (_json["holidayCutoffs"] as core.List)
          .map<HolidayCutoff>((value) => new HolidayCutoff.fromJson(value))
          .toList();
    }
    if (_json.containsKey("maxHandlingTimeInDays")) {
      maxHandlingTimeInDays = _json["maxHandlingTimeInDays"];
    }
    if (_json.containsKey("maxTransitTimeInDays")) {
      maxTransitTimeInDays = _json["maxTransitTimeInDays"];
    }
    if (_json.containsKey("minHandlingTimeInDays")) {
      minHandlingTimeInDays = _json["minHandlingTimeInDays"];
    }
    if (_json.containsKey("minTransitTimeInDays")) {
      minTransitTimeInDays = _json["minTransitTimeInDays"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (cutoffTime != null) {
      _json["cutoffTime"] = (cutoffTime).toJson();
    }
    if (holidayCutoffs != null) {
      _json["holidayCutoffs"] =
          holidayCutoffs.map((value) => (value).toJson()).toList();
    }
    if (maxHandlingTimeInDays != null) {
      _json["maxHandlingTimeInDays"] = maxHandlingTimeInDays;
    }
    if (maxTransitTimeInDays != null) {
      _json["maxTransitTimeInDays"] = maxTransitTimeInDays;
    }
    if (minHandlingTimeInDays != null) {
      _json["minHandlingTimeInDays"] = minHandlingTimeInDays;
    }
    if (minTransitTimeInDays != null) {
      _json["minTransitTimeInDays"] = minTransitTimeInDays;
    }
    return _json;
  }
}

/// An error returned by the API.
class Error {
  /// The domain of the error.
  core.String domain;

  /// A description of the error.
  core.String message;

  /// The error code.
  core.String reason;

  Error();

  Error.fromJson(core.Map _json) {
    if (_json.containsKey("domain")) {
      domain = _json["domain"];
    }
    if (_json.containsKey("message")) {
      message = _json["message"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (domain != null) {
      _json["domain"] = domain;
    }
    if (message != null) {
      _json["message"] = message;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    return _json;
  }
}

/// A list of errors returned by a failed batch entry.
class Errors {
  /// The HTTP status of the first error in errors.
  core.int code;

  /// A list of errors.
  core.List<Error> errors;

  /// The message of the first error in errors.
  core.String message;

  Errors();

  Errors.fromJson(core.Map _json) {
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("errors")) {
      errors = (_json["errors"] as core.List)
          .map<Error>((value) => new Error.fromJson(value))
          .toList();
    }
    if (_json.containsKey("message")) {
      message = _json["message"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (code != null) {
      _json["code"] = code;
    }
    if (errors != null) {
      _json["errors"] = errors.map((value) => (value).toJson()).toList();
    }
    if (message != null) {
      _json["message"] = message;
    }
    return _json;
  }
}

class GmbAccounts {
  /// The ID of the account.
  core.String accountId;

  /// A list of GMB accounts which are available to the merchant.
  core.List<GmbAccountsGmbAccount> gmbAccounts;

  GmbAccounts();

  GmbAccounts.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("gmbAccounts")) {
      gmbAccounts = (_json["gmbAccounts"] as core.List)
          .map<GmbAccountsGmbAccount>(
              (value) => new GmbAccountsGmbAccount.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (gmbAccounts != null) {
      _json["gmbAccounts"] =
          gmbAccounts.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class GmbAccountsGmbAccount {
  /// The email which identifies the GMB account.
  core.String email;

  /// Number of listings under this account.
  core.String listingCount;

  /// The name of the GMB account.
  core.String name;

  /// The type of the GMB account (User or Business).
  core.String type;

  GmbAccountsGmbAccount();

  GmbAccountsGmbAccount.fromJson(core.Map _json) {
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("listingCount")) {
      listingCount = _json["listingCount"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (email != null) {
      _json["email"] = email;
    }
    if (listingCount != null) {
      _json["listingCount"] = listingCount;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/// A non-empty list of row or column headers for a table. Exactly one of
/// prices, weights, numItems, postalCodeGroupNames, or locations must be set.
class Headers {
  /// A list of location ID sets. Must be non-empty. Can only be set if all
  /// other fields are not set.
  core.List<LocationIdSet> locations;

  /// A list of inclusive number of items upper bounds. The last value can be
  /// "infinity". For example ["10", "50", "infinity"] represents the headers
  /// "<= 10 items", " 50 items". Must be non-empty. Can only be set if all
  /// other fields are not set.
  core.List<core.String> numberOfItems;

  /// A list of postal group names. The last value can be "all other locations".
  /// Example: ["zone 1", "zone 2", "all other locations"]. The referred postal
  /// code groups must match the delivery country of the service. Must be
  /// non-empty. Can only be set if all other fields are not set.
  core.List<core.String> postalCodeGroupNames;

  /// A list of inclusive order price upper bounds. The last price's value can
  /// be "infinity". For example [{"value": "10", "currency": "USD"}, {"value":
  /// "500", "currency": "USD"}, {"value": "infinity", "currency": "USD"}]
  /// represents the headers "<= $10", " $500". All prices within a service must
  /// have the same currency. Must be non-empty. Can only be set if all other
  /// fields are not set.
  core.List<Price> prices;

  /// A list of inclusive order weight upper bounds. The last weight's value can
  /// be "infinity". For example [{"value": "10", "unit": "kg"}, {"value": "50",
  /// "unit": "kg"}, {"value": "infinity", "unit": "kg"}] represents the headers
  /// "<= 10kg", " 50kg". All weights within a service must have the same unit.
  /// Must be non-empty. Can only be set if all other fields are not set.
  core.List<Weight> weights;

  Headers();

  Headers.fromJson(core.Map _json) {
    if (_json.containsKey("locations")) {
      locations = (_json["locations"] as core.List)
          .map<LocationIdSet>((value) => new LocationIdSet.fromJson(value))
          .toList();
    }
    if (_json.containsKey("numberOfItems")) {
      numberOfItems = (_json["numberOfItems"] as core.List).cast<core.String>();
    }
    if (_json.containsKey("postalCodeGroupNames")) {
      postalCodeGroupNames =
          (_json["postalCodeGroupNames"] as core.List).cast<core.String>();
    }
    if (_json.containsKey("prices")) {
      prices = (_json["prices"] as core.List)
          .map<Price>((value) => new Price.fromJson(value))
          .toList();
    }
    if (_json.containsKey("weights")) {
      weights = (_json["weights"] as core.List)
          .map<Weight>((value) => new Weight.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (locations != null) {
      _json["locations"] = locations.map((value) => (value).toJson()).toList();
    }
    if (numberOfItems != null) {
      _json["numberOfItems"] = numberOfItems;
    }
    if (postalCodeGroupNames != null) {
      _json["postalCodeGroupNames"] = postalCodeGroupNames;
    }
    if (prices != null) {
      _json["prices"] = prices.map((value) => (value).toJson()).toList();
    }
    if (weights != null) {
      _json["weights"] = weights.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class HolidayCutoff {
  /// Date of the order deadline, in ISO 8601 format. E.g. "2016-11-29" for 29th
  /// November 2016. Required.
  core.String deadlineDate;

  /// Hour of the day on the deadline date until which the order has to be
  /// placed to qualify for the delivery guarantee. Possible values are: 0
  /// (midnight), 1, ..., 12 (noon), 13, ..., 23. Required.
  core.int deadlineHour;

  /// Timezone identifier for the deadline hour. A list of identifiers can be
  /// found in  the AdWords API documentation. E.g. "Europe/Zurich". Required.
  core.String deadlineTimezone;

  /// Unique identifier for the holiday. Required.
  core.String holidayId;

  /// Date on which the deadline will become visible to consumers in ISO 8601
  /// format. E.g. "2016-10-31" for 31st October 2016. Required.
  core.String visibleFromDate;

  HolidayCutoff();

  HolidayCutoff.fromJson(core.Map _json) {
    if (_json.containsKey("deadlineDate")) {
      deadlineDate = _json["deadlineDate"];
    }
    if (_json.containsKey("deadlineHour")) {
      deadlineHour = _json["deadlineHour"];
    }
    if (_json.containsKey("deadlineTimezone")) {
      deadlineTimezone = _json["deadlineTimezone"];
    }
    if (_json.containsKey("holidayId")) {
      holidayId = _json["holidayId"];
    }
    if (_json.containsKey("visibleFromDate")) {
      visibleFromDate = _json["visibleFromDate"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (deadlineDate != null) {
      _json["deadlineDate"] = deadlineDate;
    }
    if (deadlineHour != null) {
      _json["deadlineHour"] = deadlineHour;
    }
    if (deadlineTimezone != null) {
      _json["deadlineTimezone"] = deadlineTimezone;
    }
    if (holidayId != null) {
      _json["holidayId"] = holidayId;
    }
    if (visibleFromDate != null) {
      _json["visibleFromDate"] = visibleFromDate;
    }
    return _json;
  }
}

class HolidaysHoliday {
  /// The CLDR territory code of the country in which the holiday is available.
  /// E.g. "US", "DE", "GB". A holiday cutoff can only be configured in a
  /// shipping settings service with matching delivery country. Always present.
  core.String countryCode;

  /// Date of the holiday, in ISO 8601 format. E.g. "2016-12-25" for Christmas
  /// 2016. Always present.
  core.String date;

  /// Date on which the order has to arrive at the customer's, in ISO 8601
  /// format. E.g. "2016-12-24" for 24th December 2016. Always present.
  core.String deliveryGuaranteeDate;

  /// Hour of the day in the delivery location's timezone on the guaranteed
  /// delivery date by which the order has to arrive at the customer's. Possible
  /// values are: 0 (midnight), 1, ..., 12 (noon), 13, ..., 23. Always present.
  core.String deliveryGuaranteeHour;

  /// Unique identifier for the holiday to be used when configuring holiday
  /// cutoffs. Always present.
  core.String id;

  /// The holiday type. Always present.
  core.String type;

  HolidaysHoliday();

  HolidaysHoliday.fromJson(core.Map _json) {
    if (_json.containsKey("countryCode")) {
      countryCode = _json["countryCode"];
    }
    if (_json.containsKey("date")) {
      date = _json["date"];
    }
    if (_json.containsKey("deliveryGuaranteeDate")) {
      deliveryGuaranteeDate = _json["deliveryGuaranteeDate"];
    }
    if (_json.containsKey("deliveryGuaranteeHour")) {
      deliveryGuaranteeHour = _json["deliveryGuaranteeHour"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (countryCode != null) {
      _json["countryCode"] = countryCode;
    }
    if (date != null) {
      _json["date"] = date;
    }
    if (deliveryGuaranteeDate != null) {
      _json["deliveryGuaranteeDate"] = deliveryGuaranteeDate;
    }
    if (deliveryGuaranteeHour != null) {
      _json["deliveryGuaranteeHour"] = deliveryGuaranteeHour;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class Installment {
  /// The amount the buyer has to pay per month.
  Price amount;

  /// The number of installments the buyer has to pay.
  core.String months;

  Installment();

  Installment.fromJson(core.Map _json) {
    if (_json.containsKey("amount")) {
      amount = new Price.fromJson(_json["amount"]);
    }
    if (_json.containsKey("months")) {
      months = _json["months"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (amount != null) {
      _json["amount"] = (amount).toJson();
    }
    if (months != null) {
      _json["months"] = months;
    }
    return _json;
  }
}

class InvoiceSummary {
  /// Summary of the total amounts of the additional charges.
  core.List<InvoiceSummaryAdditionalChargeSummary> additionalChargeSummaries;

  /// [required] Customer balance on this invoice. A negative amount means the
  /// customer is paying, a positive one means the customer is receiving money.
  /// Note: the sum of merchant_balance, customer_balance and google_balance
  /// must always be zero.
  ///
  /// Furthermore the absolute value of this amount is expected to be equal to
  /// the sum of product amount and additional charges, minus promotions.
  Amount customerBalance;

  /// [required] Google balance on this invoice. A negative amount means Google
  /// is paying, a positive one means Google is receiving money. Note: the sum
  /// of merchant_balance, customer_balance and google_balance must always be
  /// zero.
  Amount googleBalance;

  /// [required] Merchant balance on this invoice. A negative amount means the
  /// merchant is paying, a positive one means the merchant is receiving money.
  /// Note: the sum of merchant_balance, customer_balance and google_balance
  /// must always be zero.
  Amount merchantBalance;

  /// [required] Total price for the product.
  Amount productTotal;

  /// Summary for each promotion.
  core.List<Promotion> promotionSummaries;

  InvoiceSummary();

  InvoiceSummary.fromJson(core.Map _json) {
    if (_json.containsKey("additionalChargeSummaries")) {
      additionalChargeSummaries =
          (_json["additionalChargeSummaries"] as core.List)
              .map<InvoiceSummaryAdditionalChargeSummary>((value) =>
                  new InvoiceSummaryAdditionalChargeSummary.fromJson(value))
              .toList();
    }
    if (_json.containsKey("customerBalance")) {
      customerBalance = new Amount.fromJson(_json["customerBalance"]);
    }
    if (_json.containsKey("googleBalance")) {
      googleBalance = new Amount.fromJson(_json["googleBalance"]);
    }
    if (_json.containsKey("merchantBalance")) {
      merchantBalance = new Amount.fromJson(_json["merchantBalance"]);
    }
    if (_json.containsKey("productTotal")) {
      productTotal = new Amount.fromJson(_json["productTotal"]);
    }
    if (_json.containsKey("promotionSummaries")) {
      promotionSummaries = (_json["promotionSummaries"] as core.List)
          .map<Promotion>((value) => new Promotion.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (additionalChargeSummaries != null) {
      _json["additionalChargeSummaries"] =
          additionalChargeSummaries.map((value) => (value).toJson()).toList();
    }
    if (customerBalance != null) {
      _json["customerBalance"] = (customerBalance).toJson();
    }
    if (googleBalance != null) {
      _json["googleBalance"] = (googleBalance).toJson();
    }
    if (merchantBalance != null) {
      _json["merchantBalance"] = (merchantBalance).toJson();
    }
    if (productTotal != null) {
      _json["productTotal"] = (productTotal).toJson();
    }
    if (promotionSummaries != null) {
      _json["promotionSummaries"] =
          promotionSummaries.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class InvoiceSummaryAdditionalChargeSummary {
  /// [required] Total additional charge for this type.
  Amount totalAmount;

  /// [required] Type of the additional charge.
  core.String type;

  InvoiceSummaryAdditionalChargeSummary();

  InvoiceSummaryAdditionalChargeSummary.fromJson(core.Map _json) {
    if (_json.containsKey("totalAmount")) {
      totalAmount = new Amount.fromJson(_json["totalAmount"]);
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (totalAmount != null) {
      _json["totalAmount"] = (totalAmount).toJson();
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class LiaAboutPageSettings {
  /// The status of the verification process for the About page.
  core.String status;

  /// The URL for the About page.
  core.String url;

  LiaAboutPageSettings();

  LiaAboutPageSettings.fromJson(core.Map _json) {
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (status != null) {
      _json["status"] = status;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

class LiaCountrySettings {
  /// The settings for the About page.
  LiaAboutPageSettings about;

  /// CLDR country code (e.g. "US").
  core.String country;

  /// The status of the "Merchant hosted local storefront" feature.
  core.bool hostedLocalStorefrontActive;

  /// LIA inventory verification settings.
  LiaInventorySettings inventory;

  /// LIA "On Display To Order" settings.
  LiaOnDisplayToOrderSettings onDisplayToOrder;

  /// The POS data provider linked with this country.
  LiaPosDataProvider posDataProvider;

  /// The status of the "Store pickup" feature.
  core.bool storePickupActive;

  LiaCountrySettings();

  LiaCountrySettings.fromJson(core.Map _json) {
    if (_json.containsKey("about")) {
      about = new LiaAboutPageSettings.fromJson(_json["about"]);
    }
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("hostedLocalStorefrontActive")) {
      hostedLocalStorefrontActive = _json["hostedLocalStorefrontActive"];
    }
    if (_json.containsKey("inventory")) {
      inventory = new LiaInventorySettings.fromJson(_json["inventory"]);
    }
    if (_json.containsKey("onDisplayToOrder")) {
      onDisplayToOrder =
          new LiaOnDisplayToOrderSettings.fromJson(_json["onDisplayToOrder"]);
    }
    if (_json.containsKey("posDataProvider")) {
      posDataProvider =
          new LiaPosDataProvider.fromJson(_json["posDataProvider"]);
    }
    if (_json.containsKey("storePickupActive")) {
      storePickupActive = _json["storePickupActive"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (about != null) {
      _json["about"] = (about).toJson();
    }
    if (country != null) {
      _json["country"] = country;
    }
    if (hostedLocalStorefrontActive != null) {
      _json["hostedLocalStorefrontActive"] = hostedLocalStorefrontActive;
    }
    if (inventory != null) {
      _json["inventory"] = (inventory).toJson();
    }
    if (onDisplayToOrder != null) {
      _json["onDisplayToOrder"] = (onDisplayToOrder).toJson();
    }
    if (posDataProvider != null) {
      _json["posDataProvider"] = (posDataProvider).toJson();
    }
    if (storePickupActive != null) {
      _json["storePickupActive"] = storePickupActive;
    }
    return _json;
  }
}

class LiaInventorySettings {
  /// The email of the contact for the inventory verification process.
  core.String inventoryVerificationContactEmail;

  /// The name of the contact for the inventory verification process.
  core.String inventoryVerificationContactName;

  /// The status of the verification contact.
  core.String inventoryVerificationContactStatus;

  /// The status of the inventory verification process.
  core.String status;

  LiaInventorySettings();

  LiaInventorySettings.fromJson(core.Map _json) {
    if (_json.containsKey("inventoryVerificationContactEmail")) {
      inventoryVerificationContactEmail =
          _json["inventoryVerificationContactEmail"];
    }
    if (_json.containsKey("inventoryVerificationContactName")) {
      inventoryVerificationContactName =
          _json["inventoryVerificationContactName"];
    }
    if (_json.containsKey("inventoryVerificationContactStatus")) {
      inventoryVerificationContactStatus =
          _json["inventoryVerificationContactStatus"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (inventoryVerificationContactEmail != null) {
      _json["inventoryVerificationContactEmail"] =
          inventoryVerificationContactEmail;
    }
    if (inventoryVerificationContactName != null) {
      _json["inventoryVerificationContactName"] =
          inventoryVerificationContactName;
    }
    if (inventoryVerificationContactStatus != null) {
      _json["inventoryVerificationContactStatus"] =
          inventoryVerificationContactStatus;
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

class LiaOnDisplayToOrderSettings {
  /// Shipping cost and policy URL.
  core.String shippingCostPolicyUrl;

  /// The status of the ?On display to order? feature.
  core.String status;

  LiaOnDisplayToOrderSettings();

  LiaOnDisplayToOrderSettings.fromJson(core.Map _json) {
    if (_json.containsKey("shippingCostPolicyUrl")) {
      shippingCostPolicyUrl = _json["shippingCostPolicyUrl"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (shippingCostPolicyUrl != null) {
      _json["shippingCostPolicyUrl"] = shippingCostPolicyUrl;
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

class LiaPosDataProvider {
  /// The ID of the POS data provider.
  core.String posDataProviderId;

  /// The account ID by which this merchant is known to the POS data provider.
  core.String posExternalAccountId;

  LiaPosDataProvider();

  LiaPosDataProvider.fromJson(core.Map _json) {
    if (_json.containsKey("posDataProviderId")) {
      posDataProviderId = _json["posDataProviderId"];
    }
    if (_json.containsKey("posExternalAccountId")) {
      posExternalAccountId = _json["posExternalAccountId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (posDataProviderId != null) {
      _json["posDataProviderId"] = posDataProviderId;
    }
    if (posExternalAccountId != null) {
      _json["posExternalAccountId"] = posExternalAccountId;
    }
    return _json;
  }
}

/// Local Inventory ads (LIA) settings. All methods except listposdataproviders
/// require the admin role.
class LiaSettings {
  /// The ID of the account to which these LIA settings belong. Ignored upon
  /// update, always present in get request responses.
  core.String accountId;

  /// The LIA settings for each country.
  core.List<LiaCountrySettings> countrySettings;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#liaSettings".
  core.String kind;

  LiaSettings();

  LiaSettings.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("countrySettings")) {
      countrySettings = (_json["countrySettings"] as core.List)
          .map<LiaCountrySettings>(
              (value) => new LiaCountrySettings.fromJson(value))
          .toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (countrySettings != null) {
      _json["countrySettings"] =
          countrySettings.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class LiasettingsCustomBatchRequest {
  /// The request entries to be processed in the batch.
  core.List<LiasettingsCustomBatchRequestEntry> entries;

  LiasettingsCustomBatchRequest();

  LiasettingsCustomBatchRequest.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = (_json["entries"] as core.List)
          .map<LiasettingsCustomBatchRequestEntry>(
              (value) => new LiasettingsCustomBatchRequestEntry.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class LiasettingsCustomBatchRequestEntry {
  /// The ID of the account for which to get/update account shipping settings.
  core.String accountId;

  /// An entry ID, unique within the batch request.
  core.int batchId;

  /// Inventory validation contact email. Required only for
  /// SetInventoryValidationContact.
  core.String contactEmail;

  /// Inventory validation contact name. Required only for
  /// SetInventoryValidationContact.
  core.String contactName;

  /// The country code. Required only for RequestInventoryVerification.
  core.String country;

  /// The GMB account. Required only for RequestGmbAccess.
  core.String gmbEmail;

  /// The account Lia settings to update. Only defined if the method is update.
  LiaSettings liaSettings;

  /// The ID of the managing account.
  core.String merchantId;
  core.String method;

  /// The ID of POS data provider. Required only for SetPosProvider.
  core.String posDataProviderId;

  /// The account ID by which this merchant is known to the POS provider.
  core.String posExternalAccountId;

  LiasettingsCustomBatchRequestEntry();

  LiasettingsCustomBatchRequestEntry.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("contactEmail")) {
      contactEmail = _json["contactEmail"];
    }
    if (_json.containsKey("contactName")) {
      contactName = _json["contactName"];
    }
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("gmbEmail")) {
      gmbEmail = _json["gmbEmail"];
    }
    if (_json.containsKey("liaSettings")) {
      liaSettings = new LiaSettings.fromJson(_json["liaSettings"]);
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
    if (_json.containsKey("posDataProviderId")) {
      posDataProviderId = _json["posDataProviderId"];
    }
    if (_json.containsKey("posExternalAccountId")) {
      posExternalAccountId = _json["posExternalAccountId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (contactEmail != null) {
      _json["contactEmail"] = contactEmail;
    }
    if (contactName != null) {
      _json["contactName"] = contactName;
    }
    if (country != null) {
      _json["country"] = country;
    }
    if (gmbEmail != null) {
      _json["gmbEmail"] = gmbEmail;
    }
    if (liaSettings != null) {
      _json["liaSettings"] = (liaSettings).toJson();
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (method != null) {
      _json["method"] = method;
    }
    if (posDataProviderId != null) {
      _json["posDataProviderId"] = posDataProviderId;
    }
    if (posExternalAccountId != null) {
      _json["posExternalAccountId"] = posExternalAccountId;
    }
    return _json;
  }
}

class LiasettingsCustomBatchResponse {
  /// The result of the execution of the batch requests.
  core.List<LiasettingsCustomBatchResponseEntry> entries;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#liasettingsCustomBatchResponse".
  core.String kind;

  LiasettingsCustomBatchResponse();

  LiasettingsCustomBatchResponse.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = (_json["entries"] as core.List)
          .map<LiasettingsCustomBatchResponseEntry>((value) =>
              new LiasettingsCustomBatchResponseEntry.fromJson(value))
          .toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class LiasettingsCustomBatchResponseEntry {
  /// The ID of the request entry to which this entry responds.
  core.int batchId;

  /// A list of errors defined if, and only if, the request failed.
  Errors errors;

  /// The the list of accessible GMB accounts.
  GmbAccounts gmbAccounts;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#liasettingsCustomBatchResponseEntry".
  core.String kind;

  /// The retrieved or updated Lia settings.
  LiaSettings liaSettings;

  /// The list of POS data providers.
  core.List<PosDataProviders> posDataProviders;

  LiasettingsCustomBatchResponseEntry();

  LiasettingsCustomBatchResponseEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("errors")) {
      errors = new Errors.fromJson(_json["errors"]);
    }
    if (_json.containsKey("gmbAccounts")) {
      gmbAccounts = new GmbAccounts.fromJson(_json["gmbAccounts"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("liaSettings")) {
      liaSettings = new LiaSettings.fromJson(_json["liaSettings"]);
    }
    if (_json.containsKey("posDataProviders")) {
      posDataProviders = (_json["posDataProviders"] as core.List)
          .map<PosDataProviders>(
              (value) => new PosDataProviders.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (errors != null) {
      _json["errors"] = (errors).toJson();
    }
    if (gmbAccounts != null) {
      _json["gmbAccounts"] = (gmbAccounts).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (liaSettings != null) {
      _json["liaSettings"] = (liaSettings).toJson();
    }
    if (posDataProviders != null) {
      _json["posDataProviders"] =
          posDataProviders.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class LiasettingsGetAccessibleGmbAccountsResponse {
  /// The ID of the account.
  core.String accountId;

  /// A list of GMB accounts which are available to the merchant.
  core.List<GmbAccountsGmbAccount> gmbAccounts;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#liasettingsGetAccessibleGmbAccountsResponse".
  core.String kind;

  LiasettingsGetAccessibleGmbAccountsResponse();

  LiasettingsGetAccessibleGmbAccountsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("gmbAccounts")) {
      gmbAccounts = (_json["gmbAccounts"] as core.List)
          .map<GmbAccountsGmbAccount>(
              (value) => new GmbAccountsGmbAccount.fromJson(value))
          .toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (gmbAccounts != null) {
      _json["gmbAccounts"] =
          gmbAccounts.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class LiasettingsListPosDataProvidersResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#liasettingsListPosDataProvidersResponse".
  core.String kind;

  /// The list of POS data providers for each eligible country
  core.List<PosDataProviders> posDataProviders;

  LiasettingsListPosDataProvidersResponse();

  LiasettingsListPosDataProvidersResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("posDataProviders")) {
      posDataProviders = (_json["posDataProviders"] as core.List)
          .map<PosDataProviders>(
              (value) => new PosDataProviders.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (posDataProviders != null) {
      _json["posDataProviders"] =
          posDataProviders.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class LiasettingsListResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#liasettingsListResponse".
  core.String kind;

  /// The token for the retrieval of the next page of LIA settings.
  core.String nextPageToken;
  core.List<LiaSettings> resources;

  LiasettingsListResponse();

  LiasettingsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resources")) {
      resources = (_json["resources"] as core.List)
          .map<LiaSettings>((value) => new LiaSettings.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resources != null) {
      _json["resources"] = resources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class LiasettingsRequestGmbAccessResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#liasettingsRequestGmbAccessResponse".
  core.String kind;

  LiasettingsRequestGmbAccessResponse();

  LiasettingsRequestGmbAccessResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class LiasettingsRequestInventoryVerificationResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#liasettingsRequestInventoryVerificationResponse".
  core.String kind;

  LiasettingsRequestInventoryVerificationResponse();

  LiasettingsRequestInventoryVerificationResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class LiasettingsSetInventoryVerificationContactResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#liasettingsSetInventoryVerificationContactResponse".
  core.String kind;

  LiasettingsSetInventoryVerificationContactResponse();

  LiasettingsSetInventoryVerificationContactResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class LiasettingsSetPosDataProviderResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#liasettingsSetPosDataProviderResponse".
  core.String kind;

  LiasettingsSetPosDataProviderResponse();

  LiasettingsSetPosDataProviderResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class LocationIdSet {
  /// A non-empty list of location IDs. They must all be of the same location
  /// type (e.g., state).
  core.List<core.String> locationIds;

  LocationIdSet();

  LocationIdSet.fromJson(core.Map _json) {
    if (_json.containsKey("locationIds")) {
      locationIds = (_json["locationIds"] as core.List).cast<core.String>();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (locationIds != null) {
      _json["locationIds"] = locationIds;
    }
    return _json;
  }
}

class LoyaltyPoints {
  /// Name of loyalty points program. It is recommended to limit the name to 12
  /// full-width characters or 24 Roman characters.
  core.String name;

  /// The retailer's loyalty points in absolute value.
  core.String pointsValue;

  /// The ratio of a point when converted to currency. Google assumes currency
  /// based on Merchant Center settings. If ratio is left out, it defaults to
  /// 1.0.
  core.double ratio;

  LoyaltyPoints();

  LoyaltyPoints.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("pointsValue")) {
      pointsValue = _json["pointsValue"];
    }
    if (_json.containsKey("ratio")) {
      ratio = _json["ratio"].toDouble();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (name != null) {
      _json["name"] = name;
    }
    if (pointsValue != null) {
      _json["pointsValue"] = pointsValue;
    }
    if (ratio != null) {
      _json["ratio"] = ratio;
    }
    return _json;
  }
}

class MerchantOrderReturn {
  core.String creationDate;
  core.String merchantOrderId;
  core.String orderId;
  core.String orderReturnId;
  core.List<MerchantOrderReturnItem> returnItems;
  core.List<ReturnShipment> returnShipments;

  MerchantOrderReturn();

  MerchantOrderReturn.fromJson(core.Map _json) {
    if (_json.containsKey("creationDate")) {
      creationDate = _json["creationDate"];
    }
    if (_json.containsKey("merchantOrderId")) {
      merchantOrderId = _json["merchantOrderId"];
    }
    if (_json.containsKey("orderId")) {
      orderId = _json["orderId"];
    }
    if (_json.containsKey("orderReturnId")) {
      orderReturnId = _json["orderReturnId"];
    }
    if (_json.containsKey("returnItems")) {
      returnItems = (_json["returnItems"] as core.List)
          .map<MerchantOrderReturnItem>(
              (value) => new MerchantOrderReturnItem.fromJson(value))
          .toList();
    }
    if (_json.containsKey("returnShipments")) {
      returnShipments = (_json["returnShipments"] as core.List)
          .map<ReturnShipment>((value) => new ReturnShipment.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (creationDate != null) {
      _json["creationDate"] = creationDate;
    }
    if (merchantOrderId != null) {
      _json["merchantOrderId"] = merchantOrderId;
    }
    if (orderId != null) {
      _json["orderId"] = orderId;
    }
    if (orderReturnId != null) {
      _json["orderReturnId"] = orderReturnId;
    }
    if (returnItems != null) {
      _json["returnItems"] =
          returnItems.map((value) => (value).toJson()).toList();
    }
    if (returnShipments != null) {
      _json["returnShipments"] =
          returnShipments.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class MerchantOrderReturnItem {
  CustomerReturnReason customerReturnReason;
  core.String itemId;
  RefundReason merchantReturnReason;
  OrderLineItemProduct product;
  core.List<core.String> returnShipmentIds;
  core.String state;

  MerchantOrderReturnItem();

  MerchantOrderReturnItem.fromJson(core.Map _json) {
    if (_json.containsKey("customerReturnReason")) {
      customerReturnReason =
          new CustomerReturnReason.fromJson(_json["customerReturnReason"]);
    }
    if (_json.containsKey("itemId")) {
      itemId = _json["itemId"];
    }
    if (_json.containsKey("merchantReturnReason")) {
      merchantReturnReason =
          new RefundReason.fromJson(_json["merchantReturnReason"]);
    }
    if (_json.containsKey("product")) {
      product = new OrderLineItemProduct.fromJson(_json["product"]);
    }
    if (_json.containsKey("returnShipmentIds")) {
      returnShipmentIds =
          (_json["returnShipmentIds"] as core.List).cast<core.String>();
    }
    if (_json.containsKey("state")) {
      state = _json["state"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (customerReturnReason != null) {
      _json["customerReturnReason"] = (customerReturnReason).toJson();
    }
    if (itemId != null) {
      _json["itemId"] = itemId;
    }
    if (merchantReturnReason != null) {
      _json["merchantReturnReason"] = (merchantReturnReason).toJson();
    }
    if (product != null) {
      _json["product"] = (product).toJson();
    }
    if (returnShipmentIds != null) {
      _json["returnShipmentIds"] = returnShipmentIds;
    }
    if (state != null) {
      _json["state"] = state;
    }
    return _json;
  }
}

/// Order. All methods require the order manager role.
class Order {
  /// Whether the order was acknowledged.
  core.bool acknowledged;

  /// The billing address.
  OrderAddress billingAddress;

  /// The channel type of the order: "purchaseOnGoogle" or "googleExpress".
  core.String channelType;

  /// The details of the customer who placed the order.
  OrderCustomer customer;

  /// The details for the delivery.
  OrderDeliveryDetails deliveryDetails;

  /// The REST id of the order. Globally unique.
  core.String id;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#order".
  core.String kind;

  /// Line items that are ordered.
  core.List<OrderLineItem> lineItems;
  core.String merchantId;

  /// Merchant-provided id of the order.
  core.String merchantOrderId;

  /// The net amount for the order. For example, if an order was originally for
  /// a grand total of $100 and a refund was issued for $20, the net amount will
  /// be $80.
  Price netAmount;

  /// The status of the payment.
  core.String paymentStatus;

  /// The date when the order was placed, in ISO 8601 format.
  core.String placedDate;

  /// Promotions associated with the order.
  core.List<OrderPromotion> promotions;

  /// Refunds for the order.
  core.List<OrderRefund> refunds;

  /// Shipments of the order.
  core.List<OrderShipment> shipments;

  /// The total cost of shipping for all items.
  Price shippingCost;

  /// The tax for the total shipping cost.
  Price shippingCostTax;

  /// The requested shipping option.
  core.String shippingOption;

  /// The status of the order.
  core.String status;

  /// The party responsible for collecting and remitting taxes.
  core.String taxCollector;

  Order();

  Order.fromJson(core.Map _json) {
    if (_json.containsKey("acknowledged")) {
      acknowledged = _json["acknowledged"];
    }
    if (_json.containsKey("billingAddress")) {
      billingAddress = new OrderAddress.fromJson(_json["billingAddress"]);
    }
    if (_json.containsKey("channelType")) {
      channelType = _json["channelType"];
    }
    if (_json.containsKey("customer")) {
      customer = new OrderCustomer.fromJson(_json["customer"]);
    }
    if (_json.containsKey("deliveryDetails")) {
      deliveryDetails =
          new OrderDeliveryDetails.fromJson(_json["deliveryDetails"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lineItems")) {
      lineItems = (_json["lineItems"] as core.List)
          .map<OrderLineItem>((value) => new OrderLineItem.fromJson(value))
          .toList();
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("merchantOrderId")) {
      merchantOrderId = _json["merchantOrderId"];
    }
    if (_json.containsKey("netAmount")) {
      netAmount = new Price.fromJson(_json["netAmount"]);
    }
    if (_json.containsKey("paymentStatus")) {
      paymentStatus = _json["paymentStatus"];
    }
    if (_json.containsKey("placedDate")) {
      placedDate = _json["placedDate"];
    }
    if (_json.containsKey("promotions")) {
      promotions = (_json["promotions"] as core.List)
          .map<OrderPromotion>((value) => new OrderPromotion.fromJson(value))
          .toList();
    }
    if (_json.containsKey("refunds")) {
      refunds = (_json["refunds"] as core.List)
          .map<OrderRefund>((value) => new OrderRefund.fromJson(value))
          .toList();
    }
    if (_json.containsKey("shipments")) {
      shipments = (_json["shipments"] as core.List)
          .map<OrderShipment>((value) => new OrderShipment.fromJson(value))
          .toList();
    }
    if (_json.containsKey("shippingCost")) {
      shippingCost = new Price.fromJson(_json["shippingCost"]);
    }
    if (_json.containsKey("shippingCostTax")) {
      shippingCostTax = new Price.fromJson(_json["shippingCostTax"]);
    }
    if (_json.containsKey("shippingOption")) {
      shippingOption = _json["shippingOption"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("taxCollector")) {
      taxCollector = _json["taxCollector"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (acknowledged != null) {
      _json["acknowledged"] = acknowledged;
    }
    if (billingAddress != null) {
      _json["billingAddress"] = (billingAddress).toJson();
    }
    if (channelType != null) {
      _json["channelType"] = channelType;
    }
    if (customer != null) {
      _json["customer"] = (customer).toJson();
    }
    if (deliveryDetails != null) {
      _json["deliveryDetails"] = (deliveryDetails).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lineItems != null) {
      _json["lineItems"] = lineItems.map((value) => (value).toJson()).toList();
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (merchantOrderId != null) {
      _json["merchantOrderId"] = merchantOrderId;
    }
    if (netAmount != null) {
      _json["netAmount"] = (netAmount).toJson();
    }
    if (paymentStatus != null) {
      _json["paymentStatus"] = paymentStatus;
    }
    if (placedDate != null) {
      _json["placedDate"] = placedDate;
    }
    if (promotions != null) {
      _json["promotions"] =
          promotions.map((value) => (value).toJson()).toList();
    }
    if (refunds != null) {
      _json["refunds"] = refunds.map((value) => (value).toJson()).toList();
    }
    if (shipments != null) {
      _json["shipments"] = shipments.map((value) => (value).toJson()).toList();
    }
    if (shippingCost != null) {
      _json["shippingCost"] = (shippingCost).toJson();
    }
    if (shippingCostTax != null) {
      _json["shippingCostTax"] = (shippingCostTax).toJson();
    }
    if (shippingOption != null) {
      _json["shippingOption"] = shippingOption;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (taxCollector != null) {
      _json["taxCollector"] = taxCollector;
    }
    return _json;
  }
}

class OrderAddress {
  /// CLDR country code (e.g. "US").
  core.String country;

  /// Strings representing the lines of the printed label for mailing the order,
  /// for example:
  /// John Smith
  /// 1600 Amphitheatre Parkway
  /// Mountain View, CA, 94043
  /// United States
  core.List<core.String> fullAddress;

  /// Whether the address is a post office box.
  core.bool isPostOfficeBox;

  /// City, town or commune. May also include dependent localities or
  /// sublocalities (e.g. neighborhoods or suburbs).
  core.String locality;

  /// Postal Code or ZIP (e.g. "94043").
  core.String postalCode;

  /// Name of the recipient.
  core.String recipientName;

  /// Top-level administrative subdivision of the country. For example, a state
  /// like California ("CA") or a province like Quebec ("QC").
  core.String region;

  /// Street-level part of the address.
  core.List<core.String> streetAddress;

  OrderAddress();

  OrderAddress.fromJson(core.Map _json) {
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("fullAddress")) {
      fullAddress = (_json["fullAddress"] as core.List).cast<core.String>();
    }
    if (_json.containsKey("isPostOfficeBox")) {
      isPostOfficeBox = _json["isPostOfficeBox"];
    }
    if (_json.containsKey("locality")) {
      locality = _json["locality"];
    }
    if (_json.containsKey("postalCode")) {
      postalCode = _json["postalCode"];
    }
    if (_json.containsKey("recipientName")) {
      recipientName = _json["recipientName"];
    }
    if (_json.containsKey("region")) {
      region = _json["region"];
    }
    if (_json.containsKey("streetAddress")) {
      streetAddress = (_json["streetAddress"] as core.List).cast<core.String>();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (country != null) {
      _json["country"] = country;
    }
    if (fullAddress != null) {
      _json["fullAddress"] = fullAddress;
    }
    if (isPostOfficeBox != null) {
      _json["isPostOfficeBox"] = isPostOfficeBox;
    }
    if (locality != null) {
      _json["locality"] = locality;
    }
    if (postalCode != null) {
      _json["postalCode"] = postalCode;
    }
    if (recipientName != null) {
      _json["recipientName"] = recipientName;
    }
    if (region != null) {
      _json["region"] = region;
    }
    if (streetAddress != null) {
      _json["streetAddress"] = streetAddress;
    }
    return _json;
  }
}

class OrderCancellation {
  /// The actor that created the cancellation.
  core.String actor;

  /// Date on which the cancellation has been created, in ISO 8601 format.
  core.String creationDate;

  /// The quantity that was canceled.
  core.int quantity;

  /// The reason for the cancellation. Orders that are cancelled with a
  /// noInventory reason will lead to the removal of the product from Shopping
  /// Actions until you make an update to that product. This will not affect
  /// your Shopping ads.
  core.String reason;

  /// The explanation of the reason.
  core.String reasonText;

  OrderCancellation();

  OrderCancellation.fromJson(core.Map _json) {
    if (_json.containsKey("actor")) {
      actor = _json["actor"];
    }
    if (_json.containsKey("creationDate")) {
      creationDate = _json["creationDate"];
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (actor != null) {
      _json["actor"] = actor;
    }
    if (creationDate != null) {
      _json["creationDate"] = creationDate;
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrderCustomer {
  /// Deprecated.
  core.String email;

  /// Full name of the customer.
  core.String fullName;

  /// Customer's marketing preferences.
  OrderCustomerMarketingRightsInfo marketingRightsInfo;

  OrderCustomer();

  OrderCustomer.fromJson(core.Map _json) {
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("fullName")) {
      fullName = _json["fullName"];
    }
    if (_json.containsKey("marketingRightsInfo")) {
      marketingRightsInfo = new OrderCustomerMarketingRightsInfo.fromJson(
          _json["marketingRightsInfo"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (email != null) {
      _json["email"] = email;
    }
    if (fullName != null) {
      _json["fullName"] = fullName;
    }
    if (marketingRightsInfo != null) {
      _json["marketingRightsInfo"] = (marketingRightsInfo).toJson();
    }
    return _json;
  }
}

class OrderCustomerMarketingRightsInfo {
  /// Last known user selection regarding marketing preferences. In certain
  /// cases this selection might not be known, so this field would be empty.
  core.String explicitMarketingPreference;

  /// Timestamp when last time marketing preference was updated. Could be empty,
  /// if user wasn't offered a selection yet.
  core.String lastUpdatedTimestamp;

  /// Email address that can be used for marketing purposes. This field is only
  /// filled when explicitMarketingPreference is equal to 'granted'.
  core.String marketingEmailAddress;

  OrderCustomerMarketingRightsInfo();

  OrderCustomerMarketingRightsInfo.fromJson(core.Map _json) {
    if (_json.containsKey("explicitMarketingPreference")) {
      explicitMarketingPreference = _json["explicitMarketingPreference"];
    }
    if (_json.containsKey("lastUpdatedTimestamp")) {
      lastUpdatedTimestamp = _json["lastUpdatedTimestamp"];
    }
    if (_json.containsKey("marketingEmailAddress")) {
      marketingEmailAddress = _json["marketingEmailAddress"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (explicitMarketingPreference != null) {
      _json["explicitMarketingPreference"] = explicitMarketingPreference;
    }
    if (lastUpdatedTimestamp != null) {
      _json["lastUpdatedTimestamp"] = lastUpdatedTimestamp;
    }
    if (marketingEmailAddress != null) {
      _json["marketingEmailAddress"] = marketingEmailAddress;
    }
    return _json;
  }
}

class OrderDeliveryDetails {
  /// The delivery address
  OrderAddress address;

  /// The phone number of the person receiving the delivery.
  core.String phoneNumber;

  OrderDeliveryDetails();

  OrderDeliveryDetails.fromJson(core.Map _json) {
    if (_json.containsKey("address")) {
      address = new OrderAddress.fromJson(_json["address"]);
    }
    if (_json.containsKey("phoneNumber")) {
      phoneNumber = _json["phoneNumber"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (address != null) {
      _json["address"] = (address).toJson();
    }
    if (phoneNumber != null) {
      _json["phoneNumber"] = phoneNumber;
    }
    return _json;
  }
}

class OrderLineItem {
  /// Annotations that are attached to the line item.
  core.List<OrderMerchantProvidedAnnotation> annotations;

  /// Cancellations of the line item.
  core.List<OrderCancellation> cancellations;

  /// The id of the line item.
  core.String id;

  /// Total price for the line item. For example, if two items for $10 are
  /// purchased, the total price will be $20.
  Price price;

  /// Product data as seen by customer from the time of the order placement.
  /// Note that certain attributes values (e.g. title or gtin) might be
  /// reformatted and no longer match values submitted via product feed.
  OrderLineItemProduct product;

  /// Number of items canceled.
  core.int quantityCanceled;

  /// Number of items delivered.
  core.int quantityDelivered;

  /// Number of items ordered.
  core.int quantityOrdered;

  /// Number of items pending.
  core.int quantityPending;

  /// Number of items returned.
  core.int quantityReturned;

  /// Number of items shipped.
  core.int quantityShipped;

  /// Details of the return policy for the line item.
  OrderLineItemReturnInfo returnInfo;

  /// Returns of the line item.
  core.List<OrderReturn> returns;

  /// Details of the requested shipping for the line item.
  OrderLineItemShippingDetails shippingDetails;

  /// Total tax amount for the line item. For example, if two items are
  /// purchased, and each have a cost tax of $2, the total tax amount will be
  /// $4.
  Price tax;

  OrderLineItem();

  OrderLineItem.fromJson(core.Map _json) {
    if (_json.containsKey("annotations")) {
      annotations = (_json["annotations"] as core.List)
          .map<OrderMerchantProvidedAnnotation>(
              (value) => new OrderMerchantProvidedAnnotation.fromJson(value))
          .toList();
    }
    if (_json.containsKey("cancellations")) {
      cancellations = (_json["cancellations"] as core.List)
          .map<OrderCancellation>(
              (value) => new OrderCancellation.fromJson(value))
          .toList();
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("price")) {
      price = new Price.fromJson(_json["price"]);
    }
    if (_json.containsKey("product")) {
      product = new OrderLineItemProduct.fromJson(_json["product"]);
    }
    if (_json.containsKey("quantityCanceled")) {
      quantityCanceled = _json["quantityCanceled"];
    }
    if (_json.containsKey("quantityDelivered")) {
      quantityDelivered = _json["quantityDelivered"];
    }
    if (_json.containsKey("quantityOrdered")) {
      quantityOrdered = _json["quantityOrdered"];
    }
    if (_json.containsKey("quantityPending")) {
      quantityPending = _json["quantityPending"];
    }
    if (_json.containsKey("quantityReturned")) {
      quantityReturned = _json["quantityReturned"];
    }
    if (_json.containsKey("quantityShipped")) {
      quantityShipped = _json["quantityShipped"];
    }
    if (_json.containsKey("returnInfo")) {
      returnInfo = new OrderLineItemReturnInfo.fromJson(_json["returnInfo"]);
    }
    if (_json.containsKey("returns")) {
      returns = (_json["returns"] as core.List)
          .map<OrderReturn>((value) => new OrderReturn.fromJson(value))
          .toList();
    }
    if (_json.containsKey("shippingDetails")) {
      shippingDetails =
          new OrderLineItemShippingDetails.fromJson(_json["shippingDetails"]);
    }
    if (_json.containsKey("tax")) {
      tax = new Price.fromJson(_json["tax"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (annotations != null) {
      _json["annotations"] =
          annotations.map((value) => (value).toJson()).toList();
    }
    if (cancellations != null) {
      _json["cancellations"] =
          cancellations.map((value) => (value).toJson()).toList();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (price != null) {
      _json["price"] = (price).toJson();
    }
    if (product != null) {
      _json["product"] = (product).toJson();
    }
    if (quantityCanceled != null) {
      _json["quantityCanceled"] = quantityCanceled;
    }
    if (quantityDelivered != null) {
      _json["quantityDelivered"] = quantityDelivered;
    }
    if (quantityOrdered != null) {
      _json["quantityOrdered"] = quantityOrdered;
    }
    if (quantityPending != null) {
      _json["quantityPending"] = quantityPending;
    }
    if (quantityReturned != null) {
      _json["quantityReturned"] = quantityReturned;
    }
    if (quantityShipped != null) {
      _json["quantityShipped"] = quantityShipped;
    }
    if (returnInfo != null) {
      _json["returnInfo"] = (returnInfo).toJson();
    }
    if (returns != null) {
      _json["returns"] = returns.map((value) => (value).toJson()).toList();
    }
    if (shippingDetails != null) {
      _json["shippingDetails"] = (shippingDetails).toJson();
    }
    if (tax != null) {
      _json["tax"] = (tax).toJson();
    }
    return _json;
  }
}

class OrderLineItemProduct {
  /// Brand of the item.
  core.String brand;

  /// The item's channel (online or local).
  core.String channel;

  /// Condition or state of the item.
  core.String condition;

  /// The two-letter ISO 639-1 language code for the item.
  core.String contentLanguage;

  /// Associated fees at order creation time.
  core.List<OrderLineItemProductFee> fees;

  /// Global Trade Item Number (GTIN) of the item.
  core.String gtin;

  /// The REST id of the product.
  core.String id;

  /// URL of an image of the item.
  core.String imageLink;

  /// Shared identifier for all variants of the same product.
  core.String itemGroupId;

  /// Manufacturer Part Number (MPN) of the item.
  core.String mpn;

  /// An identifier of the item.
  core.String offerId;

  /// Price of the item.
  Price price;

  /// URL to the cached image shown to the user when order was placed.
  core.String shownImage;

  /// The CLDR territory code of the target country of the product.
  core.String targetCountry;

  /// The title of the product.
  core.String title;

  /// Variant attributes for the item. These are dimensions of the product, such
  /// as color, gender, material, pattern, and size. You can find a
  /// comprehensive list of variant attributes here.
  core.List<OrderLineItemProductVariantAttribute> variantAttributes;

  OrderLineItemProduct();

  OrderLineItemProduct.fromJson(core.Map _json) {
    if (_json.containsKey("brand")) {
      brand = _json["brand"];
    }
    if (_json.containsKey("channel")) {
      channel = _json["channel"];
    }
    if (_json.containsKey("condition")) {
      condition = _json["condition"];
    }
    if (_json.containsKey("contentLanguage")) {
      contentLanguage = _json["contentLanguage"];
    }
    if (_json.containsKey("fees")) {
      fees = (_json["fees"] as core.List)
          .map<OrderLineItemProductFee>(
              (value) => new OrderLineItemProductFee.fromJson(value))
          .toList();
    }
    if (_json.containsKey("gtin")) {
      gtin = _json["gtin"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("imageLink")) {
      imageLink = _json["imageLink"];
    }
    if (_json.containsKey("itemGroupId")) {
      itemGroupId = _json["itemGroupId"];
    }
    if (_json.containsKey("mpn")) {
      mpn = _json["mpn"];
    }
    if (_json.containsKey("offerId")) {
      offerId = _json["offerId"];
    }
    if (_json.containsKey("price")) {
      price = new Price.fromJson(_json["price"]);
    }
    if (_json.containsKey("shownImage")) {
      shownImage = _json["shownImage"];
    }
    if (_json.containsKey("targetCountry")) {
      targetCountry = _json["targetCountry"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("variantAttributes")) {
      variantAttributes = (_json["variantAttributes"] as core.List)
          .map<OrderLineItemProductVariantAttribute>((value) =>
              new OrderLineItemProductVariantAttribute.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (brand != null) {
      _json["brand"] = brand;
    }
    if (channel != null) {
      _json["channel"] = channel;
    }
    if (condition != null) {
      _json["condition"] = condition;
    }
    if (contentLanguage != null) {
      _json["contentLanguage"] = contentLanguage;
    }
    if (fees != null) {
      _json["fees"] = fees.map((value) => (value).toJson()).toList();
    }
    if (gtin != null) {
      _json["gtin"] = gtin;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (imageLink != null) {
      _json["imageLink"] = imageLink;
    }
    if (itemGroupId != null) {
      _json["itemGroupId"] = itemGroupId;
    }
    if (mpn != null) {
      _json["mpn"] = mpn;
    }
    if (offerId != null) {
      _json["offerId"] = offerId;
    }
    if (price != null) {
      _json["price"] = (price).toJson();
    }
    if (shownImage != null) {
      _json["shownImage"] = shownImage;
    }
    if (targetCountry != null) {
      _json["targetCountry"] = targetCountry;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (variantAttributes != null) {
      _json["variantAttributes"] =
          variantAttributes.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class OrderLineItemProductFee {
  /// Amount of the fee.
  Price amount;

  /// Name of the fee.
  core.String name;

  OrderLineItemProductFee();

  OrderLineItemProductFee.fromJson(core.Map _json) {
    if (_json.containsKey("amount")) {
      amount = new Price.fromJson(_json["amount"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (amount != null) {
      _json["amount"] = (amount).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

class OrderLineItemProductVariantAttribute {
  /// The dimension of the variant.
  core.String dimension;

  /// The value for the dimension.
  core.String value;

  OrderLineItemProductVariantAttribute();

  OrderLineItemProductVariantAttribute.fromJson(core.Map _json) {
    if (_json.containsKey("dimension")) {
      dimension = _json["dimension"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (dimension != null) {
      _json["dimension"] = dimension;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class OrderLineItemReturnInfo {
  /// How many days later the item can be returned.
  core.int daysToReturn;

  /// Whether the item is returnable.
  core.bool isReturnable;

  /// URL of the item return policy.
  core.String policyUrl;

  OrderLineItemReturnInfo();

  OrderLineItemReturnInfo.fromJson(core.Map _json) {
    if (_json.containsKey("daysToReturn")) {
      daysToReturn = _json["daysToReturn"];
    }
    if (_json.containsKey("isReturnable")) {
      isReturnable = _json["isReturnable"];
    }
    if (_json.containsKey("policyUrl")) {
      policyUrl = _json["policyUrl"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (daysToReturn != null) {
      _json["daysToReturn"] = daysToReturn;
    }
    if (isReturnable != null) {
      _json["isReturnable"] = isReturnable;
    }
    if (policyUrl != null) {
      _json["policyUrl"] = policyUrl;
    }
    return _json;
  }
}

class OrderLineItemShippingDetails {
  /// The delivery by date, in ISO 8601 format.
  core.String deliverByDate;

  /// Details of the shipping method.
  OrderLineItemShippingDetailsMethod method;

  /// The ship by date, in ISO 8601 format.
  core.String shipByDate;

  OrderLineItemShippingDetails();

  OrderLineItemShippingDetails.fromJson(core.Map _json) {
    if (_json.containsKey("deliverByDate")) {
      deliverByDate = _json["deliverByDate"];
    }
    if (_json.containsKey("method")) {
      method = new OrderLineItemShippingDetailsMethod.fromJson(_json["method"]);
    }
    if (_json.containsKey("shipByDate")) {
      shipByDate = _json["shipByDate"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (deliverByDate != null) {
      _json["deliverByDate"] = deliverByDate;
    }
    if (method != null) {
      _json["method"] = (method).toJson();
    }
    if (shipByDate != null) {
      _json["shipByDate"] = shipByDate;
    }
    return _json;
  }
}

class OrderLineItemShippingDetailsMethod {
  /// The carrier for the shipping. Optional. See shipments[].carrier for a list
  /// of acceptable values.
  core.String carrier;

  /// Maximum transit time.
  core.int maxDaysInTransit;

  /// The name of the shipping method.
  core.String methodName;

  /// Minimum transit time.
  core.int minDaysInTransit;

  OrderLineItemShippingDetailsMethod();

  OrderLineItemShippingDetailsMethod.fromJson(core.Map _json) {
    if (_json.containsKey("carrier")) {
      carrier = _json["carrier"];
    }
    if (_json.containsKey("maxDaysInTransit")) {
      maxDaysInTransit = _json["maxDaysInTransit"];
    }
    if (_json.containsKey("methodName")) {
      methodName = _json["methodName"];
    }
    if (_json.containsKey("minDaysInTransit")) {
      minDaysInTransit = _json["minDaysInTransit"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (carrier != null) {
      _json["carrier"] = carrier;
    }
    if (maxDaysInTransit != null) {
      _json["maxDaysInTransit"] = maxDaysInTransit;
    }
    if (methodName != null) {
      _json["methodName"] = methodName;
    }
    if (minDaysInTransit != null) {
      _json["minDaysInTransit"] = minDaysInTransit;
    }
    return _json;
  }
}

class OrderMerchantProvidedAnnotation {
  /// Key for additional merchant provided (as key-value pairs) annotation about
  /// the line item.
  core.String key;

  /// Value for additional merchant provided (as key-value pairs) annotation
  /// about the line item.
  core.String value;

  OrderMerchantProvidedAnnotation();

  OrderMerchantProvidedAnnotation.fromJson(core.Map _json) {
    if (_json.containsKey("key")) {
      key = _json["key"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (key != null) {
      _json["key"] = key;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class OrderPromotion {
  /// Items which this promotion may be applied to. If empty, there are no
  /// restrictions on applicable items and quantity.
  core.List<OrderPromotionItem> applicableItems;

  /// Items which this promotion have been applied to.
  core.List<OrderPromotionItem> appliedItems;

  /// The party funding the promotion.
  core.String funder;

  /// This field is used to identify promotions within merchants' own systems.
  core.String merchantPromotionId;

  /// Estimated discount applied to pre-tax amount.
  Price pretaxValue;

  /// A short title of the promotion to be shown on the checkout page.
  core.String shortTitle;

  /// The category of the promotion.
  core.String subtype;

  /// Estimated discount applied to tax (if allowed by law).
  Price taxValue;

  /// The title of the promotion.
  core.String title;

  /// The scope of the promotion.
  core.String type;

  OrderPromotion();

  OrderPromotion.fromJson(core.Map _json) {
    if (_json.containsKey("applicableItems")) {
      applicableItems = (_json["applicableItems"] as core.List)
          .map<OrderPromotionItem>(
              (value) => new OrderPromotionItem.fromJson(value))
          .toList();
    }
    if (_json.containsKey("appliedItems")) {
      appliedItems = (_json["appliedItems"] as core.List)
          .map<OrderPromotionItem>(
              (value) => new OrderPromotionItem.fromJson(value))
          .toList();
    }
    if (_json.containsKey("funder")) {
      funder = _json["funder"];
    }
    if (_json.containsKey("merchantPromotionId")) {
      merchantPromotionId = _json["merchantPromotionId"];
    }
    if (_json.containsKey("pretaxValue")) {
      pretaxValue = new Price.fromJson(_json["pretaxValue"]);
    }
    if (_json.containsKey("shortTitle")) {
      shortTitle = _json["shortTitle"];
    }
    if (_json.containsKey("subtype")) {
      subtype = _json["subtype"];
    }
    if (_json.containsKey("taxValue")) {
      taxValue = new Price.fromJson(_json["taxValue"]);
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (applicableItems != null) {
      _json["applicableItems"] =
          applicableItems.map((value) => (value).toJson()).toList();
    }
    if (appliedItems != null) {
      _json["appliedItems"] =
          appliedItems.map((value) => (value).toJson()).toList();
    }
    if (funder != null) {
      _json["funder"] = funder;
    }
    if (merchantPromotionId != null) {
      _json["merchantPromotionId"] = merchantPromotionId;
    }
    if (pretaxValue != null) {
      _json["pretaxValue"] = (pretaxValue).toJson();
    }
    if (shortTitle != null) {
      _json["shortTitle"] = shortTitle;
    }
    if (subtype != null) {
      _json["subtype"] = subtype;
    }
    if (taxValue != null) {
      _json["taxValue"] = (taxValue).toJson();
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class OrderPromotionItem {
  core.String lineItemId;
  core.String productId;

  /// The quantity of the associated product.
  core.int quantity;

  OrderPromotionItem();

  OrderPromotionItem.fromJson(core.Map _json) {
    if (_json.containsKey("lineItemId")) {
      lineItemId = _json["lineItemId"];
    }
    if (_json.containsKey("productId")) {
      productId = _json["productId"];
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (lineItemId != null) {
      _json["lineItemId"] = lineItemId;
    }
    if (productId != null) {
      _json["productId"] = productId;
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    return _json;
  }
}

class OrderRefund {
  /// The actor that created the refund.
  core.String actor;

  /// The amount that is refunded.
  Price amount;

  /// Date on which the item has been created, in ISO 8601 format.
  core.String creationDate;

  /// The reason for the refund.
  core.String reason;

  /// The explanation of the reason.
  core.String reasonText;

  OrderRefund();

  OrderRefund.fromJson(core.Map _json) {
    if (_json.containsKey("actor")) {
      actor = _json["actor"];
    }
    if (_json.containsKey("amount")) {
      amount = new Price.fromJson(_json["amount"]);
    }
    if (_json.containsKey("creationDate")) {
      creationDate = _json["creationDate"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (actor != null) {
      _json["actor"] = actor;
    }
    if (amount != null) {
      _json["amount"] = (amount).toJson();
    }
    if (creationDate != null) {
      _json["creationDate"] = creationDate;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

/// Order disbursement. All methods require the payment analyst role.
class OrderReportDisbursement {
  /// The disbursement amount.
  Price disbursementAmount;

  /// The disbursement date, in ISO 8601 format.
  core.String disbursementCreationDate;

  /// The date the disbursement was initiated, in ISO 8601 format.
  core.String disbursementDate;

  /// The ID of the disbursement.
  core.String disbursementId;

  /// The ID of the managing account.
  core.String merchantId;

  OrderReportDisbursement();

  OrderReportDisbursement.fromJson(core.Map _json) {
    if (_json.containsKey("disbursementAmount")) {
      disbursementAmount = new Price.fromJson(_json["disbursementAmount"]);
    }
    if (_json.containsKey("disbursementCreationDate")) {
      disbursementCreationDate = _json["disbursementCreationDate"];
    }
    if (_json.containsKey("disbursementDate")) {
      disbursementDate = _json["disbursementDate"];
    }
    if (_json.containsKey("disbursementId")) {
      disbursementId = _json["disbursementId"];
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (disbursementAmount != null) {
      _json["disbursementAmount"] = (disbursementAmount).toJson();
    }
    if (disbursementCreationDate != null) {
      _json["disbursementCreationDate"] = disbursementCreationDate;
    }
    if (disbursementDate != null) {
      _json["disbursementDate"] = disbursementDate;
    }
    if (disbursementId != null) {
      _json["disbursementId"] = disbursementId;
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    return _json;
  }
}

class OrderReportTransaction {
  /// The disbursement amount.
  Price disbursementAmount;

  /// The date the disbursement was created, in ISO 8601 format.
  core.String disbursementCreationDate;

  /// The date the disbursement was initiated, in ISO 8601 format.
  core.String disbursementDate;

  /// The ID of the disbursement.
  core.String disbursementId;

  /// The ID of the managing account.
  core.String merchantId;

  /// Merchant-provided id of the order.
  core.String merchantOrderId;

  /// The id of the order.
  core.String orderId;

  /// Total amount for the items.
  ProductAmount productAmount;

  /// The date of the transaction, in ISO 8601 format.
  core.String transactionDate;

  OrderReportTransaction();

  OrderReportTransaction.fromJson(core.Map _json) {
    if (_json.containsKey("disbursementAmount")) {
      disbursementAmount = new Price.fromJson(_json["disbursementAmount"]);
    }
    if (_json.containsKey("disbursementCreationDate")) {
      disbursementCreationDate = _json["disbursementCreationDate"];
    }
    if (_json.containsKey("disbursementDate")) {
      disbursementDate = _json["disbursementDate"];
    }
    if (_json.containsKey("disbursementId")) {
      disbursementId = _json["disbursementId"];
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("merchantOrderId")) {
      merchantOrderId = _json["merchantOrderId"];
    }
    if (_json.containsKey("orderId")) {
      orderId = _json["orderId"];
    }
    if (_json.containsKey("productAmount")) {
      productAmount = new ProductAmount.fromJson(_json["productAmount"]);
    }
    if (_json.containsKey("transactionDate")) {
      transactionDate = _json["transactionDate"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (disbursementAmount != null) {
      _json["disbursementAmount"] = (disbursementAmount).toJson();
    }
    if (disbursementCreationDate != null) {
      _json["disbursementCreationDate"] = disbursementCreationDate;
    }
    if (disbursementDate != null) {
      _json["disbursementDate"] = disbursementDate;
    }
    if (disbursementId != null) {
      _json["disbursementId"] = disbursementId;
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (merchantOrderId != null) {
      _json["merchantOrderId"] = merchantOrderId;
    }
    if (orderId != null) {
      _json["orderId"] = orderId;
    }
    if (productAmount != null) {
      _json["productAmount"] = (productAmount).toJson();
    }
    if (transactionDate != null) {
      _json["transactionDate"] = transactionDate;
    }
    return _json;
  }
}

class OrderReturn {
  /// The actor that created the refund.
  core.String actor;

  /// Date on which the item has been created, in ISO 8601 format.
  core.String creationDate;

  /// Quantity that is returned.
  core.int quantity;

  /// The reason for the return.
  core.String reason;

  /// The explanation of the reason.
  core.String reasonText;

  OrderReturn();

  OrderReturn.fromJson(core.Map _json) {
    if (_json.containsKey("actor")) {
      actor = _json["actor"];
    }
    if (_json.containsKey("creationDate")) {
      creationDate = _json["creationDate"];
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (actor != null) {
      _json["actor"] = actor;
    }
    if (creationDate != null) {
      _json["creationDate"] = creationDate;
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrderShipment {
  /// The carrier handling the shipment.
  ///
  /// Acceptable values for US are:
  /// - "gsx"
  /// - "ups"
  /// - "usps"
  /// - "fedex"
  /// - "dhl"
  /// - "ecourier"
  /// - "cxt"
  /// - "google"
  /// - "ontrac"
  /// - "emsy"
  /// - "ont"
  /// - "deliv"
  /// - "dynamex"
  /// - "lasership"
  /// - "mpx"
  /// - "uds"
  ///
  /// Acceptable values for FR are:
  /// - "colissimo"
  /// - "chronopost"
  core.String carrier;

  /// Date on which the shipment has been created, in ISO 8601 format.
  core.String creationDate;

  /// Date on which the shipment has been delivered, in ISO 8601 format. Present
  /// only if status is delivered
  core.String deliveryDate;

  /// The id of the shipment.
  core.String id;

  /// The line items that are shipped.
  core.List<OrderShipmentLineItemShipment> lineItems;

  /// The status of the shipment.
  core.String status;

  /// The tracking id for the shipment.
  core.String trackingId;

  OrderShipment();

  OrderShipment.fromJson(core.Map _json) {
    if (_json.containsKey("carrier")) {
      carrier = _json["carrier"];
    }
    if (_json.containsKey("creationDate")) {
      creationDate = _json["creationDate"];
    }
    if (_json.containsKey("deliveryDate")) {
      deliveryDate = _json["deliveryDate"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("lineItems")) {
      lineItems = (_json["lineItems"] as core.List)
          .map<OrderShipmentLineItemShipment>(
              (value) => new OrderShipmentLineItemShipment.fromJson(value))
          .toList();
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("trackingId")) {
      trackingId = _json["trackingId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (carrier != null) {
      _json["carrier"] = carrier;
    }
    if (creationDate != null) {
      _json["creationDate"] = creationDate;
    }
    if (deliveryDate != null) {
      _json["deliveryDate"] = deliveryDate;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (lineItems != null) {
      _json["lineItems"] = lineItems.map((value) => (value).toJson()).toList();
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (trackingId != null) {
      _json["trackingId"] = trackingId;
    }
    return _json;
  }
}

class OrderShipmentLineItemShipment {
  /// The id of the line item that is shipped. Either lineItemId or productId is
  /// required.
  core.String lineItemId;

  /// The ID of the product to ship. This is the REST ID used in the products
  /// service. Either lineItemId or productId is required.
  core.String productId;

  /// The quantity that is shipped.
  core.int quantity;

  OrderShipmentLineItemShipment();

  OrderShipmentLineItemShipment.fromJson(core.Map _json) {
    if (_json.containsKey("lineItemId")) {
      lineItemId = _json["lineItemId"];
    }
    if (_json.containsKey("productId")) {
      productId = _json["productId"];
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (lineItemId != null) {
      _json["lineItemId"] = lineItemId;
    }
    if (productId != null) {
      _json["productId"] = productId;
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    return _json;
  }
}

class OrderinvoicesCreateChargeInvoiceRequest {
  /// [required] The ID of the invoice.
  core.String invoiceId;

  /// [required] Invoice summary.
  InvoiceSummary invoiceSummary;

  /// [required] Invoice details per line item.
  core.List<ShipmentInvoiceLineItemInvoice> lineItemInvoices;

  /// [required] The ID of the operation, unique across all operations for a
  /// given order.
  core.String operationId;

  /// [required] ID of the shipment group.
  core.String shipmentGroupId;

  OrderinvoicesCreateChargeInvoiceRequest();

  OrderinvoicesCreateChargeInvoiceRequest.fromJson(core.Map _json) {
    if (_json.containsKey("invoiceId")) {
      invoiceId = _json["invoiceId"];
    }
    if (_json.containsKey("invoiceSummary")) {
      invoiceSummary = new InvoiceSummary.fromJson(_json["invoiceSummary"]);
    }
    if (_json.containsKey("lineItemInvoices")) {
      lineItemInvoices = (_json["lineItemInvoices"] as core.List)
          .map<ShipmentInvoiceLineItemInvoice>(
              (value) => new ShipmentInvoiceLineItemInvoice.fromJson(value))
          .toList();
    }
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("shipmentGroupId")) {
      shipmentGroupId = _json["shipmentGroupId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (invoiceId != null) {
      _json["invoiceId"] = invoiceId;
    }
    if (invoiceSummary != null) {
      _json["invoiceSummary"] = (invoiceSummary).toJson();
    }
    if (lineItemInvoices != null) {
      _json["lineItemInvoices"] =
          lineItemInvoices.map((value) => (value).toJson()).toList();
    }
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (shipmentGroupId != null) {
      _json["shipmentGroupId"] = shipmentGroupId;
    }
    return _json;
  }
}

class OrderinvoicesCreateChargeInvoiceResponse {
  /// The status of the execution.
  core.String executionStatus;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#orderinvoicesCreateChargeInvoiceResponse".
  core.String kind;

  OrderinvoicesCreateChargeInvoiceResponse();

  OrderinvoicesCreateChargeInvoiceResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrderinvoicesCreateRefundInvoiceRequest {
  /// [required] The ID of the invoice.
  core.String invoiceId;

  /// [required] The ID of the operation, unique across all operations for a
  /// given order.
  core.String operationId;

  /// Option to create a refund-only invoice. Exactly one of refundOnlyOption or
  /// returnOption must be provided.
  OrderinvoicesCustomBatchRequestEntryCreateRefundInvoiceRefundOption
      refundOnlyOption;

  /// Option to create an invoice for a refund and mark all items within the
  /// invoice as returned. Exactly one of refundOnlyOption or returnOption must
  /// be provided.
  OrderinvoicesCustomBatchRequestEntryCreateRefundInvoiceReturnOption
      returnOption;

  /// Invoice details for different shipment groups.
  core.List<ShipmentInvoice> shipmentInvoices;

  OrderinvoicesCreateRefundInvoiceRequest();

  OrderinvoicesCreateRefundInvoiceRequest.fromJson(core.Map _json) {
    if (_json.containsKey("invoiceId")) {
      invoiceId = _json["invoiceId"];
    }
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("refundOnlyOption")) {
      refundOnlyOption =
          new OrderinvoicesCustomBatchRequestEntryCreateRefundInvoiceRefundOption
              .fromJson(_json["refundOnlyOption"]);
    }
    if (_json.containsKey("returnOption")) {
      returnOption =
          new OrderinvoicesCustomBatchRequestEntryCreateRefundInvoiceReturnOption
              .fromJson(_json["returnOption"]);
    }
    if (_json.containsKey("shipmentInvoices")) {
      shipmentInvoices = (_json["shipmentInvoices"] as core.List)
          .map<ShipmentInvoice>((value) => new ShipmentInvoice.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (invoiceId != null) {
      _json["invoiceId"] = invoiceId;
    }
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (refundOnlyOption != null) {
      _json["refundOnlyOption"] = (refundOnlyOption).toJson();
    }
    if (returnOption != null) {
      _json["returnOption"] = (returnOption).toJson();
    }
    if (shipmentInvoices != null) {
      _json["shipmentInvoices"] =
          shipmentInvoices.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class OrderinvoicesCreateRefundInvoiceResponse {
  /// The status of the execution.
  core.String executionStatus;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#orderinvoicesCreateRefundInvoiceResponse".
  core.String kind;

  OrderinvoicesCreateRefundInvoiceResponse();

  OrderinvoicesCreateRefundInvoiceResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrderinvoicesCustomBatchRequestEntryCreateRefundInvoiceRefundOption {
  /// Optional description of the refund reason.
  core.String description;

  /// [required] Reason for the refund.
  core.String reason;

  OrderinvoicesCustomBatchRequestEntryCreateRefundInvoiceRefundOption();

  OrderinvoicesCustomBatchRequestEntryCreateRefundInvoiceRefundOption.fromJson(
      core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (description != null) {
      _json["description"] = description;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    return _json;
  }
}

class OrderinvoicesCustomBatchRequestEntryCreateRefundInvoiceReturnOption {
  /// Optional description of the return reason.
  core.String description;

  /// [required] Reason for the return.
  core.String reason;

  OrderinvoicesCustomBatchRequestEntryCreateRefundInvoiceReturnOption();

  OrderinvoicesCustomBatchRequestEntryCreateRefundInvoiceReturnOption.fromJson(
      core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (description != null) {
      _json["description"] = description;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    return _json;
  }
}

class OrderpaymentsNotifyAuthApprovedRequest {
  Price authAmountPretax;
  Price authAmountTax;

  OrderpaymentsNotifyAuthApprovedRequest();

  OrderpaymentsNotifyAuthApprovedRequest.fromJson(core.Map _json) {
    if (_json.containsKey("authAmountPretax")) {
      authAmountPretax = new Price.fromJson(_json["authAmountPretax"]);
    }
    if (_json.containsKey("authAmountTax")) {
      authAmountTax = new Price.fromJson(_json["authAmountTax"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (authAmountPretax != null) {
      _json["authAmountPretax"] = (authAmountPretax).toJson();
    }
    if (authAmountTax != null) {
      _json["authAmountTax"] = (authAmountTax).toJson();
    }
    return _json;
  }
}

class OrderpaymentsNotifyAuthApprovedResponse {
  /// The status of the execution.
  core.String executionStatus;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#orderpaymentsNotifyAuthApprovedResponse".
  core.String kind;

  OrderpaymentsNotifyAuthApprovedResponse();

  OrderpaymentsNotifyAuthApprovedResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrderpaymentsNotifyAuthDeclinedRequest {
  /// Reason why payment authorization was declined.
  core.String declineReason;

  OrderpaymentsNotifyAuthDeclinedRequest();

  OrderpaymentsNotifyAuthDeclinedRequest.fromJson(core.Map _json) {
    if (_json.containsKey("declineReason")) {
      declineReason = _json["declineReason"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (declineReason != null) {
      _json["declineReason"] = declineReason;
    }
    return _json;
  }
}

class OrderpaymentsNotifyAuthDeclinedResponse {
  /// The status of the execution.
  core.String executionStatus;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#orderpaymentsNotifyAuthDeclinedResponse".
  core.String kind;

  OrderpaymentsNotifyAuthDeclinedResponse();

  OrderpaymentsNotifyAuthDeclinedResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrderpaymentsNotifyChargeRequest {
  /// Whether charge was successful.
  core.String chargeState;

  /// Invoice IDs from the orderinvoices service that correspond to the charge.
  core.List<core.String> invoiceIds;

  OrderpaymentsNotifyChargeRequest();

  OrderpaymentsNotifyChargeRequest.fromJson(core.Map _json) {
    if (_json.containsKey("chargeState")) {
      chargeState = _json["chargeState"];
    }
    if (_json.containsKey("invoiceIds")) {
      invoiceIds = (_json["invoiceIds"] as core.List).cast<core.String>();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (chargeState != null) {
      _json["chargeState"] = chargeState;
    }
    if (invoiceIds != null) {
      _json["invoiceIds"] = invoiceIds;
    }
    return _json;
  }
}

class OrderpaymentsNotifyChargeResponse {
  /// The status of the execution.
  core.String executionStatus;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#orderpaymentsNotifyChargeResponse".
  core.String kind;

  OrderpaymentsNotifyChargeResponse();

  OrderpaymentsNotifyChargeResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrderpaymentsNotifyRefundRequest {
  /// Invoice IDs from the orderinvoices service that correspond to the refund.
  core.List<core.String> invoiceIds;

  /// Whether refund was successful.
  core.String refundState;

  OrderpaymentsNotifyRefundRequest();

  OrderpaymentsNotifyRefundRequest.fromJson(core.Map _json) {
    if (_json.containsKey("invoiceIds")) {
      invoiceIds = (_json["invoiceIds"] as core.List).cast<core.String>();
    }
    if (_json.containsKey("refundState")) {
      refundState = _json["refundState"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (invoiceIds != null) {
      _json["invoiceIds"] = invoiceIds;
    }
    if (refundState != null) {
      _json["refundState"] = refundState;
    }
    return _json;
  }
}

class OrderpaymentsNotifyRefundResponse {
  /// The status of the execution.
  core.String executionStatus;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#orderpaymentsNotifyRefundResponse".
  core.String kind;

  OrderpaymentsNotifyRefundResponse();

  OrderpaymentsNotifyRefundResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrderreportsListDisbursementsResponse {
  /// The list of disbursements.
  core.List<OrderReportDisbursement> disbursements;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#orderreportsListDisbursementsResponse".
  core.String kind;

  /// The token for the retrieval of the next page of disbursements.
  core.String nextPageToken;

  OrderreportsListDisbursementsResponse();

  OrderreportsListDisbursementsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("disbursements")) {
      disbursements = (_json["disbursements"] as core.List)
          .map<OrderReportDisbursement>(
              (value) => new OrderReportDisbursement.fromJson(value))
          .toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (disbursements != null) {
      _json["disbursements"] =
          disbursements.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

class OrderreportsListTransactionsResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#orderreportsListTransactionsResponse".
  core.String kind;

  /// The token for the retrieval of the next page of transactions.
  core.String nextPageToken;

  /// The list of transactions.
  core.List<OrderReportTransaction> transactions;

  OrderreportsListTransactionsResponse();

  OrderreportsListTransactionsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("transactions")) {
      transactions = (_json["transactions"] as core.List)
          .map<OrderReportTransaction>(
              (value) => new OrderReportTransaction.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (transactions != null) {
      _json["transactions"] =
          transactions.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class OrderreturnsListResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#orderreturnsListResponse".
  core.String kind;

  /// The token for the retrieval of the next page of returns.
  core.String nextPageToken;
  core.List<MerchantOrderReturn> resources;

  OrderreturnsListResponse();

  OrderreturnsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resources")) {
      resources = (_json["resources"] as core.List)
          .map<MerchantOrderReturn>(
              (value) => new MerchantOrderReturn.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resources != null) {
      _json["resources"] = resources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class OrdersAcknowledgeRequest {
  /// The ID of the operation. Unique across all operations for a given order.
  core.String operationId;

  OrdersAcknowledgeRequest();

  OrdersAcknowledgeRequest.fromJson(core.Map _json) {
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    return _json;
  }
}

class OrdersAcknowledgeResponse {
  /// The status of the execution.
  core.String executionStatus;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#ordersAcknowledgeResponse".
  core.String kind;

  OrdersAcknowledgeResponse();

  OrdersAcknowledgeResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersAdvanceTestOrderResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#ordersAdvanceTestOrderResponse".
  core.String kind;

  OrdersAdvanceTestOrderResponse();

  OrdersAdvanceTestOrderResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersCancelLineItemRequest {
  /// The ID of the line item to cancel. Either lineItemId or productId is
  /// required.
  core.String lineItemId;

  /// The ID of the operation. Unique across all operations for a given order.
  core.String operationId;

  /// The ID of the product to cancel. This is the REST ID used in the products
  /// service. Either lineItemId or productId is required.
  core.String productId;

  /// The quantity to cancel.
  core.int quantity;

  /// The reason for the cancellation.
  core.String reason;

  /// The explanation of the reason.
  core.String reasonText;

  OrdersCancelLineItemRequest();

  OrdersCancelLineItemRequest.fromJson(core.Map _json) {
    if (_json.containsKey("lineItemId")) {
      lineItemId = _json["lineItemId"];
    }
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("productId")) {
      productId = _json["productId"];
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (lineItemId != null) {
      _json["lineItemId"] = lineItemId;
    }
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (productId != null) {
      _json["productId"] = productId;
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrdersCancelLineItemResponse {
  /// The status of the execution.
  core.String executionStatus;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#ordersCancelLineItemResponse".
  core.String kind;

  OrdersCancelLineItemResponse();

  OrdersCancelLineItemResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersCancelRequest {
  /// The ID of the operation. Unique across all operations for a given order.
  core.String operationId;

  /// The reason for the cancellation.
  core.String reason;

  /// The explanation of the reason.
  core.String reasonText;

  OrdersCancelRequest();

  OrdersCancelRequest.fromJson(core.Map _json) {
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrdersCancelResponse {
  /// The status of the execution.
  core.String executionStatus;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#ordersCancelResponse".
  core.String kind;

  OrdersCancelResponse();

  OrdersCancelResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersCancelTestOrderByCustomerRequest {
  /// The reason for the cancellation.
  core.String reason;

  OrdersCancelTestOrderByCustomerRequest();

  OrdersCancelTestOrderByCustomerRequest.fromJson(core.Map _json) {
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (reason != null) {
      _json["reason"] = reason;
    }
    return _json;
  }
}

class OrdersCancelTestOrderByCustomerResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#ordersCancelTestOrderByCustomerResponse".
  core.String kind;

  OrdersCancelTestOrderByCustomerResponse();

  OrdersCancelTestOrderByCustomerResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersCreateTestOrderRequest {
  /// The  CLDR territory code of the country of the test order to create.
  /// Affects the currency and addresses of orders created via template_name, or
  /// the addresses of orders created via test_order.
  ///
  /// Acceptable values are:
  /// - "US"
  /// - "FR"  Defaults to US.
  core.String country;

  /// The test order template to use. Specify as an alternative to testOrder as
  /// a shortcut for retrieving a template and then creating an order using that
  /// template.
  core.String templateName;

  /// The test order to create.
  TestOrder testOrder;

  OrdersCreateTestOrderRequest();

  OrdersCreateTestOrderRequest.fromJson(core.Map _json) {
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("templateName")) {
      templateName = _json["templateName"];
    }
    if (_json.containsKey("testOrder")) {
      testOrder = new TestOrder.fromJson(_json["testOrder"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (country != null) {
      _json["country"] = country;
    }
    if (templateName != null) {
      _json["templateName"] = templateName;
    }
    if (testOrder != null) {
      _json["testOrder"] = (testOrder).toJson();
    }
    return _json;
  }
}

class OrdersCreateTestOrderResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#ordersCreateTestOrderResponse".
  core.String kind;

  /// The ID of the newly created test order.
  core.String orderId;

  OrdersCreateTestOrderResponse();

  OrdersCreateTestOrderResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("orderId")) {
      orderId = _json["orderId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (orderId != null) {
      _json["orderId"] = orderId;
    }
    return _json;
  }
}

class OrdersCreateTestReturnRequest {
  /// Returned items.
  core.List<OrdersCustomBatchRequestEntryCreateTestReturnReturnItem> items;

  OrdersCreateTestReturnRequest();

  OrdersCreateTestReturnRequest.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = (_json["items"] as core.List)
          .map<OrdersCustomBatchRequestEntryCreateTestReturnReturnItem>(
              (value) =>
                  new OrdersCustomBatchRequestEntryCreateTestReturnReturnItem
                      .fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class OrdersCreateTestReturnResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#ordersCreateTestReturnResponse".
  core.String kind;

  /// The ID of the newly created test order return.
  core.String returnId;

  OrdersCreateTestReturnResponse();

  OrdersCreateTestReturnResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("returnId")) {
      returnId = _json["returnId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (returnId != null) {
      _json["returnId"] = returnId;
    }
    return _json;
  }
}

class OrdersCustomBatchRequestEntryCreateTestReturnReturnItem {
  /// The ID of the line item to return.
  core.String lineItemId;

  /// Quantity that is returned.
  core.int quantity;

  OrdersCustomBatchRequestEntryCreateTestReturnReturnItem();

  OrdersCustomBatchRequestEntryCreateTestReturnReturnItem.fromJson(
      core.Map _json) {
    if (_json.containsKey("lineItemId")) {
      lineItemId = _json["lineItemId"];
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (lineItemId != null) {
      _json["lineItemId"] = lineItemId;
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    return _json;
  }
}

class OrdersCustomBatchRequestEntryShipLineItemsShipmentInfo {
  /// The carrier handling the shipment. See shipments[].carrier in the  Orders
  /// resource representation for a list of acceptable values.
  core.String carrier;

  /// The ID of the shipment.
  core.String shipmentId;

  /// The tracking id for the shipment.
  core.String trackingId;

  OrdersCustomBatchRequestEntryShipLineItemsShipmentInfo();

  OrdersCustomBatchRequestEntryShipLineItemsShipmentInfo.fromJson(
      core.Map _json) {
    if (_json.containsKey("carrier")) {
      carrier = _json["carrier"];
    }
    if (_json.containsKey("shipmentId")) {
      shipmentId = _json["shipmentId"];
    }
    if (_json.containsKey("trackingId")) {
      trackingId = _json["trackingId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (carrier != null) {
      _json["carrier"] = carrier;
    }
    if (shipmentId != null) {
      _json["shipmentId"] = shipmentId;
    }
    if (trackingId != null) {
      _json["trackingId"] = trackingId;
    }
    return _json;
  }
}

class OrdersGetByMerchantOrderIdResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#ordersGetByMerchantOrderIdResponse".
  core.String kind;

  /// The requested order.
  Order order;

  OrdersGetByMerchantOrderIdResponse();

  OrdersGetByMerchantOrderIdResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("order")) {
      order = new Order.fromJson(_json["order"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (order != null) {
      _json["order"] = (order).toJson();
    }
    return _json;
  }
}

class OrdersGetTestOrderTemplateResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#ordersGetTestOrderTemplateResponse".
  core.String kind;

  /// The requested test order template.
  TestOrder template;

  OrdersGetTestOrderTemplateResponse();

  OrdersGetTestOrderTemplateResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("template")) {
      template = new TestOrder.fromJson(_json["template"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (template != null) {
      _json["template"] = (template).toJson();
    }
    return _json;
  }
}

class OrdersInStoreRefundLineItemRequest {
  /// The ID of the line item to return. Either lineItemId or productId is
  /// required.
  core.String lineItemId;

  /// The ID of the operation. Unique across all operations for a given order.
  core.String operationId;

  /// The amount to be refunded. This may be pre-tax or post-tax depending on
  /// the location of the order. Required.
  Price priceAmount;

  /// The ID of the product to return. This is the REST ID used in the products
  /// service. Either lineItemId or productId is required.
  core.String productId;

  /// The quantity to return and refund.
  core.int quantity;

  /// The reason for the return.
  core.String reason;

  /// The explanation of the reason.
  core.String reasonText;

  /// The amount of tax to be refunded. Required.
  Price taxAmount;

  OrdersInStoreRefundLineItemRequest();

  OrdersInStoreRefundLineItemRequest.fromJson(core.Map _json) {
    if (_json.containsKey("lineItemId")) {
      lineItemId = _json["lineItemId"];
    }
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("priceAmount")) {
      priceAmount = new Price.fromJson(_json["priceAmount"]);
    }
    if (_json.containsKey("productId")) {
      productId = _json["productId"];
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
    if (_json.containsKey("taxAmount")) {
      taxAmount = new Price.fromJson(_json["taxAmount"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (lineItemId != null) {
      _json["lineItemId"] = lineItemId;
    }
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (priceAmount != null) {
      _json["priceAmount"] = (priceAmount).toJson();
    }
    if (productId != null) {
      _json["productId"] = productId;
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    if (taxAmount != null) {
      _json["taxAmount"] = (taxAmount).toJson();
    }
    return _json;
  }
}

class OrdersInStoreRefundLineItemResponse {
  /// The status of the execution.
  core.String executionStatus;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#ordersInStoreRefundLineItemResponse".
  core.String kind;

  OrdersInStoreRefundLineItemResponse();

  OrdersInStoreRefundLineItemResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersListResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#ordersListResponse".
  core.String kind;

  /// The token for the retrieval of the next page of orders.
  core.String nextPageToken;
  core.List<Order> resources;

  OrdersListResponse();

  OrdersListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resources")) {
      resources = (_json["resources"] as core.List)
          .map<Order>((value) => new Order.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resources != null) {
      _json["resources"] = resources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class OrdersRejectReturnLineItemRequest {
  /// The ID of the line item to return. Either lineItemId or productId is
  /// required.
  core.String lineItemId;

  /// The ID of the operation. Unique across all operations for a given order.
  core.String operationId;

  /// The ID of the product to return. This is the REST ID used in the products
  /// service. Either lineItemId or productId is required.
  core.String productId;

  /// The quantity to return and refund.
  core.int quantity;

  /// The reason for the return.
  core.String reason;

  /// The explanation of the reason.
  core.String reasonText;

  OrdersRejectReturnLineItemRequest();

  OrdersRejectReturnLineItemRequest.fromJson(core.Map _json) {
    if (_json.containsKey("lineItemId")) {
      lineItemId = _json["lineItemId"];
    }
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("productId")) {
      productId = _json["productId"];
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (lineItemId != null) {
      _json["lineItemId"] = lineItemId;
    }
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (productId != null) {
      _json["productId"] = productId;
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    return _json;
  }
}

class OrdersRejectReturnLineItemResponse {
  /// The status of the execution.
  core.String executionStatus;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#ordersRejectReturnLineItemResponse".
  core.String kind;

  OrdersRejectReturnLineItemResponse();

  OrdersRejectReturnLineItemResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersReturnRefundLineItemRequest {
  /// The ID of the line item to return. Either lineItemId or productId is
  /// required.
  core.String lineItemId;

  /// The ID of the operation. Unique across all operations for a given order.
  core.String operationId;

  /// The amount to be refunded. This may be pre-tax or post-tax depending on
  /// the location of the order. If omitted, refundless return is assumed.
  Price priceAmount;

  /// The ID of the product to return. This is the REST ID used in the products
  /// service. Either lineItemId or productId is required.
  core.String productId;

  /// The quantity to return and refund.
  core.int quantity;

  /// The reason for the return.
  core.String reason;

  /// The explanation of the reason.
  core.String reasonText;

  /// The amount of tax to be refunded. Optional, but if filled, then
  /// priceAmount must be set. Calculated automatically if not provided.
  Price taxAmount;

  OrdersReturnRefundLineItemRequest();

  OrdersReturnRefundLineItemRequest.fromJson(core.Map _json) {
    if (_json.containsKey("lineItemId")) {
      lineItemId = _json["lineItemId"];
    }
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("priceAmount")) {
      priceAmount = new Price.fromJson(_json["priceAmount"]);
    }
    if (_json.containsKey("productId")) {
      productId = _json["productId"];
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("reasonText")) {
      reasonText = _json["reasonText"];
    }
    if (_json.containsKey("taxAmount")) {
      taxAmount = new Price.fromJson(_json["taxAmount"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (lineItemId != null) {
      _json["lineItemId"] = lineItemId;
    }
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (priceAmount != null) {
      _json["priceAmount"] = (priceAmount).toJson();
    }
    if (productId != null) {
      _json["productId"] = productId;
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (reasonText != null) {
      _json["reasonText"] = reasonText;
    }
    if (taxAmount != null) {
      _json["taxAmount"] = (taxAmount).toJson();
    }
    return _json;
  }
}

class OrdersReturnRefundLineItemResponse {
  /// The status of the execution.
  core.String executionStatus;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#ordersReturnRefundLineItemResponse".
  core.String kind;

  OrdersReturnRefundLineItemResponse();

  OrdersReturnRefundLineItemResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersSetLineItemMetadataRequest {
  core.List<OrderMerchantProvidedAnnotation> annotations;

  /// The ID of the line item to set metadata. Either lineItemId or productId is
  /// required.
  core.String lineItemId;

  /// The ID of the operation. Unique across all operations for a given order.
  core.String operationId;

  /// The ID of the product to set metadata. This is the REST ID used in the
  /// products service. Either lineItemId or productId is required.
  core.String productId;

  OrdersSetLineItemMetadataRequest();

  OrdersSetLineItemMetadataRequest.fromJson(core.Map _json) {
    if (_json.containsKey("annotations")) {
      annotations = (_json["annotations"] as core.List)
          .map<OrderMerchantProvidedAnnotation>(
              (value) => new OrderMerchantProvidedAnnotation.fromJson(value))
          .toList();
    }
    if (_json.containsKey("lineItemId")) {
      lineItemId = _json["lineItemId"];
    }
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("productId")) {
      productId = _json["productId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (annotations != null) {
      _json["annotations"] =
          annotations.map((value) => (value).toJson()).toList();
    }
    if (lineItemId != null) {
      _json["lineItemId"] = lineItemId;
    }
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (productId != null) {
      _json["productId"] = productId;
    }
    return _json;
  }
}

class OrdersSetLineItemMetadataResponse {
  /// The status of the execution.
  core.String executionStatus;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#ordersSetLineItemMetadataResponse".
  core.String kind;

  OrdersSetLineItemMetadataResponse();

  OrdersSetLineItemMetadataResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersShipLineItemsRequest {
  /// Line items to ship.
  core.List<OrderShipmentLineItemShipment> lineItems;

  /// The ID of the operation. Unique across all operations for a given order.
  core.String operationId;

  /// ID of the shipment group. Required for orders that use the orderinvoices
  /// service.
  core.String shipmentGroupId;

  /// Shipment information. This field is repeated because a single line item
  /// can be shipped in several packages (and have several tracking IDs).
  core.List<OrdersCustomBatchRequestEntryShipLineItemsShipmentInfo>
      shipmentInfos;

  OrdersShipLineItemsRequest();

  OrdersShipLineItemsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("lineItems")) {
      lineItems = (_json["lineItems"] as core.List)
          .map<OrderShipmentLineItemShipment>(
              (value) => new OrderShipmentLineItemShipment.fromJson(value))
          .toList();
    }
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("shipmentGroupId")) {
      shipmentGroupId = _json["shipmentGroupId"];
    }
    if (_json.containsKey("shipmentInfos")) {
      shipmentInfos = (_json["shipmentInfos"] as core.List)
          .map<OrdersCustomBatchRequestEntryShipLineItemsShipmentInfo>(
              (value) =>
                  new OrdersCustomBatchRequestEntryShipLineItemsShipmentInfo
                      .fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (lineItems != null) {
      _json["lineItems"] = lineItems.map((value) => (value).toJson()).toList();
    }
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (shipmentGroupId != null) {
      _json["shipmentGroupId"] = shipmentGroupId;
    }
    if (shipmentInfos != null) {
      _json["shipmentInfos"] =
          shipmentInfos.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class OrdersShipLineItemsResponse {
  /// The status of the execution.
  core.String executionStatus;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#ordersShipLineItemsResponse".
  core.String kind;

  OrdersShipLineItemsResponse();

  OrdersShipLineItemsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersUpdateLineItemShippingDetailsRequest {
  /// Updated delivery by date, in ISO 8601 format. If not specified only ship
  /// by date is updated.
  core.String deliverByDate;

  /// The ID of the line item to set metadata. Either lineItemId or productId is
  /// required.
  core.String lineItemId;

  /// The ID of the operation. Unique across all operations for a given order.
  core.String operationId;

  /// The ID of the product to set metadata. This is the REST ID used in the
  /// products service. Either lineItemId or productId is required.
  core.String productId;

  /// Updated ship by date, in ISO 8601 format. If not specified only deliver by
  /// date is updated.
  core.String shipByDate;

  OrdersUpdateLineItemShippingDetailsRequest();

  OrdersUpdateLineItemShippingDetailsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("deliverByDate")) {
      deliverByDate = _json["deliverByDate"];
    }
    if (_json.containsKey("lineItemId")) {
      lineItemId = _json["lineItemId"];
    }
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("productId")) {
      productId = _json["productId"];
    }
    if (_json.containsKey("shipByDate")) {
      shipByDate = _json["shipByDate"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (deliverByDate != null) {
      _json["deliverByDate"] = deliverByDate;
    }
    if (lineItemId != null) {
      _json["lineItemId"] = lineItemId;
    }
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (productId != null) {
      _json["productId"] = productId;
    }
    if (shipByDate != null) {
      _json["shipByDate"] = shipByDate;
    }
    return _json;
  }
}

class OrdersUpdateLineItemShippingDetailsResponse {
  /// The status of the execution.
  core.String executionStatus;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#ordersUpdateLineItemShippingDetailsResponse".
  core.String kind;

  OrdersUpdateLineItemShippingDetailsResponse();

  OrdersUpdateLineItemShippingDetailsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersUpdateMerchantOrderIdRequest {
  /// The merchant order id to be assigned to the order. Must be unique per
  /// merchant.
  core.String merchantOrderId;

  /// The ID of the operation. Unique across all operations for a given order.
  core.String operationId;

  OrdersUpdateMerchantOrderIdRequest();

  OrdersUpdateMerchantOrderIdRequest.fromJson(core.Map _json) {
    if (_json.containsKey("merchantOrderId")) {
      merchantOrderId = _json["merchantOrderId"];
    }
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (merchantOrderId != null) {
      _json["merchantOrderId"] = merchantOrderId;
    }
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    return _json;
  }
}

class OrdersUpdateMerchantOrderIdResponse {
  /// The status of the execution.
  core.String executionStatus;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#ordersUpdateMerchantOrderIdResponse".
  core.String kind;

  OrdersUpdateMerchantOrderIdResponse();

  OrdersUpdateMerchantOrderIdResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class OrdersUpdateShipmentRequest {
  /// The carrier handling the shipment. Not updated if missing. See
  /// shipments[].carrier in the  Orders resource representation for a list of
  /// acceptable values.
  core.String carrier;

  /// Date on which the shipment has been delivered, in ISO 8601 format.
  /// Optional and can be provided only if status is delivered.
  core.String deliveryDate;

  /// The ID of the operation. Unique across all operations for a given order.
  core.String operationId;

  /// The ID of the shipment.
  core.String shipmentId;

  /// New status for the shipment. Not updated if missing.
  core.String status;

  /// The tracking id for the shipment. Not updated if missing.
  core.String trackingId;

  OrdersUpdateShipmentRequest();

  OrdersUpdateShipmentRequest.fromJson(core.Map _json) {
    if (_json.containsKey("carrier")) {
      carrier = _json["carrier"];
    }
    if (_json.containsKey("deliveryDate")) {
      deliveryDate = _json["deliveryDate"];
    }
    if (_json.containsKey("operationId")) {
      operationId = _json["operationId"];
    }
    if (_json.containsKey("shipmentId")) {
      shipmentId = _json["shipmentId"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("trackingId")) {
      trackingId = _json["trackingId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (carrier != null) {
      _json["carrier"] = carrier;
    }
    if (deliveryDate != null) {
      _json["deliveryDate"] = deliveryDate;
    }
    if (operationId != null) {
      _json["operationId"] = operationId;
    }
    if (shipmentId != null) {
      _json["shipmentId"] = shipmentId;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (trackingId != null) {
      _json["trackingId"] = trackingId;
    }
    return _json;
  }
}

class OrdersUpdateShipmentResponse {
  /// The status of the execution.
  core.String executionStatus;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#ordersUpdateShipmentResponse".
  core.String kind;

  OrdersUpdateShipmentResponse();

  OrdersUpdateShipmentResponse.fromJson(core.Map _json) {
    if (_json.containsKey("executionStatus")) {
      executionStatus = _json["executionStatus"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (executionStatus != null) {
      _json["executionStatus"] = executionStatus;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class PosCustomBatchRequest {
  /// The request entries to be processed in the batch.
  core.List<PosCustomBatchRequestEntry> entries;

  PosCustomBatchRequest();

  PosCustomBatchRequest.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = (_json["entries"] as core.List)
          .map<PosCustomBatchRequestEntry>(
              (value) => new PosCustomBatchRequestEntry.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class PosCustomBatchRequestEntry {
  /// An entry ID, unique within the batch request.
  core.int batchId;

  /// The inventory to submit. Set this only if the method is inventory.
  PosInventory inventory;

  /// The ID of the POS data provider.
  core.String merchantId;
  core.String method;

  /// The sale information to submit. Set this only if the method is sale.
  PosSale sale;

  /// The store information to submit. Set this only if the method is insert.
  PosStore store;

  /// The store code. Set this only if the method is delete or get.
  core.String storeCode;

  /// The ID of the account for which to get/submit data.
  core.String targetMerchantId;

  PosCustomBatchRequestEntry();

  PosCustomBatchRequestEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("inventory")) {
      inventory = new PosInventory.fromJson(_json["inventory"]);
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
    if (_json.containsKey("sale")) {
      sale = new PosSale.fromJson(_json["sale"]);
    }
    if (_json.containsKey("store")) {
      store = new PosStore.fromJson(_json["store"]);
    }
    if (_json.containsKey("storeCode")) {
      storeCode = _json["storeCode"];
    }
    if (_json.containsKey("targetMerchantId")) {
      targetMerchantId = _json["targetMerchantId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (inventory != null) {
      _json["inventory"] = (inventory).toJson();
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (method != null) {
      _json["method"] = method;
    }
    if (sale != null) {
      _json["sale"] = (sale).toJson();
    }
    if (store != null) {
      _json["store"] = (store).toJson();
    }
    if (storeCode != null) {
      _json["storeCode"] = storeCode;
    }
    if (targetMerchantId != null) {
      _json["targetMerchantId"] = targetMerchantId;
    }
    return _json;
  }
}

class PosCustomBatchResponse {
  /// The result of the execution of the batch requests.
  core.List<PosCustomBatchResponseEntry> entries;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#posCustomBatchResponse".
  core.String kind;

  PosCustomBatchResponse();

  PosCustomBatchResponse.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = (_json["entries"] as core.List)
          .map<PosCustomBatchResponseEntry>(
              (value) => new PosCustomBatchResponseEntry.fromJson(value))
          .toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class PosCustomBatchResponseEntry {
  /// The ID of the request entry to which this entry responds.
  core.int batchId;

  /// A list of errors defined if, and only if, the request failed.
  Errors errors;

  /// The updated inventory information.
  PosInventory inventory;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#posCustomBatchResponseEntry".
  core.String kind;

  /// The updated sale information.
  PosSale sale;

  /// The retrieved or updated store information.
  PosStore store;

  PosCustomBatchResponseEntry();

  PosCustomBatchResponseEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("errors")) {
      errors = new Errors.fromJson(_json["errors"]);
    }
    if (_json.containsKey("inventory")) {
      inventory = new PosInventory.fromJson(_json["inventory"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("sale")) {
      sale = new PosSale.fromJson(_json["sale"]);
    }
    if (_json.containsKey("store")) {
      store = new PosStore.fromJson(_json["store"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (errors != null) {
      _json["errors"] = (errors).toJson();
    }
    if (inventory != null) {
      _json["inventory"] = (inventory).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (sale != null) {
      _json["sale"] = (sale).toJson();
    }
    if (store != null) {
      _json["store"] = (store).toJson();
    }
    return _json;
  }
}

class PosDataProviders {
  /// Country code.
  core.String country;

  /// A list of POS data providers.
  core.List<PosDataProvidersPosDataProvider> posDataProviders;

  PosDataProviders();

  PosDataProviders.fromJson(core.Map _json) {
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("posDataProviders")) {
      posDataProviders = (_json["posDataProviders"] as core.List)
          .map<PosDataProvidersPosDataProvider>(
              (value) => new PosDataProvidersPosDataProvider.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (country != null) {
      _json["country"] = country;
    }
    if (posDataProviders != null) {
      _json["posDataProviders"] =
          posDataProviders.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class PosDataProvidersPosDataProvider {
  /// The display name of Pos data Provider.
  core.String displayName;

  /// The full name of this POS data Provider.
  core.String fullName;

  /// The ID of the account.
  core.String providerId;

  PosDataProvidersPosDataProvider();

  PosDataProvidersPosDataProvider.fromJson(core.Map _json) {
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("fullName")) {
      fullName = _json["fullName"];
    }
    if (_json.containsKey("providerId")) {
      providerId = _json["providerId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (fullName != null) {
      _json["fullName"] = fullName;
    }
    if (providerId != null) {
      _json["providerId"] = providerId;
    }
    return _json;
  }
}

/// The absolute quantity of an item available at the given store.
class PosInventory {
  /// The two-letter ISO 639-1 language code for the item.
  core.String contentLanguage;

  /// Global Trade Item Number.
  core.String gtin;

  /// A unique identifier for the item.
  core.String itemId;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#posInventory".
  core.String kind;

  /// The current price of the item.
  Price price;

  /// The available quantity of the item.
  core.String quantity;

  /// The identifier of the merchant's store. Either a storeCode inserted via
  /// the API or the code of the store in Google My Business.
  core.String storeCode;

  /// The CLDR territory code for the item.
  core.String targetCountry;

  /// The inventory timestamp, in ISO 8601 format.
  core.String timestamp;

  PosInventory();

  PosInventory.fromJson(core.Map _json) {
    if (_json.containsKey("contentLanguage")) {
      contentLanguage = _json["contentLanguage"];
    }
    if (_json.containsKey("gtin")) {
      gtin = _json["gtin"];
    }
    if (_json.containsKey("itemId")) {
      itemId = _json["itemId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("price")) {
      price = new Price.fromJson(_json["price"]);
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("storeCode")) {
      storeCode = _json["storeCode"];
    }
    if (_json.containsKey("targetCountry")) {
      targetCountry = _json["targetCountry"];
    }
    if (_json.containsKey("timestamp")) {
      timestamp = _json["timestamp"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (contentLanguage != null) {
      _json["contentLanguage"] = contentLanguage;
    }
    if (gtin != null) {
      _json["gtin"] = gtin;
    }
    if (itemId != null) {
      _json["itemId"] = itemId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (price != null) {
      _json["price"] = (price).toJson();
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (storeCode != null) {
      _json["storeCode"] = storeCode;
    }
    if (targetCountry != null) {
      _json["targetCountry"] = targetCountry;
    }
    if (timestamp != null) {
      _json["timestamp"] = timestamp;
    }
    return _json;
  }
}

class PosInventoryRequest {
  /// The two-letter ISO 639-1 language code for the item.
  core.String contentLanguage;

  /// Global Trade Item Number.
  core.String gtin;

  /// A unique identifier for the item.
  core.String itemId;

  /// The current price of the item.
  Price price;

  /// The available quantity of the item.
  core.String quantity;

  /// The identifier of the merchant's store. Either a storeCode inserted via
  /// the API or the code of the store in Google My Business.
  core.String storeCode;

  /// The CLDR territory code for the item.
  core.String targetCountry;

  /// The inventory timestamp, in ISO 8601 format.
  core.String timestamp;

  PosInventoryRequest();

  PosInventoryRequest.fromJson(core.Map _json) {
    if (_json.containsKey("contentLanguage")) {
      contentLanguage = _json["contentLanguage"];
    }
    if (_json.containsKey("gtin")) {
      gtin = _json["gtin"];
    }
    if (_json.containsKey("itemId")) {
      itemId = _json["itemId"];
    }
    if (_json.containsKey("price")) {
      price = new Price.fromJson(_json["price"]);
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("storeCode")) {
      storeCode = _json["storeCode"];
    }
    if (_json.containsKey("targetCountry")) {
      targetCountry = _json["targetCountry"];
    }
    if (_json.containsKey("timestamp")) {
      timestamp = _json["timestamp"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (contentLanguage != null) {
      _json["contentLanguage"] = contentLanguage;
    }
    if (gtin != null) {
      _json["gtin"] = gtin;
    }
    if (itemId != null) {
      _json["itemId"] = itemId;
    }
    if (price != null) {
      _json["price"] = (price).toJson();
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (storeCode != null) {
      _json["storeCode"] = storeCode;
    }
    if (targetCountry != null) {
      _json["targetCountry"] = targetCountry;
    }
    if (timestamp != null) {
      _json["timestamp"] = timestamp;
    }
    return _json;
  }
}

class PosInventoryResponse {
  /// The two-letter ISO 639-1 language code for the item.
  core.String contentLanguage;

  /// Global Trade Item Number.
  core.String gtin;

  /// A unique identifier for the item.
  core.String itemId;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#posInventoryResponse".
  core.String kind;

  /// The current price of the item.
  Price price;

  /// The available quantity of the item.
  core.String quantity;

  /// The identifier of the merchant's store. Either a storeCode inserted via
  /// the API or the code of the store in Google My Business.
  core.String storeCode;

  /// The CLDR territory code for the item.
  core.String targetCountry;

  /// The inventory timestamp, in ISO 8601 format.
  core.String timestamp;

  PosInventoryResponse();

  PosInventoryResponse.fromJson(core.Map _json) {
    if (_json.containsKey("contentLanguage")) {
      contentLanguage = _json["contentLanguage"];
    }
    if (_json.containsKey("gtin")) {
      gtin = _json["gtin"];
    }
    if (_json.containsKey("itemId")) {
      itemId = _json["itemId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("price")) {
      price = new Price.fromJson(_json["price"]);
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("storeCode")) {
      storeCode = _json["storeCode"];
    }
    if (_json.containsKey("targetCountry")) {
      targetCountry = _json["targetCountry"];
    }
    if (_json.containsKey("timestamp")) {
      timestamp = _json["timestamp"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (contentLanguage != null) {
      _json["contentLanguage"] = contentLanguage;
    }
    if (gtin != null) {
      _json["gtin"] = gtin;
    }
    if (itemId != null) {
      _json["itemId"] = itemId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (price != null) {
      _json["price"] = (price).toJson();
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (storeCode != null) {
      _json["storeCode"] = storeCode;
    }
    if (targetCountry != null) {
      _json["targetCountry"] = targetCountry;
    }
    if (timestamp != null) {
      _json["timestamp"] = timestamp;
    }
    return _json;
  }
}

class PosListResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#posListResponse".
  core.String kind;
  core.List<PosStore> resources;

  PosListResponse();

  PosListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("resources")) {
      resources = (_json["resources"] as core.List)
          .map<PosStore>((value) => new PosStore.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (resources != null) {
      _json["resources"] = resources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// The change of the available quantity of an item at the given store.
class PosSale {
  /// The two-letter ISO 639-1 language code for the item.
  core.String contentLanguage;

  /// Global Trade Item Number.
  core.String gtin;

  /// A unique identifier for the item.
  core.String itemId;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#posSale".
  core.String kind;

  /// The price of the item.
  Price price;

  /// The relative change of the available quantity. Negative for items
  /// returned.
  core.String quantity;

  /// A unique ID to group items from the same sale event.
  core.String saleId;

  /// The identifier of the merchant's store. Either a storeCode inserted via
  /// the API or the code of the store in Google My Business.
  core.String storeCode;

  /// The CLDR territory code for the item.
  core.String targetCountry;

  /// The inventory timestamp, in ISO 8601 format.
  core.String timestamp;

  PosSale();

  PosSale.fromJson(core.Map _json) {
    if (_json.containsKey("contentLanguage")) {
      contentLanguage = _json["contentLanguage"];
    }
    if (_json.containsKey("gtin")) {
      gtin = _json["gtin"];
    }
    if (_json.containsKey("itemId")) {
      itemId = _json["itemId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("price")) {
      price = new Price.fromJson(_json["price"]);
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("saleId")) {
      saleId = _json["saleId"];
    }
    if (_json.containsKey("storeCode")) {
      storeCode = _json["storeCode"];
    }
    if (_json.containsKey("targetCountry")) {
      targetCountry = _json["targetCountry"];
    }
    if (_json.containsKey("timestamp")) {
      timestamp = _json["timestamp"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (contentLanguage != null) {
      _json["contentLanguage"] = contentLanguage;
    }
    if (gtin != null) {
      _json["gtin"] = gtin;
    }
    if (itemId != null) {
      _json["itemId"] = itemId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (price != null) {
      _json["price"] = (price).toJson();
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (saleId != null) {
      _json["saleId"] = saleId;
    }
    if (storeCode != null) {
      _json["storeCode"] = storeCode;
    }
    if (targetCountry != null) {
      _json["targetCountry"] = targetCountry;
    }
    if (timestamp != null) {
      _json["timestamp"] = timestamp;
    }
    return _json;
  }
}

class PosSaleRequest {
  /// The two-letter ISO 639-1 language code for the item.
  core.String contentLanguage;

  /// Global Trade Item Number.
  core.String gtin;

  /// A unique identifier for the item.
  core.String itemId;

  /// The price of the item.
  Price price;

  /// The relative change of the available quantity. Negative for items
  /// returned.
  core.String quantity;

  /// A unique ID to group items from the same sale event.
  core.String saleId;

  /// The identifier of the merchant's store. Either a storeCode inserted via
  /// the API or the code of the store in Google My Business.
  core.String storeCode;

  /// The CLDR territory code for the item.
  core.String targetCountry;

  /// The inventory timestamp, in ISO 8601 format.
  core.String timestamp;

  PosSaleRequest();

  PosSaleRequest.fromJson(core.Map _json) {
    if (_json.containsKey("contentLanguage")) {
      contentLanguage = _json["contentLanguage"];
    }
    if (_json.containsKey("gtin")) {
      gtin = _json["gtin"];
    }
    if (_json.containsKey("itemId")) {
      itemId = _json["itemId"];
    }
    if (_json.containsKey("price")) {
      price = new Price.fromJson(_json["price"]);
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("saleId")) {
      saleId = _json["saleId"];
    }
    if (_json.containsKey("storeCode")) {
      storeCode = _json["storeCode"];
    }
    if (_json.containsKey("targetCountry")) {
      targetCountry = _json["targetCountry"];
    }
    if (_json.containsKey("timestamp")) {
      timestamp = _json["timestamp"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (contentLanguage != null) {
      _json["contentLanguage"] = contentLanguage;
    }
    if (gtin != null) {
      _json["gtin"] = gtin;
    }
    if (itemId != null) {
      _json["itemId"] = itemId;
    }
    if (price != null) {
      _json["price"] = (price).toJson();
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (saleId != null) {
      _json["saleId"] = saleId;
    }
    if (storeCode != null) {
      _json["storeCode"] = storeCode;
    }
    if (targetCountry != null) {
      _json["targetCountry"] = targetCountry;
    }
    if (timestamp != null) {
      _json["timestamp"] = timestamp;
    }
    return _json;
  }
}

class PosSaleResponse {
  /// The two-letter ISO 639-1 language code for the item.
  core.String contentLanguage;

  /// Global Trade Item Number.
  core.String gtin;

  /// A unique identifier for the item.
  core.String itemId;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#posSaleResponse".
  core.String kind;

  /// The price of the item.
  Price price;

  /// The relative change of the available quantity. Negative for items
  /// returned.
  core.String quantity;

  /// A unique ID to group items from the same sale event.
  core.String saleId;

  /// The identifier of the merchant's store. Either a storeCode inserted via
  /// the API or the code of the store in Google My Business.
  core.String storeCode;

  /// The CLDR territory code for the item.
  core.String targetCountry;

  /// The inventory timestamp, in ISO 8601 format.
  core.String timestamp;

  PosSaleResponse();

  PosSaleResponse.fromJson(core.Map _json) {
    if (_json.containsKey("contentLanguage")) {
      contentLanguage = _json["contentLanguage"];
    }
    if (_json.containsKey("gtin")) {
      gtin = _json["gtin"];
    }
    if (_json.containsKey("itemId")) {
      itemId = _json["itemId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("price")) {
      price = new Price.fromJson(_json["price"]);
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("saleId")) {
      saleId = _json["saleId"];
    }
    if (_json.containsKey("storeCode")) {
      storeCode = _json["storeCode"];
    }
    if (_json.containsKey("targetCountry")) {
      targetCountry = _json["targetCountry"];
    }
    if (_json.containsKey("timestamp")) {
      timestamp = _json["timestamp"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (contentLanguage != null) {
      _json["contentLanguage"] = contentLanguage;
    }
    if (gtin != null) {
      _json["gtin"] = gtin;
    }
    if (itemId != null) {
      _json["itemId"] = itemId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (price != null) {
      _json["price"] = (price).toJson();
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (saleId != null) {
      _json["saleId"] = saleId;
    }
    if (storeCode != null) {
      _json["storeCode"] = storeCode;
    }
    if (targetCountry != null) {
      _json["targetCountry"] = targetCountry;
    }
    if (timestamp != null) {
      _json["timestamp"] = timestamp;
    }
    return _json;
  }
}

/// Store resource.
class PosStore {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#posStore".
  core.String kind;

  /// The street address of the store.
  core.String storeAddress;

  /// A store identifier that is unique for the given merchant.
  core.String storeCode;

  PosStore();

  PosStore.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("storeAddress")) {
      storeAddress = _json["storeAddress"];
    }
    if (_json.containsKey("storeCode")) {
      storeCode = _json["storeCode"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (storeAddress != null) {
      _json["storeAddress"] = storeAddress;
    }
    if (storeCode != null) {
      _json["storeCode"] = storeCode;
    }
    return _json;
  }
}

class PostalCodeGroup {
  /// The CLDR territory code of the country the postal code group applies to.
  /// Required.
  core.String country;

  /// The name of the postal code group, referred to in headers. Required.
  core.String name;

  /// A range of postal codes. Required.
  core.List<PostalCodeRange> postalCodeRanges;

  PostalCodeGroup();

  PostalCodeGroup.fromJson(core.Map _json) {
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("postalCodeRanges")) {
      postalCodeRanges = (_json["postalCodeRanges"] as core.List)
          .map<PostalCodeRange>((value) => new PostalCodeRange.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (country != null) {
      _json["country"] = country;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (postalCodeRanges != null) {
      _json["postalCodeRanges"] =
          postalCodeRanges.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class PostalCodeRange {
  /// A postal code or a pattern of the form prefix* denoting the inclusive
  /// lower bound of the range defining the area. Examples values: "94108",
  /// "9410*", "9*". Required.
  core.String postalCodeRangeBegin;

  /// A postal code or a pattern of the form prefix* denoting the inclusive
  /// upper bound of the range defining the area. It must have the same length
  /// as postalCodeRangeBegin: if postalCodeRangeBegin is a postal code then
  /// postalCodeRangeEnd must be a postal code too; if postalCodeRangeBegin is a
  /// pattern then postalCodeRangeEnd must be a pattern with the same prefix
  /// length. Optional: if not set, then the area is defined as being all the
  /// postal codes matching postalCodeRangeBegin.
  core.String postalCodeRangeEnd;

  PostalCodeRange();

  PostalCodeRange.fromJson(core.Map _json) {
    if (_json.containsKey("postalCodeRangeBegin")) {
      postalCodeRangeBegin = _json["postalCodeRangeBegin"];
    }
    if (_json.containsKey("postalCodeRangeEnd")) {
      postalCodeRangeEnd = _json["postalCodeRangeEnd"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (postalCodeRangeBegin != null) {
      _json["postalCodeRangeBegin"] = postalCodeRangeBegin;
    }
    if (postalCodeRangeEnd != null) {
      _json["postalCodeRangeEnd"] = postalCodeRangeEnd;
    }
    return _json;
  }
}

class Price {
  /// The currency of the price.
  core.String currency;

  /// The price represented as a number.
  core.String value;

  Price();

  Price.fromJson(core.Map _json) {
    if (_json.containsKey("currency")) {
      currency = _json["currency"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (currency != null) {
      _json["currency"] = currency;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/// Product data. After inserting, updating, or deleting a product, it may take
/// several minutes before changes take effect.
class Product {
  /// Additional URLs of images of the item.
  core.List<core.String> additionalImageLinks;

  /// Used to group items in an arbitrary way. Only for CPA%, discouraged
  /// otherwise.
  core.String adsGrouping;

  /// Similar to ads_grouping, but only works on CPC.
  core.List<core.String> adsLabels;

  /// Allows advertisers to override the item URL when the product is shown
  /// within the context of Product Ads.
  core.String adsRedirect;

  /// Set to true if the item is targeted towards adults.
  core.bool adult;

  /// Target age group of the item.
  core.String ageGroup;

  /// Availability status of the item.
  core.String availability;

  /// The day a pre-ordered product becomes available for delivery, in ISO 8601
  /// format.
  core.String availabilityDate;

  /// Brand of the item.
  core.String brand;

  /// The item's channel (online or local).
  core.String channel;

  /// Color of the item.
  core.String color;

  /// Condition or state of the item.
  core.String condition;

  /// The two-letter ISO 639-1 language code for the item.
  core.String contentLanguage;

  /// Cost of goods sold. Used for gross profit reporting.
  Price costOfGoodsSold;

  /// A list of custom (merchant-provided) attributes. It can also be used for
  /// submitting any attribute of the feed specification in its generic form
  /// (e.g., { "name": "size type", "type": "text", "value": "regular" }). This
  /// is useful for submitting attributes not explicitly exposed by the API.
  core.List<CustomAttribute> customAttributes;

  /// Custom label 0 for custom grouping of items in a Shopping campaign.
  core.String customLabel0;

  /// Custom label 1 for custom grouping of items in a Shopping campaign.
  core.String customLabel1;

  /// Custom label 2 for custom grouping of items in a Shopping campaign.
  core.String customLabel2;

  /// Custom label 3 for custom grouping of items in a Shopping campaign.
  core.String customLabel3;

  /// Custom label 4 for custom grouping of items in a Shopping campaign.
  core.String customLabel4;

  /// Description of the item.
  core.String description;

  /// An identifier for an item for dynamic remarketing campaigns.
  core.String displayAdsId;

  /// URL directly to your item's landing page for dynamic remarketing
  /// campaigns.
  core.String displayAdsLink;

  /// Advertiser-specified recommendations.
  core.List<core.String> displayAdsSimilarIds;

  /// Title of an item for dynamic remarketing campaigns.
  core.String displayAdsTitle;

  /// Offer margin for dynamic remarketing campaigns.
  core.double displayAdsValue;

  /// The energy efficiency class as defined in EU directive 2010/30/EU.
  core.String energyEfficiencyClass;

  /// The list of destinations to exclude for this target (corresponds to
  /// unchecked check boxes in Merchant Center).
  core.List<core.String> excludedDestinations;

  /// Date on which the item should expire, as specified upon insertion, in ISO
  /// 8601 format. The actual expiration date in Google Shopping is exposed in
  /// productstatuses as googleExpirationDate and might be earlier if
  /// expirationDate is too far in the future.
  core.String expirationDate;

  /// Target gender of the item.
  core.String gender;

  /// Google's category of the item (see Google product taxonomy).
  core.String googleProductCategory;

  /// Global Trade Item Number (GTIN) of the item.
  core.String gtin;

  /// The REST id of the product. Content API methods that operate on products
  /// take this as their productId parameter.
  /// The REST id for a product is of the form
  /// channel:contentLanguage:targetCountry:offerId.
  core.String id;

  /// False when the item does not have unique product identifiers appropriate
  /// to its category, such as GTIN, MPN, and brand. Required according to the
  /// Unique Product Identifier Rules for all target countries except for
  /// Canada.
  core.bool identifierExists;

  /// URL of an image of the item.
  core.String imageLink;

  /// The list of destinations to include for this target (corresponds to
  /// checked check boxes in Merchant Center). Default destinations are always
  /// included unless provided in the excluded_destination field.
  core.List<core.String> includedDestinations;

  /// Number and amount of installments to pay for an item. Brazil only.
  Installment installment;

  /// Whether the item is a merchant-defined bundle. A bundle is a custom
  /// grouping of different products sold by a merchant for a single price.
  core.bool isBundle;

  /// Shared identifier for all variants of the same product.
  core.String itemGroupId;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#product".
  core.String kind;

  /// URL directly linking to your item's page on your website.
  core.String link;

  /// Loyalty points that users receive after purchasing the item. Japan only.
  LoyaltyPoints loyaltyPoints;

  /// The material of which the item is made.
  core.String material;

  /// The energy efficiency class as defined in EU directive 2010/30/EU.
  core.String maxEnergyEfficiencyClass;

  /// Maximal product handling time (in business days).
  core.String maxHandlingTime;

  /// The energy efficiency class as defined in EU directive 2010/30/EU.
  core.String minEnergyEfficiencyClass;

  /// Minimal product handling time (in business days).
  core.String minHandlingTime;

  /// Link to a mobile-optimized version of the landing page.
  core.String mobileLink;

  /// Manufacturer Part Number (MPN) of the item.
  core.String mpn;

  /// The number of identical products in a merchant-defined multipack.
  core.String multipack;

  /// A unique identifier for the item. Leading and trailing whitespaces are
  /// stripped and multiple whitespaces are replaced by a single whitespace upon
  /// submission. Only valid unicode characters are accepted. See the products
  /// feed specification for details.
  /// Note: Content API methods that operate on products take the REST id of the
  /// product, not this identifier.
  core.String offerId;

  /// The item's pattern (e.g. polka dots).
  core.String pattern;

  /// Price of the item.
  Price price;

  /// Categories of the item (formatted as in products feed specification).
  core.List<core.String> productTypes;

  /// The unique ID of a promotion.
  core.List<core.String> promotionIds;

  /// Advertised sale price of the item.
  Price salePrice;

  /// Date range during which the item is on sale (see products feed
  /// specification).
  core.String salePriceEffectiveDate;

  /// The quantity of the product that is available for selling on Google.
  /// Supported only for online products.
  core.String sellOnGoogleQuantity;

  /// Shipping rules.
  core.List<ProductShipping> shipping;

  /// Height of the item for shipping.
  ProductShippingDimension shippingHeight;

  /// The shipping label of the product, used to group product in account-level
  /// shipping rules.
  core.String shippingLabel;

  /// Length of the item for shipping.
  ProductShippingDimension shippingLength;

  /// Weight of the item for shipping.
  ProductShippingWeight shippingWeight;

  /// Width of the item for shipping.
  ProductShippingDimension shippingWidth;

  /// System in which the size is specified. Recommended for apparel items.
  core.String sizeSystem;

  /// The cut of the item. Recommended for apparel items.
  core.String sizeType;

  /// Size of the item.
  core.List<core.String> sizes;

  /// The source of the offer, i.e., how the offer was created.
  core.String source;

  /// The CLDR territory code for the item.
  core.String targetCountry;

  /// Tax information.
  core.List<ProductTax> taxes;

  /// Title of the item.
  core.String title;

  /// The preference of the denominator of the unit price.
  ProductUnitPricingBaseMeasure unitPricingBaseMeasure;

  /// The measure and dimension of an item.
  ProductUnitPricingMeasure unitPricingMeasure;

  Product();

  Product.fromJson(core.Map _json) {
    if (_json.containsKey("additionalImageLinks")) {
      additionalImageLinks =
          (_json["additionalImageLinks"] as core.List).cast<core.String>();
    }
    if (_json.containsKey("adsGrouping")) {
      adsGrouping = _json["adsGrouping"];
    }
    if (_json.containsKey("adsLabels")) {
      adsLabels = (_json["adsLabels"] as core.List).cast<core.String>();
    }
    if (_json.containsKey("adsRedirect")) {
      adsRedirect = _json["adsRedirect"];
    }
    if (_json.containsKey("adult")) {
      adult = _json["adult"];
    }
    if (_json.containsKey("ageGroup")) {
      ageGroup = _json["ageGroup"];
    }
    if (_json.containsKey("availability")) {
      availability = _json["availability"];
    }
    if (_json.containsKey("availabilityDate")) {
      availabilityDate = _json["availabilityDate"];
    }
    if (_json.containsKey("brand")) {
      brand = _json["brand"];
    }
    if (_json.containsKey("channel")) {
      channel = _json["channel"];
    }
    if (_json.containsKey("color")) {
      color = _json["color"];
    }
    if (_json.containsKey("condition")) {
      condition = _json["condition"];
    }
    if (_json.containsKey("contentLanguage")) {
      contentLanguage = _json["contentLanguage"];
    }
    if (_json.containsKey("costOfGoodsSold")) {
      costOfGoodsSold = new Price.fromJson(_json["costOfGoodsSold"]);
    }
    if (_json.containsKey("customAttributes")) {
      customAttributes = (_json["customAttributes"] as core.List)
          .map<CustomAttribute>((value) => new CustomAttribute.fromJson(value))
          .toList();
    }
    if (_json.containsKey("customLabel0")) {
      customLabel0 = _json["customLabel0"];
    }
    if (_json.containsKey("customLabel1")) {
      customLabel1 = _json["customLabel1"];
    }
    if (_json.containsKey("customLabel2")) {
      customLabel2 = _json["customLabel2"];
    }
    if (_json.containsKey("customLabel3")) {
      customLabel3 = _json["customLabel3"];
    }
    if (_json.containsKey("customLabel4")) {
      customLabel4 = _json["customLabel4"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("displayAdsId")) {
      displayAdsId = _json["displayAdsId"];
    }
    if (_json.containsKey("displayAdsLink")) {
      displayAdsLink = _json["displayAdsLink"];
    }
    if (_json.containsKey("displayAdsSimilarIds")) {
      displayAdsSimilarIds =
          (_json["displayAdsSimilarIds"] as core.List).cast<core.String>();
    }
    if (_json.containsKey("displayAdsTitle")) {
      displayAdsTitle = _json["displayAdsTitle"];
    }
    if (_json.containsKey("displayAdsValue")) {
      displayAdsValue = _json["displayAdsValue"].toDouble();
    }
    if (_json.containsKey("energyEfficiencyClass")) {
      energyEfficiencyClass = _json["energyEfficiencyClass"];
    }
    if (_json.containsKey("excludedDestinations")) {
      excludedDestinations =
          (_json["excludedDestinations"] as core.List).cast<core.String>();
    }
    if (_json.containsKey("expirationDate")) {
      expirationDate = _json["expirationDate"];
    }
    if (_json.containsKey("gender")) {
      gender = _json["gender"];
    }
    if (_json.containsKey("googleProductCategory")) {
      googleProductCategory = _json["googleProductCategory"];
    }
    if (_json.containsKey("gtin")) {
      gtin = _json["gtin"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("identifierExists")) {
      identifierExists = _json["identifierExists"];
    }
    if (_json.containsKey("imageLink")) {
      imageLink = _json["imageLink"];
    }
    if (_json.containsKey("includedDestinations")) {
      includedDestinations =
          (_json["includedDestinations"] as core.List).cast<core.String>();
    }
    if (_json.containsKey("installment")) {
      installment = new Installment.fromJson(_json["installment"]);
    }
    if (_json.containsKey("isBundle")) {
      isBundle = _json["isBundle"];
    }
    if (_json.containsKey("itemGroupId")) {
      itemGroupId = _json["itemGroupId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("link")) {
      link = _json["link"];
    }
    if (_json.containsKey("loyaltyPoints")) {
      loyaltyPoints = new LoyaltyPoints.fromJson(_json["loyaltyPoints"]);
    }
    if (_json.containsKey("material")) {
      material = _json["material"];
    }
    if (_json.containsKey("maxEnergyEfficiencyClass")) {
      maxEnergyEfficiencyClass = _json["maxEnergyEfficiencyClass"];
    }
    if (_json.containsKey("maxHandlingTime")) {
      maxHandlingTime = _json["maxHandlingTime"];
    }
    if (_json.containsKey("minEnergyEfficiencyClass")) {
      minEnergyEfficiencyClass = _json["minEnergyEfficiencyClass"];
    }
    if (_json.containsKey("minHandlingTime")) {
      minHandlingTime = _json["minHandlingTime"];
    }
    if (_json.containsKey("mobileLink")) {
      mobileLink = _json["mobileLink"];
    }
    if (_json.containsKey("mpn")) {
      mpn = _json["mpn"];
    }
    if (_json.containsKey("multipack")) {
      multipack = _json["multipack"];
    }
    if (_json.containsKey("offerId")) {
      offerId = _json["offerId"];
    }
    if (_json.containsKey("pattern")) {
      pattern = _json["pattern"];
    }
    if (_json.containsKey("price")) {
      price = new Price.fromJson(_json["price"]);
    }
    if (_json.containsKey("productTypes")) {
      productTypes = (_json["productTypes"] as core.List).cast<core.String>();
    }
    if (_json.containsKey("promotionIds")) {
      promotionIds = (_json["promotionIds"] as core.List).cast<core.String>();
    }
    if (_json.containsKey("salePrice")) {
      salePrice = new Price.fromJson(_json["salePrice"]);
    }
    if (_json.containsKey("salePriceEffectiveDate")) {
      salePriceEffectiveDate = _json["salePriceEffectiveDate"];
    }
    if (_json.containsKey("sellOnGoogleQuantity")) {
      sellOnGoogleQuantity = _json["sellOnGoogleQuantity"];
    }
    if (_json.containsKey("shipping")) {
      shipping = (_json["shipping"] as core.List)
          .map<ProductShipping>((value) => new ProductShipping.fromJson(value))
          .toList();
    }
    if (_json.containsKey("shippingHeight")) {
      shippingHeight =
          new ProductShippingDimension.fromJson(_json["shippingHeight"]);
    }
    if (_json.containsKey("shippingLabel")) {
      shippingLabel = _json["shippingLabel"];
    }
    if (_json.containsKey("shippingLength")) {
      shippingLength =
          new ProductShippingDimension.fromJson(_json["shippingLength"]);
    }
    if (_json.containsKey("shippingWeight")) {
      shippingWeight =
          new ProductShippingWeight.fromJson(_json["shippingWeight"]);
    }
    if (_json.containsKey("shippingWidth")) {
      shippingWidth =
          new ProductShippingDimension.fromJson(_json["shippingWidth"]);
    }
    if (_json.containsKey("sizeSystem")) {
      sizeSystem = _json["sizeSystem"];
    }
    if (_json.containsKey("sizeType")) {
      sizeType = _json["sizeType"];
    }
    if (_json.containsKey("sizes")) {
      sizes = (_json["sizes"] as core.List).cast<core.String>();
    }
    if (_json.containsKey("source")) {
      source = _json["source"];
    }
    if (_json.containsKey("targetCountry")) {
      targetCountry = _json["targetCountry"];
    }
    if (_json.containsKey("taxes")) {
      taxes = (_json["taxes"] as core.List)
          .map<ProductTax>((value) => new ProductTax.fromJson(value))
          .toList();
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("unitPricingBaseMeasure")) {
      unitPricingBaseMeasure = new ProductUnitPricingBaseMeasure.fromJson(
          _json["unitPricingBaseMeasure"]);
    }
    if (_json.containsKey("unitPricingMeasure")) {
      unitPricingMeasure =
          new ProductUnitPricingMeasure.fromJson(_json["unitPricingMeasure"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (additionalImageLinks != null) {
      _json["additionalImageLinks"] = additionalImageLinks;
    }
    if (adsGrouping != null) {
      _json["adsGrouping"] = adsGrouping;
    }
    if (adsLabels != null) {
      _json["adsLabels"] = adsLabels;
    }
    if (adsRedirect != null) {
      _json["adsRedirect"] = adsRedirect;
    }
    if (adult != null) {
      _json["adult"] = adult;
    }
    if (ageGroup != null) {
      _json["ageGroup"] = ageGroup;
    }
    if (availability != null) {
      _json["availability"] = availability;
    }
    if (availabilityDate != null) {
      _json["availabilityDate"] = availabilityDate;
    }
    if (brand != null) {
      _json["brand"] = brand;
    }
    if (channel != null) {
      _json["channel"] = channel;
    }
    if (color != null) {
      _json["color"] = color;
    }
    if (condition != null) {
      _json["condition"] = condition;
    }
    if (contentLanguage != null) {
      _json["contentLanguage"] = contentLanguage;
    }
    if (costOfGoodsSold != null) {
      _json["costOfGoodsSold"] = (costOfGoodsSold).toJson();
    }
    if (customAttributes != null) {
      _json["customAttributes"] =
          customAttributes.map((value) => (value).toJson()).toList();
    }
    if (customLabel0 != null) {
      _json["customLabel0"] = customLabel0;
    }
    if (customLabel1 != null) {
      _json["customLabel1"] = customLabel1;
    }
    if (customLabel2 != null) {
      _json["customLabel2"] = customLabel2;
    }
    if (customLabel3 != null) {
      _json["customLabel3"] = customLabel3;
    }
    if (customLabel4 != null) {
      _json["customLabel4"] = customLabel4;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (displayAdsId != null) {
      _json["displayAdsId"] = displayAdsId;
    }
    if (displayAdsLink != null) {
      _json["displayAdsLink"] = displayAdsLink;
    }
    if (displayAdsSimilarIds != null) {
      _json["displayAdsSimilarIds"] = displayAdsSimilarIds;
    }
    if (displayAdsTitle != null) {
      _json["displayAdsTitle"] = displayAdsTitle;
    }
    if (displayAdsValue != null) {
      _json["displayAdsValue"] = displayAdsValue;
    }
    if (energyEfficiencyClass != null) {
      _json["energyEfficiencyClass"] = energyEfficiencyClass;
    }
    if (excludedDestinations != null) {
      _json["excludedDestinations"] = excludedDestinations;
    }
    if (expirationDate != null) {
      _json["expirationDate"] = expirationDate;
    }
    if (gender != null) {
      _json["gender"] = gender;
    }
    if (googleProductCategory != null) {
      _json["googleProductCategory"] = googleProductCategory;
    }
    if (gtin != null) {
      _json["gtin"] = gtin;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (identifierExists != null) {
      _json["identifierExists"] = identifierExists;
    }
    if (imageLink != null) {
      _json["imageLink"] = imageLink;
    }
    if (includedDestinations != null) {
      _json["includedDestinations"] = includedDestinations;
    }
    if (installment != null) {
      _json["installment"] = (installment).toJson();
    }
    if (isBundle != null) {
      _json["isBundle"] = isBundle;
    }
    if (itemGroupId != null) {
      _json["itemGroupId"] = itemGroupId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (link != null) {
      _json["link"] = link;
    }
    if (loyaltyPoints != null) {
      _json["loyaltyPoints"] = (loyaltyPoints).toJson();
    }
    if (material != null) {
      _json["material"] = material;
    }
    if (maxEnergyEfficiencyClass != null) {
      _json["maxEnergyEfficiencyClass"] = maxEnergyEfficiencyClass;
    }
    if (maxHandlingTime != null) {
      _json["maxHandlingTime"] = maxHandlingTime;
    }
    if (minEnergyEfficiencyClass != null) {
      _json["minEnergyEfficiencyClass"] = minEnergyEfficiencyClass;
    }
    if (minHandlingTime != null) {
      _json["minHandlingTime"] = minHandlingTime;
    }
    if (mobileLink != null) {
      _json["mobileLink"] = mobileLink;
    }
    if (mpn != null) {
      _json["mpn"] = mpn;
    }
    if (multipack != null) {
      _json["multipack"] = multipack;
    }
    if (offerId != null) {
      _json["offerId"] = offerId;
    }
    if (pattern != null) {
      _json["pattern"] = pattern;
    }
    if (price != null) {
      _json["price"] = (price).toJson();
    }
    if (productTypes != null) {
      _json["productTypes"] = productTypes;
    }
    if (promotionIds != null) {
      _json["promotionIds"] = promotionIds;
    }
    if (salePrice != null) {
      _json["salePrice"] = (salePrice).toJson();
    }
    if (salePriceEffectiveDate != null) {
      _json["salePriceEffectiveDate"] = salePriceEffectiveDate;
    }
    if (sellOnGoogleQuantity != null) {
      _json["sellOnGoogleQuantity"] = sellOnGoogleQuantity;
    }
    if (shipping != null) {
      _json["shipping"] = shipping.map((value) => (value).toJson()).toList();
    }
    if (shippingHeight != null) {
      _json["shippingHeight"] = (shippingHeight).toJson();
    }
    if (shippingLabel != null) {
      _json["shippingLabel"] = shippingLabel;
    }
    if (shippingLength != null) {
      _json["shippingLength"] = (shippingLength).toJson();
    }
    if (shippingWeight != null) {
      _json["shippingWeight"] = (shippingWeight).toJson();
    }
    if (shippingWidth != null) {
      _json["shippingWidth"] = (shippingWidth).toJson();
    }
    if (sizeSystem != null) {
      _json["sizeSystem"] = sizeSystem;
    }
    if (sizeType != null) {
      _json["sizeType"] = sizeType;
    }
    if (sizes != null) {
      _json["sizes"] = sizes;
    }
    if (source != null) {
      _json["source"] = source;
    }
    if (targetCountry != null) {
      _json["targetCountry"] = targetCountry;
    }
    if (taxes != null) {
      _json["taxes"] = taxes.map((value) => (value).toJson()).toList();
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (unitPricingBaseMeasure != null) {
      _json["unitPricingBaseMeasure"] = (unitPricingBaseMeasure).toJson();
    }
    if (unitPricingMeasure != null) {
      _json["unitPricingMeasure"] = (unitPricingMeasure).toJson();
    }
    return _json;
  }
}

class ProductAmount {
  /// The pre-tax or post-tax price depending on the location of the order.
  Price priceAmount;

  /// Remitted tax value.
  Price remittedTaxAmount;

  /// Tax value.
  Price taxAmount;

  ProductAmount();

  ProductAmount.fromJson(core.Map _json) {
    if (_json.containsKey("priceAmount")) {
      priceAmount = new Price.fromJson(_json["priceAmount"]);
    }
    if (_json.containsKey("remittedTaxAmount")) {
      remittedTaxAmount = new Price.fromJson(_json["remittedTaxAmount"]);
    }
    if (_json.containsKey("taxAmount")) {
      taxAmount = new Price.fromJson(_json["taxAmount"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (priceAmount != null) {
      _json["priceAmount"] = (priceAmount).toJson();
    }
    if (remittedTaxAmount != null) {
      _json["remittedTaxAmount"] = (remittedTaxAmount).toJson();
    }
    if (taxAmount != null) {
      _json["taxAmount"] = (taxAmount).toJson();
    }
    return _json;
  }
}

class ProductShipping {
  /// The CLDR territory code of the country to which an item will ship.
  core.String country;

  /// The location where the shipping is applicable, represented by a location
  /// group name.
  core.String locationGroupName;

  /// The numeric id of a location that the shipping rate applies to as defined
  /// in the AdWords API.
  core.String locationId;

  /// The postal code range that the shipping rate applies to, represented by a
  /// postal code, a postal code prefix followed by a * wildcard, a range
  /// between two postal codes or two postal code prefixes of equal length.
  core.String postalCode;

  /// Fixed shipping price, represented as a number.
  Price price;

  /// The geographic region to which a shipping rate applies.
  core.String region;

  /// A free-form description of the service class or delivery speed.
  core.String service;

  ProductShipping();

  ProductShipping.fromJson(core.Map _json) {
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("locationGroupName")) {
      locationGroupName = _json["locationGroupName"];
    }
    if (_json.containsKey("locationId")) {
      locationId = _json["locationId"];
    }
    if (_json.containsKey("postalCode")) {
      postalCode = _json["postalCode"];
    }
    if (_json.containsKey("price")) {
      price = new Price.fromJson(_json["price"]);
    }
    if (_json.containsKey("region")) {
      region = _json["region"];
    }
    if (_json.containsKey("service")) {
      service = _json["service"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (country != null) {
      _json["country"] = country;
    }
    if (locationGroupName != null) {
      _json["locationGroupName"] = locationGroupName;
    }
    if (locationId != null) {
      _json["locationId"] = locationId;
    }
    if (postalCode != null) {
      _json["postalCode"] = postalCode;
    }
    if (price != null) {
      _json["price"] = (price).toJson();
    }
    if (region != null) {
      _json["region"] = region;
    }
    if (service != null) {
      _json["service"] = service;
    }
    return _json;
  }
}

class ProductShippingDimension {
  /// The unit of value.
  core.String unit;

  /// The dimension of the product used to calculate the shipping cost of the
  /// item.
  core.double value;

  ProductShippingDimension();

  ProductShippingDimension.fromJson(core.Map _json) {
    if (_json.containsKey("unit")) {
      unit = _json["unit"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"].toDouble();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (unit != null) {
      _json["unit"] = unit;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class ProductShippingWeight {
  /// The unit of value.
  core.String unit;

  /// The weight of the product used to calculate the shipping cost of the item.
  core.double value;

  ProductShippingWeight();

  ProductShippingWeight.fromJson(core.Map _json) {
    if (_json.containsKey("unit")) {
      unit = _json["unit"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"].toDouble();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (unit != null) {
      _json["unit"] = unit;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/// The status of a product, i.e., information about a product computed
/// asynchronously by the data quality analysis.
class ProductStatus {
  /// Date on which the item has been created, in ISO 8601 format.
  core.String creationDate;

  /// The intended destinations for the product.
  core.List<ProductStatusDestinationStatus> destinationStatuses;

  /// Date on which the item expires in Google Shopping, in ISO 8601 format.
  core.String googleExpirationDate;

  /// A list of all issues associated with the product.
  core.List<ProductStatusItemLevelIssue> itemLevelIssues;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#productStatus".
  core.String kind;

  /// Date on which the item has been last updated, in ISO 8601 format.
  core.String lastUpdateDate;

  /// The link to the product.
  core.String link;

  /// The id of the product for which status is reported.
  core.String productId;

  /// The title of the product.
  core.String title;

  ProductStatus();

  ProductStatus.fromJson(core.Map _json) {
    if (_json.containsKey("creationDate")) {
      creationDate = _json["creationDate"];
    }
    if (_json.containsKey("destinationStatuses")) {
      destinationStatuses = (_json["destinationStatuses"] as core.List)
          .map<ProductStatusDestinationStatus>(
              (value) => new ProductStatusDestinationStatus.fromJson(value))
          .toList();
    }
    if (_json.containsKey("googleExpirationDate")) {
      googleExpirationDate = _json["googleExpirationDate"];
    }
    if (_json.containsKey("itemLevelIssues")) {
      itemLevelIssues = (_json["itemLevelIssues"] as core.List)
          .map<ProductStatusItemLevelIssue>(
              (value) => new ProductStatusItemLevelIssue.fromJson(value))
          .toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lastUpdateDate")) {
      lastUpdateDate = _json["lastUpdateDate"];
    }
    if (_json.containsKey("link")) {
      link = _json["link"];
    }
    if (_json.containsKey("productId")) {
      productId = _json["productId"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (creationDate != null) {
      _json["creationDate"] = creationDate;
    }
    if (destinationStatuses != null) {
      _json["destinationStatuses"] =
          destinationStatuses.map((value) => (value).toJson()).toList();
    }
    if (googleExpirationDate != null) {
      _json["googleExpirationDate"] = googleExpirationDate;
    }
    if (itemLevelIssues != null) {
      _json["itemLevelIssues"] =
          itemLevelIssues.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lastUpdateDate != null) {
      _json["lastUpdateDate"] = lastUpdateDate;
    }
    if (link != null) {
      _json["link"] = link;
    }
    if (productId != null) {
      _json["productId"] = productId;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

class ProductStatusDestinationStatus {
  /// The name of the destination
  core.String destination;
  core.String status;

  ProductStatusDestinationStatus();

  ProductStatusDestinationStatus.fromJson(core.Map _json) {
    if (_json.containsKey("destination")) {
      destination = _json["destination"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (destination != null) {
      _json["destination"] = destination;
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

class ProductStatusItemLevelIssue {
  /// The attribute's name, if the issue is caused by a single attribute.
  core.String attributeName;

  /// The error code of the issue.
  core.String code;

  /// A short issue description in English.
  core.String description;

  /// The destination the issue applies to.
  core.String destination;

  /// A detailed issue description in English.
  core.String detail;

  /// The URL of a web page to help with resolving this issue.
  core.String documentation;

  /// Whether the issue can be resolved by the merchant.
  core.String resolution;

  /// How this issue affects serving of the offer.
  core.String servability;

  ProductStatusItemLevelIssue();

  ProductStatusItemLevelIssue.fromJson(core.Map _json) {
    if (_json.containsKey("attributeName")) {
      attributeName = _json["attributeName"];
    }
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("destination")) {
      destination = _json["destination"];
    }
    if (_json.containsKey("detail")) {
      detail = _json["detail"];
    }
    if (_json.containsKey("documentation")) {
      documentation = _json["documentation"];
    }
    if (_json.containsKey("resolution")) {
      resolution = _json["resolution"];
    }
    if (_json.containsKey("servability")) {
      servability = _json["servability"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (attributeName != null) {
      _json["attributeName"] = attributeName;
    }
    if (code != null) {
      _json["code"] = code;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (destination != null) {
      _json["destination"] = destination;
    }
    if (detail != null) {
      _json["detail"] = detail;
    }
    if (documentation != null) {
      _json["documentation"] = documentation;
    }
    if (resolution != null) {
      _json["resolution"] = resolution;
    }
    if (servability != null) {
      _json["servability"] = servability;
    }
    return _json;
  }
}

class ProductTax {
  /// The country within which the item is taxed, specified as a CLDR territory
  /// code.
  core.String country;

  /// The numeric id of a location that the tax rate applies to as defined in
  /// the AdWords API.
  core.String locationId;

  /// The postal code range that the tax rate applies to, represented by a ZIP
  /// code, a ZIP code prefix using * wildcard, a range between two ZIP codes or
  /// two ZIP code prefixes of equal length. Examples: 94114, 94*, 94002-95460,
  /// 94*-95*.
  core.String postalCode;

  /// The percentage of tax rate that applies to the item price.
  core.double rate;

  /// The geographic region to which the tax rate applies.
  core.String region;

  /// Set to true if tax is charged on shipping.
  core.bool taxShip;

  ProductTax();

  ProductTax.fromJson(core.Map _json) {
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("locationId")) {
      locationId = _json["locationId"];
    }
    if (_json.containsKey("postalCode")) {
      postalCode = _json["postalCode"];
    }
    if (_json.containsKey("rate")) {
      rate = _json["rate"].toDouble();
    }
    if (_json.containsKey("region")) {
      region = _json["region"];
    }
    if (_json.containsKey("taxShip")) {
      taxShip = _json["taxShip"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (country != null) {
      _json["country"] = country;
    }
    if (locationId != null) {
      _json["locationId"] = locationId;
    }
    if (postalCode != null) {
      _json["postalCode"] = postalCode;
    }
    if (rate != null) {
      _json["rate"] = rate;
    }
    if (region != null) {
      _json["region"] = region;
    }
    if (taxShip != null) {
      _json["taxShip"] = taxShip;
    }
    return _json;
  }
}

class ProductUnitPricingBaseMeasure {
  /// The unit of the denominator.
  core.String unit;

  /// The denominator of the unit price.
  core.String value;

  ProductUnitPricingBaseMeasure();

  ProductUnitPricingBaseMeasure.fromJson(core.Map _json) {
    if (_json.containsKey("unit")) {
      unit = _json["unit"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (unit != null) {
      _json["unit"] = unit;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class ProductUnitPricingMeasure {
  /// The unit of the measure.
  core.String unit;

  /// The measure of an item.
  core.double value;

  ProductUnitPricingMeasure();

  ProductUnitPricingMeasure.fromJson(core.Map _json) {
    if (_json.containsKey("unit")) {
      unit = _json["unit"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"].toDouble();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (unit != null) {
      _json["unit"] = unit;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class ProductsCustomBatchRequest {
  /// The request entries to be processed in the batch.
  core.List<ProductsCustomBatchRequestEntry> entries;

  ProductsCustomBatchRequest();

  ProductsCustomBatchRequest.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = (_json["entries"] as core.List)
          .map<ProductsCustomBatchRequestEntry>(
              (value) => new ProductsCustomBatchRequestEntry.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// A batch entry encoding a single non-batch products request.
class ProductsCustomBatchRequestEntry {
  /// An entry ID, unique within the batch request.
  core.int batchId;

  /// The ID of the managing account.
  core.String merchantId;
  core.String method;

  /// The product to insert. Only required if the method is insert.
  Product product;

  /// The ID of the product to get or delete. Only defined if the method is get
  /// or delete.
  core.String productId;

  ProductsCustomBatchRequestEntry();

  ProductsCustomBatchRequestEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
    if (_json.containsKey("product")) {
      product = new Product.fromJson(_json["product"]);
    }
    if (_json.containsKey("productId")) {
      productId = _json["productId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (method != null) {
      _json["method"] = method;
    }
    if (product != null) {
      _json["product"] = (product).toJson();
    }
    if (productId != null) {
      _json["productId"] = productId;
    }
    return _json;
  }
}

class ProductsCustomBatchResponse {
  /// The result of the execution of the batch requests.
  core.List<ProductsCustomBatchResponseEntry> entries;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#productsCustomBatchResponse".
  core.String kind;

  ProductsCustomBatchResponse();

  ProductsCustomBatchResponse.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = (_json["entries"] as core.List)
          .map<ProductsCustomBatchResponseEntry>(
              (value) => new ProductsCustomBatchResponseEntry.fromJson(value))
          .toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/// A batch entry encoding a single non-batch products response.
class ProductsCustomBatchResponseEntry {
  /// The ID of the request entry this entry responds to.
  core.int batchId;

  /// A list of errors defined if and only if the request failed.
  Errors errors;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#productsCustomBatchResponseEntry".
  core.String kind;

  /// The inserted product. Only defined if the method is insert and if the
  /// request was successful.
  Product product;

  ProductsCustomBatchResponseEntry();

  ProductsCustomBatchResponseEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("errors")) {
      errors = new Errors.fromJson(_json["errors"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("product")) {
      product = new Product.fromJson(_json["product"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (errors != null) {
      _json["errors"] = (errors).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (product != null) {
      _json["product"] = (product).toJson();
    }
    return _json;
  }
}

class ProductsListResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#productsListResponse".
  core.String kind;

  /// The token for the retrieval of the next page of products.
  core.String nextPageToken;
  core.List<Product> resources;

  ProductsListResponse();

  ProductsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resources")) {
      resources = (_json["resources"] as core.List)
          .map<Product>((value) => new Product.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resources != null) {
      _json["resources"] = resources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class ProductstatusesCustomBatchRequest {
  /// The request entries to be processed in the batch.
  core.List<ProductstatusesCustomBatchRequestEntry> entries;

  ProductstatusesCustomBatchRequest();

  ProductstatusesCustomBatchRequest.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = (_json["entries"] as core.List)
          .map<ProductstatusesCustomBatchRequestEntry>((value) =>
              new ProductstatusesCustomBatchRequestEntry.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// A batch entry encoding a single non-batch productstatuses request.
class ProductstatusesCustomBatchRequestEntry {
  /// An entry ID, unique within the batch request.
  core.int batchId;

  /// If set, only issues for the specified destinations are returned, otherwise
  /// only issues for the Shopping destination.
  core.List<core.String> destinations;
  core.bool includeAttributes;

  /// The ID of the managing account.
  core.String merchantId;
  core.String method;

  /// The ID of the product whose status to get.
  core.String productId;

  ProductstatusesCustomBatchRequestEntry();

  ProductstatusesCustomBatchRequestEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("destinations")) {
      destinations = (_json["destinations"] as core.List).cast<core.String>();
    }
    if (_json.containsKey("includeAttributes")) {
      includeAttributes = _json["includeAttributes"];
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
    if (_json.containsKey("productId")) {
      productId = _json["productId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (destinations != null) {
      _json["destinations"] = destinations;
    }
    if (includeAttributes != null) {
      _json["includeAttributes"] = includeAttributes;
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (method != null) {
      _json["method"] = method;
    }
    if (productId != null) {
      _json["productId"] = productId;
    }
    return _json;
  }
}

class ProductstatusesCustomBatchResponse {
  /// The result of the execution of the batch requests.
  core.List<ProductstatusesCustomBatchResponseEntry> entries;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#productstatusesCustomBatchResponse".
  core.String kind;

  ProductstatusesCustomBatchResponse();

  ProductstatusesCustomBatchResponse.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = (_json["entries"] as core.List)
          .map<ProductstatusesCustomBatchResponseEntry>((value) =>
              new ProductstatusesCustomBatchResponseEntry.fromJson(value))
          .toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/// A batch entry encoding a single non-batch productstatuses response.
class ProductstatusesCustomBatchResponseEntry {
  /// The ID of the request entry this entry responds to.
  core.int batchId;

  /// A list of errors, if the request failed.
  Errors errors;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#productstatusesCustomBatchResponseEntry".
  core.String kind;

  /// The requested product status. Only defined if the request was successful.
  ProductStatus productStatus;

  ProductstatusesCustomBatchResponseEntry();

  ProductstatusesCustomBatchResponseEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("errors")) {
      errors = new Errors.fromJson(_json["errors"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("productStatus")) {
      productStatus = new ProductStatus.fromJson(_json["productStatus"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (errors != null) {
      _json["errors"] = (errors).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (productStatus != null) {
      _json["productStatus"] = (productStatus).toJson();
    }
    return _json;
  }
}

class ProductstatusesListResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#productstatusesListResponse".
  core.String kind;

  /// The token for the retrieval of the next page of products statuses.
  core.String nextPageToken;
  core.List<ProductStatus> resources;

  ProductstatusesListResponse();

  ProductstatusesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resources")) {
      resources = (_json["resources"] as core.List)
          .map<ProductStatus>((value) => new ProductStatus.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resources != null) {
      _json["resources"] = resources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class Promotion {
  /// [required] Amount of the promotion. The values here are the promotion
  /// applied to the unit price pretax and to the total of the tax amounts.
  Amount promotionAmount;

  /// [required] ID of the promotion.
  core.String promotionId;

  Promotion();

  Promotion.fromJson(core.Map _json) {
    if (_json.containsKey("promotionAmount")) {
      promotionAmount = new Amount.fromJson(_json["promotionAmount"]);
    }
    if (_json.containsKey("promotionId")) {
      promotionId = _json["promotionId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (promotionAmount != null) {
      _json["promotionAmount"] = (promotionAmount).toJson();
    }
    if (promotionId != null) {
      _json["promotionId"] = promotionId;
    }
    return _json;
  }
}

class RateGroup {
  /// A list of shipping labels defining the products to which this rate group
  /// applies to. This is a disjunction: only one of the labels has to match for
  /// the rate group to apply. May only be empty for the last rate group of a
  /// service. Required.
  core.List<core.String> applicableShippingLabels;

  /// A list of carrier rates that can be referred to by mainTable or
  /// singleValue.
  core.List<CarrierRate> carrierRates;

  /// A table defining the rate group, when singleValue is not expressive
  /// enough. Can only be set if singleValue is not set.
  Table mainTable;

  /// Name of the rate group. Optional. If set has to be unique within shipping
  /// service.
  core.String name;

  /// The value of the rate group (e.g. flat rate $10). Can only be set if
  /// mainTable and subtables are not set.
  Value singleValue;

  /// A list of subtables referred to by mainTable. Can only be set if mainTable
  /// is set.
  core.List<Table> subtables;

  RateGroup();

  RateGroup.fromJson(core.Map _json) {
    if (_json.containsKey("applicableShippingLabels")) {
      applicableShippingLabels =
          (_json["applicableShippingLabels"] as core.List).cast<core.String>();
    }
    if (_json.containsKey("carrierRates")) {
      carrierRates = (_json["carrierRates"] as core.List)
          .map<CarrierRate>((value) => new CarrierRate.fromJson(value))
          .toList();
    }
    if (_json.containsKey("mainTable")) {
      mainTable = new Table.fromJson(_json["mainTable"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("singleValue")) {
      singleValue = new Value.fromJson(_json["singleValue"]);
    }
    if (_json.containsKey("subtables")) {
      subtables = (_json["subtables"] as core.List)
          .map<Table>((value) => new Table.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (applicableShippingLabels != null) {
      _json["applicableShippingLabels"] = applicableShippingLabels;
    }
    if (carrierRates != null) {
      _json["carrierRates"] =
          carrierRates.map((value) => (value).toJson()).toList();
    }
    if (mainTable != null) {
      _json["mainTable"] = (mainTable).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (singleValue != null) {
      _json["singleValue"] = (singleValue).toJson();
    }
    if (subtables != null) {
      _json["subtables"] = subtables.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class RefundReason {
  core.String description;
  core.String reasonCode;

  RefundReason();

  RefundReason.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("reasonCode")) {
      reasonCode = _json["reasonCode"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (description != null) {
      _json["description"] = description;
    }
    if (reasonCode != null) {
      _json["reasonCode"] = reasonCode;
    }
    return _json;
  }
}

class ReturnShipment {
  core.String creationDate;
  core.String returnMethodType;
  core.String shipmentId;
  core.List<ShipmentTrackingInfo> shipmentTrackingInfos;

  ReturnShipment();

  ReturnShipment.fromJson(core.Map _json) {
    if (_json.containsKey("creationDate")) {
      creationDate = _json["creationDate"];
    }
    if (_json.containsKey("returnMethodType")) {
      returnMethodType = _json["returnMethodType"];
    }
    if (_json.containsKey("shipmentId")) {
      shipmentId = _json["shipmentId"];
    }
    if (_json.containsKey("shipmentTrackingInfos")) {
      shipmentTrackingInfos = (_json["shipmentTrackingInfos"] as core.List)
          .map<ShipmentTrackingInfo>(
              (value) => new ShipmentTrackingInfo.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (creationDate != null) {
      _json["creationDate"] = creationDate;
    }
    if (returnMethodType != null) {
      _json["returnMethodType"] = returnMethodType;
    }
    if (shipmentId != null) {
      _json["shipmentId"] = shipmentId;
    }
    if (shipmentTrackingInfos != null) {
      _json["shipmentTrackingInfos"] =
          shipmentTrackingInfos.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class Row {
  /// The list of cells that constitute the row. Must have the same length as
  /// columnHeaders for two-dimensional tables, a length of 1 for
  /// one-dimensional tables. Required.
  core.List<Value> cells;

  Row();

  Row.fromJson(core.Map _json) {
    if (_json.containsKey("cells")) {
      cells = (_json["cells"] as core.List)
          .map<Value>((value) => new Value.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (cells != null) {
      _json["cells"] = cells.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class Service {
  /// A boolean exposing the active status of the shipping service. Required.
  core.bool active;

  /// The CLDR code of the currency to which this service applies. Must match
  /// that of the prices in rate groups.
  core.String currency;

  /// The CLDR territory code of the country to which the service applies.
  /// Required.
  core.String deliveryCountry;

  /// Time spent in various aspects from order to the delivery of the product.
  /// Required.
  DeliveryTime deliveryTime;

  /// Eligibility for this service.
  core.String eligibility;

  /// Minimum order value for this service. If set, indicates that customers
  /// will have to spend at least this amount. All prices within a service must
  /// have the same currency.
  Price minimumOrderValue;

  /// Free-form name of the service. Must be unique within target account.
  /// Required.
  core.String name;

  /// Shipping rate group definitions. Only the last one is allowed to have an
  /// empty applicableShippingLabels, which means "everything else". The other
  /// applicableShippingLabels must not overlap.
  core.List<RateGroup> rateGroups;

  Service();

  Service.fromJson(core.Map _json) {
    if (_json.containsKey("active")) {
      active = _json["active"];
    }
    if (_json.containsKey("currency")) {
      currency = _json["currency"];
    }
    if (_json.containsKey("deliveryCountry")) {
      deliveryCountry = _json["deliveryCountry"];
    }
    if (_json.containsKey("deliveryTime")) {
      deliveryTime = new DeliveryTime.fromJson(_json["deliveryTime"]);
    }
    if (_json.containsKey("eligibility")) {
      eligibility = _json["eligibility"];
    }
    if (_json.containsKey("minimumOrderValue")) {
      minimumOrderValue = new Price.fromJson(_json["minimumOrderValue"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("rateGroups")) {
      rateGroups = (_json["rateGroups"] as core.List)
          .map<RateGroup>((value) => new RateGroup.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (active != null) {
      _json["active"] = active;
    }
    if (currency != null) {
      _json["currency"] = currency;
    }
    if (deliveryCountry != null) {
      _json["deliveryCountry"] = deliveryCountry;
    }
    if (deliveryTime != null) {
      _json["deliveryTime"] = (deliveryTime).toJson();
    }
    if (eligibility != null) {
      _json["eligibility"] = eligibility;
    }
    if (minimumOrderValue != null) {
      _json["minimumOrderValue"] = (minimumOrderValue).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (rateGroups != null) {
      _json["rateGroups"] =
          rateGroups.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class ShipmentInvoice {
  /// [required] Invoice summary.
  InvoiceSummary invoiceSummary;

  /// [required] Invoice details per line item.
  core.List<ShipmentInvoiceLineItemInvoice> lineItemInvoices;

  /// [required] ID of the shipment group.
  core.String shipmentGroupId;

  ShipmentInvoice();

  ShipmentInvoice.fromJson(core.Map _json) {
    if (_json.containsKey("invoiceSummary")) {
      invoiceSummary = new InvoiceSummary.fromJson(_json["invoiceSummary"]);
    }
    if (_json.containsKey("lineItemInvoices")) {
      lineItemInvoices = (_json["lineItemInvoices"] as core.List)
          .map<ShipmentInvoiceLineItemInvoice>(
              (value) => new ShipmentInvoiceLineItemInvoice.fromJson(value))
          .toList();
    }
    if (_json.containsKey("shipmentGroupId")) {
      shipmentGroupId = _json["shipmentGroupId"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (invoiceSummary != null) {
      _json["invoiceSummary"] = (invoiceSummary).toJson();
    }
    if (lineItemInvoices != null) {
      _json["lineItemInvoices"] =
          lineItemInvoices.map((value) => (value).toJson()).toList();
    }
    if (shipmentGroupId != null) {
      _json["shipmentGroupId"] = shipmentGroupId;
    }
    return _json;
  }
}

class ShipmentInvoiceLineItemInvoice {
  /// ID of the line item. Either lineItemId or productId must be set.
  core.String lineItemId;

  /// ID of the product. This is the REST ID used in the products service.
  /// Either lineItemId or productId must be set.
  core.String productId;

  /// [required] Unit IDs to define specific units within the line item.
  core.List<core.String> shipmentUnitIds;

  /// [required] Invoice details for a single unit.
  UnitInvoice unitInvoice;

  ShipmentInvoiceLineItemInvoice();

  ShipmentInvoiceLineItemInvoice.fromJson(core.Map _json) {
    if (_json.containsKey("lineItemId")) {
      lineItemId = _json["lineItemId"];
    }
    if (_json.containsKey("productId")) {
      productId = _json["productId"];
    }
    if (_json.containsKey("shipmentUnitIds")) {
      shipmentUnitIds =
          (_json["shipmentUnitIds"] as core.List).cast<core.String>();
    }
    if (_json.containsKey("unitInvoice")) {
      unitInvoice = new UnitInvoice.fromJson(_json["unitInvoice"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (lineItemId != null) {
      _json["lineItemId"] = lineItemId;
    }
    if (productId != null) {
      _json["productId"] = productId;
    }
    if (shipmentUnitIds != null) {
      _json["shipmentUnitIds"] = shipmentUnitIds;
    }
    if (unitInvoice != null) {
      _json["unitInvoice"] = (unitInvoice).toJson();
    }
    return _json;
  }
}

class ShipmentTrackingInfo {
  core.String carrier;
  core.String trackingNumber;

  ShipmentTrackingInfo();

  ShipmentTrackingInfo.fromJson(core.Map _json) {
    if (_json.containsKey("carrier")) {
      carrier = _json["carrier"];
    }
    if (_json.containsKey("trackingNumber")) {
      trackingNumber = _json["trackingNumber"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (carrier != null) {
      _json["carrier"] = carrier;
    }
    if (trackingNumber != null) {
      _json["trackingNumber"] = trackingNumber;
    }
    return _json;
  }
}

/// The merchant account's shipping settings. All methods except
/// getsupportedcarriers and getsupportedholidays require the admin role.
class ShippingSettings {
  /// The ID of the account to which these account shipping settings belong.
  /// Ignored upon update, always present in get request responses.
  core.String accountId;

  /// A list of postal code groups that can be referred to in services.
  /// Optional.
  core.List<PostalCodeGroup> postalCodeGroups;

  /// The target account's list of services. Optional.
  core.List<Service> services;

  ShippingSettings();

  ShippingSettings.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("postalCodeGroups")) {
      postalCodeGroups = (_json["postalCodeGroups"] as core.List)
          .map<PostalCodeGroup>((value) => new PostalCodeGroup.fromJson(value))
          .toList();
    }
    if (_json.containsKey("services")) {
      services = (_json["services"] as core.List)
          .map<Service>((value) => new Service.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (postalCodeGroups != null) {
      _json["postalCodeGroups"] =
          postalCodeGroups.map((value) => (value).toJson()).toList();
    }
    if (services != null) {
      _json["services"] = services.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class ShippingsettingsCustomBatchRequest {
  /// The request entries to be processed in the batch.
  core.List<ShippingsettingsCustomBatchRequestEntry> entries;

  ShippingsettingsCustomBatchRequest();

  ShippingsettingsCustomBatchRequest.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = (_json["entries"] as core.List)
          .map<ShippingsettingsCustomBatchRequestEntry>((value) =>
              new ShippingsettingsCustomBatchRequestEntry.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/// A batch entry encoding a single non-batch shippingsettings request.
class ShippingsettingsCustomBatchRequestEntry {
  /// The ID of the account for which to get/update account shipping settings.
  core.String accountId;

  /// An entry ID, unique within the batch request.
  core.int batchId;

  /// The ID of the managing account.
  core.String merchantId;
  core.String method;

  /// The account shipping settings to update. Only defined if the method is
  /// update.
  ShippingSettings shippingSettings;

  ShippingsettingsCustomBatchRequestEntry();

  ShippingsettingsCustomBatchRequestEntry.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("merchantId")) {
      merchantId = _json["merchantId"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
    if (_json.containsKey("shippingSettings")) {
      shippingSettings =
          new ShippingSettings.fromJson(_json["shippingSettings"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (merchantId != null) {
      _json["merchantId"] = merchantId;
    }
    if (method != null) {
      _json["method"] = method;
    }
    if (shippingSettings != null) {
      _json["shippingSettings"] = (shippingSettings).toJson();
    }
    return _json;
  }
}

class ShippingsettingsCustomBatchResponse {
  /// The result of the execution of the batch requests.
  core.List<ShippingsettingsCustomBatchResponseEntry> entries;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#shippingsettingsCustomBatchResponse".
  core.String kind;

  ShippingsettingsCustomBatchResponse();

  ShippingsettingsCustomBatchResponse.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = (_json["entries"] as core.List)
          .map<ShippingsettingsCustomBatchResponseEntry>((value) =>
              new ShippingsettingsCustomBatchResponseEntry.fromJson(value))
          .toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/// A batch entry encoding a single non-batch shipping settings response.
class ShippingsettingsCustomBatchResponseEntry {
  /// The ID of the request entry to which this entry responds.
  core.int batchId;

  /// A list of errors defined if, and only if, the request failed.
  Errors errors;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#shippingsettingsCustomBatchResponseEntry".
  core.String kind;

  /// The retrieved or updated account shipping settings.
  ShippingSettings shippingSettings;

  ShippingsettingsCustomBatchResponseEntry();

  ShippingsettingsCustomBatchResponseEntry.fromJson(core.Map _json) {
    if (_json.containsKey("batchId")) {
      batchId = _json["batchId"];
    }
    if (_json.containsKey("errors")) {
      errors = new Errors.fromJson(_json["errors"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("shippingSettings")) {
      shippingSettings =
          new ShippingSettings.fromJson(_json["shippingSettings"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (batchId != null) {
      _json["batchId"] = batchId;
    }
    if (errors != null) {
      _json["errors"] = (errors).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (shippingSettings != null) {
      _json["shippingSettings"] = (shippingSettings).toJson();
    }
    return _json;
  }
}

class ShippingsettingsGetSupportedCarriersResponse {
  /// A list of supported carriers. May be empty.
  core.List<CarriersCarrier> carriers;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#shippingsettingsGetSupportedCarriersResponse".
  core.String kind;

  ShippingsettingsGetSupportedCarriersResponse();

  ShippingsettingsGetSupportedCarriersResponse.fromJson(core.Map _json) {
    if (_json.containsKey("carriers")) {
      carriers = (_json["carriers"] as core.List)
          .map<CarriersCarrier>((value) => new CarriersCarrier.fromJson(value))
          .toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (carriers != null) {
      _json["carriers"] = carriers.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class ShippingsettingsGetSupportedHolidaysResponse {
  /// A list of holidays applicable for delivery guarantees. May be empty.
  core.List<HolidaysHoliday> holidays;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#shippingsettingsGetSupportedHolidaysResponse".
  core.String kind;

  ShippingsettingsGetSupportedHolidaysResponse();

  ShippingsettingsGetSupportedHolidaysResponse.fromJson(core.Map _json) {
    if (_json.containsKey("holidays")) {
      holidays = (_json["holidays"] as core.List)
          .map<HolidaysHoliday>((value) => new HolidaysHoliday.fromJson(value))
          .toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (holidays != null) {
      _json["holidays"] = holidays.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class ShippingsettingsListResponse {
  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#shippingsettingsListResponse".
  core.String kind;

  /// The token for the retrieval of the next page of shipping settings.
  core.String nextPageToken;
  core.List<ShippingSettings> resources;

  ShippingsettingsListResponse();

  ShippingsettingsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("resources")) {
      resources = (_json["resources"] as core.List)
          .map<ShippingSettings>(
              (value) => new ShippingSettings.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (resources != null) {
      _json["resources"] = resources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class Table {
  /// Headers of the table's columns. Optional: if not set then the table has
  /// only one dimension.
  Headers columnHeaders;

  /// Name of the table. Required for subtables, ignored for the main table.
  core.String name;

  /// Headers of the table's rows. Required.
  Headers rowHeaders;

  /// The list of rows that constitute the table. Must have the same length as
  /// rowHeaders. Required.
  core.List<Row> rows;

  Table();

  Table.fromJson(core.Map _json) {
    if (_json.containsKey("columnHeaders")) {
      columnHeaders = new Headers.fromJson(_json["columnHeaders"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("rowHeaders")) {
      rowHeaders = new Headers.fromJson(_json["rowHeaders"]);
    }
    if (_json.containsKey("rows")) {
      rows = (_json["rows"] as core.List)
          .map<Row>((value) => new Row.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (columnHeaders != null) {
      _json["columnHeaders"] = (columnHeaders).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (rowHeaders != null) {
      _json["rowHeaders"] = (rowHeaders).toJson();
    }
    if (rows != null) {
      _json["rows"] = rows.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class TestOrder {
  /// The details of the customer who placed the order.
  TestOrderCustomer customer;

  /// Whether the orderinvoices service should support this order.
  core.bool enableOrderinvoices;

  /// Identifies what kind of resource this is. Value: the fixed string
  /// "content#testOrder".
  core.String kind;

  /// Line items that are ordered. At least one line item must be provided.
  core.List<TestOrderLineItem> lineItems;

  /// Determines if test order must be pulled by merchant or pushed to merchant
  /// via push integration.
  core.String notificationMode;

  /// The billing address.
  core.String predefinedBillingAddress;

  /// Identifier of one of the predefined delivery addresses for the delivery.
  core.String predefinedDeliveryAddress;

  /// Promotions associated with the order.
  core.List<OrderPromotion> promotions;

  /// The total cost of shipping for all items.
  Price shippingCost;

  /// The tax for the total shipping cost.
  Price shippingCostTax;

  /// The requested shipping option.
  core.String shippingOption;

  TestOrder();

  TestOrder.fromJson(core.Map _json) {
    if (_json.containsKey("customer")) {
      customer = new TestOrderCustomer.fromJson(_json["customer"]);
    }
    if (_json.containsKey("enableOrderinvoices")) {
      enableOrderinvoices = _json["enableOrderinvoices"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lineItems")) {
      lineItems = (_json["lineItems"] as core.List)
          .map<TestOrderLineItem>(
              (value) => new TestOrderLineItem.fromJson(value))
          .toList();
    }
    if (_json.containsKey("notificationMode")) {
      notificationMode = _json["notificationMode"];
    }
    if (_json.containsKey("predefinedBillingAddress")) {
      predefinedBillingAddress = _json["predefinedBillingAddress"];
    }
    if (_json.containsKey("predefinedDeliveryAddress")) {
      predefinedDeliveryAddress = _json["predefinedDeliveryAddress"];
    }
    if (_json.containsKey("promotions")) {
      promotions = (_json["promotions"] as core.List)
          .map<OrderPromotion>((value) => new OrderPromotion.fromJson(value))
          .toList();
    }
    if (_json.containsKey("shippingCost")) {
      shippingCost = new Price.fromJson(_json["shippingCost"]);
    }
    if (_json.containsKey("shippingCostTax")) {
      shippingCostTax = new Price.fromJson(_json["shippingCostTax"]);
    }
    if (_json.containsKey("shippingOption")) {
      shippingOption = _json["shippingOption"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (customer != null) {
      _json["customer"] = (customer).toJson();
    }
    if (enableOrderinvoices != null) {
      _json["enableOrderinvoices"] = enableOrderinvoices;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lineItems != null) {
      _json["lineItems"] = lineItems.map((value) => (value).toJson()).toList();
    }
    if (notificationMode != null) {
      _json["notificationMode"] = notificationMode;
    }
    if (predefinedBillingAddress != null) {
      _json["predefinedBillingAddress"] = predefinedBillingAddress;
    }
    if (predefinedDeliveryAddress != null) {
      _json["predefinedDeliveryAddress"] = predefinedDeliveryAddress;
    }
    if (promotions != null) {
      _json["promotions"] =
          promotions.map((value) => (value).toJson()).toList();
    }
    if (shippingCost != null) {
      _json["shippingCost"] = (shippingCost).toJson();
    }
    if (shippingCostTax != null) {
      _json["shippingCostTax"] = (shippingCostTax).toJson();
    }
    if (shippingOption != null) {
      _json["shippingOption"] = shippingOption;
    }
    return _json;
  }
}

class TestOrderCustomer {
  /// Deprecated.
  core.String email;

  /// Full name of the customer.
  core.String fullName;

  /// Customer's marketing preferences.
  TestOrderCustomerMarketingRightsInfo marketingRightsInfo;

  TestOrderCustomer();

  TestOrderCustomer.fromJson(core.Map _json) {
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("fullName")) {
      fullName = _json["fullName"];
    }
    if (_json.containsKey("marketingRightsInfo")) {
      marketingRightsInfo = new TestOrderCustomerMarketingRightsInfo.fromJson(
          _json["marketingRightsInfo"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (email != null) {
      _json["email"] = email;
    }
    if (fullName != null) {
      _json["fullName"] = fullName;
    }
    if (marketingRightsInfo != null) {
      _json["marketingRightsInfo"] = (marketingRightsInfo).toJson();
    }
    return _json;
  }
}

class TestOrderCustomerMarketingRightsInfo {
  /// Last know user use selection regards marketing preferences. In certain
  /// cases selection might not be known, so this field would be empty.
  core.String explicitMarketingPreference;

  /// Timestamp when last time marketing preference was updated. Could be empty,
  /// if user wasn't offered a selection yet.
  core.String lastUpdatedTimestamp;

  TestOrderCustomerMarketingRightsInfo();

  TestOrderCustomerMarketingRightsInfo.fromJson(core.Map _json) {
    if (_json.containsKey("explicitMarketingPreference")) {
      explicitMarketingPreference = _json["explicitMarketingPreference"];
    }
    if (_json.containsKey("lastUpdatedTimestamp")) {
      lastUpdatedTimestamp = _json["lastUpdatedTimestamp"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (explicitMarketingPreference != null) {
      _json["explicitMarketingPreference"] = explicitMarketingPreference;
    }
    if (lastUpdatedTimestamp != null) {
      _json["lastUpdatedTimestamp"] = lastUpdatedTimestamp;
    }
    return _json;
  }
}

class TestOrderLineItem {
  /// Product data from the time of the order placement.
  TestOrderLineItemProduct product;

  /// Number of items ordered.
  core.int quantityOrdered;

  /// Details of the return policy for the line item.
  OrderLineItemReturnInfo returnInfo;

  /// Details of the requested shipping for the line item.
  OrderLineItemShippingDetails shippingDetails;

  /// Unit tax for the line item.
  Price unitTax;

  TestOrderLineItem();

  TestOrderLineItem.fromJson(core.Map _json) {
    if (_json.containsKey("product")) {
      product = new TestOrderLineItemProduct.fromJson(_json["product"]);
    }
    if (_json.containsKey("quantityOrdered")) {
      quantityOrdered = _json["quantityOrdered"];
    }
    if (_json.containsKey("returnInfo")) {
      returnInfo = new OrderLineItemReturnInfo.fromJson(_json["returnInfo"]);
    }
    if (_json.containsKey("shippingDetails")) {
      shippingDetails =
          new OrderLineItemShippingDetails.fromJson(_json["shippingDetails"]);
    }
    if (_json.containsKey("unitTax")) {
      unitTax = new Price.fromJson(_json["unitTax"]);
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (product != null) {
      _json["product"] = (product).toJson();
    }
    if (quantityOrdered != null) {
      _json["quantityOrdered"] = quantityOrdered;
    }
    if (returnInfo != null) {
      _json["returnInfo"] = (returnInfo).toJson();
    }
    if (shippingDetails != null) {
      _json["shippingDetails"] = (shippingDetails).toJson();
    }
    if (unitTax != null) {
      _json["unitTax"] = (unitTax).toJson();
    }
    return _json;
  }
}

class TestOrderLineItemProduct {
  /// Brand of the item.
  core.String brand;

  /// The item's channel.
  core.String channel;

  /// Condition or state of the item.
  core.String condition;

  /// The two-letter ISO 639-1 language code for the item.
  core.String contentLanguage;

  /// Global Trade Item Number (GTIN) of the item. Optional.
  core.String gtin;

  /// URL of an image of the item.
  core.String imageLink;

  /// Shared identifier for all variants of the same product. Optional.
  core.String itemGroupId;

  /// Manufacturer Part Number (MPN) of the item. Optional.
  core.String mpn;

  /// An identifier of the item.
  core.String offerId;

  /// The price for the product.
  Price price;

  /// The CLDR territory code of the target country of the product.
  core.String targetCountry;

  /// The title of the product.
  core.String title;

  /// Variant attributes for the item. Optional.
  core.List<OrderLineItemProductVariantAttribute> variantAttributes;

  TestOrderLineItemProduct();

  TestOrderLineItemProduct.fromJson(core.Map _json) {
    if (_json.containsKey("brand")) {
      brand = _json["brand"];
    }
    if (_json.containsKey("channel")) {
      channel = _json["channel"];
    }
    if (_json.containsKey("condition")) {
      condition = _json["condition"];
    }
    if (_json.containsKey("contentLanguage")) {
      contentLanguage = _json["contentLanguage"];
    }
    if (_json.containsKey("gtin")) {
      gtin = _json["gtin"];
    }
    if (_json.containsKey("imageLink")) {
      imageLink = _json["imageLink"];
    }
    if (_json.containsKey("itemGroupId")) {
      itemGroupId = _json["itemGroupId"];
    }
    if (_json.containsKey("mpn")) {
      mpn = _json["mpn"];
    }
    if (_json.containsKey("offerId")) {
      offerId = _json["offerId"];
    }
    if (_json.containsKey("price")) {
      price = new Price.fromJson(_json["price"]);
    }
    if (_json.containsKey("targetCountry")) {
      targetCountry = _json["targetCountry"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("variantAttributes")) {
      variantAttributes = (_json["variantAttributes"] as core.List)
          .map<OrderLineItemProductVariantAttribute>((value) =>
              new OrderLineItemProductVariantAttribute.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (brand != null) {
      _json["brand"] = brand;
    }
    if (channel != null) {
      _json["channel"] = channel;
    }
    if (condition != null) {
      _json["condition"] = condition;
    }
    if (contentLanguage != null) {
      _json["contentLanguage"] = contentLanguage;
    }
    if (gtin != null) {
      _json["gtin"] = gtin;
    }
    if (imageLink != null) {
      _json["imageLink"] = imageLink;
    }
    if (itemGroupId != null) {
      _json["itemGroupId"] = itemGroupId;
    }
    if (mpn != null) {
      _json["mpn"] = mpn;
    }
    if (offerId != null) {
      _json["offerId"] = offerId;
    }
    if (price != null) {
      _json["price"] = (price).toJson();
    }
    if (targetCountry != null) {
      _json["targetCountry"] = targetCountry;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (variantAttributes != null) {
      _json["variantAttributes"] =
          variantAttributes.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class UnitInvoice {
  /// Additional charges for a unit, e.g. shipping costs.
  core.List<UnitInvoiceAdditionalCharge> additionalCharges;

  /// Promotions applied to a unit.
  core.List<Promotion> promotions;

  /// [required] Price of the unit, before applying taxes.
  Price unitPricePretax;

  /// Tax amounts to apply to the unit price.
  core.List<UnitInvoiceTaxLine> unitPriceTaxes;

  UnitInvoice();

  UnitInvoice.fromJson(core.Map _json) {
    if (_json.containsKey("additionalCharges")) {
      additionalCharges = (_json["additionalCharges"] as core.List)
          .map<UnitInvoiceAdditionalCharge>(
              (value) => new UnitInvoiceAdditionalCharge.fromJson(value))
          .toList();
    }
    if (_json.containsKey("promotions")) {
      promotions = (_json["promotions"] as core.List)
          .map<Promotion>((value) => new Promotion.fromJson(value))
          .toList();
    }
    if (_json.containsKey("unitPricePretax")) {
      unitPricePretax = new Price.fromJson(_json["unitPricePretax"]);
    }
    if (_json.containsKey("unitPriceTaxes")) {
      unitPriceTaxes = (_json["unitPriceTaxes"] as core.List)
          .map<UnitInvoiceTaxLine>(
              (value) => new UnitInvoiceTaxLine.fromJson(value))
          .toList();
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (additionalCharges != null) {
      _json["additionalCharges"] =
          additionalCharges.map((value) => (value).toJson()).toList();
    }
    if (promotions != null) {
      _json["promotions"] =
          promotions.map((value) => (value).toJson()).toList();
    }
    if (unitPricePretax != null) {
      _json["unitPricePretax"] = (unitPricePretax).toJson();
    }
    if (unitPriceTaxes != null) {
      _json["unitPriceTaxes"] =
          unitPriceTaxes.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class UnitInvoiceAdditionalCharge {
  /// [required] Amount of the additional charge.
  Amount additionalChargeAmount;

  /// Promotions applied to the additional charge.
  core.List<Promotion> additionalChargePromotions;

  /// [required] Type of the additional charge.
  core.String type;

  UnitInvoiceAdditionalCharge();

  UnitInvoiceAdditionalCharge.fromJson(core.Map _json) {
    if (_json.containsKey("additionalChargeAmount")) {
      additionalChargeAmount =
          new Amount.fromJson(_json["additionalChargeAmount"]);
    }
    if (_json.containsKey("additionalChargePromotions")) {
      additionalChargePromotions =
          (_json["additionalChargePromotions"] as core.List)
              .map<Promotion>((value) => new Promotion.fromJson(value))
              .toList();
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (additionalChargeAmount != null) {
      _json["additionalChargeAmount"] = (additionalChargeAmount).toJson();
    }
    if (additionalChargePromotions != null) {
      _json["additionalChargePromotions"] =
          additionalChargePromotions.map((value) => (value).toJson()).toList();
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class UnitInvoiceTaxLine {
  /// [required] Tax amount for the tax type.
  Price taxAmount;

  /// Optional name of the tax type. This should only be provided if taxType is
  /// otherFeeTax.
  core.String taxName;

  /// [required] Type of the tax.
  core.String taxType;

  UnitInvoiceTaxLine();

  UnitInvoiceTaxLine.fromJson(core.Map _json) {
    if (_json.containsKey("taxAmount")) {
      taxAmount = new Price.fromJson(_json["taxAmount"]);
    }
    if (_json.containsKey("taxName")) {
      taxName = _json["taxName"];
    }
    if (_json.containsKey("taxType")) {
      taxType = _json["taxType"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (taxAmount != null) {
      _json["taxAmount"] = (taxAmount).toJson();
    }
    if (taxName != null) {
      _json["taxName"] = taxName;
    }
    if (taxType != null) {
      _json["taxType"] = taxType;
    }
    return _json;
  }
}

/// The single value of a rate group or the value of a rate group table's cell.
/// Exactly one of noShipping, flatRate, pricePercentage, carrierRateName,
/// subtableName must be set.
class Value {
  /// The name of a carrier rate referring to a carrier rate defined in the same
  /// rate group. Can only be set if all other fields are not set.
  core.String carrierRateName;

  /// A flat rate. Can only be set if all other fields are not set.
  Price flatRate;

  /// If true, then the product can't ship. Must be true when set, can only be
  /// set if all other fields are not set.
  core.bool noShipping;

  /// A percentage of the price represented as a number in decimal notation
  /// (e.g., "5.4"). Can only be set if all other fields are not set.
  core.String pricePercentage;

  /// The name of a subtable. Can only be set in table cells (i.e., not for
  /// single values), and only if all other fields are not set.
  core.String subtableName;

  Value();

  Value.fromJson(core.Map _json) {
    if (_json.containsKey("carrierRateName")) {
      carrierRateName = _json["carrierRateName"];
    }
    if (_json.containsKey("flatRate")) {
      flatRate = new Price.fromJson(_json["flatRate"]);
    }
    if (_json.containsKey("noShipping")) {
      noShipping = _json["noShipping"];
    }
    if (_json.containsKey("pricePercentage")) {
      pricePercentage = _json["pricePercentage"];
    }
    if (_json.containsKey("subtableName")) {
      subtableName = _json["subtableName"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (carrierRateName != null) {
      _json["carrierRateName"] = carrierRateName;
    }
    if (flatRate != null) {
      _json["flatRate"] = (flatRate).toJson();
    }
    if (noShipping != null) {
      _json["noShipping"] = noShipping;
    }
    if (pricePercentage != null) {
      _json["pricePercentage"] = pricePercentage;
    }
    if (subtableName != null) {
      _json["subtableName"] = subtableName;
    }
    return _json;
  }
}

class Weight {
  /// The weight unit.
  core.String unit;

  /// The weight represented as a number.
  core.String value;

  Weight();

  Weight.fromJson(core.Map _json) {
    if (_json.containsKey("unit")) {
      unit = _json["unit"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map<core.String, core.Object> toJson() {
    final core.Map<core.String, core.Object> _json =
        new core.Map<core.String, core.Object>();
    if (unit != null) {
      _json["unit"] = unit;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}
