import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final EdgeInsetsGeometry? margin;
  final double height;
  final Color? backgroundColor;
  final TextStyle? titleStyle;

  const PrimaryButton({
    super.key,
    required this.title,
    required this.onPress,
    this.margin,
    this.height = 60,
    this.backgroundColor,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.mainColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          elevation: 0,
        ),
        child: Text(
          title.toUpperCase(),
          style: AppTypography.latoRegular.copyWith(
            color: AppColors.white,
            fontSize: 14,
          ).merge(titleStyle),
        ),
      ),
    );
  }
}
