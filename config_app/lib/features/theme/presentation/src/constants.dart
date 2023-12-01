part of '../theme.dart';

const headline1 = TextStyle(fontWeight: FontWeight.w400, fontSize: 16);
const headline2 = TextStyle(fontWeight: FontWeight.w400, fontSize: 14);
const headline3 = TextStyle(fontWeight: FontWeight.w400, fontSize: 12);
const labelSmall = TextStyle(fontWeight: FontWeight.w400, fontSize: 8);
const bodySmall = TextStyle(fontWeight: FontWeight.w400, fontSize: 8);

// ignore: prefer-match-file-name
abstract class AppColors {
  static const white = Colors.white;
  static const black = Colors.black;
  static const grey = Colors.grey;
  static const pink = Colors.pink;

  static const darkerGrey = Color(0xFF6C6C6C);
  static const darkestGrey = Color(0xFF626262);
  static const lighterGrey = Color(0xFF959595);
  static const lightGrey = Color(0xFF5d5d5d);

  static const lighterDark = Color(0xFF272727);
  static const lightDark = Color(0xFF1b1b1b);

  static const lightMessagePrimaryColor = Colors.black;
  static const lightMessageBubbleColor = Color(0xffdcf8c6);
  static const lightMessageReceivedBubbleColor = Color(0xffdcf8c6);

  static const darkMessagePrimaryColor = Colors.black;
  static const darkMessageBubbleColor = Color(0xffdcf8c6);
  static const darkMessageReceivedBubbleColor = Color(0xffdcf8c6);
}
