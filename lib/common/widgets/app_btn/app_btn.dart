import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/utils/constants/colors.dart';
import 'package:sole/utils/helpers/helper_functions.dart';

class UButton extends StatelessWidget {
  final String? label;
  final Function()? onPressed;
  final double? width;
  final bool? isLoading;
  final double height;
  final double textSize;
  final double radius;
  final EdgeInsets margin;
  final bool isButonDisabled;
  final double iconSize;
  final Color? bgColor;
  final Color? textColor;
  final Color? borderColor;
  final bool isBorder;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final MainAxisAlignment mainAxisAlignment;
  final TextStyle? textStyle;
  final Widget? child;

  const UButton({
    super.key,
    this.label,
    this.onPressed,
    this.width,
    this.isButonDisabled = false,
    this.height = 50,
    this.textSize = 16,
    this.child,
    this.radius = 12,
    this.margin = EdgeInsets.zero,
    this.iconSize = 20,
    this.bgColor,
    this.borderColor,
    this.textColor,
    this.isBorder = false,
    this.suffixIcon,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.prefixIcon,
    this.textStyle,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      color: bgColor ?? UColors.primary,
      minWidth: width ?? MediaQuery.of(context).size.width,
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      disabledColor: const Color(0xffa0a0a0),
      disabledElevation: 0,
      highlightElevation: 0,
      splashColor: Colors.white.withOpacity(0.2),
      highlightColor: Colors.white.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: borderColor ?? Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
      onPressed: onPressed,
      child: child ??
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: mainAxisAlignment,
            children: [
              if (prefixIcon != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: prefixIcon!,
                ),
              isLoading == true
                  ?  CircularProgressIndicator(color: UHelperFunctions.getColor('White'))
                  : Text(
                label ?? "",
                textAlign: TextAlign.center,
                softWrap: false,
                maxLines: 1,
                style: textStyle ??
                    GoogleFonts.plusJakartaSans(
                      color: textColor ?? UColors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
              ),
              if (suffixIcon != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: suffixIcon!,
                ),
            ],
          ),
    );
  }
}