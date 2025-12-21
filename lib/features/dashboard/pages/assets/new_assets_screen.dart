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
              DottedBorder(
                borderType: RoundedRectDottedBorder(
                  color: UColors.borderB3FF,
                  dashGap: 4,
                  dashWidth: 4,
                  strokeWidth: 2,
                  radius: Radius.circular(12),
                ),
                child: SizedBox(
                  height: 185,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
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
                      SizedBox(
                        height: 38,
                        width: 130,
                        child: UButton(
                          onPressed: () {},
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
              SizedBox(height: USizes.lg),
              UTextField2(hintText: "Enter asset name", titleText: "New Asset"),
              SizedBox(height: USizes.xl),
              UTextField2(
                hintText: "Enter price",
                titleText: "Asset Value",
                prefixWidget: SvgPicture.asset(UImages.rupeeIcon),
              ),
              SizedBox(height: USizes.lg),
              UTextField2(
                hintText: "Date Purchased",
                titleText: "Enter date",
                prefixWidget: SvgPicture.asset(UImages.calendarLineIcon),
                suffix: Icon(Icons.keyboard_arrow_down_outlined),
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
            ],
          ),
        ),
      ),
    );
  }
}
