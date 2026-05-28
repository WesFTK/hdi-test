import 'package:flutter/material.dart';
import 'package:hdi_test/utils/extensions/build_context_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthAppIcon extends StatelessWidget {
  const AuthAppIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    return Container(
      width: 56.w,
      height: 56.w,
      decoration: BoxDecoration(
        color: cs.primary,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Icon(Icons.dashboard_rounded, color: cs.onPrimary, size: 28.sp),
    );
  }
}
