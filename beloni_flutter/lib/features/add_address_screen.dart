import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_safe_area.dart';
import '../../widgets/primary_button.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomSafeArea(
        child: Column(
          children: [
            const CustomHeader(title: 'Add address'),
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
                              _inputField(
                                controller: _titleController,
                                placeholder: 'Home, Work, etc.',
                                validator: (value) => value == null || value.isEmpty ? 'Please enter a title' : null,
                              ),
                              const SizedBox(height: 10),
                              _inputField(
                                controller: _addressController,
                                placeholder: 'Enter your address',
                                validator: (value) => value == null || value.isEmpty ? 'Please enter an address' : null,
                              ),
                              const SizedBox(height: 20),
                              PrimaryButton(
                                title: 'Save address',
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
