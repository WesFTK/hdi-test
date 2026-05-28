import 'package:flutter/material.dart';
import 'package:hdi_test/core/theme/app_typography.dart';
import 'package:hdi_test/utils/extensions/build_context_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hdi_test/models/member_model.dart';
import 'package:hdi_test/utils/utils_function.dart';

class MemberInfoCard extends StatelessWidget {
  final MemberModel member;
  const MemberInfoCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.primary, cs.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundColor: Colors.white.withValues(alpha: 0.2),
                child: Text(
                  member.name.substring(0, 1).toUpperCase(),
                  style: AppTypography.memberAvatar.copyWith(color: Colors.white),
                ),
              ),
              Gap(14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.name,
                      style: AppTypography.memberName.copyWith(color: Colors.white),
                    ),
                    Text(
                      member.id,
                      style: AppTypography.captionMedium.copyWith(color: Colors.white.withValues(alpha: 0.8)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  member.membershipStatus,
                  style: AppTypography.badge.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          Gap(16.h),
          Row(
            children: [
              _InfoItem(icon: Icons.location_on_outlined, text: member.city),
              Gap(20.w),
              _InfoItem(
                icon: Icons.calendar_today_outlined,
                text: 'Since ${UtilsFunction.formatDate(member.joinDate, pattern: 'MMM yyyy')}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.7), size: 14.sp),
        Gap(4.w),
        Text(
          text,
          style: context.textTheme.bodySmall?.copyWith(color: Colors.white.withValues(alpha: 0.85)),
        ),
      ],
    );
  }
}
