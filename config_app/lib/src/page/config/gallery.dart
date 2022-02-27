import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class MediaGalleryWidget extends StatefulWidget {
  const MediaGalleryWidget({Key? key}) : super(key: key);

  @override
  State<MediaGalleryWidget> createState() => _MediaGalleryWidgetState();
}

class _MediaGalleryWidgetState extends State<MediaGalleryWidget> {
  final items = <GalleryItem>[
    GalleryItem(Uri.parse('http://127.0.0.1:8080/cache/123/get/1.jpg'), '1'),
    GalleryItem(Uri.parse('http://127.0.0.1:8080/cache/123/get/2.jpg'), '2'),
    GalleryItem(Uri.parse('http://127.0.0.1:8080/cache/123/get/3.jpg'), '3'),
    GalleryItem(Uri.parse('http://127.0.0.1:8080/cache/123/get/4.gif'), '4'),
    GalleryItem(Uri.parse('http://127.0.0.1:8080/cache/123/get/5.mp4'), '5'),
    GalleryItem(Uri.parse('http://127.0.0.1:8080/cache/123/get/1.jpg'), '1'),
    GalleryItem(Uri.parse('http://127.0.0.1:8080/cache/123/get/1.jpg'), '1'),
    GalleryItem(Uri.parse('http://127.0.0.1:8080/cache/123/get/1.jpg'), '1'),
    GalleryItem(Uri.parse('http://127.0.0.1:8080/cache/123/get/1.jpg'), '1'),
    GalleryItem(Uri.parse('http://127.0.0.1:8080/cache/123/get/1.jpg'), '1'),
  ];
  final _selected = <GalleryItem>[];
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              crossAxisCount: 3,
              mainAxisSpacing: 10,
            ),
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: _buildItem));
  }

  Widget _buildItem(BuildContext ctx, index) {
    final item = items[index];
    final ext = path.extension(item.uri.path);

    return GestureDetector(
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
          child: ext == '.mp4'
              ? Text('Video "${path.basename(item.uri.path)}"')
              : Image.network(
                  item.uri.toString(),
                  errorBuilder: (
                    BuildContext context,
                    Object error,
                    StackTrace? stackTrace,
                  ) {
                    return Text('Not found "${item.uri.path}');
                  },
                ),
          decoration: item.selected
              ? BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.blue))
              : BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 1)),
        ));
  }
}

class GalleryItem {
  final Uri uri;
  final String title;
  bool selected;

  GalleryItem(this.uri, this.title, {this.selected = false});
}
