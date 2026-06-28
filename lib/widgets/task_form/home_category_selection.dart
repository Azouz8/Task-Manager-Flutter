import 'package:flutter/material.dart';
import 'package:task_manager/models/task_model.dart';

class HomeCategorySelection extends StatefulWidget {
  const HomeCategorySelection({super.key, required this.selectCategory});

  final void Function(EisenhowerCategory pickedCategory) selectCategory;

  @override
  State<HomeCategorySelection> createState() {
    return _HomeCategorySelectionState();
  }
}

class _HomeCategorySelectionState extends State<HomeCategorySelection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("CATEGORY"),
        const SizedBox(
          height: 10,
        ),
        DropdownMenu(
          width: double.infinity,
          onSelected: (value) {
            widget.selectCategory(
              value ?? EisenhowerCategory.notUrgentNotImportant,
            );
          },
          hintText: "NOT urget NOT important",
          inputDecorationTheme: Theme.of(
            context,
          ).inputDecorationTheme,
          dropdownMenuEntries: [
            DropdownMenuEntry(
              value: EisenhowerCategory.notUrgentImportant,
              label: categoryMap[EisenhowerCategory.notUrgentImportant]!,
            ),
            DropdownMenuEntry(
              value: EisenhowerCategory.notUrgentNotImportant,
              label: categoryMap[EisenhowerCategory.notUrgentNotImportant]!,
            ),
            DropdownMenuEntry(
              value: EisenhowerCategory.urgentImportant,
              label: categoryMap[EisenhowerCategory.urgentImportant]!,
            ),
            DropdownMenuEntry(
              value: EisenhowerCategory.urgentNotImportant,
              label: categoryMap[EisenhowerCategory.urgentNotImportant]!,
            ),
          ],
        ),
      ],
    );
  }
}
