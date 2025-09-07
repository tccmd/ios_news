import 'package:flutter/material.dart';
import 'styles.dart';

extension AppThemeColors on BuildContext {
  Color get gray0 => AppColors.gray0;
  Color get gray1 => AppColors.gray1;
  Color get gray2 => AppColors.gray2;
  Color get gray3 => AppColors.gray3;
  Color get gray4 => AppColors.gray4;
  Color get black => AppColors.black;
  Color get accent => AppColors.accent;
  Color get black10 => AppColors.black10;

  Color get bg1 => AppColors.bg1;
  Color get bg2 => AppColors.bg2;
  Color get bg3 => AppColors.bg3;
  Color get line1 => AppColors.line1;
  Color get line2 => AppColors.line2;
  Color get text1 => AppColors.text1;
  Color get text2 => AppColors.text2;
}

extension AppSpacings on BuildContext {
  double get spacing24 => AppSpacing.spacing24;
  double get spacing20 => AppSpacing.spacing20;
  double get spacing10 => AppSpacing.spacing10;
  double get spacing30 => AppSpacing.spacing30;
  double get spacing40 => AppSpacing.spacing40;
  double get spacing50 => AppSpacing.spacing50;
}

extension AppTextStyles on BuildContext {
  TextStyle get koHeadline1 => AppTextStyle.koHeadline1;
  TextStyle get enHeadline1 => AppTextStyle.enHeadline1;
  TextStyle get koHeadline2 => AppTextStyle.koHeadline2;
  TextStyle get enHeadline2 => AppTextStyle.enHeadline2;
  TextStyle get koHeadline3 => AppTextStyle.koHeadline3;
  TextStyle get enHeadline3 => AppTextStyle.enHeadline3;
  TextStyle get koHeadline4 => AppTextStyle.koHeadline4;
  TextStyle get enHeadline4 => AppTextStyle.enHeadline4;
  TextStyle get koHeadline5 => AppTextStyle.koHeadline5;
  TextStyle get enHeadline5 => AppTextStyle.enHeadline5;
  TextStyle get koBody1 => AppTextStyle.koBody1;
  TextStyle get enBody1 => AppTextStyle.enBody1;
  TextStyle get koBody2 => AppTextStyle.koBody2;
  TextStyle get enBody2 => AppTextStyle.enBody2;
  TextStyle get koTab => AppTextStyle.koTab;
  TextStyle get enTab => AppTextStyle.enTab;
  TextStyle get koCaption1 => AppTextStyle.koCaption1;
  TextStyle get enCaption1 => AppTextStyle.enCaption1;
  TextStyle get koOverLine => AppTextStyle.koOverLine;
  TextStyle get enOverLine => AppTextStyle.enOverLine;
  TextStyle get koButton => AppTextStyle.koButton;
  TextStyle get enButton => AppTextStyle.enButton;
  TextStyle get koCaption2 => AppTextStyle.koCaption2;
  TextStyle get enCaption2 => AppTextStyle.enCaption2;
  TextStyle get koNav => AppTextStyle.koNav;
  TextStyle get enNav => AppTextStyle.enNav;
}