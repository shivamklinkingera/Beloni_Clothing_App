import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/app_state_provider.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/logo_svg.dart';
import '../../widgets/custom_safe_area.dart';
import '../../core/theme/app_colors.dart';

class OnboardingData {
  final String title;
  final String description;
  final String image;

  OnboardingData({required this.title, required this.description, required this.image});
}

final List<OnboardingData> onboardingList = [
  OnboardingData(
    title: 'Welcome to\nBeloni!',
    description: 'Labore sunt culpa excepteur culpa ipsum.\nLabore occaecat ex nisi mollit.',
    image: 'https://george-fx.github.io/beloni/onboarding/01.jpg',
  ),
  OnboardingData(
    title: 'Easy Track\nOrder!',
    description: 'Labore sunt culpa excepteur culpa ipsum.\nLabore occaecat ex nisi mollit.',
    image: 'https://george-fx.github.io/beloni/onboarding/02.jpg',
  ),
  OnboardingData(
    title: 'Door to Door\nDelivery!',
    description: 'Labore sunt culpa excepteur culpa ipsum.\nLabore occaecat ex nisi mollit.',
    image: 'https://george-fx.github.io/beloni/onboarding/03.jpg',
  ),
];

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomSafeArea(
        edges: const ['top'],
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 40),
                const Center(child: LogoSvg()),
                const SizedBox(height: 12),
                Expanded(
                  flex: 2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/01.png',
                        width: 210,
                        fit: BoxFit.contain,
                      ),
                      PageView.builder(
                        controller: _pageController,
                        itemCount: onboardingList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText.h1(
                                onboardingList[index].title,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 14),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 40),
                                child: CustomText.t16(
                                  onboardingList[index].description,
                                  textAlign: TextAlign.center,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: onboardingList.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        onboardingList[index].image,
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 100), // Space for button
              ],
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: PrimaryButton(
                title: 'Get Started',
                onPress: () {
                  ref.read(appStateProvider.notifier).setIsFirstTime(false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
