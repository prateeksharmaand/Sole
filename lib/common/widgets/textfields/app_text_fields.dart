import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sole/utils/constants/colors.dart';

class UTextField extends StatefulWidget {
  final String? titleText;
  final TextStyle? textstyle;
  final TextEditingController? controller;
  final int? maxLines;
  final bool? isReadOnly;
  final bool? isEnabled;
  final int? maxLength;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onchanged;
  final FormFieldValidator? validator;
  final Function()? onTap;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefix;
  final Widget? prefixWidget;
  final Widget? suffix;
  final TextAlign? textAlign;
  final bool? autoValidate;
  final EdgeInsets? contentPadding;
  final bool? isCapital;
  final bool? isFilled;
  final ValueChanged<String>? onFieldSubmitted;
  final double? borderRadius;
  final Color? borderColor;
  final Color? fillColor;
  final String? labelText;
  final Color? prefixColor;
  final Color? cursorColor;
  final double? height;
  final double? width;

  const UTextField({
    super.key,
    this.titleText,
    this.textstyle,
    this.controller,
    this.maxLines,
    this.isReadOnly = false,
    this.isEnabled,
    this.maxLength,
    this.obscureText = false,
    this.keyboardType,
    this.onchanged,
    this.validator,
    this.onTap,
    this.hintText,
    this.hintTextStyle,
    this.inputFormatters,
    this.prefix,
    this.prefixWidget,
    this.suffix,
    this.textAlign,
    this.autoValidate = false,
    this.contentPadding,
    this.isCapital,
    this.onFieldSubmitted,
    this.isFilled = true,
    this.borderRadius = 10,
    this.borderColor = UColors.borderBtn,
    this.fillColor = UColors.white,
    this.labelText,
    this.prefixColor = UColors.white,
    this.cursorColor,
    this.height = 50,
    this.width = double.infinity,
  });

  @override
  State<UTextField> createState() => _UTextFieldState();
}

class _UTextFieldState extends State<UTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.titleText != null && widget.titleText!.isNotEmpty) ...[
          Text(
            widget.titleText!,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              color: Theme.of(context).textTheme.bodySmall!.color!,
            ),
          ),
          const SizedBox(height: 6),
        ],
        SizedBox(
          width: widget.width,
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius!),
              boxShadow: _focusNode.hasFocus
                  ? [
                      BoxShadow(
                        color: UColors.primary.withOpacity(0.35),
                        blurRadius: 0,
                        spreadRadius: 4,
                      ),
                    ]
                  : [],
            ),
            child: TextFormField(
              controller: widget.controller,
              focusNode: _focusNode,
              inputFormatters: widget.inputFormatters,
              style:
                  widget.textstyle ??
                  GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    color: UColors.textPrimary,
                  ),
              maxLines: widget.maxLines ?? 1,
              readOnly: widget.isReadOnly!,
              enabled: widget.isEnabled,
              maxLength: widget.maxLength,
              obscureText: widget.obscureText!,
              keyboardType: widget.keyboardType ?? TextInputType.text,
              textAlign: widget.textAlign ?? TextAlign.start,
              cursorColor: widget.cursorColor ?? UColors.textPrimary,
              onChanged: widget.onchanged ?? (val) {},
              onTap: widget.onTap ?? () {},
              onFieldSubmitted: widget.onFieldSubmitted,
              validator: widget.validator,
              autovalidateMode: widget.autoValidate!
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              decoration: InputDecoration(
                errorMaxLines: 5,
                filled: widget.isFilled,
                fillColor: widget.fillColor,
                contentPadding:
                    widget.contentPadding ??
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                hintText: widget.hintText,
                hintStyle:
                    widget.hintTextStyle ??
                    GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      color: UColors.textSecondary,
                    ),
                labelText: widget.labelText,
                labelStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  letterSpacing: -0.1,
                  fontSize: 14,
                  color: UColors.textPrimary.withOpacity(0.24),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    widget.maxLines == null ? widget.borderRadius! : 8,
                  ),
                  borderSide: BorderSide(color: widget.borderColor!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    widget.maxLines == null ? widget.borderRadius! : 8,
                  ),
                  borderSide: BorderSide(color: widget.borderColor!, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    widget.maxLines == null ? widget.borderRadius! : 8,
                  ),
                  borderSide: BorderSide(color: UColors.primary, width: 2),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    widget.maxLines == null ? widget.borderRadius! : 8,
                  ),
                  borderSide: const BorderSide(color: Colors.green),
                ),
                prefixIcon:
                    widget.prefixWidget ??
                    (widget.prefix == null
                        ? null
                        : Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              top: 10,
                              bottom: 10,
                              right: 6,
                            ),
                            child: SvgPicture.asset(
                              widget.prefix!,
                              width: 30,
                              height: 30,
                              colorFilter: ColorFilter.mode(
                                widget.prefixColor!,
                                BlendMode.srcIn,
                              ),
                            ),
                          )),
                prefixIconConstraints: const BoxConstraints(
                  minHeight: 15,
                  minWidth: 15,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: widget.suffix,
                ),
                suffixIconConstraints: const BoxConstraints(
                  minHeight: 20,
                  minWidth: 20,
                ),
                counterText: "",
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class UTextField2 extends StatefulWidget {
  final String? titleText;
  final TextStyle? textstyle;
  final TextEditingController? controller;
  final int? maxLines;
  final bool? isReadOnly;
  final bool? isEnabled;
  final int? maxLength;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onchanged;
  final FormFieldValidator? validator;
  final Function()? onTap;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefix;
  final Widget? prefixWidget;
  final Widget? suffix;
  final TextAlign? textAlign;
  final bool? autoValidate;
  final EdgeInsets? contentPadding;
  final bool? isCapital;
  final bool? isFilled;
  final ValueChanged<String>? onFieldSubmitted;
  final double? borderRadius;
  final Color? borderColor;
  final Color? fillColor;
  final String? labelText;
  final Color? prefixColor;
  final Color? cursorColor;
  final double? height;
  final double? width;

  const UTextField2({
    super.key,
    this.titleText,
    this.textstyle,
    this.controller,
    this.maxLines,
    this.isReadOnly = false,
    this.isEnabled,
    this.maxLength,
    this.obscureText = false,
    this.keyboardType,
    this.onchanged,
    this.validator,
    this.onTap,
    this.hintText,
    this.hintTextStyle,
    this.inputFormatters,
    this.prefix,
    this.prefixWidget,
    this.suffix,
    this.textAlign,
    this.autoValidate = false,
    this.contentPadding,
    this.isCapital,
    this.onFieldSubmitted,
    this.isFilled = true,
    this.borderRadius = 10,
    this.borderColor = UColors.borderBtn,
    this.fillColor = UColors.white,
    this.labelText,
    this.prefixColor = UColors.white,
    this.cursorColor,
    this.height = 50,
    this.width = double.infinity,
  });

  @override
  State<UTextField2> createState() => _UTextField2State();
}

class _UTextField2State extends State<UTextField2> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.titleText != null && widget.titleText!.isNotEmpty) ...[
          Text(
            widget.titleText!,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: UColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
        ],
        SizedBox(
          width: widget.width,
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            inputFormatters: widget.inputFormatters,
            style:
                widget.textstyle ??
                GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: UColors.textPrimary,
                ),
            maxLines: widget.maxLines ?? 1,
            readOnly: widget.isReadOnly!,
            enabled: widget.isEnabled,
            maxLength: widget.maxLength,
            obscureText: widget.obscureText!,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            textAlign: widget.textAlign ?? TextAlign.start,
            cursorColor: widget.cursorColor ?? UColors.textPrimary,
            onChanged: widget.onchanged ?? (val) {},
            onTap: widget.onTap ?? () {},
            onFieldSubmitted: widget.onFieldSubmitted,
            validator: widget.validator,
            autovalidateMode: widget.autoValidate!
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            decoration: InputDecoration(
              filled: false,
              counterText: "",
              contentPadding: const EdgeInsets.symmetric(vertical: 10),

              /// Floating Label
              labelText: widget.labelText,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelStyle: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: UColors.textSecondary,
              ),
              floatingLabelStyle: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: UColors.primary,
                fontWeight: FontWeight.w500,
              ),

              /// Hint
              hintText: widget.hintText,
              hintStyle: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                color: UColors.textSecondary.withOpacity(0.6),
              ),

              /// 🔹 PREFIX (same as UTextField)
              prefixIcon:
                  widget.prefixWidget ??
                  (widget.prefix == null
                      ? null
                      : Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            top: 10,
                            bottom: 10,
                            right: 6,
                          ),
                          child: SvgPicture.asset(
                            widget.prefix!,
                            width: 22,
                            height: 22,
                            colorFilter: ColorFilter.mode(
                              widget.prefixColor!,
                              BlendMode.srcIn,
                            ),
                          ),
                        )),
              prefixIconConstraints: const BoxConstraints(
                minHeight: 15,
                minWidth: 15,
              ),

              /// 🔹 SUFFIX (same as UTextField)
              suffixIcon: widget.suffix == null
                  ? null
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: widget.suffix,
                    ),
              suffixIconConstraints: const BoxConstraints(
                minHeight: 20,
                minWidth: 20,
              ),

              /// Underline Borders
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: UColors.borderBtn, width: 1),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: UColors.primary, width: 2),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// class UTextField extends StatelessWidget {
//   final String? titleText;
//   final TextStyle? textstyle;
//   final TextEditingController? controller;
//   final int? maxLines;
//   final bool? isReadOnly;
//   final bool? isEnabled;
//   final int? maxLength;
//   final bool? obscureText;
//   final TextInputType? keyboardType;
//   final Function(String)? onchanged;
//   final FormFieldValidator? validator;
//   final Function()? onTap;
//   final String? hintText;
//   final TextStyle? hintTextStyle;
//   final List<TextInputFormatter>? inputFormatters;
//   final String? prefix;
//   final Widget? prefixWidget;
//   final Widget? suffix;
//   final TextAlign? textAlign;
//   final bool? autoValidate;
//   final EdgeInsets? contentPadding;
//   final bool? isCapital;
//   final bool? isFilled;
//   final ValueChanged<String>? onFieldSubmitted;
//   final double? borderRadius;
//   final Color? borderColor;
//   final Color? fillColor;
//   final String? labelText;
//   final Color? prefixColor;
//   final Color? cursorColor;
//   final double? height;
//   final double? width;
//
//   const UTextField({
//     super.key,
//     this.titleText,
//     this.textstyle,
//     this.controller,
//     this.maxLines,
//     this.isReadOnly = false,
//     this.isEnabled,
//     this.maxLength,
//     this.obscureText = false,
//     this.keyboardType,
//     this.onchanged,
//     this.validator,
//     this.onTap,
//     this.hintText,
//     this.hintTextStyle,
//     this.inputFormatters,
//     this.prefix,
//     this.prefixWidget,
//     this.suffix,
//     this.textAlign,
//     this.autoValidate = false,
//     this.contentPadding,
//     this.isCapital,
//     this.onFieldSubmitted,
//     this.isFilled = true,
//     this.borderRadius = 10,
//     this.borderColor = UColors.borderBtn,
//     this.fillColor = UColors.white,
//     this.labelText,
//     this.prefixColor = UColors.white,
//     this.cursorColor,
//     this.height = 50,
//     this.width = double.infinity,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (titleText != null && titleText!.isNotEmpty) ...[
//           Text(
//             titleText!,
//             style: GoogleFonts.plusJakartaSans(
//               fontSize: 12,
//               color: Theme.of(context).textTheme.bodySmall!.color!,
//             ),
//           ),
//           SizedBox(
//             height: 6,
//           )
//         ] else ...[
//           const SizedBox.shrink(),
//         ],
//         SizedBox(
//           width: width,
//           child: TextFormField(
//             controller: controller,
//             inputFormatters: inputFormatters,
//
//             style: textstyle ??
//                 GoogleFonts.plusJakartaSans(
//                   fontSize: 14,
//                   color: UColors.textPrimary,
//                 ),
//             maxLines: maxLines ?? 1,
//             readOnly: isReadOnly!,
//             enabled: isEnabled,
//             maxLength: maxLength,
//             obscureText: obscureText!,
//             decoration: InputDecoration(
//                 errorMaxLines: 5,
//                 filled: isFilled,
//                 fillColor: fillColor,
//                 contentPadding: contentPadding ??
//                     EdgeInsets.only(
//                       left: 15,
//                       top: 10,
//                       right: 15,
//                       bottom: 10,
//                     ),
//                 hintText: hintText,
//                 hintStyle: hintTextStyle ??
//                     GoogleFonts.plusJakartaSans(
//                       fontSize: 13,
//                       color: UColors.textSecondary,
//                     ),
//                 labelText: labelText,
//                 labelStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
//                   letterSpacing: -0.1,
//                   fontSize: 14,
//                   color: UColors.textPrimary.withOpacity(0.24),
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(maxLines == null ? borderRadius! : 8),
//                   borderSide: isFilled! ? BorderSide(width: 1.0, color: borderColor!) : BorderSide.none,
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(maxLines == null ? borderRadius! : 8),
//                   borderSide: isFilled! ? BorderSide(width: 1.0, color: borderColor!) : BorderSide.none,
//                 ),
//                 disabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(maxLines == null ? borderRadius! : 8),
//                   borderSide: isFilled! ? BorderSide(width: 1.0, color: borderColor!) : BorderSide.none,
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(maxLines == null ? borderRadius! : 8),
//                   borderSide: isFilled! ? BorderSide(width: 1.0, color: borderColor!) : BorderSide.none,
//                 ),
//                 prefixIcon: prefixWidget ??
//                     (prefix == null
//                         ? null
//                         : Padding(
//                       padding: const EdgeInsets.only(left: 10, top: 10.0, bottom: 10, right: 6),
//                       child: SvgPicture.asset(
//                         prefix!,
//                         width: 30,
//                         height: 30,
//                         colorFilter: ColorFilter.mode(prefixColor!, BlendMode.srcIn),
//                       ),
//                     )),
//                 prefixIconConstraints: BoxConstraints(minHeight: 15, minWidth: 15),
//                 suffixIcon: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   child: suffix,
//                 ),
//                 suffixIconConstraints: BoxConstraints(
//                   minHeight: 20,
//                   minWidth: 20,
//                 ),
//                 counterText: ""),
//             keyboardType: keyboardType ?? TextInputType.text,
//             cursorColor: cursorColor ?? UColors.textPrimary,
//             onChanged: onchanged ?? (val) {},
//             onTap: onTap ?? () {},
//             validator: validator,
//             autovalidateMode: autoValidate! ? AutovalidateMode.onUserInteraction : AutovalidateMode.onUserInteraction,
//           ),
//         ),
//       ],
//     );
//   }
// }
