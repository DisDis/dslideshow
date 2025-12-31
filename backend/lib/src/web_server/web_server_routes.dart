abstract class WebServerRoutes {
  static const String info = '/info';
  static const String webSocket = "/ws";

  static const String getMedialItemsList = "/cache/<code>/list";
  static const String getMediaItem = "/cache/<code>/get/<itemPath>";
}