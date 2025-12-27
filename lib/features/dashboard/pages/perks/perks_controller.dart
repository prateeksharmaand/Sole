import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/routes/routes.dart';
import 'perk_model.dart';

class PerksController extends GetxController {
  final featuredPerks = <PerkModel>[
    PerkModel(
      title: 'Worldpay',
      description:
          'You can now access all-in-one payment features from within your Sole App.',
      icon:
          'https://static.vecteezy.com/system/resources/previews/008/214/517/original/abstract-geometric-logo-or-infinity-line-logo-for-your-company-free-vector.jpg',
      isFeatured: true,
      promoCode: 'SOLE',
      url: 'https://soleapp.com.au/partner/worldpay',
      bgColor: const Color(0xFF4F46E5),
    ),
    PerkModel(
      title: 'BizCover',
      description: 'You can now access payment features from within your..',
      icon:
          'https://img.freepik.com/premium-vector/abstract-logo-design-any-corporate-brand-business-company_1253202-94801.jpg',
      isFeatured: true,
      promoCode: 'BIZSOLE',
      url: 'https://bizcover.com.au',
      bgColor: const Color(0xFF4F46E5),
    ),
  ].obs;

  final latestDeals = <PerkModel>[
    PerkModel(
      title: 'SumUp',
      description: 'Payment solutions',
      icon:
          'https://static.vecteezy.com/system/resources/previews/008/214/517/original/abstract-geometric-logo-or-infinity-line-logo-for-your-company-free-vector.jpg',
      promoCode: 'SUMUP10',
      url: 'https://sumup.com',
    ),
    PerkModel(
      title: 'Bonza Business Sales',
      description: 'Business sales services',
      icon:
          'https://img.freepik.com/premium-vector/abstract-logo-design-any-corporate-brand-business-company_1253202-94801.jpg',
      promoCode: 'BONZA',
      url: 'https://bonza.com',
    ),
    PerkModel(
      title: 'Shift Finance',
      description: 'Business finance solutions',
      icon:
          'https://static.vecteezy.com/system/resources/previews/008/214/517/original/abstract-geometric-logo-or-infinity-line-logo-for-your-company-free-vector.jpg',
      promoCode: 'SHIFT',
      url: 'https://shift.com',
    ),
    PerkModel(
      title: 'Freedom Suites',
      description: 'Freelancer suites',
      icon:
          'https://img.freepik.com/premium-vector/abstract-logo-design-any-corporate-brand-business-company_1253202-94801.jpg',
      promoCode: 'FREEDOM',
      url: 'https://www.google.com/',
    ),
    PerkModel(
      title: 'Boss Coaching',
      description: 'Business coaching',
      icon:
          'https://static.vecteezy.com/system/resources/previews/008/214/517/original/abstract-geometric-logo-or-infinity-line-logo-for-your-company-free-vector.jpg',
      promoCode: 'BOSS',
      url: 'https://www.google.com/',
    ),
    PerkModel(
      title: 'MODC',
      description: 'Design services',
      icon:
          'https://img.freepik.com/premium-vector/abstract-logo-design-any-corporate-brand-business-company_1253202-94801.jpg',
      promoCode: 'MODC',
      url: 'https://www.google.com/',
    ),
  ].obs;

  void showPerkDetails(PerkModel perk) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Detail Perks',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              perk.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'Lorem ipsum dolor sit amet consectetur. Ipsum ullamcorper suspendisse in feugiat. Habitant est etiam elementum malesuada nam euismod facilisis diam.',
              style: TextStyle(color: UColors.textSecondary, fontSize: 14),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: UColors.borderEEF1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Promo Code',
                    style: TextStyle(color: UColors.textSecondary),
                  ),
                  Text(
                    perk.promoCode,
                    style: const TextStyle(
                      color: Color(0xFF4F46E5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  launchPerkUrl(perk.url);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F46E5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Get This Deal'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void launchPerkUrl(String url) {
    // In a real app, use url_launcher or navigate to a webview screen
    // For now, we'll just show a snackbar or print content
    print('Launching URL: $url');
    // Implement WebView navigation here if requested
    Get.toNamed(URoutes.webview, arguments: {'url': url});
  }
}
