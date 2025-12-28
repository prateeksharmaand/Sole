import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/features/dashboard/pages/customers_suppliers/widgets/all_contacts.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/sizes.dart';
import '../../../../common/widgets/app_btn/app_btn.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/drop_down/common_year_dropdown.dart';
import '../../../../utils/constants/images.dart';
import '../../../../utils/helpers/device_helpers.dart';
import '../assets/assets_screen.dart';
import '../audit_trail/audit_trail_screen.dart';

/// ================= CONTROLLER =================

class CustomersSuppliersController extends GetxController {
  /// Main tabs (Transfer, Claims, ...)
  final selectedTab = 0.obs;

  /// Transfer sub tabs (All, Client, Supplier)
  final selectedTab1 = 0.obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void changeTab1(int index) {
    selectedTab1.value = index;
  }

  final selectedYear = "2025-2026".obs;
  final selectedMonths = "March 2025".obs;
  final years = ["2023-2024", "2024-2025", "2025-2026", "2026-2027"];
  final months = ["March 2025", "April 2025", "May 2025", "June 2025"];

}

/// ================= MAIN SCREEN =================

class CustomersSuppliersScreen extends GetView<CustomersSuppliersController> {
  const CustomersSuppliersScreen({super.key});

  // final CustomersSuppliersController controller = Get.put(ReportingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        centerTitle: true,
        showBackArrow: true,
        showDivider: false,
        title: Text(
          "Customers / Suppliers",
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
            CommonInfoContainer(text: 'Enter Your Own code to allow you to'),

            const SizedBox(height: 20),
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
            const SizedBox(height: 20),

            /// 🔥 MAIN CUSTOM TABS
            CustomNumberTabs(),

            const SizedBox(height: 20),

            /// 🔹 MAIN TAB CONTENT
            Expanded(
              child: Obx(() {
                switch (controller.selectedTab.value) {
                  case 0:
                    return TransferSection();
                  case 1:
                    return const Center(child: Text("Claims Content"));
                  case 2:
                    return const Center(child: Text("Record Content"));
                  case 3:
                    return const Center(child: Text("Account Content"));
                  case 4:
                    return const Center(child: Text("Offer Content"));
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

class CustomNumberTabs extends GetView<CustomersSuppliersController> {
  CustomNumberTabs({super.key});

  // final ReportingController controller = Get.find();

  final List<String> tabs = [
    'Contacts',
    'Invoices',
    'Quotes',
    'Expenses',
    'Offer',
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
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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

/// ================= TRANSFER SECTION =================

class TransferSection extends GetView<CustomersSuppliersController> {
  TransferSection({super.key});

  // final ReportingController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            UCommonSearch(hint: "Search  assets"),
            SizedBox(width: USizes.sm),
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(UImages.filterIcon, height: 46),
            ),
            SizedBox(width: USizes.sm),
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(UImages.downloadIcon, height: 46),
            ),
          ],
        ),

        const SizedBox(height: 20),

        /// 🔥 TRANSFER SUB TABS
        TransferTab(),

        const SizedBox(height: 20),

        /// 🔹 TRANSFER BODY
        Expanded(
          child: Obx(() {
            switch (controller.selectedTab1.value) {
              case 0:
                return AllContactsScreen();
              case 1:
                return AllContactsScreen();
              case 2:
                return AllContactsScreen();
              default:
                return const SizedBox();
            }
          }),
        ),
      ],
    );
  }
}

/// ================= TRANSFER SUB TABS =================

class TransferTab extends GetView<CustomersSuppliersController> {
  TransferTab({super.key});

  final List<String> tabs = ["All", "Client", "Supplier"];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 44,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xffF2F4F7), // light grey background
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: List.generate(tabs.length, (index) {
            final isSelected = controller.selectedTab1.value == index;

            return Expanded(
              child: GestureDetector(
                onTap: () => controller.changeTab1(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: isSelected ? Colors.black : UColors.textSecondary,
                    ),
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
