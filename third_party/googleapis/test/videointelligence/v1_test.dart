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
import 'package:googleapis/videointelligence/v1.dart' as api;

import '../test_shared.dart';

core.List<api.GoogleCloudVideointelligenceV1VideoAnnotationProgress>
    buildUnnamed6441() {
  var o = <api.GoogleCloudVideointelligenceV1VideoAnnotationProgress>[];
  o.add(buildGoogleCloudVideointelligenceV1VideoAnnotationProgress());
  o.add(buildGoogleCloudVideointelligenceV1VideoAnnotationProgress());
  return o;
}

void checkUnnamed6441(
    core.List<api.GoogleCloudVideointelligenceV1VideoAnnotationProgress> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1VideoAnnotationProgress(
      o[0] as api.GoogleCloudVideointelligenceV1VideoAnnotationProgress);
  checkGoogleCloudVideointelligenceV1VideoAnnotationProgress(
      o[1] as api.GoogleCloudVideointelligenceV1VideoAnnotationProgress);
}

core.int buildCounterGoogleCloudVideointelligenceV1AnnotateVideoProgress = 0;
api.GoogleCloudVideointelligenceV1AnnotateVideoProgress
    buildGoogleCloudVideointelligenceV1AnnotateVideoProgress() {
  var o = api.GoogleCloudVideointelligenceV1AnnotateVideoProgress();
  buildCounterGoogleCloudVideointelligenceV1AnnotateVideoProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1AnnotateVideoProgress < 3) {
    o.annotationProgress = buildUnnamed6441();
  }
  buildCounterGoogleCloudVideointelligenceV1AnnotateVideoProgress--;
  return o;
}

void checkGoogleCloudVideointelligenceV1AnnotateVideoProgress(
    api.GoogleCloudVideointelligenceV1AnnotateVideoProgress o) {
  buildCounterGoogleCloudVideointelligenceV1AnnotateVideoProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1AnnotateVideoProgress < 3) {
    checkUnnamed6441(o.annotationProgress!);
  }
  buildCounterGoogleCloudVideointelligenceV1AnnotateVideoProgress--;
}

core.List<core.String> buildUnnamed6442() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed6442(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudVideointelligenceV1AnnotateVideoRequest = 0;
api.GoogleCloudVideointelligenceV1AnnotateVideoRequest
    buildGoogleCloudVideointelligenceV1AnnotateVideoRequest() {
  var o = api.GoogleCloudVideointelligenceV1AnnotateVideoRequest();
  buildCounterGoogleCloudVideointelligenceV1AnnotateVideoRequest++;
  if (buildCounterGoogleCloudVideointelligenceV1AnnotateVideoRequest < 3) {
    o.features = buildUnnamed6442();
    o.inputContent = 'foo';
    o.inputUri = 'foo';
    o.locationId = 'foo';
    o.outputUri = 'foo';
    o.videoContext = buildGoogleCloudVideointelligenceV1VideoContext();
  }
  buildCounterGoogleCloudVideointelligenceV1AnnotateVideoRequest--;
  return o;
}

void checkGoogleCloudVideointelligenceV1AnnotateVideoRequest(
    api.GoogleCloudVideointelligenceV1AnnotateVideoRequest o) {
  buildCounterGoogleCloudVideointelligenceV1AnnotateVideoRequest++;
  if (buildCounterGoogleCloudVideointelligenceV1AnnotateVideoRequest < 3) {
    checkUnnamed6442(o.features!);
    unittest.expect(
      o.inputContent!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.inputUri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.locationId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.outputUri!,
      unittest.equals('foo'),
    );
    checkGoogleCloudVideointelligenceV1VideoContext(
        o.videoContext! as api.GoogleCloudVideointelligenceV1VideoContext);
  }
  buildCounterGoogleCloudVideointelligenceV1AnnotateVideoRequest--;
}

core.List<api.GoogleCloudVideointelligenceV1VideoAnnotationResults>
    buildUnnamed6443() {
  var o = <api.GoogleCloudVideointelligenceV1VideoAnnotationResults>[];
  o.add(buildGoogleCloudVideointelligenceV1VideoAnnotationResults());
  o.add(buildGoogleCloudVideointelligenceV1VideoAnnotationResults());
  return o;
}

void checkUnnamed6443(
    core.List<api.GoogleCloudVideointelligenceV1VideoAnnotationResults> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1VideoAnnotationResults(
      o[0] as api.GoogleCloudVideointelligenceV1VideoAnnotationResults);
  checkGoogleCloudVideointelligenceV1VideoAnnotationResults(
      o[1] as api.GoogleCloudVideointelligenceV1VideoAnnotationResults);
}

core.int buildCounterGoogleCloudVideointelligenceV1AnnotateVideoResponse = 0;
api.GoogleCloudVideointelligenceV1AnnotateVideoResponse
    buildGoogleCloudVideointelligenceV1AnnotateVideoResponse() {
  var o = api.GoogleCloudVideointelligenceV1AnnotateVideoResponse();
  buildCounterGoogleCloudVideointelligenceV1AnnotateVideoResponse++;
  if (buildCounterGoogleCloudVideointelligenceV1AnnotateVideoResponse < 3) {
    o.annotationResults = buildUnnamed6443();
  }
  buildCounterGoogleCloudVideointelligenceV1AnnotateVideoResponse--;
  return o;
}

void checkGoogleCloudVideointelligenceV1AnnotateVideoResponse(
    api.GoogleCloudVideointelligenceV1AnnotateVideoResponse o) {
  buildCounterGoogleCloudVideointelligenceV1AnnotateVideoResponse++;
  if (buildCounterGoogleCloudVideointelligenceV1AnnotateVideoResponse < 3) {
    checkUnnamed6443(o.annotationResults!);
  }
  buildCounterGoogleCloudVideointelligenceV1AnnotateVideoResponse--;
}

core.int buildCounterGoogleCloudVideointelligenceV1DetectedAttribute = 0;
api.GoogleCloudVideointelligenceV1DetectedAttribute
    buildGoogleCloudVideointelligenceV1DetectedAttribute() {
  var o = api.GoogleCloudVideointelligenceV1DetectedAttribute();
  buildCounterGoogleCloudVideointelligenceV1DetectedAttribute++;
  if (buildCounterGoogleCloudVideointelligenceV1DetectedAttribute < 3) {
    o.confidence = 42.0;
    o.name = 'foo';
    o.value = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1DetectedAttribute--;
  return o;
}

void checkGoogleCloudVideointelligenceV1DetectedAttribute(
    api.GoogleCloudVideointelligenceV1DetectedAttribute o) {
  buildCounterGoogleCloudVideointelligenceV1DetectedAttribute++;
  if (buildCounterGoogleCloudVideointelligenceV1DetectedAttribute < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1DetectedAttribute--;
}

core.int buildCounterGoogleCloudVideointelligenceV1DetectedLandmark = 0;
api.GoogleCloudVideointelligenceV1DetectedLandmark
    buildGoogleCloudVideointelligenceV1DetectedLandmark() {
  var o = api.GoogleCloudVideointelligenceV1DetectedLandmark();
  buildCounterGoogleCloudVideointelligenceV1DetectedLandmark++;
  if (buildCounterGoogleCloudVideointelligenceV1DetectedLandmark < 3) {
    o.confidence = 42.0;
    o.name = 'foo';
    o.point = buildGoogleCloudVideointelligenceV1NormalizedVertex();
  }
  buildCounterGoogleCloudVideointelligenceV1DetectedLandmark--;
  return o;
}

void checkGoogleCloudVideointelligenceV1DetectedLandmark(
    api.GoogleCloudVideointelligenceV1DetectedLandmark o) {
  buildCounterGoogleCloudVideointelligenceV1DetectedLandmark++;
  if (buildCounterGoogleCloudVideointelligenceV1DetectedLandmark < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkGoogleCloudVideointelligenceV1NormalizedVertex(
        o.point! as api.GoogleCloudVideointelligenceV1NormalizedVertex);
  }
  buildCounterGoogleCloudVideointelligenceV1DetectedLandmark--;
}

core.int buildCounterGoogleCloudVideointelligenceV1Entity = 0;
api.GoogleCloudVideointelligenceV1Entity
    buildGoogleCloudVideointelligenceV1Entity() {
  var o = api.GoogleCloudVideointelligenceV1Entity();
  buildCounterGoogleCloudVideointelligenceV1Entity++;
  if (buildCounterGoogleCloudVideointelligenceV1Entity < 3) {
    o.description = 'foo';
    o.entityId = 'foo';
    o.languageCode = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1Entity--;
  return o;
}

void checkGoogleCloudVideointelligenceV1Entity(
    api.GoogleCloudVideointelligenceV1Entity o) {
  buildCounterGoogleCloudVideointelligenceV1Entity++;
  if (buildCounterGoogleCloudVideointelligenceV1Entity < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.entityId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1Entity--;
}

core.List<api.GoogleCloudVideointelligenceV1ExplicitContentFrame>
    buildUnnamed6444() {
  var o = <api.GoogleCloudVideointelligenceV1ExplicitContentFrame>[];
  o.add(buildGoogleCloudVideointelligenceV1ExplicitContentFrame());
  o.add(buildGoogleCloudVideointelligenceV1ExplicitContentFrame());
  return o;
}

void checkUnnamed6444(
    core.List<api.GoogleCloudVideointelligenceV1ExplicitContentFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1ExplicitContentFrame(
      o[0] as api.GoogleCloudVideointelligenceV1ExplicitContentFrame);
  checkGoogleCloudVideointelligenceV1ExplicitContentFrame(
      o[1] as api.GoogleCloudVideointelligenceV1ExplicitContentFrame);
}

core.int buildCounterGoogleCloudVideointelligenceV1ExplicitContentAnnotation =
    0;
api.GoogleCloudVideointelligenceV1ExplicitContentAnnotation
    buildGoogleCloudVideointelligenceV1ExplicitContentAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1ExplicitContentAnnotation();
  buildCounterGoogleCloudVideointelligenceV1ExplicitContentAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1ExplicitContentAnnotation < 3) {
    o.frames = buildUnnamed6444();
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1ExplicitContentAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1ExplicitContentAnnotation(
    api.GoogleCloudVideointelligenceV1ExplicitContentAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1ExplicitContentAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1ExplicitContentAnnotation < 3) {
    checkUnnamed6444(o.frames!);
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1ExplicitContentAnnotation--;
}

core.int
    buildCounterGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig =
    0;
api.GoogleCloudVideointelligenceV1ExplicitContentDetectionConfig
    buildGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig() {
  var o = api.GoogleCloudVideointelligenceV1ExplicitContentDetectionConfig();
  buildCounterGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig++;
  if (buildCounterGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig <
      3) {
    o.model = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig--;
  return o;
}

void checkGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig(
    api.GoogleCloudVideointelligenceV1ExplicitContentDetectionConfig o) {
  buildCounterGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig++;
  if (buildCounterGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig <
      3) {
    unittest.expect(
      o.model!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig--;
}

core.int buildCounterGoogleCloudVideointelligenceV1ExplicitContentFrame = 0;
api.GoogleCloudVideointelligenceV1ExplicitContentFrame
    buildGoogleCloudVideointelligenceV1ExplicitContentFrame() {
  var o = api.GoogleCloudVideointelligenceV1ExplicitContentFrame();
  buildCounterGoogleCloudVideointelligenceV1ExplicitContentFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1ExplicitContentFrame < 3) {
    o.pornographyLikelihood = 'foo';
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1ExplicitContentFrame--;
  return o;
}

void checkGoogleCloudVideointelligenceV1ExplicitContentFrame(
    api.GoogleCloudVideointelligenceV1ExplicitContentFrame o) {
  buildCounterGoogleCloudVideointelligenceV1ExplicitContentFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1ExplicitContentFrame < 3) {
    unittest.expect(
      o.pornographyLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1ExplicitContentFrame--;
}

core.List<api.GoogleCloudVideointelligenceV1FaceFrame> buildUnnamed6445() {
  var o = <api.GoogleCloudVideointelligenceV1FaceFrame>[];
  o.add(buildGoogleCloudVideointelligenceV1FaceFrame());
  o.add(buildGoogleCloudVideointelligenceV1FaceFrame());
  return o;
}

void checkUnnamed6445(
    core.List<api.GoogleCloudVideointelligenceV1FaceFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1FaceFrame(
      o[0] as api.GoogleCloudVideointelligenceV1FaceFrame);
  checkGoogleCloudVideointelligenceV1FaceFrame(
      o[1] as api.GoogleCloudVideointelligenceV1FaceFrame);
}

core.List<api.GoogleCloudVideointelligenceV1FaceSegment> buildUnnamed6446() {
  var o = <api.GoogleCloudVideointelligenceV1FaceSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1FaceSegment());
  o.add(buildGoogleCloudVideointelligenceV1FaceSegment());
  return o;
}

void checkUnnamed6446(
    core.List<api.GoogleCloudVideointelligenceV1FaceSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1FaceSegment(
      o[0] as api.GoogleCloudVideointelligenceV1FaceSegment);
  checkGoogleCloudVideointelligenceV1FaceSegment(
      o[1] as api.GoogleCloudVideointelligenceV1FaceSegment);
}

core.int buildCounterGoogleCloudVideointelligenceV1FaceAnnotation = 0;
api.GoogleCloudVideointelligenceV1FaceAnnotation
    buildGoogleCloudVideointelligenceV1FaceAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1FaceAnnotation();
  buildCounterGoogleCloudVideointelligenceV1FaceAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1FaceAnnotation < 3) {
    o.frames = buildUnnamed6445();
    o.segments = buildUnnamed6446();
    o.thumbnail = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1FaceAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1FaceAnnotation(
    api.GoogleCloudVideointelligenceV1FaceAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1FaceAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1FaceAnnotation < 3) {
    checkUnnamed6445(o.frames!);
    checkUnnamed6446(o.segments!);
    unittest.expect(
      o.thumbnail!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1FaceAnnotation--;
}

core.List<api.GoogleCloudVideointelligenceV1Track> buildUnnamed6447() {
  var o = <api.GoogleCloudVideointelligenceV1Track>[];
  o.add(buildGoogleCloudVideointelligenceV1Track());
  o.add(buildGoogleCloudVideointelligenceV1Track());
  return o;
}

void checkUnnamed6447(core.List<api.GoogleCloudVideointelligenceV1Track> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1Track(
      o[0] as api.GoogleCloudVideointelligenceV1Track);
  checkGoogleCloudVideointelligenceV1Track(
      o[1] as api.GoogleCloudVideointelligenceV1Track);
}

core.int buildCounterGoogleCloudVideointelligenceV1FaceDetectionAnnotation = 0;
api.GoogleCloudVideointelligenceV1FaceDetectionAnnotation
    buildGoogleCloudVideointelligenceV1FaceDetectionAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1FaceDetectionAnnotation();
  buildCounterGoogleCloudVideointelligenceV1FaceDetectionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1FaceDetectionAnnotation < 3) {
    o.thumbnail = 'foo';
    o.tracks = buildUnnamed6447();
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1FaceDetectionAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1FaceDetectionAnnotation(
    api.GoogleCloudVideointelligenceV1FaceDetectionAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1FaceDetectionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1FaceDetectionAnnotation < 3) {
    unittest.expect(
      o.thumbnail!,
      unittest.equals('foo'),
    );
    checkUnnamed6447(o.tracks!);
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1FaceDetectionAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1FaceDetectionConfig = 0;
api.GoogleCloudVideointelligenceV1FaceDetectionConfig
    buildGoogleCloudVideointelligenceV1FaceDetectionConfig() {
  var o = api.GoogleCloudVideointelligenceV1FaceDetectionConfig();
  buildCounterGoogleCloudVideointelligenceV1FaceDetectionConfig++;
  if (buildCounterGoogleCloudVideointelligenceV1FaceDetectionConfig < 3) {
    o.includeAttributes = true;
    o.includeBoundingBoxes = true;
    o.model = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1FaceDetectionConfig--;
  return o;
}

void checkGoogleCloudVideointelligenceV1FaceDetectionConfig(
    api.GoogleCloudVideointelligenceV1FaceDetectionConfig o) {
  buildCounterGoogleCloudVideointelligenceV1FaceDetectionConfig++;
  if (buildCounterGoogleCloudVideointelligenceV1FaceDetectionConfig < 3) {
    unittest.expect(o.includeAttributes!, unittest.isTrue);
    unittest.expect(o.includeBoundingBoxes!, unittest.isTrue);
    unittest.expect(
      o.model!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1FaceDetectionConfig--;
}

core.List<api.GoogleCloudVideointelligenceV1NormalizedBoundingBox>
    buildUnnamed6448() {
  var o = <api.GoogleCloudVideointelligenceV1NormalizedBoundingBox>[];
  o.add(buildGoogleCloudVideointelligenceV1NormalizedBoundingBox());
  o.add(buildGoogleCloudVideointelligenceV1NormalizedBoundingBox());
  return o;
}

void checkUnnamed6448(
    core.List<api.GoogleCloudVideointelligenceV1NormalizedBoundingBox> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1NormalizedBoundingBox(
      o[0] as api.GoogleCloudVideointelligenceV1NormalizedBoundingBox);
  checkGoogleCloudVideointelligenceV1NormalizedBoundingBox(
      o[1] as api.GoogleCloudVideointelligenceV1NormalizedBoundingBox);
}

core.int buildCounterGoogleCloudVideointelligenceV1FaceFrame = 0;
api.GoogleCloudVideointelligenceV1FaceFrame
    buildGoogleCloudVideointelligenceV1FaceFrame() {
  var o = api.GoogleCloudVideointelligenceV1FaceFrame();
  buildCounterGoogleCloudVideointelligenceV1FaceFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1FaceFrame < 3) {
    o.normalizedBoundingBoxes = buildUnnamed6448();
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1FaceFrame--;
  return o;
}

void checkGoogleCloudVideointelligenceV1FaceFrame(
    api.GoogleCloudVideointelligenceV1FaceFrame o) {
  buildCounterGoogleCloudVideointelligenceV1FaceFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1FaceFrame < 3) {
    checkUnnamed6448(o.normalizedBoundingBoxes!);
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1FaceFrame--;
}

core.int buildCounterGoogleCloudVideointelligenceV1FaceSegment = 0;
api.GoogleCloudVideointelligenceV1FaceSegment
    buildGoogleCloudVideointelligenceV1FaceSegment() {
  var o = api.GoogleCloudVideointelligenceV1FaceSegment();
  buildCounterGoogleCloudVideointelligenceV1FaceSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1FaceSegment < 3) {
    o.segment = buildGoogleCloudVideointelligenceV1VideoSegment();
  }
  buildCounterGoogleCloudVideointelligenceV1FaceSegment--;
  return o;
}

void checkGoogleCloudVideointelligenceV1FaceSegment(
    api.GoogleCloudVideointelligenceV1FaceSegment o) {
  buildCounterGoogleCloudVideointelligenceV1FaceSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1FaceSegment < 3) {
    checkGoogleCloudVideointelligenceV1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1VideoSegment);
  }
  buildCounterGoogleCloudVideointelligenceV1FaceSegment--;
}

core.List<api.GoogleCloudVideointelligenceV1Entity> buildUnnamed6449() {
  var o = <api.GoogleCloudVideointelligenceV1Entity>[];
  o.add(buildGoogleCloudVideointelligenceV1Entity());
  o.add(buildGoogleCloudVideointelligenceV1Entity());
  return o;
}

void checkUnnamed6449(core.List<api.GoogleCloudVideointelligenceV1Entity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1Entity(
      o[0] as api.GoogleCloudVideointelligenceV1Entity);
  checkGoogleCloudVideointelligenceV1Entity(
      o[1] as api.GoogleCloudVideointelligenceV1Entity);
}

core.List<api.GoogleCloudVideointelligenceV1LabelFrame> buildUnnamed6450() {
  var o = <api.GoogleCloudVideointelligenceV1LabelFrame>[];
  o.add(buildGoogleCloudVideointelligenceV1LabelFrame());
  o.add(buildGoogleCloudVideointelligenceV1LabelFrame());
  return o;
}

void checkUnnamed6450(
    core.List<api.GoogleCloudVideointelligenceV1LabelFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1LabelFrame(
      o[0] as api.GoogleCloudVideointelligenceV1LabelFrame);
  checkGoogleCloudVideointelligenceV1LabelFrame(
      o[1] as api.GoogleCloudVideointelligenceV1LabelFrame);
}

core.List<api.GoogleCloudVideointelligenceV1LabelSegment> buildUnnamed6451() {
  var o = <api.GoogleCloudVideointelligenceV1LabelSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1LabelSegment());
  o.add(buildGoogleCloudVideointelligenceV1LabelSegment());
  return o;
}

void checkUnnamed6451(
    core.List<api.GoogleCloudVideointelligenceV1LabelSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1LabelSegment(
      o[0] as api.GoogleCloudVideointelligenceV1LabelSegment);
  checkGoogleCloudVideointelligenceV1LabelSegment(
      o[1] as api.GoogleCloudVideointelligenceV1LabelSegment);
}

core.int buildCounterGoogleCloudVideointelligenceV1LabelAnnotation = 0;
api.GoogleCloudVideointelligenceV1LabelAnnotation
    buildGoogleCloudVideointelligenceV1LabelAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1LabelAnnotation();
  buildCounterGoogleCloudVideointelligenceV1LabelAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1LabelAnnotation < 3) {
    o.categoryEntities = buildUnnamed6449();
    o.entity = buildGoogleCloudVideointelligenceV1Entity();
    o.frames = buildUnnamed6450();
    o.segments = buildUnnamed6451();
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1LabelAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1LabelAnnotation(
    api.GoogleCloudVideointelligenceV1LabelAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1LabelAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1LabelAnnotation < 3) {
    checkUnnamed6449(o.categoryEntities!);
    checkGoogleCloudVideointelligenceV1Entity(
        o.entity! as api.GoogleCloudVideointelligenceV1Entity);
    checkUnnamed6450(o.frames!);
    checkUnnamed6451(o.segments!);
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1LabelAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1LabelDetectionConfig = 0;
api.GoogleCloudVideointelligenceV1LabelDetectionConfig
    buildGoogleCloudVideointelligenceV1LabelDetectionConfig() {
  var o = api.GoogleCloudVideointelligenceV1LabelDetectionConfig();
  buildCounterGoogleCloudVideointelligenceV1LabelDetectionConfig++;
  if (buildCounterGoogleCloudVideointelligenceV1LabelDetectionConfig < 3) {
    o.frameConfidenceThreshold = 42.0;
    o.labelDetectionMode = 'foo';
    o.model = 'foo';
    o.stationaryCamera = true;
    o.videoConfidenceThreshold = 42.0;
  }
  buildCounterGoogleCloudVideointelligenceV1LabelDetectionConfig--;
  return o;
}

void checkGoogleCloudVideointelligenceV1LabelDetectionConfig(
    api.GoogleCloudVideointelligenceV1LabelDetectionConfig o) {
  buildCounterGoogleCloudVideointelligenceV1LabelDetectionConfig++;
  if (buildCounterGoogleCloudVideointelligenceV1LabelDetectionConfig < 3) {
    unittest.expect(
      o.frameConfidenceThreshold!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.labelDetectionMode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.model!,
      unittest.equals('foo'),
    );
    unittest.expect(o.stationaryCamera!, unittest.isTrue);
    unittest.expect(
      o.videoConfidenceThreshold!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1LabelDetectionConfig--;
}

core.int buildCounterGoogleCloudVideointelligenceV1LabelFrame = 0;
api.GoogleCloudVideointelligenceV1LabelFrame
    buildGoogleCloudVideointelligenceV1LabelFrame() {
  var o = api.GoogleCloudVideointelligenceV1LabelFrame();
  buildCounterGoogleCloudVideointelligenceV1LabelFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1LabelFrame < 3) {
    o.confidence = 42.0;
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1LabelFrame--;
  return o;
}

void checkGoogleCloudVideointelligenceV1LabelFrame(
    api.GoogleCloudVideointelligenceV1LabelFrame o) {
  buildCounterGoogleCloudVideointelligenceV1LabelFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1LabelFrame < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1LabelFrame--;
}

core.int buildCounterGoogleCloudVideointelligenceV1LabelSegment = 0;
api.GoogleCloudVideointelligenceV1LabelSegment
    buildGoogleCloudVideointelligenceV1LabelSegment() {
  var o = api.GoogleCloudVideointelligenceV1LabelSegment();
  buildCounterGoogleCloudVideointelligenceV1LabelSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1LabelSegment < 3) {
    o.confidence = 42.0;
    o.segment = buildGoogleCloudVideointelligenceV1VideoSegment();
  }
  buildCounterGoogleCloudVideointelligenceV1LabelSegment--;
  return o;
}

void checkGoogleCloudVideointelligenceV1LabelSegment(
    api.GoogleCloudVideointelligenceV1LabelSegment o) {
  buildCounterGoogleCloudVideointelligenceV1LabelSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1LabelSegment < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVideointelligenceV1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1VideoSegment);
  }
  buildCounterGoogleCloudVideointelligenceV1LabelSegment--;
}

core.List<api.GoogleCloudVideointelligenceV1VideoSegment> buildUnnamed6452() {
  var o = <api.GoogleCloudVideointelligenceV1VideoSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1VideoSegment());
  o.add(buildGoogleCloudVideointelligenceV1VideoSegment());
  return o;
}

void checkUnnamed6452(
    core.List<api.GoogleCloudVideointelligenceV1VideoSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1VideoSegment(
      o[0] as api.GoogleCloudVideointelligenceV1VideoSegment);
  checkGoogleCloudVideointelligenceV1VideoSegment(
      o[1] as api.GoogleCloudVideointelligenceV1VideoSegment);
}

core.List<api.GoogleCloudVideointelligenceV1Track> buildUnnamed6453() {
  var o = <api.GoogleCloudVideointelligenceV1Track>[];
  o.add(buildGoogleCloudVideointelligenceV1Track());
  o.add(buildGoogleCloudVideointelligenceV1Track());
  return o;
}

void checkUnnamed6453(core.List<api.GoogleCloudVideointelligenceV1Track> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1Track(
      o[0] as api.GoogleCloudVideointelligenceV1Track);
  checkGoogleCloudVideointelligenceV1Track(
      o[1] as api.GoogleCloudVideointelligenceV1Track);
}

core.int buildCounterGoogleCloudVideointelligenceV1LogoRecognitionAnnotation =
    0;
api.GoogleCloudVideointelligenceV1LogoRecognitionAnnotation
    buildGoogleCloudVideointelligenceV1LogoRecognitionAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1LogoRecognitionAnnotation();
  buildCounterGoogleCloudVideointelligenceV1LogoRecognitionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1LogoRecognitionAnnotation < 3) {
    o.entity = buildGoogleCloudVideointelligenceV1Entity();
    o.segments = buildUnnamed6452();
    o.tracks = buildUnnamed6453();
  }
  buildCounterGoogleCloudVideointelligenceV1LogoRecognitionAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1LogoRecognitionAnnotation(
    api.GoogleCloudVideointelligenceV1LogoRecognitionAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1LogoRecognitionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1LogoRecognitionAnnotation < 3) {
    checkGoogleCloudVideointelligenceV1Entity(
        o.entity! as api.GoogleCloudVideointelligenceV1Entity);
    checkUnnamed6452(o.segments!);
    checkUnnamed6453(o.tracks!);
  }
  buildCounterGoogleCloudVideointelligenceV1LogoRecognitionAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1NormalizedBoundingBox = 0;
api.GoogleCloudVideointelligenceV1NormalizedBoundingBox
    buildGoogleCloudVideointelligenceV1NormalizedBoundingBox() {
  var o = api.GoogleCloudVideointelligenceV1NormalizedBoundingBox();
  buildCounterGoogleCloudVideointelligenceV1NormalizedBoundingBox++;
  if (buildCounterGoogleCloudVideointelligenceV1NormalizedBoundingBox < 3) {
    o.bottom = 42.0;
    o.left = 42.0;
    o.right = 42.0;
    o.top = 42.0;
  }
  buildCounterGoogleCloudVideointelligenceV1NormalizedBoundingBox--;
  return o;
}

void checkGoogleCloudVideointelligenceV1NormalizedBoundingBox(
    api.GoogleCloudVideointelligenceV1NormalizedBoundingBox o) {
  buildCounterGoogleCloudVideointelligenceV1NormalizedBoundingBox++;
  if (buildCounterGoogleCloudVideointelligenceV1NormalizedBoundingBox < 3) {
    unittest.expect(
      o.bottom!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.left!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.right!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.top!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1NormalizedBoundingBox--;
}

core.List<api.GoogleCloudVideointelligenceV1NormalizedVertex>
    buildUnnamed6454() {
  var o = <api.GoogleCloudVideointelligenceV1NormalizedVertex>[];
  o.add(buildGoogleCloudVideointelligenceV1NormalizedVertex());
  o.add(buildGoogleCloudVideointelligenceV1NormalizedVertex());
  return o;
}

void checkUnnamed6454(
    core.List<api.GoogleCloudVideointelligenceV1NormalizedVertex> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1NormalizedVertex(
      o[0] as api.GoogleCloudVideointelligenceV1NormalizedVertex);
  checkGoogleCloudVideointelligenceV1NormalizedVertex(
      o[1] as api.GoogleCloudVideointelligenceV1NormalizedVertex);
}

core.int buildCounterGoogleCloudVideointelligenceV1NormalizedBoundingPoly = 0;
api.GoogleCloudVideointelligenceV1NormalizedBoundingPoly
    buildGoogleCloudVideointelligenceV1NormalizedBoundingPoly() {
  var o = api.GoogleCloudVideointelligenceV1NormalizedBoundingPoly();
  buildCounterGoogleCloudVideointelligenceV1NormalizedBoundingPoly++;
  if (buildCounterGoogleCloudVideointelligenceV1NormalizedBoundingPoly < 3) {
    o.vertices = buildUnnamed6454();
  }
  buildCounterGoogleCloudVideointelligenceV1NormalizedBoundingPoly--;
  return o;
}

void checkGoogleCloudVideointelligenceV1NormalizedBoundingPoly(
    api.GoogleCloudVideointelligenceV1NormalizedBoundingPoly o) {
  buildCounterGoogleCloudVideointelligenceV1NormalizedBoundingPoly++;
  if (buildCounterGoogleCloudVideointelligenceV1NormalizedBoundingPoly < 3) {
    checkUnnamed6454(o.vertices!);
  }
  buildCounterGoogleCloudVideointelligenceV1NormalizedBoundingPoly--;
}

core.int buildCounterGoogleCloudVideointelligenceV1NormalizedVertex = 0;
api.GoogleCloudVideointelligenceV1NormalizedVertex
    buildGoogleCloudVideointelligenceV1NormalizedVertex() {
  var o = api.GoogleCloudVideointelligenceV1NormalizedVertex();
  buildCounterGoogleCloudVideointelligenceV1NormalizedVertex++;
  if (buildCounterGoogleCloudVideointelligenceV1NormalizedVertex < 3) {
    o.x = 42.0;
    o.y = 42.0;
  }
  buildCounterGoogleCloudVideointelligenceV1NormalizedVertex--;
  return o;
}

void checkGoogleCloudVideointelligenceV1NormalizedVertex(
    api.GoogleCloudVideointelligenceV1NormalizedVertex o) {
  buildCounterGoogleCloudVideointelligenceV1NormalizedVertex++;
  if (buildCounterGoogleCloudVideointelligenceV1NormalizedVertex < 3) {
    unittest.expect(
      o.x!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.y!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1NormalizedVertex--;
}

core.List<api.GoogleCloudVideointelligenceV1ObjectTrackingFrame>
    buildUnnamed6455() {
  var o = <api.GoogleCloudVideointelligenceV1ObjectTrackingFrame>[];
  o.add(buildGoogleCloudVideointelligenceV1ObjectTrackingFrame());
  o.add(buildGoogleCloudVideointelligenceV1ObjectTrackingFrame());
  return o;
}

void checkUnnamed6455(
    core.List<api.GoogleCloudVideointelligenceV1ObjectTrackingFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1ObjectTrackingFrame(
      o[0] as api.GoogleCloudVideointelligenceV1ObjectTrackingFrame);
  checkGoogleCloudVideointelligenceV1ObjectTrackingFrame(
      o[1] as api.GoogleCloudVideointelligenceV1ObjectTrackingFrame);
}

core.int buildCounterGoogleCloudVideointelligenceV1ObjectTrackingAnnotation = 0;
api.GoogleCloudVideointelligenceV1ObjectTrackingAnnotation
    buildGoogleCloudVideointelligenceV1ObjectTrackingAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1ObjectTrackingAnnotation();
  buildCounterGoogleCloudVideointelligenceV1ObjectTrackingAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1ObjectTrackingAnnotation < 3) {
    o.confidence = 42.0;
    o.entity = buildGoogleCloudVideointelligenceV1Entity();
    o.frames = buildUnnamed6455();
    o.segment = buildGoogleCloudVideointelligenceV1VideoSegment();
    o.trackId = 'foo';
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1ObjectTrackingAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1ObjectTrackingAnnotation(
    api.GoogleCloudVideointelligenceV1ObjectTrackingAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1ObjectTrackingAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1ObjectTrackingAnnotation < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVideointelligenceV1Entity(
        o.entity! as api.GoogleCloudVideointelligenceV1Entity);
    checkUnnamed6455(o.frames!);
    checkGoogleCloudVideointelligenceV1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1VideoSegment);
    unittest.expect(
      o.trackId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1ObjectTrackingAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1ObjectTrackingConfig = 0;
api.GoogleCloudVideointelligenceV1ObjectTrackingConfig
    buildGoogleCloudVideointelligenceV1ObjectTrackingConfig() {
  var o = api.GoogleCloudVideointelligenceV1ObjectTrackingConfig();
  buildCounterGoogleCloudVideointelligenceV1ObjectTrackingConfig++;
  if (buildCounterGoogleCloudVideointelligenceV1ObjectTrackingConfig < 3) {
    o.model = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1ObjectTrackingConfig--;
  return o;
}

void checkGoogleCloudVideointelligenceV1ObjectTrackingConfig(
    api.GoogleCloudVideointelligenceV1ObjectTrackingConfig o) {
  buildCounterGoogleCloudVideointelligenceV1ObjectTrackingConfig++;
  if (buildCounterGoogleCloudVideointelligenceV1ObjectTrackingConfig < 3) {
    unittest.expect(
      o.model!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1ObjectTrackingConfig--;
}

core.int buildCounterGoogleCloudVideointelligenceV1ObjectTrackingFrame = 0;
api.GoogleCloudVideointelligenceV1ObjectTrackingFrame
    buildGoogleCloudVideointelligenceV1ObjectTrackingFrame() {
  var o = api.GoogleCloudVideointelligenceV1ObjectTrackingFrame();
  buildCounterGoogleCloudVideointelligenceV1ObjectTrackingFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1ObjectTrackingFrame < 3) {
    o.normalizedBoundingBox =
        buildGoogleCloudVideointelligenceV1NormalizedBoundingBox();
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1ObjectTrackingFrame--;
  return o;
}

void checkGoogleCloudVideointelligenceV1ObjectTrackingFrame(
    api.GoogleCloudVideointelligenceV1ObjectTrackingFrame o) {
  buildCounterGoogleCloudVideointelligenceV1ObjectTrackingFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1ObjectTrackingFrame < 3) {
    checkGoogleCloudVideointelligenceV1NormalizedBoundingBox(
        o.normalizedBoundingBox!
            as api.GoogleCloudVideointelligenceV1NormalizedBoundingBox);
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1ObjectTrackingFrame--;
}

core.List<api.GoogleCloudVideointelligenceV1Track> buildUnnamed6456() {
  var o = <api.GoogleCloudVideointelligenceV1Track>[];
  o.add(buildGoogleCloudVideointelligenceV1Track());
  o.add(buildGoogleCloudVideointelligenceV1Track());
  return o;
}

void checkUnnamed6456(core.List<api.GoogleCloudVideointelligenceV1Track> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1Track(
      o[0] as api.GoogleCloudVideointelligenceV1Track);
  checkGoogleCloudVideointelligenceV1Track(
      o[1] as api.GoogleCloudVideointelligenceV1Track);
}

core.int buildCounterGoogleCloudVideointelligenceV1PersonDetectionAnnotation =
    0;
api.GoogleCloudVideointelligenceV1PersonDetectionAnnotation
    buildGoogleCloudVideointelligenceV1PersonDetectionAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1PersonDetectionAnnotation();
  buildCounterGoogleCloudVideointelligenceV1PersonDetectionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1PersonDetectionAnnotation < 3) {
    o.tracks = buildUnnamed6456();
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1PersonDetectionAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1PersonDetectionAnnotation(
    api.GoogleCloudVideointelligenceV1PersonDetectionAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1PersonDetectionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1PersonDetectionAnnotation < 3) {
    checkUnnamed6456(o.tracks!);
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1PersonDetectionAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1PersonDetectionConfig = 0;
api.GoogleCloudVideointelligenceV1PersonDetectionConfig
    buildGoogleCloudVideointelligenceV1PersonDetectionConfig() {
  var o = api.GoogleCloudVideointelligenceV1PersonDetectionConfig();
  buildCounterGoogleCloudVideointelligenceV1PersonDetectionConfig++;
  if (buildCounterGoogleCloudVideointelligenceV1PersonDetectionConfig < 3) {
    o.includeAttributes = true;
    o.includeBoundingBoxes = true;
    o.includePoseLandmarks = true;
  }
  buildCounterGoogleCloudVideointelligenceV1PersonDetectionConfig--;
  return o;
}

void checkGoogleCloudVideointelligenceV1PersonDetectionConfig(
    api.GoogleCloudVideointelligenceV1PersonDetectionConfig o) {
  buildCounterGoogleCloudVideointelligenceV1PersonDetectionConfig++;
  if (buildCounterGoogleCloudVideointelligenceV1PersonDetectionConfig < 3) {
    unittest.expect(o.includeAttributes!, unittest.isTrue);
    unittest.expect(o.includeBoundingBoxes!, unittest.isTrue);
    unittest.expect(o.includePoseLandmarks!, unittest.isTrue);
  }
  buildCounterGoogleCloudVideointelligenceV1PersonDetectionConfig--;
}

core.int buildCounterGoogleCloudVideointelligenceV1ShotChangeDetectionConfig =
    0;
api.GoogleCloudVideointelligenceV1ShotChangeDetectionConfig
    buildGoogleCloudVideointelligenceV1ShotChangeDetectionConfig() {
  var o = api.GoogleCloudVideointelligenceV1ShotChangeDetectionConfig();
  buildCounterGoogleCloudVideointelligenceV1ShotChangeDetectionConfig++;
  if (buildCounterGoogleCloudVideointelligenceV1ShotChangeDetectionConfig < 3) {
    o.model = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1ShotChangeDetectionConfig--;
  return o;
}

void checkGoogleCloudVideointelligenceV1ShotChangeDetectionConfig(
    api.GoogleCloudVideointelligenceV1ShotChangeDetectionConfig o) {
  buildCounterGoogleCloudVideointelligenceV1ShotChangeDetectionConfig++;
  if (buildCounterGoogleCloudVideointelligenceV1ShotChangeDetectionConfig < 3) {
    unittest.expect(
      o.model!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1ShotChangeDetectionConfig--;
}

core.List<core.String> buildUnnamed6457() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed6457(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudVideointelligenceV1SpeechContext = 0;
api.GoogleCloudVideointelligenceV1SpeechContext
    buildGoogleCloudVideointelligenceV1SpeechContext() {
  var o = api.GoogleCloudVideointelligenceV1SpeechContext();
  buildCounterGoogleCloudVideointelligenceV1SpeechContext++;
  if (buildCounterGoogleCloudVideointelligenceV1SpeechContext < 3) {
    o.phrases = buildUnnamed6457();
  }
  buildCounterGoogleCloudVideointelligenceV1SpeechContext--;
  return o;
}

void checkGoogleCloudVideointelligenceV1SpeechContext(
    api.GoogleCloudVideointelligenceV1SpeechContext o) {
  buildCounterGoogleCloudVideointelligenceV1SpeechContext++;
  if (buildCounterGoogleCloudVideointelligenceV1SpeechContext < 3) {
    checkUnnamed6457(o.phrases!);
  }
  buildCounterGoogleCloudVideointelligenceV1SpeechContext--;
}

core.List<api.GoogleCloudVideointelligenceV1WordInfo> buildUnnamed6458() {
  var o = <api.GoogleCloudVideointelligenceV1WordInfo>[];
  o.add(buildGoogleCloudVideointelligenceV1WordInfo());
  o.add(buildGoogleCloudVideointelligenceV1WordInfo());
  return o;
}

void checkUnnamed6458(core.List<api.GoogleCloudVideointelligenceV1WordInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1WordInfo(
      o[0] as api.GoogleCloudVideointelligenceV1WordInfo);
  checkGoogleCloudVideointelligenceV1WordInfo(
      o[1] as api.GoogleCloudVideointelligenceV1WordInfo);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1SpeechRecognitionAlternative = 0;
api.GoogleCloudVideointelligenceV1SpeechRecognitionAlternative
    buildGoogleCloudVideointelligenceV1SpeechRecognitionAlternative() {
  var o = api.GoogleCloudVideointelligenceV1SpeechRecognitionAlternative();
  buildCounterGoogleCloudVideointelligenceV1SpeechRecognitionAlternative++;
  if (buildCounterGoogleCloudVideointelligenceV1SpeechRecognitionAlternative <
      3) {
    o.confidence = 42.0;
    o.transcript = 'foo';
    o.words = buildUnnamed6458();
  }
  buildCounterGoogleCloudVideointelligenceV1SpeechRecognitionAlternative--;
  return o;
}

void checkGoogleCloudVideointelligenceV1SpeechRecognitionAlternative(
    api.GoogleCloudVideointelligenceV1SpeechRecognitionAlternative o) {
  buildCounterGoogleCloudVideointelligenceV1SpeechRecognitionAlternative++;
  if (buildCounterGoogleCloudVideointelligenceV1SpeechRecognitionAlternative <
      3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.transcript!,
      unittest.equals('foo'),
    );
    checkUnnamed6458(o.words!);
  }
  buildCounterGoogleCloudVideointelligenceV1SpeechRecognitionAlternative--;
}

core.List<api.GoogleCloudVideointelligenceV1SpeechRecognitionAlternative>
    buildUnnamed6459() {
  var o = <api.GoogleCloudVideointelligenceV1SpeechRecognitionAlternative>[];
  o.add(buildGoogleCloudVideointelligenceV1SpeechRecognitionAlternative());
  o.add(buildGoogleCloudVideointelligenceV1SpeechRecognitionAlternative());
  return o;
}

void checkUnnamed6459(
    core.List<api.GoogleCloudVideointelligenceV1SpeechRecognitionAlternative>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1SpeechRecognitionAlternative(
      o[0] as api.GoogleCloudVideointelligenceV1SpeechRecognitionAlternative);
  checkGoogleCloudVideointelligenceV1SpeechRecognitionAlternative(
      o[1] as api.GoogleCloudVideointelligenceV1SpeechRecognitionAlternative);
}

core.int buildCounterGoogleCloudVideointelligenceV1SpeechTranscription = 0;
api.GoogleCloudVideointelligenceV1SpeechTranscription
    buildGoogleCloudVideointelligenceV1SpeechTranscription() {
  var o = api.GoogleCloudVideointelligenceV1SpeechTranscription();
  buildCounterGoogleCloudVideointelligenceV1SpeechTranscription++;
  if (buildCounterGoogleCloudVideointelligenceV1SpeechTranscription < 3) {
    o.alternatives = buildUnnamed6459();
    o.languageCode = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1SpeechTranscription--;
  return o;
}

void checkGoogleCloudVideointelligenceV1SpeechTranscription(
    api.GoogleCloudVideointelligenceV1SpeechTranscription o) {
  buildCounterGoogleCloudVideointelligenceV1SpeechTranscription++;
  if (buildCounterGoogleCloudVideointelligenceV1SpeechTranscription < 3) {
    checkUnnamed6459(o.alternatives!);
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1SpeechTranscription--;
}

core.List<core.int> buildUnnamed6460() {
  var o = <core.int>[];
  o.add(42);
  o.add(42);
  return o;
}

void checkUnnamed6460(core.List<core.int> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(
    o[0],
    unittest.equals(42),
  );
  unittest.expect(
    o[1],
    unittest.equals(42),
  );
}

core.List<api.GoogleCloudVideointelligenceV1SpeechContext> buildUnnamed6461() {
  var o = <api.GoogleCloudVideointelligenceV1SpeechContext>[];
  o.add(buildGoogleCloudVideointelligenceV1SpeechContext());
  o.add(buildGoogleCloudVideointelligenceV1SpeechContext());
  return o;
}

void checkUnnamed6461(
    core.List<api.GoogleCloudVideointelligenceV1SpeechContext> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1SpeechContext(
      o[0] as api.GoogleCloudVideointelligenceV1SpeechContext);
  checkGoogleCloudVideointelligenceV1SpeechContext(
      o[1] as api.GoogleCloudVideointelligenceV1SpeechContext);
}

core.int buildCounterGoogleCloudVideointelligenceV1SpeechTranscriptionConfig =
    0;
api.GoogleCloudVideointelligenceV1SpeechTranscriptionConfig
    buildGoogleCloudVideointelligenceV1SpeechTranscriptionConfig() {
  var o = api.GoogleCloudVideointelligenceV1SpeechTranscriptionConfig();
  buildCounterGoogleCloudVideointelligenceV1SpeechTranscriptionConfig++;
  if (buildCounterGoogleCloudVideointelligenceV1SpeechTranscriptionConfig < 3) {
    o.audioTracks = buildUnnamed6460();
    o.diarizationSpeakerCount = 42;
    o.enableAutomaticPunctuation = true;
    o.enableSpeakerDiarization = true;
    o.enableWordConfidence = true;
    o.filterProfanity = true;
    o.languageCode = 'foo';
    o.maxAlternatives = 42;
    o.speechContexts = buildUnnamed6461();
  }
  buildCounterGoogleCloudVideointelligenceV1SpeechTranscriptionConfig--;
  return o;
}

void checkGoogleCloudVideointelligenceV1SpeechTranscriptionConfig(
    api.GoogleCloudVideointelligenceV1SpeechTranscriptionConfig o) {
  buildCounterGoogleCloudVideointelligenceV1SpeechTranscriptionConfig++;
  if (buildCounterGoogleCloudVideointelligenceV1SpeechTranscriptionConfig < 3) {
    checkUnnamed6460(o.audioTracks!);
    unittest.expect(
      o.diarizationSpeakerCount!,
      unittest.equals(42),
    );
    unittest.expect(o.enableAutomaticPunctuation!, unittest.isTrue);
    unittest.expect(o.enableSpeakerDiarization!, unittest.isTrue);
    unittest.expect(o.enableWordConfidence!, unittest.isTrue);
    unittest.expect(o.filterProfanity!, unittest.isTrue);
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.maxAlternatives!,
      unittest.equals(42),
    );
    checkUnnamed6461(o.speechContexts!);
  }
  buildCounterGoogleCloudVideointelligenceV1SpeechTranscriptionConfig--;
}

core.List<api.GoogleCloudVideointelligenceV1TextSegment> buildUnnamed6462() {
  var o = <api.GoogleCloudVideointelligenceV1TextSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1TextSegment());
  o.add(buildGoogleCloudVideointelligenceV1TextSegment());
  return o;
}

void checkUnnamed6462(
    core.List<api.GoogleCloudVideointelligenceV1TextSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1TextSegment(
      o[0] as api.GoogleCloudVideointelligenceV1TextSegment);
  checkGoogleCloudVideointelligenceV1TextSegment(
      o[1] as api.GoogleCloudVideointelligenceV1TextSegment);
}

core.int buildCounterGoogleCloudVideointelligenceV1TextAnnotation = 0;
api.GoogleCloudVideointelligenceV1TextAnnotation
    buildGoogleCloudVideointelligenceV1TextAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1TextAnnotation();
  buildCounterGoogleCloudVideointelligenceV1TextAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1TextAnnotation < 3) {
    o.segments = buildUnnamed6462();
    o.text = 'foo';
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1TextAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1TextAnnotation(
    api.GoogleCloudVideointelligenceV1TextAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1TextAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1TextAnnotation < 3) {
    checkUnnamed6462(o.segments!);
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1TextAnnotation--;
}

core.List<core.String> buildUnnamed6463() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed6463(core.List<core.String> o) {
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

core.int buildCounterGoogleCloudVideointelligenceV1TextDetectionConfig = 0;
api.GoogleCloudVideointelligenceV1TextDetectionConfig
    buildGoogleCloudVideointelligenceV1TextDetectionConfig() {
  var o = api.GoogleCloudVideointelligenceV1TextDetectionConfig();
  buildCounterGoogleCloudVideointelligenceV1TextDetectionConfig++;
  if (buildCounterGoogleCloudVideointelligenceV1TextDetectionConfig < 3) {
    o.languageHints = buildUnnamed6463();
    o.model = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1TextDetectionConfig--;
  return o;
}

void checkGoogleCloudVideointelligenceV1TextDetectionConfig(
    api.GoogleCloudVideointelligenceV1TextDetectionConfig o) {
  buildCounterGoogleCloudVideointelligenceV1TextDetectionConfig++;
  if (buildCounterGoogleCloudVideointelligenceV1TextDetectionConfig < 3) {
    checkUnnamed6463(o.languageHints!);
    unittest.expect(
      o.model!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1TextDetectionConfig--;
}

core.int buildCounterGoogleCloudVideointelligenceV1TextFrame = 0;
api.GoogleCloudVideointelligenceV1TextFrame
    buildGoogleCloudVideointelligenceV1TextFrame() {
  var o = api.GoogleCloudVideointelligenceV1TextFrame();
  buildCounterGoogleCloudVideointelligenceV1TextFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1TextFrame < 3) {
    o.rotatedBoundingBox =
        buildGoogleCloudVideointelligenceV1NormalizedBoundingPoly();
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1TextFrame--;
  return o;
}

void checkGoogleCloudVideointelligenceV1TextFrame(
    api.GoogleCloudVideointelligenceV1TextFrame o) {
  buildCounterGoogleCloudVideointelligenceV1TextFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1TextFrame < 3) {
    checkGoogleCloudVideointelligenceV1NormalizedBoundingPoly(
        o.rotatedBoundingBox!
            as api.GoogleCloudVideointelligenceV1NormalizedBoundingPoly);
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1TextFrame--;
}

core.List<api.GoogleCloudVideointelligenceV1TextFrame> buildUnnamed6464() {
  var o = <api.GoogleCloudVideointelligenceV1TextFrame>[];
  o.add(buildGoogleCloudVideointelligenceV1TextFrame());
  o.add(buildGoogleCloudVideointelligenceV1TextFrame());
  return o;
}

void checkUnnamed6464(
    core.List<api.GoogleCloudVideointelligenceV1TextFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1TextFrame(
      o[0] as api.GoogleCloudVideointelligenceV1TextFrame);
  checkGoogleCloudVideointelligenceV1TextFrame(
      o[1] as api.GoogleCloudVideointelligenceV1TextFrame);
}

core.int buildCounterGoogleCloudVideointelligenceV1TextSegment = 0;
api.GoogleCloudVideointelligenceV1TextSegment
    buildGoogleCloudVideointelligenceV1TextSegment() {
  var o = api.GoogleCloudVideointelligenceV1TextSegment();
  buildCounterGoogleCloudVideointelligenceV1TextSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1TextSegment < 3) {
    o.confidence = 42.0;
    o.frames = buildUnnamed6464();
    o.segment = buildGoogleCloudVideointelligenceV1VideoSegment();
  }
  buildCounterGoogleCloudVideointelligenceV1TextSegment--;
  return o;
}

void checkGoogleCloudVideointelligenceV1TextSegment(
    api.GoogleCloudVideointelligenceV1TextSegment o) {
  buildCounterGoogleCloudVideointelligenceV1TextSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1TextSegment < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkUnnamed6464(o.frames!);
    checkGoogleCloudVideointelligenceV1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1VideoSegment);
  }
  buildCounterGoogleCloudVideointelligenceV1TextSegment--;
}

core.List<api.GoogleCloudVideointelligenceV1DetectedAttribute>
    buildUnnamed6465() {
  var o = <api.GoogleCloudVideointelligenceV1DetectedAttribute>[];
  o.add(buildGoogleCloudVideointelligenceV1DetectedAttribute());
  o.add(buildGoogleCloudVideointelligenceV1DetectedAttribute());
  return o;
}

void checkUnnamed6465(
    core.List<api.GoogleCloudVideointelligenceV1DetectedAttribute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1DetectedAttribute(
      o[0] as api.GoogleCloudVideointelligenceV1DetectedAttribute);
  checkGoogleCloudVideointelligenceV1DetectedAttribute(
      o[1] as api.GoogleCloudVideointelligenceV1DetectedAttribute);
}

core.List<api.GoogleCloudVideointelligenceV1DetectedLandmark>
    buildUnnamed6466() {
  var o = <api.GoogleCloudVideointelligenceV1DetectedLandmark>[];
  o.add(buildGoogleCloudVideointelligenceV1DetectedLandmark());
  o.add(buildGoogleCloudVideointelligenceV1DetectedLandmark());
  return o;
}

void checkUnnamed6466(
    core.List<api.GoogleCloudVideointelligenceV1DetectedLandmark> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1DetectedLandmark(
      o[0] as api.GoogleCloudVideointelligenceV1DetectedLandmark);
  checkGoogleCloudVideointelligenceV1DetectedLandmark(
      o[1] as api.GoogleCloudVideointelligenceV1DetectedLandmark);
}

core.int buildCounterGoogleCloudVideointelligenceV1TimestampedObject = 0;
api.GoogleCloudVideointelligenceV1TimestampedObject
    buildGoogleCloudVideointelligenceV1TimestampedObject() {
  var o = api.GoogleCloudVideointelligenceV1TimestampedObject();
  buildCounterGoogleCloudVideointelligenceV1TimestampedObject++;
  if (buildCounterGoogleCloudVideointelligenceV1TimestampedObject < 3) {
    o.attributes = buildUnnamed6465();
    o.landmarks = buildUnnamed6466();
    o.normalizedBoundingBox =
        buildGoogleCloudVideointelligenceV1NormalizedBoundingBox();
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1TimestampedObject--;
  return o;
}

void checkGoogleCloudVideointelligenceV1TimestampedObject(
    api.GoogleCloudVideointelligenceV1TimestampedObject o) {
  buildCounterGoogleCloudVideointelligenceV1TimestampedObject++;
  if (buildCounterGoogleCloudVideointelligenceV1TimestampedObject < 3) {
    checkUnnamed6465(o.attributes!);
    checkUnnamed6466(o.landmarks!);
    checkGoogleCloudVideointelligenceV1NormalizedBoundingBox(
        o.normalizedBoundingBox!
            as api.GoogleCloudVideointelligenceV1NormalizedBoundingBox);
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1TimestampedObject--;
}

core.List<api.GoogleCloudVideointelligenceV1DetectedAttribute>
    buildUnnamed6467() {
  var o = <api.GoogleCloudVideointelligenceV1DetectedAttribute>[];
  o.add(buildGoogleCloudVideointelligenceV1DetectedAttribute());
  o.add(buildGoogleCloudVideointelligenceV1DetectedAttribute());
  return o;
}

void checkUnnamed6467(
    core.List<api.GoogleCloudVideointelligenceV1DetectedAttribute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1DetectedAttribute(
      o[0] as api.GoogleCloudVideointelligenceV1DetectedAttribute);
  checkGoogleCloudVideointelligenceV1DetectedAttribute(
      o[1] as api.GoogleCloudVideointelligenceV1DetectedAttribute);
}

core.List<api.GoogleCloudVideointelligenceV1TimestampedObject>
    buildUnnamed6468() {
  var o = <api.GoogleCloudVideointelligenceV1TimestampedObject>[];
  o.add(buildGoogleCloudVideointelligenceV1TimestampedObject());
  o.add(buildGoogleCloudVideointelligenceV1TimestampedObject());
  return o;
}

void checkUnnamed6468(
    core.List<api.GoogleCloudVideointelligenceV1TimestampedObject> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1TimestampedObject(
      o[0] as api.GoogleCloudVideointelligenceV1TimestampedObject);
  checkGoogleCloudVideointelligenceV1TimestampedObject(
      o[1] as api.GoogleCloudVideointelligenceV1TimestampedObject);
}

core.int buildCounterGoogleCloudVideointelligenceV1Track = 0;
api.GoogleCloudVideointelligenceV1Track
    buildGoogleCloudVideointelligenceV1Track() {
  var o = api.GoogleCloudVideointelligenceV1Track();
  buildCounterGoogleCloudVideointelligenceV1Track++;
  if (buildCounterGoogleCloudVideointelligenceV1Track < 3) {
    o.attributes = buildUnnamed6467();
    o.confidence = 42.0;
    o.segment = buildGoogleCloudVideointelligenceV1VideoSegment();
    o.timestampedObjects = buildUnnamed6468();
  }
  buildCounterGoogleCloudVideointelligenceV1Track--;
  return o;
}

void checkGoogleCloudVideointelligenceV1Track(
    api.GoogleCloudVideointelligenceV1Track o) {
  buildCounterGoogleCloudVideointelligenceV1Track++;
  if (buildCounterGoogleCloudVideointelligenceV1Track < 3) {
    checkUnnamed6467(o.attributes!);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVideointelligenceV1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1VideoSegment);
    checkUnnamed6468(o.timestampedObjects!);
  }
  buildCounterGoogleCloudVideointelligenceV1Track--;
}

core.int buildCounterGoogleCloudVideointelligenceV1VideoAnnotationProgress = 0;
api.GoogleCloudVideointelligenceV1VideoAnnotationProgress
    buildGoogleCloudVideointelligenceV1VideoAnnotationProgress() {
  var o = api.GoogleCloudVideointelligenceV1VideoAnnotationProgress();
  buildCounterGoogleCloudVideointelligenceV1VideoAnnotationProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1VideoAnnotationProgress < 3) {
    o.feature = 'foo';
    o.inputUri = 'foo';
    o.progressPercent = 42;
    o.segment = buildGoogleCloudVideointelligenceV1VideoSegment();
    o.startTime = 'foo';
    o.updateTime = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1VideoAnnotationProgress--;
  return o;
}

void checkGoogleCloudVideointelligenceV1VideoAnnotationProgress(
    api.GoogleCloudVideointelligenceV1VideoAnnotationProgress o) {
  buildCounterGoogleCloudVideointelligenceV1VideoAnnotationProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1VideoAnnotationProgress < 3) {
    unittest.expect(
      o.feature!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.inputUri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.progressPercent!,
      unittest.equals(42),
    );
    checkGoogleCloudVideointelligenceV1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1VideoSegment);
    unittest.expect(
      o.startTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.updateTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1VideoAnnotationProgress--;
}

core.List<api.GoogleCloudVideointelligenceV1FaceAnnotation> buildUnnamed6469() {
  var o = <api.GoogleCloudVideointelligenceV1FaceAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1FaceAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1FaceAnnotation());
  return o;
}

void checkUnnamed6469(
    core.List<api.GoogleCloudVideointelligenceV1FaceAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1FaceAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1FaceAnnotation);
  checkGoogleCloudVideointelligenceV1FaceAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1FaceAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1FaceDetectionAnnotation>
    buildUnnamed6470() {
  var o = <api.GoogleCloudVideointelligenceV1FaceDetectionAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1FaceDetectionAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1FaceDetectionAnnotation());
  return o;
}

void checkUnnamed6470(
    core.List<api.GoogleCloudVideointelligenceV1FaceDetectionAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1FaceDetectionAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1FaceDetectionAnnotation);
  checkGoogleCloudVideointelligenceV1FaceDetectionAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1FaceDetectionAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1LabelAnnotation>
    buildUnnamed6471() {
  var o = <api.GoogleCloudVideointelligenceV1LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1LabelAnnotation());
  return o;
}

void checkUnnamed6471(
    core.List<api.GoogleCloudVideointelligenceV1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1LabelAnnotation);
  checkGoogleCloudVideointelligenceV1LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1LogoRecognitionAnnotation>
    buildUnnamed6472() {
  var o = <api.GoogleCloudVideointelligenceV1LogoRecognitionAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1LogoRecognitionAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1LogoRecognitionAnnotation());
  return o;
}

void checkUnnamed6472(
    core.List<api.GoogleCloudVideointelligenceV1LogoRecognitionAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1LogoRecognitionAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1LogoRecognitionAnnotation);
  checkGoogleCloudVideointelligenceV1LogoRecognitionAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1LogoRecognitionAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1ObjectTrackingAnnotation>
    buildUnnamed6473() {
  var o = <api.GoogleCloudVideointelligenceV1ObjectTrackingAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1ObjectTrackingAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1ObjectTrackingAnnotation());
  return o;
}

void checkUnnamed6473(
    core.List<api.GoogleCloudVideointelligenceV1ObjectTrackingAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1ObjectTrackingAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1ObjectTrackingAnnotation);
  checkGoogleCloudVideointelligenceV1ObjectTrackingAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1ObjectTrackingAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1PersonDetectionAnnotation>
    buildUnnamed6474() {
  var o = <api.GoogleCloudVideointelligenceV1PersonDetectionAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1PersonDetectionAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1PersonDetectionAnnotation());
  return o;
}

void checkUnnamed6474(
    core.List<api.GoogleCloudVideointelligenceV1PersonDetectionAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1PersonDetectionAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1PersonDetectionAnnotation);
  checkGoogleCloudVideointelligenceV1PersonDetectionAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1PersonDetectionAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1LabelAnnotation>
    buildUnnamed6475() {
  var o = <api.GoogleCloudVideointelligenceV1LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1LabelAnnotation());
  return o;
}

void checkUnnamed6475(
    core.List<api.GoogleCloudVideointelligenceV1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1LabelAnnotation);
  checkGoogleCloudVideointelligenceV1LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1LabelAnnotation>
    buildUnnamed6476() {
  var o = <api.GoogleCloudVideointelligenceV1LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1LabelAnnotation());
  return o;
}

void checkUnnamed6476(
    core.List<api.GoogleCloudVideointelligenceV1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1LabelAnnotation);
  checkGoogleCloudVideointelligenceV1LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1VideoSegment> buildUnnamed6477() {
  var o = <api.GoogleCloudVideointelligenceV1VideoSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1VideoSegment());
  o.add(buildGoogleCloudVideointelligenceV1VideoSegment());
  return o;
}

void checkUnnamed6477(
    core.List<api.GoogleCloudVideointelligenceV1VideoSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1VideoSegment(
      o[0] as api.GoogleCloudVideointelligenceV1VideoSegment);
  checkGoogleCloudVideointelligenceV1VideoSegment(
      o[1] as api.GoogleCloudVideointelligenceV1VideoSegment);
}

core.List<api.GoogleCloudVideointelligenceV1LabelAnnotation>
    buildUnnamed6478() {
  var o = <api.GoogleCloudVideointelligenceV1LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1LabelAnnotation());
  return o;
}

void checkUnnamed6478(
    core.List<api.GoogleCloudVideointelligenceV1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1LabelAnnotation);
  checkGoogleCloudVideointelligenceV1LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1LabelAnnotation>
    buildUnnamed6479() {
  var o = <api.GoogleCloudVideointelligenceV1LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1LabelAnnotation());
  return o;
}

void checkUnnamed6479(
    core.List<api.GoogleCloudVideointelligenceV1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1LabelAnnotation);
  checkGoogleCloudVideointelligenceV1LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1SpeechTranscription>
    buildUnnamed6480() {
  var o = <api.GoogleCloudVideointelligenceV1SpeechTranscription>[];
  o.add(buildGoogleCloudVideointelligenceV1SpeechTranscription());
  o.add(buildGoogleCloudVideointelligenceV1SpeechTranscription());
  return o;
}

void checkUnnamed6480(
    core.List<api.GoogleCloudVideointelligenceV1SpeechTranscription> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1SpeechTranscription(
      o[0] as api.GoogleCloudVideointelligenceV1SpeechTranscription);
  checkGoogleCloudVideointelligenceV1SpeechTranscription(
      o[1] as api.GoogleCloudVideointelligenceV1SpeechTranscription);
}

core.List<api.GoogleCloudVideointelligenceV1TextAnnotation> buildUnnamed6481() {
  var o = <api.GoogleCloudVideointelligenceV1TextAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1TextAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1TextAnnotation());
  return o;
}

void checkUnnamed6481(
    core.List<api.GoogleCloudVideointelligenceV1TextAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1TextAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1TextAnnotation);
  checkGoogleCloudVideointelligenceV1TextAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1TextAnnotation);
}

core.int buildCounterGoogleCloudVideointelligenceV1VideoAnnotationResults = 0;
api.GoogleCloudVideointelligenceV1VideoAnnotationResults
    buildGoogleCloudVideointelligenceV1VideoAnnotationResults() {
  var o = api.GoogleCloudVideointelligenceV1VideoAnnotationResults();
  buildCounterGoogleCloudVideointelligenceV1VideoAnnotationResults++;
  if (buildCounterGoogleCloudVideointelligenceV1VideoAnnotationResults < 3) {
    o.error = buildGoogleRpcStatus();
    o.explicitAnnotation =
        buildGoogleCloudVideointelligenceV1ExplicitContentAnnotation();
    o.faceAnnotations = buildUnnamed6469();
    o.faceDetectionAnnotations = buildUnnamed6470();
    o.frameLabelAnnotations = buildUnnamed6471();
    o.inputUri = 'foo';
    o.logoRecognitionAnnotations = buildUnnamed6472();
    o.objectAnnotations = buildUnnamed6473();
    o.personDetectionAnnotations = buildUnnamed6474();
    o.segment = buildGoogleCloudVideointelligenceV1VideoSegment();
    o.segmentLabelAnnotations = buildUnnamed6475();
    o.segmentPresenceLabelAnnotations = buildUnnamed6476();
    o.shotAnnotations = buildUnnamed6477();
    o.shotLabelAnnotations = buildUnnamed6478();
    o.shotPresenceLabelAnnotations = buildUnnamed6479();
    o.speechTranscriptions = buildUnnamed6480();
    o.textAnnotations = buildUnnamed6481();
  }
  buildCounterGoogleCloudVideointelligenceV1VideoAnnotationResults--;
  return o;
}

void checkGoogleCloudVideointelligenceV1VideoAnnotationResults(
    api.GoogleCloudVideointelligenceV1VideoAnnotationResults o) {
  buildCounterGoogleCloudVideointelligenceV1VideoAnnotationResults++;
  if (buildCounterGoogleCloudVideointelligenceV1VideoAnnotationResults < 3) {
    checkGoogleRpcStatus(o.error! as api.GoogleRpcStatus);
    checkGoogleCloudVideointelligenceV1ExplicitContentAnnotation(
        o.explicitAnnotation!
            as api.GoogleCloudVideointelligenceV1ExplicitContentAnnotation);
    checkUnnamed6469(o.faceAnnotations!);
    checkUnnamed6470(o.faceDetectionAnnotations!);
    checkUnnamed6471(o.frameLabelAnnotations!);
    unittest.expect(
      o.inputUri!,
      unittest.equals('foo'),
    );
    checkUnnamed6472(o.logoRecognitionAnnotations!);
    checkUnnamed6473(o.objectAnnotations!);
    checkUnnamed6474(o.personDetectionAnnotations!);
    checkGoogleCloudVideointelligenceV1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1VideoSegment);
    checkUnnamed6475(o.segmentLabelAnnotations!);
    checkUnnamed6476(o.segmentPresenceLabelAnnotations!);
    checkUnnamed6477(o.shotAnnotations!);
    checkUnnamed6478(o.shotLabelAnnotations!);
    checkUnnamed6479(o.shotPresenceLabelAnnotations!);
    checkUnnamed6480(o.speechTranscriptions!);
    checkUnnamed6481(o.textAnnotations!);
  }
  buildCounterGoogleCloudVideointelligenceV1VideoAnnotationResults--;
}

core.List<api.GoogleCloudVideointelligenceV1VideoSegment> buildUnnamed6482() {
  var o = <api.GoogleCloudVideointelligenceV1VideoSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1VideoSegment());
  o.add(buildGoogleCloudVideointelligenceV1VideoSegment());
  return o;
}

void checkUnnamed6482(
    core.List<api.GoogleCloudVideointelligenceV1VideoSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1VideoSegment(
      o[0] as api.GoogleCloudVideointelligenceV1VideoSegment);
  checkGoogleCloudVideointelligenceV1VideoSegment(
      o[1] as api.GoogleCloudVideointelligenceV1VideoSegment);
}

core.int buildCounterGoogleCloudVideointelligenceV1VideoContext = 0;
api.GoogleCloudVideointelligenceV1VideoContext
    buildGoogleCloudVideointelligenceV1VideoContext() {
  var o = api.GoogleCloudVideointelligenceV1VideoContext();
  buildCounterGoogleCloudVideointelligenceV1VideoContext++;
  if (buildCounterGoogleCloudVideointelligenceV1VideoContext < 3) {
    o.explicitContentDetectionConfig =
        buildGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig();
    o.faceDetectionConfig =
        buildGoogleCloudVideointelligenceV1FaceDetectionConfig();
    o.labelDetectionConfig =
        buildGoogleCloudVideointelligenceV1LabelDetectionConfig();
    o.objectTrackingConfig =
        buildGoogleCloudVideointelligenceV1ObjectTrackingConfig();
    o.personDetectionConfig =
        buildGoogleCloudVideointelligenceV1PersonDetectionConfig();
    o.segments = buildUnnamed6482();
    o.shotChangeDetectionConfig =
        buildGoogleCloudVideointelligenceV1ShotChangeDetectionConfig();
    o.speechTranscriptionConfig =
        buildGoogleCloudVideointelligenceV1SpeechTranscriptionConfig();
    o.textDetectionConfig =
        buildGoogleCloudVideointelligenceV1TextDetectionConfig();
  }
  buildCounterGoogleCloudVideointelligenceV1VideoContext--;
  return o;
}

void checkGoogleCloudVideointelligenceV1VideoContext(
    api.GoogleCloudVideointelligenceV1VideoContext o) {
  buildCounterGoogleCloudVideointelligenceV1VideoContext++;
  if (buildCounterGoogleCloudVideointelligenceV1VideoContext < 3) {
    checkGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig(o
            .explicitContentDetectionConfig!
        as api.GoogleCloudVideointelligenceV1ExplicitContentDetectionConfig);
    checkGoogleCloudVideointelligenceV1FaceDetectionConfig(
        o.faceDetectionConfig!
            as api.GoogleCloudVideointelligenceV1FaceDetectionConfig);
    checkGoogleCloudVideointelligenceV1LabelDetectionConfig(
        o.labelDetectionConfig!
            as api.GoogleCloudVideointelligenceV1LabelDetectionConfig);
    checkGoogleCloudVideointelligenceV1ObjectTrackingConfig(
        o.objectTrackingConfig!
            as api.GoogleCloudVideointelligenceV1ObjectTrackingConfig);
    checkGoogleCloudVideointelligenceV1PersonDetectionConfig(
        o.personDetectionConfig!
            as api.GoogleCloudVideointelligenceV1PersonDetectionConfig);
    checkUnnamed6482(o.segments!);
    checkGoogleCloudVideointelligenceV1ShotChangeDetectionConfig(
        o.shotChangeDetectionConfig!
            as api.GoogleCloudVideointelligenceV1ShotChangeDetectionConfig);
    checkGoogleCloudVideointelligenceV1SpeechTranscriptionConfig(
        o.speechTranscriptionConfig!
            as api.GoogleCloudVideointelligenceV1SpeechTranscriptionConfig);
    checkGoogleCloudVideointelligenceV1TextDetectionConfig(
        o.textDetectionConfig!
            as api.GoogleCloudVideointelligenceV1TextDetectionConfig);
  }
  buildCounterGoogleCloudVideointelligenceV1VideoContext--;
}

core.int buildCounterGoogleCloudVideointelligenceV1VideoSegment = 0;
api.GoogleCloudVideointelligenceV1VideoSegment
    buildGoogleCloudVideointelligenceV1VideoSegment() {
  var o = api.GoogleCloudVideointelligenceV1VideoSegment();
  buildCounterGoogleCloudVideointelligenceV1VideoSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1VideoSegment < 3) {
    o.endTimeOffset = 'foo';
    o.startTimeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1VideoSegment--;
  return o;
}

void checkGoogleCloudVideointelligenceV1VideoSegment(
    api.GoogleCloudVideointelligenceV1VideoSegment o) {
  buildCounterGoogleCloudVideointelligenceV1VideoSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1VideoSegment < 3) {
    unittest.expect(
      o.endTimeOffset!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.startTimeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1VideoSegment--;
}

core.int buildCounterGoogleCloudVideointelligenceV1WordInfo = 0;
api.GoogleCloudVideointelligenceV1WordInfo
    buildGoogleCloudVideointelligenceV1WordInfo() {
  var o = api.GoogleCloudVideointelligenceV1WordInfo();
  buildCounterGoogleCloudVideointelligenceV1WordInfo++;
  if (buildCounterGoogleCloudVideointelligenceV1WordInfo < 3) {
    o.confidence = 42.0;
    o.endTime = 'foo';
    o.speakerTag = 42;
    o.startTime = 'foo';
    o.word = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1WordInfo--;
  return o;
}

void checkGoogleCloudVideointelligenceV1WordInfo(
    api.GoogleCloudVideointelligenceV1WordInfo o) {
  buildCounterGoogleCloudVideointelligenceV1WordInfo++;
  if (buildCounterGoogleCloudVideointelligenceV1WordInfo < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.endTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.speakerTag!,
      unittest.equals(42),
    );
    unittest.expect(
      o.startTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.word!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1WordInfo--;
}

core.List<api.GoogleCloudVideointelligenceV1beta2VideoAnnotationProgress>
    buildUnnamed6483() {
  var o = <api.GoogleCloudVideointelligenceV1beta2VideoAnnotationProgress>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress());
  o.add(buildGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress());
  return o;
}

void checkUnnamed6483(
    core.List<api.GoogleCloudVideointelligenceV1beta2VideoAnnotationProgress>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress(
      o[0] as api.GoogleCloudVideointelligenceV1beta2VideoAnnotationProgress);
  checkGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress(
      o[1] as api.GoogleCloudVideointelligenceV1beta2VideoAnnotationProgress);
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoProgress =
    0;
api.GoogleCloudVideointelligenceV1beta2AnnotateVideoProgress
    buildGoogleCloudVideointelligenceV1beta2AnnotateVideoProgress() {
  var o = api.GoogleCloudVideointelligenceV1beta2AnnotateVideoProgress();
  buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoProgress <
      3) {
    o.annotationProgress = buildUnnamed6483();
  }
  buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoProgress--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2AnnotateVideoProgress(
    api.GoogleCloudVideointelligenceV1beta2AnnotateVideoProgress o) {
  buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoProgress <
      3) {
    checkUnnamed6483(o.annotationProgress!);
  }
  buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoProgress--;
}

core.List<api.GoogleCloudVideointelligenceV1beta2VideoAnnotationResults>
    buildUnnamed6484() {
  var o = <api.GoogleCloudVideointelligenceV1beta2VideoAnnotationResults>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2VideoAnnotationResults());
  o.add(buildGoogleCloudVideointelligenceV1beta2VideoAnnotationResults());
  return o;
}

void checkUnnamed6484(
    core.List<api.GoogleCloudVideointelligenceV1beta2VideoAnnotationResults>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2VideoAnnotationResults(
      o[0] as api.GoogleCloudVideointelligenceV1beta2VideoAnnotationResults);
  checkGoogleCloudVideointelligenceV1beta2VideoAnnotationResults(
      o[1] as api.GoogleCloudVideointelligenceV1beta2VideoAnnotationResults);
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoResponse =
    0;
api.GoogleCloudVideointelligenceV1beta2AnnotateVideoResponse
    buildGoogleCloudVideointelligenceV1beta2AnnotateVideoResponse() {
  var o = api.GoogleCloudVideointelligenceV1beta2AnnotateVideoResponse();
  buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoResponse++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoResponse <
      3) {
    o.annotationResults = buildUnnamed6484();
  }
  buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoResponse--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2AnnotateVideoResponse(
    api.GoogleCloudVideointelligenceV1beta2AnnotateVideoResponse o) {
  buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoResponse++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoResponse <
      3) {
    checkUnnamed6484(o.annotationResults!);
  }
  buildCounterGoogleCloudVideointelligenceV1beta2AnnotateVideoResponse--;
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2DetectedAttribute = 0;
api.GoogleCloudVideointelligenceV1beta2DetectedAttribute
    buildGoogleCloudVideointelligenceV1beta2DetectedAttribute() {
  var o = api.GoogleCloudVideointelligenceV1beta2DetectedAttribute();
  buildCounterGoogleCloudVideointelligenceV1beta2DetectedAttribute++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2DetectedAttribute < 3) {
    o.confidence = 42.0;
    o.name = 'foo';
    o.value = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1beta2DetectedAttribute--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2DetectedAttribute(
    api.GoogleCloudVideointelligenceV1beta2DetectedAttribute o) {
  buildCounterGoogleCloudVideointelligenceV1beta2DetectedAttribute++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2DetectedAttribute < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1beta2DetectedAttribute--;
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2DetectedLandmark = 0;
api.GoogleCloudVideointelligenceV1beta2DetectedLandmark
    buildGoogleCloudVideointelligenceV1beta2DetectedLandmark() {
  var o = api.GoogleCloudVideointelligenceV1beta2DetectedLandmark();
  buildCounterGoogleCloudVideointelligenceV1beta2DetectedLandmark++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2DetectedLandmark < 3) {
    o.confidence = 42.0;
    o.name = 'foo';
    o.point = buildGoogleCloudVideointelligenceV1beta2NormalizedVertex();
  }
  buildCounterGoogleCloudVideointelligenceV1beta2DetectedLandmark--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2DetectedLandmark(
    api.GoogleCloudVideointelligenceV1beta2DetectedLandmark o) {
  buildCounterGoogleCloudVideointelligenceV1beta2DetectedLandmark++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2DetectedLandmark < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkGoogleCloudVideointelligenceV1beta2NormalizedVertex(
        o.point! as api.GoogleCloudVideointelligenceV1beta2NormalizedVertex);
  }
  buildCounterGoogleCloudVideointelligenceV1beta2DetectedLandmark--;
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2Entity = 0;
api.GoogleCloudVideointelligenceV1beta2Entity
    buildGoogleCloudVideointelligenceV1beta2Entity() {
  var o = api.GoogleCloudVideointelligenceV1beta2Entity();
  buildCounterGoogleCloudVideointelligenceV1beta2Entity++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2Entity < 3) {
    o.description = 'foo';
    o.entityId = 'foo';
    o.languageCode = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1beta2Entity--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2Entity(
    api.GoogleCloudVideointelligenceV1beta2Entity o) {
  buildCounterGoogleCloudVideointelligenceV1beta2Entity++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2Entity < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.entityId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1beta2Entity--;
}

core.List<api.GoogleCloudVideointelligenceV1beta2ExplicitContentFrame>
    buildUnnamed6485() {
  var o = <api.GoogleCloudVideointelligenceV1beta2ExplicitContentFrame>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2ExplicitContentFrame());
  o.add(buildGoogleCloudVideointelligenceV1beta2ExplicitContentFrame());
  return o;
}

void checkUnnamed6485(
    core.List<api.GoogleCloudVideointelligenceV1beta2ExplicitContentFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2ExplicitContentFrame(
      o[0] as api.GoogleCloudVideointelligenceV1beta2ExplicitContentFrame);
  checkGoogleCloudVideointelligenceV1beta2ExplicitContentFrame(
      o[1] as api.GoogleCloudVideointelligenceV1beta2ExplicitContentFrame);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation =
    0;
api.GoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation
    buildGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation();
  buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation <
      3) {
    o.frames = buildUnnamed6485();
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation(
    api.GoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation <
      3) {
    checkUnnamed6485(o.frames!);
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentFrame =
    0;
api.GoogleCloudVideointelligenceV1beta2ExplicitContentFrame
    buildGoogleCloudVideointelligenceV1beta2ExplicitContentFrame() {
  var o = api.GoogleCloudVideointelligenceV1beta2ExplicitContentFrame();
  buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentFrame < 3) {
    o.pornographyLikelihood = 'foo';
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentFrame--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2ExplicitContentFrame(
    api.GoogleCloudVideointelligenceV1beta2ExplicitContentFrame o) {
  buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentFrame < 3) {
    unittest.expect(
      o.pornographyLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1beta2ExplicitContentFrame--;
}

core.List<api.GoogleCloudVideointelligenceV1beta2FaceFrame> buildUnnamed6486() {
  var o = <api.GoogleCloudVideointelligenceV1beta2FaceFrame>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2FaceFrame());
  o.add(buildGoogleCloudVideointelligenceV1beta2FaceFrame());
  return o;
}

void checkUnnamed6486(
    core.List<api.GoogleCloudVideointelligenceV1beta2FaceFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2FaceFrame(
      o[0] as api.GoogleCloudVideointelligenceV1beta2FaceFrame);
  checkGoogleCloudVideointelligenceV1beta2FaceFrame(
      o[1] as api.GoogleCloudVideointelligenceV1beta2FaceFrame);
}

core.List<api.GoogleCloudVideointelligenceV1beta2FaceSegment>
    buildUnnamed6487() {
  var o = <api.GoogleCloudVideointelligenceV1beta2FaceSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2FaceSegment());
  o.add(buildGoogleCloudVideointelligenceV1beta2FaceSegment());
  return o;
}

void checkUnnamed6487(
    core.List<api.GoogleCloudVideointelligenceV1beta2FaceSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2FaceSegment(
      o[0] as api.GoogleCloudVideointelligenceV1beta2FaceSegment);
  checkGoogleCloudVideointelligenceV1beta2FaceSegment(
      o[1] as api.GoogleCloudVideointelligenceV1beta2FaceSegment);
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2FaceAnnotation = 0;
api.GoogleCloudVideointelligenceV1beta2FaceAnnotation
    buildGoogleCloudVideointelligenceV1beta2FaceAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1beta2FaceAnnotation();
  buildCounterGoogleCloudVideointelligenceV1beta2FaceAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2FaceAnnotation < 3) {
    o.frames = buildUnnamed6486();
    o.segments = buildUnnamed6487();
    o.thumbnail = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1beta2FaceAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2FaceAnnotation(
    api.GoogleCloudVideointelligenceV1beta2FaceAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1beta2FaceAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2FaceAnnotation < 3) {
    checkUnnamed6486(o.frames!);
    checkUnnamed6487(o.segments!);
    unittest.expect(
      o.thumbnail!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1beta2FaceAnnotation--;
}

core.List<api.GoogleCloudVideointelligenceV1beta2Track> buildUnnamed6488() {
  var o = <api.GoogleCloudVideointelligenceV1beta2Track>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2Track());
  o.add(buildGoogleCloudVideointelligenceV1beta2Track());
  return o;
}

void checkUnnamed6488(
    core.List<api.GoogleCloudVideointelligenceV1beta2Track> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2Track(
      o[0] as api.GoogleCloudVideointelligenceV1beta2Track);
  checkGoogleCloudVideointelligenceV1beta2Track(
      o[1] as api.GoogleCloudVideointelligenceV1beta2Track);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation = 0;
api.GoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation
    buildGoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation();
  buildCounterGoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation <
      3) {
    o.thumbnail = 'foo';
    o.tracks = buildUnnamed6488();
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation(
    api.GoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation <
      3) {
    unittest.expect(
      o.thumbnail!,
      unittest.equals('foo'),
    );
    checkUnnamed6488(o.tracks!);
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation--;
}

core.List<api.GoogleCloudVideointelligenceV1beta2NormalizedBoundingBox>
    buildUnnamed6489() {
  var o = <api.GoogleCloudVideointelligenceV1beta2NormalizedBoundingBox>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2NormalizedBoundingBox());
  o.add(buildGoogleCloudVideointelligenceV1beta2NormalizedBoundingBox());
  return o;
}

void checkUnnamed6489(
    core.List<api.GoogleCloudVideointelligenceV1beta2NormalizedBoundingBox> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2NormalizedBoundingBox(
      o[0] as api.GoogleCloudVideointelligenceV1beta2NormalizedBoundingBox);
  checkGoogleCloudVideointelligenceV1beta2NormalizedBoundingBox(
      o[1] as api.GoogleCloudVideointelligenceV1beta2NormalizedBoundingBox);
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2FaceFrame = 0;
api.GoogleCloudVideointelligenceV1beta2FaceFrame
    buildGoogleCloudVideointelligenceV1beta2FaceFrame() {
  var o = api.GoogleCloudVideointelligenceV1beta2FaceFrame();
  buildCounterGoogleCloudVideointelligenceV1beta2FaceFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2FaceFrame < 3) {
    o.normalizedBoundingBoxes = buildUnnamed6489();
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1beta2FaceFrame--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2FaceFrame(
    api.GoogleCloudVideointelligenceV1beta2FaceFrame o) {
  buildCounterGoogleCloudVideointelligenceV1beta2FaceFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2FaceFrame < 3) {
    checkUnnamed6489(o.normalizedBoundingBoxes!);
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1beta2FaceFrame--;
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2FaceSegment = 0;
api.GoogleCloudVideointelligenceV1beta2FaceSegment
    buildGoogleCloudVideointelligenceV1beta2FaceSegment() {
  var o = api.GoogleCloudVideointelligenceV1beta2FaceSegment();
  buildCounterGoogleCloudVideointelligenceV1beta2FaceSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2FaceSegment < 3) {
    o.segment = buildGoogleCloudVideointelligenceV1beta2VideoSegment();
  }
  buildCounterGoogleCloudVideointelligenceV1beta2FaceSegment--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2FaceSegment(
    api.GoogleCloudVideointelligenceV1beta2FaceSegment o) {
  buildCounterGoogleCloudVideointelligenceV1beta2FaceSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2FaceSegment < 3) {
    checkGoogleCloudVideointelligenceV1beta2VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1beta2VideoSegment);
  }
  buildCounterGoogleCloudVideointelligenceV1beta2FaceSegment--;
}

core.List<api.GoogleCloudVideointelligenceV1beta2Entity> buildUnnamed6490() {
  var o = <api.GoogleCloudVideointelligenceV1beta2Entity>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2Entity());
  o.add(buildGoogleCloudVideointelligenceV1beta2Entity());
  return o;
}

void checkUnnamed6490(
    core.List<api.GoogleCloudVideointelligenceV1beta2Entity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2Entity(
      o[0] as api.GoogleCloudVideointelligenceV1beta2Entity);
  checkGoogleCloudVideointelligenceV1beta2Entity(
      o[1] as api.GoogleCloudVideointelligenceV1beta2Entity);
}

core.List<api.GoogleCloudVideointelligenceV1beta2LabelFrame>
    buildUnnamed6491() {
  var o = <api.GoogleCloudVideointelligenceV1beta2LabelFrame>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2LabelFrame());
  o.add(buildGoogleCloudVideointelligenceV1beta2LabelFrame());
  return o;
}

void checkUnnamed6491(
    core.List<api.GoogleCloudVideointelligenceV1beta2LabelFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2LabelFrame(
      o[0] as api.GoogleCloudVideointelligenceV1beta2LabelFrame);
  checkGoogleCloudVideointelligenceV1beta2LabelFrame(
      o[1] as api.GoogleCloudVideointelligenceV1beta2LabelFrame);
}

core.List<api.GoogleCloudVideointelligenceV1beta2LabelSegment>
    buildUnnamed6492() {
  var o = <api.GoogleCloudVideointelligenceV1beta2LabelSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2LabelSegment());
  o.add(buildGoogleCloudVideointelligenceV1beta2LabelSegment());
  return o;
}

void checkUnnamed6492(
    core.List<api.GoogleCloudVideointelligenceV1beta2LabelSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2LabelSegment(
      o[0] as api.GoogleCloudVideointelligenceV1beta2LabelSegment);
  checkGoogleCloudVideointelligenceV1beta2LabelSegment(
      o[1] as api.GoogleCloudVideointelligenceV1beta2LabelSegment);
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2LabelAnnotation = 0;
api.GoogleCloudVideointelligenceV1beta2LabelAnnotation
    buildGoogleCloudVideointelligenceV1beta2LabelAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1beta2LabelAnnotation();
  buildCounterGoogleCloudVideointelligenceV1beta2LabelAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2LabelAnnotation < 3) {
    o.categoryEntities = buildUnnamed6490();
    o.entity = buildGoogleCloudVideointelligenceV1beta2Entity();
    o.frames = buildUnnamed6491();
    o.segments = buildUnnamed6492();
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1beta2LabelAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2LabelAnnotation(
    api.GoogleCloudVideointelligenceV1beta2LabelAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1beta2LabelAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2LabelAnnotation < 3) {
    checkUnnamed6490(o.categoryEntities!);
    checkGoogleCloudVideointelligenceV1beta2Entity(
        o.entity! as api.GoogleCloudVideointelligenceV1beta2Entity);
    checkUnnamed6491(o.frames!);
    checkUnnamed6492(o.segments!);
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1beta2LabelAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2LabelFrame = 0;
api.GoogleCloudVideointelligenceV1beta2LabelFrame
    buildGoogleCloudVideointelligenceV1beta2LabelFrame() {
  var o = api.GoogleCloudVideointelligenceV1beta2LabelFrame();
  buildCounterGoogleCloudVideointelligenceV1beta2LabelFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2LabelFrame < 3) {
    o.confidence = 42.0;
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1beta2LabelFrame--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2LabelFrame(
    api.GoogleCloudVideointelligenceV1beta2LabelFrame o) {
  buildCounterGoogleCloudVideointelligenceV1beta2LabelFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2LabelFrame < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1beta2LabelFrame--;
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2LabelSegment = 0;
api.GoogleCloudVideointelligenceV1beta2LabelSegment
    buildGoogleCloudVideointelligenceV1beta2LabelSegment() {
  var o = api.GoogleCloudVideointelligenceV1beta2LabelSegment();
  buildCounterGoogleCloudVideointelligenceV1beta2LabelSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2LabelSegment < 3) {
    o.confidence = 42.0;
    o.segment = buildGoogleCloudVideointelligenceV1beta2VideoSegment();
  }
  buildCounterGoogleCloudVideointelligenceV1beta2LabelSegment--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2LabelSegment(
    api.GoogleCloudVideointelligenceV1beta2LabelSegment o) {
  buildCounterGoogleCloudVideointelligenceV1beta2LabelSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2LabelSegment < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVideointelligenceV1beta2VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1beta2VideoSegment);
  }
  buildCounterGoogleCloudVideointelligenceV1beta2LabelSegment--;
}

core.List<api.GoogleCloudVideointelligenceV1beta2VideoSegment>
    buildUnnamed6493() {
  var o = <api.GoogleCloudVideointelligenceV1beta2VideoSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2VideoSegment());
  o.add(buildGoogleCloudVideointelligenceV1beta2VideoSegment());
  return o;
}

void checkUnnamed6493(
    core.List<api.GoogleCloudVideointelligenceV1beta2VideoSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2VideoSegment(
      o[0] as api.GoogleCloudVideointelligenceV1beta2VideoSegment);
  checkGoogleCloudVideointelligenceV1beta2VideoSegment(
      o[1] as api.GoogleCloudVideointelligenceV1beta2VideoSegment);
}

core.List<api.GoogleCloudVideointelligenceV1beta2Track> buildUnnamed6494() {
  var o = <api.GoogleCloudVideointelligenceV1beta2Track>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2Track());
  o.add(buildGoogleCloudVideointelligenceV1beta2Track());
  return o;
}

void checkUnnamed6494(
    core.List<api.GoogleCloudVideointelligenceV1beta2Track> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2Track(
      o[0] as api.GoogleCloudVideointelligenceV1beta2Track);
  checkGoogleCloudVideointelligenceV1beta2Track(
      o[1] as api.GoogleCloudVideointelligenceV1beta2Track);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation =
    0;
api.GoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation
    buildGoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation();
  buildCounterGoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation <
      3) {
    o.entity = buildGoogleCloudVideointelligenceV1beta2Entity();
    o.segments = buildUnnamed6493();
    o.tracks = buildUnnamed6494();
  }
  buildCounterGoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation(
    api.GoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation <
      3) {
    checkGoogleCloudVideointelligenceV1beta2Entity(
        o.entity! as api.GoogleCloudVideointelligenceV1beta2Entity);
    checkUnnamed6493(o.segments!);
    checkUnnamed6494(o.tracks!);
  }
  buildCounterGoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2NormalizedBoundingBox =
    0;
api.GoogleCloudVideointelligenceV1beta2NormalizedBoundingBox
    buildGoogleCloudVideointelligenceV1beta2NormalizedBoundingBox() {
  var o = api.GoogleCloudVideointelligenceV1beta2NormalizedBoundingBox();
  buildCounterGoogleCloudVideointelligenceV1beta2NormalizedBoundingBox++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2NormalizedBoundingBox <
      3) {
    o.bottom = 42.0;
    o.left = 42.0;
    o.right = 42.0;
    o.top = 42.0;
  }
  buildCounterGoogleCloudVideointelligenceV1beta2NormalizedBoundingBox--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2NormalizedBoundingBox(
    api.GoogleCloudVideointelligenceV1beta2NormalizedBoundingBox o) {
  buildCounterGoogleCloudVideointelligenceV1beta2NormalizedBoundingBox++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2NormalizedBoundingBox <
      3) {
    unittest.expect(
      o.bottom!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.left!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.right!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.top!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1beta2NormalizedBoundingBox--;
}

core.List<api.GoogleCloudVideointelligenceV1beta2NormalizedVertex>
    buildUnnamed6495() {
  var o = <api.GoogleCloudVideointelligenceV1beta2NormalizedVertex>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2NormalizedVertex());
  o.add(buildGoogleCloudVideointelligenceV1beta2NormalizedVertex());
  return o;
}

void checkUnnamed6495(
    core.List<api.GoogleCloudVideointelligenceV1beta2NormalizedVertex> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2NormalizedVertex(
      o[0] as api.GoogleCloudVideointelligenceV1beta2NormalizedVertex);
  checkGoogleCloudVideointelligenceV1beta2NormalizedVertex(
      o[1] as api.GoogleCloudVideointelligenceV1beta2NormalizedVertex);
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2NormalizedBoundingPoly =
    0;
api.GoogleCloudVideointelligenceV1beta2NormalizedBoundingPoly
    buildGoogleCloudVideointelligenceV1beta2NormalizedBoundingPoly() {
  var o = api.GoogleCloudVideointelligenceV1beta2NormalizedBoundingPoly();
  buildCounterGoogleCloudVideointelligenceV1beta2NormalizedBoundingPoly++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2NormalizedBoundingPoly <
      3) {
    o.vertices = buildUnnamed6495();
  }
  buildCounterGoogleCloudVideointelligenceV1beta2NormalizedBoundingPoly--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2NormalizedBoundingPoly(
    api.GoogleCloudVideointelligenceV1beta2NormalizedBoundingPoly o) {
  buildCounterGoogleCloudVideointelligenceV1beta2NormalizedBoundingPoly++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2NormalizedBoundingPoly <
      3) {
    checkUnnamed6495(o.vertices!);
  }
  buildCounterGoogleCloudVideointelligenceV1beta2NormalizedBoundingPoly--;
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2NormalizedVertex = 0;
api.GoogleCloudVideointelligenceV1beta2NormalizedVertex
    buildGoogleCloudVideointelligenceV1beta2NormalizedVertex() {
  var o = api.GoogleCloudVideointelligenceV1beta2NormalizedVertex();
  buildCounterGoogleCloudVideointelligenceV1beta2NormalizedVertex++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2NormalizedVertex < 3) {
    o.x = 42.0;
    o.y = 42.0;
  }
  buildCounterGoogleCloudVideointelligenceV1beta2NormalizedVertex--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2NormalizedVertex(
    api.GoogleCloudVideointelligenceV1beta2NormalizedVertex o) {
  buildCounterGoogleCloudVideointelligenceV1beta2NormalizedVertex++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2NormalizedVertex < 3) {
    unittest.expect(
      o.x!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.y!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1beta2NormalizedVertex--;
}

core.List<api.GoogleCloudVideointelligenceV1beta2ObjectTrackingFrame>
    buildUnnamed6496() {
  var o = <api.GoogleCloudVideointelligenceV1beta2ObjectTrackingFrame>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2ObjectTrackingFrame());
  o.add(buildGoogleCloudVideointelligenceV1beta2ObjectTrackingFrame());
  return o;
}

void checkUnnamed6496(
    core.List<api.GoogleCloudVideointelligenceV1beta2ObjectTrackingFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2ObjectTrackingFrame(
      o[0] as api.GoogleCloudVideointelligenceV1beta2ObjectTrackingFrame);
  checkGoogleCloudVideointelligenceV1beta2ObjectTrackingFrame(
      o[1] as api.GoogleCloudVideointelligenceV1beta2ObjectTrackingFrame);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation = 0;
api.GoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation
    buildGoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation();
  buildCounterGoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation <
      3) {
    o.confidence = 42.0;
    o.entity = buildGoogleCloudVideointelligenceV1beta2Entity();
    o.frames = buildUnnamed6496();
    o.segment = buildGoogleCloudVideointelligenceV1beta2VideoSegment();
    o.trackId = 'foo';
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation(
    api.GoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation <
      3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVideointelligenceV1beta2Entity(
        o.entity! as api.GoogleCloudVideointelligenceV1beta2Entity);
    checkUnnamed6496(o.frames!);
    checkGoogleCloudVideointelligenceV1beta2VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1beta2VideoSegment);
    unittest.expect(
      o.trackId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2ObjectTrackingFrame = 0;
api.GoogleCloudVideointelligenceV1beta2ObjectTrackingFrame
    buildGoogleCloudVideointelligenceV1beta2ObjectTrackingFrame() {
  var o = api.GoogleCloudVideointelligenceV1beta2ObjectTrackingFrame();
  buildCounterGoogleCloudVideointelligenceV1beta2ObjectTrackingFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2ObjectTrackingFrame < 3) {
    o.normalizedBoundingBox =
        buildGoogleCloudVideointelligenceV1beta2NormalizedBoundingBox();
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1beta2ObjectTrackingFrame--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2ObjectTrackingFrame(
    api.GoogleCloudVideointelligenceV1beta2ObjectTrackingFrame o) {
  buildCounterGoogleCloudVideointelligenceV1beta2ObjectTrackingFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2ObjectTrackingFrame < 3) {
    checkGoogleCloudVideointelligenceV1beta2NormalizedBoundingBox(
        o.normalizedBoundingBox!
            as api.GoogleCloudVideointelligenceV1beta2NormalizedBoundingBox);
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1beta2ObjectTrackingFrame--;
}

core.List<api.GoogleCloudVideointelligenceV1beta2Track> buildUnnamed6497() {
  var o = <api.GoogleCloudVideointelligenceV1beta2Track>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2Track());
  o.add(buildGoogleCloudVideointelligenceV1beta2Track());
  return o;
}

void checkUnnamed6497(
    core.List<api.GoogleCloudVideointelligenceV1beta2Track> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2Track(
      o[0] as api.GoogleCloudVideointelligenceV1beta2Track);
  checkGoogleCloudVideointelligenceV1beta2Track(
      o[1] as api.GoogleCloudVideointelligenceV1beta2Track);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation =
    0;
api.GoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation
    buildGoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation();
  buildCounterGoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation <
      3) {
    o.tracks = buildUnnamed6497();
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation(
    api.GoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation <
      3) {
    checkUnnamed6497(o.tracks!);
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation--;
}

core.List<api.GoogleCloudVideointelligenceV1beta2WordInfo> buildUnnamed6498() {
  var o = <api.GoogleCloudVideointelligenceV1beta2WordInfo>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2WordInfo());
  o.add(buildGoogleCloudVideointelligenceV1beta2WordInfo());
  return o;
}

void checkUnnamed6498(
    core.List<api.GoogleCloudVideointelligenceV1beta2WordInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2WordInfo(
      o[0] as api.GoogleCloudVideointelligenceV1beta2WordInfo);
  checkGoogleCloudVideointelligenceV1beta2WordInfo(
      o[1] as api.GoogleCloudVideointelligenceV1beta2WordInfo);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative =
    0;
api.GoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative
    buildGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative() {
  var o = api.GoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative();
  buildCounterGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative <
      3) {
    o.confidence = 42.0;
    o.transcript = 'foo';
    o.words = buildUnnamed6498();
  }
  buildCounterGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative(
    api.GoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative o) {
  buildCounterGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative <
      3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.transcript!,
      unittest.equals('foo'),
    );
    checkUnnamed6498(o.words!);
  }
  buildCounterGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative--;
}

core.List<api.GoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative>
    buildUnnamed6499() {
  var o =
      <api.GoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative());
  o.add(buildGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative());
  return o;
}

void checkUnnamed6499(
    core.List<
            api.GoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative(o[0]
      as api.GoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative);
  checkGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative(o[1]
      as api.GoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative);
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2SpeechTranscription = 0;
api.GoogleCloudVideointelligenceV1beta2SpeechTranscription
    buildGoogleCloudVideointelligenceV1beta2SpeechTranscription() {
  var o = api.GoogleCloudVideointelligenceV1beta2SpeechTranscription();
  buildCounterGoogleCloudVideointelligenceV1beta2SpeechTranscription++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2SpeechTranscription < 3) {
    o.alternatives = buildUnnamed6499();
    o.languageCode = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1beta2SpeechTranscription--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2SpeechTranscription(
    api.GoogleCloudVideointelligenceV1beta2SpeechTranscription o) {
  buildCounterGoogleCloudVideointelligenceV1beta2SpeechTranscription++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2SpeechTranscription < 3) {
    checkUnnamed6499(o.alternatives!);
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1beta2SpeechTranscription--;
}

core.List<api.GoogleCloudVideointelligenceV1beta2TextSegment>
    buildUnnamed6500() {
  var o = <api.GoogleCloudVideointelligenceV1beta2TextSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2TextSegment());
  o.add(buildGoogleCloudVideointelligenceV1beta2TextSegment());
  return o;
}

void checkUnnamed6500(
    core.List<api.GoogleCloudVideointelligenceV1beta2TextSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2TextSegment(
      o[0] as api.GoogleCloudVideointelligenceV1beta2TextSegment);
  checkGoogleCloudVideointelligenceV1beta2TextSegment(
      o[1] as api.GoogleCloudVideointelligenceV1beta2TextSegment);
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2TextAnnotation = 0;
api.GoogleCloudVideointelligenceV1beta2TextAnnotation
    buildGoogleCloudVideointelligenceV1beta2TextAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1beta2TextAnnotation();
  buildCounterGoogleCloudVideointelligenceV1beta2TextAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2TextAnnotation < 3) {
    o.segments = buildUnnamed6500();
    o.text = 'foo';
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1beta2TextAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2TextAnnotation(
    api.GoogleCloudVideointelligenceV1beta2TextAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1beta2TextAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2TextAnnotation < 3) {
    checkUnnamed6500(o.segments!);
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1beta2TextAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2TextFrame = 0;
api.GoogleCloudVideointelligenceV1beta2TextFrame
    buildGoogleCloudVideointelligenceV1beta2TextFrame() {
  var o = api.GoogleCloudVideointelligenceV1beta2TextFrame();
  buildCounterGoogleCloudVideointelligenceV1beta2TextFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2TextFrame < 3) {
    o.rotatedBoundingBox =
        buildGoogleCloudVideointelligenceV1beta2NormalizedBoundingPoly();
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1beta2TextFrame--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2TextFrame(
    api.GoogleCloudVideointelligenceV1beta2TextFrame o) {
  buildCounterGoogleCloudVideointelligenceV1beta2TextFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2TextFrame < 3) {
    checkGoogleCloudVideointelligenceV1beta2NormalizedBoundingPoly(
        o.rotatedBoundingBox!
            as api.GoogleCloudVideointelligenceV1beta2NormalizedBoundingPoly);
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1beta2TextFrame--;
}

core.List<api.GoogleCloudVideointelligenceV1beta2TextFrame> buildUnnamed6501() {
  var o = <api.GoogleCloudVideointelligenceV1beta2TextFrame>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2TextFrame());
  o.add(buildGoogleCloudVideointelligenceV1beta2TextFrame());
  return o;
}

void checkUnnamed6501(
    core.List<api.GoogleCloudVideointelligenceV1beta2TextFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2TextFrame(
      o[0] as api.GoogleCloudVideointelligenceV1beta2TextFrame);
  checkGoogleCloudVideointelligenceV1beta2TextFrame(
      o[1] as api.GoogleCloudVideointelligenceV1beta2TextFrame);
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2TextSegment = 0;
api.GoogleCloudVideointelligenceV1beta2TextSegment
    buildGoogleCloudVideointelligenceV1beta2TextSegment() {
  var o = api.GoogleCloudVideointelligenceV1beta2TextSegment();
  buildCounterGoogleCloudVideointelligenceV1beta2TextSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2TextSegment < 3) {
    o.confidence = 42.0;
    o.frames = buildUnnamed6501();
    o.segment = buildGoogleCloudVideointelligenceV1beta2VideoSegment();
  }
  buildCounterGoogleCloudVideointelligenceV1beta2TextSegment--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2TextSegment(
    api.GoogleCloudVideointelligenceV1beta2TextSegment o) {
  buildCounterGoogleCloudVideointelligenceV1beta2TextSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2TextSegment < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkUnnamed6501(o.frames!);
    checkGoogleCloudVideointelligenceV1beta2VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1beta2VideoSegment);
  }
  buildCounterGoogleCloudVideointelligenceV1beta2TextSegment--;
}

core.List<api.GoogleCloudVideointelligenceV1beta2DetectedAttribute>
    buildUnnamed6502() {
  var o = <api.GoogleCloudVideointelligenceV1beta2DetectedAttribute>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2DetectedAttribute());
  o.add(buildGoogleCloudVideointelligenceV1beta2DetectedAttribute());
  return o;
}

void checkUnnamed6502(
    core.List<api.GoogleCloudVideointelligenceV1beta2DetectedAttribute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2DetectedAttribute(
      o[0] as api.GoogleCloudVideointelligenceV1beta2DetectedAttribute);
  checkGoogleCloudVideointelligenceV1beta2DetectedAttribute(
      o[1] as api.GoogleCloudVideointelligenceV1beta2DetectedAttribute);
}

core.List<api.GoogleCloudVideointelligenceV1beta2DetectedLandmark>
    buildUnnamed6503() {
  var o = <api.GoogleCloudVideointelligenceV1beta2DetectedLandmark>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2DetectedLandmark());
  o.add(buildGoogleCloudVideointelligenceV1beta2DetectedLandmark());
  return o;
}

void checkUnnamed6503(
    core.List<api.GoogleCloudVideointelligenceV1beta2DetectedLandmark> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2DetectedLandmark(
      o[0] as api.GoogleCloudVideointelligenceV1beta2DetectedLandmark);
  checkGoogleCloudVideointelligenceV1beta2DetectedLandmark(
      o[1] as api.GoogleCloudVideointelligenceV1beta2DetectedLandmark);
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2TimestampedObject = 0;
api.GoogleCloudVideointelligenceV1beta2TimestampedObject
    buildGoogleCloudVideointelligenceV1beta2TimestampedObject() {
  var o = api.GoogleCloudVideointelligenceV1beta2TimestampedObject();
  buildCounterGoogleCloudVideointelligenceV1beta2TimestampedObject++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2TimestampedObject < 3) {
    o.attributes = buildUnnamed6502();
    o.landmarks = buildUnnamed6503();
    o.normalizedBoundingBox =
        buildGoogleCloudVideointelligenceV1beta2NormalizedBoundingBox();
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1beta2TimestampedObject--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2TimestampedObject(
    api.GoogleCloudVideointelligenceV1beta2TimestampedObject o) {
  buildCounterGoogleCloudVideointelligenceV1beta2TimestampedObject++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2TimestampedObject < 3) {
    checkUnnamed6502(o.attributes!);
    checkUnnamed6503(o.landmarks!);
    checkGoogleCloudVideointelligenceV1beta2NormalizedBoundingBox(
        o.normalizedBoundingBox!
            as api.GoogleCloudVideointelligenceV1beta2NormalizedBoundingBox);
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1beta2TimestampedObject--;
}

core.List<api.GoogleCloudVideointelligenceV1beta2DetectedAttribute>
    buildUnnamed6504() {
  var o = <api.GoogleCloudVideointelligenceV1beta2DetectedAttribute>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2DetectedAttribute());
  o.add(buildGoogleCloudVideointelligenceV1beta2DetectedAttribute());
  return o;
}

void checkUnnamed6504(
    core.List<api.GoogleCloudVideointelligenceV1beta2DetectedAttribute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2DetectedAttribute(
      o[0] as api.GoogleCloudVideointelligenceV1beta2DetectedAttribute);
  checkGoogleCloudVideointelligenceV1beta2DetectedAttribute(
      o[1] as api.GoogleCloudVideointelligenceV1beta2DetectedAttribute);
}

core.List<api.GoogleCloudVideointelligenceV1beta2TimestampedObject>
    buildUnnamed6505() {
  var o = <api.GoogleCloudVideointelligenceV1beta2TimestampedObject>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2TimestampedObject());
  o.add(buildGoogleCloudVideointelligenceV1beta2TimestampedObject());
  return o;
}

void checkUnnamed6505(
    core.List<api.GoogleCloudVideointelligenceV1beta2TimestampedObject> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2TimestampedObject(
      o[0] as api.GoogleCloudVideointelligenceV1beta2TimestampedObject);
  checkGoogleCloudVideointelligenceV1beta2TimestampedObject(
      o[1] as api.GoogleCloudVideointelligenceV1beta2TimestampedObject);
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2Track = 0;
api.GoogleCloudVideointelligenceV1beta2Track
    buildGoogleCloudVideointelligenceV1beta2Track() {
  var o = api.GoogleCloudVideointelligenceV1beta2Track();
  buildCounterGoogleCloudVideointelligenceV1beta2Track++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2Track < 3) {
    o.attributes = buildUnnamed6504();
    o.confidence = 42.0;
    o.segment = buildGoogleCloudVideointelligenceV1beta2VideoSegment();
    o.timestampedObjects = buildUnnamed6505();
  }
  buildCounterGoogleCloudVideointelligenceV1beta2Track--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2Track(
    api.GoogleCloudVideointelligenceV1beta2Track o) {
  buildCounterGoogleCloudVideointelligenceV1beta2Track++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2Track < 3) {
    checkUnnamed6504(o.attributes!);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVideointelligenceV1beta2VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1beta2VideoSegment);
    checkUnnamed6505(o.timestampedObjects!);
  }
  buildCounterGoogleCloudVideointelligenceV1beta2Track--;
}

core.int
    buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress = 0;
api.GoogleCloudVideointelligenceV1beta2VideoAnnotationProgress
    buildGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress() {
  var o = api.GoogleCloudVideointelligenceV1beta2VideoAnnotationProgress();
  buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress <
      3) {
    o.feature = 'foo';
    o.inputUri = 'foo';
    o.progressPercent = 42;
    o.segment = buildGoogleCloudVideointelligenceV1beta2VideoSegment();
    o.startTime = 'foo';
    o.updateTime = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress(
    api.GoogleCloudVideointelligenceV1beta2VideoAnnotationProgress o) {
  buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress <
      3) {
    unittest.expect(
      o.feature!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.inputUri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.progressPercent!,
      unittest.equals(42),
    );
    checkGoogleCloudVideointelligenceV1beta2VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1beta2VideoSegment);
    unittest.expect(
      o.startTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.updateTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress--;
}

core.List<api.GoogleCloudVideointelligenceV1beta2FaceAnnotation>
    buildUnnamed6506() {
  var o = <api.GoogleCloudVideointelligenceV1beta2FaceAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2FaceAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1beta2FaceAnnotation());
  return o;
}

void checkUnnamed6506(
    core.List<api.GoogleCloudVideointelligenceV1beta2FaceAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2FaceAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1beta2FaceAnnotation);
  checkGoogleCloudVideointelligenceV1beta2FaceAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1beta2FaceAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation>
    buildUnnamed6507() {
  var o = <api.GoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation());
  return o;
}

void checkUnnamed6507(
    core.List<api.GoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation);
  checkGoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1beta2LabelAnnotation>
    buildUnnamed6508() {
  var o = <api.GoogleCloudVideointelligenceV1beta2LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1beta2LabelAnnotation());
  return o;
}

void checkUnnamed6508(
    core.List<api.GoogleCloudVideointelligenceV1beta2LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1beta2LabelAnnotation);
  checkGoogleCloudVideointelligenceV1beta2LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1beta2LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation>
    buildUnnamed6509() {
  var o = <api.GoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation());
  return o;
}

void checkUnnamed6509(
    core.List<api.GoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation);
  checkGoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation>
    buildUnnamed6510() {
  var o = <api.GoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation());
  return o;
}

void checkUnnamed6510(
    core.List<api.GoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation);
  checkGoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation>
    buildUnnamed6511() {
  var o = <api.GoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation());
  return o;
}

void checkUnnamed6511(
    core.List<api.GoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation);
  checkGoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1beta2LabelAnnotation>
    buildUnnamed6512() {
  var o = <api.GoogleCloudVideointelligenceV1beta2LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1beta2LabelAnnotation());
  return o;
}

void checkUnnamed6512(
    core.List<api.GoogleCloudVideointelligenceV1beta2LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1beta2LabelAnnotation);
  checkGoogleCloudVideointelligenceV1beta2LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1beta2LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1beta2LabelAnnotation>
    buildUnnamed6513() {
  var o = <api.GoogleCloudVideointelligenceV1beta2LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1beta2LabelAnnotation());
  return o;
}

void checkUnnamed6513(
    core.List<api.GoogleCloudVideointelligenceV1beta2LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1beta2LabelAnnotation);
  checkGoogleCloudVideointelligenceV1beta2LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1beta2LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1beta2VideoSegment>
    buildUnnamed6514() {
  var o = <api.GoogleCloudVideointelligenceV1beta2VideoSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2VideoSegment());
  o.add(buildGoogleCloudVideointelligenceV1beta2VideoSegment());
  return o;
}

void checkUnnamed6514(
    core.List<api.GoogleCloudVideointelligenceV1beta2VideoSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2VideoSegment(
      o[0] as api.GoogleCloudVideointelligenceV1beta2VideoSegment);
  checkGoogleCloudVideointelligenceV1beta2VideoSegment(
      o[1] as api.GoogleCloudVideointelligenceV1beta2VideoSegment);
}

core.List<api.GoogleCloudVideointelligenceV1beta2LabelAnnotation>
    buildUnnamed6515() {
  var o = <api.GoogleCloudVideointelligenceV1beta2LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1beta2LabelAnnotation());
  return o;
}

void checkUnnamed6515(
    core.List<api.GoogleCloudVideointelligenceV1beta2LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1beta2LabelAnnotation);
  checkGoogleCloudVideointelligenceV1beta2LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1beta2LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1beta2LabelAnnotation>
    buildUnnamed6516() {
  var o = <api.GoogleCloudVideointelligenceV1beta2LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1beta2LabelAnnotation());
  return o;
}

void checkUnnamed6516(
    core.List<api.GoogleCloudVideointelligenceV1beta2LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1beta2LabelAnnotation);
  checkGoogleCloudVideointelligenceV1beta2LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1beta2LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1beta2SpeechTranscription>
    buildUnnamed6517() {
  var o = <api.GoogleCloudVideointelligenceV1beta2SpeechTranscription>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2SpeechTranscription());
  o.add(buildGoogleCloudVideointelligenceV1beta2SpeechTranscription());
  return o;
}

void checkUnnamed6517(
    core.List<api.GoogleCloudVideointelligenceV1beta2SpeechTranscription> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2SpeechTranscription(
      o[0] as api.GoogleCloudVideointelligenceV1beta2SpeechTranscription);
  checkGoogleCloudVideointelligenceV1beta2SpeechTranscription(
      o[1] as api.GoogleCloudVideointelligenceV1beta2SpeechTranscription);
}

core.List<api.GoogleCloudVideointelligenceV1beta2TextAnnotation>
    buildUnnamed6518() {
  var o = <api.GoogleCloudVideointelligenceV1beta2TextAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1beta2TextAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1beta2TextAnnotation());
  return o;
}

void checkUnnamed6518(
    core.List<api.GoogleCloudVideointelligenceV1beta2TextAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1beta2TextAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1beta2TextAnnotation);
  checkGoogleCloudVideointelligenceV1beta2TextAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1beta2TextAnnotation);
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationResults =
    0;
api.GoogleCloudVideointelligenceV1beta2VideoAnnotationResults
    buildGoogleCloudVideointelligenceV1beta2VideoAnnotationResults() {
  var o = api.GoogleCloudVideointelligenceV1beta2VideoAnnotationResults();
  buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationResults++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationResults <
      3) {
    o.error = buildGoogleRpcStatus();
    o.explicitAnnotation =
        buildGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation();
    o.faceAnnotations = buildUnnamed6506();
    o.faceDetectionAnnotations = buildUnnamed6507();
    o.frameLabelAnnotations = buildUnnamed6508();
    o.inputUri = 'foo';
    o.logoRecognitionAnnotations = buildUnnamed6509();
    o.objectAnnotations = buildUnnamed6510();
    o.personDetectionAnnotations = buildUnnamed6511();
    o.segment = buildGoogleCloudVideointelligenceV1beta2VideoSegment();
    o.segmentLabelAnnotations = buildUnnamed6512();
    o.segmentPresenceLabelAnnotations = buildUnnamed6513();
    o.shotAnnotations = buildUnnamed6514();
    o.shotLabelAnnotations = buildUnnamed6515();
    o.shotPresenceLabelAnnotations = buildUnnamed6516();
    o.speechTranscriptions = buildUnnamed6517();
    o.textAnnotations = buildUnnamed6518();
  }
  buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationResults--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2VideoAnnotationResults(
    api.GoogleCloudVideointelligenceV1beta2VideoAnnotationResults o) {
  buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationResults++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationResults <
      3) {
    checkGoogleRpcStatus(o.error! as api.GoogleRpcStatus);
    checkGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation(o
            .explicitAnnotation!
        as api.GoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation);
    checkUnnamed6506(o.faceAnnotations!);
    checkUnnamed6507(o.faceDetectionAnnotations!);
    checkUnnamed6508(o.frameLabelAnnotations!);
    unittest.expect(
      o.inputUri!,
      unittest.equals('foo'),
    );
    checkUnnamed6509(o.logoRecognitionAnnotations!);
    checkUnnamed6510(o.objectAnnotations!);
    checkUnnamed6511(o.personDetectionAnnotations!);
    checkGoogleCloudVideointelligenceV1beta2VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1beta2VideoSegment);
    checkUnnamed6512(o.segmentLabelAnnotations!);
    checkUnnamed6513(o.segmentPresenceLabelAnnotations!);
    checkUnnamed6514(o.shotAnnotations!);
    checkUnnamed6515(o.shotLabelAnnotations!);
    checkUnnamed6516(o.shotPresenceLabelAnnotations!);
    checkUnnamed6517(o.speechTranscriptions!);
    checkUnnamed6518(o.textAnnotations!);
  }
  buildCounterGoogleCloudVideointelligenceV1beta2VideoAnnotationResults--;
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2VideoSegment = 0;
api.GoogleCloudVideointelligenceV1beta2VideoSegment
    buildGoogleCloudVideointelligenceV1beta2VideoSegment() {
  var o = api.GoogleCloudVideointelligenceV1beta2VideoSegment();
  buildCounterGoogleCloudVideointelligenceV1beta2VideoSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2VideoSegment < 3) {
    o.endTimeOffset = 'foo';
    o.startTimeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1beta2VideoSegment--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2VideoSegment(
    api.GoogleCloudVideointelligenceV1beta2VideoSegment o) {
  buildCounterGoogleCloudVideointelligenceV1beta2VideoSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2VideoSegment < 3) {
    unittest.expect(
      o.endTimeOffset!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.startTimeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1beta2VideoSegment--;
}

core.int buildCounterGoogleCloudVideointelligenceV1beta2WordInfo = 0;
api.GoogleCloudVideointelligenceV1beta2WordInfo
    buildGoogleCloudVideointelligenceV1beta2WordInfo() {
  var o = api.GoogleCloudVideointelligenceV1beta2WordInfo();
  buildCounterGoogleCloudVideointelligenceV1beta2WordInfo++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2WordInfo < 3) {
    o.confidence = 42.0;
    o.endTime = 'foo';
    o.speakerTag = 42;
    o.startTime = 'foo';
    o.word = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1beta2WordInfo--;
  return o;
}

void checkGoogleCloudVideointelligenceV1beta2WordInfo(
    api.GoogleCloudVideointelligenceV1beta2WordInfo o) {
  buildCounterGoogleCloudVideointelligenceV1beta2WordInfo++;
  if (buildCounterGoogleCloudVideointelligenceV1beta2WordInfo < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.endTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.speakerTag!,
      unittest.equals(42),
    );
    unittest.expect(
      o.startTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.word!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1beta2WordInfo--;
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress>
    buildUnnamed6519() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress());
  return o;
}

void checkUnnamed6519(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress);
  checkGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress = 0;
api.GoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress
    buildGoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress();
  buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress <
      3) {
    o.annotationProgress = buildUnnamed6519();
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress(
    api.GoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress <
      3) {
    checkUnnamed6519(o.annotationProgress!);
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress--;
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults>
    buildUnnamed6520() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults());
  return o;
}

void checkUnnamed6520(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults);
  checkGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse = 0;
api.GoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse
    buildGoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse();
  buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse <
      3) {
    o.annotationResults = buildUnnamed6520();
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse(
    api.GoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse <
      3) {
    checkUnnamed6520(o.annotationResults!);
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1DetectedAttribute = 0;
api.GoogleCloudVideointelligenceV1p1beta1DetectedAttribute
    buildGoogleCloudVideointelligenceV1p1beta1DetectedAttribute() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1DetectedAttribute();
  buildCounterGoogleCloudVideointelligenceV1p1beta1DetectedAttribute++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1DetectedAttribute < 3) {
    o.confidence = 42.0;
    o.name = 'foo';
    o.value = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1DetectedAttribute--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1DetectedAttribute(
    api.GoogleCloudVideointelligenceV1p1beta1DetectedAttribute o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1DetectedAttribute++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1DetectedAttribute < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1DetectedAttribute--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1DetectedLandmark = 0;
api.GoogleCloudVideointelligenceV1p1beta1DetectedLandmark
    buildGoogleCloudVideointelligenceV1p1beta1DetectedLandmark() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1DetectedLandmark();
  buildCounterGoogleCloudVideointelligenceV1p1beta1DetectedLandmark++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1DetectedLandmark < 3) {
    o.confidence = 42.0;
    o.name = 'foo';
    o.point = buildGoogleCloudVideointelligenceV1p1beta1NormalizedVertex();
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1DetectedLandmark--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1DetectedLandmark(
    api.GoogleCloudVideointelligenceV1p1beta1DetectedLandmark o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1DetectedLandmark++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1DetectedLandmark < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkGoogleCloudVideointelligenceV1p1beta1NormalizedVertex(
        o.point! as api.GoogleCloudVideointelligenceV1p1beta1NormalizedVertex);
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1DetectedLandmark--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1Entity = 0;
api.GoogleCloudVideointelligenceV1p1beta1Entity
    buildGoogleCloudVideointelligenceV1p1beta1Entity() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1Entity();
  buildCounterGoogleCloudVideointelligenceV1p1beta1Entity++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1Entity < 3) {
    o.description = 'foo';
    o.entityId = 'foo';
    o.languageCode = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1Entity--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1Entity(
    api.GoogleCloudVideointelligenceV1p1beta1Entity o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1Entity++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1Entity < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.entityId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1Entity--;
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame>
    buildUnnamed6521() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame());
  return o;
}

void checkUnnamed6521(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame);
  checkGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation =
    0;
api.GoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation
    buildGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation <
      3) {
    o.frames = buildUnnamed6521();
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation(
    api.GoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation <
      3) {
    checkUnnamed6521(o.frames!);
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame =
    0;
api.GoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame
    buildGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame();
  buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame <
      3) {
    o.pornographyLikelihood = 'foo';
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame(
    api.GoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame <
      3) {
    unittest.expect(
      o.pornographyLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame--;
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1FaceFrame>
    buildUnnamed6522() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1FaceFrame>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1FaceFrame());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1FaceFrame());
  return o;
}

void checkUnnamed6522(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1FaceFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1FaceFrame(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1FaceFrame);
  checkGoogleCloudVideointelligenceV1p1beta1FaceFrame(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1FaceFrame);
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1FaceSegment>
    buildUnnamed6523() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1FaceSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1FaceSegment());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1FaceSegment());
  return o;
}

void checkUnnamed6523(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1FaceSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1FaceSegment(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1FaceSegment);
  checkGoogleCloudVideointelligenceV1p1beta1FaceSegment(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1FaceSegment);
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1FaceAnnotation = 0;
api.GoogleCloudVideointelligenceV1p1beta1FaceAnnotation
    buildGoogleCloudVideointelligenceV1p1beta1FaceAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1FaceAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p1beta1FaceAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1FaceAnnotation < 3) {
    o.frames = buildUnnamed6522();
    o.segments = buildUnnamed6523();
    o.thumbnail = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1FaceAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1FaceAnnotation(
    api.GoogleCloudVideointelligenceV1p1beta1FaceAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1FaceAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1FaceAnnotation < 3) {
    checkUnnamed6522(o.frames!);
    checkUnnamed6523(o.segments!);
    unittest.expect(
      o.thumbnail!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1FaceAnnotation--;
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1Track> buildUnnamed6524() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1Track>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1Track());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1Track());
  return o;
}

void checkUnnamed6524(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1Track> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1Track(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1Track);
  checkGoogleCloudVideointelligenceV1p1beta1Track(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1Track);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation =
    0;
api.GoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation
    buildGoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation <
      3) {
    o.thumbnail = 'foo';
    o.tracks = buildUnnamed6524();
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation(
    api.GoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation <
      3) {
    unittest.expect(
      o.thumbnail!,
      unittest.equals('foo'),
    );
    checkUnnamed6524(o.tracks!);
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation--;
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox>
    buildUnnamed6525() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox());
  return o;
}

void checkUnnamed6525(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox);
  checkGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox);
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1FaceFrame = 0;
api.GoogleCloudVideointelligenceV1p1beta1FaceFrame
    buildGoogleCloudVideointelligenceV1p1beta1FaceFrame() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1FaceFrame();
  buildCounterGoogleCloudVideointelligenceV1p1beta1FaceFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1FaceFrame < 3) {
    o.normalizedBoundingBoxes = buildUnnamed6525();
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1FaceFrame--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1FaceFrame(
    api.GoogleCloudVideointelligenceV1p1beta1FaceFrame o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1FaceFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1FaceFrame < 3) {
    checkUnnamed6525(o.normalizedBoundingBoxes!);
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1FaceFrame--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1FaceSegment = 0;
api.GoogleCloudVideointelligenceV1p1beta1FaceSegment
    buildGoogleCloudVideointelligenceV1p1beta1FaceSegment() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1FaceSegment();
  buildCounterGoogleCloudVideointelligenceV1p1beta1FaceSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1FaceSegment < 3) {
    o.segment = buildGoogleCloudVideointelligenceV1p1beta1VideoSegment();
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1FaceSegment--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1FaceSegment(
    api.GoogleCloudVideointelligenceV1p1beta1FaceSegment o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1FaceSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1FaceSegment < 3) {
    checkGoogleCloudVideointelligenceV1p1beta1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1p1beta1VideoSegment);
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1FaceSegment--;
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1Entity> buildUnnamed6526() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1Entity>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1Entity());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1Entity());
  return o;
}

void checkUnnamed6526(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1Entity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1Entity(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1Entity);
  checkGoogleCloudVideointelligenceV1p1beta1Entity(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1Entity);
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1LabelFrame>
    buildUnnamed6527() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1LabelFrame>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LabelFrame());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LabelFrame());
  return o;
}

void checkUnnamed6527(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1LabelFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1LabelFrame(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1LabelFrame);
  checkGoogleCloudVideointelligenceV1p1beta1LabelFrame(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1LabelFrame);
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1LabelSegment>
    buildUnnamed6528() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1LabelSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LabelSegment());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LabelSegment());
  return o;
}

void checkUnnamed6528(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1LabelSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1LabelSegment(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1LabelSegment);
  checkGoogleCloudVideointelligenceV1p1beta1LabelSegment(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1LabelSegment);
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1LabelAnnotation = 0;
api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation
    buildGoogleCloudVideointelligenceV1p1beta1LabelAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p1beta1LabelAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1LabelAnnotation < 3) {
    o.categoryEntities = buildUnnamed6526();
    o.entity = buildGoogleCloudVideointelligenceV1p1beta1Entity();
    o.frames = buildUnnamed6527();
    o.segments = buildUnnamed6528();
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1LabelAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1LabelAnnotation(
    api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1LabelAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1LabelAnnotation < 3) {
    checkUnnamed6526(o.categoryEntities!);
    checkGoogleCloudVideointelligenceV1p1beta1Entity(
        o.entity! as api.GoogleCloudVideointelligenceV1p1beta1Entity);
    checkUnnamed6527(o.frames!);
    checkUnnamed6528(o.segments!);
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1LabelAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1LabelFrame = 0;
api.GoogleCloudVideointelligenceV1p1beta1LabelFrame
    buildGoogleCloudVideointelligenceV1p1beta1LabelFrame() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1LabelFrame();
  buildCounterGoogleCloudVideointelligenceV1p1beta1LabelFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1LabelFrame < 3) {
    o.confidence = 42.0;
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1LabelFrame--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1LabelFrame(
    api.GoogleCloudVideointelligenceV1p1beta1LabelFrame o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1LabelFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1LabelFrame < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1LabelFrame--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1LabelSegment = 0;
api.GoogleCloudVideointelligenceV1p1beta1LabelSegment
    buildGoogleCloudVideointelligenceV1p1beta1LabelSegment() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1LabelSegment();
  buildCounterGoogleCloudVideointelligenceV1p1beta1LabelSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1LabelSegment < 3) {
    o.confidence = 42.0;
    o.segment = buildGoogleCloudVideointelligenceV1p1beta1VideoSegment();
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1LabelSegment--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1LabelSegment(
    api.GoogleCloudVideointelligenceV1p1beta1LabelSegment o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1LabelSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1LabelSegment < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVideointelligenceV1p1beta1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1p1beta1VideoSegment);
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1LabelSegment--;
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1VideoSegment>
    buildUnnamed6529() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1VideoSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1VideoSegment());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1VideoSegment());
  return o;
}

void checkUnnamed6529(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1VideoSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1VideoSegment(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1VideoSegment);
  checkGoogleCloudVideointelligenceV1p1beta1VideoSegment(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1VideoSegment);
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1Track> buildUnnamed6530() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1Track>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1Track());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1Track());
  return o;
}

void checkUnnamed6530(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1Track> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1Track(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1Track);
  checkGoogleCloudVideointelligenceV1p1beta1Track(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1Track);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation =
    0;
api.GoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation
    buildGoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation <
      3) {
    o.entity = buildGoogleCloudVideointelligenceV1p1beta1Entity();
    o.segments = buildUnnamed6529();
    o.tracks = buildUnnamed6530();
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation(
    api.GoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation <
      3) {
    checkGoogleCloudVideointelligenceV1p1beta1Entity(
        o.entity! as api.GoogleCloudVideointelligenceV1p1beta1Entity);
    checkUnnamed6529(o.segments!);
    checkUnnamed6530(o.tracks!);
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation--;
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox = 0;
api.GoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox
    buildGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox();
  buildCounterGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox <
      3) {
    o.bottom = 42.0;
    o.left = 42.0;
    o.right = 42.0;
    o.top = 42.0;
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox(
    api.GoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox <
      3) {
    unittest.expect(
      o.bottom!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.left!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.right!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.top!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox--;
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1NormalizedVertex>
    buildUnnamed6531() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1NormalizedVertex>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1NormalizedVertex());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1NormalizedVertex());
  return o;
}

void checkUnnamed6531(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1NormalizedVertex> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1NormalizedVertex(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1NormalizedVertex);
  checkGoogleCloudVideointelligenceV1p1beta1NormalizedVertex(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1NormalizedVertex);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingPoly = 0;
api.GoogleCloudVideointelligenceV1p1beta1NormalizedBoundingPoly
    buildGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingPoly() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1NormalizedBoundingPoly();
  buildCounterGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingPoly++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingPoly <
      3) {
    o.vertices = buildUnnamed6531();
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingPoly--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingPoly(
    api.GoogleCloudVideointelligenceV1p1beta1NormalizedBoundingPoly o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingPoly++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingPoly <
      3) {
    checkUnnamed6531(o.vertices!);
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingPoly--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1NormalizedVertex = 0;
api.GoogleCloudVideointelligenceV1p1beta1NormalizedVertex
    buildGoogleCloudVideointelligenceV1p1beta1NormalizedVertex() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1NormalizedVertex();
  buildCounterGoogleCloudVideointelligenceV1p1beta1NormalizedVertex++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1NormalizedVertex < 3) {
    o.x = 42.0;
    o.y = 42.0;
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1NormalizedVertex--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1NormalizedVertex(
    api.GoogleCloudVideointelligenceV1p1beta1NormalizedVertex o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1NormalizedVertex++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1NormalizedVertex < 3) {
    unittest.expect(
      o.x!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.y!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1NormalizedVertex--;
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame>
    buildUnnamed6532() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame());
  return o;
}

void checkUnnamed6532(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame);
  checkGoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation =
    0;
api.GoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation
    buildGoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation <
      3) {
    o.confidence = 42.0;
    o.entity = buildGoogleCloudVideointelligenceV1p1beta1Entity();
    o.frames = buildUnnamed6532();
    o.segment = buildGoogleCloudVideointelligenceV1p1beta1VideoSegment();
    o.trackId = 'foo';
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation(
    api.GoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation <
      3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVideointelligenceV1p1beta1Entity(
        o.entity! as api.GoogleCloudVideointelligenceV1p1beta1Entity);
    checkUnnamed6532(o.frames!);
    checkGoogleCloudVideointelligenceV1p1beta1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1p1beta1VideoSegment);
    unittest.expect(
      o.trackId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame =
    0;
api.GoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame
    buildGoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame();
  buildCounterGoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame <
      3) {
    o.normalizedBoundingBox =
        buildGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox();
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame(
    api.GoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame <
      3) {
    checkGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox(
        o.normalizedBoundingBox!
            as api.GoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox);
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame--;
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1Track> buildUnnamed6533() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1Track>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1Track());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1Track());
  return o;
}

void checkUnnamed6533(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1Track> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1Track(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1Track);
  checkGoogleCloudVideointelligenceV1p1beta1Track(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1Track);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation =
    0;
api.GoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation
    buildGoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation <
      3) {
    o.tracks = buildUnnamed6533();
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation(
    api.GoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation <
      3) {
    checkUnnamed6533(o.tracks!);
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation--;
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1WordInfo>
    buildUnnamed6534() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1WordInfo>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1WordInfo());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1WordInfo());
  return o;
}

void checkUnnamed6534(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1WordInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1WordInfo(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1WordInfo);
  checkGoogleCloudVideointelligenceV1p1beta1WordInfo(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1WordInfo);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative =
    0;
api.GoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative
    buildGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative() {
  var o =
      api.GoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative();
  buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative <
      3) {
    o.confidence = 42.0;
    o.transcript = 'foo';
    o.words = buildUnnamed6534();
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative(
    api.GoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative <
      3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.transcript!,
      unittest.equals('foo'),
    );
    checkUnnamed6534(o.words!);
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative--;
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative>
    buildUnnamed6535() {
  var o =
      <api.GoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative>[];
  o.add(
      buildGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative());
  o.add(
      buildGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative());
  return o;
}

void checkUnnamed6535(
    core.List<
            api.GoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative(o[0]
      as api.GoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative);
  checkGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative(o[1]
      as api.GoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative);
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechTranscription =
    0;
api.GoogleCloudVideointelligenceV1p1beta1SpeechTranscription
    buildGoogleCloudVideointelligenceV1p1beta1SpeechTranscription() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1SpeechTranscription();
  buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechTranscription++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechTranscription <
      3) {
    o.alternatives = buildUnnamed6535();
    o.languageCode = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechTranscription--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1SpeechTranscription(
    api.GoogleCloudVideointelligenceV1p1beta1SpeechTranscription o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechTranscription++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechTranscription <
      3) {
    checkUnnamed6535(o.alternatives!);
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1SpeechTranscription--;
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1TextSegment>
    buildUnnamed6536() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1TextSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1TextSegment());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1TextSegment());
  return o;
}

void checkUnnamed6536(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1TextSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1TextSegment(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1TextSegment);
  checkGoogleCloudVideointelligenceV1p1beta1TextSegment(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1TextSegment);
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1TextAnnotation = 0;
api.GoogleCloudVideointelligenceV1p1beta1TextAnnotation
    buildGoogleCloudVideointelligenceV1p1beta1TextAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1TextAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p1beta1TextAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1TextAnnotation < 3) {
    o.segments = buildUnnamed6536();
    o.text = 'foo';
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1TextAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1TextAnnotation(
    api.GoogleCloudVideointelligenceV1p1beta1TextAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1TextAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1TextAnnotation < 3) {
    checkUnnamed6536(o.segments!);
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1TextAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1TextFrame = 0;
api.GoogleCloudVideointelligenceV1p1beta1TextFrame
    buildGoogleCloudVideointelligenceV1p1beta1TextFrame() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1TextFrame();
  buildCounterGoogleCloudVideointelligenceV1p1beta1TextFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1TextFrame < 3) {
    o.rotatedBoundingBox =
        buildGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingPoly();
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1TextFrame--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1TextFrame(
    api.GoogleCloudVideointelligenceV1p1beta1TextFrame o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1TextFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1TextFrame < 3) {
    checkGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingPoly(
        o.rotatedBoundingBox!
            as api.GoogleCloudVideointelligenceV1p1beta1NormalizedBoundingPoly);
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1TextFrame--;
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1TextFrame>
    buildUnnamed6537() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1TextFrame>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1TextFrame());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1TextFrame());
  return o;
}

void checkUnnamed6537(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1TextFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1TextFrame(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1TextFrame);
  checkGoogleCloudVideointelligenceV1p1beta1TextFrame(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1TextFrame);
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1TextSegment = 0;
api.GoogleCloudVideointelligenceV1p1beta1TextSegment
    buildGoogleCloudVideointelligenceV1p1beta1TextSegment() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1TextSegment();
  buildCounterGoogleCloudVideointelligenceV1p1beta1TextSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1TextSegment < 3) {
    o.confidence = 42.0;
    o.frames = buildUnnamed6537();
    o.segment = buildGoogleCloudVideointelligenceV1p1beta1VideoSegment();
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1TextSegment--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1TextSegment(
    api.GoogleCloudVideointelligenceV1p1beta1TextSegment o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1TextSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1TextSegment < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkUnnamed6537(o.frames!);
    checkGoogleCloudVideointelligenceV1p1beta1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1p1beta1VideoSegment);
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1TextSegment--;
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1DetectedAttribute>
    buildUnnamed6538() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1DetectedAttribute>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1DetectedAttribute());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1DetectedAttribute());
  return o;
}

void checkUnnamed6538(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1DetectedAttribute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1DetectedAttribute(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1DetectedAttribute);
  checkGoogleCloudVideointelligenceV1p1beta1DetectedAttribute(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1DetectedAttribute);
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1DetectedLandmark>
    buildUnnamed6539() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1DetectedLandmark>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1DetectedLandmark());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1DetectedLandmark());
  return o;
}

void checkUnnamed6539(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1DetectedLandmark> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1DetectedLandmark(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1DetectedLandmark);
  checkGoogleCloudVideointelligenceV1p1beta1DetectedLandmark(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1DetectedLandmark);
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1TimestampedObject = 0;
api.GoogleCloudVideointelligenceV1p1beta1TimestampedObject
    buildGoogleCloudVideointelligenceV1p1beta1TimestampedObject() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1TimestampedObject();
  buildCounterGoogleCloudVideointelligenceV1p1beta1TimestampedObject++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1TimestampedObject < 3) {
    o.attributes = buildUnnamed6538();
    o.landmarks = buildUnnamed6539();
    o.normalizedBoundingBox =
        buildGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox();
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1TimestampedObject--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1TimestampedObject(
    api.GoogleCloudVideointelligenceV1p1beta1TimestampedObject o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1TimestampedObject++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1TimestampedObject < 3) {
    checkUnnamed6538(o.attributes!);
    checkUnnamed6539(o.landmarks!);
    checkGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox(
        o.normalizedBoundingBox!
            as api.GoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox);
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1TimestampedObject--;
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1DetectedAttribute>
    buildUnnamed6540() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1DetectedAttribute>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1DetectedAttribute());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1DetectedAttribute());
  return o;
}

void checkUnnamed6540(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1DetectedAttribute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1DetectedAttribute(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1DetectedAttribute);
  checkGoogleCloudVideointelligenceV1p1beta1DetectedAttribute(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1DetectedAttribute);
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1TimestampedObject>
    buildUnnamed6541() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1TimestampedObject>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1TimestampedObject());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1TimestampedObject());
  return o;
}

void checkUnnamed6541(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1TimestampedObject> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1TimestampedObject(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1TimestampedObject);
  checkGoogleCloudVideointelligenceV1p1beta1TimestampedObject(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1TimestampedObject);
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1Track = 0;
api.GoogleCloudVideointelligenceV1p1beta1Track
    buildGoogleCloudVideointelligenceV1p1beta1Track() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1Track();
  buildCounterGoogleCloudVideointelligenceV1p1beta1Track++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1Track < 3) {
    o.attributes = buildUnnamed6540();
    o.confidence = 42.0;
    o.segment = buildGoogleCloudVideointelligenceV1p1beta1VideoSegment();
    o.timestampedObjects = buildUnnamed6541();
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1Track--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1Track(
    api.GoogleCloudVideointelligenceV1p1beta1Track o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1Track++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1Track < 3) {
    checkUnnamed6540(o.attributes!);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVideointelligenceV1p1beta1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1p1beta1VideoSegment);
    checkUnnamed6541(o.timestampedObjects!);
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1Track--;
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress =
    0;
api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress
    buildGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress();
  buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress <
      3) {
    o.feature = 'foo';
    o.inputUri = 'foo';
    o.progressPercent = 42;
    o.segment = buildGoogleCloudVideointelligenceV1p1beta1VideoSegment();
    o.startTime = 'foo';
    o.updateTime = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress(
    api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress <
      3) {
    unittest.expect(
      o.feature!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.inputUri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.progressPercent!,
      unittest.equals(42),
    );
    checkGoogleCloudVideointelligenceV1p1beta1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1p1beta1VideoSegment);
    unittest.expect(
      o.startTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.updateTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress--;
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1FaceAnnotation>
    buildUnnamed6542() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1FaceAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1FaceAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1FaceAnnotation());
  return o;
}

void checkUnnamed6542(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1FaceAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1FaceAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1FaceAnnotation);
  checkGoogleCloudVideointelligenceV1p1beta1FaceAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1FaceAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation>
    buildUnnamed6543() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation());
  return o;
}

void checkUnnamed6543(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation);
  checkGoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation>
    buildUnnamed6544() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LabelAnnotation());
  return o;
}

void checkUnnamed6544(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation);
  checkGoogleCloudVideointelligenceV1p1beta1LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation>
    buildUnnamed6545() {
  var o =
      <api.GoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation());
  return o;
}

void checkUnnamed6545(
    core.List<
            api.GoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation(o[0]
      as api.GoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation);
  checkGoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation(o[1]
      as api.GoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation>
    buildUnnamed6546() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation());
  return o;
}

void checkUnnamed6546(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation(o[0]
      as api.GoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation);
  checkGoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation(o[1]
      as api.GoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation>
    buildUnnamed6547() {
  var o =
      <api.GoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation());
  return o;
}

void checkUnnamed6547(
    core.List<
            api.GoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation(o[0]
      as api.GoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation);
  checkGoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation(o[1]
      as api.GoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation>
    buildUnnamed6548() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LabelAnnotation());
  return o;
}

void checkUnnamed6548(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation);
  checkGoogleCloudVideointelligenceV1p1beta1LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation>
    buildUnnamed6549() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LabelAnnotation());
  return o;
}

void checkUnnamed6549(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation);
  checkGoogleCloudVideointelligenceV1p1beta1LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1VideoSegment>
    buildUnnamed6550() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1VideoSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1VideoSegment());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1VideoSegment());
  return o;
}

void checkUnnamed6550(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1VideoSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1VideoSegment(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1VideoSegment);
  checkGoogleCloudVideointelligenceV1p1beta1VideoSegment(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1VideoSegment);
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation>
    buildUnnamed6551() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LabelAnnotation());
  return o;
}

void checkUnnamed6551(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation);
  checkGoogleCloudVideointelligenceV1p1beta1LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation>
    buildUnnamed6552() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1LabelAnnotation());
  return o;
}

void checkUnnamed6552(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation);
  checkGoogleCloudVideointelligenceV1p1beta1LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1SpeechTranscription>
    buildUnnamed6553() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1SpeechTranscription>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1SpeechTranscription());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1SpeechTranscription());
  return o;
}

void checkUnnamed6553(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1SpeechTranscription> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1SpeechTranscription(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1SpeechTranscription);
  checkGoogleCloudVideointelligenceV1p1beta1SpeechTranscription(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1SpeechTranscription);
}

core.List<api.GoogleCloudVideointelligenceV1p1beta1TextAnnotation>
    buildUnnamed6554() {
  var o = <api.GoogleCloudVideointelligenceV1p1beta1TextAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p1beta1TextAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p1beta1TextAnnotation());
  return o;
}

void checkUnnamed6554(
    core.List<api.GoogleCloudVideointelligenceV1p1beta1TextAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p1beta1TextAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1p1beta1TextAnnotation);
  checkGoogleCloudVideointelligenceV1p1beta1TextAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1p1beta1TextAnnotation);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults = 0;
api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults
    buildGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults();
  buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults <
      3) {
    o.error = buildGoogleRpcStatus();
    o.explicitAnnotation =
        buildGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation();
    o.faceAnnotations = buildUnnamed6542();
    o.faceDetectionAnnotations = buildUnnamed6543();
    o.frameLabelAnnotations = buildUnnamed6544();
    o.inputUri = 'foo';
    o.logoRecognitionAnnotations = buildUnnamed6545();
    o.objectAnnotations = buildUnnamed6546();
    o.personDetectionAnnotations = buildUnnamed6547();
    o.segment = buildGoogleCloudVideointelligenceV1p1beta1VideoSegment();
    o.segmentLabelAnnotations = buildUnnamed6548();
    o.segmentPresenceLabelAnnotations = buildUnnamed6549();
    o.shotAnnotations = buildUnnamed6550();
    o.shotLabelAnnotations = buildUnnamed6551();
    o.shotPresenceLabelAnnotations = buildUnnamed6552();
    o.speechTranscriptions = buildUnnamed6553();
    o.textAnnotations = buildUnnamed6554();
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults(
    api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults <
      3) {
    checkGoogleRpcStatus(o.error! as api.GoogleRpcStatus);
    checkGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation(o
            .explicitAnnotation!
        as api.GoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation);
    checkUnnamed6542(o.faceAnnotations!);
    checkUnnamed6543(o.faceDetectionAnnotations!);
    checkUnnamed6544(o.frameLabelAnnotations!);
    unittest.expect(
      o.inputUri!,
      unittest.equals('foo'),
    );
    checkUnnamed6545(o.logoRecognitionAnnotations!);
    checkUnnamed6546(o.objectAnnotations!);
    checkUnnamed6547(o.personDetectionAnnotations!);
    checkGoogleCloudVideointelligenceV1p1beta1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1p1beta1VideoSegment);
    checkUnnamed6548(o.segmentLabelAnnotations!);
    checkUnnamed6549(o.segmentPresenceLabelAnnotations!);
    checkUnnamed6550(o.shotAnnotations!);
    checkUnnamed6551(o.shotLabelAnnotations!);
    checkUnnamed6552(o.shotPresenceLabelAnnotations!);
    checkUnnamed6553(o.speechTranscriptions!);
    checkUnnamed6554(o.textAnnotations!);
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1VideoSegment = 0;
api.GoogleCloudVideointelligenceV1p1beta1VideoSegment
    buildGoogleCloudVideointelligenceV1p1beta1VideoSegment() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1VideoSegment();
  buildCounterGoogleCloudVideointelligenceV1p1beta1VideoSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1VideoSegment < 3) {
    o.endTimeOffset = 'foo';
    o.startTimeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1VideoSegment--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1VideoSegment(
    api.GoogleCloudVideointelligenceV1p1beta1VideoSegment o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1VideoSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1VideoSegment < 3) {
    unittest.expect(
      o.endTimeOffset!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.startTimeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1VideoSegment--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p1beta1WordInfo = 0;
api.GoogleCloudVideointelligenceV1p1beta1WordInfo
    buildGoogleCloudVideointelligenceV1p1beta1WordInfo() {
  var o = api.GoogleCloudVideointelligenceV1p1beta1WordInfo();
  buildCounterGoogleCloudVideointelligenceV1p1beta1WordInfo++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1WordInfo < 3) {
    o.confidence = 42.0;
    o.endTime = 'foo';
    o.speakerTag = 42;
    o.startTime = 'foo';
    o.word = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1WordInfo--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p1beta1WordInfo(
    api.GoogleCloudVideointelligenceV1p1beta1WordInfo o) {
  buildCounterGoogleCloudVideointelligenceV1p1beta1WordInfo++;
  if (buildCounterGoogleCloudVideointelligenceV1p1beta1WordInfo < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.endTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.speakerTag!,
      unittest.equals(42),
    );
    unittest.expect(
      o.startTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.word!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p1beta1WordInfo--;
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress>
    buildUnnamed6555() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress());
  return o;
}

void checkUnnamed6555(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress);
  checkGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress = 0;
api.GoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress
    buildGoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress();
  buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress <
      3) {
    o.annotationProgress = buildUnnamed6555();
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress(
    api.GoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress <
      3) {
    checkUnnamed6555(o.annotationProgress!);
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress--;
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults>
    buildUnnamed6556() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults());
  return o;
}

void checkUnnamed6556(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults);
  checkGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse = 0;
api.GoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse
    buildGoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse();
  buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse <
      3) {
    o.annotationResults = buildUnnamed6556();
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse(
    api.GoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse <
      3) {
    checkUnnamed6556(o.annotationResults!);
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1DetectedAttribute = 0;
api.GoogleCloudVideointelligenceV1p2beta1DetectedAttribute
    buildGoogleCloudVideointelligenceV1p2beta1DetectedAttribute() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1DetectedAttribute();
  buildCounterGoogleCloudVideointelligenceV1p2beta1DetectedAttribute++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1DetectedAttribute < 3) {
    o.confidence = 42.0;
    o.name = 'foo';
    o.value = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1DetectedAttribute--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1DetectedAttribute(
    api.GoogleCloudVideointelligenceV1p2beta1DetectedAttribute o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1DetectedAttribute++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1DetectedAttribute < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1DetectedAttribute--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1DetectedLandmark = 0;
api.GoogleCloudVideointelligenceV1p2beta1DetectedLandmark
    buildGoogleCloudVideointelligenceV1p2beta1DetectedLandmark() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1DetectedLandmark();
  buildCounterGoogleCloudVideointelligenceV1p2beta1DetectedLandmark++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1DetectedLandmark < 3) {
    o.confidence = 42.0;
    o.name = 'foo';
    o.point = buildGoogleCloudVideointelligenceV1p2beta1NormalizedVertex();
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1DetectedLandmark--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1DetectedLandmark(
    api.GoogleCloudVideointelligenceV1p2beta1DetectedLandmark o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1DetectedLandmark++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1DetectedLandmark < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkGoogleCloudVideointelligenceV1p2beta1NormalizedVertex(
        o.point! as api.GoogleCloudVideointelligenceV1p2beta1NormalizedVertex);
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1DetectedLandmark--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1Entity = 0;
api.GoogleCloudVideointelligenceV1p2beta1Entity
    buildGoogleCloudVideointelligenceV1p2beta1Entity() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1Entity();
  buildCounterGoogleCloudVideointelligenceV1p2beta1Entity++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1Entity < 3) {
    o.description = 'foo';
    o.entityId = 'foo';
    o.languageCode = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1Entity--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1Entity(
    api.GoogleCloudVideointelligenceV1p2beta1Entity o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1Entity++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1Entity < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.entityId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1Entity--;
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame>
    buildUnnamed6557() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame());
  return o;
}

void checkUnnamed6557(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame);
  checkGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation =
    0;
api.GoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation
    buildGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation <
      3) {
    o.frames = buildUnnamed6557();
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation(
    api.GoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation <
      3) {
    checkUnnamed6557(o.frames!);
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame =
    0;
api.GoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame
    buildGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame();
  buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame <
      3) {
    o.pornographyLikelihood = 'foo';
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame(
    api.GoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame <
      3) {
    unittest.expect(
      o.pornographyLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame--;
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1FaceFrame>
    buildUnnamed6558() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1FaceFrame>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1FaceFrame());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1FaceFrame());
  return o;
}

void checkUnnamed6558(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1FaceFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1FaceFrame(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1FaceFrame);
  checkGoogleCloudVideointelligenceV1p2beta1FaceFrame(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1FaceFrame);
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1FaceSegment>
    buildUnnamed6559() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1FaceSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1FaceSegment());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1FaceSegment());
  return o;
}

void checkUnnamed6559(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1FaceSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1FaceSegment(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1FaceSegment);
  checkGoogleCloudVideointelligenceV1p2beta1FaceSegment(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1FaceSegment);
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1FaceAnnotation = 0;
api.GoogleCloudVideointelligenceV1p2beta1FaceAnnotation
    buildGoogleCloudVideointelligenceV1p2beta1FaceAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1FaceAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p2beta1FaceAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1FaceAnnotation < 3) {
    o.frames = buildUnnamed6558();
    o.segments = buildUnnamed6559();
    o.thumbnail = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1FaceAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1FaceAnnotation(
    api.GoogleCloudVideointelligenceV1p2beta1FaceAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1FaceAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1FaceAnnotation < 3) {
    checkUnnamed6558(o.frames!);
    checkUnnamed6559(o.segments!);
    unittest.expect(
      o.thumbnail!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1FaceAnnotation--;
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1Track> buildUnnamed6560() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1Track>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1Track());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1Track());
  return o;
}

void checkUnnamed6560(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1Track> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1Track(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1Track);
  checkGoogleCloudVideointelligenceV1p2beta1Track(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1Track);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation =
    0;
api.GoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation
    buildGoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation <
      3) {
    o.thumbnail = 'foo';
    o.tracks = buildUnnamed6560();
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation(
    api.GoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation <
      3) {
    unittest.expect(
      o.thumbnail!,
      unittest.equals('foo'),
    );
    checkUnnamed6560(o.tracks!);
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation--;
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox>
    buildUnnamed6561() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox());
  return o;
}

void checkUnnamed6561(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox);
  checkGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox);
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1FaceFrame = 0;
api.GoogleCloudVideointelligenceV1p2beta1FaceFrame
    buildGoogleCloudVideointelligenceV1p2beta1FaceFrame() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1FaceFrame();
  buildCounterGoogleCloudVideointelligenceV1p2beta1FaceFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1FaceFrame < 3) {
    o.normalizedBoundingBoxes = buildUnnamed6561();
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1FaceFrame--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1FaceFrame(
    api.GoogleCloudVideointelligenceV1p2beta1FaceFrame o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1FaceFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1FaceFrame < 3) {
    checkUnnamed6561(o.normalizedBoundingBoxes!);
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1FaceFrame--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1FaceSegment = 0;
api.GoogleCloudVideointelligenceV1p2beta1FaceSegment
    buildGoogleCloudVideointelligenceV1p2beta1FaceSegment() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1FaceSegment();
  buildCounterGoogleCloudVideointelligenceV1p2beta1FaceSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1FaceSegment < 3) {
    o.segment = buildGoogleCloudVideointelligenceV1p2beta1VideoSegment();
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1FaceSegment--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1FaceSegment(
    api.GoogleCloudVideointelligenceV1p2beta1FaceSegment o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1FaceSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1FaceSegment < 3) {
    checkGoogleCloudVideointelligenceV1p2beta1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1p2beta1VideoSegment);
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1FaceSegment--;
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1Entity> buildUnnamed6562() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1Entity>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1Entity());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1Entity());
  return o;
}

void checkUnnamed6562(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1Entity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1Entity(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1Entity);
  checkGoogleCloudVideointelligenceV1p2beta1Entity(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1Entity);
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1LabelFrame>
    buildUnnamed6563() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1LabelFrame>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LabelFrame());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LabelFrame());
  return o;
}

void checkUnnamed6563(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1LabelFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1LabelFrame(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1LabelFrame);
  checkGoogleCloudVideointelligenceV1p2beta1LabelFrame(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1LabelFrame);
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1LabelSegment>
    buildUnnamed6564() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1LabelSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LabelSegment());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LabelSegment());
  return o;
}

void checkUnnamed6564(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1LabelSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1LabelSegment(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1LabelSegment);
  checkGoogleCloudVideointelligenceV1p2beta1LabelSegment(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1LabelSegment);
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1LabelAnnotation = 0;
api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation
    buildGoogleCloudVideointelligenceV1p2beta1LabelAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p2beta1LabelAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1LabelAnnotation < 3) {
    o.categoryEntities = buildUnnamed6562();
    o.entity = buildGoogleCloudVideointelligenceV1p2beta1Entity();
    o.frames = buildUnnamed6563();
    o.segments = buildUnnamed6564();
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1LabelAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1LabelAnnotation(
    api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1LabelAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1LabelAnnotation < 3) {
    checkUnnamed6562(o.categoryEntities!);
    checkGoogleCloudVideointelligenceV1p2beta1Entity(
        o.entity! as api.GoogleCloudVideointelligenceV1p2beta1Entity);
    checkUnnamed6563(o.frames!);
    checkUnnamed6564(o.segments!);
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1LabelAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1LabelFrame = 0;
api.GoogleCloudVideointelligenceV1p2beta1LabelFrame
    buildGoogleCloudVideointelligenceV1p2beta1LabelFrame() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1LabelFrame();
  buildCounterGoogleCloudVideointelligenceV1p2beta1LabelFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1LabelFrame < 3) {
    o.confidence = 42.0;
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1LabelFrame--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1LabelFrame(
    api.GoogleCloudVideointelligenceV1p2beta1LabelFrame o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1LabelFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1LabelFrame < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1LabelFrame--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1LabelSegment = 0;
api.GoogleCloudVideointelligenceV1p2beta1LabelSegment
    buildGoogleCloudVideointelligenceV1p2beta1LabelSegment() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1LabelSegment();
  buildCounterGoogleCloudVideointelligenceV1p2beta1LabelSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1LabelSegment < 3) {
    o.confidence = 42.0;
    o.segment = buildGoogleCloudVideointelligenceV1p2beta1VideoSegment();
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1LabelSegment--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1LabelSegment(
    api.GoogleCloudVideointelligenceV1p2beta1LabelSegment o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1LabelSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1LabelSegment < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVideointelligenceV1p2beta1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1p2beta1VideoSegment);
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1LabelSegment--;
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1VideoSegment>
    buildUnnamed6565() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1VideoSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1VideoSegment());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1VideoSegment());
  return o;
}

void checkUnnamed6565(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1VideoSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1VideoSegment(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1VideoSegment);
  checkGoogleCloudVideointelligenceV1p2beta1VideoSegment(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1VideoSegment);
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1Track> buildUnnamed6566() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1Track>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1Track());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1Track());
  return o;
}

void checkUnnamed6566(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1Track> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1Track(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1Track);
  checkGoogleCloudVideointelligenceV1p2beta1Track(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1Track);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation =
    0;
api.GoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation
    buildGoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation <
      3) {
    o.entity = buildGoogleCloudVideointelligenceV1p2beta1Entity();
    o.segments = buildUnnamed6565();
    o.tracks = buildUnnamed6566();
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation(
    api.GoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation <
      3) {
    checkGoogleCloudVideointelligenceV1p2beta1Entity(
        o.entity! as api.GoogleCloudVideointelligenceV1p2beta1Entity);
    checkUnnamed6565(o.segments!);
    checkUnnamed6566(o.tracks!);
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation--;
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox = 0;
api.GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox
    buildGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox();
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

void checkGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox(
    api.GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox <
      3) {
    unittest.expect(
      o.bottom!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.left!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.right!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.top!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox--;
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1NormalizedVertex>
    buildUnnamed6567() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1NormalizedVertex>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1NormalizedVertex());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1NormalizedVertex());
  return o;
}

void checkUnnamed6567(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1NormalizedVertex> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1NormalizedVertex(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1NormalizedVertex);
  checkGoogleCloudVideointelligenceV1p2beta1NormalizedVertex(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1NormalizedVertex);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly = 0;
api.GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly
    buildGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly();
  buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly <
      3) {
    o.vertices = buildUnnamed6567();
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly(
    api.GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly <
      3) {
    checkUnnamed6567(o.vertices!);
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedVertex = 0;
api.GoogleCloudVideointelligenceV1p2beta1NormalizedVertex
    buildGoogleCloudVideointelligenceV1p2beta1NormalizedVertex() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1NormalizedVertex();
  buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedVertex++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedVertex < 3) {
    o.x = 42.0;
    o.y = 42.0;
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedVertex--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1NormalizedVertex(
    api.GoogleCloudVideointelligenceV1p2beta1NormalizedVertex o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedVertex++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedVertex < 3) {
    unittest.expect(
      o.x!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.y!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1NormalizedVertex--;
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame>
    buildUnnamed6568() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame());
  return o;
}

void checkUnnamed6568(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame);
  checkGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation =
    0;
api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation
    buildGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation <
      3) {
    o.confidence = 42.0;
    o.entity = buildGoogleCloudVideointelligenceV1p2beta1Entity();
    o.frames = buildUnnamed6568();
    o.segment = buildGoogleCloudVideointelligenceV1p2beta1VideoSegment();
    o.trackId = 'foo';
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation(
    api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation <
      3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVideointelligenceV1p2beta1Entity(
        o.entity! as api.GoogleCloudVideointelligenceV1p2beta1Entity);
    checkUnnamed6568(o.frames!);
    checkGoogleCloudVideointelligenceV1p2beta1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1p2beta1VideoSegment);
    unittest.expect(
      o.trackId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame =
    0;
api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame
    buildGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame();
  buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame <
      3) {
    o.normalizedBoundingBox =
        buildGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox();
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame(
    api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame <
      3) {
    checkGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox(
        o.normalizedBoundingBox!
            as api.GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox);
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame--;
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1Track> buildUnnamed6569() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1Track>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1Track());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1Track());
  return o;
}

void checkUnnamed6569(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1Track> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1Track(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1Track);
  checkGoogleCloudVideointelligenceV1p2beta1Track(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1Track);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation =
    0;
api.GoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation
    buildGoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation <
      3) {
    o.tracks = buildUnnamed6569();
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation(
    api.GoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation <
      3) {
    checkUnnamed6569(o.tracks!);
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation--;
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1WordInfo>
    buildUnnamed6570() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1WordInfo>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1WordInfo());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1WordInfo());
  return o;
}

void checkUnnamed6570(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1WordInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1WordInfo(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1WordInfo);
  checkGoogleCloudVideointelligenceV1p2beta1WordInfo(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1WordInfo);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative =
    0;
api.GoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative
    buildGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative() {
  var o =
      api.GoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative();
  buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative <
      3) {
    o.confidence = 42.0;
    o.transcript = 'foo';
    o.words = buildUnnamed6570();
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative(
    api.GoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative <
      3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.transcript!,
      unittest.equals('foo'),
    );
    checkUnnamed6570(o.words!);
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative--;
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative>
    buildUnnamed6571() {
  var o =
      <api.GoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative>[];
  o.add(
      buildGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative());
  o.add(
      buildGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative());
  return o;
}

void checkUnnamed6571(
    core.List<
            api.GoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative(o[0]
      as api.GoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative);
  checkGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative(o[1]
      as api.GoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative);
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechTranscription =
    0;
api.GoogleCloudVideointelligenceV1p2beta1SpeechTranscription
    buildGoogleCloudVideointelligenceV1p2beta1SpeechTranscription() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1SpeechTranscription();
  buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechTranscription++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechTranscription <
      3) {
    o.alternatives = buildUnnamed6571();
    o.languageCode = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechTranscription--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1SpeechTranscription(
    api.GoogleCloudVideointelligenceV1p2beta1SpeechTranscription o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechTranscription++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechTranscription <
      3) {
    checkUnnamed6571(o.alternatives!);
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1SpeechTranscription--;
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1TextSegment>
    buildUnnamed6572() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1TextSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1TextSegment());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1TextSegment());
  return o;
}

void checkUnnamed6572(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1TextSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1TextSegment(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1TextSegment);
  checkGoogleCloudVideointelligenceV1p2beta1TextSegment(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1TextSegment);
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1TextAnnotation = 0;
api.GoogleCloudVideointelligenceV1p2beta1TextAnnotation
    buildGoogleCloudVideointelligenceV1p2beta1TextAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1TextAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p2beta1TextAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1TextAnnotation < 3) {
    o.segments = buildUnnamed6572();
    o.text = 'foo';
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1TextAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1TextAnnotation(
    api.GoogleCloudVideointelligenceV1p2beta1TextAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1TextAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1TextAnnotation < 3) {
    checkUnnamed6572(o.segments!);
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1TextAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1TextFrame = 0;
api.GoogleCloudVideointelligenceV1p2beta1TextFrame
    buildGoogleCloudVideointelligenceV1p2beta1TextFrame() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1TextFrame();
  buildCounterGoogleCloudVideointelligenceV1p2beta1TextFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1TextFrame < 3) {
    o.rotatedBoundingBox =
        buildGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly();
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1TextFrame--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1TextFrame(
    api.GoogleCloudVideointelligenceV1p2beta1TextFrame o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1TextFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1TextFrame < 3) {
    checkGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly(
        o.rotatedBoundingBox!
            as api.GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly);
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1TextFrame--;
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1TextFrame>
    buildUnnamed6573() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1TextFrame>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1TextFrame());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1TextFrame());
  return o;
}

void checkUnnamed6573(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1TextFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1TextFrame(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1TextFrame);
  checkGoogleCloudVideointelligenceV1p2beta1TextFrame(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1TextFrame);
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1TextSegment = 0;
api.GoogleCloudVideointelligenceV1p2beta1TextSegment
    buildGoogleCloudVideointelligenceV1p2beta1TextSegment() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1TextSegment();
  buildCounterGoogleCloudVideointelligenceV1p2beta1TextSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1TextSegment < 3) {
    o.confidence = 42.0;
    o.frames = buildUnnamed6573();
    o.segment = buildGoogleCloudVideointelligenceV1p2beta1VideoSegment();
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1TextSegment--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1TextSegment(
    api.GoogleCloudVideointelligenceV1p2beta1TextSegment o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1TextSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1TextSegment < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkUnnamed6573(o.frames!);
    checkGoogleCloudVideointelligenceV1p2beta1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1p2beta1VideoSegment);
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1TextSegment--;
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1DetectedAttribute>
    buildUnnamed6574() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1DetectedAttribute>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1DetectedAttribute());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1DetectedAttribute());
  return o;
}

void checkUnnamed6574(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1DetectedAttribute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1DetectedAttribute(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1DetectedAttribute);
  checkGoogleCloudVideointelligenceV1p2beta1DetectedAttribute(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1DetectedAttribute);
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1DetectedLandmark>
    buildUnnamed6575() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1DetectedLandmark>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1DetectedLandmark());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1DetectedLandmark());
  return o;
}

void checkUnnamed6575(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1DetectedLandmark> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1DetectedLandmark(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1DetectedLandmark);
  checkGoogleCloudVideointelligenceV1p2beta1DetectedLandmark(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1DetectedLandmark);
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1TimestampedObject = 0;
api.GoogleCloudVideointelligenceV1p2beta1TimestampedObject
    buildGoogleCloudVideointelligenceV1p2beta1TimestampedObject() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1TimestampedObject();
  buildCounterGoogleCloudVideointelligenceV1p2beta1TimestampedObject++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1TimestampedObject < 3) {
    o.attributes = buildUnnamed6574();
    o.landmarks = buildUnnamed6575();
    o.normalizedBoundingBox =
        buildGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox();
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1TimestampedObject--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1TimestampedObject(
    api.GoogleCloudVideointelligenceV1p2beta1TimestampedObject o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1TimestampedObject++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1TimestampedObject < 3) {
    checkUnnamed6574(o.attributes!);
    checkUnnamed6575(o.landmarks!);
    checkGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox(
        o.normalizedBoundingBox!
            as api.GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox);
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1TimestampedObject--;
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1DetectedAttribute>
    buildUnnamed6576() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1DetectedAttribute>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1DetectedAttribute());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1DetectedAttribute());
  return o;
}

void checkUnnamed6576(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1DetectedAttribute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1DetectedAttribute(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1DetectedAttribute);
  checkGoogleCloudVideointelligenceV1p2beta1DetectedAttribute(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1DetectedAttribute);
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1TimestampedObject>
    buildUnnamed6577() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1TimestampedObject>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1TimestampedObject());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1TimestampedObject());
  return o;
}

void checkUnnamed6577(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1TimestampedObject> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1TimestampedObject(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1TimestampedObject);
  checkGoogleCloudVideointelligenceV1p2beta1TimestampedObject(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1TimestampedObject);
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1Track = 0;
api.GoogleCloudVideointelligenceV1p2beta1Track
    buildGoogleCloudVideointelligenceV1p2beta1Track() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1Track();
  buildCounterGoogleCloudVideointelligenceV1p2beta1Track++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1Track < 3) {
    o.attributes = buildUnnamed6576();
    o.confidence = 42.0;
    o.segment = buildGoogleCloudVideointelligenceV1p2beta1VideoSegment();
    o.timestampedObjects = buildUnnamed6577();
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1Track--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1Track(
    api.GoogleCloudVideointelligenceV1p2beta1Track o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1Track++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1Track < 3) {
    checkUnnamed6576(o.attributes!);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVideointelligenceV1p2beta1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1p2beta1VideoSegment);
    checkUnnamed6577(o.timestampedObjects!);
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1Track--;
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress =
    0;
api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress
    buildGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress();
  buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress <
      3) {
    o.feature = 'foo';
    o.inputUri = 'foo';
    o.progressPercent = 42;
    o.segment = buildGoogleCloudVideointelligenceV1p2beta1VideoSegment();
    o.startTime = 'foo';
    o.updateTime = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress(
    api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress <
      3) {
    unittest.expect(
      o.feature!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.inputUri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.progressPercent!,
      unittest.equals(42),
    );
    checkGoogleCloudVideointelligenceV1p2beta1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1p2beta1VideoSegment);
    unittest.expect(
      o.startTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.updateTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress--;
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1FaceAnnotation>
    buildUnnamed6578() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1FaceAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1FaceAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1FaceAnnotation());
  return o;
}

void checkUnnamed6578(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1FaceAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1FaceAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1FaceAnnotation);
  checkGoogleCloudVideointelligenceV1p2beta1FaceAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1FaceAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation>
    buildUnnamed6579() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation());
  return o;
}

void checkUnnamed6579(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation);
  checkGoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation>
    buildUnnamed6580() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LabelAnnotation());
  return o;
}

void checkUnnamed6580(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation);
  checkGoogleCloudVideointelligenceV1p2beta1LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation>
    buildUnnamed6581() {
  var o =
      <api.GoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation());
  return o;
}

void checkUnnamed6581(
    core.List<
            api.GoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation(o[0]
      as api.GoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation);
  checkGoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation(o[1]
      as api.GoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation>
    buildUnnamed6582() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation());
  return o;
}

void checkUnnamed6582(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation(o[0]
      as api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation);
  checkGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation(o[1]
      as api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation>
    buildUnnamed6583() {
  var o =
      <api.GoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation());
  return o;
}

void checkUnnamed6583(
    core.List<
            api.GoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation(o[0]
      as api.GoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation);
  checkGoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation(o[1]
      as api.GoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation>
    buildUnnamed6584() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LabelAnnotation());
  return o;
}

void checkUnnamed6584(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation);
  checkGoogleCloudVideointelligenceV1p2beta1LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation>
    buildUnnamed6585() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LabelAnnotation());
  return o;
}

void checkUnnamed6585(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation);
  checkGoogleCloudVideointelligenceV1p2beta1LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1VideoSegment>
    buildUnnamed6586() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1VideoSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1VideoSegment());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1VideoSegment());
  return o;
}

void checkUnnamed6586(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1VideoSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1VideoSegment(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1VideoSegment);
  checkGoogleCloudVideointelligenceV1p2beta1VideoSegment(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1VideoSegment);
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation>
    buildUnnamed6587() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LabelAnnotation());
  return o;
}

void checkUnnamed6587(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation);
  checkGoogleCloudVideointelligenceV1p2beta1LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation>
    buildUnnamed6588() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1LabelAnnotation());
  return o;
}

void checkUnnamed6588(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation);
  checkGoogleCloudVideointelligenceV1p2beta1LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1SpeechTranscription>
    buildUnnamed6589() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1SpeechTranscription>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1SpeechTranscription());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1SpeechTranscription());
  return o;
}

void checkUnnamed6589(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1SpeechTranscription> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1SpeechTranscription(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1SpeechTranscription);
  checkGoogleCloudVideointelligenceV1p2beta1SpeechTranscription(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1SpeechTranscription);
}

core.List<api.GoogleCloudVideointelligenceV1p2beta1TextAnnotation>
    buildUnnamed6590() {
  var o = <api.GoogleCloudVideointelligenceV1p2beta1TextAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p2beta1TextAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p2beta1TextAnnotation());
  return o;
}

void checkUnnamed6590(
    core.List<api.GoogleCloudVideointelligenceV1p2beta1TextAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p2beta1TextAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1p2beta1TextAnnotation);
  checkGoogleCloudVideointelligenceV1p2beta1TextAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1p2beta1TextAnnotation);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults = 0;
api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults
    buildGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults();
  buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults <
      3) {
    o.error = buildGoogleRpcStatus();
    o.explicitAnnotation =
        buildGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation();
    o.faceAnnotations = buildUnnamed6578();
    o.faceDetectionAnnotations = buildUnnamed6579();
    o.frameLabelAnnotations = buildUnnamed6580();
    o.inputUri = 'foo';
    o.logoRecognitionAnnotations = buildUnnamed6581();
    o.objectAnnotations = buildUnnamed6582();
    o.personDetectionAnnotations = buildUnnamed6583();
    o.segment = buildGoogleCloudVideointelligenceV1p2beta1VideoSegment();
    o.segmentLabelAnnotations = buildUnnamed6584();
    o.segmentPresenceLabelAnnotations = buildUnnamed6585();
    o.shotAnnotations = buildUnnamed6586();
    o.shotLabelAnnotations = buildUnnamed6587();
    o.shotPresenceLabelAnnotations = buildUnnamed6588();
    o.speechTranscriptions = buildUnnamed6589();
    o.textAnnotations = buildUnnamed6590();
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults(
    api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults <
      3) {
    checkGoogleRpcStatus(o.error! as api.GoogleRpcStatus);
    checkGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation(o
            .explicitAnnotation!
        as api.GoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation);
    checkUnnamed6578(o.faceAnnotations!);
    checkUnnamed6579(o.faceDetectionAnnotations!);
    checkUnnamed6580(o.frameLabelAnnotations!);
    unittest.expect(
      o.inputUri!,
      unittest.equals('foo'),
    );
    checkUnnamed6581(o.logoRecognitionAnnotations!);
    checkUnnamed6582(o.objectAnnotations!);
    checkUnnamed6583(o.personDetectionAnnotations!);
    checkGoogleCloudVideointelligenceV1p2beta1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1p2beta1VideoSegment);
    checkUnnamed6584(o.segmentLabelAnnotations!);
    checkUnnamed6585(o.segmentPresenceLabelAnnotations!);
    checkUnnamed6586(o.shotAnnotations!);
    checkUnnamed6587(o.shotLabelAnnotations!);
    checkUnnamed6588(o.shotPresenceLabelAnnotations!);
    checkUnnamed6589(o.speechTranscriptions!);
    checkUnnamed6590(o.textAnnotations!);
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1VideoSegment = 0;
api.GoogleCloudVideointelligenceV1p2beta1VideoSegment
    buildGoogleCloudVideointelligenceV1p2beta1VideoSegment() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1VideoSegment();
  buildCounterGoogleCloudVideointelligenceV1p2beta1VideoSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1VideoSegment < 3) {
    o.endTimeOffset = 'foo';
    o.startTimeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1VideoSegment--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1VideoSegment(
    api.GoogleCloudVideointelligenceV1p2beta1VideoSegment o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1VideoSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1VideoSegment < 3) {
    unittest.expect(
      o.endTimeOffset!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.startTimeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1VideoSegment--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p2beta1WordInfo = 0;
api.GoogleCloudVideointelligenceV1p2beta1WordInfo
    buildGoogleCloudVideointelligenceV1p2beta1WordInfo() {
  var o = api.GoogleCloudVideointelligenceV1p2beta1WordInfo();
  buildCounterGoogleCloudVideointelligenceV1p2beta1WordInfo++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1WordInfo < 3) {
    o.confidence = 42.0;
    o.endTime = 'foo';
    o.speakerTag = 42;
    o.startTime = 'foo';
    o.word = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1WordInfo--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p2beta1WordInfo(
    api.GoogleCloudVideointelligenceV1p2beta1WordInfo o) {
  buildCounterGoogleCloudVideointelligenceV1p2beta1WordInfo++;
  if (buildCounterGoogleCloudVideointelligenceV1p2beta1WordInfo < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.endTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.speakerTag!,
      unittest.equals(42),
    );
    unittest.expect(
      o.startTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.word!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p2beta1WordInfo--;
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress>
    buildUnnamed6591() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress());
  return o;
}

void checkUnnamed6591(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress);
  checkGoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p3beta1AnnotateVideoProgress = 0;
api.GoogleCloudVideointelligenceV1p3beta1AnnotateVideoProgress
    buildGoogleCloudVideointelligenceV1p3beta1AnnotateVideoProgress() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1AnnotateVideoProgress();
  buildCounterGoogleCloudVideointelligenceV1p3beta1AnnotateVideoProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1AnnotateVideoProgress <
      3) {
    o.annotationProgress = buildUnnamed6591();
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1AnnotateVideoProgress--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1AnnotateVideoProgress(
    api.GoogleCloudVideointelligenceV1p3beta1AnnotateVideoProgress o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1AnnotateVideoProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1AnnotateVideoProgress <
      3) {
    checkUnnamed6591(o.annotationProgress!);
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1AnnotateVideoProgress--;
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults>
    buildUnnamed6592() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults());
  return o;
}

void checkUnnamed6592(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults);
  checkGoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p3beta1AnnotateVideoResponse = 0;
api.GoogleCloudVideointelligenceV1p3beta1AnnotateVideoResponse
    buildGoogleCloudVideointelligenceV1p3beta1AnnotateVideoResponse() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1AnnotateVideoResponse();
  buildCounterGoogleCloudVideointelligenceV1p3beta1AnnotateVideoResponse++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1AnnotateVideoResponse <
      3) {
    o.annotationResults = buildUnnamed6592();
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1AnnotateVideoResponse--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1AnnotateVideoResponse(
    api.GoogleCloudVideointelligenceV1p3beta1AnnotateVideoResponse o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1AnnotateVideoResponse++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1AnnotateVideoResponse <
      3) {
    checkUnnamed6592(o.annotationResults!);
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1AnnotateVideoResponse--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p3beta1Celebrity = 0;
api.GoogleCloudVideointelligenceV1p3beta1Celebrity
    buildGoogleCloudVideointelligenceV1p3beta1Celebrity() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1Celebrity();
  buildCounterGoogleCloudVideointelligenceV1p3beta1Celebrity++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1Celebrity < 3) {
    o.description = 'foo';
    o.displayName = 'foo';
    o.name = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1Celebrity--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1Celebrity(
    api.GoogleCloudVideointelligenceV1p3beta1Celebrity o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1Celebrity++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1Celebrity < 3) {
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
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1Celebrity--;
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1CelebrityTrack>
    buildUnnamed6593() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1CelebrityTrack>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1CelebrityTrack());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1CelebrityTrack());
  return o;
}

void checkUnnamed6593(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1CelebrityTrack> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1CelebrityTrack(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1CelebrityTrack);
  checkGoogleCloudVideointelligenceV1p3beta1CelebrityTrack(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1CelebrityTrack);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p3beta1CelebrityRecognitionAnnotation =
    0;
api.GoogleCloudVideointelligenceV1p3beta1CelebrityRecognitionAnnotation
    buildGoogleCloudVideointelligenceV1p3beta1CelebrityRecognitionAnnotation() {
  var o =
      api.GoogleCloudVideointelligenceV1p3beta1CelebrityRecognitionAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p3beta1CelebrityRecognitionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1CelebrityRecognitionAnnotation <
      3) {
    o.celebrityTracks = buildUnnamed6593();
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1CelebrityRecognitionAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1CelebrityRecognitionAnnotation(
    api.GoogleCloudVideointelligenceV1p3beta1CelebrityRecognitionAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1CelebrityRecognitionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1CelebrityRecognitionAnnotation <
      3) {
    checkUnnamed6593(o.celebrityTracks!);
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1CelebrityRecognitionAnnotation--;
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity>
    buildUnnamed6594() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity());
  return o;
}

void checkUnnamed6594(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity);
  checkGoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity);
}

core.int buildCounterGoogleCloudVideointelligenceV1p3beta1CelebrityTrack = 0;
api.GoogleCloudVideointelligenceV1p3beta1CelebrityTrack
    buildGoogleCloudVideointelligenceV1p3beta1CelebrityTrack() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1CelebrityTrack();
  buildCounterGoogleCloudVideointelligenceV1p3beta1CelebrityTrack++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1CelebrityTrack < 3) {
    o.celebrities = buildUnnamed6594();
    o.faceTrack = buildGoogleCloudVideointelligenceV1p3beta1Track();
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1CelebrityTrack--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1CelebrityTrack(
    api.GoogleCloudVideointelligenceV1p3beta1CelebrityTrack o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1CelebrityTrack++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1CelebrityTrack < 3) {
    checkUnnamed6594(o.celebrities!);
    checkGoogleCloudVideointelligenceV1p3beta1Track(
        o.faceTrack! as api.GoogleCloudVideointelligenceV1p3beta1Track);
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1CelebrityTrack--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p3beta1DetectedAttribute = 0;
api.GoogleCloudVideointelligenceV1p3beta1DetectedAttribute
    buildGoogleCloudVideointelligenceV1p3beta1DetectedAttribute() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1DetectedAttribute();
  buildCounterGoogleCloudVideointelligenceV1p3beta1DetectedAttribute++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1DetectedAttribute < 3) {
    o.confidence = 42.0;
    o.name = 'foo';
    o.value = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1DetectedAttribute--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1DetectedAttribute(
    api.GoogleCloudVideointelligenceV1p3beta1DetectedAttribute o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1DetectedAttribute++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1DetectedAttribute < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1DetectedAttribute--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p3beta1DetectedLandmark = 0;
api.GoogleCloudVideointelligenceV1p3beta1DetectedLandmark
    buildGoogleCloudVideointelligenceV1p3beta1DetectedLandmark() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1DetectedLandmark();
  buildCounterGoogleCloudVideointelligenceV1p3beta1DetectedLandmark++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1DetectedLandmark < 3) {
    o.confidence = 42.0;
    o.name = 'foo';
    o.point = buildGoogleCloudVideointelligenceV1p3beta1NormalizedVertex();
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1DetectedLandmark--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1DetectedLandmark(
    api.GoogleCloudVideointelligenceV1p3beta1DetectedLandmark o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1DetectedLandmark++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1DetectedLandmark < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkGoogleCloudVideointelligenceV1p3beta1NormalizedVertex(
        o.point! as api.GoogleCloudVideointelligenceV1p3beta1NormalizedVertex);
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1DetectedLandmark--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p3beta1Entity = 0;
api.GoogleCloudVideointelligenceV1p3beta1Entity
    buildGoogleCloudVideointelligenceV1p3beta1Entity() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1Entity();
  buildCounterGoogleCloudVideointelligenceV1p3beta1Entity++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1Entity < 3) {
    o.description = 'foo';
    o.entityId = 'foo';
    o.languageCode = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1Entity--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1Entity(
    api.GoogleCloudVideointelligenceV1p3beta1Entity o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1Entity++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1Entity < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.entityId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1Entity--;
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame>
    buildUnnamed6595() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame());
  return o;
}

void checkUnnamed6595(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame);
  checkGoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p3beta1ExplicitContentAnnotation =
    0;
api.GoogleCloudVideointelligenceV1p3beta1ExplicitContentAnnotation
    buildGoogleCloudVideointelligenceV1p3beta1ExplicitContentAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1ExplicitContentAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p3beta1ExplicitContentAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1ExplicitContentAnnotation <
      3) {
    o.frames = buildUnnamed6595();
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1ExplicitContentAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1ExplicitContentAnnotation(
    api.GoogleCloudVideointelligenceV1p3beta1ExplicitContentAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1ExplicitContentAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1ExplicitContentAnnotation <
      3) {
    checkUnnamed6595(o.frames!);
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1ExplicitContentAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame =
    0;
api.GoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame
    buildGoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame();
  buildCounterGoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame <
      3) {
    o.pornographyLikelihood = 'foo';
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame(
    api.GoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame <
      3) {
    unittest.expect(
      o.pornographyLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame--;
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1FaceFrame>
    buildUnnamed6596() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1FaceFrame>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1FaceFrame());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1FaceFrame());
  return o;
}

void checkUnnamed6596(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1FaceFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1FaceFrame(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1FaceFrame);
  checkGoogleCloudVideointelligenceV1p3beta1FaceFrame(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1FaceFrame);
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1FaceSegment>
    buildUnnamed6597() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1FaceSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1FaceSegment());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1FaceSegment());
  return o;
}

void checkUnnamed6597(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1FaceSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1FaceSegment(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1FaceSegment);
  checkGoogleCloudVideointelligenceV1p3beta1FaceSegment(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1FaceSegment);
}

core.int buildCounterGoogleCloudVideointelligenceV1p3beta1FaceAnnotation = 0;
api.GoogleCloudVideointelligenceV1p3beta1FaceAnnotation
    buildGoogleCloudVideointelligenceV1p3beta1FaceAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1FaceAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p3beta1FaceAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1FaceAnnotation < 3) {
    o.frames = buildUnnamed6596();
    o.segments = buildUnnamed6597();
    o.thumbnail = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1FaceAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1FaceAnnotation(
    api.GoogleCloudVideointelligenceV1p3beta1FaceAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1FaceAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1FaceAnnotation < 3) {
    checkUnnamed6596(o.frames!);
    checkUnnamed6597(o.segments!);
    unittest.expect(
      o.thumbnail!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1FaceAnnotation--;
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1Track> buildUnnamed6598() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1Track>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1Track());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1Track());
  return o;
}

void checkUnnamed6598(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1Track> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1Track(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1Track);
  checkGoogleCloudVideointelligenceV1p3beta1Track(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1Track);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation =
    0;
api.GoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation
    buildGoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation <
      3) {
    o.thumbnail = 'foo';
    o.tracks = buildUnnamed6598();
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation(
    api.GoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation <
      3) {
    unittest.expect(
      o.thumbnail!,
      unittest.equals('foo'),
    );
    checkUnnamed6598(o.tracks!);
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation--;
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox>
    buildUnnamed6599() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox());
  return o;
}

void checkUnnamed6599(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox);
  checkGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox);
}

core.int buildCounterGoogleCloudVideointelligenceV1p3beta1FaceFrame = 0;
api.GoogleCloudVideointelligenceV1p3beta1FaceFrame
    buildGoogleCloudVideointelligenceV1p3beta1FaceFrame() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1FaceFrame();
  buildCounterGoogleCloudVideointelligenceV1p3beta1FaceFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1FaceFrame < 3) {
    o.normalizedBoundingBoxes = buildUnnamed6599();
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1FaceFrame--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1FaceFrame(
    api.GoogleCloudVideointelligenceV1p3beta1FaceFrame o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1FaceFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1FaceFrame < 3) {
    checkUnnamed6599(o.normalizedBoundingBoxes!);
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1FaceFrame--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p3beta1FaceSegment = 0;
api.GoogleCloudVideointelligenceV1p3beta1FaceSegment
    buildGoogleCloudVideointelligenceV1p3beta1FaceSegment() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1FaceSegment();
  buildCounterGoogleCloudVideointelligenceV1p3beta1FaceSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1FaceSegment < 3) {
    o.segment = buildGoogleCloudVideointelligenceV1p3beta1VideoSegment();
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1FaceSegment--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1FaceSegment(
    api.GoogleCloudVideointelligenceV1p3beta1FaceSegment o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1FaceSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1FaceSegment < 3) {
    checkGoogleCloudVideointelligenceV1p3beta1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1p3beta1VideoSegment);
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1FaceSegment--;
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1Entity> buildUnnamed6600() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1Entity>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1Entity());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1Entity());
  return o;
}

void checkUnnamed6600(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1Entity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1Entity(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1Entity);
  checkGoogleCloudVideointelligenceV1p3beta1Entity(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1Entity);
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1LabelFrame>
    buildUnnamed6601() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1LabelFrame>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1LabelFrame());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1LabelFrame());
  return o;
}

void checkUnnamed6601(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1LabelFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1LabelFrame(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1LabelFrame);
  checkGoogleCloudVideointelligenceV1p3beta1LabelFrame(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1LabelFrame);
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1LabelSegment>
    buildUnnamed6602() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1LabelSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1LabelSegment());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1LabelSegment());
  return o;
}

void checkUnnamed6602(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1LabelSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1LabelSegment(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1LabelSegment);
  checkGoogleCloudVideointelligenceV1p3beta1LabelSegment(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1LabelSegment);
}

core.int buildCounterGoogleCloudVideointelligenceV1p3beta1LabelAnnotation = 0;
api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation
    buildGoogleCloudVideointelligenceV1p3beta1LabelAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p3beta1LabelAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1LabelAnnotation < 3) {
    o.categoryEntities = buildUnnamed6600();
    o.entity = buildGoogleCloudVideointelligenceV1p3beta1Entity();
    o.frames = buildUnnamed6601();
    o.segments = buildUnnamed6602();
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1LabelAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1LabelAnnotation(
    api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1LabelAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1LabelAnnotation < 3) {
    checkUnnamed6600(o.categoryEntities!);
    checkGoogleCloudVideointelligenceV1p3beta1Entity(
        o.entity! as api.GoogleCloudVideointelligenceV1p3beta1Entity);
    checkUnnamed6601(o.frames!);
    checkUnnamed6602(o.segments!);
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1LabelAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p3beta1LabelFrame = 0;
api.GoogleCloudVideointelligenceV1p3beta1LabelFrame
    buildGoogleCloudVideointelligenceV1p3beta1LabelFrame() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1LabelFrame();
  buildCounterGoogleCloudVideointelligenceV1p3beta1LabelFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1LabelFrame < 3) {
    o.confidence = 42.0;
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1LabelFrame--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1LabelFrame(
    api.GoogleCloudVideointelligenceV1p3beta1LabelFrame o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1LabelFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1LabelFrame < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1LabelFrame--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p3beta1LabelSegment = 0;
api.GoogleCloudVideointelligenceV1p3beta1LabelSegment
    buildGoogleCloudVideointelligenceV1p3beta1LabelSegment() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1LabelSegment();
  buildCounterGoogleCloudVideointelligenceV1p3beta1LabelSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1LabelSegment < 3) {
    o.confidence = 42.0;
    o.segment = buildGoogleCloudVideointelligenceV1p3beta1VideoSegment();
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1LabelSegment--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1LabelSegment(
    api.GoogleCloudVideointelligenceV1p3beta1LabelSegment o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1LabelSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1LabelSegment < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVideointelligenceV1p3beta1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1p3beta1VideoSegment);
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1LabelSegment--;
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1VideoSegment>
    buildUnnamed6603() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1VideoSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1VideoSegment());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1VideoSegment());
  return o;
}

void checkUnnamed6603(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1VideoSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1VideoSegment(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1VideoSegment);
  checkGoogleCloudVideointelligenceV1p3beta1VideoSegment(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1VideoSegment);
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1Track> buildUnnamed6604() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1Track>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1Track());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1Track());
  return o;
}

void checkUnnamed6604(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1Track> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1Track(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1Track);
  checkGoogleCloudVideointelligenceV1p3beta1Track(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1Track);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation =
    0;
api.GoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation
    buildGoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation <
      3) {
    o.entity = buildGoogleCloudVideointelligenceV1p3beta1Entity();
    o.segments = buildUnnamed6603();
    o.tracks = buildUnnamed6604();
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation(
    api.GoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation <
      3) {
    checkGoogleCloudVideointelligenceV1p3beta1Entity(
        o.entity! as api.GoogleCloudVideointelligenceV1p3beta1Entity);
    checkUnnamed6603(o.segments!);
    checkUnnamed6604(o.tracks!);
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation--;
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox = 0;
api.GoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox
    buildGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox();
  buildCounterGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox <
      3) {
    o.bottom = 42.0;
    o.left = 42.0;
    o.right = 42.0;
    o.top = 42.0;
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox(
    api.GoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox <
      3) {
    unittest.expect(
      o.bottom!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.left!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.right!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.top!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox--;
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1NormalizedVertex>
    buildUnnamed6605() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1NormalizedVertex>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1NormalizedVertex());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1NormalizedVertex());
  return o;
}

void checkUnnamed6605(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1NormalizedVertex> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1NormalizedVertex(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1NormalizedVertex);
  checkGoogleCloudVideointelligenceV1p3beta1NormalizedVertex(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1NormalizedVertex);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingPoly = 0;
api.GoogleCloudVideointelligenceV1p3beta1NormalizedBoundingPoly
    buildGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingPoly() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1NormalizedBoundingPoly();
  buildCounterGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingPoly++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingPoly <
      3) {
    o.vertices = buildUnnamed6605();
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingPoly--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingPoly(
    api.GoogleCloudVideointelligenceV1p3beta1NormalizedBoundingPoly o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingPoly++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingPoly <
      3) {
    checkUnnamed6605(o.vertices!);
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingPoly--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p3beta1NormalizedVertex = 0;
api.GoogleCloudVideointelligenceV1p3beta1NormalizedVertex
    buildGoogleCloudVideointelligenceV1p3beta1NormalizedVertex() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1NormalizedVertex();
  buildCounterGoogleCloudVideointelligenceV1p3beta1NormalizedVertex++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1NormalizedVertex < 3) {
    o.x = 42.0;
    o.y = 42.0;
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1NormalizedVertex--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1NormalizedVertex(
    api.GoogleCloudVideointelligenceV1p3beta1NormalizedVertex o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1NormalizedVertex++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1NormalizedVertex < 3) {
    unittest.expect(
      o.x!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.y!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1NormalizedVertex--;
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame>
    buildUnnamed6606() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame());
  return o;
}

void checkUnnamed6606(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame);
  checkGoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation =
    0;
api.GoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation
    buildGoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation <
      3) {
    o.confidence = 42.0;
    o.entity = buildGoogleCloudVideointelligenceV1p3beta1Entity();
    o.frames = buildUnnamed6606();
    o.segment = buildGoogleCloudVideointelligenceV1p3beta1VideoSegment();
    o.trackId = 'foo';
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation(
    api.GoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation <
      3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVideointelligenceV1p3beta1Entity(
        o.entity! as api.GoogleCloudVideointelligenceV1p3beta1Entity);
    checkUnnamed6606(o.frames!);
    checkGoogleCloudVideointelligenceV1p3beta1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1p3beta1VideoSegment);
    unittest.expect(
      o.trackId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame =
    0;
api.GoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame
    buildGoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame();
  buildCounterGoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame <
      3) {
    o.normalizedBoundingBox =
        buildGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox();
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame(
    api.GoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame <
      3) {
    checkGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox(
        o.normalizedBoundingBox!
            as api.GoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox);
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame--;
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1Track> buildUnnamed6607() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1Track>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1Track());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1Track());
  return o;
}

void checkUnnamed6607(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1Track> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1Track(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1Track);
  checkGoogleCloudVideointelligenceV1p3beta1Track(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1Track);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation =
    0;
api.GoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation
    buildGoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation <
      3) {
    o.tracks = buildUnnamed6607();
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation(
    api.GoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation <
      3) {
    checkUnnamed6607(o.tracks!);
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity =
    0;
api.GoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity
    buildGoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity();
  buildCounterGoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity <
      3) {
    o.celebrity = buildGoogleCloudVideointelligenceV1p3beta1Celebrity();
    o.confidence = 42.0;
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity(
    api.GoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity <
      3) {
    checkGoogleCloudVideointelligenceV1p3beta1Celebrity(
        o.celebrity! as api.GoogleCloudVideointelligenceV1p3beta1Celebrity);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity--;
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1WordInfo>
    buildUnnamed6608() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1WordInfo>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1WordInfo());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1WordInfo());
  return o;
}

void checkUnnamed6608(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1WordInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1WordInfo(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1WordInfo);
  checkGoogleCloudVideointelligenceV1p3beta1WordInfo(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1WordInfo);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative =
    0;
api.GoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative
    buildGoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative() {
  var o =
      api.GoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative();
  buildCounterGoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative <
      3) {
    o.confidence = 42.0;
    o.transcript = 'foo';
    o.words = buildUnnamed6608();
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative(
    api.GoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative <
      3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.transcript!,
      unittest.equals('foo'),
    );
    checkUnnamed6608(o.words!);
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative--;
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative>
    buildUnnamed6609() {
  var o =
      <api.GoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative>[];
  o.add(
      buildGoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative());
  o.add(
      buildGoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative());
  return o;
}

void checkUnnamed6609(
    core.List<
            api.GoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative(o[0]
      as api.GoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative);
  checkGoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative(o[1]
      as api.GoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative);
}

core.int buildCounterGoogleCloudVideointelligenceV1p3beta1SpeechTranscription =
    0;
api.GoogleCloudVideointelligenceV1p3beta1SpeechTranscription
    buildGoogleCloudVideointelligenceV1p3beta1SpeechTranscription() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1SpeechTranscription();
  buildCounterGoogleCloudVideointelligenceV1p3beta1SpeechTranscription++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1SpeechTranscription <
      3) {
    o.alternatives = buildUnnamed6609();
    o.languageCode = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1SpeechTranscription--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1SpeechTranscription(
    api.GoogleCloudVideointelligenceV1p3beta1SpeechTranscription o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1SpeechTranscription++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1SpeechTranscription <
      3) {
    checkUnnamed6609(o.alternatives!);
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1SpeechTranscription--;
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p3beta1StreamingAnnotateVideoResponse =
    0;
api.GoogleCloudVideointelligenceV1p3beta1StreamingAnnotateVideoResponse
    buildGoogleCloudVideointelligenceV1p3beta1StreamingAnnotateVideoResponse() {
  var o =
      api.GoogleCloudVideointelligenceV1p3beta1StreamingAnnotateVideoResponse();
  buildCounterGoogleCloudVideointelligenceV1p3beta1StreamingAnnotateVideoResponse++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1StreamingAnnotateVideoResponse <
      3) {
    o.annotationResults =
        buildGoogleCloudVideointelligenceV1p3beta1StreamingVideoAnnotationResults();
    o.annotationResultsUri = 'foo';
    o.error = buildGoogleRpcStatus();
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1StreamingAnnotateVideoResponse--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1StreamingAnnotateVideoResponse(
    api.GoogleCloudVideointelligenceV1p3beta1StreamingAnnotateVideoResponse o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1StreamingAnnotateVideoResponse++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1StreamingAnnotateVideoResponse <
      3) {
    checkGoogleCloudVideointelligenceV1p3beta1StreamingVideoAnnotationResults(
        o.annotationResults! as api
            .GoogleCloudVideointelligenceV1p3beta1StreamingVideoAnnotationResults);
    unittest.expect(
      o.annotationResultsUri!,
      unittest.equals('foo'),
    );
    checkGoogleRpcStatus(o.error! as api.GoogleRpcStatus);
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1StreamingAnnotateVideoResponse--;
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation>
    buildUnnamed6610() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1LabelAnnotation());
  return o;
}

void checkUnnamed6610(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation);
  checkGoogleCloudVideointelligenceV1p3beta1LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation>
    buildUnnamed6611() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation());
  return o;
}

void checkUnnamed6611(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation(o[0]
      as api.GoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation);
  checkGoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation(o[1]
      as api.GoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1VideoSegment>
    buildUnnamed6612() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1VideoSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1VideoSegment());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1VideoSegment());
  return o;
}

void checkUnnamed6612(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1VideoSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1VideoSegment(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1VideoSegment);
  checkGoogleCloudVideointelligenceV1p3beta1VideoSegment(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1VideoSegment);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p3beta1StreamingVideoAnnotationResults =
    0;
api.GoogleCloudVideointelligenceV1p3beta1StreamingVideoAnnotationResults
    buildGoogleCloudVideointelligenceV1p3beta1StreamingVideoAnnotationResults() {
  var o = api
      .GoogleCloudVideointelligenceV1p3beta1StreamingVideoAnnotationResults();
  buildCounterGoogleCloudVideointelligenceV1p3beta1StreamingVideoAnnotationResults++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1StreamingVideoAnnotationResults <
      3) {
    o.explicitAnnotation =
        buildGoogleCloudVideointelligenceV1p3beta1ExplicitContentAnnotation();
    o.frameTimestamp = 'foo';
    o.labelAnnotations = buildUnnamed6610();
    o.objectAnnotations = buildUnnamed6611();
    o.shotAnnotations = buildUnnamed6612();
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1StreamingVideoAnnotationResults--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1StreamingVideoAnnotationResults(
    api.GoogleCloudVideointelligenceV1p3beta1StreamingVideoAnnotationResults
        o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1StreamingVideoAnnotationResults++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1StreamingVideoAnnotationResults <
      3) {
    checkGoogleCloudVideointelligenceV1p3beta1ExplicitContentAnnotation(o
            .explicitAnnotation!
        as api.GoogleCloudVideointelligenceV1p3beta1ExplicitContentAnnotation);
    unittest.expect(
      o.frameTimestamp!,
      unittest.equals('foo'),
    );
    checkUnnamed6610(o.labelAnnotations!);
    checkUnnamed6611(o.objectAnnotations!);
    checkUnnamed6612(o.shotAnnotations!);
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1StreamingVideoAnnotationResults--;
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1TextSegment>
    buildUnnamed6613() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1TextSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1TextSegment());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1TextSegment());
  return o;
}

void checkUnnamed6613(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1TextSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1TextSegment(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1TextSegment);
  checkGoogleCloudVideointelligenceV1p3beta1TextSegment(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1TextSegment);
}

core.int buildCounterGoogleCloudVideointelligenceV1p3beta1TextAnnotation = 0;
api.GoogleCloudVideointelligenceV1p3beta1TextAnnotation
    buildGoogleCloudVideointelligenceV1p3beta1TextAnnotation() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1TextAnnotation();
  buildCounterGoogleCloudVideointelligenceV1p3beta1TextAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1TextAnnotation < 3) {
    o.segments = buildUnnamed6613();
    o.text = 'foo';
    o.version = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1TextAnnotation--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1TextAnnotation(
    api.GoogleCloudVideointelligenceV1p3beta1TextAnnotation o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1TextAnnotation++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1TextAnnotation < 3) {
    checkUnnamed6613(o.segments!);
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.version!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1TextAnnotation--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p3beta1TextFrame = 0;
api.GoogleCloudVideointelligenceV1p3beta1TextFrame
    buildGoogleCloudVideointelligenceV1p3beta1TextFrame() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1TextFrame();
  buildCounterGoogleCloudVideointelligenceV1p3beta1TextFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1TextFrame < 3) {
    o.rotatedBoundingBox =
        buildGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingPoly();
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1TextFrame--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1TextFrame(
    api.GoogleCloudVideointelligenceV1p3beta1TextFrame o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1TextFrame++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1TextFrame < 3) {
    checkGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingPoly(
        o.rotatedBoundingBox!
            as api.GoogleCloudVideointelligenceV1p3beta1NormalizedBoundingPoly);
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1TextFrame--;
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1TextFrame>
    buildUnnamed6614() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1TextFrame>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1TextFrame());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1TextFrame());
  return o;
}

void checkUnnamed6614(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1TextFrame> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1TextFrame(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1TextFrame);
  checkGoogleCloudVideointelligenceV1p3beta1TextFrame(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1TextFrame);
}

core.int buildCounterGoogleCloudVideointelligenceV1p3beta1TextSegment = 0;
api.GoogleCloudVideointelligenceV1p3beta1TextSegment
    buildGoogleCloudVideointelligenceV1p3beta1TextSegment() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1TextSegment();
  buildCounterGoogleCloudVideointelligenceV1p3beta1TextSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1TextSegment < 3) {
    o.confidence = 42.0;
    o.frames = buildUnnamed6614();
    o.segment = buildGoogleCloudVideointelligenceV1p3beta1VideoSegment();
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1TextSegment--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1TextSegment(
    api.GoogleCloudVideointelligenceV1p3beta1TextSegment o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1TextSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1TextSegment < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkUnnamed6614(o.frames!);
    checkGoogleCloudVideointelligenceV1p3beta1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1p3beta1VideoSegment);
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1TextSegment--;
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1DetectedAttribute>
    buildUnnamed6615() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1DetectedAttribute>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1DetectedAttribute());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1DetectedAttribute());
  return o;
}

void checkUnnamed6615(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1DetectedAttribute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1DetectedAttribute(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1DetectedAttribute);
  checkGoogleCloudVideointelligenceV1p3beta1DetectedAttribute(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1DetectedAttribute);
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1DetectedLandmark>
    buildUnnamed6616() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1DetectedLandmark>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1DetectedLandmark());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1DetectedLandmark());
  return o;
}

void checkUnnamed6616(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1DetectedLandmark> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1DetectedLandmark(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1DetectedLandmark);
  checkGoogleCloudVideointelligenceV1p3beta1DetectedLandmark(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1DetectedLandmark);
}

core.int buildCounterGoogleCloudVideointelligenceV1p3beta1TimestampedObject = 0;
api.GoogleCloudVideointelligenceV1p3beta1TimestampedObject
    buildGoogleCloudVideointelligenceV1p3beta1TimestampedObject() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1TimestampedObject();
  buildCounterGoogleCloudVideointelligenceV1p3beta1TimestampedObject++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1TimestampedObject < 3) {
    o.attributes = buildUnnamed6615();
    o.landmarks = buildUnnamed6616();
    o.normalizedBoundingBox =
        buildGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox();
    o.timeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1TimestampedObject--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1TimestampedObject(
    api.GoogleCloudVideointelligenceV1p3beta1TimestampedObject o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1TimestampedObject++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1TimestampedObject < 3) {
    checkUnnamed6615(o.attributes!);
    checkUnnamed6616(o.landmarks!);
    checkGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox(
        o.normalizedBoundingBox!
            as api.GoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox);
    unittest.expect(
      o.timeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1TimestampedObject--;
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1DetectedAttribute>
    buildUnnamed6617() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1DetectedAttribute>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1DetectedAttribute());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1DetectedAttribute());
  return o;
}

void checkUnnamed6617(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1DetectedAttribute> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1DetectedAttribute(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1DetectedAttribute);
  checkGoogleCloudVideointelligenceV1p3beta1DetectedAttribute(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1DetectedAttribute);
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1TimestampedObject>
    buildUnnamed6618() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1TimestampedObject>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1TimestampedObject());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1TimestampedObject());
  return o;
}

void checkUnnamed6618(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1TimestampedObject> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1TimestampedObject(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1TimestampedObject);
  checkGoogleCloudVideointelligenceV1p3beta1TimestampedObject(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1TimestampedObject);
}

core.int buildCounterGoogleCloudVideointelligenceV1p3beta1Track = 0;
api.GoogleCloudVideointelligenceV1p3beta1Track
    buildGoogleCloudVideointelligenceV1p3beta1Track() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1Track();
  buildCounterGoogleCloudVideointelligenceV1p3beta1Track++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1Track < 3) {
    o.attributes = buildUnnamed6617();
    o.confidence = 42.0;
    o.segment = buildGoogleCloudVideointelligenceV1p3beta1VideoSegment();
    o.timestampedObjects = buildUnnamed6618();
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1Track--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1Track(
    api.GoogleCloudVideointelligenceV1p3beta1Track o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1Track++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1Track < 3) {
    checkUnnamed6617(o.attributes!);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVideointelligenceV1p3beta1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1p3beta1VideoSegment);
    checkUnnamed6618(o.timestampedObjects!);
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1Track--;
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress =
    0;
api.GoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress
    buildGoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress();
  buildCounterGoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress <
      3) {
    o.feature = 'foo';
    o.inputUri = 'foo';
    o.progressPercent = 42;
    o.segment = buildGoogleCloudVideointelligenceV1p3beta1VideoSegment();
    o.startTime = 'foo';
    o.updateTime = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress(
    api.GoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress <
      3) {
    unittest.expect(
      o.feature!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.inputUri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.progressPercent!,
      unittest.equals(42),
    );
    checkGoogleCloudVideointelligenceV1p3beta1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1p3beta1VideoSegment);
    unittest.expect(
      o.startTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.updateTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress--;
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1FaceAnnotation>
    buildUnnamed6619() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1FaceAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1FaceAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1FaceAnnotation());
  return o;
}

void checkUnnamed6619(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1FaceAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1FaceAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1FaceAnnotation);
  checkGoogleCloudVideointelligenceV1p3beta1FaceAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1FaceAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation>
    buildUnnamed6620() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation());
  return o;
}

void checkUnnamed6620(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation);
  checkGoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation>
    buildUnnamed6621() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1LabelAnnotation());
  return o;
}

void checkUnnamed6621(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation);
  checkGoogleCloudVideointelligenceV1p3beta1LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation>
    buildUnnamed6622() {
  var o =
      <api.GoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation());
  return o;
}

void checkUnnamed6622(
    core.List<
            api.GoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation(o[0]
      as api.GoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation);
  checkGoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation(o[1]
      as api.GoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation>
    buildUnnamed6623() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation());
  return o;
}

void checkUnnamed6623(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation(o[0]
      as api.GoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation);
  checkGoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation(o[1]
      as api.GoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation>
    buildUnnamed6624() {
  var o =
      <api.GoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation());
  return o;
}

void checkUnnamed6624(
    core.List<
            api.GoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation(o[0]
      as api.GoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation);
  checkGoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation(o[1]
      as api.GoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation>
    buildUnnamed6625() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1LabelAnnotation());
  return o;
}

void checkUnnamed6625(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation);
  checkGoogleCloudVideointelligenceV1p3beta1LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation>
    buildUnnamed6626() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1LabelAnnotation());
  return o;
}

void checkUnnamed6626(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation);
  checkGoogleCloudVideointelligenceV1p3beta1LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1VideoSegment>
    buildUnnamed6627() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1VideoSegment>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1VideoSegment());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1VideoSegment());
  return o;
}

void checkUnnamed6627(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1VideoSegment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1VideoSegment(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1VideoSegment);
  checkGoogleCloudVideointelligenceV1p3beta1VideoSegment(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1VideoSegment);
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation>
    buildUnnamed6628() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1LabelAnnotation());
  return o;
}

void checkUnnamed6628(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation);
  checkGoogleCloudVideointelligenceV1p3beta1LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation>
    buildUnnamed6629() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1LabelAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1LabelAnnotation());
  return o;
}

void checkUnnamed6629(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1LabelAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation);
  checkGoogleCloudVideointelligenceV1p3beta1LabelAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation);
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1SpeechTranscription>
    buildUnnamed6630() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1SpeechTranscription>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1SpeechTranscription());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1SpeechTranscription());
  return o;
}

void checkUnnamed6630(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1SpeechTranscription> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1SpeechTranscription(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1SpeechTranscription);
  checkGoogleCloudVideointelligenceV1p3beta1SpeechTranscription(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1SpeechTranscription);
}

core.List<api.GoogleCloudVideointelligenceV1p3beta1TextAnnotation>
    buildUnnamed6631() {
  var o = <api.GoogleCloudVideointelligenceV1p3beta1TextAnnotation>[];
  o.add(buildGoogleCloudVideointelligenceV1p3beta1TextAnnotation());
  o.add(buildGoogleCloudVideointelligenceV1p3beta1TextAnnotation());
  return o;
}

void checkUnnamed6631(
    core.List<api.GoogleCloudVideointelligenceV1p3beta1TextAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVideointelligenceV1p3beta1TextAnnotation(
      o[0] as api.GoogleCloudVideointelligenceV1p3beta1TextAnnotation);
  checkGoogleCloudVideointelligenceV1p3beta1TextAnnotation(
      o[1] as api.GoogleCloudVideointelligenceV1p3beta1TextAnnotation);
}

core.int
    buildCounterGoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults = 0;
api.GoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults
    buildGoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults();
  buildCounterGoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults <
      3) {
    o.celebrityRecognitionAnnotations =
        buildGoogleCloudVideointelligenceV1p3beta1CelebrityRecognitionAnnotation();
    o.error = buildGoogleRpcStatus();
    o.explicitAnnotation =
        buildGoogleCloudVideointelligenceV1p3beta1ExplicitContentAnnotation();
    o.faceAnnotations = buildUnnamed6619();
    o.faceDetectionAnnotations = buildUnnamed6620();
    o.frameLabelAnnotations = buildUnnamed6621();
    o.inputUri = 'foo';
    o.logoRecognitionAnnotations = buildUnnamed6622();
    o.objectAnnotations = buildUnnamed6623();
    o.personDetectionAnnotations = buildUnnamed6624();
    o.segment = buildGoogleCloudVideointelligenceV1p3beta1VideoSegment();
    o.segmentLabelAnnotations = buildUnnamed6625();
    o.segmentPresenceLabelAnnotations = buildUnnamed6626();
    o.shotAnnotations = buildUnnamed6627();
    o.shotLabelAnnotations = buildUnnamed6628();
    o.shotPresenceLabelAnnotations = buildUnnamed6629();
    o.speechTranscriptions = buildUnnamed6630();
    o.textAnnotations = buildUnnamed6631();
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults(
    api.GoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults <
      3) {
    checkGoogleCloudVideointelligenceV1p3beta1CelebrityRecognitionAnnotation(
        o.celebrityRecognitionAnnotations! as api
            .GoogleCloudVideointelligenceV1p3beta1CelebrityRecognitionAnnotation);
    checkGoogleRpcStatus(o.error! as api.GoogleRpcStatus);
    checkGoogleCloudVideointelligenceV1p3beta1ExplicitContentAnnotation(o
            .explicitAnnotation!
        as api.GoogleCloudVideointelligenceV1p3beta1ExplicitContentAnnotation);
    checkUnnamed6619(o.faceAnnotations!);
    checkUnnamed6620(o.faceDetectionAnnotations!);
    checkUnnamed6621(o.frameLabelAnnotations!);
    unittest.expect(
      o.inputUri!,
      unittest.equals('foo'),
    );
    checkUnnamed6622(o.logoRecognitionAnnotations!);
    checkUnnamed6623(o.objectAnnotations!);
    checkUnnamed6624(o.personDetectionAnnotations!);
    checkGoogleCloudVideointelligenceV1p3beta1VideoSegment(
        o.segment! as api.GoogleCloudVideointelligenceV1p3beta1VideoSegment);
    checkUnnamed6625(o.segmentLabelAnnotations!);
    checkUnnamed6626(o.segmentPresenceLabelAnnotations!);
    checkUnnamed6627(o.shotAnnotations!);
    checkUnnamed6628(o.shotLabelAnnotations!);
    checkUnnamed6629(o.shotPresenceLabelAnnotations!);
    checkUnnamed6630(o.speechTranscriptions!);
    checkUnnamed6631(o.textAnnotations!);
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p3beta1VideoSegment = 0;
api.GoogleCloudVideointelligenceV1p3beta1VideoSegment
    buildGoogleCloudVideointelligenceV1p3beta1VideoSegment() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1VideoSegment();
  buildCounterGoogleCloudVideointelligenceV1p3beta1VideoSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1VideoSegment < 3) {
    o.endTimeOffset = 'foo';
    o.startTimeOffset = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1VideoSegment--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1VideoSegment(
    api.GoogleCloudVideointelligenceV1p3beta1VideoSegment o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1VideoSegment++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1VideoSegment < 3) {
    unittest.expect(
      o.endTimeOffset!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.startTimeOffset!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1VideoSegment--;
}

core.int buildCounterGoogleCloudVideointelligenceV1p3beta1WordInfo = 0;
api.GoogleCloudVideointelligenceV1p3beta1WordInfo
    buildGoogleCloudVideointelligenceV1p3beta1WordInfo() {
  var o = api.GoogleCloudVideointelligenceV1p3beta1WordInfo();
  buildCounterGoogleCloudVideointelligenceV1p3beta1WordInfo++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1WordInfo < 3) {
    o.confidence = 42.0;
    o.endTime = 'foo';
    o.speakerTag = 42;
    o.startTime = 'foo';
    o.word = 'foo';
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1WordInfo--;
  return o;
}

void checkGoogleCloudVideointelligenceV1p3beta1WordInfo(
    api.GoogleCloudVideointelligenceV1p3beta1WordInfo o) {
  buildCounterGoogleCloudVideointelligenceV1p3beta1WordInfo++;
  if (buildCounterGoogleCloudVideointelligenceV1p3beta1WordInfo < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.endTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.speakerTag!,
      unittest.equals(42),
    );
    unittest.expect(
      o.startTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.word!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVideointelligenceV1p3beta1WordInfo--;
}

core.int buildCounterGoogleLongrunningCancelOperationRequest = 0;
api.GoogleLongrunningCancelOperationRequest
    buildGoogleLongrunningCancelOperationRequest() {
  var o = api.GoogleLongrunningCancelOperationRequest();
  buildCounterGoogleLongrunningCancelOperationRequest++;
  if (buildCounterGoogleLongrunningCancelOperationRequest < 3) {}
  buildCounterGoogleLongrunningCancelOperationRequest--;
  return o;
}

void checkGoogleLongrunningCancelOperationRequest(
    api.GoogleLongrunningCancelOperationRequest o) {
  buildCounterGoogleLongrunningCancelOperationRequest++;
  if (buildCounterGoogleLongrunningCancelOperationRequest < 3) {}
  buildCounterGoogleLongrunningCancelOperationRequest--;
}

core.List<api.GoogleLongrunningOperation> buildUnnamed6632() {
  var o = <api.GoogleLongrunningOperation>[];
  o.add(buildGoogleLongrunningOperation());
  o.add(buildGoogleLongrunningOperation());
  return o;
}

void checkUnnamed6632(core.List<api.GoogleLongrunningOperation> o) {
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
    o.operations = buildUnnamed6632();
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
    checkUnnamed6632(o.operations!);
  }
  buildCounterGoogleLongrunningListOperationsResponse--;
}

core.Map<core.String, core.Object> buildUnnamed6633() {
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

void checkUnnamed6633(core.Map<core.String, core.Object> o) {
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

core.Map<core.String, core.Object> buildUnnamed6634() {
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

void checkUnnamed6634(core.Map<core.String, core.Object> o) {
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

core.int buildCounterGoogleLongrunningOperation = 0;
api.GoogleLongrunningOperation buildGoogleLongrunningOperation() {
  var o = api.GoogleLongrunningOperation();
  buildCounterGoogleLongrunningOperation++;
  if (buildCounterGoogleLongrunningOperation < 3) {
    o.done = true;
    o.error = buildGoogleRpcStatus();
    o.metadata = buildUnnamed6633();
    o.name = 'foo';
    o.response = buildUnnamed6634();
  }
  buildCounterGoogleLongrunningOperation--;
  return o;
}

void checkGoogleLongrunningOperation(api.GoogleLongrunningOperation o) {
  buildCounterGoogleLongrunningOperation++;
  if (buildCounterGoogleLongrunningOperation < 3) {
    unittest.expect(o.done!, unittest.isTrue);
    checkGoogleRpcStatus(o.error! as api.GoogleRpcStatus);
    checkUnnamed6633(o.metadata!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed6634(o.response!);
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

core.Map<core.String, core.Object> buildUnnamed6635() {
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

void checkUnnamed6635(core.Map<core.String, core.Object> o) {
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

core.List<core.Map<core.String, core.Object>> buildUnnamed6636() {
  var o = <core.Map<core.String, core.Object>>[];
  o.add(buildUnnamed6635());
  o.add(buildUnnamed6635());
  return o;
}

void checkUnnamed6636(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed6635(o[0]);
  checkUnnamed6635(o[1]);
}

core.int buildCounterGoogleRpcStatus = 0;
api.GoogleRpcStatus buildGoogleRpcStatus() {
  var o = api.GoogleRpcStatus();
  buildCounterGoogleRpcStatus++;
  if (buildCounterGoogleRpcStatus < 3) {
    o.code = 42;
    o.details = buildUnnamed6636();
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
    checkUnnamed6636(o.details!);
    unittest.expect(
      o.message!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleRpcStatus--;
}

void main() {
  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1AnnotateVideoProgress', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1AnnotateVideoProgress();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1AnnotateVideoProgress.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1AnnotateVideoProgress(
          od as api.GoogleCloudVideointelligenceV1AnnotateVideoProgress);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1AnnotateVideoRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1AnnotateVideoRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1AnnotateVideoRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1AnnotateVideoRequest(
          od as api.GoogleCloudVideointelligenceV1AnnotateVideoRequest);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1AnnotateVideoResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1AnnotateVideoResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1AnnotateVideoResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1AnnotateVideoResponse(
          od as api.GoogleCloudVideointelligenceV1AnnotateVideoResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1DetectedAttribute',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1DetectedAttribute();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1DetectedAttribute.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1DetectedAttribute(
          od as api.GoogleCloudVideointelligenceV1DetectedAttribute);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1DetectedLandmark',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1DetectedLandmark();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1DetectedLandmark.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1DetectedLandmark(
          od as api.GoogleCloudVideointelligenceV1DetectedLandmark);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1Entity', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1Entity();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1Entity.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1Entity(
          od as api.GoogleCloudVideointelligenceV1Entity);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1ExplicitContentAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1ExplicitContentAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1ExplicitContentAnnotation.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1ExplicitContentAnnotation(
          od as api.GoogleCloudVideointelligenceV1ExplicitContentAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1ExplicitContentDetectionConfig',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1ExplicitContentDetectionConfig
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1ExplicitContentDetectionConfig(od
          as api.GoogleCloudVideointelligenceV1ExplicitContentDetectionConfig);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1ExplicitContentFrame', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1ExplicitContentFrame();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1ExplicitContentFrame.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1ExplicitContentFrame(
          od as api.GoogleCloudVideointelligenceV1ExplicitContentFrame);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1FaceAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1FaceAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1FaceAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1FaceAnnotation(
          od as api.GoogleCloudVideointelligenceV1FaceAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1FaceDetectionAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1FaceDetectionAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1FaceDetectionAnnotation.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1FaceDetectionAnnotation(
          od as api.GoogleCloudVideointelligenceV1FaceDetectionAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1FaceDetectionConfig',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1FaceDetectionConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1FaceDetectionConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1FaceDetectionConfig(
          od as api.GoogleCloudVideointelligenceV1FaceDetectionConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1FaceFrame', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1FaceFrame();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1FaceFrame.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1FaceFrame(
          od as api.GoogleCloudVideointelligenceV1FaceFrame);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1FaceSegment', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1FaceSegment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1FaceSegment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1FaceSegment(
          od as api.GoogleCloudVideointelligenceV1FaceSegment);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1LabelAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1LabelAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1LabelAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1LabelAnnotation(
          od as api.GoogleCloudVideointelligenceV1LabelAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1LabelDetectionConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1LabelDetectionConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1LabelDetectionConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1LabelDetectionConfig(
          od as api.GoogleCloudVideointelligenceV1LabelDetectionConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1LabelFrame', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1LabelFrame();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1LabelFrame.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1LabelFrame(
          od as api.GoogleCloudVideointelligenceV1LabelFrame);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1LabelSegment', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1LabelSegment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1LabelSegment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1LabelSegment(
          od as api.GoogleCloudVideointelligenceV1LabelSegment);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1LogoRecognitionAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1LogoRecognitionAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1LogoRecognitionAnnotation.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1LogoRecognitionAnnotation(
          od as api.GoogleCloudVideointelligenceV1LogoRecognitionAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1NormalizedBoundingBox', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1NormalizedBoundingBox();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1NormalizedBoundingBox.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1NormalizedBoundingBox(
          od as api.GoogleCloudVideointelligenceV1NormalizedBoundingBox);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1NormalizedBoundingPoly', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1NormalizedBoundingPoly();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1NormalizedBoundingPoly.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1NormalizedBoundingPoly(
          od as api.GoogleCloudVideointelligenceV1NormalizedBoundingPoly);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1NormalizedVertex',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1NormalizedVertex();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1NormalizedVertex.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1NormalizedVertex(
          od as api.GoogleCloudVideointelligenceV1NormalizedVertex);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1ObjectTrackingAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1ObjectTrackingAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1ObjectTrackingAnnotation.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1ObjectTrackingAnnotation(
          od as api.GoogleCloudVideointelligenceV1ObjectTrackingAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1ObjectTrackingConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1ObjectTrackingConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1ObjectTrackingConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1ObjectTrackingConfig(
          od as api.GoogleCloudVideointelligenceV1ObjectTrackingConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1ObjectTrackingFrame',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1ObjectTrackingFrame();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1ObjectTrackingFrame.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1ObjectTrackingFrame(
          od as api.GoogleCloudVideointelligenceV1ObjectTrackingFrame);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1PersonDetectionAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1PersonDetectionAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1PersonDetectionAnnotation.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1PersonDetectionAnnotation(
          od as api.GoogleCloudVideointelligenceV1PersonDetectionAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1PersonDetectionConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1PersonDetectionConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1PersonDetectionConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1PersonDetectionConfig(
          od as api.GoogleCloudVideointelligenceV1PersonDetectionConfig);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1ShotChangeDetectionConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1ShotChangeDetectionConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1ShotChangeDetectionConfig.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1ShotChangeDetectionConfig(
          od as api.GoogleCloudVideointelligenceV1ShotChangeDetectionConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1SpeechContext', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1SpeechContext();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1SpeechContext.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1SpeechContext(
          od as api.GoogleCloudVideointelligenceV1SpeechContext);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1SpeechRecognitionAlternative',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1SpeechRecognitionAlternative();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1SpeechRecognitionAlternative
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1SpeechRecognitionAlternative(
          od as api.GoogleCloudVideointelligenceV1SpeechRecognitionAlternative);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1SpeechTranscription',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1SpeechTranscription();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1SpeechTranscription.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1SpeechTranscription(
          od as api.GoogleCloudVideointelligenceV1SpeechTranscription);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1SpeechTranscriptionConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1SpeechTranscriptionConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1SpeechTranscriptionConfig.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1SpeechTranscriptionConfig(
          od as api.GoogleCloudVideointelligenceV1SpeechTranscriptionConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1TextAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1TextAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1TextAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1TextAnnotation(
          od as api.GoogleCloudVideointelligenceV1TextAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1TextDetectionConfig',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1TextDetectionConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1TextDetectionConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1TextDetectionConfig(
          od as api.GoogleCloudVideointelligenceV1TextDetectionConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1TextFrame', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1TextFrame();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1TextFrame.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1TextFrame(
          od as api.GoogleCloudVideointelligenceV1TextFrame);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1TextSegment', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1TextSegment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1TextSegment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1TextSegment(
          od as api.GoogleCloudVideointelligenceV1TextSegment);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1TimestampedObject',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1TimestampedObject();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1TimestampedObject.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1TimestampedObject(
          od as api.GoogleCloudVideointelligenceV1TimestampedObject);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1Track', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1Track();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1Track.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1Track(
          od as api.GoogleCloudVideointelligenceV1Track);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1VideoAnnotationProgress', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1VideoAnnotationProgress();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1VideoAnnotationProgress.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1VideoAnnotationProgress(
          od as api.GoogleCloudVideointelligenceV1VideoAnnotationProgress);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1VideoAnnotationResults', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1VideoAnnotationResults();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1VideoAnnotationResults.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1VideoAnnotationResults(
          od as api.GoogleCloudVideointelligenceV1VideoAnnotationResults);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1VideoContext', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1VideoContext();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1VideoContext.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1VideoContext(
          od as api.GoogleCloudVideointelligenceV1VideoContext);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1VideoSegment', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1VideoSegment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1VideoSegment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1VideoSegment(
          od as api.GoogleCloudVideointelligenceV1VideoSegment);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1WordInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1WordInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1WordInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1WordInfo(
          od as api.GoogleCloudVideointelligenceV1WordInfo);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1beta2AnnotateVideoProgress',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2AnnotateVideoProgress();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1beta2AnnotateVideoProgress.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2AnnotateVideoProgress(
          od as api.GoogleCloudVideointelligenceV1beta2AnnotateVideoProgress);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1beta2AnnotateVideoResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2AnnotateVideoResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1beta2AnnotateVideoResponse.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2AnnotateVideoResponse(
          od as api.GoogleCloudVideointelligenceV1beta2AnnotateVideoResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1beta2DetectedAttribute', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2DetectedAttribute();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1beta2DetectedAttribute.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2DetectedAttribute(
          od as api.GoogleCloudVideointelligenceV1beta2DetectedAttribute);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1beta2DetectedLandmark', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2DetectedLandmark();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1beta2DetectedLandmark.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2DetectedLandmark(
          od as api.GoogleCloudVideointelligenceV1beta2DetectedLandmark);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1beta2Entity', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2Entity();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1beta2Entity.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2Entity(
          od as api.GoogleCloudVideointelligenceV1beta2Entity);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation(od
          as api.GoogleCloudVideointelligenceV1beta2ExplicitContentAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1beta2ExplicitContentFrame', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2ExplicitContentFrame();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1beta2ExplicitContentFrame.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2ExplicitContentFrame(
          od as api.GoogleCloudVideointelligenceV1beta2ExplicitContentFrame);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1beta2FaceAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2FaceAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1beta2FaceAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2FaceAnnotation(
          od as api.GoogleCloudVideointelligenceV1beta2FaceAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation(
          od as api.GoogleCloudVideointelligenceV1beta2FaceDetectionAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1beta2FaceFrame', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2FaceFrame();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1beta2FaceFrame.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2FaceFrame(
          od as api.GoogleCloudVideointelligenceV1beta2FaceFrame);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1beta2FaceSegment',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2FaceSegment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1beta2FaceSegment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2FaceSegment(
          od as api.GoogleCloudVideointelligenceV1beta2FaceSegment);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1beta2LabelAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2LabelAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1beta2LabelAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2LabelAnnotation(
          od as api.GoogleCloudVideointelligenceV1beta2LabelAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1beta2LabelFrame',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2LabelFrame();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1beta2LabelFrame.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2LabelFrame(
          od as api.GoogleCloudVideointelligenceV1beta2LabelFrame);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1beta2LabelSegment',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2LabelSegment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1beta2LabelSegment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2LabelSegment(
          od as api.GoogleCloudVideointelligenceV1beta2LabelSegment);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation(od
          as api.GoogleCloudVideointelligenceV1beta2LogoRecognitionAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1beta2NormalizedBoundingBox',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2NormalizedBoundingBox();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1beta2NormalizedBoundingBox.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2NormalizedBoundingBox(
          od as api.GoogleCloudVideointelligenceV1beta2NormalizedBoundingBox);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1beta2NormalizedBoundingPoly',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2NormalizedBoundingPoly();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1beta2NormalizedBoundingPoly
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2NormalizedBoundingPoly(
          od as api.GoogleCloudVideointelligenceV1beta2NormalizedBoundingPoly);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1beta2NormalizedVertex', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2NormalizedVertex();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1beta2NormalizedVertex.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2NormalizedVertex(
          od as api.GoogleCloudVideointelligenceV1beta2NormalizedVertex);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation(od
          as api.GoogleCloudVideointelligenceV1beta2ObjectTrackingAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1beta2ObjectTrackingFrame', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2ObjectTrackingFrame();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1beta2ObjectTrackingFrame.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2ObjectTrackingFrame(
          od as api.GoogleCloudVideointelligenceV1beta2ObjectTrackingFrame);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation(od
          as api.GoogleCloudVideointelligenceV1beta2PersonDetectionAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative(od
          as api
              .GoogleCloudVideointelligenceV1beta2SpeechRecognitionAlternative);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1beta2SpeechTranscription', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2SpeechTranscription();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1beta2SpeechTranscription.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2SpeechTranscription(
          od as api.GoogleCloudVideointelligenceV1beta2SpeechTranscription);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1beta2TextAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2TextAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1beta2TextAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2TextAnnotation(
          od as api.GoogleCloudVideointelligenceV1beta2TextAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1beta2TextFrame', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2TextFrame();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1beta2TextFrame.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2TextFrame(
          od as api.GoogleCloudVideointelligenceV1beta2TextFrame);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1beta2TextSegment',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2TextSegment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1beta2TextSegment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2TextSegment(
          od as api.GoogleCloudVideointelligenceV1beta2TextSegment);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1beta2TimestampedObject', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2TimestampedObject();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1beta2TimestampedObject.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2TimestampedObject(
          od as api.GoogleCloudVideointelligenceV1beta2TimestampedObject);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1beta2Track', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2Track();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1beta2Track.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2Track(
          od as api.GoogleCloudVideointelligenceV1beta2Track);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1beta2VideoAnnotationProgress',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1beta2VideoAnnotationProgress
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2VideoAnnotationProgress(
          od as api.GoogleCloudVideointelligenceV1beta2VideoAnnotationProgress);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1beta2VideoAnnotationResults',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2VideoAnnotationResults();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1beta2VideoAnnotationResults
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2VideoAnnotationResults(
          od as api.GoogleCloudVideointelligenceV1beta2VideoAnnotationResults);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1beta2VideoSegment',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2VideoSegment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1beta2VideoSegment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2VideoSegment(
          od as api.GoogleCloudVideointelligenceV1beta2VideoSegment);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1beta2WordInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1beta2WordInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1beta2WordInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1beta2WordInfo(
          od as api.GoogleCloudVideointelligenceV1beta2WordInfo);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress(
          od as api.GoogleCloudVideointelligenceV1p1beta1AnnotateVideoProgress);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse(
          od as api.GoogleCloudVideointelligenceV1p1beta1AnnotateVideoResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p1beta1DetectedAttribute', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p1beta1DetectedAttribute();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p1beta1DetectedAttribute.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1DetectedAttribute(
          od as api.GoogleCloudVideointelligenceV1p1beta1DetectedAttribute);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p1beta1DetectedLandmark', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p1beta1DetectedLandmark();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p1beta1DetectedLandmark.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1DetectedLandmark(
          od as api.GoogleCloudVideointelligenceV1p1beta1DetectedLandmark);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p1beta1Entity', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p1beta1Entity();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p1beta1Entity.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1Entity(
          od as api.GoogleCloudVideointelligenceV1p1beta1Entity);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation(od
          as api
              .GoogleCloudVideointelligenceV1p1beta1ExplicitContentAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame(
          od as api.GoogleCloudVideointelligenceV1p1beta1ExplicitContentFrame);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p1beta1FaceAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p1beta1FaceAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p1beta1FaceAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1FaceAnnotation(
          od as api.GoogleCloudVideointelligenceV1p1beta1FaceAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation(od
          as api.GoogleCloudVideointelligenceV1p1beta1FaceDetectionAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p1beta1FaceFrame',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p1beta1FaceFrame();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p1beta1FaceFrame.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1FaceFrame(
          od as api.GoogleCloudVideointelligenceV1p1beta1FaceFrame);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p1beta1FaceSegment',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p1beta1FaceSegment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p1beta1FaceSegment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1FaceSegment(
          od as api.GoogleCloudVideointelligenceV1p1beta1FaceSegment);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p1beta1LabelAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p1beta1LabelAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1LabelAnnotation(
          od as api.GoogleCloudVideointelligenceV1p1beta1LabelAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p1beta1LabelFrame',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p1beta1LabelFrame();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p1beta1LabelFrame.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1LabelFrame(
          od as api.GoogleCloudVideointelligenceV1p1beta1LabelFrame);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p1beta1LabelSegment',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p1beta1LabelSegment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p1beta1LabelSegment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1LabelSegment(
          od as api.GoogleCloudVideointelligenceV1p1beta1LabelSegment);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation(od
          as api
              .GoogleCloudVideointelligenceV1p1beta1LogoRecognitionAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox(
          od as api.GoogleCloudVideointelligenceV1p1beta1NormalizedBoundingBox);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p1beta1NormalizedBoundingPoly',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingPoly();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p1beta1NormalizedBoundingPoly
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1NormalizedBoundingPoly(od
          as api.GoogleCloudVideointelligenceV1p1beta1NormalizedBoundingPoly);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p1beta1NormalizedVertex', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p1beta1NormalizedVertex();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p1beta1NormalizedVertex.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1NormalizedVertex(
          od as api.GoogleCloudVideointelligenceV1p1beta1NormalizedVertex);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation(od
          as api.GoogleCloudVideointelligenceV1p1beta1ObjectTrackingAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame(
          od as api.GoogleCloudVideointelligenceV1p1beta1ObjectTrackingFrame);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation(od
          as api
              .GoogleCloudVideointelligenceV1p1beta1PersonDetectionAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative(od
          as api
              .GoogleCloudVideointelligenceV1p1beta1SpeechRecognitionAlternative);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p1beta1SpeechTranscription',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p1beta1SpeechTranscription();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p1beta1SpeechTranscription.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1SpeechTranscription(
          od as api.GoogleCloudVideointelligenceV1p1beta1SpeechTranscription);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p1beta1TextAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p1beta1TextAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p1beta1TextAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1TextAnnotation(
          od as api.GoogleCloudVideointelligenceV1p1beta1TextAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p1beta1TextFrame',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p1beta1TextFrame();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p1beta1TextFrame.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1TextFrame(
          od as api.GoogleCloudVideointelligenceV1p1beta1TextFrame);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p1beta1TextSegment',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p1beta1TextSegment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p1beta1TextSegment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1TextSegment(
          od as api.GoogleCloudVideointelligenceV1p1beta1TextSegment);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p1beta1TimestampedObject', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p1beta1TimestampedObject();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p1beta1TimestampedObject.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1TimestampedObject(
          od as api.GoogleCloudVideointelligenceV1p1beta1TimestampedObject);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p1beta1Track', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p1beta1Track();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p1beta1Track.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1Track(
          od as api.GoogleCloudVideointelligenceV1p1beta1Track);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress(od
          as api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationProgress);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults(od
          as api.GoogleCloudVideointelligenceV1p1beta1VideoAnnotationResults);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p1beta1VideoSegment',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p1beta1VideoSegment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p1beta1VideoSegment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1VideoSegment(
          od as api.GoogleCloudVideointelligenceV1p1beta1VideoSegment);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p1beta1WordInfo',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p1beta1WordInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p1beta1WordInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p1beta1WordInfo(
          od as api.GoogleCloudVideointelligenceV1p1beta1WordInfo);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress(
          od as api.GoogleCloudVideointelligenceV1p2beta1AnnotateVideoProgress);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse(
          od as api.GoogleCloudVideointelligenceV1p2beta1AnnotateVideoResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p2beta1DetectedAttribute', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p2beta1DetectedAttribute();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p2beta1DetectedAttribute.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1DetectedAttribute(
          od as api.GoogleCloudVideointelligenceV1p2beta1DetectedAttribute);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p2beta1DetectedLandmark', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p2beta1DetectedLandmark();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p2beta1DetectedLandmark.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1DetectedLandmark(
          od as api.GoogleCloudVideointelligenceV1p2beta1DetectedLandmark);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p2beta1Entity', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p2beta1Entity();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p2beta1Entity.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1Entity(
          od as api.GoogleCloudVideointelligenceV1p2beta1Entity);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation(od
          as api
              .GoogleCloudVideointelligenceV1p2beta1ExplicitContentAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame(
          od as api.GoogleCloudVideointelligenceV1p2beta1ExplicitContentFrame);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p2beta1FaceAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p2beta1FaceAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p2beta1FaceAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1FaceAnnotation(
          od as api.GoogleCloudVideointelligenceV1p2beta1FaceAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation(od
          as api.GoogleCloudVideointelligenceV1p2beta1FaceDetectionAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p2beta1FaceFrame',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p2beta1FaceFrame();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p2beta1FaceFrame.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1FaceFrame(
          od as api.GoogleCloudVideointelligenceV1p2beta1FaceFrame);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p2beta1FaceSegment',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p2beta1FaceSegment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p2beta1FaceSegment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1FaceSegment(
          od as api.GoogleCloudVideointelligenceV1p2beta1FaceSegment);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p2beta1LabelAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p2beta1LabelAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1LabelAnnotation(
          od as api.GoogleCloudVideointelligenceV1p2beta1LabelAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p2beta1LabelFrame',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p2beta1LabelFrame();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p2beta1LabelFrame.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1LabelFrame(
          od as api.GoogleCloudVideointelligenceV1p2beta1LabelFrame);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p2beta1LabelSegment',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p2beta1LabelSegment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p2beta1LabelSegment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1LabelSegment(
          od as api.GoogleCloudVideointelligenceV1p2beta1LabelSegment);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation(od
          as api
              .GoogleCloudVideointelligenceV1p2beta1LogoRecognitionAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox(
          od as api.GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingBox);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly(od
          as api.GoogleCloudVideointelligenceV1p2beta1NormalizedBoundingPoly);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p2beta1NormalizedVertex', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p2beta1NormalizedVertex();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p2beta1NormalizedVertex.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1NormalizedVertex(
          od as api.GoogleCloudVideointelligenceV1p2beta1NormalizedVertex);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation(od
          as api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame(
          od as api.GoogleCloudVideointelligenceV1p2beta1ObjectTrackingFrame);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation(od
          as api
              .GoogleCloudVideointelligenceV1p2beta1PersonDetectionAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative(od
          as api
              .GoogleCloudVideointelligenceV1p2beta1SpeechRecognitionAlternative);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p2beta1SpeechTranscription',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p2beta1SpeechTranscription();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p2beta1SpeechTranscription.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1SpeechTranscription(
          od as api.GoogleCloudVideointelligenceV1p2beta1SpeechTranscription);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p2beta1TextAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p2beta1TextAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p2beta1TextAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1TextAnnotation(
          od as api.GoogleCloudVideointelligenceV1p2beta1TextAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p2beta1TextFrame',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p2beta1TextFrame();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p2beta1TextFrame.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1TextFrame(
          od as api.GoogleCloudVideointelligenceV1p2beta1TextFrame);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p2beta1TextSegment',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p2beta1TextSegment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p2beta1TextSegment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1TextSegment(
          od as api.GoogleCloudVideointelligenceV1p2beta1TextSegment);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p2beta1TimestampedObject', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p2beta1TimestampedObject();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p2beta1TimestampedObject.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1TimestampedObject(
          od as api.GoogleCloudVideointelligenceV1p2beta1TimestampedObject);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p2beta1Track', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p2beta1Track();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p2beta1Track.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1Track(
          od as api.GoogleCloudVideointelligenceV1p2beta1Track);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress(od
          as api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationProgress);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults(od
          as api.GoogleCloudVideointelligenceV1p2beta1VideoAnnotationResults);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p2beta1VideoSegment',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p2beta1VideoSegment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p2beta1VideoSegment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1VideoSegment(
          od as api.GoogleCloudVideointelligenceV1p2beta1VideoSegment);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p2beta1WordInfo',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p2beta1WordInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p2beta1WordInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p2beta1WordInfo(
          od as api.GoogleCloudVideointelligenceV1p2beta1WordInfo);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1AnnotateVideoProgress',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1AnnotateVideoProgress();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p3beta1AnnotateVideoProgress
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1AnnotateVideoProgress(
          od as api.GoogleCloudVideointelligenceV1p3beta1AnnotateVideoProgress);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1AnnotateVideoResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1AnnotateVideoResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p3beta1AnnotateVideoResponse
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1AnnotateVideoResponse(
          od as api.GoogleCloudVideointelligenceV1p3beta1AnnotateVideoResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p3beta1Celebrity',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1Celebrity();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p3beta1Celebrity.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1Celebrity(
          od as api.GoogleCloudVideointelligenceV1p3beta1Celebrity);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1CelebrityRecognitionAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p3beta1CelebrityRecognitionAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p3beta1CelebrityRecognitionAnnotation
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1CelebrityRecognitionAnnotation(
          od as api
              .GoogleCloudVideointelligenceV1p3beta1CelebrityRecognitionAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1CelebrityTrack', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1CelebrityTrack();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p3beta1CelebrityTrack.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1CelebrityTrack(
          od as api.GoogleCloudVideointelligenceV1p3beta1CelebrityTrack);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1DetectedAttribute', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1DetectedAttribute();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p3beta1DetectedAttribute.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1DetectedAttribute(
          od as api.GoogleCloudVideointelligenceV1p3beta1DetectedAttribute);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1DetectedLandmark', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1DetectedLandmark();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p3beta1DetectedLandmark.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1DetectedLandmark(
          od as api.GoogleCloudVideointelligenceV1p3beta1DetectedLandmark);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p3beta1Entity', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1Entity();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p3beta1Entity.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1Entity(
          od as api.GoogleCloudVideointelligenceV1p3beta1Entity);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1ExplicitContentAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p3beta1ExplicitContentAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p3beta1ExplicitContentAnnotation
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1ExplicitContentAnnotation(od
          as api
              .GoogleCloudVideointelligenceV1p3beta1ExplicitContentAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame(
          od as api.GoogleCloudVideointelligenceV1p3beta1ExplicitContentFrame);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1FaceAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1FaceAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p3beta1FaceAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1FaceAnnotation(
          od as api.GoogleCloudVideointelligenceV1p3beta1FaceAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation(od
          as api.GoogleCloudVideointelligenceV1p3beta1FaceDetectionAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p3beta1FaceFrame',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1FaceFrame();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p3beta1FaceFrame.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1FaceFrame(
          od as api.GoogleCloudVideointelligenceV1p3beta1FaceFrame);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p3beta1FaceSegment',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1FaceSegment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p3beta1FaceSegment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1FaceSegment(
          od as api.GoogleCloudVideointelligenceV1p3beta1FaceSegment);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1LabelAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1LabelAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1LabelAnnotation(
          od as api.GoogleCloudVideointelligenceV1p3beta1LabelAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p3beta1LabelFrame',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1LabelFrame();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p3beta1LabelFrame.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1LabelFrame(
          od as api.GoogleCloudVideointelligenceV1p3beta1LabelFrame);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p3beta1LabelSegment',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1LabelSegment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p3beta1LabelSegment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1LabelSegment(
          od as api.GoogleCloudVideointelligenceV1p3beta1LabelSegment);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation(od
          as api
              .GoogleCloudVideointelligenceV1p3beta1LogoRecognitionAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox(
          od as api.GoogleCloudVideointelligenceV1p3beta1NormalizedBoundingBox);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1NormalizedBoundingPoly',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingPoly();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p3beta1NormalizedBoundingPoly
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1NormalizedBoundingPoly(od
          as api.GoogleCloudVideointelligenceV1p3beta1NormalizedBoundingPoly);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1NormalizedVertex', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1NormalizedVertex();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p3beta1NormalizedVertex.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1NormalizedVertex(
          od as api.GoogleCloudVideointelligenceV1p3beta1NormalizedVertex);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation(od
          as api.GoogleCloudVideointelligenceV1p3beta1ObjectTrackingAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame(
          od as api.GoogleCloudVideointelligenceV1p3beta1ObjectTrackingFrame);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation(od
          as api
              .GoogleCloudVideointelligenceV1p3beta1PersonDetectionAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity(
          od as api.GoogleCloudVideointelligenceV1p3beta1RecognizedCelebrity);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative(od
          as api
              .GoogleCloudVideointelligenceV1p3beta1SpeechRecognitionAlternative);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1SpeechTranscription',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1SpeechTranscription();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p3beta1SpeechTranscription.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1SpeechTranscription(
          od as api.GoogleCloudVideointelligenceV1p3beta1SpeechTranscription);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1StreamingAnnotateVideoResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p3beta1StreamingAnnotateVideoResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p3beta1StreamingAnnotateVideoResponse
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1StreamingAnnotateVideoResponse(
          od as api
              .GoogleCloudVideointelligenceV1p3beta1StreamingAnnotateVideoResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1StreamingVideoAnnotationResults',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p3beta1StreamingVideoAnnotationResults();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p3beta1StreamingVideoAnnotationResults
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1StreamingVideoAnnotationResults(
          od as api
              .GoogleCloudVideointelligenceV1p3beta1StreamingVideoAnnotationResults);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1TextAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1TextAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p3beta1TextAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1TextAnnotation(
          od as api.GoogleCloudVideointelligenceV1p3beta1TextAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p3beta1TextFrame',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1TextFrame();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p3beta1TextFrame.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1TextFrame(
          od as api.GoogleCloudVideointelligenceV1p3beta1TextFrame);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p3beta1TextSegment',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1TextSegment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p3beta1TextSegment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1TextSegment(
          od as api.GoogleCloudVideointelligenceV1p3beta1TextSegment);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1TimestampedObject', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1TimestampedObject();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVideointelligenceV1p3beta1TimestampedObject.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1TimestampedObject(
          od as api.GoogleCloudVideointelligenceV1p3beta1TimestampedObject);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p3beta1Track', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1Track();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p3beta1Track.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1Track(
          od as api.GoogleCloudVideointelligenceV1p3beta1Track);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress(od
          as api.GoogleCloudVideointelligenceV1p3beta1VideoAnnotationProgress);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults(od
          as api.GoogleCloudVideointelligenceV1p3beta1VideoAnnotationResults);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p3beta1VideoSegment',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1VideoSegment();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p3beta1VideoSegment.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1VideoSegment(
          od as api.GoogleCloudVideointelligenceV1p3beta1VideoSegment);
    });
  });

  unittest.group('obj-schema-GoogleCloudVideointelligenceV1p3beta1WordInfo',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVideointelligenceV1p3beta1WordInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVideointelligenceV1p3beta1WordInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVideointelligenceV1p3beta1WordInfo(
          od as api.GoogleCloudVideointelligenceV1p3beta1WordInfo);
    });
  });

  unittest.group('obj-schema-GoogleLongrunningCancelOperationRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleLongrunningCancelOperationRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleLongrunningCancelOperationRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleLongrunningCancelOperationRequest(
          od as api.GoogleLongrunningCancelOperationRequest);
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

  unittest.group('resource-OperationsProjectsLocationsOperationsResource', () {
    unittest.test('method--cancel', () async {
      var mock = HttpServerMock();
      var res = api.CloudVideoIntelligenceApi(mock)
          .operations
          .projects
          .locations
          .operations;
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
          path.substring(pathOffset, pathOffset + 14),
          unittest.equals("v1/operations/"),
        );
        pathOffset += 14;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
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

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.CloudVideoIntelligenceApi(mock)
          .operations
          .projects
          .locations
          .operations;
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
          path.substring(pathOffset, pathOffset + 14),
          unittest.equals("v1/operations/"),
        );
        pathOffset += 14;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
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
      var res = api.CloudVideoIntelligenceApi(mock)
          .operations
          .projects
          .locations
          .operations;
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
          path.substring(pathOffset, pathOffset + 14),
          unittest.equals("v1/operations/"),
        );
        pathOffset += 14;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
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
  });

  unittest.group('resource-ProjectsLocationsOperationsResource', () {
    unittest.test('method--cancel', () async {
      var mock = HttpServerMock();
      var res =
          api.CloudVideoIntelligenceApi(mock).projects.locations.operations;
      var arg_request = buildGoogleLongrunningCancelOperationRequest();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.GoogleLongrunningCancelOperationRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkGoogleLongrunningCancelOperationRequest(
            obj as api.GoogleLongrunningCancelOperationRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 3),
          unittest.equals("v1/"),
        );
        pathOffset += 3;
        // NOTE: We cannot test reserved expansions due to the inability to reverse the operation;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
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
          await res.cancel(arg_request, arg_name, $fields: arg_$fields);
      checkGoogleProtobufEmpty(response as api.GoogleProtobufEmpty);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res =
          api.CloudVideoIntelligenceApi(mock).projects.locations.operations;
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
      var res =
          api.CloudVideoIntelligenceApi(mock).projects.locations.operations;
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
      var res =
          api.CloudVideoIntelligenceApi(mock).projects.locations.operations;
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

  unittest.group('resource-VideosResource', () {
    unittest.test('method--annotate', () async {
      var mock = HttpServerMock();
      var res = api.CloudVideoIntelligenceApi(mock).videos;
      var arg_request =
          buildGoogleCloudVideointelligenceV1AnnotateVideoRequest();
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj =
            api.GoogleCloudVideointelligenceV1AnnotateVideoRequest.fromJson(
                json as core.Map<core.String, core.dynamic>);
        checkGoogleCloudVideointelligenceV1AnnotateVideoRequest(
            obj as api.GoogleCloudVideointelligenceV1AnnotateVideoRequest);

        var path = (req.url).path;
        var pathOffset = 0;
        core.int index;
        core.String subPart;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 1),
          unittest.equals("/"),
        );
        pathOffset += 1;
        unittest.expect(
          path.substring(pathOffset, pathOffset + 18),
          unittest.equals("v1/videos:annotate"),
        );
        pathOffset += 18;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = <core.String, core.List<core.String>>{};
        void addQueryParam(core.String n, core.String v) =>
            queryMap.putIfAbsent(n, () => []).add(v);

        if (query.isNotEmpty) {
          for (var part in query.split('&')) {
            var keyValue = part.split('=');
            addQueryParam(
              core.Uri.decodeQueryComponent(keyValue[0]),
              core.Uri.decodeQueryComponent(keyValue[1]),
            );
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
      final response = await res.annotate(arg_request, $fields: arg_$fields);
      checkGoogleLongrunningOperation(
          response as api.GoogleLongrunningOperation);
    });
  });
}
