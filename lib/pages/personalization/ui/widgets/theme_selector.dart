import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hdi_test/core/theme/theme_cubit.dart';
import 'package:hdi_test/utils/extensions/build_context_extension.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;

    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, current) {
        final options = [
          (ThemeMode.system, 'System default', Icons.brightness_auto_rounded),
          (ThemeMode.light, 'Light', Icons.light_mode_rounded),
          (ThemeMode.dark, 'Dark', Icons.dark_mode_rounded),
        ];

        return Container(
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: cs.outline.withValues(alpha: 0.4),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              for (int i = 0; i < options.length; i++) ...[
                if (i > 0)
                  Divider(
                    height: 1,
                    thickness: 0.5,
                    color: cs.outline.withValues(alpha: 0.4),
                    indent: 16.w,
                    endIndent: 16.w,
                  ),
                ThemeOptionTile(
                  icon: options[i].$3,
                  label: options[i].$2,
                  selected: current == options[i].$1,
                  onTap: () =>
                      context.read<ThemeCubit>().setMode(options[i].$1),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class ThemeOptionTile extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;

  const ThemeOptionTile({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    final tt = context.textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 20.sp,
                color: selected ? cs.primary : cs.onSurfaceVariant,
              ),
              Gap(12.w),
            ],
            Expanded(
              child: Text(
                label,
                style: tt.bodyMedium?.copyWith(
                  color: selected ? cs.primary : cs.onSurface,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: selected
                  ? Icon(
                      Icons.check_rounded,
                      key: const ValueKey('check'),
                      size: 18.sp,
                      color: cs.primary,
                    )
                  : SizedBox(key: const ValueKey('empty'), width: 18.sp),
            ),
          ],
        ),
      ),
    );
  }
}
