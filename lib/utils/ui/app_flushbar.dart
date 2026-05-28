import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hdi_test/utils/extensions/build_context_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppFlushbar {
  static Future<void> showError(BuildContext context, String message) {
    final cs = context.colorScheme;
    return Flushbar(
      message: message,
      icon: Icon(Icons.error_outline_rounded, color: cs.onError, size: 24.r),
      backgroundColor: cs.error,
      messageColor: cs.onError,
      duration: const Duration(seconds: 3),
      margin: EdgeInsets.all(12.r),
      borderRadius: BorderRadius.circular(12.r),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  static Future<void> showSuccess(BuildContext context, String message) {
    final cs = context.colorScheme;
    return Flushbar(
      message: message,
      icon: Icon(Icons.check_circle_outline_rounded, color: cs.onTertiary, size: 24.r),
      backgroundColor: cs.tertiary,
      messageColor: cs.onTertiary,
      duration: const Duration(seconds: 3),
      margin: EdgeInsets.all(12.r),
      borderRadius: BorderRadius.circular(12.r),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  static Future<void> showInfo(BuildContext context, String message) {
    final cs = context.colorScheme;
    return Flushbar(
      message: message,
      icon: Icon(Icons.info_outline_rounded, color: cs.onSecondaryContainer, size: 24.r),
      backgroundColor: cs.secondaryContainer,
      messageColor: cs.onSecondaryContainer,
      duration: const Duration(seconds: 3),
      margin: EdgeInsets.all(12.r),
      borderRadius: BorderRadius.circular(12.r),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }
}
