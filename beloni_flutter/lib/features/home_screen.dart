import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/product_provider.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_safe_area.dart';
import '../../core/theme/app_colors.dart';
import '../../models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);

    return Scaffold(
      backgroundColor: AppColors.pastel,
      body: CustomSafeArea(
        edges: const ['top'],
        child: Column(
          children: [
            const CustomHeader(
              title: 'Beloni',
              showBackButton: false,
            ),
            Expanded(
              child: productsAsync.when(
                data: (products) => RefreshIndicator(
                  onRefresh: () => ref.refresh(productsProvider.future),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildFeatured(context, products),
                        _buildBestSellers(context, products),
                      ],
                    ),
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Error: $err')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatured(BuildContext context, List<ProductModel> products) {
    final featured = products.where((p) => p.isFeatured).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText.h3('Featured Products'),
              GestureDetector(
                onTap: () => context.push('/shop', extra: {
                  'products': featured,
                  'title': 'Featured',
                }),
                child: CustomText.t14('View all', color: AppColors.accentColor),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            itemCount: featured.length,
            itemBuilder: (context, index) {
              final product = featured[index];
              return _ProductCard(product: product);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBestSellers(BuildContext context, List<ProductModel> products) {
    final bestSellers = products.where((p) => p.isBestseller).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText.h3('Best Sellers'),
              GestureDetector(
                onTap: () => context.push('/shop', extra: {
                  'products': bestSellers,
                  'title': 'Best Sellers',
                }),
                child: CustomText.t14('View all', color: AppColors.accentColor),
              ),
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemCount: bestSellers.length > 4 ? 4 : bestSellers.length,
          itemBuilder: (context, index) {
            return _ProductCard(product: bestSellers[index]);
          },
        ),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ProductModel product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/product', extra: product),
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: product.image,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(color: AppColors.pastel),
              ),
            ),
            const SizedBox(height: 8),
            CustomText.t14(product.name, maxLines: 1, overflow: TextOverflow.ellipsis),
            CustomText.t14('\$${product.price}', color: AppColors.accentColor),
          ],
        ),
      ),
    );
  }
}
