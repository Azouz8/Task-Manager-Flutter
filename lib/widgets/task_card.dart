import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/cubits/task_cubit/task_cubit.dart';
import 'package:task_manager/models/task_model.dart';

class TaskCard extends StatefulWidget {
  const TaskCard(this.task, {super.key, required this.updateTask});

  final TaskModel task;
  final Future<void> Function(TaskModel task) updateTask;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _sizeAnimation;
  bool _isDisappearing = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _sizeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleStatusUpdate({
    TaskStatus? newStatus,
    required String message,
    bool isDelete = false,
  }) async {
    if (!mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    final taskCubit = context.read<TaskCubit>();
    final snackBarColor = Theme.of(context).cardColor;
    final undoColor = Theme.of(context).colorScheme.primary;
    final originalTask = widget.task;

    if (isDelete) {
      taskCubit.deleteTask(originalTask.id);
    } else if (newStatus != null) {
      await widget.updateTask(
        widget.task.copyWith(
          id: widget.task.id,
          status: newStatus,
        ),
      );
    }

    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        persist: false,
        behavior: SnackBarBehavior.floating,
        backgroundColor: snackBarColor,
        duration: const Duration(seconds: 2),
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        action: SnackBarAction(
          label: "Undo",
          textColor: undoColor,
          onPressed: () async {
            messenger.hideCurrentSnackBar();
            if (isDelete) {
              taskCubit.addTask(originalTask);
            } else if (newStatus != null) {
              await widget.updateTask(originalTask);
            }
          },
        ),
      ),
    );
  }

  Future<void> _handleCheckboxClick() async {
    if (_isDisappearing) return;

    setState(() {
      _isDisappearing = true;
    });
    await _animationController.forward();

    final newStatus = widget.task.status == TaskStatus.done
        ? TaskStatus.todo
        : TaskStatus.done;

    await _handleStatusUpdate(
      newStatus: newStatus,
      message: "Task Status Updated",
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: Tween<double>(begin: 1.0, end: 0.0).animate(_sizeAnimation),
      axisAlignment: -1.0,
      child: FadeTransition(
        opacity: Tween<double>(begin: 1.0, end: 0.0).animate(_sizeAnimation),
        child: Dismissible(
          key: Key(widget.task.id),
          direction:
              widget.task.status == TaskStatus.todo ||
                  widget.task.status == TaskStatus.overdue
              ? DismissDirection.horizontal
              : DismissDirection.endToStart,
          background: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 24),
            child: const Icon(
              Icons.double_arrow_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          secondaryBackground: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.red.shade400,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 24),
            child: const Icon(
              Icons.delete_outline,
              color: Colors.white,
              size: 28,
            ),
          ),
          onDismissed: (direction) {
            if (direction == DismissDirection.startToEnd) {
              _handleStatusUpdate(
                newStatus: TaskStatus.doing,
                message: "Task Moved To Doing",
              );
            } else if (direction == DismissDirection.endToStart) {
              _handleStatusUpdate(message: "Task deleted", isDelete: true);
            }
          },
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            color: Theme.of(context).cardColor,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    value: widget.task.status == TaskStatus.done,
                    onChanged: (_) => _handleCheckboxClick(),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.task.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.task.description,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(height: 16),
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
                                const SizedBox(width: 6),
                                Text(
                                  formatter.format(widget.task.date),
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displaySmall,
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: categoryColors[widget.task.category]
                                    ?.withAlpha(80),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                categoryMap[widget.task.category]!,
                                style: TextStyle(
                                  color: categoryColors[widget.task.category],
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
          ),
        ),
      ),
    );
  }
}
