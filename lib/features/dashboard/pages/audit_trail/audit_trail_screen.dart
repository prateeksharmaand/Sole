import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/common/widgets/appbar/appbar.dart';
import 'package:sole/features/dashboard/controllers/audit_trail_controller.dart';
import 'package:sole/features/dashboard/pages/assets/assets_screen.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/images.dart';
import 'package:sole/utils/constants/sizes.dart';
import '../../../../common/widgets/drop_down/common_year_dropdown.dart';

class AuditTrailScreen extends GetView<AuditTrailController> {
  const AuditTrailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        centerTitle: true,
        showBackArrow: true,
        showDivider: false,
        title: Text(
          "Audit Trail",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: UColors.textPrimary,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(USizes.defaultSpace20),
        child: Column(
          children: [
            /// Info Box
            CommonInfoContainer(
              text: 'View all user activities and changes in the system.',
            ),

            SizedBox(height: USizes.lg),
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
            SizedBox(height: USizes.lg),

            /// Search
            Row(children: [UCommonSearch(hint: "Search activity")]),

            SizedBox(height: USizes.md),

            /// List Area
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: 4,
                separatorBuilder: (context, index) =>
                    SizedBox(height: USizes.md),

                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: UColors.borderBtn, width: 1),
                      color: Colors.white,
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Email
                        Text(
                          "demo@soleapp.com",
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: UColors.black,
                          ),
                        ),

                        Divider(height: 20, color: UColors.borderBtn),

                        /// Date & Time
                        _buildRow(
                          title: "Date & Time",
                          value: "17/12/2025 — 03:14 PM",
                        ),

                        SizedBox(height: 10),

                        /// Module
                        _buildRow(
                          title: "Module",
                          value: "Communication\nPreference",
                        ),

                        SizedBox(height: 10),

                        /// Action Performed
                        _buildRow(
                          title: "Action Performed",
                          value:
                              "Reminder setting for Invoice due reminder updated",
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Common row widget
  Widget _buildRow({required String title, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            color: UColors.text5866,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: UColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

class CommonInfoContainer extends StatelessWidget {
  final String text;
  const CommonInfoContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: UColors.lightGrey,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: UColors.textPrimary),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: UColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CommonEmptyReporting extends StatelessWidget {
  final String title;
  final String subtitle;
  const CommonEmptyReporting({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(UImages.emptyReportingIcon),
          SizedBox(height: USizes.lg),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: UColors.textPrimary,
            ),
          ),
          SizedBox(height: USizes.sm),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: UColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
