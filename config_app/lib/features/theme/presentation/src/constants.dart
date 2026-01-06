part of '../theme.dart';

const headline1 = TextStyle(fontWeight: FontWeight.w400, fontSize: 16);
const headline2 = TextStyle(fontWeight: FontWeight.w400, fontSize: 14);
const headline3 = TextStyle(fontWeight: FontWeight.w400, fontSize: 12);
const labelSmall = TextStyle(fontWeight: FontWeight.w400, fontSize: 8);
const bodySmall = TextStyle(fontWeight: FontWeight.w400, fontSize: 8);

// ignore: prefer-match-file-name
abstract class AppColors {
  // Основные цвета
  static const white = Colors.white;
  static const black = Colors.black;
  static const grey = Colors.grey;
  static const pink = Colors.pink;

  // Оттенки серого
  static const darkerGrey = Color(0xFF6C6C6C);
  static const darkestGrey = Color(0xFF626262);
  static const lighterGrey = Color(0xFF959595);
  static const lightGrey = Color(0xFF5d5d5d);

  // Цвета для темной темы
  static const lighterDark = Color(0xFF272727);
  static const lightDark = Color(0xFF1b1b1b);

  // Цвета для сообщений
  static const lightMessagePrimaryColor = Colors.black;
  static const lightMessageBubbleColor = Color(0xffdcf8c6);
  static const lightMessageReceivedBubbleColor = Color(0xffdcf8c6);
  static const darkMessagePrimaryColor = Colors.black;
  static const darkMessageBubbleColor = Color(0xffdcf8c6);
  static const darkMessageReceivedBubbleColor = Color(0xffdcf8c6);

  // Цвета для UI элементов
  static const errorRed = Colors.red;
  static const firmwareUploadSuccess = Colors.green;
  static final progressOta = Colors.grey[300];
  static const progressOtaValue = Colors.blue;
  static const progressBlueBackground = Colors.grey;
  static const progressGreen = Colors.green;
  static const errorRedDark = Colors.red;
  static const errorRedAccent = Colors.redAccent;
  // static const amber = Colors.amber;
  // static const blue = Colors.blue;
  static const navWiFiMenuItem = Colors.blueAccent;
  // static const green = Colors.green;
  static const navGalleryMenuItem = Colors.green;
  static const navUploadMenuItem = Colors.red;
  static const navOtaMenuItem = Colors.purpleAccent;
  static const navConfigMenuItem = Colors.orangeAccent;
  static const navPowerMenuItem = Colors.lightBlue;
  // static const orange = Colors.orange;
  static const grey300 = Colors.grey;
  // static const grey400 = Colors.grey;
  // static const grey600 = Colors.grey;

  static final powerTabHint = Colors.grey[600];

  static final powerTabArrow = Colors.grey[400];
  
  // static const grey700 = Colors.grey;
  // static const grey800 = Colors.grey;
  // static const grey850 = Colors.grey;
  // static const white70 = Colors.white70;
  static const galleryVideoHint = Colors.white54;
  // static const black54 = Colors.black54;
  static const galleryVideoLoadinBackground = Colors.black87;
  static const homeHeader = Colors.transparent;
  static final gallerySelectionModeHeader = Colors.blueGrey.shade900;

  // Цвета для специфических элементов
  static const wifiSignalStrong = Colors.green;
  static const wifiSignalMedium = Colors.orange;
  static const wifiSignalWeak = Colors.red;
  static const wifiIconError = Colors.grey;
  static const wifiDeleteButton = Colors.red;
  static const wifi5GhzLabel = Colors.blue;
  static const wifiLockedIcon = Colors.grey;
  static const wifiBackground = Colors.blue;
  static const wifiChannel = Colors.grey;
  static final folderIcon = Colors.amber[700];
  static final imageErrorBackground = Colors.grey[300];
  static const imageErrorIcon = Colors.grey;
  static const videoBackground = Colors.black;
  static const videoErrorIcon = Colors.red;
  static const videoText = Colors.white70;
  static const videoPlayIcon = Colors.white;
  static const videoPlayButton = Colors.white;
  static const gallerySelectionBorder = Colors.blueAccent;
  static const galleryUnSelectionBorder = Colors.transparent;
  static final galleryItem = Colors.grey[200];
  static const selectionBackground = Colors.blue;
  static const slideshowBackground = Colors.black;
  static final slideshowInfoPanel = Colors.white.withAlpha((255.0 * 0.8).round());
  static const powerIconRestart = Colors.orange;
  static const powerIconPowerOff = Colors.red;
  static const settingsInfoIcon = Colors.grey;
  static const uploadQueuedIcon = Colors.grey;
  static const uploadCompletedIcon = Colors.green;
  static const uploadErrorIcon = Colors.red;
  static const uploadErrorText = Colors.red;
  static const uploadText = Colors.grey;
  static const homePageHeaderWelcome = Colors.grey;
  static const settingSectionIcon = Colors.grey;
  static const connectonProtected = Colors.grey;
  static const connectionNotProtected = Colors.green;
  static const noImageAvatar = Colors.amber;
  static const imageAvatar = Colors.blue;
}
