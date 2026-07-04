import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/app_state_provider.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_safe_area.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomSafeArea(
        child: Column(
          children: [
            CustomHeader(
              title: 'Sign in',
              showBackButton: GoRouter.of(context).canPop(),
              onBackPress: () => GoRouter.of(context).pop(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.symmetric(vertical: 44),
                  decoration: const BoxDecoration(
                    color: AppColors.pastel,
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/02.png',
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomText.h1('Welcome Back!', textAlign: TextAlign.center),
                              const SizedBox(height: 14),
                              CustomText.t16(
                                'Use social networks or your email',
                                textAlign: TextAlign.center,
                                color: AppColors.textColor,
                              ),
                              const SizedBox(height: 30),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _SocialButton(icon: Icons.facebook),
                                  SizedBox(width: 10),
                                  _SocialButton(icon: Icons.alternate_email),
                                  SizedBox(width: 10),
                                  _SocialButton(icon: Icons.g_mobiledata),
                                ],
                              ),
                              const SizedBox(height: 30),
                              _inputField(
                                controller: _emailController,
                                placeholder: 'kristinwatson@mail.com',
                                suffixIcon: const Icon(Icons.check, size: 18, color: AppColors.mainColor),
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'Please enter your email';
                                  if (!value.contains('@')) return 'Please enter a valid email';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              _inputField(
                                controller: _passwordController,
                                placeholder: '••••••••',
                                obscureText: _obscurePassword,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                    size: 18,
                                    color: AppColors.mainColor,
                                  ),
                                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'Please enter your password';
                                  if (value.length < 6) return 'Password must be at least 6 characters';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => setState(() => _rememberMe = !_rememberMe),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 18,
                                          height: 18,
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            border: Border.all(color: AppColors.pastel),
                                          ),
                                          child: _rememberMe
                                              ? Container(
                                                  margin: const EdgeInsets.all(3),
                                                  color: AppColors.accentColor,
                                                )
                                              : null,
                                        ),
                                        const SizedBox(width: 10),
                                        CustomText.t16('Remember me', color: AppColors.textColor),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () => context.push('/forgot-password'),
                                    child: CustomText.t16('Forgot password?', color: AppColors.accentColor),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              PrimaryButton(
                                title: 'Sign in',
                                onPress: () {
                                  if (_formKey.currentState!.validate()) {
                                    ref.read(appStateProvider.notifier).setTokens('accessToken', 'refreshToken');
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () => context.push('/signup'),
                                child: RichText(
                                  text: TextSpan(
                                    style: AppTypography.t16.copyWith(color: AppColors.textColor),
                                    children: [
                                      const TextSpan(text: 'No account? '),
                                      TextSpan(
                                        text: 'Register now.',
                                        style: TextStyle(color: AppColors.accentColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: TextStyle(color: AppColors.textColor.withOpacity(0.5)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: InputBorder.none,
          suffixIcon: suffixIcon,
          errorStyle: const TextStyle(height: 0),
        ),
        style: const TextStyle(color: AppColors.mainColor),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  const _SocialButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Icon(icon, color: AppColors.mainColor),
    );
  }
}
