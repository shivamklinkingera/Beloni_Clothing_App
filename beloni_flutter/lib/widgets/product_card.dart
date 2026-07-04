import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import '../providers/wishlist_provider.dart';
import '../providers/cart_provider.dart';
import '../core/theme/app_colors.dart';
import 'custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

class ProductCard extends ConsumerWidget {
  final ProductModel product;
  final int version;
  final bool lastItem;

  const ProductCard({
    super.key,
    required this.product,
    required this.version,
    this.lastItem = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistProvider);
    final isInWishlist = wishlist.any((item) => item.id == product.id);

    if (version == 1) {
      return GestureDetector(
        onTap: () => context.push('/product', extra: product),
        child: Container(
          width: 138,
          margin: EdgeInsets.only(right: lastItem ? 20 : 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageStack(context, ref, isInWishlist),
              const SizedBox(height: 14),
              CustomText.h6(product.name, maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 4),
              _buildPriceRow(),
            ],
          ),
        ),
      );
    }

    if (version == 2) {
      return GestureDetector(
        onTap: () => context.push('/product', extra: product),
        child: Container(
          width: (MediaQuery.of(context).size.width - 55) / 2,
          margin: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageStack(context, ref, isInWishlist),
              const SizedBox(height: 14),
              CustomText.h6(product.name, maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 4),
              _buildPriceRow(),
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildImageStack(BuildContext context, WidgetRef ref, bool isInWishlist) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        color: AppColors.pastel,
        image: DecorationImage(
          image: CachedNetworkImageProvider(product.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 7,
            top: 7,
            child: _buildRating(),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => ref.read(wishlistProvider.notifier).toggleWishlist(product),
                    child: Icon(
                      isInWishlist ? Icons.favorite : Icons.favorite_border,
                      color: isInWishlist ? AppColors.accentColor : AppColors.mainColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      ref.read(cartProvider.notifier).addToCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${product.name} added to cart')),
                      );
                    },
                    child: const Icon(Icons.shopping_basket_outlined, color: AppColors.mainColor, size: 20),
                  ),
                ],
              ),
            ),
          ),
          if (product.isSale)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 39,
                height: 16,
                color: const Color(0xFFA3D2A2),
                alignment: Alignment.center,
                child: const Text(
                  'SALE',
                  style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRating() {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.orange, size: 12),
        const SizedBox(width: 4),
        CustomText.t14(product.rating.toStringAsFixed(1), fontSize: 12),
      ],
    );
  }

  Widget _buildPriceRow() {
    return Row(
      children: [
        if (product.oldPrice != null)
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Text(
              '\$${product.oldPrice!.toStringAsFixed(2)}',
              style: const TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Color(0xFF999999),
                fontSize: 12,
              ),
            ),
          ),
        CustomText.t14(
          '\$${product.price.toStringAsFixed(2)}',
          color: product.oldPrice != null ? AppColors.accentColor : AppColors.textColor,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
