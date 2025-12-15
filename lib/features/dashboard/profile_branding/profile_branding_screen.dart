import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/common/widgets/appbar/appbar.dart';
import 'package:sole/common/widgets/textfields/app_text_fields.dart';
import 'package:sole/features/dashboard/taxes_bankings/taxes_banking_screen.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/sizes.dart';
import 'package:sole/utils/helpers/device_helpers.dart';

class ProfileBrandingScreen extends StatelessWidget {
  const ProfileBrandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(title: Text("Profile & Branding"), showBackArrow: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: USizes.defaultSpace20,vertical: USizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      DotContainer(),
                      Text(
                        "Taxes",
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
                    "Tax name",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: UColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: USizes.md),
                  UTextField2(hintText: "GST",
                  ),
                  SizedBox(height: USizes.xl),
                  Text(
                    "Rate",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: UColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: USizes.md),
                  UTextField2(
                    hintText: "Rate",
                    suffix: Icon(Icons.percent_outlined),
                  )
                ],
              ),
            ),
            SizedBox(height: USizes.xl),
            Divider(color: UColors.divider, thickness: 20),
            SizedBox(height: USizes.md),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: USizes.defaultSpace20,vertical: USizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      DotContainer(),
                      Text(
                        "Taxes",
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
                    "Tax name",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: UColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: USizes.md),
                  UTextField2(hintText: "GST",
                  ),
                  SizedBox(height: USizes.xl),
                  Text(
                    "Rate",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: UColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: USizes.md),
                  UTextField2(
                    hintText: "Rate",
                    suffix: Icon(Icons.percent_outlined),
                  ),
                  SizedBox(height: USizes.xl),
                  Text(
                    "Tax name",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: UColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: USizes.md),
                  UTextField2(hintText: "GST",
                  ),
                  SizedBox(height: USizes.xl),
                  Text(
                    "Tax name",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: UColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: USizes.md),
                  UTextField2(hintText: "GST",
                  ),
                ],
              ),
            ),
            SizedBox(
                height: UDeviceHelper.getBottomNavigationBarHeight()
            )
          ],
        ),
      ),
    );
  }
}
