import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/common/widgets/app_btn/app_btn.dart';
import 'package:sole/common/widgets/textfields/app_text_fields.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/images.dart';
import 'package:sole/utils/constants/sizes.dart';
import 'package:sole/utils/helpers/device_helpers.dart';
import 'verification_controller.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerificationController());

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: USizes.defaultSpace20,
          right: USizes.defaultSpace20,
          top: UDeviceHelper.getAppBarHeight(),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: USizes.xl),
              SvgPicture.asset(UImages.logoMedium),
              SizedBox(height: USizes.xl),
              Text(
                "Verify Your Email ✉️",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  color: UColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: USizes.xs),
              Obx(
                () => Text(
                  "We've sent a verification code to\n${controller.email.value}",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    color: UColors.textPrimary,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: USizes.xl * 2),
              Text(
                "Verification Code",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: UColors.text4054,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: USizes.sm * 1.5),
              UTextField(
                controller: controller.otpController,
                hintText: "Enter 6-digit code",
                keyboardType: TextInputType.number,
                maxLength: 6,
                textAlign: TextAlign.center,
                textstyle: GoogleFonts.plusJakartaSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 8,
                ),
              ),
              SizedBox(height: USizes.xl * 2),
              Obx(
                () => UButton(
                  onPressed: controller.verifyAccount,
                  label: "Verify",
                  isLoading: controller.isLoading.value,
                ),
              ),
              SizedBox(height: USizes.lg),
              // TextButton(
              //   onPressed: () {
              //     Get.snackbar(
              //       'Info',
              //       'Resend code functionality coming soon',
              //       snackPosition: SnackPosition.BOTTOM,
              //     );
              //   },
              //   child: Text(
              //     "Didn't receive the code? Resend",
              //     style: GoogleFonts.plusJakartaSans(
              //       fontSize: 14,
              //       color: UColors.primary,
              //       fontWeight: FontWeight.w500,
              //       decoration: TextDecoration.underline,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
