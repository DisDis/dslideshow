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
import 'package:googleapis/retail/v2.dart' as api;

import '../test_shared.dart';

core.Map<core.String, core.Object> buildUnnamed2653() {
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

void checkUnnamed2653(core.Map<core.String, core.Object> o) {
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

core.List<core.Map<core.String, core.Object>> buildUnnamed2654() {
  var o = <core.Map<core.String, core.Object>>[];
  o.add(buildUnnamed2653());
  o.add(buildUnnamed2653());
  return o;
}

void checkUnnamed2654(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed2653(o[0]);
  checkUnnamed2653(o[1]);
}

core.int buildCounterGoogleApiHttpBody = 0;
api.GoogleApiHttpBody buildGoogleApiHttpBody() {
  var o = api.GoogleApiHttpBody();
  buildCounterGoogleApiHttpBody++;
  if (buildCounterGoogleApiHttpBody < 3) {
    o.contentType = 'foo';
    o.data = 'foo';
    o.extensions = buildUnnamed2654();
  }
  buildCounterGoogleApiHttpBody--;
  return o;
}

void checkGoogleApiHttpBody(api.GoogleApiHttpBody o) {
  buildCounterGoogleApiHttpBody++;
  if (buildCounterGoogleApiHttpBody < 3) {
    unittest.expect(
      o.contentType!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.data!,
      unittest.equals('foo'),
    );
    checkUnnamed2654(o.extensions!);
  }
  buildCounterGoogleApiHttpBody--;
}

core.int buildCounterGoogleCloudRetailLoggingErrorContext = 0;
api.GoogleCloudRetailLoggingErrorContext
    buildGoogleCloudRetailLoggingErrorContext() {
  var o = api.GoogleCloudRetailLoggingErrorContext();
  buildCounterGoogleCloudRetailLoggingErrorContext++;
  if (buildCounterGoogleCloudRetailLoggingErrorContext < 3) {
    o.httpRequest = buildGoogleCloudRetailLoggingHttpRequestContext();
    o.reportLocation = buildGoogleCloudRetailLoggingSourceLocation();
  }
  buildCounterGoogleCloudRetailLoggingErrorContext--;
  return o;
}

void checkGoogleCloudRetailLoggingErrorContext(
    api.GoogleCloudRetailLoggingErrorContext o) {
  buildCounterGoogleCloudRetailLoggingErrorContext++;
  if (buildCounterGoogleCloudRetailLoggingErrorContext < 3) {
    checkGoogleCloudRetailLoggingHttpRequestContext(
        o.httpRequest! as api.GoogleCloudRetailLoggingHttpRequestContext);
    checkGoogleCloudRetailLoggingSourceLocation(
        o.reportLocation! as api.GoogleCloudRetailLoggingSourceLocation);
  }
  buildCounterGoogleCloudRetailLoggingErrorContext--;
}

core.Map<core.String, core.Object> buildUnnamed2655() {
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

void checkUnnamed2655(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted3 = (o['x']!) as core.Map;
  unittest.expect(casted3, unittest.hasLength(3));
  unittest.expect(
    casted3['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted3['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted3['string'],
    unittest.equals('foo'),
  );
  var casted4 = (o['y']!) as core.Map;
  unittest.expect(casted4, unittest.hasLength(3));
  unittest.expect(
    casted4['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted4['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted4['string'],
    unittest.equals('foo'),
  );
}

core.Map<core.String, core.Object> buildUnnamed2656() {
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

void checkUnnamed2656(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted5 = (o['x']!) as core.Map;
  unittest.expect(casted5, unittest.hasLength(3));
  unittest.expect(
    casted5['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted5['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted5['string'],
    unittest.equals('foo'),
  );
  var casted6 = (o['y']!) as core.Map;
  unittest.expect(casted6, unittest.hasLength(3));
  unittest.expect(
    casted6['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted6['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted6['string'],
    unittest.equals('foo'),
  );
}

core.int buildCounterGoogleCloudRetailLoggingErrorLog = 0;
api.GoogleCloudRetailLoggingErrorLog buildGoogleCloudRetailLoggingErrorLog() {
  var o = api.GoogleCloudRetailLoggingErrorLog();
  buildCounterGoogleCloudRetailLoggingErrorLog++;
  if (buildCounterGoogleCloudRetailLoggingErrorLog < 3) {
    o.context = buildGoogleCloudRetailLoggingErrorContext();
    o.importPayload = buildGoogleCloudRetailLoggingImportErrorContext();
    o.message = 'foo';
    o.requestPayload = buildUnnamed2655();
    o.responsePayload = buildUnnamed2656();
    o.serviceContext = buildGoogleCloudRetailLoggingServiceContext();
    o.status = buildGoogleRpcStatus();
  }
  buildCounterGoogleCloudRetailLoggingErrorLog--;
  return o;
}

void checkGoogleCloudRetailLoggingErrorLog(
    api.GoogleCloudRetailLoggingErrorLog o) {
  buildCounterGoogleCloudRetailLoggingErrorLog++;
  if (buildCounterGoogleCloudRetailLoggingErrorLog < 3) {
    checkGoogleCloudRetailLoggingErrorContext(
        o.context! as api.GoogleCloudRetailLoggingErrorContext);
    checkGoogleCloudRetailLoggingImportErrorContext(
        o.importPayload! as api.GoogleCloudRetailLoggingImportErrorContext);
    unittest.expect(
      o.message!,
      unittest.equals('foo'),
    );
    checkUnnamed2655(o.requestPayload!);
    checkUnnamed2656(o.responsePayload!);
    checkGoogleCloudRetailLoggingServiceContext(
        o.serviceContext! as api.GoogleCloudRetailLoggingServiceContext);
    checkGoogleRpcStatus(o.status! as api.GoogleRpcStatus);
  }
  buildCounterGoogleCloudRetailLoggingErrorLog--;
}

core.int buildCounterGoogleCloudRetailLoggingHttpRequestContext = 0;
api.GoogleCloudRetailLoggingHttpRequestContext
    buildGoogleCloudRetailLoggingHttpRequestContext() {
  var o = api.GoogleCloudRetailLoggingHttpRequestContext();
  buildCounterGoogleCloudRetailLoggingHttpRequestContext++;
  if (buildCounterGoogleCloudRetailLoggingHttpRequestContext < 3) {
    o.responseStatusCode = 42;
  }
  buildCounterGoogleCloudRetailLoggingHttpRequestContext--;
  return o;
}

void checkGoogleCloudRetailLoggingHttpRequestContext(
    api.GoogleCloudRetailLoggingHttpRequestContext o) {
  buildCounterGoogleCloudRetailLoggingHttpRequestContext++;
  if (buildCounterGoogleCloudRetailLoggingHttpRequestContext < 3) {
    unittest.expect(
      o.responseStatusCode!,
      unittest.equals(42),
    );
  }
  buildCounterGoogleCloudRetailLoggingHttpRequestContext--;
}

core.int buildCounterGoogleCloudRetailLoggingImportErrorContext = 0;
api.GoogleCloudRetailLoggingImportErrorContext
    buildGoogleCloudRetailLoggingImportErrorContext() {
  var o = api.GoogleCloudRetailLoggingImportErrorContext();
  buildCounterGoogleCloudRetailLoggingImportErrorContext++;
  if (buildCounterGoogleCloudRetailLoggingImportErrorContext < 3) {
    o.catalogItem = 'foo';
    o.gcsPath = 'foo';
    o.lineNumber = 'foo';
    o.operationName = 'foo';
    o.product = 'foo';
    o.userEvent = 'foo';
  }
  buildCounterGoogleCloudRetailLoggingImportErrorContext--;
  return o;
}

void checkGoogleCloudRetailLoggingImportErrorContext(
    api.GoogleCloudRetailLoggingImportErrorContext o) {
  buildCounterGoogleCloudRetailLoggingImportErrorContext++;
  if (buildCounterGoogleCloudRetailLoggingImportErrorContext < 3) {
    unittest.expect(
      o.catalogItem!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.gcsPath!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.lineNumber!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.operationName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.product!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.userEvent!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailLoggingImportErrorContext--;
}

core.int buildCounterGoogleCloudRetailLoggingServiceContext = 0;
api.GoogleCloudRetailLoggingServiceContext
    buildGoogleCloudRetailLoggingServiceContext() {
  var o = api.GoogleCloudRetailLoggingServiceContext();
  buildCounterGoogleCloudRetailLoggingServiceContext++;
  if (buildCounterGoogleCloudRetailLoggingServiceContext < 3) {
    o.service = 'foo';
  }
  buildCounterGoogleCloudRetailLoggingServiceContext--;
  return o;
}

void checkGoogleCloudRetailLoggingServiceContext(
    api.GoogleCloudRetailLoggingServiceContext o) {
  buildCounterGoogleCloudRetailLoggingServiceContext++;
  if (buildCounterGoogleCloudRetailLoggingServiceContext < 3) {
    unittest.expect(
      o.service!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailLoggingServiceContext--;
}

core.int buildCounterGoogleCloudRetailLoggingSourceLocation = 0;
api.GoogleCloudRetailLoggingSourceLocation
    buildGoogleCloudRetailLoggingSourceLocation() {
  var o = api.GoogleCloudRetailLoggingSourceLocation();
  buildCounterGoogleCloudRetailLoggingSourceLocation++;
  if (buildCounterGoogleCloudRetailLoggingSourceLocation < 3) {
    o.functionName = 'foo';
  }
  buildCounterGoogleCloudRetailLoggingSourceLocation--;
  return o;
}

void checkGoogleCloudRetailLoggingSourceLocation(
    api.GoogleCloudRetailLoggingSourceLocation o) {
  buildCounterGoogleCloudRetailLoggingSourceLocation++;
  if (buildCounterGoogleCloudRetailLoggingSourceLocation < 3) {
    unittest.expect(
      o.functionName!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailLoggingSourceLocation--;
}

core.int buildCounterGoogleCloudRetailV2BigQuerySource = 0;
api.GoogleCloudRetailV2BigQuerySource buildGoogleCloudRetailV2BigQuerySource() {
  var o = api.GoogleCloudRetailV2BigQuerySource();
  buildCounterGoogleCloudRetailV2BigQuerySource++;
  if (buildCounterGoogleCloudRetailV2BigQuerySource < 3) {
    o.dataSchema = 'foo';
    o.datasetId = 'foo';
    o.gcsStagingDir = 'foo';
    o.projectId = 'foo';
    o.tableId = 'foo';
  }
  buildCounterGoogleCloudRetailV2BigQuerySource--;
  return o;
}

void checkGoogleCloudRetailV2BigQuerySource(
    api.GoogleCloudRetailV2BigQuerySource o) {
  buildCounterGoogleCloudRetailV2BigQuerySource++;
  if (buildCounterGoogleCloudRetailV2BigQuerySource < 3) {
    unittest.expect(
      o.dataSchema!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.datasetId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.gcsStagingDir!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.projectId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.tableId!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2BigQuerySource--;
}

core.int buildCounterGoogleCloudRetailV2Catalog = 0;
api.GoogleCloudRetailV2Catalog buildGoogleCloudRetailV2Catalog() {
  var o = api.GoogleCloudRetailV2Catalog();
  buildCounterGoogleCloudRetailV2Catalog++;
  if (buildCounterGoogleCloudRetailV2Catalog < 3) {
    o.displayName = 'foo';
    o.name = 'foo';
    o.productLevelConfig = buildGoogleCloudRetailV2ProductLevelConfig();
  }
  buildCounterGoogleCloudRetailV2Catalog--;
  return o;
}

void checkGoogleCloudRetailV2Catalog(api.GoogleCloudRetailV2Catalog o) {
  buildCounterGoogleCloudRetailV2Catalog++;
  if (buildCounterGoogleCloudRetailV2Catalog < 3) {
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkGoogleCloudRetailV2ProductLevelConfig(
        o.productLevelConfig! as api.GoogleCloudRetailV2ProductLevelConfig);
  }
  buildCounterGoogleCloudRetailV2Catalog--;
}

core.List<core.double> buildUnnamed2657() {
  var o = <core.double>[];
  o.add(42.0);
  o.add(42.0);
  return o;
}

void checkUnnamed2657(core.List<core.double> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(
    o[0],
    unittest.equals(42.0),
  );
  unittest.expect(
    o[1],
    unittest.equals(42.0),
  );
}

core.List<core.String> buildUnnamed2658() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2658(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudRetailV2CustomAttribute = 0;
api.GoogleCloudRetailV2CustomAttribute
    buildGoogleCloudRetailV2CustomAttribute() {
  var o = api.GoogleCloudRetailV2CustomAttribute();
  buildCounterGoogleCloudRetailV2CustomAttribute++;
  if (buildCounterGoogleCloudRetailV2CustomAttribute < 3) {
    o.numbers = buildUnnamed2657();
    o.text = buildUnnamed2658();
  }
  buildCounterGoogleCloudRetailV2CustomAttribute--;
  return o;
}

void checkGoogleCloudRetailV2CustomAttribute(
    api.GoogleCloudRetailV2CustomAttribute o) {
  buildCounterGoogleCloudRetailV2CustomAttribute++;
  if (buildCounterGoogleCloudRetailV2CustomAttribute < 3) {
    checkUnnamed2657(o.numbers!);
    checkUnnamed2658(o.text!);
  }
  buildCounterGoogleCloudRetailV2CustomAttribute--;
}

core.List<core.String> buildUnnamed2659() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2659(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudRetailV2GcsSource = 0;
api.GoogleCloudRetailV2GcsSource buildGoogleCloudRetailV2GcsSource() {
  var o = api.GoogleCloudRetailV2GcsSource();
  buildCounterGoogleCloudRetailV2GcsSource++;
  if (buildCounterGoogleCloudRetailV2GcsSource < 3) {
    o.dataSchema = 'foo';
    o.inputUris = buildUnnamed2659();
  }
  buildCounterGoogleCloudRetailV2GcsSource--;
  return o;
}

void checkGoogleCloudRetailV2GcsSource(api.GoogleCloudRetailV2GcsSource o) {
  buildCounterGoogleCloudRetailV2GcsSource++;
  if (buildCounterGoogleCloudRetailV2GcsSource < 3) {
    unittest.expect(
      o.dataSchema!,
      unittest.equals('foo'),
    );
    checkUnnamed2659(o.inputUris!);
  }
  buildCounterGoogleCloudRetailV2GcsSource--;
}

core.int buildCounterGoogleCloudRetailV2Image = 0;
api.GoogleCloudRetailV2Image buildGoogleCloudRetailV2Image() {
  var o = api.GoogleCloudRetailV2Image();
  buildCounterGoogleCloudRetailV2Image++;
  if (buildCounterGoogleCloudRetailV2Image < 3) {
    o.height = 42;
    o.uri = 'foo';
    o.width = 42;
  }
  buildCounterGoogleCloudRetailV2Image--;
  return o;
}

void checkGoogleCloudRetailV2Image(api.GoogleCloudRetailV2Image o) {
  buildCounterGoogleCloudRetailV2Image++;
  if (buildCounterGoogleCloudRetailV2Image < 3) {
    unittest.expect(
      o.height!,
      unittest.equals(42),
    );
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.width!,
      unittest.equals(42),
    );
  }
  buildCounterGoogleCloudRetailV2Image--;
}

core.int buildCounterGoogleCloudRetailV2ImportErrorsConfig = 0;
api.GoogleCloudRetailV2ImportErrorsConfig
    buildGoogleCloudRetailV2ImportErrorsConfig() {
  var o = api.GoogleCloudRetailV2ImportErrorsConfig();
  buildCounterGoogleCloudRetailV2ImportErrorsConfig++;
  if (buildCounterGoogleCloudRetailV2ImportErrorsConfig < 3) {
    o.gcsPrefix = 'foo';
  }
  buildCounterGoogleCloudRetailV2ImportErrorsConfig--;
  return o;
}

void checkGoogleCloudRetailV2ImportErrorsConfig(
    api.GoogleCloudRetailV2ImportErrorsConfig o) {
  buildCounterGoogleCloudRetailV2ImportErrorsConfig++;
  if (buildCounterGoogleCloudRetailV2ImportErrorsConfig < 3) {
    unittest.expect(
      o.gcsPrefix!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2ImportErrorsConfig--;
}

core.int buildCounterGoogleCloudRetailV2ImportMetadata = 0;
api.GoogleCloudRetailV2ImportMetadata buildGoogleCloudRetailV2ImportMetadata() {
  var o = api.GoogleCloudRetailV2ImportMetadata();
  buildCounterGoogleCloudRetailV2ImportMetadata++;
  if (buildCounterGoogleCloudRetailV2ImportMetadata < 3) {
    o.createTime = 'foo';
    o.failureCount = 'foo';
    o.successCount = 'foo';
    o.updateTime = 'foo';
  }
  buildCounterGoogleCloudRetailV2ImportMetadata--;
  return o;
}

void checkGoogleCloudRetailV2ImportMetadata(
    api.GoogleCloudRetailV2ImportMetadata o) {
  buildCounterGoogleCloudRetailV2ImportMetadata++;
  if (buildCounterGoogleCloudRetailV2ImportMetadata < 3) {
    unittest.expect(
      o.createTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.failureCount!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.successCount!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.updateTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2ImportMetadata--;
}

core.int buildCounterGoogleCloudRetailV2ImportProductsRequest = 0;
api.GoogleCloudRetailV2ImportProductsRequest
    buildGoogleCloudRetailV2ImportProductsRequest() {
  var o = api.GoogleCloudRetailV2ImportProductsRequest();
  buildCounterGoogleCloudRetailV2ImportProductsRequest++;
  if (buildCounterGoogleCloudRetailV2ImportProductsRequest < 3) {
    o.errorsConfig = buildGoogleCloudRetailV2ImportErrorsConfig();
    o.inputConfig = buildGoogleCloudRetailV2ProductInputConfig();
    o.updateMask = 'foo';
  }
  buildCounterGoogleCloudRetailV2ImportProductsRequest--;
  return o;
}

void checkGoogleCloudRetailV2ImportProductsRequest(
    api.GoogleCloudRetailV2ImportProductsRequest o) {
  buildCounterGoogleCloudRetailV2ImportProductsRequest++;
  if (buildCounterGoogleCloudRetailV2ImportProductsRequest < 3) {
    checkGoogleCloudRetailV2ImportErrorsConfig(
        o.errorsConfig! as api.GoogleCloudRetailV2ImportErrorsConfig);
    checkGoogleCloudRetailV2ProductInputConfig(
        o.inputConfig! as api.GoogleCloudRetailV2ProductInputConfig);
    unittest.expect(
      o.updateMask!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2ImportProductsRequest--;
}

core.List<api.GoogleRpcStatus> buildUnnamed2660() {
  var o = <api.GoogleRpcStatus>[];
  o.add(buildGoogleRpcStatus());
  o.add(buildGoogleRpcStatus());
  return o;
}

void checkUnnamed2660(core.List<api.GoogleRpcStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleRpcStatus(o[0] as api.GoogleRpcStatus);
  checkGoogleRpcStatus(o[1] as api.GoogleRpcStatus);
}

core.int buildCounterGoogleCloudRetailV2ImportProductsResponse = 0;
api.GoogleCloudRetailV2ImportProductsResponse
    buildGoogleCloudRetailV2ImportProductsResponse() {
  var o = api.GoogleCloudRetailV2ImportProductsResponse();
  buildCounterGoogleCloudRetailV2ImportProductsResponse++;
  if (buildCounterGoogleCloudRetailV2ImportProductsResponse < 3) {
    o.errorSamples = buildUnnamed2660();
    o.errorsConfig = buildGoogleCloudRetailV2ImportErrorsConfig();
  }
  buildCounterGoogleCloudRetailV2ImportProductsResponse--;
  return o;
}

void checkGoogleCloudRetailV2ImportProductsResponse(
    api.GoogleCloudRetailV2ImportProductsResponse o) {
  buildCounterGoogleCloudRetailV2ImportProductsResponse++;
  if (buildCounterGoogleCloudRetailV2ImportProductsResponse < 3) {
    checkUnnamed2660(o.errorSamples!);
    checkGoogleCloudRetailV2ImportErrorsConfig(
        o.errorsConfig! as api.GoogleCloudRetailV2ImportErrorsConfig);
  }
  buildCounterGoogleCloudRetailV2ImportProductsResponse--;
}

core.int buildCounterGoogleCloudRetailV2ImportUserEventsRequest = 0;
api.GoogleCloudRetailV2ImportUserEventsRequest
    buildGoogleCloudRetailV2ImportUserEventsRequest() {
  var o = api.GoogleCloudRetailV2ImportUserEventsRequest();
  buildCounterGoogleCloudRetailV2ImportUserEventsRequest++;
  if (buildCounterGoogleCloudRetailV2ImportUserEventsRequest < 3) {
    o.errorsConfig = buildGoogleCloudRetailV2ImportErrorsConfig();
    o.inputConfig = buildGoogleCloudRetailV2UserEventInputConfig();
  }
  buildCounterGoogleCloudRetailV2ImportUserEventsRequest--;
  return o;
}

void checkGoogleCloudRetailV2ImportUserEventsRequest(
    api.GoogleCloudRetailV2ImportUserEventsRequest o) {
  buildCounterGoogleCloudRetailV2ImportUserEventsRequest++;
  if (buildCounterGoogleCloudRetailV2ImportUserEventsRequest < 3) {
    checkGoogleCloudRetailV2ImportErrorsConfig(
        o.errorsConfig! as api.GoogleCloudRetailV2ImportErrorsConfig);
    checkGoogleCloudRetailV2UserEventInputConfig(
        o.inputConfig! as api.GoogleCloudRetailV2UserEventInputConfig);
  }
  buildCounterGoogleCloudRetailV2ImportUserEventsRequest--;
}

core.List<api.GoogleRpcStatus> buildUnnamed2661() {
  var o = <api.GoogleRpcStatus>[];
  o.add(buildGoogleRpcStatus());
  o.add(buildGoogleRpcStatus());
  return o;
}

void checkUnnamed2661(core.List<api.GoogleRpcStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleRpcStatus(o[0] as api.GoogleRpcStatus);
  checkGoogleRpcStatus(o[1] as api.GoogleRpcStatus);
}

core.int buildCounterGoogleCloudRetailV2ImportUserEventsResponse = 0;
api.GoogleCloudRetailV2ImportUserEventsResponse
    buildGoogleCloudRetailV2ImportUserEventsResponse() {
  var o = api.GoogleCloudRetailV2ImportUserEventsResponse();
  buildCounterGoogleCloudRetailV2ImportUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2ImportUserEventsResponse < 3) {
    o.errorSamples = buildUnnamed2661();
    o.errorsConfig = buildGoogleCloudRetailV2ImportErrorsConfig();
    o.importSummary = buildGoogleCloudRetailV2UserEventImportSummary();
  }
  buildCounterGoogleCloudRetailV2ImportUserEventsResponse--;
  return o;
}

void checkGoogleCloudRetailV2ImportUserEventsResponse(
    api.GoogleCloudRetailV2ImportUserEventsResponse o) {
  buildCounterGoogleCloudRetailV2ImportUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2ImportUserEventsResponse < 3) {
    checkUnnamed2661(o.errorSamples!);
    checkGoogleCloudRetailV2ImportErrorsConfig(
        o.errorsConfig! as api.GoogleCloudRetailV2ImportErrorsConfig);
    checkGoogleCloudRetailV2UserEventImportSummary(
        o.importSummary! as api.GoogleCloudRetailV2UserEventImportSummary);
  }
  buildCounterGoogleCloudRetailV2ImportUserEventsResponse--;
}

core.List<api.GoogleCloudRetailV2Catalog> buildUnnamed2662() {
  var o = <api.GoogleCloudRetailV2Catalog>[];
  o.add(buildGoogleCloudRetailV2Catalog());
  o.add(buildGoogleCloudRetailV2Catalog());
  return o;
}

void checkUnnamed2662(core.List<api.GoogleCloudRetailV2Catalog> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudRetailV2Catalog(o[0] as api.GoogleCloudRetailV2Catalog);
  checkGoogleCloudRetailV2Catalog(o[1] as api.GoogleCloudRetailV2Catalog);
}

core.int buildCounterGoogleCloudRetailV2ListCatalogsResponse = 0;
api.GoogleCloudRetailV2ListCatalogsResponse
    buildGoogleCloudRetailV2ListCatalogsResponse() {
  var o = api.GoogleCloudRetailV2ListCatalogsResponse();
  buildCounterGoogleCloudRetailV2ListCatalogsResponse++;
  if (buildCounterGoogleCloudRetailV2ListCatalogsResponse < 3) {
    o.catalogs = buildUnnamed2662();
    o.nextPageToken = 'foo';
  }
  buildCounterGoogleCloudRetailV2ListCatalogsResponse--;
  return o;
}

void checkGoogleCloudRetailV2ListCatalogsResponse(
    api.GoogleCloudRetailV2ListCatalogsResponse o) {
  buildCounterGoogleCloudRetailV2ListCatalogsResponse++;
  if (buildCounterGoogleCloudRetailV2ListCatalogsResponse < 3) {
    checkUnnamed2662(o.catalogs!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2ListCatalogsResponse--;
}

core.Map<core.String, core.String> buildUnnamed2663() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2663(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(
    o['x']!,
    unittest.equals('foo'),
  );
  unittest.expect(
    o['y']!,
    unittest.equals('foo'),
  );
}

core.Map<core.String, core.Object> buildUnnamed2664() {
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

void checkUnnamed2664(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted7 = (o['x']!) as core.Map;
  unittest.expect(casted7, unittest.hasLength(3));
  unittest.expect(
    casted7['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted7['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted7['string'],
    unittest.equals('foo'),
  );
  var casted8 = (o['y']!) as core.Map;
  unittest.expect(casted8, unittest.hasLength(3));
  unittest.expect(
    casted8['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted8['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted8['string'],
    unittest.equals('foo'),
  );
}

core.int buildCounterGoogleCloudRetailV2PredictRequest = 0;
api.GoogleCloudRetailV2PredictRequest buildGoogleCloudRetailV2PredictRequest() {
  var o = api.GoogleCloudRetailV2PredictRequest();
  buildCounterGoogleCloudRetailV2PredictRequest++;
  if (buildCounterGoogleCloudRetailV2PredictRequest < 3) {
    o.filter = 'foo';
    o.labels = buildUnnamed2663();
    o.pageSize = 42;
    o.pageToken = 'foo';
    o.params = buildUnnamed2664();
    o.userEvent = buildGoogleCloudRetailV2UserEvent();
    o.validateOnly = true;
  }
  buildCounterGoogleCloudRetailV2PredictRequest--;
  return o;
}

void checkGoogleCloudRetailV2PredictRequest(
    api.GoogleCloudRetailV2PredictRequest o) {
  buildCounterGoogleCloudRetailV2PredictRequest++;
  if (buildCounterGoogleCloudRetailV2PredictRequest < 3) {
    unittest.expect(
      o.filter!,
      unittest.equals('foo'),
    );
    checkUnnamed2663(o.labels!);
    unittest.expect(
      o.pageSize!,
      unittest.equals(42),
    );
    unittest.expect(
      o.pageToken!,
      unittest.equals('foo'),
    );
    checkUnnamed2664(o.params!);
    checkGoogleCloudRetailV2UserEvent(
        o.userEvent! as api.GoogleCloudRetailV2UserEvent);
    unittest.expect(o.validateOnly!, unittest.isTrue);
  }
  buildCounterGoogleCloudRetailV2PredictRequest--;
}

core.List<core.String> buildUnnamed2665() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2665(core.List<core.String> o) {
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

core.List<api.GoogleCloudRetailV2PredictResponsePredictionResult>
    buildUnnamed2666() {
  var o = <api.GoogleCloudRetailV2PredictResponsePredictionResult>[];
  o.add(buildGoogleCloudRetailV2PredictResponsePredictionResult());
  o.add(buildGoogleCloudRetailV2PredictResponsePredictionResult());
  return o;
}

void checkUnnamed2666(
    core.List<api.GoogleCloudRetailV2PredictResponsePredictionResult> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudRetailV2PredictResponsePredictionResult(
      o[0] as api.GoogleCloudRetailV2PredictResponsePredictionResult);
  checkGoogleCloudRetailV2PredictResponsePredictionResult(
      o[1] as api.GoogleCloudRetailV2PredictResponsePredictionResult);
}

core.int buildCounterGoogleCloudRetailV2PredictResponse = 0;
api.GoogleCloudRetailV2PredictResponse
    buildGoogleCloudRetailV2PredictResponse() {
  var o = api.GoogleCloudRetailV2PredictResponse();
  buildCounterGoogleCloudRetailV2PredictResponse++;
  if (buildCounterGoogleCloudRetailV2PredictResponse < 3) {
    o.attributionToken = 'foo';
    o.missingIds = buildUnnamed2665();
    o.results = buildUnnamed2666();
    o.validateOnly = true;
  }
  buildCounterGoogleCloudRetailV2PredictResponse--;
  return o;
}

void checkGoogleCloudRetailV2PredictResponse(
    api.GoogleCloudRetailV2PredictResponse o) {
  buildCounterGoogleCloudRetailV2PredictResponse++;
  if (buildCounterGoogleCloudRetailV2PredictResponse < 3) {
    unittest.expect(
      o.attributionToken!,
      unittest.equals('foo'),
    );
    checkUnnamed2665(o.missingIds!);
    checkUnnamed2666(o.results!);
    unittest.expect(o.validateOnly!, unittest.isTrue);
  }
  buildCounterGoogleCloudRetailV2PredictResponse--;
}

core.Map<core.String, core.Object> buildUnnamed2667() {
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

void checkUnnamed2667(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted9 = (o['x']!) as core.Map;
  unittest.expect(casted9, unittest.hasLength(3));
  unittest.expect(
    casted9['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted9['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted9['string'],
    unittest.equals('foo'),
  );
  var casted10 = (o['y']!) as core.Map;
  unittest.expect(casted10, unittest.hasLength(3));
  unittest.expect(
    casted10['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted10['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted10['string'],
    unittest.equals('foo'),
  );
}

core.int buildCounterGoogleCloudRetailV2PredictResponsePredictionResult = 0;
api.GoogleCloudRetailV2PredictResponsePredictionResult
    buildGoogleCloudRetailV2PredictResponsePredictionResult() {
  var o = api.GoogleCloudRetailV2PredictResponsePredictionResult();
  buildCounterGoogleCloudRetailV2PredictResponsePredictionResult++;
  if (buildCounterGoogleCloudRetailV2PredictResponsePredictionResult < 3) {
    o.id = 'foo';
    o.metadata = buildUnnamed2667();
  }
  buildCounterGoogleCloudRetailV2PredictResponsePredictionResult--;
  return o;
}

void checkGoogleCloudRetailV2PredictResponsePredictionResult(
    api.GoogleCloudRetailV2PredictResponsePredictionResult o) {
  buildCounterGoogleCloudRetailV2PredictResponsePredictionResult++;
  if (buildCounterGoogleCloudRetailV2PredictResponsePredictionResult < 3) {
    unittest.expect(
      o.id!,
      unittest.equals('foo'),
    );
    checkUnnamed2667(o.metadata!);
  }
  buildCounterGoogleCloudRetailV2PredictResponsePredictionResult--;
}

core.int buildCounterGoogleCloudRetailV2PriceInfo = 0;
api.GoogleCloudRetailV2PriceInfo buildGoogleCloudRetailV2PriceInfo() {
  var o = api.GoogleCloudRetailV2PriceInfo();
  buildCounterGoogleCloudRetailV2PriceInfo++;
  if (buildCounterGoogleCloudRetailV2PriceInfo < 3) {
    o.cost = 42.0;
    o.currencyCode = 'foo';
    o.originalPrice = 42.0;
    o.price = 42.0;
  }
  buildCounterGoogleCloudRetailV2PriceInfo--;
  return o;
}

void checkGoogleCloudRetailV2PriceInfo(api.GoogleCloudRetailV2PriceInfo o) {
  buildCounterGoogleCloudRetailV2PriceInfo++;
  if (buildCounterGoogleCloudRetailV2PriceInfo < 3) {
    unittest.expect(
      o.cost!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.currencyCode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.originalPrice!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.price!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudRetailV2PriceInfo--;
}

core.Map<core.String, api.GoogleCloudRetailV2CustomAttribute>
    buildUnnamed2668() {
  var o = <core.String, api.GoogleCloudRetailV2CustomAttribute>{};
  o['x'] = buildGoogleCloudRetailV2CustomAttribute();
  o['y'] = buildGoogleCloudRetailV2CustomAttribute();
  return o;
}

void checkUnnamed2668(
    core.Map<core.String, api.GoogleCloudRetailV2CustomAttribute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudRetailV2CustomAttribute(
      o['x']! as api.GoogleCloudRetailV2CustomAttribute);
  checkGoogleCloudRetailV2CustomAttribute(
      o['y']! as api.GoogleCloudRetailV2CustomAttribute);
}

core.List<core.String> buildUnnamed2669() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2669(core.List<core.String> o) {
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

core.List<api.GoogleCloudRetailV2Image> buildUnnamed2670() {
  var o = <api.GoogleCloudRetailV2Image>[];
  o.add(buildGoogleCloudRetailV2Image());
  o.add(buildGoogleCloudRetailV2Image());
  return o;
}

void checkUnnamed2670(core.List<api.GoogleCloudRetailV2Image> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudRetailV2Image(o[0] as api.GoogleCloudRetailV2Image);
  checkGoogleCloudRetailV2Image(o[1] as api.GoogleCloudRetailV2Image);
}

core.List<core.String> buildUnnamed2671() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2671(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudRetailV2Product = 0;
api.GoogleCloudRetailV2Product buildGoogleCloudRetailV2Product() {
  var o = api.GoogleCloudRetailV2Product();
  buildCounterGoogleCloudRetailV2Product++;
  if (buildCounterGoogleCloudRetailV2Product < 3) {
    o.attributes = buildUnnamed2668();
    o.availability = 'foo';
    o.availableQuantity = 42;
    o.availableTime = 'foo';
    o.categories = buildUnnamed2669();
    o.description = 'foo';
    o.id = 'foo';
    o.images = buildUnnamed2670();
    o.name = 'foo';
    o.priceInfo = buildGoogleCloudRetailV2PriceInfo();
    o.primaryProductId = 'foo';
    o.tags = buildUnnamed2671();
    o.title = 'foo';
    o.type = 'foo';
    o.uri = 'foo';
  }
  buildCounterGoogleCloudRetailV2Product--;
  return o;
}

void checkGoogleCloudRetailV2Product(api.GoogleCloudRetailV2Product o) {
  buildCounterGoogleCloudRetailV2Product++;
  if (buildCounterGoogleCloudRetailV2Product < 3) {
    checkUnnamed2668(o.attributes!);
    unittest.expect(
      o.availability!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.availableQuantity!,
      unittest.equals(42),
    );
    unittest.expect(
      o.availableTime!,
      unittest.equals('foo'),
    );
    checkUnnamed2669(o.categories!);
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.id!,
      unittest.equals('foo'),
    );
    checkUnnamed2670(o.images!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkGoogleCloudRetailV2PriceInfo(
        o.priceInfo! as api.GoogleCloudRetailV2PriceInfo);
    unittest.expect(
      o.primaryProductId!,
      unittest.equals('foo'),
    );
    checkUnnamed2671(o.tags!);
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2Product--;
}

core.int buildCounterGoogleCloudRetailV2ProductDetail = 0;
api.GoogleCloudRetailV2ProductDetail buildGoogleCloudRetailV2ProductDetail() {
  var o = api.GoogleCloudRetailV2ProductDetail();
  buildCounterGoogleCloudRetailV2ProductDetail++;
  if (buildCounterGoogleCloudRetailV2ProductDetail < 3) {
    o.product = buildGoogleCloudRetailV2Product();
    o.quantity = 42;
  }
  buildCounterGoogleCloudRetailV2ProductDetail--;
  return o;
}

void checkGoogleCloudRetailV2ProductDetail(
    api.GoogleCloudRetailV2ProductDetail o) {
  buildCounterGoogleCloudRetailV2ProductDetail++;
  if (buildCounterGoogleCloudRetailV2ProductDetail < 3) {
    checkGoogleCloudRetailV2Product(
        o.product! as api.GoogleCloudRetailV2Product);
    unittest.expect(
      o.quantity!,
      unittest.equals(42),
    );
  }
  buildCounterGoogleCloudRetailV2ProductDetail--;
}

core.List<api.GoogleCloudRetailV2Product> buildUnnamed2672() {
  var o = <api.GoogleCloudRetailV2Product>[];
  o.add(buildGoogleCloudRetailV2Product());
  o.add(buildGoogleCloudRetailV2Product());
  return o;
}

void checkUnnamed2672(core.List<api.GoogleCloudRetailV2Product> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudRetailV2Product(o[0] as api.GoogleCloudRetailV2Product);
  checkGoogleCloudRetailV2Product(o[1] as api.GoogleCloudRetailV2Product);
}

core.int buildCounterGoogleCloudRetailV2ProductInlineSource = 0;
api.GoogleCloudRetailV2ProductInlineSource
    buildGoogleCloudRetailV2ProductInlineSource() {
  var o = api.GoogleCloudRetailV2ProductInlineSource();
  buildCounterGoogleCloudRetailV2ProductInlineSource++;
  if (buildCounterGoogleCloudRetailV2ProductInlineSource < 3) {
    o.products = buildUnnamed2672();
  }
  buildCounterGoogleCloudRetailV2ProductInlineSource--;
  return o;
}

void checkGoogleCloudRetailV2ProductInlineSource(
    api.GoogleCloudRetailV2ProductInlineSource o) {
  buildCounterGoogleCloudRetailV2ProductInlineSource++;
  if (buildCounterGoogleCloudRetailV2ProductInlineSource < 3) {
    checkUnnamed2672(o.products!);
  }
  buildCounterGoogleCloudRetailV2ProductInlineSource--;
}

core.int buildCounterGoogleCloudRetailV2ProductInputConfig = 0;
api.GoogleCloudRetailV2ProductInputConfig
    buildGoogleCloudRetailV2ProductInputConfig() {
  var o = api.GoogleCloudRetailV2ProductInputConfig();
  buildCounterGoogleCloudRetailV2ProductInputConfig++;
  if (buildCounterGoogleCloudRetailV2ProductInputConfig < 3) {
    o.bigQuerySource = buildGoogleCloudRetailV2BigQuerySource();
    o.gcsSource = buildGoogleCloudRetailV2GcsSource();
    o.productInlineSource = buildGoogleCloudRetailV2ProductInlineSource();
  }
  buildCounterGoogleCloudRetailV2ProductInputConfig--;
  return o;
}

void checkGoogleCloudRetailV2ProductInputConfig(
    api.GoogleCloudRetailV2ProductInputConfig o) {
  buildCounterGoogleCloudRetailV2ProductInputConfig++;
  if (buildCounterGoogleCloudRetailV2ProductInputConfig < 3) {
    checkGoogleCloudRetailV2BigQuerySource(
        o.bigQuerySource! as api.GoogleCloudRetailV2BigQuerySource);
    checkGoogleCloudRetailV2GcsSource(
        o.gcsSource! as api.GoogleCloudRetailV2GcsSource);
    checkGoogleCloudRetailV2ProductInlineSource(
        o.productInlineSource! as api.GoogleCloudRetailV2ProductInlineSource);
  }
  buildCounterGoogleCloudRetailV2ProductInputConfig--;
}

core.int buildCounterGoogleCloudRetailV2ProductLevelConfig = 0;
api.GoogleCloudRetailV2ProductLevelConfig
    buildGoogleCloudRetailV2ProductLevelConfig() {
  var o = api.GoogleCloudRetailV2ProductLevelConfig();
  buildCounterGoogleCloudRetailV2ProductLevelConfig++;
  if (buildCounterGoogleCloudRetailV2ProductLevelConfig < 3) {
    o.ingestionProductType = 'foo';
    o.merchantCenterProductIdField = 'foo';
  }
  buildCounterGoogleCloudRetailV2ProductLevelConfig--;
  return o;
}

void checkGoogleCloudRetailV2ProductLevelConfig(
    api.GoogleCloudRetailV2ProductLevelConfig o) {
  buildCounterGoogleCloudRetailV2ProductLevelConfig++;
  if (buildCounterGoogleCloudRetailV2ProductLevelConfig < 3) {
    unittest.expect(
      o.ingestionProductType!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.merchantCenterProductIdField!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2ProductLevelConfig--;
}

core.int buildCounterGoogleCloudRetailV2PurchaseTransaction = 0;
api.GoogleCloudRetailV2PurchaseTransaction
    buildGoogleCloudRetailV2PurchaseTransaction() {
  var o = api.GoogleCloudRetailV2PurchaseTransaction();
  buildCounterGoogleCloudRetailV2PurchaseTransaction++;
  if (buildCounterGoogleCloudRetailV2PurchaseTransaction < 3) {
    o.cost = 42.0;
    o.currencyCode = 'foo';
    o.id = 'foo';
    o.revenue = 42.0;
    o.tax = 42.0;
  }
  buildCounterGoogleCloudRetailV2PurchaseTransaction--;
  return o;
}

void checkGoogleCloudRetailV2PurchaseTransaction(
    api.GoogleCloudRetailV2PurchaseTransaction o) {
  buildCounterGoogleCloudRetailV2PurchaseTransaction++;
  if (buildCounterGoogleCloudRetailV2PurchaseTransaction < 3) {
    unittest.expect(
      o.cost!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.currencyCode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.id!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.revenue!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.tax!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudRetailV2PurchaseTransaction--;
}

core.int buildCounterGoogleCloudRetailV2PurgeMetadata = 0;
api.GoogleCloudRetailV2PurgeMetadata buildGoogleCloudRetailV2PurgeMetadata() {
  var o = api.GoogleCloudRetailV2PurgeMetadata();
  buildCounterGoogleCloudRetailV2PurgeMetadata++;
  if (buildCounterGoogleCloudRetailV2PurgeMetadata < 3) {}
  buildCounterGoogleCloudRetailV2PurgeMetadata--;
  return o;
}

void checkGoogleCloudRetailV2PurgeMetadata(
    api.GoogleCloudRetailV2PurgeMetadata o) {
  buildCounterGoogleCloudRetailV2PurgeMetadata++;
  if (buildCounterGoogleCloudRetailV2PurgeMetadata < 3) {}
  buildCounterGoogleCloudRetailV2PurgeMetadata--;
}

core.int buildCounterGoogleCloudRetailV2PurgeUserEventsRequest = 0;
api.GoogleCloudRetailV2PurgeUserEventsRequest
    buildGoogleCloudRetailV2PurgeUserEventsRequest() {
  var o = api.GoogleCloudRetailV2PurgeUserEventsRequest();
  buildCounterGoogleCloudRetailV2PurgeUserEventsRequest++;
  if (buildCounterGoogleCloudRetailV2PurgeUserEventsRequest < 3) {
    o.filter = 'foo';
    o.force = true;
  }
  buildCounterGoogleCloudRetailV2PurgeUserEventsRequest--;
  return o;
}

void checkGoogleCloudRetailV2PurgeUserEventsRequest(
    api.GoogleCloudRetailV2PurgeUserEventsRequest o) {
  buildCounterGoogleCloudRetailV2PurgeUserEventsRequest++;
  if (buildCounterGoogleCloudRetailV2PurgeUserEventsRequest < 3) {
    unittest.expect(
      o.filter!,
      unittest.equals('foo'),
    );
    unittest.expect(o.force!, unittest.isTrue);
  }
  buildCounterGoogleCloudRetailV2PurgeUserEventsRequest--;
}

core.int buildCounterGoogleCloudRetailV2PurgeUserEventsResponse = 0;
api.GoogleCloudRetailV2PurgeUserEventsResponse
    buildGoogleCloudRetailV2PurgeUserEventsResponse() {
  var o = api.GoogleCloudRetailV2PurgeUserEventsResponse();
  buildCounterGoogleCloudRetailV2PurgeUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2PurgeUserEventsResponse < 3) {
    o.purgedEventsCount = 'foo';
  }
  buildCounterGoogleCloudRetailV2PurgeUserEventsResponse--;
  return o;
}

void checkGoogleCloudRetailV2PurgeUserEventsResponse(
    api.GoogleCloudRetailV2PurgeUserEventsResponse o) {
  buildCounterGoogleCloudRetailV2PurgeUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2PurgeUserEventsResponse < 3) {
    unittest.expect(
      o.purgedEventsCount!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2PurgeUserEventsResponse--;
}

core.int buildCounterGoogleCloudRetailV2RejoinUserEventsMetadata = 0;
api.GoogleCloudRetailV2RejoinUserEventsMetadata
    buildGoogleCloudRetailV2RejoinUserEventsMetadata() {
  var o = api.GoogleCloudRetailV2RejoinUserEventsMetadata();
  buildCounterGoogleCloudRetailV2RejoinUserEventsMetadata++;
  if (buildCounterGoogleCloudRetailV2RejoinUserEventsMetadata < 3) {}
  buildCounterGoogleCloudRetailV2RejoinUserEventsMetadata--;
  return o;
}

void checkGoogleCloudRetailV2RejoinUserEventsMetadata(
    api.GoogleCloudRetailV2RejoinUserEventsMetadata o) {
  buildCounterGoogleCloudRetailV2RejoinUserEventsMetadata++;
  if (buildCounterGoogleCloudRetailV2RejoinUserEventsMetadata < 3) {}
  buildCounterGoogleCloudRetailV2RejoinUserEventsMetadata--;
}

core.int buildCounterGoogleCloudRetailV2RejoinUserEventsRequest = 0;
api.GoogleCloudRetailV2RejoinUserEventsRequest
    buildGoogleCloudRetailV2RejoinUserEventsRequest() {
  var o = api.GoogleCloudRetailV2RejoinUserEventsRequest();
  buildCounterGoogleCloudRetailV2RejoinUserEventsRequest++;
  if (buildCounterGoogleCloudRetailV2RejoinUserEventsRequest < 3) {
    o.userEventRejoinScope = 'foo';
  }
  buildCounterGoogleCloudRetailV2RejoinUserEventsRequest--;
  return o;
}

void checkGoogleCloudRetailV2RejoinUserEventsRequest(
    api.GoogleCloudRetailV2RejoinUserEventsRequest o) {
  buildCounterGoogleCloudRetailV2RejoinUserEventsRequest++;
  if (buildCounterGoogleCloudRetailV2RejoinUserEventsRequest < 3) {
    unittest.expect(
      o.userEventRejoinScope!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2RejoinUserEventsRequest--;
}

core.int buildCounterGoogleCloudRetailV2RejoinUserEventsResponse = 0;
api.GoogleCloudRetailV2RejoinUserEventsResponse
    buildGoogleCloudRetailV2RejoinUserEventsResponse() {
  var o = api.GoogleCloudRetailV2RejoinUserEventsResponse();
  buildCounterGoogleCloudRetailV2RejoinUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2RejoinUserEventsResponse < 3) {
    o.rejoinedUserEventsCount = 'foo';
  }
  buildCounterGoogleCloudRetailV2RejoinUserEventsResponse--;
  return o;
}

void checkGoogleCloudRetailV2RejoinUserEventsResponse(
    api.GoogleCloudRetailV2RejoinUserEventsResponse o) {
  buildCounterGoogleCloudRetailV2RejoinUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2RejoinUserEventsResponse < 3) {
    unittest.expect(
      o.rejoinedUserEventsCount!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2RejoinUserEventsResponse--;
}

core.Map<core.String, api.GoogleCloudRetailV2CustomAttribute>
    buildUnnamed2673() {
  var o = <core.String, api.GoogleCloudRetailV2CustomAttribute>{};
  o['x'] = buildGoogleCloudRetailV2CustomAttribute();
  o['y'] = buildGoogleCloudRetailV2CustomAttribute();
  return o;
}

void checkUnnamed2673(
    core.Map<core.String, api.GoogleCloudRetailV2CustomAttribute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudRetailV2CustomAttribute(
      o['x']! as api.GoogleCloudRetailV2CustomAttribute);
  checkGoogleCloudRetailV2CustomAttribute(
      o['y']! as api.GoogleCloudRetailV2CustomAttribute);
}

core.List<core.String> buildUnnamed2674() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2674(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed2675() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2675(core.List<core.String> o) {
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

core.List<api.GoogleCloudRetailV2ProductDetail> buildUnnamed2676() {
  var o = <api.GoogleCloudRetailV2ProductDetail>[];
  o.add(buildGoogleCloudRetailV2ProductDetail());
  o.add(buildGoogleCloudRetailV2ProductDetail());
  return o;
}

void checkUnnamed2676(core.List<api.GoogleCloudRetailV2ProductDetail> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudRetailV2ProductDetail(
      o[0] as api.GoogleCloudRetailV2ProductDetail);
  checkGoogleCloudRetailV2ProductDetail(
      o[1] as api.GoogleCloudRetailV2ProductDetail);
}

core.int buildCounterGoogleCloudRetailV2UserEvent = 0;
api.GoogleCloudRetailV2UserEvent buildGoogleCloudRetailV2UserEvent() {
  var o = api.GoogleCloudRetailV2UserEvent();
  buildCounterGoogleCloudRetailV2UserEvent++;
  if (buildCounterGoogleCloudRetailV2UserEvent < 3) {
    o.attributes = buildUnnamed2673();
    o.attributionToken = 'foo';
    o.cartId = 'foo';
    o.eventTime = 'foo';
    o.eventType = 'foo';
    o.experimentIds = buildUnnamed2674();
    o.pageCategories = buildUnnamed2675();
    o.pageViewId = 'foo';
    o.productDetails = buildUnnamed2676();
    o.purchaseTransaction = buildGoogleCloudRetailV2PurchaseTransaction();
    o.referrerUri = 'foo';
    o.searchQuery = 'foo';
    o.uri = 'foo';
    o.userInfo = buildGoogleCloudRetailV2UserInfo();
    o.visitorId = 'foo';
  }
  buildCounterGoogleCloudRetailV2UserEvent--;
  return o;
}

void checkGoogleCloudRetailV2UserEvent(api.GoogleCloudRetailV2UserEvent o) {
  buildCounterGoogleCloudRetailV2UserEvent++;
  if (buildCounterGoogleCloudRetailV2UserEvent < 3) {
    checkUnnamed2673(o.attributes!);
    unittest.expect(
      o.attributionToken!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.cartId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.eventTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.eventType!,
      unittest.equals('foo'),
    );
    checkUnnamed2674(o.experimentIds!);
    checkUnnamed2675(o.pageCategories!);
    unittest.expect(
      o.pageViewId!,
      unittest.equals('foo'),
    );
    checkUnnamed2676(o.productDetails!);
    checkGoogleCloudRetailV2PurchaseTransaction(
        o.purchaseTransaction! as api.GoogleCloudRetailV2PurchaseTransaction);
    unittest.expect(
      o.referrerUri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.searchQuery!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
    checkGoogleCloudRetailV2UserInfo(
        o.userInfo! as api.GoogleCloudRetailV2UserInfo);
    unittest.expect(
      o.visitorId!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2UserEvent--;
}

core.int buildCounterGoogleCloudRetailV2UserEventImportSummary = 0;
api.GoogleCloudRetailV2UserEventImportSummary
    buildGoogleCloudRetailV2UserEventImportSummary() {
  var o = api.GoogleCloudRetailV2UserEventImportSummary();
  buildCounterGoogleCloudRetailV2UserEventImportSummary++;
  if (buildCounterGoogleCloudRetailV2UserEventImportSummary < 3) {
    o.joinedEventsCount = 'foo';
    o.unjoinedEventsCount = 'foo';
  }
  buildCounterGoogleCloudRetailV2UserEventImportSummary--;
  return o;
}

void checkGoogleCloudRetailV2UserEventImportSummary(
    api.GoogleCloudRetailV2UserEventImportSummary o) {
  buildCounterGoogleCloudRetailV2UserEventImportSummary++;
  if (buildCounterGoogleCloudRetailV2UserEventImportSummary < 3) {
    unittest.expect(
      o.joinedEventsCount!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.unjoinedEventsCount!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2UserEventImportSummary--;
}

core.List<api.GoogleCloudRetailV2UserEvent> buildUnnamed2677() {
  var o = <api.GoogleCloudRetailV2UserEvent>[];
  o.add(buildGoogleCloudRetailV2UserEvent());
  o.add(buildGoogleCloudRetailV2UserEvent());
  return o;
}

void checkUnnamed2677(core.List<api.GoogleCloudRetailV2UserEvent> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudRetailV2UserEvent(o[0] as api.GoogleCloudRetailV2UserEvent);
  checkGoogleCloudRetailV2UserEvent(o[1] as api.GoogleCloudRetailV2UserEvent);
}

core.int buildCounterGoogleCloudRetailV2UserEventInlineSource = 0;
api.GoogleCloudRetailV2UserEventInlineSource
    buildGoogleCloudRetailV2UserEventInlineSource() {
  var o = api.GoogleCloudRetailV2UserEventInlineSource();
  buildCounterGoogleCloudRetailV2UserEventInlineSource++;
  if (buildCounterGoogleCloudRetailV2UserEventInlineSource < 3) {
    o.userEvents = buildUnnamed2677();
  }
  buildCounterGoogleCloudRetailV2UserEventInlineSource--;
  return o;
}

void checkGoogleCloudRetailV2UserEventInlineSource(
    api.GoogleCloudRetailV2UserEventInlineSource o) {
  buildCounterGoogleCloudRetailV2UserEventInlineSource++;
  if (buildCounterGoogleCloudRetailV2UserEventInlineSource < 3) {
    checkUnnamed2677(o.userEvents!);
  }
  buildCounterGoogleCloudRetailV2UserEventInlineSource--;
}

core.int buildCounterGoogleCloudRetailV2UserEventInputConfig = 0;
api.GoogleCloudRetailV2UserEventInputConfig
    buildGoogleCloudRetailV2UserEventInputConfig() {
  var o = api.GoogleCloudRetailV2UserEventInputConfig();
  buildCounterGoogleCloudRetailV2UserEventInputConfig++;
  if (buildCounterGoogleCloudRetailV2UserEventInputConfig < 3) {
    o.bigQuerySource = buildGoogleCloudRetailV2BigQuerySource();
    o.gcsSource = buildGoogleCloudRetailV2GcsSource();
    o.userEventInlineSource = buildGoogleCloudRetailV2UserEventInlineSource();
  }
  buildCounterGoogleCloudRetailV2UserEventInputConfig--;
  return o;
}

void checkGoogleCloudRetailV2UserEventInputConfig(
    api.GoogleCloudRetailV2UserEventInputConfig o) {
  buildCounterGoogleCloudRetailV2UserEventInputConfig++;
  if (buildCounterGoogleCloudRetailV2UserEventInputConfig < 3) {
    checkGoogleCloudRetailV2BigQuerySource(
        o.bigQuerySource! as api.GoogleCloudRetailV2BigQuerySource);
    checkGoogleCloudRetailV2GcsSource(
        o.gcsSource! as api.GoogleCloudRetailV2GcsSource);
    checkGoogleCloudRetailV2UserEventInlineSource(o.userEventInlineSource!
        as api.GoogleCloudRetailV2UserEventInlineSource);
  }
  buildCounterGoogleCloudRetailV2UserEventInputConfig--;
}

core.int buildCounterGoogleCloudRetailV2UserInfo = 0;
api.GoogleCloudRetailV2UserInfo buildGoogleCloudRetailV2UserInfo() {
  var o = api.GoogleCloudRetailV2UserInfo();
  buildCounterGoogleCloudRetailV2UserInfo++;
  if (buildCounterGoogleCloudRetailV2UserInfo < 3) {
    o.directUserRequest = true;
    o.ipAddress = 'foo';
    o.userAgent = 'foo';
    o.userId = 'foo';
  }
  buildCounterGoogleCloudRetailV2UserInfo--;
  return o;
}

void checkGoogleCloudRetailV2UserInfo(api.GoogleCloudRetailV2UserInfo o) {
  buildCounterGoogleCloudRetailV2UserInfo++;
  if (buildCounterGoogleCloudRetailV2UserInfo < 3) {
    unittest.expect(o.directUserRequest!, unittest.isTrue);
    unittest.expect(
      o.ipAddress!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.userAgent!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.userId!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2UserInfo--;
}

core.int buildCounterGoogleCloudRetailV2alphaExportErrorsConfig = 0;
api.GoogleCloudRetailV2alphaExportErrorsConfig
    buildGoogleCloudRetailV2alphaExportErrorsConfig() {
  var o = api.GoogleCloudRetailV2alphaExportErrorsConfig();
  buildCounterGoogleCloudRetailV2alphaExportErrorsConfig++;
  if (buildCounterGoogleCloudRetailV2alphaExportErrorsConfig < 3) {
    o.gcsPrefix = 'foo';
  }
  buildCounterGoogleCloudRetailV2alphaExportErrorsConfig--;
  return o;
}

void checkGoogleCloudRetailV2alphaExportErrorsConfig(
    api.GoogleCloudRetailV2alphaExportErrorsConfig o) {
  buildCounterGoogleCloudRetailV2alphaExportErrorsConfig++;
  if (buildCounterGoogleCloudRetailV2alphaExportErrorsConfig < 3) {
    unittest.expect(
      o.gcsPrefix!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2alphaExportErrorsConfig--;
}

core.int buildCounterGoogleCloudRetailV2alphaExportMetadata = 0;
api.GoogleCloudRetailV2alphaExportMetadata
    buildGoogleCloudRetailV2alphaExportMetadata() {
  var o = api.GoogleCloudRetailV2alphaExportMetadata();
  buildCounterGoogleCloudRetailV2alphaExportMetadata++;
  if (buildCounterGoogleCloudRetailV2alphaExportMetadata < 3) {
    o.createTime = 'foo';
    o.updateTime = 'foo';
  }
  buildCounterGoogleCloudRetailV2alphaExportMetadata--;
  return o;
}

void checkGoogleCloudRetailV2alphaExportMetadata(
    api.GoogleCloudRetailV2alphaExportMetadata o) {
  buildCounterGoogleCloudRetailV2alphaExportMetadata++;
  if (buildCounterGoogleCloudRetailV2alphaExportMetadata < 3) {
    unittest.expect(
      o.createTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.updateTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2alphaExportMetadata--;
}

core.List<api.GoogleRpcStatus> buildUnnamed2678() {
  var o = <api.GoogleRpcStatus>[];
  o.add(buildGoogleRpcStatus());
  o.add(buildGoogleRpcStatus());
  return o;
}

void checkUnnamed2678(core.List<api.GoogleRpcStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleRpcStatus(o[0] as api.GoogleRpcStatus);
  checkGoogleRpcStatus(o[1] as api.GoogleRpcStatus);
}

core.int buildCounterGoogleCloudRetailV2alphaExportProductsResponse = 0;
api.GoogleCloudRetailV2alphaExportProductsResponse
    buildGoogleCloudRetailV2alphaExportProductsResponse() {
  var o = api.GoogleCloudRetailV2alphaExportProductsResponse();
  buildCounterGoogleCloudRetailV2alphaExportProductsResponse++;
  if (buildCounterGoogleCloudRetailV2alphaExportProductsResponse < 3) {
    o.errorSamples = buildUnnamed2678();
    o.errorsConfig = buildGoogleCloudRetailV2alphaExportErrorsConfig();
  }
  buildCounterGoogleCloudRetailV2alphaExportProductsResponse--;
  return o;
}

void checkGoogleCloudRetailV2alphaExportProductsResponse(
    api.GoogleCloudRetailV2alphaExportProductsResponse o) {
  buildCounterGoogleCloudRetailV2alphaExportProductsResponse++;
  if (buildCounterGoogleCloudRetailV2alphaExportProductsResponse < 3) {
    checkUnnamed2678(o.errorSamples!);
    checkGoogleCloudRetailV2alphaExportErrorsConfig(
        o.errorsConfig! as api.GoogleCloudRetailV2alphaExportErrorsConfig);
  }
  buildCounterGoogleCloudRetailV2alphaExportProductsResponse--;
}

core.List<api.GoogleRpcStatus> buildUnnamed2679() {
  var o = <api.GoogleRpcStatus>[];
  o.add(buildGoogleRpcStatus());
  o.add(buildGoogleRpcStatus());
  return o;
}

void checkUnnamed2679(core.List<api.GoogleRpcStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleRpcStatus(o[0] as api.GoogleRpcStatus);
  checkGoogleRpcStatus(o[1] as api.GoogleRpcStatus);
}

core.int buildCounterGoogleCloudRetailV2alphaExportUserEventsResponse = 0;
api.GoogleCloudRetailV2alphaExportUserEventsResponse
    buildGoogleCloudRetailV2alphaExportUserEventsResponse() {
  var o = api.GoogleCloudRetailV2alphaExportUserEventsResponse();
  buildCounterGoogleCloudRetailV2alphaExportUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2alphaExportUserEventsResponse < 3) {
    o.errorSamples = buildUnnamed2679();
    o.errorsConfig = buildGoogleCloudRetailV2alphaExportErrorsConfig();
  }
  buildCounterGoogleCloudRetailV2alphaExportUserEventsResponse--;
  return o;
}

void checkGoogleCloudRetailV2alphaExportUserEventsResponse(
    api.GoogleCloudRetailV2alphaExportUserEventsResponse o) {
  buildCounterGoogleCloudRetailV2alphaExportUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2alphaExportUserEventsResponse < 3) {
    checkUnnamed2679(o.errorSamples!);
    checkGoogleCloudRetailV2alphaExportErrorsConfig(
        o.errorsConfig! as api.GoogleCloudRetailV2alphaExportErrorsConfig);
  }
  buildCounterGoogleCloudRetailV2alphaExportUserEventsResponse--;
}

core.int buildCounterGoogleCloudRetailV2alphaImportErrorsConfig = 0;
api.GoogleCloudRetailV2alphaImportErrorsConfig
    buildGoogleCloudRetailV2alphaImportErrorsConfig() {
  var o = api.GoogleCloudRetailV2alphaImportErrorsConfig();
  buildCounterGoogleCloudRetailV2alphaImportErrorsConfig++;
  if (buildCounterGoogleCloudRetailV2alphaImportErrorsConfig < 3) {
    o.gcsPrefix = 'foo';
  }
  buildCounterGoogleCloudRetailV2alphaImportErrorsConfig--;
  return o;
}

void checkGoogleCloudRetailV2alphaImportErrorsConfig(
    api.GoogleCloudRetailV2alphaImportErrorsConfig o) {
  buildCounterGoogleCloudRetailV2alphaImportErrorsConfig++;
  if (buildCounterGoogleCloudRetailV2alphaImportErrorsConfig < 3) {
    unittest.expect(
      o.gcsPrefix!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2alphaImportErrorsConfig--;
}

core.int buildCounterGoogleCloudRetailV2alphaImportMetadata = 0;
api.GoogleCloudRetailV2alphaImportMetadata
    buildGoogleCloudRetailV2alphaImportMetadata() {
  var o = api.GoogleCloudRetailV2alphaImportMetadata();
  buildCounterGoogleCloudRetailV2alphaImportMetadata++;
  if (buildCounterGoogleCloudRetailV2alphaImportMetadata < 3) {
    o.createTime = 'foo';
    o.failureCount = 'foo';
    o.successCount = 'foo';
    o.updateTime = 'foo';
  }
  buildCounterGoogleCloudRetailV2alphaImportMetadata--;
  return o;
}

void checkGoogleCloudRetailV2alphaImportMetadata(
    api.GoogleCloudRetailV2alphaImportMetadata o) {
  buildCounterGoogleCloudRetailV2alphaImportMetadata++;
  if (buildCounterGoogleCloudRetailV2alphaImportMetadata < 3) {
    unittest.expect(
      o.createTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.failureCount!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.successCount!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.updateTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2alphaImportMetadata--;
}

core.List<api.GoogleRpcStatus> buildUnnamed2680() {
  var o = <api.GoogleRpcStatus>[];
  o.add(buildGoogleRpcStatus());
  o.add(buildGoogleRpcStatus());
  return o;
}

void checkUnnamed2680(core.List<api.GoogleRpcStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleRpcStatus(o[0] as api.GoogleRpcStatus);
  checkGoogleRpcStatus(o[1] as api.GoogleRpcStatus);
}

core.int buildCounterGoogleCloudRetailV2alphaImportProductsResponse = 0;
api.GoogleCloudRetailV2alphaImportProductsResponse
    buildGoogleCloudRetailV2alphaImportProductsResponse() {
  var o = api.GoogleCloudRetailV2alphaImportProductsResponse();
  buildCounterGoogleCloudRetailV2alphaImportProductsResponse++;
  if (buildCounterGoogleCloudRetailV2alphaImportProductsResponse < 3) {
    o.errorSamples = buildUnnamed2680();
    o.errorsConfig = buildGoogleCloudRetailV2alphaImportErrorsConfig();
  }
  buildCounterGoogleCloudRetailV2alphaImportProductsResponse--;
  return o;
}

void checkGoogleCloudRetailV2alphaImportProductsResponse(
    api.GoogleCloudRetailV2alphaImportProductsResponse o) {
  buildCounterGoogleCloudRetailV2alphaImportProductsResponse++;
  if (buildCounterGoogleCloudRetailV2alphaImportProductsResponse < 3) {
    checkUnnamed2680(o.errorSamples!);
    checkGoogleCloudRetailV2alphaImportErrorsConfig(
        o.errorsConfig! as api.GoogleCloudRetailV2alphaImportErrorsConfig);
  }
  buildCounterGoogleCloudRetailV2alphaImportProductsResponse--;
}

core.List<api.GoogleRpcStatus> buildUnnamed2681() {
  var o = <api.GoogleRpcStatus>[];
  o.add(buildGoogleRpcStatus());
  o.add(buildGoogleRpcStatus());
  return o;
}

void checkUnnamed2681(core.List<api.GoogleRpcStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleRpcStatus(o[0] as api.GoogleRpcStatus);
  checkGoogleRpcStatus(o[1] as api.GoogleRpcStatus);
}

core.int buildCounterGoogleCloudRetailV2alphaImportUserEventsResponse = 0;
api.GoogleCloudRetailV2alphaImportUserEventsResponse
    buildGoogleCloudRetailV2alphaImportUserEventsResponse() {
  var o = api.GoogleCloudRetailV2alphaImportUserEventsResponse();
  buildCounterGoogleCloudRetailV2alphaImportUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2alphaImportUserEventsResponse < 3) {
    o.errorSamples = buildUnnamed2681();
    o.errorsConfig = buildGoogleCloudRetailV2alphaImportErrorsConfig();
    o.importSummary = buildGoogleCloudRetailV2alphaUserEventImportSummary();
  }
  buildCounterGoogleCloudRetailV2alphaImportUserEventsResponse--;
  return o;
}

void checkGoogleCloudRetailV2alphaImportUserEventsResponse(
    api.GoogleCloudRetailV2alphaImportUserEventsResponse o) {
  buildCounterGoogleCloudRetailV2alphaImportUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2alphaImportUserEventsResponse < 3) {
    checkUnnamed2681(o.errorSamples!);
    checkGoogleCloudRetailV2alphaImportErrorsConfig(
        o.errorsConfig! as api.GoogleCloudRetailV2alphaImportErrorsConfig);
    checkGoogleCloudRetailV2alphaUserEventImportSummary(
        o.importSummary! as api.GoogleCloudRetailV2alphaUserEventImportSummary);
  }
  buildCounterGoogleCloudRetailV2alphaImportUserEventsResponse--;
}

core.int buildCounterGoogleCloudRetailV2alphaPurgeMetadata = 0;
api.GoogleCloudRetailV2alphaPurgeMetadata
    buildGoogleCloudRetailV2alphaPurgeMetadata() {
  var o = api.GoogleCloudRetailV2alphaPurgeMetadata();
  buildCounterGoogleCloudRetailV2alphaPurgeMetadata++;
  if (buildCounterGoogleCloudRetailV2alphaPurgeMetadata < 3) {}
  buildCounterGoogleCloudRetailV2alphaPurgeMetadata--;
  return o;
}

void checkGoogleCloudRetailV2alphaPurgeMetadata(
    api.GoogleCloudRetailV2alphaPurgeMetadata o) {
  buildCounterGoogleCloudRetailV2alphaPurgeMetadata++;
  if (buildCounterGoogleCloudRetailV2alphaPurgeMetadata < 3) {}
  buildCounterGoogleCloudRetailV2alphaPurgeMetadata--;
}

core.int buildCounterGoogleCloudRetailV2alphaPurgeUserEventsResponse = 0;
api.GoogleCloudRetailV2alphaPurgeUserEventsResponse
    buildGoogleCloudRetailV2alphaPurgeUserEventsResponse() {
  var o = api.GoogleCloudRetailV2alphaPurgeUserEventsResponse();
  buildCounterGoogleCloudRetailV2alphaPurgeUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2alphaPurgeUserEventsResponse < 3) {
    o.purgedEventsCount = 'foo';
  }
  buildCounterGoogleCloudRetailV2alphaPurgeUserEventsResponse--;
  return o;
}

void checkGoogleCloudRetailV2alphaPurgeUserEventsResponse(
    api.GoogleCloudRetailV2alphaPurgeUserEventsResponse o) {
  buildCounterGoogleCloudRetailV2alphaPurgeUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2alphaPurgeUserEventsResponse < 3) {
    unittest.expect(
      o.purgedEventsCount!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2alphaPurgeUserEventsResponse--;
}

core.int buildCounterGoogleCloudRetailV2alphaRejoinUserEventsMetadata = 0;
api.GoogleCloudRetailV2alphaRejoinUserEventsMetadata
    buildGoogleCloudRetailV2alphaRejoinUserEventsMetadata() {
  var o = api.GoogleCloudRetailV2alphaRejoinUserEventsMetadata();
  buildCounterGoogleCloudRetailV2alphaRejoinUserEventsMetadata++;
  if (buildCounterGoogleCloudRetailV2alphaRejoinUserEventsMetadata < 3) {}
  buildCounterGoogleCloudRetailV2alphaRejoinUserEventsMetadata--;
  return o;
}

void checkGoogleCloudRetailV2alphaRejoinUserEventsMetadata(
    api.GoogleCloudRetailV2alphaRejoinUserEventsMetadata o) {
  buildCounterGoogleCloudRetailV2alphaRejoinUserEventsMetadata++;
  if (buildCounterGoogleCloudRetailV2alphaRejoinUserEventsMetadata < 3) {}
  buildCounterGoogleCloudRetailV2alphaRejoinUserEventsMetadata--;
}

core.int buildCounterGoogleCloudRetailV2alphaRejoinUserEventsResponse = 0;
api.GoogleCloudRetailV2alphaRejoinUserEventsResponse
    buildGoogleCloudRetailV2alphaRejoinUserEventsResponse() {
  var o = api.GoogleCloudRetailV2alphaRejoinUserEventsResponse();
  buildCounterGoogleCloudRetailV2alphaRejoinUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2alphaRejoinUserEventsResponse < 3) {
    o.rejoinedUserEventsCount = 'foo';
  }
  buildCounterGoogleCloudRetailV2alphaRejoinUserEventsResponse--;
  return o;
}

void checkGoogleCloudRetailV2alphaRejoinUserEventsResponse(
    api.GoogleCloudRetailV2alphaRejoinUserEventsResponse o) {
  buildCounterGoogleCloudRetailV2alphaRejoinUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2alphaRejoinUserEventsResponse < 3) {
    unittest.expect(
      o.rejoinedUserEventsCount!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2alphaRejoinUserEventsResponse--;
}

core.int buildCounterGoogleCloudRetailV2alphaUserEventImportSummary = 0;
api.GoogleCloudRetailV2alphaUserEventImportSummary
    buildGoogleCloudRetailV2alphaUserEventImportSummary() {
  var o = api.GoogleCloudRetailV2alphaUserEventImportSummary();
  buildCounterGoogleCloudRetailV2alphaUserEventImportSummary++;
  if (buildCounterGoogleCloudRetailV2alphaUserEventImportSummary < 3) {
    o.joinedEventsCount = 'foo';
    o.unjoinedEventsCount = 'foo';
  }
  buildCounterGoogleCloudRetailV2alphaUserEventImportSummary--;
  return o;
}

void checkGoogleCloudRetailV2alphaUserEventImportSummary(
    api.GoogleCloudRetailV2alphaUserEventImportSummary o) {
  buildCounterGoogleCloudRetailV2alphaUserEventImportSummary++;
  if (buildCounterGoogleCloudRetailV2alphaUserEventImportSummary < 3) {
    unittest.expect(
      o.joinedEventsCount!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.unjoinedEventsCount!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2alphaUserEventImportSummary--;
}

core.int buildCounterGoogleCloudRetailV2betaExportErrorsConfig = 0;
api.GoogleCloudRetailV2betaExportErrorsConfig
    buildGoogleCloudRetailV2betaExportErrorsConfig() {
  var o = api.GoogleCloudRetailV2betaExportErrorsConfig();
  buildCounterGoogleCloudRetailV2betaExportErrorsConfig++;
  if (buildCounterGoogleCloudRetailV2betaExportErrorsConfig < 3) {
    o.gcsPrefix = 'foo';
  }
  buildCounterGoogleCloudRetailV2betaExportErrorsConfig--;
  return o;
}

void checkGoogleCloudRetailV2betaExportErrorsConfig(
    api.GoogleCloudRetailV2betaExportErrorsConfig o) {
  buildCounterGoogleCloudRetailV2betaExportErrorsConfig++;
  if (buildCounterGoogleCloudRetailV2betaExportErrorsConfig < 3) {
    unittest.expect(
      o.gcsPrefix!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2betaExportErrorsConfig--;
}

core.int buildCounterGoogleCloudRetailV2betaExportMetadata = 0;
api.GoogleCloudRetailV2betaExportMetadata
    buildGoogleCloudRetailV2betaExportMetadata() {
  var o = api.GoogleCloudRetailV2betaExportMetadata();
  buildCounterGoogleCloudRetailV2betaExportMetadata++;
  if (buildCounterGoogleCloudRetailV2betaExportMetadata < 3) {
    o.createTime = 'foo';
    o.updateTime = 'foo';
  }
  buildCounterGoogleCloudRetailV2betaExportMetadata--;
  return o;
}

void checkGoogleCloudRetailV2betaExportMetadata(
    api.GoogleCloudRetailV2betaExportMetadata o) {
  buildCounterGoogleCloudRetailV2betaExportMetadata++;
  if (buildCounterGoogleCloudRetailV2betaExportMetadata < 3) {
    unittest.expect(
      o.createTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.updateTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2betaExportMetadata--;
}

core.List<api.GoogleRpcStatus> buildUnnamed2682() {
  var o = <api.GoogleRpcStatus>[];
  o.add(buildGoogleRpcStatus());
  o.add(buildGoogleRpcStatus());
  return o;
}

void checkUnnamed2682(core.List<api.GoogleRpcStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleRpcStatus(o[0] as api.GoogleRpcStatus);
  checkGoogleRpcStatus(o[1] as api.GoogleRpcStatus);
}

core.int buildCounterGoogleCloudRetailV2betaExportProductsResponse = 0;
api.GoogleCloudRetailV2betaExportProductsResponse
    buildGoogleCloudRetailV2betaExportProductsResponse() {
  var o = api.GoogleCloudRetailV2betaExportProductsResponse();
  buildCounterGoogleCloudRetailV2betaExportProductsResponse++;
  if (buildCounterGoogleCloudRetailV2betaExportProductsResponse < 3) {
    o.errorSamples = buildUnnamed2682();
    o.errorsConfig = buildGoogleCloudRetailV2betaExportErrorsConfig();
  }
  buildCounterGoogleCloudRetailV2betaExportProductsResponse--;
  return o;
}

void checkGoogleCloudRetailV2betaExportProductsResponse(
    api.GoogleCloudRetailV2betaExportProductsResponse o) {
  buildCounterGoogleCloudRetailV2betaExportProductsResponse++;
  if (buildCounterGoogleCloudRetailV2betaExportProductsResponse < 3) {
    checkUnnamed2682(o.errorSamples!);
    checkGoogleCloudRetailV2betaExportErrorsConfig(
        o.errorsConfig! as api.GoogleCloudRetailV2betaExportErrorsConfig);
  }
  buildCounterGoogleCloudRetailV2betaExportProductsResponse--;
}

core.List<api.GoogleRpcStatus> buildUnnamed2683() {
  var o = <api.GoogleRpcStatus>[];
  o.add(buildGoogleRpcStatus());
  o.add(buildGoogleRpcStatus());
  return o;
}

void checkUnnamed2683(core.List<api.GoogleRpcStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleRpcStatus(o[0] as api.GoogleRpcStatus);
  checkGoogleRpcStatus(o[1] as api.GoogleRpcStatus);
}

core.int buildCounterGoogleCloudRetailV2betaExportUserEventsResponse = 0;
api.GoogleCloudRetailV2betaExportUserEventsResponse
    buildGoogleCloudRetailV2betaExportUserEventsResponse() {
  var o = api.GoogleCloudRetailV2betaExportUserEventsResponse();
  buildCounterGoogleCloudRetailV2betaExportUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2betaExportUserEventsResponse < 3) {
    o.errorSamples = buildUnnamed2683();
    o.errorsConfig = buildGoogleCloudRetailV2betaExportErrorsConfig();
  }
  buildCounterGoogleCloudRetailV2betaExportUserEventsResponse--;
  return o;
}

void checkGoogleCloudRetailV2betaExportUserEventsResponse(
    api.GoogleCloudRetailV2betaExportUserEventsResponse o) {
  buildCounterGoogleCloudRetailV2betaExportUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2betaExportUserEventsResponse < 3) {
    checkUnnamed2683(o.errorSamples!);
    checkGoogleCloudRetailV2betaExportErrorsConfig(
        o.errorsConfig! as api.GoogleCloudRetailV2betaExportErrorsConfig);
  }
  buildCounterGoogleCloudRetailV2betaExportUserEventsResponse--;
}

core.int buildCounterGoogleCloudRetailV2betaImportErrorsConfig = 0;
api.GoogleCloudRetailV2betaImportErrorsConfig
    buildGoogleCloudRetailV2betaImportErrorsConfig() {
  var o = api.GoogleCloudRetailV2betaImportErrorsConfig();
  buildCounterGoogleCloudRetailV2betaImportErrorsConfig++;
  if (buildCounterGoogleCloudRetailV2betaImportErrorsConfig < 3) {
    o.gcsPrefix = 'foo';
  }
  buildCounterGoogleCloudRetailV2betaImportErrorsConfig--;
  return o;
}

void checkGoogleCloudRetailV2betaImportErrorsConfig(
    api.GoogleCloudRetailV2betaImportErrorsConfig o) {
  buildCounterGoogleCloudRetailV2betaImportErrorsConfig++;
  if (buildCounterGoogleCloudRetailV2betaImportErrorsConfig < 3) {
    unittest.expect(
      o.gcsPrefix!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2betaImportErrorsConfig--;
}

core.int buildCounterGoogleCloudRetailV2betaImportMetadata = 0;
api.GoogleCloudRetailV2betaImportMetadata
    buildGoogleCloudRetailV2betaImportMetadata() {
  var o = api.GoogleCloudRetailV2betaImportMetadata();
  buildCounterGoogleCloudRetailV2betaImportMetadata++;
  if (buildCounterGoogleCloudRetailV2betaImportMetadata < 3) {
    o.createTime = 'foo';
    o.failureCount = 'foo';
    o.successCount = 'foo';
    o.updateTime = 'foo';
  }
  buildCounterGoogleCloudRetailV2betaImportMetadata--;
  return o;
}

void checkGoogleCloudRetailV2betaImportMetadata(
    api.GoogleCloudRetailV2betaImportMetadata o) {
  buildCounterGoogleCloudRetailV2betaImportMetadata++;
  if (buildCounterGoogleCloudRetailV2betaImportMetadata < 3) {
    unittest.expect(
      o.createTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.failureCount!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.successCount!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.updateTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2betaImportMetadata--;
}

core.List<api.GoogleRpcStatus> buildUnnamed2684() {
  var o = <api.GoogleRpcStatus>[];
  o.add(buildGoogleRpcStatus());
  o.add(buildGoogleRpcStatus());
  return o;
}

void checkUnnamed2684(core.List<api.GoogleRpcStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleRpcStatus(o[0] as api.GoogleRpcStatus);
  checkGoogleRpcStatus(o[1] as api.GoogleRpcStatus);
}

core.int buildCounterGoogleCloudRetailV2betaImportProductsResponse = 0;
api.GoogleCloudRetailV2betaImportProductsResponse
    buildGoogleCloudRetailV2betaImportProductsResponse() {
  var o = api.GoogleCloudRetailV2betaImportProductsResponse();
  buildCounterGoogleCloudRetailV2betaImportProductsResponse++;
  if (buildCounterGoogleCloudRetailV2betaImportProductsResponse < 3) {
    o.errorSamples = buildUnnamed2684();
    o.errorsConfig = buildGoogleCloudRetailV2betaImportErrorsConfig();
  }
  buildCounterGoogleCloudRetailV2betaImportProductsResponse--;
  return o;
}

void checkGoogleCloudRetailV2betaImportProductsResponse(
    api.GoogleCloudRetailV2betaImportProductsResponse o) {
  buildCounterGoogleCloudRetailV2betaImportProductsResponse++;
  if (buildCounterGoogleCloudRetailV2betaImportProductsResponse < 3) {
    checkUnnamed2684(o.errorSamples!);
    checkGoogleCloudRetailV2betaImportErrorsConfig(
        o.errorsConfig! as api.GoogleCloudRetailV2betaImportErrorsConfig);
  }
  buildCounterGoogleCloudRetailV2betaImportProductsResponse--;
}

core.List<api.GoogleRpcStatus> buildUnnamed2685() {
  var o = <api.GoogleRpcStatus>[];
  o.add(buildGoogleRpcStatus());
  o.add(buildGoogleRpcStatus());
  return o;
}

void checkUnnamed2685(core.List<api.GoogleRpcStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleRpcStatus(o[0] as api.GoogleRpcStatus);
  checkGoogleRpcStatus(o[1] as api.GoogleRpcStatus);
}

core.int buildCounterGoogleCloudRetailV2betaImportUserEventsResponse = 0;
api.GoogleCloudRetailV2betaImportUserEventsResponse
    buildGoogleCloudRetailV2betaImportUserEventsResponse() {
  var o = api.GoogleCloudRetailV2betaImportUserEventsResponse();
  buildCounterGoogleCloudRetailV2betaImportUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2betaImportUserEventsResponse < 3) {
    o.errorSamples = buildUnnamed2685();
    o.errorsConfig = buildGoogleCloudRetailV2betaImportErrorsConfig();
    o.importSummary = buildGoogleCloudRetailV2betaUserEventImportSummary();
  }
  buildCounterGoogleCloudRetailV2betaImportUserEventsResponse--;
  return o;
}

void checkGoogleCloudRetailV2betaImportUserEventsResponse(
    api.GoogleCloudRetailV2betaImportUserEventsResponse o) {
  buildCounterGoogleCloudRetailV2betaImportUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2betaImportUserEventsResponse < 3) {
    checkUnnamed2685(o.errorSamples!);
    checkGoogleCloudRetailV2betaImportErrorsConfig(
        o.errorsConfig! as api.GoogleCloudRetailV2betaImportErrorsConfig);
    checkGoogleCloudRetailV2betaUserEventImportSummary(
        o.importSummary! as api.GoogleCloudRetailV2betaUserEventImportSummary);
  }
  buildCounterGoogleCloudRetailV2betaImportUserEventsResponse--;
}

core.int buildCounterGoogleCloudRetailV2betaPurgeMetadata = 0;
api.GoogleCloudRetailV2betaPurgeMetadata
    buildGoogleCloudRetailV2betaPurgeMetadata() {
  var o = api.GoogleCloudRetailV2betaPurgeMetadata();
  buildCounterGoogleCloudRetailV2betaPurgeMetadata++;
  if (buildCounterGoogleCloudRetailV2betaPurgeMetadata < 3) {}
  buildCounterGoogleCloudRetailV2betaPurgeMetadata--;
  return o;
}

void checkGoogleCloudRetailV2betaPurgeMetadata(
    api.GoogleCloudRetailV2betaPurgeMetadata o) {
  buildCounterGoogleCloudRetailV2betaPurgeMetadata++;
  if (buildCounterGoogleCloudRetailV2betaPurgeMetadata < 3) {}
  buildCounterGoogleCloudRetailV2betaPurgeMetadata--;
}

core.int buildCounterGoogleCloudRetailV2betaPurgeUserEventsResponse = 0;
api.GoogleCloudRetailV2betaPurgeUserEventsResponse
    buildGoogleCloudRetailV2betaPurgeUserEventsResponse() {
  var o = api.GoogleCloudRetailV2betaPurgeUserEventsResponse();
  buildCounterGoogleCloudRetailV2betaPurgeUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2betaPurgeUserEventsResponse < 3) {
    o.purgedEventsCount = 'foo';
  }
  buildCounterGoogleCloudRetailV2betaPurgeUserEventsResponse--;
  return o;
}

void checkGoogleCloudRetailV2betaPurgeUserEventsResponse(
    api.GoogleCloudRetailV2betaPurgeUserEventsResponse o) {
  buildCounterGoogleCloudRetailV2betaPurgeUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2betaPurgeUserEventsResponse < 3) {
    unittest.expect(
      o.purgedEventsCount!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2betaPurgeUserEventsResponse--;
}

core.int buildCounterGoogleCloudRetailV2betaRejoinUserEventsMetadata = 0;
api.GoogleCloudRetailV2betaRejoinUserEventsMetadata
    buildGoogleCloudRetailV2betaRejoinUserEventsMetadata() {
  var o = api.GoogleCloudRetailV2betaRejoinUserEventsMetadata();
  buildCounterGoogleCloudRetailV2betaRejoinUserEventsMetadata++;
  if (buildCounterGoogleCloudRetailV2betaRejoinUserEventsMetadata < 3) {}
  buildCounterGoogleCloudRetailV2betaRejoinUserEventsMetadata--;
  return o;
}

void checkGoogleCloudRetailV2betaRejoinUserEventsMetadata(
    api.GoogleCloudRetailV2betaRejoinUserEventsMetadata o) {
  buildCounterGoogleCloudRetailV2betaRejoinUserEventsMetadata++;
  if (buildCounterGoogleCloudRetailV2betaRejoinUserEventsMetadata < 3) {}
  buildCounterGoogleCloudRetailV2betaRejoinUserEventsMetadata--;
}

core.int buildCounterGoogleCloudRetailV2betaRejoinUserEventsResponse = 0;
api.GoogleCloudRetailV2betaRejoinUserEventsResponse
    buildGoogleCloudRetailV2betaRejoinUserEventsResponse() {
  var o = api.GoogleCloudRetailV2betaRejoinUserEventsResponse();
  buildCounterGoogleCloudRetailV2betaRejoinUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2betaRejoinUserEventsResponse < 3) {
    o.rejoinedUserEventsCount = 'foo';
  }
  buildCounterGoogleCloudRetailV2betaRejoinUserEventsResponse--;
  return o;
}

void checkGoogleCloudRetailV2betaRejoinUserEventsResponse(
    api.GoogleCloudRetailV2betaRejoinUserEventsResponse o) {
  buildCounterGoogleCloudRetailV2betaRejoinUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2betaRejoinUserEventsResponse < 3) {
    unittest.expect(
      o.rejoinedUserEventsCount!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2betaRejoinUserEventsResponse--;
}

core.int buildCounterGoogleCloudRetailV2betaUserEventImportSummary = 0;
api.GoogleCloudRetailV2betaUserEventImportSummary
    buildGoogleCloudRetailV2betaUserEventImportSummary() {
  var o = api.GoogleCloudRetailV2betaUserEventImportSummary();
  buildCounterGoogleCloudRetailV2betaUserEventImportSummary++;
  if (buildCounterGoogleCloudRetailV2betaUserEventImportSummary < 3) {
    o.joinedEventsCount = 'foo';
    o.unjoinedEventsCount = 'foo';
  }
  buildCounterGoogleCloudRetailV2betaUserEventImportSummary--;
  return o;
}

void checkGoogleCloudRetailV2betaUserEventImportSummary(
    api.GoogleCloudRetailV2betaUserEventImportSummary o) {
  buildCounterGoogleCloudRetailV2betaUserEventImportSummary++;
  if (buildCounterGoogleCloudRetailV2betaUserEventImportSummary < 3) {
    unittest.expect(
      o.joinedEventsCount!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.unjoinedEventsCount!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2betaUserEventImportSummary--;
}

core.int buildCounterGoogleCloudRetailV2mainExportErrorsConfig = 0;
api.GoogleCloudRetailV2mainExportErrorsConfig
    buildGoogleCloudRetailV2mainExportErrorsConfig() {
  var o = api.GoogleCloudRetailV2mainExportErrorsConfig();
  buildCounterGoogleCloudRetailV2mainExportErrorsConfig++;
  if (buildCounterGoogleCloudRetailV2mainExportErrorsConfig < 3) {
    o.gcsPrefix = 'foo';
  }
  buildCounterGoogleCloudRetailV2mainExportErrorsConfig--;
  return o;
}

void checkGoogleCloudRetailV2mainExportErrorsConfig(
    api.GoogleCloudRetailV2mainExportErrorsConfig o) {
  buildCounterGoogleCloudRetailV2mainExportErrorsConfig++;
  if (buildCounterGoogleCloudRetailV2mainExportErrorsConfig < 3) {
    unittest.expect(
      o.gcsPrefix!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2mainExportErrorsConfig--;
}

core.int buildCounterGoogleCloudRetailV2mainExportMetadata = 0;
api.GoogleCloudRetailV2mainExportMetadata
    buildGoogleCloudRetailV2mainExportMetadata() {
  var o = api.GoogleCloudRetailV2mainExportMetadata();
  buildCounterGoogleCloudRetailV2mainExportMetadata++;
  if (buildCounterGoogleCloudRetailV2mainExportMetadata < 3) {
    o.createTime = 'foo';
    o.updateTime = 'foo';
  }
  buildCounterGoogleCloudRetailV2mainExportMetadata--;
  return o;
}

void checkGoogleCloudRetailV2mainExportMetadata(
    api.GoogleCloudRetailV2mainExportMetadata o) {
  buildCounterGoogleCloudRetailV2mainExportMetadata++;
  if (buildCounterGoogleCloudRetailV2mainExportMetadata < 3) {
    unittest.expect(
      o.createTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.updateTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2mainExportMetadata--;
}

core.List<api.GoogleRpcStatus> buildUnnamed2686() {
  var o = <api.GoogleRpcStatus>[];
  o.add(buildGoogleRpcStatus());
  o.add(buildGoogleRpcStatus());
  return o;
}

void checkUnnamed2686(core.List<api.GoogleRpcStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleRpcStatus(o[0] as api.GoogleRpcStatus);
  checkGoogleRpcStatus(o[1] as api.GoogleRpcStatus);
}

core.int buildCounterGoogleCloudRetailV2mainExportProductsResponse = 0;
api.GoogleCloudRetailV2mainExportProductsResponse
    buildGoogleCloudRetailV2mainExportProductsResponse() {
  var o = api.GoogleCloudRetailV2mainExportProductsResponse();
  buildCounterGoogleCloudRetailV2mainExportProductsResponse++;
  if (buildCounterGoogleCloudRetailV2mainExportProductsResponse < 3) {
    o.errorSamples = buildUnnamed2686();
    o.errorsConfig = buildGoogleCloudRetailV2mainExportErrorsConfig();
  }
  buildCounterGoogleCloudRetailV2mainExportProductsResponse--;
  return o;
}

void checkGoogleCloudRetailV2mainExportProductsResponse(
    api.GoogleCloudRetailV2mainExportProductsResponse o) {
  buildCounterGoogleCloudRetailV2mainExportProductsResponse++;
  if (buildCounterGoogleCloudRetailV2mainExportProductsResponse < 3) {
    checkUnnamed2686(o.errorSamples!);
    checkGoogleCloudRetailV2mainExportErrorsConfig(
        o.errorsConfig! as api.GoogleCloudRetailV2mainExportErrorsConfig);
  }
  buildCounterGoogleCloudRetailV2mainExportProductsResponse--;
}

core.List<api.GoogleRpcStatus> buildUnnamed2687() {
  var o = <api.GoogleRpcStatus>[];
  o.add(buildGoogleRpcStatus());
  o.add(buildGoogleRpcStatus());
  return o;
}

void checkUnnamed2687(core.List<api.GoogleRpcStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleRpcStatus(o[0] as api.GoogleRpcStatus);
  checkGoogleRpcStatus(o[1] as api.GoogleRpcStatus);
}

core.int buildCounterGoogleCloudRetailV2mainExportUserEventsResponse = 0;
api.GoogleCloudRetailV2mainExportUserEventsResponse
    buildGoogleCloudRetailV2mainExportUserEventsResponse() {
  var o = api.GoogleCloudRetailV2mainExportUserEventsResponse();
  buildCounterGoogleCloudRetailV2mainExportUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2mainExportUserEventsResponse < 3) {
    o.errorSamples = buildUnnamed2687();
    o.errorsConfig = buildGoogleCloudRetailV2mainExportErrorsConfig();
  }
  buildCounterGoogleCloudRetailV2mainExportUserEventsResponse--;
  return o;
}

void checkGoogleCloudRetailV2mainExportUserEventsResponse(
    api.GoogleCloudRetailV2mainExportUserEventsResponse o) {
  buildCounterGoogleCloudRetailV2mainExportUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2mainExportUserEventsResponse < 3) {
    checkUnnamed2687(o.errorSamples!);
    checkGoogleCloudRetailV2mainExportErrorsConfig(
        o.errorsConfig! as api.GoogleCloudRetailV2mainExportErrorsConfig);
  }
  buildCounterGoogleCloudRetailV2mainExportUserEventsResponse--;
}

core.int buildCounterGoogleCloudRetailV2mainImportErrorsConfig = 0;
api.GoogleCloudRetailV2mainImportErrorsConfig
    buildGoogleCloudRetailV2mainImportErrorsConfig() {
  var o = api.GoogleCloudRetailV2mainImportErrorsConfig();
  buildCounterGoogleCloudRetailV2mainImportErrorsConfig++;
  if (buildCounterGoogleCloudRetailV2mainImportErrorsConfig < 3) {
    o.gcsPrefix = 'foo';
  }
  buildCounterGoogleCloudRetailV2mainImportErrorsConfig--;
  return o;
}

void checkGoogleCloudRetailV2mainImportErrorsConfig(
    api.GoogleCloudRetailV2mainImportErrorsConfig o) {
  buildCounterGoogleCloudRetailV2mainImportErrorsConfig++;
  if (buildCounterGoogleCloudRetailV2mainImportErrorsConfig < 3) {
    unittest.expect(
      o.gcsPrefix!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2mainImportErrorsConfig--;
}

core.int buildCounterGoogleCloudRetailV2mainImportMetadata = 0;
api.GoogleCloudRetailV2mainImportMetadata
    buildGoogleCloudRetailV2mainImportMetadata() {
  var o = api.GoogleCloudRetailV2mainImportMetadata();
  buildCounterGoogleCloudRetailV2mainImportMetadata++;
  if (buildCounterGoogleCloudRetailV2mainImportMetadata < 3) {
    o.createTime = 'foo';
    o.failureCount = 'foo';
    o.successCount = 'foo';
    o.updateTime = 'foo';
  }
  buildCounterGoogleCloudRetailV2mainImportMetadata--;
  return o;
}

void checkGoogleCloudRetailV2mainImportMetadata(
    api.GoogleCloudRetailV2mainImportMetadata o) {
  buildCounterGoogleCloudRetailV2mainImportMetadata++;
  if (buildCounterGoogleCloudRetailV2mainImportMetadata < 3) {
    unittest.expect(
      o.createTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.failureCount!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.successCount!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.updateTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2mainImportMetadata--;
}

core.List<api.GoogleRpcStatus> buildUnnamed2688() {
  var o = <api.GoogleRpcStatus>[];
  o.add(buildGoogleRpcStatus());
  o.add(buildGoogleRpcStatus());
  return o;
}

void checkUnnamed2688(core.List<api.GoogleRpcStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleRpcStatus(o[0] as api.GoogleRpcStatus);
  checkGoogleRpcStatus(o[1] as api.GoogleRpcStatus);
}

core.int buildCounterGoogleCloudRetailV2mainImportProductsResponse = 0;
api.GoogleCloudRetailV2mainImportProductsResponse
    buildGoogleCloudRetailV2mainImportProductsResponse() {
  var o = api.GoogleCloudRetailV2mainImportProductsResponse();
  buildCounterGoogleCloudRetailV2mainImportProductsResponse++;
  if (buildCounterGoogleCloudRetailV2mainImportProductsResponse < 3) {
    o.errorSamples = buildUnnamed2688();
    o.errorsConfig = buildGoogleCloudRetailV2mainImportErrorsConfig();
  }
  buildCounterGoogleCloudRetailV2mainImportProductsResponse--;
  return o;
}

void checkGoogleCloudRetailV2mainImportProductsResponse(
    api.GoogleCloudRetailV2mainImportProductsResponse o) {
  buildCounterGoogleCloudRetailV2mainImportProductsResponse++;
  if (buildCounterGoogleCloudRetailV2mainImportProductsResponse < 3) {
    checkUnnamed2688(o.errorSamples!);
    checkGoogleCloudRetailV2mainImportErrorsConfig(
        o.errorsConfig! as api.GoogleCloudRetailV2mainImportErrorsConfig);
  }
  buildCounterGoogleCloudRetailV2mainImportProductsResponse--;
}

core.List<api.GoogleRpcStatus> buildUnnamed2689() {
  var o = <api.GoogleRpcStatus>[];
  o.add(buildGoogleRpcStatus());
  o.add(buildGoogleRpcStatus());
  return o;
}

void checkUnnamed2689(core.List<api.GoogleRpcStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleRpcStatus(o[0] as api.GoogleRpcStatus);
  checkGoogleRpcStatus(o[1] as api.GoogleRpcStatus);
}

core.int buildCounterGoogleCloudRetailV2mainImportUserEventsResponse = 0;
api.GoogleCloudRetailV2mainImportUserEventsResponse
    buildGoogleCloudRetailV2mainImportUserEventsResponse() {
  var o = api.GoogleCloudRetailV2mainImportUserEventsResponse();
  buildCounterGoogleCloudRetailV2mainImportUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2mainImportUserEventsResponse < 3) {
    o.errorSamples = buildUnnamed2689();
    o.errorsConfig = buildGoogleCloudRetailV2mainImportErrorsConfig();
    o.importSummary = buildGoogleCloudRetailV2mainUserEventImportSummary();
  }
  buildCounterGoogleCloudRetailV2mainImportUserEventsResponse--;
  return o;
}

void checkGoogleCloudRetailV2mainImportUserEventsResponse(
    api.GoogleCloudRetailV2mainImportUserEventsResponse o) {
  buildCounterGoogleCloudRetailV2mainImportUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2mainImportUserEventsResponse < 3) {
    checkUnnamed2689(o.errorSamples!);
    checkGoogleCloudRetailV2mainImportErrorsConfig(
        o.errorsConfig! as api.GoogleCloudRetailV2mainImportErrorsConfig);
    checkGoogleCloudRetailV2mainUserEventImportSummary(
        o.importSummary! as api.GoogleCloudRetailV2mainUserEventImportSummary);
  }
  buildCounterGoogleCloudRetailV2mainImportUserEventsResponse--;
}

core.int buildCounterGoogleCloudRetailV2mainPurgeMetadata = 0;
api.GoogleCloudRetailV2mainPurgeMetadata
    buildGoogleCloudRetailV2mainPurgeMetadata() {
  var o = api.GoogleCloudRetailV2mainPurgeMetadata();
  buildCounterGoogleCloudRetailV2mainPurgeMetadata++;
  if (buildCounterGoogleCloudRetailV2mainPurgeMetadata < 3) {}
  buildCounterGoogleCloudRetailV2mainPurgeMetadata--;
  return o;
}

void checkGoogleCloudRetailV2mainPurgeMetadata(
    api.GoogleCloudRetailV2mainPurgeMetadata o) {
  buildCounterGoogleCloudRetailV2mainPurgeMetadata++;
  if (buildCounterGoogleCloudRetailV2mainPurgeMetadata < 3) {}
  buildCounterGoogleCloudRetailV2mainPurgeMetadata--;
}

core.int buildCounterGoogleCloudRetailV2mainPurgeUserEventsResponse = 0;
api.GoogleCloudRetailV2mainPurgeUserEventsResponse
    buildGoogleCloudRetailV2mainPurgeUserEventsResponse() {
  var o = api.GoogleCloudRetailV2mainPurgeUserEventsResponse();
  buildCounterGoogleCloudRetailV2mainPurgeUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2mainPurgeUserEventsResponse < 3) {
    o.purgedEventsCount = 'foo';
  }
  buildCounterGoogleCloudRetailV2mainPurgeUserEventsResponse--;
  return o;
}

void checkGoogleCloudRetailV2mainPurgeUserEventsResponse(
    api.GoogleCloudRetailV2mainPurgeUserEventsResponse o) {
  buildCounterGoogleCloudRetailV2mainPurgeUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2mainPurgeUserEventsResponse < 3) {
    unittest.expect(
      o.purgedEventsCount!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2mainPurgeUserEventsResponse--;
}

core.int buildCounterGoogleCloudRetailV2mainRejoinUserEventsMetadata = 0;
api.GoogleCloudRetailV2mainRejoinUserEventsMetadata
    buildGoogleCloudRetailV2mainRejoinUserEventsMetadata() {
  var o = api.GoogleCloudRetailV2mainRejoinUserEventsMetadata();
  buildCounterGoogleCloudRetailV2mainRejoinUserEventsMetadata++;
  if (buildCounterGoogleCloudRetailV2mainRejoinUserEventsMetadata < 3) {}
  buildCounterGoogleCloudRetailV2mainRejoinUserEventsMetadata--;
  return o;
}

void checkGoogleCloudRetailV2mainRejoinUserEventsMetadata(
    api.GoogleCloudRetailV2mainRejoinUserEventsMetadata o) {
  buildCounterGoogleCloudRetailV2mainRejoinUserEventsMetadata++;
  if (buildCounterGoogleCloudRetailV2mainRejoinUserEventsMetadata < 3) {}
  buildCounterGoogleCloudRetailV2mainRejoinUserEventsMetadata--;
}

core.int buildCounterGoogleCloudRetailV2mainRejoinUserEventsResponse = 0;
api.GoogleCloudRetailV2mainRejoinUserEventsResponse
    buildGoogleCloudRetailV2mainRejoinUserEventsResponse() {
  var o = api.GoogleCloudRetailV2mainRejoinUserEventsResponse();
  buildCounterGoogleCloudRetailV2mainRejoinUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2mainRejoinUserEventsResponse < 3) {
    o.rejoinedUserEventsCount = 'foo';
  }
  buildCounterGoogleCloudRetailV2mainRejoinUserEventsResponse--;
  return o;
}

void checkGoogleCloudRetailV2mainRejoinUserEventsResponse(
    api.GoogleCloudRetailV2mainRejoinUserEventsResponse o) {
  buildCounterGoogleCloudRetailV2mainRejoinUserEventsResponse++;
  if (buildCounterGoogleCloudRetailV2mainRejoinUserEventsResponse < 3) {
    unittest.expect(
      o.rejoinedUserEventsCount!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2mainRejoinUserEventsResponse--;
}

core.int buildCounterGoogleCloudRetailV2mainUserEventImportSummary = 0;
api.GoogleCloudRetailV2mainUserEventImportSummary
    buildGoogleCloudRetailV2mainUserEventImportSummary() {
  var o = api.GoogleCloudRetailV2mainUserEventImportSummary();
  buildCounterGoogleCloudRetailV2mainUserEventImportSummary++;
  if (buildCounterGoogleCloudRetailV2mainUserEventImportSummary < 3) {
    o.joinedEventsCount = 'foo';
    o.unjoinedEventsCount = 'foo';
  }
  buildCounterGoogleCloudRetailV2mainUserEventImportSummary--;
  return o;
}

void checkGoogleCloudRetailV2mainUserEventImportSummary(
    api.GoogleCloudRetailV2mainUserEventImportSummary o) {
  buildCounterGoogleCloudRetailV2mainUserEventImportSummary++;
  if (buildCounterGoogleCloudRetailV2mainUserEventImportSummary < 3) {
    unittest.expect(
      o.joinedEventsCount!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.unjoinedEventsCount!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudRetailV2mainUserEventImportSummary--;
}

core.List<api.GoogleLongrunningOperation> buildUnnamed2690() {
  var o = <api.GoogleLongrunningOperation>[];
  o.add(buildGoogleLongrunningOperation());
  o.add(buildGoogleLongrunningOperation());
  return o;
}

void checkUnnamed2690(core.List<api.GoogleLongrunningOperation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleLongrunningOperation(o[0] as api.GoogleLongrunningOperation);
  checkGoogleLongrunningOperation(o[1] as api.GoogleLongrunningOperation);
}

core.int buildCounterGoogleLongrunningListOperationsResponse = 0;
api.GoogleLongrunningListOperationsResponse
    buildGoogleLongrunningListOperationsResponse() {
  var o = api.GoogleLongrunningListOperationsResponse();
  buildCounterGoogleLongrunningListOperationsResponse++;
  if (buildCounterGoogleLongrunningListOperationsResponse < 3) {
    o.nextPageToken = 'foo';
    o.operations = buildUnnamed2690();
  }
  buildCounterGoogleLongrunningListOperationsResponse--;
  return o;
}

void checkGoogleLongrunningListOperationsResponse(
    api.GoogleLongrunningListOperationsResponse o) {
  buildCounterGoogleLongrunningListOperationsResponse++;
  if (buildCounterGoogleLongrunningListOperationsResponse < 3) {
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
    checkUnnamed2690(o.operations!);
  }
  buildCounterGoogleLongrunningListOperationsResponse--;
}

core.Map<core.String, core.Object> buildUnnamed2691() {
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

void checkUnnamed2691(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted11 = (o['x']!) as core.Map;
  unittest.expect(casted11, unittest.hasLength(3));
  unittest.expect(
    casted11['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted11['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted11['string'],
    unittest.equals('foo'),
  );
  var casted12 = (o['y']!) as core.Map;
  unittest.expect(casted12, unittest.hasLength(3));
  unittest.expect(
    casted12['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted12['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted12['string'],
    unittest.equals('foo'),
  );
}

core.Map<core.String, core.Object> buildUnnamed2692() {
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

void checkUnnamed2692(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted13 = (o['x']!) as core.Map;
  unittest.expect(casted13, unittest.hasLength(3));
  unittest.expect(
    casted13['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted13['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted13['string'],
    unittest.equals('foo'),
  );
  var casted14 = (o['y']!) as core.Map;
  unittest.expect(casted14, unittest.hasLength(3));
  unittest.expect(
    casted14['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted14['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted14['string'],
    unittest.equals('foo'),
  );
}

core.int buildCounterGoogleLongrunningOperation = 0;
api.GoogleLongrunningOperation buildGoogleLongrunningOperation() {
  var o = api.GoogleLongrunningOperation();
  buildCounterGoogleLongrunningOperation++;
  if (buildCounterGoogleLongrunningOperation < 3) {
    o.done = true;
    o.error = buildGoogleRpcStatus();
    o.metadata = buildUnnamed2691();
    o.name = 'foo';
    o.response = buildUnnamed2692();
  }
  buildCounterGoogleLongrunningOperation--;
  return o;
}

void checkGoogleLongrunningOperation(api.GoogleLongrunningOperation o) {
  buildCounterGoogleLongrunningOperation++;
  if (buildCounterGoogleLongrunningOperation < 3) {
    unittest.expect(o.done!, unittest.isTrue);
    checkGoogleRpcStatus(o.error! as api.GoogleRpcStatus);
    checkUnnamed2691(o.metadata!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed2692(o.response!);
  }
  buildCounterGoogleLongrunningOperation--;
}

core.int buildCounterGoogleProtobufEmpty = 0;
api.GoogleProtobufEmpty buildGoogleProtobufEmpty() {
  var o = api.GoogleProtobufEmpty();
  buildCounterGoogleProtobufEmpty++;
  if (buildCounterGoogleProtobufEmpty < 3) {}
  buildCounterGoogleProtobufEmpty--;
  return o;
}

void checkGoogleProtobufEmpty(api.GoogleProtobufEmpty o) {
  buildCounterGoogleProtobufEmpty++;
  if (buildCounterGoogleProtobufEmpty < 3) {}
  buildCounterGoogleProtobufEmpty--;
}

core.Map<core.String, core.Object> buildUnnamed2693() {
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

void checkUnnamed2693(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted15 = (o['x']!) as core.Map;
  unittest.expect(casted15, unittest.hasLength(3));
  unittest.expect(
    casted15['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted15['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted15['string'],
    unittest.equals('foo'),
  );
  var casted16 = (o['y']!) as core.Map;
  unittest.expect(casted16, unittest.hasLength(3));
  unittest.expect(
    casted16['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted16['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted16['string'],
    unittest.equals('foo'),
  );
}

core.List<core.Map<core.String, core.Object>> buildUnnamed2694() {
  var o = <core.Map<core.String, core.Object>>[];
  o.add(buildUnnamed2693());
  o.add(buildUnnamed2693());
  return o;
}

void checkUnnamed2694(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed2693(o[0]);
  checkUnnamed2693(o[1]);
}

core.int buildCounterGoogleRpcStatus = 0;
api.GoogleRpcStatus buildGoogleRpcStatus() {
  var o = api.GoogleRpcStatus();
  buildCounterGoogleRpcStatus++;
  if (buildCounterGoogleRpcStatus < 3) {
    o.code = 42;
    o.details = buildUnnamed2694();
    o.message = 'foo';
  }
  buildCounterGoogleRpcStatus--;
  return o;
}

void checkGoogleRpcStatus(api.GoogleRpcStatus o) {
  buildCounterGoogleRpcStatus++;
  if (buildCounterGoogleRpcStatus < 3) {
    unittest.expect(
      o.code!,
      unittest.equals(42),
    );
    checkUnnamed2694(o.details!);
    unittest.expect(
      o.message!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleRpcStatus--;
}

void main() {
  unittest.group('obj-schema-GoogleApiHttpBody', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleApiHttpBody();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleApiHttpBody.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleApiHttpBody(od as api.GoogleApiHttpBody);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailLoggingErrorContext', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailLoggingErrorContext();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailLoggingErrorContext.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailLoggingErrorContext(
          od as api.GoogleCloudRetailLoggingErrorContext);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailLoggingErrorLog', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailLoggingErrorLog();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailLoggingErrorLog.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailLoggingErrorLog(
          od as api.GoogleCloudRetailLoggingErrorLog);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailLoggingHttpRequestContext', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailLoggingHttpRequestContext();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailLoggingHttpRequestContext.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailLoggingHttpRequestContext(
          od as api.GoogleCloudRetailLoggingHttpRequestContext);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailLoggingImportErrorContext', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailLoggingImportErrorContext();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailLoggingImportErrorContext.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailLoggingImportErrorContext(
          od as api.GoogleCloudRetailLoggingImportErrorContext);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailLoggingServiceContext', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailLoggingServiceContext();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailLoggingServiceContext.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailLoggingServiceContext(
          od as api.GoogleCloudRetailLoggingServiceContext);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailLoggingSourceLocation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailLoggingSourceLocation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailLoggingSourceLocation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailLoggingSourceLocation(
          od as api.GoogleCloudRetailLoggingSourceLocation);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2BigQuerySource', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2BigQuerySource();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2BigQuerySource.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2BigQuerySource(
          od as api.GoogleCloudRetailV2BigQuerySource);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2Catalog', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2Catalog();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2Catalog.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2Catalog(od as api.GoogleCloudRetailV2Catalog);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2CustomAttribute', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2CustomAttribute();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2CustomAttribute.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2CustomAttribute(
          od as api.GoogleCloudRetailV2CustomAttribute);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2GcsSource', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2GcsSource();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2GcsSource.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2GcsSource(od as api.GoogleCloudRetailV2GcsSource);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2Image', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2Image();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2Image.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2Image(od as api.GoogleCloudRetailV2Image);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2ImportErrorsConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2ImportErrorsConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2ImportErrorsConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2ImportErrorsConfig(
          od as api.GoogleCloudRetailV2ImportErrorsConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2ImportMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2ImportMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2ImportMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2ImportMetadata(
          od as api.GoogleCloudRetailV2ImportMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2ImportProductsRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2ImportProductsRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2ImportProductsRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2ImportProductsRequest(
          od as api.GoogleCloudRetailV2ImportProductsRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2ImportProductsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2ImportProductsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2ImportProductsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2ImportProductsResponse(
          od as api.GoogleCloudRetailV2ImportProductsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2ImportUserEventsRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2ImportUserEventsRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2ImportUserEventsRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2ImportUserEventsRequest(
          od as api.GoogleCloudRetailV2ImportUserEventsRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2ImportUserEventsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2ImportUserEventsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2ImportUserEventsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2ImportUserEventsResponse(
          od as api.GoogleCloudRetailV2ImportUserEventsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2ListCatalogsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2ListCatalogsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2ListCatalogsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2ListCatalogsResponse(
          od as api.GoogleCloudRetailV2ListCatalogsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2PredictRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2PredictRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2PredictRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2PredictRequest(
          od as api.GoogleCloudRetailV2PredictRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2PredictResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2PredictResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2PredictResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2PredictResponse(
          od as api.GoogleCloudRetailV2PredictResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudRetailV2PredictResponsePredictionResult', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2PredictResponsePredictionResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2PredictResponsePredictionResult.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2PredictResponsePredictionResult(
          od as api.GoogleCloudRetailV2PredictResponsePredictionResult);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2PriceInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2PriceInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2PriceInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2PriceInfo(od as api.GoogleCloudRetailV2PriceInfo);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2Product', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2Product();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2Product.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2Product(od as api.GoogleCloudRetailV2Product);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2ProductDetail', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2ProductDetail();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2ProductDetail.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2ProductDetail(
          od as api.GoogleCloudRetailV2ProductDetail);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2ProductInlineSource', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2ProductInlineSource();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2ProductInlineSource.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2ProductInlineSource(
          od as api.GoogleCloudRetailV2ProductInlineSource);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2ProductInputConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2ProductInputConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2ProductInputConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2ProductInputConfig(
          od as api.GoogleCloudRetailV2ProductInputConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2ProductLevelConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2ProductLevelConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2ProductLevelConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2ProductLevelConfig(
          od as api.GoogleCloudRetailV2ProductLevelConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2PurchaseTransaction', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2PurchaseTransaction();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2PurchaseTransaction.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2PurchaseTransaction(
          od as api.GoogleCloudRetailV2PurchaseTransaction);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2PurgeMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2PurgeMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2PurgeMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2PurgeMetadata(
          od as api.GoogleCloudRetailV2PurgeMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2PurgeUserEventsRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2PurgeUserEventsRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2PurgeUserEventsRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2PurgeUserEventsRequest(
          od as api.GoogleCloudRetailV2PurgeUserEventsRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2PurgeUserEventsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2PurgeUserEventsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2PurgeUserEventsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2PurgeUserEventsResponse(
          od as api.GoogleCloudRetailV2PurgeUserEventsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2RejoinUserEventsMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2RejoinUserEventsMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2RejoinUserEventsMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2RejoinUserEventsMetadata(
          od as api.GoogleCloudRetailV2RejoinUserEventsMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2RejoinUserEventsRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2RejoinUserEventsRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2RejoinUserEventsRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2RejoinUserEventsRequest(
          od as api.GoogleCloudRetailV2RejoinUserEventsRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2RejoinUserEventsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2RejoinUserEventsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2RejoinUserEventsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2RejoinUserEventsResponse(
          od as api.GoogleCloudRetailV2RejoinUserEventsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2UserEvent', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2UserEvent();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2UserEvent.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2UserEvent(od as api.GoogleCloudRetailV2UserEvent);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2UserEventImportSummary', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2UserEventImportSummary();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2UserEventImportSummary.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2UserEventImportSummary(
          od as api.GoogleCloudRetailV2UserEventImportSummary);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2UserEventInlineSource', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2UserEventInlineSource();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2UserEventInlineSource.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2UserEventInlineSource(
          od as api.GoogleCloudRetailV2UserEventInlineSource);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2UserEventInputConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2UserEventInputConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2UserEventInputConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2UserEventInputConfig(
          od as api.GoogleCloudRetailV2UserEventInputConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2UserInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2UserInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2UserInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2UserInfo(od as api.GoogleCloudRetailV2UserInfo);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2alphaExportErrorsConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2alphaExportErrorsConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2alphaExportErrorsConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2alphaExportErrorsConfig(
          od as api.GoogleCloudRetailV2alphaExportErrorsConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2alphaExportMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2alphaExportMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2alphaExportMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2alphaExportMetadata(
          od as api.GoogleCloudRetailV2alphaExportMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2alphaExportProductsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2alphaExportProductsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2alphaExportProductsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2alphaExportProductsResponse(
          od as api.GoogleCloudRetailV2alphaExportProductsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2alphaExportUserEventsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2alphaExportUserEventsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2alphaExportUserEventsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2alphaExportUserEventsResponse(
          od as api.GoogleCloudRetailV2alphaExportUserEventsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2alphaImportErrorsConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2alphaImportErrorsConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2alphaImportErrorsConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2alphaImportErrorsConfig(
          od as api.GoogleCloudRetailV2alphaImportErrorsConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2alphaImportMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2alphaImportMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2alphaImportMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2alphaImportMetadata(
          od as api.GoogleCloudRetailV2alphaImportMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2alphaImportProductsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2alphaImportProductsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2alphaImportProductsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2alphaImportProductsResponse(
          od as api.GoogleCloudRetailV2alphaImportProductsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2alphaImportUserEventsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2alphaImportUserEventsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2alphaImportUserEventsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2alphaImportUserEventsResponse(
          od as api.GoogleCloudRetailV2alphaImportUserEventsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2alphaPurgeMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2alphaPurgeMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2alphaPurgeMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2alphaPurgeMetadata(
          od as api.GoogleCloudRetailV2alphaPurgeMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2alphaPurgeUserEventsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2alphaPurgeUserEventsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2alphaPurgeUserEventsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2alphaPurgeUserEventsResponse(
          od as api.GoogleCloudRetailV2alphaPurgeUserEventsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2alphaRejoinUserEventsMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2alphaRejoinUserEventsMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2alphaRejoinUserEventsMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2alphaRejoinUserEventsMetadata(
          od as api.GoogleCloudRetailV2alphaRejoinUserEventsMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2alphaRejoinUserEventsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2alphaRejoinUserEventsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2alphaRejoinUserEventsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2alphaRejoinUserEventsResponse(
          od as api.GoogleCloudRetailV2alphaRejoinUserEventsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2alphaUserEventImportSummary',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2alphaUserEventImportSummary();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2alphaUserEventImportSummary.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2alphaUserEventImportSummary(
          od as api.GoogleCloudRetailV2alphaUserEventImportSummary);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2betaExportErrorsConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2betaExportErrorsConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2betaExportErrorsConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2betaExportErrorsConfig(
          od as api.GoogleCloudRetailV2betaExportErrorsConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2betaExportMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2betaExportMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2betaExportMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2betaExportMetadata(
          od as api.GoogleCloudRetailV2betaExportMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2betaExportProductsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2betaExportProductsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2betaExportProductsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2betaExportProductsResponse(
          od as api.GoogleCloudRetailV2betaExportProductsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2betaExportUserEventsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2betaExportUserEventsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2betaExportUserEventsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2betaExportUserEventsResponse(
          od as api.GoogleCloudRetailV2betaExportUserEventsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2betaImportErrorsConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2betaImportErrorsConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2betaImportErrorsConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2betaImportErrorsConfig(
          od as api.GoogleCloudRetailV2betaImportErrorsConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2betaImportMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2betaImportMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2betaImportMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2betaImportMetadata(
          od as api.GoogleCloudRetailV2betaImportMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2betaImportProductsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2betaImportProductsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2betaImportProductsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2betaImportProductsResponse(
          od as api.GoogleCloudRetailV2betaImportProductsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2betaImportUserEventsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2betaImportUserEventsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2betaImportUserEventsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2betaImportUserEventsResponse(
          od as api.GoogleCloudRetailV2betaImportUserEventsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2betaPurgeMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2betaPurgeMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2betaPurgeMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2betaPurgeMetadata(
          od as api.GoogleCloudRetailV2betaPurgeMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2betaPurgeUserEventsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2betaPurgeUserEventsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2betaPurgeUserEventsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2betaPurgeUserEventsResponse(
          od as api.GoogleCloudRetailV2betaPurgeUserEventsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2betaRejoinUserEventsMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2betaRejoinUserEventsMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2betaRejoinUserEventsMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2betaRejoinUserEventsMetadata(
          od as api.GoogleCloudRetailV2betaRejoinUserEventsMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2betaRejoinUserEventsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2betaRejoinUserEventsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2betaRejoinUserEventsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2betaRejoinUserEventsResponse(
          od as api.GoogleCloudRetailV2betaRejoinUserEventsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2betaUserEventImportSummary',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2betaUserEventImportSummary();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2betaUserEventImportSummary.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2betaUserEventImportSummary(
          od as api.GoogleCloudRetailV2betaUserEventImportSummary);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2mainExportErrorsConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2mainExportErrorsConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2mainExportErrorsConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2mainExportErrorsConfig(
          od as api.GoogleCloudRetailV2mainExportErrorsConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2mainExportMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2mainExportMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2mainExportMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2mainExportMetadata(
          od as api.GoogleCloudRetailV2mainExportMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2mainExportProductsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2mainExportProductsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2mainExportProductsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2mainExportProductsResponse(
          od as api.GoogleCloudRetailV2mainExportProductsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2mainExportUserEventsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2mainExportUserEventsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2mainExportUserEventsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2mainExportUserEventsResponse(
          od as api.GoogleCloudRetailV2mainExportUserEventsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2mainImportErrorsConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2mainImportErrorsConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2mainImportErrorsConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2mainImportErrorsConfig(
          od as api.GoogleCloudRetailV2mainImportErrorsConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2mainImportMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2mainImportMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2mainImportMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2mainImportMetadata(
          od as api.GoogleCloudRetailV2mainImportMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2mainImportProductsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2mainImportProductsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2mainImportProductsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2mainImportProductsResponse(
          od as api.GoogleCloudRetailV2mainImportProductsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2mainImportUserEventsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2mainImportUserEventsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2mainImportUserEventsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2mainImportUserEventsResponse(
          od as api.GoogleCloudRetailV2mainImportUserEventsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2mainPurgeMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2mainPurgeMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2mainPurgeMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2mainPurgeMetadata(
          od as api.GoogleCloudRetailV2mainPurgeMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2mainPurgeUserEventsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2mainPurgeUserEventsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2mainPurgeUserEventsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2mainPurgeUserEventsResponse(
          od as api.GoogleCloudRetailV2mainPurgeUserEventsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2mainRejoinUserEventsMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2mainRejoinUserEventsMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2mainRejoinUserEventsMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2mainRejoinUserEventsMetadata(
          od as api.GoogleCloudRetailV2mainRejoinUserEventsMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2mainRejoinUserEventsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2mainRejoinUserEventsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2mainRejoinUserEventsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2mainRejoinUserEventsResponse(
          od as api.GoogleCloudRetailV2mainRejoinUserEventsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudRetailV2mainUserEventImportSummary',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudRetailV2mainUserEventImportSummary();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudRetailV2mainUserEventImportSummary.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudRetailV2mainUserEventImportSummary(
          od as api.GoogleCloudRetailV2mainUserEventImportSummary);
    });
  });

  unittest.group('obj-schema-GoogleLongrunningListOperationsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleLongrunningListOperationsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleLongrunningListOperationsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleLongrunningListOperationsResponse(
          od as api.GoogleLongrunningListOperationsResponse);
    });
  });

  unittest.group('obj-schema-GoogleLongrunningOperation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleLongrunningOperation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleLongrunningOperation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleLongrunningOperation(od as api.GoogleLongrunningOperation);
    });
  });

  unittest.group('obj-schema-GoogleProtobufEmpty', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleProtobufEmpty();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleProtobufEmpty.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleProtobufEmpty(od as api.GoogleProtobufEmpty);
    });
  });

  unittest.group('obj-schema-GoogleRpcStatus', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleRpcStatus();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleRpcStatus.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleRpcStatus(od as api.GoogleRpcStatus);
    });
  });

  unittest.group('resource-ProjectsLocationsCatalogsResource', () {
    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.CloudRetailApi(mock).projects.locations.catalogs;
      var arg_parent = 'foo';
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
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v2/"),
        );
        pathOffset += 3;
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
        var resp =
            convert.json.encode(buildGoogleCloudRetailV2ListCatalogsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudRetailV2ListCatalogsResponse(
          response as api.GoogleCloudRetailV2ListCatalogsResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.CloudRetailApi(mock).projects.locations.catalogs;
      var arg_request = buildGoogleCloudRetailV2Catalog();
      var arg_name = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudRetailV2Catalog.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudRetailV2Catalog(obj as api.GoogleCloudRetailV2Catalog);

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
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v2/"),
        );
        pathOffset += 3;
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
          queryMap["updateMask"]!.first,
          unittest.equals(arg_updateMask),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleCloudRetailV2Catalog());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          updateMask: arg_updateMask, $fields: arg_$fields);
      checkGoogleCloudRetailV2Catalog(
          response as api.GoogleCloudRetailV2Catalog);
    });
  });

  unittest.group('resource-ProjectsLocationsCatalogsBranchesOperationsResource',
      () {
    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.CloudRetailApi(mock)
          .projects
          .locations
          .catalogs
          .branches
          .operations;
      var arg_name = 'foo';
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
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v2/"),
        );
        pathOffset += 3;
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
        var resp = convert.json.encode(buildGoogleLongrunningOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });
  });

  unittest.group('resource-ProjectsLocationsCatalogsBranchesProductsResource',
      () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.CloudRetailApi(mock)
          .projects
          .locations
          .catalogs
          .branches
          .products;
      var arg_request = buildGoogleCloudRetailV2Product();
      var arg_parent = 'foo';
      var arg_productId = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudRetailV2Product.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudRetailV2Product(obj as api.GoogleCloudRetailV2Product);

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
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v2/"),
        );
        pathOffset += 3;
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
          queryMap["productId"]!.first,
          unittest.equals(arg_productId),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleCloudRetailV2Product());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.create(arg_request, arg_parent,
          productId: arg_productId, $fields: arg_$fields);
      checkGoogleCloudRetailV2Product(
          response as api.GoogleCloudRetailV2Product);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.CloudRetailApi(mock)
          .projects
          .locations
          .catalogs
          .branches
          .products;
      var arg_name = 'foo';
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
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v2/"),
        );
        pathOffset += 3;
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
        var resp = convert.json.encode(buildGoogleProtobufEmpty());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleProtobufEmpty(response as api.GoogleProtobufEmpty);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.CloudRetailApi(mock)
          .projects
          .locations
          .catalogs
          .branches
          .products;
      var arg_name = 'foo';
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
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v2/"),
        );
        pathOffset += 3;
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
        var resp = convert.json.encode(buildGoogleCloudRetailV2Product());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudRetailV2Product(
          response as api.GoogleCloudRetailV2Product);
    });

    unittest.test('method--import', () async {
      var mock = HttpServerMock();
      var res = api.CloudRetailApi(mock)
          .projects
          .locations
          .catalogs
          .branches
          .products;
      var arg_request = buildGoogleCloudRetailV2ImportProductsRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudRetailV2ImportProductsRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudRetailV2ImportProductsRequest(
            obj as api.GoogleCloudRetailV2ImportProductsRequest);

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
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v2/"),
        );
        pathOffset += 3;
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
        var resp = convert.json.encode(buildGoogleLongrunningOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.import(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.CloudRetailApi(mock)
          .projects
          .locations
          .catalogs
          .branches
          .products;
      var arg_request = buildGoogleCloudRetailV2Product();
      var arg_name = 'foo';
      var arg_allowMissing = true;
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudRetailV2Product.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudRetailV2Product(obj as api.GoogleCloudRetailV2Product);

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
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v2/"),
        );
        pathOffset += 3;
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
          queryMap["allowMissing"]!.first,
          unittest.equals("$arg_allowMissing"),
        );
        unittest.expect(
          queryMap["updateMask"]!.first,
          unittest.equals(arg_updateMask),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleCloudRetailV2Product());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          allowMissing: arg_allowMissing,
          updateMask: arg_updateMask,
          $fields: arg_$fields);
      checkGoogleCloudRetailV2Product(
          response as api.GoogleCloudRetailV2Product);
    });
  });

  unittest.group('resource-ProjectsLocationsCatalogsOperationsResource', () {
    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.CloudRetailApi(mock).projects.locations.catalogs.operations;
      var arg_name = 'foo';
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
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v2/"),
        );
        pathOffset += 3;
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
        var resp = convert.json.encode(buildGoogleLongrunningOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.CloudRetailApi(mock).projects.locations.catalogs.operations;
      var arg_name = 'foo';
      var arg_filter = 'foo';
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
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v2/"),
        );
        pathOffset += 3;
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
          queryMap["filter"]!.first,
          unittest.equals(arg_filter),
        );
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
        var resp =
            convert.json.encode(buildGoogleLongrunningListOperationsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_name,
          filter: arg_filter,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleLongrunningListOperationsResponse(
          response as api.GoogleLongrunningListOperationsResponse);
    });
  });

  unittest.group('resource-ProjectsLocationsCatalogsPlacementsResource', () {
    unittest.test('method--predict', () async {
      var mock = HttpServerMock();
      var res = api.CloudRetailApi(mock).projects.locations.catalogs.placements;
      var arg_request = buildGoogleCloudRetailV2PredictRequest();
      var arg_placement = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudRetailV2PredictRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudRetailV2PredictRequest(
            obj as api.GoogleCloudRetailV2PredictRequest);

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
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v2/"),
        );
        pathOffset += 3;
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
        var resp =
            convert.json.encode(buildGoogleCloudRetailV2PredictResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.predict(arg_request, arg_placement, $fields: arg_$fields);
      checkGoogleCloudRetailV2PredictResponse(
          response as api.GoogleCloudRetailV2PredictResponse);
    });
  });

  unittest.group('resource-ProjectsLocationsCatalogsUserEventsResource', () {
    unittest.test('method--collect', () async {
      var mock = HttpServerMock();
      var res = api.CloudRetailApi(mock).projects.locations.catalogs.userEvents;
      var arg_parent = 'foo';
      var arg_ets = 'foo';
      var arg_uri = 'foo';
      var arg_userEvent = 'foo';
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
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v2/"),
        );
        pathOffset += 3;
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
          queryMap["ets"]!.first,
          unittest.equals(arg_ets),
        );
        unittest.expect(
          queryMap["uri"]!.first,
          unittest.equals(arg_uri),
        );
        unittest.expect(
          queryMap["userEvent"]!.first,
          unittest.equals(arg_userEvent),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleApiHttpBody());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.collect(arg_parent,
          ets: arg_ets,
          uri: arg_uri,
          userEvent: arg_userEvent,
          $fields: arg_$fields);
      checkGoogleApiHttpBody(response as api.GoogleApiHttpBody);
    });

    unittest.test('method--import', () async {
      var mock = HttpServerMock();
      var res = api.CloudRetailApi(mock).projects.locations.catalogs.userEvents;
      var arg_request = buildGoogleCloudRetailV2ImportUserEventsRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudRetailV2ImportUserEventsRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudRetailV2ImportUserEventsRequest(
            obj as api.GoogleCloudRetailV2ImportUserEventsRequest);

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
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v2/"),
        );
        pathOffset += 3;
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
        var resp = convert.json.encode(buildGoogleLongrunningOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.import(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--purge', () async {
      var mock = HttpServerMock();
      var res = api.CloudRetailApi(mock).projects.locations.catalogs.userEvents;
      var arg_request = buildGoogleCloudRetailV2PurgeUserEventsRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudRetailV2PurgeUserEventsRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudRetailV2PurgeUserEventsRequest(
            obj as api.GoogleCloudRetailV2PurgeUserEventsRequest);

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
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v2/"),
        );
        pathOffset += 3;
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
        var resp = convert.json.encode(buildGoogleLongrunningOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.purge(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--rejoin', () async {
      var mock = HttpServerMock();
      var res = api.CloudRetailApi(mock).projects.locations.catalogs.userEvents;
      var arg_request = buildGoogleCloudRetailV2RejoinUserEventsRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudRetailV2RejoinUserEventsRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudRetailV2RejoinUserEventsRequest(
            obj as api.GoogleCloudRetailV2RejoinUserEventsRequest);

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
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v2/"),
        );
        pathOffset += 3;
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
        var resp = convert.json.encode(buildGoogleLongrunningOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.rejoin(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--write', () async {
      var mock = HttpServerMock();
      var res = api.CloudRetailApi(mock).projects.locations.catalogs.userEvents;
      var arg_request = buildGoogleCloudRetailV2UserEvent();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudRetailV2UserEvent.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudRetailV2UserEvent(
            obj as api.GoogleCloudRetailV2UserEvent);

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
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v2/"),
        );
        pathOffset += 3;
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
        var resp = convert.json.encode(buildGoogleCloudRetailV2UserEvent());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.write(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudRetailV2UserEvent(
          response as api.GoogleCloudRetailV2UserEvent);
    });
  });

  unittest.group('resource-ProjectsLocationsOperationsResource', () {
    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.CloudRetailApi(mock).projects.locations.operations;
      var arg_name = 'foo';
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
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v2/"),
        );
        pathOffset += 3;
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
        var resp = convert.json.encode(buildGoogleLongrunningOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.CloudRetailApi(mock).projects.locations.operations;
      var arg_name = 'foo';
      var arg_filter = 'foo';
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
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v2/"),
        );
        pathOffset += 3;
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
          queryMap["filter"]!.first,
          unittest.equals(arg_filter),
        );
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
        var resp =
            convert.json.encode(buildGoogleLongrunningListOperationsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_name,
          filter: arg_filter,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleLongrunningListOperationsResponse(
          response as api.GoogleLongrunningListOperationsResponse);
    });
  });
}
