import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/features/authentication/screens/login/login_screen.dart';
import 'package:sole/features/dashboard/pages/profile/widgets/bussiness_information_card.dart';
import 'package:sole/features/dashboard/pages/support/support_screen.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/images.dart';
import 'package:sole/utils/constants/sizes.dart';
import '../../controllers/profile_controller.dart';
import '../accountant/accountant_screen.dart';
import '../communication_preferences/communication_preferences_screen.dart';
import '../profile_branding/profile_branding_screen.dart';
import '../subscriptions/subscriptions_screen.dart';
import '../taxes_bankings/taxes_banking_screen.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller if not already done
    Get.put(ProfileController());

    return Scaffold(
      backgroundColor: UColors.bg,
      body: Obx(() {
        // Show loading indicator while fetching profile
        if (controller.isLoading.value &&
            controller.userProfile.value == null) {
          return Center(
            child: CircularProgressIndicator(color: UColors.primary),
          );
        }

        return Column(
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
                              controller.displayName,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: UColors.textPrimary,
                              ),
                            ),
                            Text(
                              controller.email,
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
                    child:
                        controller.profilePictureUrl != null &&
                            controller.profilePictureUrl!.isNotEmpty
                        ? ClipOval(
                            child: Image.network(
                              controller.profilePictureUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    decoration: BoxDecoration(
                                      color: UColors.primary.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      size: 40,
                                      color: UColors.primary,
                                    ),
                                  ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: UColors.primary.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person,
                              size: 40,
                              color: UColors.primary,
                            ),
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
                      Obx(() {
                        // Loading state
                        if (controller.isLoadingClients.value &&
                            controller.clients.isEmpty) {
                          return SizedBox(
                            height: 260,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: UColors.primary,
                              ),
                            ),
                          );
                        }

                        // Empty state
                        if (controller.clients.isEmpty) {
                          return SizedBox(
                            height: 260,
                            child: Center(
                              child: Text(
                                'No clients found',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  color: UColors.textSecondary,
                                ),
                              ),
                            ),
                          );
                        }

                        // Client list
                        return SizedBox(
                          height: 260,
                          child: ListView.builder(
                            itemCount: controller.clients.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final client = controller.clients[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: SizedBox(
                                  width: 330,
                                  child: BusinessInformationCard(
                                    client: client,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: USizes.defaultSpace20,
                        ),
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
                              onTap: () {
                                Get.to(() => ProfileBrandingScreen());
                              },
                            ),
                            IconText(
                              icon: UImages.cardIcon,
                              text: "Taxes & Banking",
                              onTap: () {
                                Get.to(() => TaxesBankingScreen());
                              },
                            ),
                            IconText(
                              icon: UImages.percentageIcon,
                              text: "Accountant",
                              onTap: () {
                                Get.to(() => AccountantScreen());
                              },
                            ),
                            IconText(
                              icon: UImages.calendarIcon,
                              text: "Subscriptions",
                              onTap: () {
                                Get.to(() => SubscriptionsScreen());
                              },
                            ),
                            IconText(
                              icon: UImages.communicationIcon,
                              text: "Communication Preferences",
                              isDivider: false,
                              onTap: () {
                                Get.to(() => CommunicationPreferencesScreen());
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: USizes.defaultSpace20,
                        ),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: UColors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            IconText(
                              icon: UImages.headphoneIcon,
                              text: "Support",
                              onTap: () {
                                Get.to(() => SupportScreen());
                              },
                            ),
                            IconText(
                              icon: UImages.logoutIcon,
                              text: "Logout",
                              isDivider: false,
                              isArrow: false,
                              textColor: UColors.textRed414B,
                              onTap: () {
                                _showLogoutDialog(context);
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
        );
      }),
    );
  }
}

class CommonContainer extends StatelessWidget {
  final String heading;
  final String text;
  const CommonContainer({super.key, required this.heading, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: UColors.whiteF9F9,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: UColors.textSecondary,
            ),
          ),
          Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: UColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Show logout confirmation dialog
void _showLogoutDialog(BuildContext context) {
  Get.dialog(
    AlertDialog(
      backgroundColor: UColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        'Logout',
        style: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: UColors.textPrimary,
        ),
      ),
      content: Text(
        'Are you sure you want to logout?',
        style: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: UColors.textSecondary,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            'Cancel',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: UColors.textSecondary,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            // Close dialog
            Get.back();

            // Show loading indicator
            Get.dialog(
              Center(child: CircularProgressIndicator(color: UColors.primary)),
              barrierDismissible: false,
            );

            // Get controller from GetX
            final controller = Get.find<ProfileController>();

            // Perform logout
            final success = await controller.logout();

            // Close loading indicator
            Get.back();

            if (success) {
              // Navigate to login screen and clear all previous routes
              Get.offAll(() => LoginScreen());
            } else {
              // Show error message
              Get.snackbar(
                'Error',
                'Failed to logout. Please try again.',
                backgroundColor: UColors.textRed414B.withOpacity(0.1),
                colorText: UColors.textRed414B,
                snackPosition: SnackPosition.BOTTOM,
                margin: EdgeInsets.all(16),
              );
            }
          },
          child: Text(
            'Logout',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: UColors.textRed414B,
            ),
          ),
        ),
      ],
    ),
    barrierDismissible: true,
  );
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
    return InkWell(
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
