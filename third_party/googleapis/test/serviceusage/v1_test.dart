library googleapis.serviceusage.v1.test;

import "dart:core" as core;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:test/test.dart' as unittest;

import 'package:googleapis/serviceusage/v1.dart' as api;

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

buildUnnamed0() {
  var o = new core.List<api.Method>();
  o.add(buildMethod());
  o.add(buildMethod());
  return o;
}

checkUnnamed0(core.List<api.Method> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMethod(o[0]);
  checkMethod(o[1]);
}

buildUnnamed1() {
  var o = new core.List<api.Mixin>();
  o.add(buildMixin());
  o.add(buildMixin());
  return o;
}

checkUnnamed1(core.List<api.Mixin> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMixin(o[0]);
  checkMixin(o[1]);
}

buildUnnamed2() {
  var o = new core.List<api.Option>();
  o.add(buildOption());
  o.add(buildOption());
  return o;
}

checkUnnamed2(core.List<api.Option> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOption(o[0]);
  checkOption(o[1]);
}

core.int buildCounterApi = 0;
buildApi() {
  var o = new api.Api();
  buildCounterApi++;
  if (buildCounterApi < 3) {
    o.methods = buildUnnamed0();
    o.mixins = buildUnnamed1();
    o.name = "foo";
    o.options = buildUnnamed2();
    o.sourceContext = buildSourceContext();
    o.syntax = "foo";
    o.version = "foo";
  }
  buildCounterApi--;
  return o;
}

checkApi(api.Api o) {
  buildCounterApi++;
  if (buildCounterApi < 3) {
    checkUnnamed0(o.methods);
    checkUnnamed1(o.mixins);
    unittest.expect(o.name, unittest.equals('foo'));
    checkUnnamed2(o.options);
    checkSourceContext(o.sourceContext);
    unittest.expect(o.syntax, unittest.equals('foo'));
    unittest.expect(o.version, unittest.equals('foo'));
  }
  buildCounterApi--;
}

core.int buildCounterAuthProvider = 0;
buildAuthProvider() {
  var o = new api.AuthProvider();
  buildCounterAuthProvider++;
  if (buildCounterAuthProvider < 3) {
    o.audiences = "foo";
    o.authorizationUrl = "foo";
    o.id = "foo";
    o.issuer = "foo";
    o.jwksUri = "foo";
  }
  buildCounterAuthProvider--;
  return o;
}

checkAuthProvider(api.AuthProvider o) {
  buildCounterAuthProvider++;
  if (buildCounterAuthProvider < 3) {
    unittest.expect(o.audiences, unittest.equals('foo'));
    unittest.expect(o.authorizationUrl, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.issuer, unittest.equals('foo'));
    unittest.expect(o.jwksUri, unittest.equals('foo'));
  }
  buildCounterAuthProvider--;
}

core.int buildCounterAuthRequirement = 0;
buildAuthRequirement() {
  var o = new api.AuthRequirement();
  buildCounterAuthRequirement++;
  if (buildCounterAuthRequirement < 3) {
    o.audiences = "foo";
    o.providerId = "foo";
  }
  buildCounterAuthRequirement--;
  return o;
}

checkAuthRequirement(api.AuthRequirement o) {
  buildCounterAuthRequirement++;
  if (buildCounterAuthRequirement < 3) {
    unittest.expect(o.audiences, unittest.equals('foo'));
    unittest.expect(o.providerId, unittest.equals('foo'));
  }
  buildCounterAuthRequirement--;
}

buildUnnamed3() {
  var o = new core.List<api.AuthProvider>();
  o.add(buildAuthProvider());
  o.add(buildAuthProvider());
  return o;
}

checkUnnamed3(core.List<api.AuthProvider> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAuthProvider(o[0]);
  checkAuthProvider(o[1]);
}

buildUnnamed4() {
  var o = new core.List<api.AuthenticationRule>();
  o.add(buildAuthenticationRule());
  o.add(buildAuthenticationRule());
  return o;
}

checkUnnamed4(core.List<api.AuthenticationRule> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAuthenticationRule(o[0]);
  checkAuthenticationRule(o[1]);
}

core.int buildCounterAuthentication = 0;
buildAuthentication() {
  var o = new api.Authentication();
  buildCounterAuthentication++;
  if (buildCounterAuthentication < 3) {
    o.providers = buildUnnamed3();
    o.rules = buildUnnamed4();
  }
  buildCounterAuthentication--;
  return o;
}

checkAuthentication(api.Authentication o) {
  buildCounterAuthentication++;
  if (buildCounterAuthentication < 3) {
    checkUnnamed3(o.providers);
    checkUnnamed4(o.rules);
  }
  buildCounterAuthentication--;
}

buildUnnamed5() {
  var o = new core.List<api.AuthRequirement>();
  o.add(buildAuthRequirement());
  o.add(buildAuthRequirement());
  return o;
}

checkUnnamed5(core.List<api.AuthRequirement> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAuthRequirement(o[0]);
  checkAuthRequirement(o[1]);
}

core.int buildCounterAuthenticationRule = 0;
buildAuthenticationRule() {
  var o = new api.AuthenticationRule();
  buildCounterAuthenticationRule++;
  if (buildCounterAuthenticationRule < 3) {
    o.allowWithoutCredential = true;
    o.oauth = buildOAuthRequirements();
    o.requirements = buildUnnamed5();
    o.selector = "foo";
  }
  buildCounterAuthenticationRule--;
  return o;
}

checkAuthenticationRule(api.AuthenticationRule o) {
  buildCounterAuthenticationRule++;
  if (buildCounterAuthenticationRule < 3) {
    unittest.expect(o.allowWithoutCredential, unittest.isTrue);
    checkOAuthRequirements(o.oauth);
    checkUnnamed5(o.requirements);
    unittest.expect(o.selector, unittest.equals('foo'));
  }
  buildCounterAuthenticationRule--;
}

core.int buildCounterAuthorizationConfig = 0;
buildAuthorizationConfig() {
  var o = new api.AuthorizationConfig();
  buildCounterAuthorizationConfig++;
  if (buildCounterAuthorizationConfig < 3) {
    o.provider = "foo";
  }
  buildCounterAuthorizationConfig--;
  return o;
}

checkAuthorizationConfig(api.AuthorizationConfig o) {
  buildCounterAuthorizationConfig++;
  if (buildCounterAuthorizationConfig < 3) {
    unittest.expect(o.provider, unittest.equals('foo'));
  }
  buildCounterAuthorizationConfig--;
}

buildUnnamed6() {
  var o = new core.List<api.BackendRule>();
  o.add(buildBackendRule());
  o.add(buildBackendRule());
  return o;
}

checkUnnamed6(core.List<api.BackendRule> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBackendRule(o[0]);
  checkBackendRule(o[1]);
}

core.int buildCounterBackend = 0;
buildBackend() {
  var o = new api.Backend();
  buildCounterBackend++;
  if (buildCounterBackend < 3) {
    o.rules = buildUnnamed6();
  }
  buildCounterBackend--;
  return o;
}

checkBackend(api.Backend o) {
  buildCounterBackend++;
  if (buildCounterBackend < 3) {
    checkUnnamed6(o.rules);
  }
  buildCounterBackend--;
}

core.int buildCounterBackendRule = 0;
buildBackendRule() {
  var o = new api.BackendRule();
  buildCounterBackendRule++;
  if (buildCounterBackendRule < 3) {
    o.address = "foo";
    o.deadline = 42.0;
    o.jwtAudience = "foo";
    o.minDeadline = 42.0;
    o.operationDeadline = 42.0;
    o.pathTranslation = "foo";
    o.selector = "foo";
  }
  buildCounterBackendRule--;
  return o;
}

checkBackendRule(api.BackendRule o) {
  buildCounterBackendRule++;
  if (buildCounterBackendRule < 3) {
    unittest.expect(o.address, unittest.equals('foo'));
    unittest.expect(o.deadline, unittest.equals(42.0));
    unittest.expect(o.jwtAudience, unittest.equals('foo'));
    unittest.expect(o.minDeadline, unittest.equals(42.0));
    unittest.expect(o.operationDeadline, unittest.equals(42.0));
    unittest.expect(o.pathTranslation, unittest.equals('foo'));
    unittest.expect(o.selector, unittest.equals('foo'));
  }
  buildCounterBackendRule--;
}

buildUnnamed7() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed7(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterBatchEnableServicesRequest = 0;
buildBatchEnableServicesRequest() {
  var o = new api.BatchEnableServicesRequest();
  buildCounterBatchEnableServicesRequest++;
  if (buildCounterBatchEnableServicesRequest < 3) {
    o.serviceIds = buildUnnamed7();
  }
  buildCounterBatchEnableServicesRequest--;
  return o;
}

checkBatchEnableServicesRequest(api.BatchEnableServicesRequest o) {
  buildCounterBatchEnableServicesRequest++;
  if (buildCounterBatchEnableServicesRequest < 3) {
    checkUnnamed7(o.serviceIds);
  }
  buildCounterBatchEnableServicesRequest--;
}

buildUnnamed8() {
  var o = new core.List<api.EnableFailure>();
  o.add(buildEnableFailure());
  o.add(buildEnableFailure());
  return o;
}

checkUnnamed8(core.List<api.EnableFailure> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEnableFailure(o[0]);
  checkEnableFailure(o[1]);
}

buildUnnamed9() {
  var o = new core.List<api.GoogleApiServiceusageV1Service>();
  o.add(buildGoogleApiServiceusageV1Service());
  o.add(buildGoogleApiServiceusageV1Service());
  return o;
}

checkUnnamed9(core.List<api.GoogleApiServiceusageV1Service> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleApiServiceusageV1Service(o[0]);
  checkGoogleApiServiceusageV1Service(o[1]);
}

core.int buildCounterBatchEnableServicesResponse = 0;
buildBatchEnableServicesResponse() {
  var o = new api.BatchEnableServicesResponse();
  buildCounterBatchEnableServicesResponse++;
  if (buildCounterBatchEnableServicesResponse < 3) {
    o.failures = buildUnnamed8();
    o.services = buildUnnamed9();
  }
  buildCounterBatchEnableServicesResponse--;
  return o;
}

checkBatchEnableServicesResponse(api.BatchEnableServicesResponse o) {
  buildCounterBatchEnableServicesResponse++;
  if (buildCounterBatchEnableServicesResponse < 3) {
    checkUnnamed8(o.failures);
    checkUnnamed9(o.services);
  }
  buildCounterBatchEnableServicesResponse--;
}

buildUnnamed10() {
  var o = new core.List<api.BillingDestination>();
  o.add(buildBillingDestination());
  o.add(buildBillingDestination());
  return o;
}

checkUnnamed10(core.List<api.BillingDestination> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBillingDestination(o[0]);
  checkBillingDestination(o[1]);
}

core.int buildCounterBilling = 0;
buildBilling() {
  var o = new api.Billing();
  buildCounterBilling++;
  if (buildCounterBilling < 3) {
    o.consumerDestinations = buildUnnamed10();
  }
  buildCounterBilling--;
  return o;
}

checkBilling(api.Billing o) {
  buildCounterBilling++;
  if (buildCounterBilling < 3) {
    checkUnnamed10(o.consumerDestinations);
  }
  buildCounterBilling--;
}

buildUnnamed11() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed11(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterBillingDestination = 0;
buildBillingDestination() {
  var o = new api.BillingDestination();
  buildCounterBillingDestination++;
  if (buildCounterBillingDestination < 3) {
    o.metrics = buildUnnamed11();
    o.monitoredResource = "foo";
  }
  buildCounterBillingDestination--;
  return o;
}

checkBillingDestination(api.BillingDestination o) {
  buildCounterBillingDestination++;
  if (buildCounterBillingDestination < 3) {
    checkUnnamed11(o.metrics);
    unittest.expect(o.monitoredResource, unittest.equals('foo'));
  }
  buildCounterBillingDestination--;
}

core.int buildCounterCancelOperationRequest = 0;
buildCancelOperationRequest() {
  var o = new api.CancelOperationRequest();
  buildCounterCancelOperationRequest++;
  if (buildCounterCancelOperationRequest < 3) {}
  buildCounterCancelOperationRequest--;
  return o;
}

checkCancelOperationRequest(api.CancelOperationRequest o) {
  buildCounterCancelOperationRequest++;
  if (buildCounterCancelOperationRequest < 3) {}
  buildCounterCancelOperationRequest--;
}

buildUnnamed12() {
  var o = new core.List<api.ContextRule>();
  o.add(buildContextRule());
  o.add(buildContextRule());
  return o;
}

checkUnnamed12(core.List<api.ContextRule> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkContextRule(o[0]);
  checkContextRule(o[1]);
}

core.int buildCounterContext = 0;
buildContext() {
  var o = new api.Context();
  buildCounterContext++;
  if (buildCounterContext < 3) {
    o.rules = buildUnnamed12();
  }
  buildCounterContext--;
  return o;
}

checkContext(api.Context o) {
  buildCounterContext++;
  if (buildCounterContext < 3) {
    checkUnnamed12(o.rules);
  }
  buildCounterContext--;
}

buildUnnamed13() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed13(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed14() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed14(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed15() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed15(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed16() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed16(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterContextRule = 0;
buildContextRule() {
  var o = new api.ContextRule();
  buildCounterContextRule++;
  if (buildCounterContextRule < 3) {
    o.allowedRequestExtensions = buildUnnamed13();
    o.allowedResponseExtensions = buildUnnamed14();
    o.provided = buildUnnamed15();
    o.requested = buildUnnamed16();
    o.selector = "foo";
  }
  buildCounterContextRule--;
  return o;
}

checkContextRule(api.ContextRule o) {
  buildCounterContextRule++;
  if (buildCounterContextRule < 3) {
    checkUnnamed13(o.allowedRequestExtensions);
    checkUnnamed14(o.allowedResponseExtensions);
    checkUnnamed15(o.provided);
    checkUnnamed16(o.requested);
    unittest.expect(o.selector, unittest.equals('foo'));
  }
  buildCounterContextRule--;
}

core.int buildCounterControl = 0;
buildControl() {
  var o = new api.Control();
  buildCounterControl++;
  if (buildCounterControl < 3) {
    o.environment = "foo";
  }
  buildCounterControl--;
  return o;
}

checkControl(api.Control o) {
  buildCounterControl++;
  if (buildCounterControl < 3) {
    unittest.expect(o.environment, unittest.equals('foo'));
  }
  buildCounterControl--;
}

buildUnnamed17() {
  var o = new core.List<api.CustomErrorRule>();
  o.add(buildCustomErrorRule());
  o.add(buildCustomErrorRule());
  return o;
}

checkUnnamed17(core.List<api.CustomErrorRule> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCustomErrorRule(o[0]);
  checkCustomErrorRule(o[1]);
}

buildUnnamed18() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed18(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterCustomError = 0;
buildCustomError() {
  var o = new api.CustomError();
  buildCounterCustomError++;
  if (buildCounterCustomError < 3) {
    o.rules = buildUnnamed17();
    o.types = buildUnnamed18();
  }
  buildCounterCustomError--;
  return o;
}

checkCustomError(api.CustomError o) {
  buildCounterCustomError++;
  if (buildCounterCustomError < 3) {
    checkUnnamed17(o.rules);
    checkUnnamed18(o.types);
  }
  buildCounterCustomError--;
}

core.int buildCounterCustomErrorRule = 0;
buildCustomErrorRule() {
  var o = new api.CustomErrorRule();
  buildCounterCustomErrorRule++;
  if (buildCounterCustomErrorRule < 3) {
    o.isErrorType = true;
    o.selector = "foo";
  }
  buildCounterCustomErrorRule--;
  return o;
}

checkCustomErrorRule(api.CustomErrorRule o) {
  buildCounterCustomErrorRule++;
  if (buildCounterCustomErrorRule < 3) {
    unittest.expect(o.isErrorType, unittest.isTrue);
    unittest.expect(o.selector, unittest.equals('foo'));
  }
  buildCounterCustomErrorRule--;
}

core.int buildCounterCustomHttpPattern = 0;
buildCustomHttpPattern() {
  var o = new api.CustomHttpPattern();
  buildCounterCustomHttpPattern++;
  if (buildCounterCustomHttpPattern < 3) {
    o.kind = "foo";
    o.path = "foo";
  }
  buildCounterCustomHttpPattern--;
  return o;
}

checkCustomHttpPattern(api.CustomHttpPattern o) {
  buildCounterCustomHttpPattern++;
  if (buildCounterCustomHttpPattern < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.path, unittest.equals('foo'));
  }
  buildCounterCustomHttpPattern--;
}

core.int buildCounterDisableServiceRequest = 0;
buildDisableServiceRequest() {
  var o = new api.DisableServiceRequest();
  buildCounterDisableServiceRequest++;
  if (buildCounterDisableServiceRequest < 3) {
    o.disableDependentServices = true;
  }
  buildCounterDisableServiceRequest--;
  return o;
}

checkDisableServiceRequest(api.DisableServiceRequest o) {
  buildCounterDisableServiceRequest++;
  if (buildCounterDisableServiceRequest < 3) {
    unittest.expect(o.disableDependentServices, unittest.isTrue);
  }
  buildCounterDisableServiceRequest--;
}

core.int buildCounterDisableServiceResponse = 0;
buildDisableServiceResponse() {
  var o = new api.DisableServiceResponse();
  buildCounterDisableServiceResponse++;
  if (buildCounterDisableServiceResponse < 3) {
    o.service = buildGoogleApiServiceusageV1Service();
  }
  buildCounterDisableServiceResponse--;
  return o;
}

checkDisableServiceResponse(api.DisableServiceResponse o) {
  buildCounterDisableServiceResponse++;
  if (buildCounterDisableServiceResponse < 3) {
    checkGoogleApiServiceusageV1Service(o.service);
  }
  buildCounterDisableServiceResponse--;
}

buildUnnamed19() {
  var o = new core.List<api.Page>();
  o.add(buildPage());
  o.add(buildPage());
  return o;
}

checkUnnamed19(core.List<api.Page> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPage(o[0]);
  checkPage(o[1]);
}

buildUnnamed20() {
  var o = new core.List<api.DocumentationRule>();
  o.add(buildDocumentationRule());
  o.add(buildDocumentationRule());
  return o;
}

checkUnnamed20(core.List<api.DocumentationRule> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDocumentationRule(o[0]);
  checkDocumentationRule(o[1]);
}

core.int buildCounterDocumentation = 0;
buildDocumentation() {
  var o = new api.Documentation();
  buildCounterDocumentation++;
  if (buildCounterDocumentation < 3) {
    o.documentationRootUrl = "foo";
    o.overview = "foo";
    o.pages = buildUnnamed19();
    o.rules = buildUnnamed20();
    o.summary = "foo";
  }
  buildCounterDocumentation--;
  return o;
}

checkDocumentation(api.Documentation o) {
  buildCounterDocumentation++;
  if (buildCounterDocumentation < 3) {
    unittest.expect(o.documentationRootUrl, unittest.equals('foo'));
    unittest.expect(o.overview, unittest.equals('foo'));
    checkUnnamed19(o.pages);
    checkUnnamed20(o.rules);
    unittest.expect(o.summary, unittest.equals('foo'));
  }
  buildCounterDocumentation--;
}

core.int buildCounterDocumentationRule = 0;
buildDocumentationRule() {
  var o = new api.DocumentationRule();
  buildCounterDocumentationRule++;
  if (buildCounterDocumentationRule < 3) {
    o.deprecationDescription = "foo";
    o.description = "foo";
    o.selector = "foo";
  }
  buildCounterDocumentationRule--;
  return o;
}

checkDocumentationRule(api.DocumentationRule o) {
  buildCounterDocumentationRule++;
  if (buildCounterDocumentationRule < 3) {
    unittest.expect(o.deprecationDescription, unittest.equals('foo'));
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.selector, unittest.equals('foo'));
  }
  buildCounterDocumentationRule--;
}

core.int buildCounterEmpty = 0;
buildEmpty() {
  var o = new api.Empty();
  buildCounterEmpty++;
  if (buildCounterEmpty < 3) {}
  buildCounterEmpty--;
  return o;
}

checkEmpty(api.Empty o) {
  buildCounterEmpty++;
  if (buildCounterEmpty < 3) {}
  buildCounterEmpty--;
}

core.int buildCounterEnableFailure = 0;
buildEnableFailure() {
  var o = new api.EnableFailure();
  buildCounterEnableFailure++;
  if (buildCounterEnableFailure < 3) {
    o.errorMessage = "foo";
    o.serviceId = "foo";
  }
  buildCounterEnableFailure--;
  return o;
}

checkEnableFailure(api.EnableFailure o) {
  buildCounterEnableFailure++;
  if (buildCounterEnableFailure < 3) {
    unittest.expect(o.errorMessage, unittest.equals('foo'));
    unittest.expect(o.serviceId, unittest.equals('foo'));
  }
  buildCounterEnableFailure--;
}

core.int buildCounterEnableServiceRequest = 0;
buildEnableServiceRequest() {
  var o = new api.EnableServiceRequest();
  buildCounterEnableServiceRequest++;
  if (buildCounterEnableServiceRequest < 3) {}
  buildCounterEnableServiceRequest--;
  return o;
}

checkEnableServiceRequest(api.EnableServiceRequest o) {
  buildCounterEnableServiceRequest++;
  if (buildCounterEnableServiceRequest < 3) {}
  buildCounterEnableServiceRequest--;
}

core.int buildCounterEnableServiceResponse = 0;
buildEnableServiceResponse() {
  var o = new api.EnableServiceResponse();
  buildCounterEnableServiceResponse++;
  if (buildCounterEnableServiceResponse < 3) {
    o.service = buildGoogleApiServiceusageV1Service();
  }
  buildCounterEnableServiceResponse--;
  return o;
}

checkEnableServiceResponse(api.EnableServiceResponse o) {
  buildCounterEnableServiceResponse++;
  if (buildCounterEnableServiceResponse < 3) {
    checkGoogleApiServiceusageV1Service(o.service);
  }
  buildCounterEnableServiceResponse--;
}

buildUnnamed21() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed21(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed22() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed22(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterEndpoint = 0;
buildEndpoint() {
  var o = new api.Endpoint();
  buildCounterEndpoint++;
  if (buildCounterEndpoint < 3) {
    o.aliases = buildUnnamed21();
    o.allowCors = true;
    o.features = buildUnnamed22();
    o.name = "foo";
    o.target = "foo";
  }
  buildCounterEndpoint--;
  return o;
}

checkEndpoint(api.Endpoint o) {
  buildCounterEndpoint++;
  if (buildCounterEndpoint < 3) {
    checkUnnamed21(o.aliases);
    unittest.expect(o.allowCors, unittest.isTrue);
    checkUnnamed22(o.features);
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.target, unittest.equals('foo'));
  }
  buildCounterEndpoint--;
}

buildUnnamed23() {
  var o = new core.List<api.EnumValue>();
  o.add(buildEnumValue());
  o.add(buildEnumValue());
  return o;
}

checkUnnamed23(core.List<api.EnumValue> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEnumValue(o[0]);
  checkEnumValue(o[1]);
}

buildUnnamed24() {
  var o = new core.List<api.Option>();
  o.add(buildOption());
  o.add(buildOption());
  return o;
}

checkUnnamed24(core.List<api.Option> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOption(o[0]);
  checkOption(o[1]);
}

core.int buildCounterEnum = 0;
buildEnum() {
  var o = new api.Enum();
  buildCounterEnum++;
  if (buildCounterEnum < 3) {
    o.enumvalue = buildUnnamed23();
    o.name = "foo";
    o.options = buildUnnamed24();
    o.sourceContext = buildSourceContext();
    o.syntax = "foo";
  }
  buildCounterEnum--;
  return o;
}

checkEnum(api.Enum o) {
  buildCounterEnum++;
  if (buildCounterEnum < 3) {
    checkUnnamed23(o.enumvalue);
    unittest.expect(o.name, unittest.equals('foo'));
    checkUnnamed24(o.options);
    checkSourceContext(o.sourceContext);
    unittest.expect(o.syntax, unittest.equals('foo'));
  }
  buildCounterEnum--;
}

buildUnnamed25() {
  var o = new core.List<api.Option>();
  o.add(buildOption());
  o.add(buildOption());
  return o;
}

checkUnnamed25(core.List<api.Option> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOption(o[0]);
  checkOption(o[1]);
}

core.int buildCounterEnumValue = 0;
buildEnumValue() {
  var o = new api.EnumValue();
  buildCounterEnumValue++;
  if (buildCounterEnumValue < 3) {
    o.name = "foo";
    o.number = 42;
    o.options = buildUnnamed25();
  }
  buildCounterEnumValue--;
  return o;
}

checkEnumValue(api.EnumValue o) {
  buildCounterEnumValue++;
  if (buildCounterEnumValue < 3) {
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.number, unittest.equals(42));
    checkUnnamed25(o.options);
  }
  buildCounterEnumValue--;
}

core.int buildCounterExperimental = 0;
buildExperimental() {
  var o = new api.Experimental();
  buildCounterExperimental++;
  if (buildCounterExperimental < 3) {
    o.authorization = buildAuthorizationConfig();
  }
  buildCounterExperimental--;
  return o;
}

checkExperimental(api.Experimental o) {
  buildCounterExperimental++;
  if (buildCounterExperimental < 3) {
    checkAuthorizationConfig(o.authorization);
  }
  buildCounterExperimental--;
}

buildUnnamed26() {
  var o = new core.List<api.Option>();
  o.add(buildOption());
  o.add(buildOption());
  return o;
}

checkUnnamed26(core.List<api.Option> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOption(o[0]);
  checkOption(o[1]);
}

core.int buildCounterField = 0;
buildField() {
  var o = new api.Field();
  buildCounterField++;
  if (buildCounterField < 3) {
    o.cardinality = "foo";
    o.defaultValue = "foo";
    o.jsonName = "foo";
    o.kind = "foo";
    o.name = "foo";
    o.number = 42;
    o.oneofIndex = 42;
    o.options = buildUnnamed26();
    o.packed = true;
    o.typeUrl = "foo";
  }
  buildCounterField--;
  return o;
}

checkField(api.Field o) {
  buildCounterField++;
  if (buildCounterField < 3) {
    unittest.expect(o.cardinality, unittest.equals('foo'));
    unittest.expect(o.defaultValue, unittest.equals('foo'));
    unittest.expect(o.jsonName, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.number, unittest.equals(42));
    unittest.expect(o.oneofIndex, unittest.equals(42));
    checkUnnamed26(o.options);
    unittest.expect(o.packed, unittest.isTrue);
    unittest.expect(o.typeUrl, unittest.equals('foo'));
  }
  buildCounterField--;
}

buildUnnamed27() {
  var o = new core.List<api.Api>();
  o.add(buildApi());
  o.add(buildApi());
  return o;
}

checkUnnamed27(core.List<api.Api> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkApi(o[0]);
  checkApi(o[1]);
}

buildUnnamed28() {
  var o = new core.List<api.Endpoint>();
  o.add(buildEndpoint());
  o.add(buildEndpoint());
  return o;
}

checkUnnamed28(core.List<api.Endpoint> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEndpoint(o[0]);
  checkEndpoint(o[1]);
}

buildUnnamed29() {
  var o = new core.List<api.Enum>();
  o.add(buildEnum());
  o.add(buildEnum());
  return o;
}

checkUnnamed29(core.List<api.Enum> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEnum(o[0]);
  checkEnum(o[1]);
}

buildUnnamed30() {
  var o = new core.List<api.LogDescriptor>();
  o.add(buildLogDescriptor());
  o.add(buildLogDescriptor());
  return o;
}

checkUnnamed30(core.List<api.LogDescriptor> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLogDescriptor(o[0]);
  checkLogDescriptor(o[1]);
}

buildUnnamed31() {
  var o = new core.List<api.MetricDescriptor>();
  o.add(buildMetricDescriptor());
  o.add(buildMetricDescriptor());
  return o;
}

checkUnnamed31(core.List<api.MetricDescriptor> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMetricDescriptor(o[0]);
  checkMetricDescriptor(o[1]);
}

buildUnnamed32() {
  var o = new core.List<api.MonitoredResourceDescriptor>();
  o.add(buildMonitoredResourceDescriptor());
  o.add(buildMonitoredResourceDescriptor());
  return o;
}

checkUnnamed32(core.List<api.MonitoredResourceDescriptor> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMonitoredResourceDescriptor(o[0]);
  checkMonitoredResourceDescriptor(o[1]);
}

buildUnnamed33() {
  var o = new core.List<api.Type>();
  o.add(buildType());
  o.add(buildType());
  return o;
}

checkUnnamed33(core.List<api.Type> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkType(o[0]);
  checkType(o[1]);
}

buildUnnamed34() {
  var o = new core.List<api.Type>();
  o.add(buildType());
  o.add(buildType());
  return o;
}

checkUnnamed34(core.List<api.Type> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkType(o[0]);
  checkType(o[1]);
}

core.int buildCounterGoogleApiService = 0;
buildGoogleApiService() {
  var o = new api.GoogleApiService();
  buildCounterGoogleApiService++;
  if (buildCounterGoogleApiService < 3) {
    o.apis = buildUnnamed27();
    o.authentication = buildAuthentication();
    o.backend = buildBackend();
    o.billing = buildBilling();
    o.configVersion = 42;
    o.context = buildContext();
    o.control = buildControl();
    o.customError = buildCustomError();
    o.documentation = buildDocumentation();
    o.endpoints = buildUnnamed28();
    o.enums = buildUnnamed29();
    o.experimental = buildExperimental();
    o.http = buildHttp();
    o.id = "foo";
    o.logging = buildLogging();
    o.logs = buildUnnamed30();
    o.metrics = buildUnnamed31();
    o.monitoredResources = buildUnnamed32();
    o.monitoring = buildMonitoring();
    o.name = "foo";
    o.producerProjectId = "foo";
    o.quota = buildQuota();
    o.sourceInfo = buildSourceInfo();
    o.systemParameters = buildSystemParameters();
    o.systemTypes = buildUnnamed33();
    o.title = "foo";
    o.types = buildUnnamed34();
    o.usage = buildUsage();
  }
  buildCounterGoogleApiService--;
  return o;
}

checkGoogleApiService(api.GoogleApiService o) {
  buildCounterGoogleApiService++;
  if (buildCounterGoogleApiService < 3) {
    checkUnnamed27(o.apis);
    checkAuthentication(o.authentication);
    checkBackend(o.backend);
    checkBilling(o.billing);
    unittest.expect(o.configVersion, unittest.equals(42));
    checkContext(o.context);
    checkControl(o.control);
    checkCustomError(o.customError);
    checkDocumentation(o.documentation);
    checkUnnamed28(o.endpoints);
    checkUnnamed29(o.enums);
    checkExperimental(o.experimental);
    checkHttp(o.http);
    unittest.expect(o.id, unittest.equals('foo'));
    checkLogging(o.logging);
    checkUnnamed30(o.logs);
    checkUnnamed31(o.metrics);
    checkUnnamed32(o.monitoredResources);
    checkMonitoring(o.monitoring);
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.producerProjectId, unittest.equals('foo'));
    checkQuota(o.quota);
    checkSourceInfo(o.sourceInfo);
    checkSystemParameters(o.systemParameters);
    checkUnnamed33(o.systemTypes);
    unittest.expect(o.title, unittest.equals('foo'));
    checkUnnamed34(o.types);
    checkUsage(o.usage);
  }
  buildCounterGoogleApiService--;
}

buildUnnamed35() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed35(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterGoogleApiServiceusageV1OperationMetadata = 0;
buildGoogleApiServiceusageV1OperationMetadata() {
  var o = new api.GoogleApiServiceusageV1OperationMetadata();
  buildCounterGoogleApiServiceusageV1OperationMetadata++;
  if (buildCounterGoogleApiServiceusageV1OperationMetadata < 3) {
    o.resourceNames = buildUnnamed35();
  }
  buildCounterGoogleApiServiceusageV1OperationMetadata--;
  return o;
}

checkGoogleApiServiceusageV1OperationMetadata(
    api.GoogleApiServiceusageV1OperationMetadata o) {
  buildCounterGoogleApiServiceusageV1OperationMetadata++;
  if (buildCounterGoogleApiServiceusageV1OperationMetadata < 3) {
    checkUnnamed35(o.resourceNames);
  }
  buildCounterGoogleApiServiceusageV1OperationMetadata--;
}

core.int buildCounterGoogleApiServiceusageV1Service = 0;
buildGoogleApiServiceusageV1Service() {
  var o = new api.GoogleApiServiceusageV1Service();
  buildCounterGoogleApiServiceusageV1Service++;
  if (buildCounterGoogleApiServiceusageV1Service < 3) {
    o.config = buildGoogleApiServiceusageV1ServiceConfig();
    o.name = "foo";
    o.parent = "foo";
    o.state = "foo";
  }
  buildCounterGoogleApiServiceusageV1Service--;
  return o;
}

checkGoogleApiServiceusageV1Service(api.GoogleApiServiceusageV1Service o) {
  buildCounterGoogleApiServiceusageV1Service++;
  if (buildCounterGoogleApiServiceusageV1Service < 3) {
    checkGoogleApiServiceusageV1ServiceConfig(o.config);
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.parent, unittest.equals('foo'));
    unittest.expect(o.state, unittest.equals('foo'));
  }
  buildCounterGoogleApiServiceusageV1Service--;
}

buildUnnamed36() {
  var o = new core.List<api.Api>();
  o.add(buildApi());
  o.add(buildApi());
  return o;
}

checkUnnamed36(core.List<api.Api> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkApi(o[0]);
  checkApi(o[1]);
}

buildUnnamed37() {
  var o = new core.List<api.Endpoint>();
  o.add(buildEndpoint());
  o.add(buildEndpoint());
  return o;
}

checkUnnamed37(core.List<api.Endpoint> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEndpoint(o[0]);
  checkEndpoint(o[1]);
}

core.int buildCounterGoogleApiServiceusageV1ServiceConfig = 0;
buildGoogleApiServiceusageV1ServiceConfig() {
  var o = new api.GoogleApiServiceusageV1ServiceConfig();
  buildCounterGoogleApiServiceusageV1ServiceConfig++;
  if (buildCounterGoogleApiServiceusageV1ServiceConfig < 3) {
    o.apis = buildUnnamed36();
    o.authentication = buildAuthentication();
    o.documentation = buildDocumentation();
    o.endpoints = buildUnnamed37();
    o.name = "foo";
    o.quota = buildQuota();
    o.title = "foo";
    o.usage = buildUsage();
  }
  buildCounterGoogleApiServiceusageV1ServiceConfig--;
  return o;
}

checkGoogleApiServiceusageV1ServiceConfig(
    api.GoogleApiServiceusageV1ServiceConfig o) {
  buildCounterGoogleApiServiceusageV1ServiceConfig++;
  if (buildCounterGoogleApiServiceusageV1ServiceConfig < 3) {
    checkUnnamed36(o.apis);
    checkAuthentication(o.authentication);
    checkDocumentation(o.documentation);
    checkUnnamed37(o.endpoints);
    unittest.expect(o.name, unittest.equals('foo'));
    checkQuota(o.quota);
    unittest.expect(o.title, unittest.equals('foo'));
    checkUsage(o.usage);
  }
  buildCounterGoogleApiServiceusageV1ServiceConfig--;
}

buildUnnamed38() {
  var o = new core.List<api.HttpRule>();
  o.add(buildHttpRule());
  o.add(buildHttpRule());
  return o;
}

checkUnnamed38(core.List<api.HttpRule> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkHttpRule(o[0]);
  checkHttpRule(o[1]);
}

core.int buildCounterHttp = 0;
buildHttp() {
  var o = new api.Http();
  buildCounterHttp++;
  if (buildCounterHttp < 3) {
    o.fullyDecodeReservedExpansion = true;
    o.rules = buildUnnamed38();
  }
  buildCounterHttp--;
  return o;
}

checkHttp(api.Http o) {
  buildCounterHttp++;
  if (buildCounterHttp < 3) {
    unittest.expect(o.fullyDecodeReservedExpansion, unittest.isTrue);
    checkUnnamed38(o.rules);
  }
  buildCounterHttp--;
}

buildUnnamed39() {
  var o = new core.List<api.HttpRule>();
  o.add(buildHttpRule());
  o.add(buildHttpRule());
  return o;
}

checkUnnamed39(core.List<api.HttpRule> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkHttpRule(o[0]);
  checkHttpRule(o[1]);
}

core.int buildCounterHttpRule = 0;
buildHttpRule() {
  var o = new api.HttpRule();
  buildCounterHttpRule++;
  if (buildCounterHttpRule < 3) {
    o.additionalBindings = buildUnnamed39();
    o.body = "foo";
    o.custom = buildCustomHttpPattern();
    o.delete = "foo";
    o.get = "foo";
    o.patch = "foo";
    o.post = "foo";
    o.put = "foo";
    o.responseBody = "foo";
    o.selector = "foo";
  }
  buildCounterHttpRule--;
  return o;
}

checkHttpRule(api.HttpRule o) {
  buildCounterHttpRule++;
  if (buildCounterHttpRule < 3) {
    checkUnnamed39(o.additionalBindings);
    unittest.expect(o.body, unittest.equals('foo'));
    checkCustomHttpPattern(o.custom);
    unittest.expect(o.delete, unittest.equals('foo'));
    unittest.expect(o.get, unittest.equals('foo'));
    unittest.expect(o.patch, unittest.equals('foo'));
    unittest.expect(o.post, unittest.equals('foo'));
    unittest.expect(o.put, unittest.equals('foo'));
    unittest.expect(o.responseBody, unittest.equals('foo'));
    unittest.expect(o.selector, unittest.equals('foo'));
  }
  buildCounterHttpRule--;
}

core.int buildCounterLabelDescriptor = 0;
buildLabelDescriptor() {
  var o = new api.LabelDescriptor();
  buildCounterLabelDescriptor++;
  if (buildCounterLabelDescriptor < 3) {
    o.description = "foo";
    o.key = "foo";
    o.valueType = "foo";
  }
  buildCounterLabelDescriptor--;
  return o;
}

checkLabelDescriptor(api.LabelDescriptor o) {
  buildCounterLabelDescriptor++;
  if (buildCounterLabelDescriptor < 3) {
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.key, unittest.equals('foo'));
    unittest.expect(o.valueType, unittest.equals('foo'));
  }
  buildCounterLabelDescriptor--;
}

buildUnnamed40() {
  var o = new core.List<api.Operation>();
  o.add(buildOperation());
  o.add(buildOperation());
  return o;
}

checkUnnamed40(core.List<api.Operation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOperation(o[0]);
  checkOperation(o[1]);
}

core.int buildCounterListOperationsResponse = 0;
buildListOperationsResponse() {
  var o = new api.ListOperationsResponse();
  buildCounterListOperationsResponse++;
  if (buildCounterListOperationsResponse < 3) {
    o.nextPageToken = "foo";
    o.operations = buildUnnamed40();
  }
  buildCounterListOperationsResponse--;
  return o;
}

checkListOperationsResponse(api.ListOperationsResponse o) {
  buildCounterListOperationsResponse++;
  if (buildCounterListOperationsResponse < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed40(o.operations);
  }
  buildCounterListOperationsResponse--;
}

buildUnnamed41() {
  var o = new core.List<api.GoogleApiServiceusageV1Service>();
  o.add(buildGoogleApiServiceusageV1Service());
  o.add(buildGoogleApiServiceusageV1Service());
  return o;
}

checkUnnamed41(core.List<api.GoogleApiServiceusageV1Service> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleApiServiceusageV1Service(o[0]);
  checkGoogleApiServiceusageV1Service(o[1]);
}

core.int buildCounterListServicesResponse = 0;
buildListServicesResponse() {
  var o = new api.ListServicesResponse();
  buildCounterListServicesResponse++;
  if (buildCounterListServicesResponse < 3) {
    o.nextPageToken = "foo";
    o.services = buildUnnamed41();
  }
  buildCounterListServicesResponse--;
  return o;
}

checkListServicesResponse(api.ListServicesResponse o) {
  buildCounterListServicesResponse++;
  if (buildCounterListServicesResponse < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed41(o.services);
  }
  buildCounterListServicesResponse--;
}

buildUnnamed42() {
  var o = new core.List<api.LabelDescriptor>();
  o.add(buildLabelDescriptor());
  o.add(buildLabelDescriptor());
  return o;
}

checkUnnamed42(core.List<api.LabelDescriptor> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLabelDescriptor(o[0]);
  checkLabelDescriptor(o[1]);
}

core.int buildCounterLogDescriptor = 0;
buildLogDescriptor() {
  var o = new api.LogDescriptor();
  buildCounterLogDescriptor++;
  if (buildCounterLogDescriptor < 3) {
    o.description = "foo";
    o.displayName = "foo";
    o.labels = buildUnnamed42();
    o.name = "foo";
  }
  buildCounterLogDescriptor--;
  return o;
}

checkLogDescriptor(api.LogDescriptor o) {
  buildCounterLogDescriptor++;
  if (buildCounterLogDescriptor < 3) {
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.displayName, unittest.equals('foo'));
    checkUnnamed42(o.labels);
    unittest.expect(o.name, unittest.equals('foo'));
  }
  buildCounterLogDescriptor--;
}

buildUnnamed43() {
  var o = new core.List<api.LoggingDestination>();
  o.add(buildLoggingDestination());
  o.add(buildLoggingDestination());
  return o;
}

checkUnnamed43(core.List<api.LoggingDestination> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLoggingDestination(o[0]);
  checkLoggingDestination(o[1]);
}

buildUnnamed44() {
  var o = new core.List<api.LoggingDestination>();
  o.add(buildLoggingDestination());
  o.add(buildLoggingDestination());
  return o;
}

checkUnnamed44(core.List<api.LoggingDestination> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLoggingDestination(o[0]);
  checkLoggingDestination(o[1]);
}

core.int buildCounterLogging = 0;
buildLogging() {
  var o = new api.Logging();
  buildCounterLogging++;
  if (buildCounterLogging < 3) {
    o.consumerDestinations = buildUnnamed43();
    o.producerDestinations = buildUnnamed44();
  }
  buildCounterLogging--;
  return o;
}

checkLogging(api.Logging o) {
  buildCounterLogging++;
  if (buildCounterLogging < 3) {
    checkUnnamed43(o.consumerDestinations);
    checkUnnamed44(o.producerDestinations);
  }
  buildCounterLogging--;
}

buildUnnamed45() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed45(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterLoggingDestination = 0;
buildLoggingDestination() {
  var o = new api.LoggingDestination();
  buildCounterLoggingDestination++;
  if (buildCounterLoggingDestination < 3) {
    o.logs = buildUnnamed45();
    o.monitoredResource = "foo";
  }
  buildCounterLoggingDestination--;
  return o;
}

checkLoggingDestination(api.LoggingDestination o) {
  buildCounterLoggingDestination++;
  if (buildCounterLoggingDestination < 3) {
    checkUnnamed45(o.logs);
    unittest.expect(o.monitoredResource, unittest.equals('foo'));
  }
  buildCounterLoggingDestination--;
}

buildUnnamed46() {
  var o = new core.List<api.Option>();
  o.add(buildOption());
  o.add(buildOption());
  return o;
}

checkUnnamed46(core.List<api.Option> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOption(o[0]);
  checkOption(o[1]);
}

core.int buildCounterMethod = 0;
buildMethod() {
  var o = new api.Method();
  buildCounterMethod++;
  if (buildCounterMethod < 3) {
    o.name = "foo";
    o.options = buildUnnamed46();
    o.requestStreaming = true;
    o.requestTypeUrl = "foo";
    o.responseStreaming = true;
    o.responseTypeUrl = "foo";
    o.syntax = "foo";
  }
  buildCounterMethod--;
  return o;
}

checkMethod(api.Method o) {
  buildCounterMethod++;
  if (buildCounterMethod < 3) {
    unittest.expect(o.name, unittest.equals('foo'));
    checkUnnamed46(o.options);
    unittest.expect(o.requestStreaming, unittest.isTrue);
    unittest.expect(o.requestTypeUrl, unittest.equals('foo'));
    unittest.expect(o.responseStreaming, unittest.isTrue);
    unittest.expect(o.responseTypeUrl, unittest.equals('foo'));
    unittest.expect(o.syntax, unittest.equals('foo'));
  }
  buildCounterMethod--;
}

buildUnnamed47() {
  var o = new core.List<api.LabelDescriptor>();
  o.add(buildLabelDescriptor());
  o.add(buildLabelDescriptor());
  return o;
}

checkUnnamed47(core.List<api.LabelDescriptor> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLabelDescriptor(o[0]);
  checkLabelDescriptor(o[1]);
}

core.int buildCounterMetricDescriptor = 0;
buildMetricDescriptor() {
  var o = new api.MetricDescriptor();
  buildCounterMetricDescriptor++;
  if (buildCounterMetricDescriptor < 3) {
    o.description = "foo";
    o.displayName = "foo";
    o.labels = buildUnnamed47();
    o.metadata = buildMetricDescriptorMetadata();
    o.metricKind = "foo";
    o.name = "foo";
    o.type = "foo";
    o.unit = "foo";
    o.valueType = "foo";
  }
  buildCounterMetricDescriptor--;
  return o;
}

checkMetricDescriptor(api.MetricDescriptor o) {
  buildCounterMetricDescriptor++;
  if (buildCounterMetricDescriptor < 3) {
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.displayName, unittest.equals('foo'));
    checkUnnamed47(o.labels);
    checkMetricDescriptorMetadata(o.metadata);
    unittest.expect(o.metricKind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
    unittest.expect(o.unit, unittest.equals('foo'));
    unittest.expect(o.valueType, unittest.equals('foo'));
  }
  buildCounterMetricDescriptor--;
}

core.int buildCounterMetricDescriptorMetadata = 0;
buildMetricDescriptorMetadata() {
  var o = new api.MetricDescriptorMetadata();
  buildCounterMetricDescriptorMetadata++;
  if (buildCounterMetricDescriptorMetadata < 3) {
    o.ingestDelay = "foo";
    o.launchStage = "foo";
    o.samplePeriod = "foo";
  }
  buildCounterMetricDescriptorMetadata--;
  return o;
}

checkMetricDescriptorMetadata(api.MetricDescriptorMetadata o) {
  buildCounterMetricDescriptorMetadata++;
  if (buildCounterMetricDescriptorMetadata < 3) {
    unittest.expect(o.ingestDelay, unittest.equals('foo'));
    unittest.expect(o.launchStage, unittest.equals('foo'));
    unittest.expect(o.samplePeriod, unittest.equals('foo'));
  }
  buildCounterMetricDescriptorMetadata--;
}

buildUnnamed48() {
  var o = new core.Map<core.String, core.String>();
  o["x"] = "foo";
  o["y"] = "foo";
  return o;
}

checkUnnamed48(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals('foo'));
  unittest.expect(o["y"], unittest.equals('foo'));
}

core.int buildCounterMetricRule = 0;
buildMetricRule() {
  var o = new api.MetricRule();
  buildCounterMetricRule++;
  if (buildCounterMetricRule < 3) {
    o.metricCosts = buildUnnamed48();
    o.selector = "foo";
  }
  buildCounterMetricRule--;
  return o;
}

checkMetricRule(api.MetricRule o) {
  buildCounterMetricRule++;
  if (buildCounterMetricRule < 3) {
    checkUnnamed48(o.metricCosts);
    unittest.expect(o.selector, unittest.equals('foo'));
  }
  buildCounterMetricRule--;
}

core.int buildCounterMixin = 0;
buildMixin() {
  var o = new api.Mixin();
  buildCounterMixin++;
  if (buildCounterMixin < 3) {
    o.name = "foo";
    o.root = "foo";
  }
  buildCounterMixin--;
  return o;
}

checkMixin(api.Mixin o) {
  buildCounterMixin++;
  if (buildCounterMixin < 3) {
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.root, unittest.equals('foo'));
  }
  buildCounterMixin--;
}

buildUnnamed49() {
  var o = new core.List<api.LabelDescriptor>();
  o.add(buildLabelDescriptor());
  o.add(buildLabelDescriptor());
  return o;
}

checkUnnamed49(core.List<api.LabelDescriptor> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLabelDescriptor(o[0]);
  checkLabelDescriptor(o[1]);
}

core.int buildCounterMonitoredResourceDescriptor = 0;
buildMonitoredResourceDescriptor() {
  var o = new api.MonitoredResourceDescriptor();
  buildCounterMonitoredResourceDescriptor++;
  if (buildCounterMonitoredResourceDescriptor < 3) {
    o.description = "foo";
    o.displayName = "foo";
    o.labels = buildUnnamed49();
    o.name = "foo";
    o.type = "foo";
  }
  buildCounterMonitoredResourceDescriptor--;
  return o;
}

checkMonitoredResourceDescriptor(api.MonitoredResourceDescriptor o) {
  buildCounterMonitoredResourceDescriptor++;
  if (buildCounterMonitoredResourceDescriptor < 3) {
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.displayName, unittest.equals('foo'));
    checkUnnamed49(o.labels);
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterMonitoredResourceDescriptor--;
}

buildUnnamed50() {
  var o = new core.List<api.MonitoringDestination>();
  o.add(buildMonitoringDestination());
  o.add(buildMonitoringDestination());
  return o;
}

checkUnnamed50(core.List<api.MonitoringDestination> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMonitoringDestination(o[0]);
  checkMonitoringDestination(o[1]);
}

buildUnnamed51() {
  var o = new core.List<api.MonitoringDestination>();
  o.add(buildMonitoringDestination());
  o.add(buildMonitoringDestination());
  return o;
}

checkUnnamed51(core.List<api.MonitoringDestination> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMonitoringDestination(o[0]);
  checkMonitoringDestination(o[1]);
}

core.int buildCounterMonitoring = 0;
buildMonitoring() {
  var o = new api.Monitoring();
  buildCounterMonitoring++;
  if (buildCounterMonitoring < 3) {
    o.consumerDestinations = buildUnnamed50();
    o.producerDestinations = buildUnnamed51();
  }
  buildCounterMonitoring--;
  return o;
}

checkMonitoring(api.Monitoring o) {
  buildCounterMonitoring++;
  if (buildCounterMonitoring < 3) {
    checkUnnamed50(o.consumerDestinations);
    checkUnnamed51(o.producerDestinations);
  }
  buildCounterMonitoring--;
}

buildUnnamed52() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed52(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterMonitoringDestination = 0;
buildMonitoringDestination() {
  var o = new api.MonitoringDestination();
  buildCounterMonitoringDestination++;
  if (buildCounterMonitoringDestination < 3) {
    o.metrics = buildUnnamed52();
    o.monitoredResource = "foo";
  }
  buildCounterMonitoringDestination--;
  return o;
}

checkMonitoringDestination(api.MonitoringDestination o) {
  buildCounterMonitoringDestination++;
  if (buildCounterMonitoringDestination < 3) {
    checkUnnamed52(o.metrics);
    unittest.expect(o.monitoredResource, unittest.equals('foo'));
  }
  buildCounterMonitoringDestination--;
}

core.int buildCounterOAuthRequirements = 0;
buildOAuthRequirements() {
  var o = new api.OAuthRequirements();
  buildCounterOAuthRequirements++;
  if (buildCounterOAuthRequirements < 3) {
    o.canonicalScopes = "foo";
  }
  buildCounterOAuthRequirements--;
  return o;
}

checkOAuthRequirements(api.OAuthRequirements o) {
  buildCounterOAuthRequirements++;
  if (buildCounterOAuthRequirements < 3) {
    unittest.expect(o.canonicalScopes, unittest.equals('foo'));
  }
  buildCounterOAuthRequirements--;
}

buildUnnamed53() {
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

checkUnnamed53(core.Map<core.String, core.Object> o) {
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

buildUnnamed54() {
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

checkUnnamed54(core.Map<core.String, core.Object> o) {
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

core.int buildCounterOperation = 0;
buildOperation() {
  var o = new api.Operation();
  buildCounterOperation++;
  if (buildCounterOperation < 3) {
    o.done = true;
    o.error = buildStatus();
    o.metadata = buildUnnamed53();
    o.name = "foo";
    o.response = buildUnnamed54();
  }
  buildCounterOperation--;
  return o;
}

checkOperation(api.Operation o) {
  buildCounterOperation++;
  if (buildCounterOperation < 3) {
    unittest.expect(o.done, unittest.isTrue);
    checkStatus(o.error);
    checkUnnamed53(o.metadata);
    unittest.expect(o.name, unittest.equals('foo'));
    checkUnnamed54(o.response);
  }
  buildCounterOperation--;
}

buildUnnamed55() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed55(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterOperationMetadata = 0;
buildOperationMetadata() {
  var o = new api.OperationMetadata();
  buildCounterOperationMetadata++;
  if (buildCounterOperationMetadata < 3) {
    o.resourceNames = buildUnnamed55();
  }
  buildCounterOperationMetadata--;
  return o;
}

checkOperationMetadata(api.OperationMetadata o) {
  buildCounterOperationMetadata++;
  if (buildCounterOperationMetadata < 3) {
    checkUnnamed55(o.resourceNames);
  }
  buildCounterOperationMetadata--;
}

buildUnnamed56() {
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

checkUnnamed56(core.Map<core.String, core.Object> o) {
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

core.int buildCounterOption = 0;
buildOption() {
  var o = new api.Option();
  buildCounterOption++;
  if (buildCounterOption < 3) {
    o.name = "foo";
    o.value = buildUnnamed56();
  }
  buildCounterOption--;
  return o;
}

checkOption(api.Option o) {
  buildCounterOption++;
  if (buildCounterOption < 3) {
    unittest.expect(o.name, unittest.equals('foo'));
    checkUnnamed56(o.value);
  }
  buildCounterOption--;
}

buildUnnamed57() {
  var o = new core.List<api.Page>();
  o.add(buildPage());
  o.add(buildPage());
  return o;
}

checkUnnamed57(core.List<api.Page> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPage(o[0]);
  checkPage(o[1]);
}

core.int buildCounterPage = 0;
buildPage() {
  var o = new api.Page();
  buildCounterPage++;
  if (buildCounterPage < 3) {
    o.content = "foo";
    o.name = "foo";
    o.subpages = buildUnnamed57();
  }
  buildCounterPage--;
  return o;
}

checkPage(api.Page o) {
  buildCounterPage++;
  if (buildCounterPage < 3) {
    unittest.expect(o.content, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    checkUnnamed57(o.subpages);
  }
  buildCounterPage--;
}

buildUnnamed58() {
  var o = new core.List<api.QuotaLimit>();
  o.add(buildQuotaLimit());
  o.add(buildQuotaLimit());
  return o;
}

checkUnnamed58(core.List<api.QuotaLimit> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkQuotaLimit(o[0]);
  checkQuotaLimit(o[1]);
}

buildUnnamed59() {
  var o = new core.List<api.MetricRule>();
  o.add(buildMetricRule());
  o.add(buildMetricRule());
  return o;
}

checkUnnamed59(core.List<api.MetricRule> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMetricRule(o[0]);
  checkMetricRule(o[1]);
}

core.int buildCounterQuota = 0;
buildQuota() {
  var o = new api.Quota();
  buildCounterQuota++;
  if (buildCounterQuota < 3) {
    o.limits = buildUnnamed58();
    o.metricRules = buildUnnamed59();
  }
  buildCounterQuota--;
  return o;
}

checkQuota(api.Quota o) {
  buildCounterQuota++;
  if (buildCounterQuota < 3) {
    checkUnnamed58(o.limits);
    checkUnnamed59(o.metricRules);
  }
  buildCounterQuota--;
}

buildUnnamed60() {
  var o = new core.Map<core.String, core.String>();
  o["x"] = "foo";
  o["y"] = "foo";
  return o;
}

checkUnnamed60(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals('foo'));
  unittest.expect(o["y"], unittest.equals('foo'));
}

core.int buildCounterQuotaLimit = 0;
buildQuotaLimit() {
  var o = new api.QuotaLimit();
  buildCounterQuotaLimit++;
  if (buildCounterQuotaLimit < 3) {
    o.defaultLimit = "foo";
    o.description = "foo";
    o.displayName = "foo";
    o.duration = "foo";
    o.freeTier = "foo";
    o.maxLimit = "foo";
    o.metric = "foo";
    o.name = "foo";
    o.unit = "foo";
    o.values = buildUnnamed60();
  }
  buildCounterQuotaLimit--;
  return o;
}

checkQuotaLimit(api.QuotaLimit o) {
  buildCounterQuotaLimit++;
  if (buildCounterQuotaLimit < 3) {
    unittest.expect(o.defaultLimit, unittest.equals('foo'));
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.displayName, unittest.equals('foo'));
    unittest.expect(o.duration, unittest.equals('foo'));
    unittest.expect(o.freeTier, unittest.equals('foo'));
    unittest.expect(o.maxLimit, unittest.equals('foo'));
    unittest.expect(o.metric, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.unit, unittest.equals('foo'));
    checkUnnamed60(o.values);
  }
  buildCounterQuotaLimit--;
}

core.int buildCounterSourceContext = 0;
buildSourceContext() {
  var o = new api.SourceContext();
  buildCounterSourceContext++;
  if (buildCounterSourceContext < 3) {
    o.fileName = "foo";
  }
  buildCounterSourceContext--;
  return o;
}

checkSourceContext(api.SourceContext o) {
  buildCounterSourceContext++;
  if (buildCounterSourceContext < 3) {
    unittest.expect(o.fileName, unittest.equals('foo'));
  }
  buildCounterSourceContext--;
}

buildUnnamed61() {
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

checkUnnamed61(core.Map<core.String, core.Object> o) {
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

buildUnnamed62() {
  var o = new core.List<core.Map<core.String, core.Object>>();
  o.add(buildUnnamed61());
  o.add(buildUnnamed61());
  return o;
}

checkUnnamed62(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed61(o[0]);
  checkUnnamed61(o[1]);
}

core.int buildCounterSourceInfo = 0;
buildSourceInfo() {
  var o = new api.SourceInfo();
  buildCounterSourceInfo++;
  if (buildCounterSourceInfo < 3) {
    o.sourceFiles = buildUnnamed62();
  }
  buildCounterSourceInfo--;
  return o;
}

checkSourceInfo(api.SourceInfo o) {
  buildCounterSourceInfo++;
  if (buildCounterSourceInfo < 3) {
    checkUnnamed62(o.sourceFiles);
  }
  buildCounterSourceInfo--;
}

buildUnnamed63() {
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

checkUnnamed63(core.Map<core.String, core.Object> o) {
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

buildUnnamed64() {
  var o = new core.List<core.Map<core.String, core.Object>>();
  o.add(buildUnnamed63());
  o.add(buildUnnamed63());
  return o;
}

checkUnnamed64(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed63(o[0]);
  checkUnnamed63(o[1]);
}

core.int buildCounterStatus = 0;
buildStatus() {
  var o = new api.Status();
  buildCounterStatus++;
  if (buildCounterStatus < 3) {
    o.code = 42;
    o.details = buildUnnamed64();
    o.message = "foo";
  }
  buildCounterStatus--;
  return o;
}

checkStatus(api.Status o) {
  buildCounterStatus++;
  if (buildCounterStatus < 3) {
    unittest.expect(o.code, unittest.equals(42));
    checkUnnamed64(o.details);
    unittest.expect(o.message, unittest.equals('foo'));
  }
  buildCounterStatus--;
}

core.int buildCounterSystemParameter = 0;
buildSystemParameter() {
  var o = new api.SystemParameter();
  buildCounterSystemParameter++;
  if (buildCounterSystemParameter < 3) {
    o.httpHeader = "foo";
    o.name = "foo";
    o.urlQueryParameter = "foo";
  }
  buildCounterSystemParameter--;
  return o;
}

checkSystemParameter(api.SystemParameter o) {
  buildCounterSystemParameter++;
  if (buildCounterSystemParameter < 3) {
    unittest.expect(o.httpHeader, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.urlQueryParameter, unittest.equals('foo'));
  }
  buildCounterSystemParameter--;
}

buildUnnamed65() {
  var o = new core.List<api.SystemParameter>();
  o.add(buildSystemParameter());
  o.add(buildSystemParameter());
  return o;
}

checkUnnamed65(core.List<api.SystemParameter> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSystemParameter(o[0]);
  checkSystemParameter(o[1]);
}

core.int buildCounterSystemParameterRule = 0;
buildSystemParameterRule() {
  var o = new api.SystemParameterRule();
  buildCounterSystemParameterRule++;
  if (buildCounterSystemParameterRule < 3) {
    o.parameters = buildUnnamed65();
    o.selector = "foo";
  }
  buildCounterSystemParameterRule--;
  return o;
}

checkSystemParameterRule(api.SystemParameterRule o) {
  buildCounterSystemParameterRule++;
  if (buildCounterSystemParameterRule < 3) {
    checkUnnamed65(o.parameters);
    unittest.expect(o.selector, unittest.equals('foo'));
  }
  buildCounterSystemParameterRule--;
}

buildUnnamed66() {
  var o = new core.List<api.SystemParameterRule>();
  o.add(buildSystemParameterRule());
  o.add(buildSystemParameterRule());
  return o;
}

checkUnnamed66(core.List<api.SystemParameterRule> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSystemParameterRule(o[0]);
  checkSystemParameterRule(o[1]);
}

core.int buildCounterSystemParameters = 0;
buildSystemParameters() {
  var o = new api.SystemParameters();
  buildCounterSystemParameters++;
  if (buildCounterSystemParameters < 3) {
    o.rules = buildUnnamed66();
  }
  buildCounterSystemParameters--;
  return o;
}

checkSystemParameters(api.SystemParameters o) {
  buildCounterSystemParameters++;
  if (buildCounterSystemParameters < 3) {
    checkUnnamed66(o.rules);
  }
  buildCounterSystemParameters--;
}

buildUnnamed67() {
  var o = new core.List<api.Field>();
  o.add(buildField());
  o.add(buildField());
  return o;
}

checkUnnamed67(core.List<api.Field> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkField(o[0]);
  checkField(o[1]);
}

buildUnnamed68() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed68(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed69() {
  var o = new core.List<api.Option>();
  o.add(buildOption());
  o.add(buildOption());
  return o;
}

checkUnnamed69(core.List<api.Option> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOption(o[0]);
  checkOption(o[1]);
}

core.int buildCounterType = 0;
buildType() {
  var o = new api.Type();
  buildCounterType++;
  if (buildCounterType < 3) {
    o.fields = buildUnnamed67();
    o.name = "foo";
    o.oneofs = buildUnnamed68();
    o.options = buildUnnamed69();
    o.sourceContext = buildSourceContext();
    o.syntax = "foo";
  }
  buildCounterType--;
  return o;
}

checkType(api.Type o) {
  buildCounterType++;
  if (buildCounterType < 3) {
    checkUnnamed67(o.fields);
    unittest.expect(o.name, unittest.equals('foo'));
    checkUnnamed68(o.oneofs);
    checkUnnamed69(o.options);
    checkSourceContext(o.sourceContext);
    unittest.expect(o.syntax, unittest.equals('foo'));
  }
  buildCounterType--;
}

buildUnnamed70() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed70(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed71() {
  var o = new core.List<api.UsageRule>();
  o.add(buildUsageRule());
  o.add(buildUsageRule());
  return o;
}

checkUnnamed71(core.List<api.UsageRule> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUsageRule(o[0]);
  checkUsageRule(o[1]);
}

core.int buildCounterUsage = 0;
buildUsage() {
  var o = new api.Usage();
  buildCounterUsage++;
  if (buildCounterUsage < 3) {
    o.producerNotificationChannel = "foo";
    o.requirements = buildUnnamed70();
    o.rules = buildUnnamed71();
  }
  buildCounterUsage--;
  return o;
}

checkUsage(api.Usage o) {
  buildCounterUsage++;
  if (buildCounterUsage < 3) {
    unittest.expect(o.producerNotificationChannel, unittest.equals('foo'));
    checkUnnamed70(o.requirements);
    checkUnnamed71(o.rules);
  }
  buildCounterUsage--;
}

core.int buildCounterUsageRule = 0;
buildUsageRule() {
  var o = new api.UsageRule();
  buildCounterUsageRule++;
  if (buildCounterUsageRule < 3) {
    o.allowUnregisteredCalls = true;
    o.selector = "foo";
    o.skipServiceControl = true;
  }
  buildCounterUsageRule--;
  return o;
}

checkUsageRule(api.UsageRule o) {
  buildCounterUsageRule++;
  if (buildCounterUsageRule < 3) {
    unittest.expect(o.allowUnregisteredCalls, unittest.isTrue);
    unittest.expect(o.selector, unittest.equals('foo'));
    unittest.expect(o.skipServiceControl, unittest.isTrue);
  }
  buildCounterUsageRule--;
}

main() {
  unittest.group("obj-schema-Api", () {
    unittest.test("to-json--from-json", () {
      var o = buildApi();
      var od = new api.Api.fromJson(o.toJson());
      checkApi(od);
    });
  });

  unittest.group("obj-schema-AuthProvider", () {
    unittest.test("to-json--from-json", () {
      var o = buildAuthProvider();
      var od = new api.AuthProvider.fromJson(o.toJson());
      checkAuthProvider(od);
    });
  });

  unittest.group("obj-schema-AuthRequirement", () {
    unittest.test("to-json--from-json", () {
      var o = buildAuthRequirement();
      var od = new api.AuthRequirement.fromJson(o.toJson());
      checkAuthRequirement(od);
    });
  });

  unittest.group("obj-schema-Authentication", () {
    unittest.test("to-json--from-json", () {
      var o = buildAuthentication();
      var od = new api.Authentication.fromJson(o.toJson());
      checkAuthentication(od);
    });
  });

  unittest.group("obj-schema-AuthenticationRule", () {
    unittest.test("to-json--from-json", () {
      var o = buildAuthenticationRule();
      var od = new api.AuthenticationRule.fromJson(o.toJson());
      checkAuthenticationRule(od);
    });
  });

  unittest.group("obj-schema-AuthorizationConfig", () {
    unittest.test("to-json--from-json", () {
      var o = buildAuthorizationConfig();
      var od = new api.AuthorizationConfig.fromJson(o.toJson());
      checkAuthorizationConfig(od);
    });
  });

  unittest.group("obj-schema-Backend", () {
    unittest.test("to-json--from-json", () {
      var o = buildBackend();
      var od = new api.Backend.fromJson(o.toJson());
      checkBackend(od);
    });
  });

  unittest.group("obj-schema-BackendRule", () {
    unittest.test("to-json--from-json", () {
      var o = buildBackendRule();
      var od = new api.BackendRule.fromJson(o.toJson());
      checkBackendRule(od);
    });
  });

  unittest.group("obj-schema-BatchEnableServicesRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildBatchEnableServicesRequest();
      var od = new api.BatchEnableServicesRequest.fromJson(o.toJson());
      checkBatchEnableServicesRequest(od);
    });
  });

  unittest.group("obj-schema-BatchEnableServicesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildBatchEnableServicesResponse();
      var od = new api.BatchEnableServicesResponse.fromJson(o.toJson());
      checkBatchEnableServicesResponse(od);
    });
  });

  unittest.group("obj-schema-Billing", () {
    unittest.test("to-json--from-json", () {
      var o = buildBilling();
      var od = new api.Billing.fromJson(o.toJson());
      checkBilling(od);
    });
  });

  unittest.group("obj-schema-BillingDestination", () {
    unittest.test("to-json--from-json", () {
      var o = buildBillingDestination();
      var od = new api.BillingDestination.fromJson(o.toJson());
      checkBillingDestination(od);
    });
  });

  unittest.group("obj-schema-CancelOperationRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildCancelOperationRequest();
      var od = new api.CancelOperationRequest.fromJson(o.toJson());
      checkCancelOperationRequest(od);
    });
  });

  unittest.group("obj-schema-Context", () {
    unittest.test("to-json--from-json", () {
      var o = buildContext();
      var od = new api.Context.fromJson(o.toJson());
      checkContext(od);
    });
  });

  unittest.group("obj-schema-ContextRule", () {
    unittest.test("to-json--from-json", () {
      var o = buildContextRule();
      var od = new api.ContextRule.fromJson(o.toJson());
      checkContextRule(od);
    });
  });

  unittest.group("obj-schema-Control", () {
    unittest.test("to-json--from-json", () {
      var o = buildControl();
      var od = new api.Control.fromJson(o.toJson());
      checkControl(od);
    });
  });

  unittest.group("obj-schema-CustomError", () {
    unittest.test("to-json--from-json", () {
      var o = buildCustomError();
      var od = new api.CustomError.fromJson(o.toJson());
      checkCustomError(od);
    });
  });

  unittest.group("obj-schema-CustomErrorRule", () {
    unittest.test("to-json--from-json", () {
      var o = buildCustomErrorRule();
      var od = new api.CustomErrorRule.fromJson(o.toJson());
      checkCustomErrorRule(od);
    });
  });

  unittest.group("obj-schema-CustomHttpPattern", () {
    unittest.test("to-json--from-json", () {
      var o = buildCustomHttpPattern();
      var od = new api.CustomHttpPattern.fromJson(o.toJson());
      checkCustomHttpPattern(od);
    });
  });

  unittest.group("obj-schema-DisableServiceRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildDisableServiceRequest();
      var od = new api.DisableServiceRequest.fromJson(o.toJson());
      checkDisableServiceRequest(od);
    });
  });

  unittest.group("obj-schema-DisableServiceResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildDisableServiceResponse();
      var od = new api.DisableServiceResponse.fromJson(o.toJson());
      checkDisableServiceResponse(od);
    });
  });

  unittest.group("obj-schema-Documentation", () {
    unittest.test("to-json--from-json", () {
      var o = buildDocumentation();
      var od = new api.Documentation.fromJson(o.toJson());
      checkDocumentation(od);
    });
  });

  unittest.group("obj-schema-DocumentationRule", () {
    unittest.test("to-json--from-json", () {
      var o = buildDocumentationRule();
      var od = new api.DocumentationRule.fromJson(o.toJson());
      checkDocumentationRule(od);
    });
  });

  unittest.group("obj-schema-Empty", () {
    unittest.test("to-json--from-json", () {
      var o = buildEmpty();
      var od = new api.Empty.fromJson(o.toJson());
      checkEmpty(od);
    });
  });

  unittest.group("obj-schema-EnableFailure", () {
    unittest.test("to-json--from-json", () {
      var o = buildEnableFailure();
      var od = new api.EnableFailure.fromJson(o.toJson());
      checkEnableFailure(od);
    });
  });

  unittest.group("obj-schema-EnableServiceRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildEnableServiceRequest();
      var od = new api.EnableServiceRequest.fromJson(o.toJson());
      checkEnableServiceRequest(od);
    });
  });

  unittest.group("obj-schema-EnableServiceResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildEnableServiceResponse();
      var od = new api.EnableServiceResponse.fromJson(o.toJson());
      checkEnableServiceResponse(od);
    });
  });

  unittest.group("obj-schema-Endpoint", () {
    unittest.test("to-json--from-json", () {
      var o = buildEndpoint();
      var od = new api.Endpoint.fromJson(o.toJson());
      checkEndpoint(od);
    });
  });

  unittest.group("obj-schema-Enum", () {
    unittest.test("to-json--from-json", () {
      var o = buildEnum();
      var od = new api.Enum.fromJson(o.toJson());
      checkEnum(od);
    });
  });

  unittest.group("obj-schema-EnumValue", () {
    unittest.test("to-json--from-json", () {
      var o = buildEnumValue();
      var od = new api.EnumValue.fromJson(o.toJson());
      checkEnumValue(od);
    });
  });

  unittest.group("obj-schema-Experimental", () {
    unittest.test("to-json--from-json", () {
      var o = buildExperimental();
      var od = new api.Experimental.fromJson(o.toJson());
      checkExperimental(od);
    });
  });

  unittest.group("obj-schema-Field", () {
    unittest.test("to-json--from-json", () {
      var o = buildField();
      var od = new api.Field.fromJson(o.toJson());
      checkField(od);
    });
  });

  unittest.group("obj-schema-GoogleApiService", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleApiService();
      var od = new api.GoogleApiService.fromJson(o.toJson());
      checkGoogleApiService(od);
    });
  });

  unittest.group("obj-schema-GoogleApiServiceusageV1OperationMetadata", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleApiServiceusageV1OperationMetadata();
      var od =
          new api.GoogleApiServiceusageV1OperationMetadata.fromJson(o.toJson());
      checkGoogleApiServiceusageV1OperationMetadata(od);
    });
  });

  unittest.group("obj-schema-GoogleApiServiceusageV1Service", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleApiServiceusageV1Service();
      var od = new api.GoogleApiServiceusageV1Service.fromJson(o.toJson());
      checkGoogleApiServiceusageV1Service(od);
    });
  });

  unittest.group("obj-schema-GoogleApiServiceusageV1ServiceConfig", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleApiServiceusageV1ServiceConfig();
      var od =
          new api.GoogleApiServiceusageV1ServiceConfig.fromJson(o.toJson());
      checkGoogleApiServiceusageV1ServiceConfig(od);
    });
  });

  unittest.group("obj-schema-Http", () {
    unittest.test("to-json--from-json", () {
      var o = buildHttp();
      var od = new api.Http.fromJson(o.toJson());
      checkHttp(od);
    });
  });

  unittest.group("obj-schema-HttpRule", () {
    unittest.test("to-json--from-json", () {
      var o = buildHttpRule();
      var od = new api.HttpRule.fromJson(o.toJson());
      checkHttpRule(od);
    });
  });

  unittest.group("obj-schema-LabelDescriptor", () {
    unittest.test("to-json--from-json", () {
      var o = buildLabelDescriptor();
      var od = new api.LabelDescriptor.fromJson(o.toJson());
      checkLabelDescriptor(od);
    });
  });

  unittest.group("obj-schema-ListOperationsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListOperationsResponse();
      var od = new api.ListOperationsResponse.fromJson(o.toJson());
      checkListOperationsResponse(od);
    });
  });

  unittest.group("obj-schema-ListServicesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListServicesResponse();
      var od = new api.ListServicesResponse.fromJson(o.toJson());
      checkListServicesResponse(od);
    });
  });

  unittest.group("obj-schema-LogDescriptor", () {
    unittest.test("to-json--from-json", () {
      var o = buildLogDescriptor();
      var od = new api.LogDescriptor.fromJson(o.toJson());
      checkLogDescriptor(od);
    });
  });

  unittest.group("obj-schema-Logging", () {
    unittest.test("to-json--from-json", () {
      var o = buildLogging();
      var od = new api.Logging.fromJson(o.toJson());
      checkLogging(od);
    });
  });

  unittest.group("obj-schema-LoggingDestination", () {
    unittest.test("to-json--from-json", () {
      var o = buildLoggingDestination();
      var od = new api.LoggingDestination.fromJson(o.toJson());
      checkLoggingDestination(od);
    });
  });

  unittest.group("obj-schema-Method", () {
    unittest.test("to-json--from-json", () {
      var o = buildMethod();
      var od = new api.Method.fromJson(o.toJson());
      checkMethod(od);
    });
  });

  unittest.group("obj-schema-MetricDescriptor", () {
    unittest.test("to-json--from-json", () {
      var o = buildMetricDescriptor();
      var od = new api.MetricDescriptor.fromJson(o.toJson());
      checkMetricDescriptor(od);
    });
  });

  unittest.group("obj-schema-MetricDescriptorMetadata", () {
    unittest.test("to-json--from-json", () {
      var o = buildMetricDescriptorMetadata();
      var od = new api.MetricDescriptorMetadata.fromJson(o.toJson());
      checkMetricDescriptorMetadata(od);
    });
  });

  unittest.group("obj-schema-MetricRule", () {
    unittest.test("to-json--from-json", () {
      var o = buildMetricRule();
      var od = new api.MetricRule.fromJson(o.toJson());
      checkMetricRule(od);
    });
  });

  unittest.group("obj-schema-Mixin", () {
    unittest.test("to-json--from-json", () {
      var o = buildMixin();
      var od = new api.Mixin.fromJson(o.toJson());
      checkMixin(od);
    });
  });

  unittest.group("obj-schema-MonitoredResourceDescriptor", () {
    unittest.test("to-json--from-json", () {
      var o = buildMonitoredResourceDescriptor();
      var od = new api.MonitoredResourceDescriptor.fromJson(o.toJson());
      checkMonitoredResourceDescriptor(od);
    });
  });

  unittest.group("obj-schema-Monitoring", () {
    unittest.test("to-json--from-json", () {
      var o = buildMonitoring();
      var od = new api.Monitoring.fromJson(o.toJson());
      checkMonitoring(od);
    });
  });

  unittest.group("obj-schema-MonitoringDestination", () {
    unittest.test("to-json--from-json", () {
      var o = buildMonitoringDestination();
      var od = new api.MonitoringDestination.fromJson(o.toJson());
      checkMonitoringDestination(od);
    });
  });

  unittest.group("obj-schema-OAuthRequirements", () {
    unittest.test("to-json--from-json", () {
      var o = buildOAuthRequirements();
      var od = new api.OAuthRequirements.fromJson(o.toJson());
      checkOAuthRequirements(od);
    });
  });

  unittest.group("obj-schema-Operation", () {
    unittest.test("to-json--from-json", () {
      var o = buildOperation();
      var od = new api.Operation.fromJson(o.toJson());
      checkOperation(od);
    });
  });

  unittest.group("obj-schema-OperationMetadata", () {
    unittest.test("to-json--from-json", () {
      var o = buildOperationMetadata();
      var od = new api.OperationMetadata.fromJson(o.toJson());
      checkOperationMetadata(od);
    });
  });

  unittest.group("obj-schema-Option", () {
    unittest.test("to-json--from-json", () {
      var o = buildOption();
      var od = new api.Option.fromJson(o.toJson());
      checkOption(od);
    });
  });

  unittest.group("obj-schema-Page", () {
    unittest.test("to-json--from-json", () {
      var o = buildPage();
      var od = new api.Page.fromJson(o.toJson());
      checkPage(od);
    });
  });

  unittest.group("obj-schema-Quota", () {
    unittest.test("to-json--from-json", () {
      var o = buildQuota();
      var od = new api.Quota.fromJson(o.toJson());
      checkQuota(od);
    });
  });

  unittest.group("obj-schema-QuotaLimit", () {
    unittest.test("to-json--from-json", () {
      var o = buildQuotaLimit();
      var od = new api.QuotaLimit.fromJson(o.toJson());
      checkQuotaLimit(od);
    });
  });

  unittest.group("obj-schema-SourceContext", () {
    unittest.test("to-json--from-json", () {
      var o = buildSourceContext();
      var od = new api.SourceContext.fromJson(o.toJson());
      checkSourceContext(od);
    });
  });

  unittest.group("obj-schema-SourceInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildSourceInfo();
      var od = new api.SourceInfo.fromJson(o.toJson());
      checkSourceInfo(od);
    });
  });

  unittest.group("obj-schema-Status", () {
    unittest.test("to-json--from-json", () {
      var o = buildStatus();
      var od = new api.Status.fromJson(o.toJson());
      checkStatus(od);
    });
  });

  unittest.group("obj-schema-SystemParameter", () {
    unittest.test("to-json--from-json", () {
      var o = buildSystemParameter();
      var od = new api.SystemParameter.fromJson(o.toJson());
      checkSystemParameter(od);
    });
  });

  unittest.group("obj-schema-SystemParameterRule", () {
    unittest.test("to-json--from-json", () {
      var o = buildSystemParameterRule();
      var od = new api.SystemParameterRule.fromJson(o.toJson());
      checkSystemParameterRule(od);
    });
  });

  unittest.group("obj-schema-SystemParameters", () {
    unittest.test("to-json--from-json", () {
      var o = buildSystemParameters();
      var od = new api.SystemParameters.fromJson(o.toJson());
      checkSystemParameters(od);
    });
  });

  unittest.group("obj-schema-Type", () {
    unittest.test("to-json--from-json", () {
      var o = buildType();
      var od = new api.Type.fromJson(o.toJson());
      checkType(od);
    });
  });

  unittest.group("obj-schema-Usage", () {
    unittest.test("to-json--from-json", () {
      var o = buildUsage();
      var od = new api.Usage.fromJson(o.toJson());
      checkUsage(od);
    });
  });

  unittest.group("obj-schema-UsageRule", () {
    unittest.test("to-json--from-json", () {
      var o = buildUsageRule();
      var od = new api.UsageRule.fromJson(o.toJson());
      checkUsageRule(od);
    });
  });

  unittest.group("resource-OperationsResourceApi", () {
    unittest.test("method--cancel", () {
      var mock = new HttpServerMock();
      api.OperationsResourceApi res = new api.ServiceusageApi(mock).operations;
      var arg_request = buildCancelOperationRequest();
      var arg_name = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.CancelOperationRequest.fromJson(json);
        checkCancelOperationRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 3), unittest.equals("v1/"));
        pathOffset += 3;
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
        var resp = convert.json.encode(buildEmpty());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .cancel(arg_request, arg_name, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkEmpty(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.OperationsResourceApi res = new api.ServiceusageApi(mock).operations;
      var arg_name = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 3), unittest.equals("v1/"));
        pathOffset += 3;
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
        var resp = convert.json.encode(buildEmpty());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_name, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkEmpty(response);
      })));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.OperationsResourceApi res = new api.ServiceusageApi(mock).operations;
      var arg_name = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 3), unittest.equals("v1/"));
        pathOffset += 3;
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
        var resp = convert.json.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_name, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.OperationsResourceApi res = new api.ServiceusageApi(mock).operations;
      var arg_pageSize = 42;
      var arg_filter = "foo";
      var arg_name = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 13),
            unittest.equals("v1/operations"));
        pathOffset += 13;

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
        unittest.expect(queryMap["filter"].first, unittest.equals(arg_filter));
        unittest.expect(queryMap["name"].first, unittest.equals(arg_name));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildListOperationsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(
              pageSize: arg_pageSize,
              filter: arg_filter,
              name: arg_name,
              pageToken: arg_pageToken,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkListOperationsResponse(response);
      })));
    });
  });

  unittest.group("resource-ServicesResourceApi", () {
    unittest.test("method--batchEnable", () {
      var mock = new HttpServerMock();
      api.ServicesResourceApi res = new api.ServiceusageApi(mock).services;
      var arg_request = buildBatchEnableServicesRequest();
      var arg_parent = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.BatchEnableServicesRequest.fromJson(json);
        checkBatchEnableServicesRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 3), unittest.equals("v1/"));
        pathOffset += 3;
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
        var resp = convert.json.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .batchEnable(arg_request, arg_parent, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--disable", () {
      var mock = new HttpServerMock();
      api.ServicesResourceApi res = new api.ServiceusageApi(mock).services;
      var arg_request = buildDisableServiceRequest();
      var arg_name = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.DisableServiceRequest.fromJson(json);
        checkDisableServiceRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 3), unittest.equals("v1/"));
        pathOffset += 3;
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
        var resp = convert.json.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .disable(arg_request, arg_name, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--enable", () {
      var mock = new HttpServerMock();
      api.ServicesResourceApi res = new api.ServiceusageApi(mock).services;
      var arg_request = buildEnableServiceRequest();
      var arg_name = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.EnableServiceRequest.fromJson(json);
        checkEnableServiceRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 3), unittest.equals("v1/"));
        pathOffset += 3;
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
        var resp = convert.json.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .enable(arg_request, arg_name, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.ServicesResourceApi res = new api.ServiceusageApi(mock).services;
      var arg_name = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 3), unittest.equals("v1/"));
        pathOffset += 3;
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
        var resp = convert.json.encode(buildGoogleApiServiceusageV1Service());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_name, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkGoogleApiServiceusageV1Service(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.ServicesResourceApi res = new api.ServiceusageApi(mock).services;
      var arg_parent = "foo";
      var arg_filter = "foo";
      var arg_pageToken = "foo";
      var arg_pageSize = 42;
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 3), unittest.equals("v1/"));
        pathOffset += 3;
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
        unittest.expect(queryMap["filter"].first, unittest.equals(arg_filter));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.int.parse(queryMap["pageSize"].first),
            unittest.equals(arg_pageSize));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildListServicesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_parent,
              filter: arg_filter,
              pageToken: arg_pageToken,
              pageSize: arg_pageSize,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkListServicesResponse(response);
      })));
    });
  });
}
