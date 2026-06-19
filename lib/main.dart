import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/cubits/layout_cubit/layout_cubit.dart';
import 'package:task_manager/screens/layout_screen.dart';

void main() {
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LayoutScreen(),
      ),
    );
  }
}
