import 'package:flutter/material.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/theme/app_colors.dart';

class HomeCategorySelection extends StatefulWidget {
  const HomeCategorySelection({
    super.key,
    required this.selectCategory,
  });

  final void Function(EisenhowerCategory pickedCategory) selectCategory;

  @override
  State<HomeCategorySelection> createState() => _HomeCategorySelectionState();
}

class _HomeCategorySelectionState extends State<HomeCategorySelection> {
  EisenhowerCategory _selectedCategory = EisenhowerCategory.notUrgentNotImportant;

  Color _getCategoryColor(EisenhowerCategory category) {
    switch (category) {
      case EisenhowerCategory.notUrgentImportant:
        return AppColors.notUrgentImportantTaskColor;
      case EisenhowerCategory.notUrgentNotImportant:
        return AppColors.notUrgentNotImportantTaskColor;
      case EisenhowerCategory.urgentImportant:
        return AppColors.urgentImportantTaskColor;
      case EisenhowerCategory.urgentNotImportant:
        return AppColors.urgentNotImportantTaskColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("CATEGORY"),
        const SizedBox(height: 10),
        Builder(
          builder: (context) => InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () async {
              FocusScope.of(context).unfocus();
              await Future.delayed(const Duration(milliseconds: 250));

              final RenderBox renderBox = context.findRenderObject() as RenderBox;
              final offset = renderBox.localToGlobal(Offset.zero);

              final selected = await showMenu<EisenhowerCategory>(
                context: context,
                color: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                position: RelativeRect.fromLTRB(
                  offset.dx,
                  offset.dy + renderBox.size.height + 8,
                  MediaQuery.of(context).size.width - offset.dx - renderBox.size.width,
                  0,
                ),
                items: EisenhowerCategory.values.map((category) {
                  return PopupMenuItem<EisenhowerCategory>(
                    value: category,
                    child: Text(
                      categoryMap[category]!,
                      style: TextStyle(
                        color: _getCategoryColor(category),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              );

              if (selected == null) return;
              FocusScope.of(context).requestFocus(FocusNode());
              setState(() => _selectedCategory = selected);
              widget.selectCategory(selected);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white38),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      categoryMap[_selectedCategory]!,
                      style: TextStyle(
                        color: _getCategoryColor(_selectedCategory),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, color: Colors.white54),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}