import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_safe_area.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen({super.key});

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomSafeArea(
        child: Column(
          children: [
            CustomHeader(
              title: 'Verify your phone number',
              onBackPress: () => GoRouter.of(context).pop(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.only(top: 30, bottom: 50),
                  decoration: const BoxDecoration(
                    color: AppColors.pastel,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          'assets/images/03.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            CustomText.t16(
                              'We have sent you an SMS with a code to number +17 0123456789.',
                              color: AppColors.textColor,
                            ),
                            const SizedBox(height: 30),
                            _buildPhoneInput(),
                            const SizedBox(height: 20),
                            PrimaryButton(
                              title: 'Confirm',
                              onPress: () {
                                context.push('/confirmation-code');
                              },
                            ),
                            const SizedBox(height: 200),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneInput() {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          CustomText.t16('+1', color: AppColors.mainColor),
          const SizedBox(width: 10),
          const VerticalDivider(width: 1, indent: 15, endIndent: 15),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: '0123456789',
                border: InputBorder.none,
              ),
              style: AppTypography.t16.copyWith(color: AppColors.mainColor),
            ),
          ),
        ],
      ),
    );
  }
}
