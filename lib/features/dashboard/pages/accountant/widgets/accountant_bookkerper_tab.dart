import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/common/widgets/textfields/app_text_fields.dart';
import 'package:sole/features/dashboard/pages/taxes_bankings/taxes_banking_screen.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/sizes.dart';
import 'package:sole/utils/helpers/device_helpers.dart';

class AccountantBookkeeperTab extends StatelessWidget {
  const AccountantBookkeeperTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: USizes.defaultSpace20,
              vertical: USizes.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    DotContainer(),
                    Text(
                      "Accounting Information",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: UColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: USizes.xl),
                Text(
                  "Accountant Name",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: UColors.textSecondary,
                  ),
                ),
                SizedBox(height: USizes.md),
                UTextField2(hintText: "Accountant Full Name"),
                SizedBox(height: USizes.xl),
                Text(
                  "Accountant Email Address",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: UColors.textSecondary,
                  ),
                ),
                SizedBox(height: USizes.md),
                UTextField2(hintText: "eg., accountant@example.com"),
              ],
            ),
          ),
          SizedBox(height: USizes.xl),
          Divider(color: UColors.divider, thickness: 12),
          SizedBox(height: USizes.md),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: USizes.defaultSpace20,
              vertical: USizes.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    DotContainer(),
                    Text(
                      "Bookeeper Information",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: UColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: USizes.xl),
                Text(
                  "Bookeeper Name",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: UColors.textSecondary,
                  ),
                ),
                SizedBox(height: USizes.md),
                UTextField2(hintText: "Bookeeper full name"),
                SizedBox(height: USizes.xl),
                Text(
                  "Bookeeper Email Address",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: UColors.textSecondary,
                  ),
                ),
                SizedBox(height: USizes.md),
                UTextField2(
                  hintText: "eg., boookeeper@exaple.com",
                  suffix: Icon(Icons.percent_outlined),
                ),
              ],
            ),
          ),
          SizedBox(height: UDeviceHelper.getBottomNavigationBarHeight()),
        ],
      ),
    );
  }
}