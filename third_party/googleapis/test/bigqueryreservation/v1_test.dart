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
import 'package:googleapis/bigqueryreservation/v1.dart' as api;

import '../test_shared.dart';

core.int buildCounterAssignment = 0;
api.Assignment buildAssignment() {
  var o = api.Assignment();
  buildCounterAssignment++;
  if (buildCounterAssignment < 3) {
    o.assignee = 'foo';
    o.jobType = 'foo';
    o.name = 'foo';
    o.state = 'foo';
  }
  buildCounterAssignment--;
  return o;
}

void checkAssignment(api.Assignment o) {
  buildCounterAssignment++;
  if (buildCounterAssignment < 3) {
    unittest.expect(
      o.assignee!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.jobType!,
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
  buildCounterAssignment--;
}

core.int buildCounterBiReservation = 0;
api.BiReservation buildBiReservation() {
  var o = api.BiReservation();
  buildCounterBiReservation++;
  if (buildCounterBiReservation < 3) {
    o.name = 'foo';
    o.size = 'foo';
    o.updateTime = 'foo';
  }
  buildCounterBiReservation--;
  return o;
}

void checkBiReservation(api.BiReservation o) {
  buildCounterBiReservation++;
  if (buildCounterBiReservation < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.size!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.updateTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterBiReservation--;
}

core.int buildCounterCapacityCommitment = 0;
api.CapacityCommitment buildCapacityCommitment() {
  var o = api.CapacityCommitment();
  buildCounterCapacityCommitment++;
  if (buildCounterCapacityCommitment < 3) {
    o.commitmentEndTime = 'foo';
    o.commitmentStartTime = 'foo';
    o.failureStatus = buildStatus();
    o.name = 'foo';
    o.plan = 'foo';
    o.renewalPlan = 'foo';
    o.slotCount = 'foo';
    o.state = 'foo';
  }
  buildCounterCapacityCommitment--;
  return o;
}

void checkCapacityCommitment(api.CapacityCommitment o) {
  buildCounterCapacityCommitment++;
  if (buildCounterCapacityCommitment < 3) {
    unittest.expect(
      o.commitmentEndTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.commitmentStartTime!,
      unittest.equals('foo'),
    );
    checkStatus(o.failureStatus! as api.Status);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.plan!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.renewalPlan!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.slotCount!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
  }
  buildCounterCapacityCommitment--;
}

core.int buildCounterCreateSlotPoolMetadata = 0;
api.CreateSlotPoolMetadata buildCreateSlotPoolMetadata() {
  var o = api.CreateSlotPoolMetadata();
  buildCounterCreateSlotPoolMetadata++;
  if (buildCounterCreateSlotPoolMetadata < 3) {
    o.slotPool = 'foo';
  }
  buildCounterCreateSlotPoolMetadata--;
  return o;
}

void checkCreateSlotPoolMetadata(api.CreateSlotPoolMetadata o) {
  buildCounterCreateSlotPoolMetadata++;
  if (buildCounterCreateSlotPoolMetadata < 3) {
    unittest.expect(
      o.slotPool!,
      unittest.equals('foo'),
    );
  }
  buildCounterCreateSlotPoolMetadata--;
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

core.List<api.Assignment> buildUnnamed5386() {
  var o = <api.Assignment>[];
  o.add(buildAssignment());
  o.add(buildAssignment());
  return o;
}

void checkUnnamed5386(core.List<api.Assignment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAssignment(o[0] as api.Assignment);
  checkAssignment(o[1] as api.Assignment);
}

core.int buildCounterListAssignmentsResponse = 0;
api.ListAssignmentsResponse buildListAssignmentsResponse() {
  var o = api.ListAssignmentsResponse();
  buildCounterListAssignmentsResponse++;
  if (buildCounterListAssignmentsResponse < 3) {
    o.assignments = buildUnnamed5386();
    o.nextPageToken = 'foo';
  }
  buildCounterListAssignmentsResponse--;
  return o;
}

void checkListAssignmentsResponse(api.ListAssignmentsResponse o) {
  buildCounterListAssignmentsResponse++;
  if (buildCounterListAssignmentsResponse < 3) {
    checkUnnamed5386(o.assignments!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterListAssignmentsResponse--;
}

core.List<api.CapacityCommitment> buildUnnamed5387() {
  var o = <api.CapacityCommitment>[];
  o.add(buildCapacityCommitment());
  o.add(buildCapacityCommitment());
  return o;
}

void checkUnnamed5387(core.List<api.CapacityCommitment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCapacityCommitment(o[0] as api.CapacityCommitment);
  checkCapacityCommitment(o[1] as api.CapacityCommitment);
}

core.int buildCounterListCapacityCommitmentsResponse = 0;
api.ListCapacityCommitmentsResponse buildListCapacityCommitmentsResponse() {
  var o = api.ListCapacityCommitmentsResponse();
  buildCounterListCapacityCommitmentsResponse++;
  if (buildCounterListCapacityCommitmentsResponse < 3) {
    o.capacityCommitments = buildUnnamed5387();
    o.nextPageToken = 'foo';
  }
  buildCounterListCapacityCommitmentsResponse--;
  return o;
}

void checkListCapacityCommitmentsResponse(
    api.ListCapacityCommitmentsResponse o) {
  buildCounterListCapacityCommitmentsResponse++;
  if (buildCounterListCapacityCommitmentsResponse < 3) {
    checkUnnamed5387(o.capacityCommitments!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterListCapacityCommitmentsResponse--;
}

core.List<api.Operation> buildUnnamed5388() {
  var o = <api.Operation>[];
  o.add(buildOperation());
  o.add(buildOperation());
  return o;
}

void checkUnnamed5388(core.List<api.Operation> o) {
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
    o.operations = buildUnnamed5388();
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
    checkUnnamed5388(o.operations!);
  }
  buildCounterListOperationsResponse--;
}

core.List<api.Reservation> buildUnnamed5389() {
  var o = <api.Reservation>[];
  o.add(buildReservation());
  o.add(buildReservation());
  return o;
}

void checkUnnamed5389(core.List<api.Reservation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkReservation(o[0] as api.Reservation);
  checkReservation(o[1] as api.Reservation);
}

core.int buildCounterListReservationsResponse = 0;
api.ListReservationsResponse buildListReservationsResponse() {
  var o = api.ListReservationsResponse();
  buildCounterListReservationsResponse++;
  if (buildCounterListReservationsResponse < 3) {
    o.nextPageToken = 'foo';
    o.reservations = buildUnnamed5389();
  }
  buildCounterListReservationsResponse--;
  return o;
}

void checkListReservationsResponse(api.ListReservationsResponse o) {
  buildCounterListReservationsResponse++;
  if (buildCounterListReservationsResponse < 3) {
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
    checkUnnamed5389(o.reservations!);
  }
  buildCounterListReservationsResponse--;
}

core.List<core.String> buildUnnamed5390() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed5390(core.List<core.String> o) {
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

core.int buildCounterMergeCapacityCommitmentsRequest = 0;
api.MergeCapacityCommitmentsRequest buildMergeCapacityCommitmentsRequest() {
  var o = api.MergeCapacityCommitmentsRequest();
  buildCounterMergeCapacityCommitmentsRequest++;
  if (buildCounterMergeCapacityCommitmentsRequest < 3) {
    o.capacityCommitmentIds = buildUnnamed5390();
  }
  buildCounterMergeCapacityCommitmentsRequest--;
  return o;
}

void checkMergeCapacityCommitmentsRequest(
    api.MergeCapacityCommitmentsRequest o) {
  buildCounterMergeCapacityCommitmentsRequest++;
  if (buildCounterMergeCapacityCommitmentsRequest < 3) {
    checkUnnamed5390(o.capacityCommitmentIds!);
  }
  buildCounterMergeCapacityCommitmentsRequest--;
}

core.int buildCounterMoveAssignmentRequest = 0;
api.MoveAssignmentRequest buildMoveAssignmentRequest() {
  var o = api.MoveAssignmentRequest();
  buildCounterMoveAssignmentRequest++;
  if (buildCounterMoveAssignmentRequest < 3) {
    o.destinationId = 'foo';
  }
  buildCounterMoveAssignmentRequest--;
  return o;
}

void checkMoveAssignmentRequest(api.MoveAssignmentRequest o) {
  buildCounterMoveAssignmentRequest++;
  if (buildCounterMoveAssignmentRequest < 3) {
    unittest.expect(
      o.destinationId!,
      unittest.equals('foo'),
    );
  }
  buildCounterMoveAssignmentRequest--;
}

core.Map<core.String, core.Object> buildUnnamed5391() {
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

void checkUnnamed5391(core.Map<core.String, core.Object> o) {
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

core.Map<core.String, core.Object> buildUnnamed5392() {
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

void checkUnnamed5392(core.Map<core.String, core.Object> o) {
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
    o.metadata = buildUnnamed5391();
    o.name = 'foo';
    o.response = buildUnnamed5392();
  }
  buildCounterOperation--;
  return o;
}

void checkOperation(api.Operation o) {
  buildCounterOperation++;
  if (buildCounterOperation < 3) {
    unittest.expect(o.done!, unittest.isTrue);
    checkStatus(o.error! as api.Status);
    checkUnnamed5391(o.metadata!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed5392(o.response!);
  }
  buildCounterOperation--;
}

core.int buildCounterReservation = 0;
api.Reservation buildReservation() {
  var o = api.Reservation();
  buildCounterReservation++;
  if (buildCounterReservation < 3) {
    o.creationTime = 'foo';
    o.ignoreIdleSlots = true;
    o.name = 'foo';
    o.slotCapacity = 'foo';
    o.updateTime = 'foo';
  }
  buildCounterReservation--;
  return o;
}

void checkReservation(api.Reservation o) {
  buildCounterReservation++;
  if (buildCounterReservation < 3) {
    unittest.expect(
      o.creationTime!,
      unittest.equals('foo'),
    );
    unittest.expect(o.ignoreIdleSlots!, unittest.isTrue);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.slotCapacity!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.updateTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterReservation--;
}

core.List<api.Assignment> buildUnnamed5393() {
  var o = <api.Assignment>[];
  o.add(buildAssignment());
  o.add(buildAssignment());
  return o;
}

void checkUnnamed5393(core.List<api.Assignment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAssignment(o[0] as api.Assignment);
  checkAssignment(o[1] as api.Assignment);
}

core.int buildCounterSearchAllAssignmentsResponse = 0;
api.SearchAllAssignmentsResponse buildSearchAllAssignmentsResponse() {
  var o = api.SearchAllAssignmentsResponse();
  buildCounterSearchAllAssignmentsResponse++;
  if (buildCounterSearchAllAssignmentsResponse < 3) {
    o.assignments = buildUnnamed5393();
    o.nextPageToken = 'foo';
  }
  buildCounterSearchAllAssignmentsResponse--;
  return o;
}

void checkSearchAllAssignmentsResponse(api.SearchAllAssignmentsResponse o) {
  buildCounterSearchAllAssignmentsResponse++;
  if (buildCounterSearchAllAssignmentsResponse < 3) {
    checkUnnamed5393(o.assignments!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterSearchAllAssignmentsResponse--;
}

core.List<api.Assignment> buildUnnamed5394() {
  var o = <api.Assignment>[];
  o.add(buildAssignment());
  o.add(buildAssignment());
  return o;
}

void checkUnnamed5394(core.List<api.Assignment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAssignment(o[0] as api.Assignment);
  checkAssignment(o[1] as api.Assignment);
}

core.int buildCounterSearchAssignmentsResponse = 0;
api.SearchAssignmentsResponse buildSearchAssignmentsResponse() {
  var o = api.SearchAssignmentsResponse();
  buildCounterSearchAssignmentsResponse++;
  if (buildCounterSearchAssignmentsResponse < 3) {
    o.assignments = buildUnnamed5394();
    o.nextPageToken = 'foo';
  }
  buildCounterSearchAssignmentsResponse--;
  return o;
}

void checkSearchAssignmentsResponse(api.SearchAssignmentsResponse o) {
  buildCounterSearchAssignmentsResponse++;
  if (buildCounterSearchAssignmentsResponse < 3) {
    checkUnnamed5394(o.assignments!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterSearchAssignmentsResponse--;
}

core.int buildCounterSplitCapacityCommitmentRequest = 0;
api.SplitCapacityCommitmentRequest buildSplitCapacityCommitmentRequest() {
  var o = api.SplitCapacityCommitmentRequest();
  buildCounterSplitCapacityCommitmentRequest++;
  if (buildCounterSplitCapacityCommitmentRequest < 3) {
    o.slotCount = 'foo';
  }
  buildCounterSplitCapacityCommitmentRequest--;
  return o;
}

void checkSplitCapacityCommitmentRequest(api.SplitCapacityCommitmentRequest o) {
  buildCounterSplitCapacityCommitmentRequest++;
  if (buildCounterSplitCapacityCommitmentRequest < 3) {
    unittest.expect(
      o.slotCount!,
      unittest.equals('foo'),
    );
  }
  buildCounterSplitCapacityCommitmentRequest--;
}

core.int buildCounterSplitCapacityCommitmentResponse = 0;
api.SplitCapacityCommitmentResponse buildSplitCapacityCommitmentResponse() {
  var o = api.SplitCapacityCommitmentResponse();
  buildCounterSplitCapacityCommitmentResponse++;
  if (buildCounterSplitCapacityCommitmentResponse < 3) {
    o.first = buildCapacityCommitment();
    o.second = buildCapacityCommitment();
  }
  buildCounterSplitCapacityCommitmentResponse--;
  return o;
}

void checkSplitCapacityCommitmentResponse(
    api.SplitCapacityCommitmentResponse o) {
  buildCounterSplitCapacityCommitmentResponse++;
  if (buildCounterSplitCapacityCommitmentResponse < 3) {
    checkCapacityCommitment(o.first! as api.CapacityCommitment);
    checkCapacityCommitment(o.second! as api.CapacityCommitment);
  }
  buildCounterSplitCapacityCommitmentResponse--;
}

core.Map<core.String, core.Object> buildUnnamed5395() {
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

void checkUnnamed5395(core.Map<core.String, core.Object> o) {
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

core.List<core.Map<core.String, core.Object>> buildUnnamed5396() {
  var o = <core.Map<core.String, core.Object>>[];
  o.add(buildUnnamed5395());
  o.add(buildUnnamed5395());
  return o;
}

void checkUnnamed5396(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed5395(o[0]);
  checkUnnamed5395(o[1]);
}

core.int buildCounterStatus = 0;
api.Status buildStatus() {
  var o = api.Status();
  buildCounterStatus++;
  if (buildCounterStatus < 3) {
    o.code = 42;
    o.details = buildUnnamed5396();
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
    checkUnnamed5396(o.details!);
    unittest.expect(
      o.message!,
      unittest.equals('foo'),
    );
  }
  buildCounterStatus--;
}

void main() {
  unittest.group('obj-schema-Assignment', () {
    unittest.test('to-json--from-json', () async {
      var o = buildAssignment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Assignment.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkAssignment(od as api.Assignment);
    });
  });

  unittest.group('obj-schema-BiReservation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildBiReservation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.BiReservation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkBiReservation(od as api.BiReservation);
    });
  });

  unittest.group('obj-schema-CapacityCommitment', () {
    unittest.test('to-json--from-json', () async {
      var o = buildCapacityCommitment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.CapacityCommitment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkCapacityCommitment(od as api.CapacityCommitment);
    });
  });

  unittest.group('obj-schema-CreateSlotPoolMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildCreateSlotPoolMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.CreateSlotPoolMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkCreateSlotPoolMetadata(od as api.CreateSlotPoolMetadata);
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

  unittest.group('obj-schema-ListAssignmentsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildListAssignmentsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ListAssignmentsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkListAssignmentsResponse(od as api.ListAssignmentsResponse);
    });
  });

  unittest.group('obj-schema-ListCapacityCommitmentsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildListCapacityCommitmentsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ListCapacityCommitmentsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkListCapacityCommitmentsResponse(
          od as api.ListCapacityCommitmentsResponse);
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

  unittest.group('obj-schema-ListReservationsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildListReservationsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ListReservationsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkListReservationsResponse(od as api.ListReservationsResponse);
    });
  });

  unittest.group('obj-schema-MergeCapacityCommitmentsRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildMergeCapacityCommitmentsRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.MergeCapacityCommitmentsRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkMergeCapacityCommitmentsRequest(
          od as api.MergeCapacityCommitmentsRequest);
    });
  });

  unittest.group('obj-schema-MoveAssignmentRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildMoveAssignmentRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.MoveAssignmentRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkMoveAssignmentRequest(od as api.MoveAssignmentRequest);
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

  unittest.group('obj-schema-Reservation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildReservation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.Reservation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkReservation(od as api.Reservation);
    });
  });

  unittest.group('obj-schema-SearchAllAssignmentsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildSearchAllAssignmentsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.SearchAllAssignmentsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkSearchAllAssignmentsResponse(od as api.SearchAllAssignmentsResponse);
    });
  });

  unittest.group('obj-schema-SearchAssignmentsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildSearchAssignmentsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.SearchAssignmentsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkSearchAssignmentsResponse(od as api.SearchAssignmentsResponse);
    });
  });

  unittest.group('obj-schema-SplitCapacityCommitmentRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildSplitCapacityCommitmentRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.SplitCapacityCommitmentRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkSplitCapacityCommitmentRequest(
          od as api.SplitCapacityCommitmentRequest);
    });
  });

  unittest.group('obj-schema-SplitCapacityCommitmentResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildSplitCapacityCommitmentResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.SplitCapacityCommitmentResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkSplitCapacityCommitmentResponse(
          od as api.SplitCapacityCommitmentResponse);
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

  unittest.group('resource-OperationsResource', () {
    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.BigQueryReservationApi(mock).operations;
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

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.BigQueryReservationApi(mock).operations;
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
        var resp = convert.json.encode(buildListOperationsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_name,
          filter: arg_filter,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkListOperationsResponse(response as api.ListOperationsResponse);
    });
  });

  unittest.group('resource-ProjectsLocationsResource', () {
    unittest.test('method--getBiReservation', () async {
      var mock = HttpServerMock();
      var res = api.BigQueryReservationApi(mock).projects.locations;
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
        var resp = convert.json.encode(buildBiReservation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.getBiReservation(arg_name, $fields: arg_$fields);
      checkBiReservation(response as api.BiReservation);
    });

    unittest.test('method--searchAllAssignments', () async {
      var mock = HttpServerMock();
      var res = api.BigQueryReservationApi(mock).projects.locations;
      var arg_parent = 'foo';
      var arg_pageSize = 42;
      var arg_pageToken = 'foo';
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
          core.int.parse(queryMap["pageSize"]!.first),
          unittest.equals(arg_pageSize),
        );
        unittest.expect(
          queryMap["pageToken"]!.first,
          unittest.equals(arg_pageToken),
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
        var resp = convert.json.encode(buildSearchAllAssignmentsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.searchAllAssignments(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          query: arg_query,
          $fields: arg_$fields);
      checkSearchAllAssignmentsResponse(
          response as api.SearchAllAssignmentsResponse);
    });

    unittest.test('method--searchAssignments', () async {
      var mock = HttpServerMock();
      var res = api.BigQueryReservationApi(mock).projects.locations;
      var arg_parent = 'foo';
      var arg_pageSize = 42;
      var arg_pageToken = 'foo';
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
          core.int.parse(queryMap["pageSize"]!.first),
          unittest.equals(arg_pageSize),
        );
        unittest.expect(
          queryMap["pageToken"]!.first,
          unittest.equals(arg_pageToken),
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
        var resp = convert.json.encode(buildSearchAssignmentsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.searchAssignments(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          query: arg_query,
          $fields: arg_$fields);
      checkSearchAssignmentsResponse(response as api.SearchAssignmentsResponse);
    });

    unittest.test('method--updateBiReservation', () async {
      var mock = HttpServerMock();
      var res = api.BigQueryReservationApi(mock).projects.locations;
      var arg_request = buildBiReservation();
      var arg_name = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.BiReservation.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkBiReservation(obj as api.BiReservation);

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
        var resp = convert.json.encode(buildBiReservation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.updateBiReservation(arg_request, arg_name,
          updateMask: arg_updateMask, $fields: arg_$fields);
      checkBiReservation(response as api.BiReservation);
    });
  });

  unittest.group('resource-ProjectsLocationsCapacityCommitmentsResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.BigQueryReservationApi(mock)
          .projects
          .locations
          .capacityCommitments;
      var arg_request = buildCapacityCommitment();
      var arg_parent = 'foo';
      var arg_enforceSingleAdminProjectPerOrg = true;
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.CapacityCommitment.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkCapacityCommitment(obj as api.CapacityCommitment);

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
          queryMap["enforceSingleAdminProjectPerOrg"]!.first,
          unittest.equals("$arg_enforceSingleAdminProjectPerOrg"),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildCapacityCommitment());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.create(arg_request, arg_parent,
          enforceSingleAdminProjectPerOrg: arg_enforceSingleAdminProjectPerOrg,
          $fields: arg_$fields);
      checkCapacityCommitment(response as api.CapacityCommitment);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.BigQueryReservationApi(mock)
          .projects
          .locations
          .capacityCommitments;
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
      var res = api.BigQueryReservationApi(mock)
          .projects
          .locations
          .capacityCommitments;
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
        var resp = convert.json.encode(buildCapacityCommitment());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkCapacityCommitment(response as api.CapacityCommitment);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.BigQueryReservationApi(mock)
          .projects
          .locations
          .capacityCommitments;
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
        var resp = convert.json.encode(buildListCapacityCommitmentsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkListCapacityCommitmentsResponse(
          response as api.ListCapacityCommitmentsResponse);
    });

    unittest.test('method--merge', () async {
      var mock = HttpServerMock();
      var res = api.BigQueryReservationApi(mock)
          .projects
          .locations
          .capacityCommitments;
      var arg_request = buildMergeCapacityCommitmentsRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.MergeCapacityCommitmentsRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkMergeCapacityCommitmentsRequest(
            obj as api.MergeCapacityCommitmentsRequest);

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
        var resp = convert.json.encode(buildCapacityCommitment());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.merge(arg_request, arg_parent, $fields: arg_$fields);
      checkCapacityCommitment(response as api.CapacityCommitment);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.BigQueryReservationApi(mock)
          .projects
          .locations
          .capacityCommitments;
      var arg_request = buildCapacityCommitment();
      var arg_name = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.CapacityCommitment.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkCapacityCommitment(obj as api.CapacityCommitment);

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
        var resp = convert.json.encode(buildCapacityCommitment());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          updateMask: arg_updateMask, $fields: arg_$fields);
      checkCapacityCommitment(response as api.CapacityCommitment);
    });

    unittest.test('method--split', () async {
      var mock = HttpServerMock();
      var res = api.BigQueryReservationApi(mock)
          .projects
          .locations
          .capacityCommitments;
      var arg_request = buildSplitCapacityCommitmentRequest();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.SplitCapacityCommitmentRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkSplitCapacityCommitmentRequest(
            obj as api.SplitCapacityCommitmentRequest);

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
        var resp = convert.json.encode(buildSplitCapacityCommitmentResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.split(arg_request, arg_name, $fields: arg_$fields);
      checkSplitCapacityCommitmentResponse(
          response as api.SplitCapacityCommitmentResponse);
    });
  });

  unittest.group('resource-ProjectsLocationsReservationsResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res =
          api.BigQueryReservationApi(mock).projects.locations.reservations;
      var arg_request = buildReservation();
      var arg_parent = 'foo';
      var arg_reservationId = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.Reservation.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkReservation(obj as api.Reservation);

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
          queryMap["reservationId"]!.first,
          unittest.equals(arg_reservationId),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildReservation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.create(arg_request, arg_parent,
          reservationId: arg_reservationId, $fields: arg_$fields);
      checkReservation(response as api.Reservation);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res =
          api.BigQueryReservationApi(mock).projects.locations.reservations;
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
      var res =
          api.BigQueryReservationApi(mock).projects.locations.reservations;
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
        var resp = convert.json.encode(buildReservation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkReservation(response as api.Reservation);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res =
          api.BigQueryReservationApi(mock).projects.locations.reservations;
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
        var resp = convert.json.encode(buildListReservationsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkListReservationsResponse(response as api.ListReservationsResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res =
          api.BigQueryReservationApi(mock).projects.locations.reservations;
      var arg_request = buildReservation();
      var arg_name = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.Reservation.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkReservation(obj as api.Reservation);

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
        var resp = convert.json.encode(buildReservation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          updateMask: arg_updateMask, $fields: arg_$fields);
      checkReservation(response as api.Reservation);
    });
  });

  unittest.group('resource-ProjectsLocationsReservationsAssignmentsResource',
      () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.BigQueryReservationApi(mock)
          .projects
          .locations
          .reservations
          .assignments;
      var arg_request = buildAssignment();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.Assignment.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkAssignment(obj as api.Assignment);

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
        var resp = convert.json.encode(buildAssignment());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkAssignment(response as api.Assignment);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.BigQueryReservationApi(mock)
          .projects
          .locations
          .reservations
          .assignments;
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

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.BigQueryReservationApi(mock)
          .projects
          .locations
          .reservations
          .assignments;
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
        var resp = convert.json.encode(buildListAssignmentsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkListAssignmentsResponse(response as api.ListAssignmentsResponse);
    });

    unittest.test('method--move', () async {
      var mock = HttpServerMock();
      var res = api.BigQueryReservationApi(mock)
          .projects
          .locations
          .reservations
          .assignments;
      var arg_request = buildMoveAssignmentRequest();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.MoveAssignmentRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkMoveAssignmentRequest(obj as api.MoveAssignmentRequest);

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
        var resp = convert.json.encode(buildAssignment());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.move(arg_request, arg_name, $fields: arg_$fields);
      checkAssignment(response as api.Assignment);
    });
  });
}
