import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/features/dashboard/pages/bas_reports/transaction_details.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/sizes.dart';
import '../../../../common/widgets/app_btn/app_btn.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/images.dart';
import '../../../../utils/helpers/device_helpers.dart';
import '../audit_trail/audit_trail_screen.dart';
import '../cash_flow/cash_flow_screen.dart';

/// ================= CONTROLLER =================

class BasReportsController extends GetxController {
  /// Main tabs (Transfer, Claims, ...)
  final selectedTab = 0.obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }
}

/// ================= MAIN SCREEN =================

class BasReportsScreen extends GetView<BasReportsController> {
  const BasReportsScreen({super.key});

  // final CustomersSuppliersController controller = Get.put(ReportingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        centerTitle: true,
        showBackArrow: true,
        showDivider: false,
        title: Text(
          "BAS Report",
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
            CommonInfoContainer(text: 'Details of BAS Report'),

            SizedBox(height: USizes.lg),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: UColors.borderBtn),
              ),
              child: Column(
                children: [
                  CommonHeadingValue(heading: 'GST on Sales', value: "\$0.00"),
                  Divider(color: UColors.divider),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CommonHeadingValue(
                        heading: 'GST on Purchases',
                        value: "\$0.00",
                      ),
                      Container(height: 50, width: 2, color: UColors.divider),
                      CommonHeadingValue(heading: 'Net GST', value: "\$0.00"),
                    ],
                  ),
                ],
              ),
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
                    return const Center(child: Text("Claims Content"));
                  case 2:
                    return QuarterTab();
                  case 3:
                    return QuarterTab();
                  case 4:
                    return QuarterTab();
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

class CustomNumberTabs extends GetView<BasReportsController> {
  CustomNumberTabs({super.key});

  // final ReportingController controller = Get.find();

  final List<String> tabs = [
    'Transactions',
    'Quarter 1',
    'Quarter 2',
    'Quarter 3',
    'Quarter 4',
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

class QuarterTab extends StatelessWidget {
  const QuarterTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: UDeviceHelper.getBottomNavigationBarHeight() + 40,
        ),
        child: Column(
          children: const [
            GstSectionCard(
              title: "GST amounts you owe the tax office (Sales)",
              items: [
                GstItem(
                  title: "Total Sales (Incl. GST)",
                  code: "G1",
                  amount: "\$0.00",
                ),
                GstItem(
                  title: "GST Free Sales",
                  code: "G1",
                  amount: "\$941.82",
                ),
                GstItem(
                  title: "Total Sales Applicable",
                  code: "G1",
                  amount: "\$941.82",
                ),
                GstItem(title: "GST On Sales", code: "G1", amount: "\$941.82"),
              ],
            ),

            SizedBox(height: 16),

            GstSectionCard(
              title: "GST amounts tax office owes you (Purchases)",
              items: [
                GstItem(
                  title: "Total Purchases",
                  code: "G11",
                  amount: "\$0.00",
                ),
                GstItem(
                  title: "Capital Purchases",
                  code: "G10",
                  amount: "\$0.00",
                ),
                GstItem(
                  title: "GST on Purchases",
                  code: "G10",
                  amount: "\$0.00",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GstSectionCard extends StatefulWidget {
  final String title;
  final List<GstItem> items;

  const GstSectionCard({super.key, required this.title, required this.items});

  @override
  State<GstSectionCard> createState() => _GstSectionCardState();
}

class _GstSectionCardState extends State<GstSectionCard> {
  bool expanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: UColors.borderBtn),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => expanded = !expanded),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: UColors.black,
                  ),
                ),
                Icon(
                  expanded
                      ? Icons.arrow_drop_up_sharp
                      : Icons.arrow_drop_down_sharp,
                ),
              ],
            ),
          ),

          if (expanded) const SizedBox(height: 10),

          if (expanded)
            Column(
              children: List.generate(widget.items.length, (index) {
                final item = widget.items[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: UColors.bg,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// title
                      Text(
                        item.title,
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w500,
                          color: UColors.text5866,
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// Code row
                      Row(
                        children: [
                          Text(
                            "Code:",
                            style: GoogleFonts.plusJakartaSans(
                              color: UColors.text5866,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 60),
                          Text(
                            item.code,
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: UColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      /// Amount row
                      Row(
                        children: [
                          Text(
                            "Amount:",
                            style: GoogleFonts.plusJakartaSans(
                              color: UColors.text5866,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 60),
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
                    ],
                  ),
                );
              }),
            ),
        ],
      ),
    );
  }
}

class GstItem {
  final String title;
  final String code;
  final String amount;

  const GstItem({
    required this.title,
    required this.code,
    required this.amount,
  });
}
