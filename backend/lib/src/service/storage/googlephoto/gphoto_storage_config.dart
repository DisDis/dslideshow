import 'package:dslideshow_backend/config.dart';

class GPhotoStorageConfig  extends BaseConfig {
  int _imageWidth;
  int get imageWidth => _imageWidth ??= readInt("imageWidth", 1980);
  int _imageHeight;
  int get imageHeight => _imageHeight ??= readInt("imageHeight", 1080);

  String _albumName;
  String get albumName => _albumName ??= readValue<String>("albumName", "SlideShow");

  GPhotoClientIdConfig _clientId;
  GPhotoClientIdConfig get clientId => _clientId??=new GPhotoClientIdConfig(readRaw("clientId") as Map<String, dynamic>);


  String _refreshToken;
  /// A refresh token, which can be used to refresh the access credentials.
  ///
  /// This field may be null.
  String get refreshToken => _refreshToken ??= readValue<String>("refreshToken");

  GPhotoStorageConfig(Map<String, dynamic> config) :super(config);
}

class GPhotoClientIdConfig  extends BaseConfig {

  String _identifier;
  /// The identifier used to identify this application to the server.
  String get identifier => _identifier ??= readValue<String>("identifier");

  String _secret;
  /// The client secret used to identify this application to the server.
  String get secret => _secret ??= readValue<String>("secret");

  GPhotoClientIdConfig(Map<String, dynamic> config) :super(config);
}