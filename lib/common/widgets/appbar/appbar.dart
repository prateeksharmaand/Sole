import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/images.dart';
import '../../../utils/helpers/device_helpers.dart';

class UAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UAppBar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.showDivider = true,
    this.centerTitle = false, this.backgroundColor,
  });

  final Widget? title;
  final bool showBackArrow;
  final bool? centerTitle;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final bool showDivider;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: backgroundColor ?? UColors.white,
       centerTitle: centerTitle,
      /// Leading
      leading: showBackArrow
          ? IconButton(
        onPressed: Get.back,
        icon: SvgPicture.asset(UImages.arrowLeft),
      )
          : leadingIcon != null
          ? IconButton(
        onPressed: leadingOnPressed,
        icon: Icon(
          leadingIcon,
          color: UColors.textSecondary,
        ),
      )
          : null,

      /// Title
      title: title,

      /// Actions
      actions: actions,

      /// 🔹 Bottom Divider
      bottom: showDivider
          ? PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(
          height: 1,
          thickness: 1,
          color: UColors.borderBtn.withOpacity(0.6),
        ),
      )
          : null,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(UDeviceHelper.getAppBarHeight() + 1);
}

// class UAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const UAppBar(
//       {super.key, this.title, this.showBackArrow = false, this.leadingIcon, this.actions, this.leadingOnPressed});
//
//   final Widget? title;
//   final bool showBackArrow;
//   final IconData? leadingIcon;
//   final List<Widget>? actions;
//   final VoidCallback? leadingOnPressed;
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Padding(
//       padding: EdgeInsets.only(left: USizes.sm),
//       child: AppBar(
//         automaticallyImplyLeading: false,
//
//         /// Leading
//         leading: showBackArrow
//             ? IconButton(onPressed: Get.back, icon: Icon(Icons.arrow_back_outlined, color: UColors.textSecondary))
//             : leadingIcon != null
//             ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon))
//             : null,
//
//         /// Title
//         title: title,
//
//         /// Actions
//         actions: actions,
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(UDeviceHelper.getAppBarHeight());
// }