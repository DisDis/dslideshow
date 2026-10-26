import 'package:json_annotation/json_annotation.dart';

part 'catalog_state.g.dart';

@JsonSerializable(explicitToJson: true)
class GalleryCatalogState {
  final String serverId;
  final String epoch;
  final String revision;
  final Map<String, GallerySourceRecord> records;
  @JsonKey(defaultValue: <String>[])
  final List<String> completedOperations;

  const GalleryCatalogState({
    required this.serverId,
    required this.epoch,
    required this.revision,
    required this.records,
    this.completedOperations = const [],
  });

  factory GalleryCatalogState.fromJson(Map<String, dynamic> json) =>
      _$GalleryCatalogStateFromJson(json);
  Map<String, dynamic> toJson() => _$GalleryCatalogStateToJson(this);
}

@JsonSerializable()
class GallerySourceRecord {
  final String id;
  final String generation;
  final String fingerprint;
  final bool directory;

  const GallerySourceRecord({
    required this.id,
    required this.generation,
    required this.fingerprint,
    required this.directory,
  });

  factory GallerySourceRecord.fromJson(Map<String, dynamic> json) =>
      _$GallerySourceRecordFromJson(json);
  Map<String, dynamic> toJson() => _$GallerySourceRecordToJson(this);
}

@JsonSerializable()
class GalleryPublicationRecord {
  final String token;
  final bool dirty;
  final int ownerPid;
  @JsonKey(defaultValue: '')
  final String ownerStart;

  const GalleryPublicationRecord({
    required this.token,
    required this.dirty,
    required this.ownerPid,
    this.ownerStart = '',
  });

  factory GalleryPublicationRecord.fromJson(Map<String, dynamic> json) =>
      _$GalleryPublicationRecordFromJson(json);
  Map<String, dynamic> toJson() => _$GalleryPublicationRecordToJson(this);
}
