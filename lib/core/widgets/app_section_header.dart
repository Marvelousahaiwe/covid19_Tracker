import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppSectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const AppSectionHeader({
    super.key,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            gradient: AppColors.brandGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: AppDimens.paddingSM),
        Expanded(
          child: Text(title, style: AppTextStyles.titleLarge),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}
