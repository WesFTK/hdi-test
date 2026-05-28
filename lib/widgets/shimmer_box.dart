import 'package:flutter/material.dart';
import 'package:hdi_test/utils/extensions/build_context_extension.dart';
import 'package:hdi_test/core/theme/app_theme_extension.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerBox({super.key, this.width = double.infinity, required this.height, this.borderRadius = 8});

  @override
  Widget build(BuildContext context) {
    final ext = AppThemeExtension.of(context);
    return Shimmer.fromColors(
      baseColor: ext.shimmerBase,
      highlightColor: ext.shimmerHighlight,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
