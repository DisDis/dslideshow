abstract class WebServerRoutes {
  static const String info = '/info';
  static const String webSocket = "/ws";

  static const String uploadMedia = "/upload/<code>/";
  static const String getMedialItemsList = "/cache/<code>/list";
  static const String getMediaItem = r"/cache/<code>/get/<itemPath|.*>";
}
