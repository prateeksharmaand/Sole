import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/common/widgets/app_btn/app_btn.dart';
import 'package:sole/common/widgets/button/social_buttons.dart';
import 'package:sole/common/widgets/drop_down/app_drop_down.dart';
import 'package:sole/common/widgets/textfields/app_text_fields.dart';
import 'package:sole/features/authentication/screens/login/login_screen.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/images.dart';
import 'package:sole/utils/constants/sizes.dart';
import 'package:sole/utils/helpers/device_helpers.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: USizes.defaultSpace20,
          right: USizes.defaultSpace20,
          top: UDeviceHelper.getAppBarHeight(),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(UImages.logoMedium),
                  SizedBox(height: USizes.lg),
                  Text(
                    "Create your account ✨",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      color: UColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: USizes.xs),
                  Text(
                    "Join SoleApp to simplify your accounting & invoicing.",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: UColors.textPrimary,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: USizes.xl),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: UColors.text4054,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: USizes.sm * 1.5),
                  UTextField(
                    hintText: "Enter your email",
                    prefixWidget: Padding(
                      padding: EdgeInsets.only(left: USizes.sm * 1.5),
                      child: SvgPicture.asset(UImages.mailIcon),
                    ),
                  ),
                  SizedBox(height: USizes.md),
                  Text(
                    "Password",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: UColors.text4054,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: USizes.sm * 1.5),
                  UTextField(
                    hintText: "Enter Password",
                    prefixWidget: Padding(
                      padding: EdgeInsets.only(left: USizes.sm * 1.5),
                      child: SvgPicture.asset(UImages.passwordIcon),
                    ),
                    suffix: Icon(
                      Icons.visibility_off_outlined,
                      color: UColors.iconA2B3,
                    ),
                  ),
                  SizedBox(height: USizes.md),
                  Text(
                    "Confirmation Password",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: UColors.text4054,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: USizes.sm * 1.5),
                  UTextField(
                    hintText: "Enter confirmation password",
                    prefixWidget: Padding(
                      padding: EdgeInsets.only(left: USizes.sm * 1.5),
                      child: SvgPicture.asset(UImages.passwordIcon),
                    ),
                    suffix: Icon(
                      Icons.visibility_off_outlined,
                      color: UColors.iconA2B3,
                    ),
                  ),
                  SizedBox(height: USizes.md),
                  Text(
                    "Join From",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: UColors.text4054,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: USizes.sm * 1.5),
                  UDropdownField(
                    hintText: "Select  join from",
                    items: const [
                      'Spreadsheets',
                      'Xero',
                      'QuickBooks',
                      'Zoho Books',
                    ],
                    prefixWidget: Padding(
                      padding: EdgeInsets.only(left: USizes.sm * 1.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [SvgPicture.asset(UImages.fourBoxIcon)],
                      ),
                    ),
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                  SizedBox(height: USizes.md),
                  Text(
                    "Referral Code (Optional)",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: UColors.text4054,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: USizes.sm * 1.5),
                  UDropdownField(
                    hintText: "Enter referral code",
                    items: const [
                      'Spreadsheets',
                      'Xero',
                      'QuickBooks',
                      'Zoho Books',
                    ],
                    prefixWidget: Padding(
                      padding: EdgeInsets.only(left: USizes.sm * 1.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [SvgPicture.asset(UImages.userIcon)],
                      ),
                    ),
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                  SizedBox(height: USizes.md),
                  Text(
                    "Coupon Code (Optional",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: UColors.text4054,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: USizes.sm * 1.5),
                  UDropdownField(
                    hintText: "Enter coupon code",
                    items: const [
                      'Spreadsheets',
                      'Xero',
                      'QuickBooks',
                      'Zoho Books',
                    ],
                    prefixWidget: Padding(
                      padding: EdgeInsets.only(left: USizes.sm * 1.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [SvgPicture.asset(UImages.ticketIcon)],
                      ),
                    ),
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                  SizedBox(height: USizes.lg),
                  UButton(onPressed: () {
                    Get.offAll(()=>LoginScreen());
                  }, label: "Sign Up"),
                  SizedBox(height: USizes.lg),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: UColors.disableD0D5,
                          endIndent: USizes.sm,
                        ),
                      ),
                      Text(
                        "or Sign in with social account",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: UColors.text5866,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: UColors.disableD0D5,
                          indent: USizes.sm,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: USizes.lg),
                  SocialAccountBtn(),
                  SizedBox(height: USizes.lg),
                  UButton(
                    onPressed: () {},
                    borderColor: UColors.primary,
                    bgColor: UColors.white,
                    label: "Sole for Accountants & Bookeepers",
                    textColor: UColors.primary,
                  ),
                  SizedBox(height: USizes.lg),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: UColors.text5866,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: "Login",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              color: UColors.text46E6,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(() => LoginScreen());
                              },
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: UDeviceHelper.getBottomNavigationBarHeight(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
