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
import 'package:googleapis/apigee/v1.dart' as api;

import '../test_shared.dart';

core.Map<core.String, core.Object> buildUnnamed3330() {
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

void checkUnnamed3330(core.Map<core.String, core.Object> o) {
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

core.List<core.Map<core.String, core.Object>> buildUnnamed3331() {
  var o = <core.Map<core.String, core.Object>>[];
  o.add(buildUnnamed3330());
  o.add(buildUnnamed3330());
  return o;
}

void checkUnnamed3331(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed3330(o[0]);
  checkUnnamed3330(o[1]);
}

core.int buildCounterGoogleApiHttpBody = 0;
api.GoogleApiHttpBody buildGoogleApiHttpBody() {
  var o = api.GoogleApiHttpBody();
  buildCounterGoogleApiHttpBody++;
  if (buildCounterGoogleApiHttpBody < 3) {
    o.contentType = 'foo';
    o.data = 'foo';
    o.extensions = buildUnnamed3331();
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
    checkUnnamed3331(o.extensions!);
  }
  buildCounterGoogleApiHttpBody--;
}

core.int buildCounterGoogleCloudApigeeV1Access = 0;
api.GoogleCloudApigeeV1Access buildGoogleCloudApigeeV1Access() {
  var o = api.GoogleCloudApigeeV1Access();
  buildCounterGoogleCloudApigeeV1Access++;
  if (buildCounterGoogleCloudApigeeV1Access < 3) {
    o.Get = buildGoogleCloudApigeeV1AccessGet();
    o.Remove = buildGoogleCloudApigeeV1AccessRemove();
    o.Set = buildGoogleCloudApigeeV1AccessSet();
  }
  buildCounterGoogleCloudApigeeV1Access--;
  return o;
}

void checkGoogleCloudApigeeV1Access(api.GoogleCloudApigeeV1Access o) {
  buildCounterGoogleCloudApigeeV1Access++;
  if (buildCounterGoogleCloudApigeeV1Access < 3) {
    checkGoogleCloudApigeeV1AccessGet(
        o.Get! as api.GoogleCloudApigeeV1AccessGet);
    checkGoogleCloudApigeeV1AccessRemove(
        o.Remove! as api.GoogleCloudApigeeV1AccessRemove);
    checkGoogleCloudApigeeV1AccessSet(
        o.Set! as api.GoogleCloudApigeeV1AccessSet);
  }
  buildCounterGoogleCloudApigeeV1Access--;
}

core.int buildCounterGoogleCloudApigeeV1AccessGet = 0;
api.GoogleCloudApigeeV1AccessGet buildGoogleCloudApigeeV1AccessGet() {
  var o = api.GoogleCloudApigeeV1AccessGet();
  buildCounterGoogleCloudApigeeV1AccessGet++;
  if (buildCounterGoogleCloudApigeeV1AccessGet < 3) {
    o.name = 'foo';
    o.value = 'foo';
  }
  buildCounterGoogleCloudApigeeV1AccessGet--;
  return o;
}

void checkGoogleCloudApigeeV1AccessGet(api.GoogleCloudApigeeV1AccessGet o) {
  buildCounterGoogleCloudApigeeV1AccessGet++;
  if (buildCounterGoogleCloudApigeeV1AccessGet < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1AccessGet--;
}

core.int buildCounterGoogleCloudApigeeV1AccessRemove = 0;
api.GoogleCloudApigeeV1AccessRemove buildGoogleCloudApigeeV1AccessRemove() {
  var o = api.GoogleCloudApigeeV1AccessRemove();
  buildCounterGoogleCloudApigeeV1AccessRemove++;
  if (buildCounterGoogleCloudApigeeV1AccessRemove < 3) {
    o.name = 'foo';
    o.success = true;
  }
  buildCounterGoogleCloudApigeeV1AccessRemove--;
  return o;
}

void checkGoogleCloudApigeeV1AccessRemove(
    api.GoogleCloudApigeeV1AccessRemove o) {
  buildCounterGoogleCloudApigeeV1AccessRemove++;
  if (buildCounterGoogleCloudApigeeV1AccessRemove < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(o.success!, unittest.isTrue);
  }
  buildCounterGoogleCloudApigeeV1AccessRemove--;
}

core.int buildCounterGoogleCloudApigeeV1AccessSet = 0;
api.GoogleCloudApigeeV1AccessSet buildGoogleCloudApigeeV1AccessSet() {
  var o = api.GoogleCloudApigeeV1AccessSet();
  buildCounterGoogleCloudApigeeV1AccessSet++;
  if (buildCounterGoogleCloudApigeeV1AccessSet < 3) {
    o.name = 'foo';
    o.success = true;
    o.value = 'foo';
  }
  buildCounterGoogleCloudApigeeV1AccessSet--;
  return o;
}

void checkGoogleCloudApigeeV1AccessSet(api.GoogleCloudApigeeV1AccessSet o) {
  buildCounterGoogleCloudApigeeV1AccessSet++;
  if (buildCounterGoogleCloudApigeeV1AccessSet < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(o.success!, unittest.isTrue);
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1AccessSet--;
}

core.int buildCounterGoogleCloudApigeeV1ActivateNatAddressRequest = 0;
api.GoogleCloudApigeeV1ActivateNatAddressRequest
    buildGoogleCloudApigeeV1ActivateNatAddressRequest() {
  var o = api.GoogleCloudApigeeV1ActivateNatAddressRequest();
  buildCounterGoogleCloudApigeeV1ActivateNatAddressRequest++;
  if (buildCounterGoogleCloudApigeeV1ActivateNatAddressRequest < 3) {}
  buildCounterGoogleCloudApigeeV1ActivateNatAddressRequest--;
  return o;
}

void checkGoogleCloudApigeeV1ActivateNatAddressRequest(
    api.GoogleCloudApigeeV1ActivateNatAddressRequest o) {
  buildCounterGoogleCloudApigeeV1ActivateNatAddressRequest++;
  if (buildCounterGoogleCloudApigeeV1ActivateNatAddressRequest < 3) {}
  buildCounterGoogleCloudApigeeV1ActivateNatAddressRequest--;
}

core.int buildCounterGoogleCloudApigeeV1Alias = 0;
api.GoogleCloudApigeeV1Alias buildGoogleCloudApigeeV1Alias() {
  var o = api.GoogleCloudApigeeV1Alias();
  buildCounterGoogleCloudApigeeV1Alias++;
  if (buildCounterGoogleCloudApigeeV1Alias < 3) {
    o.alias = 'foo';
    o.certsInfo = buildGoogleCloudApigeeV1Certificate();
    o.type = 'foo';
  }
  buildCounterGoogleCloudApigeeV1Alias--;
  return o;
}

void checkGoogleCloudApigeeV1Alias(api.GoogleCloudApigeeV1Alias o) {
  buildCounterGoogleCloudApigeeV1Alias++;
  if (buildCounterGoogleCloudApigeeV1Alias < 3) {
    unittest.expect(
      o.alias!,
      unittest.equals('foo'),
    );
    checkGoogleCloudApigeeV1Certificate(
        o.certsInfo! as api.GoogleCloudApigeeV1Certificate);
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1Alias--;
}

core.int buildCounterGoogleCloudApigeeV1AliasRevisionConfig = 0;
api.GoogleCloudApigeeV1AliasRevisionConfig
    buildGoogleCloudApigeeV1AliasRevisionConfig() {
  var o = api.GoogleCloudApigeeV1AliasRevisionConfig();
  buildCounterGoogleCloudApigeeV1AliasRevisionConfig++;
  if (buildCounterGoogleCloudApigeeV1AliasRevisionConfig < 3) {
    o.location = 'foo';
    o.name = 'foo';
    o.type = 'foo';
  }
  buildCounterGoogleCloudApigeeV1AliasRevisionConfig--;
  return o;
}

void checkGoogleCloudApigeeV1AliasRevisionConfig(
    api.GoogleCloudApigeeV1AliasRevisionConfig o) {
  buildCounterGoogleCloudApigeeV1AliasRevisionConfig++;
  if (buildCounterGoogleCloudApigeeV1AliasRevisionConfig < 3) {
    unittest.expect(
      o.location!,
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
  buildCounterGoogleCloudApigeeV1AliasRevisionConfig--;
}

core.int buildCounterGoogleCloudApigeeV1ApiCategory = 0;
api.GoogleCloudApigeeV1ApiCategory buildGoogleCloudApigeeV1ApiCategory() {
  var o = api.GoogleCloudApigeeV1ApiCategory();
  buildCounterGoogleCloudApigeeV1ApiCategory++;
  if (buildCounterGoogleCloudApigeeV1ApiCategory < 3) {
    o.data = buildGoogleCloudApigeeV1ApiCategoryData();
    o.errorCode = 'foo';
    o.message = 'foo';
    o.requestId = 'foo';
    o.status = 'foo';
  }
  buildCounterGoogleCloudApigeeV1ApiCategory--;
  return o;
}

void checkGoogleCloudApigeeV1ApiCategory(api.GoogleCloudApigeeV1ApiCategory o) {
  buildCounterGoogleCloudApigeeV1ApiCategory++;
  if (buildCounterGoogleCloudApigeeV1ApiCategory < 3) {
    checkGoogleCloudApigeeV1ApiCategoryData(
        o.data! as api.GoogleCloudApigeeV1ApiCategoryData);
    unittest.expect(
      o.errorCode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.message!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.requestId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.status!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1ApiCategory--;
}

core.int buildCounterGoogleCloudApigeeV1ApiCategoryData = 0;
api.GoogleCloudApigeeV1ApiCategoryData
    buildGoogleCloudApigeeV1ApiCategoryData() {
  var o = api.GoogleCloudApigeeV1ApiCategoryData();
  buildCounterGoogleCloudApigeeV1ApiCategoryData++;
  if (buildCounterGoogleCloudApigeeV1ApiCategoryData < 3) {
    o.id = 'foo';
    o.name = 'foo';
    o.siteId = 'foo';
    o.updateTime = 'foo';
  }
  buildCounterGoogleCloudApigeeV1ApiCategoryData--;
  return o;
}

void checkGoogleCloudApigeeV1ApiCategoryData(
    api.GoogleCloudApigeeV1ApiCategoryData o) {
  buildCounterGoogleCloudApigeeV1ApiCategoryData++;
  if (buildCounterGoogleCloudApigeeV1ApiCategoryData < 3) {
    unittest.expect(
      o.id!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.siteId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.updateTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1ApiCategoryData--;
}

core.List<core.String> buildUnnamed3332() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3332(core.List<core.String> o) {
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

core.List<api.GoogleCloudApigeeV1Attribute> buildUnnamed3333() {
  var o = <api.GoogleCloudApigeeV1Attribute>[];
  o.add(buildGoogleCloudApigeeV1Attribute());
  o.add(buildGoogleCloudApigeeV1Attribute());
  return o;
}

void checkUnnamed3333(core.List<api.GoogleCloudApigeeV1Attribute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Attribute(o[0] as api.GoogleCloudApigeeV1Attribute);
  checkGoogleCloudApigeeV1Attribute(o[1] as api.GoogleCloudApigeeV1Attribute);
}

core.List<core.String> buildUnnamed3334() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3334(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed3335() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3335(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed3336() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3336(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1ApiProduct = 0;
api.GoogleCloudApigeeV1ApiProduct buildGoogleCloudApigeeV1ApiProduct() {
  var o = api.GoogleCloudApigeeV1ApiProduct();
  buildCounterGoogleCloudApigeeV1ApiProduct++;
  if (buildCounterGoogleCloudApigeeV1ApiProduct < 3) {
    o.apiResources = buildUnnamed3332();
    o.approvalType = 'foo';
    o.attributes = buildUnnamed3333();
    o.createdAt = 'foo';
    o.description = 'foo';
    o.displayName = 'foo';
    o.environments = buildUnnamed3334();
    o.lastModifiedAt = 'foo';
    o.name = 'foo';
    o.operationGroup = buildGoogleCloudApigeeV1OperationGroup();
    o.proxies = buildUnnamed3335();
    o.quota = 'foo';
    o.quotaInterval = 'foo';
    o.quotaTimeUnit = 'foo';
    o.scopes = buildUnnamed3336();
  }
  buildCounterGoogleCloudApigeeV1ApiProduct--;
  return o;
}

void checkGoogleCloudApigeeV1ApiProduct(api.GoogleCloudApigeeV1ApiProduct o) {
  buildCounterGoogleCloudApigeeV1ApiProduct++;
  if (buildCounterGoogleCloudApigeeV1ApiProduct < 3) {
    checkUnnamed3332(o.apiResources!);
    unittest.expect(
      o.approvalType!,
      unittest.equals('foo'),
    );
    checkUnnamed3333(o.attributes!);
    unittest.expect(
      o.createdAt!,
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
    checkUnnamed3334(o.environments!);
    unittest.expect(
      o.lastModifiedAt!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkGoogleCloudApigeeV1OperationGroup(
        o.operationGroup! as api.GoogleCloudApigeeV1OperationGroup);
    checkUnnamed3335(o.proxies!);
    unittest.expect(
      o.quota!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.quotaInterval!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.quotaTimeUnit!,
      unittest.equals('foo'),
    );
    checkUnnamed3336(o.scopes!);
  }
  buildCounterGoogleCloudApigeeV1ApiProduct--;
}

core.int buildCounterGoogleCloudApigeeV1ApiProductRef = 0;
api.GoogleCloudApigeeV1ApiProductRef buildGoogleCloudApigeeV1ApiProductRef() {
  var o = api.GoogleCloudApigeeV1ApiProductRef();
  buildCounterGoogleCloudApigeeV1ApiProductRef++;
  if (buildCounterGoogleCloudApigeeV1ApiProductRef < 3) {
    o.apiproduct = 'foo';
    o.status = 'foo';
  }
  buildCounterGoogleCloudApigeeV1ApiProductRef--;
  return o;
}

void checkGoogleCloudApigeeV1ApiProductRef(
    api.GoogleCloudApigeeV1ApiProductRef o) {
  buildCounterGoogleCloudApigeeV1ApiProductRef++;
  if (buildCounterGoogleCloudApigeeV1ApiProductRef < 3) {
    unittest.expect(
      o.apiproduct!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.status!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1ApiProductRef--;
}

core.List<core.String> buildUnnamed3337() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3337(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1ApiProxy = 0;
api.GoogleCloudApigeeV1ApiProxy buildGoogleCloudApigeeV1ApiProxy() {
  var o = api.GoogleCloudApigeeV1ApiProxy();
  buildCounterGoogleCloudApigeeV1ApiProxy++;
  if (buildCounterGoogleCloudApigeeV1ApiProxy < 3) {
    o.latestRevisionId = 'foo';
    o.metaData = buildGoogleCloudApigeeV1EntityMetadata();
    o.name = 'foo';
    o.revision = buildUnnamed3337();
  }
  buildCounterGoogleCloudApigeeV1ApiProxy--;
  return o;
}

void checkGoogleCloudApigeeV1ApiProxy(api.GoogleCloudApigeeV1ApiProxy o) {
  buildCounterGoogleCloudApigeeV1ApiProxy++;
  if (buildCounterGoogleCloudApigeeV1ApiProxy < 3) {
    unittest.expect(
      o.latestRevisionId!,
      unittest.equals('foo'),
    );
    checkGoogleCloudApigeeV1EntityMetadata(
        o.metaData! as api.GoogleCloudApigeeV1EntityMetadata);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed3337(o.revision!);
  }
  buildCounterGoogleCloudApigeeV1ApiProxy--;
}

core.List<core.String> buildUnnamed3338() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3338(core.List<core.String> o) {
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

core.Map<core.String, core.String> buildUnnamed3339() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed3339(core.Map<core.String, core.String> o) {
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

core.List<core.String> buildUnnamed3340() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3340(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed3341() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3341(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed3342() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3342(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed3343() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3343(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed3344() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3344(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed3345() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3345(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed3346() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3346(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed3347() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3347(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed3348() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3348(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1ApiProxyRevision = 0;
api.GoogleCloudApigeeV1ApiProxyRevision
    buildGoogleCloudApigeeV1ApiProxyRevision() {
  var o = api.GoogleCloudApigeeV1ApiProxyRevision();
  buildCounterGoogleCloudApigeeV1ApiProxyRevision++;
  if (buildCounterGoogleCloudApigeeV1ApiProxyRevision < 3) {
    o.basepaths = buildUnnamed3338();
    o.configurationVersion = buildGoogleCloudApigeeV1ConfigVersion();
    o.contextInfo = 'foo';
    o.createdAt = 'foo';
    o.description = 'foo';
    o.displayName = 'foo';
    o.entityMetaDataAsProperties = buildUnnamed3339();
    o.lastModifiedAt = 'foo';
    o.name = 'foo';
    o.policies = buildUnnamed3340();
    o.proxies = buildUnnamed3341();
    o.proxyEndpoints = buildUnnamed3342();
    o.resourceFiles = buildGoogleCloudApigeeV1ResourceFiles();
    o.resources = buildUnnamed3343();
    o.revision = 'foo';
    o.sharedFlows = buildUnnamed3344();
    o.spec = 'foo';
    o.targetEndpoints = buildUnnamed3345();
    o.targetServers = buildUnnamed3346();
    o.targets = buildUnnamed3347();
    o.teams = buildUnnamed3348();
    o.type = 'foo';
  }
  buildCounterGoogleCloudApigeeV1ApiProxyRevision--;
  return o;
}

void checkGoogleCloudApigeeV1ApiProxyRevision(
    api.GoogleCloudApigeeV1ApiProxyRevision o) {
  buildCounterGoogleCloudApigeeV1ApiProxyRevision++;
  if (buildCounterGoogleCloudApigeeV1ApiProxyRevision < 3) {
    checkUnnamed3338(o.basepaths!);
    checkGoogleCloudApigeeV1ConfigVersion(
        o.configurationVersion! as api.GoogleCloudApigeeV1ConfigVersion);
    unittest.expect(
      o.contextInfo!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.createdAt!,
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
    checkUnnamed3339(o.entityMetaDataAsProperties!);
    unittest.expect(
      o.lastModifiedAt!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed3340(o.policies!);
    checkUnnamed3341(o.proxies!);
    checkUnnamed3342(o.proxyEndpoints!);
    checkGoogleCloudApigeeV1ResourceFiles(
        o.resourceFiles! as api.GoogleCloudApigeeV1ResourceFiles);
    checkUnnamed3343(o.resources!);
    unittest.expect(
      o.revision!,
      unittest.equals('foo'),
    );
    checkUnnamed3344(o.sharedFlows!);
    unittest.expect(
      o.spec!,
      unittest.equals('foo'),
    );
    checkUnnamed3345(o.targetEndpoints!);
    checkUnnamed3346(o.targetServers!);
    checkUnnamed3347(o.targets!);
    checkUnnamed3348(o.teams!);
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1ApiProxyRevision--;
}

core.int buildCounterGoogleCloudApigeeV1ApiResponseWrapper = 0;
api.GoogleCloudApigeeV1ApiResponseWrapper
    buildGoogleCloudApigeeV1ApiResponseWrapper() {
  var o = api.GoogleCloudApigeeV1ApiResponseWrapper();
  buildCounterGoogleCloudApigeeV1ApiResponseWrapper++;
  if (buildCounterGoogleCloudApigeeV1ApiResponseWrapper < 3) {
    o.errorCode = 'foo';
    o.message = 'foo';
    o.requestId = 'foo';
    o.status = 'foo';
  }
  buildCounterGoogleCloudApigeeV1ApiResponseWrapper--;
  return o;
}

void checkGoogleCloudApigeeV1ApiResponseWrapper(
    api.GoogleCloudApigeeV1ApiResponseWrapper o) {
  buildCounterGoogleCloudApigeeV1ApiResponseWrapper++;
  if (buildCounterGoogleCloudApigeeV1ApiResponseWrapper < 3) {
    unittest.expect(
      o.errorCode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.message!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.requestId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.status!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1ApiResponseWrapper--;
}

core.List<api.GoogleCloudApigeeV1ApiProductRef> buildUnnamed3349() {
  var o = <api.GoogleCloudApigeeV1ApiProductRef>[];
  o.add(buildGoogleCloudApigeeV1ApiProductRef());
  o.add(buildGoogleCloudApigeeV1ApiProductRef());
  return o;
}

void checkUnnamed3349(core.List<api.GoogleCloudApigeeV1ApiProductRef> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1ApiProductRef(
      o[0] as api.GoogleCloudApigeeV1ApiProductRef);
  checkGoogleCloudApigeeV1ApiProductRef(
      o[1] as api.GoogleCloudApigeeV1ApiProductRef);
}

core.List<api.GoogleCloudApigeeV1Attribute> buildUnnamed3350() {
  var o = <api.GoogleCloudApigeeV1Attribute>[];
  o.add(buildGoogleCloudApigeeV1Attribute());
  o.add(buildGoogleCloudApigeeV1Attribute());
  return o;
}

void checkUnnamed3350(core.List<api.GoogleCloudApigeeV1Attribute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Attribute(o[0] as api.GoogleCloudApigeeV1Attribute);
  checkGoogleCloudApigeeV1Attribute(o[1] as api.GoogleCloudApigeeV1Attribute);
}

core.List<api.GoogleCloudApigeeV1Credential> buildUnnamed3351() {
  var o = <api.GoogleCloudApigeeV1Credential>[];
  o.add(buildGoogleCloudApigeeV1Credential());
  o.add(buildGoogleCloudApigeeV1Credential());
  return o;
}

void checkUnnamed3351(core.List<api.GoogleCloudApigeeV1Credential> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Credential(o[0] as api.GoogleCloudApigeeV1Credential);
  checkGoogleCloudApigeeV1Credential(o[1] as api.GoogleCloudApigeeV1Credential);
}

core.List<core.String> buildUnnamed3352() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3352(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1App = 0;
api.GoogleCloudApigeeV1App buildGoogleCloudApigeeV1App() {
  var o = api.GoogleCloudApigeeV1App();
  buildCounterGoogleCloudApigeeV1App++;
  if (buildCounterGoogleCloudApigeeV1App < 3) {
    o.apiProducts = buildUnnamed3349();
    o.appId = 'foo';
    o.attributes = buildUnnamed3350();
    o.callbackUrl = 'foo';
    o.companyName = 'foo';
    o.createdAt = 'foo';
    o.credentials = buildUnnamed3351();
    o.developerId = 'foo';
    o.keyExpiresIn = 'foo';
    o.lastModifiedAt = 'foo';
    o.name = 'foo';
    o.scopes = buildUnnamed3352();
    o.status = 'foo';
  }
  buildCounterGoogleCloudApigeeV1App--;
  return o;
}

void checkGoogleCloudApigeeV1App(api.GoogleCloudApigeeV1App o) {
  buildCounterGoogleCloudApigeeV1App++;
  if (buildCounterGoogleCloudApigeeV1App < 3) {
    checkUnnamed3349(o.apiProducts!);
    unittest.expect(
      o.appId!,
      unittest.equals('foo'),
    );
    checkUnnamed3350(o.attributes!);
    unittest.expect(
      o.callbackUrl!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.companyName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.createdAt!,
      unittest.equals('foo'),
    );
    checkUnnamed3351(o.credentials!);
    unittest.expect(
      o.developerId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.keyExpiresIn!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.lastModifiedAt!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed3352(o.scopes!);
    unittest.expect(
      o.status!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1App--;
}

core.int buildCounterGoogleCloudApigeeV1AsyncQuery = 0;
api.GoogleCloudApigeeV1AsyncQuery buildGoogleCloudApigeeV1AsyncQuery() {
  var o = api.GoogleCloudApigeeV1AsyncQuery();
  buildCounterGoogleCloudApigeeV1AsyncQuery++;
  if (buildCounterGoogleCloudApigeeV1AsyncQuery < 3) {
    o.created = 'foo';
    o.envgroupHostname = 'foo';
    o.error = 'foo';
    o.executionTime = 'foo';
    o.name = 'foo';
    o.queryParams = buildGoogleCloudApigeeV1QueryMetadata();
    o.reportDefinitionId = 'foo';
    o.result = buildGoogleCloudApigeeV1AsyncQueryResult();
    o.resultFileSize = 'foo';
    o.resultRows = 'foo';
    o.self = 'foo';
    o.state = 'foo';
    o.updated = 'foo';
  }
  buildCounterGoogleCloudApigeeV1AsyncQuery--;
  return o;
}

void checkGoogleCloudApigeeV1AsyncQuery(api.GoogleCloudApigeeV1AsyncQuery o) {
  buildCounterGoogleCloudApigeeV1AsyncQuery++;
  if (buildCounterGoogleCloudApigeeV1AsyncQuery < 3) {
    unittest.expect(
      o.created!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.envgroupHostname!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.error!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.executionTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkGoogleCloudApigeeV1QueryMetadata(
        o.queryParams! as api.GoogleCloudApigeeV1QueryMetadata);
    unittest.expect(
      o.reportDefinitionId!,
      unittest.equals('foo'),
    );
    checkGoogleCloudApigeeV1AsyncQueryResult(
        o.result! as api.GoogleCloudApigeeV1AsyncQueryResult);
    unittest.expect(
      o.resultFileSize!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.resultRows!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.self!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.updated!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1AsyncQuery--;
}

core.int buildCounterGoogleCloudApigeeV1AsyncQueryResult = 0;
api.GoogleCloudApigeeV1AsyncQueryResult
    buildGoogleCloudApigeeV1AsyncQueryResult() {
  var o = api.GoogleCloudApigeeV1AsyncQueryResult();
  buildCounterGoogleCloudApigeeV1AsyncQueryResult++;
  if (buildCounterGoogleCloudApigeeV1AsyncQueryResult < 3) {
    o.expires = 'foo';
    o.self = 'foo';
  }
  buildCounterGoogleCloudApigeeV1AsyncQueryResult--;
  return o;
}

void checkGoogleCloudApigeeV1AsyncQueryResult(
    api.GoogleCloudApigeeV1AsyncQueryResult o) {
  buildCounterGoogleCloudApigeeV1AsyncQueryResult++;
  if (buildCounterGoogleCloudApigeeV1AsyncQueryResult < 3) {
    unittest.expect(
      o.expires!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.self!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1AsyncQueryResult--;
}

core.List<core.Object> buildUnnamed3353() {
  var o = <core.Object>[];
  o.add({
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  });
  o.add({
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  });
  return o;
}

void checkUnnamed3353(core.List<core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted3 = (o[0]) as core.Map;
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
  var casted4 = (o[1]) as core.Map;
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

core.int buildCounterGoogleCloudApigeeV1AsyncQueryResultView = 0;
api.GoogleCloudApigeeV1AsyncQueryResultView
    buildGoogleCloudApigeeV1AsyncQueryResultView() {
  var o = api.GoogleCloudApigeeV1AsyncQueryResultView();
  buildCounterGoogleCloudApigeeV1AsyncQueryResultView++;
  if (buildCounterGoogleCloudApigeeV1AsyncQueryResultView < 3) {
    o.code = 42;
    o.error = 'foo';
    o.metadata = buildGoogleCloudApigeeV1QueryMetadata();
    o.rows = buildUnnamed3353();
    o.state = 'foo';
  }
  buildCounterGoogleCloudApigeeV1AsyncQueryResultView--;
  return o;
}

void checkGoogleCloudApigeeV1AsyncQueryResultView(
    api.GoogleCloudApigeeV1AsyncQueryResultView o) {
  buildCounterGoogleCloudApigeeV1AsyncQueryResultView++;
  if (buildCounterGoogleCloudApigeeV1AsyncQueryResultView < 3) {
    unittest.expect(
      o.code!,
      unittest.equals(42),
    );
    unittest.expect(
      o.error!,
      unittest.equals('foo'),
    );
    checkGoogleCloudApigeeV1QueryMetadata(
        o.metadata! as api.GoogleCloudApigeeV1QueryMetadata);
    checkUnnamed3353(o.rows!);
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1AsyncQueryResultView--;
}

core.int buildCounterGoogleCloudApigeeV1Attribute = 0;
api.GoogleCloudApigeeV1Attribute buildGoogleCloudApigeeV1Attribute() {
  var o = api.GoogleCloudApigeeV1Attribute();
  buildCounterGoogleCloudApigeeV1Attribute++;
  if (buildCounterGoogleCloudApigeeV1Attribute < 3) {
    o.name = 'foo';
    o.value = 'foo';
  }
  buildCounterGoogleCloudApigeeV1Attribute--;
  return o;
}

void checkGoogleCloudApigeeV1Attribute(api.GoogleCloudApigeeV1Attribute o) {
  buildCounterGoogleCloudApigeeV1Attribute++;
  if (buildCounterGoogleCloudApigeeV1Attribute < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1Attribute--;
}

core.List<api.GoogleCloudApigeeV1Attribute> buildUnnamed3354() {
  var o = <api.GoogleCloudApigeeV1Attribute>[];
  o.add(buildGoogleCloudApigeeV1Attribute());
  o.add(buildGoogleCloudApigeeV1Attribute());
  return o;
}

void checkUnnamed3354(core.List<api.GoogleCloudApigeeV1Attribute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Attribute(o[0] as api.GoogleCloudApigeeV1Attribute);
  checkGoogleCloudApigeeV1Attribute(o[1] as api.GoogleCloudApigeeV1Attribute);
}

core.int buildCounterGoogleCloudApigeeV1Attributes = 0;
api.GoogleCloudApigeeV1Attributes buildGoogleCloudApigeeV1Attributes() {
  var o = api.GoogleCloudApigeeV1Attributes();
  buildCounterGoogleCloudApigeeV1Attributes++;
  if (buildCounterGoogleCloudApigeeV1Attributes < 3) {
    o.attribute = buildUnnamed3354();
  }
  buildCounterGoogleCloudApigeeV1Attributes--;
  return o;
}

void checkGoogleCloudApigeeV1Attributes(api.GoogleCloudApigeeV1Attributes o) {
  buildCounterGoogleCloudApigeeV1Attributes++;
  if (buildCounterGoogleCloudApigeeV1Attributes < 3) {
    checkUnnamed3354(o.attribute!);
  }
  buildCounterGoogleCloudApigeeV1Attributes--;
}

core.int buildCounterGoogleCloudApigeeV1CanaryEvaluation = 0;
api.GoogleCloudApigeeV1CanaryEvaluation
    buildGoogleCloudApigeeV1CanaryEvaluation() {
  var o = api.GoogleCloudApigeeV1CanaryEvaluation();
  buildCounterGoogleCloudApigeeV1CanaryEvaluation++;
  if (buildCounterGoogleCloudApigeeV1CanaryEvaluation < 3) {
    o.control = 'foo';
    o.createTime = 'foo';
    o.endTime = 'foo';
    o.metricLabels = buildGoogleCloudApigeeV1CanaryEvaluationMetricLabels();
    o.name = 'foo';
    o.startTime = 'foo';
    o.state = 'foo';
    o.treatment = 'foo';
    o.verdict = 'foo';
  }
  buildCounterGoogleCloudApigeeV1CanaryEvaluation--;
  return o;
}

void checkGoogleCloudApigeeV1CanaryEvaluation(
    api.GoogleCloudApigeeV1CanaryEvaluation o) {
  buildCounterGoogleCloudApigeeV1CanaryEvaluation++;
  if (buildCounterGoogleCloudApigeeV1CanaryEvaluation < 3) {
    unittest.expect(
      o.control!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.createTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.endTime!,
      unittest.equals('foo'),
    );
    checkGoogleCloudApigeeV1CanaryEvaluationMetricLabels(
        o.metricLabels! as api.GoogleCloudApigeeV1CanaryEvaluationMetricLabels);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.startTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.treatment!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.verdict!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1CanaryEvaluation--;
}

core.int buildCounterGoogleCloudApigeeV1CanaryEvaluationMetricLabels = 0;
api.GoogleCloudApigeeV1CanaryEvaluationMetricLabels
    buildGoogleCloudApigeeV1CanaryEvaluationMetricLabels() {
  var o = api.GoogleCloudApigeeV1CanaryEvaluationMetricLabels();
  buildCounterGoogleCloudApigeeV1CanaryEvaluationMetricLabels++;
  if (buildCounterGoogleCloudApigeeV1CanaryEvaluationMetricLabels < 3) {
    o.env = 'foo';
    o.instanceId = 'foo';
    o.location = 'foo';
  }
  buildCounterGoogleCloudApigeeV1CanaryEvaluationMetricLabels--;
  return o;
}

void checkGoogleCloudApigeeV1CanaryEvaluationMetricLabels(
    api.GoogleCloudApigeeV1CanaryEvaluationMetricLabels o) {
  buildCounterGoogleCloudApigeeV1CanaryEvaluationMetricLabels++;
  if (buildCounterGoogleCloudApigeeV1CanaryEvaluationMetricLabels < 3) {
    unittest.expect(
      o.env!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.instanceId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.location!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1CanaryEvaluationMetricLabels--;
}

core.List<core.String> buildUnnamed3355() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3355(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1CertInfo = 0;
api.GoogleCloudApigeeV1CertInfo buildGoogleCloudApigeeV1CertInfo() {
  var o = api.GoogleCloudApigeeV1CertInfo();
  buildCounterGoogleCloudApigeeV1CertInfo++;
  if (buildCounterGoogleCloudApigeeV1CertInfo < 3) {
    o.basicConstraints = 'foo';
    o.expiryDate = 'foo';
    o.isValid = 'foo';
    o.issuer = 'foo';
    o.publicKey = 'foo';
    o.serialNumber = 'foo';
    o.sigAlgName = 'foo';
    o.subject = 'foo';
    o.subjectAlternativeNames = buildUnnamed3355();
    o.validFrom = 'foo';
    o.version = 42;
  }
  buildCounterGoogleCloudApigeeV1CertInfo--;
  return o;
}

void checkGoogleCloudApigeeV1CertInfo(api.GoogleCloudApigeeV1CertInfo o) {
  buildCounterGoogleCloudApigeeV1CertInfo++;
  if (buildCounterGoogleCloudApigeeV1CertInfo < 3) {
    unittest.expect(
      o.basicConstraints!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.expiryDate!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.isValid!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.issuer!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.publicKey!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.serialNumber!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.sigAlgName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.subject!,
      unittest.equals('foo'),
    );
    checkUnnamed3355(o.subjectAlternativeNames!);
    unittest.expect(
      o.validFrom!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.version!,
      unittest.equals(42),
    );
  }
  buildCounterGoogleCloudApigeeV1CertInfo--;
}

core.List<api.GoogleCloudApigeeV1CertInfo> buildUnnamed3356() {
  var o = <api.GoogleCloudApigeeV1CertInfo>[];
  o.add(buildGoogleCloudApigeeV1CertInfo());
  o.add(buildGoogleCloudApigeeV1CertInfo());
  return o;
}

void checkUnnamed3356(core.List<api.GoogleCloudApigeeV1CertInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1CertInfo(o[0] as api.GoogleCloudApigeeV1CertInfo);
  checkGoogleCloudApigeeV1CertInfo(o[1] as api.GoogleCloudApigeeV1CertInfo);
}

core.int buildCounterGoogleCloudApigeeV1Certificate = 0;
api.GoogleCloudApigeeV1Certificate buildGoogleCloudApigeeV1Certificate() {
  var o = api.GoogleCloudApigeeV1Certificate();
  buildCounterGoogleCloudApigeeV1Certificate++;
  if (buildCounterGoogleCloudApigeeV1Certificate < 3) {
    o.certInfo = buildUnnamed3356();
  }
  buildCounterGoogleCloudApigeeV1Certificate--;
  return o;
}

void checkGoogleCloudApigeeV1Certificate(api.GoogleCloudApigeeV1Certificate o) {
  buildCounterGoogleCloudApigeeV1Certificate++;
  if (buildCounterGoogleCloudApigeeV1Certificate < 3) {
    checkUnnamed3356(o.certInfo!);
  }
  buildCounterGoogleCloudApigeeV1Certificate--;
}

core.int buildCounterGoogleCloudApigeeV1CommonNameConfig = 0;
api.GoogleCloudApigeeV1CommonNameConfig
    buildGoogleCloudApigeeV1CommonNameConfig() {
  var o = api.GoogleCloudApigeeV1CommonNameConfig();
  buildCounterGoogleCloudApigeeV1CommonNameConfig++;
  if (buildCounterGoogleCloudApigeeV1CommonNameConfig < 3) {
    o.matchWildCards = true;
    o.name = 'foo';
  }
  buildCounterGoogleCloudApigeeV1CommonNameConfig--;
  return o;
}

void checkGoogleCloudApigeeV1CommonNameConfig(
    api.GoogleCloudApigeeV1CommonNameConfig o) {
  buildCounterGoogleCloudApigeeV1CommonNameConfig++;
  if (buildCounterGoogleCloudApigeeV1CommonNameConfig < 3) {
    unittest.expect(o.matchWildCards!, unittest.isTrue);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1CommonNameConfig--;
}

core.int buildCounterGoogleCloudApigeeV1ConfigVersion = 0;
api.GoogleCloudApigeeV1ConfigVersion buildGoogleCloudApigeeV1ConfigVersion() {
  var o = api.GoogleCloudApigeeV1ConfigVersion();
  buildCounterGoogleCloudApigeeV1ConfigVersion++;
  if (buildCounterGoogleCloudApigeeV1ConfigVersion < 3) {
    o.majorVersion = 42;
    o.minorVersion = 42;
  }
  buildCounterGoogleCloudApigeeV1ConfigVersion--;
  return o;
}

void checkGoogleCloudApigeeV1ConfigVersion(
    api.GoogleCloudApigeeV1ConfigVersion o) {
  buildCounterGoogleCloudApigeeV1ConfigVersion++;
  if (buildCounterGoogleCloudApigeeV1ConfigVersion < 3) {
    unittest.expect(
      o.majorVersion!,
      unittest.equals(42),
    );
    unittest.expect(
      o.minorVersion!,
      unittest.equals(42),
    );
  }
  buildCounterGoogleCloudApigeeV1ConfigVersion--;
}

core.List<api.GoogleCloudApigeeV1ApiProductRef> buildUnnamed3357() {
  var o = <api.GoogleCloudApigeeV1ApiProductRef>[];
  o.add(buildGoogleCloudApigeeV1ApiProductRef());
  o.add(buildGoogleCloudApigeeV1ApiProductRef());
  return o;
}

void checkUnnamed3357(core.List<api.GoogleCloudApigeeV1ApiProductRef> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1ApiProductRef(
      o[0] as api.GoogleCloudApigeeV1ApiProductRef);
  checkGoogleCloudApigeeV1ApiProductRef(
      o[1] as api.GoogleCloudApigeeV1ApiProductRef);
}

core.List<api.GoogleCloudApigeeV1Attribute> buildUnnamed3358() {
  var o = <api.GoogleCloudApigeeV1Attribute>[];
  o.add(buildGoogleCloudApigeeV1Attribute());
  o.add(buildGoogleCloudApigeeV1Attribute());
  return o;
}

void checkUnnamed3358(core.List<api.GoogleCloudApigeeV1Attribute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Attribute(o[0] as api.GoogleCloudApigeeV1Attribute);
  checkGoogleCloudApigeeV1Attribute(o[1] as api.GoogleCloudApigeeV1Attribute);
}

core.List<core.String> buildUnnamed3359() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3359(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1Credential = 0;
api.GoogleCloudApigeeV1Credential buildGoogleCloudApigeeV1Credential() {
  var o = api.GoogleCloudApigeeV1Credential();
  buildCounterGoogleCloudApigeeV1Credential++;
  if (buildCounterGoogleCloudApigeeV1Credential < 3) {
    o.apiProducts = buildUnnamed3357();
    o.attributes = buildUnnamed3358();
    o.consumerKey = 'foo';
    o.consumerSecret = 'foo';
    o.expiresAt = 'foo';
    o.issuedAt = 'foo';
    o.scopes = buildUnnamed3359();
    o.status = 'foo';
  }
  buildCounterGoogleCloudApigeeV1Credential--;
  return o;
}

void checkGoogleCloudApigeeV1Credential(api.GoogleCloudApigeeV1Credential o) {
  buildCounterGoogleCloudApigeeV1Credential++;
  if (buildCounterGoogleCloudApigeeV1Credential < 3) {
    checkUnnamed3357(o.apiProducts!);
    checkUnnamed3358(o.attributes!);
    unittest.expect(
      o.consumerKey!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.consumerSecret!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.expiresAt!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.issuedAt!,
      unittest.equals('foo'),
    );
    checkUnnamed3359(o.scopes!);
    unittest.expect(
      o.status!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1Credential--;
}

core.List<core.String> buildUnnamed3360() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3360(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed3361() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3361(core.List<core.String> o) {
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

core.List<api.GoogleCloudApigeeV1CustomReportMetric> buildUnnamed3362() {
  var o = <api.GoogleCloudApigeeV1CustomReportMetric>[];
  o.add(buildGoogleCloudApigeeV1CustomReportMetric());
  o.add(buildGoogleCloudApigeeV1CustomReportMetric());
  return o;
}

void checkUnnamed3362(core.List<api.GoogleCloudApigeeV1CustomReportMetric> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1CustomReportMetric(
      o[0] as api.GoogleCloudApigeeV1CustomReportMetric);
  checkGoogleCloudApigeeV1CustomReportMetric(
      o[1] as api.GoogleCloudApigeeV1CustomReportMetric);
}

core.List<api.GoogleCloudApigeeV1ReportProperty> buildUnnamed3363() {
  var o = <api.GoogleCloudApigeeV1ReportProperty>[];
  o.add(buildGoogleCloudApigeeV1ReportProperty());
  o.add(buildGoogleCloudApigeeV1ReportProperty());
  return o;
}

void checkUnnamed3363(core.List<api.GoogleCloudApigeeV1ReportProperty> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1ReportProperty(
      o[0] as api.GoogleCloudApigeeV1ReportProperty);
  checkGoogleCloudApigeeV1ReportProperty(
      o[1] as api.GoogleCloudApigeeV1ReportProperty);
}

core.List<core.String> buildUnnamed3364() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3364(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed3365() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3365(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1CustomReport = 0;
api.GoogleCloudApigeeV1CustomReport buildGoogleCloudApigeeV1CustomReport() {
  var o = api.GoogleCloudApigeeV1CustomReport();
  buildCounterGoogleCloudApigeeV1CustomReport++;
  if (buildCounterGoogleCloudApigeeV1CustomReport < 3) {
    o.chartType = 'foo';
    o.comments = buildUnnamed3360();
    o.createdAt = 'foo';
    o.dimensions = buildUnnamed3361();
    o.displayName = 'foo';
    o.environment = 'foo';
    o.filter = 'foo';
    o.fromTime = 'foo';
    o.lastModifiedAt = 'foo';
    o.lastViewedAt = 'foo';
    o.limit = 'foo';
    o.metrics = buildUnnamed3362();
    o.name = 'foo';
    o.offset = 'foo';
    o.organization = 'foo';
    o.properties = buildUnnamed3363();
    o.sortByCols = buildUnnamed3364();
    o.sortOrder = 'foo';
    o.tags = buildUnnamed3365();
    o.timeUnit = 'foo';
    o.toTime = 'foo';
    o.topk = 'foo';
  }
  buildCounterGoogleCloudApigeeV1CustomReport--;
  return o;
}

void checkGoogleCloudApigeeV1CustomReport(
    api.GoogleCloudApigeeV1CustomReport o) {
  buildCounterGoogleCloudApigeeV1CustomReport++;
  if (buildCounterGoogleCloudApigeeV1CustomReport < 3) {
    unittest.expect(
      o.chartType!,
      unittest.equals('foo'),
    );
    checkUnnamed3360(o.comments!);
    unittest.expect(
      o.createdAt!,
      unittest.equals('foo'),
    );
    checkUnnamed3361(o.dimensions!);
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.environment!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.filter!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.fromTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.lastModifiedAt!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.lastViewedAt!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.limit!,
      unittest.equals('foo'),
    );
    checkUnnamed3362(o.metrics!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.offset!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.organization!,
      unittest.equals('foo'),
    );
    checkUnnamed3363(o.properties!);
    checkUnnamed3364(o.sortByCols!);
    unittest.expect(
      o.sortOrder!,
      unittest.equals('foo'),
    );
    checkUnnamed3365(o.tags!);
    unittest.expect(
      o.timeUnit!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.toTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.topk!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1CustomReport--;
}

core.int buildCounterGoogleCloudApigeeV1CustomReportMetric = 0;
api.GoogleCloudApigeeV1CustomReportMetric
    buildGoogleCloudApigeeV1CustomReportMetric() {
  var o = api.GoogleCloudApigeeV1CustomReportMetric();
  buildCounterGoogleCloudApigeeV1CustomReportMetric++;
  if (buildCounterGoogleCloudApigeeV1CustomReportMetric < 3) {
    o.function = 'foo';
    o.name = 'foo';
  }
  buildCounterGoogleCloudApigeeV1CustomReportMetric--;
  return o;
}

void checkGoogleCloudApigeeV1CustomReportMetric(
    api.GoogleCloudApigeeV1CustomReportMetric o) {
  buildCounterGoogleCloudApigeeV1CustomReportMetric++;
  if (buildCounterGoogleCloudApigeeV1CustomReportMetric < 3) {
    unittest.expect(
      o.function!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1CustomReportMetric--;
}

core.int buildCounterGoogleCloudApigeeV1DataCollector = 0;
api.GoogleCloudApigeeV1DataCollector buildGoogleCloudApigeeV1DataCollector() {
  var o = api.GoogleCloudApigeeV1DataCollector();
  buildCounterGoogleCloudApigeeV1DataCollector++;
  if (buildCounterGoogleCloudApigeeV1DataCollector < 3) {
    o.createdAt = 'foo';
    o.description = 'foo';
    o.lastModifiedAt = 'foo';
    o.name = 'foo';
    o.type = 'foo';
  }
  buildCounterGoogleCloudApigeeV1DataCollector--;
  return o;
}

void checkGoogleCloudApigeeV1DataCollector(
    api.GoogleCloudApigeeV1DataCollector o) {
  buildCounterGoogleCloudApigeeV1DataCollector++;
  if (buildCounterGoogleCloudApigeeV1DataCollector < 3) {
    unittest.expect(
      o.createdAt!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.lastModifiedAt!,
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
  buildCounterGoogleCloudApigeeV1DataCollector--;
}

core.int buildCounterGoogleCloudApigeeV1DataCollectorConfig = 0;
api.GoogleCloudApigeeV1DataCollectorConfig
    buildGoogleCloudApigeeV1DataCollectorConfig() {
  var o = api.GoogleCloudApigeeV1DataCollectorConfig();
  buildCounterGoogleCloudApigeeV1DataCollectorConfig++;
  if (buildCounterGoogleCloudApigeeV1DataCollectorConfig < 3) {
    o.name = 'foo';
    o.type = 'foo';
  }
  buildCounterGoogleCloudApigeeV1DataCollectorConfig--;
  return o;
}

void checkGoogleCloudApigeeV1DataCollectorConfig(
    api.GoogleCloudApigeeV1DataCollectorConfig o) {
  buildCounterGoogleCloudApigeeV1DataCollectorConfig++;
  if (buildCounterGoogleCloudApigeeV1DataCollectorConfig < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1DataCollectorConfig--;
}

core.int buildCounterGoogleCloudApigeeV1Datastore = 0;
api.GoogleCloudApigeeV1Datastore buildGoogleCloudApigeeV1Datastore() {
  var o = api.GoogleCloudApigeeV1Datastore();
  buildCounterGoogleCloudApigeeV1Datastore++;
  if (buildCounterGoogleCloudApigeeV1Datastore < 3) {
    o.createTime = 'foo';
    o.datastoreConfig = buildGoogleCloudApigeeV1DatastoreConfig();
    o.displayName = 'foo';
    o.lastUpdateTime = 'foo';
    o.org = 'foo';
    o.self = 'foo';
    o.targetType = 'foo';
  }
  buildCounterGoogleCloudApigeeV1Datastore--;
  return o;
}

void checkGoogleCloudApigeeV1Datastore(api.GoogleCloudApigeeV1Datastore o) {
  buildCounterGoogleCloudApigeeV1Datastore++;
  if (buildCounterGoogleCloudApigeeV1Datastore < 3) {
    unittest.expect(
      o.createTime!,
      unittest.equals('foo'),
    );
    checkGoogleCloudApigeeV1DatastoreConfig(
        o.datastoreConfig! as api.GoogleCloudApigeeV1DatastoreConfig);
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.lastUpdateTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.org!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.self!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.targetType!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1Datastore--;
}

core.int buildCounterGoogleCloudApigeeV1DatastoreConfig = 0;
api.GoogleCloudApigeeV1DatastoreConfig
    buildGoogleCloudApigeeV1DatastoreConfig() {
  var o = api.GoogleCloudApigeeV1DatastoreConfig();
  buildCounterGoogleCloudApigeeV1DatastoreConfig++;
  if (buildCounterGoogleCloudApigeeV1DatastoreConfig < 3) {
    o.bucketName = 'foo';
    o.datasetName = 'foo';
    o.path = 'foo';
    o.projectId = 'foo';
    o.tablePrefix = 'foo';
  }
  buildCounterGoogleCloudApigeeV1DatastoreConfig--;
  return o;
}

void checkGoogleCloudApigeeV1DatastoreConfig(
    api.GoogleCloudApigeeV1DatastoreConfig o) {
  buildCounterGoogleCloudApigeeV1DatastoreConfig++;
  if (buildCounterGoogleCloudApigeeV1DatastoreConfig < 3) {
    unittest.expect(
      o.bucketName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.datasetName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.path!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.projectId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.tablePrefix!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1DatastoreConfig--;
}

core.int buildCounterGoogleCloudApigeeV1DateRange = 0;
api.GoogleCloudApigeeV1DateRange buildGoogleCloudApigeeV1DateRange() {
  var o = api.GoogleCloudApigeeV1DateRange();
  buildCounterGoogleCloudApigeeV1DateRange++;
  if (buildCounterGoogleCloudApigeeV1DateRange < 3) {
    o.end = 'foo';
    o.start = 'foo';
  }
  buildCounterGoogleCloudApigeeV1DateRange--;
  return o;
}

void checkGoogleCloudApigeeV1DateRange(api.GoogleCloudApigeeV1DateRange o) {
  buildCounterGoogleCloudApigeeV1DateRange++;
  if (buildCounterGoogleCloudApigeeV1DateRange < 3) {
    unittest.expect(
      o.end!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.start!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1DateRange--;
}

core.List<core.String> buildUnnamed3366() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3366(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed3367() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3367(core.List<core.String> o) {
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

core.Map<core.String, core.String> buildUnnamed3368() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed3368(core.Map<core.String, core.String> o) {
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

core.List<core.String> buildUnnamed3369() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3369(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed3370() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3370(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed3371() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3371(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed3372() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3372(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed3373() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3373(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1DebugMask = 0;
api.GoogleCloudApigeeV1DebugMask buildGoogleCloudApigeeV1DebugMask() {
  var o = api.GoogleCloudApigeeV1DebugMask();
  buildCounterGoogleCloudApigeeV1DebugMask++;
  if (buildCounterGoogleCloudApigeeV1DebugMask < 3) {
    o.faultJSONPaths = buildUnnamed3366();
    o.faultXPaths = buildUnnamed3367();
    o.name = 'foo';
    o.namespaces = buildUnnamed3368();
    o.requestJSONPaths = buildUnnamed3369();
    o.requestXPaths = buildUnnamed3370();
    o.responseJSONPaths = buildUnnamed3371();
    o.responseXPaths = buildUnnamed3372();
    o.variables = buildUnnamed3373();
  }
  buildCounterGoogleCloudApigeeV1DebugMask--;
  return o;
}

void checkGoogleCloudApigeeV1DebugMask(api.GoogleCloudApigeeV1DebugMask o) {
  buildCounterGoogleCloudApigeeV1DebugMask++;
  if (buildCounterGoogleCloudApigeeV1DebugMask < 3) {
    checkUnnamed3366(o.faultJSONPaths!);
    checkUnnamed3367(o.faultXPaths!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed3368(o.namespaces!);
    checkUnnamed3369(o.requestJSONPaths!);
    checkUnnamed3370(o.requestXPaths!);
    checkUnnamed3371(o.responseJSONPaths!);
    checkUnnamed3372(o.responseXPaths!);
    checkUnnamed3373(o.variables!);
  }
  buildCounterGoogleCloudApigeeV1DebugMask--;
}

core.int buildCounterGoogleCloudApigeeV1DebugSession = 0;
api.GoogleCloudApigeeV1DebugSession buildGoogleCloudApigeeV1DebugSession() {
  var o = api.GoogleCloudApigeeV1DebugSession();
  buildCounterGoogleCloudApigeeV1DebugSession++;
  if (buildCounterGoogleCloudApigeeV1DebugSession < 3) {
    o.count = 42;
    o.filter = 'foo';
    o.name = 'foo';
    o.timeout = 'foo';
    o.tracesize = 42;
    o.validity = 42;
  }
  buildCounterGoogleCloudApigeeV1DebugSession--;
  return o;
}

void checkGoogleCloudApigeeV1DebugSession(
    api.GoogleCloudApigeeV1DebugSession o) {
  buildCounterGoogleCloudApigeeV1DebugSession++;
  if (buildCounterGoogleCloudApigeeV1DebugSession < 3) {
    unittest.expect(
      o.count!,
      unittest.equals(42),
    );
    unittest.expect(
      o.filter!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.timeout!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.tracesize!,
      unittest.equals(42),
    );
    unittest.expect(
      o.validity!,
      unittest.equals(42),
    );
  }
  buildCounterGoogleCloudApigeeV1DebugSession--;
}

core.List<api.GoogleCloudApigeeV1Point> buildUnnamed3374() {
  var o = <api.GoogleCloudApigeeV1Point>[];
  o.add(buildGoogleCloudApigeeV1Point());
  o.add(buildGoogleCloudApigeeV1Point());
  return o;
}

void checkUnnamed3374(core.List<api.GoogleCloudApigeeV1Point> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Point(o[0] as api.GoogleCloudApigeeV1Point);
  checkGoogleCloudApigeeV1Point(o[1] as api.GoogleCloudApigeeV1Point);
}

core.int buildCounterGoogleCloudApigeeV1DebugSessionTransaction = 0;
api.GoogleCloudApigeeV1DebugSessionTransaction
    buildGoogleCloudApigeeV1DebugSessionTransaction() {
  var o = api.GoogleCloudApigeeV1DebugSessionTransaction();
  buildCounterGoogleCloudApigeeV1DebugSessionTransaction++;
  if (buildCounterGoogleCloudApigeeV1DebugSessionTransaction < 3) {
    o.completed = true;
    o.point = buildUnnamed3374();
  }
  buildCounterGoogleCloudApigeeV1DebugSessionTransaction--;
  return o;
}

void checkGoogleCloudApigeeV1DebugSessionTransaction(
    api.GoogleCloudApigeeV1DebugSessionTransaction o) {
  buildCounterGoogleCloudApigeeV1DebugSessionTransaction++;
  if (buildCounterGoogleCloudApigeeV1DebugSessionTransaction < 3) {
    unittest.expect(o.completed!, unittest.isTrue);
    checkUnnamed3374(o.point!);
  }
  buildCounterGoogleCloudApigeeV1DebugSessionTransaction--;
}

core.int buildCounterGoogleCloudApigeeV1DeleteCustomReportResponse = 0;
api.GoogleCloudApigeeV1DeleteCustomReportResponse
    buildGoogleCloudApigeeV1DeleteCustomReportResponse() {
  var o = api.GoogleCloudApigeeV1DeleteCustomReportResponse();
  buildCounterGoogleCloudApigeeV1DeleteCustomReportResponse++;
  if (buildCounterGoogleCloudApigeeV1DeleteCustomReportResponse < 3) {
    o.message = 'foo';
  }
  buildCounterGoogleCloudApigeeV1DeleteCustomReportResponse--;
  return o;
}

void checkGoogleCloudApigeeV1DeleteCustomReportResponse(
    api.GoogleCloudApigeeV1DeleteCustomReportResponse o) {
  buildCounterGoogleCloudApigeeV1DeleteCustomReportResponse++;
  if (buildCounterGoogleCloudApigeeV1DeleteCustomReportResponse < 3) {
    unittest.expect(
      o.message!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1DeleteCustomReportResponse--;
}

core.List<api.GoogleRpcStatus> buildUnnamed3375() {
  var o = <api.GoogleRpcStatus>[];
  o.add(buildGoogleRpcStatus());
  o.add(buildGoogleRpcStatus());
  return o;
}

void checkUnnamed3375(core.List<api.GoogleRpcStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleRpcStatus(o[0] as api.GoogleRpcStatus);
  checkGoogleRpcStatus(o[1] as api.GoogleRpcStatus);
}

core.List<api.GoogleCloudApigeeV1InstanceDeploymentStatus> buildUnnamed3376() {
  var o = <api.GoogleCloudApigeeV1InstanceDeploymentStatus>[];
  o.add(buildGoogleCloudApigeeV1InstanceDeploymentStatus());
  o.add(buildGoogleCloudApigeeV1InstanceDeploymentStatus());
  return o;
}

void checkUnnamed3376(
    core.List<api.GoogleCloudApigeeV1InstanceDeploymentStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1InstanceDeploymentStatus(
      o[0] as api.GoogleCloudApigeeV1InstanceDeploymentStatus);
  checkGoogleCloudApigeeV1InstanceDeploymentStatus(
      o[1] as api.GoogleCloudApigeeV1InstanceDeploymentStatus);
}

core.List<api.GoogleCloudApigeeV1PodStatus> buildUnnamed3377() {
  var o = <api.GoogleCloudApigeeV1PodStatus>[];
  o.add(buildGoogleCloudApigeeV1PodStatus());
  o.add(buildGoogleCloudApigeeV1PodStatus());
  return o;
}

void checkUnnamed3377(core.List<api.GoogleCloudApigeeV1PodStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1PodStatus(o[0] as api.GoogleCloudApigeeV1PodStatus);
  checkGoogleCloudApigeeV1PodStatus(o[1] as api.GoogleCloudApigeeV1PodStatus);
}

core.List<api.GoogleCloudApigeeV1DeploymentChangeReportRoutingConflict>
    buildUnnamed3378() {
  var o = <api.GoogleCloudApigeeV1DeploymentChangeReportRoutingConflict>[];
  o.add(buildGoogleCloudApigeeV1DeploymentChangeReportRoutingConflict());
  o.add(buildGoogleCloudApigeeV1DeploymentChangeReportRoutingConflict());
  return o;
}

void checkUnnamed3378(
    core.List<api.GoogleCloudApigeeV1DeploymentChangeReportRoutingConflict> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1DeploymentChangeReportRoutingConflict(
      o[0] as api.GoogleCloudApigeeV1DeploymentChangeReportRoutingConflict);
  checkGoogleCloudApigeeV1DeploymentChangeReportRoutingConflict(
      o[1] as api.GoogleCloudApigeeV1DeploymentChangeReportRoutingConflict);
}

core.int buildCounterGoogleCloudApigeeV1Deployment = 0;
api.GoogleCloudApigeeV1Deployment buildGoogleCloudApigeeV1Deployment() {
  var o = api.GoogleCloudApigeeV1Deployment();
  buildCounterGoogleCloudApigeeV1Deployment++;
  if (buildCounterGoogleCloudApigeeV1Deployment < 3) {
    o.apiProxy = 'foo';
    o.deployStartTime = 'foo';
    o.environment = 'foo';
    o.errors = buildUnnamed3375();
    o.instances = buildUnnamed3376();
    o.pods = buildUnnamed3377();
    o.revision = 'foo';
    o.routeConflicts = buildUnnamed3378();
    o.state = 'foo';
  }
  buildCounterGoogleCloudApigeeV1Deployment--;
  return o;
}

void checkGoogleCloudApigeeV1Deployment(api.GoogleCloudApigeeV1Deployment o) {
  buildCounterGoogleCloudApigeeV1Deployment++;
  if (buildCounterGoogleCloudApigeeV1Deployment < 3) {
    unittest.expect(
      o.apiProxy!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.deployStartTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.environment!,
      unittest.equals('foo'),
    );
    checkUnnamed3375(o.errors!);
    checkUnnamed3376(o.instances!);
    checkUnnamed3377(o.pods!);
    unittest.expect(
      o.revision!,
      unittest.equals('foo'),
    );
    checkUnnamed3378(o.routeConflicts!);
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1Deployment--;
}

core.List<api.GoogleCloudApigeeV1DeploymentChangeReportRoutingChange>
    buildUnnamed3379() {
  var o = <api.GoogleCloudApigeeV1DeploymentChangeReportRoutingChange>[];
  o.add(buildGoogleCloudApigeeV1DeploymentChangeReportRoutingChange());
  o.add(buildGoogleCloudApigeeV1DeploymentChangeReportRoutingChange());
  return o;
}

void checkUnnamed3379(
    core.List<api.GoogleCloudApigeeV1DeploymentChangeReportRoutingChange> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1DeploymentChangeReportRoutingChange(
      o[0] as api.GoogleCloudApigeeV1DeploymentChangeReportRoutingChange);
  checkGoogleCloudApigeeV1DeploymentChangeReportRoutingChange(
      o[1] as api.GoogleCloudApigeeV1DeploymentChangeReportRoutingChange);
}

core.List<api.GoogleCloudApigeeV1DeploymentChangeReportRoutingConflict>
    buildUnnamed3380() {
  var o = <api.GoogleCloudApigeeV1DeploymentChangeReportRoutingConflict>[];
  o.add(buildGoogleCloudApigeeV1DeploymentChangeReportRoutingConflict());
  o.add(buildGoogleCloudApigeeV1DeploymentChangeReportRoutingConflict());
  return o;
}

void checkUnnamed3380(
    core.List<api.GoogleCloudApigeeV1DeploymentChangeReportRoutingConflict> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1DeploymentChangeReportRoutingConflict(
      o[0] as api.GoogleCloudApigeeV1DeploymentChangeReportRoutingConflict);
  checkGoogleCloudApigeeV1DeploymentChangeReportRoutingConflict(
      o[1] as api.GoogleCloudApigeeV1DeploymentChangeReportRoutingConflict);
}

core.int buildCounterGoogleCloudApigeeV1DeploymentChangeReport = 0;
api.GoogleCloudApigeeV1DeploymentChangeReport
    buildGoogleCloudApigeeV1DeploymentChangeReport() {
  var o = api.GoogleCloudApigeeV1DeploymentChangeReport();
  buildCounterGoogleCloudApigeeV1DeploymentChangeReport++;
  if (buildCounterGoogleCloudApigeeV1DeploymentChangeReport < 3) {
    o.routingChanges = buildUnnamed3379();
    o.routingConflicts = buildUnnamed3380();
    o.validationErrors = buildGoogleRpcPreconditionFailure();
  }
  buildCounterGoogleCloudApigeeV1DeploymentChangeReport--;
  return o;
}

void checkGoogleCloudApigeeV1DeploymentChangeReport(
    api.GoogleCloudApigeeV1DeploymentChangeReport o) {
  buildCounterGoogleCloudApigeeV1DeploymentChangeReport++;
  if (buildCounterGoogleCloudApigeeV1DeploymentChangeReport < 3) {
    checkUnnamed3379(o.routingChanges!);
    checkUnnamed3380(o.routingConflicts!);
    checkGoogleRpcPreconditionFailure(
        o.validationErrors! as api.GoogleRpcPreconditionFailure);
  }
  buildCounterGoogleCloudApigeeV1DeploymentChangeReport--;
}

core.int buildCounterGoogleCloudApigeeV1DeploymentChangeReportRoutingChange = 0;
api.GoogleCloudApigeeV1DeploymentChangeReportRoutingChange
    buildGoogleCloudApigeeV1DeploymentChangeReportRoutingChange() {
  var o = api.GoogleCloudApigeeV1DeploymentChangeReportRoutingChange();
  buildCounterGoogleCloudApigeeV1DeploymentChangeReportRoutingChange++;
  if (buildCounterGoogleCloudApigeeV1DeploymentChangeReportRoutingChange < 3) {
    o.description = 'foo';
    o.environmentGroup = 'foo';
    o.fromDeployment =
        buildGoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment();
    o.shouldSequenceRollout = true;
    o.toDeployment =
        buildGoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment();
  }
  buildCounterGoogleCloudApigeeV1DeploymentChangeReportRoutingChange--;
  return o;
}

void checkGoogleCloudApigeeV1DeploymentChangeReportRoutingChange(
    api.GoogleCloudApigeeV1DeploymentChangeReportRoutingChange o) {
  buildCounterGoogleCloudApigeeV1DeploymentChangeReportRoutingChange++;
  if (buildCounterGoogleCloudApigeeV1DeploymentChangeReportRoutingChange < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.environmentGroup!,
      unittest.equals('foo'),
    );
    checkGoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment(
        o.fromDeployment!
            as api.GoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment);
    unittest.expect(o.shouldSequenceRollout!, unittest.isTrue);
    checkGoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment(
        o.toDeployment!
            as api.GoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment);
  }
  buildCounterGoogleCloudApigeeV1DeploymentChangeReportRoutingChange--;
}

core.int buildCounterGoogleCloudApigeeV1DeploymentChangeReportRoutingConflict =
    0;
api.GoogleCloudApigeeV1DeploymentChangeReportRoutingConflict
    buildGoogleCloudApigeeV1DeploymentChangeReportRoutingConflict() {
  var o = api.GoogleCloudApigeeV1DeploymentChangeReportRoutingConflict();
  buildCounterGoogleCloudApigeeV1DeploymentChangeReportRoutingConflict++;
  if (buildCounterGoogleCloudApigeeV1DeploymentChangeReportRoutingConflict <
      3) {
    o.conflictingDeployment =
        buildGoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment();
    o.description = 'foo';
    o.environmentGroup = 'foo';
  }
  buildCounterGoogleCloudApigeeV1DeploymentChangeReportRoutingConflict--;
  return o;
}

void checkGoogleCloudApigeeV1DeploymentChangeReportRoutingConflict(
    api.GoogleCloudApigeeV1DeploymentChangeReportRoutingConflict o) {
  buildCounterGoogleCloudApigeeV1DeploymentChangeReportRoutingConflict++;
  if (buildCounterGoogleCloudApigeeV1DeploymentChangeReportRoutingConflict <
      3) {
    checkGoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment(
        o.conflictingDeployment!
            as api.GoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment);
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.environmentGroup!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1DeploymentChangeReportRoutingConflict--;
}

core.int
    buildCounterGoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment = 0;
api.GoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment
    buildGoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment() {
  var o = api.GoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment();
  buildCounterGoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment++;
  if (buildCounterGoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment <
      3) {
    o.apiProxy = 'foo';
    o.basepath = 'foo';
    o.environment = 'foo';
    o.revision = 'foo';
  }
  buildCounterGoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment--;
  return o;
}

void checkGoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment(
    api.GoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment o) {
  buildCounterGoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment++;
  if (buildCounterGoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment <
      3) {
    unittest.expect(
      o.apiProxy!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.basepath!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.environment!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.revision!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment--;
}

core.Map<core.String, core.String> buildUnnamed3381() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed3381(core.Map<core.String, core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1DeploymentConfig = 0;
api.GoogleCloudApigeeV1DeploymentConfig
    buildGoogleCloudApigeeV1DeploymentConfig() {
  var o = api.GoogleCloudApigeeV1DeploymentConfig();
  buildCounterGoogleCloudApigeeV1DeploymentConfig++;
  if (buildCounterGoogleCloudApigeeV1DeploymentConfig < 3) {
    o.attributes = buildUnnamed3381();
    o.basePath = 'foo';
    o.location = 'foo';
    o.name = 'foo';
    o.proxyUid = 'foo';
    o.uid = 'foo';
  }
  buildCounterGoogleCloudApigeeV1DeploymentConfig--;
  return o;
}

void checkGoogleCloudApigeeV1DeploymentConfig(
    api.GoogleCloudApigeeV1DeploymentConfig o) {
  buildCounterGoogleCloudApigeeV1DeploymentConfig++;
  if (buildCounterGoogleCloudApigeeV1DeploymentConfig < 3) {
    checkUnnamed3381(o.attributes!);
    unittest.expect(
      o.basePath!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.location!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.proxyUid!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.uid!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1DeploymentConfig--;
}

core.List<core.String> buildUnnamed3382() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3382(core.List<core.String> o) {
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

core.List<api.GoogleCloudApigeeV1Attribute> buildUnnamed3383() {
  var o = <api.GoogleCloudApigeeV1Attribute>[];
  o.add(buildGoogleCloudApigeeV1Attribute());
  o.add(buildGoogleCloudApigeeV1Attribute());
  return o;
}

void checkUnnamed3383(core.List<api.GoogleCloudApigeeV1Attribute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Attribute(o[0] as api.GoogleCloudApigeeV1Attribute);
  checkGoogleCloudApigeeV1Attribute(o[1] as api.GoogleCloudApigeeV1Attribute);
}

core.List<core.String> buildUnnamed3384() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3384(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1Developer = 0;
api.GoogleCloudApigeeV1Developer buildGoogleCloudApigeeV1Developer() {
  var o = api.GoogleCloudApigeeV1Developer();
  buildCounterGoogleCloudApigeeV1Developer++;
  if (buildCounterGoogleCloudApigeeV1Developer < 3) {
    o.accessType = 'foo';
    o.appFamily = 'foo';
    o.apps = buildUnnamed3382();
    o.attributes = buildUnnamed3383();
    o.companies = buildUnnamed3384();
    o.createdAt = 'foo';
    o.developerId = 'foo';
    o.email = 'foo';
    o.firstName = 'foo';
    o.lastModifiedAt = 'foo';
    o.lastName = 'foo';
    o.organizationName = 'foo';
    o.status = 'foo';
    o.userName = 'foo';
  }
  buildCounterGoogleCloudApigeeV1Developer--;
  return o;
}

void checkGoogleCloudApigeeV1Developer(api.GoogleCloudApigeeV1Developer o) {
  buildCounterGoogleCloudApigeeV1Developer++;
  if (buildCounterGoogleCloudApigeeV1Developer < 3) {
    unittest.expect(
      o.accessType!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.appFamily!,
      unittest.equals('foo'),
    );
    checkUnnamed3382(o.apps!);
    checkUnnamed3383(o.attributes!);
    checkUnnamed3384(o.companies!);
    unittest.expect(
      o.createdAt!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.developerId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.email!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.firstName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.lastModifiedAt!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.lastName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.organizationName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.status!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.userName!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1Developer--;
}

core.List<core.String> buildUnnamed3385() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3385(core.List<core.String> o) {
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

core.List<api.GoogleCloudApigeeV1Attribute> buildUnnamed3386() {
  var o = <api.GoogleCloudApigeeV1Attribute>[];
  o.add(buildGoogleCloudApigeeV1Attribute());
  o.add(buildGoogleCloudApigeeV1Attribute());
  return o;
}

void checkUnnamed3386(core.List<api.GoogleCloudApigeeV1Attribute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Attribute(o[0] as api.GoogleCloudApigeeV1Attribute);
  checkGoogleCloudApigeeV1Attribute(o[1] as api.GoogleCloudApigeeV1Attribute);
}

core.List<api.GoogleCloudApigeeV1Credential> buildUnnamed3387() {
  var o = <api.GoogleCloudApigeeV1Credential>[];
  o.add(buildGoogleCloudApigeeV1Credential());
  o.add(buildGoogleCloudApigeeV1Credential());
  return o;
}

void checkUnnamed3387(core.List<api.GoogleCloudApigeeV1Credential> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Credential(o[0] as api.GoogleCloudApigeeV1Credential);
  checkGoogleCloudApigeeV1Credential(o[1] as api.GoogleCloudApigeeV1Credential);
}

core.List<core.String> buildUnnamed3388() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3388(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1DeveloperApp = 0;
api.GoogleCloudApigeeV1DeveloperApp buildGoogleCloudApigeeV1DeveloperApp() {
  var o = api.GoogleCloudApigeeV1DeveloperApp();
  buildCounterGoogleCloudApigeeV1DeveloperApp++;
  if (buildCounterGoogleCloudApigeeV1DeveloperApp < 3) {
    o.apiProducts = buildUnnamed3385();
    o.appFamily = 'foo';
    o.appId = 'foo';
    o.attributes = buildUnnamed3386();
    o.callbackUrl = 'foo';
    o.createdAt = 'foo';
    o.credentials = buildUnnamed3387();
    o.developerId = 'foo';
    o.keyExpiresIn = 'foo';
    o.lastModifiedAt = 'foo';
    o.name = 'foo';
    o.scopes = buildUnnamed3388();
    o.status = 'foo';
  }
  buildCounterGoogleCloudApigeeV1DeveloperApp--;
  return o;
}

void checkGoogleCloudApigeeV1DeveloperApp(
    api.GoogleCloudApigeeV1DeveloperApp o) {
  buildCounterGoogleCloudApigeeV1DeveloperApp++;
  if (buildCounterGoogleCloudApigeeV1DeveloperApp < 3) {
    checkUnnamed3385(o.apiProducts!);
    unittest.expect(
      o.appFamily!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.appId!,
      unittest.equals('foo'),
    );
    checkUnnamed3386(o.attributes!);
    unittest.expect(
      o.callbackUrl!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.createdAt!,
      unittest.equals('foo'),
    );
    checkUnnamed3387(o.credentials!);
    unittest.expect(
      o.developerId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.keyExpiresIn!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.lastModifiedAt!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed3388(o.scopes!);
    unittest.expect(
      o.status!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1DeveloperApp--;
}

core.List<core.Object> buildUnnamed3389() {
  var o = <core.Object>[];
  o.add({
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  });
  o.add({
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  });
  return o;
}

void checkUnnamed3389(core.List<core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted5 = (o[0]) as core.Map;
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
  var casted6 = (o[1]) as core.Map;
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

core.List<api.GoogleCloudApigeeV1Attribute> buildUnnamed3390() {
  var o = <api.GoogleCloudApigeeV1Attribute>[];
  o.add(buildGoogleCloudApigeeV1Attribute());
  o.add(buildGoogleCloudApigeeV1Attribute());
  return o;
}

void checkUnnamed3390(core.List<api.GoogleCloudApigeeV1Attribute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Attribute(o[0] as api.GoogleCloudApigeeV1Attribute);
  checkGoogleCloudApigeeV1Attribute(o[1] as api.GoogleCloudApigeeV1Attribute);
}

core.List<core.String> buildUnnamed3391() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3391(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1DeveloperAppKey = 0;
api.GoogleCloudApigeeV1DeveloperAppKey
    buildGoogleCloudApigeeV1DeveloperAppKey() {
  var o = api.GoogleCloudApigeeV1DeveloperAppKey();
  buildCounterGoogleCloudApigeeV1DeveloperAppKey++;
  if (buildCounterGoogleCloudApigeeV1DeveloperAppKey < 3) {
    o.apiProducts = buildUnnamed3389();
    o.attributes = buildUnnamed3390();
    o.consumerKey = 'foo';
    o.consumerSecret = 'foo';
    o.expiresAt = 'foo';
    o.expiresInSeconds = 'foo';
    o.issuedAt = 'foo';
    o.scopes = buildUnnamed3391();
    o.status = 'foo';
  }
  buildCounterGoogleCloudApigeeV1DeveloperAppKey--;
  return o;
}

void checkGoogleCloudApigeeV1DeveloperAppKey(
    api.GoogleCloudApigeeV1DeveloperAppKey o) {
  buildCounterGoogleCloudApigeeV1DeveloperAppKey++;
  if (buildCounterGoogleCloudApigeeV1DeveloperAppKey < 3) {
    checkUnnamed3389(o.apiProducts!);
    checkUnnamed3390(o.attributes!);
    unittest.expect(
      o.consumerKey!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.consumerSecret!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.expiresAt!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.expiresInSeconds!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.issuedAt!,
      unittest.equals('foo'),
    );
    checkUnnamed3391(o.scopes!);
    unittest.expect(
      o.status!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1DeveloperAppKey--;
}

core.List<api.GoogleCloudApigeeV1Metric> buildUnnamed3392() {
  var o = <api.GoogleCloudApigeeV1Metric>[];
  o.add(buildGoogleCloudApigeeV1Metric());
  o.add(buildGoogleCloudApigeeV1Metric());
  return o;
}

void checkUnnamed3392(core.List<api.GoogleCloudApigeeV1Metric> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Metric(o[0] as api.GoogleCloudApigeeV1Metric);
  checkGoogleCloudApigeeV1Metric(o[1] as api.GoogleCloudApigeeV1Metric);
}

core.int buildCounterGoogleCloudApigeeV1DimensionMetric = 0;
api.GoogleCloudApigeeV1DimensionMetric
    buildGoogleCloudApigeeV1DimensionMetric() {
  var o = api.GoogleCloudApigeeV1DimensionMetric();
  buildCounterGoogleCloudApigeeV1DimensionMetric++;
  if (buildCounterGoogleCloudApigeeV1DimensionMetric < 3) {
    o.metrics = buildUnnamed3392();
    o.name = 'foo';
  }
  buildCounterGoogleCloudApigeeV1DimensionMetric--;
  return o;
}

void checkGoogleCloudApigeeV1DimensionMetric(
    api.GoogleCloudApigeeV1DimensionMetric o) {
  buildCounterGoogleCloudApigeeV1DimensionMetric++;
  if (buildCounterGoogleCloudApigeeV1DimensionMetric < 3) {
    checkUnnamed3392(o.metrics!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1DimensionMetric--;
}

core.int buildCounterGoogleCloudApigeeV1EntityMetadata = 0;
api.GoogleCloudApigeeV1EntityMetadata buildGoogleCloudApigeeV1EntityMetadata() {
  var o = api.GoogleCloudApigeeV1EntityMetadata();
  buildCounterGoogleCloudApigeeV1EntityMetadata++;
  if (buildCounterGoogleCloudApigeeV1EntityMetadata < 3) {
    o.createdAt = 'foo';
    o.lastModifiedAt = 'foo';
    o.subType = 'foo';
  }
  buildCounterGoogleCloudApigeeV1EntityMetadata--;
  return o;
}

void checkGoogleCloudApigeeV1EntityMetadata(
    api.GoogleCloudApigeeV1EntityMetadata o) {
  buildCounterGoogleCloudApigeeV1EntityMetadata++;
  if (buildCounterGoogleCloudApigeeV1EntityMetadata < 3) {
    unittest.expect(
      o.createdAt!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.lastModifiedAt!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.subType!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1EntityMetadata--;
}

core.int buildCounterGoogleCloudApigeeV1Environment = 0;
api.GoogleCloudApigeeV1Environment buildGoogleCloudApigeeV1Environment() {
  var o = api.GoogleCloudApigeeV1Environment();
  buildCounterGoogleCloudApigeeV1Environment++;
  if (buildCounterGoogleCloudApigeeV1Environment < 3) {
    o.createdAt = 'foo';
    o.description = 'foo';
    o.displayName = 'foo';
    o.lastModifiedAt = 'foo';
    o.name = 'foo';
    o.properties = buildGoogleCloudApigeeV1Properties();
    o.state = 'foo';
  }
  buildCounterGoogleCloudApigeeV1Environment--;
  return o;
}

void checkGoogleCloudApigeeV1Environment(api.GoogleCloudApigeeV1Environment o) {
  buildCounterGoogleCloudApigeeV1Environment++;
  if (buildCounterGoogleCloudApigeeV1Environment < 3) {
    unittest.expect(
      o.createdAt!,
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
      o.lastModifiedAt!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkGoogleCloudApigeeV1Properties(
        o.properties! as api.GoogleCloudApigeeV1Properties);
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1Environment--;
}

core.List<api.GoogleCloudApigeeV1DataCollectorConfig> buildUnnamed3393() {
  var o = <api.GoogleCloudApigeeV1DataCollectorConfig>[];
  o.add(buildGoogleCloudApigeeV1DataCollectorConfig());
  o.add(buildGoogleCloudApigeeV1DataCollectorConfig());
  return o;
}

void checkUnnamed3393(core.List<api.GoogleCloudApigeeV1DataCollectorConfig> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1DataCollectorConfig(
      o[0] as api.GoogleCloudApigeeV1DataCollectorConfig);
  checkGoogleCloudApigeeV1DataCollectorConfig(
      o[1] as api.GoogleCloudApigeeV1DataCollectorConfig);
}

core.List<api.GoogleCloudApigeeV1DeploymentConfig> buildUnnamed3394() {
  var o = <api.GoogleCloudApigeeV1DeploymentConfig>[];
  o.add(buildGoogleCloudApigeeV1DeploymentConfig());
  o.add(buildGoogleCloudApigeeV1DeploymentConfig());
  return o;
}

void checkUnnamed3394(core.List<api.GoogleCloudApigeeV1DeploymentConfig> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1DeploymentConfig(
      o[0] as api.GoogleCloudApigeeV1DeploymentConfig);
  checkGoogleCloudApigeeV1DeploymentConfig(
      o[1] as api.GoogleCloudApigeeV1DeploymentConfig);
}

core.Map<core.String, core.String> buildUnnamed3395() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed3395(core.Map<core.String, core.String> o) {
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

core.List<api.GoogleCloudApigeeV1FlowHookConfig> buildUnnamed3396() {
  var o = <api.GoogleCloudApigeeV1FlowHookConfig>[];
  o.add(buildGoogleCloudApigeeV1FlowHookConfig());
  o.add(buildGoogleCloudApigeeV1FlowHookConfig());
  return o;
}

void checkUnnamed3396(core.List<api.GoogleCloudApigeeV1FlowHookConfig> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1FlowHookConfig(
      o[0] as api.GoogleCloudApigeeV1FlowHookConfig);
  checkGoogleCloudApigeeV1FlowHookConfig(
      o[1] as api.GoogleCloudApigeeV1FlowHookConfig);
}

core.List<api.GoogleCloudApigeeV1KeystoreConfig> buildUnnamed3397() {
  var o = <api.GoogleCloudApigeeV1KeystoreConfig>[];
  o.add(buildGoogleCloudApigeeV1KeystoreConfig());
  o.add(buildGoogleCloudApigeeV1KeystoreConfig());
  return o;
}

void checkUnnamed3397(core.List<api.GoogleCloudApigeeV1KeystoreConfig> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1KeystoreConfig(
      o[0] as api.GoogleCloudApigeeV1KeystoreConfig);
  checkGoogleCloudApigeeV1KeystoreConfig(
      o[1] as api.GoogleCloudApigeeV1KeystoreConfig);
}

core.List<api.GoogleCloudApigeeV1ReferenceConfig> buildUnnamed3398() {
  var o = <api.GoogleCloudApigeeV1ReferenceConfig>[];
  o.add(buildGoogleCloudApigeeV1ReferenceConfig());
  o.add(buildGoogleCloudApigeeV1ReferenceConfig());
  return o;
}

void checkUnnamed3398(core.List<api.GoogleCloudApigeeV1ReferenceConfig> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1ReferenceConfig(
      o[0] as api.GoogleCloudApigeeV1ReferenceConfig);
  checkGoogleCloudApigeeV1ReferenceConfig(
      o[1] as api.GoogleCloudApigeeV1ReferenceConfig);
}

core.List<api.GoogleCloudApigeeV1ResourceConfig> buildUnnamed3399() {
  var o = <api.GoogleCloudApigeeV1ResourceConfig>[];
  o.add(buildGoogleCloudApigeeV1ResourceConfig());
  o.add(buildGoogleCloudApigeeV1ResourceConfig());
  return o;
}

void checkUnnamed3399(core.List<api.GoogleCloudApigeeV1ResourceConfig> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1ResourceConfig(
      o[0] as api.GoogleCloudApigeeV1ResourceConfig);
  checkGoogleCloudApigeeV1ResourceConfig(
      o[1] as api.GoogleCloudApigeeV1ResourceConfig);
}

core.List<api.GoogleCloudApigeeV1TargetServerConfig> buildUnnamed3400() {
  var o = <api.GoogleCloudApigeeV1TargetServerConfig>[];
  o.add(buildGoogleCloudApigeeV1TargetServerConfig());
  o.add(buildGoogleCloudApigeeV1TargetServerConfig());
  return o;
}

void checkUnnamed3400(core.List<api.GoogleCloudApigeeV1TargetServerConfig> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1TargetServerConfig(
      o[0] as api.GoogleCloudApigeeV1TargetServerConfig);
  checkGoogleCloudApigeeV1TargetServerConfig(
      o[1] as api.GoogleCloudApigeeV1TargetServerConfig);
}

core.int buildCounterGoogleCloudApigeeV1EnvironmentConfig = 0;
api.GoogleCloudApigeeV1EnvironmentConfig
    buildGoogleCloudApigeeV1EnvironmentConfig() {
  var o = api.GoogleCloudApigeeV1EnvironmentConfig();
  buildCounterGoogleCloudApigeeV1EnvironmentConfig++;
  if (buildCounterGoogleCloudApigeeV1EnvironmentConfig < 3) {
    o.createTime = 'foo';
    o.dataCollectors = buildUnnamed3393();
    o.debugMask = buildGoogleCloudApigeeV1DebugMask();
    o.deployments = buildUnnamed3394();
    o.featureFlags = buildUnnamed3395();
    o.flowhooks = buildUnnamed3396();
    o.keystores = buildUnnamed3397();
    o.name = 'foo';
    o.provider = 'foo';
    o.pubsubTopic = 'foo';
    o.resourceReferences = buildUnnamed3398();
    o.resources = buildUnnamed3399();
    o.revisionId = 'foo';
    o.sequenceNumber = 'foo';
    o.targets = buildUnnamed3400();
    o.traceConfig = buildGoogleCloudApigeeV1RuntimeTraceConfig();
    o.uid = 'foo';
  }
  buildCounterGoogleCloudApigeeV1EnvironmentConfig--;
  return o;
}

void checkGoogleCloudApigeeV1EnvironmentConfig(
    api.GoogleCloudApigeeV1EnvironmentConfig o) {
  buildCounterGoogleCloudApigeeV1EnvironmentConfig++;
  if (buildCounterGoogleCloudApigeeV1EnvironmentConfig < 3) {
    unittest.expect(
      o.createTime!,
      unittest.equals('foo'),
    );
    checkUnnamed3393(o.dataCollectors!);
    checkGoogleCloudApigeeV1DebugMask(
        o.debugMask! as api.GoogleCloudApigeeV1DebugMask);
    checkUnnamed3394(o.deployments!);
    checkUnnamed3395(o.featureFlags!);
    checkUnnamed3396(o.flowhooks!);
    checkUnnamed3397(o.keystores!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.provider!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.pubsubTopic!,
      unittest.equals('foo'),
    );
    checkUnnamed3398(o.resourceReferences!);
    checkUnnamed3399(o.resources!);
    unittest.expect(
      o.revisionId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.sequenceNumber!,
      unittest.equals('foo'),
    );
    checkUnnamed3400(o.targets!);
    checkGoogleCloudApigeeV1RuntimeTraceConfig(
        o.traceConfig! as api.GoogleCloudApigeeV1RuntimeTraceConfig);
    unittest.expect(
      o.uid!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1EnvironmentConfig--;
}

core.List<core.String> buildUnnamed3401() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3401(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1EnvironmentGroup = 0;
api.GoogleCloudApigeeV1EnvironmentGroup
    buildGoogleCloudApigeeV1EnvironmentGroup() {
  var o = api.GoogleCloudApigeeV1EnvironmentGroup();
  buildCounterGoogleCloudApigeeV1EnvironmentGroup++;
  if (buildCounterGoogleCloudApigeeV1EnvironmentGroup < 3) {
    o.createdAt = 'foo';
    o.hostnames = buildUnnamed3401();
    o.lastModifiedAt = 'foo';
    o.name = 'foo';
    o.state = 'foo';
  }
  buildCounterGoogleCloudApigeeV1EnvironmentGroup--;
  return o;
}

void checkGoogleCloudApigeeV1EnvironmentGroup(
    api.GoogleCloudApigeeV1EnvironmentGroup o) {
  buildCounterGoogleCloudApigeeV1EnvironmentGroup++;
  if (buildCounterGoogleCloudApigeeV1EnvironmentGroup < 3) {
    unittest.expect(
      o.createdAt!,
      unittest.equals('foo'),
    );
    checkUnnamed3401(o.hostnames!);
    unittest.expect(
      o.lastModifiedAt!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1EnvironmentGroup--;
}

core.int buildCounterGoogleCloudApigeeV1EnvironmentGroupAttachment = 0;
api.GoogleCloudApigeeV1EnvironmentGroupAttachment
    buildGoogleCloudApigeeV1EnvironmentGroupAttachment() {
  var o = api.GoogleCloudApigeeV1EnvironmentGroupAttachment();
  buildCounterGoogleCloudApigeeV1EnvironmentGroupAttachment++;
  if (buildCounterGoogleCloudApigeeV1EnvironmentGroupAttachment < 3) {
    o.createdAt = 'foo';
    o.environment = 'foo';
    o.name = 'foo';
  }
  buildCounterGoogleCloudApigeeV1EnvironmentGroupAttachment--;
  return o;
}

void checkGoogleCloudApigeeV1EnvironmentGroupAttachment(
    api.GoogleCloudApigeeV1EnvironmentGroupAttachment o) {
  buildCounterGoogleCloudApigeeV1EnvironmentGroupAttachment++;
  if (buildCounterGoogleCloudApigeeV1EnvironmentGroupAttachment < 3) {
    unittest.expect(
      o.createdAt!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.environment!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1EnvironmentGroupAttachment--;
}

core.List<core.String> buildUnnamed3402() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3402(core.List<core.String> o) {
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

core.List<api.GoogleCloudApigeeV1RoutingRule> buildUnnamed3403() {
  var o = <api.GoogleCloudApigeeV1RoutingRule>[];
  o.add(buildGoogleCloudApigeeV1RoutingRule());
  o.add(buildGoogleCloudApigeeV1RoutingRule());
  return o;
}

void checkUnnamed3403(core.List<api.GoogleCloudApigeeV1RoutingRule> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1RoutingRule(
      o[0] as api.GoogleCloudApigeeV1RoutingRule);
  checkGoogleCloudApigeeV1RoutingRule(
      o[1] as api.GoogleCloudApigeeV1RoutingRule);
}

core.int buildCounterGoogleCloudApigeeV1EnvironmentGroupConfig = 0;
api.GoogleCloudApigeeV1EnvironmentGroupConfig
    buildGoogleCloudApigeeV1EnvironmentGroupConfig() {
  var o = api.GoogleCloudApigeeV1EnvironmentGroupConfig();
  buildCounterGoogleCloudApigeeV1EnvironmentGroupConfig++;
  if (buildCounterGoogleCloudApigeeV1EnvironmentGroupConfig < 3) {
    o.hostnames = buildUnnamed3402();
    o.name = 'foo';
    o.revisionId = 'foo';
    o.routingRules = buildUnnamed3403();
    o.uid = 'foo';
  }
  buildCounterGoogleCloudApigeeV1EnvironmentGroupConfig--;
  return o;
}

void checkGoogleCloudApigeeV1EnvironmentGroupConfig(
    api.GoogleCloudApigeeV1EnvironmentGroupConfig o) {
  buildCounterGoogleCloudApigeeV1EnvironmentGroupConfig++;
  if (buildCounterGoogleCloudApigeeV1EnvironmentGroupConfig < 3) {
    checkUnnamed3402(o.hostnames!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.revisionId!,
      unittest.equals('foo'),
    );
    checkUnnamed3403(o.routingRules!);
    unittest.expect(
      o.uid!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1EnvironmentGroupConfig--;
}

core.int buildCounterGoogleCloudApigeeV1Export = 0;
api.GoogleCloudApigeeV1Export buildGoogleCloudApigeeV1Export() {
  var o = api.GoogleCloudApigeeV1Export();
  buildCounterGoogleCloudApigeeV1Export++;
  if (buildCounterGoogleCloudApigeeV1Export < 3) {
    o.created = 'foo';
    o.datastoreName = 'foo';
    o.description = 'foo';
    o.error = 'foo';
    o.executionTime = 'foo';
    o.name = 'foo';
    o.self = 'foo';
    o.state = 'foo';
    o.updated = 'foo';
  }
  buildCounterGoogleCloudApigeeV1Export--;
  return o;
}

void checkGoogleCloudApigeeV1Export(api.GoogleCloudApigeeV1Export o) {
  buildCounterGoogleCloudApigeeV1Export++;
  if (buildCounterGoogleCloudApigeeV1Export < 3) {
    unittest.expect(
      o.created!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.datastoreName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.error!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.executionTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.self!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.updated!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1Export--;
}

core.int buildCounterGoogleCloudApigeeV1ExportRequest = 0;
api.GoogleCloudApigeeV1ExportRequest buildGoogleCloudApigeeV1ExportRequest() {
  var o = api.GoogleCloudApigeeV1ExportRequest();
  buildCounterGoogleCloudApigeeV1ExportRequest++;
  if (buildCounterGoogleCloudApigeeV1ExportRequest < 3) {
    o.csvDelimiter = 'foo';
    o.datastoreName = 'foo';
    o.dateRange = buildGoogleCloudApigeeV1DateRange();
    o.description = 'foo';
    o.name = 'foo';
    o.outputFormat = 'foo';
  }
  buildCounterGoogleCloudApigeeV1ExportRequest--;
  return o;
}

void checkGoogleCloudApigeeV1ExportRequest(
    api.GoogleCloudApigeeV1ExportRequest o) {
  buildCounterGoogleCloudApigeeV1ExportRequest++;
  if (buildCounterGoogleCloudApigeeV1ExportRequest < 3) {
    unittest.expect(
      o.csvDelimiter!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.datastoreName!,
      unittest.equals('foo'),
    );
    checkGoogleCloudApigeeV1DateRange(
        o.dateRange! as api.GoogleCloudApigeeV1DateRange);
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.outputFormat!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1ExportRequest--;
}

core.int buildCounterGoogleCloudApigeeV1FlowHook = 0;
api.GoogleCloudApigeeV1FlowHook buildGoogleCloudApigeeV1FlowHook() {
  var o = api.GoogleCloudApigeeV1FlowHook();
  buildCounterGoogleCloudApigeeV1FlowHook++;
  if (buildCounterGoogleCloudApigeeV1FlowHook < 3) {
    o.continueOnError = true;
    o.description = 'foo';
    o.flowHookPoint = 'foo';
    o.sharedFlow = 'foo';
  }
  buildCounterGoogleCloudApigeeV1FlowHook--;
  return o;
}

void checkGoogleCloudApigeeV1FlowHook(api.GoogleCloudApigeeV1FlowHook o) {
  buildCounterGoogleCloudApigeeV1FlowHook++;
  if (buildCounterGoogleCloudApigeeV1FlowHook < 3) {
    unittest.expect(o.continueOnError!, unittest.isTrue);
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.flowHookPoint!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.sharedFlow!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1FlowHook--;
}

core.int buildCounterGoogleCloudApigeeV1FlowHookConfig = 0;
api.GoogleCloudApigeeV1FlowHookConfig buildGoogleCloudApigeeV1FlowHookConfig() {
  var o = api.GoogleCloudApigeeV1FlowHookConfig();
  buildCounterGoogleCloudApigeeV1FlowHookConfig++;
  if (buildCounterGoogleCloudApigeeV1FlowHookConfig < 3) {
    o.continueOnError = true;
    o.name = 'foo';
    o.sharedFlowName = 'foo';
  }
  buildCounterGoogleCloudApigeeV1FlowHookConfig--;
  return o;
}

void checkGoogleCloudApigeeV1FlowHookConfig(
    api.GoogleCloudApigeeV1FlowHookConfig o) {
  buildCounterGoogleCloudApigeeV1FlowHookConfig++;
  if (buildCounterGoogleCloudApigeeV1FlowHookConfig < 3) {
    unittest.expect(o.continueOnError!, unittest.isTrue);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.sharedFlowName!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1FlowHookConfig--;
}

core.int buildCounterGoogleCloudApigeeV1GetSyncAuthorizationRequest = 0;
api.GoogleCloudApigeeV1GetSyncAuthorizationRequest
    buildGoogleCloudApigeeV1GetSyncAuthorizationRequest() {
  var o = api.GoogleCloudApigeeV1GetSyncAuthorizationRequest();
  buildCounterGoogleCloudApigeeV1GetSyncAuthorizationRequest++;
  if (buildCounterGoogleCloudApigeeV1GetSyncAuthorizationRequest < 3) {}
  buildCounterGoogleCloudApigeeV1GetSyncAuthorizationRequest--;
  return o;
}

void checkGoogleCloudApigeeV1GetSyncAuthorizationRequest(
    api.GoogleCloudApigeeV1GetSyncAuthorizationRequest o) {
  buildCounterGoogleCloudApigeeV1GetSyncAuthorizationRequest++;
  if (buildCounterGoogleCloudApigeeV1GetSyncAuthorizationRequest < 3) {}
  buildCounterGoogleCloudApigeeV1GetSyncAuthorizationRequest--;
}

core.List<api.GoogleCloudApigeeV1EnvironmentGroupConfig> buildUnnamed3404() {
  var o = <api.GoogleCloudApigeeV1EnvironmentGroupConfig>[];
  o.add(buildGoogleCloudApigeeV1EnvironmentGroupConfig());
  o.add(buildGoogleCloudApigeeV1EnvironmentGroupConfig());
  return o;
}

void checkUnnamed3404(
    core.List<api.GoogleCloudApigeeV1EnvironmentGroupConfig> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1EnvironmentGroupConfig(
      o[0] as api.GoogleCloudApigeeV1EnvironmentGroupConfig);
  checkGoogleCloudApigeeV1EnvironmentGroupConfig(
      o[1] as api.GoogleCloudApigeeV1EnvironmentGroupConfig);
}

core.int buildCounterGoogleCloudApigeeV1IngressConfig = 0;
api.GoogleCloudApigeeV1IngressConfig buildGoogleCloudApigeeV1IngressConfig() {
  var o = api.GoogleCloudApigeeV1IngressConfig();
  buildCounterGoogleCloudApigeeV1IngressConfig++;
  if (buildCounterGoogleCloudApigeeV1IngressConfig < 3) {
    o.environmentGroups = buildUnnamed3404();
    o.name = 'foo';
    o.revisionCreateTime = 'foo';
    o.revisionId = 'foo';
    o.uid = 'foo';
  }
  buildCounterGoogleCloudApigeeV1IngressConfig--;
  return o;
}

void checkGoogleCloudApigeeV1IngressConfig(
    api.GoogleCloudApigeeV1IngressConfig o) {
  buildCounterGoogleCloudApigeeV1IngressConfig++;
  if (buildCounterGoogleCloudApigeeV1IngressConfig < 3) {
    checkUnnamed3404(o.environmentGroups!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.revisionCreateTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.revisionId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.uid!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1IngressConfig--;
}

core.int buildCounterGoogleCloudApigeeV1Instance = 0;
api.GoogleCloudApigeeV1Instance buildGoogleCloudApigeeV1Instance() {
  var o = api.GoogleCloudApigeeV1Instance();
  buildCounterGoogleCloudApigeeV1Instance++;
  if (buildCounterGoogleCloudApigeeV1Instance < 3) {
    o.createdAt = 'foo';
    o.description = 'foo';
    o.diskEncryptionKeyName = 'foo';
    o.displayName = 'foo';
    o.host = 'foo';
    o.lastModifiedAt = 'foo';
    o.location = 'foo';
    o.name = 'foo';
    o.peeringCidrRange = 'foo';
    o.port = 'foo';
    o.state = 'foo';
  }
  buildCounterGoogleCloudApigeeV1Instance--;
  return o;
}

void checkGoogleCloudApigeeV1Instance(api.GoogleCloudApigeeV1Instance o) {
  buildCounterGoogleCloudApigeeV1Instance++;
  if (buildCounterGoogleCloudApigeeV1Instance < 3) {
    unittest.expect(
      o.createdAt!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.diskEncryptionKeyName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.host!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.lastModifiedAt!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.location!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.peeringCidrRange!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.port!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1Instance--;
}

core.int buildCounterGoogleCloudApigeeV1InstanceAttachment = 0;
api.GoogleCloudApigeeV1InstanceAttachment
    buildGoogleCloudApigeeV1InstanceAttachment() {
  var o = api.GoogleCloudApigeeV1InstanceAttachment();
  buildCounterGoogleCloudApigeeV1InstanceAttachment++;
  if (buildCounterGoogleCloudApigeeV1InstanceAttachment < 3) {
    o.createdAt = 'foo';
    o.environment = 'foo';
    o.name = 'foo';
  }
  buildCounterGoogleCloudApigeeV1InstanceAttachment--;
  return o;
}

void checkGoogleCloudApigeeV1InstanceAttachment(
    api.GoogleCloudApigeeV1InstanceAttachment o) {
  buildCounterGoogleCloudApigeeV1InstanceAttachment++;
  if (buildCounterGoogleCloudApigeeV1InstanceAttachment < 3) {
    unittest.expect(
      o.createdAt!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.environment!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1InstanceAttachment--;
}

core.List<api.GoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision>
    buildUnnamed3405() {
  var o = <api.GoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision>[];
  o.add(buildGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision());
  o.add(buildGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision());
  return o;
}

void checkUnnamed3405(
    core.List<api.GoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision(
      o[0] as api.GoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision);
  checkGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision(
      o[1] as api.GoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision);
}

core.List<api.GoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute>
    buildUnnamed3406() {
  var o = <api.GoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute>[];
  o.add(buildGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute());
  o.add(buildGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute());
  return o;
}

void checkUnnamed3406(
    core.List<api.GoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute(
      o[0] as api.GoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute);
  checkGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute(
      o[1] as api.GoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute);
}

core.int buildCounterGoogleCloudApigeeV1InstanceDeploymentStatus = 0;
api.GoogleCloudApigeeV1InstanceDeploymentStatus
    buildGoogleCloudApigeeV1InstanceDeploymentStatus() {
  var o = api.GoogleCloudApigeeV1InstanceDeploymentStatus();
  buildCounterGoogleCloudApigeeV1InstanceDeploymentStatus++;
  if (buildCounterGoogleCloudApigeeV1InstanceDeploymentStatus < 3) {
    o.deployedRevisions = buildUnnamed3405();
    o.deployedRoutes = buildUnnamed3406();
    o.instance = 'foo';
  }
  buildCounterGoogleCloudApigeeV1InstanceDeploymentStatus--;
  return o;
}

void checkGoogleCloudApigeeV1InstanceDeploymentStatus(
    api.GoogleCloudApigeeV1InstanceDeploymentStatus o) {
  buildCounterGoogleCloudApigeeV1InstanceDeploymentStatus++;
  if (buildCounterGoogleCloudApigeeV1InstanceDeploymentStatus < 3) {
    checkUnnamed3405(o.deployedRevisions!);
    checkUnnamed3406(o.deployedRoutes!);
    unittest.expect(
      o.instance!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1InstanceDeploymentStatus--;
}

core.int
    buildCounterGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision = 0;
api.GoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision
    buildGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision() {
  var o = api.GoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision();
  buildCounterGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision++;
  if (buildCounterGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision <
      3) {
    o.percentage = 42;
    o.revision = 'foo';
  }
  buildCounterGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision--;
  return o;
}

void checkGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision(
    api.GoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision o) {
  buildCounterGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision++;
  if (buildCounterGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision <
      3) {
    unittest.expect(
      o.percentage!,
      unittest.equals(42),
    );
    unittest.expect(
      o.revision!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision--;
}

core.int buildCounterGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute =
    0;
api.GoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute
    buildGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute() {
  var o = api.GoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute();
  buildCounterGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute++;
  if (buildCounterGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute <
      3) {
    o.basepath = 'foo';
    o.envgroup = 'foo';
    o.environment = 'foo';
    o.percentage = 42;
  }
  buildCounterGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute--;
  return o;
}

void checkGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute(
    api.GoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute o) {
  buildCounterGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute++;
  if (buildCounterGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute <
      3) {
    unittest.expect(
      o.basepath!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.envgroup!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.environment!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.percentage!,
      unittest.equals(42),
    );
  }
  buildCounterGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute--;
}

core.int buildCounterGoogleCloudApigeeV1KeyAliasReference = 0;
api.GoogleCloudApigeeV1KeyAliasReference
    buildGoogleCloudApigeeV1KeyAliasReference() {
  var o = api.GoogleCloudApigeeV1KeyAliasReference();
  buildCounterGoogleCloudApigeeV1KeyAliasReference++;
  if (buildCounterGoogleCloudApigeeV1KeyAliasReference < 3) {
    o.aliasId = 'foo';
    o.reference = 'foo';
  }
  buildCounterGoogleCloudApigeeV1KeyAliasReference--;
  return o;
}

void checkGoogleCloudApigeeV1KeyAliasReference(
    api.GoogleCloudApigeeV1KeyAliasReference o) {
  buildCounterGoogleCloudApigeeV1KeyAliasReference++;
  if (buildCounterGoogleCloudApigeeV1KeyAliasReference < 3) {
    unittest.expect(
      o.aliasId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.reference!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1KeyAliasReference--;
}

core.int buildCounterGoogleCloudApigeeV1KeyValueMap = 0;
api.GoogleCloudApigeeV1KeyValueMap buildGoogleCloudApigeeV1KeyValueMap() {
  var o = api.GoogleCloudApigeeV1KeyValueMap();
  buildCounterGoogleCloudApigeeV1KeyValueMap++;
  if (buildCounterGoogleCloudApigeeV1KeyValueMap < 3) {
    o.encrypted = true;
    o.name = 'foo';
  }
  buildCounterGoogleCloudApigeeV1KeyValueMap--;
  return o;
}

void checkGoogleCloudApigeeV1KeyValueMap(api.GoogleCloudApigeeV1KeyValueMap o) {
  buildCounterGoogleCloudApigeeV1KeyValueMap++;
  if (buildCounterGoogleCloudApigeeV1KeyValueMap < 3) {
    unittest.expect(o.encrypted!, unittest.isTrue);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1KeyValueMap--;
}

core.List<core.String> buildUnnamed3407() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3407(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1Keystore = 0;
api.GoogleCloudApigeeV1Keystore buildGoogleCloudApigeeV1Keystore() {
  var o = api.GoogleCloudApigeeV1Keystore();
  buildCounterGoogleCloudApigeeV1Keystore++;
  if (buildCounterGoogleCloudApigeeV1Keystore < 3) {
    o.aliases = buildUnnamed3407();
    o.name = 'foo';
  }
  buildCounterGoogleCloudApigeeV1Keystore--;
  return o;
}

void checkGoogleCloudApigeeV1Keystore(api.GoogleCloudApigeeV1Keystore o) {
  buildCounterGoogleCloudApigeeV1Keystore++;
  if (buildCounterGoogleCloudApigeeV1Keystore < 3) {
    checkUnnamed3407(o.aliases!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1Keystore--;
}

core.List<api.GoogleCloudApigeeV1AliasRevisionConfig> buildUnnamed3408() {
  var o = <api.GoogleCloudApigeeV1AliasRevisionConfig>[];
  o.add(buildGoogleCloudApigeeV1AliasRevisionConfig());
  o.add(buildGoogleCloudApigeeV1AliasRevisionConfig());
  return o;
}

void checkUnnamed3408(core.List<api.GoogleCloudApigeeV1AliasRevisionConfig> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1AliasRevisionConfig(
      o[0] as api.GoogleCloudApigeeV1AliasRevisionConfig);
  checkGoogleCloudApigeeV1AliasRevisionConfig(
      o[1] as api.GoogleCloudApigeeV1AliasRevisionConfig);
}

core.int buildCounterGoogleCloudApigeeV1KeystoreConfig = 0;
api.GoogleCloudApigeeV1KeystoreConfig buildGoogleCloudApigeeV1KeystoreConfig() {
  var o = api.GoogleCloudApigeeV1KeystoreConfig();
  buildCounterGoogleCloudApigeeV1KeystoreConfig++;
  if (buildCounterGoogleCloudApigeeV1KeystoreConfig < 3) {
    o.aliases = buildUnnamed3408();
    o.name = 'foo';
  }
  buildCounterGoogleCloudApigeeV1KeystoreConfig--;
  return o;
}

void checkGoogleCloudApigeeV1KeystoreConfig(
    api.GoogleCloudApigeeV1KeystoreConfig o) {
  buildCounterGoogleCloudApigeeV1KeystoreConfig++;
  if (buildCounterGoogleCloudApigeeV1KeystoreConfig < 3) {
    checkUnnamed3408(o.aliases!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1KeystoreConfig--;
}

core.List<api.GoogleCloudApigeeV1ApiCategoryData> buildUnnamed3409() {
  var o = <api.GoogleCloudApigeeV1ApiCategoryData>[];
  o.add(buildGoogleCloudApigeeV1ApiCategoryData());
  o.add(buildGoogleCloudApigeeV1ApiCategoryData());
  return o;
}

void checkUnnamed3409(core.List<api.GoogleCloudApigeeV1ApiCategoryData> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1ApiCategoryData(
      o[0] as api.GoogleCloudApigeeV1ApiCategoryData);
  checkGoogleCloudApigeeV1ApiCategoryData(
      o[1] as api.GoogleCloudApigeeV1ApiCategoryData);
}

core.int buildCounterGoogleCloudApigeeV1ListApiCategoriesResponse = 0;
api.GoogleCloudApigeeV1ListApiCategoriesResponse
    buildGoogleCloudApigeeV1ListApiCategoriesResponse() {
  var o = api.GoogleCloudApigeeV1ListApiCategoriesResponse();
  buildCounterGoogleCloudApigeeV1ListApiCategoriesResponse++;
  if (buildCounterGoogleCloudApigeeV1ListApiCategoriesResponse < 3) {
    o.data = buildUnnamed3409();
    o.errorCode = 'foo';
    o.message = 'foo';
    o.requestId = 'foo';
    o.status = 'foo';
  }
  buildCounterGoogleCloudApigeeV1ListApiCategoriesResponse--;
  return o;
}

void checkGoogleCloudApigeeV1ListApiCategoriesResponse(
    api.GoogleCloudApigeeV1ListApiCategoriesResponse o) {
  buildCounterGoogleCloudApigeeV1ListApiCategoriesResponse++;
  if (buildCounterGoogleCloudApigeeV1ListApiCategoriesResponse < 3) {
    checkUnnamed3409(o.data!);
    unittest.expect(
      o.errorCode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.message!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.requestId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.status!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1ListApiCategoriesResponse--;
}

core.List<api.GoogleCloudApigeeV1ApiProduct> buildUnnamed3410() {
  var o = <api.GoogleCloudApigeeV1ApiProduct>[];
  o.add(buildGoogleCloudApigeeV1ApiProduct());
  o.add(buildGoogleCloudApigeeV1ApiProduct());
  return o;
}

void checkUnnamed3410(core.List<api.GoogleCloudApigeeV1ApiProduct> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1ApiProduct(o[0] as api.GoogleCloudApigeeV1ApiProduct);
  checkGoogleCloudApigeeV1ApiProduct(o[1] as api.GoogleCloudApigeeV1ApiProduct);
}

core.int buildCounterGoogleCloudApigeeV1ListApiProductsResponse = 0;
api.GoogleCloudApigeeV1ListApiProductsResponse
    buildGoogleCloudApigeeV1ListApiProductsResponse() {
  var o = api.GoogleCloudApigeeV1ListApiProductsResponse();
  buildCounterGoogleCloudApigeeV1ListApiProductsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListApiProductsResponse < 3) {
    o.apiProduct = buildUnnamed3410();
  }
  buildCounterGoogleCloudApigeeV1ListApiProductsResponse--;
  return o;
}

void checkGoogleCloudApigeeV1ListApiProductsResponse(
    api.GoogleCloudApigeeV1ListApiProductsResponse o) {
  buildCounterGoogleCloudApigeeV1ListApiProductsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListApiProductsResponse < 3) {
    checkUnnamed3410(o.apiProduct!);
  }
  buildCounterGoogleCloudApigeeV1ListApiProductsResponse--;
}

core.List<api.GoogleCloudApigeeV1ApiProxy> buildUnnamed3411() {
  var o = <api.GoogleCloudApigeeV1ApiProxy>[];
  o.add(buildGoogleCloudApigeeV1ApiProxy());
  o.add(buildGoogleCloudApigeeV1ApiProxy());
  return o;
}

void checkUnnamed3411(core.List<api.GoogleCloudApigeeV1ApiProxy> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1ApiProxy(o[0] as api.GoogleCloudApigeeV1ApiProxy);
  checkGoogleCloudApigeeV1ApiProxy(o[1] as api.GoogleCloudApigeeV1ApiProxy);
}

core.int buildCounterGoogleCloudApigeeV1ListApiProxiesResponse = 0;
api.GoogleCloudApigeeV1ListApiProxiesResponse
    buildGoogleCloudApigeeV1ListApiProxiesResponse() {
  var o = api.GoogleCloudApigeeV1ListApiProxiesResponse();
  buildCounterGoogleCloudApigeeV1ListApiProxiesResponse++;
  if (buildCounterGoogleCloudApigeeV1ListApiProxiesResponse < 3) {
    o.proxies = buildUnnamed3411();
  }
  buildCounterGoogleCloudApigeeV1ListApiProxiesResponse--;
  return o;
}

void checkGoogleCloudApigeeV1ListApiProxiesResponse(
    api.GoogleCloudApigeeV1ListApiProxiesResponse o) {
  buildCounterGoogleCloudApigeeV1ListApiProxiesResponse++;
  if (buildCounterGoogleCloudApigeeV1ListApiProxiesResponse < 3) {
    checkUnnamed3411(o.proxies!);
  }
  buildCounterGoogleCloudApigeeV1ListApiProxiesResponse--;
}

core.List<api.GoogleCloudApigeeV1App> buildUnnamed3412() {
  var o = <api.GoogleCloudApigeeV1App>[];
  o.add(buildGoogleCloudApigeeV1App());
  o.add(buildGoogleCloudApigeeV1App());
  return o;
}

void checkUnnamed3412(core.List<api.GoogleCloudApigeeV1App> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1App(o[0] as api.GoogleCloudApigeeV1App);
  checkGoogleCloudApigeeV1App(o[1] as api.GoogleCloudApigeeV1App);
}

core.int buildCounterGoogleCloudApigeeV1ListAppsResponse = 0;
api.GoogleCloudApigeeV1ListAppsResponse
    buildGoogleCloudApigeeV1ListAppsResponse() {
  var o = api.GoogleCloudApigeeV1ListAppsResponse();
  buildCounterGoogleCloudApigeeV1ListAppsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListAppsResponse < 3) {
    o.app = buildUnnamed3412();
  }
  buildCounterGoogleCloudApigeeV1ListAppsResponse--;
  return o;
}

void checkGoogleCloudApigeeV1ListAppsResponse(
    api.GoogleCloudApigeeV1ListAppsResponse o) {
  buildCounterGoogleCloudApigeeV1ListAppsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListAppsResponse < 3) {
    checkUnnamed3412(o.app!);
  }
  buildCounterGoogleCloudApigeeV1ListAppsResponse--;
}

core.List<api.GoogleCloudApigeeV1AsyncQuery> buildUnnamed3413() {
  var o = <api.GoogleCloudApigeeV1AsyncQuery>[];
  o.add(buildGoogleCloudApigeeV1AsyncQuery());
  o.add(buildGoogleCloudApigeeV1AsyncQuery());
  return o;
}

void checkUnnamed3413(core.List<api.GoogleCloudApigeeV1AsyncQuery> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1AsyncQuery(o[0] as api.GoogleCloudApigeeV1AsyncQuery);
  checkGoogleCloudApigeeV1AsyncQuery(o[1] as api.GoogleCloudApigeeV1AsyncQuery);
}

core.int buildCounterGoogleCloudApigeeV1ListAsyncQueriesResponse = 0;
api.GoogleCloudApigeeV1ListAsyncQueriesResponse
    buildGoogleCloudApigeeV1ListAsyncQueriesResponse() {
  var o = api.GoogleCloudApigeeV1ListAsyncQueriesResponse();
  buildCounterGoogleCloudApigeeV1ListAsyncQueriesResponse++;
  if (buildCounterGoogleCloudApigeeV1ListAsyncQueriesResponse < 3) {
    o.queries = buildUnnamed3413();
  }
  buildCounterGoogleCloudApigeeV1ListAsyncQueriesResponse--;
  return o;
}

void checkGoogleCloudApigeeV1ListAsyncQueriesResponse(
    api.GoogleCloudApigeeV1ListAsyncQueriesResponse o) {
  buildCounterGoogleCloudApigeeV1ListAsyncQueriesResponse++;
  if (buildCounterGoogleCloudApigeeV1ListAsyncQueriesResponse < 3) {
    checkUnnamed3413(o.queries!);
  }
  buildCounterGoogleCloudApigeeV1ListAsyncQueriesResponse--;
}

core.List<api.GoogleCloudApigeeV1CustomReport> buildUnnamed3414() {
  var o = <api.GoogleCloudApigeeV1CustomReport>[];
  o.add(buildGoogleCloudApigeeV1CustomReport());
  o.add(buildGoogleCloudApigeeV1CustomReport());
  return o;
}

void checkUnnamed3414(core.List<api.GoogleCloudApigeeV1CustomReport> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1CustomReport(
      o[0] as api.GoogleCloudApigeeV1CustomReport);
  checkGoogleCloudApigeeV1CustomReport(
      o[1] as api.GoogleCloudApigeeV1CustomReport);
}

core.int buildCounterGoogleCloudApigeeV1ListCustomReportsResponse = 0;
api.GoogleCloudApigeeV1ListCustomReportsResponse
    buildGoogleCloudApigeeV1ListCustomReportsResponse() {
  var o = api.GoogleCloudApigeeV1ListCustomReportsResponse();
  buildCounterGoogleCloudApigeeV1ListCustomReportsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListCustomReportsResponse < 3) {
    o.qualifier = buildUnnamed3414();
  }
  buildCounterGoogleCloudApigeeV1ListCustomReportsResponse--;
  return o;
}

void checkGoogleCloudApigeeV1ListCustomReportsResponse(
    api.GoogleCloudApigeeV1ListCustomReportsResponse o) {
  buildCounterGoogleCloudApigeeV1ListCustomReportsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListCustomReportsResponse < 3) {
    checkUnnamed3414(o.qualifier!);
  }
  buildCounterGoogleCloudApigeeV1ListCustomReportsResponse--;
}

core.List<api.GoogleCloudApigeeV1DataCollector> buildUnnamed3415() {
  var o = <api.GoogleCloudApigeeV1DataCollector>[];
  o.add(buildGoogleCloudApigeeV1DataCollector());
  o.add(buildGoogleCloudApigeeV1DataCollector());
  return o;
}

void checkUnnamed3415(core.List<api.GoogleCloudApigeeV1DataCollector> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1DataCollector(
      o[0] as api.GoogleCloudApigeeV1DataCollector);
  checkGoogleCloudApigeeV1DataCollector(
      o[1] as api.GoogleCloudApigeeV1DataCollector);
}

core.int buildCounterGoogleCloudApigeeV1ListDataCollectorsResponse = 0;
api.GoogleCloudApigeeV1ListDataCollectorsResponse
    buildGoogleCloudApigeeV1ListDataCollectorsResponse() {
  var o = api.GoogleCloudApigeeV1ListDataCollectorsResponse();
  buildCounterGoogleCloudApigeeV1ListDataCollectorsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListDataCollectorsResponse < 3) {
    o.dataCollectors = buildUnnamed3415();
    o.nextPageToken = 'foo';
  }
  buildCounterGoogleCloudApigeeV1ListDataCollectorsResponse--;
  return o;
}

void checkGoogleCloudApigeeV1ListDataCollectorsResponse(
    api.GoogleCloudApigeeV1ListDataCollectorsResponse o) {
  buildCounterGoogleCloudApigeeV1ListDataCollectorsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListDataCollectorsResponse < 3) {
    checkUnnamed3415(o.dataCollectors!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1ListDataCollectorsResponse--;
}

core.List<api.GoogleCloudApigeeV1Datastore> buildUnnamed3416() {
  var o = <api.GoogleCloudApigeeV1Datastore>[];
  o.add(buildGoogleCloudApigeeV1Datastore());
  o.add(buildGoogleCloudApigeeV1Datastore());
  return o;
}

void checkUnnamed3416(core.List<api.GoogleCloudApigeeV1Datastore> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Datastore(o[0] as api.GoogleCloudApigeeV1Datastore);
  checkGoogleCloudApigeeV1Datastore(o[1] as api.GoogleCloudApigeeV1Datastore);
}

core.int buildCounterGoogleCloudApigeeV1ListDatastoresResponse = 0;
api.GoogleCloudApigeeV1ListDatastoresResponse
    buildGoogleCloudApigeeV1ListDatastoresResponse() {
  var o = api.GoogleCloudApigeeV1ListDatastoresResponse();
  buildCounterGoogleCloudApigeeV1ListDatastoresResponse++;
  if (buildCounterGoogleCloudApigeeV1ListDatastoresResponse < 3) {
    o.datastores = buildUnnamed3416();
  }
  buildCounterGoogleCloudApigeeV1ListDatastoresResponse--;
  return o;
}

void checkGoogleCloudApigeeV1ListDatastoresResponse(
    api.GoogleCloudApigeeV1ListDatastoresResponse o) {
  buildCounterGoogleCloudApigeeV1ListDatastoresResponse++;
  if (buildCounterGoogleCloudApigeeV1ListDatastoresResponse < 3) {
    checkUnnamed3416(o.datastores!);
  }
  buildCounterGoogleCloudApigeeV1ListDatastoresResponse--;
}

core.List<api.GoogleCloudApigeeV1Session> buildUnnamed3417() {
  var o = <api.GoogleCloudApigeeV1Session>[];
  o.add(buildGoogleCloudApigeeV1Session());
  o.add(buildGoogleCloudApigeeV1Session());
  return o;
}

void checkUnnamed3417(core.List<api.GoogleCloudApigeeV1Session> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Session(o[0] as api.GoogleCloudApigeeV1Session);
  checkGoogleCloudApigeeV1Session(o[1] as api.GoogleCloudApigeeV1Session);
}

core.int buildCounterGoogleCloudApigeeV1ListDebugSessionsResponse = 0;
api.GoogleCloudApigeeV1ListDebugSessionsResponse
    buildGoogleCloudApigeeV1ListDebugSessionsResponse() {
  var o = api.GoogleCloudApigeeV1ListDebugSessionsResponse();
  buildCounterGoogleCloudApigeeV1ListDebugSessionsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListDebugSessionsResponse < 3) {
    o.nextPageToken = 'foo';
    o.sessions = buildUnnamed3417();
  }
  buildCounterGoogleCloudApigeeV1ListDebugSessionsResponse--;
  return o;
}

void checkGoogleCloudApigeeV1ListDebugSessionsResponse(
    api.GoogleCloudApigeeV1ListDebugSessionsResponse o) {
  buildCounterGoogleCloudApigeeV1ListDebugSessionsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListDebugSessionsResponse < 3) {
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
    checkUnnamed3417(o.sessions!);
  }
  buildCounterGoogleCloudApigeeV1ListDebugSessionsResponse--;
}

core.List<api.GoogleCloudApigeeV1Deployment> buildUnnamed3418() {
  var o = <api.GoogleCloudApigeeV1Deployment>[];
  o.add(buildGoogleCloudApigeeV1Deployment());
  o.add(buildGoogleCloudApigeeV1Deployment());
  return o;
}

void checkUnnamed3418(core.List<api.GoogleCloudApigeeV1Deployment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Deployment(o[0] as api.GoogleCloudApigeeV1Deployment);
  checkGoogleCloudApigeeV1Deployment(o[1] as api.GoogleCloudApigeeV1Deployment);
}

core.int buildCounterGoogleCloudApigeeV1ListDeploymentsResponse = 0;
api.GoogleCloudApigeeV1ListDeploymentsResponse
    buildGoogleCloudApigeeV1ListDeploymentsResponse() {
  var o = api.GoogleCloudApigeeV1ListDeploymentsResponse();
  buildCounterGoogleCloudApigeeV1ListDeploymentsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListDeploymentsResponse < 3) {
    o.deployments = buildUnnamed3418();
  }
  buildCounterGoogleCloudApigeeV1ListDeploymentsResponse--;
  return o;
}

void checkGoogleCloudApigeeV1ListDeploymentsResponse(
    api.GoogleCloudApigeeV1ListDeploymentsResponse o) {
  buildCounterGoogleCloudApigeeV1ListDeploymentsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListDeploymentsResponse < 3) {
    checkUnnamed3418(o.deployments!);
  }
  buildCounterGoogleCloudApigeeV1ListDeploymentsResponse--;
}

core.List<api.GoogleCloudApigeeV1DeveloperApp> buildUnnamed3419() {
  var o = <api.GoogleCloudApigeeV1DeveloperApp>[];
  o.add(buildGoogleCloudApigeeV1DeveloperApp());
  o.add(buildGoogleCloudApigeeV1DeveloperApp());
  return o;
}

void checkUnnamed3419(core.List<api.GoogleCloudApigeeV1DeveloperApp> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1DeveloperApp(
      o[0] as api.GoogleCloudApigeeV1DeveloperApp);
  checkGoogleCloudApigeeV1DeveloperApp(
      o[1] as api.GoogleCloudApigeeV1DeveloperApp);
}

core.int buildCounterGoogleCloudApigeeV1ListDeveloperAppsResponse = 0;
api.GoogleCloudApigeeV1ListDeveloperAppsResponse
    buildGoogleCloudApigeeV1ListDeveloperAppsResponse() {
  var o = api.GoogleCloudApigeeV1ListDeveloperAppsResponse();
  buildCounterGoogleCloudApigeeV1ListDeveloperAppsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListDeveloperAppsResponse < 3) {
    o.app = buildUnnamed3419();
  }
  buildCounterGoogleCloudApigeeV1ListDeveloperAppsResponse--;
  return o;
}

void checkGoogleCloudApigeeV1ListDeveloperAppsResponse(
    api.GoogleCloudApigeeV1ListDeveloperAppsResponse o) {
  buildCounterGoogleCloudApigeeV1ListDeveloperAppsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListDeveloperAppsResponse < 3) {
    checkUnnamed3419(o.app!);
  }
  buildCounterGoogleCloudApigeeV1ListDeveloperAppsResponse--;
}

core.List<api.GoogleCloudApigeeV1EnvironmentGroupAttachment>
    buildUnnamed3420() {
  var o = <api.GoogleCloudApigeeV1EnvironmentGroupAttachment>[];
  o.add(buildGoogleCloudApigeeV1EnvironmentGroupAttachment());
  o.add(buildGoogleCloudApigeeV1EnvironmentGroupAttachment());
  return o;
}

void checkUnnamed3420(
    core.List<api.GoogleCloudApigeeV1EnvironmentGroupAttachment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1EnvironmentGroupAttachment(
      o[0] as api.GoogleCloudApigeeV1EnvironmentGroupAttachment);
  checkGoogleCloudApigeeV1EnvironmentGroupAttachment(
      o[1] as api.GoogleCloudApigeeV1EnvironmentGroupAttachment);
}

core.int
    buildCounterGoogleCloudApigeeV1ListEnvironmentGroupAttachmentsResponse = 0;
api.GoogleCloudApigeeV1ListEnvironmentGroupAttachmentsResponse
    buildGoogleCloudApigeeV1ListEnvironmentGroupAttachmentsResponse() {
  var o = api.GoogleCloudApigeeV1ListEnvironmentGroupAttachmentsResponse();
  buildCounterGoogleCloudApigeeV1ListEnvironmentGroupAttachmentsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListEnvironmentGroupAttachmentsResponse <
      3) {
    o.environmentGroupAttachments = buildUnnamed3420();
    o.nextPageToken = 'foo';
  }
  buildCounterGoogleCloudApigeeV1ListEnvironmentGroupAttachmentsResponse--;
  return o;
}

void checkGoogleCloudApigeeV1ListEnvironmentGroupAttachmentsResponse(
    api.GoogleCloudApigeeV1ListEnvironmentGroupAttachmentsResponse o) {
  buildCounterGoogleCloudApigeeV1ListEnvironmentGroupAttachmentsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListEnvironmentGroupAttachmentsResponse <
      3) {
    checkUnnamed3420(o.environmentGroupAttachments!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1ListEnvironmentGroupAttachmentsResponse--;
}

core.List<api.GoogleCloudApigeeV1EnvironmentGroup> buildUnnamed3421() {
  var o = <api.GoogleCloudApigeeV1EnvironmentGroup>[];
  o.add(buildGoogleCloudApigeeV1EnvironmentGroup());
  o.add(buildGoogleCloudApigeeV1EnvironmentGroup());
  return o;
}

void checkUnnamed3421(core.List<api.GoogleCloudApigeeV1EnvironmentGroup> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1EnvironmentGroup(
      o[0] as api.GoogleCloudApigeeV1EnvironmentGroup);
  checkGoogleCloudApigeeV1EnvironmentGroup(
      o[1] as api.GoogleCloudApigeeV1EnvironmentGroup);
}

core.int buildCounterGoogleCloudApigeeV1ListEnvironmentGroupsResponse = 0;
api.GoogleCloudApigeeV1ListEnvironmentGroupsResponse
    buildGoogleCloudApigeeV1ListEnvironmentGroupsResponse() {
  var o = api.GoogleCloudApigeeV1ListEnvironmentGroupsResponse();
  buildCounterGoogleCloudApigeeV1ListEnvironmentGroupsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListEnvironmentGroupsResponse < 3) {
    o.environmentGroups = buildUnnamed3421();
    o.nextPageToken = 'foo';
  }
  buildCounterGoogleCloudApigeeV1ListEnvironmentGroupsResponse--;
  return o;
}

void checkGoogleCloudApigeeV1ListEnvironmentGroupsResponse(
    api.GoogleCloudApigeeV1ListEnvironmentGroupsResponse o) {
  buildCounterGoogleCloudApigeeV1ListEnvironmentGroupsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListEnvironmentGroupsResponse < 3) {
    checkUnnamed3421(o.environmentGroups!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1ListEnvironmentGroupsResponse--;
}

core.List<api.GoogleCloudApigeeV1ResourceFile> buildUnnamed3422() {
  var o = <api.GoogleCloudApigeeV1ResourceFile>[];
  o.add(buildGoogleCloudApigeeV1ResourceFile());
  o.add(buildGoogleCloudApigeeV1ResourceFile());
  return o;
}

void checkUnnamed3422(core.List<api.GoogleCloudApigeeV1ResourceFile> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1ResourceFile(
      o[0] as api.GoogleCloudApigeeV1ResourceFile);
  checkGoogleCloudApigeeV1ResourceFile(
      o[1] as api.GoogleCloudApigeeV1ResourceFile);
}

core.int buildCounterGoogleCloudApigeeV1ListEnvironmentResourcesResponse = 0;
api.GoogleCloudApigeeV1ListEnvironmentResourcesResponse
    buildGoogleCloudApigeeV1ListEnvironmentResourcesResponse() {
  var o = api.GoogleCloudApigeeV1ListEnvironmentResourcesResponse();
  buildCounterGoogleCloudApigeeV1ListEnvironmentResourcesResponse++;
  if (buildCounterGoogleCloudApigeeV1ListEnvironmentResourcesResponse < 3) {
    o.resourceFile = buildUnnamed3422();
  }
  buildCounterGoogleCloudApigeeV1ListEnvironmentResourcesResponse--;
  return o;
}

void checkGoogleCloudApigeeV1ListEnvironmentResourcesResponse(
    api.GoogleCloudApigeeV1ListEnvironmentResourcesResponse o) {
  buildCounterGoogleCloudApigeeV1ListEnvironmentResourcesResponse++;
  if (buildCounterGoogleCloudApigeeV1ListEnvironmentResourcesResponse < 3) {
    checkUnnamed3422(o.resourceFile!);
  }
  buildCounterGoogleCloudApigeeV1ListEnvironmentResourcesResponse--;
}

core.List<api.GoogleCloudApigeeV1Export> buildUnnamed3423() {
  var o = <api.GoogleCloudApigeeV1Export>[];
  o.add(buildGoogleCloudApigeeV1Export());
  o.add(buildGoogleCloudApigeeV1Export());
  return o;
}

void checkUnnamed3423(core.List<api.GoogleCloudApigeeV1Export> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Export(o[0] as api.GoogleCloudApigeeV1Export);
  checkGoogleCloudApigeeV1Export(o[1] as api.GoogleCloudApigeeV1Export);
}

core.int buildCounterGoogleCloudApigeeV1ListExportsResponse = 0;
api.GoogleCloudApigeeV1ListExportsResponse
    buildGoogleCloudApigeeV1ListExportsResponse() {
  var o = api.GoogleCloudApigeeV1ListExportsResponse();
  buildCounterGoogleCloudApigeeV1ListExportsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListExportsResponse < 3) {
    o.exports = buildUnnamed3423();
  }
  buildCounterGoogleCloudApigeeV1ListExportsResponse--;
  return o;
}

void checkGoogleCloudApigeeV1ListExportsResponse(
    api.GoogleCloudApigeeV1ListExportsResponse o) {
  buildCounterGoogleCloudApigeeV1ListExportsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListExportsResponse < 3) {
    checkUnnamed3423(o.exports!);
  }
  buildCounterGoogleCloudApigeeV1ListExportsResponse--;
}

core.List<api.GoogleCloudApigeeV1ServiceIssuersMapping> buildUnnamed3424() {
  var o = <api.GoogleCloudApigeeV1ServiceIssuersMapping>[];
  o.add(buildGoogleCloudApigeeV1ServiceIssuersMapping());
  o.add(buildGoogleCloudApigeeV1ServiceIssuersMapping());
  return o;
}

void checkUnnamed3424(
    core.List<api.GoogleCloudApigeeV1ServiceIssuersMapping> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1ServiceIssuersMapping(
      o[0] as api.GoogleCloudApigeeV1ServiceIssuersMapping);
  checkGoogleCloudApigeeV1ServiceIssuersMapping(
      o[1] as api.GoogleCloudApigeeV1ServiceIssuersMapping);
}

core.int buildCounterGoogleCloudApigeeV1ListHybridIssuersResponse = 0;
api.GoogleCloudApigeeV1ListHybridIssuersResponse
    buildGoogleCloudApigeeV1ListHybridIssuersResponse() {
  var o = api.GoogleCloudApigeeV1ListHybridIssuersResponse();
  buildCounterGoogleCloudApigeeV1ListHybridIssuersResponse++;
  if (buildCounterGoogleCloudApigeeV1ListHybridIssuersResponse < 3) {
    o.issuers = buildUnnamed3424();
  }
  buildCounterGoogleCloudApigeeV1ListHybridIssuersResponse--;
  return o;
}

void checkGoogleCloudApigeeV1ListHybridIssuersResponse(
    api.GoogleCloudApigeeV1ListHybridIssuersResponse o) {
  buildCounterGoogleCloudApigeeV1ListHybridIssuersResponse++;
  if (buildCounterGoogleCloudApigeeV1ListHybridIssuersResponse < 3) {
    checkUnnamed3424(o.issuers!);
  }
  buildCounterGoogleCloudApigeeV1ListHybridIssuersResponse--;
}

core.List<api.GoogleCloudApigeeV1InstanceAttachment> buildUnnamed3425() {
  var o = <api.GoogleCloudApigeeV1InstanceAttachment>[];
  o.add(buildGoogleCloudApigeeV1InstanceAttachment());
  o.add(buildGoogleCloudApigeeV1InstanceAttachment());
  return o;
}

void checkUnnamed3425(core.List<api.GoogleCloudApigeeV1InstanceAttachment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1InstanceAttachment(
      o[0] as api.GoogleCloudApigeeV1InstanceAttachment);
  checkGoogleCloudApigeeV1InstanceAttachment(
      o[1] as api.GoogleCloudApigeeV1InstanceAttachment);
}

core.int buildCounterGoogleCloudApigeeV1ListInstanceAttachmentsResponse = 0;
api.GoogleCloudApigeeV1ListInstanceAttachmentsResponse
    buildGoogleCloudApigeeV1ListInstanceAttachmentsResponse() {
  var o = api.GoogleCloudApigeeV1ListInstanceAttachmentsResponse();
  buildCounterGoogleCloudApigeeV1ListInstanceAttachmentsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListInstanceAttachmentsResponse < 3) {
    o.attachments = buildUnnamed3425();
    o.nextPageToken = 'foo';
  }
  buildCounterGoogleCloudApigeeV1ListInstanceAttachmentsResponse--;
  return o;
}

void checkGoogleCloudApigeeV1ListInstanceAttachmentsResponse(
    api.GoogleCloudApigeeV1ListInstanceAttachmentsResponse o) {
  buildCounterGoogleCloudApigeeV1ListInstanceAttachmentsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListInstanceAttachmentsResponse < 3) {
    checkUnnamed3425(o.attachments!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1ListInstanceAttachmentsResponse--;
}

core.List<api.GoogleCloudApigeeV1Instance> buildUnnamed3426() {
  var o = <api.GoogleCloudApigeeV1Instance>[];
  o.add(buildGoogleCloudApigeeV1Instance());
  o.add(buildGoogleCloudApigeeV1Instance());
  return o;
}

void checkUnnamed3426(core.List<api.GoogleCloudApigeeV1Instance> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Instance(o[0] as api.GoogleCloudApigeeV1Instance);
  checkGoogleCloudApigeeV1Instance(o[1] as api.GoogleCloudApigeeV1Instance);
}

core.int buildCounterGoogleCloudApigeeV1ListInstancesResponse = 0;
api.GoogleCloudApigeeV1ListInstancesResponse
    buildGoogleCloudApigeeV1ListInstancesResponse() {
  var o = api.GoogleCloudApigeeV1ListInstancesResponse();
  buildCounterGoogleCloudApigeeV1ListInstancesResponse++;
  if (buildCounterGoogleCloudApigeeV1ListInstancesResponse < 3) {
    o.instances = buildUnnamed3426();
    o.nextPageToken = 'foo';
  }
  buildCounterGoogleCloudApigeeV1ListInstancesResponse--;
  return o;
}

void checkGoogleCloudApigeeV1ListInstancesResponse(
    api.GoogleCloudApigeeV1ListInstancesResponse o) {
  buildCounterGoogleCloudApigeeV1ListInstancesResponse++;
  if (buildCounterGoogleCloudApigeeV1ListInstancesResponse < 3) {
    checkUnnamed3426(o.instances!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1ListInstancesResponse--;
}

core.List<api.GoogleCloudApigeeV1NatAddress> buildUnnamed3427() {
  var o = <api.GoogleCloudApigeeV1NatAddress>[];
  o.add(buildGoogleCloudApigeeV1NatAddress());
  o.add(buildGoogleCloudApigeeV1NatAddress());
  return o;
}

void checkUnnamed3427(core.List<api.GoogleCloudApigeeV1NatAddress> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1NatAddress(o[0] as api.GoogleCloudApigeeV1NatAddress);
  checkGoogleCloudApigeeV1NatAddress(o[1] as api.GoogleCloudApigeeV1NatAddress);
}

core.int buildCounterGoogleCloudApigeeV1ListNatAddressesResponse = 0;
api.GoogleCloudApigeeV1ListNatAddressesResponse
    buildGoogleCloudApigeeV1ListNatAddressesResponse() {
  var o = api.GoogleCloudApigeeV1ListNatAddressesResponse();
  buildCounterGoogleCloudApigeeV1ListNatAddressesResponse++;
  if (buildCounterGoogleCloudApigeeV1ListNatAddressesResponse < 3) {
    o.natAddresses = buildUnnamed3427();
    o.nextPageToken = 'foo';
  }
  buildCounterGoogleCloudApigeeV1ListNatAddressesResponse--;
  return o;
}

void checkGoogleCloudApigeeV1ListNatAddressesResponse(
    api.GoogleCloudApigeeV1ListNatAddressesResponse o) {
  buildCounterGoogleCloudApigeeV1ListNatAddressesResponse++;
  if (buildCounterGoogleCloudApigeeV1ListNatAddressesResponse < 3) {
    checkUnnamed3427(o.natAddresses!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1ListNatAddressesResponse--;
}

core.List<api.GoogleCloudApigeeV1Developer> buildUnnamed3428() {
  var o = <api.GoogleCloudApigeeV1Developer>[];
  o.add(buildGoogleCloudApigeeV1Developer());
  o.add(buildGoogleCloudApigeeV1Developer());
  return o;
}

void checkUnnamed3428(core.List<api.GoogleCloudApigeeV1Developer> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Developer(o[0] as api.GoogleCloudApigeeV1Developer);
  checkGoogleCloudApigeeV1Developer(o[1] as api.GoogleCloudApigeeV1Developer);
}

core.int buildCounterGoogleCloudApigeeV1ListOfDevelopersResponse = 0;
api.GoogleCloudApigeeV1ListOfDevelopersResponse
    buildGoogleCloudApigeeV1ListOfDevelopersResponse() {
  var o = api.GoogleCloudApigeeV1ListOfDevelopersResponse();
  buildCounterGoogleCloudApigeeV1ListOfDevelopersResponse++;
  if (buildCounterGoogleCloudApigeeV1ListOfDevelopersResponse < 3) {
    o.developer = buildUnnamed3428();
  }
  buildCounterGoogleCloudApigeeV1ListOfDevelopersResponse--;
  return o;
}

void checkGoogleCloudApigeeV1ListOfDevelopersResponse(
    api.GoogleCloudApigeeV1ListOfDevelopersResponse o) {
  buildCounterGoogleCloudApigeeV1ListOfDevelopersResponse++;
  if (buildCounterGoogleCloudApigeeV1ListOfDevelopersResponse < 3) {
    checkUnnamed3428(o.developer!);
  }
  buildCounterGoogleCloudApigeeV1ListOfDevelopersResponse--;
}

core.List<api.GoogleCloudApigeeV1OrganizationProjectMapping>
    buildUnnamed3429() {
  var o = <api.GoogleCloudApigeeV1OrganizationProjectMapping>[];
  o.add(buildGoogleCloudApigeeV1OrganizationProjectMapping());
  o.add(buildGoogleCloudApigeeV1OrganizationProjectMapping());
  return o;
}

void checkUnnamed3429(
    core.List<api.GoogleCloudApigeeV1OrganizationProjectMapping> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1OrganizationProjectMapping(
      o[0] as api.GoogleCloudApigeeV1OrganizationProjectMapping);
  checkGoogleCloudApigeeV1OrganizationProjectMapping(
      o[1] as api.GoogleCloudApigeeV1OrganizationProjectMapping);
}

core.int buildCounterGoogleCloudApigeeV1ListOrganizationsResponse = 0;
api.GoogleCloudApigeeV1ListOrganizationsResponse
    buildGoogleCloudApigeeV1ListOrganizationsResponse() {
  var o = api.GoogleCloudApigeeV1ListOrganizationsResponse();
  buildCounterGoogleCloudApigeeV1ListOrganizationsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListOrganizationsResponse < 3) {
    o.organizations = buildUnnamed3429();
  }
  buildCounterGoogleCloudApigeeV1ListOrganizationsResponse--;
  return o;
}

void checkGoogleCloudApigeeV1ListOrganizationsResponse(
    api.GoogleCloudApigeeV1ListOrganizationsResponse o) {
  buildCounterGoogleCloudApigeeV1ListOrganizationsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListOrganizationsResponse < 3) {
    checkUnnamed3429(o.organizations!);
  }
  buildCounterGoogleCloudApigeeV1ListOrganizationsResponse--;
}

core.List<api.GoogleCloudApigeeV1SharedFlow> buildUnnamed3430() {
  var o = <api.GoogleCloudApigeeV1SharedFlow>[];
  o.add(buildGoogleCloudApigeeV1SharedFlow());
  o.add(buildGoogleCloudApigeeV1SharedFlow());
  return o;
}

void checkUnnamed3430(core.List<api.GoogleCloudApigeeV1SharedFlow> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1SharedFlow(o[0] as api.GoogleCloudApigeeV1SharedFlow);
  checkGoogleCloudApigeeV1SharedFlow(o[1] as api.GoogleCloudApigeeV1SharedFlow);
}

core.int buildCounterGoogleCloudApigeeV1ListSharedFlowsResponse = 0;
api.GoogleCloudApigeeV1ListSharedFlowsResponse
    buildGoogleCloudApigeeV1ListSharedFlowsResponse() {
  var o = api.GoogleCloudApigeeV1ListSharedFlowsResponse();
  buildCounterGoogleCloudApigeeV1ListSharedFlowsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListSharedFlowsResponse < 3) {
    o.sharedFlows = buildUnnamed3430();
  }
  buildCounterGoogleCloudApigeeV1ListSharedFlowsResponse--;
  return o;
}

void checkGoogleCloudApigeeV1ListSharedFlowsResponse(
    api.GoogleCloudApigeeV1ListSharedFlowsResponse o) {
  buildCounterGoogleCloudApigeeV1ListSharedFlowsResponse++;
  if (buildCounterGoogleCloudApigeeV1ListSharedFlowsResponse < 3) {
    checkUnnamed3430(o.sharedFlows!);
  }
  buildCounterGoogleCloudApigeeV1ListSharedFlowsResponse--;
}

core.List<core.String> buildUnnamed3431() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3431(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed3432() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3432(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1Metadata = 0;
api.GoogleCloudApigeeV1Metadata buildGoogleCloudApigeeV1Metadata() {
  var o = api.GoogleCloudApigeeV1Metadata();
  buildCounterGoogleCloudApigeeV1Metadata++;
  if (buildCounterGoogleCloudApigeeV1Metadata < 3) {
    o.errors = buildUnnamed3431();
    o.notices = buildUnnamed3432();
  }
  buildCounterGoogleCloudApigeeV1Metadata--;
  return o;
}

void checkGoogleCloudApigeeV1Metadata(api.GoogleCloudApigeeV1Metadata o) {
  buildCounterGoogleCloudApigeeV1Metadata++;
  if (buildCounterGoogleCloudApigeeV1Metadata < 3) {
    checkUnnamed3431(o.errors!);
    checkUnnamed3432(o.notices!);
  }
  buildCounterGoogleCloudApigeeV1Metadata--;
}

core.List<core.Object> buildUnnamed3433() {
  var o = <core.Object>[];
  o.add({
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  });
  o.add({
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  });
  return o;
}

void checkUnnamed3433(core.List<core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted7 = (o[0]) as core.Map;
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
  var casted8 = (o[1]) as core.Map;
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

core.int buildCounterGoogleCloudApigeeV1Metric = 0;
api.GoogleCloudApigeeV1Metric buildGoogleCloudApigeeV1Metric() {
  var o = api.GoogleCloudApigeeV1Metric();
  buildCounterGoogleCloudApigeeV1Metric++;
  if (buildCounterGoogleCloudApigeeV1Metric < 3) {
    o.name = 'foo';
    o.values = buildUnnamed3433();
  }
  buildCounterGoogleCloudApigeeV1Metric--;
  return o;
}

void checkGoogleCloudApigeeV1Metric(api.GoogleCloudApigeeV1Metric o) {
  buildCounterGoogleCloudApigeeV1Metric++;
  if (buildCounterGoogleCloudApigeeV1Metric < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed3433(o.values!);
  }
  buildCounterGoogleCloudApigeeV1Metric--;
}

core.int buildCounterGoogleCloudApigeeV1NatAddress = 0;
api.GoogleCloudApigeeV1NatAddress buildGoogleCloudApigeeV1NatAddress() {
  var o = api.GoogleCloudApigeeV1NatAddress();
  buildCounterGoogleCloudApigeeV1NatAddress++;
  if (buildCounterGoogleCloudApigeeV1NatAddress < 3) {
    o.ipAddress = 'foo';
    o.name = 'foo';
    o.state = 'foo';
  }
  buildCounterGoogleCloudApigeeV1NatAddress--;
  return o;
}

void checkGoogleCloudApigeeV1NatAddress(api.GoogleCloudApigeeV1NatAddress o) {
  buildCounterGoogleCloudApigeeV1NatAddress++;
  if (buildCounterGoogleCloudApigeeV1NatAddress < 3) {
    unittest.expect(
      o.ipAddress!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1NatAddress--;
}

core.List<core.String> buildUnnamed3434() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3434(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1Operation = 0;
api.GoogleCloudApigeeV1Operation buildGoogleCloudApigeeV1Operation() {
  var o = api.GoogleCloudApigeeV1Operation();
  buildCounterGoogleCloudApigeeV1Operation++;
  if (buildCounterGoogleCloudApigeeV1Operation < 3) {
    o.methods = buildUnnamed3434();
    o.resource = 'foo';
  }
  buildCounterGoogleCloudApigeeV1Operation--;
  return o;
}

void checkGoogleCloudApigeeV1Operation(api.GoogleCloudApigeeV1Operation o) {
  buildCounterGoogleCloudApigeeV1Operation++;
  if (buildCounterGoogleCloudApigeeV1Operation < 3) {
    checkUnnamed3434(o.methods!);
    unittest.expect(
      o.resource!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1Operation--;
}

core.List<api.GoogleCloudApigeeV1Attribute> buildUnnamed3435() {
  var o = <api.GoogleCloudApigeeV1Attribute>[];
  o.add(buildGoogleCloudApigeeV1Attribute());
  o.add(buildGoogleCloudApigeeV1Attribute());
  return o;
}

void checkUnnamed3435(core.List<api.GoogleCloudApigeeV1Attribute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Attribute(o[0] as api.GoogleCloudApigeeV1Attribute);
  checkGoogleCloudApigeeV1Attribute(o[1] as api.GoogleCloudApigeeV1Attribute);
}

core.List<api.GoogleCloudApigeeV1Operation> buildUnnamed3436() {
  var o = <api.GoogleCloudApigeeV1Operation>[];
  o.add(buildGoogleCloudApigeeV1Operation());
  o.add(buildGoogleCloudApigeeV1Operation());
  return o;
}

void checkUnnamed3436(core.List<api.GoogleCloudApigeeV1Operation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Operation(o[0] as api.GoogleCloudApigeeV1Operation);
  checkGoogleCloudApigeeV1Operation(o[1] as api.GoogleCloudApigeeV1Operation);
}

core.int buildCounterGoogleCloudApigeeV1OperationConfig = 0;
api.GoogleCloudApigeeV1OperationConfig
    buildGoogleCloudApigeeV1OperationConfig() {
  var o = api.GoogleCloudApigeeV1OperationConfig();
  buildCounterGoogleCloudApigeeV1OperationConfig++;
  if (buildCounterGoogleCloudApigeeV1OperationConfig < 3) {
    o.apiSource = 'foo';
    o.attributes = buildUnnamed3435();
    o.operations = buildUnnamed3436();
    o.quota = buildGoogleCloudApigeeV1Quota();
  }
  buildCounterGoogleCloudApigeeV1OperationConfig--;
  return o;
}

void checkGoogleCloudApigeeV1OperationConfig(
    api.GoogleCloudApigeeV1OperationConfig o) {
  buildCounterGoogleCloudApigeeV1OperationConfig++;
  if (buildCounterGoogleCloudApigeeV1OperationConfig < 3) {
    unittest.expect(
      o.apiSource!,
      unittest.equals('foo'),
    );
    checkUnnamed3435(o.attributes!);
    checkUnnamed3436(o.operations!);
    checkGoogleCloudApigeeV1Quota(o.quota! as api.GoogleCloudApigeeV1Quota);
  }
  buildCounterGoogleCloudApigeeV1OperationConfig--;
}

core.List<api.GoogleCloudApigeeV1OperationConfig> buildUnnamed3437() {
  var o = <api.GoogleCloudApigeeV1OperationConfig>[];
  o.add(buildGoogleCloudApigeeV1OperationConfig());
  o.add(buildGoogleCloudApigeeV1OperationConfig());
  return o;
}

void checkUnnamed3437(core.List<api.GoogleCloudApigeeV1OperationConfig> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1OperationConfig(
      o[0] as api.GoogleCloudApigeeV1OperationConfig);
  checkGoogleCloudApigeeV1OperationConfig(
      o[1] as api.GoogleCloudApigeeV1OperationConfig);
}

core.int buildCounterGoogleCloudApigeeV1OperationGroup = 0;
api.GoogleCloudApigeeV1OperationGroup buildGoogleCloudApigeeV1OperationGroup() {
  var o = api.GoogleCloudApigeeV1OperationGroup();
  buildCounterGoogleCloudApigeeV1OperationGroup++;
  if (buildCounterGoogleCloudApigeeV1OperationGroup < 3) {
    o.operationConfigType = 'foo';
    o.operationConfigs = buildUnnamed3437();
  }
  buildCounterGoogleCloudApigeeV1OperationGroup--;
  return o;
}

void checkGoogleCloudApigeeV1OperationGroup(
    api.GoogleCloudApigeeV1OperationGroup o) {
  buildCounterGoogleCloudApigeeV1OperationGroup++;
  if (buildCounterGoogleCloudApigeeV1OperationGroup < 3) {
    unittest.expect(
      o.operationConfigType!,
      unittest.equals('foo'),
    );
    checkUnnamed3437(o.operationConfigs!);
  }
  buildCounterGoogleCloudApigeeV1OperationGroup--;
}

core.int buildCounterGoogleCloudApigeeV1OperationMetadata = 0;
api.GoogleCloudApigeeV1OperationMetadata
    buildGoogleCloudApigeeV1OperationMetadata() {
  var o = api.GoogleCloudApigeeV1OperationMetadata();
  buildCounterGoogleCloudApigeeV1OperationMetadata++;
  if (buildCounterGoogleCloudApigeeV1OperationMetadata < 3) {
    o.operationType = 'foo';
    o.state = 'foo';
    o.targetResourceName = 'foo';
  }
  buildCounterGoogleCloudApigeeV1OperationMetadata--;
  return o;
}

void checkGoogleCloudApigeeV1OperationMetadata(
    api.GoogleCloudApigeeV1OperationMetadata o) {
  buildCounterGoogleCloudApigeeV1OperationMetadata++;
  if (buildCounterGoogleCloudApigeeV1OperationMetadata < 3) {
    unittest.expect(
      o.operationType!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.targetResourceName!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1OperationMetadata--;
}

core.int buildCounterGoogleCloudApigeeV1OptimizedStats = 0;
api.GoogleCloudApigeeV1OptimizedStats buildGoogleCloudApigeeV1OptimizedStats() {
  var o = api.GoogleCloudApigeeV1OptimizedStats();
  buildCounterGoogleCloudApigeeV1OptimizedStats++;
  if (buildCounterGoogleCloudApigeeV1OptimizedStats < 3) {
    o.Response = buildGoogleCloudApigeeV1OptimizedStatsResponse();
  }
  buildCounterGoogleCloudApigeeV1OptimizedStats--;
  return o;
}

void checkGoogleCloudApigeeV1OptimizedStats(
    api.GoogleCloudApigeeV1OptimizedStats o) {
  buildCounterGoogleCloudApigeeV1OptimizedStats++;
  if (buildCounterGoogleCloudApigeeV1OptimizedStats < 3) {
    checkGoogleCloudApigeeV1OptimizedStatsResponse(
        o.Response! as api.GoogleCloudApigeeV1OptimizedStatsResponse);
  }
  buildCounterGoogleCloudApigeeV1OptimizedStats--;
}

core.List<core.Object> buildUnnamed3438() {
  var o = <core.Object>[];
  o.add({
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  });
  o.add({
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  });
  return o;
}

void checkUnnamed3438(core.List<core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted9 = (o[0]) as core.Map;
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
  var casted10 = (o[1]) as core.Map;
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

core.int buildCounterGoogleCloudApigeeV1OptimizedStatsNode = 0;
api.GoogleCloudApigeeV1OptimizedStatsNode
    buildGoogleCloudApigeeV1OptimizedStatsNode() {
  var o = api.GoogleCloudApigeeV1OptimizedStatsNode();
  buildCounterGoogleCloudApigeeV1OptimizedStatsNode++;
  if (buildCounterGoogleCloudApigeeV1OptimizedStatsNode < 3) {
    o.data = buildUnnamed3438();
  }
  buildCounterGoogleCloudApigeeV1OptimizedStatsNode--;
  return o;
}

void checkGoogleCloudApigeeV1OptimizedStatsNode(
    api.GoogleCloudApigeeV1OptimizedStatsNode o) {
  buildCounterGoogleCloudApigeeV1OptimizedStatsNode++;
  if (buildCounterGoogleCloudApigeeV1OptimizedStatsNode < 3) {
    checkUnnamed3438(o.data!);
  }
  buildCounterGoogleCloudApigeeV1OptimizedStatsNode--;
}

core.List<core.String> buildUnnamed3439() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3439(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1OptimizedStatsResponse = 0;
api.GoogleCloudApigeeV1OptimizedStatsResponse
    buildGoogleCloudApigeeV1OptimizedStatsResponse() {
  var o = api.GoogleCloudApigeeV1OptimizedStatsResponse();
  buildCounterGoogleCloudApigeeV1OptimizedStatsResponse++;
  if (buildCounterGoogleCloudApigeeV1OptimizedStatsResponse < 3) {
    o.TimeUnit = buildUnnamed3439();
    o.metaData = buildGoogleCloudApigeeV1Metadata();
    o.resultTruncated = true;
    o.stats = buildGoogleCloudApigeeV1OptimizedStatsNode();
  }
  buildCounterGoogleCloudApigeeV1OptimizedStatsResponse--;
  return o;
}

void checkGoogleCloudApigeeV1OptimizedStatsResponse(
    api.GoogleCloudApigeeV1OptimizedStatsResponse o) {
  buildCounterGoogleCloudApigeeV1OptimizedStatsResponse++;
  if (buildCounterGoogleCloudApigeeV1OptimizedStatsResponse < 3) {
    checkUnnamed3439(o.TimeUnit!);
    checkGoogleCloudApigeeV1Metadata(
        o.metaData! as api.GoogleCloudApigeeV1Metadata);
    unittest.expect(o.resultTruncated!, unittest.isTrue);
    checkGoogleCloudApigeeV1OptimizedStatsNode(
        o.stats! as api.GoogleCloudApigeeV1OptimizedStatsNode);
  }
  buildCounterGoogleCloudApigeeV1OptimizedStatsResponse--;
}

core.List<core.String> buildUnnamed3440() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3440(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed3441() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3441(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1Organization = 0;
api.GoogleCloudApigeeV1Organization buildGoogleCloudApigeeV1Organization() {
  var o = api.GoogleCloudApigeeV1Organization();
  buildCounterGoogleCloudApigeeV1Organization++;
  if (buildCounterGoogleCloudApigeeV1Organization < 3) {
    o.analyticsRegion = 'foo';
    o.attributes = buildUnnamed3440();
    o.authorizedNetwork = 'foo';
    o.billingType = 'foo';
    o.caCertificate = 'foo';
    o.createdAt = 'foo';
    o.customerName = 'foo';
    o.description = 'foo';
    o.displayName = 'foo';
    o.environments = buildUnnamed3441();
    o.expiresAt = 'foo';
    o.lastModifiedAt = 'foo';
    o.name = 'foo';
    o.projectId = 'foo';
    o.properties = buildGoogleCloudApigeeV1Properties();
    o.runtimeDatabaseEncryptionKeyName = 'foo';
    o.runtimeType_ = 'foo';
    o.state = 'foo';
    o.subscriptionType = 'foo';
    o.type = 'foo';
  }
  buildCounterGoogleCloudApigeeV1Organization--;
  return o;
}

void checkGoogleCloudApigeeV1Organization(
    api.GoogleCloudApigeeV1Organization o) {
  buildCounterGoogleCloudApigeeV1Organization++;
  if (buildCounterGoogleCloudApigeeV1Organization < 3) {
    unittest.expect(
      o.analyticsRegion!,
      unittest.equals('foo'),
    );
    checkUnnamed3440(o.attributes!);
    unittest.expect(
      o.authorizedNetwork!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.billingType!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.caCertificate!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.createdAt!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.customerName!,
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
    checkUnnamed3441(o.environments!);
    unittest.expect(
      o.expiresAt!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.lastModifiedAt!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.projectId!,
      unittest.equals('foo'),
    );
    checkGoogleCloudApigeeV1Properties(
        o.properties! as api.GoogleCloudApigeeV1Properties);
    unittest.expect(
      o.runtimeDatabaseEncryptionKeyName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.runtimeType_!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.subscriptionType!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1Organization--;
}

core.List<core.String> buildUnnamed3442() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3442(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1OrganizationProjectMapping = 0;
api.GoogleCloudApigeeV1OrganizationProjectMapping
    buildGoogleCloudApigeeV1OrganizationProjectMapping() {
  var o = api.GoogleCloudApigeeV1OrganizationProjectMapping();
  buildCounterGoogleCloudApigeeV1OrganizationProjectMapping++;
  if (buildCounterGoogleCloudApigeeV1OrganizationProjectMapping < 3) {
    o.organization = 'foo';
    o.projectIds = buildUnnamed3442();
  }
  buildCounterGoogleCloudApigeeV1OrganizationProjectMapping--;
  return o;
}

void checkGoogleCloudApigeeV1OrganizationProjectMapping(
    api.GoogleCloudApigeeV1OrganizationProjectMapping o) {
  buildCounterGoogleCloudApigeeV1OrganizationProjectMapping++;
  if (buildCounterGoogleCloudApigeeV1OrganizationProjectMapping < 3) {
    unittest.expect(
      o.organization!,
      unittest.equals('foo'),
    );
    checkUnnamed3442(o.projectIds!);
  }
  buildCounterGoogleCloudApigeeV1OrganizationProjectMapping--;
}

core.int buildCounterGoogleCloudApigeeV1PodStatus = 0;
api.GoogleCloudApigeeV1PodStatus buildGoogleCloudApigeeV1PodStatus() {
  var o = api.GoogleCloudApigeeV1PodStatus();
  buildCounterGoogleCloudApigeeV1PodStatus++;
  if (buildCounterGoogleCloudApigeeV1PodStatus < 3) {
    o.appVersion = 'foo';
    o.deploymentStatus = 'foo';
    o.deploymentStatusTime = 'foo';
    o.deploymentTime = 'foo';
    o.podName = 'foo';
    o.podStatus = 'foo';
    o.podStatusTime = 'foo';
    o.statusCode = 'foo';
    o.statusCodeDetails = 'foo';
  }
  buildCounterGoogleCloudApigeeV1PodStatus--;
  return o;
}

void checkGoogleCloudApigeeV1PodStatus(api.GoogleCloudApigeeV1PodStatus o) {
  buildCounterGoogleCloudApigeeV1PodStatus++;
  if (buildCounterGoogleCloudApigeeV1PodStatus < 3) {
    unittest.expect(
      o.appVersion!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.deploymentStatus!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.deploymentStatusTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.deploymentTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.podName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.podStatus!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.podStatusTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.statusCode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.statusCodeDetails!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1PodStatus--;
}

core.List<api.GoogleCloudApigeeV1Result> buildUnnamed3443() {
  var o = <api.GoogleCloudApigeeV1Result>[];
  o.add(buildGoogleCloudApigeeV1Result());
  o.add(buildGoogleCloudApigeeV1Result());
  return o;
}

void checkUnnamed3443(core.List<api.GoogleCloudApigeeV1Result> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Result(o[0] as api.GoogleCloudApigeeV1Result);
  checkGoogleCloudApigeeV1Result(o[1] as api.GoogleCloudApigeeV1Result);
}

core.int buildCounterGoogleCloudApigeeV1Point = 0;
api.GoogleCloudApigeeV1Point buildGoogleCloudApigeeV1Point() {
  var o = api.GoogleCloudApigeeV1Point();
  buildCounterGoogleCloudApigeeV1Point++;
  if (buildCounterGoogleCloudApigeeV1Point < 3) {
    o.id = 'foo';
    o.results = buildUnnamed3443();
  }
  buildCounterGoogleCloudApigeeV1Point--;
  return o;
}

void checkGoogleCloudApigeeV1Point(api.GoogleCloudApigeeV1Point o) {
  buildCounterGoogleCloudApigeeV1Point++;
  if (buildCounterGoogleCloudApigeeV1Point < 3) {
    unittest.expect(
      o.id!,
      unittest.equals('foo'),
    );
    checkUnnamed3443(o.results!);
  }
  buildCounterGoogleCloudApigeeV1Point--;
}

core.List<api.GoogleCloudApigeeV1Property> buildUnnamed3444() {
  var o = <api.GoogleCloudApigeeV1Property>[];
  o.add(buildGoogleCloudApigeeV1Property());
  o.add(buildGoogleCloudApigeeV1Property());
  return o;
}

void checkUnnamed3444(core.List<api.GoogleCloudApigeeV1Property> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Property(o[0] as api.GoogleCloudApigeeV1Property);
  checkGoogleCloudApigeeV1Property(o[1] as api.GoogleCloudApigeeV1Property);
}

core.int buildCounterGoogleCloudApigeeV1Properties = 0;
api.GoogleCloudApigeeV1Properties buildGoogleCloudApigeeV1Properties() {
  var o = api.GoogleCloudApigeeV1Properties();
  buildCounterGoogleCloudApigeeV1Properties++;
  if (buildCounterGoogleCloudApigeeV1Properties < 3) {
    o.property = buildUnnamed3444();
  }
  buildCounterGoogleCloudApigeeV1Properties--;
  return o;
}

void checkGoogleCloudApigeeV1Properties(api.GoogleCloudApigeeV1Properties o) {
  buildCounterGoogleCloudApigeeV1Properties++;
  if (buildCounterGoogleCloudApigeeV1Properties < 3) {
    checkUnnamed3444(o.property!);
  }
  buildCounterGoogleCloudApigeeV1Properties--;
}

core.int buildCounterGoogleCloudApigeeV1Property = 0;
api.GoogleCloudApigeeV1Property buildGoogleCloudApigeeV1Property() {
  var o = api.GoogleCloudApigeeV1Property();
  buildCounterGoogleCloudApigeeV1Property++;
  if (buildCounterGoogleCloudApigeeV1Property < 3) {
    o.name = 'foo';
    o.value = 'foo';
  }
  buildCounterGoogleCloudApigeeV1Property--;
  return o;
}

void checkGoogleCloudApigeeV1Property(api.GoogleCloudApigeeV1Property o) {
  buildCounterGoogleCloudApigeeV1Property++;
  if (buildCounterGoogleCloudApigeeV1Property < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1Property--;
}

core.int buildCounterGoogleCloudApigeeV1ProvisionOrganizationRequest = 0;
api.GoogleCloudApigeeV1ProvisionOrganizationRequest
    buildGoogleCloudApigeeV1ProvisionOrganizationRequest() {
  var o = api.GoogleCloudApigeeV1ProvisionOrganizationRequest();
  buildCounterGoogleCloudApigeeV1ProvisionOrganizationRequest++;
  if (buildCounterGoogleCloudApigeeV1ProvisionOrganizationRequest < 3) {
    o.analyticsRegion = 'foo';
    o.authorizedNetwork = 'foo';
    o.runtimeLocation = 'foo';
  }
  buildCounterGoogleCloudApigeeV1ProvisionOrganizationRequest--;
  return o;
}

void checkGoogleCloudApigeeV1ProvisionOrganizationRequest(
    api.GoogleCloudApigeeV1ProvisionOrganizationRequest o) {
  buildCounterGoogleCloudApigeeV1ProvisionOrganizationRequest++;
  if (buildCounterGoogleCloudApigeeV1ProvisionOrganizationRequest < 3) {
    unittest.expect(
      o.analyticsRegion!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.authorizedNetwork!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.runtimeLocation!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1ProvisionOrganizationRequest--;
}

core.List<core.String> buildUnnamed3445() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3445(core.List<core.String> o) {
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

core.List<api.GoogleCloudApigeeV1QueryMetric> buildUnnamed3446() {
  var o = <api.GoogleCloudApigeeV1QueryMetric>[];
  o.add(buildGoogleCloudApigeeV1QueryMetric());
  o.add(buildGoogleCloudApigeeV1QueryMetric());
  return o;
}

void checkUnnamed3446(core.List<api.GoogleCloudApigeeV1QueryMetric> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1QueryMetric(
      o[0] as api.GoogleCloudApigeeV1QueryMetric);
  checkGoogleCloudApigeeV1QueryMetric(
      o[1] as api.GoogleCloudApigeeV1QueryMetric);
}

core.int buildCounterGoogleCloudApigeeV1Query = 0;
api.GoogleCloudApigeeV1Query buildGoogleCloudApigeeV1Query() {
  var o = api.GoogleCloudApigeeV1Query();
  buildCounterGoogleCloudApigeeV1Query++;
  if (buildCounterGoogleCloudApigeeV1Query < 3) {
    o.csvDelimiter = 'foo';
    o.dimensions = buildUnnamed3445();
    o.envgroupHostname = 'foo';
    o.filter = 'foo';
    o.groupByTimeUnit = 'foo';
    o.limit = 42;
    o.metrics = buildUnnamed3446();
    o.name = 'foo';
    o.outputFormat = 'foo';
    o.reportDefinitionId = 'foo';
    o.timeRange = {
      'list': [1, 2, 3],
      'bool': true,
      'string': 'foo'
    };
  }
  buildCounterGoogleCloudApigeeV1Query--;
  return o;
}

void checkGoogleCloudApigeeV1Query(api.GoogleCloudApigeeV1Query o) {
  buildCounterGoogleCloudApigeeV1Query++;
  if (buildCounterGoogleCloudApigeeV1Query < 3) {
    unittest.expect(
      o.csvDelimiter!,
      unittest.equals('foo'),
    );
    checkUnnamed3445(o.dimensions!);
    unittest.expect(
      o.envgroupHostname!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.filter!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.groupByTimeUnit!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.limit!,
      unittest.equals(42),
    );
    checkUnnamed3446(o.metrics!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.outputFormat!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.reportDefinitionId!,
      unittest.equals('foo'),
    );
    var casted11 = (o.timeRange!) as core.Map;
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
  }
  buildCounterGoogleCloudApigeeV1Query--;
}

core.List<core.String> buildUnnamed3447() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3447(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed3448() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3448(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1QueryMetadata = 0;
api.GoogleCloudApigeeV1QueryMetadata buildGoogleCloudApigeeV1QueryMetadata() {
  var o = api.GoogleCloudApigeeV1QueryMetadata();
  buildCounterGoogleCloudApigeeV1QueryMetadata++;
  if (buildCounterGoogleCloudApigeeV1QueryMetadata < 3) {
    o.dimensions = buildUnnamed3447();
    o.endTimestamp = 'foo';
    o.metrics = buildUnnamed3448();
    o.outputFormat = 'foo';
    o.startTimestamp = 'foo';
    o.timeUnit = 'foo';
  }
  buildCounterGoogleCloudApigeeV1QueryMetadata--;
  return o;
}

void checkGoogleCloudApigeeV1QueryMetadata(
    api.GoogleCloudApigeeV1QueryMetadata o) {
  buildCounterGoogleCloudApigeeV1QueryMetadata++;
  if (buildCounterGoogleCloudApigeeV1QueryMetadata < 3) {
    checkUnnamed3447(o.dimensions!);
    unittest.expect(
      o.endTimestamp!,
      unittest.equals('foo'),
    );
    checkUnnamed3448(o.metrics!);
    unittest.expect(
      o.outputFormat!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.startTimestamp!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.timeUnit!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1QueryMetadata--;
}

core.int buildCounterGoogleCloudApigeeV1QueryMetric = 0;
api.GoogleCloudApigeeV1QueryMetric buildGoogleCloudApigeeV1QueryMetric() {
  var o = api.GoogleCloudApigeeV1QueryMetric();
  buildCounterGoogleCloudApigeeV1QueryMetric++;
  if (buildCounterGoogleCloudApigeeV1QueryMetric < 3) {
    o.alias = 'foo';
    o.function = 'foo';
    o.name = 'foo';
    o.operator = 'foo';
    o.value = 'foo';
  }
  buildCounterGoogleCloudApigeeV1QueryMetric--;
  return o;
}

void checkGoogleCloudApigeeV1QueryMetric(api.GoogleCloudApigeeV1QueryMetric o) {
  buildCounterGoogleCloudApigeeV1QueryMetric++;
  if (buildCounterGoogleCloudApigeeV1QueryMetric < 3) {
    unittest.expect(
      o.alias!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.function!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.operator!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1QueryMetric--;
}

core.int buildCounterGoogleCloudApigeeV1Quota = 0;
api.GoogleCloudApigeeV1Quota buildGoogleCloudApigeeV1Quota() {
  var o = api.GoogleCloudApigeeV1Quota();
  buildCounterGoogleCloudApigeeV1Quota++;
  if (buildCounterGoogleCloudApigeeV1Quota < 3) {
    o.interval = 'foo';
    o.limit = 'foo';
    o.timeUnit = 'foo';
  }
  buildCounterGoogleCloudApigeeV1Quota--;
  return o;
}

void checkGoogleCloudApigeeV1Quota(api.GoogleCloudApigeeV1Quota o) {
  buildCounterGoogleCloudApigeeV1Quota++;
  if (buildCounterGoogleCloudApigeeV1Quota < 3) {
    unittest.expect(
      o.interval!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.limit!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.timeUnit!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1Quota--;
}

core.int buildCounterGoogleCloudApigeeV1Reference = 0;
api.GoogleCloudApigeeV1Reference buildGoogleCloudApigeeV1Reference() {
  var o = api.GoogleCloudApigeeV1Reference();
  buildCounterGoogleCloudApigeeV1Reference++;
  if (buildCounterGoogleCloudApigeeV1Reference < 3) {
    o.description = 'foo';
    o.name = 'foo';
    o.refers = 'foo';
    o.resourceType = 'foo';
  }
  buildCounterGoogleCloudApigeeV1Reference--;
  return o;
}

void checkGoogleCloudApigeeV1Reference(api.GoogleCloudApigeeV1Reference o) {
  buildCounterGoogleCloudApigeeV1Reference++;
  if (buildCounterGoogleCloudApigeeV1Reference < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.refers!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.resourceType!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1Reference--;
}

core.int buildCounterGoogleCloudApigeeV1ReferenceConfig = 0;
api.GoogleCloudApigeeV1ReferenceConfig
    buildGoogleCloudApigeeV1ReferenceConfig() {
  var o = api.GoogleCloudApigeeV1ReferenceConfig();
  buildCounterGoogleCloudApigeeV1ReferenceConfig++;
  if (buildCounterGoogleCloudApigeeV1ReferenceConfig < 3) {
    o.name = 'foo';
    o.resourceName = 'foo';
  }
  buildCounterGoogleCloudApigeeV1ReferenceConfig--;
  return o;
}

void checkGoogleCloudApigeeV1ReferenceConfig(
    api.GoogleCloudApigeeV1ReferenceConfig o) {
  buildCounterGoogleCloudApigeeV1ReferenceConfig++;
  if (buildCounterGoogleCloudApigeeV1ReferenceConfig < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.resourceName!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1ReferenceConfig--;
}

core.List<api.GoogleCloudApigeeV1ResourceStatus> buildUnnamed3449() {
  var o = <api.GoogleCloudApigeeV1ResourceStatus>[];
  o.add(buildGoogleCloudApigeeV1ResourceStatus());
  o.add(buildGoogleCloudApigeeV1ResourceStatus());
  return o;
}

void checkUnnamed3449(core.List<api.GoogleCloudApigeeV1ResourceStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1ResourceStatus(
      o[0] as api.GoogleCloudApigeeV1ResourceStatus);
  checkGoogleCloudApigeeV1ResourceStatus(
      o[1] as api.GoogleCloudApigeeV1ResourceStatus);
}

core.int buildCounterGoogleCloudApigeeV1ReportInstanceStatusRequest = 0;
api.GoogleCloudApigeeV1ReportInstanceStatusRequest
    buildGoogleCloudApigeeV1ReportInstanceStatusRequest() {
  var o = api.GoogleCloudApigeeV1ReportInstanceStatusRequest();
  buildCounterGoogleCloudApigeeV1ReportInstanceStatusRequest++;
  if (buildCounterGoogleCloudApigeeV1ReportInstanceStatusRequest < 3) {
    o.instanceUid = 'foo';
    o.reportTime = 'foo';
    o.resources = buildUnnamed3449();
  }
  buildCounterGoogleCloudApigeeV1ReportInstanceStatusRequest--;
  return o;
}

void checkGoogleCloudApigeeV1ReportInstanceStatusRequest(
    api.GoogleCloudApigeeV1ReportInstanceStatusRequest o) {
  buildCounterGoogleCloudApigeeV1ReportInstanceStatusRequest++;
  if (buildCounterGoogleCloudApigeeV1ReportInstanceStatusRequest < 3) {
    unittest.expect(
      o.instanceUid!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.reportTime!,
      unittest.equals('foo'),
    );
    checkUnnamed3449(o.resources!);
  }
  buildCounterGoogleCloudApigeeV1ReportInstanceStatusRequest--;
}

core.int buildCounterGoogleCloudApigeeV1ReportInstanceStatusResponse = 0;
api.GoogleCloudApigeeV1ReportInstanceStatusResponse
    buildGoogleCloudApigeeV1ReportInstanceStatusResponse() {
  var o = api.GoogleCloudApigeeV1ReportInstanceStatusResponse();
  buildCounterGoogleCloudApigeeV1ReportInstanceStatusResponse++;
  if (buildCounterGoogleCloudApigeeV1ReportInstanceStatusResponse < 3) {}
  buildCounterGoogleCloudApigeeV1ReportInstanceStatusResponse--;
  return o;
}

void checkGoogleCloudApigeeV1ReportInstanceStatusResponse(
    api.GoogleCloudApigeeV1ReportInstanceStatusResponse o) {
  buildCounterGoogleCloudApigeeV1ReportInstanceStatusResponse++;
  if (buildCounterGoogleCloudApigeeV1ReportInstanceStatusResponse < 3) {}
  buildCounterGoogleCloudApigeeV1ReportInstanceStatusResponse--;
}

core.List<api.GoogleCloudApigeeV1Attribute> buildUnnamed3450() {
  var o = <api.GoogleCloudApigeeV1Attribute>[];
  o.add(buildGoogleCloudApigeeV1Attribute());
  o.add(buildGoogleCloudApigeeV1Attribute());
  return o;
}

void checkUnnamed3450(core.List<api.GoogleCloudApigeeV1Attribute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Attribute(o[0] as api.GoogleCloudApigeeV1Attribute);
  checkGoogleCloudApigeeV1Attribute(o[1] as api.GoogleCloudApigeeV1Attribute);
}

core.int buildCounterGoogleCloudApigeeV1ReportProperty = 0;
api.GoogleCloudApigeeV1ReportProperty buildGoogleCloudApigeeV1ReportProperty() {
  var o = api.GoogleCloudApigeeV1ReportProperty();
  buildCounterGoogleCloudApigeeV1ReportProperty++;
  if (buildCounterGoogleCloudApigeeV1ReportProperty < 3) {
    o.property = 'foo';
    o.value = buildUnnamed3450();
  }
  buildCounterGoogleCloudApigeeV1ReportProperty--;
  return o;
}

void checkGoogleCloudApigeeV1ReportProperty(
    api.GoogleCloudApigeeV1ReportProperty o) {
  buildCounterGoogleCloudApigeeV1ReportProperty++;
  if (buildCounterGoogleCloudApigeeV1ReportProperty < 3) {
    unittest.expect(
      o.property!,
      unittest.equals('foo'),
    );
    checkUnnamed3450(o.value!);
  }
  buildCounterGoogleCloudApigeeV1ReportProperty--;
}

core.int buildCounterGoogleCloudApigeeV1ResourceConfig = 0;
api.GoogleCloudApigeeV1ResourceConfig buildGoogleCloudApigeeV1ResourceConfig() {
  var o = api.GoogleCloudApigeeV1ResourceConfig();
  buildCounterGoogleCloudApigeeV1ResourceConfig++;
  if (buildCounterGoogleCloudApigeeV1ResourceConfig < 3) {
    o.location = 'foo';
    o.name = 'foo';
  }
  buildCounterGoogleCloudApigeeV1ResourceConfig--;
  return o;
}

void checkGoogleCloudApigeeV1ResourceConfig(
    api.GoogleCloudApigeeV1ResourceConfig o) {
  buildCounterGoogleCloudApigeeV1ResourceConfig++;
  if (buildCounterGoogleCloudApigeeV1ResourceConfig < 3) {
    unittest.expect(
      o.location!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1ResourceConfig--;
}

core.int buildCounterGoogleCloudApigeeV1ResourceFile = 0;
api.GoogleCloudApigeeV1ResourceFile buildGoogleCloudApigeeV1ResourceFile() {
  var o = api.GoogleCloudApigeeV1ResourceFile();
  buildCounterGoogleCloudApigeeV1ResourceFile++;
  if (buildCounterGoogleCloudApigeeV1ResourceFile < 3) {
    o.name = 'foo';
    o.type = 'foo';
  }
  buildCounterGoogleCloudApigeeV1ResourceFile--;
  return o;
}

void checkGoogleCloudApigeeV1ResourceFile(
    api.GoogleCloudApigeeV1ResourceFile o) {
  buildCounterGoogleCloudApigeeV1ResourceFile++;
  if (buildCounterGoogleCloudApigeeV1ResourceFile < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1ResourceFile--;
}

core.List<api.GoogleCloudApigeeV1ResourceFile> buildUnnamed3451() {
  var o = <api.GoogleCloudApigeeV1ResourceFile>[];
  o.add(buildGoogleCloudApigeeV1ResourceFile());
  o.add(buildGoogleCloudApigeeV1ResourceFile());
  return o;
}

void checkUnnamed3451(core.List<api.GoogleCloudApigeeV1ResourceFile> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1ResourceFile(
      o[0] as api.GoogleCloudApigeeV1ResourceFile);
  checkGoogleCloudApigeeV1ResourceFile(
      o[1] as api.GoogleCloudApigeeV1ResourceFile);
}

core.int buildCounterGoogleCloudApigeeV1ResourceFiles = 0;
api.GoogleCloudApigeeV1ResourceFiles buildGoogleCloudApigeeV1ResourceFiles() {
  var o = api.GoogleCloudApigeeV1ResourceFiles();
  buildCounterGoogleCloudApigeeV1ResourceFiles++;
  if (buildCounterGoogleCloudApigeeV1ResourceFiles < 3) {
    o.resourceFile = buildUnnamed3451();
  }
  buildCounterGoogleCloudApigeeV1ResourceFiles--;
  return o;
}

void checkGoogleCloudApigeeV1ResourceFiles(
    api.GoogleCloudApigeeV1ResourceFiles o) {
  buildCounterGoogleCloudApigeeV1ResourceFiles++;
  if (buildCounterGoogleCloudApigeeV1ResourceFiles < 3) {
    checkUnnamed3451(o.resourceFile!);
  }
  buildCounterGoogleCloudApigeeV1ResourceFiles--;
}

core.List<api.GoogleCloudApigeeV1RevisionStatus> buildUnnamed3452() {
  var o = <api.GoogleCloudApigeeV1RevisionStatus>[];
  o.add(buildGoogleCloudApigeeV1RevisionStatus());
  o.add(buildGoogleCloudApigeeV1RevisionStatus());
  return o;
}

void checkUnnamed3452(core.List<api.GoogleCloudApigeeV1RevisionStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1RevisionStatus(
      o[0] as api.GoogleCloudApigeeV1RevisionStatus);
  checkGoogleCloudApigeeV1RevisionStatus(
      o[1] as api.GoogleCloudApigeeV1RevisionStatus);
}

core.int buildCounterGoogleCloudApigeeV1ResourceStatus = 0;
api.GoogleCloudApigeeV1ResourceStatus buildGoogleCloudApigeeV1ResourceStatus() {
  var o = api.GoogleCloudApigeeV1ResourceStatus();
  buildCounterGoogleCloudApigeeV1ResourceStatus++;
  if (buildCounterGoogleCloudApigeeV1ResourceStatus < 3) {
    o.resource = 'foo';
    o.revisions = buildUnnamed3452();
    o.totalReplicas = 42;
    o.uid = 'foo';
  }
  buildCounterGoogleCloudApigeeV1ResourceStatus--;
  return o;
}

void checkGoogleCloudApigeeV1ResourceStatus(
    api.GoogleCloudApigeeV1ResourceStatus o) {
  buildCounterGoogleCloudApigeeV1ResourceStatus++;
  if (buildCounterGoogleCloudApigeeV1ResourceStatus < 3) {
    unittest.expect(
      o.resource!,
      unittest.equals('foo'),
    );
    checkUnnamed3452(o.revisions!);
    unittest.expect(
      o.totalReplicas!,
      unittest.equals(42),
    );
    unittest.expect(
      o.uid!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1ResourceStatus--;
}

core.List<api.GoogleCloudApigeeV1Access> buildUnnamed3453() {
  var o = <api.GoogleCloudApigeeV1Access>[];
  o.add(buildGoogleCloudApigeeV1Access());
  o.add(buildGoogleCloudApigeeV1Access());
  return o;
}

void checkUnnamed3453(core.List<api.GoogleCloudApigeeV1Access> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Access(o[0] as api.GoogleCloudApigeeV1Access);
  checkGoogleCloudApigeeV1Access(o[1] as api.GoogleCloudApigeeV1Access);
}

core.List<api.GoogleCloudApigeeV1Property> buildUnnamed3454() {
  var o = <api.GoogleCloudApigeeV1Property>[];
  o.add(buildGoogleCloudApigeeV1Property());
  o.add(buildGoogleCloudApigeeV1Property());
  return o;
}

void checkUnnamed3454(core.List<api.GoogleCloudApigeeV1Property> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Property(o[0] as api.GoogleCloudApigeeV1Property);
  checkGoogleCloudApigeeV1Property(o[1] as api.GoogleCloudApigeeV1Property);
}

core.int buildCounterGoogleCloudApigeeV1Result = 0;
api.GoogleCloudApigeeV1Result buildGoogleCloudApigeeV1Result() {
  var o = api.GoogleCloudApigeeV1Result();
  buildCounterGoogleCloudApigeeV1Result++;
  if (buildCounterGoogleCloudApigeeV1Result < 3) {
    o.ActionResult = 'foo';
    o.accessList = buildUnnamed3453();
    o.content = 'foo';
    o.headers = buildUnnamed3454();
    o.properties = buildGoogleCloudApigeeV1Properties();
    o.reasonPhrase = 'foo';
    o.statusCode = 'foo';
    o.timestamp = 'foo';
    o.uRI = 'foo';
    o.verb = 'foo';
  }
  buildCounterGoogleCloudApigeeV1Result--;
  return o;
}

void checkGoogleCloudApigeeV1Result(api.GoogleCloudApigeeV1Result o) {
  buildCounterGoogleCloudApigeeV1Result++;
  if (buildCounterGoogleCloudApigeeV1Result < 3) {
    unittest.expect(
      o.ActionResult!,
      unittest.equals('foo'),
    );
    checkUnnamed3453(o.accessList!);
    unittest.expect(
      o.content!,
      unittest.equals('foo'),
    );
    checkUnnamed3454(o.headers!);
    checkGoogleCloudApigeeV1Properties(
        o.properties! as api.GoogleCloudApigeeV1Properties);
    unittest.expect(
      o.reasonPhrase!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.statusCode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.timestamp!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.uRI!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.verb!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1Result--;
}

core.List<api.GoogleCloudApigeeV1UpdateError> buildUnnamed3455() {
  var o = <api.GoogleCloudApigeeV1UpdateError>[];
  o.add(buildGoogleCloudApigeeV1UpdateError());
  o.add(buildGoogleCloudApigeeV1UpdateError());
  return o;
}

void checkUnnamed3455(core.List<api.GoogleCloudApigeeV1UpdateError> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1UpdateError(
      o[0] as api.GoogleCloudApigeeV1UpdateError);
  checkGoogleCloudApigeeV1UpdateError(
      o[1] as api.GoogleCloudApigeeV1UpdateError);
}

core.int buildCounterGoogleCloudApigeeV1RevisionStatus = 0;
api.GoogleCloudApigeeV1RevisionStatus buildGoogleCloudApigeeV1RevisionStatus() {
  var o = api.GoogleCloudApigeeV1RevisionStatus();
  buildCounterGoogleCloudApigeeV1RevisionStatus++;
  if (buildCounterGoogleCloudApigeeV1RevisionStatus < 3) {
    o.errors = buildUnnamed3455();
    o.jsonSpec = 'foo';
    o.replicas = 42;
    o.revisionId = 'foo';
  }
  buildCounterGoogleCloudApigeeV1RevisionStatus--;
  return o;
}

void checkGoogleCloudApigeeV1RevisionStatus(
    api.GoogleCloudApigeeV1RevisionStatus o) {
  buildCounterGoogleCloudApigeeV1RevisionStatus++;
  if (buildCounterGoogleCloudApigeeV1RevisionStatus < 3) {
    checkUnnamed3455(o.errors!);
    unittest.expect(
      o.jsonSpec!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.replicas!,
      unittest.equals(42),
    );
    unittest.expect(
      o.revisionId!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1RevisionStatus--;
}

core.int buildCounterGoogleCloudApigeeV1RoutingRule = 0;
api.GoogleCloudApigeeV1RoutingRule buildGoogleCloudApigeeV1RoutingRule() {
  var o = api.GoogleCloudApigeeV1RoutingRule();
  buildCounterGoogleCloudApigeeV1RoutingRule++;
  if (buildCounterGoogleCloudApigeeV1RoutingRule < 3) {
    o.basepath = 'foo';
    o.envGroupRevision = 'foo';
    o.environment = 'foo';
    o.receiver = 'foo';
    o.updateTime = 'foo';
  }
  buildCounterGoogleCloudApigeeV1RoutingRule--;
  return o;
}

void checkGoogleCloudApigeeV1RoutingRule(api.GoogleCloudApigeeV1RoutingRule o) {
  buildCounterGoogleCloudApigeeV1RoutingRule++;
  if (buildCounterGoogleCloudApigeeV1RoutingRule < 3) {
    unittest.expect(
      o.basepath!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.envGroupRevision!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.environment!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.receiver!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.updateTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1RoutingRule--;
}

core.List<api.GoogleCloudApigeeV1RuntimeTraceConfigOverride>
    buildUnnamed3456() {
  var o = <api.GoogleCloudApigeeV1RuntimeTraceConfigOverride>[];
  o.add(buildGoogleCloudApigeeV1RuntimeTraceConfigOverride());
  o.add(buildGoogleCloudApigeeV1RuntimeTraceConfigOverride());
  return o;
}

void checkUnnamed3456(
    core.List<api.GoogleCloudApigeeV1RuntimeTraceConfigOverride> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1RuntimeTraceConfigOverride(
      o[0] as api.GoogleCloudApigeeV1RuntimeTraceConfigOverride);
  checkGoogleCloudApigeeV1RuntimeTraceConfigOverride(
      o[1] as api.GoogleCloudApigeeV1RuntimeTraceConfigOverride);
}

core.int buildCounterGoogleCloudApigeeV1RuntimeTraceConfig = 0;
api.GoogleCloudApigeeV1RuntimeTraceConfig
    buildGoogleCloudApigeeV1RuntimeTraceConfig() {
  var o = api.GoogleCloudApigeeV1RuntimeTraceConfig();
  buildCounterGoogleCloudApigeeV1RuntimeTraceConfig++;
  if (buildCounterGoogleCloudApigeeV1RuntimeTraceConfig < 3) {
    o.endpoint = 'foo';
    o.exporter = 'foo';
    o.name = 'foo';
    o.overrides = buildUnnamed3456();
    o.revisionCreateTime = 'foo';
    o.revisionId = 'foo';
    o.samplingConfig = buildGoogleCloudApigeeV1RuntimeTraceSamplingConfig();
  }
  buildCounterGoogleCloudApigeeV1RuntimeTraceConfig--;
  return o;
}

void checkGoogleCloudApigeeV1RuntimeTraceConfig(
    api.GoogleCloudApigeeV1RuntimeTraceConfig o) {
  buildCounterGoogleCloudApigeeV1RuntimeTraceConfig++;
  if (buildCounterGoogleCloudApigeeV1RuntimeTraceConfig < 3) {
    unittest.expect(
      o.endpoint!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.exporter!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed3456(o.overrides!);
    unittest.expect(
      o.revisionCreateTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.revisionId!,
      unittest.equals('foo'),
    );
    checkGoogleCloudApigeeV1RuntimeTraceSamplingConfig(
        o.samplingConfig! as api.GoogleCloudApigeeV1RuntimeTraceSamplingConfig);
  }
  buildCounterGoogleCloudApigeeV1RuntimeTraceConfig--;
}

core.int buildCounterGoogleCloudApigeeV1RuntimeTraceConfigOverride = 0;
api.GoogleCloudApigeeV1RuntimeTraceConfigOverride
    buildGoogleCloudApigeeV1RuntimeTraceConfigOverride() {
  var o = api.GoogleCloudApigeeV1RuntimeTraceConfigOverride();
  buildCounterGoogleCloudApigeeV1RuntimeTraceConfigOverride++;
  if (buildCounterGoogleCloudApigeeV1RuntimeTraceConfigOverride < 3) {
    o.apiProxy = 'foo';
    o.name = 'foo';
    o.revisionCreateTime = 'foo';
    o.revisionId = 'foo';
    o.samplingConfig = buildGoogleCloudApigeeV1RuntimeTraceSamplingConfig();
    o.uid = 'foo';
  }
  buildCounterGoogleCloudApigeeV1RuntimeTraceConfigOverride--;
  return o;
}

void checkGoogleCloudApigeeV1RuntimeTraceConfigOverride(
    api.GoogleCloudApigeeV1RuntimeTraceConfigOverride o) {
  buildCounterGoogleCloudApigeeV1RuntimeTraceConfigOverride++;
  if (buildCounterGoogleCloudApigeeV1RuntimeTraceConfigOverride < 3) {
    unittest.expect(
      o.apiProxy!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.revisionCreateTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.revisionId!,
      unittest.equals('foo'),
    );
    checkGoogleCloudApigeeV1RuntimeTraceSamplingConfig(
        o.samplingConfig! as api.GoogleCloudApigeeV1RuntimeTraceSamplingConfig);
    unittest.expect(
      o.uid!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1RuntimeTraceConfigOverride--;
}

core.int buildCounterGoogleCloudApigeeV1RuntimeTraceSamplingConfig = 0;
api.GoogleCloudApigeeV1RuntimeTraceSamplingConfig
    buildGoogleCloudApigeeV1RuntimeTraceSamplingConfig() {
  var o = api.GoogleCloudApigeeV1RuntimeTraceSamplingConfig();
  buildCounterGoogleCloudApigeeV1RuntimeTraceSamplingConfig++;
  if (buildCounterGoogleCloudApigeeV1RuntimeTraceSamplingConfig < 3) {
    o.sampler = 'foo';
    o.samplingRate = 42.0;
  }
  buildCounterGoogleCloudApigeeV1RuntimeTraceSamplingConfig--;
  return o;
}

void checkGoogleCloudApigeeV1RuntimeTraceSamplingConfig(
    api.GoogleCloudApigeeV1RuntimeTraceSamplingConfig o) {
  buildCounterGoogleCloudApigeeV1RuntimeTraceSamplingConfig++;
  if (buildCounterGoogleCloudApigeeV1RuntimeTraceSamplingConfig < 3) {
    unittest.expect(
      o.sampler!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.samplingRate!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudApigeeV1RuntimeTraceSamplingConfig--;
}

core.List<api.GoogleCloudApigeeV1SchemaSchemaElement> buildUnnamed3457() {
  var o = <api.GoogleCloudApigeeV1SchemaSchemaElement>[];
  o.add(buildGoogleCloudApigeeV1SchemaSchemaElement());
  o.add(buildGoogleCloudApigeeV1SchemaSchemaElement());
  return o;
}

void checkUnnamed3457(core.List<api.GoogleCloudApigeeV1SchemaSchemaElement> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1SchemaSchemaElement(
      o[0] as api.GoogleCloudApigeeV1SchemaSchemaElement);
  checkGoogleCloudApigeeV1SchemaSchemaElement(
      o[1] as api.GoogleCloudApigeeV1SchemaSchemaElement);
}

core.List<core.String> buildUnnamed3458() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3458(core.List<core.String> o) {
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

core.List<api.GoogleCloudApigeeV1SchemaSchemaElement> buildUnnamed3459() {
  var o = <api.GoogleCloudApigeeV1SchemaSchemaElement>[];
  o.add(buildGoogleCloudApigeeV1SchemaSchemaElement());
  o.add(buildGoogleCloudApigeeV1SchemaSchemaElement());
  return o;
}

void checkUnnamed3459(core.List<api.GoogleCloudApigeeV1SchemaSchemaElement> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1SchemaSchemaElement(
      o[0] as api.GoogleCloudApigeeV1SchemaSchemaElement);
  checkGoogleCloudApigeeV1SchemaSchemaElement(
      o[1] as api.GoogleCloudApigeeV1SchemaSchemaElement);
}

core.int buildCounterGoogleCloudApigeeV1Schema = 0;
api.GoogleCloudApigeeV1Schema buildGoogleCloudApigeeV1Schema() {
  var o = api.GoogleCloudApigeeV1Schema();
  buildCounterGoogleCloudApigeeV1Schema++;
  if (buildCounterGoogleCloudApigeeV1Schema < 3) {
    o.dimensions = buildUnnamed3457();
    o.meta = buildUnnamed3458();
    o.metrics = buildUnnamed3459();
  }
  buildCounterGoogleCloudApigeeV1Schema--;
  return o;
}

void checkGoogleCloudApigeeV1Schema(api.GoogleCloudApigeeV1Schema o) {
  buildCounterGoogleCloudApigeeV1Schema++;
  if (buildCounterGoogleCloudApigeeV1Schema < 3) {
    checkUnnamed3457(o.dimensions!);
    checkUnnamed3458(o.meta!);
    checkUnnamed3459(o.metrics!);
  }
  buildCounterGoogleCloudApigeeV1Schema--;
}

core.int buildCounterGoogleCloudApigeeV1SchemaSchemaElement = 0;
api.GoogleCloudApigeeV1SchemaSchemaElement
    buildGoogleCloudApigeeV1SchemaSchemaElement() {
  var o = api.GoogleCloudApigeeV1SchemaSchemaElement();
  buildCounterGoogleCloudApigeeV1SchemaSchemaElement++;
  if (buildCounterGoogleCloudApigeeV1SchemaSchemaElement < 3) {
    o.name = 'foo';
    o.properties = buildGoogleCloudApigeeV1SchemaSchemaProperty();
  }
  buildCounterGoogleCloudApigeeV1SchemaSchemaElement--;
  return o;
}

void checkGoogleCloudApigeeV1SchemaSchemaElement(
    api.GoogleCloudApigeeV1SchemaSchemaElement o) {
  buildCounterGoogleCloudApigeeV1SchemaSchemaElement++;
  if (buildCounterGoogleCloudApigeeV1SchemaSchemaElement < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkGoogleCloudApigeeV1SchemaSchemaProperty(
        o.properties! as api.GoogleCloudApigeeV1SchemaSchemaProperty);
  }
  buildCounterGoogleCloudApigeeV1SchemaSchemaElement--;
}

core.int buildCounterGoogleCloudApigeeV1SchemaSchemaProperty = 0;
api.GoogleCloudApigeeV1SchemaSchemaProperty
    buildGoogleCloudApigeeV1SchemaSchemaProperty() {
  var o = api.GoogleCloudApigeeV1SchemaSchemaProperty();
  buildCounterGoogleCloudApigeeV1SchemaSchemaProperty++;
  if (buildCounterGoogleCloudApigeeV1SchemaSchemaProperty < 3) {
    o.createTime = 'foo';
    o.custom = 'foo';
    o.type = 'foo';
  }
  buildCounterGoogleCloudApigeeV1SchemaSchemaProperty--;
  return o;
}

void checkGoogleCloudApigeeV1SchemaSchemaProperty(
    api.GoogleCloudApigeeV1SchemaSchemaProperty o) {
  buildCounterGoogleCloudApigeeV1SchemaSchemaProperty++;
  if (buildCounterGoogleCloudApigeeV1SchemaSchemaProperty < 3) {
    unittest.expect(
      o.createTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.custom!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1SchemaSchemaProperty--;
}

core.List<core.String> buildUnnamed3460() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3460(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1ServiceIssuersMapping = 0;
api.GoogleCloudApigeeV1ServiceIssuersMapping
    buildGoogleCloudApigeeV1ServiceIssuersMapping() {
  var o = api.GoogleCloudApigeeV1ServiceIssuersMapping();
  buildCounterGoogleCloudApigeeV1ServiceIssuersMapping++;
  if (buildCounterGoogleCloudApigeeV1ServiceIssuersMapping < 3) {
    o.emailIds = buildUnnamed3460();
    o.service = 'foo';
  }
  buildCounterGoogleCloudApigeeV1ServiceIssuersMapping--;
  return o;
}

void checkGoogleCloudApigeeV1ServiceIssuersMapping(
    api.GoogleCloudApigeeV1ServiceIssuersMapping o) {
  buildCounterGoogleCloudApigeeV1ServiceIssuersMapping++;
  if (buildCounterGoogleCloudApigeeV1ServiceIssuersMapping < 3) {
    checkUnnamed3460(o.emailIds!);
    unittest.expect(
      o.service!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1ServiceIssuersMapping--;
}

core.int buildCounterGoogleCloudApigeeV1Session = 0;
api.GoogleCloudApigeeV1Session buildGoogleCloudApigeeV1Session() {
  var o = api.GoogleCloudApigeeV1Session();
  buildCounterGoogleCloudApigeeV1Session++;
  if (buildCounterGoogleCloudApigeeV1Session < 3) {
    o.id = 'foo';
    o.timestampMs = 'foo';
  }
  buildCounterGoogleCloudApigeeV1Session--;
  return o;
}

void checkGoogleCloudApigeeV1Session(api.GoogleCloudApigeeV1Session o) {
  buildCounterGoogleCloudApigeeV1Session++;
  if (buildCounterGoogleCloudApigeeV1Session < 3) {
    unittest.expect(
      o.id!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.timestampMs!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1Session--;
}

core.List<core.String> buildUnnamed3461() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3461(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1SharedFlow = 0;
api.GoogleCloudApigeeV1SharedFlow buildGoogleCloudApigeeV1SharedFlow() {
  var o = api.GoogleCloudApigeeV1SharedFlow();
  buildCounterGoogleCloudApigeeV1SharedFlow++;
  if (buildCounterGoogleCloudApigeeV1SharedFlow < 3) {
    o.latestRevisionId = 'foo';
    o.metaData = buildGoogleCloudApigeeV1EntityMetadata();
    o.name = 'foo';
    o.revision = buildUnnamed3461();
  }
  buildCounterGoogleCloudApigeeV1SharedFlow--;
  return o;
}

void checkGoogleCloudApigeeV1SharedFlow(api.GoogleCloudApigeeV1SharedFlow o) {
  buildCounterGoogleCloudApigeeV1SharedFlow++;
  if (buildCounterGoogleCloudApigeeV1SharedFlow < 3) {
    unittest.expect(
      o.latestRevisionId!,
      unittest.equals('foo'),
    );
    checkGoogleCloudApigeeV1EntityMetadata(
        o.metaData! as api.GoogleCloudApigeeV1EntityMetadata);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed3461(o.revision!);
  }
  buildCounterGoogleCloudApigeeV1SharedFlow--;
}

core.Map<core.String, core.String> buildUnnamed3462() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed3462(core.Map<core.String, core.String> o) {
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

core.List<core.String> buildUnnamed3463() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3463(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed3464() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3464(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed3465() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3465(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1SharedFlowRevision = 0;
api.GoogleCloudApigeeV1SharedFlowRevision
    buildGoogleCloudApigeeV1SharedFlowRevision() {
  var o = api.GoogleCloudApigeeV1SharedFlowRevision();
  buildCounterGoogleCloudApigeeV1SharedFlowRevision++;
  if (buildCounterGoogleCloudApigeeV1SharedFlowRevision < 3) {
    o.configurationVersion = buildGoogleCloudApigeeV1ConfigVersion();
    o.contextInfo = 'foo';
    o.createdAt = 'foo';
    o.description = 'foo';
    o.displayName = 'foo';
    o.entityMetaDataAsProperties = buildUnnamed3462();
    o.lastModifiedAt = 'foo';
    o.name = 'foo';
    o.policies = buildUnnamed3463();
    o.resourceFiles = buildGoogleCloudApigeeV1ResourceFiles();
    o.resources = buildUnnamed3464();
    o.revision = 'foo';
    o.sharedFlows = buildUnnamed3465();
    o.type = 'foo';
  }
  buildCounterGoogleCloudApigeeV1SharedFlowRevision--;
  return o;
}

void checkGoogleCloudApigeeV1SharedFlowRevision(
    api.GoogleCloudApigeeV1SharedFlowRevision o) {
  buildCounterGoogleCloudApigeeV1SharedFlowRevision++;
  if (buildCounterGoogleCloudApigeeV1SharedFlowRevision < 3) {
    checkGoogleCloudApigeeV1ConfigVersion(
        o.configurationVersion! as api.GoogleCloudApigeeV1ConfigVersion);
    unittest.expect(
      o.contextInfo!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.createdAt!,
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
    checkUnnamed3462(o.entityMetaDataAsProperties!);
    unittest.expect(
      o.lastModifiedAt!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed3463(o.policies!);
    checkGoogleCloudApigeeV1ResourceFiles(
        o.resourceFiles! as api.GoogleCloudApigeeV1ResourceFiles);
    checkUnnamed3464(o.resources!);
    unittest.expect(
      o.revision!,
      unittest.equals('foo'),
    );
    checkUnnamed3465(o.sharedFlows!);
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1SharedFlowRevision--;
}

core.List<api.GoogleCloudApigeeV1StatsEnvironmentStats> buildUnnamed3466() {
  var o = <api.GoogleCloudApigeeV1StatsEnvironmentStats>[];
  o.add(buildGoogleCloudApigeeV1StatsEnvironmentStats());
  o.add(buildGoogleCloudApigeeV1StatsEnvironmentStats());
  return o;
}

void checkUnnamed3466(
    core.List<api.GoogleCloudApigeeV1StatsEnvironmentStats> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1StatsEnvironmentStats(
      o[0] as api.GoogleCloudApigeeV1StatsEnvironmentStats);
  checkGoogleCloudApigeeV1StatsEnvironmentStats(
      o[1] as api.GoogleCloudApigeeV1StatsEnvironmentStats);
}

core.List<api.GoogleCloudApigeeV1StatsHostStats> buildUnnamed3467() {
  var o = <api.GoogleCloudApigeeV1StatsHostStats>[];
  o.add(buildGoogleCloudApigeeV1StatsHostStats());
  o.add(buildGoogleCloudApigeeV1StatsHostStats());
  return o;
}

void checkUnnamed3467(core.List<api.GoogleCloudApigeeV1StatsHostStats> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1StatsHostStats(
      o[0] as api.GoogleCloudApigeeV1StatsHostStats);
  checkGoogleCloudApigeeV1StatsHostStats(
      o[1] as api.GoogleCloudApigeeV1StatsHostStats);
}

core.int buildCounterGoogleCloudApigeeV1Stats = 0;
api.GoogleCloudApigeeV1Stats buildGoogleCloudApigeeV1Stats() {
  var o = api.GoogleCloudApigeeV1Stats();
  buildCounterGoogleCloudApigeeV1Stats++;
  if (buildCounterGoogleCloudApigeeV1Stats < 3) {
    o.environments = buildUnnamed3466();
    o.hosts = buildUnnamed3467();
    o.metaData = buildGoogleCloudApigeeV1Metadata();
  }
  buildCounterGoogleCloudApigeeV1Stats--;
  return o;
}

void checkGoogleCloudApigeeV1Stats(api.GoogleCloudApigeeV1Stats o) {
  buildCounterGoogleCloudApigeeV1Stats++;
  if (buildCounterGoogleCloudApigeeV1Stats < 3) {
    checkUnnamed3466(o.environments!);
    checkUnnamed3467(o.hosts!);
    checkGoogleCloudApigeeV1Metadata(
        o.metaData! as api.GoogleCloudApigeeV1Metadata);
  }
  buildCounterGoogleCloudApigeeV1Stats--;
}

core.List<api.GoogleCloudApigeeV1DimensionMetric> buildUnnamed3468() {
  var o = <api.GoogleCloudApigeeV1DimensionMetric>[];
  o.add(buildGoogleCloudApigeeV1DimensionMetric());
  o.add(buildGoogleCloudApigeeV1DimensionMetric());
  return o;
}

void checkUnnamed3468(core.List<api.GoogleCloudApigeeV1DimensionMetric> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1DimensionMetric(
      o[0] as api.GoogleCloudApigeeV1DimensionMetric);
  checkGoogleCloudApigeeV1DimensionMetric(
      o[1] as api.GoogleCloudApigeeV1DimensionMetric);
}

core.List<api.GoogleCloudApigeeV1Metric> buildUnnamed3469() {
  var o = <api.GoogleCloudApigeeV1Metric>[];
  o.add(buildGoogleCloudApigeeV1Metric());
  o.add(buildGoogleCloudApigeeV1Metric());
  return o;
}

void checkUnnamed3469(core.List<api.GoogleCloudApigeeV1Metric> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Metric(o[0] as api.GoogleCloudApigeeV1Metric);
  checkGoogleCloudApigeeV1Metric(o[1] as api.GoogleCloudApigeeV1Metric);
}

core.int buildCounterGoogleCloudApigeeV1StatsEnvironmentStats = 0;
api.GoogleCloudApigeeV1StatsEnvironmentStats
    buildGoogleCloudApigeeV1StatsEnvironmentStats() {
  var o = api.GoogleCloudApigeeV1StatsEnvironmentStats();
  buildCounterGoogleCloudApigeeV1StatsEnvironmentStats++;
  if (buildCounterGoogleCloudApigeeV1StatsEnvironmentStats < 3) {
    o.dimensions = buildUnnamed3468();
    o.metrics = buildUnnamed3469();
    o.name = 'foo';
  }
  buildCounterGoogleCloudApigeeV1StatsEnvironmentStats--;
  return o;
}

void checkGoogleCloudApigeeV1StatsEnvironmentStats(
    api.GoogleCloudApigeeV1StatsEnvironmentStats o) {
  buildCounterGoogleCloudApigeeV1StatsEnvironmentStats++;
  if (buildCounterGoogleCloudApigeeV1StatsEnvironmentStats < 3) {
    checkUnnamed3468(o.dimensions!);
    checkUnnamed3469(o.metrics!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1StatsEnvironmentStats--;
}

core.List<api.GoogleCloudApigeeV1DimensionMetric> buildUnnamed3470() {
  var o = <api.GoogleCloudApigeeV1DimensionMetric>[];
  o.add(buildGoogleCloudApigeeV1DimensionMetric());
  o.add(buildGoogleCloudApigeeV1DimensionMetric());
  return o;
}

void checkUnnamed3470(core.List<api.GoogleCloudApigeeV1DimensionMetric> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1DimensionMetric(
      o[0] as api.GoogleCloudApigeeV1DimensionMetric);
  checkGoogleCloudApigeeV1DimensionMetric(
      o[1] as api.GoogleCloudApigeeV1DimensionMetric);
}

core.List<api.GoogleCloudApigeeV1Metric> buildUnnamed3471() {
  var o = <api.GoogleCloudApigeeV1Metric>[];
  o.add(buildGoogleCloudApigeeV1Metric());
  o.add(buildGoogleCloudApigeeV1Metric());
  return o;
}

void checkUnnamed3471(core.List<api.GoogleCloudApigeeV1Metric> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudApigeeV1Metric(o[0] as api.GoogleCloudApigeeV1Metric);
  checkGoogleCloudApigeeV1Metric(o[1] as api.GoogleCloudApigeeV1Metric);
}

core.int buildCounterGoogleCloudApigeeV1StatsHostStats = 0;
api.GoogleCloudApigeeV1StatsHostStats buildGoogleCloudApigeeV1StatsHostStats() {
  var o = api.GoogleCloudApigeeV1StatsHostStats();
  buildCounterGoogleCloudApigeeV1StatsHostStats++;
  if (buildCounterGoogleCloudApigeeV1StatsHostStats < 3) {
    o.dimensions = buildUnnamed3470();
    o.metrics = buildUnnamed3471();
    o.name = 'foo';
  }
  buildCounterGoogleCloudApigeeV1StatsHostStats--;
  return o;
}

void checkGoogleCloudApigeeV1StatsHostStats(
    api.GoogleCloudApigeeV1StatsHostStats o) {
  buildCounterGoogleCloudApigeeV1StatsHostStats++;
  if (buildCounterGoogleCloudApigeeV1StatsHostStats < 3) {
    checkUnnamed3470(o.dimensions!);
    checkUnnamed3471(o.metrics!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1StatsHostStats--;
}

core.int buildCounterGoogleCloudApigeeV1Subscription = 0;
api.GoogleCloudApigeeV1Subscription buildGoogleCloudApigeeV1Subscription() {
  var o = api.GoogleCloudApigeeV1Subscription();
  buildCounterGoogleCloudApigeeV1Subscription++;
  if (buildCounterGoogleCloudApigeeV1Subscription < 3) {
    o.name = 'foo';
  }
  buildCounterGoogleCloudApigeeV1Subscription--;
  return o;
}

void checkGoogleCloudApigeeV1Subscription(
    api.GoogleCloudApigeeV1Subscription o) {
  buildCounterGoogleCloudApigeeV1Subscription++;
  if (buildCounterGoogleCloudApigeeV1Subscription < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1Subscription--;
}

core.List<core.String> buildUnnamed3472() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3472(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1SyncAuthorization = 0;
api.GoogleCloudApigeeV1SyncAuthorization
    buildGoogleCloudApigeeV1SyncAuthorization() {
  var o = api.GoogleCloudApigeeV1SyncAuthorization();
  buildCounterGoogleCloudApigeeV1SyncAuthorization++;
  if (buildCounterGoogleCloudApigeeV1SyncAuthorization < 3) {
    o.etag = 'foo';
    o.identities = buildUnnamed3472();
  }
  buildCounterGoogleCloudApigeeV1SyncAuthorization--;
  return o;
}

void checkGoogleCloudApigeeV1SyncAuthorization(
    api.GoogleCloudApigeeV1SyncAuthorization o) {
  buildCounterGoogleCloudApigeeV1SyncAuthorization++;
  if (buildCounterGoogleCloudApigeeV1SyncAuthorization < 3) {
    unittest.expect(
      o.etag!,
      unittest.equals('foo'),
    );
    checkUnnamed3472(o.identities!);
  }
  buildCounterGoogleCloudApigeeV1SyncAuthorization--;
}

core.int buildCounterGoogleCloudApigeeV1TargetServer = 0;
api.GoogleCloudApigeeV1TargetServer buildGoogleCloudApigeeV1TargetServer() {
  var o = api.GoogleCloudApigeeV1TargetServer();
  buildCounterGoogleCloudApigeeV1TargetServer++;
  if (buildCounterGoogleCloudApigeeV1TargetServer < 3) {
    o.description = 'foo';
    o.host = 'foo';
    o.isEnabled = true;
    o.name = 'foo';
    o.port = 42;
    o.sSLInfo = buildGoogleCloudApigeeV1TlsInfo();
  }
  buildCounterGoogleCloudApigeeV1TargetServer--;
  return o;
}

void checkGoogleCloudApigeeV1TargetServer(
    api.GoogleCloudApigeeV1TargetServer o) {
  buildCounterGoogleCloudApigeeV1TargetServer++;
  if (buildCounterGoogleCloudApigeeV1TargetServer < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.host!,
      unittest.equals('foo'),
    );
    unittest.expect(o.isEnabled!, unittest.isTrue);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.port!,
      unittest.equals(42),
    );
    checkGoogleCloudApigeeV1TlsInfo(
        o.sSLInfo! as api.GoogleCloudApigeeV1TlsInfo);
  }
  buildCounterGoogleCloudApigeeV1TargetServer--;
}

core.int buildCounterGoogleCloudApigeeV1TargetServerConfig = 0;
api.GoogleCloudApigeeV1TargetServerConfig
    buildGoogleCloudApigeeV1TargetServerConfig() {
  var o = api.GoogleCloudApigeeV1TargetServerConfig();
  buildCounterGoogleCloudApigeeV1TargetServerConfig++;
  if (buildCounterGoogleCloudApigeeV1TargetServerConfig < 3) {
    o.host = 'foo';
    o.name = 'foo';
    o.port = 42;
    o.tlsInfo = buildGoogleCloudApigeeV1TlsInfoConfig();
  }
  buildCounterGoogleCloudApigeeV1TargetServerConfig--;
  return o;
}

void checkGoogleCloudApigeeV1TargetServerConfig(
    api.GoogleCloudApigeeV1TargetServerConfig o) {
  buildCounterGoogleCloudApigeeV1TargetServerConfig++;
  if (buildCounterGoogleCloudApigeeV1TargetServerConfig < 3) {
    unittest.expect(
      o.host!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.port!,
      unittest.equals(42),
    );
    checkGoogleCloudApigeeV1TlsInfoConfig(
        o.tlsInfo! as api.GoogleCloudApigeeV1TlsInfoConfig);
  }
  buildCounterGoogleCloudApigeeV1TargetServerConfig--;
}

core.int buildCounterGoogleCloudApigeeV1TestDatastoreResponse = 0;
api.GoogleCloudApigeeV1TestDatastoreResponse
    buildGoogleCloudApigeeV1TestDatastoreResponse() {
  var o = api.GoogleCloudApigeeV1TestDatastoreResponse();
  buildCounterGoogleCloudApigeeV1TestDatastoreResponse++;
  if (buildCounterGoogleCloudApigeeV1TestDatastoreResponse < 3) {
    o.error = 'foo';
    o.state = 'foo';
  }
  buildCounterGoogleCloudApigeeV1TestDatastoreResponse--;
  return o;
}

void checkGoogleCloudApigeeV1TestDatastoreResponse(
    api.GoogleCloudApigeeV1TestDatastoreResponse o) {
  buildCounterGoogleCloudApigeeV1TestDatastoreResponse++;
  if (buildCounterGoogleCloudApigeeV1TestDatastoreResponse < 3) {
    unittest.expect(
      o.error!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1TestDatastoreResponse--;
}

core.List<core.String> buildUnnamed3473() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3473(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed3474() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3474(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1TlsInfo = 0;
api.GoogleCloudApigeeV1TlsInfo buildGoogleCloudApigeeV1TlsInfo() {
  var o = api.GoogleCloudApigeeV1TlsInfo();
  buildCounterGoogleCloudApigeeV1TlsInfo++;
  if (buildCounterGoogleCloudApigeeV1TlsInfo < 3) {
    o.ciphers = buildUnnamed3473();
    o.clientAuthEnabled = true;
    o.commonName = buildGoogleCloudApigeeV1TlsInfoCommonName();
    o.enabled = true;
    o.ignoreValidationErrors = true;
    o.keyAlias = 'foo';
    o.keyStore = 'foo';
    o.protocols = buildUnnamed3474();
    o.trustStore = 'foo';
  }
  buildCounterGoogleCloudApigeeV1TlsInfo--;
  return o;
}

void checkGoogleCloudApigeeV1TlsInfo(api.GoogleCloudApigeeV1TlsInfo o) {
  buildCounterGoogleCloudApigeeV1TlsInfo++;
  if (buildCounterGoogleCloudApigeeV1TlsInfo < 3) {
    checkUnnamed3473(o.ciphers!);
    unittest.expect(o.clientAuthEnabled!, unittest.isTrue);
    checkGoogleCloudApigeeV1TlsInfoCommonName(
        o.commonName! as api.GoogleCloudApigeeV1TlsInfoCommonName);
    unittest.expect(o.enabled!, unittest.isTrue);
    unittest.expect(o.ignoreValidationErrors!, unittest.isTrue);
    unittest.expect(
      o.keyAlias!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.keyStore!,
      unittest.equals('foo'),
    );
    checkUnnamed3474(o.protocols!);
    unittest.expect(
      o.trustStore!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1TlsInfo--;
}

core.int buildCounterGoogleCloudApigeeV1TlsInfoCommonName = 0;
api.GoogleCloudApigeeV1TlsInfoCommonName
    buildGoogleCloudApigeeV1TlsInfoCommonName() {
  var o = api.GoogleCloudApigeeV1TlsInfoCommonName();
  buildCounterGoogleCloudApigeeV1TlsInfoCommonName++;
  if (buildCounterGoogleCloudApigeeV1TlsInfoCommonName < 3) {
    o.value = 'foo';
    o.wildcardMatch = true;
  }
  buildCounterGoogleCloudApigeeV1TlsInfoCommonName--;
  return o;
}

void checkGoogleCloudApigeeV1TlsInfoCommonName(
    api.GoogleCloudApigeeV1TlsInfoCommonName o) {
  buildCounterGoogleCloudApigeeV1TlsInfoCommonName++;
  if (buildCounterGoogleCloudApigeeV1TlsInfoCommonName < 3) {
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
    unittest.expect(o.wildcardMatch!, unittest.isTrue);
  }
  buildCounterGoogleCloudApigeeV1TlsInfoCommonName--;
}

core.List<core.String> buildUnnamed3475() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3475(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed3476() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3476(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudApigeeV1TlsInfoConfig = 0;
api.GoogleCloudApigeeV1TlsInfoConfig buildGoogleCloudApigeeV1TlsInfoConfig() {
  var o = api.GoogleCloudApigeeV1TlsInfoConfig();
  buildCounterGoogleCloudApigeeV1TlsInfoConfig++;
  if (buildCounterGoogleCloudApigeeV1TlsInfoConfig < 3) {
    o.ciphers = buildUnnamed3475();
    o.clientAuthEnabled = true;
    o.commonName = buildGoogleCloudApigeeV1CommonNameConfig();
    o.enabled = true;
    o.ignoreValidationErrors = true;
    o.keyAlias = 'foo';
    o.keyAliasReference = buildGoogleCloudApigeeV1KeyAliasReference();
    o.protocols = buildUnnamed3476();
    o.trustStore = 'foo';
  }
  buildCounterGoogleCloudApigeeV1TlsInfoConfig--;
  return o;
}

void checkGoogleCloudApigeeV1TlsInfoConfig(
    api.GoogleCloudApigeeV1TlsInfoConfig o) {
  buildCounterGoogleCloudApigeeV1TlsInfoConfig++;
  if (buildCounterGoogleCloudApigeeV1TlsInfoConfig < 3) {
    checkUnnamed3475(o.ciphers!);
    unittest.expect(o.clientAuthEnabled!, unittest.isTrue);
    checkGoogleCloudApigeeV1CommonNameConfig(
        o.commonName! as api.GoogleCloudApigeeV1CommonNameConfig);
    unittest.expect(o.enabled!, unittest.isTrue);
    unittest.expect(o.ignoreValidationErrors!, unittest.isTrue);
    unittest.expect(
      o.keyAlias!,
      unittest.equals('foo'),
    );
    checkGoogleCloudApigeeV1KeyAliasReference(
        o.keyAliasReference! as api.GoogleCloudApigeeV1KeyAliasReference);
    checkUnnamed3476(o.protocols!);
    unittest.expect(
      o.trustStore!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1TlsInfoConfig--;
}

core.int buildCounterGoogleCloudApigeeV1UpdateError = 0;
api.GoogleCloudApigeeV1UpdateError buildGoogleCloudApigeeV1UpdateError() {
  var o = api.GoogleCloudApigeeV1UpdateError();
  buildCounterGoogleCloudApigeeV1UpdateError++;
  if (buildCounterGoogleCloudApigeeV1UpdateError < 3) {
    o.code = 'foo';
    o.message = 'foo';
    o.resource = 'foo';
    o.type = 'foo';
  }
  buildCounterGoogleCloudApigeeV1UpdateError--;
  return o;
}

void checkGoogleCloudApigeeV1UpdateError(api.GoogleCloudApigeeV1UpdateError o) {
  buildCounterGoogleCloudApigeeV1UpdateError++;
  if (buildCounterGoogleCloudApigeeV1UpdateError < 3) {
    unittest.expect(
      o.code!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.message!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.resource!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudApigeeV1UpdateError--;
}

core.List<api.GoogleIamV1AuditLogConfig> buildUnnamed3477() {
  var o = <api.GoogleIamV1AuditLogConfig>[];
  o.add(buildGoogleIamV1AuditLogConfig());
  o.add(buildGoogleIamV1AuditLogConfig());
  return o;
}

void checkUnnamed3477(core.List<api.GoogleIamV1AuditLogConfig> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleIamV1AuditLogConfig(o[0] as api.GoogleIamV1AuditLogConfig);
  checkGoogleIamV1AuditLogConfig(o[1] as api.GoogleIamV1AuditLogConfig);
}

core.int buildCounterGoogleIamV1AuditConfig = 0;
api.GoogleIamV1AuditConfig buildGoogleIamV1AuditConfig() {
  var o = api.GoogleIamV1AuditConfig();
  buildCounterGoogleIamV1AuditConfig++;
  if (buildCounterGoogleIamV1AuditConfig < 3) {
    o.auditLogConfigs = buildUnnamed3477();
    o.service = 'foo';
  }
  buildCounterGoogleIamV1AuditConfig--;
  return o;
}

void checkGoogleIamV1AuditConfig(api.GoogleIamV1AuditConfig o) {
  buildCounterGoogleIamV1AuditConfig++;
  if (buildCounterGoogleIamV1AuditConfig < 3) {
    checkUnnamed3477(o.auditLogConfigs!);
    unittest.expect(
      o.service!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleIamV1AuditConfig--;
}

core.List<core.String> buildUnnamed3478() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3478(core.List<core.String> o) {
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

core.int buildCounterGoogleIamV1AuditLogConfig = 0;
api.GoogleIamV1AuditLogConfig buildGoogleIamV1AuditLogConfig() {
  var o = api.GoogleIamV1AuditLogConfig();
  buildCounterGoogleIamV1AuditLogConfig++;
  if (buildCounterGoogleIamV1AuditLogConfig < 3) {
    o.exemptedMembers = buildUnnamed3478();
    o.logType = 'foo';
  }
  buildCounterGoogleIamV1AuditLogConfig--;
  return o;
}

void checkGoogleIamV1AuditLogConfig(api.GoogleIamV1AuditLogConfig o) {
  buildCounterGoogleIamV1AuditLogConfig++;
  if (buildCounterGoogleIamV1AuditLogConfig < 3) {
    checkUnnamed3478(o.exemptedMembers!);
    unittest.expect(
      o.logType!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleIamV1AuditLogConfig--;
}

core.List<core.String> buildUnnamed3479() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3479(core.List<core.String> o) {
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

core.int buildCounterGoogleIamV1Binding = 0;
api.GoogleIamV1Binding buildGoogleIamV1Binding() {
  var o = api.GoogleIamV1Binding();
  buildCounterGoogleIamV1Binding++;
  if (buildCounterGoogleIamV1Binding < 3) {
    o.condition = buildGoogleTypeExpr();
    o.members = buildUnnamed3479();
    o.role = 'foo';
  }
  buildCounterGoogleIamV1Binding--;
  return o;
}

void checkGoogleIamV1Binding(api.GoogleIamV1Binding o) {
  buildCounterGoogleIamV1Binding++;
  if (buildCounterGoogleIamV1Binding < 3) {
    checkGoogleTypeExpr(o.condition! as api.GoogleTypeExpr);
    checkUnnamed3479(o.members!);
    unittest.expect(
      o.role!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleIamV1Binding--;
}

core.List<api.GoogleIamV1AuditConfig> buildUnnamed3480() {
  var o = <api.GoogleIamV1AuditConfig>[];
  o.add(buildGoogleIamV1AuditConfig());
  o.add(buildGoogleIamV1AuditConfig());
  return o;
}

void checkUnnamed3480(core.List<api.GoogleIamV1AuditConfig> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleIamV1AuditConfig(o[0] as api.GoogleIamV1AuditConfig);
  checkGoogleIamV1AuditConfig(o[1] as api.GoogleIamV1AuditConfig);
}

core.List<api.GoogleIamV1Binding> buildUnnamed3481() {
  var o = <api.GoogleIamV1Binding>[];
  o.add(buildGoogleIamV1Binding());
  o.add(buildGoogleIamV1Binding());
  return o;
}

void checkUnnamed3481(core.List<api.GoogleIamV1Binding> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleIamV1Binding(o[0] as api.GoogleIamV1Binding);
  checkGoogleIamV1Binding(o[1] as api.GoogleIamV1Binding);
}

core.int buildCounterGoogleIamV1Policy = 0;
api.GoogleIamV1Policy buildGoogleIamV1Policy() {
  var o = api.GoogleIamV1Policy();
  buildCounterGoogleIamV1Policy++;
  if (buildCounterGoogleIamV1Policy < 3) {
    o.auditConfigs = buildUnnamed3480();
    o.bindings = buildUnnamed3481();
    o.etag = 'foo';
    o.version = 42;
  }
  buildCounterGoogleIamV1Policy--;
  return o;
}

void checkGoogleIamV1Policy(api.GoogleIamV1Policy o) {
  buildCounterGoogleIamV1Policy++;
  if (buildCounterGoogleIamV1Policy < 3) {
    checkUnnamed3480(o.auditConfigs!);
    checkUnnamed3481(o.bindings!);
    unittest.expect(
      o.etag!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.version!,
      unittest.equals(42),
    );
  }
  buildCounterGoogleIamV1Policy--;
}

core.int buildCounterGoogleIamV1SetIamPolicyRequest = 0;
api.GoogleIamV1SetIamPolicyRequest buildGoogleIamV1SetIamPolicyRequest() {
  var o = api.GoogleIamV1SetIamPolicyRequest();
  buildCounterGoogleIamV1SetIamPolicyRequest++;
  if (buildCounterGoogleIamV1SetIamPolicyRequest < 3) {
    o.policy = buildGoogleIamV1Policy();
    o.updateMask = 'foo';
  }
  buildCounterGoogleIamV1SetIamPolicyRequest--;
  return o;
}

void checkGoogleIamV1SetIamPolicyRequest(api.GoogleIamV1SetIamPolicyRequest o) {
  buildCounterGoogleIamV1SetIamPolicyRequest++;
  if (buildCounterGoogleIamV1SetIamPolicyRequest < 3) {
    checkGoogleIamV1Policy(o.policy! as api.GoogleIamV1Policy);
    unittest.expect(
      o.updateMask!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleIamV1SetIamPolicyRequest--;
}

core.List<core.String> buildUnnamed3482() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3482(core.List<core.String> o) {
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

core.int buildCounterGoogleIamV1TestIamPermissionsRequest = 0;
api.GoogleIamV1TestIamPermissionsRequest
    buildGoogleIamV1TestIamPermissionsRequest() {
  var o = api.GoogleIamV1TestIamPermissionsRequest();
  buildCounterGoogleIamV1TestIamPermissionsRequest++;
  if (buildCounterGoogleIamV1TestIamPermissionsRequest < 3) {
    o.permissions = buildUnnamed3482();
  }
  buildCounterGoogleIamV1TestIamPermissionsRequest--;
  return o;
}

void checkGoogleIamV1TestIamPermissionsRequest(
    api.GoogleIamV1TestIamPermissionsRequest o) {
  buildCounterGoogleIamV1TestIamPermissionsRequest++;
  if (buildCounterGoogleIamV1TestIamPermissionsRequest < 3) {
    checkUnnamed3482(o.permissions!);
  }
  buildCounterGoogleIamV1TestIamPermissionsRequest--;
}

core.List<core.String> buildUnnamed3483() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed3483(core.List<core.String> o) {
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

core.int buildCounterGoogleIamV1TestIamPermissionsResponse = 0;
api.GoogleIamV1TestIamPermissionsResponse
    buildGoogleIamV1TestIamPermissionsResponse() {
  var o = api.GoogleIamV1TestIamPermissionsResponse();
  buildCounterGoogleIamV1TestIamPermissionsResponse++;
  if (buildCounterGoogleIamV1TestIamPermissionsResponse < 3) {
    o.permissions = buildUnnamed3483();
  }
  buildCounterGoogleIamV1TestIamPermissionsResponse--;
  return o;
}

void checkGoogleIamV1TestIamPermissionsResponse(
    api.GoogleIamV1TestIamPermissionsResponse o) {
  buildCounterGoogleIamV1TestIamPermissionsResponse++;
  if (buildCounterGoogleIamV1TestIamPermissionsResponse < 3) {
    checkUnnamed3483(o.permissions!);
  }
  buildCounterGoogleIamV1TestIamPermissionsResponse--;
}

core.List<api.GoogleLongrunningOperation> buildUnnamed3484() {
  var o = <api.GoogleLongrunningOperation>[];
  o.add(buildGoogleLongrunningOperation());
  o.add(buildGoogleLongrunningOperation());
  return o;
}

void checkUnnamed3484(core.List<api.GoogleLongrunningOperation> o) {
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
    o.operations = buildUnnamed3484();
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
    checkUnnamed3484(o.operations!);
  }
  buildCounterGoogleLongrunningListOperationsResponse--;
}

core.Map<core.String, core.Object> buildUnnamed3485() {
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

void checkUnnamed3485(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted12 = (o['x']!) as core.Map;
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
  var casted13 = (o['y']!) as core.Map;
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
}

core.Map<core.String, core.Object> buildUnnamed3486() {
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

void checkUnnamed3486(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted14 = (o['x']!) as core.Map;
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
  var casted15 = (o['y']!) as core.Map;
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
}

core.int buildCounterGoogleLongrunningOperation = 0;
api.GoogleLongrunningOperation buildGoogleLongrunningOperation() {
  var o = api.GoogleLongrunningOperation();
  buildCounterGoogleLongrunningOperation++;
  if (buildCounterGoogleLongrunningOperation < 3) {
    o.done = true;
    o.error = buildGoogleRpcStatus();
    o.metadata = buildUnnamed3485();
    o.name = 'foo';
    o.response = buildUnnamed3486();
  }
  buildCounterGoogleLongrunningOperation--;
  return o;
}

void checkGoogleLongrunningOperation(api.GoogleLongrunningOperation o) {
  buildCounterGoogleLongrunningOperation++;
  if (buildCounterGoogleLongrunningOperation < 3) {
    unittest.expect(o.done!, unittest.isTrue);
    checkGoogleRpcStatus(o.error! as api.GoogleRpcStatus);
    checkUnnamed3485(o.metadata!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed3486(o.response!);
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

core.List<api.GoogleRpcPreconditionFailureViolation> buildUnnamed3487() {
  var o = <api.GoogleRpcPreconditionFailureViolation>[];
  o.add(buildGoogleRpcPreconditionFailureViolation());
  o.add(buildGoogleRpcPreconditionFailureViolation());
  return o;
}

void checkUnnamed3487(core.List<api.GoogleRpcPreconditionFailureViolation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleRpcPreconditionFailureViolation(
      o[0] as api.GoogleRpcPreconditionFailureViolation);
  checkGoogleRpcPreconditionFailureViolation(
      o[1] as api.GoogleRpcPreconditionFailureViolation);
}

core.int buildCounterGoogleRpcPreconditionFailure = 0;
api.GoogleRpcPreconditionFailure buildGoogleRpcPreconditionFailure() {
  var o = api.GoogleRpcPreconditionFailure();
  buildCounterGoogleRpcPreconditionFailure++;
  if (buildCounterGoogleRpcPreconditionFailure < 3) {
    o.violations = buildUnnamed3487();
  }
  buildCounterGoogleRpcPreconditionFailure--;
  return o;
}

void checkGoogleRpcPreconditionFailure(api.GoogleRpcPreconditionFailure o) {
  buildCounterGoogleRpcPreconditionFailure++;
  if (buildCounterGoogleRpcPreconditionFailure < 3) {
    checkUnnamed3487(o.violations!);
  }
  buildCounterGoogleRpcPreconditionFailure--;
}

core.int buildCounterGoogleRpcPreconditionFailureViolation = 0;
api.GoogleRpcPreconditionFailureViolation
    buildGoogleRpcPreconditionFailureViolation() {
  var o = api.GoogleRpcPreconditionFailureViolation();
  buildCounterGoogleRpcPreconditionFailureViolation++;
  if (buildCounterGoogleRpcPreconditionFailureViolation < 3) {
    o.description = 'foo';
    o.subject = 'foo';
    o.type = 'foo';
  }
  buildCounterGoogleRpcPreconditionFailureViolation--;
  return o;
}

void checkGoogleRpcPreconditionFailureViolation(
    api.GoogleRpcPreconditionFailureViolation o) {
  buildCounterGoogleRpcPreconditionFailureViolation++;
  if (buildCounterGoogleRpcPreconditionFailureViolation < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.subject!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleRpcPreconditionFailureViolation--;
}

core.Map<core.String, core.Object> buildUnnamed3488() {
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

void checkUnnamed3488(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted16 = (o['x']!) as core.Map;
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
  var casted17 = (o['y']!) as core.Map;
  unittest.expect(casted17, unittest.hasLength(3));
  unittest.expect(
    casted17['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted17['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted17['string'],
    unittest.equals('foo'),
  );
}

core.List<core.Map<core.String, core.Object>> buildUnnamed3489() {
  var o = <core.Map<core.String, core.Object>>[];
  o.add(buildUnnamed3488());
  o.add(buildUnnamed3488());
  return o;
}

void checkUnnamed3489(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed3488(o[0]);
  checkUnnamed3488(o[1]);
}

core.int buildCounterGoogleRpcStatus = 0;
api.GoogleRpcStatus buildGoogleRpcStatus() {
  var o = api.GoogleRpcStatus();
  buildCounterGoogleRpcStatus++;
  if (buildCounterGoogleRpcStatus < 3) {
    o.code = 42;
    o.details = buildUnnamed3489();
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
    checkUnnamed3489(o.details!);
    unittest.expect(
      o.message!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleRpcStatus--;
}

core.int buildCounterGoogleTypeExpr = 0;
api.GoogleTypeExpr buildGoogleTypeExpr() {
  var o = api.GoogleTypeExpr();
  buildCounterGoogleTypeExpr++;
  if (buildCounterGoogleTypeExpr < 3) {
    o.description = 'foo';
    o.expression = 'foo';
    o.location = 'foo';
    o.title = 'foo';
  }
  buildCounterGoogleTypeExpr--;
  return o;
}

void checkGoogleTypeExpr(api.GoogleTypeExpr o) {
  buildCounterGoogleTypeExpr++;
  if (buildCounterGoogleTypeExpr < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.expression!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.location!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleTypeExpr--;
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

  unittest.group('obj-schema-GoogleCloudApigeeV1Access', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Access();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Access.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Access(od as api.GoogleCloudApigeeV1Access);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1AccessGet', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1AccessGet();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1AccessGet.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1AccessGet(od as api.GoogleCloudApigeeV1AccessGet);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1AccessRemove', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1AccessRemove();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1AccessRemove.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1AccessRemove(
          od as api.GoogleCloudApigeeV1AccessRemove);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1AccessSet', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1AccessSet();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1AccessSet.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1AccessSet(od as api.GoogleCloudApigeeV1AccessSet);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ActivateNatAddressRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ActivateNatAddressRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ActivateNatAddressRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ActivateNatAddressRequest(
          od as api.GoogleCloudApigeeV1ActivateNatAddressRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Alias', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Alias();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Alias.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Alias(od as api.GoogleCloudApigeeV1Alias);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1AliasRevisionConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1AliasRevisionConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1AliasRevisionConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1AliasRevisionConfig(
          od as api.GoogleCloudApigeeV1AliasRevisionConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ApiCategory', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ApiCategory();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ApiCategory.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ApiCategory(
          od as api.GoogleCloudApigeeV1ApiCategory);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ApiCategoryData', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ApiCategoryData();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ApiCategoryData.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ApiCategoryData(
          od as api.GoogleCloudApigeeV1ApiCategoryData);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ApiProduct', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ApiProduct();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ApiProduct.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ApiProduct(
          od as api.GoogleCloudApigeeV1ApiProduct);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ApiProductRef', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ApiProductRef();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ApiProductRef.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ApiProductRef(
          od as api.GoogleCloudApigeeV1ApiProductRef);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ApiProxy', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ApiProxy();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ApiProxy.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ApiProxy(od as api.GoogleCloudApigeeV1ApiProxy);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ApiProxyRevision', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ApiProxyRevision();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ApiProxyRevision.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ApiProxyRevision(
          od as api.GoogleCloudApigeeV1ApiProxyRevision);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ApiResponseWrapper', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ApiResponseWrapper();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ApiResponseWrapper.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ApiResponseWrapper(
          od as api.GoogleCloudApigeeV1ApiResponseWrapper);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1App', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1App();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1App.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1App(od as api.GoogleCloudApigeeV1App);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1AsyncQuery', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1AsyncQuery();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1AsyncQuery.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1AsyncQuery(
          od as api.GoogleCloudApigeeV1AsyncQuery);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1AsyncQueryResult', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1AsyncQueryResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1AsyncQueryResult.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1AsyncQueryResult(
          od as api.GoogleCloudApigeeV1AsyncQueryResult);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1AsyncQueryResultView', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1AsyncQueryResultView();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1AsyncQueryResultView.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1AsyncQueryResultView(
          od as api.GoogleCloudApigeeV1AsyncQueryResultView);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Attribute', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Attribute();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Attribute.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Attribute(od as api.GoogleCloudApigeeV1Attribute);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Attributes', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Attributes();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Attributes.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Attributes(
          od as api.GoogleCloudApigeeV1Attributes);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1CanaryEvaluation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1CanaryEvaluation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1CanaryEvaluation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1CanaryEvaluation(
          od as api.GoogleCloudApigeeV1CanaryEvaluation);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1CanaryEvaluationMetricLabels',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1CanaryEvaluationMetricLabels();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1CanaryEvaluationMetricLabels.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1CanaryEvaluationMetricLabels(
          od as api.GoogleCloudApigeeV1CanaryEvaluationMetricLabels);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1CertInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1CertInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1CertInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1CertInfo(od as api.GoogleCloudApigeeV1CertInfo);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Certificate', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Certificate();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Certificate.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Certificate(
          od as api.GoogleCloudApigeeV1Certificate);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1CommonNameConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1CommonNameConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1CommonNameConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1CommonNameConfig(
          od as api.GoogleCloudApigeeV1CommonNameConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ConfigVersion', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ConfigVersion();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ConfigVersion.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ConfigVersion(
          od as api.GoogleCloudApigeeV1ConfigVersion);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Credential', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Credential();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Credential.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Credential(
          od as api.GoogleCloudApigeeV1Credential);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1CustomReport', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1CustomReport();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1CustomReport.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1CustomReport(
          od as api.GoogleCloudApigeeV1CustomReport);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1CustomReportMetric', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1CustomReportMetric();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1CustomReportMetric.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1CustomReportMetric(
          od as api.GoogleCloudApigeeV1CustomReportMetric);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1DataCollector', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1DataCollector();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1DataCollector.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1DataCollector(
          od as api.GoogleCloudApigeeV1DataCollector);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1DataCollectorConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1DataCollectorConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1DataCollectorConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1DataCollectorConfig(
          od as api.GoogleCloudApigeeV1DataCollectorConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Datastore', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Datastore();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Datastore.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Datastore(od as api.GoogleCloudApigeeV1Datastore);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1DatastoreConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1DatastoreConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1DatastoreConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1DatastoreConfig(
          od as api.GoogleCloudApigeeV1DatastoreConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1DateRange', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1DateRange();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1DateRange.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1DateRange(od as api.GoogleCloudApigeeV1DateRange);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1DebugMask', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1DebugMask();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1DebugMask.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1DebugMask(od as api.GoogleCloudApigeeV1DebugMask);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1DebugSession', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1DebugSession();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1DebugSession.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1DebugSession(
          od as api.GoogleCloudApigeeV1DebugSession);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1DebugSessionTransaction', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1DebugSessionTransaction();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1DebugSessionTransaction.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1DebugSessionTransaction(
          od as api.GoogleCloudApigeeV1DebugSessionTransaction);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1DeleteCustomReportResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1DeleteCustomReportResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1DeleteCustomReportResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1DeleteCustomReportResponse(
          od as api.GoogleCloudApigeeV1DeleteCustomReportResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Deployment', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Deployment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Deployment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Deployment(
          od as api.GoogleCloudApigeeV1Deployment);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1DeploymentChangeReport', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1DeploymentChangeReport();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1DeploymentChangeReport.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1DeploymentChangeReport(
          od as api.GoogleCloudApigeeV1DeploymentChangeReport);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudApigeeV1DeploymentChangeReportRoutingChange', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1DeploymentChangeReportRoutingChange();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudApigeeV1DeploymentChangeReportRoutingChange.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1DeploymentChangeReportRoutingChange(
          od as api.GoogleCloudApigeeV1DeploymentChangeReportRoutingChange);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudApigeeV1DeploymentChangeReportRoutingConflict',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1DeploymentChangeReportRoutingConflict();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudApigeeV1DeploymentChangeReportRoutingConflict.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1DeploymentChangeReportRoutingConflict(
          od as api.GoogleCloudApigeeV1DeploymentChangeReportRoutingConflict);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment(
          od as api.GoogleCloudApigeeV1DeploymentChangeReportRoutingDeployment);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1DeploymentConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1DeploymentConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1DeploymentConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1DeploymentConfig(
          od as api.GoogleCloudApigeeV1DeploymentConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Developer', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Developer();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Developer.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Developer(od as api.GoogleCloudApigeeV1Developer);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1DeveloperApp', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1DeveloperApp();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1DeveloperApp.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1DeveloperApp(
          od as api.GoogleCloudApigeeV1DeveloperApp);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1DeveloperAppKey', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1DeveloperAppKey();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1DeveloperAppKey.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1DeveloperAppKey(
          od as api.GoogleCloudApigeeV1DeveloperAppKey);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1DimensionMetric', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1DimensionMetric();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1DimensionMetric.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1DimensionMetric(
          od as api.GoogleCloudApigeeV1DimensionMetric);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1EntityMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1EntityMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1EntityMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1EntityMetadata(
          od as api.GoogleCloudApigeeV1EntityMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Environment', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Environment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Environment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Environment(
          od as api.GoogleCloudApigeeV1Environment);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1EnvironmentConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1EnvironmentConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1EnvironmentConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1EnvironmentConfig(
          od as api.GoogleCloudApigeeV1EnvironmentConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1EnvironmentGroup', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1EnvironmentGroup();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1EnvironmentGroup.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1EnvironmentGroup(
          od as api.GoogleCloudApigeeV1EnvironmentGroup);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1EnvironmentGroupAttachment',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1EnvironmentGroupAttachment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1EnvironmentGroupAttachment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1EnvironmentGroupAttachment(
          od as api.GoogleCloudApigeeV1EnvironmentGroupAttachment);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1EnvironmentGroupConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1EnvironmentGroupConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1EnvironmentGroupConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1EnvironmentGroupConfig(
          od as api.GoogleCloudApigeeV1EnvironmentGroupConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Export', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Export();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Export.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Export(od as api.GoogleCloudApigeeV1Export);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ExportRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ExportRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ExportRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ExportRequest(
          od as api.GoogleCloudApigeeV1ExportRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1FlowHook', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1FlowHook();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1FlowHook.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1FlowHook(od as api.GoogleCloudApigeeV1FlowHook);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1FlowHookConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1FlowHookConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1FlowHookConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1FlowHookConfig(
          od as api.GoogleCloudApigeeV1FlowHookConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1GetSyncAuthorizationRequest',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1GetSyncAuthorizationRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1GetSyncAuthorizationRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1GetSyncAuthorizationRequest(
          od as api.GoogleCloudApigeeV1GetSyncAuthorizationRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1IngressConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1IngressConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1IngressConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1IngressConfig(
          od as api.GoogleCloudApigeeV1IngressConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Instance', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Instance();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Instance.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Instance(od as api.GoogleCloudApigeeV1Instance);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1InstanceAttachment', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1InstanceAttachment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1InstanceAttachment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1InstanceAttachment(
          od as api.GoogleCloudApigeeV1InstanceAttachment);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1InstanceDeploymentStatus', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1InstanceDeploymentStatus();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1InstanceDeploymentStatus.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1InstanceDeploymentStatus(
          od as api.GoogleCloudApigeeV1InstanceDeploymentStatus);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision(od
          as api.GoogleCloudApigeeV1InstanceDeploymentStatusDeployedRevision);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute(
          od as api.GoogleCloudApigeeV1InstanceDeploymentStatusDeployedRoute);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1KeyAliasReference', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1KeyAliasReference();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1KeyAliasReference.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1KeyAliasReference(
          od as api.GoogleCloudApigeeV1KeyAliasReference);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1KeyValueMap', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1KeyValueMap();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1KeyValueMap.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1KeyValueMap(
          od as api.GoogleCloudApigeeV1KeyValueMap);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Keystore', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Keystore();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Keystore.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Keystore(od as api.GoogleCloudApigeeV1Keystore);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1KeystoreConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1KeystoreConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1KeystoreConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1KeystoreConfig(
          od as api.GoogleCloudApigeeV1KeystoreConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ListApiCategoriesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ListApiCategoriesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ListApiCategoriesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ListApiCategoriesResponse(
          od as api.GoogleCloudApigeeV1ListApiCategoriesResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ListApiProductsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ListApiProductsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ListApiProductsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ListApiProductsResponse(
          od as api.GoogleCloudApigeeV1ListApiProductsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ListApiProxiesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ListApiProxiesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ListApiProxiesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ListApiProxiesResponse(
          od as api.GoogleCloudApigeeV1ListApiProxiesResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ListAppsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ListAppsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ListAppsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ListAppsResponse(
          od as api.GoogleCloudApigeeV1ListAppsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ListAsyncQueriesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ListAsyncQueriesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ListAsyncQueriesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ListAsyncQueriesResponse(
          od as api.GoogleCloudApigeeV1ListAsyncQueriesResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ListCustomReportsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ListCustomReportsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ListCustomReportsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ListCustomReportsResponse(
          od as api.GoogleCloudApigeeV1ListCustomReportsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ListDataCollectorsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ListDataCollectorsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ListDataCollectorsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ListDataCollectorsResponse(
          od as api.GoogleCloudApigeeV1ListDataCollectorsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ListDatastoresResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ListDatastoresResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ListDatastoresResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ListDatastoresResponse(
          od as api.GoogleCloudApigeeV1ListDatastoresResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ListDebugSessionsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ListDebugSessionsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ListDebugSessionsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ListDebugSessionsResponse(
          od as api.GoogleCloudApigeeV1ListDebugSessionsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ListDeploymentsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ListDeploymentsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ListDeploymentsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ListDeploymentsResponse(
          od as api.GoogleCloudApigeeV1ListDeploymentsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ListDeveloperAppsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ListDeveloperAppsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ListDeveloperAppsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ListDeveloperAppsResponse(
          od as api.GoogleCloudApigeeV1ListDeveloperAppsResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudApigeeV1ListEnvironmentGroupAttachmentsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ListEnvironmentGroupAttachmentsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ListEnvironmentGroupAttachmentsResponse
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ListEnvironmentGroupAttachmentsResponse(
          od as api.GoogleCloudApigeeV1ListEnvironmentGroupAttachmentsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ListEnvironmentGroupsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ListEnvironmentGroupsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ListEnvironmentGroupsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ListEnvironmentGroupsResponse(
          od as api.GoogleCloudApigeeV1ListEnvironmentGroupsResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudApigeeV1ListEnvironmentResourcesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ListEnvironmentResourcesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ListEnvironmentResourcesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ListEnvironmentResourcesResponse(
          od as api.GoogleCloudApigeeV1ListEnvironmentResourcesResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ListExportsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ListExportsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ListExportsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ListExportsResponse(
          od as api.GoogleCloudApigeeV1ListExportsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ListHybridIssuersResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ListHybridIssuersResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ListHybridIssuersResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ListHybridIssuersResponse(
          od as api.GoogleCloudApigeeV1ListHybridIssuersResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudApigeeV1ListInstanceAttachmentsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ListInstanceAttachmentsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ListInstanceAttachmentsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ListInstanceAttachmentsResponse(
          od as api.GoogleCloudApigeeV1ListInstanceAttachmentsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ListInstancesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ListInstancesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ListInstancesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ListInstancesResponse(
          od as api.GoogleCloudApigeeV1ListInstancesResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ListNatAddressesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ListNatAddressesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ListNatAddressesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ListNatAddressesResponse(
          od as api.GoogleCloudApigeeV1ListNatAddressesResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ListOfDevelopersResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ListOfDevelopersResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ListOfDevelopersResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ListOfDevelopersResponse(
          od as api.GoogleCloudApigeeV1ListOfDevelopersResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ListOrganizationsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ListOrganizationsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ListOrganizationsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ListOrganizationsResponse(
          od as api.GoogleCloudApigeeV1ListOrganizationsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ListSharedFlowsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ListSharedFlowsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ListSharedFlowsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ListSharedFlowsResponse(
          od as api.GoogleCloudApigeeV1ListSharedFlowsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Metadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Metadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Metadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Metadata(od as api.GoogleCloudApigeeV1Metadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Metric', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Metric();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Metric.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Metric(od as api.GoogleCloudApigeeV1Metric);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1NatAddress', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1NatAddress();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1NatAddress.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1NatAddress(
          od as api.GoogleCloudApigeeV1NatAddress);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Operation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Operation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Operation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Operation(od as api.GoogleCloudApigeeV1Operation);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1OperationConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1OperationConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1OperationConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1OperationConfig(
          od as api.GoogleCloudApigeeV1OperationConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1OperationGroup', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1OperationGroup();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1OperationGroup.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1OperationGroup(
          od as api.GoogleCloudApigeeV1OperationGroup);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1OperationMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1OperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1OperationMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1OperationMetadata(
          od as api.GoogleCloudApigeeV1OperationMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1OptimizedStats', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1OptimizedStats();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1OptimizedStats.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1OptimizedStats(
          od as api.GoogleCloudApigeeV1OptimizedStats);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1OptimizedStatsNode', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1OptimizedStatsNode();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1OptimizedStatsNode.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1OptimizedStatsNode(
          od as api.GoogleCloudApigeeV1OptimizedStatsNode);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1OptimizedStatsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1OptimizedStatsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1OptimizedStatsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1OptimizedStatsResponse(
          od as api.GoogleCloudApigeeV1OptimizedStatsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Organization', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Organization();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Organization.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Organization(
          od as api.GoogleCloudApigeeV1Organization);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1OrganizationProjectMapping',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1OrganizationProjectMapping();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1OrganizationProjectMapping.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1OrganizationProjectMapping(
          od as api.GoogleCloudApigeeV1OrganizationProjectMapping);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1PodStatus', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1PodStatus();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1PodStatus.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1PodStatus(od as api.GoogleCloudApigeeV1PodStatus);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Point', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Point();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Point.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Point(od as api.GoogleCloudApigeeV1Point);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Properties', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Properties();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Properties.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Properties(
          od as api.GoogleCloudApigeeV1Properties);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Property', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Property();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Property.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Property(od as api.GoogleCloudApigeeV1Property);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ProvisionOrganizationRequest',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ProvisionOrganizationRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ProvisionOrganizationRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ProvisionOrganizationRequest(
          od as api.GoogleCloudApigeeV1ProvisionOrganizationRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Query', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Query();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Query.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Query(od as api.GoogleCloudApigeeV1Query);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1QueryMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1QueryMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1QueryMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1QueryMetadata(
          od as api.GoogleCloudApigeeV1QueryMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1QueryMetric', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1QueryMetric();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1QueryMetric.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1QueryMetric(
          od as api.GoogleCloudApigeeV1QueryMetric);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Quota', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Quota();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Quota.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Quota(od as api.GoogleCloudApigeeV1Quota);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Reference', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Reference();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Reference.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Reference(od as api.GoogleCloudApigeeV1Reference);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ReferenceConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ReferenceConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ReferenceConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ReferenceConfig(
          od as api.GoogleCloudApigeeV1ReferenceConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ReportInstanceStatusRequest',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ReportInstanceStatusRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ReportInstanceStatusRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ReportInstanceStatusRequest(
          od as api.GoogleCloudApigeeV1ReportInstanceStatusRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ReportInstanceStatusResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ReportInstanceStatusResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ReportInstanceStatusResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ReportInstanceStatusResponse(
          od as api.GoogleCloudApigeeV1ReportInstanceStatusResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ReportProperty', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ReportProperty();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ReportProperty.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ReportProperty(
          od as api.GoogleCloudApigeeV1ReportProperty);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ResourceConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ResourceConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ResourceConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ResourceConfig(
          od as api.GoogleCloudApigeeV1ResourceConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ResourceFile', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ResourceFile();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ResourceFile.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ResourceFile(
          od as api.GoogleCloudApigeeV1ResourceFile);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ResourceFiles', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ResourceFiles();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ResourceFiles.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ResourceFiles(
          od as api.GoogleCloudApigeeV1ResourceFiles);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ResourceStatus', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ResourceStatus();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ResourceStatus.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ResourceStatus(
          od as api.GoogleCloudApigeeV1ResourceStatus);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Result', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Result();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Result.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Result(od as api.GoogleCloudApigeeV1Result);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1RevisionStatus', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1RevisionStatus();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1RevisionStatus.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1RevisionStatus(
          od as api.GoogleCloudApigeeV1RevisionStatus);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1RoutingRule', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1RoutingRule();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1RoutingRule.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1RoutingRule(
          od as api.GoogleCloudApigeeV1RoutingRule);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1RuntimeTraceConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1RuntimeTraceConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1RuntimeTraceConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1RuntimeTraceConfig(
          od as api.GoogleCloudApigeeV1RuntimeTraceConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1RuntimeTraceConfigOverride',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1RuntimeTraceConfigOverride();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1RuntimeTraceConfigOverride.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1RuntimeTraceConfigOverride(
          od as api.GoogleCloudApigeeV1RuntimeTraceConfigOverride);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1RuntimeTraceSamplingConfig',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1RuntimeTraceSamplingConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1RuntimeTraceSamplingConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1RuntimeTraceSamplingConfig(
          od as api.GoogleCloudApigeeV1RuntimeTraceSamplingConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Schema', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Schema();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Schema.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Schema(od as api.GoogleCloudApigeeV1Schema);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1SchemaSchemaElement', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1SchemaSchemaElement();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1SchemaSchemaElement.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1SchemaSchemaElement(
          od as api.GoogleCloudApigeeV1SchemaSchemaElement);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1SchemaSchemaProperty', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1SchemaSchemaProperty();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1SchemaSchemaProperty.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1SchemaSchemaProperty(
          od as api.GoogleCloudApigeeV1SchemaSchemaProperty);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1ServiceIssuersMapping', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1ServiceIssuersMapping();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1ServiceIssuersMapping.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1ServiceIssuersMapping(
          od as api.GoogleCloudApigeeV1ServiceIssuersMapping);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Session', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Session();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Session.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Session(od as api.GoogleCloudApigeeV1Session);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1SharedFlow', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1SharedFlow();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1SharedFlow.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1SharedFlow(
          od as api.GoogleCloudApigeeV1SharedFlow);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1SharedFlowRevision', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1SharedFlowRevision();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1SharedFlowRevision.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1SharedFlowRevision(
          od as api.GoogleCloudApigeeV1SharedFlowRevision);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Stats', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Stats();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Stats.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Stats(od as api.GoogleCloudApigeeV1Stats);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1StatsEnvironmentStats', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1StatsEnvironmentStats();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1StatsEnvironmentStats.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1StatsEnvironmentStats(
          od as api.GoogleCloudApigeeV1StatsEnvironmentStats);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1StatsHostStats', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1StatsHostStats();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1StatsHostStats.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1StatsHostStats(
          od as api.GoogleCloudApigeeV1StatsHostStats);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1Subscription', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1Subscription();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1Subscription.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1Subscription(
          od as api.GoogleCloudApigeeV1Subscription);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1SyncAuthorization', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1SyncAuthorization();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1SyncAuthorization.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1SyncAuthorization(
          od as api.GoogleCloudApigeeV1SyncAuthorization);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1TargetServer', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1TargetServer();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1TargetServer.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1TargetServer(
          od as api.GoogleCloudApigeeV1TargetServer);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1TargetServerConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1TargetServerConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1TargetServerConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1TargetServerConfig(
          od as api.GoogleCloudApigeeV1TargetServerConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1TestDatastoreResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1TestDatastoreResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1TestDatastoreResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1TestDatastoreResponse(
          od as api.GoogleCloudApigeeV1TestDatastoreResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1TlsInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1TlsInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1TlsInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1TlsInfo(od as api.GoogleCloudApigeeV1TlsInfo);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1TlsInfoCommonName', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1TlsInfoCommonName();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1TlsInfoCommonName.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1TlsInfoCommonName(
          od as api.GoogleCloudApigeeV1TlsInfoCommonName);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1TlsInfoConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1TlsInfoConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1TlsInfoConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1TlsInfoConfig(
          od as api.GoogleCloudApigeeV1TlsInfoConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudApigeeV1UpdateError', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudApigeeV1UpdateError();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudApigeeV1UpdateError.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudApigeeV1UpdateError(
          od as api.GoogleCloudApigeeV1UpdateError);
    });
  });

  unittest.group('obj-schema-GoogleIamV1AuditConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleIamV1AuditConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleIamV1AuditConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleIamV1AuditConfig(od as api.GoogleIamV1AuditConfig);
    });
  });

  unittest.group('obj-schema-GoogleIamV1AuditLogConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleIamV1AuditLogConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleIamV1AuditLogConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleIamV1AuditLogConfig(od as api.GoogleIamV1AuditLogConfig);
    });
  });

  unittest.group('obj-schema-GoogleIamV1Binding', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleIamV1Binding();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleIamV1Binding.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleIamV1Binding(od as api.GoogleIamV1Binding);
    });
  });

  unittest.group('obj-schema-GoogleIamV1Policy', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleIamV1Policy();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleIamV1Policy.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleIamV1Policy(od as api.GoogleIamV1Policy);
    });
  });

  unittest.group('obj-schema-GoogleIamV1SetIamPolicyRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleIamV1SetIamPolicyRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleIamV1SetIamPolicyRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleIamV1SetIamPolicyRequest(
          od as api.GoogleIamV1SetIamPolicyRequest);
    });
  });

  unittest.group('obj-schema-GoogleIamV1TestIamPermissionsRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleIamV1TestIamPermissionsRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleIamV1TestIamPermissionsRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleIamV1TestIamPermissionsRequest(
          od as api.GoogleIamV1TestIamPermissionsRequest);
    });
  });

  unittest.group('obj-schema-GoogleIamV1TestIamPermissionsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleIamV1TestIamPermissionsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleIamV1TestIamPermissionsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleIamV1TestIamPermissionsResponse(
          od as api.GoogleIamV1TestIamPermissionsResponse);
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

  unittest.group('obj-schema-GoogleRpcPreconditionFailure', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleRpcPreconditionFailure();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleRpcPreconditionFailure.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleRpcPreconditionFailure(od as api.GoogleRpcPreconditionFailure);
    });
  });

  unittest.group('obj-schema-GoogleRpcPreconditionFailureViolation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleRpcPreconditionFailureViolation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleRpcPreconditionFailureViolation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleRpcPreconditionFailureViolation(
          od as api.GoogleRpcPreconditionFailureViolation);
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

  unittest.group('obj-schema-GoogleTypeExpr', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleTypeExpr();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleTypeExpr.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleTypeExpr(od as api.GoogleTypeExpr);
    });
  });

  unittest.group('resource-HybridIssuersResource', () {
    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).hybrid.issuers;
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
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListHybridIssuersResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListHybridIssuersResponse(
          response as api.GoogleCloudApigeeV1ListHybridIssuersResponse);
    });
  });

  unittest.group('resource-OrganizationsResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations;
      var arg_request = buildGoogleCloudApigeeV1Organization();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1Organization.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1Organization(
            obj as api.GoogleCloudApigeeV1Organization);

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
          path.substring(pathOffset, pathOffset + 16),
          unittest.equals("v1/organizations"),
        );
        pathOffset += 16;

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
          queryMap["parent"]!.first,
          unittest.equals(arg_parent),
        );
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
      final response = await res.create(arg_request,
          parent: arg_parent, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations;
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
        var resp = convert.json.encode(buildGoogleLongrunningOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Organization());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Organization(
          response as api.GoogleCloudApigeeV1Organization);
    });

    unittest.test('method--getDeployedIngressConfig', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations;
      var arg_name = 'foo';
      var arg_view = 'foo';
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
          queryMap["view"]!.first,
          unittest.equals(arg_view),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleCloudApigeeV1IngressConfig());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.getDeployedIngressConfig(arg_name,
          view: arg_view, $fields: arg_$fields);
      checkGoogleCloudApigeeV1IngressConfig(
          response as api.GoogleCloudApigeeV1IngressConfig);
    });

    unittest.test('method--getSyncAuthorization', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations;
      var arg_request = buildGoogleCloudApigeeV1GetSyncAuthorizationRequest();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1GetSyncAuthorizationRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1GetSyncAuthorizationRequest(
            obj as api.GoogleCloudApigeeV1GetSyncAuthorizationRequest);

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
        var resp =
            convert.json.encode(buildGoogleCloudApigeeV1SyncAuthorization());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.getSyncAuthorization(arg_request, arg_name,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1SyncAuthorization(
          response as api.GoogleCloudApigeeV1SyncAuthorization);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations;
      var arg_parent = 'foo';
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
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListOrganizationsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListOrganizationsResponse(
          response as api.GoogleCloudApigeeV1ListOrganizationsResponse);
    });

    unittest.test('method--setSyncAuthorization', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations;
      var arg_request = buildGoogleCloudApigeeV1SyncAuthorization();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1SyncAuthorization.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1SyncAuthorization(
            obj as api.GoogleCloudApigeeV1SyncAuthorization);

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
        var resp =
            convert.json.encode(buildGoogleCloudApigeeV1SyncAuthorization());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.setSyncAuthorization(arg_request, arg_name,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1SyncAuthorization(
          response as api.GoogleCloudApigeeV1SyncAuthorization);
    });

    unittest.test('method--update', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations;
      var arg_request = buildGoogleCloudApigeeV1Organization();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1Organization.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1Organization(
            obj as api.GoogleCloudApigeeV1Organization);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Organization());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.update(arg_request, arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Organization(
          response as api.GoogleCloudApigeeV1Organization);
    });
  });

  unittest.group('resource-OrganizationsAnalyticsDatastoresResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.analytics.datastores;
      var arg_request = buildGoogleCloudApigeeV1Datastore();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1Datastore.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1Datastore(
            obj as api.GoogleCloudApigeeV1Datastore);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Datastore());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Datastore(
          response as api.GoogleCloudApigeeV1Datastore);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.analytics.datastores;
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
        var resp = convert.json.encode(buildGoogleProtobufEmpty());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleProtobufEmpty(response as api.GoogleProtobufEmpty);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.analytics.datastores;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Datastore());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Datastore(
          response as api.GoogleCloudApigeeV1Datastore);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.analytics.datastores;
      var arg_parent = 'foo';
      var arg_targetType = 'foo';
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
          queryMap["targetType"]!.first,
          unittest.equals(arg_targetType),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListDatastoresResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          targetType: arg_targetType, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListDatastoresResponse(
          response as api.GoogleCloudApigeeV1ListDatastoresResponse);
    });

    unittest.test('method--test', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.analytics.datastores;
      var arg_request = buildGoogleCloudApigeeV1Datastore();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1Datastore.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1Datastore(
            obj as api.GoogleCloudApigeeV1Datastore);

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
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1TestDatastoreResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.test(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1TestDatastoreResponse(
          response as api.GoogleCloudApigeeV1TestDatastoreResponse);
    });

    unittest.test('method--update', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.analytics.datastores;
      var arg_request = buildGoogleCloudApigeeV1Datastore();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1Datastore.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1Datastore(
            obj as api.GoogleCloudApigeeV1Datastore);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Datastore());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.update(arg_request, arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Datastore(
          response as api.GoogleCloudApigeeV1Datastore);
    });
  });

  unittest.group('resource-OrganizationsApiproductsResource', () {
    unittest.test('method--attributes', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.apiproducts;
      var arg_request = buildGoogleCloudApigeeV1Attributes();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1Attributes.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1Attributes(
            obj as api.GoogleCloudApigeeV1Attributes);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Attributes());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.attributes(arg_request, arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Attributes(
          response as api.GoogleCloudApigeeV1Attributes);
    });

    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.apiproducts;
      var arg_request = buildGoogleCloudApigeeV1ApiProduct();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1ApiProduct.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1ApiProduct(
            obj as api.GoogleCloudApigeeV1ApiProduct);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1ApiProduct());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ApiProduct(
          response as api.GoogleCloudApigeeV1ApiProduct);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.apiproducts;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1ApiProduct());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ApiProduct(
          response as api.GoogleCloudApigeeV1ApiProduct);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.apiproducts;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1ApiProduct());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ApiProduct(
          response as api.GoogleCloudApigeeV1ApiProduct);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.apiproducts;
      var arg_parent = 'foo';
      var arg_attributename = 'foo';
      var arg_attributevalue = 'foo';
      var arg_count = 'foo';
      var arg_expand = true;
      var arg_startKey = 'foo';
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
          queryMap["attributename"]!.first,
          unittest.equals(arg_attributename),
        );
        unittest.expect(
          queryMap["attributevalue"]!.first,
          unittest.equals(arg_attributevalue),
        );
        unittest.expect(
          queryMap["count"]!.first,
          unittest.equals(arg_count),
        );
        unittest.expect(
          queryMap["expand"]!.first,
          unittest.equals("$arg_expand"),
        );
        unittest.expect(
          queryMap["startKey"]!.first,
          unittest.equals(arg_startKey),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListApiProductsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          attributename: arg_attributename,
          attributevalue: arg_attributevalue,
          count: arg_count,
          expand: arg_expand,
          startKey: arg_startKey,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListApiProductsResponse(
          response as api.GoogleCloudApigeeV1ListApiProductsResponse);
    });

    unittest.test('method--update', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.apiproducts;
      var arg_request = buildGoogleCloudApigeeV1ApiProduct();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1ApiProduct.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1ApiProduct(
            obj as api.GoogleCloudApigeeV1ApiProduct);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1ApiProduct());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.update(arg_request, arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ApiProduct(
          response as api.GoogleCloudApigeeV1ApiProduct);
    });
  });

  unittest.group('resource-OrganizationsApiproductsAttributesResource', () {
    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.apiproducts.attributes_1;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Attribute());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Attribute(
          response as api.GoogleCloudApigeeV1Attribute);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.apiproducts.attributes_1;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Attribute());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Attribute(
          response as api.GoogleCloudApigeeV1Attribute);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.apiproducts.attributes_1;
      var arg_parent = 'foo';
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Attributes());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Attributes(
          response as api.GoogleCloudApigeeV1Attributes);
    });

    unittest.test('method--updateApiProductAttribute', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.apiproducts.attributes_1;
      var arg_request = buildGoogleCloudApigeeV1Attribute();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1Attribute.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1Attribute(
            obj as api.GoogleCloudApigeeV1Attribute);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Attribute());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.updateApiProductAttribute(
          arg_request, arg_name,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1Attribute(
          response as api.GoogleCloudApigeeV1Attribute);
    });
  });

  unittest.group('resource-OrganizationsApisResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.apis;
      var arg_request = buildGoogleApiHttpBody();
      var arg_parent = 'foo';
      var arg_action = 'foo';
      var arg_name = 'foo';
      var arg_validate = true;
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleApiHttpBody.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleApiHttpBody(obj as api.GoogleApiHttpBody);

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
          queryMap["action"]!.first,
          unittest.equals(arg_action),
        );
        unittest.expect(
          queryMap["name"]!.first,
          unittest.equals(arg_name),
        );
        unittest.expect(
          queryMap["validate"]!.first,
          unittest.equals("$arg_validate"),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp =
            convert.json.encode(buildGoogleCloudApigeeV1ApiProxyRevision());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.create(arg_request, arg_parent,
          action: arg_action,
          name: arg_name,
          validate: arg_validate,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1ApiProxyRevision(
          response as api.GoogleCloudApigeeV1ApiProxyRevision);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.apis;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1ApiProxy());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ApiProxy(
          response as api.GoogleCloudApigeeV1ApiProxy);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.apis;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1ApiProxy());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ApiProxy(
          response as api.GoogleCloudApigeeV1ApiProxy);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.apis;
      var arg_parent = 'foo';
      var arg_includeMetaData = true;
      var arg_includeRevisions = true;
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
          queryMap["includeMetaData"]!.first,
          unittest.equals("$arg_includeMetaData"),
        );
        unittest.expect(
          queryMap["includeRevisions"]!.first,
          unittest.equals("$arg_includeRevisions"),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListApiProxiesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          includeMetaData: arg_includeMetaData,
          includeRevisions: arg_includeRevisions,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListApiProxiesResponse(
          response as api.GoogleCloudApigeeV1ListApiProxiesResponse);
    });
  });

  unittest.group('resource-OrganizationsApisDeploymentsResource', () {
    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.apis.deployments;
      var arg_parent = 'foo';
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
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListDeploymentsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListDeploymentsResponse(
          response as api.GoogleCloudApigeeV1ListDeploymentsResponse);
    });
  });

  unittest.group('resource-OrganizationsApisKeyvaluemapsResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.apis.keyvaluemaps;
      var arg_request = buildGoogleCloudApigeeV1KeyValueMap();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1KeyValueMap.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1KeyValueMap(
            obj as api.GoogleCloudApigeeV1KeyValueMap);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1KeyValueMap());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1KeyValueMap(
          response as api.GoogleCloudApigeeV1KeyValueMap);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.apis.keyvaluemaps;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1KeyValueMap());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1KeyValueMap(
          response as api.GoogleCloudApigeeV1KeyValueMap);
    });
  });

  unittest.group('resource-OrganizationsApisRevisionsResource', () {
    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.apis.revisions;
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
        var resp =
            convert.json.encode(buildGoogleCloudApigeeV1ApiProxyRevision());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ApiProxyRevision(
          response as api.GoogleCloudApigeeV1ApiProxyRevision);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.apis.revisions;
      var arg_name = 'foo';
      var arg_format = 'foo';
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
          queryMap["format"]!.first,
          unittest.equals(arg_format),
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
      final response =
          await res.get(arg_name, format: arg_format, $fields: arg_$fields);
      checkGoogleApiHttpBody(response as api.GoogleApiHttpBody);
    });

    unittest.test('method--updateApiProxyRevision', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.apis.revisions;
      var arg_request = buildGoogleApiHttpBody();
      var arg_name = 'foo';
      var arg_validate = true;
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleApiHttpBody.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleApiHttpBody(obj as api.GoogleApiHttpBody);

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
          queryMap["validate"]!.first,
          unittest.equals("$arg_validate"),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp =
            convert.json.encode(buildGoogleCloudApigeeV1ApiProxyRevision());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.updateApiProxyRevision(arg_request, arg_name,
          validate: arg_validate, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ApiProxyRevision(
          response as api.GoogleCloudApigeeV1ApiProxyRevision);
    });
  });

  unittest.group('resource-OrganizationsApisRevisionsDeploymentsResource', () {
    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.apis.revisions.deployments;
      var arg_parent = 'foo';
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
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListDeploymentsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListDeploymentsResponse(
          response as api.GoogleCloudApigeeV1ListDeploymentsResponse);
    });
  });

  unittest.group('resource-OrganizationsAppsResource', () {
    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.apps;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1App());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1App(response as api.GoogleCloudApigeeV1App);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.apps;
      var arg_parent = 'foo';
      var arg_apiProduct = 'foo';
      var arg_apptype = 'foo';
      var arg_expand = true;
      var arg_ids = 'foo';
      var arg_includeCred = true;
      var arg_keyStatus = 'foo';
      var arg_rows = 'foo';
      var arg_startKey = 'foo';
      var arg_status = 'foo';
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
          queryMap["apiProduct"]!.first,
          unittest.equals(arg_apiProduct),
        );
        unittest.expect(
          queryMap["apptype"]!.first,
          unittest.equals(arg_apptype),
        );
        unittest.expect(
          queryMap["expand"]!.first,
          unittest.equals("$arg_expand"),
        );
        unittest.expect(
          queryMap["ids"]!.first,
          unittest.equals(arg_ids),
        );
        unittest.expect(
          queryMap["includeCred"]!.first,
          unittest.equals("$arg_includeCred"),
        );
        unittest.expect(
          queryMap["keyStatus"]!.first,
          unittest.equals(arg_keyStatus),
        );
        unittest.expect(
          queryMap["rows"]!.first,
          unittest.equals(arg_rows),
        );
        unittest.expect(
          queryMap["startKey"]!.first,
          unittest.equals(arg_startKey),
        );
        unittest.expect(
          queryMap["status"]!.first,
          unittest.equals(arg_status),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp =
            convert.json.encode(buildGoogleCloudApigeeV1ListAppsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          apiProduct: arg_apiProduct,
          apptype: arg_apptype,
          expand: arg_expand,
          ids: arg_ids,
          includeCred: arg_includeCred,
          keyStatus: arg_keyStatus,
          rows: arg_rows,
          startKey: arg_startKey,
          status: arg_status,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListAppsResponse(
          response as api.GoogleCloudApigeeV1ListAppsResponse);
    });
  });

  unittest.group('resource-OrganizationsDatacollectorsResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.datacollectors;
      var arg_request = buildGoogleCloudApigeeV1DataCollector();
      var arg_parent = 'foo';
      var arg_dataCollectorId = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1DataCollector.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1DataCollector(
            obj as api.GoogleCloudApigeeV1DataCollector);

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
          queryMap["dataCollectorId"]!.first,
          unittest.equals(arg_dataCollectorId),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleCloudApigeeV1DataCollector());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.create(arg_request, arg_parent,
          dataCollectorId: arg_dataCollectorId, $fields: arg_$fields);
      checkGoogleCloudApigeeV1DataCollector(
          response as api.GoogleCloudApigeeV1DataCollector);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.datacollectors;
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
        var resp = convert.json.encode(buildGoogleProtobufEmpty());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleProtobufEmpty(response as api.GoogleProtobufEmpty);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.datacollectors;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1DataCollector());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1DataCollector(
          response as api.GoogleCloudApigeeV1DataCollector);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.datacollectors;
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
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListDataCollectorsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListDataCollectorsResponse(
          response as api.GoogleCloudApigeeV1ListDataCollectorsResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.datacollectors;
      var arg_request = buildGoogleCloudApigeeV1DataCollector();
      var arg_name = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1DataCollector.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1DataCollector(
            obj as api.GoogleCloudApigeeV1DataCollector);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1DataCollector());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          updateMask: arg_updateMask, $fields: arg_$fields);
      checkGoogleCloudApigeeV1DataCollector(
          response as api.GoogleCloudApigeeV1DataCollector);
    });
  });

  unittest.group('resource-OrganizationsDeploymentsResource', () {
    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.deployments;
      var arg_parent = 'foo';
      var arg_sharedFlows = true;
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
          queryMap["sharedFlows"]!.first,
          unittest.equals("$arg_sharedFlows"),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListDeploymentsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          sharedFlows: arg_sharedFlows, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListDeploymentsResponse(
          response as api.GoogleCloudApigeeV1ListDeploymentsResponse);
    });
  });

  unittest.group('resource-OrganizationsDevelopersResource', () {
    unittest.test('method--attributes', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers;
      var arg_request = buildGoogleCloudApigeeV1Attributes();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1Attributes.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1Attributes(
            obj as api.GoogleCloudApigeeV1Attributes);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Attributes());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.attributes(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Attributes(
          response as api.GoogleCloudApigeeV1Attributes);
    });

    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers;
      var arg_request = buildGoogleCloudApigeeV1Developer();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1Developer.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1Developer(
            obj as api.GoogleCloudApigeeV1Developer);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Developer());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Developer(
          response as api.GoogleCloudApigeeV1Developer);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Developer());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Developer(
          response as api.GoogleCloudApigeeV1Developer);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers;
      var arg_name = 'foo';
      var arg_action = 'foo';
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
          queryMap["action"]!.first,
          unittest.equals(arg_action),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Developer());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.get(arg_name, action: arg_action, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Developer(
          response as api.GoogleCloudApigeeV1Developer);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers;
      var arg_parent = 'foo';
      var arg_app = 'foo';
      var arg_count = 'foo';
      var arg_expand = true;
      var arg_ids = 'foo';
      var arg_includeCompany = true;
      var arg_startKey = 'foo';
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
          queryMap["app"]!.first,
          unittest.equals(arg_app),
        );
        unittest.expect(
          queryMap["count"]!.first,
          unittest.equals(arg_count),
        );
        unittest.expect(
          queryMap["expand"]!.first,
          unittest.equals("$arg_expand"),
        );
        unittest.expect(
          queryMap["ids"]!.first,
          unittest.equals(arg_ids),
        );
        unittest.expect(
          queryMap["includeCompany"]!.first,
          unittest.equals("$arg_includeCompany"),
        );
        unittest.expect(
          queryMap["startKey"]!.first,
          unittest.equals(arg_startKey),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListOfDevelopersResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          app: arg_app,
          count: arg_count,
          expand: arg_expand,
          ids: arg_ids,
          includeCompany: arg_includeCompany,
          startKey: arg_startKey,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListOfDevelopersResponse(
          response as api.GoogleCloudApigeeV1ListOfDevelopersResponse);
    });

    unittest.test('method--setDeveloperStatus', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers;
      var arg_name = 'foo';
      var arg_action = 'foo';
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
          queryMap["action"]!.first,
          unittest.equals(arg_action),
        );
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
      final response = await res.setDeveloperStatus(arg_name,
          action: arg_action, $fields: arg_$fields);
      checkGoogleProtobufEmpty(response as api.GoogleProtobufEmpty);
    });

    unittest.test('method--update', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers;
      var arg_request = buildGoogleCloudApigeeV1Developer();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1Developer.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1Developer(
            obj as api.GoogleCloudApigeeV1Developer);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Developer());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.update(arg_request, arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Developer(
          response as api.GoogleCloudApigeeV1Developer);
    });
  });

  unittest.group('resource-OrganizationsDevelopersAppsResource', () {
    unittest.test('method--attributes', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers.apps;
      var arg_request = buildGoogleCloudApigeeV1Attributes();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1Attributes.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1Attributes(
            obj as api.GoogleCloudApigeeV1Attributes);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Attributes());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.attributes(arg_request, arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Attributes(
          response as api.GoogleCloudApigeeV1Attributes);
    });

    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers.apps;
      var arg_request = buildGoogleCloudApigeeV1DeveloperApp();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1DeveloperApp.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1DeveloperApp(
            obj as api.GoogleCloudApigeeV1DeveloperApp);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1DeveloperApp());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1DeveloperApp(
          response as api.GoogleCloudApigeeV1DeveloperApp);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers.apps;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1DeveloperApp());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1DeveloperApp(
          response as api.GoogleCloudApigeeV1DeveloperApp);
    });

    unittest.test('method--generateKeyPairOrUpdateDeveloperAppStatus',
        () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers.apps;
      var arg_request = buildGoogleCloudApigeeV1DeveloperApp();
      var arg_name = 'foo';
      var arg_action = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1DeveloperApp.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1DeveloperApp(
            obj as api.GoogleCloudApigeeV1DeveloperApp);

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
          queryMap["action"]!.first,
          unittest.equals(arg_action),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleCloudApigeeV1DeveloperApp());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.generateKeyPairOrUpdateDeveloperAppStatus(
          arg_request, arg_name,
          action: arg_action, $fields: arg_$fields);
      checkGoogleCloudApigeeV1DeveloperApp(
          response as api.GoogleCloudApigeeV1DeveloperApp);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers.apps;
      var arg_name = 'foo';
      var arg_entity = 'foo';
      var arg_query = 'foo';
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
          queryMap["entity"]!.first,
          unittest.equals(arg_entity),
        );
        unittest.expect(
          queryMap["query"]!.first,
          unittest.equals(arg_query),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleCloudApigeeV1DeveloperApp());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name,
          entity: arg_entity, query: arg_query, $fields: arg_$fields);
      checkGoogleCloudApigeeV1DeveloperApp(
          response as api.GoogleCloudApigeeV1DeveloperApp);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers.apps;
      var arg_parent = 'foo';
      var arg_count = 'foo';
      var arg_expand = true;
      var arg_shallowExpand = true;
      var arg_startKey = 'foo';
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
          queryMap["count"]!.first,
          unittest.equals(arg_count),
        );
        unittest.expect(
          queryMap["expand"]!.first,
          unittest.equals("$arg_expand"),
        );
        unittest.expect(
          queryMap["shallowExpand"]!.first,
          unittest.equals("$arg_shallowExpand"),
        );
        unittest.expect(
          queryMap["startKey"]!.first,
          unittest.equals(arg_startKey),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListDeveloperAppsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          count: arg_count,
          expand: arg_expand,
          shallowExpand: arg_shallowExpand,
          startKey: arg_startKey,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListDeveloperAppsResponse(
          response as api.GoogleCloudApigeeV1ListDeveloperAppsResponse);
    });

    unittest.test('method--update', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers.apps;
      var arg_request = buildGoogleCloudApigeeV1DeveloperApp();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1DeveloperApp.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1DeveloperApp(
            obj as api.GoogleCloudApigeeV1DeveloperApp);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1DeveloperApp());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.update(arg_request, arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1DeveloperApp(
          response as api.GoogleCloudApigeeV1DeveloperApp);
    });
  });

  unittest.group('resource-OrganizationsDevelopersAppsAttributesResource', () {
    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers.apps.attributes_1;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Attribute());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Attribute(
          response as api.GoogleCloudApigeeV1Attribute);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers.apps.attributes_1;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Attribute());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Attribute(
          response as api.GoogleCloudApigeeV1Attribute);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers.apps.attributes_1;
      var arg_parent = 'foo';
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Attributes());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Attributes(
          response as api.GoogleCloudApigeeV1Attributes);
    });

    unittest.test('method--updateDeveloperAppAttribute', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers.apps.attributes_1;
      var arg_request = buildGoogleCloudApigeeV1Attribute();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1Attribute.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1Attribute(
            obj as api.GoogleCloudApigeeV1Attribute);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Attribute());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.updateDeveloperAppAttribute(
          arg_request, arg_name,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1Attribute(
          response as api.GoogleCloudApigeeV1Attribute);
    });
  });

  unittest.group('resource-OrganizationsDevelopersAppsKeysResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers.apps.keys;
      var arg_request = buildGoogleCloudApigeeV1DeveloperAppKey();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1DeveloperAppKey.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1DeveloperAppKey(
            obj as api.GoogleCloudApigeeV1DeveloperAppKey);

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
        var resp =
            convert.json.encode(buildGoogleCloudApigeeV1DeveloperAppKey());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1DeveloperAppKey(
          response as api.GoogleCloudApigeeV1DeveloperAppKey);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers.apps.keys;
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
        var resp =
            convert.json.encode(buildGoogleCloudApigeeV1DeveloperAppKey());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1DeveloperAppKey(
          response as api.GoogleCloudApigeeV1DeveloperAppKey);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers.apps.keys;
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
        var resp =
            convert.json.encode(buildGoogleCloudApigeeV1DeveloperAppKey());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1DeveloperAppKey(
          response as api.GoogleCloudApigeeV1DeveloperAppKey);
    });

    unittest.test('method--replaceDeveloperAppKey', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers.apps.keys;
      var arg_request = buildGoogleCloudApigeeV1DeveloperAppKey();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1DeveloperAppKey.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1DeveloperAppKey(
            obj as api.GoogleCloudApigeeV1DeveloperAppKey);

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
        var resp =
            convert.json.encode(buildGoogleCloudApigeeV1DeveloperAppKey());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.replaceDeveloperAppKey(arg_request, arg_name,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1DeveloperAppKey(
          response as api.GoogleCloudApigeeV1DeveloperAppKey);
    });

    unittest.test('method--updateDeveloperAppKey', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers.apps.keys;
      var arg_request = buildGoogleCloudApigeeV1DeveloperAppKey();
      var arg_name = 'foo';
      var arg_action = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1DeveloperAppKey.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1DeveloperAppKey(
            obj as api.GoogleCloudApigeeV1DeveloperAppKey);

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
          queryMap["action"]!.first,
          unittest.equals(arg_action),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp =
            convert.json.encode(buildGoogleCloudApigeeV1DeveloperAppKey());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.updateDeveloperAppKey(arg_request, arg_name,
          action: arg_action, $fields: arg_$fields);
      checkGoogleCloudApigeeV1DeveloperAppKey(
          response as api.GoogleCloudApigeeV1DeveloperAppKey);
    });
  });

  unittest.group('resource-OrganizationsDevelopersAppsKeysApiproductsResource',
      () {
    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res =
          api.ApigeeApi(mock).organizations.developers.apps.keys.apiproducts;
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
        var resp =
            convert.json.encode(buildGoogleCloudApigeeV1DeveloperAppKey());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1DeveloperAppKey(
          response as api.GoogleCloudApigeeV1DeveloperAppKey);
    });

    unittest.test('method--updateDeveloperAppKeyApiProduct', () async {
      var mock = HttpServerMock();
      var res =
          api.ApigeeApi(mock).organizations.developers.apps.keys.apiproducts;
      var arg_name = 'foo';
      var arg_action = 'foo';
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
          queryMap["action"]!.first,
          unittest.equals(arg_action),
        );
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
      final response = await res.updateDeveloperAppKeyApiProduct(arg_name,
          action: arg_action, $fields: arg_$fields);
      checkGoogleProtobufEmpty(response as api.GoogleProtobufEmpty);
    });
  });

  unittest.group('resource-OrganizationsDevelopersAppsKeysCreateResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers.apps.keys.create_1;
      var arg_request = buildGoogleCloudApigeeV1DeveloperAppKey();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1DeveloperAppKey.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1DeveloperAppKey(
            obj as api.GoogleCloudApigeeV1DeveloperAppKey);

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
        var resp =
            convert.json.encode(buildGoogleCloudApigeeV1DeveloperAppKey());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1DeveloperAppKey(
          response as api.GoogleCloudApigeeV1DeveloperAppKey);
    });
  });

  unittest.group('resource-OrganizationsDevelopersAttributesResource', () {
    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers.attributes_1;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Attribute());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Attribute(
          response as api.GoogleCloudApigeeV1Attribute);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers.attributes_1;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Attribute());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Attribute(
          response as api.GoogleCloudApigeeV1Attribute);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers.attributes_1;
      var arg_parent = 'foo';
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Attributes());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Attributes(
          response as api.GoogleCloudApigeeV1Attributes);
    });

    unittest.test('method--updateDeveloperAttribute', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.developers.attributes_1;
      var arg_request = buildGoogleCloudApigeeV1Attribute();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1Attribute.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1Attribute(
            obj as api.GoogleCloudApigeeV1Attribute);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Attribute());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.updateDeveloperAttribute(arg_request, arg_name,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1Attribute(
          response as api.GoogleCloudApigeeV1Attribute);
    });
  });

  unittest.group('resource-OrganizationsEnvgroupsResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.envgroups;
      var arg_request = buildGoogleCloudApigeeV1EnvironmentGroup();
      var arg_parent = 'foo';
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1EnvironmentGroup.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1EnvironmentGroup(
            obj as api.GoogleCloudApigeeV1EnvironmentGroup);

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
          queryMap["name"]!.first,
          unittest.equals(arg_name),
        );
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
      final response = await res.create(arg_request, arg_parent,
          name: arg_name, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.envgroups;
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
        var resp = convert.json.encode(buildGoogleLongrunningOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.envgroups;
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
        var resp =
            convert.json.encode(buildGoogleCloudApigeeV1EnvironmentGroup());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1EnvironmentGroup(
          response as api.GoogleCloudApigeeV1EnvironmentGroup);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.envgroups;
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
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListEnvironmentGroupsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListEnvironmentGroupsResponse(
          response as api.GoogleCloudApigeeV1ListEnvironmentGroupsResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.envgroups;
      var arg_request = buildGoogleCloudApigeeV1EnvironmentGroup();
      var arg_name = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1EnvironmentGroup.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1EnvironmentGroup(
            obj as api.GoogleCloudApigeeV1EnvironmentGroup);

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
        var resp = convert.json.encode(buildGoogleLongrunningOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          updateMask: arg_updateMask, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });
  });

  unittest.group('resource-OrganizationsEnvgroupsAttachmentsResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.envgroups.attachments;
      var arg_request = buildGoogleCloudApigeeV1EnvironmentGroupAttachment();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1EnvironmentGroupAttachment.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1EnvironmentGroupAttachment(
            obj as api.GoogleCloudApigeeV1EnvironmentGroupAttachment);

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
        var resp = convert.json.encode(buildGoogleLongrunningOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.envgroups.attachments;
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
        var resp = convert.json.encode(buildGoogleLongrunningOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.envgroups.attachments;
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
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1EnvironmentGroupAttachment());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1EnvironmentGroupAttachment(
          response as api.GoogleCloudApigeeV1EnvironmentGroupAttachment);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.envgroups.attachments;
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
        var resp = convert.json.encode(
            buildGoogleCloudApigeeV1ListEnvironmentGroupAttachmentsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListEnvironmentGroupAttachmentsResponse(response
          as api.GoogleCloudApigeeV1ListEnvironmentGroupAttachmentsResponse);
    });
  });

  unittest.group('resource-OrganizationsEnvironmentsResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments;
      var arg_request = buildGoogleCloudApigeeV1Environment();
      var arg_parent = 'foo';
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1Environment.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1Environment(
            obj as api.GoogleCloudApigeeV1Environment);

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
          queryMap["name"]!.first,
          unittest.equals(arg_name),
        );
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
      final response = await res.create(arg_request, arg_parent,
          name: arg_name, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments;
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
        var resp = convert.json.encode(buildGoogleLongrunningOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Environment());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Environment(
          response as api.GoogleCloudApigeeV1Environment);
    });

    unittest.test('method--getDebugmask', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1DebugMask());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.getDebugmask(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1DebugMask(
          response as api.GoogleCloudApigeeV1DebugMask);
    });

    unittest.test('method--getDeployedConfig', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments;
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
        var resp =
            convert.json.encode(buildGoogleCloudApigeeV1EnvironmentConfig());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.getDeployedConfig(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1EnvironmentConfig(
          response as api.GoogleCloudApigeeV1EnvironmentConfig);
    });

    unittest.test('method--getIamPolicy', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments;
      var arg_resource = 'foo';
      var arg_options_requestedPolicyVersion = 42;
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
          core.int.parse(queryMap["options.requestedPolicyVersion"]!.first),
          unittest.equals(arg_options_requestedPolicyVersion),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleIamV1Policy());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.getIamPolicy(arg_resource,
          options_requestedPolicyVersion: arg_options_requestedPolicyVersion,
          $fields: arg_$fields);
      checkGoogleIamV1Policy(response as api.GoogleIamV1Policy);
    });

    unittest.test('method--setIamPolicy', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments;
      var arg_request = buildGoogleIamV1SetIamPolicyRequest();
      var arg_resource = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleIamV1SetIamPolicyRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleIamV1SetIamPolicyRequest(
            obj as api.GoogleIamV1SetIamPolicyRequest);

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
        var resp = convert.json.encode(buildGoogleIamV1Policy());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.setIamPolicy(arg_request, arg_resource,
          $fields: arg_$fields);
      checkGoogleIamV1Policy(response as api.GoogleIamV1Policy);
    });

    unittest.test('method--subscribe', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments;
      var arg_parent = 'foo';
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Subscription());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.subscribe(arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Subscription(
          response as api.GoogleCloudApigeeV1Subscription);
    });

    unittest.test('method--testIamPermissions', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments;
      var arg_request = buildGoogleIamV1TestIamPermissionsRequest();
      var arg_resource = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleIamV1TestIamPermissionsRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleIamV1TestIamPermissionsRequest(
            obj as api.GoogleIamV1TestIamPermissionsRequest);

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
        var resp =
            convert.json.encode(buildGoogleIamV1TestIamPermissionsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.testIamPermissions(arg_request, arg_resource,
          $fields: arg_$fields);
      checkGoogleIamV1TestIamPermissionsResponse(
          response as api.GoogleIamV1TestIamPermissionsResponse);
    });

    unittest.test('method--unsubscribe', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments;
      var arg_request = buildGoogleCloudApigeeV1Subscription();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1Subscription.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1Subscription(
            obj as api.GoogleCloudApigeeV1Subscription);

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
        var resp = convert.json.encode(buildGoogleProtobufEmpty());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.unsubscribe(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleProtobufEmpty(response as api.GoogleProtobufEmpty);
    });

    unittest.test('method--update', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments;
      var arg_request = buildGoogleCloudApigeeV1Environment();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1Environment.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1Environment(
            obj as api.GoogleCloudApigeeV1Environment);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Environment());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.update(arg_request, arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Environment(
          response as api.GoogleCloudApigeeV1Environment);
    });

    unittest.test('method--updateDebugmask', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments;
      var arg_request = buildGoogleCloudApigeeV1DebugMask();
      var arg_name = 'foo';
      var arg_replaceRepeatedFields = true;
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1DebugMask.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1DebugMask(
            obj as api.GoogleCloudApigeeV1DebugMask);

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
          queryMap["replaceRepeatedFields"]!.first,
          unittest.equals("$arg_replaceRepeatedFields"),
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1DebugMask());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.updateDebugmask(arg_request, arg_name,
          replaceRepeatedFields: arg_replaceRepeatedFields,
          updateMask: arg_updateMask,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1DebugMask(
          response as api.GoogleCloudApigeeV1DebugMask);
    });

    unittest.test('method--updateEnvironment', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments;
      var arg_request = buildGoogleCloudApigeeV1Environment();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1Environment.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1Environment(
            obj as api.GoogleCloudApigeeV1Environment);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Environment());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.updateEnvironment(arg_request, arg_name,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1Environment(
          response as api.GoogleCloudApigeeV1Environment);
    });
  });

  unittest.group('resource-OrganizationsEnvironmentsAnalyticsAdminResource',
      () {
    unittest.test('method--getSchemav2', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.analytics.admin;
      var arg_name = 'foo';
      var arg_type = 'foo';
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
          queryMap["type"]!.first,
          unittest.equals(arg_type),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Schema());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.getSchemav2(arg_name, type: arg_type, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Schema(response as api.GoogleCloudApigeeV1Schema);
    });
  });

  unittest.group('resource-OrganizationsEnvironmentsAnalyticsExportsResource',
      () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res =
          api.ApigeeApi(mock).organizations.environments.analytics.exports;
      var arg_request = buildGoogleCloudApigeeV1ExportRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1ExportRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1ExportRequest(
            obj as api.GoogleCloudApigeeV1ExportRequest);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Export());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Export(response as api.GoogleCloudApigeeV1Export);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res =
          api.ApigeeApi(mock).organizations.environments.analytics.exports;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Export());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Export(response as api.GoogleCloudApigeeV1Export);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res =
          api.ApigeeApi(mock).organizations.environments.analytics.exports;
      var arg_parent = 'foo';
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
        var resp =
            convert.json.encode(buildGoogleCloudApigeeV1ListExportsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListExportsResponse(
          response as api.GoogleCloudApigeeV1ListExportsResponse);
    });
  });

  unittest.group('resource-OrganizationsEnvironmentsApisDeploymentsResource',
      () {
    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.apis.deployments;
      var arg_parent = 'foo';
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
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListDeploymentsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListDeploymentsResponse(
          response as api.GoogleCloudApigeeV1ListDeploymentsResponse);
    });
  });

  unittest.group('resource-OrganizationsEnvironmentsApisRevisionsResource', () {
    unittest.test('method--deploy', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.apis.revisions;
      var arg_name = 'foo';
      var arg_override = true;
      var arg_sequencedRollout = true;
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
          queryMap["override"]!.first,
          unittest.equals("$arg_override"),
        );
        unittest.expect(
          queryMap["sequencedRollout"]!.first,
          unittest.equals("$arg_sequencedRollout"),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Deployment());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.deploy(arg_name,
          override: arg_override,
          sequencedRollout: arg_sequencedRollout,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1Deployment(
          response as api.GoogleCloudApigeeV1Deployment);
    });

    unittest.test('method--getDeployments', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.apis.revisions;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Deployment());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.getDeployments(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Deployment(
          response as api.GoogleCloudApigeeV1Deployment);
    });

    unittest.test('method--undeploy', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.apis.revisions;
      var arg_name = 'foo';
      var arg_sequencedRollout = true;
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
          queryMap["sequencedRollout"]!.first,
          unittest.equals("$arg_sequencedRollout"),
        );
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
      final response = await res.undeploy(arg_name,
          sequencedRollout: arg_sequencedRollout, $fields: arg_$fields);
      checkGoogleProtobufEmpty(response as api.GoogleProtobufEmpty);
    });
  });

  unittest.group(
      'resource-OrganizationsEnvironmentsApisRevisionsDebugsessionsResource',
      () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock)
          .organizations
          .environments
          .apis
          .revisions
          .debugsessions;
      var arg_request = buildGoogleCloudApigeeV1DebugSession();
      var arg_parent = 'foo';
      var arg_timeout = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1DebugSession.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1DebugSession(
            obj as api.GoogleCloudApigeeV1DebugSession);

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
          queryMap["timeout"]!.first,
          unittest.equals(arg_timeout),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleCloudApigeeV1DebugSession());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.create(arg_request, arg_parent,
          timeout: arg_timeout, $fields: arg_$fields);
      checkGoogleCloudApigeeV1DebugSession(
          response as api.GoogleCloudApigeeV1DebugSession);
    });

    unittest.test('method--deleteData', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock)
          .organizations
          .environments
          .apis
          .revisions
          .debugsessions;
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
        var resp = convert.json.encode(buildGoogleProtobufEmpty());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.deleteData(arg_name, $fields: arg_$fields);
      checkGoogleProtobufEmpty(response as api.GoogleProtobufEmpty);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock)
          .organizations
          .environments
          .apis
          .revisions
          .debugsessions;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1DebugSession());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1DebugSession(
          response as api.GoogleCloudApigeeV1DebugSession);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock)
          .organizations
          .environments
          .apis
          .revisions
          .debugsessions;
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
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListDebugSessionsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListDebugSessionsResponse(
          response as api.GoogleCloudApigeeV1ListDebugSessionsResponse);
    });
  });

  unittest.group(
      'resource-OrganizationsEnvironmentsApisRevisionsDebugsessionsDataResource',
      () {
    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock)
          .organizations
          .environments
          .apis
          .revisions
          .debugsessions
          .data;
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
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1DebugSessionTransaction());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1DebugSessionTransaction(
          response as api.GoogleCloudApigeeV1DebugSessionTransaction);
    });
  });

  unittest.group(
      'resource-OrganizationsEnvironmentsApisRevisionsDeploymentsResource', () {
    unittest.test('method--generateDeployChangeReport', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock)
          .organizations
          .environments
          .apis
          .revisions
          .deployments;
      var arg_name = 'foo';
      var arg_override = true;
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
          queryMap["override"]!.first,
          unittest.equals("$arg_override"),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1DeploymentChangeReport());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.generateDeployChangeReport(arg_name,
          override: arg_override, $fields: arg_$fields);
      checkGoogleCloudApigeeV1DeploymentChangeReport(
          response as api.GoogleCloudApigeeV1DeploymentChangeReport);
    });

    unittest.test('method--generateUndeployChangeReport', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock)
          .organizations
          .environments
          .apis
          .revisions
          .deployments;
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
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1DeploymentChangeReport());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.generateUndeployChangeReport(arg_name,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1DeploymentChangeReport(
          response as api.GoogleCloudApigeeV1DeploymentChangeReport);
    });
  });

  unittest.group('resource-OrganizationsEnvironmentsCachesResource', () {
    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.caches;
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
        var resp = convert.json.encode(buildGoogleProtobufEmpty());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleProtobufEmpty(response as api.GoogleProtobufEmpty);
    });
  });

  unittest.group('resource-OrganizationsEnvironmentsDeploymentsResource', () {
    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.deployments;
      var arg_parent = 'foo';
      var arg_sharedFlows = true;
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
          queryMap["sharedFlows"]!.first,
          unittest.equals("$arg_sharedFlows"),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListDeploymentsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          sharedFlows: arg_sharedFlows, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListDeploymentsResponse(
          response as api.GoogleCloudApigeeV1ListDeploymentsResponse);
    });
  });

  unittest.group('resource-OrganizationsEnvironmentsFlowhooksResource', () {
    unittest.test('method--attachSharedFlowToFlowHook', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.flowhooks;
      var arg_request = buildGoogleCloudApigeeV1FlowHook();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1FlowHook.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1FlowHook(
            obj as api.GoogleCloudApigeeV1FlowHook);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1FlowHook());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.attachSharedFlowToFlowHook(
          arg_request, arg_name,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1FlowHook(
          response as api.GoogleCloudApigeeV1FlowHook);
    });

    unittest.test('method--detachSharedFlowFromFlowHook', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.flowhooks;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1FlowHook());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.detachSharedFlowFromFlowHook(arg_name,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1FlowHook(
          response as api.GoogleCloudApigeeV1FlowHook);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.flowhooks;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1FlowHook());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1FlowHook(
          response as api.GoogleCloudApigeeV1FlowHook);
    });
  });

  unittest.group('resource-OrganizationsEnvironmentsKeystoresResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.keystores;
      var arg_request = buildGoogleCloudApigeeV1Keystore();
      var arg_parent = 'foo';
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1Keystore.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1Keystore(
            obj as api.GoogleCloudApigeeV1Keystore);

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
          queryMap["name"]!.first,
          unittest.equals(arg_name),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Keystore());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.create(arg_request, arg_parent,
          name: arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Keystore(
          response as api.GoogleCloudApigeeV1Keystore);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.keystores;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Keystore());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Keystore(
          response as api.GoogleCloudApigeeV1Keystore);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.keystores;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Keystore());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Keystore(
          response as api.GoogleCloudApigeeV1Keystore);
    });
  });

  unittest.group('resource-OrganizationsEnvironmentsKeystoresAliasesResource',
      () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res =
          api.ApigeeApi(mock).organizations.environments.keystores.aliases;
      var arg_request = buildGoogleApiHttpBody();
      var arg_parent = 'foo';
      var arg_P_password = 'foo';
      var arg_alias = 'foo';
      var arg_format = 'foo';
      var arg_ignoreExpiryValidation = true;
      var arg_ignoreNewlineValidation = true;
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleApiHttpBody.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleApiHttpBody(obj as api.GoogleApiHttpBody);

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
          queryMap["_password"]!.first,
          unittest.equals(arg_P_password),
        );
        unittest.expect(
          queryMap["alias"]!.first,
          unittest.equals(arg_alias),
        );
        unittest.expect(
          queryMap["format"]!.first,
          unittest.equals(arg_format),
        );
        unittest.expect(
          queryMap["ignoreExpiryValidation"]!.first,
          unittest.equals("$arg_ignoreExpiryValidation"),
        );
        unittest.expect(
          queryMap["ignoreNewlineValidation"]!.first,
          unittest.equals("$arg_ignoreNewlineValidation"),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Alias());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.create(arg_request, arg_parent,
          P_password: arg_P_password,
          alias: arg_alias,
          format: arg_format,
          ignoreExpiryValidation: arg_ignoreExpiryValidation,
          ignoreNewlineValidation: arg_ignoreNewlineValidation,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1Alias(response as api.GoogleCloudApigeeV1Alias);
    });

    unittest.test('method--csr', () async {
      var mock = HttpServerMock();
      var res =
          api.ApigeeApi(mock).organizations.environments.keystores.aliases;
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
        var resp = convert.json.encode(buildGoogleApiHttpBody());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.csr(arg_name, $fields: arg_$fields);
      checkGoogleApiHttpBody(response as api.GoogleApiHttpBody);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res =
          api.ApigeeApi(mock).organizations.environments.keystores.aliases;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Alias());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Alias(response as api.GoogleCloudApigeeV1Alias);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res =
          api.ApigeeApi(mock).organizations.environments.keystores.aliases;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Alias());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Alias(response as api.GoogleCloudApigeeV1Alias);
    });

    unittest.test('method--getCertificate', () async {
      var mock = HttpServerMock();
      var res =
          api.ApigeeApi(mock).organizations.environments.keystores.aliases;
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
        var resp = convert.json.encode(buildGoogleApiHttpBody());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.getCertificate(arg_name, $fields: arg_$fields);
      checkGoogleApiHttpBody(response as api.GoogleApiHttpBody);
    });

    unittest.test('method--update', () async {
      var mock = HttpServerMock();
      var res =
          api.ApigeeApi(mock).organizations.environments.keystores.aliases;
      var arg_request = buildGoogleApiHttpBody();
      var arg_name = 'foo';
      var arg_ignoreExpiryValidation = true;
      var arg_ignoreNewlineValidation = true;
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleApiHttpBody.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleApiHttpBody(obj as api.GoogleApiHttpBody);

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
          queryMap["ignoreExpiryValidation"]!.first,
          unittest.equals("$arg_ignoreExpiryValidation"),
        );
        unittest.expect(
          queryMap["ignoreNewlineValidation"]!.first,
          unittest.equals("$arg_ignoreNewlineValidation"),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Alias());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.update(arg_request, arg_name,
          ignoreExpiryValidation: arg_ignoreExpiryValidation,
          ignoreNewlineValidation: arg_ignoreNewlineValidation,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1Alias(response as api.GoogleCloudApigeeV1Alias);
    });
  });

  unittest.group('resource-OrganizationsEnvironmentsKeyvaluemapsResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.keyvaluemaps;
      var arg_request = buildGoogleCloudApigeeV1KeyValueMap();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1KeyValueMap.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1KeyValueMap(
            obj as api.GoogleCloudApigeeV1KeyValueMap);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1KeyValueMap());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1KeyValueMap(
          response as api.GoogleCloudApigeeV1KeyValueMap);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.keyvaluemaps;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1KeyValueMap());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1KeyValueMap(
          response as api.GoogleCloudApigeeV1KeyValueMap);
    });
  });

  unittest.group('resource-OrganizationsEnvironmentsOptimizedStatsResource',
      () {
    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.optimizedStats;
      var arg_name = 'foo';
      var arg_accuracy = 'foo';
      var arg_aggTable = 'foo';
      var arg_filter = 'foo';
      var arg_limit = 'foo';
      var arg_offset = 'foo';
      var arg_realtime = true;
      var arg_select = 'foo';
      var arg_sonar = true;
      var arg_sort = 'foo';
      var arg_sortby = 'foo';
      var arg_timeRange = 'foo';
      var arg_timeUnit = 'foo';
      var arg_topk = 'foo';
      var arg_tsAscending = true;
      var arg_tzo = 'foo';
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
          queryMap["accuracy"]!.first,
          unittest.equals(arg_accuracy),
        );
        unittest.expect(
          queryMap["aggTable"]!.first,
          unittest.equals(arg_aggTable),
        );
        unittest.expect(
          queryMap["filter"]!.first,
          unittest.equals(arg_filter),
        );
        unittest.expect(
          queryMap["limit"]!.first,
          unittest.equals(arg_limit),
        );
        unittest.expect(
          queryMap["offset"]!.first,
          unittest.equals(arg_offset),
        );
        unittest.expect(
          queryMap["realtime"]!.first,
          unittest.equals("$arg_realtime"),
        );
        unittest.expect(
          queryMap["select"]!.first,
          unittest.equals(arg_select),
        );
        unittest.expect(
          queryMap["sonar"]!.first,
          unittest.equals("$arg_sonar"),
        );
        unittest.expect(
          queryMap["sort"]!.first,
          unittest.equals(arg_sort),
        );
        unittest.expect(
          queryMap["sortby"]!.first,
          unittest.equals(arg_sortby),
        );
        unittest.expect(
          queryMap["timeRange"]!.first,
          unittest.equals(arg_timeRange),
        );
        unittest.expect(
          queryMap["timeUnit"]!.first,
          unittest.equals(arg_timeUnit),
        );
        unittest.expect(
          queryMap["topk"]!.first,
          unittest.equals(arg_topk),
        );
        unittest.expect(
          queryMap["tsAscending"]!.first,
          unittest.equals("$arg_tsAscending"),
        );
        unittest.expect(
          queryMap["tzo"]!.first,
          unittest.equals(arg_tzo),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp =
            convert.json.encode(buildGoogleCloudApigeeV1OptimizedStats());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name,
          accuracy: arg_accuracy,
          aggTable: arg_aggTable,
          filter: arg_filter,
          limit: arg_limit,
          offset: arg_offset,
          realtime: arg_realtime,
          select: arg_select,
          sonar: arg_sonar,
          sort: arg_sort,
          sortby: arg_sortby,
          timeRange: arg_timeRange,
          timeUnit: arg_timeUnit,
          topk: arg_topk,
          tsAscending: arg_tsAscending,
          tzo: arg_tzo,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1OptimizedStats(
          response as api.GoogleCloudApigeeV1OptimizedStats);
    });
  });

  unittest.group('resource-OrganizationsEnvironmentsQueriesResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.queries;
      var arg_request = buildGoogleCloudApigeeV1Query();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1Query.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1Query(obj as api.GoogleCloudApigeeV1Query);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1AsyncQuery());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1AsyncQuery(
          response as api.GoogleCloudApigeeV1AsyncQuery);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.queries;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1AsyncQuery());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1AsyncQuery(
          response as api.GoogleCloudApigeeV1AsyncQuery);
    });

    unittest.test('method--getResult', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.queries;
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
        var resp = convert.json.encode(buildGoogleApiHttpBody());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.getResult(arg_name, $fields: arg_$fields);
      checkGoogleApiHttpBody(response as api.GoogleApiHttpBody);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.queries;
      var arg_parent = 'foo';
      var arg_dataset = 'foo';
      var arg_from = 'foo';
      var arg_inclQueriesWithoutReport = 'foo';
      var arg_status = 'foo';
      var arg_submittedBy = 'foo';
      var arg_to = 'foo';
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
          queryMap["dataset"]!.first,
          unittest.equals(arg_dataset),
        );
        unittest.expect(
          queryMap["from"]!.first,
          unittest.equals(arg_from),
        );
        unittest.expect(
          queryMap["inclQueriesWithoutReport"]!.first,
          unittest.equals(arg_inclQueriesWithoutReport),
        );
        unittest.expect(
          queryMap["status"]!.first,
          unittest.equals(arg_status),
        );
        unittest.expect(
          queryMap["submittedBy"]!.first,
          unittest.equals(arg_submittedBy),
        );
        unittest.expect(
          queryMap["to"]!.first,
          unittest.equals(arg_to),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListAsyncQueriesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          dataset: arg_dataset,
          from: arg_from,
          inclQueriesWithoutReport: arg_inclQueriesWithoutReport,
          status: arg_status,
          submittedBy: arg_submittedBy,
          to: arg_to,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListAsyncQueriesResponse(
          response as api.GoogleCloudApigeeV1ListAsyncQueriesResponse);
    });
  });

  unittest.group('resource-OrganizationsEnvironmentsReferencesResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.references;
      var arg_request = buildGoogleCloudApigeeV1Reference();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1Reference.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1Reference(
            obj as api.GoogleCloudApigeeV1Reference);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Reference());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Reference(
          response as api.GoogleCloudApigeeV1Reference);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.references;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Reference());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Reference(
          response as api.GoogleCloudApigeeV1Reference);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.references;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Reference());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Reference(
          response as api.GoogleCloudApigeeV1Reference);
    });

    unittest.test('method--update', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.references;
      var arg_request = buildGoogleCloudApigeeV1Reference();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1Reference.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1Reference(
            obj as api.GoogleCloudApigeeV1Reference);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Reference());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.update(arg_request, arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Reference(
          response as api.GoogleCloudApigeeV1Reference);
    });
  });

  unittest.group('resource-OrganizationsEnvironmentsResourcefilesResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.resourcefiles;
      var arg_request = buildGoogleApiHttpBody();
      var arg_parent = 'foo';
      var arg_name = 'foo';
      var arg_type = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleApiHttpBody.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleApiHttpBody(obj as api.GoogleApiHttpBody);

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
          queryMap["name"]!.first,
          unittest.equals(arg_name),
        );
        unittest.expect(
          queryMap["type"]!.first,
          unittest.equals(arg_type),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleCloudApigeeV1ResourceFile());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.create(arg_request, arg_parent,
          name: arg_name, type: arg_type, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ResourceFile(
          response as api.GoogleCloudApigeeV1ResourceFile);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.resourcefiles;
      var arg_parent = 'foo';
      var arg_type = 'foo';
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1ResourceFile());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_parent, arg_type, arg_name,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1ResourceFile(
          response as api.GoogleCloudApigeeV1ResourceFile);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.resourcefiles;
      var arg_parent = 'foo';
      var arg_type = 'foo';
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
        var resp = convert.json.encode(buildGoogleApiHttpBody());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.get(arg_parent, arg_type, arg_name, $fields: arg_$fields);
      checkGoogleApiHttpBody(response as api.GoogleApiHttpBody);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.resourcefiles;
      var arg_parent = 'foo';
      var arg_type = 'foo';
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
          queryMap["type"]!.first,
          unittest.equals(arg_type),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListEnvironmentResourcesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.list(arg_parent, type: arg_type, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListEnvironmentResourcesResponse(
          response as api.GoogleCloudApigeeV1ListEnvironmentResourcesResponse);
    });

    unittest.test('method--listEnvironmentResources', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.resourcefiles;
      var arg_parent = 'foo';
      var arg_type = 'foo';
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
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListEnvironmentResourcesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.listEnvironmentResources(arg_parent, arg_type,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListEnvironmentResourcesResponse(
          response as api.GoogleCloudApigeeV1ListEnvironmentResourcesResponse);
    });

    unittest.test('method--update', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.resourcefiles;
      var arg_request = buildGoogleApiHttpBody();
      var arg_parent = 'foo';
      var arg_type = 'foo';
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleApiHttpBody.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleApiHttpBody(obj as api.GoogleApiHttpBody);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1ResourceFile());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.update(
          arg_request, arg_parent, arg_type, arg_name,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1ResourceFile(
          response as api.GoogleCloudApigeeV1ResourceFile);
    });
  });

  unittest.group(
      'resource-OrganizationsEnvironmentsSharedflowsDeploymentsResource', () {
    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock)
          .organizations
          .environments
          .sharedflows
          .deployments;
      var arg_parent = 'foo';
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
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListDeploymentsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListDeploymentsResponse(
          response as api.GoogleCloudApigeeV1ListDeploymentsResponse);
    });
  });

  unittest.group(
      'resource-OrganizationsEnvironmentsSharedflowsRevisionsResource', () {
    unittest.test('method--deploy', () async {
      var mock = HttpServerMock();
      var res =
          api.ApigeeApi(mock).organizations.environments.sharedflows.revisions;
      var arg_name = 'foo';
      var arg_override = true;
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
          queryMap["override"]!.first,
          unittest.equals("$arg_override"),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Deployment());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.deploy(arg_name,
          override: arg_override, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Deployment(
          response as api.GoogleCloudApigeeV1Deployment);
    });

    unittest.test('method--getDeployments', () async {
      var mock = HttpServerMock();
      var res =
          api.ApigeeApi(mock).organizations.environments.sharedflows.revisions;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Deployment());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.getDeployments(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Deployment(
          response as api.GoogleCloudApigeeV1Deployment);
    });

    unittest.test('method--undeploy', () async {
      var mock = HttpServerMock();
      var res =
          api.ApigeeApi(mock).organizations.environments.sharedflows.revisions;
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
        var resp = convert.json.encode(buildGoogleProtobufEmpty());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.undeploy(arg_name, $fields: arg_$fields);
      checkGoogleProtobufEmpty(response as api.GoogleProtobufEmpty);
    });
  });

  unittest.group('resource-OrganizationsEnvironmentsStatsResource', () {
    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.stats;
      var arg_name = 'foo';
      var arg_accuracy = 'foo';
      var arg_aggTable = 'foo';
      var arg_filter = 'foo';
      var arg_limit = 'foo';
      var arg_offset = 'foo';
      var arg_realtime = true;
      var arg_select = 'foo';
      var arg_sonar = true;
      var arg_sort = 'foo';
      var arg_sortby = 'foo';
      var arg_timeRange = 'foo';
      var arg_timeUnit = 'foo';
      var arg_topk = 'foo';
      var arg_tsAscending = true;
      var arg_tzo = 'foo';
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
          queryMap["accuracy"]!.first,
          unittest.equals(arg_accuracy),
        );
        unittest.expect(
          queryMap["aggTable"]!.first,
          unittest.equals(arg_aggTable),
        );
        unittest.expect(
          queryMap["filter"]!.first,
          unittest.equals(arg_filter),
        );
        unittest.expect(
          queryMap["limit"]!.first,
          unittest.equals(arg_limit),
        );
        unittest.expect(
          queryMap["offset"]!.first,
          unittest.equals(arg_offset),
        );
        unittest.expect(
          queryMap["realtime"]!.first,
          unittest.equals("$arg_realtime"),
        );
        unittest.expect(
          queryMap["select"]!.first,
          unittest.equals(arg_select),
        );
        unittest.expect(
          queryMap["sonar"]!.first,
          unittest.equals("$arg_sonar"),
        );
        unittest.expect(
          queryMap["sort"]!.first,
          unittest.equals(arg_sort),
        );
        unittest.expect(
          queryMap["sortby"]!.first,
          unittest.equals(arg_sortby),
        );
        unittest.expect(
          queryMap["timeRange"]!.first,
          unittest.equals(arg_timeRange),
        );
        unittest.expect(
          queryMap["timeUnit"]!.first,
          unittest.equals(arg_timeUnit),
        );
        unittest.expect(
          queryMap["topk"]!.first,
          unittest.equals(arg_topk),
        );
        unittest.expect(
          queryMap["tsAscending"]!.first,
          unittest.equals("$arg_tsAscending"),
        );
        unittest.expect(
          queryMap["tzo"]!.first,
          unittest.equals(arg_tzo),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Stats());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name,
          accuracy: arg_accuracy,
          aggTable: arg_aggTable,
          filter: arg_filter,
          limit: arg_limit,
          offset: arg_offset,
          realtime: arg_realtime,
          select: arg_select,
          sonar: arg_sonar,
          sort: arg_sort,
          sortby: arg_sortby,
          timeRange: arg_timeRange,
          timeUnit: arg_timeUnit,
          topk: arg_topk,
          tsAscending: arg_tsAscending,
          tzo: arg_tzo,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1Stats(response as api.GoogleCloudApigeeV1Stats);
    });
  });

  unittest.group('resource-OrganizationsEnvironmentsTargetserversResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.targetservers;
      var arg_request = buildGoogleCloudApigeeV1TargetServer();
      var arg_parent = 'foo';
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1TargetServer.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1TargetServer(
            obj as api.GoogleCloudApigeeV1TargetServer);

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
          queryMap["name"]!.first,
          unittest.equals(arg_name),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleCloudApigeeV1TargetServer());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.create(arg_request, arg_parent,
          name: arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1TargetServer(
          response as api.GoogleCloudApigeeV1TargetServer);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.targetservers;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1TargetServer());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1TargetServer(
          response as api.GoogleCloudApigeeV1TargetServer);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.targetservers;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1TargetServer());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1TargetServer(
          response as api.GoogleCloudApigeeV1TargetServer);
    });

    unittest.test('method--update', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.environments.targetservers;
      var arg_request = buildGoogleCloudApigeeV1TargetServer();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1TargetServer.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1TargetServer(
            obj as api.GoogleCloudApigeeV1TargetServer);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1TargetServer());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.update(arg_request, arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1TargetServer(
          response as api.GoogleCloudApigeeV1TargetServer);
    });
  });

  unittest.group('resource-OrganizationsHostQueriesResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.hostQueries;
      var arg_request = buildGoogleCloudApigeeV1Query();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1Query.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1Query(obj as api.GoogleCloudApigeeV1Query);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1AsyncQuery());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1AsyncQuery(
          response as api.GoogleCloudApigeeV1AsyncQuery);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.hostQueries;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1AsyncQuery());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1AsyncQuery(
          response as api.GoogleCloudApigeeV1AsyncQuery);
    });

    unittest.test('method--getResult', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.hostQueries;
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
        var resp = convert.json.encode(buildGoogleApiHttpBody());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.getResult(arg_name, $fields: arg_$fields);
      checkGoogleApiHttpBody(response as api.GoogleApiHttpBody);
    });

    unittest.test('method--getResultView', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.hostQueries;
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
        var resp =
            convert.json.encode(buildGoogleCloudApigeeV1AsyncQueryResultView());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.getResultView(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1AsyncQueryResultView(
          response as api.GoogleCloudApigeeV1AsyncQueryResultView);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.hostQueries;
      var arg_parent = 'foo';
      var arg_dataset = 'foo';
      var arg_envgroupHostname = 'foo';
      var arg_from = 'foo';
      var arg_inclQueriesWithoutReport = 'foo';
      var arg_status = 'foo';
      var arg_submittedBy = 'foo';
      var arg_to = 'foo';
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
          queryMap["dataset"]!.first,
          unittest.equals(arg_dataset),
        );
        unittest.expect(
          queryMap["envgroupHostname"]!.first,
          unittest.equals(arg_envgroupHostname),
        );
        unittest.expect(
          queryMap["from"]!.first,
          unittest.equals(arg_from),
        );
        unittest.expect(
          queryMap["inclQueriesWithoutReport"]!.first,
          unittest.equals(arg_inclQueriesWithoutReport),
        );
        unittest.expect(
          queryMap["status"]!.first,
          unittest.equals(arg_status),
        );
        unittest.expect(
          queryMap["submittedBy"]!.first,
          unittest.equals(arg_submittedBy),
        );
        unittest.expect(
          queryMap["to"]!.first,
          unittest.equals(arg_to),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListAsyncQueriesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          dataset: arg_dataset,
          envgroupHostname: arg_envgroupHostname,
          from: arg_from,
          inclQueriesWithoutReport: arg_inclQueriesWithoutReport,
          status: arg_status,
          submittedBy: arg_submittedBy,
          to: arg_to,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListAsyncQueriesResponse(
          response as api.GoogleCloudApigeeV1ListAsyncQueriesResponse);
    });
  });

  unittest.group('resource-OrganizationsHostStatsResource', () {
    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.hostStats;
      var arg_name = 'foo';
      var arg_accuracy = 'foo';
      var arg_envgroupHostname = 'foo';
      var arg_filter = 'foo';
      var arg_limit = 'foo';
      var arg_offset = 'foo';
      var arg_realtime = true;
      var arg_select = 'foo';
      var arg_sort = 'foo';
      var arg_sortby = 'foo';
      var arg_timeRange = 'foo';
      var arg_timeUnit = 'foo';
      var arg_topk = 'foo';
      var arg_tsAscending = true;
      var arg_tzo = 'foo';
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
          queryMap["accuracy"]!.first,
          unittest.equals(arg_accuracy),
        );
        unittest.expect(
          queryMap["envgroupHostname"]!.first,
          unittest.equals(arg_envgroupHostname),
        );
        unittest.expect(
          queryMap["filter"]!.first,
          unittest.equals(arg_filter),
        );
        unittest.expect(
          queryMap["limit"]!.first,
          unittest.equals(arg_limit),
        );
        unittest.expect(
          queryMap["offset"]!.first,
          unittest.equals(arg_offset),
        );
        unittest.expect(
          queryMap["realtime"]!.first,
          unittest.equals("$arg_realtime"),
        );
        unittest.expect(
          queryMap["select"]!.first,
          unittest.equals(arg_select),
        );
        unittest.expect(
          queryMap["sort"]!.first,
          unittest.equals(arg_sort),
        );
        unittest.expect(
          queryMap["sortby"]!.first,
          unittest.equals(arg_sortby),
        );
        unittest.expect(
          queryMap["timeRange"]!.first,
          unittest.equals(arg_timeRange),
        );
        unittest.expect(
          queryMap["timeUnit"]!.first,
          unittest.equals(arg_timeUnit),
        );
        unittest.expect(
          queryMap["topk"]!.first,
          unittest.equals(arg_topk),
        );
        unittest.expect(
          queryMap["tsAscending"]!.first,
          unittest.equals("$arg_tsAscending"),
        );
        unittest.expect(
          queryMap["tzo"]!.first,
          unittest.equals(arg_tzo),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Stats());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name,
          accuracy: arg_accuracy,
          envgroupHostname: arg_envgroupHostname,
          filter: arg_filter,
          limit: arg_limit,
          offset: arg_offset,
          realtime: arg_realtime,
          select: arg_select,
          sort: arg_sort,
          sortby: arg_sortby,
          timeRange: arg_timeRange,
          timeUnit: arg_timeUnit,
          topk: arg_topk,
          tsAscending: arg_tsAscending,
          tzo: arg_tzo,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1Stats(response as api.GoogleCloudApigeeV1Stats);
    });
  });

  unittest.group('resource-OrganizationsInstancesResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.instances;
      var arg_request = buildGoogleCloudApigeeV1Instance();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1Instance.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1Instance(
            obj as api.GoogleCloudApigeeV1Instance);

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
        var resp = convert.json.encode(buildGoogleLongrunningOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.instances;
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
        var resp = convert.json.encode(buildGoogleLongrunningOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.instances;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1Instance());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1Instance(
          response as api.GoogleCloudApigeeV1Instance);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.instances;
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
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListInstancesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListInstancesResponse(
          response as api.GoogleCloudApigeeV1ListInstancesResponse);
    });

    unittest.test('method--reportStatus', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.instances;
      var arg_request = buildGoogleCloudApigeeV1ReportInstanceStatusRequest();
      var arg_instance = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1ReportInstanceStatusRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1ReportInstanceStatusRequest(
            obj as api.GoogleCloudApigeeV1ReportInstanceStatusRequest);

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
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ReportInstanceStatusResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.reportStatus(arg_request, arg_instance,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1ReportInstanceStatusResponse(
          response as api.GoogleCloudApigeeV1ReportInstanceStatusResponse);
    });
  });

  unittest.group('resource-OrganizationsInstancesAttachmentsResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.instances.attachments;
      var arg_request = buildGoogleCloudApigeeV1InstanceAttachment();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1InstanceAttachment.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1InstanceAttachment(
            obj as api.GoogleCloudApigeeV1InstanceAttachment);

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
        var resp = convert.json.encode(buildGoogleLongrunningOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.instances.attachments;
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
        var resp = convert.json.encode(buildGoogleLongrunningOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.instances.attachments;
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
        var resp =
            convert.json.encode(buildGoogleCloudApigeeV1InstanceAttachment());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1InstanceAttachment(
          response as api.GoogleCloudApigeeV1InstanceAttachment);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.instances.attachments;
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
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListInstanceAttachmentsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListInstanceAttachmentsResponse(
          response as api.GoogleCloudApigeeV1ListInstanceAttachmentsResponse);
    });
  });

  unittest.group('resource-OrganizationsInstancesCanaryevaluationsResource',
      () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.instances.canaryevaluations;
      var arg_request = buildGoogleCloudApigeeV1CanaryEvaluation();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1CanaryEvaluation.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1CanaryEvaluation(
            obj as api.GoogleCloudApigeeV1CanaryEvaluation);

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
        var resp = convert.json.encode(buildGoogleLongrunningOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.instances.canaryevaluations;
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
        var resp =
            convert.json.encode(buildGoogleCloudApigeeV1CanaryEvaluation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1CanaryEvaluation(
          response as api.GoogleCloudApigeeV1CanaryEvaluation);
    });
  });

  unittest.group('resource-OrganizationsInstancesNatAddressesResource', () {
    unittest.test('method--activate', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.instances.natAddresses;
      var arg_request = buildGoogleCloudApigeeV1ActivateNatAddressRequest();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1ActivateNatAddressRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1ActivateNatAddressRequest(
            obj as api.GoogleCloudApigeeV1ActivateNatAddressRequest);

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
        var resp = convert.json.encode(buildGoogleLongrunningOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.activate(arg_request, arg_name, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.instances.natAddresses;
      var arg_request = buildGoogleCloudApigeeV1NatAddress();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1NatAddress.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1NatAddress(
            obj as api.GoogleCloudApigeeV1NatAddress);

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
        var resp = convert.json.encode(buildGoogleLongrunningOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.instances.natAddresses;
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
        var resp = convert.json.encode(buildGoogleLongrunningOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.instances.natAddresses;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1NatAddress());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1NatAddress(
          response as api.GoogleCloudApigeeV1NatAddress);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.instances.natAddresses;
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
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListNatAddressesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListNatAddressesResponse(
          response as api.GoogleCloudApigeeV1ListNatAddressesResponse);
    });
  });

  unittest.group('resource-OrganizationsKeyvaluemapsResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.keyvaluemaps;
      var arg_request = buildGoogleCloudApigeeV1KeyValueMap();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1KeyValueMap.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1KeyValueMap(
            obj as api.GoogleCloudApigeeV1KeyValueMap);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1KeyValueMap());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1KeyValueMap(
          response as api.GoogleCloudApigeeV1KeyValueMap);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.keyvaluemaps;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1KeyValueMap());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1KeyValueMap(
          response as api.GoogleCloudApigeeV1KeyValueMap);
    });
  });

  unittest.group('resource-OrganizationsOperationsResource', () {
    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.operations;
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
        var resp = convert.json.encode(buildGoogleLongrunningOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.operations;
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

  unittest.group('resource-OrganizationsOptimizedHostStatsResource', () {
    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.optimizedHostStats;
      var arg_name = 'foo';
      var arg_accuracy = 'foo';
      var arg_envgroupHostname = 'foo';
      var arg_filter = 'foo';
      var arg_limit = 'foo';
      var arg_offset = 'foo';
      var arg_realtime = true;
      var arg_select = 'foo';
      var arg_sort = 'foo';
      var arg_sortby = 'foo';
      var arg_timeRange = 'foo';
      var arg_timeUnit = 'foo';
      var arg_topk = 'foo';
      var arg_tsAscending = true;
      var arg_tzo = 'foo';
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
          queryMap["accuracy"]!.first,
          unittest.equals(arg_accuracy),
        );
        unittest.expect(
          queryMap["envgroupHostname"]!.first,
          unittest.equals(arg_envgroupHostname),
        );
        unittest.expect(
          queryMap["filter"]!.first,
          unittest.equals(arg_filter),
        );
        unittest.expect(
          queryMap["limit"]!.first,
          unittest.equals(arg_limit),
        );
        unittest.expect(
          queryMap["offset"]!.first,
          unittest.equals(arg_offset),
        );
        unittest.expect(
          queryMap["realtime"]!.first,
          unittest.equals("$arg_realtime"),
        );
        unittest.expect(
          queryMap["select"]!.first,
          unittest.equals(arg_select),
        );
        unittest.expect(
          queryMap["sort"]!.first,
          unittest.equals(arg_sort),
        );
        unittest.expect(
          queryMap["sortby"]!.first,
          unittest.equals(arg_sortby),
        );
        unittest.expect(
          queryMap["timeRange"]!.first,
          unittest.equals(arg_timeRange),
        );
        unittest.expect(
          queryMap["timeUnit"]!.first,
          unittest.equals(arg_timeUnit),
        );
        unittest.expect(
          queryMap["topk"]!.first,
          unittest.equals(arg_topk),
        );
        unittest.expect(
          queryMap["tsAscending"]!.first,
          unittest.equals("$arg_tsAscending"),
        );
        unittest.expect(
          queryMap["tzo"]!.first,
          unittest.equals(arg_tzo),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp =
            convert.json.encode(buildGoogleCloudApigeeV1OptimizedStats());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name,
          accuracy: arg_accuracy,
          envgroupHostname: arg_envgroupHostname,
          filter: arg_filter,
          limit: arg_limit,
          offset: arg_offset,
          realtime: arg_realtime,
          select: arg_select,
          sort: arg_sort,
          sortby: arg_sortby,
          timeRange: arg_timeRange,
          timeUnit: arg_timeUnit,
          topk: arg_topk,
          tsAscending: arg_tsAscending,
          tzo: arg_tzo,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1OptimizedStats(
          response as api.GoogleCloudApigeeV1OptimizedStats);
    });
  });

  unittest.group('resource-OrganizationsReportsResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.reports;
      var arg_request = buildGoogleCloudApigeeV1CustomReport();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1CustomReport.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1CustomReport(
            obj as api.GoogleCloudApigeeV1CustomReport);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1CustomReport());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1CustomReport(
          response as api.GoogleCloudApigeeV1CustomReport);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.reports;
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
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1DeleteCustomReportResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1DeleteCustomReportResponse(
          response as api.GoogleCloudApigeeV1DeleteCustomReportResponse);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.reports;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1CustomReport());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1CustomReport(
          response as api.GoogleCloudApigeeV1CustomReport);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.reports;
      var arg_parent = 'foo';
      var arg_expand = true;
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
          queryMap["expand"]!.first,
          unittest.equals("$arg_expand"),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListCustomReportsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.list(arg_parent, expand: arg_expand, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListCustomReportsResponse(
          response as api.GoogleCloudApigeeV1ListCustomReportsResponse);
    });

    unittest.test('method--update', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.reports;
      var arg_request = buildGoogleCloudApigeeV1CustomReport();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1CustomReport.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1CustomReport(
            obj as api.GoogleCloudApigeeV1CustomReport);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1CustomReport());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.update(arg_request, arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1CustomReport(
          response as api.GoogleCloudApigeeV1CustomReport);
    });
  });

  unittest.group('resource-OrganizationsSharedflowsResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.sharedflows;
      var arg_request = buildGoogleApiHttpBody();
      var arg_parent = 'foo';
      var arg_action = 'foo';
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleApiHttpBody.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleApiHttpBody(obj as api.GoogleApiHttpBody);

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
          queryMap["action"]!.first,
          unittest.equals(arg_action),
        );
        unittest.expect(
          queryMap["name"]!.first,
          unittest.equals(arg_name),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp =
            convert.json.encode(buildGoogleCloudApigeeV1SharedFlowRevision());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.create(arg_request, arg_parent,
          action: arg_action, name: arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1SharedFlowRevision(
          response as api.GoogleCloudApigeeV1SharedFlowRevision);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.sharedflows;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1SharedFlow());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1SharedFlow(
          response as api.GoogleCloudApigeeV1SharedFlow);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.sharedflows;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1SharedFlow());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1SharedFlow(
          response as api.GoogleCloudApigeeV1SharedFlow);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.sharedflows;
      var arg_parent = 'foo';
      var arg_includeMetaData = true;
      var arg_includeRevisions = true;
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
          queryMap["includeMetaData"]!.first,
          unittest.equals("$arg_includeMetaData"),
        );
        unittest.expect(
          queryMap["includeRevisions"]!.first,
          unittest.equals("$arg_includeRevisions"),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListSharedFlowsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          includeMetaData: arg_includeMetaData,
          includeRevisions: arg_includeRevisions,
          $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListSharedFlowsResponse(
          response as api.GoogleCloudApigeeV1ListSharedFlowsResponse);
    });
  });

  unittest.group('resource-OrganizationsSharedflowsDeploymentsResource', () {
    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.sharedflows.deployments;
      var arg_parent = 'foo';
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
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListDeploymentsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListDeploymentsResponse(
          response as api.GoogleCloudApigeeV1ListDeploymentsResponse);
    });
  });

  unittest.group('resource-OrganizationsSharedflowsRevisionsResource', () {
    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.sharedflows.revisions;
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
        var resp =
            convert.json.encode(buildGoogleCloudApigeeV1SharedFlowRevision());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1SharedFlowRevision(
          response as api.GoogleCloudApigeeV1SharedFlowRevision);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.sharedflows.revisions;
      var arg_name = 'foo';
      var arg_format = 'foo';
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
          queryMap["format"]!.first,
          unittest.equals(arg_format),
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
      final response =
          await res.get(arg_name, format: arg_format, $fields: arg_$fields);
      checkGoogleApiHttpBody(response as api.GoogleApiHttpBody);
    });

    unittest.test('method--updateSharedFlowRevision', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.sharedflows.revisions;
      var arg_request = buildGoogleApiHttpBody();
      var arg_name = 'foo';
      var arg_validate = true;
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleApiHttpBody.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleApiHttpBody(obj as api.GoogleApiHttpBody);

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
          queryMap["validate"]!.first,
          unittest.equals("$arg_validate"),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp =
            convert.json.encode(buildGoogleCloudApigeeV1SharedFlowRevision());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.updateSharedFlowRevision(arg_request, arg_name,
          validate: arg_validate, $fields: arg_$fields);
      checkGoogleCloudApigeeV1SharedFlowRevision(
          response as api.GoogleCloudApigeeV1SharedFlowRevision);
    });
  });

  unittest.group(
      'resource-OrganizationsSharedflowsRevisionsDeploymentsResource', () {
    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res =
          api.ApigeeApi(mock).organizations.sharedflows.revisions.deployments;
      var arg_parent = 'foo';
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
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListDeploymentsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListDeploymentsResponse(
          response as api.GoogleCloudApigeeV1ListDeploymentsResponse);
    });
  });

  unittest.group('resource-OrganizationsSitesApicategoriesResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.sites.apicategories;
      var arg_request = buildGoogleCloudApigeeV1ApiCategoryData();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1ApiCategoryData.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1ApiCategoryData(
            obj as api.GoogleCloudApigeeV1ApiCategoryData);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1ApiCategory());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ApiCategory(
          response as api.GoogleCloudApigeeV1ApiCategory);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.sites.apicategories;
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
        var resp =
            convert.json.encode(buildGoogleCloudApigeeV1ApiResponseWrapper());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.delete(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ApiResponseWrapper(
          response as api.GoogleCloudApigeeV1ApiResponseWrapper);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.sites.apicategories;
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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1ApiCategory());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ApiCategory(
          response as api.GoogleCloudApigeeV1ApiCategory);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.sites.apicategories;
      var arg_parent = 'foo';
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
        var resp = convert.json
            .encode(buildGoogleCloudApigeeV1ListApiCategoriesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ListApiCategoriesResponse(
          response as api.GoogleCloudApigeeV1ListApiCategoriesResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).organizations.sites.apicategories;
      var arg_request = buildGoogleCloudApigeeV1ApiCategoryData();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1ApiCategoryData.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1ApiCategoryData(
            obj as api.GoogleCloudApigeeV1ApiCategoryData);

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
        var resp = convert.json.encode(buildGoogleCloudApigeeV1ApiCategory());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.patch(arg_request, arg_name, $fields: arg_$fields);
      checkGoogleCloudApigeeV1ApiCategory(
          response as api.GoogleCloudApigeeV1ApiCategory);
    });
  });

  unittest.group('resource-ProjectsResource', () {
    unittest.test('method--provisionOrganization', () async {
      var mock = HttpServerMock();
      var res = api.ApigeeApi(mock).projects;
      var arg_request = buildGoogleCloudApigeeV1ProvisionOrganizationRequest();
      var arg_project = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudApigeeV1ProvisionOrganizationRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudApigeeV1ProvisionOrganizationRequest(
            obj as api.GoogleCloudApigeeV1ProvisionOrganizationRequest);

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
        var resp = convert.json.encode(buildGoogleLongrunningOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.provisionOrganization(arg_request, arg_project,
          $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });
  });
}
