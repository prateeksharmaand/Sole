import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/common/widgets/app_btn/app_btn.dart';
import 'package:sole/features/dashboard/controllers/add_expenses_controller.dart';
import 'package:sole/features/dashboard/pages/subscriptions/subscriptions_screen.dart';
import 'package:sole/routes/routes.dart';
import 'package:sole/utils/constants/images.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class DetailsExpensesScreen extends GetView<AddExpensesController> {
  const DetailsExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UColors.bg,
      appBar: UAppBar(
        backgroundColor: UColors.bg,
        centerTitle: true,
        showBackArrow: true,
        showDivider: false,
        title: Text(
          "Details Expense",
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: UColors.textPrimary,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(USizes.defaultSpace20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// header Container Data
              Container(
                height: 184,
                width: double.infinity,
                padding: EdgeInsets.all(USizes.md),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: UColors.borderBtn),
                  color: UColors.bgContainerF8FA
                ),
                child: Image.asset("assets/images/document.png"),
              ),
              SizedBox(height: USizes.defaultSpace20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(USizes.md),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    CommonTextSubText(
                      text: "Description",
                      subText: "Monthly Canva Subscription",
                    ),
                    CommonTextSubText(text: "Date", subText: "10 Sep 2025"),
                    Divider(color: UColors.divider),
                    CommonTextSubText(text: "Suplier", subText: "Canva Pty Ltd"),
                    CommonTextSubText(text: "Category", subText: "Software"),
                    Divider(color: UColors.divider),
                    CommonTextSubText(text: "Price", subText: "19"),
                    CommonTextSubText(text: "Subtotal", subText: "\$36"),
                    CommonTextSubText(text: "GST", subText: "\$4"),
                    CommonTextSubText(text: "Pay With Cash", subText: "No"),
                  ],
                ),
              ),
              SizedBox(height: USizes.defaultSpace20),
              Row(
                children: [
                  Expanded(
                    child: CommonIconText(
                      icon: UImages.fileCopyIcon,
                      text: 'Duplicate',
                      onTap: (){
                        Get.dialog(
                           UDialogDetails(text: "Duplicate Expense?", subText: "A new expense will be created with the same details. ", btnName: "Duplicate", onTap: (){}, btnColor: UColors.primary),
                          barrierDismissible: false,
                        );
                      },
                    ),
                  ),
                  SizedBox(width: USizes.sm),
                  Expanded(
                    child: CommonIconText(
                      icon: UImages.editIcon,
                      text: 'Edit',
                      onTap: () {
                        Get.toNamed(URoutes.addExpensesScreen);
                      },
                    ),
                  ),
                  SizedBox(width: USizes.sm),
                  Expanded(
                    child: CommonIconText(
                      icon: UImages.deleteIcon,
                      text: 'Delete',
                      onTap: () {
                        Get.dialog(
                           UDialogDetails(text: "Remove Expense?", subText: 'This expense is already reconciled, are you sure you want to delete the expense and undo the reconciliation?', btnName: "Remove", onTap: (){}, btnColor: UColors.red4954),
                          barrierDismissible: false,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommonIconText extends StatelessWidget {
  final String icon;
  final String text;
  final GestureTapCallback onTap;
  const CommonIconText({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: UColors.borderBtn),
          color: UColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(icon),
            SizedBox(width: USizes.sm),
            Text(
              text,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: UColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UDialogDetails extends StatelessWidget {
  final String text;
  final String subText;
  final String btnName;
  final Function() onTap;
  final Color btnColor;
  const UDialogDetails({super.key, required this.text, required this.subText, required this.btnName, required this.onTap, required this.btnColor});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: UColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: USizes.md,right: USizes.md,top: USizes.defaultSpace20),
            child: Column(
              children: [
                /// Title
                Text(
                  text,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 12),

                /// Description
                Text(
                  subText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: UColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),


          const SizedBox(height: 12),
          Divider(color: UColors.divider),
          const SizedBox(height: 12),

          /// Buttons
          Padding(
            padding: const EdgeInsets.only(left: USizes.md,right: USizes.md,bottom: USizes.defaultSpace20),
            child: Row(
              children: [
                /// Cancel
                Expanded(child: UButton(
                  label: "Cancel",
                  textColor: UColors.textSecondary,
                  borderColor: UColors.borderBtn,
                  bgColor: UColors.white,
                  onPressed: (){
                    Get.back();
                  },
                )),

                const SizedBox(width: 12),

                /// Remove
                Expanded(
                  child: UButton(
                    label: btnName,
                    onPressed: onTap,
                    bgColor: btnColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

