import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import 'custom_text.dart';

class BlockHeading extends StatelessWidget {
  final String title;
  final VoidCallback? viewAllOnPress;
  final EdgeInsets? margin;

  const BlockHeading({
    super.key,
    required this.title,
    this.viewAllOnPress,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.mainColor, width: 2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomText.h3(title),
          if (viewAllOnPress != null)
            GestureDetector(
              onTap: viewAllOnPress,
              child: CustomText.t16(
                'View all',
                color: AppColors.accentColor,
              ),
            ),
        ],
      ),
    );
  }
}
