import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

part 'gallery_file_path_bloc.freezed.dart';

enum GalleryFilePathStyle { breadcrumbs, nearestFolder }

enum GalleryFilePathEvent { toggle }

@freezed
abstract class GalleryFilePathState with _$GalleryFilePathState {
  const factory GalleryFilePathState({
    required String name,
    String? displayPath,
    @Default([]) List<String> folders,
    @Default(false) bool expanded,
  }) = _GalleryFilePathState;
}

/// Accepts only the gallery's relative POSIX path, never an original's URL.
class GalleryFilePathBloc
    extends Bloc<GalleryFilePathEvent, GalleryFilePathState> {
  static final _log = Logger('GalleryFilePathBloc');

  GalleryFilePathBloc({required String? relativePath, required String name})
    : super(_initial(relativePath, name)) {
    on<GalleryFilePathEvent>((event, emit) {
      final expanded = !state.expanded;
      _log.fine(
        () =>
            'event=pathExpansionChanged expanded=$expanded depth=${state.folders.length}',
      );
      emit(state.copyWith(expanded: expanded));
    });
  }

  static GalleryFilePathState _initial(String? relative, String name) {
    if (relative == null || relative.isEmpty) {
      return GalleryFilePathState(name: name);
    }
    final segments = path.posix.split(relative);
    if (path.posix.isAbsolute(relative) ||
        path.windows.isAbsolute(relative) ||
        segments.any((segment) => segment == '..' || segment == '.')) {
      _log.warning('event=pathRejected reason=nonRelativePath');
      return GalleryFilePathState(name: name);
    }
    final normalized = path.posix.normalize(relative);
    final directory = path.posix.dirname(normalized);
    return GalleryFilePathState(
      name: path.posix.basename(normalized),
      displayPath: path.posix.join('/', normalized),
      folders: directory == '.' ? const [] : path.posix.split(directory),
    );
  }
}
