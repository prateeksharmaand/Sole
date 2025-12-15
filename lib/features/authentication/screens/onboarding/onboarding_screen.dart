import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sole/common/widgets/app_btn/app_btn.dart';
import 'package:sole/features/authentication/controller/onboarding_controller.dart';
import 'package:sole/features/authentication/screens/onboarding/widgets/onboarding_pageView.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/images.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// PageView
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            children: [
              OnboardingPageView(
                image: UImages.onboarding1,
                text: 'Create invoices in under 30 seconds',
                subText:
                    'Send professional quotes and invoices to your clients and get paid faster',
              ),
              OnboardingPageView(
                image: UImages.onboarding2,
                text: 'Never lose a receipt again',
                subText:
                    'Snap, upload, and track your business expenses anytime, anywhere.',
              ),
              OnboardingPageView(
                image: UImages.onboarding3,
                text: 'No more tax surprises',
                subText:
                    'Automatically tracks GST & BAS so you’re always ready for tax time.',
              ),
            ],
          ),

          /// Page Indicator (NO Obx)
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: controller.pageController,
                count: 3,
                effect: WormEffect(
                  activeDotColor: UColors.primary,
                  dotColor: Colors.grey,
                  dotHeight: 8,
                  dotWidth: 24,
                ),
              ),
            ),
          ),

          /// Skip Button
          Positioned(
            top: 50,
            right: 24,
            left: 24,
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(UImages.logoSvg),
                  // Skip button only if not on page 2
                  if (controller.currentPage.value != 2)
                    GestureDetector(
                      onTap: controller.skip,
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 14,
                          color: UColors.text5866,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          /// Bottom Button (Obx REQUIRED)
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Obx(() {
              // Page 0 → only Next button
              if (controller.currentPage.value == 0) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: controller.nextPage,
                  child: const Text('Next'),
                );
              }

              // Page 1 & 2 → Back + Next / Get Started
              return Row(
                children: [
                  Expanded(
                    child: UButton(
                      onPressed: controller.previousPage,
                      label: "Back",
                      textColor: UColors.textSecondary,
                      bgColor: UColors.white,
                      borderColor: UColors.borderBtn,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: UButton(
                      onPressed: controller.nextPage,
                      label: controller.currentPage.value == 2
                          ? 'Get Started'
                          : 'Next',
                      bgColor: UColors.primary,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
