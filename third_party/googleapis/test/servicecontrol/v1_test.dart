library googleapis.servicecontrol.v1.test;

import "dart:core" as core;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:test/test.dart' as unittest;

import 'package:googleapis/servicecontrol/v1.dart' as api;

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

buildUnnamed545() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed545(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterAllocateInfo = 0;
buildAllocateInfo() {
  var o = new api.AllocateInfo();
  buildCounterAllocateInfo++;
  if (buildCounterAllocateInfo < 3) {
    o.unusedArguments = buildUnnamed545();
  }
  buildCounterAllocateInfo--;
  return o;
}

checkAllocateInfo(api.AllocateInfo o) {
  buildCounterAllocateInfo++;
  if (buildCounterAllocateInfo < 3) {
    checkUnnamed545(o.unusedArguments);
  }
  buildCounterAllocateInfo--;
}

core.int buildCounterAllocateQuotaRequest = 0;
buildAllocateQuotaRequest() {
  var o = new api.AllocateQuotaRequest();
  buildCounterAllocateQuotaRequest++;
  if (buildCounterAllocateQuotaRequest < 3) {
    o.allocateOperation = buildQuotaOperation();
    o.serviceConfigId = "foo";
  }
  buildCounterAllocateQuotaRequest--;
  return o;
}

checkAllocateQuotaRequest(api.AllocateQuotaRequest o) {
  buildCounterAllocateQuotaRequest++;
  if (buildCounterAllocateQuotaRequest < 3) {
    checkQuotaOperation(o.allocateOperation);
    unittest.expect(o.serviceConfigId, unittest.equals('foo'));
  }
  buildCounterAllocateQuotaRequest--;
}

buildUnnamed546() {
  var o = new core.List<api.QuotaError>();
  o.add(buildQuotaError());
  o.add(buildQuotaError());
  return o;
}

checkUnnamed546(core.List<api.QuotaError> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkQuotaError(o[0]);
  checkQuotaError(o[1]);
}

buildUnnamed547() {
  var o = new core.List<api.MetricValueSet>();
  o.add(buildMetricValueSet());
  o.add(buildMetricValueSet());
  return o;
}

checkUnnamed547(core.List<api.MetricValueSet> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMetricValueSet(o[0]);
  checkMetricValueSet(o[1]);
}

core.int buildCounterAllocateQuotaResponse = 0;
buildAllocateQuotaResponse() {
  var o = new api.AllocateQuotaResponse();
  buildCounterAllocateQuotaResponse++;
  if (buildCounterAllocateQuotaResponse < 3) {
    o.allocateErrors = buildUnnamed546();
    o.allocateInfo = buildAllocateInfo();
    o.operationId = "foo";
    o.quotaMetrics = buildUnnamed547();
    o.serviceConfigId = "foo";
  }
  buildCounterAllocateQuotaResponse--;
  return o;
}

checkAllocateQuotaResponse(api.AllocateQuotaResponse o) {
  buildCounterAllocateQuotaResponse++;
  if (buildCounterAllocateQuotaResponse < 3) {
    checkUnnamed546(o.allocateErrors);
    checkAllocateInfo(o.allocateInfo);
    unittest.expect(o.operationId, unittest.equals('foo'));
    checkUnnamed547(o.quotaMetrics);
    unittest.expect(o.serviceConfigId, unittest.equals('foo'));
  }
  buildCounterAllocateQuotaResponse--;
}

buildUnnamed548() {
  var o = new core.List<api.AuthorizationInfo>();
  o.add(buildAuthorizationInfo());
  o.add(buildAuthorizationInfo());
  return o;
}

checkUnnamed548(core.List<api.AuthorizationInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAuthorizationInfo(o[0]);
  checkAuthorizationInfo(o[1]);
}

buildUnnamed549() {
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

checkUnnamed549(core.Map<core.String, core.Object> o) {
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

buildUnnamed550() {
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

checkUnnamed550(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted3 = (o["x"]) as core.Map;
  unittest.expect(casted3, unittest.hasLength(3));
  unittest.expect(casted3["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted3["bool"], unittest.equals(true));
  unittest.expect(casted3["string"], unittest.equals('foo'));
  var casted4 = (o["y"]) as core.Map;
  unittest.expect(casted4, unittest.hasLength(3));
  unittest.expect(casted4["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted4["bool"], unittest.equals(true));
  unittest.expect(casted4["string"], unittest.equals('foo'));
}

buildUnnamed551() {
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

checkUnnamed551(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted5 = (o["x"]) as core.Map;
  unittest.expect(casted5, unittest.hasLength(3));
  unittest.expect(casted5["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted5["bool"], unittest.equals(true));
  unittest.expect(casted5["string"], unittest.equals('foo'));
  var casted6 = (o["y"]) as core.Map;
  unittest.expect(casted6, unittest.hasLength(3));
  unittest.expect(casted6["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted6["bool"], unittest.equals(true));
  unittest.expect(casted6["string"], unittest.equals('foo'));
}

buildUnnamed552() {
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

checkUnnamed552(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted7 = (o["x"]) as core.Map;
  unittest.expect(casted7, unittest.hasLength(3));
  unittest.expect(casted7["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted7["bool"], unittest.equals(true));
  unittest.expect(casted7["string"], unittest.equals('foo'));
  var casted8 = (o["y"]) as core.Map;
  unittest.expect(casted8, unittest.hasLength(3));
  unittest.expect(casted8["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted8["bool"], unittest.equals(true));
  unittest.expect(casted8["string"], unittest.equals('foo'));
}

buildUnnamed553() {
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

checkUnnamed553(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted9 = (o["x"]) as core.Map;
  unittest.expect(casted9, unittest.hasLength(3));
  unittest.expect(casted9["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted9["bool"], unittest.equals(true));
  unittest.expect(casted9["string"], unittest.equals('foo'));
  var casted10 = (o["y"]) as core.Map;
  unittest.expect(casted10, unittest.hasLength(3));
  unittest.expect(casted10["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted10["bool"], unittest.equals(true));
  unittest.expect(casted10["string"], unittest.equals('foo'));
}

core.int buildCounterAuditLog = 0;
buildAuditLog() {
  var o = new api.AuditLog();
  buildCounterAuditLog++;
  if (buildCounterAuditLog < 3) {
    o.authenticationInfo = buildAuthenticationInfo();
    o.authorizationInfo = buildUnnamed548();
    o.metadata = buildUnnamed549();
    o.methodName = "foo";
    o.numResponseItems = "foo";
    o.request = buildUnnamed550();
    o.requestMetadata = buildRequestMetadata();
    o.resourceLocation = buildResourceLocation();
    o.resourceName = "foo";
    o.resourceOriginalState = buildUnnamed551();
    o.response = buildUnnamed552();
    o.serviceData = buildUnnamed553();
    o.serviceName = "foo";
    o.status = buildStatus();
  }
  buildCounterAuditLog--;
  return o;
}

checkAuditLog(api.AuditLog o) {
  buildCounterAuditLog++;
  if (buildCounterAuditLog < 3) {
    checkAuthenticationInfo(o.authenticationInfo);
    checkUnnamed548(o.authorizationInfo);
    checkUnnamed549(o.metadata);
    unittest.expect(o.methodName, unittest.equals('foo'));
    unittest.expect(o.numResponseItems, unittest.equals('foo'));
    checkUnnamed550(o.request);
    checkRequestMetadata(o.requestMetadata);
    checkResourceLocation(o.resourceLocation);
    unittest.expect(o.resourceName, unittest.equals('foo'));
    checkUnnamed551(o.resourceOriginalState);
    checkUnnamed552(o.response);
    checkUnnamed553(o.serviceData);
    unittest.expect(o.serviceName, unittest.equals('foo'));
    checkStatus(o.status);
  }
  buildCounterAuditLog--;
}

buildUnnamed554() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed554(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed555() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed555(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed556() {
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

checkUnnamed556(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted11 = (o["x"]) as core.Map;
  unittest.expect(casted11, unittest.hasLength(3));
  unittest.expect(casted11["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted11["bool"], unittest.equals(true));
  unittest.expect(casted11["string"], unittest.equals('foo'));
  var casted12 = (o["y"]) as core.Map;
  unittest.expect(casted12, unittest.hasLength(3));
  unittest.expect(casted12["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted12["bool"], unittest.equals(true));
  unittest.expect(casted12["string"], unittest.equals('foo'));
}

core.int buildCounterAuth = 0;
buildAuth() {
  var o = new api.Auth();
  buildCounterAuth++;
  if (buildCounterAuth < 3) {
    o.accessLevels = buildUnnamed554();
    o.audiences = buildUnnamed555();
    o.claims = buildUnnamed556();
    o.presenter = "foo";
    o.principal = "foo";
  }
  buildCounterAuth--;
  return o;
}

checkAuth(api.Auth o) {
  buildCounterAuth++;
  if (buildCounterAuth < 3) {
    checkUnnamed554(o.accessLevels);
    checkUnnamed555(o.audiences);
    checkUnnamed556(o.claims);
    unittest.expect(o.presenter, unittest.equals('foo'));
    unittest.expect(o.principal, unittest.equals('foo'));
  }
  buildCounterAuth--;
}

buildUnnamed557() {
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

checkUnnamed557(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted13 = (o["x"]) as core.Map;
  unittest.expect(casted13, unittest.hasLength(3));
  unittest.expect(casted13["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted13["bool"], unittest.equals(true));
  unittest.expect(casted13["string"], unittest.equals('foo'));
  var casted14 = (o["y"]) as core.Map;
  unittest.expect(casted14, unittest.hasLength(3));
  unittest.expect(casted14["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted14["bool"], unittest.equals(true));
  unittest.expect(casted14["string"], unittest.equals('foo'));
}

core.int buildCounterAuthenticationInfo = 0;
buildAuthenticationInfo() {
  var o = new api.AuthenticationInfo();
  buildCounterAuthenticationInfo++;
  if (buildCounterAuthenticationInfo < 3) {
    o.authoritySelector = "foo";
    o.principalEmail = "foo";
    o.serviceAccountKeyName = "foo";
    o.thirdPartyPrincipal = buildUnnamed557();
  }
  buildCounterAuthenticationInfo--;
  return o;
}

checkAuthenticationInfo(api.AuthenticationInfo o) {
  buildCounterAuthenticationInfo++;
  if (buildCounterAuthenticationInfo < 3) {
    unittest.expect(o.authoritySelector, unittest.equals('foo'));
    unittest.expect(o.principalEmail, unittest.equals('foo'));
    unittest.expect(o.serviceAccountKeyName, unittest.equals('foo'));
    checkUnnamed557(o.thirdPartyPrincipal);
  }
  buildCounterAuthenticationInfo--;
}

core.int buildCounterAuthorizationInfo = 0;
buildAuthorizationInfo() {
  var o = new api.AuthorizationInfo();
  buildCounterAuthorizationInfo++;
  if (buildCounterAuthorizationInfo < 3) {
    o.granted = true;
    o.permission = "foo";
    o.resource = "foo";
    o.resourceAttributes = buildResource();
  }
  buildCounterAuthorizationInfo--;
  return o;
}

checkAuthorizationInfo(api.AuthorizationInfo o) {
  buildCounterAuthorizationInfo++;
  if (buildCounterAuthorizationInfo < 3) {
    unittest.expect(o.granted, unittest.isTrue);
    unittest.expect(o.permission, unittest.equals('foo'));
    unittest.expect(o.resource, unittest.equals('foo'));
    checkResource(o.resourceAttributes);
  }
  buildCounterAuthorizationInfo--;
}

core.int buildCounterCheckError = 0;
buildCheckError() {
  var o = new api.CheckError();
  buildCounterCheckError++;
  if (buildCounterCheckError < 3) {
    o.code = "foo";
    o.detail = "foo";
    o.subject = "foo";
  }
  buildCounterCheckError--;
  return o;
}

checkCheckError(api.CheckError o) {
  buildCounterCheckError++;
  if (buildCounterCheckError < 3) {
    unittest.expect(o.code, unittest.equals('foo'));
    unittest.expect(o.detail, unittest.equals('foo'));
    unittest.expect(o.subject, unittest.equals('foo'));
  }
  buildCounterCheckError--;
}

buildUnnamed558() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed558(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterCheckInfo = 0;
buildCheckInfo() {
  var o = new api.CheckInfo();
  buildCounterCheckInfo++;
  if (buildCounterCheckInfo < 3) {
    o.consumerInfo = buildConsumerInfo();
    o.unusedArguments = buildUnnamed558();
  }
  buildCounterCheckInfo--;
  return o;
}

checkCheckInfo(api.CheckInfo o) {
  buildCounterCheckInfo++;
  if (buildCounterCheckInfo < 3) {
    checkConsumerInfo(o.consumerInfo);
    checkUnnamed558(o.unusedArguments);
  }
  buildCounterCheckInfo--;
}

core.int buildCounterCheckRequest = 0;
buildCheckRequest() {
  var o = new api.CheckRequest();
  buildCounterCheckRequest++;
  if (buildCounterCheckRequest < 3) {
    o.operation = buildOperation();
    o.requestProjectSettings = true;
    o.serviceConfigId = "foo";
    o.skipActivationCheck = true;
  }
  buildCounterCheckRequest--;
  return o;
}

checkCheckRequest(api.CheckRequest o) {
  buildCounterCheckRequest++;
  if (buildCounterCheckRequest < 3) {
    checkOperation(o.operation);
    unittest.expect(o.requestProjectSettings, unittest.isTrue);
    unittest.expect(o.serviceConfigId, unittest.equals('foo'));
    unittest.expect(o.skipActivationCheck, unittest.isTrue);
  }
  buildCounterCheckRequest--;
}

buildUnnamed559() {
  var o = new core.List<api.CheckError>();
  o.add(buildCheckError());
  o.add(buildCheckError());
  return o;
}

checkUnnamed559(core.List<api.CheckError> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCheckError(o[0]);
  checkCheckError(o[1]);
}

core.int buildCounterCheckResponse = 0;
buildCheckResponse() {
  var o = new api.CheckResponse();
  buildCounterCheckResponse++;
  if (buildCounterCheckResponse < 3) {
    o.checkErrors = buildUnnamed559();
    o.checkInfo = buildCheckInfo();
    o.operationId = "foo";
    o.quotaInfo = buildQuotaInfo();
    o.serviceConfigId = "foo";
  }
  buildCounterCheckResponse--;
  return o;
}

checkCheckResponse(api.CheckResponse o) {
  buildCounterCheckResponse++;
  if (buildCounterCheckResponse < 3) {
    checkUnnamed559(o.checkErrors);
    checkCheckInfo(o.checkInfo);
    unittest.expect(o.operationId, unittest.equals('foo'));
    checkQuotaInfo(o.quotaInfo);
    unittest.expect(o.serviceConfigId, unittest.equals('foo'));
  }
  buildCounterCheckResponse--;
}

core.int buildCounterConsumerInfo = 0;
buildConsumerInfo() {
  var o = new api.ConsumerInfo();
  buildCounterConsumerInfo++;
  if (buildCounterConsumerInfo < 3) {
    o.consumerNumber = "foo";
    o.projectNumber = "foo";
    o.type = "foo";
  }
  buildCounterConsumerInfo--;
  return o;
}

checkConsumerInfo(api.ConsumerInfo o) {
  buildCounterConsumerInfo++;
  if (buildCounterConsumerInfo < 3) {
    unittest.expect(o.consumerNumber, unittest.equals('foo'));
    unittest.expect(o.projectNumber, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterConsumerInfo--;
}

buildUnnamed560() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed560(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterDistribution = 0;
buildDistribution() {
  var o = new api.Distribution();
  buildCounterDistribution++;
  if (buildCounterDistribution < 3) {
    o.bucketCounts = buildUnnamed560();
    o.count = "foo";
    o.explicitBuckets = buildExplicitBuckets();
    o.exponentialBuckets = buildExponentialBuckets();
    o.linearBuckets = buildLinearBuckets();
    o.maximum = 42.0;
    o.mean = 42.0;
    o.minimum = 42.0;
    o.sumOfSquaredDeviation = 42.0;
  }
  buildCounterDistribution--;
  return o;
}

checkDistribution(api.Distribution o) {
  buildCounterDistribution++;
  if (buildCounterDistribution < 3) {
    checkUnnamed560(o.bucketCounts);
    unittest.expect(o.count, unittest.equals('foo'));
    checkExplicitBuckets(o.explicitBuckets);
    checkExponentialBuckets(o.exponentialBuckets);
    checkLinearBuckets(o.linearBuckets);
    unittest.expect(o.maximum, unittest.equals(42.0));
    unittest.expect(o.mean, unittest.equals(42.0));
    unittest.expect(o.minimum, unittest.equals(42.0));
    unittest.expect(o.sumOfSquaredDeviation, unittest.equals(42.0));
  }
  buildCounterDistribution--;
}

buildUnnamed561() {
  var o = new core.List<core.double>();
  o.add(42.0);
  o.add(42.0);
  return o;
}

checkUnnamed561(core.List<core.double> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals(42.0));
  unittest.expect(o[1], unittest.equals(42.0));
}

core.int buildCounterExplicitBuckets = 0;
buildExplicitBuckets() {
  var o = new api.ExplicitBuckets();
  buildCounterExplicitBuckets++;
  if (buildCounterExplicitBuckets < 3) {
    o.bounds = buildUnnamed561();
  }
  buildCounterExplicitBuckets--;
  return o;
}

checkExplicitBuckets(api.ExplicitBuckets o) {
  buildCounterExplicitBuckets++;
  if (buildCounterExplicitBuckets < 3) {
    checkUnnamed561(o.bounds);
  }
  buildCounterExplicitBuckets--;
}

core.int buildCounterExponentialBuckets = 0;
buildExponentialBuckets() {
  var o = new api.ExponentialBuckets();
  buildCounterExponentialBuckets++;
  if (buildCounterExponentialBuckets < 3) {
    o.growthFactor = 42.0;
    o.numFiniteBuckets = 42;
    o.scale = 42.0;
  }
  buildCounterExponentialBuckets--;
  return o;
}

checkExponentialBuckets(api.ExponentialBuckets o) {
  buildCounterExponentialBuckets++;
  if (buildCounterExponentialBuckets < 3) {
    unittest.expect(o.growthFactor, unittest.equals(42.0));
    unittest.expect(o.numFiniteBuckets, unittest.equals(42));
    unittest.expect(o.scale, unittest.equals(42.0));
  }
  buildCounterExponentialBuckets--;
}

core.int buildCounterHttpRequest = 0;
buildHttpRequest() {
  var o = new api.HttpRequest();
  buildCounterHttpRequest++;
  if (buildCounterHttpRequest < 3) {
    o.cacheFillBytes = "foo";
    o.cacheHit = true;
    o.cacheLookup = true;
    o.cacheValidatedWithOriginServer = true;
    o.latency = "foo";
    o.protocol = "foo";
    o.referer = "foo";
    o.remoteIp = "foo";
    o.requestMethod = "foo";
    o.requestSize = "foo";
    o.requestUrl = "foo";
    o.responseSize = "foo";
    o.serverIp = "foo";
    o.status = 42;
    o.userAgent = "foo";
  }
  buildCounterHttpRequest--;
  return o;
}

checkHttpRequest(api.HttpRequest o) {
  buildCounterHttpRequest++;
  if (buildCounterHttpRequest < 3) {
    unittest.expect(o.cacheFillBytes, unittest.equals('foo'));
    unittest.expect(o.cacheHit, unittest.isTrue);
    unittest.expect(o.cacheLookup, unittest.isTrue);
    unittest.expect(o.cacheValidatedWithOriginServer, unittest.isTrue);
    unittest.expect(o.latency, unittest.equals('foo'));
    unittest.expect(o.protocol, unittest.equals('foo'));
    unittest.expect(o.referer, unittest.equals('foo'));
    unittest.expect(o.remoteIp, unittest.equals('foo'));
    unittest.expect(o.requestMethod, unittest.equals('foo'));
    unittest.expect(o.requestSize, unittest.equals('foo'));
    unittest.expect(o.requestUrl, unittest.equals('foo'));
    unittest.expect(o.responseSize, unittest.equals('foo'));
    unittest.expect(o.serverIp, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals(42));
    unittest.expect(o.userAgent, unittest.equals('foo'));
  }
  buildCounterHttpRequest--;
}

core.int buildCounterLinearBuckets = 0;
buildLinearBuckets() {
  var o = new api.LinearBuckets();
  buildCounterLinearBuckets++;
  if (buildCounterLinearBuckets < 3) {
    o.numFiniteBuckets = 42;
    o.offset = 42.0;
    o.width = 42.0;
  }
  buildCounterLinearBuckets--;
  return o;
}

checkLinearBuckets(api.LinearBuckets o) {
  buildCounterLinearBuckets++;
  if (buildCounterLinearBuckets < 3) {
    unittest.expect(o.numFiniteBuckets, unittest.equals(42));
    unittest.expect(o.offset, unittest.equals(42.0));
    unittest.expect(o.width, unittest.equals(42.0));
  }
  buildCounterLinearBuckets--;
}

buildUnnamed562() {
  var o = new core.Map<core.String, core.String>();
  o["x"] = "foo";
  o["y"] = "foo";
  return o;
}

checkUnnamed562(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals('foo'));
  unittest.expect(o["y"], unittest.equals('foo'));
}

buildUnnamed563() {
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

checkUnnamed563(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted15 = (o["x"]) as core.Map;
  unittest.expect(casted15, unittest.hasLength(3));
  unittest.expect(casted15["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted15["bool"], unittest.equals(true));
  unittest.expect(casted15["string"], unittest.equals('foo'));
  var casted16 = (o["y"]) as core.Map;
  unittest.expect(casted16, unittest.hasLength(3));
  unittest.expect(casted16["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted16["bool"], unittest.equals(true));
  unittest.expect(casted16["string"], unittest.equals('foo'));
}

buildUnnamed564() {
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

checkUnnamed564(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted17 = (o["x"]) as core.Map;
  unittest.expect(casted17, unittest.hasLength(3));
  unittest.expect(casted17["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted17["bool"], unittest.equals(true));
  unittest.expect(casted17["string"], unittest.equals('foo'));
  var casted18 = (o["y"]) as core.Map;
  unittest.expect(casted18, unittest.hasLength(3));
  unittest.expect(casted18["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted18["bool"], unittest.equals(true));
  unittest.expect(casted18["string"], unittest.equals('foo'));
}

core.int buildCounterLogEntry = 0;
buildLogEntry() {
  var o = new api.LogEntry();
  buildCounterLogEntry++;
  if (buildCounterLogEntry < 3) {
    o.httpRequest = buildHttpRequest();
    o.insertId = "foo";
    o.labels = buildUnnamed562();
    o.name = "foo";
    o.operation = buildLogEntryOperation();
    o.protoPayload = buildUnnamed563();
    o.severity = "foo";
    o.structPayload = buildUnnamed564();
    o.textPayload = "foo";
    o.timestamp = "foo";
    o.trace = "foo";
  }
  buildCounterLogEntry--;
  return o;
}

checkLogEntry(api.LogEntry o) {
  buildCounterLogEntry++;
  if (buildCounterLogEntry < 3) {
    checkHttpRequest(o.httpRequest);
    unittest.expect(o.insertId, unittest.equals('foo'));
    checkUnnamed562(o.labels);
    unittest.expect(o.name, unittest.equals('foo'));
    checkLogEntryOperation(o.operation);
    checkUnnamed563(o.protoPayload);
    unittest.expect(o.severity, unittest.equals('foo'));
    checkUnnamed564(o.structPayload);
    unittest.expect(o.textPayload, unittest.equals('foo'));
    unittest.expect(o.timestamp, unittest.equals('foo'));
    unittest.expect(o.trace, unittest.equals('foo'));
  }
  buildCounterLogEntry--;
}

core.int buildCounterLogEntryOperation = 0;
buildLogEntryOperation() {
  var o = new api.LogEntryOperation();
  buildCounterLogEntryOperation++;
  if (buildCounterLogEntryOperation < 3) {
    o.first = true;
    o.id = "foo";
    o.last = true;
    o.producer = "foo";
  }
  buildCounterLogEntryOperation--;
  return o;
}

checkLogEntryOperation(api.LogEntryOperation o) {
  buildCounterLogEntryOperation++;
  if (buildCounterLogEntryOperation < 3) {
    unittest.expect(o.first, unittest.isTrue);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.last, unittest.isTrue);
    unittest.expect(o.producer, unittest.equals('foo'));
  }
  buildCounterLogEntryOperation--;
}

buildUnnamed565() {
  var o = new core.Map<core.String, core.String>();
  o["x"] = "foo";
  o["y"] = "foo";
  return o;
}

checkUnnamed565(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals('foo'));
  unittest.expect(o["y"], unittest.equals('foo'));
}

core.int buildCounterMetricValue = 0;
buildMetricValue() {
  var o = new api.MetricValue();
  buildCounterMetricValue++;
  if (buildCounterMetricValue < 3) {
    o.boolValue = true;
    o.distributionValue = buildDistribution();
    o.doubleValue = 42.0;
    o.endTime = "foo";
    o.int64Value = "foo";
    o.labels = buildUnnamed565();
    o.moneyValue = buildMoney();
    o.startTime = "foo";
    o.stringValue = "foo";
  }
  buildCounterMetricValue--;
  return o;
}

checkMetricValue(api.MetricValue o) {
  buildCounterMetricValue++;
  if (buildCounterMetricValue < 3) {
    unittest.expect(o.boolValue, unittest.isTrue);
    checkDistribution(o.distributionValue);
    unittest.expect(o.doubleValue, unittest.equals(42.0));
    unittest.expect(o.endTime, unittest.equals('foo'));
    unittest.expect(o.int64Value, unittest.equals('foo'));
    checkUnnamed565(o.labels);
    checkMoney(o.moneyValue);
    unittest.expect(o.startTime, unittest.equals('foo'));
    unittest.expect(o.stringValue, unittest.equals('foo'));
  }
  buildCounterMetricValue--;
}

buildUnnamed566() {
  var o = new core.List<api.MetricValue>();
  o.add(buildMetricValue());
  o.add(buildMetricValue());
  return o;
}

checkUnnamed566(core.List<api.MetricValue> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMetricValue(o[0]);
  checkMetricValue(o[1]);
}

core.int buildCounterMetricValueSet = 0;
buildMetricValueSet() {
  var o = new api.MetricValueSet();
  buildCounterMetricValueSet++;
  if (buildCounterMetricValueSet < 3) {
    o.metricName = "foo";
    o.metricValues = buildUnnamed566();
  }
  buildCounterMetricValueSet--;
  return o;
}

checkMetricValueSet(api.MetricValueSet o) {
  buildCounterMetricValueSet++;
  if (buildCounterMetricValueSet < 3) {
    unittest.expect(o.metricName, unittest.equals('foo'));
    checkUnnamed566(o.metricValues);
  }
  buildCounterMetricValueSet--;
}

core.int buildCounterMoney = 0;
buildMoney() {
  var o = new api.Money();
  buildCounterMoney++;
  if (buildCounterMoney < 3) {
    o.currencyCode = "foo";
    o.nanos = 42;
    o.units = "foo";
  }
  buildCounterMoney--;
  return o;
}

checkMoney(api.Money o) {
  buildCounterMoney++;
  if (buildCounterMoney < 3) {
    unittest.expect(o.currencyCode, unittest.equals('foo'));
    unittest.expect(o.nanos, unittest.equals(42));
    unittest.expect(o.units, unittest.equals('foo'));
  }
  buildCounterMoney--;
}

buildUnnamed567() {
  var o = new core.Map<core.String, core.String>();
  o["x"] = "foo";
  o["y"] = "foo";
  return o;
}

checkUnnamed567(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals('foo'));
  unittest.expect(o["y"], unittest.equals('foo'));
}

buildUnnamed568() {
  var o = new core.List<api.LogEntry>();
  o.add(buildLogEntry());
  o.add(buildLogEntry());
  return o;
}

checkUnnamed568(core.List<api.LogEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLogEntry(o[0]);
  checkLogEntry(o[1]);
}

buildUnnamed569() {
  var o = new core.List<api.MetricValueSet>();
  o.add(buildMetricValueSet());
  o.add(buildMetricValueSet());
  return o;
}

checkUnnamed569(core.List<api.MetricValueSet> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMetricValueSet(o[0]);
  checkMetricValueSet(o[1]);
}

buildUnnamed570() {
  var o = new core.List<api.ResourceInfo>();
  o.add(buildResourceInfo());
  o.add(buildResourceInfo());
  return o;
}

checkUnnamed570(core.List<api.ResourceInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkResourceInfo(o[0]);
  checkResourceInfo(o[1]);
}

buildUnnamed571() {
  var o = new core.Map<core.String, core.String>();
  o["x"] = "foo";
  o["y"] = "foo";
  return o;
}

checkUnnamed571(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals('foo'));
  unittest.expect(o["y"], unittest.equals('foo'));
}

core.int buildCounterOperation = 0;
buildOperation() {
  var o = new api.Operation();
  buildCounterOperation++;
  if (buildCounterOperation < 3) {
    o.consumerId = "foo";
    o.endTime = "foo";
    o.importance = "foo";
    o.labels = buildUnnamed567();
    o.logEntries = buildUnnamed568();
    o.metricValueSets = buildUnnamed569();
    o.operationId = "foo";
    o.operationName = "foo";
    o.quotaProperties = buildQuotaProperties();
    o.resourceContainer = "foo";
    o.resources = buildUnnamed570();
    o.startTime = "foo";
    o.userLabels = buildUnnamed571();
  }
  buildCounterOperation--;
  return o;
}

checkOperation(api.Operation o) {
  buildCounterOperation++;
  if (buildCounterOperation < 3) {
    unittest.expect(o.consumerId, unittest.equals('foo'));
    unittest.expect(o.endTime, unittest.equals('foo'));
    unittest.expect(o.importance, unittest.equals('foo'));
    checkUnnamed567(o.labels);
    checkUnnamed568(o.logEntries);
    checkUnnamed569(o.metricValueSets);
    unittest.expect(o.operationId, unittest.equals('foo'));
    unittest.expect(o.operationName, unittest.equals('foo'));
    checkQuotaProperties(o.quotaProperties);
    unittest.expect(o.resourceContainer, unittest.equals('foo'));
    checkUnnamed570(o.resources);
    unittest.expect(o.startTime, unittest.equals('foo'));
    checkUnnamed571(o.userLabels);
  }
  buildCounterOperation--;
}

buildUnnamed572() {
  var o = new core.Map<core.String, core.String>();
  o["x"] = "foo";
  o["y"] = "foo";
  return o;
}

checkUnnamed572(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals('foo'));
  unittest.expect(o["y"], unittest.equals('foo'));
}

core.int buildCounterPeer = 0;
buildPeer() {
  var o = new api.Peer();
  buildCounterPeer++;
  if (buildCounterPeer < 3) {
    o.ip = "foo";
    o.labels = buildUnnamed572();
    o.port = "foo";
    o.principal = "foo";
    o.regionCode = "foo";
    o.service = "foo";
  }
  buildCounterPeer--;
  return o;
}

checkPeer(api.Peer o) {
  buildCounterPeer++;
  if (buildCounterPeer < 3) {
    unittest.expect(o.ip, unittest.equals('foo'));
    checkUnnamed572(o.labels);
    unittest.expect(o.port, unittest.equals('foo'));
    unittest.expect(o.principal, unittest.equals('foo'));
    unittest.expect(o.regionCode, unittest.equals('foo'));
    unittest.expect(o.service, unittest.equals('foo'));
  }
  buildCounterPeer--;
}

core.int buildCounterQuotaError = 0;
buildQuotaError() {
  var o = new api.QuotaError();
  buildCounterQuotaError++;
  if (buildCounterQuotaError < 3) {
    o.code = "foo";
    o.description = "foo";
    o.subject = "foo";
  }
  buildCounterQuotaError--;
  return o;
}

checkQuotaError(api.QuotaError o) {
  buildCounterQuotaError++;
  if (buildCounterQuotaError < 3) {
    unittest.expect(o.code, unittest.equals('foo'));
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.subject, unittest.equals('foo'));
  }
  buildCounterQuotaError--;
}

buildUnnamed573() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed573(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed574() {
  var o = new core.Map<core.String, core.int>();
  o["x"] = 42;
  o["y"] = 42;
  return o;
}

checkUnnamed574(core.Map<core.String, core.int> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals(42));
  unittest.expect(o["y"], unittest.equals(42));
}

buildUnnamed575() {
  var o = new core.List<api.MetricValueSet>();
  o.add(buildMetricValueSet());
  o.add(buildMetricValueSet());
  return o;
}

checkUnnamed575(core.List<api.MetricValueSet> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMetricValueSet(o[0]);
  checkMetricValueSet(o[1]);
}

core.int buildCounterQuotaInfo = 0;
buildQuotaInfo() {
  var o = new api.QuotaInfo();
  buildCounterQuotaInfo++;
  if (buildCounterQuotaInfo < 3) {
    o.limitExceeded = buildUnnamed573();
    o.quotaConsumed = buildUnnamed574();
    o.quotaMetrics = buildUnnamed575();
  }
  buildCounterQuotaInfo--;
  return o;
}

checkQuotaInfo(api.QuotaInfo o) {
  buildCounterQuotaInfo++;
  if (buildCounterQuotaInfo < 3) {
    checkUnnamed573(o.limitExceeded);
    checkUnnamed574(o.quotaConsumed);
    checkUnnamed575(o.quotaMetrics);
  }
  buildCounterQuotaInfo--;
}

buildUnnamed576() {
  var o = new core.Map<core.String, core.String>();
  o["x"] = "foo";
  o["y"] = "foo";
  return o;
}

checkUnnamed576(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals('foo'));
  unittest.expect(o["y"], unittest.equals('foo'));
}

buildUnnamed577() {
  var o = new core.List<api.MetricValueSet>();
  o.add(buildMetricValueSet());
  o.add(buildMetricValueSet());
  return o;
}

checkUnnamed577(core.List<api.MetricValueSet> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMetricValueSet(o[0]);
  checkMetricValueSet(o[1]);
}

core.int buildCounterQuotaOperation = 0;
buildQuotaOperation() {
  var o = new api.QuotaOperation();
  buildCounterQuotaOperation++;
  if (buildCounterQuotaOperation < 3) {
    o.consumerId = "foo";
    o.labels = buildUnnamed576();
    o.methodName = "foo";
    o.operationId = "foo";
    o.quotaMetrics = buildUnnamed577();
    o.quotaMode = "foo";
  }
  buildCounterQuotaOperation--;
  return o;
}

checkQuotaOperation(api.QuotaOperation o) {
  buildCounterQuotaOperation++;
  if (buildCounterQuotaOperation < 3) {
    unittest.expect(o.consumerId, unittest.equals('foo'));
    checkUnnamed576(o.labels);
    unittest.expect(o.methodName, unittest.equals('foo'));
    unittest.expect(o.operationId, unittest.equals('foo'));
    checkUnnamed577(o.quotaMetrics);
    unittest.expect(o.quotaMode, unittest.equals('foo'));
  }
  buildCounterQuotaOperation--;
}

core.int buildCounterQuotaProperties = 0;
buildQuotaProperties() {
  var o = new api.QuotaProperties();
  buildCounterQuotaProperties++;
  if (buildCounterQuotaProperties < 3) {
    o.quotaMode = "foo";
  }
  buildCounterQuotaProperties--;
  return o;
}

checkQuotaProperties(api.QuotaProperties o) {
  buildCounterQuotaProperties++;
  if (buildCounterQuotaProperties < 3) {
    unittest.expect(o.quotaMode, unittest.equals('foo'));
  }
  buildCounterQuotaProperties--;
}

core.int buildCounterReportError = 0;
buildReportError() {
  var o = new api.ReportError();
  buildCounterReportError++;
  if (buildCounterReportError < 3) {
    o.operationId = "foo";
    o.status = buildStatus();
  }
  buildCounterReportError--;
  return o;
}

checkReportError(api.ReportError o) {
  buildCounterReportError++;
  if (buildCounterReportError < 3) {
    unittest.expect(o.operationId, unittest.equals('foo'));
    checkStatus(o.status);
  }
  buildCounterReportError--;
}

core.int buildCounterReportInfo = 0;
buildReportInfo() {
  var o = new api.ReportInfo();
  buildCounterReportInfo++;
  if (buildCounterReportInfo < 3) {
    o.operationId = "foo";
    o.quotaInfo = buildQuotaInfo();
  }
  buildCounterReportInfo--;
  return o;
}

checkReportInfo(api.ReportInfo o) {
  buildCounterReportInfo++;
  if (buildCounterReportInfo < 3) {
    unittest.expect(o.operationId, unittest.equals('foo'));
    checkQuotaInfo(o.quotaInfo);
  }
  buildCounterReportInfo--;
}

buildUnnamed578() {
  var o = new core.List<api.Operation>();
  o.add(buildOperation());
  o.add(buildOperation());
  return o;
}

checkUnnamed578(core.List<api.Operation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOperation(o[0]);
  checkOperation(o[1]);
}

core.int buildCounterReportRequest = 0;
buildReportRequest() {
  var o = new api.ReportRequest();
  buildCounterReportRequest++;
  if (buildCounterReportRequest < 3) {
    o.operations = buildUnnamed578();
    o.serviceConfigId = "foo";
  }
  buildCounterReportRequest--;
  return o;
}

checkReportRequest(api.ReportRequest o) {
  buildCounterReportRequest++;
  if (buildCounterReportRequest < 3) {
    checkUnnamed578(o.operations);
    unittest.expect(o.serviceConfigId, unittest.equals('foo'));
  }
  buildCounterReportRequest--;
}

buildUnnamed579() {
  var o = new core.List<api.ReportError>();
  o.add(buildReportError());
  o.add(buildReportError());
  return o;
}

checkUnnamed579(core.List<api.ReportError> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkReportError(o[0]);
  checkReportError(o[1]);
}

buildUnnamed580() {
  var o = new core.List<api.ReportInfo>();
  o.add(buildReportInfo());
  o.add(buildReportInfo());
  return o;
}

checkUnnamed580(core.List<api.ReportInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkReportInfo(o[0]);
  checkReportInfo(o[1]);
}

core.int buildCounterReportResponse = 0;
buildReportResponse() {
  var o = new api.ReportResponse();
  buildCounterReportResponse++;
  if (buildCounterReportResponse < 3) {
    o.reportErrors = buildUnnamed579();
    o.reportInfos = buildUnnamed580();
    o.serviceConfigId = "foo";
  }
  buildCounterReportResponse--;
  return o;
}

checkReportResponse(api.ReportResponse o) {
  buildCounterReportResponse++;
  if (buildCounterReportResponse < 3) {
    checkUnnamed579(o.reportErrors);
    checkUnnamed580(o.reportInfos);
    unittest.expect(o.serviceConfigId, unittest.equals('foo'));
  }
  buildCounterReportResponse--;
}

buildUnnamed581() {
  var o = new core.Map<core.String, core.String>();
  o["x"] = "foo";
  o["y"] = "foo";
  return o;
}

checkUnnamed581(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals('foo'));
  unittest.expect(o["y"], unittest.equals('foo'));
}

core.int buildCounterRequest = 0;
buildRequest() {
  var o = new api.Request();
  buildCounterRequest++;
  if (buildCounterRequest < 3) {
    o.auth = buildAuth();
    o.fragment = "foo";
    o.headers = buildUnnamed581();
    o.host = "foo";
    o.id = "foo";
    o.method = "foo";
    o.path = "foo";
    o.protocol = "foo";
    o.query = "foo";
    o.reason = "foo";
    o.scheme = "foo";
    o.size = "foo";
    o.time = "foo";
  }
  buildCounterRequest--;
  return o;
}

checkRequest(api.Request o) {
  buildCounterRequest++;
  if (buildCounterRequest < 3) {
    checkAuth(o.auth);
    unittest.expect(o.fragment, unittest.equals('foo'));
    checkUnnamed581(o.headers);
    unittest.expect(o.host, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.method, unittest.equals('foo'));
    unittest.expect(o.path, unittest.equals('foo'));
    unittest.expect(o.protocol, unittest.equals('foo'));
    unittest.expect(o.query, unittest.equals('foo'));
    unittest.expect(o.reason, unittest.equals('foo'));
    unittest.expect(o.scheme, unittest.equals('foo'));
    unittest.expect(o.size, unittest.equals('foo'));
    unittest.expect(o.time, unittest.equals('foo'));
  }
  buildCounterRequest--;
}

core.int buildCounterRequestMetadata = 0;
buildRequestMetadata() {
  var o = new api.RequestMetadata();
  buildCounterRequestMetadata++;
  if (buildCounterRequestMetadata < 3) {
    o.callerIp = "foo";
    o.callerNetwork = "foo";
    o.callerSuppliedUserAgent = "foo";
    o.destinationAttributes = buildPeer();
    o.requestAttributes = buildRequest();
  }
  buildCounterRequestMetadata--;
  return o;
}

checkRequestMetadata(api.RequestMetadata o) {
  buildCounterRequestMetadata++;
  if (buildCounterRequestMetadata < 3) {
    unittest.expect(o.callerIp, unittest.equals('foo'));
    unittest.expect(o.callerNetwork, unittest.equals('foo'));
    unittest.expect(o.callerSuppliedUserAgent, unittest.equals('foo'));
    checkPeer(o.destinationAttributes);
    checkRequest(o.requestAttributes);
  }
  buildCounterRequestMetadata--;
}

buildUnnamed582() {
  var o = new core.Map<core.String, core.String>();
  o["x"] = "foo";
  o["y"] = "foo";
  return o;
}

checkUnnamed582(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals('foo'));
  unittest.expect(o["y"], unittest.equals('foo'));
}

core.int buildCounterResource = 0;
buildResource() {
  var o = new api.Resource();
  buildCounterResource++;
  if (buildCounterResource < 3) {
    o.labels = buildUnnamed582();
    o.name = "foo";
    o.service = "foo";
    o.type = "foo";
  }
  buildCounterResource--;
  return o;
}

checkResource(api.Resource o) {
  buildCounterResource++;
  if (buildCounterResource < 3) {
    checkUnnamed582(o.labels);
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.service, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterResource--;
}

core.int buildCounterResourceInfo = 0;
buildResourceInfo() {
  var o = new api.ResourceInfo();
  buildCounterResourceInfo++;
  if (buildCounterResourceInfo < 3) {
    o.resourceContainer = "foo";
    o.resourceLocation = "foo";
    o.resourceName = "foo";
  }
  buildCounterResourceInfo--;
  return o;
}

checkResourceInfo(api.ResourceInfo o) {
  buildCounterResourceInfo++;
  if (buildCounterResourceInfo < 3) {
    unittest.expect(o.resourceContainer, unittest.equals('foo'));
    unittest.expect(o.resourceLocation, unittest.equals('foo'));
    unittest.expect(o.resourceName, unittest.equals('foo'));
  }
  buildCounterResourceInfo--;
}

buildUnnamed583() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed583(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed584() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed584(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterResourceLocation = 0;
buildResourceLocation() {
  var o = new api.ResourceLocation();
  buildCounterResourceLocation++;
  if (buildCounterResourceLocation < 3) {
    o.currentLocations = buildUnnamed583();
    o.originalLocations = buildUnnamed584();
  }
  buildCounterResourceLocation--;
  return o;
}

checkResourceLocation(api.ResourceLocation o) {
  buildCounterResourceLocation++;
  if (buildCounterResourceLocation < 3) {
    checkUnnamed583(o.currentLocations);
    checkUnnamed584(o.originalLocations);
  }
  buildCounterResourceLocation--;
}

buildUnnamed585() {
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

checkUnnamed585(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted19 = (o["x"]) as core.Map;
  unittest.expect(casted19, unittest.hasLength(3));
  unittest.expect(casted19["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted19["bool"], unittest.equals(true));
  unittest.expect(casted19["string"], unittest.equals('foo'));
  var casted20 = (o["y"]) as core.Map;
  unittest.expect(casted20, unittest.hasLength(3));
  unittest.expect(casted20["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted20["bool"], unittest.equals(true));
  unittest.expect(casted20["string"], unittest.equals('foo'));
}

buildUnnamed586() {
  var o = new core.List<core.Map<core.String, core.Object>>();
  o.add(buildUnnamed585());
  o.add(buildUnnamed585());
  return o;
}

checkUnnamed586(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed585(o[0]);
  checkUnnamed585(o[1]);
}

core.int buildCounterStatus = 0;
buildStatus() {
  var o = new api.Status();
  buildCounterStatus++;
  if (buildCounterStatus < 3) {
    o.code = 42;
    o.details = buildUnnamed586();
    o.message = "foo";
  }
  buildCounterStatus--;
  return o;
}

checkStatus(api.Status o) {
  buildCounterStatus++;
  if (buildCounterStatus < 3) {
    unittest.expect(o.code, unittest.equals(42));
    checkUnnamed586(o.details);
    unittest.expect(o.message, unittest.equals('foo'));
  }
  buildCounterStatus--;
}

main() {
  unittest.group("obj-schema-AllocateInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildAllocateInfo();
      var od = new api.AllocateInfo.fromJson(o.toJson());
      checkAllocateInfo(od);
    });
  });

  unittest.group("obj-schema-AllocateQuotaRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildAllocateQuotaRequest();
      var od = new api.AllocateQuotaRequest.fromJson(o.toJson());
      checkAllocateQuotaRequest(od);
    });
  });

  unittest.group("obj-schema-AllocateQuotaResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAllocateQuotaResponse();
      var od = new api.AllocateQuotaResponse.fromJson(o.toJson());
      checkAllocateQuotaResponse(od);
    });
  });

  unittest.group("obj-schema-AuditLog", () {
    unittest.test("to-json--from-json", () {
      var o = buildAuditLog();
      var od = new api.AuditLog.fromJson(o.toJson());
      checkAuditLog(od);
    });
  });

  unittest.group("obj-schema-Auth", () {
    unittest.test("to-json--from-json", () {
      var o = buildAuth();
      var od = new api.Auth.fromJson(o.toJson());
      checkAuth(od);
    });
  });

  unittest.group("obj-schema-AuthenticationInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildAuthenticationInfo();
      var od = new api.AuthenticationInfo.fromJson(o.toJson());
      checkAuthenticationInfo(od);
    });
  });

  unittest.group("obj-schema-AuthorizationInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildAuthorizationInfo();
      var od = new api.AuthorizationInfo.fromJson(o.toJson());
      checkAuthorizationInfo(od);
    });
  });

  unittest.group("obj-schema-CheckError", () {
    unittest.test("to-json--from-json", () {
      var o = buildCheckError();
      var od = new api.CheckError.fromJson(o.toJson());
      checkCheckError(od);
    });
  });

  unittest.group("obj-schema-CheckInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildCheckInfo();
      var od = new api.CheckInfo.fromJson(o.toJson());
      checkCheckInfo(od);
    });
  });

  unittest.group("obj-schema-CheckRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildCheckRequest();
      var od = new api.CheckRequest.fromJson(o.toJson());
      checkCheckRequest(od);
    });
  });

  unittest.group("obj-schema-CheckResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildCheckResponse();
      var od = new api.CheckResponse.fromJson(o.toJson());
      checkCheckResponse(od);
    });
  });

  unittest.group("obj-schema-ConsumerInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildConsumerInfo();
      var od = new api.ConsumerInfo.fromJson(o.toJson());
      checkConsumerInfo(od);
    });
  });

  unittest.group("obj-schema-Distribution", () {
    unittest.test("to-json--from-json", () {
      var o = buildDistribution();
      var od = new api.Distribution.fromJson(o.toJson());
      checkDistribution(od);
    });
  });

  unittest.group("obj-schema-ExplicitBuckets", () {
    unittest.test("to-json--from-json", () {
      var o = buildExplicitBuckets();
      var od = new api.ExplicitBuckets.fromJson(o.toJson());
      checkExplicitBuckets(od);
    });
  });

  unittest.group("obj-schema-ExponentialBuckets", () {
    unittest.test("to-json--from-json", () {
      var o = buildExponentialBuckets();
      var od = new api.ExponentialBuckets.fromJson(o.toJson());
      checkExponentialBuckets(od);
    });
  });

  unittest.group("obj-schema-HttpRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildHttpRequest();
      var od = new api.HttpRequest.fromJson(o.toJson());
      checkHttpRequest(od);
    });
  });

  unittest.group("obj-schema-LinearBuckets", () {
    unittest.test("to-json--from-json", () {
      var o = buildLinearBuckets();
      var od = new api.LinearBuckets.fromJson(o.toJson());
      checkLinearBuckets(od);
    });
  });

  unittest.group("obj-schema-LogEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildLogEntry();
      var od = new api.LogEntry.fromJson(o.toJson());
      checkLogEntry(od);
    });
  });

  unittest.group("obj-schema-LogEntryOperation", () {
    unittest.test("to-json--from-json", () {
      var o = buildLogEntryOperation();
      var od = new api.LogEntryOperation.fromJson(o.toJson());
      checkLogEntryOperation(od);
    });
  });

  unittest.group("obj-schema-MetricValue", () {
    unittest.test("to-json--from-json", () {
      var o = buildMetricValue();
      var od = new api.MetricValue.fromJson(o.toJson());
      checkMetricValue(od);
    });
  });

  unittest.group("obj-schema-MetricValueSet", () {
    unittest.test("to-json--from-json", () {
      var o = buildMetricValueSet();
      var od = new api.MetricValueSet.fromJson(o.toJson());
      checkMetricValueSet(od);
    });
  });

  unittest.group("obj-schema-Money", () {
    unittest.test("to-json--from-json", () {
      var o = buildMoney();
      var od = new api.Money.fromJson(o.toJson());
      checkMoney(od);
    });
  });

  unittest.group("obj-schema-Operation", () {
    unittest.test("to-json--from-json", () {
      var o = buildOperation();
      var od = new api.Operation.fromJson(o.toJson());
      checkOperation(od);
    });
  });

  unittest.group("obj-schema-Peer", () {
    unittest.test("to-json--from-json", () {
      var o = buildPeer();
      var od = new api.Peer.fromJson(o.toJson());
      checkPeer(od);
    });
  });

  unittest.group("obj-schema-QuotaError", () {
    unittest.test("to-json--from-json", () {
      var o = buildQuotaError();
      var od = new api.QuotaError.fromJson(o.toJson());
      checkQuotaError(od);
    });
  });

  unittest.group("obj-schema-QuotaInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildQuotaInfo();
      var od = new api.QuotaInfo.fromJson(o.toJson());
      checkQuotaInfo(od);
    });
  });

  unittest.group("obj-schema-QuotaOperation", () {
    unittest.test("to-json--from-json", () {
      var o = buildQuotaOperation();
      var od = new api.QuotaOperation.fromJson(o.toJson());
      checkQuotaOperation(od);
    });
  });

  unittest.group("obj-schema-QuotaProperties", () {
    unittest.test("to-json--from-json", () {
      var o = buildQuotaProperties();
      var od = new api.QuotaProperties.fromJson(o.toJson());
      checkQuotaProperties(od);
    });
  });

  unittest.group("obj-schema-ReportError", () {
    unittest.test("to-json--from-json", () {
      var o = buildReportError();
      var od = new api.ReportError.fromJson(o.toJson());
      checkReportError(od);
    });
  });

  unittest.group("obj-schema-ReportInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildReportInfo();
      var od = new api.ReportInfo.fromJson(o.toJson());
      checkReportInfo(od);
    });
  });

  unittest.group("obj-schema-ReportRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildReportRequest();
      var od = new api.ReportRequest.fromJson(o.toJson());
      checkReportRequest(od);
    });
  });

  unittest.group("obj-schema-ReportResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildReportResponse();
      var od = new api.ReportResponse.fromJson(o.toJson());
      checkReportResponse(od);
    });
  });

  unittest.group("obj-schema-Request", () {
    unittest.test("to-json--from-json", () {
      var o = buildRequest();
      var od = new api.Request.fromJson(o.toJson());
      checkRequest(od);
    });
  });

  unittest.group("obj-schema-RequestMetadata", () {
    unittest.test("to-json--from-json", () {
      var o = buildRequestMetadata();
      var od = new api.RequestMetadata.fromJson(o.toJson());
      checkRequestMetadata(od);
    });
  });

  unittest.group("obj-schema-Resource", () {
    unittest.test("to-json--from-json", () {
      var o = buildResource();
      var od = new api.Resource.fromJson(o.toJson());
      checkResource(od);
    });
  });

  unittest.group("obj-schema-ResourceInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildResourceInfo();
      var od = new api.ResourceInfo.fromJson(o.toJson());
      checkResourceInfo(od);
    });
  });

  unittest.group("obj-schema-ResourceLocation", () {
    unittest.test("to-json--from-json", () {
      var o = buildResourceLocation();
      var od = new api.ResourceLocation.fromJson(o.toJson());
      checkResourceLocation(od);
    });
  });

  unittest.group("obj-schema-Status", () {
    unittest.test("to-json--from-json", () {
      var o = buildStatus();
      var od = new api.Status.fromJson(o.toJson());
      checkStatus(od);
    });
  });

  unittest.group("resource-ServicesResourceApi", () {
    unittest.test("method--allocateQuota", () {
      var mock = new HttpServerMock();
      api.ServicesResourceApi res = new api.ServicecontrolApi(mock).services;
      var arg_request = buildAllocateQuotaRequest();
      var arg_serviceName = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.AllocateQuotaRequest.fromJson(json);
        checkAllocateQuotaRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("v1/services/"));
        pathOffset += 12;
        index = path.indexOf(":allocateQuota", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_serviceName"));
        unittest.expect(path.substring(pathOffset, pathOffset + 14),
            unittest.equals(":allocateQuota"));
        pathOffset += 14;

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
        var resp = convert.json.encode(buildAllocateQuotaResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .allocateQuota(arg_request, arg_serviceName, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAllocateQuotaResponse(response);
      })));
    });

    unittest.test("method--check", () {
      var mock = new HttpServerMock();
      api.ServicesResourceApi res = new api.ServicecontrolApi(mock).services;
      var arg_request = buildCheckRequest();
      var arg_serviceName = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.CheckRequest.fromJson(json);
        checkCheckRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("v1/services/"));
        pathOffset += 12;
        index = path.indexOf(":check", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_serviceName"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6),
            unittest.equals(":check"));
        pathOffset += 6;

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
        var resp = convert.json.encode(buildCheckResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .check(arg_request, arg_serviceName, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkCheckResponse(response);
      })));
    });

    unittest.test("method--report", () {
      var mock = new HttpServerMock();
      api.ServicesResourceApi res = new api.ServicecontrolApi(mock).services;
      var arg_request = buildReportRequest();
      var arg_serviceName = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.ReportRequest.fromJson(json);
        checkReportRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("v1/services/"));
        pathOffset += 12;
        index = path.indexOf(":report", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_serviceName"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7),
            unittest.equals(":report"));
        pathOffset += 7;

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
        var resp = convert.json.encode(buildReportResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .report(arg_request, arg_serviceName, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkReportResponse(response);
      })));
    });
  });
}
