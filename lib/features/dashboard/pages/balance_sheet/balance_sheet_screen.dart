import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/features/dashboard/pages/balance_sheet/cash_screen.dart';
import 'package:sole/utils/constants/images.dart';
import '../../../../common/widgets/app_btn/app_btn.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/device_helpers.dart';
import '../../controllers/balance_sheet_controller.dart';
import '../audit_trail/audit_trail_screen.dart';
import '../cash_flow/cash_flow_screen.dart';

class BalanceSheetScreen extends GetView<BalanceSheetController> {
  const BalanceSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        centerTitle: true,
        showBackArrow: true,
        showDivider: false,
        title: Text(
          "Balance Sheet",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: UColors.textPrimary,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: USizes.defaultSpace20,
          right: USizes.defaultSpace20,
          top: USizes.defaultSpace20,
          bottom: UDeviceHelper.getBottomNavigationBarHeight() + 50,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Info Box
              CommonInfoContainer(
                text:
                    "Snapshot of what your business owns or is due to receive from others (assets), what it owes to others (liabilities), and what you've invested or retained in your business (equity).",
              ),

              SizedBox(height: USizes.lg),
              YearDropdown(),
              SizedBox(height: USizes.lg),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: UColors.borderBtn),
                ),
                child: Column(
                  children: [
                    CommonHeadingValue(
                      heading: 'Total Income',
                      value: "-\$327.00",
                    ),
                    Divider(color: UColors.divider),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CommonHeadingValue(
                          heading: 'Liabilities',
                          value: "-\$65.30",
                        ),
                        Container(height: 50, width: 2, color: UColors.divider),
                        CommonHeadingValue(
                          heading: 'Net Position',
                          value: "-\$261.70",
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: USizes.lg),

              Obx(
                () => Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => CashScreen());
                      },
                      child: BalanceSectionCard(
                        title: "Assets",
                        expanded: controller.assetsOpen.value,
                        onToggle: () => controller.assetsOpen.toggle(),
                        items: controller.assets,
                        totalLabel: "Total Assets",
                        totalValue: controller.totalAssets,
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Get.to(() => CashScreen());
                      },
                      child: BalanceSectionCard(
                        title: "Liabilities",
                        expanded: controller.liabilitiesOpen.value,
                        onToggle: () => controller.liabilitiesOpen.toggle(),
                        items: controller.liabilities,
                        totalLabel: "Total Liabilities",
                        totalValue: controller.totalLiabilities,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: USizes.md),

              /// List Area
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.only(
          bottom: UDeviceHelper.getBottomNavigationBarHeight() / 2,
          left: USizes.defaultSpace20,
          right: USizes.defaultSpace20,
        ),
        child: Row(
          children: [
            Expanded(
              child: UButton(
                onPressed: () {},
                bgColor: UColors.white,
                borderColor: UColors.primary,
                label: "Download",
                textColor: UColors.primary,
              ),
            ),
            SizedBox(width: USizes.sm * 1.5),
            Expanded(
              child: UButton(onPressed: () {}, label: "Send Report"),
            ),
          ],
        ),
      ),
    );
  }
}

class BalanceSectionCard extends StatelessWidget {
  final String title;
  final bool expanded;
  final VoidCallback onToggle;
  final List<BalanceItem> items;
  final String totalLabel;
  final String totalValue;

  const BalanceSectionCard({
    super.key,
    required this.title,
    required this.expanded,
    required this.onToggle,
    required this.items,
    required this.totalLabel,
    required this.totalValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: UColors.borderBtn),
        color: Colors.white,
      ),
      child: Column(
        children: [
          /// header row
          GestureDetector(
            onTap: onToggle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: UColors.black,
                  ),
                ),
                Icon(
                  expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
              ],
            ),
          ),

          if (expanded) const SizedBox(height: 12),

          /// list items
          if (expanded)
            Column(
              children: List.generate(items.length, (index) {
                final item = items[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: UColors.whiteF9F9,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// title + amount
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: UColors.text5866,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item.amount,
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: UColors.textPrimary,
                            ),
                          ),
                        ],
                      ),

                      /// icon button
                      SvgPicture.asset(UImages.fileIcon),
                    ],
                  ),
                );
              }),
            ),

          /// total row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                totalLabel.toUpperCase(),
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: UColors.text5866,
                ),
              ),
              Text(
                totalValue,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: UColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BalanceItem {
  final String title;
  final String amount;

  const BalanceItem({required this.title, required this.amount});
}

class YearDropdown extends GetView<BalanceSheetController> {
  const YearDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: UColors.borderBtn),
          color: Colors.white,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: controller.selectedYear.value,
            icon: const Icon(Icons.keyboard_arrow_down),
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: UColors.textPrimary,
            ),
            items: controller.years.map((value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            onChanged: (val) {
              if (val != null) controller.changeYear(val);
            },
          ),
        ),
      ),
    );
  }
}
