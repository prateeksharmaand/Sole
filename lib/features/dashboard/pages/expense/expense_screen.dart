import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/images.dart';
import 'package:sole/utils/constants/sizes.dart';
import 'package:sole/utils/helpers/device_helpers.dart';
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
                      padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: UColors.borderBtn),
                        color: Colors.white,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.selectedMonth.value,
                          icon: const Icon(Icons.keyboard_arrow_down,color: UColors.textSecondary),
                          items: controller.months.map((month) {
                            return DropdownMenuItem<String>(
                              value: month,
                              child: Text(
                                month,
                                style:  GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: UColors.textSecondary
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
                  CommonTextPrizePercent(text: 'Total Expenses', prize: '\$512k', percent: '+2.5%', isProfit: true),
                  SizedBox(height: USizes.md),
                  Divider(color: UColors.divider),
                  SizedBox(height: USizes.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CommonTextPrizePercent(text: 'Reconciled Expenses', prize: '\$2,932', percent: '+2.5%', isProfit: true),
                      CommonTextPrizePercent(text: 'Pending Expenses', prize: '\$2,932', percent: '-8.5%', isProfit: false)
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: USizes.defaultSpace20),
            /// search and filter
            Row(
              children: [
                UCommonSearch(),
                SizedBox(width: USizes.sm),
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(UImages.filterIcon),
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
                child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: USizes.lg),
                      child: Row(
                        children: [
                          SvgPicture.asset(UImages.assetsListIcon),
                          SizedBox(width: USizes.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Accountancy Expenses",
                                  style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: UColors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: USizes.xs),
                                Row(
                                  children: [
                                    Text(
                                      "Bunnings",
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
                                        color: UColors.textSecondary.withValues(
                                          alpha: .3,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "2 Days ago",
                                      style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
                                        color: UColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: USizes.md),
                          Text(
                            "\$10.22",
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
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
    super.key, required this.text, required this.prize, required this.percent, required this.isProfit,
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
              padding: EdgeInsets.symmetric(horizontal:USizes.xs,vertical: USizes.xs/2),
              decoration: BoxDecoration(
                color: isProfit ? UColors.greenFBF5 : UColors.redEBEC,
                borderRadius: BorderRadius.circular(4)
              ),
              child: Text(
                  percent,
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 11,
                    color: isProfit ? UColors.green7F67 : UColors.red3137,
                  ))
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
        )
      ],
    );
  }
}
