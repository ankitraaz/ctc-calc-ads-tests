import 'package:ctc_calc/theme/appcolor.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  // Fixed (default) styles
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.heading,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.heading,
  );

  static const TextStyle subsectionTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.heading,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.body,
    height: 1.5,
  );

  static const TextStyle warningText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.warningText,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  /// 🔧 Reusable Custom Style Method with Defaults
  static TextStyle custom({
    double? fontSize, // optional
    FontWeight? fontWeight, // optional
    Color? color, // optional
    double? height,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 14, // default size = 14
      fontWeight: fontWeight ?? FontWeight.normal, // default weight = normal
      color: color ?? AppColors.body, // default color
      height: height,
      decoration: decoration,
    );
  }
}
