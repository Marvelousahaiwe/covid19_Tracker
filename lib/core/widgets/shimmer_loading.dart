import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/app_theme.dart';

class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.radius = AppDimens.radiusMD,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.surfaceDark,
      highlightColor: AppColors.cardBg,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppDimens.paddingMD,
          AppDimens.paddingMD,
          AppDimens.paddingMD,
          AppDimens.paddingXL,
        ),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const ShimmerBox(width: 140, height: 14, radius: 6),
          const SizedBox(height: AppDimens.paddingLG),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: AppDimens.paddingMD,
            mainAxisSpacing: AppDimens.paddingMD,
            childAspectRatio: 0.9,
            children: List.generate(4, (_) => const _StatCardShimmer()),
          ),
          const SizedBox(height: AppDimens.paddingLG),

          const _ChartCardShimmer(height: 270),
          const SizedBox(height: AppDimens.paddingLG),

          const _ChartCardShimmer(height: 220),
          const SizedBox(height: AppDimens.paddingLG),

          const ShimmerBox(
            width: double.infinity,
            height: 72,
            radius: AppDimens.radiusLG,
          ),
        ],
      ),
    );
  }
}

class _StatCardShimmer extends StatelessWidget {
  const _StatCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppDimens.radiusLG),
        border: Border.all(color: AppColors.divider, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerBox(width: 40, height: 40),
          const SizedBox(height: AppDimens.paddingMD),
          const ShimmerBox(width: 80, height: 24, radius: 4),
          const SizedBox(height: AppDimens.paddingXS),
          const ShimmerBox(width: 110, height: 12, radius: 4),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ShimmerBox(width: 60, height: 10, radius: 4),
              ShimmerBox(
                width: 38,
                height: 18,
                radius: AppDimens.radiusSM,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChartCardShimmer extends StatelessWidget {
  final double height;

  const _ChartCardShimmer({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingLG),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppDimens.radiusLG),
        border: Border.all(color: AppColors.divider, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerBox(width: 160, height: 16, radius: 4),
          const SizedBox(height: AppDimens.paddingLG),
          ShimmerBox(
            width: double.infinity,
            height: height - AppDimens.paddingLG * 2 - 16 - AppDimens.paddingLG,
            radius: AppDimens.radiusMD,
          ),
        ],
      ),
    );
  }
}
