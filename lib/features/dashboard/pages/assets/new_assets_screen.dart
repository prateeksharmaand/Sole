import 'package:flutter/material.dart';
import 'package:flutter_dotted_border/flutter_dotted_border.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/common/widgets/app_btn/app_btn.dart';
import 'package:sole/common/widgets/switch_btn/switch_btn.dart';
import 'package:sole/common/widgets/textfields/app_text_fields.dart';
import 'package:sole/utils/constants/images.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/drop_down/u_drop_down_underLine.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/assets_controller.dart';

class NewAssetsScreen extends GetView<AssetsController> {
  const NewAssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UColors.bg,
      appBar: const UAppBar(
        title: Text("New Assets"),
        showDivider: false,
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(USizes.defaultSpace20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // dotted Border Container
              ReceiptUploadBox(),
              SizedBox(height: USizes.lg),
              UTextField2(
                controller: controller.assetNameController,
                hintText: "Enter asset name",
                titleText: "New Asset",
              ),
              SizedBox(height: USizes.xl),
              UTextField2(
                controller: controller.assetValueController,
                hintText: "Enter price",
                titleText: "Asset Value",
                prefixWidget: SvgPicture.asset(UImages.rupeeIcon),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: USizes.lg),
              UTextField2(
                controller: controller.datePurchaseController,
                hintText: "Date Purchased",
                titleText: "Enter date",
                prefixWidget: SvgPicture.asset(UImages.calendarLineIcon),
                suffix: Icon(Icons.keyboard_arrow_down_outlined),
                isReadOnly: true,
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    controller.datePurchaseController.text =
                        "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                  }
                },
              ),
              SizedBox(height: USizes.lg),
              Obx(() {
                if (controller.isLoadingClients.value) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Supplier",
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: UColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: USizes.sm),
                      Center(child: CircularProgressIndicator()),
                    ],
                  );
                }

                return UDropDown<int>(
                  label: "Supplier",
                  hint: "Select supplier",
                  value: controller.selectedClientId.value,
                  items: controller.clientsList
                      .map(
                        (client) => DropdownMenuItem<int>(
                          value: client.clientId,
                          child: Text(client.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    controller.selectedClientId.value = value;
                  },
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

              // Save Button
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: UButton(
                    onPressed: controller.isSavingAsset.value
                        ? null
                        : controller.createNewAsset,
                    label: controller.isSavingAsset.value
                        ? "Saving..."
                        : "Save Asset",
                    bgColor: UColors.primary,
                    textColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReceiptUploadBox extends GetView<AssetsController> {
  const ReceiptUploadBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.receiptImage.value == null
          ? GestureDetector(
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.add),
                      SizedBox(height: USizes.lg),
                      Text(
                        "Add a Photo or Receipt",
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: UColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: USizes.xs),
                      Text(
                        "JPEG, PNG, or JPG formats, up to 5 MB.",
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: UColors.text8C98,
                        ),
                      ),
                      SizedBox(height: USizes.md),

                      /// Browse Button
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
            )
          /// ===== IMAGE VIEW =====
          : Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 185,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.file(
                      controller.receiptImage.value!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                /// CLEAR ICON
                Positioned(
                  right: 6,
                  top: 6,
                  child: GestureDetector(
                    onTap: controller.clearImage,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
