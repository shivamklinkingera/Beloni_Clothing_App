import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_safe_area.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomSafeArea(
        child: Column(
          children: [
            CustomHeader(
              title: 'Forgot password',
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomText.t16(
                                'Please enter your email address. You will receive a link to create a new password via email.',
                                color: AppColors.textColor,
                              ),
                              const SizedBox(height: 30),
                              _inputField(
                                controller: _emailController,
                                placeholder: 'kristinwatson@mail.com',
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'Please enter your email';
                                  if (!value.contains('@')) return 'Please enter a valid email';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              PrimaryButton(
                                title: 'Send',
                                onPress: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.push('/forgot-password-sent');
                                  }
                                },
                              ),
                              const SizedBox(height: 200), // Ensure space for background image
                            ],
                          ),
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

  Widget _inputField({
    required TextEditingController controller,
    required String placeholder,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: AppTypography.t16.copyWith(color: AppColors.textColor.withOpacity(0.5)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: InputBorder.none,
          errorStyle: const TextStyle(height: 0),
        ),
        style: AppTypography.t16.copyWith(color: AppColors.mainColor),
      ),
    );
  }
}
