import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sole/common/widgets/appbar/appbar.dart';
import 'package:sole/features/dashboard/pages/refer_earn/refer_earn_controller.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/sizes.dart';

class ReferEarnScreen extends StatelessWidget {
  const ReferEarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReferEarnController());

    return Scaffold(
      backgroundColor: UColors.light,
      appBar: UAppBar(
        title: const Text('Refer & Earn'),
        showBackArrow: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.info_circle)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(USizes.defaultSpace),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: UColors.primary,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner Text Section
                Padding(
                  padding: const EdgeInsets.all(USizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You Earn \$50 dollars once the referred\nperson spent 90 days',
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: USizes.sm),
                      Text(
                        'Once the person you refer finishes their trial and purchases their Sole subscription, you will receive a free additional month on your Sole subscription (valued at \$14.99).',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                // White Content Section
                Container(
                  padding: const EdgeInsets.all(USizes.defaultSpace),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSteps(context),
                      const SizedBox(height: USizes.spaceBtwSections),
                      _buildInviteSection(context, controller),
                      const SizedBox(height: USizes.spaceBtwSections),
                      Obx(
                        () => controller.hasReferrals.value
                            ? _buildDashboard(context, controller)
                            : _buildEmptyState(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // _buildBanner is removed as it's merged into the main build method

  Widget _buildSteps(BuildContext context) {
    return Column(
      children: [
        _buildStepItem(
          context,
          '1',
          'Refer Your Friend',
          'Add your friend\'s email below to send a referral invite',
        ),
        const SizedBox(height: USizes.spaceBtwItems),
        _buildStepItem(
          context,
          '2',
          'Our Friend Wins',
          'Our friend will receive a coupon giving them a discount for trying Sole.',
        ),
        const SizedBox(height: USizes.spaceBtwItems),
        _buildStepItem(
          context,
          '3',
          'You Get Rewarded',
          'Once the person you have referred has made their first subscription payment, you will receive your reward.',
        ),
      ],
    );
  }

  Widget _buildStepItem(
    BuildContext context,
    String number,
    String title,
    String subtitle,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: const Color(0xFF2ECC71), // Green color from image
          child: Text(
            number,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        const SizedBox(width: USizes.spaceBtwItems),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: USizes.xs),
              Text(
                subtitle,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(color: UColors.textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInviteSection(
    BuildContext context,
    ReferEarnController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Invite Your Friend',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: USizes.sm),
        Text(
          'Add your friend email addresses and sent them invitations to join!',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: UColors.textSecondary),
        ),
        const SizedBox(height: USizes.spaceBtwItems),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: TextField(
                  controller: controller.inviteEmailController,
                  decoration: const InputDecoration(
                    hintText: 'Enter friend\'s email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(USizes.cardRadiusMd),
                      ),
                      borderSide: BorderSide(color: UColors.borderEEF1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(USizes.cardRadiusMd),
                      ),
                      borderSide: BorderSide(color: UColors.borderEEF1),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: USizes.spaceBtwItems),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF4F46E5), // Blue/Purple from image
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: controller.sendInvite,
                icon: const Icon(Iconsax.send_2, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDashboard(BuildContext context, ReferEarnController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(USizes.md),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(USizes.cardRadiusLg),
            border: Border.all(color: UColors.borderEEF1),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildStatItem(
                      context,
                      icon: Iconsax.dollar_circle,
                      iconColor: const Color(0xFF4F46E5),
                      bgColor: const Color(0xFFEEF2FF),
                      label: 'Your Earnings',
                      value:
                          '\$${controller.totalEarnings.value.toStringAsFixed(0)}',
                    ),
                  ),
                  const SizedBox(width: USizes.spaceBtwItems),
                  Expanded(
                    child: _buildStatItem(
                      context,
                      icon: Iconsax.people,
                      iconColor: const Color(0xFF4F46E5),
                      bgColor: const Color(0xFFEEF2FF),
                      label: 'Total Invited',
                      value: '${controller.totalInvited.value}',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: USizes.spaceBtwItems),
              Row(
                children: [
                  Expanded(
                    child: _buildStatItem(
                      context,
                      icon: Iconsax.tick_circle,
                      iconColor: const Color(0xFF4F46E5),
                      bgColor: const Color(0xFFEEF2FF),
                      label: 'Completed',
                      value: '${controller.completedReferrals.value}',
                    ),
                  ),
                  const SizedBox(width: USizes.spaceBtwItems),
                  Expanded(
                    child: _buildStatItem(
                      context,
                      icon: Iconsax.info_circle,
                      iconColor: const Color(
                        0xFF4F46E5,
                      ), // Using similar blue for consistency
                      bgColor: const Color(0xFFEEF2FF),
                      label: 'Pending',
                      value: '${controller.pendingReferrals.value}',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: USizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.withdrawEarnings,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB), // Primary blue
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Withdraw'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: USizes.spaceBtwSections),
        Text('Referred Friend', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: USizes.spaceBtwItems),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.referrals.length,
          separatorBuilder: (_, __) =>
              const SizedBox(height: USizes.spaceBtwItems),
          itemBuilder: (context, index) {
            final referral = controller.referrals[index];
            return Container(
              padding: const EdgeInsets.all(USizes.md),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(USizes.cardRadiusMd),
                border: Border.all(color: UColors.borderEEF1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFFE0F2FE),
                    child: Text(
                      referral.email[0].toUpperCase(),
                      style: const TextStyle(color: Color(0xFF0284C7)),
                    ),
                  ),
                  const SizedBox(width: USizes.spaceBtwItems),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          referral.email,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          referral.date,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: UColors.textSecondary),
                        ),
                        const SizedBox(height: USizes.sm),
                        Row(
                          children: [
                            _buildStatusBadge(referral.status),
                            const SizedBox(width: USizes.sm),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: UColors.borderEEF1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Iconsax.calendar_1,
                                    size: 14,
                                    color: UColors.textSecondary,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    referral.statusMessage,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: UColors.textSecondary,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: USizes.spaceBtwSections),
          // Placeholder for empty state image
          const Icon(Iconsax.gift, size: 64, color: UColors.borderEEF1),
          const SizedBox(height: USizes.spaceBtwItems),
          Text(
            'No referrals yet.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: USizes.sm),
          Text(
            'Start sharing your unique referral link to earn rewards. Every successful signup earns you \$50 after 90 days.',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: UColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: USizes.sm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: UColors.textSecondary),
            ),
            Text(value, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bg;
    Color text;
    switch (status) {
      case 'Pending':
        bg = const Color(0xFFFFF7ED); // Orange/Peach
        text = const Color(0xFFEA580C);
        break;
      case 'Completed':
        bg = const Color(0xFFECFDF5); // Green
        text = const Color(0xFF059669);
        break;
      case 'Active':
        bg = const Color(0xFFF3E8FF); // Purple
        text = const Color(0xFF7E22CE);
        break;
      default:
        bg = UColors.grey;
        text = UColors.darkGrey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: text,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
