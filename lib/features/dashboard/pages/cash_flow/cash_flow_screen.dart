import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/features/dashboard/controllers/cash_flow_controller.dart';
import 'package:sole/utils/constants/images.dart';
import 'package:sole/utils/helpers/device_helpers.dart';
import '../../../../common/widgets/app_btn/app_btn.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/drop_down/common_year_dropdown.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../assets/assets_screen.dart';
import '../audit_trail/audit_trail_screen.dart';
import 'cash_flow_formation_screen.dart';

class CashFlowScreen extends GetView<CashFlowController> {
  const CashFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        centerTitle: true,
        showBackArrow: true,
        showDivider: false,
        title: Text(
          "Cashflow",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: UColors.textPrimary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(USizes.defaultSpace20),
        child: Column(
          children: [
            /// Info Box
            CommonInfoContainer(
              text:
                  'Tracks the movement of money in and out of your business, showing how cash is generated and spent during a specific period. It helps assess your company’s liquidity, operational efficiency, and overall financial health.',
            ),

            SizedBox(height: USizes.lg),
            Row(
              children: [
                Expanded(
                  child: CommonYearDropdown(
                      selectedYear: controller.selectedYear,
                      years: controller.years,
                      onChanged: (value){}),
                ),
                SizedBox(width: USizes.sm),
                Expanded(
                  child: CommonYearDropdown(
                      selectedYear: controller.selectedMonths,
                      years: controller.months,
                      onChanged: (value){}),
                ),
              ],
            ),
            SizedBox(height: USizes.lg),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: UColors.borderBtn),
              ),
              child: Column(
                children: [
                  CommonHeadingValue(heading: 'Net Movement'),
                  Divider(color: UColors.divider),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CommonHeadingValue(heading: 'Total Debit'),
                      Container(height: 50, width: 2, color: UColors.divider),
                      CommonHeadingValue(heading: 'Total Credit'),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: USizes.lg),

            /// Search
            Row(
              children: [
                UCommonSearch(hint: "Search  contacts"),
                SizedBox(width: USizes.sm),
                SvgPicture.asset(UImages.filterIcon, width: 45, height: 48),
              ],
            ),

            SizedBox(height: USizes.md),

            /// List Area
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: UColors.borderBtn),
                ),

                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,

                  child: ListView.separated(
                    padding: EdgeInsets.all(16),
                    itemCount: 6,
                    separatorBuilder: (context, index) => SizedBox(height: 30),

                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => CashFlowFormationScreen());
                        },

                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /// Leading Icon box
                            SvgPicture.asset(UImages.expensesIcon),

                            SizedBox(width: 12),

                            /// Middle text section
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Date
                                  Text(
                                    "21/09/2025",
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: UColors.textPrimary,
                                    ),
                                  ),

                                  SizedBox(height: 4),

                                  /// Subtitle row
                                  Row(
                                    children: [
                                      Text(
                                        "Expense",
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 11,
                                          color: UColors.textSecondary,
                                        ),
                                      ),

                                      SizedBox(width: 6),

                                      Icon(
                                        Icons.circle,
                                        size: 6,
                                        color: UColors.textSecondary,
                                      ),

                                      SizedBox(width: 6),

                                      Text(
                                        "Cash",
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 11,
                                          color: UColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            /// Right Amount
                            Text(
                              "-\$111.00",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: UColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
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

class CommonHeadingValue extends StatelessWidget {
  final String heading;
  final String? value;
  const CommonHeadingValue({super.key, required this.heading, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: USizes.md),
      child: Column(
        children: [
          Text(
            heading,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: UColors.textSecondary,
            ),
          ),
          Text(
            value ?? "\$1,221.00",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: UColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
