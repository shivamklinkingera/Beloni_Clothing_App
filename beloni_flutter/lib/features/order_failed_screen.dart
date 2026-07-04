import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_safe_area.dart';
import '../../core/theme/app_colors.dart';

class OrderFailedScreen extends StatelessWidget {
  const OrderFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pastel,
      body: CustomSafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Image.network(
                'https://george-fx.github.io/beloni/products-02/10.jpg',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 30),
              CustomText.h2('Sorry! Your order has\nfailed!', textAlign: TextAlign.center),
              const SizedBox(height: 14),
              CustomText.t16(
                'Something went wrong. Please try again\nto continue your order.',
                textAlign: TextAlign.center,
                color: AppColors.textColor,
              ),
              const SizedBox(height: 30),
              PrimaryButton(
                title: 'Try again',
                onPress: () => context.pop(),
              ),
              const SizedBox(height: 10),
              PrimaryButton(
                title: 'Go to my profile',
                backgroundColor: AppColors.white,
                titleStyle: const TextStyle(color: AppColors.mainColor),
                onPress: () => context.go('/'), // In RN it goes to profile tab usually
              ),
            ],
          ),
        ),
      ),
    );
  }
}
