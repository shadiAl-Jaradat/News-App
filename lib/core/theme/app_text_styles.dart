import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String fontFamily = 'Newsreader';

  static TextStyle get headline1 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 32.sp > 46 ? 46 : 32.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static TextStyle get headline2 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 28.sp > 42 ? 42 : 28.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static TextStyle get headline3 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 24.sp > 38 ? 38 : 24.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // Article titles
  static TextStyle get articleTitleLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 18.sp > 32 ? 32 : 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get articleTitleMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp > 28 ? 28 : 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get articleTitleSmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp > 24 ? 24 : 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // Body text
  static TextStyle get bodyLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp > 28 ? 28 : 16.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp > 24 ? 24 : 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle get bodySmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp > 20 ? 20 : 12.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  // Metadata (author, date, source)
  static TextStyle get metadataLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp > 24 ? 24 : 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  static TextStyle get metadataMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp > 20 ? 20 : 12.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  static TextStyle get metadataSmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: 10.sp > 22 ? 22 : 10.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.2,
  );

  static TextStyle get searchHint => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp > 36 ? 36 : 16.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static TextStyle get appBarTitle => TextStyle(
    fontFamily: fontFamily,
    fontSize: 20.sp > 34 ? 34 : 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.2,
  );
}
