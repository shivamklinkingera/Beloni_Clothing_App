import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/confirmation_code_input.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_safe_area.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class ConfirmationCodeScreen extends StatefulWidget {
  const ConfirmationCodeScreen({super.key});

  @override
  State<ConfirmationCodeScreen> createState() => _ConfirmationCodeScreenState();
}

class _ConfirmationCodeScreenState extends State<ConfirmationCodeScreen> {
  String _code = '';

  void _verifyCode() {
    if (_code.length == 5) {
      context.push('/signup-success');
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
              title: 'Verify your phone number',
              onBackPress: null,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText.t16(
                              'Enter your OTP code here.',
                              color: AppColors.textColor,
                            ),
                            const SizedBox(height: 30),
                            ConfirmationCodeInput(
                              length: 5,
                              onChanged: (value) => setState(() => _code = value),
                              onCompleted: (value) {
                                _code = value;
                                _verifyCode();
                              },
                            ),
                            const SizedBox(height: 30),
                            GestureDetector(
                              onTap: () {},
                              child: RichText(
                                text: TextSpan(
                                  style: AppTypography.t16.copyWith(color: AppColors.textColor),
                                  children: [
                                    const TextSpan(text: 'Did not receive the OTP? '),
                                    TextSpan(
                                      text: 'Resend.',
                                      style: TextStyle(color: AppColors.accentColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            PrimaryButton(
                              title: 'Verify',
                              onPress: _verifyCode,
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
}
