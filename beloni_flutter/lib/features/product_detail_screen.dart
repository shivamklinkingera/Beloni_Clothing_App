import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../models/product_model.dart';
import '../providers/cart_provider.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_header.dart';
import '../widgets/custom_safe_area.dart';
import '../widgets/primary_button.dart';
import '../core/theme/app_colors.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final ProductModel product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  ConsumerState<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  int _currentImageIndex = 0;
  late String _selectedSize;
  late String _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedSize = widget.product.sizes.isNotEmpty ? widget.product.sizes[0] : '';
    _selectedColor = widget.product.colors.isNotEmpty ? widget.product.colors[0] : '';
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    final cartItem = cartItems.where((item) => item.id == widget.product.id).firstOrNull;
    final quantity = cartItem?.cartQuantity ?? 0;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomSafeArea(
        child: Column(
          children: [
            const CustomHeader(title: '', showBackButton: true),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCarousel(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: CustomText.h2(widget.product.name)),
                              const Icon(Icons.favorite_border, color: AppColors.mainColor),
                            ],
                          ),
                          const SizedBox(height: 7),
                          Row(
                            children: [
                              CustomText.t14('IN STOCK', color: const Color(0xFF00824B)),
                              const SizedBox(width: 10),
                              _buildRating(widget.product.rating),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText.h3('\$${widget.product.price}', color: AppColors.accentColor),
                              _buildQuantitySelector(quantity),
                            ],
                          ),
                          const SizedBox(height: 25),
                          _buildSectionTitle('Color'),
                          _buildColorSelector(),
                          const SizedBox(height: 25),
                          _buildSectionTitle('Size'),
                          _buildSizeSelector(),
                          const SizedBox(height: 25),
                          _buildSectionTitle('Description'),
                          CustomText.t16(widget.product.description, color: AppColors.textColor),
                          const SizedBox(height: 40),
                          PrimaryButton(
                            title: '+ Add to cart',
                            onPress: () {
                              ref.read(cartProvider.notifier).addToCart(widget.product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${widget.product.name} added to cart')),
                              );
                            },
                          ),
                          const SizedBox(height: 40),
                          _buildReviewsSection(),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return SizedBox(
      height: 350,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: widget.product.images.length,
            onPageChanged: (index) => setState(() => _currentImageIndex = index),
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: widget.product.images[index],
                fit: BoxFit.cover,
                width: double.infinity,
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.product.images.length,
                (index) => Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.mainColor.withOpacity(_currentImageIndex == index ? 1 : 0.2),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRating(double rating) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < rating.floor() ? Icons.star : Icons.star_border,
          size: 14,
          color: Colors.orange,
        ),
      ),
    );
  }

  Widget _buildQuantitySelector(int quantity) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pastel,
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove, size: 18),
            onPressed: () => ref.read(cartProvider.notifier).removeFromCart(widget.product),
          ),
          CustomText.t14('$quantity'),
          IconButton(
            icon: const Icon(Icons.add, size: 18),
            onPressed: () => ref.read(cartProvider.notifier).addToCart(widget.product),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CustomText.h5(title),
    );
  }

  Widget _buildColorSelector() {
    return Wrap(
      spacing: 10,
      children: widget.product.colors.map((color) {
        return GestureDetector(
          onTap: () => setState(() => _selectedColor = color),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getColorFromName(color),
              border: Border.all(
                color: _selectedColor == color ? AppColors.accentColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSizeSelector() {
    return Wrap(
      spacing: 10,
      children: widget.product.sizes.map((size) {
        bool isSelected = _selectedSize == size;
        return GestureDetector(
          onTap: () => setState(() => _selectedSize = size),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.mainColor : AppColors.white,
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: CustomText.t14(
              size,
              color: isSelected ? AppColors.white : AppColors.textColor,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildReviewsSection() {
    final reviews = widget.product.reviews;
    final displayReviews = reviews.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText.h5('Reviews (${reviews.length})'),
            TextButton(
              onPressed: () => context.push('/reviews', extra: reviews),
              child: CustomText.t14('View All', color: AppColors.accentColor),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...displayReviews.map((review) => Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText.h6(review.name),
                  _buildRating(review.rating.toDouble()),
                ],
              ),
              const SizedBox(height: 5),
              CustomText.t14(review.comment, color: AppColors.textColor),
              const SizedBox(height: 5),
              CustomText.t14(review.date, color: AppColors.textColor.withOpacity(0.5), fontSize: 12),
            ],
          ),
        )),
      ],
    );
  }

  Color _getColorFromName(String name) {
    switch (name.toLowerCase()) {
      case 'camel': return const Color(0xFFC19A6B);
      case 'black': return Colors.black;
      case 'white': return Colors.white;
      default: return Colors.grey;
    }
  }
}
