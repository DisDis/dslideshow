library googleapis.gmail.v1.test;

import "dart:core" as core;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:test/test.dart' as unittest;

import 'package:googleapis/gmail/v1.dart' as api;

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

core.int buildCounterAutoForwarding = 0;
buildAutoForwarding() {
  var o = new api.AutoForwarding();
  buildCounterAutoForwarding++;
  if (buildCounterAutoForwarding < 3) {
    o.disposition = "foo";
    o.emailAddress = "foo";
    o.enabled = true;
  }
  buildCounterAutoForwarding--;
  return o;
}

checkAutoForwarding(api.AutoForwarding o) {
  buildCounterAutoForwarding++;
  if (buildCounterAutoForwarding < 3) {
    unittest.expect(o.disposition, unittest.equals('foo'));
    unittest.expect(o.emailAddress, unittest.equals('foo'));
    unittest.expect(o.enabled, unittest.isTrue);
  }
  buildCounterAutoForwarding--;
}

buildUnnamed1067() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1067(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterBatchDeleteMessagesRequest = 0;
buildBatchDeleteMessagesRequest() {
  var o = new api.BatchDeleteMessagesRequest();
  buildCounterBatchDeleteMessagesRequest++;
  if (buildCounterBatchDeleteMessagesRequest < 3) {
    o.ids = buildUnnamed1067();
  }
  buildCounterBatchDeleteMessagesRequest--;
  return o;
}

checkBatchDeleteMessagesRequest(api.BatchDeleteMessagesRequest o) {
  buildCounterBatchDeleteMessagesRequest++;
  if (buildCounterBatchDeleteMessagesRequest < 3) {
    checkUnnamed1067(o.ids);
  }
  buildCounterBatchDeleteMessagesRequest--;
}

buildUnnamed1068() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1068(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1069() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1069(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1070() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1070(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterBatchModifyMessagesRequest = 0;
buildBatchModifyMessagesRequest() {
  var o = new api.BatchModifyMessagesRequest();
  buildCounterBatchModifyMessagesRequest++;
  if (buildCounterBatchModifyMessagesRequest < 3) {
    o.addLabelIds = buildUnnamed1068();
    o.ids = buildUnnamed1069();
    o.removeLabelIds = buildUnnamed1070();
  }
  buildCounterBatchModifyMessagesRequest--;
  return o;
}

checkBatchModifyMessagesRequest(api.BatchModifyMessagesRequest o) {
  buildCounterBatchModifyMessagesRequest++;
  if (buildCounterBatchModifyMessagesRequest < 3) {
    checkUnnamed1068(o.addLabelIds);
    checkUnnamed1069(o.ids);
    checkUnnamed1070(o.removeLabelIds);
  }
  buildCounterBatchModifyMessagesRequest--;
}

core.int buildCounterDelegate = 0;
buildDelegate() {
  var o = new api.Delegate();
  buildCounterDelegate++;
  if (buildCounterDelegate < 3) {
    o.delegateEmail = "foo";
    o.verificationStatus = "foo";
  }
  buildCounterDelegate--;
  return o;
}

checkDelegate(api.Delegate o) {
  buildCounterDelegate++;
  if (buildCounterDelegate < 3) {
    unittest.expect(o.delegateEmail, unittest.equals('foo'));
    unittest.expect(o.verificationStatus, unittest.equals('foo'));
  }
  buildCounterDelegate--;
}

core.int buildCounterDraft = 0;
buildDraft() {
  var o = new api.Draft();
  buildCounterDraft++;
  if (buildCounterDraft < 3) {
    o.id = "foo";
    o.message = buildMessage();
  }
  buildCounterDraft--;
  return o;
}

checkDraft(api.Draft o) {
  buildCounterDraft++;
  if (buildCounterDraft < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
    checkMessage(o.message);
  }
  buildCounterDraft--;
}

core.int buildCounterFilter = 0;
buildFilter() {
  var o = new api.Filter();
  buildCounterFilter++;
  if (buildCounterFilter < 3) {
    o.action = buildFilterAction();
    o.criteria = buildFilterCriteria();
    o.id = "foo";
  }
  buildCounterFilter--;
  return o;
}

checkFilter(api.Filter o) {
  buildCounterFilter++;
  if (buildCounterFilter < 3) {
    checkFilterAction(o.action);
    checkFilterCriteria(o.criteria);
    unittest.expect(o.id, unittest.equals('foo'));
  }
  buildCounterFilter--;
}

buildUnnamed1071() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1071(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1072() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1072(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterFilterAction = 0;
buildFilterAction() {
  var o = new api.FilterAction();
  buildCounterFilterAction++;
  if (buildCounterFilterAction < 3) {
    o.addLabelIds = buildUnnamed1071();
    o.forward = "foo";
    o.removeLabelIds = buildUnnamed1072();
  }
  buildCounterFilterAction--;
  return o;
}

checkFilterAction(api.FilterAction o) {
  buildCounterFilterAction++;
  if (buildCounterFilterAction < 3) {
    checkUnnamed1071(o.addLabelIds);
    unittest.expect(o.forward, unittest.equals('foo'));
    checkUnnamed1072(o.removeLabelIds);
  }
  buildCounterFilterAction--;
}

core.int buildCounterFilterCriteria = 0;
buildFilterCriteria() {
  var o = new api.FilterCriteria();
  buildCounterFilterCriteria++;
  if (buildCounterFilterCriteria < 3) {
    o.excludeChats = true;
    o.from = "foo";
    o.hasAttachment = true;
    o.negatedQuery = "foo";
    o.query = "foo";
    o.size = 42;
    o.sizeComparison = "foo";
    o.subject = "foo";
    o.to = "foo";
  }
  buildCounterFilterCriteria--;
  return o;
}

checkFilterCriteria(api.FilterCriteria o) {
  buildCounterFilterCriteria++;
  if (buildCounterFilterCriteria < 3) {
    unittest.expect(o.excludeChats, unittest.isTrue);
    unittest.expect(o.from, unittest.equals('foo'));
    unittest.expect(o.hasAttachment, unittest.isTrue);
    unittest.expect(o.negatedQuery, unittest.equals('foo'));
    unittest.expect(o.query, unittest.equals('foo'));
    unittest.expect(o.size, unittest.equals(42));
    unittest.expect(o.sizeComparison, unittest.equals('foo'));
    unittest.expect(o.subject, unittest.equals('foo'));
    unittest.expect(o.to, unittest.equals('foo'));
  }
  buildCounterFilterCriteria--;
}

core.int buildCounterForwardingAddress = 0;
buildForwardingAddress() {
  var o = new api.ForwardingAddress();
  buildCounterForwardingAddress++;
  if (buildCounterForwardingAddress < 3) {
    o.forwardingEmail = "foo";
    o.verificationStatus = "foo";
  }
  buildCounterForwardingAddress--;
  return o;
}

checkForwardingAddress(api.ForwardingAddress o) {
  buildCounterForwardingAddress++;
  if (buildCounterForwardingAddress < 3) {
    unittest.expect(o.forwardingEmail, unittest.equals('foo'));
    unittest.expect(o.verificationStatus, unittest.equals('foo'));
  }
  buildCounterForwardingAddress--;
}

buildUnnamed1073() {
  var o = new core.List<api.HistoryLabelAdded>();
  o.add(buildHistoryLabelAdded());
  o.add(buildHistoryLabelAdded());
  return o;
}

checkUnnamed1073(core.List<api.HistoryLabelAdded> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkHistoryLabelAdded(o[0]);
  checkHistoryLabelAdded(o[1]);
}

buildUnnamed1074() {
  var o = new core.List<api.HistoryLabelRemoved>();
  o.add(buildHistoryLabelRemoved());
  o.add(buildHistoryLabelRemoved());
  return o;
}

checkUnnamed1074(core.List<api.HistoryLabelRemoved> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkHistoryLabelRemoved(o[0]);
  checkHistoryLabelRemoved(o[1]);
}

buildUnnamed1075() {
  var o = new core.List<api.Message>();
  o.add(buildMessage());
  o.add(buildMessage());
  return o;
}

checkUnnamed1075(core.List<api.Message> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMessage(o[0]);
  checkMessage(o[1]);
}

buildUnnamed1076() {
  var o = new core.List<api.HistoryMessageAdded>();
  o.add(buildHistoryMessageAdded());
  o.add(buildHistoryMessageAdded());
  return o;
}

checkUnnamed1076(core.List<api.HistoryMessageAdded> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkHistoryMessageAdded(o[0]);
  checkHistoryMessageAdded(o[1]);
}

buildUnnamed1077() {
  var o = new core.List<api.HistoryMessageDeleted>();
  o.add(buildHistoryMessageDeleted());
  o.add(buildHistoryMessageDeleted());
  return o;
}

checkUnnamed1077(core.List<api.HistoryMessageDeleted> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkHistoryMessageDeleted(o[0]);
  checkHistoryMessageDeleted(o[1]);
}

core.int buildCounterHistory = 0;
buildHistory() {
  var o = new api.History();
  buildCounterHistory++;
  if (buildCounterHistory < 3) {
    o.id = "foo";
    o.labelsAdded = buildUnnamed1073();
    o.labelsRemoved = buildUnnamed1074();
    o.messages = buildUnnamed1075();
    o.messagesAdded = buildUnnamed1076();
    o.messagesDeleted = buildUnnamed1077();
  }
  buildCounterHistory--;
  return o;
}

checkHistory(api.History o) {
  buildCounterHistory++;
  if (buildCounterHistory < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
    checkUnnamed1073(o.labelsAdded);
    checkUnnamed1074(o.labelsRemoved);
    checkUnnamed1075(o.messages);
    checkUnnamed1076(o.messagesAdded);
    checkUnnamed1077(o.messagesDeleted);
  }
  buildCounterHistory--;
}

buildUnnamed1078() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1078(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterHistoryLabelAdded = 0;
buildHistoryLabelAdded() {
  var o = new api.HistoryLabelAdded();
  buildCounterHistoryLabelAdded++;
  if (buildCounterHistoryLabelAdded < 3) {
    o.labelIds = buildUnnamed1078();
    o.message = buildMessage();
  }
  buildCounterHistoryLabelAdded--;
  return o;
}

checkHistoryLabelAdded(api.HistoryLabelAdded o) {
  buildCounterHistoryLabelAdded++;
  if (buildCounterHistoryLabelAdded < 3) {
    checkUnnamed1078(o.labelIds);
    checkMessage(o.message);
  }
  buildCounterHistoryLabelAdded--;
}

buildUnnamed1079() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1079(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterHistoryLabelRemoved = 0;
buildHistoryLabelRemoved() {
  var o = new api.HistoryLabelRemoved();
  buildCounterHistoryLabelRemoved++;
  if (buildCounterHistoryLabelRemoved < 3) {
    o.labelIds = buildUnnamed1079();
    o.message = buildMessage();
  }
  buildCounterHistoryLabelRemoved--;
  return o;
}

checkHistoryLabelRemoved(api.HistoryLabelRemoved o) {
  buildCounterHistoryLabelRemoved++;
  if (buildCounterHistoryLabelRemoved < 3) {
    checkUnnamed1079(o.labelIds);
    checkMessage(o.message);
  }
  buildCounterHistoryLabelRemoved--;
}

core.int buildCounterHistoryMessageAdded = 0;
buildHistoryMessageAdded() {
  var o = new api.HistoryMessageAdded();
  buildCounterHistoryMessageAdded++;
  if (buildCounterHistoryMessageAdded < 3) {
    o.message = buildMessage();
  }
  buildCounterHistoryMessageAdded--;
  return o;
}

checkHistoryMessageAdded(api.HistoryMessageAdded o) {
  buildCounterHistoryMessageAdded++;
  if (buildCounterHistoryMessageAdded < 3) {
    checkMessage(o.message);
  }
  buildCounterHistoryMessageAdded--;
}

core.int buildCounterHistoryMessageDeleted = 0;
buildHistoryMessageDeleted() {
  var o = new api.HistoryMessageDeleted();
  buildCounterHistoryMessageDeleted++;
  if (buildCounterHistoryMessageDeleted < 3) {
    o.message = buildMessage();
  }
  buildCounterHistoryMessageDeleted--;
  return o;
}

checkHistoryMessageDeleted(api.HistoryMessageDeleted o) {
  buildCounterHistoryMessageDeleted++;
  if (buildCounterHistoryMessageDeleted < 3) {
    checkMessage(o.message);
  }
  buildCounterHistoryMessageDeleted--;
}

core.int buildCounterImapSettings = 0;
buildImapSettings() {
  var o = new api.ImapSettings();
  buildCounterImapSettings++;
  if (buildCounterImapSettings < 3) {
    o.autoExpunge = true;
    o.enabled = true;
    o.expungeBehavior = "foo";
    o.maxFolderSize = 42;
  }
  buildCounterImapSettings--;
  return o;
}

checkImapSettings(api.ImapSettings o) {
  buildCounterImapSettings++;
  if (buildCounterImapSettings < 3) {
    unittest.expect(o.autoExpunge, unittest.isTrue);
    unittest.expect(o.enabled, unittest.isTrue);
    unittest.expect(o.expungeBehavior, unittest.equals('foo'));
    unittest.expect(o.maxFolderSize, unittest.equals(42));
  }
  buildCounterImapSettings--;
}

core.int buildCounterLabel = 0;
buildLabel() {
  var o = new api.Label();
  buildCounterLabel++;
  if (buildCounterLabel < 3) {
    o.color = buildLabelColor();
    o.id = "foo";
    o.labelListVisibility = "foo";
    o.messageListVisibility = "foo";
    o.messagesTotal = 42;
    o.messagesUnread = 42;
    o.name = "foo";
    o.threadsTotal = 42;
    o.threadsUnread = 42;
    o.type = "foo";
  }
  buildCounterLabel--;
  return o;
}

checkLabel(api.Label o) {
  buildCounterLabel++;
  if (buildCounterLabel < 3) {
    checkLabelColor(o.color);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.labelListVisibility, unittest.equals('foo'));
    unittest.expect(o.messageListVisibility, unittest.equals('foo'));
    unittest.expect(o.messagesTotal, unittest.equals(42));
    unittest.expect(o.messagesUnread, unittest.equals(42));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.threadsTotal, unittest.equals(42));
    unittest.expect(o.threadsUnread, unittest.equals(42));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterLabel--;
}

core.int buildCounterLabelColor = 0;
buildLabelColor() {
  var o = new api.LabelColor();
  buildCounterLabelColor++;
  if (buildCounterLabelColor < 3) {
    o.backgroundColor = "foo";
    o.textColor = "foo";
  }
  buildCounterLabelColor--;
  return o;
}

checkLabelColor(api.LabelColor o) {
  buildCounterLabelColor++;
  if (buildCounterLabelColor < 3) {
    unittest.expect(o.backgroundColor, unittest.equals('foo'));
    unittest.expect(o.textColor, unittest.equals('foo'));
  }
  buildCounterLabelColor--;
}

buildUnnamed1080() {
  var o = new core.List<api.Delegate>();
  o.add(buildDelegate());
  o.add(buildDelegate());
  return o;
}

checkUnnamed1080(core.List<api.Delegate> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDelegate(o[0]);
  checkDelegate(o[1]);
}

core.int buildCounterListDelegatesResponse = 0;
buildListDelegatesResponse() {
  var o = new api.ListDelegatesResponse();
  buildCounterListDelegatesResponse++;
  if (buildCounterListDelegatesResponse < 3) {
    o.delegates = buildUnnamed1080();
  }
  buildCounterListDelegatesResponse--;
  return o;
}

checkListDelegatesResponse(api.ListDelegatesResponse o) {
  buildCounterListDelegatesResponse++;
  if (buildCounterListDelegatesResponse < 3) {
    checkUnnamed1080(o.delegates);
  }
  buildCounterListDelegatesResponse--;
}

buildUnnamed1081() {
  var o = new core.List<api.Draft>();
  o.add(buildDraft());
  o.add(buildDraft());
  return o;
}

checkUnnamed1081(core.List<api.Draft> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDraft(o[0]);
  checkDraft(o[1]);
}

core.int buildCounterListDraftsResponse = 0;
buildListDraftsResponse() {
  var o = new api.ListDraftsResponse();
  buildCounterListDraftsResponse++;
  if (buildCounterListDraftsResponse < 3) {
    o.drafts = buildUnnamed1081();
    o.nextPageToken = "foo";
    o.resultSizeEstimate = 42;
  }
  buildCounterListDraftsResponse--;
  return o;
}

checkListDraftsResponse(api.ListDraftsResponse o) {
  buildCounterListDraftsResponse++;
  if (buildCounterListDraftsResponse < 3) {
    checkUnnamed1081(o.drafts);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.resultSizeEstimate, unittest.equals(42));
  }
  buildCounterListDraftsResponse--;
}

buildUnnamed1082() {
  var o = new core.List<api.Filter>();
  o.add(buildFilter());
  o.add(buildFilter());
  return o;
}

checkUnnamed1082(core.List<api.Filter> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkFilter(o[0]);
  checkFilter(o[1]);
}

core.int buildCounterListFiltersResponse = 0;
buildListFiltersResponse() {
  var o = new api.ListFiltersResponse();
  buildCounterListFiltersResponse++;
  if (buildCounterListFiltersResponse < 3) {
    o.filter = buildUnnamed1082();
  }
  buildCounterListFiltersResponse--;
  return o;
}

checkListFiltersResponse(api.ListFiltersResponse o) {
  buildCounterListFiltersResponse++;
  if (buildCounterListFiltersResponse < 3) {
    checkUnnamed1082(o.filter);
  }
  buildCounterListFiltersResponse--;
}

buildUnnamed1083() {
  var o = new core.List<api.ForwardingAddress>();
  o.add(buildForwardingAddress());
  o.add(buildForwardingAddress());
  return o;
}

checkUnnamed1083(core.List<api.ForwardingAddress> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkForwardingAddress(o[0]);
  checkForwardingAddress(o[1]);
}

core.int buildCounterListForwardingAddressesResponse = 0;
buildListForwardingAddressesResponse() {
  var o = new api.ListForwardingAddressesResponse();
  buildCounterListForwardingAddressesResponse++;
  if (buildCounterListForwardingAddressesResponse < 3) {
    o.forwardingAddresses = buildUnnamed1083();
  }
  buildCounterListForwardingAddressesResponse--;
  return o;
}

checkListForwardingAddressesResponse(api.ListForwardingAddressesResponse o) {
  buildCounterListForwardingAddressesResponse++;
  if (buildCounterListForwardingAddressesResponse < 3) {
    checkUnnamed1083(o.forwardingAddresses);
  }
  buildCounterListForwardingAddressesResponse--;
}

buildUnnamed1084() {
  var o = new core.List<api.History>();
  o.add(buildHistory());
  o.add(buildHistory());
  return o;
}

checkUnnamed1084(core.List<api.History> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkHistory(o[0]);
  checkHistory(o[1]);
}

core.int buildCounterListHistoryResponse = 0;
buildListHistoryResponse() {
  var o = new api.ListHistoryResponse();
  buildCounterListHistoryResponse++;
  if (buildCounterListHistoryResponse < 3) {
    o.history = buildUnnamed1084();
    o.historyId = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterListHistoryResponse--;
  return o;
}

checkListHistoryResponse(api.ListHistoryResponse o) {
  buildCounterListHistoryResponse++;
  if (buildCounterListHistoryResponse < 3) {
    checkUnnamed1084(o.history);
    unittest.expect(o.historyId, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterListHistoryResponse--;
}

buildUnnamed1085() {
  var o = new core.List<api.Label>();
  o.add(buildLabel());
  o.add(buildLabel());
  return o;
}

checkUnnamed1085(core.List<api.Label> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLabel(o[0]);
  checkLabel(o[1]);
}

core.int buildCounterListLabelsResponse = 0;
buildListLabelsResponse() {
  var o = new api.ListLabelsResponse();
  buildCounterListLabelsResponse++;
  if (buildCounterListLabelsResponse < 3) {
    o.labels = buildUnnamed1085();
  }
  buildCounterListLabelsResponse--;
  return o;
}

checkListLabelsResponse(api.ListLabelsResponse o) {
  buildCounterListLabelsResponse++;
  if (buildCounterListLabelsResponse < 3) {
    checkUnnamed1085(o.labels);
  }
  buildCounterListLabelsResponse--;
}

buildUnnamed1086() {
  var o = new core.List<api.Message>();
  o.add(buildMessage());
  o.add(buildMessage());
  return o;
}

checkUnnamed1086(core.List<api.Message> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMessage(o[0]);
  checkMessage(o[1]);
}

core.int buildCounterListMessagesResponse = 0;
buildListMessagesResponse() {
  var o = new api.ListMessagesResponse();
  buildCounterListMessagesResponse++;
  if (buildCounterListMessagesResponse < 3) {
    o.messages = buildUnnamed1086();
    o.nextPageToken = "foo";
    o.resultSizeEstimate = 42;
  }
  buildCounterListMessagesResponse--;
  return o;
}

checkListMessagesResponse(api.ListMessagesResponse o) {
  buildCounterListMessagesResponse++;
  if (buildCounterListMessagesResponse < 3) {
    checkUnnamed1086(o.messages);
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.resultSizeEstimate, unittest.equals(42));
  }
  buildCounterListMessagesResponse--;
}

buildUnnamed1087() {
  var o = new core.List<api.SendAs>();
  o.add(buildSendAs());
  o.add(buildSendAs());
  return o;
}

checkUnnamed1087(core.List<api.SendAs> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSendAs(o[0]);
  checkSendAs(o[1]);
}

core.int buildCounterListSendAsResponse = 0;
buildListSendAsResponse() {
  var o = new api.ListSendAsResponse();
  buildCounterListSendAsResponse++;
  if (buildCounterListSendAsResponse < 3) {
    o.sendAs = buildUnnamed1087();
  }
  buildCounterListSendAsResponse--;
  return o;
}

checkListSendAsResponse(api.ListSendAsResponse o) {
  buildCounterListSendAsResponse++;
  if (buildCounterListSendAsResponse < 3) {
    checkUnnamed1087(o.sendAs);
  }
  buildCounterListSendAsResponse--;
}

buildUnnamed1088() {
  var o = new core.List<api.SmimeInfo>();
  o.add(buildSmimeInfo());
  o.add(buildSmimeInfo());
  return o;
}

checkUnnamed1088(core.List<api.SmimeInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSmimeInfo(o[0]);
  checkSmimeInfo(o[1]);
}

core.int buildCounterListSmimeInfoResponse = 0;
buildListSmimeInfoResponse() {
  var o = new api.ListSmimeInfoResponse();
  buildCounterListSmimeInfoResponse++;
  if (buildCounterListSmimeInfoResponse < 3) {
    o.smimeInfo = buildUnnamed1088();
  }
  buildCounterListSmimeInfoResponse--;
  return o;
}

checkListSmimeInfoResponse(api.ListSmimeInfoResponse o) {
  buildCounterListSmimeInfoResponse++;
  if (buildCounterListSmimeInfoResponse < 3) {
    checkUnnamed1088(o.smimeInfo);
  }
  buildCounterListSmimeInfoResponse--;
}

buildUnnamed1089() {
  var o = new core.List<api.Thread>();
  o.add(buildThread());
  o.add(buildThread());
  return o;
}

checkUnnamed1089(core.List<api.Thread> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkThread(o[0]);
  checkThread(o[1]);
}

core.int buildCounterListThreadsResponse = 0;
buildListThreadsResponse() {
  var o = new api.ListThreadsResponse();
  buildCounterListThreadsResponse++;
  if (buildCounterListThreadsResponse < 3) {
    o.nextPageToken = "foo";
    o.resultSizeEstimate = 42;
    o.threads = buildUnnamed1089();
  }
  buildCounterListThreadsResponse--;
  return o;
}

checkListThreadsResponse(api.ListThreadsResponse o) {
  buildCounterListThreadsResponse++;
  if (buildCounterListThreadsResponse < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.resultSizeEstimate, unittest.equals(42));
    checkUnnamed1089(o.threads);
  }
  buildCounterListThreadsResponse--;
}

buildUnnamed1090() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1090(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterMessage = 0;
buildMessage() {
  var o = new api.Message();
  buildCounterMessage++;
  if (buildCounterMessage < 3) {
    o.historyId = "foo";
    o.id = "foo";
    o.internalDate = "foo";
    o.labelIds = buildUnnamed1090();
    o.payload = buildMessagePart();
    o.raw = "foo";
    o.sizeEstimate = 42;
    o.snippet = "foo";
    o.threadId = "foo";
  }
  buildCounterMessage--;
  return o;
}

checkMessage(api.Message o) {
  buildCounterMessage++;
  if (buildCounterMessage < 3) {
    unittest.expect(o.historyId, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.internalDate, unittest.equals('foo'));
    checkUnnamed1090(o.labelIds);
    checkMessagePart(o.payload);
    unittest.expect(o.raw, unittest.equals('foo'));
    unittest.expect(o.sizeEstimate, unittest.equals(42));
    unittest.expect(o.snippet, unittest.equals('foo'));
    unittest.expect(o.threadId, unittest.equals('foo'));
  }
  buildCounterMessage--;
}

buildUnnamed1091() {
  var o = new core.List<api.MessagePartHeader>();
  o.add(buildMessagePartHeader());
  o.add(buildMessagePartHeader());
  return o;
}

checkUnnamed1091(core.List<api.MessagePartHeader> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMessagePartHeader(o[0]);
  checkMessagePartHeader(o[1]);
}

buildUnnamed1092() {
  var o = new core.List<api.MessagePart>();
  o.add(buildMessagePart());
  o.add(buildMessagePart());
  return o;
}

checkUnnamed1092(core.List<api.MessagePart> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMessagePart(o[0]);
  checkMessagePart(o[1]);
}

core.int buildCounterMessagePart = 0;
buildMessagePart() {
  var o = new api.MessagePart();
  buildCounterMessagePart++;
  if (buildCounterMessagePart < 3) {
    o.body = buildMessagePartBody();
    o.filename = "foo";
    o.headers = buildUnnamed1091();
    o.mimeType = "foo";
    o.partId = "foo";
    o.parts = buildUnnamed1092();
  }
  buildCounterMessagePart--;
  return o;
}

checkMessagePart(api.MessagePart o) {
  buildCounterMessagePart++;
  if (buildCounterMessagePart < 3) {
    checkMessagePartBody(o.body);
    unittest.expect(o.filename, unittest.equals('foo'));
    checkUnnamed1091(o.headers);
    unittest.expect(o.mimeType, unittest.equals('foo'));
    unittest.expect(o.partId, unittest.equals('foo'));
    checkUnnamed1092(o.parts);
  }
  buildCounterMessagePart--;
}

core.int buildCounterMessagePartBody = 0;
buildMessagePartBody() {
  var o = new api.MessagePartBody();
  buildCounterMessagePartBody++;
  if (buildCounterMessagePartBody < 3) {
    o.attachmentId = "foo";
    o.data = "foo";
    o.size = 42;
  }
  buildCounterMessagePartBody--;
  return o;
}

checkMessagePartBody(api.MessagePartBody o) {
  buildCounterMessagePartBody++;
  if (buildCounterMessagePartBody < 3) {
    unittest.expect(o.attachmentId, unittest.equals('foo'));
    unittest.expect(o.data, unittest.equals('foo'));
    unittest.expect(o.size, unittest.equals(42));
  }
  buildCounterMessagePartBody--;
}

core.int buildCounterMessagePartHeader = 0;
buildMessagePartHeader() {
  var o = new api.MessagePartHeader();
  buildCounterMessagePartHeader++;
  if (buildCounterMessagePartHeader < 3) {
    o.name = "foo";
    o.value = "foo";
  }
  buildCounterMessagePartHeader--;
  return o;
}

checkMessagePartHeader(api.MessagePartHeader o) {
  buildCounterMessagePartHeader++;
  if (buildCounterMessagePartHeader < 3) {
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.value, unittest.equals('foo'));
  }
  buildCounterMessagePartHeader--;
}

buildUnnamed1093() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1093(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1094() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1094(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterModifyMessageRequest = 0;
buildModifyMessageRequest() {
  var o = new api.ModifyMessageRequest();
  buildCounterModifyMessageRequest++;
  if (buildCounterModifyMessageRequest < 3) {
    o.addLabelIds = buildUnnamed1093();
    o.removeLabelIds = buildUnnamed1094();
  }
  buildCounterModifyMessageRequest--;
  return o;
}

checkModifyMessageRequest(api.ModifyMessageRequest o) {
  buildCounterModifyMessageRequest++;
  if (buildCounterModifyMessageRequest < 3) {
    checkUnnamed1093(o.addLabelIds);
    checkUnnamed1094(o.removeLabelIds);
  }
  buildCounterModifyMessageRequest--;
}

buildUnnamed1095() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1095(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1096() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1096(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterModifyThreadRequest = 0;
buildModifyThreadRequest() {
  var o = new api.ModifyThreadRequest();
  buildCounterModifyThreadRequest++;
  if (buildCounterModifyThreadRequest < 3) {
    o.addLabelIds = buildUnnamed1095();
    o.removeLabelIds = buildUnnamed1096();
  }
  buildCounterModifyThreadRequest--;
  return o;
}

checkModifyThreadRequest(api.ModifyThreadRequest o) {
  buildCounterModifyThreadRequest++;
  if (buildCounterModifyThreadRequest < 3) {
    checkUnnamed1095(o.addLabelIds);
    checkUnnamed1096(o.removeLabelIds);
  }
  buildCounterModifyThreadRequest--;
}

core.int buildCounterPopSettings = 0;
buildPopSettings() {
  var o = new api.PopSettings();
  buildCounterPopSettings++;
  if (buildCounterPopSettings < 3) {
    o.accessWindow = "foo";
    o.disposition = "foo";
  }
  buildCounterPopSettings--;
  return o;
}

checkPopSettings(api.PopSettings o) {
  buildCounterPopSettings++;
  if (buildCounterPopSettings < 3) {
    unittest.expect(o.accessWindow, unittest.equals('foo'));
    unittest.expect(o.disposition, unittest.equals('foo'));
  }
  buildCounterPopSettings--;
}

core.int buildCounterProfile = 0;
buildProfile() {
  var o = new api.Profile();
  buildCounterProfile++;
  if (buildCounterProfile < 3) {
    o.emailAddress = "foo";
    o.historyId = "foo";
    o.messagesTotal = 42;
    o.threadsTotal = 42;
  }
  buildCounterProfile--;
  return o;
}

checkProfile(api.Profile o) {
  buildCounterProfile++;
  if (buildCounterProfile < 3) {
    unittest.expect(o.emailAddress, unittest.equals('foo'));
    unittest.expect(o.historyId, unittest.equals('foo'));
    unittest.expect(o.messagesTotal, unittest.equals(42));
    unittest.expect(o.threadsTotal, unittest.equals(42));
  }
  buildCounterProfile--;
}

core.int buildCounterSendAs = 0;
buildSendAs() {
  var o = new api.SendAs();
  buildCounterSendAs++;
  if (buildCounterSendAs < 3) {
    o.displayName = "foo";
    o.isDefault = true;
    o.isPrimary = true;
    o.replyToAddress = "foo";
    o.sendAsEmail = "foo";
    o.signature = "foo";
    o.smtpMsa = buildSmtpMsa();
    o.treatAsAlias = true;
    o.verificationStatus = "foo";
  }
  buildCounterSendAs--;
  return o;
}

checkSendAs(api.SendAs o) {
  buildCounterSendAs++;
  if (buildCounterSendAs < 3) {
    unittest.expect(o.displayName, unittest.equals('foo'));
    unittest.expect(o.isDefault, unittest.isTrue);
    unittest.expect(o.isPrimary, unittest.isTrue);
    unittest.expect(o.replyToAddress, unittest.equals('foo'));
    unittest.expect(o.sendAsEmail, unittest.equals('foo'));
    unittest.expect(o.signature, unittest.equals('foo'));
    checkSmtpMsa(o.smtpMsa);
    unittest.expect(o.treatAsAlias, unittest.isTrue);
    unittest.expect(o.verificationStatus, unittest.equals('foo'));
  }
  buildCounterSendAs--;
}

core.int buildCounterSmimeInfo = 0;
buildSmimeInfo() {
  var o = new api.SmimeInfo();
  buildCounterSmimeInfo++;
  if (buildCounterSmimeInfo < 3) {
    o.encryptedKeyPassword = "foo";
    o.expiration = "foo";
    o.id = "foo";
    o.isDefault = true;
    o.issuerCn = "foo";
    o.pem = "foo";
    o.pkcs12 = "foo";
  }
  buildCounterSmimeInfo--;
  return o;
}

checkSmimeInfo(api.SmimeInfo o) {
  buildCounterSmimeInfo++;
  if (buildCounterSmimeInfo < 3) {
    unittest.expect(o.encryptedKeyPassword, unittest.equals('foo'));
    unittest.expect(o.expiration, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.isDefault, unittest.isTrue);
    unittest.expect(o.issuerCn, unittest.equals('foo'));
    unittest.expect(o.pem, unittest.equals('foo'));
    unittest.expect(o.pkcs12, unittest.equals('foo'));
  }
  buildCounterSmimeInfo--;
}

core.int buildCounterSmtpMsa = 0;
buildSmtpMsa() {
  var o = new api.SmtpMsa();
  buildCounterSmtpMsa++;
  if (buildCounterSmtpMsa < 3) {
    o.host = "foo";
    o.password = "foo";
    o.port = 42;
    o.securityMode = "foo";
    o.username = "foo";
  }
  buildCounterSmtpMsa--;
  return o;
}

checkSmtpMsa(api.SmtpMsa o) {
  buildCounterSmtpMsa++;
  if (buildCounterSmtpMsa < 3) {
    unittest.expect(o.host, unittest.equals('foo'));
    unittest.expect(o.password, unittest.equals('foo'));
    unittest.expect(o.port, unittest.equals(42));
    unittest.expect(o.securityMode, unittest.equals('foo'));
    unittest.expect(o.username, unittest.equals('foo'));
  }
  buildCounterSmtpMsa--;
}

buildUnnamed1097() {
  var o = new core.List<api.Message>();
  o.add(buildMessage());
  o.add(buildMessage());
  return o;
}

checkUnnamed1097(core.List<api.Message> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkMessage(o[0]);
  checkMessage(o[1]);
}

core.int buildCounterThread = 0;
buildThread() {
  var o = new api.Thread();
  buildCounterThread++;
  if (buildCounterThread < 3) {
    o.historyId = "foo";
    o.id = "foo";
    o.messages = buildUnnamed1097();
    o.snippet = "foo";
  }
  buildCounterThread--;
  return o;
}

checkThread(api.Thread o) {
  buildCounterThread++;
  if (buildCounterThread < 3) {
    unittest.expect(o.historyId, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    checkUnnamed1097(o.messages);
    unittest.expect(o.snippet, unittest.equals('foo'));
  }
  buildCounterThread--;
}

core.int buildCounterVacationSettings = 0;
buildVacationSettings() {
  var o = new api.VacationSettings();
  buildCounterVacationSettings++;
  if (buildCounterVacationSettings < 3) {
    o.enableAutoReply = true;
    o.endTime = "foo";
    o.responseBodyHtml = "foo";
    o.responseBodyPlainText = "foo";
    o.responseSubject = "foo";
    o.restrictToContacts = true;
    o.restrictToDomain = true;
    o.startTime = "foo";
  }
  buildCounterVacationSettings--;
  return o;
}

checkVacationSettings(api.VacationSettings o) {
  buildCounterVacationSettings++;
  if (buildCounterVacationSettings < 3) {
    unittest.expect(o.enableAutoReply, unittest.isTrue);
    unittest.expect(o.endTime, unittest.equals('foo'));
    unittest.expect(o.responseBodyHtml, unittest.equals('foo'));
    unittest.expect(o.responseBodyPlainText, unittest.equals('foo'));
    unittest.expect(o.responseSubject, unittest.equals('foo'));
    unittest.expect(o.restrictToContacts, unittest.isTrue);
    unittest.expect(o.restrictToDomain, unittest.isTrue);
    unittest.expect(o.startTime, unittest.equals('foo'));
  }
  buildCounterVacationSettings--;
}

buildUnnamed1098() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1098(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterWatchRequest = 0;
buildWatchRequest() {
  var o = new api.WatchRequest();
  buildCounterWatchRequest++;
  if (buildCounterWatchRequest < 3) {
    o.labelFilterAction = "foo";
    o.labelIds = buildUnnamed1098();
    o.topicName = "foo";
  }
  buildCounterWatchRequest--;
  return o;
}

checkWatchRequest(api.WatchRequest o) {
  buildCounterWatchRequest++;
  if (buildCounterWatchRequest < 3) {
    unittest.expect(o.labelFilterAction, unittest.equals('foo'));
    checkUnnamed1098(o.labelIds);
    unittest.expect(o.topicName, unittest.equals('foo'));
  }
  buildCounterWatchRequest--;
}

core.int buildCounterWatchResponse = 0;
buildWatchResponse() {
  var o = new api.WatchResponse();
  buildCounterWatchResponse++;
  if (buildCounterWatchResponse < 3) {
    o.expiration = "foo";
    o.historyId = "foo";
  }
  buildCounterWatchResponse--;
  return o;
}

checkWatchResponse(api.WatchResponse o) {
  buildCounterWatchResponse++;
  if (buildCounterWatchResponse < 3) {
    unittest.expect(o.expiration, unittest.equals('foo'));
    unittest.expect(o.historyId, unittest.equals('foo'));
  }
  buildCounterWatchResponse--;
}

buildUnnamed1099() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1099(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1100() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1100(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1101() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1101(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1102() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1102(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1103() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1103(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

main() {
  unittest.group("obj-schema-AutoForwarding", () {
    unittest.test("to-json--from-json", () {
      var o = buildAutoForwarding();
      var od = new api.AutoForwarding.fromJson(o.toJson());
      checkAutoForwarding(od);
    });
  });

  unittest.group("obj-schema-BatchDeleteMessagesRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildBatchDeleteMessagesRequest();
      var od = new api.BatchDeleteMessagesRequest.fromJson(o.toJson());
      checkBatchDeleteMessagesRequest(od);
    });
  });

  unittest.group("obj-schema-BatchModifyMessagesRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildBatchModifyMessagesRequest();
      var od = new api.BatchModifyMessagesRequest.fromJson(o.toJson());
      checkBatchModifyMessagesRequest(od);
    });
  });

  unittest.group("obj-schema-Delegate", () {
    unittest.test("to-json--from-json", () {
      var o = buildDelegate();
      var od = new api.Delegate.fromJson(o.toJson());
      checkDelegate(od);
    });
  });

  unittest.group("obj-schema-Draft", () {
    unittest.test("to-json--from-json", () {
      var o = buildDraft();
      var od = new api.Draft.fromJson(o.toJson());
      checkDraft(od);
    });
  });

  unittest.group("obj-schema-Filter", () {
    unittest.test("to-json--from-json", () {
      var o = buildFilter();
      var od = new api.Filter.fromJson(o.toJson());
      checkFilter(od);
    });
  });

  unittest.group("obj-schema-FilterAction", () {
    unittest.test("to-json--from-json", () {
      var o = buildFilterAction();
      var od = new api.FilterAction.fromJson(o.toJson());
      checkFilterAction(od);
    });
  });

  unittest.group("obj-schema-FilterCriteria", () {
    unittest.test("to-json--from-json", () {
      var o = buildFilterCriteria();
      var od = new api.FilterCriteria.fromJson(o.toJson());
      checkFilterCriteria(od);
    });
  });

  unittest.group("obj-schema-ForwardingAddress", () {
    unittest.test("to-json--from-json", () {
      var o = buildForwardingAddress();
      var od = new api.ForwardingAddress.fromJson(o.toJson());
      checkForwardingAddress(od);
    });
  });

  unittest.group("obj-schema-History", () {
    unittest.test("to-json--from-json", () {
      var o = buildHistory();
      var od = new api.History.fromJson(o.toJson());
      checkHistory(od);
    });
  });

  unittest.group("obj-schema-HistoryLabelAdded", () {
    unittest.test("to-json--from-json", () {
      var o = buildHistoryLabelAdded();
      var od = new api.HistoryLabelAdded.fromJson(o.toJson());
      checkHistoryLabelAdded(od);
    });
  });

  unittest.group("obj-schema-HistoryLabelRemoved", () {
    unittest.test("to-json--from-json", () {
      var o = buildHistoryLabelRemoved();
      var od = new api.HistoryLabelRemoved.fromJson(o.toJson());
      checkHistoryLabelRemoved(od);
    });
  });

  unittest.group("obj-schema-HistoryMessageAdded", () {
    unittest.test("to-json--from-json", () {
      var o = buildHistoryMessageAdded();
      var od = new api.HistoryMessageAdded.fromJson(o.toJson());
      checkHistoryMessageAdded(od);
    });
  });

  unittest.group("obj-schema-HistoryMessageDeleted", () {
    unittest.test("to-json--from-json", () {
      var o = buildHistoryMessageDeleted();
      var od = new api.HistoryMessageDeleted.fromJson(o.toJson());
      checkHistoryMessageDeleted(od);
    });
  });

  unittest.group("obj-schema-ImapSettings", () {
    unittest.test("to-json--from-json", () {
      var o = buildImapSettings();
      var od = new api.ImapSettings.fromJson(o.toJson());
      checkImapSettings(od);
    });
  });

  unittest.group("obj-schema-Label", () {
    unittest.test("to-json--from-json", () {
      var o = buildLabel();
      var od = new api.Label.fromJson(o.toJson());
      checkLabel(od);
    });
  });

  unittest.group("obj-schema-LabelColor", () {
    unittest.test("to-json--from-json", () {
      var o = buildLabelColor();
      var od = new api.LabelColor.fromJson(o.toJson());
      checkLabelColor(od);
    });
  });

  unittest.group("obj-schema-ListDelegatesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListDelegatesResponse();
      var od = new api.ListDelegatesResponse.fromJson(o.toJson());
      checkListDelegatesResponse(od);
    });
  });

  unittest.group("obj-schema-ListDraftsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListDraftsResponse();
      var od = new api.ListDraftsResponse.fromJson(o.toJson());
      checkListDraftsResponse(od);
    });
  });

  unittest.group("obj-schema-ListFiltersResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListFiltersResponse();
      var od = new api.ListFiltersResponse.fromJson(o.toJson());
      checkListFiltersResponse(od);
    });
  });

  unittest.group("obj-schema-ListForwardingAddressesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListForwardingAddressesResponse();
      var od = new api.ListForwardingAddressesResponse.fromJson(o.toJson());
      checkListForwardingAddressesResponse(od);
    });
  });

  unittest.group("obj-schema-ListHistoryResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListHistoryResponse();
      var od = new api.ListHistoryResponse.fromJson(o.toJson());
      checkListHistoryResponse(od);
    });
  });

  unittest.group("obj-schema-ListLabelsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListLabelsResponse();
      var od = new api.ListLabelsResponse.fromJson(o.toJson());
      checkListLabelsResponse(od);
    });
  });

  unittest.group("obj-schema-ListMessagesResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListMessagesResponse();
      var od = new api.ListMessagesResponse.fromJson(o.toJson());
      checkListMessagesResponse(od);
    });
  });

  unittest.group("obj-schema-ListSendAsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListSendAsResponse();
      var od = new api.ListSendAsResponse.fromJson(o.toJson());
      checkListSendAsResponse(od);
    });
  });

  unittest.group("obj-schema-ListSmimeInfoResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListSmimeInfoResponse();
      var od = new api.ListSmimeInfoResponse.fromJson(o.toJson());
      checkListSmimeInfoResponse(od);
    });
  });

  unittest.group("obj-schema-ListThreadsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildListThreadsResponse();
      var od = new api.ListThreadsResponse.fromJson(o.toJson());
      checkListThreadsResponse(od);
    });
  });

  unittest.group("obj-schema-Message", () {
    unittest.test("to-json--from-json", () {
      var o = buildMessage();
      var od = new api.Message.fromJson(o.toJson());
      checkMessage(od);
    });
  });

  unittest.group("obj-schema-MessagePart", () {
    unittest.test("to-json--from-json", () {
      var o = buildMessagePart();
      var od = new api.MessagePart.fromJson(o.toJson());
      checkMessagePart(od);
    });
  });

  unittest.group("obj-schema-MessagePartBody", () {
    unittest.test("to-json--from-json", () {
      var o = buildMessagePartBody();
      var od = new api.MessagePartBody.fromJson(o.toJson());
      checkMessagePartBody(od);
    });
  });

  unittest.group("obj-schema-MessagePartHeader", () {
    unittest.test("to-json--from-json", () {
      var o = buildMessagePartHeader();
      var od = new api.MessagePartHeader.fromJson(o.toJson());
      checkMessagePartHeader(od);
    });
  });

  unittest.group("obj-schema-ModifyMessageRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildModifyMessageRequest();
      var od = new api.ModifyMessageRequest.fromJson(o.toJson());
      checkModifyMessageRequest(od);
    });
  });

  unittest.group("obj-schema-ModifyThreadRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildModifyThreadRequest();
      var od = new api.ModifyThreadRequest.fromJson(o.toJson());
      checkModifyThreadRequest(od);
    });
  });

  unittest.group("obj-schema-PopSettings", () {
    unittest.test("to-json--from-json", () {
      var o = buildPopSettings();
      var od = new api.PopSettings.fromJson(o.toJson());
      checkPopSettings(od);
    });
  });

  unittest.group("obj-schema-Profile", () {
    unittest.test("to-json--from-json", () {
      var o = buildProfile();
      var od = new api.Profile.fromJson(o.toJson());
      checkProfile(od);
    });
  });

  unittest.group("obj-schema-SendAs", () {
    unittest.test("to-json--from-json", () {
      var o = buildSendAs();
      var od = new api.SendAs.fromJson(o.toJson());
      checkSendAs(od);
    });
  });

  unittest.group("obj-schema-SmimeInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildSmimeInfo();
      var od = new api.SmimeInfo.fromJson(o.toJson());
      checkSmimeInfo(od);
    });
  });

  unittest.group("obj-schema-SmtpMsa", () {
    unittest.test("to-json--from-json", () {
      var o = buildSmtpMsa();
      var od = new api.SmtpMsa.fromJson(o.toJson());
      checkSmtpMsa(od);
    });
  });

  unittest.group("obj-schema-Thread", () {
    unittest.test("to-json--from-json", () {
      var o = buildThread();
      var od = new api.Thread.fromJson(o.toJson());
      checkThread(od);
    });
  });

  unittest.group("obj-schema-VacationSettings", () {
    unittest.test("to-json--from-json", () {
      var o = buildVacationSettings();
      var od = new api.VacationSettings.fromJson(o.toJson());
      checkVacationSettings(od);
    });
  });

  unittest.group("obj-schema-WatchRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildWatchRequest();
      var od = new api.WatchRequest.fromJson(o.toJson());
      checkWatchRequest(od);
    });
  });

  unittest.group("obj-schema-WatchResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildWatchResponse();
      var od = new api.WatchResponse.fromJson(o.toJson());
      checkWatchResponse(od);
    });
  });

  unittest.group("resource-UsersResourceApi", () {
    unittest.test("method--getProfile", () {
      var mock = new HttpServerMock();
      api.UsersResourceApi res = new api.GmailApi(mock).users;
      var arg_userId = "foo";
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
        var resp = convert.json.encode(buildProfile());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .getProfile(arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkProfile(response);
      })));
    });

    unittest.test("method--stop", () {
      var mock = new HttpServerMock();
      api.UsersResourceApi res = new api.GmailApi(mock).users;
      var arg_userId = "foo";
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
          .stop(arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--watch", () {
      var mock = new HttpServerMock();
      api.UsersResourceApi res = new api.GmailApi(mock).users;
      var arg_request = buildWatchRequest();
      var arg_userId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.WatchRequest.fromJson(json);
        checkWatchRequest(obj);

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
        var resp = convert.json.encode(buildWatchResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .watch(arg_request, arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkWatchResponse(response);
      })));
    });
  });

  unittest.group("resource-UsersDraftsResourceApi", () {
    unittest.test("method--create", () {
      // TODO: Implement tests for media upload;
      // TODO: Implement tests for media download;

      var mock = new HttpServerMock();
      api.UsersDraftsResourceApi res = new api.GmailApi(mock).users.drafts;
      var arg_request = buildDraft();
      var arg_userId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Draft.fromJson(json);
        checkDraft(obj);

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
        var resp = convert.json.encode(buildDraft());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .create(arg_request, arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkDraft(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.UsersDraftsResourceApi res = new api.GmailApi(mock).users.drafts;
      var arg_userId = "foo";
      var arg_id = "foo";
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
          .delete(arg_userId, arg_id, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.UsersDraftsResourceApi res = new api.GmailApi(mock).users.drafts;
      var arg_userId = "foo";
      var arg_id = "foo";
      var arg_format = "foo";
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
        unittest.expect(queryMap["format"].first, unittest.equals(arg_format));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildDraft());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_userId, arg_id, format: arg_format, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkDraft(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.UsersDraftsResourceApi res = new api.GmailApi(mock).users.drafts;
      var arg_userId = "foo";
      var arg_includeSpamTrash = true;
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      var arg_q = "foo";
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
        unittest.expect(queryMap["includeSpamTrash"].first,
            unittest.equals("$arg_includeSpamTrash"));
        unittest.expect(core.int.parse(queryMap["maxResults"].first),
            unittest.equals(arg_maxResults));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["q"].first, unittest.equals(arg_q));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildListDraftsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_userId,
              includeSpamTrash: arg_includeSpamTrash,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              q: arg_q,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkListDraftsResponse(response);
      })));
    });

    unittest.test("method--send", () {
      // TODO: Implement tests for media upload;
      // TODO: Implement tests for media download;

      var mock = new HttpServerMock();
      api.UsersDraftsResourceApi res = new api.GmailApi(mock).users.drafts;
      var arg_request = buildDraft();
      var arg_userId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Draft.fromJson(json);
        checkDraft(obj);

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
        var resp = convert.json.encode(buildMessage());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .send(arg_request, arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkMessage(response);
      })));
    });

    unittest.test("method--update", () {
      // TODO: Implement tests for media upload;
      // TODO: Implement tests for media download;

      var mock = new HttpServerMock();
      api.UsersDraftsResourceApi res = new api.GmailApi(mock).users.drafts;
      var arg_request = buildDraft();
      var arg_userId = "foo";
      var arg_id = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Draft.fromJson(json);
        checkDraft(obj);

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
        var resp = convert.json.encode(buildDraft());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .update(arg_request, arg_userId, arg_id, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkDraft(response);
      })));
    });
  });

  unittest.group("resource-UsersHistoryResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.UsersHistoryResourceApi res = new api.GmailApi(mock).users.history;
      var arg_userId = "foo";
      var arg_historyTypes = buildUnnamed1099();
      var arg_labelId = "foo";
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      var arg_startHistoryId = "foo";
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
            queryMap["historyTypes"], unittest.equals(arg_historyTypes));
        unittest.expect(
            queryMap["labelId"].first, unittest.equals(arg_labelId));
        unittest.expect(core.int.parse(queryMap["maxResults"].first),
            unittest.equals(arg_maxResults));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["startHistoryId"].first,
            unittest.equals(arg_startHistoryId));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildListHistoryResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_userId,
              historyTypes: arg_historyTypes,
              labelId: arg_labelId,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              startHistoryId: arg_startHistoryId,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkListHistoryResponse(response);
      })));
    });
  });

  unittest.group("resource-UsersLabelsResourceApi", () {
    unittest.test("method--create", () {
      var mock = new HttpServerMock();
      api.UsersLabelsResourceApi res = new api.GmailApi(mock).users.labels;
      var arg_request = buildLabel();
      var arg_userId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Label.fromJson(json);
        checkLabel(obj);

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
        var resp = convert.json.encode(buildLabel());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .create(arg_request, arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkLabel(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.UsersLabelsResourceApi res = new api.GmailApi(mock).users.labels;
      var arg_userId = "foo";
      var arg_id = "foo";
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
          .delete(arg_userId, arg_id, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.UsersLabelsResourceApi res = new api.GmailApi(mock).users.labels;
      var arg_userId = "foo";
      var arg_id = "foo";
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
        var resp = convert.json.encode(buildLabel());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_userId, arg_id, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkLabel(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.UsersLabelsResourceApi res = new api.GmailApi(mock).users.labels;
      var arg_userId = "foo";
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
        var resp = convert.json.encode(buildListLabelsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkListLabelsResponse(response);
      })));
    });

    unittest.test("method--patch", () {
      var mock = new HttpServerMock();
      api.UsersLabelsResourceApi res = new api.GmailApi(mock).users.labels;
      var arg_request = buildLabel();
      var arg_userId = "foo";
      var arg_id = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Label.fromJson(json);
        checkLabel(obj);

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
        var resp = convert.json.encode(buildLabel());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .patch(arg_request, arg_userId, arg_id, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkLabel(response);
      })));
    });

    unittest.test("method--update", () {
      var mock = new HttpServerMock();
      api.UsersLabelsResourceApi res = new api.GmailApi(mock).users.labels;
      var arg_request = buildLabel();
      var arg_userId = "foo";
      var arg_id = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Label.fromJson(json);
        checkLabel(obj);

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
        var resp = convert.json.encode(buildLabel());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .update(arg_request, arg_userId, arg_id, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkLabel(response);
      })));
    });
  });

  unittest.group("resource-UsersMessagesResourceApi", () {
    unittest.test("method--batchDelete", () {
      var mock = new HttpServerMock();
      api.UsersMessagesResourceApi res = new api.GmailApi(mock).users.messages;
      var arg_request = buildBatchDeleteMessagesRequest();
      var arg_userId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.BatchDeleteMessagesRequest.fromJson(json);
        checkBatchDeleteMessagesRequest(obj);

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
          .batchDelete(arg_request, arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--batchModify", () {
      var mock = new HttpServerMock();
      api.UsersMessagesResourceApi res = new api.GmailApi(mock).users.messages;
      var arg_request = buildBatchModifyMessagesRequest();
      var arg_userId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.BatchModifyMessagesRequest.fromJson(json);
        checkBatchModifyMessagesRequest(obj);

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
          .batchModify(arg_request, arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.UsersMessagesResourceApi res = new api.GmailApi(mock).users.messages;
      var arg_userId = "foo";
      var arg_id = "foo";
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
          .delete(arg_userId, arg_id, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.UsersMessagesResourceApi res = new api.GmailApi(mock).users.messages;
      var arg_userId = "foo";
      var arg_id = "foo";
      var arg_format = "foo";
      var arg_metadataHeaders = buildUnnamed1100();
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
        unittest.expect(queryMap["format"].first, unittest.equals(arg_format));
        unittest.expect(
            queryMap["metadataHeaders"], unittest.equals(arg_metadataHeaders));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildMessage());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_userId, arg_id,
              format: arg_format,
              metadataHeaders: arg_metadataHeaders,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkMessage(response);
      })));
    });

    unittest.test("method--import", () {
      // TODO: Implement tests for media upload;
      // TODO: Implement tests for media download;

      var mock = new HttpServerMock();
      api.UsersMessagesResourceApi res = new api.GmailApi(mock).users.messages;
      var arg_request = buildMessage();
      var arg_userId = "foo";
      var arg_deleted = true;
      var arg_internalDateSource = "foo";
      var arg_neverMarkSpam = true;
      var arg_processForCalendar = true;
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Message.fromJson(json);
        checkMessage(obj);

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
            queryMap["deleted"].first, unittest.equals("$arg_deleted"));
        unittest.expect(queryMap["internalDateSource"].first,
            unittest.equals(arg_internalDateSource));
        unittest.expect(queryMap["neverMarkSpam"].first,
            unittest.equals("$arg_neverMarkSpam"));
        unittest.expect(queryMap["processForCalendar"].first,
            unittest.equals("$arg_processForCalendar"));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildMessage());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .import(arg_request, arg_userId,
              deleted: arg_deleted,
              internalDateSource: arg_internalDateSource,
              neverMarkSpam: arg_neverMarkSpam,
              processForCalendar: arg_processForCalendar,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkMessage(response);
      })));
    });

    unittest.test("method--insert", () {
      // TODO: Implement tests for media upload;
      // TODO: Implement tests for media download;

      var mock = new HttpServerMock();
      api.UsersMessagesResourceApi res = new api.GmailApi(mock).users.messages;
      var arg_request = buildMessage();
      var arg_userId = "foo";
      var arg_deleted = true;
      var arg_internalDateSource = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Message.fromJson(json);
        checkMessage(obj);

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
            queryMap["deleted"].first, unittest.equals("$arg_deleted"));
        unittest.expect(queryMap["internalDateSource"].first,
            unittest.equals(arg_internalDateSource));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildMessage());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .insert(arg_request, arg_userId,
              deleted: arg_deleted,
              internalDateSource: arg_internalDateSource,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkMessage(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.UsersMessagesResourceApi res = new api.GmailApi(mock).users.messages;
      var arg_userId = "foo";
      var arg_includeSpamTrash = true;
      var arg_labelIds = buildUnnamed1101();
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      var arg_q = "foo";
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
        unittest.expect(queryMap["includeSpamTrash"].first,
            unittest.equals("$arg_includeSpamTrash"));
        unittest.expect(queryMap["labelIds"], unittest.equals(arg_labelIds));
        unittest.expect(core.int.parse(queryMap["maxResults"].first),
            unittest.equals(arg_maxResults));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["q"].first, unittest.equals(arg_q));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildListMessagesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_userId,
              includeSpamTrash: arg_includeSpamTrash,
              labelIds: arg_labelIds,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              q: arg_q,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkListMessagesResponse(response);
      })));
    });

    unittest.test("method--modify", () {
      var mock = new HttpServerMock();
      api.UsersMessagesResourceApi res = new api.GmailApi(mock).users.messages;
      var arg_request = buildModifyMessageRequest();
      var arg_userId = "foo";
      var arg_id = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.ModifyMessageRequest.fromJson(json);
        checkModifyMessageRequest(obj);

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
        var resp = convert.json.encode(buildMessage());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .modify(arg_request, arg_userId, arg_id, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkMessage(response);
      })));
    });

    unittest.test("method--send", () {
      // TODO: Implement tests for media upload;
      // TODO: Implement tests for media download;

      var mock = new HttpServerMock();
      api.UsersMessagesResourceApi res = new api.GmailApi(mock).users.messages;
      var arg_request = buildMessage();
      var arg_userId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Message.fromJson(json);
        checkMessage(obj);

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
        var resp = convert.json.encode(buildMessage());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .send(arg_request, arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkMessage(response);
      })));
    });

    unittest.test("method--trash", () {
      var mock = new HttpServerMock();
      api.UsersMessagesResourceApi res = new api.GmailApi(mock).users.messages;
      var arg_userId = "foo";
      var arg_id = "foo";
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
        var resp = convert.json.encode(buildMessage());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .trash(arg_userId, arg_id, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkMessage(response);
      })));
    });

    unittest.test("method--untrash", () {
      var mock = new HttpServerMock();
      api.UsersMessagesResourceApi res = new api.GmailApi(mock).users.messages;
      var arg_userId = "foo";
      var arg_id = "foo";
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
        var resp = convert.json.encode(buildMessage());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .untrash(arg_userId, arg_id, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkMessage(response);
      })));
    });
  });

  unittest.group("resource-UsersMessagesAttachmentsResourceApi", () {
    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.UsersMessagesAttachmentsResourceApi res =
          new api.GmailApi(mock).users.messages.attachments;
      var arg_userId = "foo";
      var arg_messageId = "foo";
      var arg_id = "foo";
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
        var resp = convert.json.encode(buildMessagePartBody());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_userId, arg_messageId, arg_id, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkMessagePartBody(response);
      })));
    });
  });

  unittest.group("resource-UsersSettingsResourceApi", () {
    unittest.test("method--getAutoForwarding", () {
      var mock = new HttpServerMock();
      api.UsersSettingsResourceApi res = new api.GmailApi(mock).users.settings;
      var arg_userId = "foo";
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
        var resp = convert.json.encode(buildAutoForwarding());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .getAutoForwarding(arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAutoForwarding(response);
      })));
    });

    unittest.test("method--getImap", () {
      var mock = new HttpServerMock();
      api.UsersSettingsResourceApi res = new api.GmailApi(mock).users.settings;
      var arg_userId = "foo";
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
        var resp = convert.json.encode(buildImapSettings());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .getImap(arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkImapSettings(response);
      })));
    });

    unittest.test("method--getPop", () {
      var mock = new HttpServerMock();
      api.UsersSettingsResourceApi res = new api.GmailApi(mock).users.settings;
      var arg_userId = "foo";
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
        var resp = convert.json.encode(buildPopSettings());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .getPop(arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkPopSettings(response);
      })));
    });

    unittest.test("method--getVacation", () {
      var mock = new HttpServerMock();
      api.UsersSettingsResourceApi res = new api.GmailApi(mock).users.settings;
      var arg_userId = "foo";
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
        var resp = convert.json.encode(buildVacationSettings());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .getVacation(arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkVacationSettings(response);
      })));
    });

    unittest.test("method--updateAutoForwarding", () {
      var mock = new HttpServerMock();
      api.UsersSettingsResourceApi res = new api.GmailApi(mock).users.settings;
      var arg_request = buildAutoForwarding();
      var arg_userId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.AutoForwarding.fromJson(json);
        checkAutoForwarding(obj);

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
        var resp = convert.json.encode(buildAutoForwarding());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .updateAutoForwarding(arg_request, arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAutoForwarding(response);
      })));
    });

    unittest.test("method--updateImap", () {
      var mock = new HttpServerMock();
      api.UsersSettingsResourceApi res = new api.GmailApi(mock).users.settings;
      var arg_request = buildImapSettings();
      var arg_userId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.ImapSettings.fromJson(json);
        checkImapSettings(obj);

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
        var resp = convert.json.encode(buildImapSettings());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .updateImap(arg_request, arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkImapSettings(response);
      })));
    });

    unittest.test("method--updatePop", () {
      var mock = new HttpServerMock();
      api.UsersSettingsResourceApi res = new api.GmailApi(mock).users.settings;
      var arg_request = buildPopSettings();
      var arg_userId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.PopSettings.fromJson(json);
        checkPopSettings(obj);

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
        var resp = convert.json.encode(buildPopSettings());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .updatePop(arg_request, arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkPopSettings(response);
      })));
    });

    unittest.test("method--updateVacation", () {
      var mock = new HttpServerMock();
      api.UsersSettingsResourceApi res = new api.GmailApi(mock).users.settings;
      var arg_request = buildVacationSettings();
      var arg_userId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.VacationSettings.fromJson(json);
        checkVacationSettings(obj);

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
        var resp = convert.json.encode(buildVacationSettings());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .updateVacation(arg_request, arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkVacationSettings(response);
      })));
    });
  });

  unittest.group("resource-UsersSettingsDelegatesResourceApi", () {
    unittest.test("method--create", () {
      var mock = new HttpServerMock();
      api.UsersSettingsDelegatesResourceApi res =
          new api.GmailApi(mock).users.settings.delegates;
      var arg_request = buildDelegate();
      var arg_userId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Delegate.fromJson(json);
        checkDelegate(obj);

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
        var resp = convert.json.encode(buildDelegate());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .create(arg_request, arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkDelegate(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.UsersSettingsDelegatesResourceApi res =
          new api.GmailApi(mock).users.settings.delegates;
      var arg_userId = "foo";
      var arg_delegateEmail = "foo";
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
          .delete(arg_userId, arg_delegateEmail, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.UsersSettingsDelegatesResourceApi res =
          new api.GmailApi(mock).users.settings.delegates;
      var arg_userId = "foo";
      var arg_delegateEmail = "foo";
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
        var resp = convert.json.encode(buildDelegate());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_userId, arg_delegateEmail, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkDelegate(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.UsersSettingsDelegatesResourceApi res =
          new api.GmailApi(mock).users.settings.delegates;
      var arg_userId = "foo";
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
        var resp = convert.json.encode(buildListDelegatesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkListDelegatesResponse(response);
      })));
    });
  });

  unittest.group("resource-UsersSettingsFiltersResourceApi", () {
    unittest.test("method--create", () {
      var mock = new HttpServerMock();
      api.UsersSettingsFiltersResourceApi res =
          new api.GmailApi(mock).users.settings.filters;
      var arg_request = buildFilter();
      var arg_userId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.Filter.fromJson(json);
        checkFilter(obj);

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
        var resp = convert.json.encode(buildFilter());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .create(arg_request, arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkFilter(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.UsersSettingsFiltersResourceApi res =
          new api.GmailApi(mock).users.settings.filters;
      var arg_userId = "foo";
      var arg_id = "foo";
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
          .delete(arg_userId, arg_id, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.UsersSettingsFiltersResourceApi res =
          new api.GmailApi(mock).users.settings.filters;
      var arg_userId = "foo";
      var arg_id = "foo";
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
        var resp = convert.json.encode(buildFilter());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_userId, arg_id, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkFilter(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.UsersSettingsFiltersResourceApi res =
          new api.GmailApi(mock).users.settings.filters;
      var arg_userId = "foo";
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
        var resp = convert.json.encode(buildListFiltersResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkListFiltersResponse(response);
      })));
    });
  });

  unittest.group("resource-UsersSettingsForwardingAddressesResourceApi", () {
    unittest.test("method--create", () {
      var mock = new HttpServerMock();
      api.UsersSettingsForwardingAddressesResourceApi res =
          new api.GmailApi(mock).users.settings.forwardingAddresses;
      var arg_request = buildForwardingAddress();
      var arg_userId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.ForwardingAddress.fromJson(json);
        checkForwardingAddress(obj);

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
        var resp = convert.json.encode(buildForwardingAddress());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .create(arg_request, arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkForwardingAddress(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.UsersSettingsForwardingAddressesResourceApi res =
          new api.GmailApi(mock).users.settings.forwardingAddresses;
      var arg_userId = "foo";
      var arg_forwardingEmail = "foo";
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
          .delete(arg_userId, arg_forwardingEmail, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.UsersSettingsForwardingAddressesResourceApi res =
          new api.GmailApi(mock).users.settings.forwardingAddresses;
      var arg_userId = "foo";
      var arg_forwardingEmail = "foo";
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
        var resp = convert.json.encode(buildForwardingAddress());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_userId, arg_forwardingEmail, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkForwardingAddress(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.UsersSettingsForwardingAddressesResourceApi res =
          new api.GmailApi(mock).users.settings.forwardingAddresses;
      var arg_userId = "foo";
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
        var resp = convert.json.encode(buildListForwardingAddressesResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkListForwardingAddressesResponse(response);
      })));
    });
  });

  unittest.group("resource-UsersSettingsSendAsResourceApi", () {
    unittest.test("method--create", () {
      var mock = new HttpServerMock();
      api.UsersSettingsSendAsResourceApi res =
          new api.GmailApi(mock).users.settings.sendAs;
      var arg_request = buildSendAs();
      var arg_userId = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.SendAs.fromJson(json);
        checkSendAs(obj);

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
        var resp = convert.json.encode(buildSendAs());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .create(arg_request, arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkSendAs(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.UsersSettingsSendAsResourceApi res =
          new api.GmailApi(mock).users.settings.sendAs;
      var arg_userId = "foo";
      var arg_sendAsEmail = "foo";
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
          .delete(arg_userId, arg_sendAsEmail, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.UsersSettingsSendAsResourceApi res =
          new api.GmailApi(mock).users.settings.sendAs;
      var arg_userId = "foo";
      var arg_sendAsEmail = "foo";
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
        var resp = convert.json.encode(buildSendAs());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_userId, arg_sendAsEmail, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkSendAs(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.UsersSettingsSendAsResourceApi res =
          new api.GmailApi(mock).users.settings.sendAs;
      var arg_userId = "foo";
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
        var resp = convert.json.encode(buildListSendAsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_userId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkListSendAsResponse(response);
      })));
    });

    unittest.test("method--patch", () {
      var mock = new HttpServerMock();
      api.UsersSettingsSendAsResourceApi res =
          new api.GmailApi(mock).users.settings.sendAs;
      var arg_request = buildSendAs();
      var arg_userId = "foo";
      var arg_sendAsEmail = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.SendAs.fromJson(json);
        checkSendAs(obj);

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
        var resp = convert.json.encode(buildSendAs());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .patch(arg_request, arg_userId, arg_sendAsEmail, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkSendAs(response);
      })));
    });

    unittest.test("method--update", () {
      var mock = new HttpServerMock();
      api.UsersSettingsSendAsResourceApi res =
          new api.GmailApi(mock).users.settings.sendAs;
      var arg_request = buildSendAs();
      var arg_userId = "foo";
      var arg_sendAsEmail = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.SendAs.fromJson(json);
        checkSendAs(obj);

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
        var resp = convert.json.encode(buildSendAs());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .update(arg_request, arg_userId, arg_sendAsEmail,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkSendAs(response);
      })));
    });

    unittest.test("method--verify", () {
      var mock = new HttpServerMock();
      api.UsersSettingsSendAsResourceApi res =
          new api.GmailApi(mock).users.settings.sendAs;
      var arg_userId = "foo";
      var arg_sendAsEmail = "foo";
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
          .verify(arg_userId, arg_sendAsEmail, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });
  });

  unittest.group("resource-UsersSettingsSendAsSmimeInfoResourceApi", () {
    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.UsersSettingsSendAsSmimeInfoResourceApi res =
          new api.GmailApi(mock).users.settings.sendAs.smimeInfo;
      var arg_userId = "foo";
      var arg_sendAsEmail = "foo";
      var arg_id = "foo";
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
          .delete(arg_userId, arg_sendAsEmail, arg_id, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.UsersSettingsSendAsSmimeInfoResourceApi res =
          new api.GmailApi(mock).users.settings.sendAs.smimeInfo;
      var arg_userId = "foo";
      var arg_sendAsEmail = "foo";
      var arg_id = "foo";
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
        var resp = convert.json.encode(buildSmimeInfo());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_userId, arg_sendAsEmail, arg_id, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkSmimeInfo(response);
      })));
    });

    unittest.test("method--insert", () {
      var mock = new HttpServerMock();
      api.UsersSettingsSendAsSmimeInfoResourceApi res =
          new api.GmailApi(mock).users.settings.sendAs.smimeInfo;
      var arg_request = buildSmimeInfo();
      var arg_userId = "foo";
      var arg_sendAsEmail = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.SmimeInfo.fromJson(json);
        checkSmimeInfo(obj);

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
        var resp = convert.json.encode(buildSmimeInfo());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .insert(arg_request, arg_userId, arg_sendAsEmail,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkSmimeInfo(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.UsersSettingsSendAsSmimeInfoResourceApi res =
          new api.GmailApi(mock).users.settings.sendAs.smimeInfo;
      var arg_userId = "foo";
      var arg_sendAsEmail = "foo";
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
        var resp = convert.json.encode(buildListSmimeInfoResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_userId, arg_sendAsEmail, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkListSmimeInfoResponse(response);
      })));
    });

    unittest.test("method--setDefault", () {
      var mock = new HttpServerMock();
      api.UsersSettingsSendAsSmimeInfoResourceApi res =
          new api.GmailApi(mock).users.settings.sendAs.smimeInfo;
      var arg_userId = "foo";
      var arg_sendAsEmail = "foo";
      var arg_id = "foo";
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
          .setDefault(arg_userId, arg_sendAsEmail, arg_id, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });
  });

  unittest.group("resource-UsersThreadsResourceApi", () {
    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.UsersThreadsResourceApi res = new api.GmailApi(mock).users.threads;
      var arg_userId = "foo";
      var arg_id = "foo";
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
          .delete(arg_userId, arg_id, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.UsersThreadsResourceApi res = new api.GmailApi(mock).users.threads;
      var arg_userId = "foo";
      var arg_id = "foo";
      var arg_format = "foo";
      var arg_metadataHeaders = buildUnnamed1102();
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
        unittest.expect(queryMap["format"].first, unittest.equals(arg_format));
        unittest.expect(
            queryMap["metadataHeaders"], unittest.equals(arg_metadataHeaders));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildThread());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_userId, arg_id,
              format: arg_format,
              metadataHeaders: arg_metadataHeaders,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkThread(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.UsersThreadsResourceApi res = new api.GmailApi(mock).users.threads;
      var arg_userId = "foo";
      var arg_includeSpamTrash = true;
      var arg_labelIds = buildUnnamed1103();
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      var arg_q = "foo";
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
        unittest.expect(queryMap["includeSpamTrash"].first,
            unittest.equals("$arg_includeSpamTrash"));
        unittest.expect(queryMap["labelIds"], unittest.equals(arg_labelIds));
        unittest.expect(core.int.parse(queryMap["maxResults"].first),
            unittest.equals(arg_maxResults));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["q"].first, unittest.equals(arg_q));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildListThreadsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_userId,
              includeSpamTrash: arg_includeSpamTrash,
              labelIds: arg_labelIds,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              q: arg_q,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkListThreadsResponse(response);
      })));
    });

    unittest.test("method--modify", () {
      var mock = new HttpServerMock();
      api.UsersThreadsResourceApi res = new api.GmailApi(mock).users.threads;
      var arg_request = buildModifyThreadRequest();
      var arg_userId = "foo";
      var arg_id = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = new api.ModifyThreadRequest.fromJson(json);
        checkModifyThreadRequest(obj);

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
        var resp = convert.json.encode(buildThread());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .modify(arg_request, arg_userId, arg_id, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkThread(response);
      })));
    });

    unittest.test("method--trash", () {
      var mock = new HttpServerMock();
      api.UsersThreadsResourceApi res = new api.GmailApi(mock).users.threads;
      var arg_userId = "foo";
      var arg_id = "foo";
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
        var resp = convert.json.encode(buildThread());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .trash(arg_userId, arg_id, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkThread(response);
      })));
    });

    unittest.test("method--untrash", () {
      var mock = new HttpServerMock();
      api.UsersThreadsResourceApi res = new api.GmailApi(mock).users.threads;
      var arg_userId = "foo";
      var arg_id = "foo";
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
        var resp = convert.json.encode(buildThread());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .untrash(arg_userId, arg_id, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkThread(response);
      })));
    });
  });
}
