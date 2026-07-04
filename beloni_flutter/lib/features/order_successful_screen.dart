import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_safe_area.dart';
import '../../core/theme/app_colors.dart';

class OrderSuccessfulScreen extends StatelessWidget {
  const OrderSuccessfulScreen({super.key});

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
                'https://george-fx.github.io/beloni/products-02/08.jpg',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 30),
              CustomText.h2('Thank you for your order!', textAlign: TextAlign.center),
              const SizedBox(height: 14),
              CustomText.t16(
                'Your order will be delivered on time.\nThank you!',
                textAlign: TextAlign.center,
                color: AppColors.textColor,
              ),
              const SizedBox(height: 30),
              PrimaryButton(
                title: 'View orders',
                onPress: () => context.go('/order-history'),
              ),
              const SizedBox(height: 10),
              PrimaryButton(
                title: 'Continue Shopping',
                backgroundColor: AppColors.white,
                titleStyle: const TextStyle(color: AppColors.mainColor),
                onPress: () => context.go('/'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// Note: Fixed the double button logic to match visual style in RN.
