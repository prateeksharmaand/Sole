import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/common/widgets/app_btn/app_btn.dart';
import 'package:sole/common/widgets/appbar/appbar.dart';
import 'package:sole/common/widgets/textfields/app_text_fields.dart';
import 'package:sole/features/dashboard/communication_preferences/communication_preferences_screen.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/images.dart';
import 'package:sole/utils/constants/sizes.dart';
import 'package:sole/utils/helpers/device_helpers.dart';

class TaxesBankingScreen extends StatelessWidget {
  const TaxesBankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(title: Text("Taxes & Banking"), showBackArrow: true),
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
                  ),
                  SizedBox(height: USizes.xl),
                  CommonTextSubTextAndSwitch(
                    text: 'Set as default tax',
                    subText:
                        'This tax will be automatically applied to new invoices and expenses',
                    value: true,
                    onChanged: (bool value) {},
                  ),
                  SizedBox(height: USizes.xl),
                  Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: UColors.whiteF9F9
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Important notes on taxes",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: UColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: USizes.sm),
                        Row(
                          children: [
                            DotContainer(
                              height: 6,
                              width: 6,
                              color: UColors.textSecondary,
                            ),
                            Expanded(
                              child: Text(
                                "Setting a tax as default will automatically apply it to new invoices and recurring expenses.",
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: UColors.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: USizes.sm),
                        Row(
                          children: [
                            DotContainer(
                              height: 6,
                              width: 6,
                              color: UColors.textSecondary,
                            ),
                            Expanded(
                              child: Text(
                                    "Changing the default tax will affect any recurring invoices or recurring expenses that use the previous default tax.",
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: UColors.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: USizes.sm),
                        Row(
                          children: [
                            DotContainer(
                              height: 6,
                              width: 6,
                              color: UColors.textSecondary,
                            ),
                            Expanded(
                              child: Text(
                                " After updating tax settings, you may need to manually update existing recurring invoices and expenses.",
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: UColors.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: USizes.xl),
                  SizedBox(
                    width: 150,
                    child: UButton(onPressed: () {}, label: "Update Tax"),
                  ),
                ],
              ),
            ),
            SizedBox(height: USizes.xl),
            Divider(color: UColors.divider, thickness: 20),
            SizedBox(height: USizes.md),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: USizes.defaultSpace20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      DotContainer(),
                      Text(
                        "Payment Details",
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
                    "BSB Number",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: UColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: USizes.md),
                  UTextField2(hintText: "BSB Number"),
                  SizedBox(height: USizes.xl),
                  Text(
                    "Bank Name",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: UColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: USizes.md),
                  UTextField2(hintText: "Bank Name"),
                  SizedBox(height: USizes.xl),
                  Text(
                    "Account Holder Name ",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: UColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: USizes.md),
                  UTextField2(hintText: "Account Holder Name "),
                  SizedBox(height: USizes.xl),
                  Text(
                    "Account Number ",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: UColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: USizes.md),
                  UTextField2(hintText: "Account Number "),
                  SizedBox(height: USizes.xl),
                  SizedBox(
                    width: 110,
                    child: UButton(onPressed: () {}, label: "Save"),
                  ),
                ],
              ),
            ),
            SizedBox(height: USizes.xl),
            Divider(color: UColors.divider, thickness: 20),
            SizedBox(height: USizes.md),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: USizes.defaultSpace20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      DotContainer(),
                      Text(
                        "Automated Payments",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: UColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: USizes.xl),
                  CommonAutomatedPaymentsContainer(icon: UImages.linkSquareIcon, text: 'Connect Account', subText: 'Link Existing Account If you have a Worldpay account, connect it here.', btnName: 'Connect Account', onTap: (){}),
                  CommonAutomatedPaymentsContainer(icon: UImages.addIcon, text: "Create New Account", subText: "If you don't have an account, set up a new one.", btnName: "Create Account", onTap: (){}),
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

class CommonAutomatedPaymentsContainer extends StatelessWidget {
  final String icon;
  final String text;
  final String subText;
  final String btnName;
  final Function()? onTap;
  const CommonAutomatedPaymentsContainer({
    super.key, required this.icon, required this.text, required this.subText, required this.btnName, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: UColors.whiteF9F9
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: UColors.primaryLightE0FF,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: SvgPicture.asset(
                icon, // replace
                height: 22,
              ),
            ),
          ),
          SizedBox(height: USizes.md),
          Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: UColors.textPrimary,
            ),
          ),
          SizedBox(height: USizes.sm),
          Text(
            subText,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: UColors.textSecondary,
            ),
          ),
          SizedBox(height: USizes.lg),
          UButton(
            onPressed: onTap,
            label: btnName,
          ),
          SizedBox(height: USizes.sm),
        ],
      ),
    );
  }
}

class DotContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  const DotContainer({super.key, this.height, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 8,
      width: width ?? 8,
      margin: EdgeInsets.only(right: USizes.sm),
      decoration: BoxDecoration(
        color: color ?? UColors.primary,
        shape: BoxShape.circle,
      ),
    );
  }
}
