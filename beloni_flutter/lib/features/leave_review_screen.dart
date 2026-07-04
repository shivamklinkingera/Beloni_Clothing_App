import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_safe_area.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class LeaveReviewScreen extends StatefulWidget {
  const LeaveReviewScreen({super.key});

  @override
  State<LeaveReviewScreen> createState() => _LeaveReviewScreenState();
}

class _LeaveReviewScreenState extends State<LeaveReviewScreen> {
  int _rating = 0;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomSafeArea(
        child: Column(
          children: [
            const CustomHeader(title: 'Leave a review'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Image.network(
                      'https://george-fx.github.io/beloni/products-02/14.jpg',
                      width: 204,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 30),
                    CustomText.h2('Please rate the quality of\nservice for the order!', textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    _buildRatingStars(),
                    const SizedBox(height: 20),
                    CustomText.t16(
                      'Your comments and suggestions help\nus improve the service quality better!',
                      textAlign: TextAlign.center,
                      color: AppColors.textColor,
                    ),
                    const SizedBox(height: 30),
                    _buildBigInputField(),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      title: 'Submit',
                      onPress: () => context.pop(),
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

  Widget _buildRatingStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () => setState(() => _rating = index + 1),
          child: Icon(
            index < _rating ? Icons.star : Icons.star_border,
            color: Colors.orange,
            size: 40,
          ),
        );
      }),
    );
  }

  Widget _buildBigInputField() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.pastel,
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: TextField(
        controller: _commentController,
        maxLines: 5,
        decoration: const InputDecoration(
          hintText: 'Enter your comment...',
          border: InputBorder.none,
        ),
        style: AppTypography.t16.copyWith(color: AppColors.mainColor),
      ),
    );
  }
}
