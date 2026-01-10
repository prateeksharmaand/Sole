import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/common/widgets/textfields/app_text_fields.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/images.dart';
import 'package:sole/utils/constants/sizes.dart';
import 'package:sole/utils/helpers/device_helpers.dart';
import 'package:sole/routes/routes.dart';
import '../../controllers/expense_controller.dart';
import '../assets/assets_screen.dart';
import '../taxes_bankings/taxes_banking_screen.dart';

class ExpenseScreen extends GetView<ExpenseController> {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UColors.bg,
      floatingActionButton: FloatingActionButton(
        backgroundColor: UColors.primary,
        shape: const CircleBorder(),
        onPressed: () {
          Get.bottomSheet(
            const AddExpenseBottomSheet(),
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: USizes.defaultSpace20,
          vertical: UDeviceHelper.getAppBarHeight(),
        ),
        child: Column(
          children: [
            /// App Bar header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Expenses",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: UColors.textPrimary,
                  ),
                ),
                SvgPicture.asset(UImages.downloadIcon),
              ],
            ),
            SizedBox(height: USizes.defaultSpace20),

            /// header Container Data
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(USizes.md),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Obx(
                    () => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: UColors.borderBtn),
                        color: Colors.white,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.selectedMonth.value,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: UColors.textSecondary,
                          ),
                          items: controller.months.map((month) {
                            return DropdownMenuItem<String>(
                              value: month,
                              child: Text(
                                month,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: UColors.textSecondary,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              controller.changeMonth(value);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: USizes.md),
                  Obx(
                    () => CommonTextPrizePercent(
                      text: 'Total Expenses',
                      prize: '\$${controller.totalExpenses.value}',
                      percent: '+2.5%',
                      isProfit: true,
                    ),
                  ),
                  SizedBox(height: USizes.md),
                  Divider(color: UColors.divider),
                  SizedBox(height: USizes.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CommonTextPrizePercent(
                        text: 'Reconciled Expenses',
                        prize: '\$2,932',
                        percent: '+2.5%',
                        isProfit: true,
                      ),
                      CommonTextPrizePercent(
                        text: 'Pending Expenses',
                        prize: '\$2,932',
                        percent: '-8.5%',
                        isProfit: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: USizes.defaultSpace20),

            /// search and filter
            Row(
              children: [
                Expanded(
                  child: UTextField(
                    hintText: "Search expenses...",
                    onchanged: (value) {
                      controller.searchExpenses(value);
                    },
                    prefixWidget: Padding(
                      padding: EdgeInsets.only(left: USizes.sm),
                      child: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(width: USizes.sm),
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      ExpenseFilterBottomSheet(),
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                    );
                  },
                  child: SvgPicture.asset(
                    UImages.filterIcon,
                    width: 45,
                    height: 48,
                  ),
                ),
              ],
            ),
            SizedBox(height: USizes.defaultSpace20),

            /// Bottom List Details
            Expanded(
              child: Container(
                padding: EdgeInsets.all(USizes.md),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Obx(() {
                  // Loading state
                  if (controller.isLoading.value &&
                      controller.expenses.isEmpty) {
                    return Center(
                      child: CircularProgressIndicator(color: UColors.primary),
                    );
                  }

                  // Empty state
                  if (controller.expenses.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.receipt_long_outlined,
                            size: 64,
                            color: UColors.textSecondary.withValues(alpha: 0.5),
                          ),
                          SizedBox(height: USizes.md),
                          Text(
                            'No expenses found',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: UColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: USizes.sm),
                          Text(
                            'Add your first expense to get started',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              color: UColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // List with data
                  return RefreshIndicator(
                    onRefresh: controller.refreshExpenses,
                    color: UColors.primary,
                    child: ListView.builder(
                      controller: controller.scrollController,
                      itemCount:
                          controller.expenses.length +
                          (controller.isLoadingMore.value ? 1 : 0),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        // Loading more indicator at bottom
                        if (index == controller.expenses.length) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: UColors.primary,
                              ),
                            ),
                          );
                        }

                        final expense = controller.expenses[index];

                        return GestureDetector(
                          onTap: () {
                            // Navigate to details screen with expense ID
                            Get.toNamed(
                              URoutes.detailsExpensesScreen,
                              arguments: expense.expenseId,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: USizes.lg),
                            child: Row(
                              children: [
                                // Expense icon/image
                                expense.image != null &&
                                        expense.image!.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          expense.image!,
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  SvgPicture.asset(
                                                    UImages.assetsListIcon,
                                                  ),
                                        ),
                                      )
                                    : SvgPicture.asset(UImages.assetsListIcon),
                                SizedBox(width: USizes.md),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Expense name
                                      Text(
                                        expense.name,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: UColors.textPrimary,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: USizes.xs),
                                      Row(
                                        children: [
                                          // Client name
                                          Text(
                                            expense.client.name,
                                            style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11,
                                              color: UColors.textSecondary,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: USizes.sm,
                                            ),
                                            child: DotContainer(
                                              color: UColors.textSecondary
                                                  .withValues(alpha: .3),
                                            ),
                                          ),
                                          // Date
                                          Text(
                                            expense.date,
                                            style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11,
                                              color: UColors.textSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Classifications/Tags
                                      if (expense.classifications.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 4,
                                          ),
                                          child: Wrap(
                                            spacing: 4,
                                            children: expense.classifications
                                                .take(3)
                                                .map(
                                                  (classification) => Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 6,
                                                          vertical: 2,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: UColors.primary
                                                          .withValues(
                                                            alpha: 0.1,
                                                          ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            4,
                                                          ),
                                                    ),
                                                    child: Text(
                                                      classification.name,
                                                      style:
                                                          GoogleFonts.plusJakartaSans(
                                                            fontSize: 9,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                UColors.primary,
                                                          ),
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: USizes.md),
                                // Price
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '\$${expense.price}',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: UColors.textPrimary,
                                      ),
                                    ),
                                    if (expense.gst == 1)
                                      Text(
                                        'incl. GST',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 9,
                                          color: UColors.textSecondary,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommonTextPrizePercent extends StatelessWidget {
  final String text;
  final String prize;
  final String percent;
  final bool isProfit;
  const CommonTextPrizePercent({
    super.key,
    required this.text,
    required this.prize,
    required this.percent,
    required this.isProfit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: UColors.textSecondary,
          ),
        ),
        SizedBox(height: 6),
        Text(
          prize,
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: UColors.textPrimary,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: USizes.sm),
              padding: EdgeInsets.symmetric(
                horizontal: USizes.xs,
                vertical: USizes.xs / 2,
              ),
              decoration: BoxDecoration(
                color: isProfit ? UColors.greenFBF5 : UColors.redEBEC,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                percent,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                  color: isProfit ? UColors.green7F67 : UColors.red3137,
                ),
              ),
            ),
            Text(
              "vs last month",
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w400,
                fontSize: 11,
                color: UColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ExpenseFilterBottomSheet extends StatelessWidget {
  ExpenseFilterBottomSheet({super.key});

  final ExpenseController controller = Get.find<ExpenseController>();

  @override
  Widget build(BuildContext context) {
    // Load clients and suppliers when filter sheet opens
    if (controller.clients.isEmpty) {
      controller.loadClients();
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Filter",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: UColors.textPrimary,
                ),
              ),
              GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(Icons.close),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// SORT BY
          const Text("Sort by"),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            items: controller.months
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) {
              if (value != null) controller.changeMonth(value);
            },
            decoration: const InputDecoration(
              hintText: "Sort by",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          /// PRICE RANGE
          const Text("Price"),
          Obx(() {
            // Compute the effective max value
            final effectiveMax = controller.maxPrice.value > 0
                ? controller.maxPrice.value
                : 1000.0;

            // Ensure values are within valid range
            final clampedMin = controller.minPrice.value.clamp(
              0.0,
              effectiveMax,
            );
            final clampedMax = controller.maxPriceFilter.value.clamp(
              0.0,
              effectiveMax,
            );

            return RangeSlider(
              min: 0,
              max: effectiveMax,
              activeColor: UColors.primary,
              inactiveColor: UColors.textSecondary.withValues(alpha: .4),
              values: RangeValues(clampedMin, clampedMax),
              onChanged: (value) {
                controller.minPrice.value = value.start;
                controller.maxPriceFilter.value = value.end;
              },
            );
          }),
          Obx(
            () => Text(
              "\$ ${controller.minPrice.value.toInt()} - \$ ${controller.maxPriceFilter.value.toInt()}",
            ),
          ),

          const SizedBox(height: 20),

          /// DATE RANGE (UI only)
          const Text("Date Range"),
          const SizedBox(height: 8),
          TextField(
            readOnly: true,
            decoration: const InputDecoration(
              hintText: "DD / MM / YYYY",
              prefixIcon: Icon(Icons.calendar_today_outlined),
              suffixIcon: Icon(
                Icons.arrow_drop_down_sharp,
                color: Colors.black,
              ),
              border: OutlineInputBorder(),
            ),
          ),



          const SizedBox(height: 20),

          /// CLIENT
          const Text("Client"),
          const SizedBox(height: 8),
          Obx(() {
            if (controller.isLoadingClients.value) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              );
            }

            return DropdownButtonFormField<int>(
              value: controller.selectedClientId.value,
              items: [
                const DropdownMenuItem<int>(
                  value: null,
                  child: Text("All Clients"),
                ),
                ...controller.clients.map(
                  (client) => DropdownMenuItem<int>(
                    value: client.clientId,
                    child: Text(client.name),
                  ),
                ),
              ],
              onChanged: (value) {
                controller.selectedClientId.value = value;
              },
              decoration: const InputDecoration(
                hintText: "Select client",
                border: OutlineInputBorder(),
              ),
            );
          }),
          const SizedBox(height: 20),

          /// CATEGORY
          const Text("Category"),
          const SizedBox(height: 8),
          Obx(
                () => DropdownButtonFormField<String>(
              value: controller.selectedCategory.value.isEmpty
                  ? null
                  : controller.selectedCategory.value,
              items: const [
                DropdownMenuItem(value: "Food", child: Text("Food")),
                DropdownMenuItem(value: "Travel", child: Text("Travel")),
                DropdownMenuItem(value: "Office", child: Text("Office")),
              ],
              onChanged: (value) {
                controller.selectedCategory.value = value ?? '';
              },
              decoration: const InputDecoration(
                hintText: "Select category",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),


          /// PAID BY CASH
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Paid by Cash"),
                Switch(
                  value: controller.paidByCash.value,
                  onChanged: (value) {
                    controller.paidByCash.value = value;
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          /// BUTTONS
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: controller.resetFilter,
                  child: const Text("Reset"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: controller.applyFilter,
                  child: const Text("Apply"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
