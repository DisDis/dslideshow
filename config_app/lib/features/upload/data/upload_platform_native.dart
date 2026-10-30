import 'dart:io';

import 'package:config_app/features/upload/domain/upload_folder_file.dart';
import 'package:config_app/features/upload/domain/upload_task.dart';

import 'android_documents.dart';

const _documents = AndroidDocuments();
UploadPickedPathMode get platformPickedPathMode =>
    Platform.isAndroid ? UploadPickedPathMode.fileName : UploadPickedPathMode.parentFolder;
Future<String?> Function()? get platformPickDirectory => Platform.isAndroid ? _documents.pickDirectory : null;
Stream<UploadFolderFile> Function(String)? get platformListDirectory =>
    Platform.isAndroid ? _documents.listDirectory : null;
