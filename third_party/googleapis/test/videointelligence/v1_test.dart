library googleapis.videointelligence.v1.test;

import "dart:core" as core;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:test/test.dart' as unittest;

import 'package:googleapis/videointelligence/v1.dart' as api;

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

buildUnnamed1939() {
  var o = new core
      .List<api.GoogleCloudVideointelligenceV1VideoAnnotationProgress>();
  o.add(buildGoogleCloudVideointelligenceV1VideoAnnotationProgress());
  o.add(buildGoogleCloudVideointelligenceV1VideoAnnotationProgress());
  return o;
}

checkUnnamed1939(
    core.List<api.GoogleCloudVideointelligenceV1VideoAnnotationProgress> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1VideoAnnotationProgress(o[0]);
  checkGoogleCloudVideointelligenceV1VideoAnnotationProgress(o[1]);
}

core.int buildCounterGoogleCloudVideointelligenceV1AnnotateVideoProgress = 0;
buildGoogleCloudVideointelligenceV1AnnotateVideoProgress() {
  var o = new api.GoogleCloudVideointelligenceV1AnnotateVideoProgress();
  buildCounterGoogleCloudVideointelligenceV1AnnotateVideoProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1AnnotateVideoProgress < 3) {
    o.annotationProgress = buildUnnamed1939();
  }
  buildCounterGoogleCloudVideointelligenceV1AnnotateVideoProgress--;
  return o;
}

checkGoogleCloudVideointelligenceV1AnnotateVideoProgress(
    api.GoogleCloudVideointelligenceV1AnnotateVideoProgress o) {
  buildCounterGoogleCloudVideointelligenceV1AnnotateVideoProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1AnnotateVideoProgress < 3) {
    checkUnnamed1939(o.annotationProgress);
  }
  buildCounterGoogleCloudVideointelligenceV1AnnotateVideoProgress--;
}

buildUnnamed1940() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1940(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterGoogleCloudVideointelligenceV1AnnotateVideoRequest = 0;
buildGoogleCloudVideointelligenceV1AnnotateVideoRequest() {
  var o = new api.GoogleCloudVideointelligenceV1AnnotateVideoRequest();
  buildCounterGoogleCloudVideointelligenceV1AnnotateVideoRequest++;
  if (buildCounterGoogleCloudVideointelligenceV1AnnotateVideoRequest < 3) {
    o.features = buildUnnamed1940();
    o.inputContent = "foo";
    o.inputUri = "foo";
    o.locationId = "foo";
    o.outputUri = "foo";
    o.videoContext = buildGoogleCloudVideointelligenceV1VideoContext();
  }
  buildCounterGoogleCloudVideointelligenceV1AnnotateVideoRequest--;
  return o;
}

checkGoogleCloudVideointelligenceV1AnnotateVideoRequest(
    api.GoogleCloudVideointelligenceV1AnnotateVideoRequest o) {
  buildCounterGoogleCloudVideointelligenceV1AnnotateVideoRequest++;
  if (buildCounterGoogleCloudVideointelligenceV1AnnotateVideoRequest < 3) {
    checkUnnamed1940(o.features);
    unittest.expect(o.inputContent, unittest.equals('foo'));
    unittest.expect(o.inputUri, unittest.equals('foo'));
    unittest.expect(o.locationId, unittest.equals('foo'));
    unittest.expect(o.outputUri, unittest.equals('foo'));
    checkGoogleCloudVideointelligenceV1VideoContext(o.videoContext);
  }
  buildCounterGoogleCloudVideointelligenceV1AnnotateVideoRequest--;
}

buildUnnamed1941() {
  var o =
      new core.List<api.GoogleCloudVideointelligenceV1VideoAnnotationResults>();
  o.add(buildGoogleCloudVideointelligenceV1VideoAnnotationResults());
  o.add(buildGoogleCloudVideointelligenceV1VideoAnnotationResults());
  return o;
}

checkUnnamed1941(
    core.List<api.GoogleCloudVideointelligenceV1VideoAnnotationResults> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1VideoAnnotationResults(o[0]);
  checkGoogleCloudVideointelligenceV1VideoAnnotationResults(o[1]);
}

core.int buildCounterGoogleCloudVideointelligenceV1AnnotateVideoResponse = 0;
buildGoogleCloudVideointelligenceV1AnnotateVideoResponse() {
  var o = new api.GoogleCloudVideointelligenceV1AnnotateVideoResponse();
  buildCounterGoogleCloudVideointelligenceV1AnnotateVideoResponse++;
  if (buildCounterGoogleCloudVideointelligenceV1AnnotateVideoResponse < 3) {
    o.annotationResults = buildUnnamed1941();
  }
  buildCounterGoogleCloudVideointelligenceV1AnnotateVideoResponse--;
  return o;
}

checkGoogleCloudVideointelligenceV1AnnotateVideoResponse(
    api.GoogleCloudVideointelligenceV1AnnotateVideoResponse o) {
  buildCounterGoogleCloudVideointelligenceV1AnnotateVideoResponse++;
  if (buildCounterGoogleCloudVideointelligenceV1AnnotateVideoResponse < 3) {
    checkUnnamed1941(o.annotationResults);
  }
  buildCounterGoogleCloudVideointelligenceV1AnnotateVideoResponse--;
}

core.int buildCounterGoogleCloudVideointelligenceV1Entity = 0;
buildGoogleCloudVideointelligenceV1Entity() {
  var o = new api.GoogleCloudVideointelligenceV1Entity();
  buildCounterGoogleCloudVideointelligenceV1Entity++;
  if (buildCounterGoogleCloudVideointelligenceV1Entity < 3) {
    o.description = "foo";
    o.entityId = "foo";
    o.languageCode = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1Entity--;
  return o;
}

checkGoogleCloudVideointelligenceV1Entity(
    api.GoogleCloudVideointelligenceV1Entity o) {
  buildCounterGoogleCloudVideointelligenceV1Entity++;
  if (buildCounterGoogleCloudVideointelligenceV1Entity < 3) {
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.entityId, unittest.equals('foo'));
    unittest.expect(o.languageCode, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1Entity--;
}

buildUnnamed1942() {
  var o =
      new core.List<api.GoogleCloudVideointelligenceV1ExplicitContentFrame>();
  o.add(buildGoogleCloudVideointelligenceV1ExplicitContentFrame());
  o.add(buildGoogleCloudVideointelligenceV1ExplicitContentFrame());
  return o;
}

checkUnnamed1942(
    core.List<api.GoogleCloudVideointelligenceV1ExplicitContentFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1ExplicitContentFrame(o[0]);
  checkGoogleCloudVideointelligenceV1ExplicitContentFrame(o[1]);
}

core.int buildCounterGoogleCloudVideointelligenceV1ExplicitContentAnnotation =
    0;
buildGoogleCloudVideointelligenceV1ExplicitContentAnnotation() {
  var o = new api.GoogleCloudVideointelligenceV1ExplicitContentAnnotation();
  buildCounterGoogleCloudVideointelligenceV1ExplicitContentAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1ExplicitContentAnnotation < 3) {
    o.frames = buildUnnamed1942();
  }
  buildCounterGoogleCloudVideointelligenceV1ExplicitContentAnnotation--;
  return o;
}

checkGoogleCloudVideointelligenceV1ExplicitContentAnnotation(
    api.GoogleCloudVideointelligenceV1ExplicitContentAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1ExplicitContentAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1ExplicitContentAnnotation < 3) {
    checkUnnamed1942(o.frames);
  }
  buildCounterGoogleCloudVideointelligenceV1ExplicitContentAnnotation--;
}

core.int
    buildCounterGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig =
    0;
buildGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig() {
  var o =
      new api.GoogleCloudVideointelligenceV1ExplicitContentDetectionConfig();
  buildCounterGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig++;
  if (buildCounterGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig <
      3) {
    o.model = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig--;
  return o;
}

checkGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig(
    api.GoogleCloudVideointelligenceV1ExplicitContentDetectionConfig o) {
  buildCounterGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig++;
  if (buildCounterGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig <
      3) {
    unittest.expect(o.model, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig--;
}

core.int buildCounterGoogleCloudVideointelligenceV1ExplicitContentFrame = 0;
buildGoogleCloudVideointelligenceV1ExplicitContentFrame() {
  var o = new api.GoogleCloudVideointelligenceV1ExplicitContentFrame();
  buildCounterGoogleCloudVideointelligenceV1ExplicitContentFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1ExplicitContentFrame < 3) {
    o.pornographyLikelihood = "foo";
    o.timeOffset = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1ExplicitContentFrame--;
  return o;
}

checkGoogleCloudVideointelligenceV1ExplicitContentFrame(
    api.GoogleCloudVideointelligenceV1ExplicitContentFrame o) {
  buildCounterGoogleCloudVideointelligenceV1ExplicitContentFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1ExplicitContentFrame < 3) {
    unittest.expect(o.pornographyLikelihood, unittest.equals('foo'));
    unittest.expect(o.timeOffset, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1ExplicitContentFrame--;
}

buildUnnamed1943() {
  var o = new core.List<api.GoogleCloudVideointelligenceV1Entity>();
  o.add(buildGoogleCloudVideointelligenceV1Entity());
  o.add(buildGoogleCloudVideointelligenceV1Entity());
  return o;
}

checkUnnamed1943(core.List<api.GoogleCloudVideointelligenceV1Entity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1Entity(o[0]);
  checkGoogleCloudVideointelligenceV1Entity(o[1]);
}

buildUnnamed1944() {
  var o = new core.List<api.GoogleCloudVideointelligenceV1LabelFrame>();
  o.add(buildGoogleCloudVideointelligenceV1LabelFrame());
  o.add(buildGoogleCloudVideointelligenceV1LabelFrame());
  return o;
}

checkUnnamed1944(core.List<api.GoogleCloudVideointelligenceV1LabelFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1LabelFrame(o[0]);
  checkGoogleCloudVideointelligenceV1LabelFrame(o[1]);
}

buildUnnamed1945() {
  var o = new core.List<api.GoogleCloudVideointelligenceV1LabelSegment>();
  o.add(buildGoogleCloudVideointelligenceV1LabelSegment());
  o.add(buildGoogleCloudVideointelligenceV1LabelSegment());
  return o;
}

checkUnnamed1945(core.List<api.GoogleCloudVideointelligenceV1LabelSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1LabelSegment(o[0]);
  checkGoogleCloudVideointelligenceV1LabelSegment(o[1]);
}

core.int buildCounterGoogleCloudVideointelligenceV1LabelAnnotation = 0;
buildGoogleCloudVideointelligenceV1LabelAnnotation() {
  var o = new api.GoogleCloudVideointelligenceV1LabelAnnotation();
  buildCounterGoogleCloudVideointelligenceV1LabelAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1LabelAnnotation < 3) {
    o.categoryEntities = buildUnnamed1943();
    o.entity = buildGoogleCloudVideointelligenceV1Entity();
    o.frames = buildUnnamed1944();
    o.segments = buildUnnamed1945();
  }
  buildCounterGoogleCloudVideointelligenceV1LabelAnnotation--;
  return o;
}

checkGoogleCloudVideointelligenceV1LabelAnnotation(
    api.GoogleCloudVideointelligenceV1LabelAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1LabelAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1LabelAnnotation < 3) {
    checkUnnamed1943(o.categoryEntities);
    checkGoogleCloudVideointelligenceV1Entity(o.entity);
    checkUnnamed1944(o.frames);
    checkUnnamed1945(o.segments);
  }
  buildCounterGoogleCloudVideointelligenceV1LabelAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1LabelDetectionConfig = 0;
buildGoogleCloudVideointelligenceV1LabelDetectionConfig() {
  var o = new api.GoogleCloudVideointelligenceV1LabelDetectionConfig();
  buildCounterGoogleCloudVideointelligenceV1LabelDetectionConfig++;
  if (buildCounterGoogleCloudVideointelligenceV1LabelDetectionConfig < 3) {
    o.labelDetectionMode = "foo";
    o.model = "foo";
    o.stationaryCamera = true;
  }
  buildCounterGoogleCloudVideointelligenceV1LabelDetectionConfig--;
  return o;
}

checkGoogleCloudVideointelligenceV1LabelDetectionConfig(
    api.GoogleCloudVideointelligenceV1LabelDetectionConfig o) {
  buildCounterGoogleCloudVideointelligenceV1LabelDetectionConfig++;
  if (buildCounterGoogleCloudVideointelligenceV1LabelDetectionConfig < 3) {
    unittest.expect(o.labelDetectionMode, unittest.equals('foo'));
    unittest.expect(o.model, unittest.equals('foo'));
    unittest.expect(o.stationaryCamera, unittest.isTrue);
  }
  buildCounterGoogleCloudVideointelligenceV1LabelDetectionConfig--;
}

core.int buildCounterGoogleCloudVideointelligenceV1LabelFrame = 0;
buildGoogleCloudVideointelligenceV1LabelFrame() {
  var o = new api.GoogleCloudVideointelligenceV1LabelFrame();
  buildCounterGoogleCloudVideointelligenceV1LabelFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1LabelFrame < 3) {
    o.confidence = 42.0;
    o.timeOffset = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1LabelFrame--;
  return o;
}

checkGoogleCloudVideointelligenceV1LabelFrame(
    api.GoogleCloudVideointelligenceV1LabelFrame o) {
  buildCounterGoogleCloudVideointelligenceV1LabelFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1LabelFrame < 3) {
    unittest.expect(o.confidence, unittest.equals(42.0));
    unittest.expect(o.timeOffset, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1LabelFrame--;
}

core.int buildCounterGoogleCloudVideointelligenceV1LabelSegment = 0;
buildGoogleCloudVideointelligenceV1LabelSegment() {
  var o = new api.GoogleCloudVideointelligenceV1LabelSegment();
  buildCounterGoogleCloudVideointelligenceV1LabelSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1LabelSegment < 3) {
    o.confidence = 42.0;
    o.segment = buildGoogleCloudVideointelligenceV1VideoSegment();
  }
  buildCounterGoogleCloudVideointelligenceV1LabelSegment--;
  return o;
}

checkGoogleCloudVideointelligenceV1LabelSegment(
    api.GoogleCloudVideointelligenceV1LabelSegment o) {
  buildCounterGoogleCloudVideointelligenceV1LabelSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1LabelSegment < 3) {
    unittest.expect(o.confidence, unittest.equals(42.0));
    checkGoogleCloudVideointelligenceV1VideoSegment(o.segment);
  }
  buildCounterGoogleCloudVideointelligenceV1LabelSegment--;
}

core.int buildCounterGoogleCloudVideointelligenceV1ShotChangeDetectionConfig =
    0;
buildGoogleCloudVideointelligenceV1ShotChangeDetectionConfig() {
  var o = new api.GoogleCloudVideointelligenceV1ShotChangeDetectionConfig();
  buildCounterGoogleCloudVideointelligenceV1ShotChangeDetectionConfig++;
  if (buildCounterGoogleCloudVideointelligenceV1ShotChangeDetectionConfig < 3) {
    o.model = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1ShotChangeDetectionConfig--;
  return o;
}

checkGoogleCloudVideointelligenceV1ShotChangeDetectionConfig(
    api.GoogleCloudVideointelligenceV1ShotChangeDetectionConfig o) {
  buildCounterGoogleCloudVideointelligenceV1ShotChangeDetectionConfig++;
  if (buildCounterGoogleCloudVideointelligenceV1ShotChangeDetectionConfig < 3) {
    unittest.expect(o.model, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1ShotChangeDetectionConfig--;
}

buildUnnamed1946() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1946(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterGoogleCloudVideointelligenceV1SpeechContext = 0;
buildGoogleCloudVideointelligenceV1SpeechContext() {
  var o = new api.GoogleCloudVideointelligenceV1SpeechContext();
  buildCounterGoogleCloudVideointelligenceV1SpeechContext++;
  if (buildCounterGoogleCloudVideointelligenceV1SpeechContext < 3) {
    o.phrases = buildUnnamed1946();
  }
  buildCounterGoogleCloudVideointelligenceV1SpeechContext--;
  return o;
}

checkGoogleCloudVideointelligenceV1SpeechContext(
    api.GoogleCloudVideointelligenceV1SpeechContext o) {
  buildCounterGoogleCloudVideointelligenceV1SpeechContext++;
  if (buildCounterGoogleCloudVideointelligenceV1SpeechContext < 3) {
    checkUnnamed1946(o.phrases);
  }
  buildCounterGoogleCloudVideointelligenceV1SpeechContext--;
}

buildUnnamed1947() {
  var o = new core.List<api.GoogleCloudVideointelligenceV1WordInfo>();
  o.add(buildGoogleCloudVideointelligenceV1WordInfo());
  o.add(buildGoogleCloudVideointelligenceV1WordInfo());
  return o;
}

checkUnnamed1947(core.List<api.GoogleCloudVideointelligenceV1WordInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1WordInfo(o[0]);
  checkGoogleCloudVideointelligenceV1WordInfo(o[1]);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1SpeechRecognitionAlternative = 0;
buildGoogleCloudVideointelligenceV1SpeechRecognitionAlternative() {
  var o = new api.GoogleCloudVideointelligenceV1SpeechRecognitionAlternative();
  buildCounterGoogleCloudVideointelligenceV1SpeechRecognitionAlternative++;
  if (buildCounterGoogleCloudVideointelligenceV1SpeechRecognitionAlternative <
      3) {
    o.confidence = 42.0;
    o.transcript = "foo";
    o.words = buildUnnamed1947();
  }
  buildCounterGoogleCloudVideointelligenceV1SpeechRecognitionAlternative--;
  return o;
}

checkGoogleCloudVideointelligenceV1SpeechRecognitionAlternative(
    api.GoogleCloudVideointelligenceV1SpeechRecognitionAlternative o) {
  buildCounterGoogleCloudVideointelligenceV1SpeechRecognitionAlternative++;
  if (buildCounterGoogleCloudVideointelligenceV1SpeechRecognitionAlternative <
      3) {
    unittest.expect(o.confidence, unittest.equals(42.0));
    unittest.expect(o.transcript, unittest.equals('foo'));
    checkUnnamed1947(o.words);
  }
  buildCounterGoogleCloudVideointelligenceV1SpeechRecognitionAlternative--;
}

buildUnnamed1948() {
  var o = new core
      .List<api.GoogleCloudVideointelligenceV1SpeechRecognitionAlternative>();
  o.add(buildGoogleCloudVideointelligenceV1SpeechRecognitionAlternative());
  o.add(buildGoogleCloudVideointelligenceV1SpeechRecognitionAlternative());
  return o;
}

checkUnnamed1948(
    core.List<api.GoogleCloudVideointelligenceV1SpeechRecognitionAlternative>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1SpeechRecognitionAlternative(o[0]);
  checkGoogleCloudVideointelligenceV1SpeechRecognitionAlternative(o[1]);
}

core.int buildCounterGoogleCloudVideointelligenceV1SpeechTranscription = 0;
buildGoogleCloudVideointelligenceV1SpeechTranscription() {
  var o = new api.GoogleCloudVideointelligenceV1SpeechTranscription();
  buildCounterGoogleCloudVideointelligenceV1SpeechTranscription++;
  if (buildCounterGoogleCloudVideointelligenceV1SpeechTranscription < 3) {
    o.alternatives = buildUnnamed1948();
    o.languageCode = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1SpeechTranscription--;
  return o;
}

checkGoogleCloudVideointelligenceV1SpeechTranscription(
    api.GoogleCloudVideointelligenceV1SpeechTranscription o) {
  buildCounterGoogleCloudVideointelligenceV1SpeechTranscription++;
  if (buildCounterGoogleCloudVideointelligenceV1SpeechTranscription < 3) {
    checkUnnamed1948(o.alternatives);
    unittest.expect(o.languageCode, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1SpeechTranscription--;
}

buildUnnamed1949() {
  var o = new core.List<core.int>();
  o.add(42);
  o.add(42);
  return o;
}

checkUnnamed1949(core.List<core.int> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals(42));
  unittest.expect(o[1], unittest.equals(42));
}

buildUnnamed1950() {
  var o = new core.List<api.GoogleCloudVideointelligenceV1SpeechContext>();
  o.add(buildGoogleCloudVideointelligenceV1SpeechContext());
  o.add(buildGoogleCloudVideointelligenceV1SpeechContext());
  return o;
}

checkUnnamed1950(core.List<api.GoogleCloudVideointelligenceV1SpeechContext> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1SpeechContext(o[0]);
  checkGoogleCloudVideointelligenceV1SpeechContext(o[1]);
}

core.int buildCounterGoogleCloudVideointelligenceV1SpeechTranscriptionConfig =
    0;
buildGoogleCloudVideointelligenceV1SpeechTranscriptionConfig() {
  var o = new api.GoogleCloudVideointelligenceV1SpeechTranscriptionConfig();
  buildCounterGoogleCloudVideointelligenceV1SpeechTranscriptionConfig++;
  if (buildCounterGoogleCloudVideointelligenceV1SpeechTranscriptionConfig < 3) {
    o.audioTracks = buildUnnamed1949();
    o.diarizationSpeakerCount = 42;
    o.enableAutomaticPunctuation = true;
    o.enableSpeakerDiarization = true;
    o.enableWordConfidence = true;
    o.filterProfanity = true;
    o.languageCode = "foo";
    o.maxAlternatives = 42;
    o.speechContexts = buildUnnamed1950();
  }
  buildCounterGoogleCloudVideointelligenceV1SpeechTranscriptionConfig--;
  return o;
}

checkGoogleCloudVideointelligenceV1SpeechTranscriptionConfig(
    api.GoogleCloudVideointelligenceV1SpeechTranscriptionConfig o) {
  buildCounterGoogleCloudVideointelligenceV1SpeechTranscriptionConfig++;
  if (buildCounterGoogleCloudVideointelligenceV1SpeechTranscriptionConfig < 3) {
    checkUnnamed1949(o.audioTracks);
    unittest.expect(o.diarizationSpeakerCount, unittest.equals(42));
    unittest.expect(o.enableAutomaticPunctuation, unittest.isTrue);
    unittest.expect(o.enableSpeakerDiarization, unittest.isTrue);
    unittest.expect(o.enableWordConfidence, unittest.isTrue);
    unittest.expect(o.filterProfanity, unittest.isTrue);
    unittest.expect(o.languageCode, unittest.equals('foo'));
    unittest.expect(o.maxAlternatives, unittest.equals(42));
    checkUnnamed1950(o.speechContexts);
  }
  buildCounterGoogleCloudVideointelligenceV1SpeechTranscriptionConfig--;
}

core.int buildCounterGoogleCloudVideointelligenceV1VideoAnnotationProgress = 0;
buildGoogleCloudVideointelligenceV1VideoAnnotationProgress() {
  var o = new api.GoogleCloudVideointelligenceV1VideoAnnotationProgress();
  buildCounterGoogleCloudVideointelligenceV1VideoAnnotationProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1VideoAnnotationProgress < 3) {
    o.inputUri = "foo";
    o.progressPercent = 42;
    o.startTime = "foo";
    o.updateTime = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1VideoAnnotationProgress--;
  return o;
}

checkGoogleCloudVideointelligenceV1VideoAnnotationProgress(
    api.GoogleCloudVideointelligenceV1VideoAnnotationProgress o) {
  buildCounterGoogleCloudVideointelligenceV1VideoAnnotationProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1VideoAnnotationProgress < 3) {
    unittest.expect(o.inputUri, unittest.equals('foo'));
    unittest.expect(o.progressPercent, unittest.equals(42));
    unittest.expect(o.startTime, unittest.equals('foo'));
    unittest.expect(o.updateTime, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1VideoAnnotationProgress--;
}

buildUnnamed1951() {
  var o = new core.List<api.GoogleCloudVideointelligenceV1LabelAnnotation>();
  o.add(buildGoogleCloudVideointelligenceV1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1LabelAnnotation());
  return o;
}

checkUnnamed1951(
    core.List<api.GoogleCloudVideointelligenceV1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1LabelAnnotation(o[0]);
  checkGoogleCloudVideointelligenceV1LabelAnnotation(o[1]);
}

buildUnnamed1952() {
  var o = new core.List<api.GoogleCloudVideointelligenceV1LabelAnnotation>();
  o.add(buildGoogleCloudVideointelligenceV1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1LabelAnnotation());
  return o;
}

checkUnnamed1952(
    core.List<api.GoogleCloudVideointelligenceV1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1LabelAnnotation(o[0]);
  checkGoogleCloudVideointelligenceV1LabelAnnotation(o[1]);
}

buildUnnamed1953() {
  var o = new core.List<api.GoogleCloudVideointelligenceV1VideoSegment>();
  o.add(buildGoogleCloudVideointelligenceV1VideoSegment());
  o.add(buildGoogleCloudVideointelligenceV1VideoSegment());
  return o;
}

checkUnnamed1953(core.List<api.GoogleCloudVideointelligenceV1VideoSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1VideoSegment(o[0]);
  checkGoogleCloudVideointelligenceV1VideoSegment(o[1]);
}

buildUnnamed1954() {
  var o = new core.List<api.GoogleCloudVideointelligenceV1LabelAnnotation>();
  o.add(buildGoogleCloudVideointelligenceV1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1LabelAnnotation());
  return o;
}

checkUnnamed1954(
    core.List<api.GoogleCloudVideointelligenceV1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1LabelAnnotation(o[0]);
  checkGoogleCloudVideointelligenceV1LabelAnnotation(o[1]);
}

buildUnnamed1955() {
  var o =
      new core.List<api.GoogleCloudVideointelligenceV1SpeechTranscription>();
  o.add(buildGoogleCloudVideointelligenceV1SpeechTranscription());
  o.add(buildGoogleCloudVideointelligenceV1SpeechTranscription());
  return o;
}

checkUnnamed1955(
    core.List<api.GoogleCloudVideointelligenceV1SpeechTranscription> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1SpeechTranscription(o[0]);
  checkGoogleCloudVideointelligenceV1SpeechTranscription(o[1]);
}

core.int buildCounterGoogleCloudVideointelligenceV1VideoAnnotationResults = 0;
buildGoogleCloudVideointelligenceV1VideoAnnotationResults() {
  var o = new api.GoogleCloudVideointelligenceV1VideoAnnotationResults();
  buildCounterGoogleCloudVideointelligenceV1VideoAnnotationResults++;
  if (buildCounterGoogleCloudVideointelligenceV1VideoAnnotationResults < 3) {
    o.error = buildGoogleRpcStatus();
    o.explicitAnnotation =
        buildGoogleCloudVideointelligenceV1ExplicitContentAnnotation();
    o.frameLabelAnnotations = buildUnnamed1951();
    o.inputUri = "foo";
    o.segmentLabelAnnotations = buildUnnamed1952();
    o.shotAnnotations = buildUnnamed1953();
    o.shotLabelAnnotations = buildUnnamed1954();
    o.speechTranscriptions = buildUnnamed1955();
  }
  buildCounterGoogleCloudVideointelligenceV1VideoAnnotationResults--;
  return o;
}

checkGoogleCloudVideointelligenceV1VideoAnnotationResults(
    api.GoogleCloudVideointelligenceV1VideoAnnotationResults o) {
  buildCounterGoogleCloudVideointelligenceV1VideoAnnotationResults++;
  if (buildCounterGoogleCloudVideointelligenceV1VideoAnnotationResults < 3) {
    checkGoogleRpcStatus(o.error);
    checkGoogleCloudVideointelligenceV1ExplicitContentAnnotation(
        o.explicitAnnotation);
    checkUnnamed1951(o.frameLabelAnnotations);
    unittest.expect(o.inputUri, unittest.equals('foo'));
    checkUnnamed1952(o.segmentLabelAnnotations);
    checkUnnamed1953(o.shotAnnotations);
    checkUnnamed1954(o.shotLabelAnnotations);
    checkUnnamed1955(o.speechTranscriptions);
  }
  buildCounterGoogleCloudVideointelligenceV1VideoAnnotationResults--;
}

buildUnnamed1956() {
  var o = new core.List<api.GoogleCloudVideointelligenceV1VideoSegment>();
  o.add(buildGoogleCloudVideointelligenceV1VideoSegment());
  o.add(buildGoogleCloudVideointelligenceV1VideoSegment());
  return o;
}

checkUnnamed1956(core.List<api.GoogleCloudVideointelligenceV1VideoSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1VideoSegment(o[0]);
  checkGoogleCloudVideointelligenceV1VideoSegment(o[1]);
}

core.int buildCounterGoogleCloudVideointelligenceV1VideoContext = 0;
buildGoogleCloudVideointelligenceV1VideoContext() {
  var o = new api.GoogleCloudVideointelligenceV1VideoContext();
  buildCounterGoogleCloudVideointelligenceV1VideoContext++;
  if (buildCounterGoogleCloudVideointelligenceV1VideoContext < 3) {
    o.explicitContentDetectionConfig =
        buildGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig();
    o.labelDetectionConfig =
        buildGoogleCloudVideointelligenceV1LabelDetectionConfig();
    o.segments = buildUnnamed1956();
    o.shotChangeDetectionConfig =
        buildGoogleCloudVideointelligenceV1ShotChangeDetectionConfig();
    o.speechTranscriptionConfig =
        buildGoogleCloudVideointelligenceV1SpeechTranscriptionConfig();
  }
  buildCounterGoogleCloudVideointelligenceV1VideoContext--;
  return o;
}

checkGoogleCloudVideointelligenceV1VideoContext(
    api.GoogleCloudVideointelligenceV1VideoContext o) {
  buildCounterGoogleCloudVideointelligenceV1VideoContext++;
  if (buildCounterGoogleCloudVideointelligenceV1VideoContext < 3) {
    checkGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig(
        o.explicitContentDetectionConfig);
    checkGoogleCloudVideointelligenceV1LabelDetectionConfig(
        o.labelDetectionConfig);
    checkUnnamed1956(o.segments);
    checkGoogleCloudVideointelligenceV1ShotChangeDetectionConfig(
        o.shotChangeDetectionConfig);
    checkGoogleCloudVideointelligenceV1SpeechTranscriptionConfig(
        o.speechTranscriptionConfig);
  }
  buildCounterGoogleCloudVideointelligenceV1VideoContext--;
}

core.int buildCounterGoogleCloudVideointelligenceV1VideoSegment = 0;
buildGoogleCloudVideointelligenceV1VideoSegment() {
  var o = new api.GoogleCloudVideointelligenceV1VideoSegment();
  buildCounterGoogleCloudVideointelligenceV1VideoSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1VideoSegment < 3) {
    o.endTimeOffset = "foo";
    o.startTimeOffset = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1VideoSegment--;
  return o;
}

checkGoogleCloudVideointelligenceV1VideoSegment(
    api.GoogleCloudVideointelligenceV1VideoSegment o) {
  buildCounterGoogleCloudVideointelligenceV1VideoSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1VideoSegment < 3) {
    unittest.expect(o.endTimeOffset, unittest.equals('foo'));
    unittest.expect(o.startTimeOffset, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1VideoSegment--;
}

core.int buildCounterGoogleCloudVideointelligenceV1WordInfo = 0;
buildGoogleCloudVideointelligenceV1WordInfo() {
  var o = new api.GoogleCloudVideointelligenceV1WordInfo();
  buildCounterGoogleCloudVideointelligenceV1WordInfo++;
  if (buildCounterGoogleCloudVideointelligenceV1WordInfo < 3) {
    o.confidence = 42.0;
    o.endTime = "foo";
    o.speakerTag = 42;
    o.startTime = "foo";
    o.word = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1WordInfo--;
  return o;
}

checkGoogleCloudVideointelligenceV1WordInfo(
    api.GoogleCloudVideointelligenceV1WordInfo o) {
  buildCounterGoogleCloudVideointelligenceV1WordInfo++;
  if (buildCounterGoogleCloudVideointelligenceV1WordInfo < 3) {
    unittest.expect(o.confidence, unittest.equals(42.0));
    unittest.expect(o.endTime, unittest.equals('foo'));
    unittest.expect(o.speakerTag, unittest.equals(42));
    unittest.expect(o.startTime, unittest.equals('foo'));
    unittest.expect(o.word, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1WordInfo--;
}

buildUnnamed1957() {
  var o = new core
      .List<api.GoogleCloudVideointelligenceV1beta2VideoAnnotationProgress>();
  o.add(buildGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress());
  o.add(buildGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress());
  return o;
}

checkUnnamed1957(
    core.List<api.GoogleCloudVideointelligenceV1beta2VideoAnnotationProgress>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress(o[0]);
  checkGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress(o[1]);
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoProgress =
    0;
buildGoogleCloudVideointelligenceV1beta2AnnotateVideoProgress() {
  var o = new api.GoogleCloudVideointelligenceV1beta2AnnotateVideoProgress();
  buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoProgress <
      3) {
    o.annotationProgress = buildUnnamed1957();
  }
  buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoProgress--;
  return o;
}

checkGoogleCloudVideointelligenceV1beta2AnnotateVideoProgress(
    api.GoogleCloudVideointelligenceV1beta2AnnotateVideoProgress o) {
  buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoProgress <
      3) {
    checkUnnamed1957(o.annotationProgress);
  }
  buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoProgress--;
}

buildUnnamed1958() {
  var o = new core
      .List<api.GoogleCloudVideointelligenceV1beta2VideoAnnotationResults>();
  o.add(buildGoogleCloudVideointelligenceV1beta2VideoAnnotationResults());
  o.add(buildGoogleCloudVideointelligenceV1beta2VideoAnnotationResults());
  return o;
}

checkUnnamed1958(
    core.List<api.GoogleCloudVideointelligenceV1beta2VideoAnnotationResults>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2VideoAnnotationResults(o[0]);
  checkGoogleCloudVideointelligenceV1beta2VideoAnnotationResults(o[1]);
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoResponse =
    0;
buildGoogleCloudVideointelligenceV1beta2AnnotateVideoResponse() {
  var o = new api.GoogleCloudVideointelligenceV1beta2AnnotateVideoResponse();
  buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoResponse++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoResponse <
      3) {
    o.annotationResults = buildUnnamed1958();
  }
  buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoResponse--;
  return o;
}

checkGoogleCloudVideointelligenceV1beta2AnnotateVideoResponse(
    api.GoogleCloudVideointelligenceV1beta2AnnotateVideoResponse o) {
  buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoResponse++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoResponse <
      3) {
    checkUnnamed1958(o.annotationResults);
  }
  buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoResponse--;
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2Entity = 0;
buildGoogleCloudVideointelligenceV1beta2Entity() {
  var o = new api.GoogleCloudVideointelligenceV1beta2Entity();
  buildCounterGoogleCloudVideointelligenceV1beta2Entity++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2Entity < 3) {
    o.description = "foo";
    o.entityId = "foo";
    o.languageCode = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1beta2Entity--;
  return o;
}

checkGoogleCloudVideointelligenceV1beta2Entity(
    api.GoogleCloudVideointelligenceV1beta2Entity o) {
  buildCounterGoogleCloudVideointelligenceV1beta2Entity++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2Entity < 3) {
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.entityId, unittest.equals('foo'));
    unittest.expect(o.languageCode, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1beta2Entity--;
}

buildUnnamed1959() {
  var o = new core
      .List<api.GoogleCloudVideointelligenceV1beta2ExplicitContentFrame>();
  o.add(buildGoogleCloudVideointelligenceV1beta2ExplicitContentFrame());
  o.add(buildGoogleCloudVideointelligenceV1beta2ExplicitContentFrame());
  return o;
}

checkUnnamed1959(
    core.List<api.GoogleCloudVideointelligenceV1beta2ExplicitContentFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2ExplicitContentFrame(o[0]);
  checkGoogleCloudVideointelligenceV1beta2ExplicitContentFrame(o[1]);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation =
    0;
buildGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation() {
  var o =
      new api.GoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation();
  buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation <
      3) {
    o.frames = buildUnnamed1959();
  }
  buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation--;
  return o;
}

checkGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation(
    api.GoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation <
      3) {
    checkUnnamed1959(o.frames);
  }
  buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentFrame =
    0;
buildGoogleCloudVideointelligenceV1beta2ExplicitContentFrame() {
  var o = new api.GoogleCloudVideointelligenceV1beta2ExplicitContentFrame();
  buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentFrame < 3) {
    o.pornographyLikelihood = "foo";
    o.timeOffset = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentFrame--;
  return o;
}

checkGoogleCloudVideointelligenceV1beta2ExplicitContentFrame(
    api.GoogleCloudVideointelligenceV1beta2ExplicitContentFrame o) {
  buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentFrame < 3) {
    unittest.expect(o.pornographyLikelihood, unittest.equals('foo'));
    unittest.expect(o.timeOffset, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentFrame--;
}

buildUnnamed1960() {
  var o = new core.List<api.GoogleCloudVideointelligenceV1beta2Entity>();
  o.add(buildGoogleCloudVideointelligenceV1beta2Entity());
  o.add(buildGoogleCloudVideointelligenceV1beta2Entity());
  return o;
}

checkUnnamed1960(core.List<api.GoogleCloudVideointelligenceV1beta2Entity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2Entity(o[0]);
  checkGoogleCloudVideointelligenceV1beta2Entity(o[1]);
}

buildUnnamed1961() {
  var o = new core.List<api.GoogleCloudVideointelligenceV1beta2LabelFrame>();
  o.add(buildGoogleCloudVideointelligenceV1beta2LabelFrame());
  o.add(buildGoogleCloudVideointelligenceV1beta2LabelFrame());
  return o;
}

checkUnnamed1961(
    core.List<api.GoogleCloudVideointelligenceV1beta2LabelFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2LabelFrame(o[0]);
  checkGoogleCloudVideointelligenceV1beta2LabelFrame(o[1]);
}

buildUnnamed1962() {
  var o = new core.List<api.GoogleCloudVideointelligenceV1beta2LabelSegment>();
  o.add(buildGoogleCloudVideointelligenceV1beta2LabelSegment());
  o.add(buildGoogleCloudVideointelligenceV1beta2LabelSegment());
  return o;
}

checkUnnamed1962(
    core.List<api.GoogleCloudVideointelligenceV1beta2LabelSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2LabelSegment(o[0]);
  checkGoogleCloudVideointelligenceV1beta2LabelSegment(o[1]);
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2LabelAnnotation = 0;
buildGoogleCloudVideointelligenceV1beta2LabelAnnotation() {
  var o = new api.GoogleCloudVideointelligenceV1beta2LabelAnnotation();
  buildCounterGoogleCloudVideointelligenceV1beta2LabelAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2LabelAnnotation < 3) {
    o.categoryEntities = buildUnnamed1960();
    o.entity = buildGoogleCloudVideointelligenceV1beta2Entity();
    o.frames = buildUnnamed1961();
    o.segments = buildUnnamed1962();
  }
  buildCounterGoogleCloudVideointelligenceV1beta2LabelAnnotation--;
  return o;
}

checkGoogleCloudVideointelligenceV1beta2LabelAnnotation(
    api.GoogleCloudVideointelligenceV1beta2LabelAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1beta2LabelAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2LabelAnnotation < 3) {
    checkUnnamed1960(o.categoryEntities);
    checkGoogleCloudVideointelligenceV1beta2Entity(o.entity);
    checkUnnamed1961(o.frames);
    checkUnnamed1962(o.segments);
  }
  buildCounterGoogleCloudVideointelligenceV1beta2LabelAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2LabelFrame = 0;
buildGoogleCloudVideointelligenceV1beta2LabelFrame() {
  var o = new api.GoogleCloudVideointelligenceV1beta2LabelFrame();
  buildCounterGoogleCloudVideointelligenceV1beta2LabelFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2LabelFrame < 3) {
    o.confidence = 42.0;
    o.timeOffset = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1beta2LabelFrame--;
  return o;
}

checkGoogleCloudVideointelligenceV1beta2LabelFrame(
    api.GoogleCloudVideointelligenceV1beta2LabelFrame o) {
  buildCounterGoogleCloudVideointelligenceV1beta2LabelFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2LabelFrame < 3) {
    unittest.expect(o.confidence, unittest.equals(42.0));
    unittest.expect(o.timeOffset, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1beta2LabelFrame--;
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2LabelSegment = 0;
buildGoogleCloudVideointelligenceV1beta2LabelSegment() {
  var o = new api.GoogleCloudVideointelligenceV1beta2LabelSegment();
  buildCounterGoogleCloudVideointelligenceV1beta2LabelSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2LabelSegment < 3) {
    o.confidence = 42.0;
    o.segment = buildGoogleCloudVideointelligenceV1beta2VideoSegment();
  }
  buildCounterGoogleCloudVideointelligenceV1beta2LabelSegment--;
  return o;
}

checkGoogleCloudVideointelligenceV1beta2LabelSegment(
    api.GoogleCloudVideointelligenceV1beta2LabelSegment o) {
  buildCounterGoogleCloudVideointelligenceV1beta2LabelSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2LabelSegment < 3) {
    unittest.expect(o.confidence, unittest.equals(42.0));
    checkGoogleCloudVideointelligenceV1beta2VideoSegment(o.segment);
  }
  buildCounterGoogleCloudVideointelligenceV1beta2LabelSegment--;
}

buildUnnamed1963() {
  var o = new core.List<api.GoogleCloudVideointelligenceV1beta2WordInfo>();
  o.add(buildGoogleCloudVideointelligenceV1beta2WordInfo());
  o.add(buildGoogleCloudVideointelligenceV1beta2WordInfo());
  return o;
}

checkUnnamed1963(core.List<api.GoogleCloudVideointelligenceV1beta2WordInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2WordInfo(o[0]);
  checkGoogleCloudVideointelligenceV1beta2WordInfo(o[1]);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative =
    0;
buildGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative() {
  var o =
      new api.GoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative();
  buildCounterGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative <
      3) {
    o.confidence = 42.0;
    o.transcript = "foo";
    o.words = buildUnnamed1963();
  }
  buildCounterGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative--;
  return o;
}

checkGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative(
    api.GoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative o) {
  buildCounterGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative <
      3) {
    unittest.expect(o.confidence, unittest.equals(42.0));
    unittest.expect(o.transcript, unittest.equals('foo'));
    checkUnnamed1963(o.words);
  }
  buildCounterGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative--;
}

buildUnnamed1964() {
  var o = new core.List<
      api.GoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative>();
  o.add(buildGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative());
  o.add(buildGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative());
  return o;
}

checkUnnamed1964(
    core.List<
            api.GoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative(o[0]);
  checkGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative(o[1]);
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2SpeechTranscription = 0;
buildGoogleCloudVideointelligenceV1beta2SpeechTranscription() {
  var o = new api.GoogleCloudVideointelligenceV1beta2SpeechTranscription();
  buildCounterGoogleCloudVideointelligenceV1beta2SpeechTranscription++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2SpeechTranscription < 3) {
    o.alternatives = buildUnnamed1964();
    o.languageCode = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1beta2SpeechTranscription--;
  return o;
}

checkGoogleCloudVideointelligenceV1beta2SpeechTranscription(
    api.GoogleCloudVideointelligenceV1beta2SpeechTranscription o) {
  buildCounterGoogleCloudVideointelligenceV1beta2SpeechTranscription++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2SpeechTranscription < 3) {
    checkUnnamed1964(o.alternatives);
    unittest.expect(o.languageCode, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1beta2SpeechTranscription--;
}

core.int
    buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress = 0;
buildGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress() {
  var o = new api.GoogleCloudVideointelligenceV1beta2VideoAnnotationProgress();
  buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress <
      3) {
    o.inputUri = "foo";
    o.progressPercent = 42;
    o.startTime = "foo";
    o.updateTime = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress--;
  return o;
}

checkGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress(
    api.GoogleCloudVideointelligenceV1beta2VideoAnnotationProgress o) {
  buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress <
      3) {
    unittest.expect(o.inputUri, unittest.equals('foo'));
    unittest.expect(o.progressPercent, unittest.equals(42));
    unittest.expect(o.startTime, unittest.equals('foo'));
    unittest.expect(o.updateTime, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress--;
}

buildUnnamed1965() {
  var o =
      new core.List<api.GoogleCloudVideointelligenceV1beta2LabelAnnotation>();
  o.add(buildGoogleCloudVideointelligenceV1beta2LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1beta2LabelAnnotation());
  return o;
}

checkUnnamed1965(
    core.List<api.GoogleCloudVideointelligenceV1beta2LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2LabelAnnotation(o[0]);
  checkGoogleCloudVideointelligenceV1beta2LabelAnnotation(o[1]);
}

buildUnnamed1966() {
  var o =
      new core.List<api.GoogleCloudVideointelligenceV1beta2LabelAnnotation>();
  o.add(buildGoogleCloudVideointelligenceV1beta2LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1beta2LabelAnnotation());
  return o;
}

checkUnnamed1966(
    core.List<api.GoogleCloudVideointelligenceV1beta2LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2LabelAnnotation(o[0]);
  checkGoogleCloudVideointelligenceV1beta2LabelAnnotation(o[1]);
}

buildUnnamed1967() {
  var o = new core.List<api.GoogleCloudVideointelligenceV1beta2VideoSegment>();
  o.add(buildGoogleCloudVideointelligenceV1beta2VideoSegment());
  o.add(buildGoogleCloudVideointelligenceV1beta2VideoSegment());
  return o;
}

checkUnnamed1967(
    core.List<api.GoogleCloudVideointelligenceV1beta2VideoSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2VideoSegment(o[0]);
  checkGoogleCloudVideointelligenceV1beta2VideoSegment(o[1]);
}

buildUnnamed1968() {
  var o =
      new core.List<api.GoogleCloudVideointelligenceV1beta2LabelAnnotation>();
  o.add(buildGoogleCloudVideointelligenceV1beta2LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1beta2LabelAnnotation());
  return o;
}

checkUnnamed1968(
    core.List<api.GoogleCloudVideointelligenceV1beta2LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2LabelAnnotation(o[0]);
  checkGoogleCloudVideointelligenceV1beta2LabelAnnotation(o[1]);
}

buildUnnamed1969() {
  var o = new core
      .List<api.GoogleCloudVideointelligenceV1beta2SpeechTranscription>();
  o.add(buildGoogleCloudVideointelligenceV1beta2SpeechTranscription());
  o.add(buildGoogleCloudVideointelligenceV1beta2SpeechTranscription());
  return o;
}

checkUnnamed1969(
    core.List<api.GoogleCloudVideointelligenceV1beta2SpeechTranscription> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2SpeechTranscription(o[0]);
  checkGoogleCloudVideointelligenceV1beta2SpeechTranscription(o[1]);
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationResults =
    0;
buildGoogleCloudVideointelligenceV1beta2VideoAnnotationResults() {
  var o = new api.GoogleCloudVideointelligenceV1beta2VideoAnnotationResults();
  buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationResults++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationResults <
      3) {
    o.error = buildGoogleRpcStatus();
    o.explicitAnnotation =
        buildGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation();
    o.frameLabelAnnotations = buildUnnamed1965();
    o.inputUri = "foo";
    o.segmentLabelAnnotations = buildUnnamed1966();
    o.shotAnnotations = buildUnnamed1967();
    o.shotLabelAnnotations = buildUnnamed1968();
    o.speechTranscriptions = buildUnnamed1969();
  }
  buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationResults--;
  return o;
}

checkGoogleCloudVideointelligenceV1beta2VideoAnnotationResults(
    api.GoogleCloudVideointelligenceV1beta2VideoAnnotationResults o) {
  buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationResults++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationResults <
      3) {
    checkGoogleRpcStatus(o.error);
    checkGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation(
        o.explicitAnnotation);
    checkUnnamed1965(o.frameLabelAnnotations);
    unittest.expect(o.inputUri, unittest.equals('foo'));
    checkUnnamed1966(o.segmentLabelAnnotations);
    checkUnnamed1967(o.shotAnnotations);
    checkUnnamed1968(o.shotLabelAnnotations);
    checkUnnamed1969(o.speechTranscriptions);
  }
  buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationResults--;
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2VideoSegment = 0;
buildGoogleCloudVideointelligenceV1beta2VideoSegment() {
  var o = new api.GoogleCloudVideointelligenceV1beta2VideoSegment();
  buildCounterGoogleCloudVideointelligenceV1beta2VideoSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2VideoSegment < 3) {
    o.endTimeOffset = "foo";
    o.startTimeOffset = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1beta2VideoSegment--;
  return o;
}

checkGoogleCloudVideointelligenceV1beta2VideoSegment(
    api.GoogleCloudVideointelligenceV1beta2VideoSegment o) {
  buildCounterGoogleCloudVideointelligenceV1beta2VideoSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2VideoSegment < 3) {
    unittest.expect(o.endTimeOffset, unittest.equals('foo'));
    unittest.expect(o.startTimeOffset, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1beta2VideoSegment--;
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2WordInfo = 0;
buildGoogleCloudVideointelligenceV1beta2WordInfo() {
  var o = new api.GoogleCloudVideointelligenceV1beta2WordInfo();
  buildCounterGoogleCloudVideointelligenceV1beta2WordInfo++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2WordInfo < 3) {
    o.confidence = 42.0;
    o.endTime = "foo";
    o.speakerTag = 42;
    o.startTime = "foo";
    o.word = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1beta2WordInfo--;
  return o;
}

checkGoogleCloudVideointelligenceV1beta2WordInfo(
    api.GoogleCloudVideointelligenceV1beta2WordInfo o) {
  buildCounterGoogleCloudVideointelligenceV1beta2WordInfo++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2WordInfo < 3) {
    unittest.expect(o.confidence, unittest.equals(42.0));
    unittest.expect(o.endTime, unittest.equals('foo'));
    unittest.expect(o.speakerTag, unittest.equals(42));
    unittest.expect(o.startTime, unittest.equals('foo'));
    unittest.expect(o.word, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1beta2WordInfo--;
}

buildUnnamed1970() {
  var o = new core
      .List<api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress>();
  o.add(buildGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress());
  return o;
}

checkUnnamed1970(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress(o[0]);
  checkGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress(o[1]);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress = 0;
buildGoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress() {
  var o = new api.GoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress();
  buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress <
      3) {
    o.annotationProgress = buildUnnamed1970();
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress--;
  return o;
}

checkGoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress(
    api.GoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress <
      3) {
    checkUnnamed1970(o.annotationProgress);
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress--;
}

buildUnnamed1971() {
  var o = new core
      .List<api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults>();
  o.add(buildGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults());
  return o;
}

checkUnnamed1971(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults(o[0]);
  checkGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults(o[1]);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse = 0;
buildGoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse() {
  var o = new api.GoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse();
  buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse <
      3) {
    o.annotationResults = buildUnnamed1971();
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse--;
  return o;
}

checkGoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse(
    api.GoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse <
      3) {
    checkUnnamed1971(o.annotationResults);
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1Entity = 0;
buildGoogleCloudVideointelligenceV1p1beta1Entity() {
  var o = new api.GoogleCloudVideointelligenceV1p1beta1Entity();
  buildCounterGoogleCloudVideointelligenceV1p1beta1Entity++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1Entity < 3) {
    o.description = "foo";
    o.entityId = "foo";
    o.languageCode = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1Entity--;
  return o;
}

checkGoogleCloudVideointelligenceV1p1beta1Entity(
    api.GoogleCloudVideointelligenceV1p1beta1Entity o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1Entity++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1Entity < 3) {
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.entityId, unittest.equals('foo'));
    unittest.expect(o.languageCode, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1Entity--;
}

buildUnnamed1972() {
  var o = new core
      .List<api.GoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame>();
  o.add(buildGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame());
  return o;
}

checkUnnamed1972(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame(o[0]);
  checkGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame(o[1]);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation =
    0;
buildGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation() {
  var o =
      new api.GoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation <
      3) {
    o.frames = buildUnnamed1972();
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation--;
  return o;
}

checkGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation(
    api.GoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation <
      3) {
    checkUnnamed1972(o.frames);
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame =
    0;
buildGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame() {
  var o = new api.GoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame();
  buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame <
      3) {
    o.pornographyLikelihood = "foo";
    o.timeOffset = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame--;
  return o;
}

checkGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame(
    api.GoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame <
      3) {
    unittest.expect(o.pornographyLikelihood, unittest.equals('foo'));
    unittest.expect(o.timeOffset, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame--;
}

buildUnnamed1973() {
  var o = new core.List<api.GoogleCloudVideointelligenceV1p1beta1Entity>();
  o.add(buildGoogleCloudVideointelligenceV1p1beta1Entity());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1Entity());
  return o;
}

checkUnnamed1973(core.List<api.GoogleCloudVideointelligenceV1p1beta1Entity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1Entity(o[0]);
  checkGoogleCloudVideointelligenceV1p1beta1Entity(o[1]);
}

buildUnnamed1974() {
  var o = new core.List<api.GoogleCloudVideointelligenceV1p1beta1LabelFrame>();
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LabelFrame());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LabelFrame());
  return o;
}

checkUnnamed1974(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1LabelFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1LabelFrame(o[0]);
  checkGoogleCloudVideointelligenceV1p1beta1LabelFrame(o[1]);
}

buildUnnamed1975() {
  var o =
      new core.List<api.GoogleCloudVideointelligenceV1p1beta1LabelSegment>();
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LabelSegment());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LabelSegment());
  return o;
}

checkUnnamed1975(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1LabelSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1LabelSegment(o[0]);
  checkGoogleCloudVideointelligenceV1p1beta1LabelSegment(o[1]);
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1LabelAnnotation = 0;
buildGoogleCloudVideointelligenceV1p1beta1LabelAnnotation() {
  var o = new api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p1beta1LabelAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1LabelAnnotation < 3) {
    o.categoryEntities = buildUnnamed1973();
    o.entity = buildGoogleCloudVideointelligenceV1p1beta1Entity();
    o.frames = buildUnnamed1974();
    o.segments = buildUnnamed1975();
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1LabelAnnotation--;
  return o;
}

checkGoogleCloudVideointelligenceV1p1beta1LabelAnnotation(
    api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1LabelAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1LabelAnnotation < 3) {
    checkUnnamed1973(o.categoryEntities);
    checkGoogleCloudVideointelligenceV1p1beta1Entity(o.entity);
    checkUnnamed1974(o.frames);
    checkUnnamed1975(o.segments);
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1LabelAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1LabelFrame = 0;
buildGoogleCloudVideointelligenceV1p1beta1LabelFrame() {
  var o = new api.GoogleCloudVideointelligenceV1p1beta1LabelFrame();
  buildCounterGoogleCloudVideointelligenceV1p1beta1LabelFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1LabelFrame < 3) {
    o.confidence = 42.0;
    o.timeOffset = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1LabelFrame--;
  return o;
}

checkGoogleCloudVideointelligenceV1p1beta1LabelFrame(
    api.GoogleCloudVideointelligenceV1p1beta1LabelFrame o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1LabelFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1LabelFrame < 3) {
    unittest.expect(o.confidence, unittest.equals(42.0));
    unittest.expect(o.timeOffset, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1LabelFrame--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1LabelSegment = 0;
buildGoogleCloudVideointelligenceV1p1beta1LabelSegment() {
  var o = new api.GoogleCloudVideointelligenceV1p1beta1LabelSegment();
  buildCounterGoogleCloudVideointelligenceV1p1beta1LabelSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1LabelSegment < 3) {
    o.confidence = 42.0;
    o.segment = buildGoogleCloudVideointelligenceV1p1beta1VideoSegment();
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1LabelSegment--;
  return o;
}

checkGoogleCloudVideointelligenceV1p1beta1LabelSegment(
    api.GoogleCloudVideointelligenceV1p1beta1LabelSegment o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1LabelSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1LabelSegment < 3) {
    unittest.expect(o.confidence, unittest.equals(42.0));
    checkGoogleCloudVideointelligenceV1p1beta1VideoSegment(o.segment);
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1LabelSegment--;
}

buildUnnamed1976() {
  var o = new core.List<api.GoogleCloudVideointelligenceV1p1beta1WordInfo>();
  o.add(buildGoogleCloudVideointelligenceV1p1beta1WordInfo());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1WordInfo());
  return o;
}

checkUnnamed1976(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1WordInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1WordInfo(o[0]);
  checkGoogleCloudVideointelligenceV1p1beta1WordInfo(o[1]);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative =
    0;
buildGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative() {
  var o = new api
      .GoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative();
  buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative <
      3) {
    o.confidence = 42.0;
    o.transcript = "foo";
    o.words = buildUnnamed1976();
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative--;
  return o;
}

checkGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative(
    api.GoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative <
      3) {
    unittest.expect(o.confidence, unittest.equals(42.0));
    unittest.expect(o.transcript, unittest.equals('foo'));
    checkUnnamed1976(o.words);
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative--;
}

buildUnnamed1977() {
  var o = new core.List<
      api.GoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative>();
  o.add(
      buildGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative());
  o.add(
      buildGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative());
  return o;
}

checkUnnamed1977(
    core.List<
            api.GoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative(o[0]);
  checkGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative(o[1]);
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechTranscription =
    0;
buildGoogleCloudVideointelligenceV1p1beta1SpeechTranscription() {
  var o = new api.GoogleCloudVideointelligenceV1p1beta1SpeechTranscription();
  buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechTranscription++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechTranscription <
      3) {
    o.alternatives = buildUnnamed1977();
    o.languageCode = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechTranscription--;
  return o;
}

checkGoogleCloudVideointelligenceV1p1beta1SpeechTranscription(
    api.GoogleCloudVideointelligenceV1p1beta1SpeechTranscription o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechTranscription++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechTranscription <
      3) {
    checkUnnamed1977(o.alternatives);
    unittest.expect(o.languageCode, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechTranscription--;
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress =
    0;
buildGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress() {
  var o =
      new api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress();
  buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress <
      3) {
    o.inputUri = "foo";
    o.progressPercent = 42;
    o.startTime = "foo";
    o.updateTime = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress--;
  return o;
}

checkGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress(
    api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress <
      3) {
    unittest.expect(o.inputUri, unittest.equals('foo'));
    unittest.expect(o.progressPercent, unittest.equals(42));
    unittest.expect(o.startTime, unittest.equals('foo'));
    unittest.expect(o.updateTime, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress--;
}

buildUnnamed1978() {
  var o =
      new core.List<api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation>();
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LabelAnnotation());
  return o;
}

checkUnnamed1978(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1LabelAnnotation(o[0]);
  checkGoogleCloudVideointelligenceV1p1beta1LabelAnnotation(o[1]);
}

buildUnnamed1979() {
  var o =
      new core.List<api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation>();
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LabelAnnotation());
  return o;
}

checkUnnamed1979(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1LabelAnnotation(o[0]);
  checkGoogleCloudVideointelligenceV1p1beta1LabelAnnotation(o[1]);
}

buildUnnamed1980() {
  var o =
      new core.List<api.GoogleCloudVideointelligenceV1p1beta1VideoSegment>();
  o.add(buildGoogleCloudVideointelligenceV1p1beta1VideoSegment());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1VideoSegment());
  return o;
}

checkUnnamed1980(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1VideoSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1VideoSegment(o[0]);
  checkGoogleCloudVideointelligenceV1p1beta1VideoSegment(o[1]);
}

buildUnnamed1981() {
  var o =
      new core.List<api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation>();
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LabelAnnotation());
  return o;
}

checkUnnamed1981(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1LabelAnnotation(o[0]);
  checkGoogleCloudVideointelligenceV1p1beta1LabelAnnotation(o[1]);
}

buildUnnamed1982() {
  var o = new core
      .List<api.GoogleCloudVideointelligenceV1p1beta1SpeechTranscription>();
  o.add(buildGoogleCloudVideointelligenceV1p1beta1SpeechTranscription());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1SpeechTranscription());
  return o;
}

checkUnnamed1982(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1SpeechTranscription> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1SpeechTranscription(o[0]);
  checkGoogleCloudVideointelligenceV1p1beta1SpeechTranscription(o[1]);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults = 0;
buildGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults() {
  var o = new api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults();
  buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults <
      3) {
    o.error = buildGoogleRpcStatus();
    o.explicitAnnotation =
        buildGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation();
    o.frameLabelAnnotations = buildUnnamed1978();
    o.inputUri = "foo";
    o.segmentLabelAnnotations = buildUnnamed1979();
    o.shotAnnotations = buildUnnamed1980();
    o.shotLabelAnnotations = buildUnnamed1981();
    o.speechTranscriptions = buildUnnamed1982();
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults--;
  return o;
}

checkGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults(
    api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults <
      3) {
    checkGoogleRpcStatus(o.error);
    checkGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation(
        o.explicitAnnotation);
    checkUnnamed1978(o.frameLabelAnnotations);
    unittest.expect(o.inputUri, unittest.equals('foo'));
    checkUnnamed1979(o.segmentLabelAnnotations);
    checkUnnamed1980(o.shotAnnotations);
    checkUnnamed1981(o.shotLabelAnnotations);
    checkUnnamed1982(o.speechTranscriptions);
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1VideoSegment = 0;
buildGoogleCloudVideointelligenceV1p1beta1VideoSegment() {
  var o = new api.GoogleCloudVideointelligenceV1p1beta1VideoSegment();
  buildCounterGoogleCloudVideointelligenceV1p1beta1VideoSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1VideoSegment < 3) {
    o.endTimeOffset = "foo";
    o.startTimeOffset = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1VideoSegment--;
  return o;
}

checkGoogleCloudVideointelligenceV1p1beta1VideoSegment(
    api.GoogleCloudVideointelligenceV1p1beta1VideoSegment o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1VideoSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1VideoSegment < 3) {
    unittest.expect(o.endTimeOffset, unittest.equals('foo'));
    unittest.expect(o.startTimeOffset, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1VideoSegment--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1WordInfo = 0;
buildGoogleCloudVideointelligenceV1p1beta1WordInfo() {
  var o = new api.GoogleCloudVideointelligenceV1p1beta1WordInfo();
  buildCounterGoogleCloudVideointelligenceV1p1beta1WordInfo++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1WordInfo < 3) {
    o.confidence = 42.0;
    o.endTime = "foo";
    o.speakerTag = 42;
    o.startTime = "foo";
    o.word = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1WordInfo--;
  return o;
}

checkGoogleCloudVideointelligenceV1p1beta1WordInfo(
    api.GoogleCloudVideointelligenceV1p1beta1WordInfo o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1WordInfo++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1WordInfo < 3) {
    unittest.expect(o.confidence, unittest.equals(42.0));
    unittest.expect(o.endTime, unittest.equals('foo'));
    unittest.expect(o.speakerTag, unittest.equals(42));
    unittest.expect(o.startTime, unittest.equals('foo'));
    unittest.expect(o.word, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1WordInfo--;
}

buildUnnamed1983() {
  var o = new core
      .List<api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress>();
  o.add(buildGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress());
  return o;
}

checkUnnamed1983(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress(o[0]);
  checkGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress(o[1]);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress = 0;
buildGoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress() {
  var o = new api.GoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress();
  buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress <
      3) {
    o.annotationProgress = buildUnnamed1983();
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress--;
  return o;
}

checkGoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress(
    api.GoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress <
      3) {
    checkUnnamed1983(o.annotationProgress);
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress--;
}

buildUnnamed1984() {
  var o = new core
      .List<api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults>();
  o.add(buildGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults());
  return o;
}

checkUnnamed1984(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults(o[0]);
  checkGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults(o[1]);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse = 0;
buildGoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse() {
  var o = new api.GoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse();
  buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse <
      3) {
    o.annotationResults = buildUnnamed1984();
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse--;
  return o;
}

checkGoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse(
    api.GoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse <
      3) {
    checkUnnamed1984(o.annotationResults);
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1Entity = 0;
buildGoogleCloudVideointelligenceV1p2beta1Entity() {
  var o = new api.GoogleCloudVideointelligenceV1p2beta1Entity();
  buildCounterGoogleCloudVideointelligenceV1p2beta1Entity++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1Entity < 3) {
    o.description = "foo";
    o.entityId = "foo";
    o.languageCode = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1Entity--;
  return o;
}

checkGoogleCloudVideointelligenceV1p2beta1Entity(
    api.GoogleCloudVideointelligenceV1p2beta1Entity o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1Entity++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1Entity < 3) {
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.entityId, unittest.equals('foo'));
    unittest.expect(o.languageCode, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1Entity--;
}

buildUnnamed1985() {
  var o = new core
      .List<api.GoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame>();
  o.add(buildGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame());
  return o;
}

checkUnnamed1985(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame(o[0]);
  checkGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame(o[1]);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation =
    0;
buildGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation() {
  var o =
      new api.GoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation <
      3) {
    o.frames = buildUnnamed1985();
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation--;
  return o;
}

checkGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation(
    api.GoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation <
      3) {
    checkUnnamed1985(o.frames);
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame =
    0;
buildGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame() {
  var o = new api.GoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame();
  buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame <
      3) {
    o.pornographyLikelihood = "foo";
    o.timeOffset = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame--;
  return o;
}

checkGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame(
    api.GoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame <
      3) {
    unittest.expect(o.pornographyLikelihood, unittest.equals('foo'));
    unittest.expect(o.timeOffset, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame--;
}

buildUnnamed1986() {
  var o = new core.List<api.GoogleCloudVideointelligenceV1p2beta1Entity>();
  o.add(buildGoogleCloudVideointelligenceV1p2beta1Entity());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1Entity());
  return o;
}

checkUnnamed1986(core.List<api.GoogleCloudVideointelligenceV1p2beta1Entity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1Entity(o[0]);
  checkGoogleCloudVideointelligenceV1p2beta1Entity(o[1]);
}

buildUnnamed1987() {
  var o = new core.List<api.GoogleCloudVideointelligenceV1p2beta1LabelFrame>();
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LabelFrame());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LabelFrame());
  return o;
}

checkUnnamed1987(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1LabelFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1LabelFrame(o[0]);
  checkGoogleCloudVideointelligenceV1p2beta1LabelFrame(o[1]);
}

buildUnnamed1988() {
  var o =
      new core.List<api.GoogleCloudVideointelligenceV1p2beta1LabelSegment>();
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LabelSegment());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LabelSegment());
  return o;
}

checkUnnamed1988(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1LabelSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1LabelSegment(o[0]);
  checkGoogleCloudVideointelligenceV1p2beta1LabelSegment(o[1]);
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1LabelAnnotation = 0;
buildGoogleCloudVideointelligenceV1p2beta1LabelAnnotation() {
  var o = new api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p2beta1LabelAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1LabelAnnotation < 3) {
    o.categoryEntities = buildUnnamed1986();
    o.entity = buildGoogleCloudVideointelligenceV1p2beta1Entity();
    o.frames = buildUnnamed1987();
    o.segments = buildUnnamed1988();
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1LabelAnnotation--;
  return o;
}

checkGoogleCloudVideointelligenceV1p2beta1LabelAnnotation(
    api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1LabelAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1LabelAnnotation < 3) {
    checkUnnamed1986(o.categoryEntities);
    checkGoogleCloudVideointelligenceV1p2beta1Entity(o.entity);
    checkUnnamed1987(o.frames);
    checkUnnamed1988(o.segments);
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1LabelAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1LabelFrame = 0;
buildGoogleCloudVideointelligenceV1p2beta1LabelFrame() {
  var o = new api.GoogleCloudVideointelligenceV1p2beta1LabelFrame();
  buildCounterGoogleCloudVideointelligenceV1p2beta1LabelFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1LabelFrame < 3) {
    o.confidence = 42.0;
    o.timeOffset = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1LabelFrame--;
  return o;
}

checkGoogleCloudVideointelligenceV1p2beta1LabelFrame(
    api.GoogleCloudVideointelligenceV1p2beta1LabelFrame o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1LabelFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1LabelFrame < 3) {
    unittest.expect(o.confidence, unittest.equals(42.0));
    unittest.expect(o.timeOffset, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1LabelFrame--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1LabelSegment = 0;
buildGoogleCloudVideointelligenceV1p2beta1LabelSegment() {
  var o = new api.GoogleCloudVideointelligenceV1p2beta1LabelSegment();
  buildCounterGoogleCloudVideointelligenceV1p2beta1LabelSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1LabelSegment < 3) {
    o.confidence = 42.0;
    o.segment = buildGoogleCloudVideointelligenceV1p2beta1VideoSegment();
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1LabelSegment--;
  return o;
}

checkGoogleCloudVideointelligenceV1p2beta1LabelSegment(
    api.GoogleCloudVideointelligenceV1p2beta1LabelSegment o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1LabelSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1LabelSegment < 3) {
    unittest.expect(o.confidence, unittest.equals(42.0));
    checkGoogleCloudVideointelligenceV1p2beta1VideoSegment(o.segment);
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1LabelSegment--;
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox = 0;
buildGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox() {
  var o = new api.GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox();
  buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox <
      3) {
    o.bottom = 42.0;
    o.left = 42.0;
    o.right = 42.0;
    o.top = 42.0;
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox--;
  return o;
}

checkGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox(
    api.GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox <
      3) {
    unittest.expect(o.bottom, unittest.equals(42.0));
    unittest.expect(o.left, unittest.equals(42.0));
    unittest.expect(o.right, unittest.equals(42.0));
    unittest.expect(o.top, unittest.equals(42.0));
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox--;
}

buildUnnamed1989() {
  var o = new core
      .List<api.GoogleCloudVideointelligenceV1p2beta1NormalizedVertex>();
  o.add(buildGoogleCloudVideointelligenceV1p2beta1NormalizedVertex());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1NormalizedVertex());
  return o;
}

checkUnnamed1989(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1NormalizedVertex> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1NormalizedVertex(o[0]);
  checkGoogleCloudVideointelligenceV1p2beta1NormalizedVertex(o[1]);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly = 0;
buildGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly() {
  var o = new api.GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly();
  buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly <
      3) {
    o.vertices = buildUnnamed1989();
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly--;
  return o;
}

checkGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly(
    api.GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly <
      3) {
    checkUnnamed1989(o.vertices);
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedVertex = 0;
buildGoogleCloudVideointelligenceV1p2beta1NormalizedVertex() {
  var o = new api.GoogleCloudVideointelligenceV1p2beta1NormalizedVertex();
  buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedVertex++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedVertex < 3) {
    o.x = 42.0;
    o.y = 42.0;
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedVertex--;
  return o;
}

checkGoogleCloudVideointelligenceV1p2beta1NormalizedVertex(
    api.GoogleCloudVideointelligenceV1p2beta1NormalizedVertex o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedVertex++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedVertex < 3) {
    unittest.expect(o.x, unittest.equals(42.0));
    unittest.expect(o.y, unittest.equals(42.0));
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedVertex--;
}

buildUnnamed1990() {
  var o = new core
      .List<api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame>();
  o.add(buildGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame());
  return o;
}

checkUnnamed1990(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame(o[0]);
  checkGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame(o[1]);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation =
    0;
buildGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation() {
  var o =
      new api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation <
      3) {
    o.confidence = 42.0;
    o.entity = buildGoogleCloudVideointelligenceV1p2beta1Entity();
    o.frames = buildUnnamed1990();
    o.segment = buildGoogleCloudVideointelligenceV1p2beta1VideoSegment();
    o.trackId = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation--;
  return o;
}

checkGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation(
    api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation <
      3) {
    unittest.expect(o.confidence, unittest.equals(42.0));
    checkGoogleCloudVideointelligenceV1p2beta1Entity(o.entity);
    checkUnnamed1990(o.frames);
    checkGoogleCloudVideointelligenceV1p2beta1VideoSegment(o.segment);
    unittest.expect(o.trackId, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame =
    0;
buildGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame() {
  var o = new api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame();
  buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame <
      3) {
    o.normalizedBoundingBox =
        buildGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox();
    o.timeOffset = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame--;
  return o;
}

checkGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame(
    api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame <
      3) {
    checkGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox(
        o.normalizedBoundingBox);
    unittest.expect(o.timeOffset, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame--;
}

buildUnnamed1991() {
  var o = new core.List<api.GoogleCloudVideointelligenceV1p2beta1WordInfo>();
  o.add(buildGoogleCloudVideointelligenceV1p2beta1WordInfo());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1WordInfo());
  return o;
}

checkUnnamed1991(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1WordInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1WordInfo(o[0]);
  checkGoogleCloudVideointelligenceV1p2beta1WordInfo(o[1]);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative =
    0;
buildGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative() {
  var o = new api
      .GoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative();
  buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative <
      3) {
    o.confidence = 42.0;
    o.transcript = "foo";
    o.words = buildUnnamed1991();
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative--;
  return o;
}

checkGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative(
    api.GoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative <
      3) {
    unittest.expect(o.confidence, unittest.equals(42.0));
    unittest.expect(o.transcript, unittest.equals('foo'));
    checkUnnamed1991(o.words);
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative--;
}

buildUnnamed1992() {
  var o = new core.List<
      api.GoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative>();
  o.add(
      buildGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative());
  o.add(
      buildGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative());
  return o;
}

checkUnnamed1992(
    core.List<
            api.GoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative(o[0]);
  checkGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative(o[1]);
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechTranscription =
    0;
buildGoogleCloudVideointelligenceV1p2beta1SpeechTranscription() {
  var o = new api.GoogleCloudVideointelligenceV1p2beta1SpeechTranscription();
  buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechTranscription++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechTranscription <
      3) {
    o.alternatives = buildUnnamed1992();
    o.languageCode = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechTranscription--;
  return o;
}

checkGoogleCloudVideointelligenceV1p2beta1SpeechTranscription(
    api.GoogleCloudVideointelligenceV1p2beta1SpeechTranscription o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechTranscription++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechTranscription <
      3) {
    checkUnnamed1992(o.alternatives);
    unittest.expect(o.languageCode, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechTranscription--;
}

buildUnnamed1993() {
  var o = new core.List<api.GoogleCloudVideointelligenceV1p2beta1TextSegment>();
  o.add(buildGoogleCloudVideointelligenceV1p2beta1TextSegment());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1TextSegment());
  return o;
}

checkUnnamed1993(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1TextSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1TextSegment(o[0]);
  checkGoogleCloudVideointelligenceV1p2beta1TextSegment(o[1]);
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1TextAnnotation = 0;
buildGoogleCloudVideointelligenceV1p2beta1TextAnnotation() {
  var o = new api.GoogleCloudVideointelligenceV1p2beta1TextAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p2beta1TextAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1TextAnnotation < 3) {
    o.segments = buildUnnamed1993();
    o.text = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1TextAnnotation--;
  return o;
}

checkGoogleCloudVideointelligenceV1p2beta1TextAnnotation(
    api.GoogleCloudVideointelligenceV1p2beta1TextAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1TextAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1TextAnnotation < 3) {
    checkUnnamed1993(o.segments);
    unittest.expect(o.text, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1TextAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1TextFrame = 0;
buildGoogleCloudVideointelligenceV1p2beta1TextFrame() {
  var o = new api.GoogleCloudVideointelligenceV1p2beta1TextFrame();
  buildCounterGoogleCloudVideointelligenceV1p2beta1TextFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1TextFrame < 3) {
    o.rotatedBoundingBox =
        buildGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly();
    o.timeOffset = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1TextFrame--;
  return o;
}

checkGoogleCloudVideointelligenceV1p2beta1TextFrame(
    api.GoogleCloudVideointelligenceV1p2beta1TextFrame o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1TextFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1TextFrame < 3) {
    checkGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly(
        o.rotatedBoundingBox);
    unittest.expect(o.timeOffset, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1TextFrame--;
}

buildUnnamed1994() {
  var o = new core.List<api.GoogleCloudVideointelligenceV1p2beta1TextFrame>();
  o.add(buildGoogleCloudVideointelligenceV1p2beta1TextFrame());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1TextFrame());
  return o;
}

checkUnnamed1994(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1TextFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1TextFrame(o[0]);
  checkGoogleCloudVideointelligenceV1p2beta1TextFrame(o[1]);
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1TextSegment = 0;
buildGoogleCloudVideointelligenceV1p2beta1TextSegment() {
  var o = new api.GoogleCloudVideointelligenceV1p2beta1TextSegment();
  buildCounterGoogleCloudVideointelligenceV1p2beta1TextSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1TextSegment < 3) {
    o.confidence = 42.0;
    o.frames = buildUnnamed1994();
    o.segment = buildGoogleCloudVideointelligenceV1p2beta1VideoSegment();
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1TextSegment--;
  return o;
}

checkGoogleCloudVideointelligenceV1p2beta1TextSegment(
    api.GoogleCloudVideointelligenceV1p2beta1TextSegment o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1TextSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1TextSegment < 3) {
    unittest.expect(o.confidence, unittest.equals(42.0));
    checkUnnamed1994(o.frames);
    checkGoogleCloudVideointelligenceV1p2beta1VideoSegment(o.segment);
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1TextSegment--;
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress =
    0;
buildGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress() {
  var o =
      new api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress();
  buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress <
      3) {
    o.inputUri = "foo";
    o.progressPercent = 42;
    o.startTime = "foo";
    o.updateTime = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress--;
  return o;
}

checkGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress(
    api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress <
      3) {
    unittest.expect(o.inputUri, unittest.equals('foo'));
    unittest.expect(o.progressPercent, unittest.equals(42));
    unittest.expect(o.startTime, unittest.equals('foo'));
    unittest.expect(o.updateTime, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress--;
}

buildUnnamed1995() {
  var o =
      new core.List<api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation>();
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LabelAnnotation());
  return o;
}

checkUnnamed1995(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1LabelAnnotation(o[0]);
  checkGoogleCloudVideointelligenceV1p2beta1LabelAnnotation(o[1]);
}

buildUnnamed1996() {
  var o = new core.List<
      api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation>();
  o.add(buildGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation());
  return o;
}

checkUnnamed1996(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation(o[0]);
  checkGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation(o[1]);
}

buildUnnamed1997() {
  var o =
      new core.List<api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation>();
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LabelAnnotation());
  return o;
}

checkUnnamed1997(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1LabelAnnotation(o[0]);
  checkGoogleCloudVideointelligenceV1p2beta1LabelAnnotation(o[1]);
}

buildUnnamed1998() {
  var o =
      new core.List<api.GoogleCloudVideointelligenceV1p2beta1VideoSegment>();
  o.add(buildGoogleCloudVideointelligenceV1p2beta1VideoSegment());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1VideoSegment());
  return o;
}

checkUnnamed1998(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1VideoSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1VideoSegment(o[0]);
  checkGoogleCloudVideointelligenceV1p2beta1VideoSegment(o[1]);
}

buildUnnamed1999() {
  var o =
      new core.List<api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation>();
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LabelAnnotation());
  return o;
}

checkUnnamed1999(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1LabelAnnotation(o[0]);
  checkGoogleCloudVideointelligenceV1p2beta1LabelAnnotation(o[1]);
}

buildUnnamed2000() {
  var o = new core
      .List<api.GoogleCloudVideointelligenceV1p2beta1SpeechTranscription>();
  o.add(buildGoogleCloudVideointelligenceV1p2beta1SpeechTranscription());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1SpeechTranscription());
  return o;
}

checkUnnamed2000(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1SpeechTranscription> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1SpeechTranscription(o[0]);
  checkGoogleCloudVideointelligenceV1p2beta1SpeechTranscription(o[1]);
}

buildUnnamed2001() {
  var o =
      new core.List<api.GoogleCloudVideointelligenceV1p2beta1TextAnnotation>();
  o.add(buildGoogleCloudVideointelligenceV1p2beta1TextAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1TextAnnotation());
  return o;
}

checkUnnamed2001(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1TextAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1TextAnnotation(o[0]);
  checkGoogleCloudVideointelligenceV1p2beta1TextAnnotation(o[1]);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults = 0;
buildGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults() {
  var o = new api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults();
  buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults <
      3) {
    o.error = buildGoogleRpcStatus();
    o.explicitAnnotation =
        buildGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation();
    o.frameLabelAnnotations = buildUnnamed1995();
    o.inputUri = "foo";
    o.objectAnnotations = buildUnnamed1996();
    o.segmentLabelAnnotations = buildUnnamed1997();
    o.shotAnnotations = buildUnnamed1998();
    o.shotLabelAnnotations = buildUnnamed1999();
    o.speechTranscriptions = buildUnnamed2000();
    o.textAnnotations = buildUnnamed2001();
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults--;
  return o;
}

checkGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults(
    api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults <
      3) {
    checkGoogleRpcStatus(o.error);
    checkGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation(
        o.explicitAnnotation);
    checkUnnamed1995(o.frameLabelAnnotations);
    unittest.expect(o.inputUri, unittest.equals('foo'));
    checkUnnamed1996(o.objectAnnotations);
    checkUnnamed1997(o.segmentLabelAnnotations);
    checkUnnamed1998(o.shotAnnotations);
    checkUnnamed1999(o.shotLabelAnnotations);
    checkUnnamed2000(o.speechTranscriptions);
    checkUnnamed2001(o.textAnnotations);
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1VideoSegment = 0;
buildGoogleCloudVideointelligenceV1p2beta1VideoSegment() {
  var o = new api.GoogleCloudVideointelligenceV1p2beta1VideoSegment();
  buildCounterGoogleCloudVideointelligenceV1p2beta1VideoSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1VideoSegment < 3) {
    o.endTimeOffset = "foo";
    o.startTimeOffset = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1VideoSegment--;
  return o;
}

checkGoogleCloudVideointelligenceV1p2beta1VideoSegment(
    api.GoogleCloudVideointelligenceV1p2beta1VideoSegment o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1VideoSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1VideoSegment < 3) {
    unittest.expect(o.endTimeOffset, unittest.equals('foo'));
    unittest.expect(o.startTimeOffset, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1VideoSegment--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1WordInfo = 0;
buildGoogleCloudVideointelligenceV1p2beta1WordInfo() {
  var o = new api.GoogleCloudVideointelligenceV1p2beta1WordInfo();
  buildCounterGoogleCloudVideointelligenceV1p2beta1WordInfo++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1WordInfo < 3) {
    o.confidence = 42.0;
    o.endTime = "foo";
    o.speakerTag = 42;
    o.startTime = "foo";
    o.word = "foo";
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1WordInfo--;
  return o;
}

checkGoogleCloudVideointelligenceV1p2beta1WordInfo(
    api.GoogleCloudVideointelligenceV1p2beta1WordInfo o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1WordInfo++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1WordInfo < 3) {
    unittest.expect(o.confidence, unittest.equals(42.0));
    unittest.expect(o.endTime, unittest.equals('foo'));
    unittest.expect(o.speakerTag, unittest.equals(42));
    unittest.expect(o.startTime, unittest.equals('foo'));
    unittest.expect(o.word, unittest.equals('foo'));
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1WordInfo--;
}

core.int buildCounterGoogleLongrunningCancelOperationRequest = 0;
buildGoogleLongrunningCancelOperationRequest() {
  var o = new api.GoogleLongrunningCancelOperationRequest();
  buildCounterGoogleLongrunningCancelOperationRequest++;
  if (buildCounterGoogleLongrunningCancelOperationRequest < 3) {}
  buildCounterGoogleLongrunningCancelOperationRequest--;
  return o;
}

checkGoogleLongrunningCancelOperationRequest(
    api.GoogleLongrunningCancelOperationRequest o) {
  buildCounterGoogleLongrunningCancelOperationRequest++;
  if (buildCounterGoogleLongrunningCancelOperationRequest < 3) {}
  buildCounterGoogleLongrunningCancelOperationRequest--;
}

buildUnnamed2002() {
  var o = new core.List<api.GoogleLongrunningOperation>();
  o.add(buildGoogleLongrunningOperation());
  o.add(buildGoogleLongrunningOperation());
  return o;
}

checkUnnamed2002(core.List<api.GoogleLongrunningOperation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleLongrunningOperation(o[0]);
  checkGoogleLongrunningOperation(o[1]);
}

core.int buildCounterGoogleLongrunningListOperationsResponse = 0;
buildGoogleLongrunningListOperationsResponse() {
  var o = new api.GoogleLongrunningListOperationsResponse();
  buildCounterGoogleLongrunningListOperationsResponse++;
  if (buildCounterGoogleLongrunningListOperationsResponse < 3) {
    o.nextPageToken = "foo";
    o.operations = buildUnnamed2002();
  }
  buildCounterGoogleLongrunningListOperationsResponse--;
  return o;
}

checkGoogleLongrunningListOperationsResponse(
    api.GoogleLongrunningListOperationsResponse o) {
  buildCounterGoogleLongrunningListOperationsResponse++;
  if (buildCounterGoogleLongrunningListOperationsResponse < 3) {
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    checkUnnamed2002(o.operations);
  }
  buildCounterGoogleLongrunningListOperationsResponse--;
}

buildUnnamed2003() {
  var o = new core.Map<core.String, core.Object>();
  o["x"] = {
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  };
  o["y"] = {
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  };
  return o;
}

checkUnnamed2003(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted1 = (o["x"]) as core.Map;
  unittest.expect(casted1, unittest.hasLength(3));
  unittest.expect(casted1["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted1["bool"], unittest.equals(true));
  unittest.expect(casted1["string"], unittest.equals('foo'));
  var casted2 = (o["y"]) as core.Map;
  unittest.expect(casted2, unittest.hasLength(3));
  unittest.expect(casted2["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted2["bool"], unittest.equals(true));
  unittest.expect(casted2["string"], unittest.equals('foo'));
}

buildUnnamed2004() {
  var o = new core.Map<core.String, core.Object>();
  o["x"] = {
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  };
  o["y"] = {
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  };
  return o;
}

checkUnnamed2004(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted3 = (o["x"]) as core.Map;
  unittest.expect(casted3, unittest.hasLength(3));
  unittest.expect(casted3["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted3["bool"], unittest.equals(true));
  unittest.expect(casted3["string"], unittest.equals('foo'));
  var casted4 = (o["y"]) as core.Map;
  unittest.expect(casted4, unittest.hasLength(3));
  unittest.expect(casted4["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted4["bool"], unittest.equals(true));
  unittest.expect(casted4["string"], unittest.equals('foo'));
}

core.int buildCounterGoogleLongrunningOperation = 0;
buildGoogleLongrunningOperation() {
  var o = new api.GoogleLongrunningOperation();
  buildCounterGoogleLongrunningOperation++;
  if (buildCounterGoogleLongrunningOperation < 3) {
    o.done = true;
    o.error = buildGoogleRpcStatus();
    o.metadata = buildUnnamed2003();
    o.name = "foo";
    o.response = buildUnnamed2004();
  }
  buildCounterGoogleLongrunningOperation--;
  return o;
}

checkGoogleLongrunningOperation(api.GoogleLongrunningOperation o) {
  buildCounterGoogleLongrunningOperation++;
  if (buildCounterGoogleLongrunningOperation < 3) {
    unittest.expect(o.done, unittest.isTrue);
    checkGoogleRpcStatus(o.error);
    checkUnnamed2003(o.metadata);
    unittest.expect(o.name, unittest.equals('foo'));
    checkUnnamed2004(o.response);
  }
  buildCounterGoogleLongrunningOperation--;
}

core.int buildCounterGoogleProtobufEmpty = 0;
buildGoogleProtobufEmpty() {
  var o = new api.GoogleProtobufEmpty();
  buildCounterGoogleProtobufEmpty++;
  if (buildCounterGoogleProtobufEmpty < 3) {}
  buildCounterGoogleProtobufEmpty--;
  return o;
}

checkGoogleProtobufEmpty(api.GoogleProtobufEmpty o) {
  buildCounterGoogleProtobufEmpty++;
  if (buildCounterGoogleProtobufEmpty < 3) {}
  buildCounterGoogleProtobufEmpty--;
}

buildUnnamed2005() {
  var o = new core.Map<core.String, core.Object>();
  o["x"] = {
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  };
  o["y"] = {
    'list': [1, 2, 3],
    'bool': true,
    'string': 'foo'
  };
  return o;
}

checkUnnamed2005(core.Map<core.String, core.Object> o) {
  unittest.expect(o, unittest.hasLength(2));
  var casted5 = (o["x"]) as core.Map;
  unittest.expect(casted5, unittest.hasLength(3));
  unittest.expect(casted5["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted5["bool"], unittest.equals(true));
  unittest.expect(casted5["string"], unittest.equals('foo'));
  var casted6 = (o["y"]) as core.Map;
  unittest.expect(casted6, unittest.hasLength(3));
  unittest.expect(casted6["list"], unittest.equals([1, 2, 3]));
  unittest.expect(casted6["bool"], unittest.equals(true));
  unittest.expect(casted6["string"], unittest.equals('foo'));
}

buildUnnamed2006() {
  var o = new core.List<core.Map<core.String, core.Object>>();
  o.add(buildUnnamed2005());
  o.add(buildUnnamed2005());
  return o;
}

checkUnnamed2006(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed2005(o[0]);
  checkUnnamed2005(o[1]);
}

core.int buildCounterGoogleRpcStatus = 0;
buildGoogleRpcStatus() {
  var o = new api.GoogleRpcStatus();
  buildCounterGoogleRpcStatus++;
  if (buildCounterGoogleRpcStatus < 3) {
    o.code = 42;
    o.details = buildUnnamed2006();
    o.message = "foo";
  }
  buildCounterGoogleRpcStatus--;
  return o;
}

checkGoogleRpcStatus(api.GoogleRpcStatus o) {
  buildCounterGoogleRpcStatus++;
  if (buildCounterGoogleRpcStatus < 3) {
    unittest.expect(o.code, unittest.equals(42));
    checkUnnamed2006(o.details);
    unittest.expect(o.message, unittest.equals('foo'));
  }
  buildCounterGoogleRpcStatus--;
}

main() {
  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1AnnotateVideoProgress", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1AnnotateVideoProgress();
      var od =
          new api.GoogleCloudVideointelligenceV1AnnotateVideoProgress.fromJson(
              o.toJson());
      checkGoogleCloudVideointelligenceV1AnnotateVideoProgress(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1AnnotateVideoRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1AnnotateVideoRequest();
      var od =
          new api.GoogleCloudVideointelligenceV1AnnotateVideoRequest.fromJson(
              o.toJson());
      checkGoogleCloudVideointelligenceV1AnnotateVideoRequest(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1AnnotateVideoResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1AnnotateVideoResponse();
      var od =
          new api.GoogleCloudVideointelligenceV1AnnotateVideoResponse.fromJson(
              o.toJson());
      checkGoogleCloudVideointelligenceV1AnnotateVideoResponse(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1Entity", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1Entity();
      var od =
          new api.GoogleCloudVideointelligenceV1Entity.fromJson(o.toJson());
      checkGoogleCloudVideointelligenceV1Entity(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1ExplicitContentAnnotation", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1ExplicitContentAnnotation();
      var od = new api
              .GoogleCloudVideointelligenceV1ExplicitContentAnnotation.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1ExplicitContentAnnotation(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1ExplicitContentDetectionConfig",
      () {
    unittest.test("to-json--from-json", () {
      var o =
          buildGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig();
      var od = new api
              .GoogleCloudVideointelligenceV1ExplicitContentDetectionConfig.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1ExplicitContentFrame", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1ExplicitContentFrame();
      var od =
          new api.GoogleCloudVideointelligenceV1ExplicitContentFrame.fromJson(
              o.toJson());
      checkGoogleCloudVideointelligenceV1ExplicitContentFrame(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1LabelAnnotation",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1LabelAnnotation();
      var od = new api.GoogleCloudVideointelligenceV1LabelAnnotation.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1LabelAnnotation(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1LabelDetectionConfig", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1LabelDetectionConfig();
      var od =
          new api.GoogleCloudVideointelligenceV1LabelDetectionConfig.fromJson(
              o.toJson());
      checkGoogleCloudVideointelligenceV1LabelDetectionConfig(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1LabelFrame", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1LabelFrame();
      var od =
          new api.GoogleCloudVideointelligenceV1LabelFrame.fromJson(o.toJson());
      checkGoogleCloudVideointelligenceV1LabelFrame(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1LabelSegment", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1LabelSegment();
      var od = new api.GoogleCloudVideointelligenceV1LabelSegment.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1LabelSegment(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1ShotChangeDetectionConfig", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1ShotChangeDetectionConfig();
      var od = new api
              .GoogleCloudVideointelligenceV1ShotChangeDetectionConfig.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1ShotChangeDetectionConfig(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1SpeechContext", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1SpeechContext();
      var od = new api.GoogleCloudVideointelligenceV1SpeechContext.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1SpeechContext(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1SpeechRecognitionAlternative",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1SpeechRecognitionAlternative();
      var od = new api
              .GoogleCloudVideointelligenceV1SpeechRecognitionAlternative.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1SpeechRecognitionAlternative(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1SpeechTranscription",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1SpeechTranscription();
      var od =
          new api.GoogleCloudVideointelligenceV1SpeechTranscription.fromJson(
              o.toJson());
      checkGoogleCloudVideointelligenceV1SpeechTranscription(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1SpeechTranscriptionConfig", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1SpeechTranscriptionConfig();
      var od = new api
              .GoogleCloudVideointelligenceV1SpeechTranscriptionConfig.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1SpeechTranscriptionConfig(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1VideoAnnotationProgress", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1VideoAnnotationProgress();
      var od = new api
              .GoogleCloudVideointelligenceV1VideoAnnotationProgress.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1VideoAnnotationProgress(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1VideoAnnotationResults", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1VideoAnnotationResults();
      var od =
          new api.GoogleCloudVideointelligenceV1VideoAnnotationResults.fromJson(
              o.toJson());
      checkGoogleCloudVideointelligenceV1VideoAnnotationResults(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1VideoContext", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1VideoContext();
      var od = new api.GoogleCloudVideointelligenceV1VideoContext.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1VideoContext(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1VideoSegment", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1VideoSegment();
      var od = new api.GoogleCloudVideointelligenceV1VideoSegment.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1VideoSegment(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1WordInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1WordInfo();
      var od =
          new api.GoogleCloudVideointelligenceV1WordInfo.fromJson(o.toJson());
      checkGoogleCloudVideointelligenceV1WordInfo(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1beta2AnnotateVideoProgress",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1beta2AnnotateVideoProgress();
      var od = new api
              .GoogleCloudVideointelligenceV1beta2AnnotateVideoProgress.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1beta2AnnotateVideoProgress(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1beta2AnnotateVideoResponse",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1beta2AnnotateVideoResponse();
      var od = new api
              .GoogleCloudVideointelligenceV1beta2AnnotateVideoResponse.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1beta2AnnotateVideoResponse(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1beta2Entity", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1beta2Entity();
      var od = new api.GoogleCloudVideointelligenceV1beta2Entity.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1beta2Entity(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation",
      () {
    unittest.test("to-json--from-json", () {
      var o =
          buildGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation();
      var od = new api
              .GoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1beta2ExplicitContentFrame", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1beta2ExplicitContentFrame();
      var od = new api
              .GoogleCloudVideointelligenceV1beta2ExplicitContentFrame.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1beta2ExplicitContentFrame(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1beta2LabelAnnotation", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1beta2LabelAnnotation();
      var od =
          new api.GoogleCloudVideointelligenceV1beta2LabelAnnotation.fromJson(
              o.toJson());
      checkGoogleCloudVideointelligenceV1beta2LabelAnnotation(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1beta2LabelFrame",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1beta2LabelFrame();
      var od = new api.GoogleCloudVideointelligenceV1beta2LabelFrame.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1beta2LabelFrame(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1beta2LabelSegment",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1beta2LabelSegment();
      var od = new api.GoogleCloudVideointelligenceV1beta2LabelSegment.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1beta2LabelSegment(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative",
      () {
    unittest.test("to-json--from-json", () {
      var o =
          buildGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative();
      var od = new api
              .GoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1beta2SpeechTranscription", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1beta2SpeechTranscription();
      var od = new api
              .GoogleCloudVideointelligenceV1beta2SpeechTranscription.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1beta2SpeechTranscription(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1beta2VideoAnnotationProgress",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress();
      var od = new api
              .GoogleCloudVideointelligenceV1beta2VideoAnnotationProgress.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1beta2VideoAnnotationResults",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1beta2VideoAnnotationResults();
      var od = new api
              .GoogleCloudVideointelligenceV1beta2VideoAnnotationResults.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1beta2VideoAnnotationResults(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1beta2VideoSegment",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1beta2VideoSegment();
      var od = new api.GoogleCloudVideointelligenceV1beta2VideoSegment.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1beta2VideoSegment(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1beta2WordInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1beta2WordInfo();
      var od = new api.GoogleCloudVideointelligenceV1beta2WordInfo.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1beta2WordInfo(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress();
      var od = new api
              .GoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse();
      var od = new api
              .GoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1p1beta1Entity", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p1beta1Entity();
      var od = new api.GoogleCloudVideointelligenceV1p1beta1Entity.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p1beta1Entity(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation",
      () {
    unittest.test("to-json--from-json", () {
      var o =
          buildGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation();
      var od = new api
              .GoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame();
      var od = new api
              .GoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1p1beta1LabelAnnotation", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p1beta1LabelAnnotation();
      var od =
          new api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation.fromJson(
              o.toJson());
      checkGoogleCloudVideointelligenceV1p1beta1LabelAnnotation(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1p1beta1LabelFrame",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p1beta1LabelFrame();
      var od = new api.GoogleCloudVideointelligenceV1p1beta1LabelFrame.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p1beta1LabelFrame(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1p1beta1LabelSegment",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p1beta1LabelSegment();
      var od =
          new api.GoogleCloudVideointelligenceV1p1beta1LabelSegment.fromJson(
              o.toJson());
      checkGoogleCloudVideointelligenceV1p1beta1LabelSegment(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative",
      () {
    unittest.test("to-json--from-json", () {
      var o =
          buildGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative();
      var od = new api
              .GoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative(
          od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1p1beta1SpeechTranscription",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p1beta1SpeechTranscription();
      var od = new api
              .GoogleCloudVideointelligenceV1p1beta1SpeechTranscription.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p1beta1SpeechTranscription(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress",
      () {
    unittest.test("to-json--from-json", () {
      var o =
          buildGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress();
      var od = new api
              .GoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults",
      () {
    unittest.test("to-json--from-json", () {
      var o =
          buildGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults();
      var od = new api
              .GoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1p1beta1VideoSegment",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p1beta1VideoSegment();
      var od =
          new api.GoogleCloudVideointelligenceV1p1beta1VideoSegment.fromJson(
              o.toJson());
      checkGoogleCloudVideointelligenceV1p1beta1VideoSegment(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1p1beta1WordInfo",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p1beta1WordInfo();
      var od = new api.GoogleCloudVideointelligenceV1p1beta1WordInfo.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p1beta1WordInfo(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress();
      var od = new api
              .GoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse();
      var od = new api
              .GoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1p2beta1Entity", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p2beta1Entity();
      var od = new api.GoogleCloudVideointelligenceV1p2beta1Entity.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p2beta1Entity(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation",
      () {
    unittest.test("to-json--from-json", () {
      var o =
          buildGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation();
      var od = new api
              .GoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame();
      var od = new api
              .GoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1p2beta1LabelAnnotation", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p2beta1LabelAnnotation();
      var od =
          new api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation.fromJson(
              o.toJson());
      checkGoogleCloudVideointelligenceV1p2beta1LabelAnnotation(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1p2beta1LabelFrame",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p2beta1LabelFrame();
      var od = new api.GoogleCloudVideointelligenceV1p2beta1LabelFrame.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p2beta1LabelFrame(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1p2beta1LabelSegment",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p2beta1LabelSegment();
      var od =
          new api.GoogleCloudVideointelligenceV1p2beta1LabelSegment.fromJson(
              o.toJson());
      checkGoogleCloudVideointelligenceV1p2beta1LabelSegment(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox();
      var od = new api
              .GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly",
      () {
    unittest.test("to-json--from-json", () {
      var o =
          buildGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly();
      var od = new api
              .GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1p2beta1NormalizedVertex", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p2beta1NormalizedVertex();
      var od = new api
              .GoogleCloudVideointelligenceV1p2beta1NormalizedVertex.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p2beta1NormalizedVertex(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation",
      () {
    unittest.test("to-json--from-json", () {
      var o =
          buildGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation();
      var od = new api
              .GoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame();
      var od = new api
              .GoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative",
      () {
    unittest.test("to-json--from-json", () {
      var o =
          buildGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative();
      var od = new api
              .GoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative(
          od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1p2beta1SpeechTranscription",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p2beta1SpeechTranscription();
      var od = new api
              .GoogleCloudVideointelligenceV1p2beta1SpeechTranscription.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p2beta1SpeechTranscription(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1p2beta1TextAnnotation", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p2beta1TextAnnotation();
      var od =
          new api.GoogleCloudVideointelligenceV1p2beta1TextAnnotation.fromJson(
              o.toJson());
      checkGoogleCloudVideointelligenceV1p2beta1TextAnnotation(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1p2beta1TextFrame",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p2beta1TextFrame();
      var od = new api.GoogleCloudVideointelligenceV1p2beta1TextFrame.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p2beta1TextFrame(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1p2beta1TextSegment",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p2beta1TextSegment();
      var od =
          new api.GoogleCloudVideointelligenceV1p2beta1TextSegment.fromJson(
              o.toJson());
      checkGoogleCloudVideointelligenceV1p2beta1TextSegment(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress",
      () {
    unittest.test("to-json--from-json", () {
      var o =
          buildGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress();
      var od = new api
              .GoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress(od);
    });
  });

  unittest.group(
      "obj-schema-GoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults",
      () {
    unittest.test("to-json--from-json", () {
      var o =
          buildGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults();
      var od = new api
              .GoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1p2beta1VideoSegment",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p2beta1VideoSegment();
      var od =
          new api.GoogleCloudVideointelligenceV1p2beta1VideoSegment.fromJson(
              o.toJson());
      checkGoogleCloudVideointelligenceV1p2beta1VideoSegment(od);
    });
  });

  unittest.group("obj-schema-GoogleCloudVideointelligenceV1p2beta1WordInfo",
      () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleCloudVideointelligenceV1p2beta1WordInfo();
      var od = new api.GoogleCloudVideointelligenceV1p2beta1WordInfo.fromJson(
          o.toJson());
      checkGoogleCloudVideointelligenceV1p2beta1WordInfo(od);
    });
  });

  unittest.group("obj-schema-GoogleLongrunningCancelOperationRequest", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleLongrunningCancelOperationRequest();
      var od =
          new api.GoogleLongrunningCancelOperationRequest.fromJson(o.toJson());
      checkGoogleLongrunningCancelOperationRequest(od);
    });
  });

  unittest.group("obj-schema-GoogleLongrunningListOperationsResponse", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleLongrunningListOperationsResponse();
      var od =
          new api.GoogleLongrunningListOperationsResponse.fromJson(o.toJson());
      checkGoogleLongrunningListOperationsResponse(od);
    });
  });

  unittest.group("obj-schema-GoogleLongrunningOperation", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleLongrunningOperation();
      var od = new api.GoogleLongrunningOperation.fromJson(o.toJson());
      checkGoogleLongrunningOperation(od);
    });
  });

  unittest.group("obj-schema-GoogleProtobufEmpty", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleProtobufEmpty();
      var od = new api.GoogleProtobufEmpty.fromJson(o.toJson());
      checkGoogleProtobufEmpty(od);
    });
  });

  unittest.group("obj-schema-GoogleRpcStatus", () {
    unittest.test("to-json--from-json", () {
      var o = buildGoogleRpcStatus();
      var od = new api.GoogleRpcStatus.fromJson(o.toJson());
      checkGoogleRpcStatus(od);
    });
  });

  unittest.group("resource-OperationsResourceApi", () {
    unittest.test("method--cancel", () {
      var mock = new HttpServerMock();
      api.OperationsResourceApi res =
          new api.VideointelligenceApi(mock).operations;
      var arg_request = buildGoogleLongrunningCancelOperationRequest();
      var arg_name = "foo";
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj =
            new api.GoogleLongrunningCancelOperationRequest.fromJson(json);
        checkGoogleLongrunningCancelOperationRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 14),
            unittest.equals("v1/operations/"));
        pathOffset += 14;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

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
        var resp = convert.json.encode(buildGoogleProtobufEmpty());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .cancel(arg_request, arg_name, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkGoogleProtobufEmpty(response);
      })));
    });

    unittest.test("method--delete", () {
      var mock = new HttpServerMock();
      api.OperationsResourceApi res =
          new api.VideointelligenceApi(mock).operations;
      var arg_name = "foo";
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
            unittest.equals("v1/operations/"));
        pathOffset += 14;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

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
        var resp = convert.json.encode(buildGoogleProtobufEmpty());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .delete(arg_name, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkGoogleProtobufEmpty(response);
      })));
    });

    unittest.test("method--get", () {
      var mock = new HttpServerMock();
      api.OperationsResourceApi res =
          new api.VideointelligenceApi(mock).operations;
      var arg_name = "foo";
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
            unittest.equals("v1/operations/"));
        pathOffset += 14;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

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
        var resp = convert.json.encode(buildGoogleLongrunningOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .get(arg_name, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkGoogleLongrunningOperation(response);
      })));
    });

    unittest.test("method--list", () {
      var mock = new HttpServerMock();
      api.OperationsResourceApi res =
          new api.VideointelligenceApi(mock).operations;
      var arg_filter = "foo";
      var arg_name = "foo";
      var arg_pageToken = "foo";
      var arg_pageSize = 42;
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
            unittest.equals("v1/operations"));
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
        unittest.expect(queryMap["filter"].first, unittest.equals(arg_filter));
        unittest.expect(queryMap["name"].first, unittest.equals(arg_name));
        unittest.expect(
            queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.int.parse(queryMap["pageSize"].first),
            unittest.equals(arg_pageSize));
        unittest.expect(queryMap["fields"].first, unittest.equals(arg_$fields));

        var h = {
          "content-type": "application/json; charset=utf-8",
        };
        var resp =
            convert.json.encode(buildGoogleLongrunningListOperationsResponse());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .list(
              filter: arg_filter,
              name: arg_name,
              pageToken: arg_pageToken,
              pageSize: arg_pageSize,
              $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkGoogleLongrunningListOperationsResponse(response);
      })));
    });
  });

  unittest.group("resource-VideosResourceApi", () {
    unittest.test("method--annotate", () {
      var mock = new HttpServerMock();
      api.VideosResourceApi res = new api.VideointelligenceApi(mock).videos;
      var arg_request =
          buildGoogleCloudVideointelligenceV1AnnotateVideoRequest();
      var arg_$fields = "foo";
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj =
            new api.GoogleCloudVideointelligenceV1AnnotateVideoRequest.fromJson(
                json);
        checkGoogleCloudVideointelligenceV1AnnotateVideoRequest(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(
            path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 18),
            unittest.equals("v1/videos:annotate"));
        pathOffset += 18;

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
        var resp = convert.json.encode(buildGoogleLongrunningOperation());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res
          .annotate(arg_request, $fields: arg_$fields)
          .then(unittest.expectAsync1(((response) {
        checkGoogleLongrunningOperation(response);
      })));
    });
  });
}
