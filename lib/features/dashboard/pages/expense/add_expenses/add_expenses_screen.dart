import 'package:flutter/material.dart';
import 'package:flutter_dotted_border/flutter_dotted_border.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/common/widgets/appbar/appbar.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/helpers/device_helpers.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../common/widgets/app_btn/app_btn.dart';
import '../../../../../common/widgets/drop_down/u_drop_down_underLine.dart';
import '../../../../../common/widgets/switch_btn/switch_btn.dart';
import '../../../../../common/widgets/textfields/app_text_fields.dart';
import '../../../../../utils/constants/images.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/add_expenses_controller.dart';

class AddExpensesScreen extends GetView<AddExpensesController> {
  const AddExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        centerTitle: true,
        showBackArrow: true,
        showDivider: false,
        title: Obx(
          () => Text(
            controller.isEditMode.value ? "Edit Expense" : "Add Expense",
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: UColors.textPrimary,
            ),
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
                controller: controller.nameController,
                hintText: "Enter expense name",
                titleText: "Expense Name*",
              ),
              SizedBox(height: USizes.lg),
              UTextField2(
                controller: controller.descriptionController,
                hintText: "Write descriptions...",
                titleText: "Expense Description*",
              ),
              SizedBox(height: USizes.xl),
              Row(
                children: [
                  Expanded(
                    child: UTextField2(
                      controller: controller.priceController,
                      hintText: "Enter price",
                      titleText: "Price*",
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      prefixWidget: SvgPicture.asset(UImages.rupeeIcon),
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
              Obx(() {
                // State 1: Loading - Show spinner
                if (controller.isLoadingClients.value) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Client*",
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: UColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: USizes.sm),
                      Container(
                        padding: EdgeInsets.all(USizes.md),
                        decoration: BoxDecoration(
                          border: Border.all(color: UColors.borderB3FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: UColors.primary,
                              ),
                            ),
                            SizedBox(width: USizes.sm),
                            Text(
                              "Loading clients...",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                color: UColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }

                // State 2: Empty after loading - Show error
                if (controller.hasLoadedClients.value &&
                    controller.clients.isEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Client*",
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: UColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: USizes.sm),
                      Container(
                        padding: EdgeInsets.all(USizes.md),
                        decoration: BoxDecoration(
                          border: Border.all(color: UColors.red3137),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: UColors.red3137,
                              size: 20,
                            ),
                            SizedBox(width: USizes.sm),
                            Expanded(
                              child: Text(
                                "No clients found. Please add a client first.",
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  color: UColors.red3137,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }

                // State 3: Initial state or Has clients - Show dropdown with tap to load
                return GestureDetector(
                  onTap: () {
                    // Load clients when field is tapped (if not already loaded)
                    controller.loadClients();
                  },
                  child: AbsorbPointer(
                    absorbing: controller.isLoadingClients.value,
                    child: UDropDown<int>(
                      label: "Client*",
                      hint: controller.clients.isEmpty
                          ? "Tap to load clients"
                          : "Select client",
                      value: controller.selectedClientId.value,
                      items: controller.clients.isEmpty
                          ? [] // Empty list for initial state
                          : controller.clients
                                .map(
                                  (client) => DropdownMenuItem<int>(
                                    value: client.clientId,
                                    child: Text(client.name),
                                  ),
                                )
                                .toList(),
                      onChanged: (value) {
                        if (controller.clients.isNotEmpty) {
                          controller.selectedClientId.value = value;
                        }
                      },
                    ),
                  ),
                );
              }),
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
              Obx(
                () => UButton(
                  label: controller.isSaving.value ? "Saving..." : "Save",
                  isLoading: controller.isSaving.value,
                  onPressed: controller.isSaving.value
                      ? () {} // Disable when saving
                      : controller.createExpense,
                ),
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
          // Priority 1: Show new local image if selected
          if (controller.selectedImage.value != null)
            _buildLocalImageWidget()
          // Priority 2: Show existing network image in edit mode
          else if (controller.existingImageUrl.value.isNotEmpty)
            _buildNetworkImageWidget()
          // Priority 3: Show upload box
          else
            _buildUploadBoxWidget(),

          SizedBox(height: USizes.lg),

          /// CAMERA BUTTON
          _buildCameraButton(),
        ],
      ),
    );
  }

  Widget _buildLocalImageWidget() {
    return Stack(
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
              child: const Icon(Icons.close, color: Colors.white, size: 18),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNetworkImageWidget() {
    return GestureDetector(
      onTap: controller.pickFromGallery, // Tap to change image
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              controller.existingImageUrl.value,
              height: 185,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 185,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: UColors.bgContainerF8FA,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: UColors.borderB3FF),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.broken_image,
                        size: 48,
                        color: UColors.textSecondary,
                      ),
                      SizedBox(height: USizes.sm),
                      Text(
                        'Failed to load image\nTap to upload new',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: UColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 185,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: UColors.bgContainerF8FA,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                          : null,
                      color: UColors.primary,
                    ),
                  ),
                );
              },
            ),
          ),

          /// OVERLAY WITH CHANGE HINT
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: USizes.sm,
                vertical: USizes.xs,
              ),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit, size: 14, color: Colors.white),
                  SizedBox(width: 4),
                  Text(
                    'Tap to change',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
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

  Widget _buildUploadBoxWidget() {
    return GestureDetector(
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
    );
  }

  Widget _buildCameraButton() {
    return GestureDetector(
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
    );
  }
}
