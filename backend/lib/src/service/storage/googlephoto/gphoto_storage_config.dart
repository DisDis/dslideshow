import 'package:dslideshow_backend/config.dart';

class GPhotoStorageConfig  extends BaseConfig {
  int _imageWidth;
  int get imageWidth => _imageWidth ??= readInt("imageWidth", 2560);
  int _imageHeight;
  int get imageHeight => _imageHeight ??= readInt("imageHeight", 1600);

  Duration _syncPeriod;
  Duration get syncPeriod => _syncPeriod ??= new Duration(seconds: readInt("syncPeriodSec", 60*60));//1 hour

  List<String> _albumNames;
  List<String> get albumNames => _albumNames ??= readValue<List<String>>("albumNames", <String>["SlideShow"]);

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