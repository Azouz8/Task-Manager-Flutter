import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/widgets/matrix/matrix_quadrant.dart';
import 'package:task_manager/widgets/task_form/home_taskform.dart';

class MatrixScreen extends StatelessWidget {
  const MatrixScreen({super.key});

  void _openTaskForm(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return HomeTaskform();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final systemPadding = MediaQuery.of(context).padding;
    final availableHeight =
        size.height -
        kToolbarHeight -
        kBottomNavigationBarHeight -
        systemPadding.top -
        systemPadding.bottom;
    final targetItemHeight = (availableHeight - 32 - 10) / 2;
    final targetItemWidth = (size.width - 32 - 10) / 2;
    final exactAspectRatio = targetItemWidth / targetItemHeight;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 8,
        title: Text(
          "The Matrix",
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFC1C1FF),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openTaskForm(context);
        },
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: const Icon(Icons.add),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: exactAspectRatio,
        physics: const BouncingScrollPhysics(),
        children:  const [
          MatrixQuadrant(
            taskCategory: EisenhowerCategory.urgentImportant,
          ),
          MatrixQuadrant(
            taskCategory: EisenhowerCategory.notUrgentImportant,
          ),
          MatrixQuadrant(
            taskCategory: EisenhowerCategory.urgentNotImportant,
          ),
          MatrixQuadrant(
            taskCategory: EisenhowerCategory.notUrgentNotImportant,
          ),
        ],
      ),
    );
  }
}
