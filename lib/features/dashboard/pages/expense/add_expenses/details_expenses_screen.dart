import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/common/widgets/app_btn/app_btn.dart';
import 'package:sole/features/dashboard/controllers/expense_details_controller.dart';
import 'package:sole/features/dashboard/pages/subscriptions/subscriptions_screen.dart';
import 'package:sole/routes/routes.dart';
import 'package:sole/utils/constants/images.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import 'package:intl/intl.dart';

class DetailsExpensesScreen extends StatelessWidget {
  const DetailsExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller with Get.put to ensure it's created
    final controller = Get.put(ExpenseDetailsController());

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
      body: Obx(() {
        // Loading state
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: UColors.primary),
          );
        }

        // No data state
        if (controller.expense.value == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: UColors.textSecondary,
                ),
                SizedBox(height: USizes.md),
                Text(
                  'Expense not found',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: UColors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        }

        final expense = controller.expense.value!;

        return Padding(
          padding: EdgeInsets.all(USizes.defaultSpace20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// header Container Data - Receipt Image
                Container(
                  height: 184,
                  width: double.infinity,
                  padding: EdgeInsets.all(USizes.md),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: UColors.borderBtn),
                    color: UColors.bgContainerF8FA,
                  ),
                  child: expense.image != null && expense.image!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            expense.image!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset("assets/images/document.png"),
                          ),
                        )
                      : Image.asset("assets/images/document.png"),
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
                      CommonTextSubText(text: "Name", subText: expense.name),
                      CommonTextSubText(
                        text: "Description",
                        subText: expense.description.isNotEmpty
                            ? expense.description
                            : "No description",
                      ),
                      CommonTextSubText(
                        text: "Date",
                        subText: _formatDate(expense.date),
                      ),
                      Divider(color: UColors.divider),
                      CommonTextSubText(
                        text: "Client",
                        subText: expense.client.name,
                      ),
                      if (expense.accountSubcategory != null)
                        CommonTextSubText(
                          text: "Category",
                          subText: expense.accountSubcategory!.name,
                        ),
                      Divider(color: UColors.divider),
                      CommonTextSubText(
                        text: "Price",
                        subText: "\$${expense.price}",
                      ),
                      CommonTextSubText(
                        text: "Subtotal",
                        subText: "\$${expense.subTotal}",
                      ),
                      CommonTextSubText(
                        text: "GST",
                        subText: "\$${expense.totalGst}",
                      ),
                      CommonTextSubText(
                        text: "Pay With Cash",
                        subText: expense.paidWithCash == 1 ? "Yes" : "No",
                      ),
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
                        onTap: () {
                          Get.dialog(
                            UDialogDetails(
                              text: "Duplicate Expense?",
                              subText:
                                  "A new expense will be created with the same details. ",
                              btnName: "Duplicate",
                              onTap: () {},
                              btnColor: UColors.primary,
                            ),
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
                          // Navigate to add expenses screen with expense data for editing
                          Get.toNamed(
                            URoutes.addExpensesScreen,
                            arguments: expense,
                          );
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
                            UDialogDetails(
                              text: "Remove Expense?",
                              subText:
                                  'This expense is already reconciled, are you sure you want to delete the expense and undo the reconciliation?',
                              btnName: "Remove",
                              onTap: () {},
                              btnColor: UColors.red4954,
                            ),
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
        );
      }),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
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
  const UDialogDetails({
    super.key,
    required this.text,
    required this.subText,
    required this.btnName,
    required this.onTap,
    required this.btnColor,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: UColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: USizes.md,
              right: USizes.md,
              top: USizes.defaultSpace20,
            ),
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
            padding: const EdgeInsets.only(
              left: USizes.md,
              right: USizes.md,
              bottom: USizes.defaultSpace20,
            ),
            child: Row(
              children: [
                /// Cancel
                Expanded(
                  child: UButton(
                    label: "Cancel",
                    textColor: UColors.textSecondary,
                    borderColor: UColors.borderBtn,
                    bgColor: UColors.white,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),

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
