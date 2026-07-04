import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/product_provider.dart';
import '../../providers/banner_provider.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_safe_area.dart';
import '../../widgets/block_heading.dart';
import '../../widgets/product_card.dart';
import '../../widgets/banner_item.dart';
import '../../core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);
    final bannersAsync = ref.watch(bannersProvider);

    return Scaffold(
      backgroundColor: AppColors.pastel,
      body: CustomSafeArea(
        edges: const ['top'],
        child: Column(
          children: [
            const CustomHeader(
              logo: true,
              basket: true,
              backgroundColor: AppColors.pastel,
            ),
            Expanded(
              child: productsAsync.when(
                data: (products) => bannersAsync.when(
                  data: (banners) => SingleChildScrollView(
                    child: Container(
                      color: AppColors.white,
                      child: Column(
                        children: [
                          if (banners.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 40),
                              child: BannerItem(version: 1, banner: banners[0]),
                            ),
                          _buildFeatured(context, products),
                          if (banners.length > 1)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 40),
                              child: BannerItem(version: 2, banner: banners[1]),
                            ),
                          _buildBestSellers(context, products),
                        ],
                      ),
                    ),
                  ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text('Error: $err')),
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

  Widget _buildFeatured(BuildContext context, List<dynamic> products) {
    final featured = products.where((p) => p.isFeatured).toList();
    final slice = featured.take(5).toList();

    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      child: Column(
        children: [
          BlockHeading(
            title: 'Featured Products',
            margin: const EdgeInsets.symmetric(horizontal: 20),
            viewAllOnPress: () => context.push('/shop', extra: {
              'products': featured,
              'title': 'Featured',
            }),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20),
              itemCount: slice.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: slice[index],
                  version: 1,
                  lastItem: index == slice.length - 1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBestSellers(BuildContext context, List<dynamic> products) {
    final bestSellers = products.where((p) => p.isBestseller).toList();
    final slice = bestSellers.take(5).toList();

    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      child: Column(
        children: [
          BlockHeading(
            title: 'Best Sellers',
            margin: const EdgeInsets.symmetric(horizontal: 20),
            viewAllOnPress: () => context.push('/shop', extra: {
              'products': bestSellers,
              'title': 'Best Sellers',
            }),
          ),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              spacing: 15,
              children: slice.map((product) => ProductCard(
                product: product,
                version: 2,
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
