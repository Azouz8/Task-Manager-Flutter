import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/cubits/task_cubit/task_cubit.dart';
import 'package:task_manager/cubits/task_cubit/tast_states.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/widgets/task_form/home_category_selection.dart';
import 'package:task_manager/widgets/task_form/home_date_selection.dart';

class HomeTaskform extends StatelessWidget {
  HomeTaskform({super.key});

  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _detailsController = TextEditingController();
  DateTime? _selectedDate = DateTime.now().add(const Duration(days: 1));
  EisenhowerCategory _selectedCategory =
      EisenhowerCategory.notUrgentNotImportant;

  void selectCategory(EisenhowerCategory pickedCategory) {
    _selectedCategory = pickedCategory;
  }

  void selectDate(DateTime? pickedDate) {
    _selectedDate = pickedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Add New Task",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("TASK TITLE"),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required.";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Enter task designation...",
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text("DETAILS"),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _detailsController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required.";
                    }
                    return null;
                  },
                  minLines: 3,
                  maxLines: 6,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: "Record annotations...",
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                HomeCategorySelection(selectCategory: selectCategory),
                const SizedBox(
                  height: 30,
                ),
                HomeDateSelection(selectDate: selectDate),
                const SizedBox(
                  height: 30,
                ),
                BlocBuilder<TaskCubit, TaskStates>(
                  builder: (context, state) {
                    return SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: FilledButton.icon(
                        icon: const Icon(
                          Icons.save,
                          size: 24,
                        ),
                        style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<TaskCubit>().addTask(
                              TaskModel(
                                title: _titleController.text,
                                description: _detailsController.text,
                                date: _selectedDate!,
                                status: TaskStatus.todo,
                                category: _selectedCategory,
                              ),
                            );
                            _formKey.currentState!.reset();
                            Navigator.pop(context);
                          }
                        },
                        label: const Text(
                          "Save to Ledger",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
