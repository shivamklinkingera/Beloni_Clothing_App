import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/app_state_provider.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_safe_area.dart';
import '../../core/theme/app_colors.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomSafeArea(
        child: Column(
          children: [
            const CustomHeader(
              title: 'My profile',
              showBackButton: false,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                child: Column(
                  children: [
                    _buildUserInfo(context),
                    const SizedBox(height: 20),
                    _buildProfileList(context, ref),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/edit-profile'),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.accentColor, width: 6),
                  image: const DecorationImage(
                    image: NetworkImage('https://george-fx.github.io/beloni/avatar/01.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, size: 16, color: AppColors.mainColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          CustomText.h3('Kristin Watson', textAlign: TextAlign.center),
          const SizedBox(height: 4),
          CustomText.t14('kristinwatson@mail.com', textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildProfileList(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        _ProfileItem(
          icon: Icons.calendar_today_outlined,
          title: 'Order history',
          onTap: () => context.push('/order-history'),
        ),
        _ProfileItem(
          icon: Icons.credit_card_outlined,
          title: 'Payment method',
          onTap: () => context.push('/payment-method'),
        ),
        _ProfileItem(
          icon: Icons.location_on_outlined,
          title: 'My address',
          onTap: () => context.push('/my-address'),
        ),
        _ProfileItem(
          icon: Icons.card_giftcard_outlined,
          title: 'My promocodes',
          onTap: () => context.push('/my-promocodes'),
        ),
        _ProfileItem(
          icon: Icons.help_outline,
          title: 'FAQ',
          onTap: () => context.push('/faq'),
        ),
        _ProfileItem(
          icon: Icons.logout,
          title: 'Sign out',
          onTap: () => ref.read(appStateProvider.notifier).logout(),
        ),
      ],
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileItem({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.pastel,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: AppColors.mainColor),
              const SizedBox(width: 16),
              Expanded(child: CustomText.t16(title, color: AppColors.mainColor)),
              const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.mainColor),
            ],
          ),
        ),
      ),
    );
  }
}
