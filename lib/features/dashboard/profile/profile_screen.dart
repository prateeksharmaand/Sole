import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/features/authentication/screens/login/login_screen.dart';
import 'package:sole/features/dashboard/communication_preferences/communication_preferences_screen.dart';
import 'package:sole/features/dashboard/profile/widgets/bussiness_information_card.dart';
import 'package:sole/features/dashboard/subscriptions/subscriptions_screen.dart';
import 'package:sole/features/dashboard/taxes_bankings/taxes_banking_screen.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/images.dart';
import 'package:sole/utils/constants/sizes.dart';
import 'package:sole/utils/helpers/device_helpers.dart';
import 'package:sole/utils/helpers/helper_functions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UColors.bg,
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 260,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                      image: AssetImage(UImages.bgProfileScreen),
                      width: double.infinity,
                      height: 148,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: USizes.lg * 1.8),
                    Padding(
                      padding: EdgeInsets.only(left: USizes.defaultSpace20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Gissele Alexandra",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: UColors.textPrimary,
                            ),
                          ),
                          Text(
                            "gisselealexandra@gmail.com",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: UColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: USizes.defaultSpace20,
                top: 115,
                child: Container(
                  height: 66,
                  width: 66,
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: UColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Image(
                    image: AssetImage("assets/images/img/user_profile.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: USizes.defaultSpace20,
                  right: USizes.defaultSpace20,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 260,
                      child: ListView.builder(
                        itemCount: 2,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: SizedBox(
                              width: 330, // ✅ MUST HAVE WIDTH
                              child: BusinessInformationCard(),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: USizes.defaultSpace20),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: UColors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          IconText(
                            icon: UImages.personIcon,
                            text: "Profile & Branding",
                          ),
                          IconText(icon: UImages.cardIcon, text: "Taxes & Banking",onTap: (){
                            Get.to(()=>TaxesBankingScreen());
                          }),
                          IconText(
                            icon: UImages.percentageIcon,
                            text: "Accountant",
                          ),
                          IconText(
                            icon: UImages.calendarIcon,
                            text: "Subscriptions",
                            onTap: (){
                              Get.to(()=>SubscriptionsScreen());
                            },
                          ),
                          IconText(
                            icon: UImages.communicationIcon,
                            text: "Communication Preferences",
                            isDivider: false,
                            onTap: (){
                              Get.to(()=>CommunicationPreferencesScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: USizes.defaultSpace20),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: UColors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          IconText(icon: UImages.headphoneIcon, text: "Support"),
                          IconText(
                            icon: UImages.logoutIcon,
                            text: "Logout",
                            isDivider: false,
                            isArrow: false,
                            textColor: UColors.textRed414B,
                            onTap: () {
                              Get.offAll(() => LoginScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CommonContainer extends StatelessWidget {
  final String heading;
  final String text;
  const CommonContainer({
    super.key, required this.heading, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
      decoration: BoxDecoration(
        color: UColors.whiteF9F9,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(
        heading,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color:  UColors.textSecondary,
        )),
        Text(
        text,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color:  UColors.textPrimary,
        )),
        ],
      ),
    );
  }
}

class IconText extends StatelessWidget {
  final String icon;
  final String text;
  final Color? textColor;
  final bool? isDivider;
  final bool? isArrow;
  final GestureTapCallback? onTap;
  const IconText({
    super.key,
    this.isDivider = true,
    required this.icon,
    required this.text,
    this.textColor,
    this.isArrow = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(icon),
              SizedBox(width: USizes.sm * 1.25),
              Text(
                text,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: textColor ?? UColors.textPrimary,
                ),
              ),
              if (isArrow == true) Spacer(),
              if (isArrow == true)
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: UColors.text5866,
                ),
            ],
          ),
          if (isDivider == true) Divider(color: UColors.divider, height: 28),
        ],
      ),
    );
  }
}
