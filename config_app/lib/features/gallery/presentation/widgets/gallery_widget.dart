import 'package:cached_network_image/cached_network_image.dart';
import 'package:config_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;

class GalleryWidget extends StatelessWidget {
  const GalleryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryBloc, GalleryState>(builder: (
      BuildContext context,
      GalleryState currentState,
    ) {
      if (currentState is UninitializedGalleryState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (currentState is ErrorGalleryState) {
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(currentState.errorMessage),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: ElevatedButton(
                onPressed: () => _load(context),
                child: const Text('reload'),
              ),
            ),
          ],
        ));
      }
      if (currentState is LoadedGalleryState) {
        return Column(
          children: [
            Row(
              children: [
                Text("Total ${currentState.items.length} items"),
                ElevatedButton(
                  child: const Text('Reload'),
                  onPressed: () {
                    _load(context);
                  },
                ),
              ],
            ),
            Expanded(
              child: MediaGalleryWidget(
                items: currentState.items,
              ),
            ),
          ],
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  void _load(BuildContext context) {
    context.read<GalleryBloc>().add(const GalleryLoadEvent());
  }
}

class MediaGalleryWidget extends StatefulWidget {
  final List<String> items;
  const MediaGalleryWidget({super.key, required this.items});

  @override
  State<MediaGalleryWidget> createState() => _MediaGalleryWidgetState();
}

class _MediaGalleryWidgetState extends State<MediaGalleryWidget> {
  late List<GalleryItem> items;
  final _selected = <GalleryItem>[];
  @override
  void initState() {
    final wclient = context.read<GalleryBloc>().getWebClient();
    items = widget.items
        .map((item) => GalleryItem(
              uri: wclient.getMediaItemUri(item),
              title: path.basename(item),
            ))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            height: MediaQuery.of(context).size.height -
                200, // Устанавливаем высоту, чтобы избежать проблем с shrinkWrap
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                ),
                itemCount: items.length,
                itemBuilder: _buildItem)));
  }

  Widget _buildItem(BuildContext ctx, index) {
    final item = items[index];
    final ext = path.extension(item.uri.path);

    return Tooltip(
      message: item.title,
      child: GestureDetector(
          onTap: () {
            setState(() {
              item.selected = !item.selected;
              if (item.selected) {
                _selected.add(item);
              } else {
                _selected.remove(item);
              }
            });
          }, // Image tapped
          child: Container(
            alignment: Alignment.center,
            decoration: item.selected
                ? BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.blue))
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1)),
            child: ext == '.mp4'
                ? Text('Video "${path.basename(item.uri.path)}"')
                : ext == ''
                    ? Row(
                        children: [
                          const Icon(Icons.folder),
                          Text(item.title),
                        ],
                      )
                    : CachedNetworkImage(
                        imageUrl: item.uri.toString(),
                        placeholder: (BuildContext context, String url) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorWidget: (BuildContext context, String url, error) {
                          return Column(
                            children: [
                              const Icon(Icons.error),
                              Text('Not found'),
                              Text(item.uri.path),
                            ],
                          );
                        },
                      ),
          )),
    );
  }
}

class GalleryItem {
  final Uri uri;
  final String title;
  bool selected;

  GalleryItem({
    required this.uri,
    required this.title,
    this.selected = false,
  });
}
