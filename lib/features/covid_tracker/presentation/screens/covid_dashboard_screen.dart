import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/app_formatter.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../bloc/covid_bloc.dart';
import '../bloc/covid_event.dart';
import '../bloc/covid_state.dart';
import '../widgets/case_distribution_chart.dart';
import '../widgets/daily_cases_chart.dart';
import '../widgets/stat_card.dart';

class CovidDashboardScreen extends StatefulWidget {
  const CovidDashboardScreen({super.key});

  @override
  State<CovidDashboardScreen> createState() => _CovidDashboardScreenState();
}

class _CovidDashboardScreenState extends State<CovidDashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CovidBloc>().add(const LoadCovidData());
  }

  void _refresh() {
    HapticFeedback.lightImpact();
    context.read<CovidBloc>().add(const RefreshCovidData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (_, __) => [_buildAppBar()],
          body: BlocBuilder<CovidBloc, CovidState>(
            builder: (context, state) {
              if (state is CovidLoading || state is CovidInitial) {
                return const DashboardShimmer();
              }
              if (state is CovidError) {
                return AppErrorWidget(
                  message: state.message,
                  onRetry: _refresh,
                );
              }
              if (state is CovidLoaded) {
                return _DashboardBody(state: state, onRefresh: _refresh);
              }
              return const DashboardShimmer();
            },
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 120,
      collapsedHeight: 80,
      backgroundColor: AppColors.scaffoldBg,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsetsDirectional.fromSTEB(
          AppDimens.paddingMD,
          0,
          AppDimens.paddingMD,
          AppDimens.paddingMD,
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(right: 6, bottom: 1),
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                ),
                Text(
                  'LIVE DATA',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.success,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppColors.brandGradient.createShader(bounds),
              child: Text(
                'COVID-19 Tracker',
                style: AppTextStyles.headlineMedium.copyWith(
                  color: AppColors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
        background: Container(color: AppColors.scaffoldBg),
      ),
      actions: [
        _RefreshButton(onPressed: _refresh),
        const SizedBox(width: AppDimens.paddingSM),
      ],
    );
  }
}

class _DashboardBody extends StatelessWidget {
  final CovidLoaded state;
  final VoidCallback onRefresh;

  const _DashboardBody({required this.state, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final summary = state.summary;
    final total = summary.confirmed;

    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      color: AppColors.gradientStart,
      backgroundColor: AppColors.cardBg,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppDimens.paddingMD,
          AppDimens.paddingMD,
          AppDimens.paddingMD,
          AppDimens.paddingXL,
        ),
        children: [
          _LastUpdatedBadge(fetchedAt: state.fetchedAt),
          const SizedBox(height: AppDimens.paddingLG),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: AppDimens.paddingMD,
            mainAxisSpacing: AppDimens.paddingMD,
            childAspectRatio: 0.9,
            children: [
              StatCard(
                label: 'CONFIRMED',
                value: summary.confirmed,
                percentage: 100,
                accentColor: AppColors.confirmed,
                icon: Icons.coronavirus_outlined,
              ),
              StatCard(
                label: 'ACTIVE',
                value: summary.active,
                percentage: summary.activePercent,
                accentColor: AppColors.active,
                icon: Icons.local_hospital_outlined,
              ),
              StatCard(
                label: 'RECOVERED',
                value: summary.recovered,
                percentage: summary.recoveredPercent,
                accentColor: AppColors.recovered,
                icon: Icons.favorite_border_rounded,
              ),
              StatCard(
                label: 'DEATHS',
                value: summary.deaths,
                percentage: summary.deathsPercent,
                accentColor: AppColors.deaths,
                icon: Icons.monitor_heart_outlined,
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingLG),

          DailyCasesChart(data: state.historicalData),
          const SizedBox(height: AppDimens.paddingLG),

          CaseDistributionChart(summary: summary),
          const SizedBox(height: AppDimens.paddingLG),

          _GlobalTotalBanner(total: total),
        ],
      ),
    );
  }
}

class _RefreshButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _RefreshButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(AppDimens.paddingSM),
        decoration: BoxDecoration(
          gradient: AppColors.brandGradient,
          borderRadius: BorderRadius.circular(AppDimens.radiusMD),
          boxShadow: [
            BoxShadow(
              color: AppColors.gradientStart.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Icon(
          Icons.refresh_rounded,
          color: AppColors.white,
          size: 20,
        ),
      ),
    );
  }
}

class _LastUpdatedBadge extends StatelessWidget {
  final DateTime fetchedAt;

  const _LastUpdatedBadge({required this.fetchedAt});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.access_time_rounded,
          size: 13,
          color: AppColors.textMuted,
        ),
        const SizedBox(width: 4),
        Text(
          'Updated at ${fetchedAt.hour.toString().padLeft(2, '0')}:'
          '${fetchedAt.minute.toString().padLeft(2, '0')}',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textMuted,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class _GlobalTotalBanner extends StatelessWidget {
  final int total;

  const _GlobalTotalBanner({required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingLG),
      decoration: BoxDecoration(
        gradient: AppColors.brandGradient,
        borderRadius: BorderRadius.circular(AppDimens.radiusLG),
        boxShadow: [
          BoxShadow(
            color: AppColors.gradientStart.withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.public_rounded, color: AppColors.white, size: 32),
          const SizedBox(width: AppDimens.paddingMD),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Global Confirmed Cases',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.white.withValues(alpha: 0.8),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                AppFormatter.full(total),
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
