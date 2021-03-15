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
import 'package:googleapis/vision/v1.dart' as api;

import '../test_shared.dart';

core.int buildCounterAddProductToProductSetRequest = 0;
api.AddProductToProductSetRequest buildAddProductToProductSetRequest() {
  var o = api.AddProductToProductSetRequest();
  buildCounterAddProductToProductSetRequest++;
  if (buildCounterAddProductToProductSetRequest < 3) {
    o.product = 'foo';
  }
  buildCounterAddProductToProductSetRequest--;
  return o;
}

void checkAddProductToProductSetRequest(api.AddProductToProductSetRequest o) {
  buildCounterAddProductToProductSetRequest++;
  if (buildCounterAddProductToProductSetRequest < 3) {
    unittest.expect(
      o.product!,
      unittest.equals('foo'),
    );
  }
  buildCounterAddProductToProductSetRequest--;
}

core.List<api.Feature> buildUnnamed6238() {
  var o = <api.Feature>[];
  o.add(buildFeature());
  o.add(buildFeature());
  return o;
}

void checkUnnamed6238(core.List<api.Feature> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkFeature(o[0] as api.Feature);
  checkFeature(o[1] as api.Feature);
}

core.List<core.int> buildUnnamed6239() {
  var o = <core.int>[];
  o.add(42);
  o.add(42);
  return o;
}

void checkUnnamed6239(core.List<core.int> o) {
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

core.int buildCounterAnnotateFileRequest = 0;
api.AnnotateFileRequest buildAnnotateFileRequest() {
  var o = api.AnnotateFileRequest();
  buildCounterAnnotateFileRequest++;
  if (buildCounterAnnotateFileRequest < 3) {
    o.features = buildUnnamed6238();
    o.imageContext = buildImageContext();
    o.inputConfig = buildInputConfig();
    o.pages = buildUnnamed6239();
  }
  buildCounterAnnotateFileRequest--;
  return o;
}

void checkAnnotateFileRequest(api.AnnotateFileRequest o) {
  buildCounterAnnotateFileRequest++;
  if (buildCounterAnnotateFileRequest < 3) {
    checkUnnamed6238(o.features!);
    checkImageContext(o.imageContext! as api.ImageContext);
    checkInputConfig(o.inputConfig! as api.InputConfig);
    checkUnnamed6239(o.pages!);
  }
  buildCounterAnnotateFileRequest--;
}

core.List<api.AnnotateImageResponse> buildUnnamed6240() {
  var o = <api.AnnotateImageResponse>[];
  o.add(buildAnnotateImageResponse());
  o.add(buildAnnotateImageResponse());
  return o;
}

void checkUnnamed6240(core.List<api.AnnotateImageResponse> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAnnotateImageResponse(o[0] as api.AnnotateImageResponse);
  checkAnnotateImageResponse(o[1] as api.AnnotateImageResponse);
}

core.int buildCounterAnnotateFileResponse = 0;
api.AnnotateFileResponse buildAnnotateFileResponse() {
  var o = api.AnnotateFileResponse();
  buildCounterAnnotateFileResponse++;
  if (buildCounterAnnotateFileResponse < 3) {
    o.error = buildStatus();
    o.inputConfig = buildInputConfig();
    o.responses = buildUnnamed6240();
    o.totalPages = 42;
  }
  buildCounterAnnotateFileResponse--;
  return o;
}

void checkAnnotateFileResponse(api.AnnotateFileResponse o) {
  buildCounterAnnotateFileResponse++;
  if (buildCounterAnnotateFileResponse < 3) {
    checkStatus(o.error! as api.Status);
    checkInputConfig(o.inputConfig! as api.InputConfig);
    checkUnnamed6240(o.responses!);
    unittest.expect(
      o.totalPages!,
      unittest.equals(42),
    );
  }
  buildCounterAnnotateFileResponse--;
}

core.List<api.Feature> buildUnnamed6241() {
  var o = <api.Feature>[];
  o.add(buildFeature());
  o.add(buildFeature());
  return o;
}

void checkUnnamed6241(core.List<api.Feature> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkFeature(o[0] as api.Feature);
  checkFeature(o[1] as api.Feature);
}

core.int buildCounterAnnotateImageRequest = 0;
api.AnnotateImageRequest buildAnnotateImageRequest() {
  var o = api.AnnotateImageRequest();
  buildCounterAnnotateImageRequest++;
  if (buildCounterAnnotateImageRequest < 3) {
    o.features = buildUnnamed6241();
    o.image = buildImage();
    o.imageContext = buildImageContext();
  }
  buildCounterAnnotateImageRequest--;
  return o;
}

void checkAnnotateImageRequest(api.AnnotateImageRequest o) {
  buildCounterAnnotateImageRequest++;
  if (buildCounterAnnotateImageRequest < 3) {
    checkUnnamed6241(o.features!);
    checkImage(o.image! as api.Image);
    checkImageContext(o.imageContext! as api.ImageContext);
  }
  buildCounterAnnotateImageRequest--;
}

core.List<api.FaceAnnotation> buildUnnamed6242() {
  var o = <api.FaceAnnotation>[];
  o.add(buildFaceAnnotation());
  o.add(buildFaceAnnotation());
  return o;
}

void checkUnnamed6242(core.List<api.FaceAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkFaceAnnotation(o[0] as api.FaceAnnotation);
  checkFaceAnnotation(o[1] as api.FaceAnnotation);
}

core.List<api.EntityAnnotation> buildUnnamed6243() {
  var o = <api.EntityAnnotation>[];
  o.add(buildEntityAnnotation());
  o.add(buildEntityAnnotation());
  return o;
}

void checkUnnamed6243(core.List<api.EntityAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEntityAnnotation(o[0] as api.EntityAnnotation);
  checkEntityAnnotation(o[1] as api.EntityAnnotation);
}

core.List<api.EntityAnnotation> buildUnnamed6244() {
  var o = <api.EntityAnnotation>[];
  o.add(buildEntityAnnotation());
  o.add(buildEntityAnnotation());
  return o;
}

void checkUnnamed6244(core.List<api.EntityAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEntityAnnotation(o[0] as api.EntityAnnotation);
  checkEntityAnnotation(o[1] as api.EntityAnnotation);
}

core.List<api.LocalizedObjectAnnotation> buildUnnamed6245() {
  var o = <api.LocalizedObjectAnnotation>[];
  o.add(buildLocalizedObjectAnnotation());
  o.add(buildLocalizedObjectAnnotation());
  return o;
}

void checkUnnamed6245(core.List<api.LocalizedObjectAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLocalizedObjectAnnotation(o[0] as api.LocalizedObjectAnnotation);
  checkLocalizedObjectAnnotation(o[1] as api.LocalizedObjectAnnotation);
}

core.List<api.EntityAnnotation> buildUnnamed6246() {
  var o = <api.EntityAnnotation>[];
  o.add(buildEntityAnnotation());
  o.add(buildEntityAnnotation());
  return o;
}

void checkUnnamed6246(core.List<api.EntityAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEntityAnnotation(o[0] as api.EntityAnnotation);
  checkEntityAnnotation(o[1] as api.EntityAnnotation);
}

core.List<api.EntityAnnotation> buildUnnamed6247() {
  var o = <api.EntityAnnotation>[];
  o.add(buildEntityAnnotation());
  o.add(buildEntityAnnotation());
  return o;
}

void checkUnnamed6247(core.List<api.EntityAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkEntityAnnotation(o[0] as api.EntityAnnotation);
  checkEntityAnnotation(o[1] as api.EntityAnnotation);
}

core.int buildCounterAnnotateImageResponse = 0;
api.AnnotateImageResponse buildAnnotateImageResponse() {
  var o = api.AnnotateImageResponse();
  buildCounterAnnotateImageResponse++;
  if (buildCounterAnnotateImageResponse < 3) {
    o.context = buildImageAnnotationContext();
    o.cropHintsAnnotation = buildCropHintsAnnotation();
    o.error = buildStatus();
    o.faceAnnotations = buildUnnamed6242();
    o.fullTextAnnotation = buildTextAnnotation();
    o.imagePropertiesAnnotation = buildImageProperties();
    o.labelAnnotations = buildUnnamed6243();
    o.landmarkAnnotations = buildUnnamed6244();
    o.localizedObjectAnnotations = buildUnnamed6245();
    o.logoAnnotations = buildUnnamed6246();
    o.productSearchResults = buildProductSearchResults();
    o.safeSearchAnnotation = buildSafeSearchAnnotation();
    o.textAnnotations = buildUnnamed6247();
    o.webDetection = buildWebDetection();
  }
  buildCounterAnnotateImageResponse--;
  return o;
}

void checkAnnotateImageResponse(api.AnnotateImageResponse o) {
  buildCounterAnnotateImageResponse++;
  if (buildCounterAnnotateImageResponse < 3) {
    checkImageAnnotationContext(o.context! as api.ImageAnnotationContext);
    checkCropHintsAnnotation(o.cropHintsAnnotation! as api.CropHintsAnnotation);
    checkStatus(o.error! as api.Status);
    checkUnnamed6242(o.faceAnnotations!);
    checkTextAnnotation(o.fullTextAnnotation! as api.TextAnnotation);
    checkImageProperties(o.imagePropertiesAnnotation! as api.ImageProperties);
    checkUnnamed6243(o.labelAnnotations!);
    checkUnnamed6244(o.landmarkAnnotations!);
    checkUnnamed6245(o.localizedObjectAnnotations!);
    checkUnnamed6246(o.logoAnnotations!);
    checkProductSearchResults(
        o.productSearchResults! as api.ProductSearchResults);
    checkSafeSearchAnnotation(
        o.safeSearchAnnotation! as api.SafeSearchAnnotation);
    checkUnnamed6247(o.textAnnotations!);
    checkWebDetection(o.webDetection! as api.WebDetection);
  }
  buildCounterAnnotateImageResponse--;
}

core.List<api.Feature> buildUnnamed6248() {
  var o = <api.Feature>[];
  o.add(buildFeature());
  o.add(buildFeature());
  return o;
}

void checkUnnamed6248(core.List<api.Feature> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkFeature(o[0] as api.Feature);
  checkFeature(o[1] as api.Feature);
}

core.int buildCounterAsyncAnnotateFileRequest = 0;
api.AsyncAnnotateFileRequest buildAsyncAnnotateFileRequest() {
  var o = api.AsyncAnnotateFileRequest();
  buildCounterAsyncAnnotateFileRequest++;
  if (buildCounterAsyncAnnotateFileRequest < 3) {
    o.features = buildUnnamed6248();
    o.imageContext = buildImageContext();
    o.inputConfig = buildInputConfig();
    o.outputConfig = buildOutputConfig();
  }
  buildCounterAsyncAnnotateFileRequest--;
  return o;
}

void checkAsyncAnnotateFileRequest(api.AsyncAnnotateFileRequest o) {
  buildCounterAsyncAnnotateFileRequest++;
  if (buildCounterAsyncAnnotateFileRequest < 3) {
    checkUnnamed6248(o.features!);
    checkImageContext(o.imageContext! as api.ImageContext);
    checkInputConfig(o.inputConfig! as api.InputConfig);
    checkOutputConfig(o.outputConfig! as api.OutputConfig);
  }
  buildCounterAsyncAnnotateFileRequest--;
}

core.int buildCounterAsyncAnnotateFileResponse = 0;
api.AsyncAnnotateFileResponse buildAsyncAnnotateFileResponse() {
  var o = api.AsyncAnnotateFileResponse();
  buildCounterAsyncAnnotateFileResponse++;
  if (buildCounterAsyncAnnotateFileResponse < 3) {
    o.outputConfig = buildOutputConfig();
  }
  buildCounterAsyncAnnotateFileResponse--;
  return o;
}

void checkAsyncAnnotateFileResponse(api.AsyncAnnotateFileResponse o) {
  buildCounterAsyncAnnotateFileResponse++;
  if (buildCounterAsyncAnnotateFileResponse < 3) {
    checkOutputConfig(o.outputConfig! as api.OutputConfig);
  }
  buildCounterAsyncAnnotateFileResponse--;
}

core.List<api.AsyncAnnotateFileRequest> buildUnnamed6249() {
  var o = <api.AsyncAnnotateFileRequest>[];
  o.add(buildAsyncAnnotateFileRequest());
  o.add(buildAsyncAnnotateFileRequest());
  return o;
}

void checkUnnamed6249(core.List<api.AsyncAnnotateFileRequest> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAsyncAnnotateFileRequest(o[0] as api.AsyncAnnotateFileRequest);
  checkAsyncAnnotateFileRequest(o[1] as api.AsyncAnnotateFileRequest);
}

core.int buildCounterAsyncBatchAnnotateFilesRequest = 0;
api.AsyncBatchAnnotateFilesRequest buildAsyncBatchAnnotateFilesRequest() {
  var o = api.AsyncBatchAnnotateFilesRequest();
  buildCounterAsyncBatchAnnotateFilesRequest++;
  if (buildCounterAsyncBatchAnnotateFilesRequest < 3) {
    o.parent = 'foo';
    o.requests = buildUnnamed6249();
  }
  buildCounterAsyncBatchAnnotateFilesRequest--;
  return o;
}

void checkAsyncBatchAnnotateFilesRequest(api.AsyncBatchAnnotateFilesRequest o) {
  buildCounterAsyncBatchAnnotateFilesRequest++;
  if (buildCounterAsyncBatchAnnotateFilesRequest < 3) {
    unittest.expect(
      o.parent!,
      unittest.equals('foo'),
    );
    checkUnnamed6249(o.requests!);
  }
  buildCounterAsyncBatchAnnotateFilesRequest--;
}

core.List<api.AsyncAnnotateFileResponse> buildUnnamed6250() {
  var o = <api.AsyncAnnotateFileResponse>[];
  o.add(buildAsyncAnnotateFileResponse());
  o.add(buildAsyncAnnotateFileResponse());
  return o;
}

void checkUnnamed6250(core.List<api.AsyncAnnotateFileResponse> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAsyncAnnotateFileResponse(o[0] as api.AsyncAnnotateFileResponse);
  checkAsyncAnnotateFileResponse(o[1] as api.AsyncAnnotateFileResponse);
}

core.int buildCounterAsyncBatchAnnotateFilesResponse = 0;
api.AsyncBatchAnnotateFilesResponse buildAsyncBatchAnnotateFilesResponse() {
  var o = api.AsyncBatchAnnotateFilesResponse();
  buildCounterAsyncBatchAnnotateFilesResponse++;
  if (buildCounterAsyncBatchAnnotateFilesResponse < 3) {
    o.responses = buildUnnamed6250();
  }
  buildCounterAsyncBatchAnnotateFilesResponse--;
  return o;
}

void checkAsyncBatchAnnotateFilesResponse(
    api.AsyncBatchAnnotateFilesResponse o) {
  buildCounterAsyncBatchAnnotateFilesResponse++;
  if (buildCounterAsyncBatchAnnotateFilesResponse < 3) {
    checkUnnamed6250(o.responses!);
  }
  buildCounterAsyncBatchAnnotateFilesResponse--;
}

core.List<api.AnnotateImageRequest> buildUnnamed6251() {
  var o = <api.AnnotateImageRequest>[];
  o.add(buildAnnotateImageRequest());
  o.add(buildAnnotateImageRequest());
  return o;
}

void checkUnnamed6251(core.List<api.AnnotateImageRequest> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAnnotateImageRequest(o[0] as api.AnnotateImageRequest);
  checkAnnotateImageRequest(o[1] as api.AnnotateImageRequest);
}

core.int buildCounterAsyncBatchAnnotateImagesRequest = 0;
api.AsyncBatchAnnotateImagesRequest buildAsyncBatchAnnotateImagesRequest() {
  var o = api.AsyncBatchAnnotateImagesRequest();
  buildCounterAsyncBatchAnnotateImagesRequest++;
  if (buildCounterAsyncBatchAnnotateImagesRequest < 3) {
    o.outputConfig = buildOutputConfig();
    o.parent = 'foo';
    o.requests = buildUnnamed6251();
  }
  buildCounterAsyncBatchAnnotateImagesRequest--;
  return o;
}

void checkAsyncBatchAnnotateImagesRequest(
    api.AsyncBatchAnnotateImagesRequest o) {
  buildCounterAsyncBatchAnnotateImagesRequest++;
  if (buildCounterAsyncBatchAnnotateImagesRequest < 3) {
    checkOutputConfig(o.outputConfig! as api.OutputConfig);
    unittest.expect(
      o.parent!,
      unittest.equals('foo'),
    );
    checkUnnamed6251(o.requests!);
  }
  buildCounterAsyncBatchAnnotateImagesRequest--;
}

core.int buildCounterAsyncBatchAnnotateImagesResponse = 0;
api.AsyncBatchAnnotateImagesResponse buildAsyncBatchAnnotateImagesResponse() {
  var o = api.AsyncBatchAnnotateImagesResponse();
  buildCounterAsyncBatchAnnotateImagesResponse++;
  if (buildCounterAsyncBatchAnnotateImagesResponse < 3) {
    o.outputConfig = buildOutputConfig();
  }
  buildCounterAsyncBatchAnnotateImagesResponse--;
  return o;
}

void checkAsyncBatchAnnotateImagesResponse(
    api.AsyncBatchAnnotateImagesResponse o) {
  buildCounterAsyncBatchAnnotateImagesResponse++;
  if (buildCounterAsyncBatchAnnotateImagesResponse < 3) {
    checkOutputConfig(o.outputConfig! as api.OutputConfig);
  }
  buildCounterAsyncBatchAnnotateImagesResponse--;
}

core.List<api.AnnotateFileRequest> buildUnnamed6252() {
  var o = <api.AnnotateFileRequest>[];
  o.add(buildAnnotateFileRequest());
  o.add(buildAnnotateFileRequest());
  return o;
}

void checkUnnamed6252(core.List<api.AnnotateFileRequest> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAnnotateFileRequest(o[0] as api.AnnotateFileRequest);
  checkAnnotateFileRequest(o[1] as api.AnnotateFileRequest);
}

core.int buildCounterBatchAnnotateFilesRequest = 0;
api.BatchAnnotateFilesRequest buildBatchAnnotateFilesRequest() {
  var o = api.BatchAnnotateFilesRequest();
  buildCounterBatchAnnotateFilesRequest++;
  if (buildCounterBatchAnnotateFilesRequest < 3) {
    o.parent = 'foo';
    o.requests = buildUnnamed6252();
  }
  buildCounterBatchAnnotateFilesRequest--;
  return o;
}

void checkBatchAnnotateFilesRequest(api.BatchAnnotateFilesRequest o) {
  buildCounterBatchAnnotateFilesRequest++;
  if (buildCounterBatchAnnotateFilesRequest < 3) {
    unittest.expect(
      o.parent!,
      unittest.equals('foo'),
    );
    checkUnnamed6252(o.requests!);
  }
  buildCounterBatchAnnotateFilesRequest--;
}

core.List<api.AnnotateFileResponse> buildUnnamed6253() {
  var o = <api.AnnotateFileResponse>[];
  o.add(buildAnnotateFileResponse());
  o.add(buildAnnotateFileResponse());
  return o;
}

void checkUnnamed6253(core.List<api.AnnotateFileResponse> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAnnotateFileResponse(o[0] as api.AnnotateFileResponse);
  checkAnnotateFileResponse(o[1] as api.AnnotateFileResponse);
}

core.int buildCounterBatchAnnotateFilesResponse = 0;
api.BatchAnnotateFilesResponse buildBatchAnnotateFilesResponse() {
  var o = api.BatchAnnotateFilesResponse();
  buildCounterBatchAnnotateFilesResponse++;
  if (buildCounterBatchAnnotateFilesResponse < 3) {
    o.responses = buildUnnamed6253();
  }
  buildCounterBatchAnnotateFilesResponse--;
  return o;
}

void checkBatchAnnotateFilesResponse(api.BatchAnnotateFilesResponse o) {
  buildCounterBatchAnnotateFilesResponse++;
  if (buildCounterBatchAnnotateFilesResponse < 3) {
    checkUnnamed6253(o.responses!);
  }
  buildCounterBatchAnnotateFilesResponse--;
}

core.List<api.AnnotateImageRequest> buildUnnamed6254() {
  var o = <api.AnnotateImageRequest>[];
  o.add(buildAnnotateImageRequest());
  o.add(buildAnnotateImageRequest());
  return o;
}

void checkUnnamed6254(core.List<api.AnnotateImageRequest> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAnnotateImageRequest(o[0] as api.AnnotateImageRequest);
  checkAnnotateImageRequest(o[1] as api.AnnotateImageRequest);
}

core.int buildCounterBatchAnnotateImagesRequest = 0;
api.BatchAnnotateImagesRequest buildBatchAnnotateImagesRequest() {
  var o = api.BatchAnnotateImagesRequest();
  buildCounterBatchAnnotateImagesRequest++;
  if (buildCounterBatchAnnotateImagesRequest < 3) {
    o.parent = 'foo';
    o.requests = buildUnnamed6254();
  }
  buildCounterBatchAnnotateImagesRequest--;
  return o;
}

void checkBatchAnnotateImagesRequest(api.BatchAnnotateImagesRequest o) {
  buildCounterBatchAnnotateImagesRequest++;
  if (buildCounterBatchAnnotateImagesRequest < 3) {
    unittest.expect(
      o.parent!,
      unittest.equals('foo'),
    );
    checkUnnamed6254(o.requests!);
  }
  buildCounterBatchAnnotateImagesRequest--;
}

core.List<api.AnnotateImageResponse> buildUnnamed6255() {
  var o = <api.AnnotateImageResponse>[];
  o.add(buildAnnotateImageResponse());
  o.add(buildAnnotateImageResponse());
  return o;
}

void checkUnnamed6255(core.List<api.AnnotateImageResponse> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkAnnotateImageResponse(o[0] as api.AnnotateImageResponse);
  checkAnnotateImageResponse(o[1] as api.AnnotateImageResponse);
}

core.int buildCounterBatchAnnotateImagesResponse = 0;
api.BatchAnnotateImagesResponse buildBatchAnnotateImagesResponse() {
  var o = api.BatchAnnotateImagesResponse();
  buildCounterBatchAnnotateImagesResponse++;
  if (buildCounterBatchAnnotateImagesResponse < 3) {
    o.responses = buildUnnamed6255();
  }
  buildCounterBatchAnnotateImagesResponse--;
  return o;
}

void checkBatchAnnotateImagesResponse(api.BatchAnnotateImagesResponse o) {
  buildCounterBatchAnnotateImagesResponse++;
  if (buildCounterBatchAnnotateImagesResponse < 3) {
    checkUnnamed6255(o.responses!);
  }
  buildCounterBatchAnnotateImagesResponse--;
}

core.int buildCounterBatchOperationMetadata = 0;
api.BatchOperationMetadata buildBatchOperationMetadata() {
  var o = api.BatchOperationMetadata();
  buildCounterBatchOperationMetadata++;
  if (buildCounterBatchOperationMetadata < 3) {
    o.endTime = 'foo';
    o.state = 'foo';
    o.submitTime = 'foo';
  }
  buildCounterBatchOperationMetadata--;
  return o;
}

void checkBatchOperationMetadata(api.BatchOperationMetadata o) {
  buildCounterBatchOperationMetadata++;
  if (buildCounterBatchOperationMetadata < 3) {
    unittest.expect(
      o.endTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.submitTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterBatchOperationMetadata--;
}

core.List<api.Paragraph> buildUnnamed6256() {
  var o = <api.Paragraph>[];
  o.add(buildParagraph());
  o.add(buildParagraph());
  return o;
}

void checkUnnamed6256(core.List<api.Paragraph> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkParagraph(o[0] as api.Paragraph);
  checkParagraph(o[1] as api.Paragraph);
}

core.int buildCounterBlock = 0;
api.Block buildBlock() {
  var o = api.Block();
  buildCounterBlock++;
  if (buildCounterBlock < 3) {
    o.blockType = 'foo';
    o.boundingBox = buildBoundingPoly();
    o.confidence = 42.0;
    o.paragraphs = buildUnnamed6256();
    o.property = buildTextProperty();
  }
  buildCounterBlock--;
  return o;
}

void checkBlock(api.Block o) {
  buildCounterBlock++;
  if (buildCounterBlock < 3) {
    unittest.expect(
      o.blockType!,
      unittest.equals('foo'),
    );
    checkBoundingPoly(o.boundingBox! as api.BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkUnnamed6256(o.paragraphs!);
    checkTextProperty(o.property! as api.TextProperty);
  }
  buildCounterBlock--;
}

core.List<api.NormalizedVertex> buildUnnamed6257() {
  var o = <api.NormalizedVertex>[];
  o.add(buildNormalizedVertex());
  o.add(buildNormalizedVertex());
  return o;
}

void checkUnnamed6257(core.List<api.NormalizedVertex> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkNormalizedVertex(o[0] as api.NormalizedVertex);
  checkNormalizedVertex(o[1] as api.NormalizedVertex);
}

core.List<api.Vertex> buildUnnamed6258() {
  var o = <api.Vertex>[];
  o.add(buildVertex());
  o.add(buildVertex());
  return o;
}

void checkUnnamed6258(core.List<api.Vertex> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkVertex(o[0] as api.Vertex);
  checkVertex(o[1] as api.Vertex);
}

core.int buildCounterBoundingPoly = 0;
api.BoundingPoly buildBoundingPoly() {
  var o = api.BoundingPoly();
  buildCounterBoundingPoly++;
  if (buildCounterBoundingPoly < 3) {
    o.normalizedVertices = buildUnnamed6257();
    o.vertices = buildUnnamed6258();
  }
  buildCounterBoundingPoly--;
  return o;
}

void checkBoundingPoly(api.BoundingPoly o) {
  buildCounterBoundingPoly++;
  if (buildCounterBoundingPoly < 3) {
    checkUnnamed6257(o.normalizedVertices!);
    checkUnnamed6258(o.vertices!);
  }
  buildCounterBoundingPoly--;
}

core.int buildCounterCancelOperationRequest = 0;
api.CancelOperationRequest buildCancelOperationRequest() {
  var o = api.CancelOperationRequest();
  buildCounterCancelOperationRequest++;
  if (buildCounterCancelOperationRequest < 3) {}
  buildCounterCancelOperationRequest--;
  return o;
}

void checkCancelOperationRequest(api.CancelOperationRequest o) {
  buildCounterCancelOperationRequest++;
  if (buildCounterCancelOperationRequest < 3) {}
  buildCounterCancelOperationRequest--;
}

core.int buildCounterColor = 0;
api.Color buildColor() {
  var o = api.Color();
  buildCounterColor++;
  if (buildCounterColor < 3) {
    o.alpha = 42.0;
    o.blue = 42.0;
    o.green = 42.0;
    o.red = 42.0;
  }
  buildCounterColor--;
  return o;
}

void checkColor(api.Color o) {
  buildCounterColor++;
  if (buildCounterColor < 3) {
    unittest.expect(
      o.alpha!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.blue!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.green!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.red!,
      unittest.equals(42.0),
    );
  }
  buildCounterColor--;
}

core.int buildCounterColorInfo = 0;
api.ColorInfo buildColorInfo() {
  var o = api.ColorInfo();
  buildCounterColorInfo++;
  if (buildCounterColorInfo < 3) {
    o.color = buildColor();
    o.pixelFraction = 42.0;
    o.score = 42.0;
  }
  buildCounterColorInfo--;
  return o;
}

void checkColorInfo(api.ColorInfo o) {
  buildCounterColorInfo++;
  if (buildCounterColorInfo < 3) {
    checkColor(o.color! as api.Color);
    unittest.expect(
      o.pixelFraction!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterColorInfo--;
}

core.int buildCounterCropHint = 0;
api.CropHint buildCropHint() {
  var o = api.CropHint();
  buildCounterCropHint++;
  if (buildCounterCropHint < 3) {
    o.boundingPoly = buildBoundingPoly();
    o.confidence = 42.0;
    o.importanceFraction = 42.0;
  }
  buildCounterCropHint--;
  return o;
}

void checkCropHint(api.CropHint o) {
  buildCounterCropHint++;
  if (buildCounterCropHint < 3) {
    checkBoundingPoly(o.boundingPoly! as api.BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.importanceFraction!,
      unittest.equals(42.0),
    );
  }
  buildCounterCropHint--;
}

core.List<api.CropHint> buildUnnamed6259() {
  var o = <api.CropHint>[];
  o.add(buildCropHint());
  o.add(buildCropHint());
  return o;
}

void checkUnnamed6259(core.List<api.CropHint> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkCropHint(o[0] as api.CropHint);
  checkCropHint(o[1] as api.CropHint);
}

core.int buildCounterCropHintsAnnotation = 0;
api.CropHintsAnnotation buildCropHintsAnnotation() {
  var o = api.CropHintsAnnotation();
  buildCounterCropHintsAnnotation++;
  if (buildCounterCropHintsAnnotation < 3) {
    o.cropHints = buildUnnamed6259();
  }
  buildCounterCropHintsAnnotation--;
  return o;
}

void checkCropHintsAnnotation(api.CropHintsAnnotation o) {
  buildCounterCropHintsAnnotation++;
  if (buildCounterCropHintsAnnotation < 3) {
    checkUnnamed6259(o.cropHints!);
  }
  buildCounterCropHintsAnnotation--;
}

core.List<core.double> buildUnnamed6260() {
  var o = <core.double>[];
  o.add(42.0);
  o.add(42.0);
  return o;
}

void checkUnnamed6260(core.List<core.double> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(
    o[0],
    unittest.equals(42.0),
  );
  unittest.expect(
    o[1],
    unittest.equals(42.0),
  );
}

core.int buildCounterCropHintsParams = 0;
api.CropHintsParams buildCropHintsParams() {
  var o = api.CropHintsParams();
  buildCounterCropHintsParams++;
  if (buildCounterCropHintsParams < 3) {
    o.aspectRatios = buildUnnamed6260();
  }
  buildCounterCropHintsParams--;
  return o;
}

void checkCropHintsParams(api.CropHintsParams o) {
  buildCounterCropHintsParams++;
  if (buildCounterCropHintsParams < 3) {
    checkUnnamed6260(o.aspectRatios!);
  }
  buildCounterCropHintsParams--;
}

core.int buildCounterDetectedBreak = 0;
api.DetectedBreak buildDetectedBreak() {
  var o = api.DetectedBreak();
  buildCounterDetectedBreak++;
  if (buildCounterDetectedBreak < 3) {
    o.isPrefix = true;
    o.type = 'foo';
  }
  buildCounterDetectedBreak--;
  return o;
}

void checkDetectedBreak(api.DetectedBreak o) {
  buildCounterDetectedBreak++;
  if (buildCounterDetectedBreak < 3) {
    unittest.expect(o.isPrefix!, unittest.isTrue);
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterDetectedBreak--;
}

core.int buildCounterDetectedLanguage = 0;
api.DetectedLanguage buildDetectedLanguage() {
  var o = api.DetectedLanguage();
  buildCounterDetectedLanguage++;
  if (buildCounterDetectedLanguage < 3) {
    o.confidence = 42.0;
    o.languageCode = 'foo';
  }
  buildCounterDetectedLanguage--;
  return o;
}

void checkDetectedLanguage(api.DetectedLanguage o) {
  buildCounterDetectedLanguage++;
  if (buildCounterDetectedLanguage < 3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
  }
  buildCounterDetectedLanguage--;
}

core.List<api.ColorInfo> buildUnnamed6261() {
  var o = <api.ColorInfo>[];
  o.add(buildColorInfo());
  o.add(buildColorInfo());
  return o;
}

void checkUnnamed6261(core.List<api.ColorInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkColorInfo(o[0] as api.ColorInfo);
  checkColorInfo(o[1] as api.ColorInfo);
}

core.int buildCounterDominantColorsAnnotation = 0;
api.DominantColorsAnnotation buildDominantColorsAnnotation() {
  var o = api.DominantColorsAnnotation();
  buildCounterDominantColorsAnnotation++;
  if (buildCounterDominantColorsAnnotation < 3) {
    o.colors = buildUnnamed6261();
  }
  buildCounterDominantColorsAnnotation--;
  return o;
}

void checkDominantColorsAnnotation(api.DominantColorsAnnotation o) {
  buildCounterDominantColorsAnnotation++;
  if (buildCounterDominantColorsAnnotation < 3) {
    checkUnnamed6261(o.colors!);
  }
  buildCounterDominantColorsAnnotation--;
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

core.List<api.LocationInfo> buildUnnamed6262() {
  var o = <api.LocationInfo>[];
  o.add(buildLocationInfo());
  o.add(buildLocationInfo());
  return o;
}

void checkUnnamed6262(core.List<api.LocationInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLocationInfo(o[0] as api.LocationInfo);
  checkLocationInfo(o[1] as api.LocationInfo);
}

core.List<api.Property> buildUnnamed6263() {
  var o = <api.Property>[];
  o.add(buildProperty());
  o.add(buildProperty());
  return o;
}

void checkUnnamed6263(core.List<api.Property> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkProperty(o[0] as api.Property);
  checkProperty(o[1] as api.Property);
}

core.int buildCounterEntityAnnotation = 0;
api.EntityAnnotation buildEntityAnnotation() {
  var o = api.EntityAnnotation();
  buildCounterEntityAnnotation++;
  if (buildCounterEntityAnnotation < 3) {
    o.boundingPoly = buildBoundingPoly();
    o.confidence = 42.0;
    o.description = 'foo';
    o.locale = 'foo';
    o.locations = buildUnnamed6262();
    o.mid = 'foo';
    o.properties = buildUnnamed6263();
    o.score = 42.0;
    o.topicality = 42.0;
  }
  buildCounterEntityAnnotation--;
  return o;
}

void checkEntityAnnotation(api.EntityAnnotation o) {
  buildCounterEntityAnnotation++;
  if (buildCounterEntityAnnotation < 3) {
    checkBoundingPoly(o.boundingPoly! as api.BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.locale!,
      unittest.equals('foo'),
    );
    checkUnnamed6262(o.locations!);
    unittest.expect(
      o.mid!,
      unittest.equals('foo'),
    );
    checkUnnamed6263(o.properties!);
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.topicality!,
      unittest.equals(42.0),
    );
  }
  buildCounterEntityAnnotation--;
}

core.List<api.Landmark> buildUnnamed6264() {
  var o = <api.Landmark>[];
  o.add(buildLandmark());
  o.add(buildLandmark());
  return o;
}

void checkUnnamed6264(core.List<api.Landmark> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkLandmark(o[0] as api.Landmark);
  checkLandmark(o[1] as api.Landmark);
}

core.int buildCounterFaceAnnotation = 0;
api.FaceAnnotation buildFaceAnnotation() {
  var o = api.FaceAnnotation();
  buildCounterFaceAnnotation++;
  if (buildCounterFaceAnnotation < 3) {
    o.angerLikelihood = 'foo';
    o.blurredLikelihood = 'foo';
    o.boundingPoly = buildBoundingPoly();
    o.detectionConfidence = 42.0;
    o.fdBoundingPoly = buildBoundingPoly();
    o.headwearLikelihood = 'foo';
    o.joyLikelihood = 'foo';
    o.landmarkingConfidence = 42.0;
    o.landmarks = buildUnnamed6264();
    o.panAngle = 42.0;
    o.rollAngle = 42.0;
    o.sorrowLikelihood = 'foo';
    o.surpriseLikelihood = 'foo';
    o.tiltAngle = 42.0;
    o.underExposedLikelihood = 'foo';
  }
  buildCounterFaceAnnotation--;
  return o;
}

void checkFaceAnnotation(api.FaceAnnotation o) {
  buildCounterFaceAnnotation++;
  if (buildCounterFaceAnnotation < 3) {
    unittest.expect(
      o.angerLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.blurredLikelihood!,
      unittest.equals('foo'),
    );
    checkBoundingPoly(o.boundingPoly! as api.BoundingPoly);
    unittest.expect(
      o.detectionConfidence!,
      unittest.equals(42.0),
    );
    checkBoundingPoly(o.fdBoundingPoly! as api.BoundingPoly);
    unittest.expect(
      o.headwearLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.joyLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.landmarkingConfidence!,
      unittest.equals(42.0),
    );
    checkUnnamed6264(o.landmarks!);
    unittest.expect(
      o.panAngle!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.rollAngle!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.sorrowLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.surpriseLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.tiltAngle!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.underExposedLikelihood!,
      unittest.equals('foo'),
    );
  }
  buildCounterFaceAnnotation--;
}

core.int buildCounterFeature = 0;
api.Feature buildFeature() {
  var o = api.Feature();
  buildCounterFeature++;
  if (buildCounterFeature < 3) {
    o.maxResults = 42;
    o.model = 'foo';
    o.type = 'foo';
  }
  buildCounterFeature--;
  return o;
}

void checkFeature(api.Feature o) {
  buildCounterFeature++;
  if (buildCounterFeature < 3) {
    unittest.expect(
      o.maxResults!,
      unittest.equals(42),
    );
    unittest.expect(
      o.model!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterFeature--;
}

core.int buildCounterGcsDestination = 0;
api.GcsDestination buildGcsDestination() {
  var o = api.GcsDestination();
  buildCounterGcsDestination++;
  if (buildCounterGcsDestination < 3) {
    o.uri = 'foo';
  }
  buildCounterGcsDestination--;
  return o;
}

void checkGcsDestination(api.GcsDestination o) {
  buildCounterGcsDestination++;
  if (buildCounterGcsDestination < 3) {
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGcsDestination--;
}

core.int buildCounterGcsSource = 0;
api.GcsSource buildGcsSource() {
  var o = api.GcsSource();
  buildCounterGcsSource++;
  if (buildCounterGcsSource < 3) {
    o.uri = 'foo';
  }
  buildCounterGcsSource--;
  return o;
}

void checkGcsSource(api.GcsSource o) {
  buildCounterGcsSource++;
  if (buildCounterGcsSource < 3) {
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGcsSource--;
}

core.List<api.GoogleCloudVisionV1p1beta1AnnotateImageResponse>
    buildUnnamed6265() {
  var o = <api.GoogleCloudVisionV1p1beta1AnnotateImageResponse>[];
  o.add(buildGoogleCloudVisionV1p1beta1AnnotateImageResponse());
  o.add(buildGoogleCloudVisionV1p1beta1AnnotateImageResponse());
  return o;
}

void checkUnnamed6265(
    core.List<api.GoogleCloudVisionV1p1beta1AnnotateImageResponse> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1AnnotateImageResponse(
      o[0] as api.GoogleCloudVisionV1p1beta1AnnotateImageResponse);
  checkGoogleCloudVisionV1p1beta1AnnotateImageResponse(
      o[1] as api.GoogleCloudVisionV1p1beta1AnnotateImageResponse);
}

core.int buildCounterGoogleCloudVisionV1p1beta1AnnotateFileResponse = 0;
api.GoogleCloudVisionV1p1beta1AnnotateFileResponse
    buildGoogleCloudVisionV1p1beta1AnnotateFileResponse() {
  var o = api.GoogleCloudVisionV1p1beta1AnnotateFileResponse();
  buildCounterGoogleCloudVisionV1p1beta1AnnotateFileResponse++;
  if (buildCounterGoogleCloudVisionV1p1beta1AnnotateFileResponse < 3) {
    o.error = buildStatus();
    o.inputConfig = buildGoogleCloudVisionV1p1beta1InputConfig();
    o.responses = buildUnnamed6265();
    o.totalPages = 42;
  }
  buildCounterGoogleCloudVisionV1p1beta1AnnotateFileResponse--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1AnnotateFileResponse(
    api.GoogleCloudVisionV1p1beta1AnnotateFileResponse o) {
  buildCounterGoogleCloudVisionV1p1beta1AnnotateFileResponse++;
  if (buildCounterGoogleCloudVisionV1p1beta1AnnotateFileResponse < 3) {
    checkStatus(o.error! as api.Status);
    checkGoogleCloudVisionV1p1beta1InputConfig(
        o.inputConfig! as api.GoogleCloudVisionV1p1beta1InputConfig);
    checkUnnamed6265(o.responses!);
    unittest.expect(
      o.totalPages!,
      unittest.equals(42),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1AnnotateFileResponse--;
}

core.List<api.GoogleCloudVisionV1p1beta1FaceAnnotation> buildUnnamed6266() {
  var o = <api.GoogleCloudVisionV1p1beta1FaceAnnotation>[];
  o.add(buildGoogleCloudVisionV1p1beta1FaceAnnotation());
  o.add(buildGoogleCloudVisionV1p1beta1FaceAnnotation());
  return o;
}

void checkUnnamed6266(
    core.List<api.GoogleCloudVisionV1p1beta1FaceAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1FaceAnnotation(
      o[0] as api.GoogleCloudVisionV1p1beta1FaceAnnotation);
  checkGoogleCloudVisionV1p1beta1FaceAnnotation(
      o[1] as api.GoogleCloudVisionV1p1beta1FaceAnnotation);
}

core.List<api.GoogleCloudVisionV1p1beta1EntityAnnotation> buildUnnamed6267() {
  var o = <api.GoogleCloudVisionV1p1beta1EntityAnnotation>[];
  o.add(buildGoogleCloudVisionV1p1beta1EntityAnnotation());
  o.add(buildGoogleCloudVisionV1p1beta1EntityAnnotation());
  return o;
}

void checkUnnamed6267(
    core.List<api.GoogleCloudVisionV1p1beta1EntityAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1EntityAnnotation(
      o[0] as api.GoogleCloudVisionV1p1beta1EntityAnnotation);
  checkGoogleCloudVisionV1p1beta1EntityAnnotation(
      o[1] as api.GoogleCloudVisionV1p1beta1EntityAnnotation);
}

core.List<api.GoogleCloudVisionV1p1beta1EntityAnnotation> buildUnnamed6268() {
  var o = <api.GoogleCloudVisionV1p1beta1EntityAnnotation>[];
  o.add(buildGoogleCloudVisionV1p1beta1EntityAnnotation());
  o.add(buildGoogleCloudVisionV1p1beta1EntityAnnotation());
  return o;
}

void checkUnnamed6268(
    core.List<api.GoogleCloudVisionV1p1beta1EntityAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1EntityAnnotation(
      o[0] as api.GoogleCloudVisionV1p1beta1EntityAnnotation);
  checkGoogleCloudVisionV1p1beta1EntityAnnotation(
      o[1] as api.GoogleCloudVisionV1p1beta1EntityAnnotation);
}

core.List<api.GoogleCloudVisionV1p1beta1LocalizedObjectAnnotation>
    buildUnnamed6269() {
  var o = <api.GoogleCloudVisionV1p1beta1LocalizedObjectAnnotation>[];
  o.add(buildGoogleCloudVisionV1p1beta1LocalizedObjectAnnotation());
  o.add(buildGoogleCloudVisionV1p1beta1LocalizedObjectAnnotation());
  return o;
}

void checkUnnamed6269(
    core.List<api.GoogleCloudVisionV1p1beta1LocalizedObjectAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1LocalizedObjectAnnotation(
      o[0] as api.GoogleCloudVisionV1p1beta1LocalizedObjectAnnotation);
  checkGoogleCloudVisionV1p1beta1LocalizedObjectAnnotation(
      o[1] as api.GoogleCloudVisionV1p1beta1LocalizedObjectAnnotation);
}

core.List<api.GoogleCloudVisionV1p1beta1EntityAnnotation> buildUnnamed6270() {
  var o = <api.GoogleCloudVisionV1p1beta1EntityAnnotation>[];
  o.add(buildGoogleCloudVisionV1p1beta1EntityAnnotation());
  o.add(buildGoogleCloudVisionV1p1beta1EntityAnnotation());
  return o;
}

void checkUnnamed6270(
    core.List<api.GoogleCloudVisionV1p1beta1EntityAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1EntityAnnotation(
      o[0] as api.GoogleCloudVisionV1p1beta1EntityAnnotation);
  checkGoogleCloudVisionV1p1beta1EntityAnnotation(
      o[1] as api.GoogleCloudVisionV1p1beta1EntityAnnotation);
}

core.List<api.GoogleCloudVisionV1p1beta1EntityAnnotation> buildUnnamed6271() {
  var o = <api.GoogleCloudVisionV1p1beta1EntityAnnotation>[];
  o.add(buildGoogleCloudVisionV1p1beta1EntityAnnotation());
  o.add(buildGoogleCloudVisionV1p1beta1EntityAnnotation());
  return o;
}

void checkUnnamed6271(
    core.List<api.GoogleCloudVisionV1p1beta1EntityAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1EntityAnnotation(
      o[0] as api.GoogleCloudVisionV1p1beta1EntityAnnotation);
  checkGoogleCloudVisionV1p1beta1EntityAnnotation(
      o[1] as api.GoogleCloudVisionV1p1beta1EntityAnnotation);
}

core.int buildCounterGoogleCloudVisionV1p1beta1AnnotateImageResponse = 0;
api.GoogleCloudVisionV1p1beta1AnnotateImageResponse
    buildGoogleCloudVisionV1p1beta1AnnotateImageResponse() {
  var o = api.GoogleCloudVisionV1p1beta1AnnotateImageResponse();
  buildCounterGoogleCloudVisionV1p1beta1AnnotateImageResponse++;
  if (buildCounterGoogleCloudVisionV1p1beta1AnnotateImageResponse < 3) {
    o.context = buildGoogleCloudVisionV1p1beta1ImageAnnotationContext();
    o.cropHintsAnnotation =
        buildGoogleCloudVisionV1p1beta1CropHintsAnnotation();
    o.error = buildStatus();
    o.faceAnnotations = buildUnnamed6266();
    o.fullTextAnnotation = buildGoogleCloudVisionV1p1beta1TextAnnotation();
    o.imagePropertiesAnnotation =
        buildGoogleCloudVisionV1p1beta1ImageProperties();
    o.labelAnnotations = buildUnnamed6267();
    o.landmarkAnnotations = buildUnnamed6268();
    o.localizedObjectAnnotations = buildUnnamed6269();
    o.logoAnnotations = buildUnnamed6270();
    o.productSearchResults =
        buildGoogleCloudVisionV1p1beta1ProductSearchResults();
    o.safeSearchAnnotation =
        buildGoogleCloudVisionV1p1beta1SafeSearchAnnotation();
    o.textAnnotations = buildUnnamed6271();
    o.webDetection = buildGoogleCloudVisionV1p1beta1WebDetection();
  }
  buildCounterGoogleCloudVisionV1p1beta1AnnotateImageResponse--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1AnnotateImageResponse(
    api.GoogleCloudVisionV1p1beta1AnnotateImageResponse o) {
  buildCounterGoogleCloudVisionV1p1beta1AnnotateImageResponse++;
  if (buildCounterGoogleCloudVisionV1p1beta1AnnotateImageResponse < 3) {
    checkGoogleCloudVisionV1p1beta1ImageAnnotationContext(
        o.context! as api.GoogleCloudVisionV1p1beta1ImageAnnotationContext);
    checkGoogleCloudVisionV1p1beta1CropHintsAnnotation(o.cropHintsAnnotation!
        as api.GoogleCloudVisionV1p1beta1CropHintsAnnotation);
    checkStatus(o.error! as api.Status);
    checkUnnamed6266(o.faceAnnotations!);
    checkGoogleCloudVisionV1p1beta1TextAnnotation(
        o.fullTextAnnotation! as api.GoogleCloudVisionV1p1beta1TextAnnotation);
    checkGoogleCloudVisionV1p1beta1ImageProperties(o.imagePropertiesAnnotation!
        as api.GoogleCloudVisionV1p1beta1ImageProperties);
    checkUnnamed6267(o.labelAnnotations!);
    checkUnnamed6268(o.landmarkAnnotations!);
    checkUnnamed6269(o.localizedObjectAnnotations!);
    checkUnnamed6270(o.logoAnnotations!);
    checkGoogleCloudVisionV1p1beta1ProductSearchResults(o.productSearchResults!
        as api.GoogleCloudVisionV1p1beta1ProductSearchResults);
    checkGoogleCloudVisionV1p1beta1SafeSearchAnnotation(o.safeSearchAnnotation!
        as api.GoogleCloudVisionV1p1beta1SafeSearchAnnotation);
    checkUnnamed6271(o.textAnnotations!);
    checkGoogleCloudVisionV1p1beta1WebDetection(
        o.webDetection! as api.GoogleCloudVisionV1p1beta1WebDetection);
  }
  buildCounterGoogleCloudVisionV1p1beta1AnnotateImageResponse--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse = 0;
api.GoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse
    buildGoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse() {
  var o = api.GoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse();
  buildCounterGoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse++;
  if (buildCounterGoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse < 3) {
    o.outputConfig = buildGoogleCloudVisionV1p1beta1OutputConfig();
  }
  buildCounterGoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse(
    api.GoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse o) {
  buildCounterGoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse++;
  if (buildCounterGoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse < 3) {
    checkGoogleCloudVisionV1p1beta1OutputConfig(
        o.outputConfig! as api.GoogleCloudVisionV1p1beta1OutputConfig);
  }
  buildCounterGoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse--;
}

core.List<api.GoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse>
    buildUnnamed6272() {
  var o = <api.GoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse>[];
  o.add(buildGoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse());
  o.add(buildGoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse());
  return o;
}

void checkUnnamed6272(
    core.List<api.GoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse(
      o[0] as api.GoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse);
  checkGoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse(
      o[1] as api.GoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse);
}

core.int buildCounterGoogleCloudVisionV1p1beta1AsyncBatchAnnotateFilesResponse =
    0;
api.GoogleCloudVisionV1p1beta1AsyncBatchAnnotateFilesResponse
    buildGoogleCloudVisionV1p1beta1AsyncBatchAnnotateFilesResponse() {
  var o = api.GoogleCloudVisionV1p1beta1AsyncBatchAnnotateFilesResponse();
  buildCounterGoogleCloudVisionV1p1beta1AsyncBatchAnnotateFilesResponse++;
  if (buildCounterGoogleCloudVisionV1p1beta1AsyncBatchAnnotateFilesResponse <
      3) {
    o.responses = buildUnnamed6272();
  }
  buildCounterGoogleCloudVisionV1p1beta1AsyncBatchAnnotateFilesResponse--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1AsyncBatchAnnotateFilesResponse(
    api.GoogleCloudVisionV1p1beta1AsyncBatchAnnotateFilesResponse o) {
  buildCounterGoogleCloudVisionV1p1beta1AsyncBatchAnnotateFilesResponse++;
  if (buildCounterGoogleCloudVisionV1p1beta1AsyncBatchAnnotateFilesResponse <
      3) {
    checkUnnamed6272(o.responses!);
  }
  buildCounterGoogleCloudVisionV1p1beta1AsyncBatchAnnotateFilesResponse--;
}

core.List<api.GoogleCloudVisionV1p1beta1Paragraph> buildUnnamed6273() {
  var o = <api.GoogleCloudVisionV1p1beta1Paragraph>[];
  o.add(buildGoogleCloudVisionV1p1beta1Paragraph());
  o.add(buildGoogleCloudVisionV1p1beta1Paragraph());
  return o;
}

void checkUnnamed6273(core.List<api.GoogleCloudVisionV1p1beta1Paragraph> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1Paragraph(
      o[0] as api.GoogleCloudVisionV1p1beta1Paragraph);
  checkGoogleCloudVisionV1p1beta1Paragraph(
      o[1] as api.GoogleCloudVisionV1p1beta1Paragraph);
}

core.int buildCounterGoogleCloudVisionV1p1beta1Block = 0;
api.GoogleCloudVisionV1p1beta1Block buildGoogleCloudVisionV1p1beta1Block() {
  var o = api.GoogleCloudVisionV1p1beta1Block();
  buildCounterGoogleCloudVisionV1p1beta1Block++;
  if (buildCounterGoogleCloudVisionV1p1beta1Block < 3) {
    o.blockType = 'foo';
    o.boundingBox = buildGoogleCloudVisionV1p1beta1BoundingPoly();
    o.confidence = 42.0;
    o.paragraphs = buildUnnamed6273();
    o.property = buildGoogleCloudVisionV1p1beta1TextAnnotationTextProperty();
  }
  buildCounterGoogleCloudVisionV1p1beta1Block--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1Block(
    api.GoogleCloudVisionV1p1beta1Block o) {
  buildCounterGoogleCloudVisionV1p1beta1Block++;
  if (buildCounterGoogleCloudVisionV1p1beta1Block < 3) {
    unittest.expect(
      o.blockType!,
      unittest.equals('foo'),
    );
    checkGoogleCloudVisionV1p1beta1BoundingPoly(
        o.boundingBox! as api.GoogleCloudVisionV1p1beta1BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkUnnamed6273(o.paragraphs!);
    checkGoogleCloudVisionV1p1beta1TextAnnotationTextProperty(o.property!
        as api.GoogleCloudVisionV1p1beta1TextAnnotationTextProperty);
  }
  buildCounterGoogleCloudVisionV1p1beta1Block--;
}

core.List<api.GoogleCloudVisionV1p1beta1NormalizedVertex> buildUnnamed6274() {
  var o = <api.GoogleCloudVisionV1p1beta1NormalizedVertex>[];
  o.add(buildGoogleCloudVisionV1p1beta1NormalizedVertex());
  o.add(buildGoogleCloudVisionV1p1beta1NormalizedVertex());
  return o;
}

void checkUnnamed6274(
    core.List<api.GoogleCloudVisionV1p1beta1NormalizedVertex> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1NormalizedVertex(
      o[0] as api.GoogleCloudVisionV1p1beta1NormalizedVertex);
  checkGoogleCloudVisionV1p1beta1NormalizedVertex(
      o[1] as api.GoogleCloudVisionV1p1beta1NormalizedVertex);
}

core.List<api.GoogleCloudVisionV1p1beta1Vertex> buildUnnamed6275() {
  var o = <api.GoogleCloudVisionV1p1beta1Vertex>[];
  o.add(buildGoogleCloudVisionV1p1beta1Vertex());
  o.add(buildGoogleCloudVisionV1p1beta1Vertex());
  return o;
}

void checkUnnamed6275(core.List<api.GoogleCloudVisionV1p1beta1Vertex> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1Vertex(
      o[0] as api.GoogleCloudVisionV1p1beta1Vertex);
  checkGoogleCloudVisionV1p1beta1Vertex(
      o[1] as api.GoogleCloudVisionV1p1beta1Vertex);
}

core.int buildCounterGoogleCloudVisionV1p1beta1BoundingPoly = 0;
api.GoogleCloudVisionV1p1beta1BoundingPoly
    buildGoogleCloudVisionV1p1beta1BoundingPoly() {
  var o = api.GoogleCloudVisionV1p1beta1BoundingPoly();
  buildCounterGoogleCloudVisionV1p1beta1BoundingPoly++;
  if (buildCounterGoogleCloudVisionV1p1beta1BoundingPoly < 3) {
    o.normalizedVertices = buildUnnamed6274();
    o.vertices = buildUnnamed6275();
  }
  buildCounterGoogleCloudVisionV1p1beta1BoundingPoly--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1BoundingPoly(
    api.GoogleCloudVisionV1p1beta1BoundingPoly o) {
  buildCounterGoogleCloudVisionV1p1beta1BoundingPoly++;
  if (buildCounterGoogleCloudVisionV1p1beta1BoundingPoly < 3) {
    checkUnnamed6274(o.normalizedVertices!);
    checkUnnamed6275(o.vertices!);
  }
  buildCounterGoogleCloudVisionV1p1beta1BoundingPoly--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1ColorInfo = 0;
api.GoogleCloudVisionV1p1beta1ColorInfo
    buildGoogleCloudVisionV1p1beta1ColorInfo() {
  var o = api.GoogleCloudVisionV1p1beta1ColorInfo();
  buildCounterGoogleCloudVisionV1p1beta1ColorInfo++;
  if (buildCounterGoogleCloudVisionV1p1beta1ColorInfo < 3) {
    o.color = buildColor();
    o.pixelFraction = 42.0;
    o.score = 42.0;
  }
  buildCounterGoogleCloudVisionV1p1beta1ColorInfo--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1ColorInfo(
    api.GoogleCloudVisionV1p1beta1ColorInfo o) {
  buildCounterGoogleCloudVisionV1p1beta1ColorInfo++;
  if (buildCounterGoogleCloudVisionV1p1beta1ColorInfo < 3) {
    checkColor(o.color! as api.Color);
    unittest.expect(
      o.pixelFraction!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1ColorInfo--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1CropHint = 0;
api.GoogleCloudVisionV1p1beta1CropHint
    buildGoogleCloudVisionV1p1beta1CropHint() {
  var o = api.GoogleCloudVisionV1p1beta1CropHint();
  buildCounterGoogleCloudVisionV1p1beta1CropHint++;
  if (buildCounterGoogleCloudVisionV1p1beta1CropHint < 3) {
    o.boundingPoly = buildGoogleCloudVisionV1p1beta1BoundingPoly();
    o.confidence = 42.0;
    o.importanceFraction = 42.0;
  }
  buildCounterGoogleCloudVisionV1p1beta1CropHint--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1CropHint(
    api.GoogleCloudVisionV1p1beta1CropHint o) {
  buildCounterGoogleCloudVisionV1p1beta1CropHint++;
  if (buildCounterGoogleCloudVisionV1p1beta1CropHint < 3) {
    checkGoogleCloudVisionV1p1beta1BoundingPoly(
        o.boundingPoly! as api.GoogleCloudVisionV1p1beta1BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.importanceFraction!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1CropHint--;
}

core.List<api.GoogleCloudVisionV1p1beta1CropHint> buildUnnamed6276() {
  var o = <api.GoogleCloudVisionV1p1beta1CropHint>[];
  o.add(buildGoogleCloudVisionV1p1beta1CropHint());
  o.add(buildGoogleCloudVisionV1p1beta1CropHint());
  return o;
}

void checkUnnamed6276(core.List<api.GoogleCloudVisionV1p1beta1CropHint> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1CropHint(
      o[0] as api.GoogleCloudVisionV1p1beta1CropHint);
  checkGoogleCloudVisionV1p1beta1CropHint(
      o[1] as api.GoogleCloudVisionV1p1beta1CropHint);
}

core.int buildCounterGoogleCloudVisionV1p1beta1CropHintsAnnotation = 0;
api.GoogleCloudVisionV1p1beta1CropHintsAnnotation
    buildGoogleCloudVisionV1p1beta1CropHintsAnnotation() {
  var o = api.GoogleCloudVisionV1p1beta1CropHintsAnnotation();
  buildCounterGoogleCloudVisionV1p1beta1CropHintsAnnotation++;
  if (buildCounterGoogleCloudVisionV1p1beta1CropHintsAnnotation < 3) {
    o.cropHints = buildUnnamed6276();
  }
  buildCounterGoogleCloudVisionV1p1beta1CropHintsAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1CropHintsAnnotation(
    api.GoogleCloudVisionV1p1beta1CropHintsAnnotation o) {
  buildCounterGoogleCloudVisionV1p1beta1CropHintsAnnotation++;
  if (buildCounterGoogleCloudVisionV1p1beta1CropHintsAnnotation < 3) {
    checkUnnamed6276(o.cropHints!);
  }
  buildCounterGoogleCloudVisionV1p1beta1CropHintsAnnotation--;
}

core.List<api.GoogleCloudVisionV1p1beta1ColorInfo> buildUnnamed6277() {
  var o = <api.GoogleCloudVisionV1p1beta1ColorInfo>[];
  o.add(buildGoogleCloudVisionV1p1beta1ColorInfo());
  o.add(buildGoogleCloudVisionV1p1beta1ColorInfo());
  return o;
}

void checkUnnamed6277(core.List<api.GoogleCloudVisionV1p1beta1ColorInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1ColorInfo(
      o[0] as api.GoogleCloudVisionV1p1beta1ColorInfo);
  checkGoogleCloudVisionV1p1beta1ColorInfo(
      o[1] as api.GoogleCloudVisionV1p1beta1ColorInfo);
}

core.int buildCounterGoogleCloudVisionV1p1beta1DominantColorsAnnotation = 0;
api.GoogleCloudVisionV1p1beta1DominantColorsAnnotation
    buildGoogleCloudVisionV1p1beta1DominantColorsAnnotation() {
  var o = api.GoogleCloudVisionV1p1beta1DominantColorsAnnotation();
  buildCounterGoogleCloudVisionV1p1beta1DominantColorsAnnotation++;
  if (buildCounterGoogleCloudVisionV1p1beta1DominantColorsAnnotation < 3) {
    o.colors = buildUnnamed6277();
  }
  buildCounterGoogleCloudVisionV1p1beta1DominantColorsAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1DominantColorsAnnotation(
    api.GoogleCloudVisionV1p1beta1DominantColorsAnnotation o) {
  buildCounterGoogleCloudVisionV1p1beta1DominantColorsAnnotation++;
  if (buildCounterGoogleCloudVisionV1p1beta1DominantColorsAnnotation < 3) {
    checkUnnamed6277(o.colors!);
  }
  buildCounterGoogleCloudVisionV1p1beta1DominantColorsAnnotation--;
}

core.List<api.GoogleCloudVisionV1p1beta1LocationInfo> buildUnnamed6278() {
  var o = <api.GoogleCloudVisionV1p1beta1LocationInfo>[];
  o.add(buildGoogleCloudVisionV1p1beta1LocationInfo());
  o.add(buildGoogleCloudVisionV1p1beta1LocationInfo());
  return o;
}

void checkUnnamed6278(core.List<api.GoogleCloudVisionV1p1beta1LocationInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1LocationInfo(
      o[0] as api.GoogleCloudVisionV1p1beta1LocationInfo);
  checkGoogleCloudVisionV1p1beta1LocationInfo(
      o[1] as api.GoogleCloudVisionV1p1beta1LocationInfo);
}

core.List<api.GoogleCloudVisionV1p1beta1Property> buildUnnamed6279() {
  var o = <api.GoogleCloudVisionV1p1beta1Property>[];
  o.add(buildGoogleCloudVisionV1p1beta1Property());
  o.add(buildGoogleCloudVisionV1p1beta1Property());
  return o;
}

void checkUnnamed6279(core.List<api.GoogleCloudVisionV1p1beta1Property> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1Property(
      o[0] as api.GoogleCloudVisionV1p1beta1Property);
  checkGoogleCloudVisionV1p1beta1Property(
      o[1] as api.GoogleCloudVisionV1p1beta1Property);
}

core.int buildCounterGoogleCloudVisionV1p1beta1EntityAnnotation = 0;
api.GoogleCloudVisionV1p1beta1EntityAnnotation
    buildGoogleCloudVisionV1p1beta1EntityAnnotation() {
  var o = api.GoogleCloudVisionV1p1beta1EntityAnnotation();
  buildCounterGoogleCloudVisionV1p1beta1EntityAnnotation++;
  if (buildCounterGoogleCloudVisionV1p1beta1EntityAnnotation < 3) {
    o.boundingPoly = buildGoogleCloudVisionV1p1beta1BoundingPoly();
    o.confidence = 42.0;
    o.description = 'foo';
    o.locale = 'foo';
    o.locations = buildUnnamed6278();
    o.mid = 'foo';
    o.properties = buildUnnamed6279();
    o.score = 42.0;
    o.topicality = 42.0;
  }
  buildCounterGoogleCloudVisionV1p1beta1EntityAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1EntityAnnotation(
    api.GoogleCloudVisionV1p1beta1EntityAnnotation o) {
  buildCounterGoogleCloudVisionV1p1beta1EntityAnnotation++;
  if (buildCounterGoogleCloudVisionV1p1beta1EntityAnnotation < 3) {
    checkGoogleCloudVisionV1p1beta1BoundingPoly(
        o.boundingPoly! as api.GoogleCloudVisionV1p1beta1BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.locale!,
      unittest.equals('foo'),
    );
    checkUnnamed6278(o.locations!);
    unittest.expect(
      o.mid!,
      unittest.equals('foo'),
    );
    checkUnnamed6279(o.properties!);
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.topicality!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1EntityAnnotation--;
}

core.List<api.GoogleCloudVisionV1p1beta1FaceAnnotationLandmark>
    buildUnnamed6280() {
  var o = <api.GoogleCloudVisionV1p1beta1FaceAnnotationLandmark>[];
  o.add(buildGoogleCloudVisionV1p1beta1FaceAnnotationLandmark());
  o.add(buildGoogleCloudVisionV1p1beta1FaceAnnotationLandmark());
  return o;
}

void checkUnnamed6280(
    core.List<api.GoogleCloudVisionV1p1beta1FaceAnnotationLandmark> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1FaceAnnotationLandmark(
      o[0] as api.GoogleCloudVisionV1p1beta1FaceAnnotationLandmark);
  checkGoogleCloudVisionV1p1beta1FaceAnnotationLandmark(
      o[1] as api.GoogleCloudVisionV1p1beta1FaceAnnotationLandmark);
}

core.int buildCounterGoogleCloudVisionV1p1beta1FaceAnnotation = 0;
api.GoogleCloudVisionV1p1beta1FaceAnnotation
    buildGoogleCloudVisionV1p1beta1FaceAnnotation() {
  var o = api.GoogleCloudVisionV1p1beta1FaceAnnotation();
  buildCounterGoogleCloudVisionV1p1beta1FaceAnnotation++;
  if (buildCounterGoogleCloudVisionV1p1beta1FaceAnnotation < 3) {
    o.angerLikelihood = 'foo';
    o.blurredLikelihood = 'foo';
    o.boundingPoly = buildGoogleCloudVisionV1p1beta1BoundingPoly();
    o.detectionConfidence = 42.0;
    o.fdBoundingPoly = buildGoogleCloudVisionV1p1beta1BoundingPoly();
    o.headwearLikelihood = 'foo';
    o.joyLikelihood = 'foo';
    o.landmarkingConfidence = 42.0;
    o.landmarks = buildUnnamed6280();
    o.panAngle = 42.0;
    o.rollAngle = 42.0;
    o.sorrowLikelihood = 'foo';
    o.surpriseLikelihood = 'foo';
    o.tiltAngle = 42.0;
    o.underExposedLikelihood = 'foo';
  }
  buildCounterGoogleCloudVisionV1p1beta1FaceAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1FaceAnnotation(
    api.GoogleCloudVisionV1p1beta1FaceAnnotation o) {
  buildCounterGoogleCloudVisionV1p1beta1FaceAnnotation++;
  if (buildCounterGoogleCloudVisionV1p1beta1FaceAnnotation < 3) {
    unittest.expect(
      o.angerLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.blurredLikelihood!,
      unittest.equals('foo'),
    );
    checkGoogleCloudVisionV1p1beta1BoundingPoly(
        o.boundingPoly! as api.GoogleCloudVisionV1p1beta1BoundingPoly);
    unittest.expect(
      o.detectionConfidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVisionV1p1beta1BoundingPoly(
        o.fdBoundingPoly! as api.GoogleCloudVisionV1p1beta1BoundingPoly);
    unittest.expect(
      o.headwearLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.joyLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.landmarkingConfidence!,
      unittest.equals(42.0),
    );
    checkUnnamed6280(o.landmarks!);
    unittest.expect(
      o.panAngle!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.rollAngle!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.sorrowLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.surpriseLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.tiltAngle!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.underExposedLikelihood!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1FaceAnnotation--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1FaceAnnotationLandmark = 0;
api.GoogleCloudVisionV1p1beta1FaceAnnotationLandmark
    buildGoogleCloudVisionV1p1beta1FaceAnnotationLandmark() {
  var o = api.GoogleCloudVisionV1p1beta1FaceAnnotationLandmark();
  buildCounterGoogleCloudVisionV1p1beta1FaceAnnotationLandmark++;
  if (buildCounterGoogleCloudVisionV1p1beta1FaceAnnotationLandmark < 3) {
    o.position = buildGoogleCloudVisionV1p1beta1Position();
    o.type = 'foo';
  }
  buildCounterGoogleCloudVisionV1p1beta1FaceAnnotationLandmark--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1FaceAnnotationLandmark(
    api.GoogleCloudVisionV1p1beta1FaceAnnotationLandmark o) {
  buildCounterGoogleCloudVisionV1p1beta1FaceAnnotationLandmark++;
  if (buildCounterGoogleCloudVisionV1p1beta1FaceAnnotationLandmark < 3) {
    checkGoogleCloudVisionV1p1beta1Position(
        o.position! as api.GoogleCloudVisionV1p1beta1Position);
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1FaceAnnotationLandmark--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1GcsDestination = 0;
api.GoogleCloudVisionV1p1beta1GcsDestination
    buildGoogleCloudVisionV1p1beta1GcsDestination() {
  var o = api.GoogleCloudVisionV1p1beta1GcsDestination();
  buildCounterGoogleCloudVisionV1p1beta1GcsDestination++;
  if (buildCounterGoogleCloudVisionV1p1beta1GcsDestination < 3) {
    o.uri = 'foo';
  }
  buildCounterGoogleCloudVisionV1p1beta1GcsDestination--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1GcsDestination(
    api.GoogleCloudVisionV1p1beta1GcsDestination o) {
  buildCounterGoogleCloudVisionV1p1beta1GcsDestination++;
  if (buildCounterGoogleCloudVisionV1p1beta1GcsDestination < 3) {
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1GcsDestination--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1GcsSource = 0;
api.GoogleCloudVisionV1p1beta1GcsSource
    buildGoogleCloudVisionV1p1beta1GcsSource() {
  var o = api.GoogleCloudVisionV1p1beta1GcsSource();
  buildCounterGoogleCloudVisionV1p1beta1GcsSource++;
  if (buildCounterGoogleCloudVisionV1p1beta1GcsSource < 3) {
    o.uri = 'foo';
  }
  buildCounterGoogleCloudVisionV1p1beta1GcsSource--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1GcsSource(
    api.GoogleCloudVisionV1p1beta1GcsSource o) {
  buildCounterGoogleCloudVisionV1p1beta1GcsSource++;
  if (buildCounterGoogleCloudVisionV1p1beta1GcsSource < 3) {
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1GcsSource--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1ImageAnnotationContext = 0;
api.GoogleCloudVisionV1p1beta1ImageAnnotationContext
    buildGoogleCloudVisionV1p1beta1ImageAnnotationContext() {
  var o = api.GoogleCloudVisionV1p1beta1ImageAnnotationContext();
  buildCounterGoogleCloudVisionV1p1beta1ImageAnnotationContext++;
  if (buildCounterGoogleCloudVisionV1p1beta1ImageAnnotationContext < 3) {
    o.pageNumber = 42;
    o.uri = 'foo';
  }
  buildCounterGoogleCloudVisionV1p1beta1ImageAnnotationContext--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1ImageAnnotationContext(
    api.GoogleCloudVisionV1p1beta1ImageAnnotationContext o) {
  buildCounterGoogleCloudVisionV1p1beta1ImageAnnotationContext++;
  if (buildCounterGoogleCloudVisionV1p1beta1ImageAnnotationContext < 3) {
    unittest.expect(
      o.pageNumber!,
      unittest.equals(42),
    );
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1ImageAnnotationContext--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1ImageProperties = 0;
api.GoogleCloudVisionV1p1beta1ImageProperties
    buildGoogleCloudVisionV1p1beta1ImageProperties() {
  var o = api.GoogleCloudVisionV1p1beta1ImageProperties();
  buildCounterGoogleCloudVisionV1p1beta1ImageProperties++;
  if (buildCounterGoogleCloudVisionV1p1beta1ImageProperties < 3) {
    o.dominantColors =
        buildGoogleCloudVisionV1p1beta1DominantColorsAnnotation();
  }
  buildCounterGoogleCloudVisionV1p1beta1ImageProperties--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1ImageProperties(
    api.GoogleCloudVisionV1p1beta1ImageProperties o) {
  buildCounterGoogleCloudVisionV1p1beta1ImageProperties++;
  if (buildCounterGoogleCloudVisionV1p1beta1ImageProperties < 3) {
    checkGoogleCloudVisionV1p1beta1DominantColorsAnnotation(o.dominantColors!
        as api.GoogleCloudVisionV1p1beta1DominantColorsAnnotation);
  }
  buildCounterGoogleCloudVisionV1p1beta1ImageProperties--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1InputConfig = 0;
api.GoogleCloudVisionV1p1beta1InputConfig
    buildGoogleCloudVisionV1p1beta1InputConfig() {
  var o = api.GoogleCloudVisionV1p1beta1InputConfig();
  buildCounterGoogleCloudVisionV1p1beta1InputConfig++;
  if (buildCounterGoogleCloudVisionV1p1beta1InputConfig < 3) {
    o.content = 'foo';
    o.gcsSource = buildGoogleCloudVisionV1p1beta1GcsSource();
    o.mimeType = 'foo';
  }
  buildCounterGoogleCloudVisionV1p1beta1InputConfig--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1InputConfig(
    api.GoogleCloudVisionV1p1beta1InputConfig o) {
  buildCounterGoogleCloudVisionV1p1beta1InputConfig++;
  if (buildCounterGoogleCloudVisionV1p1beta1InputConfig < 3) {
    unittest.expect(
      o.content!,
      unittest.equals('foo'),
    );
    checkGoogleCloudVisionV1p1beta1GcsSource(
        o.gcsSource! as api.GoogleCloudVisionV1p1beta1GcsSource);
    unittest.expect(
      o.mimeType!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1InputConfig--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1LocalizedObjectAnnotation = 0;
api.GoogleCloudVisionV1p1beta1LocalizedObjectAnnotation
    buildGoogleCloudVisionV1p1beta1LocalizedObjectAnnotation() {
  var o = api.GoogleCloudVisionV1p1beta1LocalizedObjectAnnotation();
  buildCounterGoogleCloudVisionV1p1beta1LocalizedObjectAnnotation++;
  if (buildCounterGoogleCloudVisionV1p1beta1LocalizedObjectAnnotation < 3) {
    o.boundingPoly = buildGoogleCloudVisionV1p1beta1BoundingPoly();
    o.languageCode = 'foo';
    o.mid = 'foo';
    o.name = 'foo';
    o.score = 42.0;
  }
  buildCounterGoogleCloudVisionV1p1beta1LocalizedObjectAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1LocalizedObjectAnnotation(
    api.GoogleCloudVisionV1p1beta1LocalizedObjectAnnotation o) {
  buildCounterGoogleCloudVisionV1p1beta1LocalizedObjectAnnotation++;
  if (buildCounterGoogleCloudVisionV1p1beta1LocalizedObjectAnnotation < 3) {
    checkGoogleCloudVisionV1p1beta1BoundingPoly(
        o.boundingPoly! as api.GoogleCloudVisionV1p1beta1BoundingPoly);
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.mid!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1LocalizedObjectAnnotation--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1LocationInfo = 0;
api.GoogleCloudVisionV1p1beta1LocationInfo
    buildGoogleCloudVisionV1p1beta1LocationInfo() {
  var o = api.GoogleCloudVisionV1p1beta1LocationInfo();
  buildCounterGoogleCloudVisionV1p1beta1LocationInfo++;
  if (buildCounterGoogleCloudVisionV1p1beta1LocationInfo < 3) {
    o.latLng = buildLatLng();
  }
  buildCounterGoogleCloudVisionV1p1beta1LocationInfo--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1LocationInfo(
    api.GoogleCloudVisionV1p1beta1LocationInfo o) {
  buildCounterGoogleCloudVisionV1p1beta1LocationInfo++;
  if (buildCounterGoogleCloudVisionV1p1beta1LocationInfo < 3) {
    checkLatLng(o.latLng! as api.LatLng);
  }
  buildCounterGoogleCloudVisionV1p1beta1LocationInfo--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1NormalizedVertex = 0;
api.GoogleCloudVisionV1p1beta1NormalizedVertex
    buildGoogleCloudVisionV1p1beta1NormalizedVertex() {
  var o = api.GoogleCloudVisionV1p1beta1NormalizedVertex();
  buildCounterGoogleCloudVisionV1p1beta1NormalizedVertex++;
  if (buildCounterGoogleCloudVisionV1p1beta1NormalizedVertex < 3) {
    o.x = 42.0;
    o.y = 42.0;
  }
  buildCounterGoogleCloudVisionV1p1beta1NormalizedVertex--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1NormalizedVertex(
    api.GoogleCloudVisionV1p1beta1NormalizedVertex o) {
  buildCounterGoogleCloudVisionV1p1beta1NormalizedVertex++;
  if (buildCounterGoogleCloudVisionV1p1beta1NormalizedVertex < 3) {
    unittest.expect(
      o.x!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.y!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1NormalizedVertex--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1OperationMetadata = 0;
api.GoogleCloudVisionV1p1beta1OperationMetadata
    buildGoogleCloudVisionV1p1beta1OperationMetadata() {
  var o = api.GoogleCloudVisionV1p1beta1OperationMetadata();
  buildCounterGoogleCloudVisionV1p1beta1OperationMetadata++;
  if (buildCounterGoogleCloudVisionV1p1beta1OperationMetadata < 3) {
    o.createTime = 'foo';
    o.state = 'foo';
    o.updateTime = 'foo';
  }
  buildCounterGoogleCloudVisionV1p1beta1OperationMetadata--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1OperationMetadata(
    api.GoogleCloudVisionV1p1beta1OperationMetadata o) {
  buildCounterGoogleCloudVisionV1p1beta1OperationMetadata++;
  if (buildCounterGoogleCloudVisionV1p1beta1OperationMetadata < 3) {
    unittest.expect(
      o.createTime!,
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
  buildCounterGoogleCloudVisionV1p1beta1OperationMetadata--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1OutputConfig = 0;
api.GoogleCloudVisionV1p1beta1OutputConfig
    buildGoogleCloudVisionV1p1beta1OutputConfig() {
  var o = api.GoogleCloudVisionV1p1beta1OutputConfig();
  buildCounterGoogleCloudVisionV1p1beta1OutputConfig++;
  if (buildCounterGoogleCloudVisionV1p1beta1OutputConfig < 3) {
    o.batchSize = 42;
    o.gcsDestination = buildGoogleCloudVisionV1p1beta1GcsDestination();
  }
  buildCounterGoogleCloudVisionV1p1beta1OutputConfig--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1OutputConfig(
    api.GoogleCloudVisionV1p1beta1OutputConfig o) {
  buildCounterGoogleCloudVisionV1p1beta1OutputConfig++;
  if (buildCounterGoogleCloudVisionV1p1beta1OutputConfig < 3) {
    unittest.expect(
      o.batchSize!,
      unittest.equals(42),
    );
    checkGoogleCloudVisionV1p1beta1GcsDestination(
        o.gcsDestination! as api.GoogleCloudVisionV1p1beta1GcsDestination);
  }
  buildCounterGoogleCloudVisionV1p1beta1OutputConfig--;
}

core.List<api.GoogleCloudVisionV1p1beta1Block> buildUnnamed6281() {
  var o = <api.GoogleCloudVisionV1p1beta1Block>[];
  o.add(buildGoogleCloudVisionV1p1beta1Block());
  o.add(buildGoogleCloudVisionV1p1beta1Block());
  return o;
}

void checkUnnamed6281(core.List<api.GoogleCloudVisionV1p1beta1Block> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1Block(
      o[0] as api.GoogleCloudVisionV1p1beta1Block);
  checkGoogleCloudVisionV1p1beta1Block(
      o[1] as api.GoogleCloudVisionV1p1beta1Block);
}

core.int buildCounterGoogleCloudVisionV1p1beta1Page = 0;
api.GoogleCloudVisionV1p1beta1Page buildGoogleCloudVisionV1p1beta1Page() {
  var o = api.GoogleCloudVisionV1p1beta1Page();
  buildCounterGoogleCloudVisionV1p1beta1Page++;
  if (buildCounterGoogleCloudVisionV1p1beta1Page < 3) {
    o.blocks = buildUnnamed6281();
    o.confidence = 42.0;
    o.height = 42;
    o.property = buildGoogleCloudVisionV1p1beta1TextAnnotationTextProperty();
    o.width = 42;
  }
  buildCounterGoogleCloudVisionV1p1beta1Page--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1Page(api.GoogleCloudVisionV1p1beta1Page o) {
  buildCounterGoogleCloudVisionV1p1beta1Page++;
  if (buildCounterGoogleCloudVisionV1p1beta1Page < 3) {
    checkUnnamed6281(o.blocks!);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.height!,
      unittest.equals(42),
    );
    checkGoogleCloudVisionV1p1beta1TextAnnotationTextProperty(o.property!
        as api.GoogleCloudVisionV1p1beta1TextAnnotationTextProperty);
    unittest.expect(
      o.width!,
      unittest.equals(42),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1Page--;
}

core.List<api.GoogleCloudVisionV1p1beta1Word> buildUnnamed6282() {
  var o = <api.GoogleCloudVisionV1p1beta1Word>[];
  o.add(buildGoogleCloudVisionV1p1beta1Word());
  o.add(buildGoogleCloudVisionV1p1beta1Word());
  return o;
}

void checkUnnamed6282(core.List<api.GoogleCloudVisionV1p1beta1Word> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1Word(
      o[0] as api.GoogleCloudVisionV1p1beta1Word);
  checkGoogleCloudVisionV1p1beta1Word(
      o[1] as api.GoogleCloudVisionV1p1beta1Word);
}

core.int buildCounterGoogleCloudVisionV1p1beta1Paragraph = 0;
api.GoogleCloudVisionV1p1beta1Paragraph
    buildGoogleCloudVisionV1p1beta1Paragraph() {
  var o = api.GoogleCloudVisionV1p1beta1Paragraph();
  buildCounterGoogleCloudVisionV1p1beta1Paragraph++;
  if (buildCounterGoogleCloudVisionV1p1beta1Paragraph < 3) {
    o.boundingBox = buildGoogleCloudVisionV1p1beta1BoundingPoly();
    o.confidence = 42.0;
    o.property = buildGoogleCloudVisionV1p1beta1TextAnnotationTextProperty();
    o.words = buildUnnamed6282();
  }
  buildCounterGoogleCloudVisionV1p1beta1Paragraph--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1Paragraph(
    api.GoogleCloudVisionV1p1beta1Paragraph o) {
  buildCounterGoogleCloudVisionV1p1beta1Paragraph++;
  if (buildCounterGoogleCloudVisionV1p1beta1Paragraph < 3) {
    checkGoogleCloudVisionV1p1beta1BoundingPoly(
        o.boundingBox! as api.GoogleCloudVisionV1p1beta1BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVisionV1p1beta1TextAnnotationTextProperty(o.property!
        as api.GoogleCloudVisionV1p1beta1TextAnnotationTextProperty);
    checkUnnamed6282(o.words!);
  }
  buildCounterGoogleCloudVisionV1p1beta1Paragraph--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1Position = 0;
api.GoogleCloudVisionV1p1beta1Position
    buildGoogleCloudVisionV1p1beta1Position() {
  var o = api.GoogleCloudVisionV1p1beta1Position();
  buildCounterGoogleCloudVisionV1p1beta1Position++;
  if (buildCounterGoogleCloudVisionV1p1beta1Position < 3) {
    o.x = 42.0;
    o.y = 42.0;
    o.z = 42.0;
  }
  buildCounterGoogleCloudVisionV1p1beta1Position--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1Position(
    api.GoogleCloudVisionV1p1beta1Position o) {
  buildCounterGoogleCloudVisionV1p1beta1Position++;
  if (buildCounterGoogleCloudVisionV1p1beta1Position < 3) {
    unittest.expect(
      o.x!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.y!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.z!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1Position--;
}

core.List<api.GoogleCloudVisionV1p1beta1ProductKeyValue> buildUnnamed6283() {
  var o = <api.GoogleCloudVisionV1p1beta1ProductKeyValue>[];
  o.add(buildGoogleCloudVisionV1p1beta1ProductKeyValue());
  o.add(buildGoogleCloudVisionV1p1beta1ProductKeyValue());
  return o;
}

void checkUnnamed6283(
    core.List<api.GoogleCloudVisionV1p1beta1ProductKeyValue> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1ProductKeyValue(
      o[0] as api.GoogleCloudVisionV1p1beta1ProductKeyValue);
  checkGoogleCloudVisionV1p1beta1ProductKeyValue(
      o[1] as api.GoogleCloudVisionV1p1beta1ProductKeyValue);
}

core.int buildCounterGoogleCloudVisionV1p1beta1Product = 0;
api.GoogleCloudVisionV1p1beta1Product buildGoogleCloudVisionV1p1beta1Product() {
  var o = api.GoogleCloudVisionV1p1beta1Product();
  buildCounterGoogleCloudVisionV1p1beta1Product++;
  if (buildCounterGoogleCloudVisionV1p1beta1Product < 3) {
    o.description = 'foo';
    o.displayName = 'foo';
    o.name = 'foo';
    o.productCategory = 'foo';
    o.productLabels = buildUnnamed6283();
  }
  buildCounterGoogleCloudVisionV1p1beta1Product--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1Product(
    api.GoogleCloudVisionV1p1beta1Product o) {
  buildCounterGoogleCloudVisionV1p1beta1Product++;
  if (buildCounterGoogleCloudVisionV1p1beta1Product < 3) {
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
      o.productCategory!,
      unittest.equals('foo'),
    );
    checkUnnamed6283(o.productLabels!);
  }
  buildCounterGoogleCloudVisionV1p1beta1Product--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1ProductKeyValue = 0;
api.GoogleCloudVisionV1p1beta1ProductKeyValue
    buildGoogleCloudVisionV1p1beta1ProductKeyValue() {
  var o = api.GoogleCloudVisionV1p1beta1ProductKeyValue();
  buildCounterGoogleCloudVisionV1p1beta1ProductKeyValue++;
  if (buildCounterGoogleCloudVisionV1p1beta1ProductKeyValue < 3) {
    o.key = 'foo';
    o.value = 'foo';
  }
  buildCounterGoogleCloudVisionV1p1beta1ProductKeyValue--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1ProductKeyValue(
    api.GoogleCloudVisionV1p1beta1ProductKeyValue o) {
  buildCounterGoogleCloudVisionV1p1beta1ProductKeyValue++;
  if (buildCounterGoogleCloudVisionV1p1beta1ProductKeyValue < 3) {
    unittest.expect(
      o.key!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1ProductKeyValue--;
}

core.List<api.GoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult>
    buildUnnamed6284() {
  var o = <api.GoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult>[];
  o.add(buildGoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult());
  o.add(buildGoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult());
  return o;
}

void checkUnnamed6284(
    core.List<api.GoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult(
      o[0] as api.GoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult);
  checkGoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult(
      o[1] as api.GoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult);
}

core.List<api.GoogleCloudVisionV1p1beta1ProductSearchResultsResult>
    buildUnnamed6285() {
  var o = <api.GoogleCloudVisionV1p1beta1ProductSearchResultsResult>[];
  o.add(buildGoogleCloudVisionV1p1beta1ProductSearchResultsResult());
  o.add(buildGoogleCloudVisionV1p1beta1ProductSearchResultsResult());
  return o;
}

void checkUnnamed6285(
    core.List<api.GoogleCloudVisionV1p1beta1ProductSearchResultsResult> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1ProductSearchResultsResult(
      o[0] as api.GoogleCloudVisionV1p1beta1ProductSearchResultsResult);
  checkGoogleCloudVisionV1p1beta1ProductSearchResultsResult(
      o[1] as api.GoogleCloudVisionV1p1beta1ProductSearchResultsResult);
}

core.int buildCounterGoogleCloudVisionV1p1beta1ProductSearchResults = 0;
api.GoogleCloudVisionV1p1beta1ProductSearchResults
    buildGoogleCloudVisionV1p1beta1ProductSearchResults() {
  var o = api.GoogleCloudVisionV1p1beta1ProductSearchResults();
  buildCounterGoogleCloudVisionV1p1beta1ProductSearchResults++;
  if (buildCounterGoogleCloudVisionV1p1beta1ProductSearchResults < 3) {
    o.indexTime = 'foo';
    o.productGroupedResults = buildUnnamed6284();
    o.results = buildUnnamed6285();
  }
  buildCounterGoogleCloudVisionV1p1beta1ProductSearchResults--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1ProductSearchResults(
    api.GoogleCloudVisionV1p1beta1ProductSearchResults o) {
  buildCounterGoogleCloudVisionV1p1beta1ProductSearchResults++;
  if (buildCounterGoogleCloudVisionV1p1beta1ProductSearchResults < 3) {
    unittest.expect(
      o.indexTime!,
      unittest.equals('foo'),
    );
    checkUnnamed6284(o.productGroupedResults!);
    checkUnnamed6285(o.results!);
  }
  buildCounterGoogleCloudVisionV1p1beta1ProductSearchResults--;
}

core.List<api.GoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation>
    buildUnnamed6286() {
  var o =
      <api.GoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation>[];
  o.add(buildGoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation());
  o.add(buildGoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation());
  return o;
}

void checkUnnamed6286(
    core.List<
            api.GoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation(o[0]
      as api.GoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation);
  checkGoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation(o[1]
      as api.GoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation);
}

core.List<api.GoogleCloudVisionV1p1beta1ProductSearchResultsResult>
    buildUnnamed6287() {
  var o = <api.GoogleCloudVisionV1p1beta1ProductSearchResultsResult>[];
  o.add(buildGoogleCloudVisionV1p1beta1ProductSearchResultsResult());
  o.add(buildGoogleCloudVisionV1p1beta1ProductSearchResultsResult());
  return o;
}

void checkUnnamed6287(
    core.List<api.GoogleCloudVisionV1p1beta1ProductSearchResultsResult> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1ProductSearchResultsResult(
      o[0] as api.GoogleCloudVisionV1p1beta1ProductSearchResultsResult);
  checkGoogleCloudVisionV1p1beta1ProductSearchResultsResult(
      o[1] as api.GoogleCloudVisionV1p1beta1ProductSearchResultsResult);
}

core.int
    buildCounterGoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult = 0;
api.GoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult
    buildGoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult() {
  var o = api.GoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult();
  buildCounterGoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult++;
  if (buildCounterGoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult <
      3) {
    o.boundingPoly = buildGoogleCloudVisionV1p1beta1BoundingPoly();
    o.objectAnnotations = buildUnnamed6286();
    o.results = buildUnnamed6287();
  }
  buildCounterGoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult(
    api.GoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult o) {
  buildCounterGoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult++;
  if (buildCounterGoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult <
      3) {
    checkGoogleCloudVisionV1p1beta1BoundingPoly(
        o.boundingPoly! as api.GoogleCloudVisionV1p1beta1BoundingPoly);
    checkUnnamed6286(o.objectAnnotations!);
    checkUnnamed6287(o.results!);
  }
  buildCounterGoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult--;
}

core.int
    buildCounterGoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation =
    0;
api.GoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation
    buildGoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation() {
  var o = api.GoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation();
  buildCounterGoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation++;
  if (buildCounterGoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation <
      3) {
    o.languageCode = 'foo';
    o.mid = 'foo';
    o.name = 'foo';
    o.score = 42.0;
  }
  buildCounterGoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation(
    api.GoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation o) {
  buildCounterGoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation++;
  if (buildCounterGoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation <
      3) {
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.mid!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1ProductSearchResultsResult = 0;
api.GoogleCloudVisionV1p1beta1ProductSearchResultsResult
    buildGoogleCloudVisionV1p1beta1ProductSearchResultsResult() {
  var o = api.GoogleCloudVisionV1p1beta1ProductSearchResultsResult();
  buildCounterGoogleCloudVisionV1p1beta1ProductSearchResultsResult++;
  if (buildCounterGoogleCloudVisionV1p1beta1ProductSearchResultsResult < 3) {
    o.image = 'foo';
    o.product = buildGoogleCloudVisionV1p1beta1Product();
    o.score = 42.0;
  }
  buildCounterGoogleCloudVisionV1p1beta1ProductSearchResultsResult--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1ProductSearchResultsResult(
    api.GoogleCloudVisionV1p1beta1ProductSearchResultsResult o) {
  buildCounterGoogleCloudVisionV1p1beta1ProductSearchResultsResult++;
  if (buildCounterGoogleCloudVisionV1p1beta1ProductSearchResultsResult < 3) {
    unittest.expect(
      o.image!,
      unittest.equals('foo'),
    );
    checkGoogleCloudVisionV1p1beta1Product(
        o.product! as api.GoogleCloudVisionV1p1beta1Product);
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1ProductSearchResultsResult--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1Property = 0;
api.GoogleCloudVisionV1p1beta1Property
    buildGoogleCloudVisionV1p1beta1Property() {
  var o = api.GoogleCloudVisionV1p1beta1Property();
  buildCounterGoogleCloudVisionV1p1beta1Property++;
  if (buildCounterGoogleCloudVisionV1p1beta1Property < 3) {
    o.name = 'foo';
    o.uint64Value = 'foo';
    o.value = 'foo';
  }
  buildCounterGoogleCloudVisionV1p1beta1Property--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1Property(
    api.GoogleCloudVisionV1p1beta1Property o) {
  buildCounterGoogleCloudVisionV1p1beta1Property++;
  if (buildCounterGoogleCloudVisionV1p1beta1Property < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.uint64Value!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1Property--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1SafeSearchAnnotation = 0;
api.GoogleCloudVisionV1p1beta1SafeSearchAnnotation
    buildGoogleCloudVisionV1p1beta1SafeSearchAnnotation() {
  var o = api.GoogleCloudVisionV1p1beta1SafeSearchAnnotation();
  buildCounterGoogleCloudVisionV1p1beta1SafeSearchAnnotation++;
  if (buildCounterGoogleCloudVisionV1p1beta1SafeSearchAnnotation < 3) {
    o.adult = 'foo';
    o.medical = 'foo';
    o.racy = 'foo';
    o.spoof = 'foo';
    o.violence = 'foo';
  }
  buildCounterGoogleCloudVisionV1p1beta1SafeSearchAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1SafeSearchAnnotation(
    api.GoogleCloudVisionV1p1beta1SafeSearchAnnotation o) {
  buildCounterGoogleCloudVisionV1p1beta1SafeSearchAnnotation++;
  if (buildCounterGoogleCloudVisionV1p1beta1SafeSearchAnnotation < 3) {
    unittest.expect(
      o.adult!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.medical!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.racy!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.spoof!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.violence!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1SafeSearchAnnotation--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1Symbol = 0;
api.GoogleCloudVisionV1p1beta1Symbol buildGoogleCloudVisionV1p1beta1Symbol() {
  var o = api.GoogleCloudVisionV1p1beta1Symbol();
  buildCounterGoogleCloudVisionV1p1beta1Symbol++;
  if (buildCounterGoogleCloudVisionV1p1beta1Symbol < 3) {
    o.boundingBox = buildGoogleCloudVisionV1p1beta1BoundingPoly();
    o.confidence = 42.0;
    o.property = buildGoogleCloudVisionV1p1beta1TextAnnotationTextProperty();
    o.text = 'foo';
  }
  buildCounterGoogleCloudVisionV1p1beta1Symbol--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1Symbol(
    api.GoogleCloudVisionV1p1beta1Symbol o) {
  buildCounterGoogleCloudVisionV1p1beta1Symbol++;
  if (buildCounterGoogleCloudVisionV1p1beta1Symbol < 3) {
    checkGoogleCloudVisionV1p1beta1BoundingPoly(
        o.boundingBox! as api.GoogleCloudVisionV1p1beta1BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVisionV1p1beta1TextAnnotationTextProperty(o.property!
        as api.GoogleCloudVisionV1p1beta1TextAnnotationTextProperty);
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1Symbol--;
}

core.List<api.GoogleCloudVisionV1p1beta1Page> buildUnnamed6288() {
  var o = <api.GoogleCloudVisionV1p1beta1Page>[];
  o.add(buildGoogleCloudVisionV1p1beta1Page());
  o.add(buildGoogleCloudVisionV1p1beta1Page());
  return o;
}

void checkUnnamed6288(core.List<api.GoogleCloudVisionV1p1beta1Page> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1Page(
      o[0] as api.GoogleCloudVisionV1p1beta1Page);
  checkGoogleCloudVisionV1p1beta1Page(
      o[1] as api.GoogleCloudVisionV1p1beta1Page);
}

core.int buildCounterGoogleCloudVisionV1p1beta1TextAnnotation = 0;
api.GoogleCloudVisionV1p1beta1TextAnnotation
    buildGoogleCloudVisionV1p1beta1TextAnnotation() {
  var o = api.GoogleCloudVisionV1p1beta1TextAnnotation();
  buildCounterGoogleCloudVisionV1p1beta1TextAnnotation++;
  if (buildCounterGoogleCloudVisionV1p1beta1TextAnnotation < 3) {
    o.pages = buildUnnamed6288();
    o.text = 'foo';
  }
  buildCounterGoogleCloudVisionV1p1beta1TextAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1TextAnnotation(
    api.GoogleCloudVisionV1p1beta1TextAnnotation o) {
  buildCounterGoogleCloudVisionV1p1beta1TextAnnotation++;
  if (buildCounterGoogleCloudVisionV1p1beta1TextAnnotation < 3) {
    checkUnnamed6288(o.pages!);
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1TextAnnotation--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1TextAnnotationDetectedBreak = 0;
api.GoogleCloudVisionV1p1beta1TextAnnotationDetectedBreak
    buildGoogleCloudVisionV1p1beta1TextAnnotationDetectedBreak() {
  var o = api.GoogleCloudVisionV1p1beta1TextAnnotationDetectedBreak();
  buildCounterGoogleCloudVisionV1p1beta1TextAnnotationDetectedBreak++;
  if (buildCounterGoogleCloudVisionV1p1beta1TextAnnotationDetectedBreak < 3) {
    o.isPrefix = true;
    o.type = 'foo';
  }
  buildCounterGoogleCloudVisionV1p1beta1TextAnnotationDetectedBreak--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1TextAnnotationDetectedBreak(
    api.GoogleCloudVisionV1p1beta1TextAnnotationDetectedBreak o) {
  buildCounterGoogleCloudVisionV1p1beta1TextAnnotationDetectedBreak++;
  if (buildCounterGoogleCloudVisionV1p1beta1TextAnnotationDetectedBreak < 3) {
    unittest.expect(o.isPrefix!, unittest.isTrue);
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1TextAnnotationDetectedBreak--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage =
    0;
api.GoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage
    buildGoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage() {
  var o = api.GoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage();
  buildCounterGoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage++;
  if (buildCounterGoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage <
      3) {
    o.confidence = 42.0;
    o.languageCode = 'foo';
  }
  buildCounterGoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage(
    api.GoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage o) {
  buildCounterGoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage++;
  if (buildCounterGoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage <
      3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage--;
}

core.List<api.GoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage>
    buildUnnamed6289() {
  var o = <api.GoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage>[];
  o.add(buildGoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage());
  o.add(buildGoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage());
  return o;
}

void checkUnnamed6289(
    core.List<api.GoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage(
      o[0] as api.GoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage);
  checkGoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage(
      o[1] as api.GoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage);
}

core.int buildCounterGoogleCloudVisionV1p1beta1TextAnnotationTextProperty = 0;
api.GoogleCloudVisionV1p1beta1TextAnnotationTextProperty
    buildGoogleCloudVisionV1p1beta1TextAnnotationTextProperty() {
  var o = api.GoogleCloudVisionV1p1beta1TextAnnotationTextProperty();
  buildCounterGoogleCloudVisionV1p1beta1TextAnnotationTextProperty++;
  if (buildCounterGoogleCloudVisionV1p1beta1TextAnnotationTextProperty < 3) {
    o.detectedBreak =
        buildGoogleCloudVisionV1p1beta1TextAnnotationDetectedBreak();
    o.detectedLanguages = buildUnnamed6289();
  }
  buildCounterGoogleCloudVisionV1p1beta1TextAnnotationTextProperty--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1TextAnnotationTextProperty(
    api.GoogleCloudVisionV1p1beta1TextAnnotationTextProperty o) {
  buildCounterGoogleCloudVisionV1p1beta1TextAnnotationTextProperty++;
  if (buildCounterGoogleCloudVisionV1p1beta1TextAnnotationTextProperty < 3) {
    checkGoogleCloudVisionV1p1beta1TextAnnotationDetectedBreak(o.detectedBreak!
        as api.GoogleCloudVisionV1p1beta1TextAnnotationDetectedBreak);
    checkUnnamed6289(o.detectedLanguages!);
  }
  buildCounterGoogleCloudVisionV1p1beta1TextAnnotationTextProperty--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1Vertex = 0;
api.GoogleCloudVisionV1p1beta1Vertex buildGoogleCloudVisionV1p1beta1Vertex() {
  var o = api.GoogleCloudVisionV1p1beta1Vertex();
  buildCounterGoogleCloudVisionV1p1beta1Vertex++;
  if (buildCounterGoogleCloudVisionV1p1beta1Vertex < 3) {
    o.x = 42;
    o.y = 42;
  }
  buildCounterGoogleCloudVisionV1p1beta1Vertex--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1Vertex(
    api.GoogleCloudVisionV1p1beta1Vertex o) {
  buildCounterGoogleCloudVisionV1p1beta1Vertex++;
  if (buildCounterGoogleCloudVisionV1p1beta1Vertex < 3) {
    unittest.expect(
      o.x!,
      unittest.equals(42),
    );
    unittest.expect(
      o.y!,
      unittest.equals(42),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1Vertex--;
}

core.List<api.GoogleCloudVisionV1p1beta1WebDetectionWebLabel>
    buildUnnamed6290() {
  var o = <api.GoogleCloudVisionV1p1beta1WebDetectionWebLabel>[];
  o.add(buildGoogleCloudVisionV1p1beta1WebDetectionWebLabel());
  o.add(buildGoogleCloudVisionV1p1beta1WebDetectionWebLabel());
  return o;
}

void checkUnnamed6290(
    core.List<api.GoogleCloudVisionV1p1beta1WebDetectionWebLabel> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1WebDetectionWebLabel(
      o[0] as api.GoogleCloudVisionV1p1beta1WebDetectionWebLabel);
  checkGoogleCloudVisionV1p1beta1WebDetectionWebLabel(
      o[1] as api.GoogleCloudVisionV1p1beta1WebDetectionWebLabel);
}

core.List<api.GoogleCloudVisionV1p1beta1WebDetectionWebImage>
    buildUnnamed6291() {
  var o = <api.GoogleCloudVisionV1p1beta1WebDetectionWebImage>[];
  o.add(buildGoogleCloudVisionV1p1beta1WebDetectionWebImage());
  o.add(buildGoogleCloudVisionV1p1beta1WebDetectionWebImage());
  return o;
}

void checkUnnamed6291(
    core.List<api.GoogleCloudVisionV1p1beta1WebDetectionWebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1WebDetectionWebImage(
      o[0] as api.GoogleCloudVisionV1p1beta1WebDetectionWebImage);
  checkGoogleCloudVisionV1p1beta1WebDetectionWebImage(
      o[1] as api.GoogleCloudVisionV1p1beta1WebDetectionWebImage);
}

core.List<api.GoogleCloudVisionV1p1beta1WebDetectionWebPage>
    buildUnnamed6292() {
  var o = <api.GoogleCloudVisionV1p1beta1WebDetectionWebPage>[];
  o.add(buildGoogleCloudVisionV1p1beta1WebDetectionWebPage());
  o.add(buildGoogleCloudVisionV1p1beta1WebDetectionWebPage());
  return o;
}

void checkUnnamed6292(
    core.List<api.GoogleCloudVisionV1p1beta1WebDetectionWebPage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1WebDetectionWebPage(
      o[0] as api.GoogleCloudVisionV1p1beta1WebDetectionWebPage);
  checkGoogleCloudVisionV1p1beta1WebDetectionWebPage(
      o[1] as api.GoogleCloudVisionV1p1beta1WebDetectionWebPage);
}

core.List<api.GoogleCloudVisionV1p1beta1WebDetectionWebImage>
    buildUnnamed6293() {
  var o = <api.GoogleCloudVisionV1p1beta1WebDetectionWebImage>[];
  o.add(buildGoogleCloudVisionV1p1beta1WebDetectionWebImage());
  o.add(buildGoogleCloudVisionV1p1beta1WebDetectionWebImage());
  return o;
}

void checkUnnamed6293(
    core.List<api.GoogleCloudVisionV1p1beta1WebDetectionWebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1WebDetectionWebImage(
      o[0] as api.GoogleCloudVisionV1p1beta1WebDetectionWebImage);
  checkGoogleCloudVisionV1p1beta1WebDetectionWebImage(
      o[1] as api.GoogleCloudVisionV1p1beta1WebDetectionWebImage);
}

core.List<api.GoogleCloudVisionV1p1beta1WebDetectionWebImage>
    buildUnnamed6294() {
  var o = <api.GoogleCloudVisionV1p1beta1WebDetectionWebImage>[];
  o.add(buildGoogleCloudVisionV1p1beta1WebDetectionWebImage());
  o.add(buildGoogleCloudVisionV1p1beta1WebDetectionWebImage());
  return o;
}

void checkUnnamed6294(
    core.List<api.GoogleCloudVisionV1p1beta1WebDetectionWebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1WebDetectionWebImage(
      o[0] as api.GoogleCloudVisionV1p1beta1WebDetectionWebImage);
  checkGoogleCloudVisionV1p1beta1WebDetectionWebImage(
      o[1] as api.GoogleCloudVisionV1p1beta1WebDetectionWebImage);
}

core.List<api.GoogleCloudVisionV1p1beta1WebDetectionWebEntity>
    buildUnnamed6295() {
  var o = <api.GoogleCloudVisionV1p1beta1WebDetectionWebEntity>[];
  o.add(buildGoogleCloudVisionV1p1beta1WebDetectionWebEntity());
  o.add(buildGoogleCloudVisionV1p1beta1WebDetectionWebEntity());
  return o;
}

void checkUnnamed6295(
    core.List<api.GoogleCloudVisionV1p1beta1WebDetectionWebEntity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1WebDetectionWebEntity(
      o[0] as api.GoogleCloudVisionV1p1beta1WebDetectionWebEntity);
  checkGoogleCloudVisionV1p1beta1WebDetectionWebEntity(
      o[1] as api.GoogleCloudVisionV1p1beta1WebDetectionWebEntity);
}

core.int buildCounterGoogleCloudVisionV1p1beta1WebDetection = 0;
api.GoogleCloudVisionV1p1beta1WebDetection
    buildGoogleCloudVisionV1p1beta1WebDetection() {
  var o = api.GoogleCloudVisionV1p1beta1WebDetection();
  buildCounterGoogleCloudVisionV1p1beta1WebDetection++;
  if (buildCounterGoogleCloudVisionV1p1beta1WebDetection < 3) {
    o.bestGuessLabels = buildUnnamed6290();
    o.fullMatchingImages = buildUnnamed6291();
    o.pagesWithMatchingImages = buildUnnamed6292();
    o.partialMatchingImages = buildUnnamed6293();
    o.visuallySimilarImages = buildUnnamed6294();
    o.webEntities = buildUnnamed6295();
  }
  buildCounterGoogleCloudVisionV1p1beta1WebDetection--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1WebDetection(
    api.GoogleCloudVisionV1p1beta1WebDetection o) {
  buildCounterGoogleCloudVisionV1p1beta1WebDetection++;
  if (buildCounterGoogleCloudVisionV1p1beta1WebDetection < 3) {
    checkUnnamed6290(o.bestGuessLabels!);
    checkUnnamed6291(o.fullMatchingImages!);
    checkUnnamed6292(o.pagesWithMatchingImages!);
    checkUnnamed6293(o.partialMatchingImages!);
    checkUnnamed6294(o.visuallySimilarImages!);
    checkUnnamed6295(o.webEntities!);
  }
  buildCounterGoogleCloudVisionV1p1beta1WebDetection--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebEntity = 0;
api.GoogleCloudVisionV1p1beta1WebDetectionWebEntity
    buildGoogleCloudVisionV1p1beta1WebDetectionWebEntity() {
  var o = api.GoogleCloudVisionV1p1beta1WebDetectionWebEntity();
  buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebEntity++;
  if (buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebEntity < 3) {
    o.description = 'foo';
    o.entityId = 'foo';
    o.score = 42.0;
  }
  buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebEntity--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1WebDetectionWebEntity(
    api.GoogleCloudVisionV1p1beta1WebDetectionWebEntity o) {
  buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebEntity++;
  if (buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebEntity < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.entityId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebEntity--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebImage = 0;
api.GoogleCloudVisionV1p1beta1WebDetectionWebImage
    buildGoogleCloudVisionV1p1beta1WebDetectionWebImage() {
  var o = api.GoogleCloudVisionV1p1beta1WebDetectionWebImage();
  buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebImage++;
  if (buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebImage < 3) {
    o.score = 42.0;
    o.url = 'foo';
  }
  buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebImage--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1WebDetectionWebImage(
    api.GoogleCloudVisionV1p1beta1WebDetectionWebImage o) {
  buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebImage++;
  if (buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebImage < 3) {
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.url!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebImage--;
}

core.int buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebLabel = 0;
api.GoogleCloudVisionV1p1beta1WebDetectionWebLabel
    buildGoogleCloudVisionV1p1beta1WebDetectionWebLabel() {
  var o = api.GoogleCloudVisionV1p1beta1WebDetectionWebLabel();
  buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebLabel++;
  if (buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebLabel < 3) {
    o.label = 'foo';
    o.languageCode = 'foo';
  }
  buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebLabel--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1WebDetectionWebLabel(
    api.GoogleCloudVisionV1p1beta1WebDetectionWebLabel o) {
  buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebLabel++;
  if (buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebLabel < 3) {
    unittest.expect(
      o.label!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebLabel--;
}

core.List<api.GoogleCloudVisionV1p1beta1WebDetectionWebImage>
    buildUnnamed6296() {
  var o = <api.GoogleCloudVisionV1p1beta1WebDetectionWebImage>[];
  o.add(buildGoogleCloudVisionV1p1beta1WebDetectionWebImage());
  o.add(buildGoogleCloudVisionV1p1beta1WebDetectionWebImage());
  return o;
}

void checkUnnamed6296(
    core.List<api.GoogleCloudVisionV1p1beta1WebDetectionWebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1WebDetectionWebImage(
      o[0] as api.GoogleCloudVisionV1p1beta1WebDetectionWebImage);
  checkGoogleCloudVisionV1p1beta1WebDetectionWebImage(
      o[1] as api.GoogleCloudVisionV1p1beta1WebDetectionWebImage);
}

core.List<api.GoogleCloudVisionV1p1beta1WebDetectionWebImage>
    buildUnnamed6297() {
  var o = <api.GoogleCloudVisionV1p1beta1WebDetectionWebImage>[];
  o.add(buildGoogleCloudVisionV1p1beta1WebDetectionWebImage());
  o.add(buildGoogleCloudVisionV1p1beta1WebDetectionWebImage());
  return o;
}

void checkUnnamed6297(
    core.List<api.GoogleCloudVisionV1p1beta1WebDetectionWebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1WebDetectionWebImage(
      o[0] as api.GoogleCloudVisionV1p1beta1WebDetectionWebImage);
  checkGoogleCloudVisionV1p1beta1WebDetectionWebImage(
      o[1] as api.GoogleCloudVisionV1p1beta1WebDetectionWebImage);
}

core.int buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebPage = 0;
api.GoogleCloudVisionV1p1beta1WebDetectionWebPage
    buildGoogleCloudVisionV1p1beta1WebDetectionWebPage() {
  var o = api.GoogleCloudVisionV1p1beta1WebDetectionWebPage();
  buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebPage++;
  if (buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebPage < 3) {
    o.fullMatchingImages = buildUnnamed6296();
    o.pageTitle = 'foo';
    o.partialMatchingImages = buildUnnamed6297();
    o.score = 42.0;
    o.url = 'foo';
  }
  buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebPage--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1WebDetectionWebPage(
    api.GoogleCloudVisionV1p1beta1WebDetectionWebPage o) {
  buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebPage++;
  if (buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebPage < 3) {
    checkUnnamed6296(o.fullMatchingImages!);
    unittest.expect(
      o.pageTitle!,
      unittest.equals('foo'),
    );
    checkUnnamed6297(o.partialMatchingImages!);
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.url!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p1beta1WebDetectionWebPage--;
}

core.List<api.GoogleCloudVisionV1p1beta1Symbol> buildUnnamed6298() {
  var o = <api.GoogleCloudVisionV1p1beta1Symbol>[];
  o.add(buildGoogleCloudVisionV1p1beta1Symbol());
  o.add(buildGoogleCloudVisionV1p1beta1Symbol());
  return o;
}

void checkUnnamed6298(core.List<api.GoogleCloudVisionV1p1beta1Symbol> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p1beta1Symbol(
      o[0] as api.GoogleCloudVisionV1p1beta1Symbol);
  checkGoogleCloudVisionV1p1beta1Symbol(
      o[1] as api.GoogleCloudVisionV1p1beta1Symbol);
}

core.int buildCounterGoogleCloudVisionV1p1beta1Word = 0;
api.GoogleCloudVisionV1p1beta1Word buildGoogleCloudVisionV1p1beta1Word() {
  var o = api.GoogleCloudVisionV1p1beta1Word();
  buildCounterGoogleCloudVisionV1p1beta1Word++;
  if (buildCounterGoogleCloudVisionV1p1beta1Word < 3) {
    o.boundingBox = buildGoogleCloudVisionV1p1beta1BoundingPoly();
    o.confidence = 42.0;
    o.property = buildGoogleCloudVisionV1p1beta1TextAnnotationTextProperty();
    o.symbols = buildUnnamed6298();
  }
  buildCounterGoogleCloudVisionV1p1beta1Word--;
  return o;
}

void checkGoogleCloudVisionV1p1beta1Word(api.GoogleCloudVisionV1p1beta1Word o) {
  buildCounterGoogleCloudVisionV1p1beta1Word++;
  if (buildCounterGoogleCloudVisionV1p1beta1Word < 3) {
    checkGoogleCloudVisionV1p1beta1BoundingPoly(
        o.boundingBox! as api.GoogleCloudVisionV1p1beta1BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVisionV1p1beta1TextAnnotationTextProperty(o.property!
        as api.GoogleCloudVisionV1p1beta1TextAnnotationTextProperty);
    checkUnnamed6298(o.symbols!);
  }
  buildCounterGoogleCloudVisionV1p1beta1Word--;
}

core.List<api.GoogleCloudVisionV1p2beta1AnnotateImageResponse>
    buildUnnamed6299() {
  var o = <api.GoogleCloudVisionV1p2beta1AnnotateImageResponse>[];
  o.add(buildGoogleCloudVisionV1p2beta1AnnotateImageResponse());
  o.add(buildGoogleCloudVisionV1p2beta1AnnotateImageResponse());
  return o;
}

void checkUnnamed6299(
    core.List<api.GoogleCloudVisionV1p2beta1AnnotateImageResponse> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1AnnotateImageResponse(
      o[0] as api.GoogleCloudVisionV1p2beta1AnnotateImageResponse);
  checkGoogleCloudVisionV1p2beta1AnnotateImageResponse(
      o[1] as api.GoogleCloudVisionV1p2beta1AnnotateImageResponse);
}

core.int buildCounterGoogleCloudVisionV1p2beta1AnnotateFileResponse = 0;
api.GoogleCloudVisionV1p2beta1AnnotateFileResponse
    buildGoogleCloudVisionV1p2beta1AnnotateFileResponse() {
  var o = api.GoogleCloudVisionV1p2beta1AnnotateFileResponse();
  buildCounterGoogleCloudVisionV1p2beta1AnnotateFileResponse++;
  if (buildCounterGoogleCloudVisionV1p2beta1AnnotateFileResponse < 3) {
    o.error = buildStatus();
    o.inputConfig = buildGoogleCloudVisionV1p2beta1InputConfig();
    o.responses = buildUnnamed6299();
    o.totalPages = 42;
  }
  buildCounterGoogleCloudVisionV1p2beta1AnnotateFileResponse--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1AnnotateFileResponse(
    api.GoogleCloudVisionV1p2beta1AnnotateFileResponse o) {
  buildCounterGoogleCloudVisionV1p2beta1AnnotateFileResponse++;
  if (buildCounterGoogleCloudVisionV1p2beta1AnnotateFileResponse < 3) {
    checkStatus(o.error! as api.Status);
    checkGoogleCloudVisionV1p2beta1InputConfig(
        o.inputConfig! as api.GoogleCloudVisionV1p2beta1InputConfig);
    checkUnnamed6299(o.responses!);
    unittest.expect(
      o.totalPages!,
      unittest.equals(42),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1AnnotateFileResponse--;
}

core.List<api.GoogleCloudVisionV1p2beta1FaceAnnotation> buildUnnamed6300() {
  var o = <api.GoogleCloudVisionV1p2beta1FaceAnnotation>[];
  o.add(buildGoogleCloudVisionV1p2beta1FaceAnnotation());
  o.add(buildGoogleCloudVisionV1p2beta1FaceAnnotation());
  return o;
}

void checkUnnamed6300(
    core.List<api.GoogleCloudVisionV1p2beta1FaceAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1FaceAnnotation(
      o[0] as api.GoogleCloudVisionV1p2beta1FaceAnnotation);
  checkGoogleCloudVisionV1p2beta1FaceAnnotation(
      o[1] as api.GoogleCloudVisionV1p2beta1FaceAnnotation);
}

core.List<api.GoogleCloudVisionV1p2beta1EntityAnnotation> buildUnnamed6301() {
  var o = <api.GoogleCloudVisionV1p2beta1EntityAnnotation>[];
  o.add(buildGoogleCloudVisionV1p2beta1EntityAnnotation());
  o.add(buildGoogleCloudVisionV1p2beta1EntityAnnotation());
  return o;
}

void checkUnnamed6301(
    core.List<api.GoogleCloudVisionV1p2beta1EntityAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1EntityAnnotation(
      o[0] as api.GoogleCloudVisionV1p2beta1EntityAnnotation);
  checkGoogleCloudVisionV1p2beta1EntityAnnotation(
      o[1] as api.GoogleCloudVisionV1p2beta1EntityAnnotation);
}

core.List<api.GoogleCloudVisionV1p2beta1EntityAnnotation> buildUnnamed6302() {
  var o = <api.GoogleCloudVisionV1p2beta1EntityAnnotation>[];
  o.add(buildGoogleCloudVisionV1p2beta1EntityAnnotation());
  o.add(buildGoogleCloudVisionV1p2beta1EntityAnnotation());
  return o;
}

void checkUnnamed6302(
    core.List<api.GoogleCloudVisionV1p2beta1EntityAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1EntityAnnotation(
      o[0] as api.GoogleCloudVisionV1p2beta1EntityAnnotation);
  checkGoogleCloudVisionV1p2beta1EntityAnnotation(
      o[1] as api.GoogleCloudVisionV1p2beta1EntityAnnotation);
}

core.List<api.GoogleCloudVisionV1p2beta1LocalizedObjectAnnotation>
    buildUnnamed6303() {
  var o = <api.GoogleCloudVisionV1p2beta1LocalizedObjectAnnotation>[];
  o.add(buildGoogleCloudVisionV1p2beta1LocalizedObjectAnnotation());
  o.add(buildGoogleCloudVisionV1p2beta1LocalizedObjectAnnotation());
  return o;
}

void checkUnnamed6303(
    core.List<api.GoogleCloudVisionV1p2beta1LocalizedObjectAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1LocalizedObjectAnnotation(
      o[0] as api.GoogleCloudVisionV1p2beta1LocalizedObjectAnnotation);
  checkGoogleCloudVisionV1p2beta1LocalizedObjectAnnotation(
      o[1] as api.GoogleCloudVisionV1p2beta1LocalizedObjectAnnotation);
}

core.List<api.GoogleCloudVisionV1p2beta1EntityAnnotation> buildUnnamed6304() {
  var o = <api.GoogleCloudVisionV1p2beta1EntityAnnotation>[];
  o.add(buildGoogleCloudVisionV1p2beta1EntityAnnotation());
  o.add(buildGoogleCloudVisionV1p2beta1EntityAnnotation());
  return o;
}

void checkUnnamed6304(
    core.List<api.GoogleCloudVisionV1p2beta1EntityAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1EntityAnnotation(
      o[0] as api.GoogleCloudVisionV1p2beta1EntityAnnotation);
  checkGoogleCloudVisionV1p2beta1EntityAnnotation(
      o[1] as api.GoogleCloudVisionV1p2beta1EntityAnnotation);
}

core.List<api.GoogleCloudVisionV1p2beta1EntityAnnotation> buildUnnamed6305() {
  var o = <api.GoogleCloudVisionV1p2beta1EntityAnnotation>[];
  o.add(buildGoogleCloudVisionV1p2beta1EntityAnnotation());
  o.add(buildGoogleCloudVisionV1p2beta1EntityAnnotation());
  return o;
}

void checkUnnamed6305(
    core.List<api.GoogleCloudVisionV1p2beta1EntityAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1EntityAnnotation(
      o[0] as api.GoogleCloudVisionV1p2beta1EntityAnnotation);
  checkGoogleCloudVisionV1p2beta1EntityAnnotation(
      o[1] as api.GoogleCloudVisionV1p2beta1EntityAnnotation);
}

core.int buildCounterGoogleCloudVisionV1p2beta1AnnotateImageResponse = 0;
api.GoogleCloudVisionV1p2beta1AnnotateImageResponse
    buildGoogleCloudVisionV1p2beta1AnnotateImageResponse() {
  var o = api.GoogleCloudVisionV1p2beta1AnnotateImageResponse();
  buildCounterGoogleCloudVisionV1p2beta1AnnotateImageResponse++;
  if (buildCounterGoogleCloudVisionV1p2beta1AnnotateImageResponse < 3) {
    o.context = buildGoogleCloudVisionV1p2beta1ImageAnnotationContext();
    o.cropHintsAnnotation =
        buildGoogleCloudVisionV1p2beta1CropHintsAnnotation();
    o.error = buildStatus();
    o.faceAnnotations = buildUnnamed6300();
    o.fullTextAnnotation = buildGoogleCloudVisionV1p2beta1TextAnnotation();
    o.imagePropertiesAnnotation =
        buildGoogleCloudVisionV1p2beta1ImageProperties();
    o.labelAnnotations = buildUnnamed6301();
    o.landmarkAnnotations = buildUnnamed6302();
    o.localizedObjectAnnotations = buildUnnamed6303();
    o.logoAnnotations = buildUnnamed6304();
    o.productSearchResults =
        buildGoogleCloudVisionV1p2beta1ProductSearchResults();
    o.safeSearchAnnotation =
        buildGoogleCloudVisionV1p2beta1SafeSearchAnnotation();
    o.textAnnotations = buildUnnamed6305();
    o.webDetection = buildGoogleCloudVisionV1p2beta1WebDetection();
  }
  buildCounterGoogleCloudVisionV1p2beta1AnnotateImageResponse--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1AnnotateImageResponse(
    api.GoogleCloudVisionV1p2beta1AnnotateImageResponse o) {
  buildCounterGoogleCloudVisionV1p2beta1AnnotateImageResponse++;
  if (buildCounterGoogleCloudVisionV1p2beta1AnnotateImageResponse < 3) {
    checkGoogleCloudVisionV1p2beta1ImageAnnotationContext(
        o.context! as api.GoogleCloudVisionV1p2beta1ImageAnnotationContext);
    checkGoogleCloudVisionV1p2beta1CropHintsAnnotation(o.cropHintsAnnotation!
        as api.GoogleCloudVisionV1p2beta1CropHintsAnnotation);
    checkStatus(o.error! as api.Status);
    checkUnnamed6300(o.faceAnnotations!);
    checkGoogleCloudVisionV1p2beta1TextAnnotation(
        o.fullTextAnnotation! as api.GoogleCloudVisionV1p2beta1TextAnnotation);
    checkGoogleCloudVisionV1p2beta1ImageProperties(o.imagePropertiesAnnotation!
        as api.GoogleCloudVisionV1p2beta1ImageProperties);
    checkUnnamed6301(o.labelAnnotations!);
    checkUnnamed6302(o.landmarkAnnotations!);
    checkUnnamed6303(o.localizedObjectAnnotations!);
    checkUnnamed6304(o.logoAnnotations!);
    checkGoogleCloudVisionV1p2beta1ProductSearchResults(o.productSearchResults!
        as api.GoogleCloudVisionV1p2beta1ProductSearchResults);
    checkGoogleCloudVisionV1p2beta1SafeSearchAnnotation(o.safeSearchAnnotation!
        as api.GoogleCloudVisionV1p2beta1SafeSearchAnnotation);
    checkUnnamed6305(o.textAnnotations!);
    checkGoogleCloudVisionV1p2beta1WebDetection(
        o.webDetection! as api.GoogleCloudVisionV1p2beta1WebDetection);
  }
  buildCounterGoogleCloudVisionV1p2beta1AnnotateImageResponse--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse = 0;
api.GoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse
    buildGoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse() {
  var o = api.GoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse();
  buildCounterGoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse++;
  if (buildCounterGoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse < 3) {
    o.outputConfig = buildGoogleCloudVisionV1p2beta1OutputConfig();
  }
  buildCounterGoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse(
    api.GoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse o) {
  buildCounterGoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse++;
  if (buildCounterGoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse < 3) {
    checkGoogleCloudVisionV1p2beta1OutputConfig(
        o.outputConfig! as api.GoogleCloudVisionV1p2beta1OutputConfig);
  }
  buildCounterGoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse--;
}

core.List<api.GoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse>
    buildUnnamed6306() {
  var o = <api.GoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse>[];
  o.add(buildGoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse());
  o.add(buildGoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse());
  return o;
}

void checkUnnamed6306(
    core.List<api.GoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse(
      o[0] as api.GoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse);
  checkGoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse(
      o[1] as api.GoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse);
}

core.int buildCounterGoogleCloudVisionV1p2beta1AsyncBatchAnnotateFilesResponse =
    0;
api.GoogleCloudVisionV1p2beta1AsyncBatchAnnotateFilesResponse
    buildGoogleCloudVisionV1p2beta1AsyncBatchAnnotateFilesResponse() {
  var o = api.GoogleCloudVisionV1p2beta1AsyncBatchAnnotateFilesResponse();
  buildCounterGoogleCloudVisionV1p2beta1AsyncBatchAnnotateFilesResponse++;
  if (buildCounterGoogleCloudVisionV1p2beta1AsyncBatchAnnotateFilesResponse <
      3) {
    o.responses = buildUnnamed6306();
  }
  buildCounterGoogleCloudVisionV1p2beta1AsyncBatchAnnotateFilesResponse--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1AsyncBatchAnnotateFilesResponse(
    api.GoogleCloudVisionV1p2beta1AsyncBatchAnnotateFilesResponse o) {
  buildCounterGoogleCloudVisionV1p2beta1AsyncBatchAnnotateFilesResponse++;
  if (buildCounterGoogleCloudVisionV1p2beta1AsyncBatchAnnotateFilesResponse <
      3) {
    checkUnnamed6306(o.responses!);
  }
  buildCounterGoogleCloudVisionV1p2beta1AsyncBatchAnnotateFilesResponse--;
}

core.List<api.GoogleCloudVisionV1p2beta1Paragraph> buildUnnamed6307() {
  var o = <api.GoogleCloudVisionV1p2beta1Paragraph>[];
  o.add(buildGoogleCloudVisionV1p2beta1Paragraph());
  o.add(buildGoogleCloudVisionV1p2beta1Paragraph());
  return o;
}

void checkUnnamed6307(core.List<api.GoogleCloudVisionV1p2beta1Paragraph> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1Paragraph(
      o[0] as api.GoogleCloudVisionV1p2beta1Paragraph);
  checkGoogleCloudVisionV1p2beta1Paragraph(
      o[1] as api.GoogleCloudVisionV1p2beta1Paragraph);
}

core.int buildCounterGoogleCloudVisionV1p2beta1Block = 0;
api.GoogleCloudVisionV1p2beta1Block buildGoogleCloudVisionV1p2beta1Block() {
  var o = api.GoogleCloudVisionV1p2beta1Block();
  buildCounterGoogleCloudVisionV1p2beta1Block++;
  if (buildCounterGoogleCloudVisionV1p2beta1Block < 3) {
    o.blockType = 'foo';
    o.boundingBox = buildGoogleCloudVisionV1p2beta1BoundingPoly();
    o.confidence = 42.0;
    o.paragraphs = buildUnnamed6307();
    o.property = buildGoogleCloudVisionV1p2beta1TextAnnotationTextProperty();
  }
  buildCounterGoogleCloudVisionV1p2beta1Block--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1Block(
    api.GoogleCloudVisionV1p2beta1Block o) {
  buildCounterGoogleCloudVisionV1p2beta1Block++;
  if (buildCounterGoogleCloudVisionV1p2beta1Block < 3) {
    unittest.expect(
      o.blockType!,
      unittest.equals('foo'),
    );
    checkGoogleCloudVisionV1p2beta1BoundingPoly(
        o.boundingBox! as api.GoogleCloudVisionV1p2beta1BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkUnnamed6307(o.paragraphs!);
    checkGoogleCloudVisionV1p2beta1TextAnnotationTextProperty(o.property!
        as api.GoogleCloudVisionV1p2beta1TextAnnotationTextProperty);
  }
  buildCounterGoogleCloudVisionV1p2beta1Block--;
}

core.List<api.GoogleCloudVisionV1p2beta1NormalizedVertex> buildUnnamed6308() {
  var o = <api.GoogleCloudVisionV1p2beta1NormalizedVertex>[];
  o.add(buildGoogleCloudVisionV1p2beta1NormalizedVertex());
  o.add(buildGoogleCloudVisionV1p2beta1NormalizedVertex());
  return o;
}

void checkUnnamed6308(
    core.List<api.GoogleCloudVisionV1p2beta1NormalizedVertex> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1NormalizedVertex(
      o[0] as api.GoogleCloudVisionV1p2beta1NormalizedVertex);
  checkGoogleCloudVisionV1p2beta1NormalizedVertex(
      o[1] as api.GoogleCloudVisionV1p2beta1NormalizedVertex);
}

core.List<api.GoogleCloudVisionV1p2beta1Vertex> buildUnnamed6309() {
  var o = <api.GoogleCloudVisionV1p2beta1Vertex>[];
  o.add(buildGoogleCloudVisionV1p2beta1Vertex());
  o.add(buildGoogleCloudVisionV1p2beta1Vertex());
  return o;
}

void checkUnnamed6309(core.List<api.GoogleCloudVisionV1p2beta1Vertex> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1Vertex(
      o[0] as api.GoogleCloudVisionV1p2beta1Vertex);
  checkGoogleCloudVisionV1p2beta1Vertex(
      o[1] as api.GoogleCloudVisionV1p2beta1Vertex);
}

core.int buildCounterGoogleCloudVisionV1p2beta1BoundingPoly = 0;
api.GoogleCloudVisionV1p2beta1BoundingPoly
    buildGoogleCloudVisionV1p2beta1BoundingPoly() {
  var o = api.GoogleCloudVisionV1p2beta1BoundingPoly();
  buildCounterGoogleCloudVisionV1p2beta1BoundingPoly++;
  if (buildCounterGoogleCloudVisionV1p2beta1BoundingPoly < 3) {
    o.normalizedVertices = buildUnnamed6308();
    o.vertices = buildUnnamed6309();
  }
  buildCounterGoogleCloudVisionV1p2beta1BoundingPoly--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1BoundingPoly(
    api.GoogleCloudVisionV1p2beta1BoundingPoly o) {
  buildCounterGoogleCloudVisionV1p2beta1BoundingPoly++;
  if (buildCounterGoogleCloudVisionV1p2beta1BoundingPoly < 3) {
    checkUnnamed6308(o.normalizedVertices!);
    checkUnnamed6309(o.vertices!);
  }
  buildCounterGoogleCloudVisionV1p2beta1BoundingPoly--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1ColorInfo = 0;
api.GoogleCloudVisionV1p2beta1ColorInfo
    buildGoogleCloudVisionV1p2beta1ColorInfo() {
  var o = api.GoogleCloudVisionV1p2beta1ColorInfo();
  buildCounterGoogleCloudVisionV1p2beta1ColorInfo++;
  if (buildCounterGoogleCloudVisionV1p2beta1ColorInfo < 3) {
    o.color = buildColor();
    o.pixelFraction = 42.0;
    o.score = 42.0;
  }
  buildCounterGoogleCloudVisionV1p2beta1ColorInfo--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1ColorInfo(
    api.GoogleCloudVisionV1p2beta1ColorInfo o) {
  buildCounterGoogleCloudVisionV1p2beta1ColorInfo++;
  if (buildCounterGoogleCloudVisionV1p2beta1ColorInfo < 3) {
    checkColor(o.color! as api.Color);
    unittest.expect(
      o.pixelFraction!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1ColorInfo--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1CropHint = 0;
api.GoogleCloudVisionV1p2beta1CropHint
    buildGoogleCloudVisionV1p2beta1CropHint() {
  var o = api.GoogleCloudVisionV1p2beta1CropHint();
  buildCounterGoogleCloudVisionV1p2beta1CropHint++;
  if (buildCounterGoogleCloudVisionV1p2beta1CropHint < 3) {
    o.boundingPoly = buildGoogleCloudVisionV1p2beta1BoundingPoly();
    o.confidence = 42.0;
    o.importanceFraction = 42.0;
  }
  buildCounterGoogleCloudVisionV1p2beta1CropHint--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1CropHint(
    api.GoogleCloudVisionV1p2beta1CropHint o) {
  buildCounterGoogleCloudVisionV1p2beta1CropHint++;
  if (buildCounterGoogleCloudVisionV1p2beta1CropHint < 3) {
    checkGoogleCloudVisionV1p2beta1BoundingPoly(
        o.boundingPoly! as api.GoogleCloudVisionV1p2beta1BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.importanceFraction!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1CropHint--;
}

core.List<api.GoogleCloudVisionV1p2beta1CropHint> buildUnnamed6310() {
  var o = <api.GoogleCloudVisionV1p2beta1CropHint>[];
  o.add(buildGoogleCloudVisionV1p2beta1CropHint());
  o.add(buildGoogleCloudVisionV1p2beta1CropHint());
  return o;
}

void checkUnnamed6310(core.List<api.GoogleCloudVisionV1p2beta1CropHint> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1CropHint(
      o[0] as api.GoogleCloudVisionV1p2beta1CropHint);
  checkGoogleCloudVisionV1p2beta1CropHint(
      o[1] as api.GoogleCloudVisionV1p2beta1CropHint);
}

core.int buildCounterGoogleCloudVisionV1p2beta1CropHintsAnnotation = 0;
api.GoogleCloudVisionV1p2beta1CropHintsAnnotation
    buildGoogleCloudVisionV1p2beta1CropHintsAnnotation() {
  var o = api.GoogleCloudVisionV1p2beta1CropHintsAnnotation();
  buildCounterGoogleCloudVisionV1p2beta1CropHintsAnnotation++;
  if (buildCounterGoogleCloudVisionV1p2beta1CropHintsAnnotation < 3) {
    o.cropHints = buildUnnamed6310();
  }
  buildCounterGoogleCloudVisionV1p2beta1CropHintsAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1CropHintsAnnotation(
    api.GoogleCloudVisionV1p2beta1CropHintsAnnotation o) {
  buildCounterGoogleCloudVisionV1p2beta1CropHintsAnnotation++;
  if (buildCounterGoogleCloudVisionV1p2beta1CropHintsAnnotation < 3) {
    checkUnnamed6310(o.cropHints!);
  }
  buildCounterGoogleCloudVisionV1p2beta1CropHintsAnnotation--;
}

core.List<api.GoogleCloudVisionV1p2beta1ColorInfo> buildUnnamed6311() {
  var o = <api.GoogleCloudVisionV1p2beta1ColorInfo>[];
  o.add(buildGoogleCloudVisionV1p2beta1ColorInfo());
  o.add(buildGoogleCloudVisionV1p2beta1ColorInfo());
  return o;
}

void checkUnnamed6311(core.List<api.GoogleCloudVisionV1p2beta1ColorInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1ColorInfo(
      o[0] as api.GoogleCloudVisionV1p2beta1ColorInfo);
  checkGoogleCloudVisionV1p2beta1ColorInfo(
      o[1] as api.GoogleCloudVisionV1p2beta1ColorInfo);
}

core.int buildCounterGoogleCloudVisionV1p2beta1DominantColorsAnnotation = 0;
api.GoogleCloudVisionV1p2beta1DominantColorsAnnotation
    buildGoogleCloudVisionV1p2beta1DominantColorsAnnotation() {
  var o = api.GoogleCloudVisionV1p2beta1DominantColorsAnnotation();
  buildCounterGoogleCloudVisionV1p2beta1DominantColorsAnnotation++;
  if (buildCounterGoogleCloudVisionV1p2beta1DominantColorsAnnotation < 3) {
    o.colors = buildUnnamed6311();
  }
  buildCounterGoogleCloudVisionV1p2beta1DominantColorsAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1DominantColorsAnnotation(
    api.GoogleCloudVisionV1p2beta1DominantColorsAnnotation o) {
  buildCounterGoogleCloudVisionV1p2beta1DominantColorsAnnotation++;
  if (buildCounterGoogleCloudVisionV1p2beta1DominantColorsAnnotation < 3) {
    checkUnnamed6311(o.colors!);
  }
  buildCounterGoogleCloudVisionV1p2beta1DominantColorsAnnotation--;
}

core.List<api.GoogleCloudVisionV1p2beta1LocationInfo> buildUnnamed6312() {
  var o = <api.GoogleCloudVisionV1p2beta1LocationInfo>[];
  o.add(buildGoogleCloudVisionV1p2beta1LocationInfo());
  o.add(buildGoogleCloudVisionV1p2beta1LocationInfo());
  return o;
}

void checkUnnamed6312(core.List<api.GoogleCloudVisionV1p2beta1LocationInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1LocationInfo(
      o[0] as api.GoogleCloudVisionV1p2beta1LocationInfo);
  checkGoogleCloudVisionV1p2beta1LocationInfo(
      o[1] as api.GoogleCloudVisionV1p2beta1LocationInfo);
}

core.List<api.GoogleCloudVisionV1p2beta1Property> buildUnnamed6313() {
  var o = <api.GoogleCloudVisionV1p2beta1Property>[];
  o.add(buildGoogleCloudVisionV1p2beta1Property());
  o.add(buildGoogleCloudVisionV1p2beta1Property());
  return o;
}

void checkUnnamed6313(core.List<api.GoogleCloudVisionV1p2beta1Property> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1Property(
      o[0] as api.GoogleCloudVisionV1p2beta1Property);
  checkGoogleCloudVisionV1p2beta1Property(
      o[1] as api.GoogleCloudVisionV1p2beta1Property);
}

core.int buildCounterGoogleCloudVisionV1p2beta1EntityAnnotation = 0;
api.GoogleCloudVisionV1p2beta1EntityAnnotation
    buildGoogleCloudVisionV1p2beta1EntityAnnotation() {
  var o = api.GoogleCloudVisionV1p2beta1EntityAnnotation();
  buildCounterGoogleCloudVisionV1p2beta1EntityAnnotation++;
  if (buildCounterGoogleCloudVisionV1p2beta1EntityAnnotation < 3) {
    o.boundingPoly = buildGoogleCloudVisionV1p2beta1BoundingPoly();
    o.confidence = 42.0;
    o.description = 'foo';
    o.locale = 'foo';
    o.locations = buildUnnamed6312();
    o.mid = 'foo';
    o.properties = buildUnnamed6313();
    o.score = 42.0;
    o.topicality = 42.0;
  }
  buildCounterGoogleCloudVisionV1p2beta1EntityAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1EntityAnnotation(
    api.GoogleCloudVisionV1p2beta1EntityAnnotation o) {
  buildCounterGoogleCloudVisionV1p2beta1EntityAnnotation++;
  if (buildCounterGoogleCloudVisionV1p2beta1EntityAnnotation < 3) {
    checkGoogleCloudVisionV1p2beta1BoundingPoly(
        o.boundingPoly! as api.GoogleCloudVisionV1p2beta1BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.locale!,
      unittest.equals('foo'),
    );
    checkUnnamed6312(o.locations!);
    unittest.expect(
      o.mid!,
      unittest.equals('foo'),
    );
    checkUnnamed6313(o.properties!);
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.topicality!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1EntityAnnotation--;
}

core.List<api.GoogleCloudVisionV1p2beta1FaceAnnotationLandmark>
    buildUnnamed6314() {
  var o = <api.GoogleCloudVisionV1p2beta1FaceAnnotationLandmark>[];
  o.add(buildGoogleCloudVisionV1p2beta1FaceAnnotationLandmark());
  o.add(buildGoogleCloudVisionV1p2beta1FaceAnnotationLandmark());
  return o;
}

void checkUnnamed6314(
    core.List<api.GoogleCloudVisionV1p2beta1FaceAnnotationLandmark> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1FaceAnnotationLandmark(
      o[0] as api.GoogleCloudVisionV1p2beta1FaceAnnotationLandmark);
  checkGoogleCloudVisionV1p2beta1FaceAnnotationLandmark(
      o[1] as api.GoogleCloudVisionV1p2beta1FaceAnnotationLandmark);
}

core.int buildCounterGoogleCloudVisionV1p2beta1FaceAnnotation = 0;
api.GoogleCloudVisionV1p2beta1FaceAnnotation
    buildGoogleCloudVisionV1p2beta1FaceAnnotation() {
  var o = api.GoogleCloudVisionV1p2beta1FaceAnnotation();
  buildCounterGoogleCloudVisionV1p2beta1FaceAnnotation++;
  if (buildCounterGoogleCloudVisionV1p2beta1FaceAnnotation < 3) {
    o.angerLikelihood = 'foo';
    o.blurredLikelihood = 'foo';
    o.boundingPoly = buildGoogleCloudVisionV1p2beta1BoundingPoly();
    o.detectionConfidence = 42.0;
    o.fdBoundingPoly = buildGoogleCloudVisionV1p2beta1BoundingPoly();
    o.headwearLikelihood = 'foo';
    o.joyLikelihood = 'foo';
    o.landmarkingConfidence = 42.0;
    o.landmarks = buildUnnamed6314();
    o.panAngle = 42.0;
    o.rollAngle = 42.0;
    o.sorrowLikelihood = 'foo';
    o.surpriseLikelihood = 'foo';
    o.tiltAngle = 42.0;
    o.underExposedLikelihood = 'foo';
  }
  buildCounterGoogleCloudVisionV1p2beta1FaceAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1FaceAnnotation(
    api.GoogleCloudVisionV1p2beta1FaceAnnotation o) {
  buildCounterGoogleCloudVisionV1p2beta1FaceAnnotation++;
  if (buildCounterGoogleCloudVisionV1p2beta1FaceAnnotation < 3) {
    unittest.expect(
      o.angerLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.blurredLikelihood!,
      unittest.equals('foo'),
    );
    checkGoogleCloudVisionV1p2beta1BoundingPoly(
        o.boundingPoly! as api.GoogleCloudVisionV1p2beta1BoundingPoly);
    unittest.expect(
      o.detectionConfidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVisionV1p2beta1BoundingPoly(
        o.fdBoundingPoly! as api.GoogleCloudVisionV1p2beta1BoundingPoly);
    unittest.expect(
      o.headwearLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.joyLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.landmarkingConfidence!,
      unittest.equals(42.0),
    );
    checkUnnamed6314(o.landmarks!);
    unittest.expect(
      o.panAngle!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.rollAngle!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.sorrowLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.surpriseLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.tiltAngle!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.underExposedLikelihood!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1FaceAnnotation--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1FaceAnnotationLandmark = 0;
api.GoogleCloudVisionV1p2beta1FaceAnnotationLandmark
    buildGoogleCloudVisionV1p2beta1FaceAnnotationLandmark() {
  var o = api.GoogleCloudVisionV1p2beta1FaceAnnotationLandmark();
  buildCounterGoogleCloudVisionV1p2beta1FaceAnnotationLandmark++;
  if (buildCounterGoogleCloudVisionV1p2beta1FaceAnnotationLandmark < 3) {
    o.position = buildGoogleCloudVisionV1p2beta1Position();
    o.type = 'foo';
  }
  buildCounterGoogleCloudVisionV1p2beta1FaceAnnotationLandmark--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1FaceAnnotationLandmark(
    api.GoogleCloudVisionV1p2beta1FaceAnnotationLandmark o) {
  buildCounterGoogleCloudVisionV1p2beta1FaceAnnotationLandmark++;
  if (buildCounterGoogleCloudVisionV1p2beta1FaceAnnotationLandmark < 3) {
    checkGoogleCloudVisionV1p2beta1Position(
        o.position! as api.GoogleCloudVisionV1p2beta1Position);
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1FaceAnnotationLandmark--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1GcsDestination = 0;
api.GoogleCloudVisionV1p2beta1GcsDestination
    buildGoogleCloudVisionV1p2beta1GcsDestination() {
  var o = api.GoogleCloudVisionV1p2beta1GcsDestination();
  buildCounterGoogleCloudVisionV1p2beta1GcsDestination++;
  if (buildCounterGoogleCloudVisionV1p2beta1GcsDestination < 3) {
    o.uri = 'foo';
  }
  buildCounterGoogleCloudVisionV1p2beta1GcsDestination--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1GcsDestination(
    api.GoogleCloudVisionV1p2beta1GcsDestination o) {
  buildCounterGoogleCloudVisionV1p2beta1GcsDestination++;
  if (buildCounterGoogleCloudVisionV1p2beta1GcsDestination < 3) {
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1GcsDestination--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1GcsSource = 0;
api.GoogleCloudVisionV1p2beta1GcsSource
    buildGoogleCloudVisionV1p2beta1GcsSource() {
  var o = api.GoogleCloudVisionV1p2beta1GcsSource();
  buildCounterGoogleCloudVisionV1p2beta1GcsSource++;
  if (buildCounterGoogleCloudVisionV1p2beta1GcsSource < 3) {
    o.uri = 'foo';
  }
  buildCounterGoogleCloudVisionV1p2beta1GcsSource--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1GcsSource(
    api.GoogleCloudVisionV1p2beta1GcsSource o) {
  buildCounterGoogleCloudVisionV1p2beta1GcsSource++;
  if (buildCounterGoogleCloudVisionV1p2beta1GcsSource < 3) {
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1GcsSource--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1ImageAnnotationContext = 0;
api.GoogleCloudVisionV1p2beta1ImageAnnotationContext
    buildGoogleCloudVisionV1p2beta1ImageAnnotationContext() {
  var o = api.GoogleCloudVisionV1p2beta1ImageAnnotationContext();
  buildCounterGoogleCloudVisionV1p2beta1ImageAnnotationContext++;
  if (buildCounterGoogleCloudVisionV1p2beta1ImageAnnotationContext < 3) {
    o.pageNumber = 42;
    o.uri = 'foo';
  }
  buildCounterGoogleCloudVisionV1p2beta1ImageAnnotationContext--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1ImageAnnotationContext(
    api.GoogleCloudVisionV1p2beta1ImageAnnotationContext o) {
  buildCounterGoogleCloudVisionV1p2beta1ImageAnnotationContext++;
  if (buildCounterGoogleCloudVisionV1p2beta1ImageAnnotationContext < 3) {
    unittest.expect(
      o.pageNumber!,
      unittest.equals(42),
    );
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1ImageAnnotationContext--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1ImageProperties = 0;
api.GoogleCloudVisionV1p2beta1ImageProperties
    buildGoogleCloudVisionV1p2beta1ImageProperties() {
  var o = api.GoogleCloudVisionV1p2beta1ImageProperties();
  buildCounterGoogleCloudVisionV1p2beta1ImageProperties++;
  if (buildCounterGoogleCloudVisionV1p2beta1ImageProperties < 3) {
    o.dominantColors =
        buildGoogleCloudVisionV1p2beta1DominantColorsAnnotation();
  }
  buildCounterGoogleCloudVisionV1p2beta1ImageProperties--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1ImageProperties(
    api.GoogleCloudVisionV1p2beta1ImageProperties o) {
  buildCounterGoogleCloudVisionV1p2beta1ImageProperties++;
  if (buildCounterGoogleCloudVisionV1p2beta1ImageProperties < 3) {
    checkGoogleCloudVisionV1p2beta1DominantColorsAnnotation(o.dominantColors!
        as api.GoogleCloudVisionV1p2beta1DominantColorsAnnotation);
  }
  buildCounterGoogleCloudVisionV1p2beta1ImageProperties--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1InputConfig = 0;
api.GoogleCloudVisionV1p2beta1InputConfig
    buildGoogleCloudVisionV1p2beta1InputConfig() {
  var o = api.GoogleCloudVisionV1p2beta1InputConfig();
  buildCounterGoogleCloudVisionV1p2beta1InputConfig++;
  if (buildCounterGoogleCloudVisionV1p2beta1InputConfig < 3) {
    o.content = 'foo';
    o.gcsSource = buildGoogleCloudVisionV1p2beta1GcsSource();
    o.mimeType = 'foo';
  }
  buildCounterGoogleCloudVisionV1p2beta1InputConfig--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1InputConfig(
    api.GoogleCloudVisionV1p2beta1InputConfig o) {
  buildCounterGoogleCloudVisionV1p2beta1InputConfig++;
  if (buildCounterGoogleCloudVisionV1p2beta1InputConfig < 3) {
    unittest.expect(
      o.content!,
      unittest.equals('foo'),
    );
    checkGoogleCloudVisionV1p2beta1GcsSource(
        o.gcsSource! as api.GoogleCloudVisionV1p2beta1GcsSource);
    unittest.expect(
      o.mimeType!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1InputConfig--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1LocalizedObjectAnnotation = 0;
api.GoogleCloudVisionV1p2beta1LocalizedObjectAnnotation
    buildGoogleCloudVisionV1p2beta1LocalizedObjectAnnotation() {
  var o = api.GoogleCloudVisionV1p2beta1LocalizedObjectAnnotation();
  buildCounterGoogleCloudVisionV1p2beta1LocalizedObjectAnnotation++;
  if (buildCounterGoogleCloudVisionV1p2beta1LocalizedObjectAnnotation < 3) {
    o.boundingPoly = buildGoogleCloudVisionV1p2beta1BoundingPoly();
    o.languageCode = 'foo';
    o.mid = 'foo';
    o.name = 'foo';
    o.score = 42.0;
  }
  buildCounterGoogleCloudVisionV1p2beta1LocalizedObjectAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1LocalizedObjectAnnotation(
    api.GoogleCloudVisionV1p2beta1LocalizedObjectAnnotation o) {
  buildCounterGoogleCloudVisionV1p2beta1LocalizedObjectAnnotation++;
  if (buildCounterGoogleCloudVisionV1p2beta1LocalizedObjectAnnotation < 3) {
    checkGoogleCloudVisionV1p2beta1BoundingPoly(
        o.boundingPoly! as api.GoogleCloudVisionV1p2beta1BoundingPoly);
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.mid!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1LocalizedObjectAnnotation--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1LocationInfo = 0;
api.GoogleCloudVisionV1p2beta1LocationInfo
    buildGoogleCloudVisionV1p2beta1LocationInfo() {
  var o = api.GoogleCloudVisionV1p2beta1LocationInfo();
  buildCounterGoogleCloudVisionV1p2beta1LocationInfo++;
  if (buildCounterGoogleCloudVisionV1p2beta1LocationInfo < 3) {
    o.latLng = buildLatLng();
  }
  buildCounterGoogleCloudVisionV1p2beta1LocationInfo--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1LocationInfo(
    api.GoogleCloudVisionV1p2beta1LocationInfo o) {
  buildCounterGoogleCloudVisionV1p2beta1LocationInfo++;
  if (buildCounterGoogleCloudVisionV1p2beta1LocationInfo < 3) {
    checkLatLng(o.latLng! as api.LatLng);
  }
  buildCounterGoogleCloudVisionV1p2beta1LocationInfo--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1NormalizedVertex = 0;
api.GoogleCloudVisionV1p2beta1NormalizedVertex
    buildGoogleCloudVisionV1p2beta1NormalizedVertex() {
  var o = api.GoogleCloudVisionV1p2beta1NormalizedVertex();
  buildCounterGoogleCloudVisionV1p2beta1NormalizedVertex++;
  if (buildCounterGoogleCloudVisionV1p2beta1NormalizedVertex < 3) {
    o.x = 42.0;
    o.y = 42.0;
  }
  buildCounterGoogleCloudVisionV1p2beta1NormalizedVertex--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1NormalizedVertex(
    api.GoogleCloudVisionV1p2beta1NormalizedVertex o) {
  buildCounterGoogleCloudVisionV1p2beta1NormalizedVertex++;
  if (buildCounterGoogleCloudVisionV1p2beta1NormalizedVertex < 3) {
    unittest.expect(
      o.x!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.y!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1NormalizedVertex--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1OperationMetadata = 0;
api.GoogleCloudVisionV1p2beta1OperationMetadata
    buildGoogleCloudVisionV1p2beta1OperationMetadata() {
  var o = api.GoogleCloudVisionV1p2beta1OperationMetadata();
  buildCounterGoogleCloudVisionV1p2beta1OperationMetadata++;
  if (buildCounterGoogleCloudVisionV1p2beta1OperationMetadata < 3) {
    o.createTime = 'foo';
    o.state = 'foo';
    o.updateTime = 'foo';
  }
  buildCounterGoogleCloudVisionV1p2beta1OperationMetadata--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1OperationMetadata(
    api.GoogleCloudVisionV1p2beta1OperationMetadata o) {
  buildCounterGoogleCloudVisionV1p2beta1OperationMetadata++;
  if (buildCounterGoogleCloudVisionV1p2beta1OperationMetadata < 3) {
    unittest.expect(
      o.createTime!,
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
  buildCounterGoogleCloudVisionV1p2beta1OperationMetadata--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1OutputConfig = 0;
api.GoogleCloudVisionV1p2beta1OutputConfig
    buildGoogleCloudVisionV1p2beta1OutputConfig() {
  var o = api.GoogleCloudVisionV1p2beta1OutputConfig();
  buildCounterGoogleCloudVisionV1p2beta1OutputConfig++;
  if (buildCounterGoogleCloudVisionV1p2beta1OutputConfig < 3) {
    o.batchSize = 42;
    o.gcsDestination = buildGoogleCloudVisionV1p2beta1GcsDestination();
  }
  buildCounterGoogleCloudVisionV1p2beta1OutputConfig--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1OutputConfig(
    api.GoogleCloudVisionV1p2beta1OutputConfig o) {
  buildCounterGoogleCloudVisionV1p2beta1OutputConfig++;
  if (buildCounterGoogleCloudVisionV1p2beta1OutputConfig < 3) {
    unittest.expect(
      o.batchSize!,
      unittest.equals(42),
    );
    checkGoogleCloudVisionV1p2beta1GcsDestination(
        o.gcsDestination! as api.GoogleCloudVisionV1p2beta1GcsDestination);
  }
  buildCounterGoogleCloudVisionV1p2beta1OutputConfig--;
}

core.List<api.GoogleCloudVisionV1p2beta1Block> buildUnnamed6315() {
  var o = <api.GoogleCloudVisionV1p2beta1Block>[];
  o.add(buildGoogleCloudVisionV1p2beta1Block());
  o.add(buildGoogleCloudVisionV1p2beta1Block());
  return o;
}

void checkUnnamed6315(core.List<api.GoogleCloudVisionV1p2beta1Block> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1Block(
      o[0] as api.GoogleCloudVisionV1p2beta1Block);
  checkGoogleCloudVisionV1p2beta1Block(
      o[1] as api.GoogleCloudVisionV1p2beta1Block);
}

core.int buildCounterGoogleCloudVisionV1p2beta1Page = 0;
api.GoogleCloudVisionV1p2beta1Page buildGoogleCloudVisionV1p2beta1Page() {
  var o = api.GoogleCloudVisionV1p2beta1Page();
  buildCounterGoogleCloudVisionV1p2beta1Page++;
  if (buildCounterGoogleCloudVisionV1p2beta1Page < 3) {
    o.blocks = buildUnnamed6315();
    o.confidence = 42.0;
    o.height = 42;
    o.property = buildGoogleCloudVisionV1p2beta1TextAnnotationTextProperty();
    o.width = 42;
  }
  buildCounterGoogleCloudVisionV1p2beta1Page--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1Page(api.GoogleCloudVisionV1p2beta1Page o) {
  buildCounterGoogleCloudVisionV1p2beta1Page++;
  if (buildCounterGoogleCloudVisionV1p2beta1Page < 3) {
    checkUnnamed6315(o.blocks!);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.height!,
      unittest.equals(42),
    );
    checkGoogleCloudVisionV1p2beta1TextAnnotationTextProperty(o.property!
        as api.GoogleCloudVisionV1p2beta1TextAnnotationTextProperty);
    unittest.expect(
      o.width!,
      unittest.equals(42),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1Page--;
}

core.List<api.GoogleCloudVisionV1p2beta1Word> buildUnnamed6316() {
  var o = <api.GoogleCloudVisionV1p2beta1Word>[];
  o.add(buildGoogleCloudVisionV1p2beta1Word());
  o.add(buildGoogleCloudVisionV1p2beta1Word());
  return o;
}

void checkUnnamed6316(core.List<api.GoogleCloudVisionV1p2beta1Word> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1Word(
      o[0] as api.GoogleCloudVisionV1p2beta1Word);
  checkGoogleCloudVisionV1p2beta1Word(
      o[1] as api.GoogleCloudVisionV1p2beta1Word);
}

core.int buildCounterGoogleCloudVisionV1p2beta1Paragraph = 0;
api.GoogleCloudVisionV1p2beta1Paragraph
    buildGoogleCloudVisionV1p2beta1Paragraph() {
  var o = api.GoogleCloudVisionV1p2beta1Paragraph();
  buildCounterGoogleCloudVisionV1p2beta1Paragraph++;
  if (buildCounterGoogleCloudVisionV1p2beta1Paragraph < 3) {
    o.boundingBox = buildGoogleCloudVisionV1p2beta1BoundingPoly();
    o.confidence = 42.0;
    o.property = buildGoogleCloudVisionV1p2beta1TextAnnotationTextProperty();
    o.words = buildUnnamed6316();
  }
  buildCounterGoogleCloudVisionV1p2beta1Paragraph--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1Paragraph(
    api.GoogleCloudVisionV1p2beta1Paragraph o) {
  buildCounterGoogleCloudVisionV1p2beta1Paragraph++;
  if (buildCounterGoogleCloudVisionV1p2beta1Paragraph < 3) {
    checkGoogleCloudVisionV1p2beta1BoundingPoly(
        o.boundingBox! as api.GoogleCloudVisionV1p2beta1BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVisionV1p2beta1TextAnnotationTextProperty(o.property!
        as api.GoogleCloudVisionV1p2beta1TextAnnotationTextProperty);
    checkUnnamed6316(o.words!);
  }
  buildCounterGoogleCloudVisionV1p2beta1Paragraph--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1Position = 0;
api.GoogleCloudVisionV1p2beta1Position
    buildGoogleCloudVisionV1p2beta1Position() {
  var o = api.GoogleCloudVisionV1p2beta1Position();
  buildCounterGoogleCloudVisionV1p2beta1Position++;
  if (buildCounterGoogleCloudVisionV1p2beta1Position < 3) {
    o.x = 42.0;
    o.y = 42.0;
    o.z = 42.0;
  }
  buildCounterGoogleCloudVisionV1p2beta1Position--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1Position(
    api.GoogleCloudVisionV1p2beta1Position o) {
  buildCounterGoogleCloudVisionV1p2beta1Position++;
  if (buildCounterGoogleCloudVisionV1p2beta1Position < 3) {
    unittest.expect(
      o.x!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.y!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.z!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1Position--;
}

core.List<api.GoogleCloudVisionV1p2beta1ProductKeyValue> buildUnnamed6317() {
  var o = <api.GoogleCloudVisionV1p2beta1ProductKeyValue>[];
  o.add(buildGoogleCloudVisionV1p2beta1ProductKeyValue());
  o.add(buildGoogleCloudVisionV1p2beta1ProductKeyValue());
  return o;
}

void checkUnnamed6317(
    core.List<api.GoogleCloudVisionV1p2beta1ProductKeyValue> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1ProductKeyValue(
      o[0] as api.GoogleCloudVisionV1p2beta1ProductKeyValue);
  checkGoogleCloudVisionV1p2beta1ProductKeyValue(
      o[1] as api.GoogleCloudVisionV1p2beta1ProductKeyValue);
}

core.int buildCounterGoogleCloudVisionV1p2beta1Product = 0;
api.GoogleCloudVisionV1p2beta1Product buildGoogleCloudVisionV1p2beta1Product() {
  var o = api.GoogleCloudVisionV1p2beta1Product();
  buildCounterGoogleCloudVisionV1p2beta1Product++;
  if (buildCounterGoogleCloudVisionV1p2beta1Product < 3) {
    o.description = 'foo';
    o.displayName = 'foo';
    o.name = 'foo';
    o.productCategory = 'foo';
    o.productLabels = buildUnnamed6317();
  }
  buildCounterGoogleCloudVisionV1p2beta1Product--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1Product(
    api.GoogleCloudVisionV1p2beta1Product o) {
  buildCounterGoogleCloudVisionV1p2beta1Product++;
  if (buildCounterGoogleCloudVisionV1p2beta1Product < 3) {
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
      o.productCategory!,
      unittest.equals('foo'),
    );
    checkUnnamed6317(o.productLabels!);
  }
  buildCounterGoogleCloudVisionV1p2beta1Product--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1ProductKeyValue = 0;
api.GoogleCloudVisionV1p2beta1ProductKeyValue
    buildGoogleCloudVisionV1p2beta1ProductKeyValue() {
  var o = api.GoogleCloudVisionV1p2beta1ProductKeyValue();
  buildCounterGoogleCloudVisionV1p2beta1ProductKeyValue++;
  if (buildCounterGoogleCloudVisionV1p2beta1ProductKeyValue < 3) {
    o.key = 'foo';
    o.value = 'foo';
  }
  buildCounterGoogleCloudVisionV1p2beta1ProductKeyValue--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1ProductKeyValue(
    api.GoogleCloudVisionV1p2beta1ProductKeyValue o) {
  buildCounterGoogleCloudVisionV1p2beta1ProductKeyValue++;
  if (buildCounterGoogleCloudVisionV1p2beta1ProductKeyValue < 3) {
    unittest.expect(
      o.key!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1ProductKeyValue--;
}

core.List<api.GoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult>
    buildUnnamed6318() {
  var o = <api.GoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult>[];
  o.add(buildGoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult());
  o.add(buildGoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult());
  return o;
}

void checkUnnamed6318(
    core.List<api.GoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult(
      o[0] as api.GoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult);
  checkGoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult(
      o[1] as api.GoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult);
}

core.List<api.GoogleCloudVisionV1p2beta1ProductSearchResultsResult>
    buildUnnamed6319() {
  var o = <api.GoogleCloudVisionV1p2beta1ProductSearchResultsResult>[];
  o.add(buildGoogleCloudVisionV1p2beta1ProductSearchResultsResult());
  o.add(buildGoogleCloudVisionV1p2beta1ProductSearchResultsResult());
  return o;
}

void checkUnnamed6319(
    core.List<api.GoogleCloudVisionV1p2beta1ProductSearchResultsResult> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1ProductSearchResultsResult(
      o[0] as api.GoogleCloudVisionV1p2beta1ProductSearchResultsResult);
  checkGoogleCloudVisionV1p2beta1ProductSearchResultsResult(
      o[1] as api.GoogleCloudVisionV1p2beta1ProductSearchResultsResult);
}

core.int buildCounterGoogleCloudVisionV1p2beta1ProductSearchResults = 0;
api.GoogleCloudVisionV1p2beta1ProductSearchResults
    buildGoogleCloudVisionV1p2beta1ProductSearchResults() {
  var o = api.GoogleCloudVisionV1p2beta1ProductSearchResults();
  buildCounterGoogleCloudVisionV1p2beta1ProductSearchResults++;
  if (buildCounterGoogleCloudVisionV1p2beta1ProductSearchResults < 3) {
    o.indexTime = 'foo';
    o.productGroupedResults = buildUnnamed6318();
    o.results = buildUnnamed6319();
  }
  buildCounterGoogleCloudVisionV1p2beta1ProductSearchResults--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1ProductSearchResults(
    api.GoogleCloudVisionV1p2beta1ProductSearchResults o) {
  buildCounterGoogleCloudVisionV1p2beta1ProductSearchResults++;
  if (buildCounterGoogleCloudVisionV1p2beta1ProductSearchResults < 3) {
    unittest.expect(
      o.indexTime!,
      unittest.equals('foo'),
    );
    checkUnnamed6318(o.productGroupedResults!);
    checkUnnamed6319(o.results!);
  }
  buildCounterGoogleCloudVisionV1p2beta1ProductSearchResults--;
}

core.List<api.GoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation>
    buildUnnamed6320() {
  var o =
      <api.GoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation>[];
  o.add(buildGoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation());
  o.add(buildGoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation());
  return o;
}

void checkUnnamed6320(
    core.List<
            api.GoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation(o[0]
      as api.GoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation);
  checkGoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation(o[1]
      as api.GoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation);
}

core.List<api.GoogleCloudVisionV1p2beta1ProductSearchResultsResult>
    buildUnnamed6321() {
  var o = <api.GoogleCloudVisionV1p2beta1ProductSearchResultsResult>[];
  o.add(buildGoogleCloudVisionV1p2beta1ProductSearchResultsResult());
  o.add(buildGoogleCloudVisionV1p2beta1ProductSearchResultsResult());
  return o;
}

void checkUnnamed6321(
    core.List<api.GoogleCloudVisionV1p2beta1ProductSearchResultsResult> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1ProductSearchResultsResult(
      o[0] as api.GoogleCloudVisionV1p2beta1ProductSearchResultsResult);
  checkGoogleCloudVisionV1p2beta1ProductSearchResultsResult(
      o[1] as api.GoogleCloudVisionV1p2beta1ProductSearchResultsResult);
}

core.int
    buildCounterGoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult = 0;
api.GoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult
    buildGoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult() {
  var o = api.GoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult();
  buildCounterGoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult++;
  if (buildCounterGoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult <
      3) {
    o.boundingPoly = buildGoogleCloudVisionV1p2beta1BoundingPoly();
    o.objectAnnotations = buildUnnamed6320();
    o.results = buildUnnamed6321();
  }
  buildCounterGoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult(
    api.GoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult o) {
  buildCounterGoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult++;
  if (buildCounterGoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult <
      3) {
    checkGoogleCloudVisionV1p2beta1BoundingPoly(
        o.boundingPoly! as api.GoogleCloudVisionV1p2beta1BoundingPoly);
    checkUnnamed6320(o.objectAnnotations!);
    checkUnnamed6321(o.results!);
  }
  buildCounterGoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult--;
}

core.int
    buildCounterGoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation =
    0;
api.GoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation
    buildGoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation() {
  var o = api.GoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation();
  buildCounterGoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation++;
  if (buildCounterGoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation <
      3) {
    o.languageCode = 'foo';
    o.mid = 'foo';
    o.name = 'foo';
    o.score = 42.0;
  }
  buildCounterGoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation(
    api.GoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation o) {
  buildCounterGoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation++;
  if (buildCounterGoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation <
      3) {
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.mid!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1ProductSearchResultsResult = 0;
api.GoogleCloudVisionV1p2beta1ProductSearchResultsResult
    buildGoogleCloudVisionV1p2beta1ProductSearchResultsResult() {
  var o = api.GoogleCloudVisionV1p2beta1ProductSearchResultsResult();
  buildCounterGoogleCloudVisionV1p2beta1ProductSearchResultsResult++;
  if (buildCounterGoogleCloudVisionV1p2beta1ProductSearchResultsResult < 3) {
    o.image = 'foo';
    o.product = buildGoogleCloudVisionV1p2beta1Product();
    o.score = 42.0;
  }
  buildCounterGoogleCloudVisionV1p2beta1ProductSearchResultsResult--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1ProductSearchResultsResult(
    api.GoogleCloudVisionV1p2beta1ProductSearchResultsResult o) {
  buildCounterGoogleCloudVisionV1p2beta1ProductSearchResultsResult++;
  if (buildCounterGoogleCloudVisionV1p2beta1ProductSearchResultsResult < 3) {
    unittest.expect(
      o.image!,
      unittest.equals('foo'),
    );
    checkGoogleCloudVisionV1p2beta1Product(
        o.product! as api.GoogleCloudVisionV1p2beta1Product);
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1ProductSearchResultsResult--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1Property = 0;
api.GoogleCloudVisionV1p2beta1Property
    buildGoogleCloudVisionV1p2beta1Property() {
  var o = api.GoogleCloudVisionV1p2beta1Property();
  buildCounterGoogleCloudVisionV1p2beta1Property++;
  if (buildCounterGoogleCloudVisionV1p2beta1Property < 3) {
    o.name = 'foo';
    o.uint64Value = 'foo';
    o.value = 'foo';
  }
  buildCounterGoogleCloudVisionV1p2beta1Property--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1Property(
    api.GoogleCloudVisionV1p2beta1Property o) {
  buildCounterGoogleCloudVisionV1p2beta1Property++;
  if (buildCounterGoogleCloudVisionV1p2beta1Property < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.uint64Value!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1Property--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1SafeSearchAnnotation = 0;
api.GoogleCloudVisionV1p2beta1SafeSearchAnnotation
    buildGoogleCloudVisionV1p2beta1SafeSearchAnnotation() {
  var o = api.GoogleCloudVisionV1p2beta1SafeSearchAnnotation();
  buildCounterGoogleCloudVisionV1p2beta1SafeSearchAnnotation++;
  if (buildCounterGoogleCloudVisionV1p2beta1SafeSearchAnnotation < 3) {
    o.adult = 'foo';
    o.medical = 'foo';
    o.racy = 'foo';
    o.spoof = 'foo';
    o.violence = 'foo';
  }
  buildCounterGoogleCloudVisionV1p2beta1SafeSearchAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1SafeSearchAnnotation(
    api.GoogleCloudVisionV1p2beta1SafeSearchAnnotation o) {
  buildCounterGoogleCloudVisionV1p2beta1SafeSearchAnnotation++;
  if (buildCounterGoogleCloudVisionV1p2beta1SafeSearchAnnotation < 3) {
    unittest.expect(
      o.adult!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.medical!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.racy!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.spoof!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.violence!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1SafeSearchAnnotation--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1Symbol = 0;
api.GoogleCloudVisionV1p2beta1Symbol buildGoogleCloudVisionV1p2beta1Symbol() {
  var o = api.GoogleCloudVisionV1p2beta1Symbol();
  buildCounterGoogleCloudVisionV1p2beta1Symbol++;
  if (buildCounterGoogleCloudVisionV1p2beta1Symbol < 3) {
    o.boundingBox = buildGoogleCloudVisionV1p2beta1BoundingPoly();
    o.confidence = 42.0;
    o.property = buildGoogleCloudVisionV1p2beta1TextAnnotationTextProperty();
    o.text = 'foo';
  }
  buildCounterGoogleCloudVisionV1p2beta1Symbol--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1Symbol(
    api.GoogleCloudVisionV1p2beta1Symbol o) {
  buildCounterGoogleCloudVisionV1p2beta1Symbol++;
  if (buildCounterGoogleCloudVisionV1p2beta1Symbol < 3) {
    checkGoogleCloudVisionV1p2beta1BoundingPoly(
        o.boundingBox! as api.GoogleCloudVisionV1p2beta1BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVisionV1p2beta1TextAnnotationTextProperty(o.property!
        as api.GoogleCloudVisionV1p2beta1TextAnnotationTextProperty);
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1Symbol--;
}

core.List<api.GoogleCloudVisionV1p2beta1Page> buildUnnamed6322() {
  var o = <api.GoogleCloudVisionV1p2beta1Page>[];
  o.add(buildGoogleCloudVisionV1p2beta1Page());
  o.add(buildGoogleCloudVisionV1p2beta1Page());
  return o;
}

void checkUnnamed6322(core.List<api.GoogleCloudVisionV1p2beta1Page> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1Page(
      o[0] as api.GoogleCloudVisionV1p2beta1Page);
  checkGoogleCloudVisionV1p2beta1Page(
      o[1] as api.GoogleCloudVisionV1p2beta1Page);
}

core.int buildCounterGoogleCloudVisionV1p2beta1TextAnnotation = 0;
api.GoogleCloudVisionV1p2beta1TextAnnotation
    buildGoogleCloudVisionV1p2beta1TextAnnotation() {
  var o = api.GoogleCloudVisionV1p2beta1TextAnnotation();
  buildCounterGoogleCloudVisionV1p2beta1TextAnnotation++;
  if (buildCounterGoogleCloudVisionV1p2beta1TextAnnotation < 3) {
    o.pages = buildUnnamed6322();
    o.text = 'foo';
  }
  buildCounterGoogleCloudVisionV1p2beta1TextAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1TextAnnotation(
    api.GoogleCloudVisionV1p2beta1TextAnnotation o) {
  buildCounterGoogleCloudVisionV1p2beta1TextAnnotation++;
  if (buildCounterGoogleCloudVisionV1p2beta1TextAnnotation < 3) {
    checkUnnamed6322(o.pages!);
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1TextAnnotation--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1TextAnnotationDetectedBreak = 0;
api.GoogleCloudVisionV1p2beta1TextAnnotationDetectedBreak
    buildGoogleCloudVisionV1p2beta1TextAnnotationDetectedBreak() {
  var o = api.GoogleCloudVisionV1p2beta1TextAnnotationDetectedBreak();
  buildCounterGoogleCloudVisionV1p2beta1TextAnnotationDetectedBreak++;
  if (buildCounterGoogleCloudVisionV1p2beta1TextAnnotationDetectedBreak < 3) {
    o.isPrefix = true;
    o.type = 'foo';
  }
  buildCounterGoogleCloudVisionV1p2beta1TextAnnotationDetectedBreak--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1TextAnnotationDetectedBreak(
    api.GoogleCloudVisionV1p2beta1TextAnnotationDetectedBreak o) {
  buildCounterGoogleCloudVisionV1p2beta1TextAnnotationDetectedBreak++;
  if (buildCounterGoogleCloudVisionV1p2beta1TextAnnotationDetectedBreak < 3) {
    unittest.expect(o.isPrefix!, unittest.isTrue);
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1TextAnnotationDetectedBreak--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage =
    0;
api.GoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage
    buildGoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage() {
  var o = api.GoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage();
  buildCounterGoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage++;
  if (buildCounterGoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage <
      3) {
    o.confidence = 42.0;
    o.languageCode = 'foo';
  }
  buildCounterGoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage(
    api.GoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage o) {
  buildCounterGoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage++;
  if (buildCounterGoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage <
      3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage--;
}

core.List<api.GoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage>
    buildUnnamed6323() {
  var o = <api.GoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage>[];
  o.add(buildGoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage());
  o.add(buildGoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage());
  return o;
}

void checkUnnamed6323(
    core.List<api.GoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage(
      o[0] as api.GoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage);
  checkGoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage(
      o[1] as api.GoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage);
}

core.int buildCounterGoogleCloudVisionV1p2beta1TextAnnotationTextProperty = 0;
api.GoogleCloudVisionV1p2beta1TextAnnotationTextProperty
    buildGoogleCloudVisionV1p2beta1TextAnnotationTextProperty() {
  var o = api.GoogleCloudVisionV1p2beta1TextAnnotationTextProperty();
  buildCounterGoogleCloudVisionV1p2beta1TextAnnotationTextProperty++;
  if (buildCounterGoogleCloudVisionV1p2beta1TextAnnotationTextProperty < 3) {
    o.detectedBreak =
        buildGoogleCloudVisionV1p2beta1TextAnnotationDetectedBreak();
    o.detectedLanguages = buildUnnamed6323();
  }
  buildCounterGoogleCloudVisionV1p2beta1TextAnnotationTextProperty--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1TextAnnotationTextProperty(
    api.GoogleCloudVisionV1p2beta1TextAnnotationTextProperty o) {
  buildCounterGoogleCloudVisionV1p2beta1TextAnnotationTextProperty++;
  if (buildCounterGoogleCloudVisionV1p2beta1TextAnnotationTextProperty < 3) {
    checkGoogleCloudVisionV1p2beta1TextAnnotationDetectedBreak(o.detectedBreak!
        as api.GoogleCloudVisionV1p2beta1TextAnnotationDetectedBreak);
    checkUnnamed6323(o.detectedLanguages!);
  }
  buildCounterGoogleCloudVisionV1p2beta1TextAnnotationTextProperty--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1Vertex = 0;
api.GoogleCloudVisionV1p2beta1Vertex buildGoogleCloudVisionV1p2beta1Vertex() {
  var o = api.GoogleCloudVisionV1p2beta1Vertex();
  buildCounterGoogleCloudVisionV1p2beta1Vertex++;
  if (buildCounterGoogleCloudVisionV1p2beta1Vertex < 3) {
    o.x = 42;
    o.y = 42;
  }
  buildCounterGoogleCloudVisionV1p2beta1Vertex--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1Vertex(
    api.GoogleCloudVisionV1p2beta1Vertex o) {
  buildCounterGoogleCloudVisionV1p2beta1Vertex++;
  if (buildCounterGoogleCloudVisionV1p2beta1Vertex < 3) {
    unittest.expect(
      o.x!,
      unittest.equals(42),
    );
    unittest.expect(
      o.y!,
      unittest.equals(42),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1Vertex--;
}

core.List<api.GoogleCloudVisionV1p2beta1WebDetectionWebLabel>
    buildUnnamed6324() {
  var o = <api.GoogleCloudVisionV1p2beta1WebDetectionWebLabel>[];
  o.add(buildGoogleCloudVisionV1p2beta1WebDetectionWebLabel());
  o.add(buildGoogleCloudVisionV1p2beta1WebDetectionWebLabel());
  return o;
}

void checkUnnamed6324(
    core.List<api.GoogleCloudVisionV1p2beta1WebDetectionWebLabel> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1WebDetectionWebLabel(
      o[0] as api.GoogleCloudVisionV1p2beta1WebDetectionWebLabel);
  checkGoogleCloudVisionV1p2beta1WebDetectionWebLabel(
      o[1] as api.GoogleCloudVisionV1p2beta1WebDetectionWebLabel);
}

core.List<api.GoogleCloudVisionV1p2beta1WebDetectionWebImage>
    buildUnnamed6325() {
  var o = <api.GoogleCloudVisionV1p2beta1WebDetectionWebImage>[];
  o.add(buildGoogleCloudVisionV1p2beta1WebDetectionWebImage());
  o.add(buildGoogleCloudVisionV1p2beta1WebDetectionWebImage());
  return o;
}

void checkUnnamed6325(
    core.List<api.GoogleCloudVisionV1p2beta1WebDetectionWebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1WebDetectionWebImage(
      o[0] as api.GoogleCloudVisionV1p2beta1WebDetectionWebImage);
  checkGoogleCloudVisionV1p2beta1WebDetectionWebImage(
      o[1] as api.GoogleCloudVisionV1p2beta1WebDetectionWebImage);
}

core.List<api.GoogleCloudVisionV1p2beta1WebDetectionWebPage>
    buildUnnamed6326() {
  var o = <api.GoogleCloudVisionV1p2beta1WebDetectionWebPage>[];
  o.add(buildGoogleCloudVisionV1p2beta1WebDetectionWebPage());
  o.add(buildGoogleCloudVisionV1p2beta1WebDetectionWebPage());
  return o;
}

void checkUnnamed6326(
    core.List<api.GoogleCloudVisionV1p2beta1WebDetectionWebPage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1WebDetectionWebPage(
      o[0] as api.GoogleCloudVisionV1p2beta1WebDetectionWebPage);
  checkGoogleCloudVisionV1p2beta1WebDetectionWebPage(
      o[1] as api.GoogleCloudVisionV1p2beta1WebDetectionWebPage);
}

core.List<api.GoogleCloudVisionV1p2beta1WebDetectionWebImage>
    buildUnnamed6327() {
  var o = <api.GoogleCloudVisionV1p2beta1WebDetectionWebImage>[];
  o.add(buildGoogleCloudVisionV1p2beta1WebDetectionWebImage());
  o.add(buildGoogleCloudVisionV1p2beta1WebDetectionWebImage());
  return o;
}

void checkUnnamed6327(
    core.List<api.GoogleCloudVisionV1p2beta1WebDetectionWebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1WebDetectionWebImage(
      o[0] as api.GoogleCloudVisionV1p2beta1WebDetectionWebImage);
  checkGoogleCloudVisionV1p2beta1WebDetectionWebImage(
      o[1] as api.GoogleCloudVisionV1p2beta1WebDetectionWebImage);
}

core.List<api.GoogleCloudVisionV1p2beta1WebDetectionWebImage>
    buildUnnamed6328() {
  var o = <api.GoogleCloudVisionV1p2beta1WebDetectionWebImage>[];
  o.add(buildGoogleCloudVisionV1p2beta1WebDetectionWebImage());
  o.add(buildGoogleCloudVisionV1p2beta1WebDetectionWebImage());
  return o;
}

void checkUnnamed6328(
    core.List<api.GoogleCloudVisionV1p2beta1WebDetectionWebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1WebDetectionWebImage(
      o[0] as api.GoogleCloudVisionV1p2beta1WebDetectionWebImage);
  checkGoogleCloudVisionV1p2beta1WebDetectionWebImage(
      o[1] as api.GoogleCloudVisionV1p2beta1WebDetectionWebImage);
}

core.List<api.GoogleCloudVisionV1p2beta1WebDetectionWebEntity>
    buildUnnamed6329() {
  var o = <api.GoogleCloudVisionV1p2beta1WebDetectionWebEntity>[];
  o.add(buildGoogleCloudVisionV1p2beta1WebDetectionWebEntity());
  o.add(buildGoogleCloudVisionV1p2beta1WebDetectionWebEntity());
  return o;
}

void checkUnnamed6329(
    core.List<api.GoogleCloudVisionV1p2beta1WebDetectionWebEntity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1WebDetectionWebEntity(
      o[0] as api.GoogleCloudVisionV1p2beta1WebDetectionWebEntity);
  checkGoogleCloudVisionV1p2beta1WebDetectionWebEntity(
      o[1] as api.GoogleCloudVisionV1p2beta1WebDetectionWebEntity);
}

core.int buildCounterGoogleCloudVisionV1p2beta1WebDetection = 0;
api.GoogleCloudVisionV1p2beta1WebDetection
    buildGoogleCloudVisionV1p2beta1WebDetection() {
  var o = api.GoogleCloudVisionV1p2beta1WebDetection();
  buildCounterGoogleCloudVisionV1p2beta1WebDetection++;
  if (buildCounterGoogleCloudVisionV1p2beta1WebDetection < 3) {
    o.bestGuessLabels = buildUnnamed6324();
    o.fullMatchingImages = buildUnnamed6325();
    o.pagesWithMatchingImages = buildUnnamed6326();
    o.partialMatchingImages = buildUnnamed6327();
    o.visuallySimilarImages = buildUnnamed6328();
    o.webEntities = buildUnnamed6329();
  }
  buildCounterGoogleCloudVisionV1p2beta1WebDetection--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1WebDetection(
    api.GoogleCloudVisionV1p2beta1WebDetection o) {
  buildCounterGoogleCloudVisionV1p2beta1WebDetection++;
  if (buildCounterGoogleCloudVisionV1p2beta1WebDetection < 3) {
    checkUnnamed6324(o.bestGuessLabels!);
    checkUnnamed6325(o.fullMatchingImages!);
    checkUnnamed6326(o.pagesWithMatchingImages!);
    checkUnnamed6327(o.partialMatchingImages!);
    checkUnnamed6328(o.visuallySimilarImages!);
    checkUnnamed6329(o.webEntities!);
  }
  buildCounterGoogleCloudVisionV1p2beta1WebDetection--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebEntity = 0;
api.GoogleCloudVisionV1p2beta1WebDetectionWebEntity
    buildGoogleCloudVisionV1p2beta1WebDetectionWebEntity() {
  var o = api.GoogleCloudVisionV1p2beta1WebDetectionWebEntity();
  buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebEntity++;
  if (buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebEntity < 3) {
    o.description = 'foo';
    o.entityId = 'foo';
    o.score = 42.0;
  }
  buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebEntity--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1WebDetectionWebEntity(
    api.GoogleCloudVisionV1p2beta1WebDetectionWebEntity o) {
  buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebEntity++;
  if (buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebEntity < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.entityId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebEntity--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebImage = 0;
api.GoogleCloudVisionV1p2beta1WebDetectionWebImage
    buildGoogleCloudVisionV1p2beta1WebDetectionWebImage() {
  var o = api.GoogleCloudVisionV1p2beta1WebDetectionWebImage();
  buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebImage++;
  if (buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebImage < 3) {
    o.score = 42.0;
    o.url = 'foo';
  }
  buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebImage--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1WebDetectionWebImage(
    api.GoogleCloudVisionV1p2beta1WebDetectionWebImage o) {
  buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebImage++;
  if (buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebImage < 3) {
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.url!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebImage--;
}

core.int buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebLabel = 0;
api.GoogleCloudVisionV1p2beta1WebDetectionWebLabel
    buildGoogleCloudVisionV1p2beta1WebDetectionWebLabel() {
  var o = api.GoogleCloudVisionV1p2beta1WebDetectionWebLabel();
  buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebLabel++;
  if (buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebLabel < 3) {
    o.label = 'foo';
    o.languageCode = 'foo';
  }
  buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebLabel--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1WebDetectionWebLabel(
    api.GoogleCloudVisionV1p2beta1WebDetectionWebLabel o) {
  buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebLabel++;
  if (buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebLabel < 3) {
    unittest.expect(
      o.label!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebLabel--;
}

core.List<api.GoogleCloudVisionV1p2beta1WebDetectionWebImage>
    buildUnnamed6330() {
  var o = <api.GoogleCloudVisionV1p2beta1WebDetectionWebImage>[];
  o.add(buildGoogleCloudVisionV1p2beta1WebDetectionWebImage());
  o.add(buildGoogleCloudVisionV1p2beta1WebDetectionWebImage());
  return o;
}

void checkUnnamed6330(
    core.List<api.GoogleCloudVisionV1p2beta1WebDetectionWebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1WebDetectionWebImage(
      o[0] as api.GoogleCloudVisionV1p2beta1WebDetectionWebImage);
  checkGoogleCloudVisionV1p2beta1WebDetectionWebImage(
      o[1] as api.GoogleCloudVisionV1p2beta1WebDetectionWebImage);
}

core.List<api.GoogleCloudVisionV1p2beta1WebDetectionWebImage>
    buildUnnamed6331() {
  var o = <api.GoogleCloudVisionV1p2beta1WebDetectionWebImage>[];
  o.add(buildGoogleCloudVisionV1p2beta1WebDetectionWebImage());
  o.add(buildGoogleCloudVisionV1p2beta1WebDetectionWebImage());
  return o;
}

void checkUnnamed6331(
    core.List<api.GoogleCloudVisionV1p2beta1WebDetectionWebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1WebDetectionWebImage(
      o[0] as api.GoogleCloudVisionV1p2beta1WebDetectionWebImage);
  checkGoogleCloudVisionV1p2beta1WebDetectionWebImage(
      o[1] as api.GoogleCloudVisionV1p2beta1WebDetectionWebImage);
}

core.int buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebPage = 0;
api.GoogleCloudVisionV1p2beta1WebDetectionWebPage
    buildGoogleCloudVisionV1p2beta1WebDetectionWebPage() {
  var o = api.GoogleCloudVisionV1p2beta1WebDetectionWebPage();
  buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebPage++;
  if (buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebPage < 3) {
    o.fullMatchingImages = buildUnnamed6330();
    o.pageTitle = 'foo';
    o.partialMatchingImages = buildUnnamed6331();
    o.score = 42.0;
    o.url = 'foo';
  }
  buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebPage--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1WebDetectionWebPage(
    api.GoogleCloudVisionV1p2beta1WebDetectionWebPage o) {
  buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebPage++;
  if (buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebPage < 3) {
    checkUnnamed6330(o.fullMatchingImages!);
    unittest.expect(
      o.pageTitle!,
      unittest.equals('foo'),
    );
    checkUnnamed6331(o.partialMatchingImages!);
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.url!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p2beta1WebDetectionWebPage--;
}

core.List<api.GoogleCloudVisionV1p2beta1Symbol> buildUnnamed6332() {
  var o = <api.GoogleCloudVisionV1p2beta1Symbol>[];
  o.add(buildGoogleCloudVisionV1p2beta1Symbol());
  o.add(buildGoogleCloudVisionV1p2beta1Symbol());
  return o;
}

void checkUnnamed6332(core.List<api.GoogleCloudVisionV1p2beta1Symbol> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p2beta1Symbol(
      o[0] as api.GoogleCloudVisionV1p2beta1Symbol);
  checkGoogleCloudVisionV1p2beta1Symbol(
      o[1] as api.GoogleCloudVisionV1p2beta1Symbol);
}

core.int buildCounterGoogleCloudVisionV1p2beta1Word = 0;
api.GoogleCloudVisionV1p2beta1Word buildGoogleCloudVisionV1p2beta1Word() {
  var o = api.GoogleCloudVisionV1p2beta1Word();
  buildCounterGoogleCloudVisionV1p2beta1Word++;
  if (buildCounterGoogleCloudVisionV1p2beta1Word < 3) {
    o.boundingBox = buildGoogleCloudVisionV1p2beta1BoundingPoly();
    o.confidence = 42.0;
    o.property = buildGoogleCloudVisionV1p2beta1TextAnnotationTextProperty();
    o.symbols = buildUnnamed6332();
  }
  buildCounterGoogleCloudVisionV1p2beta1Word--;
  return o;
}

void checkGoogleCloudVisionV1p2beta1Word(api.GoogleCloudVisionV1p2beta1Word o) {
  buildCounterGoogleCloudVisionV1p2beta1Word++;
  if (buildCounterGoogleCloudVisionV1p2beta1Word < 3) {
    checkGoogleCloudVisionV1p2beta1BoundingPoly(
        o.boundingBox! as api.GoogleCloudVisionV1p2beta1BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVisionV1p2beta1TextAnnotationTextProperty(o.property!
        as api.GoogleCloudVisionV1p2beta1TextAnnotationTextProperty);
    checkUnnamed6332(o.symbols!);
  }
  buildCounterGoogleCloudVisionV1p2beta1Word--;
}

core.List<api.GoogleCloudVisionV1p3beta1AnnotateImageResponse>
    buildUnnamed6333() {
  var o = <api.GoogleCloudVisionV1p3beta1AnnotateImageResponse>[];
  o.add(buildGoogleCloudVisionV1p3beta1AnnotateImageResponse());
  o.add(buildGoogleCloudVisionV1p3beta1AnnotateImageResponse());
  return o;
}

void checkUnnamed6333(
    core.List<api.GoogleCloudVisionV1p3beta1AnnotateImageResponse> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1AnnotateImageResponse(
      o[0] as api.GoogleCloudVisionV1p3beta1AnnotateImageResponse);
  checkGoogleCloudVisionV1p3beta1AnnotateImageResponse(
      o[1] as api.GoogleCloudVisionV1p3beta1AnnotateImageResponse);
}

core.int buildCounterGoogleCloudVisionV1p3beta1AnnotateFileResponse = 0;
api.GoogleCloudVisionV1p3beta1AnnotateFileResponse
    buildGoogleCloudVisionV1p3beta1AnnotateFileResponse() {
  var o = api.GoogleCloudVisionV1p3beta1AnnotateFileResponse();
  buildCounterGoogleCloudVisionV1p3beta1AnnotateFileResponse++;
  if (buildCounterGoogleCloudVisionV1p3beta1AnnotateFileResponse < 3) {
    o.error = buildStatus();
    o.inputConfig = buildGoogleCloudVisionV1p3beta1InputConfig();
    o.responses = buildUnnamed6333();
    o.totalPages = 42;
  }
  buildCounterGoogleCloudVisionV1p3beta1AnnotateFileResponse--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1AnnotateFileResponse(
    api.GoogleCloudVisionV1p3beta1AnnotateFileResponse o) {
  buildCounterGoogleCloudVisionV1p3beta1AnnotateFileResponse++;
  if (buildCounterGoogleCloudVisionV1p3beta1AnnotateFileResponse < 3) {
    checkStatus(o.error! as api.Status);
    checkGoogleCloudVisionV1p3beta1InputConfig(
        o.inputConfig! as api.GoogleCloudVisionV1p3beta1InputConfig);
    checkUnnamed6333(o.responses!);
    unittest.expect(
      o.totalPages!,
      unittest.equals(42),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1AnnotateFileResponse--;
}

core.List<api.GoogleCloudVisionV1p3beta1FaceAnnotation> buildUnnamed6334() {
  var o = <api.GoogleCloudVisionV1p3beta1FaceAnnotation>[];
  o.add(buildGoogleCloudVisionV1p3beta1FaceAnnotation());
  o.add(buildGoogleCloudVisionV1p3beta1FaceAnnotation());
  return o;
}

void checkUnnamed6334(
    core.List<api.GoogleCloudVisionV1p3beta1FaceAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1FaceAnnotation(
      o[0] as api.GoogleCloudVisionV1p3beta1FaceAnnotation);
  checkGoogleCloudVisionV1p3beta1FaceAnnotation(
      o[1] as api.GoogleCloudVisionV1p3beta1FaceAnnotation);
}

core.List<api.GoogleCloudVisionV1p3beta1EntityAnnotation> buildUnnamed6335() {
  var o = <api.GoogleCloudVisionV1p3beta1EntityAnnotation>[];
  o.add(buildGoogleCloudVisionV1p3beta1EntityAnnotation());
  o.add(buildGoogleCloudVisionV1p3beta1EntityAnnotation());
  return o;
}

void checkUnnamed6335(
    core.List<api.GoogleCloudVisionV1p3beta1EntityAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1EntityAnnotation(
      o[0] as api.GoogleCloudVisionV1p3beta1EntityAnnotation);
  checkGoogleCloudVisionV1p3beta1EntityAnnotation(
      o[1] as api.GoogleCloudVisionV1p3beta1EntityAnnotation);
}

core.List<api.GoogleCloudVisionV1p3beta1EntityAnnotation> buildUnnamed6336() {
  var o = <api.GoogleCloudVisionV1p3beta1EntityAnnotation>[];
  o.add(buildGoogleCloudVisionV1p3beta1EntityAnnotation());
  o.add(buildGoogleCloudVisionV1p3beta1EntityAnnotation());
  return o;
}

void checkUnnamed6336(
    core.List<api.GoogleCloudVisionV1p3beta1EntityAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1EntityAnnotation(
      o[0] as api.GoogleCloudVisionV1p3beta1EntityAnnotation);
  checkGoogleCloudVisionV1p3beta1EntityAnnotation(
      o[1] as api.GoogleCloudVisionV1p3beta1EntityAnnotation);
}

core.List<api.GoogleCloudVisionV1p3beta1LocalizedObjectAnnotation>
    buildUnnamed6337() {
  var o = <api.GoogleCloudVisionV1p3beta1LocalizedObjectAnnotation>[];
  o.add(buildGoogleCloudVisionV1p3beta1LocalizedObjectAnnotation());
  o.add(buildGoogleCloudVisionV1p3beta1LocalizedObjectAnnotation());
  return o;
}

void checkUnnamed6337(
    core.List<api.GoogleCloudVisionV1p3beta1LocalizedObjectAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1LocalizedObjectAnnotation(
      o[0] as api.GoogleCloudVisionV1p3beta1LocalizedObjectAnnotation);
  checkGoogleCloudVisionV1p3beta1LocalizedObjectAnnotation(
      o[1] as api.GoogleCloudVisionV1p3beta1LocalizedObjectAnnotation);
}

core.List<api.GoogleCloudVisionV1p3beta1EntityAnnotation> buildUnnamed6338() {
  var o = <api.GoogleCloudVisionV1p3beta1EntityAnnotation>[];
  o.add(buildGoogleCloudVisionV1p3beta1EntityAnnotation());
  o.add(buildGoogleCloudVisionV1p3beta1EntityAnnotation());
  return o;
}

void checkUnnamed6338(
    core.List<api.GoogleCloudVisionV1p3beta1EntityAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1EntityAnnotation(
      o[0] as api.GoogleCloudVisionV1p3beta1EntityAnnotation);
  checkGoogleCloudVisionV1p3beta1EntityAnnotation(
      o[1] as api.GoogleCloudVisionV1p3beta1EntityAnnotation);
}

core.List<api.GoogleCloudVisionV1p3beta1EntityAnnotation> buildUnnamed6339() {
  var o = <api.GoogleCloudVisionV1p3beta1EntityAnnotation>[];
  o.add(buildGoogleCloudVisionV1p3beta1EntityAnnotation());
  o.add(buildGoogleCloudVisionV1p3beta1EntityAnnotation());
  return o;
}

void checkUnnamed6339(
    core.List<api.GoogleCloudVisionV1p3beta1EntityAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1EntityAnnotation(
      o[0] as api.GoogleCloudVisionV1p3beta1EntityAnnotation);
  checkGoogleCloudVisionV1p3beta1EntityAnnotation(
      o[1] as api.GoogleCloudVisionV1p3beta1EntityAnnotation);
}

core.int buildCounterGoogleCloudVisionV1p3beta1AnnotateImageResponse = 0;
api.GoogleCloudVisionV1p3beta1AnnotateImageResponse
    buildGoogleCloudVisionV1p3beta1AnnotateImageResponse() {
  var o = api.GoogleCloudVisionV1p3beta1AnnotateImageResponse();
  buildCounterGoogleCloudVisionV1p3beta1AnnotateImageResponse++;
  if (buildCounterGoogleCloudVisionV1p3beta1AnnotateImageResponse < 3) {
    o.context = buildGoogleCloudVisionV1p3beta1ImageAnnotationContext();
    o.cropHintsAnnotation =
        buildGoogleCloudVisionV1p3beta1CropHintsAnnotation();
    o.error = buildStatus();
    o.faceAnnotations = buildUnnamed6334();
    o.fullTextAnnotation = buildGoogleCloudVisionV1p3beta1TextAnnotation();
    o.imagePropertiesAnnotation =
        buildGoogleCloudVisionV1p3beta1ImageProperties();
    o.labelAnnotations = buildUnnamed6335();
    o.landmarkAnnotations = buildUnnamed6336();
    o.localizedObjectAnnotations = buildUnnamed6337();
    o.logoAnnotations = buildUnnamed6338();
    o.productSearchResults =
        buildGoogleCloudVisionV1p3beta1ProductSearchResults();
    o.safeSearchAnnotation =
        buildGoogleCloudVisionV1p3beta1SafeSearchAnnotation();
    o.textAnnotations = buildUnnamed6339();
    o.webDetection = buildGoogleCloudVisionV1p3beta1WebDetection();
  }
  buildCounterGoogleCloudVisionV1p3beta1AnnotateImageResponse--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1AnnotateImageResponse(
    api.GoogleCloudVisionV1p3beta1AnnotateImageResponse o) {
  buildCounterGoogleCloudVisionV1p3beta1AnnotateImageResponse++;
  if (buildCounterGoogleCloudVisionV1p3beta1AnnotateImageResponse < 3) {
    checkGoogleCloudVisionV1p3beta1ImageAnnotationContext(
        o.context! as api.GoogleCloudVisionV1p3beta1ImageAnnotationContext);
    checkGoogleCloudVisionV1p3beta1CropHintsAnnotation(o.cropHintsAnnotation!
        as api.GoogleCloudVisionV1p3beta1CropHintsAnnotation);
    checkStatus(o.error! as api.Status);
    checkUnnamed6334(o.faceAnnotations!);
    checkGoogleCloudVisionV1p3beta1TextAnnotation(
        o.fullTextAnnotation! as api.GoogleCloudVisionV1p3beta1TextAnnotation);
    checkGoogleCloudVisionV1p3beta1ImageProperties(o.imagePropertiesAnnotation!
        as api.GoogleCloudVisionV1p3beta1ImageProperties);
    checkUnnamed6335(o.labelAnnotations!);
    checkUnnamed6336(o.landmarkAnnotations!);
    checkUnnamed6337(o.localizedObjectAnnotations!);
    checkUnnamed6338(o.logoAnnotations!);
    checkGoogleCloudVisionV1p3beta1ProductSearchResults(o.productSearchResults!
        as api.GoogleCloudVisionV1p3beta1ProductSearchResults);
    checkGoogleCloudVisionV1p3beta1SafeSearchAnnotation(o.safeSearchAnnotation!
        as api.GoogleCloudVisionV1p3beta1SafeSearchAnnotation);
    checkUnnamed6339(o.textAnnotations!);
    checkGoogleCloudVisionV1p3beta1WebDetection(
        o.webDetection! as api.GoogleCloudVisionV1p3beta1WebDetection);
  }
  buildCounterGoogleCloudVisionV1p3beta1AnnotateImageResponse--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse = 0;
api.GoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse
    buildGoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse() {
  var o = api.GoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse();
  buildCounterGoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse++;
  if (buildCounterGoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse < 3) {
    o.outputConfig = buildGoogleCloudVisionV1p3beta1OutputConfig();
  }
  buildCounterGoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse(
    api.GoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse o) {
  buildCounterGoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse++;
  if (buildCounterGoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse < 3) {
    checkGoogleCloudVisionV1p3beta1OutputConfig(
        o.outputConfig! as api.GoogleCloudVisionV1p3beta1OutputConfig);
  }
  buildCounterGoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse--;
}

core.List<api.GoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse>
    buildUnnamed6340() {
  var o = <api.GoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse>[];
  o.add(buildGoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse());
  o.add(buildGoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse());
  return o;
}

void checkUnnamed6340(
    core.List<api.GoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse(
      o[0] as api.GoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse);
  checkGoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse(
      o[1] as api.GoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse);
}

core.int buildCounterGoogleCloudVisionV1p3beta1AsyncBatchAnnotateFilesResponse =
    0;
api.GoogleCloudVisionV1p3beta1AsyncBatchAnnotateFilesResponse
    buildGoogleCloudVisionV1p3beta1AsyncBatchAnnotateFilesResponse() {
  var o = api.GoogleCloudVisionV1p3beta1AsyncBatchAnnotateFilesResponse();
  buildCounterGoogleCloudVisionV1p3beta1AsyncBatchAnnotateFilesResponse++;
  if (buildCounterGoogleCloudVisionV1p3beta1AsyncBatchAnnotateFilesResponse <
      3) {
    o.responses = buildUnnamed6340();
  }
  buildCounterGoogleCloudVisionV1p3beta1AsyncBatchAnnotateFilesResponse--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1AsyncBatchAnnotateFilesResponse(
    api.GoogleCloudVisionV1p3beta1AsyncBatchAnnotateFilesResponse o) {
  buildCounterGoogleCloudVisionV1p3beta1AsyncBatchAnnotateFilesResponse++;
  if (buildCounterGoogleCloudVisionV1p3beta1AsyncBatchAnnotateFilesResponse <
      3) {
    checkUnnamed6340(o.responses!);
  }
  buildCounterGoogleCloudVisionV1p3beta1AsyncBatchAnnotateFilesResponse--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1BatchOperationMetadata = 0;
api.GoogleCloudVisionV1p3beta1BatchOperationMetadata
    buildGoogleCloudVisionV1p3beta1BatchOperationMetadata() {
  var o = api.GoogleCloudVisionV1p3beta1BatchOperationMetadata();
  buildCounterGoogleCloudVisionV1p3beta1BatchOperationMetadata++;
  if (buildCounterGoogleCloudVisionV1p3beta1BatchOperationMetadata < 3) {
    o.endTime = 'foo';
    o.state = 'foo';
    o.submitTime = 'foo';
  }
  buildCounterGoogleCloudVisionV1p3beta1BatchOperationMetadata--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1BatchOperationMetadata(
    api.GoogleCloudVisionV1p3beta1BatchOperationMetadata o) {
  buildCounterGoogleCloudVisionV1p3beta1BatchOperationMetadata++;
  if (buildCounterGoogleCloudVisionV1p3beta1BatchOperationMetadata < 3) {
    unittest.expect(
      o.endTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.submitTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1BatchOperationMetadata--;
}

core.List<api.GoogleCloudVisionV1p3beta1Paragraph> buildUnnamed6341() {
  var o = <api.GoogleCloudVisionV1p3beta1Paragraph>[];
  o.add(buildGoogleCloudVisionV1p3beta1Paragraph());
  o.add(buildGoogleCloudVisionV1p3beta1Paragraph());
  return o;
}

void checkUnnamed6341(core.List<api.GoogleCloudVisionV1p3beta1Paragraph> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1Paragraph(
      o[0] as api.GoogleCloudVisionV1p3beta1Paragraph);
  checkGoogleCloudVisionV1p3beta1Paragraph(
      o[1] as api.GoogleCloudVisionV1p3beta1Paragraph);
}

core.int buildCounterGoogleCloudVisionV1p3beta1Block = 0;
api.GoogleCloudVisionV1p3beta1Block buildGoogleCloudVisionV1p3beta1Block() {
  var o = api.GoogleCloudVisionV1p3beta1Block();
  buildCounterGoogleCloudVisionV1p3beta1Block++;
  if (buildCounterGoogleCloudVisionV1p3beta1Block < 3) {
    o.blockType = 'foo';
    o.boundingBox = buildGoogleCloudVisionV1p3beta1BoundingPoly();
    o.confidence = 42.0;
    o.paragraphs = buildUnnamed6341();
    o.property = buildGoogleCloudVisionV1p3beta1TextAnnotationTextProperty();
  }
  buildCounterGoogleCloudVisionV1p3beta1Block--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1Block(
    api.GoogleCloudVisionV1p3beta1Block o) {
  buildCounterGoogleCloudVisionV1p3beta1Block++;
  if (buildCounterGoogleCloudVisionV1p3beta1Block < 3) {
    unittest.expect(
      o.blockType!,
      unittest.equals('foo'),
    );
    checkGoogleCloudVisionV1p3beta1BoundingPoly(
        o.boundingBox! as api.GoogleCloudVisionV1p3beta1BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkUnnamed6341(o.paragraphs!);
    checkGoogleCloudVisionV1p3beta1TextAnnotationTextProperty(o.property!
        as api.GoogleCloudVisionV1p3beta1TextAnnotationTextProperty);
  }
  buildCounterGoogleCloudVisionV1p3beta1Block--;
}

core.List<api.GoogleCloudVisionV1p3beta1NormalizedVertex> buildUnnamed6342() {
  var o = <api.GoogleCloudVisionV1p3beta1NormalizedVertex>[];
  o.add(buildGoogleCloudVisionV1p3beta1NormalizedVertex());
  o.add(buildGoogleCloudVisionV1p3beta1NormalizedVertex());
  return o;
}

void checkUnnamed6342(
    core.List<api.GoogleCloudVisionV1p3beta1NormalizedVertex> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1NormalizedVertex(
      o[0] as api.GoogleCloudVisionV1p3beta1NormalizedVertex);
  checkGoogleCloudVisionV1p3beta1NormalizedVertex(
      o[1] as api.GoogleCloudVisionV1p3beta1NormalizedVertex);
}

core.List<api.GoogleCloudVisionV1p3beta1Vertex> buildUnnamed6343() {
  var o = <api.GoogleCloudVisionV1p3beta1Vertex>[];
  o.add(buildGoogleCloudVisionV1p3beta1Vertex());
  o.add(buildGoogleCloudVisionV1p3beta1Vertex());
  return o;
}

void checkUnnamed6343(core.List<api.GoogleCloudVisionV1p3beta1Vertex> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1Vertex(
      o[0] as api.GoogleCloudVisionV1p3beta1Vertex);
  checkGoogleCloudVisionV1p3beta1Vertex(
      o[1] as api.GoogleCloudVisionV1p3beta1Vertex);
}

core.int buildCounterGoogleCloudVisionV1p3beta1BoundingPoly = 0;
api.GoogleCloudVisionV1p3beta1BoundingPoly
    buildGoogleCloudVisionV1p3beta1BoundingPoly() {
  var o = api.GoogleCloudVisionV1p3beta1BoundingPoly();
  buildCounterGoogleCloudVisionV1p3beta1BoundingPoly++;
  if (buildCounterGoogleCloudVisionV1p3beta1BoundingPoly < 3) {
    o.normalizedVertices = buildUnnamed6342();
    o.vertices = buildUnnamed6343();
  }
  buildCounterGoogleCloudVisionV1p3beta1BoundingPoly--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1BoundingPoly(
    api.GoogleCloudVisionV1p3beta1BoundingPoly o) {
  buildCounterGoogleCloudVisionV1p3beta1BoundingPoly++;
  if (buildCounterGoogleCloudVisionV1p3beta1BoundingPoly < 3) {
    checkUnnamed6342(o.normalizedVertices!);
    checkUnnamed6343(o.vertices!);
  }
  buildCounterGoogleCloudVisionV1p3beta1BoundingPoly--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1ColorInfo = 0;
api.GoogleCloudVisionV1p3beta1ColorInfo
    buildGoogleCloudVisionV1p3beta1ColorInfo() {
  var o = api.GoogleCloudVisionV1p3beta1ColorInfo();
  buildCounterGoogleCloudVisionV1p3beta1ColorInfo++;
  if (buildCounterGoogleCloudVisionV1p3beta1ColorInfo < 3) {
    o.color = buildColor();
    o.pixelFraction = 42.0;
    o.score = 42.0;
  }
  buildCounterGoogleCloudVisionV1p3beta1ColorInfo--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1ColorInfo(
    api.GoogleCloudVisionV1p3beta1ColorInfo o) {
  buildCounterGoogleCloudVisionV1p3beta1ColorInfo++;
  if (buildCounterGoogleCloudVisionV1p3beta1ColorInfo < 3) {
    checkColor(o.color! as api.Color);
    unittest.expect(
      o.pixelFraction!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1ColorInfo--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1CropHint = 0;
api.GoogleCloudVisionV1p3beta1CropHint
    buildGoogleCloudVisionV1p3beta1CropHint() {
  var o = api.GoogleCloudVisionV1p3beta1CropHint();
  buildCounterGoogleCloudVisionV1p3beta1CropHint++;
  if (buildCounterGoogleCloudVisionV1p3beta1CropHint < 3) {
    o.boundingPoly = buildGoogleCloudVisionV1p3beta1BoundingPoly();
    o.confidence = 42.0;
    o.importanceFraction = 42.0;
  }
  buildCounterGoogleCloudVisionV1p3beta1CropHint--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1CropHint(
    api.GoogleCloudVisionV1p3beta1CropHint o) {
  buildCounterGoogleCloudVisionV1p3beta1CropHint++;
  if (buildCounterGoogleCloudVisionV1p3beta1CropHint < 3) {
    checkGoogleCloudVisionV1p3beta1BoundingPoly(
        o.boundingPoly! as api.GoogleCloudVisionV1p3beta1BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.importanceFraction!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1CropHint--;
}

core.List<api.GoogleCloudVisionV1p3beta1CropHint> buildUnnamed6344() {
  var o = <api.GoogleCloudVisionV1p3beta1CropHint>[];
  o.add(buildGoogleCloudVisionV1p3beta1CropHint());
  o.add(buildGoogleCloudVisionV1p3beta1CropHint());
  return o;
}

void checkUnnamed6344(core.List<api.GoogleCloudVisionV1p3beta1CropHint> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1CropHint(
      o[0] as api.GoogleCloudVisionV1p3beta1CropHint);
  checkGoogleCloudVisionV1p3beta1CropHint(
      o[1] as api.GoogleCloudVisionV1p3beta1CropHint);
}

core.int buildCounterGoogleCloudVisionV1p3beta1CropHintsAnnotation = 0;
api.GoogleCloudVisionV1p3beta1CropHintsAnnotation
    buildGoogleCloudVisionV1p3beta1CropHintsAnnotation() {
  var o = api.GoogleCloudVisionV1p3beta1CropHintsAnnotation();
  buildCounterGoogleCloudVisionV1p3beta1CropHintsAnnotation++;
  if (buildCounterGoogleCloudVisionV1p3beta1CropHintsAnnotation < 3) {
    o.cropHints = buildUnnamed6344();
  }
  buildCounterGoogleCloudVisionV1p3beta1CropHintsAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1CropHintsAnnotation(
    api.GoogleCloudVisionV1p3beta1CropHintsAnnotation o) {
  buildCounterGoogleCloudVisionV1p3beta1CropHintsAnnotation++;
  if (buildCounterGoogleCloudVisionV1p3beta1CropHintsAnnotation < 3) {
    checkUnnamed6344(o.cropHints!);
  }
  buildCounterGoogleCloudVisionV1p3beta1CropHintsAnnotation--;
}

core.List<api.GoogleCloudVisionV1p3beta1ColorInfo> buildUnnamed6345() {
  var o = <api.GoogleCloudVisionV1p3beta1ColorInfo>[];
  o.add(buildGoogleCloudVisionV1p3beta1ColorInfo());
  o.add(buildGoogleCloudVisionV1p3beta1ColorInfo());
  return o;
}

void checkUnnamed6345(core.List<api.GoogleCloudVisionV1p3beta1ColorInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1ColorInfo(
      o[0] as api.GoogleCloudVisionV1p3beta1ColorInfo);
  checkGoogleCloudVisionV1p3beta1ColorInfo(
      o[1] as api.GoogleCloudVisionV1p3beta1ColorInfo);
}

core.int buildCounterGoogleCloudVisionV1p3beta1DominantColorsAnnotation = 0;
api.GoogleCloudVisionV1p3beta1DominantColorsAnnotation
    buildGoogleCloudVisionV1p3beta1DominantColorsAnnotation() {
  var o = api.GoogleCloudVisionV1p3beta1DominantColorsAnnotation();
  buildCounterGoogleCloudVisionV1p3beta1DominantColorsAnnotation++;
  if (buildCounterGoogleCloudVisionV1p3beta1DominantColorsAnnotation < 3) {
    o.colors = buildUnnamed6345();
  }
  buildCounterGoogleCloudVisionV1p3beta1DominantColorsAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1DominantColorsAnnotation(
    api.GoogleCloudVisionV1p3beta1DominantColorsAnnotation o) {
  buildCounterGoogleCloudVisionV1p3beta1DominantColorsAnnotation++;
  if (buildCounterGoogleCloudVisionV1p3beta1DominantColorsAnnotation < 3) {
    checkUnnamed6345(o.colors!);
  }
  buildCounterGoogleCloudVisionV1p3beta1DominantColorsAnnotation--;
}

core.List<api.GoogleCloudVisionV1p3beta1LocationInfo> buildUnnamed6346() {
  var o = <api.GoogleCloudVisionV1p3beta1LocationInfo>[];
  o.add(buildGoogleCloudVisionV1p3beta1LocationInfo());
  o.add(buildGoogleCloudVisionV1p3beta1LocationInfo());
  return o;
}

void checkUnnamed6346(core.List<api.GoogleCloudVisionV1p3beta1LocationInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1LocationInfo(
      o[0] as api.GoogleCloudVisionV1p3beta1LocationInfo);
  checkGoogleCloudVisionV1p3beta1LocationInfo(
      o[1] as api.GoogleCloudVisionV1p3beta1LocationInfo);
}

core.List<api.GoogleCloudVisionV1p3beta1Property> buildUnnamed6347() {
  var o = <api.GoogleCloudVisionV1p3beta1Property>[];
  o.add(buildGoogleCloudVisionV1p3beta1Property());
  o.add(buildGoogleCloudVisionV1p3beta1Property());
  return o;
}

void checkUnnamed6347(core.List<api.GoogleCloudVisionV1p3beta1Property> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1Property(
      o[0] as api.GoogleCloudVisionV1p3beta1Property);
  checkGoogleCloudVisionV1p3beta1Property(
      o[1] as api.GoogleCloudVisionV1p3beta1Property);
}

core.int buildCounterGoogleCloudVisionV1p3beta1EntityAnnotation = 0;
api.GoogleCloudVisionV1p3beta1EntityAnnotation
    buildGoogleCloudVisionV1p3beta1EntityAnnotation() {
  var o = api.GoogleCloudVisionV1p3beta1EntityAnnotation();
  buildCounterGoogleCloudVisionV1p3beta1EntityAnnotation++;
  if (buildCounterGoogleCloudVisionV1p3beta1EntityAnnotation < 3) {
    o.boundingPoly = buildGoogleCloudVisionV1p3beta1BoundingPoly();
    o.confidence = 42.0;
    o.description = 'foo';
    o.locale = 'foo';
    o.locations = buildUnnamed6346();
    o.mid = 'foo';
    o.properties = buildUnnamed6347();
    o.score = 42.0;
    o.topicality = 42.0;
  }
  buildCounterGoogleCloudVisionV1p3beta1EntityAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1EntityAnnotation(
    api.GoogleCloudVisionV1p3beta1EntityAnnotation o) {
  buildCounterGoogleCloudVisionV1p3beta1EntityAnnotation++;
  if (buildCounterGoogleCloudVisionV1p3beta1EntityAnnotation < 3) {
    checkGoogleCloudVisionV1p3beta1BoundingPoly(
        o.boundingPoly! as api.GoogleCloudVisionV1p3beta1BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.locale!,
      unittest.equals('foo'),
    );
    checkUnnamed6346(o.locations!);
    unittest.expect(
      o.mid!,
      unittest.equals('foo'),
    );
    checkUnnamed6347(o.properties!);
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.topicality!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1EntityAnnotation--;
}

core.List<api.GoogleCloudVisionV1p3beta1FaceAnnotationLandmark>
    buildUnnamed6348() {
  var o = <api.GoogleCloudVisionV1p3beta1FaceAnnotationLandmark>[];
  o.add(buildGoogleCloudVisionV1p3beta1FaceAnnotationLandmark());
  o.add(buildGoogleCloudVisionV1p3beta1FaceAnnotationLandmark());
  return o;
}

void checkUnnamed6348(
    core.List<api.GoogleCloudVisionV1p3beta1FaceAnnotationLandmark> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1FaceAnnotationLandmark(
      o[0] as api.GoogleCloudVisionV1p3beta1FaceAnnotationLandmark);
  checkGoogleCloudVisionV1p3beta1FaceAnnotationLandmark(
      o[1] as api.GoogleCloudVisionV1p3beta1FaceAnnotationLandmark);
}

core.int buildCounterGoogleCloudVisionV1p3beta1FaceAnnotation = 0;
api.GoogleCloudVisionV1p3beta1FaceAnnotation
    buildGoogleCloudVisionV1p3beta1FaceAnnotation() {
  var o = api.GoogleCloudVisionV1p3beta1FaceAnnotation();
  buildCounterGoogleCloudVisionV1p3beta1FaceAnnotation++;
  if (buildCounterGoogleCloudVisionV1p3beta1FaceAnnotation < 3) {
    o.angerLikelihood = 'foo';
    o.blurredLikelihood = 'foo';
    o.boundingPoly = buildGoogleCloudVisionV1p3beta1BoundingPoly();
    o.detectionConfidence = 42.0;
    o.fdBoundingPoly = buildGoogleCloudVisionV1p3beta1BoundingPoly();
    o.headwearLikelihood = 'foo';
    o.joyLikelihood = 'foo';
    o.landmarkingConfidence = 42.0;
    o.landmarks = buildUnnamed6348();
    o.panAngle = 42.0;
    o.rollAngle = 42.0;
    o.sorrowLikelihood = 'foo';
    o.surpriseLikelihood = 'foo';
    o.tiltAngle = 42.0;
    o.underExposedLikelihood = 'foo';
  }
  buildCounterGoogleCloudVisionV1p3beta1FaceAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1FaceAnnotation(
    api.GoogleCloudVisionV1p3beta1FaceAnnotation o) {
  buildCounterGoogleCloudVisionV1p3beta1FaceAnnotation++;
  if (buildCounterGoogleCloudVisionV1p3beta1FaceAnnotation < 3) {
    unittest.expect(
      o.angerLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.blurredLikelihood!,
      unittest.equals('foo'),
    );
    checkGoogleCloudVisionV1p3beta1BoundingPoly(
        o.boundingPoly! as api.GoogleCloudVisionV1p3beta1BoundingPoly);
    unittest.expect(
      o.detectionConfidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVisionV1p3beta1BoundingPoly(
        o.fdBoundingPoly! as api.GoogleCloudVisionV1p3beta1BoundingPoly);
    unittest.expect(
      o.headwearLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.joyLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.landmarkingConfidence!,
      unittest.equals(42.0),
    );
    checkUnnamed6348(o.landmarks!);
    unittest.expect(
      o.panAngle!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.rollAngle!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.sorrowLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.surpriseLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.tiltAngle!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.underExposedLikelihood!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1FaceAnnotation--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1FaceAnnotationLandmark = 0;
api.GoogleCloudVisionV1p3beta1FaceAnnotationLandmark
    buildGoogleCloudVisionV1p3beta1FaceAnnotationLandmark() {
  var o = api.GoogleCloudVisionV1p3beta1FaceAnnotationLandmark();
  buildCounterGoogleCloudVisionV1p3beta1FaceAnnotationLandmark++;
  if (buildCounterGoogleCloudVisionV1p3beta1FaceAnnotationLandmark < 3) {
    o.position = buildGoogleCloudVisionV1p3beta1Position();
    o.type = 'foo';
  }
  buildCounterGoogleCloudVisionV1p3beta1FaceAnnotationLandmark--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1FaceAnnotationLandmark(
    api.GoogleCloudVisionV1p3beta1FaceAnnotationLandmark o) {
  buildCounterGoogleCloudVisionV1p3beta1FaceAnnotationLandmark++;
  if (buildCounterGoogleCloudVisionV1p3beta1FaceAnnotationLandmark < 3) {
    checkGoogleCloudVisionV1p3beta1Position(
        o.position! as api.GoogleCloudVisionV1p3beta1Position);
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1FaceAnnotationLandmark--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1GcsDestination = 0;
api.GoogleCloudVisionV1p3beta1GcsDestination
    buildGoogleCloudVisionV1p3beta1GcsDestination() {
  var o = api.GoogleCloudVisionV1p3beta1GcsDestination();
  buildCounterGoogleCloudVisionV1p3beta1GcsDestination++;
  if (buildCounterGoogleCloudVisionV1p3beta1GcsDestination < 3) {
    o.uri = 'foo';
  }
  buildCounterGoogleCloudVisionV1p3beta1GcsDestination--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1GcsDestination(
    api.GoogleCloudVisionV1p3beta1GcsDestination o) {
  buildCounterGoogleCloudVisionV1p3beta1GcsDestination++;
  if (buildCounterGoogleCloudVisionV1p3beta1GcsDestination < 3) {
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1GcsDestination--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1GcsSource = 0;
api.GoogleCloudVisionV1p3beta1GcsSource
    buildGoogleCloudVisionV1p3beta1GcsSource() {
  var o = api.GoogleCloudVisionV1p3beta1GcsSource();
  buildCounterGoogleCloudVisionV1p3beta1GcsSource++;
  if (buildCounterGoogleCloudVisionV1p3beta1GcsSource < 3) {
    o.uri = 'foo';
  }
  buildCounterGoogleCloudVisionV1p3beta1GcsSource--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1GcsSource(
    api.GoogleCloudVisionV1p3beta1GcsSource o) {
  buildCounterGoogleCloudVisionV1p3beta1GcsSource++;
  if (buildCounterGoogleCloudVisionV1p3beta1GcsSource < 3) {
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1GcsSource--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1ImageAnnotationContext = 0;
api.GoogleCloudVisionV1p3beta1ImageAnnotationContext
    buildGoogleCloudVisionV1p3beta1ImageAnnotationContext() {
  var o = api.GoogleCloudVisionV1p3beta1ImageAnnotationContext();
  buildCounterGoogleCloudVisionV1p3beta1ImageAnnotationContext++;
  if (buildCounterGoogleCloudVisionV1p3beta1ImageAnnotationContext < 3) {
    o.pageNumber = 42;
    o.uri = 'foo';
  }
  buildCounterGoogleCloudVisionV1p3beta1ImageAnnotationContext--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1ImageAnnotationContext(
    api.GoogleCloudVisionV1p3beta1ImageAnnotationContext o) {
  buildCounterGoogleCloudVisionV1p3beta1ImageAnnotationContext++;
  if (buildCounterGoogleCloudVisionV1p3beta1ImageAnnotationContext < 3) {
    unittest.expect(
      o.pageNumber!,
      unittest.equals(42),
    );
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1ImageAnnotationContext--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1ImageProperties = 0;
api.GoogleCloudVisionV1p3beta1ImageProperties
    buildGoogleCloudVisionV1p3beta1ImageProperties() {
  var o = api.GoogleCloudVisionV1p3beta1ImageProperties();
  buildCounterGoogleCloudVisionV1p3beta1ImageProperties++;
  if (buildCounterGoogleCloudVisionV1p3beta1ImageProperties < 3) {
    o.dominantColors =
        buildGoogleCloudVisionV1p3beta1DominantColorsAnnotation();
  }
  buildCounterGoogleCloudVisionV1p3beta1ImageProperties--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1ImageProperties(
    api.GoogleCloudVisionV1p3beta1ImageProperties o) {
  buildCounterGoogleCloudVisionV1p3beta1ImageProperties++;
  if (buildCounterGoogleCloudVisionV1p3beta1ImageProperties < 3) {
    checkGoogleCloudVisionV1p3beta1DominantColorsAnnotation(o.dominantColors!
        as api.GoogleCloudVisionV1p3beta1DominantColorsAnnotation);
  }
  buildCounterGoogleCloudVisionV1p3beta1ImageProperties--;
}

core.List<api.GoogleCloudVisionV1p3beta1ReferenceImage> buildUnnamed6349() {
  var o = <api.GoogleCloudVisionV1p3beta1ReferenceImage>[];
  o.add(buildGoogleCloudVisionV1p3beta1ReferenceImage());
  o.add(buildGoogleCloudVisionV1p3beta1ReferenceImage());
  return o;
}

void checkUnnamed6349(
    core.List<api.GoogleCloudVisionV1p3beta1ReferenceImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1ReferenceImage(
      o[0] as api.GoogleCloudVisionV1p3beta1ReferenceImage);
  checkGoogleCloudVisionV1p3beta1ReferenceImage(
      o[1] as api.GoogleCloudVisionV1p3beta1ReferenceImage);
}

core.List<api.Status> buildUnnamed6350() {
  var o = <api.Status>[];
  o.add(buildStatus());
  o.add(buildStatus());
  return o;
}

void checkUnnamed6350(core.List<api.Status> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkStatus(o[0] as api.Status);
  checkStatus(o[1] as api.Status);
}

core.int buildCounterGoogleCloudVisionV1p3beta1ImportProductSetsResponse = 0;
api.GoogleCloudVisionV1p3beta1ImportProductSetsResponse
    buildGoogleCloudVisionV1p3beta1ImportProductSetsResponse() {
  var o = api.GoogleCloudVisionV1p3beta1ImportProductSetsResponse();
  buildCounterGoogleCloudVisionV1p3beta1ImportProductSetsResponse++;
  if (buildCounterGoogleCloudVisionV1p3beta1ImportProductSetsResponse < 3) {
    o.referenceImages = buildUnnamed6349();
    o.statuses = buildUnnamed6350();
  }
  buildCounterGoogleCloudVisionV1p3beta1ImportProductSetsResponse--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1ImportProductSetsResponse(
    api.GoogleCloudVisionV1p3beta1ImportProductSetsResponse o) {
  buildCounterGoogleCloudVisionV1p3beta1ImportProductSetsResponse++;
  if (buildCounterGoogleCloudVisionV1p3beta1ImportProductSetsResponse < 3) {
    checkUnnamed6349(o.referenceImages!);
    checkUnnamed6350(o.statuses!);
  }
  buildCounterGoogleCloudVisionV1p3beta1ImportProductSetsResponse--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1InputConfig = 0;
api.GoogleCloudVisionV1p3beta1InputConfig
    buildGoogleCloudVisionV1p3beta1InputConfig() {
  var o = api.GoogleCloudVisionV1p3beta1InputConfig();
  buildCounterGoogleCloudVisionV1p3beta1InputConfig++;
  if (buildCounterGoogleCloudVisionV1p3beta1InputConfig < 3) {
    o.content = 'foo';
    o.gcsSource = buildGoogleCloudVisionV1p3beta1GcsSource();
    o.mimeType = 'foo';
  }
  buildCounterGoogleCloudVisionV1p3beta1InputConfig--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1InputConfig(
    api.GoogleCloudVisionV1p3beta1InputConfig o) {
  buildCounterGoogleCloudVisionV1p3beta1InputConfig++;
  if (buildCounterGoogleCloudVisionV1p3beta1InputConfig < 3) {
    unittest.expect(
      o.content!,
      unittest.equals('foo'),
    );
    checkGoogleCloudVisionV1p3beta1GcsSource(
        o.gcsSource! as api.GoogleCloudVisionV1p3beta1GcsSource);
    unittest.expect(
      o.mimeType!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1InputConfig--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1LocalizedObjectAnnotation = 0;
api.GoogleCloudVisionV1p3beta1LocalizedObjectAnnotation
    buildGoogleCloudVisionV1p3beta1LocalizedObjectAnnotation() {
  var o = api.GoogleCloudVisionV1p3beta1LocalizedObjectAnnotation();
  buildCounterGoogleCloudVisionV1p3beta1LocalizedObjectAnnotation++;
  if (buildCounterGoogleCloudVisionV1p3beta1LocalizedObjectAnnotation < 3) {
    o.boundingPoly = buildGoogleCloudVisionV1p3beta1BoundingPoly();
    o.languageCode = 'foo';
    o.mid = 'foo';
    o.name = 'foo';
    o.score = 42.0;
  }
  buildCounterGoogleCloudVisionV1p3beta1LocalizedObjectAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1LocalizedObjectAnnotation(
    api.GoogleCloudVisionV1p3beta1LocalizedObjectAnnotation o) {
  buildCounterGoogleCloudVisionV1p3beta1LocalizedObjectAnnotation++;
  if (buildCounterGoogleCloudVisionV1p3beta1LocalizedObjectAnnotation < 3) {
    checkGoogleCloudVisionV1p3beta1BoundingPoly(
        o.boundingPoly! as api.GoogleCloudVisionV1p3beta1BoundingPoly);
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.mid!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1LocalizedObjectAnnotation--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1LocationInfo = 0;
api.GoogleCloudVisionV1p3beta1LocationInfo
    buildGoogleCloudVisionV1p3beta1LocationInfo() {
  var o = api.GoogleCloudVisionV1p3beta1LocationInfo();
  buildCounterGoogleCloudVisionV1p3beta1LocationInfo++;
  if (buildCounterGoogleCloudVisionV1p3beta1LocationInfo < 3) {
    o.latLng = buildLatLng();
  }
  buildCounterGoogleCloudVisionV1p3beta1LocationInfo--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1LocationInfo(
    api.GoogleCloudVisionV1p3beta1LocationInfo o) {
  buildCounterGoogleCloudVisionV1p3beta1LocationInfo++;
  if (buildCounterGoogleCloudVisionV1p3beta1LocationInfo < 3) {
    checkLatLng(o.latLng! as api.LatLng);
  }
  buildCounterGoogleCloudVisionV1p3beta1LocationInfo--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1NormalizedVertex = 0;
api.GoogleCloudVisionV1p3beta1NormalizedVertex
    buildGoogleCloudVisionV1p3beta1NormalizedVertex() {
  var o = api.GoogleCloudVisionV1p3beta1NormalizedVertex();
  buildCounterGoogleCloudVisionV1p3beta1NormalizedVertex++;
  if (buildCounterGoogleCloudVisionV1p3beta1NormalizedVertex < 3) {
    o.x = 42.0;
    o.y = 42.0;
  }
  buildCounterGoogleCloudVisionV1p3beta1NormalizedVertex--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1NormalizedVertex(
    api.GoogleCloudVisionV1p3beta1NormalizedVertex o) {
  buildCounterGoogleCloudVisionV1p3beta1NormalizedVertex++;
  if (buildCounterGoogleCloudVisionV1p3beta1NormalizedVertex < 3) {
    unittest.expect(
      o.x!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.y!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1NormalizedVertex--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1OperationMetadata = 0;
api.GoogleCloudVisionV1p3beta1OperationMetadata
    buildGoogleCloudVisionV1p3beta1OperationMetadata() {
  var o = api.GoogleCloudVisionV1p3beta1OperationMetadata();
  buildCounterGoogleCloudVisionV1p3beta1OperationMetadata++;
  if (buildCounterGoogleCloudVisionV1p3beta1OperationMetadata < 3) {
    o.createTime = 'foo';
    o.state = 'foo';
    o.updateTime = 'foo';
  }
  buildCounterGoogleCloudVisionV1p3beta1OperationMetadata--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1OperationMetadata(
    api.GoogleCloudVisionV1p3beta1OperationMetadata o) {
  buildCounterGoogleCloudVisionV1p3beta1OperationMetadata++;
  if (buildCounterGoogleCloudVisionV1p3beta1OperationMetadata < 3) {
    unittest.expect(
      o.createTime!,
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
  buildCounterGoogleCloudVisionV1p3beta1OperationMetadata--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1OutputConfig = 0;
api.GoogleCloudVisionV1p3beta1OutputConfig
    buildGoogleCloudVisionV1p3beta1OutputConfig() {
  var o = api.GoogleCloudVisionV1p3beta1OutputConfig();
  buildCounterGoogleCloudVisionV1p3beta1OutputConfig++;
  if (buildCounterGoogleCloudVisionV1p3beta1OutputConfig < 3) {
    o.batchSize = 42;
    o.gcsDestination = buildGoogleCloudVisionV1p3beta1GcsDestination();
  }
  buildCounterGoogleCloudVisionV1p3beta1OutputConfig--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1OutputConfig(
    api.GoogleCloudVisionV1p3beta1OutputConfig o) {
  buildCounterGoogleCloudVisionV1p3beta1OutputConfig++;
  if (buildCounterGoogleCloudVisionV1p3beta1OutputConfig < 3) {
    unittest.expect(
      o.batchSize!,
      unittest.equals(42),
    );
    checkGoogleCloudVisionV1p3beta1GcsDestination(
        o.gcsDestination! as api.GoogleCloudVisionV1p3beta1GcsDestination);
  }
  buildCounterGoogleCloudVisionV1p3beta1OutputConfig--;
}

core.List<api.GoogleCloudVisionV1p3beta1Block> buildUnnamed6351() {
  var o = <api.GoogleCloudVisionV1p3beta1Block>[];
  o.add(buildGoogleCloudVisionV1p3beta1Block());
  o.add(buildGoogleCloudVisionV1p3beta1Block());
  return o;
}

void checkUnnamed6351(core.List<api.GoogleCloudVisionV1p3beta1Block> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1Block(
      o[0] as api.GoogleCloudVisionV1p3beta1Block);
  checkGoogleCloudVisionV1p3beta1Block(
      o[1] as api.GoogleCloudVisionV1p3beta1Block);
}

core.int buildCounterGoogleCloudVisionV1p3beta1Page = 0;
api.GoogleCloudVisionV1p3beta1Page buildGoogleCloudVisionV1p3beta1Page() {
  var o = api.GoogleCloudVisionV1p3beta1Page();
  buildCounterGoogleCloudVisionV1p3beta1Page++;
  if (buildCounterGoogleCloudVisionV1p3beta1Page < 3) {
    o.blocks = buildUnnamed6351();
    o.confidence = 42.0;
    o.height = 42;
    o.property = buildGoogleCloudVisionV1p3beta1TextAnnotationTextProperty();
    o.width = 42;
  }
  buildCounterGoogleCloudVisionV1p3beta1Page--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1Page(api.GoogleCloudVisionV1p3beta1Page o) {
  buildCounterGoogleCloudVisionV1p3beta1Page++;
  if (buildCounterGoogleCloudVisionV1p3beta1Page < 3) {
    checkUnnamed6351(o.blocks!);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.height!,
      unittest.equals(42),
    );
    checkGoogleCloudVisionV1p3beta1TextAnnotationTextProperty(o.property!
        as api.GoogleCloudVisionV1p3beta1TextAnnotationTextProperty);
    unittest.expect(
      o.width!,
      unittest.equals(42),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1Page--;
}

core.List<api.GoogleCloudVisionV1p3beta1Word> buildUnnamed6352() {
  var o = <api.GoogleCloudVisionV1p3beta1Word>[];
  o.add(buildGoogleCloudVisionV1p3beta1Word());
  o.add(buildGoogleCloudVisionV1p3beta1Word());
  return o;
}

void checkUnnamed6352(core.List<api.GoogleCloudVisionV1p3beta1Word> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1Word(
      o[0] as api.GoogleCloudVisionV1p3beta1Word);
  checkGoogleCloudVisionV1p3beta1Word(
      o[1] as api.GoogleCloudVisionV1p3beta1Word);
}

core.int buildCounterGoogleCloudVisionV1p3beta1Paragraph = 0;
api.GoogleCloudVisionV1p3beta1Paragraph
    buildGoogleCloudVisionV1p3beta1Paragraph() {
  var o = api.GoogleCloudVisionV1p3beta1Paragraph();
  buildCounterGoogleCloudVisionV1p3beta1Paragraph++;
  if (buildCounterGoogleCloudVisionV1p3beta1Paragraph < 3) {
    o.boundingBox = buildGoogleCloudVisionV1p3beta1BoundingPoly();
    o.confidence = 42.0;
    o.property = buildGoogleCloudVisionV1p3beta1TextAnnotationTextProperty();
    o.words = buildUnnamed6352();
  }
  buildCounterGoogleCloudVisionV1p3beta1Paragraph--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1Paragraph(
    api.GoogleCloudVisionV1p3beta1Paragraph o) {
  buildCounterGoogleCloudVisionV1p3beta1Paragraph++;
  if (buildCounterGoogleCloudVisionV1p3beta1Paragraph < 3) {
    checkGoogleCloudVisionV1p3beta1BoundingPoly(
        o.boundingBox! as api.GoogleCloudVisionV1p3beta1BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVisionV1p3beta1TextAnnotationTextProperty(o.property!
        as api.GoogleCloudVisionV1p3beta1TextAnnotationTextProperty);
    checkUnnamed6352(o.words!);
  }
  buildCounterGoogleCloudVisionV1p3beta1Paragraph--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1Position = 0;
api.GoogleCloudVisionV1p3beta1Position
    buildGoogleCloudVisionV1p3beta1Position() {
  var o = api.GoogleCloudVisionV1p3beta1Position();
  buildCounterGoogleCloudVisionV1p3beta1Position++;
  if (buildCounterGoogleCloudVisionV1p3beta1Position < 3) {
    o.x = 42.0;
    o.y = 42.0;
    o.z = 42.0;
  }
  buildCounterGoogleCloudVisionV1p3beta1Position--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1Position(
    api.GoogleCloudVisionV1p3beta1Position o) {
  buildCounterGoogleCloudVisionV1p3beta1Position++;
  if (buildCounterGoogleCloudVisionV1p3beta1Position < 3) {
    unittest.expect(
      o.x!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.y!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.z!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1Position--;
}

core.List<api.GoogleCloudVisionV1p3beta1ProductKeyValue> buildUnnamed6353() {
  var o = <api.GoogleCloudVisionV1p3beta1ProductKeyValue>[];
  o.add(buildGoogleCloudVisionV1p3beta1ProductKeyValue());
  o.add(buildGoogleCloudVisionV1p3beta1ProductKeyValue());
  return o;
}

void checkUnnamed6353(
    core.List<api.GoogleCloudVisionV1p3beta1ProductKeyValue> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1ProductKeyValue(
      o[0] as api.GoogleCloudVisionV1p3beta1ProductKeyValue);
  checkGoogleCloudVisionV1p3beta1ProductKeyValue(
      o[1] as api.GoogleCloudVisionV1p3beta1ProductKeyValue);
}

core.int buildCounterGoogleCloudVisionV1p3beta1Product = 0;
api.GoogleCloudVisionV1p3beta1Product buildGoogleCloudVisionV1p3beta1Product() {
  var o = api.GoogleCloudVisionV1p3beta1Product();
  buildCounterGoogleCloudVisionV1p3beta1Product++;
  if (buildCounterGoogleCloudVisionV1p3beta1Product < 3) {
    o.description = 'foo';
    o.displayName = 'foo';
    o.name = 'foo';
    o.productCategory = 'foo';
    o.productLabels = buildUnnamed6353();
  }
  buildCounterGoogleCloudVisionV1p3beta1Product--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1Product(
    api.GoogleCloudVisionV1p3beta1Product o) {
  buildCounterGoogleCloudVisionV1p3beta1Product++;
  if (buildCounterGoogleCloudVisionV1p3beta1Product < 3) {
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
      o.productCategory!,
      unittest.equals('foo'),
    );
    checkUnnamed6353(o.productLabels!);
  }
  buildCounterGoogleCloudVisionV1p3beta1Product--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1ProductKeyValue = 0;
api.GoogleCloudVisionV1p3beta1ProductKeyValue
    buildGoogleCloudVisionV1p3beta1ProductKeyValue() {
  var o = api.GoogleCloudVisionV1p3beta1ProductKeyValue();
  buildCounterGoogleCloudVisionV1p3beta1ProductKeyValue++;
  if (buildCounterGoogleCloudVisionV1p3beta1ProductKeyValue < 3) {
    o.key = 'foo';
    o.value = 'foo';
  }
  buildCounterGoogleCloudVisionV1p3beta1ProductKeyValue--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1ProductKeyValue(
    api.GoogleCloudVisionV1p3beta1ProductKeyValue o) {
  buildCounterGoogleCloudVisionV1p3beta1ProductKeyValue++;
  if (buildCounterGoogleCloudVisionV1p3beta1ProductKeyValue < 3) {
    unittest.expect(
      o.key!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1ProductKeyValue--;
}

core.List<api.GoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult>
    buildUnnamed6354() {
  var o = <api.GoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult>[];
  o.add(buildGoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult());
  o.add(buildGoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult());
  return o;
}

void checkUnnamed6354(
    core.List<api.GoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult(
      o[0] as api.GoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult);
  checkGoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult(
      o[1] as api.GoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult);
}

core.List<api.GoogleCloudVisionV1p3beta1ProductSearchResultsResult>
    buildUnnamed6355() {
  var o = <api.GoogleCloudVisionV1p3beta1ProductSearchResultsResult>[];
  o.add(buildGoogleCloudVisionV1p3beta1ProductSearchResultsResult());
  o.add(buildGoogleCloudVisionV1p3beta1ProductSearchResultsResult());
  return o;
}

void checkUnnamed6355(
    core.List<api.GoogleCloudVisionV1p3beta1ProductSearchResultsResult> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1ProductSearchResultsResult(
      o[0] as api.GoogleCloudVisionV1p3beta1ProductSearchResultsResult);
  checkGoogleCloudVisionV1p3beta1ProductSearchResultsResult(
      o[1] as api.GoogleCloudVisionV1p3beta1ProductSearchResultsResult);
}

core.int buildCounterGoogleCloudVisionV1p3beta1ProductSearchResults = 0;
api.GoogleCloudVisionV1p3beta1ProductSearchResults
    buildGoogleCloudVisionV1p3beta1ProductSearchResults() {
  var o = api.GoogleCloudVisionV1p3beta1ProductSearchResults();
  buildCounterGoogleCloudVisionV1p3beta1ProductSearchResults++;
  if (buildCounterGoogleCloudVisionV1p3beta1ProductSearchResults < 3) {
    o.indexTime = 'foo';
    o.productGroupedResults = buildUnnamed6354();
    o.results = buildUnnamed6355();
  }
  buildCounterGoogleCloudVisionV1p3beta1ProductSearchResults--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1ProductSearchResults(
    api.GoogleCloudVisionV1p3beta1ProductSearchResults o) {
  buildCounterGoogleCloudVisionV1p3beta1ProductSearchResults++;
  if (buildCounterGoogleCloudVisionV1p3beta1ProductSearchResults < 3) {
    unittest.expect(
      o.indexTime!,
      unittest.equals('foo'),
    );
    checkUnnamed6354(o.productGroupedResults!);
    checkUnnamed6355(o.results!);
  }
  buildCounterGoogleCloudVisionV1p3beta1ProductSearchResults--;
}

core.List<api.GoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation>
    buildUnnamed6356() {
  var o =
      <api.GoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation>[];
  o.add(buildGoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation());
  o.add(buildGoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation());
  return o;
}

void checkUnnamed6356(
    core.List<
            api.GoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation(o[0]
      as api.GoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation);
  checkGoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation(o[1]
      as api.GoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation);
}

core.List<api.GoogleCloudVisionV1p3beta1ProductSearchResultsResult>
    buildUnnamed6357() {
  var o = <api.GoogleCloudVisionV1p3beta1ProductSearchResultsResult>[];
  o.add(buildGoogleCloudVisionV1p3beta1ProductSearchResultsResult());
  o.add(buildGoogleCloudVisionV1p3beta1ProductSearchResultsResult());
  return o;
}

void checkUnnamed6357(
    core.List<api.GoogleCloudVisionV1p3beta1ProductSearchResultsResult> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1ProductSearchResultsResult(
      o[0] as api.GoogleCloudVisionV1p3beta1ProductSearchResultsResult);
  checkGoogleCloudVisionV1p3beta1ProductSearchResultsResult(
      o[1] as api.GoogleCloudVisionV1p3beta1ProductSearchResultsResult);
}

core.int
    buildCounterGoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult = 0;
api.GoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult
    buildGoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult() {
  var o = api.GoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult();
  buildCounterGoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult++;
  if (buildCounterGoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult <
      3) {
    o.boundingPoly = buildGoogleCloudVisionV1p3beta1BoundingPoly();
    o.objectAnnotations = buildUnnamed6356();
    o.results = buildUnnamed6357();
  }
  buildCounterGoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult(
    api.GoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult o) {
  buildCounterGoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult++;
  if (buildCounterGoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult <
      3) {
    checkGoogleCloudVisionV1p3beta1BoundingPoly(
        o.boundingPoly! as api.GoogleCloudVisionV1p3beta1BoundingPoly);
    checkUnnamed6356(o.objectAnnotations!);
    checkUnnamed6357(o.results!);
  }
  buildCounterGoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult--;
}

core.int
    buildCounterGoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation =
    0;
api.GoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation
    buildGoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation() {
  var o = api.GoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation();
  buildCounterGoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation++;
  if (buildCounterGoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation <
      3) {
    o.languageCode = 'foo';
    o.mid = 'foo';
    o.name = 'foo';
    o.score = 42.0;
  }
  buildCounterGoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation(
    api.GoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation o) {
  buildCounterGoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation++;
  if (buildCounterGoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation <
      3) {
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.mid!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1ProductSearchResultsResult = 0;
api.GoogleCloudVisionV1p3beta1ProductSearchResultsResult
    buildGoogleCloudVisionV1p3beta1ProductSearchResultsResult() {
  var o = api.GoogleCloudVisionV1p3beta1ProductSearchResultsResult();
  buildCounterGoogleCloudVisionV1p3beta1ProductSearchResultsResult++;
  if (buildCounterGoogleCloudVisionV1p3beta1ProductSearchResultsResult < 3) {
    o.image = 'foo';
    o.product = buildGoogleCloudVisionV1p3beta1Product();
    o.score = 42.0;
  }
  buildCounterGoogleCloudVisionV1p3beta1ProductSearchResultsResult--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1ProductSearchResultsResult(
    api.GoogleCloudVisionV1p3beta1ProductSearchResultsResult o) {
  buildCounterGoogleCloudVisionV1p3beta1ProductSearchResultsResult++;
  if (buildCounterGoogleCloudVisionV1p3beta1ProductSearchResultsResult < 3) {
    unittest.expect(
      o.image!,
      unittest.equals('foo'),
    );
    checkGoogleCloudVisionV1p3beta1Product(
        o.product! as api.GoogleCloudVisionV1p3beta1Product);
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1ProductSearchResultsResult--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1Property = 0;
api.GoogleCloudVisionV1p3beta1Property
    buildGoogleCloudVisionV1p3beta1Property() {
  var o = api.GoogleCloudVisionV1p3beta1Property();
  buildCounterGoogleCloudVisionV1p3beta1Property++;
  if (buildCounterGoogleCloudVisionV1p3beta1Property < 3) {
    o.name = 'foo';
    o.uint64Value = 'foo';
    o.value = 'foo';
  }
  buildCounterGoogleCloudVisionV1p3beta1Property--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1Property(
    api.GoogleCloudVisionV1p3beta1Property o) {
  buildCounterGoogleCloudVisionV1p3beta1Property++;
  if (buildCounterGoogleCloudVisionV1p3beta1Property < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.uint64Value!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1Property--;
}

core.List<api.GoogleCloudVisionV1p3beta1BoundingPoly> buildUnnamed6358() {
  var o = <api.GoogleCloudVisionV1p3beta1BoundingPoly>[];
  o.add(buildGoogleCloudVisionV1p3beta1BoundingPoly());
  o.add(buildGoogleCloudVisionV1p3beta1BoundingPoly());
  return o;
}

void checkUnnamed6358(core.List<api.GoogleCloudVisionV1p3beta1BoundingPoly> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1BoundingPoly(
      o[0] as api.GoogleCloudVisionV1p3beta1BoundingPoly);
  checkGoogleCloudVisionV1p3beta1BoundingPoly(
      o[1] as api.GoogleCloudVisionV1p3beta1BoundingPoly);
}

core.int buildCounterGoogleCloudVisionV1p3beta1ReferenceImage = 0;
api.GoogleCloudVisionV1p3beta1ReferenceImage
    buildGoogleCloudVisionV1p3beta1ReferenceImage() {
  var o = api.GoogleCloudVisionV1p3beta1ReferenceImage();
  buildCounterGoogleCloudVisionV1p3beta1ReferenceImage++;
  if (buildCounterGoogleCloudVisionV1p3beta1ReferenceImage < 3) {
    o.boundingPolys = buildUnnamed6358();
    o.name = 'foo';
    o.uri = 'foo';
  }
  buildCounterGoogleCloudVisionV1p3beta1ReferenceImage--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1ReferenceImage(
    api.GoogleCloudVisionV1p3beta1ReferenceImage o) {
  buildCounterGoogleCloudVisionV1p3beta1ReferenceImage++;
  if (buildCounterGoogleCloudVisionV1p3beta1ReferenceImage < 3) {
    checkUnnamed6358(o.boundingPolys!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1ReferenceImage--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1SafeSearchAnnotation = 0;
api.GoogleCloudVisionV1p3beta1SafeSearchAnnotation
    buildGoogleCloudVisionV1p3beta1SafeSearchAnnotation() {
  var o = api.GoogleCloudVisionV1p3beta1SafeSearchAnnotation();
  buildCounterGoogleCloudVisionV1p3beta1SafeSearchAnnotation++;
  if (buildCounterGoogleCloudVisionV1p3beta1SafeSearchAnnotation < 3) {
    o.adult = 'foo';
    o.medical = 'foo';
    o.racy = 'foo';
    o.spoof = 'foo';
    o.violence = 'foo';
  }
  buildCounterGoogleCloudVisionV1p3beta1SafeSearchAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1SafeSearchAnnotation(
    api.GoogleCloudVisionV1p3beta1SafeSearchAnnotation o) {
  buildCounterGoogleCloudVisionV1p3beta1SafeSearchAnnotation++;
  if (buildCounterGoogleCloudVisionV1p3beta1SafeSearchAnnotation < 3) {
    unittest.expect(
      o.adult!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.medical!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.racy!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.spoof!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.violence!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1SafeSearchAnnotation--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1Symbol = 0;
api.GoogleCloudVisionV1p3beta1Symbol buildGoogleCloudVisionV1p3beta1Symbol() {
  var o = api.GoogleCloudVisionV1p3beta1Symbol();
  buildCounterGoogleCloudVisionV1p3beta1Symbol++;
  if (buildCounterGoogleCloudVisionV1p3beta1Symbol < 3) {
    o.boundingBox = buildGoogleCloudVisionV1p3beta1BoundingPoly();
    o.confidence = 42.0;
    o.property = buildGoogleCloudVisionV1p3beta1TextAnnotationTextProperty();
    o.text = 'foo';
  }
  buildCounterGoogleCloudVisionV1p3beta1Symbol--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1Symbol(
    api.GoogleCloudVisionV1p3beta1Symbol o) {
  buildCounterGoogleCloudVisionV1p3beta1Symbol++;
  if (buildCounterGoogleCloudVisionV1p3beta1Symbol < 3) {
    checkGoogleCloudVisionV1p3beta1BoundingPoly(
        o.boundingBox! as api.GoogleCloudVisionV1p3beta1BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVisionV1p3beta1TextAnnotationTextProperty(o.property!
        as api.GoogleCloudVisionV1p3beta1TextAnnotationTextProperty);
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1Symbol--;
}

core.List<api.GoogleCloudVisionV1p3beta1Page> buildUnnamed6359() {
  var o = <api.GoogleCloudVisionV1p3beta1Page>[];
  o.add(buildGoogleCloudVisionV1p3beta1Page());
  o.add(buildGoogleCloudVisionV1p3beta1Page());
  return o;
}

void checkUnnamed6359(core.List<api.GoogleCloudVisionV1p3beta1Page> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1Page(
      o[0] as api.GoogleCloudVisionV1p3beta1Page);
  checkGoogleCloudVisionV1p3beta1Page(
      o[1] as api.GoogleCloudVisionV1p3beta1Page);
}

core.int buildCounterGoogleCloudVisionV1p3beta1TextAnnotation = 0;
api.GoogleCloudVisionV1p3beta1TextAnnotation
    buildGoogleCloudVisionV1p3beta1TextAnnotation() {
  var o = api.GoogleCloudVisionV1p3beta1TextAnnotation();
  buildCounterGoogleCloudVisionV1p3beta1TextAnnotation++;
  if (buildCounterGoogleCloudVisionV1p3beta1TextAnnotation < 3) {
    o.pages = buildUnnamed6359();
    o.text = 'foo';
  }
  buildCounterGoogleCloudVisionV1p3beta1TextAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1TextAnnotation(
    api.GoogleCloudVisionV1p3beta1TextAnnotation o) {
  buildCounterGoogleCloudVisionV1p3beta1TextAnnotation++;
  if (buildCounterGoogleCloudVisionV1p3beta1TextAnnotation < 3) {
    checkUnnamed6359(o.pages!);
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1TextAnnotation--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1TextAnnotationDetectedBreak = 0;
api.GoogleCloudVisionV1p3beta1TextAnnotationDetectedBreak
    buildGoogleCloudVisionV1p3beta1TextAnnotationDetectedBreak() {
  var o = api.GoogleCloudVisionV1p3beta1TextAnnotationDetectedBreak();
  buildCounterGoogleCloudVisionV1p3beta1TextAnnotationDetectedBreak++;
  if (buildCounterGoogleCloudVisionV1p3beta1TextAnnotationDetectedBreak < 3) {
    o.isPrefix = true;
    o.type = 'foo';
  }
  buildCounterGoogleCloudVisionV1p3beta1TextAnnotationDetectedBreak--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1TextAnnotationDetectedBreak(
    api.GoogleCloudVisionV1p3beta1TextAnnotationDetectedBreak o) {
  buildCounterGoogleCloudVisionV1p3beta1TextAnnotationDetectedBreak++;
  if (buildCounterGoogleCloudVisionV1p3beta1TextAnnotationDetectedBreak < 3) {
    unittest.expect(o.isPrefix!, unittest.isTrue);
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1TextAnnotationDetectedBreak--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage =
    0;
api.GoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage
    buildGoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage() {
  var o = api.GoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage();
  buildCounterGoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage++;
  if (buildCounterGoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage <
      3) {
    o.confidence = 42.0;
    o.languageCode = 'foo';
  }
  buildCounterGoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage(
    api.GoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage o) {
  buildCounterGoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage++;
  if (buildCounterGoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage <
      3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage--;
}

core.List<api.GoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage>
    buildUnnamed6360() {
  var o = <api.GoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage>[];
  o.add(buildGoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage());
  o.add(buildGoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage());
  return o;
}

void checkUnnamed6360(
    core.List<api.GoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage(
      o[0] as api.GoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage);
  checkGoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage(
      o[1] as api.GoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage);
}

core.int buildCounterGoogleCloudVisionV1p3beta1TextAnnotationTextProperty = 0;
api.GoogleCloudVisionV1p3beta1TextAnnotationTextProperty
    buildGoogleCloudVisionV1p3beta1TextAnnotationTextProperty() {
  var o = api.GoogleCloudVisionV1p3beta1TextAnnotationTextProperty();
  buildCounterGoogleCloudVisionV1p3beta1TextAnnotationTextProperty++;
  if (buildCounterGoogleCloudVisionV1p3beta1TextAnnotationTextProperty < 3) {
    o.detectedBreak =
        buildGoogleCloudVisionV1p3beta1TextAnnotationDetectedBreak();
    o.detectedLanguages = buildUnnamed6360();
  }
  buildCounterGoogleCloudVisionV1p3beta1TextAnnotationTextProperty--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1TextAnnotationTextProperty(
    api.GoogleCloudVisionV1p3beta1TextAnnotationTextProperty o) {
  buildCounterGoogleCloudVisionV1p3beta1TextAnnotationTextProperty++;
  if (buildCounterGoogleCloudVisionV1p3beta1TextAnnotationTextProperty < 3) {
    checkGoogleCloudVisionV1p3beta1TextAnnotationDetectedBreak(o.detectedBreak!
        as api.GoogleCloudVisionV1p3beta1TextAnnotationDetectedBreak);
    checkUnnamed6360(o.detectedLanguages!);
  }
  buildCounterGoogleCloudVisionV1p3beta1TextAnnotationTextProperty--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1Vertex = 0;
api.GoogleCloudVisionV1p3beta1Vertex buildGoogleCloudVisionV1p3beta1Vertex() {
  var o = api.GoogleCloudVisionV1p3beta1Vertex();
  buildCounterGoogleCloudVisionV1p3beta1Vertex++;
  if (buildCounterGoogleCloudVisionV1p3beta1Vertex < 3) {
    o.x = 42;
    o.y = 42;
  }
  buildCounterGoogleCloudVisionV1p3beta1Vertex--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1Vertex(
    api.GoogleCloudVisionV1p3beta1Vertex o) {
  buildCounterGoogleCloudVisionV1p3beta1Vertex++;
  if (buildCounterGoogleCloudVisionV1p3beta1Vertex < 3) {
    unittest.expect(
      o.x!,
      unittest.equals(42),
    );
    unittest.expect(
      o.y!,
      unittest.equals(42),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1Vertex--;
}

core.List<api.GoogleCloudVisionV1p3beta1WebDetectionWebLabel>
    buildUnnamed6361() {
  var o = <api.GoogleCloudVisionV1p3beta1WebDetectionWebLabel>[];
  o.add(buildGoogleCloudVisionV1p3beta1WebDetectionWebLabel());
  o.add(buildGoogleCloudVisionV1p3beta1WebDetectionWebLabel());
  return o;
}

void checkUnnamed6361(
    core.List<api.GoogleCloudVisionV1p3beta1WebDetectionWebLabel> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1WebDetectionWebLabel(
      o[0] as api.GoogleCloudVisionV1p3beta1WebDetectionWebLabel);
  checkGoogleCloudVisionV1p3beta1WebDetectionWebLabel(
      o[1] as api.GoogleCloudVisionV1p3beta1WebDetectionWebLabel);
}

core.List<api.GoogleCloudVisionV1p3beta1WebDetectionWebImage>
    buildUnnamed6362() {
  var o = <api.GoogleCloudVisionV1p3beta1WebDetectionWebImage>[];
  o.add(buildGoogleCloudVisionV1p3beta1WebDetectionWebImage());
  o.add(buildGoogleCloudVisionV1p3beta1WebDetectionWebImage());
  return o;
}

void checkUnnamed6362(
    core.List<api.GoogleCloudVisionV1p3beta1WebDetectionWebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1WebDetectionWebImage(
      o[0] as api.GoogleCloudVisionV1p3beta1WebDetectionWebImage);
  checkGoogleCloudVisionV1p3beta1WebDetectionWebImage(
      o[1] as api.GoogleCloudVisionV1p3beta1WebDetectionWebImage);
}

core.List<api.GoogleCloudVisionV1p3beta1WebDetectionWebPage>
    buildUnnamed6363() {
  var o = <api.GoogleCloudVisionV1p3beta1WebDetectionWebPage>[];
  o.add(buildGoogleCloudVisionV1p3beta1WebDetectionWebPage());
  o.add(buildGoogleCloudVisionV1p3beta1WebDetectionWebPage());
  return o;
}

void checkUnnamed6363(
    core.List<api.GoogleCloudVisionV1p3beta1WebDetectionWebPage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1WebDetectionWebPage(
      o[0] as api.GoogleCloudVisionV1p3beta1WebDetectionWebPage);
  checkGoogleCloudVisionV1p3beta1WebDetectionWebPage(
      o[1] as api.GoogleCloudVisionV1p3beta1WebDetectionWebPage);
}

core.List<api.GoogleCloudVisionV1p3beta1WebDetectionWebImage>
    buildUnnamed6364() {
  var o = <api.GoogleCloudVisionV1p3beta1WebDetectionWebImage>[];
  o.add(buildGoogleCloudVisionV1p3beta1WebDetectionWebImage());
  o.add(buildGoogleCloudVisionV1p3beta1WebDetectionWebImage());
  return o;
}

void checkUnnamed6364(
    core.List<api.GoogleCloudVisionV1p3beta1WebDetectionWebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1WebDetectionWebImage(
      o[0] as api.GoogleCloudVisionV1p3beta1WebDetectionWebImage);
  checkGoogleCloudVisionV1p3beta1WebDetectionWebImage(
      o[1] as api.GoogleCloudVisionV1p3beta1WebDetectionWebImage);
}

core.List<api.GoogleCloudVisionV1p3beta1WebDetectionWebImage>
    buildUnnamed6365() {
  var o = <api.GoogleCloudVisionV1p3beta1WebDetectionWebImage>[];
  o.add(buildGoogleCloudVisionV1p3beta1WebDetectionWebImage());
  o.add(buildGoogleCloudVisionV1p3beta1WebDetectionWebImage());
  return o;
}

void checkUnnamed6365(
    core.List<api.GoogleCloudVisionV1p3beta1WebDetectionWebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1WebDetectionWebImage(
      o[0] as api.GoogleCloudVisionV1p3beta1WebDetectionWebImage);
  checkGoogleCloudVisionV1p3beta1WebDetectionWebImage(
      o[1] as api.GoogleCloudVisionV1p3beta1WebDetectionWebImage);
}

core.List<api.GoogleCloudVisionV1p3beta1WebDetectionWebEntity>
    buildUnnamed6366() {
  var o = <api.GoogleCloudVisionV1p3beta1WebDetectionWebEntity>[];
  o.add(buildGoogleCloudVisionV1p3beta1WebDetectionWebEntity());
  o.add(buildGoogleCloudVisionV1p3beta1WebDetectionWebEntity());
  return o;
}

void checkUnnamed6366(
    core.List<api.GoogleCloudVisionV1p3beta1WebDetectionWebEntity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1WebDetectionWebEntity(
      o[0] as api.GoogleCloudVisionV1p3beta1WebDetectionWebEntity);
  checkGoogleCloudVisionV1p3beta1WebDetectionWebEntity(
      o[1] as api.GoogleCloudVisionV1p3beta1WebDetectionWebEntity);
}

core.int buildCounterGoogleCloudVisionV1p3beta1WebDetection = 0;
api.GoogleCloudVisionV1p3beta1WebDetection
    buildGoogleCloudVisionV1p3beta1WebDetection() {
  var o = api.GoogleCloudVisionV1p3beta1WebDetection();
  buildCounterGoogleCloudVisionV1p3beta1WebDetection++;
  if (buildCounterGoogleCloudVisionV1p3beta1WebDetection < 3) {
    o.bestGuessLabels = buildUnnamed6361();
    o.fullMatchingImages = buildUnnamed6362();
    o.pagesWithMatchingImages = buildUnnamed6363();
    o.partialMatchingImages = buildUnnamed6364();
    o.visuallySimilarImages = buildUnnamed6365();
    o.webEntities = buildUnnamed6366();
  }
  buildCounterGoogleCloudVisionV1p3beta1WebDetection--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1WebDetection(
    api.GoogleCloudVisionV1p3beta1WebDetection o) {
  buildCounterGoogleCloudVisionV1p3beta1WebDetection++;
  if (buildCounterGoogleCloudVisionV1p3beta1WebDetection < 3) {
    checkUnnamed6361(o.bestGuessLabels!);
    checkUnnamed6362(o.fullMatchingImages!);
    checkUnnamed6363(o.pagesWithMatchingImages!);
    checkUnnamed6364(o.partialMatchingImages!);
    checkUnnamed6365(o.visuallySimilarImages!);
    checkUnnamed6366(o.webEntities!);
  }
  buildCounterGoogleCloudVisionV1p3beta1WebDetection--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebEntity = 0;
api.GoogleCloudVisionV1p3beta1WebDetectionWebEntity
    buildGoogleCloudVisionV1p3beta1WebDetectionWebEntity() {
  var o = api.GoogleCloudVisionV1p3beta1WebDetectionWebEntity();
  buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebEntity++;
  if (buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebEntity < 3) {
    o.description = 'foo';
    o.entityId = 'foo';
    o.score = 42.0;
  }
  buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebEntity--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1WebDetectionWebEntity(
    api.GoogleCloudVisionV1p3beta1WebDetectionWebEntity o) {
  buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebEntity++;
  if (buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebEntity < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.entityId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebEntity--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebImage = 0;
api.GoogleCloudVisionV1p3beta1WebDetectionWebImage
    buildGoogleCloudVisionV1p3beta1WebDetectionWebImage() {
  var o = api.GoogleCloudVisionV1p3beta1WebDetectionWebImage();
  buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebImage++;
  if (buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebImage < 3) {
    o.score = 42.0;
    o.url = 'foo';
  }
  buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebImage--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1WebDetectionWebImage(
    api.GoogleCloudVisionV1p3beta1WebDetectionWebImage o) {
  buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebImage++;
  if (buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebImage < 3) {
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.url!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebImage--;
}

core.int buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebLabel = 0;
api.GoogleCloudVisionV1p3beta1WebDetectionWebLabel
    buildGoogleCloudVisionV1p3beta1WebDetectionWebLabel() {
  var o = api.GoogleCloudVisionV1p3beta1WebDetectionWebLabel();
  buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebLabel++;
  if (buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebLabel < 3) {
    o.label = 'foo';
    o.languageCode = 'foo';
  }
  buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebLabel--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1WebDetectionWebLabel(
    api.GoogleCloudVisionV1p3beta1WebDetectionWebLabel o) {
  buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebLabel++;
  if (buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebLabel < 3) {
    unittest.expect(
      o.label!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebLabel--;
}

core.List<api.GoogleCloudVisionV1p3beta1WebDetectionWebImage>
    buildUnnamed6367() {
  var o = <api.GoogleCloudVisionV1p3beta1WebDetectionWebImage>[];
  o.add(buildGoogleCloudVisionV1p3beta1WebDetectionWebImage());
  o.add(buildGoogleCloudVisionV1p3beta1WebDetectionWebImage());
  return o;
}

void checkUnnamed6367(
    core.List<api.GoogleCloudVisionV1p3beta1WebDetectionWebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1WebDetectionWebImage(
      o[0] as api.GoogleCloudVisionV1p3beta1WebDetectionWebImage);
  checkGoogleCloudVisionV1p3beta1WebDetectionWebImage(
      o[1] as api.GoogleCloudVisionV1p3beta1WebDetectionWebImage);
}

core.List<api.GoogleCloudVisionV1p3beta1WebDetectionWebImage>
    buildUnnamed6368() {
  var o = <api.GoogleCloudVisionV1p3beta1WebDetectionWebImage>[];
  o.add(buildGoogleCloudVisionV1p3beta1WebDetectionWebImage());
  o.add(buildGoogleCloudVisionV1p3beta1WebDetectionWebImage());
  return o;
}

void checkUnnamed6368(
    core.List<api.GoogleCloudVisionV1p3beta1WebDetectionWebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1WebDetectionWebImage(
      o[0] as api.GoogleCloudVisionV1p3beta1WebDetectionWebImage);
  checkGoogleCloudVisionV1p3beta1WebDetectionWebImage(
      o[1] as api.GoogleCloudVisionV1p3beta1WebDetectionWebImage);
}

core.int buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebPage = 0;
api.GoogleCloudVisionV1p3beta1WebDetectionWebPage
    buildGoogleCloudVisionV1p3beta1WebDetectionWebPage() {
  var o = api.GoogleCloudVisionV1p3beta1WebDetectionWebPage();
  buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebPage++;
  if (buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebPage < 3) {
    o.fullMatchingImages = buildUnnamed6367();
    o.pageTitle = 'foo';
    o.partialMatchingImages = buildUnnamed6368();
    o.score = 42.0;
    o.url = 'foo';
  }
  buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebPage--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1WebDetectionWebPage(
    api.GoogleCloudVisionV1p3beta1WebDetectionWebPage o) {
  buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebPage++;
  if (buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebPage < 3) {
    checkUnnamed6367(o.fullMatchingImages!);
    unittest.expect(
      o.pageTitle!,
      unittest.equals('foo'),
    );
    checkUnnamed6368(o.partialMatchingImages!);
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.url!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p3beta1WebDetectionWebPage--;
}

core.List<api.GoogleCloudVisionV1p3beta1Symbol> buildUnnamed6369() {
  var o = <api.GoogleCloudVisionV1p3beta1Symbol>[];
  o.add(buildGoogleCloudVisionV1p3beta1Symbol());
  o.add(buildGoogleCloudVisionV1p3beta1Symbol());
  return o;
}

void checkUnnamed6369(core.List<api.GoogleCloudVisionV1p3beta1Symbol> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p3beta1Symbol(
      o[0] as api.GoogleCloudVisionV1p3beta1Symbol);
  checkGoogleCloudVisionV1p3beta1Symbol(
      o[1] as api.GoogleCloudVisionV1p3beta1Symbol);
}

core.int buildCounterGoogleCloudVisionV1p3beta1Word = 0;
api.GoogleCloudVisionV1p3beta1Word buildGoogleCloudVisionV1p3beta1Word() {
  var o = api.GoogleCloudVisionV1p3beta1Word();
  buildCounterGoogleCloudVisionV1p3beta1Word++;
  if (buildCounterGoogleCloudVisionV1p3beta1Word < 3) {
    o.boundingBox = buildGoogleCloudVisionV1p3beta1BoundingPoly();
    o.confidence = 42.0;
    o.property = buildGoogleCloudVisionV1p3beta1TextAnnotationTextProperty();
    o.symbols = buildUnnamed6369();
  }
  buildCounterGoogleCloudVisionV1p3beta1Word--;
  return o;
}

void checkGoogleCloudVisionV1p3beta1Word(api.GoogleCloudVisionV1p3beta1Word o) {
  buildCounterGoogleCloudVisionV1p3beta1Word++;
  if (buildCounterGoogleCloudVisionV1p3beta1Word < 3) {
    checkGoogleCloudVisionV1p3beta1BoundingPoly(
        o.boundingBox! as api.GoogleCloudVisionV1p3beta1BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVisionV1p3beta1TextAnnotationTextProperty(o.property!
        as api.GoogleCloudVisionV1p3beta1TextAnnotationTextProperty);
    checkUnnamed6369(o.symbols!);
  }
  buildCounterGoogleCloudVisionV1p3beta1Word--;
}

core.List<api.GoogleCloudVisionV1p4beta1AnnotateImageResponse>
    buildUnnamed6370() {
  var o = <api.GoogleCloudVisionV1p4beta1AnnotateImageResponse>[];
  o.add(buildGoogleCloudVisionV1p4beta1AnnotateImageResponse());
  o.add(buildGoogleCloudVisionV1p4beta1AnnotateImageResponse());
  return o;
}

void checkUnnamed6370(
    core.List<api.GoogleCloudVisionV1p4beta1AnnotateImageResponse> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1AnnotateImageResponse(
      o[0] as api.GoogleCloudVisionV1p4beta1AnnotateImageResponse);
  checkGoogleCloudVisionV1p4beta1AnnotateImageResponse(
      o[1] as api.GoogleCloudVisionV1p4beta1AnnotateImageResponse);
}

core.int buildCounterGoogleCloudVisionV1p4beta1AnnotateFileResponse = 0;
api.GoogleCloudVisionV1p4beta1AnnotateFileResponse
    buildGoogleCloudVisionV1p4beta1AnnotateFileResponse() {
  var o = api.GoogleCloudVisionV1p4beta1AnnotateFileResponse();
  buildCounterGoogleCloudVisionV1p4beta1AnnotateFileResponse++;
  if (buildCounterGoogleCloudVisionV1p4beta1AnnotateFileResponse < 3) {
    o.error = buildStatus();
    o.inputConfig = buildGoogleCloudVisionV1p4beta1InputConfig();
    o.responses = buildUnnamed6370();
    o.totalPages = 42;
  }
  buildCounterGoogleCloudVisionV1p4beta1AnnotateFileResponse--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1AnnotateFileResponse(
    api.GoogleCloudVisionV1p4beta1AnnotateFileResponse o) {
  buildCounterGoogleCloudVisionV1p4beta1AnnotateFileResponse++;
  if (buildCounterGoogleCloudVisionV1p4beta1AnnotateFileResponse < 3) {
    checkStatus(o.error! as api.Status);
    checkGoogleCloudVisionV1p4beta1InputConfig(
        o.inputConfig! as api.GoogleCloudVisionV1p4beta1InputConfig);
    checkUnnamed6370(o.responses!);
    unittest.expect(
      o.totalPages!,
      unittest.equals(42),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1AnnotateFileResponse--;
}

core.List<api.GoogleCloudVisionV1p4beta1FaceAnnotation> buildUnnamed6371() {
  var o = <api.GoogleCloudVisionV1p4beta1FaceAnnotation>[];
  o.add(buildGoogleCloudVisionV1p4beta1FaceAnnotation());
  o.add(buildGoogleCloudVisionV1p4beta1FaceAnnotation());
  return o;
}

void checkUnnamed6371(
    core.List<api.GoogleCloudVisionV1p4beta1FaceAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1FaceAnnotation(
      o[0] as api.GoogleCloudVisionV1p4beta1FaceAnnotation);
  checkGoogleCloudVisionV1p4beta1FaceAnnotation(
      o[1] as api.GoogleCloudVisionV1p4beta1FaceAnnotation);
}

core.List<api.GoogleCloudVisionV1p4beta1EntityAnnotation> buildUnnamed6372() {
  var o = <api.GoogleCloudVisionV1p4beta1EntityAnnotation>[];
  o.add(buildGoogleCloudVisionV1p4beta1EntityAnnotation());
  o.add(buildGoogleCloudVisionV1p4beta1EntityAnnotation());
  return o;
}

void checkUnnamed6372(
    core.List<api.GoogleCloudVisionV1p4beta1EntityAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1EntityAnnotation(
      o[0] as api.GoogleCloudVisionV1p4beta1EntityAnnotation);
  checkGoogleCloudVisionV1p4beta1EntityAnnotation(
      o[1] as api.GoogleCloudVisionV1p4beta1EntityAnnotation);
}

core.List<api.GoogleCloudVisionV1p4beta1EntityAnnotation> buildUnnamed6373() {
  var o = <api.GoogleCloudVisionV1p4beta1EntityAnnotation>[];
  o.add(buildGoogleCloudVisionV1p4beta1EntityAnnotation());
  o.add(buildGoogleCloudVisionV1p4beta1EntityAnnotation());
  return o;
}

void checkUnnamed6373(
    core.List<api.GoogleCloudVisionV1p4beta1EntityAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1EntityAnnotation(
      o[0] as api.GoogleCloudVisionV1p4beta1EntityAnnotation);
  checkGoogleCloudVisionV1p4beta1EntityAnnotation(
      o[1] as api.GoogleCloudVisionV1p4beta1EntityAnnotation);
}

core.List<api.GoogleCloudVisionV1p4beta1LocalizedObjectAnnotation>
    buildUnnamed6374() {
  var o = <api.GoogleCloudVisionV1p4beta1LocalizedObjectAnnotation>[];
  o.add(buildGoogleCloudVisionV1p4beta1LocalizedObjectAnnotation());
  o.add(buildGoogleCloudVisionV1p4beta1LocalizedObjectAnnotation());
  return o;
}

void checkUnnamed6374(
    core.List<api.GoogleCloudVisionV1p4beta1LocalizedObjectAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1LocalizedObjectAnnotation(
      o[0] as api.GoogleCloudVisionV1p4beta1LocalizedObjectAnnotation);
  checkGoogleCloudVisionV1p4beta1LocalizedObjectAnnotation(
      o[1] as api.GoogleCloudVisionV1p4beta1LocalizedObjectAnnotation);
}

core.List<api.GoogleCloudVisionV1p4beta1EntityAnnotation> buildUnnamed6375() {
  var o = <api.GoogleCloudVisionV1p4beta1EntityAnnotation>[];
  o.add(buildGoogleCloudVisionV1p4beta1EntityAnnotation());
  o.add(buildGoogleCloudVisionV1p4beta1EntityAnnotation());
  return o;
}

void checkUnnamed6375(
    core.List<api.GoogleCloudVisionV1p4beta1EntityAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1EntityAnnotation(
      o[0] as api.GoogleCloudVisionV1p4beta1EntityAnnotation);
  checkGoogleCloudVisionV1p4beta1EntityAnnotation(
      o[1] as api.GoogleCloudVisionV1p4beta1EntityAnnotation);
}

core.List<api.GoogleCloudVisionV1p4beta1EntityAnnotation> buildUnnamed6376() {
  var o = <api.GoogleCloudVisionV1p4beta1EntityAnnotation>[];
  o.add(buildGoogleCloudVisionV1p4beta1EntityAnnotation());
  o.add(buildGoogleCloudVisionV1p4beta1EntityAnnotation());
  return o;
}

void checkUnnamed6376(
    core.List<api.GoogleCloudVisionV1p4beta1EntityAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1EntityAnnotation(
      o[0] as api.GoogleCloudVisionV1p4beta1EntityAnnotation);
  checkGoogleCloudVisionV1p4beta1EntityAnnotation(
      o[1] as api.GoogleCloudVisionV1p4beta1EntityAnnotation);
}

core.int buildCounterGoogleCloudVisionV1p4beta1AnnotateImageResponse = 0;
api.GoogleCloudVisionV1p4beta1AnnotateImageResponse
    buildGoogleCloudVisionV1p4beta1AnnotateImageResponse() {
  var o = api.GoogleCloudVisionV1p4beta1AnnotateImageResponse();
  buildCounterGoogleCloudVisionV1p4beta1AnnotateImageResponse++;
  if (buildCounterGoogleCloudVisionV1p4beta1AnnotateImageResponse < 3) {
    o.context = buildGoogleCloudVisionV1p4beta1ImageAnnotationContext();
    o.cropHintsAnnotation =
        buildGoogleCloudVisionV1p4beta1CropHintsAnnotation();
    o.error = buildStatus();
    o.faceAnnotations = buildUnnamed6371();
    o.fullTextAnnotation = buildGoogleCloudVisionV1p4beta1TextAnnotation();
    o.imagePropertiesAnnotation =
        buildGoogleCloudVisionV1p4beta1ImageProperties();
    o.labelAnnotations = buildUnnamed6372();
    o.landmarkAnnotations = buildUnnamed6373();
    o.localizedObjectAnnotations = buildUnnamed6374();
    o.logoAnnotations = buildUnnamed6375();
    o.productSearchResults =
        buildGoogleCloudVisionV1p4beta1ProductSearchResults();
    o.safeSearchAnnotation =
        buildGoogleCloudVisionV1p4beta1SafeSearchAnnotation();
    o.textAnnotations = buildUnnamed6376();
    o.webDetection = buildGoogleCloudVisionV1p4beta1WebDetection();
  }
  buildCounterGoogleCloudVisionV1p4beta1AnnotateImageResponse--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1AnnotateImageResponse(
    api.GoogleCloudVisionV1p4beta1AnnotateImageResponse o) {
  buildCounterGoogleCloudVisionV1p4beta1AnnotateImageResponse++;
  if (buildCounterGoogleCloudVisionV1p4beta1AnnotateImageResponse < 3) {
    checkGoogleCloudVisionV1p4beta1ImageAnnotationContext(
        o.context! as api.GoogleCloudVisionV1p4beta1ImageAnnotationContext);
    checkGoogleCloudVisionV1p4beta1CropHintsAnnotation(o.cropHintsAnnotation!
        as api.GoogleCloudVisionV1p4beta1CropHintsAnnotation);
    checkStatus(o.error! as api.Status);
    checkUnnamed6371(o.faceAnnotations!);
    checkGoogleCloudVisionV1p4beta1TextAnnotation(
        o.fullTextAnnotation! as api.GoogleCloudVisionV1p4beta1TextAnnotation);
    checkGoogleCloudVisionV1p4beta1ImageProperties(o.imagePropertiesAnnotation!
        as api.GoogleCloudVisionV1p4beta1ImageProperties);
    checkUnnamed6372(o.labelAnnotations!);
    checkUnnamed6373(o.landmarkAnnotations!);
    checkUnnamed6374(o.localizedObjectAnnotations!);
    checkUnnamed6375(o.logoAnnotations!);
    checkGoogleCloudVisionV1p4beta1ProductSearchResults(o.productSearchResults!
        as api.GoogleCloudVisionV1p4beta1ProductSearchResults);
    checkGoogleCloudVisionV1p4beta1SafeSearchAnnotation(o.safeSearchAnnotation!
        as api.GoogleCloudVisionV1p4beta1SafeSearchAnnotation);
    checkUnnamed6376(o.textAnnotations!);
    checkGoogleCloudVisionV1p4beta1WebDetection(
        o.webDetection! as api.GoogleCloudVisionV1p4beta1WebDetection);
  }
  buildCounterGoogleCloudVisionV1p4beta1AnnotateImageResponse--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse = 0;
api.GoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse
    buildGoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse() {
  var o = api.GoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse();
  buildCounterGoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse++;
  if (buildCounterGoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse < 3) {
    o.outputConfig = buildGoogleCloudVisionV1p4beta1OutputConfig();
  }
  buildCounterGoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse(
    api.GoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse o) {
  buildCounterGoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse++;
  if (buildCounterGoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse < 3) {
    checkGoogleCloudVisionV1p4beta1OutputConfig(
        o.outputConfig! as api.GoogleCloudVisionV1p4beta1OutputConfig);
  }
  buildCounterGoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse--;
}

core.List<api.GoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse>
    buildUnnamed6377() {
  var o = <api.GoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse>[];
  o.add(buildGoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse());
  o.add(buildGoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse());
  return o;
}

void checkUnnamed6377(
    core.List<api.GoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse(
      o[0] as api.GoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse);
  checkGoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse(
      o[1] as api.GoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse);
}

core.int buildCounterGoogleCloudVisionV1p4beta1AsyncBatchAnnotateFilesResponse =
    0;
api.GoogleCloudVisionV1p4beta1AsyncBatchAnnotateFilesResponse
    buildGoogleCloudVisionV1p4beta1AsyncBatchAnnotateFilesResponse() {
  var o = api.GoogleCloudVisionV1p4beta1AsyncBatchAnnotateFilesResponse();
  buildCounterGoogleCloudVisionV1p4beta1AsyncBatchAnnotateFilesResponse++;
  if (buildCounterGoogleCloudVisionV1p4beta1AsyncBatchAnnotateFilesResponse <
      3) {
    o.responses = buildUnnamed6377();
  }
  buildCounterGoogleCloudVisionV1p4beta1AsyncBatchAnnotateFilesResponse--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1AsyncBatchAnnotateFilesResponse(
    api.GoogleCloudVisionV1p4beta1AsyncBatchAnnotateFilesResponse o) {
  buildCounterGoogleCloudVisionV1p4beta1AsyncBatchAnnotateFilesResponse++;
  if (buildCounterGoogleCloudVisionV1p4beta1AsyncBatchAnnotateFilesResponse <
      3) {
    checkUnnamed6377(o.responses!);
  }
  buildCounterGoogleCloudVisionV1p4beta1AsyncBatchAnnotateFilesResponse--;
}

core.int
    buildCounterGoogleCloudVisionV1p4beta1AsyncBatchAnnotateImagesResponse = 0;
api.GoogleCloudVisionV1p4beta1AsyncBatchAnnotateImagesResponse
    buildGoogleCloudVisionV1p4beta1AsyncBatchAnnotateImagesResponse() {
  var o = api.GoogleCloudVisionV1p4beta1AsyncBatchAnnotateImagesResponse();
  buildCounterGoogleCloudVisionV1p4beta1AsyncBatchAnnotateImagesResponse++;
  if (buildCounterGoogleCloudVisionV1p4beta1AsyncBatchAnnotateImagesResponse <
      3) {
    o.outputConfig = buildGoogleCloudVisionV1p4beta1OutputConfig();
  }
  buildCounterGoogleCloudVisionV1p4beta1AsyncBatchAnnotateImagesResponse--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1AsyncBatchAnnotateImagesResponse(
    api.GoogleCloudVisionV1p4beta1AsyncBatchAnnotateImagesResponse o) {
  buildCounterGoogleCloudVisionV1p4beta1AsyncBatchAnnotateImagesResponse++;
  if (buildCounterGoogleCloudVisionV1p4beta1AsyncBatchAnnotateImagesResponse <
      3) {
    checkGoogleCloudVisionV1p4beta1OutputConfig(
        o.outputConfig! as api.GoogleCloudVisionV1p4beta1OutputConfig);
  }
  buildCounterGoogleCloudVisionV1p4beta1AsyncBatchAnnotateImagesResponse--;
}

core.List<api.GoogleCloudVisionV1p4beta1AnnotateFileResponse>
    buildUnnamed6378() {
  var o = <api.GoogleCloudVisionV1p4beta1AnnotateFileResponse>[];
  o.add(buildGoogleCloudVisionV1p4beta1AnnotateFileResponse());
  o.add(buildGoogleCloudVisionV1p4beta1AnnotateFileResponse());
  return o;
}

void checkUnnamed6378(
    core.List<api.GoogleCloudVisionV1p4beta1AnnotateFileResponse> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1AnnotateFileResponse(
      o[0] as api.GoogleCloudVisionV1p4beta1AnnotateFileResponse);
  checkGoogleCloudVisionV1p4beta1AnnotateFileResponse(
      o[1] as api.GoogleCloudVisionV1p4beta1AnnotateFileResponse);
}

core.int buildCounterGoogleCloudVisionV1p4beta1BatchAnnotateFilesResponse = 0;
api.GoogleCloudVisionV1p4beta1BatchAnnotateFilesResponse
    buildGoogleCloudVisionV1p4beta1BatchAnnotateFilesResponse() {
  var o = api.GoogleCloudVisionV1p4beta1BatchAnnotateFilesResponse();
  buildCounterGoogleCloudVisionV1p4beta1BatchAnnotateFilesResponse++;
  if (buildCounterGoogleCloudVisionV1p4beta1BatchAnnotateFilesResponse < 3) {
    o.responses = buildUnnamed6378();
  }
  buildCounterGoogleCloudVisionV1p4beta1BatchAnnotateFilesResponse--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1BatchAnnotateFilesResponse(
    api.GoogleCloudVisionV1p4beta1BatchAnnotateFilesResponse o) {
  buildCounterGoogleCloudVisionV1p4beta1BatchAnnotateFilesResponse++;
  if (buildCounterGoogleCloudVisionV1p4beta1BatchAnnotateFilesResponse < 3) {
    checkUnnamed6378(o.responses!);
  }
  buildCounterGoogleCloudVisionV1p4beta1BatchAnnotateFilesResponse--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1BatchOperationMetadata = 0;
api.GoogleCloudVisionV1p4beta1BatchOperationMetadata
    buildGoogleCloudVisionV1p4beta1BatchOperationMetadata() {
  var o = api.GoogleCloudVisionV1p4beta1BatchOperationMetadata();
  buildCounterGoogleCloudVisionV1p4beta1BatchOperationMetadata++;
  if (buildCounterGoogleCloudVisionV1p4beta1BatchOperationMetadata < 3) {
    o.endTime = 'foo';
    o.state = 'foo';
    o.submitTime = 'foo';
  }
  buildCounterGoogleCloudVisionV1p4beta1BatchOperationMetadata--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1BatchOperationMetadata(
    api.GoogleCloudVisionV1p4beta1BatchOperationMetadata o) {
  buildCounterGoogleCloudVisionV1p4beta1BatchOperationMetadata++;
  if (buildCounterGoogleCloudVisionV1p4beta1BatchOperationMetadata < 3) {
    unittest.expect(
      o.endTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.state!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.submitTime!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1BatchOperationMetadata--;
}

core.List<api.GoogleCloudVisionV1p4beta1Paragraph> buildUnnamed6379() {
  var o = <api.GoogleCloudVisionV1p4beta1Paragraph>[];
  o.add(buildGoogleCloudVisionV1p4beta1Paragraph());
  o.add(buildGoogleCloudVisionV1p4beta1Paragraph());
  return o;
}

void checkUnnamed6379(core.List<api.GoogleCloudVisionV1p4beta1Paragraph> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1Paragraph(
      o[0] as api.GoogleCloudVisionV1p4beta1Paragraph);
  checkGoogleCloudVisionV1p4beta1Paragraph(
      o[1] as api.GoogleCloudVisionV1p4beta1Paragraph);
}

core.int buildCounterGoogleCloudVisionV1p4beta1Block = 0;
api.GoogleCloudVisionV1p4beta1Block buildGoogleCloudVisionV1p4beta1Block() {
  var o = api.GoogleCloudVisionV1p4beta1Block();
  buildCounterGoogleCloudVisionV1p4beta1Block++;
  if (buildCounterGoogleCloudVisionV1p4beta1Block < 3) {
    o.blockType = 'foo';
    o.boundingBox = buildGoogleCloudVisionV1p4beta1BoundingPoly();
    o.confidence = 42.0;
    o.paragraphs = buildUnnamed6379();
    o.property = buildGoogleCloudVisionV1p4beta1TextAnnotationTextProperty();
  }
  buildCounterGoogleCloudVisionV1p4beta1Block--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1Block(
    api.GoogleCloudVisionV1p4beta1Block o) {
  buildCounterGoogleCloudVisionV1p4beta1Block++;
  if (buildCounterGoogleCloudVisionV1p4beta1Block < 3) {
    unittest.expect(
      o.blockType!,
      unittest.equals('foo'),
    );
    checkGoogleCloudVisionV1p4beta1BoundingPoly(
        o.boundingBox! as api.GoogleCloudVisionV1p4beta1BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkUnnamed6379(o.paragraphs!);
    checkGoogleCloudVisionV1p4beta1TextAnnotationTextProperty(o.property!
        as api.GoogleCloudVisionV1p4beta1TextAnnotationTextProperty);
  }
  buildCounterGoogleCloudVisionV1p4beta1Block--;
}

core.List<api.GoogleCloudVisionV1p4beta1NormalizedVertex> buildUnnamed6380() {
  var o = <api.GoogleCloudVisionV1p4beta1NormalizedVertex>[];
  o.add(buildGoogleCloudVisionV1p4beta1NormalizedVertex());
  o.add(buildGoogleCloudVisionV1p4beta1NormalizedVertex());
  return o;
}

void checkUnnamed6380(
    core.List<api.GoogleCloudVisionV1p4beta1NormalizedVertex> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1NormalizedVertex(
      o[0] as api.GoogleCloudVisionV1p4beta1NormalizedVertex);
  checkGoogleCloudVisionV1p4beta1NormalizedVertex(
      o[1] as api.GoogleCloudVisionV1p4beta1NormalizedVertex);
}

core.List<api.GoogleCloudVisionV1p4beta1Vertex> buildUnnamed6381() {
  var o = <api.GoogleCloudVisionV1p4beta1Vertex>[];
  o.add(buildGoogleCloudVisionV1p4beta1Vertex());
  o.add(buildGoogleCloudVisionV1p4beta1Vertex());
  return o;
}

void checkUnnamed6381(core.List<api.GoogleCloudVisionV1p4beta1Vertex> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1Vertex(
      o[0] as api.GoogleCloudVisionV1p4beta1Vertex);
  checkGoogleCloudVisionV1p4beta1Vertex(
      o[1] as api.GoogleCloudVisionV1p4beta1Vertex);
}

core.int buildCounterGoogleCloudVisionV1p4beta1BoundingPoly = 0;
api.GoogleCloudVisionV1p4beta1BoundingPoly
    buildGoogleCloudVisionV1p4beta1BoundingPoly() {
  var o = api.GoogleCloudVisionV1p4beta1BoundingPoly();
  buildCounterGoogleCloudVisionV1p4beta1BoundingPoly++;
  if (buildCounterGoogleCloudVisionV1p4beta1BoundingPoly < 3) {
    o.normalizedVertices = buildUnnamed6380();
    o.vertices = buildUnnamed6381();
  }
  buildCounterGoogleCloudVisionV1p4beta1BoundingPoly--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1BoundingPoly(
    api.GoogleCloudVisionV1p4beta1BoundingPoly o) {
  buildCounterGoogleCloudVisionV1p4beta1BoundingPoly++;
  if (buildCounterGoogleCloudVisionV1p4beta1BoundingPoly < 3) {
    checkUnnamed6380(o.normalizedVertices!);
    checkUnnamed6381(o.vertices!);
  }
  buildCounterGoogleCloudVisionV1p4beta1BoundingPoly--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1Celebrity = 0;
api.GoogleCloudVisionV1p4beta1Celebrity
    buildGoogleCloudVisionV1p4beta1Celebrity() {
  var o = api.GoogleCloudVisionV1p4beta1Celebrity();
  buildCounterGoogleCloudVisionV1p4beta1Celebrity++;
  if (buildCounterGoogleCloudVisionV1p4beta1Celebrity < 3) {
    o.description = 'foo';
    o.displayName = 'foo';
    o.name = 'foo';
  }
  buildCounterGoogleCloudVisionV1p4beta1Celebrity--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1Celebrity(
    api.GoogleCloudVisionV1p4beta1Celebrity o) {
  buildCounterGoogleCloudVisionV1p4beta1Celebrity++;
  if (buildCounterGoogleCloudVisionV1p4beta1Celebrity < 3) {
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
  buildCounterGoogleCloudVisionV1p4beta1Celebrity--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1ColorInfo = 0;
api.GoogleCloudVisionV1p4beta1ColorInfo
    buildGoogleCloudVisionV1p4beta1ColorInfo() {
  var o = api.GoogleCloudVisionV1p4beta1ColorInfo();
  buildCounterGoogleCloudVisionV1p4beta1ColorInfo++;
  if (buildCounterGoogleCloudVisionV1p4beta1ColorInfo < 3) {
    o.color = buildColor();
    o.pixelFraction = 42.0;
    o.score = 42.0;
  }
  buildCounterGoogleCloudVisionV1p4beta1ColorInfo--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1ColorInfo(
    api.GoogleCloudVisionV1p4beta1ColorInfo o) {
  buildCounterGoogleCloudVisionV1p4beta1ColorInfo++;
  if (buildCounterGoogleCloudVisionV1p4beta1ColorInfo < 3) {
    checkColor(o.color! as api.Color);
    unittest.expect(
      o.pixelFraction!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1ColorInfo--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1CropHint = 0;
api.GoogleCloudVisionV1p4beta1CropHint
    buildGoogleCloudVisionV1p4beta1CropHint() {
  var o = api.GoogleCloudVisionV1p4beta1CropHint();
  buildCounterGoogleCloudVisionV1p4beta1CropHint++;
  if (buildCounterGoogleCloudVisionV1p4beta1CropHint < 3) {
    o.boundingPoly = buildGoogleCloudVisionV1p4beta1BoundingPoly();
    o.confidence = 42.0;
    o.importanceFraction = 42.0;
  }
  buildCounterGoogleCloudVisionV1p4beta1CropHint--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1CropHint(
    api.GoogleCloudVisionV1p4beta1CropHint o) {
  buildCounterGoogleCloudVisionV1p4beta1CropHint++;
  if (buildCounterGoogleCloudVisionV1p4beta1CropHint < 3) {
    checkGoogleCloudVisionV1p4beta1BoundingPoly(
        o.boundingPoly! as api.GoogleCloudVisionV1p4beta1BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.importanceFraction!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1CropHint--;
}

core.List<api.GoogleCloudVisionV1p4beta1CropHint> buildUnnamed6382() {
  var o = <api.GoogleCloudVisionV1p4beta1CropHint>[];
  o.add(buildGoogleCloudVisionV1p4beta1CropHint());
  o.add(buildGoogleCloudVisionV1p4beta1CropHint());
  return o;
}

void checkUnnamed6382(core.List<api.GoogleCloudVisionV1p4beta1CropHint> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1CropHint(
      o[0] as api.GoogleCloudVisionV1p4beta1CropHint);
  checkGoogleCloudVisionV1p4beta1CropHint(
      o[1] as api.GoogleCloudVisionV1p4beta1CropHint);
}

core.int buildCounterGoogleCloudVisionV1p4beta1CropHintsAnnotation = 0;
api.GoogleCloudVisionV1p4beta1CropHintsAnnotation
    buildGoogleCloudVisionV1p4beta1CropHintsAnnotation() {
  var o = api.GoogleCloudVisionV1p4beta1CropHintsAnnotation();
  buildCounterGoogleCloudVisionV1p4beta1CropHintsAnnotation++;
  if (buildCounterGoogleCloudVisionV1p4beta1CropHintsAnnotation < 3) {
    o.cropHints = buildUnnamed6382();
  }
  buildCounterGoogleCloudVisionV1p4beta1CropHintsAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1CropHintsAnnotation(
    api.GoogleCloudVisionV1p4beta1CropHintsAnnotation o) {
  buildCounterGoogleCloudVisionV1p4beta1CropHintsAnnotation++;
  if (buildCounterGoogleCloudVisionV1p4beta1CropHintsAnnotation < 3) {
    checkUnnamed6382(o.cropHints!);
  }
  buildCounterGoogleCloudVisionV1p4beta1CropHintsAnnotation--;
}

core.List<api.GoogleCloudVisionV1p4beta1ColorInfo> buildUnnamed6383() {
  var o = <api.GoogleCloudVisionV1p4beta1ColorInfo>[];
  o.add(buildGoogleCloudVisionV1p4beta1ColorInfo());
  o.add(buildGoogleCloudVisionV1p4beta1ColorInfo());
  return o;
}

void checkUnnamed6383(core.List<api.GoogleCloudVisionV1p4beta1ColorInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1ColorInfo(
      o[0] as api.GoogleCloudVisionV1p4beta1ColorInfo);
  checkGoogleCloudVisionV1p4beta1ColorInfo(
      o[1] as api.GoogleCloudVisionV1p4beta1ColorInfo);
}

core.int buildCounterGoogleCloudVisionV1p4beta1DominantColorsAnnotation = 0;
api.GoogleCloudVisionV1p4beta1DominantColorsAnnotation
    buildGoogleCloudVisionV1p4beta1DominantColorsAnnotation() {
  var o = api.GoogleCloudVisionV1p4beta1DominantColorsAnnotation();
  buildCounterGoogleCloudVisionV1p4beta1DominantColorsAnnotation++;
  if (buildCounterGoogleCloudVisionV1p4beta1DominantColorsAnnotation < 3) {
    o.colors = buildUnnamed6383();
  }
  buildCounterGoogleCloudVisionV1p4beta1DominantColorsAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1DominantColorsAnnotation(
    api.GoogleCloudVisionV1p4beta1DominantColorsAnnotation o) {
  buildCounterGoogleCloudVisionV1p4beta1DominantColorsAnnotation++;
  if (buildCounterGoogleCloudVisionV1p4beta1DominantColorsAnnotation < 3) {
    checkUnnamed6383(o.colors!);
  }
  buildCounterGoogleCloudVisionV1p4beta1DominantColorsAnnotation--;
}

core.List<api.GoogleCloudVisionV1p4beta1LocationInfo> buildUnnamed6384() {
  var o = <api.GoogleCloudVisionV1p4beta1LocationInfo>[];
  o.add(buildGoogleCloudVisionV1p4beta1LocationInfo());
  o.add(buildGoogleCloudVisionV1p4beta1LocationInfo());
  return o;
}

void checkUnnamed6384(core.List<api.GoogleCloudVisionV1p4beta1LocationInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1LocationInfo(
      o[0] as api.GoogleCloudVisionV1p4beta1LocationInfo);
  checkGoogleCloudVisionV1p4beta1LocationInfo(
      o[1] as api.GoogleCloudVisionV1p4beta1LocationInfo);
}

core.List<api.GoogleCloudVisionV1p4beta1Property> buildUnnamed6385() {
  var o = <api.GoogleCloudVisionV1p4beta1Property>[];
  o.add(buildGoogleCloudVisionV1p4beta1Property());
  o.add(buildGoogleCloudVisionV1p4beta1Property());
  return o;
}

void checkUnnamed6385(core.List<api.GoogleCloudVisionV1p4beta1Property> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1Property(
      o[0] as api.GoogleCloudVisionV1p4beta1Property);
  checkGoogleCloudVisionV1p4beta1Property(
      o[1] as api.GoogleCloudVisionV1p4beta1Property);
}

core.int buildCounterGoogleCloudVisionV1p4beta1EntityAnnotation = 0;
api.GoogleCloudVisionV1p4beta1EntityAnnotation
    buildGoogleCloudVisionV1p4beta1EntityAnnotation() {
  var o = api.GoogleCloudVisionV1p4beta1EntityAnnotation();
  buildCounterGoogleCloudVisionV1p4beta1EntityAnnotation++;
  if (buildCounterGoogleCloudVisionV1p4beta1EntityAnnotation < 3) {
    o.boundingPoly = buildGoogleCloudVisionV1p4beta1BoundingPoly();
    o.confidence = 42.0;
    o.description = 'foo';
    o.locale = 'foo';
    o.locations = buildUnnamed6384();
    o.mid = 'foo';
    o.properties = buildUnnamed6385();
    o.score = 42.0;
    o.topicality = 42.0;
  }
  buildCounterGoogleCloudVisionV1p4beta1EntityAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1EntityAnnotation(
    api.GoogleCloudVisionV1p4beta1EntityAnnotation o) {
  buildCounterGoogleCloudVisionV1p4beta1EntityAnnotation++;
  if (buildCounterGoogleCloudVisionV1p4beta1EntityAnnotation < 3) {
    checkGoogleCloudVisionV1p4beta1BoundingPoly(
        o.boundingPoly! as api.GoogleCloudVisionV1p4beta1BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.locale!,
      unittest.equals('foo'),
    );
    checkUnnamed6384(o.locations!);
    unittest.expect(
      o.mid!,
      unittest.equals('foo'),
    );
    checkUnnamed6385(o.properties!);
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.topicality!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1EntityAnnotation--;
}

core.List<api.GoogleCloudVisionV1p4beta1FaceAnnotationLandmark>
    buildUnnamed6386() {
  var o = <api.GoogleCloudVisionV1p4beta1FaceAnnotationLandmark>[];
  o.add(buildGoogleCloudVisionV1p4beta1FaceAnnotationLandmark());
  o.add(buildGoogleCloudVisionV1p4beta1FaceAnnotationLandmark());
  return o;
}

void checkUnnamed6386(
    core.List<api.GoogleCloudVisionV1p4beta1FaceAnnotationLandmark> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1FaceAnnotationLandmark(
      o[0] as api.GoogleCloudVisionV1p4beta1FaceAnnotationLandmark);
  checkGoogleCloudVisionV1p4beta1FaceAnnotationLandmark(
      o[1] as api.GoogleCloudVisionV1p4beta1FaceAnnotationLandmark);
}

core.List<api.GoogleCloudVisionV1p4beta1FaceRecognitionResult>
    buildUnnamed6387() {
  var o = <api.GoogleCloudVisionV1p4beta1FaceRecognitionResult>[];
  o.add(buildGoogleCloudVisionV1p4beta1FaceRecognitionResult());
  o.add(buildGoogleCloudVisionV1p4beta1FaceRecognitionResult());
  return o;
}

void checkUnnamed6387(
    core.List<api.GoogleCloudVisionV1p4beta1FaceRecognitionResult> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1FaceRecognitionResult(
      o[0] as api.GoogleCloudVisionV1p4beta1FaceRecognitionResult);
  checkGoogleCloudVisionV1p4beta1FaceRecognitionResult(
      o[1] as api.GoogleCloudVisionV1p4beta1FaceRecognitionResult);
}

core.int buildCounterGoogleCloudVisionV1p4beta1FaceAnnotation = 0;
api.GoogleCloudVisionV1p4beta1FaceAnnotation
    buildGoogleCloudVisionV1p4beta1FaceAnnotation() {
  var o = api.GoogleCloudVisionV1p4beta1FaceAnnotation();
  buildCounterGoogleCloudVisionV1p4beta1FaceAnnotation++;
  if (buildCounterGoogleCloudVisionV1p4beta1FaceAnnotation < 3) {
    o.angerLikelihood = 'foo';
    o.blurredLikelihood = 'foo';
    o.boundingPoly = buildGoogleCloudVisionV1p4beta1BoundingPoly();
    o.detectionConfidence = 42.0;
    o.fdBoundingPoly = buildGoogleCloudVisionV1p4beta1BoundingPoly();
    o.headwearLikelihood = 'foo';
    o.joyLikelihood = 'foo';
    o.landmarkingConfidence = 42.0;
    o.landmarks = buildUnnamed6386();
    o.panAngle = 42.0;
    o.recognitionResult = buildUnnamed6387();
    o.rollAngle = 42.0;
    o.sorrowLikelihood = 'foo';
    o.surpriseLikelihood = 'foo';
    o.tiltAngle = 42.0;
    o.underExposedLikelihood = 'foo';
  }
  buildCounterGoogleCloudVisionV1p4beta1FaceAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1FaceAnnotation(
    api.GoogleCloudVisionV1p4beta1FaceAnnotation o) {
  buildCounterGoogleCloudVisionV1p4beta1FaceAnnotation++;
  if (buildCounterGoogleCloudVisionV1p4beta1FaceAnnotation < 3) {
    unittest.expect(
      o.angerLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.blurredLikelihood!,
      unittest.equals('foo'),
    );
    checkGoogleCloudVisionV1p4beta1BoundingPoly(
        o.boundingPoly! as api.GoogleCloudVisionV1p4beta1BoundingPoly);
    unittest.expect(
      o.detectionConfidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVisionV1p4beta1BoundingPoly(
        o.fdBoundingPoly! as api.GoogleCloudVisionV1p4beta1BoundingPoly);
    unittest.expect(
      o.headwearLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.joyLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.landmarkingConfidence!,
      unittest.equals(42.0),
    );
    checkUnnamed6386(o.landmarks!);
    unittest.expect(
      o.panAngle!,
      unittest.equals(42.0),
    );
    checkUnnamed6387(o.recognitionResult!);
    unittest.expect(
      o.rollAngle!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.sorrowLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.surpriseLikelihood!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.tiltAngle!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.underExposedLikelihood!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1FaceAnnotation--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1FaceAnnotationLandmark = 0;
api.GoogleCloudVisionV1p4beta1FaceAnnotationLandmark
    buildGoogleCloudVisionV1p4beta1FaceAnnotationLandmark() {
  var o = api.GoogleCloudVisionV1p4beta1FaceAnnotationLandmark();
  buildCounterGoogleCloudVisionV1p4beta1FaceAnnotationLandmark++;
  if (buildCounterGoogleCloudVisionV1p4beta1FaceAnnotationLandmark < 3) {
    o.position = buildGoogleCloudVisionV1p4beta1Position();
    o.type = 'foo';
  }
  buildCounterGoogleCloudVisionV1p4beta1FaceAnnotationLandmark--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1FaceAnnotationLandmark(
    api.GoogleCloudVisionV1p4beta1FaceAnnotationLandmark o) {
  buildCounterGoogleCloudVisionV1p4beta1FaceAnnotationLandmark++;
  if (buildCounterGoogleCloudVisionV1p4beta1FaceAnnotationLandmark < 3) {
    checkGoogleCloudVisionV1p4beta1Position(
        o.position! as api.GoogleCloudVisionV1p4beta1Position);
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1FaceAnnotationLandmark--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1FaceRecognitionResult = 0;
api.GoogleCloudVisionV1p4beta1FaceRecognitionResult
    buildGoogleCloudVisionV1p4beta1FaceRecognitionResult() {
  var o = api.GoogleCloudVisionV1p4beta1FaceRecognitionResult();
  buildCounterGoogleCloudVisionV1p4beta1FaceRecognitionResult++;
  if (buildCounterGoogleCloudVisionV1p4beta1FaceRecognitionResult < 3) {
    o.celebrity = buildGoogleCloudVisionV1p4beta1Celebrity();
    o.confidence = 42.0;
  }
  buildCounterGoogleCloudVisionV1p4beta1FaceRecognitionResult--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1FaceRecognitionResult(
    api.GoogleCloudVisionV1p4beta1FaceRecognitionResult o) {
  buildCounterGoogleCloudVisionV1p4beta1FaceRecognitionResult++;
  if (buildCounterGoogleCloudVisionV1p4beta1FaceRecognitionResult < 3) {
    checkGoogleCloudVisionV1p4beta1Celebrity(
        o.celebrity! as api.GoogleCloudVisionV1p4beta1Celebrity);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1FaceRecognitionResult--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1GcsDestination = 0;
api.GoogleCloudVisionV1p4beta1GcsDestination
    buildGoogleCloudVisionV1p4beta1GcsDestination() {
  var o = api.GoogleCloudVisionV1p4beta1GcsDestination();
  buildCounterGoogleCloudVisionV1p4beta1GcsDestination++;
  if (buildCounterGoogleCloudVisionV1p4beta1GcsDestination < 3) {
    o.uri = 'foo';
  }
  buildCounterGoogleCloudVisionV1p4beta1GcsDestination--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1GcsDestination(
    api.GoogleCloudVisionV1p4beta1GcsDestination o) {
  buildCounterGoogleCloudVisionV1p4beta1GcsDestination++;
  if (buildCounterGoogleCloudVisionV1p4beta1GcsDestination < 3) {
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1GcsDestination--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1GcsSource = 0;
api.GoogleCloudVisionV1p4beta1GcsSource
    buildGoogleCloudVisionV1p4beta1GcsSource() {
  var o = api.GoogleCloudVisionV1p4beta1GcsSource();
  buildCounterGoogleCloudVisionV1p4beta1GcsSource++;
  if (buildCounterGoogleCloudVisionV1p4beta1GcsSource < 3) {
    o.uri = 'foo';
  }
  buildCounterGoogleCloudVisionV1p4beta1GcsSource--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1GcsSource(
    api.GoogleCloudVisionV1p4beta1GcsSource o) {
  buildCounterGoogleCloudVisionV1p4beta1GcsSource++;
  if (buildCounterGoogleCloudVisionV1p4beta1GcsSource < 3) {
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1GcsSource--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1ImageAnnotationContext = 0;
api.GoogleCloudVisionV1p4beta1ImageAnnotationContext
    buildGoogleCloudVisionV1p4beta1ImageAnnotationContext() {
  var o = api.GoogleCloudVisionV1p4beta1ImageAnnotationContext();
  buildCounterGoogleCloudVisionV1p4beta1ImageAnnotationContext++;
  if (buildCounterGoogleCloudVisionV1p4beta1ImageAnnotationContext < 3) {
    o.pageNumber = 42;
    o.uri = 'foo';
  }
  buildCounterGoogleCloudVisionV1p4beta1ImageAnnotationContext--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1ImageAnnotationContext(
    api.GoogleCloudVisionV1p4beta1ImageAnnotationContext o) {
  buildCounterGoogleCloudVisionV1p4beta1ImageAnnotationContext++;
  if (buildCounterGoogleCloudVisionV1p4beta1ImageAnnotationContext < 3) {
    unittest.expect(
      o.pageNumber!,
      unittest.equals(42),
    );
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1ImageAnnotationContext--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1ImageProperties = 0;
api.GoogleCloudVisionV1p4beta1ImageProperties
    buildGoogleCloudVisionV1p4beta1ImageProperties() {
  var o = api.GoogleCloudVisionV1p4beta1ImageProperties();
  buildCounterGoogleCloudVisionV1p4beta1ImageProperties++;
  if (buildCounterGoogleCloudVisionV1p4beta1ImageProperties < 3) {
    o.dominantColors =
        buildGoogleCloudVisionV1p4beta1DominantColorsAnnotation();
  }
  buildCounterGoogleCloudVisionV1p4beta1ImageProperties--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1ImageProperties(
    api.GoogleCloudVisionV1p4beta1ImageProperties o) {
  buildCounterGoogleCloudVisionV1p4beta1ImageProperties++;
  if (buildCounterGoogleCloudVisionV1p4beta1ImageProperties < 3) {
    checkGoogleCloudVisionV1p4beta1DominantColorsAnnotation(o.dominantColors!
        as api.GoogleCloudVisionV1p4beta1DominantColorsAnnotation);
  }
  buildCounterGoogleCloudVisionV1p4beta1ImageProperties--;
}

core.List<api.GoogleCloudVisionV1p4beta1ReferenceImage> buildUnnamed6388() {
  var o = <api.GoogleCloudVisionV1p4beta1ReferenceImage>[];
  o.add(buildGoogleCloudVisionV1p4beta1ReferenceImage());
  o.add(buildGoogleCloudVisionV1p4beta1ReferenceImage());
  return o;
}

void checkUnnamed6388(
    core.List<api.GoogleCloudVisionV1p4beta1ReferenceImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1ReferenceImage(
      o[0] as api.GoogleCloudVisionV1p4beta1ReferenceImage);
  checkGoogleCloudVisionV1p4beta1ReferenceImage(
      o[1] as api.GoogleCloudVisionV1p4beta1ReferenceImage);
}

core.List<api.Status> buildUnnamed6389() {
  var o = <api.Status>[];
  o.add(buildStatus());
  o.add(buildStatus());
  return o;
}

void checkUnnamed6389(core.List<api.Status> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkStatus(o[0] as api.Status);
  checkStatus(o[1] as api.Status);
}

core.int buildCounterGoogleCloudVisionV1p4beta1ImportProductSetsResponse = 0;
api.GoogleCloudVisionV1p4beta1ImportProductSetsResponse
    buildGoogleCloudVisionV1p4beta1ImportProductSetsResponse() {
  var o = api.GoogleCloudVisionV1p4beta1ImportProductSetsResponse();
  buildCounterGoogleCloudVisionV1p4beta1ImportProductSetsResponse++;
  if (buildCounterGoogleCloudVisionV1p4beta1ImportProductSetsResponse < 3) {
    o.referenceImages = buildUnnamed6388();
    o.statuses = buildUnnamed6389();
  }
  buildCounterGoogleCloudVisionV1p4beta1ImportProductSetsResponse--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1ImportProductSetsResponse(
    api.GoogleCloudVisionV1p4beta1ImportProductSetsResponse o) {
  buildCounterGoogleCloudVisionV1p4beta1ImportProductSetsResponse++;
  if (buildCounterGoogleCloudVisionV1p4beta1ImportProductSetsResponse < 3) {
    checkUnnamed6388(o.referenceImages!);
    checkUnnamed6389(o.statuses!);
  }
  buildCounterGoogleCloudVisionV1p4beta1ImportProductSetsResponse--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1InputConfig = 0;
api.GoogleCloudVisionV1p4beta1InputConfig
    buildGoogleCloudVisionV1p4beta1InputConfig() {
  var o = api.GoogleCloudVisionV1p4beta1InputConfig();
  buildCounterGoogleCloudVisionV1p4beta1InputConfig++;
  if (buildCounterGoogleCloudVisionV1p4beta1InputConfig < 3) {
    o.content = 'foo';
    o.gcsSource = buildGoogleCloudVisionV1p4beta1GcsSource();
    o.mimeType = 'foo';
  }
  buildCounterGoogleCloudVisionV1p4beta1InputConfig--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1InputConfig(
    api.GoogleCloudVisionV1p4beta1InputConfig o) {
  buildCounterGoogleCloudVisionV1p4beta1InputConfig++;
  if (buildCounterGoogleCloudVisionV1p4beta1InputConfig < 3) {
    unittest.expect(
      o.content!,
      unittest.equals('foo'),
    );
    checkGoogleCloudVisionV1p4beta1GcsSource(
        o.gcsSource! as api.GoogleCloudVisionV1p4beta1GcsSource);
    unittest.expect(
      o.mimeType!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1InputConfig--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1LocalizedObjectAnnotation = 0;
api.GoogleCloudVisionV1p4beta1LocalizedObjectAnnotation
    buildGoogleCloudVisionV1p4beta1LocalizedObjectAnnotation() {
  var o = api.GoogleCloudVisionV1p4beta1LocalizedObjectAnnotation();
  buildCounterGoogleCloudVisionV1p4beta1LocalizedObjectAnnotation++;
  if (buildCounterGoogleCloudVisionV1p4beta1LocalizedObjectAnnotation < 3) {
    o.boundingPoly = buildGoogleCloudVisionV1p4beta1BoundingPoly();
    o.languageCode = 'foo';
    o.mid = 'foo';
    o.name = 'foo';
    o.score = 42.0;
  }
  buildCounterGoogleCloudVisionV1p4beta1LocalizedObjectAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1LocalizedObjectAnnotation(
    api.GoogleCloudVisionV1p4beta1LocalizedObjectAnnotation o) {
  buildCounterGoogleCloudVisionV1p4beta1LocalizedObjectAnnotation++;
  if (buildCounterGoogleCloudVisionV1p4beta1LocalizedObjectAnnotation < 3) {
    checkGoogleCloudVisionV1p4beta1BoundingPoly(
        o.boundingPoly! as api.GoogleCloudVisionV1p4beta1BoundingPoly);
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.mid!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1LocalizedObjectAnnotation--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1LocationInfo = 0;
api.GoogleCloudVisionV1p4beta1LocationInfo
    buildGoogleCloudVisionV1p4beta1LocationInfo() {
  var o = api.GoogleCloudVisionV1p4beta1LocationInfo();
  buildCounterGoogleCloudVisionV1p4beta1LocationInfo++;
  if (buildCounterGoogleCloudVisionV1p4beta1LocationInfo < 3) {
    o.latLng = buildLatLng();
  }
  buildCounterGoogleCloudVisionV1p4beta1LocationInfo--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1LocationInfo(
    api.GoogleCloudVisionV1p4beta1LocationInfo o) {
  buildCounterGoogleCloudVisionV1p4beta1LocationInfo++;
  if (buildCounterGoogleCloudVisionV1p4beta1LocationInfo < 3) {
    checkLatLng(o.latLng! as api.LatLng);
  }
  buildCounterGoogleCloudVisionV1p4beta1LocationInfo--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1NormalizedVertex = 0;
api.GoogleCloudVisionV1p4beta1NormalizedVertex
    buildGoogleCloudVisionV1p4beta1NormalizedVertex() {
  var o = api.GoogleCloudVisionV1p4beta1NormalizedVertex();
  buildCounterGoogleCloudVisionV1p4beta1NormalizedVertex++;
  if (buildCounterGoogleCloudVisionV1p4beta1NormalizedVertex < 3) {
    o.x = 42.0;
    o.y = 42.0;
  }
  buildCounterGoogleCloudVisionV1p4beta1NormalizedVertex--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1NormalizedVertex(
    api.GoogleCloudVisionV1p4beta1NormalizedVertex o) {
  buildCounterGoogleCloudVisionV1p4beta1NormalizedVertex++;
  if (buildCounterGoogleCloudVisionV1p4beta1NormalizedVertex < 3) {
    unittest.expect(
      o.x!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.y!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1NormalizedVertex--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1OperationMetadata = 0;
api.GoogleCloudVisionV1p4beta1OperationMetadata
    buildGoogleCloudVisionV1p4beta1OperationMetadata() {
  var o = api.GoogleCloudVisionV1p4beta1OperationMetadata();
  buildCounterGoogleCloudVisionV1p4beta1OperationMetadata++;
  if (buildCounterGoogleCloudVisionV1p4beta1OperationMetadata < 3) {
    o.createTime = 'foo';
    o.state = 'foo';
    o.updateTime = 'foo';
  }
  buildCounterGoogleCloudVisionV1p4beta1OperationMetadata--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1OperationMetadata(
    api.GoogleCloudVisionV1p4beta1OperationMetadata o) {
  buildCounterGoogleCloudVisionV1p4beta1OperationMetadata++;
  if (buildCounterGoogleCloudVisionV1p4beta1OperationMetadata < 3) {
    unittest.expect(
      o.createTime!,
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
  buildCounterGoogleCloudVisionV1p4beta1OperationMetadata--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1OutputConfig = 0;
api.GoogleCloudVisionV1p4beta1OutputConfig
    buildGoogleCloudVisionV1p4beta1OutputConfig() {
  var o = api.GoogleCloudVisionV1p4beta1OutputConfig();
  buildCounterGoogleCloudVisionV1p4beta1OutputConfig++;
  if (buildCounterGoogleCloudVisionV1p4beta1OutputConfig < 3) {
    o.batchSize = 42;
    o.gcsDestination = buildGoogleCloudVisionV1p4beta1GcsDestination();
  }
  buildCounterGoogleCloudVisionV1p4beta1OutputConfig--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1OutputConfig(
    api.GoogleCloudVisionV1p4beta1OutputConfig o) {
  buildCounterGoogleCloudVisionV1p4beta1OutputConfig++;
  if (buildCounterGoogleCloudVisionV1p4beta1OutputConfig < 3) {
    unittest.expect(
      o.batchSize!,
      unittest.equals(42),
    );
    checkGoogleCloudVisionV1p4beta1GcsDestination(
        o.gcsDestination! as api.GoogleCloudVisionV1p4beta1GcsDestination);
  }
  buildCounterGoogleCloudVisionV1p4beta1OutputConfig--;
}

core.List<api.GoogleCloudVisionV1p4beta1Block> buildUnnamed6390() {
  var o = <api.GoogleCloudVisionV1p4beta1Block>[];
  o.add(buildGoogleCloudVisionV1p4beta1Block());
  o.add(buildGoogleCloudVisionV1p4beta1Block());
  return o;
}

void checkUnnamed6390(core.List<api.GoogleCloudVisionV1p4beta1Block> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1Block(
      o[0] as api.GoogleCloudVisionV1p4beta1Block);
  checkGoogleCloudVisionV1p4beta1Block(
      o[1] as api.GoogleCloudVisionV1p4beta1Block);
}

core.int buildCounterGoogleCloudVisionV1p4beta1Page = 0;
api.GoogleCloudVisionV1p4beta1Page buildGoogleCloudVisionV1p4beta1Page() {
  var o = api.GoogleCloudVisionV1p4beta1Page();
  buildCounterGoogleCloudVisionV1p4beta1Page++;
  if (buildCounterGoogleCloudVisionV1p4beta1Page < 3) {
    o.blocks = buildUnnamed6390();
    o.confidence = 42.0;
    o.height = 42;
    o.property = buildGoogleCloudVisionV1p4beta1TextAnnotationTextProperty();
    o.width = 42;
  }
  buildCounterGoogleCloudVisionV1p4beta1Page--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1Page(api.GoogleCloudVisionV1p4beta1Page o) {
  buildCounterGoogleCloudVisionV1p4beta1Page++;
  if (buildCounterGoogleCloudVisionV1p4beta1Page < 3) {
    checkUnnamed6390(o.blocks!);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.height!,
      unittest.equals(42),
    );
    checkGoogleCloudVisionV1p4beta1TextAnnotationTextProperty(o.property!
        as api.GoogleCloudVisionV1p4beta1TextAnnotationTextProperty);
    unittest.expect(
      o.width!,
      unittest.equals(42),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1Page--;
}

core.List<api.GoogleCloudVisionV1p4beta1Word> buildUnnamed6391() {
  var o = <api.GoogleCloudVisionV1p4beta1Word>[];
  o.add(buildGoogleCloudVisionV1p4beta1Word());
  o.add(buildGoogleCloudVisionV1p4beta1Word());
  return o;
}

void checkUnnamed6391(core.List<api.GoogleCloudVisionV1p4beta1Word> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1Word(
      o[0] as api.GoogleCloudVisionV1p4beta1Word);
  checkGoogleCloudVisionV1p4beta1Word(
      o[1] as api.GoogleCloudVisionV1p4beta1Word);
}

core.int buildCounterGoogleCloudVisionV1p4beta1Paragraph = 0;
api.GoogleCloudVisionV1p4beta1Paragraph
    buildGoogleCloudVisionV1p4beta1Paragraph() {
  var o = api.GoogleCloudVisionV1p4beta1Paragraph();
  buildCounterGoogleCloudVisionV1p4beta1Paragraph++;
  if (buildCounterGoogleCloudVisionV1p4beta1Paragraph < 3) {
    o.boundingBox = buildGoogleCloudVisionV1p4beta1BoundingPoly();
    o.confidence = 42.0;
    o.property = buildGoogleCloudVisionV1p4beta1TextAnnotationTextProperty();
    o.words = buildUnnamed6391();
  }
  buildCounterGoogleCloudVisionV1p4beta1Paragraph--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1Paragraph(
    api.GoogleCloudVisionV1p4beta1Paragraph o) {
  buildCounterGoogleCloudVisionV1p4beta1Paragraph++;
  if (buildCounterGoogleCloudVisionV1p4beta1Paragraph < 3) {
    checkGoogleCloudVisionV1p4beta1BoundingPoly(
        o.boundingBox! as api.GoogleCloudVisionV1p4beta1BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVisionV1p4beta1TextAnnotationTextProperty(o.property!
        as api.GoogleCloudVisionV1p4beta1TextAnnotationTextProperty);
    checkUnnamed6391(o.words!);
  }
  buildCounterGoogleCloudVisionV1p4beta1Paragraph--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1Position = 0;
api.GoogleCloudVisionV1p4beta1Position
    buildGoogleCloudVisionV1p4beta1Position() {
  var o = api.GoogleCloudVisionV1p4beta1Position();
  buildCounterGoogleCloudVisionV1p4beta1Position++;
  if (buildCounterGoogleCloudVisionV1p4beta1Position < 3) {
    o.x = 42.0;
    o.y = 42.0;
    o.z = 42.0;
  }
  buildCounterGoogleCloudVisionV1p4beta1Position--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1Position(
    api.GoogleCloudVisionV1p4beta1Position o) {
  buildCounterGoogleCloudVisionV1p4beta1Position++;
  if (buildCounterGoogleCloudVisionV1p4beta1Position < 3) {
    unittest.expect(
      o.x!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.y!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.z!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1Position--;
}

core.List<api.GoogleCloudVisionV1p4beta1ProductKeyValue> buildUnnamed6392() {
  var o = <api.GoogleCloudVisionV1p4beta1ProductKeyValue>[];
  o.add(buildGoogleCloudVisionV1p4beta1ProductKeyValue());
  o.add(buildGoogleCloudVisionV1p4beta1ProductKeyValue());
  return o;
}

void checkUnnamed6392(
    core.List<api.GoogleCloudVisionV1p4beta1ProductKeyValue> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1ProductKeyValue(
      o[0] as api.GoogleCloudVisionV1p4beta1ProductKeyValue);
  checkGoogleCloudVisionV1p4beta1ProductKeyValue(
      o[1] as api.GoogleCloudVisionV1p4beta1ProductKeyValue);
}

core.int buildCounterGoogleCloudVisionV1p4beta1Product = 0;
api.GoogleCloudVisionV1p4beta1Product buildGoogleCloudVisionV1p4beta1Product() {
  var o = api.GoogleCloudVisionV1p4beta1Product();
  buildCounterGoogleCloudVisionV1p4beta1Product++;
  if (buildCounterGoogleCloudVisionV1p4beta1Product < 3) {
    o.description = 'foo';
    o.displayName = 'foo';
    o.name = 'foo';
    o.productCategory = 'foo';
    o.productLabels = buildUnnamed6392();
  }
  buildCounterGoogleCloudVisionV1p4beta1Product--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1Product(
    api.GoogleCloudVisionV1p4beta1Product o) {
  buildCounterGoogleCloudVisionV1p4beta1Product++;
  if (buildCounterGoogleCloudVisionV1p4beta1Product < 3) {
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
      o.productCategory!,
      unittest.equals('foo'),
    );
    checkUnnamed6392(o.productLabels!);
  }
  buildCounterGoogleCloudVisionV1p4beta1Product--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1ProductKeyValue = 0;
api.GoogleCloudVisionV1p4beta1ProductKeyValue
    buildGoogleCloudVisionV1p4beta1ProductKeyValue() {
  var o = api.GoogleCloudVisionV1p4beta1ProductKeyValue();
  buildCounterGoogleCloudVisionV1p4beta1ProductKeyValue++;
  if (buildCounterGoogleCloudVisionV1p4beta1ProductKeyValue < 3) {
    o.key = 'foo';
    o.value = 'foo';
  }
  buildCounterGoogleCloudVisionV1p4beta1ProductKeyValue--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1ProductKeyValue(
    api.GoogleCloudVisionV1p4beta1ProductKeyValue o) {
  buildCounterGoogleCloudVisionV1p4beta1ProductKeyValue++;
  if (buildCounterGoogleCloudVisionV1p4beta1ProductKeyValue < 3) {
    unittest.expect(
      o.key!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1ProductKeyValue--;
}

core.List<api.GoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult>
    buildUnnamed6393() {
  var o = <api.GoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult>[];
  o.add(buildGoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult());
  o.add(buildGoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult());
  return o;
}

void checkUnnamed6393(
    core.List<api.GoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult(
      o[0] as api.GoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult);
  checkGoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult(
      o[1] as api.GoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult);
}

core.List<api.GoogleCloudVisionV1p4beta1ProductSearchResultsResult>
    buildUnnamed6394() {
  var o = <api.GoogleCloudVisionV1p4beta1ProductSearchResultsResult>[];
  o.add(buildGoogleCloudVisionV1p4beta1ProductSearchResultsResult());
  o.add(buildGoogleCloudVisionV1p4beta1ProductSearchResultsResult());
  return o;
}

void checkUnnamed6394(
    core.List<api.GoogleCloudVisionV1p4beta1ProductSearchResultsResult> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1ProductSearchResultsResult(
      o[0] as api.GoogleCloudVisionV1p4beta1ProductSearchResultsResult);
  checkGoogleCloudVisionV1p4beta1ProductSearchResultsResult(
      o[1] as api.GoogleCloudVisionV1p4beta1ProductSearchResultsResult);
}

core.int buildCounterGoogleCloudVisionV1p4beta1ProductSearchResults = 0;
api.GoogleCloudVisionV1p4beta1ProductSearchResults
    buildGoogleCloudVisionV1p4beta1ProductSearchResults() {
  var o = api.GoogleCloudVisionV1p4beta1ProductSearchResults();
  buildCounterGoogleCloudVisionV1p4beta1ProductSearchResults++;
  if (buildCounterGoogleCloudVisionV1p4beta1ProductSearchResults < 3) {
    o.indexTime = 'foo';
    o.productGroupedResults = buildUnnamed6393();
    o.results = buildUnnamed6394();
  }
  buildCounterGoogleCloudVisionV1p4beta1ProductSearchResults--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1ProductSearchResults(
    api.GoogleCloudVisionV1p4beta1ProductSearchResults o) {
  buildCounterGoogleCloudVisionV1p4beta1ProductSearchResults++;
  if (buildCounterGoogleCloudVisionV1p4beta1ProductSearchResults < 3) {
    unittest.expect(
      o.indexTime!,
      unittest.equals('foo'),
    );
    checkUnnamed6393(o.productGroupedResults!);
    checkUnnamed6394(o.results!);
  }
  buildCounterGoogleCloudVisionV1p4beta1ProductSearchResults--;
}

core.List<api.GoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation>
    buildUnnamed6395() {
  var o =
      <api.GoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation>[];
  o.add(buildGoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation());
  o.add(buildGoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation());
  return o;
}

void checkUnnamed6395(
    core.List<
            api.GoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation>
        o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation(o[0]
      as api.GoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation);
  checkGoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation(o[1]
      as api.GoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation);
}

core.List<api.GoogleCloudVisionV1p4beta1ProductSearchResultsResult>
    buildUnnamed6396() {
  var o = <api.GoogleCloudVisionV1p4beta1ProductSearchResultsResult>[];
  o.add(buildGoogleCloudVisionV1p4beta1ProductSearchResultsResult());
  o.add(buildGoogleCloudVisionV1p4beta1ProductSearchResultsResult());
  return o;
}

void checkUnnamed6396(
    core.List<api.GoogleCloudVisionV1p4beta1ProductSearchResultsResult> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1ProductSearchResultsResult(
      o[0] as api.GoogleCloudVisionV1p4beta1ProductSearchResultsResult);
  checkGoogleCloudVisionV1p4beta1ProductSearchResultsResult(
      o[1] as api.GoogleCloudVisionV1p4beta1ProductSearchResultsResult);
}

core.int
    buildCounterGoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult = 0;
api.GoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult
    buildGoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult() {
  var o = api.GoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult();
  buildCounterGoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult++;
  if (buildCounterGoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult <
      3) {
    o.boundingPoly = buildGoogleCloudVisionV1p4beta1BoundingPoly();
    o.objectAnnotations = buildUnnamed6395();
    o.results = buildUnnamed6396();
  }
  buildCounterGoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult(
    api.GoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult o) {
  buildCounterGoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult++;
  if (buildCounterGoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult <
      3) {
    checkGoogleCloudVisionV1p4beta1BoundingPoly(
        o.boundingPoly! as api.GoogleCloudVisionV1p4beta1BoundingPoly);
    checkUnnamed6395(o.objectAnnotations!);
    checkUnnamed6396(o.results!);
  }
  buildCounterGoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult--;
}

core.int
    buildCounterGoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation =
    0;
api.GoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation
    buildGoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation() {
  var o = api.GoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation();
  buildCounterGoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation++;
  if (buildCounterGoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation <
      3) {
    o.languageCode = 'foo';
    o.mid = 'foo';
    o.name = 'foo';
    o.score = 42.0;
  }
  buildCounterGoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation(
    api.GoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation o) {
  buildCounterGoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation++;
  if (buildCounterGoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation <
      3) {
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.mid!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1ProductSearchResultsResult = 0;
api.GoogleCloudVisionV1p4beta1ProductSearchResultsResult
    buildGoogleCloudVisionV1p4beta1ProductSearchResultsResult() {
  var o = api.GoogleCloudVisionV1p4beta1ProductSearchResultsResult();
  buildCounterGoogleCloudVisionV1p4beta1ProductSearchResultsResult++;
  if (buildCounterGoogleCloudVisionV1p4beta1ProductSearchResultsResult < 3) {
    o.image = 'foo';
    o.product = buildGoogleCloudVisionV1p4beta1Product();
    o.score = 42.0;
  }
  buildCounterGoogleCloudVisionV1p4beta1ProductSearchResultsResult--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1ProductSearchResultsResult(
    api.GoogleCloudVisionV1p4beta1ProductSearchResultsResult o) {
  buildCounterGoogleCloudVisionV1p4beta1ProductSearchResultsResult++;
  if (buildCounterGoogleCloudVisionV1p4beta1ProductSearchResultsResult < 3) {
    unittest.expect(
      o.image!,
      unittest.equals('foo'),
    );
    checkGoogleCloudVisionV1p4beta1Product(
        o.product! as api.GoogleCloudVisionV1p4beta1Product);
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1ProductSearchResultsResult--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1Property = 0;
api.GoogleCloudVisionV1p4beta1Property
    buildGoogleCloudVisionV1p4beta1Property() {
  var o = api.GoogleCloudVisionV1p4beta1Property();
  buildCounterGoogleCloudVisionV1p4beta1Property++;
  if (buildCounterGoogleCloudVisionV1p4beta1Property < 3) {
    o.name = 'foo';
    o.uint64Value = 'foo';
    o.value = 'foo';
  }
  buildCounterGoogleCloudVisionV1p4beta1Property--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1Property(
    api.GoogleCloudVisionV1p4beta1Property o) {
  buildCounterGoogleCloudVisionV1p4beta1Property++;
  if (buildCounterGoogleCloudVisionV1p4beta1Property < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.uint64Value!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1Property--;
}

core.List<api.GoogleCloudVisionV1p4beta1BoundingPoly> buildUnnamed6397() {
  var o = <api.GoogleCloudVisionV1p4beta1BoundingPoly>[];
  o.add(buildGoogleCloudVisionV1p4beta1BoundingPoly());
  o.add(buildGoogleCloudVisionV1p4beta1BoundingPoly());
  return o;
}

void checkUnnamed6397(core.List<api.GoogleCloudVisionV1p4beta1BoundingPoly> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1BoundingPoly(
      o[0] as api.GoogleCloudVisionV1p4beta1BoundingPoly);
  checkGoogleCloudVisionV1p4beta1BoundingPoly(
      o[1] as api.GoogleCloudVisionV1p4beta1BoundingPoly);
}

core.int buildCounterGoogleCloudVisionV1p4beta1ReferenceImage = 0;
api.GoogleCloudVisionV1p4beta1ReferenceImage
    buildGoogleCloudVisionV1p4beta1ReferenceImage() {
  var o = api.GoogleCloudVisionV1p4beta1ReferenceImage();
  buildCounterGoogleCloudVisionV1p4beta1ReferenceImage++;
  if (buildCounterGoogleCloudVisionV1p4beta1ReferenceImage < 3) {
    o.boundingPolys = buildUnnamed6397();
    o.name = 'foo';
    o.uri = 'foo';
  }
  buildCounterGoogleCloudVisionV1p4beta1ReferenceImage--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1ReferenceImage(
    api.GoogleCloudVisionV1p4beta1ReferenceImage o) {
  buildCounterGoogleCloudVisionV1p4beta1ReferenceImage++;
  if (buildCounterGoogleCloudVisionV1p4beta1ReferenceImage < 3) {
    checkUnnamed6397(o.boundingPolys!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1ReferenceImage--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1SafeSearchAnnotation = 0;
api.GoogleCloudVisionV1p4beta1SafeSearchAnnotation
    buildGoogleCloudVisionV1p4beta1SafeSearchAnnotation() {
  var o = api.GoogleCloudVisionV1p4beta1SafeSearchAnnotation();
  buildCounterGoogleCloudVisionV1p4beta1SafeSearchAnnotation++;
  if (buildCounterGoogleCloudVisionV1p4beta1SafeSearchAnnotation < 3) {
    o.adult = 'foo';
    o.medical = 'foo';
    o.racy = 'foo';
    o.spoof = 'foo';
    o.violence = 'foo';
  }
  buildCounterGoogleCloudVisionV1p4beta1SafeSearchAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1SafeSearchAnnotation(
    api.GoogleCloudVisionV1p4beta1SafeSearchAnnotation o) {
  buildCounterGoogleCloudVisionV1p4beta1SafeSearchAnnotation++;
  if (buildCounterGoogleCloudVisionV1p4beta1SafeSearchAnnotation < 3) {
    unittest.expect(
      o.adult!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.medical!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.racy!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.spoof!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.violence!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1SafeSearchAnnotation--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1Symbol = 0;
api.GoogleCloudVisionV1p4beta1Symbol buildGoogleCloudVisionV1p4beta1Symbol() {
  var o = api.GoogleCloudVisionV1p4beta1Symbol();
  buildCounterGoogleCloudVisionV1p4beta1Symbol++;
  if (buildCounterGoogleCloudVisionV1p4beta1Symbol < 3) {
    o.boundingBox = buildGoogleCloudVisionV1p4beta1BoundingPoly();
    o.confidence = 42.0;
    o.property = buildGoogleCloudVisionV1p4beta1TextAnnotationTextProperty();
    o.text = 'foo';
  }
  buildCounterGoogleCloudVisionV1p4beta1Symbol--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1Symbol(
    api.GoogleCloudVisionV1p4beta1Symbol o) {
  buildCounterGoogleCloudVisionV1p4beta1Symbol++;
  if (buildCounterGoogleCloudVisionV1p4beta1Symbol < 3) {
    checkGoogleCloudVisionV1p4beta1BoundingPoly(
        o.boundingBox! as api.GoogleCloudVisionV1p4beta1BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVisionV1p4beta1TextAnnotationTextProperty(o.property!
        as api.GoogleCloudVisionV1p4beta1TextAnnotationTextProperty);
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1Symbol--;
}

core.List<api.GoogleCloudVisionV1p4beta1Page> buildUnnamed6398() {
  var o = <api.GoogleCloudVisionV1p4beta1Page>[];
  o.add(buildGoogleCloudVisionV1p4beta1Page());
  o.add(buildGoogleCloudVisionV1p4beta1Page());
  return o;
}

void checkUnnamed6398(core.List<api.GoogleCloudVisionV1p4beta1Page> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1Page(
      o[0] as api.GoogleCloudVisionV1p4beta1Page);
  checkGoogleCloudVisionV1p4beta1Page(
      o[1] as api.GoogleCloudVisionV1p4beta1Page);
}

core.int buildCounterGoogleCloudVisionV1p4beta1TextAnnotation = 0;
api.GoogleCloudVisionV1p4beta1TextAnnotation
    buildGoogleCloudVisionV1p4beta1TextAnnotation() {
  var o = api.GoogleCloudVisionV1p4beta1TextAnnotation();
  buildCounterGoogleCloudVisionV1p4beta1TextAnnotation++;
  if (buildCounterGoogleCloudVisionV1p4beta1TextAnnotation < 3) {
    o.pages = buildUnnamed6398();
    o.text = 'foo';
  }
  buildCounterGoogleCloudVisionV1p4beta1TextAnnotation--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1TextAnnotation(
    api.GoogleCloudVisionV1p4beta1TextAnnotation o) {
  buildCounterGoogleCloudVisionV1p4beta1TextAnnotation++;
  if (buildCounterGoogleCloudVisionV1p4beta1TextAnnotation < 3) {
    checkUnnamed6398(o.pages!);
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1TextAnnotation--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1TextAnnotationDetectedBreak = 0;
api.GoogleCloudVisionV1p4beta1TextAnnotationDetectedBreak
    buildGoogleCloudVisionV1p4beta1TextAnnotationDetectedBreak() {
  var o = api.GoogleCloudVisionV1p4beta1TextAnnotationDetectedBreak();
  buildCounterGoogleCloudVisionV1p4beta1TextAnnotationDetectedBreak++;
  if (buildCounterGoogleCloudVisionV1p4beta1TextAnnotationDetectedBreak < 3) {
    o.isPrefix = true;
    o.type = 'foo';
  }
  buildCounterGoogleCloudVisionV1p4beta1TextAnnotationDetectedBreak--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1TextAnnotationDetectedBreak(
    api.GoogleCloudVisionV1p4beta1TextAnnotationDetectedBreak o) {
  buildCounterGoogleCloudVisionV1p4beta1TextAnnotationDetectedBreak++;
  if (buildCounterGoogleCloudVisionV1p4beta1TextAnnotationDetectedBreak < 3) {
    unittest.expect(o.isPrefix!, unittest.isTrue);
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1TextAnnotationDetectedBreak--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage =
    0;
api.GoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage
    buildGoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage() {
  var o = api.GoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage();
  buildCounterGoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage++;
  if (buildCounterGoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage <
      3) {
    o.confidence = 42.0;
    o.languageCode = 'foo';
  }
  buildCounterGoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage(
    api.GoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage o) {
  buildCounterGoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage++;
  if (buildCounterGoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage <
      3) {
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage--;
}

core.List<api.GoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage>
    buildUnnamed6399() {
  var o = <api.GoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage>[];
  o.add(buildGoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage());
  o.add(buildGoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage());
  return o;
}

void checkUnnamed6399(
    core.List<api.GoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage(
      o[0] as api.GoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage);
  checkGoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage(
      o[1] as api.GoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage);
}

core.int buildCounterGoogleCloudVisionV1p4beta1TextAnnotationTextProperty = 0;
api.GoogleCloudVisionV1p4beta1TextAnnotationTextProperty
    buildGoogleCloudVisionV1p4beta1TextAnnotationTextProperty() {
  var o = api.GoogleCloudVisionV1p4beta1TextAnnotationTextProperty();
  buildCounterGoogleCloudVisionV1p4beta1TextAnnotationTextProperty++;
  if (buildCounterGoogleCloudVisionV1p4beta1TextAnnotationTextProperty < 3) {
    o.detectedBreak =
        buildGoogleCloudVisionV1p4beta1TextAnnotationDetectedBreak();
    o.detectedLanguages = buildUnnamed6399();
  }
  buildCounterGoogleCloudVisionV1p4beta1TextAnnotationTextProperty--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1TextAnnotationTextProperty(
    api.GoogleCloudVisionV1p4beta1TextAnnotationTextProperty o) {
  buildCounterGoogleCloudVisionV1p4beta1TextAnnotationTextProperty++;
  if (buildCounterGoogleCloudVisionV1p4beta1TextAnnotationTextProperty < 3) {
    checkGoogleCloudVisionV1p4beta1TextAnnotationDetectedBreak(o.detectedBreak!
        as api.GoogleCloudVisionV1p4beta1TextAnnotationDetectedBreak);
    checkUnnamed6399(o.detectedLanguages!);
  }
  buildCounterGoogleCloudVisionV1p4beta1TextAnnotationTextProperty--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1Vertex = 0;
api.GoogleCloudVisionV1p4beta1Vertex buildGoogleCloudVisionV1p4beta1Vertex() {
  var o = api.GoogleCloudVisionV1p4beta1Vertex();
  buildCounterGoogleCloudVisionV1p4beta1Vertex++;
  if (buildCounterGoogleCloudVisionV1p4beta1Vertex < 3) {
    o.x = 42;
    o.y = 42;
  }
  buildCounterGoogleCloudVisionV1p4beta1Vertex--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1Vertex(
    api.GoogleCloudVisionV1p4beta1Vertex o) {
  buildCounterGoogleCloudVisionV1p4beta1Vertex++;
  if (buildCounterGoogleCloudVisionV1p4beta1Vertex < 3) {
    unittest.expect(
      o.x!,
      unittest.equals(42),
    );
    unittest.expect(
      o.y!,
      unittest.equals(42),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1Vertex--;
}

core.List<api.GoogleCloudVisionV1p4beta1WebDetectionWebLabel>
    buildUnnamed6400() {
  var o = <api.GoogleCloudVisionV1p4beta1WebDetectionWebLabel>[];
  o.add(buildGoogleCloudVisionV1p4beta1WebDetectionWebLabel());
  o.add(buildGoogleCloudVisionV1p4beta1WebDetectionWebLabel());
  return o;
}

void checkUnnamed6400(
    core.List<api.GoogleCloudVisionV1p4beta1WebDetectionWebLabel> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1WebDetectionWebLabel(
      o[0] as api.GoogleCloudVisionV1p4beta1WebDetectionWebLabel);
  checkGoogleCloudVisionV1p4beta1WebDetectionWebLabel(
      o[1] as api.GoogleCloudVisionV1p4beta1WebDetectionWebLabel);
}

core.List<api.GoogleCloudVisionV1p4beta1WebDetectionWebImage>
    buildUnnamed6401() {
  var o = <api.GoogleCloudVisionV1p4beta1WebDetectionWebImage>[];
  o.add(buildGoogleCloudVisionV1p4beta1WebDetectionWebImage());
  o.add(buildGoogleCloudVisionV1p4beta1WebDetectionWebImage());
  return o;
}

void checkUnnamed6401(
    core.List<api.GoogleCloudVisionV1p4beta1WebDetectionWebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1WebDetectionWebImage(
      o[0] as api.GoogleCloudVisionV1p4beta1WebDetectionWebImage);
  checkGoogleCloudVisionV1p4beta1WebDetectionWebImage(
      o[1] as api.GoogleCloudVisionV1p4beta1WebDetectionWebImage);
}

core.List<api.GoogleCloudVisionV1p4beta1WebDetectionWebPage>
    buildUnnamed6402() {
  var o = <api.GoogleCloudVisionV1p4beta1WebDetectionWebPage>[];
  o.add(buildGoogleCloudVisionV1p4beta1WebDetectionWebPage());
  o.add(buildGoogleCloudVisionV1p4beta1WebDetectionWebPage());
  return o;
}

void checkUnnamed6402(
    core.List<api.GoogleCloudVisionV1p4beta1WebDetectionWebPage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1WebDetectionWebPage(
      o[0] as api.GoogleCloudVisionV1p4beta1WebDetectionWebPage);
  checkGoogleCloudVisionV1p4beta1WebDetectionWebPage(
      o[1] as api.GoogleCloudVisionV1p4beta1WebDetectionWebPage);
}

core.List<api.GoogleCloudVisionV1p4beta1WebDetectionWebImage>
    buildUnnamed6403() {
  var o = <api.GoogleCloudVisionV1p4beta1WebDetectionWebImage>[];
  o.add(buildGoogleCloudVisionV1p4beta1WebDetectionWebImage());
  o.add(buildGoogleCloudVisionV1p4beta1WebDetectionWebImage());
  return o;
}

void checkUnnamed6403(
    core.List<api.GoogleCloudVisionV1p4beta1WebDetectionWebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1WebDetectionWebImage(
      o[0] as api.GoogleCloudVisionV1p4beta1WebDetectionWebImage);
  checkGoogleCloudVisionV1p4beta1WebDetectionWebImage(
      o[1] as api.GoogleCloudVisionV1p4beta1WebDetectionWebImage);
}

core.List<api.GoogleCloudVisionV1p4beta1WebDetectionWebImage>
    buildUnnamed6404() {
  var o = <api.GoogleCloudVisionV1p4beta1WebDetectionWebImage>[];
  o.add(buildGoogleCloudVisionV1p4beta1WebDetectionWebImage());
  o.add(buildGoogleCloudVisionV1p4beta1WebDetectionWebImage());
  return o;
}

void checkUnnamed6404(
    core.List<api.GoogleCloudVisionV1p4beta1WebDetectionWebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1WebDetectionWebImage(
      o[0] as api.GoogleCloudVisionV1p4beta1WebDetectionWebImage);
  checkGoogleCloudVisionV1p4beta1WebDetectionWebImage(
      o[1] as api.GoogleCloudVisionV1p4beta1WebDetectionWebImage);
}

core.List<api.GoogleCloudVisionV1p4beta1WebDetectionWebEntity>
    buildUnnamed6405() {
  var o = <api.GoogleCloudVisionV1p4beta1WebDetectionWebEntity>[];
  o.add(buildGoogleCloudVisionV1p4beta1WebDetectionWebEntity());
  o.add(buildGoogleCloudVisionV1p4beta1WebDetectionWebEntity());
  return o;
}

void checkUnnamed6405(
    core.List<api.GoogleCloudVisionV1p4beta1WebDetectionWebEntity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1WebDetectionWebEntity(
      o[0] as api.GoogleCloudVisionV1p4beta1WebDetectionWebEntity);
  checkGoogleCloudVisionV1p4beta1WebDetectionWebEntity(
      o[1] as api.GoogleCloudVisionV1p4beta1WebDetectionWebEntity);
}

core.int buildCounterGoogleCloudVisionV1p4beta1WebDetection = 0;
api.GoogleCloudVisionV1p4beta1WebDetection
    buildGoogleCloudVisionV1p4beta1WebDetection() {
  var o = api.GoogleCloudVisionV1p4beta1WebDetection();
  buildCounterGoogleCloudVisionV1p4beta1WebDetection++;
  if (buildCounterGoogleCloudVisionV1p4beta1WebDetection < 3) {
    o.bestGuessLabels = buildUnnamed6400();
    o.fullMatchingImages = buildUnnamed6401();
    o.pagesWithMatchingImages = buildUnnamed6402();
    o.partialMatchingImages = buildUnnamed6403();
    o.visuallySimilarImages = buildUnnamed6404();
    o.webEntities = buildUnnamed6405();
  }
  buildCounterGoogleCloudVisionV1p4beta1WebDetection--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1WebDetection(
    api.GoogleCloudVisionV1p4beta1WebDetection o) {
  buildCounterGoogleCloudVisionV1p4beta1WebDetection++;
  if (buildCounterGoogleCloudVisionV1p4beta1WebDetection < 3) {
    checkUnnamed6400(o.bestGuessLabels!);
    checkUnnamed6401(o.fullMatchingImages!);
    checkUnnamed6402(o.pagesWithMatchingImages!);
    checkUnnamed6403(o.partialMatchingImages!);
    checkUnnamed6404(o.visuallySimilarImages!);
    checkUnnamed6405(o.webEntities!);
  }
  buildCounterGoogleCloudVisionV1p4beta1WebDetection--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebEntity = 0;
api.GoogleCloudVisionV1p4beta1WebDetectionWebEntity
    buildGoogleCloudVisionV1p4beta1WebDetectionWebEntity() {
  var o = api.GoogleCloudVisionV1p4beta1WebDetectionWebEntity();
  buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebEntity++;
  if (buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebEntity < 3) {
    o.description = 'foo';
    o.entityId = 'foo';
    o.score = 42.0;
  }
  buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebEntity--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1WebDetectionWebEntity(
    api.GoogleCloudVisionV1p4beta1WebDetectionWebEntity o) {
  buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebEntity++;
  if (buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebEntity < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.entityId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebEntity--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebImage = 0;
api.GoogleCloudVisionV1p4beta1WebDetectionWebImage
    buildGoogleCloudVisionV1p4beta1WebDetectionWebImage() {
  var o = api.GoogleCloudVisionV1p4beta1WebDetectionWebImage();
  buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebImage++;
  if (buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebImage < 3) {
    o.score = 42.0;
    o.url = 'foo';
  }
  buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebImage--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1WebDetectionWebImage(
    api.GoogleCloudVisionV1p4beta1WebDetectionWebImage o) {
  buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebImage++;
  if (buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebImage < 3) {
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.url!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebImage--;
}

core.int buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebLabel = 0;
api.GoogleCloudVisionV1p4beta1WebDetectionWebLabel
    buildGoogleCloudVisionV1p4beta1WebDetectionWebLabel() {
  var o = api.GoogleCloudVisionV1p4beta1WebDetectionWebLabel();
  buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebLabel++;
  if (buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebLabel < 3) {
    o.label = 'foo';
    o.languageCode = 'foo';
  }
  buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebLabel--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1WebDetectionWebLabel(
    api.GoogleCloudVisionV1p4beta1WebDetectionWebLabel o) {
  buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebLabel++;
  if (buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebLabel < 3) {
    unittest.expect(
      o.label!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebLabel--;
}

core.List<api.GoogleCloudVisionV1p4beta1WebDetectionWebImage>
    buildUnnamed6406() {
  var o = <api.GoogleCloudVisionV1p4beta1WebDetectionWebImage>[];
  o.add(buildGoogleCloudVisionV1p4beta1WebDetectionWebImage());
  o.add(buildGoogleCloudVisionV1p4beta1WebDetectionWebImage());
  return o;
}

void checkUnnamed6406(
    core.List<api.GoogleCloudVisionV1p4beta1WebDetectionWebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1WebDetectionWebImage(
      o[0] as api.GoogleCloudVisionV1p4beta1WebDetectionWebImage);
  checkGoogleCloudVisionV1p4beta1WebDetectionWebImage(
      o[1] as api.GoogleCloudVisionV1p4beta1WebDetectionWebImage);
}

core.List<api.GoogleCloudVisionV1p4beta1WebDetectionWebImage>
    buildUnnamed6407() {
  var o = <api.GoogleCloudVisionV1p4beta1WebDetectionWebImage>[];
  o.add(buildGoogleCloudVisionV1p4beta1WebDetectionWebImage());
  o.add(buildGoogleCloudVisionV1p4beta1WebDetectionWebImage());
  return o;
}

void checkUnnamed6407(
    core.List<api.GoogleCloudVisionV1p4beta1WebDetectionWebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1WebDetectionWebImage(
      o[0] as api.GoogleCloudVisionV1p4beta1WebDetectionWebImage);
  checkGoogleCloudVisionV1p4beta1WebDetectionWebImage(
      o[1] as api.GoogleCloudVisionV1p4beta1WebDetectionWebImage);
}

core.int buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebPage = 0;
api.GoogleCloudVisionV1p4beta1WebDetectionWebPage
    buildGoogleCloudVisionV1p4beta1WebDetectionWebPage() {
  var o = api.GoogleCloudVisionV1p4beta1WebDetectionWebPage();
  buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebPage++;
  if (buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebPage < 3) {
    o.fullMatchingImages = buildUnnamed6406();
    o.pageTitle = 'foo';
    o.partialMatchingImages = buildUnnamed6407();
    o.score = 42.0;
    o.url = 'foo';
  }
  buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebPage--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1WebDetectionWebPage(
    api.GoogleCloudVisionV1p4beta1WebDetectionWebPage o) {
  buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebPage++;
  if (buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebPage < 3) {
    checkUnnamed6406(o.fullMatchingImages!);
    unittest.expect(
      o.pageTitle!,
      unittest.equals('foo'),
    );
    checkUnnamed6407(o.partialMatchingImages!);
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.url!,
      unittest.equals('foo'),
    );
  }
  buildCounterGoogleCloudVisionV1p4beta1WebDetectionWebPage--;
}

core.List<api.GoogleCloudVisionV1p4beta1Symbol> buildUnnamed6408() {
  var o = <api.GoogleCloudVisionV1p4beta1Symbol>[];
  o.add(buildGoogleCloudVisionV1p4beta1Symbol());
  o.add(buildGoogleCloudVisionV1p4beta1Symbol());
  return o;
}

void checkUnnamed6408(core.List<api.GoogleCloudVisionV1p4beta1Symbol> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGoogleCloudVisionV1p4beta1Symbol(
      o[0] as api.GoogleCloudVisionV1p4beta1Symbol);
  checkGoogleCloudVisionV1p4beta1Symbol(
      o[1] as api.GoogleCloudVisionV1p4beta1Symbol);
}

core.int buildCounterGoogleCloudVisionV1p4beta1Word = 0;
api.GoogleCloudVisionV1p4beta1Word buildGoogleCloudVisionV1p4beta1Word() {
  var o = api.GoogleCloudVisionV1p4beta1Word();
  buildCounterGoogleCloudVisionV1p4beta1Word++;
  if (buildCounterGoogleCloudVisionV1p4beta1Word < 3) {
    o.boundingBox = buildGoogleCloudVisionV1p4beta1BoundingPoly();
    o.confidence = 42.0;
    o.property = buildGoogleCloudVisionV1p4beta1TextAnnotationTextProperty();
    o.symbols = buildUnnamed6408();
  }
  buildCounterGoogleCloudVisionV1p4beta1Word--;
  return o;
}

void checkGoogleCloudVisionV1p4beta1Word(api.GoogleCloudVisionV1p4beta1Word o) {
  buildCounterGoogleCloudVisionV1p4beta1Word++;
  if (buildCounterGoogleCloudVisionV1p4beta1Word < 3) {
    checkGoogleCloudVisionV1p4beta1BoundingPoly(
        o.boundingBox! as api.GoogleCloudVisionV1p4beta1BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkGoogleCloudVisionV1p4beta1TextAnnotationTextProperty(o.property!
        as api.GoogleCloudVisionV1p4beta1TextAnnotationTextProperty);
    checkUnnamed6408(o.symbols!);
  }
  buildCounterGoogleCloudVisionV1p4beta1Word--;
}

core.List<api.ObjectAnnotation> buildUnnamed6409() {
  var o = <api.ObjectAnnotation>[];
  o.add(buildObjectAnnotation());
  o.add(buildObjectAnnotation());
  return o;
}

void checkUnnamed6409(core.List<api.ObjectAnnotation> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkObjectAnnotation(o[0] as api.ObjectAnnotation);
  checkObjectAnnotation(o[1] as api.ObjectAnnotation);
}

core.List<api.Result> buildUnnamed6410() {
  var o = <api.Result>[];
  o.add(buildResult());
  o.add(buildResult());
  return o;
}

void checkUnnamed6410(core.List<api.Result> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkResult(o[0] as api.Result);
  checkResult(o[1] as api.Result);
}

core.int buildCounterGroupedResult = 0;
api.GroupedResult buildGroupedResult() {
  var o = api.GroupedResult();
  buildCounterGroupedResult++;
  if (buildCounterGroupedResult < 3) {
    o.boundingPoly = buildBoundingPoly();
    o.objectAnnotations = buildUnnamed6409();
    o.results = buildUnnamed6410();
  }
  buildCounterGroupedResult--;
  return o;
}

void checkGroupedResult(api.GroupedResult o) {
  buildCounterGroupedResult++;
  if (buildCounterGroupedResult < 3) {
    checkBoundingPoly(o.boundingPoly! as api.BoundingPoly);
    checkUnnamed6409(o.objectAnnotations!);
    checkUnnamed6410(o.results!);
  }
  buildCounterGroupedResult--;
}

core.int buildCounterImage = 0;
api.Image buildImage() {
  var o = api.Image();
  buildCounterImage++;
  if (buildCounterImage < 3) {
    o.content = 'foo';
    o.source = buildImageSource();
  }
  buildCounterImage--;
  return o;
}

void checkImage(api.Image o) {
  buildCounterImage++;
  if (buildCounterImage < 3) {
    unittest.expect(
      o.content!,
      unittest.equals('foo'),
    );
    checkImageSource(o.source! as api.ImageSource);
  }
  buildCounterImage--;
}

core.int buildCounterImageAnnotationContext = 0;
api.ImageAnnotationContext buildImageAnnotationContext() {
  var o = api.ImageAnnotationContext();
  buildCounterImageAnnotationContext++;
  if (buildCounterImageAnnotationContext < 3) {
    o.pageNumber = 42;
    o.uri = 'foo';
  }
  buildCounterImageAnnotationContext--;
  return o;
}

void checkImageAnnotationContext(api.ImageAnnotationContext o) {
  buildCounterImageAnnotationContext++;
  if (buildCounterImageAnnotationContext < 3) {
    unittest.expect(
      o.pageNumber!,
      unittest.equals(42),
    );
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterImageAnnotationContext--;
}

core.List<core.String> buildUnnamed6411() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed6411(core.List<core.String> o) {
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

core.int buildCounterImageContext = 0;
api.ImageContext buildImageContext() {
  var o = api.ImageContext();
  buildCounterImageContext++;
  if (buildCounterImageContext < 3) {
    o.cropHintsParams = buildCropHintsParams();
    o.languageHints = buildUnnamed6411();
    o.latLongRect = buildLatLongRect();
    o.productSearchParams = buildProductSearchParams();
    o.textDetectionParams = buildTextDetectionParams();
    o.webDetectionParams = buildWebDetectionParams();
  }
  buildCounterImageContext--;
  return o;
}

void checkImageContext(api.ImageContext o) {
  buildCounterImageContext++;
  if (buildCounterImageContext < 3) {
    checkCropHintsParams(o.cropHintsParams! as api.CropHintsParams);
    checkUnnamed6411(o.languageHints!);
    checkLatLongRect(o.latLongRect! as api.LatLongRect);
    checkProductSearchParams(o.productSearchParams! as api.ProductSearchParams);
    checkTextDetectionParams(o.textDetectionParams! as api.TextDetectionParams);
    checkWebDetectionParams(o.webDetectionParams! as api.WebDetectionParams);
  }
  buildCounterImageContext--;
}

core.int buildCounterImageProperties = 0;
api.ImageProperties buildImageProperties() {
  var o = api.ImageProperties();
  buildCounterImageProperties++;
  if (buildCounterImageProperties < 3) {
    o.dominantColors = buildDominantColorsAnnotation();
  }
  buildCounterImageProperties--;
  return o;
}

void checkImageProperties(api.ImageProperties o) {
  buildCounterImageProperties++;
  if (buildCounterImageProperties < 3) {
    checkDominantColorsAnnotation(
        o.dominantColors! as api.DominantColorsAnnotation);
  }
  buildCounterImageProperties--;
}

core.int buildCounterImageSource = 0;
api.ImageSource buildImageSource() {
  var o = api.ImageSource();
  buildCounterImageSource++;
  if (buildCounterImageSource < 3) {
    o.gcsImageUri = 'foo';
    o.imageUri = 'foo';
  }
  buildCounterImageSource--;
  return o;
}

void checkImageSource(api.ImageSource o) {
  buildCounterImageSource++;
  if (buildCounterImageSource < 3) {
    unittest.expect(
      o.gcsImageUri!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.imageUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterImageSource--;
}

core.int buildCounterImportProductSetsGcsSource = 0;
api.ImportProductSetsGcsSource buildImportProductSetsGcsSource() {
  var o = api.ImportProductSetsGcsSource();
  buildCounterImportProductSetsGcsSource++;
  if (buildCounterImportProductSetsGcsSource < 3) {
    o.csvFileUri = 'foo';
  }
  buildCounterImportProductSetsGcsSource--;
  return o;
}

void checkImportProductSetsGcsSource(api.ImportProductSetsGcsSource o) {
  buildCounterImportProductSetsGcsSource++;
  if (buildCounterImportProductSetsGcsSource < 3) {
    unittest.expect(
      o.csvFileUri!,
      unittest.equals('foo'),
    );
  }
  buildCounterImportProductSetsGcsSource--;
}

core.int buildCounterImportProductSetsInputConfig = 0;
api.ImportProductSetsInputConfig buildImportProductSetsInputConfig() {
  var o = api.ImportProductSetsInputConfig();
  buildCounterImportProductSetsInputConfig++;
  if (buildCounterImportProductSetsInputConfig < 3) {
    o.gcsSource = buildImportProductSetsGcsSource();
  }
  buildCounterImportProductSetsInputConfig--;
  return o;
}

void checkImportProductSetsInputConfig(api.ImportProductSetsInputConfig o) {
  buildCounterImportProductSetsInputConfig++;
  if (buildCounterImportProductSetsInputConfig < 3) {
    checkImportProductSetsGcsSource(
        o.gcsSource! as api.ImportProductSetsGcsSource);
  }
  buildCounterImportProductSetsInputConfig--;
}

core.int buildCounterImportProductSetsRequest = 0;
api.ImportProductSetsRequest buildImportProductSetsRequest() {
  var o = api.ImportProductSetsRequest();
  buildCounterImportProductSetsRequest++;
  if (buildCounterImportProductSetsRequest < 3) {
    o.inputConfig = buildImportProductSetsInputConfig();
  }
  buildCounterImportProductSetsRequest--;
  return o;
}

void checkImportProductSetsRequest(api.ImportProductSetsRequest o) {
  buildCounterImportProductSetsRequest++;
  if (buildCounterImportProductSetsRequest < 3) {
    checkImportProductSetsInputConfig(
        o.inputConfig! as api.ImportProductSetsInputConfig);
  }
  buildCounterImportProductSetsRequest--;
}

core.List<api.ReferenceImage> buildUnnamed6412() {
  var o = <api.ReferenceImage>[];
  o.add(buildReferenceImage());
  o.add(buildReferenceImage());
  return o;
}

void checkUnnamed6412(core.List<api.ReferenceImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkReferenceImage(o[0] as api.ReferenceImage);
  checkReferenceImage(o[1] as api.ReferenceImage);
}

core.List<api.Status> buildUnnamed6413() {
  var o = <api.Status>[];
  o.add(buildStatus());
  o.add(buildStatus());
  return o;
}

void checkUnnamed6413(core.List<api.Status> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkStatus(o[0] as api.Status);
  checkStatus(o[1] as api.Status);
}

core.int buildCounterImportProductSetsResponse = 0;
api.ImportProductSetsResponse buildImportProductSetsResponse() {
  var o = api.ImportProductSetsResponse();
  buildCounterImportProductSetsResponse++;
  if (buildCounterImportProductSetsResponse < 3) {
    o.referenceImages = buildUnnamed6412();
    o.statuses = buildUnnamed6413();
  }
  buildCounterImportProductSetsResponse--;
  return o;
}

void checkImportProductSetsResponse(api.ImportProductSetsResponse o) {
  buildCounterImportProductSetsResponse++;
  if (buildCounterImportProductSetsResponse < 3) {
    checkUnnamed6412(o.referenceImages!);
    checkUnnamed6413(o.statuses!);
  }
  buildCounterImportProductSetsResponse--;
}

core.int buildCounterInputConfig = 0;
api.InputConfig buildInputConfig() {
  var o = api.InputConfig();
  buildCounterInputConfig++;
  if (buildCounterInputConfig < 3) {
    o.content = 'foo';
    o.gcsSource = buildGcsSource();
    o.mimeType = 'foo';
  }
  buildCounterInputConfig--;
  return o;
}

void checkInputConfig(api.InputConfig o) {
  buildCounterInputConfig++;
  if (buildCounterInputConfig < 3) {
    unittest.expect(
      o.content!,
      unittest.equals('foo'),
    );
    checkGcsSource(o.gcsSource! as api.GcsSource);
    unittest.expect(
      o.mimeType!,
      unittest.equals('foo'),
    );
  }
  buildCounterInputConfig--;
}

core.int buildCounterKeyValue = 0;
api.KeyValue buildKeyValue() {
  var o = api.KeyValue();
  buildCounterKeyValue++;
  if (buildCounterKeyValue < 3) {
    o.key = 'foo';
    o.value = 'foo';
  }
  buildCounterKeyValue--;
  return o;
}

void checkKeyValue(api.KeyValue o) {
  buildCounterKeyValue++;
  if (buildCounterKeyValue < 3) {
    unittest.expect(
      o.key!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterKeyValue--;
}

core.int buildCounterLandmark = 0;
api.Landmark buildLandmark() {
  var o = api.Landmark();
  buildCounterLandmark++;
  if (buildCounterLandmark < 3) {
    o.position = buildPosition();
    o.type = 'foo';
  }
  buildCounterLandmark--;
  return o;
}

void checkLandmark(api.Landmark o) {
  buildCounterLandmark++;
  if (buildCounterLandmark < 3) {
    checkPosition(o.position! as api.Position);
    unittest.expect(
      o.type!,
      unittest.equals('foo'),
    );
  }
  buildCounterLandmark--;
}

core.int buildCounterLatLng = 0;
api.LatLng buildLatLng() {
  var o = api.LatLng();
  buildCounterLatLng++;
  if (buildCounterLatLng < 3) {
    o.latitude = 42.0;
    o.longitude = 42.0;
  }
  buildCounterLatLng--;
  return o;
}

void checkLatLng(api.LatLng o) {
  buildCounterLatLng++;
  if (buildCounterLatLng < 3) {
    unittest.expect(
      o.latitude!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.longitude!,
      unittest.equals(42.0),
    );
  }
  buildCounterLatLng--;
}

core.int buildCounterLatLongRect = 0;
api.LatLongRect buildLatLongRect() {
  var o = api.LatLongRect();
  buildCounterLatLongRect++;
  if (buildCounterLatLongRect < 3) {
    o.maxLatLng = buildLatLng();
    o.minLatLng = buildLatLng();
  }
  buildCounterLatLongRect--;
  return o;
}

void checkLatLongRect(api.LatLongRect o) {
  buildCounterLatLongRect++;
  if (buildCounterLatLongRect < 3) {
    checkLatLng(o.maxLatLng! as api.LatLng);
    checkLatLng(o.minLatLng! as api.LatLng);
  }
  buildCounterLatLongRect--;
}

core.List<api.Operation> buildUnnamed6414() {
  var o = <api.Operation>[];
  o.add(buildOperation());
  o.add(buildOperation());
  return o;
}

void checkUnnamed6414(core.List<api.Operation> o) {
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
    o.operations = buildUnnamed6414();
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
    checkUnnamed6414(o.operations!);
  }
  buildCounterListOperationsResponse--;
}

core.List<api.ProductSet> buildUnnamed6415() {
  var o = <api.ProductSet>[];
  o.add(buildProductSet());
  o.add(buildProductSet());
  return o;
}

void checkUnnamed6415(core.List<api.ProductSet> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkProductSet(o[0] as api.ProductSet);
  checkProductSet(o[1] as api.ProductSet);
}

core.int buildCounterListProductSetsResponse = 0;
api.ListProductSetsResponse buildListProductSetsResponse() {
  var o = api.ListProductSetsResponse();
  buildCounterListProductSetsResponse++;
  if (buildCounterListProductSetsResponse < 3) {
    o.nextPageToken = 'foo';
    o.productSets = buildUnnamed6415();
  }
  buildCounterListProductSetsResponse--;
  return o;
}

void checkListProductSetsResponse(api.ListProductSetsResponse o) {
  buildCounterListProductSetsResponse++;
  if (buildCounterListProductSetsResponse < 3) {
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
    checkUnnamed6415(o.productSets!);
  }
  buildCounterListProductSetsResponse--;
}

core.List<api.Product> buildUnnamed6416() {
  var o = <api.Product>[];
  o.add(buildProduct());
  o.add(buildProduct());
  return o;
}

void checkUnnamed6416(core.List<api.Product> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkProduct(o[0] as api.Product);
  checkProduct(o[1] as api.Product);
}

core.int buildCounterListProductsInProductSetResponse = 0;
api.ListProductsInProductSetResponse buildListProductsInProductSetResponse() {
  var o = api.ListProductsInProductSetResponse();
  buildCounterListProductsInProductSetResponse++;
  if (buildCounterListProductsInProductSetResponse < 3) {
    o.nextPageToken = 'foo';
    o.products = buildUnnamed6416();
  }
  buildCounterListProductsInProductSetResponse--;
  return o;
}

void checkListProductsInProductSetResponse(
    api.ListProductsInProductSetResponse o) {
  buildCounterListProductsInProductSetResponse++;
  if (buildCounterListProductsInProductSetResponse < 3) {
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
    checkUnnamed6416(o.products!);
  }
  buildCounterListProductsInProductSetResponse--;
}

core.List<api.Product> buildUnnamed6417() {
  var o = <api.Product>[];
  o.add(buildProduct());
  o.add(buildProduct());
  return o;
}

void checkUnnamed6417(core.List<api.Product> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkProduct(o[0] as api.Product);
  checkProduct(o[1] as api.Product);
}

core.int buildCounterListProductsResponse = 0;
api.ListProductsResponse buildListProductsResponse() {
  var o = api.ListProductsResponse();
  buildCounterListProductsResponse++;
  if (buildCounterListProductsResponse < 3) {
    o.nextPageToken = 'foo';
    o.products = buildUnnamed6417();
  }
  buildCounterListProductsResponse--;
  return o;
}

void checkListProductsResponse(api.ListProductsResponse o) {
  buildCounterListProductsResponse++;
  if (buildCounterListProductsResponse < 3) {
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
    checkUnnamed6417(o.products!);
  }
  buildCounterListProductsResponse--;
}

core.List<api.ReferenceImage> buildUnnamed6418() {
  var o = <api.ReferenceImage>[];
  o.add(buildReferenceImage());
  o.add(buildReferenceImage());
  return o;
}

void checkUnnamed6418(core.List<api.ReferenceImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkReferenceImage(o[0] as api.ReferenceImage);
  checkReferenceImage(o[1] as api.ReferenceImage);
}

core.int buildCounterListReferenceImagesResponse = 0;
api.ListReferenceImagesResponse buildListReferenceImagesResponse() {
  var o = api.ListReferenceImagesResponse();
  buildCounterListReferenceImagesResponse++;
  if (buildCounterListReferenceImagesResponse < 3) {
    o.nextPageToken = 'foo';
    o.pageSize = 42;
    o.referenceImages = buildUnnamed6418();
  }
  buildCounterListReferenceImagesResponse--;
  return o;
}

void checkListReferenceImagesResponse(api.ListReferenceImagesResponse o) {
  buildCounterListReferenceImagesResponse++;
  if (buildCounterListReferenceImagesResponse < 3) {
    unittest.expect(
      o.nextPageToken!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.pageSize!,
      unittest.equals(42),
    );
    checkUnnamed6418(o.referenceImages!);
  }
  buildCounterListReferenceImagesResponse--;
}

core.int buildCounterLocalizedObjectAnnotation = 0;
api.LocalizedObjectAnnotation buildLocalizedObjectAnnotation() {
  var o = api.LocalizedObjectAnnotation();
  buildCounterLocalizedObjectAnnotation++;
  if (buildCounterLocalizedObjectAnnotation < 3) {
    o.boundingPoly = buildBoundingPoly();
    o.languageCode = 'foo';
    o.mid = 'foo';
    o.name = 'foo';
    o.score = 42.0;
  }
  buildCounterLocalizedObjectAnnotation--;
  return o;
}

void checkLocalizedObjectAnnotation(api.LocalizedObjectAnnotation o) {
  buildCounterLocalizedObjectAnnotation++;
  if (buildCounterLocalizedObjectAnnotation < 3) {
    checkBoundingPoly(o.boundingPoly! as api.BoundingPoly);
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.mid!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterLocalizedObjectAnnotation--;
}

core.int buildCounterLocationInfo = 0;
api.LocationInfo buildLocationInfo() {
  var o = api.LocationInfo();
  buildCounterLocationInfo++;
  if (buildCounterLocationInfo < 3) {
    o.latLng = buildLatLng();
  }
  buildCounterLocationInfo--;
  return o;
}

void checkLocationInfo(api.LocationInfo o) {
  buildCounterLocationInfo++;
  if (buildCounterLocationInfo < 3) {
    checkLatLng(o.latLng! as api.LatLng);
  }
  buildCounterLocationInfo--;
}

core.int buildCounterNormalizedVertex = 0;
api.NormalizedVertex buildNormalizedVertex() {
  var o = api.NormalizedVertex();
  buildCounterNormalizedVertex++;
  if (buildCounterNormalizedVertex < 3) {
    o.x = 42.0;
    o.y = 42.0;
  }
  buildCounterNormalizedVertex--;
  return o;
}

void checkNormalizedVertex(api.NormalizedVertex o) {
  buildCounterNormalizedVertex++;
  if (buildCounterNormalizedVertex < 3) {
    unittest.expect(
      o.x!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.y!,
      unittest.equals(42.0),
    );
  }
  buildCounterNormalizedVertex--;
}

core.int buildCounterObjectAnnotation = 0;
api.ObjectAnnotation buildObjectAnnotation() {
  var o = api.ObjectAnnotation();
  buildCounterObjectAnnotation++;
  if (buildCounterObjectAnnotation < 3) {
    o.languageCode = 'foo';
    o.mid = 'foo';
    o.name = 'foo';
    o.score = 42.0;
  }
  buildCounterObjectAnnotation--;
  return o;
}

void checkObjectAnnotation(api.ObjectAnnotation o) {
  buildCounterObjectAnnotation++;
  if (buildCounterObjectAnnotation < 3) {
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.mid!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterObjectAnnotation--;
}

core.Map<core.String, core.Object> buildUnnamed6419() {
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

void checkUnnamed6419(core.Map<core.String, core.Object> o) {
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

core.Map<core.String, core.Object> buildUnnamed6420() {
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

void checkUnnamed6420(core.Map<core.String, core.Object> o) {
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
    o.metadata = buildUnnamed6419();
    o.name = 'foo';
    o.response = buildUnnamed6420();
  }
  buildCounterOperation--;
  return o;
}

void checkOperation(api.Operation o) {
  buildCounterOperation++;
  if (buildCounterOperation < 3) {
    unittest.expect(o.done!, unittest.isTrue);
    checkStatus(o.error! as api.Status);
    checkUnnamed6419(o.metadata!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    checkUnnamed6420(o.response!);
  }
  buildCounterOperation--;
}

core.int buildCounterOperationMetadata = 0;
api.OperationMetadata buildOperationMetadata() {
  var o = api.OperationMetadata();
  buildCounterOperationMetadata++;
  if (buildCounterOperationMetadata < 3) {
    o.createTime = 'foo';
    o.state = 'foo';
    o.updateTime = 'foo';
  }
  buildCounterOperationMetadata--;
  return o;
}

void checkOperationMetadata(api.OperationMetadata o) {
  buildCounterOperationMetadata++;
  if (buildCounterOperationMetadata < 3) {
    unittest.expect(
      o.createTime!,
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
  buildCounterOperationMetadata--;
}

core.int buildCounterOutputConfig = 0;
api.OutputConfig buildOutputConfig() {
  var o = api.OutputConfig();
  buildCounterOutputConfig++;
  if (buildCounterOutputConfig < 3) {
    o.batchSize = 42;
    o.gcsDestination = buildGcsDestination();
  }
  buildCounterOutputConfig--;
  return o;
}

void checkOutputConfig(api.OutputConfig o) {
  buildCounterOutputConfig++;
  if (buildCounterOutputConfig < 3) {
    unittest.expect(
      o.batchSize!,
      unittest.equals(42),
    );
    checkGcsDestination(o.gcsDestination! as api.GcsDestination);
  }
  buildCounterOutputConfig--;
}

core.List<api.Block> buildUnnamed6421() {
  var o = <api.Block>[];
  o.add(buildBlock());
  o.add(buildBlock());
  return o;
}

void checkUnnamed6421(core.List<api.Block> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBlock(o[0] as api.Block);
  checkBlock(o[1] as api.Block);
}

core.int buildCounterPage = 0;
api.Page buildPage() {
  var o = api.Page();
  buildCounterPage++;
  if (buildCounterPage < 3) {
    o.blocks = buildUnnamed6421();
    o.confidence = 42.0;
    o.height = 42;
    o.property = buildTextProperty();
    o.width = 42;
  }
  buildCounterPage--;
  return o;
}

void checkPage(api.Page o) {
  buildCounterPage++;
  if (buildCounterPage < 3) {
    checkUnnamed6421(o.blocks!);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.height!,
      unittest.equals(42),
    );
    checkTextProperty(o.property! as api.TextProperty);
    unittest.expect(
      o.width!,
      unittest.equals(42),
    );
  }
  buildCounterPage--;
}

core.List<api.Word> buildUnnamed6422() {
  var o = <api.Word>[];
  o.add(buildWord());
  o.add(buildWord());
  return o;
}

void checkUnnamed6422(core.List<api.Word> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkWord(o[0] as api.Word);
  checkWord(o[1] as api.Word);
}

core.int buildCounterParagraph = 0;
api.Paragraph buildParagraph() {
  var o = api.Paragraph();
  buildCounterParagraph++;
  if (buildCounterParagraph < 3) {
    o.boundingBox = buildBoundingPoly();
    o.confidence = 42.0;
    o.property = buildTextProperty();
    o.words = buildUnnamed6422();
  }
  buildCounterParagraph--;
  return o;
}

void checkParagraph(api.Paragraph o) {
  buildCounterParagraph++;
  if (buildCounterParagraph < 3) {
    checkBoundingPoly(o.boundingBox! as api.BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkTextProperty(o.property! as api.TextProperty);
    checkUnnamed6422(o.words!);
  }
  buildCounterParagraph--;
}

core.int buildCounterPosition = 0;
api.Position buildPosition() {
  var o = api.Position();
  buildCounterPosition++;
  if (buildCounterPosition < 3) {
    o.x = 42.0;
    o.y = 42.0;
    o.z = 42.0;
  }
  buildCounterPosition--;
  return o;
}

void checkPosition(api.Position o) {
  buildCounterPosition++;
  if (buildCounterPosition < 3) {
    unittest.expect(
      o.x!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.y!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.z!,
      unittest.equals(42.0),
    );
  }
  buildCounterPosition--;
}

core.List<api.KeyValue> buildUnnamed6423() {
  var o = <api.KeyValue>[];
  o.add(buildKeyValue());
  o.add(buildKeyValue());
  return o;
}

void checkUnnamed6423(core.List<api.KeyValue> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkKeyValue(o[0] as api.KeyValue);
  checkKeyValue(o[1] as api.KeyValue);
}

core.int buildCounterProduct = 0;
api.Product buildProduct() {
  var o = api.Product();
  buildCounterProduct++;
  if (buildCounterProduct < 3) {
    o.description = 'foo';
    o.displayName = 'foo';
    o.name = 'foo';
    o.productCategory = 'foo';
    o.productLabels = buildUnnamed6423();
  }
  buildCounterProduct--;
  return o;
}

void checkProduct(api.Product o) {
  buildCounterProduct++;
  if (buildCounterProduct < 3) {
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
      o.productCategory!,
      unittest.equals('foo'),
    );
    checkUnnamed6423(o.productLabels!);
  }
  buildCounterProduct--;
}

core.List<core.String> buildUnnamed6424() {
  var o = <core.String>[];
  o.add('foo');
  o.add('foo');
  return o;
}

void checkUnnamed6424(core.List<core.String> o) {
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

core.int buildCounterProductSearchParams = 0;
api.ProductSearchParams buildProductSearchParams() {
  var o = api.ProductSearchParams();
  buildCounterProductSearchParams++;
  if (buildCounterProductSearchParams < 3) {
    o.boundingPoly = buildBoundingPoly();
    o.filter = 'foo';
    o.productCategories = buildUnnamed6424();
    o.productSet = 'foo';
  }
  buildCounterProductSearchParams--;
  return o;
}

void checkProductSearchParams(api.ProductSearchParams o) {
  buildCounterProductSearchParams++;
  if (buildCounterProductSearchParams < 3) {
    checkBoundingPoly(o.boundingPoly! as api.BoundingPoly);
    unittest.expect(
      o.filter!,
      unittest.equals('foo'),
    );
    checkUnnamed6424(o.productCategories!);
    unittest.expect(
      o.productSet!,
      unittest.equals('foo'),
    );
  }
  buildCounterProductSearchParams--;
}

core.List<api.GroupedResult> buildUnnamed6425() {
  var o = <api.GroupedResult>[];
  o.add(buildGroupedResult());
  o.add(buildGroupedResult());
  return o;
}

void checkUnnamed6425(core.List<api.GroupedResult> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkGroupedResult(o[0] as api.GroupedResult);
  checkGroupedResult(o[1] as api.GroupedResult);
}

core.List<api.Result> buildUnnamed6426() {
  var o = <api.Result>[];
  o.add(buildResult());
  o.add(buildResult());
  return o;
}

void checkUnnamed6426(core.List<api.Result> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkResult(o[0] as api.Result);
  checkResult(o[1] as api.Result);
}

core.int buildCounterProductSearchResults = 0;
api.ProductSearchResults buildProductSearchResults() {
  var o = api.ProductSearchResults();
  buildCounterProductSearchResults++;
  if (buildCounterProductSearchResults < 3) {
    o.indexTime = 'foo';
    o.productGroupedResults = buildUnnamed6425();
    o.results = buildUnnamed6426();
  }
  buildCounterProductSearchResults--;
  return o;
}

void checkProductSearchResults(api.ProductSearchResults o) {
  buildCounterProductSearchResults++;
  if (buildCounterProductSearchResults < 3) {
    unittest.expect(
      o.indexTime!,
      unittest.equals('foo'),
    );
    checkUnnamed6425(o.productGroupedResults!);
    checkUnnamed6426(o.results!);
  }
  buildCounterProductSearchResults--;
}

core.int buildCounterProductSet = 0;
api.ProductSet buildProductSet() {
  var o = api.ProductSet();
  buildCounterProductSet++;
  if (buildCounterProductSet < 3) {
    o.displayName = 'foo';
    o.indexError = buildStatus();
    o.indexTime = 'foo';
    o.name = 'foo';
  }
  buildCounterProductSet--;
  return o;
}

void checkProductSet(api.ProductSet o) {
  buildCounterProductSet++;
  if (buildCounterProductSet < 3) {
    unittest.expect(
      o.displayName!,
      unittest.equals('foo'),
    );
    checkStatus(o.indexError! as api.Status);
    unittest.expect(
      o.indexTime!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
  }
  buildCounterProductSet--;
}

core.int buildCounterProductSetPurgeConfig = 0;
api.ProductSetPurgeConfig buildProductSetPurgeConfig() {
  var o = api.ProductSetPurgeConfig();
  buildCounterProductSetPurgeConfig++;
  if (buildCounterProductSetPurgeConfig < 3) {
    o.productSetId = 'foo';
  }
  buildCounterProductSetPurgeConfig--;
  return o;
}

void checkProductSetPurgeConfig(api.ProductSetPurgeConfig o) {
  buildCounterProductSetPurgeConfig++;
  if (buildCounterProductSetPurgeConfig < 3) {
    unittest.expect(
      o.productSetId!,
      unittest.equals('foo'),
    );
  }
  buildCounterProductSetPurgeConfig--;
}

core.int buildCounterProperty = 0;
api.Property buildProperty() {
  var o = api.Property();
  buildCounterProperty++;
  if (buildCounterProperty < 3) {
    o.name = 'foo';
    o.uint64Value = 'foo';
    o.value = 'foo';
  }
  buildCounterProperty--;
  return o;
}

void checkProperty(api.Property o) {
  buildCounterProperty++;
  if (buildCounterProperty < 3) {
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.uint64Value!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.value!,
      unittest.equals('foo'),
    );
  }
  buildCounterProperty--;
}

core.int buildCounterPurgeProductsRequest = 0;
api.PurgeProductsRequest buildPurgeProductsRequest() {
  var o = api.PurgeProductsRequest();
  buildCounterPurgeProductsRequest++;
  if (buildCounterPurgeProductsRequest < 3) {
    o.deleteOrphanProducts = true;
    o.force = true;
    o.productSetPurgeConfig = buildProductSetPurgeConfig();
  }
  buildCounterPurgeProductsRequest--;
  return o;
}

void checkPurgeProductsRequest(api.PurgeProductsRequest o) {
  buildCounterPurgeProductsRequest++;
  if (buildCounterPurgeProductsRequest < 3) {
    unittest.expect(o.deleteOrphanProducts!, unittest.isTrue);
    unittest.expect(o.force!, unittest.isTrue);
    checkProductSetPurgeConfig(
        o.productSetPurgeConfig! as api.ProductSetPurgeConfig);
  }
  buildCounterPurgeProductsRequest--;
}

core.List<api.BoundingPoly> buildUnnamed6427() {
  var o = <api.BoundingPoly>[];
  o.add(buildBoundingPoly());
  o.add(buildBoundingPoly());
  return o;
}

void checkUnnamed6427(core.List<api.BoundingPoly> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBoundingPoly(o[0] as api.BoundingPoly);
  checkBoundingPoly(o[1] as api.BoundingPoly);
}

core.int buildCounterReferenceImage = 0;
api.ReferenceImage buildReferenceImage() {
  var o = api.ReferenceImage();
  buildCounterReferenceImage++;
  if (buildCounterReferenceImage < 3) {
    o.boundingPolys = buildUnnamed6427();
    o.name = 'foo';
    o.uri = 'foo';
  }
  buildCounterReferenceImage--;
  return o;
}

void checkReferenceImage(api.ReferenceImage o) {
  buildCounterReferenceImage++;
  if (buildCounterReferenceImage < 3) {
    checkUnnamed6427(o.boundingPolys!);
    unittest.expect(
      o.name!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.uri!,
      unittest.equals('foo'),
    );
  }
  buildCounterReferenceImage--;
}

core.int buildCounterRemoveProductFromProductSetRequest = 0;
api.RemoveProductFromProductSetRequest
    buildRemoveProductFromProductSetRequest() {
  var o = api.RemoveProductFromProductSetRequest();
  buildCounterRemoveProductFromProductSetRequest++;
  if (buildCounterRemoveProductFromProductSetRequest < 3) {
    o.product = 'foo';
  }
  buildCounterRemoveProductFromProductSetRequest--;
  return o;
}

void checkRemoveProductFromProductSetRequest(
    api.RemoveProductFromProductSetRequest o) {
  buildCounterRemoveProductFromProductSetRequest++;
  if (buildCounterRemoveProductFromProductSetRequest < 3) {
    unittest.expect(
      o.product!,
      unittest.equals('foo'),
    );
  }
  buildCounterRemoveProductFromProductSetRequest--;
}

core.int buildCounterResult = 0;
api.Result buildResult() {
  var o = api.Result();
  buildCounterResult++;
  if (buildCounterResult < 3) {
    o.image = 'foo';
    o.product = buildProduct();
    o.score = 42.0;
  }
  buildCounterResult--;
  return o;
}

void checkResult(api.Result o) {
  buildCounterResult++;
  if (buildCounterResult < 3) {
    unittest.expect(
      o.image!,
      unittest.equals('foo'),
    );
    checkProduct(o.product! as api.Product);
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterResult--;
}

core.int buildCounterSafeSearchAnnotation = 0;
api.SafeSearchAnnotation buildSafeSearchAnnotation() {
  var o = api.SafeSearchAnnotation();
  buildCounterSafeSearchAnnotation++;
  if (buildCounterSafeSearchAnnotation < 3) {
    o.adult = 'foo';
    o.medical = 'foo';
    o.racy = 'foo';
    o.spoof = 'foo';
    o.violence = 'foo';
  }
  buildCounterSafeSearchAnnotation--;
  return o;
}

void checkSafeSearchAnnotation(api.SafeSearchAnnotation o) {
  buildCounterSafeSearchAnnotation++;
  if (buildCounterSafeSearchAnnotation < 3) {
    unittest.expect(
      o.adult!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.medical!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.racy!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.spoof!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.violence!,
      unittest.equals('foo'),
    );
  }
  buildCounterSafeSearchAnnotation--;
}

core.Map<core.String, core.Object> buildUnnamed6428() {
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

void checkUnnamed6428(core.Map<core.String, core.Object> o) {
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

core.List<core.Map<core.String, core.Object>> buildUnnamed6429() {
  var o = <core.Map<core.String, core.Object>>[];
  o.add(buildUnnamed6428());
  o.add(buildUnnamed6428());
  return o;
}

void checkUnnamed6429(core.List<core.Map<core.String, core.Object>> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkUnnamed6428(o[0]);
  checkUnnamed6428(o[1]);
}

core.int buildCounterStatus = 0;
api.Status buildStatus() {
  var o = api.Status();
  buildCounterStatus++;
  if (buildCounterStatus < 3) {
    o.code = 42;
    o.details = buildUnnamed6429();
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
    checkUnnamed6429(o.details!);
    unittest.expect(
      o.message!,
      unittest.equals('foo'),
    );
  }
  buildCounterStatus--;
}

core.int buildCounterSymbol = 0;
api.Symbol buildSymbol() {
  var o = api.Symbol();
  buildCounterSymbol++;
  if (buildCounterSymbol < 3) {
    o.boundingBox = buildBoundingPoly();
    o.confidence = 42.0;
    o.property = buildTextProperty();
    o.text = 'foo';
  }
  buildCounterSymbol--;
  return o;
}

void checkSymbol(api.Symbol o) {
  buildCounterSymbol++;
  if (buildCounterSymbol < 3) {
    checkBoundingPoly(o.boundingBox! as api.BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkTextProperty(o.property! as api.TextProperty);
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterSymbol--;
}

core.List<api.Page> buildUnnamed6430() {
  var o = <api.Page>[];
  o.add(buildPage());
  o.add(buildPage());
  return o;
}

void checkUnnamed6430(core.List<api.Page> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPage(o[0] as api.Page);
  checkPage(o[1] as api.Page);
}

core.int buildCounterTextAnnotation = 0;
api.TextAnnotation buildTextAnnotation() {
  var o = api.TextAnnotation();
  buildCounterTextAnnotation++;
  if (buildCounterTextAnnotation < 3) {
    o.pages = buildUnnamed6430();
    o.text = 'foo';
  }
  buildCounterTextAnnotation--;
  return o;
}

void checkTextAnnotation(api.TextAnnotation o) {
  buildCounterTextAnnotation++;
  if (buildCounterTextAnnotation < 3) {
    checkUnnamed6430(o.pages!);
    unittest.expect(
      o.text!,
      unittest.equals('foo'),
    );
  }
  buildCounterTextAnnotation--;
}

core.int buildCounterTextDetectionParams = 0;
api.TextDetectionParams buildTextDetectionParams() {
  var o = api.TextDetectionParams();
  buildCounterTextDetectionParams++;
  if (buildCounterTextDetectionParams < 3) {
    o.enableTextDetectionConfidenceScore = true;
  }
  buildCounterTextDetectionParams--;
  return o;
}

void checkTextDetectionParams(api.TextDetectionParams o) {
  buildCounterTextDetectionParams++;
  if (buildCounterTextDetectionParams < 3) {
    unittest.expect(o.enableTextDetectionConfidenceScore!, unittest.isTrue);
  }
  buildCounterTextDetectionParams--;
}

core.List<api.DetectedLanguage> buildUnnamed6431() {
  var o = <api.DetectedLanguage>[];
  o.add(buildDetectedLanguage());
  o.add(buildDetectedLanguage());
  return o;
}

void checkUnnamed6431(core.List<api.DetectedLanguage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkDetectedLanguage(o[0] as api.DetectedLanguage);
  checkDetectedLanguage(o[1] as api.DetectedLanguage);
}

core.int buildCounterTextProperty = 0;
api.TextProperty buildTextProperty() {
  var o = api.TextProperty();
  buildCounterTextProperty++;
  if (buildCounterTextProperty < 3) {
    o.detectedBreak = buildDetectedBreak();
    o.detectedLanguages = buildUnnamed6431();
  }
  buildCounterTextProperty--;
  return o;
}

void checkTextProperty(api.TextProperty o) {
  buildCounterTextProperty++;
  if (buildCounterTextProperty < 3) {
    checkDetectedBreak(o.detectedBreak! as api.DetectedBreak);
    checkUnnamed6431(o.detectedLanguages!);
  }
  buildCounterTextProperty--;
}

core.int buildCounterVertex = 0;
api.Vertex buildVertex() {
  var o = api.Vertex();
  buildCounterVertex++;
  if (buildCounterVertex < 3) {
    o.x = 42;
    o.y = 42;
  }
  buildCounterVertex--;
  return o;
}

void checkVertex(api.Vertex o) {
  buildCounterVertex++;
  if (buildCounterVertex < 3) {
    unittest.expect(
      o.x!,
      unittest.equals(42),
    );
    unittest.expect(
      o.y!,
      unittest.equals(42),
    );
  }
  buildCounterVertex--;
}

core.List<api.WebLabel> buildUnnamed6432() {
  var o = <api.WebLabel>[];
  o.add(buildWebLabel());
  o.add(buildWebLabel());
  return o;
}

void checkUnnamed6432(core.List<api.WebLabel> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkWebLabel(o[0] as api.WebLabel);
  checkWebLabel(o[1] as api.WebLabel);
}

core.List<api.WebImage> buildUnnamed6433() {
  var o = <api.WebImage>[];
  o.add(buildWebImage());
  o.add(buildWebImage());
  return o;
}

void checkUnnamed6433(core.List<api.WebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkWebImage(o[0] as api.WebImage);
  checkWebImage(o[1] as api.WebImage);
}

core.List<api.WebPage> buildUnnamed6434() {
  var o = <api.WebPage>[];
  o.add(buildWebPage());
  o.add(buildWebPage());
  return o;
}

void checkUnnamed6434(core.List<api.WebPage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkWebPage(o[0] as api.WebPage);
  checkWebPage(o[1] as api.WebPage);
}

core.List<api.WebImage> buildUnnamed6435() {
  var o = <api.WebImage>[];
  o.add(buildWebImage());
  o.add(buildWebImage());
  return o;
}

void checkUnnamed6435(core.List<api.WebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkWebImage(o[0] as api.WebImage);
  checkWebImage(o[1] as api.WebImage);
}

core.List<api.WebImage> buildUnnamed6436() {
  var o = <api.WebImage>[];
  o.add(buildWebImage());
  o.add(buildWebImage());
  return o;
}

void checkUnnamed6436(core.List<api.WebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkWebImage(o[0] as api.WebImage);
  checkWebImage(o[1] as api.WebImage);
}

core.List<api.WebEntity> buildUnnamed6437() {
  var o = <api.WebEntity>[];
  o.add(buildWebEntity());
  o.add(buildWebEntity());
  return o;
}

void checkUnnamed6437(core.List<api.WebEntity> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkWebEntity(o[0] as api.WebEntity);
  checkWebEntity(o[1] as api.WebEntity);
}

core.int buildCounterWebDetection = 0;
api.WebDetection buildWebDetection() {
  var o = api.WebDetection();
  buildCounterWebDetection++;
  if (buildCounterWebDetection < 3) {
    o.bestGuessLabels = buildUnnamed6432();
    o.fullMatchingImages = buildUnnamed6433();
    o.pagesWithMatchingImages = buildUnnamed6434();
    o.partialMatchingImages = buildUnnamed6435();
    o.visuallySimilarImages = buildUnnamed6436();
    o.webEntities = buildUnnamed6437();
  }
  buildCounterWebDetection--;
  return o;
}

void checkWebDetection(api.WebDetection o) {
  buildCounterWebDetection++;
  if (buildCounterWebDetection < 3) {
    checkUnnamed6432(o.bestGuessLabels!);
    checkUnnamed6433(o.fullMatchingImages!);
    checkUnnamed6434(o.pagesWithMatchingImages!);
    checkUnnamed6435(o.partialMatchingImages!);
    checkUnnamed6436(o.visuallySimilarImages!);
    checkUnnamed6437(o.webEntities!);
  }
  buildCounterWebDetection--;
}

core.int buildCounterWebDetectionParams = 0;
api.WebDetectionParams buildWebDetectionParams() {
  var o = api.WebDetectionParams();
  buildCounterWebDetectionParams++;
  if (buildCounterWebDetectionParams < 3) {
    o.includeGeoResults = true;
  }
  buildCounterWebDetectionParams--;
  return o;
}

void checkWebDetectionParams(api.WebDetectionParams o) {
  buildCounterWebDetectionParams++;
  if (buildCounterWebDetectionParams < 3) {
    unittest.expect(o.includeGeoResults!, unittest.isTrue);
  }
  buildCounterWebDetectionParams--;
}

core.int buildCounterWebEntity = 0;
api.WebEntity buildWebEntity() {
  var o = api.WebEntity();
  buildCounterWebEntity++;
  if (buildCounterWebEntity < 3) {
    o.description = 'foo';
    o.entityId = 'foo';
    o.score = 42.0;
  }
  buildCounterWebEntity--;
  return o;
}

void checkWebEntity(api.WebEntity o) {
  buildCounterWebEntity++;
  if (buildCounterWebEntity < 3) {
    unittest.expect(
      o.description!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.entityId!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
  }
  buildCounterWebEntity--;
}

core.int buildCounterWebImage = 0;
api.WebImage buildWebImage() {
  var o = api.WebImage();
  buildCounterWebImage++;
  if (buildCounterWebImage < 3) {
    o.score = 42.0;
    o.url = 'foo';
  }
  buildCounterWebImage--;
  return o;
}

void checkWebImage(api.WebImage o) {
  buildCounterWebImage++;
  if (buildCounterWebImage < 3) {
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.url!,
      unittest.equals('foo'),
    );
  }
  buildCounterWebImage--;
}

core.int buildCounterWebLabel = 0;
api.WebLabel buildWebLabel() {
  var o = api.WebLabel();
  buildCounterWebLabel++;
  if (buildCounterWebLabel < 3) {
    o.label = 'foo';
    o.languageCode = 'foo';
  }
  buildCounterWebLabel--;
  return o;
}

void checkWebLabel(api.WebLabel o) {
  buildCounterWebLabel++;
  if (buildCounterWebLabel < 3) {
    unittest.expect(
      o.label!,
      unittest.equals('foo'),
    );
    unittest.expect(
      o.languageCode!,
      unittest.equals('foo'),
    );
  }
  buildCounterWebLabel--;
}

core.List<api.WebImage> buildUnnamed6438() {
  var o = <api.WebImage>[];
  o.add(buildWebImage());
  o.add(buildWebImage());
  return o;
}

void checkUnnamed6438(core.List<api.WebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkWebImage(o[0] as api.WebImage);
  checkWebImage(o[1] as api.WebImage);
}

core.List<api.WebImage> buildUnnamed6439() {
  var o = <api.WebImage>[];
  o.add(buildWebImage());
  o.add(buildWebImage());
  return o;
}

void checkUnnamed6439(core.List<api.WebImage> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkWebImage(o[0] as api.WebImage);
  checkWebImage(o[1] as api.WebImage);
}

core.int buildCounterWebPage = 0;
api.WebPage buildWebPage() {
  var o = api.WebPage();
  buildCounterWebPage++;
  if (buildCounterWebPage < 3) {
    o.fullMatchingImages = buildUnnamed6438();
    o.pageTitle = 'foo';
    o.partialMatchingImages = buildUnnamed6439();
    o.score = 42.0;
    o.url = 'foo';
  }
  buildCounterWebPage--;
  return o;
}

void checkWebPage(api.WebPage o) {
  buildCounterWebPage++;
  if (buildCounterWebPage < 3) {
    checkUnnamed6438(o.fullMatchingImages!);
    unittest.expect(
      o.pageTitle!,
      unittest.equals('foo'),
    );
    checkUnnamed6439(o.partialMatchingImages!);
    unittest.expect(
      o.score!,
      unittest.equals(42.0),
    );
    unittest.expect(
      o.url!,
      unittest.equals('foo'),
    );
  }
  buildCounterWebPage--;
}

core.List<api.Symbol> buildUnnamed6440() {
  var o = <api.Symbol>[];
  o.add(buildSymbol());
  o.add(buildSymbol());
  return o;
}

void checkUnnamed6440(core.List<api.Symbol> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkSymbol(o[0] as api.Symbol);
  checkSymbol(o[1] as api.Symbol);
}

core.int buildCounterWord = 0;
api.Word buildWord() {
  var o = api.Word();
  buildCounterWord++;
  if (buildCounterWord < 3) {
    o.boundingBox = buildBoundingPoly();
    o.confidence = 42.0;
    o.property = buildTextProperty();
    o.symbols = buildUnnamed6440();
  }
  buildCounterWord--;
  return o;
}

void checkWord(api.Word o) {
  buildCounterWord++;
  if (buildCounterWord < 3) {
    checkBoundingPoly(o.boundingBox! as api.BoundingPoly);
    unittest.expect(
      o.confidence!,
      unittest.equals(42.0),
    );
    checkTextProperty(o.property! as api.TextProperty);
    checkUnnamed6440(o.symbols!);
  }
  buildCounterWord--;
}

void main() {
  unittest.group('obj-schema-AddProductToProductSetRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildAddProductToProductSetRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.AddProductToProductSetRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkAddProductToProductSetRequest(
          od as api.AddProductToProductSetRequest);
    });
  });

  unittest.group('obj-schema-AnnotateFileRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildAnnotateFileRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.AnnotateFileRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkAnnotateFileRequest(od as api.AnnotateFileRequest);
    });
  });

  unittest.group('obj-schema-AnnotateFileResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildAnnotateFileResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.AnnotateFileResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkAnnotateFileResponse(od as api.AnnotateFileResponse);
    });
  });

  unittest.group('obj-schema-AnnotateImageRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildAnnotateImageRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.AnnotateImageRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkAnnotateImageRequest(od as api.AnnotateImageRequest);
    });
  });

  unittest.group('obj-schema-AnnotateImageResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildAnnotateImageResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.AnnotateImageResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkAnnotateImageResponse(od as api.AnnotateImageResponse);
    });
  });

  unittest.group('obj-schema-AsyncAnnotateFileRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildAsyncAnnotateFileRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.AsyncAnnotateFileRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkAsyncAnnotateFileRequest(od as api.AsyncAnnotateFileRequest);
    });
  });

  unittest.group('obj-schema-AsyncAnnotateFileResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildAsyncAnnotateFileResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.AsyncAnnotateFileResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkAsyncAnnotateFileResponse(od as api.AsyncAnnotateFileResponse);
    });
  });

  unittest.group('obj-schema-AsyncBatchAnnotateFilesRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildAsyncBatchAnnotateFilesRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.AsyncBatchAnnotateFilesRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkAsyncBatchAnnotateFilesRequest(
          od as api.AsyncBatchAnnotateFilesRequest);
    });
  });

  unittest.group('obj-schema-AsyncBatchAnnotateFilesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildAsyncBatchAnnotateFilesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.AsyncBatchAnnotateFilesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkAsyncBatchAnnotateFilesResponse(
          od as api.AsyncBatchAnnotateFilesResponse);
    });
  });

  unittest.group('obj-schema-AsyncBatchAnnotateImagesRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildAsyncBatchAnnotateImagesRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.AsyncBatchAnnotateImagesRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkAsyncBatchAnnotateImagesRequest(
          od as api.AsyncBatchAnnotateImagesRequest);
    });
  });

  unittest.group('obj-schema-AsyncBatchAnnotateImagesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildAsyncBatchAnnotateImagesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.AsyncBatchAnnotateImagesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkAsyncBatchAnnotateImagesResponse(
          od as api.AsyncBatchAnnotateImagesResponse);
    });
  });

  unittest.group('obj-schema-BatchAnnotateFilesRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildBatchAnnotateFilesRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.BatchAnnotateFilesRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkBatchAnnotateFilesRequest(od as api.BatchAnnotateFilesRequest);
    });
  });

  unittest.group('obj-schema-BatchAnnotateFilesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildBatchAnnotateFilesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.BatchAnnotateFilesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkBatchAnnotateFilesResponse(od as api.BatchAnnotateFilesResponse);
    });
  });

  unittest.group('obj-schema-BatchAnnotateImagesRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildBatchAnnotateImagesRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.BatchAnnotateImagesRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkBatchAnnotateImagesRequest(od as api.BatchAnnotateImagesRequest);
    });
  });

  unittest.group('obj-schema-BatchAnnotateImagesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildBatchAnnotateImagesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.BatchAnnotateImagesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkBatchAnnotateImagesResponse(od as api.BatchAnnotateImagesResponse);
    });
  });

  unittest.group('obj-schema-BatchOperationMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildBatchOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.BatchOperationMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkBatchOperationMetadata(od as api.BatchOperationMetadata);
    });
  });

  unittest.group('obj-schema-Block', () {
    unittest.test('to-json--from-json', () async {
      var o = buildBlock();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.Block.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkBlock(od as api.Block);
    });
  });

  unittest.group('obj-schema-BoundingPoly', () {
    unittest.test('to-json--from-json', () async {
      var o = buildBoundingPoly();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.BoundingPoly.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkBoundingPoly(od as api.BoundingPoly);
    });
  });

  unittest.group('obj-schema-CancelOperationRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildCancelOperationRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.CancelOperationRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkCancelOperationRequest(od as api.CancelOperationRequest);
    });
  });

  unittest.group('obj-schema-Color', () {
    unittest.test('to-json--from-json', () async {
      var o = buildColor();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.Color.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkColor(od as api.Color);
    });
  });

  unittest.group('obj-schema-ColorInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildColorInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.ColorInfo.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkColorInfo(od as api.ColorInfo);
    });
  });

  unittest.group('obj-schema-CropHint', () {
    unittest.test('to-json--from-json', () async {
      var o = buildCropHint();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.CropHint.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkCropHint(od as api.CropHint);
    });
  });

  unittest.group('obj-schema-CropHintsAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildCropHintsAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.CropHintsAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkCropHintsAnnotation(od as api.CropHintsAnnotation);
    });
  });

  unittest.group('obj-schema-CropHintsParams', () {
    unittest.test('to-json--from-json', () async {
      var o = buildCropHintsParams();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.CropHintsParams.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkCropHintsParams(od as api.CropHintsParams);
    });
  });

  unittest.group('obj-schema-DetectedBreak', () {
    unittest.test('to-json--from-json', () async {
      var o = buildDetectedBreak();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.DetectedBreak.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkDetectedBreak(od as api.DetectedBreak);
    });
  });

  unittest.group('obj-schema-DetectedLanguage', () {
    unittest.test('to-json--from-json', () async {
      var o = buildDetectedLanguage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.DetectedLanguage.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkDetectedLanguage(od as api.DetectedLanguage);
    });
  });

  unittest.group('obj-schema-DominantColorsAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildDominantColorsAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.DominantColorsAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkDominantColorsAnnotation(od as api.DominantColorsAnnotation);
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

  unittest.group('obj-schema-EntityAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildEntityAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.EntityAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkEntityAnnotation(od as api.EntityAnnotation);
    });
  });

  unittest.group('obj-schema-FaceAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildFaceAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.FaceAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkFaceAnnotation(od as api.FaceAnnotation);
    });
  });

  unittest.group('obj-schema-Feature', () {
    unittest.test('to-json--from-json', () async {
      var o = buildFeature();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Feature.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkFeature(od as api.Feature);
    });
  });

  unittest.group('obj-schema-GcsDestination', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGcsDestination();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GcsDestination.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGcsDestination(od as api.GcsDestination);
    });
  });

  unittest.group('obj-schema-GcsSource', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGcsSource();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GcsSource.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGcsSource(od as api.GcsSource);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1AnnotateFileResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1AnnotateFileResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1AnnotateFileResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1AnnotateFileResponse(
          od as api.GoogleCloudVisionV1p1beta1AnnotateFileResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1AnnotateImageResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1AnnotateImageResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1AnnotateImageResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1AnnotateImageResponse(
          od as api.GoogleCloudVisionV1p1beta1AnnotateImageResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse(
          od as api.GoogleCloudVisionV1p1beta1AsyncAnnotateFileResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p1beta1AsyncBatchAnnotateFilesResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1AsyncBatchAnnotateFilesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1AsyncBatchAnnotateFilesResponse
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1AsyncBatchAnnotateFilesResponse(
          od as api.GoogleCloudVisionV1p1beta1AsyncBatchAnnotateFilesResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1Block', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1Block();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1Block.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1Block(
          od as api.GoogleCloudVisionV1p1beta1Block);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1BoundingPoly', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1BoundingPoly();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1BoundingPoly.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1BoundingPoly(
          od as api.GoogleCloudVisionV1p1beta1BoundingPoly);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1ColorInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1ColorInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1ColorInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1ColorInfo(
          od as api.GoogleCloudVisionV1p1beta1ColorInfo);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1CropHint', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1CropHint();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1CropHint.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1CropHint(
          od as api.GoogleCloudVisionV1p1beta1CropHint);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1CropHintsAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1CropHintsAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1CropHintsAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1CropHintsAnnotation(
          od as api.GoogleCloudVisionV1p1beta1CropHintsAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p1beta1DominantColorsAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1DominantColorsAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1DominantColorsAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1DominantColorsAnnotation(
          od as api.GoogleCloudVisionV1p1beta1DominantColorsAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1EntityAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1EntityAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1EntityAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1EntityAnnotation(
          od as api.GoogleCloudVisionV1p1beta1EntityAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1FaceAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1FaceAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1FaceAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1FaceAnnotation(
          od as api.GoogleCloudVisionV1p1beta1FaceAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1FaceAnnotationLandmark',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1FaceAnnotationLandmark();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1FaceAnnotationLandmark.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1FaceAnnotationLandmark(
          od as api.GoogleCloudVisionV1p1beta1FaceAnnotationLandmark);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1GcsDestination', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1GcsDestination();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1GcsDestination.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1GcsDestination(
          od as api.GoogleCloudVisionV1p1beta1GcsDestination);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1GcsSource', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1GcsSource();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1GcsSource.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1GcsSource(
          od as api.GoogleCloudVisionV1p1beta1GcsSource);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1ImageAnnotationContext',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1ImageAnnotationContext();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1ImageAnnotationContext.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1ImageAnnotationContext(
          od as api.GoogleCloudVisionV1p1beta1ImageAnnotationContext);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1ImageProperties', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1ImageProperties();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1ImageProperties.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1ImageProperties(
          od as api.GoogleCloudVisionV1p1beta1ImageProperties);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1InputConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1InputConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1InputConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1InputConfig(
          od as api.GoogleCloudVisionV1p1beta1InputConfig);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p1beta1LocalizedObjectAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1LocalizedObjectAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1LocalizedObjectAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1LocalizedObjectAnnotation(
          od as api.GoogleCloudVisionV1p1beta1LocalizedObjectAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1LocationInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1LocationInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1LocationInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1LocationInfo(
          od as api.GoogleCloudVisionV1p1beta1LocationInfo);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1NormalizedVertex', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1NormalizedVertex();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1NormalizedVertex.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1NormalizedVertex(
          od as api.GoogleCloudVisionV1p1beta1NormalizedVertex);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1OperationMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1OperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1OperationMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1OperationMetadata(
          od as api.GoogleCloudVisionV1p1beta1OperationMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1OutputConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1OutputConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1OutputConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1OutputConfig(
          od as api.GoogleCloudVisionV1p1beta1OutputConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1Page', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1Page();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1Page.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1Page(
          od as api.GoogleCloudVisionV1p1beta1Page);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1Paragraph', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1Paragraph();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1Paragraph.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1Paragraph(
          od as api.GoogleCloudVisionV1p1beta1Paragraph);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1Position', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1Position();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1Position.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1Position(
          od as api.GoogleCloudVisionV1p1beta1Position);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1Product', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1Product();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1Product.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1Product(
          od as api.GoogleCloudVisionV1p1beta1Product);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1ProductKeyValue', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1ProductKeyValue();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1ProductKeyValue.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1ProductKeyValue(
          od as api.GoogleCloudVisionV1p1beta1ProductKeyValue);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1ProductSearchResults',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1ProductSearchResults();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1ProductSearchResults.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1ProductSearchResults(
          od as api.GoogleCloudVisionV1p1beta1ProductSearchResults);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult(od
          as api.GoogleCloudVisionV1p1beta1ProductSearchResultsGroupedResult);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation(od
          as api
              .GoogleCloudVisionV1p1beta1ProductSearchResultsObjectAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p1beta1ProductSearchResultsResult', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1ProductSearchResultsResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVisionV1p1beta1ProductSearchResultsResult.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1ProductSearchResultsResult(
          od as api.GoogleCloudVisionV1p1beta1ProductSearchResultsResult);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1Property', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1Property();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1Property.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1Property(
          od as api.GoogleCloudVisionV1p1beta1Property);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1SafeSearchAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1SafeSearchAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1SafeSearchAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1SafeSearchAnnotation(
          od as api.GoogleCloudVisionV1p1beta1SafeSearchAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1Symbol', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1Symbol();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1Symbol.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1Symbol(
          od as api.GoogleCloudVisionV1p1beta1Symbol);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1TextAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1TextAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1TextAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1TextAnnotation(
          od as api.GoogleCloudVisionV1p1beta1TextAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p1beta1TextAnnotationDetectedBreak', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1TextAnnotationDetectedBreak();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVisionV1p1beta1TextAnnotationDetectedBreak.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1TextAnnotationDetectedBreak(
          od as api.GoogleCloudVisionV1p1beta1TextAnnotationDetectedBreak);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage(
          od as api.GoogleCloudVisionV1p1beta1TextAnnotationDetectedLanguage);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p1beta1TextAnnotationTextProperty', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1TextAnnotationTextProperty();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVisionV1p1beta1TextAnnotationTextProperty.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1TextAnnotationTextProperty(
          od as api.GoogleCloudVisionV1p1beta1TextAnnotationTextProperty);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1Vertex', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1Vertex();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1Vertex.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1Vertex(
          od as api.GoogleCloudVisionV1p1beta1Vertex);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1WebDetection', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1WebDetection();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1WebDetection.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1WebDetection(
          od as api.GoogleCloudVisionV1p1beta1WebDetection);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1WebDetectionWebEntity',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1WebDetectionWebEntity();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1WebDetectionWebEntity.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1WebDetectionWebEntity(
          od as api.GoogleCloudVisionV1p1beta1WebDetectionWebEntity);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1WebDetectionWebImage',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1WebDetectionWebImage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1WebDetectionWebImage.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1WebDetectionWebImage(
          od as api.GoogleCloudVisionV1p1beta1WebDetectionWebImage);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1WebDetectionWebLabel',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1WebDetectionWebLabel();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1WebDetectionWebLabel.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1WebDetectionWebLabel(
          od as api.GoogleCloudVisionV1p1beta1WebDetectionWebLabel);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1WebDetectionWebPage',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1WebDetectionWebPage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1WebDetectionWebPage.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1WebDetectionWebPage(
          od as api.GoogleCloudVisionV1p1beta1WebDetectionWebPage);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p1beta1Word', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p1beta1Word();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p1beta1Word.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p1beta1Word(
          od as api.GoogleCloudVisionV1p1beta1Word);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1AnnotateFileResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1AnnotateFileResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1AnnotateFileResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1AnnotateFileResponse(
          od as api.GoogleCloudVisionV1p2beta1AnnotateFileResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1AnnotateImageResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1AnnotateImageResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1AnnotateImageResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1AnnotateImageResponse(
          od as api.GoogleCloudVisionV1p2beta1AnnotateImageResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse(
          od as api.GoogleCloudVisionV1p2beta1AsyncAnnotateFileResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p2beta1AsyncBatchAnnotateFilesResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1AsyncBatchAnnotateFilesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1AsyncBatchAnnotateFilesResponse
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1AsyncBatchAnnotateFilesResponse(
          od as api.GoogleCloudVisionV1p2beta1AsyncBatchAnnotateFilesResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1Block', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1Block();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1Block.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1Block(
          od as api.GoogleCloudVisionV1p2beta1Block);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1BoundingPoly', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1BoundingPoly();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1BoundingPoly.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1BoundingPoly(
          od as api.GoogleCloudVisionV1p2beta1BoundingPoly);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1ColorInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1ColorInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1ColorInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1ColorInfo(
          od as api.GoogleCloudVisionV1p2beta1ColorInfo);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1CropHint', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1CropHint();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1CropHint.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1CropHint(
          od as api.GoogleCloudVisionV1p2beta1CropHint);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1CropHintsAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1CropHintsAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1CropHintsAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1CropHintsAnnotation(
          od as api.GoogleCloudVisionV1p2beta1CropHintsAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p2beta1DominantColorsAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1DominantColorsAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1DominantColorsAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1DominantColorsAnnotation(
          od as api.GoogleCloudVisionV1p2beta1DominantColorsAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1EntityAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1EntityAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1EntityAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1EntityAnnotation(
          od as api.GoogleCloudVisionV1p2beta1EntityAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1FaceAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1FaceAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1FaceAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1FaceAnnotation(
          od as api.GoogleCloudVisionV1p2beta1FaceAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1FaceAnnotationLandmark',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1FaceAnnotationLandmark();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1FaceAnnotationLandmark.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1FaceAnnotationLandmark(
          od as api.GoogleCloudVisionV1p2beta1FaceAnnotationLandmark);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1GcsDestination', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1GcsDestination();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1GcsDestination.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1GcsDestination(
          od as api.GoogleCloudVisionV1p2beta1GcsDestination);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1GcsSource', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1GcsSource();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1GcsSource.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1GcsSource(
          od as api.GoogleCloudVisionV1p2beta1GcsSource);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1ImageAnnotationContext',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1ImageAnnotationContext();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1ImageAnnotationContext.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1ImageAnnotationContext(
          od as api.GoogleCloudVisionV1p2beta1ImageAnnotationContext);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1ImageProperties', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1ImageProperties();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1ImageProperties.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1ImageProperties(
          od as api.GoogleCloudVisionV1p2beta1ImageProperties);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1InputConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1InputConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1InputConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1InputConfig(
          od as api.GoogleCloudVisionV1p2beta1InputConfig);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p2beta1LocalizedObjectAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1LocalizedObjectAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1LocalizedObjectAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1LocalizedObjectAnnotation(
          od as api.GoogleCloudVisionV1p2beta1LocalizedObjectAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1LocationInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1LocationInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1LocationInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1LocationInfo(
          od as api.GoogleCloudVisionV1p2beta1LocationInfo);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1NormalizedVertex', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1NormalizedVertex();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1NormalizedVertex.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1NormalizedVertex(
          od as api.GoogleCloudVisionV1p2beta1NormalizedVertex);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1OperationMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1OperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1OperationMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1OperationMetadata(
          od as api.GoogleCloudVisionV1p2beta1OperationMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1OutputConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1OutputConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1OutputConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1OutputConfig(
          od as api.GoogleCloudVisionV1p2beta1OutputConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1Page', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1Page();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1Page.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1Page(
          od as api.GoogleCloudVisionV1p2beta1Page);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1Paragraph', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1Paragraph();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1Paragraph.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1Paragraph(
          od as api.GoogleCloudVisionV1p2beta1Paragraph);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1Position', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1Position();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1Position.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1Position(
          od as api.GoogleCloudVisionV1p2beta1Position);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1Product', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1Product();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1Product.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1Product(
          od as api.GoogleCloudVisionV1p2beta1Product);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1ProductKeyValue', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1ProductKeyValue();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1ProductKeyValue.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1ProductKeyValue(
          od as api.GoogleCloudVisionV1p2beta1ProductKeyValue);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1ProductSearchResults',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1ProductSearchResults();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1ProductSearchResults.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1ProductSearchResults(
          od as api.GoogleCloudVisionV1p2beta1ProductSearchResults);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult(od
          as api.GoogleCloudVisionV1p2beta1ProductSearchResultsGroupedResult);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation(od
          as api
              .GoogleCloudVisionV1p2beta1ProductSearchResultsObjectAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p2beta1ProductSearchResultsResult', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1ProductSearchResultsResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVisionV1p2beta1ProductSearchResultsResult.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1ProductSearchResultsResult(
          od as api.GoogleCloudVisionV1p2beta1ProductSearchResultsResult);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1Property', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1Property();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1Property.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1Property(
          od as api.GoogleCloudVisionV1p2beta1Property);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1SafeSearchAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1SafeSearchAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1SafeSearchAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1SafeSearchAnnotation(
          od as api.GoogleCloudVisionV1p2beta1SafeSearchAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1Symbol', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1Symbol();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1Symbol.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1Symbol(
          od as api.GoogleCloudVisionV1p2beta1Symbol);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1TextAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1TextAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1TextAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1TextAnnotation(
          od as api.GoogleCloudVisionV1p2beta1TextAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p2beta1TextAnnotationDetectedBreak', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1TextAnnotationDetectedBreak();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVisionV1p2beta1TextAnnotationDetectedBreak.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1TextAnnotationDetectedBreak(
          od as api.GoogleCloudVisionV1p2beta1TextAnnotationDetectedBreak);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage(
          od as api.GoogleCloudVisionV1p2beta1TextAnnotationDetectedLanguage);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p2beta1TextAnnotationTextProperty', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1TextAnnotationTextProperty();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVisionV1p2beta1TextAnnotationTextProperty.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1TextAnnotationTextProperty(
          od as api.GoogleCloudVisionV1p2beta1TextAnnotationTextProperty);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1Vertex', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1Vertex();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1Vertex.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1Vertex(
          od as api.GoogleCloudVisionV1p2beta1Vertex);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1WebDetection', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1WebDetection();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1WebDetection.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1WebDetection(
          od as api.GoogleCloudVisionV1p2beta1WebDetection);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1WebDetectionWebEntity',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1WebDetectionWebEntity();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1WebDetectionWebEntity.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1WebDetectionWebEntity(
          od as api.GoogleCloudVisionV1p2beta1WebDetectionWebEntity);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1WebDetectionWebImage',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1WebDetectionWebImage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1WebDetectionWebImage.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1WebDetectionWebImage(
          od as api.GoogleCloudVisionV1p2beta1WebDetectionWebImage);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1WebDetectionWebLabel',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1WebDetectionWebLabel();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1WebDetectionWebLabel.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1WebDetectionWebLabel(
          od as api.GoogleCloudVisionV1p2beta1WebDetectionWebLabel);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1WebDetectionWebPage',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1WebDetectionWebPage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1WebDetectionWebPage.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1WebDetectionWebPage(
          od as api.GoogleCloudVisionV1p2beta1WebDetectionWebPage);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p2beta1Word', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p2beta1Word();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p2beta1Word.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p2beta1Word(
          od as api.GoogleCloudVisionV1p2beta1Word);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1AnnotateFileResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1AnnotateFileResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1AnnotateFileResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1AnnotateFileResponse(
          od as api.GoogleCloudVisionV1p3beta1AnnotateFileResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1AnnotateImageResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1AnnotateImageResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1AnnotateImageResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1AnnotateImageResponse(
          od as api.GoogleCloudVisionV1p3beta1AnnotateImageResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse(
          od as api.GoogleCloudVisionV1p3beta1AsyncAnnotateFileResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p3beta1AsyncBatchAnnotateFilesResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1AsyncBatchAnnotateFilesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1AsyncBatchAnnotateFilesResponse
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1AsyncBatchAnnotateFilesResponse(
          od as api.GoogleCloudVisionV1p3beta1AsyncBatchAnnotateFilesResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1BatchOperationMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1BatchOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1BatchOperationMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1BatchOperationMetadata(
          od as api.GoogleCloudVisionV1p3beta1BatchOperationMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1Block', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1Block();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1Block.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1Block(
          od as api.GoogleCloudVisionV1p3beta1Block);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1BoundingPoly', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1BoundingPoly();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1BoundingPoly.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1BoundingPoly(
          od as api.GoogleCloudVisionV1p3beta1BoundingPoly);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1ColorInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1ColorInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1ColorInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1ColorInfo(
          od as api.GoogleCloudVisionV1p3beta1ColorInfo);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1CropHint', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1CropHint();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1CropHint.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1CropHint(
          od as api.GoogleCloudVisionV1p3beta1CropHint);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1CropHintsAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1CropHintsAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1CropHintsAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1CropHintsAnnotation(
          od as api.GoogleCloudVisionV1p3beta1CropHintsAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p3beta1DominantColorsAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1DominantColorsAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1DominantColorsAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1DominantColorsAnnotation(
          od as api.GoogleCloudVisionV1p3beta1DominantColorsAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1EntityAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1EntityAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1EntityAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1EntityAnnotation(
          od as api.GoogleCloudVisionV1p3beta1EntityAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1FaceAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1FaceAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1FaceAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1FaceAnnotation(
          od as api.GoogleCloudVisionV1p3beta1FaceAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1FaceAnnotationLandmark',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1FaceAnnotationLandmark();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1FaceAnnotationLandmark.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1FaceAnnotationLandmark(
          od as api.GoogleCloudVisionV1p3beta1FaceAnnotationLandmark);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1GcsDestination', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1GcsDestination();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1GcsDestination.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1GcsDestination(
          od as api.GoogleCloudVisionV1p3beta1GcsDestination);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1GcsSource', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1GcsSource();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1GcsSource.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1GcsSource(
          od as api.GoogleCloudVisionV1p3beta1GcsSource);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1ImageAnnotationContext',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1ImageAnnotationContext();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1ImageAnnotationContext.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1ImageAnnotationContext(
          od as api.GoogleCloudVisionV1p3beta1ImageAnnotationContext);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1ImageProperties', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1ImageProperties();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1ImageProperties.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1ImageProperties(
          od as api.GoogleCloudVisionV1p3beta1ImageProperties);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p3beta1ImportProductSetsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1ImportProductSetsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1ImportProductSetsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1ImportProductSetsResponse(
          od as api.GoogleCloudVisionV1p3beta1ImportProductSetsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1InputConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1InputConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1InputConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1InputConfig(
          od as api.GoogleCloudVisionV1p3beta1InputConfig);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p3beta1LocalizedObjectAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1LocalizedObjectAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1LocalizedObjectAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1LocalizedObjectAnnotation(
          od as api.GoogleCloudVisionV1p3beta1LocalizedObjectAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1LocationInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1LocationInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1LocationInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1LocationInfo(
          od as api.GoogleCloudVisionV1p3beta1LocationInfo);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1NormalizedVertex', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1NormalizedVertex();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1NormalizedVertex.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1NormalizedVertex(
          od as api.GoogleCloudVisionV1p3beta1NormalizedVertex);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1OperationMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1OperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1OperationMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1OperationMetadata(
          od as api.GoogleCloudVisionV1p3beta1OperationMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1OutputConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1OutputConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1OutputConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1OutputConfig(
          od as api.GoogleCloudVisionV1p3beta1OutputConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1Page', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1Page();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1Page.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1Page(
          od as api.GoogleCloudVisionV1p3beta1Page);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1Paragraph', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1Paragraph();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1Paragraph.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1Paragraph(
          od as api.GoogleCloudVisionV1p3beta1Paragraph);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1Position', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1Position();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1Position.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1Position(
          od as api.GoogleCloudVisionV1p3beta1Position);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1Product', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1Product();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1Product.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1Product(
          od as api.GoogleCloudVisionV1p3beta1Product);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1ProductKeyValue', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1ProductKeyValue();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1ProductKeyValue.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1ProductKeyValue(
          od as api.GoogleCloudVisionV1p3beta1ProductKeyValue);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1ProductSearchResults',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1ProductSearchResults();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1ProductSearchResults.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1ProductSearchResults(
          od as api.GoogleCloudVisionV1p3beta1ProductSearchResults);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult(od
          as api.GoogleCloudVisionV1p3beta1ProductSearchResultsGroupedResult);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation(od
          as api
              .GoogleCloudVisionV1p3beta1ProductSearchResultsObjectAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p3beta1ProductSearchResultsResult', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1ProductSearchResultsResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVisionV1p3beta1ProductSearchResultsResult.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1ProductSearchResultsResult(
          od as api.GoogleCloudVisionV1p3beta1ProductSearchResultsResult);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1Property', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1Property();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1Property.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1Property(
          od as api.GoogleCloudVisionV1p3beta1Property);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1ReferenceImage', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1ReferenceImage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1ReferenceImage.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1ReferenceImage(
          od as api.GoogleCloudVisionV1p3beta1ReferenceImage);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1SafeSearchAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1SafeSearchAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1SafeSearchAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1SafeSearchAnnotation(
          od as api.GoogleCloudVisionV1p3beta1SafeSearchAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1Symbol', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1Symbol();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1Symbol.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1Symbol(
          od as api.GoogleCloudVisionV1p3beta1Symbol);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1TextAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1TextAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1TextAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1TextAnnotation(
          od as api.GoogleCloudVisionV1p3beta1TextAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p3beta1TextAnnotationDetectedBreak', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1TextAnnotationDetectedBreak();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVisionV1p3beta1TextAnnotationDetectedBreak.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1TextAnnotationDetectedBreak(
          od as api.GoogleCloudVisionV1p3beta1TextAnnotationDetectedBreak);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage(
          od as api.GoogleCloudVisionV1p3beta1TextAnnotationDetectedLanguage);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p3beta1TextAnnotationTextProperty', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1TextAnnotationTextProperty();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVisionV1p3beta1TextAnnotationTextProperty.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1TextAnnotationTextProperty(
          od as api.GoogleCloudVisionV1p3beta1TextAnnotationTextProperty);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1Vertex', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1Vertex();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1Vertex.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1Vertex(
          od as api.GoogleCloudVisionV1p3beta1Vertex);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1WebDetection', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1WebDetection();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1WebDetection.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1WebDetection(
          od as api.GoogleCloudVisionV1p3beta1WebDetection);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1WebDetectionWebEntity',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1WebDetectionWebEntity();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1WebDetectionWebEntity.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1WebDetectionWebEntity(
          od as api.GoogleCloudVisionV1p3beta1WebDetectionWebEntity);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1WebDetectionWebImage',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1WebDetectionWebImage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1WebDetectionWebImage.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1WebDetectionWebImage(
          od as api.GoogleCloudVisionV1p3beta1WebDetectionWebImage);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1WebDetectionWebLabel',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1WebDetectionWebLabel();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1WebDetectionWebLabel.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1WebDetectionWebLabel(
          od as api.GoogleCloudVisionV1p3beta1WebDetectionWebLabel);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1WebDetectionWebPage',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1WebDetectionWebPage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1WebDetectionWebPage.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1WebDetectionWebPage(
          od as api.GoogleCloudVisionV1p3beta1WebDetectionWebPage);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p3beta1Word', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p3beta1Word();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p3beta1Word.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p3beta1Word(
          od as api.GoogleCloudVisionV1p3beta1Word);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1AnnotateFileResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1AnnotateFileResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1AnnotateFileResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1AnnotateFileResponse(
          od as api.GoogleCloudVisionV1p4beta1AnnotateFileResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1AnnotateImageResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1AnnotateImageResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1AnnotateImageResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1AnnotateImageResponse(
          od as api.GoogleCloudVisionV1p4beta1AnnotateImageResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse(
          od as api.GoogleCloudVisionV1p4beta1AsyncAnnotateFileResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p4beta1AsyncBatchAnnotateFilesResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1AsyncBatchAnnotateFilesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1AsyncBatchAnnotateFilesResponse
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1AsyncBatchAnnotateFilesResponse(
          od as api.GoogleCloudVisionV1p4beta1AsyncBatchAnnotateFilesResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p4beta1AsyncBatchAnnotateImagesResponse',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1AsyncBatchAnnotateImagesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1AsyncBatchAnnotateImagesResponse
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1AsyncBatchAnnotateImagesResponse(
          od as api.GoogleCloudVisionV1p4beta1AsyncBatchAnnotateImagesResponse);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p4beta1BatchAnnotateFilesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1BatchAnnotateFilesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVisionV1p4beta1BatchAnnotateFilesResponse.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1BatchAnnotateFilesResponse(
          od as api.GoogleCloudVisionV1p4beta1BatchAnnotateFilesResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1BatchOperationMetadata',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1BatchOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1BatchOperationMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1BatchOperationMetadata(
          od as api.GoogleCloudVisionV1p4beta1BatchOperationMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1Block', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1Block();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1Block.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1Block(
          od as api.GoogleCloudVisionV1p4beta1Block);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1BoundingPoly', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1BoundingPoly();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1BoundingPoly.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1BoundingPoly(
          od as api.GoogleCloudVisionV1p4beta1BoundingPoly);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1Celebrity', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1Celebrity();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1Celebrity.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1Celebrity(
          od as api.GoogleCloudVisionV1p4beta1Celebrity);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1ColorInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1ColorInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1ColorInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1ColorInfo(
          od as api.GoogleCloudVisionV1p4beta1ColorInfo);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1CropHint', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1CropHint();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1CropHint.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1CropHint(
          od as api.GoogleCloudVisionV1p4beta1CropHint);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1CropHintsAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1CropHintsAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1CropHintsAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1CropHintsAnnotation(
          od as api.GoogleCloudVisionV1p4beta1CropHintsAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p4beta1DominantColorsAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1DominantColorsAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1DominantColorsAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1DominantColorsAnnotation(
          od as api.GoogleCloudVisionV1p4beta1DominantColorsAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1EntityAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1EntityAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1EntityAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1EntityAnnotation(
          od as api.GoogleCloudVisionV1p4beta1EntityAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1FaceAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1FaceAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1FaceAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1FaceAnnotation(
          od as api.GoogleCloudVisionV1p4beta1FaceAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1FaceAnnotationLandmark',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1FaceAnnotationLandmark();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1FaceAnnotationLandmark.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1FaceAnnotationLandmark(
          od as api.GoogleCloudVisionV1p4beta1FaceAnnotationLandmark);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1FaceRecognitionResult',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1FaceRecognitionResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1FaceRecognitionResult.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1FaceRecognitionResult(
          od as api.GoogleCloudVisionV1p4beta1FaceRecognitionResult);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1GcsDestination', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1GcsDestination();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1GcsDestination.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1GcsDestination(
          od as api.GoogleCloudVisionV1p4beta1GcsDestination);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1GcsSource', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1GcsSource();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1GcsSource.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1GcsSource(
          od as api.GoogleCloudVisionV1p4beta1GcsSource);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1ImageAnnotationContext',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1ImageAnnotationContext();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1ImageAnnotationContext.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1ImageAnnotationContext(
          od as api.GoogleCloudVisionV1p4beta1ImageAnnotationContext);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1ImageProperties', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1ImageProperties();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1ImageProperties.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1ImageProperties(
          od as api.GoogleCloudVisionV1p4beta1ImageProperties);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p4beta1ImportProductSetsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1ImportProductSetsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1ImportProductSetsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1ImportProductSetsResponse(
          od as api.GoogleCloudVisionV1p4beta1ImportProductSetsResponse);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1InputConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1InputConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1InputConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1InputConfig(
          od as api.GoogleCloudVisionV1p4beta1InputConfig);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p4beta1LocalizedObjectAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1LocalizedObjectAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1LocalizedObjectAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1LocalizedObjectAnnotation(
          od as api.GoogleCloudVisionV1p4beta1LocalizedObjectAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1LocationInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1LocationInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1LocationInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1LocationInfo(
          od as api.GoogleCloudVisionV1p4beta1LocationInfo);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1NormalizedVertex', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1NormalizedVertex();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1NormalizedVertex.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1NormalizedVertex(
          od as api.GoogleCloudVisionV1p4beta1NormalizedVertex);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1OperationMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1OperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1OperationMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1OperationMetadata(
          od as api.GoogleCloudVisionV1p4beta1OperationMetadata);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1OutputConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1OutputConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1OutputConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1OutputConfig(
          od as api.GoogleCloudVisionV1p4beta1OutputConfig);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1Page', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1Page();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1Page.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1Page(
          od as api.GoogleCloudVisionV1p4beta1Page);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1Paragraph', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1Paragraph();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1Paragraph.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1Paragraph(
          od as api.GoogleCloudVisionV1p4beta1Paragraph);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1Position', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1Position();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1Position.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1Position(
          od as api.GoogleCloudVisionV1p4beta1Position);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1Product', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1Product();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1Product.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1Product(
          od as api.GoogleCloudVisionV1p4beta1Product);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1ProductKeyValue', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1ProductKeyValue();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1ProductKeyValue.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1ProductKeyValue(
          od as api.GoogleCloudVisionV1p4beta1ProductKeyValue);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1ProductSearchResults',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1ProductSearchResults();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1ProductSearchResults.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1ProductSearchResults(
          od as api.GoogleCloudVisionV1p4beta1ProductSearchResults);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult
          .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult(od
          as api.GoogleCloudVisionV1p4beta1ProductSearchResultsGroupedResult);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o =
          buildGoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation
              .fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation(od
          as api
              .GoogleCloudVisionV1p4beta1ProductSearchResultsObjectAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p4beta1ProductSearchResultsResult', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1ProductSearchResultsResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVisionV1p4beta1ProductSearchResultsResult.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1ProductSearchResultsResult(
          od as api.GoogleCloudVisionV1p4beta1ProductSearchResultsResult);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1Property', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1Property();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1Property.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1Property(
          od as api.GoogleCloudVisionV1p4beta1Property);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1ReferenceImage', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1ReferenceImage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1ReferenceImage.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1ReferenceImage(
          od as api.GoogleCloudVisionV1p4beta1ReferenceImage);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1SafeSearchAnnotation',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1SafeSearchAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1SafeSearchAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1SafeSearchAnnotation(
          od as api.GoogleCloudVisionV1p4beta1SafeSearchAnnotation);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1Symbol', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1Symbol();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1Symbol.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1Symbol(
          od as api.GoogleCloudVisionV1p4beta1Symbol);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1TextAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1TextAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1TextAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1TextAnnotation(
          od as api.GoogleCloudVisionV1p4beta1TextAnnotation);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p4beta1TextAnnotationDetectedBreak', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1TextAnnotationDetectedBreak();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVisionV1p4beta1TextAnnotationDetectedBreak.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1TextAnnotationDetectedBreak(
          od as api.GoogleCloudVisionV1p4beta1TextAnnotationDetectedBreak);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage(
          od as api.GoogleCloudVisionV1p4beta1TextAnnotationDetectedLanguage);
    });
  });

  unittest.group(
      'obj-schema-GoogleCloudVisionV1p4beta1TextAnnotationTextProperty', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1TextAnnotationTextProperty();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.GoogleCloudVisionV1p4beta1TextAnnotationTextProperty.fromJson(
              oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1TextAnnotationTextProperty(
          od as api.GoogleCloudVisionV1p4beta1TextAnnotationTextProperty);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1Vertex', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1Vertex();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1Vertex.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1Vertex(
          od as api.GoogleCloudVisionV1p4beta1Vertex);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1WebDetection', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1WebDetection();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1WebDetection.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1WebDetection(
          od as api.GoogleCloudVisionV1p4beta1WebDetection);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1WebDetectionWebEntity',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1WebDetectionWebEntity();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1WebDetectionWebEntity.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1WebDetectionWebEntity(
          od as api.GoogleCloudVisionV1p4beta1WebDetectionWebEntity);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1WebDetectionWebImage',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1WebDetectionWebImage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1WebDetectionWebImage.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1WebDetectionWebImage(
          od as api.GoogleCloudVisionV1p4beta1WebDetectionWebImage);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1WebDetectionWebLabel',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1WebDetectionWebLabel();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1WebDetectionWebLabel.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1WebDetectionWebLabel(
          od as api.GoogleCloudVisionV1p4beta1WebDetectionWebLabel);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1WebDetectionWebPage',
      () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1WebDetectionWebPage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1WebDetectionWebPage.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1WebDetectionWebPage(
          od as api.GoogleCloudVisionV1p4beta1WebDetectionWebPage);
    });
  });

  unittest.group('obj-schema-GoogleCloudVisionV1p4beta1Word', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGoogleCloudVisionV1p4beta1Word();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GoogleCloudVisionV1p4beta1Word.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGoogleCloudVisionV1p4beta1Word(
          od as api.GoogleCloudVisionV1p4beta1Word);
    });
  });

  unittest.group('obj-schema-GroupedResult', () {
    unittest.test('to-json--from-json', () async {
      var o = buildGroupedResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.GroupedResult.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkGroupedResult(od as api.GroupedResult);
    });
  });

  unittest.group('obj-schema-Image', () {
    unittest.test('to-json--from-json', () async {
      var o = buildImage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.Image.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkImage(od as api.Image);
    });
  });

  unittest.group('obj-schema-ImageAnnotationContext', () {
    unittest.test('to-json--from-json', () async {
      var o = buildImageAnnotationContext();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ImageAnnotationContext.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkImageAnnotationContext(od as api.ImageAnnotationContext);
    });
  });

  unittest.group('obj-schema-ImageContext', () {
    unittest.test('to-json--from-json', () async {
      var o = buildImageContext();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ImageContext.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkImageContext(od as api.ImageContext);
    });
  });

  unittest.group('obj-schema-ImageProperties', () {
    unittest.test('to-json--from-json', () async {
      var o = buildImageProperties();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ImageProperties.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkImageProperties(od as api.ImageProperties);
    });
  });

  unittest.group('obj-schema-ImageSource', () {
    unittest.test('to-json--from-json', () async {
      var o = buildImageSource();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ImageSource.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkImageSource(od as api.ImageSource);
    });
  });

  unittest.group('obj-schema-ImportProductSetsGcsSource', () {
    unittest.test('to-json--from-json', () async {
      var o = buildImportProductSetsGcsSource();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ImportProductSetsGcsSource.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkImportProductSetsGcsSource(od as api.ImportProductSetsGcsSource);
    });
  });

  unittest.group('obj-schema-ImportProductSetsInputConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildImportProductSetsInputConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ImportProductSetsInputConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkImportProductSetsInputConfig(od as api.ImportProductSetsInputConfig);
    });
  });

  unittest.group('obj-schema-ImportProductSetsRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildImportProductSetsRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ImportProductSetsRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkImportProductSetsRequest(od as api.ImportProductSetsRequest);
    });
  });

  unittest.group('obj-schema-ImportProductSetsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildImportProductSetsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ImportProductSetsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkImportProductSetsResponse(od as api.ImportProductSetsResponse);
    });
  });

  unittest.group('obj-schema-InputConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildInputConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.InputConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkInputConfig(od as api.InputConfig);
    });
  });

  unittest.group('obj-schema-KeyValue', () {
    unittest.test('to-json--from-json', () async {
      var o = buildKeyValue();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.KeyValue.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkKeyValue(od as api.KeyValue);
    });
  });

  unittest.group('obj-schema-Landmark', () {
    unittest.test('to-json--from-json', () async {
      var o = buildLandmark();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Landmark.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkLandmark(od as api.Landmark);
    });
  });

  unittest.group('obj-schema-LatLng', () {
    unittest.test('to-json--from-json', () async {
      var o = buildLatLng();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.LatLng.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkLatLng(od as api.LatLng);
    });
  });

  unittest.group('obj-schema-LatLongRect', () {
    unittest.test('to-json--from-json', () async {
      var o = buildLatLongRect();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.LatLongRect.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkLatLongRect(od as api.LatLongRect);
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

  unittest.group('obj-schema-ListProductSetsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildListProductSetsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ListProductSetsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkListProductSetsResponse(od as api.ListProductSetsResponse);
    });
  });

  unittest.group('obj-schema-ListProductsInProductSetResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildListProductsInProductSetResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ListProductsInProductSetResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkListProductsInProductSetResponse(
          od as api.ListProductsInProductSetResponse);
    });
  });

  unittest.group('obj-schema-ListProductsResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildListProductsResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ListProductsResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkListProductsResponse(od as api.ListProductsResponse);
    });
  });

  unittest.group('obj-schema-ListReferenceImagesResponse', () {
    unittest.test('to-json--from-json', () async {
      var o = buildListReferenceImagesResponse();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ListReferenceImagesResponse.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkListReferenceImagesResponse(od as api.ListReferenceImagesResponse);
    });
  });

  unittest.group('obj-schema-LocalizedObjectAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildLocalizedObjectAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.LocalizedObjectAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkLocalizedObjectAnnotation(od as api.LocalizedObjectAnnotation);
    });
  });

  unittest.group('obj-schema-LocationInfo', () {
    unittest.test('to-json--from-json', () async {
      var o = buildLocationInfo();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.LocationInfo.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkLocationInfo(od as api.LocationInfo);
    });
  });

  unittest.group('obj-schema-NormalizedVertex', () {
    unittest.test('to-json--from-json', () async {
      var o = buildNormalizedVertex();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.NormalizedVertex.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkNormalizedVertex(od as api.NormalizedVertex);
    });
  });

  unittest.group('obj-schema-ObjectAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildObjectAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ObjectAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkObjectAnnotation(od as api.ObjectAnnotation);
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

  unittest.group('obj-schema-OperationMetadata', () {
    unittest.test('to-json--from-json', () async {
      var o = buildOperationMetadata();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.OperationMetadata.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkOperationMetadata(od as api.OperationMetadata);
    });
  });

  unittest.group('obj-schema-OutputConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildOutputConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.OutputConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkOutputConfig(od as api.OutputConfig);
    });
  });

  unittest.group('obj-schema-Page', () {
    unittest.test('to-json--from-json', () async {
      var o = buildPage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.Page.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkPage(od as api.Page);
    });
  });

  unittest.group('obj-schema-Paragraph', () {
    unittest.test('to-json--from-json', () async {
      var o = buildParagraph();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Paragraph.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkParagraph(od as api.Paragraph);
    });
  });

  unittest.group('obj-schema-Position', () {
    unittest.test('to-json--from-json', () async {
      var o = buildPosition();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Position.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkPosition(od as api.Position);
    });
  });

  unittest.group('obj-schema-Product', () {
    unittest.test('to-json--from-json', () async {
      var o = buildProduct();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Product.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkProduct(od as api.Product);
    });
  });

  unittest.group('obj-schema-ProductSearchParams', () {
    unittest.test('to-json--from-json', () async {
      var o = buildProductSearchParams();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ProductSearchParams.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkProductSearchParams(od as api.ProductSearchParams);
    });
  });

  unittest.group('obj-schema-ProductSearchResults', () {
    unittest.test('to-json--from-json', () async {
      var o = buildProductSearchResults();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ProductSearchResults.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkProductSearchResults(od as api.ProductSearchResults);
    });
  });

  unittest.group('obj-schema-ProductSet', () {
    unittest.test('to-json--from-json', () async {
      var o = buildProductSet();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.ProductSet.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkProductSet(od as api.ProductSet);
    });
  });

  unittest.group('obj-schema-ProductSetPurgeConfig', () {
    unittest.test('to-json--from-json', () async {
      var o = buildProductSetPurgeConfig();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ProductSetPurgeConfig.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkProductSetPurgeConfig(od as api.ProductSetPurgeConfig);
    });
  });

  unittest.group('obj-schema-Property', () {
    unittest.test('to-json--from-json', () async {
      var o = buildProperty();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Property.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkProperty(od as api.Property);
    });
  });

  unittest.group('obj-schema-PurgeProductsRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildPurgeProductsRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.PurgeProductsRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkPurgeProductsRequest(od as api.PurgeProductsRequest);
    });
  });

  unittest.group('obj-schema-ReferenceImage', () {
    unittest.test('to-json--from-json', () async {
      var o = buildReferenceImage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.ReferenceImage.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkReferenceImage(od as api.ReferenceImage);
    });
  });

  unittest.group('obj-schema-RemoveProductFromProductSetRequest', () {
    unittest.test('to-json--from-json', () async {
      var o = buildRemoveProductFromProductSetRequest();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.RemoveProductFromProductSetRequest.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkRemoveProductFromProductSetRequest(
          od as api.RemoveProductFromProductSetRequest);
    });
  });

  unittest.group('obj-schema-Result', () {
    unittest.test('to-json--from-json', () async {
      var o = buildResult();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Result.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkResult(od as api.Result);
    });
  });

  unittest.group('obj-schema-SafeSearchAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildSafeSearchAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.SafeSearchAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkSafeSearchAnnotation(od as api.SafeSearchAnnotation);
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

  unittest.group('obj-schema-Symbol', () {
    unittest.test('to-json--from-json', () async {
      var o = buildSymbol();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Symbol.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkSymbol(od as api.Symbol);
    });
  });

  unittest.group('obj-schema-TextAnnotation', () {
    unittest.test('to-json--from-json', () async {
      var o = buildTextAnnotation();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.TextAnnotation.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkTextAnnotation(od as api.TextAnnotation);
    });
  });

  unittest.group('obj-schema-TextDetectionParams', () {
    unittest.test('to-json--from-json', () async {
      var o = buildTextDetectionParams();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.TextDetectionParams.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkTextDetectionParams(od as api.TextDetectionParams);
    });
  });

  unittest.group('obj-schema-TextProperty', () {
    unittest.test('to-json--from-json', () async {
      var o = buildTextProperty();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.TextProperty.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkTextProperty(od as api.TextProperty);
    });
  });

  unittest.group('obj-schema-Vertex', () {
    unittest.test('to-json--from-json', () async {
      var o = buildVertex();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.Vertex.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkVertex(od as api.Vertex);
    });
  });

  unittest.group('obj-schema-WebDetection', () {
    unittest.test('to-json--from-json', () async {
      var o = buildWebDetection();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.WebDetection.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkWebDetection(od as api.WebDetection);
    });
  });

  unittest.group('obj-schema-WebDetectionParams', () {
    unittest.test('to-json--from-json', () async {
      var o = buildWebDetectionParams();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.WebDetectionParams.fromJson(
          oJson as core.Map<core.String, core.dynamic>);
      checkWebDetectionParams(od as api.WebDetectionParams);
    });
  });

  unittest.group('obj-schema-WebEntity', () {
    unittest.test('to-json--from-json', () async {
      var o = buildWebEntity();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.WebEntity.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkWebEntity(od as api.WebEntity);
    });
  });

  unittest.group('obj-schema-WebImage', () {
    unittest.test('to-json--from-json', () async {
      var o = buildWebImage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.WebImage.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkWebImage(od as api.WebImage);
    });
  });

  unittest.group('obj-schema-WebLabel', () {
    unittest.test('to-json--from-json', () async {
      var o = buildWebLabel();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.WebLabel.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkWebLabel(od as api.WebLabel);
    });
  });

  unittest.group('obj-schema-WebPage', () {
    unittest.test('to-json--from-json', () async {
      var o = buildWebPage();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od =
          api.WebPage.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkWebPage(od as api.WebPage);
    });
  });

  unittest.group('obj-schema-Word', () {
    unittest.test('to-json--from-json', () async {
      var o = buildWord();
      var oJson = convert.jsonDecode(convert.jsonEncode(o));
      var od = api.Word.fromJson(oJson as core.Map<core.String, core.dynamic>);
      checkWord(od as api.Word);
    });
  });

  unittest.group('resource-FilesResource', () {
    unittest.test('method--annotate', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).files;
      var arg_request = buildBatchAnnotateFilesRequest();
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.BatchAnnotateFilesRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkBatchAnnotateFilesRequest(obj as api.BatchAnnotateFilesRequest);

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
          path.substring(pathOffset, pathOffset + 17),
          unittest.equals("v1/files:annotate"),
        );
        pathOffset += 17;

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
        var resp = convert.json.encode(buildBatchAnnotateFilesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.annotate(arg_request, $fields: arg_$fields);
      checkBatchAnnotateFilesResponse(
          response as api.BatchAnnotateFilesResponse);
    });

    unittest.test('method--asyncBatchAnnotate', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).files;
      var arg_request = buildAsyncBatchAnnotateFilesRequest();
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.AsyncBatchAnnotateFilesRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkAsyncBatchAnnotateFilesRequest(
            obj as api.AsyncBatchAnnotateFilesRequest);

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
          path.substring(pathOffset, pathOffset + 27),
          unittest.equals("v1/files:asyncBatchAnnotate"),
        );
        pathOffset += 27;

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
          await res.asyncBatchAnnotate(arg_request, $fields: arg_$fields);
      checkOperation(response as api.Operation);
    });
  });

  unittest.group('resource-ImagesResource', () {
    unittest.test('method--annotate', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).images;
      var arg_request = buildBatchAnnotateImagesRequest();
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.BatchAnnotateImagesRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkBatchAnnotateImagesRequest(obj as api.BatchAnnotateImagesRequest);

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
          unittest.equals("v1/images:annotate"),
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
        var resp = convert.json.encode(buildBatchAnnotateImagesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.annotate(arg_request, $fields: arg_$fields);
      checkBatchAnnotateImagesResponse(
          response as api.BatchAnnotateImagesResponse);
    });

    unittest.test('method--asyncBatchAnnotate', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).images;
      var arg_request = buildAsyncBatchAnnotateImagesRequest();
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.AsyncBatchAnnotateImagesRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkAsyncBatchAnnotateImagesRequest(
            obj as api.AsyncBatchAnnotateImagesRequest);

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
          path.substring(pathOffset, pathOffset + 28),
          unittest.equals("v1/images:asyncBatchAnnotate"),
        );
        pathOffset += 28;

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
          await res.asyncBatchAnnotate(arg_request, $fields: arg_$fields);
      checkOperation(response as api.Operation);
    });
  });

  unittest.group('resource-LocationsOperationsResource', () {
    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).locations.operations;
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
  });

  unittest.group('resource-OperationsResource', () {
    unittest.test('method--cancel', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).operations;
      var arg_request = buildCancelOperationRequest();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.CancelOperationRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkCancelOperationRequest(obj as api.CancelOperationRequest);

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
      final response =
          await res.cancel(arg_request, arg_name, $fields: arg_$fields);
      checkEmpty(response as api.Empty);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).operations;
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
      var res = api.VisionApi(mock).operations;
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

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).operations;
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

  unittest.group('resource-ProjectsFilesResource', () {
    unittest.test('method--annotate', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.files;
      var arg_request = buildBatchAnnotateFilesRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.BatchAnnotateFilesRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkBatchAnnotateFilesRequest(obj as api.BatchAnnotateFilesRequest);

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
        var resp = convert.json.encode(buildBatchAnnotateFilesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.annotate(arg_request, arg_parent, $fields: arg_$fields);
      checkBatchAnnotateFilesResponse(
          response as api.BatchAnnotateFilesResponse);
    });

    unittest.test('method--asyncBatchAnnotate', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.files;
      var arg_request = buildAsyncBatchAnnotateFilesRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.AsyncBatchAnnotateFilesRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkAsyncBatchAnnotateFilesRequest(
            obj as api.AsyncBatchAnnotateFilesRequest);

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
      final response = await res.asyncBatchAnnotate(arg_request, arg_parent,
          $fields: arg_$fields);
      checkOperation(response as api.Operation);
    });
  });

  unittest.group('resource-ProjectsImagesResource', () {
    unittest.test('method--annotate', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.images;
      var arg_request = buildBatchAnnotateImagesRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.BatchAnnotateImagesRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkBatchAnnotateImagesRequest(obj as api.BatchAnnotateImagesRequest);

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
        var resp = convert.json.encode(buildBatchAnnotateImagesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.annotate(arg_request, arg_parent, $fields: arg_$fields);
      checkBatchAnnotateImagesResponse(
          response as api.BatchAnnotateImagesResponse);
    });

    unittest.test('method--asyncBatchAnnotate', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.images;
      var arg_request = buildAsyncBatchAnnotateImagesRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.AsyncBatchAnnotateImagesRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkAsyncBatchAnnotateImagesRequest(
            obj as api.AsyncBatchAnnotateImagesRequest);

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
      final response = await res.asyncBatchAnnotate(arg_request, arg_parent,
          $fields: arg_$fields);
      checkOperation(response as api.Operation);
    });
  });

  unittest.group('resource-ProjectsLocationsFilesResource', () {
    unittest.test('method--annotate', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.locations.files;
      var arg_request = buildBatchAnnotateFilesRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.BatchAnnotateFilesRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkBatchAnnotateFilesRequest(obj as api.BatchAnnotateFilesRequest);

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
        var resp = convert.json.encode(buildBatchAnnotateFilesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.annotate(arg_request, arg_parent, $fields: arg_$fields);
      checkBatchAnnotateFilesResponse(
          response as api.BatchAnnotateFilesResponse);
    });

    unittest.test('method--asyncBatchAnnotate', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.locations.files;
      var arg_request = buildAsyncBatchAnnotateFilesRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.AsyncBatchAnnotateFilesRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkAsyncBatchAnnotateFilesRequest(
            obj as api.AsyncBatchAnnotateFilesRequest);

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
      final response = await res.asyncBatchAnnotate(arg_request, arg_parent,
          $fields: arg_$fields);
      checkOperation(response as api.Operation);
    });
  });

  unittest.group('resource-ProjectsLocationsImagesResource', () {
    unittest.test('method--annotate', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.locations.images;
      var arg_request = buildBatchAnnotateImagesRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.BatchAnnotateImagesRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkBatchAnnotateImagesRequest(obj as api.BatchAnnotateImagesRequest);

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
        var resp = convert.json.encode(buildBatchAnnotateImagesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response =
          await res.annotate(arg_request, arg_parent, $fields: arg_$fields);
      checkBatchAnnotateImagesResponse(
          response as api.BatchAnnotateImagesResponse);
    });

    unittest.test('method--asyncBatchAnnotate', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.locations.images;
      var arg_request = buildAsyncBatchAnnotateImagesRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.AsyncBatchAnnotateImagesRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkAsyncBatchAnnotateImagesRequest(
            obj as api.AsyncBatchAnnotateImagesRequest);

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
      final response = await res.asyncBatchAnnotate(arg_request, arg_parent,
          $fields: arg_$fields);
      checkOperation(response as api.Operation);
    });
  });

  unittest.group('resource-ProjectsLocationsOperationsResource', () {
    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.locations.operations;
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
  });

  unittest.group('resource-ProjectsLocationsProductSetsResource', () {
    unittest.test('method--addProduct', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.locations.productSets;
      var arg_request = buildAddProductToProductSetRequest();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.AddProductToProductSetRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkAddProductToProductSetRequest(
            obj as api.AddProductToProductSetRequest);

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
      final response =
          await res.addProduct(arg_request, arg_name, $fields: arg_$fields);
      checkEmpty(response as api.Empty);
    });

    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.locations.productSets;
      var arg_request = buildProductSet();
      var arg_parent = 'foo';
      var arg_productSetId = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.ProductSet.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkProductSet(obj as api.ProductSet);

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
          queryMap["productSetId"]!.first,
          unittest.equals(arg_productSetId),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildProductSet());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.create(arg_request, arg_parent,
          productSetId: arg_productSetId, $fields: arg_$fields);
      checkProductSet(response as api.ProductSet);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.locations.productSets;
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
      var res = api.VisionApi(mock).projects.locations.productSets;
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
        var resp = convert.json.encode(buildProductSet());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkProductSet(response as api.ProductSet);
    });

    unittest.test('method--import', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.locations.productSets;
      var arg_request = buildImportProductSetsRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.ImportProductSetsRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkImportProductSetsRequest(obj as api.ImportProductSetsRequest);

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
          await res.import(arg_request, arg_parent, $fields: arg_$fields);
      checkOperation(response as api.Operation);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.locations.productSets;
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
        var resp = convert.json.encode(buildListProductSetsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkListProductSetsResponse(response as api.ListProductSetsResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.locations.productSets;
      var arg_request = buildProductSet();
      var arg_name = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.ProductSet.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkProductSet(obj as api.ProductSet);

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
        var resp = convert.json.encode(buildProductSet());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          updateMask: arg_updateMask, $fields: arg_$fields);
      checkProductSet(response as api.ProductSet);
    });

    unittest.test('method--removeProduct', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.locations.productSets;
      var arg_request = buildRemoveProductFromProductSetRequest();
      var arg_name = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.RemoveProductFromProductSetRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkRemoveProductFromProductSetRequest(
            obj as api.RemoveProductFromProductSetRequest);

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
      final response =
          await res.removeProduct(arg_request, arg_name, $fields: arg_$fields);
      checkEmpty(response as api.Empty);
    });
  });

  unittest.group('resource-ProjectsLocationsProductSetsProductsResource', () {
    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.locations.productSets.products;
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
        var resp = convert.json.encode(buildListProductsInProductSetResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_name,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkListProductsInProductSetResponse(
          response as api.ListProductsInProductSetResponse);
    });
  });

  unittest.group('resource-ProjectsLocationsProductsResource', () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.locations.products;
      var arg_request = buildProduct();
      var arg_parent = 'foo';
      var arg_productId = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj =
            api.Product.fromJson(json as core.Map<core.String, core.dynamic>);
        checkProduct(obj as api.Product);

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
          queryMap["productId"]!.first,
          unittest.equals(arg_productId),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildProduct());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.create(arg_request, arg_parent,
          productId: arg_productId, $fields: arg_$fields);
      checkProduct(response as api.Product);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.locations.products;
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
      var res = api.VisionApi(mock).projects.locations.products;
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
        var resp = convert.json.encode(buildProduct());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkProduct(response as api.Product);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.locations.products;
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
        var resp = convert.json.encode(buildListProductsResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkListProductsResponse(response as api.ListProductsResponse);
    });

    unittest.test('method--patch', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.locations.products;
      var arg_request = buildProduct();
      var arg_name = 'foo';
      var arg_updateMask = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj =
            api.Product.fromJson(json as core.Map<core.String, core.dynamic>);
        checkProduct(obj as api.Product);

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
        var resp = convert.json.encode(buildProduct());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.patch(arg_request, arg_name,
          updateMask: arg_updateMask, $fields: arg_$fields);
      checkProduct(response as api.Product);
    });

    unittest.test('method--purge', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.locations.products;
      var arg_request = buildPurgeProductsRequest();
      var arg_parent = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.PurgeProductsRequest.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkPurgeProductsRequest(obj as api.PurgeProductsRequest);

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
          await res.purge(arg_request, arg_parent, $fields: arg_$fields);
      checkOperation(response as api.Operation);
    });
  });

  unittest.group('resource-ProjectsLocationsProductsReferenceImagesResource',
      () {
    unittest.test('method--create', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.locations.products.referenceImages;
      var arg_request = buildReferenceImage();
      var arg_parent = 'foo';
      var arg_referenceImageId = 'foo';
      var arg_$fields = 'foo';
      mock.register(unittest.expectAsync2((http.BaseRequest req, json) {
        var obj = api.ReferenceImage.fromJson(
            json as core.Map<core.String, core.dynamic>);
        checkReferenceImage(obj as api.ReferenceImage);

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
          queryMap["referenceImageId"]!.first,
          unittest.equals(arg_referenceImageId),
        );
        unittest.expect(
          queryMap["fields"]!.first,
          unittest.equals(arg_$fields),
        );

        var h = {
          'content-type': 'application/json; charset=utf-8',
        };
        var resp = convert.json.encode(buildReferenceImage());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.create(arg_request, arg_parent,
          referenceImageId: arg_referenceImageId, $fields: arg_$fields);
      checkReferenceImage(response as api.ReferenceImage);
    });

    unittest.test('method--delete', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.locations.products.referenceImages;
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
      var res = api.VisionApi(mock).projects.locations.products.referenceImages;
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
        var resp = convert.json.encode(buildReferenceImage());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.get(arg_name, $fields: arg_$fields);
      checkReferenceImage(response as api.ReferenceImage);
    });

    unittest.test('method--list', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.locations.products.referenceImages;
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
        var resp = convert.json.encode(buildListReferenceImagesResponse());
        return async.Future.value(stringResponse(200, h, resp));
      }), true);
      final response = await res.list(arg_parent,
          pageSize: arg_pageSize,
          pageToken: arg_pageToken,
          $fields: arg_$fields);
      checkListReferenceImagesResponse(
          response as api.ListReferenceImagesResponse);
    });
  });

  unittest.group('resource-ProjectsOperationsResource', () {
    unittest.test('method--get', () async {
      var mock = HttpServerMock();
      var res = api.VisionApi(mock).projects.operations;
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
  });
}
