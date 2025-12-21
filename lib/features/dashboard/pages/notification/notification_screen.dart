import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/images.dart';
import 'package:sole/utils/constants/sizes.dart';
import 'package:sole/utils/helpers/device_helpers.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../controllers/notification_controller.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UColors.bg,
      appBar: UAppBar(
        centerTitle: true,
        showBackArrow: true,
        showDivider: true,
        title: Text(
          "Notification",
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: UColors.textPrimary,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),

          /// Tabs
          _tabBar(),

          const SizedBox(height: 20),

          /// Content
          SingleChildScrollView(
            child: Obx(() {
              final data = controller.filteredNotifications;

              if (controller.selectedTab.value == 2 && data.isEmpty) {
                return _emptyState(context);
              }

              return Container(
                margin: EdgeInsets.symmetric(horizontal: USizes.defaultSpace20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: UColors.white,
                ),
                child: Column(
                  children: List.generate(
                    data.length,
                    (index) => _notificationTile(data[index]),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _tabBar() {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F3F5),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: List.generate(
            controller.tabs.length,
            (index) => Expanded(
              child: GestureDetector(
                onTap: () => controller.selectedTab.value = index,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: controller.selectedTab.value == index
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    controller.tabs[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: controller.selectedTab.value == index
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: controller.selectedTab.value == index
                          ? UColors.textPrimary
                          : UColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _notificationTile(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: USizes.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Icon
          SvgPicture.asset(UImages.notificationListIcon),

          const SizedBox(width: 12),

          /// Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['title'],
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: UColors.textPrimary,
                      ),
                    ),
                    Text(
                      item['date'],
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        color: UColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item['desc'],
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: UColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyState(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: UDeviceHelper.getScreenHeight(context) * .25),
        SvgPicture.asset(UImages.notificationCircleIcon),
        SizedBox(height: USizes.lg),
        Text(
          'No read notifications',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            color: UColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Notifications you’ve already read will appear here.',
          style: GoogleFonts.plusJakartaSans(
            color: UColors.textSecondary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
