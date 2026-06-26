import 'package:flutter/material.dart';
import 'package:task_manager/models/task_model.dart';
import '../../theme/task_colors.dart';

import '../../utils/profile_helpers.dart';

class RecentArchivesSection extends StatelessWidget {
  final List<TaskModel> recentTasks;

  const RecentArchivesSection({super.key, required this.recentTasks});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); //[cite: 2]

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Archives',
              style: theme.textTheme.titleMedium, //[cite: 2]
            ),
            // TextButton(
            //   onPressed: () {},
            //   child: Text(
            //     'View All',
            //     style: theme.textTheme.displaySmall?.copyWith(
            //       //[cite: 2]
            //       color: theme.colorScheme.primaryContainer, //[cite: 2]
            //     ),
            //   ),
            // ),
          ],
        ),
        const SizedBox(height: 12),
        if (recentTasks.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              "No archives yet.",
              style: theme.textTheme.bodyMedium, //[cite: 2]
            ),
          ),
        ...recentTasks.map(
          (task) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _ArchiveTile(
              taskName: task.title,
              completedTime:
                  'Completed ${ProfileHelpers.getTimeAgo(task.date)}',
              category: ProfileHelpers.getCategoryDisplayName(task.category),
            ),
          ),
        ),
      ],
    );
  }
}

class _ArchiveTile extends StatelessWidget {
  final String taskName;
  final String completedTime;
  final String category;

  const _ArchiveTile({
    required this.taskName,
    required this.completedTime,
    required this.category,
  });

  Color _getCategoryColor(BuildContext context, String category) {
    switch (category.toLowerCase()) {
      case 'work':
        return high;
      case 'personal':
        return low;
      case 'admin':
        return medium;
      case 'research':
        return low;
      default:
        return Theme.of(context).colorScheme.primaryContainer; //[cite: 2]
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); //[cite: 2]
    final categoryColor = _getCategoryColor(context, category);

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: theme.cardColor, //[cite: 2]
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: categoryColor, width: 4),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: low, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskName,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    //[cite: 2]
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  completedTime,
                  style: theme.textTheme.bodySmall, //[cite: 2]
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: categoryColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              category,
              style: theme.textTheme.displaySmall?.copyWith(
                //[cite: 2]
                color: categoryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
