import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_safe_area.dart';
import '../../core/theme/app_colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(text: 'Kristin Watson');
  final TextEditingController _emailController = TextEditingController(text: 'kristinwatson@mail.com');
  final TextEditingController _phoneController = TextEditingController(text: '+17 123456789');
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomSafeArea(
        child: Column(
          children: [
            CustomHeader(
              title: 'Edit profile',
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
                              _buildAvatar(),
                              const SizedBox(height: 34),
                              _inputField(
                                controller: _nameController,
                                placeholder: 'Full Name',
                                validator: (value) => value == null || value.isEmpty ? 'Name cannot be empty' : null,
                              ),
                              const SizedBox(height: 10),
                              _inputField(
                                controller: _emailController,
                                placeholder: 'Email',
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'Email cannot be empty';
                                  if (!value.contains('@')) return 'Invalid email';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              _inputField(
                                controller: _phoneController,
                                placeholder: 'Phone',
                                validator: (value) => value == null || value.isEmpty ? 'Phone cannot be empty' : null,
                              ),
                              const SizedBox(height: 10),
                              _inputField(
                                controller: _addressController,
                                placeholder: 'Enter your address',
                                validator: (value) => value == null || value.isEmpty ? 'Address cannot be empty' : null,
                              ),
                              const SizedBox(height: 20),
                              PrimaryButton(
                                title: 'Save changes',
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

  Widget _buildAvatar() {
    return Stack(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.accentColor, width: 6),
            image: const DecorationImage(
              image: NetworkImage('https://george-fx.github.io/beloni/avatar/01.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.camera_alt_outlined, size: 20, color: AppColors.mainColor),
          ),
        ),
      ],
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
          hintStyle: const TextStyle(color: Color(0x80666666)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: InputBorder.none,
          errorStyle: const TextStyle(height: 0),
        ),
        style: const TextStyle(color: Color(0xFF222222)),
      ),
    );
  }
}
