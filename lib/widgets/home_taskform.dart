import 'package:flutter/material.dart';

class HomeTaskform extends StatefulWidget {
  const HomeTaskform({super.key});

  @override
  State<HomeTaskform> createState() {
    return _HomeTaskFormState();
  }
}

class _HomeTaskFormState extends State<HomeTaskform> {
  final _formKey = GlobalKey<FormState>();

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("CATEGORY"),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownMenu(
                          hintText: "Medium",
                          inputDecorationTheme: Theme.of(
                            context,
                          ).inputDecorationTheme,
                          dropdownMenuEntries: const [
                            DropdownMenuEntry(value: "low", label: "Low"),
                            DropdownMenuEntry(value: "med", label: "Medium"),
                            DropdownMenuEntry(value: "high", label: "High"),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("PICK DATE"),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            readOnly: true,
                            decoration: const InputDecoration(
                              hintText: "mm/dd/yyyy",
                              hintStyle: TextStyle(color: Colors.white),
                              suffixIcon: Icon(Icons.calendar_month),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
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
                    onPressed: () {},
                    label: const Text(
                      "Save to Ledger",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
