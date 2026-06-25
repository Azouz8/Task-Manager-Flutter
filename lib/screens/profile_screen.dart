import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager/cubits/task_cubit/task_cubit.dart';
import 'package:task_manager/cubits/task_cubit/tast_states.dart';
import 'package:task_manager/models/task_model.dart';

// Theme Constants - Luminous Focus Design System
const Color _bgColor = Color(0xFF131313);
const Color _surfaceElevated = Color(0xFF363636);
const Color _primaryColor = Color(0xFFC1C1FF);
const Color _primaryContainer = Color(0xFF8687E7);
const Color _textPrimary = Color(0xFFFFFFFF);
const Color _textSecondary = Color(0xFFAFAFAF);
const Color _taskLow = Color(0xFF80FFA3);
const Color _taskMedium = Color(0xFFFFD070);
const Color _taskHigh = Color(0xFFFF8080);

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: _bgColor,
        elevation: 0,
        title: Row(
          children: [
            // Container(
            //   width: 40,
            //   height: 40,
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: _surfaceElevated,
            //   ),
            // child: const Icon(
            //   Icons.menu_book,
            //   color: _primaryColor,
            //   size: 20,
            // ),
            // ),
            const SizedBox(width: 12),
            Text(
              'Master Ledger',
              style: GoogleFonts.inter(
                color: _primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 16.0),
        //     child: IconButton(
        //       icon: const Icon(Icons.settings, color: _textSecondary),
        //       onPressed: () {},
        //     ),
        //   ),
        // ],
      ),
      // Automatically rebuilds whenever TaskCubit updates Hive data
      body: BlocBuilder<TaskCubit, TaskStates>(
        builder: (context, taskState) {
          // --- DATA EXTRACTION ---
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

          // --- RANK & LEVEL CALCULATIONS ---
          const int tasksPerLevel = 12;
          final int currentLevel = (conqueredCount ~/ tasksPerLevel) + 1;
          final int tasksIntoCurrentLevel = conqueredCount % tasksPerLevel;
          final int totalXP = conqueredCount * 100;
          final int xpForNextLevel = tasksPerLevel * 100;
          final double progressFraction = tasksIntoCurrentLevel / tasksPerLevel;

          // --- 7-DAY FOCUS CALCULATIONS ---
          final now = DateTime.now();
          final List<int> tasksPerDay = [];
          final List<String> dayLabels = [];

          for (int i = 6; i >= 0; i--) {
            final targetDate = now.subtract(Duration(days: i));
            dayLabels.add(_getWeekdayLabel(targetDate.weekday));

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

          // --- RECENT ARCHIVES ---
          final recentArchives = completedTasks.reversed.take(3).toList();

          // --- UI RENDERING ---
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildProfileHeader(conqueredCount),
                const SizedBox(height: 24),

                _buildCurrentRankCard(
                  level: currentLevel,
                  currentXP: totalXP,
                  xpForNextLevel: xpForNextLevel,
                  progress: progressFraction,
                ),
                const SizedBox(height: 16),

                _buildFocusChartCard(
                  dailyData: tasksPerDay,
                  labels: dayLabels,
                  peak: peak,
                ),
                const SizedBox(height: 16),

                _buildRecentArchivesSection(recentArchives),
                const SizedBox(height: 24),

                // Stats Section
                _buildStatsSection(
                  allTasks,
                  completedTasks,
                  todoTasks,
                  doingTasks,
                  overdueTasks,
                ),
                const SizedBox(height: 80), // Bottom padding for nav bar
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatsSection(
    List<TaskModel> allTasks,
    List<TaskModel> completedTasks,
    List<TaskModel> todoTasks,
    List<TaskModel> doingTasks,
    List<TaskModel> overdueTasks,
  ) {
    final totalTasks = allTasks.length;
    final completionRate = totalTasks > 0
        ? (completedTasks.length / totalTasks * 100).toStringAsFixed(1)
        : '0';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stats Header
        Text(
          'QUICK STATS',
          style: GoogleFonts.inter(
            color: _textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.05,
          ),
        ),
        const SizedBox(height: 12),

        // Summary Stats Row 1
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.check_circle,
                title: 'Completed',
                value: completedTasks.length.toString(),
                color: _taskLow,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                icon: Icons.pending_actions,
                title: 'Todo',
                value: todoTasks.length.toString(),
                color: _taskMedium,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Summary Stats Row 2
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.schedule,
                title: 'In Progress',
                value: doingTasks.length.toString(),
                color: _primaryColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                icon: Icons.error,
                title: 'Overdue',
                value: overdueTasks.length.toString(),
                color: _taskHigh,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Completion Rate Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _surfaceElevated,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF444444), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'COMPLETION RATE',
                style: GoogleFonts.inter(
                  color: _textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.05,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  '$completionRate%',
                  style: GoogleFonts.inter(
                    color: _primaryColor,
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: (double.parse(completionRate) / 100).clamp(0.0, 1.0),
                  minHeight: 8,
                  backgroundColor: const Color(0xFF2A2A2A),
                  valueColor: AlwaysStoppedAnimation<Color>(_primaryContainer),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Tasks by Category
        Text(
          'Tasks by Priority',
          style: GoogleFonts.inter(
            color: _textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        ..._buildCategoryStats(allTasks),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _surfaceElevated,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF444444), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.inter(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.inter(
              color: _textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCategoryStats(List<TaskModel> tasks) {
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
      _buildCategoryTile(
        label: 'Urgent & Important',
        count: urgentImportant,
        color: _taskHigh,
      ),
      _buildCategoryTile(
        label: 'Important',
        count: notUrgentImportant,
        color: _taskMedium,
      ),
      _buildCategoryTile(
        label: 'Urgent',
        count: urgentNotImportant,
        color: _primaryColor,
      ),
      _buildCategoryTile(
        label: 'Other',
        count: notUrgentNotImportant,
        color: _taskLow,
      ),
    ];
  }

  Widget _buildCategoryTile({
    required String label,
    required int count,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _surfaceElevated,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: _textPrimary,
              fontSize: 14,
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
              style: GoogleFonts.inter(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- HELPER METHODS ---

  String _getWeekdayLabel(int weekday) {
    switch (weekday) {
      case 1:
        return 'M';
      case 2:
        return 'T';
      case 3:
        return 'W';
      case 4:
        return 'T';
      case 5:
        return 'F';
      case 6:
        return 'S';
      case 7:
        return 'S';
      default:
        return '';
    }
  }

  // --- UI WIDGET COMPONENTS ---

  Widget _buildProfileHeader(int completedCount) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _primaryContainer,
                  width: 4,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/scholar_avatar.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: _surfaceElevated,
                    child: const Icon(
                      Icons.person,
                      size: 60,
                      color: _textSecondary,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _primaryContainer,
                border: Border.all(color: _bgColor, width: 3),
              ),
              child: const Icon(
                Icons.verified,
                color: Color(0xFF23217F),
                size: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Ziad Alaa',
          style: GoogleFonts.inter(
            color: _textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'MASTER SCHOLAR',
          style: GoogleFonts.inter(
            color: _primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.05,
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentRankCard({
    required int level,
    required int currentXP,
    required int xpForNextLevel,
    required double progress,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: _surfaceElevated,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF444444), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _primaryContainer,
            ),
            child: const Icon(
              Icons.military_tech,
              color: Color(0xFF23217F),
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
                      style: GoogleFonts.inter(
                        color: _textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '$currentXP / $xpForNextLevel XP',
                      style: GoogleFonts.inter(
                        color: _primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
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
                    backgroundColor: Color(0xFF2A2A2A),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _primaryContainer,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Level $level Scholar',
                  style: GoogleFonts.inter(
                    color: _textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFocusChartCard({
    required List<int> dailyData,
    required List<String> labels,
    required int peak,
  }) {
    final upwardTrend =
        dailyData.isNotEmpty && dailyData.last > (dailyData.first) ? '↑' : '↓';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: _surfaceElevated,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF444444), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '7-DAY FOCUS',
                style: GoogleFonts.inter(
                  color: _textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.05,
                ),
              ),
              Text(
                '$upwardTrend 12% vs last week',
                style: GoogleFonts.inter(
                  color: _taskLow,
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
                        color: isPeak ? _primaryContainer : Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      labels[index],
                      style: GoogleFonts.inter(
                        color: _textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
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

  Widget _buildRecentArchivesSection(List<TaskModel> recentTasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Archives',
              style: GoogleFonts.inter(
                color: _textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'View All',
                style: GoogleFonts.inter(
                  color: _primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (recentTasks.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              "No archives yet.",
              style: GoogleFonts.inter(
                color: _textSecondary,
                fontSize: 14,
              ),
            ),
          ),
        ...recentTasks.map(
          (task) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _ArchiveTile(
              taskName: task.title,
              completedTime: 'Completed ${_getTimeAgo(task.date)}',
              category: _getCategoryDisplayName(task.category),
            ),
          ),
        ),
      ],
    );
  }

  String _getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else {
      return 'Oct ${date.day}';
    }
  }

  String _getCategoryDisplayName(dynamic category) {
    final categoryStr = category.toString().split('.').last;
    switch (categoryStr) {
      case 'urgentImportant':
        return 'Work';
      case 'notUrgentImportant':
        return 'Personal';
      case 'urgentNotImportant':
        return 'Admin';
      case 'notUrgentNotImportant':
        return 'Research';
      default:
        return 'Other';
    }
  }
}

// --- REUSABLE WIDGETS ---

class _ArchiveTile extends StatelessWidget {
  final String taskName;
  final String completedTime;
  final String category;

  const _ArchiveTile({
    required this.taskName,
    required this.completedTime,
    required this.category,
  });

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'work':
        return _taskHigh;
      case 'personal':
        return _taskLow;
      case 'admin':
        return _taskMedium;
      case 'research':
        return _taskLow;
      default:
        return _primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryColor = _getCategoryColor(category);

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: _surfaceElevated,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: categoryColor, width: 4),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: _taskLow, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskName,
                  style: GoogleFonts.inter(
                    color: _textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  completedTime,
                  style: GoogleFonts.inter(
                    color: _textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
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
              style: GoogleFonts.inter(
                color: categoryColor,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
