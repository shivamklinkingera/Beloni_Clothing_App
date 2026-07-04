import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_safe_area.dart';
import '../../core/theme/app_colors.dart';

class MyPromocodesScreen extends StatefulWidget {
  const MyPromocodesScreen({super.key});

  @override
  State<MyPromocodesScreen> createState() => _MyPromocodesScreenState();
}

class _MyPromocodesScreenState extends State<MyPromocodesScreen> {
  String _activeTab = 'current';

  final List<Map<String, dynamic>> _promocodes = [
    {'id': 1, 'name': 'Acme Co.', 'code': 'Discount21', 'discount': 50, 'valid_till': 'Expire Dec 31, 2023'},
    {'id': 2, 'name': 'Barone LLC.', 'code': 'Discount22', 'discount': 15, 'valid_till': 'Valid until Jan 30, 2023'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomSafeArea(
        child: Column(
          children: [
            const CustomHeader(title: 'My promocodes'),
            _buildTabs(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildPromocodeGrid(),
                    const SizedBox(height: 40),
                    _buildAddButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          _TabItem(
            title: 'Current',
            isActive: _activeTab == 'current',
            onTap: () => setState(() => _activeTab = 'current'),
          ),
          const SizedBox(width: 10),
          _TabItem(
            title: 'Used',
            isActive: _activeTab == 'used',
            onTap: () => setState(() => _activeTab = 'used'),
          ),
        ],
      ),
    );
  }

  Widget _buildPromocodeGrid() {
    return Wrap(
      spacing: 15,
      runSpacing: 15,
      children: _promocodes.map((promo) => _PromoCard(promo: promo)).toList(),
    );
  }

  Widget _buildAddButton() {
    return Column(
      children: [
        IconButton(
          icon: const Icon(Icons.add_circle_outline, size: 40, color: AppColors.mainColor),
          onPressed: () => context.push('/add-promocode'),
        ),
        CustomText.t14('Add a new promocode'),
      ],
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _TabItem({required this.title, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.mainColor, width: isActive ? 1 : 0)),
          ),
          child: CustomText.h4(title, color: AppColors.mainColor.withOpacity(isActive ? 1 : 0.5)),
        ),
      ),
    );
  }
}

class _PromoCard extends StatelessWidget {
  final Map<String, dynamic> promo;
  const _PromoCard({required this.promo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 55) / 2,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.pastel,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText.h5('${promo['discount']}%', color: AppColors.accentColor),
          const SizedBox(height: 5),
          CustomText.t14(promo['name'], maxLines: 1),
          const SizedBox(height: 5),
          CustomText.t14(promo['code'], color: AppColors.mainColor),
          const SizedBox(height: 10),
          CustomText.t14(promo['valid_till'], color: AppColors.textColor, fontSize: 10),
        ],
      ),
    );
  }
}
