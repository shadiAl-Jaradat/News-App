import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,

      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.secondary,
        secondary: AppColors.textSecondary,
        onSecondary: AppColors.textPrimary,
        surface: AppColors.background,
        onSurface: AppColors.textPrimary,
      ),

      scaffoldBackgroundColor: AppColors.background,

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.appBarTitle,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.searchBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        hintStyle: AppTextStyles.searchHint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),

      // FloatingActionButton theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.secondary,
        elevation: 4,
        shape: const CircleBorder(),
      ),

      dividerTheme: DividerThemeData(color: AppColors.divider, thickness: 1, space: 1),

      textTheme: TextTheme(
        headlineLarge: AppTextStyles.headline1,
        headlineMedium: AppTextStyles.headline2,
        headlineSmall: AppTextStyles.headline3,

        titleLarge: AppTextStyles.articleTitleLarge,
        titleMedium: AppTextStyles.articleTitleMedium,
        titleSmall: AppTextStyles.articleTitleSmall,

        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,

        labelLarge: AppTextStyles.metadataLarge,
        labelMedium: AppTextStyles.metadataMedium,
        labelSmall: AppTextStyles.metadataSmall,
      ),

      fontFamily: AppTextStyles.fontFamily,
    );
  }
}
