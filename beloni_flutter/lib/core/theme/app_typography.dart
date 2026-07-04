import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  static const String tenorSans = 'TenorSans';
  static const String lato = 'Lato';

  static TextStyle h1 = const TextStyle(
    fontFamily: tenorSans,
    fontSize: 32,
    height: 1.2,
    color: AppColors.mainColor,
  );

  static TextStyle h2 = const TextStyle(
    fontFamily: tenorSans,
    fontSize: 22,
    height: 1.2,
    color: AppColors.mainColor,
  );

  static TextStyle h3 = const TextStyle(
    fontFamily: tenorSans,
    fontSize: 20,
    height: 1.2,
    color: AppColors.mainColor,
  );

  static TextStyle h4 = const TextStyle(
    fontFamily: tenorSans,
    fontSize: 18,
    height: 1.2,
    color: AppColors.mainColor,
  );

  static TextStyle h5 = const TextStyle(
    fontFamily: tenorSans,
    fontSize: 16,
    height: 1.2,
    color: AppColors.mainColor,
  );

  static TextStyle h6 = const TextStyle(
    fontFamily: tenorSans,
    fontSize: 14,
    height: 1.6,
    color: AppColors.mainColor,
  );

  static TextStyle t14 = const TextStyle(
    fontFamily: lato,
    fontSize: 14,
    height: 1.5,
    color: AppColors.textColor,
  );

  static TextStyle t16 = const TextStyle(
    fontFamily: lato,
    fontSize: 16,
    height: 1.7,
    color: AppColors.textColor,
  );

  static TextStyle latoRegular = const TextStyle(
    fontFamily: lato,
    fontWeight: FontWeight.w400,
  );

  static TextStyle latoBold = const TextStyle(
    fontFamily: lato,
    fontWeight: FontWeight.w700,
  );
}
