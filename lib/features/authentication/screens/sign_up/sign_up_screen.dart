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

import 'package:sole/features/authentication/screens/sign_up/sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
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
                    controller: controller.emailController,
                    hintText: "Enter your email",
                    prefixWidget: Padding(
                      padding: EdgeInsets.only(left: USizes.sm * 1.5),
                      child: SvgPicture.asset(UImages.mailIcon),
                    ),
                  ),
                  Obx(
                    () => controller.emailError.value.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              controller.emailError.value,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                color: Colors.red,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  SizedBox(height: USizes.md),
                  Text(
                    "Password",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: UColors.text4054,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: USizes.sm * 1.5),
                  Obx(
                    () => UTextField(
                      controller: controller.passwordController,
                      hintText: "Enter password",
                      isFilled: true,
                      fillColor: Colors.white,
                      borderRadius: 10,
                      prefixWidget: Padding(
                        padding: EdgeInsets.only(left: USizes.sm * 1.5),
                        child: SvgPicture.asset(UImages.passwordIcon),
                      ),
                      obscureText: !controller.isPasswordVisible.value,
                      onchanged: controller.updatePassword,
                      suffix: IconButton(
                        icon: Icon(
                          controller.isPasswordVisible.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: UColors.iconA2B3,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                  ),
                  SizedBox(height: USizes.sm),
                  // Password Strength Bars
                  Obx(
                    () => Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 4,
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                              color: controller.passwordStrength.value > 0
                                  ? const Color(0xFF10B981) // Green
                                  : UColors.disableD0D5,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 4,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: controller.passwordStrength.value > 0.33
                                  ? const Color(0xFF10B981)
                                  : UColors.disableD0D5,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 4,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: controller.passwordStrength.value > 0.66
                                  ? const Color(0xFF10B981)
                                  : UColors.disableD0D5,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 4,
                            margin: const EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              color: controller.passwordStrength.value == 1.0
                                  ? const Color(0xFF10B981)
                                  : UColors.disableD0D5,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: USizes.sm),
                  // Strength Text
                  Obx(
                    () => Text(
                      controller.passwordStrength.value == 1.0
                          ? "Strong password. Your password is secure."
                          : "Must contain at least:",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: UColors.textSecondary,
                      ),
                    ),
                  ),
                  SizedBox(height: USizes.sm),
                  // Checklist
                  Obx(
                    () => Column(
                      children: [
                        _buildCheckItem(
                          "At least 1 uppercase",
                          controller.hasUppercase.value,
                        ),
                        const SizedBox(height: 4),
                        _buildCheckItem(
                          "At least 1 number",
                          controller.hasDigits.value,
                        ),
                        const SizedBox(height: 4),
                        _buildCheckItem(
                          "At least 8 characters",
                          controller.hasMinLength.value,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: USizes.md),
                  Text(
                    "Confirm Password",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: UColors.text4054,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: USizes.sm * 1.5),
                  Obx(
                    () => UTextField(
                      controller: controller.confirmPasswordController,
                      hintText: "Enter Confirm Password",
                      prefixWidget: Padding(
                        padding: EdgeInsets.only(left: USizes.sm * 1.5),
                        child: SvgPicture.asset(UImages.passwordIcon),
                      ),
                      obscureText: !controller.isConfirmPasswordVisible.value,
                      suffix: IconButton(
                        icon: Icon(
                          controller.isConfirmPasswordVisible.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: UColors.iconA2B3,
                        ),
                        onPressed: controller.toggleConfirmPasswordVisibility,
                      ),
                    ),
                  ),
                  Obx(
                    () => controller.confirmPasswordError.value.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              controller.confirmPasswordError.value,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                color: Colors.red,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
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
                    items: const ['UK', 'India', 'China', 'Nepal'],
                    prefixWidget: Padding(
                      padding: EdgeInsets.only(left: USizes.sm * 1.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [SvgPicture.asset(UImages.fourBoxIcon)],
                      ),
                    ),
                    onChanged: (value) {
                      controller.selectedJoinFrom.value = value ?? '';
                    },
                  ),
                  Obx(
                    () => controller.joinFromError.value.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              controller.joinFromError.value,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                color: Colors.red,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
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
                  UTextField(
                    controller: controller.referralCodeController,
                    hintText: "Enter referral code",
                    prefixWidget: Padding(
                      padding: EdgeInsets.only(left: USizes.sm * 1.5),
                      child: SvgPicture.asset(UImages.userIcon),
                    ),
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
                  UTextField(
                    controller: controller.couponCodeController,
                    hintText: "Enter coupon code",
                    prefixWidget: Padding(
                      padding: EdgeInsets.only(left: USizes.sm * 1.5),
                      child: SvgPicture.asset(UImages.ticketIcon),
                    ),
                  ),
                  SizedBox(height: USizes.lg),
                  Obx(
                    () => UButton(
                      onPressed: () async {
                        if (!controller.validateFields()) {
                          return;
                        }

                        // Device registration is already handled by AppInitializationController
                        // during app startup, so we can proceed directly to user registration
                        await controller.registerUser();
                      },
                      isLoading: controller.isLoading.value,
                      label: "Sign Up",
                    ),
                  ),
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

  Widget _buildCheckItem(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          Icons.check_circle,
          size: 16,
          color: isValid ? const Color(0xFF10B981) : UColors.disableD0D5,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            color: isValid ? const Color(0xFF10B981) : UColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
