import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/app_formatter.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_section_header.dart';
import '../../domain/entities/covid_summary.dart';

class CaseDistributionChart extends StatefulWidget {
  final CovidSummary summary;

  const CaseDistributionChart({super.key, required this.summary});

  @override
  State<CaseDistributionChart> createState() => _CaseDistributionChartState();
}

class _CaseDistributionChartState extends State<CaseDistributionChart> {
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final sections = _buildSections();

    return AppCard(
      padding: const EdgeInsets.all(AppDimens.paddingLG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppSectionHeader(title: 'Case Distribution'),
          const SizedBox(height: AppDimens.paddingLG),

          Row(
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: PieChart(
                  PieChartData(
                    sections: sections,
                    centerSpaceRadius: 40,
                    sectionsSpace: 3,
                    pieTouchData: PieTouchData(
                      touchCallback: (event, response) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              response == null ||
                              response.touchedSection == null) {
                            _touchedIndex = -1;
                            return;
                          }
                          _touchedIndex =
                              response.touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppDimens.paddingLG),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _LegendItem(
                      color: AppColors.active,
                      label: 'Active',
                      value: AppFormatter.compact(widget.summary.active),
                      percent: AppFormatter.percent(
                        widget.summary.activePercent,
                      ),
                    ),
                    const SizedBox(height: AppDimens.paddingSM),
                    _LegendItem(
                      color: AppColors.recovered,
                      label: 'Recovered',
                      value: AppFormatter.compact(widget.summary.recovered),
                      percent: AppFormatter.percent(
                        widget.summary.recoveredPercent,
                      ),
                    ),
                    const SizedBox(height: AppDimens.paddingSM),
                    _LegendItem(
                      color: AppColors.deaths,
                      label: 'Deaths',
                      value: AppFormatter.compact(widget.summary.deaths),
                      percent: AppFormatter.percent(
                        widget.summary.deathsPercent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildSections() {
    final data = [
      (AppColors.active, widget.summary.active.toDouble()),
      (AppColors.recovered, widget.summary.recovered.toDouble()),
      (AppColors.deaths, widget.summary.deaths.toDouble()),
    ];

    return List.generate(data.length, (i) {
      final isTouched = i == _touchedIndex;
      final radius = isTouched ? 60.0 : 52.0;
      return PieChartSectionData(
        color: data[i].$1,
        value: data[i].$2,
        radius: radius,
        showTitle: false,
      );
    });
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final String value;
  final String percent;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.value,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: AppDimens.paddingSM),
            Expanded(child: Text(label, style: AppTextStyles.bodySmall)),
          ],
        ),
        const SizedBox(width: AppDimens.paddingSM),
        Row(
          children: [
            Text(
              '$value  ',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: AppDimens.paddingSM),
            Text(
              percent,
              style: AppTextStyles.bodySmall.copyWith(color: color),
            ),
          ],
        ),
      ],
    );
  }
}
