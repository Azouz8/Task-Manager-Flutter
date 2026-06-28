import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/cubits/task_cubit/task_cubit.dart';
import 'package:task_manager/models/task_model.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({super.key, required this.task});

  final TaskModel task;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool isDone;

  @override
  void initState() {
    super.initState();
    isDone = widget.task.status == TaskStatus.done;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isDone,
      onChanged: _onChanged,
      side: BorderSide(color: widget.task.category.color),
      activeColor: widget.task.category.color,
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  void _onChanged(bool? value) {
    setState(() {
      isDone = value ?? false;
    });
    context.read<TaskCubit>().updateTask(
      widget.task.copyWith(status: isDone ? TaskStatus.done : TaskStatus.todo),
    );
  }
}
