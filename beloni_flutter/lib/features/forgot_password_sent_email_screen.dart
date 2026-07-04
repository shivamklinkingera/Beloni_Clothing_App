import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/logo_svg.dart';
import '../../widgets/custom_safe_area.dart';
import '../../core/theme/app_colors.dart';

class ForgotPasswordSentEmailScreen extends StatelessWidget {
  const ForgotPasswordSentEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomSafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const LogoSvg(),
              const SizedBox(height: 40),
              Image.network(
                'https://george-fx.github.io/beloni/products-02/05.png',
                width: MediaQuery.of(context).size.width - 100,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 30),
              CustomText.h2('Your password has\nbeen reset!', textAlign: TextAlign.center),
              const SizedBox(height: 14),
              CustomText.t16(
                'Qui ex aute ipsum duis. Incididunt\nadipisicing voluptate laborum',
                textAlign: TextAlign.center,
                color: AppColors.textColor,
              ),
              const SizedBox(height: 30),
              PrimaryButton(
                title: 'Done',
                onPress: () => context.go('/signin'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
