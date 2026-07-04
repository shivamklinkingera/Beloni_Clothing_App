import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_safe_area.dart';
import '../../widgets/primary_button.dart';
import '../../core/theme/app_colors.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final subtotal = cartItems.fold<double>(0, (sum, item) => sum + (item.price * item.cartQuantity));

    return Scaffold(
      backgroundColor: cartItems.isEmpty ? AppColors.pastel : AppColors.white,
      body: CustomSafeArea(
        child: Column(
          children: [
            const CustomHeader(
              title: 'Order',
              showBackButton: false,
            ),
            Expanded(
              child: cartItems.isEmpty
                  ? _buildEmptyCart(context)
                  : _buildCartContent(context, ref, cartItems, subtotal),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: 'https://george-fx.github.io/beloni/products-02/11.jpg',
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 30),
          CustomText.h2('Your cart is empty!', textAlign: TextAlign.center),
          const SizedBox(height: 14),
          CustomText.t16(
            "Looks like you haven't made\nyour order yet.",
            textAlign: TextAlign.center,
            color: AppColors.textColor,
          ),
          const SizedBox(height: 30),
          PrimaryButton(
            title: 'Shop now',
            onPress: () {
              // Navigate to shop/home
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent(BuildContext context, WidgetRef ref, List<CartItem> items, double subtotal) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          ...items.map((item) => _CartItemWidget(item: item)),
          const SizedBox(height: 14),
          _buildPromoCode(),
          const SizedBox(height: 40),
          _buildSummary(subtotal),
          const SizedBox(height: 20),
          PrimaryButton(
            title: 'Proceed to checkout',
            onPress: () => context.push('/order-successful'),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCode() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.pastel),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Enter promocode',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: Container(
            height: 60,
            color: AppColors.pastel,
            child: Center(
              child: CustomText.t14('APPLY', color: AppColors.mainColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummary(double subtotal) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.pastel),
      ),
      child: Column(
        children: [
          _summaryRow('Subtotal', '\$$subtotal'),
          const SizedBox(height: 9),
          _summaryRow('Delivery', 'Free', valueColor: const Color(0xFF00824B)),
          const Divider(height: 20, color: AppColors.pastel),
          _summaryRow('Total', '\$$subtotal', isTotal: true),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {Color? valueColor, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText.t14(label, color: isTotal ? AppColors.mainColor : AppColors.textColor),
        CustomText.t14(value, color: valueColor ?? AppColors.mainColor),
      ],
    );
  }
}

class _CartItemWidget extends ConsumerWidget {
  final CartItem item;
  const _CartItemWidget({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: item.image,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText.t14(item.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                CustomText.t14('\$${item.price}', color: AppColors.accentColor),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove, size: 18),
                onPressed: () => ref.read(cartProvider.notifier).removeFromCart(item),
              ),
              CustomText.t14('${item.cartQuantity}'),
              IconButton(
                icon: const Icon(Icons.add, size: 18),
                onPressed: () => ref.read(cartProvider.notifier).addToCart(item),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
