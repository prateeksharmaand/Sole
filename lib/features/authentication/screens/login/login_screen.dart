import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/common/widgets/app_btn/app_btn.dart';
import 'package:sole/common/widgets/button/social_buttons.dart';
import 'package:sole/common/widgets/textfields/app_text_fields.dart';
import 'package:sole/features/authentication/screens/sign_up/sign_up_screen.dart';
import 'package:sole/navigation_menu.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/images.dart';
import 'package:sole/utils/constants/sizes.dart';
import 'package:sole/utils/helpers/device_helpers.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: EdgeInsets.only(
          bottom: UDeviceHelper.getBottomNavigationBarHeight(),
        ),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: "Don’t have an account? ",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              color: UColors.text5866,
              fontWeight: FontWeight.w400,
            ),
            children: [
              TextSpan(
                text: "Sign Up",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color: UColors.text46E6,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.to(() => SignUpScreen());
                  },
              ),
            ],
          ),
        ),
      ),
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
                    "Welcome back 👋",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      color: UColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: USizes.xs),
                  Text(
                    "Log in to manage your invoices and expenses. ",
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
                  SizedBox(height: USizes.sm),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Forgot Password?",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: UColors.text4DFF,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: USizes.lg),
                  UButton(onPressed: () {
                    Get.offAll(
                            ()=>NavigationMenu());
                  }, label: "Sign in"),
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
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "By signing in, you agree to Sole’s ",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: UColors.text5866,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: "Privacy Policy ",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: UColors.text5866,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(text: "And "),
                        TextSpan(
                          text: "Terms and Conditions",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: UColors.text5866,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
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
