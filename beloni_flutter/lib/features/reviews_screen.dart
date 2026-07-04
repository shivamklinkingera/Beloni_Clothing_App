import 'package:flutter/material.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_safe_area.dart';
import '../../core/theme/app_colors.dart';
import '../../models/review_model.dart';

class ReviewsScreen extends StatelessWidget {
  final List<ReviewModel> reviews;
  const ReviewsScreen({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomSafeArea(
        child: Column(
          children: [
            const CustomHeader(title: 'Reviews'),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return _ReviewItem(review: review);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewItem extends StatelessWidget {
  final ReviewModel review;
  const _ReviewItem({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(review.image),
                radius: 20,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.h6(review.name),
                  CustomText.t14(review.date, color: AppColors.textColor),
                ],
              ),
              const Spacer(),
              _buildRating(review.rating),
            ],
          ),
          const SizedBox(height: 10),
          CustomText.t16(review.comment, color: AppColors.textColor),
        ],
      ),
    );
  }

  Widget _buildRating(double rating) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < rating.floor() ? Icons.star : Icons.star_border,
          size: 14,
          color: Colors.orange,
        ),
      ),
    );
  }
}
