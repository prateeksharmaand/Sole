import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/features/dashboard/controllers/expense_controller.dart';
import 'package:sole/features/dashboard/controllers/reports_controller.dart';
import 'package:sole/features/dashboard/pages/dashboard/dashboard_controller.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/constants/images.dart';
import 'package:sole/utils/helpers/helper_functions.dart';
import 'features/dashboard/pages/dashboard/dashboard_screen.dart';
import 'features/dashboard/pages/expense/expense_screen.dart';
import 'features/dashboard/pages/invoices/invoices_screen.dart';
import 'features/dashboard/pages/profile/profile_screen.dart';
import 'features/dashboard/pages/reports/reports_screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final bool dark = UHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Obx(() => controller.screens[controller.selectedIndex.value]),

      bottomNavigationBar: Obx(
        () => NavigationBar(
          elevation: 0,
          height: 72,
          backgroundColor: dark ? UColors.dark : UColors.light,
          indicatorColor: Colors.transparent,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: controller.onMenuTap,

          /// 🔹 TEXT COLOR CONTROL
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
            if (states.contains(WidgetState.selected)) {
              return GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: UColors.primary, // 🔵 selected text
              );
            }
            return GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: UColors.textSecondary, // ⚪ unselected text
            );
          }),

          destinations: [
            _navItem(
              label: "Dashboard",
              selectedIcon: UImages.dashboardIcon,
              unSelectedIcon: UImages.dashboardIconUnSelected,
            ),
            _navItem(
              label: "Invoices",
              selectedIcon: UImages.documentIcon,
              unSelectedIcon: UImages.documentIconUnSelected,
            ),
            _navItem(
              label: "Expense",
              selectedIcon: UImages.dollarIcon,
              unSelectedIcon: UImages.dollarIconUnSelected,
            ),
            _navItem(
              label: "Reports",
              selectedIcon: UImages.chatIcon,
              unSelectedIcon: UImages.chatIconUnSelected,
            ),
            _navItem(
              label: "Profile",
              selectedIcon: UImages.profileIcon,
              unSelectedIcon: UImages.profileIconUnSelected,
            ),
          ],
        ),
      ),
    );
  }

  /// ------------------ Nav Item ------------------
  NavigationDestination _navItem({
    required String label,
    required String selectedIcon,
    required String unSelectedIcon,
  }) {
    return NavigationDestination(
      label: label,

      /// 🔹 Unselected SVG
      icon: SvgPicture.asset(unSelectedIcon, height: 24, width: 24),

      /// 🔹 Selected SVG
      selectedIcon: SvgPicture.asset(selectedIcon, height: 24, width: 24),
    );
  }
}

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();

  RxInt selectedIndex = 0.obs;

  final List<Widget> screens = [
    DashboardScreen(),
    InvoicesScreen(),
    ExpenseScreen(),
    ReportsScreen(),
    ProfileScreen(),
  ];
  void onMenuTap(int index) {
    selectedIndex.value = index;

    // Fetch dashboard data when user navigates to dashboard tab
    if (index == 0) {
      try {
        final dashboardController = Get.find<DashboardController>();
        dashboardController.fetchDashboardData();
      } catch (e) {
        print('⚠️ Dashboard controller not found: $e');
      }
    }
  }
}

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NavigationController());
    Get.put(DashboardController());
    // Get.put(InvoicesController());
    Get.put(ExpenseController());
    Get.put(ReportsController());
    // Get.put(ProfileController());
  }
}
