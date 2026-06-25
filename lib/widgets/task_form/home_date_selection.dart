import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class HomeDateSelection extends StatefulWidget {
  const HomeDateSelection({super.key, required this.selectDate});

  final void Function(DateTime? pickedDate) selectDate;

  @override
  State<HomeDateSelection> createState() {
    return _HomeDateSelectionState();
  }
}

class _HomeDateSelectionState extends State<HomeDateSelection> {
  DateTime? _selectedDate;

  void _showDatePicker(BuildContext context) async {
    final now = DateTime.now();
    final pickeddDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year, now.month + 2, now.day),
    );
    widget.selectDate(pickeddDate);
    setState(() {
      _selectedDate = pickeddDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("PICK DATE"),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 200,
          child: TextFormField(
            onTap: () {
              _showDatePicker(context);
            },
            readOnly: true,
            decoration: InputDecoration(
              hintText: _selectedDate == null
                  ? "mm/dd/yyyy"
                  : formatter.format(_selectedDate!),
              hintStyle: const TextStyle(color: Colors.white),
              suffixIcon: const Icon(Icons.calendar_month),
            ),
          ),
        ),
      ],
    );
  }
}
