part of '../theme.dart';

// ignore_for_file: avoid-non-null-assertion, no-equal-arguments
class ThemeColors extends ThemeExtension<ThemeColors> {
  final Color appContainerBackground;
  final Color appContainerShadow;
  final Color selectedLabel;
  final Color unselectedLabel;
  final Color coursorColor;
  final Color micIcon;
  final Color settingsDialogLanguage;
  final Color messagePrimaryColor;
  final Color messageBubbleColor;
  final Color messageReceivedBubbleColor;
  final Color avatarBackgroundColor;
  final Color messageReceiptBackgroundColor;
  final Color messageReceiptIconReadColor;
  final Color messageReceiptIconUnReadColor;
  final Color messageDateTimeColor;

  const ThemeColors({
    required this.appContainerBackground,
    required this.appContainerShadow,
    required this.selectedLabel,
    required this.unselectedLabel,
    required this.coursorColor,
    required this.micIcon,
    required this.settingsDialogLanguage,
    required this.messagePrimaryColor,
    required this.messageBubbleColor,
    required this.avatarBackgroundColor,
    required this.messageReceiptBackgroundColor,
    required this.messageReceiptIconReadColor,
    required this.messageReceiptIconUnReadColor,
    required this.messageDateTimeColor,
    required this.messageReceivedBubbleColor,
  });

  @override
  // ignore: long-parameter-list
  ThemeExtension<ThemeColors> copyWith({
    Color? appContainerBackground,
    Color? appContainerShadow,
    Color? selectedLabel,
    Color? unselectedLabel,
    Color? coursorColor,
    Color? micIcon,
    Color? settingsDialogLanguage,
    Color? messagePrimaryColor,
    Color? messageBubbleColor,
    Color? avatarBackgroundColor,
    Color? messageReceiptBackgroundColor,
    Color? messageReceiptIconReadColor,
    Color? messageReceiptIconUnReadColor,
    Color? messageDateTimeColor,
    Color? messageReceivedBubbleColor,
  }) {
    return ThemeColors(
      appContainerBackground:
          appContainerBackground ?? this.appContainerBackground,
      appContainerShadow: appContainerShadow ?? this.appContainerShadow,
      selectedLabel: selectedLabel ?? this.selectedLabel,
      unselectedLabel: unselectedLabel ?? this.unselectedLabel,
      coursorColor: coursorColor ?? this.coursorColor,
      micIcon: micIcon ?? this.micIcon,
      settingsDialogLanguage:
          settingsDialogLanguage ?? this.settingsDialogLanguage,
      messagePrimaryColor: messagePrimaryColor ?? this.messagePrimaryColor,
      messageBubbleColor: messageBubbleColor ?? this.messageBubbleColor,
      avatarBackgroundColor:
          avatarBackgroundColor ?? this.avatarBackgroundColor,
      messageReceiptBackgroundColor:
          messageReceiptBackgroundColor ?? this.messageReceiptBackgroundColor,
      messageReceiptIconReadColor:
          messageReceiptIconReadColor ?? this.messageReceiptIconReadColor,
      messageReceiptIconUnReadColor:
          messageReceiptIconUnReadColor ?? this.messageReceiptIconUnReadColor,
      messageDateTimeColor: messageDateTimeColor ?? this.messageDateTimeColor,
      messageReceivedBubbleColor:
          messageReceivedBubbleColor ?? this.messageReceivedBubbleColor,
    );
  }

  @override
  // ignore: long-method
  ThemeExtension<ThemeColors> lerp(
    ThemeExtension<ThemeColors>? other,
    double t,
  ) {
    if (other is! ThemeColors) {
      return this;
    }

    return ThemeColors(
      appContainerBackground:
          Color.lerp(appContainerBackground, other.appContainerBackground, t)!,
      appContainerShadow:
          Color.lerp(appContainerShadow, other.appContainerShadow, t)!,
      selectedLabel: Color.lerp(selectedLabel, other.selectedLabel, t)!,
      unselectedLabel: Color.lerp(unselectedLabel, other.unselectedLabel, t)!,
      coursorColor: Color.lerp(coursorColor, other.coursorColor, t)!,
      micIcon: Color.lerp(micIcon, other.micIcon, t)!,
      settingsDialogLanguage:
          Color.lerp(settingsDialogLanguage, other.settingsDialogLanguage, t)!,
      messagePrimaryColor:
          Color.lerp(messagePrimaryColor, other.messagePrimaryColor, t)!,
      messageBubbleColor:
          Color.lerp(messageBubbleColor, other.messageBubbleColor, t)!,
      avatarBackgroundColor:
          Color.lerp(avatarBackgroundColor, other.avatarBackgroundColor, t)!,
      messageReceiptBackgroundColor: Color.lerp(
        messageReceiptBackgroundColor,
        other.messageReceiptBackgroundColor,
        t,
      )!,
      messageReceiptIconReadColor: Color.lerp(
        messageReceiptIconReadColor,
        other.messageReceiptIconReadColor,
        t,
      )!,
      messageReceiptIconUnReadColor: Color.lerp(
        messageReceiptIconUnReadColor,
        other.messageReceiptIconUnReadColor,
        t,
      )!,
      messageDateTimeColor: Color.lerp(
        messageDateTimeColor,
        other.messageDateTimeColor,
        t,
      )!,
      messageReceivedBubbleColor: Color.lerp(
        messageReceivedBubbleColor,
        other.messageReceivedBubbleColor,
        t,
      )!,
    );
  }

  static ThemeColors get light => ThemeColors(
        appContainerBackground: AppColors.white,
        appContainerShadow: AppColors.grey.withAlpha((255.0 * 0.5).round()),
        selectedLabel: AppColors.darkestGrey,
        unselectedLabel: AppColors.darkestGrey.withAlpha((255.0 * 0.7).round()),
        coursorColor: AppColors.pink,
        micIcon: AppColors.lightGrey,
        settingsDialogLanguage: AppColors.white,
        messagePrimaryColor: AppColors.lightMessagePrimaryColor,
        messageBubbleColor: AppColors.lightMessageBubbleColor,
        avatarBackgroundColor: Colors.white,
        messageReceiptBackgroundColor: Colors.white,
        messageReceiptIconReadColor: Colors.green[700]!,
        messageReceiptIconUnReadColor: Colors.grey,
        messageDateTimeColor: Colors.black54,
        messageReceivedBubbleColor: AppColors.lightMessageReceivedBubbleColor,
      );

  static ThemeColors get dark => ThemeColors(
        appContainerBackground: AppColors.lightDark,
        appContainerShadow:
            AppColors.darkerGrey.withAlpha((255.0 * 0.2).round()),
        selectedLabel: AppColors.darkestGrey,
        unselectedLabel: AppColors.darkestGrey.withAlpha((255.0 * 0.7).round()),
        coursorColor: AppColors.pink,
        micIcon: AppColors.lightGrey,
        settingsDialogLanguage: AppColors.lighterDark,
        messagePrimaryColor: AppColors.darkMessagePrimaryColor,
        messageBubbleColor: AppColors.darkMessageBubbleColor,
        avatarBackgroundColor: Colors.black,
        messageReceiptBackgroundColor: Colors.black,
        messageReceiptIconReadColor: Colors.green[700]!,
        messageReceiptIconUnReadColor: Colors.grey,
        messageDateTimeColor: Colors.white70,
        messageReceivedBubbleColor: AppColors.darkMessageReceivedBubbleColor,
      );
}
