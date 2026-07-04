import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/banner_model.dart';
import '../widgets/primary_button.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BannerItem extends StatelessWidget {
  final int version;
  final BannerModel banner;

  const BannerItem({
    super.key,
    required this.version,
    required this.banner,
  });

  @override
  Widget build(BuildContext context) {
    if (version == 1) {
      return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.width / 1.14,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(banner.image),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(banner.title1 ?? '', style: AppTypography.h1),
            Text(banner.title2 ?? '', style: AppTypography.h1),
            const SizedBox(height: 10),
            Text(
              banner.description1 ?? '',
              style: const TextStyle(color: AppColors.textColor, fontSize: 16),
            ),
            Text(
              banner.description2 ?? '',
              style: const TextStyle(color: AppColors.textColor, fontSize: 16),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 140,
              child: PrimaryButton(
                title: banner.btnText,
                onPress: () => context.push('/shop'),
              ),
            ),
          ],
        ),
      );
    }

    if (version == 2) {
      return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.width / 1.57,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(banner.image),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRichTitle(banner.title ?? ''),
            const SizedBox(height: 8),
            Text(
              banner.description1 ?? '',
              style: const TextStyle(color: AppColors.textColor, fontSize: 16),
            ),
            Text(
              banner.description2 ?? '',
              style: const TextStyle(color: AppColors.textColor, fontSize: 16),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 140,
              child: PrimaryButton(
                title: banner.btnText,
                onPress: () => context.push('/shop'),
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildRichTitle(String text) {
    // Basic implementation of parsing 50% for accent color as seen in RN
    final parts = text.split('50%');
    if (parts.length == 2) {
      return RichText(
        text: TextSpan(
          style: AppTypography.h2.copyWith(color: AppColors.mainColor),
          children: [
            TextSpan(text: parts[0]),
            const TextSpan(text: '50%', style: TextStyle(color: AppColors.accentColor)),
            TextSpan(text: parts[1]),
          ],
        ),
      );
    }
    return Text(text, style: AppTypography.h2);
  }
}
