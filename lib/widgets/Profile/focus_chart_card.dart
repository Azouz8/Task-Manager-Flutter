import 'package:flutter/material.dart';
import '../../theme/task_colors.dart';

class FocusChartCard extends StatelessWidget {
  final List<int> dailyData;
  final List<String> labels;
  final int peak;

  const FocusChartCard({
    super.key,
    required this.dailyData,
    required this.labels,
    required this.peak,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final upwardTrend =
        dailyData.isNotEmpty && dailyData.last > (dailyData.first) ? '↑' : '↓';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '7-DAY FOCUS',
                style: theme.textTheme.displaySmall?.copyWith(
                  fontSize: 11,
                  letterSpacing: 0.05,
                ),
              ),
              Text(
                '$upwardTrend 12% vs last week',
                style: theme.textTheme.displaySmall?.copyWith(
                  color: low,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (index) {
                final double heightFactor = peak == 0
                    ? 0
                    : dailyData[index] / peak;
                final bool isPeak = dailyData[index] == peak && peak > 0;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: 20,
                      height: 80 * heightFactor + 4,
                      decoration: BoxDecoration(
                        color: isPeak
                            ? theme.colorScheme.primary
                            : theme.colorScheme.secondary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      labels[index],
                      style: theme.textTheme.displaySmall,
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
