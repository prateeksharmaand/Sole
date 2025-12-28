import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../common/widgets/app_btn/app_btn.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/images.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/device_helpers.dart';
import '../assets/assets_screen.dart';
import '../audit_trail/audit_trail_screen.dart';
import '../bas_reports/transaction_details.dart';

/// ================= CONTROLLER =================

class TransactionListingController extends GetxController {
  /// Main tabs (Transfer, Claims, ...)
  final selectedTab = 0.obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }
}

class TransactionListingScreen extends GetView<TransactionListingController> {
  const TransactionListingScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        centerTitle: true,
        showBackArrow: true,
        showDivider: false,
        title: Text(
          "Transaction Listing",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: UColors.textPrimary,
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// INFO BOX
            CommonInfoContainer(text: 'Shows details about your business and personal transactions, including description, amount, date, category, and more.'),

            SizedBox(height: USizes.lg),
          Row(
            children: [
              UCommonSearch(hint: "Search transaction"),
              SizedBox(width: USizes.sm),
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(UImages.filterIcon, height: 46),
              )

            ],
          ),

            SizedBox(height: USizes.lg),

            /// 🔥 MAIN CUSTOM TABS
            CustomNumberTabs(),

            const SizedBox(height: 20),

            /// 🔹 MAIN TAB CONTENT
            Expanded(
              child: Obx(() {
                switch (controller.selectedTab.value) {
                  case 0:
                    return Transaction();
                  case 1:
                    return Transaction();
                  case 2:
                    return Transaction();
                  case 3:
                    return Transaction();
                  default:
                    return const SizedBox();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= MAIN TABS =================

class CustomNumberTabs extends GetView<TransactionListingController> {
  CustomNumberTabs({super.key});

  // final ReportingController controller = Get.find();

  final List<String> tabs = [
    'All',
    'Invoices',
    'Assets',
    'Transactions'
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(tabs.length, (index) {
            final isSelected = controller.selectedTab.value == index;
            return GestureDetector(
              onTap: () => controller.changeTab(index),
              child: Container(
                margin: EdgeInsets.only(right: USizes.sm),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99),
                  color: isSelected ? UColors.secondary : UColors.white,
                  border: Border.all(
                    color: isSelected ? UColors.secondary : UColors.borderBtn,
                  ),
                ),
                child: Text(
                  tabs[index],
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? UColors.white : UColors.textSecondary,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class Transaction extends StatelessWidget {
  const Transaction({super.key});

  @override
  Widget build(BuildContext context) {
    return
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
                    Get.to(() => TransactionDetails());
                  },

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// Leading Icon box
                      SvgPicture.asset(UImages.basIcon),

                      SizedBox(width: 12),

                      /// Middle text section
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Date
                            Text(
                              "INV-82",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: UColors.textPrimary,
                              ),
                            ),

                            SizedBox(height: 4),

                            /// Subtitle row
                            Row(
                              children: [
                                Text(
                                  "Supplier Name",
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
                                  "16/12/2025",
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
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );
  }
}

