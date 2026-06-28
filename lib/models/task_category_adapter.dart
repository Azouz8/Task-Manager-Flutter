import 'package:hive/hive.dart';
import 'package:task_manager/models/task_model.dart';

class EisenhowerCategoryAdapter extends TypeAdapter<EisenhowerCategory> {
  @override
  final typeId = 2;

  @override
  EisenhowerCategory read(BinaryReader reader) {
    return EisenhowerCategory.values[reader.readInt()];
  }

  @override
  void write(BinaryWriter writer, EisenhowerCategory obj) {
    writer.writeInt(obj.index);
  }
}
