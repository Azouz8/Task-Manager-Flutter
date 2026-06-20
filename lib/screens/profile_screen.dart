import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager/cubits/task_cubit/task_cubit.dart';
import 'package:task_manager/cubits/task_cubit/tast_states.dart';
import 'package:task_manager/models/task_model.dart';

// Theme Constants
const Color _bgColor = Color(0xFFF6F4EE);
const Color _cardColor = Color(0xFFFCFBF8);
const Color _textColor = Color(0xFF3E2723);
const Color _accentColor = Color(0xFF4E342E);

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
            const Icon(Icons.menu_book, color: _textColor),
            const SizedBox(width: 8),
            Text(
              'Master Ledger',
              style: GoogleFonts.playfairDisplay(
                color: _textColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
      // Automatically rebuilds whenever TaskCubit updates Hive data
      body: BlocBuilder<TaskCubit, TaskStates>(
        builder: (context, taskState) {
          // -------------------------------------------------------------
          // 1. DATA EXTRACTION
          // -------------------------------------------------------------
          final allTasks = taskState.allTasks;

          // Note: Adjust 'TaskStatus.done' if your enum uses a different name
          final completedTasks = allTasks
              .where((t) => t.status == TaskStatus.done)
              .toList();
          final conqueredCount = completedTasks.length;

          // -------------------------------------------------------------
          // 2. RANK & LEVEL CALCULATIONS
          // -------------------------------------------------------------
          const int tasksPerLevel = 10;
          final int currentLevel = (conqueredCount ~/ tasksPerLevel) + 1;
          final int tasksIntoCurrentLevel = conqueredCount % tasksPerLevel;
          final int tasksUntilNext = tasksPerLevel - tasksIntoCurrentLevel;
          final double progressFraction = tasksIntoCurrentLevel / tasksPerLevel;

          // -------------------------------------------------------------
          // 3. 7-DAY FOCUS CALCULATIONS
          // -------------------------------------------------------------
          final now = DateTime.now();
          final List<int> tasksPerDay = [];
          final List<String> dayLabels = [];

          for (int i = 6; i >= 0; i--) {
            final targetDate = now.subtract(Duration(days: i));
            dayLabels.add(_getWeekdayLabel(targetDate.weekday));

            // Count completed tasks for this specific day
            // Note: Adjust 'task.date' to match your TaskModel's DateTime property
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
          final int lowest = tasksPerDay.isEmpty
              ? 0
              : tasksPerDay.reduce((a, b) => a < b ? a : b);

          // -------------------------------------------------------------
          // 4. RECENT ARCHIVES
          // -------------------------------------------------------------
          final recentArchives = completedTasks.reversed.take(3).toList();

          // -------------------------------------------------------------
          // 5. UI RENDERING
          // -------------------------------------------------------------
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildProfileHeader(),
                const SizedBox(height: 32),

                _buildCurrentRankCard(
                  level: currentLevel,
                  conquered: conqueredCount,
                  untilNext: tasksUntilNext,
                  progress: progressFraction,
                ),
                const SizedBox(height: 24),

                _buildFocusChartCard(
                  dailyData: tasksPerDay,
                  labels: dayLabels,
                  peak: peak,
                  lowest: lowest,
                ),
                const SizedBox(height: 24),

                _buildRecentArchivesSection(recentArchives),
                const SizedBox(height: 40), // Bottom padding
              ],
            ),
          );
        },
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

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            color: _cardColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(color: Colors.black.withOpacity(0.05), width: 1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(19),
            child: Image.asset(
              'assets/scholar_avatar.png', // Replace with your actual asset path
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.person,
                size: 50,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Ziad Alaa',
          style: GoogleFonts.playfairDisplay(
            color: _textColor,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Master Scholar',
          style: GoogleFonts.lato(
            color: _textColor.withOpacity(0.7),
            fontSize: 16,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentRankCard({
    required int level,
    required int conquered,
    required int untilNext,
    required double progress,
  }) {
    return _BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Rank',
            style: GoogleFonts.playfairDisplay(
              color: _textColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Divider(color: Colors.black12, height: 24),
          Center(
            child: Column(
              children: [
                const Icon(Icons.military_tech, size: 64, color: _accentColor),
                const SizedBox(height: 8),
                Text(
                  'Level $level Scholar',
                  style: GoogleFonts.lato(
                    color: _accentColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$conquered Tasks Conquered. $untilNext until next rank.',
                  style: GoogleFonts.lato(
                    color: _textColor.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),

                Stack(
                  children: [
                    Container(
                      height: 4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: progress.clamp(0.0, 1.0),
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: _accentColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ],
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
    required int lowest,
  }) {
    return _BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '7-Day Focus',
            style: GoogleFonts.playfairDisplay(
              color: _textColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Divider(color: Colors.black12, height: 24),

          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (index) {
                final double heightFactor = peak == 0
                    ? 0
                    : dailyData[index] / peak;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: 12,
                      height: 60 * heightFactor + 4,
                      decoration: BoxDecoration(
                        color: dailyData[index] == peak && peak > 0
                            ? _accentColor
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      labels[index],
                      style: GoogleFonts.lato(
                        color: _textColor.withOpacity(0.5),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),

          const Divider(color: Colors.black12, height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lowest: $lowest',
                style: GoogleFonts.lato(
                  fontSize: 12,
                  color: _textColor.withOpacity(0.7),
                ),
              ),
              Text(
                'Peak: $peak',
                style: GoogleFonts.lato(
                  fontSize: 12,
                  color: _textColor.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentArchivesSection(List<TaskModel> recentTasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Archives',
          style: GoogleFonts.playfairDisplay(
            color: _textColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        if (recentTasks.isEmpty)
          Text("No archives yet.", style: GoogleFonts.lato(color: Colors.grey)),

        ...recentTasks.map(
          (task) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            // Note: Adjust 'task.title' to match your TaskModel's title property
            child: _ArchiveTile(taskName: task.title),
          ),
        ),
      ],
    );
  }
}

// --- REUSABLE WIDGETS ---

class _BaseCard extends StatelessWidget {
  final Widget child;

  const _BaseCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _ArchiveTile extends StatelessWidget {
  final String taskName;

  const _ArchiveTile({required this.taskName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const Icon(Icons.check, size: 12, color: Colors.grey),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              taskName,
              style: GoogleFonts.lato(
                color: _textColor.withOpacity(0.6),
                fontSize: 15,
                decoration: TextDecoration.lineThrough,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
