import 'package:flutter/material.dart';
import 'package:task_manager/models/task_model.dart';
import '../../theme/task_colors.dart';

class StatsSection extends StatelessWidget {
  final List<TaskModel> allTasks;
  final List<TaskModel> completedTasks;
  final List<TaskModel> todoTasks;
  final List<TaskModel> doingTasks;
  final List<TaskModel> overdueTasks;

  const StatsSection({
    super.key,
    required this.allTasks,
    required this.completedTasks,
    required this.todoTasks,
    required this.doingTasks,
    required this.overdueTasks,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); //[cite: 2]
    final totalTasks = allTasks.length;
    final completionRate = totalTasks > 0
        ? (completedTasks.length / totalTasks * 100).toStringAsFixed(1)
        : '0';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'QUICK STATS',
          style: theme.textTheme.displaySmall?.copyWith(
            //[cite: 2]
            fontSize: 11,
            letterSpacing: 0.05,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.check_circle,
                title: 'Completed',
                value: completedTasks.length.toString(),
                color: low,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                icon: Icons.pending_actions,
                title: 'Todo',
                value: todoTasks.length.toString(),
                color: medium,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.schedule,
                title: 'In Progress',
                value: doingTasks.length.toString(),
                color: theme.colorScheme.primaryContainer, //[cite: 2]
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                icon: Icons.error,
                title: 'Overdue',
                value: overdueTasks.length.toString(),
                color: high,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.cardColor, //[cite: 2]
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.dividerColor, width: 1), //[cite: 2]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'COMPLETION RATE',
                style: theme.textTheme.displaySmall?.copyWith(
                  //[cite: 2]
                  fontSize: 11,
                  letterSpacing: 0.05,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  '$completionRate%',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    //[cite: 2]
                    fontSize: 40,
                    color: theme.colorScheme.primaryContainer, //[cite: 2]
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: (double.parse(completionRate) / 100).clamp(0.0, 1.0),
                  minHeight: 8,
                  backgroundColor: theme.colorScheme.secondary, //[cite: 2]
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.primary,
                  ), //[cite: 2]
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Tasks by Priority',
          style: theme.textTheme.bodyLarge?.copyWith(
            //[cite: 2]
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        ..._buildCategoryStats(context, allTasks),
      ],
    );
  }

  List<Widget> _buildCategoryStats(
    BuildContext context,
    List<TaskModel> tasks,
  ) {
    final theme = Theme.of(context); //[cite: 2]

    final urgentImportant = tasks
        .where((t) => t.category.toString().contains('urgentImportant'))
        .length;
    final notUrgentImportant = tasks
        .where((t) => t.category.toString().contains('notUrgentImportant'))
        .length;
    final urgentNotImportant = tasks
        .where((t) => t.category.toString().contains('urgentNotImportant'))
        .length;
    final notUrgentNotImportant = tasks
        .where((t) => t.category.toString().contains('notUrgentNotImportant'))
        .length;

    return [
      _CategoryTile(
        label: 'Urgent & Important',
        count: urgentImportant,
        color: high,
      ),
      _CategoryTile(
        label: 'Important',
        count: notUrgentImportant,
        color: medium,
      ),
      _CategoryTile(
        label: 'Urgent',
        count: urgentNotImportant,
        color: theme.colorScheme.primaryContainer,
      ), //[cite: 2]
      _CategoryTile(
        label: 'Other',
        count: notUrgentNotImportant,
        color: low,
      ),
    ];
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); //[cite: 2]

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor, //[cite: 2]
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor, width: 1), //[cite: 2]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              //[cite: 2]
              color: color,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: theme.textTheme.displaySmall, //[cite: 2]
          ),
        ],
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _CategoryTile({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); //[cite: 2]

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor, //[cite: 2]
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              //[cite: 2]
              color: theme.colorScheme.onSurface, //[cite: 2]
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              count.toString(),
              style: theme.textTheme.bodyMedium?.copyWith(
                //[cite: 2]
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
