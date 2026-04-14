import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/app_formatter.dart';
import '../../../../core/widgets/app_card.dart';

class StatCard extends StatelessWidget {
  final String label;
  final int value;
  final double percentage;
  final Color accentColor;
  final IconData icon;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.percentage,
    required this.accentColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppDimens.paddingMD),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppDimens.radiusMD),
            ),
            child: Icon(icon, color: accentColor, size: 20),
          ),
          const SizedBox(height: AppDimens.paddingMD),

          Text(
            AppFormatter.compact(value),
            style: AppTextStyles.statValue.copyWith(color: accentColor),
          ),
          const SizedBox(height: AppDimens.paddingXS),

          Text(
            AppFormatter.full(value),
            style: AppTextStyles.bodySmall,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  label,
                  style: AppTextStyles.labelMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  AppFormatter.percent(percentage),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: accentColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
