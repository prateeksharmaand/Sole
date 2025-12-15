import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/sizes.dart';
import 'package:sole/utils/helpers/device_helpers.dart';

class OnboardingPageView extends StatelessWidget {
  final String image;
  final String text;
  final String subText;
  const OnboardingPageView({
    super.key, required this.image, required this.text, required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: UDeviceHelper.getAppBarHeight() + 50,
        left: USizes.defaultSpace,
        right: USizes.defaultSpace,
      ),
      child: Column(
        children: [
          Image(image: AssetImage(image),height: UDeviceHelper.getScreenHeight(context) * .5,width: UDeviceHelper.getScreenWidth(context),),
          SizedBox(height: USizes.sm),
          Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 24,
              color: UColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: USizes.xs * 3),
          Text(
            subText,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: UColors.textPrimary,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}