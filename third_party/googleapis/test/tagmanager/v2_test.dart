library googleapis.tagmanager.v2.test;

import "dart:core" as core;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:test/test.dart' as unittest;

import 'package:googleapis/tagmanager/v2.dart' as api;

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

core.int buildCounterAccount = 0;
buildAccount() {
  var o = new api.Account();
  buildCounterAccount++;
  if (buildCounterAccount < 3) {
    o.accountId = "foo";
    o.fingerprint = "foo";
    o.name = "foo";
    o.path = "foo";
    o.shareData = true;
    o.tagManagerUrl = "foo";
  }
  buildCounterAccount--;
  return o;
}

checkAccount(api.Account o) {
  buildCounterAccount++;
  if (buildCounterAccount < 3) {
    unittest.expect(o.accountId, unittest.equals('foo'));
    unittest.expect(o.fingerprint, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.path, unittest.equals('foo'));
    unittest.expect(o.shareData, unittest.isTrue);
    unittest.expect(o.tagManagerUrl, unittest.equals('foo'));
  }
  buildCounterAccount--;
}

core.int buildCounterAccountAccess = 0;
buildAccountAccess() {
  var o = new api.AccountAccess();
  buildCounterAccountAccess++;
  if (buildCounterAccountAccess < 3) {
    o.permission = "foo";
  }
  buildCounterAccountAccess--;
  return o;
}

checkAccountAccess(api.AccountAccess o) {
  buildCounterAccountAccess++;
  if (buildCounterAccountAccess < 3) {
    unittest.expect(o.permission, unittest.equals('foo'));
  }
  buildCounterAccountAccess--;
}

core.int buildCounterBuiltInVariable = 0;
buildBuiltInVariable() {
  var o = new api.BuiltInVariable();
  buildCounterBuiltInVariable++;
  if (buildCounterBuiltInVariable < 3) {
    o.accountId = "foo";
    o.containerId = "foo";
    o.name = "foo";
    o.path = "foo";
    o.type = "foo";
    o.workspaceId = "foo";
  }
  buildCounterBuiltInVariable--;
  return o;
}

checkBuiltInVariable(api.BuiltInVariable o) {
  buildCounterBuiltInVariable++;
  if (buildCounterBuiltInVariable < 3) {
    unittest.expect(o.accountId, unittest.equals('foo'));
    unittest.expect(o.containerId, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.path, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
    unittest.expect(o.workspaceId, unittest.equals('foo'));
  }
  buildCounterBuiltInVariable--;
}

buildUnnamed1621() {
  var o = new core.List<api.Parameter>();
  o.add(buildParameter());
  o.add(buildParameter());
  return o;
}

checkUnnamed1621(core.List<api.Parameter> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkParameter(o[0]);
  checkParameter(o[1]);
}

core.int buildCounterCondition = 0;
buildCondition() {
  var o = new api.Condition();
  buildCounterCondition++;
  if (buildCounterCondition < 3) {
    o.parameter = buildUnnamed1621();
    o.type = "foo";
  }
  buildCounterCondition--;
  return o;
}

checkCondition(api.Condition o) {
  buildCounterCondition++;
  if (buildCounterCondition < 3) {
    checkUnnamed1621(o.parameter);
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterCondition--;
}

buildUnnamed1622() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1622(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1623() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1623(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterContainer = 0;
buildContainer() {
  var o = new api.Container();
  buildCounterContainer++;
  if (buildCounterContainer < 3) {
    o.accountId = "foo";
    o.containerId = "foo";
    o.domainName = buildUnnamed1622();
    o.fingerprint = "foo";
    o.name = "foo";
    o.notes = "foo";
    o.path = "foo";
    o.publicId = "foo";
    o.tagManagerUrl = "foo";
    o.usageContext = buildUnnamed1623();
  }
  buildCounterContainer--;
  return o;
}

checkContainer(api.Container o) {
  buildCounterContainer++;
  if (buildCounterContainer < 3) {
    unittest.expect(o.accountId, unittest.equals('foo'));
    unittest.expect(o.containerId, unittest.equals('foo'));
    checkUnnamed1622(o.domainName);
    unittest.expect(o.fingerprint, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.notes, unittest.equals('foo'));
    unittest.expect(o.path, unittest.equals('foo'));
    unittest.expect(o.publicId, unittest.equals('foo'));
    unittest.expect(o.tagManagerUrl, unittest.equals('foo'));
    checkUnnamed1623(o.usageContext);
  }
  buildCounterContainer--;
}

core.int buildCounterContainerAccess = 0;
buildContainerAccess() {
  var o = new api.ContainerAccess();
  buildCounterContainerAccess++;
  if (buildCounterContainerAccess < 3) {
    o.containerId = "foo";
    o.permission = "foo";
  }
  buildCounterContainerAccess--;
  return o;
}

checkContainerAccess(api.ContainerAccess o) {
  buildCounterContainerAccess++;
  if (buildCounterContainerAccess < 3) {
    unittest.expect(o.containerId, unittest.equals('foo'));
    unittest.expect(o.permission, unittest.equals('foo'));
  }
  buildCounterContainerAccess--;
}

buildUnnamed1624() {
  var o = new core.List<api.BuiltInVariable>();
  o.add(buildBuiltInVariable());
  o.add(buildBuiltInVariable());
  return o;
}

checkUnnamed1624(core.List<api.BuiltInVariable> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBuiltInVariable(o[0]);
  checkBuiltInVariable(o[1]);
}

buildUnnamed1625() {
  var o = new core.List<api.Folder>();
  o.add(buildFolder());
  o.add(buildFolder());
  return o;
}

checkUnnamed1625(core.List<api.Folder> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkFolder(o[0]);
  checkFolder(o[1]);
}

buildUnnamed1626() {
  var o = new core.List<api.Tag>();
  o.add(buildTag());
  o.add(buildTag());
  return o;
}

checkUnnamed1626(core.List<api.Tag> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTag(o[0]);
  checkTag(o[1]);
}

buildUnnamed1627() {
  var o = new core.List<api.Trigger>();
  o.add(buildTrigger());
  o.add(buildTrigger());
  return o;
}

checkUnnamed1627(core.List<api.Trigger> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTrigger(o[0]);
  checkTrigger(o[1]);
}

buildUnnamed1628() {
  var o = new core.List<api.Variable>();
  o.add(buildVariable());
  o.add(buildVariable());
  return o;
}

checkUnnamed1628(core.List<api.Variable> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkVariable(o[0]);
  checkVariable(o[1]);
}

buildUnnamed1629() {
  var o = new core.List<api.Zone>();
  o.add(buildZone());
  o.add(buildZone());
  return o;
}

checkUnnamed1629(core.List<api.Zone> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkZone(o[0]);
  checkZone(o[1]);
}

core.int buildCounterContainerVersion = 0;
buildContainerVersion() {
  var o = new api.ContainerVersion();
  buildCounterContainerVersion++;
  if (buildCounterContainerVersion < 3) {
    o.accountId = "foo";
    o.builtInVariable = buildUnnamed1624();
    o.container = buildContainer();
    o.containerId = "foo";
    o.containerVersionId = "foo";
    o.deleted = true;
    o.description = "foo";
    o.fingerprint = "foo";
    o.folder = buildUnnamed1625();
    o.name = "foo";
    o.path = "foo";
    o.tag = buildUnnamed1626();
    o.tagManagerUrl = "foo";
    o.trigger = buildUnnamed1627();
    o.variable = buildUnnamed1628();
    o.zone = buildUnnamed1629();
  }
  buildCounterContainerVersion--;
  return o;
}

checkContainerVersion(api.ContainerVersion o) {
  buildCounterContainerVersion++;
  if (buildCounterContainerVersion < 3) {
    unittest.expect(o.accountId, unittest.equals('foo'));
    checkUnnamed1624(o.builtInVariable);
    checkContainer(o.container);
    unittest.expect(o.containerId, unittest.equals('foo'));
    unittest.expect(o.containerVersionId, unittest.equals('foo'));
    unittest.expect(o.deleted, unittest.isTrue);
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.fingerprint, unittest.equals('foo'));
    checkUnnamed1625(o.folder);
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.path, unittest.equals('foo'));
    checkUnnamed1626(o.tag);
    unittest.expect(o.tagManagerUrl, unittest.equals('foo'));
    checkUnnamed1627(o.trigger);
    checkUnnamed1628(o.variable);
    checkUnnamed1629(o.zone);
  }
  buildCounterContainerVersion--;
}

core.int buildCounterContainerVersionHeader = 0;
buildContainerVersionHeader() {
  var o = new api.ContainerVersionHeader();
  buildCounterContainerVersionHeader++;
  if (buildCounterContainerVersionHeader < 3) {
    o.accountId = "foo";
    o.containerId = "foo";
    o.containerVersionId = "foo";
    o.deleted = true;
    o.name = "foo";
    o.numMacros = "foo";
    o.numRules = "foo";
    o.numTags = "foo";
    o.numTriggers = "foo";
    o.numVariables = "foo";
    o.numZones = "foo";
    o.path = "foo";
  }
  buildCounterContainerVersionHeader--;
  return o;
}

checkContainerVersionHeader(api.ContainerVersionHeader o) {
  buildCounterContainerVersionHeader++;
  if (buildCounterContainerVersionHeader < 3) {
    unittest.expect(o.accountId, unittest.equals('foo'));
    unittest.expect(o.containerId, unittest.equals('foo'));
    unittest.expect(o.containerVersionId, unittest.equals('foo'));
    unittest.expect(o.deleted, unittest.isTrue);
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.numMacros, unittest.equals('foo'));
    unittest.expect(o.numRules, unittest.equals('foo'));
    unittest.expect(o.numTags, unittest.equals('foo'));
    unittest.expect(o.numTriggers, unittest.equals('foo'));
    unittest.expect(o.numVariables, unittest.equals('foo'));
    unittest.expect(o.numZones, unittest.equals('foo'));
    unittest.expect(o.path, unittest.equals('foo'));
  }
  buildCounterContainerVersionHeader--;
}

buildUnnamed1630() {
  var o = new core.List<api.BuiltInVariable>();
  o.add(buildBuiltInVariable());
  o.add(buildBuiltInVariable());
  return o;
}

checkUnnamed1630(core.List<api.BuiltInVariable> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBuiltInVariable(o[0]);
  checkBuiltInVariable(o[1]);
}

core.int buildCounterCreateBuiltInVariableResponse = 0;
buildCreateBuiltInVariableResponse() {
  var o = new api.CreateBuiltInVariableResponse();
  buildCounterCreateBuiltInVariableResponse++;
  if (buildCounterCreateBuiltInVariableResponse < 3) {
    o.builtInVariable = buildUnnamed1630();
  }
  buildCounterCreateBuiltInVariableResponse--;
  return o;
}

checkCreateBuiltInVariableResponse(api.CreateBuiltInVariableResponse o) {
  buildCounterCreateBuiltInVariableResponse++;
  if (buildCounterCreateBuiltInVariableResponse < 3) {
    checkUnnamed1630(o.builtInVariable);
  }
  buildCounterCreateBuiltInVariableResponse--;
}

core.int buildCounterCreateContainerVersionRequestVersionOptions = 0;
buildCreateContainerVersionRequestVersionOptions() {
  var o = new api.CreateContainerVersionRequestVersionOptions();
  buildCounterCreateContainerVersionRequestVersionOptions++;
  if (buildCounterCreateContainerVersionRequestVersionOptions < 3) {
    o.name = "foo";
    o.notes = "foo";
  }
  buildCounterCreateContainerVersionRequestVersionOptions--;
  return o;
}

checkCreateContainerVersionRequestVersionOptions(
    api.CreateContainerVersionRequestVersionOptions o) {
  buildCounterCreateContainerVersionRequestVersionOptions++;
  if (buildCounterCreateContainerVersionRequestVersionOptions < 3) {
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.notes, unittest.equals('foo'));
  }
  buildCounterCreateContainerVersionRequestVersionOptions--;
}

core.int buildCounterCreateContainerVersionResponse = 0;
buildCreateContainerVersionResponse() {
  var o = new api.CreateContainerVersionResponse();
  buildCounterCreateContainerVersionResponse++;
  if (buildCounterCreateContainerVersionResponse < 3) {
    o.compilerError = true;
    o.containerVersion = buildContainerVersion();
    o.newWorkspacePath = "foo";
    o.syncStatus = buildSyncStatus();
  }
  buildCounterCreateContainerVersionResponse--;
  return o;
}

checkCreateContainerVersionResponse(api.CreateContainerVersionResponse o) {
  buildCounterCreateContainerVersionResponse++;
  if (buildCounterCreateContainerVersionResponse < 3) {
    unittest.expect(o.compilerError, unittest.isTrue);
    checkContainerVersion(o.containerVersion);
    unittest.expect(o.newWorkspacePath, unittest.equals('foo'));
    checkSyncStatus(o.syncStatus);
  }
  buildCounterCreateContainerVersionResponse--;
}

buildUnnamed1631() {
  var o = new core.List<api.WorkspaceProposalUser>();
  o.add(buildWorkspaceProposalUser());
  o.add(buildWorkspaceProposalUser());
  return o;
}

checkUnnamed1631(core.List<api.WorkspaceProposalUser> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkWorkspaceProposalUser(o[0]);
  checkWorkspaceProposalUser(o[1]);
}

core.int buildCounterCreateWorkspaceProposalRequest = 0;
buildCreateWorkspaceProposalRequest() {
  var o = new api.CreateWorkspaceProposalRequest();
  buildCounterCreateWorkspaceProposalRequest++;
  if (buildCounterCreateWorkspaceProposalRequest < 3) {
    o.initialComment = buildWorkspaceProposalHistoryComment();
    o.reviewers = buildUnnamed1631();
  }
  buildCounterCreateWorkspaceProposalRequest--;
  return o;
}

checkCreateWorkspaceProposalRequest(api.CreateWorkspaceProposalRequest o) {
  buildCounterCreateWorkspaceProposalRequest++;
  if (buildCounterCreateWorkspaceProposalRequest < 3) {
    checkWorkspaceProposalHistoryComment(o.initialComment);
    checkUnnamed1631(o.reviewers);
  }
  buildCounterCreateWorkspaceProposalRequest--;
}

core.int buildCounterEntity = 0;
buildEntity() {
  var o = new api.Entity();
  buildCounterEntity++;
  if (buildCounterEntity < 3) {
    o.changeStatus = "foo";
    o.folder = buildFolder();
    o.tag = buildTag();
    o.trigger = buildTrigger();
    o.variable = buildVariable();
  }
  buildCounterEntity--;
  return o;
}

checkEntity(api.Entity o) {
  buildCounterEntity++;
  if (buildCounterEntity < 3) {
    unittest.expect(o.changeStatus, unittest.equals('foo'));
    checkFolder(o.folder);
    checkTag(o.tag);
    checkTrigger(o.trigger);
    checkVariable(o.variable);
  }
  buildCounterEntity--;
}

core.int buildCounterEnvironment = 0;
buildEnvironment() {
  var o = new api.Environment();
  buildCounterEnvironment++;
  if (buildCounterEnvironment < 3) {
    o.accountId = "foo";
    o.authorizationCode = "foo";
    o.authorizationTimestamp = buildTimestamp();
    o.containerId = "foo";
    o.containerVersionId = "foo";
    o.description = "foo";
    o.enableDebug = true;
    o.environmentId = "foo";
    o.fingerprint = "foo";
    o.name = "foo";
    o.path = "foo";
    o.tagManagerUrl = "foo";
    o.type = "foo";
    o.url = "foo";
    o.workspaceId = "foo";
  }
  buildCounterEnvironment--;
  return o;
}

checkEnvironment(api.Environment o) {
  buildCounterEnvironment++;
  if (buildCounterEnvironment < 3) {
    unittest.expect(o.accountId, unittest.equals('foo'));
    unittest.expect(o.authorizationCode, unittest.equals('foo'));
    checkTimestamp(o.authorizationTimestamp);
    unittest.expect(o.containerId, unittest.equals('foo'));
    unittest.expect(o.containerVersionId, unittest.equals('foo'));
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.enableDebug, unittest.isTrue);
    unittest.expect(o.environmentId, unittest.equals('foo'));
    unittest.expect(o.fingerprint, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.path, unittest.equals('foo'));
    unittest.expect(o.tagManagerUrl, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
    unittest.expect(o.url, unittest.equals('foo'));
    unittest.expect(o.workspaceId, unittest.equals('foo'));
  }
  buildCounterEnvironment--;
}

core.int buildCounterFolder = 0;
buildFolder() {
  var o = new api.Folder();
  buildCounterFolder++;
  if (buildCounterFolder < 3) {
    o.accountId = "foo";
    o.containerId = "foo";
    o.fingerprint = "foo";
    o.folderId = "foo";
    o.name = "foo";
    o.notes = "foo";
    o.path = "foo";
    o.tagManagerUrl = "foo";
    o.workspaceId = "foo";
  }
  buildCounterFolder--;
  return o;
}

checkFolder(api.Folder o) {
  buildCounterFolder++;
  if (buildCounterFolder < 3) {
    unittest.expect(o.accountId, unittest.equals('foo'));
    unittest.expect(o.containerId, unittest.equals('foo'));
    unittest.expect(o.fingerprint, unittest.equals('foo'));
    unittest.expect(o.folderId, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.notes, unittest.equals('foo'));
    unittest.expect(o.path, unittest.equals('foo'));
    unittest.expect(o.tagManagerUrl, unittest.equals('foo'));
    unittest.expect(o.workspaceId, unittest.equals('foo'));
  }
  buildCounterFolder--;
}

buildUnnamed1632() {
  var o = new core.List<api.Tag>();
  o.add(buildTag());
  o.add(buildTag());
  return o;
}

checkUnnamed1632(core.List<api.Tag> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTag(o[0]);
  checkTag(o[1]);
}

buildUnnamed1633() {
  var o = new core.List<api.Trigger>();
  o.add(buildTrigger());
  o.add(buildTrigger());
  return o;
}

checkUnnamed1633(core.List<api.Trigger> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTrigger(o[0]);
  checkTrigger(o[1]);
}

buildUnnamed1634() {
  var o = new core.List<api.Variable>();
  o.add(buildVariable());
  o.add(buildVariable());
  return o;
}

checkUnnamed1634(core.List<api.Variable> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkVariable(o[0]);
  checkVariable(o[1]);
}

core.int buildCounterFolderEntities = 0;
buildFolderEntities() {
  var o = new api.FolderEntities();
  buildCounterFolderEntities++;
  if (buildCounterFolderEntities < 3) {
    o.nextPageToken = "foo";
    o.tag = buildUnnamed1632();
    o.trigger = buildUnnamed1633();
    o.variable = buildUnnamed1634();
  }
  buildCounterFolderEntities--;
  return o;
}

checkFolderEntities(api.FolderEntities o) {
  buildCounterFolderEntities++;
  if (buildCounterFolderEntities < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed1632(o.tag);
    checkUnnamed1633(o.trigger);
    checkUnnamed1634(o.variable);
  }
  buildCounterFolderEntities--;
}

buildUnnamed1635() {
  var o = new core.List<api.MergeConflict>();
  o.add(buildMergeConflict());
  o.add(buildMergeConflict());
  return o;
}

checkUnnamed1635(core.List<api.MergeConflict> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMergeConflict(o[0]);
  checkMergeConflict(o[1]);
}

buildUnnamed1636() {
  var o = new core.List<api.Entity>();
  o.add(buildEntity());
  o.add(buildEntity());
  return o;
}

checkUnnamed1636(core.List<api.Entity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEntity(o[0]);
  checkEntity(o[1]);
}

core.int buildCounterGetWorkspaceStatusResponse = 0;
buildGetWorkspaceStatusResponse() {
  var o = new api.GetWorkspaceStatusResponse();
  buildCounterGetWorkspaceStatusResponse++;
  if (buildCounterGetWorkspaceStatusResponse < 3) {
    o.mergeConflict = buildUnnamed1635();
    o.workspaceChange = buildUnnamed1636();
  }
  buildCounterGetWorkspaceStatusResponse--;
  return o;
}

checkGetWorkspaceStatusResponse(api.GetWorkspaceStatusResponse o) {
  buildCounterGetWorkspaceStatusResponse++;
  if (buildCounterGetWorkspaceStatusResponse < 3) {
    checkUnnamed1635(o.mergeConflict);
    checkUnnamed1636(o.workspaceChange);
  }
  buildCounterGetWorkspaceStatusResponse--;
}

buildUnnamed1637() {
  var o = new core.List<api.Account>();
  o.add(buildAccount());
  o.add(buildAccount());
  return o;
}

checkUnnamed1637(core.List<api.Account> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccount(o[0]);
  checkAccount(o[1]);
}

core.int buildCounterListAccountsResponse = 0;
buildListAccountsResponse() {
  var o = new api.ListAccountsResponse();
  buildCounterListAccountsResponse++;
  if (buildCounterListAccountsResponse < 3) {
    o.account = buildUnnamed1637();
    o.nextPageToken = "foo";
  }
  buildCounterListAccountsResponse--;
  return o;
}

checkListAccountsResponse(api.ListAccountsResponse o) {
  buildCounterListAccountsResponse++;
  if (buildCounterListAccountsResponse < 3) {
    checkUnnamed1637(o.account);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListAccountsResponse--;
}

buildUnnamed1638() {
  var o = new core.List<api.ContainerVersionHeader>();
  o.add(buildContainerVersionHeader());
  o.add(buildContainerVersionHeader());
  return o;
}

checkUnnamed1638(core.List<api.ContainerVersionHeader> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkContainerVersionHeader(o[0]);
  checkContainerVersionHeader(o[1]);
}

core.int buildCounterListContainerVersionsResponse = 0;
buildListContainerVersionsResponse() {
  var o = new api.ListContainerVersionsResponse();
  buildCounterListContainerVersionsResponse++;
  if (buildCounterListContainerVersionsResponse < 3) {
    o.containerVersionHeader = buildUnnamed1638();
    o.nextPageToken = "foo";
  }
  buildCounterListContainerVersionsResponse--;
  return o;
}

checkListContainerVersionsResponse(api.ListContainerVersionsResponse o) {
  buildCounterListContainerVersionsResponse++;
  if (buildCounterListContainerVersionsResponse < 3) {
    checkUnnamed1638(o.containerVersionHeader);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListContainerVersionsResponse--;
}

buildUnnamed1639() {
  var o = new core.List<api.Container>();
  o.add(buildContainer());
  o.add(buildContainer());
  return o;
}

checkUnnamed1639(core.List<api.Container> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkContainer(o[0]);
  checkContainer(o[1]);
}

core.int buildCounterListContainersResponse = 0;
buildListContainersResponse() {
  var o = new api.ListContainersResponse();
  buildCounterListContainersResponse++;
  if (buildCounterListContainersResponse < 3) {
    o.container = buildUnnamed1639();
    o.nextPageToken = "foo";
  }
  buildCounterListContainersResponse--;
  return o;
}

checkListContainersResponse(api.ListContainersResponse o) {
  buildCounterListContainersResponse++;
  if (buildCounterListContainersResponse < 3) {
    checkUnnamed1639(o.container);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListContainersResponse--;
}

buildUnnamed1640() {
  var o = new core.List<api.BuiltInVariable>();
  o.add(buildBuiltInVariable());
  o.add(buildBuiltInVariable());
  return o;
}

checkUnnamed1640(core.List<api.BuiltInVariable> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBuiltInVariable(o[0]);
  checkBuiltInVariable(o[1]);
}

core.int buildCounterListEnabledBuiltInVariablesResponse = 0;
buildListEnabledBuiltInVariablesResponse() {
  var o = new api.ListEnabledBuiltInVariablesResponse();
  buildCounterListEnabledBuiltInVariablesResponse++;
  if (buildCounterListEnabledBuiltInVariablesResponse < 3) {
    o.builtInVariable = buildUnnamed1640();
    o.nextPageToken = "foo";
  }
  buildCounterListEnabledBuiltInVariablesResponse--;
  return o;
}

checkListEnabledBuiltInVariablesResponse(
    api.ListEnabledBuiltInVariablesResponse o) {
  buildCounterListEnabledBuiltInVariablesResponse++;
  if (buildCounterListEnabledBuiltInVariablesResponse < 3) {
    checkUnnamed1640(o.builtInVariable);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListEnabledBuiltInVariablesResponse--;
}

buildUnnamed1641() {
  var o = new core.List<api.Environment>();
  o.add(buildEnvironment());
  o.add(buildEnvironment());
  return o;
}

checkUnnamed1641(core.List<api.Environment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEnvironment(o[0]);
  checkEnvironment(o[1]);
}

core.int buildCounterListEnvironmentsResponse = 0;
buildListEnvironmentsResponse() {
  var o = new api.ListEnvironmentsResponse();
  buildCounterListEnvironmentsResponse++;
  if (buildCounterListEnvironmentsResponse < 3) {
    o.environment = buildUnnamed1641();
    o.nextPageToken = "foo";
  }
  buildCounterListEnvironmentsResponse--;
  return o;
}

checkListEnvironmentsResponse(api.ListEnvironmentsResponse o) {
  buildCounterListEnvironmentsResponse++;
  if (buildCounterListEnvironmentsResponse < 3) {
    checkUnnamed1641(o.environment);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListEnvironmentsResponse--;
}

buildUnnamed1642() {
  var o = new core.List<api.Folder>();
  o.add(buildFolder());
  o.add(buildFolder());
  return o;
}

checkUnnamed1642(core.List<api.Folder> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkFolder(o[0]);
  checkFolder(o[1]);
}

core.int buildCounterListFoldersResponse = 0;
buildListFoldersResponse() {
  var o = new api.ListFoldersResponse();
  buildCounterListFoldersResponse++;
  if (buildCounterListFoldersResponse < 3) {
    o.folder = buildUnnamed1642();
    o.nextPageToken = "foo";
  }
  buildCounterListFoldersResponse--;
  return o;
}

checkListFoldersResponse(api.ListFoldersResponse o) {
  buildCounterListFoldersResponse++;
  if (buildCounterListFoldersResponse < 3) {
    checkUnnamed1642(o.folder);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListFoldersResponse--;
}

buildUnnamed1643() {
  var o = new core.List<api.Tag>();
  o.add(buildTag());
  o.add(buildTag());
  return o;
}

checkUnnamed1643(core.List<api.Tag> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTag(o[0]);
  checkTag(o[1]);
}

core.int buildCounterListTagsResponse = 0;
buildListTagsResponse() {
  var o = new api.ListTagsResponse();
  buildCounterListTagsResponse++;
  if (buildCounterListTagsResponse < 3) {
    o.nextPageToken = "foo";
    o.tag = buildUnnamed1643();
  }
  buildCounterListTagsResponse--;
  return o;
}

checkListTagsResponse(api.ListTagsResponse o) {
  buildCounterListTagsResponse++;
  if (buildCounterListTagsResponse < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed1643(o.tag);
  }
  buildCounterListTagsResponse--;
}

buildUnnamed1644() {
  var o = new core.List<api.Trigger>();
  o.add(buildTrigger());
  o.add(buildTrigger());
  return o;
}

checkUnnamed1644(core.List<api.Trigger> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTrigger(o[0]);
  checkTrigger(o[1]);
}

core.int buildCounterListTriggersResponse = 0;
buildListTriggersResponse() {
  var o = new api.ListTriggersResponse();
  buildCounterListTriggersResponse++;
  if (buildCounterListTriggersResponse < 3) {
    o.nextPageToken = "foo";
    o.trigger = buildUnnamed1644();
  }
  buildCounterListTriggersResponse--;
  return o;
}

checkListTriggersResponse(api.ListTriggersResponse o) {
  buildCounterListTriggersResponse++;
  if (buildCounterListTriggersResponse < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed1644(o.trigger);
  }
  buildCounterListTriggersResponse--;
}

buildUnnamed1645() {
  var o = new core.List<api.UserPermission>();
  o.add(buildUserPermission());
  o.add(buildUserPermission());
  return o;
}

checkUnnamed1645(core.List<api.UserPermission> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUserPermission(o[0]);
  checkUserPermission(o[1]);
}

core.int buildCounterListUserPermissionsResponse = 0;
buildListUserPermissionsResponse() {
  var o = new api.ListUserPermissionsResponse();
  buildCounterListUserPermissionsResponse++;
  if (buildCounterListUserPermissionsResponse < 3) {
    o.nextPageToken = "foo";
    o.userPermission = buildUnnamed1645();
  }
  buildCounterListUserPermissionsResponse--;
  return o;
}

checkListUserPermissionsResponse(api.ListUserPermissionsResponse o) {
  buildCounterListUserPermissionsResponse++;
  if (buildCounterListUserPermissionsResponse < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed1645(o.userPermission);
  }
  buildCounterListUserPermissionsResponse--;
}

buildUnnamed1646() {
  var o = new core.List<api.Variable>();
  o.add(buildVariable());
  o.add(buildVariable());
  return o;
}

checkUnnamed1646(core.List<api.Variable> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkVariable(o[0]);
  checkVariable(o[1]);
}

core.int buildCounterListVariablesResponse = 0;
buildListVariablesResponse() {
  var o = new api.ListVariablesResponse();
  buildCounterListVariablesResponse++;
  if (buildCounterListVariablesResponse < 3) {
    o.nextPageToken = "foo";
    o.variable = buildUnnamed1646();
  }
  buildCounterListVariablesResponse--;
  return o;
}

checkListVariablesResponse(api.ListVariablesResponse o) {
  buildCounterListVariablesResponse++;
  if (buildCounterListVariablesResponse < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed1646(o.variable);
  }
  buildCounterListVariablesResponse--;
}

buildUnnamed1647() {
  var o = new core.List<api.Workspace>();
  o.add(buildWorkspace());
  o.add(buildWorkspace());
  return o;
}

checkUnnamed1647(core.List<api.Workspace> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkWorkspace(o[0]);
  checkWorkspace(o[1]);
}

core.int buildCounterListWorkspacesResponse = 0;
buildListWorkspacesResponse() {
  var o = new api.ListWorkspacesResponse();
  buildCounterListWorkspacesResponse++;
  if (buildCounterListWorkspacesResponse < 3) {
    o.nextPageToken = "foo";
    o.workspace = buildUnnamed1647();
  }
  buildCounterListWorkspacesResponse--;
  return o;
}

checkListWorkspacesResponse(api.ListWorkspacesResponse o) {
  buildCounterListWorkspacesResponse++;
  if (buildCounterListWorkspacesResponse < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed1647(o.workspace);
  }
  buildCounterListWorkspacesResponse--;
}

core.int buildCounterMergeConflict = 0;
buildMergeConflict() {
  var o = new api.MergeConflict();
  buildCounterMergeConflict++;
  if (buildCounterMergeConflict < 3) {
    o.entityInBaseVersion = buildEntity();
    o.entityInWorkspace = buildEntity();
  }
  buildCounterMergeConflict--;
  return o;
}

checkMergeConflict(api.MergeConflict o) {
  buildCounterMergeConflict++;
  if (buildCounterMergeConflict < 3) {
    checkEntity(o.entityInBaseVersion);
    checkEntity(o.entityInWorkspace);
  }
  buildCounterMergeConflict--;
}

buildUnnamed1648() {
  var o = new core.List<api.Parameter>();
  o.add(buildParameter());
  o.add(buildParameter());
  return o;
}

checkUnnamed1648(core.List<api.Parameter> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkParameter(o[0]);
  checkParameter(o[1]);
}

buildUnnamed1649() {
  var o = new core.List<api.Parameter>();
  o.add(buildParameter());
  o.add(buildParameter());
  return o;
}

checkUnnamed1649(core.List<api.Parameter> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkParameter(o[0]);
  checkParameter(o[1]);
}

core.int buildCounterParameter = 0;
buildParameter() {
  var o = new api.Parameter();
  buildCounterParameter++;
  if (buildCounterParameter < 3) {
    o.key = "foo";
    o.list = buildUnnamed1648();
    o.map = buildUnnamed1649();
    o.type = "foo";
    o.value = "foo";
  }
  buildCounterParameter--;
  return o;
}

checkParameter(api.Parameter o) {
  buildCounterParameter++;
  if (buildCounterParameter < 3) {
    unittest.expect(o.key, unittest.equals('foo'));
    checkUnnamed1648(o.list);
    checkUnnamed1649(o.map);
    unittest.expect(o.type, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterParameter--;
}

core.int buildCounterPublishContainerVersionResponse = 0;
buildPublishContainerVersionResponse() {
  var o = new api.PublishContainerVersionResponse();
  buildCounterPublishContainerVersionResponse++;
  if (buildCounterPublishContainerVersionResponse < 3) {
    o.compilerError = true;
    o.containerVersion = buildContainerVersion();
  }
  buildCounterPublishContainerVersionResponse--;
  return o;
}

checkPublishContainerVersionResponse(api.PublishContainerVersionResponse o) {
  buildCounterPublishContainerVersionResponse++;
  if (buildCounterPublishContainerVersionResponse < 3) {
    unittest.expect(o.compilerError, unittest.isTrue);
    checkContainerVersion(o.containerVersion);
  }
  buildCounterPublishContainerVersionResponse--;
}

core.int buildCounterQuickPreviewResponse = 0;
buildQuickPreviewResponse() {
  var o = new api.QuickPreviewResponse();
  buildCounterQuickPreviewResponse++;
  if (buildCounterQuickPreviewResponse < 3) {
    o.compilerError = true;
    o.containerVersion = buildContainerVersion();
    o.syncStatus = buildSyncStatus();
  }
  buildCounterQuickPreviewResponse--;
  return o;
}

checkQuickPreviewResponse(api.QuickPreviewResponse o) {
  buildCounterQuickPreviewResponse++;
  if (buildCounterQuickPreviewResponse < 3) {
    unittest.expect(o.compilerError, unittest.isTrue);
    checkContainerVersion(o.containerVersion);
    checkSyncStatus(o.syncStatus);
  }
  buildCounterQuickPreviewResponse--;
}

core.int buildCounterRevertBuiltInVariableResponse = 0;
buildRevertBuiltInVariableResponse() {
  var o = new api.RevertBuiltInVariableResponse();
  buildCounterRevertBuiltInVariableResponse++;
  if (buildCounterRevertBuiltInVariableResponse < 3) {
    o.enabled = true;
  }
  buildCounterRevertBuiltInVariableResponse--;
  return o;
}

checkRevertBuiltInVariableResponse(api.RevertBuiltInVariableResponse o) {
  buildCounterRevertBuiltInVariableResponse++;
  if (buildCounterRevertBuiltInVariableResponse < 3) {
    unittest.expect(o.enabled, unittest.isTrue);
  }
  buildCounterRevertBuiltInVariableResponse--;
}

core.int buildCounterRevertFolderResponse = 0;
buildRevertFolderResponse() {
  var o = new api.RevertFolderResponse();
  buildCounterRevertFolderResponse++;
  if (buildCounterRevertFolderResponse < 3) {
    o.folder = buildFolder();
  }
  buildCounterRevertFolderResponse--;
  return o;
}

checkRevertFolderResponse(api.RevertFolderResponse o) {
  buildCounterRevertFolderResponse++;
  if (buildCounterRevertFolderResponse < 3) {
    checkFolder(o.folder);
  }
  buildCounterRevertFolderResponse--;
}

core.int buildCounterRevertTagResponse = 0;
buildRevertTagResponse() {
  var o = new api.RevertTagResponse();
  buildCounterRevertTagResponse++;
  if (buildCounterRevertTagResponse < 3) {
    o.tag = buildTag();
  }
  buildCounterRevertTagResponse--;
  return o;
}

checkRevertTagResponse(api.RevertTagResponse o) {
  buildCounterRevertTagResponse++;
  if (buildCounterRevertTagResponse < 3) {
    checkTag(o.tag);
  }
  buildCounterRevertTagResponse--;
}

core.int buildCounterRevertTriggerResponse = 0;
buildRevertTriggerResponse() {
  var o = new api.RevertTriggerResponse();
  buildCounterRevertTriggerResponse++;
  if (buildCounterRevertTriggerResponse < 3) {
    o.trigger = buildTrigger();
  }
  buildCounterRevertTriggerResponse--;
  return o;
}

checkRevertTriggerResponse(api.RevertTriggerResponse o) {
  buildCounterRevertTriggerResponse++;
  if (buildCounterRevertTriggerResponse < 3) {
    checkTrigger(o.trigger);
  }
  buildCounterRevertTriggerResponse--;
}

core.int buildCounterRevertVariableResponse = 0;
buildRevertVariableResponse() {
  var o = new api.RevertVariableResponse();
  buildCounterRevertVariableResponse++;
  if (buildCounterRevertVariableResponse < 3) {
    o.variable = buildVariable();
  }
  buildCounterRevertVariableResponse--;
  return o;
}

checkRevertVariableResponse(api.RevertVariableResponse o) {
  buildCounterRevertVariableResponse++;
  if (buildCounterRevertVariableResponse < 3) {
    checkVariable(o.variable);
  }
  buildCounterRevertVariableResponse--;
}

core.int buildCounterSetupTag = 0;
buildSetupTag() {
  var o = new api.SetupTag();
  buildCounterSetupTag++;
  if (buildCounterSetupTag < 3) {
    o.stopOnSetupFailure = true;
    o.tagName = "foo";
  }
  buildCounterSetupTag--;
  return o;
}

checkSetupTag(api.SetupTag o) {
  buildCounterSetupTag++;
  if (buildCounterSetupTag < 3) {
    unittest.expect(o.stopOnSetupFailure, unittest.isTrue);
    unittest.expect(o.tagName, unittest.equals('foo'));
  }
  buildCounterSetupTag--;
}

core.int buildCounterSyncStatus = 0;
buildSyncStatus() {
  var o = new api.SyncStatus();
  buildCounterSyncStatus++;
  if (buildCounterSyncStatus < 3) {
    o.mergeConflict = true;
    o.syncError = true;
  }
  buildCounterSyncStatus--;
  return o;
}

checkSyncStatus(api.SyncStatus o) {
  buildCounterSyncStatus++;
  if (buildCounterSyncStatus < 3) {
    unittest.expect(o.mergeConflict, unittest.isTrue);
    unittest.expect(o.syncError, unittest.isTrue);
  }
  buildCounterSyncStatus--;
}

buildUnnamed1650() {
  var o = new core.List<api.MergeConflict>();
  o.add(buildMergeConflict());
  o.add(buildMergeConflict());
  return o;
}

checkUnnamed1650(core.List<api.MergeConflict> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMergeConflict(o[0]);
  checkMergeConflict(o[1]);
}

core.int buildCounterSyncWorkspaceResponse = 0;
buildSyncWorkspaceResponse() {
  var o = new api.SyncWorkspaceResponse();
  buildCounterSyncWorkspaceResponse++;
  if (buildCounterSyncWorkspaceResponse < 3) {
    o.mergeConflict = buildUnnamed1650();
    o.syncStatus = buildSyncStatus();
  }
  buildCounterSyncWorkspaceResponse--;
  return o;
}

checkSyncWorkspaceResponse(api.SyncWorkspaceResponse o) {
  buildCounterSyncWorkspaceResponse++;
  if (buildCounterSyncWorkspaceResponse < 3) {
    checkUnnamed1650(o.mergeConflict);
    checkSyncStatus(o.syncStatus);
  }
  buildCounterSyncWorkspaceResponse--;
}

buildUnnamed1651() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1651(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1652() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1652(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1653() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1653(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1654() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1654(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1655() {
  var o = new core.List<api.Parameter>();
  o.add(buildParameter());
  o.add(buildParameter());
  return o;
}

checkUnnamed1655(core.List<api.Parameter> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkParameter(o[0]);
  checkParameter(o[1]);
}

buildUnnamed1656() {
  var o = new core.List<api.SetupTag>();
  o.add(buildSetupTag());
  o.add(buildSetupTag());
  return o;
}

checkUnnamed1656(core.List<api.SetupTag> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSetupTag(o[0]);
  checkSetupTag(o[1]);
}

buildUnnamed1657() {
  var o = new core.List<api.TeardownTag>();
  o.add(buildTeardownTag());
  o.add(buildTeardownTag());
  return o;
}

checkUnnamed1657(core.List<api.TeardownTag> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkTeardownTag(o[0]);
  checkTeardownTag(o[1]);
}

core.int buildCounterTag = 0;
buildTag() {
  var o = new api.Tag();
  buildCounterTag++;
  if (buildCounterTag < 3) {
    o.accountId = "foo";
    o.blockingRuleId = buildUnnamed1651();
    o.blockingTriggerId = buildUnnamed1652();
    o.containerId = "foo";
    o.fingerprint = "foo";
    o.firingRuleId = buildUnnamed1653();
    o.firingTriggerId = buildUnnamed1654();
    o.liveOnly = true;
    o.name = "foo";
    o.notes = "foo";
    o.parameter = buildUnnamed1655();
    o.parentFolderId = "foo";
    o.path = "foo";
    o.paused = true;
    o.priority = buildParameter();
    o.scheduleEndMs = "foo";
    o.scheduleStartMs = "foo";
    o.setupTag = buildUnnamed1656();
    o.tagFiringOption = "foo";
    o.tagId = "foo";
    o.tagManagerUrl = "foo";
    o.teardownTag = buildUnnamed1657();
    o.type = "foo";
    o.workspaceId = "foo";
  }
  buildCounterTag--;
  return o;
}

checkTag(api.Tag o) {
  buildCounterTag++;
  if (buildCounterTag < 3) {
    unittest.expect(o.accountId, unittest.equals('foo'));
    checkUnnamed1651(o.blockingRuleId);
    checkUnnamed1652(o.blockingTriggerId);
    unittest.expect(o.containerId, unittest.equals('foo'));
    unittest.expect(o.fingerprint, unittest.equals('foo'));
    checkUnnamed1653(o.firingRuleId);
    checkUnnamed1654(o.firingTriggerId);
    unittest.expect(o.liveOnly, unittest.isTrue);
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.notes, unittest.equals('foo'));
    checkUnnamed1655(o.parameter);
    unittest.expect(o.parentFolderId, unittest.equals('foo'));
    unittest.expect(o.path, unittest.equals('foo'));
    unittest.expect(o.paused, unittest.isTrue);
    checkParameter(o.priority);
    unittest.expect(o.scheduleEndMs, unittest.equals('foo'));
    unittest.expect(o.scheduleStartMs, unittest.equals('foo'));
    checkUnnamed1656(o.setupTag);
    unittest.expect(o.tagFiringOption, unittest.equals('foo'));
    unittest.expect(o.tagId, unittest.equals('foo'));
    unittest.expect(o.tagManagerUrl, unittest.equals('foo'));
    checkUnnamed1657(o.teardownTag);
    unittest.expect(o.type, unittest.equals('foo'));
    unittest.expect(o.workspaceId, unittest.equals('foo'));
  }
  buildCounterTag--;
}

core.int buildCounterTeardownTag = 0;
buildTeardownTag() {
  var o = new api.TeardownTag();
  buildCounterTeardownTag++;
  if (buildCounterTeardownTag < 3) {
    o.stopTeardownOnFailure = true;
    o.tagName = "foo";
  }
  buildCounterTeardownTag--;
  return o;
}

checkTeardownTag(api.TeardownTag o) {
  buildCounterTeardownTag++;
  if (buildCounterTeardownTag < 3) {
    unittest.expect(o.stopTeardownOnFailure, unittest.isTrue);
    unittest.expect(o.tagName, unittest.equals('foo'));
  }
  buildCounterTeardownTag--;
}

core.int buildCounterTimestamp = 0;
buildTimestamp() {
  var o = new api.Timestamp();
  buildCounterTimestamp++;
  if (buildCounterTimestamp < 3) {
    o.nanos = 42;
    o.seconds = "foo";
  }
  buildCounterTimestamp--;
  return o;
}

checkTimestamp(api.Timestamp o) {
  buildCounterTimestamp++;
  if (buildCounterTimestamp < 3) {
    unittest.expect(o.nanos, unittest.equals(42));
    unittest.expect(o.seconds, unittest.equals('foo'));
  }
  buildCounterTimestamp--;
}

buildUnnamed1658() {
  var o = new core.List<api.Condition>();
  o.add(buildCondition());
  o.add(buildCondition());
  return o;
}

checkUnnamed1658(core.List<api.Condition> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCondition(o[0]);
  checkCondition(o[1]);
}

buildUnnamed1659() {
  var o = new core.List<api.Condition>();
  o.add(buildCondition());
  o.add(buildCondition());
  return o;
}

checkUnnamed1659(core.List<api.Condition> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCondition(o[0]);
  checkCondition(o[1]);
}

buildUnnamed1660() {
  var o = new core.List<api.Condition>();
  o.add(buildCondition());
  o.add(buildCondition());
  return o;
}

checkUnnamed1660(core.List<api.Condition> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCondition(o[0]);
  checkCondition(o[1]);
}

buildUnnamed1661() {
  var o = new core.List<api.Parameter>();
  o.add(buildParameter());
  o.add(buildParameter());
  return o;
}

checkUnnamed1661(core.List<api.Parameter> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkParameter(o[0]);
  checkParameter(o[1]);
}

core.int buildCounterTrigger = 0;
buildTrigger() {
  var o = new api.Trigger();
  buildCounterTrigger++;
  if (buildCounterTrigger < 3) {
    o.accountId = "foo";
    o.autoEventFilter = buildUnnamed1658();
    o.checkValidation = buildParameter();
    o.containerId = "foo";
    o.continuousTimeMinMilliseconds = buildParameter();
    o.customEventFilter = buildUnnamed1659();
    o.eventName = buildParameter();
    o.filter = buildUnnamed1660();
    o.fingerprint = "foo";
    o.horizontalScrollPercentageList = buildParameter();
    o.interval = buildParameter();
    o.intervalSeconds = buildParameter();
    o.limit = buildParameter();
    o.maxTimerLengthSeconds = buildParameter();
    o.name = "foo";
    o.notes = "foo";
    o.parameter = buildUnnamed1661();
    o.parentFolderId = "foo";
    o.path = "foo";
    o.selector = buildParameter();
    o.tagManagerUrl = "foo";
    o.totalTimeMinMilliseconds = buildParameter();
    o.triggerId = "foo";
    o.type = "foo";
    o.uniqueTriggerId = buildParameter();
    o.verticalScrollPercentageList = buildParameter();
    o.visibilitySelector = buildParameter();
    o.visiblePercentageMax = buildParameter();
    o.visiblePercentageMin = buildParameter();
    o.waitForTags = buildParameter();
    o.waitForTagsTimeout = buildParameter();
    o.workspaceId = "foo";
  }
  buildCounterTrigger--;
  return o;
}

checkTrigger(api.Trigger o) {
  buildCounterTrigger++;
  if (buildCounterTrigger < 3) {
    unittest.expect(o.accountId, unittest.equals('foo'));
    checkUnnamed1658(o.autoEventFilter);
    checkParameter(o.checkValidation);
    unittest.expect(o.containerId, unittest.equals('foo'));
    checkParameter(o.continuousTimeMinMilliseconds);
    checkUnnamed1659(o.customEventFilter);
    checkParameter(o.eventName);
    checkUnnamed1660(o.filter);
    unittest.expect(o.fingerprint, unittest.equals('foo'));
    checkParameter(o.horizontalScrollPercentageList);
    checkParameter(o.interval);
    checkParameter(o.intervalSeconds);
    checkParameter(o.limit);
    checkParameter(o.maxTimerLengthSeconds);
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.notes, unittest.equals('foo'));
    checkUnnamed1661(o.parameter);
    unittest.expect(o.parentFolderId, unittest.equals('foo'));
    unittest.expect(o.path, unittest.equals('foo'));
    checkParameter(o.selector);
    unittest.expect(o.tagManagerUrl, unittest.equals('foo'));
    checkParameter(o.totalTimeMinMilliseconds);
    unittest.expect(o.triggerId, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
    checkParameter(o.uniqueTriggerId);
    checkParameter(o.verticalScrollPercentageList);
    checkParameter(o.visibilitySelector);
    checkParameter(o.visiblePercentageMax);
    checkParameter(o.visiblePercentageMin);
    checkParameter(o.waitForTags);
    checkParameter(o.waitForTagsTimeout);
    unittest.expect(o.workspaceId, unittest.equals('foo'));
  }
  buildCounterTrigger--;
}

buildUnnamed1662() {
  var o = new core.List<api.WorkspaceProposalUser>();
  o.add(buildWorkspaceProposalUser());
  o.add(buildWorkspaceProposalUser());
  return o;
}

checkUnnamed1662(core.List<api.WorkspaceProposalUser> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkWorkspaceProposalUser(o[0]);
  checkWorkspaceProposalUser(o[1]);
}

core.int buildCounterUpdateWorkspaceProposalRequest = 0;
buildUpdateWorkspaceProposalRequest() {
  var o = new api.UpdateWorkspaceProposalRequest();
  buildCounterUpdateWorkspaceProposalRequest++;
  if (buildCounterUpdateWorkspaceProposalRequest < 3) {
    o.fingerprint = "foo";
    o.newComment = buildWorkspaceProposalHistoryComment();
    o.reviewers = buildUnnamed1662();
    o.status = "foo";
  }
  buildCounterUpdateWorkspaceProposalRequest--;
  return o;
}

checkUpdateWorkspaceProposalRequest(api.UpdateWorkspaceProposalRequest o) {
  buildCounterUpdateWorkspaceProposalRequest++;
  if (buildCounterUpdateWorkspaceProposalRequest < 3) {
    unittest.expect(o.fingerprint, unittest.equals('foo'));
    checkWorkspaceProposalHistoryComment(o.newComment);
    checkUnnamed1662(o.reviewers);
    unittest.expect(o.status, unittest.equals('foo'));
  }
  buildCounterUpdateWorkspaceProposalRequest--;
}

buildUnnamed1663() {
  var o = new core.List<api.ContainerAccess>();
  o.add(buildContainerAccess());
  o.add(buildContainerAccess());
  return o;
}

checkUnnamed1663(core.List<api.ContainerAccess> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkContainerAccess(o[0]);
  checkContainerAccess(o[1]);
}

core.int buildCounterUserPermission = 0;
buildUserPermission() {
  var o = new api.UserPermission();
  buildCounterUserPermission++;
  if (buildCounterUserPermission < 3) {
    o.accountAccess = buildAccountAccess();
    o.accountId = "foo";
    o.containerAccess = buildUnnamed1663();
    o.emailAddress = "foo";
    o.path = "foo";
  }
  buildCounterUserPermission--;
  return o;
}

checkUserPermission(api.UserPermission o) {
  buildCounterUserPermission++;
  if (buildCounterUserPermission < 3) {
    checkAccountAccess(o.accountAccess);
    unittest.expect(o.accountId, unittest.equals('foo'));
    checkUnnamed1663(o.containerAccess);
    unittest.expect(o.emailAddress, unittest.equals('foo'));
    unittest.expect(o.path, unittest.equals('foo'));
  }
  buildCounterUserPermission--;
}

buildUnnamed1664() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1664(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1665() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1665(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1666() {
  var o = new core.List<api.Parameter>();
  o.add(buildParameter());
  o.add(buildParameter());
  return o;
}

checkUnnamed1666(core.List<api.Parameter> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkParameter(o[0]);
  checkParameter(o[1]);
}

core.int buildCounterVariable = 0;
buildVariable() {
  var o = new api.Variable();
  buildCounterVariable++;
  if (buildCounterVariable < 3) {
    o.accountId = "foo";
    o.containerId = "foo";
    o.disablingTriggerId = buildUnnamed1664();
    o.enablingTriggerId = buildUnnamed1665();
    o.fingerprint = "foo";
    o.name = "foo";
    o.notes = "foo";
    o.parameter = buildUnnamed1666();
    o.parentFolderId = "foo";
    o.path = "foo";
    o.scheduleEndMs = "foo";
    o.scheduleStartMs = "foo";
    o.tagManagerUrl = "foo";
    o.type = "foo";
    o.variableId = "foo";
    o.workspaceId = "foo";
  }
  buildCounterVariable--;
  return o;
}

checkVariable(api.Variable o) {
  buildCounterVariable++;
  if (buildCounterVariable < 3) {
    unittest.expect(o.accountId, unittest.equals('foo'));
    unittest.expect(o.containerId, unittest.equals('foo'));
    checkUnnamed1664(o.disablingTriggerId);
    checkUnnamed1665(o.enablingTriggerId);
    unittest.expect(o.fingerprint, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.notes, unittest.equals('foo'));
    checkUnnamed1666(o.parameter);
    unittest.expect(o.parentFolderId, unittest.equals('foo'));
    unittest.expect(o.path, unittest.equals('foo'));
    unittest.expect(o.scheduleEndMs, unittest.equals('foo'));
    unittest.expect(o.scheduleStartMs, unittest.equals('foo'));
    unittest.expect(o.tagManagerUrl, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
    unittest.expect(o.variableId, unittest.equals('foo'));
    unittest.expect(o.workspaceId, unittest.equals('foo'));
  }
  buildCounterVariable--;
}

core.int buildCounterWorkspace = 0;
buildWorkspace() {
  var o = new api.Workspace();
  buildCounterWorkspace++;
  if (buildCounterWorkspace < 3) {
    o.accountId = "foo";
    o.containerId = "foo";
    o.description = "foo";
    o.fingerprint = "foo";
    o.name = "foo";
    o.path = "foo";
    o.tagManagerUrl = "foo";
    o.workspaceId = "foo";
  }
  buildCounterWorkspace--;
  return o;
}

checkWorkspace(api.Workspace o) {
  buildCounterWorkspace++;
  if (buildCounterWorkspace < 3) {
    unittest.expect(o.accountId, unittest.equals('foo'));
    unittest.expect(o.containerId, unittest.equals('foo'));
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.fingerprint, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.path, unittest.equals('foo'));
    unittest.expect(o.tagManagerUrl, unittest.equals('foo'));
    unittest.expect(o.workspaceId, unittest.equals('foo'));
  }
  buildCounterWorkspace--;
}

buildUnnamed1667() {
  var o = new core.List<api.WorkspaceProposalUser>();
  o.add(buildWorkspaceProposalUser());
  o.add(buildWorkspaceProposalUser());
  return o;
}

checkUnnamed1667(core.List<api.WorkspaceProposalUser> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkWorkspaceProposalUser(o[0]);
  checkWorkspaceProposalUser(o[1]);
}

buildUnnamed1668() {
  var o = new core.List<api.WorkspaceProposalHistory>();
  o.add(buildWorkspaceProposalHistory());
  o.add(buildWorkspaceProposalHistory());
  return o;
}

checkUnnamed1668(core.List<api.WorkspaceProposalHistory> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkWorkspaceProposalHistory(o[0]);
  checkWorkspaceProposalHistory(o[1]);
}

buildUnnamed1669() {
  var o = new core.List<api.WorkspaceProposalUser>();
  o.add(buildWorkspaceProposalUser());
  o.add(buildWorkspaceProposalUser());
  return o;
}

checkUnnamed1669(core.List<api.WorkspaceProposalUser> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkWorkspaceProposalUser(o[0]);
  checkWorkspaceProposalUser(o[1]);
}

core.int buildCounterWorkspaceProposal = 0;
buildWorkspaceProposal() {
  var o = new api.WorkspaceProposal();
  buildCounterWorkspaceProposal++;
  if (buildCounterWorkspaceProposal < 3) {
    o.authors = buildUnnamed1667();
    o.fingerprint = "foo";
    o.history = buildUnnamed1668();
    o.path = "foo";
    o.reviewers = buildUnnamed1669();
    o.status = "foo";
  }
  buildCounterWorkspaceProposal--;
  return o;
}

checkWorkspaceProposal(api.WorkspaceProposal o) {
  buildCounterWorkspaceProposal++;
  if (buildCounterWorkspaceProposal < 3) {
    checkUnnamed1667(o.authors);
    unittest.expect(o.fingerprint, unittest.equals('foo'));
    checkUnnamed1668(o.history);
    unittest.expect(o.path, unittest.equals('foo'));
    checkUnnamed1669(o.reviewers);
    unittest.expect(o.status, unittest.equals('foo'));
  }
  buildCounterWorkspaceProposal--;
}

core.int buildCounterWorkspaceProposalHistory = 0;
buildWorkspaceProposalHistory() {
  var o = new api.WorkspaceProposalHistory();
  buildCounterWorkspaceProposalHistory++;
  if (buildCounterWorkspaceProposalHistory < 3) {
    o.comment = buildWorkspaceProposalHistoryComment();
    o.createdBy = buildWorkspaceProposalUser();
    o.createdTimestamp = buildTimestamp();
    o.statusChange = buildWorkspaceProposalHistoryStatusChange();
    o.type = "foo";
  }
  buildCounterWorkspaceProposalHistory--;
  return o;
}

checkWorkspaceProposalHistory(api.WorkspaceProposalHistory o) {
  buildCounterWorkspaceProposalHistory++;
  if (buildCounterWorkspaceProposalHistory < 3) {
    checkWorkspaceProposalHistoryComment(o.comment);
    checkWorkspaceProposalUser(o.createdBy);
    checkTimestamp(o.createdTimestamp);
    checkWorkspaceProposalHistoryStatusChange(o.statusChange);
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterWorkspaceProposalHistory--;
}

core.int buildCounterWorkspaceProposalHistoryComment = 0;
buildWorkspaceProposalHistoryComment() {
  var o = new api.WorkspaceProposalHistoryComment();
  buildCounterWorkspaceProposalHistoryComment++;
  if (buildCounterWorkspaceProposalHistoryComment < 3) {
    o.content = "foo";
  }
  buildCounterWorkspaceProposalHistoryComment--;
  return o;
}

checkWorkspaceProposalHistoryComment(api.WorkspaceProposalHistoryComment o) {
  buildCounterWorkspaceProposalHistoryComment++;
  if (buildCounterWorkspaceProposalHistoryComment < 3) {
    unittest.expect(o.content, unittest.equals('foo'));
  }
  buildCounterWorkspaceProposalHistoryComment--;
}

core.int buildCounterWorkspaceProposalHistoryStatusChange = 0;
buildWorkspaceProposalHistoryStatusChange() {
  var o = new api.WorkspaceProposalHistoryStatusChange();
  buildCounterWorkspaceProposalHistoryStatusChange++;
  if (buildCounterWorkspaceProposalHistoryStatusChange < 3) {
    o.newStatus = "foo";
    o.oldStatus = "foo";
  }
  buildCounterWorkspaceProposalHistoryStatusChange--;
  return o;
}

checkWorkspaceProposalHistoryStatusChange(
    api.WorkspaceProposalHistoryStatusChange o) {
  buildCounterWorkspaceProposalHistoryStatusChange++;
  if (buildCounterWorkspaceProposalHistoryStatusChange < 3) {
    unittest.expect(o.newStatus, unittest.equals('foo'));
    unittest.expect(o.oldStatus, unittest.equals('foo'));
  }
  buildCounterWorkspaceProposalHistoryStatusChange--;
}

core.int buildCounterWorkspaceProposalUser = 0;
buildWorkspaceProposalUser() {
  var o = new api.WorkspaceProposalUser();
  buildCounterWorkspaceProposalUser++;
  if (buildCounterWorkspaceProposalUser < 3) {
    o.gaiaId = "foo";
    o.type = "foo";
  }
  buildCounterWorkspaceProposalUser--;
  return o;
}

checkWorkspaceProposalUser(api.WorkspaceProposalUser o) {
  buildCounterWorkspaceProposalUser++;
  if (buildCounterWorkspaceProposalUser < 3) {
    unittest.expect(o.gaiaId, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterWorkspaceProposalUser--;
}

buildUnnamed1670() {
  var o = new core.List<api.ZoneChildContainer>();
  o.add(buildZoneChildContainer());
  o.add(buildZoneChildContainer());
  return o;
}

checkUnnamed1670(core.List<api.ZoneChildContainer> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkZoneChildContainer(o[0]);
  checkZoneChildContainer(o[1]);
}

core.int buildCounterZone = 0;
buildZone() {
  var o = new api.Zone();
  buildCounterZone++;
  if (buildCounterZone < 3) {
    o.accountId = "foo";
    o.boundary = buildZoneBoundary();
    o.childContainer = buildUnnamed1670();
    o.containerId = "foo";
    o.fingerprint = "foo";
    o.name = "foo";
    o.notes = "foo";
    o.path = "foo";
    o.tagManagerUrl = "foo";
    o.typeRestriction = buildZoneTypeRestriction();
    o.workspaceId = "foo";
    o.zoneId = "foo";
  }
  buildCounterZone--;
  return o;
}

checkZone(api.Zone o) {
  buildCounterZone++;
  if (buildCounterZone < 3) {
    unittest.expect(o.accountId, unittest.equals('foo'));
    checkZoneBoundary(o.boundary);
    checkUnnamed1670(o.childContainer);
    unittest.expect(o.containerId, unittest.equals('foo'));
    unittest.expect(o.fingerprint, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.notes, unittest.equals('foo'));
    unittest.expect(o.path, unittest.equals('foo'));
    unittest.expect(o.tagManagerUrl, unittest.equals('foo'));
    checkZoneTypeRestriction(o.typeRestriction);
    unittest.expect(o.workspaceId, unittest.equals('foo'));
    unittest.expect(o.zoneId, unittest.equals('foo'));
  }
  buildCounterZone--;
}

buildUnnamed1671() {
  var o = new core.List<api.Condition>();
  o.add(buildCondition());
  o.add(buildCondition());
  return o;
}

checkUnnamed1671(core.List<api.Condition> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCondition(o[0]);
  checkCondition(o[1]);
}

buildUnnamed1672() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1672(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterZoneBoundary = 0;
buildZoneBoundary() {
  var o = new api.ZoneBoundary();
  buildCounterZoneBoundary++;
  if (buildCounterZoneBoundary < 3) {
    o.condition = buildUnnamed1671();
    o.customEvaluationTriggerId = buildUnnamed1672();
  }
  buildCounterZoneBoundary--;
  return o;
}

checkZoneBoundary(api.ZoneBoundary o) {
  buildCounterZoneBoundary++;
  if (buildCounterZoneBoundary < 3) {
    checkUnnamed1671(o.condition);
    checkUnnamed1672(o.customEvaluationTriggerId);
  }
  buildCounterZoneBoundary--;
}

core.int buildCounterZoneChildContainer = 0;
buildZoneChildContainer() {
  var o = new api.ZoneChildContainer();
  buildCounterZoneChildContainer++;
  if (buildCounterZoneChildContainer < 3) {
    o.nickname = "foo";
    o.publicId = "foo";
  }
  buildCounterZoneChildContainer--;
  return o;
}

checkZoneChildContainer(api.ZoneChildContainer o) {
  buildCounterZoneChildContainer++;
  if (buildCounterZoneChildContainer < 3) {
    unittest.expect(o.nickname, unittest.equals('foo'));
    unittest.expect(o.publicId, unittest.equals('foo'));
  }
  buildCounterZoneChildContainer--;
}

buildUnnamed1673() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1673(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterZoneTypeRestriction = 0;
buildZoneTypeRestriction() {
  var o = new api.ZoneTypeRestriction();
  buildCounterZoneTypeRestriction++;
  if (buildCounterZoneTypeRestriction < 3) {
    o.enable = true;
    o.whitelistedTypeId = buildUnnamed1673();
  }
  buildCounterZoneTypeRestriction--;
  return o;
}

checkZoneTypeRestriction(api.ZoneTypeRestriction o) {
  buildCounterZoneTypeRestriction++;
  if (buildCounterZoneTypeRestriction < 3) {
    unittest.expect(o.enable, unittest.isTrue);
    checkUnnamed1673(o.whitelistedTypeId);
  }
  buildCounterZoneTypeRestriction--;
}

buildUnnamed1674() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1674(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1675() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1675(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1676() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1676(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1677() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1677(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1678() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1678(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

main() {
  unittest.group("obj-schema-Account", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccount();
      var od = new api.Account.fromJson(o.toJson());
      checkAccount(od);
    });
  });

  unittest.group("obj-schema-AccountAccess", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccountAccess();
      var od = new api.AccountAccess.fromJson(o.toJson());
      checkAccountAccess(od);
    });
  });

  unittest.group("obj-schema-BuiltInVariable", () {
    unittest.test("to-json--from-json", () {
      var o = buildBuiltInVariable();
      var od = new api.BuiltInVariable.fromJson(o.toJson());
      checkBuiltInVariable(od);
    });
  });

  unittest.group("obj-schema-Condition", () {
    unittest.test("to-json--from-json", () {
      var o = buildCondition();
      var od = new api.Condition.fromJson(o.toJson());
      checkCondition(od);
    });
  });

  unittest.group("obj-schema-Container", () {
    unittest.test("to-json--from-json", () {
      var o = buildContainer();
      var od = new api.Container.fromJson(o.toJson());
      checkContainer(od);
    });
  });

  unittest.group("obj-schema-ContainerAccess", () {
    unittest.test("to-json--from-json", () {
      var o = buildContainerAccess();
      var od = new api.ContainerAccess.fromJson(o.toJson());
      checkContainerAccess(od);
    });
  });

  unittest.group("obj-schema-ContainerVersion", () {
    unittest.test("to-json--from-json", () {
      var o = buildContainerVersion();
      var od = new api.ContainerVersion.fromJson(o.toJson());
      checkContainerVersion(od);
    });
  });

  unittest.group("obj-schema-ContainerVersionHeader", () {
    unittest.test("to-json--from-json", () {
      var o = buildContainerVersionHeader();
      var od = new api.ContainerVersionHeader.fromJson(o.toJson());
      checkContainerVersionHeader(od);
    });
  });

  unittest.group("obj-schema-CreateBuiltInVariableResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreateBuiltInVariableResponse();
      var od = new api.CreateBuiltInVariableResponse.fromJson(o.toJson());
      checkCreateBuiltInVariableResponse(od);
    });
  });

  unittest.group("obj-schema-CreateContainerVersionRequestVersionOptions", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreateContainerVersionRequestVersionOptions();
      var od = new api.CreateContainerVersionRequestVersionOptions.fromJson(
          o.toJson());
      checkCreateContainerVersionRequestVersionOptions(od);
    });
  });

  unittest.group("obj-schema-CreateContainerVersionResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreateContainerVersionResponse();
      var od = new api.CreateContainerVersionResponse.fromJson(o.toJson());
      checkCreateContainerVersionResponse(od);
    });
  });

  unittest.group("obj-schema-CreateWorkspaceProposalRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildCreateWorkspaceProposalRequest();
      var od = new api.CreateWorkspaceProposalRequest.fromJson(o.toJson());
      checkCreateWorkspaceProposalRequest(od);
    });
  });

  unittest.group("obj-schema-Entity", () {
    unittest.test("to-json--from-json", () {
      var o = buildEntity();
      var od = new api.Entity.fromJson(o.toJson());
      checkEntity(od);
    });
  });

  unittest.group("obj-schema-Environment", () {
    unittest.test("to-json--from-json", () {
      var o = buildEnvironment();
      var od = new api.Environment.fromJson(o.toJson());
      checkEnvironment(od);
    });
  });

  unittest.group("obj-schema-Folder", () {
    unittest.test("to-json--from-json", () {
      var o = buildFolder();
      var od = new api.Folder.fromJson(o.toJson());
      checkFolder(od);
    });
  });

  unittest.group("obj-schema-FolderEntities", () {
    unittest.test("to-json--from-json", () {
      var o = buildFolderEntities();
      var od = new api.FolderEntities.fromJson(o.toJson());
      checkFolderEntities(od);
    });
  });

  unittest.group("obj-schema-GetWorkspaceStatusResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildGetWorkspaceStatusResponse();
      var od = new api.GetWorkspaceStatusResponse.fromJson(o.toJson());
      checkGetWorkspaceStatusResponse(od);
    });
  });

  unittest.group("obj-schema-ListAccountsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListAccountsResponse();
      var od = new api.ListAccountsResponse.fromJson(o.toJson());
      checkListAccountsResponse(od);
    });
  });

  unittest.group("obj-schema-ListContainerVersionsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListContainerVersionsResponse();
      var od = new api.ListContainerVersionsResponse.fromJson(o.toJson());
      checkListContainerVersionsResponse(od);
    });
  });

  unittest.group("obj-schema-ListContainersResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListContainersResponse();
      var od = new api.ListContainersResponse.fromJson(o.toJson());
      checkListContainersResponse(od);
    });
  });

  unittest.group("obj-schema-ListEnabledBuiltInVariablesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListEnabledBuiltInVariablesResponse();
      var od = new api.ListEnabledBuiltInVariablesResponse.fromJson(o.toJson());
      checkListEnabledBuiltInVariablesResponse(od);
    });
  });

  unittest.group("obj-schema-ListEnvironmentsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListEnvironmentsResponse();
      var od = new api.ListEnvironmentsResponse.fromJson(o.toJson());
      checkListEnvironmentsResponse(od);
    });
  });

  unittest.group("obj-schema-ListFoldersResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListFoldersResponse();
      var od = new api.ListFoldersResponse.fromJson(o.toJson());
      checkListFoldersResponse(od);
    });
  });

  unittest.group("obj-schema-ListTagsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListTagsResponse();
      var od = new api.ListTagsResponse.fromJson(o.toJson());
      checkListTagsResponse(od);
    });
  });

  unittest.group("obj-schema-ListTriggersResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListTriggersResponse();
      var od = new api.ListTriggersResponse.fromJson(o.toJson());
      checkListTriggersResponse(od);
    });
  });

  unittest.group("obj-schema-ListUserPermissionsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListUserPermissionsResponse();
      var od = new api.ListUserPermissionsResponse.fromJson(o.toJson());
      checkListUserPermissionsResponse(od);
    });
  });

  unittest.group("obj-schema-ListVariablesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListVariablesResponse();
      var od = new api.ListVariablesResponse.fromJson(o.toJson());
      checkListVariablesResponse(od);
    });
  });

  unittest.group("obj-schema-ListWorkspacesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListWorkspacesResponse();
      var od = new api.ListWorkspacesResponse.fromJson(o.toJson());
      checkListWorkspacesResponse(od);
    });
  });

  unittest.group("obj-schema-MergeConflict", () {
    unittest.test("to-json--from-json", () {
      var o = buildMergeConflict();
      var od = new api.MergeConflict.fromJson(o.toJson());
      checkMergeConflict(od);
    });
  });

  unittest.group("obj-schema-Parameter", () {
    unittest.test("to-json--from-json", () {
      var o = buildParameter();
      var od = new api.Parameter.fromJson(o.toJson());
      checkParameter(od);
    });
  });

  unittest.group("obj-schema-PublishContainerVersionResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildPublishContainerVersionResponse();
      var od = new api.PublishContainerVersionResponse.fromJson(o.toJson());
      checkPublishContainerVersionResponse(od);
    });
  });

  unittest.group("obj-schema-QuickPreviewResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildQuickPreviewResponse();
      var od = new api.QuickPreviewResponse.fromJson(o.toJson());
      checkQuickPreviewResponse(od);
    });
  });

  unittest.group("obj-schema-RevertBuiltInVariableResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildRevertBuiltInVariableResponse();
      var od = new api.RevertBuiltInVariableResponse.fromJson(o.toJson());
      checkRevertBuiltInVariableResponse(od);
    });
  });

  unittest.group("obj-schema-RevertFolderResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildRevertFolderResponse();
      var od = new api.RevertFolderResponse.fromJson(o.toJson());
      checkRevertFolderResponse(od);
    });
  });

  unittest.group("obj-schema-RevertTagResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildRevertTagResponse();
      var od = new api.RevertTagResponse.fromJson(o.toJson());
      checkRevertTagResponse(od);
    });
  });

  unittest.group("obj-schema-RevertTriggerResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildRevertTriggerResponse();
      var od = new api.RevertTriggerResponse.fromJson(o.toJson());
      checkRevertTriggerResponse(od);
    });
  });

  unittest.group("obj-schema-RevertVariableResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildRevertVariableResponse();
      var od = new api.RevertVariableResponse.fromJson(o.toJson());
      checkRevertVariableResponse(od);
    });
  });

  unittest.group("obj-schema-SetupTag", () {
    unittest.test("to-json--from-json", () {
      var o = buildSetupTag();
      var od = new api.SetupTag.fromJson(o.toJson());
      checkSetupTag(od);
    });
  });

  unittest.group("obj-schema-SyncStatus", () {
    unittest.test("to-json--from-json", () {
      var o = buildSyncStatus();
      var od = new api.SyncStatus.fromJson(o.toJson());
      checkSyncStatus(od);
    });
  });

  unittest.group("obj-schema-SyncWorkspaceResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildSyncWorkspaceResponse();
      var od = new api.SyncWorkspaceResponse.fromJson(o.toJson());
      checkSyncWorkspaceResponse(od);
    });
  });

  unittest.group("obj-schema-Tag", () {
    unittest.test("to-json--from-json", () {
      var o = buildTag();
      var od = new api.Tag.fromJson(o.toJson());
      checkTag(od);
    });
  });

  unittest.group("obj-schema-TeardownTag", () {
    unittest.test("to-json--from-json", () {
      var o = buildTeardownTag();
      var od = new api.TeardownTag.fromJson(o.toJson());
      checkTeardownTag(od);
    });
  });

  unittest.group("obj-schema-Timestamp", () {
    unittest.test("to-json--from-json", () {
      var o = buildTimestamp();
      var od = new api.Timestamp.fromJson(o.toJson());
      checkTimestamp(od);
    });
  });

  unittest.group("obj-schema-Trigger", () {
    unittest.test("to-json--from-json", () {
      var o = buildTrigger();
      var od = new api.Trigger.fromJson(o.toJson());
      checkTrigger(od);
    });
  });

  unittest.group("obj-schema-UpdateWorkspaceProposalRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildUpdateWorkspaceProposalRequest();
      var od = new api.UpdateWorkspaceProposalRequest.fromJson(o.toJson());
      checkUpdateWorkspaceProposalRequest(od);
    });
  });

  unittest.group("obj-schema-UserPermission", () {
    unittest.test("to-json--from-json", () {
      var o = buildUserPermission();
      var od = new api.UserPermission.fromJson(o.toJson());
      checkUserPermission(od);
    });
  });

  unittest.group("obj-schema-Variable", () {
    unittest.test("to-json--from-json", () {
      var o = buildVariable();
      var od = new api.Variable.fromJson(o.toJson());
      checkVariable(od);
    });
  });

  unittest.group("obj-schema-Workspace", () {
    unittest.test("to-json--from-json", () {
      var o = buildWorkspace();
      var od = new api.Workspace.fromJson(o.toJson());
      checkWorkspace(od);
    });
  });

  unittest.group("obj-schema-WorkspaceProposal", () {
    unittest.test("to-json--from-json", () {
      var o = buildWorkspaceProposal();
      var od = new api.WorkspaceProposal.fromJson(o.toJson());
      checkWorkspaceProposal(od);
    });
  });

  unittest.group("obj-schema-WorkspaceProposalHistory", () {
    unittest.test("to-json--from-json", () {
      var o = buildWorkspaceProposalHistory();
      var od = new api.WorkspaceProposalHistory.fromJson(o.toJson());
      checkWorkspaceProposalHistory(od);
    });
  });

  unittest.group("obj-schema-WorkspaceProposalHistoryComment", () {
    unittest.test("to-json--from-json", () {
      var o = buildWorkspaceProposalHistoryComment();
      var od = new api.WorkspaceProposalHistoryComment.fromJson(o.toJson());
      checkWorkspaceProposalHistoryComment(od);
    });
  });

  unittest.group("obj-schema-WorkspaceProposalHistoryStatusChange", () {
    unittest.test("to-json--from-json", () {
      var o = buildWorkspaceProposalHistoryStatusChange();
      var od =
          new api.WorkspaceProposalHistoryStatusChange.fromJson(o.toJson());
      checkWorkspaceProposalHistoryStatusChange(od);
    });
  });

  unittest.group("obj-schema-WorkspaceProposalUser", () {
    unittest.test("to-json--from-json", () {
      var o = buildWorkspaceProposalUser();
      var od = new api.WorkspaceProposalUser.fromJson(o.toJson());
      checkWorkspaceProposalUser(od);
    });
  });

  unittest.group("obj-schema-Zone", () {
    unittest.test("to-json--from-json", () {
      var o = buildZone();
      var od = new api.Zone.fromJson(o.toJson());
      checkZone(od);
    });
  });

  unittest.group("obj-schema-ZoneBoundary", () {
    unittest.test("to-json--from-json", () {
      var o = buildZoneBoundary();
      var od = new api.ZoneBoundary.fromJson(o.toJson());
      checkZoneBoundary(od);
    });
  });

  unittest.group("obj-schema-ZoneChildContainer", () {
    unittest.test("to-json--from-json", () {
      var o = buildZoneChildContainer();
      var od = new api.ZoneChildContainer.fromJson(o.toJson());
      checkZoneChildContainer(od);
    });
  });

  unittest.group("obj-schema-ZoneTypeRestriction", () {
    unittest.test("to-json--from-json", () {
      var o = buildZoneTypeRestriction();
      var od = new api.ZoneTypeRestriction.fromJson(o.toJson());
      checkZoneTypeRestriction(od);
    });
  });

  unittest.group("resource-AccountsResourceApi", () {
    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.AccountsResourceApi res = new api.TagmanagerApi(mock).accounts;
      var arg_path = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildAccount());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAccount(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsResourceApi res = new api.TagmanagerApi(mock).accounts;
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
        unittest.expect(path.substring(pathOffset, pathOffset + 14),
            unittest.equals("tagmanager/v2/"));
        pathOffset += 14;
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("accounts"));
        pathOffset += 8;

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
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildListAccountsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(pageToken: arg_pageToken, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkListAccountsResponse(response);
      })));
    });

    unittest.test("method--update", () {
      var mock = new HttpServerMock();
      api.AccountsResourceApi res = new api.TagmanagerApi(mock).accounts;
      var arg_request = buildAccount();
      var arg_path = "foo";
      var arg_fingerprint = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Account.fromJson(json);
        checkAccount(obj);

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
            queryMap["fingerprint"].first, unittest.equals(arg_fingerprint));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildAccount());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .update(arg_request, arg_path,
              fingerprint: arg_fingerprint, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAccount(response);
      })));
    });
  });

  unittest.group("resource-AccountsContainersResourceApi", () {
    unittest.test("method--create", () {
      var mock = new HttpServerMock();
      api.AccountsContainersResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers;
      var arg_request = buildContainer();
      var arg_parent = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Container.fromJson(json);
        checkContainer(obj);

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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildContainer());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .create(arg_request, arg_parent, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkContainer(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.AccountsContainersResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers;
      var arg_path = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.AccountsContainersResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers;
      var arg_path = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildContainer());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkContainer(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsContainersResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers;
      var arg_parent = "foo";
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
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildListContainersResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_parent, pageToken: arg_pageToken, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkListContainersResponse(response);
      })));
    });

    unittest.test("method--update", () {
      var mock = new HttpServerMock();
      api.AccountsContainersResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers;
      var arg_request = buildContainer();
      var arg_path = "foo";
      var arg_fingerprint = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Container.fromJson(json);
        checkContainer(obj);

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
            queryMap["fingerprint"].first, unittest.equals(arg_fingerprint));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildContainer());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .update(arg_request, arg_path,
              fingerprint: arg_fingerprint, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkContainer(response);
      })));
    });
  });

  unittest.group("resource-AccountsContainersEnvironmentsResourceApi", () {
    unittest.test("method--create", () {
      var mock = new HttpServerMock();
      api.AccountsContainersEnvironmentsResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.environments;
      var arg_request = buildEnvironment();
      var arg_parent = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Environment.fromJson(json);
        checkEnvironment(obj);

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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildEnvironment());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .create(arg_request, arg_parent, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkEnvironment(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.AccountsContainersEnvironmentsResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.environments;
      var arg_path = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.AccountsContainersEnvironmentsResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.environments;
      var arg_path = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildEnvironment());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkEnvironment(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsContainersEnvironmentsResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.environments;
      var arg_parent = "foo";
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
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildListEnvironmentsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_parent, pageToken: arg_pageToken, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkListEnvironmentsResponse(response);
      })));
    });

    unittest.test("method--patch", () {
      var mock = new HttpServerMock();
      api.AccountsContainersEnvironmentsResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.environments;
      var arg_request = buildEnvironment();
      var arg_path = "foo";
      var arg_fingerprint = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Environment.fromJson(json);
        checkEnvironment(obj);

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
            queryMap["fingerprint"].first, unittest.equals(arg_fingerprint));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildEnvironment());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .patch(arg_request, arg_path,
              fingerprint: arg_fingerprint, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkEnvironment(response);
      })));
    });

    unittest.test("method--reauthorize", () {
      var mock = new HttpServerMock();
      api.AccountsContainersEnvironmentsResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.environments;
      var arg_request = buildEnvironment();
      var arg_path = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Environment.fromJson(json);
        checkEnvironment(obj);

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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildEnvironment());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .reauthorize(arg_request, arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkEnvironment(response);
      })));
    });

    unittest.test("method--update", () {
      var mock = new HttpServerMock();
      api.AccountsContainersEnvironmentsResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.environments;
      var arg_request = buildEnvironment();
      var arg_path = "foo";
      var arg_fingerprint = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Environment.fromJson(json);
        checkEnvironment(obj);

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
            queryMap["fingerprint"].first, unittest.equals(arg_fingerprint));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildEnvironment());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .update(arg_request, arg_path,
              fingerprint: arg_fingerprint, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkEnvironment(response);
      })));
    });
  });

  unittest.group("resource-AccountsContainersVersionHeadersResourceApi", () {
    unittest.test("method--latest", () {
      var mock = new HttpServerMock();
      api.AccountsContainersVersionHeadersResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.versionHeaders;
      var arg_parent = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildContainerVersionHeader());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .latest(arg_parent, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkContainerVersionHeader(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsContainersVersionHeadersResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.versionHeaders;
      var arg_parent = "foo";
      var arg_includeDeleted = true;
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
        unittest.expect(queryMap["includeDeleted"].first,
            unittest.equals("$arg_includeDeleted"));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildListContainerVersionsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_parent,
              includeDeleted: arg_includeDeleted,
              pageToken: arg_pageToken,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkListContainerVersionsResponse(response);
      })));
    });
  });

  unittest.group("resource-AccountsContainersVersionsResourceApi", () {
    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.AccountsContainersVersionsResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.versions;
      var arg_path = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.AccountsContainersVersionsResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.versions;
      var arg_path = "foo";
      var arg_containerVersionId = "foo";
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
        unittest.expect(queryMap["containerVersionId"].first,
            unittest.equals(arg_containerVersionId));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildContainerVersion());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_path,
              containerVersionId: arg_containerVersionId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkContainerVersion(response);
      })));
    });

    unittest.test("method--live", () {
      var mock = new HttpServerMock();
      api.AccountsContainersVersionsResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.versions;
      var arg_parent = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildContainerVersion());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .live(arg_parent, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkContainerVersion(response);
      })));
    });

    unittest.test("method--publish", () {
      var mock = new HttpServerMock();
      api.AccountsContainersVersionsResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.versions;
      var arg_path = "foo";
      var arg_fingerprint = "foo";
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
            queryMap["fingerprint"].first, unittest.equals(arg_fingerprint));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildPublishContainerVersionResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .publish(arg_path, fingerprint: arg_fingerprint, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkPublishContainerVersionResponse(response);
      })));
    });

    unittest.test("method--setLatest", () {
      var mock = new HttpServerMock();
      api.AccountsContainersVersionsResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.versions;
      var arg_path = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildContainerVersion());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .setLatest(arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkContainerVersion(response);
      })));
    });

    unittest.test("method--undelete", () {
      var mock = new HttpServerMock();
      api.AccountsContainersVersionsResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.versions;
      var arg_path = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildContainerVersion());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .undelete(arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkContainerVersion(response);
      })));
    });

    unittest.test("method--update", () {
      var mock = new HttpServerMock();
      api.AccountsContainersVersionsResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.versions;
      var arg_request = buildContainerVersion();
      var arg_path = "foo";
      var arg_fingerprint = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.ContainerVersion.fromJson(json);
        checkContainerVersion(obj);

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
            queryMap["fingerprint"].first, unittest.equals(arg_fingerprint));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildContainerVersion());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .update(arg_request, arg_path,
              fingerprint: arg_fingerprint, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkContainerVersion(response);
      })));
    });
  });

  unittest.group("resource-AccountsContainersWorkspacesResourceApi", () {
    unittest.test("method--create", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces;
      var arg_request = buildWorkspace();
      var arg_parent = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Workspace.fromJson(json);
        checkWorkspace(obj);

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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildWorkspace());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .create(arg_request, arg_parent, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkWorkspace(response);
      })));
    });

    unittest.test("method--createVersion", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces;
      var arg_request = buildCreateContainerVersionRequestVersionOptions();
      var arg_path = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj =
            new api.CreateContainerVersionRequestVersionOptions.fromJson(json);
        checkCreateContainerVersionRequestVersionOptions(obj);

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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildCreateContainerVersionResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .createVersion(arg_request, arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkCreateContainerVersionResponse(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces;
      var arg_path = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces;
      var arg_path = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildWorkspace());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkWorkspace(response);
      })));
    });

    unittest.test("method--getProposal", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces;
      var arg_path = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildWorkspaceProposal());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .getProposal(arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkWorkspaceProposal(response);
      })));
    });

    unittest.test("method--getStatus", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces;
      var arg_path = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildGetWorkspaceStatusResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .getStatus(arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkGetWorkspaceStatusResponse(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces;
      var arg_parent = "foo";
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
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildListWorkspacesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_parent, pageToken: arg_pageToken, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkListWorkspacesResponse(response);
      })));
    });

    unittest.test("method--quickPreview", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces;
      var arg_path = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildQuickPreviewResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .quickPreview(arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkQuickPreviewResponse(response);
      })));
    });

    unittest.test("method--resolveConflict", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces;
      var arg_request = buildEntity();
      var arg_path = "foo";
      var arg_fingerprint = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Entity.fromJson(json);
        checkEntity(obj);

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
            queryMap["fingerprint"].first, unittest.equals(arg_fingerprint));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .resolveConflict(arg_request, arg_path,
              fingerprint: arg_fingerprint, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--sync", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces;
      var arg_path = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildSyncWorkspaceResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .sync(arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkSyncWorkspaceResponse(response);
      })));
    });

    unittest.test("method--update", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces;
      var arg_request = buildWorkspace();
      var arg_path = "foo";
      var arg_fingerprint = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Workspace.fromJson(json);
        checkWorkspace(obj);

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
            queryMap["fingerprint"].first, unittest.equals(arg_fingerprint));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildWorkspace());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .update(arg_request, arg_path,
              fingerprint: arg_fingerprint, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkWorkspace(response);
      })));
    });

    unittest.test("method--updateProposal", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces;
      var arg_request = buildUpdateWorkspaceProposalRequest();
      var arg_path = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.UpdateWorkspaceProposalRequest.fromJson(json);
        checkUpdateWorkspaceProposalRequest(obj);

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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildWorkspaceProposal());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .updateProposal(arg_request, arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkWorkspaceProposal(response);
      })));
    });
  });

  unittest.group(
      "resource-AccountsContainersWorkspacesBuiltInVariablesResourceApi", () {
    unittest.test("method--create", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesBuiltInVariablesResourceApi res =
          new api.TagmanagerApi(mock)
              .accounts
              .containers
              .workspaces
              .builtInVariables;
      var arg_parent = "foo";
      var arg_type = buildUnnamed1674();
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
        unittest.expect(queryMap["type"], unittest.equals(arg_type));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildCreateBuiltInVariableResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .create(arg_parent, type: arg_type, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkCreateBuiltInVariableResponse(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesBuiltInVariablesResourceApi res =
          new api.TagmanagerApi(mock)
              .accounts
              .containers
              .workspaces
              .builtInVariables;
      var arg_path = "foo";
      var arg_type = buildUnnamed1675();
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
        unittest.expect(queryMap["type"], unittest.equals(arg_type));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_path, type: arg_type, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesBuiltInVariablesResourceApi res =
          new api.TagmanagerApi(mock)
              .accounts
              .containers
              .workspaces
              .builtInVariables;
      var arg_parent = "foo";
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
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp =
            convert.json.encode(buildListEnabledBuiltInVariablesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_parent, pageToken: arg_pageToken, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkListEnabledBuiltInVariablesResponse(response);
      })));
    });

    unittest.test("method--revert", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesBuiltInVariablesResourceApi res =
          new api.TagmanagerApi(mock)
              .accounts
              .containers
              .workspaces
              .builtInVariables;
      var arg_path = "foo";
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
        unittest.expect(queryMap["type"].first, unittest.equals(arg_type));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildRevertBuiltInVariableResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .revert(arg_path, type: arg_type, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkRevertBuiltInVariableResponse(response);
      })));
    });
  });

  unittest.group("resource-AccountsContainersWorkspacesFoldersResourceApi", () {
    unittest.test("method--create", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesFoldersResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.folders;
      var arg_request = buildFolder();
      var arg_parent = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Folder.fromJson(json);
        checkFolder(obj);

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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildFolder());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .create(arg_request, arg_parent, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkFolder(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesFoldersResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.folders;
      var arg_path = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--entities", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesFoldersResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.folders;
      var arg_path = "foo";
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
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildFolderEntities());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .entities(arg_path, pageToken: arg_pageToken, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkFolderEntities(response);
      })));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesFoldersResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.folders;
      var arg_path = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildFolder());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkFolder(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesFoldersResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.folders;
      var arg_parent = "foo";
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
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildListFoldersResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_parent, pageToken: arg_pageToken, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkListFoldersResponse(response);
      })));
    });

    unittest.test("method--moveEntitiesToFolder", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesFoldersResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.folders;
      var arg_request = buildFolder();
      var arg_path = "foo";
      var arg_tagId = buildUnnamed1676();
      var arg_triggerId = buildUnnamed1677();
      var arg_variableId = buildUnnamed1678();
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Folder.fromJson(json);
        checkFolder(obj);

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
        unittest.expect(queryMap["tagId"], unittest.equals(arg_tagId));
        unittest.expect(queryMap["triggerId"], unittest.equals(arg_triggerId));
        unittest.expect(
            queryMap["variableId"], unittest.equals(arg_variableId));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .moveEntitiesToFolder(arg_request, arg_path,
              tagId: arg_tagId,
              triggerId: arg_triggerId,
              variableId: arg_variableId,
              $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--revert", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesFoldersResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.folders;
      var arg_path = "foo";
      var arg_fingerprint = "foo";
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
            queryMap["fingerprint"].first, unittest.equals(arg_fingerprint));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildRevertFolderResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .revert(arg_path, fingerprint: arg_fingerprint, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkRevertFolderResponse(response);
      })));
    });

    unittest.test("method--update", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesFoldersResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.folders;
      var arg_request = buildFolder();
      var arg_path = "foo";
      var arg_fingerprint = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Folder.fromJson(json);
        checkFolder(obj);

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
            queryMap["fingerprint"].first, unittest.equals(arg_fingerprint));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildFolder());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .update(arg_request, arg_path,
              fingerprint: arg_fingerprint, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkFolder(response);
      })));
    });
  });

  unittest.group("resource-AccountsContainersWorkspacesProposalResourceApi",
      () {
    unittest.test("method--create", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesProposalResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.proposal;
      var arg_request = buildCreateWorkspaceProposalRequest();
      var arg_parent = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.CreateWorkspaceProposalRequest.fromJson(json);
        checkCreateWorkspaceProposalRequest(obj);

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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildWorkspaceProposal());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .create(arg_request, arg_parent, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkWorkspaceProposal(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesProposalResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.proposal;
      var arg_path = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });
  });

  unittest.group("resource-AccountsContainersWorkspacesTagsResourceApi", () {
    unittest.test("method--create", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesTagsResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.tags;
      var arg_request = buildTag();
      var arg_parent = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Tag.fromJson(json);
        checkTag(obj);

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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildTag());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .create(arg_request, arg_parent, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkTag(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesTagsResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.tags;
      var arg_path = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesTagsResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.tags;
      var arg_path = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildTag());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkTag(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesTagsResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.tags;
      var arg_parent = "foo";
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
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildListTagsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_parent, pageToken: arg_pageToken, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkListTagsResponse(response);
      })));
    });

    unittest.test("method--revert", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesTagsResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.tags;
      var arg_path = "foo";
      var arg_fingerprint = "foo";
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
            queryMap["fingerprint"].first, unittest.equals(arg_fingerprint));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildRevertTagResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .revert(arg_path, fingerprint: arg_fingerprint, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkRevertTagResponse(response);
      })));
    });

    unittest.test("method--update", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesTagsResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.tags;
      var arg_request = buildTag();
      var arg_path = "foo";
      var arg_fingerprint = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Tag.fromJson(json);
        checkTag(obj);

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
            queryMap["fingerprint"].first, unittest.equals(arg_fingerprint));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildTag());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .update(arg_request, arg_path,
              fingerprint: arg_fingerprint, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkTag(response);
      })));
    });
  });

  unittest.group("resource-AccountsContainersWorkspacesTriggersResourceApi",
      () {
    unittest.test("method--create", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesTriggersResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.triggers;
      var arg_request = buildTrigger();
      var arg_parent = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Trigger.fromJson(json);
        checkTrigger(obj);

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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildTrigger());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .create(arg_request, arg_parent, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkTrigger(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesTriggersResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.triggers;
      var arg_path = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesTriggersResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.triggers;
      var arg_path = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildTrigger());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkTrigger(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesTriggersResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.triggers;
      var arg_parent = "foo";
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
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildListTriggersResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_parent, pageToken: arg_pageToken, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkListTriggersResponse(response);
      })));
    });

    unittest.test("method--revert", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesTriggersResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.triggers;
      var arg_path = "foo";
      var arg_fingerprint = "foo";
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
            queryMap["fingerprint"].first, unittest.equals(arg_fingerprint));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildRevertTriggerResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .revert(arg_path, fingerprint: arg_fingerprint, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkRevertTriggerResponse(response);
      })));
    });

    unittest.test("method--update", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesTriggersResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.triggers;
      var arg_request = buildTrigger();
      var arg_path = "foo";
      var arg_fingerprint = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Trigger.fromJson(json);
        checkTrigger(obj);

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
            queryMap["fingerprint"].first, unittest.equals(arg_fingerprint));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildTrigger());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .update(arg_request, arg_path,
              fingerprint: arg_fingerprint, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkTrigger(response);
      })));
    });
  });

  unittest.group("resource-AccountsContainersWorkspacesVariablesResourceApi",
      () {
    unittest.test("method--create", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesVariablesResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.variables;
      var arg_request = buildVariable();
      var arg_parent = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Variable.fromJson(json);
        checkVariable(obj);

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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildVariable());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .create(arg_request, arg_parent, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkVariable(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesVariablesResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.variables;
      var arg_path = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesVariablesResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.variables;
      var arg_path = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildVariable());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkVariable(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesVariablesResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.variables;
      var arg_parent = "foo";
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
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildListVariablesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_parent, pageToken: arg_pageToken, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkListVariablesResponse(response);
      })));
    });

    unittest.test("method--revert", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesVariablesResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.variables;
      var arg_path = "foo";
      var arg_fingerprint = "foo";
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
            queryMap["fingerprint"].first, unittest.equals(arg_fingerprint));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildRevertVariableResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .revert(arg_path, fingerprint: arg_fingerprint, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkRevertVariableResponse(response);
      })));
    });

    unittest.test("method--update", () {
      var mock = new HttpServerMock();
      api.AccountsContainersWorkspacesVariablesResourceApi res =
          new api.TagmanagerApi(mock).accounts.containers.workspaces.variables;
      var arg_request = buildVariable();
      var arg_path = "foo";
      var arg_fingerprint = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Variable.fromJson(json);
        checkVariable(obj);

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
            queryMap["fingerprint"].first, unittest.equals(arg_fingerprint));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildVariable());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .update(arg_request, arg_path,
              fingerprint: arg_fingerprint, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkVariable(response);
      })));
    });
  });

  unittest.group("resource-AccountsUserPermissionsResourceApi", () {
    unittest.test("method--create", () {
      var mock = new HttpServerMock();
      api.AccountsUserPermissionsResourceApi res =
          new api.TagmanagerApi(mock).accounts.userPermissions;
      var arg_request = buildUserPermission();
      var arg_parent = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.UserPermission.fromJson(json);
        checkUserPermission(obj);

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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildUserPermission());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .create(arg_request, arg_parent, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkUserPermission(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.AccountsUserPermissionsResourceApi res =
          new api.TagmanagerApi(mock).accounts.userPermissions;
      var arg_path = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.AccountsUserPermissionsResourceApi res =
          new api.TagmanagerApi(mock).accounts.userPermissions;
      var arg_path = "foo";
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildUserPermission());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkUserPermission(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsUserPermissionsResourceApi res =
          new api.TagmanagerApi(mock).accounts.userPermissions;
      var arg_parent = "foo";
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
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildListUserPermissionsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_parent, pageToken: arg_pageToken, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkListUserPermissionsResponse(response);
      })));
    });

    unittest.test("method--update", () {
      var mock = new HttpServerMock();
      api.AccountsUserPermissionsResourceApi res =
          new api.TagmanagerApi(mock).accounts.userPermissions;
      var arg_request = buildUserPermission();
      var arg_path = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.UserPermission.fromJson(json);
        checkUserPermission(obj);

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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildUserPermission());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .update(arg_request, arg_path, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkUserPermission(response);
      })));
    });
  });
}
