import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const AppErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.wifi_off_rounded,
                color: AppColors.error,
                size: 36,
              ),
            ),
            const SizedBox(height: AppDimens.paddingLG),
            Text(
              'Something went wrong',
              style: AppTextStyles.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimens.paddingSM),
            Text(
              message,
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppDimens.paddingLG),
              _RetryButton(onPressed: onRetry!),
            ],
          ],
        ),
      ),
    );
  }
}

class _RetryButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _RetryButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.paddingXL,
          vertical: AppDimens.paddingMD,
        ),
        decoration: BoxDecoration(
          gradient: AppColors.brandGradient,
          borderRadius: BorderRadius.circular(AppDimens.radiusXL),
          boxShadow: [
            BoxShadow(
              color: AppColors.gradientStart.withValues(alpha: 0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Text(
          'Try Again',
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.white,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
