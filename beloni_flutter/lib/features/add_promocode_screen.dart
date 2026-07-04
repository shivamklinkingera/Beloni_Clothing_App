import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_safe_area.dart';
import '../../widgets/primary_button.dart';
import '../../core/theme/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AddPromocodeScreen extends StatefulWidget {
  const AddPromocodeScreen({super.key});

  @override
  State<AddPromocodeScreen> createState() => _AddPromocodeScreenState();
}

class _AddPromocodeScreenState extends State<AddPromocodeScreen> {
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomSafeArea(
        child: Column(
          children: [
            CustomHeader(
              title: 'Add a promocode',
              backgroundColor: AppColors.pastel,
              onBackPress: () => context.pop(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: 'https://george-fx.github.io/beloni/products-02/15.jpg',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 30),
                    CustomText.h2(
                      'Your don’t have\npromocodes yet!',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 14),
                    CustomText.t16(
                      'Qui ex aute ipsum duis. Incididunt\nadipisicing voluptate laborum',
                      color: AppColors.textColor,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    _inputField(
                      controller: _codeController,
                      placeholder: 'Discount2022',
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      title: 'Add a promocode',
                      onPress: () {
                        context.pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String placeholder,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: TextStyle(color: AppColors.textColor.withOpacity(0.5)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: InputBorder.none,
        ),
        style: const TextStyle(color: AppColors.mainColor),
      ),
    );
  }
}
