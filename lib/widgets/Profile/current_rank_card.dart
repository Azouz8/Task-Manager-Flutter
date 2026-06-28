import 'package:flutter/material.dart';

class CurrentRankCard extends StatelessWidget {
  final int level;
  final int currentXP;
  final int xpForNextLevel;
  final double progress;

  const CurrentRankCard({
    super.key,
    required this.level,
    required this.currentXP,
    required this.xpForNextLevel,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); //[cite: 2]

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.cardColor, //[cite: 2]
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor, width: 1), //[cite: 2]
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.primary, //[cite: 2]
            ),
            child: Icon(
              Icons.military_tech,
              color: theme.colorScheme.inversePrimary, //[cite: 2]
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Current Rank',
                      style: theme.textTheme.labelLarge, //[cite: 2]
                    ),
                    Text(
                      '$currentXP / $xpForNextLevel XP',
                      style: theme.textTheme.displaySmall?.copyWith(
                        //[cite: 2]
                        color: theme.colorScheme.primaryContainer, //[cite: 2]
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    minHeight: 6,
                    backgroundColor: theme.colorScheme.secondary, //[cite: 2]
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme.colorScheme.primary, //[cite: 2]
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Level $level Scholar',
                  style: theme.textTheme.displaySmall, //[cite: 2]
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
