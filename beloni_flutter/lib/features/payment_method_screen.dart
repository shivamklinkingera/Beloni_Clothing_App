import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_safe_area.dart';
import '../../core/theme/app_colors.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> cards = [
      'https://george-fx.github.io/beloni/cards/01.png',
      'https://george-fx.github.io/beloni/cards/02.png',
      'https://george-fx.github.io/beloni/cards/03.png',
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomSafeArea(
        child: Column(
          children: [
            const CustomHeader(title: 'Payment method'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Cards'),
                    _buildCardsList(cards),
                    const SizedBox(height: 30),
                    const _PaymentMethodsList(),
                    const SizedBox(height: 40),
                    _buildAddButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: CustomText.h5(title),
    );
  }

  Widget _buildCardsList(List<String> cards) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return Container(
            width: 279,
            margin: const EdgeInsets.only(right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(cards[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Center(
      child: Column(
        children: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, size: 40, color: AppColors.mainColor),
            onPressed: () => context.push('/add-card'),
          ),
          CustomText.t14('Add a new card'),
        ],
      ),
    );
  }
}

class _PaymentMethodsList extends StatelessWidget {
  const _PaymentMethodsList();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _PaymentMethodItem(title: 'Apple Pay', isSelected: true),
          _PaymentMethodItem(title: 'Pay Pal', isSelected: true),
          _PaymentMethodItem(title: 'Payoneer', isSelected: false, isAddable: true),
        ],
      ),
    );
  }
}

class _PaymentMethodItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final bool isAddable;

  const _PaymentMethodItem({required this.title, this.isSelected = false, this.isAddable = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        children: [
          CustomText.h5(title),
          const SizedBox(width: 8),
          if (isSelected) const Icon(Icons.check_circle, size: 16, color: Colors.green),
          const Spacer(),
          Icon(isAddable ? Icons.add : Icons.edit, size: 20, color: AppColors.mainColor),
        ],
      ),
    );
  }
}
