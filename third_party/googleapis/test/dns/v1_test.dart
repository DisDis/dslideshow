library googleapis.dns.v1.test;

import "dart:core" as core;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:test/test.dart' as unittest;

import 'package:googleapis/dns/v1.dart' as api;

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

buildUnnamed4174() {
  var o = new core.List<api.ResourceRecordSet>();
  o.add(buildResourceRecordSet());
  o.add(buildResourceRecordSet());
  return o;
}

checkUnnamed4174(core.List<api.ResourceRecordSet> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkResourceRecordSet(o[0]);
  checkResourceRecordSet(o[1]);
}

buildUnnamed4175() {
  var o = new core.List<api.ResourceRecordSet>();
  o.add(buildResourceRecordSet());
  o.add(buildResourceRecordSet());
  return o;
}

checkUnnamed4175(core.List<api.ResourceRecordSet> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkResourceRecordSet(o[0]);
  checkResourceRecordSet(o[1]);
}

core.int buildCounterChange = 0;
buildChange() {
  var o = new api.Change();
  buildCounterChange++;
  if (buildCounterChange < 3) {
    o.additions = buildUnnamed4174();
    o.deletions = buildUnnamed4175();
    o.id = "foo";
    o.isServing = true;
    o.kind = "foo";
    o.startTime = "foo";
    o.status = "foo";
  }
  buildCounterChange--;
  return o;
}

checkChange(api.Change o) {
  buildCounterChange++;
  if (buildCounterChange < 3) {
    checkUnnamed4174(o.additions);
    checkUnnamed4175(o.deletions);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.isServing, unittest.isTrue);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.startTime, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals('foo'));
  }
  buildCounterChange--;
}

buildUnnamed4176() {
  var o = new core.List<api.Change>();
  o.add(buildChange());
  o.add(buildChange());
  return o;
}

checkUnnamed4176(core.List<api.Change> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkChange(o[0]);
  checkChange(o[1]);
}

core.int buildCounterChangesListResponse = 0;
buildChangesListResponse() {
  var o = new api.ChangesListResponse();
  buildCounterChangesListResponse++;
  if (buildCounterChangesListResponse < 3) {
    o.changes = buildUnnamed4176();
    o.header = buildResponseHeader();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterChangesListResponse--;
  return o;
}

checkChangesListResponse(api.ChangesListResponse o) {
  buildCounterChangesListResponse++;
  if (buildCounterChangesListResponse < 3) {
    checkUnnamed4176(o.changes);
    checkResponseHeader(o.header);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterChangesListResponse--;
}

buildUnnamed4177() {
  var o = new core.List<api.DnsKeyDigest>();
  o.add(buildDnsKeyDigest());
  o.add(buildDnsKeyDigest());
  return o;
}

checkUnnamed4177(core.List<api.DnsKeyDigest> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDnsKeyDigest(o[0]);
  checkDnsKeyDigest(o[1]);
}

core.int buildCounterDnsKey = 0;
buildDnsKey() {
  var o = new api.DnsKey();
  buildCounterDnsKey++;
  if (buildCounterDnsKey < 3) {
    o.algorithm = "foo";
    o.creationTime = "foo";
    o.description = "foo";
    o.digests = buildUnnamed4177();
    o.id = "foo";
    o.isActive = true;
    o.keyLength = 42;
    o.keyTag = 42;
    o.kind = "foo";
    o.publicKey = "foo";
    o.type = "foo";
  }
  buildCounterDnsKey--;
  return o;
}

checkDnsKey(api.DnsKey o) {
  buildCounterDnsKey++;
  if (buildCounterDnsKey < 3) {
    unittest.expect(o.algorithm, unittest.equals('foo'));
    unittest.expect(o.creationTime, unittest.equals('foo'));
    unittest.expect(o.description, unittest.equals('foo'));
    checkUnnamed4177(o.digests);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.isActive, unittest.isTrue);
    unittest.expect(o.keyLength, unittest.equals(42));
    unittest.expect(o.keyTag, unittest.equals(42));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.publicKey, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterDnsKey--;
}

core.int buildCounterDnsKeyDigest = 0;
buildDnsKeyDigest() {
  var o = new api.DnsKeyDigest();
  buildCounterDnsKeyDigest++;
  if (buildCounterDnsKeyDigest < 3) {
    o.digest = "foo";
    o.type = "foo";
  }
  buildCounterDnsKeyDigest--;
  return o;
}

checkDnsKeyDigest(api.DnsKeyDigest o) {
  buildCounterDnsKeyDigest++;
  if (buildCounterDnsKeyDigest < 3) {
    unittest.expect(o.digest, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterDnsKeyDigest--;
}

core.int buildCounterDnsKeySpec = 0;
buildDnsKeySpec() {
  var o = new api.DnsKeySpec();
  buildCounterDnsKeySpec++;
  if (buildCounterDnsKeySpec < 3) {
    o.algorithm = "foo";
    o.keyLength = 42;
    o.keyType = "foo";
    o.kind = "foo";
  }
  buildCounterDnsKeySpec--;
  return o;
}

checkDnsKeySpec(api.DnsKeySpec o) {
  buildCounterDnsKeySpec++;
  if (buildCounterDnsKeySpec < 3) {
    unittest.expect(o.algorithm, unittest.equals('foo'));
    unittest.expect(o.keyLength, unittest.equals(42));
    unittest.expect(o.keyType, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterDnsKeySpec--;
}

buildUnnamed4178() {
  var o = new core.List<api.DnsKey>();
  o.add(buildDnsKey());
  o.add(buildDnsKey());
  return o;
}

checkUnnamed4178(core.List<api.DnsKey> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDnsKey(o[0]);
  checkDnsKey(o[1]);
}

core.int buildCounterDnsKeysListResponse = 0;
buildDnsKeysListResponse() {
  var o = new api.DnsKeysListResponse();
  buildCounterDnsKeysListResponse++;
  if (buildCounterDnsKeysListResponse < 3) {
    o.dnsKeys = buildUnnamed4178();
    o.header = buildResponseHeader();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterDnsKeysListResponse--;
  return o;
}

checkDnsKeysListResponse(api.DnsKeysListResponse o) {
  buildCounterDnsKeysListResponse++;
  if (buildCounterDnsKeysListResponse < 3) {
    checkUnnamed4178(o.dnsKeys);
    checkResponseHeader(o.header);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterDnsKeysListResponse--;
}

buildUnnamed4179() {
  var o = new core.Map<core.String, core.String>();
  o["x"] = "foo";
  o["y"] = "foo";
  return o;
}

checkUnnamed4179(core.Map<core.String, core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o["x"], unittest.equals('foo'));
  unittest.expect(o["y"], unittest.equals('foo'));
}

buildUnnamed4180() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed4180(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterManagedZone = 0;
buildManagedZone() {
  var o = new api.ManagedZone();
  buildCounterManagedZone++;
  if (buildCounterManagedZone < 3) {
    o.creationTime = "foo";
    o.description = "foo";
    o.dnsName = "foo";
    o.dnssecConfig = buildManagedZoneDnsSecConfig();
    o.id = "foo";
    o.kind = "foo";
    o.labels = buildUnnamed4179();
    o.name = "foo";
    o.nameServerSet = "foo";
    o.nameServers = buildUnnamed4180();
  }
  buildCounterManagedZone--;
  return o;
}

checkManagedZone(api.ManagedZone o) {
  buildCounterManagedZone++;
  if (buildCounterManagedZone < 3) {
    unittest.expect(o.creationTime, unittest.equals('foo'));
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.dnsName, unittest.equals('foo'));
    checkManagedZoneDnsSecConfig(o.dnssecConfig);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed4179(o.labels);
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.nameServerSet, unittest.equals('foo'));
    checkUnnamed4180(o.nameServers);
  }
  buildCounterManagedZone--;
}

buildUnnamed4181() {
  var o = new core.List<api.DnsKeySpec>();
  o.add(buildDnsKeySpec());
  o.add(buildDnsKeySpec());
  return o;
}

checkUnnamed4181(core.List<api.DnsKeySpec> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDnsKeySpec(o[0]);
  checkDnsKeySpec(o[1]);
}

core.int buildCounterManagedZoneDnsSecConfig = 0;
buildManagedZoneDnsSecConfig() {
  var o = new api.ManagedZoneDnsSecConfig();
  buildCounterManagedZoneDnsSecConfig++;
  if (buildCounterManagedZoneDnsSecConfig < 3) {
    o.defaultKeySpecs = buildUnnamed4181();
    o.kind = "foo";
    o.nonExistence = "foo";
    o.state = "foo";
  }
  buildCounterManagedZoneDnsSecConfig--;
  return o;
}

checkManagedZoneDnsSecConfig(api.ManagedZoneDnsSecConfig o) {
  buildCounterManagedZoneDnsSecConfig++;
  if (buildCounterManagedZoneDnsSecConfig < 3) {
    checkUnnamed4181(o.defaultKeySpecs);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nonExistence, unittest.equals('foo'));
    unittest.expect(o.state, unittest.equals('foo'));
  }
  buildCounterManagedZoneDnsSecConfig--;
}

buildUnnamed4182() {
  var o = new core.List<api.Operation>();
  o.add(buildOperation());
  o.add(buildOperation());
  return o;
}

checkUnnamed4182(core.List<api.Operation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOperation(o[0]);
  checkOperation(o[1]);
}

core.int buildCounterManagedZoneOperationsListResponse = 0;
buildManagedZoneOperationsListResponse() {
  var o = new api.ManagedZoneOperationsListResponse();
  buildCounterManagedZoneOperationsListResponse++;
  if (buildCounterManagedZoneOperationsListResponse < 3) {
    o.header = buildResponseHeader();
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.operations = buildUnnamed4182();
  }
  buildCounterManagedZoneOperationsListResponse--;
  return o;
}

checkManagedZoneOperationsListResponse(
    api.ManagedZoneOperationsListResponse o) {
  buildCounterManagedZoneOperationsListResponse++;
  if (buildCounterManagedZoneOperationsListResponse < 3) {
    checkResponseHeader(o.header);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed4182(o.operations);
  }
  buildCounterManagedZoneOperationsListResponse--;
}

buildUnnamed4183() {
  var o = new core.List<api.ManagedZone>();
  o.add(buildManagedZone());
  o.add(buildManagedZone());
  return o;
}

checkUnnamed4183(core.List<api.ManagedZone> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkManagedZone(o[0]);
  checkManagedZone(o[1]);
}

core.int buildCounterManagedZonesListResponse = 0;
buildManagedZonesListResponse() {
  var o = new api.ManagedZonesListResponse();
  buildCounterManagedZonesListResponse++;
  if (buildCounterManagedZonesListResponse < 3) {
    o.header = buildResponseHeader();
    o.kind = "foo";
    o.managedZones = buildUnnamed4183();
    o.nextPageToken = "foo";
  }
  buildCounterManagedZonesListResponse--;
  return o;
}

checkManagedZonesListResponse(api.ManagedZonesListResponse o) {
  buildCounterManagedZonesListResponse++;
  if (buildCounterManagedZonesListResponse < 3) {
    checkResponseHeader(o.header);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed4183(o.managedZones);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterManagedZonesListResponse--;
}

core.int buildCounterOperation = 0;
buildOperation() {
  var o = new api.Operation();
  buildCounterOperation++;
  if (buildCounterOperation < 3) {
    o.dnsKeyContext = buildOperationDnsKeyContext();
    o.id = "foo";
    o.kind = "foo";
    o.startTime = "foo";
    o.status = "foo";
    o.type = "foo";
    o.user = "foo";
    o.zoneContext = buildOperationManagedZoneContext();
  }
  buildCounterOperation--;
  return o;
}

checkOperation(api.Operation o) {
  buildCounterOperation++;
  if (buildCounterOperation < 3) {
    checkOperationDnsKeyContext(o.dnsKeyContext);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.startTime, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
    unittest.expect(o.user, unittest.equals('foo'));
    checkOperationManagedZoneContext(o.zoneContext);
  }
  buildCounterOperation--;
}

core.int buildCounterOperationDnsKeyContext = 0;
buildOperationDnsKeyContext() {
  var o = new api.OperationDnsKeyContext();
  buildCounterOperationDnsKeyContext++;
  if (buildCounterOperationDnsKeyContext < 3) {
    o.newValue = buildDnsKey();
    o.oldValue = buildDnsKey();
  }
  buildCounterOperationDnsKeyContext--;
  return o;
}

checkOperationDnsKeyContext(api.OperationDnsKeyContext o) {
  buildCounterOperationDnsKeyContext++;
  if (buildCounterOperationDnsKeyContext < 3) {
    checkDnsKey(o.newValue);
    checkDnsKey(o.oldValue);
  }
  buildCounterOperationDnsKeyContext--;
}

core.int buildCounterOperationManagedZoneContext = 0;
buildOperationManagedZoneContext() {
  var o = new api.OperationManagedZoneContext();
  buildCounterOperationManagedZoneContext++;
  if (buildCounterOperationManagedZoneContext < 3) {
    o.newValue = buildManagedZone();
    o.oldValue = buildManagedZone();
  }
  buildCounterOperationManagedZoneContext--;
  return o;
}

checkOperationManagedZoneContext(api.OperationManagedZoneContext o) {
  buildCounterOperationManagedZoneContext++;
  if (buildCounterOperationManagedZoneContext < 3) {
    checkManagedZone(o.newValue);
    checkManagedZone(o.oldValue);
  }
  buildCounterOperationManagedZoneContext--;
}

core.int buildCounterProject = 0;
buildProject() {
  var o = new api.Project();
  buildCounterProject++;
  if (buildCounterProject < 3) {
    o.id = "foo";
    o.kind = "foo";
    o.number = "foo";
    o.quota = buildQuota();
  }
  buildCounterProject--;
  return o;
}

checkProject(api.Project o) {
  buildCounterProject++;
  if (buildCounterProject < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.number, unittest.equals('foo'));
    checkQuota(o.quota);
  }
  buildCounterProject--;
}

buildUnnamed4184() {
  var o = new core.List<api.DnsKeySpec>();
  o.add(buildDnsKeySpec());
  o.add(buildDnsKeySpec());
  return o;
}

checkUnnamed4184(core.List<api.DnsKeySpec> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDnsKeySpec(o[0]);
  checkDnsKeySpec(o[1]);
}

core.int buildCounterQuota = 0;
buildQuota() {
  var o = new api.Quota();
  buildCounterQuota++;
  if (buildCounterQuota < 3) {
    o.dnsKeysPerManagedZone = 42;
    o.kind = "foo";
    o.managedZones = 42;
    o.resourceRecordsPerRrset = 42;
    o.rrsetAdditionsPerChange = 42;
    o.rrsetDeletionsPerChange = 42;
    o.rrsetsPerManagedZone = 42;
    o.totalRrdataSizePerChange = 42;
    o.whitelistedKeySpecs = buildUnnamed4184();
  }
  buildCounterQuota--;
  return o;
}

checkQuota(api.Quota o) {
  buildCounterQuota++;
  if (buildCounterQuota < 3) {
    unittest.expect(o.dnsKeysPerManagedZone, unittest.equals(42));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.managedZones, unittest.equals(42));
    unittest.expect(o.resourceRecordsPerRrset, unittest.equals(42));
    unittest.expect(o.rrsetAdditionsPerChange, unittest.equals(42));
    unittest.expect(o.rrsetDeletionsPerChange, unittest.equals(42));
    unittest.expect(o.rrsetsPerManagedZone, unittest.equals(42));
    unittest.expect(o.totalRrdataSizePerChange, unittest.equals(42));
    checkUnnamed4184(o.whitelistedKeySpecs);
  }
  buildCounterQuota--;
}

buildUnnamed4185() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed4185(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed4186() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed4186(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterResourceRecordSet = 0;
buildResourceRecordSet() {
  var o = new api.ResourceRecordSet();
  buildCounterResourceRecordSet++;
  if (buildCounterResourceRecordSet < 3) {
    o.kind = "foo";
    o.name = "foo";
    o.rrdatas = buildUnnamed4185();
    o.signatureRrdatas = buildUnnamed4186();
    o.ttl = 42;
    o.type = "foo";
  }
  buildCounterResourceRecordSet--;
  return o;
}

checkResourceRecordSet(api.ResourceRecordSet o) {
  buildCounterResourceRecordSet++;
  if (buildCounterResourceRecordSet < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    checkUnnamed4185(o.rrdatas);
    checkUnnamed4186(o.signatureRrdatas);
    unittest.expect(o.ttl, unittest.equals(42));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterResourceRecordSet--;
}

buildUnnamed4187() {
  var o = new core.List<api.ResourceRecordSet>();
  o.add(buildResourceRecordSet());
  o.add(buildResourceRecordSet());
  return o;
}

checkUnnamed4187(core.List<api.ResourceRecordSet> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkResourceRecordSet(o[0]);
  checkResourceRecordSet(o[1]);
}

core.int buildCounterResourceRecordSetsListResponse = 0;
buildResourceRecordSetsListResponse() {
  var o = new api.ResourceRecordSetsListResponse();
  buildCounterResourceRecordSetsListResponse++;
  if (buildCounterResourceRecordSetsListResponse < 3) {
    o.header = buildResponseHeader();
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.rrsets = buildUnnamed4187();
  }
  buildCounterResourceRecordSetsListResponse--;
  return o;
}

checkResourceRecordSetsListResponse(api.ResourceRecordSetsListResponse o) {
  buildCounterResourceRecordSetsListResponse++;
  if (buildCounterResourceRecordSetsListResponse < 3) {
    checkResponseHeader(o.header);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed4187(o.rrsets);
  }
  buildCounterResourceRecordSetsListResponse--;
}

core.int buildCounterResponseHeader = 0;
buildResponseHeader() {
  var o = new api.ResponseHeader();
  buildCounterResponseHeader++;
  if (buildCounterResponseHeader < 3) {
    o.operationId = "foo";
  }
  buildCounterResponseHeader--;
  return o;
}

checkResponseHeader(api.ResponseHeader o) {
  buildCounterResponseHeader++;
  if (buildCounterResponseHeader < 3) {
    unittest.expect(o.operationId, unittest.equals('foo'));
  }
  buildCounterResponseHeader--;
}

main() {
  unittest.group("obj-schema-Change", () {
    unittest.test("to-json--from-json", () {
      var o = buildChange();
      var od = new api.Change.fromJson(o.toJson());
      checkChange(od);
    });
  });

  unittest.group("obj-schema-ChangesListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildChangesListResponse();
      var od = new api.ChangesListResponse.fromJson(o.toJson());
      checkChangesListResponse(od);
    });
  });

  unittest.group("obj-schema-DnsKey", () {
    unittest.test("to-json--from-json", () {
      var o = buildDnsKey();
      var od = new api.DnsKey.fromJson(o.toJson());
      checkDnsKey(od);
    });
  });

  unittest.group("obj-schema-DnsKeyDigest", () {
    unittest.test("to-json--from-json", () {
      var o = buildDnsKeyDigest();
      var od = new api.DnsKeyDigest.fromJson(o.toJson());
      checkDnsKeyDigest(od);
    });
  });

  unittest.group("obj-schema-DnsKeySpec", () {
    unittest.test("to-json--from-json", () {
      var o = buildDnsKeySpec();
      var od = new api.DnsKeySpec.fromJson(o.toJson());
      checkDnsKeySpec(od);
    });
  });

  unittest.group("obj-schema-DnsKeysListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildDnsKeysListResponse();
      var od = new api.DnsKeysListResponse.fromJson(o.toJson());
      checkDnsKeysListResponse(od);
    });
  });

  unittest.group("obj-schema-ManagedZone", () {
    unittest.test("to-json--from-json", () {
      var o = buildManagedZone();
      var od = new api.ManagedZone.fromJson(o.toJson());
      checkManagedZone(od);
    });
  });

  unittest.group("obj-schema-ManagedZoneDnsSecConfig", () {
    unittest.test("to-json--from-json", () {
      var o = buildManagedZoneDnsSecConfig();
      var od = new api.ManagedZoneDnsSecConfig.fromJson(o.toJson());
      checkManagedZoneDnsSecConfig(od);
    });
  });

  unittest.group("obj-schema-ManagedZoneOperationsListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildManagedZoneOperationsListResponse();
      var od = new api.ManagedZoneOperationsListResponse.fromJson(o.toJson());
      checkManagedZoneOperationsListResponse(od);
    });
  });

  unittest.group("obj-schema-ManagedZonesListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildManagedZonesListResponse();
      var od = new api.ManagedZonesListResponse.fromJson(o.toJson());
      checkManagedZonesListResponse(od);
    });
  });

  unittest.group("obj-schema-Operation", () {
    unittest.test("to-json--from-json", () {
      var o = buildOperation();
      var od = new api.Operation.fromJson(o.toJson());
      checkOperation(od);
    });
  });

  unittest.group("obj-schema-OperationDnsKeyContext", () {
    unittest.test("to-json--from-json", () {
      var o = buildOperationDnsKeyContext();
      var od = new api.OperationDnsKeyContext.fromJson(o.toJson());
      checkOperationDnsKeyContext(od);
    });
  });

  unittest.group("obj-schema-OperationManagedZoneContext", () {
    unittest.test("to-json--from-json", () {
      var o = buildOperationManagedZoneContext();
      var od = new api.OperationManagedZoneContext.fromJson(o.toJson());
      checkOperationManagedZoneContext(od);
    });
  });

  unittest.group("obj-schema-Project", () {
    unittest.test("to-json--from-json", () {
      var o = buildProject();
      var od = new api.Project.fromJson(o.toJson());
      checkProject(od);
    });
  });

  unittest.group("obj-schema-Quota", () {
    unittest.test("to-json--from-json", () {
      var o = buildQuota();
      var od = new api.Quota.fromJson(o.toJson());
      checkQuota(od);
    });
  });

  unittest.group("obj-schema-ResourceRecordSet", () {
    unittest.test("to-json--from-json", () {
      var o = buildResourceRecordSet();
      var od = new api.ResourceRecordSet.fromJson(o.toJson());
      checkResourceRecordSet(od);
    });
  });

  unittest.group("obj-schema-ResourceRecordSetsListResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildResourceRecordSetsListResponse();
      var od = new api.ResourceRecordSetsListResponse.fromJson(o.toJson());
      checkResourceRecordSetsListResponse(od);
    });
  });

  unittest.group("obj-schema-ResponseHeader", () {
    unittest.test("to-json--from-json", () {
      var o = buildResponseHeader();
      var od = new api.ResponseHeader.fromJson(o.toJson());
      checkResponseHeader(od);
    });
  });

  unittest.group("resource-ChangesResourceApi", () {
    unittest.test("method--create", () {
      var mock = new HttpServerMock();
      api.ChangesResourceApi res = new api.DnsApi(mock).changes;
      var arg_request = buildChange();
      var arg_project = "foo";
      var arg_managedZone = "foo";
      var arg_clientOperationId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Change.fromJson(json);
        checkChange(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["clientOperationId"].first,
            unittest.equals(arg_clientOperationId));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildChange());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .create(arg_request, arg_project, arg_managedZone,
              clientOperationId: arg_clientOperationId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkChange(response);
      })));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.ChangesResourceApi res = new api.DnsApi(mock).changes;
      var arg_project = "foo";
      var arg_managedZone = "foo";
      var arg_changeId = "foo";
      var arg_clientOperationId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["clientOperationId"].first,
            unittest.equals(arg_clientOperationId));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildChange());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_project, arg_managedZone, arg_changeId,
              clientOperationId: arg_clientOperationId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkChange(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.ChangesResourceApi res = new api.DnsApi(mock).changes;
      var arg_project = "foo";
      var arg_managedZone = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      var arg_sortBy = "foo";
      var arg_sortOrder = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(core.int.parse(queryMap["maxResults"].first),
            unittest.equals(arg_maxResults));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["sortBy"].first, unittest.equals(arg_sortBy));
        unittest.expect(
            queryMap["sortOrder"].first, unittest.equals(arg_sortOrder));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildChangesListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_project, arg_managedZone,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              sortBy: arg_sortBy,
              sortOrder: arg_sortOrder,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkChangesListResponse(response);
      })));
    });
  });

  unittest.group("resource-DnsKeysResourceApi", () {
    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.DnsKeysResourceApi res = new api.DnsApi(mock).dnsKeys;
      var arg_project = "foo";
      var arg_managedZone = "foo";
      var arg_dnsKeyId = "foo";
      var arg_clientOperationId = "foo";
      var arg_digestType = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["clientOperationId"].first,
            unittest.equals(arg_clientOperationId));
        unittest.expect(
            queryMap["digestType"].first, unittest.equals(arg_digestType));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildDnsKey());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_project, arg_managedZone, arg_dnsKeyId,
              clientOperationId: arg_clientOperationId,
              digestType: arg_digestType,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkDnsKey(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.DnsKeysResourceApi res = new api.DnsApi(mock).dnsKeys;
      var arg_project = "foo";
      var arg_managedZone = "foo";
      var arg_digestType = "foo";
      var arg_maxResults = 42;
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
        unittest.expect(
            queryMap["digestType"].first, unittest.equals(arg_digestType));
        unittest.expect(core.int.parse(queryMap["maxResults"].first),
            unittest.equals(arg_maxResults));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildDnsKeysListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_project, arg_managedZone,
              digestType: arg_digestType,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkDnsKeysListResponse(response);
      })));
    });
  });

  unittest.group("resource-ManagedZoneOperationsResourceApi", () {
    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.ManagedZoneOperationsResourceApi res =
          new api.DnsApi(mock).managedZoneOperations;
      var arg_project = "foo";
      var arg_managedZone = "foo";
      var arg_operation = "foo";
      var arg_clientOperationId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["clientOperationId"].first,
            unittest.equals(arg_clientOperationId));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_project, arg_managedZone, arg_operation,
              clientOperationId: arg_clientOperationId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.ManagedZoneOperationsResourceApi res =
          new api.DnsApi(mock).managedZoneOperations;
      var arg_project = "foo";
      var arg_managedZone = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      var arg_sortBy = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(core.int.parse(queryMap["maxResults"].first),
            unittest.equals(arg_maxResults));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["sortBy"].first, unittest.equals(arg_sortBy));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp =
            convert.json.encode(buildManagedZoneOperationsListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_project, arg_managedZone,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              sortBy: arg_sortBy,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkManagedZoneOperationsListResponse(response);
      })));
    });
  });

  unittest.group("resource-ManagedZonesResourceApi", () {
    unittest.test("method--create", () {
      var mock = new HttpServerMock();
      api.ManagedZonesResourceApi res = new api.DnsApi(mock).managedZones;
      var arg_request = buildManagedZone();
      var arg_project = "foo";
      var arg_clientOperationId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.ManagedZone.fromJson(json);
        checkManagedZone(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["clientOperationId"].first,
            unittest.equals(arg_clientOperationId));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildManagedZone());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .create(arg_request, arg_project,
              clientOperationId: arg_clientOperationId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkManagedZone(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.ManagedZonesResourceApi res = new api.DnsApi(mock).managedZones;
      var arg_project = "foo";
      var arg_managedZone = "foo";
      var arg_clientOperationId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["clientOperationId"].first,
            unittest.equals(arg_clientOperationId));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_project, arg_managedZone,
              clientOperationId: arg_clientOperationId, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.ManagedZonesResourceApi res = new api.DnsApi(mock).managedZones;
      var arg_project = "foo";
      var arg_managedZone = "foo";
      var arg_clientOperationId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["clientOperationId"].first,
            unittest.equals(arg_clientOperationId));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildManagedZone());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_project, arg_managedZone,
              clientOperationId: arg_clientOperationId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkManagedZone(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.ManagedZonesResourceApi res = new api.DnsApi(mock).managedZones;
      var arg_project = "foo";
      var arg_dnsName = "foo";
      var arg_maxResults = 42;
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
        unittest.expect(
            queryMap["dnsName"].first, unittest.equals(arg_dnsName));
        unittest.expect(core.int.parse(queryMap["maxResults"].first),
            unittest.equals(arg_maxResults));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildManagedZonesListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_project,
              dnsName: arg_dnsName,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkManagedZonesListResponse(response);
      })));
    });

    unittest.test("method--patch", () {
      var mock = new HttpServerMock();
      api.ManagedZonesResourceApi res = new api.DnsApi(mock).managedZones;
      var arg_request = buildManagedZone();
      var arg_project = "foo";
      var arg_managedZone = "foo";
      var arg_clientOperationId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.ManagedZone.fromJson(json);
        checkManagedZone(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["clientOperationId"].first,
            unittest.equals(arg_clientOperationId));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .patch(arg_request, arg_project, arg_managedZone,
              clientOperationId: arg_clientOperationId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkOperation(response);
      })));
    });

    unittest.test("method--update", () {
      var mock = new HttpServerMock();
      api.ManagedZonesResourceApi res = new api.DnsApi(mock).managedZones;
      var arg_request = buildManagedZone();
      var arg_project = "foo";
      var arg_managedZone = "foo";
      var arg_clientOperationId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.ManagedZone.fromJson(json);
        checkManagedZone(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["clientOperationId"].first,
            unittest.equals(arg_clientOperationId));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .update(arg_request, arg_project, arg_managedZone,
              clientOperationId: arg_clientOperationId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkOperation(response);
      })));
    });
  });

  unittest.group("resource-ProjectsResourceApi", () {
    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.ProjectsResourceApi res = new api.DnsApi(mock).projects;
      var arg_project = "foo";
      var arg_clientOperationId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(queryMap["clientOperationId"].first,
            unittest.equals(arg_clientOperationId));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildProject());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_project,
              clientOperationId: arg_clientOperationId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkProject(response);
      })));
    });
  });

  unittest.group("resource-ResourceRecordSetsResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.ResourceRecordSetsResourceApi res =
          new api.DnsApi(mock).resourceRecordSets;
      var arg_project = "foo";
      var arg_managedZone = "foo";
      var arg_maxResults = 42;
      var arg_name = "foo";
      var arg_pageToken = "foo";
      var arg_type = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;

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
        unittest.expect(core.int.parse(queryMap["maxResults"].first),
            unittest.equals(arg_maxResults));
        unittest.expect(queryMap["name"].first, unittest.equals(arg_name));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["type"].first, unittest.equals(arg_type));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildResourceRecordSetsListResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_project, arg_managedZone,
              maxResults: arg_maxResults,
              name: arg_name,
              pageToken: arg_pageToken,
              type: arg_type,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkResourceRecordSetsListResponse(response);
      })));
    });
  });
}
