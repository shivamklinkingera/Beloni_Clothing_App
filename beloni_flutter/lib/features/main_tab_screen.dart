import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/home_screen.dart';
import '../../features/profile_screen.dart';
import '../../features/categories_screen.dart';
import '../../features/wishlist_screen.dart';
import '../../features/order_screen.dart';
import '../../widgets/custom_safe_area.dart';
import '../../core/theme/app_colors.dart';

// Simple tab provider
final tabProvider = StateProvider<int>((ref) => 0);

class MainTabScreen extends ConsumerWidget {
  const MainTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(tabProvider);

    final List<Widget> screens = [
      const HomeScreen(),
      const CategoriesScreen(),
      const OrderScreen(),
      const WishlistScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
          color: AppColors.white,
        ),
        child: CustomSafeArea(
          edges: const ['bottom'],
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _TabItem(index: 0, icon: Icons.home_outlined, label: 'Home'),
                _TabItem(index: 1, icon: Icons.search, label: 'Search'),
                _TabItem(index: 2, icon: Icons.shopping_bag_outlined, label: 'Cart'),
                _TabItem(index: 3, icon: Icons.favorite_outline, label: 'Wishlist'),
                _TabItem(index: 4, icon: Icons.person_outline, label: 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TabItem extends ConsumerWidget {
  final int index;
  final IconData icon;
  final String label;

  const _TabItem({required this.index, required this.icon, required this.label});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(tabProvider);
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => ref.read(tabProvider.notifier).state = index,
      child: Icon(
        icon,
        color: isSelected ? AppColors.accentColor : AppColors.mainColor.withOpacity(0.5),
        size: 24,
      ),
    );
  }
}
