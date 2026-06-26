import 'package:flutter/material.dart';
import 'package:task_manager/models/task_model.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(this.task, {super.key, required this.updateTask});

  final TaskModel task;
  final Future<void> Function(TaskModel task) updateTask;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: task.status == TaskStatus.done,
              onChanged: (_) async {
                final messenger = ScaffoldMessenger.of(context);
                final snackBarColor = Theme.of(context).cardColor;
                final undoColor = Theme.of(context).colorScheme.primary;

                final originalStatus = task.status;

                await updateTask(
                  task.copyWith(
                    id: task.id,
                    status: originalStatus == TaskStatus.done
                        ? TaskStatus.todo
                        : TaskStatus.done,
                  ),
                );

                messenger.clearSnackBars();

                messenger.showSnackBar(
                  SnackBar(
                    persist: false,
                    backgroundColor: snackBarColor,
                    duration: const Duration(seconds: 2),
                    content: const Text(
                      "Task status updated.",
                      style: TextStyle(color: Colors.white),
                    ),
                    action: SnackBarAction(
                      label: "Undo",
                      textColor: undoColor,
                      onPressed: () async {
                        await updateTask(
                          task.copyWith(
                            id: task.id,
                            status: originalStatus,
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    task.description,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: Color(0xFFC7C5D4),
                            size: 16,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            formatter.format(task.date),
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: categoryColors[task.category]?.withAlpha(80),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          categoryMap[task.category]!,
                          style: TextStyle(
                            color: categoryColors[task.category],
                            fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
