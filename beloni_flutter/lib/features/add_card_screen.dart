import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_safe_area.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomSafeArea(
        child: Column(
          children: [
            const CustomHeader(title: 'Add a new card'),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 44),
                  decoration: const BoxDecoration(color: AppColors.pastel),
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
                              Image.network(
                                'https://george-fx.github.io/beloni/cards/03.png',
                                height: 180,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: 30),
                              _inputField(
                                controller: _nameController,
                                placeholder: 'Manish Kumar',
                                validator: (value) =>
                                    value == null || value.isEmpty
                                    ? 'Please enter name'
                                    : null,
                              ),
                              const SizedBox(height: 10),
                              _inputField(
                                controller: _numberController,
                                placeholder: 'xxxx xxxx xxxx xxxx',
                                keyboardType: TextInputType.number,
                                validator: (value) =>
                                    value == null || value.length < 16
                                    ? 'Invalid card number'
                                    : null,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: _inputField(
                                      controller: _expiryController,
                                      placeholder: '12/23',
                                      keyboardType: TextInputType.datetime,
                                      validator: (value) =>
                                          value == null || !value.contains('/')
                                          ? 'Invalid expiry'
                                          : null,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: _inputField(
                                      controller: _cvvController,
                                      placeholder: '•••',
                                      obscureText: true,
                                      keyboardType: TextInputType.number,
                                      validator: (value) =>
                                          value == null || value.length < 3
                                          ? 'Invalid CVV'
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              PrimaryButton(
                                title: 'Save card',
                                onPress: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.pop();
                                  }
                                },
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
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.white),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: AppTypography.t16.copyWith(
            color: AppColors.textColor.withOpacity(0.5),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          border: InputBorder.none,
          errorStyle: const TextStyle(height: 0),
        ),
        style: AppTypography.t16.copyWith(color: AppColors.mainColor),
      ),
    );
  }
}
