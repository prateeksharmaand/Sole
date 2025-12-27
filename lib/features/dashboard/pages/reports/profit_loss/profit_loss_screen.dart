import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sole/common/widgets/appbar/appbar.dart';
import 'package:sole/features/dashboard/pages/reports/profit_loss/profit_loss_breakdown_screen.dart';
import 'package:sole/features/dashboard/pages/reports/profit_loss/profit_loss_controller.dart';
import 'package:sole/features/dashboard/pages/reports/profit_loss/send_report_screen.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/sizes.dart';

class ProfitLossScreen extends StatelessWidget {
  const ProfitLossScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfitLossController());

    return Scaffold(
      appBar: const UAppBar(title: Text('Profit & Loss'), showBackArrow: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(USizes.defaultSpace),
        child: Column(
          children: [
            // Info Box
            Container(
              padding: const EdgeInsets.all(USizes.md),
              decoration: BoxDecoration(
                color: UColors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(USizes.cardRadiusMd),
              ),
              child: Row(
                children: [
                  const Icon(Iconsax.info_circle, color: UColors.darkGrey),
                  const SizedBox(width: USizes.spaceBtwItems),
                  Expanded(
                    child: Text(
                      'Shows how much you made and spent so you can see how profitable you are. Also called a P&L or income statement.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: USizes.spaceBtwSections),

            // Date Filters
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: USizes.md,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: UColors.borderEEF1),
                        borderRadius: BorderRadius.circular(
                          USizes.cardRadiusSm,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: controller.selectedYear.value,
                          items: ['2025-2026', '2024-2025']
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                          onChanged: (val) {
                            if (val != null)
                              controller.selectedYear.value = val;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: USizes.spaceBtwItems),
                Expanded(
                  child: Obx(
                    () => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: USizes.md,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: UColors.borderEEF1),
                        borderRadius: BorderRadius.circular(
                          USizes.cardRadiusSm,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: controller.selectedMonth.value,
                          items: ['Dec 2025', 'Nov 2025']
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                          onChanged: (val) {
                            if (val != null)
                              controller.selectedMonth.value = val;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: USizes.spaceBtwSections),

            Obx(() {
              if (!controller.hasData.value) {
                return _buildEmptyState(context);
              }
              return Column(
                children: [
                  // Summary Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(USizes.md),
                    decoration: BoxDecoration(
                      color: UColors.white,
                      borderRadius: BorderRadius.circular(USizes.cardRadiusLg),
                      border: Border.all(color: UColors.borderEEF1),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Total Income',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: USizes.sm),
                        Text(
                          '\$${controller.totalIncome.value.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: USizes.spaceBtwItems),
                        const Divider(color: UColors.borderEEF1),
                        const SizedBox(height: USizes.spaceBtwItems),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Total Expenses',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                  const SizedBox(height: USizes.xs),
                                  Text(
                                    '\$${controller.totalExpenses.value.toStringAsFixed(2)}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 1,
                              color: UColors.borderEEF1,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Net Profit',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                  const SizedBox(height: USizes.xs),
                                  Text(
                                    '\$${controller.netProfit.value.toStringAsFixed(2)}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: USizes.spaceBtwSections),

                  // Detailed Sections
                  _buildExpandableSection(
                    context,
                    'Income',
                    controller.totalIncome.value,
                    controller.incomeDetails,
                  ),
                  const SizedBox(height: USizes.spaceBtwItems),
                  _buildExpandableSection(context, 'Cost of Sales', 0.0, []),
                  const SizedBox(height: USizes.spaceBtwItems),
                  _buildExpandableSection(context, 'Gross Profit', 0.0, []),
                  const SizedBox(height: USizes.spaceBtwItems),
                  _buildExpandableSection(context, 'Expenses', 1102.0, []),
                  const SizedBox(height: USizes.spaceBtwItems),
                  _buildExpandableSection(context, 'EBITDA', 0.0, []),
                  const SizedBox(height: USizes.spaceBtwItems),
                  _buildExpandableSection(context, 'Net Profit', 795.82, []),
                ],
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(USizes.defaultSpace),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: UColors.borderEEF1),
                ),
                onPressed: controller.downloadReport,
                child: const Text('Download'),
              ),
            ),
            const SizedBox(width: USizes.spaceBtwItems),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Get.to(() => const SendReportScreen()),
                child: const Text('Send Report'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: USizes.spaceBtwSections * 2),
        Container(
          padding: const EdgeInsets.all(USizes.lg),
          decoration: BoxDecoration(
            color: UColors.grey.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Iconsax.calendar_1,
            size: 32,
            color: UColors.darkGrey,
          ),
        ),
        const SizedBox(height: USizes.spaceBtwItems),
        Text(
          'No activity for this period',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: USizes.sm),
        Text(
          'Try selecting a different month',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: UColors.darkGrey),
        ),
      ],
    );
  }

  Widget _buildExpandableSection(
    BuildContext context,
    String title,
    double total,
    List<dynamic> items,
  ) {
    // Only Income section items show the document icon
    final showIcon = title == 'Income';

    return Container(
      decoration: BoxDecoration(
        color: UColors.white,
        borderRadius: BorderRadius.circular(USizes.cardRadiusMd),
        border: Border.all(color: UColors.borderEEF1),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: items.isNotEmpty,
          // Always show the dropdown arrow, matching the design style (filled triangle)
          // ExpansionTile rotates this icon 180 degrees when expanded.
          trailing: const Icon(Icons.arrow_drop_down, color: UColors.darkGrey),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          children: items.map<Widget>((item) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                horizontal: USizes.md,
                vertical: USizes.sm,
              ),
              padding: const EdgeInsets.all(USizes.md),
              decoration: BoxDecoration(
                color: UColors.grey.withOpacity(0.05),
                borderRadius: BorderRadius.circular(USizes.cardRadiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['title'],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: UColors.darkGrey,
                        ),
                      ),
                      if (showIcon)
                        GestureDetector(
                          onTap: () {
                            if (item['title'] == 'Accounts Receivable') {
                              // Hacky way to access controller since we are inside a stateless widget method
                              // Ideally pass controller or use Get.find
                              final controller =
                                  Get.find<ProfitLossController>();
                              Get.to(
                                () => ProfitLossBreakdownScreen(
                                  title: item['title'],
                                  data: controller.accountsReceivableBreakdown,
                                ),
                              );
                            }
                          },
                          child: const Icon(
                            Iconsax.document_text,
                            color: UColors.darkGrey,
                            size: 18,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: USizes.sm),
                  Text(
                    '\$${item['amount'].toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: USizes.xs),
                  Text(
                    'YTD: \$${(item['ytd'] as double).toStringAsFixed(2)}',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: UColors.darkGrey),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
