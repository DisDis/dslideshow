import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_folder_file.freezed.dart';

@freezed
sealed class UploadFolderFile with _$UploadFolderFile {
  const factory UploadFolderFile.local(File file, String relativePath) = LocalUploadFolderFile;
  const factory UploadFolderFile.document(PlatformFile file, String relativePath) = DocumentUploadFolderFile;
}
