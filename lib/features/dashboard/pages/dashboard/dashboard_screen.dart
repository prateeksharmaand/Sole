import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sole/features/dashboard/pages/transactions/transactions_screen.dart';
import 'package:sole/features/dashboard/pages/assets/assets_screen.dart';
import 'package:sole/features/dashboard/pages/invoices/invoices_screen.dart';
import 'package:sole/features/dashboard/pages/add_expenses/add_expenses_screen.dart';
import 'package:sole/features/dashboard/pages/notification/notification_screen.dart';
import 'package:sole/features/dashboard/pages/profile/profile_screen.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/images.dart';
import 'package:sole/utils/helpers/helper_functions.dart';
import '../../../../../utils/constants/sizes.dart';
import 'dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? UColors.black : UColors.bg,
      body: Obx(() {
        // If first time open, show onboarding UI
        if (controller.isFirstTimeOpen.value) {
          return SingleChildScrollView(
            child: _buildFirstTimeOnboarding(context, dark),
          );
        }

        // Otherwise show main dashboard
        return SingleChildScrollView(
          child: Stack(
            children: [
              /// 1. Blue Header Background
              Container(
                height: 280,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: USizes.defaultSpace,
                  vertical: USizes.appBarHeight,
                ),
                decoration: const BoxDecoration(color: UColors.primary),
                child: Column(
                  children: [
                    /// App Bar Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Logo / Title
                        SvgPicture.asset(
                          UImages.logoMedium,
                          height: 50,
                          width: 50,
                          colorFilter: ColorFilter.mode(
                            UColors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        // Notification & Profile
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  Get.to(() => const NotificationScreen()),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: UColors.white.withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  UImages.notificationIcon,
                                  height: 18,
                                  width: 18,
                                  colorFilter: ColorFilter.mode(
                                    UColors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: USizes.spaceBtwItems),
                            GestureDetector(
                              onTap: () => Get.to(() => const ProfileScreen()),
                              child: const CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                  "https://as2.ftcdn.net/v2/jpg/01/18/63/09/1000_F_118630957_MvuK2rw0Avyp3HwlARVQWx7M3edlC4oO.jpg",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// 2. Overlapping Cards Content
              Padding(
                padding: const EdgeInsets.only(
                  top: 110.0,
                  left: USizes.defaultSpace,
                  right: USizes.defaultSpace,
                ),
                child: Column(
                  children: [
                    /// --- Header Balance & Quick Actions ---
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(USizes.md),
                      decoration: BoxDecoration(
                        color: dark ? UColors.dark : UColors.white,
                        borderRadius: BorderRadius.circular(
                          USizes.cardRadiusLg,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: UColors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Balance Header & Dropdown
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Current Balance",
                                style: TextStyle(
                                  color: UColors.textSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: UColors.borderPrimary,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Obx(
                                  () => DropdownButton<String>(
                                    value: controller.selectedTimeRange.value,
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 18,
                                    ),
                                    underline: const SizedBox(),
                                    isDense: true,
                                    style: TextStyle(
                                      color: UColors.textSecondary,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                    items: ['MTD', 'YTD', 'ALL'].map((
                                      String value,
                                    ) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            color: UColors.textSecondary,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: controller.changeTimeRange,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: USizes.sm),

                          /// Balance Amount
                          Obx(
                            () => Text(
                              "\$${controller.currentBalance.value.toStringAsFixed(0)}",
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 28,
                                  ),
                            ),
                          ),
                          SizedBox(height: 20),

                          /// Action Grid (3x2)
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 3,
                            mainAxisSpacing: USizes.spaceBtwItems,
                            crossAxisSpacing: USizes.spaceBtwItems,
                            childAspectRatio: 1.0,
                            padding: EdgeInsets.zero,
                            children: [
                              _buildActionItem(
                                context,
                                icon: UImages.clockIcon,
                                label: 'Tracker',
                              ),
                              _buildActionItem(
                                context,
                                icon: UImages.bankIcon,
                                label: 'Transactions',
                                onTap: () =>
                                    Get.to(() => const TransactionsScreen()),
                              ),
                              _buildActionItem(
                                context,
                                icon: UImages.folderOpenIcon,
                                label: 'Assets',
                                onTap: () => Get.to(() => const AssetsScreen()),
                              ),
                              _buildActionItem(
                                context,
                                icon: UImages.documentIcon2,
                                label: 'Quotes',
                                onTap: () =>
                                    Get.to(() => const InvoicesScreen()),
                              ),
                              _buildActionItem(
                                context,
                                icon: UImages.dollarIcon,
                                label: 'Client Refunds',
                              ),
                              _buildActionItem(
                                context,
                                icon: UImages.profileCircleIcon,
                                label: 'Contact',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: USizes.spaceBtwSections),

                    /// --- Financial Stats ---
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(USizes.md),
                      decoration: BoxDecoration(
                        color: dark ? UColors.dark : UColors.white,
                        borderRadius: BorderRadius.circular(
                          USizes.cardRadiusLg,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: UColors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              _buildStatItem(
                                context,
                                "Total Revenue",
                                controller.totalRevenue.value,
                              ),
                              _buildStatItem(
                                context,
                                "Net Profit",
                                controller.netProfit.value,
                              ),
                              _buildStatItem(
                                context,
                                "Profit Margin %",
                                controller.profitMargin.value,
                                isCurrency: false,
                              ),
                            ],
                          ),
                          const SizedBox(height: USizes.spaceBtwItems),
                          Row(
                            children: [
                              _buildStatItem(
                                context,
                                "Total Expense",
                                controller.totalExpense.value,
                              ),
                              _buildStatItem(
                                context,
                                "Forecast",
                                controller.forecast.value,
                              ),
                              _buildStatItem(
                                context,
                                "Total Tax",
                                controller.totalTax.value,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: USizes.spaceBtwSections),

                    /// --- Transactions Section ---
                    // Use same container style
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(USizes.md),
                      decoration: BoxDecoration(
                        color: dark ? UColors.dark : UColors.white,
                        borderRadius: BorderRadius.circular(
                          USizes.cardRadiusLg,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: UColors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Toggle
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: UColors.bg,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Obx(
                              () => Row(
                                children: [
                                  _buildToggleTab(
                                    context,
                                    "Income",
                                    controller.selectedTransactionTab.value ==
                                        "Income",
                                  ),
                                  _buildToggleTab(
                                    context,
                                    "Expenses",
                                    controller.selectedTransactionTab.value ==
                                        "Expenses",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: USizes.spaceBtwItems),

                          // List
                          Obx(() {
                            final isIncome =
                                controller.selectedTransactionTab.value ==
                                "Income";
                            final transactions = isIncome
                                ? controller.incomeTransactions
                                : controller.expenseTransactions;

                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: transactions.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                final t = transactions[index];
                                return _buildTransactionItem(context, t);
                              },
                            );
                          }),

                          const SizedBox(height: USizes.spaceBtwItems),

                          // Show More Button
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () =>
                                  Get.to(() => const TransactionsScreen()),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: UColors.borderPrimary,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Show More",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                    color: UColors.textSecondary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: USizes.spaceBtwSections),

                    /// --- Invoice Stats (Unpaid/Paid) ---
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(USizes.md),
                      decoration: BoxDecoration(
                        color: dark ? UColors.dark : UColors.white,
                        borderRadius: BorderRadius.circular(
                          USizes.cardRadiusLg,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: UColors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Unpaid",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: UColors.textSecondary,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Obx(
                                      () => Text(
                                        "\$${controller.unpaidAmount.value.toStringAsFixed(0)},500",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineSmall,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Paid",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: UColors.textSecondary,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Obx(
                                      () => Text(
                                        "\$${controller.paidAmount.value.toStringAsFixed(0)},500",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineSmall,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: USizes.spaceBtwItems),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: UColors.bg,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      UImages.percentageSquareIcon,
                                      height: 20,
                                      width: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Next BAS Due",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                                Obx(
                                  () => Text(
                                    "${controller.daysRemainingBAS.value} Days remaining",
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: UColors.textSecondary,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: USizes.spaceBtwSections),

                    /// --- Money Goal ---
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(USizes.md),
                      decoration: BoxDecoration(
                        color: dark ? UColors.dark : UColors.white,
                        borderRadius: BorderRadius.circular(
                          USizes.cardRadiusLg,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: UColors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: UColors.primary.withValues(
                                        alpha: 0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: SvgPicture.asset(
                                      UImages.chartIcon,
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    "Money Goal",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 0,
                                  ),
                                  side: const BorderSide(
                                    color: UColors.borderPrimary,
                                  ),
                                ),
                                child: const Text("Manage"),
                              ),
                            ],
                          ),
                          const SizedBox(height: USizes.spaceBtwItems),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Obx(
                                () => Text(
                                  "\$${controller.moneyGoalCurrent.value.toStringAsFixed(0)},402",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: Obx(
                                  () => Text(
                                    "/\$${controller.moneyGoalTarget.value.toStringAsFixed(0)},000",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: UColors.textSecondary,
                                        ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: Obx(
                                  () => Text(
                                    "${controller.moneyGoalPercentage.value.toStringAsFixed(0)}%",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: UColors.success,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Obx(
                              () => LinearProgressIndicator(
                                value:
                                    controller.moneyGoalPercentage.value / 100,
                                backgroundColor: UColors.bg,
                                valueColor: const AlwaysStoppedAnimation(
                                  UColors.success,
                                ), // Green bar
                                minHeight: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: USizes.spaceBtwSections),
                  ],
                ),
              ),
            ],
          ),
        );
      }),

      // Floating action button with small action items above it
      floatingActionButton: Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (controller.isFabOpen.value) ...[
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: dark ? UColors.dark : UColors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: UColors.black.withValues(alpha: 0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _fabMini(
                      context,
                      UImages.documentIcon,
                      'Add Invoice',
                      const Color(0xFF5B7FFF),
                      onTap: () {
                        controller.toggleFab();
                        Get.to(() => const InvoicesScreen());
                      },
                    ),
                    _fabMini(
                      context,
                      UImages.documentIcon2,
                      'Add Quote',
                      const Color(0xFF9B7FFF),
                      onTap: () {
                        controller.toggleFab();
                        Get.to(() => const InvoicesScreen());
                      },
                    ),
                    _fabMini(
                      context,
                      UImages.dollarIcon,
                      'Add Expense',
                      const Color(0xFF4FC3F7),
                      onTap: () {
                        controller.toggleFab();
                        Get.to(() => const AddExpensesScreen());
                      },
                    ),
                    _fabMini(
                      context,
                      UImages.profileCircleIcon,
                      'Add Contact',
                      const Color(0xFFFF9F7F),
                      onTap: () {
                        controller.toggleFab();
                        // TODO: navigation for Contact
                      },
                    ),
                  ],
                ),
              ),
            ],
            FloatingActionButton(
              onPressed: controller.toggleFab,
              backgroundColor: UColors.primary,
              child: Obx(
                () => Icon(
                  controller.isFabOpen.value ? Icons.close : Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _fabMini(
    BuildContext context,
    String iconPath,
    String label,
    Color iconBackgroundColor, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconBackgroundColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SvgPicture.asset(
                iconPath,
                height: 18,
                width: 18,
                colorFilter: ColorFilter.mode(
                  iconBackgroundColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 100,
              child: Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFirstTimeOnboarding(BuildContext context, bool dark) {
    return Column(
      children: [
        _buildHeader(context, dark),
        Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            left: USizes.defaultSpace,
            right: USizes.defaultSpace,
          ),
          child: Column(
            children: [
              // Small balance card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(USizes.md),
                decoration: BoxDecoration(
                  color: dark ? UColors.dark : UColors.white,
                  borderRadius: BorderRadius.circular(USizes.cardRadiusLg),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Current Balance',
                          style: TextStyle(
                            color: UColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: UColors.borderPrimary),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text('MTD'),
                        ),
                      ],
                    ),
                    const SizedBox(height: USizes.sm),
                    Text(
                      '\$0',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: USizes.spaceBtwSections),

              // Welcome + progress
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to Sole, Gissele👋',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '0 of 3 step completed',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: UColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: LinearProgressIndicator(
                              value: 0.7,
                              backgroundColor: UColors.bg,
                              valueColor: const AlwaysStoppedAnimation(
                                UColors.success,
                              ),
                              minHeight: 8,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '70%',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: USizes.spaceBtwSections),

              _buildOnboardingCard(context, 1, 'Know your business', [
                'Verify Contact Details',
                'Add your ABN and business information',
                'Free weekly webinar and other learning resources',
                'Migrate data into Sole',
              ]),
              const SizedBox(height: 12),
              _buildOnboardingCard(context, 2, 'Create First Invoice', [
                'Verify Contact Details',
                'Add your ABN and business information',
                'Free weekly webinar and other learning resources',
                'Migrate data into Sole',
              ]),
              const SizedBox(height: 12),
              _buildOnboardingCard(context, 3, 'Migration', [
                'Verify Contact Details',
                'Add your ABN and business information',
                'Free weekly webinar and other learning resources',
                'Migrate data into Sole',
              ]),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOnboardingCard(
    BuildContext context,
    int index,
    String title,
    List<String> items,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(USizes.md),
      decoration: BoxDecoration(
        color: UColors.white,
        borderRadius: BorderRadius.circular(USizes.cardRadiusLg),
        boxShadow: [
          BoxShadow(
            color: UColors.black.withValues(alpha: 0.03),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: UColors.bg,
                child: Text(
                  index.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: UColors.borderPrimary),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      e,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool dark) {
    return Container(
      height: 160,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: USizes.defaultSpace,
        vertical: USizes.appBarHeight / 2,
      ),
      decoration: const BoxDecoration(color: UColors.primary),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            UImages.logoMedium,
            height: 44,
            width: 44,
            colorFilter: ColorFilter.mode(UColors.white, BlendMode.srcIn),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: UColors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  UImages.notificationIcon,
                  height: 18,
                  width: 18,
                  colorFilter: ColorFilter.mode(UColors.white, BlendMode.srcIn),
                ),
              ),
              const SizedBox(width: USizes.spaceBtwItems),
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  'https://as2.ftcdn.net/v2/jpg/01/18/63/09/1000_F_118630957_MvuK2rw0Avyp3HwlARVQWx7M3edlC4oO.jpg',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(
    BuildContext context, {
    required String icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: UColors.primaryLightE0FF.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              icon,
              height: 20,
              width: 20,
              colorFilter: ColorFilter.mode(UColors.primary, BlendMode.srcIn),
            ),
          ),
          const SizedBox(height: USizes.xs),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: UColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String title,
    double amount, {
    bool isCurrency = true,
  }) {
    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: UColors.textSecondary),
          ),
          const SizedBox(height: 4),
          Text(
            isCurrency
                ? '\$${amount.toStringAsFixed(2)}'
                : '${amount.toStringAsFixed(2)}',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleTab(BuildContext context, String title, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTransactionTab(title),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? UColors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: UColors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? UColors.textPrimary : UColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, Map<String, dynamic> t) {
    bool isPositive = t['amount'] > 0;
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: UColors.borderPrimary),
          ),
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            isPositive ? UImages.arrowLeftDownIcon : UImages.arrowRightUpIcon,
            color: UColors.textPrimary,
            height: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t['title'], style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 2),
              Text(
                "${t['date']} | ${t['time']}",
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: UColors.textSecondary),
              ),
            ],
          ),
        ),
        Text(
          "${isPositive ? '+' : ''}\$${(t['amount'] as double).abs().toStringAsFixed(0)}",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: isPositive ? UColors.success : UColors.error,
          ),
        ),
      ],
    );
  }
}
