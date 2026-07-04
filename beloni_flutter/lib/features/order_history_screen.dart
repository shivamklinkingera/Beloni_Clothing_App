import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_safe_area.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  final List<Map<String, dynamic>> _history = [
    {
      'id': 1,
      'number': 648752,
      'date': 'Feb 25, 2023 at 8:32 PM',
      'total': 281.85,
      'status': 'Shipping',
      'products': [
        {'name': 'Long sleeve shirt', 'quantity': 1, 'price': 6.93},
        {'name': 'Black sneakers', 'quantity': 1, 'price': 42.89},
      ]
    },
    {
      'id': 2,
      'number': 648752,
      'date': 'Feb 25, 2023 at 8:32 PM',
      'total': 281.85,
      'status': 'Delivered',
      'products': [
        {'name': 'Warm hat', 'quantity': 1, 'price': 30.0},
      ]
    },
  ];

  int? _expandedIndex;

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Shipping': return const Color(0xFFFFA462);
      case 'Delivered': return const Color(0xFF00824B);
      case 'Canceled': return const Color(0xFFF84C6B);
      default: return const Color(0xFFFFA462);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomSafeArea(
        child: Column(
          children: [
            const CustomHeader(
              title: 'Order history',
              onBackPress: null, // Uses default pop
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  final order = _history[index];
                  final isExpanded = _expandedIndex == index;
                  return _buildOrderCard(order, index, isExpanded);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order, int index, bool isExpanded) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => _expandedIndex = isExpanded ? null : index),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isExpanded ? const Color(0xFFF7F7F7) : AppColors.white,
              border: Border.all(color: AppColors.pastel),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText.h5(order['number'].toString()),
                    CustomText.t14(order['status'], color: _getStatusColor(order['status'])),
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText.t14(order['date'], color: AppColors.textColor),
                    CustomText(order['total'].toString(), style: AppTypography.latoBold.copyWith(color: AppColors.mainColor)),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.pastel),
            ),
            child: Column(
              children: [
                ...(order['products'] as List).map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText.t14(p['name'], color: AppColors.textColor),
                      CustomText.t14('${p['quantity']} x \$${p['price']}', color: AppColors.textColor),
                    ],
                  ),
                )),
                const Divider(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.repeat, size: 16),
                        const SizedBox(width: 6),
                        CustomText.t14('Repeat order'),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => context.push('/leave-review'),
                      child: CustomText.t14('Leave a review', color: AppColors.accentColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        const SizedBox(height: 10),
      ],
    );
  }
}
