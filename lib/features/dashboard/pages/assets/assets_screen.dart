import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/features/dashboard/pages/taxes_bankings/taxes_banking_screen.dart';
import 'package:sole/routes/app_routes.dart';
import 'package:sole/routes/routes.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/textfields/app_text_fields.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/images.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/assets_controller.dart';

class AssetsScreen extends GetView<AssetsController> {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UColors.bg,
      appBar: const UAppBar(
        title: Text("Assets"),
        showDivider: false,
        showBackArrow: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: UColors.primary,
        shape: const CircleBorder(),
        onPressed: () {
          Get.toNamed(URoutes.newAssetsScreen);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: USizes.defaultSpace20,
          right: USizes.defaultSpace20,
          top: USizes.defaultSpace20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                UCommonSearch(hint: "Search  assets"),
                SizedBox(width: USizes.sm),
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(UImages.filterIcon),
                ),
                SizedBox(width: USizes.sm),
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(UImages.downloadIcon),
                ),
              ],
            ),
            SizedBox(height: USizes.lg),
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
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: USizes.lg),
                      child: Row(
                        children: [
                          SvgPicture.asset(UImages.expensesIcon),
                          SizedBox(width: USizes.md),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ergonomic Office Chairs",
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: UColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: USizes.xs),
                              Row(
                                children: [
                                  Text(
                                    "\$1,100.00",
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
                                    "04-09-2025",
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

class UCommonSearch extends StatelessWidget {
  final String? hint;
  const UCommonSearch({super.key, this.hint});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: UTextField(
        hintText: hint ?? "Search...",
        prefixWidget: Padding(
          padding: EdgeInsets.only(left: USizes.sm),
          child: Icon(Icons.search),
        ),
      ),
    );
  }
}

class AddExpenseBottomSheet extends StatelessWidget {
  const AddExpenseBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add Expenses',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: UColors.textPrimary,
                ),
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, color: UColors.textSecondary),
              ),
            ],
          ),

          const SizedBox(height: 20),

          _optionTile(
            icon: UImages.manualIcon,
            title: 'Manual',
            subtitle: 'Fill out the expense form manually',
            onTap: () {
              Get.toNamed(URoutes.addExpensesScreen);
            },
          ),

          const SizedBox(height: 16),

          _optionTile(
            icon: UImages.uploadReceiptIcon,
            title: 'Upload Receipt',
            subtitle: 'Upload receipt image and auto-extract data',
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  /// Reusable Tile
  Widget _optionTile({
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: UColors.borderBtn),
        ),
        child: Row(
          children: [
            /// Icon
            SvgPicture.asset(icon),

            const SizedBox(width: 16),

            /// Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: UColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: UColors.textSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            /// Arrow
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: UColors.textSecondary,
              size: 19,
            ),
          ],
        ),
      ),
    );
  }
}
