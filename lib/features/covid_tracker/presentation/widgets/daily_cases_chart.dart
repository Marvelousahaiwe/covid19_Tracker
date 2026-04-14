import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/app_formatter.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_section_header.dart';
import '../../domain/entities/covid_daily_case.dart';

class DailyCasesChart extends StatefulWidget {
  final List<CovidDailyCase> data;

  const DailyCasesChart({super.key, required this.data});

  @override
  State<DailyCasesChart> createState() => _DailyCasesChartState();
}

class _DailyCasesChartState extends State<DailyCasesChart> {
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) return const SizedBox.shrink();

    final maxY = widget.data
            .map((e) => e.newCases.toDouble())
            .reduce((a, b) => a > b ? a : b) *
        1.2;

    return AppCard(
      padding: const EdgeInsets.fromLTRB(
        AppDimens.paddingMD,
        AppDimens.paddingLG,
        AppDimens.paddingMD,
        AppDimens.paddingSM,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: AppDimens.paddingSM),
            child: AppSectionHeader(title: 'Daily New Cases (Last 7 Days)'),
          ),
          const SizedBox(height: AppDimens.paddingLG),
          SizedBox(
            height: 220,
            child: LineChart(
              _buildChartData(maxY),
              duration: const Duration(milliseconds: 400),
            ),
          ),
        ],
      ),
    );
  }

  LineChartData _buildChartData(double maxY) {
    final spots = widget.data.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.newCases.toDouble());
    }).toList();

    return LineChartData(
      minX: 0,
      maxX: (widget.data.length - 1).toDouble(),
      minY: 0,
      maxY: maxY,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: maxY / 4,
        getDrawingHorizontalLine: (_) => FlLine(
          color: AppColors.divider,
          strokeWidth: 0.8,
        ),
      ),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 52,
            interval: maxY / 4,
            getTitlesWidget: (value, meta) => Text(
              AppFormatter.compact(value.toInt()),
              style: AppTextStyles.bodySmall.copyWith(fontSize: 10),
            ),
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 32,
            getTitlesWidget: (value, meta) {
              final idx = value.toInt();
              if (idx < 0 || idx >= widget.data.length) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  AppFormatter.chartDate(widget.data[idx].date),
                  style: AppTextStyles.bodySmall.copyWith(fontSize: 10),
                ),
              );
            },
          ),
        ),
        rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false)),
      ),
      lineTouchData: LineTouchData(
        touchCallback: (event, response) {
          setState(() {
            _touchedIndex = response?.lineBarSpots?.first.x.toInt() ?? -1;
          });
        },
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (_) => AppColors.surfaceDark,
          tooltipRoundedRadius: AppDimens.radiusMD,
          getTooltipItems: (spots) => spots.map((spot) {
            return LineTooltipItem(
              AppFormatter.full(spot.y.toInt()),
              AppTextStyles.bodySmall.copyWith(
                color: AppColors.gradientStart,
                fontWeight: FontWeight.w700,
              ),
            );
          }).toList(),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          curveSmoothness: 0.35,
          color: AppColors.gradientStart,
          barWidth: 2.5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, bar, index) {
              final isTouched = index == _touchedIndex;
              return FlDotCirclePainter(
                radius: isTouched ? 6 : 3.5,
                color: AppColors.gradientStart,
                strokeColor: AppColors.surfaceDark,
                strokeWidth: 2,
              );
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                AppColors.gradientStart.withValues(alpha: 0.3),
                AppColors.gradientStart.withValues(alpha: 0.0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
}
