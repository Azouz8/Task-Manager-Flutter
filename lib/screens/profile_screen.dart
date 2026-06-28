import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/cubits/task_cubit/task_cubit.dart';
import 'package:task_manager/cubits/task_cubit/tast_states.dart';
import 'package:task_manager/models/task_model.dart';

import '../utils/profile_helpers.dart';
import '../widgets/Profile/index.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); //[cite: 2]

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, //[cite: 2]
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor, //[cite: 2]
        elevation: 0,
        title: Row(
          children: [
            const SizedBox(width: 12),
            Text(
              'Master Ledger',
              style: theme.textTheme.titleMedium?.copyWith(
                //[cite: 2]
                color: theme.colorScheme.primaryContainer, //[cite: 2]
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<TaskCubit, TaskStates>(
        builder: (context, taskState) {
          final allTasks = taskState.allTasks;
          final completedTasks = allTasks
              .where((t) => t.status == TaskStatus.done)
              .toList();
          final todoTasks = allTasks
              .where((t) => t.status == TaskStatus.todo)
              .toList();
          final doingTasks = allTasks
              .where((t) => t.status == TaskStatus.doing)
              .toList();
          final overdueTasks = allTasks
              .where((t) => t.status == TaskStatus.overdue)
              .toList();
          final conqueredCount = completedTasks.length;

          // Rank Calculations
          const int tasksPerLevel = 12;
          final int currentLevel = (conqueredCount ~/ tasksPerLevel) + 1;
          final int tasksIntoCurrentLevel = conqueredCount % tasksPerLevel;
          final int totalXP = conqueredCount * 100;
          final int xpForNextLevel = tasksPerLevel * 100;
          final double progressFraction = tasksIntoCurrentLevel / tasksPerLevel;

          // Focus Chart Calculations
          final now = DateTime.now();
          final List<int> tasksPerDay = [];
          final List<String> dayLabels = [];

          for (int i = 6; i >= 0; i--) {
            final targetDate = now.subtract(Duration(days: i));
            dayLabels.add(ProfileHelpers.getWeekdayLabel(targetDate.weekday));
            final countForDay = completedTasks.where((task) {
              return task.date.year == targetDate.year &&
                  task.date.month == targetDate.month &&
                  task.date.day == targetDate.day;
            }).length;
            tasksPerDay.add(countForDay);
          }

          final int peak = tasksPerDay.isEmpty
              ? 0
              : tasksPerDay.reduce((a, b) => a > b ? a : b);
          final recentArchives = completedTasks.reversed.take(3).toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfileHeader(completedCount: conqueredCount),
                const SizedBox(height: 24),
                CurrentRankCard(
                  level: currentLevel,
                  currentXP: totalXP,
                  xpForNextLevel: xpForNextLevel,
                  progress: progressFraction,
                ),
                const SizedBox(height: 16),
                FocusChartCard(
                  dailyData: tasksPerDay,
                  labels: dayLabels,
                  peak: peak,
                ),
                const SizedBox(height: 16),
                RecentArchivesSection(recentTasks: recentArchives),
                const SizedBox(height: 24),
                StatsSection(
                  allTasks: allTasks,
                  completedTasks: completedTasks,
                  todoTasks: todoTasks,
                  doingTasks: doingTasks,
                  overdueTasks: overdueTasks,
                ),
                const SizedBox(height: 80),
              ],
            ),
          );
        },
      ),
    );
  }
}
