// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 0;

  @override
  TaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModel(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      date: fields[3] as DateTime,
      status: fields[4] as TaskStatus,
      category: fields[5] as EisenhowerCategory,
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TaskStatusAdapter extends TypeAdapter<TaskStatus> {
  @override
  final int typeId = 1;

  @override
  TaskStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskStatus.overdue;
      case 1:
        return TaskStatus.todo;
      case 2:
        return TaskStatus.doing;
      case 3:
        return TaskStatus.done;
      default:
        return TaskStatus.overdue;
    }
  }

  @override
  void write(BinaryWriter writer, TaskStatus obj) {
    switch (obj) {
      case TaskStatus.overdue:
        writer.writeByte(0);
        break;
      case TaskStatus.todo:
        writer.writeByte(1);
        break;
      case TaskStatus.doing:
        writer.writeByte(2);
        break;
      case TaskStatus.done:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EisenhowerCategoryAdapter extends TypeAdapter<EisenhowerCategory> {
  @override
  final int typeId = 2;

  @override
  EisenhowerCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return EisenhowerCategory.urgentImportant;
      case 1:
        return EisenhowerCategory.notUrgentImportant;
      case 2:
        return EisenhowerCategory.urgentNotImportant;
      case 3:
        return EisenhowerCategory.notUrgentNotImportant;
      default:
        return EisenhowerCategory.urgentImportant;
    }
  }

  @override
  void write(BinaryWriter writer, EisenhowerCategory obj) {
    switch (obj) {
      case EisenhowerCategory.urgentImportant:
        writer.writeByte(0);
        break;
      case EisenhowerCategory.notUrgentImportant:
        writer.writeByte(1);
        break;
      case EisenhowerCategory.urgentNotImportant:
        writer.writeByte(2);
        break;
      case EisenhowerCategory.notUrgentNotImportant:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EisenhowerCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
