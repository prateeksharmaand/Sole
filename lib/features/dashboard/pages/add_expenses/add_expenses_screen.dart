import 'package:flutter/material.dart';
import 'package:flutter_dotted_border/flutter_dotted_border.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/common/widgets/appbar/appbar.dart';
import 'package:sole/routes/routes.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/helpers/device_helpers.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../common/widgets/app_btn/app_btn.dart';
import '../../../../common/widgets/drop_down/u_drop_down_underLine.dart';
import '../../../../common/widgets/switch_btn/switch_btn.dart';
import '../../../../common/widgets/textfields/app_text_fields.dart';
import '../../../../utils/constants/images.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/add_expenses_controller.dart';

class AddExpensesScreen extends GetView<AddExpensesController> {
  const AddExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        centerTitle: true,
        showBackArrow: true,
        showDivider: false,
        title: Text(
          "Add Expanse",
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: UColors.textPrimary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(USizes.defaultSpace20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReceiptUploadBox(),
              SizedBox(height: USizes.lg),
              UTextField2(
                hintText: "Write descriptions...",
                titleText: "Expense Description",
              ),
              SizedBox(height: USizes.xl),
              Row(
                children: [
                  Expanded(
                    child: UTextField2(
                      hintText: "Enter price",
                      titleText: "Price*",
                      prefixWidget: SvgPicture.asset(UImages.rupeeIcon),
                      suffix: Icon(Icons.keyboard_arrow_down_outlined),
                    ),
                  ),
                  SizedBox(width: USizes.md),

                  Expanded(
                    child: Obx(
                      () => UTextField2(
                        titleText: "Date*",
                        hintText: "Enter date",
                        controller: TextEditingController(
                          text: controller.formattedDate,
                        ),
                        isReadOnly: true,
                        suffix: const Icon(Icons.keyboard_arrow_down_outlined),
                        onTap: () {
                          showDatePickerBottomSheet(controller);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: USizes.lg),
              Obx(
                () => UDropDown<String>(
                  label: "Supplier",
                  hint: "Select suplier",
                  value: controller.selectedReport.value,
                  items: controller.reports
                      .map(
                        (e) =>
                            DropdownMenuItem<String>(value: e, child: Text(e)),
                      )
                      .toList(),
                  onChanged: (value) {
                    controller.selectedReport.value = value;
                  },
                ),
              ),
              SizedBox(height: USizes.lg),
              Obx(
                () => UDropDown<String>(
                  label: "Category",
                  hint: "Select category",
                  value: controller.selectedCategory.value,
                  items: controller.categoryList
                      .map(
                        (e) =>
                            DropdownMenuItem<String>(value: e, child: Text(e)),
                      )
                      .toList(),
                  onChanged: (value) {
                    controller.selectedCategory.value = value;
                  },
                ),
              ),
              SizedBox(height: USizes.lg),

              /// 🔹 Checkbox Row
              Obx(
                () => Row(
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Checkbox(
                        value: controller.isPaidWithCash.value,
                        onChanged: (value) {
                          controller.isPaidWithCash.value = value ?? false;
                        },
                      ),
                    ),
                    SizedBox(width: USizes.md),
                    Text(
                      "Paid with cash?",
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: UColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: USizes.md),

              /// 🔹 Switch Row
              Obx(
                () => Row(
                  children: [
                    SizedBox(
                      height: 30,
                      width: 40,
                      child: USwitch(
                        value: controller.isGstIncluded.value,
                        onChanged: (value) {
                          controller.isGstIncluded.value = value;
                        },
                      ),
                    ),
                    SizedBox(width: USizes.md),
                    Text(
                      "Include GST (10%)",
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: UColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: USizes.lg),
              UButton(
                label: "Save",
                onPressed: () {
                  Get.toNamed(URoutes.detailsExpensesScreen);
                },
              ),
              SizedBox(height: UDeviceHelper.getBottomNavigationBarHeight()),
            ],
          ),
        ),
      ),
    );
  }

  void showDatePickerBottomSheet(AddExpensesController controller) {
    Get.bottomSheet(
      DatePickerSheet(controller: controller),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}

class DatePickerSheet extends StatelessWidget {
  final AddExpensesController controller;
  const DatePickerSheet({super.key, required this.controller});

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
                "Select Date",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: UColors.textPrimary,
                ),
              ),
              InkWell(
                onTap: () => Get.back(),
                child: const Icon(Icons.close, color: UColors.textSecondary),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Calendar
          Obx(
            () => TableCalendar(
              focusedDay: controller.selectedDate.value ?? DateTime.now(),
              firstDay: DateTime(2000),
              lastDay: DateTime(2100),
              calendarFormat: CalendarFormat.month,

              /// HEADER CUSTOMIZATION
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,

                /// Header height control
                headerPadding: const EdgeInsets.symmetric(vertical: 8),
                headerMargin: const EdgeInsets.only(bottom: 10, top: 10),

                decoration: BoxDecoration(
                  color: UColors.bgContainerF8FA,
                  borderRadius: BorderRadius.circular(8),
                ),

                /// Custom icons
                leftChevronIcon: SvgPicture.asset(
                  UImages.arrowLeftIconTable,
                  width: 40,
                  height: 40,
                ),
                rightChevronIcon: SvgPicture.asset(
                  UImages.arrowRightIconTable,
                  width: 40,
                  height: 40,
                ),

                titleTextStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: UColors.textPrimary,
                ),
              ),

              selectedDayPredicate: (day) {
                return isSameDay(controller.selectedDate.value, day);
              },

              onDaySelected: (selectedDay, focusedDay) {
                controller.selectedDate.value = selectedDay;
              },
            ),
          ),

          const SizedBox(height: 20),

          /// Save Button
          UButton(
            label: "Save",
            onPressed: () {
              Get.back();
            },
          ),
          // SizedBox(
          //   width: double.infinity,
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       padding: const EdgeInsets.symmetric(vertical: 14),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(12),
          //       ),
          //     ),
          //     onPressed: () {
          //       Get.back();
          //     },
          //     child: const Text("Save"),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class ReceiptUploadBox extends GetView<AddExpensesController> {
  const ReceiptUploadBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Column(
        children: [

          /// IF IMAGE SELECTED
          if (controller.selectedImage.value != null)
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    controller.selectedImage.value!,
                    height: 185,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                /// CLEAR BUTTON (TOP RIGHT)
                Positioned(
                  top: 6,
                  right: 6,
                  child: GestureDetector(
                    onTap: controller.clearImage,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            )

          /// ELSE SHOW DOTTED BOX
          else
            GestureDetector(
              onTap: controller.pickFromGallery,
              child: DottedBorder(
                borderType: RoundedRectDottedBorder(
                  color: UColors.borderB3FF,
                  dashGap: 4,
                  dashWidth: 4,
                  strokeWidth: 2,
                  radius: const Radius.circular(12),
                ),
                child: SizedBox(
                  height: 185,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add),
                      SizedBox(height: USizes.defaultSpace20),
                      Text(
                        "Add a Photo or Receipt",
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: UColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: USizes.defaultSpace20),
                      SizedBox(
                        height: 38,
                        width: 130,
                        child: UButton(
                          onPressed: controller.pickFromGallery,
                          label: "Browse File",
                          textColor: UColors.primary,
                          borderColor: UColors.primary,
                          bgColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          SizedBox(height: USizes.lg),

          /// CAMERA BUTTON
          GestureDetector(
            onTap: controller.pickFromCamera,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: USizes.md,
                vertical: USizes.md,
              ),
              decoration: BoxDecoration(
                color: UColors.primaryLightE0FF,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt, color: UColors.primary),
                  SizedBox(width: USizes.md),
                  Text(
                    "Open Camera & Take photos",
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: UColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

