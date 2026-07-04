import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPress;
  final Color? backgroundColor;

  const CustomHeader({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.onBackPress,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          if (showBackButton)
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: AppColors.mainColor, size: 20),
              onPressed: onBackPress ?? () => Navigator.of(context).pop(),
            ),
          Expanded(
            child: Text(
              title,
              style: AppTypography.h4.copyWith(fontWeight: FontWeight.w400),
              textAlign: showBackButton ? TextAlign.center : TextAlign.left,
            ),
          ),
          if (showBackButton) const SizedBox(width: 48), // Balancing back button
        ],
      ),
    );
  }
}
