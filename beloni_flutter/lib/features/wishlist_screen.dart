import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/wishlist_provider.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_safe_area.dart';
import '../../core/theme/app_colors.dart';
import '../../models/product_model.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomSafeArea(
        child: Column(
          children: [
            const CustomHeader(
              title: 'Wishlist',
              showBackButton: false,
            ),
            Expanded(
              child: wishlist.isEmpty
                  ? Center(child: CustomText.t16('Your wishlist is empty'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: wishlist.length,
                      itemBuilder: (context, index) {
                        final product = wishlist[index];
                        return _WishlistItem(product: product);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WishlistItem extends ConsumerWidget {
  final ProductModel product;
  const _WishlistItem({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.pastel,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: product.image,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText.h5(product.name),
                CustomText.t14('\$${product.price}', color: AppColors.accentColor),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.favorite, color: AppColors.accentColor),
            onPressed: () => ref.read(wishlistProvider.notifier).toggleWishlist(product),
          ),
        ],
      ),
    );
  }
}
