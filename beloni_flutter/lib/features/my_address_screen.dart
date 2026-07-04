import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_safe_area.dart';
import '../../core/theme/app_colors.dart';

class MyAddressScreen extends StatelessWidget {
  const MyAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> addresses = [
      {'type': 'Home', 'address': '8000 S Kirkland Ave, Chicago, IL 6065...', 'icon': Icons.home_outlined},
      {'type': 'Work', 'address': '8000 S Kirkland Ave, Chicago, IL 6066...', 'icon': Icons.work_outline},
      {'type': 'Other', 'address': '8000 S Kirkland Ave, Chicago, IL 6067...', 'icon': Icons.location_on_outlined},
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomSafeArea(
        child: Column(
          children: [
            const CustomHeader(title: 'My address'),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  final item = addresses[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.pastel,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(item['icon'], color: AppColors.mainColor),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText.h5(item['type']),
                              CustomText.t14(item['address'], color: AppColors.textColor, maxLines: 1, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                        const Icon(Icons.edit, size: 16, color: AppColors.mainColor),
                      ],
                    ),
                  );
                },
              ),
            ),
            _buildAddButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, size: 40, color: AppColors.mainColor),
            onPressed: () => context.push('/add-address'),
          ),
          CustomText.t14('Add a new address'),
        ],
      ),
    );
  }
}
