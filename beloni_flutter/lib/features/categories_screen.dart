import 'package:flutter/material.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_safe_area.dart';
import '../../core/theme/app_colors.dart';

class Category {
  final int id;
  final String title;
  final String image;
  final int quantity;

  Category({required this.id, required this.title, required this.image, required this.quantity});
}

final List<Category> categoriesList = [
  Category(id: 1, title: 'Dresses', image: 'https://george-fx.github.io/kastelli/categories/01.jpg', quantity: 36),
  Category(id: 2, title: 'Pants', image: 'https://george-fx.github.io/kastelli/categories/02.jpg', quantity: 621),
  Category(id: 3, title: 'Accessories', image: 'https://george-fx.github.io/kastelli/categories/03.jpg', quantity: 150),
  Category(id: 4, title: 'Shoes', image: 'https://george-fx.github.io/kastelli/categories/04.jpg', quantity: 54),
  Category(id: 5, title: 'T - shirts', image: 'https://george-fx.github.io/kastelli/categories/05.jpg', quantity: 112),
  Category(id: 6, title: 'Suits', image: 'https://george-fx.github.io/kastelli/categories/06.jpg', quantity: 98),
];

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomSafeArea(
        child: Column(
          children: [
            const CustomHeader(
              title: 'Categories',
              showBackButton: false,
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: categoriesList.length,
                itemBuilder: (context, index) {
                  final category = categoriesList[index];
                  return _CategoryItem(category: category);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final Category category;
  const _CategoryItem({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pastel,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(category.image, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText.h5(category.title),
                CustomText.t14('${category.quantity} items', color: AppColors.textColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
