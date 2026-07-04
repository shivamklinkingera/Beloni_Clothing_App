import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../providers/product_provider.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_safe_area.dart';
import '../../core/theme/app_colors.dart';
import '../../models/product_model.dart';

class ShopScreen extends ConsumerWidget {
  final List<ProductModel>? products;
  final String title;

  const ShopScreen({super.key, this.products, this.title = 'Shop'});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomSafeArea(
        child: Column(
          children: [
            CustomHeader(
              title: title,
              onBackPress: () => GoRouter.of(context).pop(),
            ),
            _buildOptions(),
            Expanded(
              child: products != null
                  ? _buildProductGrid(context, products!)
                  : productsAsync.when(
                      data: (data) => _buildProductGrid(context, data),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (err, stack) => Center(child: Text('Error: $err')),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.tune, size: 20, color: AppColors.mainColor),
              const SizedBox(width: 8),
              CustomText.t14('Filters', color: AppColors.textColor),
            ],
          ),
          Row(
            children: [
              CustomText.t14('Sorting by', color: AppColors.textColor),
              const SizedBox(width: 7),
              const Icon(Icons.keyboard_arrow_down, size: 20, color: AppColors.mainColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context, List<ProductModel> productsList) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: productsList.length,
      itemBuilder: (context, index) {
        final product = productsList[index];
        return GestureDetector(
          onTap: () => context.push('/product', extra: product),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              CustomText.t14(product.name, maxLines: 1, overflow: TextOverflow.ellipsis),
              CustomText.t14('\$${product.price}', color: AppColors.accentColor),
            ],
          ),
        );
      },
    );
  }
}
