import 'package:config_app/features/upload/domain/upload_folder_file.dart';
import 'package:config_app/features/upload/domain/upload_task.dart';

UploadPickedPathMode get platformPickedPathMode => UploadPickedPathMode.parentFolder;

Future<String?> Function()? get platformPickDirectory => null;
Stream<UploadFolderFile> Function(String)? get platformListDirectory => null;
