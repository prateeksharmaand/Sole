import 'package:flutter/material.dart';
import 'package:sole/utils/constants/colors.dart';

class USwitchTheme {
  USwitchTheme._();

  /// ---------------- Light Switch Theme ----------------
  static SwitchThemeData lightSwitchTheme = SwitchThemeData(
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

    thumbColor: MaterialStateProperty.resolveWith((states) {
      return UColors.white; // thumb always white
    }),

    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return UColors.primary; // ON (blue)
      }
      return UColors.borderBtn; // OFF (grey)
    }),

    trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
  );


  /// ---------------- Dark Switch Theme ----------------
  static SwitchThemeData darkSwitchTheme = SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return UColors.white;
      }
      return UColors.white;
    }),

    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return UColors.primary;
      }
      return UColors.darkGrey;
    }),

    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return UColors.primary;
      }
      return UColors.darkGrey;
    }),
  );
}
