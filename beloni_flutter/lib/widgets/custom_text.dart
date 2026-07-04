import 'package:flutter/material.dart';
import '../core/theme/app_typography.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const CustomText(
    this.text, {
    super.key,
    required this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  factory CustomText.h1(String text, {TextAlign? textAlign, Color? color, int? maxLines, TextOverflow? overflow}) => CustomText(text, style: AppTypography.h1.copyWith(color: color), textAlign: textAlign, maxLines: maxLines, overflow: overflow);
  factory CustomText.h2(String text, {TextAlign? textAlign, Color? color, int? maxLines, TextOverflow? overflow}) => CustomText(text, style: AppTypography.h2.copyWith(color: color), textAlign: textAlign, maxLines: maxLines, overflow: overflow);
  factory CustomText.h3(String text, {TextAlign? textAlign, Color? color, int? maxLines, TextOverflow? overflow}) => CustomText(text, style: AppTypography.h3.copyWith(color: color), textAlign: textAlign, maxLines: maxLines, overflow: overflow);
  factory CustomText.h4(String text, {TextAlign? textAlign, Color? color, int? maxLines, TextOverflow? overflow}) => CustomText(text, style: AppTypography.h4.copyWith(color: color), textAlign: textAlign, maxLines: maxLines, overflow: overflow);
  factory CustomText.h5(String text, {TextAlign? textAlign, Color? color, int? maxLines, TextOverflow? overflow}) => CustomText(text, style: AppTypography.h5.copyWith(color: color), textAlign: textAlign, maxLines: maxLines, overflow: overflow);
  factory CustomText.h6(String text, {TextAlign? textAlign, Color? color, int? maxLines, TextOverflow? overflow}) => CustomText(text, style: AppTypography.h6.copyWith(color: color), textAlign: textAlign, maxLines: maxLines, overflow: overflow);
  factory CustomText.t16(String text, {TextAlign? textAlign, Color? color, int? maxLines, TextOverflow? overflow}) => CustomText(text, style: AppTypography.t16.copyWith(color: color), textAlign: textAlign, maxLines: maxLines, overflow: overflow);
  factory CustomText.t14(String text, {TextAlign? textAlign, Color? color, int? maxLines, TextOverflow? overflow, double? fontSize, FontWeight? fontWeight}) => CustomText(text, style: AppTypography.t14.copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight), textAlign: textAlign, maxLines: maxLines, overflow: overflow);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
