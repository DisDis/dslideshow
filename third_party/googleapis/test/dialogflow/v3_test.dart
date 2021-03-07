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
import 'package:googleapis/dialogflow/v3.dart' as api;

import '../test_shared.dart';

core.int buildCounterGoogleCloudDialogflowCxV3Agent = 0;
api.GoogleCloudDialogflowCxV3Agent buildGoogleCloudDialogflowCxV3Agent() {
  var o = api.GoogleCloudDialogflowCxV3Agent();
  buildCounterGoogleCloudDialogflowCxV3Agent++;
  if (buildCounterGoogleCloudDialogflowCxV3Agent < 3) {
    o.avatarUri = 'foo';
    o.defaultLanguageCode = 'foo';
    o.description = 'foo';
    o.displayName = 'foo';
    o.enableSpellCorrection = true;
    o.enableStackdriverLogging = true;
    o.name = 'foo';
    o.securitySettings = 'foo';
    o.speechToTextSettings =
        buildGoogleCloudDialogflowCxV3SpeechToTextSettings();
    o.startFlow = 'foo';
    o.timeZone = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3Agent--;
  return o;
}

void checkGoogleCloudDialogflowCxV3Agent(api.GoogleCloudDialogflowCxV3Agent o) {
  buildCounterGoogleCloudDialogflowCxV3Agent++;
  if (buildCounterGoogleCloudDialogflowCxV3Agent < 3) {
    unittest.expect(
      o.avatarUri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.defaultLanguageCode!,
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
    unittest.expect(o.enableSpellCorrection!, unittest.isTrue);
    unittest.expect(o.enableStackdriverLogging!, unittest.isTrue);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.securitySettings!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3SpeechToTextSettings(o.speechToTextSettings!
        as api.GoogleCloudDialogflowCxV3SpeechToTextSettings);
    unittest.expect(
      o.startFlow!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.timeZone!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3Agent--;
}

core.List<api.GoogleCloudDialogflowCxV3FlowValidationResult> buildUnnamed105() {
  var o = <api.GoogleCloudDialogflowCxV3FlowValidationResult>[];
  o.add(buildGoogleCloudDialogflowCxV3FlowValidationResult());
  o.add(buildGoogleCloudDialogflowCxV3FlowValidationResult());
  return o;
}

void checkUnnamed105(
    core.List<api.GoogleCloudDialogflowCxV3FlowValidationResult> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3FlowValidationResult(
      o[0] as api.GoogleCloudDialogflowCxV3FlowValidationResult);
  checkGoogleCloudDialogflowCxV3FlowValidationResult(
      o[1] as api.GoogleCloudDialogflowCxV3FlowValidationResult);
}

core.int buildCounterGoogleCloudDialogflowCxV3AgentValidationResult = 0;
api.GoogleCloudDialogflowCxV3AgentValidationResult
    buildGoogleCloudDialogflowCxV3AgentValidationResult() {
  var o = api.GoogleCloudDialogflowCxV3AgentValidationResult();
  buildCounterGoogleCloudDialogflowCxV3AgentValidationResult++;
  if (buildCounterGoogleCloudDialogflowCxV3AgentValidationResult < 3) {
    o.flowValidationResults = buildUnnamed105();
    o.name = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3AgentValidationResult--;
  return o;
}

void checkGoogleCloudDialogflowCxV3AgentValidationResult(
    api.GoogleCloudDialogflowCxV3AgentValidationResult o) {
  buildCounterGoogleCloudDialogflowCxV3AgentValidationResult++;
  if (buildCounterGoogleCloudDialogflowCxV3AgentValidationResult < 3) {
    checkUnnamed105(o.flowValidationResults!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3AgentValidationResult--;
}

core.int buildCounterGoogleCloudDialogflowCxV3AudioInput = 0;
api.GoogleCloudDialogflowCxV3AudioInput
    buildGoogleCloudDialogflowCxV3AudioInput() {
  var o = api.GoogleCloudDialogflowCxV3AudioInput();
  buildCounterGoogleCloudDialogflowCxV3AudioInput++;
  if (buildCounterGoogleCloudDialogflowCxV3AudioInput < 3) {
    o.audio = 'foo';
    o.config = buildGoogleCloudDialogflowCxV3InputAudioConfig();
  }
  buildCounterGoogleCloudDialogflowCxV3AudioInput--;
  return o;
}

void checkGoogleCloudDialogflowCxV3AudioInput(
    api.GoogleCloudDialogflowCxV3AudioInput o) {
  buildCounterGoogleCloudDialogflowCxV3AudioInput++;
  if (buildCounterGoogleCloudDialogflowCxV3AudioInput < 3) {
    unittest.expect(
      o.audio!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3InputAudioConfig(
        o.config! as api.GoogleCloudDialogflowCxV3InputAudioConfig);
  }
  buildCounterGoogleCloudDialogflowCxV3AudioInput--;
}

core.List<core.String> buildUnnamed106() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed106(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowCxV3BatchDeleteTestCasesRequest = 0;
api.GoogleCloudDialogflowCxV3BatchDeleteTestCasesRequest
    buildGoogleCloudDialogflowCxV3BatchDeleteTestCasesRequest() {
  var o = api.GoogleCloudDialogflowCxV3BatchDeleteTestCasesRequest();
  buildCounterGoogleCloudDialogflowCxV3BatchDeleteTestCasesRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3BatchDeleteTestCasesRequest < 3) {
    o.names = buildUnnamed106();
  }
  buildCounterGoogleCloudDialogflowCxV3BatchDeleteTestCasesRequest--;
  return o;
}

void checkGoogleCloudDialogflowCxV3BatchDeleteTestCasesRequest(
    api.GoogleCloudDialogflowCxV3BatchDeleteTestCasesRequest o) {
  buildCounterGoogleCloudDialogflowCxV3BatchDeleteTestCasesRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3BatchDeleteTestCasesRequest < 3) {
    checkUnnamed106(o.names!);
  }
  buildCounterGoogleCloudDialogflowCxV3BatchDeleteTestCasesRequest--;
}

core.List<api.GoogleCloudDialogflowCxV3TestError> buildUnnamed107() {
  var o = <api.GoogleCloudDialogflowCxV3TestError>[];
  o.add(buildGoogleCloudDialogflowCxV3TestError());
  o.add(buildGoogleCloudDialogflowCxV3TestError());
  return o;
}

void checkUnnamed107(core.List<api.GoogleCloudDialogflowCxV3TestError> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3TestError(
      o[0] as api.GoogleCloudDialogflowCxV3TestError);
  checkGoogleCloudDialogflowCxV3TestError(
      o[1] as api.GoogleCloudDialogflowCxV3TestError);
}

core.int buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesMetadata = 0;
api.GoogleCloudDialogflowCxV3BatchRunTestCasesMetadata
    buildGoogleCloudDialogflowCxV3BatchRunTestCasesMetadata() {
  var o = api.GoogleCloudDialogflowCxV3BatchRunTestCasesMetadata();
  buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesMetadata < 3) {
    o.errors = buildUnnamed107();
  }
  buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3BatchRunTestCasesMetadata(
    api.GoogleCloudDialogflowCxV3BatchRunTestCasesMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesMetadata < 3) {
    checkUnnamed107(o.errors!);
  }
  buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesMetadata--;
}

core.List<core.String> buildUnnamed108() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed108(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesRequest = 0;
api.GoogleCloudDialogflowCxV3BatchRunTestCasesRequest
    buildGoogleCloudDialogflowCxV3BatchRunTestCasesRequest() {
  var o = api.GoogleCloudDialogflowCxV3BatchRunTestCasesRequest();
  buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesRequest < 3) {
    o.environment = 'foo';
    o.testCases = buildUnnamed108();
  }
  buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesRequest--;
  return o;
}

void checkGoogleCloudDialogflowCxV3BatchRunTestCasesRequest(
    api.GoogleCloudDialogflowCxV3BatchRunTestCasesRequest o) {
  buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesRequest < 3) {
    unittest.expect(
      o.environment!,
      unittest.equals('foo'),
    );
    checkUnnamed108(o.testCases!);
  }
  buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesRequest--;
}

core.List<api.GoogleCloudDialogflowCxV3TestCaseResult> buildUnnamed109() {
  var o = <api.GoogleCloudDialogflowCxV3TestCaseResult>[];
  o.add(buildGoogleCloudDialogflowCxV3TestCaseResult());
  o.add(buildGoogleCloudDialogflowCxV3TestCaseResult());
  return o;
}

void checkUnnamed109(core.List<api.GoogleCloudDialogflowCxV3TestCaseResult> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3TestCaseResult(
      o[0] as api.GoogleCloudDialogflowCxV3TestCaseResult);
  checkGoogleCloudDialogflowCxV3TestCaseResult(
      o[1] as api.GoogleCloudDialogflowCxV3TestCaseResult);
}

core.int buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesResponse = 0;
api.GoogleCloudDialogflowCxV3BatchRunTestCasesResponse
    buildGoogleCloudDialogflowCxV3BatchRunTestCasesResponse() {
  var o = api.GoogleCloudDialogflowCxV3BatchRunTestCasesResponse();
  buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesResponse < 3) {
    o.results = buildUnnamed109();
  }
  buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3BatchRunTestCasesResponse(
    api.GoogleCloudDialogflowCxV3BatchRunTestCasesResponse o) {
  buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesResponse < 3) {
    checkUnnamed109(o.results!);
  }
  buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesResponse--;
}

core.int buildCounterGoogleCloudDialogflowCxV3CalculateCoverageResponse = 0;
api.GoogleCloudDialogflowCxV3CalculateCoverageResponse
    buildGoogleCloudDialogflowCxV3CalculateCoverageResponse() {
  var o = api.GoogleCloudDialogflowCxV3CalculateCoverageResponse();
  buildCounterGoogleCloudDialogflowCxV3CalculateCoverageResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3CalculateCoverageResponse < 3) {
    o.agent = 'foo';
    o.intentCoverage = buildGoogleCloudDialogflowCxV3IntentCoverage();
    o.routeGroupCoverage =
        buildGoogleCloudDialogflowCxV3TransitionRouteGroupCoverage();
    o.transitionCoverage = buildGoogleCloudDialogflowCxV3TransitionCoverage();
  }
  buildCounterGoogleCloudDialogflowCxV3CalculateCoverageResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3CalculateCoverageResponse(
    api.GoogleCloudDialogflowCxV3CalculateCoverageResponse o) {
  buildCounterGoogleCloudDialogflowCxV3CalculateCoverageResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3CalculateCoverageResponse < 3) {
    unittest.expect(
      o.agent!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3IntentCoverage(
        o.intentCoverage! as api.GoogleCloudDialogflowCxV3IntentCoverage);
    checkGoogleCloudDialogflowCxV3TransitionRouteGroupCoverage(
        o.routeGroupCoverage!
            as api.GoogleCloudDialogflowCxV3TransitionRouteGroupCoverage);
    checkGoogleCloudDialogflowCxV3TransitionCoverage(o.transitionCoverage!
        as api.GoogleCloudDialogflowCxV3TransitionCoverage);
  }
  buildCounterGoogleCloudDialogflowCxV3CalculateCoverageResponse--;
}

core.int buildCounterGoogleCloudDialogflowCxV3ConversationTurn = 0;
api.GoogleCloudDialogflowCxV3ConversationTurn
    buildGoogleCloudDialogflowCxV3ConversationTurn() {
  var o = api.GoogleCloudDialogflowCxV3ConversationTurn();
  buildCounterGoogleCloudDialogflowCxV3ConversationTurn++;
  if (buildCounterGoogleCloudDialogflowCxV3ConversationTurn < 3) {
    o.userInput = buildGoogleCloudDialogflowCxV3ConversationTurnUserInput();
    o.virtualAgentOutput =
        buildGoogleCloudDialogflowCxV3ConversationTurnVirtualAgentOutput();
  }
  buildCounterGoogleCloudDialogflowCxV3ConversationTurn--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ConversationTurn(
    api.GoogleCloudDialogflowCxV3ConversationTurn o) {
  buildCounterGoogleCloudDialogflowCxV3ConversationTurn++;
  if (buildCounterGoogleCloudDialogflowCxV3ConversationTurn < 3) {
    checkGoogleCloudDialogflowCxV3ConversationTurnUserInput(
        o.userInput! as api.GoogleCloudDialogflowCxV3ConversationTurnUserInput);
    checkGoogleCloudDialogflowCxV3ConversationTurnVirtualAgentOutput(
        o.virtualAgentOutput!
            as api.GoogleCloudDialogflowCxV3ConversationTurnVirtualAgentOutput);
  }
  buildCounterGoogleCloudDialogflowCxV3ConversationTurn--;
}

core.Map<core.String, core.Object> buildUnnamed110() {
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

void checkUnnamed110(core.Map<core.String, core.Object> o) {
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

core.int buildCounterGoogleCloudDialogflowCxV3ConversationTurnUserInput = 0;
api.GoogleCloudDialogflowCxV3ConversationTurnUserInput
    buildGoogleCloudDialogflowCxV3ConversationTurnUserInput() {
  var o = api.GoogleCloudDialogflowCxV3ConversationTurnUserInput();
  buildCounterGoogleCloudDialogflowCxV3ConversationTurnUserInput++;
  if (buildCounterGoogleCloudDialogflowCxV3ConversationTurnUserInput < 3) {
    o.injectedParameters = buildUnnamed110();
    o.input = buildGoogleCloudDialogflowCxV3QueryInput();
    o.isWebhookEnabled = true;
  }
  buildCounterGoogleCloudDialogflowCxV3ConversationTurnUserInput--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ConversationTurnUserInput(
    api.GoogleCloudDialogflowCxV3ConversationTurnUserInput o) {
  buildCounterGoogleCloudDialogflowCxV3ConversationTurnUserInput++;
  if (buildCounterGoogleCloudDialogflowCxV3ConversationTurnUserInput < 3) {
    checkUnnamed110(o.injectedParameters!);
    checkGoogleCloudDialogflowCxV3QueryInput(
        o.input! as api.GoogleCloudDialogflowCxV3QueryInput);
    unittest.expect(o.isWebhookEnabled!, unittest.isTrue);
  }
  buildCounterGoogleCloudDialogflowCxV3ConversationTurnUserInput--;
}

core.Map<core.String, core.Object> buildUnnamed111() {
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

void checkUnnamed111(core.Map<core.String, core.Object> o) {
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

core.List<api.GoogleCloudDialogflowCxV3TestRunDifference> buildUnnamed112() {
  var o = <api.GoogleCloudDialogflowCxV3TestRunDifference>[];
  o.add(buildGoogleCloudDialogflowCxV3TestRunDifference());
  o.add(buildGoogleCloudDialogflowCxV3TestRunDifference());
  return o;
}

void checkUnnamed112(
    core.List<api.GoogleCloudDialogflowCxV3TestRunDifference> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3TestRunDifference(
      o[0] as api.GoogleCloudDialogflowCxV3TestRunDifference);
  checkGoogleCloudDialogflowCxV3TestRunDifference(
      o[1] as api.GoogleCloudDialogflowCxV3TestRunDifference);
}

core.Map<core.String, core.Object> buildUnnamed113() {
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

void checkUnnamed113(core.Map<core.String, core.Object> o) {
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

core.List<api.GoogleCloudDialogflowCxV3ResponseMessageText> buildUnnamed114() {
  var o = <api.GoogleCloudDialogflowCxV3ResponseMessageText>[];
  o.add(buildGoogleCloudDialogflowCxV3ResponseMessageText());
  o.add(buildGoogleCloudDialogflowCxV3ResponseMessageText());
  return o;
}

void checkUnnamed114(
    core.List<api.GoogleCloudDialogflowCxV3ResponseMessageText> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3ResponseMessageText(
      o[0] as api.GoogleCloudDialogflowCxV3ResponseMessageText);
  checkGoogleCloudDialogflowCxV3ResponseMessageText(
      o[1] as api.GoogleCloudDialogflowCxV3ResponseMessageText);
}

core.int
    buildCounterGoogleCloudDialogflowCxV3ConversationTurnVirtualAgentOutput = 0;
api.GoogleCloudDialogflowCxV3ConversationTurnVirtualAgentOutput
    buildGoogleCloudDialogflowCxV3ConversationTurnVirtualAgentOutput() {
  var o = api.GoogleCloudDialogflowCxV3ConversationTurnVirtualAgentOutput();
  buildCounterGoogleCloudDialogflowCxV3ConversationTurnVirtualAgentOutput++;
  if (buildCounterGoogleCloudDialogflowCxV3ConversationTurnVirtualAgentOutput <
      3) {
    o.currentPage = buildGoogleCloudDialogflowCxV3Page();
    o.diagnosticInfo = buildUnnamed111();
    o.differences = buildUnnamed112();
    o.sessionParameters = buildUnnamed113();
    o.status = buildGoogleRpcStatus();
    o.textResponses = buildUnnamed114();
    o.triggeredIntent = buildGoogleCloudDialogflowCxV3Intent();
  }
  buildCounterGoogleCloudDialogflowCxV3ConversationTurnVirtualAgentOutput--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ConversationTurnVirtualAgentOutput(
    api.GoogleCloudDialogflowCxV3ConversationTurnVirtualAgentOutput o) {
  buildCounterGoogleCloudDialogflowCxV3ConversationTurnVirtualAgentOutput++;
  if (buildCounterGoogleCloudDialogflowCxV3ConversationTurnVirtualAgentOutput <
      3) {
    checkGoogleCloudDialogflowCxV3Page(
        o.currentPage! as api.GoogleCloudDialogflowCxV3Page);
    checkUnnamed111(o.diagnosticInfo!);
    checkUnnamed112(o.differences!);
    checkUnnamed113(o.sessionParameters!);
    checkGoogleRpcStatus(o.status! as api.GoogleRpcStatus);
    checkUnnamed114(o.textResponses!);
    checkGoogleCloudDialogflowCxV3Intent(
        o.triggeredIntent! as api.GoogleCloudDialogflowCxV3Intent);
  }
  buildCounterGoogleCloudDialogflowCxV3ConversationTurnVirtualAgentOutput--;
}

core.int buildCounterGoogleCloudDialogflowCxV3CreateDocumentOperationMetadata =
    0;
api.GoogleCloudDialogflowCxV3CreateDocumentOperationMetadata
    buildGoogleCloudDialogflowCxV3CreateDocumentOperationMetadata() {
  var o = api.GoogleCloudDialogflowCxV3CreateDocumentOperationMetadata();
  buildCounterGoogleCloudDialogflowCxV3CreateDocumentOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3CreateDocumentOperationMetadata <
      3) {
    o.genericMetadata =
        buildGoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata();
  }
  buildCounterGoogleCloudDialogflowCxV3CreateDocumentOperationMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3CreateDocumentOperationMetadata(
    api.GoogleCloudDialogflowCxV3CreateDocumentOperationMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3CreateDocumentOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3CreateDocumentOperationMetadata <
      3) {
    checkGoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata(
        o.genericMetadata!
            as api.GoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata);
  }
  buildCounterGoogleCloudDialogflowCxV3CreateDocumentOperationMetadata--;
}

core.int buildCounterGoogleCloudDialogflowCxV3CreateVersionOperationMetadata =
    0;
api.GoogleCloudDialogflowCxV3CreateVersionOperationMetadata
    buildGoogleCloudDialogflowCxV3CreateVersionOperationMetadata() {
  var o = api.GoogleCloudDialogflowCxV3CreateVersionOperationMetadata();
  buildCounterGoogleCloudDialogflowCxV3CreateVersionOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3CreateVersionOperationMetadata < 3) {
    o.version = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3CreateVersionOperationMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3CreateVersionOperationMetadata(
    api.GoogleCloudDialogflowCxV3CreateVersionOperationMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3CreateVersionOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3CreateVersionOperationMetadata < 3) {
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3CreateVersionOperationMetadata--;
}

core.int buildCounterGoogleCloudDialogflowCxV3DeleteDocumentOperationMetadata =
    0;
api.GoogleCloudDialogflowCxV3DeleteDocumentOperationMetadata
    buildGoogleCloudDialogflowCxV3DeleteDocumentOperationMetadata() {
  var o = api.GoogleCloudDialogflowCxV3DeleteDocumentOperationMetadata();
  buildCounterGoogleCloudDialogflowCxV3DeleteDocumentOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3DeleteDocumentOperationMetadata <
      3) {
    o.genericMetadata =
        buildGoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata();
  }
  buildCounterGoogleCloudDialogflowCxV3DeleteDocumentOperationMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3DeleteDocumentOperationMetadata(
    api.GoogleCloudDialogflowCxV3DeleteDocumentOperationMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3DeleteDocumentOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3DeleteDocumentOperationMetadata <
      3) {
    checkGoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata(
        o.genericMetadata!
            as api.GoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata);
  }
  buildCounterGoogleCloudDialogflowCxV3DeleteDocumentOperationMetadata--;
}

core.int buildCounterGoogleCloudDialogflowCxV3DetectIntentRequest = 0;
api.GoogleCloudDialogflowCxV3DetectIntentRequest
    buildGoogleCloudDialogflowCxV3DetectIntentRequest() {
  var o = api.GoogleCloudDialogflowCxV3DetectIntentRequest();
  buildCounterGoogleCloudDialogflowCxV3DetectIntentRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3DetectIntentRequest < 3) {
    o.outputAudioConfig = buildGoogleCloudDialogflowCxV3OutputAudioConfig();
    o.queryInput = buildGoogleCloudDialogflowCxV3QueryInput();
    o.queryParams = buildGoogleCloudDialogflowCxV3QueryParameters();
  }
  buildCounterGoogleCloudDialogflowCxV3DetectIntentRequest--;
  return o;
}

void checkGoogleCloudDialogflowCxV3DetectIntentRequest(
    api.GoogleCloudDialogflowCxV3DetectIntentRequest o) {
  buildCounterGoogleCloudDialogflowCxV3DetectIntentRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3DetectIntentRequest < 3) {
    checkGoogleCloudDialogflowCxV3OutputAudioConfig(
        o.outputAudioConfig! as api.GoogleCloudDialogflowCxV3OutputAudioConfig);
    checkGoogleCloudDialogflowCxV3QueryInput(
        o.queryInput! as api.GoogleCloudDialogflowCxV3QueryInput);
    checkGoogleCloudDialogflowCxV3QueryParameters(
        o.queryParams! as api.GoogleCloudDialogflowCxV3QueryParameters);
  }
  buildCounterGoogleCloudDialogflowCxV3DetectIntentRequest--;
}

core.int buildCounterGoogleCloudDialogflowCxV3DetectIntentResponse = 0;
api.GoogleCloudDialogflowCxV3DetectIntentResponse
    buildGoogleCloudDialogflowCxV3DetectIntentResponse() {
  var o = api.GoogleCloudDialogflowCxV3DetectIntentResponse();
  buildCounterGoogleCloudDialogflowCxV3DetectIntentResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3DetectIntentResponse < 3) {
    o.outputAudio = 'foo';
    o.outputAudioConfig = buildGoogleCloudDialogflowCxV3OutputAudioConfig();
    o.queryResult = buildGoogleCloudDialogflowCxV3QueryResult();
    o.responseId = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3DetectIntentResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3DetectIntentResponse(
    api.GoogleCloudDialogflowCxV3DetectIntentResponse o) {
  buildCounterGoogleCloudDialogflowCxV3DetectIntentResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3DetectIntentResponse < 3) {
    unittest.expect(
      o.outputAudio!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3OutputAudioConfig(
        o.outputAudioConfig! as api.GoogleCloudDialogflowCxV3OutputAudioConfig);
    checkGoogleCloudDialogflowCxV3QueryResult(
        o.queryResult! as api.GoogleCloudDialogflowCxV3QueryResult);
    unittest.expect(
      o.responseId!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3DetectIntentResponse--;
}

core.int buildCounterGoogleCloudDialogflowCxV3DtmfInput = 0;
api.GoogleCloudDialogflowCxV3DtmfInput
    buildGoogleCloudDialogflowCxV3DtmfInput() {
  var o = api.GoogleCloudDialogflowCxV3DtmfInput();
  buildCounterGoogleCloudDialogflowCxV3DtmfInput++;
  if (buildCounterGoogleCloudDialogflowCxV3DtmfInput < 3) {
    o.digits = 'foo';
    o.finishDigit = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3DtmfInput--;
  return o;
}

void checkGoogleCloudDialogflowCxV3DtmfInput(
    api.GoogleCloudDialogflowCxV3DtmfInput o) {
  buildCounterGoogleCloudDialogflowCxV3DtmfInput++;
  if (buildCounterGoogleCloudDialogflowCxV3DtmfInput < 3) {
    unittest.expect(
      o.digits!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.finishDigit!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3DtmfInput--;
}

core.List<api.GoogleCloudDialogflowCxV3EntityTypeEntity> buildUnnamed115() {
  var o = <api.GoogleCloudDialogflowCxV3EntityTypeEntity>[];
  o.add(buildGoogleCloudDialogflowCxV3EntityTypeEntity());
  o.add(buildGoogleCloudDialogflowCxV3EntityTypeEntity());
  return o;
}

void checkUnnamed115(
    core.List<api.GoogleCloudDialogflowCxV3EntityTypeEntity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3EntityTypeEntity(
      o[0] as api.GoogleCloudDialogflowCxV3EntityTypeEntity);
  checkGoogleCloudDialogflowCxV3EntityTypeEntity(
      o[1] as api.GoogleCloudDialogflowCxV3EntityTypeEntity);
}

core.List<api.GoogleCloudDialogflowCxV3EntityTypeExcludedPhrase>
    buildUnnamed116() {
  var o = <api.GoogleCloudDialogflowCxV3EntityTypeExcludedPhrase>[];
  o.add(buildGoogleCloudDialogflowCxV3EntityTypeExcludedPhrase());
  o.add(buildGoogleCloudDialogflowCxV3EntityTypeExcludedPhrase());
  return o;
}

void checkUnnamed116(
    core.List<api.GoogleCloudDialogflowCxV3EntityTypeExcludedPhrase> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3EntityTypeExcludedPhrase(
      o[0] as api.GoogleCloudDialogflowCxV3EntityTypeExcludedPhrase);
  checkGoogleCloudDialogflowCxV3EntityTypeExcludedPhrase(
      o[1] as api.GoogleCloudDialogflowCxV3EntityTypeExcludedPhrase);
}

core.int buildCounterGoogleCloudDialogflowCxV3EntityType = 0;
api.GoogleCloudDialogflowCxV3EntityType
    buildGoogleCloudDialogflowCxV3EntityType() {
  var o = api.GoogleCloudDialogflowCxV3EntityType();
  buildCounterGoogleCloudDialogflowCxV3EntityType++;
  if (buildCounterGoogleCloudDialogflowCxV3EntityType < 3) {
    o.autoExpansionMode = 'foo';
    o.displayName = 'foo';
    o.enableFuzzyExtraction = true;
    o.entities = buildUnnamed115();
    o.excludedPhrases = buildUnnamed116();
    o.kind = 'foo';
    o.name = 'foo';
    o.redact = true;
  }
  buildCounterGoogleCloudDialogflowCxV3EntityType--;
  return o;
}

void checkGoogleCloudDialogflowCxV3EntityType(
    api.GoogleCloudDialogflowCxV3EntityType o) {
  buildCounterGoogleCloudDialogflowCxV3EntityType++;
  if (buildCounterGoogleCloudDialogflowCxV3EntityType < 3) {
    unittest.expect(
      o.autoExpansionMode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(o.enableFuzzyExtraction!, unittest.isTrue);
    checkUnnamed115(o.entities!);
    checkUnnamed116(o.excludedPhrases!);
    unittest.expect(
      o.kind!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(o.redact!, unittest.isTrue);
  }
  buildCounterGoogleCloudDialogflowCxV3EntityType--;
}

core.List<core.String> buildUnnamed117() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed117(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowCxV3EntityTypeEntity = 0;
api.GoogleCloudDialogflowCxV3EntityTypeEntity
    buildGoogleCloudDialogflowCxV3EntityTypeEntity() {
  var o = api.GoogleCloudDialogflowCxV3EntityTypeEntity();
  buildCounterGoogleCloudDialogflowCxV3EntityTypeEntity++;
  if (buildCounterGoogleCloudDialogflowCxV3EntityTypeEntity < 3) {
    o.synonyms = buildUnnamed117();
    o.value = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3EntityTypeEntity--;
  return o;
}

void checkGoogleCloudDialogflowCxV3EntityTypeEntity(
    api.GoogleCloudDialogflowCxV3EntityTypeEntity o) {
  buildCounterGoogleCloudDialogflowCxV3EntityTypeEntity++;
  if (buildCounterGoogleCloudDialogflowCxV3EntityTypeEntity < 3) {
    checkUnnamed117(o.synonyms!);
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3EntityTypeEntity--;
}

core.int buildCounterGoogleCloudDialogflowCxV3EntityTypeExcludedPhrase = 0;
api.GoogleCloudDialogflowCxV3EntityTypeExcludedPhrase
    buildGoogleCloudDialogflowCxV3EntityTypeExcludedPhrase() {
  var o = api.GoogleCloudDialogflowCxV3EntityTypeExcludedPhrase();
  buildCounterGoogleCloudDialogflowCxV3EntityTypeExcludedPhrase++;
  if (buildCounterGoogleCloudDialogflowCxV3EntityTypeExcludedPhrase < 3) {
    o.value = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3EntityTypeExcludedPhrase--;
  return o;
}

void checkGoogleCloudDialogflowCxV3EntityTypeExcludedPhrase(
    api.GoogleCloudDialogflowCxV3EntityTypeExcludedPhrase o) {
  buildCounterGoogleCloudDialogflowCxV3EntityTypeExcludedPhrase++;
  if (buildCounterGoogleCloudDialogflowCxV3EntityTypeExcludedPhrase < 3) {
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3EntityTypeExcludedPhrase--;
}

core.List<api.GoogleCloudDialogflowCxV3EnvironmentVersionConfig>
    buildUnnamed118() {
  var o = <api.GoogleCloudDialogflowCxV3EnvironmentVersionConfig>[];
  o.add(buildGoogleCloudDialogflowCxV3EnvironmentVersionConfig());
  o.add(buildGoogleCloudDialogflowCxV3EnvironmentVersionConfig());
  return o;
}

void checkUnnamed118(
    core.List<api.GoogleCloudDialogflowCxV3EnvironmentVersionConfig> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3EnvironmentVersionConfig(
      o[0] as api.GoogleCloudDialogflowCxV3EnvironmentVersionConfig);
  checkGoogleCloudDialogflowCxV3EnvironmentVersionConfig(
      o[1] as api.GoogleCloudDialogflowCxV3EnvironmentVersionConfig);
}

core.int buildCounterGoogleCloudDialogflowCxV3Environment = 0;
api.GoogleCloudDialogflowCxV3Environment
    buildGoogleCloudDialogflowCxV3Environment() {
  var o = api.GoogleCloudDialogflowCxV3Environment();
  buildCounterGoogleCloudDialogflowCxV3Environment++;
  if (buildCounterGoogleCloudDialogflowCxV3Environment < 3) {
    o.description = 'foo';
    o.displayName = 'foo';
    o.name = 'foo';
    o.updateTime = 'foo';
    o.versionConfigs = buildUnnamed118();
  }
  buildCounterGoogleCloudDialogflowCxV3Environment--;
  return o;
}

void checkGoogleCloudDialogflowCxV3Environment(
    api.GoogleCloudDialogflowCxV3Environment o) {
  buildCounterGoogleCloudDialogflowCxV3Environment++;
  if (buildCounterGoogleCloudDialogflowCxV3Environment < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.updateTime!,
      unittest.equals('foo'),
    );
    checkUnnamed118(o.versionConfigs!);
  }
  buildCounterGoogleCloudDialogflowCxV3Environment--;
}

core.int buildCounterGoogleCloudDialogflowCxV3EnvironmentVersionConfig = 0;
api.GoogleCloudDialogflowCxV3EnvironmentVersionConfig
    buildGoogleCloudDialogflowCxV3EnvironmentVersionConfig() {
  var o = api.GoogleCloudDialogflowCxV3EnvironmentVersionConfig();
  buildCounterGoogleCloudDialogflowCxV3EnvironmentVersionConfig++;
  if (buildCounterGoogleCloudDialogflowCxV3EnvironmentVersionConfig < 3) {
    o.version = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3EnvironmentVersionConfig--;
  return o;
}

void checkGoogleCloudDialogflowCxV3EnvironmentVersionConfig(
    api.GoogleCloudDialogflowCxV3EnvironmentVersionConfig o) {
  buildCounterGoogleCloudDialogflowCxV3EnvironmentVersionConfig++;
  if (buildCounterGoogleCloudDialogflowCxV3EnvironmentVersionConfig < 3) {
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3EnvironmentVersionConfig--;
}

core.int buildCounterGoogleCloudDialogflowCxV3EventHandler = 0;
api.GoogleCloudDialogflowCxV3EventHandler
    buildGoogleCloudDialogflowCxV3EventHandler() {
  var o = api.GoogleCloudDialogflowCxV3EventHandler();
  buildCounterGoogleCloudDialogflowCxV3EventHandler++;
  if (buildCounterGoogleCloudDialogflowCxV3EventHandler < 3) {
    o.event = 'foo';
    o.name = 'foo';
    o.targetFlow = 'foo';
    o.targetPage = 'foo';
    o.triggerFulfillment = buildGoogleCloudDialogflowCxV3Fulfillment();
  }
  buildCounterGoogleCloudDialogflowCxV3EventHandler--;
  return o;
}

void checkGoogleCloudDialogflowCxV3EventHandler(
    api.GoogleCloudDialogflowCxV3EventHandler o) {
  buildCounterGoogleCloudDialogflowCxV3EventHandler++;
  if (buildCounterGoogleCloudDialogflowCxV3EventHandler < 3) {
    unittest.expect(
      o.event!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.targetFlow!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.targetPage!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3Fulfillment(
        o.triggerFulfillment! as api.GoogleCloudDialogflowCxV3Fulfillment);
  }
  buildCounterGoogleCloudDialogflowCxV3EventHandler--;
}

core.int buildCounterGoogleCloudDialogflowCxV3EventInput = 0;
api.GoogleCloudDialogflowCxV3EventInput
    buildGoogleCloudDialogflowCxV3EventInput() {
  var o = api.GoogleCloudDialogflowCxV3EventInput();
  buildCounterGoogleCloudDialogflowCxV3EventInput++;
  if (buildCounterGoogleCloudDialogflowCxV3EventInput < 3) {
    o.event = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3EventInput--;
  return o;
}

void checkGoogleCloudDialogflowCxV3EventInput(
    api.GoogleCloudDialogflowCxV3EventInput o) {
  buildCounterGoogleCloudDialogflowCxV3EventInput++;
  if (buildCounterGoogleCloudDialogflowCxV3EventInput < 3) {
    unittest.expect(
      o.event!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3EventInput--;
}

core.List<api.GoogleCloudDialogflowCxV3VariantsHistory> buildUnnamed119() {
  var o = <api.GoogleCloudDialogflowCxV3VariantsHistory>[];
  o.add(buildGoogleCloudDialogflowCxV3VariantsHistory());
  o.add(buildGoogleCloudDialogflowCxV3VariantsHistory());
  return o;
}

void checkUnnamed119(
    core.List<api.GoogleCloudDialogflowCxV3VariantsHistory> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3VariantsHistory(
      o[0] as api.GoogleCloudDialogflowCxV3VariantsHistory);
  checkGoogleCloudDialogflowCxV3VariantsHistory(
      o[1] as api.GoogleCloudDialogflowCxV3VariantsHistory);
}

core.int buildCounterGoogleCloudDialogflowCxV3Experiment = 0;
api.GoogleCloudDialogflowCxV3Experiment
    buildGoogleCloudDialogflowCxV3Experiment() {
  var o = api.GoogleCloudDialogflowCxV3Experiment();
  buildCounterGoogleCloudDialogflowCxV3Experiment++;
  if (buildCounterGoogleCloudDialogflowCxV3Experiment < 3) {
    o.createTime = 'foo';
    o.definition = buildGoogleCloudDialogflowCxV3ExperimentDefinition();
    o.description = 'foo';
    o.displayName = 'foo';
    o.endTime = 'foo';
    o.experimentLength = 'foo';
    o.lastUpdateTime = 'foo';
    o.name = 'foo';
    o.result = buildGoogleCloudDialogflowCxV3ExperimentResult();
    o.startTime = 'foo';
    o.state = 'foo';
    o.variantsHistory = buildUnnamed119();
  }
  buildCounterGoogleCloudDialogflowCxV3Experiment--;
  return o;
}

void checkGoogleCloudDialogflowCxV3Experiment(
    api.GoogleCloudDialogflowCxV3Experiment o) {
  buildCounterGoogleCloudDialogflowCxV3Experiment++;
  if (buildCounterGoogleCloudDialogflowCxV3Experiment < 3) {
    unittest.expect(
      o.createTime!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3ExperimentDefinition(
        o.definition! as api.GoogleCloudDialogflowCxV3ExperimentDefinition);
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.endTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.experimentLength!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.lastUpdateTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3ExperimentResult(
        o.result! as api.GoogleCloudDialogflowCxV3ExperimentResult);
    unittest.expect(
      o.startTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
    checkUnnamed119(o.variantsHistory!);
  }
  buildCounterGoogleCloudDialogflowCxV3Experiment--;
}

core.int buildCounterGoogleCloudDialogflowCxV3ExperimentDefinition = 0;
api.GoogleCloudDialogflowCxV3ExperimentDefinition
    buildGoogleCloudDialogflowCxV3ExperimentDefinition() {
  var o = api.GoogleCloudDialogflowCxV3ExperimentDefinition();
  buildCounterGoogleCloudDialogflowCxV3ExperimentDefinition++;
  if (buildCounterGoogleCloudDialogflowCxV3ExperimentDefinition < 3) {
    o.condition = 'foo';
    o.versionVariants = buildGoogleCloudDialogflowCxV3VersionVariants();
  }
  buildCounterGoogleCloudDialogflowCxV3ExperimentDefinition--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ExperimentDefinition(
    api.GoogleCloudDialogflowCxV3ExperimentDefinition o) {
  buildCounterGoogleCloudDialogflowCxV3ExperimentDefinition++;
  if (buildCounterGoogleCloudDialogflowCxV3ExperimentDefinition < 3) {
    unittest.expect(
      o.condition!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3VersionVariants(
        o.versionVariants! as api.GoogleCloudDialogflowCxV3VersionVariants);
  }
  buildCounterGoogleCloudDialogflowCxV3ExperimentDefinition--;
}

core.List<api.GoogleCloudDialogflowCxV3ExperimentResultVersionMetrics>
    buildUnnamed120() {
  var o = <api.GoogleCloudDialogflowCxV3ExperimentResultVersionMetrics>[];
  o.add(buildGoogleCloudDialogflowCxV3ExperimentResultVersionMetrics());
  o.add(buildGoogleCloudDialogflowCxV3ExperimentResultVersionMetrics());
  return o;
}

void checkUnnamed120(
    core.List<api.GoogleCloudDialogflowCxV3ExperimentResultVersionMetrics> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3ExperimentResultVersionMetrics(
      o[0] as api.GoogleCloudDialogflowCxV3ExperimentResultVersionMetrics);
  checkGoogleCloudDialogflowCxV3ExperimentResultVersionMetrics(
      o[1] as api.GoogleCloudDialogflowCxV3ExperimentResultVersionMetrics);
}

core.int buildCounterGoogleCloudDialogflowCxV3ExperimentResult = 0;
api.GoogleCloudDialogflowCxV3ExperimentResult
    buildGoogleCloudDialogflowCxV3ExperimentResult() {
  var o = api.GoogleCloudDialogflowCxV3ExperimentResult();
  buildCounterGoogleCloudDialogflowCxV3ExperimentResult++;
  if (buildCounterGoogleCloudDialogflowCxV3ExperimentResult < 3) {
    o.lastUpdateTime = 'foo';
    o.versionMetrics = buildUnnamed120();
  }
  buildCounterGoogleCloudDialogflowCxV3ExperimentResult--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ExperimentResult(
    api.GoogleCloudDialogflowCxV3ExperimentResult o) {
  buildCounterGoogleCloudDialogflowCxV3ExperimentResult++;
  if (buildCounterGoogleCloudDialogflowCxV3ExperimentResult < 3) {
    unittest.expect(
      o.lastUpdateTime!,
      unittest.equals('foo'),
    );
    checkUnnamed120(o.versionMetrics!);
  }
  buildCounterGoogleCloudDialogflowCxV3ExperimentResult--;
}

core.int
    buildCounterGoogleCloudDialogflowCxV3ExperimentResultConfidenceInterval = 0;
api.GoogleCloudDialogflowCxV3ExperimentResultConfidenceInterval
    buildGoogleCloudDialogflowCxV3ExperimentResultConfidenceInterval() {
  var o = api.GoogleCloudDialogflowCxV3ExperimentResultConfidenceInterval();
  buildCounterGoogleCloudDialogflowCxV3ExperimentResultConfidenceInterval++;
  if (buildCounterGoogleCloudDialogflowCxV3ExperimentResultConfidenceInterval <
      3) {
    o.confidenceLevel = 42.0;
    o.lowerBound = 42.0;
    o.ratio = 42.0;
    o.upperBound = 42.0;
  }
  buildCounterGoogleCloudDialogflowCxV3ExperimentResultConfidenceInterval--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ExperimentResultConfidenceInterval(
    api.GoogleCloudDialogflowCxV3ExperimentResultConfidenceInterval o) {
  buildCounterGoogleCloudDialogflowCxV3ExperimentResultConfidenceInterval++;
  if (buildCounterGoogleCloudDialogflowCxV3ExperimentResultConfidenceInterval <
      3) {
    unittest.expect(
      o.confidenceLevel!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.lowerBound!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.ratio!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.upperBound!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3ExperimentResultConfidenceInterval--;
}

core.int buildCounterGoogleCloudDialogflowCxV3ExperimentResultMetric = 0;
api.GoogleCloudDialogflowCxV3ExperimentResultMetric
    buildGoogleCloudDialogflowCxV3ExperimentResultMetric() {
  var o = api.GoogleCloudDialogflowCxV3ExperimentResultMetric();
  buildCounterGoogleCloudDialogflowCxV3ExperimentResultMetric++;
  if (buildCounterGoogleCloudDialogflowCxV3ExperimentResultMetric < 3) {
    o.confidenceInterval =
        buildGoogleCloudDialogflowCxV3ExperimentResultConfidenceInterval();
    o.count = 42.0;
    o.countType = 'foo';
    o.ratio = 42.0;
    o.type = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3ExperimentResultMetric--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ExperimentResultMetric(
    api.GoogleCloudDialogflowCxV3ExperimentResultMetric o) {
  buildCounterGoogleCloudDialogflowCxV3ExperimentResultMetric++;
  if (buildCounterGoogleCloudDialogflowCxV3ExperimentResultMetric < 3) {
    checkGoogleCloudDialogflowCxV3ExperimentResultConfidenceInterval(
        o.confidenceInterval!
            as api.GoogleCloudDialogflowCxV3ExperimentResultConfidenceInterval);
    unittest.expect(
      o.count!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.countType!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.ratio!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3ExperimentResultMetric--;
}

core.List<api.GoogleCloudDialogflowCxV3ExperimentResultMetric>
    buildUnnamed121() {
  var o = <api.GoogleCloudDialogflowCxV3ExperimentResultMetric>[];
  o.add(buildGoogleCloudDialogflowCxV3ExperimentResultMetric());
  o.add(buildGoogleCloudDialogflowCxV3ExperimentResultMetric());
  return o;
}

void checkUnnamed121(
    core.List<api.GoogleCloudDialogflowCxV3ExperimentResultMetric> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3ExperimentResultMetric(
      o[0] as api.GoogleCloudDialogflowCxV3ExperimentResultMetric);
  checkGoogleCloudDialogflowCxV3ExperimentResultMetric(
      o[1] as api.GoogleCloudDialogflowCxV3ExperimentResultMetric);
}

core.int buildCounterGoogleCloudDialogflowCxV3ExperimentResultVersionMetrics =
    0;
api.GoogleCloudDialogflowCxV3ExperimentResultVersionMetrics
    buildGoogleCloudDialogflowCxV3ExperimentResultVersionMetrics() {
  var o = api.GoogleCloudDialogflowCxV3ExperimentResultVersionMetrics();
  buildCounterGoogleCloudDialogflowCxV3ExperimentResultVersionMetrics++;
  if (buildCounterGoogleCloudDialogflowCxV3ExperimentResultVersionMetrics < 3) {
    o.metrics = buildUnnamed121();
    o.sessionCount = 42;
    o.version = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3ExperimentResultVersionMetrics--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ExperimentResultVersionMetrics(
    api.GoogleCloudDialogflowCxV3ExperimentResultVersionMetrics o) {
  buildCounterGoogleCloudDialogflowCxV3ExperimentResultVersionMetrics++;
  if (buildCounterGoogleCloudDialogflowCxV3ExperimentResultVersionMetrics < 3) {
    checkUnnamed121(o.metrics!);
    unittest.expect(
      o.sessionCount!,
      unittest.equals(42),
    );
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3ExperimentResultVersionMetrics--;
}

core.int buildCounterGoogleCloudDialogflowCxV3ExportAgentRequest = 0;
api.GoogleCloudDialogflowCxV3ExportAgentRequest
    buildGoogleCloudDialogflowCxV3ExportAgentRequest() {
  var o = api.GoogleCloudDialogflowCxV3ExportAgentRequest();
  buildCounterGoogleCloudDialogflowCxV3ExportAgentRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3ExportAgentRequest < 3) {
    o.agentUri = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3ExportAgentRequest--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ExportAgentRequest(
    api.GoogleCloudDialogflowCxV3ExportAgentRequest o) {
  buildCounterGoogleCloudDialogflowCxV3ExportAgentRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3ExportAgentRequest < 3) {
    unittest.expect(
      o.agentUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3ExportAgentRequest--;
}

core.int buildCounterGoogleCloudDialogflowCxV3ExportAgentResponse = 0;
api.GoogleCloudDialogflowCxV3ExportAgentResponse
    buildGoogleCloudDialogflowCxV3ExportAgentResponse() {
  var o = api.GoogleCloudDialogflowCxV3ExportAgentResponse();
  buildCounterGoogleCloudDialogflowCxV3ExportAgentResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ExportAgentResponse < 3) {
    o.agentContent = 'foo';
    o.agentUri = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3ExportAgentResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ExportAgentResponse(
    api.GoogleCloudDialogflowCxV3ExportAgentResponse o) {
  buildCounterGoogleCloudDialogflowCxV3ExportAgentResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ExportAgentResponse < 3) {
    unittest.expect(
      o.agentContent!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.agentUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3ExportAgentResponse--;
}

core.int buildCounterGoogleCloudDialogflowCxV3ExportTestCasesMetadata = 0;
api.GoogleCloudDialogflowCxV3ExportTestCasesMetadata
    buildGoogleCloudDialogflowCxV3ExportTestCasesMetadata() {
  var o = api.GoogleCloudDialogflowCxV3ExportTestCasesMetadata();
  buildCounterGoogleCloudDialogflowCxV3ExportTestCasesMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3ExportTestCasesMetadata < 3) {}
  buildCounterGoogleCloudDialogflowCxV3ExportTestCasesMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ExportTestCasesMetadata(
    api.GoogleCloudDialogflowCxV3ExportTestCasesMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3ExportTestCasesMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3ExportTestCasesMetadata < 3) {}
  buildCounterGoogleCloudDialogflowCxV3ExportTestCasesMetadata--;
}

core.int buildCounterGoogleCloudDialogflowCxV3ExportTestCasesRequest = 0;
api.GoogleCloudDialogflowCxV3ExportTestCasesRequest
    buildGoogleCloudDialogflowCxV3ExportTestCasesRequest() {
  var o = api.GoogleCloudDialogflowCxV3ExportTestCasesRequest();
  buildCounterGoogleCloudDialogflowCxV3ExportTestCasesRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3ExportTestCasesRequest < 3) {
    o.dataFormat = 'foo';
    o.filter = 'foo';
    o.gcsUri = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3ExportTestCasesRequest--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ExportTestCasesRequest(
    api.GoogleCloudDialogflowCxV3ExportTestCasesRequest o) {
  buildCounterGoogleCloudDialogflowCxV3ExportTestCasesRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3ExportTestCasesRequest < 3) {
    unittest.expect(
      o.dataFormat!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.filter!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.gcsUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3ExportTestCasesRequest--;
}

core.int buildCounterGoogleCloudDialogflowCxV3ExportTestCasesResponse = 0;
api.GoogleCloudDialogflowCxV3ExportTestCasesResponse
    buildGoogleCloudDialogflowCxV3ExportTestCasesResponse() {
  var o = api.GoogleCloudDialogflowCxV3ExportTestCasesResponse();
  buildCounterGoogleCloudDialogflowCxV3ExportTestCasesResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ExportTestCasesResponse < 3) {
    o.content = 'foo';
    o.gcsUri = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3ExportTestCasesResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ExportTestCasesResponse(
    api.GoogleCloudDialogflowCxV3ExportTestCasesResponse o) {
  buildCounterGoogleCloudDialogflowCxV3ExportTestCasesResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ExportTestCasesResponse < 3) {
    unittest.expect(
      o.content!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.gcsUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3ExportTestCasesResponse--;
}

core.List<api.GoogleCloudDialogflowCxV3EventHandler> buildUnnamed122() {
  var o = <api.GoogleCloudDialogflowCxV3EventHandler>[];
  o.add(buildGoogleCloudDialogflowCxV3EventHandler());
  o.add(buildGoogleCloudDialogflowCxV3EventHandler());
  return o;
}

void checkUnnamed122(core.List<api.GoogleCloudDialogflowCxV3EventHandler> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3EventHandler(
      o[0] as api.GoogleCloudDialogflowCxV3EventHandler);
  checkGoogleCloudDialogflowCxV3EventHandler(
      o[1] as api.GoogleCloudDialogflowCxV3EventHandler);
}

core.List<api.GoogleCloudDialogflowCxV3TransitionRoute> buildUnnamed123() {
  var o = <api.GoogleCloudDialogflowCxV3TransitionRoute>[];
  o.add(buildGoogleCloudDialogflowCxV3TransitionRoute());
  o.add(buildGoogleCloudDialogflowCxV3TransitionRoute());
  return o;
}

void checkUnnamed123(
    core.List<api.GoogleCloudDialogflowCxV3TransitionRoute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3TransitionRoute(
      o[0] as api.GoogleCloudDialogflowCxV3TransitionRoute);
  checkGoogleCloudDialogflowCxV3TransitionRoute(
      o[1] as api.GoogleCloudDialogflowCxV3TransitionRoute);
}

core.int buildCounterGoogleCloudDialogflowCxV3Flow = 0;
api.GoogleCloudDialogflowCxV3Flow buildGoogleCloudDialogflowCxV3Flow() {
  var o = api.GoogleCloudDialogflowCxV3Flow();
  buildCounterGoogleCloudDialogflowCxV3Flow++;
  if (buildCounterGoogleCloudDialogflowCxV3Flow < 3) {
    o.description = 'foo';
    o.displayName = 'foo';
    o.eventHandlers = buildUnnamed122();
    o.name = 'foo';
    o.nluSettings = buildGoogleCloudDialogflowCxV3NluSettings();
    o.transitionRoutes = buildUnnamed123();
  }
  buildCounterGoogleCloudDialogflowCxV3Flow--;
  return o;
}

void checkGoogleCloudDialogflowCxV3Flow(api.GoogleCloudDialogflowCxV3Flow o) {
  buildCounterGoogleCloudDialogflowCxV3Flow++;
  if (buildCounterGoogleCloudDialogflowCxV3Flow < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    checkUnnamed122(o.eventHandlers!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3NluSettings(
        o.nluSettings! as api.GoogleCloudDialogflowCxV3NluSettings);
    checkUnnamed123(o.transitionRoutes!);
  }
  buildCounterGoogleCloudDialogflowCxV3Flow--;
}

core.List<api.GoogleCloudDialogflowCxV3ValidationMessage> buildUnnamed124() {
  var o = <api.GoogleCloudDialogflowCxV3ValidationMessage>[];
  o.add(buildGoogleCloudDialogflowCxV3ValidationMessage());
  o.add(buildGoogleCloudDialogflowCxV3ValidationMessage());
  return o;
}

void checkUnnamed124(
    core.List<api.GoogleCloudDialogflowCxV3ValidationMessage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3ValidationMessage(
      o[0] as api.GoogleCloudDialogflowCxV3ValidationMessage);
  checkGoogleCloudDialogflowCxV3ValidationMessage(
      o[1] as api.GoogleCloudDialogflowCxV3ValidationMessage);
}

core.int buildCounterGoogleCloudDialogflowCxV3FlowValidationResult = 0;
api.GoogleCloudDialogflowCxV3FlowValidationResult
    buildGoogleCloudDialogflowCxV3FlowValidationResult() {
  var o = api.GoogleCloudDialogflowCxV3FlowValidationResult();
  buildCounterGoogleCloudDialogflowCxV3FlowValidationResult++;
  if (buildCounterGoogleCloudDialogflowCxV3FlowValidationResult < 3) {
    o.name = 'foo';
    o.updateTime = 'foo';
    o.validationMessages = buildUnnamed124();
  }
  buildCounterGoogleCloudDialogflowCxV3FlowValidationResult--;
  return o;
}

void checkGoogleCloudDialogflowCxV3FlowValidationResult(
    api.GoogleCloudDialogflowCxV3FlowValidationResult o) {
  buildCounterGoogleCloudDialogflowCxV3FlowValidationResult++;
  if (buildCounterGoogleCloudDialogflowCxV3FlowValidationResult < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.updateTime!,
      unittest.equals('foo'),
    );
    checkUnnamed124(o.validationMessages!);
  }
  buildCounterGoogleCloudDialogflowCxV3FlowValidationResult--;
}

core.List<api.GoogleCloudDialogflowCxV3FormParameter> buildUnnamed125() {
  var o = <api.GoogleCloudDialogflowCxV3FormParameter>[];
  o.add(buildGoogleCloudDialogflowCxV3FormParameter());
  o.add(buildGoogleCloudDialogflowCxV3FormParameter());
  return o;
}

void checkUnnamed125(core.List<api.GoogleCloudDialogflowCxV3FormParameter> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3FormParameter(
      o[0] as api.GoogleCloudDialogflowCxV3FormParameter);
  checkGoogleCloudDialogflowCxV3FormParameter(
      o[1] as api.GoogleCloudDialogflowCxV3FormParameter);
}

core.int buildCounterGoogleCloudDialogflowCxV3Form = 0;
api.GoogleCloudDialogflowCxV3Form buildGoogleCloudDialogflowCxV3Form() {
  var o = api.GoogleCloudDialogflowCxV3Form();
  buildCounterGoogleCloudDialogflowCxV3Form++;
  if (buildCounterGoogleCloudDialogflowCxV3Form < 3) {
    o.parameters = buildUnnamed125();
  }
  buildCounterGoogleCloudDialogflowCxV3Form--;
  return o;
}

void checkGoogleCloudDialogflowCxV3Form(api.GoogleCloudDialogflowCxV3Form o) {
  buildCounterGoogleCloudDialogflowCxV3Form++;
  if (buildCounterGoogleCloudDialogflowCxV3Form < 3) {
    checkUnnamed125(o.parameters!);
  }
  buildCounterGoogleCloudDialogflowCxV3Form--;
}

core.int buildCounterGoogleCloudDialogflowCxV3FormParameter = 0;
api.GoogleCloudDialogflowCxV3FormParameter
    buildGoogleCloudDialogflowCxV3FormParameter() {
  var o = api.GoogleCloudDialogflowCxV3FormParameter();
  buildCounterGoogleCloudDialogflowCxV3FormParameter++;
  if (buildCounterGoogleCloudDialogflowCxV3FormParameter < 3) {
    o.defaultValue = {
      'list': [1, 2, 3],
      'bool': true,
      'string': 'foo'
    };
    o.displayName = 'foo';
    o.entityType = 'foo';
    o.fillBehavior = buildGoogleCloudDialogflowCxV3FormParameterFillBehavior();
    o.isList = true;
    o.redact = true;
    o.required = true;
  }
  buildCounterGoogleCloudDialogflowCxV3FormParameter--;
  return o;
}

void checkGoogleCloudDialogflowCxV3FormParameter(
    api.GoogleCloudDialogflowCxV3FormParameter o) {
  buildCounterGoogleCloudDialogflowCxV3FormParameter++;
  if (buildCounterGoogleCloudDialogflowCxV3FormParameter < 3) {
    var casted7 = (o.defaultValue!) as core.Map;
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
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.entityType!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3FormParameterFillBehavior(o.fillBehavior!
        as api.GoogleCloudDialogflowCxV3FormParameterFillBehavior);
    unittest.expect(o.isList!, unittest.isTrue);
    unittest.expect(o.redact!, unittest.isTrue);
    unittest.expect(o.required!, unittest.isTrue);
  }
  buildCounterGoogleCloudDialogflowCxV3FormParameter--;
}

core.List<api.GoogleCloudDialogflowCxV3EventHandler> buildUnnamed126() {
  var o = <api.GoogleCloudDialogflowCxV3EventHandler>[];
  o.add(buildGoogleCloudDialogflowCxV3EventHandler());
  o.add(buildGoogleCloudDialogflowCxV3EventHandler());
  return o;
}

void checkUnnamed126(core.List<api.GoogleCloudDialogflowCxV3EventHandler> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3EventHandler(
      o[0] as api.GoogleCloudDialogflowCxV3EventHandler);
  checkGoogleCloudDialogflowCxV3EventHandler(
      o[1] as api.GoogleCloudDialogflowCxV3EventHandler);
}

core.int buildCounterGoogleCloudDialogflowCxV3FormParameterFillBehavior = 0;
api.GoogleCloudDialogflowCxV3FormParameterFillBehavior
    buildGoogleCloudDialogflowCxV3FormParameterFillBehavior() {
  var o = api.GoogleCloudDialogflowCxV3FormParameterFillBehavior();
  buildCounterGoogleCloudDialogflowCxV3FormParameterFillBehavior++;
  if (buildCounterGoogleCloudDialogflowCxV3FormParameterFillBehavior < 3) {
    o.initialPromptFulfillment = buildGoogleCloudDialogflowCxV3Fulfillment();
    o.repromptEventHandlers = buildUnnamed126();
  }
  buildCounterGoogleCloudDialogflowCxV3FormParameterFillBehavior--;
  return o;
}

void checkGoogleCloudDialogflowCxV3FormParameterFillBehavior(
    api.GoogleCloudDialogflowCxV3FormParameterFillBehavior o) {
  buildCounterGoogleCloudDialogflowCxV3FormParameterFillBehavior++;
  if (buildCounterGoogleCloudDialogflowCxV3FormParameterFillBehavior < 3) {
    checkGoogleCloudDialogflowCxV3Fulfillment(o.initialPromptFulfillment!
        as api.GoogleCloudDialogflowCxV3Fulfillment);
    checkUnnamed126(o.repromptEventHandlers!);
  }
  buildCounterGoogleCloudDialogflowCxV3FormParameterFillBehavior--;
}

core.int buildCounterGoogleCloudDialogflowCxV3FulfillIntentRequest = 0;
api.GoogleCloudDialogflowCxV3FulfillIntentRequest
    buildGoogleCloudDialogflowCxV3FulfillIntentRequest() {
  var o = api.GoogleCloudDialogflowCxV3FulfillIntentRequest();
  buildCounterGoogleCloudDialogflowCxV3FulfillIntentRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3FulfillIntentRequest < 3) {
    o.match = buildGoogleCloudDialogflowCxV3Match();
    o.matchIntentRequest = buildGoogleCloudDialogflowCxV3MatchIntentRequest();
    o.outputAudioConfig = buildGoogleCloudDialogflowCxV3OutputAudioConfig();
  }
  buildCounterGoogleCloudDialogflowCxV3FulfillIntentRequest--;
  return o;
}

void checkGoogleCloudDialogflowCxV3FulfillIntentRequest(
    api.GoogleCloudDialogflowCxV3FulfillIntentRequest o) {
  buildCounterGoogleCloudDialogflowCxV3FulfillIntentRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3FulfillIntentRequest < 3) {
    checkGoogleCloudDialogflowCxV3Match(
        o.match! as api.GoogleCloudDialogflowCxV3Match);
    checkGoogleCloudDialogflowCxV3MatchIntentRequest(o.matchIntentRequest!
        as api.GoogleCloudDialogflowCxV3MatchIntentRequest);
    checkGoogleCloudDialogflowCxV3OutputAudioConfig(
        o.outputAudioConfig! as api.GoogleCloudDialogflowCxV3OutputAudioConfig);
  }
  buildCounterGoogleCloudDialogflowCxV3FulfillIntentRequest--;
}

core.int buildCounterGoogleCloudDialogflowCxV3FulfillIntentResponse = 0;
api.GoogleCloudDialogflowCxV3FulfillIntentResponse
    buildGoogleCloudDialogflowCxV3FulfillIntentResponse() {
  var o = api.GoogleCloudDialogflowCxV3FulfillIntentResponse();
  buildCounterGoogleCloudDialogflowCxV3FulfillIntentResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3FulfillIntentResponse < 3) {
    o.outputAudio = 'foo';
    o.outputAudioConfig = buildGoogleCloudDialogflowCxV3OutputAudioConfig();
    o.queryResult = buildGoogleCloudDialogflowCxV3QueryResult();
    o.responseId = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3FulfillIntentResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3FulfillIntentResponse(
    api.GoogleCloudDialogflowCxV3FulfillIntentResponse o) {
  buildCounterGoogleCloudDialogflowCxV3FulfillIntentResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3FulfillIntentResponse < 3) {
    unittest.expect(
      o.outputAudio!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3OutputAudioConfig(
        o.outputAudioConfig! as api.GoogleCloudDialogflowCxV3OutputAudioConfig);
    checkGoogleCloudDialogflowCxV3QueryResult(
        o.queryResult! as api.GoogleCloudDialogflowCxV3QueryResult);
    unittest.expect(
      o.responseId!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3FulfillIntentResponse--;
}

core.List<api.GoogleCloudDialogflowCxV3FulfillmentConditionalCases>
    buildUnnamed127() {
  var o = <api.GoogleCloudDialogflowCxV3FulfillmentConditionalCases>[];
  o.add(buildGoogleCloudDialogflowCxV3FulfillmentConditionalCases());
  o.add(buildGoogleCloudDialogflowCxV3FulfillmentConditionalCases());
  return o;
}

void checkUnnamed127(
    core.List<api.GoogleCloudDialogflowCxV3FulfillmentConditionalCases> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3FulfillmentConditionalCases(
      o[0] as api.GoogleCloudDialogflowCxV3FulfillmentConditionalCases);
  checkGoogleCloudDialogflowCxV3FulfillmentConditionalCases(
      o[1] as api.GoogleCloudDialogflowCxV3FulfillmentConditionalCases);
}

core.List<api.GoogleCloudDialogflowCxV3ResponseMessage> buildUnnamed128() {
  var o = <api.GoogleCloudDialogflowCxV3ResponseMessage>[];
  o.add(buildGoogleCloudDialogflowCxV3ResponseMessage());
  o.add(buildGoogleCloudDialogflowCxV3ResponseMessage());
  return o;
}

void checkUnnamed128(
    core.List<api.GoogleCloudDialogflowCxV3ResponseMessage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3ResponseMessage(
      o[0] as api.GoogleCloudDialogflowCxV3ResponseMessage);
  checkGoogleCloudDialogflowCxV3ResponseMessage(
      o[1] as api.GoogleCloudDialogflowCxV3ResponseMessage);
}

core.List<api.GoogleCloudDialogflowCxV3FulfillmentSetParameterAction>
    buildUnnamed129() {
  var o = <api.GoogleCloudDialogflowCxV3FulfillmentSetParameterAction>[];
  o.add(buildGoogleCloudDialogflowCxV3FulfillmentSetParameterAction());
  o.add(buildGoogleCloudDialogflowCxV3FulfillmentSetParameterAction());
  return o;
}

void checkUnnamed129(
    core.List<api.GoogleCloudDialogflowCxV3FulfillmentSetParameterAction> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3FulfillmentSetParameterAction(
      o[0] as api.GoogleCloudDialogflowCxV3FulfillmentSetParameterAction);
  checkGoogleCloudDialogflowCxV3FulfillmentSetParameterAction(
      o[1] as api.GoogleCloudDialogflowCxV3FulfillmentSetParameterAction);
}

core.int buildCounterGoogleCloudDialogflowCxV3Fulfillment = 0;
api.GoogleCloudDialogflowCxV3Fulfillment
    buildGoogleCloudDialogflowCxV3Fulfillment() {
  var o = api.GoogleCloudDialogflowCxV3Fulfillment();
  buildCounterGoogleCloudDialogflowCxV3Fulfillment++;
  if (buildCounterGoogleCloudDialogflowCxV3Fulfillment < 3) {
    o.conditionalCases = buildUnnamed127();
    o.messages = buildUnnamed128();
    o.setParameterActions = buildUnnamed129();
    o.tag = 'foo';
    o.webhook = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3Fulfillment--;
  return o;
}

void checkGoogleCloudDialogflowCxV3Fulfillment(
    api.GoogleCloudDialogflowCxV3Fulfillment o) {
  buildCounterGoogleCloudDialogflowCxV3Fulfillment++;
  if (buildCounterGoogleCloudDialogflowCxV3Fulfillment < 3) {
    checkUnnamed127(o.conditionalCases!);
    checkUnnamed128(o.messages!);
    checkUnnamed129(o.setParameterActions!);
    unittest.expect(
      o.tag!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.webhook!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3Fulfillment--;
}

core.List<api.GoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase>
    buildUnnamed130() {
  var o = <api.GoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase>[];
  o.add(buildGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase());
  o.add(buildGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase());
  return o;
}

void checkUnnamed130(
    core.List<api.GoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase(
      o[0] as api.GoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase);
  checkGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase(
      o[1] as api.GoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase);
}

core.int buildCounterGoogleCloudDialogflowCxV3FulfillmentConditionalCases = 0;
api.GoogleCloudDialogflowCxV3FulfillmentConditionalCases
    buildGoogleCloudDialogflowCxV3FulfillmentConditionalCases() {
  var o = api.GoogleCloudDialogflowCxV3FulfillmentConditionalCases();
  buildCounterGoogleCloudDialogflowCxV3FulfillmentConditionalCases++;
  if (buildCounterGoogleCloudDialogflowCxV3FulfillmentConditionalCases < 3) {
    o.cases = buildUnnamed130();
  }
  buildCounterGoogleCloudDialogflowCxV3FulfillmentConditionalCases--;
  return o;
}

void checkGoogleCloudDialogflowCxV3FulfillmentConditionalCases(
    api.GoogleCloudDialogflowCxV3FulfillmentConditionalCases o) {
  buildCounterGoogleCloudDialogflowCxV3FulfillmentConditionalCases++;
  if (buildCounterGoogleCloudDialogflowCxV3FulfillmentConditionalCases < 3) {
    checkUnnamed130(o.cases!);
  }
  buildCounterGoogleCloudDialogflowCxV3FulfillmentConditionalCases--;
}

core.List<
        api.GoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent>
    buildUnnamed131() {
  var o = <
      api.GoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent>[];
  o.add(
      buildGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent());
  o.add(
      buildGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent());
  return o;
}

void checkUnnamed131(
    core.List<
            api.GoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent(o[0]
      as api
          .GoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent);
  checkGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent(o[1]
      as api
          .GoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent);
}

core.int buildCounterGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase =
    0;
api.GoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase
    buildGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase() {
  var o = api.GoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase();
  buildCounterGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase++;
  if (buildCounterGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase <
      3) {
    o.caseContent = buildUnnamed131();
    o.condition = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase--;
  return o;
}

void checkGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase(
    api.GoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase o) {
  buildCounterGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase++;
  if (buildCounterGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase <
      3) {
    checkUnnamed131(o.caseContent!);
    unittest.expect(
      o.condition!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase--;
}

core.int
    buildCounterGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent =
    0;
api.GoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent
    buildGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent() {
  var o =
      api.GoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent();
  buildCounterGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent++;
  if (buildCounterGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent <
      3) {
    o.additionalCases =
        buildGoogleCloudDialogflowCxV3FulfillmentConditionalCases();
    o.message = buildGoogleCloudDialogflowCxV3ResponseMessage();
  }
  buildCounterGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent--;
  return o;
}

void checkGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent(
    api.GoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent o) {
  buildCounterGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent++;
  if (buildCounterGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent <
      3) {
    checkGoogleCloudDialogflowCxV3FulfillmentConditionalCases(o.additionalCases!
        as api.GoogleCloudDialogflowCxV3FulfillmentConditionalCases);
    checkGoogleCloudDialogflowCxV3ResponseMessage(
        o.message! as api.GoogleCloudDialogflowCxV3ResponseMessage);
  }
  buildCounterGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent--;
}

core.int buildCounterGoogleCloudDialogflowCxV3FulfillmentSetParameterAction = 0;
api.GoogleCloudDialogflowCxV3FulfillmentSetParameterAction
    buildGoogleCloudDialogflowCxV3FulfillmentSetParameterAction() {
  var o = api.GoogleCloudDialogflowCxV3FulfillmentSetParameterAction();
  buildCounterGoogleCloudDialogflowCxV3FulfillmentSetParameterAction++;
  if (buildCounterGoogleCloudDialogflowCxV3FulfillmentSetParameterAction < 3) {
    o.parameter = 'foo';
    o.value = {
      'list': [1, 2, 3],
      'bool': true,
      'string': 'foo'
    };
  }
  buildCounterGoogleCloudDialogflowCxV3FulfillmentSetParameterAction--;
  return o;
}

void checkGoogleCloudDialogflowCxV3FulfillmentSetParameterAction(
    api.GoogleCloudDialogflowCxV3FulfillmentSetParameterAction o) {
  buildCounterGoogleCloudDialogflowCxV3FulfillmentSetParameterAction++;
  if (buildCounterGoogleCloudDialogflowCxV3FulfillmentSetParameterAction < 3) {
    unittest.expect(
      o.parameter!,
      unittest.equals('foo'),
    );
    var casted8 = (o.value!) as core.Map;
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
  buildCounterGoogleCloudDialogflowCxV3FulfillmentSetParameterAction--;
}

core.int
    buildCounterGoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata = 0;
api.GoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata
    buildGoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata() {
  var o = api.GoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata();
  buildCounterGoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata <
      3) {
    o.state = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata(
    api.GoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata <
      3) {
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata--;
}

core.int buildCounterGoogleCloudDialogflowCxV3ImportDocumentsOperationMetadata =
    0;
api.GoogleCloudDialogflowCxV3ImportDocumentsOperationMetadata
    buildGoogleCloudDialogflowCxV3ImportDocumentsOperationMetadata() {
  var o = api.GoogleCloudDialogflowCxV3ImportDocumentsOperationMetadata();
  buildCounterGoogleCloudDialogflowCxV3ImportDocumentsOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3ImportDocumentsOperationMetadata <
      3) {
    o.genericMetadata =
        buildGoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata();
  }
  buildCounterGoogleCloudDialogflowCxV3ImportDocumentsOperationMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ImportDocumentsOperationMetadata(
    api.GoogleCloudDialogflowCxV3ImportDocumentsOperationMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3ImportDocumentsOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3ImportDocumentsOperationMetadata <
      3) {
    checkGoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata(
        o.genericMetadata!
            as api.GoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata);
  }
  buildCounterGoogleCloudDialogflowCxV3ImportDocumentsOperationMetadata--;
}

core.List<api.GoogleRpcStatus> buildUnnamed132() {
  var o = <api.GoogleRpcStatus>[];
  o.add(buildGoogleRpcStatus());
  o.add(buildGoogleRpcStatus());
  return o;
}

void checkUnnamed132(core.List<api.GoogleRpcStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleRpcStatus(o[0] as api.GoogleRpcStatus);
  checkGoogleRpcStatus(o[1] as api.GoogleRpcStatus);
}

core.int buildCounterGoogleCloudDialogflowCxV3ImportDocumentsResponse = 0;
api.GoogleCloudDialogflowCxV3ImportDocumentsResponse
    buildGoogleCloudDialogflowCxV3ImportDocumentsResponse() {
  var o = api.GoogleCloudDialogflowCxV3ImportDocumentsResponse();
  buildCounterGoogleCloudDialogflowCxV3ImportDocumentsResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ImportDocumentsResponse < 3) {
    o.warnings = buildUnnamed132();
  }
  buildCounterGoogleCloudDialogflowCxV3ImportDocumentsResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ImportDocumentsResponse(
    api.GoogleCloudDialogflowCxV3ImportDocumentsResponse o) {
  buildCounterGoogleCloudDialogflowCxV3ImportDocumentsResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ImportDocumentsResponse < 3) {
    checkUnnamed132(o.warnings!);
  }
  buildCounterGoogleCloudDialogflowCxV3ImportDocumentsResponse--;
}

core.List<api.GoogleCloudDialogflowCxV3TestCaseError> buildUnnamed133() {
  var o = <api.GoogleCloudDialogflowCxV3TestCaseError>[];
  o.add(buildGoogleCloudDialogflowCxV3TestCaseError());
  o.add(buildGoogleCloudDialogflowCxV3TestCaseError());
  return o;
}

void checkUnnamed133(core.List<api.GoogleCloudDialogflowCxV3TestCaseError> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3TestCaseError(
      o[0] as api.GoogleCloudDialogflowCxV3TestCaseError);
  checkGoogleCloudDialogflowCxV3TestCaseError(
      o[1] as api.GoogleCloudDialogflowCxV3TestCaseError);
}

core.int buildCounterGoogleCloudDialogflowCxV3ImportTestCasesMetadata = 0;
api.GoogleCloudDialogflowCxV3ImportTestCasesMetadata
    buildGoogleCloudDialogflowCxV3ImportTestCasesMetadata() {
  var o = api.GoogleCloudDialogflowCxV3ImportTestCasesMetadata();
  buildCounterGoogleCloudDialogflowCxV3ImportTestCasesMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3ImportTestCasesMetadata < 3) {
    o.errors = buildUnnamed133();
  }
  buildCounterGoogleCloudDialogflowCxV3ImportTestCasesMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ImportTestCasesMetadata(
    api.GoogleCloudDialogflowCxV3ImportTestCasesMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3ImportTestCasesMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3ImportTestCasesMetadata < 3) {
    checkUnnamed133(o.errors!);
  }
  buildCounterGoogleCloudDialogflowCxV3ImportTestCasesMetadata--;
}

core.int buildCounterGoogleCloudDialogflowCxV3ImportTestCasesRequest = 0;
api.GoogleCloudDialogflowCxV3ImportTestCasesRequest
    buildGoogleCloudDialogflowCxV3ImportTestCasesRequest() {
  var o = api.GoogleCloudDialogflowCxV3ImportTestCasesRequest();
  buildCounterGoogleCloudDialogflowCxV3ImportTestCasesRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3ImportTestCasesRequest < 3) {
    o.content = 'foo';
    o.gcsUri = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3ImportTestCasesRequest--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ImportTestCasesRequest(
    api.GoogleCloudDialogflowCxV3ImportTestCasesRequest o) {
  buildCounterGoogleCloudDialogflowCxV3ImportTestCasesRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3ImportTestCasesRequest < 3) {
    unittest.expect(
      o.content!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.gcsUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3ImportTestCasesRequest--;
}

core.List<core.String> buildUnnamed134() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed134(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowCxV3ImportTestCasesResponse = 0;
api.GoogleCloudDialogflowCxV3ImportTestCasesResponse
    buildGoogleCloudDialogflowCxV3ImportTestCasesResponse() {
  var o = api.GoogleCloudDialogflowCxV3ImportTestCasesResponse();
  buildCounterGoogleCloudDialogflowCxV3ImportTestCasesResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ImportTestCasesResponse < 3) {
    o.names = buildUnnamed134();
  }
  buildCounterGoogleCloudDialogflowCxV3ImportTestCasesResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ImportTestCasesResponse(
    api.GoogleCloudDialogflowCxV3ImportTestCasesResponse o) {
  buildCounterGoogleCloudDialogflowCxV3ImportTestCasesResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ImportTestCasesResponse < 3) {
    checkUnnamed134(o.names!);
  }
  buildCounterGoogleCloudDialogflowCxV3ImportTestCasesResponse--;
}

core.List<core.String> buildUnnamed135() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed135(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowCxV3InputAudioConfig = 0;
api.GoogleCloudDialogflowCxV3InputAudioConfig
    buildGoogleCloudDialogflowCxV3InputAudioConfig() {
  var o = api.GoogleCloudDialogflowCxV3InputAudioConfig();
  buildCounterGoogleCloudDialogflowCxV3InputAudioConfig++;
  if (buildCounterGoogleCloudDialogflowCxV3InputAudioConfig < 3) {
    o.audioEncoding = 'foo';
    o.enableWordInfo = true;
    o.model = 'foo';
    o.modelVariant = 'foo';
    o.phraseHints = buildUnnamed135();
    o.sampleRateHertz = 42;
    o.singleUtterance = true;
  }
  buildCounterGoogleCloudDialogflowCxV3InputAudioConfig--;
  return o;
}

void checkGoogleCloudDialogflowCxV3InputAudioConfig(
    api.GoogleCloudDialogflowCxV3InputAudioConfig o) {
  buildCounterGoogleCloudDialogflowCxV3InputAudioConfig++;
  if (buildCounterGoogleCloudDialogflowCxV3InputAudioConfig < 3) {
    unittest.expect(
      o.audioEncoding!,
      unittest.equals('foo'),
    );
    unittest.expect(o.enableWordInfo!, unittest.isTrue);
    unittest.expect(
      o.model!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.modelVariant!,
      unittest.equals('foo'),
    );
    checkUnnamed135(o.phraseHints!);
    unittest.expect(
      o.sampleRateHertz!,
      unittest.equals(42),
    );
    unittest.expect(o.singleUtterance!, unittest.isTrue);
  }
  buildCounterGoogleCloudDialogflowCxV3InputAudioConfig--;
}

core.Map<core.String, core.String> buildUnnamed136() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed136(core.Map<core.String, core.String> o) {
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

core.List<api.GoogleCloudDialogflowCxV3IntentParameter> buildUnnamed137() {
  var o = <api.GoogleCloudDialogflowCxV3IntentParameter>[];
  o.add(buildGoogleCloudDialogflowCxV3IntentParameter());
  o.add(buildGoogleCloudDialogflowCxV3IntentParameter());
  return o;
}

void checkUnnamed137(
    core.List<api.GoogleCloudDialogflowCxV3IntentParameter> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3IntentParameter(
      o[0] as api.GoogleCloudDialogflowCxV3IntentParameter);
  checkGoogleCloudDialogflowCxV3IntentParameter(
      o[1] as api.GoogleCloudDialogflowCxV3IntentParameter);
}

core.List<api.GoogleCloudDialogflowCxV3IntentTrainingPhrase> buildUnnamed138() {
  var o = <api.GoogleCloudDialogflowCxV3IntentTrainingPhrase>[];
  o.add(buildGoogleCloudDialogflowCxV3IntentTrainingPhrase());
  o.add(buildGoogleCloudDialogflowCxV3IntentTrainingPhrase());
  return o;
}

void checkUnnamed138(
    core.List<api.GoogleCloudDialogflowCxV3IntentTrainingPhrase> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3IntentTrainingPhrase(
      o[0] as api.GoogleCloudDialogflowCxV3IntentTrainingPhrase);
  checkGoogleCloudDialogflowCxV3IntentTrainingPhrase(
      o[1] as api.GoogleCloudDialogflowCxV3IntentTrainingPhrase);
}

core.int buildCounterGoogleCloudDialogflowCxV3Intent = 0;
api.GoogleCloudDialogflowCxV3Intent buildGoogleCloudDialogflowCxV3Intent() {
  var o = api.GoogleCloudDialogflowCxV3Intent();
  buildCounterGoogleCloudDialogflowCxV3Intent++;
  if (buildCounterGoogleCloudDialogflowCxV3Intent < 3) {
    o.description = 'foo';
    o.displayName = 'foo';
    o.isFallback = true;
    o.labels = buildUnnamed136();
    o.name = 'foo';
    o.parameters = buildUnnamed137();
    o.priority = 42;
    o.trainingPhrases = buildUnnamed138();
  }
  buildCounterGoogleCloudDialogflowCxV3Intent--;
  return o;
}

void checkGoogleCloudDialogflowCxV3Intent(
    api.GoogleCloudDialogflowCxV3Intent o) {
  buildCounterGoogleCloudDialogflowCxV3Intent++;
  if (buildCounterGoogleCloudDialogflowCxV3Intent < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(o.isFallback!, unittest.isTrue);
    checkUnnamed136(o.labels!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed137(o.parameters!);
    unittest.expect(
      o.priority!,
      unittest.equals(42),
    );
    checkUnnamed138(o.trainingPhrases!);
  }
  buildCounterGoogleCloudDialogflowCxV3Intent--;
}

core.List<api.GoogleCloudDialogflowCxV3IntentCoverageIntent> buildUnnamed139() {
  var o = <api.GoogleCloudDialogflowCxV3IntentCoverageIntent>[];
  o.add(buildGoogleCloudDialogflowCxV3IntentCoverageIntent());
  o.add(buildGoogleCloudDialogflowCxV3IntentCoverageIntent());
  return o;
}

void checkUnnamed139(
    core.List<api.GoogleCloudDialogflowCxV3IntentCoverageIntent> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3IntentCoverageIntent(
      o[0] as api.GoogleCloudDialogflowCxV3IntentCoverageIntent);
  checkGoogleCloudDialogflowCxV3IntentCoverageIntent(
      o[1] as api.GoogleCloudDialogflowCxV3IntentCoverageIntent);
}

core.int buildCounterGoogleCloudDialogflowCxV3IntentCoverage = 0;
api.GoogleCloudDialogflowCxV3IntentCoverage
    buildGoogleCloudDialogflowCxV3IntentCoverage() {
  var o = api.GoogleCloudDialogflowCxV3IntentCoverage();
  buildCounterGoogleCloudDialogflowCxV3IntentCoverage++;
  if (buildCounterGoogleCloudDialogflowCxV3IntentCoverage < 3) {
    o.coverageScore = 42.0;
    o.intents = buildUnnamed139();
  }
  buildCounterGoogleCloudDialogflowCxV3IntentCoverage--;
  return o;
}

void checkGoogleCloudDialogflowCxV3IntentCoverage(
    api.GoogleCloudDialogflowCxV3IntentCoverage o) {
  buildCounterGoogleCloudDialogflowCxV3IntentCoverage++;
  if (buildCounterGoogleCloudDialogflowCxV3IntentCoverage < 3) {
    unittest.expect(
      o.coverageScore!,
      unittest.equals(42.0),
    );
    checkUnnamed139(o.intents!);
  }
  buildCounterGoogleCloudDialogflowCxV3IntentCoverage--;
}

core.int buildCounterGoogleCloudDialogflowCxV3IntentCoverageIntent = 0;
api.GoogleCloudDialogflowCxV3IntentCoverageIntent
    buildGoogleCloudDialogflowCxV3IntentCoverageIntent() {
  var o = api.GoogleCloudDialogflowCxV3IntentCoverageIntent();
  buildCounterGoogleCloudDialogflowCxV3IntentCoverageIntent++;
  if (buildCounterGoogleCloudDialogflowCxV3IntentCoverageIntent < 3) {
    o.covered = true;
    o.intent = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3IntentCoverageIntent--;
  return o;
}

void checkGoogleCloudDialogflowCxV3IntentCoverageIntent(
    api.GoogleCloudDialogflowCxV3IntentCoverageIntent o) {
  buildCounterGoogleCloudDialogflowCxV3IntentCoverageIntent++;
  if (buildCounterGoogleCloudDialogflowCxV3IntentCoverageIntent < 3) {
    unittest.expect(o.covered!, unittest.isTrue);
    unittest.expect(
      o.intent!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3IntentCoverageIntent--;
}

core.int buildCounterGoogleCloudDialogflowCxV3IntentInput = 0;
api.GoogleCloudDialogflowCxV3IntentInput
    buildGoogleCloudDialogflowCxV3IntentInput() {
  var o = api.GoogleCloudDialogflowCxV3IntentInput();
  buildCounterGoogleCloudDialogflowCxV3IntentInput++;
  if (buildCounterGoogleCloudDialogflowCxV3IntentInput < 3) {
    o.intent = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3IntentInput--;
  return o;
}

void checkGoogleCloudDialogflowCxV3IntentInput(
    api.GoogleCloudDialogflowCxV3IntentInput o) {
  buildCounterGoogleCloudDialogflowCxV3IntentInput++;
  if (buildCounterGoogleCloudDialogflowCxV3IntentInput < 3) {
    unittest.expect(
      o.intent!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3IntentInput--;
}

core.int buildCounterGoogleCloudDialogflowCxV3IntentParameter = 0;
api.GoogleCloudDialogflowCxV3IntentParameter
    buildGoogleCloudDialogflowCxV3IntentParameter() {
  var o = api.GoogleCloudDialogflowCxV3IntentParameter();
  buildCounterGoogleCloudDialogflowCxV3IntentParameter++;
  if (buildCounterGoogleCloudDialogflowCxV3IntentParameter < 3) {
    o.entityType = 'foo';
    o.id = 'foo';
    o.isList = true;
    o.redact = true;
  }
  buildCounterGoogleCloudDialogflowCxV3IntentParameter--;
  return o;
}

void checkGoogleCloudDialogflowCxV3IntentParameter(
    api.GoogleCloudDialogflowCxV3IntentParameter o) {
  buildCounterGoogleCloudDialogflowCxV3IntentParameter++;
  if (buildCounterGoogleCloudDialogflowCxV3IntentParameter < 3) {
    unittest.expect(
      o.entityType!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.id!,
      unittest.equals('foo'),
    );
    unittest.expect(o.isList!, unittest.isTrue);
    unittest.expect(o.redact!, unittest.isTrue);
  }
  buildCounterGoogleCloudDialogflowCxV3IntentParameter--;
}

core.List<api.GoogleCloudDialogflowCxV3IntentTrainingPhrasePart>
    buildUnnamed140() {
  var o = <api.GoogleCloudDialogflowCxV3IntentTrainingPhrasePart>[];
  o.add(buildGoogleCloudDialogflowCxV3IntentTrainingPhrasePart());
  o.add(buildGoogleCloudDialogflowCxV3IntentTrainingPhrasePart());
  return o;
}

void checkUnnamed140(
    core.List<api.GoogleCloudDialogflowCxV3IntentTrainingPhrasePart> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3IntentTrainingPhrasePart(
      o[0] as api.GoogleCloudDialogflowCxV3IntentTrainingPhrasePart);
  checkGoogleCloudDialogflowCxV3IntentTrainingPhrasePart(
      o[1] as api.GoogleCloudDialogflowCxV3IntentTrainingPhrasePart);
}

core.int buildCounterGoogleCloudDialogflowCxV3IntentTrainingPhrase = 0;
api.GoogleCloudDialogflowCxV3IntentTrainingPhrase
    buildGoogleCloudDialogflowCxV3IntentTrainingPhrase() {
  var o = api.GoogleCloudDialogflowCxV3IntentTrainingPhrase();
  buildCounterGoogleCloudDialogflowCxV3IntentTrainingPhrase++;
  if (buildCounterGoogleCloudDialogflowCxV3IntentTrainingPhrase < 3) {
    o.id = 'foo';
    o.parts = buildUnnamed140();
    o.repeatCount = 42;
  }
  buildCounterGoogleCloudDialogflowCxV3IntentTrainingPhrase--;
  return o;
}

void checkGoogleCloudDialogflowCxV3IntentTrainingPhrase(
    api.GoogleCloudDialogflowCxV3IntentTrainingPhrase o) {
  buildCounterGoogleCloudDialogflowCxV3IntentTrainingPhrase++;
  if (buildCounterGoogleCloudDialogflowCxV3IntentTrainingPhrase < 3) {
    unittest.expect(
      o.id!,
      unittest.equals('foo'),
    );
    checkUnnamed140(o.parts!);
    unittest.expect(
      o.repeatCount!,
      unittest.equals(42),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3IntentTrainingPhrase--;
}

core.int buildCounterGoogleCloudDialogflowCxV3IntentTrainingPhrasePart = 0;
api.GoogleCloudDialogflowCxV3IntentTrainingPhrasePart
    buildGoogleCloudDialogflowCxV3IntentTrainingPhrasePart() {
  var o = api.GoogleCloudDialogflowCxV3IntentTrainingPhrasePart();
  buildCounterGoogleCloudDialogflowCxV3IntentTrainingPhrasePart++;
  if (buildCounterGoogleCloudDialogflowCxV3IntentTrainingPhrasePart < 3) {
    o.parameterId = 'foo';
    o.text = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3IntentTrainingPhrasePart--;
  return o;
}

void checkGoogleCloudDialogflowCxV3IntentTrainingPhrasePart(
    api.GoogleCloudDialogflowCxV3IntentTrainingPhrasePart o) {
  buildCounterGoogleCloudDialogflowCxV3IntentTrainingPhrasePart++;
  if (buildCounterGoogleCloudDialogflowCxV3IntentTrainingPhrasePart < 3) {
    unittest.expect(
      o.parameterId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3IntentTrainingPhrasePart--;
}

core.List<api.GoogleCloudDialogflowCxV3Agent> buildUnnamed141() {
  var o = <api.GoogleCloudDialogflowCxV3Agent>[];
  o.add(buildGoogleCloudDialogflowCxV3Agent());
  o.add(buildGoogleCloudDialogflowCxV3Agent());
  return o;
}

void checkUnnamed141(core.List<api.GoogleCloudDialogflowCxV3Agent> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3Agent(
      o[0] as api.GoogleCloudDialogflowCxV3Agent);
  checkGoogleCloudDialogflowCxV3Agent(
      o[1] as api.GoogleCloudDialogflowCxV3Agent);
}

core.int buildCounterGoogleCloudDialogflowCxV3ListAgentsResponse = 0;
api.GoogleCloudDialogflowCxV3ListAgentsResponse
    buildGoogleCloudDialogflowCxV3ListAgentsResponse() {
  var o = api.GoogleCloudDialogflowCxV3ListAgentsResponse();
  buildCounterGoogleCloudDialogflowCxV3ListAgentsResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListAgentsResponse < 3) {
    o.agents = buildUnnamed141();
    o.nextPageToken = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3ListAgentsResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ListAgentsResponse(
    api.GoogleCloudDialogflowCxV3ListAgentsResponse o) {
  buildCounterGoogleCloudDialogflowCxV3ListAgentsResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListAgentsResponse < 3) {
    checkUnnamed141(o.agents!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3ListAgentsResponse--;
}

core.List<api.GoogleCloudDialogflowCxV3EntityType> buildUnnamed142() {
  var o = <api.GoogleCloudDialogflowCxV3EntityType>[];
  o.add(buildGoogleCloudDialogflowCxV3EntityType());
  o.add(buildGoogleCloudDialogflowCxV3EntityType());
  return o;
}

void checkUnnamed142(core.List<api.GoogleCloudDialogflowCxV3EntityType> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3EntityType(
      o[0] as api.GoogleCloudDialogflowCxV3EntityType);
  checkGoogleCloudDialogflowCxV3EntityType(
      o[1] as api.GoogleCloudDialogflowCxV3EntityType);
}

core.int buildCounterGoogleCloudDialogflowCxV3ListEntityTypesResponse = 0;
api.GoogleCloudDialogflowCxV3ListEntityTypesResponse
    buildGoogleCloudDialogflowCxV3ListEntityTypesResponse() {
  var o = api.GoogleCloudDialogflowCxV3ListEntityTypesResponse();
  buildCounterGoogleCloudDialogflowCxV3ListEntityTypesResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListEntityTypesResponse < 3) {
    o.entityTypes = buildUnnamed142();
    o.nextPageToken = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3ListEntityTypesResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ListEntityTypesResponse(
    api.GoogleCloudDialogflowCxV3ListEntityTypesResponse o) {
  buildCounterGoogleCloudDialogflowCxV3ListEntityTypesResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListEntityTypesResponse < 3) {
    checkUnnamed142(o.entityTypes!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3ListEntityTypesResponse--;
}

core.List<api.GoogleCloudDialogflowCxV3Environment> buildUnnamed143() {
  var o = <api.GoogleCloudDialogflowCxV3Environment>[];
  o.add(buildGoogleCloudDialogflowCxV3Environment());
  o.add(buildGoogleCloudDialogflowCxV3Environment());
  return o;
}

void checkUnnamed143(core.List<api.GoogleCloudDialogflowCxV3Environment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3Environment(
      o[0] as api.GoogleCloudDialogflowCxV3Environment);
  checkGoogleCloudDialogflowCxV3Environment(
      o[1] as api.GoogleCloudDialogflowCxV3Environment);
}

core.int buildCounterGoogleCloudDialogflowCxV3ListEnvironmentsResponse = 0;
api.GoogleCloudDialogflowCxV3ListEnvironmentsResponse
    buildGoogleCloudDialogflowCxV3ListEnvironmentsResponse() {
  var o = api.GoogleCloudDialogflowCxV3ListEnvironmentsResponse();
  buildCounterGoogleCloudDialogflowCxV3ListEnvironmentsResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListEnvironmentsResponse < 3) {
    o.environments = buildUnnamed143();
    o.nextPageToken = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3ListEnvironmentsResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ListEnvironmentsResponse(
    api.GoogleCloudDialogflowCxV3ListEnvironmentsResponse o) {
  buildCounterGoogleCloudDialogflowCxV3ListEnvironmentsResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListEnvironmentsResponse < 3) {
    checkUnnamed143(o.environments!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3ListEnvironmentsResponse--;
}

core.List<api.GoogleCloudDialogflowCxV3Experiment> buildUnnamed144() {
  var o = <api.GoogleCloudDialogflowCxV3Experiment>[];
  o.add(buildGoogleCloudDialogflowCxV3Experiment());
  o.add(buildGoogleCloudDialogflowCxV3Experiment());
  return o;
}

void checkUnnamed144(core.List<api.GoogleCloudDialogflowCxV3Experiment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3Experiment(
      o[0] as api.GoogleCloudDialogflowCxV3Experiment);
  checkGoogleCloudDialogflowCxV3Experiment(
      o[1] as api.GoogleCloudDialogflowCxV3Experiment);
}

core.int buildCounterGoogleCloudDialogflowCxV3ListExperimentsResponse = 0;
api.GoogleCloudDialogflowCxV3ListExperimentsResponse
    buildGoogleCloudDialogflowCxV3ListExperimentsResponse() {
  var o = api.GoogleCloudDialogflowCxV3ListExperimentsResponse();
  buildCounterGoogleCloudDialogflowCxV3ListExperimentsResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListExperimentsResponse < 3) {
    o.experiments = buildUnnamed144();
    o.nextPageToken = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3ListExperimentsResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ListExperimentsResponse(
    api.GoogleCloudDialogflowCxV3ListExperimentsResponse o) {
  buildCounterGoogleCloudDialogflowCxV3ListExperimentsResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListExperimentsResponse < 3) {
    checkUnnamed144(o.experiments!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3ListExperimentsResponse--;
}

core.List<api.GoogleCloudDialogflowCxV3Flow> buildUnnamed145() {
  var o = <api.GoogleCloudDialogflowCxV3Flow>[];
  o.add(buildGoogleCloudDialogflowCxV3Flow());
  o.add(buildGoogleCloudDialogflowCxV3Flow());
  return o;
}

void checkUnnamed145(core.List<api.GoogleCloudDialogflowCxV3Flow> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3Flow(o[0] as api.GoogleCloudDialogflowCxV3Flow);
  checkGoogleCloudDialogflowCxV3Flow(o[1] as api.GoogleCloudDialogflowCxV3Flow);
}

core.int buildCounterGoogleCloudDialogflowCxV3ListFlowsResponse = 0;
api.GoogleCloudDialogflowCxV3ListFlowsResponse
    buildGoogleCloudDialogflowCxV3ListFlowsResponse() {
  var o = api.GoogleCloudDialogflowCxV3ListFlowsResponse();
  buildCounterGoogleCloudDialogflowCxV3ListFlowsResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListFlowsResponse < 3) {
    o.flows = buildUnnamed145();
    o.nextPageToken = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3ListFlowsResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ListFlowsResponse(
    api.GoogleCloudDialogflowCxV3ListFlowsResponse o) {
  buildCounterGoogleCloudDialogflowCxV3ListFlowsResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListFlowsResponse < 3) {
    checkUnnamed145(o.flows!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3ListFlowsResponse--;
}

core.List<api.GoogleCloudDialogflowCxV3Intent> buildUnnamed146() {
  var o = <api.GoogleCloudDialogflowCxV3Intent>[];
  o.add(buildGoogleCloudDialogflowCxV3Intent());
  o.add(buildGoogleCloudDialogflowCxV3Intent());
  return o;
}

void checkUnnamed146(core.List<api.GoogleCloudDialogflowCxV3Intent> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3Intent(
      o[0] as api.GoogleCloudDialogflowCxV3Intent);
  checkGoogleCloudDialogflowCxV3Intent(
      o[1] as api.GoogleCloudDialogflowCxV3Intent);
}

core.int buildCounterGoogleCloudDialogflowCxV3ListIntentsResponse = 0;
api.GoogleCloudDialogflowCxV3ListIntentsResponse
    buildGoogleCloudDialogflowCxV3ListIntentsResponse() {
  var o = api.GoogleCloudDialogflowCxV3ListIntentsResponse();
  buildCounterGoogleCloudDialogflowCxV3ListIntentsResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListIntentsResponse < 3) {
    o.intents = buildUnnamed146();
    o.nextPageToken = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3ListIntentsResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ListIntentsResponse(
    api.GoogleCloudDialogflowCxV3ListIntentsResponse o) {
  buildCounterGoogleCloudDialogflowCxV3ListIntentsResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListIntentsResponse < 3) {
    checkUnnamed146(o.intents!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3ListIntentsResponse--;
}

core.List<api.GoogleCloudDialogflowCxV3Page> buildUnnamed147() {
  var o = <api.GoogleCloudDialogflowCxV3Page>[];
  o.add(buildGoogleCloudDialogflowCxV3Page());
  o.add(buildGoogleCloudDialogflowCxV3Page());
  return o;
}

void checkUnnamed147(core.List<api.GoogleCloudDialogflowCxV3Page> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3Page(o[0] as api.GoogleCloudDialogflowCxV3Page);
  checkGoogleCloudDialogflowCxV3Page(o[1] as api.GoogleCloudDialogflowCxV3Page);
}

core.int buildCounterGoogleCloudDialogflowCxV3ListPagesResponse = 0;
api.GoogleCloudDialogflowCxV3ListPagesResponse
    buildGoogleCloudDialogflowCxV3ListPagesResponse() {
  var o = api.GoogleCloudDialogflowCxV3ListPagesResponse();
  buildCounterGoogleCloudDialogflowCxV3ListPagesResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListPagesResponse < 3) {
    o.nextPageToken = 'foo';
    o.pages = buildUnnamed147();
  }
  buildCounterGoogleCloudDialogflowCxV3ListPagesResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ListPagesResponse(
    api.GoogleCloudDialogflowCxV3ListPagesResponse o) {
  buildCounterGoogleCloudDialogflowCxV3ListPagesResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListPagesResponse < 3) {
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
    checkUnnamed147(o.pages!);
  }
  buildCounterGoogleCloudDialogflowCxV3ListPagesResponse--;
}

core.List<api.GoogleCloudDialogflowCxV3SecuritySettings> buildUnnamed148() {
  var o = <api.GoogleCloudDialogflowCxV3SecuritySettings>[];
  o.add(buildGoogleCloudDialogflowCxV3SecuritySettings());
  o.add(buildGoogleCloudDialogflowCxV3SecuritySettings());
  return o;
}

void checkUnnamed148(
    core.List<api.GoogleCloudDialogflowCxV3SecuritySettings> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3SecuritySettings(
      o[0] as api.GoogleCloudDialogflowCxV3SecuritySettings);
  checkGoogleCloudDialogflowCxV3SecuritySettings(
      o[1] as api.GoogleCloudDialogflowCxV3SecuritySettings);
}

core.int buildCounterGoogleCloudDialogflowCxV3ListSecuritySettingsResponse = 0;
api.GoogleCloudDialogflowCxV3ListSecuritySettingsResponse
    buildGoogleCloudDialogflowCxV3ListSecuritySettingsResponse() {
  var o = api.GoogleCloudDialogflowCxV3ListSecuritySettingsResponse();
  buildCounterGoogleCloudDialogflowCxV3ListSecuritySettingsResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListSecuritySettingsResponse < 3) {
    o.nextPageToken = 'foo';
    o.securitySettings = buildUnnamed148();
  }
  buildCounterGoogleCloudDialogflowCxV3ListSecuritySettingsResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ListSecuritySettingsResponse(
    api.GoogleCloudDialogflowCxV3ListSecuritySettingsResponse o) {
  buildCounterGoogleCloudDialogflowCxV3ListSecuritySettingsResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListSecuritySettingsResponse < 3) {
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
    checkUnnamed148(o.securitySettings!);
  }
  buildCounterGoogleCloudDialogflowCxV3ListSecuritySettingsResponse--;
}

core.List<api.GoogleCloudDialogflowCxV3SessionEntityType> buildUnnamed149() {
  var o = <api.GoogleCloudDialogflowCxV3SessionEntityType>[];
  o.add(buildGoogleCloudDialogflowCxV3SessionEntityType());
  o.add(buildGoogleCloudDialogflowCxV3SessionEntityType());
  return o;
}

void checkUnnamed149(
    core.List<api.GoogleCloudDialogflowCxV3SessionEntityType> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3SessionEntityType(
      o[0] as api.GoogleCloudDialogflowCxV3SessionEntityType);
  checkGoogleCloudDialogflowCxV3SessionEntityType(
      o[1] as api.GoogleCloudDialogflowCxV3SessionEntityType);
}

core.int buildCounterGoogleCloudDialogflowCxV3ListSessionEntityTypesResponse =
    0;
api.GoogleCloudDialogflowCxV3ListSessionEntityTypesResponse
    buildGoogleCloudDialogflowCxV3ListSessionEntityTypesResponse() {
  var o = api.GoogleCloudDialogflowCxV3ListSessionEntityTypesResponse();
  buildCounterGoogleCloudDialogflowCxV3ListSessionEntityTypesResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListSessionEntityTypesResponse < 3) {
    o.nextPageToken = 'foo';
    o.sessionEntityTypes = buildUnnamed149();
  }
  buildCounterGoogleCloudDialogflowCxV3ListSessionEntityTypesResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ListSessionEntityTypesResponse(
    api.GoogleCloudDialogflowCxV3ListSessionEntityTypesResponse o) {
  buildCounterGoogleCloudDialogflowCxV3ListSessionEntityTypesResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListSessionEntityTypesResponse < 3) {
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
    checkUnnamed149(o.sessionEntityTypes!);
  }
  buildCounterGoogleCloudDialogflowCxV3ListSessionEntityTypesResponse--;
}

core.List<api.GoogleCloudDialogflowCxV3TestCaseResult> buildUnnamed150() {
  var o = <api.GoogleCloudDialogflowCxV3TestCaseResult>[];
  o.add(buildGoogleCloudDialogflowCxV3TestCaseResult());
  o.add(buildGoogleCloudDialogflowCxV3TestCaseResult());
  return o;
}

void checkUnnamed150(core.List<api.GoogleCloudDialogflowCxV3TestCaseResult> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3TestCaseResult(
      o[0] as api.GoogleCloudDialogflowCxV3TestCaseResult);
  checkGoogleCloudDialogflowCxV3TestCaseResult(
      o[1] as api.GoogleCloudDialogflowCxV3TestCaseResult);
}

core.int buildCounterGoogleCloudDialogflowCxV3ListTestCaseResultsResponse = 0;
api.GoogleCloudDialogflowCxV3ListTestCaseResultsResponse
    buildGoogleCloudDialogflowCxV3ListTestCaseResultsResponse() {
  var o = api.GoogleCloudDialogflowCxV3ListTestCaseResultsResponse();
  buildCounterGoogleCloudDialogflowCxV3ListTestCaseResultsResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListTestCaseResultsResponse < 3) {
    o.nextPageToken = 'foo';
    o.testCaseResults = buildUnnamed150();
  }
  buildCounterGoogleCloudDialogflowCxV3ListTestCaseResultsResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ListTestCaseResultsResponse(
    api.GoogleCloudDialogflowCxV3ListTestCaseResultsResponse o) {
  buildCounterGoogleCloudDialogflowCxV3ListTestCaseResultsResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListTestCaseResultsResponse < 3) {
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
    checkUnnamed150(o.testCaseResults!);
  }
  buildCounterGoogleCloudDialogflowCxV3ListTestCaseResultsResponse--;
}

core.List<api.GoogleCloudDialogflowCxV3TestCase> buildUnnamed151() {
  var o = <api.GoogleCloudDialogflowCxV3TestCase>[];
  o.add(buildGoogleCloudDialogflowCxV3TestCase());
  o.add(buildGoogleCloudDialogflowCxV3TestCase());
  return o;
}

void checkUnnamed151(core.List<api.GoogleCloudDialogflowCxV3TestCase> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3TestCase(
      o[0] as api.GoogleCloudDialogflowCxV3TestCase);
  checkGoogleCloudDialogflowCxV3TestCase(
      o[1] as api.GoogleCloudDialogflowCxV3TestCase);
}

core.int buildCounterGoogleCloudDialogflowCxV3ListTestCasesResponse = 0;
api.GoogleCloudDialogflowCxV3ListTestCasesResponse
    buildGoogleCloudDialogflowCxV3ListTestCasesResponse() {
  var o = api.GoogleCloudDialogflowCxV3ListTestCasesResponse();
  buildCounterGoogleCloudDialogflowCxV3ListTestCasesResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListTestCasesResponse < 3) {
    o.nextPageToken = 'foo';
    o.testCases = buildUnnamed151();
  }
  buildCounterGoogleCloudDialogflowCxV3ListTestCasesResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ListTestCasesResponse(
    api.GoogleCloudDialogflowCxV3ListTestCasesResponse o) {
  buildCounterGoogleCloudDialogflowCxV3ListTestCasesResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListTestCasesResponse < 3) {
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
    checkUnnamed151(o.testCases!);
  }
  buildCounterGoogleCloudDialogflowCxV3ListTestCasesResponse--;
}

core.List<api.GoogleCloudDialogflowCxV3TransitionRouteGroup> buildUnnamed152() {
  var o = <api.GoogleCloudDialogflowCxV3TransitionRouteGroup>[];
  o.add(buildGoogleCloudDialogflowCxV3TransitionRouteGroup());
  o.add(buildGoogleCloudDialogflowCxV3TransitionRouteGroup());
  return o;
}

void checkUnnamed152(
    core.List<api.GoogleCloudDialogflowCxV3TransitionRouteGroup> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3TransitionRouteGroup(
      o[0] as api.GoogleCloudDialogflowCxV3TransitionRouteGroup);
  checkGoogleCloudDialogflowCxV3TransitionRouteGroup(
      o[1] as api.GoogleCloudDialogflowCxV3TransitionRouteGroup);
}

core.int
    buildCounterGoogleCloudDialogflowCxV3ListTransitionRouteGroupsResponse = 0;
api.GoogleCloudDialogflowCxV3ListTransitionRouteGroupsResponse
    buildGoogleCloudDialogflowCxV3ListTransitionRouteGroupsResponse() {
  var o = api.GoogleCloudDialogflowCxV3ListTransitionRouteGroupsResponse();
  buildCounterGoogleCloudDialogflowCxV3ListTransitionRouteGroupsResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListTransitionRouteGroupsResponse <
      3) {
    o.nextPageToken = 'foo';
    o.transitionRouteGroups = buildUnnamed152();
  }
  buildCounterGoogleCloudDialogflowCxV3ListTransitionRouteGroupsResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ListTransitionRouteGroupsResponse(
    api.GoogleCloudDialogflowCxV3ListTransitionRouteGroupsResponse o) {
  buildCounterGoogleCloudDialogflowCxV3ListTransitionRouteGroupsResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListTransitionRouteGroupsResponse <
      3) {
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
    checkUnnamed152(o.transitionRouteGroups!);
  }
  buildCounterGoogleCloudDialogflowCxV3ListTransitionRouteGroupsResponse--;
}

core.List<api.GoogleCloudDialogflowCxV3Version> buildUnnamed153() {
  var o = <api.GoogleCloudDialogflowCxV3Version>[];
  o.add(buildGoogleCloudDialogflowCxV3Version());
  o.add(buildGoogleCloudDialogflowCxV3Version());
  return o;
}

void checkUnnamed153(core.List<api.GoogleCloudDialogflowCxV3Version> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3Version(
      o[0] as api.GoogleCloudDialogflowCxV3Version);
  checkGoogleCloudDialogflowCxV3Version(
      o[1] as api.GoogleCloudDialogflowCxV3Version);
}

core.int buildCounterGoogleCloudDialogflowCxV3ListVersionsResponse = 0;
api.GoogleCloudDialogflowCxV3ListVersionsResponse
    buildGoogleCloudDialogflowCxV3ListVersionsResponse() {
  var o = api.GoogleCloudDialogflowCxV3ListVersionsResponse();
  buildCounterGoogleCloudDialogflowCxV3ListVersionsResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListVersionsResponse < 3) {
    o.nextPageToken = 'foo';
    o.versions = buildUnnamed153();
  }
  buildCounterGoogleCloudDialogflowCxV3ListVersionsResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ListVersionsResponse(
    api.GoogleCloudDialogflowCxV3ListVersionsResponse o) {
  buildCounterGoogleCloudDialogflowCxV3ListVersionsResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListVersionsResponse < 3) {
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
    checkUnnamed153(o.versions!);
  }
  buildCounterGoogleCloudDialogflowCxV3ListVersionsResponse--;
}

core.List<api.GoogleCloudDialogflowCxV3Webhook> buildUnnamed154() {
  var o = <api.GoogleCloudDialogflowCxV3Webhook>[];
  o.add(buildGoogleCloudDialogflowCxV3Webhook());
  o.add(buildGoogleCloudDialogflowCxV3Webhook());
  return o;
}

void checkUnnamed154(core.List<api.GoogleCloudDialogflowCxV3Webhook> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3Webhook(
      o[0] as api.GoogleCloudDialogflowCxV3Webhook);
  checkGoogleCloudDialogflowCxV3Webhook(
      o[1] as api.GoogleCloudDialogflowCxV3Webhook);
}

core.int buildCounterGoogleCloudDialogflowCxV3ListWebhooksResponse = 0;
api.GoogleCloudDialogflowCxV3ListWebhooksResponse
    buildGoogleCloudDialogflowCxV3ListWebhooksResponse() {
  var o = api.GoogleCloudDialogflowCxV3ListWebhooksResponse();
  buildCounterGoogleCloudDialogflowCxV3ListWebhooksResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListWebhooksResponse < 3) {
    o.nextPageToken = 'foo';
    o.webhooks = buildUnnamed154();
  }
  buildCounterGoogleCloudDialogflowCxV3ListWebhooksResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ListWebhooksResponse(
    api.GoogleCloudDialogflowCxV3ListWebhooksResponse o) {
  buildCounterGoogleCloudDialogflowCxV3ListWebhooksResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ListWebhooksResponse < 3) {
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
    checkUnnamed154(o.webhooks!);
  }
  buildCounterGoogleCloudDialogflowCxV3ListWebhooksResponse--;
}

core.int buildCounterGoogleCloudDialogflowCxV3LoadVersionRequest = 0;
api.GoogleCloudDialogflowCxV3LoadVersionRequest
    buildGoogleCloudDialogflowCxV3LoadVersionRequest() {
  var o = api.GoogleCloudDialogflowCxV3LoadVersionRequest();
  buildCounterGoogleCloudDialogflowCxV3LoadVersionRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3LoadVersionRequest < 3) {
    o.allowOverrideAgentResources = true;
  }
  buildCounterGoogleCloudDialogflowCxV3LoadVersionRequest--;
  return o;
}

void checkGoogleCloudDialogflowCxV3LoadVersionRequest(
    api.GoogleCloudDialogflowCxV3LoadVersionRequest o) {
  buildCounterGoogleCloudDialogflowCxV3LoadVersionRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3LoadVersionRequest < 3) {
    unittest.expect(o.allowOverrideAgentResources!, unittest.isTrue);
  }
  buildCounterGoogleCloudDialogflowCxV3LoadVersionRequest--;
}

core.List<api.GoogleCloudDialogflowCxV3Environment> buildUnnamed155() {
  var o = <api.GoogleCloudDialogflowCxV3Environment>[];
  o.add(buildGoogleCloudDialogflowCxV3Environment());
  o.add(buildGoogleCloudDialogflowCxV3Environment());
  return o;
}

void checkUnnamed155(core.List<api.GoogleCloudDialogflowCxV3Environment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3Environment(
      o[0] as api.GoogleCloudDialogflowCxV3Environment);
  checkGoogleCloudDialogflowCxV3Environment(
      o[1] as api.GoogleCloudDialogflowCxV3Environment);
}

core.int buildCounterGoogleCloudDialogflowCxV3LookupEnvironmentHistoryResponse =
    0;
api.GoogleCloudDialogflowCxV3LookupEnvironmentHistoryResponse
    buildGoogleCloudDialogflowCxV3LookupEnvironmentHistoryResponse() {
  var o = api.GoogleCloudDialogflowCxV3LookupEnvironmentHistoryResponse();
  buildCounterGoogleCloudDialogflowCxV3LookupEnvironmentHistoryResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3LookupEnvironmentHistoryResponse <
      3) {
    o.environments = buildUnnamed155();
    o.nextPageToken = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3LookupEnvironmentHistoryResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3LookupEnvironmentHistoryResponse(
    api.GoogleCloudDialogflowCxV3LookupEnvironmentHistoryResponse o) {
  buildCounterGoogleCloudDialogflowCxV3LookupEnvironmentHistoryResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3LookupEnvironmentHistoryResponse <
      3) {
    checkUnnamed155(o.environments!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3LookupEnvironmentHistoryResponse--;
}

core.Map<core.String, core.Object> buildUnnamed156() {
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

void checkUnnamed156(core.Map<core.String, core.Object> o) {
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

core.int buildCounterGoogleCloudDialogflowCxV3Match = 0;
api.GoogleCloudDialogflowCxV3Match buildGoogleCloudDialogflowCxV3Match() {
  var o = api.GoogleCloudDialogflowCxV3Match();
  buildCounterGoogleCloudDialogflowCxV3Match++;
  if (buildCounterGoogleCloudDialogflowCxV3Match < 3) {
    o.confidence = 42.0;
    o.event = 'foo';
    o.intent = buildGoogleCloudDialogflowCxV3Intent();
    o.matchType = 'foo';
    o.parameters = buildUnnamed156();
    o.resolvedInput = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3Match--;
  return o;
}

void checkGoogleCloudDialogflowCxV3Match(api.GoogleCloudDialogflowCxV3Match o) {
  buildCounterGoogleCloudDialogflowCxV3Match++;
  if (buildCounterGoogleCloudDialogflowCxV3Match < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.event!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3Intent(
        o.intent! as api.GoogleCloudDialogflowCxV3Intent);
    unittest.expect(
      o.matchType!,
      unittest.equals('foo'),
    );
    checkUnnamed156(o.parameters!);
    unittest.expect(
      o.resolvedInput!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3Match--;
}

core.int buildCounterGoogleCloudDialogflowCxV3MatchIntentRequest = 0;
api.GoogleCloudDialogflowCxV3MatchIntentRequest
    buildGoogleCloudDialogflowCxV3MatchIntentRequest() {
  var o = api.GoogleCloudDialogflowCxV3MatchIntentRequest();
  buildCounterGoogleCloudDialogflowCxV3MatchIntentRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3MatchIntentRequest < 3) {
    o.queryInput = buildGoogleCloudDialogflowCxV3QueryInput();
    o.queryParams = buildGoogleCloudDialogflowCxV3QueryParameters();
  }
  buildCounterGoogleCloudDialogflowCxV3MatchIntentRequest--;
  return o;
}

void checkGoogleCloudDialogflowCxV3MatchIntentRequest(
    api.GoogleCloudDialogflowCxV3MatchIntentRequest o) {
  buildCounterGoogleCloudDialogflowCxV3MatchIntentRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3MatchIntentRequest < 3) {
    checkGoogleCloudDialogflowCxV3QueryInput(
        o.queryInput! as api.GoogleCloudDialogflowCxV3QueryInput);
    checkGoogleCloudDialogflowCxV3QueryParameters(
        o.queryParams! as api.GoogleCloudDialogflowCxV3QueryParameters);
  }
  buildCounterGoogleCloudDialogflowCxV3MatchIntentRequest--;
}

core.List<api.GoogleCloudDialogflowCxV3Match> buildUnnamed157() {
  var o = <api.GoogleCloudDialogflowCxV3Match>[];
  o.add(buildGoogleCloudDialogflowCxV3Match());
  o.add(buildGoogleCloudDialogflowCxV3Match());
  return o;
}

void checkUnnamed157(core.List<api.GoogleCloudDialogflowCxV3Match> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3Match(
      o[0] as api.GoogleCloudDialogflowCxV3Match);
  checkGoogleCloudDialogflowCxV3Match(
      o[1] as api.GoogleCloudDialogflowCxV3Match);
}

core.int buildCounterGoogleCloudDialogflowCxV3MatchIntentResponse = 0;
api.GoogleCloudDialogflowCxV3MatchIntentResponse
    buildGoogleCloudDialogflowCxV3MatchIntentResponse() {
  var o = api.GoogleCloudDialogflowCxV3MatchIntentResponse();
  buildCounterGoogleCloudDialogflowCxV3MatchIntentResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3MatchIntentResponse < 3) {
    o.currentPage = buildGoogleCloudDialogflowCxV3Page();
    o.matches = buildUnnamed157();
    o.text = 'foo';
    o.transcript = 'foo';
    o.triggerEvent = 'foo';
    o.triggerIntent = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3MatchIntentResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3MatchIntentResponse(
    api.GoogleCloudDialogflowCxV3MatchIntentResponse o) {
  buildCounterGoogleCloudDialogflowCxV3MatchIntentResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3MatchIntentResponse < 3) {
    checkGoogleCloudDialogflowCxV3Page(
        o.currentPage! as api.GoogleCloudDialogflowCxV3Page);
    checkUnnamed157(o.matches!);
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.transcript!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.triggerEvent!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.triggerIntent!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3MatchIntentResponse--;
}

core.int buildCounterGoogleCloudDialogflowCxV3NluSettings = 0;
api.GoogleCloudDialogflowCxV3NluSettings
    buildGoogleCloudDialogflowCxV3NluSettings() {
  var o = api.GoogleCloudDialogflowCxV3NluSettings();
  buildCounterGoogleCloudDialogflowCxV3NluSettings++;
  if (buildCounterGoogleCloudDialogflowCxV3NluSettings < 3) {
    o.classificationThreshold = 42.0;
    o.modelTrainingMode = 'foo';
    o.modelType = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3NluSettings--;
  return o;
}

void checkGoogleCloudDialogflowCxV3NluSettings(
    api.GoogleCloudDialogflowCxV3NluSettings o) {
  buildCounterGoogleCloudDialogflowCxV3NluSettings++;
  if (buildCounterGoogleCloudDialogflowCxV3NluSettings < 3) {
    unittest.expect(
      o.classificationThreshold!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.modelTrainingMode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.modelType!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3NluSettings--;
}

core.int buildCounterGoogleCloudDialogflowCxV3OutputAudioConfig = 0;
api.GoogleCloudDialogflowCxV3OutputAudioConfig
    buildGoogleCloudDialogflowCxV3OutputAudioConfig() {
  var o = api.GoogleCloudDialogflowCxV3OutputAudioConfig();
  buildCounterGoogleCloudDialogflowCxV3OutputAudioConfig++;
  if (buildCounterGoogleCloudDialogflowCxV3OutputAudioConfig < 3) {
    o.audioEncoding = 'foo';
    o.sampleRateHertz = 42;
    o.synthesizeSpeechConfig =
        buildGoogleCloudDialogflowCxV3SynthesizeSpeechConfig();
  }
  buildCounterGoogleCloudDialogflowCxV3OutputAudioConfig--;
  return o;
}

void checkGoogleCloudDialogflowCxV3OutputAudioConfig(
    api.GoogleCloudDialogflowCxV3OutputAudioConfig o) {
  buildCounterGoogleCloudDialogflowCxV3OutputAudioConfig++;
  if (buildCounterGoogleCloudDialogflowCxV3OutputAudioConfig < 3) {
    unittest.expect(
      o.audioEncoding!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.sampleRateHertz!,
      unittest.equals(42),
    );
    checkGoogleCloudDialogflowCxV3SynthesizeSpeechConfig(
        o.synthesizeSpeechConfig!
            as api.GoogleCloudDialogflowCxV3SynthesizeSpeechConfig);
  }
  buildCounterGoogleCloudDialogflowCxV3OutputAudioConfig--;
}

core.List<api.GoogleCloudDialogflowCxV3EventHandler> buildUnnamed158() {
  var o = <api.GoogleCloudDialogflowCxV3EventHandler>[];
  o.add(buildGoogleCloudDialogflowCxV3EventHandler());
  o.add(buildGoogleCloudDialogflowCxV3EventHandler());
  return o;
}

void checkUnnamed158(core.List<api.GoogleCloudDialogflowCxV3EventHandler> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3EventHandler(
      o[0] as api.GoogleCloudDialogflowCxV3EventHandler);
  checkGoogleCloudDialogflowCxV3EventHandler(
      o[1] as api.GoogleCloudDialogflowCxV3EventHandler);
}

core.List<core.String> buildUnnamed159() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed159(core.List<core.String> o) {
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

core.List<api.GoogleCloudDialogflowCxV3TransitionRoute> buildUnnamed160() {
  var o = <api.GoogleCloudDialogflowCxV3TransitionRoute>[];
  o.add(buildGoogleCloudDialogflowCxV3TransitionRoute());
  o.add(buildGoogleCloudDialogflowCxV3TransitionRoute());
  return o;
}

void checkUnnamed160(
    core.List<api.GoogleCloudDialogflowCxV3TransitionRoute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3TransitionRoute(
      o[0] as api.GoogleCloudDialogflowCxV3TransitionRoute);
  checkGoogleCloudDialogflowCxV3TransitionRoute(
      o[1] as api.GoogleCloudDialogflowCxV3TransitionRoute);
}

core.int buildCounterGoogleCloudDialogflowCxV3Page = 0;
api.GoogleCloudDialogflowCxV3Page buildGoogleCloudDialogflowCxV3Page() {
  var o = api.GoogleCloudDialogflowCxV3Page();
  buildCounterGoogleCloudDialogflowCxV3Page++;
  if (buildCounterGoogleCloudDialogflowCxV3Page < 3) {
    o.displayName = 'foo';
    o.entryFulfillment = buildGoogleCloudDialogflowCxV3Fulfillment();
    o.eventHandlers = buildUnnamed158();
    o.form = buildGoogleCloudDialogflowCxV3Form();
    o.name = 'foo';
    o.transitionRouteGroups = buildUnnamed159();
    o.transitionRoutes = buildUnnamed160();
  }
  buildCounterGoogleCloudDialogflowCxV3Page--;
  return o;
}

void checkGoogleCloudDialogflowCxV3Page(api.GoogleCloudDialogflowCxV3Page o) {
  buildCounterGoogleCloudDialogflowCxV3Page++;
  if (buildCounterGoogleCloudDialogflowCxV3Page < 3) {
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3Fulfillment(
        o.entryFulfillment! as api.GoogleCloudDialogflowCxV3Fulfillment);
    checkUnnamed158(o.eventHandlers!);
    checkGoogleCloudDialogflowCxV3Form(
        o.form! as api.GoogleCloudDialogflowCxV3Form);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed159(o.transitionRouteGroups!);
    checkUnnamed160(o.transitionRoutes!);
  }
  buildCounterGoogleCloudDialogflowCxV3Page--;
}

core.int buildCounterGoogleCloudDialogflowCxV3PageInfo = 0;
api.GoogleCloudDialogflowCxV3PageInfo buildGoogleCloudDialogflowCxV3PageInfo() {
  var o = api.GoogleCloudDialogflowCxV3PageInfo();
  buildCounterGoogleCloudDialogflowCxV3PageInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3PageInfo < 3) {
    o.currentPage = 'foo';
    o.formInfo = buildGoogleCloudDialogflowCxV3PageInfoFormInfo();
  }
  buildCounterGoogleCloudDialogflowCxV3PageInfo--;
  return o;
}

void checkGoogleCloudDialogflowCxV3PageInfo(
    api.GoogleCloudDialogflowCxV3PageInfo o) {
  buildCounterGoogleCloudDialogflowCxV3PageInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3PageInfo < 3) {
    unittest.expect(
      o.currentPage!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3PageInfoFormInfo(
        o.formInfo! as api.GoogleCloudDialogflowCxV3PageInfoFormInfo);
  }
  buildCounterGoogleCloudDialogflowCxV3PageInfo--;
}

core.List<api.GoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo>
    buildUnnamed161() {
  var o = <api.GoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo>[];
  o.add(buildGoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo());
  o.add(buildGoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo());
  return o;
}

void checkUnnamed161(
    core.List<api.GoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo(
      o[0] as api.GoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo);
  checkGoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo(
      o[1] as api.GoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo);
}

core.int buildCounterGoogleCloudDialogflowCxV3PageInfoFormInfo = 0;
api.GoogleCloudDialogflowCxV3PageInfoFormInfo
    buildGoogleCloudDialogflowCxV3PageInfoFormInfo() {
  var o = api.GoogleCloudDialogflowCxV3PageInfoFormInfo();
  buildCounterGoogleCloudDialogflowCxV3PageInfoFormInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3PageInfoFormInfo < 3) {
    o.parameterInfo = buildUnnamed161();
  }
  buildCounterGoogleCloudDialogflowCxV3PageInfoFormInfo--;
  return o;
}

void checkGoogleCloudDialogflowCxV3PageInfoFormInfo(
    api.GoogleCloudDialogflowCxV3PageInfoFormInfo o) {
  buildCounterGoogleCloudDialogflowCxV3PageInfoFormInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3PageInfoFormInfo < 3) {
    checkUnnamed161(o.parameterInfo!);
  }
  buildCounterGoogleCloudDialogflowCxV3PageInfoFormInfo--;
}

core.int buildCounterGoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo = 0;
api.GoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo
    buildGoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo() {
  var o = api.GoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo();
  buildCounterGoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo < 3) {
    o.displayName = 'foo';
    o.justCollected = true;
    o.required = true;
    o.state = 'foo';
    o.value = {
      'list': [1, 2, 3],
      'bool': true,
      'string': 'foo'
    };
  }
  buildCounterGoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo--;
  return o;
}

void checkGoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo(
    api.GoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo o) {
  buildCounterGoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo < 3) {
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(o.justCollected!, unittest.isTrue);
    unittest.expect(o.required!, unittest.isTrue);
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
    var casted11 = (o.value!) as core.Map;
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
  buildCounterGoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo--;
}

core.int buildCounterGoogleCloudDialogflowCxV3QueryInput = 0;
api.GoogleCloudDialogflowCxV3QueryInput
    buildGoogleCloudDialogflowCxV3QueryInput() {
  var o = api.GoogleCloudDialogflowCxV3QueryInput();
  buildCounterGoogleCloudDialogflowCxV3QueryInput++;
  if (buildCounterGoogleCloudDialogflowCxV3QueryInput < 3) {
    o.audio = buildGoogleCloudDialogflowCxV3AudioInput();
    o.dtmf = buildGoogleCloudDialogflowCxV3DtmfInput();
    o.event = buildGoogleCloudDialogflowCxV3EventInput();
    o.intent = buildGoogleCloudDialogflowCxV3IntentInput();
    o.languageCode = 'foo';
    o.text = buildGoogleCloudDialogflowCxV3TextInput();
  }
  buildCounterGoogleCloudDialogflowCxV3QueryInput--;
  return o;
}

void checkGoogleCloudDialogflowCxV3QueryInput(
    api.GoogleCloudDialogflowCxV3QueryInput o) {
  buildCounterGoogleCloudDialogflowCxV3QueryInput++;
  if (buildCounterGoogleCloudDialogflowCxV3QueryInput < 3) {
    checkGoogleCloudDialogflowCxV3AudioInput(
        o.audio! as api.GoogleCloudDialogflowCxV3AudioInput);
    checkGoogleCloudDialogflowCxV3DtmfInput(
        o.dtmf! as api.GoogleCloudDialogflowCxV3DtmfInput);
    checkGoogleCloudDialogflowCxV3EventInput(
        o.event! as api.GoogleCloudDialogflowCxV3EventInput);
    checkGoogleCloudDialogflowCxV3IntentInput(
        o.intent! as api.GoogleCloudDialogflowCxV3IntentInput);
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3TextInput(
        o.text! as api.GoogleCloudDialogflowCxV3TextInput);
  }
  buildCounterGoogleCloudDialogflowCxV3QueryInput--;
}

core.Map<core.String, core.Object> buildUnnamed162() {
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

void checkUnnamed162(core.Map<core.String, core.Object> o) {
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

core.Map<core.String, core.Object> buildUnnamed163() {
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

void checkUnnamed163(core.Map<core.String, core.Object> o) {
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

core.List<api.GoogleCloudDialogflowCxV3SessionEntityType> buildUnnamed164() {
  var o = <api.GoogleCloudDialogflowCxV3SessionEntityType>[];
  o.add(buildGoogleCloudDialogflowCxV3SessionEntityType());
  o.add(buildGoogleCloudDialogflowCxV3SessionEntityType());
  return o;
}

void checkUnnamed164(
    core.List<api.GoogleCloudDialogflowCxV3SessionEntityType> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3SessionEntityType(
      o[0] as api.GoogleCloudDialogflowCxV3SessionEntityType);
  checkGoogleCloudDialogflowCxV3SessionEntityType(
      o[1] as api.GoogleCloudDialogflowCxV3SessionEntityType);
}

core.Map<core.String, core.String> buildUnnamed165() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed165(core.Map<core.String, core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowCxV3QueryParameters = 0;
api.GoogleCloudDialogflowCxV3QueryParameters
    buildGoogleCloudDialogflowCxV3QueryParameters() {
  var o = api.GoogleCloudDialogflowCxV3QueryParameters();
  buildCounterGoogleCloudDialogflowCxV3QueryParameters++;
  if (buildCounterGoogleCloudDialogflowCxV3QueryParameters < 3) {
    o.analyzeQueryTextSentiment = true;
    o.disableWebhook = true;
    o.geoLocation = buildGoogleTypeLatLng();
    o.parameters = buildUnnamed162();
    o.payload = buildUnnamed163();
    o.sessionEntityTypes = buildUnnamed164();
    o.timeZone = 'foo';
    o.webhookHeaders = buildUnnamed165();
  }
  buildCounterGoogleCloudDialogflowCxV3QueryParameters--;
  return o;
}

void checkGoogleCloudDialogflowCxV3QueryParameters(
    api.GoogleCloudDialogflowCxV3QueryParameters o) {
  buildCounterGoogleCloudDialogflowCxV3QueryParameters++;
  if (buildCounterGoogleCloudDialogflowCxV3QueryParameters < 3) {
    unittest.expect(o.analyzeQueryTextSentiment!, unittest.isTrue);
    unittest.expect(o.disableWebhook!, unittest.isTrue);
    checkGoogleTypeLatLng(o.geoLocation! as api.GoogleTypeLatLng);
    checkUnnamed162(o.parameters!);
    checkUnnamed163(o.payload!);
    checkUnnamed164(o.sessionEntityTypes!);
    unittest.expect(
      o.timeZone!,
      unittest.equals('foo'),
    );
    checkUnnamed165(o.webhookHeaders!);
  }
  buildCounterGoogleCloudDialogflowCxV3QueryParameters--;
}

core.Map<core.String, core.Object> buildUnnamed166() {
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

void checkUnnamed166(core.Map<core.String, core.Object> o) {
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

core.Map<core.String, core.Object> buildUnnamed167() {
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

void checkUnnamed167(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted18 = (o['x']!) as core.Map;
  unittest.expect(casted18, unittest.hasLength(3));
  unittest.expect(
    casted18['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted18['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted18['string'],
    unittest.equals('foo'),
  );
  var casted19 = (o['y']!) as core.Map;
  unittest.expect(casted19, unittest.hasLength(3));
  unittest.expect(
    casted19['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted19['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted19['string'],
    unittest.equals('foo'),
  );
}

core.List<api.GoogleCloudDialogflowCxV3ResponseMessage> buildUnnamed168() {
  var o = <api.GoogleCloudDialogflowCxV3ResponseMessage>[];
  o.add(buildGoogleCloudDialogflowCxV3ResponseMessage());
  o.add(buildGoogleCloudDialogflowCxV3ResponseMessage());
  return o;
}

void checkUnnamed168(
    core.List<api.GoogleCloudDialogflowCxV3ResponseMessage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3ResponseMessage(
      o[0] as api.GoogleCloudDialogflowCxV3ResponseMessage);
  checkGoogleCloudDialogflowCxV3ResponseMessage(
      o[1] as api.GoogleCloudDialogflowCxV3ResponseMessage);
}

core.Map<core.String, core.Object> buildUnnamed169() {
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

void checkUnnamed169(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted20 = (o['x']!) as core.Map;
  unittest.expect(casted20, unittest.hasLength(3));
  unittest.expect(
    casted20['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted20['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted20['string'],
    unittest.equals('foo'),
  );
  var casted21 = (o['y']!) as core.Map;
  unittest.expect(casted21, unittest.hasLength(3));
  unittest.expect(
    casted21['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted21['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted21['string'],
    unittest.equals('foo'),
  );
}

core.List<core.Map<core.String, core.Object>> buildUnnamed170() {
  var o = <core.Map<core.String, core.Object>>[];
  o.add(buildUnnamed169());
  o.add(buildUnnamed169());
  return o;
}

void checkUnnamed170(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed169(o[0]);
  checkUnnamed169(o[1]);
}

core.List<api.GoogleRpcStatus> buildUnnamed171() {
  var o = <api.GoogleRpcStatus>[];
  o.add(buildGoogleRpcStatus());
  o.add(buildGoogleRpcStatus());
  return o;
}

void checkUnnamed171(core.List<api.GoogleRpcStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleRpcStatus(o[0] as api.GoogleRpcStatus);
  checkGoogleRpcStatus(o[1] as api.GoogleRpcStatus);
}

core.int buildCounterGoogleCloudDialogflowCxV3QueryResult = 0;
api.GoogleCloudDialogflowCxV3QueryResult
    buildGoogleCloudDialogflowCxV3QueryResult() {
  var o = api.GoogleCloudDialogflowCxV3QueryResult();
  buildCounterGoogleCloudDialogflowCxV3QueryResult++;
  if (buildCounterGoogleCloudDialogflowCxV3QueryResult < 3) {
    o.currentPage = buildGoogleCloudDialogflowCxV3Page();
    o.diagnosticInfo = buildUnnamed166();
    o.intent = buildGoogleCloudDialogflowCxV3Intent();
    o.intentDetectionConfidence = 42.0;
    o.languageCode = 'foo';
    o.match = buildGoogleCloudDialogflowCxV3Match();
    o.parameters = buildUnnamed167();
    o.responseMessages = buildUnnamed168();
    o.sentimentAnalysisResult =
        buildGoogleCloudDialogflowCxV3SentimentAnalysisResult();
    o.text = 'foo';
    o.transcript = 'foo';
    o.triggerEvent = 'foo';
    o.triggerIntent = 'foo';
    o.webhookPayloads = buildUnnamed170();
    o.webhookStatuses = buildUnnamed171();
  }
  buildCounterGoogleCloudDialogflowCxV3QueryResult--;
  return o;
}

void checkGoogleCloudDialogflowCxV3QueryResult(
    api.GoogleCloudDialogflowCxV3QueryResult o) {
  buildCounterGoogleCloudDialogflowCxV3QueryResult++;
  if (buildCounterGoogleCloudDialogflowCxV3QueryResult < 3) {
    checkGoogleCloudDialogflowCxV3Page(
        o.currentPage! as api.GoogleCloudDialogflowCxV3Page);
    checkUnnamed166(o.diagnosticInfo!);
    checkGoogleCloudDialogflowCxV3Intent(
        o.intent! as api.GoogleCloudDialogflowCxV3Intent);
    unittest.expect(
      o.intentDetectionConfidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3Match(
        o.match! as api.GoogleCloudDialogflowCxV3Match);
    checkUnnamed167(o.parameters!);
    checkUnnamed168(o.responseMessages!);
    checkGoogleCloudDialogflowCxV3SentimentAnalysisResult(
        o.sentimentAnalysisResult!
            as api.GoogleCloudDialogflowCxV3SentimentAnalysisResult);
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.transcript!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.triggerEvent!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.triggerIntent!,
      unittest.equals('foo'),
    );
    checkUnnamed170(o.webhookPayloads!);
    checkUnnamed171(o.webhookStatuses!);
  }
  buildCounterGoogleCloudDialogflowCxV3QueryResult--;
}

core.int buildCounterGoogleCloudDialogflowCxV3ReloadDocumentOperationMetadata =
    0;
api.GoogleCloudDialogflowCxV3ReloadDocumentOperationMetadata
    buildGoogleCloudDialogflowCxV3ReloadDocumentOperationMetadata() {
  var o = api.GoogleCloudDialogflowCxV3ReloadDocumentOperationMetadata();
  buildCounterGoogleCloudDialogflowCxV3ReloadDocumentOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3ReloadDocumentOperationMetadata <
      3) {
    o.genericMetadata =
        buildGoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata();
  }
  buildCounterGoogleCloudDialogflowCxV3ReloadDocumentOperationMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ReloadDocumentOperationMetadata(
    api.GoogleCloudDialogflowCxV3ReloadDocumentOperationMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3ReloadDocumentOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3ReloadDocumentOperationMetadata <
      3) {
    checkGoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata(
        o.genericMetadata!
            as api.GoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata);
  }
  buildCounterGoogleCloudDialogflowCxV3ReloadDocumentOperationMetadata--;
}

core.int buildCounterGoogleCloudDialogflowCxV3ResourceName = 0;
api.GoogleCloudDialogflowCxV3ResourceName
    buildGoogleCloudDialogflowCxV3ResourceName() {
  var o = api.GoogleCloudDialogflowCxV3ResourceName();
  buildCounterGoogleCloudDialogflowCxV3ResourceName++;
  if (buildCounterGoogleCloudDialogflowCxV3ResourceName < 3) {
    o.displayName = 'foo';
    o.name = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3ResourceName--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ResourceName(
    api.GoogleCloudDialogflowCxV3ResourceName o) {
  buildCounterGoogleCloudDialogflowCxV3ResourceName++;
  if (buildCounterGoogleCloudDialogflowCxV3ResourceName < 3) {
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3ResourceName--;
}

core.Map<core.String, core.Object> buildUnnamed172() {
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

void checkUnnamed172(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted22 = (o['x']!) as core.Map;
  unittest.expect(casted22, unittest.hasLength(3));
  unittest.expect(
    casted22['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted22['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted22['string'],
    unittest.equals('foo'),
  );
  var casted23 = (o['y']!) as core.Map;
  unittest.expect(casted23, unittest.hasLength(3));
  unittest.expect(
    casted23['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted23['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted23['string'],
    unittest.equals('foo'),
  );
}

core.int buildCounterGoogleCloudDialogflowCxV3ResponseMessage = 0;
api.GoogleCloudDialogflowCxV3ResponseMessage
    buildGoogleCloudDialogflowCxV3ResponseMessage() {
  var o = api.GoogleCloudDialogflowCxV3ResponseMessage();
  buildCounterGoogleCloudDialogflowCxV3ResponseMessage++;
  if (buildCounterGoogleCloudDialogflowCxV3ResponseMessage < 3) {
    o.conversationSuccess =
        buildGoogleCloudDialogflowCxV3ResponseMessageConversationSuccess();
    o.endInteraction =
        buildGoogleCloudDialogflowCxV3ResponseMessageEndInteraction();
    o.liveAgentHandoff =
        buildGoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff();
    o.mixedAudio = buildGoogleCloudDialogflowCxV3ResponseMessageMixedAudio();
    o.outputAudioText =
        buildGoogleCloudDialogflowCxV3ResponseMessageOutputAudioText();
    o.payload = buildUnnamed172();
    o.playAudio = buildGoogleCloudDialogflowCxV3ResponseMessagePlayAudio();
    o.text = buildGoogleCloudDialogflowCxV3ResponseMessageText();
  }
  buildCounterGoogleCloudDialogflowCxV3ResponseMessage--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ResponseMessage(
    api.GoogleCloudDialogflowCxV3ResponseMessage o) {
  buildCounterGoogleCloudDialogflowCxV3ResponseMessage++;
  if (buildCounterGoogleCloudDialogflowCxV3ResponseMessage < 3) {
    checkGoogleCloudDialogflowCxV3ResponseMessageConversationSuccess(
        o.conversationSuccess!
            as api.GoogleCloudDialogflowCxV3ResponseMessageConversationSuccess);
    checkGoogleCloudDialogflowCxV3ResponseMessageEndInteraction(
        o.endInteraction!
            as api.GoogleCloudDialogflowCxV3ResponseMessageEndInteraction);
    checkGoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff(
        o.liveAgentHandoff!
            as api.GoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff);
    checkGoogleCloudDialogflowCxV3ResponseMessageMixedAudio(o.mixedAudio!
        as api.GoogleCloudDialogflowCxV3ResponseMessageMixedAudio);
    checkGoogleCloudDialogflowCxV3ResponseMessageOutputAudioText(
        o.outputAudioText!
            as api.GoogleCloudDialogflowCxV3ResponseMessageOutputAudioText);
    checkUnnamed172(o.payload!);
    checkGoogleCloudDialogflowCxV3ResponseMessagePlayAudio(
        o.playAudio! as api.GoogleCloudDialogflowCxV3ResponseMessagePlayAudio);
    checkGoogleCloudDialogflowCxV3ResponseMessageText(
        o.text! as api.GoogleCloudDialogflowCxV3ResponseMessageText);
  }
  buildCounterGoogleCloudDialogflowCxV3ResponseMessage--;
}

core.Map<core.String, core.Object> buildUnnamed173() {
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

void checkUnnamed173(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted24 = (o['x']!) as core.Map;
  unittest.expect(casted24, unittest.hasLength(3));
  unittest.expect(
    casted24['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted24['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted24['string'],
    unittest.equals('foo'),
  );
  var casted25 = (o['y']!) as core.Map;
  unittest.expect(casted25, unittest.hasLength(3));
  unittest.expect(
    casted25['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted25['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted25['string'],
    unittest.equals('foo'),
  );
}

core.int
    buildCounterGoogleCloudDialogflowCxV3ResponseMessageConversationSuccess = 0;
api.GoogleCloudDialogflowCxV3ResponseMessageConversationSuccess
    buildGoogleCloudDialogflowCxV3ResponseMessageConversationSuccess() {
  var o = api.GoogleCloudDialogflowCxV3ResponseMessageConversationSuccess();
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageConversationSuccess++;
  if (buildCounterGoogleCloudDialogflowCxV3ResponseMessageConversationSuccess <
      3) {
    o.metadata = buildUnnamed173();
  }
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageConversationSuccess--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ResponseMessageConversationSuccess(
    api.GoogleCloudDialogflowCxV3ResponseMessageConversationSuccess o) {
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageConversationSuccess++;
  if (buildCounterGoogleCloudDialogflowCxV3ResponseMessageConversationSuccess <
      3) {
    checkUnnamed173(o.metadata!);
  }
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageConversationSuccess--;
}

core.int buildCounterGoogleCloudDialogflowCxV3ResponseMessageEndInteraction = 0;
api.GoogleCloudDialogflowCxV3ResponseMessageEndInteraction
    buildGoogleCloudDialogflowCxV3ResponseMessageEndInteraction() {
  var o = api.GoogleCloudDialogflowCxV3ResponseMessageEndInteraction();
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageEndInteraction++;
  if (buildCounterGoogleCloudDialogflowCxV3ResponseMessageEndInteraction < 3) {}
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageEndInteraction--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ResponseMessageEndInteraction(
    api.GoogleCloudDialogflowCxV3ResponseMessageEndInteraction o) {
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageEndInteraction++;
  if (buildCounterGoogleCloudDialogflowCxV3ResponseMessageEndInteraction < 3) {}
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageEndInteraction--;
}

core.Map<core.String, core.Object> buildUnnamed174() {
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

void checkUnnamed174(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted26 = (o['x']!) as core.Map;
  unittest.expect(casted26, unittest.hasLength(3));
  unittest.expect(
    casted26['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted26['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted26['string'],
    unittest.equals('foo'),
  );
  var casted27 = (o['y']!) as core.Map;
  unittest.expect(casted27, unittest.hasLength(3));
  unittest.expect(
    casted27['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted27['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted27['string'],
    unittest.equals('foo'),
  );
}

core.int buildCounterGoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff =
    0;
api.GoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff
    buildGoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff() {
  var o = api.GoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff();
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff++;
  if (buildCounterGoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff <
      3) {
    o.metadata = buildUnnamed174();
  }
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff(
    api.GoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff o) {
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff++;
  if (buildCounterGoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff <
      3) {
    checkUnnamed174(o.metadata!);
  }
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff--;
}

core.List<api.GoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment>
    buildUnnamed175() {
  var o = <api.GoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment>[];
  o.add(buildGoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment());
  o.add(buildGoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment());
  return o;
}

void checkUnnamed175(
    core.List<api.GoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment(
      o[0] as api.GoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment);
  checkGoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment(
      o[1] as api.GoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment);
}

core.int buildCounterGoogleCloudDialogflowCxV3ResponseMessageMixedAudio = 0;
api.GoogleCloudDialogflowCxV3ResponseMessageMixedAudio
    buildGoogleCloudDialogflowCxV3ResponseMessageMixedAudio() {
  var o = api.GoogleCloudDialogflowCxV3ResponseMessageMixedAudio();
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageMixedAudio++;
  if (buildCounterGoogleCloudDialogflowCxV3ResponseMessageMixedAudio < 3) {
    o.segments = buildUnnamed175();
  }
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageMixedAudio--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ResponseMessageMixedAudio(
    api.GoogleCloudDialogflowCxV3ResponseMessageMixedAudio o) {
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageMixedAudio++;
  if (buildCounterGoogleCloudDialogflowCxV3ResponseMessageMixedAudio < 3) {
    checkUnnamed175(o.segments!);
  }
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageMixedAudio--;
}

core.int buildCounterGoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment =
    0;
api.GoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment
    buildGoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment() {
  var o = api.GoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment();
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment++;
  if (buildCounterGoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment <
      3) {
    o.allowPlaybackInterruption = true;
    o.audio = 'foo';
    o.uri = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment(
    api.GoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment o) {
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment++;
  if (buildCounterGoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment <
      3) {
    unittest.expect(o.allowPlaybackInterruption!, unittest.isTrue);
    unittest.expect(
      o.audio!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment--;
}

core.int buildCounterGoogleCloudDialogflowCxV3ResponseMessageOutputAudioText =
    0;
api.GoogleCloudDialogflowCxV3ResponseMessageOutputAudioText
    buildGoogleCloudDialogflowCxV3ResponseMessageOutputAudioText() {
  var o = api.GoogleCloudDialogflowCxV3ResponseMessageOutputAudioText();
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageOutputAudioText++;
  if (buildCounterGoogleCloudDialogflowCxV3ResponseMessageOutputAudioText < 3) {
    o.allowPlaybackInterruption = true;
    o.ssml = 'foo';
    o.text = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageOutputAudioText--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ResponseMessageOutputAudioText(
    api.GoogleCloudDialogflowCxV3ResponseMessageOutputAudioText o) {
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageOutputAudioText++;
  if (buildCounterGoogleCloudDialogflowCxV3ResponseMessageOutputAudioText < 3) {
    unittest.expect(o.allowPlaybackInterruption!, unittest.isTrue);
    unittest.expect(
      o.ssml!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageOutputAudioText--;
}

core.int buildCounterGoogleCloudDialogflowCxV3ResponseMessagePlayAudio = 0;
api.GoogleCloudDialogflowCxV3ResponseMessagePlayAudio
    buildGoogleCloudDialogflowCxV3ResponseMessagePlayAudio() {
  var o = api.GoogleCloudDialogflowCxV3ResponseMessagePlayAudio();
  buildCounterGoogleCloudDialogflowCxV3ResponseMessagePlayAudio++;
  if (buildCounterGoogleCloudDialogflowCxV3ResponseMessagePlayAudio < 3) {
    o.allowPlaybackInterruption = true;
    o.audioUri = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3ResponseMessagePlayAudio--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ResponseMessagePlayAudio(
    api.GoogleCloudDialogflowCxV3ResponseMessagePlayAudio o) {
  buildCounterGoogleCloudDialogflowCxV3ResponseMessagePlayAudio++;
  if (buildCounterGoogleCloudDialogflowCxV3ResponseMessagePlayAudio < 3) {
    unittest.expect(o.allowPlaybackInterruption!, unittest.isTrue);
    unittest.expect(
      o.audioUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3ResponseMessagePlayAudio--;
}

core.List<core.String> buildUnnamed176() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed176(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowCxV3ResponseMessageText = 0;
api.GoogleCloudDialogflowCxV3ResponseMessageText
    buildGoogleCloudDialogflowCxV3ResponseMessageText() {
  var o = api.GoogleCloudDialogflowCxV3ResponseMessageText();
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageText++;
  if (buildCounterGoogleCloudDialogflowCxV3ResponseMessageText < 3) {
    o.allowPlaybackInterruption = true;
    o.text = buildUnnamed176();
  }
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageText--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ResponseMessageText(
    api.GoogleCloudDialogflowCxV3ResponseMessageText o) {
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageText++;
  if (buildCounterGoogleCloudDialogflowCxV3ResponseMessageText < 3) {
    unittest.expect(o.allowPlaybackInterruption!, unittest.isTrue);
    checkUnnamed176(o.text!);
  }
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageText--;
}

core.int buildCounterGoogleCloudDialogflowCxV3RestoreAgentRequest = 0;
api.GoogleCloudDialogflowCxV3RestoreAgentRequest
    buildGoogleCloudDialogflowCxV3RestoreAgentRequest() {
  var o = api.GoogleCloudDialogflowCxV3RestoreAgentRequest();
  buildCounterGoogleCloudDialogflowCxV3RestoreAgentRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3RestoreAgentRequest < 3) {
    o.agentContent = 'foo';
    o.agentUri = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3RestoreAgentRequest--;
  return o;
}

void checkGoogleCloudDialogflowCxV3RestoreAgentRequest(
    api.GoogleCloudDialogflowCxV3RestoreAgentRequest o) {
  buildCounterGoogleCloudDialogflowCxV3RestoreAgentRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3RestoreAgentRequest < 3) {
    unittest.expect(
      o.agentContent!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.agentUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3RestoreAgentRequest--;
}

core.int buildCounterGoogleCloudDialogflowCxV3RunTestCaseMetadata = 0;
api.GoogleCloudDialogflowCxV3RunTestCaseMetadata
    buildGoogleCloudDialogflowCxV3RunTestCaseMetadata() {
  var o = api.GoogleCloudDialogflowCxV3RunTestCaseMetadata();
  buildCounterGoogleCloudDialogflowCxV3RunTestCaseMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3RunTestCaseMetadata < 3) {}
  buildCounterGoogleCloudDialogflowCxV3RunTestCaseMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3RunTestCaseMetadata(
    api.GoogleCloudDialogflowCxV3RunTestCaseMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3RunTestCaseMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3RunTestCaseMetadata < 3) {}
  buildCounterGoogleCloudDialogflowCxV3RunTestCaseMetadata--;
}

core.int buildCounterGoogleCloudDialogflowCxV3RunTestCaseRequest = 0;
api.GoogleCloudDialogflowCxV3RunTestCaseRequest
    buildGoogleCloudDialogflowCxV3RunTestCaseRequest() {
  var o = api.GoogleCloudDialogflowCxV3RunTestCaseRequest();
  buildCounterGoogleCloudDialogflowCxV3RunTestCaseRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3RunTestCaseRequest < 3) {
    o.environment = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3RunTestCaseRequest--;
  return o;
}

void checkGoogleCloudDialogflowCxV3RunTestCaseRequest(
    api.GoogleCloudDialogflowCxV3RunTestCaseRequest o) {
  buildCounterGoogleCloudDialogflowCxV3RunTestCaseRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3RunTestCaseRequest < 3) {
    unittest.expect(
      o.environment!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3RunTestCaseRequest--;
}

core.int buildCounterGoogleCloudDialogflowCxV3RunTestCaseResponse = 0;
api.GoogleCloudDialogflowCxV3RunTestCaseResponse
    buildGoogleCloudDialogflowCxV3RunTestCaseResponse() {
  var o = api.GoogleCloudDialogflowCxV3RunTestCaseResponse();
  buildCounterGoogleCloudDialogflowCxV3RunTestCaseResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3RunTestCaseResponse < 3) {
    o.result = buildGoogleCloudDialogflowCxV3TestCaseResult();
  }
  buildCounterGoogleCloudDialogflowCxV3RunTestCaseResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3RunTestCaseResponse(
    api.GoogleCloudDialogflowCxV3RunTestCaseResponse o) {
  buildCounterGoogleCloudDialogflowCxV3RunTestCaseResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3RunTestCaseResponse < 3) {
    checkGoogleCloudDialogflowCxV3TestCaseResult(
        o.result! as api.GoogleCloudDialogflowCxV3TestCaseResult);
  }
  buildCounterGoogleCloudDialogflowCxV3RunTestCaseResponse--;
}

core.List<core.String> buildUnnamed177() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed177(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowCxV3SecuritySettings = 0;
api.GoogleCloudDialogflowCxV3SecuritySettings
    buildGoogleCloudDialogflowCxV3SecuritySettings() {
  var o = api.GoogleCloudDialogflowCxV3SecuritySettings();
  buildCounterGoogleCloudDialogflowCxV3SecuritySettings++;
  if (buildCounterGoogleCloudDialogflowCxV3SecuritySettings < 3) {
    o.displayName = 'foo';
    o.inspectTemplate = 'foo';
    o.name = 'foo';
    o.purgeDataTypes = buildUnnamed177();
    o.redactionScope = 'foo';
    o.redactionStrategy = 'foo';
    o.retentionWindowDays = 42;
  }
  buildCounterGoogleCloudDialogflowCxV3SecuritySettings--;
  return o;
}

void checkGoogleCloudDialogflowCxV3SecuritySettings(
    api.GoogleCloudDialogflowCxV3SecuritySettings o) {
  buildCounterGoogleCloudDialogflowCxV3SecuritySettings++;
  if (buildCounterGoogleCloudDialogflowCxV3SecuritySettings < 3) {
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.inspectTemplate!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed177(o.purgeDataTypes!);
    unittest.expect(
      o.redactionScope!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.redactionStrategy!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.retentionWindowDays!,
      unittest.equals(42),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3SecuritySettings--;
}

core.int buildCounterGoogleCloudDialogflowCxV3SentimentAnalysisResult = 0;
api.GoogleCloudDialogflowCxV3SentimentAnalysisResult
    buildGoogleCloudDialogflowCxV3SentimentAnalysisResult() {
  var o = api.GoogleCloudDialogflowCxV3SentimentAnalysisResult();
  buildCounterGoogleCloudDialogflowCxV3SentimentAnalysisResult++;
  if (buildCounterGoogleCloudDialogflowCxV3SentimentAnalysisResult < 3) {
    o.magnitude = 42.0;
    o.score = 42.0;
  }
  buildCounterGoogleCloudDialogflowCxV3SentimentAnalysisResult--;
  return o;
}

void checkGoogleCloudDialogflowCxV3SentimentAnalysisResult(
    api.GoogleCloudDialogflowCxV3SentimentAnalysisResult o) {
  buildCounterGoogleCloudDialogflowCxV3SentimentAnalysisResult++;
  if (buildCounterGoogleCloudDialogflowCxV3SentimentAnalysisResult < 3) {
    unittest.expect(
      o.magnitude!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3SentimentAnalysisResult--;
}

core.List<api.GoogleCloudDialogflowCxV3EntityTypeEntity> buildUnnamed178() {
  var o = <api.GoogleCloudDialogflowCxV3EntityTypeEntity>[];
  o.add(buildGoogleCloudDialogflowCxV3EntityTypeEntity());
  o.add(buildGoogleCloudDialogflowCxV3EntityTypeEntity());
  return o;
}

void checkUnnamed178(
    core.List<api.GoogleCloudDialogflowCxV3EntityTypeEntity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3EntityTypeEntity(
      o[0] as api.GoogleCloudDialogflowCxV3EntityTypeEntity);
  checkGoogleCloudDialogflowCxV3EntityTypeEntity(
      o[1] as api.GoogleCloudDialogflowCxV3EntityTypeEntity);
}

core.int buildCounterGoogleCloudDialogflowCxV3SessionEntityType = 0;
api.GoogleCloudDialogflowCxV3SessionEntityType
    buildGoogleCloudDialogflowCxV3SessionEntityType() {
  var o = api.GoogleCloudDialogflowCxV3SessionEntityType();
  buildCounterGoogleCloudDialogflowCxV3SessionEntityType++;
  if (buildCounterGoogleCloudDialogflowCxV3SessionEntityType < 3) {
    o.entities = buildUnnamed178();
    o.entityOverrideMode = 'foo';
    o.name = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3SessionEntityType--;
  return o;
}

void checkGoogleCloudDialogflowCxV3SessionEntityType(
    api.GoogleCloudDialogflowCxV3SessionEntityType o) {
  buildCounterGoogleCloudDialogflowCxV3SessionEntityType++;
  if (buildCounterGoogleCloudDialogflowCxV3SessionEntityType < 3) {
    checkUnnamed178(o.entities!);
    unittest.expect(
      o.entityOverrideMode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3SessionEntityType--;
}

core.Map<core.String, core.Object> buildUnnamed179() {
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

void checkUnnamed179(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted28 = (o['x']!) as core.Map;
  unittest.expect(casted28, unittest.hasLength(3));
  unittest.expect(
    casted28['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted28['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted28['string'],
    unittest.equals('foo'),
  );
  var casted29 = (o['y']!) as core.Map;
  unittest.expect(casted29, unittest.hasLength(3));
  unittest.expect(
    casted29['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted29['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted29['string'],
    unittest.equals('foo'),
  );
}

core.int buildCounterGoogleCloudDialogflowCxV3SessionInfo = 0;
api.GoogleCloudDialogflowCxV3SessionInfo
    buildGoogleCloudDialogflowCxV3SessionInfo() {
  var o = api.GoogleCloudDialogflowCxV3SessionInfo();
  buildCounterGoogleCloudDialogflowCxV3SessionInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3SessionInfo < 3) {
    o.parameters = buildUnnamed179();
    o.session = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3SessionInfo--;
  return o;
}

void checkGoogleCloudDialogflowCxV3SessionInfo(
    api.GoogleCloudDialogflowCxV3SessionInfo o) {
  buildCounterGoogleCloudDialogflowCxV3SessionInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3SessionInfo < 3) {
    checkUnnamed179(o.parameters!);
    unittest.expect(
      o.session!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3SessionInfo--;
}

core.int buildCounterGoogleCloudDialogflowCxV3SpeechToTextSettings = 0;
api.GoogleCloudDialogflowCxV3SpeechToTextSettings
    buildGoogleCloudDialogflowCxV3SpeechToTextSettings() {
  var o = api.GoogleCloudDialogflowCxV3SpeechToTextSettings();
  buildCounterGoogleCloudDialogflowCxV3SpeechToTextSettings++;
  if (buildCounterGoogleCloudDialogflowCxV3SpeechToTextSettings < 3) {
    o.enableSpeechAdaptation = true;
  }
  buildCounterGoogleCloudDialogflowCxV3SpeechToTextSettings--;
  return o;
}

void checkGoogleCloudDialogflowCxV3SpeechToTextSettings(
    api.GoogleCloudDialogflowCxV3SpeechToTextSettings o) {
  buildCounterGoogleCloudDialogflowCxV3SpeechToTextSettings++;
  if (buildCounterGoogleCloudDialogflowCxV3SpeechToTextSettings < 3) {
    unittest.expect(o.enableSpeechAdaptation!, unittest.isTrue);
  }
  buildCounterGoogleCloudDialogflowCxV3SpeechToTextSettings--;
}

core.int buildCounterGoogleCloudDialogflowCxV3StartExperimentRequest = 0;
api.GoogleCloudDialogflowCxV3StartExperimentRequest
    buildGoogleCloudDialogflowCxV3StartExperimentRequest() {
  var o = api.GoogleCloudDialogflowCxV3StartExperimentRequest();
  buildCounterGoogleCloudDialogflowCxV3StartExperimentRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3StartExperimentRequest < 3) {}
  buildCounterGoogleCloudDialogflowCxV3StartExperimentRequest--;
  return o;
}

void checkGoogleCloudDialogflowCxV3StartExperimentRequest(
    api.GoogleCloudDialogflowCxV3StartExperimentRequest o) {
  buildCounterGoogleCloudDialogflowCxV3StartExperimentRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3StartExperimentRequest < 3) {}
  buildCounterGoogleCloudDialogflowCxV3StartExperimentRequest--;
}

core.int buildCounterGoogleCloudDialogflowCxV3StopExperimentRequest = 0;
api.GoogleCloudDialogflowCxV3StopExperimentRequest
    buildGoogleCloudDialogflowCxV3StopExperimentRequest() {
  var o = api.GoogleCloudDialogflowCxV3StopExperimentRequest();
  buildCounterGoogleCloudDialogflowCxV3StopExperimentRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3StopExperimentRequest < 3) {}
  buildCounterGoogleCloudDialogflowCxV3StopExperimentRequest--;
  return o;
}

void checkGoogleCloudDialogflowCxV3StopExperimentRequest(
    api.GoogleCloudDialogflowCxV3StopExperimentRequest o) {
  buildCounterGoogleCloudDialogflowCxV3StopExperimentRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3StopExperimentRequest < 3) {}
  buildCounterGoogleCloudDialogflowCxV3StopExperimentRequest--;
}

core.List<core.String> buildUnnamed180() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed180(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowCxV3SynthesizeSpeechConfig = 0;
api.GoogleCloudDialogflowCxV3SynthesizeSpeechConfig
    buildGoogleCloudDialogflowCxV3SynthesizeSpeechConfig() {
  var o = api.GoogleCloudDialogflowCxV3SynthesizeSpeechConfig();
  buildCounterGoogleCloudDialogflowCxV3SynthesizeSpeechConfig++;
  if (buildCounterGoogleCloudDialogflowCxV3SynthesizeSpeechConfig < 3) {
    o.effectsProfileId = buildUnnamed180();
    o.pitch = 42.0;
    o.speakingRate = 42.0;
    o.voice = buildGoogleCloudDialogflowCxV3VoiceSelectionParams();
    o.volumeGainDb = 42.0;
  }
  buildCounterGoogleCloudDialogflowCxV3SynthesizeSpeechConfig--;
  return o;
}

void checkGoogleCloudDialogflowCxV3SynthesizeSpeechConfig(
    api.GoogleCloudDialogflowCxV3SynthesizeSpeechConfig o) {
  buildCounterGoogleCloudDialogflowCxV3SynthesizeSpeechConfig++;
  if (buildCounterGoogleCloudDialogflowCxV3SynthesizeSpeechConfig < 3) {
    checkUnnamed180(o.effectsProfileId!);
    unittest.expect(
      o.pitch!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.speakingRate!,
      unittest.equals(42.0),
    );
    checkGoogleCloudDialogflowCxV3VoiceSelectionParams(
        o.voice! as api.GoogleCloudDialogflowCxV3VoiceSelectionParams);
    unittest.expect(
      o.volumeGainDb!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3SynthesizeSpeechConfig--;
}

core.List<core.String> buildUnnamed181() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed181(core.List<core.String> o) {
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

core.List<api.GoogleCloudDialogflowCxV3ConversationTurn> buildUnnamed182() {
  var o = <api.GoogleCloudDialogflowCxV3ConversationTurn>[];
  o.add(buildGoogleCloudDialogflowCxV3ConversationTurn());
  o.add(buildGoogleCloudDialogflowCxV3ConversationTurn());
  return o;
}

void checkUnnamed182(
    core.List<api.GoogleCloudDialogflowCxV3ConversationTurn> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3ConversationTurn(
      o[0] as api.GoogleCloudDialogflowCxV3ConversationTurn);
  checkGoogleCloudDialogflowCxV3ConversationTurn(
      o[1] as api.GoogleCloudDialogflowCxV3ConversationTurn);
}

core.int buildCounterGoogleCloudDialogflowCxV3TestCase = 0;
api.GoogleCloudDialogflowCxV3TestCase buildGoogleCloudDialogflowCxV3TestCase() {
  var o = api.GoogleCloudDialogflowCxV3TestCase();
  buildCounterGoogleCloudDialogflowCxV3TestCase++;
  if (buildCounterGoogleCloudDialogflowCxV3TestCase < 3) {
    o.creationTime = 'foo';
    o.displayName = 'foo';
    o.lastTestResult = buildGoogleCloudDialogflowCxV3TestCaseResult();
    o.name = 'foo';
    o.notes = 'foo';
    o.tags = buildUnnamed181();
    o.testCaseConversationTurns = buildUnnamed182();
    o.testConfig = buildGoogleCloudDialogflowCxV3TestConfig();
  }
  buildCounterGoogleCloudDialogflowCxV3TestCase--;
  return o;
}

void checkGoogleCloudDialogflowCxV3TestCase(
    api.GoogleCloudDialogflowCxV3TestCase o) {
  buildCounterGoogleCloudDialogflowCxV3TestCase++;
  if (buildCounterGoogleCloudDialogflowCxV3TestCase < 3) {
    unittest.expect(
      o.creationTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3TestCaseResult(
        o.lastTestResult! as api.GoogleCloudDialogflowCxV3TestCaseResult);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.notes!,
      unittest.equals('foo'),
    );
    checkUnnamed181(o.tags!);
    checkUnnamed182(o.testCaseConversationTurns!);
    checkGoogleCloudDialogflowCxV3TestConfig(
        o.testConfig! as api.GoogleCloudDialogflowCxV3TestConfig);
  }
  buildCounterGoogleCloudDialogflowCxV3TestCase--;
}

core.int buildCounterGoogleCloudDialogflowCxV3TestCaseError = 0;
api.GoogleCloudDialogflowCxV3TestCaseError
    buildGoogleCloudDialogflowCxV3TestCaseError() {
  var o = api.GoogleCloudDialogflowCxV3TestCaseError();
  buildCounterGoogleCloudDialogflowCxV3TestCaseError++;
  if (buildCounterGoogleCloudDialogflowCxV3TestCaseError < 3) {
    o.status = buildGoogleRpcStatus();
    o.testCase = buildGoogleCloudDialogflowCxV3TestCase();
  }
  buildCounterGoogleCloudDialogflowCxV3TestCaseError--;
  return o;
}

void checkGoogleCloudDialogflowCxV3TestCaseError(
    api.GoogleCloudDialogflowCxV3TestCaseError o) {
  buildCounterGoogleCloudDialogflowCxV3TestCaseError++;
  if (buildCounterGoogleCloudDialogflowCxV3TestCaseError < 3) {
    checkGoogleRpcStatus(o.status! as api.GoogleRpcStatus);
    checkGoogleCloudDialogflowCxV3TestCase(
        o.testCase! as api.GoogleCloudDialogflowCxV3TestCase);
  }
  buildCounterGoogleCloudDialogflowCxV3TestCaseError--;
}

core.List<api.GoogleCloudDialogflowCxV3ConversationTurn> buildUnnamed183() {
  var o = <api.GoogleCloudDialogflowCxV3ConversationTurn>[];
  o.add(buildGoogleCloudDialogflowCxV3ConversationTurn());
  o.add(buildGoogleCloudDialogflowCxV3ConversationTurn());
  return o;
}

void checkUnnamed183(
    core.List<api.GoogleCloudDialogflowCxV3ConversationTurn> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3ConversationTurn(
      o[0] as api.GoogleCloudDialogflowCxV3ConversationTurn);
  checkGoogleCloudDialogflowCxV3ConversationTurn(
      o[1] as api.GoogleCloudDialogflowCxV3ConversationTurn);
}

core.int buildCounterGoogleCloudDialogflowCxV3TestCaseResult = 0;
api.GoogleCloudDialogflowCxV3TestCaseResult
    buildGoogleCloudDialogflowCxV3TestCaseResult() {
  var o = api.GoogleCloudDialogflowCxV3TestCaseResult();
  buildCounterGoogleCloudDialogflowCxV3TestCaseResult++;
  if (buildCounterGoogleCloudDialogflowCxV3TestCaseResult < 3) {
    o.conversationTurns = buildUnnamed183();
    o.environment = 'foo';
    o.name = 'foo';
    o.testResult = 'foo';
    o.testTime = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3TestCaseResult--;
  return o;
}

void checkGoogleCloudDialogflowCxV3TestCaseResult(
    api.GoogleCloudDialogflowCxV3TestCaseResult o) {
  buildCounterGoogleCloudDialogflowCxV3TestCaseResult++;
  if (buildCounterGoogleCloudDialogflowCxV3TestCaseResult < 3) {
    checkUnnamed183(o.conversationTurns!);
    unittest.expect(
      o.environment!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.testResult!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.testTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3TestCaseResult--;
}

core.List<core.String> buildUnnamed184() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed184(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowCxV3TestConfig = 0;
api.GoogleCloudDialogflowCxV3TestConfig
    buildGoogleCloudDialogflowCxV3TestConfig() {
  var o = api.GoogleCloudDialogflowCxV3TestConfig();
  buildCounterGoogleCloudDialogflowCxV3TestConfig++;
  if (buildCounterGoogleCloudDialogflowCxV3TestConfig < 3) {
    o.flow = 'foo';
    o.trackingParameters = buildUnnamed184();
  }
  buildCounterGoogleCloudDialogflowCxV3TestConfig--;
  return o;
}

void checkGoogleCloudDialogflowCxV3TestConfig(
    api.GoogleCloudDialogflowCxV3TestConfig o) {
  buildCounterGoogleCloudDialogflowCxV3TestConfig++;
  if (buildCounterGoogleCloudDialogflowCxV3TestConfig < 3) {
    unittest.expect(
      o.flow!,
      unittest.equals('foo'),
    );
    checkUnnamed184(o.trackingParameters!);
  }
  buildCounterGoogleCloudDialogflowCxV3TestConfig--;
}

core.int buildCounterGoogleCloudDialogflowCxV3TestError = 0;
api.GoogleCloudDialogflowCxV3TestError
    buildGoogleCloudDialogflowCxV3TestError() {
  var o = api.GoogleCloudDialogflowCxV3TestError();
  buildCounterGoogleCloudDialogflowCxV3TestError++;
  if (buildCounterGoogleCloudDialogflowCxV3TestError < 3) {
    o.status = buildGoogleRpcStatus();
    o.testCase = 'foo';
    o.testTime = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3TestError--;
  return o;
}

void checkGoogleCloudDialogflowCxV3TestError(
    api.GoogleCloudDialogflowCxV3TestError o) {
  buildCounterGoogleCloudDialogflowCxV3TestError++;
  if (buildCounterGoogleCloudDialogflowCxV3TestError < 3) {
    checkGoogleRpcStatus(o.status! as api.GoogleRpcStatus);
    unittest.expect(
      o.testCase!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.testTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3TestError--;
}

core.int buildCounterGoogleCloudDialogflowCxV3TestRunDifference = 0;
api.GoogleCloudDialogflowCxV3TestRunDifference
    buildGoogleCloudDialogflowCxV3TestRunDifference() {
  var o = api.GoogleCloudDialogflowCxV3TestRunDifference();
  buildCounterGoogleCloudDialogflowCxV3TestRunDifference++;
  if (buildCounterGoogleCloudDialogflowCxV3TestRunDifference < 3) {
    o.description = 'foo';
    o.type = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3TestRunDifference--;
  return o;
}

void checkGoogleCloudDialogflowCxV3TestRunDifference(
    api.GoogleCloudDialogflowCxV3TestRunDifference o) {
  buildCounterGoogleCloudDialogflowCxV3TestRunDifference++;
  if (buildCounterGoogleCloudDialogflowCxV3TestRunDifference < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3TestRunDifference--;
}

core.int buildCounterGoogleCloudDialogflowCxV3TextInput = 0;
api.GoogleCloudDialogflowCxV3TextInput
    buildGoogleCloudDialogflowCxV3TextInput() {
  var o = api.GoogleCloudDialogflowCxV3TextInput();
  buildCounterGoogleCloudDialogflowCxV3TextInput++;
  if (buildCounterGoogleCloudDialogflowCxV3TextInput < 3) {
    o.text = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3TextInput--;
  return o;
}

void checkGoogleCloudDialogflowCxV3TextInput(
    api.GoogleCloudDialogflowCxV3TextInput o) {
  buildCounterGoogleCloudDialogflowCxV3TextInput++;
  if (buildCounterGoogleCloudDialogflowCxV3TextInput < 3) {
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3TextInput--;
}

core.int buildCounterGoogleCloudDialogflowCxV3TrainFlowRequest = 0;
api.GoogleCloudDialogflowCxV3TrainFlowRequest
    buildGoogleCloudDialogflowCxV3TrainFlowRequest() {
  var o = api.GoogleCloudDialogflowCxV3TrainFlowRequest();
  buildCounterGoogleCloudDialogflowCxV3TrainFlowRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3TrainFlowRequest < 3) {}
  buildCounterGoogleCloudDialogflowCxV3TrainFlowRequest--;
  return o;
}

void checkGoogleCloudDialogflowCxV3TrainFlowRequest(
    api.GoogleCloudDialogflowCxV3TrainFlowRequest o) {
  buildCounterGoogleCloudDialogflowCxV3TrainFlowRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3TrainFlowRequest < 3) {}
  buildCounterGoogleCloudDialogflowCxV3TrainFlowRequest--;
}

core.List<api.GoogleCloudDialogflowCxV3TransitionCoverageTransition>
    buildUnnamed185() {
  var o = <api.GoogleCloudDialogflowCxV3TransitionCoverageTransition>[];
  o.add(buildGoogleCloudDialogflowCxV3TransitionCoverageTransition());
  o.add(buildGoogleCloudDialogflowCxV3TransitionCoverageTransition());
  return o;
}

void checkUnnamed185(
    core.List<api.GoogleCloudDialogflowCxV3TransitionCoverageTransition> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3TransitionCoverageTransition(
      o[0] as api.GoogleCloudDialogflowCxV3TransitionCoverageTransition);
  checkGoogleCloudDialogflowCxV3TransitionCoverageTransition(
      o[1] as api.GoogleCloudDialogflowCxV3TransitionCoverageTransition);
}

core.int buildCounterGoogleCloudDialogflowCxV3TransitionCoverage = 0;
api.GoogleCloudDialogflowCxV3TransitionCoverage
    buildGoogleCloudDialogflowCxV3TransitionCoverage() {
  var o = api.GoogleCloudDialogflowCxV3TransitionCoverage();
  buildCounterGoogleCloudDialogflowCxV3TransitionCoverage++;
  if (buildCounterGoogleCloudDialogflowCxV3TransitionCoverage < 3) {
    o.coverageScore = 42.0;
    o.transitions = buildUnnamed185();
  }
  buildCounterGoogleCloudDialogflowCxV3TransitionCoverage--;
  return o;
}

void checkGoogleCloudDialogflowCxV3TransitionCoverage(
    api.GoogleCloudDialogflowCxV3TransitionCoverage o) {
  buildCounterGoogleCloudDialogflowCxV3TransitionCoverage++;
  if (buildCounterGoogleCloudDialogflowCxV3TransitionCoverage < 3) {
    unittest.expect(
      o.coverageScore!,
      unittest.equals(42.0),
    );
    checkUnnamed185(o.transitions!);
  }
  buildCounterGoogleCloudDialogflowCxV3TransitionCoverage--;
}

core.int buildCounterGoogleCloudDialogflowCxV3TransitionCoverageTransition = 0;
api.GoogleCloudDialogflowCxV3TransitionCoverageTransition
    buildGoogleCloudDialogflowCxV3TransitionCoverageTransition() {
  var o = api.GoogleCloudDialogflowCxV3TransitionCoverageTransition();
  buildCounterGoogleCloudDialogflowCxV3TransitionCoverageTransition++;
  if (buildCounterGoogleCloudDialogflowCxV3TransitionCoverageTransition < 3) {
    o.covered = true;
    o.eventHandler = buildGoogleCloudDialogflowCxV3EventHandler();
    o.index = 42;
    o.source = buildGoogleCloudDialogflowCxV3TransitionCoverageTransitionNode();
    o.target = buildGoogleCloudDialogflowCxV3TransitionCoverageTransitionNode();
    o.transitionRoute = buildGoogleCloudDialogflowCxV3TransitionRoute();
  }
  buildCounterGoogleCloudDialogflowCxV3TransitionCoverageTransition--;
  return o;
}

void checkGoogleCloudDialogflowCxV3TransitionCoverageTransition(
    api.GoogleCloudDialogflowCxV3TransitionCoverageTransition o) {
  buildCounterGoogleCloudDialogflowCxV3TransitionCoverageTransition++;
  if (buildCounterGoogleCloudDialogflowCxV3TransitionCoverageTransition < 3) {
    unittest.expect(o.covered!, unittest.isTrue);
    checkGoogleCloudDialogflowCxV3EventHandler(
        o.eventHandler! as api.GoogleCloudDialogflowCxV3EventHandler);
    unittest.expect(
      o.index!,
      unittest.equals(42),
    );
    checkGoogleCloudDialogflowCxV3TransitionCoverageTransitionNode(o.source!
        as api.GoogleCloudDialogflowCxV3TransitionCoverageTransitionNode);
    checkGoogleCloudDialogflowCxV3TransitionCoverageTransitionNode(o.target!
        as api.GoogleCloudDialogflowCxV3TransitionCoverageTransitionNode);
    checkGoogleCloudDialogflowCxV3TransitionRoute(
        o.transitionRoute! as api.GoogleCloudDialogflowCxV3TransitionRoute);
  }
  buildCounterGoogleCloudDialogflowCxV3TransitionCoverageTransition--;
}

core.int buildCounterGoogleCloudDialogflowCxV3TransitionCoverageTransitionNode =
    0;
api.GoogleCloudDialogflowCxV3TransitionCoverageTransitionNode
    buildGoogleCloudDialogflowCxV3TransitionCoverageTransitionNode() {
  var o = api.GoogleCloudDialogflowCxV3TransitionCoverageTransitionNode();
  buildCounterGoogleCloudDialogflowCxV3TransitionCoverageTransitionNode++;
  if (buildCounterGoogleCloudDialogflowCxV3TransitionCoverageTransitionNode <
      3) {
    o.flow = buildGoogleCloudDialogflowCxV3Flow();
    o.page = buildGoogleCloudDialogflowCxV3Page();
  }
  buildCounterGoogleCloudDialogflowCxV3TransitionCoverageTransitionNode--;
  return o;
}

void checkGoogleCloudDialogflowCxV3TransitionCoverageTransitionNode(
    api.GoogleCloudDialogflowCxV3TransitionCoverageTransitionNode o) {
  buildCounterGoogleCloudDialogflowCxV3TransitionCoverageTransitionNode++;
  if (buildCounterGoogleCloudDialogflowCxV3TransitionCoverageTransitionNode <
      3) {
    checkGoogleCloudDialogflowCxV3Flow(
        o.flow! as api.GoogleCloudDialogflowCxV3Flow);
    checkGoogleCloudDialogflowCxV3Page(
        o.page! as api.GoogleCloudDialogflowCxV3Page);
  }
  buildCounterGoogleCloudDialogflowCxV3TransitionCoverageTransitionNode--;
}

core.int buildCounterGoogleCloudDialogflowCxV3TransitionRoute = 0;
api.GoogleCloudDialogflowCxV3TransitionRoute
    buildGoogleCloudDialogflowCxV3TransitionRoute() {
  var o = api.GoogleCloudDialogflowCxV3TransitionRoute();
  buildCounterGoogleCloudDialogflowCxV3TransitionRoute++;
  if (buildCounterGoogleCloudDialogflowCxV3TransitionRoute < 3) {
    o.condition = 'foo';
    o.intent = 'foo';
    o.name = 'foo';
    o.targetFlow = 'foo';
    o.targetPage = 'foo';
    o.triggerFulfillment = buildGoogleCloudDialogflowCxV3Fulfillment();
  }
  buildCounterGoogleCloudDialogflowCxV3TransitionRoute--;
  return o;
}

void checkGoogleCloudDialogflowCxV3TransitionRoute(
    api.GoogleCloudDialogflowCxV3TransitionRoute o) {
  buildCounterGoogleCloudDialogflowCxV3TransitionRoute++;
  if (buildCounterGoogleCloudDialogflowCxV3TransitionRoute < 3) {
    unittest.expect(
      o.condition!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.intent!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.targetFlow!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.targetPage!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3Fulfillment(
        o.triggerFulfillment! as api.GoogleCloudDialogflowCxV3Fulfillment);
  }
  buildCounterGoogleCloudDialogflowCxV3TransitionRoute--;
}

core.List<api.GoogleCloudDialogflowCxV3TransitionRoute> buildUnnamed186() {
  var o = <api.GoogleCloudDialogflowCxV3TransitionRoute>[];
  o.add(buildGoogleCloudDialogflowCxV3TransitionRoute());
  o.add(buildGoogleCloudDialogflowCxV3TransitionRoute());
  return o;
}

void checkUnnamed186(
    core.List<api.GoogleCloudDialogflowCxV3TransitionRoute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3TransitionRoute(
      o[0] as api.GoogleCloudDialogflowCxV3TransitionRoute);
  checkGoogleCloudDialogflowCxV3TransitionRoute(
      o[1] as api.GoogleCloudDialogflowCxV3TransitionRoute);
}

core.int buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroup = 0;
api.GoogleCloudDialogflowCxV3TransitionRouteGroup
    buildGoogleCloudDialogflowCxV3TransitionRouteGroup() {
  var o = api.GoogleCloudDialogflowCxV3TransitionRouteGroup();
  buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroup++;
  if (buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroup < 3) {
    o.displayName = 'foo';
    o.name = 'foo';
    o.transitionRoutes = buildUnnamed186();
  }
  buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroup--;
  return o;
}

void checkGoogleCloudDialogflowCxV3TransitionRouteGroup(
    api.GoogleCloudDialogflowCxV3TransitionRouteGroup o) {
  buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroup++;
  if (buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroup < 3) {
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed186(o.transitionRoutes!);
  }
  buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroup--;
}

core.List<api.GoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage>
    buildUnnamed187() {
  var o = <api.GoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage>[];
  o.add(buildGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage());
  o.add(buildGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage());
  return o;
}

void checkUnnamed187(
    core.List<api.GoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage(o[0]
      as api.GoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage);
  checkGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage(o[1]
      as api.GoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage);
}

core.int buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroupCoverage = 0;
api.GoogleCloudDialogflowCxV3TransitionRouteGroupCoverage
    buildGoogleCloudDialogflowCxV3TransitionRouteGroupCoverage() {
  var o = api.GoogleCloudDialogflowCxV3TransitionRouteGroupCoverage();
  buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroupCoverage++;
  if (buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroupCoverage < 3) {
    o.coverageScore = 42.0;
    o.coverages = buildUnnamed187();
  }
  buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroupCoverage--;
  return o;
}

void checkGoogleCloudDialogflowCxV3TransitionRouteGroupCoverage(
    api.GoogleCloudDialogflowCxV3TransitionRouteGroupCoverage o) {
  buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroupCoverage++;
  if (buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroupCoverage < 3) {
    unittest.expect(
      o.coverageScore!,
      unittest.equals(42.0),
    );
    checkUnnamed187(o.coverages!);
  }
  buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroupCoverage--;
}

core.List<
        api.GoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition>
    buildUnnamed188() {
  var o = <
      api.GoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition>[];
  o.add(
      buildGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition());
  o.add(
      buildGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition());
  return o;
}

void checkUnnamed188(
    core.List<
            api.GoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition(
      o[0] as api
          .GoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition);
  checkGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition(
      o[1] as api
          .GoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition);
}

core.int
    buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage =
    0;
api.GoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage
    buildGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage() {
  var o = api.GoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage();
  buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage++;
  if (buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage <
      3) {
    o.coverageScore = 42.0;
    o.routeGroup = buildGoogleCloudDialogflowCxV3TransitionRouteGroup();
    o.transitions = buildUnnamed188();
  }
  buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage--;
  return o;
}

void checkGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage(
    api.GoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage o) {
  buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage++;
  if (buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage <
      3) {
    unittest.expect(
      o.coverageScore!,
      unittest.equals(42.0),
    );
    checkGoogleCloudDialogflowCxV3TransitionRouteGroup(
        o.routeGroup! as api.GoogleCloudDialogflowCxV3TransitionRouteGroup);
    checkUnnamed188(o.transitions!);
  }
  buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage--;
}

core.int
    buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition =
    0;
api.GoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition
    buildGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition() {
  var o = api
      .GoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition();
  buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition++;
  if (buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition <
      3) {
    o.covered = true;
    o.transitionRoute = buildGoogleCloudDialogflowCxV3TransitionRoute();
  }
  buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition--;
  return o;
}

void checkGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition(
    api.GoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition
        o) {
  buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition++;
  if (buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition <
      3) {
    unittest.expect(o.covered!, unittest.isTrue);
    checkGoogleCloudDialogflowCxV3TransitionRoute(
        o.transitionRoute! as api.GoogleCloudDialogflowCxV3TransitionRoute);
  }
  buildCounterGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition--;
}

core.int buildCounterGoogleCloudDialogflowCxV3UpdateDocumentOperationMetadata =
    0;
api.GoogleCloudDialogflowCxV3UpdateDocumentOperationMetadata
    buildGoogleCloudDialogflowCxV3UpdateDocumentOperationMetadata() {
  var o = api.GoogleCloudDialogflowCxV3UpdateDocumentOperationMetadata();
  buildCounterGoogleCloudDialogflowCxV3UpdateDocumentOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3UpdateDocumentOperationMetadata <
      3) {
    o.genericMetadata =
        buildGoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata();
  }
  buildCounterGoogleCloudDialogflowCxV3UpdateDocumentOperationMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3UpdateDocumentOperationMetadata(
    api.GoogleCloudDialogflowCxV3UpdateDocumentOperationMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3UpdateDocumentOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3UpdateDocumentOperationMetadata <
      3) {
    checkGoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata(
        o.genericMetadata!
            as api.GoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata);
  }
  buildCounterGoogleCloudDialogflowCxV3UpdateDocumentOperationMetadata--;
}

core.int buildCounterGoogleCloudDialogflowCxV3ValidateAgentRequest = 0;
api.GoogleCloudDialogflowCxV3ValidateAgentRequest
    buildGoogleCloudDialogflowCxV3ValidateAgentRequest() {
  var o = api.GoogleCloudDialogflowCxV3ValidateAgentRequest();
  buildCounterGoogleCloudDialogflowCxV3ValidateAgentRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3ValidateAgentRequest < 3) {
    o.languageCode = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3ValidateAgentRequest--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ValidateAgentRequest(
    api.GoogleCloudDialogflowCxV3ValidateAgentRequest o) {
  buildCounterGoogleCloudDialogflowCxV3ValidateAgentRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3ValidateAgentRequest < 3) {
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3ValidateAgentRequest--;
}

core.int buildCounterGoogleCloudDialogflowCxV3ValidateFlowRequest = 0;
api.GoogleCloudDialogflowCxV3ValidateFlowRequest
    buildGoogleCloudDialogflowCxV3ValidateFlowRequest() {
  var o = api.GoogleCloudDialogflowCxV3ValidateFlowRequest();
  buildCounterGoogleCloudDialogflowCxV3ValidateFlowRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3ValidateFlowRequest < 3) {
    o.languageCode = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3ValidateFlowRequest--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ValidateFlowRequest(
    api.GoogleCloudDialogflowCxV3ValidateFlowRequest o) {
  buildCounterGoogleCloudDialogflowCxV3ValidateFlowRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3ValidateFlowRequest < 3) {
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3ValidateFlowRequest--;
}

core.List<api.GoogleCloudDialogflowCxV3ResourceName> buildUnnamed189() {
  var o = <api.GoogleCloudDialogflowCxV3ResourceName>[];
  o.add(buildGoogleCloudDialogflowCxV3ResourceName());
  o.add(buildGoogleCloudDialogflowCxV3ResourceName());
  return o;
}

void checkUnnamed189(core.List<api.GoogleCloudDialogflowCxV3ResourceName> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3ResourceName(
      o[0] as api.GoogleCloudDialogflowCxV3ResourceName);
  checkGoogleCloudDialogflowCxV3ResourceName(
      o[1] as api.GoogleCloudDialogflowCxV3ResourceName);
}

core.List<core.String> buildUnnamed190() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed190(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowCxV3ValidationMessage = 0;
api.GoogleCloudDialogflowCxV3ValidationMessage
    buildGoogleCloudDialogflowCxV3ValidationMessage() {
  var o = api.GoogleCloudDialogflowCxV3ValidationMessage();
  buildCounterGoogleCloudDialogflowCxV3ValidationMessage++;
  if (buildCounterGoogleCloudDialogflowCxV3ValidationMessage < 3) {
    o.detail = 'foo';
    o.resourceNames = buildUnnamed189();
    o.resourceType = 'foo';
    o.resources = buildUnnamed190();
    o.severity = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3ValidationMessage--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ValidationMessage(
    api.GoogleCloudDialogflowCxV3ValidationMessage o) {
  buildCounterGoogleCloudDialogflowCxV3ValidationMessage++;
  if (buildCounterGoogleCloudDialogflowCxV3ValidationMessage < 3) {
    unittest.expect(
      o.detail!,
      unittest.equals('foo'),
    );
    checkUnnamed189(o.resourceNames!);
    unittest.expect(
      o.resourceType!,
      unittest.equals('foo'),
    );
    checkUnnamed190(o.resources!);
    unittest.expect(
      o.severity!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3ValidationMessage--;
}

core.int buildCounterGoogleCloudDialogflowCxV3VariantsHistory = 0;
api.GoogleCloudDialogflowCxV3VariantsHistory
    buildGoogleCloudDialogflowCxV3VariantsHistory() {
  var o = api.GoogleCloudDialogflowCxV3VariantsHistory();
  buildCounterGoogleCloudDialogflowCxV3VariantsHistory++;
  if (buildCounterGoogleCloudDialogflowCxV3VariantsHistory < 3) {
    o.updateTime = 'foo';
    o.versionVariants = buildGoogleCloudDialogflowCxV3VersionVariants();
  }
  buildCounterGoogleCloudDialogflowCxV3VariantsHistory--;
  return o;
}

void checkGoogleCloudDialogflowCxV3VariantsHistory(
    api.GoogleCloudDialogflowCxV3VariantsHistory o) {
  buildCounterGoogleCloudDialogflowCxV3VariantsHistory++;
  if (buildCounterGoogleCloudDialogflowCxV3VariantsHistory < 3) {
    unittest.expect(
      o.updateTime!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3VersionVariants(
        o.versionVariants! as api.GoogleCloudDialogflowCxV3VersionVariants);
  }
  buildCounterGoogleCloudDialogflowCxV3VariantsHistory--;
}

core.int buildCounterGoogleCloudDialogflowCxV3Version = 0;
api.GoogleCloudDialogflowCxV3Version buildGoogleCloudDialogflowCxV3Version() {
  var o = api.GoogleCloudDialogflowCxV3Version();
  buildCounterGoogleCloudDialogflowCxV3Version++;
  if (buildCounterGoogleCloudDialogflowCxV3Version < 3) {
    o.createTime = 'foo';
    o.description = 'foo';
    o.displayName = 'foo';
    o.name = 'foo';
    o.nluSettings = buildGoogleCloudDialogflowCxV3NluSettings();
    o.state = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3Version--;
  return o;
}

void checkGoogleCloudDialogflowCxV3Version(
    api.GoogleCloudDialogflowCxV3Version o) {
  buildCounterGoogleCloudDialogflowCxV3Version++;
  if (buildCounterGoogleCloudDialogflowCxV3Version < 3) {
    unittest.expect(
      o.createTime!,
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
      o.name!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3NluSettings(
        o.nluSettings! as api.GoogleCloudDialogflowCxV3NluSettings);
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3Version--;
}

core.List<api.GoogleCloudDialogflowCxV3VersionVariantsVariant>
    buildUnnamed191() {
  var o = <api.GoogleCloudDialogflowCxV3VersionVariantsVariant>[];
  o.add(buildGoogleCloudDialogflowCxV3VersionVariantsVariant());
  o.add(buildGoogleCloudDialogflowCxV3VersionVariantsVariant());
  return o;
}

void checkUnnamed191(
    core.List<api.GoogleCloudDialogflowCxV3VersionVariantsVariant> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3VersionVariantsVariant(
      o[0] as api.GoogleCloudDialogflowCxV3VersionVariantsVariant);
  checkGoogleCloudDialogflowCxV3VersionVariantsVariant(
      o[1] as api.GoogleCloudDialogflowCxV3VersionVariantsVariant);
}

core.int buildCounterGoogleCloudDialogflowCxV3VersionVariants = 0;
api.GoogleCloudDialogflowCxV3VersionVariants
    buildGoogleCloudDialogflowCxV3VersionVariants() {
  var o = api.GoogleCloudDialogflowCxV3VersionVariants();
  buildCounterGoogleCloudDialogflowCxV3VersionVariants++;
  if (buildCounterGoogleCloudDialogflowCxV3VersionVariants < 3) {
    o.variants = buildUnnamed191();
  }
  buildCounterGoogleCloudDialogflowCxV3VersionVariants--;
  return o;
}

void checkGoogleCloudDialogflowCxV3VersionVariants(
    api.GoogleCloudDialogflowCxV3VersionVariants o) {
  buildCounterGoogleCloudDialogflowCxV3VersionVariants++;
  if (buildCounterGoogleCloudDialogflowCxV3VersionVariants < 3) {
    checkUnnamed191(o.variants!);
  }
  buildCounterGoogleCloudDialogflowCxV3VersionVariants--;
}

core.int buildCounterGoogleCloudDialogflowCxV3VersionVariantsVariant = 0;
api.GoogleCloudDialogflowCxV3VersionVariantsVariant
    buildGoogleCloudDialogflowCxV3VersionVariantsVariant() {
  var o = api.GoogleCloudDialogflowCxV3VersionVariantsVariant();
  buildCounterGoogleCloudDialogflowCxV3VersionVariantsVariant++;
  if (buildCounterGoogleCloudDialogflowCxV3VersionVariantsVariant < 3) {
    o.isControlGroup = true;
    o.trafficAllocation = 42.0;
    o.version = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3VersionVariantsVariant--;
  return o;
}

void checkGoogleCloudDialogflowCxV3VersionVariantsVariant(
    api.GoogleCloudDialogflowCxV3VersionVariantsVariant o) {
  buildCounterGoogleCloudDialogflowCxV3VersionVariantsVariant++;
  if (buildCounterGoogleCloudDialogflowCxV3VersionVariantsVariant < 3) {
    unittest.expect(o.isControlGroup!, unittest.isTrue);
    unittest.expect(
      o.trafficAllocation!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3VersionVariantsVariant--;
}

core.int buildCounterGoogleCloudDialogflowCxV3VoiceSelectionParams = 0;
api.GoogleCloudDialogflowCxV3VoiceSelectionParams
    buildGoogleCloudDialogflowCxV3VoiceSelectionParams() {
  var o = api.GoogleCloudDialogflowCxV3VoiceSelectionParams();
  buildCounterGoogleCloudDialogflowCxV3VoiceSelectionParams++;
  if (buildCounterGoogleCloudDialogflowCxV3VoiceSelectionParams < 3) {
    o.name = 'foo';
    o.ssmlGender = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3VoiceSelectionParams--;
  return o;
}

void checkGoogleCloudDialogflowCxV3VoiceSelectionParams(
    api.GoogleCloudDialogflowCxV3VoiceSelectionParams o) {
  buildCounterGoogleCloudDialogflowCxV3VoiceSelectionParams++;
  if (buildCounterGoogleCloudDialogflowCxV3VoiceSelectionParams < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.ssmlGender!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3VoiceSelectionParams--;
}

core.int buildCounterGoogleCloudDialogflowCxV3Webhook = 0;
api.GoogleCloudDialogflowCxV3Webhook buildGoogleCloudDialogflowCxV3Webhook() {
  var o = api.GoogleCloudDialogflowCxV3Webhook();
  buildCounterGoogleCloudDialogflowCxV3Webhook++;
  if (buildCounterGoogleCloudDialogflowCxV3Webhook < 3) {
    o.disabled = true;
    o.displayName = 'foo';
    o.genericWebService =
        buildGoogleCloudDialogflowCxV3WebhookGenericWebService();
    o.name = 'foo';
    o.timeout = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3Webhook--;
  return o;
}

void checkGoogleCloudDialogflowCxV3Webhook(
    api.GoogleCloudDialogflowCxV3Webhook o) {
  buildCounterGoogleCloudDialogflowCxV3Webhook++;
  if (buildCounterGoogleCloudDialogflowCxV3Webhook < 3) {
    unittest.expect(o.disabled!, unittest.isTrue);
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3WebhookGenericWebService(o.genericWebService!
        as api.GoogleCloudDialogflowCxV3WebhookGenericWebService);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.timeout!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3Webhook--;
}

core.Map<core.String, core.String> buildUnnamed192() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed192(core.Map<core.String, core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowCxV3WebhookGenericWebService = 0;
api.GoogleCloudDialogflowCxV3WebhookGenericWebService
    buildGoogleCloudDialogflowCxV3WebhookGenericWebService() {
  var o = api.GoogleCloudDialogflowCxV3WebhookGenericWebService();
  buildCounterGoogleCloudDialogflowCxV3WebhookGenericWebService++;
  if (buildCounterGoogleCloudDialogflowCxV3WebhookGenericWebService < 3) {
    o.password = 'foo';
    o.requestHeaders = buildUnnamed192();
    o.uri = 'foo';
    o.username = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3WebhookGenericWebService--;
  return o;
}

void checkGoogleCloudDialogflowCxV3WebhookGenericWebService(
    api.GoogleCloudDialogflowCxV3WebhookGenericWebService o) {
  buildCounterGoogleCloudDialogflowCxV3WebhookGenericWebService++;
  if (buildCounterGoogleCloudDialogflowCxV3WebhookGenericWebService < 3) {
    unittest.expect(
      o.password!,
      unittest.equals('foo'),
    );
    checkUnnamed192(o.requestHeaders!);
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.username!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3WebhookGenericWebService--;
}

core.List<api.GoogleCloudDialogflowCxV3ResponseMessage> buildUnnamed193() {
  var o = <api.GoogleCloudDialogflowCxV3ResponseMessage>[];
  o.add(buildGoogleCloudDialogflowCxV3ResponseMessage());
  o.add(buildGoogleCloudDialogflowCxV3ResponseMessage());
  return o;
}

void checkUnnamed193(
    core.List<api.GoogleCloudDialogflowCxV3ResponseMessage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3ResponseMessage(
      o[0] as api.GoogleCloudDialogflowCxV3ResponseMessage);
  checkGoogleCloudDialogflowCxV3ResponseMessage(
      o[1] as api.GoogleCloudDialogflowCxV3ResponseMessage);
}

core.Map<core.String, core.Object> buildUnnamed194() {
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

void checkUnnamed194(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted30 = (o['x']!) as core.Map;
  unittest.expect(casted30, unittest.hasLength(3));
  unittest.expect(
    casted30['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted30['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted30['string'],
    unittest.equals('foo'),
  );
  var casted31 = (o['y']!) as core.Map;
  unittest.expect(casted31, unittest.hasLength(3));
  unittest.expect(
    casted31['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted31['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted31['string'],
    unittest.equals('foo'),
  );
}

core.int buildCounterGoogleCloudDialogflowCxV3WebhookRequest = 0;
api.GoogleCloudDialogflowCxV3WebhookRequest
    buildGoogleCloudDialogflowCxV3WebhookRequest() {
  var o = api.GoogleCloudDialogflowCxV3WebhookRequest();
  buildCounterGoogleCloudDialogflowCxV3WebhookRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3WebhookRequest < 3) {
    o.detectIntentResponseId = 'foo';
    o.fulfillmentInfo =
        buildGoogleCloudDialogflowCxV3WebhookRequestFulfillmentInfo();
    o.intentInfo = buildGoogleCloudDialogflowCxV3WebhookRequestIntentInfo();
    o.messages = buildUnnamed193();
    o.pageInfo = buildGoogleCloudDialogflowCxV3PageInfo();
    o.payload = buildUnnamed194();
    o.sentimentAnalysisResult =
        buildGoogleCloudDialogflowCxV3WebhookRequestSentimentAnalysisResult();
    o.sessionInfo = buildGoogleCloudDialogflowCxV3SessionInfo();
  }
  buildCounterGoogleCloudDialogflowCxV3WebhookRequest--;
  return o;
}

void checkGoogleCloudDialogflowCxV3WebhookRequest(
    api.GoogleCloudDialogflowCxV3WebhookRequest o) {
  buildCounterGoogleCloudDialogflowCxV3WebhookRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3WebhookRequest < 3) {
    unittest.expect(
      o.detectIntentResponseId!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3WebhookRequestFulfillmentInfo(
        o.fulfillmentInfo!
            as api.GoogleCloudDialogflowCxV3WebhookRequestFulfillmentInfo);
    checkGoogleCloudDialogflowCxV3WebhookRequestIntentInfo(
        o.intentInfo! as api.GoogleCloudDialogflowCxV3WebhookRequestIntentInfo);
    checkUnnamed193(o.messages!);
    checkGoogleCloudDialogflowCxV3PageInfo(
        o.pageInfo! as api.GoogleCloudDialogflowCxV3PageInfo);
    checkUnnamed194(o.payload!);
    checkGoogleCloudDialogflowCxV3WebhookRequestSentimentAnalysisResult(o
            .sentimentAnalysisResult!
        as api.GoogleCloudDialogflowCxV3WebhookRequestSentimentAnalysisResult);
    checkGoogleCloudDialogflowCxV3SessionInfo(
        o.sessionInfo! as api.GoogleCloudDialogflowCxV3SessionInfo);
  }
  buildCounterGoogleCloudDialogflowCxV3WebhookRequest--;
}

core.int buildCounterGoogleCloudDialogflowCxV3WebhookRequestFulfillmentInfo = 0;
api.GoogleCloudDialogflowCxV3WebhookRequestFulfillmentInfo
    buildGoogleCloudDialogflowCxV3WebhookRequestFulfillmentInfo() {
  var o = api.GoogleCloudDialogflowCxV3WebhookRequestFulfillmentInfo();
  buildCounterGoogleCloudDialogflowCxV3WebhookRequestFulfillmentInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3WebhookRequestFulfillmentInfo < 3) {
    o.tag = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3WebhookRequestFulfillmentInfo--;
  return o;
}

void checkGoogleCloudDialogflowCxV3WebhookRequestFulfillmentInfo(
    api.GoogleCloudDialogflowCxV3WebhookRequestFulfillmentInfo o) {
  buildCounterGoogleCloudDialogflowCxV3WebhookRequestFulfillmentInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3WebhookRequestFulfillmentInfo < 3) {
    unittest.expect(
      o.tag!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3WebhookRequestFulfillmentInfo--;
}

core.Map<core.String,
        api.GoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue>
    buildUnnamed195() {
  var o = <core.String,
      api.GoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue>{};
  o['x'] =
      buildGoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue();
  o['y'] =
      buildGoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue();
  return o;
}

void checkUnnamed195(
    core.Map<core.String,
            api.GoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue(
      o['x']! as api
          .GoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue);
  checkGoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue(
      o['y']! as api
          .GoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue);
}

core.int buildCounterGoogleCloudDialogflowCxV3WebhookRequestIntentInfo = 0;
api.GoogleCloudDialogflowCxV3WebhookRequestIntentInfo
    buildGoogleCloudDialogflowCxV3WebhookRequestIntentInfo() {
  var o = api.GoogleCloudDialogflowCxV3WebhookRequestIntentInfo();
  buildCounterGoogleCloudDialogflowCxV3WebhookRequestIntentInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3WebhookRequestIntentInfo < 3) {
    o.confidence = 42.0;
    o.displayName = 'foo';
    o.lastMatchedIntent = 'foo';
    o.parameters = buildUnnamed195();
  }
  buildCounterGoogleCloudDialogflowCxV3WebhookRequestIntentInfo--;
  return o;
}

void checkGoogleCloudDialogflowCxV3WebhookRequestIntentInfo(
    api.GoogleCloudDialogflowCxV3WebhookRequestIntentInfo o) {
  buildCounterGoogleCloudDialogflowCxV3WebhookRequestIntentInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3WebhookRequestIntentInfo < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.lastMatchedIntent!,
      unittest.equals('foo'),
    );
    checkUnnamed195(o.parameters!);
  }
  buildCounterGoogleCloudDialogflowCxV3WebhookRequestIntentInfo--;
}

core.int
    buildCounterGoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue =
    0;
api.GoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue
    buildGoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue() {
  var o = api
      .GoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue();
  buildCounterGoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue++;
  if (buildCounterGoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue <
      3) {
    o.originalValue = 'foo';
    o.resolvedValue = {
      'list': [1, 2, 3],
      'bool': true,
      'string': 'foo'
    };
  }
  buildCounterGoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue--;
  return o;
}

void checkGoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue(
    api.GoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue
        o) {
  buildCounterGoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue++;
  if (buildCounterGoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue <
      3) {
    unittest.expect(
      o.originalValue!,
      unittest.equals('foo'),
    );
    var casted32 = (o.resolvedValue!) as core.Map;
    unittest.expect(casted32, unittest.hasLength(3));
    unittest.expect(
      casted32['list'],
      unittest.equals([1, 2, 3]),
    );
    unittest.expect(
      casted32['bool'],
      unittest.equals(true),
    );
    unittest.expect(
      casted32['string'],
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue--;
}

core.int
    buildCounterGoogleCloudDialogflowCxV3WebhookRequestSentimentAnalysisResult =
    0;
api.GoogleCloudDialogflowCxV3WebhookRequestSentimentAnalysisResult
    buildGoogleCloudDialogflowCxV3WebhookRequestSentimentAnalysisResult() {
  var o = api.GoogleCloudDialogflowCxV3WebhookRequestSentimentAnalysisResult();
  buildCounterGoogleCloudDialogflowCxV3WebhookRequestSentimentAnalysisResult++;
  if (buildCounterGoogleCloudDialogflowCxV3WebhookRequestSentimentAnalysisResult <
      3) {
    o.magnitude = 42.0;
    o.score = 42.0;
  }
  buildCounterGoogleCloudDialogflowCxV3WebhookRequestSentimentAnalysisResult--;
  return o;
}

void checkGoogleCloudDialogflowCxV3WebhookRequestSentimentAnalysisResult(
    api.GoogleCloudDialogflowCxV3WebhookRequestSentimentAnalysisResult o) {
  buildCounterGoogleCloudDialogflowCxV3WebhookRequestSentimentAnalysisResult++;
  if (buildCounterGoogleCloudDialogflowCxV3WebhookRequestSentimentAnalysisResult <
      3) {
    unittest.expect(
      o.magnitude!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3WebhookRequestSentimentAnalysisResult--;
}

core.Map<core.String, core.Object> buildUnnamed196() {
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

void checkUnnamed196(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted33 = (o['x']!) as core.Map;
  unittest.expect(casted33, unittest.hasLength(3));
  unittest.expect(
    casted33['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted33['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted33['string'],
    unittest.equals('foo'),
  );
  var casted34 = (o['y']!) as core.Map;
  unittest.expect(casted34, unittest.hasLength(3));
  unittest.expect(
    casted34['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted34['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted34['string'],
    unittest.equals('foo'),
  );
}

core.int buildCounterGoogleCloudDialogflowCxV3WebhookResponse = 0;
api.GoogleCloudDialogflowCxV3WebhookResponse
    buildGoogleCloudDialogflowCxV3WebhookResponse() {
  var o = api.GoogleCloudDialogflowCxV3WebhookResponse();
  buildCounterGoogleCloudDialogflowCxV3WebhookResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3WebhookResponse < 3) {
    o.fulfillmentResponse =
        buildGoogleCloudDialogflowCxV3WebhookResponseFulfillmentResponse();
    o.pageInfo = buildGoogleCloudDialogflowCxV3PageInfo();
    o.payload = buildUnnamed196();
    o.sessionInfo = buildGoogleCloudDialogflowCxV3SessionInfo();
    o.targetFlow = 'foo';
    o.targetPage = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3WebhookResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3WebhookResponse(
    api.GoogleCloudDialogflowCxV3WebhookResponse o) {
  buildCounterGoogleCloudDialogflowCxV3WebhookResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3WebhookResponse < 3) {
    checkGoogleCloudDialogflowCxV3WebhookResponseFulfillmentResponse(
        o.fulfillmentResponse!
            as api.GoogleCloudDialogflowCxV3WebhookResponseFulfillmentResponse);
    checkGoogleCloudDialogflowCxV3PageInfo(
        o.pageInfo! as api.GoogleCloudDialogflowCxV3PageInfo);
    checkUnnamed196(o.payload!);
    checkGoogleCloudDialogflowCxV3SessionInfo(
        o.sessionInfo! as api.GoogleCloudDialogflowCxV3SessionInfo);
    unittest.expect(
      o.targetFlow!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.targetPage!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3WebhookResponse--;
}

core.List<api.GoogleCloudDialogflowCxV3ResponseMessage> buildUnnamed197() {
  var o = <api.GoogleCloudDialogflowCxV3ResponseMessage>[];
  o.add(buildGoogleCloudDialogflowCxV3ResponseMessage());
  o.add(buildGoogleCloudDialogflowCxV3ResponseMessage());
  return o;
}

void checkUnnamed197(
    core.List<api.GoogleCloudDialogflowCxV3ResponseMessage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3ResponseMessage(
      o[0] as api.GoogleCloudDialogflowCxV3ResponseMessage);
  checkGoogleCloudDialogflowCxV3ResponseMessage(
      o[1] as api.GoogleCloudDialogflowCxV3ResponseMessage);
}

core.int
    buildCounterGoogleCloudDialogflowCxV3WebhookResponseFulfillmentResponse = 0;
api.GoogleCloudDialogflowCxV3WebhookResponseFulfillmentResponse
    buildGoogleCloudDialogflowCxV3WebhookResponseFulfillmentResponse() {
  var o = api.GoogleCloudDialogflowCxV3WebhookResponseFulfillmentResponse();
  buildCounterGoogleCloudDialogflowCxV3WebhookResponseFulfillmentResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3WebhookResponseFulfillmentResponse <
      3) {
    o.mergeBehavior = 'foo';
    o.messages = buildUnnamed197();
  }
  buildCounterGoogleCloudDialogflowCxV3WebhookResponseFulfillmentResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3WebhookResponseFulfillmentResponse(
    api.GoogleCloudDialogflowCxV3WebhookResponseFulfillmentResponse o) {
  buildCounterGoogleCloudDialogflowCxV3WebhookResponseFulfillmentResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3WebhookResponseFulfillmentResponse <
      3) {
    unittest.expect(
      o.mergeBehavior!,
      unittest.equals('foo'),
    );
    checkUnnamed197(o.messages!);
  }
  buildCounterGoogleCloudDialogflowCxV3WebhookResponseFulfillmentResponse--;
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1AudioInput = 0;
api.GoogleCloudDialogflowCxV3beta1AudioInput
    buildGoogleCloudDialogflowCxV3beta1AudioInput() {
  var o = api.GoogleCloudDialogflowCxV3beta1AudioInput();
  buildCounterGoogleCloudDialogflowCxV3beta1AudioInput++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1AudioInput < 3) {
    o.audio = 'foo';
    o.config = buildGoogleCloudDialogflowCxV3beta1InputAudioConfig();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1AudioInput--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1AudioInput(
    api.GoogleCloudDialogflowCxV3beta1AudioInput o) {
  buildCounterGoogleCloudDialogflowCxV3beta1AudioInput++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1AudioInput < 3) {
    unittest.expect(
      o.audio!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3beta1InputAudioConfig(
        o.config! as api.GoogleCloudDialogflowCxV3beta1InputAudioConfig);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1AudioInput--;
}

core.List<api.GoogleCloudDialogflowCxV3beta1TestError> buildUnnamed198() {
  var o = <api.GoogleCloudDialogflowCxV3beta1TestError>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1TestError());
  o.add(buildGoogleCloudDialogflowCxV3beta1TestError());
  return o;
}

void checkUnnamed198(core.List<api.GoogleCloudDialogflowCxV3beta1TestError> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1TestError(
      o[0] as api.GoogleCloudDialogflowCxV3beta1TestError);
  checkGoogleCloudDialogflowCxV3beta1TestError(
      o[1] as api.GoogleCloudDialogflowCxV3beta1TestError);
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1BatchRunTestCasesMetadata =
    0;
api.GoogleCloudDialogflowCxV3beta1BatchRunTestCasesMetadata
    buildGoogleCloudDialogflowCxV3beta1BatchRunTestCasesMetadata() {
  var o = api.GoogleCloudDialogflowCxV3beta1BatchRunTestCasesMetadata();
  buildCounterGoogleCloudDialogflowCxV3beta1BatchRunTestCasesMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1BatchRunTestCasesMetadata < 3) {
    o.errors = buildUnnamed198();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1BatchRunTestCasesMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1BatchRunTestCasesMetadata(
    api.GoogleCloudDialogflowCxV3beta1BatchRunTestCasesMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3beta1BatchRunTestCasesMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1BatchRunTestCasesMetadata < 3) {
    checkUnnamed198(o.errors!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1BatchRunTestCasesMetadata--;
}

core.List<api.GoogleCloudDialogflowCxV3beta1TestCaseResult> buildUnnamed199() {
  var o = <api.GoogleCloudDialogflowCxV3beta1TestCaseResult>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1TestCaseResult());
  o.add(buildGoogleCloudDialogflowCxV3beta1TestCaseResult());
  return o;
}

void checkUnnamed199(
    core.List<api.GoogleCloudDialogflowCxV3beta1TestCaseResult> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1TestCaseResult(
      o[0] as api.GoogleCloudDialogflowCxV3beta1TestCaseResult);
  checkGoogleCloudDialogflowCxV3beta1TestCaseResult(
      o[1] as api.GoogleCloudDialogflowCxV3beta1TestCaseResult);
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1BatchRunTestCasesResponse =
    0;
api.GoogleCloudDialogflowCxV3beta1BatchRunTestCasesResponse
    buildGoogleCloudDialogflowCxV3beta1BatchRunTestCasesResponse() {
  var o = api.GoogleCloudDialogflowCxV3beta1BatchRunTestCasesResponse();
  buildCounterGoogleCloudDialogflowCxV3beta1BatchRunTestCasesResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1BatchRunTestCasesResponse < 3) {
    o.results = buildUnnamed199();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1BatchRunTestCasesResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1BatchRunTestCasesResponse(
    api.GoogleCloudDialogflowCxV3beta1BatchRunTestCasesResponse o) {
  buildCounterGoogleCloudDialogflowCxV3beta1BatchRunTestCasesResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1BatchRunTestCasesResponse < 3) {
    checkUnnamed199(o.results!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1BatchRunTestCasesResponse--;
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1ConversationTurn = 0;
api.GoogleCloudDialogflowCxV3beta1ConversationTurn
    buildGoogleCloudDialogflowCxV3beta1ConversationTurn() {
  var o = api.GoogleCloudDialogflowCxV3beta1ConversationTurn();
  buildCounterGoogleCloudDialogflowCxV3beta1ConversationTurn++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ConversationTurn < 3) {
    o.userInput =
        buildGoogleCloudDialogflowCxV3beta1ConversationTurnUserInput();
    o.virtualAgentOutput =
        buildGoogleCloudDialogflowCxV3beta1ConversationTurnVirtualAgentOutput();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ConversationTurn--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ConversationTurn(
    api.GoogleCloudDialogflowCxV3beta1ConversationTurn o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ConversationTurn++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ConversationTurn < 3) {
    checkGoogleCloudDialogflowCxV3beta1ConversationTurnUserInput(o.userInput!
        as api.GoogleCloudDialogflowCxV3beta1ConversationTurnUserInput);
    checkGoogleCloudDialogflowCxV3beta1ConversationTurnVirtualAgentOutput(
        o.virtualAgentOutput! as api
            .GoogleCloudDialogflowCxV3beta1ConversationTurnVirtualAgentOutput);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ConversationTurn--;
}

core.Map<core.String, core.Object> buildUnnamed200() {
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

void checkUnnamed200(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted35 = (o['x']!) as core.Map;
  unittest.expect(casted35, unittest.hasLength(3));
  unittest.expect(
    casted35['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted35['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted35['string'],
    unittest.equals('foo'),
  );
  var casted36 = (o['y']!) as core.Map;
  unittest.expect(casted36, unittest.hasLength(3));
  unittest.expect(
    casted36['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted36['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted36['string'],
    unittest.equals('foo'),
  );
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1ConversationTurnUserInput =
    0;
api.GoogleCloudDialogflowCxV3beta1ConversationTurnUserInput
    buildGoogleCloudDialogflowCxV3beta1ConversationTurnUserInput() {
  var o = api.GoogleCloudDialogflowCxV3beta1ConversationTurnUserInput();
  buildCounterGoogleCloudDialogflowCxV3beta1ConversationTurnUserInput++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ConversationTurnUserInput < 3) {
    o.injectedParameters = buildUnnamed200();
    o.input = buildGoogleCloudDialogflowCxV3beta1QueryInput();
    o.isWebhookEnabled = true;
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ConversationTurnUserInput--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ConversationTurnUserInput(
    api.GoogleCloudDialogflowCxV3beta1ConversationTurnUserInput o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ConversationTurnUserInput++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ConversationTurnUserInput < 3) {
    checkUnnamed200(o.injectedParameters!);
    checkGoogleCloudDialogflowCxV3beta1QueryInput(
        o.input! as api.GoogleCloudDialogflowCxV3beta1QueryInput);
    unittest.expect(o.isWebhookEnabled!, unittest.isTrue);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ConversationTurnUserInput--;
}

core.Map<core.String, core.Object> buildUnnamed201() {
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

void checkUnnamed201(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted37 = (o['x']!) as core.Map;
  unittest.expect(casted37, unittest.hasLength(3));
  unittest.expect(
    casted37['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted37['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted37['string'],
    unittest.equals('foo'),
  );
  var casted38 = (o['y']!) as core.Map;
  unittest.expect(casted38, unittest.hasLength(3));
  unittest.expect(
    casted38['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted38['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted38['string'],
    unittest.equals('foo'),
  );
}

core.List<api.GoogleCloudDialogflowCxV3beta1TestRunDifference>
    buildUnnamed202() {
  var o = <api.GoogleCloudDialogflowCxV3beta1TestRunDifference>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1TestRunDifference());
  o.add(buildGoogleCloudDialogflowCxV3beta1TestRunDifference());
  return o;
}

void checkUnnamed202(
    core.List<api.GoogleCloudDialogflowCxV3beta1TestRunDifference> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1TestRunDifference(
      o[0] as api.GoogleCloudDialogflowCxV3beta1TestRunDifference);
  checkGoogleCloudDialogflowCxV3beta1TestRunDifference(
      o[1] as api.GoogleCloudDialogflowCxV3beta1TestRunDifference);
}

core.Map<core.String, core.Object> buildUnnamed203() {
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

void checkUnnamed203(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted39 = (o['x']!) as core.Map;
  unittest.expect(casted39, unittest.hasLength(3));
  unittest.expect(
    casted39['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted39['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted39['string'],
    unittest.equals('foo'),
  );
  var casted40 = (o['y']!) as core.Map;
  unittest.expect(casted40, unittest.hasLength(3));
  unittest.expect(
    casted40['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted40['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted40['string'],
    unittest.equals('foo'),
  );
}

core.List<api.GoogleCloudDialogflowCxV3beta1ResponseMessageText>
    buildUnnamed204() {
  var o = <api.GoogleCloudDialogflowCxV3beta1ResponseMessageText>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1ResponseMessageText());
  o.add(buildGoogleCloudDialogflowCxV3beta1ResponseMessageText());
  return o;
}

void checkUnnamed204(
    core.List<api.GoogleCloudDialogflowCxV3beta1ResponseMessageText> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1ResponseMessageText(
      o[0] as api.GoogleCloudDialogflowCxV3beta1ResponseMessageText);
  checkGoogleCloudDialogflowCxV3beta1ResponseMessageText(
      o[1] as api.GoogleCloudDialogflowCxV3beta1ResponseMessageText);
}

core.int
    buildCounterGoogleCloudDialogflowCxV3beta1ConversationTurnVirtualAgentOutput =
    0;
api.GoogleCloudDialogflowCxV3beta1ConversationTurnVirtualAgentOutput
    buildGoogleCloudDialogflowCxV3beta1ConversationTurnVirtualAgentOutput() {
  var o =
      api.GoogleCloudDialogflowCxV3beta1ConversationTurnVirtualAgentOutput();
  buildCounterGoogleCloudDialogflowCxV3beta1ConversationTurnVirtualAgentOutput++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ConversationTurnVirtualAgentOutput <
      3) {
    o.currentPage = buildGoogleCloudDialogflowCxV3beta1Page();
    o.diagnosticInfo = buildUnnamed201();
    o.differences = buildUnnamed202();
    o.sessionParameters = buildUnnamed203();
    o.status = buildGoogleRpcStatus();
    o.textResponses = buildUnnamed204();
    o.triggeredIntent = buildGoogleCloudDialogflowCxV3beta1Intent();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ConversationTurnVirtualAgentOutput--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ConversationTurnVirtualAgentOutput(
    api.GoogleCloudDialogflowCxV3beta1ConversationTurnVirtualAgentOutput o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ConversationTurnVirtualAgentOutput++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ConversationTurnVirtualAgentOutput <
      3) {
    checkGoogleCloudDialogflowCxV3beta1Page(
        o.currentPage! as api.GoogleCloudDialogflowCxV3beta1Page);
    checkUnnamed201(o.diagnosticInfo!);
    checkUnnamed202(o.differences!);
    checkUnnamed203(o.sessionParameters!);
    checkGoogleRpcStatus(o.status! as api.GoogleRpcStatus);
    checkUnnamed204(o.textResponses!);
    checkGoogleCloudDialogflowCxV3beta1Intent(
        o.triggeredIntent! as api.GoogleCloudDialogflowCxV3beta1Intent);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ConversationTurnVirtualAgentOutput--;
}

core.int
    buildCounterGoogleCloudDialogflowCxV3beta1CreateDocumentOperationMetadata =
    0;
api.GoogleCloudDialogflowCxV3beta1CreateDocumentOperationMetadata
    buildGoogleCloudDialogflowCxV3beta1CreateDocumentOperationMetadata() {
  var o = api.GoogleCloudDialogflowCxV3beta1CreateDocumentOperationMetadata();
  buildCounterGoogleCloudDialogflowCxV3beta1CreateDocumentOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1CreateDocumentOperationMetadata <
      3) {
    o.genericMetadata =
        buildGoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1CreateDocumentOperationMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1CreateDocumentOperationMetadata(
    api.GoogleCloudDialogflowCxV3beta1CreateDocumentOperationMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3beta1CreateDocumentOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1CreateDocumentOperationMetadata <
      3) {
    checkGoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata(o
            .genericMetadata!
        as api.GoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1CreateDocumentOperationMetadata--;
}

core.int
    buildCounterGoogleCloudDialogflowCxV3beta1CreateVersionOperationMetadata =
    0;
api.GoogleCloudDialogflowCxV3beta1CreateVersionOperationMetadata
    buildGoogleCloudDialogflowCxV3beta1CreateVersionOperationMetadata() {
  var o = api.GoogleCloudDialogflowCxV3beta1CreateVersionOperationMetadata();
  buildCounterGoogleCloudDialogflowCxV3beta1CreateVersionOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1CreateVersionOperationMetadata <
      3) {
    o.version = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3beta1CreateVersionOperationMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1CreateVersionOperationMetadata(
    api.GoogleCloudDialogflowCxV3beta1CreateVersionOperationMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3beta1CreateVersionOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1CreateVersionOperationMetadata <
      3) {
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1CreateVersionOperationMetadata--;
}

core.int
    buildCounterGoogleCloudDialogflowCxV3beta1DeleteDocumentOperationMetadata =
    0;
api.GoogleCloudDialogflowCxV3beta1DeleteDocumentOperationMetadata
    buildGoogleCloudDialogflowCxV3beta1DeleteDocumentOperationMetadata() {
  var o = api.GoogleCloudDialogflowCxV3beta1DeleteDocumentOperationMetadata();
  buildCounterGoogleCloudDialogflowCxV3beta1DeleteDocumentOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1DeleteDocumentOperationMetadata <
      3) {
    o.genericMetadata =
        buildGoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1DeleteDocumentOperationMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1DeleteDocumentOperationMetadata(
    api.GoogleCloudDialogflowCxV3beta1DeleteDocumentOperationMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3beta1DeleteDocumentOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1DeleteDocumentOperationMetadata <
      3) {
    checkGoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata(o
            .genericMetadata!
        as api.GoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1DeleteDocumentOperationMetadata--;
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1DtmfInput = 0;
api.GoogleCloudDialogflowCxV3beta1DtmfInput
    buildGoogleCloudDialogflowCxV3beta1DtmfInput() {
  var o = api.GoogleCloudDialogflowCxV3beta1DtmfInput();
  buildCounterGoogleCloudDialogflowCxV3beta1DtmfInput++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1DtmfInput < 3) {
    o.digits = 'foo';
    o.finishDigit = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3beta1DtmfInput--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1DtmfInput(
    api.GoogleCloudDialogflowCxV3beta1DtmfInput o) {
  buildCounterGoogleCloudDialogflowCxV3beta1DtmfInput++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1DtmfInput < 3) {
    unittest.expect(
      o.digits!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.finishDigit!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1DtmfInput--;
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1EventHandler = 0;
api.GoogleCloudDialogflowCxV3beta1EventHandler
    buildGoogleCloudDialogflowCxV3beta1EventHandler() {
  var o = api.GoogleCloudDialogflowCxV3beta1EventHandler();
  buildCounterGoogleCloudDialogflowCxV3beta1EventHandler++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1EventHandler < 3) {
    o.event = 'foo';
    o.name = 'foo';
    o.targetFlow = 'foo';
    o.targetPage = 'foo';
    o.triggerFulfillment = buildGoogleCloudDialogflowCxV3beta1Fulfillment();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1EventHandler--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1EventHandler(
    api.GoogleCloudDialogflowCxV3beta1EventHandler o) {
  buildCounterGoogleCloudDialogflowCxV3beta1EventHandler++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1EventHandler < 3) {
    unittest.expect(
      o.event!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.targetFlow!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.targetPage!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3beta1Fulfillment(
        o.triggerFulfillment! as api.GoogleCloudDialogflowCxV3beta1Fulfillment);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1EventHandler--;
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1EventInput = 0;
api.GoogleCloudDialogflowCxV3beta1EventInput
    buildGoogleCloudDialogflowCxV3beta1EventInput() {
  var o = api.GoogleCloudDialogflowCxV3beta1EventInput();
  buildCounterGoogleCloudDialogflowCxV3beta1EventInput++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1EventInput < 3) {
    o.event = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3beta1EventInput--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1EventInput(
    api.GoogleCloudDialogflowCxV3beta1EventInput o) {
  buildCounterGoogleCloudDialogflowCxV3beta1EventInput++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1EventInput < 3) {
    unittest.expect(
      o.event!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1EventInput--;
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1ExportAgentResponse = 0;
api.GoogleCloudDialogflowCxV3beta1ExportAgentResponse
    buildGoogleCloudDialogflowCxV3beta1ExportAgentResponse() {
  var o = api.GoogleCloudDialogflowCxV3beta1ExportAgentResponse();
  buildCounterGoogleCloudDialogflowCxV3beta1ExportAgentResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ExportAgentResponse < 3) {
    o.agentContent = 'foo';
    o.agentUri = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ExportAgentResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ExportAgentResponse(
    api.GoogleCloudDialogflowCxV3beta1ExportAgentResponse o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ExportAgentResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ExportAgentResponse < 3) {
    unittest.expect(
      o.agentContent!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.agentUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ExportAgentResponse--;
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1ExportTestCasesMetadata = 0;
api.GoogleCloudDialogflowCxV3beta1ExportTestCasesMetadata
    buildGoogleCloudDialogflowCxV3beta1ExportTestCasesMetadata() {
  var o = api.GoogleCloudDialogflowCxV3beta1ExportTestCasesMetadata();
  buildCounterGoogleCloudDialogflowCxV3beta1ExportTestCasesMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ExportTestCasesMetadata < 3) {}
  buildCounterGoogleCloudDialogflowCxV3beta1ExportTestCasesMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ExportTestCasesMetadata(
    api.GoogleCloudDialogflowCxV3beta1ExportTestCasesMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ExportTestCasesMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ExportTestCasesMetadata < 3) {}
  buildCounterGoogleCloudDialogflowCxV3beta1ExportTestCasesMetadata--;
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1ExportTestCasesResponse = 0;
api.GoogleCloudDialogflowCxV3beta1ExportTestCasesResponse
    buildGoogleCloudDialogflowCxV3beta1ExportTestCasesResponse() {
  var o = api.GoogleCloudDialogflowCxV3beta1ExportTestCasesResponse();
  buildCounterGoogleCloudDialogflowCxV3beta1ExportTestCasesResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ExportTestCasesResponse < 3) {
    o.content = 'foo';
    o.gcsUri = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ExportTestCasesResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ExportTestCasesResponse(
    api.GoogleCloudDialogflowCxV3beta1ExportTestCasesResponse o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ExportTestCasesResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ExportTestCasesResponse < 3) {
    unittest.expect(
      o.content!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.gcsUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ExportTestCasesResponse--;
}

core.List<api.GoogleCloudDialogflowCxV3beta1FormParameter> buildUnnamed205() {
  var o = <api.GoogleCloudDialogflowCxV3beta1FormParameter>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1FormParameter());
  o.add(buildGoogleCloudDialogflowCxV3beta1FormParameter());
  return o;
}

void checkUnnamed205(
    core.List<api.GoogleCloudDialogflowCxV3beta1FormParameter> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1FormParameter(
      o[0] as api.GoogleCloudDialogflowCxV3beta1FormParameter);
  checkGoogleCloudDialogflowCxV3beta1FormParameter(
      o[1] as api.GoogleCloudDialogflowCxV3beta1FormParameter);
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1Form = 0;
api.GoogleCloudDialogflowCxV3beta1Form
    buildGoogleCloudDialogflowCxV3beta1Form() {
  var o = api.GoogleCloudDialogflowCxV3beta1Form();
  buildCounterGoogleCloudDialogflowCxV3beta1Form++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1Form < 3) {
    o.parameters = buildUnnamed205();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1Form--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1Form(
    api.GoogleCloudDialogflowCxV3beta1Form o) {
  buildCounterGoogleCloudDialogflowCxV3beta1Form++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1Form < 3) {
    checkUnnamed205(o.parameters!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1Form--;
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1FormParameter = 0;
api.GoogleCloudDialogflowCxV3beta1FormParameter
    buildGoogleCloudDialogflowCxV3beta1FormParameter() {
  var o = api.GoogleCloudDialogflowCxV3beta1FormParameter();
  buildCounterGoogleCloudDialogflowCxV3beta1FormParameter++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1FormParameter < 3) {
    o.defaultValue = {
      'list': [1, 2, 3],
      'bool': true,
      'string': 'foo'
    };
    o.displayName = 'foo';
    o.entityType = 'foo';
    o.fillBehavior =
        buildGoogleCloudDialogflowCxV3beta1FormParameterFillBehavior();
    o.isList = true;
    o.redact = true;
    o.required = true;
  }
  buildCounterGoogleCloudDialogflowCxV3beta1FormParameter--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1FormParameter(
    api.GoogleCloudDialogflowCxV3beta1FormParameter o) {
  buildCounterGoogleCloudDialogflowCxV3beta1FormParameter++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1FormParameter < 3) {
    var casted41 = (o.defaultValue!) as core.Map;
    unittest.expect(casted41, unittest.hasLength(3));
    unittest.expect(
      casted41['list'],
      unittest.equals([1, 2, 3]),
    );
    unittest.expect(
      casted41['bool'],
      unittest.equals(true),
    );
    unittest.expect(
      casted41['string'],
      unittest.equals('foo'),
    );
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.entityType!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3beta1FormParameterFillBehavior(o.fillBehavior!
        as api.GoogleCloudDialogflowCxV3beta1FormParameterFillBehavior);
    unittest.expect(o.isList!, unittest.isTrue);
    unittest.expect(o.redact!, unittest.isTrue);
    unittest.expect(o.required!, unittest.isTrue);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1FormParameter--;
}

core.List<api.GoogleCloudDialogflowCxV3beta1EventHandler> buildUnnamed206() {
  var o = <api.GoogleCloudDialogflowCxV3beta1EventHandler>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1EventHandler());
  o.add(buildGoogleCloudDialogflowCxV3beta1EventHandler());
  return o;
}

void checkUnnamed206(
    core.List<api.GoogleCloudDialogflowCxV3beta1EventHandler> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1EventHandler(
      o[0] as api.GoogleCloudDialogflowCxV3beta1EventHandler);
  checkGoogleCloudDialogflowCxV3beta1EventHandler(
      o[1] as api.GoogleCloudDialogflowCxV3beta1EventHandler);
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1FormParameterFillBehavior =
    0;
api.GoogleCloudDialogflowCxV3beta1FormParameterFillBehavior
    buildGoogleCloudDialogflowCxV3beta1FormParameterFillBehavior() {
  var o = api.GoogleCloudDialogflowCxV3beta1FormParameterFillBehavior();
  buildCounterGoogleCloudDialogflowCxV3beta1FormParameterFillBehavior++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1FormParameterFillBehavior < 3) {
    o.initialPromptFulfillment =
        buildGoogleCloudDialogflowCxV3beta1Fulfillment();
    o.repromptEventHandlers = buildUnnamed206();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1FormParameterFillBehavior--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1FormParameterFillBehavior(
    api.GoogleCloudDialogflowCxV3beta1FormParameterFillBehavior o) {
  buildCounterGoogleCloudDialogflowCxV3beta1FormParameterFillBehavior++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1FormParameterFillBehavior < 3) {
    checkGoogleCloudDialogflowCxV3beta1Fulfillment(o.initialPromptFulfillment!
        as api.GoogleCloudDialogflowCxV3beta1Fulfillment);
    checkUnnamed206(o.repromptEventHandlers!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1FormParameterFillBehavior--;
}

core.List<api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases>
    buildUnnamed207() {
  var o = <api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases());
  o.add(buildGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases());
  return o;
}

void checkUnnamed207(
    core.List<api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases(
      o[0] as api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases);
  checkGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases(
      o[1] as api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases);
}

core.List<api.GoogleCloudDialogflowCxV3beta1ResponseMessage> buildUnnamed208() {
  var o = <api.GoogleCloudDialogflowCxV3beta1ResponseMessage>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1ResponseMessage());
  o.add(buildGoogleCloudDialogflowCxV3beta1ResponseMessage());
  return o;
}

void checkUnnamed208(
    core.List<api.GoogleCloudDialogflowCxV3beta1ResponseMessage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1ResponseMessage(
      o[0] as api.GoogleCloudDialogflowCxV3beta1ResponseMessage);
  checkGoogleCloudDialogflowCxV3beta1ResponseMessage(
      o[1] as api.GoogleCloudDialogflowCxV3beta1ResponseMessage);
}

core.List<api.GoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction>
    buildUnnamed209() {
  var o = <api.GoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction());
  o.add(buildGoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction());
  return o;
}

void checkUnnamed209(
    core.List<api.GoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction(
      o[0] as api.GoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction);
  checkGoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction(
      o[1] as api.GoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction);
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1Fulfillment = 0;
api.GoogleCloudDialogflowCxV3beta1Fulfillment
    buildGoogleCloudDialogflowCxV3beta1Fulfillment() {
  var o = api.GoogleCloudDialogflowCxV3beta1Fulfillment();
  buildCounterGoogleCloudDialogflowCxV3beta1Fulfillment++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1Fulfillment < 3) {
    o.conditionalCases = buildUnnamed207();
    o.messages = buildUnnamed208();
    o.setParameterActions = buildUnnamed209();
    o.tag = 'foo';
    o.webhook = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3beta1Fulfillment--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1Fulfillment(
    api.GoogleCloudDialogflowCxV3beta1Fulfillment o) {
  buildCounterGoogleCloudDialogflowCxV3beta1Fulfillment++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1Fulfillment < 3) {
    checkUnnamed207(o.conditionalCases!);
    checkUnnamed208(o.messages!);
    checkUnnamed209(o.setParameterActions!);
    unittest.expect(
      o.tag!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.webhook!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1Fulfillment--;
}

core.List<api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase>
    buildUnnamed210() {
  var o = <api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase());
  o.add(buildGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase());
  return o;
}

void checkUnnamed210(
    core.List<api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase(o[0]
      as api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase);
  checkGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase(o[1]
      as api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase);
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases =
    0;
api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases
    buildGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases() {
  var o = api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases();
  buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases <
      3) {
    o.cases = buildUnnamed210();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases(
    api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases o) {
  buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases <
      3) {
    checkUnnamed210(o.cases!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases--;
}

core.List<
        api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent>
    buildUnnamed211() {
  var o = <
      api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent>[];
  o.add(
      buildGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent());
  o.add(
      buildGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent());
  return o;
}

void checkUnnamed211(
    core.List<
            api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent(
      o[0] as api
          .GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent);
  checkGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent(
      o[1] as api
          .GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent);
}

core.int
    buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase =
    0;
api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase
    buildGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase() {
  var o = api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase();
  buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase <
      3) {
    o.caseContent = buildUnnamed211();
    o.condition = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase(
    api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase o) {
  buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase <
      3) {
    checkUnnamed211(o.caseContent!);
    unittest.expect(
      o.condition!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase--;
}

core.int
    buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent =
    0;
api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent
    buildGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent() {
  var o = api
      .GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent();
  buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent <
      3) {
    o.additionalCases =
        buildGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases();
    o.message = buildGoogleCloudDialogflowCxV3beta1ResponseMessage();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent(
    api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent
        o) {
  buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent <
      3) {
    checkGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases(
        o.additionalCases!
            as api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases);
    checkGoogleCloudDialogflowCxV3beta1ResponseMessage(
        o.message! as api.GoogleCloudDialogflowCxV3beta1ResponseMessage);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent--;
}

core.int
    buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction = 0;
api.GoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction
    buildGoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction() {
  var o = api.GoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction();
  buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction <
      3) {
    o.parameter = 'foo';
    o.value = {
      'list': [1, 2, 3],
      'bool': true,
      'string': 'foo'
    };
  }
  buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction(
    api.GoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction o) {
  buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction <
      3) {
    unittest.expect(
      o.parameter!,
      unittest.equals('foo'),
    );
    var casted42 = (o.value!) as core.Map;
    unittest.expect(casted42, unittest.hasLength(3));
    unittest.expect(
      casted42['list'],
      unittest.equals([1, 2, 3]),
    );
    unittest.expect(
      casted42['bool'],
      unittest.equals(true),
    );
    unittest.expect(
      casted42['string'],
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction--;
}

core.int
    buildCounterGoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata =
    0;
api.GoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata
    buildGoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata() {
  var o = api.GoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata();
  buildCounterGoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata <
      3) {
    o.state = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata(
    api.GoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata <
      3) {
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata--;
}

core.int
    buildCounterGoogleCloudDialogflowCxV3beta1ImportDocumentsOperationMetadata =
    0;
api.GoogleCloudDialogflowCxV3beta1ImportDocumentsOperationMetadata
    buildGoogleCloudDialogflowCxV3beta1ImportDocumentsOperationMetadata() {
  var o = api.GoogleCloudDialogflowCxV3beta1ImportDocumentsOperationMetadata();
  buildCounterGoogleCloudDialogflowCxV3beta1ImportDocumentsOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ImportDocumentsOperationMetadata <
      3) {
    o.genericMetadata =
        buildGoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ImportDocumentsOperationMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ImportDocumentsOperationMetadata(
    api.GoogleCloudDialogflowCxV3beta1ImportDocumentsOperationMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ImportDocumentsOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ImportDocumentsOperationMetadata <
      3) {
    checkGoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata(o
            .genericMetadata!
        as api.GoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ImportDocumentsOperationMetadata--;
}

core.List<api.GoogleRpcStatus> buildUnnamed212() {
  var o = <api.GoogleRpcStatus>[];
  o.add(buildGoogleRpcStatus());
  o.add(buildGoogleRpcStatus());
  return o;
}

void checkUnnamed212(core.List<api.GoogleRpcStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleRpcStatus(o[0] as api.GoogleRpcStatus);
  checkGoogleRpcStatus(o[1] as api.GoogleRpcStatus);
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1ImportDocumentsResponse = 0;
api.GoogleCloudDialogflowCxV3beta1ImportDocumentsResponse
    buildGoogleCloudDialogflowCxV3beta1ImportDocumentsResponse() {
  var o = api.GoogleCloudDialogflowCxV3beta1ImportDocumentsResponse();
  buildCounterGoogleCloudDialogflowCxV3beta1ImportDocumentsResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ImportDocumentsResponse < 3) {
    o.warnings = buildUnnamed212();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ImportDocumentsResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ImportDocumentsResponse(
    api.GoogleCloudDialogflowCxV3beta1ImportDocumentsResponse o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ImportDocumentsResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ImportDocumentsResponse < 3) {
    checkUnnamed212(o.warnings!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ImportDocumentsResponse--;
}

core.List<api.GoogleCloudDialogflowCxV3beta1TestCaseError> buildUnnamed213() {
  var o = <api.GoogleCloudDialogflowCxV3beta1TestCaseError>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1TestCaseError());
  o.add(buildGoogleCloudDialogflowCxV3beta1TestCaseError());
  return o;
}

void checkUnnamed213(
    core.List<api.GoogleCloudDialogflowCxV3beta1TestCaseError> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1TestCaseError(
      o[0] as api.GoogleCloudDialogflowCxV3beta1TestCaseError);
  checkGoogleCloudDialogflowCxV3beta1TestCaseError(
      o[1] as api.GoogleCloudDialogflowCxV3beta1TestCaseError);
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1ImportTestCasesMetadata = 0;
api.GoogleCloudDialogflowCxV3beta1ImportTestCasesMetadata
    buildGoogleCloudDialogflowCxV3beta1ImportTestCasesMetadata() {
  var o = api.GoogleCloudDialogflowCxV3beta1ImportTestCasesMetadata();
  buildCounterGoogleCloudDialogflowCxV3beta1ImportTestCasesMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ImportTestCasesMetadata < 3) {
    o.errors = buildUnnamed213();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ImportTestCasesMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ImportTestCasesMetadata(
    api.GoogleCloudDialogflowCxV3beta1ImportTestCasesMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ImportTestCasesMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ImportTestCasesMetadata < 3) {
    checkUnnamed213(o.errors!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ImportTestCasesMetadata--;
}

core.List<core.String> buildUnnamed214() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed214(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowCxV3beta1ImportTestCasesResponse = 0;
api.GoogleCloudDialogflowCxV3beta1ImportTestCasesResponse
    buildGoogleCloudDialogflowCxV3beta1ImportTestCasesResponse() {
  var o = api.GoogleCloudDialogflowCxV3beta1ImportTestCasesResponse();
  buildCounterGoogleCloudDialogflowCxV3beta1ImportTestCasesResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ImportTestCasesResponse < 3) {
    o.names = buildUnnamed214();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ImportTestCasesResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ImportTestCasesResponse(
    api.GoogleCloudDialogflowCxV3beta1ImportTestCasesResponse o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ImportTestCasesResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ImportTestCasesResponse < 3) {
    checkUnnamed214(o.names!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ImportTestCasesResponse--;
}

core.List<core.String> buildUnnamed215() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed215(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowCxV3beta1InputAudioConfig = 0;
api.GoogleCloudDialogflowCxV3beta1InputAudioConfig
    buildGoogleCloudDialogflowCxV3beta1InputAudioConfig() {
  var o = api.GoogleCloudDialogflowCxV3beta1InputAudioConfig();
  buildCounterGoogleCloudDialogflowCxV3beta1InputAudioConfig++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1InputAudioConfig < 3) {
    o.audioEncoding = 'foo';
    o.enableWordInfo = true;
    o.model = 'foo';
    o.modelVariant = 'foo';
    o.phraseHints = buildUnnamed215();
    o.sampleRateHertz = 42;
    o.singleUtterance = true;
  }
  buildCounterGoogleCloudDialogflowCxV3beta1InputAudioConfig--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1InputAudioConfig(
    api.GoogleCloudDialogflowCxV3beta1InputAudioConfig o) {
  buildCounterGoogleCloudDialogflowCxV3beta1InputAudioConfig++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1InputAudioConfig < 3) {
    unittest.expect(
      o.audioEncoding!,
      unittest.equals('foo'),
    );
    unittest.expect(o.enableWordInfo!, unittest.isTrue);
    unittest.expect(
      o.model!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.modelVariant!,
      unittest.equals('foo'),
    );
    checkUnnamed215(o.phraseHints!);
    unittest.expect(
      o.sampleRateHertz!,
      unittest.equals(42),
    );
    unittest.expect(o.singleUtterance!, unittest.isTrue);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1InputAudioConfig--;
}

core.Map<core.String, core.String> buildUnnamed216() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed216(core.Map<core.String, core.String> o) {
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

core.List<api.GoogleCloudDialogflowCxV3beta1IntentParameter> buildUnnamed217() {
  var o = <api.GoogleCloudDialogflowCxV3beta1IntentParameter>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1IntentParameter());
  o.add(buildGoogleCloudDialogflowCxV3beta1IntentParameter());
  return o;
}

void checkUnnamed217(
    core.List<api.GoogleCloudDialogflowCxV3beta1IntentParameter> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1IntentParameter(
      o[0] as api.GoogleCloudDialogflowCxV3beta1IntentParameter);
  checkGoogleCloudDialogflowCxV3beta1IntentParameter(
      o[1] as api.GoogleCloudDialogflowCxV3beta1IntentParameter);
}

core.List<api.GoogleCloudDialogflowCxV3beta1IntentTrainingPhrase>
    buildUnnamed218() {
  var o = <api.GoogleCloudDialogflowCxV3beta1IntentTrainingPhrase>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1IntentTrainingPhrase());
  o.add(buildGoogleCloudDialogflowCxV3beta1IntentTrainingPhrase());
  return o;
}

void checkUnnamed218(
    core.List<api.GoogleCloudDialogflowCxV3beta1IntentTrainingPhrase> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1IntentTrainingPhrase(
      o[0] as api.GoogleCloudDialogflowCxV3beta1IntentTrainingPhrase);
  checkGoogleCloudDialogflowCxV3beta1IntentTrainingPhrase(
      o[1] as api.GoogleCloudDialogflowCxV3beta1IntentTrainingPhrase);
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1Intent = 0;
api.GoogleCloudDialogflowCxV3beta1Intent
    buildGoogleCloudDialogflowCxV3beta1Intent() {
  var o = api.GoogleCloudDialogflowCxV3beta1Intent();
  buildCounterGoogleCloudDialogflowCxV3beta1Intent++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1Intent < 3) {
    o.description = 'foo';
    o.displayName = 'foo';
    o.isFallback = true;
    o.labels = buildUnnamed216();
    o.name = 'foo';
    o.parameters = buildUnnamed217();
    o.priority = 42;
    o.trainingPhrases = buildUnnamed218();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1Intent--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1Intent(
    api.GoogleCloudDialogflowCxV3beta1Intent o) {
  buildCounterGoogleCloudDialogflowCxV3beta1Intent++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1Intent < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(o.isFallback!, unittest.isTrue);
    checkUnnamed216(o.labels!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed217(o.parameters!);
    unittest.expect(
      o.priority!,
      unittest.equals(42),
    );
    checkUnnamed218(o.trainingPhrases!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1Intent--;
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1IntentInput = 0;
api.GoogleCloudDialogflowCxV3beta1IntentInput
    buildGoogleCloudDialogflowCxV3beta1IntentInput() {
  var o = api.GoogleCloudDialogflowCxV3beta1IntentInput();
  buildCounterGoogleCloudDialogflowCxV3beta1IntentInput++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1IntentInput < 3) {
    o.intent = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3beta1IntentInput--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1IntentInput(
    api.GoogleCloudDialogflowCxV3beta1IntentInput o) {
  buildCounterGoogleCloudDialogflowCxV3beta1IntentInput++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1IntentInput < 3) {
    unittest.expect(
      o.intent!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1IntentInput--;
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1IntentParameter = 0;
api.GoogleCloudDialogflowCxV3beta1IntentParameter
    buildGoogleCloudDialogflowCxV3beta1IntentParameter() {
  var o = api.GoogleCloudDialogflowCxV3beta1IntentParameter();
  buildCounterGoogleCloudDialogflowCxV3beta1IntentParameter++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1IntentParameter < 3) {
    o.entityType = 'foo';
    o.id = 'foo';
    o.isList = true;
    o.redact = true;
  }
  buildCounterGoogleCloudDialogflowCxV3beta1IntentParameter--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1IntentParameter(
    api.GoogleCloudDialogflowCxV3beta1IntentParameter o) {
  buildCounterGoogleCloudDialogflowCxV3beta1IntentParameter++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1IntentParameter < 3) {
    unittest.expect(
      o.entityType!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.id!,
      unittest.equals('foo'),
    );
    unittest.expect(o.isList!, unittest.isTrue);
    unittest.expect(o.redact!, unittest.isTrue);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1IntentParameter--;
}

core.List<api.GoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart>
    buildUnnamed219() {
  var o = <api.GoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart());
  o.add(buildGoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart());
  return o;
}

void checkUnnamed219(
    core.List<api.GoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart(
      o[0] as api.GoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart);
  checkGoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart(
      o[1] as api.GoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart);
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1IntentTrainingPhrase = 0;
api.GoogleCloudDialogflowCxV3beta1IntentTrainingPhrase
    buildGoogleCloudDialogflowCxV3beta1IntentTrainingPhrase() {
  var o = api.GoogleCloudDialogflowCxV3beta1IntentTrainingPhrase();
  buildCounterGoogleCloudDialogflowCxV3beta1IntentTrainingPhrase++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1IntentTrainingPhrase < 3) {
    o.id = 'foo';
    o.parts = buildUnnamed219();
    o.repeatCount = 42;
  }
  buildCounterGoogleCloudDialogflowCxV3beta1IntentTrainingPhrase--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1IntentTrainingPhrase(
    api.GoogleCloudDialogflowCxV3beta1IntentTrainingPhrase o) {
  buildCounterGoogleCloudDialogflowCxV3beta1IntentTrainingPhrase++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1IntentTrainingPhrase < 3) {
    unittest.expect(
      o.id!,
      unittest.equals('foo'),
    );
    checkUnnamed219(o.parts!);
    unittest.expect(
      o.repeatCount!,
      unittest.equals(42),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1IntentTrainingPhrase--;
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart = 0;
api.GoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart
    buildGoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart() {
  var o = api.GoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart();
  buildCounterGoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart < 3) {
    o.parameterId = 'foo';
    o.text = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart(
    api.GoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart o) {
  buildCounterGoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart < 3) {
    unittest.expect(
      o.parameterId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart--;
}

core.List<api.GoogleCloudDialogflowCxV3beta1EventHandler> buildUnnamed220() {
  var o = <api.GoogleCloudDialogflowCxV3beta1EventHandler>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1EventHandler());
  o.add(buildGoogleCloudDialogflowCxV3beta1EventHandler());
  return o;
}

void checkUnnamed220(
    core.List<api.GoogleCloudDialogflowCxV3beta1EventHandler> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1EventHandler(
      o[0] as api.GoogleCloudDialogflowCxV3beta1EventHandler);
  checkGoogleCloudDialogflowCxV3beta1EventHandler(
      o[1] as api.GoogleCloudDialogflowCxV3beta1EventHandler);
}

core.List<core.String> buildUnnamed221() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed221(core.List<core.String> o) {
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

core.List<api.GoogleCloudDialogflowCxV3beta1TransitionRoute> buildUnnamed222() {
  var o = <api.GoogleCloudDialogflowCxV3beta1TransitionRoute>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1TransitionRoute());
  o.add(buildGoogleCloudDialogflowCxV3beta1TransitionRoute());
  return o;
}

void checkUnnamed222(
    core.List<api.GoogleCloudDialogflowCxV3beta1TransitionRoute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1TransitionRoute(
      o[0] as api.GoogleCloudDialogflowCxV3beta1TransitionRoute);
  checkGoogleCloudDialogflowCxV3beta1TransitionRoute(
      o[1] as api.GoogleCloudDialogflowCxV3beta1TransitionRoute);
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1Page = 0;
api.GoogleCloudDialogflowCxV3beta1Page
    buildGoogleCloudDialogflowCxV3beta1Page() {
  var o = api.GoogleCloudDialogflowCxV3beta1Page();
  buildCounterGoogleCloudDialogflowCxV3beta1Page++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1Page < 3) {
    o.displayName = 'foo';
    o.entryFulfillment = buildGoogleCloudDialogflowCxV3beta1Fulfillment();
    o.eventHandlers = buildUnnamed220();
    o.form = buildGoogleCloudDialogflowCxV3beta1Form();
    o.name = 'foo';
    o.transitionRouteGroups = buildUnnamed221();
    o.transitionRoutes = buildUnnamed222();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1Page--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1Page(
    api.GoogleCloudDialogflowCxV3beta1Page o) {
  buildCounterGoogleCloudDialogflowCxV3beta1Page++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1Page < 3) {
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3beta1Fulfillment(
        o.entryFulfillment! as api.GoogleCloudDialogflowCxV3beta1Fulfillment);
    checkUnnamed220(o.eventHandlers!);
    checkGoogleCloudDialogflowCxV3beta1Form(
        o.form! as api.GoogleCloudDialogflowCxV3beta1Form);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed221(o.transitionRouteGroups!);
    checkUnnamed222(o.transitionRoutes!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1Page--;
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1PageInfo = 0;
api.GoogleCloudDialogflowCxV3beta1PageInfo
    buildGoogleCloudDialogflowCxV3beta1PageInfo() {
  var o = api.GoogleCloudDialogflowCxV3beta1PageInfo();
  buildCounterGoogleCloudDialogflowCxV3beta1PageInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1PageInfo < 3) {
    o.currentPage = 'foo';
    o.formInfo = buildGoogleCloudDialogflowCxV3beta1PageInfoFormInfo();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1PageInfo--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1PageInfo(
    api.GoogleCloudDialogflowCxV3beta1PageInfo o) {
  buildCounterGoogleCloudDialogflowCxV3beta1PageInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1PageInfo < 3) {
    unittest.expect(
      o.currentPage!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3beta1PageInfoFormInfo(
        o.formInfo! as api.GoogleCloudDialogflowCxV3beta1PageInfoFormInfo);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1PageInfo--;
}

core.List<api.GoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo>
    buildUnnamed223() {
  var o = <api.GoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo());
  o.add(buildGoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo());
  return o;
}

void checkUnnamed223(
    core.List<api.GoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo(
      o[0] as api.GoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo);
  checkGoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo(
      o[1] as api.GoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo);
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1PageInfoFormInfo = 0;
api.GoogleCloudDialogflowCxV3beta1PageInfoFormInfo
    buildGoogleCloudDialogflowCxV3beta1PageInfoFormInfo() {
  var o = api.GoogleCloudDialogflowCxV3beta1PageInfoFormInfo();
  buildCounterGoogleCloudDialogflowCxV3beta1PageInfoFormInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1PageInfoFormInfo < 3) {
    o.parameterInfo = buildUnnamed223();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1PageInfoFormInfo--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1PageInfoFormInfo(
    api.GoogleCloudDialogflowCxV3beta1PageInfoFormInfo o) {
  buildCounterGoogleCloudDialogflowCxV3beta1PageInfoFormInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1PageInfoFormInfo < 3) {
    checkUnnamed223(o.parameterInfo!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1PageInfoFormInfo--;
}

core.int
    buildCounterGoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo = 0;
api.GoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo
    buildGoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo() {
  var o = api.GoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo();
  buildCounterGoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo <
      3) {
    o.displayName = 'foo';
    o.justCollected = true;
    o.required = true;
    o.state = 'foo';
    o.value = {
      'list': [1, 2, 3],
      'bool': true,
      'string': 'foo'
    };
  }
  buildCounterGoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo(
    api.GoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo o) {
  buildCounterGoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo <
      3) {
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(o.justCollected!, unittest.isTrue);
    unittest.expect(o.required!, unittest.isTrue);
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
    var casted43 = (o.value!) as core.Map;
    unittest.expect(casted43, unittest.hasLength(3));
    unittest.expect(
      casted43['list'],
      unittest.equals([1, 2, 3]),
    );
    unittest.expect(
      casted43['bool'],
      unittest.equals(true),
    );
    unittest.expect(
      casted43['string'],
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo--;
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1QueryInput = 0;
api.GoogleCloudDialogflowCxV3beta1QueryInput
    buildGoogleCloudDialogflowCxV3beta1QueryInput() {
  var o = api.GoogleCloudDialogflowCxV3beta1QueryInput();
  buildCounterGoogleCloudDialogflowCxV3beta1QueryInput++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1QueryInput < 3) {
    o.audio = buildGoogleCloudDialogflowCxV3beta1AudioInput();
    o.dtmf = buildGoogleCloudDialogflowCxV3beta1DtmfInput();
    o.event = buildGoogleCloudDialogflowCxV3beta1EventInput();
    o.intent = buildGoogleCloudDialogflowCxV3beta1IntentInput();
    o.languageCode = 'foo';
    o.text = buildGoogleCloudDialogflowCxV3beta1TextInput();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1QueryInput--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1QueryInput(
    api.GoogleCloudDialogflowCxV3beta1QueryInput o) {
  buildCounterGoogleCloudDialogflowCxV3beta1QueryInput++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1QueryInput < 3) {
    checkGoogleCloudDialogflowCxV3beta1AudioInput(
        o.audio! as api.GoogleCloudDialogflowCxV3beta1AudioInput);
    checkGoogleCloudDialogflowCxV3beta1DtmfInput(
        o.dtmf! as api.GoogleCloudDialogflowCxV3beta1DtmfInput);
    checkGoogleCloudDialogflowCxV3beta1EventInput(
        o.event! as api.GoogleCloudDialogflowCxV3beta1EventInput);
    checkGoogleCloudDialogflowCxV3beta1IntentInput(
        o.intent! as api.GoogleCloudDialogflowCxV3beta1IntentInput);
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3beta1TextInput(
        o.text! as api.GoogleCloudDialogflowCxV3beta1TextInput);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1QueryInput--;
}

core.int
    buildCounterGoogleCloudDialogflowCxV3beta1ReloadDocumentOperationMetadata =
    0;
api.GoogleCloudDialogflowCxV3beta1ReloadDocumentOperationMetadata
    buildGoogleCloudDialogflowCxV3beta1ReloadDocumentOperationMetadata() {
  var o = api.GoogleCloudDialogflowCxV3beta1ReloadDocumentOperationMetadata();
  buildCounterGoogleCloudDialogflowCxV3beta1ReloadDocumentOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ReloadDocumentOperationMetadata <
      3) {
    o.genericMetadata =
        buildGoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ReloadDocumentOperationMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ReloadDocumentOperationMetadata(
    api.GoogleCloudDialogflowCxV3beta1ReloadDocumentOperationMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ReloadDocumentOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ReloadDocumentOperationMetadata <
      3) {
    checkGoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata(o
            .genericMetadata!
        as api.GoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ReloadDocumentOperationMetadata--;
}

core.Map<core.String, core.Object> buildUnnamed224() {
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

void checkUnnamed224(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted44 = (o['x']!) as core.Map;
  unittest.expect(casted44, unittest.hasLength(3));
  unittest.expect(
    casted44['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted44['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted44['string'],
    unittest.equals('foo'),
  );
  var casted45 = (o['y']!) as core.Map;
  unittest.expect(casted45, unittest.hasLength(3));
  unittest.expect(
    casted45['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted45['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted45['string'],
    unittest.equals('foo'),
  );
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessage = 0;
api.GoogleCloudDialogflowCxV3beta1ResponseMessage
    buildGoogleCloudDialogflowCxV3beta1ResponseMessage() {
  var o = api.GoogleCloudDialogflowCxV3beta1ResponseMessage();
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessage++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessage < 3) {
    o.conversationSuccess =
        buildGoogleCloudDialogflowCxV3beta1ResponseMessageConversationSuccess();
    o.endInteraction =
        buildGoogleCloudDialogflowCxV3beta1ResponseMessageEndInteraction();
    o.liveAgentHandoff =
        buildGoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff();
    o.mixedAudio =
        buildGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudio();
    o.outputAudioText =
        buildGoogleCloudDialogflowCxV3beta1ResponseMessageOutputAudioText();
    o.payload = buildUnnamed224();
    o.playAudio = buildGoogleCloudDialogflowCxV3beta1ResponseMessagePlayAudio();
    o.text = buildGoogleCloudDialogflowCxV3beta1ResponseMessageText();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessage--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ResponseMessage(
    api.GoogleCloudDialogflowCxV3beta1ResponseMessage o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessage++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessage < 3) {
    checkGoogleCloudDialogflowCxV3beta1ResponseMessageConversationSuccess(
        o.conversationSuccess! as api
            .GoogleCloudDialogflowCxV3beta1ResponseMessageConversationSuccess);
    checkGoogleCloudDialogflowCxV3beta1ResponseMessageEndInteraction(
        o.endInteraction!
            as api.GoogleCloudDialogflowCxV3beta1ResponseMessageEndInteraction);
    checkGoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff(o
            .liveAgentHandoff!
        as api.GoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff);
    checkGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudio(o.mixedAudio!
        as api.GoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudio);
    checkGoogleCloudDialogflowCxV3beta1ResponseMessageOutputAudioText(o
            .outputAudioText!
        as api.GoogleCloudDialogflowCxV3beta1ResponseMessageOutputAudioText);
    checkUnnamed224(o.payload!);
    checkGoogleCloudDialogflowCxV3beta1ResponseMessagePlayAudio(o.playAudio!
        as api.GoogleCloudDialogflowCxV3beta1ResponseMessagePlayAudio);
    checkGoogleCloudDialogflowCxV3beta1ResponseMessageText(
        o.text! as api.GoogleCloudDialogflowCxV3beta1ResponseMessageText);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessage--;
}

core.Map<core.String, core.Object> buildUnnamed225() {
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

void checkUnnamed225(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted46 = (o['x']!) as core.Map;
  unittest.expect(casted46, unittest.hasLength(3));
  unittest.expect(
    casted46['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted46['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted46['string'],
    unittest.equals('foo'),
  );
  var casted47 = (o['y']!) as core.Map;
  unittest.expect(casted47, unittest.hasLength(3));
  unittest.expect(
    casted47['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted47['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted47['string'],
    unittest.equals('foo'),
  );
}

core.int
    buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageConversationSuccess =
    0;
api.GoogleCloudDialogflowCxV3beta1ResponseMessageConversationSuccess
    buildGoogleCloudDialogflowCxV3beta1ResponseMessageConversationSuccess() {
  var o =
      api.GoogleCloudDialogflowCxV3beta1ResponseMessageConversationSuccess();
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageConversationSuccess++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageConversationSuccess <
      3) {
    o.metadata = buildUnnamed225();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageConversationSuccess--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ResponseMessageConversationSuccess(
    api.GoogleCloudDialogflowCxV3beta1ResponseMessageConversationSuccess o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageConversationSuccess++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageConversationSuccess <
      3) {
    checkUnnamed225(o.metadata!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageConversationSuccess--;
}

core.int
    buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageEndInteraction = 0;
api.GoogleCloudDialogflowCxV3beta1ResponseMessageEndInteraction
    buildGoogleCloudDialogflowCxV3beta1ResponseMessageEndInteraction() {
  var o = api.GoogleCloudDialogflowCxV3beta1ResponseMessageEndInteraction();
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageEndInteraction++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageEndInteraction <
      3) {}
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageEndInteraction--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ResponseMessageEndInteraction(
    api.GoogleCloudDialogflowCxV3beta1ResponseMessageEndInteraction o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageEndInteraction++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageEndInteraction <
      3) {}
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageEndInteraction--;
}

core.Map<core.String, core.Object> buildUnnamed226() {
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

void checkUnnamed226(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted48 = (o['x']!) as core.Map;
  unittest.expect(casted48, unittest.hasLength(3));
  unittest.expect(
    casted48['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted48['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted48['string'],
    unittest.equals('foo'),
  );
  var casted49 = (o['y']!) as core.Map;
  unittest.expect(casted49, unittest.hasLength(3));
  unittest.expect(
    casted49['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted49['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted49['string'],
    unittest.equals('foo'),
  );
}

core.int
    buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff =
    0;
api.GoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff
    buildGoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff() {
  var o = api.GoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff();
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff <
      3) {
    o.metadata = buildUnnamed226();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff(
    api.GoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff <
      3) {
    checkUnnamed226(o.metadata!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff--;
}

core.List<api.GoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment>
    buildUnnamed227() {
  var o =
      <api.GoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment());
  o.add(buildGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment());
  return o;
}

void checkUnnamed227(
    core.List<
            api.GoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment(o[0]
      as api.GoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment);
  checkGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment(o[1]
      as api.GoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment);
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudio =
    0;
api.GoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudio
    buildGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudio() {
  var o = api.GoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudio();
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudio++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudio < 3) {
    o.segments = buildUnnamed227();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudio--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudio(
    api.GoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudio o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudio++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudio < 3) {
    checkUnnamed227(o.segments!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudio--;
}

core.int
    buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment =
    0;
api.GoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment
    buildGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment() {
  var o = api.GoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment();
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment <
      3) {
    o.allowPlaybackInterruption = true;
    o.audio = 'foo';
    o.uri = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment(
    api.GoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment <
      3) {
    unittest.expect(o.allowPlaybackInterruption!, unittest.isTrue);
    unittest.expect(
      o.audio!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment--;
}

core.int
    buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageOutputAudioText =
    0;
api.GoogleCloudDialogflowCxV3beta1ResponseMessageOutputAudioText
    buildGoogleCloudDialogflowCxV3beta1ResponseMessageOutputAudioText() {
  var o = api.GoogleCloudDialogflowCxV3beta1ResponseMessageOutputAudioText();
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageOutputAudioText++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageOutputAudioText <
      3) {
    o.allowPlaybackInterruption = true;
    o.ssml = 'foo';
    o.text = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageOutputAudioText--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ResponseMessageOutputAudioText(
    api.GoogleCloudDialogflowCxV3beta1ResponseMessageOutputAudioText o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageOutputAudioText++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageOutputAudioText <
      3) {
    unittest.expect(o.allowPlaybackInterruption!, unittest.isTrue);
    unittest.expect(
      o.ssml!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageOutputAudioText--;
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessagePlayAudio = 0;
api.GoogleCloudDialogflowCxV3beta1ResponseMessagePlayAudio
    buildGoogleCloudDialogflowCxV3beta1ResponseMessagePlayAudio() {
  var o = api.GoogleCloudDialogflowCxV3beta1ResponseMessagePlayAudio();
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessagePlayAudio++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessagePlayAudio < 3) {
    o.allowPlaybackInterruption = true;
    o.audioUri = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessagePlayAudio--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ResponseMessagePlayAudio(
    api.GoogleCloudDialogflowCxV3beta1ResponseMessagePlayAudio o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessagePlayAudio++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessagePlayAudio < 3) {
    unittest.expect(o.allowPlaybackInterruption!, unittest.isTrue);
    unittest.expect(
      o.audioUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessagePlayAudio--;
}

core.List<core.String> buildUnnamed228() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed228(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageText = 0;
api.GoogleCloudDialogflowCxV3beta1ResponseMessageText
    buildGoogleCloudDialogflowCxV3beta1ResponseMessageText() {
  var o = api.GoogleCloudDialogflowCxV3beta1ResponseMessageText();
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageText++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageText < 3) {
    o.allowPlaybackInterruption = true;
    o.text = buildUnnamed228();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageText--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ResponseMessageText(
    api.GoogleCloudDialogflowCxV3beta1ResponseMessageText o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageText++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageText < 3) {
    unittest.expect(o.allowPlaybackInterruption!, unittest.isTrue);
    checkUnnamed228(o.text!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageText--;
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1RunTestCaseMetadata = 0;
api.GoogleCloudDialogflowCxV3beta1RunTestCaseMetadata
    buildGoogleCloudDialogflowCxV3beta1RunTestCaseMetadata() {
  var o = api.GoogleCloudDialogflowCxV3beta1RunTestCaseMetadata();
  buildCounterGoogleCloudDialogflowCxV3beta1RunTestCaseMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1RunTestCaseMetadata < 3) {}
  buildCounterGoogleCloudDialogflowCxV3beta1RunTestCaseMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1RunTestCaseMetadata(
    api.GoogleCloudDialogflowCxV3beta1RunTestCaseMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3beta1RunTestCaseMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1RunTestCaseMetadata < 3) {}
  buildCounterGoogleCloudDialogflowCxV3beta1RunTestCaseMetadata--;
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1RunTestCaseResponse = 0;
api.GoogleCloudDialogflowCxV3beta1RunTestCaseResponse
    buildGoogleCloudDialogflowCxV3beta1RunTestCaseResponse() {
  var o = api.GoogleCloudDialogflowCxV3beta1RunTestCaseResponse();
  buildCounterGoogleCloudDialogflowCxV3beta1RunTestCaseResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1RunTestCaseResponse < 3) {
    o.result = buildGoogleCloudDialogflowCxV3beta1TestCaseResult();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1RunTestCaseResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1RunTestCaseResponse(
    api.GoogleCloudDialogflowCxV3beta1RunTestCaseResponse o) {
  buildCounterGoogleCloudDialogflowCxV3beta1RunTestCaseResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1RunTestCaseResponse < 3) {
    checkGoogleCloudDialogflowCxV3beta1TestCaseResult(
        o.result! as api.GoogleCloudDialogflowCxV3beta1TestCaseResult);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1RunTestCaseResponse--;
}

core.Map<core.String, core.Object> buildUnnamed229() {
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

void checkUnnamed229(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted50 = (o['x']!) as core.Map;
  unittest.expect(casted50, unittest.hasLength(3));
  unittest.expect(
    casted50['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted50['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted50['string'],
    unittest.equals('foo'),
  );
  var casted51 = (o['y']!) as core.Map;
  unittest.expect(casted51, unittest.hasLength(3));
  unittest.expect(
    casted51['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted51['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted51['string'],
    unittest.equals('foo'),
  );
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1SessionInfo = 0;
api.GoogleCloudDialogflowCxV3beta1SessionInfo
    buildGoogleCloudDialogflowCxV3beta1SessionInfo() {
  var o = api.GoogleCloudDialogflowCxV3beta1SessionInfo();
  buildCounterGoogleCloudDialogflowCxV3beta1SessionInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1SessionInfo < 3) {
    o.parameters = buildUnnamed229();
    o.session = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3beta1SessionInfo--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1SessionInfo(
    api.GoogleCloudDialogflowCxV3beta1SessionInfo o) {
  buildCounterGoogleCloudDialogflowCxV3beta1SessionInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1SessionInfo < 3) {
    checkUnnamed229(o.parameters!);
    unittest.expect(
      o.session!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1SessionInfo--;
}

core.List<core.String> buildUnnamed230() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed230(core.List<core.String> o) {
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

core.List<api.GoogleCloudDialogflowCxV3beta1ConversationTurn>
    buildUnnamed231() {
  var o = <api.GoogleCloudDialogflowCxV3beta1ConversationTurn>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1ConversationTurn());
  o.add(buildGoogleCloudDialogflowCxV3beta1ConversationTurn());
  return o;
}

void checkUnnamed231(
    core.List<api.GoogleCloudDialogflowCxV3beta1ConversationTurn> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1ConversationTurn(
      o[0] as api.GoogleCloudDialogflowCxV3beta1ConversationTurn);
  checkGoogleCloudDialogflowCxV3beta1ConversationTurn(
      o[1] as api.GoogleCloudDialogflowCxV3beta1ConversationTurn);
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1TestCase = 0;
api.GoogleCloudDialogflowCxV3beta1TestCase
    buildGoogleCloudDialogflowCxV3beta1TestCase() {
  var o = api.GoogleCloudDialogflowCxV3beta1TestCase();
  buildCounterGoogleCloudDialogflowCxV3beta1TestCase++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1TestCase < 3) {
    o.creationTime = 'foo';
    o.displayName = 'foo';
    o.lastTestResult = buildGoogleCloudDialogflowCxV3beta1TestCaseResult();
    o.name = 'foo';
    o.notes = 'foo';
    o.tags = buildUnnamed230();
    o.testCaseConversationTurns = buildUnnamed231();
    o.testConfig = buildGoogleCloudDialogflowCxV3beta1TestConfig();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1TestCase--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1TestCase(
    api.GoogleCloudDialogflowCxV3beta1TestCase o) {
  buildCounterGoogleCloudDialogflowCxV3beta1TestCase++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1TestCase < 3) {
    unittest.expect(
      o.creationTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3beta1TestCaseResult(
        o.lastTestResult! as api.GoogleCloudDialogflowCxV3beta1TestCaseResult);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.notes!,
      unittest.equals('foo'),
    );
    checkUnnamed230(o.tags!);
    checkUnnamed231(o.testCaseConversationTurns!);
    checkGoogleCloudDialogflowCxV3beta1TestConfig(
        o.testConfig! as api.GoogleCloudDialogflowCxV3beta1TestConfig);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1TestCase--;
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1TestCaseError = 0;
api.GoogleCloudDialogflowCxV3beta1TestCaseError
    buildGoogleCloudDialogflowCxV3beta1TestCaseError() {
  var o = api.GoogleCloudDialogflowCxV3beta1TestCaseError();
  buildCounterGoogleCloudDialogflowCxV3beta1TestCaseError++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1TestCaseError < 3) {
    o.status = buildGoogleRpcStatus();
    o.testCase = buildGoogleCloudDialogflowCxV3beta1TestCase();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1TestCaseError--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1TestCaseError(
    api.GoogleCloudDialogflowCxV3beta1TestCaseError o) {
  buildCounterGoogleCloudDialogflowCxV3beta1TestCaseError++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1TestCaseError < 3) {
    checkGoogleRpcStatus(o.status! as api.GoogleRpcStatus);
    checkGoogleCloudDialogflowCxV3beta1TestCase(
        o.testCase! as api.GoogleCloudDialogflowCxV3beta1TestCase);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1TestCaseError--;
}

core.List<api.GoogleCloudDialogflowCxV3beta1ConversationTurn>
    buildUnnamed232() {
  var o = <api.GoogleCloudDialogflowCxV3beta1ConversationTurn>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1ConversationTurn());
  o.add(buildGoogleCloudDialogflowCxV3beta1ConversationTurn());
  return o;
}

void checkUnnamed232(
    core.List<api.GoogleCloudDialogflowCxV3beta1ConversationTurn> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1ConversationTurn(
      o[0] as api.GoogleCloudDialogflowCxV3beta1ConversationTurn);
  checkGoogleCloudDialogflowCxV3beta1ConversationTurn(
      o[1] as api.GoogleCloudDialogflowCxV3beta1ConversationTurn);
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1TestCaseResult = 0;
api.GoogleCloudDialogflowCxV3beta1TestCaseResult
    buildGoogleCloudDialogflowCxV3beta1TestCaseResult() {
  var o = api.GoogleCloudDialogflowCxV3beta1TestCaseResult();
  buildCounterGoogleCloudDialogflowCxV3beta1TestCaseResult++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1TestCaseResult < 3) {
    o.conversationTurns = buildUnnamed232();
    o.environment = 'foo';
    o.name = 'foo';
    o.testResult = 'foo';
    o.testTime = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3beta1TestCaseResult--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1TestCaseResult(
    api.GoogleCloudDialogflowCxV3beta1TestCaseResult o) {
  buildCounterGoogleCloudDialogflowCxV3beta1TestCaseResult++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1TestCaseResult < 3) {
    checkUnnamed232(o.conversationTurns!);
    unittest.expect(
      o.environment!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.testResult!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.testTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1TestCaseResult--;
}

core.List<core.String> buildUnnamed233() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed233(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowCxV3beta1TestConfig = 0;
api.GoogleCloudDialogflowCxV3beta1TestConfig
    buildGoogleCloudDialogflowCxV3beta1TestConfig() {
  var o = api.GoogleCloudDialogflowCxV3beta1TestConfig();
  buildCounterGoogleCloudDialogflowCxV3beta1TestConfig++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1TestConfig < 3) {
    o.flow = 'foo';
    o.trackingParameters = buildUnnamed233();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1TestConfig--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1TestConfig(
    api.GoogleCloudDialogflowCxV3beta1TestConfig o) {
  buildCounterGoogleCloudDialogflowCxV3beta1TestConfig++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1TestConfig < 3) {
    unittest.expect(
      o.flow!,
      unittest.equals('foo'),
    );
    checkUnnamed233(o.trackingParameters!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1TestConfig--;
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1TestError = 0;
api.GoogleCloudDialogflowCxV3beta1TestError
    buildGoogleCloudDialogflowCxV3beta1TestError() {
  var o = api.GoogleCloudDialogflowCxV3beta1TestError();
  buildCounterGoogleCloudDialogflowCxV3beta1TestError++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1TestError < 3) {
    o.status = buildGoogleRpcStatus();
    o.testCase = 'foo';
    o.testTime = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3beta1TestError--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1TestError(
    api.GoogleCloudDialogflowCxV3beta1TestError o) {
  buildCounterGoogleCloudDialogflowCxV3beta1TestError++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1TestError < 3) {
    checkGoogleRpcStatus(o.status! as api.GoogleRpcStatus);
    unittest.expect(
      o.testCase!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.testTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1TestError--;
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1TestRunDifference = 0;
api.GoogleCloudDialogflowCxV3beta1TestRunDifference
    buildGoogleCloudDialogflowCxV3beta1TestRunDifference() {
  var o = api.GoogleCloudDialogflowCxV3beta1TestRunDifference();
  buildCounterGoogleCloudDialogflowCxV3beta1TestRunDifference++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1TestRunDifference < 3) {
    o.description = 'foo';
    o.type = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3beta1TestRunDifference--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1TestRunDifference(
    api.GoogleCloudDialogflowCxV3beta1TestRunDifference o) {
  buildCounterGoogleCloudDialogflowCxV3beta1TestRunDifference++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1TestRunDifference < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1TestRunDifference--;
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1TextInput = 0;
api.GoogleCloudDialogflowCxV3beta1TextInput
    buildGoogleCloudDialogflowCxV3beta1TextInput() {
  var o = api.GoogleCloudDialogflowCxV3beta1TextInput();
  buildCounterGoogleCloudDialogflowCxV3beta1TextInput++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1TextInput < 3) {
    o.text = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3beta1TextInput--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1TextInput(
    api.GoogleCloudDialogflowCxV3beta1TextInput o) {
  buildCounterGoogleCloudDialogflowCxV3beta1TextInput++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1TextInput < 3) {
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1TextInput--;
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1TransitionRoute = 0;
api.GoogleCloudDialogflowCxV3beta1TransitionRoute
    buildGoogleCloudDialogflowCxV3beta1TransitionRoute() {
  var o = api.GoogleCloudDialogflowCxV3beta1TransitionRoute();
  buildCounterGoogleCloudDialogflowCxV3beta1TransitionRoute++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1TransitionRoute < 3) {
    o.condition = 'foo';
    o.intent = 'foo';
    o.name = 'foo';
    o.targetFlow = 'foo';
    o.targetPage = 'foo';
    o.triggerFulfillment = buildGoogleCloudDialogflowCxV3beta1Fulfillment();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1TransitionRoute--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1TransitionRoute(
    api.GoogleCloudDialogflowCxV3beta1TransitionRoute o) {
  buildCounterGoogleCloudDialogflowCxV3beta1TransitionRoute++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1TransitionRoute < 3) {
    unittest.expect(
      o.condition!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.intent!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.targetFlow!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.targetPage!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3beta1Fulfillment(
        o.triggerFulfillment! as api.GoogleCloudDialogflowCxV3beta1Fulfillment);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1TransitionRoute--;
}

core.int
    buildCounterGoogleCloudDialogflowCxV3beta1UpdateDocumentOperationMetadata =
    0;
api.GoogleCloudDialogflowCxV3beta1UpdateDocumentOperationMetadata
    buildGoogleCloudDialogflowCxV3beta1UpdateDocumentOperationMetadata() {
  var o = api.GoogleCloudDialogflowCxV3beta1UpdateDocumentOperationMetadata();
  buildCounterGoogleCloudDialogflowCxV3beta1UpdateDocumentOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1UpdateDocumentOperationMetadata <
      3) {
    o.genericMetadata =
        buildGoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1UpdateDocumentOperationMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1UpdateDocumentOperationMetadata(
    api.GoogleCloudDialogflowCxV3beta1UpdateDocumentOperationMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3beta1UpdateDocumentOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1UpdateDocumentOperationMetadata <
      3) {
    checkGoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata(o
            .genericMetadata!
        as api.GoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1UpdateDocumentOperationMetadata--;
}

core.List<api.GoogleCloudDialogflowCxV3beta1ResponseMessage> buildUnnamed234() {
  var o = <api.GoogleCloudDialogflowCxV3beta1ResponseMessage>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1ResponseMessage());
  o.add(buildGoogleCloudDialogflowCxV3beta1ResponseMessage());
  return o;
}

void checkUnnamed234(
    core.List<api.GoogleCloudDialogflowCxV3beta1ResponseMessage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1ResponseMessage(
      o[0] as api.GoogleCloudDialogflowCxV3beta1ResponseMessage);
  checkGoogleCloudDialogflowCxV3beta1ResponseMessage(
      o[1] as api.GoogleCloudDialogflowCxV3beta1ResponseMessage);
}

core.Map<core.String, core.Object> buildUnnamed235() {
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

void checkUnnamed235(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted52 = (o['x']!) as core.Map;
  unittest.expect(casted52, unittest.hasLength(3));
  unittest.expect(
    casted52['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted52['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted52['string'],
    unittest.equals('foo'),
  );
  var casted53 = (o['y']!) as core.Map;
  unittest.expect(casted53, unittest.hasLength(3));
  unittest.expect(
    casted53['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted53['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted53['string'],
    unittest.equals('foo'),
  );
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequest = 0;
api.GoogleCloudDialogflowCxV3beta1WebhookRequest
    buildGoogleCloudDialogflowCxV3beta1WebhookRequest() {
  var o = api.GoogleCloudDialogflowCxV3beta1WebhookRequest();
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequest < 3) {
    o.detectIntentResponseId = 'foo';
    o.fulfillmentInfo =
        buildGoogleCloudDialogflowCxV3beta1WebhookRequestFulfillmentInfo();
    o.intentInfo =
        buildGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfo();
    o.messages = buildUnnamed234();
    o.pageInfo = buildGoogleCloudDialogflowCxV3beta1PageInfo();
    o.payload = buildUnnamed235();
    o.sentimentAnalysisResult =
        buildGoogleCloudDialogflowCxV3beta1WebhookRequestSentimentAnalysisResult();
    o.sessionInfo = buildGoogleCloudDialogflowCxV3beta1SessionInfo();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequest--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1WebhookRequest(
    api.GoogleCloudDialogflowCxV3beta1WebhookRequest o) {
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequest++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequest < 3) {
    unittest.expect(
      o.detectIntentResponseId!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowCxV3beta1WebhookRequestFulfillmentInfo(
        o.fulfillmentInfo!
            as api.GoogleCloudDialogflowCxV3beta1WebhookRequestFulfillmentInfo);
    checkGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfo(o.intentInfo!
        as api.GoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfo);
    checkUnnamed234(o.messages!);
    checkGoogleCloudDialogflowCxV3beta1PageInfo(
        o.pageInfo! as api.GoogleCloudDialogflowCxV3beta1PageInfo);
    checkUnnamed235(o.payload!);
    checkGoogleCloudDialogflowCxV3beta1WebhookRequestSentimentAnalysisResult(
        o.sentimentAnalysisResult! as api
            .GoogleCloudDialogflowCxV3beta1WebhookRequestSentimentAnalysisResult);
    checkGoogleCloudDialogflowCxV3beta1SessionInfo(
        o.sessionInfo! as api.GoogleCloudDialogflowCxV3beta1SessionInfo);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequest--;
}

core.int
    buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestFulfillmentInfo = 0;
api.GoogleCloudDialogflowCxV3beta1WebhookRequestFulfillmentInfo
    buildGoogleCloudDialogflowCxV3beta1WebhookRequestFulfillmentInfo() {
  var o = api.GoogleCloudDialogflowCxV3beta1WebhookRequestFulfillmentInfo();
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestFulfillmentInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestFulfillmentInfo <
      3) {
    o.tag = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestFulfillmentInfo--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1WebhookRequestFulfillmentInfo(
    api.GoogleCloudDialogflowCxV3beta1WebhookRequestFulfillmentInfo o) {
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestFulfillmentInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestFulfillmentInfo <
      3) {
    unittest.expect(
      o.tag!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestFulfillmentInfo--;
}

core.Map<core.String,
        api.GoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue>
    buildUnnamed236() {
  var o = <core.String,
      api.GoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue>{};
  o['x'] =
      buildGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue();
  o['y'] =
      buildGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue();
  return o;
}

void checkUnnamed236(
    core.Map<core.String,
            api.GoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue(
      o['x']! as api
          .GoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue);
  checkGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue(
      o['y']! as api
          .GoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue);
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfo = 0;
api.GoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfo
    buildGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfo() {
  var o = api.GoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfo();
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfo < 3) {
    o.confidence = 42.0;
    o.displayName = 'foo';
    o.lastMatchedIntent = 'foo';
    o.parameters = buildUnnamed236();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfo--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfo(
    api.GoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfo o) {
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfo < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.lastMatchedIntent!,
      unittest.equals('foo'),
    );
    checkUnnamed236(o.parameters!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfo--;
}

core.int
    buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue =
    0;
api.GoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue
    buildGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue() {
  var o = api
      .GoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue();
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue <
      3) {
    o.originalValue = 'foo';
    o.resolvedValue = {
      'list': [1, 2, 3],
      'bool': true,
      'string': 'foo'
    };
  }
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue(
    api.GoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue
        o) {
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue <
      3) {
    unittest.expect(
      o.originalValue!,
      unittest.equals('foo'),
    );
    var casted54 = (o.resolvedValue!) as core.Map;
    unittest.expect(casted54, unittest.hasLength(3));
    unittest.expect(
      casted54['list'],
      unittest.equals([1, 2, 3]),
    );
    unittest.expect(
      casted54['bool'],
      unittest.equals(true),
    );
    unittest.expect(
      casted54['string'],
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue--;
}

core.int
    buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestSentimentAnalysisResult =
    0;
api.GoogleCloudDialogflowCxV3beta1WebhookRequestSentimentAnalysisResult
    buildGoogleCloudDialogflowCxV3beta1WebhookRequestSentimentAnalysisResult() {
  var o =
      api.GoogleCloudDialogflowCxV3beta1WebhookRequestSentimentAnalysisResult();
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestSentimentAnalysisResult++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestSentimentAnalysisResult <
      3) {
    o.magnitude = 42.0;
    o.score = 42.0;
  }
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestSentimentAnalysisResult--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1WebhookRequestSentimentAnalysisResult(
    api.GoogleCloudDialogflowCxV3beta1WebhookRequestSentimentAnalysisResult o) {
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestSentimentAnalysisResult++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestSentimentAnalysisResult <
      3) {
    unittest.expect(
      o.magnitude!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookRequestSentimentAnalysisResult--;
}

core.Map<core.String, core.Object> buildUnnamed237() {
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

void checkUnnamed237(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted55 = (o['x']!) as core.Map;
  unittest.expect(casted55, unittest.hasLength(3));
  unittest.expect(
    casted55['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted55['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted55['string'],
    unittest.equals('foo'),
  );
  var casted56 = (o['y']!) as core.Map;
  unittest.expect(casted56, unittest.hasLength(3));
  unittest.expect(
    casted56['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted56['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted56['string'],
    unittest.equals('foo'),
  );
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1WebhookResponse = 0;
api.GoogleCloudDialogflowCxV3beta1WebhookResponse
    buildGoogleCloudDialogflowCxV3beta1WebhookResponse() {
  var o = api.GoogleCloudDialogflowCxV3beta1WebhookResponse();
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1WebhookResponse < 3) {
    o.fulfillmentResponse =
        buildGoogleCloudDialogflowCxV3beta1WebhookResponseFulfillmentResponse();
    o.pageInfo = buildGoogleCloudDialogflowCxV3beta1PageInfo();
    o.payload = buildUnnamed237();
    o.sessionInfo = buildGoogleCloudDialogflowCxV3beta1SessionInfo();
    o.targetFlow = 'foo';
    o.targetPage = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1WebhookResponse(
    api.GoogleCloudDialogflowCxV3beta1WebhookResponse o) {
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1WebhookResponse < 3) {
    checkGoogleCloudDialogflowCxV3beta1WebhookResponseFulfillmentResponse(
        o.fulfillmentResponse! as api
            .GoogleCloudDialogflowCxV3beta1WebhookResponseFulfillmentResponse);
    checkGoogleCloudDialogflowCxV3beta1PageInfo(
        o.pageInfo! as api.GoogleCloudDialogflowCxV3beta1PageInfo);
    checkUnnamed237(o.payload!);
    checkGoogleCloudDialogflowCxV3beta1SessionInfo(
        o.sessionInfo! as api.GoogleCloudDialogflowCxV3beta1SessionInfo);
    unittest.expect(
      o.targetFlow!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.targetPage!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookResponse--;
}

core.List<api.GoogleCloudDialogflowCxV3beta1ResponseMessage> buildUnnamed238() {
  var o = <api.GoogleCloudDialogflowCxV3beta1ResponseMessage>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1ResponseMessage());
  o.add(buildGoogleCloudDialogflowCxV3beta1ResponseMessage());
  return o;
}

void checkUnnamed238(
    core.List<api.GoogleCloudDialogflowCxV3beta1ResponseMessage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1ResponseMessage(
      o[0] as api.GoogleCloudDialogflowCxV3beta1ResponseMessage);
  checkGoogleCloudDialogflowCxV3beta1ResponseMessage(
      o[1] as api.GoogleCloudDialogflowCxV3beta1ResponseMessage);
}

core.int
    buildCounterGoogleCloudDialogflowCxV3beta1WebhookResponseFulfillmentResponse =
    0;
api.GoogleCloudDialogflowCxV3beta1WebhookResponseFulfillmentResponse
    buildGoogleCloudDialogflowCxV3beta1WebhookResponseFulfillmentResponse() {
  var o =
      api.GoogleCloudDialogflowCxV3beta1WebhookResponseFulfillmentResponse();
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookResponseFulfillmentResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1WebhookResponseFulfillmentResponse <
      3) {
    o.mergeBehavior = 'foo';
    o.messages = buildUnnamed238();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookResponseFulfillmentResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1WebhookResponseFulfillmentResponse(
    api.GoogleCloudDialogflowCxV3beta1WebhookResponseFulfillmentResponse o) {
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookResponseFulfillmentResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1WebhookResponseFulfillmentResponse <
      3) {
    unittest.expect(
      o.mergeBehavior!,
      unittest.equals('foo'),
    );
    checkUnnamed238(o.messages!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookResponseFulfillmentResponse--;
}

core.int buildCounterGoogleCloudDialogflowV2AnnotatedMessagePart = 0;
api.GoogleCloudDialogflowV2AnnotatedMessagePart
    buildGoogleCloudDialogflowV2AnnotatedMessagePart() {
  var o = api.GoogleCloudDialogflowV2AnnotatedMessagePart();
  buildCounterGoogleCloudDialogflowV2AnnotatedMessagePart++;
  if (buildCounterGoogleCloudDialogflowV2AnnotatedMessagePart < 3) {
    o.entityType = 'foo';
    o.formattedValue = {
      'list': [1, 2, 3],
      'bool': true,
      'string': 'foo'
    };
    o.text = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2AnnotatedMessagePart--;
  return o;
}

void checkGoogleCloudDialogflowV2AnnotatedMessagePart(
    api.GoogleCloudDialogflowV2AnnotatedMessagePart o) {
  buildCounterGoogleCloudDialogflowV2AnnotatedMessagePart++;
  if (buildCounterGoogleCloudDialogflowV2AnnotatedMessagePart < 3) {
    unittest.expect(
      o.entityType!,
      unittest.equals('foo'),
    );
    var casted57 = (o.formattedValue!) as core.Map;
    unittest.expect(casted57, unittest.hasLength(3));
    unittest.expect(
      casted57['list'],
      unittest.equals([1, 2, 3]),
    );
    unittest.expect(
      casted57['bool'],
      unittest.equals(true),
    );
    unittest.expect(
      casted57['string'],
      unittest.equals('foo'),
    );
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2AnnotatedMessagePart--;
}

core.List<api.GoogleCloudDialogflowV2EntityType> buildUnnamed239() {
  var o = <api.GoogleCloudDialogflowV2EntityType>[];
  o.add(buildGoogleCloudDialogflowV2EntityType());
  o.add(buildGoogleCloudDialogflowV2EntityType());
  return o;
}

void checkUnnamed239(core.List<api.GoogleCloudDialogflowV2EntityType> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2EntityType(
      o[0] as api.GoogleCloudDialogflowV2EntityType);
  checkGoogleCloudDialogflowV2EntityType(
      o[1] as api.GoogleCloudDialogflowV2EntityType);
}

core.int buildCounterGoogleCloudDialogflowV2BatchUpdateEntityTypesResponse = 0;
api.GoogleCloudDialogflowV2BatchUpdateEntityTypesResponse
    buildGoogleCloudDialogflowV2BatchUpdateEntityTypesResponse() {
  var o = api.GoogleCloudDialogflowV2BatchUpdateEntityTypesResponse();
  buildCounterGoogleCloudDialogflowV2BatchUpdateEntityTypesResponse++;
  if (buildCounterGoogleCloudDialogflowV2BatchUpdateEntityTypesResponse < 3) {
    o.entityTypes = buildUnnamed239();
  }
  buildCounterGoogleCloudDialogflowV2BatchUpdateEntityTypesResponse--;
  return o;
}

void checkGoogleCloudDialogflowV2BatchUpdateEntityTypesResponse(
    api.GoogleCloudDialogflowV2BatchUpdateEntityTypesResponse o) {
  buildCounterGoogleCloudDialogflowV2BatchUpdateEntityTypesResponse++;
  if (buildCounterGoogleCloudDialogflowV2BatchUpdateEntityTypesResponse < 3) {
    checkUnnamed239(o.entityTypes!);
  }
  buildCounterGoogleCloudDialogflowV2BatchUpdateEntityTypesResponse--;
}

core.List<api.GoogleCloudDialogflowV2Intent> buildUnnamed240() {
  var o = <api.GoogleCloudDialogflowV2Intent>[];
  o.add(buildGoogleCloudDialogflowV2Intent());
  o.add(buildGoogleCloudDialogflowV2Intent());
  return o;
}

void checkUnnamed240(core.List<api.GoogleCloudDialogflowV2Intent> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2Intent(o[0] as api.GoogleCloudDialogflowV2Intent);
  checkGoogleCloudDialogflowV2Intent(o[1] as api.GoogleCloudDialogflowV2Intent);
}

core.int buildCounterGoogleCloudDialogflowV2BatchUpdateIntentsResponse = 0;
api.GoogleCloudDialogflowV2BatchUpdateIntentsResponse
    buildGoogleCloudDialogflowV2BatchUpdateIntentsResponse() {
  var o = api.GoogleCloudDialogflowV2BatchUpdateIntentsResponse();
  buildCounterGoogleCloudDialogflowV2BatchUpdateIntentsResponse++;
  if (buildCounterGoogleCloudDialogflowV2BatchUpdateIntentsResponse < 3) {
    o.intents = buildUnnamed240();
  }
  buildCounterGoogleCloudDialogflowV2BatchUpdateIntentsResponse--;
  return o;
}

void checkGoogleCloudDialogflowV2BatchUpdateIntentsResponse(
    api.GoogleCloudDialogflowV2BatchUpdateIntentsResponse o) {
  buildCounterGoogleCloudDialogflowV2BatchUpdateIntentsResponse++;
  if (buildCounterGoogleCloudDialogflowV2BatchUpdateIntentsResponse < 3) {
    checkUnnamed240(o.intents!);
  }
  buildCounterGoogleCloudDialogflowV2BatchUpdateIntentsResponse--;
}

core.Map<core.String, core.Object> buildUnnamed241() {
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

void checkUnnamed241(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted58 = (o['x']!) as core.Map;
  unittest.expect(casted58, unittest.hasLength(3));
  unittest.expect(
    casted58['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted58['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted58['string'],
    unittest.equals('foo'),
  );
  var casted59 = (o['y']!) as core.Map;
  unittest.expect(casted59, unittest.hasLength(3));
  unittest.expect(
    casted59['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted59['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted59['string'],
    unittest.equals('foo'),
  );
}

core.int buildCounterGoogleCloudDialogflowV2Context = 0;
api.GoogleCloudDialogflowV2Context buildGoogleCloudDialogflowV2Context() {
  var o = api.GoogleCloudDialogflowV2Context();
  buildCounterGoogleCloudDialogflowV2Context++;
  if (buildCounterGoogleCloudDialogflowV2Context < 3) {
    o.lifespanCount = 42;
    o.name = 'foo';
    o.parameters = buildUnnamed241();
  }
  buildCounterGoogleCloudDialogflowV2Context--;
  return o;
}

void checkGoogleCloudDialogflowV2Context(api.GoogleCloudDialogflowV2Context o) {
  buildCounterGoogleCloudDialogflowV2Context++;
  if (buildCounterGoogleCloudDialogflowV2Context < 3) {
    unittest.expect(
      o.lifespanCount!,
      unittest.equals(42),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed241(o.parameters!);
  }
  buildCounterGoogleCloudDialogflowV2Context--;
}

core.int buildCounterGoogleCloudDialogflowV2ConversationEvent = 0;
api.GoogleCloudDialogflowV2ConversationEvent
    buildGoogleCloudDialogflowV2ConversationEvent() {
  var o = api.GoogleCloudDialogflowV2ConversationEvent();
  buildCounterGoogleCloudDialogflowV2ConversationEvent++;
  if (buildCounterGoogleCloudDialogflowV2ConversationEvent < 3) {
    o.conversation = 'foo';
    o.errorStatus = buildGoogleRpcStatus();
    o.newMessagePayload = buildGoogleCloudDialogflowV2Message();
    o.type = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2ConversationEvent--;
  return o;
}

void checkGoogleCloudDialogflowV2ConversationEvent(
    api.GoogleCloudDialogflowV2ConversationEvent o) {
  buildCounterGoogleCloudDialogflowV2ConversationEvent++;
  if (buildCounterGoogleCloudDialogflowV2ConversationEvent < 3) {
    unittest.expect(
      o.conversation!,
      unittest.equals('foo'),
    );
    checkGoogleRpcStatus(o.errorStatus! as api.GoogleRpcStatus);
    checkGoogleCloudDialogflowV2Message(
        o.newMessagePayload! as api.GoogleCloudDialogflowV2Message);
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2ConversationEvent--;
}

core.List<api.GoogleCloudDialogflowV2EntityTypeEntity> buildUnnamed242() {
  var o = <api.GoogleCloudDialogflowV2EntityTypeEntity>[];
  o.add(buildGoogleCloudDialogflowV2EntityTypeEntity());
  o.add(buildGoogleCloudDialogflowV2EntityTypeEntity());
  return o;
}

void checkUnnamed242(core.List<api.GoogleCloudDialogflowV2EntityTypeEntity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2EntityTypeEntity(
      o[0] as api.GoogleCloudDialogflowV2EntityTypeEntity);
  checkGoogleCloudDialogflowV2EntityTypeEntity(
      o[1] as api.GoogleCloudDialogflowV2EntityTypeEntity);
}

core.int buildCounterGoogleCloudDialogflowV2EntityType = 0;
api.GoogleCloudDialogflowV2EntityType buildGoogleCloudDialogflowV2EntityType() {
  var o = api.GoogleCloudDialogflowV2EntityType();
  buildCounterGoogleCloudDialogflowV2EntityType++;
  if (buildCounterGoogleCloudDialogflowV2EntityType < 3) {
    o.autoExpansionMode = 'foo';
    o.displayName = 'foo';
    o.enableFuzzyExtraction = true;
    o.entities = buildUnnamed242();
    o.kind = 'foo';
    o.name = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2EntityType--;
  return o;
}

void checkGoogleCloudDialogflowV2EntityType(
    api.GoogleCloudDialogflowV2EntityType o) {
  buildCounterGoogleCloudDialogflowV2EntityType++;
  if (buildCounterGoogleCloudDialogflowV2EntityType < 3) {
    unittest.expect(
      o.autoExpansionMode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(o.enableFuzzyExtraction!, unittest.isTrue);
    checkUnnamed242(o.entities!);
    unittest.expect(
      o.kind!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2EntityType--;
}

core.List<core.String> buildUnnamed243() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed243(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowV2EntityTypeEntity = 0;
api.GoogleCloudDialogflowV2EntityTypeEntity
    buildGoogleCloudDialogflowV2EntityTypeEntity() {
  var o = api.GoogleCloudDialogflowV2EntityTypeEntity();
  buildCounterGoogleCloudDialogflowV2EntityTypeEntity++;
  if (buildCounterGoogleCloudDialogflowV2EntityTypeEntity < 3) {
    o.synonyms = buildUnnamed243();
    o.value = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2EntityTypeEntity--;
  return o;
}

void checkGoogleCloudDialogflowV2EntityTypeEntity(
    api.GoogleCloudDialogflowV2EntityTypeEntity o) {
  buildCounterGoogleCloudDialogflowV2EntityTypeEntity++;
  if (buildCounterGoogleCloudDialogflowV2EntityTypeEntity < 3) {
    checkUnnamed243(o.synonyms!);
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2EntityTypeEntity--;
}

core.Map<core.String, core.Object> buildUnnamed244() {
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

void checkUnnamed244(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted60 = (o['x']!) as core.Map;
  unittest.expect(casted60, unittest.hasLength(3));
  unittest.expect(
    casted60['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted60['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted60['string'],
    unittest.equals('foo'),
  );
  var casted61 = (o['y']!) as core.Map;
  unittest.expect(casted61, unittest.hasLength(3));
  unittest.expect(
    casted61['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted61['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted61['string'],
    unittest.equals('foo'),
  );
}

core.int buildCounterGoogleCloudDialogflowV2EventInput = 0;
api.GoogleCloudDialogflowV2EventInput buildGoogleCloudDialogflowV2EventInput() {
  var o = api.GoogleCloudDialogflowV2EventInput();
  buildCounterGoogleCloudDialogflowV2EventInput++;
  if (buildCounterGoogleCloudDialogflowV2EventInput < 3) {
    o.languageCode = 'foo';
    o.name = 'foo';
    o.parameters = buildUnnamed244();
  }
  buildCounterGoogleCloudDialogflowV2EventInput--;
  return o;
}

void checkGoogleCloudDialogflowV2EventInput(
    api.GoogleCloudDialogflowV2EventInput o) {
  buildCounterGoogleCloudDialogflowV2EventInput++;
  if (buildCounterGoogleCloudDialogflowV2EventInput < 3) {
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed244(o.parameters!);
  }
  buildCounterGoogleCloudDialogflowV2EventInput--;
}

core.int buildCounterGoogleCloudDialogflowV2ExportAgentResponse = 0;
api.GoogleCloudDialogflowV2ExportAgentResponse
    buildGoogleCloudDialogflowV2ExportAgentResponse() {
  var o = api.GoogleCloudDialogflowV2ExportAgentResponse();
  buildCounterGoogleCloudDialogflowV2ExportAgentResponse++;
  if (buildCounterGoogleCloudDialogflowV2ExportAgentResponse < 3) {
    o.agentContent = 'foo';
    o.agentUri = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2ExportAgentResponse--;
  return o;
}

void checkGoogleCloudDialogflowV2ExportAgentResponse(
    api.GoogleCloudDialogflowV2ExportAgentResponse o) {
  buildCounterGoogleCloudDialogflowV2ExportAgentResponse++;
  if (buildCounterGoogleCloudDialogflowV2ExportAgentResponse < 3) {
    unittest.expect(
      o.agentContent!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.agentUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2ExportAgentResponse--;
}

core.List<core.String> buildUnnamed245() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed245(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed246() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed246(core.List<core.String> o) {
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

core.List<api.GoogleCloudDialogflowV2IntentFollowupIntentInfo>
    buildUnnamed247() {
  var o = <api.GoogleCloudDialogflowV2IntentFollowupIntentInfo>[];
  o.add(buildGoogleCloudDialogflowV2IntentFollowupIntentInfo());
  o.add(buildGoogleCloudDialogflowV2IntentFollowupIntentInfo());
  return o;
}

void checkUnnamed247(
    core.List<api.GoogleCloudDialogflowV2IntentFollowupIntentInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentFollowupIntentInfo(
      o[0] as api.GoogleCloudDialogflowV2IntentFollowupIntentInfo);
  checkGoogleCloudDialogflowV2IntentFollowupIntentInfo(
      o[1] as api.GoogleCloudDialogflowV2IntentFollowupIntentInfo);
}

core.List<core.String> buildUnnamed248() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed248(core.List<core.String> o) {
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

core.List<api.GoogleCloudDialogflowV2IntentMessage> buildUnnamed249() {
  var o = <api.GoogleCloudDialogflowV2IntentMessage>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessage());
  o.add(buildGoogleCloudDialogflowV2IntentMessage());
  return o;
}

void checkUnnamed249(core.List<api.GoogleCloudDialogflowV2IntentMessage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentMessage(
      o[0] as api.GoogleCloudDialogflowV2IntentMessage);
  checkGoogleCloudDialogflowV2IntentMessage(
      o[1] as api.GoogleCloudDialogflowV2IntentMessage);
}

core.List<api.GoogleCloudDialogflowV2Context> buildUnnamed250() {
  var o = <api.GoogleCloudDialogflowV2Context>[];
  o.add(buildGoogleCloudDialogflowV2Context());
  o.add(buildGoogleCloudDialogflowV2Context());
  return o;
}

void checkUnnamed250(core.List<api.GoogleCloudDialogflowV2Context> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2Context(
      o[0] as api.GoogleCloudDialogflowV2Context);
  checkGoogleCloudDialogflowV2Context(
      o[1] as api.GoogleCloudDialogflowV2Context);
}

core.List<api.GoogleCloudDialogflowV2IntentParameter> buildUnnamed251() {
  var o = <api.GoogleCloudDialogflowV2IntentParameter>[];
  o.add(buildGoogleCloudDialogflowV2IntentParameter());
  o.add(buildGoogleCloudDialogflowV2IntentParameter());
  return o;
}

void checkUnnamed251(core.List<api.GoogleCloudDialogflowV2IntentParameter> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentParameter(
      o[0] as api.GoogleCloudDialogflowV2IntentParameter);
  checkGoogleCloudDialogflowV2IntentParameter(
      o[1] as api.GoogleCloudDialogflowV2IntentParameter);
}

core.List<api.GoogleCloudDialogflowV2IntentTrainingPhrase> buildUnnamed252() {
  var o = <api.GoogleCloudDialogflowV2IntentTrainingPhrase>[];
  o.add(buildGoogleCloudDialogflowV2IntentTrainingPhrase());
  o.add(buildGoogleCloudDialogflowV2IntentTrainingPhrase());
  return o;
}

void checkUnnamed252(
    core.List<api.GoogleCloudDialogflowV2IntentTrainingPhrase> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentTrainingPhrase(
      o[0] as api.GoogleCloudDialogflowV2IntentTrainingPhrase);
  checkGoogleCloudDialogflowV2IntentTrainingPhrase(
      o[1] as api.GoogleCloudDialogflowV2IntentTrainingPhrase);
}

core.int buildCounterGoogleCloudDialogflowV2Intent = 0;
api.GoogleCloudDialogflowV2Intent buildGoogleCloudDialogflowV2Intent() {
  var o = api.GoogleCloudDialogflowV2Intent();
  buildCounterGoogleCloudDialogflowV2Intent++;
  if (buildCounterGoogleCloudDialogflowV2Intent < 3) {
    o.action = 'foo';
    o.defaultResponsePlatforms = buildUnnamed245();
    o.displayName = 'foo';
    o.events = buildUnnamed246();
    o.followupIntentInfo = buildUnnamed247();
    o.inputContextNames = buildUnnamed248();
    o.isFallback = true;
    o.messages = buildUnnamed249();
    o.mlDisabled = true;
    o.name = 'foo';
    o.outputContexts = buildUnnamed250();
    o.parameters = buildUnnamed251();
    o.parentFollowupIntentName = 'foo';
    o.priority = 42;
    o.resetContexts = true;
    o.rootFollowupIntentName = 'foo';
    o.trainingPhrases = buildUnnamed252();
    o.webhookState = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2Intent--;
  return o;
}

void checkGoogleCloudDialogflowV2Intent(api.GoogleCloudDialogflowV2Intent o) {
  buildCounterGoogleCloudDialogflowV2Intent++;
  if (buildCounterGoogleCloudDialogflowV2Intent < 3) {
    unittest.expect(
      o.action!,
      unittest.equals('foo'),
    );
    checkUnnamed245(o.defaultResponsePlatforms!);
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    checkUnnamed246(o.events!);
    checkUnnamed247(o.followupIntentInfo!);
    checkUnnamed248(o.inputContextNames!);
    unittest.expect(o.isFallback!, unittest.isTrue);
    checkUnnamed249(o.messages!);
    unittest.expect(o.mlDisabled!, unittest.isTrue);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed250(o.outputContexts!);
    checkUnnamed251(o.parameters!);
    unittest.expect(
      o.parentFollowupIntentName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.priority!,
      unittest.equals(42),
    );
    unittest.expect(o.resetContexts!, unittest.isTrue);
    unittest.expect(
      o.rootFollowupIntentName!,
      unittest.equals('foo'),
    );
    checkUnnamed252(o.trainingPhrases!);
    unittest.expect(
      o.webhookState!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2Intent--;
}

core.int buildCounterGoogleCloudDialogflowV2IntentFollowupIntentInfo = 0;
api.GoogleCloudDialogflowV2IntentFollowupIntentInfo
    buildGoogleCloudDialogflowV2IntentFollowupIntentInfo() {
  var o = api.GoogleCloudDialogflowV2IntentFollowupIntentInfo();
  buildCounterGoogleCloudDialogflowV2IntentFollowupIntentInfo++;
  if (buildCounterGoogleCloudDialogflowV2IntentFollowupIntentInfo < 3) {
    o.followupIntentName = 'foo';
    o.parentFollowupIntentName = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2IntentFollowupIntentInfo--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentFollowupIntentInfo(
    api.GoogleCloudDialogflowV2IntentFollowupIntentInfo o) {
  buildCounterGoogleCloudDialogflowV2IntentFollowupIntentInfo++;
  if (buildCounterGoogleCloudDialogflowV2IntentFollowupIntentInfo < 3) {
    unittest.expect(
      o.followupIntentName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.parentFollowupIntentName!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2IntentFollowupIntentInfo--;
}

core.Map<core.String, core.Object> buildUnnamed253() {
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

void checkUnnamed253(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted62 = (o['x']!) as core.Map;
  unittest.expect(casted62, unittest.hasLength(3));
  unittest.expect(
    casted62['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted62['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted62['string'],
    unittest.equals('foo'),
  );
  var casted63 = (o['y']!) as core.Map;
  unittest.expect(casted63, unittest.hasLength(3));
  unittest.expect(
    casted63['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted63['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted63['string'],
    unittest.equals('foo'),
  );
}

core.int buildCounterGoogleCloudDialogflowV2IntentMessage = 0;
api.GoogleCloudDialogflowV2IntentMessage
    buildGoogleCloudDialogflowV2IntentMessage() {
  var o = api.GoogleCloudDialogflowV2IntentMessage();
  buildCounterGoogleCloudDialogflowV2IntentMessage++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessage < 3) {
    o.basicCard = buildGoogleCloudDialogflowV2IntentMessageBasicCard();
    o.browseCarouselCard =
        buildGoogleCloudDialogflowV2IntentMessageBrowseCarouselCard();
    o.card = buildGoogleCloudDialogflowV2IntentMessageCard();
    o.carouselSelect =
        buildGoogleCloudDialogflowV2IntentMessageCarouselSelect();
    o.image = buildGoogleCloudDialogflowV2IntentMessageImage();
    o.linkOutSuggestion =
        buildGoogleCloudDialogflowV2IntentMessageLinkOutSuggestion();
    o.listSelect = buildGoogleCloudDialogflowV2IntentMessageListSelect();
    o.mediaContent = buildGoogleCloudDialogflowV2IntentMessageMediaContent();
    o.payload = buildUnnamed253();
    o.platform = 'foo';
    o.quickReplies = buildGoogleCloudDialogflowV2IntentMessageQuickReplies();
    o.simpleResponses =
        buildGoogleCloudDialogflowV2IntentMessageSimpleResponses();
    o.suggestions = buildGoogleCloudDialogflowV2IntentMessageSuggestions();
    o.tableCard = buildGoogleCloudDialogflowV2IntentMessageTableCard();
    o.text = buildGoogleCloudDialogflowV2IntentMessageText();
  }
  buildCounterGoogleCloudDialogflowV2IntentMessage--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessage(
    api.GoogleCloudDialogflowV2IntentMessage o) {
  buildCounterGoogleCloudDialogflowV2IntentMessage++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessage < 3) {
    checkGoogleCloudDialogflowV2IntentMessageBasicCard(
        o.basicCard! as api.GoogleCloudDialogflowV2IntentMessageBasicCard);
    checkGoogleCloudDialogflowV2IntentMessageBrowseCarouselCard(
        o.browseCarouselCard!
            as api.GoogleCloudDialogflowV2IntentMessageBrowseCarouselCard);
    checkGoogleCloudDialogflowV2IntentMessageCard(
        o.card! as api.GoogleCloudDialogflowV2IntentMessageCard);
    checkGoogleCloudDialogflowV2IntentMessageCarouselSelect(o.carouselSelect!
        as api.GoogleCloudDialogflowV2IntentMessageCarouselSelect);
    checkGoogleCloudDialogflowV2IntentMessageImage(
        o.image! as api.GoogleCloudDialogflowV2IntentMessageImage);
    checkGoogleCloudDialogflowV2IntentMessageLinkOutSuggestion(
        o.linkOutSuggestion!
            as api.GoogleCloudDialogflowV2IntentMessageLinkOutSuggestion);
    checkGoogleCloudDialogflowV2IntentMessageListSelect(
        o.listSelect! as api.GoogleCloudDialogflowV2IntentMessageListSelect);
    checkGoogleCloudDialogflowV2IntentMessageMediaContent(o.mediaContent!
        as api.GoogleCloudDialogflowV2IntentMessageMediaContent);
    checkUnnamed253(o.payload!);
    unittest.expect(
      o.platform!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowV2IntentMessageQuickReplies(o.quickReplies!
        as api.GoogleCloudDialogflowV2IntentMessageQuickReplies);
    checkGoogleCloudDialogflowV2IntentMessageSimpleResponses(o.simpleResponses!
        as api.GoogleCloudDialogflowV2IntentMessageSimpleResponses);
    checkGoogleCloudDialogflowV2IntentMessageSuggestions(
        o.suggestions! as api.GoogleCloudDialogflowV2IntentMessageSuggestions);
    checkGoogleCloudDialogflowV2IntentMessageTableCard(
        o.tableCard! as api.GoogleCloudDialogflowV2IntentMessageTableCard);
    checkGoogleCloudDialogflowV2IntentMessageText(
        o.text! as api.GoogleCloudDialogflowV2IntentMessageText);
  }
  buildCounterGoogleCloudDialogflowV2IntentMessage--;
}

core.List<api.GoogleCloudDialogflowV2IntentMessageBasicCardButton>
    buildUnnamed254() {
  var o = <api.GoogleCloudDialogflowV2IntentMessageBasicCardButton>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessageBasicCardButton());
  o.add(buildGoogleCloudDialogflowV2IntentMessageBasicCardButton());
  return o;
}

void checkUnnamed254(
    core.List<api.GoogleCloudDialogflowV2IntentMessageBasicCardButton> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentMessageBasicCardButton(
      o[0] as api.GoogleCloudDialogflowV2IntentMessageBasicCardButton);
  checkGoogleCloudDialogflowV2IntentMessageBasicCardButton(
      o[1] as api.GoogleCloudDialogflowV2IntentMessageBasicCardButton);
}

core.int buildCounterGoogleCloudDialogflowV2IntentMessageBasicCard = 0;
api.GoogleCloudDialogflowV2IntentMessageBasicCard
    buildGoogleCloudDialogflowV2IntentMessageBasicCard() {
  var o = api.GoogleCloudDialogflowV2IntentMessageBasicCard();
  buildCounterGoogleCloudDialogflowV2IntentMessageBasicCard++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageBasicCard < 3) {
    o.buttons = buildUnnamed254();
    o.formattedText = 'foo';
    o.image = buildGoogleCloudDialogflowV2IntentMessageImage();
    o.subtitle = 'foo';
    o.title = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageBasicCard--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageBasicCard(
    api.GoogleCloudDialogflowV2IntentMessageBasicCard o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageBasicCard++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageBasicCard < 3) {
    checkUnnamed254(o.buttons!);
    unittest.expect(
      o.formattedText!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowV2IntentMessageImage(
        o.image! as api.GoogleCloudDialogflowV2IntentMessageImage);
    unittest.expect(
      o.subtitle!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageBasicCard--;
}

core.int buildCounterGoogleCloudDialogflowV2IntentMessageBasicCardButton = 0;
api.GoogleCloudDialogflowV2IntentMessageBasicCardButton
    buildGoogleCloudDialogflowV2IntentMessageBasicCardButton() {
  var o = api.GoogleCloudDialogflowV2IntentMessageBasicCardButton();
  buildCounterGoogleCloudDialogflowV2IntentMessageBasicCardButton++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageBasicCardButton < 3) {
    o.openUriAction =
        buildGoogleCloudDialogflowV2IntentMessageBasicCardButtonOpenUriAction();
    o.title = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageBasicCardButton--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageBasicCardButton(
    api.GoogleCloudDialogflowV2IntentMessageBasicCardButton o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageBasicCardButton++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageBasicCardButton < 3) {
    checkGoogleCloudDialogflowV2IntentMessageBasicCardButtonOpenUriAction(
        o.openUriAction! as api
            .GoogleCloudDialogflowV2IntentMessageBasicCardButtonOpenUriAction);
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageBasicCardButton--;
}

core.int
    buildCounterGoogleCloudDialogflowV2IntentMessageBasicCardButtonOpenUriAction =
    0;
api.GoogleCloudDialogflowV2IntentMessageBasicCardButtonOpenUriAction
    buildGoogleCloudDialogflowV2IntentMessageBasicCardButtonOpenUriAction() {
  var o =
      api.GoogleCloudDialogflowV2IntentMessageBasicCardButtonOpenUriAction();
  buildCounterGoogleCloudDialogflowV2IntentMessageBasicCardButtonOpenUriAction++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageBasicCardButtonOpenUriAction <
      3) {
    o.uri = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageBasicCardButtonOpenUriAction--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageBasicCardButtonOpenUriAction(
    api.GoogleCloudDialogflowV2IntentMessageBasicCardButtonOpenUriAction o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageBasicCardButtonOpenUriAction++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageBasicCardButtonOpenUriAction <
      3) {
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageBasicCardButtonOpenUriAction--;
}

core.List<
        api.GoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem>
    buildUnnamed255() {
  var o = <
      api.GoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem>[];
  o.add(
      buildGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem());
  o.add(
      buildGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem());
  return o;
}

void checkUnnamed255(
    core.List<
            api.GoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem(
      o[0] as api
          .GoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem);
  checkGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem(
      o[1] as api
          .GoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem);
}

core.int buildCounterGoogleCloudDialogflowV2IntentMessageBrowseCarouselCard = 0;
api.GoogleCloudDialogflowV2IntentMessageBrowseCarouselCard
    buildGoogleCloudDialogflowV2IntentMessageBrowseCarouselCard() {
  var o = api.GoogleCloudDialogflowV2IntentMessageBrowseCarouselCard();
  buildCounterGoogleCloudDialogflowV2IntentMessageBrowseCarouselCard++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageBrowseCarouselCard < 3) {
    o.imageDisplayOptions = 'foo';
    o.items = buildUnnamed255();
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageBrowseCarouselCard--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageBrowseCarouselCard(
    api.GoogleCloudDialogflowV2IntentMessageBrowseCarouselCard o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageBrowseCarouselCard++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageBrowseCarouselCard < 3) {
    unittest.expect(
      o.imageDisplayOptions!,
      unittest.equals('foo'),
    );
    checkUnnamed255(o.items!);
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageBrowseCarouselCard--;
}

core.int
    buildCounterGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem =
    0;
api.GoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem
    buildGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem() {
  var o = api
      .GoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem();
  buildCounterGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem <
      3) {
    o.description = 'foo';
    o.footer = 'foo';
    o.image = buildGoogleCloudDialogflowV2IntentMessageImage();
    o.openUriAction =
        buildGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction();
    o.title = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem(
    api.GoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem
        o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem <
      3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.footer!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowV2IntentMessageImage(
        o.image! as api.GoogleCloudDialogflowV2IntentMessageImage);
    checkGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction(
        o.openUriAction! as api
            .GoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction);
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem--;
}

core.int
    buildCounterGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction =
    0;
api.GoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction
    buildGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction() {
  var o = api
      .GoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction();
  buildCounterGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction <
      3) {
    o.url = 'foo';
    o.urlTypeHint = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction(
    api.GoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction
        o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction <
      3) {
    unittest.expect(
      o.url!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.urlTypeHint!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction--;
}

core.List<api.GoogleCloudDialogflowV2IntentMessageCardButton>
    buildUnnamed256() {
  var o = <api.GoogleCloudDialogflowV2IntentMessageCardButton>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessageCardButton());
  o.add(buildGoogleCloudDialogflowV2IntentMessageCardButton());
  return o;
}

void checkUnnamed256(
    core.List<api.GoogleCloudDialogflowV2IntentMessageCardButton> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentMessageCardButton(
      o[0] as api.GoogleCloudDialogflowV2IntentMessageCardButton);
  checkGoogleCloudDialogflowV2IntentMessageCardButton(
      o[1] as api.GoogleCloudDialogflowV2IntentMessageCardButton);
}

core.int buildCounterGoogleCloudDialogflowV2IntentMessageCard = 0;
api.GoogleCloudDialogflowV2IntentMessageCard
    buildGoogleCloudDialogflowV2IntentMessageCard() {
  var o = api.GoogleCloudDialogflowV2IntentMessageCard();
  buildCounterGoogleCloudDialogflowV2IntentMessageCard++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageCard < 3) {
    o.buttons = buildUnnamed256();
    o.imageUri = 'foo';
    o.subtitle = 'foo';
    o.title = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageCard--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageCard(
    api.GoogleCloudDialogflowV2IntentMessageCard o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageCard++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageCard < 3) {
    checkUnnamed256(o.buttons!);
    unittest.expect(
      o.imageUri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.subtitle!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageCard--;
}

core.int buildCounterGoogleCloudDialogflowV2IntentMessageCardButton = 0;
api.GoogleCloudDialogflowV2IntentMessageCardButton
    buildGoogleCloudDialogflowV2IntentMessageCardButton() {
  var o = api.GoogleCloudDialogflowV2IntentMessageCardButton();
  buildCounterGoogleCloudDialogflowV2IntentMessageCardButton++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageCardButton < 3) {
    o.postback = 'foo';
    o.text = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageCardButton--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageCardButton(
    api.GoogleCloudDialogflowV2IntentMessageCardButton o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageCardButton++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageCardButton < 3) {
    unittest.expect(
      o.postback!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageCardButton--;
}

core.List<api.GoogleCloudDialogflowV2IntentMessageCarouselSelectItem>
    buildUnnamed257() {
  var o = <api.GoogleCloudDialogflowV2IntentMessageCarouselSelectItem>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessageCarouselSelectItem());
  o.add(buildGoogleCloudDialogflowV2IntentMessageCarouselSelectItem());
  return o;
}

void checkUnnamed257(
    core.List<api.GoogleCloudDialogflowV2IntentMessageCarouselSelectItem> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentMessageCarouselSelectItem(
      o[0] as api.GoogleCloudDialogflowV2IntentMessageCarouselSelectItem);
  checkGoogleCloudDialogflowV2IntentMessageCarouselSelectItem(
      o[1] as api.GoogleCloudDialogflowV2IntentMessageCarouselSelectItem);
}

core.int buildCounterGoogleCloudDialogflowV2IntentMessageCarouselSelect = 0;
api.GoogleCloudDialogflowV2IntentMessageCarouselSelect
    buildGoogleCloudDialogflowV2IntentMessageCarouselSelect() {
  var o = api.GoogleCloudDialogflowV2IntentMessageCarouselSelect();
  buildCounterGoogleCloudDialogflowV2IntentMessageCarouselSelect++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageCarouselSelect < 3) {
    o.items = buildUnnamed257();
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageCarouselSelect--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageCarouselSelect(
    api.GoogleCloudDialogflowV2IntentMessageCarouselSelect o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageCarouselSelect++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageCarouselSelect < 3) {
    checkUnnamed257(o.items!);
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageCarouselSelect--;
}

core.int buildCounterGoogleCloudDialogflowV2IntentMessageCarouselSelectItem = 0;
api.GoogleCloudDialogflowV2IntentMessageCarouselSelectItem
    buildGoogleCloudDialogflowV2IntentMessageCarouselSelectItem() {
  var o = api.GoogleCloudDialogflowV2IntentMessageCarouselSelectItem();
  buildCounterGoogleCloudDialogflowV2IntentMessageCarouselSelectItem++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageCarouselSelectItem < 3) {
    o.description = 'foo';
    o.image = buildGoogleCloudDialogflowV2IntentMessageImage();
    o.info = buildGoogleCloudDialogflowV2IntentMessageSelectItemInfo();
    o.title = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageCarouselSelectItem--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageCarouselSelectItem(
    api.GoogleCloudDialogflowV2IntentMessageCarouselSelectItem o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageCarouselSelectItem++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageCarouselSelectItem < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowV2IntentMessageImage(
        o.image! as api.GoogleCloudDialogflowV2IntentMessageImage);
    checkGoogleCloudDialogflowV2IntentMessageSelectItemInfo(
        o.info! as api.GoogleCloudDialogflowV2IntentMessageSelectItemInfo);
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageCarouselSelectItem--;
}

core.int buildCounterGoogleCloudDialogflowV2IntentMessageColumnProperties = 0;
api.GoogleCloudDialogflowV2IntentMessageColumnProperties
    buildGoogleCloudDialogflowV2IntentMessageColumnProperties() {
  var o = api.GoogleCloudDialogflowV2IntentMessageColumnProperties();
  buildCounterGoogleCloudDialogflowV2IntentMessageColumnProperties++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageColumnProperties < 3) {
    o.header = 'foo';
    o.horizontalAlignment = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageColumnProperties--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageColumnProperties(
    api.GoogleCloudDialogflowV2IntentMessageColumnProperties o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageColumnProperties++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageColumnProperties < 3) {
    unittest.expect(
      o.header!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.horizontalAlignment!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageColumnProperties--;
}

core.int buildCounterGoogleCloudDialogflowV2IntentMessageImage = 0;
api.GoogleCloudDialogflowV2IntentMessageImage
    buildGoogleCloudDialogflowV2IntentMessageImage() {
  var o = api.GoogleCloudDialogflowV2IntentMessageImage();
  buildCounterGoogleCloudDialogflowV2IntentMessageImage++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageImage < 3) {
    o.accessibilityText = 'foo';
    o.imageUri = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageImage--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageImage(
    api.GoogleCloudDialogflowV2IntentMessageImage o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageImage++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageImage < 3) {
    unittest.expect(
      o.accessibilityText!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.imageUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageImage--;
}

core.int buildCounterGoogleCloudDialogflowV2IntentMessageLinkOutSuggestion = 0;
api.GoogleCloudDialogflowV2IntentMessageLinkOutSuggestion
    buildGoogleCloudDialogflowV2IntentMessageLinkOutSuggestion() {
  var o = api.GoogleCloudDialogflowV2IntentMessageLinkOutSuggestion();
  buildCounterGoogleCloudDialogflowV2IntentMessageLinkOutSuggestion++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageLinkOutSuggestion < 3) {
    o.destinationName = 'foo';
    o.uri = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageLinkOutSuggestion--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageLinkOutSuggestion(
    api.GoogleCloudDialogflowV2IntentMessageLinkOutSuggestion o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageLinkOutSuggestion++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageLinkOutSuggestion < 3) {
    unittest.expect(
      o.destinationName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageLinkOutSuggestion--;
}

core.List<api.GoogleCloudDialogflowV2IntentMessageListSelectItem>
    buildUnnamed258() {
  var o = <api.GoogleCloudDialogflowV2IntentMessageListSelectItem>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessageListSelectItem());
  o.add(buildGoogleCloudDialogflowV2IntentMessageListSelectItem());
  return o;
}

void checkUnnamed258(
    core.List<api.GoogleCloudDialogflowV2IntentMessageListSelectItem> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentMessageListSelectItem(
      o[0] as api.GoogleCloudDialogflowV2IntentMessageListSelectItem);
  checkGoogleCloudDialogflowV2IntentMessageListSelectItem(
      o[1] as api.GoogleCloudDialogflowV2IntentMessageListSelectItem);
}

core.int buildCounterGoogleCloudDialogflowV2IntentMessageListSelect = 0;
api.GoogleCloudDialogflowV2IntentMessageListSelect
    buildGoogleCloudDialogflowV2IntentMessageListSelect() {
  var o = api.GoogleCloudDialogflowV2IntentMessageListSelect();
  buildCounterGoogleCloudDialogflowV2IntentMessageListSelect++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageListSelect < 3) {
    o.items = buildUnnamed258();
    o.subtitle = 'foo';
    o.title = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageListSelect--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageListSelect(
    api.GoogleCloudDialogflowV2IntentMessageListSelect o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageListSelect++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageListSelect < 3) {
    checkUnnamed258(o.items!);
    unittest.expect(
      o.subtitle!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageListSelect--;
}

core.int buildCounterGoogleCloudDialogflowV2IntentMessageListSelectItem = 0;
api.GoogleCloudDialogflowV2IntentMessageListSelectItem
    buildGoogleCloudDialogflowV2IntentMessageListSelectItem() {
  var o = api.GoogleCloudDialogflowV2IntentMessageListSelectItem();
  buildCounterGoogleCloudDialogflowV2IntentMessageListSelectItem++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageListSelectItem < 3) {
    o.description = 'foo';
    o.image = buildGoogleCloudDialogflowV2IntentMessageImage();
    o.info = buildGoogleCloudDialogflowV2IntentMessageSelectItemInfo();
    o.title = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageListSelectItem--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageListSelectItem(
    api.GoogleCloudDialogflowV2IntentMessageListSelectItem o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageListSelectItem++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageListSelectItem < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowV2IntentMessageImage(
        o.image! as api.GoogleCloudDialogflowV2IntentMessageImage);
    checkGoogleCloudDialogflowV2IntentMessageSelectItemInfo(
        o.info! as api.GoogleCloudDialogflowV2IntentMessageSelectItemInfo);
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageListSelectItem--;
}

core.List<
        api.GoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject>
    buildUnnamed259() {
  var o = <
      api.GoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject>[];
  o.add(
      buildGoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject());
  o.add(
      buildGoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject());
  return o;
}

void checkUnnamed259(
    core.List<
            api.GoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject(o[0]
      as api
          .GoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject);
  checkGoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject(o[1]
      as api
          .GoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject);
}

core.int buildCounterGoogleCloudDialogflowV2IntentMessageMediaContent = 0;
api.GoogleCloudDialogflowV2IntentMessageMediaContent
    buildGoogleCloudDialogflowV2IntentMessageMediaContent() {
  var o = api.GoogleCloudDialogflowV2IntentMessageMediaContent();
  buildCounterGoogleCloudDialogflowV2IntentMessageMediaContent++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageMediaContent < 3) {
    o.mediaObjects = buildUnnamed259();
    o.mediaType = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageMediaContent--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageMediaContent(
    api.GoogleCloudDialogflowV2IntentMessageMediaContent o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageMediaContent++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageMediaContent < 3) {
    checkUnnamed259(o.mediaObjects!);
    unittest.expect(
      o.mediaType!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageMediaContent--;
}

core.int
    buildCounterGoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject =
    0;
api.GoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject
    buildGoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject() {
  var o =
      api.GoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject();
  buildCounterGoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject <
      3) {
    o.contentUrl = 'foo';
    o.description = 'foo';
    o.icon = buildGoogleCloudDialogflowV2IntentMessageImage();
    o.largeImage = buildGoogleCloudDialogflowV2IntentMessageImage();
    o.name = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject(
    api.GoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject <
      3) {
    unittest.expect(
      o.contentUrl!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowV2IntentMessageImage(
        o.icon! as api.GoogleCloudDialogflowV2IntentMessageImage);
    checkGoogleCloudDialogflowV2IntentMessageImage(
        o.largeImage! as api.GoogleCloudDialogflowV2IntentMessageImage);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject--;
}

core.List<core.String> buildUnnamed260() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed260(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowV2IntentMessageQuickReplies = 0;
api.GoogleCloudDialogflowV2IntentMessageQuickReplies
    buildGoogleCloudDialogflowV2IntentMessageQuickReplies() {
  var o = api.GoogleCloudDialogflowV2IntentMessageQuickReplies();
  buildCounterGoogleCloudDialogflowV2IntentMessageQuickReplies++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageQuickReplies < 3) {
    o.quickReplies = buildUnnamed260();
    o.title = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageQuickReplies--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageQuickReplies(
    api.GoogleCloudDialogflowV2IntentMessageQuickReplies o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageQuickReplies++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageQuickReplies < 3) {
    checkUnnamed260(o.quickReplies!);
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageQuickReplies--;
}

core.List<core.String> buildUnnamed261() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed261(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowV2IntentMessageSelectItemInfo = 0;
api.GoogleCloudDialogflowV2IntentMessageSelectItemInfo
    buildGoogleCloudDialogflowV2IntentMessageSelectItemInfo() {
  var o = api.GoogleCloudDialogflowV2IntentMessageSelectItemInfo();
  buildCounterGoogleCloudDialogflowV2IntentMessageSelectItemInfo++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageSelectItemInfo < 3) {
    o.key = 'foo';
    o.synonyms = buildUnnamed261();
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageSelectItemInfo--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageSelectItemInfo(
    api.GoogleCloudDialogflowV2IntentMessageSelectItemInfo o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageSelectItemInfo++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageSelectItemInfo < 3) {
    unittest.expect(
      o.key!,
      unittest.equals('foo'),
    );
    checkUnnamed261(o.synonyms!);
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageSelectItemInfo--;
}

core.int buildCounterGoogleCloudDialogflowV2IntentMessageSimpleResponse = 0;
api.GoogleCloudDialogflowV2IntentMessageSimpleResponse
    buildGoogleCloudDialogflowV2IntentMessageSimpleResponse() {
  var o = api.GoogleCloudDialogflowV2IntentMessageSimpleResponse();
  buildCounterGoogleCloudDialogflowV2IntentMessageSimpleResponse++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageSimpleResponse < 3) {
    o.displayText = 'foo';
    o.ssml = 'foo';
    o.textToSpeech = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageSimpleResponse--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageSimpleResponse(
    api.GoogleCloudDialogflowV2IntentMessageSimpleResponse o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageSimpleResponse++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageSimpleResponse < 3) {
    unittest.expect(
      o.displayText!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.ssml!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.textToSpeech!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageSimpleResponse--;
}

core.List<api.GoogleCloudDialogflowV2IntentMessageSimpleResponse>
    buildUnnamed262() {
  var o = <api.GoogleCloudDialogflowV2IntentMessageSimpleResponse>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessageSimpleResponse());
  o.add(buildGoogleCloudDialogflowV2IntentMessageSimpleResponse());
  return o;
}

void checkUnnamed262(
    core.List<api.GoogleCloudDialogflowV2IntentMessageSimpleResponse> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentMessageSimpleResponse(
      o[0] as api.GoogleCloudDialogflowV2IntentMessageSimpleResponse);
  checkGoogleCloudDialogflowV2IntentMessageSimpleResponse(
      o[1] as api.GoogleCloudDialogflowV2IntentMessageSimpleResponse);
}

core.int buildCounterGoogleCloudDialogflowV2IntentMessageSimpleResponses = 0;
api.GoogleCloudDialogflowV2IntentMessageSimpleResponses
    buildGoogleCloudDialogflowV2IntentMessageSimpleResponses() {
  var o = api.GoogleCloudDialogflowV2IntentMessageSimpleResponses();
  buildCounterGoogleCloudDialogflowV2IntentMessageSimpleResponses++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageSimpleResponses < 3) {
    o.simpleResponses = buildUnnamed262();
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageSimpleResponses--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageSimpleResponses(
    api.GoogleCloudDialogflowV2IntentMessageSimpleResponses o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageSimpleResponses++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageSimpleResponses < 3) {
    checkUnnamed262(o.simpleResponses!);
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageSimpleResponses--;
}

core.int buildCounterGoogleCloudDialogflowV2IntentMessageSuggestion = 0;
api.GoogleCloudDialogflowV2IntentMessageSuggestion
    buildGoogleCloudDialogflowV2IntentMessageSuggestion() {
  var o = api.GoogleCloudDialogflowV2IntentMessageSuggestion();
  buildCounterGoogleCloudDialogflowV2IntentMessageSuggestion++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageSuggestion < 3) {
    o.title = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageSuggestion--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageSuggestion(
    api.GoogleCloudDialogflowV2IntentMessageSuggestion o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageSuggestion++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageSuggestion < 3) {
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageSuggestion--;
}

core.List<api.GoogleCloudDialogflowV2IntentMessageSuggestion>
    buildUnnamed263() {
  var o = <api.GoogleCloudDialogflowV2IntentMessageSuggestion>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessageSuggestion());
  o.add(buildGoogleCloudDialogflowV2IntentMessageSuggestion());
  return o;
}

void checkUnnamed263(
    core.List<api.GoogleCloudDialogflowV2IntentMessageSuggestion> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentMessageSuggestion(
      o[0] as api.GoogleCloudDialogflowV2IntentMessageSuggestion);
  checkGoogleCloudDialogflowV2IntentMessageSuggestion(
      o[1] as api.GoogleCloudDialogflowV2IntentMessageSuggestion);
}

core.int buildCounterGoogleCloudDialogflowV2IntentMessageSuggestions = 0;
api.GoogleCloudDialogflowV2IntentMessageSuggestions
    buildGoogleCloudDialogflowV2IntentMessageSuggestions() {
  var o = api.GoogleCloudDialogflowV2IntentMessageSuggestions();
  buildCounterGoogleCloudDialogflowV2IntentMessageSuggestions++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageSuggestions < 3) {
    o.suggestions = buildUnnamed263();
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageSuggestions--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageSuggestions(
    api.GoogleCloudDialogflowV2IntentMessageSuggestions o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageSuggestions++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageSuggestions < 3) {
    checkUnnamed263(o.suggestions!);
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageSuggestions--;
}

core.List<api.GoogleCloudDialogflowV2IntentMessageBasicCardButton>
    buildUnnamed264() {
  var o = <api.GoogleCloudDialogflowV2IntentMessageBasicCardButton>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessageBasicCardButton());
  o.add(buildGoogleCloudDialogflowV2IntentMessageBasicCardButton());
  return o;
}

void checkUnnamed264(
    core.List<api.GoogleCloudDialogflowV2IntentMessageBasicCardButton> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentMessageBasicCardButton(
      o[0] as api.GoogleCloudDialogflowV2IntentMessageBasicCardButton);
  checkGoogleCloudDialogflowV2IntentMessageBasicCardButton(
      o[1] as api.GoogleCloudDialogflowV2IntentMessageBasicCardButton);
}

core.List<api.GoogleCloudDialogflowV2IntentMessageColumnProperties>
    buildUnnamed265() {
  var o = <api.GoogleCloudDialogflowV2IntentMessageColumnProperties>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessageColumnProperties());
  o.add(buildGoogleCloudDialogflowV2IntentMessageColumnProperties());
  return o;
}

void checkUnnamed265(
    core.List<api.GoogleCloudDialogflowV2IntentMessageColumnProperties> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentMessageColumnProperties(
      o[0] as api.GoogleCloudDialogflowV2IntentMessageColumnProperties);
  checkGoogleCloudDialogflowV2IntentMessageColumnProperties(
      o[1] as api.GoogleCloudDialogflowV2IntentMessageColumnProperties);
}

core.List<api.GoogleCloudDialogflowV2IntentMessageTableCardRow>
    buildUnnamed266() {
  var o = <api.GoogleCloudDialogflowV2IntentMessageTableCardRow>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessageTableCardRow());
  o.add(buildGoogleCloudDialogflowV2IntentMessageTableCardRow());
  return o;
}

void checkUnnamed266(
    core.List<api.GoogleCloudDialogflowV2IntentMessageTableCardRow> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentMessageTableCardRow(
      o[0] as api.GoogleCloudDialogflowV2IntentMessageTableCardRow);
  checkGoogleCloudDialogflowV2IntentMessageTableCardRow(
      o[1] as api.GoogleCloudDialogflowV2IntentMessageTableCardRow);
}

core.int buildCounterGoogleCloudDialogflowV2IntentMessageTableCard = 0;
api.GoogleCloudDialogflowV2IntentMessageTableCard
    buildGoogleCloudDialogflowV2IntentMessageTableCard() {
  var o = api.GoogleCloudDialogflowV2IntentMessageTableCard();
  buildCounterGoogleCloudDialogflowV2IntentMessageTableCard++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageTableCard < 3) {
    o.buttons = buildUnnamed264();
    o.columnProperties = buildUnnamed265();
    o.image = buildGoogleCloudDialogflowV2IntentMessageImage();
    o.rows = buildUnnamed266();
    o.subtitle = 'foo';
    o.title = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageTableCard--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageTableCard(
    api.GoogleCloudDialogflowV2IntentMessageTableCard o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageTableCard++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageTableCard < 3) {
    checkUnnamed264(o.buttons!);
    checkUnnamed265(o.columnProperties!);
    checkGoogleCloudDialogflowV2IntentMessageImage(
        o.image! as api.GoogleCloudDialogflowV2IntentMessageImage);
    checkUnnamed266(o.rows!);
    unittest.expect(
      o.subtitle!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageTableCard--;
}

core.int buildCounterGoogleCloudDialogflowV2IntentMessageTableCardCell = 0;
api.GoogleCloudDialogflowV2IntentMessageTableCardCell
    buildGoogleCloudDialogflowV2IntentMessageTableCardCell() {
  var o = api.GoogleCloudDialogflowV2IntentMessageTableCardCell();
  buildCounterGoogleCloudDialogflowV2IntentMessageTableCardCell++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageTableCardCell < 3) {
    o.text = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageTableCardCell--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageTableCardCell(
    api.GoogleCloudDialogflowV2IntentMessageTableCardCell o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageTableCardCell++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageTableCardCell < 3) {
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageTableCardCell--;
}

core.List<api.GoogleCloudDialogflowV2IntentMessageTableCardCell>
    buildUnnamed267() {
  var o = <api.GoogleCloudDialogflowV2IntentMessageTableCardCell>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessageTableCardCell());
  o.add(buildGoogleCloudDialogflowV2IntentMessageTableCardCell());
  return o;
}

void checkUnnamed267(
    core.List<api.GoogleCloudDialogflowV2IntentMessageTableCardCell> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentMessageTableCardCell(
      o[0] as api.GoogleCloudDialogflowV2IntentMessageTableCardCell);
  checkGoogleCloudDialogflowV2IntentMessageTableCardCell(
      o[1] as api.GoogleCloudDialogflowV2IntentMessageTableCardCell);
}

core.int buildCounterGoogleCloudDialogflowV2IntentMessageTableCardRow = 0;
api.GoogleCloudDialogflowV2IntentMessageTableCardRow
    buildGoogleCloudDialogflowV2IntentMessageTableCardRow() {
  var o = api.GoogleCloudDialogflowV2IntentMessageTableCardRow();
  buildCounterGoogleCloudDialogflowV2IntentMessageTableCardRow++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageTableCardRow < 3) {
    o.cells = buildUnnamed267();
    o.dividerAfter = true;
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageTableCardRow--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageTableCardRow(
    api.GoogleCloudDialogflowV2IntentMessageTableCardRow o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageTableCardRow++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageTableCardRow < 3) {
    checkUnnamed267(o.cells!);
    unittest.expect(o.dividerAfter!, unittest.isTrue);
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageTableCardRow--;
}

core.List<core.String> buildUnnamed268() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed268(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowV2IntentMessageText = 0;
api.GoogleCloudDialogflowV2IntentMessageText
    buildGoogleCloudDialogflowV2IntentMessageText() {
  var o = api.GoogleCloudDialogflowV2IntentMessageText();
  buildCounterGoogleCloudDialogflowV2IntentMessageText++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageText < 3) {
    o.text = buildUnnamed268();
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageText--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageText(
    api.GoogleCloudDialogflowV2IntentMessageText o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageText++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageText < 3) {
    checkUnnamed268(o.text!);
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageText--;
}

core.List<core.String> buildUnnamed269() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed269(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowV2IntentParameter = 0;
api.GoogleCloudDialogflowV2IntentParameter
    buildGoogleCloudDialogflowV2IntentParameter() {
  var o = api.GoogleCloudDialogflowV2IntentParameter();
  buildCounterGoogleCloudDialogflowV2IntentParameter++;
  if (buildCounterGoogleCloudDialogflowV2IntentParameter < 3) {
    o.defaultValue = 'foo';
    o.displayName = 'foo';
    o.entityTypeDisplayName = 'foo';
    o.isList = true;
    o.mandatory = true;
    o.name = 'foo';
    o.prompts = buildUnnamed269();
    o.value = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2IntentParameter--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentParameter(
    api.GoogleCloudDialogflowV2IntentParameter o) {
  buildCounterGoogleCloudDialogflowV2IntentParameter++;
  if (buildCounterGoogleCloudDialogflowV2IntentParameter < 3) {
    unittest.expect(
      o.defaultValue!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.entityTypeDisplayName!,
      unittest.equals('foo'),
    );
    unittest.expect(o.isList!, unittest.isTrue);
    unittest.expect(o.mandatory!, unittest.isTrue);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed269(o.prompts!);
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2IntentParameter--;
}

core.List<api.GoogleCloudDialogflowV2IntentTrainingPhrasePart>
    buildUnnamed270() {
  var o = <api.GoogleCloudDialogflowV2IntentTrainingPhrasePart>[];
  o.add(buildGoogleCloudDialogflowV2IntentTrainingPhrasePart());
  o.add(buildGoogleCloudDialogflowV2IntentTrainingPhrasePart());
  return o;
}

void checkUnnamed270(
    core.List<api.GoogleCloudDialogflowV2IntentTrainingPhrasePart> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentTrainingPhrasePart(
      o[0] as api.GoogleCloudDialogflowV2IntentTrainingPhrasePart);
  checkGoogleCloudDialogflowV2IntentTrainingPhrasePart(
      o[1] as api.GoogleCloudDialogflowV2IntentTrainingPhrasePart);
}

core.int buildCounterGoogleCloudDialogflowV2IntentTrainingPhrase = 0;
api.GoogleCloudDialogflowV2IntentTrainingPhrase
    buildGoogleCloudDialogflowV2IntentTrainingPhrase() {
  var o = api.GoogleCloudDialogflowV2IntentTrainingPhrase();
  buildCounterGoogleCloudDialogflowV2IntentTrainingPhrase++;
  if (buildCounterGoogleCloudDialogflowV2IntentTrainingPhrase < 3) {
    o.name = 'foo';
    o.parts = buildUnnamed270();
    o.timesAddedCount = 42;
    o.type = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2IntentTrainingPhrase--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentTrainingPhrase(
    api.GoogleCloudDialogflowV2IntentTrainingPhrase o) {
  buildCounterGoogleCloudDialogflowV2IntentTrainingPhrase++;
  if (buildCounterGoogleCloudDialogflowV2IntentTrainingPhrase < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed270(o.parts!);
    unittest.expect(
      o.timesAddedCount!,
      unittest.equals(42),
    );
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2IntentTrainingPhrase--;
}

core.int buildCounterGoogleCloudDialogflowV2IntentTrainingPhrasePart = 0;
api.GoogleCloudDialogflowV2IntentTrainingPhrasePart
    buildGoogleCloudDialogflowV2IntentTrainingPhrasePart() {
  var o = api.GoogleCloudDialogflowV2IntentTrainingPhrasePart();
  buildCounterGoogleCloudDialogflowV2IntentTrainingPhrasePart++;
  if (buildCounterGoogleCloudDialogflowV2IntentTrainingPhrasePart < 3) {
    o.alias = 'foo';
    o.entityType = 'foo';
    o.text = 'foo';
    o.userDefined = true;
  }
  buildCounterGoogleCloudDialogflowV2IntentTrainingPhrasePart--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentTrainingPhrasePart(
    api.GoogleCloudDialogflowV2IntentTrainingPhrasePart o) {
  buildCounterGoogleCloudDialogflowV2IntentTrainingPhrasePart++;
  if (buildCounterGoogleCloudDialogflowV2IntentTrainingPhrasePart < 3) {
    unittest.expect(
      o.alias!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.entityType!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
    unittest.expect(o.userDefined!, unittest.isTrue);
  }
  buildCounterGoogleCloudDialogflowV2IntentTrainingPhrasePart--;
}

core.int buildCounterGoogleCloudDialogflowV2Message = 0;
api.GoogleCloudDialogflowV2Message buildGoogleCloudDialogflowV2Message() {
  var o = api.GoogleCloudDialogflowV2Message();
  buildCounterGoogleCloudDialogflowV2Message++;
  if (buildCounterGoogleCloudDialogflowV2Message < 3) {
    o.content = 'foo';
    o.createTime = 'foo';
    o.languageCode = 'foo';
    o.messageAnnotation = buildGoogleCloudDialogflowV2MessageAnnotation();
    o.name = 'foo';
    o.participant = 'foo';
    o.participantRole = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2Message--;
  return o;
}

void checkGoogleCloudDialogflowV2Message(api.GoogleCloudDialogflowV2Message o) {
  buildCounterGoogleCloudDialogflowV2Message++;
  if (buildCounterGoogleCloudDialogflowV2Message < 3) {
    unittest.expect(
      o.content!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.createTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowV2MessageAnnotation(
        o.messageAnnotation! as api.GoogleCloudDialogflowV2MessageAnnotation);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.participant!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.participantRole!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2Message--;
}

core.List<api.GoogleCloudDialogflowV2AnnotatedMessagePart> buildUnnamed271() {
  var o = <api.GoogleCloudDialogflowV2AnnotatedMessagePart>[];
  o.add(buildGoogleCloudDialogflowV2AnnotatedMessagePart());
  o.add(buildGoogleCloudDialogflowV2AnnotatedMessagePart());
  return o;
}

void checkUnnamed271(
    core.List<api.GoogleCloudDialogflowV2AnnotatedMessagePart> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2AnnotatedMessagePart(
      o[0] as api.GoogleCloudDialogflowV2AnnotatedMessagePart);
  checkGoogleCloudDialogflowV2AnnotatedMessagePart(
      o[1] as api.GoogleCloudDialogflowV2AnnotatedMessagePart);
}

core.int buildCounterGoogleCloudDialogflowV2MessageAnnotation = 0;
api.GoogleCloudDialogflowV2MessageAnnotation
    buildGoogleCloudDialogflowV2MessageAnnotation() {
  var o = api.GoogleCloudDialogflowV2MessageAnnotation();
  buildCounterGoogleCloudDialogflowV2MessageAnnotation++;
  if (buildCounterGoogleCloudDialogflowV2MessageAnnotation < 3) {
    o.containEntities = true;
    o.parts = buildUnnamed271();
  }
  buildCounterGoogleCloudDialogflowV2MessageAnnotation--;
  return o;
}

void checkGoogleCloudDialogflowV2MessageAnnotation(
    api.GoogleCloudDialogflowV2MessageAnnotation o) {
  buildCounterGoogleCloudDialogflowV2MessageAnnotation++;
  if (buildCounterGoogleCloudDialogflowV2MessageAnnotation < 3) {
    unittest.expect(o.containEntities!, unittest.isTrue);
    checkUnnamed271(o.parts!);
  }
  buildCounterGoogleCloudDialogflowV2MessageAnnotation--;
}

core.Map<core.String, core.Object> buildUnnamed272() {
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

void checkUnnamed272(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted64 = (o['x']!) as core.Map;
  unittest.expect(casted64, unittest.hasLength(3));
  unittest.expect(
    casted64['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted64['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted64['string'],
    unittest.equals('foo'),
  );
  var casted65 = (o['y']!) as core.Map;
  unittest.expect(casted65, unittest.hasLength(3));
  unittest.expect(
    casted65['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted65['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted65['string'],
    unittest.equals('foo'),
  );
}

core.int buildCounterGoogleCloudDialogflowV2OriginalDetectIntentRequest = 0;
api.GoogleCloudDialogflowV2OriginalDetectIntentRequest
    buildGoogleCloudDialogflowV2OriginalDetectIntentRequest() {
  var o = api.GoogleCloudDialogflowV2OriginalDetectIntentRequest();
  buildCounterGoogleCloudDialogflowV2OriginalDetectIntentRequest++;
  if (buildCounterGoogleCloudDialogflowV2OriginalDetectIntentRequest < 3) {
    o.payload = buildUnnamed272();
    o.source = 'foo';
    o.version = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2OriginalDetectIntentRequest--;
  return o;
}

void checkGoogleCloudDialogflowV2OriginalDetectIntentRequest(
    api.GoogleCloudDialogflowV2OriginalDetectIntentRequest o) {
  buildCounterGoogleCloudDialogflowV2OriginalDetectIntentRequest++;
  if (buildCounterGoogleCloudDialogflowV2OriginalDetectIntentRequest < 3) {
    checkUnnamed272(o.payload!);
    unittest.expect(
      o.source!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2OriginalDetectIntentRequest--;
}

core.Map<core.String, core.Object> buildUnnamed273() {
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

void checkUnnamed273(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted66 = (o['x']!) as core.Map;
  unittest.expect(casted66, unittest.hasLength(3));
  unittest.expect(
    casted66['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted66['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted66['string'],
    unittest.equals('foo'),
  );
  var casted67 = (o['y']!) as core.Map;
  unittest.expect(casted67, unittest.hasLength(3));
  unittest.expect(
    casted67['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted67['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted67['string'],
    unittest.equals('foo'),
  );
}

core.List<api.GoogleCloudDialogflowV2IntentMessage> buildUnnamed274() {
  var o = <api.GoogleCloudDialogflowV2IntentMessage>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessage());
  o.add(buildGoogleCloudDialogflowV2IntentMessage());
  return o;
}

void checkUnnamed274(core.List<api.GoogleCloudDialogflowV2IntentMessage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentMessage(
      o[0] as api.GoogleCloudDialogflowV2IntentMessage);
  checkGoogleCloudDialogflowV2IntentMessage(
      o[1] as api.GoogleCloudDialogflowV2IntentMessage);
}

core.List<api.GoogleCloudDialogflowV2Context> buildUnnamed275() {
  var o = <api.GoogleCloudDialogflowV2Context>[];
  o.add(buildGoogleCloudDialogflowV2Context());
  o.add(buildGoogleCloudDialogflowV2Context());
  return o;
}

void checkUnnamed275(core.List<api.GoogleCloudDialogflowV2Context> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2Context(
      o[0] as api.GoogleCloudDialogflowV2Context);
  checkGoogleCloudDialogflowV2Context(
      o[1] as api.GoogleCloudDialogflowV2Context);
}

core.Map<core.String, core.Object> buildUnnamed276() {
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

void checkUnnamed276(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted68 = (o['x']!) as core.Map;
  unittest.expect(casted68, unittest.hasLength(3));
  unittest.expect(
    casted68['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted68['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted68['string'],
    unittest.equals('foo'),
  );
  var casted69 = (o['y']!) as core.Map;
  unittest.expect(casted69, unittest.hasLength(3));
  unittest.expect(
    casted69['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted69['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted69['string'],
    unittest.equals('foo'),
  );
}

core.Map<core.String, core.Object> buildUnnamed277() {
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

void checkUnnamed277(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted70 = (o['x']!) as core.Map;
  unittest.expect(casted70, unittest.hasLength(3));
  unittest.expect(
    casted70['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted70['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted70['string'],
    unittest.equals('foo'),
  );
  var casted71 = (o['y']!) as core.Map;
  unittest.expect(casted71, unittest.hasLength(3));
  unittest.expect(
    casted71['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted71['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted71['string'],
    unittest.equals('foo'),
  );
}

core.int buildCounterGoogleCloudDialogflowV2QueryResult = 0;
api.GoogleCloudDialogflowV2QueryResult
    buildGoogleCloudDialogflowV2QueryResult() {
  var o = api.GoogleCloudDialogflowV2QueryResult();
  buildCounterGoogleCloudDialogflowV2QueryResult++;
  if (buildCounterGoogleCloudDialogflowV2QueryResult < 3) {
    o.action = 'foo';
    o.allRequiredParamsPresent = true;
    o.diagnosticInfo = buildUnnamed273();
    o.fulfillmentMessages = buildUnnamed274();
    o.fulfillmentText = 'foo';
    o.intent = buildGoogleCloudDialogflowV2Intent();
    o.intentDetectionConfidence = 42.0;
    o.languageCode = 'foo';
    o.outputContexts = buildUnnamed275();
    o.parameters = buildUnnamed276();
    o.queryText = 'foo';
    o.sentimentAnalysisResult =
        buildGoogleCloudDialogflowV2SentimentAnalysisResult();
    o.speechRecognitionConfidence = 42.0;
    o.webhookPayload = buildUnnamed277();
    o.webhookSource = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2QueryResult--;
  return o;
}

void checkGoogleCloudDialogflowV2QueryResult(
    api.GoogleCloudDialogflowV2QueryResult o) {
  buildCounterGoogleCloudDialogflowV2QueryResult++;
  if (buildCounterGoogleCloudDialogflowV2QueryResult < 3) {
    unittest.expect(
      o.action!,
      unittest.equals('foo'),
    );
    unittest.expect(o.allRequiredParamsPresent!, unittest.isTrue);
    checkUnnamed273(o.diagnosticInfo!);
    checkUnnamed274(o.fulfillmentMessages!);
    unittest.expect(
      o.fulfillmentText!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowV2Intent(
        o.intent! as api.GoogleCloudDialogflowV2Intent);
    unittest.expect(
      o.intentDetectionConfidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
    checkUnnamed275(o.outputContexts!);
    checkUnnamed276(o.parameters!);
    unittest.expect(
      o.queryText!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowV2SentimentAnalysisResult(
        o.sentimentAnalysisResult!
            as api.GoogleCloudDialogflowV2SentimentAnalysisResult);
    unittest.expect(
      o.speechRecognitionConfidence!,
      unittest.equals(42.0),
    );
    checkUnnamed277(o.webhookPayload!);
    unittest.expect(
      o.webhookSource!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2QueryResult--;
}

core.int buildCounterGoogleCloudDialogflowV2Sentiment = 0;
api.GoogleCloudDialogflowV2Sentiment buildGoogleCloudDialogflowV2Sentiment() {
  var o = api.GoogleCloudDialogflowV2Sentiment();
  buildCounterGoogleCloudDialogflowV2Sentiment++;
  if (buildCounterGoogleCloudDialogflowV2Sentiment < 3) {
    o.magnitude = 42.0;
    o.score = 42.0;
  }
  buildCounterGoogleCloudDialogflowV2Sentiment--;
  return o;
}

void checkGoogleCloudDialogflowV2Sentiment(
    api.GoogleCloudDialogflowV2Sentiment o) {
  buildCounterGoogleCloudDialogflowV2Sentiment++;
  if (buildCounterGoogleCloudDialogflowV2Sentiment < 3) {
    unittest.expect(
      o.magnitude!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudDialogflowV2Sentiment--;
}

core.int buildCounterGoogleCloudDialogflowV2SentimentAnalysisResult = 0;
api.GoogleCloudDialogflowV2SentimentAnalysisResult
    buildGoogleCloudDialogflowV2SentimentAnalysisResult() {
  var o = api.GoogleCloudDialogflowV2SentimentAnalysisResult();
  buildCounterGoogleCloudDialogflowV2SentimentAnalysisResult++;
  if (buildCounterGoogleCloudDialogflowV2SentimentAnalysisResult < 3) {
    o.queryTextSentiment = buildGoogleCloudDialogflowV2Sentiment();
  }
  buildCounterGoogleCloudDialogflowV2SentimentAnalysisResult--;
  return o;
}

void checkGoogleCloudDialogflowV2SentimentAnalysisResult(
    api.GoogleCloudDialogflowV2SentimentAnalysisResult o) {
  buildCounterGoogleCloudDialogflowV2SentimentAnalysisResult++;
  if (buildCounterGoogleCloudDialogflowV2SentimentAnalysisResult < 3) {
    checkGoogleCloudDialogflowV2Sentiment(
        o.queryTextSentiment! as api.GoogleCloudDialogflowV2Sentiment);
  }
  buildCounterGoogleCloudDialogflowV2SentimentAnalysisResult--;
}

core.List<api.GoogleCloudDialogflowV2EntityTypeEntity> buildUnnamed278() {
  var o = <api.GoogleCloudDialogflowV2EntityTypeEntity>[];
  o.add(buildGoogleCloudDialogflowV2EntityTypeEntity());
  o.add(buildGoogleCloudDialogflowV2EntityTypeEntity());
  return o;
}

void checkUnnamed278(core.List<api.GoogleCloudDialogflowV2EntityTypeEntity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2EntityTypeEntity(
      o[0] as api.GoogleCloudDialogflowV2EntityTypeEntity);
  checkGoogleCloudDialogflowV2EntityTypeEntity(
      o[1] as api.GoogleCloudDialogflowV2EntityTypeEntity);
}

core.int buildCounterGoogleCloudDialogflowV2SessionEntityType = 0;
api.GoogleCloudDialogflowV2SessionEntityType
    buildGoogleCloudDialogflowV2SessionEntityType() {
  var o = api.GoogleCloudDialogflowV2SessionEntityType();
  buildCounterGoogleCloudDialogflowV2SessionEntityType++;
  if (buildCounterGoogleCloudDialogflowV2SessionEntityType < 3) {
    o.entities = buildUnnamed278();
    o.entityOverrideMode = 'foo';
    o.name = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2SessionEntityType--;
  return o;
}

void checkGoogleCloudDialogflowV2SessionEntityType(
    api.GoogleCloudDialogflowV2SessionEntityType o) {
  buildCounterGoogleCloudDialogflowV2SessionEntityType++;
  if (buildCounterGoogleCloudDialogflowV2SessionEntityType < 3) {
    checkUnnamed278(o.entities!);
    unittest.expect(
      o.entityOverrideMode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2SessionEntityType--;
}

core.int buildCounterGoogleCloudDialogflowV2WebhookRequest = 0;
api.GoogleCloudDialogflowV2WebhookRequest
    buildGoogleCloudDialogflowV2WebhookRequest() {
  var o = api.GoogleCloudDialogflowV2WebhookRequest();
  buildCounterGoogleCloudDialogflowV2WebhookRequest++;
  if (buildCounterGoogleCloudDialogflowV2WebhookRequest < 3) {
    o.originalDetectIntentRequest =
        buildGoogleCloudDialogflowV2OriginalDetectIntentRequest();
    o.queryResult = buildGoogleCloudDialogflowV2QueryResult();
    o.responseId = 'foo';
    o.session = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2WebhookRequest--;
  return o;
}

void checkGoogleCloudDialogflowV2WebhookRequest(
    api.GoogleCloudDialogflowV2WebhookRequest o) {
  buildCounterGoogleCloudDialogflowV2WebhookRequest++;
  if (buildCounterGoogleCloudDialogflowV2WebhookRequest < 3) {
    checkGoogleCloudDialogflowV2OriginalDetectIntentRequest(
        o.originalDetectIntentRequest!
            as api.GoogleCloudDialogflowV2OriginalDetectIntentRequest);
    checkGoogleCloudDialogflowV2QueryResult(
        o.queryResult! as api.GoogleCloudDialogflowV2QueryResult);
    unittest.expect(
      o.responseId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.session!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2WebhookRequest--;
}

core.List<api.GoogleCloudDialogflowV2IntentMessage> buildUnnamed279() {
  var o = <api.GoogleCloudDialogflowV2IntentMessage>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessage());
  o.add(buildGoogleCloudDialogflowV2IntentMessage());
  return o;
}

void checkUnnamed279(core.List<api.GoogleCloudDialogflowV2IntentMessage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentMessage(
      o[0] as api.GoogleCloudDialogflowV2IntentMessage);
  checkGoogleCloudDialogflowV2IntentMessage(
      o[1] as api.GoogleCloudDialogflowV2IntentMessage);
}

core.List<api.GoogleCloudDialogflowV2Context> buildUnnamed280() {
  var o = <api.GoogleCloudDialogflowV2Context>[];
  o.add(buildGoogleCloudDialogflowV2Context());
  o.add(buildGoogleCloudDialogflowV2Context());
  return o;
}

void checkUnnamed280(core.List<api.GoogleCloudDialogflowV2Context> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2Context(
      o[0] as api.GoogleCloudDialogflowV2Context);
  checkGoogleCloudDialogflowV2Context(
      o[1] as api.GoogleCloudDialogflowV2Context);
}

core.Map<core.String, core.Object> buildUnnamed281() {
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

void checkUnnamed281(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted72 = (o['x']!) as core.Map;
  unittest.expect(casted72, unittest.hasLength(3));
  unittest.expect(
    casted72['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted72['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted72['string'],
    unittest.equals('foo'),
  );
  var casted73 = (o['y']!) as core.Map;
  unittest.expect(casted73, unittest.hasLength(3));
  unittest.expect(
    casted73['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted73['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted73['string'],
    unittest.equals('foo'),
  );
}

core.List<api.GoogleCloudDialogflowV2SessionEntityType> buildUnnamed282() {
  var o = <api.GoogleCloudDialogflowV2SessionEntityType>[];
  o.add(buildGoogleCloudDialogflowV2SessionEntityType());
  o.add(buildGoogleCloudDialogflowV2SessionEntityType());
  return o;
}

void checkUnnamed282(
    core.List<api.GoogleCloudDialogflowV2SessionEntityType> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2SessionEntityType(
      o[0] as api.GoogleCloudDialogflowV2SessionEntityType);
  checkGoogleCloudDialogflowV2SessionEntityType(
      o[1] as api.GoogleCloudDialogflowV2SessionEntityType);
}

core.int buildCounterGoogleCloudDialogflowV2WebhookResponse = 0;
api.GoogleCloudDialogflowV2WebhookResponse
    buildGoogleCloudDialogflowV2WebhookResponse() {
  var o = api.GoogleCloudDialogflowV2WebhookResponse();
  buildCounterGoogleCloudDialogflowV2WebhookResponse++;
  if (buildCounterGoogleCloudDialogflowV2WebhookResponse < 3) {
    o.followupEventInput = buildGoogleCloudDialogflowV2EventInput();
    o.fulfillmentMessages = buildUnnamed279();
    o.fulfillmentText = 'foo';
    o.outputContexts = buildUnnamed280();
    o.payload = buildUnnamed281();
    o.sessionEntityTypes = buildUnnamed282();
    o.source = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2WebhookResponse--;
  return o;
}

void checkGoogleCloudDialogflowV2WebhookResponse(
    api.GoogleCloudDialogflowV2WebhookResponse o) {
  buildCounterGoogleCloudDialogflowV2WebhookResponse++;
  if (buildCounterGoogleCloudDialogflowV2WebhookResponse < 3) {
    checkGoogleCloudDialogflowV2EventInput(
        o.followupEventInput! as api.GoogleCloudDialogflowV2EventInput);
    checkUnnamed279(o.fulfillmentMessages!);
    unittest.expect(
      o.fulfillmentText!,
      unittest.equals('foo'),
    );
    checkUnnamed280(o.outputContexts!);
    checkUnnamed281(o.payload!);
    checkUnnamed282(o.sessionEntityTypes!);
    unittest.expect(
      o.source!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2WebhookResponse--;
}

core.List<api.GoogleCloudDialogflowV2beta1EntityType> buildUnnamed283() {
  var o = <api.GoogleCloudDialogflowV2beta1EntityType>[];
  o.add(buildGoogleCloudDialogflowV2beta1EntityType());
  o.add(buildGoogleCloudDialogflowV2beta1EntityType());
  return o;
}

void checkUnnamed283(core.List<api.GoogleCloudDialogflowV2beta1EntityType> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1EntityType(
      o[0] as api.GoogleCloudDialogflowV2beta1EntityType);
  checkGoogleCloudDialogflowV2beta1EntityType(
      o[1] as api.GoogleCloudDialogflowV2beta1EntityType);
}

core.int
    buildCounterGoogleCloudDialogflowV2beta1BatchUpdateEntityTypesResponse = 0;
api.GoogleCloudDialogflowV2beta1BatchUpdateEntityTypesResponse
    buildGoogleCloudDialogflowV2beta1BatchUpdateEntityTypesResponse() {
  var o = api.GoogleCloudDialogflowV2beta1BatchUpdateEntityTypesResponse();
  buildCounterGoogleCloudDialogflowV2beta1BatchUpdateEntityTypesResponse++;
  if (buildCounterGoogleCloudDialogflowV2beta1BatchUpdateEntityTypesResponse <
      3) {
    o.entityTypes = buildUnnamed283();
  }
  buildCounterGoogleCloudDialogflowV2beta1BatchUpdateEntityTypesResponse--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1BatchUpdateEntityTypesResponse(
    api.GoogleCloudDialogflowV2beta1BatchUpdateEntityTypesResponse o) {
  buildCounterGoogleCloudDialogflowV2beta1BatchUpdateEntityTypesResponse++;
  if (buildCounterGoogleCloudDialogflowV2beta1BatchUpdateEntityTypesResponse <
      3) {
    checkUnnamed283(o.entityTypes!);
  }
  buildCounterGoogleCloudDialogflowV2beta1BatchUpdateEntityTypesResponse--;
}

core.List<api.GoogleCloudDialogflowV2beta1Intent> buildUnnamed284() {
  var o = <api.GoogleCloudDialogflowV2beta1Intent>[];
  o.add(buildGoogleCloudDialogflowV2beta1Intent());
  o.add(buildGoogleCloudDialogflowV2beta1Intent());
  return o;
}

void checkUnnamed284(core.List<api.GoogleCloudDialogflowV2beta1Intent> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1Intent(
      o[0] as api.GoogleCloudDialogflowV2beta1Intent);
  checkGoogleCloudDialogflowV2beta1Intent(
      o[1] as api.GoogleCloudDialogflowV2beta1Intent);
}

core.int buildCounterGoogleCloudDialogflowV2beta1BatchUpdateIntentsResponse = 0;
api.GoogleCloudDialogflowV2beta1BatchUpdateIntentsResponse
    buildGoogleCloudDialogflowV2beta1BatchUpdateIntentsResponse() {
  var o = api.GoogleCloudDialogflowV2beta1BatchUpdateIntentsResponse();
  buildCounterGoogleCloudDialogflowV2beta1BatchUpdateIntentsResponse++;
  if (buildCounterGoogleCloudDialogflowV2beta1BatchUpdateIntentsResponse < 3) {
    o.intents = buildUnnamed284();
  }
  buildCounterGoogleCloudDialogflowV2beta1BatchUpdateIntentsResponse--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1BatchUpdateIntentsResponse(
    api.GoogleCloudDialogflowV2beta1BatchUpdateIntentsResponse o) {
  buildCounterGoogleCloudDialogflowV2beta1BatchUpdateIntentsResponse++;
  if (buildCounterGoogleCloudDialogflowV2beta1BatchUpdateIntentsResponse < 3) {
    checkUnnamed284(o.intents!);
  }
  buildCounterGoogleCloudDialogflowV2beta1BatchUpdateIntentsResponse--;
}

core.Map<core.String, core.Object> buildUnnamed285() {
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

void checkUnnamed285(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted74 = (o['x']!) as core.Map;
  unittest.expect(casted74, unittest.hasLength(3));
  unittest.expect(
    casted74['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted74['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted74['string'],
    unittest.equals('foo'),
  );
  var casted75 = (o['y']!) as core.Map;
  unittest.expect(casted75, unittest.hasLength(3));
  unittest.expect(
    casted75['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted75['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted75['string'],
    unittest.equals('foo'),
  );
}

core.int buildCounterGoogleCloudDialogflowV2beta1Context = 0;
api.GoogleCloudDialogflowV2beta1Context
    buildGoogleCloudDialogflowV2beta1Context() {
  var o = api.GoogleCloudDialogflowV2beta1Context();
  buildCounterGoogleCloudDialogflowV2beta1Context++;
  if (buildCounterGoogleCloudDialogflowV2beta1Context < 3) {
    o.lifespanCount = 42;
    o.name = 'foo';
    o.parameters = buildUnnamed285();
  }
  buildCounterGoogleCloudDialogflowV2beta1Context--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1Context(
    api.GoogleCloudDialogflowV2beta1Context o) {
  buildCounterGoogleCloudDialogflowV2beta1Context++;
  if (buildCounterGoogleCloudDialogflowV2beta1Context < 3) {
    unittest.expect(
      o.lifespanCount!,
      unittest.equals(42),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed285(o.parameters!);
  }
  buildCounterGoogleCloudDialogflowV2beta1Context--;
}

core.List<api.GoogleCloudDialogflowV2beta1EntityTypeEntity> buildUnnamed286() {
  var o = <api.GoogleCloudDialogflowV2beta1EntityTypeEntity>[];
  o.add(buildGoogleCloudDialogflowV2beta1EntityTypeEntity());
  o.add(buildGoogleCloudDialogflowV2beta1EntityTypeEntity());
  return o;
}

void checkUnnamed286(
    core.List<api.GoogleCloudDialogflowV2beta1EntityTypeEntity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1EntityTypeEntity(
      o[0] as api.GoogleCloudDialogflowV2beta1EntityTypeEntity);
  checkGoogleCloudDialogflowV2beta1EntityTypeEntity(
      o[1] as api.GoogleCloudDialogflowV2beta1EntityTypeEntity);
}

core.int buildCounterGoogleCloudDialogflowV2beta1EntityType = 0;
api.GoogleCloudDialogflowV2beta1EntityType
    buildGoogleCloudDialogflowV2beta1EntityType() {
  var o = api.GoogleCloudDialogflowV2beta1EntityType();
  buildCounterGoogleCloudDialogflowV2beta1EntityType++;
  if (buildCounterGoogleCloudDialogflowV2beta1EntityType < 3) {
    o.autoExpansionMode = 'foo';
    o.displayName = 'foo';
    o.enableFuzzyExtraction = true;
    o.entities = buildUnnamed286();
    o.kind = 'foo';
    o.name = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1EntityType--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1EntityType(
    api.GoogleCloudDialogflowV2beta1EntityType o) {
  buildCounterGoogleCloudDialogflowV2beta1EntityType++;
  if (buildCounterGoogleCloudDialogflowV2beta1EntityType < 3) {
    unittest.expect(
      o.autoExpansionMode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(o.enableFuzzyExtraction!, unittest.isTrue);
    checkUnnamed286(o.entities!);
    unittest.expect(
      o.kind!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1EntityType--;
}

core.List<core.String> buildUnnamed287() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed287(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowV2beta1EntityTypeEntity = 0;
api.GoogleCloudDialogflowV2beta1EntityTypeEntity
    buildGoogleCloudDialogflowV2beta1EntityTypeEntity() {
  var o = api.GoogleCloudDialogflowV2beta1EntityTypeEntity();
  buildCounterGoogleCloudDialogflowV2beta1EntityTypeEntity++;
  if (buildCounterGoogleCloudDialogflowV2beta1EntityTypeEntity < 3) {
    o.synonyms = buildUnnamed287();
    o.value = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1EntityTypeEntity--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1EntityTypeEntity(
    api.GoogleCloudDialogflowV2beta1EntityTypeEntity o) {
  buildCounterGoogleCloudDialogflowV2beta1EntityTypeEntity++;
  if (buildCounterGoogleCloudDialogflowV2beta1EntityTypeEntity < 3) {
    checkUnnamed287(o.synonyms!);
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1EntityTypeEntity--;
}

core.Map<core.String, core.Object> buildUnnamed288() {
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

void checkUnnamed288(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted76 = (o['x']!) as core.Map;
  unittest.expect(casted76, unittest.hasLength(3));
  unittest.expect(
    casted76['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted76['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted76['string'],
    unittest.equals('foo'),
  );
  var casted77 = (o['y']!) as core.Map;
  unittest.expect(casted77, unittest.hasLength(3));
  unittest.expect(
    casted77['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted77['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted77['string'],
    unittest.equals('foo'),
  );
}

core.int buildCounterGoogleCloudDialogflowV2beta1EventInput = 0;
api.GoogleCloudDialogflowV2beta1EventInput
    buildGoogleCloudDialogflowV2beta1EventInput() {
  var o = api.GoogleCloudDialogflowV2beta1EventInput();
  buildCounterGoogleCloudDialogflowV2beta1EventInput++;
  if (buildCounterGoogleCloudDialogflowV2beta1EventInput < 3) {
    o.languageCode = 'foo';
    o.name = 'foo';
    o.parameters = buildUnnamed288();
  }
  buildCounterGoogleCloudDialogflowV2beta1EventInput--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1EventInput(
    api.GoogleCloudDialogflowV2beta1EventInput o) {
  buildCounterGoogleCloudDialogflowV2beta1EventInput++;
  if (buildCounterGoogleCloudDialogflowV2beta1EventInput < 3) {
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed288(o.parameters!);
  }
  buildCounterGoogleCloudDialogflowV2beta1EventInput--;
}

core.int buildCounterGoogleCloudDialogflowV2beta1ExportAgentResponse = 0;
api.GoogleCloudDialogflowV2beta1ExportAgentResponse
    buildGoogleCloudDialogflowV2beta1ExportAgentResponse() {
  var o = api.GoogleCloudDialogflowV2beta1ExportAgentResponse();
  buildCounterGoogleCloudDialogflowV2beta1ExportAgentResponse++;
  if (buildCounterGoogleCloudDialogflowV2beta1ExportAgentResponse < 3) {
    o.agentContent = 'foo';
    o.agentUri = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1ExportAgentResponse--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1ExportAgentResponse(
    api.GoogleCloudDialogflowV2beta1ExportAgentResponse o) {
  buildCounterGoogleCloudDialogflowV2beta1ExportAgentResponse++;
  if (buildCounterGoogleCloudDialogflowV2beta1ExportAgentResponse < 3) {
    unittest.expect(
      o.agentContent!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.agentUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1ExportAgentResponse--;
}

core.List<core.String> buildUnnamed289() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed289(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed290() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed290(core.List<core.String> o) {
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

core.List<api.GoogleCloudDialogflowV2beta1IntentFollowupIntentInfo>
    buildUnnamed291() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentFollowupIntentInfo>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentFollowupIntentInfo());
  o.add(buildGoogleCloudDialogflowV2beta1IntentFollowupIntentInfo());
  return o;
}

void checkUnnamed291(
    core.List<api.GoogleCloudDialogflowV2beta1IntentFollowupIntentInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentFollowupIntentInfo(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentFollowupIntentInfo);
  checkGoogleCloudDialogflowV2beta1IntentFollowupIntentInfo(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentFollowupIntentInfo);
}

core.List<core.String> buildUnnamed292() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed292(core.List<core.String> o) {
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

core.List<api.GoogleCloudDialogflowV2beta1IntentMessage> buildUnnamed293() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessage>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessage());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessage());
  return o;
}

void checkUnnamed293(
    core.List<api.GoogleCloudDialogflowV2beta1IntentMessage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentMessage(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentMessage);
  checkGoogleCloudDialogflowV2beta1IntentMessage(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentMessage);
}

core.List<api.GoogleCloudDialogflowV2beta1Context> buildUnnamed294() {
  var o = <api.GoogleCloudDialogflowV2beta1Context>[];
  o.add(buildGoogleCloudDialogflowV2beta1Context());
  o.add(buildGoogleCloudDialogflowV2beta1Context());
  return o;
}

void checkUnnamed294(core.List<api.GoogleCloudDialogflowV2beta1Context> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1Context(
      o[0] as api.GoogleCloudDialogflowV2beta1Context);
  checkGoogleCloudDialogflowV2beta1Context(
      o[1] as api.GoogleCloudDialogflowV2beta1Context);
}

core.List<api.GoogleCloudDialogflowV2beta1IntentParameter> buildUnnamed295() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentParameter>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentParameter());
  o.add(buildGoogleCloudDialogflowV2beta1IntentParameter());
  return o;
}

void checkUnnamed295(
    core.List<api.GoogleCloudDialogflowV2beta1IntentParameter> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentParameter(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentParameter);
  checkGoogleCloudDialogflowV2beta1IntentParameter(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentParameter);
}

core.List<api.GoogleCloudDialogflowV2beta1IntentTrainingPhrase>
    buildUnnamed296() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentTrainingPhrase>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentTrainingPhrase());
  o.add(buildGoogleCloudDialogflowV2beta1IntentTrainingPhrase());
  return o;
}

void checkUnnamed296(
    core.List<api.GoogleCloudDialogflowV2beta1IntentTrainingPhrase> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentTrainingPhrase(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentTrainingPhrase);
  checkGoogleCloudDialogflowV2beta1IntentTrainingPhrase(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentTrainingPhrase);
}

core.int buildCounterGoogleCloudDialogflowV2beta1Intent = 0;
api.GoogleCloudDialogflowV2beta1Intent
    buildGoogleCloudDialogflowV2beta1Intent() {
  var o = api.GoogleCloudDialogflowV2beta1Intent();
  buildCounterGoogleCloudDialogflowV2beta1Intent++;
  if (buildCounterGoogleCloudDialogflowV2beta1Intent < 3) {
    o.action = 'foo';
    o.defaultResponsePlatforms = buildUnnamed289();
    o.displayName = 'foo';
    o.endInteraction = true;
    o.events = buildUnnamed290();
    o.followupIntentInfo = buildUnnamed291();
    o.inputContextNames = buildUnnamed292();
    o.isFallback = true;
    o.messages = buildUnnamed293();
    o.mlDisabled = true;
    o.mlEnabled = true;
    o.name = 'foo';
    o.outputContexts = buildUnnamed294();
    o.parameters = buildUnnamed295();
    o.parentFollowupIntentName = 'foo';
    o.priority = 42;
    o.resetContexts = true;
    o.rootFollowupIntentName = 'foo';
    o.trainingPhrases = buildUnnamed296();
    o.webhookState = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1Intent--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1Intent(
    api.GoogleCloudDialogflowV2beta1Intent o) {
  buildCounterGoogleCloudDialogflowV2beta1Intent++;
  if (buildCounterGoogleCloudDialogflowV2beta1Intent < 3) {
    unittest.expect(
      o.action!,
      unittest.equals('foo'),
    );
    checkUnnamed289(o.defaultResponsePlatforms!);
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(o.endInteraction!, unittest.isTrue);
    checkUnnamed290(o.events!);
    checkUnnamed291(o.followupIntentInfo!);
    checkUnnamed292(o.inputContextNames!);
    unittest.expect(o.isFallback!, unittest.isTrue);
    checkUnnamed293(o.messages!);
    unittest.expect(o.mlDisabled!, unittest.isTrue);
    unittest.expect(o.mlEnabled!, unittest.isTrue);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed294(o.outputContexts!);
    checkUnnamed295(o.parameters!);
    unittest.expect(
      o.parentFollowupIntentName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.priority!,
      unittest.equals(42),
    );
    unittest.expect(o.resetContexts!, unittest.isTrue);
    unittest.expect(
      o.rootFollowupIntentName!,
      unittest.equals('foo'),
    );
    checkUnnamed296(o.trainingPhrases!);
    unittest.expect(
      o.webhookState!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1Intent--;
}

core.int buildCounterGoogleCloudDialogflowV2beta1IntentFollowupIntentInfo = 0;
api.GoogleCloudDialogflowV2beta1IntentFollowupIntentInfo
    buildGoogleCloudDialogflowV2beta1IntentFollowupIntentInfo() {
  var o = api.GoogleCloudDialogflowV2beta1IntentFollowupIntentInfo();
  buildCounterGoogleCloudDialogflowV2beta1IntentFollowupIntentInfo++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentFollowupIntentInfo < 3) {
    o.followupIntentName = 'foo';
    o.parentFollowupIntentName = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentFollowupIntentInfo--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentFollowupIntentInfo(
    api.GoogleCloudDialogflowV2beta1IntentFollowupIntentInfo o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentFollowupIntentInfo++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentFollowupIntentInfo < 3) {
    unittest.expect(
      o.followupIntentName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.parentFollowupIntentName!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentFollowupIntentInfo--;
}

core.Map<core.String, core.Object> buildUnnamed297() {
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

void checkUnnamed297(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted78 = (o['x']!) as core.Map;
  unittest.expect(casted78, unittest.hasLength(3));
  unittest.expect(
    casted78['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted78['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted78['string'],
    unittest.equals('foo'),
  );
  var casted79 = (o['y']!) as core.Map;
  unittest.expect(casted79, unittest.hasLength(3));
  unittest.expect(
    casted79['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted79['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted79['string'],
    unittest.equals('foo'),
  );
}

core.int buildCounterGoogleCloudDialogflowV2beta1IntentMessage = 0;
api.GoogleCloudDialogflowV2beta1IntentMessage
    buildGoogleCloudDialogflowV2beta1IntentMessage() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessage();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessage++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessage < 3) {
    o.basicCard = buildGoogleCloudDialogflowV2beta1IntentMessageBasicCard();
    o.browseCarouselCard =
        buildGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCard();
    o.card = buildGoogleCloudDialogflowV2beta1IntentMessageCard();
    o.carouselSelect =
        buildGoogleCloudDialogflowV2beta1IntentMessageCarouselSelect();
    o.image = buildGoogleCloudDialogflowV2beta1IntentMessageImage();
    o.linkOutSuggestion =
        buildGoogleCloudDialogflowV2beta1IntentMessageLinkOutSuggestion();
    o.listSelect = buildGoogleCloudDialogflowV2beta1IntentMessageListSelect();
    o.mediaContent =
        buildGoogleCloudDialogflowV2beta1IntentMessageMediaContent();
    o.payload = buildUnnamed297();
    o.platform = 'foo';
    o.quickReplies =
        buildGoogleCloudDialogflowV2beta1IntentMessageQuickReplies();
    o.rbmCarouselRichCard =
        buildGoogleCloudDialogflowV2beta1IntentMessageRbmCarouselCard();
    o.rbmStandaloneRichCard =
        buildGoogleCloudDialogflowV2beta1IntentMessageRbmStandaloneCard();
    o.rbmText = buildGoogleCloudDialogflowV2beta1IntentMessageRbmText();
    o.simpleResponses =
        buildGoogleCloudDialogflowV2beta1IntentMessageSimpleResponses();
    o.suggestions = buildGoogleCloudDialogflowV2beta1IntentMessageSuggestions();
    o.tableCard = buildGoogleCloudDialogflowV2beta1IntentMessageTableCard();
    o.telephonyPlayAudio =
        buildGoogleCloudDialogflowV2beta1IntentMessageTelephonyPlayAudio();
    o.telephonySynthesizeSpeech =
        buildGoogleCloudDialogflowV2beta1IntentMessageTelephonySynthesizeSpeech();
    o.telephonyTransferCall =
        buildGoogleCloudDialogflowV2beta1IntentMessageTelephonyTransferCall();
    o.text = buildGoogleCloudDialogflowV2beta1IntentMessageText();
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessage--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessage(
    api.GoogleCloudDialogflowV2beta1IntentMessage o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessage++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessage < 3) {
    checkGoogleCloudDialogflowV2beta1IntentMessageBasicCard(
        o.basicCard! as api.GoogleCloudDialogflowV2beta1IntentMessageBasicCard);
    checkGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCard(
        o.browseCarouselCard!
            as api.GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCard);
    checkGoogleCloudDialogflowV2beta1IntentMessageCard(
        o.card! as api.GoogleCloudDialogflowV2beta1IntentMessageCard);
    checkGoogleCloudDialogflowV2beta1IntentMessageCarouselSelect(
        o.carouselSelect!
            as api.GoogleCloudDialogflowV2beta1IntentMessageCarouselSelect);
    checkGoogleCloudDialogflowV2beta1IntentMessageImage(
        o.image! as api.GoogleCloudDialogflowV2beta1IntentMessageImage);
    checkGoogleCloudDialogflowV2beta1IntentMessageLinkOutSuggestion(
        o.linkOutSuggestion!
            as api.GoogleCloudDialogflowV2beta1IntentMessageLinkOutSuggestion);
    checkGoogleCloudDialogflowV2beta1IntentMessageListSelect(o.listSelect!
        as api.GoogleCloudDialogflowV2beta1IntentMessageListSelect);
    checkGoogleCloudDialogflowV2beta1IntentMessageMediaContent(o.mediaContent!
        as api.GoogleCloudDialogflowV2beta1IntentMessageMediaContent);
    checkUnnamed297(o.payload!);
    unittest.expect(
      o.platform!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowV2beta1IntentMessageQuickReplies(o.quickReplies!
        as api.GoogleCloudDialogflowV2beta1IntentMessageQuickReplies);
    checkGoogleCloudDialogflowV2beta1IntentMessageRbmCarouselCard(
        o.rbmCarouselRichCard!
            as api.GoogleCloudDialogflowV2beta1IntentMessageRbmCarouselCard);
    checkGoogleCloudDialogflowV2beta1IntentMessageRbmStandaloneCard(
        o.rbmStandaloneRichCard!
            as api.GoogleCloudDialogflowV2beta1IntentMessageRbmStandaloneCard);
    checkGoogleCloudDialogflowV2beta1IntentMessageRbmText(
        o.rbmText! as api.GoogleCloudDialogflowV2beta1IntentMessageRbmText);
    checkGoogleCloudDialogflowV2beta1IntentMessageSimpleResponses(
        o.simpleResponses!
            as api.GoogleCloudDialogflowV2beta1IntentMessageSimpleResponses);
    checkGoogleCloudDialogflowV2beta1IntentMessageSuggestions(o.suggestions!
        as api.GoogleCloudDialogflowV2beta1IntentMessageSuggestions);
    checkGoogleCloudDialogflowV2beta1IntentMessageTableCard(
        o.tableCard! as api.GoogleCloudDialogflowV2beta1IntentMessageTableCard);
    checkGoogleCloudDialogflowV2beta1IntentMessageTelephonyPlayAudio(
        o.telephonyPlayAudio!
            as api.GoogleCloudDialogflowV2beta1IntentMessageTelephonyPlayAudio);
    checkGoogleCloudDialogflowV2beta1IntentMessageTelephonySynthesizeSpeech(
        o.telephonySynthesizeSpeech! as api
            .GoogleCloudDialogflowV2beta1IntentMessageTelephonySynthesizeSpeech);
    checkGoogleCloudDialogflowV2beta1IntentMessageTelephonyTransferCall(o
            .telephonyTransferCall!
        as api.GoogleCloudDialogflowV2beta1IntentMessageTelephonyTransferCall);
    checkGoogleCloudDialogflowV2beta1IntentMessageText(
        o.text! as api.GoogleCloudDialogflowV2beta1IntentMessageText);
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessage--;
}

core.List<api.GoogleCloudDialogflowV2beta1IntentMessageBasicCardButton>
    buildUnnamed298() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageBasicCardButton>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageBasicCardButton());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageBasicCardButton());
  return o;
}

void checkUnnamed298(
    core.List<api.GoogleCloudDialogflowV2beta1IntentMessageBasicCardButton> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentMessageBasicCardButton(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentMessageBasicCardButton);
  checkGoogleCloudDialogflowV2beta1IntentMessageBasicCardButton(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentMessageBasicCardButton);
}

core.int buildCounterGoogleCloudDialogflowV2beta1IntentMessageBasicCard = 0;
api.GoogleCloudDialogflowV2beta1IntentMessageBasicCard
    buildGoogleCloudDialogflowV2beta1IntentMessageBasicCard() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageBasicCard();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageBasicCard++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageBasicCard < 3) {
    o.buttons = buildUnnamed298();
    o.formattedText = 'foo';
    o.image = buildGoogleCloudDialogflowV2beta1IntentMessageImage();
    o.subtitle = 'foo';
    o.title = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageBasicCard--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageBasicCard(
    api.GoogleCloudDialogflowV2beta1IntentMessageBasicCard o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageBasicCard++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageBasicCard < 3) {
    checkUnnamed298(o.buttons!);
    unittest.expect(
      o.formattedText!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowV2beta1IntentMessageImage(
        o.image! as api.GoogleCloudDialogflowV2beta1IntentMessageImage);
    unittest.expect(
      o.subtitle!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageBasicCard--;
}

core.int buildCounterGoogleCloudDialogflowV2beta1IntentMessageBasicCardButton =
    0;
api.GoogleCloudDialogflowV2beta1IntentMessageBasicCardButton
    buildGoogleCloudDialogflowV2beta1IntentMessageBasicCardButton() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageBasicCardButton();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageBasicCardButton++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageBasicCardButton <
      3) {
    o.openUriAction =
        buildGoogleCloudDialogflowV2beta1IntentMessageBasicCardButtonOpenUriAction();
    o.title = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageBasicCardButton--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageBasicCardButton(
    api.GoogleCloudDialogflowV2beta1IntentMessageBasicCardButton o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageBasicCardButton++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageBasicCardButton <
      3) {
    checkGoogleCloudDialogflowV2beta1IntentMessageBasicCardButtonOpenUriAction(
        o.openUriAction! as api
            .GoogleCloudDialogflowV2beta1IntentMessageBasicCardButtonOpenUriAction);
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageBasicCardButton--;
}

core.int
    buildCounterGoogleCloudDialogflowV2beta1IntentMessageBasicCardButtonOpenUriAction =
    0;
api.GoogleCloudDialogflowV2beta1IntentMessageBasicCardButtonOpenUriAction
    buildGoogleCloudDialogflowV2beta1IntentMessageBasicCardButtonOpenUriAction() {
  var o = api
      .GoogleCloudDialogflowV2beta1IntentMessageBasicCardButtonOpenUriAction();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageBasicCardButtonOpenUriAction++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageBasicCardButtonOpenUriAction <
      3) {
    o.uri = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageBasicCardButtonOpenUriAction--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageBasicCardButtonOpenUriAction(
    api.GoogleCloudDialogflowV2beta1IntentMessageBasicCardButtonOpenUriAction
        o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageBasicCardButtonOpenUriAction++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageBasicCardButtonOpenUriAction <
      3) {
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageBasicCardButtonOpenUriAction--;
}

core.List<
        api.GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem>
    buildUnnamed299() {
  var o = <
      api.GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem>[];
  o.add(
      buildGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem());
  o.add(
      buildGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem());
  return o;
}

void checkUnnamed299(
    core.List<
            api.GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem(
      o[0] as api
          .GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem);
  checkGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem(
      o[1] as api
          .GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem);
}

core.int
    buildCounterGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCard = 0;
api.GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCard
    buildGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCard() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCard();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCard++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCard <
      3) {
    o.imageDisplayOptions = 'foo';
    o.items = buildUnnamed299();
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCard--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCard(
    api.GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCard o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCard++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCard <
      3) {
    unittest.expect(
      o.imageDisplayOptions!,
      unittest.equals('foo'),
    );
    checkUnnamed299(o.items!);
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCard--;
}

core.int
    buildCounterGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem =
    0;
api.GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem
    buildGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem() {
  var o = api
      .GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem <
      3) {
    o.description = 'foo';
    o.footer = 'foo';
    o.image = buildGoogleCloudDialogflowV2beta1IntentMessageImage();
    o.openUriAction =
        buildGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction();
    o.title = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem(
    api.GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem
        o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem <
      3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.footer!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowV2beta1IntentMessageImage(
        o.image! as api.GoogleCloudDialogflowV2beta1IntentMessageImage);
    checkGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction(
        o.openUriAction! as api
            .GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction);
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem--;
}

core.int
    buildCounterGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction =
    0;
api.GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction
    buildGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction() {
  var o = api
      .GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction <
      3) {
    o.url = 'foo';
    o.urlTypeHint = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction(
    api.GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction
        o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction <
      3) {
    unittest.expect(
      o.url!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.urlTypeHint!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction--;
}

core.List<api.GoogleCloudDialogflowV2beta1IntentMessageCardButton>
    buildUnnamed300() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageCardButton>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageCardButton());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageCardButton());
  return o;
}

void checkUnnamed300(
    core.List<api.GoogleCloudDialogflowV2beta1IntentMessageCardButton> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentMessageCardButton(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentMessageCardButton);
  checkGoogleCloudDialogflowV2beta1IntentMessageCardButton(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentMessageCardButton);
}

core.int buildCounterGoogleCloudDialogflowV2beta1IntentMessageCard = 0;
api.GoogleCloudDialogflowV2beta1IntentMessageCard
    buildGoogleCloudDialogflowV2beta1IntentMessageCard() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageCard();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageCard++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageCard < 3) {
    o.buttons = buildUnnamed300();
    o.imageUri = 'foo';
    o.subtitle = 'foo';
    o.title = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageCard--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageCard(
    api.GoogleCloudDialogflowV2beta1IntentMessageCard o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageCard++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageCard < 3) {
    checkUnnamed300(o.buttons!);
    unittest.expect(
      o.imageUri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.subtitle!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageCard--;
}

core.int buildCounterGoogleCloudDialogflowV2beta1IntentMessageCardButton = 0;
api.GoogleCloudDialogflowV2beta1IntentMessageCardButton
    buildGoogleCloudDialogflowV2beta1IntentMessageCardButton() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageCardButton();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageCardButton++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageCardButton < 3) {
    o.postback = 'foo';
    o.text = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageCardButton--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageCardButton(
    api.GoogleCloudDialogflowV2beta1IntentMessageCardButton o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageCardButton++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageCardButton < 3) {
    unittest.expect(
      o.postback!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageCardButton--;
}

core.List<api.GoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem>
    buildUnnamed301() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem());
  return o;
}

void checkUnnamed301(
    core.List<api.GoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem);
  checkGoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem);
}

core.int buildCounterGoogleCloudDialogflowV2beta1IntentMessageCarouselSelect =
    0;
api.GoogleCloudDialogflowV2beta1IntentMessageCarouselSelect
    buildGoogleCloudDialogflowV2beta1IntentMessageCarouselSelect() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageCarouselSelect();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageCarouselSelect++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageCarouselSelect < 3) {
    o.items = buildUnnamed301();
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageCarouselSelect--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageCarouselSelect(
    api.GoogleCloudDialogflowV2beta1IntentMessageCarouselSelect o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageCarouselSelect++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageCarouselSelect < 3) {
    checkUnnamed301(o.items!);
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageCarouselSelect--;
}

core.int
    buildCounterGoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem = 0;
api.GoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem
    buildGoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem <
      3) {
    o.description = 'foo';
    o.image = buildGoogleCloudDialogflowV2beta1IntentMessageImage();
    o.info = buildGoogleCloudDialogflowV2beta1IntentMessageSelectItemInfo();
    o.title = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem(
    api.GoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem <
      3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowV2beta1IntentMessageImage(
        o.image! as api.GoogleCloudDialogflowV2beta1IntentMessageImage);
    checkGoogleCloudDialogflowV2beta1IntentMessageSelectItemInfo(
        o.info! as api.GoogleCloudDialogflowV2beta1IntentMessageSelectItemInfo);
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem--;
}

core.int buildCounterGoogleCloudDialogflowV2beta1IntentMessageColumnProperties =
    0;
api.GoogleCloudDialogflowV2beta1IntentMessageColumnProperties
    buildGoogleCloudDialogflowV2beta1IntentMessageColumnProperties() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageColumnProperties();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageColumnProperties++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageColumnProperties <
      3) {
    o.header = 'foo';
    o.horizontalAlignment = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageColumnProperties--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageColumnProperties(
    api.GoogleCloudDialogflowV2beta1IntentMessageColumnProperties o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageColumnProperties++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageColumnProperties <
      3) {
    unittest.expect(
      o.header!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.horizontalAlignment!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageColumnProperties--;
}

core.int buildCounterGoogleCloudDialogflowV2beta1IntentMessageImage = 0;
api.GoogleCloudDialogflowV2beta1IntentMessageImage
    buildGoogleCloudDialogflowV2beta1IntentMessageImage() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageImage();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageImage++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageImage < 3) {
    o.accessibilityText = 'foo';
    o.imageUri = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageImage--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageImage(
    api.GoogleCloudDialogflowV2beta1IntentMessageImage o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageImage++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageImage < 3) {
    unittest.expect(
      o.accessibilityText!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.imageUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageImage--;
}

core.int
    buildCounterGoogleCloudDialogflowV2beta1IntentMessageLinkOutSuggestion = 0;
api.GoogleCloudDialogflowV2beta1IntentMessageLinkOutSuggestion
    buildGoogleCloudDialogflowV2beta1IntentMessageLinkOutSuggestion() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageLinkOutSuggestion();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageLinkOutSuggestion++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageLinkOutSuggestion <
      3) {
    o.destinationName = 'foo';
    o.uri = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageLinkOutSuggestion--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageLinkOutSuggestion(
    api.GoogleCloudDialogflowV2beta1IntentMessageLinkOutSuggestion o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageLinkOutSuggestion++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageLinkOutSuggestion <
      3) {
    unittest.expect(
      o.destinationName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageLinkOutSuggestion--;
}

core.List<api.GoogleCloudDialogflowV2beta1IntentMessageListSelectItem>
    buildUnnamed302() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageListSelectItem>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageListSelectItem());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageListSelectItem());
  return o;
}

void checkUnnamed302(
    core.List<api.GoogleCloudDialogflowV2beta1IntentMessageListSelectItem> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentMessageListSelectItem(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentMessageListSelectItem);
  checkGoogleCloudDialogflowV2beta1IntentMessageListSelectItem(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentMessageListSelectItem);
}

core.int buildCounterGoogleCloudDialogflowV2beta1IntentMessageListSelect = 0;
api.GoogleCloudDialogflowV2beta1IntentMessageListSelect
    buildGoogleCloudDialogflowV2beta1IntentMessageListSelect() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageListSelect();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageListSelect++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageListSelect < 3) {
    o.items = buildUnnamed302();
    o.subtitle = 'foo';
    o.title = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageListSelect--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageListSelect(
    api.GoogleCloudDialogflowV2beta1IntentMessageListSelect o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageListSelect++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageListSelect < 3) {
    checkUnnamed302(o.items!);
    unittest.expect(
      o.subtitle!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageListSelect--;
}

core.int buildCounterGoogleCloudDialogflowV2beta1IntentMessageListSelectItem =
    0;
api.GoogleCloudDialogflowV2beta1IntentMessageListSelectItem
    buildGoogleCloudDialogflowV2beta1IntentMessageListSelectItem() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageListSelectItem();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageListSelectItem++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageListSelectItem < 3) {
    o.description = 'foo';
    o.image = buildGoogleCloudDialogflowV2beta1IntentMessageImage();
    o.info = buildGoogleCloudDialogflowV2beta1IntentMessageSelectItemInfo();
    o.title = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageListSelectItem--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageListSelectItem(
    api.GoogleCloudDialogflowV2beta1IntentMessageListSelectItem o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageListSelectItem++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageListSelectItem < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowV2beta1IntentMessageImage(
        o.image! as api.GoogleCloudDialogflowV2beta1IntentMessageImage);
    checkGoogleCloudDialogflowV2beta1IntentMessageSelectItemInfo(
        o.info! as api.GoogleCloudDialogflowV2beta1IntentMessageSelectItemInfo);
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageListSelectItem--;
}

core.List<
        api.GoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject>
    buildUnnamed303() {
  var o = <
      api.GoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject>[];
  o.add(
      buildGoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject());
  o.add(
      buildGoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject());
  return o;
}

void checkUnnamed303(
    core.List<
            api.GoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject(
      o[0] as api
          .GoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject);
  checkGoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject(
      o[1] as api
          .GoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject);
}

core.int buildCounterGoogleCloudDialogflowV2beta1IntentMessageMediaContent = 0;
api.GoogleCloudDialogflowV2beta1IntentMessageMediaContent
    buildGoogleCloudDialogflowV2beta1IntentMessageMediaContent() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageMediaContent();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageMediaContent++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageMediaContent < 3) {
    o.mediaObjects = buildUnnamed303();
    o.mediaType = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageMediaContent--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageMediaContent(
    api.GoogleCloudDialogflowV2beta1IntentMessageMediaContent o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageMediaContent++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageMediaContent < 3) {
    checkUnnamed303(o.mediaObjects!);
    unittest.expect(
      o.mediaType!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageMediaContent--;
}

core.int
    buildCounterGoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject =
    0;
api.GoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject
    buildGoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject() {
  var o = api
      .GoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject <
      3) {
    o.contentUrl = 'foo';
    o.description = 'foo';
    o.icon = buildGoogleCloudDialogflowV2beta1IntentMessageImage();
    o.largeImage = buildGoogleCloudDialogflowV2beta1IntentMessageImage();
    o.name = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject(
    api.GoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject
        o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject <
      3) {
    unittest.expect(
      o.contentUrl!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowV2beta1IntentMessageImage(
        o.icon! as api.GoogleCloudDialogflowV2beta1IntentMessageImage);
    checkGoogleCloudDialogflowV2beta1IntentMessageImage(
        o.largeImage! as api.GoogleCloudDialogflowV2beta1IntentMessageImage);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject--;
}

core.List<core.String> buildUnnamed304() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed304(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowV2beta1IntentMessageQuickReplies = 0;
api.GoogleCloudDialogflowV2beta1IntentMessageQuickReplies
    buildGoogleCloudDialogflowV2beta1IntentMessageQuickReplies() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageQuickReplies();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageQuickReplies++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageQuickReplies < 3) {
    o.quickReplies = buildUnnamed304();
    o.title = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageQuickReplies--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageQuickReplies(
    api.GoogleCloudDialogflowV2beta1IntentMessageQuickReplies o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageQuickReplies++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageQuickReplies < 3) {
    checkUnnamed304(o.quickReplies!);
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageQuickReplies--;
}

core.List<api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion>
    buildUnnamed305() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion());
  return o;
}

void checkUnnamed305(
    core.List<api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion);
  checkGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion);
}

core.int buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmCardContent =
    0;
api.GoogleCloudDialogflowV2beta1IntentMessageRbmCardContent
    buildGoogleCloudDialogflowV2beta1IntentMessageRbmCardContent() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageRbmCardContent();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmCardContent++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmCardContent < 3) {
    o.description = 'foo';
    o.media =
        buildGoogleCloudDialogflowV2beta1IntentMessageRbmCardContentRbmMedia();
    o.suggestions = buildUnnamed305();
    o.title = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmCardContent--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageRbmCardContent(
    api.GoogleCloudDialogflowV2beta1IntentMessageRbmCardContent o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmCardContent++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmCardContent < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowV2beta1IntentMessageRbmCardContentRbmMedia(o
            .media!
        as api.GoogleCloudDialogflowV2beta1IntentMessageRbmCardContentRbmMedia);
    checkUnnamed305(o.suggestions!);
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmCardContent--;
}

core.int
    buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmCardContentRbmMedia =
    0;
api.GoogleCloudDialogflowV2beta1IntentMessageRbmCardContentRbmMedia
    buildGoogleCloudDialogflowV2beta1IntentMessageRbmCardContentRbmMedia() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageRbmCardContentRbmMedia();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmCardContentRbmMedia++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmCardContentRbmMedia <
      3) {
    o.fileUri = 'foo';
    o.height = 'foo';
    o.thumbnailUri = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmCardContentRbmMedia--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageRbmCardContentRbmMedia(
    api.GoogleCloudDialogflowV2beta1IntentMessageRbmCardContentRbmMedia o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmCardContentRbmMedia++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmCardContentRbmMedia <
      3) {
    unittest.expect(
      o.fileUri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.height!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.thumbnailUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmCardContentRbmMedia--;
}

core.List<api.GoogleCloudDialogflowV2beta1IntentMessageRbmCardContent>
    buildUnnamed306() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageRbmCardContent>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageRbmCardContent());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageRbmCardContent());
  return o;
}

void checkUnnamed306(
    core.List<api.GoogleCloudDialogflowV2beta1IntentMessageRbmCardContent> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentMessageRbmCardContent(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentMessageRbmCardContent);
  checkGoogleCloudDialogflowV2beta1IntentMessageRbmCardContent(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentMessageRbmCardContent);
}

core.int buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmCarouselCard =
    0;
api.GoogleCloudDialogflowV2beta1IntentMessageRbmCarouselCard
    buildGoogleCloudDialogflowV2beta1IntentMessageRbmCarouselCard() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageRbmCarouselCard();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmCarouselCard++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmCarouselCard <
      3) {
    o.cardContents = buildUnnamed306();
    o.cardWidth = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmCarouselCard--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageRbmCarouselCard(
    api.GoogleCloudDialogflowV2beta1IntentMessageRbmCarouselCard o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmCarouselCard++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmCarouselCard <
      3) {
    checkUnnamed306(o.cardContents!);
    unittest.expect(
      o.cardWidth!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmCarouselCard--;
}

core.int
    buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmStandaloneCard = 0;
api.GoogleCloudDialogflowV2beta1IntentMessageRbmStandaloneCard
    buildGoogleCloudDialogflowV2beta1IntentMessageRbmStandaloneCard() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageRbmStandaloneCard();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmStandaloneCard++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmStandaloneCard <
      3) {
    o.cardContent =
        buildGoogleCloudDialogflowV2beta1IntentMessageRbmCardContent();
    o.cardOrientation = 'foo';
    o.thumbnailImageAlignment = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmStandaloneCard--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageRbmStandaloneCard(
    api.GoogleCloudDialogflowV2beta1IntentMessageRbmStandaloneCard o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmStandaloneCard++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmStandaloneCard <
      3) {
    checkGoogleCloudDialogflowV2beta1IntentMessageRbmCardContent(o.cardContent!
        as api.GoogleCloudDialogflowV2beta1IntentMessageRbmCardContent);
    unittest.expect(
      o.cardOrientation!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.thumbnailImageAlignment!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmStandaloneCard--;
}

core.int
    buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedAction = 0;
api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedAction
    buildGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedAction() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedAction();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedAction++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedAction <
      3) {
    o.dial =
        buildGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionDial();
    o.openUrl =
        buildGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionOpenUri();
    o.postbackData = 'foo';
    o.shareLocation =
        buildGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionShareLocation();
    o.text = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedAction--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedAction(
    api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedAction o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedAction++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedAction <
      3) {
    checkGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionDial(
        o.dial! as api
            .GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionDial);
    checkGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionOpenUri(
        o.openUrl! as api
            .GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionOpenUri);
    unittest.expect(
      o.postbackData!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionShareLocation(
        o.shareLocation! as api
            .GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionShareLocation);
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedAction--;
}

core.int
    buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionDial =
    0;
api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionDial
    buildGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionDial() {
  var o = api
      .GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionDial();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionDial++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionDial <
      3) {
    o.phoneNumber = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionDial--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionDial(
    api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionDial
        o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionDial++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionDial <
      3) {
    unittest.expect(
      o.phoneNumber!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionDial--;
}

core.int
    buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionOpenUri =
    0;
api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionOpenUri
    buildGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionOpenUri() {
  var o = api
      .GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionOpenUri();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionOpenUri++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionOpenUri <
      3) {
    o.uri = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionOpenUri--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionOpenUri(
    api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionOpenUri
        o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionOpenUri++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionOpenUri <
      3) {
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionOpenUri--;
}

core.int
    buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionShareLocation =
    0;
api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionShareLocation
    buildGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionShareLocation() {
  var o = api
      .GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionShareLocation();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionShareLocation++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionShareLocation <
      3) {}
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionShareLocation--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionShareLocation(
    api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionShareLocation
        o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionShareLocation++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionShareLocation <
      3) {}
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionShareLocation--;
}

core.int
    buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedReply = 0;
api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedReply
    buildGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedReply() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedReply();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedReply++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedReply <
      3) {
    o.postbackData = 'foo';
    o.text = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedReply--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedReply(
    api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedReply o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedReply++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedReply <
      3) {
    unittest.expect(
      o.postbackData!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedReply--;
}

core.int buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion = 0;
api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion
    buildGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion < 3) {
    o.action =
        buildGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedAction();
    o.reply = buildGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedReply();
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion(
    api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion < 3) {
    checkGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedAction(o.action!
        as api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedAction);
    checkGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedReply(o.reply!
        as api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedReply);
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion--;
}

core.List<api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion>
    buildUnnamed307() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion());
  return o;
}

void checkUnnamed307(
    core.List<api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion);
  checkGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion);
}

core.int buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmText = 0;
api.GoogleCloudDialogflowV2beta1IntentMessageRbmText
    buildGoogleCloudDialogflowV2beta1IntentMessageRbmText() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageRbmText();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmText++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmText < 3) {
    o.rbmSuggestion = buildUnnamed307();
    o.text = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmText--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageRbmText(
    api.GoogleCloudDialogflowV2beta1IntentMessageRbmText o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmText++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmText < 3) {
    checkUnnamed307(o.rbmSuggestion!);
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmText--;
}

core.List<core.String> buildUnnamed308() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed308(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowV2beta1IntentMessageSelectItemInfo =
    0;
api.GoogleCloudDialogflowV2beta1IntentMessageSelectItemInfo
    buildGoogleCloudDialogflowV2beta1IntentMessageSelectItemInfo() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageSelectItemInfo();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageSelectItemInfo++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageSelectItemInfo < 3) {
    o.key = 'foo';
    o.synonyms = buildUnnamed308();
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageSelectItemInfo--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageSelectItemInfo(
    api.GoogleCloudDialogflowV2beta1IntentMessageSelectItemInfo o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageSelectItemInfo++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageSelectItemInfo < 3) {
    unittest.expect(
      o.key!,
      unittest.equals('foo'),
    );
    checkUnnamed308(o.synonyms!);
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageSelectItemInfo--;
}

core.int buildCounterGoogleCloudDialogflowV2beta1IntentMessageSimpleResponse =
    0;
api.GoogleCloudDialogflowV2beta1IntentMessageSimpleResponse
    buildGoogleCloudDialogflowV2beta1IntentMessageSimpleResponse() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageSimpleResponse();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageSimpleResponse++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageSimpleResponse < 3) {
    o.displayText = 'foo';
    o.ssml = 'foo';
    o.textToSpeech = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageSimpleResponse--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageSimpleResponse(
    api.GoogleCloudDialogflowV2beta1IntentMessageSimpleResponse o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageSimpleResponse++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageSimpleResponse < 3) {
    unittest.expect(
      o.displayText!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.ssml!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.textToSpeech!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageSimpleResponse--;
}

core.List<api.GoogleCloudDialogflowV2beta1IntentMessageSimpleResponse>
    buildUnnamed309() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageSimpleResponse>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageSimpleResponse());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageSimpleResponse());
  return o;
}

void checkUnnamed309(
    core.List<api.GoogleCloudDialogflowV2beta1IntentMessageSimpleResponse> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentMessageSimpleResponse(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentMessageSimpleResponse);
  checkGoogleCloudDialogflowV2beta1IntentMessageSimpleResponse(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentMessageSimpleResponse);
}

core.int buildCounterGoogleCloudDialogflowV2beta1IntentMessageSimpleResponses =
    0;
api.GoogleCloudDialogflowV2beta1IntentMessageSimpleResponses
    buildGoogleCloudDialogflowV2beta1IntentMessageSimpleResponses() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageSimpleResponses();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageSimpleResponses++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageSimpleResponses <
      3) {
    o.simpleResponses = buildUnnamed309();
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageSimpleResponses--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageSimpleResponses(
    api.GoogleCloudDialogflowV2beta1IntentMessageSimpleResponses o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageSimpleResponses++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageSimpleResponses <
      3) {
    checkUnnamed309(o.simpleResponses!);
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageSimpleResponses--;
}

core.int buildCounterGoogleCloudDialogflowV2beta1IntentMessageSuggestion = 0;
api.GoogleCloudDialogflowV2beta1IntentMessageSuggestion
    buildGoogleCloudDialogflowV2beta1IntentMessageSuggestion() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageSuggestion();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageSuggestion++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageSuggestion < 3) {
    o.title = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageSuggestion--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageSuggestion(
    api.GoogleCloudDialogflowV2beta1IntentMessageSuggestion o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageSuggestion++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageSuggestion < 3) {
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageSuggestion--;
}

core.List<api.GoogleCloudDialogflowV2beta1IntentMessageSuggestion>
    buildUnnamed310() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageSuggestion>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageSuggestion());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageSuggestion());
  return o;
}

void checkUnnamed310(
    core.List<api.GoogleCloudDialogflowV2beta1IntentMessageSuggestion> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentMessageSuggestion(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentMessageSuggestion);
  checkGoogleCloudDialogflowV2beta1IntentMessageSuggestion(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentMessageSuggestion);
}

core.int buildCounterGoogleCloudDialogflowV2beta1IntentMessageSuggestions = 0;
api.GoogleCloudDialogflowV2beta1IntentMessageSuggestions
    buildGoogleCloudDialogflowV2beta1IntentMessageSuggestions() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageSuggestions();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageSuggestions++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageSuggestions < 3) {
    o.suggestions = buildUnnamed310();
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageSuggestions--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageSuggestions(
    api.GoogleCloudDialogflowV2beta1IntentMessageSuggestions o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageSuggestions++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageSuggestions < 3) {
    checkUnnamed310(o.suggestions!);
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageSuggestions--;
}

core.List<api.GoogleCloudDialogflowV2beta1IntentMessageBasicCardButton>
    buildUnnamed311() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageBasicCardButton>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageBasicCardButton());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageBasicCardButton());
  return o;
}

void checkUnnamed311(
    core.List<api.GoogleCloudDialogflowV2beta1IntentMessageBasicCardButton> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentMessageBasicCardButton(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentMessageBasicCardButton);
  checkGoogleCloudDialogflowV2beta1IntentMessageBasicCardButton(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentMessageBasicCardButton);
}

core.List<api.GoogleCloudDialogflowV2beta1IntentMessageColumnProperties>
    buildUnnamed312() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageColumnProperties>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageColumnProperties());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageColumnProperties());
  return o;
}

void checkUnnamed312(
    core.List<api.GoogleCloudDialogflowV2beta1IntentMessageColumnProperties>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentMessageColumnProperties(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentMessageColumnProperties);
  checkGoogleCloudDialogflowV2beta1IntentMessageColumnProperties(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentMessageColumnProperties);
}

core.List<api.GoogleCloudDialogflowV2beta1IntentMessageTableCardRow>
    buildUnnamed313() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageTableCardRow>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageTableCardRow());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageTableCardRow());
  return o;
}

void checkUnnamed313(
    core.List<api.GoogleCloudDialogflowV2beta1IntentMessageTableCardRow> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentMessageTableCardRow(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentMessageTableCardRow);
  checkGoogleCloudDialogflowV2beta1IntentMessageTableCardRow(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentMessageTableCardRow);
}

core.int buildCounterGoogleCloudDialogflowV2beta1IntentMessageTableCard = 0;
api.GoogleCloudDialogflowV2beta1IntentMessageTableCard
    buildGoogleCloudDialogflowV2beta1IntentMessageTableCard() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageTableCard();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTableCard++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageTableCard < 3) {
    o.buttons = buildUnnamed311();
    o.columnProperties = buildUnnamed312();
    o.image = buildGoogleCloudDialogflowV2beta1IntentMessageImage();
    o.rows = buildUnnamed313();
    o.subtitle = 'foo';
    o.title = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTableCard--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageTableCard(
    api.GoogleCloudDialogflowV2beta1IntentMessageTableCard o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTableCard++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageTableCard < 3) {
    checkUnnamed311(o.buttons!);
    checkUnnamed312(o.columnProperties!);
    checkGoogleCloudDialogflowV2beta1IntentMessageImage(
        o.image! as api.GoogleCloudDialogflowV2beta1IntentMessageImage);
    checkUnnamed313(o.rows!);
    unittest.expect(
      o.subtitle!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTableCard--;
}

core.int buildCounterGoogleCloudDialogflowV2beta1IntentMessageTableCardCell = 0;
api.GoogleCloudDialogflowV2beta1IntentMessageTableCardCell
    buildGoogleCloudDialogflowV2beta1IntentMessageTableCardCell() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageTableCardCell();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTableCardCell++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageTableCardCell < 3) {
    o.text = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTableCardCell--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageTableCardCell(
    api.GoogleCloudDialogflowV2beta1IntentMessageTableCardCell o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTableCardCell++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageTableCardCell < 3) {
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTableCardCell--;
}

core.List<api.GoogleCloudDialogflowV2beta1IntentMessageTableCardCell>
    buildUnnamed314() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageTableCardCell>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageTableCardCell());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageTableCardCell());
  return o;
}

void checkUnnamed314(
    core.List<api.GoogleCloudDialogflowV2beta1IntentMessageTableCardCell> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentMessageTableCardCell(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentMessageTableCardCell);
  checkGoogleCloudDialogflowV2beta1IntentMessageTableCardCell(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentMessageTableCardCell);
}

core.int buildCounterGoogleCloudDialogflowV2beta1IntentMessageTableCardRow = 0;
api.GoogleCloudDialogflowV2beta1IntentMessageTableCardRow
    buildGoogleCloudDialogflowV2beta1IntentMessageTableCardRow() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageTableCardRow();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTableCardRow++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageTableCardRow < 3) {
    o.cells = buildUnnamed314();
    o.dividerAfter = true;
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTableCardRow--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageTableCardRow(
    api.GoogleCloudDialogflowV2beta1IntentMessageTableCardRow o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTableCardRow++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageTableCardRow < 3) {
    checkUnnamed314(o.cells!);
    unittest.expect(o.dividerAfter!, unittest.isTrue);
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTableCardRow--;
}

core.int
    buildCounterGoogleCloudDialogflowV2beta1IntentMessageTelephonyPlayAudio = 0;
api.GoogleCloudDialogflowV2beta1IntentMessageTelephonyPlayAudio
    buildGoogleCloudDialogflowV2beta1IntentMessageTelephonyPlayAudio() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageTelephonyPlayAudio();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTelephonyPlayAudio++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageTelephonyPlayAudio <
      3) {
    o.audioUri = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTelephonyPlayAudio--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageTelephonyPlayAudio(
    api.GoogleCloudDialogflowV2beta1IntentMessageTelephonyPlayAudio o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTelephonyPlayAudio++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageTelephonyPlayAudio <
      3) {
    unittest.expect(
      o.audioUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTelephonyPlayAudio--;
}

core.int
    buildCounterGoogleCloudDialogflowV2beta1IntentMessageTelephonySynthesizeSpeech =
    0;
api.GoogleCloudDialogflowV2beta1IntentMessageTelephonySynthesizeSpeech
    buildGoogleCloudDialogflowV2beta1IntentMessageTelephonySynthesizeSpeech() {
  var o =
      api.GoogleCloudDialogflowV2beta1IntentMessageTelephonySynthesizeSpeech();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTelephonySynthesizeSpeech++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageTelephonySynthesizeSpeech <
      3) {
    o.ssml = 'foo';
    o.text = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTelephonySynthesizeSpeech--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageTelephonySynthesizeSpeech(
    api.GoogleCloudDialogflowV2beta1IntentMessageTelephonySynthesizeSpeech o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTelephonySynthesizeSpeech++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageTelephonySynthesizeSpeech <
      3) {
    unittest.expect(
      o.ssml!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTelephonySynthesizeSpeech--;
}

core.int
    buildCounterGoogleCloudDialogflowV2beta1IntentMessageTelephonyTransferCall =
    0;
api.GoogleCloudDialogflowV2beta1IntentMessageTelephonyTransferCall
    buildGoogleCloudDialogflowV2beta1IntentMessageTelephonyTransferCall() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageTelephonyTransferCall();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTelephonyTransferCall++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageTelephonyTransferCall <
      3) {
    o.phoneNumber = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTelephonyTransferCall--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageTelephonyTransferCall(
    api.GoogleCloudDialogflowV2beta1IntentMessageTelephonyTransferCall o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTelephonyTransferCall++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageTelephonyTransferCall <
      3) {
    unittest.expect(
      o.phoneNumber!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTelephonyTransferCall--;
}

core.List<core.String> buildUnnamed315() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed315(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowV2beta1IntentMessageText = 0;
api.GoogleCloudDialogflowV2beta1IntentMessageText
    buildGoogleCloudDialogflowV2beta1IntentMessageText() {
  var o = api.GoogleCloudDialogflowV2beta1IntentMessageText();
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageText++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageText < 3) {
    o.text = buildUnnamed315();
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageText--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageText(
    api.GoogleCloudDialogflowV2beta1IntentMessageText o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageText++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageText < 3) {
    checkUnnamed315(o.text!);
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageText--;
}

core.List<core.String> buildUnnamed316() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed316(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowV2beta1IntentParameter = 0;
api.GoogleCloudDialogflowV2beta1IntentParameter
    buildGoogleCloudDialogflowV2beta1IntentParameter() {
  var o = api.GoogleCloudDialogflowV2beta1IntentParameter();
  buildCounterGoogleCloudDialogflowV2beta1IntentParameter++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentParameter < 3) {
    o.defaultValue = 'foo';
    o.displayName = 'foo';
    o.entityTypeDisplayName = 'foo';
    o.isList = true;
    o.mandatory = true;
    o.name = 'foo';
    o.prompts = buildUnnamed316();
    o.value = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentParameter--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentParameter(
    api.GoogleCloudDialogflowV2beta1IntentParameter o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentParameter++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentParameter < 3) {
    unittest.expect(
      o.defaultValue!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.entityTypeDisplayName!,
      unittest.equals('foo'),
    );
    unittest.expect(o.isList!, unittest.isTrue);
    unittest.expect(o.mandatory!, unittest.isTrue);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed316(o.prompts!);
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentParameter--;
}

core.List<api.GoogleCloudDialogflowV2beta1IntentTrainingPhrasePart>
    buildUnnamed317() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentTrainingPhrasePart>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentTrainingPhrasePart());
  o.add(buildGoogleCloudDialogflowV2beta1IntentTrainingPhrasePart());
  return o;
}

void checkUnnamed317(
    core.List<api.GoogleCloudDialogflowV2beta1IntentTrainingPhrasePart> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentTrainingPhrasePart(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentTrainingPhrasePart);
  checkGoogleCloudDialogflowV2beta1IntentTrainingPhrasePart(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentTrainingPhrasePart);
}

core.int buildCounterGoogleCloudDialogflowV2beta1IntentTrainingPhrase = 0;
api.GoogleCloudDialogflowV2beta1IntentTrainingPhrase
    buildGoogleCloudDialogflowV2beta1IntentTrainingPhrase() {
  var o = api.GoogleCloudDialogflowV2beta1IntentTrainingPhrase();
  buildCounterGoogleCloudDialogflowV2beta1IntentTrainingPhrase++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentTrainingPhrase < 3) {
    o.name = 'foo';
    o.parts = buildUnnamed317();
    o.timesAddedCount = 42;
    o.type = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentTrainingPhrase--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentTrainingPhrase(
    api.GoogleCloudDialogflowV2beta1IntentTrainingPhrase o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentTrainingPhrase++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentTrainingPhrase < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed317(o.parts!);
    unittest.expect(
      o.timesAddedCount!,
      unittest.equals(42),
    );
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentTrainingPhrase--;
}

core.int buildCounterGoogleCloudDialogflowV2beta1IntentTrainingPhrasePart = 0;
api.GoogleCloudDialogflowV2beta1IntentTrainingPhrasePart
    buildGoogleCloudDialogflowV2beta1IntentTrainingPhrasePart() {
  var o = api.GoogleCloudDialogflowV2beta1IntentTrainingPhrasePart();
  buildCounterGoogleCloudDialogflowV2beta1IntentTrainingPhrasePart++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentTrainingPhrasePart < 3) {
    o.alias = 'foo';
    o.entityType = 'foo';
    o.text = 'foo';
    o.userDefined = true;
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentTrainingPhrasePart--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentTrainingPhrasePart(
    api.GoogleCloudDialogflowV2beta1IntentTrainingPhrasePart o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentTrainingPhrasePart++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentTrainingPhrasePart < 3) {
    unittest.expect(
      o.alias!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.entityType!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
    unittest.expect(o.userDefined!, unittest.isTrue);
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentTrainingPhrasePart--;
}

core.List<api.GoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer>
    buildUnnamed318() {
  var o = <api.GoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer>[];
  o.add(buildGoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer());
  o.add(buildGoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer());
  return o;
}

void checkUnnamed318(
    core.List<api.GoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer(
      o[0] as api.GoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer);
  checkGoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer(
      o[1] as api.GoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer);
}

core.int buildCounterGoogleCloudDialogflowV2beta1KnowledgeAnswers = 0;
api.GoogleCloudDialogflowV2beta1KnowledgeAnswers
    buildGoogleCloudDialogflowV2beta1KnowledgeAnswers() {
  var o = api.GoogleCloudDialogflowV2beta1KnowledgeAnswers();
  buildCounterGoogleCloudDialogflowV2beta1KnowledgeAnswers++;
  if (buildCounterGoogleCloudDialogflowV2beta1KnowledgeAnswers < 3) {
    o.answers = buildUnnamed318();
  }
  buildCounterGoogleCloudDialogflowV2beta1KnowledgeAnswers--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1KnowledgeAnswers(
    api.GoogleCloudDialogflowV2beta1KnowledgeAnswers o) {
  buildCounterGoogleCloudDialogflowV2beta1KnowledgeAnswers++;
  if (buildCounterGoogleCloudDialogflowV2beta1KnowledgeAnswers < 3) {
    checkUnnamed318(o.answers!);
  }
  buildCounterGoogleCloudDialogflowV2beta1KnowledgeAnswers--;
}

core.int buildCounterGoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer = 0;
api.GoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer
    buildGoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer() {
  var o = api.GoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer();
  buildCounterGoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer++;
  if (buildCounterGoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer < 3) {
    o.answer = 'foo';
    o.faqQuestion = 'foo';
    o.matchConfidence = 42.0;
    o.matchConfidenceLevel = 'foo';
    o.source = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer(
    api.GoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer o) {
  buildCounterGoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer++;
  if (buildCounterGoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer < 3) {
    unittest.expect(
      o.answer!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.faqQuestion!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.matchConfidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.matchConfidenceLevel!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.source!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer--;
}

core.int buildCounterGoogleCloudDialogflowV2beta1KnowledgeOperationMetadata = 0;
api.GoogleCloudDialogflowV2beta1KnowledgeOperationMetadata
    buildGoogleCloudDialogflowV2beta1KnowledgeOperationMetadata() {
  var o = api.GoogleCloudDialogflowV2beta1KnowledgeOperationMetadata();
  buildCounterGoogleCloudDialogflowV2beta1KnowledgeOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowV2beta1KnowledgeOperationMetadata < 3) {
    o.state = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1KnowledgeOperationMetadata--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1KnowledgeOperationMetadata(
    api.GoogleCloudDialogflowV2beta1KnowledgeOperationMetadata o) {
  buildCounterGoogleCloudDialogflowV2beta1KnowledgeOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowV2beta1KnowledgeOperationMetadata < 3) {
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1KnowledgeOperationMetadata--;
}

core.Map<core.String, core.Object> buildUnnamed319() {
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

void checkUnnamed319(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted80 = (o['x']!) as core.Map;
  unittest.expect(casted80, unittest.hasLength(3));
  unittest.expect(
    casted80['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted80['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted80['string'],
    unittest.equals('foo'),
  );
  var casted81 = (o['y']!) as core.Map;
  unittest.expect(casted81, unittest.hasLength(3));
  unittest.expect(
    casted81['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted81['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted81['string'],
    unittest.equals('foo'),
  );
}

core.int buildCounterGoogleCloudDialogflowV2beta1OriginalDetectIntentRequest =
    0;
api.GoogleCloudDialogflowV2beta1OriginalDetectIntentRequest
    buildGoogleCloudDialogflowV2beta1OriginalDetectIntentRequest() {
  var o = api.GoogleCloudDialogflowV2beta1OriginalDetectIntentRequest();
  buildCounterGoogleCloudDialogflowV2beta1OriginalDetectIntentRequest++;
  if (buildCounterGoogleCloudDialogflowV2beta1OriginalDetectIntentRequest < 3) {
    o.payload = buildUnnamed319();
    o.source = 'foo';
    o.version = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1OriginalDetectIntentRequest--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1OriginalDetectIntentRequest(
    api.GoogleCloudDialogflowV2beta1OriginalDetectIntentRequest o) {
  buildCounterGoogleCloudDialogflowV2beta1OriginalDetectIntentRequest++;
  if (buildCounterGoogleCloudDialogflowV2beta1OriginalDetectIntentRequest < 3) {
    checkUnnamed319(o.payload!);
    unittest.expect(
      o.source!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1OriginalDetectIntentRequest--;
}

core.Map<core.String, core.Object> buildUnnamed320() {
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

void checkUnnamed320(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted82 = (o['x']!) as core.Map;
  unittest.expect(casted82, unittest.hasLength(3));
  unittest.expect(
    casted82['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted82['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted82['string'],
    unittest.equals('foo'),
  );
  var casted83 = (o['y']!) as core.Map;
  unittest.expect(casted83, unittest.hasLength(3));
  unittest.expect(
    casted83['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted83['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted83['string'],
    unittest.equals('foo'),
  );
}

core.List<api.GoogleCloudDialogflowV2beta1IntentMessage> buildUnnamed321() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessage>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessage());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessage());
  return o;
}

void checkUnnamed321(
    core.List<api.GoogleCloudDialogflowV2beta1IntentMessage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentMessage(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentMessage);
  checkGoogleCloudDialogflowV2beta1IntentMessage(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentMessage);
}

core.List<api.GoogleCloudDialogflowV2beta1Context> buildUnnamed322() {
  var o = <api.GoogleCloudDialogflowV2beta1Context>[];
  o.add(buildGoogleCloudDialogflowV2beta1Context());
  o.add(buildGoogleCloudDialogflowV2beta1Context());
  return o;
}

void checkUnnamed322(core.List<api.GoogleCloudDialogflowV2beta1Context> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1Context(
      o[0] as api.GoogleCloudDialogflowV2beta1Context);
  checkGoogleCloudDialogflowV2beta1Context(
      o[1] as api.GoogleCloudDialogflowV2beta1Context);
}

core.Map<core.String, core.Object> buildUnnamed323() {
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

void checkUnnamed323(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted84 = (o['x']!) as core.Map;
  unittest.expect(casted84, unittest.hasLength(3));
  unittest.expect(
    casted84['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted84['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted84['string'],
    unittest.equals('foo'),
  );
  var casted85 = (o['y']!) as core.Map;
  unittest.expect(casted85, unittest.hasLength(3));
  unittest.expect(
    casted85['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted85['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted85['string'],
    unittest.equals('foo'),
  );
}

core.Map<core.String, core.Object> buildUnnamed324() {
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

void checkUnnamed324(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted86 = (o['x']!) as core.Map;
  unittest.expect(casted86, unittest.hasLength(3));
  unittest.expect(
    casted86['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted86['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted86['string'],
    unittest.equals('foo'),
  );
  var casted87 = (o['y']!) as core.Map;
  unittest.expect(casted87, unittest.hasLength(3));
  unittest.expect(
    casted87['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted87['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted87['string'],
    unittest.equals('foo'),
  );
}

core.int buildCounterGoogleCloudDialogflowV2beta1QueryResult = 0;
api.GoogleCloudDialogflowV2beta1QueryResult
    buildGoogleCloudDialogflowV2beta1QueryResult() {
  var o = api.GoogleCloudDialogflowV2beta1QueryResult();
  buildCounterGoogleCloudDialogflowV2beta1QueryResult++;
  if (buildCounterGoogleCloudDialogflowV2beta1QueryResult < 3) {
    o.action = 'foo';
    o.allRequiredParamsPresent = true;
    o.diagnosticInfo = buildUnnamed320();
    o.fulfillmentMessages = buildUnnamed321();
    o.fulfillmentText = 'foo';
    o.intent = buildGoogleCloudDialogflowV2beta1Intent();
    o.intentDetectionConfidence = 42.0;
    o.knowledgeAnswers = buildGoogleCloudDialogflowV2beta1KnowledgeAnswers();
    o.languageCode = 'foo';
    o.outputContexts = buildUnnamed322();
    o.parameters = buildUnnamed323();
    o.queryText = 'foo';
    o.sentimentAnalysisResult =
        buildGoogleCloudDialogflowV2beta1SentimentAnalysisResult();
    o.speechRecognitionConfidence = 42.0;
    o.webhookPayload = buildUnnamed324();
    o.webhookSource = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1QueryResult--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1QueryResult(
    api.GoogleCloudDialogflowV2beta1QueryResult o) {
  buildCounterGoogleCloudDialogflowV2beta1QueryResult++;
  if (buildCounterGoogleCloudDialogflowV2beta1QueryResult < 3) {
    unittest.expect(
      o.action!,
      unittest.equals('foo'),
    );
    unittest.expect(o.allRequiredParamsPresent!, unittest.isTrue);
    checkUnnamed320(o.diagnosticInfo!);
    checkUnnamed321(o.fulfillmentMessages!);
    unittest.expect(
      o.fulfillmentText!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowV2beta1Intent(
        o.intent! as api.GoogleCloudDialogflowV2beta1Intent);
    unittest.expect(
      o.intentDetectionConfidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudDialogflowV2beta1KnowledgeAnswers(o.knowledgeAnswers!
        as api.GoogleCloudDialogflowV2beta1KnowledgeAnswers);
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
    checkUnnamed322(o.outputContexts!);
    checkUnnamed323(o.parameters!);
    unittest.expect(
      o.queryText!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowV2beta1SentimentAnalysisResult(
        o.sentimentAnalysisResult!
            as api.GoogleCloudDialogflowV2beta1SentimentAnalysisResult);
    unittest.expect(
      o.speechRecognitionConfidence!,
      unittest.equals(42.0),
    );
    checkUnnamed324(o.webhookPayload!);
    unittest.expect(
      o.webhookSource!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1QueryResult--;
}

core.int buildCounterGoogleCloudDialogflowV2beta1Sentiment = 0;
api.GoogleCloudDialogflowV2beta1Sentiment
    buildGoogleCloudDialogflowV2beta1Sentiment() {
  var o = api.GoogleCloudDialogflowV2beta1Sentiment();
  buildCounterGoogleCloudDialogflowV2beta1Sentiment++;
  if (buildCounterGoogleCloudDialogflowV2beta1Sentiment < 3) {
    o.magnitude = 42.0;
    o.score = 42.0;
  }
  buildCounterGoogleCloudDialogflowV2beta1Sentiment--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1Sentiment(
    api.GoogleCloudDialogflowV2beta1Sentiment o) {
  buildCounterGoogleCloudDialogflowV2beta1Sentiment++;
  if (buildCounterGoogleCloudDialogflowV2beta1Sentiment < 3) {
    unittest.expect(
      o.magnitude!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1Sentiment--;
}

core.int buildCounterGoogleCloudDialogflowV2beta1SentimentAnalysisResult = 0;
api.GoogleCloudDialogflowV2beta1SentimentAnalysisResult
    buildGoogleCloudDialogflowV2beta1SentimentAnalysisResult() {
  var o = api.GoogleCloudDialogflowV2beta1SentimentAnalysisResult();
  buildCounterGoogleCloudDialogflowV2beta1SentimentAnalysisResult++;
  if (buildCounterGoogleCloudDialogflowV2beta1SentimentAnalysisResult < 3) {
    o.queryTextSentiment = buildGoogleCloudDialogflowV2beta1Sentiment();
  }
  buildCounterGoogleCloudDialogflowV2beta1SentimentAnalysisResult--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1SentimentAnalysisResult(
    api.GoogleCloudDialogflowV2beta1SentimentAnalysisResult o) {
  buildCounterGoogleCloudDialogflowV2beta1SentimentAnalysisResult++;
  if (buildCounterGoogleCloudDialogflowV2beta1SentimentAnalysisResult < 3) {
    checkGoogleCloudDialogflowV2beta1Sentiment(
        o.queryTextSentiment! as api.GoogleCloudDialogflowV2beta1Sentiment);
  }
  buildCounterGoogleCloudDialogflowV2beta1SentimentAnalysisResult--;
}

core.List<api.GoogleCloudDialogflowV2beta1EntityTypeEntity> buildUnnamed325() {
  var o = <api.GoogleCloudDialogflowV2beta1EntityTypeEntity>[];
  o.add(buildGoogleCloudDialogflowV2beta1EntityTypeEntity());
  o.add(buildGoogleCloudDialogflowV2beta1EntityTypeEntity());
  return o;
}

void checkUnnamed325(
    core.List<api.GoogleCloudDialogflowV2beta1EntityTypeEntity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1EntityTypeEntity(
      o[0] as api.GoogleCloudDialogflowV2beta1EntityTypeEntity);
  checkGoogleCloudDialogflowV2beta1EntityTypeEntity(
      o[1] as api.GoogleCloudDialogflowV2beta1EntityTypeEntity);
}

core.int buildCounterGoogleCloudDialogflowV2beta1SessionEntityType = 0;
api.GoogleCloudDialogflowV2beta1SessionEntityType
    buildGoogleCloudDialogflowV2beta1SessionEntityType() {
  var o = api.GoogleCloudDialogflowV2beta1SessionEntityType();
  buildCounterGoogleCloudDialogflowV2beta1SessionEntityType++;
  if (buildCounterGoogleCloudDialogflowV2beta1SessionEntityType < 3) {
    o.entities = buildUnnamed325();
    o.entityOverrideMode = 'foo';
    o.name = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1SessionEntityType--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1SessionEntityType(
    api.GoogleCloudDialogflowV2beta1SessionEntityType o) {
  buildCounterGoogleCloudDialogflowV2beta1SessionEntityType++;
  if (buildCounterGoogleCloudDialogflowV2beta1SessionEntityType < 3) {
    checkUnnamed325(o.entities!);
    unittest.expect(
      o.entityOverrideMode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1SessionEntityType--;
}

core.List<api.GoogleCloudDialogflowV2beta1QueryResult> buildUnnamed326() {
  var o = <api.GoogleCloudDialogflowV2beta1QueryResult>[];
  o.add(buildGoogleCloudDialogflowV2beta1QueryResult());
  o.add(buildGoogleCloudDialogflowV2beta1QueryResult());
  return o;
}

void checkUnnamed326(core.List<api.GoogleCloudDialogflowV2beta1QueryResult> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1QueryResult(
      o[0] as api.GoogleCloudDialogflowV2beta1QueryResult);
  checkGoogleCloudDialogflowV2beta1QueryResult(
      o[1] as api.GoogleCloudDialogflowV2beta1QueryResult);
}

core.int buildCounterGoogleCloudDialogflowV2beta1WebhookRequest = 0;
api.GoogleCloudDialogflowV2beta1WebhookRequest
    buildGoogleCloudDialogflowV2beta1WebhookRequest() {
  var o = api.GoogleCloudDialogflowV2beta1WebhookRequest();
  buildCounterGoogleCloudDialogflowV2beta1WebhookRequest++;
  if (buildCounterGoogleCloudDialogflowV2beta1WebhookRequest < 3) {
    o.alternativeQueryResults = buildUnnamed326();
    o.originalDetectIntentRequest =
        buildGoogleCloudDialogflowV2beta1OriginalDetectIntentRequest();
    o.queryResult = buildGoogleCloudDialogflowV2beta1QueryResult();
    o.responseId = 'foo';
    o.session = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1WebhookRequest--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1WebhookRequest(
    api.GoogleCloudDialogflowV2beta1WebhookRequest o) {
  buildCounterGoogleCloudDialogflowV2beta1WebhookRequest++;
  if (buildCounterGoogleCloudDialogflowV2beta1WebhookRequest < 3) {
    checkUnnamed326(o.alternativeQueryResults!);
    checkGoogleCloudDialogflowV2beta1OriginalDetectIntentRequest(
        o.originalDetectIntentRequest!
            as api.GoogleCloudDialogflowV2beta1OriginalDetectIntentRequest);
    checkGoogleCloudDialogflowV2beta1QueryResult(
        o.queryResult! as api.GoogleCloudDialogflowV2beta1QueryResult);
    unittest.expect(
      o.responseId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.session!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1WebhookRequest--;
}

core.List<api.GoogleCloudDialogflowV2beta1IntentMessage> buildUnnamed327() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessage>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessage());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessage());
  return o;
}

void checkUnnamed327(
    core.List<api.GoogleCloudDialogflowV2beta1IntentMessage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentMessage(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentMessage);
  checkGoogleCloudDialogflowV2beta1IntentMessage(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentMessage);
}

core.List<api.GoogleCloudDialogflowV2beta1Context> buildUnnamed328() {
  var o = <api.GoogleCloudDialogflowV2beta1Context>[];
  o.add(buildGoogleCloudDialogflowV2beta1Context());
  o.add(buildGoogleCloudDialogflowV2beta1Context());
  return o;
}

void checkUnnamed328(core.List<api.GoogleCloudDialogflowV2beta1Context> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1Context(
      o[0] as api.GoogleCloudDialogflowV2beta1Context);
  checkGoogleCloudDialogflowV2beta1Context(
      o[1] as api.GoogleCloudDialogflowV2beta1Context);
}

core.Map<core.String, core.Object> buildUnnamed329() {
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

void checkUnnamed329(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted88 = (o['x']!) as core.Map;
  unittest.expect(casted88, unittest.hasLength(3));
  unittest.expect(
    casted88['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted88['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted88['string'],
    unittest.equals('foo'),
  );
  var casted89 = (o['y']!) as core.Map;
  unittest.expect(casted89, unittest.hasLength(3));
  unittest.expect(
    casted89['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted89['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted89['string'],
    unittest.equals('foo'),
  );
}

core.List<api.GoogleCloudDialogflowV2beta1SessionEntityType> buildUnnamed330() {
  var o = <api.GoogleCloudDialogflowV2beta1SessionEntityType>[];
  o.add(buildGoogleCloudDialogflowV2beta1SessionEntityType());
  o.add(buildGoogleCloudDialogflowV2beta1SessionEntityType());
  return o;
}

void checkUnnamed330(
    core.List<api.GoogleCloudDialogflowV2beta1SessionEntityType> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1SessionEntityType(
      o[0] as api.GoogleCloudDialogflowV2beta1SessionEntityType);
  checkGoogleCloudDialogflowV2beta1SessionEntityType(
      o[1] as api.GoogleCloudDialogflowV2beta1SessionEntityType);
}

core.int buildCounterGoogleCloudDialogflowV2beta1WebhookResponse = 0;
api.GoogleCloudDialogflowV2beta1WebhookResponse
    buildGoogleCloudDialogflowV2beta1WebhookResponse() {
  var o = api.GoogleCloudDialogflowV2beta1WebhookResponse();
  buildCounterGoogleCloudDialogflowV2beta1WebhookResponse++;
  if (buildCounterGoogleCloudDialogflowV2beta1WebhookResponse < 3) {
    o.endInteraction = true;
    o.followupEventInput = buildGoogleCloudDialogflowV2beta1EventInput();
    o.fulfillmentMessages = buildUnnamed327();
    o.fulfillmentText = 'foo';
    o.outputContexts = buildUnnamed328();
    o.payload = buildUnnamed329();
    o.sessionEntityTypes = buildUnnamed330();
    o.source = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1WebhookResponse--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1WebhookResponse(
    api.GoogleCloudDialogflowV2beta1WebhookResponse o) {
  buildCounterGoogleCloudDialogflowV2beta1WebhookResponse++;
  if (buildCounterGoogleCloudDialogflowV2beta1WebhookResponse < 3) {
    unittest.expect(o.endInteraction!, unittest.isTrue);
    checkGoogleCloudDialogflowV2beta1EventInput(
        o.followupEventInput! as api.GoogleCloudDialogflowV2beta1EventInput);
    checkUnnamed327(o.fulfillmentMessages!);
    unittest.expect(
      o.fulfillmentText!,
      unittest.equals('foo'),
    );
    checkUnnamed328(o.outputContexts!);
    checkUnnamed329(o.payload!);
    checkUnnamed330(o.sessionEntityTypes!);
    unittest.expect(
      o.source!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1WebhookResponse--;
}

core.int
    buildCounterGoogleCloudDialogflowV3alpha1CreateDocumentOperationMetadata =
    0;
api.GoogleCloudDialogflowV3alpha1CreateDocumentOperationMetadata
    buildGoogleCloudDialogflowV3alpha1CreateDocumentOperationMetadata() {
  var o = api.GoogleCloudDialogflowV3alpha1CreateDocumentOperationMetadata();
  buildCounterGoogleCloudDialogflowV3alpha1CreateDocumentOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowV3alpha1CreateDocumentOperationMetadata <
      3) {
    o.genericMetadata =
        buildGoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata();
  }
  buildCounterGoogleCloudDialogflowV3alpha1CreateDocumentOperationMetadata--;
  return o;
}

void checkGoogleCloudDialogflowV3alpha1CreateDocumentOperationMetadata(
    api.GoogleCloudDialogflowV3alpha1CreateDocumentOperationMetadata o) {
  buildCounterGoogleCloudDialogflowV3alpha1CreateDocumentOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowV3alpha1CreateDocumentOperationMetadata <
      3) {
    checkGoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata(o
            .genericMetadata!
        as api.GoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata);
  }
  buildCounterGoogleCloudDialogflowV3alpha1CreateDocumentOperationMetadata--;
}

core.int
    buildCounterGoogleCloudDialogflowV3alpha1DeleteDocumentOperationMetadata =
    0;
api.GoogleCloudDialogflowV3alpha1DeleteDocumentOperationMetadata
    buildGoogleCloudDialogflowV3alpha1DeleteDocumentOperationMetadata() {
  var o = api.GoogleCloudDialogflowV3alpha1DeleteDocumentOperationMetadata();
  buildCounterGoogleCloudDialogflowV3alpha1DeleteDocumentOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowV3alpha1DeleteDocumentOperationMetadata <
      3) {
    o.genericMetadata =
        buildGoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata();
  }
  buildCounterGoogleCloudDialogflowV3alpha1DeleteDocumentOperationMetadata--;
  return o;
}

void checkGoogleCloudDialogflowV3alpha1DeleteDocumentOperationMetadata(
    api.GoogleCloudDialogflowV3alpha1DeleteDocumentOperationMetadata o) {
  buildCounterGoogleCloudDialogflowV3alpha1DeleteDocumentOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowV3alpha1DeleteDocumentOperationMetadata <
      3) {
    checkGoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata(o
            .genericMetadata!
        as api.GoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata);
  }
  buildCounterGoogleCloudDialogflowV3alpha1DeleteDocumentOperationMetadata--;
}

core.int
    buildCounterGoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata =
    0;
api.GoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata
    buildGoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata() {
  var o = api.GoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata();
  buildCounterGoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata <
      3) {
    o.state = 'foo';
  }
  buildCounterGoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata--;
  return o;
}

void checkGoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata(
    api.GoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata o) {
  buildCounterGoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata <
      3) {
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata--;
}

core.int
    buildCounterGoogleCloudDialogflowV3alpha1ImportDocumentsOperationMetadata =
    0;
api.GoogleCloudDialogflowV3alpha1ImportDocumentsOperationMetadata
    buildGoogleCloudDialogflowV3alpha1ImportDocumentsOperationMetadata() {
  var o = api.GoogleCloudDialogflowV3alpha1ImportDocumentsOperationMetadata();
  buildCounterGoogleCloudDialogflowV3alpha1ImportDocumentsOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowV3alpha1ImportDocumentsOperationMetadata <
      3) {
    o.genericMetadata =
        buildGoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata();
  }
  buildCounterGoogleCloudDialogflowV3alpha1ImportDocumentsOperationMetadata--;
  return o;
}

void checkGoogleCloudDialogflowV3alpha1ImportDocumentsOperationMetadata(
    api.GoogleCloudDialogflowV3alpha1ImportDocumentsOperationMetadata o) {
  buildCounterGoogleCloudDialogflowV3alpha1ImportDocumentsOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowV3alpha1ImportDocumentsOperationMetadata <
      3) {
    checkGoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata(o
            .genericMetadata!
        as api.GoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata);
  }
  buildCounterGoogleCloudDialogflowV3alpha1ImportDocumentsOperationMetadata--;
}

core.List<api.GoogleRpcStatus> buildUnnamed331() {
  var o = <api.GoogleRpcStatus>[];
  o.add(buildGoogleRpcStatus());
  o.add(buildGoogleRpcStatus());
  return o;
}

void checkUnnamed331(core.List<api.GoogleRpcStatus> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleRpcStatus(o[0] as api.GoogleRpcStatus);
  checkGoogleRpcStatus(o[1] as api.GoogleRpcStatus);
}

core.int buildCounterGoogleCloudDialogflowV3alpha1ImportDocumentsResponse = 0;
api.GoogleCloudDialogflowV3alpha1ImportDocumentsResponse
    buildGoogleCloudDialogflowV3alpha1ImportDocumentsResponse() {
  var o = api.GoogleCloudDialogflowV3alpha1ImportDocumentsResponse();
  buildCounterGoogleCloudDialogflowV3alpha1ImportDocumentsResponse++;
  if (buildCounterGoogleCloudDialogflowV3alpha1ImportDocumentsResponse < 3) {
    o.warnings = buildUnnamed331();
  }
  buildCounterGoogleCloudDialogflowV3alpha1ImportDocumentsResponse--;
  return o;
}

void checkGoogleCloudDialogflowV3alpha1ImportDocumentsResponse(
    api.GoogleCloudDialogflowV3alpha1ImportDocumentsResponse o) {
  buildCounterGoogleCloudDialogflowV3alpha1ImportDocumentsResponse++;
  if (buildCounterGoogleCloudDialogflowV3alpha1ImportDocumentsResponse < 3) {
    checkUnnamed331(o.warnings!);
  }
  buildCounterGoogleCloudDialogflowV3alpha1ImportDocumentsResponse--;
}

core.int
    buildCounterGoogleCloudDialogflowV3alpha1ReloadDocumentOperationMetadata =
    0;
api.GoogleCloudDialogflowV3alpha1ReloadDocumentOperationMetadata
    buildGoogleCloudDialogflowV3alpha1ReloadDocumentOperationMetadata() {
  var o = api.GoogleCloudDialogflowV3alpha1ReloadDocumentOperationMetadata();
  buildCounterGoogleCloudDialogflowV3alpha1ReloadDocumentOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowV3alpha1ReloadDocumentOperationMetadata <
      3) {
    o.genericMetadata =
        buildGoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata();
  }
  buildCounterGoogleCloudDialogflowV3alpha1ReloadDocumentOperationMetadata--;
  return o;
}

void checkGoogleCloudDialogflowV3alpha1ReloadDocumentOperationMetadata(
    api.GoogleCloudDialogflowV3alpha1ReloadDocumentOperationMetadata o) {
  buildCounterGoogleCloudDialogflowV3alpha1ReloadDocumentOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowV3alpha1ReloadDocumentOperationMetadata <
      3) {
    checkGoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata(o
            .genericMetadata!
        as api.GoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata);
  }
  buildCounterGoogleCloudDialogflowV3alpha1ReloadDocumentOperationMetadata--;
}

core.int
    buildCounterGoogleCloudDialogflowV3alpha1UpdateDocumentOperationMetadata =
    0;
api.GoogleCloudDialogflowV3alpha1UpdateDocumentOperationMetadata
    buildGoogleCloudDialogflowV3alpha1UpdateDocumentOperationMetadata() {
  var o = api.GoogleCloudDialogflowV3alpha1UpdateDocumentOperationMetadata();
  buildCounterGoogleCloudDialogflowV3alpha1UpdateDocumentOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowV3alpha1UpdateDocumentOperationMetadata <
      3) {
    o.genericMetadata =
        buildGoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata();
  }
  buildCounterGoogleCloudDialogflowV3alpha1UpdateDocumentOperationMetadata--;
  return o;
}

void checkGoogleCloudDialogflowV3alpha1UpdateDocumentOperationMetadata(
    api.GoogleCloudDialogflowV3alpha1UpdateDocumentOperationMetadata o) {
  buildCounterGoogleCloudDialogflowV3alpha1UpdateDocumentOperationMetadata++;
  if (buildCounterGoogleCloudDialogflowV3alpha1UpdateDocumentOperationMetadata <
      3) {
    checkGoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata(o
            .genericMetadata!
        as api.GoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata);
  }
  buildCounterGoogleCloudDialogflowV3alpha1UpdateDocumentOperationMetadata--;
}

core.List<api.GoogleLongrunningOperation> buildUnnamed332() {
  var o = <api.GoogleLongrunningOperation>[];
  o.add(buildGoogleLongrunningOperation());
  o.add(buildGoogleLongrunningOperation());
  return o;
}

void checkUnnamed332(core.List<api.GoogleLongrunningOperation> o) {
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
    o.operations = buildUnnamed332();
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
    checkUnnamed332(o.operations!);
  }
  buildCounterGoogleLongrunningListOperationsResponse--;
}

core.Map<core.String, core.Object> buildUnnamed333() {
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

void checkUnnamed333(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted90 = (o['x']!) as core.Map;
  unittest.expect(casted90, unittest.hasLength(3));
  unittest.expect(
    casted90['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted90['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted90['string'],
    unittest.equals('foo'),
  );
  var casted91 = (o['y']!) as core.Map;
  unittest.expect(casted91, unittest.hasLength(3));
  unittest.expect(
    casted91['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted91['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted91['string'],
    unittest.equals('foo'),
  );
}

core.Map<core.String, core.Object> buildUnnamed334() {
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

void checkUnnamed334(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted92 = (o['x']!) as core.Map;
  unittest.expect(casted92, unittest.hasLength(3));
  unittest.expect(
    casted92['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted92['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted92['string'],
    unittest.equals('foo'),
  );
  var casted93 = (o['y']!) as core.Map;
  unittest.expect(casted93, unittest.hasLength(3));
  unittest.expect(
    casted93['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted93['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted93['string'],
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
    o.metadata = buildUnnamed333();
    o.name = 'foo';
    o.response = buildUnnamed334();
  }
  buildCounterGoogleLongrunningOperation--;
  return o;
}

void checkGoogleLongrunningOperation(api.GoogleLongrunningOperation o) {
  buildCounterGoogleLongrunningOperation++;
  if (buildCounterGoogleLongrunningOperation < 3) {
    unittest.expect(o.done!, unittest.isTrue);
    checkGoogleRpcStatus(o.error! as api.GoogleRpcStatus);
    checkUnnamed333(o.metadata!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed334(o.response!);
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

core.Map<core.String, core.Object> buildUnnamed335() {
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

void checkUnnamed335(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted94 = (o['x']!) as core.Map;
  unittest.expect(casted94, unittest.hasLength(3));
  unittest.expect(
    casted94['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted94['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted94['string'],
    unittest.equals('foo'),
  );
  var casted95 = (o['y']!) as core.Map;
  unittest.expect(casted95, unittest.hasLength(3));
  unittest.expect(
    casted95['list'],
    unittest.equals([1, 2, 3]),
  );
  unittest.expect(
    casted95['bool'],
    unittest.equals(true),
  );
  unittest.expect(
    casted95['string'],
    unittest.equals('foo'),
  );
}

core.List<core.Map<core.String, core.Object>> buildUnnamed336() {
  var o = <core.Map<core.String, core.Object>>[];
  o.add(buildUnnamed335());
  o.add(buildUnnamed335());
  return o;
}

void checkUnnamed336(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed335(o[0]);
  checkUnnamed335(o[1]);
}

core.int buildCounterGoogleRpcStatus = 0;
api.GoogleRpcStatus buildGoogleRpcStatus() {
  var o = api.GoogleRpcStatus();
  buildCounterGoogleRpcStatus++;
  if (buildCounterGoogleRpcStatus < 3) {
    o.code = 42;
    o.details = buildUnnamed336();
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
    checkUnnamed336(o.details!);
    unittest.expect(
      o.message!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleRpcStatus--;
}

core.int buildCounterGoogleTypeLatLng = 0;
api.GoogleTypeLatLng buildGoogleTypeLatLng() {
  var o = api.GoogleTypeLatLng();
  buildCounterGoogleTypeLatLng++;
  if (buildCounterGoogleTypeLatLng < 3) {
    o.latitude = 42.0;
    o.longitude = 42.0;
  }
  buildCounterGoogleTypeLatLng--;
  return o;
}

void checkGoogleTypeLatLng(api.GoogleTypeLatLng o) {
  buildCounterGoogleTypeLatLng++;
  if (buildCounterGoogleTypeLatLng < 3) {
    unittest.expect(
      o.latitude!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.longitude!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleTypeLatLng--;
}

void main() {
  unittest.group('obj-schema-GoogleCloudDialogflowCxV3Agent', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3Agent();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3Agent.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3Agent(
          od as api.GoogleCloudDialogflowCxV3Agent);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3AgentValidationResult',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3AgentValidationResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3AgentValidationResult.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3AgentValidationResult(
          od as api.GoogleCloudDialogflowCxV3AgentValidationResult);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3AudioInput', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3AudioInput();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3AudioInput.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3AudioInput(
          od as api.GoogleCloudDialogflowCxV3AudioInput);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3BatchDeleteTestCasesRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3BatchDeleteTestCasesRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3BatchDeleteTestCasesRequest.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3BatchDeleteTestCasesRequest(
          od as api.GoogleCloudDialogflowCxV3BatchDeleteTestCasesRequest);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3BatchRunTestCasesMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3BatchRunTestCasesMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3BatchRunTestCasesMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3BatchRunTestCasesMetadata(
          od as api.GoogleCloudDialogflowCxV3BatchRunTestCasesMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3BatchRunTestCasesRequest',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3BatchRunTestCasesRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3BatchRunTestCasesRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3BatchRunTestCasesRequest(
          od as api.GoogleCloudDialogflowCxV3BatchRunTestCasesRequest);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3BatchRunTestCasesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3BatchRunTestCasesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3BatchRunTestCasesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3BatchRunTestCasesResponse(
          od as api.GoogleCloudDialogflowCxV3BatchRunTestCasesResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3CalculateCoverageResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3CalculateCoverageResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3CalculateCoverageResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3CalculateCoverageResponse(
          od as api.GoogleCloudDialogflowCxV3CalculateCoverageResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ConversationTurn', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ConversationTurn();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ConversationTurn.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ConversationTurn(
          od as api.GoogleCloudDialogflowCxV3ConversationTurn);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3ConversationTurnUserInput', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ConversationTurnUserInput();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ConversationTurnUserInput.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ConversationTurnUserInput(
          od as api.GoogleCloudDialogflowCxV3ConversationTurnUserInput);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3ConversationTurnVirtualAgentOutput',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3ConversationTurnVirtualAgentOutput();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ConversationTurnVirtualAgentOutput
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ConversationTurnVirtualAgentOutput(od
          as api.GoogleCloudDialogflowCxV3ConversationTurnVirtualAgentOutput);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3CreateDocumentOperationMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3CreateDocumentOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3CreateDocumentOperationMetadata.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3CreateDocumentOperationMetadata(
          od as api.GoogleCloudDialogflowCxV3CreateDocumentOperationMetadata);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3CreateVersionOperationMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3CreateVersionOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3CreateVersionOperationMetadata.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3CreateVersionOperationMetadata(
          od as api.GoogleCloudDialogflowCxV3CreateVersionOperationMetadata);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3DeleteDocumentOperationMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3DeleteDocumentOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3DeleteDocumentOperationMetadata.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3DeleteDocumentOperationMetadata(
          od as api.GoogleCloudDialogflowCxV3DeleteDocumentOperationMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3DetectIntentRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3DetectIntentRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3DetectIntentRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3DetectIntentRequest(
          od as api.GoogleCloudDialogflowCxV3DetectIntentRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3DetectIntentResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3DetectIntentResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3DetectIntentResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3DetectIntentResponse(
          od as api.GoogleCloudDialogflowCxV3DetectIntentResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3DtmfInput', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3DtmfInput();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3DtmfInput.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3DtmfInput(
          od as api.GoogleCloudDialogflowCxV3DtmfInput);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3EntityType', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3EntityType();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3EntityType.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3EntityType(
          od as api.GoogleCloudDialogflowCxV3EntityType);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3EntityTypeEntity', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3EntityTypeEntity();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3EntityTypeEntity.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3EntityTypeEntity(
          od as api.GoogleCloudDialogflowCxV3EntityTypeEntity);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3EntityTypeExcludedPhrase',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3EntityTypeExcludedPhrase();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3EntityTypeExcludedPhrase.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3EntityTypeExcludedPhrase(
          od as api.GoogleCloudDialogflowCxV3EntityTypeExcludedPhrase);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3Environment', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3Environment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3Environment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3Environment(
          od as api.GoogleCloudDialogflowCxV3Environment);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3EnvironmentVersionConfig',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3EnvironmentVersionConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3EnvironmentVersionConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3EnvironmentVersionConfig(
          od as api.GoogleCloudDialogflowCxV3EnvironmentVersionConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3EventHandler', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3EventHandler();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3EventHandler.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3EventHandler(
          od as api.GoogleCloudDialogflowCxV3EventHandler);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3EventInput', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3EventInput();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3EventInput.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3EventInput(
          od as api.GoogleCloudDialogflowCxV3EventInput);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3Experiment', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3Experiment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3Experiment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3Experiment(
          od as api.GoogleCloudDialogflowCxV3Experiment);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ExperimentDefinition',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ExperimentDefinition();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ExperimentDefinition.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ExperimentDefinition(
          od as api.GoogleCloudDialogflowCxV3ExperimentDefinition);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ExperimentResult', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ExperimentResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ExperimentResult.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ExperimentResult(
          od as api.GoogleCloudDialogflowCxV3ExperimentResult);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3ExperimentResultConfidenceInterval',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3ExperimentResultConfidenceInterval();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ExperimentResultConfidenceInterval
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ExperimentResultConfidenceInterval(od
          as api.GoogleCloudDialogflowCxV3ExperimentResultConfidenceInterval);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ExperimentResultMetric',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ExperimentResultMetric();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ExperimentResultMetric.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ExperimentResultMetric(
          od as api.GoogleCloudDialogflowCxV3ExperimentResultMetric);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3ExperimentResultVersionMetrics', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ExperimentResultVersionMetrics();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3ExperimentResultVersionMetrics.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ExperimentResultVersionMetrics(
          od as api.GoogleCloudDialogflowCxV3ExperimentResultVersionMetrics);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ExportAgentRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ExportAgentRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ExportAgentRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ExportAgentRequest(
          od as api.GoogleCloudDialogflowCxV3ExportAgentRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ExportAgentResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ExportAgentResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ExportAgentResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ExportAgentResponse(
          od as api.GoogleCloudDialogflowCxV3ExportAgentResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ExportTestCasesMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ExportTestCasesMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ExportTestCasesMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ExportTestCasesMetadata(
          od as api.GoogleCloudDialogflowCxV3ExportTestCasesMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ExportTestCasesRequest',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ExportTestCasesRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ExportTestCasesRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ExportTestCasesRequest(
          od as api.GoogleCloudDialogflowCxV3ExportTestCasesRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ExportTestCasesResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ExportTestCasesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ExportTestCasesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ExportTestCasesResponse(
          od as api.GoogleCloudDialogflowCxV3ExportTestCasesResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3Flow', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3Flow();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3Flow.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3Flow(
          od as api.GoogleCloudDialogflowCxV3Flow);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3FlowValidationResult',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3FlowValidationResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3FlowValidationResult.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3FlowValidationResult(
          od as api.GoogleCloudDialogflowCxV3FlowValidationResult);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3Form', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3Form();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3Form.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3Form(
          od as api.GoogleCloudDialogflowCxV3Form);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3FormParameter', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3FormParameter();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3FormParameter.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3FormParameter(
          od as api.GoogleCloudDialogflowCxV3FormParameter);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3FormParameterFillBehavior', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3FormParameterFillBehavior();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3FormParameterFillBehavior.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3FormParameterFillBehavior(
          od as api.GoogleCloudDialogflowCxV3FormParameterFillBehavior);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3FulfillIntentRequest',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3FulfillIntentRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3FulfillIntentRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3FulfillIntentRequest(
          od as api.GoogleCloudDialogflowCxV3FulfillIntentRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3FulfillIntentResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3FulfillIntentResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3FulfillIntentResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3FulfillIntentResponse(
          od as api.GoogleCloudDialogflowCxV3FulfillIntentResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3Fulfillment', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3Fulfillment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3Fulfillment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3Fulfillment(
          od as api.GoogleCloudDialogflowCxV3Fulfillment);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3FulfillmentConditionalCases', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3FulfillmentConditionalCases();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3FulfillmentConditionalCases.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3FulfillmentConditionalCases(
          od as api.GoogleCloudDialogflowCxV3FulfillmentConditionalCases);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase(
          od as api.GoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent(
          od as api
              .GoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3FulfillmentSetParameterAction', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3FulfillmentSetParameterAction();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3FulfillmentSetParameterAction.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3FulfillmentSetParameterAction(
          od as api.GoogleCloudDialogflowCxV3FulfillmentSetParameterAction);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata(
          od as api.GoogleCloudDialogflowCxV3GenericKnowledgeOperationMetadata);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3ImportDocumentsOperationMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ImportDocumentsOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ImportDocumentsOperationMetadata
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ImportDocumentsOperationMetadata(
          od as api.GoogleCloudDialogflowCxV3ImportDocumentsOperationMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ImportDocumentsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ImportDocumentsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ImportDocumentsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ImportDocumentsResponse(
          od as api.GoogleCloudDialogflowCxV3ImportDocumentsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ImportTestCasesMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ImportTestCasesMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ImportTestCasesMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ImportTestCasesMetadata(
          od as api.GoogleCloudDialogflowCxV3ImportTestCasesMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ImportTestCasesRequest',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ImportTestCasesRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ImportTestCasesRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ImportTestCasesRequest(
          od as api.GoogleCloudDialogflowCxV3ImportTestCasesRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ImportTestCasesResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ImportTestCasesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ImportTestCasesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ImportTestCasesResponse(
          od as api.GoogleCloudDialogflowCxV3ImportTestCasesResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3InputAudioConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3InputAudioConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3InputAudioConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3InputAudioConfig(
          od as api.GoogleCloudDialogflowCxV3InputAudioConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3Intent', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3Intent();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3Intent.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3Intent(
          od as api.GoogleCloudDialogflowCxV3Intent);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3IntentCoverage', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3IntentCoverage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3IntentCoverage.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3IntentCoverage(
          od as api.GoogleCloudDialogflowCxV3IntentCoverage);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3IntentCoverageIntent',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3IntentCoverageIntent();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3IntentCoverageIntent.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3IntentCoverageIntent(
          od as api.GoogleCloudDialogflowCxV3IntentCoverageIntent);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3IntentInput', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3IntentInput();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3IntentInput.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3IntentInput(
          od as api.GoogleCloudDialogflowCxV3IntentInput);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3IntentParameter', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3IntentParameter();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3IntentParameter.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3IntentParameter(
          od as api.GoogleCloudDialogflowCxV3IntentParameter);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3IntentTrainingPhrase',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3IntentTrainingPhrase();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3IntentTrainingPhrase.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3IntentTrainingPhrase(
          od as api.GoogleCloudDialogflowCxV3IntentTrainingPhrase);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3IntentTrainingPhrasePart',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3IntentTrainingPhrasePart();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3IntentTrainingPhrasePart.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3IntentTrainingPhrasePart(
          od as api.GoogleCloudDialogflowCxV3IntentTrainingPhrasePart);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ListAgentsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ListAgentsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ListAgentsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ListAgentsResponse(
          od as api.GoogleCloudDialogflowCxV3ListAgentsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ListEntityTypesResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ListEntityTypesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ListEntityTypesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ListEntityTypesResponse(
          od as api.GoogleCloudDialogflowCxV3ListEntityTypesResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ListEnvironmentsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ListEnvironmentsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ListEnvironmentsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ListEnvironmentsResponse(
          od as api.GoogleCloudDialogflowCxV3ListEnvironmentsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ListExperimentsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ListExperimentsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ListExperimentsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ListExperimentsResponse(
          od as api.GoogleCloudDialogflowCxV3ListExperimentsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ListFlowsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ListFlowsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ListFlowsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ListFlowsResponse(
          od as api.GoogleCloudDialogflowCxV3ListFlowsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ListIntentsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ListIntentsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ListIntentsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ListIntentsResponse(
          od as api.GoogleCloudDialogflowCxV3ListIntentsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ListPagesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ListPagesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ListPagesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ListPagesResponse(
          od as api.GoogleCloudDialogflowCxV3ListPagesResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3ListSecuritySettingsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ListSecuritySettingsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3ListSecuritySettingsResponse.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ListSecuritySettingsResponse(
          od as api.GoogleCloudDialogflowCxV3ListSecuritySettingsResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3ListSessionEntityTypesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ListSessionEntityTypesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3ListSessionEntityTypesResponse.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ListSessionEntityTypesResponse(
          od as api.GoogleCloudDialogflowCxV3ListSessionEntityTypesResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3ListTestCaseResultsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ListTestCaseResultsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3ListTestCaseResultsResponse.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ListTestCaseResultsResponse(
          od as api.GoogleCloudDialogflowCxV3ListTestCaseResultsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ListTestCasesResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ListTestCasesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ListTestCasesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ListTestCasesResponse(
          od as api.GoogleCloudDialogflowCxV3ListTestCasesResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3ListTransitionRouteGroupsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ListTransitionRouteGroupsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ListTransitionRouteGroupsResponse
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ListTransitionRouteGroupsResponse(
          od as api.GoogleCloudDialogflowCxV3ListTransitionRouteGroupsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ListVersionsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ListVersionsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ListVersionsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ListVersionsResponse(
          od as api.GoogleCloudDialogflowCxV3ListVersionsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ListWebhooksResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ListWebhooksResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ListWebhooksResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ListWebhooksResponse(
          od as api.GoogleCloudDialogflowCxV3ListWebhooksResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3LoadVersionRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3LoadVersionRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3LoadVersionRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3LoadVersionRequest(
          od as api.GoogleCloudDialogflowCxV3LoadVersionRequest);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3LookupEnvironmentHistoryResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3LookupEnvironmentHistoryResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3LookupEnvironmentHistoryResponse
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3LookupEnvironmentHistoryResponse(
          od as api.GoogleCloudDialogflowCxV3LookupEnvironmentHistoryResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3Match', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3Match();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3Match.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3Match(
          od as api.GoogleCloudDialogflowCxV3Match);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3MatchIntentRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3MatchIntentRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3MatchIntentRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3MatchIntentRequest(
          od as api.GoogleCloudDialogflowCxV3MatchIntentRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3MatchIntentResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3MatchIntentResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3MatchIntentResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3MatchIntentResponse(
          od as api.GoogleCloudDialogflowCxV3MatchIntentResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3NluSettings', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3NluSettings();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3NluSettings.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3NluSettings(
          od as api.GoogleCloudDialogflowCxV3NluSettings);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3OutputAudioConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3OutputAudioConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3OutputAudioConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3OutputAudioConfig(
          od as api.GoogleCloudDialogflowCxV3OutputAudioConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3Page', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3Page();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3Page.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3Page(
          od as api.GoogleCloudDialogflowCxV3Page);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3PageInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3PageInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3PageInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3PageInfo(
          od as api.GoogleCloudDialogflowCxV3PageInfo);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3PageInfoFormInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3PageInfoFormInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3PageInfoFormInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3PageInfoFormInfo(
          od as api.GoogleCloudDialogflowCxV3PageInfoFormInfo);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo(
          od as api.GoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3QueryInput', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3QueryInput();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3QueryInput.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3QueryInput(
          od as api.GoogleCloudDialogflowCxV3QueryInput);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3QueryParameters', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3QueryParameters();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3QueryParameters.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3QueryParameters(
          od as api.GoogleCloudDialogflowCxV3QueryParameters);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3QueryResult', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3QueryResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3QueryResult.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3QueryResult(
          od as api.GoogleCloudDialogflowCxV3QueryResult);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3ReloadDocumentOperationMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ReloadDocumentOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3ReloadDocumentOperationMetadata.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ReloadDocumentOperationMetadata(
          od as api.GoogleCloudDialogflowCxV3ReloadDocumentOperationMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ResourceName', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ResourceName();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ResourceName.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ResourceName(
          od as api.GoogleCloudDialogflowCxV3ResourceName);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ResponseMessage', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ResponseMessage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ResponseMessage.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ResponseMessage(
          od as api.GoogleCloudDialogflowCxV3ResponseMessage);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3ResponseMessageConversationSuccess',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3ResponseMessageConversationSuccess();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ResponseMessageConversationSuccess
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ResponseMessageConversationSuccess(od
          as api.GoogleCloudDialogflowCxV3ResponseMessageConversationSuccess);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3ResponseMessageEndInteraction', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ResponseMessageEndInteraction();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3ResponseMessageEndInteraction.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ResponseMessageEndInteraction(
          od as api.GoogleCloudDialogflowCxV3ResponseMessageEndInteraction);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff(
          od as api.GoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3ResponseMessageMixedAudio', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ResponseMessageMixedAudio();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ResponseMessageMixedAudio.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ResponseMessageMixedAudio(
          od as api.GoogleCloudDialogflowCxV3ResponseMessageMixedAudio);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment(
          od as api.GoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3ResponseMessageOutputAudioText', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ResponseMessageOutputAudioText();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3ResponseMessageOutputAudioText.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ResponseMessageOutputAudioText(
          od as api.GoogleCloudDialogflowCxV3ResponseMessageOutputAudioText);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ResponseMessagePlayAudio',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ResponseMessagePlayAudio();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ResponseMessagePlayAudio.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ResponseMessagePlayAudio(
          od as api.GoogleCloudDialogflowCxV3ResponseMessagePlayAudio);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ResponseMessageText', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ResponseMessageText();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ResponseMessageText.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ResponseMessageText(
          od as api.GoogleCloudDialogflowCxV3ResponseMessageText);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3RestoreAgentRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3RestoreAgentRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3RestoreAgentRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3RestoreAgentRequest(
          od as api.GoogleCloudDialogflowCxV3RestoreAgentRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3RunTestCaseMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3RunTestCaseMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3RunTestCaseMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3RunTestCaseMetadata(
          od as api.GoogleCloudDialogflowCxV3RunTestCaseMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3RunTestCaseRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3RunTestCaseRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3RunTestCaseRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3RunTestCaseRequest(
          od as api.GoogleCloudDialogflowCxV3RunTestCaseRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3RunTestCaseResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3RunTestCaseResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3RunTestCaseResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3RunTestCaseResponse(
          od as api.GoogleCloudDialogflowCxV3RunTestCaseResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3SecuritySettings', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3SecuritySettings();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3SecuritySettings.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3SecuritySettings(
          od as api.GoogleCloudDialogflowCxV3SecuritySettings);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3SentimentAnalysisResult',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3SentimentAnalysisResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3SentimentAnalysisResult.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3SentimentAnalysisResult(
          od as api.GoogleCloudDialogflowCxV3SentimentAnalysisResult);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3SessionEntityType', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3SessionEntityType();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3SessionEntityType.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3SessionEntityType(
          od as api.GoogleCloudDialogflowCxV3SessionEntityType);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3SessionInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3SessionInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3SessionInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3SessionInfo(
          od as api.GoogleCloudDialogflowCxV3SessionInfo);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3SpeechToTextSettings',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3SpeechToTextSettings();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3SpeechToTextSettings.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3SpeechToTextSettings(
          od as api.GoogleCloudDialogflowCxV3SpeechToTextSettings);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3StartExperimentRequest',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3StartExperimentRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3StartExperimentRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3StartExperimentRequest(
          od as api.GoogleCloudDialogflowCxV3StartExperimentRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3StopExperimentRequest',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3StopExperimentRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3StopExperimentRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3StopExperimentRequest(
          od as api.GoogleCloudDialogflowCxV3StopExperimentRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3SynthesizeSpeechConfig',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3SynthesizeSpeechConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3SynthesizeSpeechConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3SynthesizeSpeechConfig(
          od as api.GoogleCloudDialogflowCxV3SynthesizeSpeechConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3TestCase', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3TestCase();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3TestCase.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3TestCase(
          od as api.GoogleCloudDialogflowCxV3TestCase);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3TestCaseError', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3TestCaseError();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3TestCaseError.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3TestCaseError(
          od as api.GoogleCloudDialogflowCxV3TestCaseError);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3TestCaseResult', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3TestCaseResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3TestCaseResult.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3TestCaseResult(
          od as api.GoogleCloudDialogflowCxV3TestCaseResult);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3TestConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3TestConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3TestConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3TestConfig(
          od as api.GoogleCloudDialogflowCxV3TestConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3TestError', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3TestError();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3TestError.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3TestError(
          od as api.GoogleCloudDialogflowCxV3TestError);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3TestRunDifference', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3TestRunDifference();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3TestRunDifference.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3TestRunDifference(
          od as api.GoogleCloudDialogflowCxV3TestRunDifference);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3TextInput', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3TextInput();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3TextInput.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3TextInput(
          od as api.GoogleCloudDialogflowCxV3TextInput);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3TrainFlowRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3TrainFlowRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3TrainFlowRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3TrainFlowRequest(
          od as api.GoogleCloudDialogflowCxV3TrainFlowRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3TransitionCoverage', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3TransitionCoverage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3TransitionCoverage.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3TransitionCoverage(
          od as api.GoogleCloudDialogflowCxV3TransitionCoverage);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3TransitionCoverageTransition', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3TransitionCoverageTransition();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3TransitionCoverageTransition.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3TransitionCoverageTransition(
          od as api.GoogleCloudDialogflowCxV3TransitionCoverageTransition);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3TransitionCoverageTransitionNode',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3TransitionCoverageTransitionNode();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3TransitionCoverageTransitionNode
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3TransitionCoverageTransitionNode(
          od as api.GoogleCloudDialogflowCxV3TransitionCoverageTransitionNode);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3TransitionRoute', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3TransitionRoute();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3TransitionRoute.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3TransitionRoute(
          od as api.GoogleCloudDialogflowCxV3TransitionRoute);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3TransitionRouteGroup',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3TransitionRouteGroup();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3TransitionRouteGroup.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3TransitionRouteGroup(
          od as api.GoogleCloudDialogflowCxV3TransitionRouteGroup);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3TransitionRouteGroupCoverage', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3TransitionRouteGroupCoverage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3TransitionRouteGroupCoverage.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3TransitionRouteGroupCoverage(
          od as api.GoogleCloudDialogflowCxV3TransitionRouteGroupCoverage);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage(od
          as api.GoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverage);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition(
          od as api
              .GoogleCloudDialogflowCxV3TransitionRouteGroupCoverageCoverageTransition);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3UpdateDocumentOperationMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3UpdateDocumentOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3UpdateDocumentOperationMetadata.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3UpdateDocumentOperationMetadata(
          od as api.GoogleCloudDialogflowCxV3UpdateDocumentOperationMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ValidateAgentRequest',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ValidateAgentRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ValidateAgentRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ValidateAgentRequest(
          od as api.GoogleCloudDialogflowCxV3ValidateAgentRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ValidateFlowRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ValidateFlowRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ValidateFlowRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ValidateFlowRequest(
          od as api.GoogleCloudDialogflowCxV3ValidateFlowRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3ValidationMessage', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3ValidationMessage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3ValidationMessage.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3ValidationMessage(
          od as api.GoogleCloudDialogflowCxV3ValidationMessage);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3VariantsHistory', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3VariantsHistory();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3VariantsHistory.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3VariantsHistory(
          od as api.GoogleCloudDialogflowCxV3VariantsHistory);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3Version', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3Version();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3Version.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3Version(
          od as api.GoogleCloudDialogflowCxV3Version);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3VersionVariants', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3VersionVariants();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3VersionVariants.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3VersionVariants(
          od as api.GoogleCloudDialogflowCxV3VersionVariants);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3VersionVariantsVariant',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3VersionVariantsVariant();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3VersionVariantsVariant.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3VersionVariantsVariant(
          od as api.GoogleCloudDialogflowCxV3VersionVariantsVariant);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3VoiceSelectionParams',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3VoiceSelectionParams();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3VoiceSelectionParams.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3VoiceSelectionParams(
          od as api.GoogleCloudDialogflowCxV3VoiceSelectionParams);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3Webhook', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3Webhook();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3Webhook.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3Webhook(
          od as api.GoogleCloudDialogflowCxV3Webhook);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3WebhookGenericWebService',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3WebhookGenericWebService();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3WebhookGenericWebService.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3WebhookGenericWebService(
          od as api.GoogleCloudDialogflowCxV3WebhookGenericWebService);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3WebhookRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3WebhookRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3WebhookRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3WebhookRequest(
          od as api.GoogleCloudDialogflowCxV3WebhookRequest);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3WebhookRequestFulfillmentInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3WebhookRequestFulfillmentInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3WebhookRequestFulfillmentInfo.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3WebhookRequestFulfillmentInfo(
          od as api.GoogleCloudDialogflowCxV3WebhookRequestFulfillmentInfo);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3WebhookRequestIntentInfo',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3WebhookRequestIntentInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3WebhookRequestIntentInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3WebhookRequestIntentInfo(
          od as api.GoogleCloudDialogflowCxV3WebhookRequestIntentInfo);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue(
          od as api
              .GoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3WebhookRequestSentimentAnalysisResult',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3WebhookRequestSentimentAnalysisResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3WebhookRequestSentimentAnalysisResult
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3WebhookRequestSentimentAnalysisResult(od
          as api
              .GoogleCloudDialogflowCxV3WebhookRequestSentimentAnalysisResult);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3WebhookResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3WebhookResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3WebhookResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3WebhookResponse(
          od as api.GoogleCloudDialogflowCxV3WebhookResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3WebhookResponseFulfillmentResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3WebhookResponseFulfillmentResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3WebhookResponseFulfillmentResponse
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3WebhookResponseFulfillmentResponse(od
          as api.GoogleCloudDialogflowCxV3WebhookResponseFulfillmentResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1AudioInput', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1AudioInput();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1AudioInput.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1AudioInput(
          od as api.GoogleCloudDialogflowCxV3beta1AudioInput);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1BatchRunTestCasesMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1BatchRunTestCasesMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3beta1BatchRunTestCasesMetadata.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1BatchRunTestCasesMetadata(
          od as api.GoogleCloudDialogflowCxV3beta1BatchRunTestCasesMetadata);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1BatchRunTestCasesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1BatchRunTestCasesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3beta1BatchRunTestCasesResponse.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1BatchRunTestCasesResponse(
          od as api.GoogleCloudDialogflowCxV3beta1BatchRunTestCasesResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1ConversationTurn',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1ConversationTurn();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1ConversationTurn.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1ConversationTurn(
          od as api.GoogleCloudDialogflowCxV3beta1ConversationTurn);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1ConversationTurnUserInput', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1ConversationTurnUserInput();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3beta1ConversationTurnUserInput.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1ConversationTurnUserInput(
          od as api.GoogleCloudDialogflowCxV3beta1ConversationTurnUserInput);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1ConversationTurnVirtualAgentOutput',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3beta1ConversationTurnVirtualAgentOutput();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3beta1ConversationTurnVirtualAgentOutput
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1ConversationTurnVirtualAgentOutput(od
          as api
              .GoogleCloudDialogflowCxV3beta1ConversationTurnVirtualAgentOutput);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1CreateDocumentOperationMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3beta1CreateDocumentOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1CreateDocumentOperationMetadata
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1CreateDocumentOperationMetadata(od
          as api.GoogleCloudDialogflowCxV3beta1CreateDocumentOperationMetadata);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1CreateVersionOperationMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3beta1CreateVersionOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1CreateVersionOperationMetadata
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1CreateVersionOperationMetadata(od
          as api.GoogleCloudDialogflowCxV3beta1CreateVersionOperationMetadata);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1DeleteDocumentOperationMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3beta1DeleteDocumentOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1DeleteDocumentOperationMetadata
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1DeleteDocumentOperationMetadata(od
          as api.GoogleCloudDialogflowCxV3beta1DeleteDocumentOperationMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1DtmfInput', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1DtmfInput();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1DtmfInput.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1DtmfInput(
          od as api.GoogleCloudDialogflowCxV3beta1DtmfInput);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1EventHandler', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1EventHandler();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1EventHandler.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1EventHandler(
          od as api.GoogleCloudDialogflowCxV3beta1EventHandler);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1EventInput', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1EventInput();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1EventInput.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1EventInput(
          od as api.GoogleCloudDialogflowCxV3beta1EventInput);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1ExportAgentResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1ExportAgentResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1ExportAgentResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1ExportAgentResponse(
          od as api.GoogleCloudDialogflowCxV3beta1ExportAgentResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1ExportTestCasesMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1ExportTestCasesMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3beta1ExportTestCasesMetadata.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1ExportTestCasesMetadata(
          od as api.GoogleCloudDialogflowCxV3beta1ExportTestCasesMetadata);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1ExportTestCasesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1ExportTestCasesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3beta1ExportTestCasesResponse.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1ExportTestCasesResponse(
          od as api.GoogleCloudDialogflowCxV3beta1ExportTestCasesResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1Form', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1Form();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1Form.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1Form(
          od as api.GoogleCloudDialogflowCxV3beta1Form);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1FormParameter', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1FormParameter();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1FormParameter.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1FormParameter(
          od as api.GoogleCloudDialogflowCxV3beta1FormParameter);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1FormParameterFillBehavior', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1FormParameterFillBehavior();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3beta1FormParameterFillBehavior.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1FormParameterFillBehavior(
          od as api.GoogleCloudDialogflowCxV3beta1FormParameterFillBehavior);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1Fulfillment', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1Fulfillment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1Fulfillment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1Fulfillment(
          od as api.GoogleCloudDialogflowCxV3beta1Fulfillment);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases(
          od as api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase(od
          as api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent(
          od as api
              .GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction(od
          as api.GoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata(od
          as api
              .GoogleCloudDialogflowCxV3beta1GenericKnowledgeOperationMetadata);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1ImportDocumentsOperationMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3beta1ImportDocumentsOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3beta1ImportDocumentsOperationMetadata
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1ImportDocumentsOperationMetadata(od
          as api
              .GoogleCloudDialogflowCxV3beta1ImportDocumentsOperationMetadata);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1ImportDocumentsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1ImportDocumentsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3beta1ImportDocumentsResponse.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1ImportDocumentsResponse(
          od as api.GoogleCloudDialogflowCxV3beta1ImportDocumentsResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1ImportTestCasesMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1ImportTestCasesMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3beta1ImportTestCasesMetadata.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1ImportTestCasesMetadata(
          od as api.GoogleCloudDialogflowCxV3beta1ImportTestCasesMetadata);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1ImportTestCasesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1ImportTestCasesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3beta1ImportTestCasesResponse.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1ImportTestCasesResponse(
          od as api.GoogleCloudDialogflowCxV3beta1ImportTestCasesResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1InputAudioConfig',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1InputAudioConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1InputAudioConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1InputAudioConfig(
          od as api.GoogleCloudDialogflowCxV3beta1InputAudioConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1Intent', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1Intent();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1Intent.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1Intent(
          od as api.GoogleCloudDialogflowCxV3beta1Intent);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1IntentInput', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1IntentInput();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1IntentInput.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1IntentInput(
          od as api.GoogleCloudDialogflowCxV3beta1IntentInput);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1IntentParameter',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1IntentParameter();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1IntentParameter.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1IntentParameter(
          od as api.GoogleCloudDialogflowCxV3beta1IntentParameter);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1IntentTrainingPhrase', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1IntentTrainingPhrase();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1IntentTrainingPhrase.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1IntentTrainingPhrase(
          od as api.GoogleCloudDialogflowCxV3beta1IntentTrainingPhrase);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart(
          od as api.GoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1Page', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1Page();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1Page.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1Page(
          od as api.GoogleCloudDialogflowCxV3beta1Page);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1PageInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1PageInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1PageInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1PageInfo(
          od as api.GoogleCloudDialogflowCxV3beta1PageInfo);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1PageInfoFormInfo',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1PageInfoFormInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1PageInfoFormInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1PageInfoFormInfo(
          od as api.GoogleCloudDialogflowCxV3beta1PageInfoFormInfo);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo(od
          as api.GoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1QueryInput', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1QueryInput();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1QueryInput.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1QueryInput(
          od as api.GoogleCloudDialogflowCxV3beta1QueryInput);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1ReloadDocumentOperationMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3beta1ReloadDocumentOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1ReloadDocumentOperationMetadata
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1ReloadDocumentOperationMetadata(od
          as api.GoogleCloudDialogflowCxV3beta1ReloadDocumentOperationMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1ResponseMessage',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1ResponseMessage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1ResponseMessage.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1ResponseMessage(
          od as api.GoogleCloudDialogflowCxV3beta1ResponseMessage);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1ResponseMessageConversationSuccess',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3beta1ResponseMessageConversationSuccess();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3beta1ResponseMessageConversationSuccess
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1ResponseMessageConversationSuccess(od
          as api
              .GoogleCloudDialogflowCxV3beta1ResponseMessageConversationSuccess);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1ResponseMessageEndInteraction',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3beta1ResponseMessageEndInteraction();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1ResponseMessageEndInteraction
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1ResponseMessageEndInteraction(od
          as api.GoogleCloudDialogflowCxV3beta1ResponseMessageEndInteraction);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff(od
          as api.GoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudio', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudio();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudio.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudio(
          od as api.GoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudio);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment(od
          as api
              .GoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1ResponseMessageOutputAudioText',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3beta1ResponseMessageOutputAudioText();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1ResponseMessageOutputAudioText
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1ResponseMessageOutputAudioText(od
          as api.GoogleCloudDialogflowCxV3beta1ResponseMessageOutputAudioText);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1ResponseMessagePlayAudio', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1ResponseMessagePlayAudio();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3beta1ResponseMessagePlayAudio.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1ResponseMessagePlayAudio(
          od as api.GoogleCloudDialogflowCxV3beta1ResponseMessagePlayAudio);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1ResponseMessageText',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1ResponseMessageText();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1ResponseMessageText.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1ResponseMessageText(
          od as api.GoogleCloudDialogflowCxV3beta1ResponseMessageText);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1RunTestCaseMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1RunTestCaseMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1RunTestCaseMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1RunTestCaseMetadata(
          od as api.GoogleCloudDialogflowCxV3beta1RunTestCaseMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1RunTestCaseResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1RunTestCaseResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1RunTestCaseResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1RunTestCaseResponse(
          od as api.GoogleCloudDialogflowCxV3beta1RunTestCaseResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1SessionInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1SessionInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1SessionInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1SessionInfo(
          od as api.GoogleCloudDialogflowCxV3beta1SessionInfo);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1TestCase', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1TestCase();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1TestCase.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1TestCase(
          od as api.GoogleCloudDialogflowCxV3beta1TestCase);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1TestCaseError', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1TestCaseError();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1TestCaseError.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1TestCaseError(
          od as api.GoogleCloudDialogflowCxV3beta1TestCaseError);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1TestCaseResult', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1TestCaseResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1TestCaseResult.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1TestCaseResult(
          od as api.GoogleCloudDialogflowCxV3beta1TestCaseResult);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1TestConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1TestConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1TestConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1TestConfig(
          od as api.GoogleCloudDialogflowCxV3beta1TestConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1TestError', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1TestError();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1TestError.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1TestError(
          od as api.GoogleCloudDialogflowCxV3beta1TestError);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1TestRunDifference',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1TestRunDifference();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1TestRunDifference.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1TestRunDifference(
          od as api.GoogleCloudDialogflowCxV3beta1TestRunDifference);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1TextInput', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1TextInput();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1TextInput.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1TextInput(
          od as api.GoogleCloudDialogflowCxV3beta1TextInput);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1TransitionRoute',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1TransitionRoute();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1TransitionRoute.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1TransitionRoute(
          od as api.GoogleCloudDialogflowCxV3beta1TransitionRoute);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1UpdateDocumentOperationMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3beta1UpdateDocumentOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1UpdateDocumentOperationMetadata
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1UpdateDocumentOperationMetadata(od
          as api.GoogleCloudDialogflowCxV3beta1UpdateDocumentOperationMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1WebhookRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1WebhookRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1WebhookRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1WebhookRequest(
          od as api.GoogleCloudDialogflowCxV3beta1WebhookRequest);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1WebhookRequestFulfillmentInfo',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3beta1WebhookRequestFulfillmentInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1WebhookRequestFulfillmentInfo
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1WebhookRequestFulfillmentInfo(od
          as api.GoogleCloudDialogflowCxV3beta1WebhookRequestFulfillmentInfo);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfo.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfo(
          od as api.GoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfo);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue(
          od as api
              .GoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1WebhookRequestSentimentAnalysisResult',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3beta1WebhookRequestSentimentAnalysisResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3beta1WebhookRequestSentimentAnalysisResult
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1WebhookRequestSentimentAnalysisResult(
          od as api
              .GoogleCloudDialogflowCxV3beta1WebhookRequestSentimentAnalysisResult);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowCxV3beta1WebhookResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowCxV3beta1WebhookResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowCxV3beta1WebhookResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1WebhookResponse(
          od as api.GoogleCloudDialogflowCxV3beta1WebhookResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowCxV3beta1WebhookResponseFulfillmentResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowCxV3beta1WebhookResponseFulfillmentResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowCxV3beta1WebhookResponseFulfillmentResponse
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowCxV3beta1WebhookResponseFulfillmentResponse(od
          as api
              .GoogleCloudDialogflowCxV3beta1WebhookResponseFulfillmentResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2AnnotatedMessagePart', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2AnnotatedMessagePart();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2AnnotatedMessagePart.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2AnnotatedMessagePart(
          od as api.GoogleCloudDialogflowV2AnnotatedMessagePart);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2BatchUpdateEntityTypesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2BatchUpdateEntityTypesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2BatchUpdateEntityTypesResponse.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2BatchUpdateEntityTypesResponse(
          od as api.GoogleCloudDialogflowV2BatchUpdateEntityTypesResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2BatchUpdateIntentsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2BatchUpdateIntentsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2BatchUpdateIntentsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2BatchUpdateIntentsResponse(
          od as api.GoogleCloudDialogflowV2BatchUpdateIntentsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2Context', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2Context();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2Context.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2Context(
          od as api.GoogleCloudDialogflowV2Context);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2ConversationEvent', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2ConversationEvent();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2ConversationEvent.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2ConversationEvent(
          od as api.GoogleCloudDialogflowV2ConversationEvent);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2EntityType', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2EntityType();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2EntityType.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2EntityType(
          od as api.GoogleCloudDialogflowV2EntityType);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2EntityTypeEntity', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2EntityTypeEntity();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2EntityTypeEntity.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2EntityTypeEntity(
          od as api.GoogleCloudDialogflowV2EntityTypeEntity);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2EventInput', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2EventInput();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2EventInput.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2EventInput(
          od as api.GoogleCloudDialogflowV2EventInput);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2ExportAgentResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2ExportAgentResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2ExportAgentResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2ExportAgentResponse(
          od as api.GoogleCloudDialogflowV2ExportAgentResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2Intent', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2Intent();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2Intent.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2Intent(
          od as api.GoogleCloudDialogflowV2Intent);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2IntentFollowupIntentInfo',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentFollowupIntentInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2IntentFollowupIntentInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentFollowupIntentInfo(
          od as api.GoogleCloudDialogflowV2IntentFollowupIntentInfo);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2IntentMessage', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentMessage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2IntentMessage.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessage(
          od as api.GoogleCloudDialogflowV2IntentMessage);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2IntentMessageBasicCard',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentMessageBasicCard();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2IntentMessageBasicCard.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageBasicCard(
          od as api.GoogleCloudDialogflowV2IntentMessageBasicCard);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2IntentMessageBasicCardButton', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentMessageBasicCardButton();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2IntentMessageBasicCardButton.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageBasicCardButton(
          od as api.GoogleCloudDialogflowV2IntentMessageBasicCardButton);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2IntentMessageBasicCardButtonOpenUriAction',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowV2IntentMessageBasicCardButtonOpenUriAction();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2IntentMessageBasicCardButtonOpenUriAction
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageBasicCardButtonOpenUriAction(od
          as api
              .GoogleCloudDialogflowV2IntentMessageBasicCardButtonOpenUriAction);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2IntentMessageBrowseCarouselCard', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentMessageBrowseCarouselCard();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2IntentMessageBrowseCarouselCard.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageBrowseCarouselCard(
          od as api.GoogleCloudDialogflowV2IntentMessageBrowseCarouselCard);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem(
          od as api
              .GoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction(
          od as api
              .GoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2IntentMessageCard', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentMessageCard();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2IntentMessageCard.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageCard(
          od as api.GoogleCloudDialogflowV2IntentMessageCard);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2IntentMessageCardButton',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentMessageCardButton();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2IntentMessageCardButton.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageCardButton(
          od as api.GoogleCloudDialogflowV2IntentMessageCardButton);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2IntentMessageCarouselSelect', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentMessageCarouselSelect();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2IntentMessageCarouselSelect.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageCarouselSelect(
          od as api.GoogleCloudDialogflowV2IntentMessageCarouselSelect);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2IntentMessageCarouselSelectItem', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentMessageCarouselSelectItem();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2IntentMessageCarouselSelectItem.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageCarouselSelectItem(
          od as api.GoogleCloudDialogflowV2IntentMessageCarouselSelectItem);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2IntentMessageColumnProperties', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentMessageColumnProperties();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2IntentMessageColumnProperties.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageColumnProperties(
          od as api.GoogleCloudDialogflowV2IntentMessageColumnProperties);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2IntentMessageImage', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentMessageImage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2IntentMessageImage.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageImage(
          od as api.GoogleCloudDialogflowV2IntentMessageImage);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2IntentMessageLinkOutSuggestion', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentMessageLinkOutSuggestion();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2IntentMessageLinkOutSuggestion.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageLinkOutSuggestion(
          od as api.GoogleCloudDialogflowV2IntentMessageLinkOutSuggestion);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2IntentMessageListSelect',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentMessageListSelect();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2IntentMessageListSelect.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageListSelect(
          od as api.GoogleCloudDialogflowV2IntentMessageListSelect);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2IntentMessageListSelectItem', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentMessageListSelectItem();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2IntentMessageListSelectItem.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageListSelectItem(
          od as api.GoogleCloudDialogflowV2IntentMessageListSelectItem);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2IntentMessageMediaContent',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentMessageMediaContent();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2IntentMessageMediaContent.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageMediaContent(
          od as api.GoogleCloudDialogflowV2IntentMessageMediaContent);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject(
          od as api
              .GoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2IntentMessageQuickReplies',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentMessageQuickReplies();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2IntentMessageQuickReplies.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageQuickReplies(
          od as api.GoogleCloudDialogflowV2IntentMessageQuickReplies);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2IntentMessageSelectItemInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentMessageSelectItemInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2IntentMessageSelectItemInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageSelectItemInfo(
          od as api.GoogleCloudDialogflowV2IntentMessageSelectItemInfo);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2IntentMessageSimpleResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentMessageSimpleResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2IntentMessageSimpleResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageSimpleResponse(
          od as api.GoogleCloudDialogflowV2IntentMessageSimpleResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2IntentMessageSimpleResponses', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentMessageSimpleResponses();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2IntentMessageSimpleResponses.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageSimpleResponses(
          od as api.GoogleCloudDialogflowV2IntentMessageSimpleResponses);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2IntentMessageSuggestion',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentMessageSuggestion();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2IntentMessageSuggestion.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageSuggestion(
          od as api.GoogleCloudDialogflowV2IntentMessageSuggestion);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2IntentMessageSuggestions',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentMessageSuggestions();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2IntentMessageSuggestions.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageSuggestions(
          od as api.GoogleCloudDialogflowV2IntentMessageSuggestions);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2IntentMessageTableCard',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentMessageTableCard();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2IntentMessageTableCard.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageTableCard(
          od as api.GoogleCloudDialogflowV2IntentMessageTableCard);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2IntentMessageTableCardCell',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentMessageTableCardCell();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2IntentMessageTableCardCell.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageTableCardCell(
          od as api.GoogleCloudDialogflowV2IntentMessageTableCardCell);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2IntentMessageTableCardRow',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentMessageTableCardRow();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2IntentMessageTableCardRow.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageTableCardRow(
          od as api.GoogleCloudDialogflowV2IntentMessageTableCardRow);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2IntentMessageText', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentMessageText();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2IntentMessageText.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentMessageText(
          od as api.GoogleCloudDialogflowV2IntentMessageText);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2IntentParameter', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentParameter();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2IntentParameter.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentParameter(
          od as api.GoogleCloudDialogflowV2IntentParameter);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2IntentTrainingPhrase', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentTrainingPhrase();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2IntentTrainingPhrase.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentTrainingPhrase(
          od as api.GoogleCloudDialogflowV2IntentTrainingPhrase);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2IntentTrainingPhrasePart',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentTrainingPhrasePart();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2IntentTrainingPhrasePart.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentTrainingPhrasePart(
          od as api.GoogleCloudDialogflowV2IntentTrainingPhrasePart);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2Message', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2Message();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2Message.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2Message(
          od as api.GoogleCloudDialogflowV2Message);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2MessageAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2MessageAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2MessageAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2MessageAnnotation(
          od as api.GoogleCloudDialogflowV2MessageAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2OriginalDetectIntentRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2OriginalDetectIntentRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2OriginalDetectIntentRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2OriginalDetectIntentRequest(
          od as api.GoogleCloudDialogflowV2OriginalDetectIntentRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2QueryResult', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2QueryResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2QueryResult.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2QueryResult(
          od as api.GoogleCloudDialogflowV2QueryResult);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2Sentiment', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2Sentiment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2Sentiment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2Sentiment(
          od as api.GoogleCloudDialogflowV2Sentiment);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2SentimentAnalysisResult',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2SentimentAnalysisResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2SentimentAnalysisResult.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2SentimentAnalysisResult(
          od as api.GoogleCloudDialogflowV2SentimentAnalysisResult);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2SessionEntityType', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2SessionEntityType();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2SessionEntityType.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2SessionEntityType(
          od as api.GoogleCloudDialogflowV2SessionEntityType);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2WebhookRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2WebhookRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2WebhookRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2WebhookRequest(
          od as api.GoogleCloudDialogflowV2WebhookRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2WebhookResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2WebhookResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2WebhookResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2WebhookResponse(
          od as api.GoogleCloudDialogflowV2WebhookResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1BatchUpdateEntityTypesResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1BatchUpdateEntityTypesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1BatchUpdateEntityTypesResponse
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1BatchUpdateEntityTypesResponse(
          od as api.GoogleCloudDialogflowV2beta1BatchUpdateEntityTypesResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1BatchUpdateIntentsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1BatchUpdateIntentsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1BatchUpdateIntentsResponse.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1BatchUpdateIntentsResponse(
          od as api.GoogleCloudDialogflowV2beta1BatchUpdateIntentsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2beta1Context', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1Context();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1Context.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1Context(
          od as api.GoogleCloudDialogflowV2beta1Context);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2beta1EntityType', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1EntityType();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1EntityType.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1EntityType(
          od as api.GoogleCloudDialogflowV2beta1EntityType);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2beta1EntityTypeEntity', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1EntityTypeEntity();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1EntityTypeEntity.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1EntityTypeEntity(
          od as api.GoogleCloudDialogflowV2beta1EntityTypeEntity);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2beta1EventInput', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1EventInput();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1EventInput.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1EventInput(
          od as api.GoogleCloudDialogflowV2beta1EventInput);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2beta1ExportAgentResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1ExportAgentResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1ExportAgentResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1ExportAgentResponse(
          od as api.GoogleCloudDialogflowV2beta1ExportAgentResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2beta1Intent', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1Intent();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1Intent.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1Intent(
          od as api.GoogleCloudDialogflowV2beta1Intent);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentFollowupIntentInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentFollowupIntentInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentFollowupIntentInfo.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentFollowupIntentInfo(
          od as api.GoogleCloudDialogflowV2beta1IntentFollowupIntentInfo);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2beta1IntentMessage', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1IntentMessage.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessage(
          od as api.GoogleCloudDialogflowV2beta1IntentMessage);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageBasicCard', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageBasicCard();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1IntentMessageBasicCard.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageBasicCard(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageBasicCard);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageBasicCardButton',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageBasicCardButton();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentMessageBasicCardButton.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageBasicCardButton(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageBasicCardButton);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageBasicCardButtonOpenUriAction',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowV2beta1IntentMessageBasicCardButtonOpenUriAction();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentMessageBasicCardButtonOpenUriAction
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageBasicCardButtonOpenUriAction(
          od as api
              .GoogleCloudDialogflowV2beta1IntentMessageBasicCardButtonOpenUriAction);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCard',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCard();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCard
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCard(od
          as api.GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCard);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem(
          od as api
              .GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction(
          od as api
              .GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItemOpenUrlAction);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2beta1IntentMessageCard',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageCard();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1IntentMessageCard.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageCard(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageCard);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageCardButton', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageCardButton();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1IntentMessageCardButton.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageCardButton(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageCardButton);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageCarouselSelect', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageCarouselSelect();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentMessageCarouselSelect.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageCarouselSelect(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageCarouselSelect);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem(od
          as api.GoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageColumnProperties',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageColumnProperties();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1IntentMessageColumnProperties
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageColumnProperties(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageColumnProperties);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2beta1IntentMessageImage',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageImage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1IntentMessageImage.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageImage(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageImage);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageLinkOutSuggestion',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageLinkOutSuggestion();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1IntentMessageLinkOutSuggestion
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageLinkOutSuggestion(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageLinkOutSuggestion);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageListSelect', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageListSelect();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1IntentMessageListSelect.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageListSelect(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageListSelect);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageListSelectItem', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageListSelectItem();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentMessageListSelectItem.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageListSelectItem(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageListSelectItem);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageMediaContent', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageMediaContent();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentMessageMediaContent.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageMediaContent(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageMediaContent);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject(
          od as api
              .GoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageQuickReplies', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageQuickReplies();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentMessageQuickReplies.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageQuickReplies(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageQuickReplies);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageRbmCardContent', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageRbmCardContent();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentMessageRbmCardContent.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageRbmCardContent(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageRbmCardContent);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageRbmCardContentRbmMedia',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowV2beta1IntentMessageRbmCardContentRbmMedia();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentMessageRbmCardContentRbmMedia
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageRbmCardContentRbmMedia(od
          as api
              .GoogleCloudDialogflowV2beta1IntentMessageRbmCardContentRbmMedia);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageRbmCarouselCard',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageRbmCarouselCard();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentMessageRbmCarouselCard.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageRbmCarouselCard(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageRbmCarouselCard);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageRbmStandaloneCard',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageRbmStandaloneCard();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1IntentMessageRbmStandaloneCard
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageRbmStandaloneCard(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageRbmStandaloneCard);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedAction',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedAction();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedAction
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedAction(od
          as api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedAction);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionDial',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionDial();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionDial
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionDial(
          od as api
              .GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionDial);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionOpenUri',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionOpenUri();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionOpenUri
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionOpenUri(
          od as api
              .GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionOpenUri);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionShareLocation',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionShareLocation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionShareLocation
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionShareLocation(
          od as api
              .GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedActionRbmSuggestedActionShareLocation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedReply',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedReply();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedReply
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedReply(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestedReply);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2beta1IntentMessageRbmText',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageRbmText();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1IntentMessageRbmText.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageRbmText(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageRbmText);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageSelectItemInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageSelectItemInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentMessageSelectItemInfo.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageSelectItemInfo(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageSelectItemInfo);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageSimpleResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageSimpleResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentMessageSimpleResponse.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageSimpleResponse(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageSimpleResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageSimpleResponses',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageSimpleResponses();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentMessageSimpleResponses.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageSimpleResponses(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageSimpleResponses);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageSuggestion', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageSuggestion();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1IntentMessageSuggestion.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageSuggestion(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageSuggestion);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageSuggestions', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageSuggestions();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentMessageSuggestions.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageSuggestions(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageSuggestions);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageTableCard', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageTableCard();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1IntentMessageTableCard.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageTableCard(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageTableCard);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageTableCardCell', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageTableCardCell();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentMessageTableCardCell.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageTableCardCell(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageTableCardCell);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageTableCardRow', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageTableCardRow();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentMessageTableCardRow.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageTableCardRow(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageTableCardRow);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageTelephonyPlayAudio',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowV2beta1IntentMessageTelephonyPlayAudio();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1IntentMessageTelephonyPlayAudio
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageTelephonyPlayAudio(od
          as api.GoogleCloudDialogflowV2beta1IntentMessageTelephonyPlayAudio);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageTelephonySynthesizeSpeech',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowV2beta1IntentMessageTelephonySynthesizeSpeech();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentMessageTelephonySynthesizeSpeech
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageTelephonySynthesizeSpeech(od
          as api
              .GoogleCloudDialogflowV2beta1IntentMessageTelephonySynthesizeSpeech);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentMessageTelephonyTransferCall',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowV2beta1IntentMessageTelephonyTransferCall();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentMessageTelephonyTransferCall
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageTelephonyTransferCall(od
          as api
              .GoogleCloudDialogflowV2beta1IntentMessageTelephonyTransferCall);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2beta1IntentMessageText',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentMessageText();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1IntentMessageText.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentMessageText(
          od as api.GoogleCloudDialogflowV2beta1IntentMessageText);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2beta1IntentParameter', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentParameter();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1IntentParameter.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentParameter(
          od as api.GoogleCloudDialogflowV2beta1IntentParameter);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2beta1IntentTrainingPhrase',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentTrainingPhrase();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1IntentTrainingPhrase.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentTrainingPhrase(
          od as api.GoogleCloudDialogflowV2beta1IntentTrainingPhrase);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1IntentTrainingPhrasePart', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1IntentTrainingPhrasePart();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1IntentTrainingPhrasePart.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1IntentTrainingPhrasePart(
          od as api.GoogleCloudDialogflowV2beta1IntentTrainingPhrasePart);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2beta1KnowledgeAnswers', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1KnowledgeAnswers();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1KnowledgeAnswers.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1KnowledgeAnswers(
          od as api.GoogleCloudDialogflowV2beta1KnowledgeAnswers);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer(
          od as api.GoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1KnowledgeOperationMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1KnowledgeOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1KnowledgeOperationMetadata.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1KnowledgeOperationMetadata(
          od as api.GoogleCloudDialogflowV2beta1KnowledgeOperationMetadata);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1OriginalDetectIntentRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1OriginalDetectIntentRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2beta1OriginalDetectIntentRequest.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1OriginalDetectIntentRequest(
          od as api.GoogleCloudDialogflowV2beta1OriginalDetectIntentRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2beta1QueryResult', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1QueryResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1QueryResult.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1QueryResult(
          od as api.GoogleCloudDialogflowV2beta1QueryResult);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2beta1Sentiment', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1Sentiment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1Sentiment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1Sentiment(
          od as api.GoogleCloudDialogflowV2beta1Sentiment);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2beta1SentimentAnalysisResult', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1SentimentAnalysisResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1SentimentAnalysisResult.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1SentimentAnalysisResult(
          od as api.GoogleCloudDialogflowV2beta1SentimentAnalysisResult);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2beta1SessionEntityType',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1SessionEntityType();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1SessionEntityType.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1SessionEntityType(
          od as api.GoogleCloudDialogflowV2beta1SessionEntityType);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2beta1WebhookRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1WebhookRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1WebhookRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1WebhookRequest(
          od as api.GoogleCloudDialogflowV2beta1WebhookRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2beta1WebhookResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2beta1WebhookResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2beta1WebhookResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2beta1WebhookResponse(
          od as api.GoogleCloudDialogflowV2beta1WebhookResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV3alpha1CreateDocumentOperationMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowV3alpha1CreateDocumentOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV3alpha1CreateDocumentOperationMetadata
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV3alpha1CreateDocumentOperationMetadata(od
          as api.GoogleCloudDialogflowV3alpha1CreateDocumentOperationMetadata);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV3alpha1DeleteDocumentOperationMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowV3alpha1DeleteDocumentOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV3alpha1DeleteDocumentOperationMetadata
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV3alpha1DeleteDocumentOperationMetadata(od
          as api.GoogleCloudDialogflowV3alpha1DeleteDocumentOperationMetadata);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata(od
          as api
              .GoogleCloudDialogflowV3alpha1GenericKnowledgeOperationMetadata);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV3alpha1ImportDocumentsOperationMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowV3alpha1ImportDocumentsOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV3alpha1ImportDocumentsOperationMetadata
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV3alpha1ImportDocumentsOperationMetadata(od
          as api.GoogleCloudDialogflowV3alpha1ImportDocumentsOperationMetadata);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV3alpha1ImportDocumentsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV3alpha1ImportDocumentsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV3alpha1ImportDocumentsResponse.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV3alpha1ImportDocumentsResponse(
          od as api.GoogleCloudDialogflowV3alpha1ImportDocumentsResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV3alpha1ReloadDocumentOperationMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowV3alpha1ReloadDocumentOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV3alpha1ReloadDocumentOperationMetadata
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV3alpha1ReloadDocumentOperationMetadata(od
          as api.GoogleCloudDialogflowV3alpha1ReloadDocumentOperationMetadata);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV3alpha1UpdateDocumentOperationMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudDialogflowV3alpha1UpdateDocumentOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV3alpha1UpdateDocumentOperationMetadata
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV3alpha1UpdateDocumentOperationMetadata(od
          as api.GoogleCloudDialogflowV3alpha1UpdateDocumentOperationMetadata);
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

  unittest.group('obj-schema-GoogleTypeLatLng', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleTypeLatLng();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleTypeLatLng.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleTypeLatLng(od as api.GoogleTypeLatLng);
    });
  });

  unittest.group('resource-ProjectsLocationsAgentsResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents;
      var arg_request = buildGoogleCloudDialogflowCxV3Agent();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3Agent.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3Agent(
            obj as api.GoogleCloudDialogflowCxV3Agent);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
        var resp = convert.json.encode(buildGoogleCloudDialogflowCxV3Agent());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3Agent(
          response as api.GoogleCloudDialogflowCxV3Agent);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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

    unittest.test('method--export', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents;
      var arg_request = buildGoogleCloudDialogflowCxV3ExportAgentRequest();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3ExportAgentRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3ExportAgentRequest(
            obj as api.GoogleCloudDialogflowCxV3ExportAgentRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
          await res.export(arg_request, arg_name, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
        var resp = convert.json.encode(buildGoogleCloudDialogflowCxV3Agent());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3Agent(
          response as api.GoogleCloudDialogflowCxV3Agent);
    });

    unittest.test('method--getValidationResult', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents;
      var arg_name = 'foo';
      var arg_languageCode = 'foo';
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["languageCode"]!.first,
          unittest.equals(arg_languageCode),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json
            .encode(buildGoogleCloudDialogflowCxV3AgentValidationResult());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.getValidationResult(arg_name,
          languageCode: arg_languageCode, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3AgentValidationResult(
          response as api.GoogleCloudDialogflowCxV3AgentValidationResult);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            .encode(buildGoogleCloudDialogflowCxV3ListAgentsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3ListAgentsResponse(
          response as api.GoogleCloudDialogflowCxV3ListAgentsResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents;
      var arg_request = buildGoogleCloudDialogflowCxV3Agent();
      var arg_name = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3Agent.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3Agent(
            obj as api.GoogleCloudDialogflowCxV3Agent);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
        var resp = convert.json.encode(buildGoogleCloudDialogflowCxV3Agent());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          updateMask: arg_updateMask, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3Agent(
          response as api.GoogleCloudDialogflowCxV3Agent);
    });

    unittest.test('method--restore', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents;
      var arg_request = buildGoogleCloudDialogflowCxV3RestoreAgentRequest();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3RestoreAgentRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3RestoreAgentRequest(
            obj as api.GoogleCloudDialogflowCxV3RestoreAgentRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
          await res.restore(arg_request, arg_name, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--validate', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents;
      var arg_request = buildGoogleCloudDialogflowCxV3ValidateAgentRequest();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3ValidateAgentRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3ValidateAgentRequest(
            obj as api.GoogleCloudDialogflowCxV3ValidateAgentRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            .encode(buildGoogleCloudDialogflowCxV3AgentValidationResult());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.validate(arg_request, arg_name, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3AgentValidationResult(
          response as api.GoogleCloudDialogflowCxV3AgentValidationResult);
    });
  });

  unittest.group('resource-ProjectsLocationsAgentsEntityTypesResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.entityTypes;
      var arg_request = buildGoogleCloudDialogflowCxV3EntityType();
      var arg_parent = 'foo';
      var arg_languageCode = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3EntityType.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3EntityType(
            obj as api.GoogleCloudDialogflowCxV3EntityType);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["languageCode"]!.first,
          unittest.equals(arg_languageCode),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp =
            convert.json.encode(buildGoogleCloudDialogflowCxV3EntityType());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.create(arg_request, arg_parent,
          languageCode: arg_languageCode, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3EntityType(
          response as api.GoogleCloudDialogflowCxV3EntityType);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.entityTypes;
      var arg_name = 'foo';
      var arg_force = true;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["force"]!.first,
          unittest.equals("$arg_force"),
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
      final response =
          await res.delete(arg_name, force: arg_force, $fields: arg_$fields);
      checkGoogleProtobufEmpty(response as api.GoogleProtobufEmpty);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.entityTypes;
      var arg_name = 'foo';
      var arg_languageCode = 'foo';
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["languageCode"]!.first,
          unittest.equals(arg_languageCode),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp =
            convert.json.encode(buildGoogleCloudDialogflowCxV3EntityType());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name,
          languageCode: arg_languageCode, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3EntityType(
          response as api.GoogleCloudDialogflowCxV3EntityType);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.entityTypes;
      var arg_parent = 'foo';
      var arg_languageCode = 'foo';
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["languageCode"]!.first,
          unittest.equals(arg_languageCode),
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
        var resp = convert.json
            .encode(buildGoogleCloudDialogflowCxV3ListEntityTypesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          languageCode: arg_languageCode,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3ListEntityTypesResponse(
          response as api.GoogleCloudDialogflowCxV3ListEntityTypesResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.entityTypes;
      var arg_request = buildGoogleCloudDialogflowCxV3EntityType();
      var arg_name = 'foo';
      var arg_languageCode = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3EntityType.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3EntityType(
            obj as api.GoogleCloudDialogflowCxV3EntityType);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["languageCode"]!.first,
          unittest.equals(arg_languageCode),
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
        var resp =
            convert.json.encode(buildGoogleCloudDialogflowCxV3EntityType());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          languageCode: arg_languageCode,
          updateMask: arg_updateMask,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3EntityType(
          response as api.GoogleCloudDialogflowCxV3EntityType);
    });
  });

  unittest.group('resource-ProjectsLocationsAgentsEnvironmentsResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.environments;
      var arg_request = buildGoogleCloudDialogflowCxV3Environment();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3Environment.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3Environment(
            obj as api.GoogleCloudDialogflowCxV3Environment);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
      var res = api.DialogflowApi(mock).projects.locations.agents.environments;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
      var res = api.DialogflowApi(mock).projects.locations.agents.environments;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            convert.json.encode(buildGoogleCloudDialogflowCxV3Environment());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3Environment(
          response as api.GoogleCloudDialogflowCxV3Environment);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.environments;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            .encode(buildGoogleCloudDialogflowCxV3ListEnvironmentsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3ListEnvironmentsResponse(
          response as api.GoogleCloudDialogflowCxV3ListEnvironmentsResponse);
    });

    unittest.test('method--lookupEnvironmentHistory', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.environments;
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
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            buildGoogleCloudDialogflowCxV3LookupEnvironmentHistoryResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.lookupEnvironmentHistory(arg_name,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3LookupEnvironmentHistoryResponse(response
          as api.GoogleCloudDialogflowCxV3LookupEnvironmentHistoryResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.environments;
      var arg_request = buildGoogleCloudDialogflowCxV3Environment();
      var arg_name = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3Environment.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3Environment(
            obj as api.GoogleCloudDialogflowCxV3Environment);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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

  unittest.group(
      'resource-ProjectsLocationsAgentsEnvironmentsExperimentsResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .locations
          .agents
          .environments
          .experiments;
      var arg_request = buildGoogleCloudDialogflowCxV3Experiment();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3Experiment.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3Experiment(
            obj as api.GoogleCloudDialogflowCxV3Experiment);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            convert.json.encode(buildGoogleCloudDialogflowCxV3Experiment());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3Experiment(
          response as api.GoogleCloudDialogflowCxV3Experiment);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .locations
          .agents
          .environments
          .experiments;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
      var res = api.DialogflowApi(mock)
          .projects
          .locations
          .agents
          .environments
          .experiments;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            convert.json.encode(buildGoogleCloudDialogflowCxV3Experiment());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3Experiment(
          response as api.GoogleCloudDialogflowCxV3Experiment);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .locations
          .agents
          .environments
          .experiments;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            .encode(buildGoogleCloudDialogflowCxV3ListExperimentsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3ListExperimentsResponse(
          response as api.GoogleCloudDialogflowCxV3ListExperimentsResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .locations
          .agents
          .environments
          .experiments;
      var arg_request = buildGoogleCloudDialogflowCxV3Experiment();
      var arg_name = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3Experiment.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3Experiment(
            obj as api.GoogleCloudDialogflowCxV3Experiment);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
        var resp =
            convert.json.encode(buildGoogleCloudDialogflowCxV3Experiment());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          updateMask: arg_updateMask, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3Experiment(
          response as api.GoogleCloudDialogflowCxV3Experiment);
    });

    unittest.test('method--start', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .locations
          .agents
          .environments
          .experiments;
      var arg_request = buildGoogleCloudDialogflowCxV3StartExperimentRequest();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3StartExperimentRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3StartExperimentRequest(
            obj as api.GoogleCloudDialogflowCxV3StartExperimentRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            convert.json.encode(buildGoogleCloudDialogflowCxV3Experiment());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.start(arg_request, arg_name, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3Experiment(
          response as api.GoogleCloudDialogflowCxV3Experiment);
    });

    unittest.test('method--stop', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .locations
          .agents
          .environments
          .experiments;
      var arg_request = buildGoogleCloudDialogflowCxV3StopExperimentRequest();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3StopExperimentRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3StopExperimentRequest(
            obj as api.GoogleCloudDialogflowCxV3StopExperimentRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            convert.json.encode(buildGoogleCloudDialogflowCxV3Experiment());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.stop(arg_request, arg_name, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3Experiment(
          response as api.GoogleCloudDialogflowCxV3Experiment);
    });
  });

  unittest.group('resource-ProjectsLocationsAgentsEnvironmentsSessionsResource',
      () {
    unittest.test('method--detectIntent', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .locations
          .agents
          .environments
          .sessions;
      var arg_request = buildGoogleCloudDialogflowCxV3DetectIntentRequest();
      var arg_session = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3DetectIntentRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3DetectIntentRequest(
            obj as api.GoogleCloudDialogflowCxV3DetectIntentRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            .encode(buildGoogleCloudDialogflowCxV3DetectIntentResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.detectIntent(arg_request, arg_session,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3DetectIntentResponse(
          response as api.GoogleCloudDialogflowCxV3DetectIntentResponse);
    });

    unittest.test('method--fulfillIntent', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .locations
          .agents
          .environments
          .sessions;
      var arg_request = buildGoogleCloudDialogflowCxV3FulfillIntentRequest();
      var arg_session = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3FulfillIntentRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3FulfillIntentRequest(
            obj as api.GoogleCloudDialogflowCxV3FulfillIntentRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            .encode(buildGoogleCloudDialogflowCxV3FulfillIntentResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.fulfillIntent(arg_request, arg_session,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3FulfillIntentResponse(
          response as api.GoogleCloudDialogflowCxV3FulfillIntentResponse);
    });

    unittest.test('method--matchIntent', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .locations
          .agents
          .environments
          .sessions;
      var arg_request = buildGoogleCloudDialogflowCxV3MatchIntentRequest();
      var arg_session = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3MatchIntentRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3MatchIntentRequest(
            obj as api.GoogleCloudDialogflowCxV3MatchIntentRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            .encode(buildGoogleCloudDialogflowCxV3MatchIntentResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.matchIntent(arg_request, arg_session, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3MatchIntentResponse(
          response as api.GoogleCloudDialogflowCxV3MatchIntentResponse);
    });
  });

  unittest.group(
      'resource-ProjectsLocationsAgentsEnvironmentsSessionsEntityTypesResource',
      () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .locations
          .agents
          .environments
          .sessions
          .entityTypes;
      var arg_request = buildGoogleCloudDialogflowCxV3SessionEntityType();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3SessionEntityType.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3SessionEntityType(
            obj as api.GoogleCloudDialogflowCxV3SessionEntityType);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            .encode(buildGoogleCloudDialogflowCxV3SessionEntityType());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3SessionEntityType(
          response as api.GoogleCloudDialogflowCxV3SessionEntityType);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .locations
          .agents
          .environments
          .sessions
          .entityTypes;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
      var res = api.DialogflowApi(mock)
          .projects
          .locations
          .agents
          .environments
          .sessions
          .entityTypes;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            .encode(buildGoogleCloudDialogflowCxV3SessionEntityType());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3SessionEntityType(
          response as api.GoogleCloudDialogflowCxV3SessionEntityType);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .locations
          .agents
          .environments
          .sessions
          .entityTypes;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            buildGoogleCloudDialogflowCxV3ListSessionEntityTypesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3ListSessionEntityTypesResponse(response
          as api.GoogleCloudDialogflowCxV3ListSessionEntityTypesResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .locations
          .agents
          .environments
          .sessions
          .entityTypes;
      var arg_request = buildGoogleCloudDialogflowCxV3SessionEntityType();
      var arg_name = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3SessionEntityType.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3SessionEntityType(
            obj as api.GoogleCloudDialogflowCxV3SessionEntityType);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
        var resp = convert.json
            .encode(buildGoogleCloudDialogflowCxV3SessionEntityType());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          updateMask: arg_updateMask, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3SessionEntityType(
          response as api.GoogleCloudDialogflowCxV3SessionEntityType);
    });
  });

  unittest.group('resource-ProjectsLocationsAgentsFlowsResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.flows;
      var arg_request = buildGoogleCloudDialogflowCxV3Flow();
      var arg_parent = 'foo';
      var arg_languageCode = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3Flow.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3Flow(
            obj as api.GoogleCloudDialogflowCxV3Flow);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["languageCode"]!.first,
          unittest.equals(arg_languageCode),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleCloudDialogflowCxV3Flow());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.create(arg_request, arg_parent,
          languageCode: arg_languageCode, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3Flow(
          response as api.GoogleCloudDialogflowCxV3Flow);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.flows;
      var arg_name = 'foo';
      var arg_force = true;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["force"]!.first,
          unittest.equals("$arg_force"),
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
      final response =
          await res.delete(arg_name, force: arg_force, $fields: arg_$fields);
      checkGoogleProtobufEmpty(response as api.GoogleProtobufEmpty);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.flows;
      var arg_name = 'foo';
      var arg_languageCode = 'foo';
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["languageCode"]!.first,
          unittest.equals(arg_languageCode),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleCloudDialogflowCxV3Flow());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name,
          languageCode: arg_languageCode, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3Flow(
          response as api.GoogleCloudDialogflowCxV3Flow);
    });

    unittest.test('method--getValidationResult', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.flows;
      var arg_name = 'foo';
      var arg_languageCode = 'foo';
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["languageCode"]!.first,
          unittest.equals(arg_languageCode),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json
            .encode(buildGoogleCloudDialogflowCxV3FlowValidationResult());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.getValidationResult(arg_name,
          languageCode: arg_languageCode, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3FlowValidationResult(
          response as api.GoogleCloudDialogflowCxV3FlowValidationResult);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.flows;
      var arg_parent = 'foo';
      var arg_languageCode = 'foo';
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["languageCode"]!.first,
          unittest.equals(arg_languageCode),
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
        var resp = convert.json
            .encode(buildGoogleCloudDialogflowCxV3ListFlowsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          languageCode: arg_languageCode,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3ListFlowsResponse(
          response as api.GoogleCloudDialogflowCxV3ListFlowsResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.flows;
      var arg_request = buildGoogleCloudDialogflowCxV3Flow();
      var arg_name = 'foo';
      var arg_languageCode = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3Flow.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3Flow(
            obj as api.GoogleCloudDialogflowCxV3Flow);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["languageCode"]!.first,
          unittest.equals(arg_languageCode),
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
        var resp = convert.json.encode(buildGoogleCloudDialogflowCxV3Flow());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          languageCode: arg_languageCode,
          updateMask: arg_updateMask,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3Flow(
          response as api.GoogleCloudDialogflowCxV3Flow);
    });

    unittest.test('method--train', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.flows;
      var arg_request = buildGoogleCloudDialogflowCxV3TrainFlowRequest();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3TrainFlowRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3TrainFlowRequest(
            obj as api.GoogleCloudDialogflowCxV3TrainFlowRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
          await res.train(arg_request, arg_name, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--validate', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.flows;
      var arg_request = buildGoogleCloudDialogflowCxV3ValidateFlowRequest();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3ValidateFlowRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3ValidateFlowRequest(
            obj as api.GoogleCloudDialogflowCxV3ValidateFlowRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            .encode(buildGoogleCloudDialogflowCxV3FlowValidationResult());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.validate(arg_request, arg_name, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3FlowValidationResult(
          response as api.GoogleCloudDialogflowCxV3FlowValidationResult);
    });
  });

  unittest.group('resource-ProjectsLocationsAgentsFlowsPagesResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.flows.pages;
      var arg_request = buildGoogleCloudDialogflowCxV3Page();
      var arg_parent = 'foo';
      var arg_languageCode = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3Page.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3Page(
            obj as api.GoogleCloudDialogflowCxV3Page);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["languageCode"]!.first,
          unittest.equals(arg_languageCode),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleCloudDialogflowCxV3Page());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.create(arg_request, arg_parent,
          languageCode: arg_languageCode, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3Page(
          response as api.GoogleCloudDialogflowCxV3Page);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.flows.pages;
      var arg_name = 'foo';
      var arg_force = true;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["force"]!.first,
          unittest.equals("$arg_force"),
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
      final response =
          await res.delete(arg_name, force: arg_force, $fields: arg_$fields);
      checkGoogleProtobufEmpty(response as api.GoogleProtobufEmpty);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.flows.pages;
      var arg_name = 'foo';
      var arg_languageCode = 'foo';
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["languageCode"]!.first,
          unittest.equals(arg_languageCode),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleCloudDialogflowCxV3Page());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name,
          languageCode: arg_languageCode, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3Page(
          response as api.GoogleCloudDialogflowCxV3Page);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.flows.pages;
      var arg_parent = 'foo';
      var arg_languageCode = 'foo';
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["languageCode"]!.first,
          unittest.equals(arg_languageCode),
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
        var resp = convert.json
            .encode(buildGoogleCloudDialogflowCxV3ListPagesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          languageCode: arg_languageCode,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3ListPagesResponse(
          response as api.GoogleCloudDialogflowCxV3ListPagesResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.flows.pages;
      var arg_request = buildGoogleCloudDialogflowCxV3Page();
      var arg_name = 'foo';
      var arg_languageCode = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3Page.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3Page(
            obj as api.GoogleCloudDialogflowCxV3Page);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["languageCode"]!.first,
          unittest.equals(arg_languageCode),
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
        var resp = convert.json.encode(buildGoogleCloudDialogflowCxV3Page());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          languageCode: arg_languageCode,
          updateMask: arg_updateMask,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3Page(
          response as api.GoogleCloudDialogflowCxV3Page);
    });
  });

  unittest.group(
      'resource-ProjectsLocationsAgentsFlowsTransitionRouteGroupsResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .locations
          .agents
          .flows
          .transitionRouteGroups;
      var arg_request = buildGoogleCloudDialogflowCxV3TransitionRouteGroup();
      var arg_parent = 'foo';
      var arg_languageCode = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3TransitionRouteGroup.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3TransitionRouteGroup(
            obj as api.GoogleCloudDialogflowCxV3TransitionRouteGroup);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["languageCode"]!.first,
          unittest.equals(arg_languageCode),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json
            .encode(buildGoogleCloudDialogflowCxV3TransitionRouteGroup());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.create(arg_request, arg_parent,
          languageCode: arg_languageCode, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3TransitionRouteGroup(
          response as api.GoogleCloudDialogflowCxV3TransitionRouteGroup);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .locations
          .agents
          .flows
          .transitionRouteGroups;
      var arg_name = 'foo';
      var arg_force = true;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["force"]!.first,
          unittest.equals("$arg_force"),
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
      final response =
          await res.delete(arg_name, force: arg_force, $fields: arg_$fields);
      checkGoogleProtobufEmpty(response as api.GoogleProtobufEmpty);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .locations
          .agents
          .flows
          .transitionRouteGroups;
      var arg_name = 'foo';
      var arg_languageCode = 'foo';
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["languageCode"]!.first,
          unittest.equals(arg_languageCode),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json
            .encode(buildGoogleCloudDialogflowCxV3TransitionRouteGroup());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name,
          languageCode: arg_languageCode, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3TransitionRouteGroup(
          response as api.GoogleCloudDialogflowCxV3TransitionRouteGroup);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .locations
          .agents
          .flows
          .transitionRouteGroups;
      var arg_parent = 'foo';
      var arg_languageCode = 'foo';
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["languageCode"]!.first,
          unittest.equals(arg_languageCode),
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
        var resp = convert.json.encode(
            buildGoogleCloudDialogflowCxV3ListTransitionRouteGroupsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          languageCode: arg_languageCode,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3ListTransitionRouteGroupsResponse(response
          as api.GoogleCloudDialogflowCxV3ListTransitionRouteGroupsResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .locations
          .agents
          .flows
          .transitionRouteGroups;
      var arg_request = buildGoogleCloudDialogflowCxV3TransitionRouteGroup();
      var arg_name = 'foo';
      var arg_languageCode = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3TransitionRouteGroup.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3TransitionRouteGroup(
            obj as api.GoogleCloudDialogflowCxV3TransitionRouteGroup);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["languageCode"]!.first,
          unittest.equals(arg_languageCode),
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
        var resp = convert.json
            .encode(buildGoogleCloudDialogflowCxV3TransitionRouteGroup());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          languageCode: arg_languageCode,
          updateMask: arg_updateMask,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3TransitionRouteGroup(
          response as api.GoogleCloudDialogflowCxV3TransitionRouteGroup);
    });
  });

  unittest.group('resource-ProjectsLocationsAgentsFlowsVersionsResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res =
          api.DialogflowApi(mock).projects.locations.agents.flows.versions;
      var arg_request = buildGoogleCloudDialogflowCxV3Version();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3Version.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3Version(
            obj as api.GoogleCloudDialogflowCxV3Version);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
      var res =
          api.DialogflowApi(mock).projects.locations.agents.flows.versions;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
      var res =
          api.DialogflowApi(mock).projects.locations.agents.flows.versions;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
        var resp = convert.json.encode(buildGoogleCloudDialogflowCxV3Version());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3Version(
          response as api.GoogleCloudDialogflowCxV3Version);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res =
          api.DialogflowApi(mock).projects.locations.agents.flows.versions;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            .encode(buildGoogleCloudDialogflowCxV3ListVersionsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3ListVersionsResponse(
          response as api.GoogleCloudDialogflowCxV3ListVersionsResponse);
    });

    unittest.test('method--load', () async {
      var mock = HttpServerMock();
      var res =
          api.DialogflowApi(mock).projects.locations.agents.flows.versions;
      var arg_request = buildGoogleCloudDialogflowCxV3LoadVersionRequest();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3LoadVersionRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3LoadVersionRequest(
            obj as api.GoogleCloudDialogflowCxV3LoadVersionRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
          await res.load(arg_request, arg_name, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res =
          api.DialogflowApi(mock).projects.locations.agents.flows.versions;
      var arg_request = buildGoogleCloudDialogflowCxV3Version();
      var arg_name = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3Version.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3Version(
            obj as api.GoogleCloudDialogflowCxV3Version);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
        var resp = convert.json.encode(buildGoogleCloudDialogflowCxV3Version());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          updateMask: arg_updateMask, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3Version(
          response as api.GoogleCloudDialogflowCxV3Version);
    });
  });

  unittest.group('resource-ProjectsLocationsAgentsIntentsResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.intents;
      var arg_request = buildGoogleCloudDialogflowCxV3Intent();
      var arg_parent = 'foo';
      var arg_languageCode = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3Intent.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3Intent(
            obj as api.GoogleCloudDialogflowCxV3Intent);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["languageCode"]!.first,
          unittest.equals(arg_languageCode),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleCloudDialogflowCxV3Intent());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.create(arg_request, arg_parent,
          languageCode: arg_languageCode, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3Intent(
          response as api.GoogleCloudDialogflowCxV3Intent);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.intents;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
      var res = api.DialogflowApi(mock).projects.locations.agents.intents;
      var arg_name = 'foo';
      var arg_languageCode = 'foo';
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["languageCode"]!.first,
          unittest.equals(arg_languageCode),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildGoogleCloudDialogflowCxV3Intent());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name,
          languageCode: arg_languageCode, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3Intent(
          response as api.GoogleCloudDialogflowCxV3Intent);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.intents;
      var arg_parent = 'foo';
      var arg_intentView = 'foo';
      var arg_languageCode = 'foo';
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["intentView"]!.first,
          unittest.equals(arg_intentView),
        );
        unittest.expect(
          queryMap["languageCode"]!.first,
          unittest.equals(arg_languageCode),
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
        var resp = convert.json
            .encode(buildGoogleCloudDialogflowCxV3ListIntentsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          intentView: arg_intentView,
          languageCode: arg_languageCode,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3ListIntentsResponse(
          response as api.GoogleCloudDialogflowCxV3ListIntentsResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.intents;
      var arg_request = buildGoogleCloudDialogflowCxV3Intent();
      var arg_name = 'foo';
      var arg_languageCode = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3Intent.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3Intent(
            obj as api.GoogleCloudDialogflowCxV3Intent);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["languageCode"]!.first,
          unittest.equals(arg_languageCode),
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
        var resp = convert.json.encode(buildGoogleCloudDialogflowCxV3Intent());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          languageCode: arg_languageCode,
          updateMask: arg_updateMask,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3Intent(
          response as api.GoogleCloudDialogflowCxV3Intent);
    });
  });

  unittest.group('resource-ProjectsLocationsAgentsSessionsResource', () {
    unittest.test('method--detectIntent', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.sessions;
      var arg_request = buildGoogleCloudDialogflowCxV3DetectIntentRequest();
      var arg_session = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3DetectIntentRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3DetectIntentRequest(
            obj as api.GoogleCloudDialogflowCxV3DetectIntentRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            .encode(buildGoogleCloudDialogflowCxV3DetectIntentResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.detectIntent(arg_request, arg_session,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3DetectIntentResponse(
          response as api.GoogleCloudDialogflowCxV3DetectIntentResponse);
    });

    unittest.test('method--fulfillIntent', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.sessions;
      var arg_request = buildGoogleCloudDialogflowCxV3FulfillIntentRequest();
      var arg_session = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3FulfillIntentRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3FulfillIntentRequest(
            obj as api.GoogleCloudDialogflowCxV3FulfillIntentRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            .encode(buildGoogleCloudDialogflowCxV3FulfillIntentResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.fulfillIntent(arg_request, arg_session,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3FulfillIntentResponse(
          response as api.GoogleCloudDialogflowCxV3FulfillIntentResponse);
    });

    unittest.test('method--matchIntent', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.sessions;
      var arg_request = buildGoogleCloudDialogflowCxV3MatchIntentRequest();
      var arg_session = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3MatchIntentRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3MatchIntentRequest(
            obj as api.GoogleCloudDialogflowCxV3MatchIntentRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            .encode(buildGoogleCloudDialogflowCxV3MatchIntentResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.matchIntent(arg_request, arg_session, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3MatchIntentResponse(
          response as api.GoogleCloudDialogflowCxV3MatchIntentResponse);
    });
  });

  unittest.group('resource-ProjectsLocationsAgentsSessionsEntityTypesResource',
      () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .locations
          .agents
          .sessions
          .entityTypes;
      var arg_request = buildGoogleCloudDialogflowCxV3SessionEntityType();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3SessionEntityType.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3SessionEntityType(
            obj as api.GoogleCloudDialogflowCxV3SessionEntityType);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            .encode(buildGoogleCloudDialogflowCxV3SessionEntityType());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3SessionEntityType(
          response as api.GoogleCloudDialogflowCxV3SessionEntityType);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .locations
          .agents
          .sessions
          .entityTypes;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
      var res = api.DialogflowApi(mock)
          .projects
          .locations
          .agents
          .sessions
          .entityTypes;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            .encode(buildGoogleCloudDialogflowCxV3SessionEntityType());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3SessionEntityType(
          response as api.GoogleCloudDialogflowCxV3SessionEntityType);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .locations
          .agents
          .sessions
          .entityTypes;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            buildGoogleCloudDialogflowCxV3ListSessionEntityTypesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3ListSessionEntityTypesResponse(response
          as api.GoogleCloudDialogflowCxV3ListSessionEntityTypesResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .locations
          .agents
          .sessions
          .entityTypes;
      var arg_request = buildGoogleCloudDialogflowCxV3SessionEntityType();
      var arg_name = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3SessionEntityType.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3SessionEntityType(
            obj as api.GoogleCloudDialogflowCxV3SessionEntityType);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
        var resp = convert.json
            .encode(buildGoogleCloudDialogflowCxV3SessionEntityType());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          updateMask: arg_updateMask, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3SessionEntityType(
          response as api.GoogleCloudDialogflowCxV3SessionEntityType);
    });
  });

  unittest.group('resource-ProjectsLocationsAgentsTestCasesResource', () {
    unittest.test('method--batchDelete', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.testCases;
      var arg_request =
          buildGoogleCloudDialogflowCxV3BatchDeleteTestCasesRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj =
            api.GoogleCloudDialogflowCxV3BatchDeleteTestCasesRequest.fromJson(
                json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3BatchDeleteTestCasesRequest(
            obj as api.GoogleCloudDialogflowCxV3BatchDeleteTestCasesRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
          await res.batchDelete(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleProtobufEmpty(response as api.GoogleProtobufEmpty);
    });

    unittest.test('method--batchRun', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.testCases;
      var arg_request =
          buildGoogleCloudDialogflowCxV3BatchRunTestCasesRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj =
            api.GoogleCloudDialogflowCxV3BatchRunTestCasesRequest.fromJson(
                json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3BatchRunTestCasesRequest(
            obj as api.GoogleCloudDialogflowCxV3BatchRunTestCasesRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
          await res.batchRun(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--calculateCoverage', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.testCases;
      var arg_agent = 'foo';
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            .encode(buildGoogleCloudDialogflowCxV3CalculateCoverageResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.calculateCoverage(arg_agent,
          type: arg_type, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3CalculateCoverageResponse(
          response as api.GoogleCloudDialogflowCxV3CalculateCoverageResponse);
    });

    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.testCases;
      var arg_request = buildGoogleCloudDialogflowCxV3TestCase();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3TestCase.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3TestCase(
            obj as api.GoogleCloudDialogflowCxV3TestCase);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            convert.json.encode(buildGoogleCloudDialogflowCxV3TestCase());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3TestCase(
          response as api.GoogleCloudDialogflowCxV3TestCase);
    });

    unittest.test('method--export', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.testCases;
      var arg_request = buildGoogleCloudDialogflowCxV3ExportTestCasesRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3ExportTestCasesRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3ExportTestCasesRequest(
            obj as api.GoogleCloudDialogflowCxV3ExportTestCasesRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
          await res.export(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.testCases;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            convert.json.encode(buildGoogleCloudDialogflowCxV3TestCase());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3TestCase(
          response as api.GoogleCloudDialogflowCxV3TestCase);
    });

    unittest.test('method--import', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.testCases;
      var arg_request = buildGoogleCloudDialogflowCxV3ImportTestCasesRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3ImportTestCasesRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3ImportTestCasesRequest(
            obj as api.GoogleCloudDialogflowCxV3ImportTestCasesRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.testCases;
      var arg_parent = 'foo';
      var arg_pageSize = 42;
      var arg_pageToken = 'foo';
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
        var resp = convert.json
            .encode(buildGoogleCloudDialogflowCxV3ListTestCasesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          view: arg_view,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3ListTestCasesResponse(
          response as api.GoogleCloudDialogflowCxV3ListTestCasesResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.testCases;
      var arg_request = buildGoogleCloudDialogflowCxV3TestCase();
      var arg_name = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3TestCase.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3TestCase(
            obj as api.GoogleCloudDialogflowCxV3TestCase);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
        var resp =
            convert.json.encode(buildGoogleCloudDialogflowCxV3TestCase());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          updateMask: arg_updateMask, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3TestCase(
          response as api.GoogleCloudDialogflowCxV3TestCase);
    });

    unittest.test('method--run', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.testCases;
      var arg_request = buildGoogleCloudDialogflowCxV3RunTestCaseRequest();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3RunTestCaseRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3RunTestCaseRequest(
            obj as api.GoogleCloudDialogflowCxV3RunTestCaseRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
          await res.run(arg_request, arg_name, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });
  });

  unittest.group('resource-ProjectsLocationsAgentsTestCasesResultsResource',
      () {
    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res =
          api.DialogflowApi(mock).projects.locations.agents.testCases.results;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
        var resp = convert.json.encode(
            buildGoogleCloudDialogflowCxV3ListTestCaseResultsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          filter: arg_filter,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3ListTestCaseResultsResponse(
          response as api.GoogleCloudDialogflowCxV3ListTestCaseResultsResponse);
    });
  });

  unittest.group('resource-ProjectsLocationsAgentsWebhooksResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.webhooks;
      var arg_request = buildGoogleCloudDialogflowCxV3Webhook();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3Webhook.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3Webhook(
            obj as api.GoogleCloudDialogflowCxV3Webhook);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
        var resp = convert.json.encode(buildGoogleCloudDialogflowCxV3Webhook());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3Webhook(
          response as api.GoogleCloudDialogflowCxV3Webhook);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.webhooks;
      var arg_name = 'foo';
      var arg_force = true;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
          }
        }
        unittest.expect(
          queryMap["force"]!.first,
          unittest.equals("$arg_force"),
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
      final response =
          await res.delete(arg_name, force: arg_force, $fields: arg_$fields);
      checkGoogleProtobufEmpty(response as api.GoogleProtobufEmpty);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.webhooks;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
        var resp = convert.json.encode(buildGoogleCloudDialogflowCxV3Webhook());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3Webhook(
          response as api.GoogleCloudDialogflowCxV3Webhook);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.webhooks;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            .encode(buildGoogleCloudDialogflowCxV3ListWebhooksResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3ListWebhooksResponse(
          response as api.GoogleCloudDialogflowCxV3ListWebhooksResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.agents.webhooks;
      var arg_request = buildGoogleCloudDialogflowCxV3Webhook();
      var arg_name = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3Webhook.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3Webhook(
            obj as api.GoogleCloudDialogflowCxV3Webhook);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
        var resp = convert.json.encode(buildGoogleCloudDialogflowCxV3Webhook());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          updateMask: arg_updateMask, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3Webhook(
          response as api.GoogleCloudDialogflowCxV3Webhook);
    });
  });

  unittest.group('resource-ProjectsLocationsOperationsResource', () {
    unittest.test('method--cancel', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.operations;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
      final response = await res.cancel(arg_name, $fields: arg_$fields);
      checkGoogleProtobufEmpty(response as api.GoogleProtobufEmpty);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.operations;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
      var res = api.DialogflowApi(mock).projects.locations.operations;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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

  unittest.group('resource-ProjectsLocationsSecuritySettingsResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.securitySettings;
      var arg_request = buildGoogleCloudDialogflowCxV3SecuritySettings();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3SecuritySettings.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3SecuritySettings(
            obj as api.GoogleCloudDialogflowCxV3SecuritySettings);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            .encode(buildGoogleCloudDialogflowCxV3SecuritySettings());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3SecuritySettings(
          response as api.GoogleCloudDialogflowCxV3SecuritySettings);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.securitySettings;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
      var res = api.DialogflowApi(mock).projects.locations.securitySettings;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            .encode(buildGoogleCloudDialogflowCxV3SecuritySettings());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3SecuritySettings(
          response as api.GoogleCloudDialogflowCxV3SecuritySettings);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.securitySettings;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
            buildGoogleCloudDialogflowCxV3ListSecuritySettingsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3ListSecuritySettingsResponse(response
          as api.GoogleCloudDialogflowCxV3ListSecuritySettingsResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.locations.securitySettings;
      var arg_request = buildGoogleCloudDialogflowCxV3SecuritySettings();
      var arg_name = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowCxV3SecuritySettings.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowCxV3SecuritySettings(
            obj as api.GoogleCloudDialogflowCxV3SecuritySettings);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
        var resp = convert.json
            .encode(buildGoogleCloudDialogflowCxV3SecuritySettings());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          updateMask: arg_updateMask, $fields: arg_$fields);
      checkGoogleCloudDialogflowCxV3SecuritySettings(
          response as api.GoogleCloudDialogflowCxV3SecuritySettings);
    });
  });

  unittest.group('resource-ProjectsOperationsResource', () {
    unittest.test('method--cancel', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.operations;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
      final response = await res.cancel(arg_name, $fields: arg_$fields);
      checkGoogleProtobufEmpty(response as api.GoogleProtobufEmpty);
    });

    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.operations;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
      var res = api.DialogflowApi(mock).projects.operations;
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
          unittest.equals("v3/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
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
