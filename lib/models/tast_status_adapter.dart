import 'package:hive/hive.dart';
import 'package:task_manager/models/task_model.dart';

class TaskStatusAdapter extends TypeAdapter<TaskStatus> {
  @override
  final typeId = 1;

  @override
  TaskStatus read(BinaryReader reader) {
    return TaskStatus.values[reader.readInt()];
  }

  @override
  void write(BinaryWriter writer, TaskStatus obj) {
    writer.writeInt(obj.index);
  }
}
