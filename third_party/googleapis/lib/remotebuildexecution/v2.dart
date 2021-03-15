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

/// Remote Build Execution API - v2
///
/// Supplies a Remote Execution API service for tools such as bazel.
///
/// For more information, see
/// <https://cloud.google.com/remote-build-execution/docs/>
///
/// Create an instance of [RemoteBuildExecutionApi] to access these resources:
///
/// - [ActionResultsResource]
/// - [ActionsResource]
/// - [BlobsResource]
/// - [OperationsResource]
/// - [V2Resource]
library remotebuildexecution.v2;

import 'dart:async' as async;
import 'dart:convert' as convert;
import 'dart:core' as core;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

import '../src/user_agent.dart';

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

/// Supplies a Remote Execution API service for tools such as bazel.
class RemoteBuildExecutionApi {
  /// View and manage your data across Google Cloud Platform services
  static const cloudPlatformScope =
      'https://www.googleapis.com/auth/cloud-platform';

  final commons.ApiRequester _requester;

  ActionResultsResource get actionResults => ActionResultsResource(_requester);
  ActionsResource get actions => ActionsResource(_requester);
  BlobsResource get blobs => BlobsResource(_requester);
  OperationsResource get operations => OperationsResource(_requester);
  V2Resource get v2 => V2Resource(_requester);

  RemoteBuildExecutionApi(http.Client client,
      {core.String rootUrl = 'https://remotebuildexecution.googleapis.com/',
      core.String servicePath = ''})
      : _requester =
            commons.ApiRequester(client, rootUrl, servicePath, requestHeaders);
}

class ActionResultsResource {
  final commons.ApiRequester _requester;

  ActionResultsResource(commons.ApiRequester client) : _requester = client;

  /// Retrieve a cached execution result.
  ///
  /// Implementations SHOULD ensure that any blobs referenced from the
  /// ContentAddressableStorage are available at the time of returning the
  /// ActionResult and will be for some period of time afterwards. The lifetimes
  /// of the referenced blobs SHOULD be increased if necessary and applicable.
  /// Errors: * `NOT_FOUND`: The requested `ActionResult` is not in the cache.
  ///
  /// Request parameters:
  ///
  /// [instanceName] - The instance of the execution system to operate against.
  /// A server may support multiple instances of the execution system (with
  /// their own workers, storage, caches, etc.). The server MAY require use of
  /// this field to select between them in an implementation-defined fashion,
  /// otherwise it can be omitted.
  /// Value must have pattern `^.*$`.
  ///
  /// [hash] - The hash. In the case of SHA-256, it will always be a lowercase
  /// hex string exactly 64 characters long.
  ///
  /// [sizeBytes] - The size of the blob, in bytes.
  ///
  /// [inlineOutputFiles] - A hint to the server to inline the contents of the
  /// listed output files. Each path needs to exactly match one file path in
  /// either `output_paths` or `output_files` (DEPRECATED since v2.1) in the
  /// Command message.
  ///
  /// [inlineStderr] - A hint to the server to request inlining stderr in the
  /// ActionResult message.
  ///
  /// [inlineStdout] - A hint to the server to request inlining stdout in the
  /// ActionResult message.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [BuildBazelRemoteExecutionV2ActionResult].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<BuildBazelRemoteExecutionV2ActionResult> get(
    core.String instanceName,
    core.String hash,
    core.String sizeBytes, {
    core.List<core.String>? inlineOutputFiles,
    core.bool? inlineStderr,
    core.bool? inlineStdout,
    core.String? $fields,
  }) async {
    final _queryParams = <core.String, core.List<core.String>>{
      if (inlineOutputFiles != null) 'inlineOutputFiles': inlineOutputFiles,
      if (inlineStderr != null) 'inlineStderr': ['${inlineStderr}'],
      if (inlineStdout != null) 'inlineStdout': ['${inlineStdout}'],
      if ($fields != null) 'fields': [$fields],
    };

    final _url = 'v2/' +
        core.Uri.encodeFull('$instanceName') +
        '/actionResults/' +
        commons.escapeVariable('$hash') +
        '/' +
        commons.escapeVariable('$sizeBytes');

    final _response = await _requester.request(
      _url,
      'GET',
      queryParams: _queryParams,
    );
    return BuildBazelRemoteExecutionV2ActionResult.fromJson(
        _response as core.Map<core.String, core.dynamic>);
  }

  /// Upload a new execution result.
  ///
  /// In order to allow the server to perform access control based on the type
  /// of action, and to assist with client debugging, the client MUST first
  /// upload the Action that produced the result, along with its Command, into
  /// the `ContentAddressableStorage`. Server implementations MAY modify the
  /// `UpdateActionResultRequest.action_result` and return an equivalent value.
  /// Errors: * `INVALID_ARGUMENT`: One or more arguments are invalid. *
  /// `FAILED_PRECONDITION`: One or more errors occurred in updating the action
  /// result, such as a missing command or action. * `RESOURCE_EXHAUSTED`: There
  /// is insufficient storage space to add the entry to the cache.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [instanceName] - The instance of the execution system to operate against.
  /// A server may support multiple instances of the execution system (with
  /// their own workers, storage, caches, etc.). The server MAY require use of
  /// this field to select between them in an implementation-defined fashion,
  /// otherwise it can be omitted.
  /// Value must have pattern `^.*$`.
  ///
  /// [hash] - The hash. In the case of SHA-256, it will always be a lowercase
  /// hex string exactly 64 characters long.
  ///
  /// [sizeBytes] - The size of the blob, in bytes.
  ///
  /// [resultsCachePolicy_priority] - The priority (relative importance) of this
  /// content in the overall cache. Generally, a lower value means a longer
  /// retention time or other advantage, but the interpretation of a given value
  /// is server-dependent. A priority of 0 means a *default* value, decided by
  /// the server. The particular semantics of this field is up to the server. In
  /// particular, every server will have their own supported range of
  /// priorities, and will decide how these map into retention/eviction policy.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [BuildBazelRemoteExecutionV2ActionResult].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<BuildBazelRemoteExecutionV2ActionResult> update(
    BuildBazelRemoteExecutionV2ActionResult request,
    core.String instanceName,
    core.String hash,
    core.String sizeBytes, {
    core.int? resultsCachePolicy_priority,
    core.String? $fields,
  }) async {
    final _body = convert.json.encode(request.toJson());
    final _queryParams = <core.String, core.List<core.String>>{
      if (resultsCachePolicy_priority != null)
        'resultsCachePolicy.priority': ['${resultsCachePolicy_priority}'],
      if ($fields != null) 'fields': [$fields],
    };

    final _url = 'v2/' +
        core.Uri.encodeFull('$instanceName') +
        '/actionResults/' +
        commons.escapeVariable('$hash') +
        '/' +
        commons.escapeVariable('$sizeBytes');

    final _response = await _requester.request(
      _url,
      'PUT',
      body: _body,
      queryParams: _queryParams,
    );
    return BuildBazelRemoteExecutionV2ActionResult.fromJson(
        _response as core.Map<core.String, core.dynamic>);
  }
}

class ActionsResource {
  final commons.ApiRequester _requester;

  ActionsResource(commons.ApiRequester client) : _requester = client;

  /// Execute an action remotely.
  ///
  /// In order to execute an action, the client must first upload all of the
  /// inputs, the Command to run, and the Action into the
  /// ContentAddressableStorage. It then calls `Execute` with an `action_digest`
  /// referring to them. The server will run the action and eventually return
  /// the result. The input `Action`'s fields MUST meet the various
  /// canonicalization requirements specified in the documentation for their
  /// types so that it has the same digest as other logically equivalent
  /// `Action`s. The server MAY enforce the requirements and return errors if a
  /// non-canonical input is received. It MAY also proceed without verifying
  /// some or all of the requirements, such as for performance reasons. If the
  /// server does not verify the requirement, then it will treat the `Action` as
  /// distinct from another logically equivalent action if they hash
  /// differently. Returns a stream of google.longrunning.Operation messages
  /// describing the resulting execution, with eventual `response`
  /// ExecuteResponse. The `metadata` on the operation is of type
  /// ExecuteOperationMetadata. If the client remains connected after the first
  /// response is returned after the server, then updates are streamed as if the
  /// client had called WaitExecution until the execution completes or the
  /// request reaches an error. The operation can also be queried using
  /// Operations API. The server NEED NOT implement other methods or
  /// functionality of the Operations API. Errors discovered during creation of
  /// the `Operation` will be reported as gRPC Status errors, while errors that
  /// occurred while running the action will be reported in the `status` field
  /// of the `ExecuteResponse`. The server MUST NOT set the `error` field of the
  /// `Operation` proto. The possible errors include: * `INVALID_ARGUMENT`: One
  /// or more arguments are invalid. * `FAILED_PRECONDITION`: One or more errors
  /// occurred in setting up the action requested, such as a missing input or
  /// command or no worker being available. The client may be able to fix the
  /// errors and retry. * `RESOURCE_EXHAUSTED`: There is insufficient quota of
  /// some resource to run the action. * `UNAVAILABLE`: Due to a transient
  /// condition, such as all workers being occupied (and the server does not
  /// support a queue), the action could not be started. The client should
  /// retry. * `INTERNAL`: An internal error occurred in the execution engine or
  /// the worker. * `DEADLINE_EXCEEDED`: The execution timed out. * `CANCELLED`:
  /// The operation was cancelled by the client. This status is only possible if
  /// the server implements the Operations API CancelOperation method, and it
  /// was called for the current execution. In the case of a missing input or
  /// command, the server SHOULD additionally send a PreconditionFailure error
  /// detail where, for each requested blob not present in the CAS, there is a
  /// `Violation` with a `type` of `MISSING` and a `subject` of
  /// `"blobs/{hash}/{size}"` indicating the digest of the missing blob. The
  /// server does not need to guarantee that a call to this method leads to at
  /// most one execution of the action. The server MAY execute the action
  /// multiple times, potentially in parallel. These redundant executions MAY
  /// continue to run, even if the operation is completed.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [instanceName] - The instance of the execution system to operate against.
  /// A server may support multiple instances of the execution system (with
  /// their own workers, storage, caches, etc.). The server MAY require use of
  /// this field to select between them in an implementation-defined fashion,
  /// otherwise it can be omitted.
  /// Value must have pattern `^.*$`.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [GoogleLongrunningOperation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<GoogleLongrunningOperation> execute(
    BuildBazelRemoteExecutionV2ExecuteRequest request,
    core.String instanceName, {
    core.String? $fields,
  }) async {
    final _body = convert.json.encode(request.toJson());
    final _queryParams = <core.String, core.List<core.String>>{
      if ($fields != null) 'fields': [$fields],
    };

    final _url =
        'v2/' + core.Uri.encodeFull('$instanceName') + '/actions:execute';

    final _response = await _requester.request(
      _url,
      'POST',
      body: _body,
      queryParams: _queryParams,
    );
    return GoogleLongrunningOperation.fromJson(
        _response as core.Map<core.String, core.dynamic>);
  }
}

class BlobsResource {
  final commons.ApiRequester _requester;

  BlobsResource(commons.ApiRequester client) : _requester = client;

  /// Download many blobs at once.
  ///
  /// The server may enforce a limit of the combined total size of blobs to be
  /// downloaded using this API. This limit may be obtained using the
  /// Capabilities API. Requests exceeding the limit should either be split into
  /// smaller chunks or downloaded using the ByteStream API, as appropriate.
  /// This request is equivalent to calling a Bytestream `Read` request on each
  /// individual blob, in parallel. The requests may succeed or fail
  /// independently. Errors: * `INVALID_ARGUMENT`: The client attempted to read
  /// more than the server supported limit. Every error on individual read will
  /// be returned in the corresponding digest status.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [instanceName] - The instance of the execution system to operate against.
  /// A server may support multiple instances of the execution system (with
  /// their own workers, storage, caches, etc.). The server MAY require use of
  /// this field to select between them in an implementation-defined fashion,
  /// otherwise it can be omitted.
  /// Value must have pattern `^.*$`.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [BuildBazelRemoteExecutionV2BatchReadBlobsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<BuildBazelRemoteExecutionV2BatchReadBlobsResponse> batchRead(
    BuildBazelRemoteExecutionV2BatchReadBlobsRequest request,
    core.String instanceName, {
    core.String? $fields,
  }) async {
    final _body = convert.json.encode(request.toJson());
    final _queryParams = <core.String, core.List<core.String>>{
      if ($fields != null) 'fields': [$fields],
    };

    final _url =
        'v2/' + core.Uri.encodeFull('$instanceName') + '/blobs:batchRead';

    final _response = await _requester.request(
      _url,
      'POST',
      body: _body,
      queryParams: _queryParams,
    );
    return BuildBazelRemoteExecutionV2BatchReadBlobsResponse.fromJson(
        _response as core.Map<core.String, core.dynamic>);
  }

  /// Upload many blobs at once.
  ///
  /// The server may enforce a limit of the combined total size of blobs to be
  /// uploaded using this API. This limit may be obtained using the Capabilities
  /// API. Requests exceeding the limit should either be split into smaller
  /// chunks or uploaded using the ByteStream API, as appropriate. This request
  /// is equivalent to calling a Bytestream `Write` request on each individual
  /// blob, in parallel. The requests may succeed or fail independently. Errors:
  /// * `INVALID_ARGUMENT`: The client attempted to upload more than the server
  /// supported limit. Individual requests may return the following errors,
  /// additionally: * `RESOURCE_EXHAUSTED`: There is insufficient disk quota to
  /// store the blob. * `INVALID_ARGUMENT`: The Digest does not match the
  /// provided data.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [instanceName] - The instance of the execution system to operate against.
  /// A server may support multiple instances of the execution system (with
  /// their own workers, storage, caches, etc.). The server MAY require use of
  /// this field to select between them in an implementation-defined fashion,
  /// otherwise it can be omitted.
  /// Value must have pattern `^.*$`.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [BuildBazelRemoteExecutionV2BatchUpdateBlobsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<BuildBazelRemoteExecutionV2BatchUpdateBlobsResponse> batchUpdate(
    BuildBazelRemoteExecutionV2BatchUpdateBlobsRequest request,
    core.String instanceName, {
    core.String? $fields,
  }) async {
    final _body = convert.json.encode(request.toJson());
    final _queryParams = <core.String, core.List<core.String>>{
      if ($fields != null) 'fields': [$fields],
    };

    final _url =
        'v2/' + core.Uri.encodeFull('$instanceName') + '/blobs:batchUpdate';

    final _response = await _requester.request(
      _url,
      'POST',
      body: _body,
      queryParams: _queryParams,
    );
    return BuildBazelRemoteExecutionV2BatchUpdateBlobsResponse.fromJson(
        _response as core.Map<core.String, core.dynamic>);
  }

  /// Determine if blobs are present in the CAS.
  ///
  /// Clients can use this API before uploading blobs to determine which ones
  /// are already present in the CAS and do not need to be uploaded again.
  /// Servers SHOULD increase the lifetimes of the referenced blobs if necessary
  /// and applicable. There are no method-specific errors.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [instanceName] - The instance of the execution system to operate against.
  /// A server may support multiple instances of the execution system (with
  /// their own workers, storage, caches, etc.). The server MAY require use of
  /// this field to select between them in an implementation-defined fashion,
  /// otherwise it can be omitted.
  /// Value must have pattern `^.*$`.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [BuildBazelRemoteExecutionV2FindMissingBlobsResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<BuildBazelRemoteExecutionV2FindMissingBlobsResponse> findMissing(
    BuildBazelRemoteExecutionV2FindMissingBlobsRequest request,
    core.String instanceName, {
    core.String? $fields,
  }) async {
    final _body = convert.json.encode(request.toJson());
    final _queryParams = <core.String, core.List<core.String>>{
      if ($fields != null) 'fields': [$fields],
    };

    final _url =
        'v2/' + core.Uri.encodeFull('$instanceName') + '/blobs:findMissing';

    final _response = await _requester.request(
      _url,
      'POST',
      body: _body,
      queryParams: _queryParams,
    );
    return BuildBazelRemoteExecutionV2FindMissingBlobsResponse.fromJson(
        _response as core.Map<core.String, core.dynamic>);
  }

  /// Fetch the entire directory tree rooted at a node.
  ///
  /// This request must be targeted at a Directory stored in the
  /// ContentAddressableStorage (CAS). The server will enumerate the `Directory`
  /// tree recursively and return every node descended from the root. The
  /// GetTreeRequest.page_token parameter can be used to skip ahead in the
  /// stream (e.g. when retrying a partially completed and aborted request), by
  /// setting it to a value taken from GetTreeResponse.next_page_token of the
  /// last successfully processed GetTreeResponse). The exact traversal order is
  /// unspecified and, unless retrieving subsequent pages from an earlier
  /// request, is not guaranteed to be stable across multiple invocations of
  /// `GetTree`. If part of the tree is missing from the CAS, the server will
  /// return the portion present and omit the rest. Errors: * `NOT_FOUND`: The
  /// requested tree root is not present in the CAS.
  ///
  /// Request parameters:
  ///
  /// [instanceName] - The instance of the execution system to operate against.
  /// A server may support multiple instances of the execution system (with
  /// their own workers, storage, caches, etc.). The server MAY require use of
  /// this field to select between them in an implementation-defined fashion,
  /// otherwise it can be omitted.
  /// Value must have pattern `^.*$`.
  ///
  /// [hash] - The hash. In the case of SHA-256, it will always be a lowercase
  /// hex string exactly 64 characters long.
  ///
  /// [sizeBytes] - The size of the blob, in bytes.
  ///
  /// [pageSize] - A maximum page size to request. If present, the server will
  /// request no more than this many items. Regardless of whether a page size is
  /// specified, the server may place its own limit on the number of items to be
  /// returned and require the client to retrieve more items using a subsequent
  /// request.
  ///
  /// [pageToken] - A page token, which must be a value received in a previous
  /// GetTreeResponse. If present, the server will use that token as an offset,
  /// returning only that page and the ones that succeed it.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [BuildBazelRemoteExecutionV2GetTreeResponse].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<BuildBazelRemoteExecutionV2GetTreeResponse> getTree(
    core.String instanceName,
    core.String hash,
    core.String sizeBytes, {
    core.int? pageSize,
    core.String? pageToken,
    core.String? $fields,
  }) async {
    final _queryParams = <core.String, core.List<core.String>>{
      if (pageSize != null) 'pageSize': ['${pageSize}'],
      if (pageToken != null) 'pageToken': [pageToken],
      if ($fields != null) 'fields': [$fields],
    };

    final _url = 'v2/' +
        core.Uri.encodeFull('$instanceName') +
        '/blobs/' +
        commons.escapeVariable('$hash') +
        '/' +
        commons.escapeVariable('$sizeBytes') +
        ':getTree';

    final _response = await _requester.request(
      _url,
      'GET',
      queryParams: _queryParams,
    );
    return BuildBazelRemoteExecutionV2GetTreeResponse.fromJson(
        _response as core.Map<core.String, core.dynamic>);
  }
}

class OperationsResource {
  final commons.ApiRequester _requester;

  OperationsResource(commons.ApiRequester client) : _requester = client;

  /// Wait for an execution operation to complete.
  ///
  /// When the client initially makes the request, the server immediately
  /// responds with the current status of the execution. The server will leave
  /// the request stream open until the operation completes, and then respond
  /// with the completed operation. The server MAY choose to stream additional
  /// updates as execution progresses, such as to provide an update as to the
  /// state of the execution.
  ///
  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [name] - The name of the Operation returned by Execute.
  /// Value must have pattern `^operations/.*$`.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [GoogleLongrunningOperation].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<GoogleLongrunningOperation> waitExecution(
    BuildBazelRemoteExecutionV2WaitExecutionRequest request,
    core.String name, {
    core.String? $fields,
  }) async {
    final _body = convert.json.encode(request.toJson());
    final _queryParams = <core.String, core.List<core.String>>{
      if ($fields != null) 'fields': [$fields],
    };

    final _url = 'v2/' + core.Uri.encodeFull('$name') + ':waitExecution';

    final _response = await _requester.request(
      _url,
      'POST',
      body: _body,
      queryParams: _queryParams,
    );
    return GoogleLongrunningOperation.fromJson(
        _response as core.Map<core.String, core.dynamic>);
  }
}

class V2Resource {
  final commons.ApiRequester _requester;

  V2Resource(commons.ApiRequester client) : _requester = client;

  /// GetCapabilities returns the server capabilities configuration of the
  /// remote endpoint.
  ///
  /// Only the capabilities of the services supported by the endpoint will be
  /// returned: * Execution + CAS + Action Cache endpoints should return both
  /// CacheCapabilities and ExecutionCapabilities. * Execution only endpoints
  /// should return ExecutionCapabilities. * CAS + Action Cache only endpoints
  /// should return CacheCapabilities.
  ///
  /// Request parameters:
  ///
  /// [instanceName] - The instance of the execution system to operate against.
  /// A server may support multiple instances of the execution system (with
  /// their own workers, storage, caches, etc.). The server MAY require use of
  /// this field to select between them in an implementation-defined fashion,
  /// otherwise it can be omitted.
  /// Value must have pattern `^.*$`.
  ///
  /// [$fields] - Selector specifying which fields to include in a partial
  /// response.
  ///
  /// Completes with a [BuildBazelRemoteExecutionV2ServerCapabilities].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<BuildBazelRemoteExecutionV2ServerCapabilities> getCapabilities(
    core.String instanceName, {
    core.String? $fields,
  }) async {
    final _queryParams = <core.String, core.List<core.String>>{
      if ($fields != null) 'fields': [$fields],
    };

    final _url = 'v2/' + core.Uri.encodeFull('$instanceName') + '/capabilities';

    final _response = await _requester.request(
      _url,
      'GET',
      queryParams: _queryParams,
    );
    return BuildBazelRemoteExecutionV2ServerCapabilities.fromJson(
        _response as core.Map<core.String, core.dynamic>);
  }
}

/// An `Action` captures all the information about an execution which is
/// required to reproduce it.
///
/// `Action`s are the core component of the \[Execution\] service. A single
/// `Action` represents a repeatable action that can be performed by the
/// execution service. `Action`s can be succinctly identified by the digest of
/// their wire format encoding and, once an `Action` has been executed, will be
/// cached in the action cache. Future requests can then use the cached result
/// rather than needing to run afresh. When a server completes execution of an
/// Action, it MAY choose to cache the result in the ActionCache unless
/// `do_not_cache` is `true`. Clients SHOULD expect the server to do so. By
/// default, future calls to Execute the same `Action` will also serve their
/// results from the cache. Clients must take care to understand the caching
/// behaviour. Ideally, all `Action`s will be reproducible so that serving a
/// result from cache is always desirable and correct.
class BuildBazelRemoteExecutionV2Action {
  /// The digest of the Command to run, which MUST be present in the
  /// ContentAddressableStorage.
  BuildBazelRemoteExecutionV2Digest? commandDigest;

  /// If true, then the `Action`'s result cannot be cached, and in-flight
  /// requests for the same `Action` may not be merged.
  core.bool? doNotCache;

  /// The digest of the root Directory for the input files.
  ///
  /// The files in the directory tree are available in the correct location on
  /// the build machine before the command is executed. The root directory, as
  /// well as every subdirectory and content blob referred to, MUST be in the
  /// ContentAddressableStorage.
  BuildBazelRemoteExecutionV2Digest? inputRootDigest;

  /// The optional platform requirements for the execution environment.
  ///
  /// The server MAY choose to execute the action on any worker satisfying the
  /// requirements, so the client SHOULD ensure that running the action on any
  /// such worker will have the same result. A detailed lexicon for this can be
  /// found in the accompanying platform.md. New in version 2.2: clients SHOULD
  /// set these platform properties as well as those in the Command. Servers
  /// SHOULD prefer those set here.
  BuildBazelRemoteExecutionV2Platform? platform;

  /// An optional additional salt value used to place this `Action` into a
  /// separate cache namespace from other instances having the same field
  /// contents.
  ///
  /// This salt typically comes from operational configuration specific to
  /// sources such as repo and service configuration, and allows disowning an
  /// entire set of ActionResults that might have been poisoned by buggy
  /// software or tool failures.
  core.String? salt;
  core.List<core.int> get saltAsBytes => convert.base64.decode(salt!);

  set saltAsBytes(core.List<core.int> _bytes) {
    salt =
        convert.base64.encode(_bytes).replaceAll('/', '_').replaceAll('+', '-');
  }

  /// A timeout after which the execution should be killed.
  ///
  /// If the timeout is absent, then the client is specifying that the execution
  /// should continue as long as the server will let it. The server SHOULD
  /// impose a timeout if the client does not specify one, however, if the
  /// client does specify a timeout that is longer than the server's maximum
  /// timeout, the server MUST reject the request. The timeout is a part of the
  /// Action message, and therefore two `Actions` with different timeouts are
  /// different, even if they are otherwise identical. This is because, if they
  /// were not, running an `Action` with a lower timeout than is required might
  /// result in a cache hit from an execution run with a longer timeout, hiding
  /// the fact that the timeout is too short. By encoding it directly in the
  /// `Action`, a lower timeout will result in a cache miss and the execution
  /// timeout will fail immediately, rather than whenever the cache entry gets
  /// evicted.
  core.String? timeout;

  BuildBazelRemoteExecutionV2Action();

  BuildBazelRemoteExecutionV2Action.fromJson(core.Map _json) {
    if (_json.containsKey('commandDigest')) {
      commandDigest = BuildBazelRemoteExecutionV2Digest.fromJson(
          _json['commandDigest'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('doNotCache')) {
      doNotCache = _json['doNotCache'] as core.bool;
    }
    if (_json.containsKey('inputRootDigest')) {
      inputRootDigest = BuildBazelRemoteExecutionV2Digest.fromJson(
          _json['inputRootDigest'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('platform')) {
      platform = BuildBazelRemoteExecutionV2Platform.fromJson(
          _json['platform'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('salt')) {
      salt = _json['salt'] as core.String;
    }
    if (_json.containsKey('timeout')) {
      timeout = _json['timeout'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (commandDigest != null) 'commandDigest': commandDigest!.toJson(),
        if (doNotCache != null) 'doNotCache': doNotCache!,
        if (inputRootDigest != null)
          'inputRootDigest': inputRootDigest!.toJson(),
        if (platform != null) 'platform': platform!.toJson(),
        if (salt != null) 'salt': salt!,
        if (timeout != null) 'timeout': timeout!,
      };
}

/// Describes the server/instance capabilities for updating the action cache.
class BuildBazelRemoteExecutionV2ActionCacheUpdateCapabilities {
  core.bool? updateEnabled;

  BuildBazelRemoteExecutionV2ActionCacheUpdateCapabilities();

  BuildBazelRemoteExecutionV2ActionCacheUpdateCapabilities.fromJson(
      core.Map _json) {
    if (_json.containsKey('updateEnabled')) {
      updateEnabled = _json['updateEnabled'] as core.bool;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (updateEnabled != null) 'updateEnabled': updateEnabled!,
      };
}

/// An ActionResult represents the result of an Action being run.
///
/// It is advised that at least one field (for example
/// `ActionResult.execution_metadata.Worker`) have a non-default value, to
/// ensure that the serialized value is non-empty, which can then be used as a
/// basic data sanity check.
class BuildBazelRemoteExecutionV2ActionResult {
  /// The details of the execution that originally produced this result.
  BuildBazelRemoteExecutionV2ExecutedActionMetadata? executionMetadata;

  /// The exit code of the command.
  core.int? exitCode;

  /// The output directories of the action.
  ///
  /// For each output directory requested in the `output_directories` or
  /// `output_paths` field of the Action, if the corresponding directory existed
  /// after the action completed, a single entry will be present in the output
  /// list, which will contain the digest of a Tree message containing the
  /// directory tree, and the path equal exactly to the corresponding Action
  /// output_directories member. As an example, suppose the Action had an output
  /// directory `a/b/dir` and the execution produced the following contents in
  /// `a/b/dir`: a file named `bar` and a directory named `foo` with an
  /// executable file named `baz`. Then, output_directory will contain (hashes
  /// shortened for readability): ```json // OutputDirectory proto: { path:
  /// "a/b/dir" tree_digest: { hash: "4a73bc9d03...", size: 55 } } // Tree proto
  /// with hash "4a73bc9d03..." and size 55: { root: { files: [ { name: "bar",
  /// digest: { hash: "4a73bc9d03...", size: 65534 } } ], directories: [ { name:
  /// "foo", digest: { hash: "4cf2eda940...", size: 43 } } ] } children : { //
  /// (Directory proto with hash "4cf2eda940..." and size 43) files: [ { name:
  /// "baz", digest: { hash: "b2c941073e...", size: 1294, }, is_executable: true
  /// } ] } } ``` If an output of the same name as listed in `output_files` of
  /// the Command was found in `output_directories`, but was not a directory,
  /// the server will return a FAILED_PRECONDITION.
  core.List<BuildBazelRemoteExecutionV2OutputDirectory>? outputDirectories;

  /// The output directories of the action that are symbolic links to other
  /// directories.
  ///
  /// Those may be links to other output directories, or input directories, or
  /// even absolute paths outside of the working directory, if the server
  /// supports SymlinkAbsolutePathStrategy.ALLOWED. For each output directory
  /// requested in the `output_directories` field of the Action, if the
  /// directory existed after the action completed, a single entry will be
  /// present either in this field, or in the `output_directories` field, if the
  /// directory was not a symbolic link. If an output of the same name was
  /// found, but was a symbolic link to a file instead of a directory, the
  /// server will return a FAILED_PRECONDITION. If the action does not produce
  /// the requested output, then that output will be omitted from the list. The
  /// server is free to arrange the output list as desired; clients MUST NOT
  /// assume that the output list is sorted. DEPRECATED as of v2.1. Servers that
  /// wish to be compatible with v2.0 API should still populate this field in
  /// addition to `output_symlinks`.
  core.List<BuildBazelRemoteExecutionV2OutputSymlink>? outputDirectorySymlinks;

  /// The output files of the action that are symbolic links to other files.
  ///
  /// Those may be links to other output files, or input files, or even absolute
  /// paths outside of the working directory, if the server supports
  /// SymlinkAbsolutePathStrategy.ALLOWED. For each output file requested in the
  /// `output_files` or `output_paths` field of the Action, if the corresponding
  /// file existed after the action completed, a single entry will be present
  /// either in this field, or in the `output_files` field, if the file was not
  /// a symbolic link. If an output symbolic link of the same name as listed in
  /// `output_files` of the Command was found, but its target type was not a
  /// regular file, the server will return a FAILED_PRECONDITION. If the action
  /// does not produce the requested output, then that output will be omitted
  /// from the list. The server is free to arrange the output list as desired;
  /// clients MUST NOT assume that the output list is sorted. DEPRECATED as of
  /// v2.1. Servers that wish to be compatible with v2.0 API should still
  /// populate this field in addition to `output_symlinks`.
  core.List<BuildBazelRemoteExecutionV2OutputSymlink>? outputFileSymlinks;

  /// The output files of the action.
  ///
  /// For each output file requested in the `output_files` or `output_paths`
  /// field of the Action, if the corresponding file existed after the action
  /// completed, a single entry will be present either in this field, or the
  /// `output_file_symlinks` field if the file was a symbolic link to another
  /// file (`output_symlinks` field after v2.1). If an output listed in
  /// `output_files` was found, but was a directory rather than a regular file,
  /// the server will return a FAILED_PRECONDITION. If the action does not
  /// produce the requested output, then that output will be omitted from the
  /// list. The server is free to arrange the output list as desired; clients
  /// MUST NOT assume that the output list is sorted.
  core.List<BuildBazelRemoteExecutionV2OutputFile>? outputFiles;

  /// New in v2.1: this field will only be populated if the command
  /// `output_paths` field was used, and not the pre v2.1 `output_files` or
  /// `output_directories` fields.
  ///
  /// The output paths of the action that are symbolic links to other paths.
  /// Those may be links to other outputs, or inputs, or even absolute paths
  /// outside of the working directory, if the server supports
  /// SymlinkAbsolutePathStrategy.ALLOWED. A single entry for each output
  /// requested in `output_paths` field of the Action, if the corresponding path
  /// existed after the action completed and was a symbolic link. If the action
  /// does not produce a requested output, then that output will be omitted from
  /// the list. The server is free to arrange the output list as desired;
  /// clients MUST NOT assume that the output list is sorted.
  core.List<BuildBazelRemoteExecutionV2OutputSymlink>? outputSymlinks;

  /// The digest for a blob containing the standard error of the action, which
  /// can be retrieved from the ContentAddressableStorage.
  BuildBazelRemoteExecutionV2Digest? stderrDigest;

  /// The standard error buffer of the action.
  ///
  /// The server SHOULD NOT inline stderr unless requested by the client in the
  /// GetActionResultRequest message. The server MAY omit inlining, even if
  /// requested, and MUST do so if inlining would cause the response to exceed
  /// message size limits.
  core.String? stderrRaw;
  core.List<core.int> get stderrRawAsBytes => convert.base64.decode(stderrRaw!);

  set stderrRawAsBytes(core.List<core.int> _bytes) {
    stderrRaw =
        convert.base64.encode(_bytes).replaceAll('/', '_').replaceAll('+', '-');
  }

  /// The digest for a blob containing the standard output of the action, which
  /// can be retrieved from the ContentAddressableStorage.
  BuildBazelRemoteExecutionV2Digest? stdoutDigest;

  /// The standard output buffer of the action.
  ///
  /// The server SHOULD NOT inline stdout unless requested by the client in the
  /// GetActionResultRequest message. The server MAY omit inlining, even if
  /// requested, and MUST do so if inlining would cause the response to exceed
  /// message size limits.
  core.String? stdoutRaw;
  core.List<core.int> get stdoutRawAsBytes => convert.base64.decode(stdoutRaw!);

  set stdoutRawAsBytes(core.List<core.int> _bytes) {
    stdoutRaw =
        convert.base64.encode(_bytes).replaceAll('/', '_').replaceAll('+', '-');
  }

  BuildBazelRemoteExecutionV2ActionResult();

  BuildBazelRemoteExecutionV2ActionResult.fromJson(core.Map _json) {
    if (_json.containsKey('executionMetadata')) {
      executionMetadata =
          BuildBazelRemoteExecutionV2ExecutedActionMetadata.fromJson(
              _json['executionMetadata']
                  as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('exitCode')) {
      exitCode = _json['exitCode'] as core.int;
    }
    if (_json.containsKey('outputDirectories')) {
      outputDirectories = (_json['outputDirectories'] as core.List)
          .map<BuildBazelRemoteExecutionV2OutputDirectory>((value) =>
              BuildBazelRemoteExecutionV2OutputDirectory.fromJson(
                  value as core.Map<core.String, core.dynamic>))
          .toList();
    }
    if (_json.containsKey('outputDirectorySymlinks')) {
      outputDirectorySymlinks = (_json['outputDirectorySymlinks'] as core.List)
          .map<BuildBazelRemoteExecutionV2OutputSymlink>((value) =>
              BuildBazelRemoteExecutionV2OutputSymlink.fromJson(
                  value as core.Map<core.String, core.dynamic>))
          .toList();
    }
    if (_json.containsKey('outputFileSymlinks')) {
      outputFileSymlinks = (_json['outputFileSymlinks'] as core.List)
          .map<BuildBazelRemoteExecutionV2OutputSymlink>((value) =>
              BuildBazelRemoteExecutionV2OutputSymlink.fromJson(
                  value as core.Map<core.String, core.dynamic>))
          .toList();
    }
    if (_json.containsKey('outputFiles')) {
      outputFiles = (_json['outputFiles'] as core.List)
          .map<BuildBazelRemoteExecutionV2OutputFile>((value) =>
              BuildBazelRemoteExecutionV2OutputFile.fromJson(
                  value as core.Map<core.String, core.dynamic>))
          .toList();
    }
    if (_json.containsKey('outputSymlinks')) {
      outputSymlinks = (_json['outputSymlinks'] as core.List)
          .map<BuildBazelRemoteExecutionV2OutputSymlink>((value) =>
              BuildBazelRemoteExecutionV2OutputSymlink.fromJson(
                  value as core.Map<core.String, core.dynamic>))
          .toList();
    }
    if (_json.containsKey('stderrDigest')) {
      stderrDigest = BuildBazelRemoteExecutionV2Digest.fromJson(
          _json['stderrDigest'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('stderrRaw')) {
      stderrRaw = _json['stderrRaw'] as core.String;
    }
    if (_json.containsKey('stdoutDigest')) {
      stdoutDigest = BuildBazelRemoteExecutionV2Digest.fromJson(
          _json['stdoutDigest'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('stdoutRaw')) {
      stdoutRaw = _json['stdoutRaw'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (executionMetadata != null)
          'executionMetadata': executionMetadata!.toJson(),
        if (exitCode != null) 'exitCode': exitCode!,
        if (outputDirectories != null)
          'outputDirectories':
              outputDirectories!.map((value) => value.toJson()).toList(),
        if (outputDirectorySymlinks != null)
          'outputDirectorySymlinks':
              outputDirectorySymlinks!.map((value) => value.toJson()).toList(),
        if (outputFileSymlinks != null)
          'outputFileSymlinks':
              outputFileSymlinks!.map((value) => value.toJson()).toList(),
        if (outputFiles != null)
          'outputFiles': outputFiles!.map((value) => value.toJson()).toList(),
        if (outputSymlinks != null)
          'outputSymlinks':
              outputSymlinks!.map((value) => value.toJson()).toList(),
        if (stderrDigest != null) 'stderrDigest': stderrDigest!.toJson(),
        if (stderrRaw != null) 'stderrRaw': stderrRaw!,
        if (stdoutDigest != null) 'stdoutDigest': stdoutDigest!.toJson(),
        if (stdoutRaw != null) 'stdoutRaw': stdoutRaw!,
      };
}

/// A request message for ContentAddressableStorage.BatchReadBlobs.
class BuildBazelRemoteExecutionV2BatchReadBlobsRequest {
  /// The individual blob digests.
  core.List<BuildBazelRemoteExecutionV2Digest>? digests;

  BuildBazelRemoteExecutionV2BatchReadBlobsRequest();

  BuildBazelRemoteExecutionV2BatchReadBlobsRequest.fromJson(core.Map _json) {
    if (_json.containsKey('digests')) {
      digests = (_json['digests'] as core.List)
          .map<BuildBazelRemoteExecutionV2Digest>((value) =>
              BuildBazelRemoteExecutionV2Digest.fromJson(
                  value as core.Map<core.String, core.dynamic>))
          .toList();
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (digests != null)
          'digests': digests!.map((value) => value.toJson()).toList(),
      };
}

/// A response message for ContentAddressableStorage.BatchReadBlobs.
class BuildBazelRemoteExecutionV2BatchReadBlobsResponse {
  /// The responses to the requests.
  core.List<BuildBazelRemoteExecutionV2BatchReadBlobsResponseResponse>?
      responses;

  BuildBazelRemoteExecutionV2BatchReadBlobsResponse();

  BuildBazelRemoteExecutionV2BatchReadBlobsResponse.fromJson(core.Map _json) {
    if (_json.containsKey('responses')) {
      responses = (_json['responses'] as core.List)
          .map<BuildBazelRemoteExecutionV2BatchReadBlobsResponseResponse>(
              (value) =>
                  BuildBazelRemoteExecutionV2BatchReadBlobsResponseResponse
                      .fromJson(value as core.Map<core.String, core.dynamic>))
          .toList();
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (responses != null)
          'responses': responses!.map((value) => value.toJson()).toList(),
      };
}

/// A response corresponding to a single blob that the client tried to download.
class BuildBazelRemoteExecutionV2BatchReadBlobsResponseResponse {
  /// The raw binary data.
  core.String? data;
  core.List<core.int> get dataAsBytes => convert.base64.decode(data!);

  set dataAsBytes(core.List<core.int> _bytes) {
    data =
        convert.base64.encode(_bytes).replaceAll('/', '_').replaceAll('+', '-');
  }

  /// The digest to which this response corresponds.
  BuildBazelRemoteExecutionV2Digest? digest;

  /// The result of attempting to download that blob.
  GoogleRpcStatus? status;

  BuildBazelRemoteExecutionV2BatchReadBlobsResponseResponse();

  BuildBazelRemoteExecutionV2BatchReadBlobsResponseResponse.fromJson(
      core.Map _json) {
    if (_json.containsKey('data')) {
      data = _json['data'] as core.String;
    }
    if (_json.containsKey('digest')) {
      digest = BuildBazelRemoteExecutionV2Digest.fromJson(
          _json['digest'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('status')) {
      status = GoogleRpcStatus.fromJson(
          _json['status'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (data != null) 'data': data!,
        if (digest != null) 'digest': digest!.toJson(),
        if (status != null) 'status': status!.toJson(),
      };
}

/// A request message for ContentAddressableStorage.BatchUpdateBlobs.
class BuildBazelRemoteExecutionV2BatchUpdateBlobsRequest {
  /// The individual upload requests.
  core.List<BuildBazelRemoteExecutionV2BatchUpdateBlobsRequestRequest>?
      requests;

  BuildBazelRemoteExecutionV2BatchUpdateBlobsRequest();

  BuildBazelRemoteExecutionV2BatchUpdateBlobsRequest.fromJson(core.Map _json) {
    if (_json.containsKey('requests')) {
      requests = (_json['requests'] as core.List)
          .map<BuildBazelRemoteExecutionV2BatchUpdateBlobsRequestRequest>(
              (value) =>
                  BuildBazelRemoteExecutionV2BatchUpdateBlobsRequestRequest
                      .fromJson(value as core.Map<core.String, core.dynamic>))
          .toList();
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (requests != null)
          'requests': requests!.map((value) => value.toJson()).toList(),
      };
}

/// A request corresponding to a single blob that the client wants to upload.
class BuildBazelRemoteExecutionV2BatchUpdateBlobsRequestRequest {
  /// The raw binary data.
  core.String? data;
  core.List<core.int> get dataAsBytes => convert.base64.decode(data!);

  set dataAsBytes(core.List<core.int> _bytes) {
    data =
        convert.base64.encode(_bytes).replaceAll('/', '_').replaceAll('+', '-');
  }

  /// The digest of the blob.
  ///
  /// This MUST be the digest of `data`.
  BuildBazelRemoteExecutionV2Digest? digest;

  BuildBazelRemoteExecutionV2BatchUpdateBlobsRequestRequest();

  BuildBazelRemoteExecutionV2BatchUpdateBlobsRequestRequest.fromJson(
      core.Map _json) {
    if (_json.containsKey('data')) {
      data = _json['data'] as core.String;
    }
    if (_json.containsKey('digest')) {
      digest = BuildBazelRemoteExecutionV2Digest.fromJson(
          _json['digest'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (data != null) 'data': data!,
        if (digest != null) 'digest': digest!.toJson(),
      };
}

/// A response message for ContentAddressableStorage.BatchUpdateBlobs.
class BuildBazelRemoteExecutionV2BatchUpdateBlobsResponse {
  /// The responses to the requests.
  core.List<BuildBazelRemoteExecutionV2BatchUpdateBlobsResponseResponse>?
      responses;

  BuildBazelRemoteExecutionV2BatchUpdateBlobsResponse();

  BuildBazelRemoteExecutionV2BatchUpdateBlobsResponse.fromJson(core.Map _json) {
    if (_json.containsKey('responses')) {
      responses = (_json['responses'] as core.List)
          .map<BuildBazelRemoteExecutionV2BatchUpdateBlobsResponseResponse>(
              (value) =>
                  BuildBazelRemoteExecutionV2BatchUpdateBlobsResponseResponse
                      .fromJson(value as core.Map<core.String, core.dynamic>))
          .toList();
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (responses != null)
          'responses': responses!.map((value) => value.toJson()).toList(),
      };
}

/// A response corresponding to a single blob that the client tried to upload.
class BuildBazelRemoteExecutionV2BatchUpdateBlobsResponseResponse {
  /// The blob digest to which this response corresponds.
  BuildBazelRemoteExecutionV2Digest? digest;

  /// The result of attempting to upload that blob.
  GoogleRpcStatus? status;

  BuildBazelRemoteExecutionV2BatchUpdateBlobsResponseResponse();

  BuildBazelRemoteExecutionV2BatchUpdateBlobsResponseResponse.fromJson(
      core.Map _json) {
    if (_json.containsKey('digest')) {
      digest = BuildBazelRemoteExecutionV2Digest.fromJson(
          _json['digest'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('status')) {
      status = GoogleRpcStatus.fromJson(
          _json['status'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (digest != null) 'digest': digest!.toJson(),
        if (status != null) 'status': status!.toJson(),
      };
}

/// Capabilities of the remote cache system.
class BuildBazelRemoteExecutionV2CacheCapabilities {
  /// Capabilities for updating the action cache.
  BuildBazelRemoteExecutionV2ActionCacheUpdateCapabilities?
      actionCacheUpdateCapabilities;

  /// Supported cache priority range for both CAS and ActionCache.
  BuildBazelRemoteExecutionV2PriorityCapabilities? cachePriorityCapabilities;

  /// All the digest functions supported by the remote cache.
  ///
  /// Remote cache may support multiple digest functions simultaneously.
  core.List<core.String>? digestFunction;

  /// Maximum total size of blobs to be uploaded/downloaded using batch methods.
  ///
  /// A value of 0 means no limit is set, although in practice there will always
  /// be a message size limitation of the protocol in use, e.g. GRPC.
  core.String? maxBatchTotalSizeBytes;

  /// Whether absolute symlink targets are supported.
  /// Possible string values are:
  /// - "UNKNOWN" : Invalid value.
  /// - "DISALLOWED" : Server will return an `INVALID_ARGUMENT` on input
  /// symlinks with absolute targets. If an action tries to create an output
  /// symlink with an absolute target, a `FAILED_PRECONDITION` will be returned.
  /// - "ALLOWED" : Server will allow symlink targets to escape the input root
  /// tree, possibly resulting in non-hermetic builds.
  core.String? symlinkAbsolutePathStrategy;

  BuildBazelRemoteExecutionV2CacheCapabilities();

  BuildBazelRemoteExecutionV2CacheCapabilities.fromJson(core.Map _json) {
    if (_json.containsKey('actionCacheUpdateCapabilities')) {
      actionCacheUpdateCapabilities =
          BuildBazelRemoteExecutionV2ActionCacheUpdateCapabilities.fromJson(
              _json['actionCacheUpdateCapabilities']
                  as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('cachePriorityCapabilities')) {
      cachePriorityCapabilities =
          BuildBazelRemoteExecutionV2PriorityCapabilities.fromJson(
              _json['cachePriorityCapabilities']
                  as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('digestFunction')) {
      digestFunction = (_json['digestFunction'] as core.List)
          .map<core.String>((value) => value as core.String)
          .toList();
    }
    if (_json.containsKey('maxBatchTotalSizeBytes')) {
      maxBatchTotalSizeBytes = _json['maxBatchTotalSizeBytes'] as core.String;
    }
    if (_json.containsKey('symlinkAbsolutePathStrategy')) {
      symlinkAbsolutePathStrategy =
          _json['symlinkAbsolutePathStrategy'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (actionCacheUpdateCapabilities != null)
          'actionCacheUpdateCapabilities':
              actionCacheUpdateCapabilities!.toJson(),
        if (cachePriorityCapabilities != null)
          'cachePriorityCapabilities': cachePriorityCapabilities!.toJson(),
        if (digestFunction != null) 'digestFunction': digestFunction!,
        if (maxBatchTotalSizeBytes != null)
          'maxBatchTotalSizeBytes': maxBatchTotalSizeBytes!,
        if (symlinkAbsolutePathStrategy != null)
          'symlinkAbsolutePathStrategy': symlinkAbsolutePathStrategy!,
      };
}

/// A `Command` is the actual command executed by a worker running an Action and
/// specifications of its environment.
///
/// Except as otherwise required, the environment (such as which system
/// libraries or binaries are available, and what filesystems are mounted where)
/// is defined by and specific to the implementation of the remote execution
/// API.
class BuildBazelRemoteExecutionV2Command {
  /// The arguments to the command.
  ///
  /// The first argument must be the path to the executable, which must be
  /// either a relative path, in which case it is evaluated with respect to the
  /// input root, or an absolute path.
  core.List<core.String>? arguments;

  /// The environment variables to set when running the program.
  ///
  /// The worker may provide its own default environment variables; these
  /// defaults can be overridden using this field. Additional variables can also
  /// be specified. In order to ensure that equivalent Commands always hash to
  /// the same value, the environment variables MUST be lexicographically sorted
  /// by name. Sorting of strings is done by code point, equivalently, by the
  /// UTF-8 bytes.
  core.List<BuildBazelRemoteExecutionV2CommandEnvironmentVariable>?
      environmentVariables;

  /// A list of the output directories that the client expects to retrieve from
  /// the action.
  ///
  /// Only the listed directories will be returned (an entire directory
  /// structure will be returned as a Tree message digest, see OutputDirectory),
  /// as well as files listed in `output_files`. Other files or directories that
  /// may be created during command execution are discarded. The paths are
  /// relative to the working directory of the action execution. The paths are
  /// specified using a single forward slash (`/`) as a path separator, even if
  /// the execution platform natively uses a different separator. The path MUST
  /// NOT include a trailing slash, nor a leading slash, being a relative path.
  /// The special value of empty string is allowed, although not recommended,
  /// and can be used to capture the entire working directory tree, including
  /// inputs. In order to ensure consistent hashing of the same Action, the
  /// output paths MUST be sorted lexicographically by code point (or,
  /// equivalently, by UTF-8 bytes). An output directory cannot be duplicated or
  /// have the same path as any of the listed output files. An output directory
  /// is allowed to be a parent of another output directory. Directories leading
  /// up to the output directories (but not the output directories themselves)
  /// are created by the worker prior to execution, even if they are not
  /// explicitly part of the input root. DEPRECATED since 2.1: Use
  /// `output_paths` instead.
  core.List<core.String>? outputDirectories;

  /// A list of the output files that the client expects to retrieve from the
  /// action.
  ///
  /// Only the listed files, as well as directories listed in
  /// `output_directories`, will be returned to the client as output. Other
  /// files or directories that may be created during command execution are
  /// discarded. The paths are relative to the working directory of the action
  /// execution. The paths are specified using a single forward slash (`/`) as a
  /// path separator, even if the execution platform natively uses a different
  /// separator. The path MUST NOT include a trailing slash, nor a leading
  /// slash, being a relative path. In order to ensure consistent hashing of the
  /// same Action, the output paths MUST be sorted lexicographically by code
  /// point (or, equivalently, by UTF-8 bytes). An output file cannot be
  /// duplicated, be a parent of another output file, or have the same path as
  /// any of the listed output directories. Directories leading up to the output
  /// files are created by the worker prior to execution, even if they are not
  /// explicitly part of the input root. DEPRECATED since v2.1: Use
  /// `output_paths` instead.
  core.List<core.String>? outputFiles;

  /// A list of keys for node properties the client expects to retrieve for
  /// output files and directories.
  ///
  /// Keys are either names of string-based NodeProperty or names of fields in
  /// NodeProperties. In order to ensure that equivalent `Action`s always hash
  /// to the same value, the node properties MUST be lexicographically sorted by
  /// name. Sorting of strings is done by code point, equivalently, by the UTF-8
  /// bytes. The interpretation of string-based properties is server-dependent.
  /// If a property is not recognized by the server, the server will return an
  /// `INVALID_ARGUMENT`.
  core.List<core.String>? outputNodeProperties;

  /// A list of the output paths that the client expects to retrieve from the
  /// action.
  ///
  /// Only the listed paths will be returned to the client as output. The type
  /// of the output (file or directory) is not specified, and will be determined
  /// by the server after action execution. If the resulting path is a file, it
  /// will be returned in an OutputFile) typed field. If the path is a
  /// directory, the entire directory structure will be returned as a Tree
  /// message digest, see OutputDirectory) Other files or directories that may
  /// be created during command execution are discarded. The paths are relative
  /// to the working directory of the action execution. The paths are specified
  /// using a single forward slash (`/`) as a path separator, even if the
  /// execution platform natively uses a different separator. The path MUST NOT
  /// include a trailing slash, nor a leading slash, being a relative path. In
  /// order to ensure consistent hashing of the same Action, the output paths
  /// MUST be deduplicated and sorted lexicographically by code point (or,
  /// equivalently, by UTF-8 bytes). Directories leading up to the output paths
  /// are created by the worker prior to execution, even if they are not
  /// explicitly part of the input root. New in v2.1: this field supersedes the
  /// DEPRECATED `output_files` and `output_directories` fields. If
  /// `output_paths` is used, `output_files` and `output_directories` will be
  /// ignored!
  core.List<core.String>? outputPaths;

  /// The platform requirements for the execution environment.
  ///
  /// The server MAY choose to execute the action on any worker satisfying the
  /// requirements, so the client SHOULD ensure that running the action on any
  /// such worker will have the same result. A detailed lexicon for this can be
  /// found in the accompanying platform.md. DEPRECATED as of v2.2: platform
  /// properties are now specified directly in the action. See documentation
  /// note in the Action for migration.
  BuildBazelRemoteExecutionV2Platform? platform;

  /// The working directory, relative to the input root, for the command to run
  /// in.
  ///
  /// It must be a directory which exists in the input tree. If it is left
  /// empty, then the action is run in the input root.
  core.String? workingDirectory;

  BuildBazelRemoteExecutionV2Command();

  BuildBazelRemoteExecutionV2Command.fromJson(core.Map _json) {
    if (_json.containsKey('arguments')) {
      arguments = (_json['arguments'] as core.List)
          .map<core.String>((value) => value as core.String)
          .toList();
    }
    if (_json.containsKey('environmentVariables')) {
      environmentVariables = (_json['environmentVariables'] as core.List)
          .map<BuildBazelRemoteExecutionV2CommandEnvironmentVariable>((value) =>
              BuildBazelRemoteExecutionV2CommandEnvironmentVariable.fromJson(
                  value as core.Map<core.String, core.dynamic>))
          .toList();
    }
    if (_json.containsKey('outputDirectories')) {
      outputDirectories = (_json['outputDirectories'] as core.List)
          .map<core.String>((value) => value as core.String)
          .toList();
    }
    if (_json.containsKey('outputFiles')) {
      outputFiles = (_json['outputFiles'] as core.List)
          .map<core.String>((value) => value as core.String)
          .toList();
    }
    if (_json.containsKey('outputNodeProperties')) {
      outputNodeProperties = (_json['outputNodeProperties'] as core.List)
          .map<core.String>((value) => value as core.String)
          .toList();
    }
    if (_json.containsKey('outputPaths')) {
      outputPaths = (_json['outputPaths'] as core.List)
          .map<core.String>((value) => value as core.String)
          .toList();
    }
    if (_json.containsKey('platform')) {
      platform = BuildBazelRemoteExecutionV2Platform.fromJson(
          _json['platform'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('workingDirectory')) {
      workingDirectory = _json['workingDirectory'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (arguments != null) 'arguments': arguments!,
        if (environmentVariables != null)
          'environmentVariables':
              environmentVariables!.map((value) => value.toJson()).toList(),
        if (outputDirectories != null) 'outputDirectories': outputDirectories!,
        if (outputFiles != null) 'outputFiles': outputFiles!,
        if (outputNodeProperties != null)
          'outputNodeProperties': outputNodeProperties!,
        if (outputPaths != null) 'outputPaths': outputPaths!,
        if (platform != null) 'platform': platform!.toJson(),
        if (workingDirectory != null) 'workingDirectory': workingDirectory!,
      };
}

/// An `EnvironmentVariable` is one variable to set in the running program's
/// environment.
class BuildBazelRemoteExecutionV2CommandEnvironmentVariable {
  /// The variable name.
  core.String? name;

  /// The variable value.
  core.String? value;

  BuildBazelRemoteExecutionV2CommandEnvironmentVariable();

  BuildBazelRemoteExecutionV2CommandEnvironmentVariable.fromJson(
      core.Map _json) {
    if (_json.containsKey('name')) {
      name = _json['name'] as core.String;
    }
    if (_json.containsKey('value')) {
      value = _json['value'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (name != null) 'name': name!,
        if (value != null) 'value': value!,
      };
}

/// A content digest.
///
/// A digest for a given blob consists of the size of the blob and its hash. The
/// hash algorithm to use is defined by the server. The size is considered to be
/// an integral part of the digest and cannot be separated. That is, even if the
/// `hash` field is correctly specified but `size_bytes` is not, the server MUST
/// reject the request. The reason for including the size in the digest is as
/// follows: in a great many cases, the server needs to know the size of the
/// blob it is about to work with prior to starting an operation with it, such
/// as flattening Merkle tree structures or streaming it to a worker.
/// Technically, the server could implement a separate metadata store, but this
/// results in a significantly more complicated implementation as opposed to
/// having the client specify the size up-front (or storing the size along with
/// the digest in every message where digests are embedded). This does mean that
/// the API leaks some implementation details of (what we consider to be) a
/// reasonable server implementation, but we consider this to be a worthwhile
/// tradeoff. When a `Digest` is used to refer to a proto message, it always
/// refers to the message in binary encoded form. To ensure consistent hashing,
/// clients and servers MUST ensure that they serialize messages according to
/// the following rules, even if there are alternate valid encodings for the
/// same message: * Fields are serialized in tag order. * There are no unknown
/// fields. * There are no duplicate fields. * Fields are serialized according
/// to the default semantics for their type. Most protocol buffer
/// implementations will always follow these rules when serializing, but care
/// should be taken to avoid shortcuts. For instance, concatenating two messages
/// to merge them may produce duplicate fields.
class BuildBazelRemoteExecutionV2Digest {
  /// The hash.
  ///
  /// In the case of SHA-256, it will always be a lowercase hex string exactly
  /// 64 characters long.
  core.String? hash;

  /// The size of the blob, in bytes.
  core.String? sizeBytes;

  BuildBazelRemoteExecutionV2Digest();

  BuildBazelRemoteExecutionV2Digest.fromJson(core.Map _json) {
    if (_json.containsKey('hash')) {
      hash = _json['hash'] as core.String;
    }
    if (_json.containsKey('sizeBytes')) {
      sizeBytes = _json['sizeBytes'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (hash != null) 'hash': hash!,
        if (sizeBytes != null) 'sizeBytes': sizeBytes!,
      };
}

/// A `Directory` represents a directory node in a file tree, containing zero or
/// more children FileNodes, DirectoryNodes and SymlinkNodes.
///
/// Each `Node` contains its name in the directory, either the digest of its
/// content (either a file blob or a `Directory` proto) or a symlink target, as
/// well as possibly some metadata about the file or directory. In order to
/// ensure that two equivalent directory trees hash to the same value, the
/// following restrictions MUST be obeyed when constructing a a `Directory`: *
/// Every child in the directory must have a path of exactly one segment.
/// Multiple levels of directory hierarchy may not be collapsed. * Each child in
/// the directory must have a unique path segment (file name). Note that while
/// the API itself is case-sensitive, the environment where the Action is
/// executed may or may not be case-sensitive. That is, it is legal to call the
/// API with a Directory that has both "Foo" and "foo" as children, but the
/// Action may be rejected by the remote system upon execution. * The files,
/// directories and symlinks in the directory must each be sorted in
/// lexicographical order by path. The path strings must be sorted by code
/// point, equivalently, by UTF-8 bytes. * The NodeProperties of files,
/// directories, and symlinks must be sorted in lexicographical order by
/// property name. A `Directory` that obeys the restrictions is said to be in
/// canonical form. As an example, the following could be used for a file named
/// `bar` and a directory named `foo` with an executable file named `baz`
/// (hashes shortened for readability): ```json // (Directory proto) { files: [
/// { name: "bar", digest: { hash: "4a73bc9d03...", size: 65534 },
/// node_properties: [ { "name": "MTime", "value": "2017-01-15T01:30:15.01Z" } ]
/// } ], directories: [ { name: "foo", digest: { hash: "4cf2eda940...", size: 43
/// } } ] } // (Directory proto with hash "4cf2eda940..." and size 43) { files:
/// [ { name: "baz", digest: { hash: "b2c941073e...", size: 1294, },
/// is_executable: true } ] } ```
class BuildBazelRemoteExecutionV2Directory {
  /// The subdirectories in the directory.
  core.List<BuildBazelRemoteExecutionV2DirectoryNode>? directories;

  /// The files in the directory.
  core.List<BuildBazelRemoteExecutionV2FileNode>? files;
  BuildBazelRemoteExecutionV2NodeProperties? nodeProperties;

  /// The symlinks in the directory.
  core.List<BuildBazelRemoteExecutionV2SymlinkNode>? symlinks;

  BuildBazelRemoteExecutionV2Directory();

  BuildBazelRemoteExecutionV2Directory.fromJson(core.Map _json) {
    if (_json.containsKey('directories')) {
      directories = (_json['directories'] as core.List)
          .map<BuildBazelRemoteExecutionV2DirectoryNode>((value) =>
              BuildBazelRemoteExecutionV2DirectoryNode.fromJson(
                  value as core.Map<core.String, core.dynamic>))
          .toList();
    }
    if (_json.containsKey('files')) {
      files = (_json['files'] as core.List)
          .map<BuildBazelRemoteExecutionV2FileNode>((value) =>
              BuildBazelRemoteExecutionV2FileNode.fromJson(
                  value as core.Map<core.String, core.dynamic>))
          .toList();
    }
    if (_json.containsKey('nodeProperties')) {
      nodeProperties = BuildBazelRemoteExecutionV2NodeProperties.fromJson(
          _json['nodeProperties'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('symlinks')) {
      symlinks = (_json['symlinks'] as core.List)
          .map<BuildBazelRemoteExecutionV2SymlinkNode>((value) =>
              BuildBazelRemoteExecutionV2SymlinkNode.fromJson(
                  value as core.Map<core.String, core.dynamic>))
          .toList();
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (directories != null)
          'directories': directories!.map((value) => value.toJson()).toList(),
        if (files != null)
          'files': files!.map((value) => value.toJson()).toList(),
        if (nodeProperties != null) 'nodeProperties': nodeProperties!.toJson(),
        if (symlinks != null)
          'symlinks': symlinks!.map((value) => value.toJson()).toList(),
      };
}

/// A `DirectoryNode` represents a child of a Directory which is itself a
/// `Directory` and its associated metadata.
class BuildBazelRemoteExecutionV2DirectoryNode {
  /// The digest of the Directory object represented.
  ///
  /// See Digest for information about how to take the digest of a proto
  /// message.
  BuildBazelRemoteExecutionV2Digest? digest;

  /// The name of the directory.
  core.String? name;

  BuildBazelRemoteExecutionV2DirectoryNode();

  BuildBazelRemoteExecutionV2DirectoryNode.fromJson(core.Map _json) {
    if (_json.containsKey('digest')) {
      digest = BuildBazelRemoteExecutionV2Digest.fromJson(
          _json['digest'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('name')) {
      name = _json['name'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (digest != null) 'digest': digest!.toJson(),
        if (name != null) 'name': name!,
      };
}

/// Metadata about an ongoing execution, which will be contained in the metadata
/// field of the Operation.
class BuildBazelRemoteExecutionV2ExecuteOperationMetadata {
  /// The digest of the Action being executed.
  BuildBazelRemoteExecutionV2Digest? actionDigest;

  /// The current stage of execution.
  /// Possible string values are:
  /// - "UNKNOWN" : Invalid value.
  /// - "CACHE_CHECK" : Checking the result against the cache.
  /// - "QUEUED" : Currently idle, awaiting a free machine to execute.
  /// - "EXECUTING" : Currently being executed by a worker.
  /// - "COMPLETED" : Finished execution.
  core.String? stage;

  /// If set, the client can use this resource name with ByteStream.Read to
  /// stream the standard error from the endpoint hosting streamed responses.
  core.String? stderrStreamName;

  /// If set, the client can use this resource name with ByteStream.Read to
  /// stream the standard output from the endpoint hosting streamed responses.
  core.String? stdoutStreamName;

  BuildBazelRemoteExecutionV2ExecuteOperationMetadata();

  BuildBazelRemoteExecutionV2ExecuteOperationMetadata.fromJson(core.Map _json) {
    if (_json.containsKey('actionDigest')) {
      actionDigest = BuildBazelRemoteExecutionV2Digest.fromJson(
          _json['actionDigest'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('stage')) {
      stage = _json['stage'] as core.String;
    }
    if (_json.containsKey('stderrStreamName')) {
      stderrStreamName = _json['stderrStreamName'] as core.String;
    }
    if (_json.containsKey('stdoutStreamName')) {
      stdoutStreamName = _json['stdoutStreamName'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (actionDigest != null) 'actionDigest': actionDigest!.toJson(),
        if (stage != null) 'stage': stage!,
        if (stderrStreamName != null) 'stderrStreamName': stderrStreamName!,
        if (stdoutStreamName != null) 'stdoutStreamName': stdoutStreamName!,
      };
}

/// A request message for Execution.Execute.
class BuildBazelRemoteExecutionV2ExecuteRequest {
  /// The digest of the Action to execute.
  BuildBazelRemoteExecutionV2Digest? actionDigest;

  /// An optional policy for execution of the action.
  ///
  /// The server will have a default policy if this is not provided.
  BuildBazelRemoteExecutionV2ExecutionPolicy? executionPolicy;

  /// An optional policy for the results of this execution in the remote cache.
  ///
  /// The server will have a default policy if this is not provided. This may be
  /// applied to both the ActionResult and the associated blobs.
  BuildBazelRemoteExecutionV2ResultsCachePolicy? resultsCachePolicy;

  /// If true, the action will be executed even if its result is already present
  /// in the ActionCache.
  ///
  /// The execution is still allowed to be merged with other in-flight
  /// executions of the same action, however - semantically, the service MUST
  /// only guarantee that the results of an execution with this field set were
  /// not visible before the corresponding execution request was sent. Note that
  /// actions from execution requests setting this field set are still eligible
  /// to be entered into the action cache upon completion, and services SHOULD
  /// overwrite any existing entries that may exist. This allows
  /// skip_cache_lookup requests to be used as a mechanism for replacing action
  /// cache entries that reference outputs no longer available or that are
  /// poisoned in any way. If false, the result may be served from the action
  /// cache.
  core.bool? skipCacheLookup;

  BuildBazelRemoteExecutionV2ExecuteRequest();

  BuildBazelRemoteExecutionV2ExecuteRequest.fromJson(core.Map _json) {
    if (_json.containsKey('actionDigest')) {
      actionDigest = BuildBazelRemoteExecutionV2Digest.fromJson(
          _json['actionDigest'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('executionPolicy')) {
      executionPolicy = BuildBazelRemoteExecutionV2ExecutionPolicy.fromJson(
          _json['executionPolicy'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('resultsCachePolicy')) {
      resultsCachePolicy =
          BuildBazelRemoteExecutionV2ResultsCachePolicy.fromJson(
              _json['resultsCachePolicy']
                  as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('skipCacheLookup')) {
      skipCacheLookup = _json['skipCacheLookup'] as core.bool;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (actionDigest != null) 'actionDigest': actionDigest!.toJson(),
        if (executionPolicy != null)
          'executionPolicy': executionPolicy!.toJson(),
        if (resultsCachePolicy != null)
          'resultsCachePolicy': resultsCachePolicy!.toJson(),
        if (skipCacheLookup != null) 'skipCacheLookup': skipCacheLookup!,
      };
}

/// The response message for Execution.Execute, which will be contained in the
/// response field of the Operation.
class BuildBazelRemoteExecutionV2ExecuteResponse {
  /// True if the result was served from cache, false if it was executed.
  core.bool? cachedResult;

  /// Freeform informational message with details on the execution of the action
  /// that may be displayed to the user upon failure or when requested
  /// explicitly.
  core.String? message;

  /// The result of the action.
  BuildBazelRemoteExecutionV2ActionResult? result;

  /// An optional list of additional log outputs the server wishes to provide.
  ///
  /// A server can use this to return execution-specific logs however it wishes.
  /// This is intended primarily to make it easier for users to debug issues
  /// that may be outside of the actual job execution, such as by identifying
  /// the worker executing the action or by providing logs from the worker's
  /// setup phase. The keys SHOULD be human readable so that a client can
  /// display them to a user.
  core.Map<core.String, BuildBazelRemoteExecutionV2LogFile>? serverLogs;

  /// If the status has a code other than `OK`, it indicates that the action did
  /// not finish execution.
  ///
  /// For example, if the operation times out during execution, the status will
  /// have a `DEADLINE_EXCEEDED` code. Servers MUST use this field for errors in
  /// execution, rather than the error field on the `Operation` object. If the
  /// status code is other than `OK`, then the result MUST NOT be cached. For an
  /// error status, the `result` field is optional; the server may populate the
  /// output-, stdout-, and stderr-related fields if it has any information
  /// available, such as the stdout and stderr of a timed-out action.
  GoogleRpcStatus? status;

  BuildBazelRemoteExecutionV2ExecuteResponse();

  BuildBazelRemoteExecutionV2ExecuteResponse.fromJson(core.Map _json) {
    if (_json.containsKey('cachedResult')) {
      cachedResult = _json['cachedResult'] as core.bool;
    }
    if (_json.containsKey('message')) {
      message = _json['message'] as core.String;
    }
    if (_json.containsKey('result')) {
      result = BuildBazelRemoteExecutionV2ActionResult.fromJson(
          _json['result'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('serverLogs')) {
      serverLogs =
          (_json['serverLogs'] as core.Map<core.String, core.dynamic>).map(
        (key, item) => core.MapEntry(
          key,
          BuildBazelRemoteExecutionV2LogFile.fromJson(
              item as core.Map<core.String, core.dynamic>),
        ),
      );
    }
    if (_json.containsKey('status')) {
      status = GoogleRpcStatus.fromJson(
          _json['status'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (cachedResult != null) 'cachedResult': cachedResult!,
        if (message != null) 'message': message!,
        if (result != null) 'result': result!.toJson(),
        if (serverLogs != null)
          'serverLogs':
              serverLogs!.map((key, item) => core.MapEntry(key, item.toJson())),
        if (status != null) 'status': status!.toJson(),
      };
}

/// ExecutedActionMetadata contains details about a completed execution.
class BuildBazelRemoteExecutionV2ExecutedActionMetadata {
  /// Details that are specific to the kind of worker used.
  ///
  /// For example, on POSIX-like systems this could contain a message with
  /// getrusage(2) statistics.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.List<core.Map<core.String, core.Object>>? auxiliaryMetadata;

  /// When the worker completed executing the action command.
  core.String? executionCompletedTimestamp;

  /// When the worker started executing the action command.
  core.String? executionStartTimestamp;

  /// When the worker finished fetching action inputs.
  core.String? inputFetchCompletedTimestamp;

  /// When the worker started fetching action inputs.
  core.String? inputFetchStartTimestamp;

  /// When the worker finished uploading action outputs.
  core.String? outputUploadCompletedTimestamp;

  /// When the worker started uploading action outputs.
  core.String? outputUploadStartTimestamp;

  /// When was the action added to the queue.
  core.String? queuedTimestamp;

  /// The name of the worker which ran the execution.
  core.String? worker;

  /// When the worker completed the action, including all stages.
  core.String? workerCompletedTimestamp;

  /// When the worker received the action.
  core.String? workerStartTimestamp;

  BuildBazelRemoteExecutionV2ExecutedActionMetadata();

  BuildBazelRemoteExecutionV2ExecutedActionMetadata.fromJson(core.Map _json) {
    if (_json.containsKey('auxiliaryMetadata')) {
      auxiliaryMetadata = (_json['auxiliaryMetadata'] as core.List)
          .map<core.Map<core.String, core.Object>>(
              (value) => (value as core.Map<core.String, core.dynamic>).map(
                    (key, item) => core.MapEntry(
                      key,
                      item as core.Object,
                    ),
                  ))
          .toList();
    }
    if (_json.containsKey('executionCompletedTimestamp')) {
      executionCompletedTimestamp =
          _json['executionCompletedTimestamp'] as core.String;
    }
    if (_json.containsKey('executionStartTimestamp')) {
      executionStartTimestamp = _json['executionStartTimestamp'] as core.String;
    }
    if (_json.containsKey('inputFetchCompletedTimestamp')) {
      inputFetchCompletedTimestamp =
          _json['inputFetchCompletedTimestamp'] as core.String;
    }
    if (_json.containsKey('inputFetchStartTimestamp')) {
      inputFetchStartTimestamp =
          _json['inputFetchStartTimestamp'] as core.String;
    }
    if (_json.containsKey('outputUploadCompletedTimestamp')) {
      outputUploadCompletedTimestamp =
          _json['outputUploadCompletedTimestamp'] as core.String;
    }
    if (_json.containsKey('outputUploadStartTimestamp')) {
      outputUploadStartTimestamp =
          _json['outputUploadStartTimestamp'] as core.String;
    }
    if (_json.containsKey('queuedTimestamp')) {
      queuedTimestamp = _json['queuedTimestamp'] as core.String;
    }
    if (_json.containsKey('worker')) {
      worker = _json['worker'] as core.String;
    }
    if (_json.containsKey('workerCompletedTimestamp')) {
      workerCompletedTimestamp =
          _json['workerCompletedTimestamp'] as core.String;
    }
    if (_json.containsKey('workerStartTimestamp')) {
      workerStartTimestamp = _json['workerStartTimestamp'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (auxiliaryMetadata != null) 'auxiliaryMetadata': auxiliaryMetadata!,
        if (executionCompletedTimestamp != null)
          'executionCompletedTimestamp': executionCompletedTimestamp!,
        if (executionStartTimestamp != null)
          'executionStartTimestamp': executionStartTimestamp!,
        if (inputFetchCompletedTimestamp != null)
          'inputFetchCompletedTimestamp': inputFetchCompletedTimestamp!,
        if (inputFetchStartTimestamp != null)
          'inputFetchStartTimestamp': inputFetchStartTimestamp!,
        if (outputUploadCompletedTimestamp != null)
          'outputUploadCompletedTimestamp': outputUploadCompletedTimestamp!,
        if (outputUploadStartTimestamp != null)
          'outputUploadStartTimestamp': outputUploadStartTimestamp!,
        if (queuedTimestamp != null) 'queuedTimestamp': queuedTimestamp!,
        if (worker != null) 'worker': worker!,
        if (workerCompletedTimestamp != null)
          'workerCompletedTimestamp': workerCompletedTimestamp!,
        if (workerStartTimestamp != null)
          'workerStartTimestamp': workerStartTimestamp!,
      };
}

/// Capabilities of the remote execution system.
class BuildBazelRemoteExecutionV2ExecutionCapabilities {
  /// Remote execution may only support a single digest function.
  /// Possible string values are:
  /// - "UNKNOWN" : It is an error for the server to return this value.
  /// - "SHA256" : The SHA-256 digest function.
  /// - "SHA1" : The SHA-1 digest function.
  /// - "MD5" : The MD5 digest function.
  /// - "VSO" : The Microsoft "VSO-Hash" paged SHA256 digest function. See
  /// https://github.com/microsoft/BuildXL/blob/master/Documentation/Specs/PagedHash.md
  /// .
  /// - "SHA384" : The SHA-384 digest function.
  /// - "SHA512" : The SHA-512 digest function.
  /// - "MURMUR3" : Murmur3 128-bit digest function, x64 variant. Note that this
  /// is not a cryptographic hash function and its collision properties are not
  /// strongly guaranteed. See
  /// https://github.com/aappleby/smhasher/wiki/MurmurHash3 .
  core.String? digestFunction;

  /// Whether remote execution is enabled for the particular server/instance.
  core.bool? execEnabled;

  /// Supported execution priority range.
  BuildBazelRemoteExecutionV2PriorityCapabilities?
      executionPriorityCapabilities;

  /// Supported node properties.
  core.List<core.String>? supportedNodeProperties;

  BuildBazelRemoteExecutionV2ExecutionCapabilities();

  BuildBazelRemoteExecutionV2ExecutionCapabilities.fromJson(core.Map _json) {
    if (_json.containsKey('digestFunction')) {
      digestFunction = _json['digestFunction'] as core.String;
    }
    if (_json.containsKey('execEnabled')) {
      execEnabled = _json['execEnabled'] as core.bool;
    }
    if (_json.containsKey('executionPriorityCapabilities')) {
      executionPriorityCapabilities =
          BuildBazelRemoteExecutionV2PriorityCapabilities.fromJson(
              _json['executionPriorityCapabilities']
                  as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('supportedNodeProperties')) {
      supportedNodeProperties = (_json['supportedNodeProperties'] as core.List)
          .map<core.String>((value) => value as core.String)
          .toList();
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (digestFunction != null) 'digestFunction': digestFunction!,
        if (execEnabled != null) 'execEnabled': execEnabled!,
        if (executionPriorityCapabilities != null)
          'executionPriorityCapabilities':
              executionPriorityCapabilities!.toJson(),
        if (supportedNodeProperties != null)
          'supportedNodeProperties': supportedNodeProperties!,
      };
}

/// An `ExecutionPolicy` can be used to control the scheduling of the action.
class BuildBazelRemoteExecutionV2ExecutionPolicy {
  /// The priority (relative importance) of this action.
  ///
  /// Generally, a lower value means that the action should be run sooner than
  /// actions having a greater priority value, but the interpretation of a given
  /// value is server- dependent. A priority of 0 means the *default* priority.
  /// Priorities may be positive or negative, and such actions should run later
  /// or sooner than actions having the default priority, respectively. The
  /// particular semantics of this field is up to the server. In particular,
  /// every server will have their own supported range of priorities, and will
  /// decide how these map into scheduling policy.
  core.int? priority;

  BuildBazelRemoteExecutionV2ExecutionPolicy();

  BuildBazelRemoteExecutionV2ExecutionPolicy.fromJson(core.Map _json) {
    if (_json.containsKey('priority')) {
      priority = _json['priority'] as core.int;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (priority != null) 'priority': priority!,
      };
}

/// A `FileNode` represents a single file and associated metadata.
class BuildBazelRemoteExecutionV2FileNode {
  /// The digest of the file's content.
  BuildBazelRemoteExecutionV2Digest? digest;

  /// True if file is executable, false otherwise.
  core.bool? isExecutable;

  /// The name of the file.
  core.String? name;
  BuildBazelRemoteExecutionV2NodeProperties? nodeProperties;

  BuildBazelRemoteExecutionV2FileNode();

  BuildBazelRemoteExecutionV2FileNode.fromJson(core.Map _json) {
    if (_json.containsKey('digest')) {
      digest = BuildBazelRemoteExecutionV2Digest.fromJson(
          _json['digest'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('isExecutable')) {
      isExecutable = _json['isExecutable'] as core.bool;
    }
    if (_json.containsKey('name')) {
      name = _json['name'] as core.String;
    }
    if (_json.containsKey('nodeProperties')) {
      nodeProperties = BuildBazelRemoteExecutionV2NodeProperties.fromJson(
          _json['nodeProperties'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (digest != null) 'digest': digest!.toJson(),
        if (isExecutable != null) 'isExecutable': isExecutable!,
        if (name != null) 'name': name!,
        if (nodeProperties != null) 'nodeProperties': nodeProperties!.toJson(),
      };
}

/// A request message for ContentAddressableStorage.FindMissingBlobs.
class BuildBazelRemoteExecutionV2FindMissingBlobsRequest {
  /// A list of the blobs to check.
  core.List<BuildBazelRemoteExecutionV2Digest>? blobDigests;

  BuildBazelRemoteExecutionV2FindMissingBlobsRequest();

  BuildBazelRemoteExecutionV2FindMissingBlobsRequest.fromJson(core.Map _json) {
    if (_json.containsKey('blobDigests')) {
      blobDigests = (_json['blobDigests'] as core.List)
          .map<BuildBazelRemoteExecutionV2Digest>((value) =>
              BuildBazelRemoteExecutionV2Digest.fromJson(
                  value as core.Map<core.String, core.dynamic>))
          .toList();
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (blobDigests != null)
          'blobDigests': blobDigests!.map((value) => value.toJson()).toList(),
      };
}

/// A response message for ContentAddressableStorage.FindMissingBlobs.
class BuildBazelRemoteExecutionV2FindMissingBlobsResponse {
  /// A list of the blobs requested *not* present in the storage.
  core.List<BuildBazelRemoteExecutionV2Digest>? missingBlobDigests;

  BuildBazelRemoteExecutionV2FindMissingBlobsResponse();

  BuildBazelRemoteExecutionV2FindMissingBlobsResponse.fromJson(core.Map _json) {
    if (_json.containsKey('missingBlobDigests')) {
      missingBlobDigests = (_json['missingBlobDigests'] as core.List)
          .map<BuildBazelRemoteExecutionV2Digest>((value) =>
              BuildBazelRemoteExecutionV2Digest.fromJson(
                  value as core.Map<core.String, core.dynamic>))
          .toList();
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (missingBlobDigests != null)
          'missingBlobDigests':
              missingBlobDigests!.map((value) => value.toJson()).toList(),
      };
}

/// A response message for ContentAddressableStorage.GetTree.
class BuildBazelRemoteExecutionV2GetTreeResponse {
  /// The directories descended from the requested root.
  core.List<BuildBazelRemoteExecutionV2Directory>? directories;

  /// If present, signifies that there are more results which the client can
  /// retrieve by passing this as the page_token in a subsequent request.
  ///
  /// If empty, signifies that this is the last page of results.
  core.String? nextPageToken;

  BuildBazelRemoteExecutionV2GetTreeResponse();

  BuildBazelRemoteExecutionV2GetTreeResponse.fromJson(core.Map _json) {
    if (_json.containsKey('directories')) {
      directories = (_json['directories'] as core.List)
          .map<BuildBazelRemoteExecutionV2Directory>((value) =>
              BuildBazelRemoteExecutionV2Directory.fromJson(
                  value as core.Map<core.String, core.dynamic>))
          .toList();
    }
    if (_json.containsKey('nextPageToken')) {
      nextPageToken = _json['nextPageToken'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (directories != null)
          'directories': directories!.map((value) => value.toJson()).toList(),
        if (nextPageToken != null) 'nextPageToken': nextPageToken!,
      };
}

/// A `LogFile` is a log stored in the CAS.
class BuildBazelRemoteExecutionV2LogFile {
  /// The digest of the log contents.
  BuildBazelRemoteExecutionV2Digest? digest;

  /// This is a hint as to the purpose of the log, and is set to true if the log
  /// is human-readable text that can be usefully displayed to a user, and false
  /// otherwise.
  ///
  /// For instance, if a command-line client wishes to print the server logs to
  /// the terminal for a failed action, this allows it to avoid displaying a
  /// binary file.
  core.bool? humanReadable;

  BuildBazelRemoteExecutionV2LogFile();

  BuildBazelRemoteExecutionV2LogFile.fromJson(core.Map _json) {
    if (_json.containsKey('digest')) {
      digest = BuildBazelRemoteExecutionV2Digest.fromJson(
          _json['digest'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('humanReadable')) {
      humanReadable = _json['humanReadable'] as core.bool;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (digest != null) 'digest': digest!.toJson(),
        if (humanReadable != null) 'humanReadable': humanReadable!,
      };
}

/// Node properties for FileNodes, DirectoryNodes, and SymlinkNodes.
///
/// The server is responsible for specifying the properties that it accepts.
class BuildBazelRemoteExecutionV2NodeProperties {
  /// The file's last modification timestamp.
  core.String? mtime;

  /// A list of string-based NodeProperties.
  core.List<BuildBazelRemoteExecutionV2NodeProperty>? properties;

  /// The UNIX file mode, e.g., 0755.
  core.int? unixMode;

  BuildBazelRemoteExecutionV2NodeProperties();

  BuildBazelRemoteExecutionV2NodeProperties.fromJson(core.Map _json) {
    if (_json.containsKey('mtime')) {
      mtime = _json['mtime'] as core.String;
    }
    if (_json.containsKey('properties')) {
      properties = (_json['properties'] as core.List)
          .map<BuildBazelRemoteExecutionV2NodeProperty>((value) =>
              BuildBazelRemoteExecutionV2NodeProperty.fromJson(
                  value as core.Map<core.String, core.dynamic>))
          .toList();
    }
    if (_json.containsKey('unixMode')) {
      unixMode = _json['unixMode'] as core.int;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (mtime != null) 'mtime': mtime!,
        if (properties != null)
          'properties': properties!.map((value) => value.toJson()).toList(),
        if (unixMode != null) 'unixMode': unixMode!,
      };
}

/// A single property for FileNodes, DirectoryNodes, and SymlinkNodes.
///
/// The server is responsible for specifying the property `name`s that it
/// accepts. If permitted by the server, the same `name` may occur multiple
/// times.
class BuildBazelRemoteExecutionV2NodeProperty {
  /// The property name.
  core.String? name;

  /// The property value.
  core.String? value;

  BuildBazelRemoteExecutionV2NodeProperty();

  BuildBazelRemoteExecutionV2NodeProperty.fromJson(core.Map _json) {
    if (_json.containsKey('name')) {
      name = _json['name'] as core.String;
    }
    if (_json.containsKey('value')) {
      value = _json['value'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (name != null) 'name': name!,
        if (value != null) 'value': value!,
      };
}

/// An `OutputDirectory` is the output in an `ActionResult` corresponding to a
/// directory's full contents rather than a single file.
class BuildBazelRemoteExecutionV2OutputDirectory {
  /// The full path of the directory relative to the working directory.
  ///
  /// The path separator is a forward slash `/`. Since this is a relative path,
  /// it MUST NOT begin with a leading forward slash. The empty string value is
  /// allowed, and it denotes the entire working directory.
  core.String? path;

  /// The digest of the encoded Tree proto containing the directory's contents.
  BuildBazelRemoteExecutionV2Digest? treeDigest;

  BuildBazelRemoteExecutionV2OutputDirectory();

  BuildBazelRemoteExecutionV2OutputDirectory.fromJson(core.Map _json) {
    if (_json.containsKey('path')) {
      path = _json['path'] as core.String;
    }
    if (_json.containsKey('treeDigest')) {
      treeDigest = BuildBazelRemoteExecutionV2Digest.fromJson(
          _json['treeDigest'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (path != null) 'path': path!,
        if (treeDigest != null) 'treeDigest': treeDigest!.toJson(),
      };
}

/// An `OutputFile` is similar to a FileNode, but it is used as an output in an
/// `ActionResult`.
///
/// It allows a full file path rather than only a name.
class BuildBazelRemoteExecutionV2OutputFile {
  /// The contents of the file if inlining was requested.
  ///
  /// The server SHOULD NOT inline file contents unless requested by the client
  /// in the GetActionResultRequest message. The server MAY omit inlining, even
  /// if requested, and MUST do so if inlining would cause the response to
  /// exceed message size limits.
  core.String? contents;
  core.List<core.int> get contentsAsBytes => convert.base64.decode(contents!);

  set contentsAsBytes(core.List<core.int> _bytes) {
    contents =
        convert.base64.encode(_bytes).replaceAll('/', '_').replaceAll('+', '-');
  }

  /// The digest of the file's content.
  BuildBazelRemoteExecutionV2Digest? digest;

  /// True if file is executable, false otherwise.
  core.bool? isExecutable;
  BuildBazelRemoteExecutionV2NodeProperties? nodeProperties;

  /// The full path of the file relative to the working directory, including the
  /// filename.
  ///
  /// The path separator is a forward slash `/`. Since this is a relative path,
  /// it MUST NOT begin with a leading forward slash.
  core.String? path;

  BuildBazelRemoteExecutionV2OutputFile();

  BuildBazelRemoteExecutionV2OutputFile.fromJson(core.Map _json) {
    if (_json.containsKey('contents')) {
      contents = _json['contents'] as core.String;
    }
    if (_json.containsKey('digest')) {
      digest = BuildBazelRemoteExecutionV2Digest.fromJson(
          _json['digest'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('isExecutable')) {
      isExecutable = _json['isExecutable'] as core.bool;
    }
    if (_json.containsKey('nodeProperties')) {
      nodeProperties = BuildBazelRemoteExecutionV2NodeProperties.fromJson(
          _json['nodeProperties'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('path')) {
      path = _json['path'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (contents != null) 'contents': contents!,
        if (digest != null) 'digest': digest!.toJson(),
        if (isExecutable != null) 'isExecutable': isExecutable!,
        if (nodeProperties != null) 'nodeProperties': nodeProperties!.toJson(),
        if (path != null) 'path': path!,
      };
}

/// An `OutputSymlink` is similar to a Symlink, but it is used as an output in
/// an `ActionResult`.
///
/// `OutputSymlink` is binary-compatible with `SymlinkNode`.
class BuildBazelRemoteExecutionV2OutputSymlink {
  BuildBazelRemoteExecutionV2NodeProperties? nodeProperties;

  /// The full path of the symlink relative to the working directory, including
  /// the filename.
  ///
  /// The path separator is a forward slash `/`. Since this is a relative path,
  /// it MUST NOT begin with a leading forward slash.
  core.String? path;

  /// The target path of the symlink.
  ///
  /// The path separator is a forward slash `/`. The target path can be relative
  /// to the parent directory of the symlink or it can be an absolute path
  /// starting with `/`. Support for absolute paths can be checked using the
  /// Capabilities API. `..` components are allowed anywhere in the target path.
  core.String? target;

  BuildBazelRemoteExecutionV2OutputSymlink();

  BuildBazelRemoteExecutionV2OutputSymlink.fromJson(core.Map _json) {
    if (_json.containsKey('nodeProperties')) {
      nodeProperties = BuildBazelRemoteExecutionV2NodeProperties.fromJson(
          _json['nodeProperties'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('path')) {
      path = _json['path'] as core.String;
    }
    if (_json.containsKey('target')) {
      target = _json['target'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (nodeProperties != null) 'nodeProperties': nodeProperties!.toJson(),
        if (path != null) 'path': path!,
        if (target != null) 'target': target!,
      };
}

/// A `Platform` is a set of requirements, such as hardware, operating system,
/// or compiler toolchain, for an Action's execution environment.
///
/// A `Platform` is represented as a series of key-value pairs representing the
/// properties that are required of the platform.
class BuildBazelRemoteExecutionV2Platform {
  /// The properties that make up this platform.
  ///
  /// In order to ensure that equivalent `Platform`s always hash to the same
  /// value, the properties MUST be lexicographically sorted by name, and then
  /// by value. Sorting of strings is done by code point, equivalently, by the
  /// UTF-8 bytes.
  core.List<BuildBazelRemoteExecutionV2PlatformProperty>? properties;

  BuildBazelRemoteExecutionV2Platform();

  BuildBazelRemoteExecutionV2Platform.fromJson(core.Map _json) {
    if (_json.containsKey('properties')) {
      properties = (_json['properties'] as core.List)
          .map<BuildBazelRemoteExecutionV2PlatformProperty>((value) =>
              BuildBazelRemoteExecutionV2PlatformProperty.fromJson(
                  value as core.Map<core.String, core.dynamic>))
          .toList();
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (properties != null)
          'properties': properties!.map((value) => value.toJson()).toList(),
      };
}

/// A single property for the environment.
///
/// The server is responsible for specifying the property `name`s that it
/// accepts. If an unknown `name` is provided in the requirements for an Action,
/// the server SHOULD reject the execution request. If permitted by the server,
/// the same `name` may occur multiple times. The server is also responsible for
/// specifying the interpretation of property `value`s. For instance, a property
/// describing how much RAM must be available may be interpreted as allowing a
/// worker with 16GB to fulfill a request for 8GB, while a property describing
/// the OS environment on which the action must be performed may require an
/// exact match with the worker's OS. The server MAY use the `value` of one or
/// more properties to determine how it sets up the execution environment, such
/// as by making specific system files available to the worker. Both names and
/// values are typically case-sensitive. Note that the platform is implicitly
/// part of the action digest, so even tiny changes in the names or values (like
/// changing case) may result in different action cache entries.
class BuildBazelRemoteExecutionV2PlatformProperty {
  /// The property name.
  core.String? name;

  /// The property value.
  core.String? value;

  BuildBazelRemoteExecutionV2PlatformProperty();

  BuildBazelRemoteExecutionV2PlatformProperty.fromJson(core.Map _json) {
    if (_json.containsKey('name')) {
      name = _json['name'] as core.String;
    }
    if (_json.containsKey('value')) {
      value = _json['value'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (name != null) 'name': name!,
        if (value != null) 'value': value!,
      };
}

/// Allowed values for priority in ResultsCachePolicy and ExecutionPolicy Used
/// for querying both cache and execution valid priority ranges.
class BuildBazelRemoteExecutionV2PriorityCapabilities {
  core.List<BuildBazelRemoteExecutionV2PriorityCapabilitiesPriorityRange>?
      priorities;

  BuildBazelRemoteExecutionV2PriorityCapabilities();

  BuildBazelRemoteExecutionV2PriorityCapabilities.fromJson(core.Map _json) {
    if (_json.containsKey('priorities')) {
      priorities = (_json['priorities'] as core.List)
          .map<BuildBazelRemoteExecutionV2PriorityCapabilitiesPriorityRange>(
              (value) =>
                  BuildBazelRemoteExecutionV2PriorityCapabilitiesPriorityRange
                      .fromJson(value as core.Map<core.String, core.dynamic>))
          .toList();
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (priorities != null)
          'priorities': priorities!.map((value) => value.toJson()).toList(),
      };
}

/// Supported range of priorities, including boundaries.
class BuildBazelRemoteExecutionV2PriorityCapabilitiesPriorityRange {
  /// The maximum numeric value for this priority range, which represents the
  /// least urgent task or shortest retained item.
  core.int? maxPriority;

  /// The minimum numeric value for this priority range, which represents the
  /// most urgent task or longest retained item.
  core.int? minPriority;

  BuildBazelRemoteExecutionV2PriorityCapabilitiesPriorityRange();

  BuildBazelRemoteExecutionV2PriorityCapabilitiesPriorityRange.fromJson(
      core.Map _json) {
    if (_json.containsKey('maxPriority')) {
      maxPriority = _json['maxPriority'] as core.int;
    }
    if (_json.containsKey('minPriority')) {
      minPriority = _json['minPriority'] as core.int;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (maxPriority != null) 'maxPriority': maxPriority!,
        if (minPriority != null) 'minPriority': minPriority!,
      };
}

/// An optional Metadata to attach to any RPC request to tell the server about
/// an external context of the request.
///
/// The server may use this for logging or other purposes. To use it, the client
/// attaches the header to the call using the canonical proto serialization: *
/// name: `build.bazel.remote.execution.v2.requestmetadata-bin` * contents: the
/// base64 encoded binary `RequestMetadata` message. Note: the gRPC library
/// serializes binary headers encoded in base 64 by default
/// (https://github.com/grpc/grpc/blob/master/doc/PROTOCOL-HTTP2.md#requests).
/// Therefore, if the gRPC library is used to pass/retrieve this metadata, the
/// user may ignore the base64 encoding and assume it is simply serialized as a
/// binary message.
class BuildBazelRemoteExecutionV2RequestMetadata {
  /// An identifier that ties multiple requests to the same action.
  ///
  /// For example, multiple requests to the CAS, Action Cache, and Execution API
  /// are used in order to compile foo.cc.
  core.String? actionId;

  /// An identifier to tie multiple tool invocations together.
  ///
  /// For example, runs of foo_test, bar_test and baz_test on a post-submit of a
  /// given patch.
  core.String? correlatedInvocationsId;

  /// The details for the tool invoking the requests.
  BuildBazelRemoteExecutionV2ToolDetails? toolDetails;

  /// An identifier that ties multiple actions together to a final result.
  ///
  /// For example, multiple actions are required to build and run foo_test.
  core.String? toolInvocationId;

  BuildBazelRemoteExecutionV2RequestMetadata();

  BuildBazelRemoteExecutionV2RequestMetadata.fromJson(core.Map _json) {
    if (_json.containsKey('actionId')) {
      actionId = _json['actionId'] as core.String;
    }
    if (_json.containsKey('correlatedInvocationsId')) {
      correlatedInvocationsId = _json['correlatedInvocationsId'] as core.String;
    }
    if (_json.containsKey('toolDetails')) {
      toolDetails = BuildBazelRemoteExecutionV2ToolDetails.fromJson(
          _json['toolDetails'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('toolInvocationId')) {
      toolInvocationId = _json['toolInvocationId'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (actionId != null) 'actionId': actionId!,
        if (correlatedInvocationsId != null)
          'correlatedInvocationsId': correlatedInvocationsId!,
        if (toolDetails != null) 'toolDetails': toolDetails!.toJson(),
        if (toolInvocationId != null) 'toolInvocationId': toolInvocationId!,
      };
}

/// A `ResultsCachePolicy` is used for fine-grained control over how action
/// outputs are stored in the CAS and Action Cache.
class BuildBazelRemoteExecutionV2ResultsCachePolicy {
  /// The priority (relative importance) of this content in the overall cache.
  ///
  /// Generally, a lower value means a longer retention time or other advantage,
  /// but the interpretation of a given value is server-dependent. A priority of
  /// 0 means a *default* value, decided by the server. The particular semantics
  /// of this field is up to the server. In particular, every server will have
  /// their own supported range of priorities, and will decide how these map
  /// into retention/eviction policy.
  core.int? priority;

  BuildBazelRemoteExecutionV2ResultsCachePolicy();

  BuildBazelRemoteExecutionV2ResultsCachePolicy.fromJson(core.Map _json) {
    if (_json.containsKey('priority')) {
      priority = _json['priority'] as core.int;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (priority != null) 'priority': priority!,
      };
}

/// A response message for Capabilities.GetCapabilities.
class BuildBazelRemoteExecutionV2ServerCapabilities {
  /// Capabilities of the remote cache system.
  BuildBazelRemoteExecutionV2CacheCapabilities? cacheCapabilities;

  /// Earliest RE API version supported, including deprecated versions.
  BuildBazelSemverSemVer? deprecatedApiVersion;

  /// Capabilities of the remote execution system.
  BuildBazelRemoteExecutionV2ExecutionCapabilities? executionCapabilities;

  /// Latest RE API version supported.
  BuildBazelSemverSemVer? highApiVersion;

  /// Earliest non-deprecated RE API version supported.
  BuildBazelSemverSemVer? lowApiVersion;

  BuildBazelRemoteExecutionV2ServerCapabilities();

  BuildBazelRemoteExecutionV2ServerCapabilities.fromJson(core.Map _json) {
    if (_json.containsKey('cacheCapabilities')) {
      cacheCapabilities = BuildBazelRemoteExecutionV2CacheCapabilities.fromJson(
          _json['cacheCapabilities'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('deprecatedApiVersion')) {
      deprecatedApiVersion = BuildBazelSemverSemVer.fromJson(
          _json['deprecatedApiVersion'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('executionCapabilities')) {
      executionCapabilities =
          BuildBazelRemoteExecutionV2ExecutionCapabilities.fromJson(
              _json['executionCapabilities']
                  as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('highApiVersion')) {
      highApiVersion = BuildBazelSemverSemVer.fromJson(
          _json['highApiVersion'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('lowApiVersion')) {
      lowApiVersion = BuildBazelSemverSemVer.fromJson(
          _json['lowApiVersion'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (cacheCapabilities != null)
          'cacheCapabilities': cacheCapabilities!.toJson(),
        if (deprecatedApiVersion != null)
          'deprecatedApiVersion': deprecatedApiVersion!.toJson(),
        if (executionCapabilities != null)
          'executionCapabilities': executionCapabilities!.toJson(),
        if (highApiVersion != null) 'highApiVersion': highApiVersion!.toJson(),
        if (lowApiVersion != null) 'lowApiVersion': lowApiVersion!.toJson(),
      };
}

/// A `SymlinkNode` represents a symbolic link.
class BuildBazelRemoteExecutionV2SymlinkNode {
  /// The name of the symlink.
  core.String? name;
  BuildBazelRemoteExecutionV2NodeProperties? nodeProperties;

  /// The target path of the symlink.
  ///
  /// The path separator is a forward slash `/`. The target path can be relative
  /// to the parent directory of the symlink or it can be an absolute path
  /// starting with `/`. Support for absolute paths can be checked using the
  /// Capabilities API. `..` components are allowed anywhere in the target path
  /// as logical canonicalization may lead to different behavior in the presence
  /// of directory symlinks (e.g. `foo/../bar` may not be the same as `bar`). To
  /// reduce potential cache misses, canonicalization is still recommended where
  /// this is possible without impacting correctness.
  core.String? target;

  BuildBazelRemoteExecutionV2SymlinkNode();

  BuildBazelRemoteExecutionV2SymlinkNode.fromJson(core.Map _json) {
    if (_json.containsKey('name')) {
      name = _json['name'] as core.String;
    }
    if (_json.containsKey('nodeProperties')) {
      nodeProperties = BuildBazelRemoteExecutionV2NodeProperties.fromJson(
          _json['nodeProperties'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('target')) {
      target = _json['target'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (name != null) 'name': name!,
        if (nodeProperties != null) 'nodeProperties': nodeProperties!.toJson(),
        if (target != null) 'target': target!,
      };
}

/// Details for the tool used to call the API.
class BuildBazelRemoteExecutionV2ToolDetails {
  /// Name of the tool, e.g. bazel.
  core.String? toolName;

  /// Version of the tool used for the request, e.g. 5.0.3.
  core.String? toolVersion;

  BuildBazelRemoteExecutionV2ToolDetails();

  BuildBazelRemoteExecutionV2ToolDetails.fromJson(core.Map _json) {
    if (_json.containsKey('toolName')) {
      toolName = _json['toolName'] as core.String;
    }
    if (_json.containsKey('toolVersion')) {
      toolVersion = _json['toolVersion'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (toolName != null) 'toolName': toolName!,
        if (toolVersion != null) 'toolVersion': toolVersion!,
      };
}

/// A `Tree` contains all the Directory protos in a single directory Merkle
/// tree, compressed into one message.
class BuildBazelRemoteExecutionV2Tree {
  /// All the child directories: the directories referred to by the root and,
  /// recursively, all its children.
  ///
  /// In order to reconstruct the directory tree, the client must take the
  /// digests of each of the child directories and then build up a tree starting
  /// from the `root`.
  core.List<BuildBazelRemoteExecutionV2Directory>? children;

  /// The root directory in the tree.
  BuildBazelRemoteExecutionV2Directory? root;

  BuildBazelRemoteExecutionV2Tree();

  BuildBazelRemoteExecutionV2Tree.fromJson(core.Map _json) {
    if (_json.containsKey('children')) {
      children = (_json['children'] as core.List)
          .map<BuildBazelRemoteExecutionV2Directory>((value) =>
              BuildBazelRemoteExecutionV2Directory.fromJson(
                  value as core.Map<core.String, core.dynamic>))
          .toList();
    }
    if (_json.containsKey('root')) {
      root = BuildBazelRemoteExecutionV2Directory.fromJson(
          _json['root'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (children != null)
          'children': children!.map((value) => value.toJson()).toList(),
        if (root != null) 'root': root!.toJson(),
      };
}

/// A request message for WaitExecution.
class BuildBazelRemoteExecutionV2WaitExecutionRequest {
  BuildBazelRemoteExecutionV2WaitExecutionRequest();

  BuildBazelRemoteExecutionV2WaitExecutionRequest.fromJson(
      // ignore: avoid_unused_constructor_parameters
      core.Map _json);

  core.Map<core.String, core.dynamic> toJson() => {};
}

/// The full version of a given tool.
class BuildBazelSemverSemVer {
  /// The major version, e.g 10 for 10.2.3.
  core.int? major;

  /// The minor version, e.g. 2 for 10.2.3.
  core.int? minor;

  /// The patch version, e.g 3 for 10.2.3.
  core.int? patch;

  /// The pre-release version.
  ///
  /// Either this field or major/minor/patch fields must be filled. They are
  /// mutually exclusive. Pre-release versions are assumed to be earlier than
  /// any released versions.
  core.String? prerelease;

  BuildBazelSemverSemVer();

  BuildBazelSemverSemVer.fromJson(core.Map _json) {
    if (_json.containsKey('major')) {
      major = _json['major'] as core.int;
    }
    if (_json.containsKey('minor')) {
      minor = _json['minor'] as core.int;
    }
    if (_json.containsKey('patch')) {
      patch = _json['patch'] as core.int;
    }
    if (_json.containsKey('prerelease')) {
      prerelease = _json['prerelease'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (major != null) 'major': major!,
        if (minor != null) 'minor': minor!,
        if (patch != null) 'patch': patch!,
        if (prerelease != null) 'prerelease': prerelease!,
      };
}

/// CommandDuration contains the various duration metrics tracked when a bot
/// performs a command.
class GoogleDevtoolsRemotebuildbotCommandDurations {
  /// The time spent to release the CAS blobs used by the task.
  core.String? casRelease;

  /// The time spent waiting for Container Manager to assign an asynchronous
  /// container for execution.
  core.String? cmWaitForAssignment;

  /// The time spent preparing the command to be run in a Docker container
  /// (includes pulling the Docker image, if necessary).
  core.String? dockerPrep;

  /// The timestamp when docker preparation begins.
  core.String? dockerPrepStartTime;

  /// The time spent downloading the input files and constructing the working
  /// directory.
  core.String? download;

  /// The timestamp when downloading the input files begins.
  core.String? downloadStartTime;

  /// The timestamp when execution begins.
  core.String? execStartTime;

  /// The time spent executing the command (i.e., doing useful work).
  core.String? execution;

  /// The timestamp when preparation is done and bot starts downloading files.
  core.String? isoPrepDone;

  /// The time spent completing the command, in total.
  core.String? overall;

  /// The time spent uploading the stdout logs.
  core.String? stdout;

  /// The time spent uploading the output files.
  core.String? upload;

  /// The timestamp when uploading the output files begins.
  core.String? uploadStartTime;

  GoogleDevtoolsRemotebuildbotCommandDurations();

  GoogleDevtoolsRemotebuildbotCommandDurations.fromJson(core.Map _json) {
    if (_json.containsKey('casRelease')) {
      casRelease = _json['casRelease'] as core.String;
    }
    if (_json.containsKey('cmWaitForAssignment')) {
      cmWaitForAssignment = _json['cmWaitForAssignment'] as core.String;
    }
    if (_json.containsKey('dockerPrep')) {
      dockerPrep = _json['dockerPrep'] as core.String;
    }
    if (_json.containsKey('dockerPrepStartTime')) {
      dockerPrepStartTime = _json['dockerPrepStartTime'] as core.String;
    }
    if (_json.containsKey('download')) {
      download = _json['download'] as core.String;
    }
    if (_json.containsKey('downloadStartTime')) {
      downloadStartTime = _json['downloadStartTime'] as core.String;
    }
    if (_json.containsKey('execStartTime')) {
      execStartTime = _json['execStartTime'] as core.String;
    }
    if (_json.containsKey('execution')) {
      execution = _json['execution'] as core.String;
    }
    if (_json.containsKey('isoPrepDone')) {
      isoPrepDone = _json['isoPrepDone'] as core.String;
    }
    if (_json.containsKey('overall')) {
      overall = _json['overall'] as core.String;
    }
    if (_json.containsKey('stdout')) {
      stdout = _json['stdout'] as core.String;
    }
    if (_json.containsKey('upload')) {
      upload = _json['upload'] as core.String;
    }
    if (_json.containsKey('uploadStartTime')) {
      uploadStartTime = _json['uploadStartTime'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (casRelease != null) 'casRelease': casRelease!,
        if (cmWaitForAssignment != null)
          'cmWaitForAssignment': cmWaitForAssignment!,
        if (dockerPrep != null) 'dockerPrep': dockerPrep!,
        if (dockerPrepStartTime != null)
          'dockerPrepStartTime': dockerPrepStartTime!,
        if (download != null) 'download': download!,
        if (downloadStartTime != null) 'downloadStartTime': downloadStartTime!,
        if (execStartTime != null) 'execStartTime': execStartTime!,
        if (execution != null) 'execution': execution!,
        if (isoPrepDone != null) 'isoPrepDone': isoPrepDone!,
        if (overall != null) 'overall': overall!,
        if (stdout != null) 'stdout': stdout!,
        if (upload != null) 'upload': upload!,
        if (uploadStartTime != null) 'uploadStartTime': uploadStartTime!,
      };
}

/// CommandEvents contains counters for the number of warnings and errors that
/// occurred during the execution of a command.
class GoogleDevtoolsRemotebuildbotCommandEvents {
  /// Indicates if and how Container Manager is being used for task execution.
  /// Possible string values are:
  /// - "NONE" : Container Manager is disabled or not running for this
  /// execution.
  /// - "CONFIG_MATCH" : Container Manager is enabled and there was a matching
  /// container available for use during execution.
  /// - "CONFIG_MISMATCH" : Container Manager is enabled, but there was no
  /// matching container available for execution.
  core.String? cmUsage;

  /// Indicates whether we are using a cached Docker image (true) or had to pull
  /// the Docker image (false) for this command.
  core.bool? dockerCacheHit;

  /// Docker Image name.
  core.String? dockerImageName;

  /// The input cache miss ratio.
  core.double? inputCacheMiss;

  /// The number of errors reported.
  core.String? numErrors;

  /// The number of warnings reported.
  core.String? numWarnings;

  /// Indicates whether an asynchronous container was used for execution.
  core.bool? usedAsyncContainer;

  GoogleDevtoolsRemotebuildbotCommandEvents();

  GoogleDevtoolsRemotebuildbotCommandEvents.fromJson(core.Map _json) {
    if (_json.containsKey('cmUsage')) {
      cmUsage = _json['cmUsage'] as core.String;
    }
    if (_json.containsKey('dockerCacheHit')) {
      dockerCacheHit = _json['dockerCacheHit'] as core.bool;
    }
    if (_json.containsKey('dockerImageName')) {
      dockerImageName = _json['dockerImageName'] as core.String;
    }
    if (_json.containsKey('inputCacheMiss')) {
      inputCacheMiss = (_json['inputCacheMiss'] as core.num).toDouble();
    }
    if (_json.containsKey('numErrors')) {
      numErrors = _json['numErrors'] as core.String;
    }
    if (_json.containsKey('numWarnings')) {
      numWarnings = _json['numWarnings'] as core.String;
    }
    if (_json.containsKey('usedAsyncContainer')) {
      usedAsyncContainer = _json['usedAsyncContainer'] as core.bool;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (cmUsage != null) 'cmUsage': cmUsage!,
        if (dockerCacheHit != null) 'dockerCacheHit': dockerCacheHit!,
        if (dockerImageName != null) 'dockerImageName': dockerImageName!,
        if (inputCacheMiss != null) 'inputCacheMiss': inputCacheMiss!,
        if (numErrors != null) 'numErrors': numErrors!,
        if (numWarnings != null) 'numWarnings': numWarnings!,
        if (usedAsyncContainer != null)
          'usedAsyncContainer': usedAsyncContainer!,
      };
}

/// The internal status of the command result.
class GoogleDevtoolsRemotebuildbotCommandStatus {
  /// The status code.
  /// Possible string values are:
  /// - "OK" : The command succeeded.
  /// - "INVALID_ARGUMENT" : The command input was invalid.
  /// - "DEADLINE_EXCEEDED" : The command had passed its expiry time while it
  /// was still running.
  /// - "NOT_FOUND" : The resources requested by the command were not found.
  /// - "PERMISSION_DENIED" : The command failed due to permission errors.
  /// - "INTERNAL" : The command failed because of some invariants expected by
  /// the underlying system have been broken. This usually indicates a bug wit
  /// the system.
  /// - "ABORTED" : The command was aborted.
  /// - "FAILED_PRECONDITION" : The command failed because the system is not in
  /// a state required for the command, e.g. the command inputs cannot be found
  /// on the server.
  /// - "CLEANUP_ERROR" : The bot failed to do the cleanup, e.g. unable to
  /// delete the command working directory or the command process.
  /// - "DOWNLOAD_INPUTS_ERROR" : The bot failed to download the inputs.
  /// - "UNKNOWN" : Unknown error.
  /// - "UPLOAD_OUTPUTS_ERROR" : The bot failed to upload the outputs.
  /// - "UPLOAD_OUTPUTS_BYTES_LIMIT_EXCEEDED" : The bot tried to upload files
  /// having a total size that is too large.
  /// - "DOCKER_LOGIN_ERROR" : The bot failed to login to docker.
  /// - "DOCKER_IMAGE_PULL_ERROR" : The bot failed to pull docker image.
  /// - "DOCKER_IMAGE_EXIST_ERROR" : The bot failed to check docker images.
  /// - "DUPLICATE_INPUTS" : The inputs contain duplicate files.
  /// - "DOCKER_IMAGE_PERMISSION_DENIED" : The bot doesn't have the permissions
  /// to pull docker images.
  /// - "DOCKER_IMAGE_NOT_FOUND" : The docker image cannot be found.
  /// - "WORKING_DIR_NOT_FOUND" : Working directory is not found.
  /// - "WORKING_DIR_NOT_IN_BASE_DIR" : Working directory is not under the base
  /// directory
  /// - "DOCKER_UNAVAILABLE" : There are issues with docker service/runtime.
  /// - "NO_CUDA_CAPABLE_DEVICE" : The command failed with "no cuda-capable
  /// device is detected" error.
  /// - "REMOTE_CAS_DOWNLOAD_ERROR" : The bot encountered errors from remote CAS
  /// when downloading blobs.
  /// - "REMOTE_CAS_UPLOAD_ERROR" : The bot encountered errors from remote CAS
  /// when uploading blobs.
  /// - "LOCAL_CASPROXY_NOT_RUNNING" : The local casproxy is not running.
  /// - "DOCKER_CREATE_CONTAINER_ERROR" : The bot couldn't start the container.
  /// - "DOCKER_INVALID_ULIMIT" : The docker ulimit is not valid.
  /// - "DOCKER_UNKNOWN_RUNTIME" : The docker runtime is unknown.
  /// - "DOCKER_UNKNOWN_CAPABILITY" : The docker capability is unknown.
  /// - "DOCKER_UNKNOWN_ERROR" : The command failed with unknown docker errors.
  /// - "DOCKER_CREATE_COMPUTE_SYSTEM_ERROR" : Docker failed to run containers
  /// with CreateComputeSystem error.
  /// - "DOCKER_PREPARELAYER_ERROR" : Docker failed to run containers with
  /// hcsshim::PrepareLayer error.
  /// - "DOCKER_INCOMPATIBLE_OS_ERROR" : Docker incompatible operating system
  /// error.
  /// - "DOCKER_CREATE_RUNTIME_FILE_NOT_FOUND" : Docker failed to create OCI
  /// runtime because of file not found.
  /// - "DOCKER_CREATE_RUNTIME_PERMISSION_DENIED" : Docker failed to create OCI
  /// runtime because of permission denied.
  /// - "DOCKER_CREATE_PROCESS_FILE_NOT_FOUND" : Docker failed to create process
  /// because of file not found.
  /// - "DOCKER_CREATE_COMPUTE_SYSTEM_INCORRECT_PARAMETER_ERROR" : Docker failed
  /// to run containers with CreateComputeSystem error that involves an
  /// incorrect parameter (more specific version of
  /// DOCKER_CREATE_COMPUTE_SYSTEM_ERROR that is user-caused).
  /// - "DOCKER_TOO_MANY_SYMBOLIC_LINK_LEVELS" : Docker failed to create an
  /// overlay mount because of too many levels of symbolic links.
  /// - "LOCAL_CONTAINER_MANAGER_NOT_RUNNING" : The local Container Manager is
  /// not running.
  core.String? code;

  /// The error message.
  core.String? message;

  GoogleDevtoolsRemotebuildbotCommandStatus();

  GoogleDevtoolsRemotebuildbotCommandStatus.fromJson(core.Map _json) {
    if (_json.containsKey('code')) {
      code = _json['code'] as core.String;
    }
    if (_json.containsKey('message')) {
      message = _json['message'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (code != null) 'code': code!,
        if (message != null) 'message': message!,
      };
}

/// ResourceUsage is the system resource usage of the host machine.
class GoogleDevtoolsRemotebuildbotResourceUsage {
  core.double? cpuUsedPercent;
  GoogleDevtoolsRemotebuildbotResourceUsageStat? diskUsage;
  GoogleDevtoolsRemotebuildbotResourceUsageStat? memoryUsage;

  GoogleDevtoolsRemotebuildbotResourceUsage();

  GoogleDevtoolsRemotebuildbotResourceUsage.fromJson(core.Map _json) {
    if (_json.containsKey('cpuUsedPercent')) {
      cpuUsedPercent = (_json['cpuUsedPercent'] as core.num).toDouble();
    }
    if (_json.containsKey('diskUsage')) {
      diskUsage = GoogleDevtoolsRemotebuildbotResourceUsageStat.fromJson(
          _json['diskUsage'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('memoryUsage')) {
      memoryUsage = GoogleDevtoolsRemotebuildbotResourceUsageStat.fromJson(
          _json['memoryUsage'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (cpuUsedPercent != null) 'cpuUsedPercent': cpuUsedPercent!,
        if (diskUsage != null) 'diskUsage': diskUsage!.toJson(),
        if (memoryUsage != null) 'memoryUsage': memoryUsage!.toJson(),
      };
}

class GoogleDevtoolsRemotebuildbotResourceUsageStat {
  core.String? total;
  core.String? used;

  GoogleDevtoolsRemotebuildbotResourceUsageStat();

  GoogleDevtoolsRemotebuildbotResourceUsageStat.fromJson(core.Map _json) {
    if (_json.containsKey('total')) {
      total = _json['total'] as core.String;
    }
    if (_json.containsKey('used')) {
      used = _json['used'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (total != null) 'total': total!,
        if (used != null) 'used': used!,
      };
}

/// AcceleratorConfig defines the accelerator cards to attach to the VM.
class GoogleDevtoolsRemotebuildexecutionAdminV1alphaAcceleratorConfig {
  /// The number of guest accelerator cards exposed to each VM.
  core.String? acceleratorCount;

  /// The type of accelerator to attach to each VM, e.g. "nvidia-tesla-k80" for
  /// nVidia Tesla K80.
  core.String? acceleratorType;

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaAcceleratorConfig();

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaAcceleratorConfig.fromJson(
      core.Map _json) {
    if (_json.containsKey('acceleratorCount')) {
      acceleratorCount = _json['acceleratorCount'] as core.String;
    }
    if (_json.containsKey('acceleratorType')) {
      acceleratorType = _json['acceleratorType'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (acceleratorCount != null) 'acceleratorCount': acceleratorCount!,
        if (acceleratorType != null) 'acceleratorType': acceleratorType!,
      };
}

/// Autoscale defines the autoscaling policy of a worker pool.
class GoogleDevtoolsRemotebuildexecutionAdminV1alphaAutoscale {
  /// The maximal number of workers.
  ///
  /// Must be equal to or greater than min_size.
  core.String? maxSize;

  /// The minimal number of workers.
  ///
  /// Must be greater than 0.
  core.String? minSize;

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaAutoscale();

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaAutoscale.fromJson(
      core.Map _json) {
    if (_json.containsKey('maxSize')) {
      maxSize = _json['maxSize'] as core.String;
    }
    if (_json.containsKey('minSize')) {
      minSize = _json['minSize'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (maxSize != null) 'maxSize': maxSize!,
        if (minSize != null) 'minSize': minSize!,
      };
}

/// The request used for `CreateInstance`.
class GoogleDevtoolsRemotebuildexecutionAdminV1alphaCreateInstanceRequest {
  /// Specifies the instance to create.
  ///
  /// The name in the instance, if specified in the instance, is ignored.
  GoogleDevtoolsRemotebuildexecutionAdminV1alphaInstance? instance;

  /// ID of the created instance.
  ///
  /// A valid `instance_id` must: be 6-50 characters long, contain only
  /// lowercase letters, digits, hyphens and underscores, start with a lowercase
  /// letter, and end with a lowercase letter or a digit.
  core.String? instanceId;

  /// Resource name of the project containing the instance.
  ///
  /// Format: `projects/[PROJECT_ID]`.
  core.String? parent;

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaCreateInstanceRequest();

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaCreateInstanceRequest.fromJson(
      core.Map _json) {
    if (_json.containsKey('instance')) {
      instance =
          GoogleDevtoolsRemotebuildexecutionAdminV1alphaInstance.fromJson(
              _json['instance'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('instanceId')) {
      instanceId = _json['instanceId'] as core.String;
    }
    if (_json.containsKey('parent')) {
      parent = _json['parent'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (instance != null) 'instance': instance!.toJson(),
        if (instanceId != null) 'instanceId': instanceId!,
        if (parent != null) 'parent': parent!,
      };
}

/// The request used for `CreateWorkerPool`.
class GoogleDevtoolsRemotebuildexecutionAdminV1alphaCreateWorkerPoolRequest {
  /// Resource name of the instance in which to create the new worker pool.
  ///
  /// Format: `projects/[PROJECT_ID]/instances/[INSTANCE_ID]`.
  core.String? parent;

  /// ID of the created worker pool.
  ///
  /// A valid pool ID must: be 6-50 characters long, contain only lowercase
  /// letters, digits, hyphens and underscores, start with a lowercase letter,
  /// and end with a lowercase letter or a digit.
  core.String? poolId;

  /// Specifies the worker pool to create.
  ///
  /// The name in the worker pool, if specified, is ignored.
  GoogleDevtoolsRemotebuildexecutionAdminV1alphaWorkerPool? workerPool;

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaCreateWorkerPoolRequest();

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaCreateWorkerPoolRequest.fromJson(
      core.Map _json) {
    if (_json.containsKey('parent')) {
      parent = _json['parent'] as core.String;
    }
    if (_json.containsKey('poolId')) {
      poolId = _json['poolId'] as core.String;
    }
    if (_json.containsKey('workerPool')) {
      workerPool =
          GoogleDevtoolsRemotebuildexecutionAdminV1alphaWorkerPool.fromJson(
              _json['workerPool'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (parent != null) 'parent': parent!,
        if (poolId != null) 'poolId': poolId!,
        if (workerPool != null) 'workerPool': workerPool!.toJson(),
      };
}

/// The request used for `DeleteInstance`.
class GoogleDevtoolsRemotebuildexecutionAdminV1alphaDeleteInstanceRequest {
  /// Name of the instance to delete.
  ///
  /// Format: `projects/[PROJECT_ID]/instances/[INSTANCE_ID]`.
  core.String? name;

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaDeleteInstanceRequest();

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaDeleteInstanceRequest.fromJson(
      core.Map _json) {
    if (_json.containsKey('name')) {
      name = _json['name'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (name != null) 'name': name!,
      };
}

/// The request used for DeleteWorkerPool.
class GoogleDevtoolsRemotebuildexecutionAdminV1alphaDeleteWorkerPoolRequest {
  /// Name of the worker pool to delete.
  ///
  /// Format:
  /// `projects/[PROJECT_ID]/instances/[INSTANCE_ID]/workerpools/[POOL_ID]`.
  core.String? name;

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaDeleteWorkerPoolRequest();

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaDeleteWorkerPoolRequest.fromJson(
      core.Map _json) {
    if (_json.containsKey('name')) {
      name = _json['name'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (name != null) 'name': name!,
      };
}

/// FeaturePolicy defines features allowed to be used on RBE instances, as well
/// as instance-wide behavior changes that take effect without opt-in or opt-out
/// at usage time.
class GoogleDevtoolsRemotebuildexecutionAdminV1alphaFeaturePolicy {
  /// Which container image sources are allowed.
  ///
  /// Currently only RBE-supported registry (gcr.io) is allowed. One can allow
  /// all repositories under a project or one specific repository only. E.g.
  /// container_image_sources { policy: RESTRICTED allowed_values: \[
  /// "gcr.io/project-foo", "gcr.io/project-bar/repo-baz", \] } will allow any
  /// repositories under "gcr.io/project-foo" plus the repository
  /// "gcr.io/project-bar/repo-baz". Default (UNSPECIFIED) is equivalent to any
  /// source is allowed.
  GoogleDevtoolsRemotebuildexecutionAdminV1alphaFeaturePolicyFeature?
      containerImageSources;

  /// Whether dockerAddCapabilities can be used or what capabilities are
  /// allowed.
  GoogleDevtoolsRemotebuildexecutionAdminV1alphaFeaturePolicyFeature?
      dockerAddCapabilities;

  /// Whether dockerChrootPath can be used.
  GoogleDevtoolsRemotebuildexecutionAdminV1alphaFeaturePolicyFeature?
      dockerChrootPath;

  /// Whether dockerNetwork can be used or what network modes are allowed.
  ///
  /// E.g. one may allow `off` value only via `allowed_values`.
  GoogleDevtoolsRemotebuildexecutionAdminV1alphaFeaturePolicyFeature?
      dockerNetwork;

  /// Whether dockerPrivileged can be used.
  GoogleDevtoolsRemotebuildexecutionAdminV1alphaFeaturePolicyFeature?
      dockerPrivileged;

  /// Whether dockerRunAsRoot can be used.
  GoogleDevtoolsRemotebuildexecutionAdminV1alphaFeaturePolicyFeature?
      dockerRunAsRoot;

  /// Whether dockerRuntime is allowed to be set or what runtimes are allowed.
  ///
  /// Note linux_isolation takes precedence, and if set, docker_runtime values
  /// may be rejected if they are incompatible with the selected isolation.
  GoogleDevtoolsRemotebuildexecutionAdminV1alphaFeaturePolicyFeature?
      dockerRuntime;

  /// Whether dockerSiblingContainers can be used.
  GoogleDevtoolsRemotebuildexecutionAdminV1alphaFeaturePolicyFeature?
      dockerSiblingContainers;

  /// linux_isolation allows overriding the docker runtime used for containers
  /// started on Linux.
  /// Possible string values are:
  /// - "LINUX_ISOLATION_UNSPECIFIED" : Default value. Will be using Linux
  /// default runtime.
  /// - "GVISOR" : Use gVisor runsc runtime.
  /// - "OFF" : Use stardard Linux runtime. This has the same behaviour as
  /// unspecified, but it can be used to revert back from gVisor.
  core.String? linuxIsolation;

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaFeaturePolicy();

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaFeaturePolicy.fromJson(
      core.Map _json) {
    if (_json.containsKey('containerImageSources')) {
      containerImageSources =
          GoogleDevtoolsRemotebuildexecutionAdminV1alphaFeaturePolicyFeature
              .fromJson(_json['containerImageSources']
                  as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('dockerAddCapabilities')) {
      dockerAddCapabilities =
          GoogleDevtoolsRemotebuildexecutionAdminV1alphaFeaturePolicyFeature
              .fromJson(_json['dockerAddCapabilities']
                  as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('dockerChrootPath')) {
      dockerChrootPath =
          GoogleDevtoolsRemotebuildexecutionAdminV1alphaFeaturePolicyFeature
              .fromJson(_json['dockerChrootPath']
                  as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('dockerNetwork')) {
      dockerNetwork =
          GoogleDevtoolsRemotebuildexecutionAdminV1alphaFeaturePolicyFeature
              .fromJson(_json['dockerNetwork']
                  as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('dockerPrivileged')) {
      dockerPrivileged =
          GoogleDevtoolsRemotebuildexecutionAdminV1alphaFeaturePolicyFeature
              .fromJson(_json['dockerPrivileged']
                  as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('dockerRunAsRoot')) {
      dockerRunAsRoot =
          GoogleDevtoolsRemotebuildexecutionAdminV1alphaFeaturePolicyFeature
              .fromJson(_json['dockerRunAsRoot']
                  as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('dockerRuntime')) {
      dockerRuntime =
          GoogleDevtoolsRemotebuildexecutionAdminV1alphaFeaturePolicyFeature
              .fromJson(_json['dockerRuntime']
                  as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('dockerSiblingContainers')) {
      dockerSiblingContainers =
          GoogleDevtoolsRemotebuildexecutionAdminV1alphaFeaturePolicyFeature
              .fromJson(_json['dockerSiblingContainers']
                  as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('linuxIsolation')) {
      linuxIsolation = _json['linuxIsolation'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (containerImageSources != null)
          'containerImageSources': containerImageSources!.toJson(),
        if (dockerAddCapabilities != null)
          'dockerAddCapabilities': dockerAddCapabilities!.toJson(),
        if (dockerChrootPath != null)
          'dockerChrootPath': dockerChrootPath!.toJson(),
        if (dockerNetwork != null) 'dockerNetwork': dockerNetwork!.toJson(),
        if (dockerPrivileged != null)
          'dockerPrivileged': dockerPrivileged!.toJson(),
        if (dockerRunAsRoot != null)
          'dockerRunAsRoot': dockerRunAsRoot!.toJson(),
        if (dockerRuntime != null) 'dockerRuntime': dockerRuntime!.toJson(),
        if (dockerSiblingContainers != null)
          'dockerSiblingContainers': dockerSiblingContainers!.toJson(),
        if (linuxIsolation != null) 'linuxIsolation': linuxIsolation!,
      };
}

/// Defines whether a feature can be used or what values are accepted.
class GoogleDevtoolsRemotebuildexecutionAdminV1alphaFeaturePolicyFeature {
  /// A list of acceptable values.
  ///
  /// Only effective when the policy is `RESTRICTED`.
  core.List<core.String>? allowedValues;

  /// The policy of the feature.
  /// Possible string values are:
  /// - "POLICY_UNSPECIFIED" : Default value, if not explicitly set. Equivalent
  /// to FORBIDDEN, unless otherwise documented on a specific Feature.
  /// - "ALLOWED" : Feature is explicitly allowed.
  /// - "FORBIDDEN" : Feature is forbidden. Requests attempting to leverage it
  /// will get an FailedPrecondition error, with a message like: "Feature
  /// forbidden by FeaturePolicy: Feature on instance "
  /// - "RESTRICTED" : Only the values specified in the `allowed_values` are
  /// allowed.
  core.String? policy;

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaFeaturePolicyFeature();

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaFeaturePolicyFeature.fromJson(
      core.Map _json) {
    if (_json.containsKey('allowedValues')) {
      allowedValues = (_json['allowedValues'] as core.List)
          .map<core.String>((value) => value as core.String)
          .toList();
    }
    if (_json.containsKey('policy')) {
      policy = _json['policy'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (allowedValues != null) 'allowedValues': allowedValues!,
        if (policy != null) 'policy': policy!,
      };
}

/// The request used for `GetInstance`.
class GoogleDevtoolsRemotebuildexecutionAdminV1alphaGetInstanceRequest {
  /// Name of the instance to retrieve.
  ///
  /// Format: `projects/[PROJECT_ID]/instances/[INSTANCE_ID]`.
  core.String? name;

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaGetInstanceRequest();

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaGetInstanceRequest.fromJson(
      core.Map _json) {
    if (_json.containsKey('name')) {
      name = _json['name'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (name != null) 'name': name!,
      };
}

/// The request used for GetWorkerPool.
class GoogleDevtoolsRemotebuildexecutionAdminV1alphaGetWorkerPoolRequest {
  /// Name of the worker pool to retrieve.
  ///
  /// Format:
  /// `projects/[PROJECT_ID]/instances/[INSTANCE_ID]/workerpools/[POOL_ID]`.
  core.String? name;

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaGetWorkerPoolRequest();

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaGetWorkerPoolRequest.fromJson(
      core.Map _json) {
    if (_json.containsKey('name')) {
      name = _json['name'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (name != null) 'name': name!,
      };
}

/// Instance conceptually encapsulates all Remote Build Execution resources for
/// remote builds.
///
/// An instance consists of storage and compute resources (for example,
/// `ContentAddressableStorage`, `ActionCache`, `WorkerPools`) used for running
/// remote builds. All Remote Build Execution API calls are scoped to an
/// instance.
class GoogleDevtoolsRemotebuildexecutionAdminV1alphaInstance {
  /// The policy to define whether or not RBE features can be used or how they
  /// can be used.
  GoogleDevtoolsRemotebuildexecutionAdminV1alphaFeaturePolicy? featurePolicy;

  /// The location is a GCP region.
  ///
  /// Currently only `us-central1` is supported.
  core.String? location;

  /// Whether stack driver logging is enabled for the instance.
  ///
  /// Output only.
  core.bool? loggingEnabled;

  /// Instance resource name formatted as:
  /// `projects/[PROJECT_ID]/instances/[INSTANCE_ID]`.
  ///
  /// Name should not be populated when creating an instance since it is
  /// provided in the `instance_id` field.
  ///
  /// Output only.
  core.String? name;

  /// State of the instance.
  ///
  /// Output only.
  /// Possible string values are:
  /// - "STATE_UNSPECIFIED" : Not a valid state, but the default value of the
  /// enum.
  /// - "CREATING" : The instance is in state `CREATING` once `CreateInstance`
  /// is called and before the instance is ready for use.
  /// - "RUNNING" : The instance is in state `RUNNING` when it is ready for use.
  /// - "INACTIVE" : An `INACTIVE` instance indicates that there is a problem
  /// that needs to be fixed. Such instances cannot be used for execution and
  /// instances that remain in this state for a significant period of time will
  /// be removed permanently.
  core.String? state;

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaInstance();

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaInstance.fromJson(
      core.Map _json) {
    if (_json.containsKey('featurePolicy')) {
      featurePolicy =
          GoogleDevtoolsRemotebuildexecutionAdminV1alphaFeaturePolicy.fromJson(
              _json['featurePolicy'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('location')) {
      location = _json['location'] as core.String;
    }
    if (_json.containsKey('loggingEnabled')) {
      loggingEnabled = _json['loggingEnabled'] as core.bool;
    }
    if (_json.containsKey('name')) {
      name = _json['name'] as core.String;
    }
    if (_json.containsKey('state')) {
      state = _json['state'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (featurePolicy != null) 'featurePolicy': featurePolicy!.toJson(),
        if (location != null) 'location': location!,
        if (loggingEnabled != null) 'loggingEnabled': loggingEnabled!,
        if (name != null) 'name': name!,
        if (state != null) 'state': state!,
      };
}

class GoogleDevtoolsRemotebuildexecutionAdminV1alphaListInstancesRequest {
  /// Resource name of the project.
  ///
  /// Format: `projects/[PROJECT_ID]`.
  core.String? parent;

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaListInstancesRequest();

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaListInstancesRequest.fromJson(
      core.Map _json) {
    if (_json.containsKey('parent')) {
      parent = _json['parent'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (parent != null) 'parent': parent!,
      };
}

class GoogleDevtoolsRemotebuildexecutionAdminV1alphaListInstancesResponse {
  /// The list of instances in a given project.
  core.List<GoogleDevtoolsRemotebuildexecutionAdminV1alphaInstance>? instances;

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaListInstancesResponse();

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaListInstancesResponse.fromJson(
      core.Map _json) {
    if (_json.containsKey('instances')) {
      instances = (_json['instances'] as core.List)
          .map<GoogleDevtoolsRemotebuildexecutionAdminV1alphaInstance>(
              (value) => GoogleDevtoolsRemotebuildexecutionAdminV1alphaInstance
                  .fromJson(value as core.Map<core.String, core.dynamic>))
          .toList();
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (instances != null)
          'instances': instances!.map((value) => value.toJson()).toList(),
      };
}

class GoogleDevtoolsRemotebuildexecutionAdminV1alphaListWorkerPoolsRequest {
  /// A filter expression that filters resources listed in the response.
  ///
  /// The expression must specify the field name, a comparison operator, and the
  /// value that you want to use for filtering. The value must be a string, a
  /// number, or a boolean. String values are case-insensitive. The comparison
  /// operator must be either `:`, `=`, `!=`, `>`, `>=`, `<=` or `<`. The `:`
  /// operator can be used with string fields to match substrings. For
  /// non-string fields it is equivalent to the `=` operator. The `:*`
  /// comparison can be used to test whether a key has been defined. You can
  /// also filter on nested fields. To filter on multiple expressions, you can
  /// separate expression using `AND` and `OR` operators, using parentheses to
  /// specify precedence. If neither operator is specified, `AND` is assumed.
  /// Examples: Include only pools with more than 100 reserved workers:
  /// `(worker_count > 100) (worker_config.reserved = true)` Include only pools
  /// with a certain label or machines of the e2-standard family:
  /// `worker_config.labels.key1 : * OR worker_config.machine_type: e2-standard`
  ///
  /// Optional.
  core.String? filter;

  /// Resource name of the instance.
  ///
  /// Format: `projects/[PROJECT_ID]/instances/[INSTANCE_ID]`.
  core.String? parent;

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaListWorkerPoolsRequest();

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaListWorkerPoolsRequest.fromJson(
      core.Map _json) {
    if (_json.containsKey('filter')) {
      filter = _json['filter'] as core.String;
    }
    if (_json.containsKey('parent')) {
      parent = _json['parent'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (filter != null) 'filter': filter!,
        if (parent != null) 'parent': parent!,
      };
}

class GoogleDevtoolsRemotebuildexecutionAdminV1alphaListWorkerPoolsResponse {
  /// The list of worker pools in a given instance.
  core.List<GoogleDevtoolsRemotebuildexecutionAdminV1alphaWorkerPool>?
      workerPools;

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaListWorkerPoolsResponse();

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaListWorkerPoolsResponse.fromJson(
      core.Map _json) {
    if (_json.containsKey('workerPools')) {
      workerPools = (_json['workerPools'] as core.List)
          .map<GoogleDevtoolsRemotebuildexecutionAdminV1alphaWorkerPool>(
              (value) =>
                  GoogleDevtoolsRemotebuildexecutionAdminV1alphaWorkerPool
                      .fromJson(value as core.Map<core.String, core.dynamic>))
          .toList();
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (workerPools != null)
          'workerPools': workerPools!.map((value) => value.toJson()).toList(),
      };
}

/// The request used for `UpdateInstance`.
class GoogleDevtoolsRemotebuildexecutionAdminV1alphaUpdateInstanceRequest {
  /// Specifies the instance to update.
  GoogleDevtoolsRemotebuildexecutionAdminV1alphaInstance? instance;

  /// Deprecated, use instance.logging_enabled instead.
  ///
  /// Whether to enable Stackdriver logging for this instance.
  core.bool? loggingEnabled;

  /// Deprecated, use instance.Name instead.
  ///
  /// Name of the instance to update. Format:
  /// `projects/[PROJECT_ID]/instances/[INSTANCE_ID]`.
  core.String? name;

  /// The update mask applies to instance.
  ///
  /// For the `FieldMask` definition, see
  /// https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#fieldmask
  /// If an empty update_mask is provided, only the non-default valued field in
  /// the worker pool field will be updated. Note that in order to update a
  /// field to the default value (zero, false, empty string) an explicit
  /// update_mask must be provided.
  core.String? updateMask;

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaUpdateInstanceRequest();

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaUpdateInstanceRequest.fromJson(
      core.Map _json) {
    if (_json.containsKey('instance')) {
      instance =
          GoogleDevtoolsRemotebuildexecutionAdminV1alphaInstance.fromJson(
              _json['instance'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('loggingEnabled')) {
      loggingEnabled = _json['loggingEnabled'] as core.bool;
    }
    if (_json.containsKey('name')) {
      name = _json['name'] as core.String;
    }
    if (_json.containsKey('updateMask')) {
      updateMask = _json['updateMask'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (instance != null) 'instance': instance!.toJson(),
        if (loggingEnabled != null) 'loggingEnabled': loggingEnabled!,
        if (name != null) 'name': name!,
        if (updateMask != null) 'updateMask': updateMask!,
      };
}

/// The request used for UpdateWorkerPool.
class GoogleDevtoolsRemotebuildexecutionAdminV1alphaUpdateWorkerPoolRequest {
  /// The update mask applies to worker_pool.
  ///
  /// For the `FieldMask` definition, see
  /// https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#fieldmask
  /// If an empty update_mask is provided, only the non-default valued field in
  /// the worker pool field will be updated. Note that in order to update a
  /// field to the default value (zero, false, empty string) an explicit
  /// update_mask must be provided.
  core.String? updateMask;

  /// Specifies the worker pool to update.
  GoogleDevtoolsRemotebuildexecutionAdminV1alphaWorkerPool? workerPool;

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaUpdateWorkerPoolRequest();

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaUpdateWorkerPoolRequest.fromJson(
      core.Map _json) {
    if (_json.containsKey('updateMask')) {
      updateMask = _json['updateMask'] as core.String;
    }
    if (_json.containsKey('workerPool')) {
      workerPool =
          GoogleDevtoolsRemotebuildexecutionAdminV1alphaWorkerPool.fromJson(
              _json['workerPool'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (updateMask != null) 'updateMask': updateMask!,
        if (workerPool != null) 'workerPool': workerPool!.toJson(),
      };
}

/// Defines the configuration to be used for creating workers in the worker
/// pool.
class GoogleDevtoolsRemotebuildexecutionAdminV1alphaWorkerConfig {
  /// The accelerator card attached to each VM.
  GoogleDevtoolsRemotebuildexecutionAdminV1alphaAcceleratorConfig? accelerator;

  /// Size of the disk attached to the worker, in GB.
  ///
  /// See https://cloud.google.com/compute/docs/disks/
  ///
  /// Required.
  core.String? diskSizeGb;

  /// Disk Type to use for the worker.
  ///
  /// See
  /// [Storage options](https://cloud.google.com/compute/docs/disks/#introduction).
  /// Currently only `pd-standard` and `pd-ssd` are supported.
  ///
  /// Required.
  core.String? diskType;

  /// Labels associated with the workers.
  ///
  /// Label keys and values can be no longer than 63 characters, can only
  /// contain lowercase letters, numeric characters, underscores and dashes.
  /// International letters are permitted. Label keys must start with a letter.
  /// Label values are optional. There can not be more than 64 labels per
  /// resource.
  core.Map<core.String, core.String>? labels;

  /// Machine type of the worker, such as `e2-standard-2`.
  ///
  /// See https://cloud.google.com/compute/docs/machine-types for a list of
  /// supported machine types. Note that `f1-micro` and `g1-small` are not yet
  /// supported.
  ///
  /// Required.
  core.String? machineType;

  /// The maximum number of actions a worker can execute concurrently.
  core.String? maxConcurrentActions;

  /// Minimum CPU platform to use when creating the worker.
  ///
  /// See [CPU Platforms](https://cloud.google.com/compute/docs/cpu-platforms).
  core.String? minCpuPlatform;

  /// Determines the type of network access granted to workers.
  ///
  /// Possible values: - "public": Workers can connect to the public internet. -
  /// "private": Workers can only connect to Google APIs and services. -
  /// "restricted-private": Workers can only connect to Google APIs that are
  /// reachable through `restricted.googleapis.com` (`199.36.153.4/30`).
  core.String? networkAccess;

  /// Determines whether the worker is reserved (equivalent to a Compute Engine
  /// on-demand VM and therefore won't be preempted).
  ///
  /// See [Preemptible VMs](https://cloud.google.com/preemptible-vms/) for more
  /// details.
  core.bool? reserved;

  /// The node type name to be used for sole-tenant nodes.
  core.String? soleTenantNodeType;

  /// The name of the image used by each VM.
  core.String? vmImage;

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaWorkerConfig();

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaWorkerConfig.fromJson(
      core.Map _json) {
    if (_json.containsKey('accelerator')) {
      accelerator =
          GoogleDevtoolsRemotebuildexecutionAdminV1alphaAcceleratorConfig
              .fromJson(
                  _json['accelerator'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('diskSizeGb')) {
      diskSizeGb = _json['diskSizeGb'] as core.String;
    }
    if (_json.containsKey('diskType')) {
      diskType = _json['diskType'] as core.String;
    }
    if (_json.containsKey('labels')) {
      labels = (_json['labels'] as core.Map<core.String, core.dynamic>).map(
        (key, item) => core.MapEntry(
          key,
          item as core.String,
        ),
      );
    }
    if (_json.containsKey('machineType')) {
      machineType = _json['machineType'] as core.String;
    }
    if (_json.containsKey('maxConcurrentActions')) {
      maxConcurrentActions = _json['maxConcurrentActions'] as core.String;
    }
    if (_json.containsKey('minCpuPlatform')) {
      minCpuPlatform = _json['minCpuPlatform'] as core.String;
    }
    if (_json.containsKey('networkAccess')) {
      networkAccess = _json['networkAccess'] as core.String;
    }
    if (_json.containsKey('reserved')) {
      reserved = _json['reserved'] as core.bool;
    }
    if (_json.containsKey('soleTenantNodeType')) {
      soleTenantNodeType = _json['soleTenantNodeType'] as core.String;
    }
    if (_json.containsKey('vmImage')) {
      vmImage = _json['vmImage'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (accelerator != null) 'accelerator': accelerator!.toJson(),
        if (diskSizeGb != null) 'diskSizeGb': diskSizeGb!,
        if (diskType != null) 'diskType': diskType!,
        if (labels != null) 'labels': labels!,
        if (machineType != null) 'machineType': machineType!,
        if (maxConcurrentActions != null)
          'maxConcurrentActions': maxConcurrentActions!,
        if (minCpuPlatform != null) 'minCpuPlatform': minCpuPlatform!,
        if (networkAccess != null) 'networkAccess': networkAccess!,
        if (reserved != null) 'reserved': reserved!,
        if (soleTenantNodeType != null)
          'soleTenantNodeType': soleTenantNodeType!,
        if (vmImage != null) 'vmImage': vmImage!,
      };
}

/// A worker pool resource in the Remote Build Execution API.
class GoogleDevtoolsRemotebuildexecutionAdminV1alphaWorkerPool {
  /// The autoscale policy to apply on a pool.
  GoogleDevtoolsRemotebuildexecutionAdminV1alphaAutoscale? autoscale;

  /// Channel specifies the release channel of the pool.
  core.String? channel;

  /// WorkerPool resource name formatted as:
  /// `projects/[PROJECT_ID]/instances/[INSTANCE_ID]/workerpools/[POOL_ID]`.
  ///
  /// name should not be populated when creating a worker pool since it is
  /// provided in the `poolId` field.
  core.String? name;

  /// State of the worker pool.
  ///
  /// Output only.
  /// Possible string values are:
  /// - "STATE_UNSPECIFIED" : Not a valid state, but the default value of the
  /// enum.
  /// - "CREATING" : The worker pool is in state `CREATING` once
  /// `CreateWorkerPool` is called and before all requested workers are ready.
  /// - "RUNNING" : The worker pool is in state `RUNNING` when all its workers
  /// are ready for use.
  /// - "UPDATING" : The worker pool is in state `UPDATING` once
  /// `UpdateWorkerPool` is called and before the new configuration has all the
  /// requested workers ready for use, and no older configuration has any
  /// workers. At that point the state transitions to `RUNNING`.
  /// - "DELETING" : The worker pool is in state `DELETING` once the `Delete`
  /// method is called and before the deletion completes.
  /// - "INACTIVE" : The worker pool is in state `INACTIVE` when the instance
  /// hosting the worker pool in not running.
  core.String? state;

  /// Specifies the properties, such as machine type and disk size, used for
  /// creating workers in a worker pool.
  GoogleDevtoolsRemotebuildexecutionAdminV1alphaWorkerConfig? workerConfig;

  /// The desired number of workers in the worker pool.
  ///
  /// Must be a value between 0 and 15000.
  core.String? workerCount;

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaWorkerPool();

  GoogleDevtoolsRemotebuildexecutionAdminV1alphaWorkerPool.fromJson(
      core.Map _json) {
    if (_json.containsKey('autoscale')) {
      autoscale =
          GoogleDevtoolsRemotebuildexecutionAdminV1alphaAutoscale.fromJson(
              _json['autoscale'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('channel')) {
      channel = _json['channel'] as core.String;
    }
    if (_json.containsKey('name')) {
      name = _json['name'] as core.String;
    }
    if (_json.containsKey('state')) {
      state = _json['state'] as core.String;
    }
    if (_json.containsKey('workerConfig')) {
      workerConfig =
          GoogleDevtoolsRemotebuildexecutionAdminV1alphaWorkerConfig.fromJson(
              _json['workerConfig'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('workerCount')) {
      workerCount = _json['workerCount'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (autoscale != null) 'autoscale': autoscale!.toJson(),
        if (channel != null) 'channel': channel!,
        if (name != null) 'name': name!,
        if (state != null) 'state': state!,
        if (workerConfig != null) 'workerConfig': workerConfig!.toJson(),
        if (workerCount != null) 'workerCount': workerCount!,
      };
}

/// AdminTemp is a prelimiary set of administration tasks.
///
/// It's called "Temp" because we do not yet know the best way to represent
/// admin tasks; it's possible that this will be entirely replaced in later
/// versions of this API. If this message proves to be sufficient, it will be
/// renamed in the alpha or beta release of this API. This message (suitably
/// marshalled into a protobuf.Any) can be used as the inline_assignment field
/// in a lease; the lease assignment field should simply be `"admin"` in these
/// cases. This message is heavily based on Swarming administration tasks from
/// the LUCI project (http://github.com/luci/luci-py/appengine/swarming).
class GoogleDevtoolsRemoteworkersV1test2AdminTemp {
  /// The argument to the admin action; see `Command` for semantics.
  core.String? arg;

  /// The admin action; see `Command` for legal values.
  /// Possible string values are:
  /// - "UNSPECIFIED" : Illegal value.
  /// - "BOT_UPDATE" : Download and run a new version of the bot. `arg` will be
  /// a resource accessible via `ByteStream.Read` to obtain the new bot code.
  /// - "BOT_RESTART" : Restart the bot without downloading a new version. `arg`
  /// will be a message to log.
  /// - "BOT_TERMINATE" : Shut down the bot. `arg` will be a task resource name
  /// (similar to those in tasks.proto) that the bot can use to tell the server
  /// that it is terminating.
  /// - "HOST_RESTART" : Restart the host computer. `arg` will be a message to
  /// log.
  core.String? command;

  GoogleDevtoolsRemoteworkersV1test2AdminTemp();

  GoogleDevtoolsRemoteworkersV1test2AdminTemp.fromJson(core.Map _json) {
    if (_json.containsKey('arg')) {
      arg = _json['arg'] as core.String;
    }
    if (_json.containsKey('command')) {
      command = _json['command'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (arg != null) 'arg': arg!,
        if (command != null) 'command': command!,
      };
}

/// Describes a blob of binary content with its digest.
class GoogleDevtoolsRemoteworkersV1test2Blob {
  /// The contents of the blob.
  core.String? contents;
  core.List<core.int> get contentsAsBytes => convert.base64.decode(contents!);

  set contentsAsBytes(core.List<core.int> _bytes) {
    contents =
        convert.base64.encode(_bytes).replaceAll('/', '_').replaceAll('+', '-');
  }

  /// The digest of the blob.
  ///
  /// This should be verified by the receiver.
  GoogleDevtoolsRemoteworkersV1test2Digest? digest;

  GoogleDevtoolsRemoteworkersV1test2Blob();

  GoogleDevtoolsRemoteworkersV1test2Blob.fromJson(core.Map _json) {
    if (_json.containsKey('contents')) {
      contents = _json['contents'] as core.String;
    }
    if (_json.containsKey('digest')) {
      digest = GoogleDevtoolsRemoteworkersV1test2Digest.fromJson(
          _json['digest'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (contents != null) 'contents': contents!,
        if (digest != null) 'digest': digest!.toJson(),
      };
}

/// DEPRECATED - use CommandResult instead.
///
/// Describes the actual outputs from the task.
class GoogleDevtoolsRemoteworkersV1test2CommandOutputs {
  /// exit_code is only fully reliable if the status' code is OK.
  ///
  /// If the task exceeded its deadline or was cancelled, the process may still
  /// produce an exit code as it is cancelled, and this will be populated, but a
  /// successful (zero) is unlikely to be correct unless the status code is OK.
  core.int? exitCode;

  /// The output files.
  ///
  /// The blob referenced by the digest should contain one of the following
  /// (implementation-dependent): * A marshalled DirectoryMetadata of the
  /// returned filesystem * A LUCI-style .isolated file
  GoogleDevtoolsRemoteworkersV1test2Digest? outputs;

  GoogleDevtoolsRemoteworkersV1test2CommandOutputs();

  GoogleDevtoolsRemoteworkersV1test2CommandOutputs.fromJson(core.Map _json) {
    if (_json.containsKey('exitCode')) {
      exitCode = _json['exitCode'] as core.int;
    }
    if (_json.containsKey('outputs')) {
      outputs = GoogleDevtoolsRemoteworkersV1test2Digest.fromJson(
          _json['outputs'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (exitCode != null) 'exitCode': exitCode!,
        if (outputs != null) 'outputs': outputs!.toJson(),
      };
}

/// DEPRECATED - use CommandResult instead.
///
/// Can be used as part of CompleteRequest.metadata, or are part of a more
/// sophisticated message.
class GoogleDevtoolsRemoteworkersV1test2CommandOverhead {
  /// The elapsed time between calling Accept and Complete.
  ///
  /// The server will also have its own idea of what this should be, but this
  /// excludes the overhead of the RPCs and the bot response time.
  core.String? duration;

  /// The amount of time *not* spent executing the command (ie
  /// uploading/downloading files).
  core.String? overhead;

  GoogleDevtoolsRemoteworkersV1test2CommandOverhead();

  GoogleDevtoolsRemoteworkersV1test2CommandOverhead.fromJson(core.Map _json) {
    if (_json.containsKey('duration')) {
      duration = _json['duration'] as core.String;
    }
    if (_json.containsKey('overhead')) {
      overhead = _json['overhead'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (duration != null) 'duration': duration!,
        if (overhead != null) 'overhead': overhead!,
      };
}

/// All information about the execution of a command, suitable for providing as
/// the Bots interface's `Lease.result` field.
class GoogleDevtoolsRemoteworkersV1test2CommandResult {
  /// The elapsed time between calling Accept and Complete.
  ///
  /// The server will also have its own idea of what this should be, but this
  /// excludes the overhead of the RPCs and the bot response time.
  core.String? duration;

  /// The exit code of the process.
  ///
  /// An exit code of "0" should only be trusted if `status` has a code of OK
  /// (otherwise it may simply be unset).
  core.int? exitCode;

  /// Implementation-dependent metadata about the task.
  ///
  /// Both servers and bots may define messages which can be encoded here; bots
  /// are free to provide metadata in multiple formats, and servers are free to
  /// choose one or more of the values to process and ignore others. In
  /// particular, it is *not* considered an error for the bot to provide the
  /// server with a field that it doesn't know about.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.List<core.Map<core.String, core.Object>>? metadata;

  /// The output files.
  ///
  /// The blob referenced by the digest should contain one of the following
  /// (implementation-dependent): * A marshalled DirectoryMetadata of the
  /// returned filesystem * A LUCI-style .isolated file
  GoogleDevtoolsRemoteworkersV1test2Digest? outputs;

  /// The amount of time *not* spent executing the command (ie
  /// uploading/downloading files).
  core.String? overhead;

  /// An overall status for the command.
  ///
  /// For example, if the command timed out, this might have a code of
  /// DEADLINE_EXCEEDED; if it was killed by the OS for memory exhaustion, it
  /// might have a code of RESOURCE_EXHAUSTED.
  GoogleRpcStatus? status;

  GoogleDevtoolsRemoteworkersV1test2CommandResult();

  GoogleDevtoolsRemoteworkersV1test2CommandResult.fromJson(core.Map _json) {
    if (_json.containsKey('duration')) {
      duration = _json['duration'] as core.String;
    }
    if (_json.containsKey('exitCode')) {
      exitCode = _json['exitCode'] as core.int;
    }
    if (_json.containsKey('metadata')) {
      metadata = (_json['metadata'] as core.List)
          .map<core.Map<core.String, core.Object>>(
              (value) => (value as core.Map<core.String, core.dynamic>).map(
                    (key, item) => core.MapEntry(
                      key,
                      item as core.Object,
                    ),
                  ))
          .toList();
    }
    if (_json.containsKey('outputs')) {
      outputs = GoogleDevtoolsRemoteworkersV1test2Digest.fromJson(
          _json['outputs'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('overhead')) {
      overhead = _json['overhead'] as core.String;
    }
    if (_json.containsKey('status')) {
      status = GoogleRpcStatus.fromJson(
          _json['status'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (duration != null) 'duration': duration!,
        if (exitCode != null) 'exitCode': exitCode!,
        if (metadata != null) 'metadata': metadata!,
        if (outputs != null) 'outputs': outputs!.toJson(),
        if (overhead != null) 'overhead': overhead!,
        if (status != null) 'status': status!.toJson(),
      };
}

/// Describes a shell-style task to execute, suitable for providing as the Bots
/// interface's `Lease.payload` field.
class GoogleDevtoolsRemoteworkersV1test2CommandTask {
  /// The expected outputs from the task.
  GoogleDevtoolsRemoteworkersV1test2CommandTaskOutputs? expectedOutputs;

  /// The inputs to the task.
  GoogleDevtoolsRemoteworkersV1test2CommandTaskInputs? inputs;

  /// The timeouts of this task.
  GoogleDevtoolsRemoteworkersV1test2CommandTaskTimeouts? timeouts;

  GoogleDevtoolsRemoteworkersV1test2CommandTask();

  GoogleDevtoolsRemoteworkersV1test2CommandTask.fromJson(core.Map _json) {
    if (_json.containsKey('expectedOutputs')) {
      expectedOutputs =
          GoogleDevtoolsRemoteworkersV1test2CommandTaskOutputs.fromJson(
              _json['expectedOutputs'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('inputs')) {
      inputs = GoogleDevtoolsRemoteworkersV1test2CommandTaskInputs.fromJson(
          _json['inputs'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('timeouts')) {
      timeouts = GoogleDevtoolsRemoteworkersV1test2CommandTaskTimeouts.fromJson(
          _json['timeouts'] as core.Map<core.String, core.dynamic>);
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (expectedOutputs != null)
          'expectedOutputs': expectedOutputs!.toJson(),
        if (inputs != null) 'inputs': inputs!.toJson(),
        if (timeouts != null) 'timeouts': timeouts!.toJson(),
      };
}

/// Describes the inputs to a shell-style task.
class GoogleDevtoolsRemoteworkersV1test2CommandTaskInputs {
  /// The command itself to run (e.g., argv).
  ///
  /// This field should be passed directly to the underlying operating system,
  /// and so it must be sensible to that operating system. For example, on
  /// Windows, the first argument might be "C:\Windows\System32\ping.exe" - that
  /// is, using drive letters and backslashes. A command for a *nix system, on
  /// the other hand, would use forward slashes. All other fields in the RWAPI
  /// must consistently use forward slashes, since those fields may be
  /// interpretted by both the service and the bot.
  core.List<core.String>? arguments;

  /// All environment variables required by the task.
  core.List<
          GoogleDevtoolsRemoteworkersV1test2CommandTaskInputsEnvironmentVariable>?
      environmentVariables;

  /// The input filesystem to be set up prior to the task beginning.
  ///
  /// The contents should be a repeated set of FileMetadata messages though
  /// other formats are allowed if better for the implementation (eg, a
  /// LUCI-style .isolated file). This field is repeated since implementations
  /// might want to cache the metadata, in which case it may be useful to break
  /// up portions of the filesystem that change frequently (eg, specific input
  /// files) from those that don't (eg, standard header files).
  core.List<GoogleDevtoolsRemoteworkersV1test2Digest>? files;

  /// Inline contents for blobs expected to be needed by the bot to execute the
  /// task.
  ///
  /// For example, contents of entries in `files` or blobs that are indirectly
  /// referenced by an entry there. The bot should check against this list
  /// before downloading required task inputs to reduce the number of
  /// communications between itself and the remote CAS server.
  core.List<GoogleDevtoolsRemoteworkersV1test2Blob>? inlineBlobs;

  /// Directory from which a command is executed.
  ///
  /// It is a relative directory with respect to the bot's working directory
  /// (i.e., "./"). If it is non-empty, then it must exist under "./".
  /// Otherwise, "./" will be used.
  core.String? workingDirectory;

  GoogleDevtoolsRemoteworkersV1test2CommandTaskInputs();

  GoogleDevtoolsRemoteworkersV1test2CommandTaskInputs.fromJson(core.Map _json) {
    if (_json.containsKey('arguments')) {
      arguments = (_json['arguments'] as core.List)
          .map<core.String>((value) => value as core.String)
          .toList();
    }
    if (_json.containsKey('environmentVariables')) {
      environmentVariables = (_json['environmentVariables'] as core.List)
          .map<GoogleDevtoolsRemoteworkersV1test2CommandTaskInputsEnvironmentVariable>(
              (value) =>
                  GoogleDevtoolsRemoteworkersV1test2CommandTaskInputsEnvironmentVariable
                      .fromJson(value as core.Map<core.String, core.dynamic>))
          .toList();
    }
    if (_json.containsKey('files')) {
      files = (_json['files'] as core.List)
          .map<GoogleDevtoolsRemoteworkersV1test2Digest>((value) =>
              GoogleDevtoolsRemoteworkersV1test2Digest.fromJson(
                  value as core.Map<core.String, core.dynamic>))
          .toList();
    }
    if (_json.containsKey('inlineBlobs')) {
      inlineBlobs = (_json['inlineBlobs'] as core.List)
          .map<GoogleDevtoolsRemoteworkersV1test2Blob>((value) =>
              GoogleDevtoolsRemoteworkersV1test2Blob.fromJson(
                  value as core.Map<core.String, core.dynamic>))
          .toList();
    }
    if (_json.containsKey('workingDirectory')) {
      workingDirectory = _json['workingDirectory'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (arguments != null) 'arguments': arguments!,
        if (environmentVariables != null)
          'environmentVariables':
              environmentVariables!.map((value) => value.toJson()).toList(),
        if (files != null)
          'files': files!.map((value) => value.toJson()).toList(),
        if (inlineBlobs != null)
          'inlineBlobs': inlineBlobs!.map((value) => value.toJson()).toList(),
        if (workingDirectory != null) 'workingDirectory': workingDirectory!,
      };
}

/// An environment variable required by this task.
class GoogleDevtoolsRemoteworkersV1test2CommandTaskInputsEnvironmentVariable {
  /// The envvar name.
  core.String? name;

  /// The envvar value.
  core.String? value;

  GoogleDevtoolsRemoteworkersV1test2CommandTaskInputsEnvironmentVariable();

  GoogleDevtoolsRemoteworkersV1test2CommandTaskInputsEnvironmentVariable.fromJson(
      core.Map _json) {
    if (_json.containsKey('name')) {
      name = _json['name'] as core.String;
    }
    if (_json.containsKey('value')) {
      value = _json['value'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (name != null) 'name': name!,
        if (value != null) 'value': value!,
      };
}

/// Describes the expected outputs of the command.
class GoogleDevtoolsRemoteworkersV1test2CommandTaskOutputs {
  /// A list of expected directories, relative to the execution root.
  ///
  /// All paths MUST be delimited by forward slashes.
  core.List<core.String>? directories;

  /// A list of expected files, relative to the execution root.
  ///
  /// All paths MUST be delimited by forward slashes.
  core.List<core.String>? files;

  /// The destination to which any stderr should be sent.
  ///
  /// The method by which the bot should send the stream contents to that
  /// destination is not defined in this API. As examples, the destination could
  /// be a file referenced in the `files` field in this message, or it could be
  /// a URI that must be written via the ByteStream API.
  core.String? stderrDestination;

  /// The destination to which any stdout should be sent.
  ///
  /// The method by which the bot should send the stream contents to that
  /// destination is not defined in this API. As examples, the destination could
  /// be a file referenced in the `files` field in this message, or it could be
  /// a URI that must be written via the ByteStream API.
  core.String? stdoutDestination;

  GoogleDevtoolsRemoteworkersV1test2CommandTaskOutputs();

  GoogleDevtoolsRemoteworkersV1test2CommandTaskOutputs.fromJson(
      core.Map _json) {
    if (_json.containsKey('directories')) {
      directories = (_json['directories'] as core.List)
          .map<core.String>((value) => value as core.String)
          .toList();
    }
    if (_json.containsKey('files')) {
      files = (_json['files'] as core.List)
          .map<core.String>((value) => value as core.String)
          .toList();
    }
    if (_json.containsKey('stderrDestination')) {
      stderrDestination = _json['stderrDestination'] as core.String;
    }
    if (_json.containsKey('stdoutDestination')) {
      stdoutDestination = _json['stdoutDestination'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (directories != null) 'directories': directories!,
        if (files != null) 'files': files!,
        if (stderrDestination != null) 'stderrDestination': stderrDestination!,
        if (stdoutDestination != null) 'stdoutDestination': stdoutDestination!,
      };
}

/// Describes the timeouts associated with this task.
class GoogleDevtoolsRemoteworkersV1test2CommandTaskTimeouts {
  /// This specifies the maximum time that the task can run, excluding the time
  /// required to download inputs or upload outputs.
  ///
  /// That is, the worker will terminate the task if it runs longer than this.
  core.String? execution;

  /// This specifies the maximum amount of time the task can be idle - that is,
  /// go without generating some output in either stdout or stderr.
  ///
  /// If the process is silent for more than the specified time, the worker will
  /// terminate the task.
  core.String? idle;

  /// If the execution or IO timeouts are exceeded, the worker will try to
  /// gracefully terminate the task and return any existing logs.
  ///
  /// However, tasks may be hard-frozen in which case this process will fail.
  /// This timeout specifies how long to wait for a terminated task to shut down
  /// gracefully (e.g. via SIGTERM) before we bring down the hammer (e.g.
  /// SIGKILL on *nix, CTRL_BREAK_EVENT on Windows).
  core.String? shutdown;

  GoogleDevtoolsRemoteworkersV1test2CommandTaskTimeouts();

  GoogleDevtoolsRemoteworkersV1test2CommandTaskTimeouts.fromJson(
      core.Map _json) {
    if (_json.containsKey('execution')) {
      execution = _json['execution'] as core.String;
    }
    if (_json.containsKey('idle')) {
      idle = _json['idle'] as core.String;
    }
    if (_json.containsKey('shutdown')) {
      shutdown = _json['shutdown'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (execution != null) 'execution': execution!,
        if (idle != null) 'idle': idle!,
        if (shutdown != null) 'shutdown': shutdown!,
      };
}

/// The CommandTask and CommandResult messages assume the existence of a service
/// that can serve blobs of content, identified by a hash and size known as a
/// "digest." The method by which these blobs may be retrieved is not specified
/// here, but a model implementation is in the Remote Execution API's
/// "ContentAddressibleStorage" interface.
///
/// In the context of the RWAPI, a Digest will virtually always refer to the
/// contents of a file or a directory. The latter is represented by the
/// byte-encoded Directory message.
class GoogleDevtoolsRemoteworkersV1test2Digest {
  /// A string-encoded hash (eg "1a2b3c", not the byte array \[0x1a, 0x2b,
  /// 0x3c\]) using an implementation-defined hash algorithm (eg SHA-256).
  core.String? hash;

  /// The size of the contents.
  ///
  /// While this is not strictly required as part of an identifier (after all,
  /// any given hash will have exactly one canonical size), it's useful in
  /// almost all cases when one might want to send or retrieve blobs of content
  /// and is included here for this reason.
  core.String? sizeBytes;

  GoogleDevtoolsRemoteworkersV1test2Digest();

  GoogleDevtoolsRemoteworkersV1test2Digest.fromJson(core.Map _json) {
    if (_json.containsKey('hash')) {
      hash = _json['hash'] as core.String;
    }
    if (_json.containsKey('sizeBytes')) {
      sizeBytes = _json['sizeBytes'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (hash != null) 'hash': hash!,
        if (sizeBytes != null) 'sizeBytes': sizeBytes!,
      };
}

/// The contents of a directory.
///
/// Similar to the equivalent message in the Remote Execution API.
class GoogleDevtoolsRemoteworkersV1test2Directory {
  /// Any subdirectories
  core.List<GoogleDevtoolsRemoteworkersV1test2DirectoryMetadata>? directories;

  /// The files in this directory
  core.List<GoogleDevtoolsRemoteworkersV1test2FileMetadata>? files;

  GoogleDevtoolsRemoteworkersV1test2Directory();

  GoogleDevtoolsRemoteworkersV1test2Directory.fromJson(core.Map _json) {
    if (_json.containsKey('directories')) {
      directories = (_json['directories'] as core.List)
          .map<GoogleDevtoolsRemoteworkersV1test2DirectoryMetadata>((value) =>
              GoogleDevtoolsRemoteworkersV1test2DirectoryMetadata.fromJson(
                  value as core.Map<core.String, core.dynamic>))
          .toList();
    }
    if (_json.containsKey('files')) {
      files = (_json['files'] as core.List)
          .map<GoogleDevtoolsRemoteworkersV1test2FileMetadata>((value) =>
              GoogleDevtoolsRemoteworkersV1test2FileMetadata.fromJson(
                  value as core.Map<core.String, core.dynamic>))
          .toList();
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (directories != null)
          'directories': directories!.map((value) => value.toJson()).toList(),
        if (files != null)
          'files': files!.map((value) => value.toJson()).toList(),
      };
}

/// The metadata for a directory.
///
/// Similar to the equivalent message in the Remote Execution API.
class GoogleDevtoolsRemoteworkersV1test2DirectoryMetadata {
  /// A pointer to the contents of the directory, in the form of a marshalled
  /// Directory message.
  GoogleDevtoolsRemoteworkersV1test2Digest? digest;

  /// The path of the directory, as in FileMetadata.path.
  core.String? path;

  GoogleDevtoolsRemoteworkersV1test2DirectoryMetadata();

  GoogleDevtoolsRemoteworkersV1test2DirectoryMetadata.fromJson(core.Map _json) {
    if (_json.containsKey('digest')) {
      digest = GoogleDevtoolsRemoteworkersV1test2Digest.fromJson(
          _json['digest'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('path')) {
      path = _json['path'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (digest != null) 'digest': digest!.toJson(),
        if (path != null) 'path': path!,
      };
}

/// The metadata for a file.
///
/// Similar to the equivalent message in the Remote Execution API.
class GoogleDevtoolsRemoteworkersV1test2FileMetadata {
  /// If the file is small enough, its contents may also or alternatively be
  /// listed here.
  core.String? contents;
  core.List<core.int> get contentsAsBytes => convert.base64.decode(contents!);

  set contentsAsBytes(core.List<core.int> _bytes) {
    contents =
        convert.base64.encode(_bytes).replaceAll('/', '_').replaceAll('+', '-');
  }

  /// A pointer to the contents of the file.
  ///
  /// The method by which a client retrieves the contents from a CAS system is
  /// not defined here.
  GoogleDevtoolsRemoteworkersV1test2Digest? digest;

  /// Properties of the file
  core.bool? isExecutable;

  /// The path of this file.
  ///
  /// If this message is part of the CommandOutputs.outputs fields, the path is
  /// relative to the execution root and must correspond to an entry in
  /// CommandTask.outputs.files. If this message is part of a Directory message,
  /// then the path is relative to the root of that directory. All paths MUST be
  /// delimited by forward slashes.
  core.String? path;

  GoogleDevtoolsRemoteworkersV1test2FileMetadata();

  GoogleDevtoolsRemoteworkersV1test2FileMetadata.fromJson(core.Map _json) {
    if (_json.containsKey('contents')) {
      contents = _json['contents'] as core.String;
    }
    if (_json.containsKey('digest')) {
      digest = GoogleDevtoolsRemoteworkersV1test2Digest.fromJson(
          _json['digest'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('isExecutable')) {
      isExecutable = _json['isExecutable'] as core.bool;
    }
    if (_json.containsKey('path')) {
      path = _json['path'] as core.String;
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (contents != null) 'contents': contents!,
        if (digest != null) 'digest': digest!.toJson(),
        if (isExecutable != null) 'isExecutable': isExecutable!,
        if (path != null) 'path': path!,
      };
}

/// This resource represents a long-running operation that is the result of a
/// network API call.
class GoogleLongrunningOperation {
  /// If the value is `false`, it means the operation is still in progress.
  ///
  /// If `true`, the operation is completed, and either `error` or `response` is
  /// available.
  core.bool? done;

  /// The error result of the operation in case of failure or cancellation.
  GoogleRpcStatus? error;

  /// Service-specific metadata associated with the operation.
  ///
  /// It typically contains progress information and common metadata such as
  /// create time. Some services might not provide such metadata. Any method
  /// that returns a long-running operation should document the metadata type,
  /// if any.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object>? metadata;

  /// The server-assigned name, which is only unique within the same service
  /// that originally returns it.
  ///
  /// If you use the default HTTP mapping, the `name` should be a resource name
  /// ending with `operations/{unique_id}`.
  core.String? name;

  /// The normal response of the operation in case of success.
  ///
  /// If the original method returns no data on success, such as `Delete`, the
  /// response is `google.protobuf.Empty`. If the original method is standard
  /// `Get`/`Create`/`Update`, the response should be the resource. For other
  /// methods, the response should have the type `XxxResponse`, where `Xxx` is
  /// the original method name. For example, if the original method name is
  /// `TakeSnapshot()`, the inferred response type is `TakeSnapshotResponse`.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.Map<core.String, core.Object>? response;

  GoogleLongrunningOperation();

  GoogleLongrunningOperation.fromJson(core.Map _json) {
    if (_json.containsKey('done')) {
      done = _json['done'] as core.bool;
    }
    if (_json.containsKey('error')) {
      error = GoogleRpcStatus.fromJson(
          _json['error'] as core.Map<core.String, core.dynamic>);
    }
    if (_json.containsKey('metadata')) {
      metadata = (_json['metadata'] as core.Map<core.String, core.dynamic>).map(
        (key, item) => core.MapEntry(
          key,
          item as core.Object,
        ),
      );
    }
    if (_json.containsKey('name')) {
      name = _json['name'] as core.String;
    }
    if (_json.containsKey('response')) {
      response = (_json['response'] as core.Map<core.String, core.dynamic>).map(
        (key, item) => core.MapEntry(
          key,
          item as core.Object,
        ),
      );
    }
  }

  core.Map<core.String, core.dynamic> toJson() => {
        if (done != null) 'done': done!,
        if (error != null) 'error': error!.toJson(),
        if (metadata != null) 'metadata': metadata!,
        if (name != null) 'name': name!,
        if (response != null) 'response': response!,
      };
}

/// The `Status` type defines a logical error model that is suitable for
/// different programming environments, including REST APIs and RPC APIs.
///
/// It is used by [gRPC](https://github.com/grpc). Each `Status` message
/// contains three pieces of data: error code, error message, and error details.
/// You can find out more about this error model and how to work with it in the
/// [API Design Guide](https://cloud.google.com/apis/design/errors).
class GoogleRpcStatus {
  /// The status code, which should be an enum value of google.rpc.Code.
  core.int? code;

  /// A list of messages that carry the error details.
  ///
  /// There is a common set of message types for APIs to use.
  ///
  /// The values for Object must be JSON objects. It can consist of `num`,
  /// `String`, `bool` and `null` as well as `Map` and `List` values.
  core.List<core.Map<core.String, core.Object>>? details;

  /// A developer-facing error message, which should be in English.
  ///
  /// Any user-facing error message should be localized and sent in the
  /// google.rpc.Status.details field, or localized by the client.
  core.String? message;

  GoogleRpcStatus();

  GoogleRpcStatus.fromJson(core.Map _json) {
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
