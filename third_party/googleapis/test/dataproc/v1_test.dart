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
import 'package:googleapis/dataproc/v1.dart' as api;

import '../test_shared.dart';

core.int buildCounterAcceleratorConfig = 0;
api.AcceleratorConfig buildAcceleratorConfig() {
  var o = api.AcceleratorConfig();
  buildCounterAcceleratorConfig++;
  if (buildCounterAcceleratorConfig < 3) {
    o.acceleratorCount = 42;
    o.acceleratorTypeUri = 'foo';
  }
  buildCounterAcceleratorConfig--;
  return o;
}

void checkAcceleratorConfig(api.AcceleratorConfig o) {
  buildCounterAcceleratorConfig++;
  if (buildCounterAcceleratorConfig < 3) {
    unittest.expect(
      o.acceleratorCount!,
      unittest.equals(42),
    );
    unittest.expect(
      o.acceleratorTypeUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterAcceleratorConfig--;
}

core.int buildCounterAutoscalingConfig = 0;
api.AutoscalingConfig buildAutoscalingConfig() {
  var o = api.AutoscalingConfig();
  buildCounterAutoscalingConfig++;
  if (buildCounterAutoscalingConfig < 3) {
    o.policyUri = 'foo';
  }
  buildCounterAutoscalingConfig--;
  return o;
}

void checkAutoscalingConfig(api.AutoscalingConfig o) {
  buildCounterAutoscalingConfig++;
  if (buildCounterAutoscalingConfig < 3) {
    unittest.expect(
      o.policyUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterAutoscalingConfig--;
}

core.int buildCounterAutoscalingPolicy = 0;
api.AutoscalingPolicy buildAutoscalingPolicy() {
  var o = api.AutoscalingPolicy();
  buildCounterAutoscalingPolicy++;
  if (buildCounterAutoscalingPolicy < 3) {
    o.basicAlgorithm = buildBasicAutoscalingAlgorithm();
    o.id = 'foo';
    o.name = 'foo';
    o.secondaryWorkerConfig = buildInstanceGroupAutoscalingPolicyConfig();
    o.workerConfig = buildInstanceGroupAutoscalingPolicyConfig();
  }
  buildCounterAutoscalingPolicy--;
  return o;
}

void checkAutoscalingPolicy(api.AutoscalingPolicy o) {
  buildCounterAutoscalingPolicy++;
  if (buildCounterAutoscalingPolicy < 3) {
    checkBasicAutoscalingAlgorithm(
        o.basicAlgorithm! as api.BasicAutoscalingAlgorithm);
    unittest.expect(
      o.id!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkInstanceGroupAutoscalingPolicyConfig(
        o.secondaryWorkerConfig! as api.InstanceGroupAutoscalingPolicyConfig);
    checkInstanceGroupAutoscalingPolicyConfig(
        o.workerConfig! as api.InstanceGroupAutoscalingPolicyConfig);
  }
  buildCounterAutoscalingPolicy--;
}

core.int buildCounterBasicAutoscalingAlgorithm = 0;
api.BasicAutoscalingAlgorithm buildBasicAutoscalingAlgorithm() {
  var o = api.BasicAutoscalingAlgorithm();
  buildCounterBasicAutoscalingAlgorithm++;
  if (buildCounterBasicAutoscalingAlgorithm < 3) {
    o.cooldownPeriod = 'foo';
    o.yarnConfig = buildBasicYarnAutoscalingConfig();
  }
  buildCounterBasicAutoscalingAlgorithm--;
  return o;
}

void checkBasicAutoscalingAlgorithm(api.BasicAutoscalingAlgorithm o) {
  buildCounterBasicAutoscalingAlgorithm++;
  if (buildCounterBasicAutoscalingAlgorithm < 3) {
    unittest.expect(
      o.cooldownPeriod!,
      unittest.equals('foo'),
    );
    checkBasicYarnAutoscalingConfig(
        o.yarnConfig! as api.BasicYarnAutoscalingConfig);
  }
  buildCounterBasicAutoscalingAlgorithm--;
}

core.int buildCounterBasicYarnAutoscalingConfig = 0;
api.BasicYarnAutoscalingConfig buildBasicYarnAutoscalingConfig() {
  var o = api.BasicYarnAutoscalingConfig();
  buildCounterBasicYarnAutoscalingConfig++;
  if (buildCounterBasicYarnAutoscalingConfig < 3) {
    o.gracefulDecommissionTimeout = 'foo';
    o.scaleDownFactor = 42.0;
    o.scaleDownMinWorkerFraction = 42.0;
    o.scaleUpFactor = 42.0;
    o.scaleUpMinWorkerFraction = 42.0;
  }
  buildCounterBasicYarnAutoscalingConfig--;
  return o;
}

void checkBasicYarnAutoscalingConfig(api.BasicYarnAutoscalingConfig o) {
  buildCounterBasicYarnAutoscalingConfig++;
  if (buildCounterBasicYarnAutoscalingConfig < 3) {
    unittest.expect(
      o.gracefulDecommissionTimeout!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.scaleDownFactor!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.scaleDownMinWorkerFraction!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.scaleUpFactor!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.scaleUpMinWorkerFraction!,
      unittest.equals(42.0),
    );
  }
  buildCounterBasicYarnAutoscalingConfig--;
}

core.List<core.String> buildUnnamed2457() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2457(core.List<core.String> o) {
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

core.int buildCounterBinding = 0;
api.Binding buildBinding() {
  var o = api.Binding();
  buildCounterBinding++;
  if (buildCounterBinding < 3) {
    o.condition = buildExpr();
    o.members = buildUnnamed2457();
    o.role = 'foo';
  }
  buildCounterBinding--;
  return o;
}

void checkBinding(api.Binding o) {
  buildCounterBinding++;
  if (buildCounterBinding < 3) {
    checkExpr(o.condition! as api.Expr);
    checkUnnamed2457(o.members!);
    unittest.expect(
      o.role!,
      unittest.equals('foo'),
    );
  }
  buildCounterBinding--;
}

core.int buildCounterCancelJobRequest = 0;
api.CancelJobRequest buildCancelJobRequest() {
  var o = api.CancelJobRequest();
  buildCounterCancelJobRequest++;
  if (buildCounterCancelJobRequest < 3) {}
  buildCounterCancelJobRequest--;
  return o;
}

void checkCancelJobRequest(api.CancelJobRequest o) {
  buildCounterCancelJobRequest++;
  if (buildCounterCancelJobRequest < 3) {}
  buildCounterCancelJobRequest--;
}

core.Map<core.String, core.String> buildUnnamed2458() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2458(core.Map<core.String, core.String> o) {
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

core.List<api.ClusterStatus> buildUnnamed2459() {
  var o = <api.ClusterStatus>[];
  o.add(buildClusterStatus());
  o.add(buildClusterStatus());
  return o;
}

void checkUnnamed2459(core.List<api.ClusterStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkClusterStatus(o[0] as api.ClusterStatus);
  checkClusterStatus(o[1] as api.ClusterStatus);
}

core.int buildCounterCluster = 0;
api.Cluster buildCluster() {
  var o = api.Cluster();
  buildCounterCluster++;
  if (buildCounterCluster < 3) {
    o.clusterName = 'foo';
    o.clusterUuid = 'foo';
    o.config = buildClusterConfig();
    o.labels = buildUnnamed2458();
    o.metrics = buildClusterMetrics();
    o.projectId = 'foo';
    o.status = buildClusterStatus();
    o.statusHistory = buildUnnamed2459();
  }
  buildCounterCluster--;
  return o;
}

void checkCluster(api.Cluster o) {
  buildCounterCluster++;
  if (buildCounterCluster < 3) {
    unittest.expect(
      o.clusterName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.clusterUuid!,
      unittest.equals('foo'),
    );
    checkClusterConfig(o.config! as api.ClusterConfig);
    checkUnnamed2458(o.labels!);
    checkClusterMetrics(o.metrics! as api.ClusterMetrics);
    unittest.expect(
      o.projectId!,
      unittest.equals('foo'),
    );
    checkClusterStatus(o.status! as api.ClusterStatus);
    checkUnnamed2459(o.statusHistory!);
  }
  buildCounterCluster--;
}

core.List<api.NodeInitializationAction> buildUnnamed2460() {
  var o = <api.NodeInitializationAction>[];
  o.add(buildNodeInitializationAction());
  o.add(buildNodeInitializationAction());
  return o;
}

void checkUnnamed2460(core.List<api.NodeInitializationAction> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkNodeInitializationAction(o[0] as api.NodeInitializationAction);
  checkNodeInitializationAction(o[1] as api.NodeInitializationAction);
}

core.int buildCounterClusterConfig = 0;
api.ClusterConfig buildClusterConfig() {
  var o = api.ClusterConfig();
  buildCounterClusterConfig++;
  if (buildCounterClusterConfig < 3) {
    o.autoscalingConfig = buildAutoscalingConfig();
    o.configBucket = 'foo';
    o.encryptionConfig = buildEncryptionConfig();
    o.endpointConfig = buildEndpointConfig();
    o.gceClusterConfig = buildGceClusterConfig();
    o.initializationActions = buildUnnamed2460();
    o.lifecycleConfig = buildLifecycleConfig();
    o.masterConfig = buildInstanceGroupConfig();
    o.metastoreConfig = buildMetastoreConfig();
    o.secondaryWorkerConfig = buildInstanceGroupConfig();
    o.securityConfig = buildSecurityConfig();
    o.softwareConfig = buildSoftwareConfig();
    o.tempBucket = 'foo';
    o.workerConfig = buildInstanceGroupConfig();
  }
  buildCounterClusterConfig--;
  return o;
}

void checkClusterConfig(api.ClusterConfig o) {
  buildCounterClusterConfig++;
  if (buildCounterClusterConfig < 3) {
    checkAutoscalingConfig(o.autoscalingConfig! as api.AutoscalingConfig);
    unittest.expect(
      o.configBucket!,
      unittest.equals('foo'),
    );
    checkEncryptionConfig(o.encryptionConfig! as api.EncryptionConfig);
    checkEndpointConfig(o.endpointConfig! as api.EndpointConfig);
    checkGceClusterConfig(o.gceClusterConfig! as api.GceClusterConfig);
    checkUnnamed2460(o.initializationActions!);
    checkLifecycleConfig(o.lifecycleConfig! as api.LifecycleConfig);
    checkInstanceGroupConfig(o.masterConfig! as api.InstanceGroupConfig);
    checkMetastoreConfig(o.metastoreConfig! as api.MetastoreConfig);
    checkInstanceGroupConfig(
        o.secondaryWorkerConfig! as api.InstanceGroupConfig);
    checkSecurityConfig(o.securityConfig! as api.SecurityConfig);
    checkSoftwareConfig(o.softwareConfig! as api.SoftwareConfig);
    unittest.expect(
      o.tempBucket!,
      unittest.equals('foo'),
    );
    checkInstanceGroupConfig(o.workerConfig! as api.InstanceGroupConfig);
  }
  buildCounterClusterConfig--;
}

core.Map<core.String, core.String> buildUnnamed2461() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2461(core.Map<core.String, core.String> o) {
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

core.Map<core.String, core.String> buildUnnamed2462() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2462(core.Map<core.String, core.String> o) {
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

core.int buildCounterClusterMetrics = 0;
api.ClusterMetrics buildClusterMetrics() {
  var o = api.ClusterMetrics();
  buildCounterClusterMetrics++;
  if (buildCounterClusterMetrics < 3) {
    o.hdfsMetrics = buildUnnamed2461();
    o.yarnMetrics = buildUnnamed2462();
  }
  buildCounterClusterMetrics--;
  return o;
}

void checkClusterMetrics(api.ClusterMetrics o) {
  buildCounterClusterMetrics++;
  if (buildCounterClusterMetrics < 3) {
    checkUnnamed2461(o.hdfsMetrics!);
    checkUnnamed2462(o.yarnMetrics!);
  }
  buildCounterClusterMetrics--;
}

core.int buildCounterClusterOperation = 0;
api.ClusterOperation buildClusterOperation() {
  var o = api.ClusterOperation();
  buildCounterClusterOperation++;
  if (buildCounterClusterOperation < 3) {
    o.done = true;
    o.error = 'foo';
    o.operationId = 'foo';
  }
  buildCounterClusterOperation--;
  return o;
}

void checkClusterOperation(api.ClusterOperation o) {
  buildCounterClusterOperation++;
  if (buildCounterClusterOperation < 3) {
    unittest.expect(o.done!, unittest.isTrue);
    unittest.expect(
      o.error!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.operationId!,
      unittest.equals('foo'),
    );
  }
  buildCounterClusterOperation--;
}

core.Map<core.String, core.String> buildUnnamed2463() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2463(core.Map<core.String, core.String> o) {
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

core.List<api.ClusterOperationStatus> buildUnnamed2464() {
  var o = <api.ClusterOperationStatus>[];
  o.add(buildClusterOperationStatus());
  o.add(buildClusterOperationStatus());
  return o;
}

void checkUnnamed2464(core.List<api.ClusterOperationStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkClusterOperationStatus(o[0] as api.ClusterOperationStatus);
  checkClusterOperationStatus(o[1] as api.ClusterOperationStatus);
}

core.List<core.String> buildUnnamed2465() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2465(core.List<core.String> o) {
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

core.int buildCounterClusterOperationMetadata = 0;
api.ClusterOperationMetadata buildClusterOperationMetadata() {
  var o = api.ClusterOperationMetadata();
  buildCounterClusterOperationMetadata++;
  if (buildCounterClusterOperationMetadata < 3) {
    o.clusterName = 'foo';
    o.clusterUuid = 'foo';
    o.description = 'foo';
    o.labels = buildUnnamed2463();
    o.operationType = 'foo';
    o.status = buildClusterOperationStatus();
    o.statusHistory = buildUnnamed2464();
    o.warnings = buildUnnamed2465();
  }
  buildCounterClusterOperationMetadata--;
  return o;
}

void checkClusterOperationMetadata(api.ClusterOperationMetadata o) {
  buildCounterClusterOperationMetadata++;
  if (buildCounterClusterOperationMetadata < 3) {
    unittest.expect(
      o.clusterName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.clusterUuid!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    checkUnnamed2463(o.labels!);
    unittest.expect(
      o.operationType!,
      unittest.equals('foo'),
    );
    checkClusterOperationStatus(o.status! as api.ClusterOperationStatus);
    checkUnnamed2464(o.statusHistory!);
    checkUnnamed2465(o.warnings!);
  }
  buildCounterClusterOperationMetadata--;
}

core.int buildCounterClusterOperationStatus = 0;
api.ClusterOperationStatus buildClusterOperationStatus() {
  var o = api.ClusterOperationStatus();
  buildCounterClusterOperationStatus++;
  if (buildCounterClusterOperationStatus < 3) {
    o.details = 'foo';
    o.innerState = 'foo';
    o.state = 'foo';
    o.stateStartTime = 'foo';
  }
  buildCounterClusterOperationStatus--;
  return o;
}

void checkClusterOperationStatus(api.ClusterOperationStatus o) {
  buildCounterClusterOperationStatus++;
  if (buildCounterClusterOperationStatus < 3) {
    unittest.expect(
      o.details!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.innerState!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.stateStartTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterClusterOperationStatus--;
}

core.Map<core.String, core.String> buildUnnamed2466() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2466(core.Map<core.String, core.String> o) {
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

core.int buildCounterClusterSelector = 0;
api.ClusterSelector buildClusterSelector() {
  var o = api.ClusterSelector();
  buildCounterClusterSelector++;
  if (buildCounterClusterSelector < 3) {
    o.clusterLabels = buildUnnamed2466();
    o.zone = 'foo';
  }
  buildCounterClusterSelector--;
  return o;
}

void checkClusterSelector(api.ClusterSelector o) {
  buildCounterClusterSelector++;
  if (buildCounterClusterSelector < 3) {
    checkUnnamed2466(o.clusterLabels!);
    unittest.expect(
      o.zone!,
      unittest.equals('foo'),
    );
  }
  buildCounterClusterSelector--;
}

core.int buildCounterClusterStatus = 0;
api.ClusterStatus buildClusterStatus() {
  var o = api.ClusterStatus();
  buildCounterClusterStatus++;
  if (buildCounterClusterStatus < 3) {
    o.detail = 'foo';
    o.state = 'foo';
    o.stateStartTime = 'foo';
    o.substate = 'foo';
  }
  buildCounterClusterStatus--;
  return o;
}

void checkClusterStatus(api.ClusterStatus o) {
  buildCounterClusterStatus++;
  if (buildCounterClusterStatus < 3) {
    unittest.expect(
      o.detail!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.stateStartTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.substate!,
      unittest.equals('foo'),
    );
  }
  buildCounterClusterStatus--;
}

core.int buildCounterDiagnoseClusterRequest = 0;
api.DiagnoseClusterRequest buildDiagnoseClusterRequest() {
  var o = api.DiagnoseClusterRequest();
  buildCounterDiagnoseClusterRequest++;
  if (buildCounterDiagnoseClusterRequest < 3) {}
  buildCounterDiagnoseClusterRequest--;
  return o;
}

void checkDiagnoseClusterRequest(api.DiagnoseClusterRequest o) {
  buildCounterDiagnoseClusterRequest++;
  if (buildCounterDiagnoseClusterRequest < 3) {}
  buildCounterDiagnoseClusterRequest--;
}

core.int buildCounterDiagnoseClusterResults = 0;
api.DiagnoseClusterResults buildDiagnoseClusterResults() {
  var o = api.DiagnoseClusterResults();
  buildCounterDiagnoseClusterResults++;
  if (buildCounterDiagnoseClusterResults < 3) {
    o.outputUri = 'foo';
  }
  buildCounterDiagnoseClusterResults--;
  return o;
}

void checkDiagnoseClusterResults(api.DiagnoseClusterResults o) {
  buildCounterDiagnoseClusterResults++;
  if (buildCounterDiagnoseClusterResults < 3) {
    unittest.expect(
      o.outputUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterDiagnoseClusterResults--;
}

core.int buildCounterDiskConfig = 0;
api.DiskConfig buildDiskConfig() {
  var o = api.DiskConfig();
  buildCounterDiskConfig++;
  if (buildCounterDiskConfig < 3) {
    o.bootDiskSizeGb = 42;
    o.bootDiskType = 'foo';
    o.numLocalSsds = 42;
  }
  buildCounterDiskConfig--;
  return o;
}

void checkDiskConfig(api.DiskConfig o) {
  buildCounterDiskConfig++;
  if (buildCounterDiskConfig < 3) {
    unittest.expect(
      o.bootDiskSizeGb!,
      unittest.equals(42),
    );
    unittest.expect(
      o.bootDiskType!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.numLocalSsds!,
      unittest.equals(42),
    );
  }
  buildCounterDiskConfig--;
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

core.int buildCounterEncryptionConfig = 0;
api.EncryptionConfig buildEncryptionConfig() {
  var o = api.EncryptionConfig();
  buildCounterEncryptionConfig++;
  if (buildCounterEncryptionConfig < 3) {
    o.gcePdKmsKeyName = 'foo';
  }
  buildCounterEncryptionConfig--;
  return o;
}

void checkEncryptionConfig(api.EncryptionConfig o) {
  buildCounterEncryptionConfig++;
  if (buildCounterEncryptionConfig < 3) {
    unittest.expect(
      o.gcePdKmsKeyName!,
      unittest.equals('foo'),
    );
  }
  buildCounterEncryptionConfig--;
}

core.Map<core.String, core.String> buildUnnamed2467() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2467(core.Map<core.String, core.String> o) {
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

core.int buildCounterEndpointConfig = 0;
api.EndpointConfig buildEndpointConfig() {
  var o = api.EndpointConfig();
  buildCounterEndpointConfig++;
  if (buildCounterEndpointConfig < 3) {
    o.enableHttpPortAccess = true;
    o.httpPorts = buildUnnamed2467();
  }
  buildCounterEndpointConfig--;
  return o;
}

void checkEndpointConfig(api.EndpointConfig o) {
  buildCounterEndpointConfig++;
  if (buildCounterEndpointConfig < 3) {
    unittest.expect(o.enableHttpPortAccess!, unittest.isTrue);
    checkUnnamed2467(o.httpPorts!);
  }
  buildCounterEndpointConfig--;
}

core.int buildCounterExpr = 0;
api.Expr buildExpr() {
  var o = api.Expr();
  buildCounterExpr++;
  if (buildCounterExpr < 3) {
    o.description = 'foo';
    o.expression = 'foo';
    o.location = 'foo';
    o.title = 'foo';
  }
  buildCounterExpr--;
  return o;
}

void checkExpr(api.Expr o) {
  buildCounterExpr++;
  if (buildCounterExpr < 3) {
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
  buildCounterExpr--;
}

core.Map<core.String, core.String> buildUnnamed2468() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2468(core.Map<core.String, core.String> o) {
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

core.List<core.String> buildUnnamed2469() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2469(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed2470() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2470(core.List<core.String> o) {
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

core.int buildCounterGceClusterConfig = 0;
api.GceClusterConfig buildGceClusterConfig() {
  var o = api.GceClusterConfig();
  buildCounterGceClusterConfig++;
  if (buildCounterGceClusterConfig < 3) {
    o.internalIpOnly = true;
    o.metadata = buildUnnamed2468();
    o.networkUri = 'foo';
    o.nodeGroupAffinity = buildNodeGroupAffinity();
    o.privateIpv6GoogleAccess = 'foo';
    o.reservationAffinity = buildReservationAffinity();
    o.serviceAccount = 'foo';
    o.serviceAccountScopes = buildUnnamed2469();
    o.shieldedInstanceConfig = buildShieldedInstanceConfig();
    o.subnetworkUri = 'foo';
    o.tags = buildUnnamed2470();
    o.zoneUri = 'foo';
  }
  buildCounterGceClusterConfig--;
  return o;
}

void checkGceClusterConfig(api.GceClusterConfig o) {
  buildCounterGceClusterConfig++;
  if (buildCounterGceClusterConfig < 3) {
    unittest.expect(o.internalIpOnly!, unittest.isTrue);
    checkUnnamed2468(o.metadata!);
    unittest.expect(
      o.networkUri!,
      unittest.equals('foo'),
    );
    checkNodeGroupAffinity(o.nodeGroupAffinity! as api.NodeGroupAffinity);
    unittest.expect(
      o.privateIpv6GoogleAccess!,
      unittest.equals('foo'),
    );
    checkReservationAffinity(o.reservationAffinity! as api.ReservationAffinity);
    unittest.expect(
      o.serviceAccount!,
      unittest.equals('foo'),
    );
    checkUnnamed2469(o.serviceAccountScopes!);
    checkShieldedInstanceConfig(
        o.shieldedInstanceConfig! as api.ShieldedInstanceConfig);
    unittest.expect(
      o.subnetworkUri!,
      unittest.equals('foo'),
    );
    checkUnnamed2470(o.tags!);
    unittest.expect(
      o.zoneUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGceClusterConfig--;
}

core.int buildCounterGetIamPolicyRequest = 0;
api.GetIamPolicyRequest buildGetIamPolicyRequest() {
  var o = api.GetIamPolicyRequest();
  buildCounterGetIamPolicyRequest++;
  if (buildCounterGetIamPolicyRequest < 3) {
    o.options = buildGetPolicyOptions();
  }
  buildCounterGetIamPolicyRequest--;
  return o;
}

void checkGetIamPolicyRequest(api.GetIamPolicyRequest o) {
  buildCounterGetIamPolicyRequest++;
  if (buildCounterGetIamPolicyRequest < 3) {
    checkGetPolicyOptions(o.options! as api.GetPolicyOptions);
  }
  buildCounterGetIamPolicyRequest--;
}

core.int buildCounterGetPolicyOptions = 0;
api.GetPolicyOptions buildGetPolicyOptions() {
  var o = api.GetPolicyOptions();
  buildCounterGetPolicyOptions++;
  if (buildCounterGetPolicyOptions < 3) {
    o.requestedPolicyVersion = 42;
  }
  buildCounterGetPolicyOptions--;
  return o;
}

void checkGetPolicyOptions(api.GetPolicyOptions o) {
  buildCounterGetPolicyOptions++;
  if (buildCounterGetPolicyOptions < 3) {
    unittest.expect(
      o.requestedPolicyVersion!,
      unittest.equals(42),
    );
  }
  buildCounterGetPolicyOptions--;
}

core.List<core.String> buildUnnamed2471() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2471(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed2472() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2472(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed2473() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2473(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed2474() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2474(core.List<core.String> o) {
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

core.Map<core.String, core.String> buildUnnamed2475() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2475(core.Map<core.String, core.String> o) {
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

core.int buildCounterHadoopJob = 0;
api.HadoopJob buildHadoopJob() {
  var o = api.HadoopJob();
  buildCounterHadoopJob++;
  if (buildCounterHadoopJob < 3) {
    o.archiveUris = buildUnnamed2471();
    o.args = buildUnnamed2472();
    o.fileUris = buildUnnamed2473();
    o.jarFileUris = buildUnnamed2474();
    o.loggingConfig = buildLoggingConfig();
    o.mainClass = 'foo';
    o.mainJarFileUri = 'foo';
    o.properties = buildUnnamed2475();
  }
  buildCounterHadoopJob--;
  return o;
}

void checkHadoopJob(api.HadoopJob o) {
  buildCounterHadoopJob++;
  if (buildCounterHadoopJob < 3) {
    checkUnnamed2471(o.archiveUris!);
    checkUnnamed2472(o.args!);
    checkUnnamed2473(o.fileUris!);
    checkUnnamed2474(o.jarFileUris!);
    checkLoggingConfig(o.loggingConfig! as api.LoggingConfig);
    unittest.expect(
      o.mainClass!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.mainJarFileUri!,
      unittest.equals('foo'),
    );
    checkUnnamed2475(o.properties!);
  }
  buildCounterHadoopJob--;
}

core.List<core.String> buildUnnamed2476() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2476(core.List<core.String> o) {
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

core.Map<core.String, core.String> buildUnnamed2477() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2477(core.Map<core.String, core.String> o) {
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

core.Map<core.String, core.String> buildUnnamed2478() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2478(core.Map<core.String, core.String> o) {
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

core.int buildCounterHiveJob = 0;
api.HiveJob buildHiveJob() {
  var o = api.HiveJob();
  buildCounterHiveJob++;
  if (buildCounterHiveJob < 3) {
    o.continueOnFailure = true;
    o.jarFileUris = buildUnnamed2476();
    o.properties = buildUnnamed2477();
    o.queryFileUri = 'foo';
    o.queryList = buildQueryList();
    o.scriptVariables = buildUnnamed2478();
  }
  buildCounterHiveJob--;
  return o;
}

void checkHiveJob(api.HiveJob o) {
  buildCounterHiveJob++;
  if (buildCounterHiveJob < 3) {
    unittest.expect(o.continueOnFailure!, unittest.isTrue);
    checkUnnamed2476(o.jarFileUris!);
    checkUnnamed2477(o.properties!);
    unittest.expect(
      o.queryFileUri!,
      unittest.equals('foo'),
    );
    checkQueryList(o.queryList! as api.QueryList);
    checkUnnamed2478(o.scriptVariables!);
  }
  buildCounterHiveJob--;
}

core.int buildCounterInjectCredentialsRequest = 0;
api.InjectCredentialsRequest buildInjectCredentialsRequest() {
  var o = api.InjectCredentialsRequest();
  buildCounterInjectCredentialsRequest++;
  if (buildCounterInjectCredentialsRequest < 3) {
    o.clusterUuid = 'foo';
    o.credentialsCiphertext = 'foo';
  }
  buildCounterInjectCredentialsRequest--;
  return o;
}

void checkInjectCredentialsRequest(api.InjectCredentialsRequest o) {
  buildCounterInjectCredentialsRequest++;
  if (buildCounterInjectCredentialsRequest < 3) {
    unittest.expect(
      o.clusterUuid!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.credentialsCiphertext!,
      unittest.equals('foo'),
    );
  }
  buildCounterInjectCredentialsRequest--;
}

core.int buildCounterInstanceGroupAutoscalingPolicyConfig = 0;
api.InstanceGroupAutoscalingPolicyConfig
    buildInstanceGroupAutoscalingPolicyConfig() {
  var o = api.InstanceGroupAutoscalingPolicyConfig();
  buildCounterInstanceGroupAutoscalingPolicyConfig++;
  if (buildCounterInstanceGroupAutoscalingPolicyConfig < 3) {
    o.maxInstances = 42;
    o.minInstances = 42;
    o.weight = 42;
  }
  buildCounterInstanceGroupAutoscalingPolicyConfig--;
  return o;
}

void checkInstanceGroupAutoscalingPolicyConfig(
    api.InstanceGroupAutoscalingPolicyConfig o) {
  buildCounterInstanceGroupAutoscalingPolicyConfig++;
  if (buildCounterInstanceGroupAutoscalingPolicyConfig < 3) {
    unittest.expect(
      o.maxInstances!,
      unittest.equals(42),
    );
    unittest.expect(
      o.minInstances!,
      unittest.equals(42),
    );
    unittest.expect(
      o.weight!,
      unittest.equals(42),
    );
  }
  buildCounterInstanceGroupAutoscalingPolicyConfig--;
}

core.List<api.AcceleratorConfig> buildUnnamed2479() {
  var o = <api.AcceleratorConfig>[];
  o.add(buildAcceleratorConfig());
  o.add(buildAcceleratorConfig());
  return o;
}

void checkUnnamed2479(core.List<api.AcceleratorConfig> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAcceleratorConfig(o[0] as api.AcceleratorConfig);
  checkAcceleratorConfig(o[1] as api.AcceleratorConfig);
}

core.List<core.String> buildUnnamed2480() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2480(core.List<core.String> o) {
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

core.List<api.InstanceReference> buildUnnamed2481() {
  var o = <api.InstanceReference>[];
  o.add(buildInstanceReference());
  o.add(buildInstanceReference());
  return o;
}

void checkUnnamed2481(core.List<api.InstanceReference> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkInstanceReference(o[0] as api.InstanceReference);
  checkInstanceReference(o[1] as api.InstanceReference);
}

core.int buildCounterInstanceGroupConfig = 0;
api.InstanceGroupConfig buildInstanceGroupConfig() {
  var o = api.InstanceGroupConfig();
  buildCounterInstanceGroupConfig++;
  if (buildCounterInstanceGroupConfig < 3) {
    o.accelerators = buildUnnamed2479();
    o.diskConfig = buildDiskConfig();
    o.imageUri = 'foo';
    o.instanceNames = buildUnnamed2480();
    o.instanceReferences = buildUnnamed2481();
    o.isPreemptible = true;
    o.machineTypeUri = 'foo';
    o.managedGroupConfig = buildManagedGroupConfig();
    o.minCpuPlatform = 'foo';
    o.numInstances = 42;
    o.preemptibility = 'foo';
  }
  buildCounterInstanceGroupConfig--;
  return o;
}

void checkInstanceGroupConfig(api.InstanceGroupConfig o) {
  buildCounterInstanceGroupConfig++;
  if (buildCounterInstanceGroupConfig < 3) {
    checkUnnamed2479(o.accelerators!);
    checkDiskConfig(o.diskConfig! as api.DiskConfig);
    unittest.expect(
      o.imageUri!,
      unittest.equals('foo'),
    );
    checkUnnamed2480(o.instanceNames!);
    checkUnnamed2481(o.instanceReferences!);
    unittest.expect(o.isPreemptible!, unittest.isTrue);
    unittest.expect(
      o.machineTypeUri!,
      unittest.equals('foo'),
    );
    checkManagedGroupConfig(o.managedGroupConfig! as api.ManagedGroupConfig);
    unittest.expect(
      o.minCpuPlatform!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.numInstances!,
      unittest.equals(42),
    );
    unittest.expect(
      o.preemptibility!,
      unittest.equals('foo'),
    );
  }
  buildCounterInstanceGroupConfig--;
}

core.int buildCounterInstanceReference = 0;
api.InstanceReference buildInstanceReference() {
  var o = api.InstanceReference();
  buildCounterInstanceReference++;
  if (buildCounterInstanceReference < 3) {
    o.instanceId = 'foo';
    o.instanceName = 'foo';
    o.publicKey = 'foo';
  }
  buildCounterInstanceReference--;
  return o;
}

void checkInstanceReference(api.InstanceReference o) {
  buildCounterInstanceReference++;
  if (buildCounterInstanceReference < 3) {
    unittest.expect(
      o.instanceId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.instanceName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.publicKey!,
      unittest.equals('foo'),
    );
  }
  buildCounterInstanceReference--;
}

core.Map<core.String, core.String> buildUnnamed2482() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2482(core.Map<core.String, core.String> o) {
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

core.int buildCounterInstantiateWorkflowTemplateRequest = 0;
api.InstantiateWorkflowTemplateRequest
    buildInstantiateWorkflowTemplateRequest() {
  var o = api.InstantiateWorkflowTemplateRequest();
  buildCounterInstantiateWorkflowTemplateRequest++;
  if (buildCounterInstantiateWorkflowTemplateRequest < 3) {
    o.parameters = buildUnnamed2482();
    o.requestId = 'foo';
    o.version = 42;
  }
  buildCounterInstantiateWorkflowTemplateRequest--;
  return o;
}

void checkInstantiateWorkflowTemplateRequest(
    api.InstantiateWorkflowTemplateRequest o) {
  buildCounterInstantiateWorkflowTemplateRequest++;
  if (buildCounterInstantiateWorkflowTemplateRequest < 3) {
    checkUnnamed2482(o.parameters!);
    unittest.expect(
      o.requestId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.version!,
      unittest.equals(42),
    );
  }
  buildCounterInstantiateWorkflowTemplateRequest--;
}

core.Map<core.String, core.String> buildUnnamed2483() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2483(core.Map<core.String, core.String> o) {
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

core.List<api.JobStatus> buildUnnamed2484() {
  var o = <api.JobStatus>[];
  o.add(buildJobStatus());
  o.add(buildJobStatus());
  return o;
}

void checkUnnamed2484(core.List<api.JobStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkJobStatus(o[0] as api.JobStatus);
  checkJobStatus(o[1] as api.JobStatus);
}

core.List<api.YarnApplication> buildUnnamed2485() {
  var o = <api.YarnApplication>[];
  o.add(buildYarnApplication());
  o.add(buildYarnApplication());
  return o;
}

void checkUnnamed2485(core.List<api.YarnApplication> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkYarnApplication(o[0] as api.YarnApplication);
  checkYarnApplication(o[1] as api.YarnApplication);
}

core.int buildCounterJob = 0;
api.Job buildJob() {
  var o = api.Job();
  buildCounterJob++;
  if (buildCounterJob < 3) {
    o.done = true;
    o.driverControlFilesUri = 'foo';
    o.driverOutputResourceUri = 'foo';
    o.hadoopJob = buildHadoopJob();
    o.hiveJob = buildHiveJob();
    o.jobUuid = 'foo';
    o.labels = buildUnnamed2483();
    o.pigJob = buildPigJob();
    o.placement = buildJobPlacement();
    o.prestoJob = buildPrestoJob();
    o.pysparkJob = buildPySparkJob();
    o.reference = buildJobReference();
    o.scheduling = buildJobScheduling();
    o.sparkJob = buildSparkJob();
    o.sparkRJob = buildSparkRJob();
    o.sparkSqlJob = buildSparkSqlJob();
    o.status = buildJobStatus();
    o.statusHistory = buildUnnamed2484();
    o.yarnApplications = buildUnnamed2485();
  }
  buildCounterJob--;
  return o;
}

void checkJob(api.Job o) {
  buildCounterJob++;
  if (buildCounterJob < 3) {
    unittest.expect(o.done!, unittest.isTrue);
    unittest.expect(
      o.driverControlFilesUri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.driverOutputResourceUri!,
      unittest.equals('foo'),
    );
    checkHadoopJob(o.hadoopJob! as api.HadoopJob);
    checkHiveJob(o.hiveJob! as api.HiveJob);
    unittest.expect(
      o.jobUuid!,
      unittest.equals('foo'),
    );
    checkUnnamed2483(o.labels!);
    checkPigJob(o.pigJob! as api.PigJob);
    checkJobPlacement(o.placement! as api.JobPlacement);
    checkPrestoJob(o.prestoJob! as api.PrestoJob);
    checkPySparkJob(o.pysparkJob! as api.PySparkJob);
    checkJobReference(o.reference! as api.JobReference);
    checkJobScheduling(o.scheduling! as api.JobScheduling);
    checkSparkJob(o.sparkJob! as api.SparkJob);
    checkSparkRJob(o.sparkRJob! as api.SparkRJob);
    checkSparkSqlJob(o.sparkSqlJob! as api.SparkSqlJob);
    checkJobStatus(o.status! as api.JobStatus);
    checkUnnamed2484(o.statusHistory!);
    checkUnnamed2485(o.yarnApplications!);
  }
  buildCounterJob--;
}

core.int buildCounterJobMetadata = 0;
api.JobMetadata buildJobMetadata() {
  var o = api.JobMetadata();
  buildCounterJobMetadata++;
  if (buildCounterJobMetadata < 3) {
    o.jobId = 'foo';
    o.operationType = 'foo';
    o.startTime = 'foo';
    o.status = buildJobStatus();
  }
  buildCounterJobMetadata--;
  return o;
}

void checkJobMetadata(api.JobMetadata o) {
  buildCounterJobMetadata++;
  if (buildCounterJobMetadata < 3) {
    unittest.expect(
      o.jobId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.operationType!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.startTime!,
      unittest.equals('foo'),
    );
    checkJobStatus(o.status! as api.JobStatus);
  }
  buildCounterJobMetadata--;
}

core.Map<core.String, core.String> buildUnnamed2486() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2486(core.Map<core.String, core.String> o) {
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

core.int buildCounterJobPlacement = 0;
api.JobPlacement buildJobPlacement() {
  var o = api.JobPlacement();
  buildCounterJobPlacement++;
  if (buildCounterJobPlacement < 3) {
    o.clusterLabels = buildUnnamed2486();
    o.clusterName = 'foo';
    o.clusterUuid = 'foo';
  }
  buildCounterJobPlacement--;
  return o;
}

void checkJobPlacement(api.JobPlacement o) {
  buildCounterJobPlacement++;
  if (buildCounterJobPlacement < 3) {
    checkUnnamed2486(o.clusterLabels!);
    unittest.expect(
      o.clusterName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.clusterUuid!,
      unittest.equals('foo'),
    );
  }
  buildCounterJobPlacement--;
}

core.int buildCounterJobReference = 0;
api.JobReference buildJobReference() {
  var o = api.JobReference();
  buildCounterJobReference++;
  if (buildCounterJobReference < 3) {
    o.jobId = 'foo';
    o.projectId = 'foo';
  }
  buildCounterJobReference--;
  return o;
}

void checkJobReference(api.JobReference o) {
  buildCounterJobReference++;
  if (buildCounterJobReference < 3) {
    unittest.expect(
      o.jobId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.projectId!,
      unittest.equals('foo'),
    );
  }
  buildCounterJobReference--;
}

core.int buildCounterJobScheduling = 0;
api.JobScheduling buildJobScheduling() {
  var o = api.JobScheduling();
  buildCounterJobScheduling++;
  if (buildCounterJobScheduling < 3) {
    o.maxFailuresPerHour = 42;
    o.maxFailuresTotal = 42;
  }
  buildCounterJobScheduling--;
  return o;
}

void checkJobScheduling(api.JobScheduling o) {
  buildCounterJobScheduling++;
  if (buildCounterJobScheduling < 3) {
    unittest.expect(
      o.maxFailuresPerHour!,
      unittest.equals(42),
    );
    unittest.expect(
      o.maxFailuresTotal!,
      unittest.equals(42),
    );
  }
  buildCounterJobScheduling--;
}

core.int buildCounterJobStatus = 0;
api.JobStatus buildJobStatus() {
  var o = api.JobStatus();
  buildCounterJobStatus++;
  if (buildCounterJobStatus < 3) {
    o.details = 'foo';
    o.state = 'foo';
    o.stateStartTime = 'foo';
    o.substate = 'foo';
  }
  buildCounterJobStatus--;
  return o;
}

void checkJobStatus(api.JobStatus o) {
  buildCounterJobStatus++;
  if (buildCounterJobStatus < 3) {
    unittest.expect(
      o.details!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.stateStartTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.substate!,
      unittest.equals('foo'),
    );
  }
  buildCounterJobStatus--;
}

core.int buildCounterKerberosConfig = 0;
api.KerberosConfig buildKerberosConfig() {
  var o = api.KerberosConfig();
  buildCounterKerberosConfig++;
  if (buildCounterKerberosConfig < 3) {
    o.crossRealmTrustAdminServer = 'foo';
    o.crossRealmTrustKdc = 'foo';
    o.crossRealmTrustRealm = 'foo';
    o.crossRealmTrustSharedPasswordUri = 'foo';
    o.enableKerberos = true;
    o.kdcDbKeyUri = 'foo';
    o.keyPasswordUri = 'foo';
    o.keystorePasswordUri = 'foo';
    o.keystoreUri = 'foo';
    o.kmsKeyUri = 'foo';
    o.realm = 'foo';
    o.rootPrincipalPasswordUri = 'foo';
    o.tgtLifetimeHours = 42;
    o.truststorePasswordUri = 'foo';
    o.truststoreUri = 'foo';
  }
  buildCounterKerberosConfig--;
  return o;
}

void checkKerberosConfig(api.KerberosConfig o) {
  buildCounterKerberosConfig++;
  if (buildCounterKerberosConfig < 3) {
    unittest.expect(
      o.crossRealmTrustAdminServer!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.crossRealmTrustKdc!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.crossRealmTrustRealm!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.crossRealmTrustSharedPasswordUri!,
      unittest.equals('foo'),
    );
    unittest.expect(o.enableKerberos!, unittest.isTrue);
    unittest.expect(
      o.kdcDbKeyUri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.keyPasswordUri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.keystorePasswordUri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.keystoreUri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.kmsKeyUri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.realm!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.rootPrincipalPasswordUri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.tgtLifetimeHours!,
      unittest.equals(42),
    );
    unittest.expect(
      o.truststorePasswordUri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.truststoreUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterKerberosConfig--;
}

core.int buildCounterLifecycleConfig = 0;
api.LifecycleConfig buildLifecycleConfig() {
  var o = api.LifecycleConfig();
  buildCounterLifecycleConfig++;
  if (buildCounterLifecycleConfig < 3) {
    o.autoDeleteTime = 'foo';
    o.autoDeleteTtl = 'foo';
    o.idleDeleteTtl = 'foo';
    o.idleStartTime = 'foo';
  }
  buildCounterLifecycleConfig--;
  return o;
}

void checkLifecycleConfig(api.LifecycleConfig o) {
  buildCounterLifecycleConfig++;
  if (buildCounterLifecycleConfig < 3) {
    unittest.expect(
      o.autoDeleteTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.autoDeleteTtl!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.idleDeleteTtl!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.idleStartTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterLifecycleConfig--;
}

core.List<api.AutoscalingPolicy> buildUnnamed2487() {
  var o = <api.AutoscalingPolicy>[];
  o.add(buildAutoscalingPolicy());
  o.add(buildAutoscalingPolicy());
  return o;
}

void checkUnnamed2487(core.List<api.AutoscalingPolicy> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAutoscalingPolicy(o[0] as api.AutoscalingPolicy);
  checkAutoscalingPolicy(o[1] as api.AutoscalingPolicy);
}

core.int buildCounterListAutoscalingPoliciesResponse = 0;
api.ListAutoscalingPoliciesResponse buildListAutoscalingPoliciesResponse() {
  var o = api.ListAutoscalingPoliciesResponse();
  buildCounterListAutoscalingPoliciesResponse++;
  if (buildCounterListAutoscalingPoliciesResponse < 3) {
    o.nextPageToken = 'foo';
    o.policies = buildUnnamed2487();
  }
  buildCounterListAutoscalingPoliciesResponse--;
  return o;
}

void checkListAutoscalingPoliciesResponse(
    api.ListAutoscalingPoliciesResponse o) {
  buildCounterListAutoscalingPoliciesResponse++;
  if (buildCounterListAutoscalingPoliciesResponse < 3) {
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
    checkUnnamed2487(o.policies!);
  }
  buildCounterListAutoscalingPoliciesResponse--;
}

core.List<api.Cluster> buildUnnamed2488() {
  var o = <api.Cluster>[];
  o.add(buildCluster());
  o.add(buildCluster());
  return o;
}

void checkUnnamed2488(core.List<api.Cluster> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCluster(o[0] as api.Cluster);
  checkCluster(o[1] as api.Cluster);
}

core.int buildCounterListClustersResponse = 0;
api.ListClustersResponse buildListClustersResponse() {
  var o = api.ListClustersResponse();
  buildCounterListClustersResponse++;
  if (buildCounterListClustersResponse < 3) {
    o.clusters = buildUnnamed2488();
    o.nextPageToken = 'foo';
  }
  buildCounterListClustersResponse--;
  return o;
}

void checkListClustersResponse(api.ListClustersResponse o) {
  buildCounterListClustersResponse++;
  if (buildCounterListClustersResponse < 3) {
    checkUnnamed2488(o.clusters!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterListClustersResponse--;
}

core.List<api.Job> buildUnnamed2489() {
  var o = <api.Job>[];
  o.add(buildJob());
  o.add(buildJob());
  return o;
}

void checkUnnamed2489(core.List<api.Job> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkJob(o[0] as api.Job);
  checkJob(o[1] as api.Job);
}

core.int buildCounterListJobsResponse = 0;
api.ListJobsResponse buildListJobsResponse() {
  var o = api.ListJobsResponse();
  buildCounterListJobsResponse++;
  if (buildCounterListJobsResponse < 3) {
    o.jobs = buildUnnamed2489();
    o.nextPageToken = 'foo';
  }
  buildCounterListJobsResponse--;
  return o;
}

void checkListJobsResponse(api.ListJobsResponse o) {
  buildCounterListJobsResponse++;
  if (buildCounterListJobsResponse < 3) {
    checkUnnamed2489(o.jobs!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterListJobsResponse--;
}

core.List<api.Operation> buildUnnamed2490() {
  var o = <api.Operation>[];
  o.add(buildOperation());
  o.add(buildOperation());
  return o;
}

void checkUnnamed2490(core.List<api.Operation> o) {
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
    o.operations = buildUnnamed2490();
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
    checkUnnamed2490(o.operations!);
  }
  buildCounterListOperationsResponse--;
}

core.List<api.WorkflowTemplate> buildUnnamed2491() {
  var o = <api.WorkflowTemplate>[];
  o.add(buildWorkflowTemplate());
  o.add(buildWorkflowTemplate());
  return o;
}

void checkUnnamed2491(core.List<api.WorkflowTemplate> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkWorkflowTemplate(o[0] as api.WorkflowTemplate);
  checkWorkflowTemplate(o[1] as api.WorkflowTemplate);
}

core.int buildCounterListWorkflowTemplatesResponse = 0;
api.ListWorkflowTemplatesResponse buildListWorkflowTemplatesResponse() {
  var o = api.ListWorkflowTemplatesResponse();
  buildCounterListWorkflowTemplatesResponse++;
  if (buildCounterListWorkflowTemplatesResponse < 3) {
    o.nextPageToken = 'foo';
    o.templates = buildUnnamed2491();
  }
  buildCounterListWorkflowTemplatesResponse--;
  return o;
}

void checkListWorkflowTemplatesResponse(api.ListWorkflowTemplatesResponse o) {
  buildCounterListWorkflowTemplatesResponse++;
  if (buildCounterListWorkflowTemplatesResponse < 3) {
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
    checkUnnamed2491(o.templates!);
  }
  buildCounterListWorkflowTemplatesResponse--;
}

core.Map<core.String, core.String> buildUnnamed2492() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2492(core.Map<core.String, core.String> o) {
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

core.int buildCounterLoggingConfig = 0;
api.LoggingConfig buildLoggingConfig() {
  var o = api.LoggingConfig();
  buildCounterLoggingConfig++;
  if (buildCounterLoggingConfig < 3) {
    o.driverLogLevels = buildUnnamed2492();
  }
  buildCounterLoggingConfig--;
  return o;
}

void checkLoggingConfig(api.LoggingConfig o) {
  buildCounterLoggingConfig++;
  if (buildCounterLoggingConfig < 3) {
    checkUnnamed2492(o.driverLogLevels!);
  }
  buildCounterLoggingConfig--;
}

core.Map<core.String, core.String> buildUnnamed2493() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2493(core.Map<core.String, core.String> o) {
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

core.int buildCounterManagedCluster = 0;
api.ManagedCluster buildManagedCluster() {
  var o = api.ManagedCluster();
  buildCounterManagedCluster++;
  if (buildCounterManagedCluster < 3) {
    o.clusterName = 'foo';
    o.config = buildClusterConfig();
    o.labels = buildUnnamed2493();
  }
  buildCounterManagedCluster--;
  return o;
}

void checkManagedCluster(api.ManagedCluster o) {
  buildCounterManagedCluster++;
  if (buildCounterManagedCluster < 3) {
    unittest.expect(
      o.clusterName!,
      unittest.equals('foo'),
    );
    checkClusterConfig(o.config! as api.ClusterConfig);
    checkUnnamed2493(o.labels!);
  }
  buildCounterManagedCluster--;
}

core.int buildCounterManagedGroupConfig = 0;
api.ManagedGroupConfig buildManagedGroupConfig() {
  var o = api.ManagedGroupConfig();
  buildCounterManagedGroupConfig++;
  if (buildCounterManagedGroupConfig < 3) {
    o.instanceGroupManagerName = 'foo';
    o.instanceTemplateName = 'foo';
  }
  buildCounterManagedGroupConfig--;
  return o;
}

void checkManagedGroupConfig(api.ManagedGroupConfig o) {
  buildCounterManagedGroupConfig++;
  if (buildCounterManagedGroupConfig < 3) {
    unittest.expect(
      o.instanceGroupManagerName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.instanceTemplateName!,
      unittest.equals('foo'),
    );
  }
  buildCounterManagedGroupConfig--;
}

core.int buildCounterMetastoreConfig = 0;
api.MetastoreConfig buildMetastoreConfig() {
  var o = api.MetastoreConfig();
  buildCounterMetastoreConfig++;
  if (buildCounterMetastoreConfig < 3) {
    o.dataprocMetastoreService = 'foo';
  }
  buildCounterMetastoreConfig--;
  return o;
}

void checkMetastoreConfig(api.MetastoreConfig o) {
  buildCounterMetastoreConfig++;
  if (buildCounterMetastoreConfig < 3) {
    unittest.expect(
      o.dataprocMetastoreService!,
      unittest.equals('foo'),
    );
  }
  buildCounterMetastoreConfig--;
}

core.int buildCounterNodeGroupAffinity = 0;
api.NodeGroupAffinity buildNodeGroupAffinity() {
  var o = api.NodeGroupAffinity();
  buildCounterNodeGroupAffinity++;
  if (buildCounterNodeGroupAffinity < 3) {
    o.nodeGroupUri = 'foo';
  }
  buildCounterNodeGroupAffinity--;
  return o;
}

void checkNodeGroupAffinity(api.NodeGroupAffinity o) {
  buildCounterNodeGroupAffinity++;
  if (buildCounterNodeGroupAffinity < 3) {
    unittest.expect(
      o.nodeGroupUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterNodeGroupAffinity--;
}

core.int buildCounterNodeInitializationAction = 0;
api.NodeInitializationAction buildNodeInitializationAction() {
  var o = api.NodeInitializationAction();
  buildCounterNodeInitializationAction++;
  if (buildCounterNodeInitializationAction < 3) {
    o.executableFile = 'foo';
    o.executionTimeout = 'foo';
  }
  buildCounterNodeInitializationAction--;
  return o;
}

void checkNodeInitializationAction(api.NodeInitializationAction o) {
  buildCounterNodeInitializationAction++;
  if (buildCounterNodeInitializationAction < 3) {
    unittest.expect(
      o.executableFile!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.executionTimeout!,
      unittest.equals('foo'),
    );
  }
  buildCounterNodeInitializationAction--;
}

core.Map<core.String, core.Object> buildUnnamed2494() {
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

void checkUnnamed2494(core.Map<core.String, core.Object> o) {
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

core.Map<core.String, core.Object> buildUnnamed2495() {
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

void checkUnnamed2495(core.Map<core.String, core.Object> o) {
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
    o.metadata = buildUnnamed2494();
    o.name = 'foo';
    o.response = buildUnnamed2495();
  }
  buildCounterOperation--;
  return o;
}

void checkOperation(api.Operation o) {
  buildCounterOperation++;
  if (buildCounterOperation < 3) {
    unittest.expect(o.done!, unittest.isTrue);
    checkStatus(o.error! as api.Status);
    checkUnnamed2494(o.metadata!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed2495(o.response!);
  }
  buildCounterOperation--;
}

core.Map<core.String, core.String> buildUnnamed2496() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2496(core.Map<core.String, core.String> o) {
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

core.List<core.String> buildUnnamed2497() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2497(core.List<core.String> o) {
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

core.int buildCounterOrderedJob = 0;
api.OrderedJob buildOrderedJob() {
  var o = api.OrderedJob();
  buildCounterOrderedJob++;
  if (buildCounterOrderedJob < 3) {
    o.hadoopJob = buildHadoopJob();
    o.hiveJob = buildHiveJob();
    o.labels = buildUnnamed2496();
    o.pigJob = buildPigJob();
    o.prerequisiteStepIds = buildUnnamed2497();
    o.prestoJob = buildPrestoJob();
    o.pysparkJob = buildPySparkJob();
    o.scheduling = buildJobScheduling();
    o.sparkJob = buildSparkJob();
    o.sparkRJob = buildSparkRJob();
    o.sparkSqlJob = buildSparkSqlJob();
    o.stepId = 'foo';
  }
  buildCounterOrderedJob--;
  return o;
}

void checkOrderedJob(api.OrderedJob o) {
  buildCounterOrderedJob++;
  if (buildCounterOrderedJob < 3) {
    checkHadoopJob(o.hadoopJob! as api.HadoopJob);
    checkHiveJob(o.hiveJob! as api.HiveJob);
    checkUnnamed2496(o.labels!);
    checkPigJob(o.pigJob! as api.PigJob);
    checkUnnamed2497(o.prerequisiteStepIds!);
    checkPrestoJob(o.prestoJob! as api.PrestoJob);
    checkPySparkJob(o.pysparkJob! as api.PySparkJob);
    checkJobScheduling(o.scheduling! as api.JobScheduling);
    checkSparkJob(o.sparkJob! as api.SparkJob);
    checkSparkRJob(o.sparkRJob! as api.SparkRJob);
    checkSparkSqlJob(o.sparkSqlJob! as api.SparkSqlJob);
    unittest.expect(
      o.stepId!,
      unittest.equals('foo'),
    );
  }
  buildCounterOrderedJob--;
}

core.int buildCounterParameterValidation = 0;
api.ParameterValidation buildParameterValidation() {
  var o = api.ParameterValidation();
  buildCounterParameterValidation++;
  if (buildCounterParameterValidation < 3) {
    o.regex = buildRegexValidation();
    o.values = buildValueValidation();
  }
  buildCounterParameterValidation--;
  return o;
}

void checkParameterValidation(api.ParameterValidation o) {
  buildCounterParameterValidation++;
  if (buildCounterParameterValidation < 3) {
    checkRegexValidation(o.regex! as api.RegexValidation);
    checkValueValidation(o.values! as api.ValueValidation);
  }
  buildCounterParameterValidation--;
}

core.List<core.String> buildUnnamed2498() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2498(core.List<core.String> o) {
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

core.Map<core.String, core.String> buildUnnamed2499() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2499(core.Map<core.String, core.String> o) {
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

core.Map<core.String, core.String> buildUnnamed2500() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2500(core.Map<core.String, core.String> o) {
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

core.int buildCounterPigJob = 0;
api.PigJob buildPigJob() {
  var o = api.PigJob();
  buildCounterPigJob++;
  if (buildCounterPigJob < 3) {
    o.continueOnFailure = true;
    o.jarFileUris = buildUnnamed2498();
    o.loggingConfig = buildLoggingConfig();
    o.properties = buildUnnamed2499();
    o.queryFileUri = 'foo';
    o.queryList = buildQueryList();
    o.scriptVariables = buildUnnamed2500();
  }
  buildCounterPigJob--;
  return o;
}

void checkPigJob(api.PigJob o) {
  buildCounterPigJob++;
  if (buildCounterPigJob < 3) {
    unittest.expect(o.continueOnFailure!, unittest.isTrue);
    checkUnnamed2498(o.jarFileUris!);
    checkLoggingConfig(o.loggingConfig! as api.LoggingConfig);
    checkUnnamed2499(o.properties!);
    unittest.expect(
      o.queryFileUri!,
      unittest.equals('foo'),
    );
    checkQueryList(o.queryList! as api.QueryList);
    checkUnnamed2500(o.scriptVariables!);
  }
  buildCounterPigJob--;
}

core.List<api.Binding> buildUnnamed2501() {
  var o = <api.Binding>[];
  o.add(buildBinding());
  o.add(buildBinding());
  return o;
}

void checkUnnamed2501(core.List<api.Binding> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBinding(o[0] as api.Binding);
  checkBinding(o[1] as api.Binding);
}

core.int buildCounterPolicy = 0;
api.Policy buildPolicy() {
  var o = api.Policy();
  buildCounterPolicy++;
  if (buildCounterPolicy < 3) {
    o.bindings = buildUnnamed2501();
    o.etag = 'foo';
    o.version = 42;
  }
  buildCounterPolicy--;
  return o;
}

void checkPolicy(api.Policy o) {
  buildCounterPolicy++;
  if (buildCounterPolicy < 3) {
    checkUnnamed2501(o.bindings!);
    unittest.expect(
      o.etag!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.version!,
      unittest.equals(42),
    );
  }
  buildCounterPolicy--;
}

core.List<core.String> buildUnnamed2502() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2502(core.List<core.String> o) {
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

core.Map<core.String, core.String> buildUnnamed2503() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2503(core.Map<core.String, core.String> o) {
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

core.int buildCounterPrestoJob = 0;
api.PrestoJob buildPrestoJob() {
  var o = api.PrestoJob();
  buildCounterPrestoJob++;
  if (buildCounterPrestoJob < 3) {
    o.clientTags = buildUnnamed2502();
    o.continueOnFailure = true;
    o.loggingConfig = buildLoggingConfig();
    o.outputFormat = 'foo';
    o.properties = buildUnnamed2503();
    o.queryFileUri = 'foo';
    o.queryList = buildQueryList();
  }
  buildCounterPrestoJob--;
  return o;
}

void checkPrestoJob(api.PrestoJob o) {
  buildCounterPrestoJob++;
  if (buildCounterPrestoJob < 3) {
    checkUnnamed2502(o.clientTags!);
    unittest.expect(o.continueOnFailure!, unittest.isTrue);
    checkLoggingConfig(o.loggingConfig! as api.LoggingConfig);
    unittest.expect(
      o.outputFormat!,
      unittest.equals('foo'),
    );
    checkUnnamed2503(o.properties!);
    unittest.expect(
      o.queryFileUri!,
      unittest.equals('foo'),
    );
    checkQueryList(o.queryList! as api.QueryList);
  }
  buildCounterPrestoJob--;
}

core.List<core.String> buildUnnamed2504() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2504(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed2505() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2505(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed2506() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2506(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed2507() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2507(core.List<core.String> o) {
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

core.Map<core.String, core.String> buildUnnamed2508() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2508(core.Map<core.String, core.String> o) {
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

core.List<core.String> buildUnnamed2509() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2509(core.List<core.String> o) {
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

core.int buildCounterPySparkJob = 0;
api.PySparkJob buildPySparkJob() {
  var o = api.PySparkJob();
  buildCounterPySparkJob++;
  if (buildCounterPySparkJob < 3) {
    o.archiveUris = buildUnnamed2504();
    o.args = buildUnnamed2505();
    o.fileUris = buildUnnamed2506();
    o.jarFileUris = buildUnnamed2507();
    o.loggingConfig = buildLoggingConfig();
    o.mainPythonFileUri = 'foo';
    o.properties = buildUnnamed2508();
    o.pythonFileUris = buildUnnamed2509();
  }
  buildCounterPySparkJob--;
  return o;
}

void checkPySparkJob(api.PySparkJob o) {
  buildCounterPySparkJob++;
  if (buildCounterPySparkJob < 3) {
    checkUnnamed2504(o.archiveUris!);
    checkUnnamed2505(o.args!);
    checkUnnamed2506(o.fileUris!);
    checkUnnamed2507(o.jarFileUris!);
    checkLoggingConfig(o.loggingConfig! as api.LoggingConfig);
    unittest.expect(
      o.mainPythonFileUri!,
      unittest.equals('foo'),
    );
    checkUnnamed2508(o.properties!);
    checkUnnamed2509(o.pythonFileUris!);
  }
  buildCounterPySparkJob--;
}

core.List<core.String> buildUnnamed2510() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2510(core.List<core.String> o) {
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

core.int buildCounterQueryList = 0;
api.QueryList buildQueryList() {
  var o = api.QueryList();
  buildCounterQueryList++;
  if (buildCounterQueryList < 3) {
    o.queries = buildUnnamed2510();
  }
  buildCounterQueryList--;
  return o;
}

void checkQueryList(api.QueryList o) {
  buildCounterQueryList++;
  if (buildCounterQueryList < 3) {
    checkUnnamed2510(o.queries!);
  }
  buildCounterQueryList--;
}

core.List<core.String> buildUnnamed2511() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2511(core.List<core.String> o) {
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

core.int buildCounterRegexValidation = 0;
api.RegexValidation buildRegexValidation() {
  var o = api.RegexValidation();
  buildCounterRegexValidation++;
  if (buildCounterRegexValidation < 3) {
    o.regexes = buildUnnamed2511();
  }
  buildCounterRegexValidation--;
  return o;
}

void checkRegexValidation(api.RegexValidation o) {
  buildCounterRegexValidation++;
  if (buildCounterRegexValidation < 3) {
    checkUnnamed2511(o.regexes!);
  }
  buildCounterRegexValidation--;
}

core.List<core.String> buildUnnamed2512() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2512(core.List<core.String> o) {
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

core.int buildCounterReservationAffinity = 0;
api.ReservationAffinity buildReservationAffinity() {
  var o = api.ReservationAffinity();
  buildCounterReservationAffinity++;
  if (buildCounterReservationAffinity < 3) {
    o.consumeReservationType = 'foo';
    o.key = 'foo';
    o.values = buildUnnamed2512();
  }
  buildCounterReservationAffinity--;
  return o;
}

void checkReservationAffinity(api.ReservationAffinity o) {
  buildCounterReservationAffinity++;
  if (buildCounterReservationAffinity < 3) {
    unittest.expect(
      o.consumeReservationType!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.key!,
      unittest.equals('foo'),
    );
    checkUnnamed2512(o.values!);
  }
  buildCounterReservationAffinity--;
}

core.int buildCounterSecurityConfig = 0;
api.SecurityConfig buildSecurityConfig() {
  var o = api.SecurityConfig();
  buildCounterSecurityConfig++;
  if (buildCounterSecurityConfig < 3) {
    o.kerberosConfig = buildKerberosConfig();
  }
  buildCounterSecurityConfig--;
  return o;
}

void checkSecurityConfig(api.SecurityConfig o) {
  buildCounterSecurityConfig++;
  if (buildCounterSecurityConfig < 3) {
    checkKerberosConfig(o.kerberosConfig! as api.KerberosConfig);
  }
  buildCounterSecurityConfig--;
}

core.int buildCounterSetIamPolicyRequest = 0;
api.SetIamPolicyRequest buildSetIamPolicyRequest() {
  var o = api.SetIamPolicyRequest();
  buildCounterSetIamPolicyRequest++;
  if (buildCounterSetIamPolicyRequest < 3) {
    o.policy = buildPolicy();
  }
  buildCounterSetIamPolicyRequest--;
  return o;
}

void checkSetIamPolicyRequest(api.SetIamPolicyRequest o) {
  buildCounterSetIamPolicyRequest++;
  if (buildCounterSetIamPolicyRequest < 3) {
    checkPolicy(o.policy! as api.Policy);
  }
  buildCounterSetIamPolicyRequest--;
}

core.int buildCounterShieldedInstanceConfig = 0;
api.ShieldedInstanceConfig buildShieldedInstanceConfig() {
  var o = api.ShieldedInstanceConfig();
  buildCounterShieldedInstanceConfig++;
  if (buildCounterShieldedInstanceConfig < 3) {
    o.enableIntegrityMonitoring = true;
    o.enableSecureBoot = true;
    o.enableVtpm = true;
  }
  buildCounterShieldedInstanceConfig--;
  return o;
}

void checkShieldedInstanceConfig(api.ShieldedInstanceConfig o) {
  buildCounterShieldedInstanceConfig++;
  if (buildCounterShieldedInstanceConfig < 3) {
    unittest.expect(o.enableIntegrityMonitoring!, unittest.isTrue);
    unittest.expect(o.enableSecureBoot!, unittest.isTrue);
    unittest.expect(o.enableVtpm!, unittest.isTrue);
  }
  buildCounterShieldedInstanceConfig--;
}

core.List<core.String> buildUnnamed2513() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2513(core.List<core.String> o) {
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

core.Map<core.String, core.String> buildUnnamed2514() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2514(core.Map<core.String, core.String> o) {
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

core.int buildCounterSoftwareConfig = 0;
api.SoftwareConfig buildSoftwareConfig() {
  var o = api.SoftwareConfig();
  buildCounterSoftwareConfig++;
  if (buildCounterSoftwareConfig < 3) {
    o.imageVersion = 'foo';
    o.optionalComponents = buildUnnamed2513();
    o.properties = buildUnnamed2514();
  }
  buildCounterSoftwareConfig--;
  return o;
}

void checkSoftwareConfig(api.SoftwareConfig o) {
  buildCounterSoftwareConfig++;
  if (buildCounterSoftwareConfig < 3) {
    unittest.expect(
      o.imageVersion!,
      unittest.equals('foo'),
    );
    checkUnnamed2513(o.optionalComponents!);
    checkUnnamed2514(o.properties!);
  }
  buildCounterSoftwareConfig--;
}

core.List<core.String> buildUnnamed2515() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2515(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed2516() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2516(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed2517() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2517(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed2518() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2518(core.List<core.String> o) {
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

core.Map<core.String, core.String> buildUnnamed2519() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2519(core.Map<core.String, core.String> o) {
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

core.int buildCounterSparkJob = 0;
api.SparkJob buildSparkJob() {
  var o = api.SparkJob();
  buildCounterSparkJob++;
  if (buildCounterSparkJob < 3) {
    o.archiveUris = buildUnnamed2515();
    o.args = buildUnnamed2516();
    o.fileUris = buildUnnamed2517();
    o.jarFileUris = buildUnnamed2518();
    o.loggingConfig = buildLoggingConfig();
    o.mainClass = 'foo';
    o.mainJarFileUri = 'foo';
    o.properties = buildUnnamed2519();
  }
  buildCounterSparkJob--;
  return o;
}

void checkSparkJob(api.SparkJob o) {
  buildCounterSparkJob++;
  if (buildCounterSparkJob < 3) {
    checkUnnamed2515(o.archiveUris!);
    checkUnnamed2516(o.args!);
    checkUnnamed2517(o.fileUris!);
    checkUnnamed2518(o.jarFileUris!);
    checkLoggingConfig(o.loggingConfig! as api.LoggingConfig);
    unittest.expect(
      o.mainClass!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.mainJarFileUri!,
      unittest.equals('foo'),
    );
    checkUnnamed2519(o.properties!);
  }
  buildCounterSparkJob--;
}

core.List<core.String> buildUnnamed2520() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2520(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed2521() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2521(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed2522() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2522(core.List<core.String> o) {
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

core.Map<core.String, core.String> buildUnnamed2523() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2523(core.Map<core.String, core.String> o) {
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

core.int buildCounterSparkRJob = 0;
api.SparkRJob buildSparkRJob() {
  var o = api.SparkRJob();
  buildCounterSparkRJob++;
  if (buildCounterSparkRJob < 3) {
    o.archiveUris = buildUnnamed2520();
    o.args = buildUnnamed2521();
    o.fileUris = buildUnnamed2522();
    o.loggingConfig = buildLoggingConfig();
    o.mainRFileUri = 'foo';
    o.properties = buildUnnamed2523();
  }
  buildCounterSparkRJob--;
  return o;
}

void checkSparkRJob(api.SparkRJob o) {
  buildCounterSparkRJob++;
  if (buildCounterSparkRJob < 3) {
    checkUnnamed2520(o.archiveUris!);
    checkUnnamed2521(o.args!);
    checkUnnamed2522(o.fileUris!);
    checkLoggingConfig(o.loggingConfig! as api.LoggingConfig);
    unittest.expect(
      o.mainRFileUri!,
      unittest.equals('foo'),
    );
    checkUnnamed2523(o.properties!);
  }
  buildCounterSparkRJob--;
}

core.List<core.String> buildUnnamed2524() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2524(core.List<core.String> o) {
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

core.Map<core.String, core.String> buildUnnamed2525() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2525(core.Map<core.String, core.String> o) {
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

core.Map<core.String, core.String> buildUnnamed2526() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2526(core.Map<core.String, core.String> o) {
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

core.int buildCounterSparkSqlJob = 0;
api.SparkSqlJob buildSparkSqlJob() {
  var o = api.SparkSqlJob();
  buildCounterSparkSqlJob++;
  if (buildCounterSparkSqlJob < 3) {
    o.jarFileUris = buildUnnamed2524();
    o.loggingConfig = buildLoggingConfig();
    o.properties = buildUnnamed2525();
    o.queryFileUri = 'foo';
    o.queryList = buildQueryList();
    o.scriptVariables = buildUnnamed2526();
  }
  buildCounterSparkSqlJob--;
  return o;
}

void checkSparkSqlJob(api.SparkSqlJob o) {
  buildCounterSparkSqlJob++;
  if (buildCounterSparkSqlJob < 3) {
    checkUnnamed2524(o.jarFileUris!);
    checkLoggingConfig(o.loggingConfig! as api.LoggingConfig);
    checkUnnamed2525(o.properties!);
    unittest.expect(
      o.queryFileUri!,
      unittest.equals('foo'),
    );
    checkQueryList(o.queryList! as api.QueryList);
    checkUnnamed2526(o.scriptVariables!);
  }
  buildCounterSparkSqlJob--;
}

core.int buildCounterStartClusterRequest = 0;
api.StartClusterRequest buildStartClusterRequest() {
  var o = api.StartClusterRequest();
  buildCounterStartClusterRequest++;
  if (buildCounterStartClusterRequest < 3) {
    o.clusterUuid = 'foo';
    o.requestId = 'foo';
  }
  buildCounterStartClusterRequest--;
  return o;
}

void checkStartClusterRequest(api.StartClusterRequest o) {
  buildCounterStartClusterRequest++;
  if (buildCounterStartClusterRequest < 3) {
    unittest.expect(
      o.clusterUuid!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.requestId!,
      unittest.equals('foo'),
    );
  }
  buildCounterStartClusterRequest--;
}

core.Map<core.String, core.Object> buildUnnamed2527() {
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

void checkUnnamed2527(core.Map<core.String, core.Object> o) {
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

core.List<core.Map<core.String, core.Object>> buildUnnamed2528() {
  var o = <core.Map<core.String, core.Object>>[];
  o.add(buildUnnamed2527());
  o.add(buildUnnamed2527());
  return o;
}

void checkUnnamed2528(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed2527(o[0]);
  checkUnnamed2527(o[1]);
}

core.int buildCounterStatus = 0;
api.Status buildStatus() {
  var o = api.Status();
  buildCounterStatus++;
  if (buildCounterStatus < 3) {
    o.code = 42;
    o.details = buildUnnamed2528();
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
    checkUnnamed2528(o.details!);
    unittest.expect(
      o.message!,
      unittest.equals('foo'),
    );
  }
  buildCounterStatus--;
}

core.int buildCounterStopClusterRequest = 0;
api.StopClusterRequest buildStopClusterRequest() {
  var o = api.StopClusterRequest();
  buildCounterStopClusterRequest++;
  if (buildCounterStopClusterRequest < 3) {
    o.clusterUuid = 'foo';
    o.requestId = 'foo';
  }
  buildCounterStopClusterRequest--;
  return o;
}

void checkStopClusterRequest(api.StopClusterRequest o) {
  buildCounterStopClusterRequest++;
  if (buildCounterStopClusterRequest < 3) {
    unittest.expect(
      o.clusterUuid!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.requestId!,
      unittest.equals('foo'),
    );
  }
  buildCounterStopClusterRequest--;
}

core.int buildCounterSubmitJobRequest = 0;
api.SubmitJobRequest buildSubmitJobRequest() {
  var o = api.SubmitJobRequest();
  buildCounterSubmitJobRequest++;
  if (buildCounterSubmitJobRequest < 3) {
    o.job = buildJob();
    o.requestId = 'foo';
  }
  buildCounterSubmitJobRequest--;
  return o;
}

void checkSubmitJobRequest(api.SubmitJobRequest o) {
  buildCounterSubmitJobRequest++;
  if (buildCounterSubmitJobRequest < 3) {
    checkJob(o.job! as api.Job);
    unittest.expect(
      o.requestId!,
      unittest.equals('foo'),
    );
  }
  buildCounterSubmitJobRequest--;
}

core.List<core.String> buildUnnamed2529() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2529(core.List<core.String> o) {
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

core.int buildCounterTemplateParameter = 0;
api.TemplateParameter buildTemplateParameter() {
  var o = api.TemplateParameter();
  buildCounterTemplateParameter++;
  if (buildCounterTemplateParameter < 3) {
    o.description = 'foo';
    o.fields = buildUnnamed2529();
    o.name = 'foo';
    o.validation = buildParameterValidation();
  }
  buildCounterTemplateParameter--;
  return o;
}

void checkTemplateParameter(api.TemplateParameter o) {
  buildCounterTemplateParameter++;
  if (buildCounterTemplateParameter < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    checkUnnamed2529(o.fields!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkParameterValidation(o.validation! as api.ParameterValidation);
  }
  buildCounterTemplateParameter--;
}

core.List<core.String> buildUnnamed2530() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2530(core.List<core.String> o) {
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

core.int buildCounterTestIamPermissionsRequest = 0;
api.TestIamPermissionsRequest buildTestIamPermissionsRequest() {
  var o = api.TestIamPermissionsRequest();
  buildCounterTestIamPermissionsRequest++;
  if (buildCounterTestIamPermissionsRequest < 3) {
    o.permissions = buildUnnamed2530();
  }
  buildCounterTestIamPermissionsRequest--;
  return o;
}

void checkTestIamPermissionsRequest(api.TestIamPermissionsRequest o) {
  buildCounterTestIamPermissionsRequest++;
  if (buildCounterTestIamPermissionsRequest < 3) {
    checkUnnamed2530(o.permissions!);
  }
  buildCounterTestIamPermissionsRequest--;
}

core.List<core.String> buildUnnamed2531() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2531(core.List<core.String> o) {
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

core.int buildCounterTestIamPermissionsResponse = 0;
api.TestIamPermissionsResponse buildTestIamPermissionsResponse() {
  var o = api.TestIamPermissionsResponse();
  buildCounterTestIamPermissionsResponse++;
  if (buildCounterTestIamPermissionsResponse < 3) {
    o.permissions = buildUnnamed2531();
  }
  buildCounterTestIamPermissionsResponse--;
  return o;
}

void checkTestIamPermissionsResponse(api.TestIamPermissionsResponse o) {
  buildCounterTestIamPermissionsResponse++;
  if (buildCounterTestIamPermissionsResponse < 3) {
    checkUnnamed2531(o.permissions!);
  }
  buildCounterTestIamPermissionsResponse--;
}

core.List<core.String> buildUnnamed2532() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2532(core.List<core.String> o) {
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

core.int buildCounterValueValidation = 0;
api.ValueValidation buildValueValidation() {
  var o = api.ValueValidation();
  buildCounterValueValidation++;
  if (buildCounterValueValidation < 3) {
    o.values = buildUnnamed2532();
  }
  buildCounterValueValidation--;
  return o;
}

void checkValueValidation(api.ValueValidation o) {
  buildCounterValueValidation++;
  if (buildCounterValueValidation < 3) {
    checkUnnamed2532(o.values!);
  }
  buildCounterValueValidation--;
}

core.List<api.WorkflowNode> buildUnnamed2533() {
  var o = <api.WorkflowNode>[];
  o.add(buildWorkflowNode());
  o.add(buildWorkflowNode());
  return o;
}

void checkUnnamed2533(core.List<api.WorkflowNode> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkWorkflowNode(o[0] as api.WorkflowNode);
  checkWorkflowNode(o[1] as api.WorkflowNode);
}

core.int buildCounterWorkflowGraph = 0;
api.WorkflowGraph buildWorkflowGraph() {
  var o = api.WorkflowGraph();
  buildCounterWorkflowGraph++;
  if (buildCounterWorkflowGraph < 3) {
    o.nodes = buildUnnamed2533();
  }
  buildCounterWorkflowGraph--;
  return o;
}

void checkWorkflowGraph(api.WorkflowGraph o) {
  buildCounterWorkflowGraph++;
  if (buildCounterWorkflowGraph < 3) {
    checkUnnamed2533(o.nodes!);
  }
  buildCounterWorkflowGraph--;
}

core.Map<core.String, core.String> buildUnnamed2534() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2534(core.Map<core.String, core.String> o) {
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

core.int buildCounterWorkflowMetadata = 0;
api.WorkflowMetadata buildWorkflowMetadata() {
  var o = api.WorkflowMetadata();
  buildCounterWorkflowMetadata++;
  if (buildCounterWorkflowMetadata < 3) {
    o.clusterName = 'foo';
    o.clusterUuid = 'foo';
    o.createCluster = buildClusterOperation();
    o.dagEndTime = 'foo';
    o.dagStartTime = 'foo';
    o.dagTimeout = 'foo';
    o.deleteCluster = buildClusterOperation();
    o.endTime = 'foo';
    o.graph = buildWorkflowGraph();
    o.parameters = buildUnnamed2534();
    o.startTime = 'foo';
    o.state = 'foo';
    o.template = 'foo';
    o.version = 42;
  }
  buildCounterWorkflowMetadata--;
  return o;
}

void checkWorkflowMetadata(api.WorkflowMetadata o) {
  buildCounterWorkflowMetadata++;
  if (buildCounterWorkflowMetadata < 3) {
    unittest.expect(
      o.clusterName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.clusterUuid!,
      unittest.equals('foo'),
    );
    checkClusterOperation(o.createCluster! as api.ClusterOperation);
    unittest.expect(
      o.dagEndTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.dagStartTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.dagTimeout!,
      unittest.equals('foo'),
    );
    checkClusterOperation(o.deleteCluster! as api.ClusterOperation);
    unittest.expect(
      o.endTime!,
      unittest.equals('foo'),
    );
    checkWorkflowGraph(o.graph! as api.WorkflowGraph);
    checkUnnamed2534(o.parameters!);
    unittest.expect(
      o.startTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.template!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.version!,
      unittest.equals(42),
    );
  }
  buildCounterWorkflowMetadata--;
}

core.List<core.String> buildUnnamed2535() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed2535(core.List<core.String> o) {
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

core.int buildCounterWorkflowNode = 0;
api.WorkflowNode buildWorkflowNode() {
  var o = api.WorkflowNode();
  buildCounterWorkflowNode++;
  if (buildCounterWorkflowNode < 3) {
    o.error = 'foo';
    o.jobId = 'foo';
    o.prerequisiteStepIds = buildUnnamed2535();
    o.state = 'foo';
    o.stepId = 'foo';
  }
  buildCounterWorkflowNode--;
  return o;
}

void checkWorkflowNode(api.WorkflowNode o) {
  buildCounterWorkflowNode++;
  if (buildCounterWorkflowNode < 3) {
    unittest.expect(
      o.error!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.jobId!,
      unittest.equals('foo'),
    );
    checkUnnamed2535(o.prerequisiteStepIds!);
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.stepId!,
      unittest.equals('foo'),
    );
  }
  buildCounterWorkflowNode--;
}

core.List<api.OrderedJob> buildUnnamed2536() {
  var o = <api.OrderedJob>[];
  o.add(buildOrderedJob());
  o.add(buildOrderedJob());
  return o;
}

void checkUnnamed2536(core.List<api.OrderedJob> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkOrderedJob(o[0] as api.OrderedJob);
  checkOrderedJob(o[1] as api.OrderedJob);
}

core.Map<core.String, core.String> buildUnnamed2537() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed2537(core.Map<core.String, core.String> o) {
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

core.List<api.TemplateParameter> buildUnnamed2538() {
  var o = <api.TemplateParameter>[];
  o.add(buildTemplateParameter());
  o.add(buildTemplateParameter());
  return o;
}

void checkUnnamed2538(core.List<api.TemplateParameter> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTemplateParameter(o[0] as api.TemplateParameter);
  checkTemplateParameter(o[1] as api.TemplateParameter);
}

core.int buildCounterWorkflowTemplate = 0;
api.WorkflowTemplate buildWorkflowTemplate() {
  var o = api.WorkflowTemplate();
  buildCounterWorkflowTemplate++;
  if (buildCounterWorkflowTemplate < 3) {
    o.createTime = 'foo';
    o.dagTimeout = 'foo';
    o.id = 'foo';
    o.jobs = buildUnnamed2536();
    o.labels = buildUnnamed2537();
    o.name = 'foo';
    o.parameters = buildUnnamed2538();
    o.placement = buildWorkflowTemplatePlacement();
    o.updateTime = 'foo';
    o.version = 42;
  }
  buildCounterWorkflowTemplate--;
  return o;
}

void checkWorkflowTemplate(api.WorkflowTemplate o) {
  buildCounterWorkflowTemplate++;
  if (buildCounterWorkflowTemplate < 3) {
    unittest.expect(
      o.createTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.dagTimeout!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.id!,
      unittest.equals('foo'),
    );
    checkUnnamed2536(o.jobs!);
    checkUnnamed2537(o.labels!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed2538(o.parameters!);
    checkWorkflowTemplatePlacement(
        o.placement! as api.WorkflowTemplatePlacement);
    unittest.expect(
      o.updateTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.version!,
      unittest.equals(42),
    );
  }
  buildCounterWorkflowTemplate--;
}

core.int buildCounterWorkflowTemplatePlacement = 0;
api.WorkflowTemplatePlacement buildWorkflowTemplatePlacement() {
  var o = api.WorkflowTemplatePlacement();
  buildCounterWorkflowTemplatePlacement++;
  if (buildCounterWorkflowTemplatePlacement < 3) {
    o.clusterSelector = buildClusterSelector();
    o.managedCluster = buildManagedCluster();
  }
  buildCounterWorkflowTemplatePlacement--;
  return o;
}

void checkWorkflowTemplatePlacement(api.WorkflowTemplatePlacement o) {
  buildCounterWorkflowTemplatePlacement++;
  if (buildCounterWorkflowTemplatePlacement < 3) {
    checkClusterSelector(o.clusterSelector! as api.ClusterSelector);
    checkManagedCluster(o.managedCluster! as api.ManagedCluster);
  }
  buildCounterWorkflowTemplatePlacement--;
}

core.int buildCounterYarnApplication = 0;
api.YarnApplication buildYarnApplication() {
  var o = api.YarnApplication();
  buildCounterYarnApplication++;
  if (buildCounterYarnApplication < 3) {
    o.name = 'foo';
    o.progress = 42.0;
    o.state = 'foo';
    o.trackingUrl = 'foo';
  }
  buildCounterYarnApplication--;
  return o;
}

void checkYarnApplication(api.YarnApplication o) {
  buildCounterYarnApplication++;
  if (buildCounterYarnApplication < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.progress!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.trackingUrl!,
      unittest.equals('foo'),
    );
  }
  buildCounterYarnApplication--;
}

void main() {
  unittest.group('obj-schema-AcceleratorConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildAcceleratorConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.AcceleratorConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkAcceleratorConfig(od as api.AcceleratorConfig);
    });
  });

  unittest.group('obj-schema-AutoscalingConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildAutoscalingConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.AutoscalingConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkAutoscalingConfig(od as api.AutoscalingConfig);
    });
  });

  unittest.group('obj-schema-AutoscalingPolicy', () {
    unittest.test('to-json--from-json', () async {
      var o = buildAutoscalingPolicy();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.AutoscalingPolicy.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkAutoscalingPolicy(od as api.AutoscalingPolicy);
    });
  });

  unittest.group('obj-schema-BasicAutoscalingAlgorithm', () {
    unittest.test('to-json--from-json', () async {
      var o = buildBasicAutoscalingAlgorithm();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.BasicAutoscalingAlgorithm.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkBasicAutoscalingAlgorithm(od as api.BasicAutoscalingAlgorithm);
    });
  });

  unittest.group('obj-schema-BasicYarnAutoscalingConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildBasicYarnAutoscalingConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.BasicYarnAutoscalingConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkBasicYarnAutoscalingConfig(od as api.BasicYarnAutoscalingConfig);
    });
  });

  unittest.group('obj-schema-Binding', () {
    unittest.test('to-json--from-json', () async {
      var o = buildBinding();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Binding.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkBinding(od as api.Binding);
    });
  });

  unittest.group('obj-schema-CancelJobRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildCancelJobRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.CancelJobRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkCancelJobRequest(od as api.CancelJobRequest);
    });
  });

  unittest.group('obj-schema-Cluster', () {
    unittest.test('to-json--from-json', () async {
      var o = buildCluster();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Cluster.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkCluster(od as api.Cluster);
    });
  });

  unittest.group('obj-schema-ClusterConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildClusterConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ClusterConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkClusterConfig(od as api.ClusterConfig);
    });
  });

  unittest.group('obj-schema-ClusterMetrics', () {
    unittest.test('to-json--from-json', () async {
      var o = buildClusterMetrics();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ClusterMetrics.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkClusterMetrics(od as api.ClusterMetrics);
    });
  });

  unittest.group('obj-schema-ClusterOperation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildClusterOperation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ClusterOperation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkClusterOperation(od as api.ClusterOperation);
    });
  });

  unittest.group('obj-schema-ClusterOperationMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildClusterOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ClusterOperationMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkClusterOperationMetadata(od as api.ClusterOperationMetadata);
    });
  });

  unittest.group('obj-schema-ClusterOperationStatus', () {
    unittest.test('to-json--from-json', () async {
      var o = buildClusterOperationStatus();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ClusterOperationStatus.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkClusterOperationStatus(od as api.ClusterOperationStatus);
    });
  });

  unittest.group('obj-schema-ClusterSelector', () {
    unittest.test('to-json--from-json', () async {
      var o = buildClusterSelector();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ClusterSelector.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkClusterSelector(od as api.ClusterSelector);
    });
  });

  unittest.group('obj-schema-ClusterStatus', () {
    unittest.test('to-json--from-json', () async {
      var o = buildClusterStatus();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ClusterStatus.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkClusterStatus(od as api.ClusterStatus);
    });
  });

  unittest.group('obj-schema-DiagnoseClusterRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildDiagnoseClusterRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.DiagnoseClusterRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkDiagnoseClusterRequest(od as api.DiagnoseClusterRequest);
    });
  });

  unittest.group('obj-schema-DiagnoseClusterResults', () {
    unittest.test('to-json--from-json', () async {
      var o = buildDiagnoseClusterResults();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.DiagnoseClusterResults.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkDiagnoseClusterResults(od as api.DiagnoseClusterResults);
    });
  });

  unittest.group('obj-schema-DiskConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildDiskConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.DiskConfig.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkDiskConfig(od as api.DiskConfig);
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

  unittest.group('obj-schema-EncryptionConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildEncryptionConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.EncryptionConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkEncryptionConfig(od as api.EncryptionConfig);
    });
  });

  unittest.group('obj-schema-EndpointConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildEndpointConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.EndpointConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkEndpointConfig(od as api.EndpointConfig);
    });
  });

  unittest.group('obj-schema-Expr', () {
    unittest.test('to-json--from-json', () async {
      var o = buildExpr();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.Expr.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkExpr(od as api.Expr);
    });
  });

  unittest.group('obj-schema-GceClusterConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGceClusterConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GceClusterConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGceClusterConfig(od as api.GceClusterConfig);
    });
  });

  unittest.group('obj-schema-GetIamPolicyRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGetIamPolicyRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GetIamPolicyRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGetIamPolicyRequest(od as api.GetIamPolicyRequest);
    });
  });

  unittest.group('obj-schema-GetPolicyOptions', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGetPolicyOptions();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GetPolicyOptions.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGetPolicyOptions(od as api.GetPolicyOptions);
    });
  });

  unittest.group('obj-schema-HadoopJob', () {
    unittest.test('to-json--from-json', () async {
      var o = buildHadoopJob();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.HadoopJob.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkHadoopJob(od as api.HadoopJob);
    });
  });

  unittest.group('obj-schema-HiveJob', () {
    unittest.test('to-json--from-json', () async {
      var o = buildHiveJob();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.HiveJob.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkHiveJob(od as api.HiveJob);
    });
  });

  unittest.group('obj-schema-InjectCredentialsRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildInjectCredentialsRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.InjectCredentialsRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkInjectCredentialsRequest(od as api.InjectCredentialsRequest);
    });
  });

  unittest.group('obj-schema-InstanceGroupAutoscalingPolicyConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildInstanceGroupAutoscalingPolicyConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.InstanceGroupAutoscalingPolicyConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkInstanceGroupAutoscalingPolicyConfig(
          od as api.InstanceGroupAutoscalingPolicyConfig);
    });
  });

  unittest.group('obj-schema-InstanceGroupConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildInstanceGroupConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.InstanceGroupConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkInstanceGroupConfig(od as api.InstanceGroupConfig);
    });
  });

  unittest.group('obj-schema-InstanceReference', () {
    unittest.test('to-json--from-json', () async {
      var o = buildInstanceReference();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.InstanceReference.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkInstanceReference(od as api.InstanceReference);
    });
  });

  unittest.group('obj-schema-InstantiateWorkflowTemplateRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildInstantiateWorkflowTemplateRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.InstantiateWorkflowTemplateRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkInstantiateWorkflowTemplateRequest(
          od as api.InstantiateWorkflowTemplateRequest);
    });
  });

  unittest.group('obj-schema-Job', () {
    unittest.test('to-json--from-json', () async {
      var o = buildJob();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.Job.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkJob(od as api.Job);
    });
  });

  unittest.group('obj-schema-JobMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildJobMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.JobMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkJobMetadata(od as api.JobMetadata);
    });
  });

  unittest.group('obj-schema-JobPlacement', () {
    unittest.test('to-json--from-json', () async {
      var o = buildJobPlacement();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.JobPlacement.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkJobPlacement(od as api.JobPlacement);
    });
  });

  unittest.group('obj-schema-JobReference', () {
    unittest.test('to-json--from-json', () async {
      var o = buildJobReference();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.JobReference.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkJobReference(od as api.JobReference);
    });
  });

  unittest.group('obj-schema-JobScheduling', () {
    unittest.test('to-json--from-json', () async {
      var o = buildJobScheduling();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.JobScheduling.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkJobScheduling(od as api.JobScheduling);
    });
  });

  unittest.group('obj-schema-JobStatus', () {
    unittest.test('to-json--from-json', () async {
      var o = buildJobStatus();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.JobStatus.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkJobStatus(od as api.JobStatus);
    });
  });

  unittest.group('obj-schema-KerberosConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildKerberosConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.KerberosConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkKerberosConfig(od as api.KerberosConfig);
    });
  });

  unittest.group('obj-schema-LifecycleConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildLifecycleConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.LifecycleConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkLifecycleConfig(od as api.LifecycleConfig);
    });
  });

  unittest.group('obj-schema-ListAutoscalingPoliciesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildListAutoscalingPoliciesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ListAutoscalingPoliciesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkListAutoscalingPoliciesResponse(
          od as api.ListAutoscalingPoliciesResponse);
    });
  });

  unittest.group('obj-schema-ListClustersResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildListClustersResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ListClustersResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkListClustersResponse(od as api.ListClustersResponse);
    });
  });

  unittest.group('obj-schema-ListJobsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildListJobsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ListJobsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkListJobsResponse(od as api.ListJobsResponse);
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

  unittest.group('obj-schema-ListWorkflowTemplatesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildListWorkflowTemplatesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ListWorkflowTemplatesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkListWorkflowTemplatesResponse(
          od as api.ListWorkflowTemplatesResponse);
    });
  });

  unittest.group('obj-schema-LoggingConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildLoggingConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.LoggingConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkLoggingConfig(od as api.LoggingConfig);
    });
  });

  unittest.group('obj-schema-ManagedCluster', () {
    unittest.test('to-json--from-json', () async {
      var o = buildManagedCluster();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ManagedCluster.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkManagedCluster(od as api.ManagedCluster);
    });
  });

  unittest.group('obj-schema-ManagedGroupConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildManagedGroupConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ManagedGroupConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkManagedGroupConfig(od as api.ManagedGroupConfig);
    });
  });

  unittest.group('obj-schema-MetastoreConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildMetastoreConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.MetastoreConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkMetastoreConfig(od as api.MetastoreConfig);
    });
  });

  unittest.group('obj-schema-NodeGroupAffinity', () {
    unittest.test('to-json--from-json', () async {
      var o = buildNodeGroupAffinity();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.NodeGroupAffinity.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkNodeGroupAffinity(od as api.NodeGroupAffinity);
    });
  });

  unittest.group('obj-schema-NodeInitializationAction', () {
    unittest.test('to-json--from-json', () async {
      var o = buildNodeInitializationAction();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.NodeInitializationAction.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkNodeInitializationAction(od as api.NodeInitializationAction);
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

  unittest.group('obj-schema-OrderedJob', () {
    unittest.test('to-json--from-json', () async {
      var o = buildOrderedJob();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.OrderedJob.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkOrderedJob(od as api.OrderedJob);
    });
  });

  unittest.group('obj-schema-ParameterValidation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildParameterValidation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ParameterValidation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkParameterValidation(od as api.ParameterValidation);
    });
  });

  unittest.group('obj-schema-PigJob', () {
    unittest.test('to-json--from-json', () async {
      var o = buildPigJob();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.PigJob.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkPigJob(od as api.PigJob);
    });
  });

  unittest.group('obj-schema-Policy', () {
    unittest.test('to-json--from-json', () async {
      var o = buildPolicy();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Policy.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkPolicy(od as api.Policy);
    });
  });

  unittest.group('obj-schema-PrestoJob', () {
    unittest.test('to-json--from-json', () async {
      var o = buildPrestoJob();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.PrestoJob.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkPrestoJob(od as api.PrestoJob);
    });
  });

  unittest.group('obj-schema-PySparkJob', () {
    unittest.test('to-json--from-json', () async {
      var o = buildPySparkJob();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.PySparkJob.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkPySparkJob(od as api.PySparkJob);
    });
  });

  unittest.group('obj-schema-QueryList', () {
    unittest.test('to-json--from-json', () async {
      var o = buildQueryList();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.QueryList.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkQueryList(od as api.QueryList);
    });
  });

  unittest.group('obj-schema-RegexValidation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildRegexValidation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.RegexValidation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkRegexValidation(od as api.RegexValidation);
    });
  });

  unittest.group('obj-schema-ReservationAffinity', () {
    unittest.test('to-json--from-json', () async {
      var o = buildReservationAffinity();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ReservationAffinity.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkReservationAffinity(od as api.ReservationAffinity);
    });
  });

  unittest.group('obj-schema-SecurityConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildSecurityConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.SecurityConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkSecurityConfig(od as api.SecurityConfig);
    });
  });

  unittest.group('obj-schema-SetIamPolicyRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildSetIamPolicyRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.SetIamPolicyRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkSetIamPolicyRequest(od as api.SetIamPolicyRequest);
    });
  });

  unittest.group('obj-schema-ShieldedInstanceConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildShieldedInstanceConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ShieldedInstanceConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkShieldedInstanceConfig(od as api.ShieldedInstanceConfig);
    });
  });

  unittest.group('obj-schema-SoftwareConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildSoftwareConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.SoftwareConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkSoftwareConfig(od as api.SoftwareConfig);
    });
  });

  unittest.group('obj-schema-SparkJob', () {
    unittest.test('to-json--from-json', () async {
      var o = buildSparkJob();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.SparkJob.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkSparkJob(od as api.SparkJob);
    });
  });

  unittest.group('obj-schema-SparkRJob', () {
    unittest.test('to-json--from-json', () async {
      var o = buildSparkRJob();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.SparkRJob.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkSparkRJob(od as api.SparkRJob);
    });
  });

  unittest.group('obj-schema-SparkSqlJob', () {
    unittest.test('to-json--from-json', () async {
      var o = buildSparkSqlJob();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.SparkSqlJob.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkSparkSqlJob(od as api.SparkSqlJob);
    });
  });

  unittest.group('obj-schema-StartClusterRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildStartClusterRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.StartClusterRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkStartClusterRequest(od as api.StartClusterRequest);
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

  unittest.group('obj-schema-StopClusterRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildStopClusterRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.StopClusterRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkStopClusterRequest(od as api.StopClusterRequest);
    });
  });

  unittest.group('obj-schema-SubmitJobRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildSubmitJobRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.SubmitJobRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkSubmitJobRequest(od as api.SubmitJobRequest);
    });
  });

  unittest.group('obj-schema-TemplateParameter', () {
    unittest.test('to-json--from-json', () async {
      var o = buildTemplateParameter();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.TemplateParameter.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkTemplateParameter(od as api.TemplateParameter);
    });
  });

  unittest.group('obj-schema-TestIamPermissionsRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildTestIamPermissionsRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.TestIamPermissionsRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkTestIamPermissionsRequest(od as api.TestIamPermissionsRequest);
    });
  });

  unittest.group('obj-schema-TestIamPermissionsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildTestIamPermissionsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.TestIamPermissionsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkTestIamPermissionsResponse(od as api.TestIamPermissionsResponse);
    });
  });

  unittest.group('obj-schema-ValueValidation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildValueValidation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ValueValidation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkValueValidation(od as api.ValueValidation);
    });
  });

  unittest.group('obj-schema-WorkflowGraph', () {
    unittest.test('to-json--from-json', () async {
      var o = buildWorkflowGraph();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.WorkflowGraph.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkWorkflowGraph(od as api.WorkflowGraph);
    });
  });

  unittest.group('obj-schema-WorkflowMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildWorkflowMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.WorkflowMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkWorkflowMetadata(od as api.WorkflowMetadata);
    });
  });

  unittest.group('obj-schema-WorkflowNode', () {
    unittest.test('to-json--from-json', () async {
      var o = buildWorkflowNode();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.WorkflowNode.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkWorkflowNode(od as api.WorkflowNode);
    });
  });

  unittest.group('obj-schema-WorkflowTemplate', () {
    unittest.test('to-json--from-json', () async {
      var o = buildWorkflowTemplate();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.WorkflowTemplate.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkWorkflowTemplate(od as api.WorkflowTemplate);
    });
  });

  unittest.group('obj-schema-WorkflowTemplatePlacement', () {
    unittest.test('to-json--from-json', () async {
      var o = buildWorkflowTemplatePlacement();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.WorkflowTemplatePlacement.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkWorkflowTemplatePlacement(od as api.WorkflowTemplatePlacement);
    });
  });

  unittest.group('obj-schema-YarnApplication', () {
    unittest.test('to-json--from-json', () async {
      var o = buildYarnApplication();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.YarnApplication.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkYarnApplication(od as api.YarnApplication);
    });
  });

  unittest.group('resource-ProjectsLocationsAutoscalingPoliciesResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.locations.autoscalingPolicies;
      var arg_request = buildAutoscalingPolicy();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.AutoscalingPolicy.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkAutoscalingPolicy(obj as api.AutoscalingPolicy);

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
        var resp = convert.json.encode(buildAutoscalingPolicy());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkAutoscalingPolicy(response as api.AutoscalingPolicy);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.locations.autoscalingPolicies;
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
      var res = api.DataprocApi(mock).projects.locations.autoscalingPolicies;
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
        var resp = convert.json.encode(buildAutoscalingPolicy());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkAutoscalingPolicy(response as api.AutoscalingPolicy);
    });

    unittest.test('method--getIamPolicy', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.locations.autoscalingPolicies;
      var arg_request = buildGetIamPolicyRequest();
      var arg_resource = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GetIamPolicyRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGetIamPolicyRequest(obj as api.GetIamPolicyRequest);

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
        var resp = convert.json.encode(buildPolicy());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.getIamPolicy(arg_request, arg_resource,
          $fields: arg_$fields);
      checkPolicy(response as api.Policy);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.locations.autoscalingPolicies;
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
        var resp = convert.json.encode(buildListAutoscalingPoliciesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkListAutoscalingPoliciesResponse(
          response as api.ListAutoscalingPoliciesResponse);
    });

    unittest.test('method--setIamPolicy', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.locations.autoscalingPolicies;
      var arg_request = buildSetIamPolicyRequest();
      var arg_resource = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.SetIamPolicyRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkSetIamPolicyRequest(obj as api.SetIamPolicyRequest);

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
        var resp = convert.json.encode(buildPolicy());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.setIamPolicy(arg_request, arg_resource,
          $fields: arg_$fields);
      checkPolicy(response as api.Policy);
    });

    unittest.test('method--testIamPermissions', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.locations.autoscalingPolicies;
      var arg_request = buildTestIamPermissionsRequest();
      var arg_resource = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.TestIamPermissionsRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkTestIamPermissionsRequest(obj as api.TestIamPermissionsRequest);

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
        var resp = convert.json.encode(buildTestIamPermissionsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.testIamPermissions(arg_request, arg_resource,
          $fields: arg_$fields);
      checkTestIamPermissionsResponse(
          response as api.TestIamPermissionsResponse);
    });

    unittest.test('method--update', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.locations.autoscalingPolicies;
      var arg_request = buildAutoscalingPolicy();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.AutoscalingPolicy.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkAutoscalingPolicy(obj as api.AutoscalingPolicy);

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
        var resp = convert.json.encode(buildAutoscalingPolicy());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.update(arg_request, arg_name, $fields: arg_$fields);
      checkAutoscalingPolicy(response as api.AutoscalingPolicy);
    });
  });

  unittest.group('resource-ProjectsLocationsWorkflowTemplatesResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.locations.workflowTemplates;
      var arg_request = buildWorkflowTemplate();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.WorkflowTemplate.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkWorkflowTemplate(obj as api.WorkflowTemplate);

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
        var resp = convert.json.encode(buildWorkflowTemplate());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkWorkflowTemplate(response as api.WorkflowTemplate);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.locations.workflowTemplates;
      var arg_name = 'foo';
      var arg_version = 42;
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
          core.int.parse(queryMap["version"]!.first),
          unittest.equals(arg_version),
        );
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
      final response = await res.delete(arg_name,
          version: arg_version, $fields: arg_$fields);
      checkEmpty(response as api.Empty);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.locations.workflowTemplates;
      var arg_name = 'foo';
      var arg_version = 42;
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
          core.int.parse(queryMap["version"]!.first),
          unittest.equals(arg_version),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildWorkflowTemplate());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.get(arg_name, version: arg_version, $fields: arg_$fields);
      checkWorkflowTemplate(response as api.WorkflowTemplate);
    });

    unittest.test('method--getIamPolicy', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.locations.workflowTemplates;
      var arg_request = buildGetIamPolicyRequest();
      var arg_resource = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GetIamPolicyRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGetIamPolicyRequest(obj as api.GetIamPolicyRequest);

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
        var resp = convert.json.encode(buildPolicy());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.getIamPolicy(arg_request, arg_resource,
          $fields: arg_$fields);
      checkPolicy(response as api.Policy);
    });

    unittest.test('method--instantiate', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.locations.workflowTemplates;
      var arg_request = buildInstantiateWorkflowTemplateRequest();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.InstantiateWorkflowTemplateRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkInstantiateWorkflowTemplateRequest(
            obj as api.InstantiateWorkflowTemplateRequest);

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
          await res.instantiate(arg_request, arg_name, $fields: arg_$fields);
      checkOperation(response as api.Operation);
    });

    unittest.test('method--instantiateInline', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.locations.workflowTemplates;
      var arg_request = buildWorkflowTemplate();
      var arg_parent = 'foo';
      var arg_requestId = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.WorkflowTemplate.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkWorkflowTemplate(obj as api.WorkflowTemplate);

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
          queryMap["requestId"]!.first,
          unittest.equals(arg_requestId),
        );
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
      final response = await res.instantiateInline(arg_request, arg_parent,
          requestId: arg_requestId, $fields: arg_$fields);
      checkOperation(response as api.Operation);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.locations.workflowTemplates;
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
        var resp = convert.json.encode(buildListWorkflowTemplatesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkListWorkflowTemplatesResponse(
          response as api.ListWorkflowTemplatesResponse);
    });

    unittest.test('method--setIamPolicy', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.locations.workflowTemplates;
      var arg_request = buildSetIamPolicyRequest();
      var arg_resource = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.SetIamPolicyRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkSetIamPolicyRequest(obj as api.SetIamPolicyRequest);

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
        var resp = convert.json.encode(buildPolicy());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.setIamPolicy(arg_request, arg_resource,
          $fields: arg_$fields);
      checkPolicy(response as api.Policy);
    });

    unittest.test('method--testIamPermissions', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.locations.workflowTemplates;
      var arg_request = buildTestIamPermissionsRequest();
      var arg_resource = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.TestIamPermissionsRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkTestIamPermissionsRequest(obj as api.TestIamPermissionsRequest);

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
        var resp = convert.json.encode(buildTestIamPermissionsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.testIamPermissions(arg_request, arg_resource,
          $fields: arg_$fields);
      checkTestIamPermissionsResponse(
          response as api.TestIamPermissionsResponse);
    });

    unittest.test('method--update', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.locations.workflowTemplates;
      var arg_request = buildWorkflowTemplate();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.WorkflowTemplate.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkWorkflowTemplate(obj as api.WorkflowTemplate);

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
        var resp = convert.json.encode(buildWorkflowTemplate());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.update(arg_request, arg_name, $fields: arg_$fields);
      checkWorkflowTemplate(response as api.WorkflowTemplate);
    });
  });

  unittest.group('resource-ProjectsRegionsAutoscalingPoliciesResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.autoscalingPolicies;
      var arg_request = buildAutoscalingPolicy();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.AutoscalingPolicy.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkAutoscalingPolicy(obj as api.AutoscalingPolicy);

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
        var resp = convert.json.encode(buildAutoscalingPolicy());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkAutoscalingPolicy(response as api.AutoscalingPolicy);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.autoscalingPolicies;
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
      var res = api.DataprocApi(mock).projects.regions.autoscalingPolicies;
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
        var resp = convert.json.encode(buildAutoscalingPolicy());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkAutoscalingPolicy(response as api.AutoscalingPolicy);
    });

    unittest.test('method--getIamPolicy', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.autoscalingPolicies;
      var arg_request = buildGetIamPolicyRequest();
      var arg_resource = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GetIamPolicyRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGetIamPolicyRequest(obj as api.GetIamPolicyRequest);

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
        var resp = convert.json.encode(buildPolicy());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.getIamPolicy(arg_request, arg_resource,
          $fields: arg_$fields);
      checkPolicy(response as api.Policy);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.autoscalingPolicies;
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
        var resp = convert.json.encode(buildListAutoscalingPoliciesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkListAutoscalingPoliciesResponse(
          response as api.ListAutoscalingPoliciesResponse);
    });

    unittest.test('method--setIamPolicy', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.autoscalingPolicies;
      var arg_request = buildSetIamPolicyRequest();
      var arg_resource = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.SetIamPolicyRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkSetIamPolicyRequest(obj as api.SetIamPolicyRequest);

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
        var resp = convert.json.encode(buildPolicy());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.setIamPolicy(arg_request, arg_resource,
          $fields: arg_$fields);
      checkPolicy(response as api.Policy);
    });

    unittest.test('method--testIamPermissions', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.autoscalingPolicies;
      var arg_request = buildTestIamPermissionsRequest();
      var arg_resource = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.TestIamPermissionsRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkTestIamPermissionsRequest(obj as api.TestIamPermissionsRequest);

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
        var resp = convert.json.encode(buildTestIamPermissionsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.testIamPermissions(arg_request, arg_resource,
          $fields: arg_$fields);
      checkTestIamPermissionsResponse(
          response as api.TestIamPermissionsResponse);
    });

    unittest.test('method--update', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.autoscalingPolicies;
      var arg_request = buildAutoscalingPolicy();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.AutoscalingPolicy.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkAutoscalingPolicy(obj as api.AutoscalingPolicy);

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
        var resp = convert.json.encode(buildAutoscalingPolicy());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.update(arg_request, arg_name, $fields: arg_$fields);
      checkAutoscalingPolicy(response as api.AutoscalingPolicy);
    });
  });

  unittest.group('resource-ProjectsRegionsClustersResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.clusters;
      var arg_request = buildCluster();
      var arg_projectId = 'foo';
      var arg_region = 'foo';
      var arg_requestId = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj =
            api.Cluster.fromJson(json as core.Map<core.String, core.dynamic>);
        checkCluster(obj as api.Cluster);

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
          path.substring(pathOffset, pathOffset + 12),
          unittest.equals("v1/projects/"),
        );
        pathOffset += 12;
        index = path.indexOf('/regions/', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_projectId'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 9),
          unittest.equals("/regions/"),
        );
        pathOffset += 9;
        index = path.indexOf('/clusters', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_region'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 9),
          unittest.equals("/clusters"),
        );
        pathOffset += 9;

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
          queryMap["requestId"]!.first,
          unittest.equals(arg_requestId),
        );
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
      final response = await res.create(arg_request, arg_projectId, arg_region,
          requestId: arg_requestId, $fields: arg_$fields);
      checkOperation(response as api.Operation);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.clusters;
      var arg_projectId = 'foo';
      var arg_region = 'foo';
      var arg_clusterName = 'foo';
      var arg_clusterUuid = 'foo';
      var arg_requestId = 'foo';
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
          path.substring(pathOffset, pathOffset + 12),
          unittest.equals("v1/projects/"),
        );
        pathOffset += 12;
        index = path.indexOf('/regions/', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_projectId'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 9),
          unittest.equals("/regions/"),
        );
        pathOffset += 9;
        index = path.indexOf('/clusters/', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_region'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 10),
          unittest.equals("/clusters/"),
        );
        pathOffset += 10;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(
          subPart,
          unittest.equals('$arg_clusterName'),
        );

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
          queryMap["clusterUuid"]!.first,
          unittest.equals(arg_clusterUuid),
        );
        unittest.expect(
          queryMap["requestId"]!.first,
          unittest.equals(arg_requestId),
        );
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
      final response = await res.delete(
          arg_projectId, arg_region, arg_clusterName,
          clusterUuid: arg_clusterUuid,
          requestId: arg_requestId,
          $fields: arg_$fields);
      checkOperation(response as api.Operation);
    });

    unittest.test('method--diagnose', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.clusters;
      var arg_request = buildDiagnoseClusterRequest();
      var arg_projectId = 'foo';
      var arg_region = 'foo';
      var arg_clusterName = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.DiagnoseClusterRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkDiagnoseClusterRequest(obj as api.DiagnoseClusterRequest);

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
          path.substring(pathOffset, pathOffset + 12),
          unittest.equals("v1/projects/"),
        );
        pathOffset += 12;
        index = path.indexOf('/regions/', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_projectId'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 9),
          unittest.equals("/regions/"),
        );
        pathOffset += 9;
        index = path.indexOf('/clusters/', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_region'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 10),
          unittest.equals("/clusters/"),
        );
        pathOffset += 10;
        index = path.indexOf(':diagnose', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_clusterName'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 9),
          unittest.equals(":diagnose"),
        );
        pathOffset += 9;

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
      final response = await res.diagnose(
          arg_request, arg_projectId, arg_region, arg_clusterName,
          $fields: arg_$fields);
      checkOperation(response as api.Operation);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.clusters;
      var arg_projectId = 'foo';
      var arg_region = 'foo';
      var arg_clusterName = 'foo';
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
          path.substring(pathOffset, pathOffset + 12),
          unittest.equals("v1/projects/"),
        );
        pathOffset += 12;
        index = path.indexOf('/regions/', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_projectId'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 9),
          unittest.equals("/regions/"),
        );
        pathOffset += 9;
        index = path.indexOf('/clusters/', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_region'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 10),
          unittest.equals("/clusters/"),
        );
        pathOffset += 10;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(
          subPart,
          unittest.equals('$arg_clusterName'),
        );

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
        var resp = convert.json.encode(buildCluster());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_projectId, arg_region, arg_clusterName,
          $fields: arg_$fields);
      checkCluster(response as api.Cluster);
    });

    unittest.test('method--getIamPolicy', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.clusters;
      var arg_request = buildGetIamPolicyRequest();
      var arg_resource = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GetIamPolicyRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGetIamPolicyRequest(obj as api.GetIamPolicyRequest);

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
        var resp = convert.json.encode(buildPolicy());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.getIamPolicy(arg_request, arg_resource,
          $fields: arg_$fields);
      checkPolicy(response as api.Policy);
    });

    unittest.test('method--injectCredentials', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.clusters;
      var arg_request = buildInjectCredentialsRequest();
      var arg_project = 'foo';
      var arg_region = 'foo';
      var arg_cluster = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.InjectCredentialsRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkInjectCredentialsRequest(obj as api.InjectCredentialsRequest);

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
      final response = await res.injectCredentials(
          arg_request, arg_project, arg_region, arg_cluster,
          $fields: arg_$fields);
      checkOperation(response as api.Operation);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.clusters;
      var arg_projectId = 'foo';
      var arg_region = 'foo';
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
          path.substring(pathOffset, pathOffset + 12),
          unittest.equals("v1/projects/"),
        );
        pathOffset += 12;
        index = path.indexOf('/regions/', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_projectId'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 9),
          unittest.equals("/regions/"),
        );
        pathOffset += 9;
        index = path.indexOf('/clusters', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_region'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 9),
          unittest.equals("/clusters"),
        );
        pathOffset += 9;

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
        var resp = convert.json.encode(buildListClustersResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_projectId, arg_region,
          filter: arg_filter,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkListClustersResponse(response as api.ListClustersResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.clusters;
      var arg_request = buildCluster();
      var arg_projectId = 'foo';
      var arg_region = 'foo';
      var arg_clusterName = 'foo';
      var arg_gracefulDecommissionTimeout = 'foo';
      var arg_requestId = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj =
            api.Cluster.fromJson(json as core.Map<core.String, core.dynamic>);
        checkCluster(obj as api.Cluster);

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
          path.substring(pathOffset, pathOffset + 12),
          unittest.equals("v1/projects/"),
        );
        pathOffset += 12;
        index = path.indexOf('/regions/', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_projectId'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 9),
          unittest.equals("/regions/"),
        );
        pathOffset += 9;
        index = path.indexOf('/clusters/', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_region'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 10),
          unittest.equals("/clusters/"),
        );
        pathOffset += 10;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(
          subPart,
          unittest.equals('$arg_clusterName'),
        );

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
          queryMap["gracefulDecommissionTimeout"]!.first,
          unittest.equals(arg_gracefulDecommissionTimeout),
        );
        unittest.expect(
          queryMap["requestId"]!.first,
          unittest.equals(arg_requestId),
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
        var resp = convert.json.encode(buildOperation());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(
          arg_request, arg_projectId, arg_region, arg_clusterName,
          gracefulDecommissionTimeout: arg_gracefulDecommissionTimeout,
          requestId: arg_requestId,
          updateMask: arg_updateMask,
          $fields: arg_$fields);
      checkOperation(response as api.Operation);
    });

    unittest.test('method--setIamPolicy', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.clusters;
      var arg_request = buildSetIamPolicyRequest();
      var arg_resource = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.SetIamPolicyRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkSetIamPolicyRequest(obj as api.SetIamPolicyRequest);

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
        var resp = convert.json.encode(buildPolicy());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.setIamPolicy(arg_request, arg_resource,
          $fields: arg_$fields);
      checkPolicy(response as api.Policy);
    });

    unittest.test('method--start', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.clusters;
      var arg_request = buildStartClusterRequest();
      var arg_projectId = 'foo';
      var arg_region = 'foo';
      var arg_clusterName = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.StartClusterRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkStartClusterRequest(obj as api.StartClusterRequest);

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
          path.substring(pathOffset, pathOffset + 12),
          unittest.equals("v1/projects/"),
        );
        pathOffset += 12;
        index = path.indexOf('/regions/', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_projectId'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 9),
          unittest.equals("/regions/"),
        );
        pathOffset += 9;
        index = path.indexOf('/clusters/', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_region'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 10),
          unittest.equals("/clusters/"),
        );
        pathOffset += 10;
        index = path.indexOf(':start', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_clusterName'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 6),
          unittest.equals(":start"),
        );
        pathOffset += 6;

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
      final response = await res.start(
          arg_request, arg_projectId, arg_region, arg_clusterName,
          $fields: arg_$fields);
      checkOperation(response as api.Operation);
    });

    unittest.test('method--stop', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.clusters;
      var arg_request = buildStopClusterRequest();
      var arg_projectId = 'foo';
      var arg_region = 'foo';
      var arg_clusterName = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.StopClusterRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkStopClusterRequest(obj as api.StopClusterRequest);

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
          path.substring(pathOffset, pathOffset + 12),
          unittest.equals("v1/projects/"),
        );
        pathOffset += 12;
        index = path.indexOf('/regions/', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_projectId'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 9),
          unittest.equals("/regions/"),
        );
        pathOffset += 9;
        index = path.indexOf('/clusters/', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_region'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 10),
          unittest.equals("/clusters/"),
        );
        pathOffset += 10;
        index = path.indexOf(':stop', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_clusterName'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 5),
          unittest.equals(":stop"),
        );
        pathOffset += 5;

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
      final response = await res.stop(
          arg_request, arg_projectId, arg_region, arg_clusterName,
          $fields: arg_$fields);
      checkOperation(response as api.Operation);
    });

    unittest.test('method--testIamPermissions', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.clusters;
      var arg_request = buildTestIamPermissionsRequest();
      var arg_resource = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.TestIamPermissionsRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkTestIamPermissionsRequest(obj as api.TestIamPermissionsRequest);

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
        var resp = convert.json.encode(buildTestIamPermissionsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.testIamPermissions(arg_request, arg_resource,
          $fields: arg_$fields);
      checkTestIamPermissionsResponse(
          response as api.TestIamPermissionsResponse);
    });
  });

  unittest.group('resource-ProjectsRegionsJobsResource', () {
    unittest.test('method--cancel', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.jobs;
      var arg_request = buildCancelJobRequest();
      var arg_projectId = 'foo';
      var arg_region = 'foo';
      var arg_jobId = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.CancelJobRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkCancelJobRequest(obj as api.CancelJobRequest);

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
          path.substring(pathOffset, pathOffset + 12),
          unittest.equals("v1/projects/"),
        );
        pathOffset += 12;
        index = path.indexOf('/regions/', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_projectId'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 9),
          unittest.equals("/regions/"),
        );
        pathOffset += 9;
        index = path.indexOf('/jobs/', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_region'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 6),
          unittest.equals("/jobs/"),
        );
        pathOffset += 6;
        index = path.indexOf(':cancel', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_jobId'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 7),
          unittest.equals(":cancel"),
        );
        pathOffset += 7;

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
        var resp = convert.json.encode(buildJob());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.cancel(
          arg_request, arg_projectId, arg_region, arg_jobId,
          $fields: arg_$fields);
      checkJob(response as api.Job);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.jobs;
      var arg_projectId = 'foo';
      var arg_region = 'foo';
      var arg_jobId = 'foo';
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
          path.substring(pathOffset, pathOffset + 12),
          unittest.equals("v1/projects/"),
        );
        pathOffset += 12;
        index = path.indexOf('/regions/', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_projectId'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 9),
          unittest.equals("/regions/"),
        );
        pathOffset += 9;
        index = path.indexOf('/jobs/', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_region'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 6),
          unittest.equals("/jobs/"),
        );
        pathOffset += 6;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(
          subPart,
          unittest.equals('$arg_jobId'),
        );

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
      final response = await res.delete(arg_projectId, arg_region, arg_jobId,
          $fields: arg_$fields);
      checkEmpty(response as api.Empty);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.jobs;
      var arg_projectId = 'foo';
      var arg_region = 'foo';
      var arg_jobId = 'foo';
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
          path.substring(pathOffset, pathOffset + 12),
          unittest.equals("v1/projects/"),
        );
        pathOffset += 12;
        index = path.indexOf('/regions/', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_projectId'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 9),
          unittest.equals("/regions/"),
        );
        pathOffset += 9;
        index = path.indexOf('/jobs/', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_region'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 6),
          unittest.equals("/jobs/"),
        );
        pathOffset += 6;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(
          subPart,
          unittest.equals('$arg_jobId'),
        );

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
        var resp = convert.json.encode(buildJob());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_projectId, arg_region, arg_jobId,
          $fields: arg_$fields);
      checkJob(response as api.Job);
    });

    unittest.test('method--getIamPolicy', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.jobs;
      var arg_request = buildGetIamPolicyRequest();
      var arg_resource = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GetIamPolicyRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGetIamPolicyRequest(obj as api.GetIamPolicyRequest);

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
        var resp = convert.json.encode(buildPolicy());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.getIamPolicy(arg_request, arg_resource,
          $fields: arg_$fields);
      checkPolicy(response as api.Policy);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.jobs;
      var arg_projectId = 'foo';
      var arg_region = 'foo';
      var arg_clusterName = 'foo';
      var arg_filter = 'foo';
      var arg_jobStateMatcher = 'foo';
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
          path.substring(pathOffset, pathOffset + 12),
          unittest.equals("v1/projects/"),
        );
        pathOffset += 12;
        index = path.indexOf('/regions/', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_projectId'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 9),
          unittest.equals("/regions/"),
        );
        pathOffset += 9;
        index = path.indexOf('/jobs', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_region'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 5),
          unittest.equals("/jobs"),
        );
        pathOffset += 5;

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
          queryMap["clusterName"]!.first,
          unittest.equals(arg_clusterName),
        );
        unittest.expect(
          queryMap["filter"]!.first,
          unittest.equals(arg_filter),
        );
        unittest.expect(
          queryMap["jobStateMatcher"]!.first,
          unittest.equals(arg_jobStateMatcher),
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
        var resp = convert.json.encode(buildListJobsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_projectId, arg_region,
          clusterName: arg_clusterName,
          filter: arg_filter,
          jobStateMatcher: arg_jobStateMatcher,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkListJobsResponse(response as api.ListJobsResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.jobs;
      var arg_request = buildJob();
      var arg_projectId = 'foo';
      var arg_region = 'foo';
      var arg_jobId = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.Job.fromJson(json as core.Map<core.String, core.dynamic>);
        checkJob(obj as api.Job);

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
          path.substring(pathOffset, pathOffset + 12),
          unittest.equals("v1/projects/"),
        );
        pathOffset += 12;
        index = path.indexOf('/regions/', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_projectId'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 9),
          unittest.equals("/regions/"),
        );
        pathOffset += 9;
        index = path.indexOf('/jobs/', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_region'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 6),
          unittest.equals("/jobs/"),
        );
        pathOffset += 6;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(
          subPart,
          unittest.equals('$arg_jobId'),
        );

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
        var resp = convert.json.encode(buildJob());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(
          arg_request, arg_projectId, arg_region, arg_jobId,
          updateMask: arg_updateMask, $fields: arg_$fields);
      checkJob(response as api.Job);
    });

    unittest.test('method--setIamPolicy', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.jobs;
      var arg_request = buildSetIamPolicyRequest();
      var arg_resource = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.SetIamPolicyRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkSetIamPolicyRequest(obj as api.SetIamPolicyRequest);

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
        var resp = convert.json.encode(buildPolicy());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.setIamPolicy(arg_request, arg_resource,
          $fields: arg_$fields);
      checkPolicy(response as api.Policy);
    });

    unittest.test('method--submit', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.jobs;
      var arg_request = buildSubmitJobRequest();
      var arg_projectId = 'foo';
      var arg_region = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.SubmitJobRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkSubmitJobRequest(obj as api.SubmitJobRequest);

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
          path.substring(pathOffset, pathOffset + 12),
          unittest.equals("v1/projects/"),
        );
        pathOffset += 12;
        index = path.indexOf('/regions/', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_projectId'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 9),
          unittest.equals("/regions/"),
        );
        pathOffset += 9;
        index = path.indexOf('/jobs:submit', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_region'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 12),
          unittest.equals("/jobs:submit"),
        );
        pathOffset += 12;

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
        var resp = convert.json.encode(buildJob());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.submit(arg_request, arg_projectId, arg_region,
          $fields: arg_$fields);
      checkJob(response as api.Job);
    });

    unittest.test('method--submitAsOperation', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.jobs;
      var arg_request = buildSubmitJobRequest();
      var arg_projectId = 'foo';
      var arg_region = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.SubmitJobRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkSubmitJobRequest(obj as api.SubmitJobRequest);

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
          path.substring(pathOffset, pathOffset + 12),
          unittest.equals("v1/projects/"),
        );
        pathOffset += 12;
        index = path.indexOf('/regions/', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_projectId'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 9),
          unittest.equals("/regions/"),
        );
        pathOffset += 9;
        index = path.indexOf('/jobs:submitAsOperation', pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(
          subPart,
          unittest.equals('$arg_region'),
        );
        unittest.expect(
          path.substring(pathOffset, pathOffset + 23),
          unittest.equals("/jobs:submitAsOperation"),
        );
        pathOffset += 23;

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
      final response = await res.submitAsOperation(
          arg_request, arg_projectId, arg_region,
          $fields: arg_$fields);
      checkOperation(response as api.Operation);
    });

    unittest.test('method--testIamPermissions', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.jobs;
      var arg_request = buildTestIamPermissionsRequest();
      var arg_resource = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.TestIamPermissionsRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkTestIamPermissionsRequest(obj as api.TestIamPermissionsRequest);

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
        var resp = convert.json.encode(buildTestIamPermissionsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.testIamPermissions(arg_request, arg_resource,
          $fields: arg_$fields);
      checkTestIamPermissionsResponse(
          response as api.TestIamPermissionsResponse);
    });
  });

  unittest.group('resource-ProjectsRegionsOperationsResource', () {
    unittest.test('method--cancel', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.operations;
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
      final response = await res.cancel(arg_name, $fields: arg_$fields);
      checkEmpty(response as api.Empty);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.operations;
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
      var res = api.DataprocApi(mock).projects.regions.operations;
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

    unittest.test('method--getIamPolicy', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.operations;
      var arg_request = buildGetIamPolicyRequest();
      var arg_resource = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GetIamPolicyRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGetIamPolicyRequest(obj as api.GetIamPolicyRequest);

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
        var resp = convert.json.encode(buildPolicy());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.getIamPolicy(arg_request, arg_resource,
          $fields: arg_$fields);
      checkPolicy(response as api.Policy);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.operations;
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

    unittest.test('method--setIamPolicy', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.operations;
      var arg_request = buildSetIamPolicyRequest();
      var arg_resource = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.SetIamPolicyRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkSetIamPolicyRequest(obj as api.SetIamPolicyRequest);

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
        var resp = convert.json.encode(buildPolicy());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.setIamPolicy(arg_request, arg_resource,
          $fields: arg_$fields);
      checkPolicy(response as api.Policy);
    });

    unittest.test('method--testIamPermissions', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.operations;
      var arg_request = buildTestIamPermissionsRequest();
      var arg_resource = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.TestIamPermissionsRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkTestIamPermissionsRequest(obj as api.TestIamPermissionsRequest);

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
        var resp = convert.json.encode(buildTestIamPermissionsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.testIamPermissions(arg_request, arg_resource,
          $fields: arg_$fields);
      checkTestIamPermissionsResponse(
          response as api.TestIamPermissionsResponse);
    });
  });

  unittest.group('resource-ProjectsRegionsWorkflowTemplatesResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.workflowTemplates;
      var arg_request = buildWorkflowTemplate();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.WorkflowTemplate.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkWorkflowTemplate(obj as api.WorkflowTemplate);

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
        var resp = convert.json.encode(buildWorkflowTemplate());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkWorkflowTemplate(response as api.WorkflowTemplate);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.workflowTemplates;
      var arg_name = 'foo';
      var arg_version = 42;
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
          core.int.parse(queryMap["version"]!.first),
          unittest.equals(arg_version),
        );
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
      final response = await res.delete(arg_name,
          version: arg_version, $fields: arg_$fields);
      checkEmpty(response as api.Empty);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.workflowTemplates;
      var arg_name = 'foo';
      var arg_version = 42;
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
          core.int.parse(queryMap["version"]!.first),
          unittest.equals(arg_version),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildWorkflowTemplate());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.get(arg_name, version: arg_version, $fields: arg_$fields);
      checkWorkflowTemplate(response as api.WorkflowTemplate);
    });

    unittest.test('method--getIamPolicy', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.workflowTemplates;
      var arg_request = buildGetIamPolicyRequest();
      var arg_resource = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GetIamPolicyRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGetIamPolicyRequest(obj as api.GetIamPolicyRequest);

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
        var resp = convert.json.encode(buildPolicy());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.getIamPolicy(arg_request, arg_resource,
          $fields: arg_$fields);
      checkPolicy(response as api.Policy);
    });

    unittest.test('method--instantiate', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.workflowTemplates;
      var arg_request = buildInstantiateWorkflowTemplateRequest();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.InstantiateWorkflowTemplateRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkInstantiateWorkflowTemplateRequest(
            obj as api.InstantiateWorkflowTemplateRequest);

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
          await res.instantiate(arg_request, arg_name, $fields: arg_$fields);
      checkOperation(response as api.Operation);
    });

    unittest.test('method--instantiateInline', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.workflowTemplates;
      var arg_request = buildWorkflowTemplate();
      var arg_parent = 'foo';
      var arg_requestId = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.WorkflowTemplate.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkWorkflowTemplate(obj as api.WorkflowTemplate);

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
          queryMap["requestId"]!.first,
          unittest.equals(arg_requestId),
        );
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
      final response = await res.instantiateInline(arg_request, arg_parent,
          requestId: arg_requestId, $fields: arg_$fields);
      checkOperation(response as api.Operation);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.workflowTemplates;
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
        var resp = convert.json.encode(buildListWorkflowTemplatesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkListWorkflowTemplatesResponse(
          response as api.ListWorkflowTemplatesResponse);
    });

    unittest.test('method--setIamPolicy', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.workflowTemplates;
      var arg_request = buildSetIamPolicyRequest();
      var arg_resource = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.SetIamPolicyRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkSetIamPolicyRequest(obj as api.SetIamPolicyRequest);

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
        var resp = convert.json.encode(buildPolicy());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.setIamPolicy(arg_request, arg_resource,
          $fields: arg_$fields);
      checkPolicy(response as api.Policy);
    });

    unittest.test('method--testIamPermissions', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.workflowTemplates;
      var arg_request = buildTestIamPermissionsRequest();
      var arg_resource = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.TestIamPermissionsRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkTestIamPermissionsRequest(obj as api.TestIamPermissionsRequest);

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
        var resp = convert.json.encode(buildTestIamPermissionsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.testIamPermissions(arg_request, arg_resource,
          $fields: arg_$fields);
      checkTestIamPermissionsResponse(
          response as api.TestIamPermissionsResponse);
    });

    unittest.test('method--update', () async {
      var mock = HttpServerMock();
      var res = api.DataprocApi(mock).projects.regions.workflowTemplates;
      var arg_request = buildWorkflowTemplate();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.WorkflowTemplate.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkWorkflowTemplate(obj as api.WorkflowTemplate);

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
        var resp = convert.json.encode(buildWorkflowTemplate());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.update(arg_request, arg_name, $fields: arg_$fields);
      checkWorkflowTemplate(response as api.WorkflowTemplate);
    });
  });
}
