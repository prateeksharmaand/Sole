import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/images.dart';
import 'package:sole/utils/constants/sizes.dart';
import 'package:sole/utils/helpers/helper_functions.dart';
import 'transactions_controller.dart';
import 'transaction_detail_screen.dart';

class TransactionsScreen extends GetView<TransactionsController> {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? UColors.black : UColors.bg,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Transactions',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: dark ? UColors.white : UColors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: USizes.defaultSpace),
        child: Column(
          children: [
            const SizedBox(height: USizes.spaceBtwItems),

            /// 1. Bank Account Cards (Horizontal Scroll)
            SizedBox(
              height: 180,
              child: Obx(
                () => ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.bankAccounts.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final account = controller.bankAccounts[index];
                    return _buildAccountCard(context, account, dark);
                  },
                ),
              ),
            ),

            const SizedBox(height: USizes.spaceBtwSections),

            /// 2. Search Bar & Filter
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: controller.updateSearch,
                    decoration: InputDecoration(
                      hintText: 'Search transaction',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: UColors.textSecondary,
                      ),
                      fillColor: dark ? UColors.dark : UColors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: dark ? UColors.dark : UColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: UColors.borderPrimary.withValues(alpha: 0.5),
                    ),
                  ),
                  child: SvgPicture.asset(
                    UImages.listIcon,
                    height: 24,
                    width: 24,
                    colorFilter: ColorFilter.mode(
                      dark ? UColors.white : UColors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: USizes.spaceBtwItems),

            /// 3. Matched/Unmatched Toggles
            Obx(
              () => Row(
                children: [
                  _buildToggleTab(
                    context,
                    "Unmatched",
                    controller.selectedTab.value == "Unmatched",
                  ),
                  const SizedBox(width: 12),
                  _buildToggleTab(
                    context,
                    "Matched",
                    controller.selectedTab.value == "Matched",
                  ),
                ],
              ),
            ),

            const SizedBox(height: USizes.spaceBtwSections),

            /// 4. Transaction List
            Obx(() {
              final isMatched = controller.selectedTab.value == "Matched";
              final transactions = isMatched
                  ? controller.matchedTransactions
                  : controller.unmatchedTransactions;

              if (transactions.isEmpty) {
                return _buildEmptyState(context, isMatched);
              }

              return Container(
                padding: const EdgeInsets.all(USizes.md),
                decoration: BoxDecoration(
                  color: dark ? UColors.dark : UColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: transactions.length,
                  separatorBuilder: (_, __) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Divider(height: 1, color: UColors.bg),
                  ),
                  itemBuilder: (context, index) {
                    final t = transactions[index];
                    return _buildTransactionRow(context, t, dark);
                  },
                ),
              );
            }),

            const SizedBox(height: 100), // Space for FAB
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTransactionBottomSheet(context, dark),
        backgroundColor: UColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showAddTransactionBottomSheet(BuildContext context, bool dark) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(USizes.defaultSpace),
        decoration: BoxDecoration(
          color: dark ? UColors.dark : UColors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add Transaction',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: UColors.bg,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, size: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: USizes.spaceBtwSections),
            _buildBottomSheetOption(
              context,
              icon: Icons.add,
              title: 'Add Transaction',
              onTap: () {
                Get.back();
                // Add Transaction Logic
              },
            ),
            const SizedBox(height: USizes.spaceBtwItems),
            _buildBottomSheetOption(
              context,
              icon: Icons.cloud_upload_outlined,
              title: 'Bulk Upload',
              onTap: () {
                Get.back();
                // Bulk Upload Logic
              },
            ),
            const SizedBox(height: USizes.spaceBtwSections),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildBottomSheetOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(USizes.md),
        decoration: BoxDecoration(
          border: Border.all(
            color: UColors.borderPrimary.withValues(alpha: 0.5),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: UColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: UColors.primary, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: UColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountCard(
    BuildContext context,
    Map<String, dynamic> account,
    bool dark,
  ) {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(vertical: USizes.md),
      decoration: BoxDecoration(
        color: dark ? UColors.dark : UColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: UColors.borderPrimary.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: USizes.md),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(right: USizes.md),
                  decoration: BoxDecoration(
                    color: UColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset(
                    UImages.bankIcon,
                    height: 24,
                    width: 24,
                    colorFilter: const ColorFilter.mode(
                      UColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account['name'],
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: UColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "\$${account['balance'].toStringAsFixed(1)}",
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Spacer(),
                const Icon(Icons.more_vert, color: UColors.textSecondary),
              ],
            ),
          ),
          const Divider(color: UColors.bg),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: USizes.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            size: 14,
                            color: UColors.success,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Last Synced',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                      Text(
                        account['lastSynced'],
                        style: Theme.of(
                          context,
                        ).textTheme.labelSmall?.copyWith(fontSize: 10),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: USizes.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        account['accountNumber'],
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        account['type'],
                        style: Theme.of(
                          context,
                        ).textTheme.labelSmall?.copyWith(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleTab(BuildContext context, String title, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(title),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1E2432) : UColors.white,
            borderRadius: BorderRadius.circular(30),
            border: isSelected
                ? null
                : Border.all(color: UColors.borderPrimary),
          ),
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? UColors.white : UColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionRow(
    BuildContext context,
    Map<String, dynamic> t,
    bool dark,
  ) {
    final isCredit = t['type'] == 'Credit';
    return InkWell(
      onTap: () {
        Get.to(
          () => TransactionDetailScreen(
            transaction: t,
            isMatched: controller.selectedTab.value == "Matched",
          ),
        );
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: UColors.bg,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              UImages.dollarIcon,
              height: 20,
              width: 20,
              colorFilter: const ColorFilter.mode(
                UColors.success,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t['title'],
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "${t['id']}  •  ${t['date']}",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: UColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${(t['amount'] as double).abs().toStringAsFixed(2)}",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isCredit
                      ? UColors.success.withValues(alpha: 0.1)
                      : UColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isCredit ? Icons.arrow_outward : Icons.south_west,
                      size: 10,
                      color: isCredit ? UColors.success : UColors.error,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      t['type'],
                      style: TextStyle(
                        fontSize: 10,
                        color: isCredit ? UColors.success : UColors.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, bool isMatched) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: UColors.bg, shape: BoxShape.circle),
          child: SvgPicture.asset(
            UImages.documentIcon,
            height: 40,
            width: 40,
            colorFilter: const ColorFilter.mode(
              UColors.textSecondary,
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          isMatched
              ? 'No matched transactions yet'
              : 'No unmatched transactions',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          isMatched
              ? 'Matched transactions will appear here once they\'re available.'
              : 'There are no transactions that need matching at the moment.',
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: UColors.textSecondary),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: 200,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: UColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, size: 18),
                SizedBox(width: 8),
                Text('Add Transaction'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: 200,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: UColors.borderPrimary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(UImages.importIcon, height: 18, width: 18),
                const SizedBox(width: 8),
                const Text('Bulk Upload'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
