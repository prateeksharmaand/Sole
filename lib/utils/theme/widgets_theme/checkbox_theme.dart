import 'package:flutter/material.dart';
import 'package:sole/utils/helpers/device_helpers.dart';
import 'package:sole/utils/helpers/helper_functions.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';


class UCheckboxTheme {
  UCheckboxTheme._();


  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(USizes.xs)),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return UColors.white;
      } else {
        return UColors.textSecondary;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.green;
      } else {
        return Colors.transparent;
      }
    }),
  );


  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(USizes.xs)),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return UColors.white;
      } else {
        return UColors.black;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return UColors.primary;
      } else {
        return Colors.transparent;
      }
    }),
  );
}
