import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

// ignore: constant_identifier_names
enum FontType { BOLD, SEMI_BOLD, MEDIUM, REGULAR, LIGHT }

class AppTextStyles {

  static FontWeight fontType(FontType fontType) {
    switch (fontType) {
      case FontType.BOLD:
        return FontWeight.w700;
      case FontType.SEMI_BOLD:
        return FontWeight.w600;
      case FontType.MEDIUM:
        return FontWeight.w500;
      case FontType.REGULAR:
        return FontWeight.w400;
      case FontType.LIGHT:
        return FontWeight.w300;
    }
  }

  static TextStyle? textStyle({
    FontType? fontType,
    Color? color,
    double? size,
  }) {
    return TextStyle(
      color: color ?? AppColor.appWhite,
      fontSize: size,
      fontWeight: AppTextStyles.fontType(fontType!),
    );
  }

  static TextStyle? s8({Color? color, required FontType fontType}) =>
      AppTextStyles.textStyle(
        size: 8.sp,
        color: color,
        fontType: fontType,
      );

  static TextStyle? s10({Color? color, required FontType fontType}) =>
      AppTextStyles.textStyle(
        size: 10.5.sp,
        color: color,
        fontType: fontType,
      );

  static TextStyle? s12({Color? color, required FontType fontType}) =>
      AppTextStyles.textStyle(
        size: 12.sp,
        color: color,
        fontType: fontType,
      );

  static TextStyle? s14({Color? color, required FontType fontType}) =>
      AppTextStyles.textStyle(
        size: 14.sp,
        color: color,
        fontType: fontType,
      );

  static TextStyle? s16({Color? color, required FontType fontType}) =>
      AppTextStyles.textStyle(
        size: 16.sp,
        color: color ?? AppColor.appWhite,
        fontType: fontType,
      );

  static TextStyle? s18({Color? color, required FontType fontType}) =>
      AppTextStyles.textStyle(
        size: 18.sp,
        color: color ?? AppColor.appWhite,
        fontType: fontType,
      );

  static TextStyle? s20({Color? color, required FontType fontType}) =>
      AppTextStyles.textStyle(
        size: 20.sp,
        color: color ?? AppColor.appWhite,
        fontType: fontType,
      );

  static TextStyle? s24({Color? color, required FontType fontType}) =>
      AppTextStyles.textStyle(
        size: 24.sp,
        color: color ?? AppColor.appWhite,
        fontType: fontType,
      );

}
