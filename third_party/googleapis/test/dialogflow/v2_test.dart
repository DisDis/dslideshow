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
import 'package:googleapis/dialogflow/v2.dart' as api;

import '../test_shared.dart';

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

core.List<api.GoogleCloudDialogflowCxV3TestError> buildUnnamed4561() {
  var o = <api.GoogleCloudDialogflowCxV3TestError>[];
  o.add(buildGoogleCloudDialogflowCxV3TestError());
  o.add(buildGoogleCloudDialogflowCxV3TestError());
  return o;
}

void checkUnnamed4561(core.List<api.GoogleCloudDialogflowCxV3TestError> o) {
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
    o.errors = buildUnnamed4561();
  }
  buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3BatchRunTestCasesMetadata(
    api.GoogleCloudDialogflowCxV3BatchRunTestCasesMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesMetadata < 3) {
    checkUnnamed4561(o.errors!);
  }
  buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesMetadata--;
}

core.List<api.GoogleCloudDialogflowCxV3TestCaseResult> buildUnnamed4562() {
  var o = <api.GoogleCloudDialogflowCxV3TestCaseResult>[];
  o.add(buildGoogleCloudDialogflowCxV3TestCaseResult());
  o.add(buildGoogleCloudDialogflowCxV3TestCaseResult());
  return o;
}

void checkUnnamed4562(
    core.List<api.GoogleCloudDialogflowCxV3TestCaseResult> o) {
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
    o.results = buildUnnamed4562();
  }
  buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3BatchRunTestCasesResponse(
    api.GoogleCloudDialogflowCxV3BatchRunTestCasesResponse o) {
  buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesResponse < 3) {
    checkUnnamed4562(o.results!);
  }
  buildCounterGoogleCloudDialogflowCxV3BatchRunTestCasesResponse--;
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

core.Map<core.String, core.Object> buildUnnamed4563() {
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

void checkUnnamed4563(core.Map<core.String, core.Object> o) {
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
    o.injectedParameters = buildUnnamed4563();
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
    checkUnnamed4563(o.injectedParameters!);
    checkGoogleCloudDialogflowCxV3QueryInput(
        o.input! as api.GoogleCloudDialogflowCxV3QueryInput);
    unittest.expect(o.isWebhookEnabled!, unittest.isTrue);
  }
  buildCounterGoogleCloudDialogflowCxV3ConversationTurnUserInput--;
}

core.Map<core.String, core.Object> buildUnnamed4564() {
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

void checkUnnamed4564(core.Map<core.String, core.Object> o) {
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

core.List<api.GoogleCloudDialogflowCxV3TestRunDifference> buildUnnamed4565() {
  var o = <api.GoogleCloudDialogflowCxV3TestRunDifference>[];
  o.add(buildGoogleCloudDialogflowCxV3TestRunDifference());
  o.add(buildGoogleCloudDialogflowCxV3TestRunDifference());
  return o;
}

void checkUnnamed4565(
    core.List<api.GoogleCloudDialogflowCxV3TestRunDifference> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3TestRunDifference(
      o[0] as api.GoogleCloudDialogflowCxV3TestRunDifference);
  checkGoogleCloudDialogflowCxV3TestRunDifference(
      o[1] as api.GoogleCloudDialogflowCxV3TestRunDifference);
}

core.Map<core.String, core.Object> buildUnnamed4566() {
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

void checkUnnamed4566(core.Map<core.String, core.Object> o) {
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

core.List<api.GoogleCloudDialogflowCxV3ResponseMessageText> buildUnnamed4567() {
  var o = <api.GoogleCloudDialogflowCxV3ResponseMessageText>[];
  o.add(buildGoogleCloudDialogflowCxV3ResponseMessageText());
  o.add(buildGoogleCloudDialogflowCxV3ResponseMessageText());
  return o;
}

void checkUnnamed4567(
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
    o.diagnosticInfo = buildUnnamed4564();
    o.differences = buildUnnamed4565();
    o.sessionParameters = buildUnnamed4566();
    o.status = buildGoogleRpcStatus();
    o.textResponses = buildUnnamed4567();
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
    checkUnnamed4564(o.diagnosticInfo!);
    checkUnnamed4565(o.differences!);
    checkUnnamed4566(o.sessionParameters!);
    checkGoogleRpcStatus(o.status! as api.GoogleRpcStatus);
    checkUnnamed4567(o.textResponses!);
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

core.List<api.GoogleCloudDialogflowCxV3FormParameter> buildUnnamed4568() {
  var o = <api.GoogleCloudDialogflowCxV3FormParameter>[];
  o.add(buildGoogleCloudDialogflowCxV3FormParameter());
  o.add(buildGoogleCloudDialogflowCxV3FormParameter());
  return o;
}

void checkUnnamed4568(core.List<api.GoogleCloudDialogflowCxV3FormParameter> o) {
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
    o.parameters = buildUnnamed4568();
  }
  buildCounterGoogleCloudDialogflowCxV3Form--;
  return o;
}

void checkGoogleCloudDialogflowCxV3Form(api.GoogleCloudDialogflowCxV3Form o) {
  buildCounterGoogleCloudDialogflowCxV3Form++;
  if (buildCounterGoogleCloudDialogflowCxV3Form < 3) {
    checkUnnamed4568(o.parameters!);
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

core.List<api.GoogleCloudDialogflowCxV3EventHandler> buildUnnamed4569() {
  var o = <api.GoogleCloudDialogflowCxV3EventHandler>[];
  o.add(buildGoogleCloudDialogflowCxV3EventHandler());
  o.add(buildGoogleCloudDialogflowCxV3EventHandler());
  return o;
}

void checkUnnamed4569(core.List<api.GoogleCloudDialogflowCxV3EventHandler> o) {
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
    o.repromptEventHandlers = buildUnnamed4569();
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
    checkUnnamed4569(o.repromptEventHandlers!);
  }
  buildCounterGoogleCloudDialogflowCxV3FormParameterFillBehavior--;
}

core.List<api.GoogleCloudDialogflowCxV3FulfillmentConditionalCases>
    buildUnnamed4570() {
  var o = <api.GoogleCloudDialogflowCxV3FulfillmentConditionalCases>[];
  o.add(buildGoogleCloudDialogflowCxV3FulfillmentConditionalCases());
  o.add(buildGoogleCloudDialogflowCxV3FulfillmentConditionalCases());
  return o;
}

void checkUnnamed4570(
    core.List<api.GoogleCloudDialogflowCxV3FulfillmentConditionalCases> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3FulfillmentConditionalCases(
      o[0] as api.GoogleCloudDialogflowCxV3FulfillmentConditionalCases);
  checkGoogleCloudDialogflowCxV3FulfillmentConditionalCases(
      o[1] as api.GoogleCloudDialogflowCxV3FulfillmentConditionalCases);
}

core.List<api.GoogleCloudDialogflowCxV3ResponseMessage> buildUnnamed4571() {
  var o = <api.GoogleCloudDialogflowCxV3ResponseMessage>[];
  o.add(buildGoogleCloudDialogflowCxV3ResponseMessage());
  o.add(buildGoogleCloudDialogflowCxV3ResponseMessage());
  return o;
}

void checkUnnamed4571(
    core.List<api.GoogleCloudDialogflowCxV3ResponseMessage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3ResponseMessage(
      o[0] as api.GoogleCloudDialogflowCxV3ResponseMessage);
  checkGoogleCloudDialogflowCxV3ResponseMessage(
      o[1] as api.GoogleCloudDialogflowCxV3ResponseMessage);
}

core.List<api.GoogleCloudDialogflowCxV3FulfillmentSetParameterAction>
    buildUnnamed4572() {
  var o = <api.GoogleCloudDialogflowCxV3FulfillmentSetParameterAction>[];
  o.add(buildGoogleCloudDialogflowCxV3FulfillmentSetParameterAction());
  o.add(buildGoogleCloudDialogflowCxV3FulfillmentSetParameterAction());
  return o;
}

void checkUnnamed4572(
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
    o.conditionalCases = buildUnnamed4570();
    o.messages = buildUnnamed4571();
    o.setParameterActions = buildUnnamed4572();
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
    checkUnnamed4570(o.conditionalCases!);
    checkUnnamed4571(o.messages!);
    checkUnnamed4572(o.setParameterActions!);
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
    buildUnnamed4573() {
  var o = <api.GoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase>[];
  o.add(buildGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase());
  o.add(buildGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCase());
  return o;
}

void checkUnnamed4573(
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
    o.cases = buildUnnamed4573();
  }
  buildCounterGoogleCloudDialogflowCxV3FulfillmentConditionalCases--;
  return o;
}

void checkGoogleCloudDialogflowCxV3FulfillmentConditionalCases(
    api.GoogleCloudDialogflowCxV3FulfillmentConditionalCases o) {
  buildCounterGoogleCloudDialogflowCxV3FulfillmentConditionalCases++;
  if (buildCounterGoogleCloudDialogflowCxV3FulfillmentConditionalCases < 3) {
    checkUnnamed4573(o.cases!);
  }
  buildCounterGoogleCloudDialogflowCxV3FulfillmentConditionalCases--;
}

core.List<
        api.GoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent>
    buildUnnamed4574() {
  var o = <
      api.GoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent>[];
  o.add(
      buildGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent());
  o.add(
      buildGoogleCloudDialogflowCxV3FulfillmentConditionalCasesCaseCaseContent());
  return o;
}

void checkUnnamed4574(
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
    o.caseContent = buildUnnamed4574();
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
    checkUnnamed4574(o.caseContent!);
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

core.List<api.GoogleRpcStatus> buildUnnamed4575() {
  var o = <api.GoogleRpcStatus>[];
  o.add(buildGoogleRpcStatus());
  o.add(buildGoogleRpcStatus());
  return o;
}

void checkUnnamed4575(core.List<api.GoogleRpcStatus> o) {
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
    o.warnings = buildUnnamed4575();
  }
  buildCounterGoogleCloudDialogflowCxV3ImportDocumentsResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ImportDocumentsResponse(
    api.GoogleCloudDialogflowCxV3ImportDocumentsResponse o) {
  buildCounterGoogleCloudDialogflowCxV3ImportDocumentsResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ImportDocumentsResponse < 3) {
    checkUnnamed4575(o.warnings!);
  }
  buildCounterGoogleCloudDialogflowCxV3ImportDocumentsResponse--;
}

core.List<api.GoogleCloudDialogflowCxV3TestCaseError> buildUnnamed4576() {
  var o = <api.GoogleCloudDialogflowCxV3TestCaseError>[];
  o.add(buildGoogleCloudDialogflowCxV3TestCaseError());
  o.add(buildGoogleCloudDialogflowCxV3TestCaseError());
  return o;
}

void checkUnnamed4576(core.List<api.GoogleCloudDialogflowCxV3TestCaseError> o) {
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
    o.errors = buildUnnamed4576();
  }
  buildCounterGoogleCloudDialogflowCxV3ImportTestCasesMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ImportTestCasesMetadata(
    api.GoogleCloudDialogflowCxV3ImportTestCasesMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3ImportTestCasesMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3ImportTestCasesMetadata < 3) {
    checkUnnamed4576(o.errors!);
  }
  buildCounterGoogleCloudDialogflowCxV3ImportTestCasesMetadata--;
}

core.List<core.String> buildUnnamed4577() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4577(core.List<core.String> o) {
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
    o.names = buildUnnamed4577();
  }
  buildCounterGoogleCloudDialogflowCxV3ImportTestCasesResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ImportTestCasesResponse(
    api.GoogleCloudDialogflowCxV3ImportTestCasesResponse o) {
  buildCounterGoogleCloudDialogflowCxV3ImportTestCasesResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3ImportTestCasesResponse < 3) {
    checkUnnamed4577(o.names!);
  }
  buildCounterGoogleCloudDialogflowCxV3ImportTestCasesResponse--;
}

core.List<core.String> buildUnnamed4578() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4578(core.List<core.String> o) {
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
    o.phraseHints = buildUnnamed4578();
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
    checkUnnamed4578(o.phraseHints!);
    unittest.expect(
      o.sampleRateHertz!,
      unittest.equals(42),
    );
    unittest.expect(o.singleUtterance!, unittest.isTrue);
  }
  buildCounterGoogleCloudDialogflowCxV3InputAudioConfig--;
}

core.Map<core.String, core.String> buildUnnamed4579() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed4579(core.Map<core.String, core.String> o) {
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

core.List<api.GoogleCloudDialogflowCxV3IntentParameter> buildUnnamed4580() {
  var o = <api.GoogleCloudDialogflowCxV3IntentParameter>[];
  o.add(buildGoogleCloudDialogflowCxV3IntentParameter());
  o.add(buildGoogleCloudDialogflowCxV3IntentParameter());
  return o;
}

void checkUnnamed4580(
    core.List<api.GoogleCloudDialogflowCxV3IntentParameter> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3IntentParameter(
      o[0] as api.GoogleCloudDialogflowCxV3IntentParameter);
  checkGoogleCloudDialogflowCxV3IntentParameter(
      o[1] as api.GoogleCloudDialogflowCxV3IntentParameter);
}

core.List<api.GoogleCloudDialogflowCxV3IntentTrainingPhrase>
    buildUnnamed4581() {
  var o = <api.GoogleCloudDialogflowCxV3IntentTrainingPhrase>[];
  o.add(buildGoogleCloudDialogflowCxV3IntentTrainingPhrase());
  o.add(buildGoogleCloudDialogflowCxV3IntentTrainingPhrase());
  return o;
}

void checkUnnamed4581(
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
    o.labels = buildUnnamed4579();
    o.name = 'foo';
    o.parameters = buildUnnamed4580();
    o.priority = 42;
    o.trainingPhrases = buildUnnamed4581();
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
    checkUnnamed4579(o.labels!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed4580(o.parameters!);
    unittest.expect(
      o.priority!,
      unittest.equals(42),
    );
    checkUnnamed4581(o.trainingPhrases!);
  }
  buildCounterGoogleCloudDialogflowCxV3Intent--;
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
    buildUnnamed4582() {
  var o = <api.GoogleCloudDialogflowCxV3IntentTrainingPhrasePart>[];
  o.add(buildGoogleCloudDialogflowCxV3IntentTrainingPhrasePart());
  o.add(buildGoogleCloudDialogflowCxV3IntentTrainingPhrasePart());
  return o;
}

void checkUnnamed4582(
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
    o.parts = buildUnnamed4582();
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
    checkUnnamed4582(o.parts!);
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

core.List<api.GoogleCloudDialogflowCxV3EventHandler> buildUnnamed4583() {
  var o = <api.GoogleCloudDialogflowCxV3EventHandler>[];
  o.add(buildGoogleCloudDialogflowCxV3EventHandler());
  o.add(buildGoogleCloudDialogflowCxV3EventHandler());
  return o;
}

void checkUnnamed4583(core.List<api.GoogleCloudDialogflowCxV3EventHandler> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3EventHandler(
      o[0] as api.GoogleCloudDialogflowCxV3EventHandler);
  checkGoogleCloudDialogflowCxV3EventHandler(
      o[1] as api.GoogleCloudDialogflowCxV3EventHandler);
}

core.List<core.String> buildUnnamed4584() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4584(core.List<core.String> o) {
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

core.List<api.GoogleCloudDialogflowCxV3TransitionRoute> buildUnnamed4585() {
  var o = <api.GoogleCloudDialogflowCxV3TransitionRoute>[];
  o.add(buildGoogleCloudDialogflowCxV3TransitionRoute());
  o.add(buildGoogleCloudDialogflowCxV3TransitionRoute());
  return o;
}

void checkUnnamed4585(
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
    o.eventHandlers = buildUnnamed4583();
    o.form = buildGoogleCloudDialogflowCxV3Form();
    o.name = 'foo';
    o.transitionRouteGroups = buildUnnamed4584();
    o.transitionRoutes = buildUnnamed4585();
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
    checkUnnamed4583(o.eventHandlers!);
    checkGoogleCloudDialogflowCxV3Form(
        o.form! as api.GoogleCloudDialogflowCxV3Form);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed4584(o.transitionRouteGroups!);
    checkUnnamed4585(o.transitionRoutes!);
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
    buildUnnamed4586() {
  var o = <api.GoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo>[];
  o.add(buildGoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo());
  o.add(buildGoogleCloudDialogflowCxV3PageInfoFormInfoParameterInfo());
  return o;
}

void checkUnnamed4586(
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
    o.parameterInfo = buildUnnamed4586();
  }
  buildCounterGoogleCloudDialogflowCxV3PageInfoFormInfo--;
  return o;
}

void checkGoogleCloudDialogflowCxV3PageInfoFormInfo(
    api.GoogleCloudDialogflowCxV3PageInfoFormInfo o) {
  buildCounterGoogleCloudDialogflowCxV3PageInfoFormInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3PageInfoFormInfo < 3) {
    checkUnnamed4586(o.parameterInfo!);
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
    var casted9 = (o.value!) as core.Map;
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

core.Map<core.String, core.Object> buildUnnamed4587() {
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

void checkUnnamed4587(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted10 = (o['x']!) as core.Map;
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
  var casted11 = (o['y']!) as core.Map;
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
    o.payload = buildUnnamed4587();
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
    checkUnnamed4587(o.payload!);
    checkGoogleCloudDialogflowCxV3ResponseMessagePlayAudio(
        o.playAudio! as api.GoogleCloudDialogflowCxV3ResponseMessagePlayAudio);
    checkGoogleCloudDialogflowCxV3ResponseMessageText(
        o.text! as api.GoogleCloudDialogflowCxV3ResponseMessageText);
  }
  buildCounterGoogleCloudDialogflowCxV3ResponseMessage--;
}

core.Map<core.String, core.Object> buildUnnamed4588() {
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

void checkUnnamed4588(core.Map<core.String, core.Object> o) {
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

core.int
    buildCounterGoogleCloudDialogflowCxV3ResponseMessageConversationSuccess = 0;
api.GoogleCloudDialogflowCxV3ResponseMessageConversationSuccess
    buildGoogleCloudDialogflowCxV3ResponseMessageConversationSuccess() {
  var o = api.GoogleCloudDialogflowCxV3ResponseMessageConversationSuccess();
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageConversationSuccess++;
  if (buildCounterGoogleCloudDialogflowCxV3ResponseMessageConversationSuccess <
      3) {
    o.metadata = buildUnnamed4588();
  }
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageConversationSuccess--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ResponseMessageConversationSuccess(
    api.GoogleCloudDialogflowCxV3ResponseMessageConversationSuccess o) {
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageConversationSuccess++;
  if (buildCounterGoogleCloudDialogflowCxV3ResponseMessageConversationSuccess <
      3) {
    checkUnnamed4588(o.metadata!);
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

core.Map<core.String, core.Object> buildUnnamed4589() {
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

void checkUnnamed4589(core.Map<core.String, core.Object> o) {
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

core.int buildCounterGoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff =
    0;
api.GoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff
    buildGoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff() {
  var o = api.GoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff();
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff++;
  if (buildCounterGoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff <
      3) {
    o.metadata = buildUnnamed4589();
  }
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff(
    api.GoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff o) {
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff++;
  if (buildCounterGoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff <
      3) {
    checkUnnamed4589(o.metadata!);
  }
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageLiveAgentHandoff--;
}

core.List<api.GoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment>
    buildUnnamed4590() {
  var o = <api.GoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment>[];
  o.add(buildGoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment());
  o.add(buildGoogleCloudDialogflowCxV3ResponseMessageMixedAudioSegment());
  return o;
}

void checkUnnamed4590(
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
    o.segments = buildUnnamed4590();
  }
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageMixedAudio--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ResponseMessageMixedAudio(
    api.GoogleCloudDialogflowCxV3ResponseMessageMixedAudio o) {
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageMixedAudio++;
  if (buildCounterGoogleCloudDialogflowCxV3ResponseMessageMixedAudio < 3) {
    checkUnnamed4590(o.segments!);
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

core.List<core.String> buildUnnamed4591() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4591(core.List<core.String> o) {
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
    o.text = buildUnnamed4591();
  }
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageText--;
  return o;
}

void checkGoogleCloudDialogflowCxV3ResponseMessageText(
    api.GoogleCloudDialogflowCxV3ResponseMessageText o) {
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageText++;
  if (buildCounterGoogleCloudDialogflowCxV3ResponseMessageText < 3) {
    unittest.expect(o.allowPlaybackInterruption!, unittest.isTrue);
    checkUnnamed4591(o.text!);
  }
  buildCounterGoogleCloudDialogflowCxV3ResponseMessageText--;
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

core.Map<core.String, core.Object> buildUnnamed4592() {
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

void checkUnnamed4592(core.Map<core.String, core.Object> o) {
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

core.int buildCounterGoogleCloudDialogflowCxV3SessionInfo = 0;
api.GoogleCloudDialogflowCxV3SessionInfo
    buildGoogleCloudDialogflowCxV3SessionInfo() {
  var o = api.GoogleCloudDialogflowCxV3SessionInfo();
  buildCounterGoogleCloudDialogflowCxV3SessionInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3SessionInfo < 3) {
    o.parameters = buildUnnamed4592();
    o.session = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3SessionInfo--;
  return o;
}

void checkGoogleCloudDialogflowCxV3SessionInfo(
    api.GoogleCloudDialogflowCxV3SessionInfo o) {
  buildCounterGoogleCloudDialogflowCxV3SessionInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3SessionInfo < 3) {
    checkUnnamed4592(o.parameters!);
    unittest.expect(
      o.session!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3SessionInfo--;
}

core.List<core.String> buildUnnamed4593() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4593(core.List<core.String> o) {
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

core.List<api.GoogleCloudDialogflowCxV3ConversationTurn> buildUnnamed4594() {
  var o = <api.GoogleCloudDialogflowCxV3ConversationTurn>[];
  o.add(buildGoogleCloudDialogflowCxV3ConversationTurn());
  o.add(buildGoogleCloudDialogflowCxV3ConversationTurn());
  return o;
}

void checkUnnamed4594(
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
    o.tags = buildUnnamed4593();
    o.testCaseConversationTurns = buildUnnamed4594();
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
    checkUnnamed4593(o.tags!);
    checkUnnamed4594(o.testCaseConversationTurns!);
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

core.List<api.GoogleCloudDialogflowCxV3ConversationTurn> buildUnnamed4595() {
  var o = <api.GoogleCloudDialogflowCxV3ConversationTurn>[];
  o.add(buildGoogleCloudDialogflowCxV3ConversationTurn());
  o.add(buildGoogleCloudDialogflowCxV3ConversationTurn());
  return o;
}

void checkUnnamed4595(
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
    o.conversationTurns = buildUnnamed4595();
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
    checkUnnamed4595(o.conversationTurns!);
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

core.List<core.String> buildUnnamed4596() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4596(core.List<core.String> o) {
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
    o.trackingParameters = buildUnnamed4596();
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
    checkUnnamed4596(o.trackingParameters!);
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

core.List<api.GoogleCloudDialogflowCxV3ResponseMessage> buildUnnamed4597() {
  var o = <api.GoogleCloudDialogflowCxV3ResponseMessage>[];
  o.add(buildGoogleCloudDialogflowCxV3ResponseMessage());
  o.add(buildGoogleCloudDialogflowCxV3ResponseMessage());
  return o;
}

void checkUnnamed4597(
    core.List<api.GoogleCloudDialogflowCxV3ResponseMessage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3ResponseMessage(
      o[0] as api.GoogleCloudDialogflowCxV3ResponseMessage);
  checkGoogleCloudDialogflowCxV3ResponseMessage(
      o[1] as api.GoogleCloudDialogflowCxV3ResponseMessage);
}

core.Map<core.String, core.Object> buildUnnamed4598() {
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

void checkUnnamed4598(core.Map<core.String, core.Object> o) {
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
    o.messages = buildUnnamed4597();
    o.pageInfo = buildGoogleCloudDialogflowCxV3PageInfo();
    o.payload = buildUnnamed4598();
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
    checkUnnamed4597(o.messages!);
    checkGoogleCloudDialogflowCxV3PageInfo(
        o.pageInfo! as api.GoogleCloudDialogflowCxV3PageInfo);
    checkUnnamed4598(o.payload!);
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
    buildUnnamed4599() {
  var o = <core.String,
      api.GoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue>{};
  o['x'] =
      buildGoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue();
  o['y'] =
      buildGoogleCloudDialogflowCxV3WebhookRequestIntentInfoIntentParameterValue();
  return o;
}

void checkUnnamed4599(
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
    o.parameters = buildUnnamed4599();
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
    checkUnnamed4599(o.parameters!);
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
    var casted20 = (o.resolvedValue!) as core.Map;
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

core.Map<core.String, core.Object> buildUnnamed4600() {
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

void checkUnnamed4600(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted21 = (o['x']!) as core.Map;
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
  var casted22 = (o['y']!) as core.Map;
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
    o.payload = buildUnnamed4600();
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
    checkUnnamed4600(o.payload!);
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

core.List<api.GoogleCloudDialogflowCxV3ResponseMessage> buildUnnamed4601() {
  var o = <api.GoogleCloudDialogflowCxV3ResponseMessage>[];
  o.add(buildGoogleCloudDialogflowCxV3ResponseMessage());
  o.add(buildGoogleCloudDialogflowCxV3ResponseMessage());
  return o;
}

void checkUnnamed4601(
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
    o.messages = buildUnnamed4601();
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
    checkUnnamed4601(o.messages!);
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

core.List<api.GoogleCloudDialogflowCxV3beta1TestError> buildUnnamed4602() {
  var o = <api.GoogleCloudDialogflowCxV3beta1TestError>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1TestError());
  o.add(buildGoogleCloudDialogflowCxV3beta1TestError());
  return o;
}

void checkUnnamed4602(
    core.List<api.GoogleCloudDialogflowCxV3beta1TestError> o) {
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
    o.errors = buildUnnamed4602();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1BatchRunTestCasesMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1BatchRunTestCasesMetadata(
    api.GoogleCloudDialogflowCxV3beta1BatchRunTestCasesMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3beta1BatchRunTestCasesMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1BatchRunTestCasesMetadata < 3) {
    checkUnnamed4602(o.errors!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1BatchRunTestCasesMetadata--;
}

core.List<api.GoogleCloudDialogflowCxV3beta1TestCaseResult> buildUnnamed4603() {
  var o = <api.GoogleCloudDialogflowCxV3beta1TestCaseResult>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1TestCaseResult());
  o.add(buildGoogleCloudDialogflowCxV3beta1TestCaseResult());
  return o;
}

void checkUnnamed4603(
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
    o.results = buildUnnamed4603();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1BatchRunTestCasesResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1BatchRunTestCasesResponse(
    api.GoogleCloudDialogflowCxV3beta1BatchRunTestCasesResponse o) {
  buildCounterGoogleCloudDialogflowCxV3beta1BatchRunTestCasesResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1BatchRunTestCasesResponse < 3) {
    checkUnnamed4603(o.results!);
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

core.Map<core.String, core.Object> buildUnnamed4604() {
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

void checkUnnamed4604(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted23 = (o['x']!) as core.Map;
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
  var casted24 = (o['y']!) as core.Map;
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
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1ConversationTurnUserInput =
    0;
api.GoogleCloudDialogflowCxV3beta1ConversationTurnUserInput
    buildGoogleCloudDialogflowCxV3beta1ConversationTurnUserInput() {
  var o = api.GoogleCloudDialogflowCxV3beta1ConversationTurnUserInput();
  buildCounterGoogleCloudDialogflowCxV3beta1ConversationTurnUserInput++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ConversationTurnUserInput < 3) {
    o.injectedParameters = buildUnnamed4604();
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
    checkUnnamed4604(o.injectedParameters!);
    checkGoogleCloudDialogflowCxV3beta1QueryInput(
        o.input! as api.GoogleCloudDialogflowCxV3beta1QueryInput);
    unittest.expect(o.isWebhookEnabled!, unittest.isTrue);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ConversationTurnUserInput--;
}

core.Map<core.String, core.Object> buildUnnamed4605() {
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

void checkUnnamed4605(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted25 = (o['x']!) as core.Map;
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
  var casted26 = (o['y']!) as core.Map;
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
}

core.List<api.GoogleCloudDialogflowCxV3beta1TestRunDifference>
    buildUnnamed4606() {
  var o = <api.GoogleCloudDialogflowCxV3beta1TestRunDifference>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1TestRunDifference());
  o.add(buildGoogleCloudDialogflowCxV3beta1TestRunDifference());
  return o;
}

void checkUnnamed4606(
    core.List<api.GoogleCloudDialogflowCxV3beta1TestRunDifference> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1TestRunDifference(
      o[0] as api.GoogleCloudDialogflowCxV3beta1TestRunDifference);
  checkGoogleCloudDialogflowCxV3beta1TestRunDifference(
      o[1] as api.GoogleCloudDialogflowCxV3beta1TestRunDifference);
}

core.Map<core.String, core.Object> buildUnnamed4607() {
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

void checkUnnamed4607(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted27 = (o['x']!) as core.Map;
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
  var casted28 = (o['y']!) as core.Map;
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
}

core.List<api.GoogleCloudDialogflowCxV3beta1ResponseMessageText>
    buildUnnamed4608() {
  var o = <api.GoogleCloudDialogflowCxV3beta1ResponseMessageText>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1ResponseMessageText());
  o.add(buildGoogleCloudDialogflowCxV3beta1ResponseMessageText());
  return o;
}

void checkUnnamed4608(
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
    o.diagnosticInfo = buildUnnamed4605();
    o.differences = buildUnnamed4606();
    o.sessionParameters = buildUnnamed4607();
    o.status = buildGoogleRpcStatus();
    o.textResponses = buildUnnamed4608();
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
    checkUnnamed4605(o.diagnosticInfo!);
    checkUnnamed4606(o.differences!);
    checkUnnamed4607(o.sessionParameters!);
    checkGoogleRpcStatus(o.status! as api.GoogleRpcStatus);
    checkUnnamed4608(o.textResponses!);
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

core.List<api.GoogleCloudDialogflowCxV3beta1FormParameter> buildUnnamed4609() {
  var o = <api.GoogleCloudDialogflowCxV3beta1FormParameter>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1FormParameter());
  o.add(buildGoogleCloudDialogflowCxV3beta1FormParameter());
  return o;
}

void checkUnnamed4609(
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
    o.parameters = buildUnnamed4609();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1Form--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1Form(
    api.GoogleCloudDialogflowCxV3beta1Form o) {
  buildCounterGoogleCloudDialogflowCxV3beta1Form++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1Form < 3) {
    checkUnnamed4609(o.parameters!);
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
    var casted29 = (o.defaultValue!) as core.Map;
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

core.List<api.GoogleCloudDialogflowCxV3beta1EventHandler> buildUnnamed4610() {
  var o = <api.GoogleCloudDialogflowCxV3beta1EventHandler>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1EventHandler());
  o.add(buildGoogleCloudDialogflowCxV3beta1EventHandler());
  return o;
}

void checkUnnamed4610(
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
    o.repromptEventHandlers = buildUnnamed4610();
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
    checkUnnamed4610(o.repromptEventHandlers!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1FormParameterFillBehavior--;
}

core.List<api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases>
    buildUnnamed4611() {
  var o = <api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases());
  o.add(buildGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases());
  return o;
}

void checkUnnamed4611(
    core.List<api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases(
      o[0] as api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases);
  checkGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases(
      o[1] as api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases);
}

core.List<api.GoogleCloudDialogflowCxV3beta1ResponseMessage>
    buildUnnamed4612() {
  var o = <api.GoogleCloudDialogflowCxV3beta1ResponseMessage>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1ResponseMessage());
  o.add(buildGoogleCloudDialogflowCxV3beta1ResponseMessage());
  return o;
}

void checkUnnamed4612(
    core.List<api.GoogleCloudDialogflowCxV3beta1ResponseMessage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1ResponseMessage(
      o[0] as api.GoogleCloudDialogflowCxV3beta1ResponseMessage);
  checkGoogleCloudDialogflowCxV3beta1ResponseMessage(
      o[1] as api.GoogleCloudDialogflowCxV3beta1ResponseMessage);
}

core.List<api.GoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction>
    buildUnnamed4613() {
  var o = <api.GoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction());
  o.add(buildGoogleCloudDialogflowCxV3beta1FulfillmentSetParameterAction());
  return o;
}

void checkUnnamed4613(
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
    o.conditionalCases = buildUnnamed4611();
    o.messages = buildUnnamed4612();
    o.setParameterActions = buildUnnamed4613();
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
    checkUnnamed4611(o.conditionalCases!);
    checkUnnamed4612(o.messages!);
    checkUnnamed4613(o.setParameterActions!);
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
    buildUnnamed4614() {
  var o = <api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase());
  o.add(buildGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCase());
  return o;
}

void checkUnnamed4614(
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
    o.cases = buildUnnamed4614();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases(
    api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases o) {
  buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases <
      3) {
    checkUnnamed4614(o.cases!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCases--;
}

core.List<
        api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent>
    buildUnnamed4615() {
  var o = <
      api.GoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent>[];
  o.add(
      buildGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent());
  o.add(
      buildGoogleCloudDialogflowCxV3beta1FulfillmentConditionalCasesCaseCaseContent());
  return o;
}

void checkUnnamed4615(
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
    o.caseContent = buildUnnamed4615();
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
    checkUnnamed4615(o.caseContent!);
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
    var casted30 = (o.value!) as core.Map;
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

core.List<api.GoogleRpcStatus> buildUnnamed4616() {
  var o = <api.GoogleRpcStatus>[];
  o.add(buildGoogleRpcStatus());
  o.add(buildGoogleRpcStatus());
  return o;
}

void checkUnnamed4616(core.List<api.GoogleRpcStatus> o) {
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
    o.warnings = buildUnnamed4616();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ImportDocumentsResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ImportDocumentsResponse(
    api.GoogleCloudDialogflowCxV3beta1ImportDocumentsResponse o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ImportDocumentsResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ImportDocumentsResponse < 3) {
    checkUnnamed4616(o.warnings!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ImportDocumentsResponse--;
}

core.List<api.GoogleCloudDialogflowCxV3beta1TestCaseError> buildUnnamed4617() {
  var o = <api.GoogleCloudDialogflowCxV3beta1TestCaseError>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1TestCaseError());
  o.add(buildGoogleCloudDialogflowCxV3beta1TestCaseError());
  return o;
}

void checkUnnamed4617(
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
    o.errors = buildUnnamed4617();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ImportTestCasesMetadata--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ImportTestCasesMetadata(
    api.GoogleCloudDialogflowCxV3beta1ImportTestCasesMetadata o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ImportTestCasesMetadata++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ImportTestCasesMetadata < 3) {
    checkUnnamed4617(o.errors!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ImportTestCasesMetadata--;
}

core.List<core.String> buildUnnamed4618() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4618(core.List<core.String> o) {
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
    o.names = buildUnnamed4618();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ImportTestCasesResponse--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ImportTestCasesResponse(
    api.GoogleCloudDialogflowCxV3beta1ImportTestCasesResponse o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ImportTestCasesResponse++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ImportTestCasesResponse < 3) {
    checkUnnamed4618(o.names!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ImportTestCasesResponse--;
}

core.List<core.String> buildUnnamed4619() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4619(core.List<core.String> o) {
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
    o.phraseHints = buildUnnamed4619();
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
    checkUnnamed4619(o.phraseHints!);
    unittest.expect(
      o.sampleRateHertz!,
      unittest.equals(42),
    );
    unittest.expect(o.singleUtterance!, unittest.isTrue);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1InputAudioConfig--;
}

core.Map<core.String, core.String> buildUnnamed4620() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed4620(core.Map<core.String, core.String> o) {
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

core.List<api.GoogleCloudDialogflowCxV3beta1IntentParameter>
    buildUnnamed4621() {
  var o = <api.GoogleCloudDialogflowCxV3beta1IntentParameter>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1IntentParameter());
  o.add(buildGoogleCloudDialogflowCxV3beta1IntentParameter());
  return o;
}

void checkUnnamed4621(
    core.List<api.GoogleCloudDialogflowCxV3beta1IntentParameter> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1IntentParameter(
      o[0] as api.GoogleCloudDialogflowCxV3beta1IntentParameter);
  checkGoogleCloudDialogflowCxV3beta1IntentParameter(
      o[1] as api.GoogleCloudDialogflowCxV3beta1IntentParameter);
}

core.List<api.GoogleCloudDialogflowCxV3beta1IntentTrainingPhrase>
    buildUnnamed4622() {
  var o = <api.GoogleCloudDialogflowCxV3beta1IntentTrainingPhrase>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1IntentTrainingPhrase());
  o.add(buildGoogleCloudDialogflowCxV3beta1IntentTrainingPhrase());
  return o;
}

void checkUnnamed4622(
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
    o.labels = buildUnnamed4620();
    o.name = 'foo';
    o.parameters = buildUnnamed4621();
    o.priority = 42;
    o.trainingPhrases = buildUnnamed4622();
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
    checkUnnamed4620(o.labels!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed4621(o.parameters!);
    unittest.expect(
      o.priority!,
      unittest.equals(42),
    );
    checkUnnamed4622(o.trainingPhrases!);
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
    buildUnnamed4623() {
  var o = <api.GoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart());
  o.add(buildGoogleCloudDialogflowCxV3beta1IntentTrainingPhrasePart());
  return o;
}

void checkUnnamed4623(
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
    o.parts = buildUnnamed4623();
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
    checkUnnamed4623(o.parts!);
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

core.List<api.GoogleCloudDialogflowCxV3beta1EventHandler> buildUnnamed4624() {
  var o = <api.GoogleCloudDialogflowCxV3beta1EventHandler>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1EventHandler());
  o.add(buildGoogleCloudDialogflowCxV3beta1EventHandler());
  return o;
}

void checkUnnamed4624(
    core.List<api.GoogleCloudDialogflowCxV3beta1EventHandler> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1EventHandler(
      o[0] as api.GoogleCloudDialogflowCxV3beta1EventHandler);
  checkGoogleCloudDialogflowCxV3beta1EventHandler(
      o[1] as api.GoogleCloudDialogflowCxV3beta1EventHandler);
}

core.List<core.String> buildUnnamed4625() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4625(core.List<core.String> o) {
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

core.List<api.GoogleCloudDialogflowCxV3beta1TransitionRoute>
    buildUnnamed4626() {
  var o = <api.GoogleCloudDialogflowCxV3beta1TransitionRoute>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1TransitionRoute());
  o.add(buildGoogleCloudDialogflowCxV3beta1TransitionRoute());
  return o;
}

void checkUnnamed4626(
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
    o.eventHandlers = buildUnnamed4624();
    o.form = buildGoogleCloudDialogflowCxV3beta1Form();
    o.name = 'foo';
    o.transitionRouteGroups = buildUnnamed4625();
    o.transitionRoutes = buildUnnamed4626();
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
    checkUnnamed4624(o.eventHandlers!);
    checkGoogleCloudDialogflowCxV3beta1Form(
        o.form! as api.GoogleCloudDialogflowCxV3beta1Form);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed4625(o.transitionRouteGroups!);
    checkUnnamed4626(o.transitionRoutes!);
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
    buildUnnamed4627() {
  var o = <api.GoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo());
  o.add(buildGoogleCloudDialogflowCxV3beta1PageInfoFormInfoParameterInfo());
  return o;
}

void checkUnnamed4627(
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
    o.parameterInfo = buildUnnamed4627();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1PageInfoFormInfo--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1PageInfoFormInfo(
    api.GoogleCloudDialogflowCxV3beta1PageInfoFormInfo o) {
  buildCounterGoogleCloudDialogflowCxV3beta1PageInfoFormInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1PageInfoFormInfo < 3) {
    checkUnnamed4627(o.parameterInfo!);
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
    var casted31 = (o.value!) as core.Map;
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

core.Map<core.String, core.Object> buildUnnamed4628() {
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

void checkUnnamed4628(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted32 = (o['x']!) as core.Map;
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
  var casted33 = (o['y']!) as core.Map;
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
    o.payload = buildUnnamed4628();
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
    checkUnnamed4628(o.payload!);
    checkGoogleCloudDialogflowCxV3beta1ResponseMessagePlayAudio(o.playAudio!
        as api.GoogleCloudDialogflowCxV3beta1ResponseMessagePlayAudio);
    checkGoogleCloudDialogflowCxV3beta1ResponseMessageText(
        o.text! as api.GoogleCloudDialogflowCxV3beta1ResponseMessageText);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessage--;
}

core.Map<core.String, core.Object> buildUnnamed4629() {
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

void checkUnnamed4629(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted34 = (o['x']!) as core.Map;
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
  var casted35 = (o['y']!) as core.Map;
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
    o.metadata = buildUnnamed4629();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageConversationSuccess--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ResponseMessageConversationSuccess(
    api.GoogleCloudDialogflowCxV3beta1ResponseMessageConversationSuccess o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageConversationSuccess++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageConversationSuccess <
      3) {
    checkUnnamed4629(o.metadata!);
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

core.Map<core.String, core.Object> buildUnnamed4630() {
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

void checkUnnamed4630(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted36 = (o['x']!) as core.Map;
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
  var casted37 = (o['y']!) as core.Map;
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
    o.metadata = buildUnnamed4630();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff(
    api.GoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff <
      3) {
    checkUnnamed4630(o.metadata!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageLiveAgentHandoff--;
}

core.List<api.GoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment>
    buildUnnamed4631() {
  var o =
      <api.GoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment());
  o.add(buildGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudioSegment());
  return o;
}

void checkUnnamed4631(
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
    o.segments = buildUnnamed4631();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudio--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudio(
    api.GoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudio o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudio++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageMixedAudio < 3) {
    checkUnnamed4631(o.segments!);
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

core.List<core.String> buildUnnamed4632() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4632(core.List<core.String> o) {
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
    o.text = buildUnnamed4632();
  }
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageText--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1ResponseMessageText(
    api.GoogleCloudDialogflowCxV3beta1ResponseMessageText o) {
  buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageText++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1ResponseMessageText < 3) {
    unittest.expect(o.allowPlaybackInterruption!, unittest.isTrue);
    checkUnnamed4632(o.text!);
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

core.Map<core.String, core.Object> buildUnnamed4633() {
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

void checkUnnamed4633(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted38 = (o['x']!) as core.Map;
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
  var casted39 = (o['y']!) as core.Map;
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
}

core.int buildCounterGoogleCloudDialogflowCxV3beta1SessionInfo = 0;
api.GoogleCloudDialogflowCxV3beta1SessionInfo
    buildGoogleCloudDialogflowCxV3beta1SessionInfo() {
  var o = api.GoogleCloudDialogflowCxV3beta1SessionInfo();
  buildCounterGoogleCloudDialogflowCxV3beta1SessionInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1SessionInfo < 3) {
    o.parameters = buildUnnamed4633();
    o.session = 'foo';
  }
  buildCounterGoogleCloudDialogflowCxV3beta1SessionInfo--;
  return o;
}

void checkGoogleCloudDialogflowCxV3beta1SessionInfo(
    api.GoogleCloudDialogflowCxV3beta1SessionInfo o) {
  buildCounterGoogleCloudDialogflowCxV3beta1SessionInfo++;
  if (buildCounterGoogleCloudDialogflowCxV3beta1SessionInfo < 3) {
    checkUnnamed4633(o.parameters!);
    unittest.expect(
      o.session!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowCxV3beta1SessionInfo--;
}

core.List<core.String> buildUnnamed4634() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4634(core.List<core.String> o) {
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
    buildUnnamed4635() {
  var o = <api.GoogleCloudDialogflowCxV3beta1ConversationTurn>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1ConversationTurn());
  o.add(buildGoogleCloudDialogflowCxV3beta1ConversationTurn());
  return o;
}

void checkUnnamed4635(
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
    o.tags = buildUnnamed4634();
    o.testCaseConversationTurns = buildUnnamed4635();
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
    checkUnnamed4634(o.tags!);
    checkUnnamed4635(o.testCaseConversationTurns!);
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
    buildUnnamed4636() {
  var o = <api.GoogleCloudDialogflowCxV3beta1ConversationTurn>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1ConversationTurn());
  o.add(buildGoogleCloudDialogflowCxV3beta1ConversationTurn());
  return o;
}

void checkUnnamed4636(
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
    o.conversationTurns = buildUnnamed4636();
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
    checkUnnamed4636(o.conversationTurns!);
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

core.List<core.String> buildUnnamed4637() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4637(core.List<core.String> o) {
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
    o.trackingParameters = buildUnnamed4637();
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
    checkUnnamed4637(o.trackingParameters!);
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

core.List<api.GoogleCloudDialogflowCxV3beta1ResponseMessage>
    buildUnnamed4638() {
  var o = <api.GoogleCloudDialogflowCxV3beta1ResponseMessage>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1ResponseMessage());
  o.add(buildGoogleCloudDialogflowCxV3beta1ResponseMessage());
  return o;
}

void checkUnnamed4638(
    core.List<api.GoogleCloudDialogflowCxV3beta1ResponseMessage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowCxV3beta1ResponseMessage(
      o[0] as api.GoogleCloudDialogflowCxV3beta1ResponseMessage);
  checkGoogleCloudDialogflowCxV3beta1ResponseMessage(
      o[1] as api.GoogleCloudDialogflowCxV3beta1ResponseMessage);
}

core.Map<core.String, core.Object> buildUnnamed4639() {
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

void checkUnnamed4639(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted40 = (o['x']!) as core.Map;
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
  var casted41 = (o['y']!) as core.Map;
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
    o.messages = buildUnnamed4638();
    o.pageInfo = buildGoogleCloudDialogflowCxV3beta1PageInfo();
    o.payload = buildUnnamed4639();
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
    checkUnnamed4638(o.messages!);
    checkGoogleCloudDialogflowCxV3beta1PageInfo(
        o.pageInfo! as api.GoogleCloudDialogflowCxV3beta1PageInfo);
    checkUnnamed4639(o.payload!);
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
    buildUnnamed4640() {
  var o = <core.String,
      api.GoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue>{};
  o['x'] =
      buildGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue();
  o['y'] =
      buildGoogleCloudDialogflowCxV3beta1WebhookRequestIntentInfoIntentParameterValue();
  return o;
}

void checkUnnamed4640(
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
    o.parameters = buildUnnamed4640();
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
    checkUnnamed4640(o.parameters!);
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
    var casted42 = (o.resolvedValue!) as core.Map;
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

core.Map<core.String, core.Object> buildUnnamed4641() {
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

void checkUnnamed4641(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted43 = (o['x']!) as core.Map;
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
  var casted44 = (o['y']!) as core.Map;
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
    o.payload = buildUnnamed4641();
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
    checkUnnamed4641(o.payload!);
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

core.List<api.GoogleCloudDialogflowCxV3beta1ResponseMessage>
    buildUnnamed4642() {
  var o = <api.GoogleCloudDialogflowCxV3beta1ResponseMessage>[];
  o.add(buildGoogleCloudDialogflowCxV3beta1ResponseMessage());
  o.add(buildGoogleCloudDialogflowCxV3beta1ResponseMessage());
  return o;
}

void checkUnnamed4642(
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
    o.messages = buildUnnamed4642();
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
    checkUnnamed4642(o.messages!);
  }
  buildCounterGoogleCloudDialogflowCxV3beta1WebhookResponseFulfillmentResponse--;
}

core.List<core.String> buildUnnamed4643() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4643(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowV2Agent = 0;
api.GoogleCloudDialogflowV2Agent buildGoogleCloudDialogflowV2Agent() {
  var o = api.GoogleCloudDialogflowV2Agent();
  buildCounterGoogleCloudDialogflowV2Agent++;
  if (buildCounterGoogleCloudDialogflowV2Agent < 3) {
    o.apiVersion = 'foo';
    o.avatarUri = 'foo';
    o.classificationThreshold = 42.0;
    o.defaultLanguageCode = 'foo';
    o.description = 'foo';
    o.displayName = 'foo';
    o.enableLogging = true;
    o.matchMode = 'foo';
    o.parent = 'foo';
    o.supportedLanguageCodes = buildUnnamed4643();
    o.tier = 'foo';
    o.timeZone = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2Agent--;
  return o;
}

void checkGoogleCloudDialogflowV2Agent(api.GoogleCloudDialogflowV2Agent o) {
  buildCounterGoogleCloudDialogflowV2Agent++;
  if (buildCounterGoogleCloudDialogflowV2Agent < 3) {
    unittest.expect(
      o.apiVersion!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.avatarUri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.classificationThreshold!,
      unittest.equals(42.0),
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
    unittest.expect(o.enableLogging!, unittest.isTrue);
    unittest.expect(
      o.matchMode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.parent!,
      unittest.equals('foo'),
    );
    checkUnnamed4643(o.supportedLanguageCodes!);
    unittest.expect(
      o.tier!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.timeZone!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2Agent--;
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
    var casted45 = (o.formattedValue!) as core.Map;
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
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2AnnotatedMessagePart--;
}

core.List<api.GoogleCloudDialogflowV2EntityTypeEntity> buildUnnamed4644() {
  var o = <api.GoogleCloudDialogflowV2EntityTypeEntity>[];
  o.add(buildGoogleCloudDialogflowV2EntityTypeEntity());
  o.add(buildGoogleCloudDialogflowV2EntityTypeEntity());
  return o;
}

void checkUnnamed4644(
    core.List<api.GoogleCloudDialogflowV2EntityTypeEntity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2EntityTypeEntity(
      o[0] as api.GoogleCloudDialogflowV2EntityTypeEntity);
  checkGoogleCloudDialogflowV2EntityTypeEntity(
      o[1] as api.GoogleCloudDialogflowV2EntityTypeEntity);
}

core.int buildCounterGoogleCloudDialogflowV2BatchCreateEntitiesRequest = 0;
api.GoogleCloudDialogflowV2BatchCreateEntitiesRequest
    buildGoogleCloudDialogflowV2BatchCreateEntitiesRequest() {
  var o = api.GoogleCloudDialogflowV2BatchCreateEntitiesRequest();
  buildCounterGoogleCloudDialogflowV2BatchCreateEntitiesRequest++;
  if (buildCounterGoogleCloudDialogflowV2BatchCreateEntitiesRequest < 3) {
    o.entities = buildUnnamed4644();
    o.languageCode = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2BatchCreateEntitiesRequest--;
  return o;
}

void checkGoogleCloudDialogflowV2BatchCreateEntitiesRequest(
    api.GoogleCloudDialogflowV2BatchCreateEntitiesRequest o) {
  buildCounterGoogleCloudDialogflowV2BatchCreateEntitiesRequest++;
  if (buildCounterGoogleCloudDialogflowV2BatchCreateEntitiesRequest < 3) {
    checkUnnamed4644(o.entities!);
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2BatchCreateEntitiesRequest--;
}

core.List<core.String> buildUnnamed4645() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4645(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowV2BatchDeleteEntitiesRequest = 0;
api.GoogleCloudDialogflowV2BatchDeleteEntitiesRequest
    buildGoogleCloudDialogflowV2BatchDeleteEntitiesRequest() {
  var o = api.GoogleCloudDialogflowV2BatchDeleteEntitiesRequest();
  buildCounterGoogleCloudDialogflowV2BatchDeleteEntitiesRequest++;
  if (buildCounterGoogleCloudDialogflowV2BatchDeleteEntitiesRequest < 3) {
    o.entityValues = buildUnnamed4645();
    o.languageCode = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2BatchDeleteEntitiesRequest--;
  return o;
}

void checkGoogleCloudDialogflowV2BatchDeleteEntitiesRequest(
    api.GoogleCloudDialogflowV2BatchDeleteEntitiesRequest o) {
  buildCounterGoogleCloudDialogflowV2BatchDeleteEntitiesRequest++;
  if (buildCounterGoogleCloudDialogflowV2BatchDeleteEntitiesRequest < 3) {
    checkUnnamed4645(o.entityValues!);
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2BatchDeleteEntitiesRequest--;
}

core.List<core.String> buildUnnamed4646() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4646(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowV2BatchDeleteEntityTypesRequest = 0;
api.GoogleCloudDialogflowV2BatchDeleteEntityTypesRequest
    buildGoogleCloudDialogflowV2BatchDeleteEntityTypesRequest() {
  var o = api.GoogleCloudDialogflowV2BatchDeleteEntityTypesRequest();
  buildCounterGoogleCloudDialogflowV2BatchDeleteEntityTypesRequest++;
  if (buildCounterGoogleCloudDialogflowV2BatchDeleteEntityTypesRequest < 3) {
    o.entityTypeNames = buildUnnamed4646();
  }
  buildCounterGoogleCloudDialogflowV2BatchDeleteEntityTypesRequest--;
  return o;
}

void checkGoogleCloudDialogflowV2BatchDeleteEntityTypesRequest(
    api.GoogleCloudDialogflowV2BatchDeleteEntityTypesRequest o) {
  buildCounterGoogleCloudDialogflowV2BatchDeleteEntityTypesRequest++;
  if (buildCounterGoogleCloudDialogflowV2BatchDeleteEntityTypesRequest < 3) {
    checkUnnamed4646(o.entityTypeNames!);
  }
  buildCounterGoogleCloudDialogflowV2BatchDeleteEntityTypesRequest--;
}

core.List<api.GoogleCloudDialogflowV2Intent> buildUnnamed4647() {
  var o = <api.GoogleCloudDialogflowV2Intent>[];
  o.add(buildGoogleCloudDialogflowV2Intent());
  o.add(buildGoogleCloudDialogflowV2Intent());
  return o;
}

void checkUnnamed4647(core.List<api.GoogleCloudDialogflowV2Intent> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2Intent(o[0] as api.GoogleCloudDialogflowV2Intent);
  checkGoogleCloudDialogflowV2Intent(o[1] as api.GoogleCloudDialogflowV2Intent);
}

core.int buildCounterGoogleCloudDialogflowV2BatchDeleteIntentsRequest = 0;
api.GoogleCloudDialogflowV2BatchDeleteIntentsRequest
    buildGoogleCloudDialogflowV2BatchDeleteIntentsRequest() {
  var o = api.GoogleCloudDialogflowV2BatchDeleteIntentsRequest();
  buildCounterGoogleCloudDialogflowV2BatchDeleteIntentsRequest++;
  if (buildCounterGoogleCloudDialogflowV2BatchDeleteIntentsRequest < 3) {
    o.intents = buildUnnamed4647();
  }
  buildCounterGoogleCloudDialogflowV2BatchDeleteIntentsRequest--;
  return o;
}

void checkGoogleCloudDialogflowV2BatchDeleteIntentsRequest(
    api.GoogleCloudDialogflowV2BatchDeleteIntentsRequest o) {
  buildCounterGoogleCloudDialogflowV2BatchDeleteIntentsRequest++;
  if (buildCounterGoogleCloudDialogflowV2BatchDeleteIntentsRequest < 3) {
    checkUnnamed4647(o.intents!);
  }
  buildCounterGoogleCloudDialogflowV2BatchDeleteIntentsRequest--;
}

core.List<api.GoogleCloudDialogflowV2EntityTypeEntity> buildUnnamed4648() {
  var o = <api.GoogleCloudDialogflowV2EntityTypeEntity>[];
  o.add(buildGoogleCloudDialogflowV2EntityTypeEntity());
  o.add(buildGoogleCloudDialogflowV2EntityTypeEntity());
  return o;
}

void checkUnnamed4648(
    core.List<api.GoogleCloudDialogflowV2EntityTypeEntity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2EntityTypeEntity(
      o[0] as api.GoogleCloudDialogflowV2EntityTypeEntity);
  checkGoogleCloudDialogflowV2EntityTypeEntity(
      o[1] as api.GoogleCloudDialogflowV2EntityTypeEntity);
}

core.int buildCounterGoogleCloudDialogflowV2BatchUpdateEntitiesRequest = 0;
api.GoogleCloudDialogflowV2BatchUpdateEntitiesRequest
    buildGoogleCloudDialogflowV2BatchUpdateEntitiesRequest() {
  var o = api.GoogleCloudDialogflowV2BatchUpdateEntitiesRequest();
  buildCounterGoogleCloudDialogflowV2BatchUpdateEntitiesRequest++;
  if (buildCounterGoogleCloudDialogflowV2BatchUpdateEntitiesRequest < 3) {
    o.entities = buildUnnamed4648();
    o.languageCode = 'foo';
    o.updateMask = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2BatchUpdateEntitiesRequest--;
  return o;
}

void checkGoogleCloudDialogflowV2BatchUpdateEntitiesRequest(
    api.GoogleCloudDialogflowV2BatchUpdateEntitiesRequest o) {
  buildCounterGoogleCloudDialogflowV2BatchUpdateEntitiesRequest++;
  if (buildCounterGoogleCloudDialogflowV2BatchUpdateEntitiesRequest < 3) {
    checkUnnamed4648(o.entities!);
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.updateMask!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2BatchUpdateEntitiesRequest--;
}

core.int buildCounterGoogleCloudDialogflowV2BatchUpdateEntityTypesRequest = 0;
api.GoogleCloudDialogflowV2BatchUpdateEntityTypesRequest
    buildGoogleCloudDialogflowV2BatchUpdateEntityTypesRequest() {
  var o = api.GoogleCloudDialogflowV2BatchUpdateEntityTypesRequest();
  buildCounterGoogleCloudDialogflowV2BatchUpdateEntityTypesRequest++;
  if (buildCounterGoogleCloudDialogflowV2BatchUpdateEntityTypesRequest < 3) {
    o.entityTypeBatchInline = buildGoogleCloudDialogflowV2EntityTypeBatch();
    o.entityTypeBatchUri = 'foo';
    o.languageCode = 'foo';
    o.updateMask = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2BatchUpdateEntityTypesRequest--;
  return o;
}

void checkGoogleCloudDialogflowV2BatchUpdateEntityTypesRequest(
    api.GoogleCloudDialogflowV2BatchUpdateEntityTypesRequest o) {
  buildCounterGoogleCloudDialogflowV2BatchUpdateEntityTypesRequest++;
  if (buildCounterGoogleCloudDialogflowV2BatchUpdateEntityTypesRequest < 3) {
    checkGoogleCloudDialogflowV2EntityTypeBatch(
        o.entityTypeBatchInline! as api.GoogleCloudDialogflowV2EntityTypeBatch);
    unittest.expect(
      o.entityTypeBatchUri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.updateMask!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2BatchUpdateEntityTypesRequest--;
}

core.List<api.GoogleCloudDialogflowV2EntityType> buildUnnamed4649() {
  var o = <api.GoogleCloudDialogflowV2EntityType>[];
  o.add(buildGoogleCloudDialogflowV2EntityType());
  o.add(buildGoogleCloudDialogflowV2EntityType());
  return o;
}

void checkUnnamed4649(core.List<api.GoogleCloudDialogflowV2EntityType> o) {
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
    o.entityTypes = buildUnnamed4649();
  }
  buildCounterGoogleCloudDialogflowV2BatchUpdateEntityTypesResponse--;
  return o;
}

void checkGoogleCloudDialogflowV2BatchUpdateEntityTypesResponse(
    api.GoogleCloudDialogflowV2BatchUpdateEntityTypesResponse o) {
  buildCounterGoogleCloudDialogflowV2BatchUpdateEntityTypesResponse++;
  if (buildCounterGoogleCloudDialogflowV2BatchUpdateEntityTypesResponse < 3) {
    checkUnnamed4649(o.entityTypes!);
  }
  buildCounterGoogleCloudDialogflowV2BatchUpdateEntityTypesResponse--;
}

core.int buildCounterGoogleCloudDialogflowV2BatchUpdateIntentsRequest = 0;
api.GoogleCloudDialogflowV2BatchUpdateIntentsRequest
    buildGoogleCloudDialogflowV2BatchUpdateIntentsRequest() {
  var o = api.GoogleCloudDialogflowV2BatchUpdateIntentsRequest();
  buildCounterGoogleCloudDialogflowV2BatchUpdateIntentsRequest++;
  if (buildCounterGoogleCloudDialogflowV2BatchUpdateIntentsRequest < 3) {
    o.intentBatchInline = buildGoogleCloudDialogflowV2IntentBatch();
    o.intentBatchUri = 'foo';
    o.intentView = 'foo';
    o.languageCode = 'foo';
    o.updateMask = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2BatchUpdateIntentsRequest--;
  return o;
}

void checkGoogleCloudDialogflowV2BatchUpdateIntentsRequest(
    api.GoogleCloudDialogflowV2BatchUpdateIntentsRequest o) {
  buildCounterGoogleCloudDialogflowV2BatchUpdateIntentsRequest++;
  if (buildCounterGoogleCloudDialogflowV2BatchUpdateIntentsRequest < 3) {
    checkGoogleCloudDialogflowV2IntentBatch(
        o.intentBatchInline! as api.GoogleCloudDialogflowV2IntentBatch);
    unittest.expect(
      o.intentBatchUri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.intentView!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.updateMask!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2BatchUpdateIntentsRequest--;
}

core.List<api.GoogleCloudDialogflowV2Intent> buildUnnamed4650() {
  var o = <api.GoogleCloudDialogflowV2Intent>[];
  o.add(buildGoogleCloudDialogflowV2Intent());
  o.add(buildGoogleCloudDialogflowV2Intent());
  return o;
}

void checkUnnamed4650(core.List<api.GoogleCloudDialogflowV2Intent> o) {
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
    o.intents = buildUnnamed4650();
  }
  buildCounterGoogleCloudDialogflowV2BatchUpdateIntentsResponse--;
  return o;
}

void checkGoogleCloudDialogflowV2BatchUpdateIntentsResponse(
    api.GoogleCloudDialogflowV2BatchUpdateIntentsResponse o) {
  buildCounterGoogleCloudDialogflowV2BatchUpdateIntentsResponse++;
  if (buildCounterGoogleCloudDialogflowV2BatchUpdateIntentsResponse < 3) {
    checkUnnamed4650(o.intents!);
  }
  buildCounterGoogleCloudDialogflowV2BatchUpdateIntentsResponse--;
}

core.Map<core.String, core.Object> buildUnnamed4651() {
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

void checkUnnamed4651(core.Map<core.String, core.Object> o) {
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

core.int buildCounterGoogleCloudDialogflowV2Context = 0;
api.GoogleCloudDialogflowV2Context buildGoogleCloudDialogflowV2Context() {
  var o = api.GoogleCloudDialogflowV2Context();
  buildCounterGoogleCloudDialogflowV2Context++;
  if (buildCounterGoogleCloudDialogflowV2Context < 3) {
    o.lifespanCount = 42;
    o.name = 'foo';
    o.parameters = buildUnnamed4651();
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
    checkUnnamed4651(o.parameters!);
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

core.int buildCounterGoogleCloudDialogflowV2DetectIntentRequest = 0;
api.GoogleCloudDialogflowV2DetectIntentRequest
    buildGoogleCloudDialogflowV2DetectIntentRequest() {
  var o = api.GoogleCloudDialogflowV2DetectIntentRequest();
  buildCounterGoogleCloudDialogflowV2DetectIntentRequest++;
  if (buildCounterGoogleCloudDialogflowV2DetectIntentRequest < 3) {
    o.inputAudio = 'foo';
    o.outputAudioConfig = buildGoogleCloudDialogflowV2OutputAudioConfig();
    o.outputAudioConfigMask = 'foo';
    o.queryInput = buildGoogleCloudDialogflowV2QueryInput();
    o.queryParams = buildGoogleCloudDialogflowV2QueryParameters();
  }
  buildCounterGoogleCloudDialogflowV2DetectIntentRequest--;
  return o;
}

void checkGoogleCloudDialogflowV2DetectIntentRequest(
    api.GoogleCloudDialogflowV2DetectIntentRequest o) {
  buildCounterGoogleCloudDialogflowV2DetectIntentRequest++;
  if (buildCounterGoogleCloudDialogflowV2DetectIntentRequest < 3) {
    unittest.expect(
      o.inputAudio!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowV2OutputAudioConfig(
        o.outputAudioConfig! as api.GoogleCloudDialogflowV2OutputAudioConfig);
    unittest.expect(
      o.outputAudioConfigMask!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowV2QueryInput(
        o.queryInput! as api.GoogleCloudDialogflowV2QueryInput);
    checkGoogleCloudDialogflowV2QueryParameters(
        o.queryParams! as api.GoogleCloudDialogflowV2QueryParameters);
  }
  buildCounterGoogleCloudDialogflowV2DetectIntentRequest--;
}

core.int buildCounterGoogleCloudDialogflowV2DetectIntentResponse = 0;
api.GoogleCloudDialogflowV2DetectIntentResponse
    buildGoogleCloudDialogflowV2DetectIntentResponse() {
  var o = api.GoogleCloudDialogflowV2DetectIntentResponse();
  buildCounterGoogleCloudDialogflowV2DetectIntentResponse++;
  if (buildCounterGoogleCloudDialogflowV2DetectIntentResponse < 3) {
    o.outputAudio = 'foo';
    o.outputAudioConfig = buildGoogleCloudDialogflowV2OutputAudioConfig();
    o.queryResult = buildGoogleCloudDialogflowV2QueryResult();
    o.responseId = 'foo';
    o.webhookStatus = buildGoogleRpcStatus();
  }
  buildCounterGoogleCloudDialogflowV2DetectIntentResponse--;
  return o;
}

void checkGoogleCloudDialogflowV2DetectIntentResponse(
    api.GoogleCloudDialogflowV2DetectIntentResponse o) {
  buildCounterGoogleCloudDialogflowV2DetectIntentResponse++;
  if (buildCounterGoogleCloudDialogflowV2DetectIntentResponse < 3) {
    unittest.expect(
      o.outputAudio!,
      unittest.equals('foo'),
    );
    checkGoogleCloudDialogflowV2OutputAudioConfig(
        o.outputAudioConfig! as api.GoogleCloudDialogflowV2OutputAudioConfig);
    checkGoogleCloudDialogflowV2QueryResult(
        o.queryResult! as api.GoogleCloudDialogflowV2QueryResult);
    unittest.expect(
      o.responseId!,
      unittest.equals('foo'),
    );
    checkGoogleRpcStatus(o.webhookStatus! as api.GoogleRpcStatus);
  }
  buildCounterGoogleCloudDialogflowV2DetectIntentResponse--;
}

core.List<api.GoogleCloudDialogflowV2EntityTypeEntity> buildUnnamed4652() {
  var o = <api.GoogleCloudDialogflowV2EntityTypeEntity>[];
  o.add(buildGoogleCloudDialogflowV2EntityTypeEntity());
  o.add(buildGoogleCloudDialogflowV2EntityTypeEntity());
  return o;
}

void checkUnnamed4652(
    core.List<api.GoogleCloudDialogflowV2EntityTypeEntity> o) {
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
    o.entities = buildUnnamed4652();
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
    checkUnnamed4652(o.entities!);
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

core.List<api.GoogleCloudDialogflowV2EntityType> buildUnnamed4653() {
  var o = <api.GoogleCloudDialogflowV2EntityType>[];
  o.add(buildGoogleCloudDialogflowV2EntityType());
  o.add(buildGoogleCloudDialogflowV2EntityType());
  return o;
}

void checkUnnamed4653(core.List<api.GoogleCloudDialogflowV2EntityType> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2EntityType(
      o[0] as api.GoogleCloudDialogflowV2EntityType);
  checkGoogleCloudDialogflowV2EntityType(
      o[1] as api.GoogleCloudDialogflowV2EntityType);
}

core.int buildCounterGoogleCloudDialogflowV2EntityTypeBatch = 0;
api.GoogleCloudDialogflowV2EntityTypeBatch
    buildGoogleCloudDialogflowV2EntityTypeBatch() {
  var o = api.GoogleCloudDialogflowV2EntityTypeBatch();
  buildCounterGoogleCloudDialogflowV2EntityTypeBatch++;
  if (buildCounterGoogleCloudDialogflowV2EntityTypeBatch < 3) {
    o.entityTypes = buildUnnamed4653();
  }
  buildCounterGoogleCloudDialogflowV2EntityTypeBatch--;
  return o;
}

void checkGoogleCloudDialogflowV2EntityTypeBatch(
    api.GoogleCloudDialogflowV2EntityTypeBatch o) {
  buildCounterGoogleCloudDialogflowV2EntityTypeBatch++;
  if (buildCounterGoogleCloudDialogflowV2EntityTypeBatch < 3) {
    checkUnnamed4653(o.entityTypes!);
  }
  buildCounterGoogleCloudDialogflowV2EntityTypeBatch--;
}

core.List<core.String> buildUnnamed4654() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4654(core.List<core.String> o) {
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
    o.synonyms = buildUnnamed4654();
    o.value = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2EntityTypeEntity--;
  return o;
}

void checkGoogleCloudDialogflowV2EntityTypeEntity(
    api.GoogleCloudDialogflowV2EntityTypeEntity o) {
  buildCounterGoogleCloudDialogflowV2EntityTypeEntity++;
  if (buildCounterGoogleCloudDialogflowV2EntityTypeEntity < 3) {
    checkUnnamed4654(o.synonyms!);
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2EntityTypeEntity--;
}

core.int buildCounterGoogleCloudDialogflowV2Environment = 0;
api.GoogleCloudDialogflowV2Environment
    buildGoogleCloudDialogflowV2Environment() {
  var o = api.GoogleCloudDialogflowV2Environment();
  buildCounterGoogleCloudDialogflowV2Environment++;
  if (buildCounterGoogleCloudDialogflowV2Environment < 3) {
    o.agentVersion = 'foo';
    o.description = 'foo';
    o.name = 'foo';
    o.state = 'foo';
    o.updateTime = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2Environment--;
  return o;
}

void checkGoogleCloudDialogflowV2Environment(
    api.GoogleCloudDialogflowV2Environment o) {
  buildCounterGoogleCloudDialogflowV2Environment++;
  if (buildCounterGoogleCloudDialogflowV2Environment < 3) {
    unittest.expect(
      o.agentVersion!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.description!,
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
    unittest.expect(
      o.updateTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2Environment--;
}

core.Map<core.String, core.Object> buildUnnamed4655() {
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

void checkUnnamed4655(core.Map<core.String, core.Object> o) {
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

core.int buildCounterGoogleCloudDialogflowV2EventInput = 0;
api.GoogleCloudDialogflowV2EventInput buildGoogleCloudDialogflowV2EventInput() {
  var o = api.GoogleCloudDialogflowV2EventInput();
  buildCounterGoogleCloudDialogflowV2EventInput++;
  if (buildCounterGoogleCloudDialogflowV2EventInput < 3) {
    o.languageCode = 'foo';
    o.name = 'foo';
    o.parameters = buildUnnamed4655();
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
    checkUnnamed4655(o.parameters!);
  }
  buildCounterGoogleCloudDialogflowV2EventInput--;
}

core.int buildCounterGoogleCloudDialogflowV2ExportAgentRequest = 0;
api.GoogleCloudDialogflowV2ExportAgentRequest
    buildGoogleCloudDialogflowV2ExportAgentRequest() {
  var o = api.GoogleCloudDialogflowV2ExportAgentRequest();
  buildCounterGoogleCloudDialogflowV2ExportAgentRequest++;
  if (buildCounterGoogleCloudDialogflowV2ExportAgentRequest < 3) {
    o.agentUri = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2ExportAgentRequest--;
  return o;
}

void checkGoogleCloudDialogflowV2ExportAgentRequest(
    api.GoogleCloudDialogflowV2ExportAgentRequest o) {
  buildCounterGoogleCloudDialogflowV2ExportAgentRequest++;
  if (buildCounterGoogleCloudDialogflowV2ExportAgentRequest < 3) {
    unittest.expect(
      o.agentUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2ExportAgentRequest--;
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

core.List<api.GoogleCloudDialogflowV2FulfillmentFeature> buildUnnamed4656() {
  var o = <api.GoogleCloudDialogflowV2FulfillmentFeature>[];
  o.add(buildGoogleCloudDialogflowV2FulfillmentFeature());
  o.add(buildGoogleCloudDialogflowV2FulfillmentFeature());
  return o;
}

void checkUnnamed4656(
    core.List<api.GoogleCloudDialogflowV2FulfillmentFeature> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2FulfillmentFeature(
      o[0] as api.GoogleCloudDialogflowV2FulfillmentFeature);
  checkGoogleCloudDialogflowV2FulfillmentFeature(
      o[1] as api.GoogleCloudDialogflowV2FulfillmentFeature);
}

core.int buildCounterGoogleCloudDialogflowV2Fulfillment = 0;
api.GoogleCloudDialogflowV2Fulfillment
    buildGoogleCloudDialogflowV2Fulfillment() {
  var o = api.GoogleCloudDialogflowV2Fulfillment();
  buildCounterGoogleCloudDialogflowV2Fulfillment++;
  if (buildCounterGoogleCloudDialogflowV2Fulfillment < 3) {
    o.displayName = 'foo';
    o.enabled = true;
    o.features = buildUnnamed4656();
    o.genericWebService =
        buildGoogleCloudDialogflowV2FulfillmentGenericWebService();
    o.name = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2Fulfillment--;
  return o;
}

void checkGoogleCloudDialogflowV2Fulfillment(
    api.GoogleCloudDialogflowV2Fulfillment o) {
  buildCounterGoogleCloudDialogflowV2Fulfillment++;
  if (buildCounterGoogleCloudDialogflowV2Fulfillment < 3) {
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(o.enabled!, unittest.isTrue);
    checkUnnamed4656(o.features!);
    checkGoogleCloudDialogflowV2FulfillmentGenericWebService(
        o.genericWebService!
            as api.GoogleCloudDialogflowV2FulfillmentGenericWebService);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2Fulfillment--;
}

core.int buildCounterGoogleCloudDialogflowV2FulfillmentFeature = 0;
api.GoogleCloudDialogflowV2FulfillmentFeature
    buildGoogleCloudDialogflowV2FulfillmentFeature() {
  var o = api.GoogleCloudDialogflowV2FulfillmentFeature();
  buildCounterGoogleCloudDialogflowV2FulfillmentFeature++;
  if (buildCounterGoogleCloudDialogflowV2FulfillmentFeature < 3) {
    o.type = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2FulfillmentFeature--;
  return o;
}

void checkGoogleCloudDialogflowV2FulfillmentFeature(
    api.GoogleCloudDialogflowV2FulfillmentFeature o) {
  buildCounterGoogleCloudDialogflowV2FulfillmentFeature++;
  if (buildCounterGoogleCloudDialogflowV2FulfillmentFeature < 3) {
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2FulfillmentFeature--;
}

core.Map<core.String, core.String> buildUnnamed4657() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed4657(core.Map<core.String, core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowV2FulfillmentGenericWebService = 0;
api.GoogleCloudDialogflowV2FulfillmentGenericWebService
    buildGoogleCloudDialogflowV2FulfillmentGenericWebService() {
  var o = api.GoogleCloudDialogflowV2FulfillmentGenericWebService();
  buildCounterGoogleCloudDialogflowV2FulfillmentGenericWebService++;
  if (buildCounterGoogleCloudDialogflowV2FulfillmentGenericWebService < 3) {
    o.isCloudFunction = true;
    o.password = 'foo';
    o.requestHeaders = buildUnnamed4657();
    o.uri = 'foo';
    o.username = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2FulfillmentGenericWebService--;
  return o;
}

void checkGoogleCloudDialogflowV2FulfillmentGenericWebService(
    api.GoogleCloudDialogflowV2FulfillmentGenericWebService o) {
  buildCounterGoogleCloudDialogflowV2FulfillmentGenericWebService++;
  if (buildCounterGoogleCloudDialogflowV2FulfillmentGenericWebService < 3) {
    unittest.expect(o.isCloudFunction!, unittest.isTrue);
    unittest.expect(
      o.password!,
      unittest.equals('foo'),
    );
    checkUnnamed4657(o.requestHeaders!);
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.username!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2FulfillmentGenericWebService--;
}

core.int buildCounterGoogleCloudDialogflowV2ImportAgentRequest = 0;
api.GoogleCloudDialogflowV2ImportAgentRequest
    buildGoogleCloudDialogflowV2ImportAgentRequest() {
  var o = api.GoogleCloudDialogflowV2ImportAgentRequest();
  buildCounterGoogleCloudDialogflowV2ImportAgentRequest++;
  if (buildCounterGoogleCloudDialogflowV2ImportAgentRequest < 3) {
    o.agentContent = 'foo';
    o.agentUri = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2ImportAgentRequest--;
  return o;
}

void checkGoogleCloudDialogflowV2ImportAgentRequest(
    api.GoogleCloudDialogflowV2ImportAgentRequest o) {
  buildCounterGoogleCloudDialogflowV2ImportAgentRequest++;
  if (buildCounterGoogleCloudDialogflowV2ImportAgentRequest < 3) {
    unittest.expect(
      o.agentContent!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.agentUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2ImportAgentRequest--;
}

core.List<core.String> buildUnnamed4658() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4658(core.List<core.String> o) {
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

core.List<api.GoogleCloudDialogflowV2SpeechContext> buildUnnamed4659() {
  var o = <api.GoogleCloudDialogflowV2SpeechContext>[];
  o.add(buildGoogleCloudDialogflowV2SpeechContext());
  o.add(buildGoogleCloudDialogflowV2SpeechContext());
  return o;
}

void checkUnnamed4659(core.List<api.GoogleCloudDialogflowV2SpeechContext> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2SpeechContext(
      o[0] as api.GoogleCloudDialogflowV2SpeechContext);
  checkGoogleCloudDialogflowV2SpeechContext(
      o[1] as api.GoogleCloudDialogflowV2SpeechContext);
}

core.int buildCounterGoogleCloudDialogflowV2InputAudioConfig = 0;
api.GoogleCloudDialogflowV2InputAudioConfig
    buildGoogleCloudDialogflowV2InputAudioConfig() {
  var o = api.GoogleCloudDialogflowV2InputAudioConfig();
  buildCounterGoogleCloudDialogflowV2InputAudioConfig++;
  if (buildCounterGoogleCloudDialogflowV2InputAudioConfig < 3) {
    o.audioEncoding = 'foo';
    o.enableWordInfo = true;
    o.languageCode = 'foo';
    o.model = 'foo';
    o.modelVariant = 'foo';
    o.phraseHints = buildUnnamed4658();
    o.sampleRateHertz = 42;
    o.singleUtterance = true;
    o.speechContexts = buildUnnamed4659();
  }
  buildCounterGoogleCloudDialogflowV2InputAudioConfig--;
  return o;
}

void checkGoogleCloudDialogflowV2InputAudioConfig(
    api.GoogleCloudDialogflowV2InputAudioConfig o) {
  buildCounterGoogleCloudDialogflowV2InputAudioConfig++;
  if (buildCounterGoogleCloudDialogflowV2InputAudioConfig < 3) {
    unittest.expect(
      o.audioEncoding!,
      unittest.equals('foo'),
    );
    unittest.expect(o.enableWordInfo!, unittest.isTrue);
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.model!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.modelVariant!,
      unittest.equals('foo'),
    );
    checkUnnamed4658(o.phraseHints!);
    unittest.expect(
      o.sampleRateHertz!,
      unittest.equals(42),
    );
    unittest.expect(o.singleUtterance!, unittest.isTrue);
    checkUnnamed4659(o.speechContexts!);
  }
  buildCounterGoogleCloudDialogflowV2InputAudioConfig--;
}

core.List<core.String> buildUnnamed4660() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4660(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed4661() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4661(core.List<core.String> o) {
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
    buildUnnamed4662() {
  var o = <api.GoogleCloudDialogflowV2IntentFollowupIntentInfo>[];
  o.add(buildGoogleCloudDialogflowV2IntentFollowupIntentInfo());
  o.add(buildGoogleCloudDialogflowV2IntentFollowupIntentInfo());
  return o;
}

void checkUnnamed4662(
    core.List<api.GoogleCloudDialogflowV2IntentFollowupIntentInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentFollowupIntentInfo(
      o[0] as api.GoogleCloudDialogflowV2IntentFollowupIntentInfo);
  checkGoogleCloudDialogflowV2IntentFollowupIntentInfo(
      o[1] as api.GoogleCloudDialogflowV2IntentFollowupIntentInfo);
}

core.List<core.String> buildUnnamed4663() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4663(core.List<core.String> o) {
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

core.List<api.GoogleCloudDialogflowV2IntentMessage> buildUnnamed4664() {
  var o = <api.GoogleCloudDialogflowV2IntentMessage>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessage());
  o.add(buildGoogleCloudDialogflowV2IntentMessage());
  return o;
}

void checkUnnamed4664(core.List<api.GoogleCloudDialogflowV2IntentMessage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentMessage(
      o[0] as api.GoogleCloudDialogflowV2IntentMessage);
  checkGoogleCloudDialogflowV2IntentMessage(
      o[1] as api.GoogleCloudDialogflowV2IntentMessage);
}

core.List<api.GoogleCloudDialogflowV2Context> buildUnnamed4665() {
  var o = <api.GoogleCloudDialogflowV2Context>[];
  o.add(buildGoogleCloudDialogflowV2Context());
  o.add(buildGoogleCloudDialogflowV2Context());
  return o;
}

void checkUnnamed4665(core.List<api.GoogleCloudDialogflowV2Context> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2Context(
      o[0] as api.GoogleCloudDialogflowV2Context);
  checkGoogleCloudDialogflowV2Context(
      o[1] as api.GoogleCloudDialogflowV2Context);
}

core.List<api.GoogleCloudDialogflowV2IntentParameter> buildUnnamed4666() {
  var o = <api.GoogleCloudDialogflowV2IntentParameter>[];
  o.add(buildGoogleCloudDialogflowV2IntentParameter());
  o.add(buildGoogleCloudDialogflowV2IntentParameter());
  return o;
}

void checkUnnamed4666(core.List<api.GoogleCloudDialogflowV2IntentParameter> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentParameter(
      o[0] as api.GoogleCloudDialogflowV2IntentParameter);
  checkGoogleCloudDialogflowV2IntentParameter(
      o[1] as api.GoogleCloudDialogflowV2IntentParameter);
}

core.List<api.GoogleCloudDialogflowV2IntentTrainingPhrase> buildUnnamed4667() {
  var o = <api.GoogleCloudDialogflowV2IntentTrainingPhrase>[];
  o.add(buildGoogleCloudDialogflowV2IntentTrainingPhrase());
  o.add(buildGoogleCloudDialogflowV2IntentTrainingPhrase());
  return o;
}

void checkUnnamed4667(
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
    o.defaultResponsePlatforms = buildUnnamed4660();
    o.displayName = 'foo';
    o.events = buildUnnamed4661();
    o.followupIntentInfo = buildUnnamed4662();
    o.inputContextNames = buildUnnamed4663();
    o.isFallback = true;
    o.messages = buildUnnamed4664();
    o.mlDisabled = true;
    o.name = 'foo';
    o.outputContexts = buildUnnamed4665();
    o.parameters = buildUnnamed4666();
    o.parentFollowupIntentName = 'foo';
    o.priority = 42;
    o.resetContexts = true;
    o.rootFollowupIntentName = 'foo';
    o.trainingPhrases = buildUnnamed4667();
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
    checkUnnamed4660(o.defaultResponsePlatforms!);
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    checkUnnamed4661(o.events!);
    checkUnnamed4662(o.followupIntentInfo!);
    checkUnnamed4663(o.inputContextNames!);
    unittest.expect(o.isFallback!, unittest.isTrue);
    checkUnnamed4664(o.messages!);
    unittest.expect(o.mlDisabled!, unittest.isTrue);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed4665(o.outputContexts!);
    checkUnnamed4666(o.parameters!);
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
    checkUnnamed4667(o.trainingPhrases!);
    unittest.expect(
      o.webhookState!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2Intent--;
}

core.List<api.GoogleCloudDialogflowV2Intent> buildUnnamed4668() {
  var o = <api.GoogleCloudDialogflowV2Intent>[];
  o.add(buildGoogleCloudDialogflowV2Intent());
  o.add(buildGoogleCloudDialogflowV2Intent());
  return o;
}

void checkUnnamed4668(core.List<api.GoogleCloudDialogflowV2Intent> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2Intent(o[0] as api.GoogleCloudDialogflowV2Intent);
  checkGoogleCloudDialogflowV2Intent(o[1] as api.GoogleCloudDialogflowV2Intent);
}

core.int buildCounterGoogleCloudDialogflowV2IntentBatch = 0;
api.GoogleCloudDialogflowV2IntentBatch
    buildGoogleCloudDialogflowV2IntentBatch() {
  var o = api.GoogleCloudDialogflowV2IntentBatch();
  buildCounterGoogleCloudDialogflowV2IntentBatch++;
  if (buildCounterGoogleCloudDialogflowV2IntentBatch < 3) {
    o.intents = buildUnnamed4668();
  }
  buildCounterGoogleCloudDialogflowV2IntentBatch--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentBatch(
    api.GoogleCloudDialogflowV2IntentBatch o) {
  buildCounterGoogleCloudDialogflowV2IntentBatch++;
  if (buildCounterGoogleCloudDialogflowV2IntentBatch < 3) {
    checkUnnamed4668(o.intents!);
  }
  buildCounterGoogleCloudDialogflowV2IntentBatch--;
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

core.Map<core.String, core.Object> buildUnnamed4669() {
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

void checkUnnamed4669(core.Map<core.String, core.Object> o) {
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
    o.payload = buildUnnamed4669();
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
    checkUnnamed4669(o.payload!);
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
    buildUnnamed4670() {
  var o = <api.GoogleCloudDialogflowV2IntentMessageBasicCardButton>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessageBasicCardButton());
  o.add(buildGoogleCloudDialogflowV2IntentMessageBasicCardButton());
  return o;
}

void checkUnnamed4670(
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
    o.buttons = buildUnnamed4670();
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
    checkUnnamed4670(o.buttons!);
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
    buildUnnamed4671() {
  var o = <
      api.GoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem>[];
  o.add(
      buildGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem());
  o.add(
      buildGoogleCloudDialogflowV2IntentMessageBrowseCarouselCardBrowseCarouselCardItem());
  return o;
}

void checkUnnamed4671(
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
    o.items = buildUnnamed4671();
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
    checkUnnamed4671(o.items!);
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
    buildUnnamed4672() {
  var o = <api.GoogleCloudDialogflowV2IntentMessageCardButton>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessageCardButton());
  o.add(buildGoogleCloudDialogflowV2IntentMessageCardButton());
  return o;
}

void checkUnnamed4672(
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
    o.buttons = buildUnnamed4672();
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
    checkUnnamed4672(o.buttons!);
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
    buildUnnamed4673() {
  var o = <api.GoogleCloudDialogflowV2IntentMessageCarouselSelectItem>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessageCarouselSelectItem());
  o.add(buildGoogleCloudDialogflowV2IntentMessageCarouselSelectItem());
  return o;
}

void checkUnnamed4673(
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
    o.items = buildUnnamed4673();
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageCarouselSelect--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageCarouselSelect(
    api.GoogleCloudDialogflowV2IntentMessageCarouselSelect o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageCarouselSelect++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageCarouselSelect < 3) {
    checkUnnamed4673(o.items!);
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
    buildUnnamed4674() {
  var o = <api.GoogleCloudDialogflowV2IntentMessageListSelectItem>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessageListSelectItem());
  o.add(buildGoogleCloudDialogflowV2IntentMessageListSelectItem());
  return o;
}

void checkUnnamed4674(
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
    o.items = buildUnnamed4674();
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
    checkUnnamed4674(o.items!);
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
    buildUnnamed4675() {
  var o = <
      api.GoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject>[];
  o.add(
      buildGoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject());
  o.add(
      buildGoogleCloudDialogflowV2IntentMessageMediaContentResponseMediaObject());
  return o;
}

void checkUnnamed4675(
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
    o.mediaObjects = buildUnnamed4675();
    o.mediaType = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageMediaContent--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageMediaContent(
    api.GoogleCloudDialogflowV2IntentMessageMediaContent o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageMediaContent++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageMediaContent < 3) {
    checkUnnamed4675(o.mediaObjects!);
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

core.List<core.String> buildUnnamed4676() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4676(core.List<core.String> o) {
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
    o.quickReplies = buildUnnamed4676();
    o.title = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageQuickReplies--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageQuickReplies(
    api.GoogleCloudDialogflowV2IntentMessageQuickReplies o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageQuickReplies++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageQuickReplies < 3) {
    checkUnnamed4676(o.quickReplies!);
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageQuickReplies--;
}

core.List<core.String> buildUnnamed4677() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4677(core.List<core.String> o) {
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
    o.synonyms = buildUnnamed4677();
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
    checkUnnamed4677(o.synonyms!);
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
    buildUnnamed4678() {
  var o = <api.GoogleCloudDialogflowV2IntentMessageSimpleResponse>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessageSimpleResponse());
  o.add(buildGoogleCloudDialogflowV2IntentMessageSimpleResponse());
  return o;
}

void checkUnnamed4678(
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
    o.simpleResponses = buildUnnamed4678();
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageSimpleResponses--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageSimpleResponses(
    api.GoogleCloudDialogflowV2IntentMessageSimpleResponses o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageSimpleResponses++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageSimpleResponses < 3) {
    checkUnnamed4678(o.simpleResponses!);
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
    buildUnnamed4679() {
  var o = <api.GoogleCloudDialogflowV2IntentMessageSuggestion>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessageSuggestion());
  o.add(buildGoogleCloudDialogflowV2IntentMessageSuggestion());
  return o;
}

void checkUnnamed4679(
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
    o.suggestions = buildUnnamed4679();
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageSuggestions--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageSuggestions(
    api.GoogleCloudDialogflowV2IntentMessageSuggestions o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageSuggestions++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageSuggestions < 3) {
    checkUnnamed4679(o.suggestions!);
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageSuggestions--;
}

core.List<api.GoogleCloudDialogflowV2IntentMessageBasicCardButton>
    buildUnnamed4680() {
  var o = <api.GoogleCloudDialogflowV2IntentMessageBasicCardButton>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessageBasicCardButton());
  o.add(buildGoogleCloudDialogflowV2IntentMessageBasicCardButton());
  return o;
}

void checkUnnamed4680(
    core.List<api.GoogleCloudDialogflowV2IntentMessageBasicCardButton> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentMessageBasicCardButton(
      o[0] as api.GoogleCloudDialogflowV2IntentMessageBasicCardButton);
  checkGoogleCloudDialogflowV2IntentMessageBasicCardButton(
      o[1] as api.GoogleCloudDialogflowV2IntentMessageBasicCardButton);
}

core.List<api.GoogleCloudDialogflowV2IntentMessageColumnProperties>
    buildUnnamed4681() {
  var o = <api.GoogleCloudDialogflowV2IntentMessageColumnProperties>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessageColumnProperties());
  o.add(buildGoogleCloudDialogflowV2IntentMessageColumnProperties());
  return o;
}

void checkUnnamed4681(
    core.List<api.GoogleCloudDialogflowV2IntentMessageColumnProperties> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentMessageColumnProperties(
      o[0] as api.GoogleCloudDialogflowV2IntentMessageColumnProperties);
  checkGoogleCloudDialogflowV2IntentMessageColumnProperties(
      o[1] as api.GoogleCloudDialogflowV2IntentMessageColumnProperties);
}

core.List<api.GoogleCloudDialogflowV2IntentMessageTableCardRow>
    buildUnnamed4682() {
  var o = <api.GoogleCloudDialogflowV2IntentMessageTableCardRow>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessageTableCardRow());
  o.add(buildGoogleCloudDialogflowV2IntentMessageTableCardRow());
  return o;
}

void checkUnnamed4682(
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
    o.buttons = buildUnnamed4680();
    o.columnProperties = buildUnnamed4681();
    o.image = buildGoogleCloudDialogflowV2IntentMessageImage();
    o.rows = buildUnnamed4682();
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
    checkUnnamed4680(o.buttons!);
    checkUnnamed4681(o.columnProperties!);
    checkGoogleCloudDialogflowV2IntentMessageImage(
        o.image! as api.GoogleCloudDialogflowV2IntentMessageImage);
    checkUnnamed4682(o.rows!);
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
    buildUnnamed4683() {
  var o = <api.GoogleCloudDialogflowV2IntentMessageTableCardCell>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessageTableCardCell());
  o.add(buildGoogleCloudDialogflowV2IntentMessageTableCardCell());
  return o;
}

void checkUnnamed4683(
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
    o.cells = buildUnnamed4683();
    o.dividerAfter = true;
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageTableCardRow--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageTableCardRow(
    api.GoogleCloudDialogflowV2IntentMessageTableCardRow o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageTableCardRow++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageTableCardRow < 3) {
    checkUnnamed4683(o.cells!);
    unittest.expect(o.dividerAfter!, unittest.isTrue);
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageTableCardRow--;
}

core.List<core.String> buildUnnamed4684() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4684(core.List<core.String> o) {
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
    o.text = buildUnnamed4684();
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageText--;
  return o;
}

void checkGoogleCloudDialogflowV2IntentMessageText(
    api.GoogleCloudDialogflowV2IntentMessageText o) {
  buildCounterGoogleCloudDialogflowV2IntentMessageText++;
  if (buildCounterGoogleCloudDialogflowV2IntentMessageText < 3) {
    checkUnnamed4684(o.text!);
  }
  buildCounterGoogleCloudDialogflowV2IntentMessageText--;
}

core.List<core.String> buildUnnamed4685() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4685(core.List<core.String> o) {
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
    o.prompts = buildUnnamed4685();
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
    checkUnnamed4685(o.prompts!);
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2IntentParameter--;
}

core.List<api.GoogleCloudDialogflowV2IntentTrainingPhrasePart>
    buildUnnamed4686() {
  var o = <api.GoogleCloudDialogflowV2IntentTrainingPhrasePart>[];
  o.add(buildGoogleCloudDialogflowV2IntentTrainingPhrasePart());
  o.add(buildGoogleCloudDialogflowV2IntentTrainingPhrasePart());
  return o;
}

void checkUnnamed4686(
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
    o.parts = buildUnnamed4686();
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
    checkUnnamed4686(o.parts!);
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

core.List<api.GoogleCloudDialogflowV2Context> buildUnnamed4687() {
  var o = <api.GoogleCloudDialogflowV2Context>[];
  o.add(buildGoogleCloudDialogflowV2Context());
  o.add(buildGoogleCloudDialogflowV2Context());
  return o;
}

void checkUnnamed4687(core.List<api.GoogleCloudDialogflowV2Context> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2Context(
      o[0] as api.GoogleCloudDialogflowV2Context);
  checkGoogleCloudDialogflowV2Context(
      o[1] as api.GoogleCloudDialogflowV2Context);
}

core.int buildCounterGoogleCloudDialogflowV2ListContextsResponse = 0;
api.GoogleCloudDialogflowV2ListContextsResponse
    buildGoogleCloudDialogflowV2ListContextsResponse() {
  var o = api.GoogleCloudDialogflowV2ListContextsResponse();
  buildCounterGoogleCloudDialogflowV2ListContextsResponse++;
  if (buildCounterGoogleCloudDialogflowV2ListContextsResponse < 3) {
    o.contexts = buildUnnamed4687();
    o.nextPageToken = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2ListContextsResponse--;
  return o;
}

void checkGoogleCloudDialogflowV2ListContextsResponse(
    api.GoogleCloudDialogflowV2ListContextsResponse o) {
  buildCounterGoogleCloudDialogflowV2ListContextsResponse++;
  if (buildCounterGoogleCloudDialogflowV2ListContextsResponse < 3) {
    checkUnnamed4687(o.contexts!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2ListContextsResponse--;
}

core.List<api.GoogleCloudDialogflowV2EntityType> buildUnnamed4688() {
  var o = <api.GoogleCloudDialogflowV2EntityType>[];
  o.add(buildGoogleCloudDialogflowV2EntityType());
  o.add(buildGoogleCloudDialogflowV2EntityType());
  return o;
}

void checkUnnamed4688(core.List<api.GoogleCloudDialogflowV2EntityType> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2EntityType(
      o[0] as api.GoogleCloudDialogflowV2EntityType);
  checkGoogleCloudDialogflowV2EntityType(
      o[1] as api.GoogleCloudDialogflowV2EntityType);
}

core.int buildCounterGoogleCloudDialogflowV2ListEntityTypesResponse = 0;
api.GoogleCloudDialogflowV2ListEntityTypesResponse
    buildGoogleCloudDialogflowV2ListEntityTypesResponse() {
  var o = api.GoogleCloudDialogflowV2ListEntityTypesResponse();
  buildCounterGoogleCloudDialogflowV2ListEntityTypesResponse++;
  if (buildCounterGoogleCloudDialogflowV2ListEntityTypesResponse < 3) {
    o.entityTypes = buildUnnamed4688();
    o.nextPageToken = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2ListEntityTypesResponse--;
  return o;
}

void checkGoogleCloudDialogflowV2ListEntityTypesResponse(
    api.GoogleCloudDialogflowV2ListEntityTypesResponse o) {
  buildCounterGoogleCloudDialogflowV2ListEntityTypesResponse++;
  if (buildCounterGoogleCloudDialogflowV2ListEntityTypesResponse < 3) {
    checkUnnamed4688(o.entityTypes!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2ListEntityTypesResponse--;
}

core.List<api.GoogleCloudDialogflowV2Environment> buildUnnamed4689() {
  var o = <api.GoogleCloudDialogflowV2Environment>[];
  o.add(buildGoogleCloudDialogflowV2Environment());
  o.add(buildGoogleCloudDialogflowV2Environment());
  return o;
}

void checkUnnamed4689(core.List<api.GoogleCloudDialogflowV2Environment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2Environment(
      o[0] as api.GoogleCloudDialogflowV2Environment);
  checkGoogleCloudDialogflowV2Environment(
      o[1] as api.GoogleCloudDialogflowV2Environment);
}

core.int buildCounterGoogleCloudDialogflowV2ListEnvironmentsResponse = 0;
api.GoogleCloudDialogflowV2ListEnvironmentsResponse
    buildGoogleCloudDialogflowV2ListEnvironmentsResponse() {
  var o = api.GoogleCloudDialogflowV2ListEnvironmentsResponse();
  buildCounterGoogleCloudDialogflowV2ListEnvironmentsResponse++;
  if (buildCounterGoogleCloudDialogflowV2ListEnvironmentsResponse < 3) {
    o.environments = buildUnnamed4689();
    o.nextPageToken = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2ListEnvironmentsResponse--;
  return o;
}

void checkGoogleCloudDialogflowV2ListEnvironmentsResponse(
    api.GoogleCloudDialogflowV2ListEnvironmentsResponse o) {
  buildCounterGoogleCloudDialogflowV2ListEnvironmentsResponse++;
  if (buildCounterGoogleCloudDialogflowV2ListEnvironmentsResponse < 3) {
    checkUnnamed4689(o.environments!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2ListEnvironmentsResponse--;
}

core.List<api.GoogleCloudDialogflowV2Intent> buildUnnamed4690() {
  var o = <api.GoogleCloudDialogflowV2Intent>[];
  o.add(buildGoogleCloudDialogflowV2Intent());
  o.add(buildGoogleCloudDialogflowV2Intent());
  return o;
}

void checkUnnamed4690(core.List<api.GoogleCloudDialogflowV2Intent> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2Intent(o[0] as api.GoogleCloudDialogflowV2Intent);
  checkGoogleCloudDialogflowV2Intent(o[1] as api.GoogleCloudDialogflowV2Intent);
}

core.int buildCounterGoogleCloudDialogflowV2ListIntentsResponse = 0;
api.GoogleCloudDialogflowV2ListIntentsResponse
    buildGoogleCloudDialogflowV2ListIntentsResponse() {
  var o = api.GoogleCloudDialogflowV2ListIntentsResponse();
  buildCounterGoogleCloudDialogflowV2ListIntentsResponse++;
  if (buildCounterGoogleCloudDialogflowV2ListIntentsResponse < 3) {
    o.intents = buildUnnamed4690();
    o.nextPageToken = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2ListIntentsResponse--;
  return o;
}

void checkGoogleCloudDialogflowV2ListIntentsResponse(
    api.GoogleCloudDialogflowV2ListIntentsResponse o) {
  buildCounterGoogleCloudDialogflowV2ListIntentsResponse++;
  if (buildCounterGoogleCloudDialogflowV2ListIntentsResponse < 3) {
    checkUnnamed4690(o.intents!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2ListIntentsResponse--;
}

core.List<api.GoogleCloudDialogflowV2SessionEntityType> buildUnnamed4691() {
  var o = <api.GoogleCloudDialogflowV2SessionEntityType>[];
  o.add(buildGoogleCloudDialogflowV2SessionEntityType());
  o.add(buildGoogleCloudDialogflowV2SessionEntityType());
  return o;
}

void checkUnnamed4691(
    core.List<api.GoogleCloudDialogflowV2SessionEntityType> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2SessionEntityType(
      o[0] as api.GoogleCloudDialogflowV2SessionEntityType);
  checkGoogleCloudDialogflowV2SessionEntityType(
      o[1] as api.GoogleCloudDialogflowV2SessionEntityType);
}

core.int buildCounterGoogleCloudDialogflowV2ListSessionEntityTypesResponse = 0;
api.GoogleCloudDialogflowV2ListSessionEntityTypesResponse
    buildGoogleCloudDialogflowV2ListSessionEntityTypesResponse() {
  var o = api.GoogleCloudDialogflowV2ListSessionEntityTypesResponse();
  buildCounterGoogleCloudDialogflowV2ListSessionEntityTypesResponse++;
  if (buildCounterGoogleCloudDialogflowV2ListSessionEntityTypesResponse < 3) {
    o.nextPageToken = 'foo';
    o.sessionEntityTypes = buildUnnamed4691();
  }
  buildCounterGoogleCloudDialogflowV2ListSessionEntityTypesResponse--;
  return o;
}

void checkGoogleCloudDialogflowV2ListSessionEntityTypesResponse(
    api.GoogleCloudDialogflowV2ListSessionEntityTypesResponse o) {
  buildCounterGoogleCloudDialogflowV2ListSessionEntityTypesResponse++;
  if (buildCounterGoogleCloudDialogflowV2ListSessionEntityTypesResponse < 3) {
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
    checkUnnamed4691(o.sessionEntityTypes!);
  }
  buildCounterGoogleCloudDialogflowV2ListSessionEntityTypesResponse--;
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

core.List<api.GoogleCloudDialogflowV2AnnotatedMessagePart> buildUnnamed4692() {
  var o = <api.GoogleCloudDialogflowV2AnnotatedMessagePart>[];
  o.add(buildGoogleCloudDialogflowV2AnnotatedMessagePart());
  o.add(buildGoogleCloudDialogflowV2AnnotatedMessagePart());
  return o;
}

void checkUnnamed4692(
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
    o.parts = buildUnnamed4692();
  }
  buildCounterGoogleCloudDialogflowV2MessageAnnotation--;
  return o;
}

void checkGoogleCloudDialogflowV2MessageAnnotation(
    api.GoogleCloudDialogflowV2MessageAnnotation o) {
  buildCounterGoogleCloudDialogflowV2MessageAnnotation++;
  if (buildCounterGoogleCloudDialogflowV2MessageAnnotation < 3) {
    unittest.expect(o.containEntities!, unittest.isTrue);
    checkUnnamed4692(o.parts!);
  }
  buildCounterGoogleCloudDialogflowV2MessageAnnotation--;
}

core.Map<core.String, core.Object> buildUnnamed4693() {
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

void checkUnnamed4693(core.Map<core.String, core.Object> o) {
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

core.int buildCounterGoogleCloudDialogflowV2OriginalDetectIntentRequest = 0;
api.GoogleCloudDialogflowV2OriginalDetectIntentRequest
    buildGoogleCloudDialogflowV2OriginalDetectIntentRequest() {
  var o = api.GoogleCloudDialogflowV2OriginalDetectIntentRequest();
  buildCounterGoogleCloudDialogflowV2OriginalDetectIntentRequest++;
  if (buildCounterGoogleCloudDialogflowV2OriginalDetectIntentRequest < 3) {
    o.payload = buildUnnamed4693();
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
    checkUnnamed4693(o.payload!);
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

core.int buildCounterGoogleCloudDialogflowV2OutputAudioConfig = 0;
api.GoogleCloudDialogflowV2OutputAudioConfig
    buildGoogleCloudDialogflowV2OutputAudioConfig() {
  var o = api.GoogleCloudDialogflowV2OutputAudioConfig();
  buildCounterGoogleCloudDialogflowV2OutputAudioConfig++;
  if (buildCounterGoogleCloudDialogflowV2OutputAudioConfig < 3) {
    o.audioEncoding = 'foo';
    o.sampleRateHertz = 42;
    o.synthesizeSpeechConfig =
        buildGoogleCloudDialogflowV2SynthesizeSpeechConfig();
  }
  buildCounterGoogleCloudDialogflowV2OutputAudioConfig--;
  return o;
}

void checkGoogleCloudDialogflowV2OutputAudioConfig(
    api.GoogleCloudDialogflowV2OutputAudioConfig o) {
  buildCounterGoogleCloudDialogflowV2OutputAudioConfig++;
  if (buildCounterGoogleCloudDialogflowV2OutputAudioConfig < 3) {
    unittest.expect(
      o.audioEncoding!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.sampleRateHertz!,
      unittest.equals(42),
    );
    checkGoogleCloudDialogflowV2SynthesizeSpeechConfig(o.synthesizeSpeechConfig!
        as api.GoogleCloudDialogflowV2SynthesizeSpeechConfig);
  }
  buildCounterGoogleCloudDialogflowV2OutputAudioConfig--;
}

core.int buildCounterGoogleCloudDialogflowV2QueryInput = 0;
api.GoogleCloudDialogflowV2QueryInput buildGoogleCloudDialogflowV2QueryInput() {
  var o = api.GoogleCloudDialogflowV2QueryInput();
  buildCounterGoogleCloudDialogflowV2QueryInput++;
  if (buildCounterGoogleCloudDialogflowV2QueryInput < 3) {
    o.audioConfig = buildGoogleCloudDialogflowV2InputAudioConfig();
    o.event = buildGoogleCloudDialogflowV2EventInput();
    o.text = buildGoogleCloudDialogflowV2TextInput();
  }
  buildCounterGoogleCloudDialogflowV2QueryInput--;
  return o;
}

void checkGoogleCloudDialogflowV2QueryInput(
    api.GoogleCloudDialogflowV2QueryInput o) {
  buildCounterGoogleCloudDialogflowV2QueryInput++;
  if (buildCounterGoogleCloudDialogflowV2QueryInput < 3) {
    checkGoogleCloudDialogflowV2InputAudioConfig(
        o.audioConfig! as api.GoogleCloudDialogflowV2InputAudioConfig);
    checkGoogleCloudDialogflowV2EventInput(
        o.event! as api.GoogleCloudDialogflowV2EventInput);
    checkGoogleCloudDialogflowV2TextInput(
        o.text! as api.GoogleCloudDialogflowV2TextInput);
  }
  buildCounterGoogleCloudDialogflowV2QueryInput--;
}

core.List<api.GoogleCloudDialogflowV2Context> buildUnnamed4694() {
  var o = <api.GoogleCloudDialogflowV2Context>[];
  o.add(buildGoogleCloudDialogflowV2Context());
  o.add(buildGoogleCloudDialogflowV2Context());
  return o;
}

void checkUnnamed4694(core.List<api.GoogleCloudDialogflowV2Context> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2Context(
      o[0] as api.GoogleCloudDialogflowV2Context);
  checkGoogleCloudDialogflowV2Context(
      o[1] as api.GoogleCloudDialogflowV2Context);
}

core.Map<core.String, core.Object> buildUnnamed4695() {
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

void checkUnnamed4695(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted54 = (o['x']!) as core.Map;
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
  var casted55 = (o['y']!) as core.Map;
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
}

core.List<api.GoogleCloudDialogflowV2SessionEntityType> buildUnnamed4696() {
  var o = <api.GoogleCloudDialogflowV2SessionEntityType>[];
  o.add(buildGoogleCloudDialogflowV2SessionEntityType());
  o.add(buildGoogleCloudDialogflowV2SessionEntityType());
  return o;
}

void checkUnnamed4696(
    core.List<api.GoogleCloudDialogflowV2SessionEntityType> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2SessionEntityType(
      o[0] as api.GoogleCloudDialogflowV2SessionEntityType);
  checkGoogleCloudDialogflowV2SessionEntityType(
      o[1] as api.GoogleCloudDialogflowV2SessionEntityType);
}

core.Map<core.String, core.String> buildUnnamed4697() {
  var o = <core.String, core.String>{};
  o['x'] = 'foo';
  o['y'] = 'foo';
  return o;
}

void checkUnnamed4697(core.Map<core.String, core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowV2QueryParameters = 0;
api.GoogleCloudDialogflowV2QueryParameters
    buildGoogleCloudDialogflowV2QueryParameters() {
  var o = api.GoogleCloudDialogflowV2QueryParameters();
  buildCounterGoogleCloudDialogflowV2QueryParameters++;
  if (buildCounterGoogleCloudDialogflowV2QueryParameters < 3) {
    o.contexts = buildUnnamed4694();
    o.geoLocation = buildGoogleTypeLatLng();
    o.payload = buildUnnamed4695();
    o.resetContexts = true;
    o.sentimentAnalysisRequestConfig =
        buildGoogleCloudDialogflowV2SentimentAnalysisRequestConfig();
    o.sessionEntityTypes = buildUnnamed4696();
    o.timeZone = 'foo';
    o.webhookHeaders = buildUnnamed4697();
  }
  buildCounterGoogleCloudDialogflowV2QueryParameters--;
  return o;
}

void checkGoogleCloudDialogflowV2QueryParameters(
    api.GoogleCloudDialogflowV2QueryParameters o) {
  buildCounterGoogleCloudDialogflowV2QueryParameters++;
  if (buildCounterGoogleCloudDialogflowV2QueryParameters < 3) {
    checkUnnamed4694(o.contexts!);
    checkGoogleTypeLatLng(o.geoLocation! as api.GoogleTypeLatLng);
    checkUnnamed4695(o.payload!);
    unittest.expect(o.resetContexts!, unittest.isTrue);
    checkGoogleCloudDialogflowV2SentimentAnalysisRequestConfig(
        o.sentimentAnalysisRequestConfig!
            as api.GoogleCloudDialogflowV2SentimentAnalysisRequestConfig);
    checkUnnamed4696(o.sessionEntityTypes!);
    unittest.expect(
      o.timeZone!,
      unittest.equals('foo'),
    );
    checkUnnamed4697(o.webhookHeaders!);
  }
  buildCounterGoogleCloudDialogflowV2QueryParameters--;
}

core.Map<core.String, core.Object> buildUnnamed4698() {
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

void checkUnnamed4698(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted56 = (o['x']!) as core.Map;
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
  var casted57 = (o['y']!) as core.Map;
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
}

core.List<api.GoogleCloudDialogflowV2IntentMessage> buildUnnamed4699() {
  var o = <api.GoogleCloudDialogflowV2IntentMessage>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessage());
  o.add(buildGoogleCloudDialogflowV2IntentMessage());
  return o;
}

void checkUnnamed4699(core.List<api.GoogleCloudDialogflowV2IntentMessage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentMessage(
      o[0] as api.GoogleCloudDialogflowV2IntentMessage);
  checkGoogleCloudDialogflowV2IntentMessage(
      o[1] as api.GoogleCloudDialogflowV2IntentMessage);
}

core.List<api.GoogleCloudDialogflowV2Context> buildUnnamed4700() {
  var o = <api.GoogleCloudDialogflowV2Context>[];
  o.add(buildGoogleCloudDialogflowV2Context());
  o.add(buildGoogleCloudDialogflowV2Context());
  return o;
}

void checkUnnamed4700(core.List<api.GoogleCloudDialogflowV2Context> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2Context(
      o[0] as api.GoogleCloudDialogflowV2Context);
  checkGoogleCloudDialogflowV2Context(
      o[1] as api.GoogleCloudDialogflowV2Context);
}

core.Map<core.String, core.Object> buildUnnamed4701() {
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

void checkUnnamed4701(core.Map<core.String, core.Object> o) {
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

core.Map<core.String, core.Object> buildUnnamed4702() {
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

void checkUnnamed4702(core.Map<core.String, core.Object> o) {
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

core.int buildCounterGoogleCloudDialogflowV2QueryResult = 0;
api.GoogleCloudDialogflowV2QueryResult
    buildGoogleCloudDialogflowV2QueryResult() {
  var o = api.GoogleCloudDialogflowV2QueryResult();
  buildCounterGoogleCloudDialogflowV2QueryResult++;
  if (buildCounterGoogleCloudDialogflowV2QueryResult < 3) {
    o.action = 'foo';
    o.allRequiredParamsPresent = true;
    o.diagnosticInfo = buildUnnamed4698();
    o.fulfillmentMessages = buildUnnamed4699();
    o.fulfillmentText = 'foo';
    o.intent = buildGoogleCloudDialogflowV2Intent();
    o.intentDetectionConfidence = 42.0;
    o.languageCode = 'foo';
    o.outputContexts = buildUnnamed4700();
    o.parameters = buildUnnamed4701();
    o.queryText = 'foo';
    o.sentimentAnalysisResult =
        buildGoogleCloudDialogflowV2SentimentAnalysisResult();
    o.speechRecognitionConfidence = 42.0;
    o.webhookPayload = buildUnnamed4702();
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
    checkUnnamed4698(o.diagnosticInfo!);
    checkUnnamed4699(o.fulfillmentMessages!);
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
    checkUnnamed4700(o.outputContexts!);
    checkUnnamed4701(o.parameters!);
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
    checkUnnamed4702(o.webhookPayload!);
    unittest.expect(
      o.webhookSource!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2QueryResult--;
}

core.int buildCounterGoogleCloudDialogflowV2RestoreAgentRequest = 0;
api.GoogleCloudDialogflowV2RestoreAgentRequest
    buildGoogleCloudDialogflowV2RestoreAgentRequest() {
  var o = api.GoogleCloudDialogflowV2RestoreAgentRequest();
  buildCounterGoogleCloudDialogflowV2RestoreAgentRequest++;
  if (buildCounterGoogleCloudDialogflowV2RestoreAgentRequest < 3) {
    o.agentContent = 'foo';
    o.agentUri = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2RestoreAgentRequest--;
  return o;
}

void checkGoogleCloudDialogflowV2RestoreAgentRequest(
    api.GoogleCloudDialogflowV2RestoreAgentRequest o) {
  buildCounterGoogleCloudDialogflowV2RestoreAgentRequest++;
  if (buildCounterGoogleCloudDialogflowV2RestoreAgentRequest < 3) {
    unittest.expect(
      o.agentContent!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.agentUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2RestoreAgentRequest--;
}

core.List<api.GoogleCloudDialogflowV2Agent> buildUnnamed4703() {
  var o = <api.GoogleCloudDialogflowV2Agent>[];
  o.add(buildGoogleCloudDialogflowV2Agent());
  o.add(buildGoogleCloudDialogflowV2Agent());
  return o;
}

void checkUnnamed4703(core.List<api.GoogleCloudDialogflowV2Agent> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2Agent(o[0] as api.GoogleCloudDialogflowV2Agent);
  checkGoogleCloudDialogflowV2Agent(o[1] as api.GoogleCloudDialogflowV2Agent);
}

core.int buildCounterGoogleCloudDialogflowV2SearchAgentsResponse = 0;
api.GoogleCloudDialogflowV2SearchAgentsResponse
    buildGoogleCloudDialogflowV2SearchAgentsResponse() {
  var o = api.GoogleCloudDialogflowV2SearchAgentsResponse();
  buildCounterGoogleCloudDialogflowV2SearchAgentsResponse++;
  if (buildCounterGoogleCloudDialogflowV2SearchAgentsResponse < 3) {
    o.agents = buildUnnamed4703();
    o.nextPageToken = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2SearchAgentsResponse--;
  return o;
}

void checkGoogleCloudDialogflowV2SearchAgentsResponse(
    api.GoogleCloudDialogflowV2SearchAgentsResponse o) {
  buildCounterGoogleCloudDialogflowV2SearchAgentsResponse++;
  if (buildCounterGoogleCloudDialogflowV2SearchAgentsResponse < 3) {
    checkUnnamed4703(o.agents!);
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2SearchAgentsResponse--;
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

core.int buildCounterGoogleCloudDialogflowV2SentimentAnalysisRequestConfig = 0;
api.GoogleCloudDialogflowV2SentimentAnalysisRequestConfig
    buildGoogleCloudDialogflowV2SentimentAnalysisRequestConfig() {
  var o = api.GoogleCloudDialogflowV2SentimentAnalysisRequestConfig();
  buildCounterGoogleCloudDialogflowV2SentimentAnalysisRequestConfig++;
  if (buildCounterGoogleCloudDialogflowV2SentimentAnalysisRequestConfig < 3) {
    o.analyzeQueryTextSentiment = true;
  }
  buildCounterGoogleCloudDialogflowV2SentimentAnalysisRequestConfig--;
  return o;
}

void checkGoogleCloudDialogflowV2SentimentAnalysisRequestConfig(
    api.GoogleCloudDialogflowV2SentimentAnalysisRequestConfig o) {
  buildCounterGoogleCloudDialogflowV2SentimentAnalysisRequestConfig++;
  if (buildCounterGoogleCloudDialogflowV2SentimentAnalysisRequestConfig < 3) {
    unittest.expect(o.analyzeQueryTextSentiment!, unittest.isTrue);
  }
  buildCounterGoogleCloudDialogflowV2SentimentAnalysisRequestConfig--;
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

core.List<api.GoogleCloudDialogflowV2EntityTypeEntity> buildUnnamed4704() {
  var o = <api.GoogleCloudDialogflowV2EntityTypeEntity>[];
  o.add(buildGoogleCloudDialogflowV2EntityTypeEntity());
  o.add(buildGoogleCloudDialogflowV2EntityTypeEntity());
  return o;
}

void checkUnnamed4704(
    core.List<api.GoogleCloudDialogflowV2EntityTypeEntity> o) {
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
    o.entities = buildUnnamed4704();
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
    checkUnnamed4704(o.entities!);
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

core.List<core.String> buildUnnamed4705() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4705(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowV2SpeechContext = 0;
api.GoogleCloudDialogflowV2SpeechContext
    buildGoogleCloudDialogflowV2SpeechContext() {
  var o = api.GoogleCloudDialogflowV2SpeechContext();
  buildCounterGoogleCloudDialogflowV2SpeechContext++;
  if (buildCounterGoogleCloudDialogflowV2SpeechContext < 3) {
    o.boost = 42.0;
    o.phrases = buildUnnamed4705();
  }
  buildCounterGoogleCloudDialogflowV2SpeechContext--;
  return o;
}

void checkGoogleCloudDialogflowV2SpeechContext(
    api.GoogleCloudDialogflowV2SpeechContext o) {
  buildCounterGoogleCloudDialogflowV2SpeechContext++;
  if (buildCounterGoogleCloudDialogflowV2SpeechContext < 3) {
    unittest.expect(
      o.boost!,
      unittest.equals(42.0),
    );
    checkUnnamed4705(o.phrases!);
  }
  buildCounterGoogleCloudDialogflowV2SpeechContext--;
}

core.List<core.String> buildUnnamed4706() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4706(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowV2SynthesizeSpeechConfig = 0;
api.GoogleCloudDialogflowV2SynthesizeSpeechConfig
    buildGoogleCloudDialogflowV2SynthesizeSpeechConfig() {
  var o = api.GoogleCloudDialogflowV2SynthesizeSpeechConfig();
  buildCounterGoogleCloudDialogflowV2SynthesizeSpeechConfig++;
  if (buildCounterGoogleCloudDialogflowV2SynthesizeSpeechConfig < 3) {
    o.effectsProfileId = buildUnnamed4706();
    o.pitch = 42.0;
    o.speakingRate = 42.0;
    o.voice = buildGoogleCloudDialogflowV2VoiceSelectionParams();
    o.volumeGainDb = 42.0;
  }
  buildCounterGoogleCloudDialogflowV2SynthesizeSpeechConfig--;
  return o;
}

void checkGoogleCloudDialogflowV2SynthesizeSpeechConfig(
    api.GoogleCloudDialogflowV2SynthesizeSpeechConfig o) {
  buildCounterGoogleCloudDialogflowV2SynthesizeSpeechConfig++;
  if (buildCounterGoogleCloudDialogflowV2SynthesizeSpeechConfig < 3) {
    checkUnnamed4706(o.effectsProfileId!);
    unittest.expect(
      o.pitch!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.speakingRate!,
      unittest.equals(42.0),
    );
    checkGoogleCloudDialogflowV2VoiceSelectionParams(
        o.voice! as api.GoogleCloudDialogflowV2VoiceSelectionParams);
    unittest.expect(
      o.volumeGainDb!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudDialogflowV2SynthesizeSpeechConfig--;
}

core.int buildCounterGoogleCloudDialogflowV2TextInput = 0;
api.GoogleCloudDialogflowV2TextInput buildGoogleCloudDialogflowV2TextInput() {
  var o = api.GoogleCloudDialogflowV2TextInput();
  buildCounterGoogleCloudDialogflowV2TextInput++;
  if (buildCounterGoogleCloudDialogflowV2TextInput < 3) {
    o.languageCode = 'foo';
    o.text = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2TextInput--;
  return o;
}

void checkGoogleCloudDialogflowV2TextInput(
    api.GoogleCloudDialogflowV2TextInput o) {
  buildCounterGoogleCloudDialogflowV2TextInput++;
  if (buildCounterGoogleCloudDialogflowV2TextInput < 3) {
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2TextInput--;
}

core.int buildCounterGoogleCloudDialogflowV2TrainAgentRequest = 0;
api.GoogleCloudDialogflowV2TrainAgentRequest
    buildGoogleCloudDialogflowV2TrainAgentRequest() {
  var o = api.GoogleCloudDialogflowV2TrainAgentRequest();
  buildCounterGoogleCloudDialogflowV2TrainAgentRequest++;
  if (buildCounterGoogleCloudDialogflowV2TrainAgentRequest < 3) {}
  buildCounterGoogleCloudDialogflowV2TrainAgentRequest--;
  return o;
}

void checkGoogleCloudDialogflowV2TrainAgentRequest(
    api.GoogleCloudDialogflowV2TrainAgentRequest o) {
  buildCounterGoogleCloudDialogflowV2TrainAgentRequest++;
  if (buildCounterGoogleCloudDialogflowV2TrainAgentRequest < 3) {}
  buildCounterGoogleCloudDialogflowV2TrainAgentRequest--;
}

core.List<core.String> buildUnnamed4707() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4707(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudDialogflowV2ValidationError = 0;
api.GoogleCloudDialogflowV2ValidationError
    buildGoogleCloudDialogflowV2ValidationError() {
  var o = api.GoogleCloudDialogflowV2ValidationError();
  buildCounterGoogleCloudDialogflowV2ValidationError++;
  if (buildCounterGoogleCloudDialogflowV2ValidationError < 3) {
    o.entries = buildUnnamed4707();
    o.errorMessage = 'foo';
    o.severity = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2ValidationError--;
  return o;
}

void checkGoogleCloudDialogflowV2ValidationError(
    api.GoogleCloudDialogflowV2ValidationError o) {
  buildCounterGoogleCloudDialogflowV2ValidationError++;
  if (buildCounterGoogleCloudDialogflowV2ValidationError < 3) {
    checkUnnamed4707(o.entries!);
    unittest.expect(
      o.errorMessage!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.severity!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2ValidationError--;
}

core.List<api.GoogleCloudDialogflowV2ValidationError> buildUnnamed4708() {
  var o = <api.GoogleCloudDialogflowV2ValidationError>[];
  o.add(buildGoogleCloudDialogflowV2ValidationError());
  o.add(buildGoogleCloudDialogflowV2ValidationError());
  return o;
}

void checkUnnamed4708(core.List<api.GoogleCloudDialogflowV2ValidationError> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2ValidationError(
      o[0] as api.GoogleCloudDialogflowV2ValidationError);
  checkGoogleCloudDialogflowV2ValidationError(
      o[1] as api.GoogleCloudDialogflowV2ValidationError);
}

core.int buildCounterGoogleCloudDialogflowV2ValidationResult = 0;
api.GoogleCloudDialogflowV2ValidationResult
    buildGoogleCloudDialogflowV2ValidationResult() {
  var o = api.GoogleCloudDialogflowV2ValidationResult();
  buildCounterGoogleCloudDialogflowV2ValidationResult++;
  if (buildCounterGoogleCloudDialogflowV2ValidationResult < 3) {
    o.validationErrors = buildUnnamed4708();
  }
  buildCounterGoogleCloudDialogflowV2ValidationResult--;
  return o;
}

void checkGoogleCloudDialogflowV2ValidationResult(
    api.GoogleCloudDialogflowV2ValidationResult o) {
  buildCounterGoogleCloudDialogflowV2ValidationResult++;
  if (buildCounterGoogleCloudDialogflowV2ValidationResult < 3) {
    checkUnnamed4708(o.validationErrors!);
  }
  buildCounterGoogleCloudDialogflowV2ValidationResult--;
}

core.int buildCounterGoogleCloudDialogflowV2VoiceSelectionParams = 0;
api.GoogleCloudDialogflowV2VoiceSelectionParams
    buildGoogleCloudDialogflowV2VoiceSelectionParams() {
  var o = api.GoogleCloudDialogflowV2VoiceSelectionParams();
  buildCounterGoogleCloudDialogflowV2VoiceSelectionParams++;
  if (buildCounterGoogleCloudDialogflowV2VoiceSelectionParams < 3) {
    o.name = 'foo';
    o.ssmlGender = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2VoiceSelectionParams--;
  return o;
}

void checkGoogleCloudDialogflowV2VoiceSelectionParams(
    api.GoogleCloudDialogflowV2VoiceSelectionParams o) {
  buildCounterGoogleCloudDialogflowV2VoiceSelectionParams++;
  if (buildCounterGoogleCloudDialogflowV2VoiceSelectionParams < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.ssmlGender!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2VoiceSelectionParams--;
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

core.List<api.GoogleCloudDialogflowV2IntentMessage> buildUnnamed4709() {
  var o = <api.GoogleCloudDialogflowV2IntentMessage>[];
  o.add(buildGoogleCloudDialogflowV2IntentMessage());
  o.add(buildGoogleCloudDialogflowV2IntentMessage());
  return o;
}

void checkUnnamed4709(core.List<api.GoogleCloudDialogflowV2IntentMessage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2IntentMessage(
      o[0] as api.GoogleCloudDialogflowV2IntentMessage);
  checkGoogleCloudDialogflowV2IntentMessage(
      o[1] as api.GoogleCloudDialogflowV2IntentMessage);
}

core.List<api.GoogleCloudDialogflowV2Context> buildUnnamed4710() {
  var o = <api.GoogleCloudDialogflowV2Context>[];
  o.add(buildGoogleCloudDialogflowV2Context());
  o.add(buildGoogleCloudDialogflowV2Context());
  return o;
}

void checkUnnamed4710(core.List<api.GoogleCloudDialogflowV2Context> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2Context(
      o[0] as api.GoogleCloudDialogflowV2Context);
  checkGoogleCloudDialogflowV2Context(
      o[1] as api.GoogleCloudDialogflowV2Context);
}

core.Map<core.String, core.Object> buildUnnamed4711() {
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

void checkUnnamed4711(core.Map<core.String, core.Object> o) {
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

core.List<api.GoogleCloudDialogflowV2SessionEntityType> buildUnnamed4712() {
  var o = <api.GoogleCloudDialogflowV2SessionEntityType>[];
  o.add(buildGoogleCloudDialogflowV2SessionEntityType());
  o.add(buildGoogleCloudDialogflowV2SessionEntityType());
  return o;
}

void checkUnnamed4712(
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
    o.fulfillmentMessages = buildUnnamed4709();
    o.fulfillmentText = 'foo';
    o.outputContexts = buildUnnamed4710();
    o.payload = buildUnnamed4711();
    o.sessionEntityTypes = buildUnnamed4712();
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
    checkUnnamed4709(o.fulfillmentMessages!);
    unittest.expect(
      o.fulfillmentText!,
      unittest.equals('foo'),
    );
    checkUnnamed4710(o.outputContexts!);
    checkUnnamed4711(o.payload!);
    checkUnnamed4712(o.sessionEntityTypes!);
    unittest.expect(
      o.source!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2WebhookResponse--;
}

core.List<api.GoogleCloudDialogflowV2beta1EntityType> buildUnnamed4713() {
  var o = <api.GoogleCloudDialogflowV2beta1EntityType>[];
  o.add(buildGoogleCloudDialogflowV2beta1EntityType());
  o.add(buildGoogleCloudDialogflowV2beta1EntityType());
  return o;
}

void checkUnnamed4713(core.List<api.GoogleCloudDialogflowV2beta1EntityType> o) {
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
    o.entityTypes = buildUnnamed4713();
  }
  buildCounterGoogleCloudDialogflowV2beta1BatchUpdateEntityTypesResponse--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1BatchUpdateEntityTypesResponse(
    api.GoogleCloudDialogflowV2beta1BatchUpdateEntityTypesResponse o) {
  buildCounterGoogleCloudDialogflowV2beta1BatchUpdateEntityTypesResponse++;
  if (buildCounterGoogleCloudDialogflowV2beta1BatchUpdateEntityTypesResponse <
      3) {
    checkUnnamed4713(o.entityTypes!);
  }
  buildCounterGoogleCloudDialogflowV2beta1BatchUpdateEntityTypesResponse--;
}

core.List<api.GoogleCloudDialogflowV2beta1Intent> buildUnnamed4714() {
  var o = <api.GoogleCloudDialogflowV2beta1Intent>[];
  o.add(buildGoogleCloudDialogflowV2beta1Intent());
  o.add(buildGoogleCloudDialogflowV2beta1Intent());
  return o;
}

void checkUnnamed4714(core.List<api.GoogleCloudDialogflowV2beta1Intent> o) {
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
    o.intents = buildUnnamed4714();
  }
  buildCounterGoogleCloudDialogflowV2beta1BatchUpdateIntentsResponse--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1BatchUpdateIntentsResponse(
    api.GoogleCloudDialogflowV2beta1BatchUpdateIntentsResponse o) {
  buildCounterGoogleCloudDialogflowV2beta1BatchUpdateIntentsResponse++;
  if (buildCounterGoogleCloudDialogflowV2beta1BatchUpdateIntentsResponse < 3) {
    checkUnnamed4714(o.intents!);
  }
  buildCounterGoogleCloudDialogflowV2beta1BatchUpdateIntentsResponse--;
}

core.Map<core.String, core.Object> buildUnnamed4715() {
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

void checkUnnamed4715(core.Map<core.String, core.Object> o) {
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

core.int buildCounterGoogleCloudDialogflowV2beta1Context = 0;
api.GoogleCloudDialogflowV2beta1Context
    buildGoogleCloudDialogflowV2beta1Context() {
  var o = api.GoogleCloudDialogflowV2beta1Context();
  buildCounterGoogleCloudDialogflowV2beta1Context++;
  if (buildCounterGoogleCloudDialogflowV2beta1Context < 3) {
    o.lifespanCount = 42;
    o.name = 'foo';
    o.parameters = buildUnnamed4715();
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
    checkUnnamed4715(o.parameters!);
  }
  buildCounterGoogleCloudDialogflowV2beta1Context--;
}

core.List<api.GoogleCloudDialogflowV2beta1EntityTypeEntity> buildUnnamed4716() {
  var o = <api.GoogleCloudDialogflowV2beta1EntityTypeEntity>[];
  o.add(buildGoogleCloudDialogflowV2beta1EntityTypeEntity());
  o.add(buildGoogleCloudDialogflowV2beta1EntityTypeEntity());
  return o;
}

void checkUnnamed4716(
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
    o.entities = buildUnnamed4716();
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
    checkUnnamed4716(o.entities!);
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

core.List<core.String> buildUnnamed4717() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4717(core.List<core.String> o) {
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
    o.synonyms = buildUnnamed4717();
    o.value = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1EntityTypeEntity--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1EntityTypeEntity(
    api.GoogleCloudDialogflowV2beta1EntityTypeEntity o) {
  buildCounterGoogleCloudDialogflowV2beta1EntityTypeEntity++;
  if (buildCounterGoogleCloudDialogflowV2beta1EntityTypeEntity < 3) {
    checkUnnamed4717(o.synonyms!);
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1EntityTypeEntity--;
}

core.Map<core.String, core.Object> buildUnnamed4718() {
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

void checkUnnamed4718(core.Map<core.String, core.Object> o) {
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

core.int buildCounterGoogleCloudDialogflowV2beta1EventInput = 0;
api.GoogleCloudDialogflowV2beta1EventInput
    buildGoogleCloudDialogflowV2beta1EventInput() {
  var o = api.GoogleCloudDialogflowV2beta1EventInput();
  buildCounterGoogleCloudDialogflowV2beta1EventInput++;
  if (buildCounterGoogleCloudDialogflowV2beta1EventInput < 3) {
    o.languageCode = 'foo';
    o.name = 'foo';
    o.parameters = buildUnnamed4718();
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
    checkUnnamed4718(o.parameters!);
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

core.List<core.String> buildUnnamed4719() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4719(core.List<core.String> o) {
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

core.List<core.String> buildUnnamed4720() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4720(core.List<core.String> o) {
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
    buildUnnamed4721() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentFollowupIntentInfo>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentFollowupIntentInfo());
  o.add(buildGoogleCloudDialogflowV2beta1IntentFollowupIntentInfo());
  return o;
}

void checkUnnamed4721(
    core.List<api.GoogleCloudDialogflowV2beta1IntentFollowupIntentInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentFollowupIntentInfo(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentFollowupIntentInfo);
  checkGoogleCloudDialogflowV2beta1IntentFollowupIntentInfo(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentFollowupIntentInfo);
}

core.List<core.String> buildUnnamed4722() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4722(core.List<core.String> o) {
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

core.List<api.GoogleCloudDialogflowV2beta1IntentMessage> buildUnnamed4723() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessage>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessage());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessage());
  return o;
}

void checkUnnamed4723(
    core.List<api.GoogleCloudDialogflowV2beta1IntentMessage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentMessage(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentMessage);
  checkGoogleCloudDialogflowV2beta1IntentMessage(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentMessage);
}

core.List<api.GoogleCloudDialogflowV2beta1Context> buildUnnamed4724() {
  var o = <api.GoogleCloudDialogflowV2beta1Context>[];
  o.add(buildGoogleCloudDialogflowV2beta1Context());
  o.add(buildGoogleCloudDialogflowV2beta1Context());
  return o;
}

void checkUnnamed4724(core.List<api.GoogleCloudDialogflowV2beta1Context> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1Context(
      o[0] as api.GoogleCloudDialogflowV2beta1Context);
  checkGoogleCloudDialogflowV2beta1Context(
      o[1] as api.GoogleCloudDialogflowV2beta1Context);
}

core.List<api.GoogleCloudDialogflowV2beta1IntentParameter> buildUnnamed4725() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentParameter>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentParameter());
  o.add(buildGoogleCloudDialogflowV2beta1IntentParameter());
  return o;
}

void checkUnnamed4725(
    core.List<api.GoogleCloudDialogflowV2beta1IntentParameter> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentParameter(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentParameter);
  checkGoogleCloudDialogflowV2beta1IntentParameter(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentParameter);
}

core.List<api.GoogleCloudDialogflowV2beta1IntentTrainingPhrase>
    buildUnnamed4726() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentTrainingPhrase>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentTrainingPhrase());
  o.add(buildGoogleCloudDialogflowV2beta1IntentTrainingPhrase());
  return o;
}

void checkUnnamed4726(
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
    o.defaultResponsePlatforms = buildUnnamed4719();
    o.displayName = 'foo';
    o.endInteraction = true;
    o.events = buildUnnamed4720();
    o.followupIntentInfo = buildUnnamed4721();
    o.inputContextNames = buildUnnamed4722();
    o.isFallback = true;
    o.messages = buildUnnamed4723();
    o.mlDisabled = true;
    o.mlEnabled = true;
    o.name = 'foo';
    o.outputContexts = buildUnnamed4724();
    o.parameters = buildUnnamed4725();
    o.parentFollowupIntentName = 'foo';
    o.priority = 42;
    o.resetContexts = true;
    o.rootFollowupIntentName = 'foo';
    o.trainingPhrases = buildUnnamed4726();
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
    checkUnnamed4719(o.defaultResponsePlatforms!);
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    unittest.expect(o.endInteraction!, unittest.isTrue);
    checkUnnamed4720(o.events!);
    checkUnnamed4721(o.followupIntentInfo!);
    checkUnnamed4722(o.inputContextNames!);
    unittest.expect(o.isFallback!, unittest.isTrue);
    checkUnnamed4723(o.messages!);
    unittest.expect(o.mlDisabled!, unittest.isTrue);
    unittest.expect(o.mlEnabled!, unittest.isTrue);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed4724(o.outputContexts!);
    checkUnnamed4725(o.parameters!);
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
    checkUnnamed4726(o.trainingPhrases!);
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

core.Map<core.String, core.Object> buildUnnamed4727() {
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

void checkUnnamed4727(core.Map<core.String, core.Object> o) {
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
    o.payload = buildUnnamed4727();
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
    checkUnnamed4727(o.payload!);
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
    buildUnnamed4728() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageBasicCardButton>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageBasicCardButton());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageBasicCardButton());
  return o;
}

void checkUnnamed4728(
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
    o.buttons = buildUnnamed4728();
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
    checkUnnamed4728(o.buttons!);
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
    buildUnnamed4729() {
  var o = <
      api.GoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem>[];
  o.add(
      buildGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem());
  o.add(
      buildGoogleCloudDialogflowV2beta1IntentMessageBrowseCarouselCardBrowseCarouselCardItem());
  return o;
}

void checkUnnamed4729(
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
    o.items = buildUnnamed4729();
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
    checkUnnamed4729(o.items!);
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
    buildUnnamed4730() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageCardButton>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageCardButton());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageCardButton());
  return o;
}

void checkUnnamed4730(
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
    o.buttons = buildUnnamed4730();
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
    checkUnnamed4730(o.buttons!);
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
    buildUnnamed4731() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageCarouselSelectItem());
  return o;
}

void checkUnnamed4731(
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
    o.items = buildUnnamed4731();
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageCarouselSelect--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageCarouselSelect(
    api.GoogleCloudDialogflowV2beta1IntentMessageCarouselSelect o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageCarouselSelect++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageCarouselSelect < 3) {
    checkUnnamed4731(o.items!);
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
    buildUnnamed4732() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageListSelectItem>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageListSelectItem());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageListSelectItem());
  return o;
}

void checkUnnamed4732(
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
    o.items = buildUnnamed4732();
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
    checkUnnamed4732(o.items!);
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
    buildUnnamed4733() {
  var o = <
      api.GoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject>[];
  o.add(
      buildGoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject());
  o.add(
      buildGoogleCloudDialogflowV2beta1IntentMessageMediaContentResponseMediaObject());
  return o;
}

void checkUnnamed4733(
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
    o.mediaObjects = buildUnnamed4733();
    o.mediaType = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageMediaContent--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageMediaContent(
    api.GoogleCloudDialogflowV2beta1IntentMessageMediaContent o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageMediaContent++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageMediaContent < 3) {
    checkUnnamed4733(o.mediaObjects!);
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

core.List<core.String> buildUnnamed4734() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4734(core.List<core.String> o) {
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
    o.quickReplies = buildUnnamed4734();
    o.title = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageQuickReplies--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageQuickReplies(
    api.GoogleCloudDialogflowV2beta1IntentMessageQuickReplies o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageQuickReplies++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageQuickReplies < 3) {
    checkUnnamed4734(o.quickReplies!);
    unittest.expect(
      o.title!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageQuickReplies--;
}

core.List<api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion>
    buildUnnamed4735() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion());
  return o;
}

void checkUnnamed4735(
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
    o.suggestions = buildUnnamed4735();
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
    checkUnnamed4735(o.suggestions!);
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
    buildUnnamed4736() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageRbmCardContent>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageRbmCardContent());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageRbmCardContent());
  return o;
}

void checkUnnamed4736(
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
    o.cardContents = buildUnnamed4736();
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
    checkUnnamed4736(o.cardContents!);
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
    buildUnnamed4737() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageRbmSuggestion());
  return o;
}

void checkUnnamed4737(
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
    o.rbmSuggestion = buildUnnamed4737();
    o.text = 'foo';
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmText--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageRbmText(
    api.GoogleCloudDialogflowV2beta1IntentMessageRbmText o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmText++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmText < 3) {
    checkUnnamed4737(o.rbmSuggestion!);
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageRbmText--;
}

core.List<core.String> buildUnnamed4738() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4738(core.List<core.String> o) {
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
    o.synonyms = buildUnnamed4738();
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
    checkUnnamed4738(o.synonyms!);
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
    buildUnnamed4739() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageSimpleResponse>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageSimpleResponse());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageSimpleResponse());
  return o;
}

void checkUnnamed4739(
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
    o.simpleResponses = buildUnnamed4739();
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageSimpleResponses--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageSimpleResponses(
    api.GoogleCloudDialogflowV2beta1IntentMessageSimpleResponses o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageSimpleResponses++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageSimpleResponses <
      3) {
    checkUnnamed4739(o.simpleResponses!);
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
    buildUnnamed4740() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageSuggestion>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageSuggestion());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageSuggestion());
  return o;
}

void checkUnnamed4740(
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
    o.suggestions = buildUnnamed4740();
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageSuggestions--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageSuggestions(
    api.GoogleCloudDialogflowV2beta1IntentMessageSuggestions o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageSuggestions++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageSuggestions < 3) {
    checkUnnamed4740(o.suggestions!);
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageSuggestions--;
}

core.List<api.GoogleCloudDialogflowV2beta1IntentMessageBasicCardButton>
    buildUnnamed4741() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageBasicCardButton>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageBasicCardButton());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageBasicCardButton());
  return o;
}

void checkUnnamed4741(
    core.List<api.GoogleCloudDialogflowV2beta1IntentMessageBasicCardButton> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentMessageBasicCardButton(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentMessageBasicCardButton);
  checkGoogleCloudDialogflowV2beta1IntentMessageBasicCardButton(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentMessageBasicCardButton);
}

core.List<api.GoogleCloudDialogflowV2beta1IntentMessageColumnProperties>
    buildUnnamed4742() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageColumnProperties>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageColumnProperties());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageColumnProperties());
  return o;
}

void checkUnnamed4742(
    core.List<api.GoogleCloudDialogflowV2beta1IntentMessageColumnProperties>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentMessageColumnProperties(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentMessageColumnProperties);
  checkGoogleCloudDialogflowV2beta1IntentMessageColumnProperties(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentMessageColumnProperties);
}

core.List<api.GoogleCloudDialogflowV2beta1IntentMessageTableCardRow>
    buildUnnamed4743() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageTableCardRow>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageTableCardRow());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageTableCardRow());
  return o;
}

void checkUnnamed4743(
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
    o.buttons = buildUnnamed4741();
    o.columnProperties = buildUnnamed4742();
    o.image = buildGoogleCloudDialogflowV2beta1IntentMessageImage();
    o.rows = buildUnnamed4743();
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
    checkUnnamed4741(o.buttons!);
    checkUnnamed4742(o.columnProperties!);
    checkGoogleCloudDialogflowV2beta1IntentMessageImage(
        o.image! as api.GoogleCloudDialogflowV2beta1IntentMessageImage);
    checkUnnamed4743(o.rows!);
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
    buildUnnamed4744() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessageTableCardCell>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageTableCardCell());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessageTableCardCell());
  return o;
}

void checkUnnamed4744(
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
    o.cells = buildUnnamed4744();
    o.dividerAfter = true;
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTableCardRow--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageTableCardRow(
    api.GoogleCloudDialogflowV2beta1IntentMessageTableCardRow o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageTableCardRow++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageTableCardRow < 3) {
    checkUnnamed4744(o.cells!);
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

core.List<core.String> buildUnnamed4745() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4745(core.List<core.String> o) {
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
    o.text = buildUnnamed4745();
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageText--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1IntentMessageText(
    api.GoogleCloudDialogflowV2beta1IntentMessageText o) {
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageText++;
  if (buildCounterGoogleCloudDialogflowV2beta1IntentMessageText < 3) {
    checkUnnamed4745(o.text!);
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentMessageText--;
}

core.List<core.String> buildUnnamed4746() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed4746(core.List<core.String> o) {
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
    o.prompts = buildUnnamed4746();
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
    checkUnnamed4746(o.prompts!);
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudDialogflowV2beta1IntentParameter--;
}

core.List<api.GoogleCloudDialogflowV2beta1IntentTrainingPhrasePart>
    buildUnnamed4747() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentTrainingPhrasePart>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentTrainingPhrasePart());
  o.add(buildGoogleCloudDialogflowV2beta1IntentTrainingPhrasePart());
  return o;
}

void checkUnnamed4747(
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
    o.parts = buildUnnamed4747();
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
    checkUnnamed4747(o.parts!);
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
    buildUnnamed4748() {
  var o = <api.GoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer>[];
  o.add(buildGoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer());
  o.add(buildGoogleCloudDialogflowV2beta1KnowledgeAnswersAnswer());
  return o;
}

void checkUnnamed4748(
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
    o.answers = buildUnnamed4748();
  }
  buildCounterGoogleCloudDialogflowV2beta1KnowledgeAnswers--;
  return o;
}

void checkGoogleCloudDialogflowV2beta1KnowledgeAnswers(
    api.GoogleCloudDialogflowV2beta1KnowledgeAnswers o) {
  buildCounterGoogleCloudDialogflowV2beta1KnowledgeAnswers++;
  if (buildCounterGoogleCloudDialogflowV2beta1KnowledgeAnswers < 3) {
    checkUnnamed4748(o.answers!);
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

core.Map<core.String, core.Object> buildUnnamed4749() {
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

void checkUnnamed4749(core.Map<core.String, core.Object> o) {
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

core.int buildCounterGoogleCloudDialogflowV2beta1OriginalDetectIntentRequest =
    0;
api.GoogleCloudDialogflowV2beta1OriginalDetectIntentRequest
    buildGoogleCloudDialogflowV2beta1OriginalDetectIntentRequest() {
  var o = api.GoogleCloudDialogflowV2beta1OriginalDetectIntentRequest();
  buildCounterGoogleCloudDialogflowV2beta1OriginalDetectIntentRequest++;
  if (buildCounterGoogleCloudDialogflowV2beta1OriginalDetectIntentRequest < 3) {
    o.payload = buildUnnamed4749();
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
    checkUnnamed4749(o.payload!);
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

core.Map<core.String, core.Object> buildUnnamed4750() {
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

void checkUnnamed4750(core.Map<core.String, core.Object> o) {
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

core.List<api.GoogleCloudDialogflowV2beta1IntentMessage> buildUnnamed4751() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessage>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessage());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessage());
  return o;
}

void checkUnnamed4751(
    core.List<api.GoogleCloudDialogflowV2beta1IntentMessage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentMessage(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentMessage);
  checkGoogleCloudDialogflowV2beta1IntentMessage(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentMessage);
}

core.List<api.GoogleCloudDialogflowV2beta1Context> buildUnnamed4752() {
  var o = <api.GoogleCloudDialogflowV2beta1Context>[];
  o.add(buildGoogleCloudDialogflowV2beta1Context());
  o.add(buildGoogleCloudDialogflowV2beta1Context());
  return o;
}

void checkUnnamed4752(core.List<api.GoogleCloudDialogflowV2beta1Context> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1Context(
      o[0] as api.GoogleCloudDialogflowV2beta1Context);
  checkGoogleCloudDialogflowV2beta1Context(
      o[1] as api.GoogleCloudDialogflowV2beta1Context);
}

core.Map<core.String, core.Object> buildUnnamed4753() {
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

void checkUnnamed4753(core.Map<core.String, core.Object> o) {
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

core.Map<core.String, core.Object> buildUnnamed4754() {
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

void checkUnnamed4754(core.Map<core.String, core.Object> o) {
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

core.int buildCounterGoogleCloudDialogflowV2beta1QueryResult = 0;
api.GoogleCloudDialogflowV2beta1QueryResult
    buildGoogleCloudDialogflowV2beta1QueryResult() {
  var o = api.GoogleCloudDialogflowV2beta1QueryResult();
  buildCounterGoogleCloudDialogflowV2beta1QueryResult++;
  if (buildCounterGoogleCloudDialogflowV2beta1QueryResult < 3) {
    o.action = 'foo';
    o.allRequiredParamsPresent = true;
    o.diagnosticInfo = buildUnnamed4750();
    o.fulfillmentMessages = buildUnnamed4751();
    o.fulfillmentText = 'foo';
    o.intent = buildGoogleCloudDialogflowV2beta1Intent();
    o.intentDetectionConfidence = 42.0;
    o.knowledgeAnswers = buildGoogleCloudDialogflowV2beta1KnowledgeAnswers();
    o.languageCode = 'foo';
    o.outputContexts = buildUnnamed4752();
    o.parameters = buildUnnamed4753();
    o.queryText = 'foo';
    o.sentimentAnalysisResult =
        buildGoogleCloudDialogflowV2beta1SentimentAnalysisResult();
    o.speechRecognitionConfidence = 42.0;
    o.webhookPayload = buildUnnamed4754();
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
    checkUnnamed4750(o.diagnosticInfo!);
    checkUnnamed4751(o.fulfillmentMessages!);
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
    checkUnnamed4752(o.outputContexts!);
    checkUnnamed4753(o.parameters!);
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
    checkUnnamed4754(o.webhookPayload!);
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

core.List<api.GoogleCloudDialogflowV2beta1EntityTypeEntity> buildUnnamed4755() {
  var o = <api.GoogleCloudDialogflowV2beta1EntityTypeEntity>[];
  o.add(buildGoogleCloudDialogflowV2beta1EntityTypeEntity());
  o.add(buildGoogleCloudDialogflowV2beta1EntityTypeEntity());
  return o;
}

void checkUnnamed4755(
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
    o.entities = buildUnnamed4755();
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
    checkUnnamed4755(o.entities!);
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

core.List<api.GoogleCloudDialogflowV2beta1QueryResult> buildUnnamed4756() {
  var o = <api.GoogleCloudDialogflowV2beta1QueryResult>[];
  o.add(buildGoogleCloudDialogflowV2beta1QueryResult());
  o.add(buildGoogleCloudDialogflowV2beta1QueryResult());
  return o;
}

void checkUnnamed4756(
    core.List<api.GoogleCloudDialogflowV2beta1QueryResult> o) {
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
    o.alternativeQueryResults = buildUnnamed4756();
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
    checkUnnamed4756(o.alternativeQueryResults!);
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

core.List<api.GoogleCloudDialogflowV2beta1IntentMessage> buildUnnamed4757() {
  var o = <api.GoogleCloudDialogflowV2beta1IntentMessage>[];
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessage());
  o.add(buildGoogleCloudDialogflowV2beta1IntentMessage());
  return o;
}

void checkUnnamed4757(
    core.List<api.GoogleCloudDialogflowV2beta1IntentMessage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1IntentMessage(
      o[0] as api.GoogleCloudDialogflowV2beta1IntentMessage);
  checkGoogleCloudDialogflowV2beta1IntentMessage(
      o[1] as api.GoogleCloudDialogflowV2beta1IntentMessage);
}

core.List<api.GoogleCloudDialogflowV2beta1Context> buildUnnamed4758() {
  var o = <api.GoogleCloudDialogflowV2beta1Context>[];
  o.add(buildGoogleCloudDialogflowV2beta1Context());
  o.add(buildGoogleCloudDialogflowV2beta1Context());
  return o;
}

void checkUnnamed4758(core.List<api.GoogleCloudDialogflowV2beta1Context> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudDialogflowV2beta1Context(
      o[0] as api.GoogleCloudDialogflowV2beta1Context);
  checkGoogleCloudDialogflowV2beta1Context(
      o[1] as api.GoogleCloudDialogflowV2beta1Context);
}

core.Map<core.String, core.Object> buildUnnamed4759() {
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

void checkUnnamed4759(core.Map<core.String, core.Object> o) {
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

core.List<api.GoogleCloudDialogflowV2beta1SessionEntityType>
    buildUnnamed4760() {
  var o = <api.GoogleCloudDialogflowV2beta1SessionEntityType>[];
  o.add(buildGoogleCloudDialogflowV2beta1SessionEntityType());
  o.add(buildGoogleCloudDialogflowV2beta1SessionEntityType());
  return o;
}

void checkUnnamed4760(
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
    o.fulfillmentMessages = buildUnnamed4757();
    o.fulfillmentText = 'foo';
    o.outputContexts = buildUnnamed4758();
    o.payload = buildUnnamed4759();
    o.sessionEntityTypes = buildUnnamed4760();
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
    checkUnnamed4757(o.fulfillmentMessages!);
    unittest.expect(
      o.fulfillmentText!,
      unittest.equals('foo'),
    );
    checkUnnamed4758(o.outputContexts!);
    checkUnnamed4759(o.payload!);
    checkUnnamed4760(o.sessionEntityTypes!);
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

core.List<api.GoogleRpcStatus> buildUnnamed4761() {
  var o = <api.GoogleRpcStatus>[];
  o.add(buildGoogleRpcStatus());
  o.add(buildGoogleRpcStatus());
  return o;
}

void checkUnnamed4761(core.List<api.GoogleRpcStatus> o) {
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
    o.warnings = buildUnnamed4761();
  }
  buildCounterGoogleCloudDialogflowV3alpha1ImportDocumentsResponse--;
  return o;
}

void checkGoogleCloudDialogflowV3alpha1ImportDocumentsResponse(
    api.GoogleCloudDialogflowV3alpha1ImportDocumentsResponse o) {
  buildCounterGoogleCloudDialogflowV3alpha1ImportDocumentsResponse++;
  if (buildCounterGoogleCloudDialogflowV3alpha1ImportDocumentsResponse < 3) {
    checkUnnamed4761(o.warnings!);
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

core.List<api.GoogleLongrunningOperation> buildUnnamed4762() {
  var o = <api.GoogleLongrunningOperation>[];
  o.add(buildGoogleLongrunningOperation());
  o.add(buildGoogleLongrunningOperation());
  return o;
}

void checkUnnamed4762(core.List<api.GoogleLongrunningOperation> o) {
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
    o.operations = buildUnnamed4762();
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
    checkUnnamed4762(o.operations!);
  }
  buildCounterGoogleLongrunningListOperationsResponse--;
}

core.Map<core.String, core.Object> buildUnnamed4763() {
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

void checkUnnamed4763(core.Map<core.String, core.Object> o) {
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

core.Map<core.String, core.Object> buildUnnamed4764() {
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

void checkUnnamed4764(core.Map<core.String, core.Object> o) {
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

core.int buildCounterGoogleLongrunningOperation = 0;
api.GoogleLongrunningOperation buildGoogleLongrunningOperation() {
  var o = api.GoogleLongrunningOperation();
  buildCounterGoogleLongrunningOperation++;
  if (buildCounterGoogleLongrunningOperation < 3) {
    o.done = true;
    o.error = buildGoogleRpcStatus();
    o.metadata = buildUnnamed4763();
    o.name = 'foo';
    o.response = buildUnnamed4764();
  }
  buildCounterGoogleLongrunningOperation--;
  return o;
}

void checkGoogleLongrunningOperation(api.GoogleLongrunningOperation o) {
  buildCounterGoogleLongrunningOperation++;
  if (buildCounterGoogleLongrunningOperation < 3) {
    unittest.expect(o.done!, unittest.isTrue);
    checkGoogleRpcStatus(o.error! as api.GoogleRpcStatus);
    checkUnnamed4763(o.metadata!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed4764(o.response!);
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

core.Map<core.String, core.Object> buildUnnamed4765() {
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

void checkUnnamed4765(core.Map<core.String, core.Object> o) {
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

core.List<core.Map<core.String, core.Object>> buildUnnamed4766() {
  var o = <core.Map<core.String, core.Object>>[];
  o.add(buildUnnamed4765());
  o.add(buildUnnamed4765());
  return o;
}

void checkUnnamed4766(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed4765(o[0]);
  checkUnnamed4765(o[1]);
}

core.int buildCounterGoogleRpcStatus = 0;
api.GoogleRpcStatus buildGoogleRpcStatus() {
  var o = api.GoogleRpcStatus();
  buildCounterGoogleRpcStatus++;
  if (buildCounterGoogleRpcStatus < 3) {
    o.code = 42;
    o.details = buildUnnamed4766();
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
    checkUnnamed4766(o.details!);
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

  unittest.group('obj-schema-GoogleCloudDialogflowV2Agent', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2Agent();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2Agent.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2Agent(od as api.GoogleCloudDialogflowV2Agent);
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

  unittest.group('obj-schema-GoogleCloudDialogflowV2BatchCreateEntitiesRequest',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2BatchCreateEntitiesRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2BatchCreateEntitiesRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2BatchCreateEntitiesRequest(
          od as api.GoogleCloudDialogflowV2BatchCreateEntitiesRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2BatchDeleteEntitiesRequest',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2BatchDeleteEntitiesRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2BatchDeleteEntitiesRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2BatchDeleteEntitiesRequest(
          od as api.GoogleCloudDialogflowV2BatchDeleteEntitiesRequest);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2BatchDeleteEntityTypesRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2BatchDeleteEntityTypesRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2BatchDeleteEntityTypesRequest.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2BatchDeleteEntityTypesRequest(
          od as api.GoogleCloudDialogflowV2BatchDeleteEntityTypesRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2BatchDeleteIntentsRequest',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2BatchDeleteIntentsRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2BatchDeleteIntentsRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2BatchDeleteIntentsRequest(
          od as api.GoogleCloudDialogflowV2BatchDeleteIntentsRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2BatchUpdateEntitiesRequest',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2BatchUpdateEntitiesRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2BatchUpdateEntitiesRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2BatchUpdateEntitiesRequest(
          od as api.GoogleCloudDialogflowV2BatchUpdateEntitiesRequest);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2BatchUpdateEntityTypesRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2BatchUpdateEntityTypesRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2BatchUpdateEntityTypesRequest.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2BatchUpdateEntityTypesRequest(
          od as api.GoogleCloudDialogflowV2BatchUpdateEntityTypesRequest);
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

  unittest.group('obj-schema-GoogleCloudDialogflowV2BatchUpdateIntentsRequest',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2BatchUpdateIntentsRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2BatchUpdateIntentsRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2BatchUpdateIntentsRequest(
          od as api.GoogleCloudDialogflowV2BatchUpdateIntentsRequest);
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

  unittest.group('obj-schema-GoogleCloudDialogflowV2DetectIntentRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2DetectIntentRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2DetectIntentRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2DetectIntentRequest(
          od as api.GoogleCloudDialogflowV2DetectIntentRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2DetectIntentResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2DetectIntentResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2DetectIntentResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2DetectIntentResponse(
          od as api.GoogleCloudDialogflowV2DetectIntentResponse);
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

  unittest.group('obj-schema-GoogleCloudDialogflowV2EntityTypeBatch', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2EntityTypeBatch();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2EntityTypeBatch.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2EntityTypeBatch(
          od as api.GoogleCloudDialogflowV2EntityTypeBatch);
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

  unittest.group('obj-schema-GoogleCloudDialogflowV2Environment', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2Environment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2Environment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2Environment(
          od as api.GoogleCloudDialogflowV2Environment);
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

  unittest.group('obj-schema-GoogleCloudDialogflowV2ExportAgentRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2ExportAgentRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2ExportAgentRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2ExportAgentRequest(
          od as api.GoogleCloudDialogflowV2ExportAgentRequest);
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

  unittest.group('obj-schema-GoogleCloudDialogflowV2Fulfillment', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2Fulfillment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2Fulfillment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2Fulfillment(
          od as api.GoogleCloudDialogflowV2Fulfillment);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2FulfillmentFeature', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2FulfillmentFeature();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2FulfillmentFeature.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2FulfillmentFeature(
          od as api.GoogleCloudDialogflowV2FulfillmentFeature);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2FulfillmentGenericWebService', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2FulfillmentGenericWebService();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2FulfillmentGenericWebService.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2FulfillmentGenericWebService(
          od as api.GoogleCloudDialogflowV2FulfillmentGenericWebService);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2ImportAgentRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2ImportAgentRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2ImportAgentRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2ImportAgentRequest(
          od as api.GoogleCloudDialogflowV2ImportAgentRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2InputAudioConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2InputAudioConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2InputAudioConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2InputAudioConfig(
          od as api.GoogleCloudDialogflowV2InputAudioConfig);
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

  unittest.group('obj-schema-GoogleCloudDialogflowV2IntentBatch', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2IntentBatch();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2IntentBatch.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2IntentBatch(
          od as api.GoogleCloudDialogflowV2IntentBatch);
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

  unittest.group('obj-schema-GoogleCloudDialogflowV2ListContextsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2ListContextsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2ListContextsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2ListContextsResponse(
          od as api.GoogleCloudDialogflowV2ListContextsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2ListEntityTypesResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2ListEntityTypesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2ListEntityTypesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2ListEntityTypesResponse(
          od as api.GoogleCloudDialogflowV2ListEntityTypesResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2ListEnvironmentsResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2ListEnvironmentsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2ListEnvironmentsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2ListEnvironmentsResponse(
          od as api.GoogleCloudDialogflowV2ListEnvironmentsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2ListIntentsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2ListIntentsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2ListIntentsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2ListIntentsResponse(
          od as api.GoogleCloudDialogflowV2ListIntentsResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2ListSessionEntityTypesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2ListSessionEntityTypesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2ListSessionEntityTypesResponse.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2ListSessionEntityTypesResponse(
          od as api.GoogleCloudDialogflowV2ListSessionEntityTypesResponse);
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

  unittest.group('obj-schema-GoogleCloudDialogflowV2OutputAudioConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2OutputAudioConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2OutputAudioConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2OutputAudioConfig(
          od as api.GoogleCloudDialogflowV2OutputAudioConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2QueryInput', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2QueryInput();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2QueryInput.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2QueryInput(
          od as api.GoogleCloudDialogflowV2QueryInput);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2QueryParameters', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2QueryParameters();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2QueryParameters.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2QueryParameters(
          od as api.GoogleCloudDialogflowV2QueryParameters);
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

  unittest.group('obj-schema-GoogleCloudDialogflowV2RestoreAgentRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2RestoreAgentRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2RestoreAgentRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2RestoreAgentRequest(
          od as api.GoogleCloudDialogflowV2RestoreAgentRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2SearchAgentsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2SearchAgentsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2SearchAgentsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2SearchAgentsResponse(
          od as api.GoogleCloudDialogflowV2SearchAgentsResponse);
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

  unittest.group(
      'obj-schema-GoogleCloudDialogflowV2SentimentAnalysisRequestConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2SentimentAnalysisRequestConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudDialogflowV2SentimentAnalysisRequestConfig.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2SentimentAnalysisRequestConfig(
          od as api.GoogleCloudDialogflowV2SentimentAnalysisRequestConfig);
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

  unittest.group('obj-schema-GoogleCloudDialogflowV2SpeechContext', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2SpeechContext();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2SpeechContext.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2SpeechContext(
          od as api.GoogleCloudDialogflowV2SpeechContext);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2SynthesizeSpeechConfig',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2SynthesizeSpeechConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2SynthesizeSpeechConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2SynthesizeSpeechConfig(
          od as api.GoogleCloudDialogflowV2SynthesizeSpeechConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2TextInput', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2TextInput();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2TextInput.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2TextInput(
          od as api.GoogleCloudDialogflowV2TextInput);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2TrainAgentRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2TrainAgentRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2TrainAgentRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2TrainAgentRequest(
          od as api.GoogleCloudDialogflowV2TrainAgentRequest);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2ValidationError', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2ValidationError();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2ValidationError.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2ValidationError(
          od as api.GoogleCloudDialogflowV2ValidationError);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2ValidationResult', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2ValidationResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2ValidationResult.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2ValidationResult(
          od as api.GoogleCloudDialogflowV2ValidationResult);
    });
  });

  unittest.group('obj-schema-GoogleCloudDialogflowV2VoiceSelectionParams', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudDialogflowV2VoiceSelectionParams();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudDialogflowV2VoiceSelectionParams.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudDialogflowV2VoiceSelectionParams(
          od as api.GoogleCloudDialogflowV2VoiceSelectionParams);
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

  unittest.group('resource-ProjectsResource', () {
    unittest.test('method--deleteAgent', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects;
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
      final response = await res.deleteAgent(arg_parent, $fields: arg_$fields);
      checkGoogleProtobufEmpty(response as api.GoogleProtobufEmpty);
    });

    unittest.test('method--getAgent', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects;
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
        var resp = convert.json.encode(buildGoogleCloudDialogflowV2Agent());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.getAgent(arg_parent, $fields: arg_$fields);
      checkGoogleCloudDialogflowV2Agent(
          response as api.GoogleCloudDialogflowV2Agent);
    });

    unittest.test('method--setAgent', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects;
      var arg_request = buildGoogleCloudDialogflowV2Agent();
      var arg_parent = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowV2Agent.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2Agent(
            obj as api.GoogleCloudDialogflowV2Agent);

        var path = (req.url).path;
        var pathOffset = 0;
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
        var resp = convert.json.encode(buildGoogleCloudDialogflowV2Agent());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.setAgent(arg_request, arg_parent,
          updateMask: arg_updateMask, $fields: arg_$fields);
      checkGoogleCloudDialogflowV2Agent(
          response as api.GoogleCloudDialogflowV2Agent);
    });
  });

  unittest.group('resource-ProjectsAgentResource', () {
    unittest.test('method--export', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent;
      var arg_request = buildGoogleCloudDialogflowV2ExportAgentRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowV2ExportAgentRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2ExportAgentRequest(
            obj as api.GoogleCloudDialogflowV2ExportAgentRequest);

        var path = (req.url).path;
        var pathOffset = 0;
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
          await res.export(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--getFulfillment', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent;
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
        var resp =
            convert.json.encode(buildGoogleCloudDialogflowV2Fulfillment());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.getFulfillment(arg_name, $fields: arg_$fields);
      checkGoogleCloudDialogflowV2Fulfillment(
          response as api.GoogleCloudDialogflowV2Fulfillment);
    });

    unittest.test('method--getValidationResult', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent;
      var arg_parent = 'foo';
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
            convert.json.encode(buildGoogleCloudDialogflowV2ValidationResult());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.getValidationResult(arg_parent,
          languageCode: arg_languageCode, $fields: arg_$fields);
      checkGoogleCloudDialogflowV2ValidationResult(
          response as api.GoogleCloudDialogflowV2ValidationResult);
    });

    unittest.test('method--import', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent;
      var arg_request = buildGoogleCloudDialogflowV2ImportAgentRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowV2ImportAgentRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2ImportAgentRequest(
            obj as api.GoogleCloudDialogflowV2ImportAgentRequest);

        var path = (req.url).path;
        var pathOffset = 0;
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

    unittest.test('method--restore', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent;
      var arg_request = buildGoogleCloudDialogflowV2RestoreAgentRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowV2RestoreAgentRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2RestoreAgentRequest(
            obj as api.GoogleCloudDialogflowV2RestoreAgentRequest);

        var path = (req.url).path;
        var pathOffset = 0;
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
          await res.restore(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--search', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent;
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
        var resp = convert.json
            .encode(buildGoogleCloudDialogflowV2SearchAgentsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.search(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowV2SearchAgentsResponse(
          response as api.GoogleCloudDialogflowV2SearchAgentsResponse);
    });

    unittest.test('method--train', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent;
      var arg_request = buildGoogleCloudDialogflowV2TrainAgentRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowV2TrainAgentRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2TrainAgentRequest(
            obj as api.GoogleCloudDialogflowV2TrainAgentRequest);

        var path = (req.url).path;
        var pathOffset = 0;
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
          await res.train(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--updateFulfillment', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent;
      var arg_request = buildGoogleCloudDialogflowV2Fulfillment();
      var arg_name = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowV2Fulfillment.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2Fulfillment(
            obj as api.GoogleCloudDialogflowV2Fulfillment);

        var path = (req.url).path;
        var pathOffset = 0;
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
        var resp =
            convert.json.encode(buildGoogleCloudDialogflowV2Fulfillment());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.updateFulfillment(arg_request, arg_name,
          updateMask: arg_updateMask, $fields: arg_$fields);
      checkGoogleCloudDialogflowV2Fulfillment(
          response as api.GoogleCloudDialogflowV2Fulfillment);
    });
  });

  unittest.group('resource-ProjectsAgentEntityTypesResource', () {
    unittest.test('method--batchDelete', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.entityTypes;
      var arg_request =
          buildGoogleCloudDialogflowV2BatchDeleteEntityTypesRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj =
            api.GoogleCloudDialogflowV2BatchDeleteEntityTypesRequest.fromJson(
                json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2BatchDeleteEntityTypesRequest(
            obj as api.GoogleCloudDialogflowV2BatchDeleteEntityTypesRequest);

        var path = (req.url).path;
        var pathOffset = 0;
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
          await res.batchDelete(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--batchUpdate', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.entityTypes;
      var arg_request =
          buildGoogleCloudDialogflowV2BatchUpdateEntityTypesRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj =
            api.GoogleCloudDialogflowV2BatchUpdateEntityTypesRequest.fromJson(
                json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2BatchUpdateEntityTypesRequest(
            obj as api.GoogleCloudDialogflowV2BatchUpdateEntityTypesRequest);

        var path = (req.url).path;
        var pathOffset = 0;
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
          await res.batchUpdate(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.entityTypes;
      var arg_request = buildGoogleCloudDialogflowV2EntityType();
      var arg_parent = 'foo';
      var arg_languageCode = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowV2EntityType.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2EntityType(
            obj as api.GoogleCloudDialogflowV2EntityType);

        var path = (req.url).path;
        var pathOffset = 0;
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
            convert.json.encode(buildGoogleCloudDialogflowV2EntityType());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.create(arg_request, arg_parent,
          languageCode: arg_languageCode, $fields: arg_$fields);
      checkGoogleCloudDialogflowV2EntityType(
          response as api.GoogleCloudDialogflowV2EntityType);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.entityTypes;
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
      var res = api.DialogflowApi(mock).projects.agent.entityTypes;
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
            convert.json.encode(buildGoogleCloudDialogflowV2EntityType());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name,
          languageCode: arg_languageCode, $fields: arg_$fields);
      checkGoogleCloudDialogflowV2EntityType(
          response as api.GoogleCloudDialogflowV2EntityType);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.entityTypes;
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
            .encode(buildGoogleCloudDialogflowV2ListEntityTypesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          languageCode: arg_languageCode,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowV2ListEntityTypesResponse(
          response as api.GoogleCloudDialogflowV2ListEntityTypesResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.entityTypes;
      var arg_request = buildGoogleCloudDialogflowV2EntityType();
      var arg_name = 'foo';
      var arg_languageCode = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowV2EntityType.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2EntityType(
            obj as api.GoogleCloudDialogflowV2EntityType);

        var path = (req.url).path;
        var pathOffset = 0;
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
            convert.json.encode(buildGoogleCloudDialogflowV2EntityType());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          languageCode: arg_languageCode,
          updateMask: arg_updateMask,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowV2EntityType(
          response as api.GoogleCloudDialogflowV2EntityType);
    });
  });

  unittest.group('resource-ProjectsAgentEntityTypesEntitiesResource', () {
    unittest.test('method--batchCreate', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.entityTypes.entities;
      var arg_request =
          buildGoogleCloudDialogflowV2BatchCreateEntitiesRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj =
            api.GoogleCloudDialogflowV2BatchCreateEntitiesRequest.fromJson(
                json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2BatchCreateEntitiesRequest(
            obj as api.GoogleCloudDialogflowV2BatchCreateEntitiesRequest);

        var path = (req.url).path;
        var pathOffset = 0;
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
          await res.batchCreate(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--batchDelete', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.entityTypes.entities;
      var arg_request =
          buildGoogleCloudDialogflowV2BatchDeleteEntitiesRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj =
            api.GoogleCloudDialogflowV2BatchDeleteEntitiesRequest.fromJson(
                json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2BatchDeleteEntitiesRequest(
            obj as api.GoogleCloudDialogflowV2BatchDeleteEntitiesRequest);

        var path = (req.url).path;
        var pathOffset = 0;
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
          await res.batchDelete(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--batchUpdate', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.entityTypes.entities;
      var arg_request =
          buildGoogleCloudDialogflowV2BatchUpdateEntitiesRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj =
            api.GoogleCloudDialogflowV2BatchUpdateEntitiesRequest.fromJson(
                json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2BatchUpdateEntitiesRequest(
            obj as api.GoogleCloudDialogflowV2BatchUpdateEntitiesRequest);

        var path = (req.url).path;
        var pathOffset = 0;
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
          await res.batchUpdate(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });
  });

  unittest.group('resource-ProjectsAgentEnvironmentsResource', () {
    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.environments;
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
        var resp = convert.json
            .encode(buildGoogleCloudDialogflowV2ListEnvironmentsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowV2ListEnvironmentsResponse(
          response as api.GoogleCloudDialogflowV2ListEnvironmentsResponse);
    });
  });

  unittest.group('resource-ProjectsAgentEnvironmentsIntentsResource', () {
    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.environments.intents;
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
            .encode(buildGoogleCloudDialogflowV2ListIntentsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          intentView: arg_intentView,
          languageCode: arg_languageCode,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowV2ListIntentsResponse(
          response as api.GoogleCloudDialogflowV2ListIntentsResponse);
    });
  });

  unittest.group('resource-ProjectsAgentEnvironmentsUsersSessionsResource', () {
    unittest.test('method--deleteContexts', () async {
      var mock = HttpServerMock();
      var res =
          api.DialogflowApi(mock).projects.agent.environments.users.sessions;
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
      final response =
          await res.deleteContexts(arg_parent, $fields: arg_$fields);
      checkGoogleProtobufEmpty(response as api.GoogleProtobufEmpty);
    });

    unittest.test('method--detectIntent', () async {
      var mock = HttpServerMock();
      var res =
          api.DialogflowApi(mock).projects.agent.environments.users.sessions;
      var arg_request = buildGoogleCloudDialogflowV2DetectIntentRequest();
      var arg_session = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowV2DetectIntentRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2DetectIntentRequest(
            obj as api.GoogleCloudDialogflowV2DetectIntentRequest);

        var path = (req.url).path;
        var pathOffset = 0;
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
        var resp = convert.json
            .encode(buildGoogleCloudDialogflowV2DetectIntentResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.detectIntent(arg_request, arg_session,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowV2DetectIntentResponse(
          response as api.GoogleCloudDialogflowV2DetectIntentResponse);
    });
  });

  unittest.group(
      'resource-ProjectsAgentEnvironmentsUsersSessionsContextsResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .agent
          .environments
          .users
          .sessions
          .contexts;
      var arg_request = buildGoogleCloudDialogflowV2Context();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowV2Context.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2Context(
            obj as api.GoogleCloudDialogflowV2Context);

        var path = (req.url).path;
        var pathOffset = 0;
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
        var resp = convert.json.encode(buildGoogleCloudDialogflowV2Context());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudDialogflowV2Context(
          response as api.GoogleCloudDialogflowV2Context);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .agent
          .environments
          .users
          .sessions
          .contexts;
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
      var res = api.DialogflowApi(mock)
          .projects
          .agent
          .environments
          .users
          .sessions
          .contexts;
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
        var resp = convert.json.encode(buildGoogleCloudDialogflowV2Context());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudDialogflowV2Context(
          response as api.GoogleCloudDialogflowV2Context);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .agent
          .environments
          .users
          .sessions
          .contexts;
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
        var resp = convert.json
            .encode(buildGoogleCloudDialogflowV2ListContextsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowV2ListContextsResponse(
          response as api.GoogleCloudDialogflowV2ListContextsResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .agent
          .environments
          .users
          .sessions
          .contexts;
      var arg_request = buildGoogleCloudDialogflowV2Context();
      var arg_name = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowV2Context.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2Context(
            obj as api.GoogleCloudDialogflowV2Context);

        var path = (req.url).path;
        var pathOffset = 0;
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
        var resp = convert.json.encode(buildGoogleCloudDialogflowV2Context());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          updateMask: arg_updateMask, $fields: arg_$fields);
      checkGoogleCloudDialogflowV2Context(
          response as api.GoogleCloudDialogflowV2Context);
    });
  });

  unittest.group(
      'resource-ProjectsAgentEnvironmentsUsersSessionsEntityTypesResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .agent
          .environments
          .users
          .sessions
          .entityTypes;
      var arg_request = buildGoogleCloudDialogflowV2SessionEntityType();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowV2SessionEntityType.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2SessionEntityType(
            obj as api.GoogleCloudDialogflowV2SessionEntityType);

        var path = (req.url).path;
        var pathOffset = 0;
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
        var resp = convert.json
            .encode(buildGoogleCloudDialogflowV2SessionEntityType());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudDialogflowV2SessionEntityType(
          response as api.GoogleCloudDialogflowV2SessionEntityType);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .agent
          .environments
          .users
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
      var res = api.DialogflowApi(mock)
          .projects
          .agent
          .environments
          .users
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
        var resp = convert.json
            .encode(buildGoogleCloudDialogflowV2SessionEntityType());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudDialogflowV2SessionEntityType(
          response as api.GoogleCloudDialogflowV2SessionEntityType);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .agent
          .environments
          .users
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
        var resp = convert.json.encode(
            buildGoogleCloudDialogflowV2ListSessionEntityTypesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowV2ListSessionEntityTypesResponse(response
          as api.GoogleCloudDialogflowV2ListSessionEntityTypesResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock)
          .projects
          .agent
          .environments
          .users
          .sessions
          .entityTypes;
      var arg_request = buildGoogleCloudDialogflowV2SessionEntityType();
      var arg_name = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowV2SessionEntityType.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2SessionEntityType(
            obj as api.GoogleCloudDialogflowV2SessionEntityType);

        var path = (req.url).path;
        var pathOffset = 0;
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
        var resp = convert.json
            .encode(buildGoogleCloudDialogflowV2SessionEntityType());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          updateMask: arg_updateMask, $fields: arg_$fields);
      checkGoogleCloudDialogflowV2SessionEntityType(
          response as api.GoogleCloudDialogflowV2SessionEntityType);
    });
  });

  unittest.group('resource-ProjectsAgentIntentsResource', () {
    unittest.test('method--batchDelete', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.intents;
      var arg_request = buildGoogleCloudDialogflowV2BatchDeleteIntentsRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowV2BatchDeleteIntentsRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2BatchDeleteIntentsRequest(
            obj as api.GoogleCloudDialogflowV2BatchDeleteIntentsRequest);

        var path = (req.url).path;
        var pathOffset = 0;
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
          await res.batchDelete(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--batchUpdate', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.intents;
      var arg_request = buildGoogleCloudDialogflowV2BatchUpdateIntentsRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowV2BatchUpdateIntentsRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2BatchUpdateIntentsRequest(
            obj as api.GoogleCloudDialogflowV2BatchUpdateIntentsRequest);

        var path = (req.url).path;
        var pathOffset = 0;
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
          await res.batchUpdate(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });

    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.intents;
      var arg_request = buildGoogleCloudDialogflowV2Intent();
      var arg_parent = 'foo';
      var arg_intentView = 'foo';
      var arg_languageCode = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowV2Intent.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2Intent(
            obj as api.GoogleCloudDialogflowV2Intent);

        var path = (req.url).path;
        var pathOffset = 0;
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
          queryMap["intentView"]!.first,
          unittest.equals(arg_intentView),
        );
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
        var resp = convert.json.encode(buildGoogleCloudDialogflowV2Intent());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.create(arg_request, arg_parent,
          intentView: arg_intentView,
          languageCode: arg_languageCode,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowV2Intent(
          response as api.GoogleCloudDialogflowV2Intent);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.intents;
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
      var res = api.DialogflowApi(mock).projects.agent.intents;
      var arg_name = 'foo';
      var arg_intentView = 'foo';
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
          queryMap["intentView"]!.first,
          unittest.equals(arg_intentView),
        );
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
        var resp = convert.json.encode(buildGoogleCloudDialogflowV2Intent());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name,
          intentView: arg_intentView,
          languageCode: arg_languageCode,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowV2Intent(
          response as api.GoogleCloudDialogflowV2Intent);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.intents;
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
            .encode(buildGoogleCloudDialogflowV2ListIntentsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          intentView: arg_intentView,
          languageCode: arg_languageCode,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowV2ListIntentsResponse(
          response as api.GoogleCloudDialogflowV2ListIntentsResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.intents;
      var arg_request = buildGoogleCloudDialogflowV2Intent();
      var arg_name = 'foo';
      var arg_intentView = 'foo';
      var arg_languageCode = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowV2Intent.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2Intent(
            obj as api.GoogleCloudDialogflowV2Intent);

        var path = (req.url).path;
        var pathOffset = 0;
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
          queryMap["intentView"]!.first,
          unittest.equals(arg_intentView),
        );
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
        var resp = convert.json.encode(buildGoogleCloudDialogflowV2Intent());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          intentView: arg_intentView,
          languageCode: arg_languageCode,
          updateMask: arg_updateMask,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowV2Intent(
          response as api.GoogleCloudDialogflowV2Intent);
    });
  });

  unittest.group('resource-ProjectsAgentSessionsResource', () {
    unittest.test('method--deleteContexts', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.sessions;
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
      final response =
          await res.deleteContexts(arg_parent, $fields: arg_$fields);
      checkGoogleProtobufEmpty(response as api.GoogleProtobufEmpty);
    });

    unittest.test('method--detectIntent', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.sessions;
      var arg_request = buildGoogleCloudDialogflowV2DetectIntentRequest();
      var arg_session = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowV2DetectIntentRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2DetectIntentRequest(
            obj as api.GoogleCloudDialogflowV2DetectIntentRequest);

        var path = (req.url).path;
        var pathOffset = 0;
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
        var resp = convert.json
            .encode(buildGoogleCloudDialogflowV2DetectIntentResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.detectIntent(arg_request, arg_session,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowV2DetectIntentResponse(
          response as api.GoogleCloudDialogflowV2DetectIntentResponse);
    });
  });

  unittest.group('resource-ProjectsAgentSessionsContextsResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.sessions.contexts;
      var arg_request = buildGoogleCloudDialogflowV2Context();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowV2Context.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2Context(
            obj as api.GoogleCloudDialogflowV2Context);

        var path = (req.url).path;
        var pathOffset = 0;
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
        var resp = convert.json.encode(buildGoogleCloudDialogflowV2Context());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudDialogflowV2Context(
          response as api.GoogleCloudDialogflowV2Context);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.sessions.contexts;
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
      var res = api.DialogflowApi(mock).projects.agent.sessions.contexts;
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
        var resp = convert.json.encode(buildGoogleCloudDialogflowV2Context());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudDialogflowV2Context(
          response as api.GoogleCloudDialogflowV2Context);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.sessions.contexts;
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
        var resp = convert.json
            .encode(buildGoogleCloudDialogflowV2ListContextsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowV2ListContextsResponse(
          response as api.GoogleCloudDialogflowV2ListContextsResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.sessions.contexts;
      var arg_request = buildGoogleCloudDialogflowV2Context();
      var arg_name = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowV2Context.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2Context(
            obj as api.GoogleCloudDialogflowV2Context);

        var path = (req.url).path;
        var pathOffset = 0;
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
        var resp = convert.json.encode(buildGoogleCloudDialogflowV2Context());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          updateMask: arg_updateMask, $fields: arg_$fields);
      checkGoogleCloudDialogflowV2Context(
          response as api.GoogleCloudDialogflowV2Context);
    });
  });

  unittest.group('resource-ProjectsAgentSessionsEntityTypesResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.sessions.entityTypes;
      var arg_request = buildGoogleCloudDialogflowV2SessionEntityType();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowV2SessionEntityType.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2SessionEntityType(
            obj as api.GoogleCloudDialogflowV2SessionEntityType);

        var path = (req.url).path;
        var pathOffset = 0;
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
        var resp = convert.json
            .encode(buildGoogleCloudDialogflowV2SessionEntityType());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.create(arg_request, arg_parent, $fields: arg_$fields);
      checkGoogleCloudDialogflowV2SessionEntityType(
          response as api.GoogleCloudDialogflowV2SessionEntityType);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.sessions.entityTypes;
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
      var res = api.DialogflowApi(mock).projects.agent.sessions.entityTypes;
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
        var resp = convert.json
            .encode(buildGoogleCloudDialogflowV2SessionEntityType());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkGoogleCloudDialogflowV2SessionEntityType(
          response as api.GoogleCloudDialogflowV2SessionEntityType);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.sessions.entityTypes;
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
        var resp = convert.json.encode(
            buildGoogleCloudDialogflowV2ListSessionEntityTypesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkGoogleCloudDialogflowV2ListSessionEntityTypesResponse(response
          as api.GoogleCloudDialogflowV2ListSessionEntityTypesResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.DialogflowApi(mock).projects.agent.sessions.entityTypes;
      var arg_request = buildGoogleCloudDialogflowV2SessionEntityType();
      var arg_name = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleCloudDialogflowV2SessionEntityType.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudDialogflowV2SessionEntityType(
            obj as api.GoogleCloudDialogflowV2SessionEntityType);

        var path = (req.url).path;
        var pathOffset = 0;
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
        var resp = convert.json
            .encode(buildGoogleCloudDialogflowV2SessionEntityType());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          updateMask: arg_updateMask, $fields: arg_$fields);
      checkGoogleCloudDialogflowV2SessionEntityType(
          response as api.GoogleCloudDialogflowV2SessionEntityType);
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
