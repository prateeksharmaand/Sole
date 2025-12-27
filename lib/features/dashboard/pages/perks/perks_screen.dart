import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sole/common/widgets/appbar/appbar.dart';
import 'package:sole/features/dashboard/pages/perks/perks_controller.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/sizes.dart';

class PerksScreen extends StatelessWidget {
  const PerksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PerksController());

    return Scaffold(
      backgroundColor: UColors.light,
      appBar: UAppBar(
        title: const Text('Perks'),
        showBackArrow: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.info_circle)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: USizes.defaultSpace),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: USizes.defaultSpace,
              ),
              child: Text(
                'Perks',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: USizes.spaceBtwItems),
            _buildFeaturedPerks(context, controller),
            const SizedBox(height: USizes.spaceBtwSections),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: USizes.defaultSpace,
              ),
              child: Text(
                'Latest Deals',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: USizes.spaceBtwItems),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: USizes.defaultSpace,
              ),
              child: _buildLatestDeals(context, controller),
            ),
            const SizedBox(height: USizes.defaultSpace),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedPerks(BuildContext context, PerksController controller) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: USizes.defaultSpace),
        scrollDirection: Axis.horizontal,
        itemCount: controller.featuredPerks.length,
        separatorBuilder: (_, __) => const SizedBox(width: USizes.md),
        itemBuilder: (context, index) {
          final perk = controller.featuredPerks[index];
          return GestureDetector(
            onTap: () => controller.showPerkDetails(perk),
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(USizes.md),
              decoration: BoxDecoration(
                color: perk.bgColor,
                borderRadius: BorderRadius.circular(USizes.cardRadiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            perk.icon,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[200],
                                child: const Icon(
                                  Icons.image_not_supported_outlined,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Featured',
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    perk.title,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: USizes.xs),
                  Text(
                    perk.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: USizes.md),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Get this deal',
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLatestDeals(BuildContext context, PerksController controller) {
    return GridView.builder(
      itemCount: controller.latestDeals.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: USizes.md,
        crossAxisSpacing: USizes.md,
        childAspectRatio: 1.6, // Adjust as needed
      ),
      itemBuilder: (context, index) {
        final perk = controller.latestDeals[index];
        return GestureDetector(
          onTap: () => controller.showPerkDetails(perk),
          child: Container(
            padding: const EdgeInsets.all(USizes.sm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(USizes.cardRadiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      perk.icon,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.image_not_supported_outlined,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: USizes.md),
                Text(
                  perk.title,
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
