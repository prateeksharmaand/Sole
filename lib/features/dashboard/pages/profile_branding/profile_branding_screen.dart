import 'package:flutter/material.dart';
import 'package:flutter_dotted_border/flutter_dotted_border.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/common/widgets/appbar/appbar.dart';
import 'package:sole/common/widgets/textfields/app_text_fields.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/sizes.dart';
import 'package:sole/utils/helpers/device_helpers.dart';

import '../taxes_bankings/taxes_banking_screen.dart';

class ProfileBrandingScreen extends StatelessWidget {
  const ProfileBrandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(title: Text("Profile & Branding"), showBackArrow: true,
      actions: [
        TextButton(onPressed: (){}, child:  Text(
          "SAVE",
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: UColors.primary,
          ),
        ),)
      ],
      
      ),
      body: SingleChildScrollView(
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
                      // dotted Border Container
                      DottedBorder(
                        borderType: RoundedRectDottedBorder(
                          color: UColors.borderB3FF,
                          dashGap: 4,
                          dashWidth: 4,
                          strokeWidth: 2,
                          radius: Radius.circular(4),
                        ),
                        child: Container(
                          height: 104,
                          width: 104,
                          decoration: BoxDecoration(
                            color: UColors.bg,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text("Upload your\nlogo",
                                textAlign: TextAlign.center
                                ,style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w400,fontSize: 12,color: UColors.textA4A6)),
                          ),
                        ),
                      ),
                      SizedBox(width: USizes.lg),
            Expanded(
              child: Text(
                "Best size: 500 x 500 pixels Used on all invoices",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: UColors.textSecondary,
                )),
            )
                    ],
                  ),
                  SizedBox(height: USizes.xl),
                  Row(
                    children: [
                      DotContainer(),
                      Text(
                        "Profile Infomations",
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
                    "Full Name",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: UColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: USizes.md),
                  UTextField2(hintText: "Enter Full Name"),
                  SizedBox(height: USizes.xl),
                  Text(
                    "Email Address",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: UColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: USizes.md),
                  UTextField2(
                    hintText: "Enter Your Email Address",
                  ),
                  SizedBox(height: USizes.xl),
                  Text(
                    "Mobile Number",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: UColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: USizes.md),
                  UTextField2(hintText: "Enter Mobile Number"),
                  SizedBox(height: USizes.xl),
                  Text(
                    "Address",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: UColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: USizes.md),
                  UTextField2(
                    hintText: "Enter Your Full Address",
                  ),
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
                        "Business Information",
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
                    "ABN Number",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: UColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: USizes.md),
                  UTextField2(hintText: "Enter ABN Number"),
                  SizedBox(height: USizes.xl),
                  Text(
                    "Business Name",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: UColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: USizes.md),
                  UTextField2(
                    hintText: "Enter Business Name",
                  ),
                  SizedBox(height: USizes.xl),
                  Text(
                    "Mobile Number",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: UColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: USizes.md),
                  UTextField2(hintText: "Enter Your Mobile Number"),
                  SizedBox(height: USizes.xl),
                  Text(
                    "Industry",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: UColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: USizes.md),
                  UTextField2(hintText: "GST"),
                ],
              ),
            ),
            SizedBox(height: UDeviceHelper.getBottomNavigationBarHeight()),
          ],
        ),
      ),
    );
  }
}
