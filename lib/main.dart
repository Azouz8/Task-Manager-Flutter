import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager/cubits/layout_cubit/layout_cubit.dart';
import 'package:task_manager/cubits/task_cubit/task_cubit.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/repos/task_repo.dart';
import 'package:task_manager/screens/layout_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(TaskStatusAdapter());
  Hive.registerAdapter(EisenhowerCategoryAdapter());

  await Hive.openBox<TaskModel>('tasks');
  final TaskRepository repository = TaskRepository();
  runApp(
    TaskManagerApp(
      repository: repository,
    ),
  );
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key, required this.repository});
  final TaskRepository repository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LayoutCubit(),
        ),
        BlocProvider(
          create: (context) => TaskCubit(repository),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LayoutScreen(),
      ),
    );
  }
}
