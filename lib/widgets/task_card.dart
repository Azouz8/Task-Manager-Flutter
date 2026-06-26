import 'package:flutter/material.dart';
import 'package:task_manager/models/task_model.dart';

class TaskCard extends StatefulWidget {
  const TaskCard(this.task, {super.key, required this.updateTask});

  final TaskModel task;
  final Future<void> Function(TaskModel task) updateTask;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _sizeAnimation;
  bool _isDisappearing = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Animation duration
    );
    
    // Generates a smooth non-linear curve for the collapse
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

  Future<void> _handleStatusUpdate() async {
    if (_isDisappearing) return;

    setState(() {
      _isDisappearing = true;
    });

    // 1. Play the shrink animation forward (collapsing the card)
    await _animationController.forward();

    // 2. Capture layout values before changing state
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    final snackBarColor = Theme.of(context).cardColor;
    final undoColor = Theme.of(context).colorScheme.primary;
    final originalStatus = widget.task.status;

    // 3. Trigger backend/bloc state change after animation completes
    await widget.updateTask(
      widget.task.copyWith(
        id: widget.task.id,
        status: originalStatus == TaskStatus.done
            ? TaskStatus.todo
            : TaskStatus.done,
      ),
    );

    // 4. Show SnackBar with Undo functionality
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
            // If undone, the Bloc will put it back in the list naturally
            await widget.updateTask(
              widget.task.copyWith(
                id: widget.task.id,
                status: originalStatus,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: Tween<double>(begin: 1.0, end: 0.0).animate(_sizeAnimation),
      axisAlignment: -1.0,
      child: FadeTransition(
        opacity: Tween<double>(begin: 1.0, end: 0.0).animate(_sizeAnimation),
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
                  value: widget.task.status == TaskStatus.done,
                  onChanged: (_) => _handleStatusUpdate(), 
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.task.title,
                        style: const TextStyle(color: Colors.white, fontSize: 20),
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
                              color: categoryColors[widget.task.category]?.withAlpha(80),
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
    );
  }
}