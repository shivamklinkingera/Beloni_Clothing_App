import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import 'logo_svg.dart';

class CustomHeader extends ConsumerWidget {
  final String? title;
  final bool showBackButton;
  final VoidCallback? onBackPress;
  final Color? backgroundColor;
  final bool logo;
  final bool basket;
  final bool search;

  const CustomHeader({
    super.key,
    this.title,
    this.showBackButton = false,
    this.onBackPress,
    this.backgroundColor,
    this.logo = false,
    this.basket = false,
    this.search = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final total = cart.fold<double>(0, (sum, item) => sum + (item.price * (item.cartQuantity ?? 1))).toStringAsFixed(2);

    return Container(
      height: 42,
      color: backgroundColor ?? AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (logo)
            const Align(
              alignment: Alignment.centerLeft,
              child: LogoSvg(),
            ),
          if (showBackButton)
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: AppColors.mainColor, size: 20),
                onPressed: onBackPress ?? () => context.pop(),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
          if (search)
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search, color: AppColors.textColor, size: 20),
                SizedBox(width: 7),
                Text('Search', style: TextStyle(color: AppColors.textColor, fontSize: 14)),
              ],
            ),
          if (title != null && !search)
            Text(
              title!,
              style: AppTypography.h4.copyWith(fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          if (basket)
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  // Navigation logic for basket
                },
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.shopping_basket_outlined, color: AppColors.mainColor, size: 24),
                    if (cart.isNotEmpty)
                      Positioned(
                        right: 15,
                        top: -5,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.accentColor,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Text(
                            '\$$total',
                            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
