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
import 'package:googleapis/serviceusage/v1.dart' as api;

import '../test_shared.dart';

core.Map<core.String, core.String> buildUnnamed4945() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed4945(core.Map<core.String, core.String> o) {
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

core.int buildCounterAdminQuotaPolicy = 0;
api.AdminQuotaPolicy buildAdminQuotaPolicy() {
  var o = api.AdminQuotaPolicy();
  buildCounterAdminQuotaPolicy++;
  if (buildCounterAdminQuotaPolicy < 3) {
    o.container = 'foo';
    o.dimensions = buildUnnamed4945();
    o.metric = 'foo';
    o.name = 'foo';
    o.policyValue = 'foo';
    o.unit = 'foo';
  }
  buildCounterAdminQuotaPolicy--;
  return o;
}

void checkAdminQuotaPolicy(api.AdminQuotaPolicy o) {
  buildCounterAdminQuotaPolicy++;
  if (buildCounterAdminQuotaPolicy < 3) {
    unittest.expect(
      o.container!,
      unittest.equals('foo'),
    );
    checkUnnamed4945(o.dimensions!);
    unittest.expect(
      o.metric!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.policyValue!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.unit!,
      unittest.equals('foo'),
    );
  }
  buildCounterAdminQuotaPolicy--;
}

core.List<api.Method> buildUnnamed4946() {
  var o = <api.Method>[];
  o.add(buildMethod());
  o.add(buildMethod());
  return o;
}

void checkUnnamed4946(core.List<api.Method> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMethod(o[0] as api.Method);
  checkMethod(o[1] as api.Method);
}

core.List<api.Mixin> buildUnnamed4947() {
  var o = <api.Mixin>[];
  o.add(buildMixin());
  o.add(buildMixin());
  return o;
}

void checkUnnamed4947(core.List<api.Mixin> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMixin(o[0] as api.Mixin);
  checkMixin(o[1] as api.Mixin);
}

core.List<api.Option> buildUnnamed4948() {
  var o = <api.Option>[];
  o.add(buildOption());
  o.add(buildOption());
  return o;
}

void checkUnnamed4948(core.List<api.Option> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOption(o[0] as api.Option);
  checkOption(o[1] as api.Option);
}

core.int buildCounterApi = 0;
api.Api buildApi() {
  var o = api.Api();
  buildCounterApi++;
  if (buildCounterApi < 3) {
    o.methods = buildUnnamed4946();
    o.mixins = buildUnnamed4947();
    o.name = 'foo';
    o.options = buildUnnamed4948();
    o.sourceContext = buildSourceContext();
    o.syntax = 'foo';
    o.version = 'foo';
  }
  buildCounterApi--;
  return o;
}

void checkApi(api.Api o) {
  buildCounterApi++;
  if (buildCounterApi < 3) {
    checkUnnamed4946(o.methods!);
    checkUnnamed4947(o.mixins!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed4948(o.options!);
    checkSourceContext(o.sourceContext! as api.SourceContext);
    unittest.expect(
      o.syntax!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterApi--;
}

core.List<api.JwtLocation> buildUnnamed4949() {
  var o = <api.JwtLocation>[];
  o.add(buildJwtLocation());
  o.add(buildJwtLocation());
  return o;
}

void checkUnnamed4949(core.List<api.JwtLocation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkJwtLocation(o[0] as api.JwtLocation);
  checkJwtLocation(o[1] as api.JwtLocation);
}

core.int buildCounterAuthProvider = 0;
api.AuthProvider buildAuthProvider() {
  var o = api.AuthProvider();
  buildCounterAuthProvider++;
  if (buildCounterAuthProvider < 3) {
    o.audiences = 'foo';
    o.authorizationUrl = 'foo';
    o.id = 'foo';
    o.issuer = 'foo';
    o.jwksUri = 'foo';
    o.jwtLocations = buildUnnamed4949();
  }
  buildCounterAuthProvider--;
  return o;
}

void checkAuthProvider(api.AuthProvider o) {
  buildCounterAuthProvider++;
  if (buildCounterAuthProvider < 3) {
    unittest.expect(
      o.audiences!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.authorizationUrl!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.id!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.issuer!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.jwksUri!,
      unittest.equals('foo'),
    );
    checkUnnamed4949(o.jwtLocations!);
  }
  buildCounterAuthProvider--;
}

core.int buildCounterAuthRequirement = 0;
api.AuthRequirement buildAuthRequirement() {
  var o = api.AuthRequirement();
  buildCounterAuthRequirement++;
  if (buildCounterAuthRequirement < 3) {
    o.audiences = 'foo';
    o.providerId = 'foo';
  }
  buildCounterAuthRequirement--;
  return o;
}

void checkAuthRequirement(api.AuthRequirement o) {
  buildCounterAuthRequirement++;
  if (buildCounterAuthRequirement < 3) {
    unittest.expect(
      o.audiences!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.providerId!,
      unittest.equals('foo'),
    );
  }
  buildCounterAuthRequirement--;
}

core.List<api.AuthProvider> buildUnnamed4950() {
  var o = <api.AuthProvider>[];
  o.add(buildAuthProvider());
  o.add(buildAuthProvider());
  return o;
}

void checkUnnamed4950(core.List<api.AuthProvider> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAuthProvider(o[0] as api.AuthProvider);
  checkAuthProvider(o[1] as api.AuthProvider);
}

core.List<api.AuthenticationRule> buildUnnamed4951() {
  var o = <api.AuthenticationRule>[];
  o.add(buildAuthenticationRule());
  o.add(buildAuthenticationRule());
  return o;
}

void checkUnnamed4951(core.List<api.AuthenticationRule> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAuthenticationRule(o[0] as api.AuthenticationRule);
  checkAuthenticationRule(o[1] as api.AuthenticationRule);
}

core.int buildCounterAuthentication = 0;
api.Authentication buildAuthentication() {
  var o = api.Authentication();
  buildCounterAuthentication++;
  if (buildCounterAuthentication < 3) {
    o.providers = buildUnnamed4950();
    o.rules = buildUnnamed4951();
  }
  buildCounterAuthentication--;
  return o;
}

void checkAuthentication(api.Authentication o) {
  buildCounterAuthentication++;
  if (buildCounterAuthentication < 3) {
    checkUnnamed4950(o.providers!);
    checkUnnamed4951(o.rules!);
  }
  buildCounterAuthentication--;
}

core.List<api.AuthRequirement> buildUnnamed4952() {
  var o = <api.AuthRequirement>[];
  o.add(buildAuthRequirement());
  o.add(buildAuthRequirement());
  return o;
}

void checkUnnamed4952(core.List<api.AuthRequirement> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAuthRequirement(o[0] as api.AuthRequirement);
  checkAuthRequirement(o[1] as api.AuthRequirement);
}

core.int buildCounterAuthenticationRule = 0;
api.AuthenticationRule buildAuthenticationRule() {
  var o = api.AuthenticationRule();
  buildCounterAuthenticationRule++;
  if (buildCounterAuthenticationRule < 3) {
    o.allowWithoutCredential = true;
    o.oauth = buildOAuthRequirements();
    o.requirements = buildUnnamed4952();
    o.selector = 'foo';
  }
  buildCounterAuthenticationRule--;
  return o;
}

void checkAuthenticationRule(api.AuthenticationRule o) {
  buildCounterAuthenticationRule++;
  if (buildCounterAuthenticationRule < 3) {
    unittest.expect(o.allowWithoutCredential!, unittest.isTrue);
    checkOAuthRequirements(o.oauth! as api.OAuthRequirements);
    checkUnnamed4952(o.requirements!);
    unittest.expect(
      o.selector!,
      unittest.equals('foo'),
    );
  }
  buildCounterAuthenticationRule--;
}

core.List<api.BackendRule> buildUnnamed4953() {
  var o = <api.BackendRule>[];
  o.add(buildBackendRule());
  o.add(buildBackendRule());
  return o;
}

void checkUnnamed4953(core.List<api.BackendRule> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBackendRule(o[0] as api.BackendRule);
  checkBackendRule(o[1] as api.BackendRule);
}

core.int buildCounterBackend = 0;
api.Backend buildBackend() {
  var o = api.Backend();
  buildCounterBackend++;
  if (buildCounterBackend < 3) {
    o.rules = buildUnnamed4953();
  }
  buildCounterBackend--;
  return o;
}

void checkBackend(api.Backend o) {
  buildCounterBackend++;
  if (buildCounterBackend < 3) {
    checkUnnamed4953(o.rules!);
  }
  buildCounterBackend--;
}

core.int buildCounterBackendRule = 0;
api.BackendRule buildBackendRule() {
  var o = api.BackendRule();
  buildCounterBackendRule++;
  if (buildCounterBackendRule < 3) {
    o.address = 'foo';
    o.deadline = 42.0;
    o.disableAuth = true;
    o.jwtAudience = 'foo';
    o.minDeadline = 42.0;
    o.operationDeadline = 42.0;
    o.pathTranslation = 'foo';
    o.protocol = 'foo';
    o.selector = 'foo';
  }
  buildCounterBackendRule--;
  return o;
}

void checkBackendRule(api.BackendRule o) {
  buildCounterBackendRule++;
  if (buildCounterBackendRule < 3) {
    unittest.expect(
      o.address!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.deadline!,
      unittest.equals(42.0),
    );
    unittest.expect(o.disableAuth!, unittest.isTrue);
    unittest.expect(
      o.jwtAudience!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.minDeadline!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.operationDeadline!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.pathTranslation!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.protocol!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.selector!,
      unittest.equals('foo'),
    );
  }
  buildCounterBackendRule--;
}

core.List<api.QuotaOverride> buildUnnamed4954() {
  var o = <api.QuotaOverride>[];
  o.add(buildQuotaOverride());
  o.add(buildQuotaOverride());
  return o;
}

void checkUnnamed4954(core.List<api.QuotaOverride> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkQuotaOverride(o[0] as api.QuotaOverride);
  checkQuotaOverride(o[1] as api.QuotaOverride);
}

core.int buildCounterBatchCreateAdminOverridesResponse = 0;
api.BatchCreateAdminOverridesResponse buildBatchCreateAdminOverridesResponse() {
  var o = api.BatchCreateAdminOverridesResponse();
  buildCounterBatchCreateAdminOverridesResponse++;
  if (buildCounterBatchCreateAdminOverridesResponse < 3) {
    o.overrides = buildUnnamed4954();
  }
  buildCounterBatchCreateAdminOverridesResponse--;
  return o;
}

void checkBatchCreateAdminOverridesResponse(
    api.BatchCreateAdminOverridesResponse o) {
  buildCounterBatchCreateAdminOverridesResponse++;
  if (buildCounterBatchCreateAdminOverridesResponse < 3) {
    checkUnnamed4954(o.overrides!);
  }
  buildCounterBatchCreateAdminOverridesResponse--;
}

core.List<api.QuotaOverride> buildUnnamed4955() {
  var o = <api.QuotaOverride>[];
  o.add(buildQuotaOverride());
  o.add(buildQuotaOverride());
  return o;
}

void checkUnnamed4955(core.List<api.QuotaOverride> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkQuotaOverride(o[0] as api.QuotaOverride);
  checkQuotaOverride(o[1] as api.QuotaOverride);
}

core.int buildCounterBatchCreateConsumerOverridesResponse = 0;
api.BatchCreateConsumerOverridesResponse
    buildBatchCreateConsumerOverridesResponse() {
  var o = api.BatchCreateConsumerOverridesResponse();
  buildCounterBatchCreateConsumerOverridesResponse++;
  if (buildCounterBatchCreateConsumerOverridesResponse < 3) {
    o.overrides = buildUnnamed4955();
  }
  buildCounterBatchCreateConsumerOverridesResponse--;
  return o;
}

void checkBatchCreateConsumerOverridesResponse(
    api.BatchCreateConsumerOverridesResponse o) {
  buildCounterBatchCreateConsumerOverridesResponse++;
  if (buildCounterBatchCreateConsumerOverridesResponse < 3) {
    checkUnnamed4955(o.overrides!);
  }
  buildCounterBatchCreateConsumerOverridesResponse--;
}

core.List<core.String> buildUnnamed4956() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4956(core.List<core.String> o) {
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

core.int buildCounterBatchEnableServicesRequest = 0;
api.BatchEnableServicesRequest buildBatchEnableServicesRequest() {
  var o = api.BatchEnableServicesRequest();
  buildCounterBatchEnableServicesRequest++;
  if (buildCounterBatchEnableServicesRequest < 3) {
    o.serviceIds = buildUnnamed4956();
  }
  buildCounterBatchEnableServicesRequest--;
  return o;
}

void checkBatchEnableServicesRequest(api.BatchEnableServicesRequest o) {
  buildCounterBatchEnableServicesRequest++;
  if (buildCounterBatchEnableServicesRequest < 3) {
    checkUnnamed4956(o.serviceIds!);
  }
  buildCounterBatchEnableServicesRequest--;
}

core.List<api.EnableFailure> buildUnnamed4957() {
  var o = <api.EnableFailure>[];
  o.add(buildEnableFailure());
  o.add(buildEnableFailure());
  return o;
}

void checkUnnamed4957(core.List<api.EnableFailure> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEnableFailure(o[0] as api.EnableFailure);
  checkEnableFailure(o[1] as api.EnableFailure);
}

core.List<api.GoogleApiServiceusageV1Service> buildUnnamed4958() {
  var o = <api.GoogleApiServiceusageV1Service>[];
  o.add(buildGoogleApiServiceusageV1Service());
  o.add(buildGoogleApiServiceusageV1Service());
  return o;
}

void checkUnnamed4958(core.List<api.GoogleApiServiceusageV1Service> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleApiServiceusageV1Service(
      o[0] as api.GoogleApiServiceusageV1Service);
  checkGoogleApiServiceusageV1Service(
      o[1] as api.GoogleApiServiceusageV1Service);
}

core.int buildCounterBatchEnableServicesResponse = 0;
api.BatchEnableServicesResponse buildBatchEnableServicesResponse() {
  var o = api.BatchEnableServicesResponse();
  buildCounterBatchEnableServicesResponse++;
  if (buildCounterBatchEnableServicesResponse < 3) {
    o.failures = buildUnnamed4957();
    o.services = buildUnnamed4958();
  }
  buildCounterBatchEnableServicesResponse--;
  return o;
}

void checkBatchEnableServicesResponse(api.BatchEnableServicesResponse o) {
  buildCounterBatchEnableServicesResponse++;
  if (buildCounterBatchEnableServicesResponse < 3) {
    checkUnnamed4957(o.failures!);
    checkUnnamed4958(o.services!);
  }
  buildCounterBatchEnableServicesResponse--;
}

core.List<api.GoogleApiServiceusageV1Service> buildUnnamed4959() {
  var o = <api.GoogleApiServiceusageV1Service>[];
  o.add(buildGoogleApiServiceusageV1Service());
  o.add(buildGoogleApiServiceusageV1Service());
  return o;
}

void checkUnnamed4959(core.List<api.GoogleApiServiceusageV1Service> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleApiServiceusageV1Service(
      o[0] as api.GoogleApiServiceusageV1Service);
  checkGoogleApiServiceusageV1Service(
      o[1] as api.GoogleApiServiceusageV1Service);
}

core.int buildCounterBatchGetServicesResponse = 0;
api.BatchGetServicesResponse buildBatchGetServicesResponse() {
  var o = api.BatchGetServicesResponse();
  buildCounterBatchGetServicesResponse++;
  if (buildCounterBatchGetServicesResponse < 3) {
    o.services = buildUnnamed4959();
  }
  buildCounterBatchGetServicesResponse--;
  return o;
}

void checkBatchGetServicesResponse(api.BatchGetServicesResponse o) {
  buildCounterBatchGetServicesResponse++;
  if (buildCounterBatchGetServicesResponse < 3) {
    checkUnnamed4959(o.services!);
  }
  buildCounterBatchGetServicesResponse--;
}

core.List<api.BillingDestination> buildUnnamed4960() {
  var o = <api.BillingDestination>[];
  o.add(buildBillingDestination());
  o.add(buildBillingDestination());
  return o;
}

void checkUnnamed4960(core.List<api.BillingDestination> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBillingDestination(o[0] as api.BillingDestination);
  checkBillingDestination(o[1] as api.BillingDestination);
}

core.int buildCounterBilling = 0;
api.Billing buildBilling() {
  var o = api.Billing();
  buildCounterBilling++;
  if (buildCounterBilling < 3) {
    o.consumerDestinations = buildUnnamed4960();
  }
  buildCounterBilling--;
  return o;
}

void checkBilling(api.Billing o) {
  buildCounterBilling++;
  if (buildCounterBilling < 3) {
    checkUnnamed4960(o.consumerDestinations!);
  }
  buildCounterBilling--;
}

core.List<core.String> buildUnnamed4961() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4961(core.List<core.String> o) {
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

core.int buildCounterBillingDestination = 0;
api.BillingDestination buildBillingDestination() {
  var o = api.BillingDestination();
  buildCounterBillingDestination++;
  if (buildCounterBillingDestination < 3) {
    o.metrics = buildUnnamed4961();
    o.monitoredResource = 'foo';
  }
  buildCounterBillingDestination--;
  return o;
}

void checkBillingDestination(api.BillingDestination o) {
  buildCounterBillingDestination++;
  if (buildCounterBillingDestination < 3) {
    checkUnnamed4961(o.metrics!);
    unittest.expect(
      o.monitoredResource!,
      unittest.equals('foo'),
    );
  }
  buildCounterBillingDestination--;
}

core.int buildCounterCancelOperationRequest = 0;
api.CancelOperationRequest buildCancelOperationRequest() {
  var o = api.CancelOperationRequest();
  buildCounterCancelOperationRequest++;
  if (buildCounterCancelOperationRequest < 3) {}
  buildCounterCancelOperationRequest--;
  return o;
}

void checkCancelOperationRequest(api.CancelOperationRequest o) {
  buildCounterCancelOperationRequest++;
  if (buildCounterCancelOperationRequest < 3) {}
  buildCounterCancelOperationRequest--;
}

core.List<api.ContextRule> buildUnnamed4962() {
  var o = <api.ContextRule>[];
  o.add(buildContextRule());
  o.add(buildContextRule());
  return o;
}

void checkUnnamed4962(core.List<api.ContextRule> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkContextRule(o[0] as api.ContextRule);
  checkContextRule(o[1] as api.ContextRule);
}

core.int buildCounterContext = 0;
api.Context buildContext() {
  var o = api.Context();
  buildCounterContext++;
  if (buildCounterContext < 3) {
    o.rules = buildUnnamed4962();
  }
  buildCounterContext--;
  return o;
}

void checkContext(api.Context o) {
  buildCounterContext++;
  if (buildCounterContext < 3) {
    checkUnnamed4962(o.rules!);
  }
  buildCounterContext--;
}

core.List<core.String> buildUnnamed4963() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4963(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed4964() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4964(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed4965() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4965(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed4966() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4966(core.List<core.String> o) {
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

core.int buildCounterContextRule = 0;
api.ContextRule buildContextRule() {
  var o = api.ContextRule();
  buildCounterContextRule++;
  if (buildCounterContextRule < 3) {
    o.allowedRequestExtensions = buildUnnamed4963();
    o.allowedResponseExtensions = buildUnnamed4964();
    o.provided = buildUnnamed4965();
    o.requested = buildUnnamed4966();
    o.selector = 'foo';
  }
  buildCounterContextRule--;
  return o;
}

void checkContextRule(api.ContextRule o) {
  buildCounterContextRule++;
  if (buildCounterContextRule < 3) {
    checkUnnamed4963(o.allowedRequestExtensions!);
    checkUnnamed4964(o.allowedResponseExtensions!);
    checkUnnamed4965(o.provided!);
    checkUnnamed4966(o.requested!);
    unittest.expect(
      o.selector!,
      unittest.equals('foo'),
    );
  }
  buildCounterContextRule--;
}

core.int buildCounterControl = 0;
api.Control buildControl() {
  var o = api.Control();
  buildCounterControl++;
  if (buildCounterControl < 3) {
    o.environment = 'foo';
  }
  buildCounterControl--;
  return o;
}

void checkControl(api.Control o) {
  buildCounterControl++;
  if (buildCounterControl < 3) {
    unittest.expect(
      o.environment!,
      unittest.equals('foo'),
    );
  }
  buildCounterControl--;
}

core.List<api.CustomErrorRule> buildUnnamed4967() {
  var o = <api.CustomErrorRule>[];
  o.add(buildCustomErrorRule());
  o.add(buildCustomErrorRule());
  return o;
}

void checkUnnamed4967(core.List<api.CustomErrorRule> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCustomErrorRule(o[0] as api.CustomErrorRule);
  checkCustomErrorRule(o[1] as api.CustomErrorRule);
}

core.List<core.String> buildUnnamed4968() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4968(core.List<core.String> o) {
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

core.int buildCounterCustomError = 0;
api.CustomError buildCustomError() {
  var o = api.CustomError();
  buildCounterCustomError++;
  if (buildCounterCustomError < 3) {
    o.rules = buildUnnamed4967();
    o.types = buildUnnamed4968();
  }
  buildCounterCustomError--;
  return o;
}

void checkCustomError(api.CustomError o) {
  buildCounterCustomError++;
  if (buildCounterCustomError < 3) {
    checkUnnamed4967(o.rules!);
    checkUnnamed4968(o.types!);
  }
  buildCounterCustomError--;
}

core.int buildCounterCustomErrorRule = 0;
api.CustomErrorRule buildCustomErrorRule() {
  var o = api.CustomErrorRule();
  buildCounterCustomErrorRule++;
  if (buildCounterCustomErrorRule < 3) {
    o.isErrorType = true;
    o.selector = 'foo';
  }
  buildCounterCustomErrorRule--;
  return o;
}

void checkCustomErrorRule(api.CustomErrorRule o) {
  buildCounterCustomErrorRule++;
  if (buildCounterCustomErrorRule < 3) {
    unittest.expect(o.isErrorType!, unittest.isTrue);
    unittest.expect(
      o.selector!,
      unittest.equals('foo'),
    );
  }
  buildCounterCustomErrorRule--;
}

core.int buildCounterCustomHttpPattern = 0;
api.CustomHttpPattern buildCustomHttpPattern() {
  var o = api.CustomHttpPattern();
  buildCounterCustomHttpPattern++;
  if (buildCounterCustomHttpPattern < 3) {
    o.kind = 'foo';
    o.path = 'foo';
  }
  buildCounterCustomHttpPattern--;
  return o;
}

void checkCustomHttpPattern(api.CustomHttpPattern o) {
  buildCounterCustomHttpPattern++;
  if (buildCounterCustomHttpPattern < 3) {
    unittest.expect(
      o.kind!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.path!,
      unittest.equals('foo'),
    );
  }
  buildCounterCustomHttpPattern--;
}

core.int buildCounterDisableServiceRequest = 0;
api.DisableServiceRequest buildDisableServiceRequest() {
  var o = api.DisableServiceRequest();
  buildCounterDisableServiceRequest++;
  if (buildCounterDisableServiceRequest < 3) {
    o.checkIfServiceHasUsage = 'foo';
    o.disableDependentServices = true;
  }
  buildCounterDisableServiceRequest--;
  return o;
}

void checkDisableServiceRequest(api.DisableServiceRequest o) {
  buildCounterDisableServiceRequest++;
  if (buildCounterDisableServiceRequest < 3) {
    unittest.expect(
      o.checkIfServiceHasUsage!,
      unittest.equals('foo'),
    );
    unittest.expect(o.disableDependentServices!, unittest.isTrue);
  }
  buildCounterDisableServiceRequest--;
}

core.int buildCounterDisableServiceResponse = 0;
api.DisableServiceResponse buildDisableServiceResponse() {
  var o = api.DisableServiceResponse();
  buildCounterDisableServiceResponse++;
  if (buildCounterDisableServiceResponse < 3) {
    o.service = buildGoogleApiServiceusageV1Service();
  }
  buildCounterDisableServiceResponse--;
  return o;
}

void checkDisableServiceResponse(api.DisableServiceResponse o) {
  buildCounterDisableServiceResponse++;
  if (buildCounterDisableServiceResponse < 3) {
    checkGoogleApiServiceusageV1Service(
        o.service! as api.GoogleApiServiceusageV1Service);
  }
  buildCounterDisableServiceResponse--;
}

core.List<api.Page> buildUnnamed4969() {
  var o = <api.Page>[];
  o.add(buildPage());
  o.add(buildPage());
  return o;
}

void checkUnnamed4969(core.List<api.Page> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPage(o[0] as api.Page);
  checkPage(o[1] as api.Page);
}

core.List<api.DocumentationRule> buildUnnamed4970() {
  var o = <api.DocumentationRule>[];
  o.add(buildDocumentationRule());
  o.add(buildDocumentationRule());
  return o;
}

void checkUnnamed4970(core.List<api.DocumentationRule> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDocumentationRule(o[0] as api.DocumentationRule);
  checkDocumentationRule(o[1] as api.DocumentationRule);
}

core.int buildCounterDocumentation = 0;
api.Documentation buildDocumentation() {
  var o = api.Documentation();
  buildCounterDocumentation++;
  if (buildCounterDocumentation < 3) {
    o.documentationRootUrl = 'foo';
    o.overview = 'foo';
    o.pages = buildUnnamed4969();
    o.rules = buildUnnamed4970();
    o.serviceRootUrl = 'foo';
    o.summary = 'foo';
  }
  buildCounterDocumentation--;
  return o;
}

void checkDocumentation(api.Documentation o) {
  buildCounterDocumentation++;
  if (buildCounterDocumentation < 3) {
    unittest.expect(
      o.documentationRootUrl!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.overview!,
      unittest.equals('foo'),
    );
    checkUnnamed4969(o.pages!);
    checkUnnamed4970(o.rules!);
    unittest.expect(
      o.serviceRootUrl!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.summary!,
      unittest.equals('foo'),
    );
  }
  buildCounterDocumentation--;
}

core.int buildCounterDocumentationRule = 0;
api.DocumentationRule buildDocumentationRule() {
  var o = api.DocumentationRule();
  buildCounterDocumentationRule++;
  if (buildCounterDocumentationRule < 3) {
    o.deprecationDescription = 'foo';
    o.description = 'foo';
    o.selector = 'foo';
  }
  buildCounterDocumentationRule--;
  return o;
}

void checkDocumentationRule(api.DocumentationRule o) {
  buildCounterDocumentationRule++;
  if (buildCounterDocumentationRule < 3) {
    unittest.expect(
      o.deprecationDescription!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.selector!,
      unittest.equals('foo'),
    );
  }
  buildCounterDocumentationRule--;
}

core.int buildCounterEmpty = 0;
api.Empty buildEmpty() {
  var o = api.Empty();
  buildCounterEmpty++;
  if (buildCounterEmpty < 3) {}
  buildCounterEmpty--;
  return o;
}

void checkEmpty(api.Empty o) {
  buildCounterEmpty++;
  if (buildCounterEmpty < 3) {}
  buildCounterEmpty--;
}

core.int buildCounterEnableFailure = 0;
api.EnableFailure buildEnableFailure() {
  var o = api.EnableFailure();
  buildCounterEnableFailure++;
  if (buildCounterEnableFailure < 3) {
    o.errorMessage = 'foo';
    o.serviceId = 'foo';
  }
  buildCounterEnableFailure--;
  return o;
}

void checkEnableFailure(api.EnableFailure o) {
  buildCounterEnableFailure++;
  if (buildCounterEnableFailure < 3) {
    unittest.expect(
      o.errorMessage!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.serviceId!,
      unittest.equals('foo'),
    );
  }
  buildCounterEnableFailure--;
}

core.int buildCounterEnableServiceRequest = 0;
api.EnableServiceRequest buildEnableServiceRequest() {
  var o = api.EnableServiceRequest();
  buildCounterEnableServiceRequest++;
  if (buildCounterEnableServiceRequest < 3) {}
  buildCounterEnableServiceRequest--;
  return o;
}

void checkEnableServiceRequest(api.EnableServiceRequest o) {
  buildCounterEnableServiceRequest++;
  if (buildCounterEnableServiceRequest < 3) {}
  buildCounterEnableServiceRequest--;
}

core.int buildCounterEnableServiceResponse = 0;
api.EnableServiceResponse buildEnableServiceResponse() {
  var o = api.EnableServiceResponse();
  buildCounterEnableServiceResponse++;
  if (buildCounterEnableServiceResponse < 3) {
    o.service = buildGoogleApiServiceusageV1Service();
  }
  buildCounterEnableServiceResponse--;
  return o;
}

void checkEnableServiceResponse(api.EnableServiceResponse o) {
  buildCounterEnableServiceResponse++;
  if (buildCounterEnableServiceResponse < 3) {
    checkGoogleApiServiceusageV1Service(
        o.service! as api.GoogleApiServiceusageV1Service);
  }
  buildCounterEnableServiceResponse--;
}

core.List<core.String> buildUnnamed4971() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4971(core.List<core.String> o) {
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

core.int buildCounterEndpoint = 0;
api.Endpoint buildEndpoint() {
  var o = api.Endpoint();
  buildCounterEndpoint++;
  if (buildCounterEndpoint < 3) {
    o.aliases = buildUnnamed4971();
    o.allowCors = true;
    o.name = 'foo';
    o.target = 'foo';
  }
  buildCounterEndpoint--;
  return o;
}

void checkEndpoint(api.Endpoint o) {
  buildCounterEndpoint++;
  if (buildCounterEndpoint < 3) {
    checkUnnamed4971(o.aliases!);
    unittest.expect(o.allowCors!, unittest.isTrue);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.target!,
      unittest.equals('foo'),
    );
  }
  buildCounterEndpoint--;
}

core.List<api.EnumValue> buildUnnamed4972() {
  var o = <api.EnumValue>[];
  o.add(buildEnumValue());
  o.add(buildEnumValue());
  return o;
}

void checkUnnamed4972(core.List<api.EnumValue> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEnumValue(o[0] as api.EnumValue);
  checkEnumValue(o[1] as api.EnumValue);
}

core.List<api.Option> buildUnnamed4973() {
  var o = <api.Option>[];
  o.add(buildOption());
  o.add(buildOption());
  return o;
}

void checkUnnamed4973(core.List<api.Option> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOption(o[0] as api.Option);
  checkOption(o[1] as api.Option);
}

core.int buildCounterEnum = 0;
api.Enum buildEnum() {
  var o = api.Enum();
  buildCounterEnum++;
  if (buildCounterEnum < 3) {
    o.enumvalue = buildUnnamed4972();
    o.name = 'foo';
    o.options = buildUnnamed4973();
    o.sourceContext = buildSourceContext();
    o.syntax = 'foo';
  }
  buildCounterEnum--;
  return o;
}

void checkEnum(api.Enum o) {
  buildCounterEnum++;
  if (buildCounterEnum < 3) {
    checkUnnamed4972(o.enumvalue!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed4973(o.options!);
    checkSourceContext(o.sourceContext! as api.SourceContext);
    unittest.expect(
      o.syntax!,
      unittest.equals('foo'),
    );
  }
  buildCounterEnum--;
}

core.List<api.Option> buildUnnamed4974() {
  var o = <api.Option>[];
  o.add(buildOption());
  o.add(buildOption());
  return o;
}

void checkUnnamed4974(core.List<api.Option> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOption(o[0] as api.Option);
  checkOption(o[1] as api.Option);
}

core.int buildCounterEnumValue = 0;
api.EnumValue buildEnumValue() {
  var o = api.EnumValue();
  buildCounterEnumValue++;
  if (buildCounterEnumValue < 3) {
    o.name = 'foo';
    o.number = 42;
    o.options = buildUnnamed4974();
  }
  buildCounterEnumValue--;
  return o;
}

void checkEnumValue(api.EnumValue o) {
  buildCounterEnumValue++;
  if (buildCounterEnumValue < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.number!,
      unittest.equals(42),
    );
    checkUnnamed4974(o.options!);
  }
  buildCounterEnumValue--;
}

core.List<api.Option> buildUnnamed4975() {
  var o = <api.Option>[];
  o.add(buildOption());
  o.add(buildOption());
  return o;
}

void checkUnnamed4975(core.List<api.Option> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOption(o[0] as api.Option);
  checkOption(o[1] as api.Option);
}

core.int buildCounterField = 0;
api.Field buildField() {
  var o = api.Field();
  buildCounterField++;
  if (buildCounterField < 3) {
    o.cardinality = 'foo';
    o.defaultValue = 'foo';
    o.jsonName = 'foo';
    o.kind = 'foo';
    o.name = 'foo';
    o.number = 42;
    o.oneofIndex = 42;
    o.options = buildUnnamed4975();
    o.packed = true;
    o.typeUrl = 'foo';
  }
  buildCounterField--;
  return o;
}

void checkField(api.Field o) {
  buildCounterField++;
  if (buildCounterField < 3) {
    unittest.expect(
      o.cardinality!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.defaultValue!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.jsonName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.kind!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.number!,
      unittest.equals(42),
    );
    unittest.expect(
      o.oneofIndex!,
      unittest.equals(42),
    );
    checkUnnamed4975(o.options!);
    unittest.expect(o.packed!, unittest.isTrue);
    unittest.expect(
      o.typeUrl!,
      unittest.equals('foo'),
    );
  }
  buildCounterField--;
}

core.int buildCounterGetServiceIdentityResponse = 0;
api.GetServiceIdentityResponse buildGetServiceIdentityResponse() {
  var o = api.GetServiceIdentityResponse();
  buildCounterGetServiceIdentityResponse++;
  if (buildCounterGetServiceIdentityResponse < 3) {
    o.identity = buildServiceIdentity();
    o.state = 'foo';
  }
  buildCounterGetServiceIdentityResponse--;
  return o;
}

void checkGetServiceIdentityResponse(api.GetServiceIdentityResponse o) {
  buildCounterGetServiceIdentityResponse++;
  if (buildCounterGetServiceIdentityResponse < 3) {
    checkServiceIdentity(o.identity! as api.ServiceIdentity);
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
  }
  buildCounterGetServiceIdentityResponse--;
}

core.List<api.Api> buildUnnamed4976() {
  var o = <api.Api>[];
  o.add(buildApi());
  o.add(buildApi());
  return o;
}

void checkUnnamed4976(core.List<api.Api> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkApi(o[0] as api.Api);
  checkApi(o[1] as api.Api);
}

core.List<api.Endpoint> buildUnnamed4977() {
  var o = <api.Endpoint>[];
  o.add(buildEndpoint());
  o.add(buildEndpoint());
  return o;
}

void checkUnnamed4977(core.List<api.Endpoint> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEndpoint(o[0] as api.Endpoint);
  checkEndpoint(o[1] as api.Endpoint);
}

core.List<api.Enum> buildUnnamed4978() {
  var o = <api.Enum>[];
  o.add(buildEnum());
  o.add(buildEnum());
  return o;
}

void checkUnnamed4978(core.List<api.Enum> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEnum(o[0] as api.Enum);
  checkEnum(o[1] as api.Enum);
}

core.List<api.LogDescriptor> buildUnnamed4979() {
  var o = <api.LogDescriptor>[];
  o.add(buildLogDescriptor());
  o.add(buildLogDescriptor());
  return o;
}

void checkUnnamed4979(core.List<api.LogDescriptor> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLogDescriptor(o[0] as api.LogDescriptor);
  checkLogDescriptor(o[1] as api.LogDescriptor);
}

core.List<api.MetricDescriptor> buildUnnamed4980() {
  var o = <api.MetricDescriptor>[];
  o.add(buildMetricDescriptor());
  o.add(buildMetricDescriptor());
  return o;
}

void checkUnnamed4980(core.List<api.MetricDescriptor> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMetricDescriptor(o[0] as api.MetricDescriptor);
  checkMetricDescriptor(o[1] as api.MetricDescriptor);
}

core.List<api.MonitoredResourceDescriptor> buildUnnamed4981() {
  var o = <api.MonitoredResourceDescriptor>[];
  o.add(buildMonitoredResourceDescriptor());
  o.add(buildMonitoredResourceDescriptor());
  return o;
}

void checkUnnamed4981(core.List<api.MonitoredResourceDescriptor> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMonitoredResourceDescriptor(o[0] as api.MonitoredResourceDescriptor);
  checkMonitoredResourceDescriptor(o[1] as api.MonitoredResourceDescriptor);
}

core.List<api.Type> buildUnnamed4982() {
  var o = <api.Type>[];
  o.add(buildType());
  o.add(buildType());
  return o;
}

void checkUnnamed4982(core.List<api.Type> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkType(o[0] as api.Type);
  checkType(o[1] as api.Type);
}

core.List<api.Type> buildUnnamed4983() {
  var o = <api.Type>[];
  o.add(buildType());
  o.add(buildType());
  return o;
}

void checkUnnamed4983(core.List<api.Type> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkType(o[0] as api.Type);
  checkType(o[1] as api.Type);
}

core.int buildCounterGoogleApiService = 0;
api.GoogleApiService buildGoogleApiService() {
  var o = api.GoogleApiService();
  buildCounterGoogleApiService++;
  if (buildCounterGoogleApiService < 3) {
    o.apis = buildUnnamed4976();
    o.authentication = buildAuthentication();
    o.backend = buildBackend();
    o.billing = buildBilling();
    o.configVersion = 42;
    o.context = buildContext();
    o.control = buildControl();
    o.customError = buildCustomError();
    o.documentation = buildDocumentation();
    o.endpoints = buildUnnamed4977();
    o.enums = buildUnnamed4978();
    o.http = buildHttp();
    o.id = 'foo';
    o.logging = buildLogging();
    o.logs = buildUnnamed4979();
    o.metrics = buildUnnamed4980();
    o.monitoredResources = buildUnnamed4981();
    o.monitoring = buildMonitoring();
    o.name = 'foo';
    o.producerProjectId = 'foo';
    o.quota = buildQuota();
    o.sourceInfo = buildSourceInfo();
    o.systemParameters = buildSystemParameters();
    o.systemTypes = buildUnnamed4982();
    o.title = 'foo';
    o.types = buildUnnamed4983();
    o.usage = buildUsage();
  }
  buildCounterGoogleApiService--;
  return o;
}

void checkGoogleApiService(api.GoogleApiService o) {
  buildCounterGoogleApiService++;
  if (buildCounterGoogleApiService < 3) {
    checkUnnamed4976(o.apis!);
    checkAuthentication(o.authentication! as api.Authentication);
    checkBackend(o.backend! as api.Backend);
    checkBilling(o.billing! as api.Billing);
    unittest.expect(
      o.configVersion!,
      unittest.equals(42),
    );
    checkContext(o.context! as api.Context);
    checkControl(o.control! as api.Control);
    checkCustomError(o.customError! as api.CustomError);
    checkDocumentation(o.documentation! as api.Documentation);
    checkUnnamed4977(o.endpoints!);
    checkUnnamed4978(o.enums!);
    checkHttp(o.http! as api.Http);
    unittest.expect(
      o.id!,
      unittest.equals('foo'),
    );
    checkLogging(o.logging! as api.Logging);
    checkUnnamed4979(o.logs!);
    checkUnnamed4980(o.metrics!);
    checkUnnamed4981(o.monitoredResources!);
    checkMonitoring(o.monitoring! as api.Monitoring);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.producerProjectId!,
      unittest.equals('foo'),
    );
    checkQuota(o.quota! as api.Quota);
    checkSourceInfo(o.sourceInfo! as api.SourceInfo);
    checkSystemParameters(o.systemParameters! as api.SystemParameters);
    checkUnnamed4982(o.systemTypes!);
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
    checkUnnamed4983(o.types!);
    checkUsage(o.usage! as api.Usage);
  }
  buildCounterGoogleApiService--;
}

core.List<core.String> buildUnnamed4984() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4984(core.List<core.String> o) {
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

core.int buildCounterGoogleApiServiceusageV1OperationMetadata = 0;
api.GoogleApiServiceusageV1OperationMetadata
    buildGoogleApiServiceusageV1OperationMetadata() {
  var o = api.GoogleApiServiceusageV1OperationMetadata();
  buildCounterGoogleApiServiceusageV1OperationMetadata++;
  if (buildCounterGoogleApiServiceusageV1OperationMetadata < 3) {
    o.resourceNames = buildUnnamed4984();
  }
  buildCounterGoogleApiServiceusageV1OperationMetadata--;
  return o;
}

void checkGoogleApiServiceusageV1OperationMetadata(
    api.GoogleApiServiceusageV1OperationMetadata o) {
  buildCounterGoogleApiServiceusageV1OperationMetadata++;
  if (buildCounterGoogleApiServiceusageV1OperationMetadata < 3) {
    checkUnnamed4984(o.resourceNames!);
  }
  buildCounterGoogleApiServiceusageV1OperationMetadata--;
}

core.int buildCounterGoogleApiServiceusageV1Service = 0;
api.GoogleApiServiceusageV1Service buildGoogleApiServiceusageV1Service() {
  var o = api.GoogleApiServiceusageV1Service();
  buildCounterGoogleApiServiceusageV1Service++;
  if (buildCounterGoogleApiServiceusageV1Service < 3) {
    o.config = buildGoogleApiServiceusageV1ServiceConfig();
    o.name = 'foo';
    o.parent = 'foo';
    o.state = 'foo';
  }
  buildCounterGoogleApiServiceusageV1Service--;
  return o;
}

void checkGoogleApiServiceusageV1Service(api.GoogleApiServiceusageV1Service o) {
  buildCounterGoogleApiServiceusageV1Service++;
  if (buildCounterGoogleApiServiceusageV1Service < 3) {
    checkGoogleApiServiceusageV1ServiceConfig(
        o.config! as api.GoogleApiServiceusageV1ServiceConfig);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.parent!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleApiServiceusageV1Service--;
}

core.List<api.Api> buildUnnamed4985() {
  var o = <api.Api>[];
  o.add(buildApi());
  o.add(buildApi());
  return o;
}

void checkUnnamed4985(core.List<api.Api> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkApi(o[0] as api.Api);
  checkApi(o[1] as api.Api);
}

core.List<api.Endpoint> buildUnnamed4986() {
  var o = <api.Endpoint>[];
  o.add(buildEndpoint());
  o.add(buildEndpoint());
  return o;
}

void checkUnnamed4986(core.List<api.Endpoint> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEndpoint(o[0] as api.Endpoint);
  checkEndpoint(o[1] as api.Endpoint);
}

core.List<api.MonitoredResourceDescriptor> buildUnnamed4987() {
  var o = <api.MonitoredResourceDescriptor>[];
  o.add(buildMonitoredResourceDescriptor());
  o.add(buildMonitoredResourceDescriptor());
  return o;
}

void checkUnnamed4987(core.List<api.MonitoredResourceDescriptor> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMonitoredResourceDescriptor(o[0] as api.MonitoredResourceDescriptor);
  checkMonitoredResourceDescriptor(o[1] as api.MonitoredResourceDescriptor);
}

core.int buildCounterGoogleApiServiceusageV1ServiceConfig = 0;
api.GoogleApiServiceusageV1ServiceConfig
    buildGoogleApiServiceusageV1ServiceConfig() {
  var o = api.GoogleApiServiceusageV1ServiceConfig();
  buildCounterGoogleApiServiceusageV1ServiceConfig++;
  if (buildCounterGoogleApiServiceusageV1ServiceConfig < 3) {
    o.apis = buildUnnamed4985();
    o.authentication = buildAuthentication();
    o.documentation = buildDocumentation();
    o.endpoints = buildUnnamed4986();
    o.monitoredResources = buildUnnamed4987();
    o.monitoring = buildMonitoring();
    o.name = 'foo';
    o.quota = buildQuota();
    o.title = 'foo';
    o.usage = buildUsage();
  }
  buildCounterGoogleApiServiceusageV1ServiceConfig--;
  return o;
}

void checkGoogleApiServiceusageV1ServiceConfig(
    api.GoogleApiServiceusageV1ServiceConfig o) {
  buildCounterGoogleApiServiceusageV1ServiceConfig++;
  if (buildCounterGoogleApiServiceusageV1ServiceConfig < 3) {
    checkUnnamed4985(o.apis!);
    checkAuthentication(o.authentication! as api.Authentication);
    checkDocumentation(o.documentation! as api.Documentation);
    checkUnnamed4986(o.endpoints!);
    checkUnnamed4987(o.monitoredResources!);
    checkMonitoring(o.monitoring! as api.Monitoring);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkQuota(o.quota! as api.Quota);
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
    checkUsage(o.usage! as api.Usage);
  }
  buildCounterGoogleApiServiceusageV1ServiceConfig--;
}

core.int buildCounterGoogleApiServiceusageV1beta1GetServiceIdentityResponse = 0;
api.GoogleApiServiceusageV1beta1GetServiceIdentityResponse
    buildGoogleApiServiceusageV1beta1GetServiceIdentityResponse() {
  var o = api.GoogleApiServiceusageV1beta1GetServiceIdentityResponse();
  buildCounterGoogleApiServiceusageV1beta1GetServiceIdentityResponse++;
  if (buildCounterGoogleApiServiceusageV1beta1GetServiceIdentityResponse < 3) {
    o.identity = buildGoogleApiServiceusageV1beta1ServiceIdentity();
    o.state = 'foo';
  }
  buildCounterGoogleApiServiceusageV1beta1GetServiceIdentityResponse--;
  return o;
}

void checkGoogleApiServiceusageV1beta1GetServiceIdentityResponse(
    api.GoogleApiServiceusageV1beta1GetServiceIdentityResponse o) {
  buildCounterGoogleApiServiceusageV1beta1GetServiceIdentityResponse++;
  if (buildCounterGoogleApiServiceusageV1beta1GetServiceIdentityResponse < 3) {
    checkGoogleApiServiceusageV1beta1ServiceIdentity(
        o.identity! as api.GoogleApiServiceusageV1beta1ServiceIdentity);
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleApiServiceusageV1beta1GetServiceIdentityResponse--;
}

core.int buildCounterGoogleApiServiceusageV1beta1ServiceIdentity = 0;
api.GoogleApiServiceusageV1beta1ServiceIdentity
    buildGoogleApiServiceusageV1beta1ServiceIdentity() {
  var o = api.GoogleApiServiceusageV1beta1ServiceIdentity();
  buildCounterGoogleApiServiceusageV1beta1ServiceIdentity++;
  if (buildCounterGoogleApiServiceusageV1beta1ServiceIdentity < 3) {
    o.email = 'foo';
    o.uniqueId = 'foo';
  }
  buildCounterGoogleApiServiceusageV1beta1ServiceIdentity--;
  return o;
}

void checkGoogleApiServiceusageV1beta1ServiceIdentity(
    api.GoogleApiServiceusageV1beta1ServiceIdentity o) {
  buildCounterGoogleApiServiceusageV1beta1ServiceIdentity++;
  if (buildCounterGoogleApiServiceusageV1beta1ServiceIdentity < 3) {
    unittest.expect(
      o.email!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.uniqueId!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleApiServiceusageV1beta1ServiceIdentity--;
}

core.List<api.HttpRule> buildUnnamed4988() {
  var o = <api.HttpRule>[];
  o.add(buildHttpRule());
  o.add(buildHttpRule());
  return o;
}

void checkUnnamed4988(core.List<api.HttpRule> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkHttpRule(o[0] as api.HttpRule);
  checkHttpRule(o[1] as api.HttpRule);
}

core.int buildCounterHttp = 0;
api.Http buildHttp() {
  var o = api.Http();
  buildCounterHttp++;
  if (buildCounterHttp < 3) {
    o.fullyDecodeReservedExpansion = true;
    o.rules = buildUnnamed4988();
  }
  buildCounterHttp--;
  return o;
}

void checkHttp(api.Http o) {
  buildCounterHttp++;
  if (buildCounterHttp < 3) {
    unittest.expect(o.fullyDecodeReservedExpansion!, unittest.isTrue);
    checkUnnamed4988(o.rules!);
  }
  buildCounterHttp--;
}

core.List<api.HttpRule> buildUnnamed4989() {
  var o = <api.HttpRule>[];
  o.add(buildHttpRule());
  o.add(buildHttpRule());
  return o;
}

void checkUnnamed4989(core.List<api.HttpRule> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkHttpRule(o[0] as api.HttpRule);
  checkHttpRule(o[1] as api.HttpRule);
}

core.int buildCounterHttpRule = 0;
api.HttpRule buildHttpRule() {
  var o = api.HttpRule();
  buildCounterHttpRule++;
  if (buildCounterHttpRule < 3) {
    o.additionalBindings = buildUnnamed4989();
    o.body = 'foo';
    o.custom = buildCustomHttpPattern();
    o.delete = 'foo';
    o.get = 'foo';
    o.patch = 'foo';
    o.post = 'foo';
    o.put = 'foo';
    o.responseBody = 'foo';
    o.selector = 'foo';
  }
  buildCounterHttpRule--;
  return o;
}

void checkHttpRule(api.HttpRule o) {
  buildCounterHttpRule++;
  if (buildCounterHttpRule < 3) {
    checkUnnamed4989(o.additionalBindings!);
    unittest.expect(
      o.body!,
      unittest.equals('foo'),
    );
    checkCustomHttpPattern(o.custom! as api.CustomHttpPattern);
    unittest.expect(
      o.delete!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.get!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.patch!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.post!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.put!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.responseBody!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.selector!,
      unittest.equals('foo'),
    );
  }
  buildCounterHttpRule--;
}

core.List<api.QuotaOverride> buildUnnamed4990() {
  var o = <api.QuotaOverride>[];
  o.add(buildQuotaOverride());
  o.add(buildQuotaOverride());
  return o;
}

void checkUnnamed4990(core.List<api.QuotaOverride> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkQuotaOverride(o[0] as api.QuotaOverride);
  checkQuotaOverride(o[1] as api.QuotaOverride);
}

core.int buildCounterImportAdminOverridesResponse = 0;
api.ImportAdminOverridesResponse buildImportAdminOverridesResponse() {
  var o = api.ImportAdminOverridesResponse();
  buildCounterImportAdminOverridesResponse++;
  if (buildCounterImportAdminOverridesResponse < 3) {
    o.overrides = buildUnnamed4990();
  }
  buildCounterImportAdminOverridesResponse--;
  return o;
}

void checkImportAdminOverridesResponse(api.ImportAdminOverridesResponse o) {
  buildCounterImportAdminOverridesResponse++;
  if (buildCounterImportAdminOverridesResponse < 3) {
    checkUnnamed4990(o.overrides!);
  }
  buildCounterImportAdminOverridesResponse--;
}

core.List<api.AdminQuotaPolicy> buildUnnamed4991() {
  var o = <api.AdminQuotaPolicy>[];
  o.add(buildAdminQuotaPolicy());
  o.add(buildAdminQuotaPolicy());
  return o;
}

void checkUnnamed4991(core.List<api.AdminQuotaPolicy> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAdminQuotaPolicy(o[0] as api.AdminQuotaPolicy);
  checkAdminQuotaPolicy(o[1] as api.AdminQuotaPolicy);
}

core.int buildCounterImportAdminQuotaPoliciesResponse = 0;
api.ImportAdminQuotaPoliciesResponse buildImportAdminQuotaPoliciesResponse() {
  var o = api.ImportAdminQuotaPoliciesResponse();
  buildCounterImportAdminQuotaPoliciesResponse++;
  if (buildCounterImportAdminQuotaPoliciesResponse < 3) {
    o.policies = buildUnnamed4991();
  }
  buildCounterImportAdminQuotaPoliciesResponse--;
  return o;
}

void checkImportAdminQuotaPoliciesResponse(
    api.ImportAdminQuotaPoliciesResponse o) {
  buildCounterImportAdminQuotaPoliciesResponse++;
  if (buildCounterImportAdminQuotaPoliciesResponse < 3) {
    checkUnnamed4991(o.policies!);
  }
  buildCounterImportAdminQuotaPoliciesResponse--;
}

core.List<api.QuotaOverride> buildUnnamed4992() {
  var o = <api.QuotaOverride>[];
  o.add(buildQuotaOverride());
  o.add(buildQuotaOverride());
  return o;
}

void checkUnnamed4992(core.List<api.QuotaOverride> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkQuotaOverride(o[0] as api.QuotaOverride);
  checkQuotaOverride(o[1] as api.QuotaOverride);
}

core.int buildCounterImportConsumerOverridesResponse = 0;
api.ImportConsumerOverridesResponse buildImportConsumerOverridesResponse() {
  var o = api.ImportConsumerOverridesResponse();
  buildCounterImportConsumerOverridesResponse++;
  if (buildCounterImportConsumerOverridesResponse < 3) {
    o.overrides = buildUnnamed4992();
  }
  buildCounterImportConsumerOverridesResponse--;
  return o;
}

void checkImportConsumerOverridesResponse(
    api.ImportConsumerOverridesResponse o) {
  buildCounterImportConsumerOverridesResponse++;
  if (buildCounterImportConsumerOverridesResponse < 3) {
    checkUnnamed4992(o.overrides!);
  }
  buildCounterImportConsumerOverridesResponse--;
}

core.int buildCounterJwtLocation = 0;
api.JwtLocation buildJwtLocation() {
  var o = api.JwtLocation();
  buildCounterJwtLocation++;
  if (buildCounterJwtLocation < 3) {
    o.header = 'foo';
    o.query = 'foo';
    o.valuePrefix = 'foo';
  }
  buildCounterJwtLocation--;
  return o;
}

void checkJwtLocation(api.JwtLocation o) {
  buildCounterJwtLocation++;
  if (buildCounterJwtLocation < 3) {
    unittest.expect(
      o.header!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.query!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.valuePrefix!,
      unittest.equals('foo'),
    );
  }
  buildCounterJwtLocation--;
}

core.int buildCounterLabelDescriptor = 0;
api.LabelDescriptor buildLabelDescriptor() {
  var o = api.LabelDescriptor();
  buildCounterLabelDescriptor++;
  if (buildCounterLabelDescriptor < 3) {
    o.description = 'foo';
    o.key = 'foo';
    o.valueType = 'foo';
  }
  buildCounterLabelDescriptor--;
  return o;
}

void checkLabelDescriptor(api.LabelDescriptor o) {
  buildCounterLabelDescriptor++;
  if (buildCounterLabelDescriptor < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.key!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.valueType!,
      unittest.equals('foo'),
    );
  }
  buildCounterLabelDescriptor--;
}

core.List<api.Operation> buildUnnamed4993() {
  var o = <api.Operation>[];
  o.add(buildOperation());
  o.add(buildOperation());
  return o;
}

void checkUnnamed4993(core.List<api.Operation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOperation(o[0] as api.Operation);
  checkOperation(o[1] as api.Operation);
}

core.int buildCounterListOperationsResponse = 0;
api.ListOperationsResponse buildListOperationsResponse() {
  var o = api.ListOperationsResponse();
  buildCounterListOperationsResponse++;
  if (buildCounterListOperationsResponse < 3) {
    o.nextPageToken = 'foo';
    o.operations = buildUnnamed4993();
  }
  buildCounterListOperationsResponse--;
  return o;
}

void checkListOperationsResponse(api.ListOperationsResponse o) {
  buildCounterListOperationsResponse++;
  if (buildCounterListOperationsResponse < 3) {
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
    checkUnnamed4993(o.operations!);
  }
  buildCounterListOperationsResponse--;
}

core.List<api.GoogleApiServiceusageV1Service> buildUnnamed4994() {
  var o = <api.GoogleApiServiceusageV1Service>[];
  o.add(buildGoogleApiServiceusageV1Service());
  o.add(buildGoogleApiServiceusageV1Service());
  return o;
}

void checkUnnamed4994(core.List<api.GoogleApiServiceusageV1Service> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleApiServiceusageV1Service(
      o[0] as api.GoogleApiServiceusageV1Service);
  checkGoogleApiServiceusageV1Service(
      o[1] as api.GoogleApiServiceusageV1Service);
}

core.int buildCounterListServicesResponse = 0;
api.ListServicesResponse buildListServicesResponse() {
  var o = api.ListServicesResponse();
  buildCounterListServicesResponse++;
  if (buildCounterListServicesResponse < 3) {
    o.nextPageToken = 'foo';
    o.services = buildUnnamed4994();
  }
  buildCounterListServicesResponse--;
  return o;
}

void checkListServicesResponse(api.ListServicesResponse o) {
  buildCounterListServicesResponse++;
  if (buildCounterListServicesResponse < 3) {
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
    checkUnnamed4994(o.services!);
  }
  buildCounterListServicesResponse--;
}

core.List<api.LabelDescriptor> buildUnnamed4995() {
  var o = <api.LabelDescriptor>[];
  o.add(buildLabelDescriptor());
  o.add(buildLabelDescriptor());
  return o;
}

void checkUnnamed4995(core.List<api.LabelDescriptor> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLabelDescriptor(o[0] as api.LabelDescriptor);
  checkLabelDescriptor(o[1] as api.LabelDescriptor);
}

core.int buildCounterLogDescriptor = 0;
api.LogDescriptor buildLogDescriptor() {
  var o = api.LogDescriptor();
  buildCounterLogDescriptor++;
  if (buildCounterLogDescriptor < 3) {
    o.description = 'foo';
    o.displayName = 'foo';
    o.labels = buildUnnamed4995();
    o.name = 'foo';
  }
  buildCounterLogDescriptor--;
  return o;
}

void checkLogDescriptor(api.LogDescriptor o) {
  buildCounterLogDescriptor++;
  if (buildCounterLogDescriptor < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    checkUnnamed4995(o.labels!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
  }
  buildCounterLogDescriptor--;
}

core.List<api.LoggingDestination> buildUnnamed4996() {
  var o = <api.LoggingDestination>[];
  o.add(buildLoggingDestination());
  o.add(buildLoggingDestination());
  return o;
}

void checkUnnamed4996(core.List<api.LoggingDestination> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLoggingDestination(o[0] as api.LoggingDestination);
  checkLoggingDestination(o[1] as api.LoggingDestination);
}

core.List<api.LoggingDestination> buildUnnamed4997() {
  var o = <api.LoggingDestination>[];
  o.add(buildLoggingDestination());
  o.add(buildLoggingDestination());
  return o;
}

void checkUnnamed4997(core.List<api.LoggingDestination> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLoggingDestination(o[0] as api.LoggingDestination);
  checkLoggingDestination(o[1] as api.LoggingDestination);
}

core.int buildCounterLogging = 0;
api.Logging buildLogging() {
  var o = api.Logging();
  buildCounterLogging++;
  if (buildCounterLogging < 3) {
    o.consumerDestinations = buildUnnamed4996();
    o.producerDestinations = buildUnnamed4997();
  }
  buildCounterLogging--;
  return o;
}

void checkLogging(api.Logging o) {
  buildCounterLogging++;
  if (buildCounterLogging < 3) {
    checkUnnamed4996(o.consumerDestinations!);
    checkUnnamed4997(o.producerDestinations!);
  }
  buildCounterLogging--;
}

core.List<core.String> buildUnnamed4998() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4998(core.List<core.String> o) {
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

core.int buildCounterLoggingDestination = 0;
api.LoggingDestination buildLoggingDestination() {
  var o = api.LoggingDestination();
  buildCounterLoggingDestination++;
  if (buildCounterLoggingDestination < 3) {
    o.logs = buildUnnamed4998();
    o.monitoredResource = 'foo';
  }
  buildCounterLoggingDestination--;
  return o;
}

void checkLoggingDestination(api.LoggingDestination o) {
  buildCounterLoggingDestination++;
  if (buildCounterLoggingDestination < 3) {
    checkUnnamed4998(o.logs!);
    unittest.expect(
      o.monitoredResource!,
      unittest.equals('foo'),
    );
  }
  buildCounterLoggingDestination--;
}

core.List<api.Option> buildUnnamed4999() {
  var o = <api.Option>[];
  o.add(buildOption());
  o.add(buildOption());
  return o;
}

void checkUnnamed4999(core.List<api.Option> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOption(o[0] as api.Option);
  checkOption(o[1] as api.Option);
}

core.int buildCounterMethod = 0;
api.Method buildMethod() {
  var o = api.Method();
  buildCounterMethod++;
  if (buildCounterMethod < 3) {
    o.name = 'foo';
    o.options = buildUnnamed4999();
    o.requestStreaming = true;
    o.requestTypeUrl = 'foo';
    o.responseStreaming = true;
    o.responseTypeUrl = 'foo';
    o.syntax = 'foo';
  }
  buildCounterMethod--;
  return o;
}

void checkMethod(api.Method o) {
  buildCounterMethod++;
  if (buildCounterMethod < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed4999(o.options!);
    unittest.expect(o.requestStreaming!, unittest.isTrue);
    unittest.expect(
      o.requestTypeUrl!,
      unittest.equals('foo'),
    );
    unittest.expect(o.responseStreaming!, unittest.isTrue);
    unittest.expect(
      o.responseTypeUrl!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.syntax!,
      unittest.equals('foo'),
    );
  }
  buildCounterMethod--;
}

core.List<api.LabelDescriptor> buildUnnamed5000() {
  var o = <api.LabelDescriptor>[];
  o.add(buildLabelDescriptor());
  o.add(buildLabelDescriptor());
  return o;
}

void checkUnnamed5000(core.List<api.LabelDescriptor> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLabelDescriptor(o[0] as api.LabelDescriptor);
  checkLabelDescriptor(o[1] as api.LabelDescriptor);
}

core.List<core.String> buildUnnamed5001() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed5001(core.List<core.String> o) {
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

core.int buildCounterMetricDescriptor = 0;
api.MetricDescriptor buildMetricDescriptor() {
  var o = api.MetricDescriptor();
  buildCounterMetricDescriptor++;
  if (buildCounterMetricDescriptor < 3) {
    o.description = 'foo';
    o.displayName = 'foo';
    o.labels = buildUnnamed5000();
    o.launchStage = 'foo';
    o.metadata = buildMetricDescriptorMetadata();
    o.metricKind = 'foo';
    o.monitoredResourceTypes = buildUnnamed5001();
    o.name = 'foo';
    o.type = 'foo';
    o.unit = 'foo';
    o.valueType = 'foo';
  }
  buildCounterMetricDescriptor--;
  return o;
}

void checkMetricDescriptor(api.MetricDescriptor o) {
  buildCounterMetricDescriptor++;
  if (buildCounterMetricDescriptor < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    checkUnnamed5000(o.labels!);
    unittest.expect(
      o.launchStage!,
      unittest.equals('foo'),
    );
    checkMetricDescriptorMetadata(o.metadata! as api.MetricDescriptorMetadata);
    unittest.expect(
      o.metricKind!,
      unittest.equals('foo'),
    );
    checkUnnamed5001(o.monitoredResourceTypes!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.unit!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.valueType!,
      unittest.equals('foo'),
    );
  }
  buildCounterMetricDescriptor--;
}

core.int buildCounterMetricDescriptorMetadata = 0;
api.MetricDescriptorMetadata buildMetricDescriptorMetadata() {
  var o = api.MetricDescriptorMetadata();
  buildCounterMetricDescriptorMetadata++;
  if (buildCounterMetricDescriptorMetadata < 3) {
    o.ingestDelay = 'foo';
    o.launchStage = 'foo';
    o.samplePeriod = 'foo';
  }
  buildCounterMetricDescriptorMetadata--;
  return o;
}

void checkMetricDescriptorMetadata(api.MetricDescriptorMetadata o) {
  buildCounterMetricDescriptorMetadata++;
  if (buildCounterMetricDescriptorMetadata < 3) {
    unittest.expect(
      o.ingestDelay!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.launchStage!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.samplePeriod!,
      unittest.equals('foo'),
    );
  }
  buildCounterMetricDescriptorMetadata--;
}

core.Map<core.String, core.String> buildUnnamed5002() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed5002(core.Map<core.String, core.String> o) {
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

core.int buildCounterMetricRule = 0;
api.MetricRule buildMetricRule() {
  var o = api.MetricRule();
  buildCounterMetricRule++;
  if (buildCounterMetricRule < 3) {
    o.metricCosts = buildUnnamed5002();
    o.selector = 'foo';
  }
  buildCounterMetricRule--;
  return o;
}

void checkMetricRule(api.MetricRule o) {
  buildCounterMetricRule++;
  if (buildCounterMetricRule < 3) {
    checkUnnamed5002(o.metricCosts!);
    unittest.expect(
      o.selector!,
      unittest.equals('foo'),
    );
  }
  buildCounterMetricRule--;
}

core.int buildCounterMixin = 0;
api.Mixin buildMixin() {
  var o = api.Mixin();
  buildCounterMixin++;
  if (buildCounterMixin < 3) {
    o.name = 'foo';
    o.root = 'foo';
  }
  buildCounterMixin--;
  return o;
}

void checkMixin(api.Mixin o) {
  buildCounterMixin++;
  if (buildCounterMixin < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.root!,
      unittest.equals('foo'),
    );
  }
  buildCounterMixin--;
}

core.List<api.LabelDescriptor> buildUnnamed5003() {
  var o = <api.LabelDescriptor>[];
  o.add(buildLabelDescriptor());
  o.add(buildLabelDescriptor());
  return o;
}

void checkUnnamed5003(core.List<api.LabelDescriptor> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLabelDescriptor(o[0] as api.LabelDescriptor);
  checkLabelDescriptor(o[1] as api.LabelDescriptor);
}

core.int buildCounterMonitoredResourceDescriptor = 0;
api.MonitoredResourceDescriptor buildMonitoredResourceDescriptor() {
  var o = api.MonitoredResourceDescriptor();
  buildCounterMonitoredResourceDescriptor++;
  if (buildCounterMonitoredResourceDescriptor < 3) {
    o.description = 'foo';
    o.displayName = 'foo';
    o.labels = buildUnnamed5003();
    o.launchStage = 'foo';
    o.name = 'foo';
    o.type = 'foo';
  }
  buildCounterMonitoredResourceDescriptor--;
  return o;
}

void checkMonitoredResourceDescriptor(api.MonitoredResourceDescriptor o) {
  buildCounterMonitoredResourceDescriptor++;
  if (buildCounterMonitoredResourceDescriptor < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    checkUnnamed5003(o.labels!);
    unittest.expect(
      o.launchStage!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterMonitoredResourceDescriptor--;
}

core.List<api.MonitoringDestination> buildUnnamed5004() {
  var o = <api.MonitoringDestination>[];
  o.add(buildMonitoringDestination());
  o.add(buildMonitoringDestination());
  return o;
}

void checkUnnamed5004(core.List<api.MonitoringDestination> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMonitoringDestination(o[0] as api.MonitoringDestination);
  checkMonitoringDestination(o[1] as api.MonitoringDestination);
}

core.List<api.MonitoringDestination> buildUnnamed5005() {
  var o = <api.MonitoringDestination>[];
  o.add(buildMonitoringDestination());
  o.add(buildMonitoringDestination());
  return o;
}

void checkUnnamed5005(core.List<api.MonitoringDestination> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMonitoringDestination(o[0] as api.MonitoringDestination);
  checkMonitoringDestination(o[1] as api.MonitoringDestination);
}

core.int buildCounterMonitoring = 0;
api.Monitoring buildMonitoring() {
  var o = api.Monitoring();
  buildCounterMonitoring++;
  if (buildCounterMonitoring < 3) {
    o.consumerDestinations = buildUnnamed5004();
    o.producerDestinations = buildUnnamed5005();
  }
  buildCounterMonitoring--;
  return o;
}

void checkMonitoring(api.Monitoring o) {
  buildCounterMonitoring++;
  if (buildCounterMonitoring < 3) {
    checkUnnamed5004(o.consumerDestinations!);
    checkUnnamed5005(o.producerDestinations!);
  }
  buildCounterMonitoring--;
}

core.List<core.String> buildUnnamed5006() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed5006(core.List<core.String> o) {
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

core.int buildCounterMonitoringDestination = 0;
api.MonitoringDestination buildMonitoringDestination() {
  var o = api.MonitoringDestination();
  buildCounterMonitoringDestination++;
  if (buildCounterMonitoringDestination < 3) {
    o.metrics = buildUnnamed5006();
    o.monitoredResource = 'foo';
  }
  buildCounterMonitoringDestination--;
  return o;
}

void checkMonitoringDestination(api.MonitoringDestination o) {
  buildCounterMonitoringDestination++;
  if (buildCounterMonitoringDestination < 3) {
    checkUnnamed5006(o.metrics!);
    unittest.expect(
      o.monitoredResource!,
      unittest.equals('foo'),
    );
  }
  buildCounterMonitoringDestination--;
}

core.int buildCounterOAuthRequirements = 0;
api.OAuthRequirements buildOAuthRequirements() {
  var o = api.OAuthRequirements();
  buildCounterOAuthRequirements++;
  if (buildCounterOAuthRequirements < 3) {
    o.canonicalScopes = 'foo';
  }
  buildCounterOAuthRequirements--;
  return o;
}

void checkOAuthRequirements(api.OAuthRequirements o) {
  buildCounterOAuthRequirements++;
  if (buildCounterOAuthRequirements < 3) {
    unittest.expect(
      o.canonicalScopes!,
      unittest.equals('foo'),
    );
  }
  buildCounterOAuthRequirements--;
}

core.Map<core.String, core.Object> buildUnnamed5007() {
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

void checkUnnamed5007(core.Map<core.String, core.Object> o) {
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

core.Map<core.String, core.Object> buildUnnamed5008() {
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

void checkUnnamed5008(core.Map<core.String, core.Object> o) {
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

core.int buildCounterOperation = 0;
api.Operation buildOperation() {
  var o = api.Operation();
  buildCounterOperation++;
  if (buildCounterOperation < 3) {
    o.done = true;
    o.error = buildStatus();
    o.metadata = buildUnnamed5007();
    o.name = 'foo';
    o.response = buildUnnamed5008();
  }
  buildCounterOperation--;
  return o;
}

void checkOperation(api.Operation o) {
  buildCounterOperation++;
  if (buildCounterOperation < 3) {
    unittest.expect(o.done!, unittest.isTrue);
    checkStatus(o.error! as api.Status);
    checkUnnamed5007(o.metadata!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed5008(o.response!);
  }
  buildCounterOperation--;
}

core.List<core.String> buildUnnamed5009() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed5009(core.List<core.String> o) {
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

core.int buildCounterOperationMetadata = 0;
api.OperationMetadata buildOperationMetadata() {
  var o = api.OperationMetadata();
  buildCounterOperationMetadata++;
  if (buildCounterOperationMetadata < 3) {
    o.resourceNames = buildUnnamed5009();
  }
  buildCounterOperationMetadata--;
  return o;
}

void checkOperationMetadata(api.OperationMetadata o) {
  buildCounterOperationMetadata++;
  if (buildCounterOperationMetadata < 3) {
    checkUnnamed5009(o.resourceNames!);
  }
  buildCounterOperationMetadata--;
}

core.Map<core.String, core.Object> buildUnnamed5010() {
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

void checkUnnamed5010(core.Map<core.String, core.Object> o) {
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

core.int buildCounterOption = 0;
api.Option buildOption() {
  var o = api.Option();
  buildCounterOption++;
  if (buildCounterOption < 3) {
    o.name = 'foo';
    o.value = buildUnnamed5010();
  }
  buildCounterOption--;
  return o;
}

void checkOption(api.Option o) {
  buildCounterOption++;
  if (buildCounterOption < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed5010(o.value!);
  }
  buildCounterOption--;
}

core.List<api.Page> buildUnnamed5011() {
  var o = <api.Page>[];
  o.add(buildPage());
  o.add(buildPage());
  return o;
}

void checkUnnamed5011(core.List<api.Page> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPage(o[0] as api.Page);
  checkPage(o[1] as api.Page);
}

core.int buildCounterPage = 0;
api.Page buildPage() {
  var o = api.Page();
  buildCounterPage++;
  if (buildCounterPage < 3) {
    o.content = 'foo';
    o.name = 'foo';
    o.subpages = buildUnnamed5011();
  }
  buildCounterPage--;
  return o;
}

void checkPage(api.Page o) {
  buildCounterPage++;
  if (buildCounterPage < 3) {
    unittest.expect(
      o.content!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed5011(o.subpages!);
  }
  buildCounterPage--;
}

core.List<api.QuotaLimit> buildUnnamed5012() {
  var o = <api.QuotaLimit>[];
  o.add(buildQuotaLimit());
  o.add(buildQuotaLimit());
  return o;
}

void checkUnnamed5012(core.List<api.QuotaLimit> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkQuotaLimit(o[0] as api.QuotaLimit);
  checkQuotaLimit(o[1] as api.QuotaLimit);
}

core.List<api.MetricRule> buildUnnamed5013() {
  var o = <api.MetricRule>[];
  o.add(buildMetricRule());
  o.add(buildMetricRule());
  return o;
}

void checkUnnamed5013(core.List<api.MetricRule> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMetricRule(o[0] as api.MetricRule);
  checkMetricRule(o[1] as api.MetricRule);
}

core.int buildCounterQuota = 0;
api.Quota buildQuota() {
  var o = api.Quota();
  buildCounterQuota++;
  if (buildCounterQuota < 3) {
    o.limits = buildUnnamed5012();
    o.metricRules = buildUnnamed5013();
  }
  buildCounterQuota--;
  return o;
}

void checkQuota(api.Quota o) {
  buildCounterQuota++;
  if (buildCounterQuota < 3) {
    checkUnnamed5012(o.limits!);
    checkUnnamed5013(o.metricRules!);
  }
  buildCounterQuota--;
}

core.Map<core.String, core.String> buildUnnamed5014() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed5014(core.Map<core.String, core.String> o) {
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

core.int buildCounterQuotaLimit = 0;
api.QuotaLimit buildQuotaLimit() {
  var o = api.QuotaLimit();
  buildCounterQuotaLimit++;
  if (buildCounterQuotaLimit < 3) {
    o.defaultLimit = 'foo';
    o.description = 'foo';
    o.displayName = 'foo';
    o.duration = 'foo';
    o.freeTier = 'foo';
    o.maxLimit = 'foo';
    o.metric = 'foo';
    o.name = 'foo';
    o.unit = 'foo';
    o.values = buildUnnamed5014();
  }
  buildCounterQuotaLimit--;
  return o;
}

void checkQuotaLimit(api.QuotaLimit o) {
  buildCounterQuotaLimit++;
  if (buildCounterQuotaLimit < 3) {
    unittest.expect(
      o.defaultLimit!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.duration!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.freeTier!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.maxLimit!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.metric!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.unit!,
      unittest.equals('foo'),
    );
    checkUnnamed5014(o.values!);
  }
  buildCounterQuotaLimit--;
}

core.Map<core.String, core.String> buildUnnamed5015() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed5015(core.Map<core.String, core.String> o) {
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

core.int buildCounterQuotaOverride = 0;
api.QuotaOverride buildQuotaOverride() {
  var o = api.QuotaOverride();
  buildCounterQuotaOverride++;
  if (buildCounterQuotaOverride < 3) {
    o.adminOverrideAncestor = 'foo';
    o.dimensions = buildUnnamed5015();
    o.metric = 'foo';
    o.name = 'foo';
    o.overrideValue = 'foo';
    o.unit = 'foo';
  }
  buildCounterQuotaOverride--;
  return o;
}

void checkQuotaOverride(api.QuotaOverride o) {
  buildCounterQuotaOverride++;
  if (buildCounterQuotaOverride < 3) {
    unittest.expect(
      o.adminOverrideAncestor!,
      unittest.equals('foo'),
    );
    checkUnnamed5015(o.dimensions!);
    unittest.expect(
      o.metric!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.overrideValue!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.unit!,
      unittest.equals('foo'),
    );
  }
  buildCounterQuotaOverride--;
}

core.int buildCounterServiceIdentity = 0;
api.ServiceIdentity buildServiceIdentity() {
  var o = api.ServiceIdentity();
  buildCounterServiceIdentity++;
  if (buildCounterServiceIdentity < 3) {
    o.email = 'foo';
    o.uniqueId = 'foo';
  }
  buildCounterServiceIdentity--;
  return o;
}

void checkServiceIdentity(api.ServiceIdentity o) {
  buildCounterServiceIdentity++;
  if (buildCounterServiceIdentity < 3) {
    unittest.expect(
      o.email!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.uniqueId!,
      unittest.equals('foo'),
    );
  }
  buildCounterServiceIdentity--;
}

core.int buildCounterSourceContext = 0;
api.SourceContext buildSourceContext() {
  var o = api.SourceContext();
  buildCounterSourceContext++;
  if (buildCounterSourceContext < 3) {
    o.fileName = 'foo';
  }
  buildCounterSourceContext--;
  return o;
}

void checkSourceContext(api.SourceContext o) {
  buildCounterSourceContext++;
  if (buildCounterSourceContext < 3) {
    unittest.expect(
      o.fileName!,
      unittest.equals('foo'),
    );
  }
  buildCounterSourceContext--;
}

core.Map<core.String, core.Object> buildUnnamed5016() {
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

void checkUnnamed5016(core.Map<core.String, core.Object> o) {
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

core.List<core.Map<core.String, core.Object>> buildUnnamed5017() {
  var o = <core.Map<core.String, core.Object>>[];
  o.add(buildUnnamed5016());
  o.add(buildUnnamed5016());
  return o;
}

void checkUnnamed5017(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed5016(o[0]);
  checkUnnamed5016(o[1]);
}

core.int buildCounterSourceInfo = 0;
api.SourceInfo buildSourceInfo() {
  var o = api.SourceInfo();
  buildCounterSourceInfo++;
  if (buildCounterSourceInfo < 3) {
    o.sourceFiles = buildUnnamed5017();
  }
  buildCounterSourceInfo--;
  return o;
}

void checkSourceInfo(api.SourceInfo o) {
  buildCounterSourceInfo++;
  if (buildCounterSourceInfo < 3) {
    checkUnnamed5017(o.sourceFiles!);
  }
  buildCounterSourceInfo--;
}

core.Map<core.String, core.Object> buildUnnamed5018() {
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

void checkUnnamed5018(core.Map<core.String, core.Object> o) {
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

core.List<core.Map<core.String, core.Object>> buildUnnamed5019() {
  var o = <core.Map<core.String, core.Object>>[];
  o.add(buildUnnamed5018());
  o.add(buildUnnamed5018());
  return o;
}

void checkUnnamed5019(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed5018(o[0]);
  checkUnnamed5018(o[1]);
}

core.int buildCounterStatus = 0;
api.Status buildStatus() {
  var o = api.Status();
  buildCounterStatus++;
  if (buildCounterStatus < 3) {
    o.code = 42;
    o.details = buildUnnamed5019();
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
    checkUnnamed5019(o.details!);
    unittest.expect(
      o.message!,
      unittest.equals('foo'),
    );
  }
  buildCounterStatus--;
}

core.int buildCounterSystemParameter = 0;
api.SystemParameter buildSystemParameter() {
  var o = api.SystemParameter();
  buildCounterSystemParameter++;
  if (buildCounterSystemParameter < 3) {
    o.httpHeader = 'foo';
    o.name = 'foo';
    o.urlQueryParameter = 'foo';
  }
  buildCounterSystemParameter--;
  return o;
}

void checkSystemParameter(api.SystemParameter o) {
  buildCounterSystemParameter++;
  if (buildCounterSystemParameter < 3) {
    unittest.expect(
      o.httpHeader!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.urlQueryParameter!,
      unittest.equals('foo'),
    );
  }
  buildCounterSystemParameter--;
}

core.List<api.SystemParameter> buildUnnamed5020() {
  var o = <api.SystemParameter>[];
  o.add(buildSystemParameter());
  o.add(buildSystemParameter());
  return o;
}

void checkUnnamed5020(core.List<api.SystemParameter> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSystemParameter(o[0] as api.SystemParameter);
  checkSystemParameter(o[1] as api.SystemParameter);
}

core.int buildCounterSystemParameterRule = 0;
api.SystemParameterRule buildSystemParameterRule() {
  var o = api.SystemParameterRule();
  buildCounterSystemParameterRule++;
  if (buildCounterSystemParameterRule < 3) {
    o.parameters = buildUnnamed5020();
    o.selector = 'foo';
  }
  buildCounterSystemParameterRule--;
  return o;
}

void checkSystemParameterRule(api.SystemParameterRule o) {
  buildCounterSystemParameterRule++;
  if (buildCounterSystemParameterRule < 3) {
    checkUnnamed5020(o.parameters!);
    unittest.expect(
      o.selector!,
      unittest.equals('foo'),
    );
  }
  buildCounterSystemParameterRule--;
}

core.List<api.SystemParameterRule> buildUnnamed5021() {
  var o = <api.SystemParameterRule>[];
  o.add(buildSystemParameterRule());
  o.add(buildSystemParameterRule());
  return o;
}

void checkUnnamed5021(core.List<api.SystemParameterRule> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSystemParameterRule(o[0] as api.SystemParameterRule);
  checkSystemParameterRule(o[1] as api.SystemParameterRule);
}

core.int buildCounterSystemParameters = 0;
api.SystemParameters buildSystemParameters() {
  var o = api.SystemParameters();
  buildCounterSystemParameters++;
  if (buildCounterSystemParameters < 3) {
    o.rules = buildUnnamed5021();
  }
  buildCounterSystemParameters--;
  return o;
}

void checkSystemParameters(api.SystemParameters o) {
  buildCounterSystemParameters++;
  if (buildCounterSystemParameters < 3) {
    checkUnnamed5021(o.rules!);
  }
  buildCounterSystemParameters--;
}

core.List<api.Field> buildUnnamed5022() {
  var o = <api.Field>[];
  o.add(buildField());
  o.add(buildField());
  return o;
}

void checkUnnamed5022(core.List<api.Field> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkField(o[0] as api.Field);
  checkField(o[1] as api.Field);
}

core.List<core.String> buildUnnamed5023() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed5023(core.List<core.String> o) {
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

core.List<api.Option> buildUnnamed5024() {
  var o = <api.Option>[];
  o.add(buildOption());
  o.add(buildOption());
  return o;
}

void checkUnnamed5024(core.List<api.Option> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOption(o[0] as api.Option);
  checkOption(o[1] as api.Option);
}

core.int buildCounterType = 0;
api.Type buildType() {
  var o = api.Type();
  buildCounterType++;
  if (buildCounterType < 3) {
    o.fields = buildUnnamed5022();
    o.name = 'foo';
    o.oneofs = buildUnnamed5023();
    o.options = buildUnnamed5024();
    o.sourceContext = buildSourceContext();
    o.syntax = 'foo';
  }
  buildCounterType--;
  return o;
}

void checkType(api.Type o) {
  buildCounterType++;
  if (buildCounterType < 3) {
    checkUnnamed5022(o.fields!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed5023(o.oneofs!);
    checkUnnamed5024(o.options!);
    checkSourceContext(o.sourceContext! as api.SourceContext);
    unittest.expect(
      o.syntax!,
      unittest.equals('foo'),
    );
  }
  buildCounterType--;
}

core.List<core.String> buildUnnamed5025() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed5025(core.List<core.String> o) {
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

core.List<api.UsageRule> buildUnnamed5026() {
  var o = <api.UsageRule>[];
  o.add(buildUsageRule());
  o.add(buildUsageRule());
  return o;
}

void checkUnnamed5026(core.List<api.UsageRule> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUsageRule(o[0] as api.UsageRule);
  checkUsageRule(o[1] as api.UsageRule);
}

core.int buildCounterUsage = 0;
api.Usage buildUsage() {
  var o = api.Usage();
  buildCounterUsage++;
  if (buildCounterUsage < 3) {
    o.producerNotificationChannel = 'foo';
    o.requirements = buildUnnamed5025();
    o.rules = buildUnnamed5026();
  }
  buildCounterUsage--;
  return o;
}

void checkUsage(api.Usage o) {
  buildCounterUsage++;
  if (buildCounterUsage < 3) {
    unittest.expect(
      o.producerNotificationChannel!,
      unittest.equals('foo'),
    );
    checkUnnamed5025(o.requirements!);
    checkUnnamed5026(o.rules!);
  }
  buildCounterUsage--;
}

core.int buildCounterUsageRule = 0;
api.UsageRule buildUsageRule() {
  var o = api.UsageRule();
  buildCounterUsageRule++;
  if (buildCounterUsageRule < 3) {
    o.allowUnregisteredCalls = true;
    o.selector = 'foo';
    o.skipServiceControl = true;
  }
  buildCounterUsageRule--;
  return o;
}

void checkUsageRule(api.UsageRule o) {
  buildCounterUsageRule++;
  if (buildCounterUsageRule < 3) {
    unittest.expect(o.allowUnregisteredCalls!, unittest.isTrue);
    unittest.expect(
      o.selector!,
      unittest.equals('foo'),
    );
    unittest.expect(o.skipServiceControl!, unittest.isTrue);
  }
  buildCounterUsageRule--;
}

core.List<core.String> buildUnnamed5027() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed5027(core.List<core.String> o) {
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

void main() {
  unittest.group('obj-schema-AdminQuotaPolicy', () {
    unittest.test('to-json--from-json', () async {
      var o = buildAdminQuotaPolicy();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.AdminQuotaPolicy.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkAdminQuotaPolicy(od as api.AdminQuotaPolicy);
    });
  });

  unittest.group('obj-schema-Api', () {
    unittest.test('to-json--from-json', () async {
      var o = buildApi();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.Api.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkApi(od as api.Api);
    });
  });

  unittest.group('obj-schema-AuthProvider', () {
    unittest.test('to-json--from-json', () async {
      var o = buildAuthProvider();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.AuthProvider.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkAuthProvider(od as api.AuthProvider);
    });
  });

  unittest.group('obj-schema-AuthRequirement', () {
    unittest.test('to-json--from-json', () async {
      var o = buildAuthRequirement();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.AuthRequirement.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkAuthRequirement(od as api.AuthRequirement);
    });
  });

  unittest.group('obj-schema-Authentication', () {
    unittest.test('to-json--from-json', () async {
      var o = buildAuthentication();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.Authentication.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkAuthentication(od as api.Authentication);
    });
  });

  unittest.group('obj-schema-AuthenticationRule', () {
    unittest.test('to-json--from-json', () async {
      var o = buildAuthenticationRule();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.AuthenticationRule.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkAuthenticationRule(od as api.AuthenticationRule);
    });
  });

  unittest.group('obj-schema-Backend', () {
    unittest.test('to-json--from-json', () async {
      var o = buildBackend();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Backend.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkBackend(od as api.Backend);
    });
  });

  unittest.group('obj-schema-BackendRule', () {
    unittest.test('to-json--from-json', () async {
      var o = buildBackendRule();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.BackendRule.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkBackendRule(od as api.BackendRule);
    });
  });

  unittest.group('obj-schema-BatchCreateAdminOverridesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildBatchCreateAdminOverridesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.BatchCreateAdminOverridesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkBatchCreateAdminOverridesResponse(
          od as api.BatchCreateAdminOverridesResponse);
    });
  });

  unittest.group('obj-schema-BatchCreateConsumerOverridesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildBatchCreateConsumerOverridesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.BatchCreateConsumerOverridesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkBatchCreateConsumerOverridesResponse(
          od as api.BatchCreateConsumerOverridesResponse);
    });
  });

  unittest.group('obj-schema-BatchEnableServicesRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildBatchEnableServicesRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.BatchEnableServicesRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkBatchEnableServicesRequest(od as api.BatchEnableServicesRequest);
    });
  });

  unittest.group('obj-schema-BatchEnableServicesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildBatchEnableServicesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.BatchEnableServicesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkBatchEnableServicesResponse(od as api.BatchEnableServicesResponse);
    });
  });

  unittest.group('obj-schema-BatchGetServicesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildBatchGetServicesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.BatchGetServicesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkBatchGetServicesResponse(od as api.BatchGetServicesResponse);
    });
  });

  unittest.group('obj-schema-Billing', () {
    unittest.test('to-json--from-json', () async {
      var o = buildBilling();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Billing.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkBilling(od as api.Billing);
    });
  });

  unittest.group('obj-schema-BillingDestination', () {
    unittest.test('to-json--from-json', () async {
      var o = buildBillingDestination();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.BillingDestination.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkBillingDestination(od as api.BillingDestination);
    });
  });

  unittest.group('obj-schema-CancelOperationRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildCancelOperationRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.CancelOperationRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkCancelOperationRequest(od as api.CancelOperationRequest);
    });
  });

  unittest.group('obj-schema-Context', () {
    unittest.test('to-json--from-json', () async {
      var o = buildContext();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Context.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkContext(od as api.Context);
    });
  });

  unittest.group('obj-schema-ContextRule', () {
    unittest.test('to-json--from-json', () async {
      var o = buildContextRule();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ContextRule.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkContextRule(od as api.ContextRule);
    });
  });

  unittest.group('obj-schema-Control', () {
    unittest.test('to-json--from-json', () async {
      var o = buildControl();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Control.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkControl(od as api.Control);
    });
  });

  unittest.group('obj-schema-CustomError', () {
    unittest.test('to-json--from-json', () async {
      var o = buildCustomError();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.CustomError.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkCustomError(od as api.CustomError);
    });
  });

  unittest.group('obj-schema-CustomErrorRule', () {
    unittest.test('to-json--from-json', () async {
      var o = buildCustomErrorRule();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.CustomErrorRule.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkCustomErrorRule(od as api.CustomErrorRule);
    });
  });

  unittest.group('obj-schema-CustomHttpPattern', () {
    unittest.test('to-json--from-json', () async {
      var o = buildCustomHttpPattern();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.CustomHttpPattern.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkCustomHttpPattern(od as api.CustomHttpPattern);
    });
  });

  unittest.group('obj-schema-DisableServiceRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildDisableServiceRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.DisableServiceRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkDisableServiceRequest(od as api.DisableServiceRequest);
    });
  });

  unittest.group('obj-schema-DisableServiceResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildDisableServiceResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.DisableServiceResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkDisableServiceResponse(od as api.DisableServiceResponse);
    });
  });

  unittest.group('obj-schema-Documentation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildDocumentation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.Documentation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkDocumentation(od as api.Documentation);
    });
  });

  unittest.group('obj-schema-DocumentationRule', () {
    unittest.test('to-json--from-json', () async {
      var o = buildDocumentationRule();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.DocumentationRule.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkDocumentationRule(od as api.DocumentationRule);
    });
  });

  unittest.group('obj-schema-Empty', () {
    unittest.test('to-json--from-json', () async {
      var o = buildEmpty();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.Empty.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkEmpty(od as api.Empty);
    });
  });

  unittest.group('obj-schema-EnableFailure', () {
    unittest.test('to-json--from-json', () async {
      var o = buildEnableFailure();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.EnableFailure.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkEnableFailure(od as api.EnableFailure);
    });
  });

  unittest.group('obj-schema-EnableServiceRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildEnableServiceRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.EnableServiceRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkEnableServiceRequest(od as api.EnableServiceRequest);
    });
  });

  unittest.group('obj-schema-EnableServiceResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildEnableServiceResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.EnableServiceResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkEnableServiceResponse(od as api.EnableServiceResponse);
    });
  });

  unittest.group('obj-schema-Endpoint', () {
    unittest.test('to-json--from-json', () async {
      var o = buildEndpoint();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Endpoint.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkEndpoint(od as api.Endpoint);
    });
  });

  unittest.group('obj-schema-Enum', () {
    unittest.test('to-json--from-json', () async {
      var o = buildEnum();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.Enum.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkEnum(od as api.Enum);
    });
  });

  unittest.group('obj-schema-EnumValue', () {
    unittest.test('to-json--from-json', () async {
      var o = buildEnumValue();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.EnumValue.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkEnumValue(od as api.EnumValue);
    });
  });

  unittest.group('obj-schema-Field', () {
    unittest.test('to-json--from-json', () async {
      var o = buildField();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.Field.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkField(od as api.Field);
    });
  });

  unittest.group('obj-schema-GetServiceIdentityResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGetServiceIdentityResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GetServiceIdentityResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGetServiceIdentityResponse(od as api.GetServiceIdentityResponse);
    });
  });

  unittest.group('obj-schema-GoogleApiService', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleApiService();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleApiService.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleApiService(od as api.GoogleApiService);
    });
  });

  unittest.group('obj-schema-GoogleApiServiceusageV1OperationMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleApiServiceusageV1OperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleApiServiceusageV1OperationMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleApiServiceusageV1OperationMetadata(
          od as api.GoogleApiServiceusageV1OperationMetadata);
    });
  });

  unittest.group('obj-schema-GoogleApiServiceusageV1Service', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleApiServiceusageV1Service();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleApiServiceusageV1Service.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleApiServiceusageV1Service(
          od as api.GoogleApiServiceusageV1Service);
    });
  });

  unittest.group('obj-schema-GoogleApiServiceusageV1ServiceConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleApiServiceusageV1ServiceConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleApiServiceusageV1ServiceConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleApiServiceusageV1ServiceConfig(
          od as api.GoogleApiServiceusageV1ServiceConfig);
    });
  });

  unittest.group(
      'obj-schema-GoogleApiServiceusageV1beta1GetServiceIdentityResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleApiServiceusageV1beta1GetServiceIdentityResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleApiServiceusageV1beta1GetServiceIdentityResponse.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleApiServiceusageV1beta1GetServiceIdentityResponse(
          od as api.GoogleApiServiceusageV1beta1GetServiceIdentityResponse);
    });
  });

  unittest.group('obj-schema-GoogleApiServiceusageV1beta1ServiceIdentity', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleApiServiceusageV1beta1ServiceIdentity();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleApiServiceusageV1beta1ServiceIdentity.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleApiServiceusageV1beta1ServiceIdentity(
          od as api.GoogleApiServiceusageV1beta1ServiceIdentity);
    });
  });

  unittest.group('obj-schema-Http', () {
    unittest.test('to-json--from-json', () async {
      var o = buildHttp();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.Http.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkHttp(od as api.Http);
    });
  });

  unittest.group('obj-schema-HttpRule', () {
    unittest.test('to-json--from-json', () async {
      var o = buildHttpRule();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.HttpRule.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkHttpRule(od as api.HttpRule);
    });
  });

  unittest.group('obj-schema-ImportAdminOverridesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildImportAdminOverridesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ImportAdminOverridesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkImportAdminOverridesResponse(od as api.ImportAdminOverridesResponse);
    });
  });

  unittest.group('obj-schema-ImportAdminQuotaPoliciesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildImportAdminQuotaPoliciesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ImportAdminQuotaPoliciesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkImportAdminQuotaPoliciesResponse(
          od as api.ImportAdminQuotaPoliciesResponse);
    });
  });

  unittest.group('obj-schema-ImportConsumerOverridesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildImportConsumerOverridesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ImportConsumerOverridesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkImportConsumerOverridesResponse(
          od as api.ImportConsumerOverridesResponse);
    });
  });

  unittest.group('obj-schema-JwtLocation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildJwtLocation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.JwtLocation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkJwtLocation(od as api.JwtLocation);
    });
  });

  unittest.group('obj-schema-LabelDescriptor', () {
    unittest.test('to-json--from-json', () async {
      var o = buildLabelDescriptor();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.LabelDescriptor.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkLabelDescriptor(od as api.LabelDescriptor);
    });
  });

  unittest.group('obj-schema-ListOperationsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildListOperationsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ListOperationsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkListOperationsResponse(od as api.ListOperationsResponse);
    });
  });

  unittest.group('obj-schema-ListServicesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildListServicesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ListServicesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkListServicesResponse(od as api.ListServicesResponse);
    });
  });

  unittest.group('obj-schema-LogDescriptor', () {
    unittest.test('to-json--from-json', () async {
      var o = buildLogDescriptor();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.LogDescriptor.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkLogDescriptor(od as api.LogDescriptor);
    });
  });

  unittest.group('obj-schema-Logging', () {
    unittest.test('to-json--from-json', () async {
      var o = buildLogging();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Logging.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkLogging(od as api.Logging);
    });
  });

  unittest.group('obj-schema-LoggingDestination', () {
    unittest.test('to-json--from-json', () async {
      var o = buildLoggingDestination();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.LoggingDestination.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkLoggingDestination(od as api.LoggingDestination);
    });
  });

  unittest.group('obj-schema-Method', () {
    unittest.test('to-json--from-json', () async {
      var o = buildMethod();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Method.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkMethod(od as api.Method);
    });
  });

  unittest.group('obj-schema-MetricDescriptor', () {
    unittest.test('to-json--from-json', () async {
      var o = buildMetricDescriptor();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.MetricDescriptor.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkMetricDescriptor(od as api.MetricDescriptor);
    });
  });

  unittest.group('obj-schema-MetricDescriptorMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildMetricDescriptorMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.MetricDescriptorMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkMetricDescriptorMetadata(od as api.MetricDescriptorMetadata);
    });
  });

  unittest.group('obj-schema-MetricRule', () {
    unittest.test('to-json--from-json', () async {
      var o = buildMetricRule();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.MetricRule.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkMetricRule(od as api.MetricRule);
    });
  });

  unittest.group('obj-schema-Mixin', () {
    unittest.test('to-json--from-json', () async {
      var o = buildMixin();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.Mixin.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkMixin(od as api.Mixin);
    });
  });

  unittest.group('obj-schema-MonitoredResourceDescriptor', () {
    unittest.test('to-json--from-json', () async {
      var o = buildMonitoredResourceDescriptor();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.MonitoredResourceDescriptor.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkMonitoredResourceDescriptor(od as api.MonitoredResourceDescriptor);
    });
  });

  unittest.group('obj-schema-Monitoring', () {
    unittest.test('to-json--from-json', () async {
      var o = buildMonitoring();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Monitoring.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkMonitoring(od as api.Monitoring);
    });
  });

  unittest.group('obj-schema-MonitoringDestination', () {
    unittest.test('to-json--from-json', () async {
      var o = buildMonitoringDestination();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.MonitoringDestination.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkMonitoringDestination(od as api.MonitoringDestination);
    });
  });

  unittest.group('obj-schema-OAuthRequirements', () {
    unittest.test('to-json--from-json', () async {
      var o = buildOAuthRequirements();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.OAuthRequirements.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkOAuthRequirements(od as api.OAuthRequirements);
    });
  });

  unittest.group('obj-schema-Operation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildOperation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Operation.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkOperation(od as api.Operation);
    });
  });

  unittest.group('obj-schema-OperationMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.OperationMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkOperationMetadata(od as api.OperationMetadata);
    });
  });

  unittest.group('obj-schema-Option', () {
    unittest.test('to-json--from-json', () async {
      var o = buildOption();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Option.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkOption(od as api.Option);
    });
  });

  unittest.group('obj-schema-Page', () {
    unittest.test('to-json--from-json', () async {
      var o = buildPage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.Page.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkPage(od as api.Page);
    });
  });

  unittest.group('obj-schema-Quota', () {
    unittest.test('to-json--from-json', () async {
      var o = buildQuota();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.Quota.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkQuota(od as api.Quota);
    });
  });

  unittest.group('obj-schema-QuotaLimit', () {
    unittest.test('to-json--from-json', () async {
      var o = buildQuotaLimit();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.QuotaLimit.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkQuotaLimit(od as api.QuotaLimit);
    });
  });

  unittest.group('obj-schema-QuotaOverride', () {
    unittest.test('to-json--from-json', () async {
      var o = buildQuotaOverride();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.QuotaOverride.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkQuotaOverride(od as api.QuotaOverride);
    });
  });

  unittest.group('obj-schema-ServiceIdentity', () {
    unittest.test('to-json--from-json', () async {
      var o = buildServiceIdentity();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ServiceIdentity.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkServiceIdentity(od as api.ServiceIdentity);
    });
  });

  unittest.group('obj-schema-SourceContext', () {
    unittest.test('to-json--from-json', () async {
      var o = buildSourceContext();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.SourceContext.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkSourceContext(od as api.SourceContext);
    });
  });

  unittest.group('obj-schema-SourceInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildSourceInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.SourceInfo.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkSourceInfo(od as api.SourceInfo);
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

  unittest.group('obj-schema-SystemParameter', () {
    unittest.test('to-json--from-json', () async {
      var o = buildSystemParameter();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.SystemParameter.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkSystemParameter(od as api.SystemParameter);
    });
  });

  unittest.group('obj-schema-SystemParameterRule', () {
    unittest.test('to-json--from-json', () async {
      var o = buildSystemParameterRule();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.SystemParameterRule.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkSystemParameterRule(od as api.SystemParameterRule);
    });
  });

  unittest.group('obj-schema-SystemParameters', () {
    unittest.test('to-json--from-json', () async {
      var o = buildSystemParameters();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.SystemParameters.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkSystemParameters(od as api.SystemParameters);
    });
  });

  unittest.group('obj-schema-Type', () {
    unittest.test('to-json--from-json', () async {
      var o = buildType();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.Type.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkType(od as api.Type);
    });
  });

  unittest.group('obj-schema-Usage', () {
    unittest.test('to-json--from-json', () async {
      var o = buildUsage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.Usage.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkUsage(od as api.Usage);
    });
  });

  unittest.group('obj-schema-UsageRule', () {
    unittest.test('to-json--from-json', () async {
      var o = buildUsageRule();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.UsageRule.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkUsageRule(od as api.UsageRule);
    });
  });

  unittest.group('resource-OperationsResource', () {
    unittest.test('method--cancel', () async {
      var mock = HttpServerMock();
      var res = api.ServiceUsageApi(mock).operations;
      var arg_request = buildCancelOperationRequest();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.CancelOperationRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkCancelOperationRequest(obj as api.CancelOperationRequest);

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
          unittest.equals("v1/"),
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
        var resp = convert.json.encode(buildEmpty());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.cancel(arg_request, arg_name, $fields: arg_$fields);
      checkEmpty(response as api.Empty);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ServiceUsageApi(mock).operations;
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
          unittest.equals("v1/"),
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
        var resp = convert.json.encode(buildEmpty());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkEmpty(response as api.Empty);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ServiceUsageApi(mock).operations;
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
          unittest.equals("v1/"),
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
        var resp = convert.json.encode(buildOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkOperation(response as api.Operation);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ServiceUsageApi(mock).operations;
      var arg_filter = 'foo';
      var arg_name = 'foo';
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
          path.substring(pathOffset, pathOffset + 13),
          unittest.equals("v1/operations"),
        );
        pathOffset += 13;

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
          queryMap["name"]!.first,
          unittest.equals(arg_name),
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
        var resp = convert.json.encode(buildListOperationsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(
          filter: arg_filter,
          name: arg_name,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkListOperationsResponse(response as api.ListOperationsResponse);
    });
  });

  unittest.group('resource-ServicesResource', () {
    unittest.test('method--batchEnable', () async {
      var mock = HttpServerMock();
      var res = api.ServiceUsageApi(mock).services;
      var arg_request = buildBatchEnableServicesRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.BatchEnableServicesRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkBatchEnableServicesRequest(obj as api.BatchEnableServicesRequest);

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
          unittest.equals("v1/"),
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
        var resp = convert.json.encode(buildOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.batchEnable(arg_request, arg_parent, $fields: arg_$fields);
      checkOperation(response as api.Operation);
    });

    unittest.test('method--batchGet', () async {
      var mock = HttpServerMock();
      var res = api.ServiceUsageApi(mock).services;
      var arg_parent = 'foo';
      var arg_names = buildUnnamed5027();
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
          unittest.equals("v1/"),
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
          queryMap["names"]!,
          unittest.equals(arg_names),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildBatchGetServicesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.batchGet(arg_parent,
          names: arg_names, $fields: arg_$fields);
      checkBatchGetServicesResponse(response as api.BatchGetServicesResponse);
    });

    unittest.test('method--disable', () async {
      var mock = HttpServerMock();
      var res = api.ServiceUsageApi(mock).services;
      var arg_request = buildDisableServiceRequest();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.DisableServiceRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkDisableServiceRequest(obj as api.DisableServiceRequest);

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
          unittest.equals("v1/"),
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
        var resp = convert.json.encode(buildOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.disable(arg_request, arg_name, $fields: arg_$fields);
      checkOperation(response as api.Operation);
    });

    unittest.test('method--enable', () async {
      var mock = HttpServerMock();
      var res = api.ServiceUsageApi(mock).services;
      var arg_request = buildEnableServiceRequest();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.EnableServiceRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkEnableServiceRequest(obj as api.EnableServiceRequest);

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
          unittest.equals("v1/"),
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
        var resp = convert.json.encode(buildOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.enable(arg_request, arg_name, $fields: arg_$fields);
      checkOperation(response as api.Operation);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ServiceUsageApi(mock).services;
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
          unittest.equals("v1/"),
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
        var resp = convert.json.encode(buildGoogleApiServiceusageV1Service());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleApiServiceusageV1Service(
          response as api.GoogleApiServiceusageV1Service);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ServiceUsageApi(mock).services;
      var arg_parent = 'foo';
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
          unittest.equals("v1/"),
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
        var resp = convert.json.encode(buildListServicesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          filter: arg_filter,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkListServicesResponse(response as api.ListServicesResponse);
    });
  });
}
