library googleapis.adsense.v1_4.test;

import "dart:core" as core;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:test/test.dart' as unittest;

import 'package:googleapis/adsense/v1_4.dart' as api;

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

buildUnnamed2174() {
  var o = new core.List<api.Account>();
  o.add(buildAccount());
  o.add(buildAccount());
  return o;
}

checkUnnamed2174(core.List<api.Account> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccount(o[0]);
  checkAccount(o[1]);
}

core.int buildCounterAccount = 0;
buildAccount() {
  var o = new api.Account();
  buildCounterAccount++;
  if (buildCounterAccount < 3) {
    o.creationTime = "foo";
    o.id = "foo";
    o.kind = "foo";
    o.name = "foo";
    o.premium = true;
    o.subAccounts = buildUnnamed2174();
    o.timezone = "foo";
  }
  buildCounterAccount--;
  return o;
}

checkAccount(api.Account o) {
  buildCounterAccount++;
  if (buildCounterAccount < 3) {
    unittest.expect(o.creationTime, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.premium, unittest.isTrue);
    checkUnnamed2174(o.subAccounts);
    unittest.expect(o.timezone, unittest.equals('foo'));
  }
  buildCounterAccount--;
}

buildUnnamed2175() {
  var o = new core.List<api.Account>();
  o.add(buildAccount());
  o.add(buildAccount());
  return o;
}

checkUnnamed2175(core.List<api.Account> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAccount(o[0]);
  checkAccount(o[1]);
}

core.int buildCounterAccounts = 0;
buildAccounts() {
  var o = new api.Accounts();
  buildCounterAccounts++;
  if (buildCounterAccounts < 3) {
    o.etag = "foo";
    o.items = buildUnnamed2175();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterAccounts--;
  return o;
}

checkAccounts(api.Accounts o) {
  buildCounterAccounts++;
  if (buildCounterAccounts < 3) {
    unittest.expect(o.etag, unittest.equals('foo'));
    checkUnnamed2175(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterAccounts--;
}

core.int buildCounterAdClient = 0;
buildAdClient() {
  var o = new api.AdClient();
  buildCounterAdClient++;
  if (buildCounterAdClient < 3) {
    o.arcOptIn = true;
    o.id = "foo";
    o.kind = "foo";
    o.productCode = "foo";
    o.supportsReporting = true;
  }
  buildCounterAdClient--;
  return o;
}

checkAdClient(api.AdClient o) {
  buildCounterAdClient++;
  if (buildCounterAdClient < 3) {
    unittest.expect(o.arcOptIn, unittest.isTrue);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.productCode, unittest.equals('foo'));
    unittest.expect(o.supportsReporting, unittest.isTrue);
  }
  buildCounterAdClient--;
}

buildUnnamed2176() {
  var o = new core.List<api.AdClient>();
  o.add(buildAdClient());
  o.add(buildAdClient());
  return o;
}

checkUnnamed2176(core.List<api.AdClient> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAdClient(o[0]);
  checkAdClient(o[1]);
}

core.int buildCounterAdClients = 0;
buildAdClients() {
  var o = new api.AdClients();
  buildCounterAdClients++;
  if (buildCounterAdClients < 3) {
    o.etag = "foo";
    o.items = buildUnnamed2176();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterAdClients--;
  return o;
}

checkAdClients(api.AdClients o) {
  buildCounterAdClients++;
  if (buildCounterAdClients < 3) {
    unittest.expect(o.etag, unittest.equals('foo'));
    checkUnnamed2176(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterAdClients--;
}

core.int buildCounterAdCode = 0;
buildAdCode() {
  var o = new api.AdCode();
  buildCounterAdCode++;
  if (buildCounterAdCode < 3) {
    o.adCode = "foo";
    o.ampBody = "foo";
    o.ampHead = "foo";
    o.kind = "foo";
  }
  buildCounterAdCode--;
  return o;
}

checkAdCode(api.AdCode o) {
  buildCounterAdCode++;
  if (buildCounterAdCode < 3) {
    unittest.expect(o.adCode, unittest.equals('foo'));
    unittest.expect(o.ampBody, unittest.equals('foo'));
    unittest.expect(o.ampHead, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterAdCode--;
}

core.int buildCounterAdStyleColors = 0;
buildAdStyleColors() {
  var o = new api.AdStyleColors();
  buildCounterAdStyleColors++;
  if (buildCounterAdStyleColors < 3) {
    o.background = "foo";
    o.border = "foo";
    o.text = "foo";
    o.title = "foo";
    o.url = "foo";
  }
  buildCounterAdStyleColors--;
  return o;
}

checkAdStyleColors(api.AdStyleColors o) {
  buildCounterAdStyleColors++;
  if (buildCounterAdStyleColors < 3) {
    unittest.expect(o.background, unittest.equals('foo'));
    unittest.expect(o.border, unittest.equals('foo'));
    unittest.expect(o.text, unittest.equals('foo'));
    unittest.expect(o.title, unittest.equals('foo'));
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterAdStyleColors--;
}

core.int buildCounterAdStyleFont = 0;
buildAdStyleFont() {
  var o = new api.AdStyleFont();
  buildCounterAdStyleFont++;
  if (buildCounterAdStyleFont < 3) {
    o.family = "foo";
    o.size = "foo";
  }
  buildCounterAdStyleFont--;
  return o;
}

checkAdStyleFont(api.AdStyleFont o) {
  buildCounterAdStyleFont++;
  if (buildCounterAdStyleFont < 3) {
    unittest.expect(o.family, unittest.equals('foo'));
    unittest.expect(o.size, unittest.equals('foo'));
  }
  buildCounterAdStyleFont--;
}

core.int buildCounterAdStyle = 0;
buildAdStyle() {
  var o = new api.AdStyle();
  buildCounterAdStyle++;
  if (buildCounterAdStyle < 3) {
    o.colors = buildAdStyleColors();
    o.corners = "foo";
    o.font = buildAdStyleFont();
    o.kind = "foo";
  }
  buildCounterAdStyle--;
  return o;
}

checkAdStyle(api.AdStyle o) {
  buildCounterAdStyle++;
  if (buildCounterAdStyle < 3) {
    checkAdStyleColors(o.colors);
    unittest.expect(o.corners, unittest.equals('foo'));
    checkAdStyleFont(o.font);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterAdStyle--;
}

core.int buildCounterAdUnitContentAdsSettingsBackupOption = 0;
buildAdUnitContentAdsSettingsBackupOption() {
  var o = new api.AdUnitContentAdsSettingsBackupOption();
  buildCounterAdUnitContentAdsSettingsBackupOption++;
  if (buildCounterAdUnitContentAdsSettingsBackupOption < 3) {
    o.color = "foo";
    o.type = "foo";
    o.url = "foo";
  }
  buildCounterAdUnitContentAdsSettingsBackupOption--;
  return o;
}

checkAdUnitContentAdsSettingsBackupOption(
    api.AdUnitContentAdsSettingsBackupOption o) {
  buildCounterAdUnitContentAdsSettingsBackupOption++;
  if (buildCounterAdUnitContentAdsSettingsBackupOption < 3) {
    unittest.expect(o.color, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterAdUnitContentAdsSettingsBackupOption--;
}

core.int buildCounterAdUnitContentAdsSettings = 0;
buildAdUnitContentAdsSettings() {
  var o = new api.AdUnitContentAdsSettings();
  buildCounterAdUnitContentAdsSettings++;
  if (buildCounterAdUnitContentAdsSettings < 3) {
    o.backupOption = buildAdUnitContentAdsSettingsBackupOption();
    o.size = "foo";
    o.type = "foo";
  }
  buildCounterAdUnitContentAdsSettings--;
  return o;
}

checkAdUnitContentAdsSettings(api.AdUnitContentAdsSettings o) {
  buildCounterAdUnitContentAdsSettings++;
  if (buildCounterAdUnitContentAdsSettings < 3) {
    checkAdUnitContentAdsSettingsBackupOption(o.backupOption);
    unittest.expect(o.size, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterAdUnitContentAdsSettings--;
}

core.int buildCounterAdUnitFeedAdsSettings = 0;
buildAdUnitFeedAdsSettings() {
  var o = new api.AdUnitFeedAdsSettings();
  buildCounterAdUnitFeedAdsSettings++;
  if (buildCounterAdUnitFeedAdsSettings < 3) {
    o.adPosition = "foo";
    o.frequency = 42;
    o.minimumWordCount = 42;
    o.type = "foo";
  }
  buildCounterAdUnitFeedAdsSettings--;
  return o;
}

checkAdUnitFeedAdsSettings(api.AdUnitFeedAdsSettings o) {
  buildCounterAdUnitFeedAdsSettings++;
  if (buildCounterAdUnitFeedAdsSettings < 3) {
    unittest.expect(o.adPosition, unittest.equals('foo'));
    unittest.expect(o.frequency, unittest.equals(42));
    unittest.expect(o.minimumWordCount, unittest.equals(42));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterAdUnitFeedAdsSettings--;
}

core.int buildCounterAdUnitMobileContentAdsSettings = 0;
buildAdUnitMobileContentAdsSettings() {
  var o = new api.AdUnitMobileContentAdsSettings();
  buildCounterAdUnitMobileContentAdsSettings++;
  if (buildCounterAdUnitMobileContentAdsSettings < 3) {
    o.markupLanguage = "foo";
    o.scriptingLanguage = "foo";
    o.size = "foo";
    o.type = "foo";
  }
  buildCounterAdUnitMobileContentAdsSettings--;
  return o;
}

checkAdUnitMobileContentAdsSettings(api.AdUnitMobileContentAdsSettings o) {
  buildCounterAdUnitMobileContentAdsSettings++;
  if (buildCounterAdUnitMobileContentAdsSettings < 3) {
    unittest.expect(o.markupLanguage, unittest.equals('foo'));
    unittest.expect(o.scriptingLanguage, unittest.equals('foo'));
    unittest.expect(o.size, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterAdUnitMobileContentAdsSettings--;
}

core.int buildCounterAdUnit = 0;
buildAdUnit() {
  var o = new api.AdUnit();
  buildCounterAdUnit++;
  if (buildCounterAdUnit < 3) {
    o.code = "foo";
    o.contentAdsSettings = buildAdUnitContentAdsSettings();
    o.customStyle = buildAdStyle();
    o.feedAdsSettings = buildAdUnitFeedAdsSettings();
    o.id = "foo";
    o.kind = "foo";
    o.mobileContentAdsSettings = buildAdUnitMobileContentAdsSettings();
    o.name = "foo";
    o.savedStyleId = "foo";
    o.status = "foo";
  }
  buildCounterAdUnit--;
  return o;
}

checkAdUnit(api.AdUnit o) {
  buildCounterAdUnit++;
  if (buildCounterAdUnit < 3) {
    unittest.expect(o.code, unittest.equals('foo'));
    checkAdUnitContentAdsSettings(o.contentAdsSettings);
    checkAdStyle(o.customStyle);
    checkAdUnitFeedAdsSettings(o.feedAdsSettings);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkAdUnitMobileContentAdsSettings(o.mobileContentAdsSettings);
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.savedStyleId, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals('foo'));
  }
  buildCounterAdUnit--;
}

buildUnnamed2177() {
  var o = new core.List<api.AdUnit>();
  o.add(buildAdUnit());
  o.add(buildAdUnit());
  return o;
}

checkUnnamed2177(core.List<api.AdUnit> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAdUnit(o[0]);
  checkAdUnit(o[1]);
}

core.int buildCounterAdUnits = 0;
buildAdUnits() {
  var o = new api.AdUnits();
  buildCounterAdUnits++;
  if (buildCounterAdUnits < 3) {
    o.etag = "foo";
    o.items = buildUnnamed2177();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterAdUnits--;
  return o;
}

checkAdUnits(api.AdUnits o) {
  buildCounterAdUnits++;
  if (buildCounterAdUnits < 3) {
    unittest.expect(o.etag, unittest.equals('foo'));
    checkUnnamed2177(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterAdUnits--;
}

buildUnnamed2178() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed2178(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterAdsenseReportsGenerateResponseHeaders = 0;
buildAdsenseReportsGenerateResponseHeaders() {
  var o = new api.AdsenseReportsGenerateResponseHeaders();
  buildCounterAdsenseReportsGenerateResponseHeaders++;
  if (buildCounterAdsenseReportsGenerateResponseHeaders < 3) {
    o.currency = "foo";
    o.name = "foo";
    o.type = "foo";
  }
  buildCounterAdsenseReportsGenerateResponseHeaders--;
  return o;
}

checkAdsenseReportsGenerateResponseHeaders(
    api.AdsenseReportsGenerateResponseHeaders o) {
  buildCounterAdsenseReportsGenerateResponseHeaders++;
  if (buildCounterAdsenseReportsGenerateResponseHeaders < 3) {
    unittest.expect(o.currency, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterAdsenseReportsGenerateResponseHeaders--;
}

buildUnnamed2179() {
  var o = new core.List<api.AdsenseReportsGenerateResponseHeaders>();
  o.add(buildAdsenseReportsGenerateResponseHeaders());
  o.add(buildAdsenseReportsGenerateResponseHeaders());
  return o;
}

checkUnnamed2179(core.List<api.AdsenseReportsGenerateResponseHeaders> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAdsenseReportsGenerateResponseHeaders(o[0]);
  checkAdsenseReportsGenerateResponseHeaders(o[1]);
}

buildUnnamed2180() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed2180(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed2181() {
  var o = new core.List<core.List<core.String>>();
  o.add(buildUnnamed2180());
  o.add(buildUnnamed2180());
  return o;
}

checkUnnamed2181(core.List<core.List<core.String>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed2180(o[0]);
  checkUnnamed2180(o[1]);
}

buildUnnamed2182() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed2182(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed2183() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed2183(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterAdsenseReportsGenerateResponse = 0;
buildAdsenseReportsGenerateResponse() {
  var o = new api.AdsenseReportsGenerateResponse();
  buildCounterAdsenseReportsGenerateResponse++;
  if (buildCounterAdsenseReportsGenerateResponse < 3) {
    o.averages = buildUnnamed2178();
    o.endDate = "foo";
    o.headers = buildUnnamed2179();
    o.kind = "foo";
    o.rows = buildUnnamed2181();
    o.startDate = "foo";
    o.totalMatchedRows = "foo";
    o.totals = buildUnnamed2182();
    o.warnings = buildUnnamed2183();
  }
  buildCounterAdsenseReportsGenerateResponse--;
  return o;
}

checkAdsenseReportsGenerateResponse(api.AdsenseReportsGenerateResponse o) {
  buildCounterAdsenseReportsGenerateResponse++;
  if (buildCounterAdsenseReportsGenerateResponse < 3) {
    checkUnnamed2178(o.averages);
    unittest.expect(o.endDate, unittest.equals('foo'));
    checkUnnamed2179(o.headers);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed2181(o.rows);
    unittest.expect(o.startDate, unittest.equals('foo'));
    unittest.expect(o.totalMatchedRows, unittest.equals('foo'));
    checkUnnamed2182(o.totals);
    checkUnnamed2183(o.warnings);
  }
  buildCounterAdsenseReportsGenerateResponse--;
}

core.int buildCounterAlert = 0;
buildAlert() {
  var o = new api.Alert();
  buildCounterAlert++;
  if (buildCounterAlert < 3) {
    o.id = "foo";
    o.isDismissible = true;
    o.kind = "foo";
    o.message = "foo";
    o.severity = "foo";
    o.type = "foo";
  }
  buildCounterAlert--;
  return o;
}

checkAlert(api.Alert o) {
  buildCounterAlert++;
  if (buildCounterAlert < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.isDismissible, unittest.isTrue);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.message, unittest.equals('foo'));
    unittest.expect(o.severity, unittest.equals('foo'));
    unittest.expect(o.type, unittest.equals('foo'));
  }
  buildCounterAlert--;
}

buildUnnamed2184() {
  var o = new core.List<api.Alert>();
  o.add(buildAlert());
  o.add(buildAlert());
  return o;
}

checkUnnamed2184(core.List<api.Alert> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAlert(o[0]);
  checkAlert(o[1]);
}

core.int buildCounterAlerts = 0;
buildAlerts() {
  var o = new api.Alerts();
  buildCounterAlerts++;
  if (buildCounterAlerts < 3) {
    o.items = buildUnnamed2184();
    o.kind = "foo";
  }
  buildCounterAlerts--;
  return o;
}

checkAlerts(api.Alerts o) {
  buildCounterAlerts++;
  if (buildCounterAlerts < 3) {
    checkUnnamed2184(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterAlerts--;
}

core.int buildCounterCustomChannelTargetingInfo = 0;
buildCustomChannelTargetingInfo() {
  var o = new api.CustomChannelTargetingInfo();
  buildCounterCustomChannelTargetingInfo++;
  if (buildCounterCustomChannelTargetingInfo < 3) {
    o.adsAppearOn = "foo";
    o.description = "foo";
    o.location = "foo";
    o.siteLanguage = "foo";
  }
  buildCounterCustomChannelTargetingInfo--;
  return o;
}

checkCustomChannelTargetingInfo(api.CustomChannelTargetingInfo o) {
  buildCounterCustomChannelTargetingInfo++;
  if (buildCounterCustomChannelTargetingInfo < 3) {
    unittest.expect(o.adsAppearOn, unittest.equals('foo'));
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.location, unittest.equals('foo'));
    unittest.expect(o.siteLanguage, unittest.equals('foo'));
  }
  buildCounterCustomChannelTargetingInfo--;
}

core.int buildCounterCustomChannel = 0;
buildCustomChannel() {
  var o = new api.CustomChannel();
  buildCounterCustomChannel++;
  if (buildCounterCustomChannel < 3) {
    o.code = "foo";
    o.id = "foo";
    o.kind = "foo";
    o.name = "foo";
    o.targetingInfo = buildCustomChannelTargetingInfo();
  }
  buildCounterCustomChannel--;
  return o;
}

checkCustomChannel(api.CustomChannel o) {
  buildCounterCustomChannel++;
  if (buildCounterCustomChannel < 3) {
    unittest.expect(o.code, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
    checkCustomChannelTargetingInfo(o.targetingInfo);
  }
  buildCounterCustomChannel--;
}

buildUnnamed2185() {
  var o = new core.List<api.CustomChannel>();
  o.add(buildCustomChannel());
  o.add(buildCustomChannel());
  return o;
}

checkUnnamed2185(core.List<api.CustomChannel> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCustomChannel(o[0]);
  checkCustomChannel(o[1]);
}

core.int buildCounterCustomChannels = 0;
buildCustomChannels() {
  var o = new api.CustomChannels();
  buildCounterCustomChannels++;
  if (buildCounterCustomChannels < 3) {
    o.etag = "foo";
    o.items = buildUnnamed2185();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterCustomChannels--;
  return o;
}

checkCustomChannels(api.CustomChannels o) {
  buildCounterCustomChannels++;
  if (buildCounterCustomChannels < 3) {
    unittest.expect(o.etag, unittest.equals('foo'));
    checkUnnamed2185(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterCustomChannels--;
}

buildUnnamed2186() {
  var o = new core.List<api.ReportingMetadataEntry>();
  o.add(buildReportingMetadataEntry());
  o.add(buildReportingMetadataEntry());
  return o;
}

checkUnnamed2186(core.List<api.ReportingMetadataEntry> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkReportingMetadataEntry(o[0]);
  checkReportingMetadataEntry(o[1]);
}

core.int buildCounterMetadata = 0;
buildMetadata() {
  var o = new api.Metadata();
  buildCounterMetadata++;
  if (buildCounterMetadata < 3) {
    o.items = buildUnnamed2186();
    o.kind = "foo";
  }
  buildCounterMetadata--;
  return o;
}

checkMetadata(api.Metadata o) {
  buildCounterMetadata++;
  if (buildCounterMetadata < 3) {
    checkUnnamed2186(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterMetadata--;
}

core.int buildCounterPayment = 0;
buildPayment() {
  var o = new api.Payment();
  buildCounterPayment++;
  if (buildCounterPayment < 3) {
    o.id = "foo";
    o.kind = "foo";
    o.paymentAmount = "foo";
    o.paymentAmountCurrencyCode = "foo";
    o.paymentDate = "foo";
  }
  buildCounterPayment--;
  return o;
}

checkPayment(api.Payment o) {
  buildCounterPayment++;
  if (buildCounterPayment < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.paymentAmount, unittest.equals('foo'));
    unittest.expect(o.paymentAmountCurrencyCode, unittest.equals('foo'));
    unittest.expect(o.paymentDate, unittest.equals('foo'));
  }
  buildCounterPayment--;
}

buildUnnamed2187() {
  var o = new core.List<api.Payment>();
  o.add(buildPayment());
  o.add(buildPayment());
  return o;
}

checkUnnamed2187(core.List<api.Payment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPayment(o[0]);
  checkPayment(o[1]);
}

core.int buildCounterPayments = 0;
buildPayments() {
  var o = new api.Payments();
  buildCounterPayments++;
  if (buildCounterPayments < 3) {
    o.items = buildUnnamed2187();
    o.kind = "foo";
  }
  buildCounterPayments--;
  return o;
}

checkPayments(api.Payments o) {
  buildCounterPayments++;
  if (buildCounterPayments < 3) {
    checkUnnamed2187(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterPayments--;
}

buildUnnamed2188() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed2188(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed2189() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed2189(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed2190() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed2190(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed2191() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed2191(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed2192() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed2192(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterReportingMetadataEntry = 0;
buildReportingMetadataEntry() {
  var o = new api.ReportingMetadataEntry();
  buildCounterReportingMetadataEntry++;
  if (buildCounterReportingMetadataEntry < 3) {
    o.compatibleDimensions = buildUnnamed2188();
    o.compatibleMetrics = buildUnnamed2189();
    o.id = "foo";
    o.kind = "foo";
    o.requiredDimensions = buildUnnamed2190();
    o.requiredMetrics = buildUnnamed2191();
    o.supportedProducts = buildUnnamed2192();
  }
  buildCounterReportingMetadataEntry--;
  return o;
}

checkReportingMetadataEntry(api.ReportingMetadataEntry o) {
  buildCounterReportingMetadataEntry++;
  if (buildCounterReportingMetadataEntry < 3) {
    checkUnnamed2188(o.compatibleDimensions);
    checkUnnamed2189(o.compatibleMetrics);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed2190(o.requiredDimensions);
    checkUnnamed2191(o.requiredMetrics);
    checkUnnamed2192(o.supportedProducts);
  }
  buildCounterReportingMetadataEntry--;
}

core.int buildCounterSavedAdStyle = 0;
buildSavedAdStyle() {
  var o = new api.SavedAdStyle();
  buildCounterSavedAdStyle++;
  if (buildCounterSavedAdStyle < 3) {
    o.adStyle = buildAdStyle();
    o.id = "foo";
    o.kind = "foo";
    o.name = "foo";
  }
  buildCounterSavedAdStyle--;
  return o;
}

checkSavedAdStyle(api.SavedAdStyle o) {
  buildCounterSavedAdStyle++;
  if (buildCounterSavedAdStyle < 3) {
    checkAdStyle(o.adStyle);
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
  }
  buildCounterSavedAdStyle--;
}

buildUnnamed2193() {
  var o = new core.List<api.SavedAdStyle>();
  o.add(buildSavedAdStyle());
  o.add(buildSavedAdStyle());
  return o;
}

checkUnnamed2193(core.List<api.SavedAdStyle> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSavedAdStyle(o[0]);
  checkSavedAdStyle(o[1]);
}

core.int buildCounterSavedAdStyles = 0;
buildSavedAdStyles() {
  var o = new api.SavedAdStyles();
  buildCounterSavedAdStyles++;
  if (buildCounterSavedAdStyles < 3) {
    o.etag = "foo";
    o.items = buildUnnamed2193();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterSavedAdStyles--;
  return o;
}

checkSavedAdStyles(api.SavedAdStyles o) {
  buildCounterSavedAdStyles++;
  if (buildCounterSavedAdStyles < 3) {
    unittest.expect(o.etag, unittest.equals('foo'));
    checkUnnamed2193(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterSavedAdStyles--;
}

core.int buildCounterSavedReport = 0;
buildSavedReport() {
  var o = new api.SavedReport();
  buildCounterSavedReport++;
  if (buildCounterSavedReport < 3) {
    o.id = "foo";
    o.kind = "foo";
    o.name = "foo";
  }
  buildCounterSavedReport--;
  return o;
}

checkSavedReport(api.SavedReport o) {
  buildCounterSavedReport++;
  if (buildCounterSavedReport < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.name, unittest.equals('foo'));
  }
  buildCounterSavedReport--;
}

buildUnnamed2194() {
  var o = new core.List<api.SavedReport>();
  o.add(buildSavedReport());
  o.add(buildSavedReport());
  return o;
}

checkUnnamed2194(core.List<api.SavedReport> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSavedReport(o[0]);
  checkSavedReport(o[1]);
}

core.int buildCounterSavedReports = 0;
buildSavedReports() {
  var o = new api.SavedReports();
  buildCounterSavedReports++;
  if (buildCounterSavedReports < 3) {
    o.etag = "foo";
    o.items = buildUnnamed2194();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterSavedReports--;
  return o;
}

checkSavedReports(api.SavedReports o) {
  buildCounterSavedReports++;
  if (buildCounterSavedReports < 3) {
    unittest.expect(o.etag, unittest.equals('foo'));
    checkUnnamed2194(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterSavedReports--;
}

core.int buildCounterUrlChannel = 0;
buildUrlChannel() {
  var o = new api.UrlChannel();
  buildCounterUrlChannel++;
  if (buildCounterUrlChannel < 3) {
    o.id = "foo";
    o.kind = "foo";
    o.urlPattern = "foo";
  }
  buildCounterUrlChannel--;
  return o;
}

checkUrlChannel(api.UrlChannel o) {
  buildCounterUrlChannel++;
  if (buildCounterUrlChannel < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.urlPattern, unittest.equals('foo'));
  }
  buildCounterUrlChannel--;
}

buildUnnamed2195() {
  var o = new core.List<api.UrlChannel>();
  o.add(buildUrlChannel());
  o.add(buildUrlChannel());
  return o;
}

checkUnnamed2195(core.List<api.UrlChannel> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUrlChannel(o[0]);
  checkUrlChannel(o[1]);
}

core.int buildCounterUrlChannels = 0;
buildUrlChannels() {
  var o = new api.UrlChannels();
  buildCounterUrlChannels++;
  if (buildCounterUrlChannels < 3) {
    o.etag = "foo";
    o.items = buildUnnamed2195();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterUrlChannels--;
  return o;
}

checkUrlChannels(api.UrlChannels o) {
  buildCounterUrlChannels++;
  if (buildCounterUrlChannels < 3) {
    unittest.expect(o.etag, unittest.equals('foo'));
    checkUnnamed2195(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterUrlChannels--;
}

buildUnnamed2196() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed2196(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed2197() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed2197(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed2198() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed2198(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed2199() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed2199(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed2200() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed2200(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed2201() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed2201(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed2202() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed2202(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed2203() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed2203(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed2204() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed2204(core.List<core.String> o) {
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

  unittest.group("obj-schema-Accounts", () {
    unittest.test("to-json--from-json", () {
      var o = buildAccounts();
      var od = new api.Accounts.fromJson(o.toJson());
      checkAccounts(od);
    });
  });

  unittest.group("obj-schema-AdClient", () {
    unittest.test("to-json--from-json", () {
      var o = buildAdClient();
      var od = new api.AdClient.fromJson(o.toJson());
      checkAdClient(od);
    });
  });

  unittest.group("obj-schema-AdClients", () {
    unittest.test("to-json--from-json", () {
      var o = buildAdClients();
      var od = new api.AdClients.fromJson(o.toJson());
      checkAdClients(od);
    });
  });

  unittest.group("obj-schema-AdCode", () {
    unittest.test("to-json--from-json", () {
      var o = buildAdCode();
      var od = new api.AdCode.fromJson(o.toJson());
      checkAdCode(od);
    });
  });

  unittest.group("obj-schema-AdStyleColors", () {
    unittest.test("to-json--from-json", () {
      var o = buildAdStyleColors();
      var od = new api.AdStyleColors.fromJson(o.toJson());
      checkAdStyleColors(od);
    });
  });

  unittest.group("obj-schema-AdStyleFont", () {
    unittest.test("to-json--from-json", () {
      var o = buildAdStyleFont();
      var od = new api.AdStyleFont.fromJson(o.toJson());
      checkAdStyleFont(od);
    });
  });

  unittest.group("obj-schema-AdStyle", () {
    unittest.test("to-json--from-json", () {
      var o = buildAdStyle();
      var od = new api.AdStyle.fromJson(o.toJson());
      checkAdStyle(od);
    });
  });

  unittest.group("obj-schema-AdUnitContentAdsSettingsBackupOption", () {
    unittest.test("to-json--from-json", () {
      var o = buildAdUnitContentAdsSettingsBackupOption();
      var od =
          new api.AdUnitContentAdsSettingsBackupOption.fromJson(o.toJson());
      checkAdUnitContentAdsSettingsBackupOption(od);
    });
  });

  unittest.group("obj-schema-AdUnitContentAdsSettings", () {
    unittest.test("to-json--from-json", () {
      var o = buildAdUnitContentAdsSettings();
      var od = new api.AdUnitContentAdsSettings.fromJson(o.toJson());
      checkAdUnitContentAdsSettings(od);
    });
  });

  unittest.group("obj-schema-AdUnitFeedAdsSettings", () {
    unittest.test("to-json--from-json", () {
      var o = buildAdUnitFeedAdsSettings();
      var od = new api.AdUnitFeedAdsSettings.fromJson(o.toJson());
      checkAdUnitFeedAdsSettings(od);
    });
  });

  unittest.group("obj-schema-AdUnitMobileContentAdsSettings", () {
    unittest.test("to-json--from-json", () {
      var o = buildAdUnitMobileContentAdsSettings();
      var od = new api.AdUnitMobileContentAdsSettings.fromJson(o.toJson());
      checkAdUnitMobileContentAdsSettings(od);
    });
  });

  unittest.group("obj-schema-AdUnit", () {
    unittest.test("to-json--from-json", () {
      var o = buildAdUnit();
      var od = new api.AdUnit.fromJson(o.toJson());
      checkAdUnit(od);
    });
  });

  unittest.group("obj-schema-AdUnits", () {
    unittest.test("to-json--from-json", () {
      var o = buildAdUnits();
      var od = new api.AdUnits.fromJson(o.toJson());
      checkAdUnits(od);
    });
  });

  unittest.group("obj-schema-AdsenseReportsGenerateResponseHeaders", () {
    unittest.test("to-json--from-json", () {
      var o = buildAdsenseReportsGenerateResponseHeaders();
      var od =
          new api.AdsenseReportsGenerateResponseHeaders.fromJson(o.toJson());
      checkAdsenseReportsGenerateResponseHeaders(od);
    });
  });

  unittest.group("obj-schema-AdsenseReportsGenerateResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildAdsenseReportsGenerateResponse();
      var od = new api.AdsenseReportsGenerateResponse.fromJson(o.toJson());
      checkAdsenseReportsGenerateResponse(od);
    });
  });

  unittest.group("obj-schema-Alert", () {
    unittest.test("to-json--from-json", () {
      var o = buildAlert();
      var od = new api.Alert.fromJson(o.toJson());
      checkAlert(od);
    });
  });

  unittest.group("obj-schema-Alerts", () {
    unittest.test("to-json--from-json", () {
      var o = buildAlerts();
      var od = new api.Alerts.fromJson(o.toJson());
      checkAlerts(od);
    });
  });

  unittest.group("obj-schema-CustomChannelTargetingInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildCustomChannelTargetingInfo();
      var od = new api.CustomChannelTargetingInfo.fromJson(o.toJson());
      checkCustomChannelTargetingInfo(od);
    });
  });

  unittest.group("obj-schema-CustomChannel", () {
    unittest.test("to-json--from-json", () {
      var o = buildCustomChannel();
      var od = new api.CustomChannel.fromJson(o.toJson());
      checkCustomChannel(od);
    });
  });

  unittest.group("obj-schema-CustomChannels", () {
    unittest.test("to-json--from-json", () {
      var o = buildCustomChannels();
      var od = new api.CustomChannels.fromJson(o.toJson());
      checkCustomChannels(od);
    });
  });

  unittest.group("obj-schema-Metadata", () {
    unittest.test("to-json--from-json", () {
      var o = buildMetadata();
      var od = new api.Metadata.fromJson(o.toJson());
      checkMetadata(od);
    });
  });

  unittest.group("obj-schema-Payment", () {
    unittest.test("to-json--from-json", () {
      var o = buildPayment();
      var od = new api.Payment.fromJson(o.toJson());
      checkPayment(od);
    });
  });

  unittest.group("obj-schema-Payments", () {
    unittest.test("to-json--from-json", () {
      var o = buildPayments();
      var od = new api.Payments.fromJson(o.toJson());
      checkPayments(od);
    });
  });

  unittest.group("obj-schema-ReportingMetadataEntry", () {
    unittest.test("to-json--from-json", () {
      var o = buildReportingMetadataEntry();
      var od = new api.ReportingMetadataEntry.fromJson(o.toJson());
      checkReportingMetadataEntry(od);
    });
  });

  unittest.group("obj-schema-SavedAdStyle", () {
    unittest.test("to-json--from-json", () {
      var o = buildSavedAdStyle();
      var od = new api.SavedAdStyle.fromJson(o.toJson());
      checkSavedAdStyle(od);
    });
  });

  unittest.group("obj-schema-SavedAdStyles", () {
    unittest.test("to-json--from-json", () {
      var o = buildSavedAdStyles();
      var od = new api.SavedAdStyles.fromJson(o.toJson());
      checkSavedAdStyles(od);
    });
  });

  unittest.group("obj-schema-SavedReport", () {
    unittest.test("to-json--from-json", () {
      var o = buildSavedReport();
      var od = new api.SavedReport.fromJson(o.toJson());
      checkSavedReport(od);
    });
  });

  unittest.group("obj-schema-SavedReports", () {
    unittest.test("to-json--from-json", () {
      var o = buildSavedReports();
      var od = new api.SavedReports.fromJson(o.toJson());
      checkSavedReports(od);
    });
  });

  unittest.group("obj-schema-UrlChannel", () {
    unittest.test("to-json--from-json", () {
      var o = buildUrlChannel();
      var od = new api.UrlChannel.fromJson(o.toJson());
      checkUrlChannel(od);
    });
  });

  unittest.group("obj-schema-UrlChannels", () {
    unittest.test("to-json--from-json", () {
      var o = buildUrlChannels();
      var od = new api.UrlChannels.fromJson(o.toJson());
      checkUrlChannels(od);
    });
  });

  unittest.group("resource-AccountsResourceApi", () {
    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.AccountsResourceApi res = new api.AdsenseApi(mock).accounts;
      var arg_accountId = "foo";
      var arg_tree = true;
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
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("accounts/"));
        pathOffset += 9;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));

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
        unittest.expect(queryMap["tree"].first, unittest.equals("$arg_tree"));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildAccount());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_accountId, tree: arg_tree, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAccount(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsResourceApi res = new api.AdsenseApi(mock).accounts;
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
        unittest.expect(path.substring(pathOffset, pathOffset + 13),
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
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
        unittest.expect(core.int.parse(queryMap["maxResults"].first),
            unittest.equals(arg_maxResults));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildAccounts());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAccounts(response);
      })));
    });
  });

  unittest.group("resource-AccountsAdclientsResourceApi", () {
    unittest.test("method--getAdCode", () {
      var mock = new HttpServerMock();
      api.AccountsAdclientsResourceApi res =
          new api.AdsenseApi(mock).accounts.adclients;
      var arg_accountId = "foo";
      var arg_adClientId = "foo";
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
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("accounts/"));
        pathOffset += 9;
        index = path.indexOf("/adclients/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/adclients/"));
        pathOffset += 11;
        index = path.indexOf("/adcode", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adClientId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7),
            unittest.equals("/adcode"));
        pathOffset += 7;

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
        var resp = convert.json.encode(buildAdCode());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .getAdCode(arg_accountId, arg_adClientId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAdCode(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsAdclientsResourceApi res =
          new api.AdsenseApi(mock).accounts.adclients;
      var arg_accountId = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 13),
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("accounts/"));
        pathOffset += 9;
        index = path.indexOf("/adclients", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 10),
            unittest.equals("/adclients"));
        pathOffset += 10;

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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildAdClients());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAdClients(response);
      })));
    });
  });

  unittest.group("resource-AccountsAdunitsResourceApi", () {
    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.AccountsAdunitsResourceApi res =
          new api.AdsenseApi(mock).accounts.adunits;
      var arg_accountId = "foo";
      var arg_adClientId = "foo";
      var arg_adUnitId = "foo";
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
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("accounts/"));
        pathOffset += 9;
        index = path.indexOf("/adclients/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/adclients/"));
        pathOffset += 11;
        index = path.indexOf("/adunits/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adClientId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("/adunits/"));
        pathOffset += 9;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_adUnitId"));

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
        var resp = convert.json.encode(buildAdUnit());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_accountId, arg_adClientId, arg_adUnitId,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAdUnit(response);
      })));
    });

    unittest.test("method--getAdCode", () {
      var mock = new HttpServerMock();
      api.AccountsAdunitsResourceApi res =
          new api.AdsenseApi(mock).accounts.adunits;
      var arg_accountId = "foo";
      var arg_adClientId = "foo";
      var arg_adUnitId = "foo";
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
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("accounts/"));
        pathOffset += 9;
        index = path.indexOf("/adclients/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/adclients/"));
        pathOffset += 11;
        index = path.indexOf("/adunits/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adClientId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("/adunits/"));
        pathOffset += 9;
        index = path.indexOf("/adcode", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adUnitId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7),
            unittest.equals("/adcode"));
        pathOffset += 7;

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
        var resp = convert.json.encode(buildAdCode());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .getAdCode(arg_accountId, arg_adClientId, arg_adUnitId,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAdCode(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsAdunitsResourceApi res =
          new api.AdsenseApi(mock).accounts.adunits;
      var arg_accountId = "foo";
      var arg_adClientId = "foo";
      var arg_includeInactive = true;
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
        unittest.expect(path.substring(pathOffset, pathOffset + 13),
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("accounts/"));
        pathOffset += 9;
        index = path.indexOf("/adclients/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/adclients/"));
        pathOffset += 11;
        index = path.indexOf("/adunits", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adClientId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("/adunits"));
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
        unittest.expect(queryMap["includeInactive"].first,
            unittest.equals("$arg_includeInactive"));
        unittest.expect(core.int.parse(queryMap["maxResults"].first),
            unittest.equals(arg_maxResults));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildAdUnits());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId, arg_adClientId,
              includeInactive: arg_includeInactive,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAdUnits(response);
      })));
    });
  });

  unittest.group("resource-AccountsAdunitsCustomchannelsResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsAdunitsCustomchannelsResourceApi res =
          new api.AdsenseApi(mock).accounts.adunits.customchannels;
      var arg_accountId = "foo";
      var arg_adClientId = "foo";
      var arg_adUnitId = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 13),
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("accounts/"));
        pathOffset += 9;
        index = path.indexOf("/adclients/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/adclients/"));
        pathOffset += 11;
        index = path.indexOf("/adunits/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adClientId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("/adunits/"));
        pathOffset += 9;
        index = path.indexOf("/customchannels", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adUnitId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 15),
            unittest.equals("/customchannels"));
        pathOffset += 15;

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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildCustomChannels());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId, arg_adClientId, arg_adUnitId,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkCustomChannels(response);
      })));
    });
  });

  unittest.group("resource-AccountsAlertsResourceApi", () {
    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.AccountsAlertsResourceApi res =
          new api.AdsenseApi(mock).accounts.alerts;
      var arg_accountId = "foo";
      var arg_alertId = "foo";
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
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("accounts/"));
        pathOffset += 9;
        index = path.indexOf("/alerts/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("/alerts/"));
        pathOffset += 8;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_alertId"));

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
          .delete(arg_accountId, arg_alertId, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsAlertsResourceApi res =
          new api.AdsenseApi(mock).accounts.alerts;
      var arg_accountId = "foo";
      var arg_locale = "foo";
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
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("accounts/"));
        pathOffset += 9;
        index = path.indexOf("/alerts", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7),
            unittest.equals("/alerts"));
        pathOffset += 7;

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
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildAlerts());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId, locale: arg_locale, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAlerts(response);
      })));
    });
  });

  unittest.group("resource-AccountsCustomchannelsResourceApi", () {
    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.AccountsCustomchannelsResourceApi res =
          new api.AdsenseApi(mock).accounts.customchannels;
      var arg_accountId = "foo";
      var arg_adClientId = "foo";
      var arg_customChannelId = "foo";
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
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("accounts/"));
        pathOffset += 9;
        index = path.indexOf("/adclients/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/adclients/"));
        pathOffset += 11;
        index = path.indexOf("/customchannels/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adClientId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 16),
            unittest.equals("/customchannels/"));
        pathOffset += 16;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_customChannelId"));

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
        var resp = convert.json.encode(buildCustomChannel());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_accountId, arg_adClientId, arg_customChannelId,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkCustomChannel(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsCustomchannelsResourceApi res =
          new api.AdsenseApi(mock).accounts.customchannels;
      var arg_accountId = "foo";
      var arg_adClientId = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 13),
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("accounts/"));
        pathOffset += 9;
        index = path.indexOf("/adclients/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/adclients/"));
        pathOffset += 11;
        index = path.indexOf("/customchannels", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adClientId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 15),
            unittest.equals("/customchannels"));
        pathOffset += 15;

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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildCustomChannels());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId, arg_adClientId,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkCustomChannels(response);
      })));
    });
  });

  unittest.group("resource-AccountsCustomchannelsAdunitsResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsCustomchannelsAdunitsResourceApi res =
          new api.AdsenseApi(mock).accounts.customchannels.adunits;
      var arg_accountId = "foo";
      var arg_adClientId = "foo";
      var arg_customChannelId = "foo";
      var arg_includeInactive = true;
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
        unittest.expect(path.substring(pathOffset, pathOffset + 13),
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("accounts/"));
        pathOffset += 9;
        index = path.indexOf("/adclients/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/adclients/"));
        pathOffset += 11;
        index = path.indexOf("/customchannels/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adClientId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 16),
            unittest.equals("/customchannels/"));
        pathOffset += 16;
        index = path.indexOf("/adunits", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_customChannelId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("/adunits"));
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
        unittest.expect(queryMap["includeInactive"].first,
            unittest.equals("$arg_includeInactive"));
        unittest.expect(core.int.parse(queryMap["maxResults"].first),
            unittest.equals(arg_maxResults));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildAdUnits());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId, arg_adClientId, arg_customChannelId,
              includeInactive: arg_includeInactive,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAdUnits(response);
      })));
    });
  });

  unittest.group("resource-AccountsPaymentsResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsPaymentsResourceApi res =
          new api.AdsenseApi(mock).accounts.payments;
      var arg_accountId = "foo";
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
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("accounts/"));
        pathOffset += 9;
        index = path.indexOf("/payments", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("/payments"));
        pathOffset += 9;

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
        var resp = convert.json.encode(buildPayments());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkPayments(response);
      })));
    });
  });

  unittest.group("resource-AccountsReportsResourceApi", () {
    unittest.test("method--generate", () {
      // TODO: Implement tests for media upload;
      // TODO: Implement tests for media download;

      var mock = new HttpServerMock();
      api.AccountsReportsResourceApi res =
          new api.AdsenseApi(mock).accounts.reports;
      var arg_accountId = "foo";
      var arg_startDate = "foo";
      var arg_endDate = "foo";
      var arg_currency = "foo";
      var arg_dimension = buildUnnamed2196();
      var arg_filter = buildUnnamed2197();
      var arg_locale = "foo";
      var arg_maxResults = 42;
      var arg_metric = buildUnnamed2198();
      var arg_sort = buildUnnamed2199();
      var arg_startIndex = 42;
      var arg_useTimezoneReporting = true;
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
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("accounts/"));
        pathOffset += 9;
        index = path.indexOf("/reports", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("/reports"));
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
            queryMap["startDate"].first, unittest.equals(arg_startDate));
        unittest.expect(
            queryMap["endDate"].first, unittest.equals(arg_endDate));
        unittest.expect(
            queryMap["currency"].first, unittest.equals(arg_currency));
        unittest.expect(queryMap["dimension"], unittest.equals(arg_dimension));
        unittest.expect(queryMap["filter"], unittest.equals(arg_filter));
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));
        unittest.expect(core.int.parse(queryMap["maxResults"].first),
            unittest.equals(arg_maxResults));
        unittest.expect(queryMap["metric"], unittest.equals(arg_metric));
        unittest.expect(queryMap["sort"], unittest.equals(arg_sort));
        unittest.expect(core.int.parse(queryMap["startIndex"].first),
            unittest.equals(arg_startIndex));
        unittest.expect(queryMap["useTimezoneReporting"].first,
            unittest.equals("$arg_useTimezoneReporting"));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildAdsenseReportsGenerateResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .generate(arg_accountId, arg_startDate, arg_endDate,
              currency: arg_currency,
              dimension: arg_dimension,
              filter: arg_filter,
              locale: arg_locale,
              maxResults: arg_maxResults,
              metric: arg_metric,
              sort: arg_sort,
              startIndex: arg_startIndex,
              useTimezoneReporting: arg_useTimezoneReporting,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAdsenseReportsGenerateResponse(response);
      })));
    });
  });

  unittest.group("resource-AccountsReportsSavedResourceApi", () {
    unittest.test("method--generate", () {
      var mock = new HttpServerMock();
      api.AccountsReportsSavedResourceApi res =
          new api.AdsenseApi(mock).accounts.reports.saved;
      var arg_accountId = "foo";
      var arg_savedReportId = "foo";
      var arg_locale = "foo";
      var arg_maxResults = 42;
      var arg_startIndex = 42;
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
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("accounts/"));
        pathOffset += 9;
        index = path.indexOf("/reports/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("/reports/"));
        pathOffset += 9;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_savedReportId"));

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
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));
        unittest.expect(core.int.parse(queryMap["maxResults"].first),
            unittest.equals(arg_maxResults));
        unittest.expect(core.int.parse(queryMap["startIndex"].first),
            unittest.equals(arg_startIndex));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildAdsenseReportsGenerateResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .generate(arg_accountId, arg_savedReportId,
              locale: arg_locale,
              maxResults: arg_maxResults,
              startIndex: arg_startIndex,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAdsenseReportsGenerateResponse(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsReportsSavedResourceApi res =
          new api.AdsenseApi(mock).accounts.reports.saved;
      var arg_accountId = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 13),
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("accounts/"));
        pathOffset += 9;
        index = path.indexOf("/reports/saved", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 14),
            unittest.equals("/reports/saved"));
        pathOffset += 14;

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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildSavedReports());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkSavedReports(response);
      })));
    });
  });

  unittest.group("resource-AccountsSavedadstylesResourceApi", () {
    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.AccountsSavedadstylesResourceApi res =
          new api.AdsenseApi(mock).accounts.savedadstyles;
      var arg_accountId = "foo";
      var arg_savedAdStyleId = "foo";
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
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("accounts/"));
        pathOffset += 9;
        index = path.indexOf("/savedadstyles/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 15),
            unittest.equals("/savedadstyles/"));
        pathOffset += 15;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_savedAdStyleId"));

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
        var resp = convert.json.encode(buildSavedAdStyle());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_accountId, arg_savedAdStyleId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkSavedAdStyle(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsSavedadstylesResourceApi res =
          new api.AdsenseApi(mock).accounts.savedadstyles;
      var arg_accountId = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 13),
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("accounts/"));
        pathOffset += 9;
        index = path.indexOf("/savedadstyles", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 14),
            unittest.equals("/savedadstyles"));
        pathOffset += 14;

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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildSavedAdStyles());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkSavedAdStyles(response);
      })));
    });
  });

  unittest.group("resource-AccountsUrlchannelsResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AccountsUrlchannelsResourceApi res =
          new api.AdsenseApi(mock).accounts.urlchannels;
      var arg_accountId = "foo";
      var arg_adClientId = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 13),
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("accounts/"));
        pathOffset += 9;
        index = path.indexOf("/adclients/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_accountId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 11),
            unittest.equals("/adclients/"));
        pathOffset += 11;
        index = path.indexOf("/urlchannels", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adClientId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("/urlchannels"));
        pathOffset += 12;

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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildUrlChannels());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_accountId, arg_adClientId,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkUrlChannels(response);
      })));
    });
  });

  unittest.group("resource-AdclientsResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AdclientsResourceApi res = new api.AdsenseApi(mock).adclients;
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
        unittest.expect(path.substring(pathOffset, pathOffset + 13),
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("adclients"));
        pathOffset += 9;

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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildAdClients());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAdClients(response);
      })));
    });
  });

  unittest.group("resource-AdunitsResourceApi", () {
    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.AdunitsResourceApi res = new api.AdsenseApi(mock).adunits;
      var arg_adClientId = "foo";
      var arg_adUnitId = "foo";
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
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 10),
            unittest.equals("adclients/"));
        pathOffset += 10;
        index = path.indexOf("/adunits/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adClientId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("/adunits/"));
        pathOffset += 9;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_adUnitId"));

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
        var resp = convert.json.encode(buildAdUnit());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_adClientId, arg_adUnitId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAdUnit(response);
      })));
    });

    unittest.test("method--getAdCode", () {
      var mock = new HttpServerMock();
      api.AdunitsResourceApi res = new api.AdsenseApi(mock).adunits;
      var arg_adClientId = "foo";
      var arg_adUnitId = "foo";
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
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 10),
            unittest.equals("adclients/"));
        pathOffset += 10;
        index = path.indexOf("/adunits/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adClientId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("/adunits/"));
        pathOffset += 9;
        index = path.indexOf("/adcode", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adUnitId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7),
            unittest.equals("/adcode"));
        pathOffset += 7;

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
        var resp = convert.json.encode(buildAdCode());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .getAdCode(arg_adClientId, arg_adUnitId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAdCode(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AdunitsResourceApi res = new api.AdsenseApi(mock).adunits;
      var arg_adClientId = "foo";
      var arg_includeInactive = true;
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
        unittest.expect(path.substring(pathOffset, pathOffset + 13),
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 10),
            unittest.equals("adclients/"));
        pathOffset += 10;
        index = path.indexOf("/adunits", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adClientId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("/adunits"));
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
        unittest.expect(queryMap["includeInactive"].first,
            unittest.equals("$arg_includeInactive"));
        unittest.expect(core.int.parse(queryMap["maxResults"].first),
            unittest.equals(arg_maxResults));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildAdUnits());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_adClientId,
              includeInactive: arg_includeInactive,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAdUnits(response);
      })));
    });
  });

  unittest.group("resource-AdunitsCustomchannelsResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AdunitsCustomchannelsResourceApi res =
          new api.AdsenseApi(mock).adunits.customchannels;
      var arg_adClientId = "foo";
      var arg_adUnitId = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 13),
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 10),
            unittest.equals("adclients/"));
        pathOffset += 10;
        index = path.indexOf("/adunits/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adClientId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9),
            unittest.equals("/adunits/"));
        pathOffset += 9;
        index = path.indexOf("/customchannels", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adUnitId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 15),
            unittest.equals("/customchannels"));
        pathOffset += 15;

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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildCustomChannels());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_adClientId, arg_adUnitId,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkCustomChannels(response);
      })));
    });
  });

  unittest.group("resource-AlertsResourceApi", () {
    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.AlertsResourceApi res = new api.AdsenseApi(mock).alerts;
      var arg_alertId = "foo";
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
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 7),
            unittest.equals("alerts/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_alertId"));

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
          .delete(arg_alertId, $fields: arg_$fields)
          .then(unittest.expectAsync1((_) {}));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.AlertsResourceApi res = new api.AdsenseApi(mock).alerts;
      var arg_locale = "foo";
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
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 6),
            unittest.equals("alerts"));
        pathOffset += 6;

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
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildAlerts());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(locale: arg_locale, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAlerts(response);
      })));
    });
  });

  unittest.group("resource-CustomchannelsResourceApi", () {
    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.CustomchannelsResourceApi res =
          new api.AdsenseApi(mock).customchannels;
      var arg_adClientId = "foo";
      var arg_customChannelId = "foo";
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
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 10),
            unittest.equals("adclients/"));
        pathOffset += 10;
        index = path.indexOf("/customchannels/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adClientId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 16),
            unittest.equals("/customchannels/"));
        pathOffset += 16;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_customChannelId"));

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
        var resp = convert.json.encode(buildCustomChannel());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_adClientId, arg_customChannelId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkCustomChannel(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.CustomchannelsResourceApi res =
          new api.AdsenseApi(mock).customchannels;
      var arg_adClientId = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 13),
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 10),
            unittest.equals("adclients/"));
        pathOffset += 10;
        index = path.indexOf("/customchannels", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adClientId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 15),
            unittest.equals("/customchannels"));
        pathOffset += 15;

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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildCustomChannels());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_adClientId,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkCustomChannels(response);
      })));
    });
  });

  unittest.group("resource-CustomchannelsAdunitsResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.CustomchannelsAdunitsResourceApi res =
          new api.AdsenseApi(mock).customchannels.adunits;
      var arg_adClientId = "foo";
      var arg_customChannelId = "foo";
      var arg_includeInactive = true;
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
        unittest.expect(path.substring(pathOffset, pathOffset + 13),
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 10),
            unittest.equals("adclients/"));
        pathOffset += 10;
        index = path.indexOf("/customchannels/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adClientId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 16),
            unittest.equals("/customchannels/"));
        pathOffset += 16;
        index = path.indexOf("/adunits", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_customChannelId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("/adunits"));
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
        unittest.expect(queryMap["includeInactive"].first,
            unittest.equals("$arg_includeInactive"));
        unittest.expect(core.int.parse(queryMap["maxResults"].first),
            unittest.equals(arg_maxResults));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildAdUnits());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_adClientId, arg_customChannelId,
              includeInactive: arg_includeInactive,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAdUnits(response);
      })));
    });
  });

  unittest.group("resource-MetadataDimensionsResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.MetadataDimensionsResourceApi res =
          new api.AdsenseApi(mock).metadata.dimensions;
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
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 19),
            unittest.equals("metadata/dimensions"));
        pathOffset += 19;

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
        var resp = convert.json.encode(buildMetadata());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list($fields: arg_$fields).then(unittest.expectAsync1(((response) {
        checkMetadata(response);
      })));
    });
  });

  unittest.group("resource-MetadataMetricsResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.MetadataMetricsResourceApi res =
          new api.AdsenseApi(mock).metadata.metrics;
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
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 16),
            unittest.equals("metadata/metrics"));
        pathOffset += 16;

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
        var resp = convert.json.encode(buildMetadata());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list($fields: arg_$fields).then(unittest.expectAsync1(((response) {
        checkMetadata(response);
      })));
    });
  });

  unittest.group("resource-PaymentsResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.PaymentsResourceApi res = new api.AdsenseApi(mock).payments;
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
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("payments"));
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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildPayments());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list($fields: arg_$fields).then(unittest.expectAsync1(((response) {
        checkPayments(response);
      })));
    });
  });

  unittest.group("resource-ReportsResourceApi", () {
    unittest.test("method--generate", () {
      // TODO: Implement tests for media upload;
      // TODO: Implement tests for media download;

      var mock = new HttpServerMock();
      api.ReportsResourceApi res = new api.AdsenseApi(mock).reports;
      var arg_startDate = "foo";
      var arg_endDate = "foo";
      var arg_accountId = buildUnnamed2200();
      var arg_currency = "foo";
      var arg_dimension = buildUnnamed2201();
      var arg_filter = buildUnnamed2202();
      var arg_locale = "foo";
      var arg_maxResults = 42;
      var arg_metric = buildUnnamed2203();
      var arg_sort = buildUnnamed2204();
      var arg_startIndex = 42;
      var arg_useTimezoneReporting = true;
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
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 7),
            unittest.equals("reports"));
        pathOffset += 7;

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
            queryMap["startDate"].first, unittest.equals(arg_startDate));
        unittest.expect(
            queryMap["endDate"].first, unittest.equals(arg_endDate));
        unittest.expect(queryMap["accountId"], unittest.equals(arg_accountId));
        unittest.expect(
            queryMap["currency"].first, unittest.equals(arg_currency));
        unittest.expect(queryMap["dimension"], unittest.equals(arg_dimension));
        unittest.expect(queryMap["filter"], unittest.equals(arg_filter));
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));
        unittest.expect(core.int.parse(queryMap["maxResults"].first),
            unittest.equals(arg_maxResults));
        unittest.expect(queryMap["metric"], unittest.equals(arg_metric));
        unittest.expect(queryMap["sort"], unittest.equals(arg_sort));
        unittest.expect(core.int.parse(queryMap["startIndex"].first),
            unittest.equals(arg_startIndex));
        unittest.expect(queryMap["useTimezoneReporting"].first,
            unittest.equals("$arg_useTimezoneReporting"));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildAdsenseReportsGenerateResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .generate(arg_startDate, arg_endDate,
              accountId: arg_accountId,
              currency: arg_currency,
              dimension: arg_dimension,
              filter: arg_filter,
              locale: arg_locale,
              maxResults: arg_maxResults,
              metric: arg_metric,
              sort: arg_sort,
              startIndex: arg_startIndex,
              useTimezoneReporting: arg_useTimezoneReporting,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAdsenseReportsGenerateResponse(response);
      })));
    });
  });

  unittest.group("resource-ReportsSavedResourceApi", () {
    unittest.test("method--generate", () {
      var mock = new HttpServerMock();
      api.ReportsSavedResourceApi res = new api.AdsenseApi(mock).reports.saved;
      var arg_savedReportId = "foo";
      var arg_locale = "foo";
      var arg_maxResults = 42;
      var arg_startIndex = 42;
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
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 8),
            unittest.equals("reports/"));
        pathOffset += 8;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_savedReportId"));

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
        unittest.expect(queryMap["locale"].first, unittest.equals(arg_locale));
        unittest.expect(core.int.parse(queryMap["maxResults"].first),
            unittest.equals(arg_maxResults));
        unittest.expect(core.int.parse(queryMap["startIndex"].first),
            unittest.equals(arg_startIndex));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildAdsenseReportsGenerateResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .generate(arg_savedReportId,
              locale: arg_locale,
              maxResults: arg_maxResults,
              startIndex: arg_startIndex,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkAdsenseReportsGenerateResponse(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.ReportsSavedResourceApi res = new api.AdsenseApi(mock).reports.saved;
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
        unittest.expect(path.substring(pathOffset, pathOffset + 13),
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 13),
            unittest.equals("reports/saved"));
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
        unittest.expect(core.int.parse(queryMap["maxResults"].first),
            unittest.equals(arg_maxResults));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildSavedReports());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkSavedReports(response);
      })));
    });
  });

  unittest.group("resource-SavedadstylesResourceApi", () {
    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.SavedadstylesResourceApi res = new api.AdsenseApi(mock).savedadstyles;
      var arg_savedAdStyleId = "foo";
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
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 14),
            unittest.equals("savedadstyles/"));
        pathOffset += 14;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_savedAdStyleId"));

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
        var resp = convert.json.encode(buildSavedAdStyle());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_savedAdStyleId, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkSavedAdStyle(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.SavedadstylesResourceApi res = new api.AdsenseApi(mock).savedadstyles;
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
        unittest.expect(path.substring(pathOffset, pathOffset + 13),
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 13),
            unittest.equals("savedadstyles"));
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
        unittest.expect(core.int.parse(queryMap["maxResults"].first),
            unittest.equals(arg_maxResults));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildSavedAdStyles());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkSavedAdStyles(response);
      })));
    });
  });

  unittest.group("resource-UrlchannelsResourceApi", () {
    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.UrlchannelsResourceApi res = new api.AdsenseApi(mock).urlchannels;
      var arg_adClientId = "foo";
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
        unittest.expect(path.substring(pathOffset, pathOffset + 13),
            unittest.equals("adsense/v1.4/"));
        pathOffset += 13;
        unittest.expect(path.substring(pathOffset, pathOffset + 10),
            unittest.equals("adclients/"));
        pathOffset += 10;
        index = path.indexOf("/urlchannels", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart =
            core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_adClientId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 12),
            unittest.equals("/urlchannels"));
        pathOffset += 12;

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
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp = convert.json.encode(buildUrlChannels());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(arg_adClientId,
              maxResults: arg_maxResults,
              pageToken: arg_pageToken,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkUrlChannels(response);
      })));
    });
  });
}
